Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA2A807C02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379530AbjLFXDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377430AbjLFXDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:03:42 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0189F98
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:03:48 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5703832009F9;
        Wed,  6 Dec 2023 18:03:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 06 Dec 2023 18:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1701903824; x=1701990224; bh=LmL8rLUL8C
        UN1kqK3NdJIJmS1N3lrb13wkKpEFgx1qg=; b=lMAp9ijMN3NXkt8U9ZleGvglLX
        VK0gcGCx+g5EmGZcwSsbcuHxPRk2VLlEz8JerWCC3javypy/8DAgjQOJepQvOXZj
        N1Rvm48UV8nDD9W2z9gRinX8lTOab6dsu2GOoucvIGbOxagc/dxbqf2+mim9SkaT
        wy0LC7V3E8PbNucD0OxLBVcQ/1e68P+FhrdUDjGhSdJnVpw6fsyGe/LA0JhtaLjc
        Yn4o7JVk/Ob9qn/lg2hBbT2qOTlfKDC+7cC6yIIfhvBBS5W3wi5MMBHWUzv8M/xj
        iJVk+dancDyVgQ63ZnzU7oAvspEMYK4SgPm4YDVuacemZrHsWFiCZTv8WD+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701903824; x=1701990224; bh=LmL8rLUL8CUN1
        kqK3NdJIJmS1N3lrb13wkKpEFgx1qg=; b=3ZWDDJVul6/I1mvoL9uwmXp/aMNEL
        g9f+AfmgJqVt7Jao+W97jkD3sSWK+LXeiavg8xIiYHCR0dcg7BFZrpYPBeRAS1lr
        xfnZoQi51TLfWAuwcMQL76izLGQ4BJ0e8PVoXriuZUohwQ/XBd9WJ5chg7+EVrPR
        AHfbdf8cSbcPxeEWHN2FxhrXaWUwlFE2dvY7MTOiyKEcP5PIz/uXhKSyIVkLPFbd
        lDsq2FBD2ELYPng+8/o90Iqoj9r76bdSIZJ5TKh0vmXxpXFSt2MRvN72gK69+MmT
        SfMNf2NylX6l/fO2wwRqJF0dPmEW3DX4qD2JLdtaonfloqTo+f3bvV2PA==
X-ME-Sender: <xms:0P1wZQ-4Z7nHb3EBhqm-qkhP3ZWMfTVRepUq8oQoh7NoOq3QI3pA6w>
    <xme:0P1wZYv0UBhxqGTsuNaya57YqvRVL75tZEqDyzyUFDJvITHSj5_sS32WCqxUpNziZ
    6BvI_imT0vPnsSad34>
X-ME-Received: <xmr:0P1wZWBZsQcpSLSe1vayEIzqrHpVts1ZLAPH86uM2FAT56W2RfpRbu-_BB_AUGJZEyvITE24vpX6T9NFOmsYnJ9S9wKynEzEgAyR65yj6Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:0P1wZQe6MobTFDPxDr4z6rmDAJHo9R_jz1NKoo_20gOqt8RWH2aWGQ>
    <xmx:0P1wZVNDc4PWOX3rbBtxjMKT05zgBEeR1jGnvcNDWn35gCelK3CcJA>
    <xmx:0P1wZanY-hGw48C-K8jW_SNn2Omzl3eSJv7QJ4mrl3fKUo_TxcDO6Q>
    <xmx:0P1wZWpK_EqgtmCoooVM1JRs3z0S0ChNRpo1M3V-saMeqPS_9My-Zw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 18:03:44 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 0/5] staging: rtl8192e: this patch series renames (5) different variables
Date:   Wed,  6 Dec 2023 18:03:59 -0500
Message-ID: <20231206230404.1721-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series renames 5 different variables with the checkpatch coding
style issue, Avoid CamelCase.

Patch 1/5) renamed variable bAMSDU_Support
Patch 2/5) renamed variable bAMPD?U_Enable
Patch 3/5) renamed variable AMPDU_factor
Patch 4/5) renamed variable MPDU_Density
Patch 5/5) renamed variable bTxEnableFwCalcDur

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>

Gary Rookard (5):
  staging: rtl8192e: renamed variable bAMSDU_Support
  staging: rtl8192e: renamed variable bAMPDUEnable
  staging: rtl8192e: renamed variable AMPDU_Factor
  staging: rtl8192e: renamed variable MPDU_Density
  staging: rtl8192e: renamed variable bTxEnableFwCalcDur

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  2 +-
 drivers/staging/rtl8192e/rtl819x_HT.h         |  8 +++----
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 24 +++++++++----------
 drivers/staging/rtl8192e/rtllib.h             |  6 ++---
 drivers/staging/rtl8192e/rtllib_tx.c          | 10 ++++----
 6 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.41.0

