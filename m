Return-Path: <linux-kernel+bounces-3799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375DA8171C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C00284316
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF4837887;
	Mon, 18 Dec 2023 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icd8mDlV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4DE3787E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702908019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHb9Nbxq9O6XaraMZw0ThBizBBW+/NNEjqc7eDhvdfw=;
	b=icd8mDlVE9JbKi+5IbuDfoi0Y7pNiu2bohpe3UAQrOpTavakjVlLBN/klkzeJZOHloIsuf
	gA0iLLqtMd7R01eWgVnCj3H37+DcSTid9d62W+qXB1jqlLkJkVqgwhhoTbEzjNAAfraWRQ
	neyBB8x2SU+2uzslXcZ+Tej6XIFwr1g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-Xzi0V-ZzPoayfIzXwuUCuA-1; Mon, 18 Dec 2023 09:00:17 -0500
X-MC-Unique: Xzi0V-ZzPoayfIzXwuUCuA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c3cea4c19so28220175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908016; x=1703512816;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHb9Nbxq9O6XaraMZw0ThBizBBW+/NNEjqc7eDhvdfw=;
        b=jWTytdDfHqIwreAjL6FBN4218dru5QDLFcKw0fjJDIev7LpfumerKO2wWYP3uaPtl4
         W3hLpLmyNNeHLvUssGR1KwIiAPOKbyhKeENltDcO8YpayB/rST1X/YkwA2VjNn3AgpSP
         r48aCqL9pg8o/bgahNZYNIk4JnripXw2IG8PFevY3QPj3yJfAa+QlusIr+zmOXfqxy1r
         tn7es/NbOhXZ2lgRP1MHlDJtviYOwcp4tvGR8S4FaSzPjzykXzwvTccn7TWOuCt9l2vU
         8jx4LqQijkpibc/nlExgqGoUezBwFhryM0DkhzuyaRGJki/o+5eNagRvTRKCOfQJv1g8
         AM3w==
X-Gm-Message-State: AOJu0YzvNzPSk7e6rC76wq2X4+a5XbTzLjnlGDmSqqa57KmNeO7gZAH3
	m/2fK1VFTXRkZwIRT90v6/fc8kZ5qK/73UwNE1R+mEyDR43BM8+W6nJkiKgRWDSm92jxDy32v8H
	R8IA6DOINHVJMq78F9KcrguJc
X-Received: by 2002:a7b:c4ca:0:b0:40c:2b87:de8b with SMTP id g10-20020a7bc4ca000000b0040c2b87de8bmr7921958wmk.132.1702908016260;
        Mon, 18 Dec 2023 06:00:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQUemTUaWAYOujMHM3kn+wtXlUppofidsDm63eCKP6jWUO0qO6fCKjoguTECdmIH7q1Qnz+g==
X-Received: by 2002:a7b:c4ca:0:b0:40c:2b87:de8b with SMTP id g10-20020a7bc4ca000000b0040c2b87de8bmr7921947wmk.132.1702908015989;
        Mon, 18 Dec 2023 06:00:15 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id cx7-20020a170907168700b009fc576e26e6sm14059747ejd.80.2023.12.18.06.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 06:00:15 -0800 (PST)
Message-ID: <630dd0a3-429a-4bdc-82de-ffc1c7b97f08@redhat.com>
Date: Mon, 18 Dec 2023 15:00:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/intel/vsec: Add support for Lunar Lake M
Content-Language: en-US
To: rjingar <rajvi.jingar@linux.intel.com>, linux-kernel@vger.kernel.org,
 david.e.box@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org
References: <20231216005146.1735455-1-rajvi.jingar@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231216005146.1735455-1-rajvi.jingar@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/16/23 01:51, rjingar wrote:
> From: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> 
> Add Lunar Lake M PMT telemetry support.
> 
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
>  drivers/platform/x86/intel/vsec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index c1f9e4471b28..3567dba57781 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -421,6 +421,11 @@ static const struct intel_vsec_platform_info tgl_info = {
>  	.quirks = VSEC_QUIRK_TABLE_SHIFT | VSEC_QUIRK_EARLY_HW,
>  };
>  
> +/* LNL info */
> +static const struct intel_vsec_platform_info lnl_info = {
> +	.caps = VSEC_CAP_TELEMETRY | VSEC_CAP_WATCHER,
> +};
> +
>  #define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
>  #define PCI_DEVICE_ID_INTEL_VSEC_DG1		0x490e
>  #define PCI_DEVICE_ID_INTEL_VSEC_MTL_M		0x7d0d
> @@ -428,6 +433,7 @@ static const struct intel_vsec_platform_info tgl_info = {
>  #define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
>  #define PCI_DEVICE_ID_INTEL_VSEC_RPL		0xa77d
>  #define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
> +#define PCI_DEVICE_ID_INTEL_VSEC_LNL_M		0x647d
>  static const struct pci_device_id intel_vsec_pci_ids[] = {
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
> @@ -436,6 +442,7 @@ static const struct pci_device_id intel_vsec_pci_ids[] = {
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &oobmsm_info) },
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
> +	{ PCI_DEVICE_DATA(INTEL, VSEC_LNL_M, &lnl_info) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, intel_vsec_pci_ids);


