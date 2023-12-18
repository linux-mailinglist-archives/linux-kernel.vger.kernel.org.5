Return-Path: <linux-kernel+bounces-3801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6421B8171D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A9C1C24C15
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08A23A1B2;
	Mon, 18 Dec 2023 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6KTsVxN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB73A1B0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702908038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=801k8/cpcdJNojr//CVmwN6MefVG1M2oNgg9WBA1ID0=;
	b=L6KTsVxNMauOEH8ObwEhy+v+vFnuJuNL+ypl0yxVm8VUZrJ/evv6SBy+rfX5WBPVv7Ie39
	F378m1vjb/oBgCsgT3qtOnTs9i3d+paD5yBO4OfsdOIwCq7xIbQAa8jADOV537tHwrf2KP
	i18lqAkttWL1YH9a2KNCp1XS2kYa3o4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-Ptvz_gj-OB-61Q6mUWW5-A-1; Mon, 18 Dec 2023 09:00:34 -0500
X-MC-Unique: Ptvz_gj-OB-61Q6mUWW5-A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a22f129e5acso170914866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908033; x=1703512833;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=801k8/cpcdJNojr//CVmwN6MefVG1M2oNgg9WBA1ID0=;
        b=m4Oe8bxdSdj4C2Cmqfu1hPSh4f1siPocl77MU849S3KSHyXryAVFiPc5BSJQ4EU8Fe
         FdtjgSuZMxelEEKjN1BWkm0xNgVZeaeBOtXwzCIcAMr6gryt4qwpVPsq4TMGKiDtKoTq
         TomcVaU9asz9CcFNh9JmHdovwNGxuwfqKfP5bCfeizGjGUwiZBgYtnwWvYgd2Kx6gaq2
         tmkMHo84Ta6cdbSaLK4dbhQgUeazwpKPcaggTZ/uAsCV0TL6l6o7i64UvhEsjPgym3Bp
         Q2zVRZbqxF0ezkDanbcb52BPqE/wDj7UU9Dde3NawEok2vvNMe5hhwY5wS6QWuBe3Ecc
         TXQw==
X-Gm-Message-State: AOJu0YxmMNQVqrnW78u3rt8SJ8fTJENIcWj1uK+LLshwbnQOs7HUG/oZ
	j4ZyWDyPScE1PLxq5cmUC3SSPq292FL2hJ6sQObl3sWnCr3IN3amkq8ue8CpzFbwe/zbbl5ngNh
	TIsNh0vGs2qCMoo2O9kSCrC5B1ps6YRjw
X-Received: by 2002:a17:907:72c1:b0:a23:6462:4d66 with SMTP id du1-20020a17090772c100b00a2364624d66mr609513ejc.85.1702908033012;
        Mon, 18 Dec 2023 06:00:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9+GoUVX1KOJ9u+Z9HHUrJNCXqBOR7ke57fYj2st3f8W6rORSA+AVr3wXuR25QoUgRdzMQyA==
X-Received: by 2002:a17:907:72c1:b0:a23:6462:4d66 with SMTP id du1-20020a17090772c100b00a2364624d66mr609498ejc.85.1702908032679;
        Mon, 18 Dec 2023 06:00:32 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id cx7-20020a170907168700b009fc576e26e6sm14059747ejd.80.2023.12.18.06.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 06:00:31 -0800 (PST)
Message-ID: <9234691b-5667-4c6c-a1d0-0bea386cf31e@redhat.com>
Date: Mon, 18 Dec 2023 15:00:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86/intel/pmc: Fix in
 pmc_core_ssram_get_pmc()
Content-Language: en-US
To: rjingar <rajvi.jingar@linux.intel.com>, irenic.rajneesh@gmail.com,
 david.e.box@intel.com, ilpo.jarvinen@linux.intel.com, markgross@kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231216011702.1976408-1-rajvi.jingar@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231216011702.1976408-1-rajvi.jingar@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/16/23 02:17, rjingar wrote:
> From: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> 
> Passing PMC_IDX_MAIN in pmc_core_pmc_add() adds only primary pmc to pmcdev.
> Use pmc_idx instead to add all available pmcs.
> 
> Fixes: a01486dc4bb1 ("platform/x86/intel/pmc: Cleanup SSRAM discovery")
> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/intel/pmc/core_ssram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
> index 3501c7bd6b33..55e54207987c 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -287,7 +287,7 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
>  	if (!map)
>  		return -ENODEV;
>  
> -	return pmc_core_pmc_add(pmcdev, pwrm_base, map, PMC_IDX_MAIN);
> +	return pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
>  }
>  
>  int pmc_core_ssram_init(struct pmc_dev *pmcdev)


