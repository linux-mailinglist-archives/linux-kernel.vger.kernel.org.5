Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90037FC2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345467AbjK1SRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjK1SRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:17:16 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D0F171D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:17:22 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D8B355C0206;
        Tue, 28 Nov 2023 13:17:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 28 Nov 2023 13:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1701195441; x=1701281841; bh=iuMysMVGg8
        PJ26JKT0z4QtNuMFMPdYynoB7Q9nJhvPE=; b=SiXPgcEEeg5u0Wdwq+4s/ASRVX
        tCYN7/g8QJZnOX3hszxjP7NAWa03sl2vvSi2MaoMX738V3nqb1+baiIVZuxyYUuZ
        blddL1TQI1QxnvWsOo6y9tLQ0CwV+FmXpKKzkdDMw5MRmXNW1x9ffrOHbbxFYHn+
        GOTP5X1vGMtS3p65WUWFq2qzZrDQVDCVLtQq8MvblXhgr6SmN4MUxSP9QXGFCHBl
        M1aR208jGwokdMs4cpOvm6FrKvUQ1ZjNjfauCia56Ule27aso+ZjG3kK6bL9r95T
        3VZt3dxexAZnJ51mEuVwYYDwQfQlnMqmx8vYFIFXjzrErIu8QIxDgDyfvjmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701195441; x=1701281841; bh=iuMysMVGg8PJ2
        6JKT0z4QtNuMFMPdYynoB7Q9nJhvPE=; b=Oc1aRgNCBne59AmE42OSBzJWoz+ow
        O5czAK/+QAWF8TF3yyD2MoCX8nXv1yNd65fLtzU5v/llXgxbaa+/xYSG3wBggWN0
        pI1/tkq7E0G3PwrKennvGeTZNPdCnT5c0Lgq0qYsWFVUxIZiTiYiGnVNYXuNJySz
        JjUbfsjV1MOK33R7h1czmpRYuZNkVz3HVvSThAaL5zO80KMoAwgGAg6SUoAZEnjV
        AGNVJRXTkHCmOdsXlPH5W6gYdIkE4eqEebrh/0NXUle/1gAQq0hLUnHMUMSzQ8m5
        lsaeRjWbSYTfeau9WiEynPWA6An7bFD3kp6Q0JHScojpwf4ZiUWAJAr/Q==
X-ME-Sender: <xms:sS5mZS1p9-eoX9F4KgQuDjirDfAVOG5d1aeN-03auB5Abqtbh-79Sw>
    <xme:sS5mZVFSSFBpWOJcdgJ9QNLPyA2Pgat7iuyAOV91GLSoIBOl3OE5O3xBBJTGjO3hH
    qKDo8XLs4A-fmKprqQ>
X-ME-Received: <xmr:sS5mZa4qzEDUWFDzir1u6OOK8S3tl9-KMW_CN43r9Ak3jm56LBr1Okpn5odUdMHmqe0A_MUORXT_3s3IBcu10WY4YTAuRiQbG3sHELsv7LE2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghr
    ugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeelgefffffghefhje
    egjeehiedvgfelfeehueeuteektdffiefhveelhfegvedvveenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrg
    hsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:sS5mZT3skYZODA5XaommfwTKoTZG83kPxRbfhS_9aq8oq6ww4SjtGA>
    <xmx:sS5mZVEo4FDymjIFx57iOlJ02hsZJmcGQdxdf8DNJM2irb3lxiz6TQ>
    <xmx:sS5mZc-MPL1K-IhiqgBDAdq9mdczBre4EQWxReBqyoJG2-0xkaPmFQ>
    <xmx:sS5mZVAd1tCX1iM05QCFU4-fznv9_qm-dySDGy1tovD_pvp_HQ_dBg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 13:17:21 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 0/3] staging: rtl8192e: patch series renames (3) different variables
Date:   Tue, 28 Nov 2023 13:17:24 -0500
Message-ID: <20231128181727.19504-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This [v3]  patch series renames 3 different variables
and improves the commit message style.
[v2] Style issues, redo.
[v1] Style issues, redo.

Patch 1/3) Coding style issue, checkpatch Avoid CamelCase,
rename it nMcsRate -> mcs_rate.

Patch 2/3) Coding style issue, checkpatch Avoid CamelCase,
rename it bCurBW40MHz -> cur_bw_40mhz.

Patch 3/3) Coding style issue, checkpatch Avoid CamelCase,
rename it nDateRate -> data_rate.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>

Gary Rookard (3):
  staging: rtl8192e: renamed variable nMcsRate
  staging: rtl8192e: renamed variable bCurBW40MHz
  staging: rtl8192e: renamed variable nDataRate

 drivers/staging/rtl8192e/rtl819x_HT.h        |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 36 ++++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  4 +--
 drivers/staging/rtl8192e/rtllib_tx.c         | 10 +++---
 4 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.41.0

