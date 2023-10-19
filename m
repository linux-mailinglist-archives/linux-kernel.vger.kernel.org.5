Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325CB7CFFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjJSQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjJSQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:40:02 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2058.outbound.protection.outlook.com [40.107.15.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E707130;
        Thu, 19 Oct 2023 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slDr3iuLew4TIXJnHzpkUMNW4c9+SZFodVsSnLO8emI=;
 b=tjhQvOqy5RGgCW4GhRgBrIpVl70N5u/SFf6SPcv6QFxBonDEXWYSZIYnV8oaUD9yf2oDV2WSHbpfII4rWQruLO+zLo2k7XceksPNLoAOSXTLKBce1C7bj3JsACjegD4FeagE0JoWPB7bppYvcagiz17mk1Mx1UCfeZUERho5zWNGWDylcaw+AcASa/N/DGXNCkmjBeCgz4k7KumJNVhcdhgPdNWTqvmUt9mdkNOrpVwQqkJwRZQZ+G/VCT+7EGxaELanne2PWnZEZkOivFGBKnfrjKO+rHLBdJ064Y+xs4nC9ORDCI7gQIJfq0GCXKliVZwyV91z7ApxQYQc0c5/UQ==
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by GV1PR03MB8686.eurprd03.prod.outlook.com
 (2603:10a6:150:92::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 16:39:51 +0000
Received: from DB8EUR05FT008.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:3c3:cafe::d5) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Thu, 19 Oct 2023 16:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.84) by
 DB8EUR05FT008.mail.protection.outlook.com (10.233.238.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26 via Frontend Transport; Thu, 19 Oct 2023 16:39:51 +0000
Received: from outmta (unknown [192.168.82.135])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id E02AA200813AA;
        Thu, 19 Oct 2023 16:39:50 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (unknown [104.47.51.232])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 416582008006F;
        Thu, 19 Oct 2023 16:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtMMVJBLXW70wrOr3P27iB0Ss4TTutjX8NUeMAhTnUrSNO1SlaXdJlJmUO2odA0Q9enlyegptx7zIMOs/XEKaovCGMTTLFYj+EzrY5Zu2AT3DIp71WA7GAgKPSuCn/TugtZtSIjUi7+r7dtrS3kPQPav8r63Xqbj2nuvmeDj4sszEjVH6srfTk6gSJ1zi8L/PHopIw8Rd4ka0nfFNPLSMseqgru3oD1MpWLUt9tMHKrfA8vPZ142iwqpcdtYYeUe2LRpSEZ0ZhiJhu83Z2VBo4+7FHBF+54kzBLDOfwC+DTMoND6WQHKH07jkq2uuq6DlcAW8aqaL9H+7oblamxYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slDr3iuLew4TIXJnHzpkUMNW4c9+SZFodVsSnLO8emI=;
 b=GXEg8HNWgsq6DHURJu8yNCWl9ufps/vb1BM0E6huHz2wdMf/5+itRfanU1JiOoCy8K3HXsJEp8EzfGAEPm7j4g78yFysL98qTvRsZKoM3bwKZiONyoz+HZtzsIvhDWzeIPsDOyB/9IwgOqgfRYPjIbcJN9emZ5etsXZ+VbHYmnXTGsdAXlyRPRVyecEiXEXnJiLtCmv7OTcXYCOf87wj6UBX2mWioKJmEVTgvvHUKHKwJW3c9aWZj1SoYhhk3yXoLhXRPC/gZrty1EpuIDWvPI2HTL/9pWVWjdsE1RhowqSzvtfal4hTun3VJc6Gs23R/fYKBwS4QSWB+7k+mXosMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slDr3iuLew4TIXJnHzpkUMNW4c9+SZFodVsSnLO8emI=;
 b=tjhQvOqy5RGgCW4GhRgBrIpVl70N5u/SFf6SPcv6QFxBonDEXWYSZIYnV8oaUD9yf2oDV2WSHbpfII4rWQruLO+zLo2k7XceksPNLoAOSXTLKBce1C7bj3JsACjegD4FeagE0JoWPB7bppYvcagiz17mk1Mx1UCfeZUERho5zWNGWDylcaw+AcASa/N/DGXNCkmjBeCgz4k7KumJNVhcdhgPdNWTqvmUt9mdkNOrpVwQqkJwRZQZ+G/VCT+7EGxaELanne2PWnZEZkOivFGBKnfrjKO+rHLBdJ064Y+xs4nC9ORDCI7gQIJfq0GCXKliVZwyV91z7ApxQYQc0c5/UQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB8PR03MB6268.eurprd03.prod.outlook.com (2603:10a6:10:133::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 16:39:47 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::4824:99ed:da95:6bd0]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::4824:99ed:da95:6bd0%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 16:39:47 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3] rtc: abx80x: Don't warn about oscillator failure after PoR
Date:   Thu, 19 Oct 2023 12:39:31 -0400
Message-Id: <20231019163931.3682923-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB8PR03MB6268:EE_|DB8EUR05FT008:EE_|GV1PR03MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f537dd-f35f-4d60-3aa3-08dbd0c20413
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7F0vYz6SpEcbvXRrJQoVd0j4MMKNoa113gMVmj7AQ9xB+7Gl67hJfqymlv0tkPPl2FeR28l7Gl6asX22AS4ysH7g+bluJ21Hyqfj1mz94ycCPaHvIMw9FiYpVk1ytJqvrGe7D2tGiYIUBJX1HwDCI2Umrw0TVNhqiqDRqCpdF8danRvUfjdCcB9B6VcTYtVMWYN/0vWb2YgXRQSsXaXST741eS8y0YLODlb+ny3gSCAh8JRHl2ClMzUymcpny4D5BB1uHJfWE1Tt1/s87gv68okAqRyWLp9dbw1Fr27++a6gjf/9CnpaW3QAyviwmCOLL1uZ/skDLb+OyKB73CXmUAjV2X9zCYspW3mDLmYy8w1n/J/K/ydzF4BjvrXzCNSA6QIRqK6yZ7WJ+Ja8QUEovmWOhBrBHWLUPuxxFTePv+FLt0GYRF9enNhuUAgoRHb+PNBgc1MlfyyNvqmjloLR8aphm4GB+K/sCITEWAV81FTV52d1O/6Q5qAbgOqdOXoGXTWLsAJQ7+IlhnPPjoqrz4qOCLaC8yGjWLY+n4TCQFIAjhJ3zCEO3rDGotkLMLtEn2KP7kXGdsHYYDjXknNu0i0P7ySN98YGSzE7DrXW3hTpOaz0qxL40/N3hZmMvcl3
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39850400004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(1076003)(2616005)(107886003)(6506007)(6666004)(6512007)(26005)(52116002)(83380400001)(44832011)(41300700001)(5660300002)(8676002)(4326008)(6486002)(2906002)(8936002)(478600001)(66476007)(110136005)(66946007)(66556008)(38100700002)(316002)(86362001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6268
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT008.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d1f6e4a7-31be-4e53-f526-08dbd0c201ae
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEV1iVRSRqu3a12+1npxtesn6Kv6peSRm29+tIgS1ubwZlxVPyKbL/EBlI56h2fDL4hjfgYUQstyLVfQb0LuBGZUmL+P9EwS9G5XtWcjji2TTPkRbKToD3T++8y0PgcrqNY7VMW7o7OVVDXAQY5Ds0BOlj21AYyDgRvhjNk4YVxUduHXR7ecTTLnqOQ2uMo5qd72xnkGUa90kMJDmyMd5EpMWDGqKB0tC7uZbhB69WK3XHNe5Chh6qvIcR+yU3Ut2p7iM6TNVlowRudC+W0uJBBMm2nKwABqK/ahwcYINw2zLFP6WFNkSejAspHG8FeqfDhW5RDDHyHhxqqs51jQu/1b6J958OPBPCizftM+VIrdwqW6yLBQlGQzWZml7iT+4oj8r9hiipa15Sr5m74QXESC9DFcqeDl9yoN9fTO1b7UNbzkkA/Oiocwhl3HLDw3unRvgQBRHMk4h87Ue0mHUGRjYxDdj2s+I4yWiAPt8MQySMDB43EFQF56uGoghDU8lZyBh0X4UpgtcIo7kmHMJGmNDv+K7Fc1+J5IWUcNHUuIqbpDNyVEgNTprSiNSXlE3rCv+hluEKSYijxmZv9jmc8JQ2wjEFClRYlBABX1Ol+xKFVs41SDslaGQ/SABA7r91ra97hZVEvfFTS/5kP2C194WOrQ4hL0HeEvAQ3QKwiWGfxqUO8V3ee2FrbwnfB7ZU60Y6CH0t/9ApzKwNQLngSeB265dZikTuhnSIQacqjurIcUKs4h6HDr+bKvLfCNACqfIN2m2mMY3BHtzuFsyA==
X-Forefront-Antispam-Report: CIP:20.160.56.84;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(136003)(346002)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(46966006)(40470700004)(36840700001)(83380400001)(40480700001)(40460700003)(107886003)(36756003)(2616005)(6512007)(110136005)(86362001)(2906002)(316002)(1076003)(5660300002)(44832011)(41300700001)(4326008)(70586007)(70206006)(8936002)(478600001)(8676002)(6506007)(6666004)(6486002)(336012)(7636003)(7596003)(82740400003)(356005)(26005)(34020700004)(36860700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 16:39:51.2877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f537dd-f35f-4d60-3aa3-08dbd0c20413
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.84];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT008.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8686
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet, the "oscillator failure" bit is set

> ...on a power on reset, when both the system and battery voltages have
> dropped below acceptable levels. It is also set if an Oscillator Failure
> occurs....

From testing, this bit is also set if a software reset is initiated.

This bit has a confusing name; it really tells us whether the time data
is valid. We clear it when writing the time. If it is still set, that
means there is a persistent issue (such as an oscillator failure),
instead of a transient one (such as power loss).

Because there are several other reasons which might cause this bit
to be set (including booting for the first time or a battery failure),
do not warn about oscillator failures willy-nilly. This may cause system
integrators to waste time looking into the wrong line of investigation.

We continue printing a message about invalid time data or an oscillator
failure. There is no voltimeter in this RTC, so this is the best
indication that the battery is dead (or dying) and reeds replacement.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---
Note that the following drivers all warn when they detect a problem with
the oscillator:

drivers/rtc/rtc-ds1672.c
drivers/rtc/rtc-pcf*.c
drivers/rtc/rtc-rs5c*.c
drivers/rtc/rtc-sc27xx.c

So warning about such an error has good precedent.

Changes in v3:
- Use info since this is a good indication of a battery failure

Changes in v2:
- Use debug instead of info in the typical case (no battery)

 drivers/rtc/rtc-abx80x.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index fde2b8054c2e..f463a58a240b 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -127,6 +127,7 @@ struct abx80x_priv {
 	struct rtc_device *rtc;
 	struct i2c_client *client;
 	struct watchdog_device wdog;
+	bool wrote_time;
 };
 
 static int abx80x_write_config_key(struct i2c_client *client, u8 key)
@@ -179,6 +180,7 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
 static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags, rc_mode = 0;
 
@@ -193,7 +195,18 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 			return flags;
 
 		if (flags & ABX8XX_OSS_OF) {
-			dev_err(dev, "Oscillator failure, data is invalid.\n");
+			/*
+			 * The OF bit can be set either because of a reset
+			 * (PoR/Software reset) or because of an oscillator
+			 * failure. Effectively, it indicates that the stored
+			 * time is invalid. When we write the time, we clear
+			 * this bit. If it stays set, then this indicates an
+			 * oscillator failure.
+			 */
+			if (priv->wrote_time)
+				dev_err(dev, "Oscillator failure\n");
+			else
+				dev_info(dev, "Time data invalid\n");
 			return -EINVAL;
 		}
 	}
@@ -219,6 +232,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -252,6 +266,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		dev_err(&client->dev, "Unable to write oscillator status register\n");
 		return err;
 	}
+	priv->wrote_time = true;
 
 	return 0;
 }
-- 
2.35.1.1320.gc452695387.dirty

