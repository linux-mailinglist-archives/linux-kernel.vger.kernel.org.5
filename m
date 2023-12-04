Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC698041B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjLDW20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjLDW2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:28:23 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81660A1;
        Mon,  4 Dec 2023 14:28:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQF433+2SGkC2XjxrQqaKrgJNEUu2yEfFfTOVExhw+so5istMJJNZtpmMEziB9RvrJH1LmimAonqKABtZ2Iagzfzh4Ytpo9BqGuCwvsfJJHzxbLYT01N9VD6xqOQPgnSBGVfVaZ3l3uykPhoKLoa+nZIa6GVD0bIwz5d2Ph1wadhEYa7rpQBf76sPxHfvmCLrvHC+AGGY5iUYDOINdtx7tBWECuHp3guA635bdbB6e0deAdp/8FbJEEGTl8OCJj2uXYoBteZN75fBsn6GdB8+rCtS2zGZTZGUDIutzaTSuryUmfboEXgI3JHPkv/jknN0Ce5jE10UwOa/2QFCHkI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g99hEI1MJyiN4uEtEvUVLeraEeowEZ1HVjFPD8fn7yw=;
 b=eCmdqGNi4ZmF7/zyshKtzQ6FEhXRon4y6PgqsC9GqTP9+WqEse0grBwgrTmrWepYIgfhFrJZnpUeN8K7KARcUKFRSBYlCX03TMiR2GziZosf8SNTSsfxxeVBv9BhUdNnm1PYFcJnf7wl5w2HRfrlER+/CTpN5FK/20srP/UTcfQR4W4QT/SmVj/lJgkMSX8iwHkxk89dEuIOltTnn2Q6RGLpoz+oFAthOUHusgpNRNGK57ku4WjRxr8Yi3pqoqn/XE1KLM/8q+h+YTgnq0L78C8sbHzXcPIzutzwhhxDPtLyz/xlcnqLC4vuB9/FbLHWo4hZKfbK4HKy759p40mbaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g99hEI1MJyiN4uEtEvUVLeraEeowEZ1HVjFPD8fn7yw=;
 b=SXVjh2dx+1b+y2RZJch/l+Ys1rV4sL5lEfzUNew35AFXBI1ZOGswzAcN0ru3C2M3eeoXD4zvd/8ijmpm1UtmTbMmg1/0XkxZx/BUYuvK+Bmhg+O99USvrPiSqY0Qpze0lefHh6zi+ErX6nOprg/IZ9mdiebYrlVyL7KxJJk+Uss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by CH2PR22MB1912.namprd22.prod.outlook.com (2603:10b6:610:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 22:28:26 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::388f:1cd7:191e:21ef]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::388f:1cd7:191e:21ef%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 22:28:26 +0000
From:   Garrett Giordano <ggiordano@phytec.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        w.egorov@phytec.de
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: [PATCH 3/3] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Remove HDMI Reset Line Name
Date:   Mon,  4 Dec 2023 14:28:11 -0800
Message-Id: <20231204222811.2344460-3-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204222811.2344460-1-ggiordano@phytec.com>
References: <20231204222811.2344460-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::19) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|CH2PR22MB1912:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ab61bf-3e76-4107-7a79-08dbf5185575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRlIsyOY3KxIZL8gBok0r+i/cnB6KCodidNqmwBvP9+B9aN5JeKYikYNCVkVbTuFkyNwMILQW7XAXwyuDBYGC0+4KROC7ZtlGbhEHM3pRy6M9cJ7/gvUUyxcJwRH638Q1T9ulmoNzqOL3rqb2Lcc6qe0Gd03nxaViPrhOP6tg/hHAH6okl7ETpDmP4nv8NhhX4prKi5P8p5bTJ9zZzt1mBiHnWNt04BZ5gqIpCcL4kBllMvsDuvwqD4pNY65QhXqS+YGUfFCdBeplMzgfNp83gJbaV7b4hkvwinsfgi4C7vo/vW0+Z/8t5zuKf/S41vVlkrrPYeGcf5MPdHgglT4C9m+k2HVFfPSsR5gPABwl0YVbZtx96h92vBIK4N60A9lNwUVtgdYk0iAyiKpybC2EQlkOAZTbMl7cFbqiO8rK4VeTWnRF+yQduwcPeYlj3gBhBlZtBdk6AEDvfRfA3xNkhNbHg+PZzORKQYF4QoKkTXVEDXOV+MSt/U9hY9wyh9Pys96DT0oM5GKCMzSVVp45wdfre8T88K41uhte6XthzZl7/E26JYu7pgELqNEL+R0khLgWKyySZffP4tzkLaG3xl7ULp+MzfF/wCpUxJm4Yzbtl6Alb6rNidiHjmKkD5R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39830400003)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(4744005)(86362001)(7416002)(4326008)(8676002)(8936002)(2906002)(38350700005)(41300700001)(6512007)(36756003)(2616005)(1076003)(6506007)(83380400001)(6486002)(478600001)(26005)(6666004)(52116002)(38100700002)(316002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JnlF8DluH+X6GmtlWZ08cc7httLrw2K/R24i8G8UkCV3uF/gJaMLxaXPlCq1?=
 =?us-ascii?Q?OVUoSvV3WCcth3hctC2aN/rjnjEo1i5O5wUgZ749JWIV1lAdgj7lawz7d2Ic?=
 =?us-ascii?Q?0ZYgOLBX2JbrOs++teCd34ieYnpegwoF2FE7z/zRXxiDzvVg+3Z1PPR0Snrf?=
 =?us-ascii?Q?zsQzZDDb3h473ITJQAwFjTjSq9OgAOjHVZhh+Hnzq9yZW52Y39lkeUuDD7tt?=
 =?us-ascii?Q?XD/AolP9T6Fbxmqipaq0+3ax1rwGLoFDbSvSA5FWyo/j5Jz+83PdArwg951b?=
 =?us-ascii?Q?dg631UbRMDw6jhFLu79epMMblcrNcA2TKOzYQRqdaZ+fQMED1c1ybU0m0GdA?=
 =?us-ascii?Q?LSBXdPVHgRln6Tr4tBjriVk5TdneHJzESxeTFBHMPDsCpWIaKArpZA1ommv5?=
 =?us-ascii?Q?kg462VinO7VbVmGcjhi1QPwIXD+IbnVmY8UWK2zNd4g3L8CSSAHXDO/oEsah?=
 =?us-ascii?Q?3nvOFdpPwivZuCMdVeOPwG3mlyJu1Y5TvNYq39HKWnEumazscclUXEwYExU8?=
 =?us-ascii?Q?uHZgOMSXsUXeG8BfXN36ZCzv4v4RPTiDE4H4bQE0hOT4D1+E2pb5SAVWS7Qo?=
 =?us-ascii?Q?dns5YdOAvqLRuhiSyrvqEkIDlfhApGWBR6cDBE/KUQyJArOv2VDTvHWVp3lQ?=
 =?us-ascii?Q?z1zYaFn8ts2o83Htre3W1Rpph8Bd0QeeGy+AKK93fbiklUHBfBv7Xkizh3AK?=
 =?us-ascii?Q?eomBcdCz+joU3AyTtU4Y6x2lIcNJ9S6ZO2AFpe/9eoMXsqF55Db91mfcXNWY?=
 =?us-ascii?Q?8/4GY36KcfRay5XbfaCKmHVgO86338sSs1y0gugf3xpTBTV9NaUo28iUqb9w?=
 =?us-ascii?Q?EWi4TmYij4suTJABSM+Pu9HaI0KSsXsSik3+4yqBtDqDjQK6Rb1ARQtc6sNb?=
 =?us-ascii?Q?4pqFHRNtooDyiU1bT3VPYB833ugnW9TSDRg6w95/lxBTR/qMGHYbP61v4gKF?=
 =?us-ascii?Q?QUni/zz7f62fjn1+Sxr3S6C1nf3qvwKNISvEXjqVWKqzJOPzn+sTUD8Hbm6G?=
 =?us-ascii?Q?K0EErvIVtvXbZJG2+7/coD3Maffn2FXr25sV/v5fWOAv1QgJJ6ZzIjBLwr1c?=
 =?us-ascii?Q?xYAvEj8cHG9HBz3A/cedfHspRDRBKEMqftyl78Q0KojUVVCNCsTFYN1zidPA?=
 =?us-ascii?Q?53e4WocJhgqFD06rFAtym7O1T+FfZ8VmFXt8PhXzQEnP+O5dFh4JUx1k0T50?=
 =?us-ascii?Q?bnH86ZRD+YY3xEF/s4orU4TdQ/FYdxfrQTgdKYHkWkv/+EAFgZCGdoclE2Vv?=
 =?us-ascii?Q?8tPns5LSy/+MlntnQeVpcbsWuabCQHoOad7zlYttVkus73HhWFT8q11tFzfh?=
 =?us-ascii?Q?eY/dvNFj2nz3ickXLrbYygbFGkuT6PEFz1K3CbDZIdDEhaAQ1WK6tKrOma0g?=
 =?us-ascii?Q?Dmd+A2HggfjK5UxbQPXU2GJIlmdz+yZu1GAmGwleDQD3OKkBc0wqxyR7P8Xl?=
 =?us-ascii?Q?Q3shWuE97Uy4LPFHSz5hN5kh+Rx5EcTuJymkIhOG7VS/tUoKmgz6Oa8gBIr9?=
 =?us-ascii?Q?CjuUup3Uoyy0KxZMXxUSlffVPDLjkgkEmY/OgMbFwUyqTSQuzmDMTARGB+X+?=
 =?us-ascii?Q?WjwuBNdqVuGXPrICGJHHvcn6BA8fQnFDRiXO6loR?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ab61bf-3e76-4107-7a79-08dbf5185575
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 22:28:26.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /P9M7CcBoQhM8rJiW1JB3IvI4qTBj5iMxfP/++0nG4fN2qC4XkzVy94MqXIfAAwchj6f9lni5kxsUz64MEPKVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1912
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO Expander has a line name defined as GPIO0_HDMI_RST. This line
is no longer associated with the HDMI Reset so we removed it.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
index 81319d68b624..4bc0134c987d 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -264,7 +264,7 @@ gpio_exp: gpio-expander@21 {
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		gpio-line-names = "GPIO0_HDMI_RST", "GPIO1_CAN0_nEN",
+		gpio-line-names = "", "GPIO1_CAN0_nEN",
 				  "GPIO2_LED2", "GPIO3_LVDS_GPIO",
 				  "GPIO4_BUT2", "GPIO5_LVDS_BKLT_EN",
 				  "GPIO6_ETH1_USER_RESET", "GPIO7_AUDIO_USER_RESET";
-- 
2.25.1

