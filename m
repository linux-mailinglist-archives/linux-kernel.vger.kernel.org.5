Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B02774EB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjHHW4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjHHW4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:56:16 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ABF1982;
        Tue,  8 Aug 2023 15:56:14 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378MtmE6052417;
        Tue, 8 Aug 2023 17:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691535348;
        bh=gn/RlHO0agg8ZMQ2jXn9GbN0dKI57+e4J4guDc2I+a4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=raCDqDMQwtc2aZBfj+fjR7CYJzw97gNMMvJQ/27XZEFsPHTAJIr+52L/deBtei6Po
         wgQr+OnNQKYDlRV1UK/czkH8bxCsIaGNZQSntBf6vdsU77+xGFDz64t3VkFjrJCp7i
         jS6sXORfWX4oZgDBarJEVuIRSwRx1/OdavkE7wRA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378Mtmw8013590
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 17:55:48 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 17:55:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 17:55:47 -0500
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378MtfSI033110;
        Tue, 8 Aug 2023 17:55:42 -0500
Message-ID: <fcf19efc-2e3c-1b5d-37c2-ddd1d8b4981a@ti.com>
Date:   Wed, 9 Aug 2023 04:25:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 00/16] CSI2RX support on J721E and AM62
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/07/23 13:59, Jai Luthra wrote:
> Hi,
> 
> This series adds support for CSI2 capture on J721E. It includes some
> fixes to the Cadence CSI2RX driver, and adds the TI CSI2RX wrapper driver.
> 
> This is a V8 of the below V7 series,
> https://lore.kernel.org/all/20230314115516.667-1-vaishnav.a@ti.com/
> 
> Since Pratyush moved out of TI, Vaishnav & I have been working on
> this driver, and I will be maintaining it upstream.
> 
> J721E CSI2RX driver can also be extended to support multi-stream
> capture, filtering different CSI Virtual Channels (VC) or Data Types
> (DT) to different DMA channels. A WIP series based on v7 is available
> for reference at https://github.com/jailuthra/linux/commits/csi_multi_wip
> 
> I will rebase the multi-stream patches on the current series (v8) and
> post them as RFC in the coming weeks.
> 
> Testing logs: https://gist.github.com/jailuthra/eaeb3af3c65b67e1bc0d5db28180131d
> 

Hi Jai,

Thank you for the series,

Tested the series for capture with OV5640 (LI-OV5640 module) on J721E EVM,
Logs and captured images available here:
https://gist.github.com/vaishnavachath/0b70bc5aaef6a3a88be4900979c788d6

Tested-by: Vaishnav Achath <vaishnav.a@ti.com>

Thanks and Regards,
Vaishnav

> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
> 
> Range-diff from v7 -> v8: http://0x0.st/H21u.diff
> 
> New Patches:
> [01/16]	   Export v4l2_subdev_link_validate_get_format() helper
> [03-04/16] Add new compatible for TI-specific SoC intergration of the
>            Cadence CSI2RX bridge IP
> [14/16]    Add support for RAW8 and RAW10 formats in Cadence CSI2RX
> 
> For [07/16] media: cadence: csi2rx: Add get_fmt and set_fmt pad ops:
> - Use active subdev state to use v4l2_subdev_get_fmt
> - Propagate formats from sink to source pads
> - Drop Laurent's R-by because of the above changes
> 
> For [08/16] media: cadence: csi2rx: Configure DPHY using link freq:
> - Drop original patch in-lieu of already merged
>   https://lore.kernel.org/linux-media/20230523085626.3295-5-jack.zhu@starfivetech.com/
> - Add a new patch to configure DPHY using link_freq control from the
>   source
> 
> For [10/16] media: cadence: csi2rx: Set the STOP bit when stopping a stream:
> - Fix bug where intention was to wait till stream status is idle, i.e.
>   STREAM_STATUS[31] -> 0 - but we were instead checking the opposite
> 
> For [15/16] media: dt-bindings: Add DT bindings for TI J721E CSI2RX driver:
> - Drop "Device Tree Bindings" from title
> - Rename "Wrapper" to "Shim" in title as that is the name referred in
>   the TRM and other places
> - Update maintainer to myself
> - Drop items from compatible as only a single element is present
> - Rename compatible to "ti,j721e-csi2rx-shim" to distinguish from the
>   SoC-specific CSI2RX bridge compatible
> 
> For [16/16] media: ti: Add CSI2RX support for J721E:
> - Move after dt-bindings to keep the series bisectable
> - Rename compatible to "ti,j721e-csi2rx-shim" to distinguish from the
>   SoC-specific CSI2RX bridge compatible
> - Make myself the Maintainer
> - Support RAW8 and RAW10 formats, and setting the pixel-unwrap size on
>   SHIM (RAW10 is stored in 16-bit containers, while RAW8 in 8-bit containers)
> - Fix enum_fmt_vid_cap() to respect CAP_IO_MC and only list pixelformats
>   matching the mbus formats set on the subdev.
> - Fix enum_framesizes() to stop enumerating more than a single framesize
>   (reject non-zero fsize->index)
> - Simplify notifier bound fucntion to use v4l2_create_fwnode_links_to_pad()
>   and inline the video_register() method
> - Add support for draining the DMA with an extra buffer, to get rid of
>   stale data in the pipeline on stream stop (or when frames start
>   getting dropped due to load)
> - Queue all available buffers to DMAEngine in the callback, also use a
>   separate "submitted" queue to track all buffers submitted to DMA
> - Use video_device_pipeline_start() instead of media_pipeline_start()
> - Drop support for VB_READ
> - Print issues in link validation as DEBUG instead of ERROR
> - s/async_subdev/async_connection
> 
> For [v7 13/13] media: dt-bindings: Convert Cadence CSI2RX binding to YAML:
>  - Drop patch in-lieu of
>    https://lore.kernel.org/linux-media/20230523085626.3295-2-jack.zhu@starfivetech.com/
> 
> ---
> Jai Luthra (4):
>       media: subdev: Export get_format helper for link validation
>       media: dt-bindings: cadence-csi2rx: Add TI compatible string
>       media: cadence: Add support for TI SoCs
>       media: cadence: csi2rx: Support RAW8 and RAW10 formats
> 
> Pratyush Yadav (12):
>       media: dt-bindings: Make sure items in data-lanes are unique
>       media: cadence: csi2rx: Unregister v4l2 async notifier
>       media: cadence: csi2rx: Cleanup media entity properly
>       media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
>       media: cadence: csi2rx: Configure DPHY using link freq
>       media: cadence: csi2rx: Soft reset the streams before starting capture
>       media: cadence: csi2rx: Set the STOP bit when stopping a stream
>       media: cadence: csi2rx: Fix stream data configuration
>       media: cadence: csi2rx: Populate subdev devnode
>       media: cadence: csi2rx: Add link validation
>       media: dt-bindings: Add TI J721E CSI2RX
>       media: ti: Add CSI2RX support for J721E
> 
>  .../devicetree/bindings/media/cdns,csi2rx.yaml     |    1 +
>  .../bindings/media/ti,j721e-csi2rx-shim.yaml       |  100 ++
>  .../bindings/media/video-interfaces.yaml           |    1 +
>  MAINTAINERS                                        |    7 +
>  drivers/media/platform/cadence/cdns-csi2rx.c       |  217 +++-
>  drivers/media/platform/ti/Kconfig                  |   12 +
>  drivers/media/platform/ti/Makefile                 |    1 +
>  drivers/media/platform/ti/j721e-csi2rx/Makefile    |    2 +
>  .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 1127 ++++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-subdev.c              |    8 +-
>  include/media/v4l2-subdev.h                        |   12 +
>  11 files changed, 1478 insertions(+), 10 deletions(-)
> ---
> base-commit: ec89391563792edd11d138a853901bce76d11f44
> change-id: 20230727-upstream_csi-acbeabe038d8
> 
> Best regards,
