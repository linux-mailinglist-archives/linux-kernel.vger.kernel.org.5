Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265147634DC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjGZL0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjGZL0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:26:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF430E9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:26:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so57549405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690370780; x=1690975580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Me9DdLikay9/mg6C3pH4uUNkCjGXHrRqvb1zE6qVcE8=;
        b=ujTe+OeVXyCQq14CK3Lba2vXYOY9/0WyK+FgPAmVWPvzh3WNG2TICYQast91tQL3J7
         7nZSIWWrhBBoDpJgfuV54SLHBWWYOCemg/C5NM5OftTyQk8YsN3RyzWTeINC6jiP20T6
         Yvw+psL8owvkQ0G+pmfjynvhdzpJuaKajxQDJ1sKtdGQylimQcZ8kz/nspw0Bg0GsK07
         dKIL0khNzLWR6bfDh71j3MQeL6YkTcRBtJvOYrm9MpfVgHft9xgCPLOisrXQndxpjXan
         wqUtQCJ6w2jldLKMabpDa/QJtc9sU8gKVGiaz5BYvrmdBjU4eesDzOULf9ieBr5AU7d/
         pQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690370780; x=1690975580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Me9DdLikay9/mg6C3pH4uUNkCjGXHrRqvb1zE6qVcE8=;
        b=jK9gLSCpcTTN7joixo0QoO45dejpBxnrsrUo/HeuqyMMynRoD857gUymPj4oeFKV9V
         lYTbdpXMJpkWazYNk1lyTT8eZ0JRzWWdN7OdSQIHX6mwBgow5LciVFF6KNQF4mE/lk3c
         NxhYqj8eJfKQGi0UcGylyunm8ntgil+c7tOCSJGckwsJ5hu/G4tz9VcqJf+jchZHfeno
         W91kiTfF10/L5gii+3NSxk37m9v4trRvH8epA1KpV3uSKpL6c++7PsnmRqnS9PXi1cSw
         rITKNb3k8pOxb0tdQ47pUBkEYNdjEYDF4vFLRiHiL+HTcpFIDW8P2j3AZBaJD0kJy7dW
         MC0Q==
X-Gm-Message-State: ABy/qLYa9MsCgYt5ZSu1w7PLZ61uyBxWRWrdpu6wLGt/6LeNxeoQq3xi
        b1b/HOJ9FPJ2lZBlo+fLNHmIIA==
X-Google-Smtp-Source: APBJJlEGjczswR4kEUEn/zYFcZ9/aGxKnTF+3Hy6HdeMe8iP8tSvfbhOFOcSPsrOUXJpQ+OHei9OVw==
X-Received: by 2002:adf:efcb:0:b0:314:370f:e92c with SMTP id i11-20020adfefcb000000b00314370fe92cmr1190968wrp.67.1690370780412;
        Wed, 26 Jul 2023 04:26:20 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h4-20020adfe984000000b003175f00e555sm9584341wrm.97.2023.07.26.04.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 04:26:19 -0700 (PDT)
Message-ID: <a108084b-8044-fe6f-9cb8-df1f3fc6fdfe@linaro.org>
Date:   Wed, 26 Jul 2023 12:26:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 2/6] media: admin-guide: Add starfive_camss.rst for
 Starfive Camera Subsystem
Content-Language: en-US
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-3-jack.zhu@starfivetech.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230619112838.19797-3-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 12:28, Jack Zhu wrote:
> Add starfive_camss.rst file that documents the Starfive Camera
> Subsystem driver which is used for handing image sensor data.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---
>   .../admin-guide/media/starfive_camss.rst      | 57 +++++++++++++++++++
>   .../media/starfive_camss_graph.dot            | 16 ++++++
>   .../admin-guide/media/v4l-drivers.rst         |  1 +
>   MAINTAINERS                                   |  1 +
>   4 files changed, 75 insertions(+)
>   create mode 100644 Documentation/admin-guide/media/starfive_camss.rst
>   create mode 100644 Documentation/admin-guide/media/starfive_camss_graph.dot
> 
> diff --git a/Documentation/admin-guide/media/starfive_camss.rst b/Documentation/admin-guide/media/starfive_camss.rst
> new file mode 100644
> index 000000000000..a6378849384f
> --- /dev/null
> +++ b/Documentation/admin-guide/media/starfive_camss.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: <isonum.txt>
> +
> +================================
> +Starfive Camera Subsystem driver
> +================================
> +
> +Introduction
> +------------
> +
> +This file documents the driver for the Starfive Camera Subsystem found on
> +Starfive JH7110 SoC. The driver is located under drivers/media/platform/
> +starfive.
> +
> +The driver implements V4L2, Media controller and v4l2_subdev interfaces.
> +Camera sensor using V4L2 subdev interface in the kernel is supported.
> +
> +The driver has been successfully used on the Gstreamer 1.18.5 with
> +v4l2src plugin.
> +
> +
> +Starfive Camera Subsystem hardware
> +----------------------------------
> +
> +The Starfive Camera Subsystem hardware consists of:
> +
> +- MIPI DPHY Receiver: receives mipi data from a MIPI camera sensor.

Feels like a terribe nit-pick but you have "mipi" and "MIPI" here. I'd 
be consistent with one - recommend MIPI throughout your documentation.

> +- MIPI CSIRx Controller: is responsible for handling and decoding CSI2 protocol
> +  based camera sensor data stream.
> +- ISP: handles the image data streams from the MIPI CSIRx Controller.

Maybe you've done this elsewhere but, it would be worthwhile describing 
what the ISP does. Debayering ? 3As ? Just raw dumps ?

> +- VIN(Video In): a top-level module, is responsible for controlling power
> +  and clocks to other modules, dumps the input data to memory or transfers the
> +  input data to ISP.
> +
> +
> +Topology
> +--------
> +
> +The media controller pipeline graph is as follows:
> +
> +.. _starfive_camss_graph:
> +
> +.. kernel-figure:: starfive_camss_graph.dot
> +    :alt:   starfive_camss_graph.dot
> +    :align: center
> +
> +The driver has 2 video devices:
> +
> +- stf_vin0_wr_video0: capture device for images directly from the VIN module.

OK so you can get the raw images.

> +- stf_vin0_isp0_video1: capture device for images without scaling.
> +
> +The driver has 3 subdevices:
> +
> +- stf_isp0: is responsible for all the isp operations.
> +- stf_vin0_wr: used to dump RAW images to memory.
> +- stf_vin0_isp0: used to capture images for the stf_vin0_isp0_video1 device.

But what is being output here ? RGB, jpeg, YUV ?
It would be worth adding a few bits of text to describe that so you 
don't have to dive into code to understand it.

---
bod
