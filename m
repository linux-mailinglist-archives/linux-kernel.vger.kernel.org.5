Return-Path: <linux-kernel+bounces-61112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E76850D72
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1839B22B89
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B6AC12F;
	Mon, 12 Feb 2024 06:08:04 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3E8BFE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707718083; cv=none; b=DTt1sb1eFa1eJud+4Eiblbogcxl6k2Q49LM15BUpgjCgl2AL2y8ww58hkXW1O//CkbwOVolygltPeWflfYKeUiDwUPbT81iMl1A54lD2qfle5UzFGrO5gleF2xB4+hVdaCi+jJIssU8CjEP79cyON1aHJGOtwHbEvfIEo/5z3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707718083; c=relaxed/simple;
	bh=oy3gkwXSjXKA2Ayx2dhISZ86EWgTqhsy2HxNCU3pqAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKaUpH/EXCvtXljtXbL53npspD6IPtMEar7C6EvKWyNR5upC6vkZYZewi5ZOf7o3HmGXUl4tsdv9v8Qkahh2ZD6qK5H+a+jx3fR6PG7Fe/ReqQtL+6h2i9n/d0j3qqiZYaRZKYEaTeVyy2Jtqw36uh3bpbSC+FOcyhORmzptcEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso3962806a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 22:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707718080; x=1708322880;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MILP1dtOJICOj8/NSquH6W/spYpMBc6qdWLltCUs/0Y=;
        b=XzpjmcCCkyfa056ha2XUwq3I4AtIc/cjUzK63nEEhgMWkLRVMg7g3lXOVma6By12uq
         xQRWP2IcYBY1X4kcRJPrKPiYH/K4LETByW0J+alw4Djw8tG3o0FigVJNjyNRYlW04xQ7
         mZ6fSz8RFUhE4ISge1teLXywaH/R0XRR+UaByrtaRY5Cq3X/4jhjRTdLRgwkNU/8Uimj
         nt5uhwzbLSu8YgsV4ndJ+fMrn5Wnq2mDXaWp+ANKa/88e3lyN0ihHdOyycX0Xi3OYEA/
         tKpkNWYFCGYWVz5PEw585Mpk7Y9VtwpRiO0YKCz9PHJWvfRBdgepqXCVOBVYKH40E6XA
         bD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTh9fmsgx+8xISMy1f/922ZgRtikiqUX6262+gGD4lDWB2cPs/Hij8+zdaNSPIyRDkUudsiYPnutAb7UCEkyRiTfriKS8YKu8zNmgS
X-Gm-Message-State: AOJu0YwV2ba3C2pAza9+Vgwo/YNPDysUVSe6PVE0xa1USt4BtU8/KNUw
	HSw151YYAdcSAV/zy0r8ceN71oq7Y1f3M2Hcs6NtQ85NY3MhMQJO
X-Google-Smtp-Source: AGHT+IFCForocFWEda5Hr23AV8M7LiMDlqi/+DPJ4IY7p6su2vjUujSLGXfj2IR9nOuPgJ/jwtwphQ==
X-Received: by 2002:a17:906:f28c:b0:a3c:943d:7363 with SMTP id gu12-20020a170906f28c00b00a3c943d7363mr1190337ejb.11.1707718080169;
        Sun, 11 Feb 2024 22:08:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdiTMkqKb5RSCNsBha9XX9F00c48jVZDVEQe+5unQnhH1EryRoq9slb9SerfOsxiKmMcJRfvgRJ6/PVlN2gNwPyR9+zlr9E25ZzSM+efvCwoaJoOzqFikmIS1vbJKlgKjJshjrohiN8HgAX5CLZ3h5vZXnJu7Kou7Zr/CpdE7ZTmcrASTJ6waUnK2h49yy7kaWTmcTvHwLiN3MefeMxETciJeXYR2nElW6isGZ4sm1+uk7E8/g07wkSC2LrLybxaNKzvPrr9IX09/apB8A9IgOJD6bcSMQJbcGGfYoXwqTc7MGb6O3o70v+2+M1OUZinGhd43gnOJGx0rgdFqux+BGLOUIwNEIaPrEgwj2phAvxrNxUAvgW5f82XBFnP3HS9t2V3gVejcwtWeWOt/wiGi+tX/G
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id wt11-20020a170906ee8b00b00a389d911606sm3529612ejb.88.2024.02.11.22.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 22:07:59 -0800 (PST)
Message-ID: <360ef165-2ee3-4018-9b24-e77cd82f3417@kernel.org>
Date: Mon, 12 Feb 2024 07:07:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Subject: [PATCH] sound: drivers: fix typo 'reguest' to
 'request'
Content-Language: en-US
To: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, james.smart@broadcom.com,
 dick.kennedy@broadcom.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
References: <20240211182846.3608447-1-guoych37@mail2.sysu.edu.cn>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240211182846.3608447-1-guoych37@mail2.sysu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the subject is mangled.

On 11. 02. 24, 19:28, Yinchuan Guo wrote:
> This patch fixes a widespread spelling mistake of the word "request"
> (incorrectly spelled as "reguest") across multiple files.
> 
> Signed-off-by: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
> ---
>   drivers/mfd/da9063-irq.c      | 2 +-
>   drivers/scsi/lpfc/lpfc_sli.c  | 2 +-
>   drivers/tty/serial/max310x.c  | 2 +-
>   drivers/tty/serial/sccnxp.c   | 2 +-

These do not look like "sound". You should send/fix them separately.

>   sound/soc/codecs/rt274.c      | 2 +-
>   sound/soc/codecs/rt286.c      | 2 +-
>   sound/soc/codecs/rt298.c      | 2 +-
>   sound/soc/codecs/rt5514-spi.c | 2 +-
>   sound/soc/codecs/rt5640.c     | 2 +-
>   sound/soc/codecs/rt5645.c     | 2 +-
>   sound/soc/codecs/rt5651.c     | 2 +-
>   sound/soc/codecs/rt5659.c     | 2 +-
>   sound/soc/codecs/rt5663.c     | 2 +-
>   sound/soc/codecs/rt5665.c     | 2 +-
>   sound/soc/codecs/rt5668.c     | 2 +-
>   sound/soc/codecs/rt5682-i2c.c | 2 +-

thanks,
-- 
js
suse labs


