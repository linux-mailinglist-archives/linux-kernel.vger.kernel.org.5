Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECDE7FC897
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376377AbjK1VO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346892AbjK1VNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:13:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA275275
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:09:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAEAC43215;
        Tue, 28 Nov 2023 21:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205774;
        bh=wGerALHB1li2fauS0519hOsVYqmOq41MjVCfNxMpPIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D52muM40oVRYlYgrBvyH15uxSfFaHiotvBw3z6W1L6qlrDMUeEWA6PdnZGPfq+lhY
         +oGZIaIT92cmDCxpEhGhI/Rx4mGeE8qC+yVmMctqVfjVzo6b57bSw/t1ztseCCz9Po
         V9XKZC1i69wf9YUPkX+HUaqBszi2gshWG86ccEb/9iwpUiUgf5gQrb8phzkhh4j1kb
         IzWYDRm4nD7/MTSE+KxkNDISeQSv1MoNhV33SrpDpFqP1P4JMJCWegXMIVXxeSGRpS
         /r/xesOBqnJBM0QidNkbEc6mKdZ8PZcCVYPxc/unPJfw0dNrNZTAwiVseiRq9zuD38
         ZLG4AVxDM26mg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lech Perczak <lech.perczak@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 13/13] net: usb: qmi_wwan: claim interface 4 for ZTE MF290
Date:   Tue, 28 Nov 2023 16:09:07 -0500
Message-ID: <20231128210914.876813-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210914.876813-1-sashal@kernel.org>
References: <20231128210914.876813-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.202
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lech Perczak <lech.perczak@gmail.com>

[ Upstream commit 99360d9620f09fb8bc15548d855011bbb198c680 ]

Interface 4 is used by for QMI interface in stock firmware of MF28D, the
router which uses MF290 modem. Rebind it to qmi_wwan after freeing it up
from option driver.
The proper configuration is:

Interface mapping is:
0: QCDM, 1: (unknown), 2: AT (PCUI), 2: AT (Modem), 4: QMI

T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=19d2 ProdID=0189 Rev= 0.00
S:  Manufacturer=ZTE, Incorporated
S:  Product=ZTE LTE Technologies MSM
C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms

Cc: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Lech Perczak <lech.perczak@gmail.com>
Link: https://lore.kernel.org/r/20231117231918.100278-3-lech.perczak@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 5cf7f389bf4ef..3d342908f57a0 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1225,6 +1225,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x19d2, 0x0168, 4)},
 	{QMI_FIXED_INTF(0x19d2, 0x0176, 3)},
 	{QMI_FIXED_INTF(0x19d2, 0x0178, 3)},
+	{QMI_FIXED_INTF(0x19d2, 0x0189, 4)},    /* ZTE MF290 */
 	{QMI_FIXED_INTF(0x19d2, 0x0191, 4)},	/* ZTE EuFi890 */
 	{QMI_FIXED_INTF(0x19d2, 0x0199, 1)},	/* ZTE MF820S */
 	{QMI_FIXED_INTF(0x19d2, 0x0200, 1)},
-- 
2.42.0

