Return-Path: <linux-kernel+bounces-161815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B189D8B5196
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670661F219AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C871119F;
	Mon, 29 Apr 2024 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2nJFGMC"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E710A09;
	Mon, 29 Apr 2024 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372848; cv=none; b=kzE6QTsHgflVEz+wWQD9bnO2mJHLxD9yPtvcaFvTwDgR0dHTnKvj+lYzeNTQDJSK7XEs5wxhavA7uuDNebTXiNNncViqWK66/fzhSJoZ240CF5WV5aP9824m4LxS08O/eqdMIAWI/ARDHhXROyLFaULezZxebxOK/7yeulv6Sug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372848; c=relaxed/simple;
	bh=fgvAz0sLTTktebTn14gaVVatU6mFkIDYuROOi6e1HvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEUOrpAk5WTZUhCYAlOWtgBuBJpKKv22FiCwFOlGm/BIf9MYH2775L4qcJ5BWI2qR/uHsnKivogd3gyOQAFr8aYpcKJc+ss/gOgIwAtYOIDvBKh7uJ1i3w3Z7T4jvNeho9p/lnRU6X5xiYEsKLVrKAj5cG1iOeWbS8y9db6J4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2nJFGMC; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dd615b6c44so43351971fa.0;
        Sun, 28 Apr 2024 23:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714372844; x=1714977644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ySN0noyUH14atcen2ygoeKf0I5NwKf7EhALfl5OZZU=;
        b=F2nJFGMCTq2EE5tS2mgJ2H0mB/otH8KqS3dBVAIL8vqcsLRdwA6Otsy5mN/x84HJuG
         Afxf7rwEttY52y3ZVPOz0AqtJN8DRQxguTabcoMkYnPweKhyQA5PMlptZmXzIYPRi3f1
         h9M9CyRfIKBICzv4H8HiOmpukECEioIYQMtPZpLBquOKydLxfRqm1coSnhriDCAMRkAU
         iDvHTWqvksbnJzWEn2QUf+AsVq73Y9yc8x0wsbuNs4BEb8TXXEYuAr4UTIfeaPzDdpTS
         UrVw6f/sb4fqnHlQih7ILDw6pqm1aq3XvXfz4cZgfnTIseitJZGMJ/fvKc31TnKl7Auj
         BVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714372844; x=1714977644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ySN0noyUH14atcen2ygoeKf0I5NwKf7EhALfl5OZZU=;
        b=wrzSFGdbGkitKmLcRwZL4c1bJpFV/4PGkO14UHsz/R1QZ8hLjbKTiwPMPFEX37lGZb
         42UJ+CAmu+zVgpxNb2JKfZzKekWt771nv9bKDMInwRSFqPYMgcI+Qq25usgIYhCi0NiI
         wCCTQoGGfuR6eE78KUOhWGLtsxrADehrfnPi6Fy5d1BvDlmsFNXYZM+LNv0PPzozXOya
         mhCsxwuZeenkBRl0jcis4h+bvbgjLWQM5oUUFBmKYOWp6IAUOOxM9AB+a3u4g/AYAp/c
         z0TJl+VkYpWpUOCMIwlzSzNYhN0pCmyotZhHnFW1Vn530clTLP7im8/+HNVwiThHjTHe
         MNag==
X-Forwarded-Encrypted: i=1; AJvYcCW0sjZ9KzUegFFWay8BIuwqRCGp3dKmwu5iVdaCJwpQPRQ3yHmhmGkgKa2Xt60DC3NCc4fMjod7qhbQrwKBgn2ngxEZZa9heUBMi+JAYXWhp4LChxTPH62PBm2J5Q+U8+zJO84egXPA
X-Gm-Message-State: AOJu0YwuKfiYibiUwJJ7FZ0y+uH5ZvnMnXvvHHefLlSr5LLWBYKoBZW4
	qFQuC5KMWEE/5Oc79w+Hj793kI9/Uj1rP+vvhsHDg095Or5tYPJJ
X-Google-Smtp-Source: AGHT+IGccakOSvOuehrzUCUisMfZI7hs8SALqkXA/2RpJEU5gO4lg9UDYpmUo/aWKiMEMc1Yw+KpOQ==
X-Received: by 2002:a2e:a789:0:b0:2e0:9ab7:22af with SMTP id c9-20020a2ea789000000b002e09ab722afmr363960ljf.53.1714372844359;
        Sun, 28 Apr 2024 23:40:44 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id e20-20020a2e9e14000000b002df37b8e73bsm1094215ljk.37.2024.04.28.23.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 23:40:43 -0700 (PDT)
Message-ID: <142a905d-f0e8-487e-a8db-ee1ded6da21f@gmail.com>
Date: Mon, 29 Apr 2024 09:40:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Content-Language: en-US, en-GB
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chenyuan Yang <chenyuan0y@gmail.com>
References: <cover.1714371936.git.mazziesaccount@gmail.com>
 <3d98589455726e812cf2ad2610f7351ee2b93b07.1714371936.git.mazziesaccount@gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <3d98589455726e812cf2ad2610f7351ee2b93b07.1714371936.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 09:29, Chenyuan Yang wrote:
> The sorting in iio_gts_build_avail_time_table is not working as intended.
> It could result in an out-of-bounds access when the time is zero.
> 
> Here are more details:
> 
> 1. When the gts->itime_table[i].time_us is zero, e.g., the time
> sequence is `3, 0, 1`, the inner for-loop will not terminate and do
> out-of-bound writes. This is because once `times[j] > new`, the value
> `new` will be added in the current position and the `times[j]` will be
> moved to `j+1` position, which makes the if-condition always hold.
> Meanwhile, idx will be added one, making the loop keep running without
> termination and out-of-bound write.
> 2. If none of the gts->itime_table[i].time_us is zero, the elements
> will just be copied without being sorted as described in the comment
> "Sort times from all tables to one and remove duplicates".
> 
> For more details, please refer to
> https://lore.kernel.org/all/6dd0d822-046c-4dd2-9532-79d7ab96ec05@gmail.com.
> 
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> Co-developed-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Co-developed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com> 

Huh. I had never before sent a patch with co-authored tags. Just to 
ensure there is no misunderstandings - I did send this patch mail. I 
added the From: tag as was suggested in:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

I am afraid mutt picked the email sender from this tag - which does not 
fee like correct thing to do! Sorry! I did not intend to impersonate 
Chenyuan!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


