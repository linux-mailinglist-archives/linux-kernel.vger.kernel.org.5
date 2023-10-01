Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6817B4796
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjJANSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjJANSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:18:05 -0400
Received: from sonic313-20.consmr.mail.ir2.yahoo.com (sonic313-20.consmr.mail.ir2.yahoo.com [77.238.179.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678ADD9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1696166280; bh=MHEdXKWgThv2pqabF9UjOZv402c0QNNym8Ltis9HYLc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=km7J2LHQYmud1FCYexf626JMxhdSkO7ua49RJKz0npDMBGBJ+1OZYx9fGRHwYOuSmD0YjWq1juCebqNsxnB7/5pTcaBgtjLsCNPZYhYXO7FssDuOj31xWgySQRuAR0WOuqHrnpv+WIc+Udd55ryr4JjaYkrfFXXc9UNiUZBoyUqLq8UtVq6V0cdTb2hbwtLWV3qfsVBXuLpYqKw4KpCAoO8rWHF2lF9mfxh7fjE9/f8k6ynDbtxWWsfvvM6QV6drbfi9QdgJNdWIvOzZKe0ng81rO1KTTeYteJcFiQiYGNYC0KgqnOJSfMUTKqxHHJprFQo8PRQBNMoQmRQ5hAKflg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696166280; bh=kNcZemSUi2+D3ss30APZIzYpXe0nI8JV+0reMuCszb6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=P+CmfwN9eWi0ZfMtCT6UhI5RZCCPTzRQdhKCsqsN3gVXw63jRr1GqAvVGOekaFYE6fKTXwmOAgvMRE/ceSDn0CSVBP4ZxaP/NabbH47RSkhPMhHfyKEJFLWp3SEkCxZVla0nvUgWVea78l9gKthwhDB8wBqUErJWZpw1K2MbQNiQ8JgKn/4KMxf+/3gjQUWmubtXG/LvB9k6LxFEvk+hUOb54qEXEhjrPkH6TIqwjw/F0wyCthDxOie/5KnJZGr+Sstu3ogufamhefIOZF6qSF9lpXAfL9KCV0UXPOUw88wzo2NIBSGv3PiRP9EKQTOiwT11dke+JV93RYkHgBVb9g==
X-YMail-OSG: PbjKa6IVM1nLcUHMCw5fdBh00sXRSXNi0tdAj.fUDoOq3LT8A9oXKlyRPKvaYBY
 ktsz4PU61LJIpOfkeh66N9GjT7gkz3Kt6AF02mQ2ZIcqnOgCULjx10ryntIL7rVuqPoHJhS.cf9x
 Ido6tOjyqKLhOb5xZO1Bi0Q4VWwIGZfHLBwE7nmU_DuxFwb4VjPdwMHuiEgUpAs2QCKUHjmM5Hyp
 9yYsLpOXDTLze7iXgl4U9WSxyFktsG6jVxRJQR4cEA15XH54gIMtWjETvlEIF6hrbypsdpxXbfT9
 AYNRhDhpVs23mL6VXqswEi0zkD39VGZwhmK_uJZ349eCXdxTK2ZwdC6Od8kWML1o8mINEUtw6VRE
 Q7YqU1V8uw4MsaNQ0djyuyUeScval0XFYVRTr4xQsleMcKL3_Lb3tCmM0P85chiK8DkAWc.RnO5w
 r6r.Q.IEGp0taDcGn7yPC68shkQea5EIjrZlsliNpz51vTK9OwCK2gii90nhli1bv6p_IiAmZRbI
 TqVelVTi7xklvhHiYd4Cg9U9nUE3xTQMXpyETPBdDCClVa8I1m5J37MeVWpydB.DXrctbBexGpC.
 dXbB1.E.cBXGYW2A0rjB8W12Fm6HORco6IBvCqnl6IqgauAeopa.ASCVRxGA3_ifEyM9mQPryA2Z
 z4Wp8bA.J2pqr_d02fPiwUOFqIiLlwhMFHPlAzQRyGAV_RO3ovKPM4Qx1O1LG1Lv9Y3VcJSNUktR
 fFN..Kbv2WzVRVwelfET3DJwSuSX1cB6d1l3RzXGUALVVQ6soq9dhC25LeevizOPYQAgKU9pwjpc
 PvuMe3IMgGrvqgrMXDhWo83j03w7wJu9bgrhLBYCkIeMHrUFins1..qMDjLQ7WBvnROVVCrsp1j7
 hVwOnKH1Xd0CF7FGQW.ROr2pQT3KAO_h8zPpSGn29S_5pjnjCTbunmEnQh7Wmv8FnnAUMzlzzUyN
 CRB.yA4AlUOdfsNw1SMj321agkAFXMl5tz6QDyNPo95.D3FBSlQueulqfnFrKCRDkeJ_2wHrXILz
 UBl20X5BrG.ad1YCua6mJsXjnqCbXnybhJBn91.yNfmJYmlPUxSUhlTZLaSUdAVM99MQiV6T_o.Z
 9OIHCOisCiz4MKqtNC.4HqMCwEPCPEN0Nkf39GDSBrPeh.c1l3sUwYgn4j4HwLmLp7ZN.1FW4puH
 gItwS200ePjS9r6HWdJxfhSVaOK5MfcB4HcCdpRdSegOb2d2rWgV41OPVnmmOuDP5Bfw2fh.QZQl
 _yrpPB.uKE8MR7KUYh3CjTeNIeX.7JKKl2TAtBrzohT72fvLAtWdtW1APZSrorB6oHV9aqnqEWns
 l5x.ANiP8bIkikU.j7EwsGZ.7qR2UgTi2w_rt8_IsFGDqchbAY737Awqj.TEdVunmqDh0NZ7flQw
 VAXDYqnwYTHPAv.M.0mdZDKGz.wysBOIGuCr1.HD4YilDS8bEP5WtgYnyR7p9UE147P5raNrXVj4
 1K69SeaGwd2QFq.Z2BWyWAyJ_4v0mjVQHFnMP2I6CElNhDMGqF_R8Z8o6IXVvINqW90yzrer9u3t
 nuDr_rHhNvDMAHdhzlc4I2j3FpkpnZz2YdBsorqbDkx4mWwdmH1FYJpQtLBnpCgoWydFPTxExUTC
 oQUY9AxWgs3wjcovWIoU7nmTqzaS6URk2MfVoUX.5kmhcoKSWEDNjl9JC4DKD30h5GVxn4IxO2zo
 SFgnIje1INW83JYfCpqggv9lKay1dzbAM8clKJrrMItmEQD5cfoxbXdPHJtVqh5mOnksiU.pIXrW
 rmANCEmEAEkRdmThTc4C5Yxjm8wPUlYiyubTO97SxVOvlgK2aPXCBOuiDW0rm03qoNttRfMgmBDJ
 QXtzK0UscXhqDVW1z_FvbIVkD6U1OMzjAdHYLKL5WiKbwbApJaDh1zFzD3i9SzSOwokg.syerNKp
 uoCrpi01SB6S8W88YqtlGIh8IEbb_56_Tdz7pU_mFpd1ouxt6LOYe7ZeL2W.VrXPqESVGNzpc2ut
 ZUXU_8L5xcjLSiorvrUMq0Da1B22tY2bv_L0LmO.T2E6towHok6qzSdvy2B5zfMrYYoJZo5aoUKo
 r8sz3gY5lcksVM3QPwfal.Y47o.B62zx4eqQqmNstloHqjq4lDUhkEkD_bZbTsjYT4v3VN5oyJMk
 zENtHuD0sU62b.BEntu_T2aHzhBLlbipBn4dLR6y7MRAbZ9R.Vi5sNwUsF6NPkseSWD._WN_OBwO
 PTOzo3ADjg_j6kqkBVDU3cloVtSWPqWJFXbijLMW.bkeorevp6uVzB1j9PU1jCf_FFL5Gkl4Qz94
 18eUuO8My87lx_YpAWfPAKvV2lIMYmA--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: f973a497-d7a0-461c-8257-f90b4180dbcd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Sun, 1 Oct 2023 13:18:00 +0000
Received: by hermes--production-ir2-55db9d9d5-gk4f2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1c2828dd5bee1de58f8566f5b57afb9;
          Sun, 01 Oct 2023 13:17:59 +0000 (UTC)
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
Subject: [PATCH v2 3/3] power: supply: rt5033_charger: Replace "&pdev->dev" by "charger->dev" in probe
Date:   Sun,  1 Oct 2023 15:17:44 +0200
Message-Id: <39b4f00e010446e453905c8dc3ca1e47e9f2c5f8.1696165240.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696165240.git.jahau@rocketmail.com>
References: <cover.1696165240.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the beginning of the probe function, "charger->dev" is set equal to
"&pdev->dev". Therefore it's more clear to subsequently use "charger->dev"
instead of "&pdev->dev".

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/power/supply/rt5033_charger.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index b34ef0ea6f8a..d19c7e80a92a 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -678,11 +678,11 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = charger;
 
-	charger->psy = devm_power_supply_register(&pdev->dev,
+	charger->psy = devm_power_supply_register(charger->dev,
 						  &rt5033_charger_desc,
 						  &psy_cfg);
 	if (IS_ERR(charger->psy))
-		return dev_err_probe(&pdev->dev, PTR_ERR(charger->psy),
+		return dev_err_probe(charger->dev, PTR_ERR(charger->psy),
 				     "Failed to register power supply\n");
 
 	ret = rt5033_charger_dt_init(charger);
@@ -701,22 +701,22 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	np_edev = of_get_parent(np_conn);
 	charger->edev = extcon_find_edev_by_node(np_edev);
 	if (IS_ERR(charger->edev)) {
-		dev_warn(&pdev->dev, "no extcon device found in device-tree\n");
+		dev_warn(charger->dev, "no extcon device found in device-tree\n");
 		goto out;
 	}
 
-	ret = devm_work_autocancel(&pdev->dev, &charger->extcon_work,
+	ret = devm_work_autocancel(charger->dev, &charger->extcon_work,
 				   rt5033_charger_extcon_work);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize extcon work\n");
+		dev_err(charger->dev, "failed to initialize extcon work\n");
 		return ret;
 	}
 
 	charger->extcon_nb.notifier_call = rt5033_charger_extcon_notifier;
-	ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
+	ret = devm_extcon_register_notifier_all(charger->dev, charger->edev,
 						&charger->extcon_nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register extcon notifier\n");
+		dev_err(charger->dev, "failed to register extcon notifier\n");
 		return ret;
 	}
 out:
-- 
2.39.2

