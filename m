Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772F97E0E78
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 09:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjKDI7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjKDI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 04:59:08 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2071.outbound.protection.outlook.com [40.92.98.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8161BD78;
        Sat,  4 Nov 2023 01:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+EBoqOXOtsJ6QIucQRrkHqaYWSQhAH4DQtiYSZPDQDYk/tsc756VST9m02FQpDIYYmcuu7Go6CwlmNMeuUn2xqltg7PVOZ1ImUHYP6OLKWDNW+/FRbhTH/3a3Kst33Z3BnpRXsT7gfCIKU4GN627EQfNZwklM7Nnf3LZvkeR9LBpv2Xtnnl1PAUG+n0zcIu20XLzJvohYPAcKKRQQ3RzT97A0trXUYFl1w4/bi2q6NApLAAOIlw175K5IcJfl8b+eoUnwirWC2GMZFuyDwH3Ug+KRbMs9RsgFCroW6qEu4AcGsePyzcpB/KSetlgk3JMl7exr5EqtW8VP3vbm0ASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnkOIjl2W1yovzxHol++eMImW9Dec1syaM6d7FbvEx8=;
 b=YS+UUkp7aCf/HK+FsKHdbe6hBP+OvMUISolVF9ywJYqOpKJsD0DLnP35y7xnlGvTgAShxKtVRihGUxdJZFy+3thjMOtWAlIiVtdPV0GZSbuZFIRT6gNstwaOPXRAMUdoeFDPJLoatxapa62Yl6/xgwHa8sCDbCEVQ5dg14slO89V/vdErAYl8cB35Gy48gNHcBOBRwkTf9j9P58c0NlUeMKwUhbtrRUe8odvoaioOvdiidd9SW6GJCnRgNYyORne/0GBK84GqVgCy0KrWQ5ESpCiTZoYhUy0UJNmYr+xubqVFcvUv+PakbbIM7Pb70mo0ghapqzn8BrXFqUQJHmZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnkOIjl2W1yovzxHol++eMImW9Dec1syaM6d7FbvEx8=;
 b=K8EQp7upVpSfcGLBldQ0NCID2/g2w5WZWJSGODlPdV9kfusmEC5+0W6Rfh4JXrb1ZpiYLeoHDTNWjodpQBhOZLFJav6OUy25oPsQk39dejS4vCFbpDhGEd/YjZQocQEutxMlUFJfigjqDzRsLsJE7xGvmXY5Q5e7EOs07Iff2Eh20oKlAMTacHPzHnx9Vlc1ZjsmlcuOy188EiWu49zUJFGSwiHuj48qvilwv+yJaxBPFaG8UQeWVZihn9b4hnhnNiaHixoktIynSLv3staVkQQ4v1eRWd3Uk3UxkbJ8/HPAg4GrfdPoA6UHhUnbT10uulEPIXSRb/IvQXPStj28DA==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB2289.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sat, 4 Nov
 2023 08:58:21 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6954.025; Sat, 4 Nov 2023
 08:58:21 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>,
        linux-kernel@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v2 3/3] wifi: rt2x00: restart beacon queue when hardware reset
Date:   Sat,  4 Nov 2023 16:58:00 +0800
Message-ID: <TYAP286MB031530EB6D98DCE4DF20766CBCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231104085800.17576-1-yangshiji66@outlook.com>
References: <20231104085800.17576-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [apcXweCsE75gzQgJ6Wx8r7nLrqzRDQFB]
X-ClientProxiedBy: TYCP301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::17) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231104085800.17576-4-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB2289:EE_
X-MS-Office365-Filtering-Correlation-Id: c9bfb2ee-2331-4f19-5d60-08dbdd1431f6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVCASfiDHdLKARlG9DUcpdL1siqIzGqfvefLsn7ERXoaFhPI+s7lISCC8Bb8TWN0ntoExyKR7TRL3JDI2H62/CCSQU+19vXsuxOqxIVGkwsuDCWJu9p/VXULO4pQN9BtWMXe3KrmooVeUJYfLsDrrqz3zShbtMu0CW+bedJgC2rjZDeqUR4vwpf1liilIxeGZM9pNICcKd5BCjeLubcyVkvEOK7+CVfCfRopFD48RfaxPyD6SaA6XYSPRL4PDkBL7rJq4moZI9T8FxbqnM5sVfMmELxcJSFHxYto2DyDbOkCYDOjqL7Xe8qN4/DPH8T+PdeJmRTJVr6towAgjbUayNjeWuojrP7vD1nSsgH9QE1tnHpJvRyQ6GjwUqm4dpl7zYGJHz4F7zkyp36b8QsCgjuaKhyU/+65v4NddkyXF2req2LVc/UBbZmUkX80LWI/VrJdGTMogOzGCZyGUb+71bDOGthoRJ+AggGsItRNMDVJb9kKrlyHVMYrKe5jxFQ1cGWrJ1aIJO8F+a6JTkiKol4Qb/whIasw942AYB/L9aF1fqD0H/T1z+/9gOcuT1YB9w+iR8XZ6PmtgbeC1IewBAL0ueT0Lw1lxc3QJ1HO+b9nP+TNK78oWXDPzfRtyM49
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KsnkYMR444YHJV+a9xzIkFy4P9ojFQJ03P7TlRpP+Apuapoi41tRFo452Z/v?=
 =?us-ascii?Q?d8HsdUgfsp6WWE0MqEkGoBn3InFzJsxJKtUyYTxMUYlPFQKF0dMDcujh2+D0?=
 =?us-ascii?Q?RXGQDPQRQuxNSDrQygJo485UgoU16QigkdBv9q55pSSCyvyEEwLvw/EP/uQd?=
 =?us-ascii?Q?bB0dI0qRgtp3k+KHlaZ6wqjOEgQytJl9F8asFkAvMH5ScGh9BXop0uyoaI7P?=
 =?us-ascii?Q?tuEymasOVDcIOd8WDyr5gPvvs2USIchhHt3xtqKnwyUtQZI/8RCY6qqpZXge?=
 =?us-ascii?Q?NHJxxLxj1MilxltczhmE5rLBunK9jGXXZo34ks+F7Cym9tIPlPfUMwy3RQYt?=
 =?us-ascii?Q?33CffuqbsWU93djygwEicb1+8pGYnQfnSutVqCHFaTFfPZAA06lxJlO2fG/5?=
 =?us-ascii?Q?0y5O8UWRkZj5RcVb0ZuAlvAg1/j/NC+qYqOxj0a+Cw0vgbsj5E5se9z4BeX6?=
 =?us-ascii?Q?NW937WjLoojBc0Q4OBQhrN877TiFKWkhva2c7tXw1wORPUwi/YBBOkz6xqYk?=
 =?us-ascii?Q?JKnczFh6GdB9ErhqZzvpkd5oRnYvIFWSEWWrMqAlGOzNQTwbAAfFFPuVWczo?=
 =?us-ascii?Q?3qiQ6UBJfbqc/FcKB7157PrUaxCJDLbZ8db7vJhTDQl7WzbaXfz5NcN6IHEX?=
 =?us-ascii?Q?nV5lukZo1I+UY84ni+jqMhbUKN7gOaasaEWdP/VQaLL4knP1k2UlhFdShrcs?=
 =?us-ascii?Q?GPIhwzFmYB4/1LQ5QQ9v7NWeEx7RuOWlSr039pdHOZbql+5YyFg/6jbNtMWB?=
 =?us-ascii?Q?B/BSgCp+D06TeEDxCZxQcmMt2ZVhm7aHNh4Sipr+nAI+dKaEIvJTgyv7STtQ?=
 =?us-ascii?Q?CxhSSZt1jZmYAd973H6NkkhQ0ide3fGthze/NBKVfKm8/rRPF2fv+JfPcqj4?=
 =?us-ascii?Q?8A1nHblPdZGOiXPpvwirUTkhR6TftTkjHvtdzZ4VeluP0ns0p8KLPocjIRpW?=
 =?us-ascii?Q?5hchJrmZurHG4ASqHvByHvMeXpjwjyhbBx3S3MFRt35lyeC5bcvPdLqFx2Is?=
 =?us-ascii?Q?JG+xnIxmC+xPjUbLigRV923pgWzgJ+Chfsp0G7RnEhGTXgI1Xn3WXclMBoNo?=
 =?us-ascii?Q?pkwMoopuAzCbFqLNVkoSwA7iIjMFueWiym9nUWEp/PtjA/gQxEWtHJZUQlxZ?=
 =?us-ascii?Q?GeBQiQ9KOYqiD2/u5rkn7J+6cZAP3MhtokGeN5nqST3FiZb7n9EGPcDcckj/?=
 =?us-ascii?Q?dCG0Q6TeOjfyMDk0fIv5YNbX1lcKnntgWF3yaw9L9PvFaWNg9J/QeqERXq8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bfb2ee-2331-4f19-5d60-08dbdd1431f6
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:58:21.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2289
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a hardware reset is triggered, all registers are reset, so all
queues are forced to stop in hardware interface. However, mac80211
will not automatically stop the queue. If we don't manually stop the
beacon queue, the queue will be deadlocked and unable to start again.
This patch fixes the issue where Apple devices cannot connect to the
AP after calling ieee80211_restart_hw().

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c |  3 +++
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 9a9cfd0ce..00b945053 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -101,6 +101,7 @@ void rt2x00lib_disable_radio(struct rt2x00_dev *rt2x00dev)
 	rt2x00link_stop_tuner(rt2x00dev);
 	rt2x00queue_stop_queues(rt2x00dev);
 	rt2x00queue_flush_queues(rt2x00dev, true);
+	rt2x00queue_stop_queue(rt2x00dev->bcn);
 
 	/*
 	 * Disable radio.
@@ -1286,6 +1287,7 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
 	rt2x00dev->intf_associated = 0;
+	rt2x00dev->intf_beaconing = 0;
 
 	/* Enable the radio */
 	retval = rt2x00lib_enable_radio(rt2x00dev);
@@ -1312,6 +1314,7 @@ void rt2x00lib_stop(struct rt2x00_dev *rt2x00dev)
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
 	rt2x00dev->intf_associated = 0;
+	rt2x00dev->intf_beaconing = 0;
 }
 
 static inline void rt2x00lib_set_if_combinations(struct rt2x00_dev *rt2x00dev)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 4202c6517..75fda72c1 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -598,6 +598,17 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 	 */
 	if (changes & BSS_CHANGED_BEACON_ENABLED) {
 		mutex_lock(&intf->beacon_skb_mutex);
+
+		/*
+		 * Clear the 'enable_beacon' flag and clear beacon because
+		 * the beacon queue has been stopped after hardware reset.
+		 */
+		if (test_bit(DEVICE_STATE_RESET, &rt2x00dev->flags) &&
+		    intf->enable_beacon) {
+			intf->enable_beacon = false;
+			rt2x00queue_clear_beacon(rt2x00dev, vif);
+		}
+
 		if (!bss_conf->enable_beacon && intf->enable_beacon) {
 			rt2x00dev->intf_beaconing--;
 			intf->enable_beacon = false;
-- 
2.39.2

