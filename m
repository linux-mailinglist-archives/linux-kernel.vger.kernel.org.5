Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF976141A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjGYLQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjGYLQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:16:10 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1FC2689
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690283742; x=1690888542; i=l.guzenko@web.de;
 bh=JgvVNzBT8P4UzxGtOp1DNJMrISv/OE1o39OgkVldOMw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=dEYrdzC0Be2BPl24rBXGnj4QZLod/vTYNL7pYBUaPMGXymHmSo6xcK9Jsd7B97Fr39EDOf+
 Rvw4bNk09KCmfTxhq6/OSkmemK4eKL/UvWu5r+iWFnq7QR5HiboqelQ3XzYzNV3+tsHcgM9xR
 WP/H8FMfPgHDHeVCQPqfG1J8WufPqf5eSD5HygrsY0gpFp/FWf81WQasAAB1mXjBDqk0P3yfa
 Doyeq78QPeQ8AeOTdjiXCytZif219+fEKzgpCBWM+qtI3sINShRL+C6aPB9dkxaVc9Jdk/Kaz
 de+NqVGLiJ+I8yOUhoEr0ECsuZNIhB6yWNL1UGYiwPyltEdAZ2TA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([77.190.186.198]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MvKbd-1q6Jah0cTZ-00rKLt; Tue, 25 Jul 2023 13:15:42 +0200
From:   Luka Guzenko <l.guzenko@web.de>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Luka Guzenko <l.guzenko@web.de>
Subject: [PATCH] ALSA: hda/relatek: Enable Mute LED on HP 250 G8
Date:   Tue, 25 Jul 2023 13:15:09 +0200
Message-ID: <20230725111509.623773-1-l.guzenko@web.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dP2sA9hxbvF2xuNjNlapa1Rw2atOLZirE9LfTzImJDaUZEgB2Yj
 3Av8+8ZDt6aygMnHuQyGZ2Qvy1gtCkc2btrpOsMh0E/r0YJjVWXtauVeOFTniXYrOFnUev4
 6iv/f8dj+Hy1a5XnVpO9K/VcsCbiKY6N5TCcY1jdx1nBpT4G7TpC93EelRfAXmhOlqj0m27
 Pc6yA44/WCn8xl1iD2xsw==
UI-OutboundReport: notjunk:1;M01:P0:HN3HGk2ZQPM=;RaJpNN5hQpL8UGQu9RE6L1Kfk97
 m+pdLywbn8REMEEdAVO0MSEeRE6xVoiDdhDPj5xBW7RNUTR9gMxMAYAfSWSSMsJz5sg6xJG0I
 dFXiZOdc/8ipsA13t6vBWBfBHNgSN2+rw/f5EzvZPQ3Ari85EnvqPkyqeKg43dj4OyvvKhH8g
 +RFDUn8YSOAe60yx5ML2+UasNdqAjmF6nHHv2VOAb+eT0f3Vc/Iszl31dnZwtAHoPRuP99NOr
 pYhLPEkpzU2O95MwIzwxg7z3P5YDnoiCOlksiW1hDKRvUNVqjlMpmgUcA6qKzbyK2TrN0bg6l
 EOg6tTIqzbbmkPNtzGCTUTFVL4nI/vCczwZBBUigrtbZoqjddyQF+82E824GPGWvHKAqdHF1m
 Tdd7YLzzKnLKMCn5gJbNXhOF7UWbJAxxQzGYmx902ICUNPzS+5VH94wiFTvbZJjbVA9723p7r
 1t3rjbp10VKWHBirKnI8aEmIwaXB5yw++Kh1AUBZzglh4pm81jSpBlSTue4s24e5YHw4J0v13
 +BjkLlOj7zTCk+KSD6JdolU9WNCrH2DNFm7zxiUI9Zd9rBzJiSOuPAfLNbpruhP7r9g5wbn7i
 2BfZ5SlbQ4degSCqVwK6xC6SFV/LH9eyBJ12BopxnHdRU2JkUXbY2la1CaTpsaz0gjooibTBY
 3hqsnfSSNpZyupv/1wYp/DQFaqKcifBroS/xwLX4kZIvPwWFi76hK7q84DB/xAbFsYT3cQBwe
 S7JRz2RWPEpwOqrXZWSvoWzT5OgHrb9XSvxxQxzRXvp8H/KLqxA0NodDIu34QwC5L7HK1D67M
 1X+xQy2DDAUnw2ZLKARv7HWS5fqR0JUVbQU/zhptJh+EoVTdM1vGnKhopHDvVzJCUq4YLrLxm
 Ef29/DoBJOdI269eG2tEhAVeP+2qAXGI74Scn7b+Cg5QP2FRceA3hhTeSpDJOzjbcT6YsWApR
 cg5Gjimf6gyFZZT9rZ3ps75uAU4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This HP Notebook used ALC236 codec with COEF 0x07 idx 1 controlling
the mute LED. Enable already existing quirk for this device.

Signed-off-by: Luka Guzenko <l.guzenko@web.de>
=2D--
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 52ea7d757d6a..9a65dfb00cb2 100644
=2D-- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9541,6 +9541,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]=
 =3D {
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_=
FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_=
HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x8812, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_=
HP_SPECTRE_X360_EB1),
+	SND_PCI_QUIRK(0x103c, 0x881d, "HP 250 G8 Notebook PC", ALC236_FIXUP_HP_M=
UTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_=
FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", AL=
C285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", AL=
C285_FIXUP_HP_GPIO_LED),
=2D-
2.41.0

