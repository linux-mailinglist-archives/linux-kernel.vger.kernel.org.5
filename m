Return-Path: <linux-kernel+bounces-153957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28088AD54E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50531C2135D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9EC155391;
	Mon, 22 Apr 2024 19:55:18 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E7153837;
	Mon, 22 Apr 2024 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815717; cv=none; b=ZzKBtdeeuC2yWpP5+J4GpJT+P26DlPFc8GgldlPjj1P95+luKMK3Z2sCkfKjthQcUdgBJCDUOaAXjGtj2pasPQhg18OA654V2W4vMWwAl8lKwHzgNkNd0IyfPSk5IDtMufH8nBDBPHTujy/DApw4SGHRSoDIOGZhTjEQ5VosXZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815717; c=relaxed/simple;
	bh=dbUuQjU2jGCOnAG004o8j90d7W0DvjwGFjx2+mLeMFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NB4o+/JZ/Zyv5gAXJJCfolP46WnN+GhRdGPxdczEQSqXlvncbwIPRNirmntxQ2cQJKgGXfQ+XOolRRx/uQNjAPvWUQbb08hmV1SyAwk9kcDXzWP1vdQylNzbSayy2QksbzHKNZLsoCgG51pqx/33xiih0g9aKZjscoHZZ8dg72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ac9b225a91so2424607a91.2;
        Mon, 22 Apr 2024 12:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815716; x=1714420516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROr3UNU3503DzaF7LIBVFzJGvqS0DJu8N802BmfVcVQ=;
        b=MDsl0UF5rOcEOHyiQwZqpZt5viID8h3fmjTsWrmgE+aIv51mj2ayRgJGj+8B0oEMkv
         j/QrP0Tg4z3WCFlmkyt9n/vQhDxDespTp1C1HjbyXVDJO877f+7HI1CvNEDEVN5ACzKP
         vBLhaBIEqNN2X3/pUs8ytfu0XyvH+qLjNO5XLYDc+l5M6vo+haC+uGceYw7ITluHNSbP
         ufH5J1G6bC/1jifrDguqk+wJIJEK1hbzcep6TcbaaugBR2TAA7m4HGYPfobgvXcWMVO/
         gxFV9USeuj78uCCNIu7ZMAumN2q8GeMs9FrSP5R0cbulzP9oOTpPhK30McpSz1KCI0z6
         trgg==
X-Forwarded-Encrypted: i=1; AJvYcCUbu03YyLvhnaNzESDgdy1l304FqRSfs54fkmbgdhaJM9W/Hsmf5PpWTh8RYOrp270rDGFK/yW96EOu8MccQGaQZ/XgzgQejHAsK15tVzMOmUrb20/C+T4x8/6lZ/nQkkyTGuDQ5rZ4kgUG7XnXYg==
X-Gm-Message-State: AOJu0YyKvhFqCoF7ghU6MF72XiEaymoXyJTywNEu3e86lAhX3J7+sioc
	JgUkhxlGQk9WO5NEv56VROZIALWRzMasfZ8W/fqd6od8YXLiK3nmzCNFKkhEDwPfmOUIWZ++AGF
	T/boeMSZq3olnXbEJ+UBRYAuviFI=
X-Google-Smtp-Source: AGHT+IG6z15TUuvvPYi53KHEEF+i40ILOSTC+cq9bm+aAOEo4+1cXpj0Lhot9aVlAh+RMtD4ohsDA3wViKH6kMCw/r8=
X-Received: by 2002:a17:90b:24d:b0:2a7:7cae:8ec9 with SMTP id
 fz13-20020a17090b024d00b002a77cae8ec9mr8940854pjb.7.1713815715629; Mon, 22
 Apr 2024 12:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402214436.1409476-1-weilin.wang@intel.com> <20240402214436.1409476-6-weilin.wang@intel.com>
In-Reply-To: <20240402214436.1409476-6-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 22 Apr 2024 12:55:04 -0700
Message-ID: <CAM9d7ciKUYAdu97O3p5VRYGjXwvOv+4kgERXKM6mjr6OUbRQZA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/6] perf stat: Add retire latency print functions
 to print out at the very end of print out
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

On Tue, Apr 2, 2024 at 2:46=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add print out functions so that users could read retire latency values.
>
> Example output:
>
>  Performance counter stats for 'system wide':
>
>             25,717      MEM_INST_RETIRED.SPLIT_STORES    #      2.2 %  tm=
a_split_stores
>         28,365,080      CPU_CLK_UNHALTED.THREAD
>              24.00      MEM_INST_RETIRED.SPLIT_STORES:p  #       96      =
  4
>
>        2.054365083 seconds time elapsed
>
> This output of retire latency data is in format:
>  <val> <event-name> # <sum> <count>.

Nop, please follow the perf stat output format.  It'd be

  <sum> <event-name> # ...

Hmm.. maybe you don't need this at all as it'll have the event
anyway (probably without the 'p' modifier like in the example
above).

Then I think you can just add a metric value saying the average
latency in the comment area.

  Performance counter stats for 'system wide':

             25,717      MEM_INST_RETIRED.SPLIT_STORES    #      2.2 %
 tma_split_stores
                                                                     #
     24.0  average latency
       28,365,080      CPU_CLK_UNHALTED.THREAD

Thanks,
Namhyung

>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

