Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E59769776
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjGaNZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGaNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:25:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62DB10F0;
        Mon, 31 Jul 2023 06:25:24 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 88F972E4;
        Mon, 31 Jul 2023 15:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690809860;
        bh=TJ1SsxaOKehE9OaIF4HQh0N0BLtL+XTNbOyUix07Ug0=;
        h=From:Subject:Date:To:Cc:From;
        b=Nx7BhIrYGPSRFepMAdbhlPInicEcj/rpeXREAO1v1gNLcxGFxa6wzIonolc2JqMHK
         8XWQ+diz1VbntnSXNQFee583eoM4FwjNpTZ76fg2Qz0hDIOKDUFPIRyzmyA4dmwC/u
         Bbe3ky3QqaoYmhoPx+/Lp7/pPui3rAM/rmPFrAXI=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v3 0/9] media: i2c: ds90ub9xx: Misc improvements
Date:   Mon, 31 Jul 2023 16:24:34 +0300
Message-Id: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABO2x2QC/22Oyw6DIBBFf6VhXYwMPkJX/Y+mC5SxTlQwYEgb4
 78X7aIbl+dm7rmzsoCeMLDbZWUeIwVyNoG8Xljba/tCTiYxgxxkXkPOu9mMZAeujaElHQfeNaV
 UtZRVDSVLvdljR+/D+Xgm7ikszn+OiSj29GerRCVkqQCyogBVKy744ibKoh4HJIv2TgZ1cLZx2
 pusdRPbdRH+ivOHIvCcN0o0AlsN2sgT0bZtX6TZtKf8AAAA
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=TJ1SsxaOKehE9OaIF4HQh0N0BLtL+XTNbOyUix07Ug0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkx7Y51doxk63Mk/7F789iG36aXEI40c0MZXc4P
 4Z183YthRCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMe2OQAKCRD6PaqMvJYe
 9UT2EACxyWuJzwGbGn2EACykgTl4arQx01xogjFK0jLXip8FzrXrZogBmEi8Zk/inj3Rv2YX1D1
 gqG73Ac+1DZHY4Ou470pLXAdwcW9N8OTZLB1AhTFDxb1xHr4699NxTscsSHTPAdmFGHT5V5lkn2
 eDwdB/3XW1J1FcZ/qql+HANya8BUiRRzJ/ysuA7ShUcICwqXr9YRD0S/XnI+5CPP4Y2+A4XVkIR
 xyyjKp2eTOsVqasESCHxyxdDtSZKoLLPnGFcSWaeyKb3YYXEfmWRkHL9UTir3XNTLh9qFoQj31+
 dfrF6mPhhNJ+x8FVxnDNwA1p+ouaZzMiMx4IQHkLUiSZ7Nt70K51MJBiig0r9R91Vi98poQ1n2E
 68HBAW6riACe0mioRneUVaNm615G2X/RKWQPP/LbMoy+gzIZGi1V7joesFVMvmRtnB0ACS00EHs
 NPmWcIWpe7xm7c8ssaqAN2WWxNDJMjPQd7NDOIwl7X2LUHMHMor3AuEwOQXU99VtRRCpesfAyuU
 mcu53bDINP59mcWfUGvqrv97jg6P89V9qAEVWQMLOOZQ/fSOqEef0N5qW5busah3iTlSSJBG5LV
 jzCIWwczYIgPaI1yB9RQN3abPOxSEVHMsJ5WVAOKei5rJIKygiiVBu63ni/9mmAwQlGZrx8G3ZJ
 V9wr4LWSsEX1rMQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains small miscellaneous improvements to the FPD-Link
drivers.

These were sent originally in v14 of the "i2c-atr and FPDLink" series
(link below), but were then left out for v15. So I have assigned v2 to
the "first" version of this series.

I have trimmed the to/cc list a bit, as these don't really deal with i2c
and dt anymore.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v3:
- New patch which fixes the async sub-device matching
- Addressed all the comments from Laurent
- Added Laurent's & Andy's Rbs
- Link to v2: https://lore.kernel.org/r/20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com

Changes in v2:
- New patch which renames ASYNC to NONSYNC
- Minor cosmetic change
- I didn't take u32_fract into use (as suggested by Andy), as I think it
  makes the driver a bit more confusing.
- Link to v1: https://lore.kernel.org/r/20230616135922.442979-1-tomi.valkeinen@ideasonboard.com

---
Tomi Valkeinen (9):
      media: i2c: ds90ub9x3: Fix sub-device matching
      media: i2c: ds90ub960: Configure CSI-2 continuous clock
      media: i2c: ds90ub953: Use v4l2_fwnode_endpoint_parse()
      media: i2c: ds90ub913: Use v4l2_fwnode_endpoint_parse()
      media: i2c: ds90ub953: Handle V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK
      media: i2c: ds90ub960: Allow FPD-Link async mode
      media: i2c: ds90ub953: Restructure clkout management
      media: i2c: ds90ub953: Support non-sync mode
      media: i2c: ds90ub960: Rename RXPORT_MODE_CSI2_ASYNC to RXPORT_MODE_CSI2_NONSYNC

 drivers/media/i2c/ds90ub913.c |  47 +++++----
 drivers/media/i2c/ds90ub953.c | 215 ++++++++++++++++++++++++------------------
 drivers/media/i2c/ds90ub960.c |  31 +++---
 3 files changed, 164 insertions(+), 129 deletions(-)
---
base-commit: 38d6a03d2511bee97455b2ea0314c918537ef1ec
change-id: 20230720-fpdlink-additions-fb5397336725

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

