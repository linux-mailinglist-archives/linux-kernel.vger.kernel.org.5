Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA375ABFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGTKbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjGTKbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:31:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DD81705;
        Thu, 20 Jul 2023 03:31:39 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2A9E4EBA;
        Thu, 20 Jul 2023 12:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689849041;
        bh=FKPk/eWfRryDWZfeoKDk/qnFgxfZjp8mjYjlaloxrdY=;
        h=From:Subject:Date:To:Cc:From;
        b=VsCmzI4eZZ5z7xomvErdLYImzjHqdkmorL1rhUY+TooC33b/jNHGwUZTnXvCwlzWb
         Cp47azyVgrTheCVpIHTcwhmssawt8gmo2q1N7+z+fgvj/rKGlIWiiETXIXSQ+7ZSNs
         RoKXsl6vH9sTlBsFa86ZlWHnd23HNRt3PO88iouY=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 0/8] media: i2c: ds90ub9xx: Misc improvements
Date:   Thu, 20 Jul 2023 13:30:31 +0300
Message-Id: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMcMuWQC/yWNQQ6DIBREr2JYFyMfldBV79G4QPnWHxUMENPGe
 PdSu3yTmTcHixgII7sXBwu4UyTvMsCtYMNk3As52cwMKpCVgoqPm13IzdxYSymXIx/7RmolZau
 gYXm3BRzpfTmfXeaJYvLhc13s4pf+ba1ohWw0QFnXoJXmgie/UrmbZUZy6B5k0UTvem+CLQe/s
 u48zy/Xjct3swAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=FKPk/eWfRryDWZfeoKDk/qnFgxfZjp8mjYjlaloxrdY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkuQ0EPt3I0636QXuPa2dSxCBk7GGfVzpyIk082
 DlQM6fnHhiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZLkNBAAKCRD6PaqMvJYe
 9Xa5D/9a35RuACGQ3cTXv43WLemB7mjHWL59Q2FYSx+YjPVeHJKXxOj0yj5XdC1n0ERybAapjfT
 oavk+xiNpAdi0L8tEE4SvqVlpLHLTxfffWhrps4Dfl+EpIBNQSHUWq9a3e1sOmK0Bov4Fc/mBB+
 ZBK5fKvV+UueOiLoFzxBL20VIn8tzpzhJAJ5aJp8I8LINKdvTp1hA6LvBaIcKep/3PR8CFEZsH5
 Owy0r3TxMiEcm9aXu7EkfJEV2SqpFjfMdufd3M1xjNfhJJ6yEpgNvzVoxcQTCyw00+7JtGRNnvr
 u76Vorx1JLypUI+xhFnEUJjDmVV/59IsKap70xA0i/FAds4TauKB7qHvmgQjpEnZlHQht+eOY0n
 TAc/QFWCSbNPeSjSWpSYhq/abPpcuxXR1Ajwwyyi836qMGSNdwKBGuwbWzoDwp9Z0yWCuF3+EDB
 q8OwPBdsx5CpkYOgdAluH7d0o1p5HoBV4fX7dpRoQmUWknB/OCS/MLnzpP41QtNrxuY/TZt3nVT
 QBYUweWIqPCVf1wFWp2aP1id4okUyhjY1wrg+is6NSnmZWsEDyiu22e1XfFqVNI/7zSd2Rhub3E
 +Dz2Sr6leH9adyBT1PhTf8tXhWhfs+Z8m8tMbZVeLzAlBCEhFirx+HrzVjfYrrWV8E5x056lIVy
 OQ2pwB+i31GYSLw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains small miscellaneous improvements to the FPD-Link
drivers.

These were sent originally in v14 of the "i2c-atr and FPDLink" series
(link below), but were then left out for v15. So I have assigned v2 to
this series.

I have trimmed the to/cc list a bit, as these don't really deal with i2c
and dt anymore.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v2:
- New patch which renames ASYNC to NONSYNC
- Minor cosmetic change
- I didn't take u32_fract into use (as suggested by Andy), as I think it
  makes the driver a bit more confusing.
- Link to v1: https://lore.kernel.org/r/20230616135922.442979-1-tomi.valkeinen@ideasonboard.com

---
Tomi Valkeinen (8):
      media: i2c: ds90ub960: Configure CSI-2 continuous clock
      media: i2c: ds90ub953: Use v4l2_fwnode_endpoint_parse()
      media: i2c: ds90ub913: Use v4l2_fwnode_endpoint_parse()
      media: i2c: ds90ub953: Handle V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK
      media: i2c: ds90ub960: Allow FPD-Link async mode
      media: i2c: ds90ub953: Restructure clkout management
      media: i2c: ds90ub953: Support non-sync mode
      media: i2c: ds90ub960: Rename RXPORT_MODE_CSI2_ASYNC to RXPORT_MODE_CSI2_NONSYNC

 drivers/media/i2c/ds90ub913.c |  32 ++++---
 drivers/media/i2c/ds90ub953.c | 193 +++++++++++++++++++++++++-----------------
 drivers/media/i2c/ds90ub960.c |  31 ++++---
 3 files changed, 152 insertions(+), 104 deletions(-)
---
base-commit: 28999781d15f94046e6c23a9a7d92ad28a436abf
change-id: 20230720-fpdlink-additions-fb5397336725

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

