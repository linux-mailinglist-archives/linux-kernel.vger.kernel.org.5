Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679517F49F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjKVPM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKVPMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:12:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20F492;
        Wed, 22 Nov 2023 07:12:21 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a00f67f120aso336539566b.2;
        Wed, 22 Nov 2023 07:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700665940; x=1701270740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQfIch1n/oRDhqVwiC5BqHYmxmK2tX6xAmCbIID5gio=;
        b=k380wJmStBa1k33QXwY+ybrAokpE37D+XWpisBwJuKe9ZtU8+HF8eSKhJG+pAUr3vP
         tGEMg1nBipl/gLlZBN3OhttDEd2E1MmZSgpYV9U3g51+RwKUuOdzhPz7sfB3Lpkzwn6b
         oXI8euXlm2l5JyLz7Tli+5afNpJzfZmwTOkgI95iePtd2GaRj4UVyfKTYHVf1TTaGtf1
         Gp6jZQttEb3wVSfEMjVBeZBLDSDy75msg79n2DJHSLcfNmwepFXG4MOOPqbj5IYB/8gT
         EvDSOsjZKtMZUZ503kWqM5/6B0CkcCnE4zYsz1S8sY/cj3/DUp3gfmc8SCM2OBhBI0Ao
         RYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665940; x=1701270740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQfIch1n/oRDhqVwiC5BqHYmxmK2tX6xAmCbIID5gio=;
        b=CcH/LI48JJwYKbFSPyqWH64esKA+J0CNq4g5MG5S8TL/VZVLE0fDKD/sU3M0zXF6Wf
         UL1ZAoeRvddIG4LAdMplfF5lbXNai6pcAQe7zIKuql4z6WnZOYhTLNMupttofS3X7f52
         Kvt07Lli4XJysEjwa/IbAFpDIGX7sAJN1SV+IGCZKo9R/vIwzCCYvk4KHO4VkGWA9w6Z
         3FjBwX2WfW8/nja5piKSoRK4TugeY9O9MnZMQdSmb2TIvordTIQziG54KNq2wxxUkWfl
         VEWx8Q5C0w3QGyZ1qpivXNQ6ftBbJ6P6I2k+pZBdkypaFRq2/pFC+ov98geQZ+KwxXGp
         w27Q==
X-Gm-Message-State: AOJu0Yz9GMtHNlH0vID9hkVxJfTWH25c859mopTClaxQUYP8iGeWIY8Z
        PZnHQP9rHoM/UsTTWCE5F2w=
X-Google-Smtp-Source: AGHT+IHiLgBVKOXhv7+TxBpeKUaX4wKMK5XDupDn+7Jg4ZH8f40KnSZtsabsjI+c1Zsx7zphFi/2RA==
X-Received: by 2002:a17:906:10d:b0:a04:837e:a955 with SMTP id 13-20020a170906010d00b00a04837ea955mr1124649eje.32.1700665939918;
        Wed, 22 Nov 2023 07:12:19 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-2-39-142-131.cust.vodafonedsl.it. [2.39.142.131])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090671d200b009fc3845adc1sm4816513ejk.154.2023.11.22.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:12:19 -0800 (PST)
Date:   Wed, 22 Nov 2023 16:12:17 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Yichong Zhong <zyc@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Allon Huang <allon.huang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: rkisp1: Fix media device memory leak
Message-ID: <ZV4aUfNGS/C/8cAM@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231122-rkisp-fixes-v1-0-1958af371e39@ideasonboard.com>
 <20231122-rkisp-fixes-v1-1-1958af371e39@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-rkisp-fixes-v1-1-1958af371e39@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On Wed, Nov 22, 2023 at 04:42:22PM +0200, Tomi Valkeinen wrote:
> Add missing calls to media_device_cleanup() to fix memory leak.
> 
> Fixes: d65dd85281fb ("media: staging: rkisp1: add Rockchip ISP1 base driver")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index c41abd2833f1..e10cc2881757 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -617,6 +617,7 @@ static int rkisp1_probe(struct platform_device *pdev)
>  	media_device_unregister(&rkisp1->media_dev);
>  err_unreg_v4l2_dev:
>  	v4l2_device_unregister(&rkisp1->v4l2_dev);
> +	media_device_cleanup(&rkisp1->media_dev);
>  err_pm_runtime_disable:
>  	pm_runtime_disable(&pdev->dev);
>  	return ret;
> @@ -637,6 +638,8 @@ static void rkisp1_remove(struct platform_device *pdev)
>  	media_device_unregister(&rkisp1->media_dev);
>  	v4l2_device_unregister(&rkisp1->v4l2_dev);
>  
> +	media_device_cleanup(&rkisp1->media_dev);
> +
>  	pm_runtime_disable(&pdev->dev);
>  }

Looks good to me.
Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>

Thanks & Regards,
Tommaso

>  
> 
> -- 
> 2.34.1
> 
> 
