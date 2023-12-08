Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C438098E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572947AbjLHBzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLHBzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:55:10 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FDC1AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:55:15 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 29C195C01E3;
        Thu,  7 Dec 2023 20:55:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Dec 2023 20:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1702000513; x=1702086913; bh=lWbZlWE3Gw
        6TSP0bn7EJqqiULdSdKNLmb8kyG8xoel4=; b=VvuXqhYn/Cu08+8oPMTrBfgite
        N3Kv5mFHR7r1WFQM7UrruqBxV4guhB4/UCgebtEjLose6Y9Vz2z+fOl5RJoSfseW
        B+Y2ps4GWjuOywAMeTwL6wShA8bYX6jfHb3uvsLrlWO0QR/wEhZg7WkOtWBio5TN
        e0SDIL3P0pHhcWE5wKOAwEPZuPmLUg/y5zovaNzTK4LAs0UM8Btw/8jeUFJFg5wl
        Sz9Z/0JiesuA1ho6IFBDkpDVa3/YVp5cBF6SFy2+9VvHozjRj6pYRBToJ0ISZbeP
        HLnkftOpGQ+ttTSL0C2/ISb7YJRJ9PEgsaN8ZiZ305lP4N2DI+04bk+ze+yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1702000513; x=1702086913; bh=lWbZlWE3Gw6TS
        P0bn7EJqqiULdSdKNLmb8kyG8xoel4=; b=eXqVHWo8IGJ3TPKfFWd9r2TcbLFX3
        9jqL14GBH575dmctmNyX+BhmdHGCMtl06+G3AF6ncYdy2NApx2qLGIMkaPA9m8ac
        039VUwmtOKQ0McFwnii+2XMtjXWgSgOLSc3AhtPpu1KxBilVNW61qNNLmMAc1lr0
        zKQaHwTclqDbZQW42lviQo34nBhD/sofWl/YFYUG5M0X+JeGUJK9x8AxVZJNZFX9
        rbMmUUrMsc1AeJRrb/HtixTodVJAOCP7DfNRGBQQpNuRwdolUI0zPVkngfL8c4CA
        uyxzJQ7FvUV6lElJ+F4WAkdprEq2dUCGbl70lbCCWO0KFwzCQ5Pg25ZgA==
X-ME-Sender: <xms:gHdyZQzQ7MFR0gG8g1215u2pGNAmXTG5D9ueZn52ozllJpXmRTw9xg>
    <xme:gHdyZUR5xc9YXjEPHOY7dE8FAn6v0HbUlTRU-uUQGK_O6ZYEY262fLDjeaIeuG4JR
    _9eBQdU7KNnyUcpbrU>
X-ME-Received: <xmr:gHdyZSUSGJxgTZmajLhNXDmBHiDTb5qQxqCWywI6240ZYnT2DpJLBFQMbAdVFuRdVC6iD_FUGMEzYXtFC58ej0dSiA2Vwopb1h4dvIeC8pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:gHdyZehjjCsHQwpDpYPvOKrUGw4W_S3Y11cpWnOdDr9x_8fQ_a5oDw>
    <xmx:gHdyZSC-rDKFdLt7bLgVhjy36bD71F6ra0und2gaq1jf8hyuDSsU1g>
    <xmx:gHdyZfJPxEyvEwRs54b2qKGbyWdU9rd0eb8rFzjV-1qLMKiSP44ZXA>
    <xmx:gXdyZdMBmJRp5fhMk834BfWEoHf-r1FaTaWyQMC17Rs5IGNRxUoXCQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 20:55:12 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 0/5] staging: rtl8192e: patch series renames (5) different variables
Date:   Thu,  7 Dec 2023 20:55:31 -0500
Message-ID: <20231208015536.21013-1-garyrookard@fastmail.org>
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

This patch series renames 5 different variables with the checkpatch
coding style issue, Avoid CamelCase.

Patch 1/5) renamed variable bCurShortGI40MHz
Patch 2/5) renamed variable bcurShortGI20MHz
Patch 3/5) renamed variable CCKOFDMRate
Patch 4/5) renamed variable HTIOTActIsCCDFsync
Patch 5/5) renamed variable IOTPeer

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>


Gary Rookard (5):
  staging: rtl8192e: renamed variable bCurShortGI40MHz
  staging: rtl8192e: renamed variable bCurShortGI20MHz
  staging: rtl8192e: renamed variable CCKOFDMRate
  staging: rtl8192e: renamed variable HTIOTActIsCCDFsync
  staging: rtl8192e: renamed variable IOTPeer

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 22 +++----
 drivers/staging/rtl8192e/rtl819x_HT.h         |  6 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 58 +++++++++----------
 drivers/staging/rtl8192e/rtllib_tx.c          |  4 +-
 5 files changed, 47 insertions(+), 47 deletions(-)

-- 
2.41.0

