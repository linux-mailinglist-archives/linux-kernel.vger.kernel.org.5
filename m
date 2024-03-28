Return-Path: <linux-kernel+bounces-123267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B268905A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF6E1F254B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEBF1369AE;
	Thu, 28 Mar 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="M5G0B3zZ"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29B135A4D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643807; cv=none; b=F+S3SCNRiL/vbtx/aFjGAtOBERSG1/DC2lugevkOf/kK8OX+UmairQW5wiJbQbTDB0Jy0PkPVB9zHSD40tZ5YvWAvJgEv04kXmNhHQR2K6wZz7FmEGlauc1Le0SbKkPjVcdAXxm0WXftlAvFHvL+MOEOVZiqzedh2+CaY4qIaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643807; c=relaxed/simple;
	bh=cEtyH6tzCXZpqAEUrIjkkPnv3RHdmfl3sgSQefQ/eQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0wgQILh/DTuTz5rBthDdehZllhWMl9Qkf4f9wVSSZKLr+hhY3lYrNFcoLAaBKaAhwP5s/NFTsqVstf8wn89gUhvUMmo1vuitK+juC24CR40oMkcz/Suz4117PoVR5oU+R9vKgIz7/T/MnSYnk6nGQ87InMVpqSMBVBaWu/K4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M5G0B3zZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-431347c6c99so3841cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711643805; x=1712248605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyYiyB+19yl+3Mab3HR7ROG9FFYrqYxnBsEAwzAS+Xg=;
        b=M5G0B3zZED1wx3GFt33wAVHvNh4RNTYQOZuS48LLzu8pSwMuOI5/G0isI+Ae2s7uJ3
         UmboGTHEcmDqnRtoSRTH+5y6uta5PkSCT9mSySCfBbMfP5+kkNFoQBqmxG2y5AY7ZxFo
         zr1ZPrZdhYGMNVidzVe30QaCcA1N7Ff10Fd4hLQJ+9JSAkZJRt1kd74G3dGMKuYM6uL5
         QyyiT/ziN3TLDKry4BO1ISeizz8JY82OMAEXIMC4Q1Olm3nyIY037ixWZTXPmg97TQj6
         v/DAC1fZrtVx1aJraZN9YlbQX5tKFe6T5mrGzzcIwqV2egJ7dyIkjOKn/ZHpEEqi8WIL
         JFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711643805; x=1712248605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyYiyB+19yl+3Mab3HR7ROG9FFYrqYxnBsEAwzAS+Xg=;
        b=BLkeOVF/gH1UuAHaZFrjQ25oIwWYdHZ6yKZ97TBlfjMbIDmlDhG9gXPnRoQg9BLc4m
         8mMrnBJ9Tto0mWtOWTVbBMvHhFPcUi0npI5awk1X7S+UzPrsc5BUTqpUUQtmRS7kzKDo
         LUqxfHP81RdBQa0OPDitzeXdTqJWi29fbi2+lKd8KYU68xMO3G/jeiBnbyixuUsUKtSQ
         5vQGuPRM9vEQsZJZf2ZKFfY7q+5g+xKmWI8wJNte7EZEuTM7p1PzOpw4U8U0j70NMJkm
         92U60t47+vgOpDB7bo2S49pzWzhw3GcjVfqVNR3r9yg+s7jNhZloCJh8qWho52FiIeKq
         e1Cw==
X-Forwarded-Encrypted: i=1; AJvYcCURDVQB6K3hv8Jcr4/A5t60BkAs2BvlK8vZde61dt0nO+A/kffJtK8J1LN4emwlaxb/rr3Gukr9GtyIGdxBzwk5CONmtR6NMV8/uGp4
X-Gm-Message-State: AOJu0Yx98Pnd8RHRSvNQ/UJegMSy/CmLadKO+LwBtPSYd+0y445WN42v
	t+bFXmClZwuc+MPwyspXosXo235YLB1phR3NbVsnRRskmTL14U9vJ6mjOJKEbUoTFyKmT2m8SNd
	vnSrZ0Ozs3pFThCgWODjk3kKsH05UEFByKn71Lc68vP9Ta5bcx2MD
X-Google-Smtp-Source: AGHT+IHlZ9eO6WHEgYjS5TA/7zKzm6r7go+pnsDTXXfO5LZSesL0xptxLsIlxVDFf0RndXT9MS/+lYUHPWVESSFQ2iE=
X-Received: by 2002:a05:622a:6182:b0:432:b6a9:9015 with SMTP id
 hh2-20020a05622a618200b00432b6a99015mr182897qtb.2.1711643804568; Thu, 28 Mar
 2024 09:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326202859.960577-1-weilin.wang@intel.com>
In-Reply-To: <20240326202859.960577-1-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 28 Mar 2024 09:36:30 -0700
Message-ID: <CAP-5=fVAKRa7LsvyuNhjQpQuQyY5hvQ7yBnaWjeAJFYtS648Xg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/6] TPEBS counting mode support
To: weilin.wang@intel.com, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 1:29=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Changes in v5:
> - Update code and add comments for better code quality [Ian]
>
> v4: https://lore.kernel.org/all/20240312234921.812685-1-weilin.wang@intel=
com/
>
> Weilin Wang (6):
>   perf stat: Parse and find tpebs events when parsing metrics to prepare
>     for perf record sampling
>   perf stat: Fork and launch perf record when perf stat needs to get
>     retire latency value for a metric.
>   perf stat: Add retire latency values into the expr_parse_ctx to
>     prepare for final metric calculation
>   perf stat: Create another thread for sample data processing
>   perf stat: Add retire latency print functions to print out at the very
>     end of print out
>   perf vendor events intel: Add MTL metric json files
>
>  tools/perf/builtin-stat.c                     |  211 +-
>  .../arch/x86/meteorlake/metricgroups.json     |  127 +
>  .../arch/x86/meteorlake/mtl-metrics.json      | 2551 +++++++++++++++++
>  tools/perf/util/data.c                        |    3 +
>  tools/perf/util/data.h                        |    5 +
>  tools/perf/util/metricgroup.c                 |   88 +-
>  tools/perf/util/metricgroup.h                 |   22 +-
>  tools/perf/util/stat-display.c                |   65 +
>  tools/perf/util/stat-shadow.c                 |   19 +
>  tools/perf/util/stat.h                        |    4 +
>  10 files changed, 3076 insertions(+), 19 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroup=
s.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics=
json

Thanks Weilin,

I'm happy with this series, my Reviewed-by is on all the patches.
Arnaldo/Namhyung, could we land this for the sake of Meteorlake metric
enablement? For the sake of tools, for the series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> --
> 2.43.0
>

