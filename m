Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA27C6ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378730AbjJLNJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJLNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:09:40 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012E9B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:09:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A50803200949;
        Thu, 12 Oct 2023 09:09:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 12 Oct 2023 09:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm2; t=1697116176; x=
        1697202576; bh=cZMmYkqHafcy9r9IqECYBJlSxMS9CljvUiH0C1OF7xE=; b=O
        pT0mWlV8K32Yoa/bTIYumB/dRHc+0SddvVSKHKYAZI9OJjnEQGQLFxD98DwYFilO
        oGW9rUmxvIe9XsoSqWuzPXwz+hjSlHbSftw45eWYG7KZ3pgxP5sB5P4uPVwyqGbT
        hq8SXPjvIZDYUgB4v5dMkmRFNmmmhIyr8wGkQgTGhelePH4MZj70UqylbIe++ulf
        yJfvhLh+WmOVYJAmV2fxax0qR3X0BGoQ/T0rqX1VGX/gbwsTj5mSarlGgg+Mjp8k
        I+qcuDkrOcGoi/FF5nLXCgDqSj9Da8oIXhr2/5rYkDu3II/6kzrnOU0B1nkf0rZT
        ncA7gQ6IXlRujRCsjeS/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1697116176; x=1697202576; bh=c
        ZMmYkqHafcy9r9IqECYBJlSxMS9CljvUiH0C1OF7xE=; b=dUdOnIgaOd+BeQxhz
        dbR5rLpI7Gnlpa4eBLDrLlBOla89T7aDrPnBUeLso8oBbdZLB3Tfrffw8FFYE5wH
        Ckuf1hhQcAJhZgEPqPVK+1dswgFsdLT2x4IafrC/GKW0f1OUtELNqOCGuUintnwz
        rWnUGwF5lIZ0v+oONktNyqKaynA0o4j73jBV4dehhUu5rlKgrsT2VYnp3pih/JWw
        aBQN+PjlXg0iH2tBHJwjFLC7x5JYDHdFHvlYPRcRU76uLfzg2SewK9Ymp/qp5bxS
        THuU0kbEOsZMGBMvoBj+aDFtKjxCm1dqGfhUhCf7CHN2GXv2EoHmUPAVIITGiJ5x
        D3MOA==
X-ME-Sender: <xms:D_AnZUFlAfslxS5HItdQlB9ZCPk5dyZ80am_YnocUKfCICVKB4Fwwg>
    <xme:D_AnZdWech7XBt4RFrmnBoCuVcKN-wt6iEs3OR-4JZVC6PElVuU5awOirqH2qn3Xd
    Hy_omtM1zJVvmUSxHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepleekveevheekffdtiedthfeiffeugfdtgfetffffteejtdfgfeevheegtedvveeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhhinhgrrhhordhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvg
X-ME-Proxy: <xmx:D_AnZeJWPQtyq13UZwN-aTmn6sRXuGT8uHQyRrlW-G1DIklra-etwQ>
    <xmx:D_AnZWF2aD4AcGMLRW_255TmfAC2BM9XQXpzpjW77nJofDAbRWDGIQ>
    <xmx:D_AnZaVRhejCMrZccBEN-zxnTzCxlI6Bt6bsC3VWsLxsr-LE0Erh-g>
    <xmx:EPAnZdeMWWOLvDfQfh1WP6c7nMx_dSn12EbHIXS4SCNmFAteMlzFTw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BDBB7B60089; Thu, 12 Oct 2023 09:09:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <36814910-2a98-4567-af7f-684318a1ebef@app.fastmail.com>
Date:   Thu, 12 Oct 2023 15:09:14 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: SoC fixes for 6.6, part 2
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6=
072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-f=
ixes-6.6-2

for you to fetch changes up to 26de14831cf6e6a6ff96609a0623e1266a636467:

  IXP4xx MAINTAINERS entries (2023-10-12 13:11:30 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 6.6, part 2

AngeloGioacchino Del Regno is stepping in as co-maintainer for the
MediaTek SoC platform and starts by sending some dts fixes for
the mt8195 platform that had been pending for a while.

On the ixp4xx platform, Krzysztof Halasa steps down as co-maintainer,
reflecting that Linus Walleij has been handling this on his own
for the past few years.

Generic RISC-V kernels are now marked as incompatible with the
RZ/Five platform that requires custom hacks both for managing
its DMA bounce buffers and for addressing low virtual memory.

Finally, there is one bugfix for the AMDTEE firmware driver
to prevent a use-after-free bug.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer

Arnd Bergmann (2):
      Merge tag 'amdtee-fix-for-v6.6' of https://git.linaro.org/people/j=
ens.wiklander/linux-tee into arm/fixes
      Merge tag 'renesas-fixes-for-v6.6-tag1' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/geert/renesas-devel into arm/fixes

Eugen Hristev (1):
      arm64: dts: mediatek: fix t-phy unit name

Jisheng Zhang (1):
      soc: renesas: Make ARCH_R9A07G043 (riscv version) depend on NONPOR=
TABLE

Krzysztof Ha=C5=82asa (1):
      IXP4xx MAINTAINERS entries

Macpaul Lin (2):
      arm64: dts: mediatek: mt8195-demo: fix the memory size to 8GB
      arm64: dts: mediatek: mt8195-demo: update and reorder reserved mem=
ory regions

N=C3=ADcolas F. R. A. Prado (1):
      arm64: dts: mediatek: mt8195: Set DSU PMU status to fail

Rijo Thomas (1):
      tee: amdtee: fix use-after-free vulnerability in amdtee_close_sess=
ion

 MAINTAINERS                                  | 27 +++++++++------------=
------
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     |  2 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    |  2 +-
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 39 +++++++++++++++++++++=
++++++++++--------
 arch/arm64/boot/dts/mediatek/mt8195.dtsi     |  1 +
 drivers/soc/renesas/Kconfig                  |  1 +
 drivers/tee/amdtee/core.c                    | 10 ++++++----
 7 files changed, 50 insertions(+), 32 deletions(-)
arnd@studio:~/soc$ git request-pull mainline/master origin soc-fixes-6.6=
-2 | xclip
Error: Can't open display: (null)
arnd@studio:~/soc$ git request-pull mainline/master origin soc-fixes-6.6=
-2 | cat
The following changes since commit 6465e260f48790807eef06b583b38ca9789b6=
072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-f=
ixes-6.6-2

for you to fetch changes up to 26de14831cf6e6a6ff96609a0623e1266a636467:

  IXP4xx MAINTAINERS entries (2023-10-12 13:11:30 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 6.6, part 2

AngeloGioacchino Del Regno is stepping in as co-maintainer for the
MediaTek SoC platform and starts by sending some dts fixes for
the mt8195 platform that had been pending for a while.

On the ixp4xx platform, Krzysztof Halasa steps down as co-maintainer,
reflecting that Linus Walleij has been handling this on his own
for the past few years.

Generic RISC-V kernels are now marked as incompatible with the
RZ/Five platform that requires custom hacks both for managing
its DMA bounce buffers and for addressing low virtual memory.

Finally, there is one bugfix for the AMDTEE firmware driver
to prevent a use-after-free bug.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer

Arnd Bergmann (2):
      Merge tag 'amdtee-fix-for-v6.6' of https://git.linaro.org/people/j=
ens.wiklander/linux-tee into arm/fixes
      Merge tag 'renesas-fixes-for-v6.6-tag1' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/geert/renesas-devel into arm/fixes

Eugen Hristev (1):
      arm64: dts: mediatek: fix t-phy unit name

Jisheng Zhang (1):
      soc: renesas: Make ARCH_R9A07G043 (riscv version) depend on NONPOR=
TABLE

Krzysztof Ha=C5=82asa (1):
      IXP4xx MAINTAINERS entries

Macpaul Lin (2):
      arm64: dts: mediatek: mt8195-demo: fix the memory size to 8GB
      arm64: dts: mediatek: mt8195-demo: update and reorder reserved mem=
ory regions

N=C3=ADcolas F. R. A. Prado (1):
      arm64: dts: mediatek: mt8195: Set DSU PMU status to fail

Rijo Thomas (1):
      tee: amdtee: fix use-after-free vulnerability in amdtee_close_sess=
ion

 MAINTAINERS                                  | 27 +++++++------------
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     |  2 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    |  2 +-
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 39 +++++++++++++++++++++=
+------
 arch/arm64/boot/dts/mediatek/mt8195.dtsi     |  1 +
 drivers/soc/renesas/Kconfig                  |  1 +
 drivers/tee/amdtee/core.c                    | 10 ++++---
 7 files changed, 50 insertions(+), 32 deletions(-)
