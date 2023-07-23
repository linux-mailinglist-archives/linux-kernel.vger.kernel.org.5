Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74E875E039
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 09:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGWHNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 03:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGWHNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 03:13:45 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C69E4A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690096419;
        bh=BydRQ7LrlxKwL52rvHooi1sAXvD3aBwhb8X0VNEtSOM=;
        h=From:To:Cc:Subject:Date;
        b=xECZ8d3GEIMhVwS7A4hzYYweLjrZOguZBn/JJ5OfsWBn/pUCd+75UOKHM44vvNuCi
         oQdON8BWU8dugfVfryoTZ6XIAEjUQ/uam3HMq2khoAIDZmX87X2ktN/xV709hdu7K3
         pPEek6wakIR+XuZP3IamdUnY/qtN1Skx6FHw7Lq0=
Received: from localhost.ust.hk ([175.159.123.184])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 1E027011; Sun, 23 Jul 2023 15:07:32 +0800
X-QQ-mid: xmsmtpt1690096052ts63ans26
Message-ID: <tencent_AA66A80A12D4372BB57E5B7A60471EB00A08@qq.com>
X-QQ-XMAILINFO: MtiJdzH17lJXn8+YGVSqosmIrUD6q6uQf2Rq1TAbO/gCztlBx7eFvcvCQ8lNvY
         90FYDRtiC5jkEcC86Jdhcm0DnOC+7LBqavgEFhMB0xnQjxTm7c6XiGUj1ERsNj/6xzTSGUdaJxTz
         thQKSDDXCriwUzNhu9rlEWcclYxUfj0xy8p7ZKihAOMnMsKS+6ajYb02pqpZnyVJFWNir3hIzlGi
         vQgppJOGxBIFC6P8sanuLd3Eyt+GIttiw3sq4+T4nLCwkYv/E1+A8ycPS2Cz1+ZjBUuMlc/i4V+T
         lnTKTWLAhZzq/zKNaHGLDsYCMGcZKaGvT3QHF9ohTfiTSn82E2rL7i0QHyZIEMJaH0q7CmXozJk8
         Dtp26om5Zi5yLNB3XYU1nSKbO7VvgEOkriac3emTDIM9j/Hhu/rEbasEr8XLyIKH2dtg773AxoC2
         og+7zUlQ+MCOmlsGH/5XyTj+25+1P9G0PUV3FG1o8KTL66UZuaWDuyamDgzkw3W+BRT3lpasI0QR
         h6AMwN7rEHgwFNJJfmyKnN5Zs2xpZrbmhEdQSj0mOVdF90cMbbfTIt/V8CLYoFQkdslHIZSJo2RB
         Hoc/EooUXK5K6mF+Q9q0/3ertZ7306oBzqlelVy4BMBenVD4eQSTvfTkCseOG/41ueMHm3NpjHKK
         649NAtCK9ilg7lFDDBnh6b6/5tc3AC3P311EcSANotAhEE8Qis6J+a86v6mRyLz6hQOrBK6FncBV
         CR9gl+Sq7oMX0IcRH32nMpEa3lN58A5Zxf2bHsYAiMt1sDdZFMRU4UPWg8RP1ebonbYGKsKBowsY
         exST73kZqa0D/B2HQDAfMRZWU7oxixaL64sFwLkBxMkxE0hIxHgOVq2tSCgPg2F2h+H/D1KmoRMp
         3B5Mm79aD/RbESeXv4Ptb+LQ/GkgaS8Yl/Xx1pIqZb4+VWyGYx+W0T0e5dc3NAK7DwtJMr2+61zW
         6a1vzJug9q4sJThXRdlZyMvR/0ZAD8151yHXEoW3YY8C6SggArug==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     oder_chiou@realtek.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] ASoC: rt5665: add missed regulator_bulk_disable
Date:   Sun, 23 Jul 2023 15:07:31 +0800
X-OQ-MSGID: <20230723070731.6195-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call regulator_bulk_disable()

Add the missed call to fix it.

Fixes: 33ada14a26c8 ("ASoC: add rt5665 codec driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 sound/soc/codecs/rt5665.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 83c367af91da..de36cad8a559 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4756,6 +4756,13 @@ static void rt5665_calibrate_handler(struct work_struct *work)
 	rt5665_calibrate(rt5665);
 }
 
+static void rt5665_i2c_disable_regulators(void *data)
+{
+	struct rt5665_priv *rt5665 = data;
+
+	regulator_bulk_disable(ARRAY_SIZE(rt5665->supplies), rt5665->supplies);
+}
+
 static int rt5665_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5665_platform_data *pdata = dev_get_platdata(&i2c->dev);
@@ -4786,6 +4793,11 @@ static int rt5665_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&i2c->dev, rt5665_i2c_disable_regulators,
+			rt5665);
+	if (ret)
+		return ret;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(rt5665->supplies),
 				    rt5665->supplies);
 	if (ret != 0) {
-- 
2.41.0


