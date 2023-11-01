Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0787DE910
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347418AbjKAXj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346931AbjKAXj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:39:58 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA07122
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:39:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id ECBD65C0160;
        Wed,  1 Nov 2023 19:39:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 01 Nov 2023 19:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698881991; x=1698968391; bh=4b
        563ZqvCmMnYCYpTaw4aWlrs3H12OBDEPRJ2whkyks=; b=QrugovtBKq868OFfTu
        b33axnvNTnn6rEcvLNuWsWzGFqGH0MofufohnuxCnYbWaxEJDMG/eJTRqUbbxIHZ
        sbscJE0rV2SBi7Qsvyf4JY/eqp8okzGD7fF4i/J4wtvzn+J2sTzHWmXL4plcmP/u
        D7hf9v80UYX3xZwAzK942iI0GnpWOxZiDebsZlZtF9bvtwGcBTtMPwmpVrqMCuIQ
        mXeV+EzzGPj4OrtDMwsZccf/iS/DXET97JT9eoVZDZtSLV3a8/J0I4kLP4DTt+VK
        dVOSSSCgyhYAfomziPo+AVo9VxHDKdLzsMc1ih3+9WVe0hOQzrIzK5l7Yv52i7kN
        HL5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698881991; x=1698968391; bh=4b563ZqvCmMnY
        CYpTaw4aWlrs3H12OBDEPRJ2whkyks=; b=e8E8sDZYgGWZjce99pJnoU41oN/zT
        In/JhZQIliiHOgRQ1zvd54KJLrPc6ykQU5+09m7T3X+b99QYNC0PAqB0Zg3jCQGq
        QQ+C5/0UpGl5dvxXdcOMPEkIh63f7JgCzFSV/tpOrI82EEKxDCt3Py3wob0KSUOE
        BuWylbS3lXFre293QxnYtiBFWLGiF+PlPx7yhsg4lQC7haTVo+Exh7q8bz3eZmwR
        bdPbl/ZwFELeO1wFVc3mEELsffIc9+WtitN6rv0DIiSmyaZ017VBfay3QQfpVbX/
        y4JrEZ51E5XojcgLP3LlhLXz/iQ/VXj8lgV7/oG02Bf9buvp/P8+LFI1A==
X-ME-Sender: <xms:x-FCZe1c1MD1wvThAL2zRXSIMsQO5y8tqZmZUhcjR8HCXEyS42wA0A>
    <xme:x-FCZRGbWl7thLlcyW6ZtdIo5iAOvvCdlNybFiZSdrFX4xGlFD4zdVNghondDCQfs
    RYxkRvw-Elzms_gIm0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:x-FCZW6k8TxlPEC_HmwL0LB01TqiSBehGu_NHXytyYYRna3vwh0uFw>
    <xmx:x-FCZf1C6Upuq-7MVr7woNhOlzzPcCZCCYZ_qZfO4oTNwzdaT1zc_g>
    <xmx:x-FCZRGYANsbVlYVOK0Ebm3djs0sGZyYiA6rXTYuGGjVS18DesEGmw>
    <xmx:x-FCZfPQlHUdaHQrgkWxTevIbinhvxOcr4_sICiKQncMDy9-ruh35Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 78F09B60089; Wed,  1 Nov 2023 19:39:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <2ba2a5c9-0e92-4ab6-88dd-8410956ffa78@app.fastmail.com>
In-Reply-To: <263c2cf0-c35a-4d3c-85b3-fcb692cbfd40@app.fastmail.com>
References: <263c2cf0-c35a-4d3c-85b3-fcb692cbfd40@app.fastmail.com>
Date:   Thu, 02 Nov 2023 00:39:30 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 4/4] ARM: SoC code changes for 6.7
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

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.7

for you to fetch changes up to a9838799e2fa9fedd77867942e661b657d5591a0:

  arm: debug: reuse the config DEBUG_OMAP2UART{1,2} for OMAP{3,4,5} (2023-10-26 17:26:15 +0200)

----------------------------------------------------------------
ARM: SoC code changes for 6.7

The AMD Pensando DPU platform gets added to arm64, and some
minor updates make it into Renesas' 32-bit platforms.

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge tag 'renesas-arm-soc-for-v6.7-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/arm

Brad Larson (2):
      MAINTAINERS: Add entry for AMD PENSANDO
      arm64: Add config for AMD Pensando SoC platforms

Geert Uytterhoeven (4):
      ARM: shmobile: rcar-gen2: Remove unneeded once handling
      ARM: shmobile: rcar-gen2: Reserve boot area when SMP is enabled
      ARM: shmobile: r8a7779: Reserve boot area when SMP is enabled
      ARM: shmobile: sh73a0: Reserve boot area when SMP is enabled

Lukas Bulwahn (1):
      arm: debug: reuse the config DEBUG_OMAP2UART{1,2} for OMAP{3,4,5}

 MAINTAINERS                           |  7 +++++++
 arch/arm/Kconfig.debug                | 12 ++++--------
 arch/arm/mach-shmobile/pm-rcar-gen2.c |  5 +++--
 arch/arm/mach-shmobile/smp-r8a7779.c  |  9 ++++++++-
 arch/arm/mach-shmobile/smp-sh73a0.c   | 10 ++++++++--
 arch/arm64/Kconfig.platforms          | 12 ++++++++++++
 6 files changed, 42 insertions(+), 13 deletions(-)
