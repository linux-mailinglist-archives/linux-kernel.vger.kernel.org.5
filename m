Return-Path: <linux-kernel+bounces-14344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90093821BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFC61F210D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6EBFBE1;
	Tue,  2 Jan 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJgMbwiw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4037AF9E6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704198678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pXm1eo2+cSSlRCUx7/WK9p72yxfZPBKBwAhmbPJUMo=;
	b=ZJgMbwiwzYaqmDId4sEwhwIXsPt/MRZ8Tl/TXPRhJhFQ3r/xVCr8eYHaNeFqnGgL4L3IaY
	drl5/OQaB19Re2A0XBFrPWOQ9QjVdMJgNt7ixHrsa0MD8DqxecDBqUpaBNvaJtSVDOs942
	V6AWp1NOU0cBlEnt/URL+F2C8QoqiRw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-cI-2yqs1PzuesBmpV0-kTw-1; Tue, 02 Jan 2024 07:31:15 -0500
X-MC-Unique: cI-2yqs1PzuesBmpV0-kTw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a23365478e5so508925666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704198674; x=1704803474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pXm1eo2+cSSlRCUx7/WK9p72yxfZPBKBwAhmbPJUMo=;
        b=Ko/sEeN4Bm7fWKp7Tabm5IswKGpWFD1L8ftF+wc0DmjIC5Tq43xKNzeChldLWhtPrF
         XvXgItGN0e2nwQkov3SRGF6EzF0Ab2wMYbyOQCTT7BteqlMohPZReriZF0TdbE/2tlUn
         FiTSbPg/lTTpJV/HhztiRaRJl1BV0MPkaHbSz4dGolstEOhzkbcKYllTa4bkUEbrg2aD
         STjVyv+ddHanJqleVfxmEPFYVc/Mlk2B36s+93AZoXO75N3iC0hS8R/iHES2Kr6nBL7m
         5EWiD7DdH1vSJW8dXp/11/hJVnknadZfQelvWFQJePBaGCNiN6Vf4ifWmVlak8jitPxD
         KIAg==
X-Gm-Message-State: AOJu0YxoYOKCWe+2iL8kG2PeAOXP+QQgkovRH7XxiiaA0I9VLep35jQx
	K38SGGVPF9XXe3CFEktD41Iyb06SyJvHSg2Vcr2cTNRBPOFGfi4Qc3yTH+z7U0T8yQsRLknBFwy
	oGZvExHO8y7CYw288DPDw7Tq9MtV+O5kDJdmRwXls
X-Received: by 2002:a17:906:dffa:b0:a23:2762:e48b with SMTP id lc26-20020a170906dffa00b00a232762e48bmr7639238ejc.63.1704198674254;
        Tue, 02 Jan 2024 04:31:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQhmw/eDGvMUU+jSkGHAZ4e48rrwX5KtU/Tq6ha27grzHEuI2uh2bIV/ZGDpq8JjxvpIlOgg==
X-Received: by 2002:a17:906:dffa:b0:a23:2762:e48b with SMTP id lc26-20020a170906dffa00b00a232762e48bmr7639233ejc.63.1704198673994;
        Tue, 02 Jan 2024 04:31:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709061cc300b00a26a9593a68sm11169117ejh.76.2024.01.02.04.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:31:13 -0800 (PST)
Message-ID: <f572489d-cdd7-4582-a355-ba0a917cf1f8@redhat.com>
Date: Tue, 2 Jan 2024 13:31:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/intel/pmc: make lnl_d3_fixup static
Content-Language: en-US, nl
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, irenic.rajneesh@gmail.com
Cc: david.e.box@intel.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20231229020808.55840-1-jiapeng.chong@linux.alibaba.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231229020808.55840-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiapeng,

On 12/29/23 03:08, Jiapeng Chong wrote:
> The lnl_d3_fixup are not used outside the file lnl.c, so the
> modification is defined as static.
> 
> drivers/platform/x86/intel/pmc/lnl.c:503:6: warning: no previous prototype for ‘lnl_d3_fixup’.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7811
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thank you for your patch, but this has already been fixed
in the current version of the code, see:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/tree/?h=for-next


Regards,

Hans

> ---
>  drivers/platform/x86/intel/pmc/lnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
> index 88b35931f5df..f18fdc68fd94 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -500,7 +500,7 @@ const struct pmc_reg_map lnl_socm_reg_map = {
>   * Set power state of select devices that do not have drivers to D3
>   * so that they do not block Package C entry.
>   */
> -void lnl_d3_fixup(void)
> +static void lnl_d3_fixup(void)
>  {
>  	pmc_core_set_device_d3(LNL_IPU_PCI_DEV);
>  	pmc_core_set_device_d3(LNL_NPU_PCI_DEV);


