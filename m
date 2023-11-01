Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257257DE90F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347526AbjKAXjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345420AbjKAXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:39:05 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF12C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:39:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A7475C017E;
        Wed,  1 Nov 2023 19:38:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 01 Nov 2023 19:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698881939; x=1698968339; bh=F1
        DCGCW1lBQGx3oWk6l1ZaaArAh1kPJB+/1646TCU88=; b=cU5tmODXG/ZE+43CMf
        n9Czs6AzFmJavHO0czDfmbY/q0vwHWZ8d7AfKIlOgYj6Jq1tYduG9Ug45p7P76gp
        Du5JsU86sz2xnFTZHgSCRnRJNIogs8HfR1xxvv+Akiif6/Ei8CE6f44ziHDLr6GS
        2+o0YuWiRvndDieaz8pWhQrfBC8cMt7x3+36zVKLGTCZgYgvbNxiyplI7iojO24i
        L5WnNAmmSDASt/d7PmaRuaDDbzekUuqTf0rvFLlKTnrBZm9LNp82Ca86sUGTQoc3
        0HWkJuSUKDHaA14vL+CAhFnkTNyKNE+u+ikmixhJHLSEaITzIiEyW1legMxWbxWp
        Toxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698881939; x=1698968339; bh=F1DCGCW1lBQGx
        3oWk6l1ZaaArAh1kPJB+/1646TCU88=; b=Q+jQe2bn6Swi+RertqkePFbDWzubK
        5phhnB/RCyqU2YuOBFKzFoK4RwArro+zlbkkxdvMFxoNoVlYSdw/r7cRhZtPWiN0
        XJu5snh2nzGKpxQ/eeHeG2sL0IXgHAUUPwt0eZM9Vf2vXowjmJLIL17veiofNqVY
        eCC5XTnmFdrVjWedfeTWlxZTRSN3vA5dybwNNBYNGXjOzLiuTmHGQohbiDe/9D3f
        bAbVPffH99p2n2v1ZXAyah+6Egbi52reQoH5x7U36wwH4sJRfAMpwlp58Wc5U6V9
        4DugwCx1JE/01jX6CqpIsyXNPg9agOAaX6T1cKooaV27HuhtUpy8+edKw==
X-ME-Sender: <xms:k-FCZVask4XTCjM0izcja_DhUDqGwwyeZFNq87DpanwR_1lPiXjGqw>
    <xme:k-FCZcbA80cWa91iw1OHh3a5DbP4RpkTEQQk4k1N6aLAJ_16otZOjVu3DSJJ_A02a
    6DuHYXmjaSZ5V52gRM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:k-FCZX9Q4wNDGBqSEQYiJRzJLocPso1mlQt1W0zajv2psbKiroZUQw>
    <xmx:k-FCZTrMEn5wEB0ulJKikeJFeYYUy-0_XqtBrZ4X10CG9493aNscxA>
    <xmx:k-FCZQrVOF8s1TJW6OTqo-dlbmVVJ1DnxoEoOtu_mbBeA0AfgzQMTw>
    <xmx:k-FCZdBk_ZJYysQdw5_3QiCQsL2r_b6F9vXc1f6nreh04bd9O5GvzA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F281BB60089; Wed,  1 Nov 2023 19:38:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <b2114f58-083c-43d0-a73e-660c030a0241@app.fastmail.com>
In-Reply-To: <263c2cf0-c35a-4d3c-85b3-fcb692cbfd40@app.fastmail.com>
References: <263c2cf0-c35a-4d3c-85b3-fcb692cbfd40@app.fastmail.com>
Date:   Thu, 02 Nov 2023 00:38:38 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/4] ARM defconfig updates for 6.7
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.7

for you to fetch changes up to 216da5ebb83a13caece8032ee443acfd6a6083b6:

  Merge tag 'ti-k3-config-for-v6.7' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/defconfig (2023-10-27 17:28:10 +0200)

----------------------------------------------------------------
ARM defconfig updates for 6.7

These are the usual trivial changes to enable a couple of newly added
device drivers and remove lines for Kconfig options that are no
longer needed.

----------------------------------------------------------------
Alexander Stein (1):
      arm64: defconfig: Enable Samsung DSIM driver

Arnd Bergmann (9):
      Merge tag 'renesas-arm-defconfig-for-v6.7-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'renesas-arm-defconfig-for-v6.7-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'imx-defconfig-6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.7' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'aspeed-6.7-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc into soc/defconfig
      Merge tag 'samsung-defconfig-6.7' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/defconfig
      Merge tag 'amlogic-defconfig-for-v6.7' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.7-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'ti-k3-config-for-v6.7' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/defconfig

Claudiu Beznea (1):
      arm64: defconfig: Enable RZ/G3S (R9A08G045) SoC

Dmitry Baryshkov (2):
      arm64: defconfig: enable CONFIG_TYPEC_QCOM_PMIC
      arm64: defconfig: enable DisplayPort altmode support

Fabio Estevam (1):
      arm64: defconfig: Enable CONFIG_USB_MASS_STORAGE

Geert Uytterhoeven (1):
      ARM: shmobile: defconfig: Refresh for v6.6-rc3

Jai Luthra (1):
      arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A

Joel Stanley (4):
      ARM: config: aspeed: Add new FSI drivers
      ARM: config: aspeed: Add Ampere SMPro drivers
      ARM: config: aspeed_g5: Enable SSIF BMC driver
      ARM: config: aspeed: Remove FIRMWARE_MEMMAP

Konrad Dybcio (1):
      arm64: defconfig: enable Qualcomm SM6115 LPASS pinctrl

Krzysztof Kozlowski (1):
      arm64: defconfig: enable Qualcomm SM8350 LPASS pinctrl

Marek Szyprowski (7):
      ARM: multi_v7_defconfig: make Exynos related PHYs modules
      ARM: multi_v7_defconfig: add AHCI_DWC driver
      ARM: exynos_defconfig: replace SATA_AHCI_PLATFORM with AHCI_DWC driver
      ARM: multi_v7_defconfig: add tm2-touchkey driver
      ARM: multi_v7_defconfig: add drivers for S5C73M3 & S5K6A3 camera sensors
      ARM: exynos_defconfig: add driver for ISL29018
      arm64: defconfig: add various drivers for Amlogic based boards

Neil Armstrong (1):
      arm64: defconfig: enable NB7VPQ904M driver as module

Svyatoslav Ryhel (1):
      ARM: s5pv210_defconfig: enable IIO required by MAX17040

Trevor Woerner (1):
      ARM: defconfig: cleanup orphaned CONFIGs

Varadarajan Narayanan (1):
      arm64: defconfig: Enable M31 USB phy driver

 arch/arm/configs/aspeed_g4_defconfig |  1 -
 arch/arm/configs/aspeed_g5_defconfig |  8 +++++++-
 arch/arm/configs/exynos_defconfig    |  3 ++-
 arch/arm/configs/keystone_defconfig  |  1 -
 arch/arm/configs/multi_v7_defconfig  |  7 ++++++-
 arch/arm/configs/omap2plus_defconfig |  8 --------
 arch/arm/configs/s5pv210_defconfig   |  1 +
 arch/arm/configs/shmobile_defconfig  |  2 +-
 arch/arm64/configs/defconfig         | 19 +++++++++++++++++++
 9 files changed, 36 insertions(+), 14 deletions(-)
