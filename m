Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1A7B4797
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjJANSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjJANSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:18:05 -0400
Received: from sonic311-30.consmr.mail.ir2.yahoo.com (sonic311-30.consmr.mail.ir2.yahoo.com [77.238.176.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB35C6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1696166280; bh=kNrx2gSsDcIRy0/jUMhx14yk2GcQW+d/YuI+hbflL44=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=ivdMzMmksKqkVBOPJtaf2qg27MbF194EN65foLJjObHSsbIHT+TZSPPr7Rj6b19vuLInCO2chf/YlX7m+uORURCqeXnmAk3pmvmftjMs8N/S/xPV5WSR43UI5Fjn+0sRPf5B1n1/8K+l/hCjcxLqCu2rr+QMQydUPp9lcHn0tEfmO70winp+OuEDaFFRIV1/Pslf1ouGzqYqQ4wCO4krhQP0EfiMRHy41izmuukKhFLWuUJWngUotIw4JmbVlmKyMuGhjoSkr9pbw8Hv3eqyJBdeuf6P+EzXnOWm7TdlJ9FmMKXzPXwR4OzbfyxaBzDHQfzmc7l6Hk792rViYef2VA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696166280; bh=gGSrZcH0TzgQp6Bu3ZNTwMT8hibJ/uSGMjflmD8yLAE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BldcmYrOJy6iwHzfj3jCyou2/ga6yo+pl14po2Z/+01mYoN/1PBFTVHCfPyuY0oPrFY3TCCwkfeeIfAxpbSt6t9DNBiEMqTX6kY4HHeH98qsUSCuEQEuq7QjQXIqpOz1cpJyzdDTF5QfBMEHVyXTcLfZlq2d7o/iYw0ndYgnvfljsBJFa/8yQ8MTImy1eh6slnnntiHWH9D5OTIzGgl0C+L5g3Sgm2MbrOVD6MtYsxEsJGMKI3rr5ftJIxn/fVSAXUyPjrUyFGgx7QQCiTnwiJRJhiZtpPtx7Ha96ILs1OtGpGLq2QRoGuaaJAxPLEpdVb0kGaxLHKKjl3dw9Zv0Yg==
X-YMail-OSG: _IApiQ0VM1kLZ5bDrJwQnZgoFwCRjbGuXSJQuCbZoK6vMeF1q2qIMzEZ3b_XZPu
 rPu8_2pv76ZLMyv9aIAfQVpEAnLMLTMyLmGmmsAEYkYPTqHWunC5Tqu_CqSuVz7FOrjjbSxz8ntY
 qe123CJLpU4_BH_F_7xwrUZ9izP8nG22ME8vm9S3mPX8diyr_PjS50B5QISerFdRuDn.jKOi_Wc8
 RiQ1AqcVmqD5a1xMt8hqsq.wS6MLH9MF5ly2WiZofwhImT7PrORlerv6StppebGEEvd25zTkj52n
 k55S0EBLN3kok6xRGiteZ4DSpNki_HCujSAjXPEtmHmTbBPYakq6Ze0cipCrngcFIF69TqR.1x.y
 6WgkpDlH4DhTbzDdzg1bIm1ABH9C9XXI.w1QF3UO04xFkMhWl9SPVsvwJbOE.BGF2x2224Woga1D
 ySOvqjseuZRDHpezPSy3gS4smHspk4O9cQHQD_vVeACh7avv6JMF2geYUIIkp1rcDut5CdQXKqXB
 dCujSS8RPodK5lP7r5AKcoAAc2MNiHTWnYSR4s.jBS1_NUPT48gkXPdKagnuuLuVM7vpvtn6glxr
 lsew.nAuOWNDvG145cPnGUdYuHgLDcL.4vQfpZq6ITmAKRwklfrr_xM1rPyjRvhPeNqeTHwn._gJ
 zThPWZXfel0w9LisWbrUO4gRS9RaGV8I0TW8E6nYNlHPcMDAtLSCgbplcZGgp2vrXfojeYk20Vf5
 IuJ5L0ln3vMrnmJJqtK_3OyOlgelXX_pF_FH6l06A42v7AaNuWoL97x2SJRUPTBynlOHzrNmz4LI
 mJuz7aRwBnp7vZFzcb4_RwbrkSgap6U2VmHoGS8XC02yfpuONfYGGU7iNbWluhmzQG1mt14NnUQl
 UehKThmVXxXehXfzZFCQfziYqKAMiQ7AlaqDtLZx4EWRCDM.pSnXcHFAecfQy0x__ei9H3iZbw0h
 _MN4hatiuBdmLyQ0is3zXXHhAiFOpy95VdP0CNzGFSNCrNdv.2quX9G8ENeC_65Tx3KGAi0quLhm
 8e.RUVAw89w_uEy5iqlL3XwYSa.bEI71gygvjrSVJpVlqEX3bhuHU_MpSTyY9BsDfhkTWOoCE1k3
 Hh688YQhimXqeLWgUuOi_iR8KnaJP835IzHRjzyAMql0V.OKmKW5kcUPYLir3GLl5YWJ0agsuB69
 6x2DJh4v8BEyXLDrwq5ernvna92l8rM9euVx1hXiceXqm.I2LqjkIwT5xp.gz0ty2Pc4gtDL3Xrc
 stJH2A_65To5vn45P24FC1EJONsrz6eXnPSv9KNkZL9VX.KcnuC6iSFN0XXMG3oHblUHUlX.Xc7c
 JJwkobz7nNWiUuEvIciQf3eIQMezDdN4zNpjuszrVn36KuKIJ7MaNV9NrFt0beXkOqZEtRZrTiae
 LJ09G4Gj3I6KheSpANjiR89DdGOrFXCsg2uyX.ohm8EQcj72D5FmZdrrbeCkV4nN83SJy_dbhMKU
 .pnQaXeG_X04zv9GlPRVPa9Ltz4YEXf8IWXp5LDDw_kYBPdF9Tm3vMYK9CjScH4WySrN8u10cviq
 A_KHBPdFzHJqz8POVNTyaMw87AKbDUOupSlj_MuOVn_LkCDGODwb.s1eeVT3H3tQXm5dZ4TUKYS9
 7XWBscKiqRk.kDLOt8dEL0UxAwn_hBXnWKj1YAOySBTUSfShq5UlBvnIi3P3YYnCoWbSqAmcIWFM
 DtZB1m6ypvkqskLcLI.PY9MZZqFuXjpPVGlk6V72PIckznn.gAtLi65dxA91jzyxwETBSqgL73D1
 3RuRXZUVPfw5v16Icnorwh21Gw2P3EDVtEEPjhwfd__9ESyK2720z_YsCo_WnlZ1IGVS4B3d4prh
 z4M0rRjy2hMrHefT4k6XrUzVlei5okfAwlUbD_vEIpsGVZIUNcBzepg7.qnE.gNHX2p2GqVHAglI
 hJelwMF033Pc8bR1Pz5Nv8oRo6g9Rc1XVtLIkgMpPD9nm0cBPcRbFv.X1Hz8Bn2IcpQat.cc6C8f
 iXX2.QCPU8CcXH.XfGVPMixNOAtW1L8Ni2EC6O8MM7GoUn75JyvkZ7bW60kqRr84HjJqQ6kkPNBS
 cjv4eT1Xrzc85YwrvyYZpzvWOPOomzwJBsDsZOAviKlpfn7OgmMlkdnjwBPv.WZNDaF1hqKGOTqC
 B9AHCWZ2B4XoUU.Y9AqC.DVHgc1h868QDiD5On7O57iaRG7jEXuiBYR_6PEFiCFpgNwa.mJBcxsh
 KUS2TvhNClFLvdKtFHTe3er_YhPSxpl5qT3XiGjM2oLSmdhFYL0RQjKHxAvlGfjYFuPT0zUV9ADw
 JRed16H2P3st7c0EUJac1D93few--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 97622b99-d75f-47de-a1fd-ae88f0c6aa69
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Sun, 1 Oct 2023 13:18:00 +0000
Received: by hermes--production-ir2-55db9d9d5-gk4f2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1c2828dd5bee1de58f8566f5b57afb9;
          Sun, 01 Oct 2023 13:17:56 +0000 (UTC)
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
Subject: [PATCH v2 0/3] Remaining patches for RT5033 charger
Date:   Sun,  1 Oct 2023 15:17:41 +0200
Message-Id: <cover.1696165240.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1696165240.git.jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the missing patch "Add cable detection and USB OTG supply"
to the RT5033 charger driver. The patch didn't make it with the initial
series [1].

In the meantime, two fixes patches [2][3] were squashed into that patch.
Additionally there are two clean-up patches, which are patches No. 2 & 3
in this series.

On squashing the fixes patches into the main patch: I didn't add a
Co-developed-by tag of Stephen because the one fix on the includes seemed
to me below the threshold for that tag.

Changes in v2:
- Patch 1: Squashed fixes patches into patch 1.
- Patch 1: Added Co-developed-by tag of Yang Yingliang and a short
  description about that in the commit message.
- Patch 1: Removed Acked-by tag of Sebastian as the patch has changed.

v1: https://lore.kernel.org/linux-pm/cover.1695844349.git.jahau@rocketmail.com/T/#t

[1] https://lore.kernel.org/linux-pm/cover.1684182964.git.jahau@rocketmail.com/T/#t
[2] https://lore.kernel.org/linux-next/20230821125741.3a2474d7@canb.auug.org.au
[3] https://lore.kernel.org/linux-pm/20230822030207.644738-1-yangyingliang@huawei.com/T/#u

Jakob Hauser (3):
  power: supply: rt5033_charger: Add cable detection and USB OTG supply
  power: supply: rt5033_charger: Simplify initialization of
    rt5033_charger_data
  power: supply: rt5033_charger: Replace "&pdev->dev" by "charger->dev"
    in probe

 drivers/power/supply/rt5033_charger.c | 320 ++++++++++++++++++++++++--
 1 file changed, 299 insertions(+), 21 deletions(-)

-- 
2.39.2

