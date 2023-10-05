Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF937BA1ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjJEPEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjJEPD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:03:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A228E96
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696516709; x=1728052709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uPW5WaZeYCNjpAiQXQ6dsyN5lBlDGiOxHHcb3Werqlg=;
  b=TcGOaI64rt7UM5BhKHmkce/ASt3Wckzwy7hi0giBR1NB9emtzaGjiSca
   V7l6GtBqZCf7D2rKzdgxl2gIVCAksw3HMV8nee8Wssz4ZqbMcvNuIJLip
   /Na1eJFVSUY/fzhBVimNQ/fW+xBoMHEhOjz/GPeGEQ1xWKE7+97mNXqUK
   7kDJ7tvmySi+pTfIURYo1IdB90/baLNsKzJoFODH7U0B4HDaVHMZdwV8g
   0fEoVbfj/AEqtLQcQPs55Bgz/cTB359r8Hy2HmcZGlOD97t6C1tOzgTZf
   X44Ju+9abi8Nvx2i5ZahPFSZO1/QP3cLvCHDoND0YSO0nnAt1g5mcxF8z
   g==;
X-CSE-ConnectionGUID: pNqRUMmsQ46P00UoeOunFg==
X-CSE-MsgGUID: 4CCEQRxATAWuAUPjZprfag==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="8182674"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2023 02:30:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 5 Oct 2023 02:30:04 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 5 Oct 2023 02:29:58 -0700
From:   Manikandan Muralidharan <manikandan.m@microchip.com>
To:     <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lee@kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>,
        Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v7 0/7] Add support for XLCDC to sam9x7 SoC family.
Date:   Thu, 5 Oct 2023 14:59:47 +0530
Message-ID: <20231005092954.881059-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to add support for XLCDC IP of sam9x7 SoC family
to the DRM subsystem.XLCDC IP has additional registers and new
configuration bits compared to the existing register set of HLCDC IP.
The new compatible string "microchip,sam9x75-xlcdc" is defined for sam9x75
variant of the sam9x7 SoC family.The is_xlcdc flag under driver data and
IP specific driver ops helps to differentiate the XLCDC and existing HLCDC
code within the same driver.

changes in v7:
* LCDC IP driver ops functions are declared static and its 
declaration are removed.

changes in v6:
* Fixed Cosmetic defects.
* Added comments for readability.

changes in v5:
* return value of regmap_read_poll_timeout is checked in failure
case.
* HLCDC and XLCDC specific driver functions are now invoked
using its IP specific driver ops w/o the need of checking is_xlcdc flag.
* Removed empty spaces and blank lines.

changes in v4:
* fixed kernel warnings reported by kernel test robot.

changes in v3:
* Removed de-referencing the value of is_xlcdc flag multiple times in
a single function.
* Removed cpu_relax() call when using regmap_read_poll_timeout.
* Updated xfactor and yfactor equations using shift operators
* Defined CSC co-efficients in an array for code readability.

changes in v2:
* Change the driver compatible name from "microchip,sam9x7-xlcdc" to
"microchip,sam9x75-xlcdc".
* Move is_xlcdc flag to driver data.
* Remove unsed Macro definitions.
* Add co-developed-bys tags
* Replace regmap_read() with regmap_read_poll_timeout() call
* Split code into two helpers for code readablitity.

Durai Manickam KR (1):
  drm: atmel-hlcdc: Define SAM9X7 SoC XLCDC specific registers

Manikandan Muralidharan (6):
  drm: atmel-hlcdc: add flag and driver ops to differentiate XLCDC and
    HLCDC IP
  drm: atmel-hlcdc: add LCD controller layer definition for sam9x75
  drm: atmel_hlcdc: Add support for XLCDC in atmel LCD driver
  drm: atmel-hlcdc: add DPI mode support for XLCDC
  drm: atmel-hlcdc: add vertical and horizontal scaling support for
    XLCDC
  drm: atmel-hlcdc: add support for DSI output formats

 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 175 +++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 105 +++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  86 ++++
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 369 +++++++++++++++---
 include/linux/mfd/atmel-hlcdc.h               |  10 +
 5 files changed, 647 insertions(+), 98 deletions(-)

-- 
2.25.1

