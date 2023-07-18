Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9047581CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjGRQNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGRQNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:13:52 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341CEB5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689696825; x=1690301625; i=l.guzenko@web.de;
 bh=VjNdHOZe3GALSSGYevbzgHCx2G8OebZvwIUZOt1cIKo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=QrnuwjkJtZL9oKy6aTlPjqB+N92UpeRs0M9bz41oTRCyDUsWAEdlIe/OSDRbV0agG+Dcm3B
 TrsiLKYkiJVCTSrw9a4UtfDzmeFbcvN7Lt1aD56AxLPr8IXH7e6BkxoVe6CaxD2NMd+LNTKH7
 22lpR5V+ytPZWFwz/W1ciX3lN2L0zaIg47jiUB35UwyoYpJE2NRrPaMZ62V8pzOo/KPhTQgIl
 7+bZQiAqSNpashm8ag8DUqKgBSttuvmvpO9NP/C2598XmA5qMGkMcV4nVJakLLp7DvKBKdWao
 lutX5+VvJJxpc9TwBqFqxjOkfqZwVVfU0fE/WlHgHEn+KSjmz0Ig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([77.182.132.112]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MNwjS-1qbEkD3G4u-00OSQN; Tue, 18 Jul 2023 18:13:45 +0200
From:   Luka Guzenko <l.guzenko@web.de>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Luka Guzenko <l.guzenko@web.de>
Subject: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP Laptop 15s-eq2xxx
Date:   Tue, 18 Jul 2023 18:12:41 +0200
Message-ID: <20230718161241.393181-1-l.guzenko@web.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DGklsXVs+hixHTI07SfvyepRZoxqPQu3mj/6ZVw59n5r+JYqcwN
 PHeG9uYF3ri+EsPs5HzC1mG/uFM9dJdZLc7U7fdT2TXJcd7+zFVhNKkSyD3OZNit/Pu6JRH
 FaoLQrJrSsOO+m1lkueCSGgJwlUOSuhoG5hMr09AzBeOTjqPAPXtigyrqprDt5t6wCieaWg
 I3zNkfl0lkchgG5yWIQuA==
UI-OutboundReport: notjunk:1;M01:P0:XY1iF2gQqOA=;UDz1uFUaA/++FFpQaq3dQ6N1MSn
 Hda6CvHbZGKVUviVdd85Q6IuKfJ/3LK2oxzR13s+ANnmkby4vKkTgbo1S744oguJTxX+qc2lB
 zX1Nz4Dx/1L5+IcFosKgsDiRbeMJwyH8K60dFDPePLu6TXoKxJofKKf+STXQQZyFuOOhwyNWh
 yKeHAlHi/k+rwiubFiFnZpvpomxcpqfie3DCAMwYyDgE7gJ7shfJYOGI05176e/yDizSy/kos
 +Qy9Q/xtk5DZkNxorzjxlcK2Apu+bTuRCOsERHEj+lMrDvEBBY1EltvOFQgivlLEgsFOpZWnW
 iQRaO7iPEWE4GDYsfwwdFp1SFhHD1FhiIPAVZmi7i53IWdwppdb6xii/uaKGyTmNJofXLMxDK
 Vms95Vn33YJI0OYNFjiXWIZYnF+2NTOzYqBrXfMTZ49HoAR17f+yt5FVLjiVrFEqwH+xeJHMN
 wVpcIoJ/SbPBFCWIgIz9P0YH/OsYTE02EfSvYYsB47nfp8HOeZ1mhNcnUUNAURPBLua5iukno
 mai6m+Z2iOhSgucrJ0hdcRai/1UrGvPhgzHOkd44KtzcCeiqZK/0bHS918GM74jFcJSbdt/b+
 VUDUGWG5gDjyKe8t0DIkaHOYJ2yoNm2J5erKritOleK3s7BM2C11n1FCWIkAFIsa8ZB9ArqsN
 XjZeC1FzoYGaRab3ghj6/6pyf6kWLTeHMFpk3OUZ1WnH3S8KonDcR/y9qbf9L+v62/EHNzTK+
 OXGta7SVnunxzjQPyp0j8iJOZFq+JRqXJA7FUrobR+Htpf+ZD+Jk3tIEHZ5L77RIRciiewZTq
 Sv8MW1n8b3RAkdkf24s/Pn1wADoT71tBRT0pvPT0dYgcdpb6XlDHllkNQPONn0MvfymCfCxNa
 fl+MC98urgjbBz3UmP1PcU9zI+XXuT/qdfJrtDqsoe6BCY6LImBmJmkKtPcueZCeH0gIqBNIp
 Pv+1jpUjH6sT1JW+jV8I8LkgHHs=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP Laptop 15s-eq2xxx uses ALC236 codec and controls the mute LED using
COEF 0x07 index 1. No existing quirk covers this configuration.
Adds a new quirk and enables it for the device.

Signed-off-by: Luka Guzenko <l.guzenko@web.de>
=2D--
 sound/pci/hda/patch_realtek.c | 23 ++++++++++++++++++++++-
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 308ec7034cc9..e8a836596bfb 100644
=2D-- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4623,6 +4623,21 @@ static void alc236_fixup_hp_mute_led_coefbit(struct=
 hda_codec *codec,
 	}
 }

+static void alc236_fixup_hp_mute_led_coefbit2(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec =3D codec->spec;
+
+	if (action =3D=3D HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity =3D 0;
+		spec->mute_led_coef.idx =3D 0x07;
+		spec->mute_led_coef.mask =3D 1;
+		spec->mute_led_coef.on =3D 1;
+		spec->mute_led_coef.off =3D 0;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -7133,6 +7148,7 @@ enum {
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
 	ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED,
+	ALC236_FIXUP_HP_MUTE_LED_COEFBIT2,
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
@@ -8556,6 +8572,10 @@ static const struct hda_fixup alc269_fixups[] =3D {
 		.type =3D HDA_FIXUP_FUNC,
 		.v.func =3D alc285_fixup_hp_spectre_x360_mute_led,
 	},
+	[ALC236_FIXUP_HP_MUTE_LED_COEFBIT2] =3D {
+	    .type =3D HDA_FIXUP_FUNC,
+	    .v.func =3D alc236_fixup_hp_mute_led_coefbit2,
+	},
 	[ALC236_FIXUP_HP_GPIO_LED] =3D {
 		.type =3D HDA_FIXUP_FUNC,
 		.v.func =3D alc236_fixup_hp_gpio_led,
@@ -9440,6 +9460,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]=
 =3D {
 	SND_PCI_QUIRK(0x103c, 0x886d, "HP ZBook Fury 17.3 Inch G8 Mobile Worksta=
tion PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Worksta=
tion PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Works=
tation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
+	SND_PCI_QUIRK(0x103c, 0x887a, "HP Laptop 15s-eq2xxx", ALC236_FIXUP_HP_MU=
TE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workst=
ation PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_=
FIXUP_HP_SPEAKERS_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_=
FIXUP_HP_MUTE_LED),
=2D-
2.41.0

