Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76C7DA767
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjJ1Nwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjJ1Nw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:52:26 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ADBED;
        Sat, 28 Oct 2023 06:52:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 692505C01F7;
        Sat, 28 Oct 2023 09:52:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 28 Oct 2023 09:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698501142; x=1698587542; bh=fRFxfVZQMQ+iwmH5/1/sMEmpdm0BY/1L6Uv
        PQZbT4lQ=; b=zmZJXQ9YDU7awpWx+y1cysOqGRW9cZMsJUQrfrG291SQm0tFRRt
        Za+91lGmTbRyS+acymZPbOdk9Z+q0nxW1h505j1eVhkstNfGmC/ZO0lUM2vklRTI
        zPxX8Fj5hof1VDSGcAnJvSkS2oEzmyipfWbDFtO9uoyRPkYmh0keWgWqbJPb50ta
        nBYPRTS+6/56wEERfg0464P2ywZpBfWPtilWgw5Ya3pADJGGq1ZAuywMevoJjXQc
        WIJQpQaIDDdopbRwF6zs2LdMSyyFwrxheaDwLWLB5NOtjwHlRgPmrMDyKg5u3rRC
        wMzT1wTpjRPl6YTy5pTB21Q677pvZFpp+bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698501142; x=1698587542; bh=fRFxfVZQMQ+iwmH5/1/sMEmpdm0BY/1L6Uv
        PQZbT4lQ=; b=R0M3/aJsdpD8XYX3NarQWs4ItYGvrRcKK4yAhLYtU0EHiRGCOIw
        eMzfxmeF+iBp49oQsHgpxwiaodc2+7++kCW9wVxdB1icDLyVSBaH4CPHvztBTNrG
        gMfJSaRcaFg5eoApDm0FFXsQCoyHI3czwiRrsQGpPV3HKwRroYSqKmvQ+V1lZzeA
        LUwQD0DejcEdUhUxPDSFkIry+LN5HWZZN4ANtEiQt7D/ZLtr+LV6FZwzKHY+IfX0
        +WGyahKwd8qTXopyHQMoaAZY3jCMR9cMac1+CwQ4mv8irCS8q4x1UItXTTUrhehJ
        c5HiucBk6tKZPJffTbH8g+HLCIUKMOiHVUQ==
X-ME-Sender: <xms:FhI9ZUM93rRYpc63YSpIZp_PwjwvmrtETgQn0aVhsxA1acYBIfTtwg>
    <xme:FhI9Za9jZIloGsv3pREm--SdpWGDVng16p7NOB7BNq6VAwUWYRMn8GYkyxQH_BjX5
    oHzPYBoLVsloqve3mg>
X-ME-Received: <xmr:FhI9ZbQDAlCLAwQSyPgl1kMkx6kkfA-gD7d2n0CehcpIHuxPurKWe8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeigdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
    geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:FhI9Zcu3AqeWJMKP0i2Iq-hLK843v_HJGSF_9lUhcjctthaoTXBztg>
    <xmx:FhI9ZcdnsEKUk4AjxeGBHp2Ie-UoCDh2NlA5jq2HJUpxhCNnpH2kJg>
    <xmx:FhI9ZQ2Ws6Bi77uR3trq8pZoai-HJsLMOoE8mQR0lY-v2lMQcUplnA>
    <xmx:FhI9ZdoGwH6nc0OCq4pX0juSz7xYmvsAlu7rkRg6OXbVZYtuyapk5A>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Oct 2023 09:52:21 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sat, 28 Oct 2023 14:52:17 +0100
Subject: [PATCH 2/2] MIPS: generic: Set SPARSEMEM by default for 64BIT
 kernel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231028-mm-v1-2-45377cd158cf@flygoat.com>
References: <20231028-mm-v1-0-45377cd158cf@flygoat.com>
In-Reply-To: <20231028-mm-v1-0-45377cd158cf@flygoat.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select ARCH_SPARSEMEM_DEFAULT for 64bit generic kernel build,
as all platforms supported by 64bit generic kernel have a hole
in their address space.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d12e8f3c1d08..fad05f699efd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -133,6 +133,7 @@ choice
 
 config MIPS_GENERIC_KERNEL
 	bool "Generic board-agnostic MIPS kernel"
+	select ARCH_SPARSEMEM_DEFAULT if 64BIT
 	select MIPS_GENERIC
 	select BOOT_RAW
 	select BUILTIN_DTB

-- 
2.34.1

