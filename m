Return-Path: <linux-kernel+bounces-13672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED2820AD4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1336C1C2154A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26EF2F52;
	Sun, 31 Dec 2023 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tc/8FJsB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6974185D
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704015596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p00vxKoEMhQVOKsnT5oQD5pn/y7oPEGUmKyIbH6tSV4=;
	b=Tc/8FJsBMEJRi0g64e6kTit2tkq7OyVSO4U2Fg32Rd4kbLxWxGgPq4TlRRGokBhxAoqBOy
	WPEtYyAEK1IMIpsnU+7rI/Tj/41F3sKM90rlt+KW4GYMsn0XP8ai0BQh9Fy08/GVXqkL0X
	IrL+8RLgezlXsvoa+W4iXplP/zyCE7A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-hxIXJDVnOMaEcIjyamVCuw-1; Sun, 31 Dec 2023 04:39:53 -0500
X-MC-Unique: hxIXJDVnOMaEcIjyamVCuw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-556415459d2so43005a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 01:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704015592; x=1704620392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p00vxKoEMhQVOKsnT5oQD5pn/y7oPEGUmKyIbH6tSV4=;
        b=hGNz8AWnNGUEGrLEQR8KOs3Px1s9omGMFH+Ig4anBB+au7OCaJriwTJ0L/wIv6WfBb
         wV7r5RCw7/exAxe2VEO9gjl15GmB3D72SfOBSo+FkRIaSUxsoRUKEhhKpd8c3mtUaAgW
         +M4iJJ4EzSVul/VGrAXlgWwMS4NgO6DIJDEmwYi1t6qVLr/hN3klYutFB+Fjza4OazqO
         kwoBtGKpN+c+gOux/olJb5K3ywlUD8uYhWSrPRCgdPVF0XIsuO6togkfBxubwyU+K6fR
         1ptHyp9eGJODvPuXZ7yiVYjQkU1UebVo7L6pyVtIVGKHUuKAVI36rtZ997XJeTOYcZkL
         YxoA==
X-Gm-Message-State: AOJu0YwosC3hGXWySxeSmtIK6Nz6gCHLkG6qO8rUR+msoQuhu+FcziU0
	8nFMHbwK5bG5TCI3gqAf2oWRiZwlaBFMWWQWS4ZjT7XeAnKrsI1rrGKp7yQT5pKvU8RghZ9hB2Y
	vRjGSPqQo/aXVPwh3UBDuK1vh573LcRIv
X-Received: by 2002:a50:f60d:0:b0:555:dc5f:101d with SMTP id c13-20020a50f60d000000b00555dc5f101dmr1016786edn.8.1704015592080;
        Sun, 31 Dec 2023 01:39:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9CSLi4539eGxiNxHCoTLDGqxn9HxSGEP8UxUiNunjYCYJMKg4e61V+O2clbJz5YKv2iw6vQ==
X-Received: by 2002:a50:f60d:0:b0:555:dc5f:101d with SMTP id c13-20020a50f60d000000b00555dc5f101dmr1016778edn.8.1704015591859;
        Sun, 31 Dec 2023 01:39:51 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ew10-20020a056402538a00b005546ba152f4sm10900308edb.71.2023.12.31.01.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 01:39:51 -0800 (PST)
Message-ID: <577086e4-c641-467e-b915-37d4ecfedb55@redhat.com>
Date: Sun, 31 Dec 2023 10:39:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: media: atomisp: pci: Fix spelling mistake in
 isp2400_input_system_global.h
Content-Language: en-US, nl
To: Dipendra Khadka <kdipendra88@gmail.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org, hpa@redhat.com
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231222201503.2337-1-kdipendra88@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231222201503.2337-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/22/23 21:15, Dipendra Khadka wrote:
> The script checkpatch.pl reported a spelling error
> in isp2400_input_system_global.h as below:
> 
> '''
> WARNING: 'upto' may be misspelled - perhaps 'up to'?
> //MIPI allows upto 4 channels.
>               ^^^^
> '''
> 
> This patch corrects a spelling error,
> changing "upto" to "up to".
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
>  drivers/staging/media/atomisp/pci/isp2400_input_system_global.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/isp2400_input_system_global.h b/drivers/staging/media/atomisp/pci/isp2400_input_system_global.h
> index 61f23814e2fd..3ff61faf0621 100644
> --- a/drivers/staging/media/atomisp/pci/isp2400_input_system_global.h
> +++ b/drivers/staging/media/atomisp/pci/isp2400_input_system_global.h
> @@ -19,7 +19,7 @@
>  #define		N_CSI_PORTS (3)
>  //AM: Use previous define for this.
>  
> -//MIPI allows upto 4 channels.
> +//MIPI allows up to 4 channels.
>  #define		N_CHANNELS  (4)
>  // 12KB = 256bit x 384 words
>  #define		IB_CAPACITY_IN_WORDS (384)


