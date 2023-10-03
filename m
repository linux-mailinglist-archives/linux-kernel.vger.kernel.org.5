Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F867B7186
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240872AbjJCTHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240854AbjJCTHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:07:14 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB5CB7;
        Tue,  3 Oct 2023 12:07:09 -0700 (PDT)
Received: from fabians-envy.localnet ([84.177.92.38]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MVv4X-1rDDg82zZ7-00RsGI; Tue, 03 Oct 2023 21:07:01 +0200
From:   Fabian Vogt <fabian@ritter-vogt.de>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: Add quirk to ignore the touchscreen battery on HP ENVY
 15-eu0556ng
Date:   Tue, 03 Oct 2023 21:07:00 +0200
Message-ID: <4537226.LvFx2qVVIh@fabians-envy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6/bSl0GhbFvOJLdGRjw2uoW+LTJqqIhl8zbVzb0If4Zp+E66czE
 z0ufViNhmJdjdf5UaipN3qhvVNaZvEa36+HcIWNp1YBQeF8NRLPrCU7WWNZusNUC5dlVws1
 jpOR3qIZYORA3o+y0a5koNL448XTboJ1Po0mi21Jo53jNivJqXizhwNNSyMFzG/sEbcD3fE
 aw1iOjLRSDc5nxDn4wutw==
UI-OutboundReport: notjunk:1;M01:P0:uuS7Q6s66iE=;OYS7ZZD1k+3WOSTUJyYVBzwAjEa
 ElQ1E6W3xPzJmtVu/ei0kRhiaqG+FQGaWsCYf9MCmfy4dSiuQPiqDt+5CcjoqNYQg6MsVlPn0
 zmqbTmvBsBBkKPszF/s2SEg6l4OZaSJoNr4v0ehiw851EU5KG/QfjCZzlkRcc102rLAynPtPW
 Mm0WqsAYzHCK/Vo/1va/6FU0CU8U+YcNzNYQSbh3hWL7r4SOVw60bIpkSiOZn0bWuebyRTF/Y
 tKIbgBuipeBefrzErqwhg7foAu1PTIBfpwhdITWGUDEmfpTJw8AxdBA1rsJvJssjK7jzwrKBH
 RpPiahYiz2Izxs/518WOT6CMB7KF57kvModzT/JIRjHahekxUxBZBRWWFcSdGuKaf+xHNkGQj
 vDYSai5dnlMPzh16+757QmPa5nlc39lQLMJKa1OSdJWjFqs1T8AJE3RVXxsPidPU6Dt5YTVDl
 qtVRUmTu73uxl3mEmRsvIaV5hnhVQ9R4FIenpF32j3RLc4WgzQXUlT326i9M3TOP5GmgCb18t
 GMm1iuAC6XB+A4fM/8BHMPsbE5U9YVEwpkDcjz8zn3EGIF6K8g24i2iG8nUSD8O2584aKacQV
 0nOIx31+NQ+EB4eUhZRUY5uijqIjuaCLZSL2yniR5zcZRZLOyEueFolQATFuzoJPuzP9kSvgV
 ZmZj2Rzs21oBU6jjz8EjaM8RZsw4iV6q4XBNMOtOxCF0YiYGOF6bLtl4veGizjDTtBeDz5SIF
 pUv60JI75w4+hm08f2obkq+ZxWcGAZIGjVXe5w3i5VhvM8SUwC1Gz2LHGl2+a5lkPgzfJO9j/
 blizskXN/b5kN4AakU3nVUvpK/15lvgCpmiY2uiVNbgkWi69alJmFTtl58ZPDR3MzvuUCiS22
 XgQHmS04EjzlNcT9yeGKzKFCL5Z2FvSMsgo8=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like various other devices using similar hardware, this model reports a
perpetually empty battery (0-1%).

Join the others and apply HID_BATTERY_QUIRK_IGNORE.

Signed-off-by: Fabian Vogt <fabian@ritter-vogt.de>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7e499992a793..e4d2dfd5d253 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -425,6 +425,7 @@
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_13T_AW100	0x29F5
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V1	0x2BED
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2	0x2BEE
+#define I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG		0x2D02
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 0235cc1690a1..c8b20d44b147 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -409,6 +409,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{}
 };
 
-- 
2.42.0




