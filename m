Return-Path: <linux-kernel+bounces-13680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 426C8820AEC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E94B218AB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C4228F1;
	Sun, 31 Dec 2023 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0CoeDjQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD28C00
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704016228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kEf7d/YGdeFm03zUvPaO/2U+4jX1XrcVLrOXY0pw9B4=;
	b=C0CoeDjQK0OjeKNmYL10URBZgQmF0N5CKe1GNhgc+l8ksu0pDT46ef5Ruazj0Ha2Eebdmu
	Q0MmHTa+t0mIp5tPVK/UF3IJlsGafjVhoJgWUhAZHzpsz659Y8blQ2WFXrPj2dSAGnf8/1
	WaUhtMIpEeMrnRtSXYGRSoqBpnrfZaU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-TasuUQ1TNxG8pfpW8pH6Mg-1; Sun, 31 Dec 2023 04:50:25 -0500
X-MC-Unique: TasuUQ1TNxG8pfpW8pH6Mg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5541f04f1e9so4328961a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 01:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704016225; x=1704621025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEf7d/YGdeFm03zUvPaO/2U+4jX1XrcVLrOXY0pw9B4=;
        b=qqSngWn3g9U9tSQtF6gFrhjBTwXQFmHH2n67p8Oial6JM6mLqI5wID9MsGTI4ACP1u
         rIH7Aun9iXP8vWkboZAQL4blHbWt6x1aUhxGuTFUmIgJPv87R3HkgKKzyjf2gbDdWTxe
         b7Hm++9AObtlZ8MUEffp2WnqNTHSjb8gIERXlPjru1aoLp2Wvo5xvYf6sL00BI60KFnK
         cP0Po1XkH9qvsPaHMnIch5ZJaIZN1b6kMnZHeiDpuxCD8EQ3yTGdjx9DBAnxTNQpASGg
         Rwln2yWqeApQ6SjFgD/0NWkrkt4BDn7ALH+5MjVhodjBW6AlBOfADg1KJM/Odvjw0Myk
         lMIA==
X-Gm-Message-State: AOJu0YyMaOTT/y3YkV2u+Or9i7i6F4fSLfveaIjSV2y9k2Vf3sy9zlV5
	Oq8wfNnrnc6aZ9SZqAruia/CBYfS0eAZ6yUbfpzBBxI7sFAdGRv6SL9ympmgFyFBBTT4RTXbEyL
	DyajMN3F4gv+U4GYQADKoUAPGG8ACSDfT
X-Received: by 2002:a05:6402:308b:b0:555:aa7f:d497 with SMTP id de11-20020a056402308b00b00555aa7fd497mr2093648edb.78.1704016224827;
        Sun, 31 Dec 2023 01:50:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3d64gvre5UEtDcBCBGdINd+i9LVRHckeXIouY1yFGpHks7z/uFszsGDHYUupOFufsytkjmw==
X-Received: by 2002:a05:6402:308b:b0:555:aa7f:d497 with SMTP id de11-20020a056402308b00b00555aa7fd497mr2093638edb.78.1704016224521;
        Sun, 31 Dec 2023 01:50:24 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p12-20020a05640243cc00b0055493aa8905sm9894390edc.63.2023.12.31.01.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 01:50:24 -0800 (PST)
Message-ID: <7e1cd3de-053a-4664-a728-1d5999f4d354@redhat.com>
Date: Sun, 31 Dec 2023 10:50:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: media/atomisp/pci/isp/kernels/hdr: Fix spelling
 mistakes in ia_css_hdr_types.h
Content-Language: en-US, nl
To: Dipendra Khadka <kdipendra88@gmail.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org, hpa@redhat.com
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231223083157.84090-1-kdipendra88@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231223083157.84090-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/23/23 09:31, Dipendra Khadka wrote:
> codespell reported following spelling mistake
> in ia_css_hdr_types.h below:
> 
> '''
> ./isp/kernels/hdr/ia_css_hdr_types.h:60: paramterers ==> parameters
> ./isp/kernels/hdr/ia_css_hdr_types.h:62: Currenly ==> Currently
> '''
> This patch fixes these spelling mistakes.
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Thank you for your patch.

I have merged this in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this patch will be included in my next
pull-request to Mauro (to media subsystem maintainer)

Regards,

Hans




> ---
>  .../media/atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h      | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h b/drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h
> index 175c301ee96a..ecc98686f5cf 100644
> --- a/drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h
> +++ b/drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h
> @@ -57,9 +57,9 @@ struct ia_css_hdr_exclusion_params {
>  };
>  
>  /**
> - * \brief HDR public paramterers.
> + * \brief HDR public parameters.
>   * \details Struct with all parameters for HDR that can be seet from
> - * the CSS API. Currenly, only test parameters are defined.
> + * the CSS API. Currently, only test parameters are defined.
>   */
>  struct ia_css_hdr_config {
>  	struct ia_css_hdr_irradiance_params irradiance; /** HDR irradiance parameters */


