Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12AF7F6A45
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjKXBtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:49:30 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2050.outbound.protection.outlook.com [40.92.107.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55665D72
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGPb5B1g6ZHwV+r4Mdm3wwUlg1hIsLwyYWlikWYbyv18XU95fSSDFhXuTjHkJQPjg9Dsz4lEDrZ0fYZ5GRIWc0TD7BFumSk3SA/xN2DaBs9gMF1IgY5oU0ZRI5QfvklniRZB7tbZndjagR8HzfHa3g9+6OAvSiabbIyriDNsuQG+4SnM4TAqfIDPXB63TOTZvXBbt879Ry38NUwESZfSbHQWMQuBxdJiDWqV+XW9eCSWdzZgqky3jgrI/5gMChx+ddsWGkL/Mkm9dsSXnSpRIAfKT9giNw3ELL2lCxEOfLXF1h9k/3XYwDmTQLS3CM4j3Oyn8EfVyASqUI7LYwRdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzfOH4PPxZYfmcJ48Ktf0XGtwpw/XSd6NX54XDBk8xU=;
 b=ESxm9vvKD2mJ6rjUyzRjPl77D8+9gQ+ffUZq7JV+XTagAE152i1o/tEy+H8+GJ2oprtyv55nBONFGT8us4x8BxtiY119cY0pQpbTwMOOMMhxnaA8ktbavPc+w9WekI7Sc3fTxKcVvQxYRQapC8nWlyPch69itgi+yo5X9X3bnPyXWTOgAYJx8b9taRdG1iEdNOt3HSCvdJqpbosQB/wBWWzi3yiB46BRcU3uCFkNciawxx4vqLvsiRbFq7rPd2lWSJN8zOkQcodOtcwTBYe5itrKKQgj1JcADVl3waGYDh6+Jcp53cTvq7tqFQC237UzmsRalPcoVOW8NFQ3rfd4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzfOH4PPxZYfmcJ48Ktf0XGtwpw/XSd6NX54XDBk8xU=;
 b=ZZKF4niq3yNrKRsae8ZLKWXCPR2yqJFUE+VkOI/H50gLRcGI2wBb5Smjz/MrG9t2yIt0+SgCT77mOk6S67x/vRMXcdRRbqaBhIScfFv2KVGbho4/83shMMHUZDr84LiRpfClA1SiHK7Zcm04kol6+a2BaaYWc61cMgMredfMjJvkb2VsXiNmS/yRn+AJR0NRTZxSxwhb2o5EnR1p1gh9xXSrybOOKlT/bQ33ZOYGfflT/kDGP/DcSVD9pGwIr2Dyzm+krPkE0GKptMSHcqDUPSdm6Q9Exoz+5Tmo8zyMeF5GtgN9tONOnhW4t2c23Nv1MRNd4dAtnBuhYsihR3iHLg==
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9) by SEYPR01MB5145.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 01:49:33 +0000
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::5074:605e:7b60:3ad4]) by TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::5074:605e:7b60:3ad4%5]) with mapi id 15.20.7025.017; Fri, 24 Nov 2023
 01:49:33 +0000
From:   Yaxiong Tian <iambestgod@outlook.com>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org, tianyaxiong@kylinos.cn
Subject: [PATCH] extcon: fix possible name leak in extcon_dev_register()
Date:   Fri, 24 Nov 2023 09:49:13 +0800
Message-ID: <TYZPR01MB4784ADCD3E951E0863F3DB72D5B8A@TYZPR01MB4784.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [KW0uat3i0q58Z3Mevc3Qv7LXZAUSmM01hGcZzGLUTcbWtGYj//n4sUBjY5tEBtJ3]
X-ClientProxiedBy: TY2PR0101CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::29) To TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9)
X-Microsoft-Original-Message-ID: <20231124014913.19395-1-iambestgod@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB4784:EE_|SEYPR01MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: eace3cc9-2153-441a-0de9-08dbec8f9aba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGG9MXnQD0Bn1MNoQTo5xwRY66MFEihhWleF7a1xJwwqw8gTQaxlXvsYWNf1HZ94oUxRcmyLGW3MFFa7xU//2plDZCtJjoaiVWU2zItA+X4wzezsj6y6gP1T/53VuakySXUYZV/IXZR20fpDsloIskwC2nvrNaa4vllDZpoUp5FSWMEkrW+lrdAojvZ+7QSBn9aRq4XqNdl3p4LCdVsgBliVp99b7cUe8lw7dSCBv/+kb2mzg0PAGu3FtLXwcGUCTZHIVXPS0Gg/vKrgee5attt0Mqjsvez4zsnmWdppt609eA1d2ZgNMYlO8t1SMbQl1K1sL/28V9ivo7sB3hYDCRSV+qvDaSLHRn2jMnlHwxpBcUYnJxatfT4HkEQXMVRpzOu4k1+R5N0w1A6XATPeYw8wsl8Cb3T7YB0BlAHbW/sg5stRZgCIU/kNX9R59dGYad6oS2OYTRHGTnXtTpbNyuCGP2nAtKFTAiUwMs1fA87YgfXiEh+GMm2Wv4bEZNbwWpCDwmccSZRiPH0oTtVvzPbOL22RjCjEwuZOtidzTtRA5Wgrn5mFpcnfose1bhri
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RIz5UQ+HgW+Ma5WYFCu0/5caeU5S3s68MRWdJ61+fqYXmJdx+xovXPNQg9Wv?=
 =?us-ascii?Q?Ef1OmR38rwavYewndsBhPU3G2e0BNFAYw2vsdqp1yU72PTrysJWkN05gUg4B?=
 =?us-ascii?Q?AuO4o8USeXIwXNmvCYxoLu+tybYgEtlLTfz6brwGdy5lUVKYlKleQ+gZ/HNo?=
 =?us-ascii?Q?5Uu/jseNBvs70Tm6hQiPZXTEsq/ocHWqODh9Eld6E/ipfR3eD9e2SeVqT83R?=
 =?us-ascii?Q?+YEjPbrGQym+QNSA/LTz/gfmpxQO+AF4d8sI82HqMpCONSLYDro79SenADIS?=
 =?us-ascii?Q?TR2qoM2E0OndQ2RqBPZoaeZz1yCl289JVbO268LYt6roj5pyrTqd0CWxlHtt?=
 =?us-ascii?Q?s3l05FVM+f91TzSyrtTp765l0ullxgz1QhropRE16Zb3Wl+5hajbfTbasnac?=
 =?us-ascii?Q?hq7UQgnzpFKXuPguOu7ZEcxfPxvPkd4JQ5P+5MGCWXCMyQ1d4Zi+xNbT8i0o?=
 =?us-ascii?Q?rst5lu1/bQ0rcGzm9AuLkKjmY4qrf338O/lHEv+kjTjscc6kZSgh8OlitJFX?=
 =?us-ascii?Q?dCi2KYSmlkaB5GOcvEg8WRdDvlhf7ICeqkkYWAT8GTg36BJ8KK3L5gAP3nz4?=
 =?us-ascii?Q?041gTmEtF7IfODxo/6Y2ZEOCPPD5fapdwztRxmR/j653TgWOTcO/6OikkKB4?=
 =?us-ascii?Q?wF9Kg/2dnojPbo0DgRyBIoguRBUIp4EJZ/XoCUKxW+zdfnWhzuULKfyI0zO6?=
 =?us-ascii?Q?+Hjh5FTIP+2w10j/FtG1ZOl/vYaWH4PYA6PdaVro02HKsZFVcW2kojXNJULl?=
 =?us-ascii?Q?R99HGLhTk9AcD2+JhgewdeNFm96uY2FCERSfTZ/fFAjIDnyBM9Quo/EeMWhp?=
 =?us-ascii?Q?KdfcKpqkrn0QjGIGT2inGP3OFOiXMIPw7QiX6hRWDyQm8Vcj0NX7zu4JAy2G?=
 =?us-ascii?Q?efzjUGTrKDd6guVP7LWQP+Vie69CLg6Y7VD9FqW4Sz+wRy8M9hW8PefLrD+B?=
 =?us-ascii?Q?vBqyYnQjXW5eLJHLBsvgtnGly3D+kiIgtlt2L8PSgZP5DklhaNyQydA9FWog?=
 =?us-ascii?Q?QKNMz72jFW5tfiIQ+6JREWT/EP0kizTgVJehKwb7tuAIokBqiGW80MqnUJmh?=
 =?us-ascii?Q?XbwNtLB5CEJNRsTdOZPGlcE/uuAO+LS+kxiTYN2o8DULyM84xj6HonWPpZnv?=
 =?us-ascii?Q?7LexNa5nL0uDY7vl0NIGCKVRjAkkKW/EsNn7EhjfFCZEPEwbVhCxOKCqNvjU?=
 =?us-ascii?Q?pTLhjV3+TcidXDzl9EeJy5kjsT+KOpU6BsTnpgHiUDWCAv3gPngmdqwrbKcX?=
 =?us-ascii?Q?RljRrHCLeG+Qmph2kUUhS8DR6MGthpmLOHN6dpo4GpzFkec6rV2Kjfd8S7uk?=
 =?us-ascii?Q?9rI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eace3cc9-2153-441a-0de9-08dbec8f9aba
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4784.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 01:49:32.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

In the error path after calling dev_set_name(), the device
name is leaked. To fix this,Moving dev_set_name() after the
error path and before device_register.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/extcon/extcon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 6f7a60d2ed91..e7f55c021e56 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1280,8 +1280,6 @@ int extcon_dev_register(struct extcon_dev *edev)
 
 	edev->id = ret;
 
-	dev_set_name(&edev->dev, "extcon%d", edev->id);
-
 	ret = extcon_alloc_cables(edev);
 	if (ret < 0)
 		goto err_alloc_cables;
@@ -1310,6 +1308,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 	RAW_INIT_NOTIFIER_HEAD(&edev->nh_all);
 
 	dev_set_drvdata(&edev->dev, edev);
+	dev_set_name(&edev->dev, "extcon%d", edev->id);
 	edev->state = 0;
 
 	ret = device_register(&edev->dev);
-- 
2.25.1

