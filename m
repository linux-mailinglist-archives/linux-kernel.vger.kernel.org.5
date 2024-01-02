Return-Path: <linux-kernel+bounces-14338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A60821B95
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 961C9B21F09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE81BF4F2;
	Tue,  2 Jan 2024 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLuneGTl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E3FBE2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704198282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynRldBdu7XvN+37R2iLOqHGBvYJWx6ZuzNGYbUyEiJo=;
	b=OLuneGTlx4LwEBPDH8H8wnMlsX+PgfTaU8VH7tPvCcZHjClwEjV578bdM2/MgBdwoCuQHo
	8Dq+TG5O1u2SvR2vkm8TZABBlyO27Uu5INeYc4W2DT7gGXJXw83X2GeDWayJaimYkY/J3i
	UX/J8+qn1mEmD1sIFbsZu18RAoq/3fI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-m_M0MtzuMgWuOXYeNxkb3Q-1; Tue, 02 Jan 2024 07:24:41 -0500
X-MC-Unique: m_M0MtzuMgWuOXYeNxkb3Q-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-556415459d2so723264a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:24:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704198280; x=1704803080;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynRldBdu7XvN+37R2iLOqHGBvYJWx6ZuzNGYbUyEiJo=;
        b=lwI6TtFkBKX5ycGDWQAmDDb0oUDUow6TJBijc47Wx1U7C2xPUTe2dfMIgZ/atfET3S
         OqRW2ZxlxkAsCfdSF2eBscvnfdmVzdwrSzYYgowfXwRL6y3PLDsKp/j1NF46IcwWS6NQ
         hj9Plop9GYENFNIHGBN8Iue8CuFid+YUMRmE0i59Q7g7dQgnpZCpzO9CDQ+MqSUkHbeu
         raco6aXL/QFi3gHhypNYiYN7UKQbPSAtwUbpgwpE06SZJlne/4PLMOn+Y/PovWqIE2LZ
         aNfLjAHCJnxzpwfzOYhaY56j27xwYWO+l032/jgQjPoyQTtSUvj217XGwNmHU1yUYTJO
         AK1w==
X-Gm-Message-State: AOJu0YzZFKH6KPHSHNiDN4ZUuJ9fwbqDVYeGHkAWNtzaAsyjgpgNR0RF
	Z8RdKUlpvCqdxb2FYeef6X9b4bHBgvLjvnD4tQPAtwkkKwm9Wls/COGAIN8WGNSbBa/kIj0dpIJ
	0fVx/VV9qcxS1Hoqd6GfzzHvVOQBiL8CW
X-Received: by 2002:a50:cddb:0:b0:554:a397:4874 with SMTP id h27-20020a50cddb000000b00554a3974874mr6090060edj.37.1704198280147;
        Tue, 02 Jan 2024 04:24:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx0jkEaa5dMdTPdzDfdzXi5wRPOceZRJVFh7q5d+smrtsxOwV3C4wZrpbc904pM8jYgXCKxA==
X-Received: by 2002:a50:cddb:0:b0:554:a397:4874 with SMTP id h27-20020a50cddb000000b00554a3974874mr6090055edj.37.1704198279968;
        Tue, 02 Jan 2024 04:24:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ez9-20020a056402450900b0055504002a5fsm9824333edb.72.2024.01.02.04.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:24:39 -0800 (PST)
Message-ID: <1b86fa4f-d85a-4c48-9bc8-aafb4b7ec916@redhat.com>
Date: Tue, 2 Jan 2024 13:24:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] platform/x86/intel/pmc/arl: Add GBE LTR ignore during
 suspend
Content-Language: en-US, nl
To: "David E. Box" <david.e.box@linux.intel.com>,
 ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231223032548.1680738-1-david.e.box@linux.intel.com>
 <20231223032548.1680738-7-david.e.box@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231223032548.1680738-7-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/23/23 04:25, David E. Box wrote:
> Add the GBE LTR ignore suspend time fix for Arrow Lake.
> 
> Fixes: f34dcf397286 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

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
>  drivers/platform/x86/intel/pmc/arl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index 31e1fa538e32..ae3a9a96f845 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -685,6 +685,8 @@ void arl_d3_fixup(void)
>  int arl_resume(struct pmc_dev *pmcdev)
>  {
>  	arl_d3_fixup();
> +	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> +
>  	return pmc_core_resume_common(pmcdev);
>  }
>  
> @@ -696,6 +698,7 @@ int arl_core_init(struct pmc_dev *pmcdev)
>  	bool ssram_init = true;
>  
>  	arl_d3_fixup();
> +	pmcdev->suspend = cnl_suspend;
>  	pmcdev->resume = arl_resume;
>  	pmcdev->regmap_list = arl_pmc_info_list;
>  


