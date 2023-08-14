Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D977BF23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjHNRik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjHNRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:38:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCA41710
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1692034682; x=1692639482; i=j.neuschaefer@gmx.net;
 bh=zhFFT0brNi3pr5AQWefsFgLYjFJRlbuSEwzaYmmNCcs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=sH0k4+RRC2x9zoWFimFfCjxK9bLHpVTBUPaGHyjs9AhyAESt374Mq9EspRO/sGk2jmGFZWE
 T5OOkhISOqFR+RxHVclXDhJHq4s0bUEYFu1+tnw0rhloxJTYLPX7409zh8ZRI4N5SbslKPgbq
 EhnkUQVFaYrkPd3Mgc2U06vN0FWPyUb8T07ZRrYlWu7WpYaBO75nRsWi6ExEGaQawOqHiye/j
 kDiSbwPeVhjkau665fTAxSH71DT8MelfNHbbmMhuNWEXzmckn4WQmNrcp+I4syVjhEv6FfaTb
 7KWfEyojkdRbhQU0xuG7cvBcYDFdEgCX6D0IEGD6pHvXdPS83Atg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([151.216.154.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1qPZdH3o1m-008I7h; Mon, 14
 Aug 2023 19:38:01 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 1/2] soc: nuvoton: Add a menu for Nuvoton SoC drivers
Date:   Mon, 14 Aug 2023 19:37:55 +0200
Message-Id: <20230814173757.1747439-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JKkgfuDoScZQteB1gTswvplP/T06sgdYrTa6+uOyVEBUmNgf2e0
 B/Isz/+/053sbUeU+tvGFzkgIIh+cn1bcZNFvMjN2r2qGANv/72UjC9dpiBR7zHwVH3NIbc
 zCqY+cA9kgLz1KcrGgr8O07OWt4C7UCY+4oG/bG0xVG5T4QcV7elWujoP33f2RCrY0uqjml
 qZB45lH5SXNqgKXLxireA==
UI-OutboundReport: notjunk:1;M01:P0:s+p0TvQO8AM=;LC7r2JEioHcFXrxVcnsqEEg6pd6
 t67at7WyKgkR8bjGtGT51AyribetIl/Bm7Z14x2V3+F5oNFdWxR6+iudwpghQ1gX+zcYbbhz1
 S0XZfFx65Uwx48I7W9HDmCt/ZaY+9QTeObOZFcxU38j2ejKHwonah+T4qXEW40yUdYxv4kNYu
 vbig0LsNC172RuX/DkrWB+ak//wIPLP4RMorbCalo+wTmxpWraFJlnFZ8/xoZrrYMZdFF6FL0
 pX9+RUUhq7c4/M6qi5/CiCH3KNSa7I/ppNA6TqDcOszB0B/9KKucdmLsC0McUUw+jKj7Ij7nd
 dg4Jo9sCDFGbVpEyOurs57VRG/CEuM+tA4hkYo+Gx7iYY8BIFfkZ+V8NB4ZcO6o4lA75sSjxP
 EvwEAiUYG9FcbF53Ep54RLUsGCm8tt/GbGQV6umiHUKsGSAIgtdX24Cwb4RqCZr15p3MMRDRr
 Hbs/QsqULoOy7vCDQ9RLR/95VoLQ0+ra2F9bf0/5tGWjljED/HEVBPbnPAEpwL6jfVMvRWexC
 BmA5WzAz6E4+HcagSdrZcaNEVaABAKc+BI496oWiozuaVjpJ22+QgXrTaktMk9Wc0NtYnb0Jg
 QopDjXPeNLE7QGw2yo/KHTskbazaSi/qdNBmxTQrlEyhiynDec9g8BSuM7kf/5m50RAajsk8L
 lmkEBcLhBzIgZJngx7zexNudFUW6dXExtR+j0mRP7AEO9VAr+bKWE4ZBPxJRbiJHKYpgiGltL
 xCM8LH2GwZ6L2WiRHKWijefd/woBl6TQpPzzxPgmB2nz3ciqi/x+wKUh/ExSHa0YyQIuwxglu
 G2MeH4s47APWqTdAdt2EWA+bL1i+rAMEHRzkdxAvLU5lSLprkw2m2HeGirA1miy6Hcg0pcN/t
 Aa9SgbHngtjqZMOTwVq3XWoC0u6OHvSvqeEpzrg6WxGCrjNRBea6ny821kI9t/ZaHg1yrjOt5
 8K8ccTRS6ovZaEPKLUutvsafAIo=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a menu "Nuvoton SoC drivers" to make it easier to add other Nuvoton
SoC drivers later on and to prevent asking about the Nuvoton WPCM450 SoC
driver when configuring a kernel without support for Nuvoton SoCs.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQ=
mQ5u+4Q8c7-wYQ@mail.gmail.com/
Fixes: 7dbb4a38bff3 ("soc: nuvoton: Add SoC info driver for WPCM450")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
=2D--
v4:
- Add Geert's tag
- Fix commit reference
- Change Link tag to Closes

v3:
- Split the commit into two
- Reword the commit messages a bit

v2:
- https://lore.kernel.org/lkml/20230212215234.2608565-1-j.neuschaefer@gmx.=
net/
- Commit message improvements, as suggested by Geert Uytterhoeven.
- Add Link after Reviewed-by, as checkpatch.pl now suggests
=2D--
 drivers/soc/nuvoton/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
index df46182088ec2..853392c8a9151 100644
=2D-- a/drivers/soc/nuvoton/Kconfig
+++ b/drivers/soc/nuvoton/Kconfig
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-menuconfig WPCM450_SOC
+menu "Nuvoton SoC drivers"
+	depends on ARCH_NPCM || COMPILE_TEST
+
+config WPCM450_SOC
 	tristate "Nuvoton WPCM450 SoC driver"
 	default y if ARCH_WPCM450
 	select SOC_BUS
@@ -9,3 +12,5 @@ menuconfig WPCM450_SOC

 	  This driver provides information such as the SoC model and
 	  revision.
+
+endmenu
=2D-
2.40.1

