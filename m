Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69D07F934E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjKZPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjKZPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:17:08 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEC5102;
        Sun, 26 Nov 2023 07:17:13 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 180905C0112;
        Sun, 26 Nov 2023 10:17:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 26 Nov 2023 10:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1701011833; x=1701098233; bh=QF
        o1C7nf0MwnRndvr35f92S5FiUlHM7+325TxLkWkMo=; b=e9CvtPcbMsXDV7nN2s
        33kDEtKN1YM4Fe6zqjOGHuIo1MNEbN5KXxsxjbcJA83Yh3+qeNS1kU0yGLpVKFJ0
        Ui0lbztiYsLtXgJwwX/Wqw1SW/+V9EOYJf18IlxlM8RJ/UUEvIyMjLAM4JZAOb2V
        x2aJZGtailchpXo6fDBkc6gFuWb8G5dytf2j2xo6hWKM1XiacyCmfngVhLm6h0kT
        cie56h/lBEAZEqfjg8gh9RiSBnr3pawI3KxO/RWmt1VrUujOGXxCmR0ZCGEetNVd
        Z+wnxqd0sPM9nsfI6HTQBdA21TN82l0OOFmCIEjUhvllzB+JqEw4Sxya+v1vKJMr
        IPmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701011833; x=1701098233; bh=QFo1C7nf0MwnR
        ndvr35f92S5FiUlHM7+325TxLkWkMo=; b=qRKwNWyXT8W10kHBnVo1h/CL/ADES
        LTNBm/q6spdLF6gZbVjH54HwV5b/vtrGHraeqTysT0RuZMcmljAYx6Vls0ZeSunE
        Ut5Brwx0Ptsh9xraQuo9zhewwHw+fhm7SJOvoppLvWzNBW117XS3iVIJLgfcQJDs
        6JPVQQy1SHs6mCF3CGVZmlaemI4bL239g6zOtCnxWPfGpmHnXDynshDts51LhrkM
        SK6siQtV9zkyds1hLuM1LnjpC+iWM5inyTjpdwsvxHfVk0BNWqpv9MjMaIPb6XLv
        fpZpo0BdCKu5zlNTX6/8smP9bwftyduLJDGBoNvkG8f6UL7Q8HmD9w6TA==
X-ME-Sender: <xms:eGFjZSjLUQyCq9G80ghEzFYVXz3yQ_uGWLyj_XUYqda1SYJ56Q3cmA>
    <xme:eGFjZTCML_wgvSqZ7oa6-coh1f-8Vj_Yzqh6dQOGpiOgYJn8BrH3DTbFUhcnHe-vG
    hyPqbRKESm3MRS-ytY>
X-ME-Received: <xmr:eGFjZaEo0uv01VOKf_8jNA3k4sZbLbvmIpYWKdsRZ9XQrMRVoMV5gXveXRyMeYPtKHjpaTGZxgiHJC-i4hQqopQpaLRSJRlX2coEIIuz5FetkoCJWu69p8pVcnZ9o0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeeludffieehueevtdffvedtueelleejuddugfettdevhfefffdvgffhjeehgfelleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:eGFjZbReS5BHUjZ7cy3whRM2VpKb-bfYx9hS34v-rfJMTWHrOmhFsg>
    <xmx:eGFjZfzOYMm7XeERhn2kedAVfU0p8qPLbWSDv9A7JbSruv7MKIw8nQ>
    <xmx:eGFjZZ4lZZH1xs16TrcaZb7VtC8iM9I6dIwMGkJjtW6egrXxVdyRKQ>
    <xmx:eWFjZSqV9NBPbDcREE_8VXXhu1OiVQbzOp1ro0xgcbwu7LOoBOm5ww>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Nov 2023 10:17:10 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Apple M1 USB4/Thunderbolt DART support
Date:   Sun, 26 Nov 2023 16:16:58 +0100
Message-Id: <20231126151701.16534-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The M1 SoCs have a second slightly different variant of the regular
DART used for the USB4 PCIe ports. It supports 64 instead of 16 streams
which requires a minor change to the MMIO layout.
There seems to be no way to tell them apart from the regular DARTs by
just looking at the DART_PARAMs register so we have to add a new
compatible for those.

Changes since v3:
  none

Changes since v2:
  - drop the manual bypass disable
  - added Rob's tag

Changes since v1:
  - apple,t8103-usb4-dart instead of apple,t8103-dart-usb4 as the
    compatible
  - collected Hector's tags

Best,

Sven

Sven Peter (3):
  dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
  iommu: dart: Write to all DART_T8020_STREAM_SELECT
  iommu: dart: Add support for t8103 USB4 DART

 .../devicetree/bindings/iommu/apple,dart.yaml |  1 +
 drivers/iommu/apple-dart.c                    | 35 +++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.34.1

