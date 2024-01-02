Return-Path: <linux-kernel+bounces-14340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F3F821B99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85419B20B65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154AEED9;
	Tue,  2 Jan 2024 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SijWjnbw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF35FC0C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704198300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8Q/H5j5Lwchf7COe52r0epRoB65ZeKVWfFb4Y2HcpU=;
	b=SijWjnbw0+bqQ7cMWOzYfYMAVxxdmo6/pMmyv/ASg6L+7J9soalHDLoE7JOtXhT2ps1sgo
	18uhcgr0EjBEUzsO38xyOhcAzU0CYVVSLlAYC+ymSnLub2bzBCbvPlepFXxdqmgxxY+wXJ
	xJNiPVdvCdXPH99pekbRvh+OKzrgGbs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-9MsRbzbEMMGSaPwl2XgVRA-1; Tue, 02 Jan 2024 07:24:59 -0500
X-MC-Unique: 9MsRbzbEMMGSaPwl2XgVRA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ccdd4dc5b3so32427411fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704198297; x=1704803097;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8Q/H5j5Lwchf7COe52r0epRoB65ZeKVWfFb4Y2HcpU=;
        b=EDZb2OkFb8j9GYrCjTZ2mXG22V9dho48Ayunwjw4xFRrSvii7mLKZ0OhD/uietGuwh
         rT+O/QcVZXdiewNSprUZOq2Yp1ZsGrl6G4FBXE3jty0pu4S3g4bgmEHW1WcUdFoOfwd1
         1SMN+XytBwTu44m+UQtpa9TGJDwzLJAT0kojGEWpVdUDriZ+KEXbkA/XXxMdxuco0OBZ
         9gswk7nHXDAvBAsYOoMxs6bS7b4fIiZMTDt5pWNfOV59UupWpLYi2v3ki+mJjCB3gh9C
         tISlG4xFt8ct0R88wCsQNQxQ8RqXQ0mMr2Ns+z/FYbL9UKXlytr0QnH5w4ppVnLdybv0
         t2Gg==
X-Gm-Message-State: AOJu0YxW8Oi26nqtjaPWMMP98QrxHyAaKpiwz3wFUL3+6Rm9PPM5nVZe
	mx+oaD2E/UforFSTWdfa084EgJ0Un2QNIFn5HED6MAYAxBJeq84h48CPhJQzA2PuIMOCWOQYKlA
	nv/Tdi1N5lKlignd7S2xjzETbGIJYekOy
X-Received: by 2002:a2e:b894:0:b0:2cc:e878:43db with SMTP id r20-20020a2eb894000000b002cce87843dbmr3981662ljp.62.1704198297766;
        Tue, 02 Jan 2024 04:24:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi5EJ/K95BWnL3W0ozAignv8PmEqsCUmC2xj78+7q5lh6tLSOY5PwL+hCIxFE8OmtU27ZVqw==
X-Received: by 2002:a2e:b894:0:b0:2cc:e878:43db with SMTP id r20-20020a2eb894000000b002cce87843dbmr3981657ljp.62.1704198297449;
        Tue, 02 Jan 2024 04:24:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ez9-20020a056402450900b0055504002a5fsm9824333edb.72.2024.01.02.04.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:24:56 -0800 (PST)
Message-ID: <6d80562e-167e-45f0-a2be-07e00544d87e@redhat.com>
Date: Tue, 2 Jan 2024 13:24:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] platform/x86/intel/pmc: Add missing extern
Content-Language: en-US, nl
To: "David E. Box" <david.e.box@linux.intel.com>,
 ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231223032548.1680738-1-david.e.box@linux.intel.com>
 <20231223032548.1680738-9-david.e.box@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231223032548.1680738-9-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/23/23 04:25, David E. Box wrote:
> Add missing extern for tgl_h_reg_map. Fixes sparse warning:
> 
>   drivers/platform/x86/intel/pmc/tgl.c:213:26: warning: symbol 'tgl_h_reg_map' was not declared. Should it be static?
> 
> Fixes: 544f7b7f651c ("platform/x86/intel/pmc: Add regmap for Tiger Lake H PCH")
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
>  drivers/platform/x86/intel/pmc/core.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index ce7b1cd2b194..2a797fccf5e6 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -452,6 +452,7 @@ extern const struct pmc_bit_map tgl_vnn_misc_status_map[];
>  extern const struct pmc_bit_map tgl_signal_status_map[];
>  extern const struct pmc_bit_map *tgl_lpm_maps[];
>  extern const struct pmc_reg_map tgl_reg_map;
> +extern const struct pmc_reg_map tgl_h_reg_map;
>  extern const struct pmc_bit_map adl_pfear_map[];
>  extern const struct pmc_bit_map *ext_adl_pfear_map[];
>  extern const struct pmc_bit_map adl_ltr_show_map[];


