Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6549C7B0D56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjI0U01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjI0U0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:26:22 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E3126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1695846378; bh=bdJ4OqXlD/zeiVIdNwvA+dR0iZ/NGVosaVOt/mywBxw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=fgEizL9ArHtxqG93hXFLZidPFVGlw1kDhGy8Crt9nMeTWJ4Wqh0K6Sr68WJJVeApku1yQXSMWUMo0Tc/B0aoP3Q8T+e6kuHGqRMrHZh4UiHbe4Zkxpsdo+AqH379SKAy03RyDNGSzrjtTEMfYSo+pvL/rwBO7MWyL4iYT9AVWt5wFbiajd59vDl7VoyFRvkUni0A6/zWMcpAv0YnLwPBDb6TILTWAMDBs0XUhu4d75uaNQwbhTBm+/xKKYJP4nXC0O8efq9dFqpy4oFZyiPJXnYdYQmYU0TvZV4QukgPbdASonoaOvO057rYWIznyWsEY660ofUrI3o4AZCk2iYsWw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695846378; bh=b0hsLidCOJsdBCSFikF5eBukHXpMS3ifNeFQvkDOdEQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IHrOQkJZh3NvsmrCcNXJWM8DNgXq7zGabjI3kx00bccRUpRU/045BE0zyOsCFboYmjSwv0sUk8oBAZ9EwTqOdVLohwuquC+pVMlW/aorTINDUt5PGJ5zhGwzsL47+z+0qG5S8zTYXvg4cWQIHJEJePrji/5mRDOh/2QEsrTKEggcNedVMcHM0ga9IoAs7OAgop2UZESmZdL8bZUBXu4hhc1qu+mUZXDWWG5zhcg94JzvBWGzVFXG5MusK+OYLLBMBDvIiICj0RQOw6sK9xNpLuFZR4Qj3+vRyTBeNImzcJXXDtS8oN+oS0IFz2Hl35pYWrr2AWo344jKoDp3INEa3g==
X-YMail-OSG: fVpVq3kVM1n8F55FrA5unfAEMCO8W4W8CBLYsspe0FcmvMoKYYBDvABzE1P4G4u
 .cR0EJNUEfFHNIqJEwqfC5bdhtnJBT7GAqm.KXzEShU6i.6E4zgALABMyGgWvsglMKeZ8GfkVhqD
 Jq7h5dWgp1ktuqtjuvkP6VcRtAlKAu.n3aHFQ8ABfdYJXc9h4hPnUfhZCTEHCh.UH45Jwu4Rzobq
 YSytrucZcAAPHKgXvGwuLVEZUYOOZ0KTEuWw8D1k.W9f3gICvaqyu1aFwjZDi.Q4vBww0JwwzGyc
 4267pa1oVGRjrPFcFlijihCm5tj0iVtBFyH3.MAJ31OMMlQP8CQyrpy_V9BRoadAWalCtZ0qQEik
 UAZXT8xmQd6qyYyovxRYEuQezzZTD44Wt2dzxcAJgPUfU0SH3fvSnQ3ggEVsNcs5CRgf.G4DPSws
 i5AmgUw00xkiHKQ_qDj6btm8CqYWrPgCyDxWZRrzu94gjb4NBifzccdn.uNkd.VqaQ8SmiycIyeR
 3Bgg4WcCkN.6tfn_GKrjv1F1ISTASWiocK7RtlGSU3.AyvKyYKYOWezMwGjtMYP3NPLT5z.KU59O
 6oFm3yE7luUxWHb_rchiXhqoC69.qlM07NEILpWSvoujp26inK1TkrB0FoQ6bXr4ppka3S72d66v
 7Thasu8iDZgzmlusRujlSZh.lvCp4X130Y1.cHWxrzyJFSnzjWqArBjYGt27tox_Z1ghTMHrAxPK
 nIvNDE8oCOSGbY5OxsvTxWyhqFmDEmDW0PAp8TmkYXL20o89Orv9GdfezJoWz6EgTLDQA6ukKX6S
 .7jL5zzG5uMezxyc2aEaDsk7mFt5c377BsCucq3_Ru.isCr2DiBz9RqyThTLKQm6qvJpuXeTyx7K
 jkaUP.yGXVb88a5QVrPUbAllQDgvkzLvM0S_4Lglso09xrpjSFaqmlpIT5_EWxeJsHWdstLRt6Zi
 JbzeZOvmvehHp5zLPbgoXyMaou8HkpiWuJe7eHxOy0q6g_gZix5_KK6fh.Ubl008H7B0hnDx17n4
 ub77ULIwYvCxGaTyY8IrwIekYp3XnIEs.2AHDj_XU7rzJiDv0f3MVLtJmpeiZ7FxdflVvWL8fw8T
 X5Ep.DVT0PI3orvz7UTOjeqQgGQDfCI.udCcS5Y7S7dbf3vz5lPFxZJxtmwujexjr1tuMUvFNYDV
 5.L0oUWx04d9E1cbN5HxqkKd1h8ifsHKnw59bNsjfwL8MPYYGwrgX1eZ.4Whdmc6gaQp6MTojAvL
 dLY4jbY9B_Qm.OVDd4yM5eKk27lJokymWaoyL8C1r9BTqNSZnx.QR.fFjYzzUN0DCLT2zXCuG_dm
 Y.ziKrGq5juG.PXYbMVHauR3XvxD0II5S9l0n0WYjrvzMUqPftIuONubMmJHWRuycD364sV5g_.B
 JI0orq6hZiv8p5WE97AuUXmTRz7RESiFE1.zjJ0ZS02uF7KLQvz4N4gs56_dQaTcLvwMu3PJaZNo
 GvpHHMYCPfzing785m4Ms6oBuFMt3.qVmyueGs6rGIu4G0Or.r375Z8S8i7EEdy9HZEfg7yRvgXb
 8wWY1sYFP7kRc68IYfrKjNgUv7hDJRh8XiDgIBaX._6m0ASuF3EyWaySIl5TMdEEW0MCliSGU2iA
 XEp6AudPE_qwYtlyN0iwxjWPeYM2Z424I0Wj5oLTmrj5.9C7eSebDrJRWse1qO2A8zSmglP74LIF
 q4nuQJyRFxwrRUVdkWA81YuIWHgHeugZof6IXKeiT_.yMihyQpqY1RoYfItG94pSo.BWSMuvvnvF
 _bKctthhmX_zQ_pd_6STEySf6KL92k2rcKPUQmh0g88dKMUi6N9oQTdOD5Fa4lJPVmy0X7a7WiOE
 QAamrn.WiPdhErVnMaLlPuRXIKGjQ_q0i58KI0WhXPK79tqTZuHqptPe8f8gM6icisKctNaynZb4
 Eu0rIdhCuoJQ59e1wg4pRyz3ZZ7At5_9w6NdRNm4xZNaY9OxbFdSCPD95w_rL_.b2xMnykAMANmP
 sgIYRZrm2cYaLRL0W68_5lycIenKoMuQZmFPc3KC6B3pHR4YXaMO7nbpeWr8BeTgYthtSRAvVSdl
 iJfaiaF0T2I_LCgvv6j_Via.dI5h6PlInGQUoKCNjYs4Zf4k2_2K49L2X_1evZMBvuc.WBVyjeH7
 gkc.xKa07.9t4vUtm35fx.IIucY2chh_mWXtXjG2NIVyv91wHPIutOYxzOVWqCtcxnGpqk0YZtxR
 bQdVsUchOGCzmRk7vlSPiL9hUxRK3d8X0FbSMCt41utrF_ItU_fI9TJ46wVaB1Q9NmhvSNHgGQzQ
 W0Gwn3tUDS0I_6YY7PXHuqtgB3w--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 72a831c0-3dbf-4a57-bcad-7a3e35457f10
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Wed, 27 Sep 2023 20:26:18 +0000
Received: by hermes--production-ir2-55db9d9d5-5hvhf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d998f486e26fd309cd8d11c694d3a2b;
          Wed, 27 Sep 2023 20:26:14 +0000 (UTC)
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
Subject: [PATCH 0/5] Remaining patches for RT5033 charger
Date:   Wed, 27 Sep 2023 22:25:57 +0200
Message-Id: <cover.1695844349.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1695844349.git.jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series collects remaining patches for the RT5033 charger driver.

The patches are based on 6.6-rc1.

Mailing list links where the patches were taken from:
 - Patch 1
   https://lore.kernel.org/linux-next/20230821125741.3a2474d7@canb.auug.org.au
 - Patch 2
   https://lore.kernel.org/linux-pm/cover.1684182964.git.jahau@rocketmail.com/T/#m27164a05bbe2ec649be1fc32157b34ba814ff31f
 - Patch 3
   https://lore.kernel.org/linux-pm/20230822030207.644738-1-yangyingliang@huawei.com/T/#u
 - Patches 4 & 5
   https://lore.kernel.org/linux-pm/cover.1686948074.git.jahau@rocketmail.com/T/#u

Jakob Hauser (3):
  power: supply: rt5033_charger: Add cable detection and USB OTG supply
  power: supply: rt5033_charger: Simplify initialization of
    rt5033_charger_data
  power: supply: rt5033_charger: Replace "&pdev->dev" by "charger->dev"
    in probe

Stephen Rothwell (1):
  fixup for "power: Explicitly include correct DT includes"

Yang Yingliang (1):
  power: supply: rt5033_charger: fix missing unlock

 drivers/power/supply/rt5033_charger.c | 320 ++++++++++++++++++++++++--
 1 file changed, 299 insertions(+), 21 deletions(-)

-- 
2.39.2

