Return-Path: <linux-kernel+bounces-153899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF4E8AD4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4991F224A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E5B155323;
	Mon, 22 Apr 2024 19:13:23 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43F154432;
	Mon, 22 Apr 2024 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813203; cv=none; b=Z2/DJkg0ur5NzNxt3lbQh0SnYsc18bdGYdiSWmH+BDt9UEVuGi34UiXH8YDgve+VpKVSdUxk5N75g2X8nZugfzkMZk1/Qm+msXFFmaXCVKWvtOw5jP/WcON+g9NavlDvDZ/N0THfAXzyS/iCu1LAqG9LdTuW+/VkLYZvB+TsCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813203; c=relaxed/simple;
	bh=n3vvI5G4jLdBOt6Q70+4BFyCFpg5vWoLy3HN5IdjI8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq5NPgzRpquX5L4mcSbtROVDRKu2UZYGJpPWPZ3BLhI/uGEUn7I6D3WTFLwYFzk11bJDeOTbbrBRK5oomXxXAvnGGyVpqn74/AKsxqkv914TT5g40mOUOA5KH7Xd2OAZ9OmZ4AhH6gpq57GQbFox1+KFOelO0IYAxBWS+6v7vlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-47a1a2c4c7cso708327137.2;
        Mon, 22 Apr 2024 12:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713813201; x=1714418001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3vvI5G4jLdBOt6Q70+4BFyCFpg5vWoLy3HN5IdjI8A=;
        b=erU26spRavHaTcSu3glp8TrTlowQt2+f6PBNB0EGoAryMi9hLItRBqaI6a9GHdOoV7
         Ya7ipKYSYin24A+cVCVzINXA+dRkZkPkVUkRnus66U69ny+lK7AxGRw3t+YTfJ33D+qG
         Zm2luALcxTPSIdtm7M7aYdEmCOWJ+OCZ2kHA9+KGixdZtIidMxcVFvrs9Ysr+QGzZYJE
         GCrI0uqmRkZFE1KryhcTcgecC3r0fv7b/78rQ/xfOgLtLjDnV4QLpTVKnxuR4m41KKtc
         V676yaEMINjs3IFf/HaT5Yzwmo+T1vyoFSJ/iXw6d2wAlfq88eNveJHczjexPTpasJxR
         6QaA==
X-Forwarded-Encrypted: i=1; AJvYcCVBhIhO3RudXUaGdUUFHqoLLk7jV/AbLrFY6bWaUhUXE5YdSqLkLZD3L1C0Nls0oXGEcoYmp6/ezR0ZpWLub0wLa971mGsvuR8lxHsZwKt3DsyseucS8E69kqPBbyY2eDG7upwiD8ejDKRc9TJasw==
X-Gm-Message-State: AOJu0YyPifj944jDGpP8zHx4vW4oduYCp+GGEumy8EYZheMuUz7QKapC
	rqqNwWIopXSMGT5FuzIOYx6jsxwMs+BL8oOoJq7rgVuAnvFIk/mBGTh7JFUyw3GHuRs0UsDp9NQ
	NxQjVSOSVXtJYit7DozxsjKcW6Vw=
X-Google-Smtp-Source: AGHT+IHzMoRwL7tNF4U0exFnj4qhqVFp1TwzqvLicf2SXHFukBKRhyno6rOPz7ISBXLkG5AzkXhuCswHl5LSR+mOW2A=
X-Received: by 2002:a67:efc3:0:b0:47b:9290:f903 with SMTP id
 s3-20020a67efc3000000b0047b9290f903mr7592305vsp.35.1713813200897; Mon, 22 Apr
 2024 12:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402214436.1409476-1-weilin.wang@intel.com> <20240402214436.1409476-2-weilin.wang@intel.com>
In-Reply-To: <20240402214436.1409476-2-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 22 Apr 2024 12:13:08 -0700
Message-ID: <CAM9d7chDxsiNNTPyrJA44miMh3DJRWemp_a03YFdE5bC_k1vGQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 1/6] perf stat: Parse and find tpebs events when
 parsing metrics to prepare for perf record sampling
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 2:45=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Metrics that use tpebs values would use the R as retire_latency modifier =
in

Can you please add this to documentation so that others can refer?
I'm not sure if we have a doc for the JSON metric format.

Thanks,
Namhyung


> formulas. We put all these events into a list and pass the list to perf
> record to collect their retire latency value.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

