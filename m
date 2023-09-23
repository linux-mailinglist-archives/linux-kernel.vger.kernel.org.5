Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8A17AC2BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjIWOfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIWOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:35:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620F811D;
        Sat, 23 Sep 2023 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1695479682; x=1696084482; i=j.neuschaefer@gmx.net;
 bh=tWuczMnBM602nSuzcpyvl8JfKLObkX8UT1LqmJOK4nQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=bggh44eBmjX2N0Cp8tW31RR+MzfQByr7SVp2JA1qKFnsXvg8mLQfEoF/XIves0h+qOvEX1DMc+7
 6oov5QpUDBx3LYq89hW0nRAg7/o2rxJyYEgftyyxigQAGYEywq5BCqRxKH+Bfz2TfrjXabZRL2yYR
 /ReAO3xrVm+gY+LXRAyuXRQ1F280viEM0IXYHSNdH5sz3SbqllXH9RjS0rO8P05Mgp+tA5F7uiM0D
 6677gIJjF0N+kZHxO/WxDJrXz44Lt7LhyjNsMsk8Cl1O1dW/1ezMVmlzSceEJSSrWbmshog3klVAM
 Nq3K1n0mxWokHxnGyF+pHrHuDkJt8B7ddGhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.47.152]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2WF-1rQV9R0umd-00k8jz; Sat, 23
 Sep 2023 16:34:42 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v9 0/3] Nuvoton WPCM450 clock and reset driver
Date:   Sat, 23 Sep 2023 16:34:35 +0200
Message-Id: <20230923143438.1895461-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eNDRGVmSiH9g9utQqqZY8Cr+TyaHbdllTMEzlrLrn0cMXrHyL0Y
 fcGqD2BL4TMpO5FGIk+zVvmggC8IZJRoZwRfpiTVyzOOsL9oQ+8/TZcFbg1qI3xzkjmTWUt
 Z29hT5A4sn2OY0aoqe+E9nZxtWlPs/N+P2hsVX3AR/zfdBF1uuEPitBnVyvg4sKXT+KnQEI
 T4kxwCC2+Qy8MNtsoLwsA==
UI-OutboundReport: notjunk:1;M01:P0:bwrW82LuPuU=;en8p4/Dckpk5IJzOJlSLjjK+mPI
 RSuv995WrxiD6kuAhGBml26Y99yTxTNyXCzY1KvsqllwWNOjApP2+rJGL6alvaGxsBg+jppYI
 bXwVl4+Gese+MiT1MYa0euJ7UMESDw2J4WnNqtAYIF49zl5AYl/A9QP7B0PFGTAozIPjVltJX
 xlQxL96jstw7zjvO8HZvik5QF5CZPPBKDyjdGTBGLkyTN/x1lppc0WTlxnC75Ku3p4G7brvpq
 4zclxM9/SBoXcLhR5f0xknXhJbSI7hB1VeBEBjwVjXEuMomiq7/1CP1TcLcQlsCK2sg12siMa
 cXqs5/ZPt7fbA/FPk6U8OeK/DhRFcpOiSo5qrcWcfpoU9CJZAq2AsuorTipnP0/qHhfZNF9yB
 zvEvcCd1k6Z4TwL1Qvbvo9j3YLMHyk1rsWieVcEoj//7YGaZAIXl6nBOSte66LFZGBxFN8iI/
 F6CjMRARntSwGr5ylLqHkB990MTPsRENQx/Dx0mPMudaewXG3er/BY4lb7qYWdHBEOUwKp13R
 mibApohRgJUWZ8w4uTfjKayKLR7q0Q00yNclKfpCdytbxNDBqU11iD5UmRy9n40KTZiSWbNLU
 TwMUO0GhZzU91ux/JlNw103FW1pI8pvU7kRFZ1rgdzBRuuxKUPJLWiDWtP6ojza1z37nFMeJa
 tYPEkN0djTJSKFcLt9Kh7a44lsCCUEhmMIGoEp/uLpXbJFqq7hjuQ7V2+5I6k2Z+9Ts0Yh1B1
 sQBFKXU5/IJJuVuBuZrwGAcpD0k4fNNxoRd+bWL4sXBgjvd7laHH7jdTcqsZ7tG6RW/VtzhrQ
 Rhd0L43RNfhVL4RHKkpikOov4LczqrhhaR7yP56Fp8fEpbzGCbBT7Qzg9qcvzkzSe62DDlnqV
 NpJA4amWu/fCo1tW+pbb9oIMa58jZyONzvsaQYLMiYY4XwV4oZ/Czkfw7KYZ6fLJoIRZpLY84
 AKZuTg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the clock and reset controller in the Nuvoton
WPCM450 SoC. This means that the clock rates for peripherals will be calcu=
lated
automatically based on the clock tree as it was preconfigured by the bootl=
oader.
The 24 MHz dummy clock, that is currently in the devicetree, is no longer =
needed.
Somewhat unfortunately, this also means that there is a breaking change on=
ce
the devicetree starts relying on the clock driver, but I find it acceptabl=
e in
this case, because WPCM450 is still at a somewhat early stage.

v9:
- Various improvements to the driver
- No longer use global clock names (and the clock-output-names property)
  to refer to the reference clock, but instead rely on a phandle reference

v8:
- https://lore.kernel.org/lkml/20230428190226.1304326-1-j.neuschaefer@gmx.=
net/
- Use %pe throughout the driver

v7:
- Simplified the error handling, by largely removing resource
  deallocation, which:
  - was already incomplete
  - would only happen in a case when the system is in pretty bad state
    because the clock driver didn't initialize correctly (in other
    words, the clock driver isn't optional enough that complex error
    handling really pays off)

v6:
- Dropped all patches except the clock binding and the clock driver, becau=
se
  they have mostly been merged
- Minor correction to how RESET_SIMPLE is selected

v5:
- Dropped patch 2 (watchdog: npcm: Enable clock if provided), which
  was since merged upstream
- Added patch 2 (clocksource: timer-npcm7xx: Enable timer 1 clock before u=
se) again,
  because I wasn't able to find it in linux-next
- Switched the driver to using struct clk_parent_data
- Rebased on 6.1-rc3

v4:
- Leave WDT clock running during after restart handler
- Fix reset controller initialization
- Dropped patch 2/7 (clocksource: timer-npcm7xx: Enable timer 1 clock befo=
re use),
  as it was applied by Daniel Lezcano

v3:
- https://lore.kernel.org/lkml/20220508194333.2170161-1-j.neuschaefer@gmx.=
net/
- Changed "refclk" string to "ref"
- Fixed some dead code in the driver
- Added clk_prepare_enable call to the watchdog restart handler
- Added a few review tags

v2:
- https://lore.kernel.org/lkml/20220429172030.398011-1-j.neuschaefer@gmx.n=
et/
- various small improvements

v1:
- https://lore.kernel.org/lkml/20220422183012.444674-1-j.neuschaefer@gmx.n=
et/

Jonathan Neusch=C3=A4fer (3):
  dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
  ARM: dts: wpcm450: Remove clock-output-names from reference clock node
  clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver

 .../bindings/clock/nuvoton,wpcm450-clk.yaml   |  65 +++
 .../arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi |   1 -
 drivers/clk/Makefile                          |   2 +-
 drivers/clk/nuvoton/Kconfig                   |   8 +-
 drivers/clk/nuvoton/Makefile                  |   1 +
 drivers/clk/nuvoton/clk-wpcm450.c             | 372 ++++++++++++++++++
 drivers/reset/Kconfig                         |   2 +-
 .../dt-bindings/clock/nuvoton,wpcm450-clk.h   |  67 ++++
 8 files changed, 514 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm45=
0-clk.yaml
 create mode 100644 drivers/clk/nuvoton/clk-wpcm450.c
 create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h

=2D-
2.40.1

