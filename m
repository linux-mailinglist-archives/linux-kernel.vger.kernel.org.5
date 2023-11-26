Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C4A7F963B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjKZXFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZXFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:05:35 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF21F0;
        Sun, 26 Nov 2023 15:05:40 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4E7F23200A62;
        Sun, 26 Nov 2023 18:05:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 26 Nov 2023 18:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1701039934; x=1701126334; bh=C18hZ8S/pL
        gCzSdaAeL/mnxamIQnFEpzLk13rIQ2vPU=; b=GgFQFSk540SnWnj187J4D4Q5Y7
        DbirXyRwWkBqojr47wP6EUqikTXDh5drj6Irqvn0APH3bjhYwd6OZrMh6YbMs1QG
        t2qLhpvbKTkestHxJKI9xPPDk0jkjX4q5OypJIFq4kXJH2r1D/1AbgDr9sS40Lmz
        C1c7Uc4NHklmwBp+tJMAVN8trQ4iwi/5npZo5wMsd0uHhL02iOW+mUKG/QtMDVS2
        7MoMiW4Ec73BgYHCGZj0KxsB7dwkwnr7CcdfvcfZLwX4Bfi3pyn/+vctRlNt/0F2
        A9Q/tnvuF65glupFsES7YG/Ib2SBQD/Wi054VesYGBcEGrG1mnLg2han+mEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701039934; x=1701126334; bh=C18hZ8S/pLgCz
        SdaAeL/mnxamIQnFEpzLk13rIQ2vPU=; b=eddodv50GRFxYOEbH8VhJvEs6THh+
        AL+tyXyEA6Nyvu+SVwJ9NARuw3nPP3NEz4t5WDrdDEGTCkEhEJ1I2cdI1coV3wU1
        R3zmpeT7NOk+RcH9JOTYRx/ExPMFoCl187u0NS6/LyvIWJUvK/av2S2ItwTW7VnD
        Ns0jFpNOz9yZszpVonkB5YserotXOQjqWC6hvah65hDSg4yJIqsy8UzYzEq5rpqa
        bsFzTC7Yx0KA727mvnXG3rZhDGb1io/otUEvsio192a4itw0s6Vf+O8SwABlg1J4
        SNUC5i5bj3NlXSvwtwjveq8h8k3f0cpkgjh9rOOLYusT5/nQQwyNY3YZQ==
X-ME-Sender: <xms:Pc9jZWHe_4j0LRYn5Ar8D0pYjMgOxztRzZInp_qGdrdVbOOe8kEGxA>
    <xme:Pc9jZXXxHp6MzASqct1QW3amVl8svDYjhtHJhK7OMG73fXaED8tLrsJleIvxAU6S_
    -reBTVlq403yLvwTxA>
X-ME-Received: <xmr:Pc9jZQJFWCUCsJWulyPVwnLcqhXDmF7ejADvC7Ug0pLmr8WFJsBPXOi7VRai>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeitddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhephefhtdegleetgfeijefgtddtheffie
    evhffgueffjeefheekteeifeevffeiledunecuffhomhgrihhnpehfrhgvvgguvghskhht
    ohhprdhorhhgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Pc9jZQGaUNMFU8Nny32SBVxZu5TLB96bWFTAt7W_ehbAQ-6A1CFbZQ>
    <xmx:Pc9jZcU83nZggLffpsDK2Zw8XC1F8_CgE3Uw0N3Vea4F0cz0vQUXyA>
    <xmx:Pc9jZTN6u6MbGx8_7RP4rxJUqW8JSIEeMtnsuqDKZMljpslIbKzrEg>
    <xmx:Ps9jZTTTF8hNOUV5D9_kcHe4Tm-gV9rqixPKFdABpqHx-7QJFTd_1Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Nov 2023 18:05:31 -0500 (EST)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/1] platform/x86: asus-wmi: disable USB0 hub on ROG Ally before suspend
Date:   Mon, 27 Nov 2023 12:05:20 +1300
Message-ID: <20231126230521.125708-1-luke@ljones.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix for the ROG Ally not being able to use the N-Key device after a suspend/resume cycle.

The root of the issue is that ASUS changed the MCU firmware to dfisconnect the USB0 hub when the
screen is switched off during the s2idle suspend path. I tried many many different tactics to try
and get this s2idle part to work but it seems there are races between this and other subsystems.

What has so far been reliable and consistent is a manual call to the CSEE method that is called in
ACPI by the Microsoft DSM screen off path followed by a short sleep in asus-wmi. The PM prepare
hook looks to be the earliest possible place. A sleep that is too long ends up with USB subsystem
registering a disconnect, and thus on resume the device paths change. Too short and it is unreliable.

Some discussion regarding this mess is at https://gitlab.freedesktop.org/drm/amd/-/issues/2719#note_2181402

Changelog:
- v2:
  - Emit dev_err(), but don't return error codes
  - Add check for MCU power save mode being enabled and disable if active
  - General cleanup and rename some vars/funcs
- v1: https://lore.kernel.org/all/20231124082749.23353-1-luke@ljones.dev/

Luke D. Jones (1):
  platform/x86: asus-wmi: disable USB0 hub on ROG Ally before suspend

 drivers/platform/x86/asus-wmi.c            | 50 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 ++
 2 files changed, 53 insertions(+)

-- 
2.43.0

