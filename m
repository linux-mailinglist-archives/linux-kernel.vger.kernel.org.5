Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14AE7CB65F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjJPWNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjJPWNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:13:45 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BEFA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1697494412; x=1698099212; i=l.guzenko@web.de;
 bh=9d2dbXiVZg4W6WYNSBv3s3mJZPt58PfKg/l2GDOEKjY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=DAuekgAZYxSjuyw8a23NurwX38n/tgADPiVhD1VsAtf5xtF/YkL9nKd0BWvT0heDtC+uxmB5tKu
 0kd2lxtJ48i/mY7stFipyx7wTqT9BBC1fsLZpFa4IQaJqjJX0QM3rfEaxRtbEUnacZYPMaRASSqRA
 xFlkDvPQWV1vYGH5EaHYUIj93ESnSoLn1ay+NwAuKU2JjcnHSJI3Ohdh2rod0WdbeNVgz0N0o1dNF
 qG1XRbWEVNNd1SlcY0xd5ZO3GuPqA064+fZ+iX1SgYcdWn36FoxEdv6NtYO8Mb0RN6zDeSijm4wTM
 LLjOVO8KyHEep22AMU50vcZvlX98aHfS7lqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from luka-spectre.fritz.box ([82.220.110.137]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mw9xG-1ri8UK0xO8-00rxnr; Tue, 17 Oct 2023 00:13:32 +0200
From:   Luka Guzenko <l.guzenko@web.de>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Luka Guzenko <l.guzenko@web.de>
Subject: [PATCH] ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq5xxx
Date:   Tue, 17 Oct 2023 00:13:28 +0200
Message-ID: <20231016221328.1521674-1-l.guzenko@web.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m2Xut+5J8jWeT6Q0+Mz260CHBg2YtKnc/3PQTdhmDpLfQw/Ps6w
 qEXtM93Hw6xxy9M3/IGT3KNFG/xr2v2jzxhBuDM330s+T4tNmU/oMprumbEPPmoFo46D8nV
 hVgRCcCi1IrhUWSaCDbDw+Kzta77QTbtaOL5M/4VRfUNL1SR/sEh9TDg78ZF3moupCur4/A
 +INeqjrFxnA2YMUIeOm+g==
UI-OutboundReport: notjunk:1;M01:P0:q3Jcwj0BHyg=;mqTzrWDxOBCqUUTERR/u2HQVRCg
 weByuyYcJEVxZOw2uYVjJwTxrCOgF6HzM3V0XHrjsHEGFT5Zm4AkQmh56kOFQoOafFcZBihAy
 K6IKPhiygAzKRknqWK7VH/cpcQ2QpLTqlUPoFrB72bmUrcZc6xTxWak2NixQvlVwP5cA1UJus
 0JMgzHrXHsUA/ofwWzU6kmsLhfCREqRUfKLTMvvbsF29mIJgJlfNzqUq5VP5bSV4cqHvdAX86
 BylgACFev1EXFtlYWUjhFbm8qYCOoCHS4bHGXbTQJ9PQHlMYJuWOxNQCjC7Qq31vwImeXyYOg
 o5OpyV001meKNTjS/e+SuPUefSDe+wzfINER+UL7sI1DeBUOeq/HfkZ7jSapgW0NmnCvuT5Dr
 Mq8SlBpIWUNWRyJiZjjc8N5wGkEmsqxwZEZzPmHJYzpEx0dTgkx1e3n8t3vn2k4kYdFhCPll2
 f4pEhGX6mMybQTEpGFwh1UYNhUDRFzTzDZSo8NABP/n0zPtEj1RLdYp939bGgLMZn0vlcKsQ5
 49pYmNDBON/Xp3BQCecCO3G9yL4Pob2UdaAh1D15pR3NjM4f0RyPygrVzH0QMikmmKMuWU4Eb
 2nSb6gr3Ba91cJ8G3zSx/DQrKl7voXxqFDsDcJPjxeQYKt6irZeco0Q43ZSkEywkBMi1bydkb
 cSsF5C0RX7Wxv9uhmzuU0GM9TAkH/D85gH/HM1Roq6BgJpg0Ap8VPIdyPqPdd/FG1fHOnELtV
 PVQEkVuZpefjOQXDWl0tIuNf98rdnGOD8m2xQSWd5EO27JwMv347C4YcSWdIcw6P/Lygfd1wM
 UCtHzwVCPRjYjGJT2Cv2eioRK61dLqE/oZp6gJrO1FqYuXBF6zUfx3+DBmDkzsn7kpD9E9I/L
 aGVALb0+cpxxSzqqT1EJxNmIMiMJ6+KRj4L30BnrpJO+qJ+3j0Cn27CUF7ikv+YRXDsSFXL5L
 0gDKuw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This HP Laptop uses ALC236 codec with COEF 0x07 controlling the
mute LED. Enable existing quirk for this device.

Signed-off-by: Luka Guzenko <l.guzenko@web.de>
=2D--
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3eeecf67c17b..4b68d3df9473 100644
=2D-- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9722,6 +9722,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]=
 =3D {
 	SND_PCI_QUIRK(0x103c, 0x89c6, "Zbook Fury 17 G9", ALC245_FIXUP_CS35L41_S=
PI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VRE=
F),
 	SND_PCI_QUIRK(0x103c, 0x89d3, "HP EliteBook 645 G9 (MB 89D2)", ALC236_FI=
XUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MU=
TE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIX=
UP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MI=
C_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x8aa0, "HP ProBook 440 G9 (MB 8A9E)", ALC236_FIXU=
P_HP_GPIO_LED),
=2D-
2.42.0

