Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4437B0D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjI0U0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjI0U0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:26:24 -0400
Received: from sonic310-11.consmr.mail.ir2.yahoo.com (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7EE191
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1695846381; bh=MHEdXKWgThv2pqabF9UjOZv402c0QNNym8Ltis9HYLc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KtlM9VygzRqte/dQRO+OyuyoGTSOKva8KK4V5BmJ474ojShwI5sDtM6bNGgL3xafLxPYsl5l8zMwu+EzBnd0DInnciIqUme5ehQUDD1h0VXNpOUwUm2pwIaYEXtSIjCp0T9AcXE8EV+IYcagLqPKPO/m4FawfS1vu/jG4oUKFDSE5PtFdX53YxeIaP0vx8l4t/Xx4O5E3vhOuvdSrt5btQKVWkN/zFhQhTQ3CwnMjQcLT51tMl4xRy5zmE9DKLtiDLJZ3mGvW+V49iTazDyyMQSOjJ81T2IplL2y/NcWl3yhgmRri9jfmT0YsoNHgcch4Kn+B/aowa6XngnE/JTGTg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695846381; bh=GxxqXNJ3e+VasoBgp8213Nx40oGIR3iF/SRLCRRcjJc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CZFNb/T7RDBJLySO2VweXwkRYbcA0ygnhj4tjRhWrWKW++ADHYYBrWzDwnQDkpP/4B/S164WMdyhVu7AS0ypmL2HghnnAk+aloeyHMfJqy3yEpQzROIDSZPooIFp5jYF7XpL6zUDap7ftQ+PZl9+UWu0zHZNnMieiamIU/AJ7STqhXWQGoar3j3U3TeND+/jxd9RzqPZ1ihgif82PzxMVUY6pHBTF/CpnKVgouSGM/+ORDyAOghIKUxts/Jf7cI3vAoWsY+twGLLFrK+c1m9zN5NxJp7poLbX1xkE/fvx9GnkRByZPZJuFXetK3ir4c3zSJLVLN2Wp5ULh905YwxGQ==
X-YMail-OSG: gRNtRkAVM1mdRiJ2DbNxfji_aZtzpp4tAxj3aVUVOGXAjlOQwHGarDGdTx7LkW8
 fJVKZCZK367BEvGAMNS0Eaf44fHiI2PdHuD7g9eQ.l.7OL5FhQzhpHxfCPuh.RqPShb6oYS.sJPX
 jhdeYP4wlbDDm4.OahpYEIttkcc5ZKLsln0LsQIiWTWcaMIsdOVlVYmg2SXOpAqn6d9OiGp4UMcv
 pfqteo11V0NRAdCPP8y3Saorw6RdB9g2PB79WDvoh1mGttrPGngz9sKF5sgWsKM6p1J.njOOSrNl
 BplSrJSko6DRgezC6enMYBPlJuGSOJpWGkgB9cR.594D4cTUN1UsbSl2H5qywscn0LbGenex8piW
 jrzkgKmaMSPA64FA_xQqYPjEjIKb2HtFeCyI02fhBEZw8YvBA80uNIibKuX7b8t7oKkC34jWL5jK
 XKTTceyDtHVqYybaOwG0DUm5W7MS5.obmpAxpl31X28rzib0PfnLqtO6rTFD7ltVkOdFhkk9Et4t
 GiirAKHjhF0QUP8ZOzq192Ipjde.F3OaG46D7tWQGvvmgd7V04KlI.CJFRLNUdWc7gRSolzd1BOd
 Sg6j6vs9xjQBN4l_GusAY_jtPhUpwyt5pGhCeREOk78k9zi8.SmlXaDnWsV_BKXNcDRAFgYepXgk
 KoRWkF_t8qiF_2BVuuEIuuBOBdzl7Q7vbLbXUJzgeJFp0hfmObLqgW5LYlCwZw9cIMTm_mmtVTKx
 .CgWe16kmGxL2fXqpi6zs71kqIPRDbuNIVO.D1SynGsQ6tPwVhE1DcSgR92vxiNR4g97Vs9dBUb2
 zjJp325oO0CpJFakbloK3SIGprsj1WbxWSnWh1f1eeiS5WOYt89bMjOREAKYL5vu5hprex4S_TrW
 SXMboTVzbYQJKhKDNfAUebWz_.MS5Gj1.53uFh5iSNbb8pyKyOSnHoV6CytB_4dtWPjtTwunz6LN
 Au_8ZlktSUMxv9tr8MQcJgesDSPSg.scqlcCedFiOYSD.m2BvVaITgruXU8NubcAYSsVUMiyrhnn
 krlrRcwJ19TX8xIuEB4cehsRKOg9CRUkkf0KOA6s0iM9Jt.VzeHmJMml2PN9pcb8JwsR_ihtlm2K
 SV2Yif8mxRimtF1jH2yYOvc3M5K8PtAvM93eVhWUar3M7.u8KZpifQaRMrqSB6Gl0Ca2.jeA8jHx
 0eqzAErvfWIeEGy24KzpTPvT048ekJqXgO0ytv6R1OtnpvsuP8LqOrN7jL0Hyhvtfhes5VRfLzUK
 cxDMlBDOt31ybRNXGVoLoBwcstxXoixRi8z3OfuTNCgp0ce3g6lNFRrYvKI_3C7N7th_X5FURsDn
 4KCT.pXo7_tHhDePdMT5MSIfAKgr6sDoTTTsXlgT2p.AWjdnrphe9fLLuS1RI.lHzkbNwmqBJZDE
 4gat2nU0v90tKa4eLwxE2W3PUdlHL1QpwPLskUGZ_0UDlDz7pfWBznnbaF1Ct6jnVgOww_KzFPzf
 Uu5Brb69Xa3iI0086XxU1uHnmGA3QUWH0hkwgWL0ui4VxjZ4EB5.vL0HLYnjdbD7OVH5dmJnz5pL
 B_fQlgXKpndYuAVhbp.OfhwrloFk.QNS3uUMvoY1OCo43Loz8bkOzQPdIH_Lu2h7ZfSjTnm6pi34
 DDAoHu5UmoJuY5ar_MrdCQqU0oKVy6c8AMD4idPgBj8pJ7jEDbIxtKoz5MvajQcvTexRHu95JnY2
 b.37sL32iaxrI7PueHrflHSxyHShk9KHR44q2nSL8C30X59zsQYl5VQMHNSI_J_L1JFx65C.NZg_
 _tQEu7ND1cgqZbrmPHo4NHouyVnEPp.qnfLrXuBBOxAi8XIvMUR4bY9wfhPWxVPF8FFsDT6wKTuz
 zz7ElOubEgvYFIvPFUcmHeMeF56lpuUkmfVBSg1FbPXjptRlHstmsI4Xr_W6NHkHwqf1q1H71v8Y
 nXMnK7W3YObVNJvfYodbLwHINOgcKbpI5XEZFAcdM1dhGBXOl4_AMBNDqzexdwb7tlyrz0U1QQnV
 ZYCFZqgdhuys7.KZO7g_Eah99N5e5ZsO9W__bvIXYTDKZlwR8ALUh6iRAAQ02U1022O0HniDoDNM
 8kIb602eogZ.tMtQppStH_A9Uz2JwWp2pbxtdC6ajVAO0iriwm11NPOK_KN87K9Ogx.27o.oRr2M
 6KZPflqJPWvVdeUf3PfpCGhz3Hh6UOLp7UZtoN4EIiCmTLQ4EhV40w2lZZq3mweLJq0lQeB__lz_
 Fm3fJ8LVzCEIZij7ez3od5FG.Jx_JH4fljSJ33cOY57rtOquOsfLD.R6Zl7rZe0SZbi89jIHFRWr
 AwkynY200zX57HwoNnN6rKNccxyVU7ozRc98D
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 394b8963-67df-4bea-8323-7de61cddd7a8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Wed, 27 Sep 2023 20:26:21 +0000
Received: by hermes--production-ir2-55db9d9d5-5hvhf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d998f486e26fd309cd8d11c694d3a2b;
          Wed, 27 Sep 2023 20:26:19 +0000 (UTC)
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
Subject: [PATCH 5/5] power: supply: rt5033_charger: Replace "&pdev->dev" by "charger->dev" in probe
Date:   Wed, 27 Sep 2023 22:26:02 +0200
Message-Id: <deee3469d9a6581b05f0a8dac4e2192f9d96c8c4.1695844349.git.jahau@rocketmail.com>
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

