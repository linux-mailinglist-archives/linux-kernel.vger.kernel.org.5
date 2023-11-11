Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB37E8D16
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 23:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjKKWRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 17:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKWRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 17:17:53 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A57030D6;
        Sat, 11 Nov 2023 14:17:50 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AF6453200902;
        Sat, 11 Nov 2023 17:17:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 11 Nov 2023 17:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1699741067; x=1699827467; bh=c48DBOfgVp
        eDa3sB5YGp5kIVd2kfZONDSWIzOlaX3HU=; b=Vkj+5/h87hSL4lrSt4zApn/c6Z
        j3oB5AtWOgDYukeunId0KJQDy+KFsYTWQiqBdDl4uagEkpMDEHST5cskt7coFTNq
        sMra/BLpz4RGY48jR/xuuGfg72Ntj1C0KtA4W1B6eFdQttkHXJSrWO+mqP86x9qx
        XpkBJVNFQKBkdO4Y5HU7r1jNzyIRuA2D8wv79YbS+ZYGtgMme/QV12c69up+jF1H
        XWbFdEBWBosnHcdFIpUapoppmnBpn4677NlnhouHYawjo6q+l2U0P8ZRK6byT623
        sGyVWmujrPq6M+hGFocbj+BKOKHrKNvIzDsz15r7/vNtKxbJv03BX0epO4lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699741067; x=1699827467; bh=c48DBOfgVpeDa
        3sB5YGp5kIVd2kfZONDSWIzOlaX3HU=; b=tHSFGYDd+9bDWgTQFirVYFqvv4GJF
        DiXHjYKTOMSUKzQa7JH7cHebbYjp0hvFKGDrO1FdZnnHOOPDeEjnVn1yQB8w1DcZ
        X58dpMm9zMBHiMhE4fu3OEDBiLu8uHD8AdGpts7YpaRu+f0uftN1w8y2NKce5w4Z
        5hKEJxHvjH0ISxQ5gdbUuJH7pdNNJJzBVhhX79JQ9HsIT0C2DyzQDuvCej/Rctz9
        yPECcuhqmMg2IvCe99ru9r7lZHGJnxttajrlBmNf2an+IDnXC+dfO4773ldEkkxS
        QGRdgCbxR96RX+CuYetMYFshvV9wqn9v/rsfejf3SqFevjYkoky3zkNsw==
X-ME-Sender: <xms:iv1PZY_HzxKoQ37tvYAiNGclbZQ1h1CeeQV0_cDqoHaTpio-fWLeJQ>
    <xme:iv1PZQuOjPGdISI_rlpPAB37WqGlxj2XQDAsf4_7LsiSvkWEKEyzkDuO3Ke3N7FDe
    hjooZ-EHRE68M5nZw>
X-ME-Received: <xmr:iv1PZeC0-pMPmrMJPDEis1MVhiMDf5vOK-9o3IziKnkB4jtcmdF1jx7XcsxfyoNc_jx9TIzUgmCe7Ons1QNhz-yjpOLEWCHw7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvhedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghnucfr
    rghluhhsuceojhhprghluhhssehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfekvddvgeekhfejudeiveeuiefhudekheejhfelheduhffhleeggfettdetuedt
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhprg
    hluhhssehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:iv1PZYevo4MIzxamVJsX2tViCl8wY7yE0ZRq5TkFhoEClKXInjdHdg>
    <xmx:iv1PZdPKHDtnHIq7r_wOmXgfdkksqSMjWtYt6LlVGsGs7GIqRLR69A>
    <xmx:iv1PZSmK5n4PHf_Z0MoO589-CKeb3NhxiV4TaNhoUi6Mf-x9r5iafw>
    <xmx:i_1PZeqrHODSPMqaLNe7--p8AAiLyZ4EyFdqzm3fGsecJOFfbwkw2g>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Nov 2023 17:17:46 -0500 (EST)
From:   Jan Palus <jpalus@fastmail.com>
To:     Tobias Schrammm <t.schramm@manjaro.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jan Palus <jpalus@fastmail.com>
Subject: [PATCH] power: supply: cw2015: correct time_to_empty units in sysfs
Date:   Sat, 11 Nov 2023 23:17:04 +0100
Message-ID: <20231111221704.5579-1-jpalus@fastmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RRT_ALRT register holds remaining battery time in minutes therefore it
needs to be scaled accordingly when exposing TIME_TO_EMPTY via sysfs
expressed in seconds

Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge driver")
Signed-off-by: Jan Palus <jpalus@fastmail.com>
---
 drivers/power/supply/cw2015_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index bb29e9ebd24a..99f3ccdc30a6 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -491,7 +491,7 @@ static int cw_battery_get_property(struct power_supply *psy,
 
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
 		if (cw_battery_valid_time_to_empty(cw_bat))
-			val->intval = cw_bat->time_to_empty;
+			val->intval = cw_bat->time_to_empty * 60;
 		else
 			val->intval = 0;
 		break;
-- 
2.42.1

