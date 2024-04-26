Return-Path: <linux-kernel+bounces-160493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261688B3E36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CF2B2527F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3CE172BAD;
	Fri, 26 Apr 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="bw24h3lc"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC615FD01
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152496; cv=none; b=JSQ1AqGrvQLRWN+4GuJ4P+Y+CnugWKZYs/9OtLQ1ZDAW/3UYSoK38k10j+o2LmHYFJ8PwDPC02xCT71yt4o9+dB4L247NiP9AFjvXsF0fVcNFrZqRH4xgHJQ7VaI0tHCByQkJa931jGiD5166xUgzC9RvYCUEQGfKRylbgUQwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152496; c=relaxed/simple;
	bh=VGNC3FuUBoY4XLfaPkzu73wiRNiQjMii3/Pcgyeoeas=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Eguplfr3AaohfDmwXM7LKGykXk9jcLTOX4aNH/ddEqcdxPcsFiNV8k3M76FUFvo7iy6ZcNqJlSVctJE72N8ox0ZmVtFiEMQwyXGlwFO0qAaOZdhhI+JBzEZ+BOphIR5LIrSeJoLohy6WPAcztHJGKX40GsTywV6zQRXyXXrOvo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=bw24h3lc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so2333431b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1714152494; x=1714757294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVaQO4aOOoD5HFv/yuXIkEx3ckF+ESud5GzmK3URHMk=;
        b=bw24h3lc2dTa9Rt1uIh95D1cTFppfiSKMi11IXIzRCE9AInKdioU9mHMC/7WxNPhqD
         bX2PO4rM6IXBWqiFTBVQmhTWtGjsvzfF7KCPH8VrOB38nOduML9c43aVT7RXthR2ncUj
         l0b1VqmvkfuruELygOEDSzSsesVYc0yjtvPELqPl8DhM3UmWZXYJSj6T95ne4ooZL41a
         G0bUkr5EyCHbYuCKMV/bqkPMvu6Mi5lTiv7QcqlhdJLhzLsdF8znKanWmwovSNp3ajia
         JOpIF49TgX1OfSjxlv5UnyfZeaaCiWOUTvvA030cKWXh9hzhvw34CH+R0uKDELh75nlh
         Z1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152494; x=1714757294;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVaQO4aOOoD5HFv/yuXIkEx3ckF+ESud5GzmK3URHMk=;
        b=gkr8aPB88DXtmZOhgMN5lwLG8fyNh9X+fHQeNcmJZrut79szHRjs7RnoGYDFJkshjr
         gPMQGctMKAIbmcaG6rr1mT2RB3lFdgkoX4oN+KYThSwK9Z6bpHidZn5qmfpAnXfVesi0
         y643uYQcUvQs4BZgJJ9nH/UVwJ/4jSieIiH9hp8Sx+552fnlPpxLpARZSeL3keyEOL8k
         D3xt4iqkaJS35md+J7vykEo41topaXM4yMSxynKSHU0HieqwAr9kcdZ+M7AR0glzUNg3
         Uhz/ZGMbSHRKapIqxkkW8MyAvoezVTzAp8ZBmz1VHGB3E235btiuGVyTpvpow3o81+Cp
         E49w==
X-Forwarded-Encrypted: i=1; AJvYcCUnGv+3/9gDpxmUKSRRi8sjCtxcBFLxcVFuIo3c1UZQw2KBFqtFs4N/6VTkDEG/ZNvVsTXJ1/aFQ8xccQYlcx31hxjBbPlZosFKOTH9
X-Gm-Message-State: AOJu0YyoyreTNLPl8+XWNQ2Mk9BkxdQ480RpZmiLJAGJ48oDHFZVsWEA
	TenufbzLHG+taBfkTFFmyTHI0cNj2Y2pE+SRUqFggjbbG6kiPZREpWBX22pK2Gc=
X-Google-Smtp-Source: AGHT+IF5ZhmO7eX8nkSZYElD9vu5AkgvriEyIvfRabLVo+Eb+eHgs+Ia3e9odQQKRsC00z8QgP072g==
X-Received: by 2002:a05:6a20:43a9:b0:1aa:5b05:7926 with SMTP id i41-20020a056a2043a900b001aa5b057926mr4853573pzl.39.1714152493907;
        Fri, 26 Apr 2024 10:28:13 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id fm8-20020a056a002f8800b006ed059cdf02sm15099295pfb.116.2024.04.26.10.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:28:13 -0700 (PDT)
Date: Fri, 26 Apr 2024 10:28:13 -0700 (PDT)
X-Google-Original-Date: Fri, 26 Apr 2024 10:28:08 PDT (-0700)
Subject:     Re: [PATCH 1/2] perf daemon: Fix the warning about time_t
In-Reply-To: <20240305120501.1785084-2-ben717@andestech.com>
CC: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
  Mark Rutland <mark.rutland@arm.com>, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
  adrian.hunter@intel.com, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  dylan@andestech.com, tim609@andestech.com, ben717@andestech.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ben717@andestech.com
Message-ID: <mhng-8fa791ba-8c58-44c9-a4fd-f40ab808042b@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 05 Mar 2024 04:05:00 PST (-0800), ben717@andestech.com wrote:
> In the 32-bit platform, the size of time_t is still 64 bits. Thus, use
> PRIu64 to resolve the format problem.
>
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> ---
>  tools/perf/builtin-daemon.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 83954af36753..0b6ffd51c475 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -23,6 +23,7 @@
>  #include <sys/signalfd.h>
>  #include <sys/wait.h>
>  #include <poll.h>
> +#include <inttypes.h>
>  #include "builtin.h"
>  #include "perf.h"
>  #include "debug.h"
> @@ -688,7 +689,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
>  			/* lock */
>  			csv_sep, daemon->base, "lock");
>
> -		fprintf(out, "%c%lu",
> +		fprintf(out, "%c%" PRIu64 "",
>  			/* session up time */
>  			csv_sep, (curr - daemon->start) / 60);
>
> @@ -700,7 +701,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
>  				daemon->base, SESSION_OUTPUT);
>  			fprintf(out, "  lock:    %s/lock\n",
>  				daemon->base);
> -			fprintf(out, "  up:      %lu minutes\n",
> +			fprintf(out, "  up:      %" PRIu64 " minutes\n",
>  				(curr - daemon->start) / 60);
>  		}
>  	}
> @@ -727,7 +728,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
>  				/* session ack */
>  				csv_sep, session->base, SESSION_ACK);
>
> -			fprintf(out, "%c%lu",
> +			fprintf(out, "%c%" PRIu64 "",
>  				/* session up time */
>  				csv_sep, (curr - session->start) / 60);
>
> @@ -745,7 +746,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
>  				session->base, SESSION_CONTROL);
>  			fprintf(out, "  ack:     %s/%s\n",
>  				session->base, SESSION_ACK);
> -			fprintf(out, "  up:      %lu minutes\n",
> +			fprintf(out, "  up:      %" PRIu64 " minutes\n",
>  				(curr - session->start) / 60);
>  		}
>  	}

Sorry I missed this earlier, but IIUC this one is actually incorrect: on 
most 32-bit platforms time_t is 32 bits, it was later extended to 64 
bits.  RISC-V is special because the work to make time_t 64-bit had 
started when we submitted the port, so we just jumped straight to the 
legacy-free uABI (after some headaches).

So IIUC this would introduce a warning for some other targets.  Either 
way I shouldn't have picked it up as it's not a RISC-V patch (this is a 
generic perf file), so I'm going to drop it from fixes.

Sorry for the confusion!

