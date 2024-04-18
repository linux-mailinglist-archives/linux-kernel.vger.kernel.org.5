Return-Path: <linux-kernel+bounces-149708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D7C8A94D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99819281E20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579AA136E23;
	Thu, 18 Apr 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4RNxu/+"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCB75804;
	Thu, 18 Apr 2024 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428603; cv=none; b=V4NZt4dxYGOnGmUs4dPG6BXmI0hCcjSz39UXRyhyADH4dwdn2YTFpum/hc7m7fI8v4Hn/vXKjfcYivqMMUa0l1InYuShbzc7OvSe3ch/el7OVSRdVc57NDhz4jkjB9zpcnFs9mhOpKrWkKRatC0Ltn26nqUnPfNhn6H0wcfmO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428603; c=relaxed/simple;
	bh=TH3QyWiKd2juU+oSKxSy/lDwl1nklskSwO6+vNj1TYY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gMpqJMtWn9SDx0qTqS+4fzpWsPO7dgwtA7m9mpnoXpiCdupdgHeNpgZ7VrIq5Uee74xeS7pUDTtH8MPXJn0Q2mts9PBPEQ1omC9jFuW3YymYCoco+urFCEV+2YddDFhwAaQdeQXzdEQkGiOgGQA0umxnAhW1KqKd455iSCbFh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4RNxu/+; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-617e6c873f3so5603897b3.2;
        Thu, 18 Apr 2024 01:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713428601; x=1714033401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P6MwEhWs+WTqrRhQNWlJQgr1xPVQGum8AsCHKue2xE=;
        b=S4RNxu/+h3DUCdN95ZkDkTedYVh6PHPBJzyWlEtOf6a7BAS605Z/sjWOkrDcs4Rp3M
         T8CCkqplNVOhqyZGC6ctE84pA9vpa7z7tsVL8eqlLJPZy6BQKV5oVTz92dBAp/AOHeMN
         3vcczhktrJr+qjpK1Dwb39q9Wxh/zfTaeJR01HQC1HBeYwkvZsnwW9m8Me1oIS6fPosN
         lOfzdBIV+A/xbghwmnSGFBlkGu3r7sATTQvbCSJbQ/NsZ037mnSZ67s99KG+KwsbzyOb
         xWca+XiCeECmsgjjoJdsZAtAg6PU3dxTI1og3+r43qqoMg9xAgTCfJdVR/o3Za/hgoY4
         TdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713428601; x=1714033401;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6P6MwEhWs+WTqrRhQNWlJQgr1xPVQGum8AsCHKue2xE=;
        b=heUcxucQnbcOA7yH289hVzO1p+/w2ZwKVFZ2EA18c3Zo3AhdZxLWeu3Kf1wtTZE9vl
         mclVdFDF//BgcvnKE8s+g14GFo4P82FCxfOiTwAnuJM7EzbcBTcrSwfL5wzudH45L8rz
         eYs3w2kK8huBpBuvkny9wYolXo0KK1AcxW5povMv+ciMLQJ9ZXXE6EIROgX74ZE1ex7s
         8Ft2kLOn6D3+GD24ve8ziNuMx9tksmogLhp8Bw2clP9pGbVMmXdF/Apk/Lvy3V2gUrMh
         VEVNUSA5suFJalUm9ocnCch2RcWyseE5KS85gB7LXBrcYA+sNp30aQ4yiIaKtVsazPce
         Tpdw==
X-Forwarded-Encrypted: i=1; AJvYcCVkAWm2utBbvI0mwWZBasgcZVP/XdCum94oPMG74VumdnEe49uunl3x2UV/w6F30v6rDCWz7QrBsKcmUkNrWVSH5GmwlzrgvCE43ls921XhqC4UySUDYYs2Gfh3bWhghQQR2/UP1xEY
X-Gm-Message-State: AOJu0YxphYkBzwU+JyRGe8hdjrngj8u3EpqhhxozVgs5WEnGrJ5t0Ieo
	gM9A6GaHNKy3psYsu0yU+kuGnNXai3U/+p9VP0MOguufZi6zWmKk
X-Google-Smtp-Source: AGHT+IGpquJXXFyR2to9qlJmM8dB5OmlGcqWdrlZfDuV9d9lRI3/NN/rALPvsJHmJWO51OyqgI9VtA==
X-Received: by 2002:a05:690c:7089:b0:615:8c1:d7ec with SMTP id jg9-20020a05690c708900b0061508c1d7ecmr2054399ywb.33.1713428601174;
        Thu, 18 Apr 2024 01:23:21 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id s21-20020a632155000000b005cd8044c6fesm881273pgm.23.2024.04.18.01.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 01:23:20 -0700 (PDT)
Message-ID: <6875fb17-f781-4594-803a-c11969f36022@gmail.com>
Date: Thu, 18 Apr 2024 17:23:17 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bagasdotme@gmail.com
Cc: Naohiro.Aota@wdc.com, frederic@kernel.org, jiangshanlai@gmail.com,
 kent.overstreet@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
 tj@kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Akira Yokosawa <akiyks@gmail.com>
References: <20240418072100.30670-2-bagasdotme@gmail.com>
Subject: Re: [PATCH] Documentation: workqueue: Inline WQ_* flag pattern
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20240418072100.30670-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[+Cc: Jon]

On Thu, 18 Apr 2024 14:21:01 +0700, Bagas Sanjaya wrote:
> Sphinx reports htmldocs warning:
> 
> Documentation/core-api/workqueue:776: ./include/linux/workqueue.h:493: WARNING: Inline literal start-string without end-string.
> 
> The warning is caused by unescaped wildcard in the pattern that matches
> all workqueue flags (WQ_*). The pattern is rendered as normal text
> (with surrounding double backticks due to @argument syntax usage)
> instead of inline text like in individual flag names as a result.
> 
> Inline the pattern to fix the warning.
> 
> Fixes: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  include/linux/workqueue.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 158784dd189ab2..c9fec74e130459 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -463,7 +463,7 @@ void workqueue_softirq_dead(unsigned int cpu);
>  /**
>   * alloc_workqueue - allocate a workqueue
>   * @fmt: printf format for the name of the workqueue
> - * @flags: WQ_* flags
> + * @flags: ``WQ_*`` flags
>   * @max_active: max in-flight work items, 0 for default
>   * remaining args: args for @fmt
>   *
> @@ -490,7 +490,7 @@ void workqueue_softirq_dead(unsigned int cpu);
>   * min_active which is set to min(@max_active, %WQ_DFL_MIN_ACTIVE). This means
>   * that the sum of per-node max_active's may be larger than @max_active.
>   *
> - * For detailed information on %WQ_* flags, please refer to
> + * For detailed information on ``WQ_*`` flags, please refer to
>   * Documentation/core-api/workqueue.rst.
>   *
>   * RETURNS:

In my opinion, reST-specific clutters like these should be avoided in
kernel-doc comments as far as possible.

Instead, I think you can educate kernel-doc (script) so that "*" is
allowed in the %CONSTANT pattern, meaning %WQ_* can be converted
to ``WQ_*`` in reST.

For similar changes made against the @param pattern, see commits
69fc23efc7e5 ("kernel-doc: Add unary operator * to $type_param_ref")
and 8aaf297a0dd6 ("docs: scripts: kernel-doc: accept bitwise negation
like ~@var").

I guess it is $type_constant2 that needs a tweak in this case.

HTH,
Akira



