Return-Path: <linux-kernel+bounces-13669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1996820ACB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304731C20F24
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1A2907;
	Sun, 31 Dec 2023 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZDWQd3Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B423D5
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704015562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSsXgXAWfLN2ei8onO/BaPZdF6p5wfeK/YpnlP6sL2w=;
	b=dZDWQd3QHBaiRzsp6W/AlEzGRu7gs9We4IwZCHjcQ635PsJptNbfOETTUXSSUQ+ZfuymBn
	dNiK7lwOWa/sj8DZjX1qaBtjhiUcZulzwKSpT55NfS+0z9N3ZWbjJXc7HNBVHZ36WsixJP
	/WPm4XyD8rdm9RGgdBLPzkBMdrVHNoI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Efk30sypOy2b2IAG5y2NwQ-1; Sun, 31 Dec 2023 04:39:15 -0500
X-MC-Unique: Efk30sypOy2b2IAG5y2NwQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5560c5ff2f2so316040a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 01:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704015555; x=1704620355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSsXgXAWfLN2ei8onO/BaPZdF6p5wfeK/YpnlP6sL2w=;
        b=PvvJf9wcIw6j2Tz6ydHIjx591MSBIuQNewF2kUAtF+rhJwWX66D5HGLh9tJd+nmvZj
         cfPjplyq4NV4JMjibKv/SPMXp9B8nGkRSYQpH/1/Hj+l+lzTjpMJCioSGTjMgJpxVK5x
         Nsg6n25C0etj6AY3mgkrv0w1K/92xA+AlINC1lV53cS3wfLHIV9kDeVexZUBuvynM5R8
         8b/sp41TN4ECDF9Fj0KuZjS96RsvTYmQubclGeipeQqv50PihzRQvHLNLg7bReibqw2p
         HTwWTbD53el1cm2p62RCt6rEhWaHXiG+RT+G72vvoHhFwKLg7iE++P9+lU76S+gl6HAD
         jVGA==
X-Gm-Message-State: AOJu0YxRVuewFMFJT8oGSQewRUPMpmGYomJPrfx1rjPcJysj9t+AmDOG
	hJD35hzeMNp/lqKhq/0YaEAx9pFDAdKvY6T6Z6UOp+M/Zfdx7QRNRa9KEEytREd877gW5QbNu4d
	dSmCyQqFsfmlepUuwgEIElq+ORqTCZIQu
X-Received: by 2002:a05:6402:148f:b0:555:b7b8:6d58 with SMTP id e15-20020a056402148f00b00555b7b86d58mr2236131edv.68.1704015554864;
        Sun, 31 Dec 2023 01:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7gkqwiv08UWlPI2wSdTw3bR46a7OJotvXDUCIQsB1EFFE5OYNb2PjBotp4aybJT+sJK7bXQ==
X-Received: by 2002:a05:6402:148f:b0:555:b7b8:6d58 with SMTP id e15-20020a056402148f00b00555b7b86d58mr2236127edv.68.1704015554550;
        Sun, 31 Dec 2023 01:39:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ew10-20020a056402538a00b005546ba152f4sm10900308edb.71.2023.12.31.01.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 01:39:13 -0800 (PST)
Message-ID: <b78d7f1d-ced8-42d2-8523-7b26f917d3e9@redhat.com>
Date: Sun, 31 Dec 2023 10:39:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: staging: media: atomisp: pci: Fixes a spelling
 mistake in sh_css_defs.h
Content-Language: en-US, nl
To: Dipendra Khadka <kdipendra88@gmail.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231218153200.450148-1-kdipendra88@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231218153200.450148-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/18/23 16:32, Dipendra Khadka wrote:
> The script checkpatch.pl reported a spelling error
> in sh_css_defs.h as below:
> 
> '''
> WARNING: 'upto' may be misspelled - perhaps 'up to'?
> /* The FPGA system (vec_nelems == 16) only supports upto 5MP */
>                                                     ^^^^
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
>  drivers/staging/media/atomisp/pci/sh_css_defs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_defs.h b/drivers/staging/media/atomisp/pci/sh_css_defs.h
> index 7eb10b226f0a..2afde974e75d 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_defs.h
> +++ b/drivers/staging/media/atomisp/pci/sh_css_defs.h
> @@ -131,7 +131,7 @@ RGB[0,8191],coef[-8192,8191] -> RGB[0,8191]
>   * invalid rows/columns that result from filter initialization are skipped. */
>  #define SH_CSS_MIN_DVS_ENVELOPE           12U
>  
> -/* The FPGA system (vec_nelems == 16) only supports upto 5MP */
> +/* The FPGA system (vec_nelems == 16) only supports up to 5MP */
>  #define SH_CSS_MAX_SENSOR_WIDTH           4608
>  #define SH_CSS_MAX_SENSOR_HEIGHT          3450
>  


