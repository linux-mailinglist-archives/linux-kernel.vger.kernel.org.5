Return-Path: <linux-kernel+bounces-23446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC8282ACD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F12B2829F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C41514F81;
	Thu, 11 Jan 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTE8GgEA"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6414F79
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so60430125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704971098; x=1705575898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZPGxlrX7BusY7TLHurUJ/YbEgD2UlLPEhETZEeCeag=;
        b=VTE8GgEAmwlqahjBoKTk6ll8/M0PDwjRmmDA8vYcnZYalElcxmAE8GjncnlaSgfCFf
         DEoaQHpSqe5VgtLV4o+ymFtr9nfPinQwZgb3U0U6shRhmZ7SRQQn5f7sfZqPzqxWnNJe
         oGSYWNzoAuKUi07AJFfMPfi+b91OtpgvmHNUujh0bZk7FAxAOzhAnSO/z+7HbGErnpN4
         /1O2Lt6JMBUJk4vkwk6XpUa5+Gk9cG/0X9onno2BCu8w2qAwEMf5Uqe+CTyJ5Z6xiuNs
         10+XzzUe4k56hkbcknQ0Zkzn6A+PZ09c29AlDkkfOZO/Lu7glmLaNOHnce+yevWDUb8O
         r8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704971098; x=1705575898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZPGxlrX7BusY7TLHurUJ/YbEgD2UlLPEhETZEeCeag=;
        b=U0rzIQUaGiUs+39IXp2MnYVANJmJZLvh3//LvIuGNh0jaruVseDyPPRmy65nVoYvDE
         BhrgGASpgTH8fdkpBxJdW9fOhz1BfFQHIpUn4vA4MaK2spruF+6LYoqtEZSt0NmtKVeY
         fX3mnjx4TQYWLxfpeDf23c/nX88BCAGuKbe8aoreZkViiQNMyT7doPJg7bSiYt55Dlll
         bTxq1xR1qt2XGbnY5t1Q8uxS5z+neW7AX16w9GSAhy+QUKwK5URLVRFXUVcmxigZO61G
         6LGPbB2LAnzIiUeJ9ph2OsYSSdmuT1nOfA9ZE3XMigbKygcb62PD7eR6ueHLVtUeMdhK
         YioA==
X-Gm-Message-State: AOJu0YyNMvA516lpxvmrEnJY0Q9m5/EAAIceMHp/wZBJMHRhij8Hl1P7
	V31VF3o57j0zEKVkvdrZsySUm92oayIM6A==
X-Google-Smtp-Source: AGHT+IF+XcaiCo8+aQz2iSRmrWzgdeHikwQTjy/cUNypVTY3l3kaz+y01SDv2jBQK/KU5ySGz3o/MQ==
X-Received: by 2002:a05:600c:4e8c:b0:40d:39d0:9916 with SMTP id f12-20020a05600c4e8c00b0040d39d09916mr228182wmq.246.1704971097287;
        Thu, 11 Jan 2024 03:04:57 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c510800b0040e624995f1sm265160wms.8.2024.01.11.03.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:04:57 -0800 (PST)
Date: Thu, 11 Jan 2024 14:04:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Ming Qian <ming.qian@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Mingjia Zhang <mingjia.zhang@mediatek.com>,
	Jack Zhu <jack.zhu@starfivetech.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 08/13] staging: media: starfive: Add for StarFive ISP
 3A SC
Message-ID: <a761d936-4f46-41c8-b6f8-c1761eddd42f@moroto.mountain>
References: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
 <20240111084120.16685-9-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111084120.16685-9-changhuang.liang@starfivetech.com>

On Thu, Jan 11, 2024 at 12:41:15AM -0800, Changhuang Liang wrote:
> Register ISP 3A "capture_scd" video device to receive statistics
> collection data.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../staging/media/starfive/camss/stf-buffer.h |   1 +
>  .../staging/media/starfive/camss/stf-camss.c  |   8 +
>  .../media/starfive/camss/stf-capture.c        |  21 ++-
>  .../media/starfive/camss/stf-isp-hw-ops.c     |  66 ++++++++
>  .../staging/media/starfive/camss/stf-isp.h    |  23 +++
>  .../staging/media/starfive/camss/stf-video.c  | 143 +++++++++++++++++-
>  .../staging/media/starfive/camss/stf-video.h  |   1 +
>  7 files changed, 254 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/media/starfive/camss/stf-buffer.h b/drivers/staging/media/starfive/camss/stf-buffer.h
> index 9d1670fb05ed..727d00617448 100644
> --- a/drivers/staging/media/starfive/camss/stf-buffer.h
> +++ b/drivers/staging/media/starfive/camss/stf-buffer.h
> @@ -23,6 +23,7 @@ enum stf_v_state {
>  struct stfcamss_buffer {
>  	struct vb2_v4l2_buffer vb;
>  	dma_addr_t addr[2];
> +	void *vaddr;
>  	struct list_head queue;
>  };
>  
> diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
> index a587f860101a..3175d0d9a05c 100644
> --- a/drivers/staging/media/starfive/camss/stf-camss.c
> +++ b/drivers/staging/media/starfive/camss/stf-camss.c
> @@ -126,6 +126,7 @@ static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
>  static int stfcamss_register_devs(struct stfcamss *stfcamss)
>  {
>  	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
> +	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
>  	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
>  	int ret;
>  
> @@ -150,6 +151,13 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
>  
>  	cap_yuv->video.source_subdev = &isp_dev->subdev;
>  
> +	ret = media_create_pad_link(&isp_dev->subdev.entity, STF_ISP_PAD_SRC_SCD,
> +				    &cap_scd->video.vdev.entity, 0, 0);
> +	if (ret)
> +		goto err_cap_unregister;
> +

Don't we need to do something like

	media_entity_remove_links(&cap_yuv->video.vdev.entity);

as part of the cleanup?  Also where do we clean up this new call to
media_create_pad_link() in the unregister process?

> +	cap_scd->video.source_subdev = &isp_dev->subdev;
> +
>  	return ret;
>  
>  err_cap_unregister:

regards,
dan carpenter

