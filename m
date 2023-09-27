Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9217B0549
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjI0NX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjI0NXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:23:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F93F5;
        Wed, 27 Sep 2023 06:23:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1549AC433C8;
        Wed, 27 Sep 2023 13:23:49 +0000 (UTC)
Message-ID: <035d64ea-2851-4b65-b7bf-fc1c852d47ca@xs4all.nl>
Date:   Wed, 27 Sep 2023 15:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] Add Toshiba Visconti Video Input Interface driver
Content-Language: en-US, nl
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji Ishikawa,

On 26/09/2023 01:28, Yuji Ishikawa wrote:
> This series is the Video Input Interface driver
> for Toshiba's ARM SoC, Visconti.
> This provides DT binding documentation,
> device driver, documentation and MAINTAINER files.
> 
> A visconti VIIF driver instance exposes
> 1 media control device file and 3 video device files
> for a VIIF hardware.
> Detailed HW/SW are described in documentation directory.
> The VIIF hardware has CSI2 receiver,
> image signal processor and DMAC inside.
> The subdevice for image signal processor provides
> vendor specific V4L2 controls.
> 
> The device driver depends on two other drivers under development;
> clock framework driver and IOMMU driver.
> Corresponding features will be added later.

Building this series results in a set of sparse warnings:

drivers/media/platform/toshiba/visconti/viif_capture.c:235:29: warning: symbol 'out_format_spec' was not declared. Should it be static?
drivers/media/platform/toshiba/visconti/viif_capture.c:517:13: warning: context imbalance in 'viif_regbuf_access_start' - wrong count at exit
drivers/media/platform/toshiba/visconti/viif_capture.c:523:13: warning: context imbalance in 'viif_regbuf_access_end' - unexpected unlock
drivers/media/platform/toshiba/visconti/viif_csi2rx.c:458:15: warning: Using plain integer as NULL pointer
drivers/media/platform/toshiba/visconti/viif_csi2rx.c:458:15: warning: Using plain integer as NULL pointer

And I also get a Documentation build warning:

Documentation/output/videodev2.h.rst:6: WARNING: undefined label: 'v4l2-ctrl-type-visconti-isp'

Also note that you need to rebase: the v4l2-controls.h header changed.

Regards,

	Hans

> 
> Best regards,
> Yuji
> 
> Changelog v2:
> - Resend v1 because a patch exceeds size limit.
> 
> Changelog v3:
> - Add documentation to describe SW and HW
> - Adapted to media control framework
> - Introduced ISP subdevice, capture device
> - Remove private IOCTLs and add vendor specific V4L2 controls
> - Change function name avoiding camelcase and uppercase letters
> 
> Changelog v4:
> - Split patches because a patch exceeds size limit
> - fix dt-bindings document
> - stop specifying ID numbers for driver instance explicitly at device tree
> - use pm_runtime to trigger initialization of HW
>   along with open/close of device files.
> - add a entry for a header file at MAINTAINERS file
> 
> Changelog v5:
> - Fix coding style problem in viif.c (patch 2/6)
> 
> Changelog v6:
> - add register definition of BUS-IF and MPU in dt-bindings
> - add CSI2RX subdevice (separeted from ISP subdevice)
> - change directory layout (moved to media/platform/toshiba/visconti)
> - change source file layout (removed hwd_xxxx.c)
> - pointer to userland memory is removed from uAPI parameters
> - change register access (from struct style to macro style)
> - remove unused macros
> 
> Changelog v7:
> - remove redundant "bindings" from header and description text
> - fix multiline text of "description"
> - change "compatible" to "visconti5-viif"
> - explicitly define allowed properties for port::endpoint
> - remove unused variables
> - update kerneldoc comments
> - update references to headers
> 
> Changelog v8:
> - rename bindings description file
> - remove/simplify items in bindings
> - update operations around v4l2_async_notifier
> - use v4l2_async_connection instead of v4l2_async_subdev
> - use dev_err_probe()
> - better error handling at probe
> - remove redundant mutex
> - add V4L2_CTRL_TYPE_VISCONTI_ISP constant
> 
> Yuji Ishikawa (5):
>   dt-bindings: media: platform: visconti: Add Toshiba Visconti Video
>     Input Interface
>   media: platform: visconti: Add Toshiba Visconti Video Input Interface
>     driver
>   media: add V4L2 vendor specific control handlers
>   documentation: media: add documentation for Toshiba Visconti Video
>     Input Interface driver
>   MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
> 
>  .../media/toshiba,visconti5-viif.yaml         |  105 +
>  .../driver-api/media/drivers/index.rst        |    1 +
>  .../media/drivers/visconti-viif.rst           |  462 +++
>  .../media/v4l/vidioc-g-ext-ctrls.rst          |    4 +
>  .../media/v4l/vidioc-queryctrl.rst            |    5 +
>  MAINTAINERS                                   |    4 +
>  drivers/media/platform/Kconfig                |    1 +
>  drivers/media/platform/Makefile               |    1 +
>  drivers/media/platform/toshiba/Kconfig        |    6 +
>  drivers/media/platform/toshiba/Makefile       |    2 +
>  .../media/platform/toshiba/visconti/Kconfig   |   18 +
>  .../media/platform/toshiba/visconti/Makefile  |    8 +
>  .../media/platform/toshiba/visconti/viif.c    |  650 ++++
>  .../media/platform/toshiba/visconti/viif.h    |  374 ++
>  .../platform/toshiba/visconti/viif_capture.c  | 1489 ++++++++
>  .../platform/toshiba/visconti/viif_capture.h  |   22 +
>  .../platform/toshiba/visconti/viif_common.c   |  199 +
>  .../platform/toshiba/visconti/viif_common.h   |   38 +
>  .../platform/toshiba/visconti/viif_controls.c | 3394 +++++++++++++++++
>  .../platform/toshiba/visconti/viif_controls.h |   18 +
>  .../platform/toshiba/visconti/viif_csi2rx.c   |  691 ++++
>  .../platform/toshiba/visconti/viif_csi2rx.h   |   24 +
>  .../toshiba/visconti/viif_csi2rx_regs.h       |  102 +
>  .../platform/toshiba/visconti/viif_isp.c      | 1259 ++++++
>  .../platform/toshiba/visconti/viif_isp.h      |   24 +
>  .../platform/toshiba/visconti/viif_regs.h     |  716 ++++
>  drivers/media/v4l2-core/v4l2-ctrls-core.c     |    7 +-
>  include/uapi/linux/v4l2-controls.h            |    6 +
>  include/uapi/linux/videodev2.h                |    2 +
>  include/uapi/linux/visconti_viif.h            | 1800 +++++++++
>  30 files changed, 11431 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti5-viif.yaml
>  create mode 100644 Documentation/driver-api/media/drivers/visconti-viif.rst
>  create mode 100644 drivers/media/platform/toshiba/Kconfig
>  create mode 100644 drivers/media/platform/toshiba/Makefile
>  create mode 100644 drivers/media/platform/toshiba/visconti/Kconfig
>  create mode 100644 drivers/media/platform/toshiba/visconti/Makefile
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_capture.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_capture.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_common.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_common.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_controls.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_controls.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx_regs.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_isp.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_isp.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_regs.h
>  create mode 100644 include/uapi/linux/visconti_viif.h
> 

