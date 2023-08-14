Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D5D77BF24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjHNRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjHNRi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:38:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439ED170C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1692034685; x=1692639485; i=j.neuschaefer@gmx.net;
 bh=VT7XpQTEvPwv34StMvAbbUdyqgucsQ7LtJt/JXIuw1c=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RXOiznYs963GfNlv50MVzgeBZg2vghZwAGJt7MSd7hRagmzlPaV1zWWx0SX2kyvkPl37Ya3
 tK9zYV2u65wiCwgoybK2ohm/oXp6eBej8hY4tm5HbGaganQXW0qLbR/o1/dEJdGDgY0vu/wR5
 FT9JT50LnktOZy6FDN4q0x6CBIdo7B3m6eo+Qt76P2Q59b6p/iAmW81z7XE6IxGrrE9V0uH2P
 vn4gfXW23CClKvvqshPy/mZ9LWNXrehPPvcE+lKrIwVCMqc7K0QgDw+99voeFr1lqKZS9rX3R
 QCs+hQeEjAAdxQEakEcNLL8Syk5BBTwpuvpVrTpWl8XxnijshF4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([151.216.154.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf078-1ppQ07352Y-00gUtr; Mon, 14
 Aug 2023 19:38:05 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 2/2] soc: nuvoton: Add "select REGMAP" to WPCM450 SoC driver
Date:   Mon, 14 Aug 2023 19:37:56 +0200
Message-Id: <20230814173757.1747439-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814173757.1747439-1-j.neuschaefer@gmx.net>
References: <20230814173757.1747439-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:REPYzm01i+UIbajMDjc9lKz60SR5oQH/gdKGfw7cPXhSmRHFYt7
 Gvp/zkjFCjme/0CRPXldOcC0CzaRDc68lN7LlyBWib6IhjWJYrwvQY8Pox7s8VIpP2bfBWl
 G/e17lpZAt6Kj6975hZMcwICYyN8ynXLTXn2JCiuiQoqcbz4qjAspVVswL6ACsJaKqOEFW1
 SRpCFWaAjxKIgmz8adyQQ==
UI-OutboundReport: notjunk:1;M01:P0:HSkiHSA1NtI=;R/dI7eWFgJeO3oGQD+l1rgdxb/X
 /ewvzpiY9eSH57Tc5wcpY42sknpVOXXX/Z/AxY02UVhBWE1Sq36zX+5i625ANNl5Xf20X1Fef
 7eb7cdErPlvxKLeh/zCAxG/Nhy+RU9Iit+00hFG08pOf0lOqyvNBhyRsCpHvxEYsw/Qqmoni/
 vpTW/8sEOMqUvGc8Fa6Q+iR+JQyKsGgKa5ynZSBBpdAwZ1R4hJJvt3WEodoa95vy9pA2ReWKy
 40Aqfa1VeWcWFz7xdB1qpkndo8ZQ2QB05uwVu4VT/D20pkGaaIxdx2Gz9w/lssf0EgSqIM4FQ
 XuJd8x4x+dyrB6hqIepUTnwvmpTy7yjCclu8wrLvnVI0bCeTyLdFCbOCPlXJpKcxMYFRUjLbY
 CqORpEAWuo6nI8jxjuKeyArcOJJcO908trvZhFBeUs2WugS+dJIgmAhLKZmrCNguWmpvVvqUY
 vqwIK6vSwYNMwAev0IDehc9tBaArubyIRdE8TWGnOO9AueYFdF5WACtjbImmpbubx/BnIyhEj
 Si//sTrivrDNDGPx5mR+f9ExeyigjeHLMaKN9bLCW2j6Ta3JpZT1oqmIaDtRaU6+jRhmwr3Fr
 lzNj2w2NuGLu7fKN4r7olzoVw0JeOSlMVU/qEUfnqOMp9NiFfwD8IU35mYF4PQxX6UkCvAunY
 oqVnAUDXGuTLQ6lo94V2U23rfe+ni663FQICk/Dav/fOUtgjZeWLXoN9fX+A0WvvERA98TOvM
 8CYJvCoF4qh0S/KkSuu7G2GfhlBsJAk8jAIzAeZjy5XQb9woN7uQSNmam7f9Zema7fec37DOw
 qokcbDuZc8l7/A0QxkgWN8xZrghJEFIgLFIj+q6jgYgDpkro894MS6FGrNd0WY0sYBiXKi8ii
 thYqJ5qAt/7cR0BnffiVUx6IlEd15OWUFcjzU4UKl5q/CTstCSzfcqeT63kfaNhWhEpk4whCI
 uQwyze1FmEwFKq8i2NfGLXqn+2w=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_REGMAP from CONFIG_WPCM450_SOC, because the driver relies
on regmap to work.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQ=
mQ5u+4Q8c7-wYQ@mail.gmail.com/
Fixes: 7dbb4a38bff3 ("soc: nuvoton: Add SoC info driver for WPCM450")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
=2D--
v4:
- Add Geert's R-b tag
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
 drivers/soc/nuvoton/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
index 853392c8a9151..2167d3d739d84 100644
=2D-- a/drivers/soc/nuvoton/Kconfig
+++ b/drivers/soc/nuvoton/Kconfig
@@ -6,6 +6,7 @@ config WPCM450_SOC
 	tristate "Nuvoton WPCM450 SoC driver"
 	default y if ARCH_WPCM450
 	select SOC_BUS
+	select REGMAP
 	help
 	  Say Y here to compile the SoC information driver for Nuvoton
 	  WPCM450 SoCs.
=2D-
2.40.1

