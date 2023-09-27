Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFFF7B0D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjI0U0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjI0U0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:26:22 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3039B121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1695846378; bh=hDLUWsH8joUkniff0C3Oe9ygMa4HUYwvyG5RfpCwNKk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dYgBHngpECMSoY3J0VqWvCvGpW0qLj7Yjqab69mXSqBv71dgAY/LF/paDiKcX3l/adKTRye4ric8zqbuw34ncYZuyXxM47TiMTJ6ES3Ym71qtluS1cPzxyqy1WdOE0kRqZD85uk6cmHVIkYfH/96hnxXD28v6FHOWJRwRCH1mUWtw1xftd4arbHnYEYB+1iwV2dxdAU5eIjg8qpnGKCIUwgrVFEPkE6vGfJ+DxmBwpmAUHuwJ0zxOAY7Hun6SruHfKSs5wvA9GBwjGaWPmR3RDWrKELybIPsGMbi90evEsVKSrMe5rAf1agJYMFqD4XTr+UjXRIMMuoVI2LSwe7Zzw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695846378; bh=t95m5vtyc+f4iBpd/P6oUkVMpieetX/nhdphSx07AfP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XOcoyTsgGBC7/VsOhKsFHYveUlGq6dDxhyEVsKCd4OHM+mofzLFSdFIkkXI+oW+mWkBIZ0DTiia9hto4ifmCvZBQuaRi1ozgJLyNMkYo9hqsaggYLUoIDMxK9kGYuYBXLak+hbGPdUkV0Z/UhZHWFOziTh4t+4fXPPad///HgATHIo4SY/PU95MdQdwHkTUspcUa3JZtrj1CVjQq08eYo3ZkP7bhVCDrByCTsCoibVkkL9XFoX36HX3dyqjc/chccY1hPuo7oEoadJ7JnHIEQErvP6GmzkeCwazar+8yX3Y2Yshb1k6bsLcq771R6MvQMfQTqLL7wARuuhZV1aBYeA==
X-YMail-OSG: zqPgAlMVM1kU6AbOKSVhjKhg_KR3wO76QoDwTYPxk83xyBiWjvmKBSHkVTsfe_D
 HcAix9mup_yIXleW8nsymEgkXr3f37Dfuo7M9.J_1oJS2O_QatbExH1bGcFLP8_RGb17yMSROtdv
 nOG5inpm24j5N8y0XnPqnVZDSUHOuHNWi5xNa4fmd6N8jjaiC5QWvHkPmdcHVdzh_Aj6ZT8Cofg4
 DRpQsAtp3usHC.JlftPsRpVPEwIA8ZSwTG3utNIO_pZ1wuKe98m_VvqUc9py0Ic2bWx8Y9zQw_Uw
 4sIQ6BILUCV0J05euqA4h2JDcnGhuYY0wpkK72vsAASaq2MlxPIlEg6KNKX.4fsAtGlUqSEimpE_
 MbKHEbSNl5Z_rFOnsXudASFDmjbQAiDnQyje1OItTVEt2coXu9CfYRCaUR9gsm9wDKoyj07i9tst
 eA1DqsGGnK4h7x66jhfVlwYu3lW628QYlwOSHGP95b1944Jo6PYxtq4AGE6hXKcjRPGcjJCu6dC9
 LDayAqJMfN8asflhTgEEx41T.KAJ_GxmXwGvAhdw2.nKlmx2sejwmgvrVOA9lTNq7ap2NTxZfhdD
 5RLeWa14Hx8JjdLXRHKTMI0RZlENmhFzM9cip1cL_DWqyYKSFmblVkqOGeosCFZkYSfkJX3bWDpu
 b9cB.tHKhZu2zoaZeK7tmLANkvd0CUgPnH4v99HlUmBvcCakkiPVydsoI2sc7K2dyAhmmBOJjrCN
 XjOc8.Dceydl.aQfX4taJOs3R9FD_FrCgL.H0rbFEJ.NBTy8_Zg.nXGhZxNTx5MqXl5eVnjXffeJ
 0oqHDr7xOamE2799GcgKAj_YyyqVkWLjkBrHndJkcz9hTKvMnn_szIEWCtzhYP3dURApsk5n_I3m
 CQ8arxBg5.B0hiNqTNt0HkT3s.NwS7jcaZZTM6BRJAEBzX_54ci86ljhYtaOGxY9KEvsUKMke.iH
 0dSG88HO04UvGsyUkxdLXdC98ibxmoXauyisl0_pRUoKbKytsZWxKjwsCl1h2BUh2gstiL4dQXAO
 oRj3j9s7nB7_SKs5i6mt8kGKJZvGCZChbgHMsUI3PL7mK43IpSyGHh4XU9bt3gBxlhm2ly1XqzPc
 mQvTg3.RewpTRT1.8zJmR1.SCE9hxDWZQwrDiYbaFBngpAw4OEx5b0FOr5mH7JyF9x_WiTShmhYn
 2feHIaxnqPFXkIHpzxgYl0ByegFHyWgIrbVR74qtY2BSaREXkGiqerre35sAq990qZxdZM..MFE5
 rJJxe4OPCbYiWcPYlh94HbTVqbne5EmNFR_tAtbXB.itJKEnrgbc3Oayj5dqPz9V53MXi5Rswflj
 53EOAkFgEJQRLix6Y50LnNmn4ZgENKpEBnA8kHTWZvbsq1oTRpdAQ8TPRoHaTl44j4htn9uBQ9eb
 gXY2aN5tQbrLbeZoVvyGF0gIWBdCK8gMm1edEGb5YhCBXatk0dj_wRua4hxFUb156uYOALfJrIsP
 67qaobjAnm677TTgUUTWh32sNNyJuOb7ODeeDpOL3emL1l_TiIW8KFCcMwke7SI2TR4ykYlj_5EQ
 m7sz8U6KXjrqBjW84STQ8eGjk_d84UD3pQVo4ofO7PC89K2fyZY3U_bx.0Cm0pnsEn6qExz7AC03
 SdDc2ZO.5k7beGqW_Cxy5nDG5ndzbm.JGOrolw5zqHt4MKv6EqJAYDUKYxgO8X5ng6GaSPwIDOmr
 Z1PiT7aq2MASospDf.6bkP60lgWpfDtqPim5fFwer3LPzQ90a7pVhkuoaJL5.y8XeI1sAhieVwjV
 JxOuG11SYnkk9BGgG2HaHStjobTGi2fkuG9J_ntceshxushyWHc74GwNbK2oKviVBj1AIxFv4vPY
 IU0_u_zGeJrito5wxu4g6Y3nBObJFWKTFirPPWEP4oEOAIKh2xWjSI9QeopirPgacN6UbnPFmttI
 jA9e0vtjNADxF2bJz0AqI4Sr2rZURIglrVP3Vjo1kFxgmsfrByzxByLYycpozIFfgaxOb3.Prrig
 XKSk9prSrHRqRiHvznbEjxk_LY5m5KmZEFANK4.CrgFSYqF5WTX44JfVOGgQtVQ8tY0_89p_JLGe
 qrhYuyouAL8lfg.A1VemMvgyLxlTSO0GZddSmXG9VhQDXb7hetZN0Pm6u1AGQONTwShRv4trh2.Q
 4xmuZuYkJz0zl9hFp_lLbGI4GXsH_vO6jm6pWp_95_nbDLMaX1U_zhqns4XU0c.70oNQ1bgjegAi
 cF0fbZPLl9HYVKzU.yIxd32wvAlQjIqgaoZT7jZ.99ov66ZxD1gn9bzrQmbZrpFW_apcikMpqDem
 s.pNey4DUYq4hjLphIrQCips1lIoZE.Q-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 69e5c1cf-7177-458f-94d7-9af5f35ebc00
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Wed, 27 Sep 2023 20:26:18 +0000
Received: by hermes--production-ir2-55db9d9d5-5hvhf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d998f486e26fd309cd8d11c694d3a2b;
          Wed, 27 Sep 2023 20:26:15 +0000 (UTC)
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
Subject: [PATCH 1/5] fixup for "power: Explicitly include correct DT includes"
Date:   Wed, 27 Sep 2023 22:25:58 +0200
Message-Id: <eccc91c670f6b7d851560ae4bebc6ea192befc9e.1695844349.git.jahau@rocketmail.com>
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

From: Stephen Rothwell <sfr@canb.auug.org.au>

interacting with commit

  12cc585f36b8 ("power: supply: rt5033_charger: Add cable detection and USB OTG supply")

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/power/supply/rt5033_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index c0c516f22c66..57a0dc631e85 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -8,6 +8,7 @@
 
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
-- 
2.39.2

