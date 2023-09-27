Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E10D7B0D53
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjI0U0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjI0U0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:26:22 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A29136
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1695846378; bh=hS9XRL4UjV0H2cpjxdGbKe5r7XpEbOe3UCWMjzVSxnQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CaNAj+cCuGb6YyJQlBRadGA9ofythS8P1VjyawDuhrmlK2WHuqE0kGl/NE50+lR6j1SW7IlDdUj0cvLgOCVi5MtT9mjG/MJGIDR1Yfyk1MEb5K3lmwF08yx6THd4O3vfIXYnlGqqj2NBP8wv6WhjE1UEpHcGlq0EfEgvF/e3HMt/CFyjtEoCndmjASButUyC2yDudRBhsUC++4f9amR19Vm2XmCCcsl8MUFbaG5rhOZvZdBq61MX9aFawsSwwlNml4s0ozwg6TQzCPwGJG3e9255W5KdPrNOAzPXK9dNMyUYgfHwv+GIl7A19wRUSgVfodRqSILDoo2tvBI0vTkpeQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695846378; bh=t/vll2PBhzBw/8NYoeZg9NA6vDIZhTGXTDI9AT675Mi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fTyshhS1q/k6oIcAZhXqs804VMSQSfQyxU+AY74cKsl++uy71VrMXrhgaq6zD+pWJuJMBsS9iF97oXo9hRaoeeBLjlP2Y30i3KZGc/j0XXps0RmNXHB9O5MYjPLw7xxOKUexDuvMoRIN4AQnJz7gdPFvJa42jsjYhzXf3AhBHCYfwOLafsZgO03Pi+9io6/0IeE9iDDDVvij2na5WZc2rlbgvJn3Dxnym+2ZlrVeX8/faPyLnIBvJiS4lGG3ATY2NVdrJHOpuyOT3CwJJWA00VMauDPiSpL0n7956nw/AEnZbRSGHoNIhdXkHn7t/3Ybs+WARu5oArwn9d/d3Nrt5Q==
X-YMail-OSG: _nsoIn8VM1kOsSRaPAUiVcczyE53v_u81cS_14xp6hERYTppEVgojnH3BoyqTeN
 zsS7oHQQD7ujh.gLBQ6Ds2GrdnbyOc28k4OScDC72RerMwbQoKKdgSm4NOFQKOMpHLXnVxW8z0id
 tvuBnsGZ.ufkRqCpMRTh5UoCwGOK9nqFa1xlv.1htsuHIyytxGqfgl57YEzYw68toTKHumVK57ub
 cumkk0Lsmdt.MAVEavtgSbY8qmOKnMV81SwCLaqTygonLe6rpeUS2pV2xw4wD74ajCLwsHbGY48f
 ZiycaY6n1EPu4YnHSfPcfegv2y7vEom6cxBELcBMv0ndKLEC4VUnkOVq54sS7h3j65OyCxJnsiuc
 noS_fDWswLXvo7kGsB0iMScJxuE4iCOe22Apj9uP1ZlOn9IcXYHHukR8..nZoX7jarsLUcz.ziG9
 oJNHUHXMrX06xBMTJ1GsJRL2JdybGIZywlOlqHo_GamJ2.1Ge95h6Pu7IJVVCcggTJ0Q4avqSGWk
 PpNtvYdu5eu3hCHThDpe5PyV41374eOOyHmp8BeD6pYYpakuBxChOW2EA.1bPNgKskqg9JtbSFMQ
 wI3.jZ9kyqP186xecKhF12B8H4qMW7BerNPiyk.Jyw2IQFI4UgPB5T3Om.qBJE7pp3UPckYsNcw0
 yTpdTIKOWbrxhfXjsl9ysnJhqaU8Khfu5kBC_VRaYDmji_Z1bLxszIssHmC2fZNXA7BaiKKGmd9w
 q4B.5SBuLpxt51ZVSTTx66.4VjEReUJ_aZq5rYBRapRFzy2tjgXDvUEwtZcR4khZWzuFBy1z89G5
 oCcNu3_UdTxTEOexNY_9rGO1thcx_adboXXZ2tsrGYos_W2QdOe6kn4aVZCvTP36r87DiutrXAr.
 IGWuEjp3Pec2UM3zVFh3gwkGGfNVBzedxDylSTePEmKhwJwRRfwfBG0LOqKyqm4UURY4NmAqmpPz
 rvcbN8ksR2bYFMdDXVtarxk3VzYKlxHVbiW1TSAWVxsEQZxXQtUSIItTw3JH3YSFY90FHr0Dh84X
 Zp5_LtQtzYHWxLW3j9lhTFbA_6L.zTKQHZQBBdUWZSFmar1zeUiC0ittgnIYbZHj8Pp_WISkXGGi
 sqVFeB2Vq72yYTxdvpaXlxjKJq5Hwwa9h.P4eGVFX0FfZRxhMkdR.mB4_GiO.7GILKcIS0VXDTI6
 Ze_CbjS..czcyRVIo.RPY9mEDv2.Rct4FmRMA0qO5f96S9fbduyngjXz6279qWmiQAlzNXVOrkxZ
 0yTXWv1NgYb9Zv6BtVdTPoW2AOz5a.1qkP.5_4cWfMdakUEFlSUFItX6fsvzQn5NcmHa0himOZZ0
 FqJYXRJ_p7eKpJeSnq4ooA9CoRjGbZLHulMTqmDDKJtZIKHAYZLQxaGtxny5haNWG0a9WTi3I6gv
 XSZN9Yao.XCTLRaaaI9n__ieZXTukCjVsPsroaNzyGi_3s1yuBJu7prUa7rWijce.r3ssyQUvefa
 TTksggQY8om9UkSaw4UDnSn3tHxLdBStMgjvsXUBOsfvLFNX573DFBB467fa95Dm0qRpJ6RGItob
 K2kbbpJRqdRNbkxw2XX0ACaMm8nqGBY3bI51xv_O5pDjqNRf4jQe.5L.3QomPUIbJLDAPRzimIXM
 VGvtfTjElOMOSWIJw2ksDmmxQTibnTCCDLRAcTNwHXs_1NZYicnUrJN7m_2cTG1Ds_1648OX.CqB
 u71msiTGJdUa0KQ0f8Kf6p6qkM0ZmG1M5.lLizJlsQVq3.b5_tRODl9Q5_HmO31U3aqhlKdp9HaK
 VtZ7wPzmoLfElNoY3SHKnQ6sVCsxsW2uxoXHrSD9pXOA6GRmBHXwArd9VCIsvLPn0bdqXmSOBDTd
 JpcU2A_ZWSW8sSz7cpHK20ganKGcZheuoL5KskDndSlukPGW8zDGInXOF9TDp3H8M.z3tnIOS9I0
 64NLEmgNfh_3u_LpdOObLC8kJtahSnOjMXuv_gT0B4U5H6tWKAMHNzKADFAFFPhnD64wkFVVjAoo
 XqOmpBuN9eHLhe2T0MT.190F_OFw2xkKiEDGJM0pS9K4UJBhl_d33cTx9N.qSTT44od12mY_j9k7
 eUn7clBafHMGXgjVk9z8a3ARI5hQluBI_VkM67bsGK9CpX2tYPP1_qm.YMPHIxS2cwhSNQHX4s7V
 0zjJ6NexmEKS7j92kID9N2QdqxzE_qgA2G_9WHd3gLOj1GA8ae.wZSJwxuRqJzEysr9zOlCIwS89
 CeiXtAkRoxQJoJlW7UytSdCuI1G.S9dLgMc8XUzzuSCJfLyJnQHJuu4YhnqzfyFNMboYA9mnnR3Z
 tCuESas4vpouU2OHQoERySZRC0riMd_E-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: b130448e-4358-44c0-b48a-0e54654458f6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Wed, 27 Sep 2023 20:26:18 +0000
Received: by hermes--production-ir2-55db9d9d5-5hvhf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d998f486e26fd309cd8d11c694d3a2b;
          Wed, 27 Sep 2023 20:26:17 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 3/5] power: supply: rt5033_charger: fix missing unlock
Date:   Wed, 27 Sep 2023 22:26:00 +0200
Message-Id: <e437e728317b6a2a860f7812f64a98146a27965e.1695844349.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1695844349.git.jahau@rocketmail.com>
References: <cover.1695844349.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

Fix missing mutex_unlock() in some error path.

Fixes: 12cc585f36b8 ("power: supply: rt5033_charger: Add cable detection and USB OTG supply")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/power/supply/rt5033_charger.c | 28 ++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 2c2073b8979d..091ca4a21f29 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -361,7 +361,8 @@ static int rt5033_charger_set_otg(struct rt5033_charger *charger)
 			0x37 << RT5033_CHGCTRL2_CV_SHIFT);
 	if (ret) {
 		dev_err(charger->dev, "Failed set OTG boost v_out\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	/* Set operation mode to OTG */
@@ -369,7 +370,8 @@ static int rt5033_charger_set_otg(struct rt5033_charger *charger)
 			RT5033_CHGCTRL1_MODE_MASK, RT5033_BOOST_MODE);
 	if (ret) {
 		dev_err(charger->dev, "Failed to update OTG mode.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	/* In case someone switched from charging to OTG directly */
@@ -378,9 +380,10 @@ static int rt5033_charger_set_otg(struct rt5033_charger *charger)
 
 	charger->otg = true;
 
+out_unlock:
 	mutex_unlock(&charger->lock);
 
-	return 0;
+	return ret;
 }
 
 static int rt5033_charger_unset_otg(struct rt5033_charger *charger)
@@ -420,8 +423,10 @@ static int rt5033_charger_set_charging(struct rt5033_charger *charger)
 	/* In case someone switched from OTG to charging directly */
 	if (charger->otg) {
 		ret = rt5033_charger_unset_otg(charger);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&charger->lock);
 			return -EINVAL;
+		}
 	}
 
 	charger->online = true;
@@ -448,6 +453,7 @@ static int rt5033_charger_set_mivr(struct rt5033_charger *charger)
 			RT5033_CHGCTRL4_MIVR_MASK, RT5033_CHARGER_MIVR_4600MV);
 	if (ret) {
 		dev_err(charger->dev, "Failed to set MIVR level.\n");
+		mutex_unlock(&charger->lock);
 		return -EINVAL;
 	}
 
@@ -463,7 +469,7 @@ static int rt5033_charger_set_mivr(struct rt5033_charger *charger)
 
 static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
 {
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&charger->lock);
 
@@ -475,7 +481,8 @@ static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
 				RT5033_CHARGER_MIVR_DISABLE);
 		if (ret) {
 			dev_err(charger->dev, "Failed to disable MIVR.\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out_unlock;
 		}
 
 		charger->mivr_enabled = false;
@@ -483,16 +490,19 @@ static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
 
 	if (charger->otg) {
 		ret = rt5033_charger_unset_otg(charger);
-		if (ret)
-			return -EINVAL;
+		if (ret) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
 	}
 
 	if (charger->online)
 		charger->online = false;
 
+out_unlock:
 	mutex_unlock(&charger->lock);
 
-	return 0;
+	return ret;
 }
 
 static enum power_supply_property rt5033_charger_props[] = {
-- 
2.39.2

