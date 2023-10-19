Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CA77D0017
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbjJSQ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbjJSQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:57:40 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0940013A;
        Thu, 19 Oct 2023 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1697734656; bh=07aDVsUy5RsQxnmnnN1afCwYsv5zVhLjMtrYunUCVWI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XrrzEBxqrJI2NUBKVQBiqsjqdRYhqAG5OeZXouIUqBKS+k565hXPquw7WL+pyGsan
         mMtNeSjULHISu2/snIV97Edi63AdqjD6FDWT4C1/BRGkpUF1QmZdVel5k80kHLvBBh
         hx6fQWpz9SnzWWn3yq+/Pc2c2BkGPVexbn751Oj8=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ondrej Jirman <megi@xff.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 4/4] mfd: rk8xx: Add support for RK806 power off
Date:   Thu, 19 Oct 2023 18:57:26 +0200
Message-ID: <20231019165732.3818789-5-megi@xff.cz>
In-Reply-To: <20231019165732.3818789-1-megi@xff.cz>
References: <20231019165732.3818789-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

Use DEV_OFF bit to power off the RK806 PMIC, when system-power-controller
is used in DTS.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/mfd/rk8xx-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index a50a181b18e9..c47164a3ec1d 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -525,6 +525,10 @@ static int rk808_power_off(struct sys_off_data *data)
 		reg = RK805_DEV_CTRL_REG;
 		bit = DEV_OFF;
 		break;
+	case RK806_ID:
+		reg = RK806_SYS_CFG3;
+		bit = DEV_OFF;
+		break;
 	case RK808_ID:
 		reg = RK808_DEVCTRL_REG,
 		bit = DEV_OFF_RST;
-- 
2.42.0

