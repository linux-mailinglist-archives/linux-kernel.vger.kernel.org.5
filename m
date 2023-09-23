Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0870A7AC21E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjIWMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjIWMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:52:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B4198
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1695473551; x=1696078351; i=j.neuschaefer@gmx.net;
 bh=McGn7BejShk21r7sbDRFwwAdeeAGxX+0PxOI4hrkHmg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=D+LflzodWX/0gKH6kRjNLBE6ybB/5ecJjOyx7RiSgkBsa9kMi63i9lP4aKNTa6ql5C48lDNz8sO
 zR+J1WU74mzkY//Er+42bCZ9TSf1gcAr/xocuim7AjvNoxvZpHn7wa8hys+D3zc0Em1NR/4UsJAE6
 n0WjF1orXWWir3b9mnM9FO5aVRIMP5Hb4Y2zXchoYlms+N0vqHe+ianMCsZSlW87rmhboTUBe/cWo
 3EeMvUMc3cs3aB0Yq0sw+z6DSEEBnu+KHjnUgZOUAh5zzfkv/Di4Yl24O87L/SbLa0ssbBjorAjH1
 xFK//4U27CTfIHtHkxJT1ASg+Ayu+yZo7itw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.47.152]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGNC-1qzuJN1huI-00JLQO; Sat, 23
 Sep 2023 14:52:31 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v5 1/2] soc: nuvoton: Add a menu for Nuvoton SoC drivers
Date:   Sat, 23 Sep 2023 14:52:26 +0200
Message-Id: <20230923125228.1770991-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TEiEqCVstzqkC02NAVuNgqGW3Q5ICPiz+Fdct4C8Ld702AK4hA6
 bt07j8M8ZD/JOM1nq2VjuepdriJWSviDWRQstQhir1e94WWIXFcdm830h8Sa2mC3wrdow1Y
 CdGZ7zSuyubkrTEYkgojHswCvvtNNbrqCcp4x1FHLWSNU2q0l0UutvRJUgNIEps+3NsMFYX
 byTV9d9y1vJk0eNf4Jx7A==
UI-OutboundReport: notjunk:1;M01:P0:yOkm6ydaOx0=;u+O+pITOmOkESlj5EaCDJlkpIZA
 lJeByMNspASQv1jeKMNy1nlC9+75KROcmcvZgMlzRXcYW63Xj3fVcRQI7KTtaTfQr7t8KOT3o
 A5r8w31EX1kbJTRMbeDuq8BPCUjO9+isMRiRi2vHd0VmdnDOscQYt8MBnBC7po3BWjWpaaUXP
 Lhzk/ugCn+/vLJGwR6i6RWoTq8T04YG36fUqb0FAR7QSB4MicztvCNpPU/KyKOGI4lEar/w0u
 nCWoY8lAe70Hk4o9dIxaFQ0XNa61LPNipWed4aofc6oENwpL4AvvQDVU+txo/jjYMhCRWbnoZ
 UjoDCzTIl894Afq/tqwMgJF4S8QJ4xVSHTa3ConnzL4Garrgo1Ii8LasXe8KQ7QDFEgwABB1I
 fdN6T3MF7WSRaQ86spCtfs7JtIXKg7SrK5J4+o1OckyScRMbbKdCNSw1STuT6L7MGnrpKnLVT
 hkNiXzHfpQJCGxW3MooMmg7vH4gBV2SKxsw1Zody3ik3Ci+qpfBuW7YgF8E+wBAiK/NBs4Mlq
 tonWSuB5fTLd1Vnc88yASTTB82SLqXKyX/dB1SIRUXUHkoOpylZdHj5TPUW4ODB9U/G1g0eCd
 t/7yXxlypXaGtSmETnrERSyq+NiPF/Jq7u6xIqO9l0RStPSSGpUePMY0VNnNPMUgZt8/5xoUu
 r7wjOAXm8nRktQBKLkFWzo4jSSddzwiPZf893UlxNXZmrL1NjsON+hnlwfE8lpjMsc5iydzvD
 6ZAYdZXLCU03n70QSrNmqnnT4zhVtAcnDOTC3dlBtfzALRQWZpp/yUlo7abifeGV7Oo1PFtsI
 nmEn3zHi9L0/wCAcX7F1iIrNDvq+aGQsdpEZdklXv8MEPWVGui8GU3e/QG3+2+OF0MoZfMspd
 9tx/FvJloSuF+7MOovDSN1eHZLM7rXbexUSUsw7JrEKXoKWeK+zSzzFmWMvXRHaZ0as5LG5DU
 9inkZWUnTyE912KVZ1GWWja6kew=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v5:
- Rebase on 6.6-rc2

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

