Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC5808014
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjLGFUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjLGFUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:20:31 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE887D44;
        Wed,  6 Dec 2023 21:20:32 -0800 (PST)
X-UUID: 550ae12494c011eea5db2bebc7c28f94-20231207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5m/cIwP+brAek9B1DG5tmgUso+IIGyZtwTuV1i3LYJA=;
        b=omfW4h7QxT70qel36iU4Wihvk0oPsejyJNTVhFP7Cc+Qc+YAKlW6a/Iv6N5FP3JlJCqk4B2GLdma5yLaJvS0jykKqZc6POiZb12iamUKJmgYrP/yiTX8qUrwowOb20Cb6gs2/sV9I3bXtKUEqjTARLNAb9ppcuQoS4YyxzqyAwU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:be150ecd-027b-4031-be6a-0f047f74b19a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:0c8562fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 550ae12494c011eea5db2bebc7c28f94-20231207
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <zhi.mao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1328425573; Thu, 07 Dec 2023 13:20:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Dec 2023 13:20:25 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Dec 2023 13:20:24 +0800
From:   Zhi Mao <zhi.mao@mediatek.com>
To:     <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <shengnan.wang@mediatek.com>, <yaya.chang@mediatek.com>,
        <10572168@qq.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <yunkec@chromium.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <jacopo.mondi@ideasonboard.com>, <sakari.ailus@linux.intel.com>,
        <zhi.mao@mediatek.com>, <hverkuil-cisco@xs4all.nl>,
        <heiko@sntech.de>, <jernej.skrabec@gmail.com>,
        <macromorgan@hotmail.com>, <linus.walleij@linaro.org>,
        <laurent.pinchart@ideasonboard.com>, <hdegoede@redhat.com>,
        <tomi.valkeinen@ideasonboard.com>, <gerald.loacker@wolfvision.net>,
        <andy.shevchenko@gmail.com>, <bingbu.cao@intel.com>,
        <dan.scally@ideasonboard.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/2] media: i2c: Add support for GC08A3 sensor 
Date:   Thu, 7 Dec 2023 13:20:14 +0800
Message-ID: <20231207052016.25954-1-zhi.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.953300-8.000000
X-TMASE-MatchedRID: 44Hc/KaCvIQtlu2PjaXfUW3NvezwBrVmQPCPzycuBFOl4EP+dy+wBAwF
        qajp21ReNJCQfPeJOQovXSnelSgBMJlIfdN/LTrGdE/dhjO8a+RqYquCrLrVwhHfiujuTbedduS
        l0OECBiYax6DXJKFg8UH+8sLaZoS5D0VXqQ1iI8djVtAwIy+afu+aBTJJYa54DFK34uTYNp9DTK
        YgguDfmv85PXnIyicNzNny9LCRSYPNwJnbTIxiVe7KTDtx8CggKhNpTcvbdUKbKItl61J/yZ+in
        TK0bC9eKrauXd3MZDVG0JUmJbystNn10BTO+noGPJvW94tofC0ats+ZN43x2ecHhVDiw4YD
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.953300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: ACC8CC612608CD163EB92DB6552FA7018104EB61AB51DBB62DC05E34EAF8B6202000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds YAML DT binding and V4L2 sub-device driver for Galaxycore's
GC08A3 8-megapixel 10-bit RAW CMOS 1/4" sensor, with an MIPI CSI-2 image data
interface and the I2C control bus.

The driver is implemented with V4L2 framework.
 - Async registered as a V4L2 sub-device.
 - As the first component of camera system including Seninf, ISP pipeline.
 - A media entity that provides one source pad in common.
 - Used in camera features on ChromeOS application.

Also this driver supports following features:
 - manual exposure and analog gain control support
 - vertical blanking control support
 - test pattern support
 - media controller support
 - runtime PM support
 - support resolution: 3264x2448@30fps, 1920x1080@60fps

Previous versions of this patch-set can be found here:
 v1: https://lore.kernel.org/linux-media/20231123115104.32094-1-zhi.mao@mediatek.com/

Changes of v2 mainly address comments from Krzysztof/Rob Herring&Conor Dooley.
Compared to v1:
  - Fix some review comments  
  - Add reviewed-by for sensor driver
  - Fix some build-error and warning message 
 
Thanks


Zhi Mao (2):
  media: i2c: Add GC08A3 image sensor driver
  media: dt-bindings: media: i2c: Document GC08A3 bindings

 .../bindings/media/i2c/galaxycore,gc08a3.yaml |  127 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/media/i2c/Kconfig                     |   14 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/gc08a3.c                    | 1888 +++++++++++++++++
 5 files changed, 2032 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
 create mode 100644 drivers/media/i2c/gc08a3.c

-- 
2.25.1



