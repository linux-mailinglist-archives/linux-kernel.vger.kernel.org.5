Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA487D2089
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 02:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjJVA1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 20:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVA1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 20:27:39 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C1E8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 17:27:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 38FDC320099E;
        Sat, 21 Oct 2023 20:27:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 21 Oct 2023 20:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1697934452; x=1698020852; bh=kryMgmGI5t
        6fyIo1RGSSptCRzE5dVsrPDOxSjiUIvYA=; b=bve52SAxtd/xTkh+MazBScbUod
        ZXMqXrPCQJE8piH0X7lIlHJfeEmxcGFjyskY3odniakMhXsJb69xbL3Cf4e8ga55
        +eK07aYyqKcd6uvLsCYwro5MwsbSgi1RgRVPUncaBlC/0POeiTgcnCDJDnp9hDSj
        x+wcZAuDXy1i2eumRCp8X+KYgDsX39iIml53qM0/IqNlSVAKivP1Km3zsGuigrO2
        qXRBefi+Ob5Dc4Y8hos0GIZ+sE4TTpBZpa8tu86yXiSXDU0INDwgD7NYgRvZzLCP
        FsyTmtIv/vzxrRkrC76BUMkN4pNuGY3vypH9NleoscnzAtvC9Iha560oMwMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697934452; x=1698020852; bh=kryMgmGI5t6fy
        Io1RGSSptCRzE5dVsrPDOxSjiUIvYA=; b=ufudPErV1PU1PvnFL/M4xO9kqFUCP
        CRg0mnennrJddRrgQesbLmcEpj0Y24JEpKe4aRbXdyjWazQ7dFQrff915XEGE0Yh
        hBO448G7FRCnBgSjoxGJ8CkEPDY7SrCJoRGSwnqk3GInkhm79DD96aXVIyrOQC7i
        yO6ZfZ+bgK9oaHr/qpNd0Gt0duhQtGXquZJA0K6ESKCi+49peI8RAbG02Et+KrOE
        WyDBbhyo0BW0+qdbDR7HcWe9ZH+cJ5jkOfoCyB+jxTj0ux4RazPZZG4Bn63atrZ3
        +1bRGeBIvPlyv6MqNuV+cerLBKfDdzpqnTrSUQ2rV051RkvLaXU3d4btQ==
X-ME-Sender: <xms:dGw0ZfR5479HQXkhrVG9UwJGcDahShIJM6PVdX4qZt0pKrB66RSS0A>
    <xme:dGw0ZQxBUmCDvpNI_gMJ1H4sdO4aXpFgEVYmkNI8mwx_RLGSaTR-Pr1S9ewndSTsd
    JkVYUp0JuiWoTEzimw>
X-ME-Received: <xmr:dGw0ZU3S5j_pF0FHd0_ODHPI-y0n5EnOKxpmHbfydEfN2SkWVnLxkbEA7aKCg0m9iOOTDsT3FPRAiDktlJQ1BpWZipCCkpTE9j01NURUVnY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedugdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghruges
    fhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeelgefffffghefhjeegje
    ehiedvgfelfeehueeuteektdffiefhveelhfegvedvveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsth
    hmrghilhdrohhrgh
X-ME-Proxy: <xmx:dGw0ZfAkGIBJL_70rQmS08aOOLI_H30s-thpeGGkC0JomhO2woal7Q>
    <xmx:dGw0ZYge-6QAWDEpFgdy2eI0v0FESZ_cIfXoVmwjWe7v5DdiQof6eA>
    <xmx:dGw0ZTrMoHIfdX5cT0rWmj7I2TCikMgNBMP-Xkvh4fO6HV6OomJLfw>
    <xmx:dGw0ZRu_nBX5Kp1bjew4WZ0ACfaz_UwWas4HUT-mYxRbPsoZnDUHcQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 20:27:31 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH] staging: rtl8192e: renamed variable HTIOTActIsDisableMCSTwoSpatialStream
Date:   Sat, 21 Oct 2023 20:26:46 -0400
Message-ID: <20231022002646.11861-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed from Pascal/Code to Snake case the variable
HTIOTActIsDisableTwoSpatialStream,
HTIOTActIsDisableMCSTwoSpatialStream ->
	ht_iot_act_is_disable_mcs_two_spatial_stream.

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 8868672131a1..e9d369df9a70 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -217,7 +217,7 @@ static bool ht_iot_act_is_disable_mcs15(struct rtllib_device *ieee)
 	return false;
 }
 
-static bool HTIOTActIsDisableMCSTwoSpatialStream(struct rtllib_device *ieee)
+static bool ht_iot_act_is_disable_mcs_two_spatial_stream(struct rtllib_device *ieee)
 {
 	return false;
 }
@@ -704,7 +704,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		if (bIOTAction)
 			ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS15;
 
-		bIOTAction = HTIOTActIsDisableMCSTwoSpatialStream(ieee);
+		bIOTAction = ht_iot_act_is_diable_mcs_two_spatial_stream(ieee);
 		if (bIOTAction)
 			ht_info->iot_action |= HT_IOT_ACT_DISABLE_ALL_2SS;
 
-- 
2.41.0

