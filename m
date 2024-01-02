Return-Path: <linux-kernel+bounces-14339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62622821B97
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A311F2297B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F0F9DE;
	Tue,  2 Jan 2024 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtZpriSO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E7F9C8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704198292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6655Tv9XjBGhS9DXEttOl8CnLCPz5cyQFf0210k2yCI=;
	b=FtZpriSOkzspdvdVWWydDqM6WCf8bhlh0OYAGRxtu80sBPC9G23KPYF7ZiZ390K4S6NGav
	nYwYJgHMr9H06oLgqPpfKwaMRUwW4PEBBuVKOHnxD2WxkRm5XRWBG6blI4TmGJ3wxzPfqw
	EAxLmHglI5pmQAFOsExfAO+TCarLxEY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16--lOW0opZOuejpRC1sWuWEg-1; Tue, 02 Jan 2024 07:24:50 -0500
X-MC-Unique: -lOW0opZOuejpRC1sWuWEg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-555f8e831f2so967910a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704198290; x=1704803090;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6655Tv9XjBGhS9DXEttOl8CnLCPz5cyQFf0210k2yCI=;
        b=EpEnDkg7ON9yyzMmFyIb2Ph4aYIhcYQ7zDgcEKyI/7Zyw2i1Ndi9zC3N/lcg1u6e5p
         YK6GfX5ykwF/RPpb1zIHPmMZA8UbQUmozbnVCh4A/4118t6SnabYa9vkj8JrePSDrsBH
         MfM6ynZJSqR7MbJUH0xy+Zz86/c/hTaBt5iPu8aI+MvumelNqRoMGeWxMdlsZmRuQUWj
         mLuymA0ILKB4x/TouZ9M8OBKT74wmargKQ0SBElcTsUNvyiyIbSyNLtP66xh8gzcLImN
         mMU9m+BoLiGt2H3yugZb9Ey3dqOPANSiwinsfP4T9h16Dx0NgU34Y3nGbo/32czx+W/+
         +F5A==
X-Gm-Message-State: AOJu0YzbRV8B6bRU9UKMWBf0xjmULO4XXLWN5zcbV2FkAmDn7UDIofS1
	SVxZ/VGQoEpdAk5RFJAfAgoFh9dctGsigNqAuauRqpAwRrCTFd7sM41n5w4ZiftVHY4tdUyEApY
	ssNH221YZv1MV45s/xuCmI4HOmXPZyAIk
X-Received: by 2002:a50:8d5a:0:b0:555:b361:4791 with SMTP id t26-20020a508d5a000000b00555b3614791mr3889737edt.60.1704198289840;
        Tue, 02 Jan 2024 04:24:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu9SF4DwjkuHhoZe1M08XYd+4w04WNbneSoYdb2Gxd7V0xGl475nn+pKKufYBWwow+mMWP0A==
X-Received: by 2002:a50:8d5a:0:b0:555:b361:4791 with SMTP id t26-20020a508d5a000000b00555b3614791mr3889731edt.60.1704198289644;
        Tue, 02 Jan 2024 04:24:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ez9-20020a056402450900b0055504002a5fsm9824333edb.72.2024.01.02.04.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:24:49 -0800 (PST)
Message-ID: <bde7b0ec-9156-4a50-b7c6-16e0adc01fdb@redhat.com>
Date: Tue, 2 Jan 2024 13:24:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] platform/x86/intel/pmc/lnl: Add GBE LTR ignore during
 suspend
Content-Language: en-US, nl
To: "David E. Box" <david.e.box@linux.intel.com>,
 ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231223032548.1680738-1-david.e.box@linux.intel.com>
 <20231223032548.1680738-8-david.e.box@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231223032548.1680738-8-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/23/23 04:25, David E. Box wrote:
> Add the GBE LTR ignore suspend time fix for Lunar Lake.
> 
> Fixes: 119652b855e6 ("platform/x86/intel/pmc: Add Lunar Lake M support to intel_pmc_core driver")
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
>  drivers/platform/x86/intel/pmc/lnl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
> index fe97ad09a1a6..eb350d64efdf 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -509,6 +509,8 @@ void lnl_d3_fixup(void)
>  int lnl_resume(struct pmc_dev *pmcdev)
>  {
>  	lnl_d3_fixup();
> +	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> +
>  	return pmc_core_resume_common(pmcdev);
>  }
>  
> @@ -521,6 +523,7 @@ int lnl_core_init(struct pmc_dev *pmcdev)
>  
>  	lnl_d3_fixup();
>  
> +	pmcdev->suspend = cnl_suspend;
>  	pmcdev->resume = lnl_resume;
>  	pmcdev->regmap_list = lnl_pmc_info_list;
>  	ret = pmc_core_ssram_init(pmcdev, func);


