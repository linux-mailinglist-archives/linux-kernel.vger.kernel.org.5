Return-Path: <linux-kernel+bounces-19725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29868271F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6F6284405
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F52C47781;
	Mon,  8 Jan 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H95tkDiu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83A45C19
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704725709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ChSqd1/MKZYhZDgOOxzAxdhSiK525NwFpogR4BbTBeo=;
	b=H95tkDiu93IU8skEXs4er9/b8ApeJUqrDYMmlb4/rridtJuwV5I32tMAuHCvz5IgxNPXYx
	yx0mVCNJQN1PTzyexaeTRBmU0Hk6qZDAuz9zfDARyVuPbQdVwQcazQ6qbabvlO+7s1awPV
	s7dHSWfSn7JnJ2g54oeC/98wabcQLuQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Vbcmpqq9M0ymrJ8x8avBrw-1; Mon, 08 Jan 2024 09:55:07 -0500
X-MC-Unique: Vbcmpqq9M0ymrJ8x8avBrw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a22f129e5acso92640266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704725705; x=1705330505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChSqd1/MKZYhZDgOOxzAxdhSiK525NwFpogR4BbTBeo=;
        b=sgQQzPj78xKukqHwCesJqu8N4sbprOND3TmKgTbgxasYD3s8rDZwpI2pgwKq4c0tvt
         YQFBFRLiZVYAz38cZLozAj5EpvP7gGzoMmnkFv65o/Ios6XdscWZ97wCpJqUfj4ty4rc
         g2qKiVWJiDSKDwQ/YI2Ep2BjkvN0YpMtC7StHamFgfEcYt8Ya+x4kI+JaeUF2qA588HD
         /OAZweuTKGyNFjNek5aq64yVqgD6ndT+gdvl5thO9LKp42Yoai48lua1Yx6eSc1qHJpT
         jAyr1DagkwAZNGHivu71Ic2kjoO4xwn1S/+wwpKPXuqsafb1ZXngPq5XP2+b86KLpbIW
         Lj6w==
X-Gm-Message-State: AOJu0YyrzPZHfXyt6Trg2TLoPt8+h6+n40/g8cYqb5cq8TdxMMe2EQOp
	X27zLhgVe6IV/xeufD+lhbR3qAcJ6KpoRcEJwZxK+86eJJe7AQeFwtCAargVKrnxj45c9rFS+ib
	RXhPLHPB31N7wcSEoLwLD2ztRoCPrkXDCYS105Uak
X-Received: by 2002:a17:907:a0c:b0:a1c:e4e0:9d56 with SMTP id bb12-20020a1709070a0c00b00a1ce4e09d56mr2292574ejc.95.1704725705807;
        Mon, 08 Jan 2024 06:55:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKOmHDFV5+3W6eE/6oCuThAGo4GPzJQzvJNyhoAq6ukGw+DBZ2epFVHtK14Tc2GP/y8GSVcA==
X-Received: by 2002:a17:907:a0c:b0:a1c:e4e0:9d56 with SMTP id bb12-20020a1709070a0c00b00a1ce4e09d56mr2292564ejc.95.1704725705359;
        Mon, 08 Jan 2024 06:55:05 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id oq3-20020a170906cc8300b00a293c6cc184sm3788783ejb.24.2024.01.08.06.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 06:55:04 -0800 (PST)
Message-ID: <7625a697-cdbc-4787-b8c2-cb5d541c344c@redhat.com>
Date: Mon, 8 Jan 2024 15:55:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi: Fix wmi_dev_probe()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Armin Wolf <W_Armin@gmx.de>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <9c81251b-bc87-4ca3-bb86-843dc85e5145@moroto.mountain>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9c81251b-bc87-4ca3-bb86-843dc85e5145@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/5/24 14:47, Dan Carpenter wrote:
> This has a reversed if statement so it accidentally disables the wmi
> method before returning.
> 
> Fixes: 704af3a40747 ("platform/x86: wmi: Remove chardev interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans


> ---
>  drivers/platform/x86/wmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 157f1ce8ac0a..e6f6fa2fd080 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -868,7 +868,7 @@ static int wmi_dev_probe(struct device *dev)
>  	if (wdriver->probe) {
>  		ret = wdriver->probe(dev_to_wdev(dev),
>  				find_guid_context(wblock, wdriver));
> -		if (!ret) {
> +		if (ret) {
>  			if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
>  				dev_warn(dev, "Failed to disable device\n");
>  


