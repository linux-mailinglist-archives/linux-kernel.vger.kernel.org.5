Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A9F78CEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbjH2VxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbjH2Vwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:52:43 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1A319A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:52:41 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 42F8A320069B;
        Tue, 29 Aug 2023 17:52:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 29 Aug 2023 17:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1693345959; x=1693432359; bh=ArD9BrBu++kODudxkUcIgGzHTgx9GdunitM
        LaEOYFrE=; b=XQK4rNKi17TpFiAYWr3kcgdB7q2OjHhSGrqKucMXRZw3TBN+rVd
        cDkY+g/EPC6VzwNbKSRWXKeKbANjsdkm9aQi9yyXMF9lC4z9MhtJLEzwDYHf9mUh
        8Ynfw2WGqW0x/E6RfSKBWE9cIDJ15XECq/qQQDbq3F+0s9lok8tm40b+L+gDAdMi
        mj7G8zyNx/q/z1h/G0VZb1Ftvq2jZqq4GWj+dL+lGnWUBwm8bHEyCHaFW5W0ypRR
        3pNwFs+0qBmN4Vp0Sxx4P+ErvVpQKUMxQWlcy4ep5I0BmZgBOqQ+y4CGjEjJceyT
        OMpd+dJcxXr0JrS2vkPRQGBrP7kJZ8f9bJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693345959; x=1693432359; bh=ArD9BrBu++kODudxkUcIgGzHTgx9GdunitM
        LaEOYFrE=; b=0J/CqkVtJ1pLYGRnIflF+zXN5S2ufbbaxaQSb7/8kbzrrX/ElKM
        uM1R6+T6f3EzLfs4UvQNCbLgoesPGbSji5Oax0uK3w3DLan3wuR20n191ZSwSo7l
        MtDB32ClWecIwJM29HCjZ29s7unS1SOmjNjWt+b2snZArmNCN4nl1HyalEik6nMn
        QYwDeq/Zlx2LmZThsotGDqqVdotnUs+JEZw6L6beoZfiL5iJdC/Wb+TA6jq9dkfR
        qIHrkPBAT0bvh6miGfcIk3AiOXWH9HV86lPjqd5wmyKqrVObk0hIPJyHb+nbNfFG
        TReLR8XTJnLf6svQcdHc2HKqZqna2QDIbLg==
X-ME-Sender: <xms:p2juZAT0d3m5DhkoZYK_Qz04s4A1aUMtDoEVqQtA0mBmflzRpUsyLg>
    <xme:p2juZNyZ9DC8djR7A1aTHEleD29gPgXWTup2Kgnl60W2RKi_gMfdnVUGLzEbRHDmg
    gdpEvjWwYVY_FXepTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:p2juZN2CkTDgZMRckW4_bQAuDHy-Ijo3G0y-z21gmbjFJClgtYDSmw>
    <xmx:p2juZECyJvgW0HySmDj9FGp0vYXXDS3nO6SLoCkmuYn_A2TLz3bI2Q>
    <xmx:p2juZJgp43uIGrS38ntLGmPBRvDTIp9kBDpJ-9z9lf6REXxj2avNqQ>
    <xmx:p2juZJbFSaTxwSKlu-wT-hKYfX_XbnDS4L_GZRaRgsiTGLdE93Y7ag>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3D060B60089; Tue, 29 Aug 2023 17:52:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <48c2b819-153a-495c-8f36-2d6bc1a74793@app.fastmail.com>
In-Reply-To: <4f60d13e-f060-491a-88c7-6f25323a48f8@app.fastmail.com>
References: <4f60d13e-f060-491a-88c7-6f25323a48f8@app.fastmail.com>
Date:   Tue, 29 Aug 2023 17:52:18 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [GIT PULL 2/4] ARM: defconfig updates for 6.6
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b5=
74c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
efconfig-6.6

for you to fetch changes up to d2dff8d84df22b8f5e88d86d9f412ae0c01ad796:

  Merge tag 'qcom-arm64-defconfig-for-6.6' of https://git.kernel.org/pub=
/scm/linux/kernel/git/qcom/linux into soc/defconfig (2023-08-21 21:21:34=
 -0400)

----------------------------------------------------------------
ARM: defconfig updates for 6.6

Various additions to the defconfig files to enable more drivers
for already supported platforms, usually as loadable modules.

----------------------------------------------------------------
Alexander Stein (1):
      arm64: defconfig: Enable i.MX93 devices

Andrew Davis (2):
      ARM: multi_v7_defconfig: Enable TI Remoteproc and related configs
      ARM: multi_v7_defconfig: Enable OMAP audio/display support

Aradhya Bhatia (1):
      arm64: defconfig: Enable ITE_IT66121 HDMI transmitter

Arnd Bergmann (5):
      Merge tag 'renesas-arm-defconfig-for-v6.6-tag1' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'imx-defconfig-6.6' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/shawnguo/linux into soc/defconfig
      Merge tag 'ti-k3-config-for-v6.6' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/ti/linux into soc/defconfig
      Merge tag 'v6.6-rockchip-defconfig64-1' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/mmind/linux-rockchip into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.6' of https://git.kernel.org=
/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig

Bartosz Golaszewski (1):
      arm64: defconfig: enable the SerDes PHY for Qualcomm DWMAC

Biju Das (2):
      arm64: defconfig: Enable Renesas MTU3a PWM config
      arm64: defconfig: Enable PMIC RAA215300 and RTC ISL 1208 configs

Bjorn Andersson (1):
      arm64: defconfig: Enable Qualcomm SC8280XP GPUCC

Cristian Ciocaltea (1):
      arm64: defconfig: Enable Rockchip OTP memory driver

Dmitry Baryshkov (1):
      arm64: defconfig: enable Qualcomm MSM8996 Global Clock Controller =
as built-in

Fabio Estevam (1):
      arm64: defconfig: Enable CONFIG_DRM_IMX_LCDIF

Fabrizio Castro (1):
      arm64: defconfig: Enable Renesas RZ/V2M CSI driver

Guido G=C3=BCnther (1):
      arm64: defconfig: Enable Redpine 91X wlan driver

Jagan Teki (2):
      arm64: defconfig: Enable PHY_ROCKCHIP_NANENG_COMBO_PHY
      arm64: defconfig: Enable GPIO_SYSCON

MD Danish Anwar (1):
      arm64: defconfig: Enable TI PRUSS

Marcel Ziswiler (1):
      arm64: defconfig: enable driver for bluetooth nxp uart

Marek Szyprowski (1):
      arm64: defconfig: Enable drivers for the Odroid-M1 board

Mark Brown (1):
      ARM: multi_v7_defconfig: Enable TLV320AIC3x

Michael Walle (1):
      arm64: defconfig: enable SL28VPD NVMEM layout

Pascal Paillet (1):
      ARM: multi_v7_defconfig: Add SCMI regulator support

Peng Fan (1):
      arm64: defconfig: select IMX_REMOTEPROC and RPMSG_VIRTIO

Sricharan Ramabadhran (1):
      arm64: defconfig: Enable IPQ5018 SoC base configs

Udit Kumar (1):
      arm64: defconfig: Enable various configs for TI K3 platforms

 arch/arm/configs/multi_v7_defconfig | 13 ++++++++++
 arch/arm64/configs/defconfig        | 49 ++++++++++++++++++++++++++++++=
+++++++
 2 files changed, 62 insertions(+)
