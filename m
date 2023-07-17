Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15971755977
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjGQCXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQCW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:22:59 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC01A7;
        Sun, 16 Jul 2023 19:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0U0e4V9SzgjKPJ8VZHq78qvuPNbgIegdw2pqpIkqTmVIl7LNM5I41AJr3LQLMuiwB/itZl1MgGc5HbQZy/GlJL/SENKOjCTSEayjaDVHDFHwotIOWfq1gAMZ0dUkDVbM2JWAOhGe6y+lZ2+KRy/Ak7BPi35iWOpDSRcJLQTjfD1oshAogJhIRNhcy7AGM48Bn1cxn5bgKwOD+dkOTOAy1UTCQBSpBz5w8pBpk8Fwjnaz9KJf8ZnRXcZUTXOMsV1+TGlw7CvsYrIGe7YurHpEekYYG2M8b7yHgZYT2o3TKI+ViDdXPKrB4IqpIWVpPpnDQv6zG2R3GOtG5iItVl+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKJKkz/w/7F+ClJg0bwXgapCDdSTZWx+YNyyzrYpxK8=;
 b=YZ+NNaBvbBNb+NxjhsGw1yuNusmirwu2fkVb0y028Kk+ephmWgQKQ8ddMaTV1O4IpUW2vtMed3ifOkDTaBzYFhQJQtr/4e9jvatv8HZNeyDy4f8RAc6TXl58bpzTtjou5yNgyWdcvgqetwod6GfFJvO+tpdxSbgMdbG4cyrScjzowPmTh5Z8gsOwJSn22lQRFSn5os7xsYebGbYAAhVf+MA0k+DJKHd7zkKmfmUoXfseZYX+vGGrGdY2ub8GnSMJCicm5C8XJpDo/kMFccRE8/4jwGV+zgTfcpIq+ItBToc4Alch93BIgjlFXIeMpprcTcNYSyPSQfuaF39PvVWgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKJKkz/w/7F+ClJg0bwXgapCDdSTZWx+YNyyzrYpxK8=;
 b=LA+G5lgjB4Gwp+Y9KbY4iWpk1uYtFgU/E1sx0nFQvXuie5gKmho1bJb0LwqW69mahLGdU+QE3Kf14LwYNe5k112to2HgomFZ+mR+pVazuze4J9rYNHIIroW0nZp+EFR2M0H5rM8DJOmOoNej2JCdYN/IJxs8c6bVpc6Npet0cGKU8DimeDZHDrDblusJ7md2L3RF7kNFu/VCncxJRFScS3YZCDCjIvpWAlT/YIFyD+gNHgiGSxPUqEmbfJOt/e3QUvvSGrPMrRg3XGnsi8jBuslAjEBWivzJXZOHIoxYUX4Brfrj+f9RuFHoU40X3CtR2m0VWkx4ddDXktC40Oe4Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEZPR06MB5787.apcprd06.prod.outlook.com (2603:1096:101:ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 02:22:50 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Mon, 17 Jul 2023
 02:22:49 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET
        DRIVER), "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org (open list:MICROCHIP LAN966X ETHERNET DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net v4] net: lan966x: fix parameter check in two functions
Date:   Mon, 17 Jul 2023 10:22:35 +0800
Message-Id: <20230717022235.1767-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::13) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEZPR06MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eafff6f-16ef-401b-5cff-08db866cb774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1e1XWrum/s0yH4in1H72Sf6Jmk3FOGofKZY051jliKnNTZYi2LWJkdhXSm33jQg+9PUg56X9F9X6W+8i18f2gAMIpHBNuu45Y1CuDxtUBqxq/RaDIhfqjJrvg69ryvhZ0boxJuoF7HtlxrwbQGB58do7iDRRcpZAlcpnncfBrzz0aJcBvp6zwy/8ymof+9hgQYIhQjcAsyPrOJPEWxlyQyC4NpyYnKInUCXKBCfZMaJ6vGw0RQ3lTBkVvfynWE+2+QcJhtpPJIubZcmTj6vJ00Q0jC2+cqGjv2dDRQVehGfgSEKuuyY+ZfUshLRJJy61ePqEpPGG9wjTqL+IM+zXzQAvPTNHGtJagS8VcvLY9T2lzELjUP/p59q5zUnRIxTcNGr9Q6Tpe/SM+6JzK52/TY6tKgeomZSjBB3kyyViVSpNZM9cTav1EHmZer1UZeFJPSDVnL3bjdVJeGtWAHpi7hb4VFfPyZXqxVj1bEhS79JZRq28jBamuVMp5cI113ybZk6eW/fJTt33cIOhWuaQ8syK9ZwoyeTX+Kj7Ms10rLH9sld/WiQYmvWx5vEU+anIWO9Zv3USj3t/DYPYMivMx6pa1S8Q4S1IANne3cldRlZphJF6A94zv0P8DOAgNZ9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(86362001)(2906002)(36756003)(7416002)(6512007)(186003)(83380400001)(1076003)(6506007)(26005)(38100700002)(38350700002)(6486002)(52116002)(54906003)(6666004)(110136005)(4326008)(316002)(66946007)(66476007)(2616005)(66556008)(478600001)(5660300002)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pkgKmKWHFXBRWXw1DGrX+JGOSFflNb8OM08YfI94AhSfYq4ygKgRx6KO8C5+?=
 =?us-ascii?Q?7Rd5s98idm1dR2Fjk6BJbqXWOQscqQuqIIt5st61E4VEY8OjnSWuAjEJRYma?=
 =?us-ascii?Q?0iYPUF7KHJCeA18sxoxKcL/88XcsD6YASzpzSMyC0u2vWyFaEJnS8uct3Mz6?=
 =?us-ascii?Q?x76bs2ofWEjaxDRgUXPccjHn+qniKxNPUUTJvkjrRP1x86Qpg8+OYQ6GRAK4?=
 =?us-ascii?Q?QW9t0ETG+Z6glCcLKnN338o57rlLjnCocgYbUptyuVzXZTV9EVlAUQELy/AV?=
 =?us-ascii?Q?pjt8DnYLl/83H0GtupYoRxCVtSbymX0ViUROkmDHrL3U91kYgOVhzV8XN+AG?=
 =?us-ascii?Q?UlD0+VxBEwnZdiDtCrN9cBYsk8mD7N7aTMzoIzicXNNQw+16OBZdDlDrlw/o?=
 =?us-ascii?Q?ExjPMZpBDbN9frryfJ+K4Y5Q+I2BXraLDTz3zbweVrov4LkrcZcqK63wVbOJ?=
 =?us-ascii?Q?Vv4UD7zPYVzcdOLU5VRarT09mOFeEyYhyhANiDJ/jw+nPcZUDS8W2VJjT6bh?=
 =?us-ascii?Q?cGWk19KV/LxXEPT1s4UXpKgIWse/TbNHY8l7igpaPQYo0+kGI1d2Uz3LLtY3?=
 =?us-ascii?Q?NE8IlVqPqKKxt8PlBzY49Mf2CGhzZg8wwf7Wj4hfWjtQMR/jn750ouKerayT?=
 =?us-ascii?Q?DwWUa+w44PU3V5J5fRX0FUynLpoFvMiNET8ZfcTMuL1W/7IlmMAZltfaW1Ze?=
 =?us-ascii?Q?GitFxzGivPcTaHJKgDh+7nUV4XMhPfwOoUex2Vgjf12mWRM5AT+uyT3p/pXa?=
 =?us-ascii?Q?HuqN5l0acSfCoJaVrNaU0PQ0sEqy/cylSBs8LHkE7OcHYi7v+jscIsU+L1eP?=
 =?us-ascii?Q?1FFolojuvct9Hd/shzVQuQL/06Qh2M3IfV20mz0IrYEHKM3o/OgaitIczXXU?=
 =?us-ascii?Q?Onyl6KJFp47sibcYNV5+8DQqwBCamHczufINQhAAM8kz5dU0BulA5gHJ1oaX?=
 =?us-ascii?Q?WCOBCZW/BQTlJ1TCvIJ7iwIGnlOgwKIj92Vvz9ZH+2S49g7gxqVcZoVZqBfo?=
 =?us-ascii?Q?bDpjsKIDu0CIYy52VBMpBuxqCY60DQcCxGfqoIcSdEhzYz7Nd09WfSYLDJ5q?=
 =?us-ascii?Q?ohaGOefSTYeCvOsp3Xr0/2SRYaZNrZIpPlzqlaxHu2GbacuY4+/CmSRg+MLj?=
 =?us-ascii?Q?2T1e/ao68nOBW0+7nFv/npq7iC6sl0J3+1M4Cyogdd+MOWQZRcLpTDwk3Y9t?=
 =?us-ascii?Q?B/SXEfJ60QZj/ekydDy0evE8/ZhlvQorp+v8UZu5pbYsXFtea2qCrLMUugfR?=
 =?us-ascii?Q?zvZvHmgSSOdLNnxO9y/f5uMiHl2YDL1VZPHcy4rpwb6GDslJMKegChEPykWQ?=
 =?us-ascii?Q?wXok1P8iXiJNmEPcF0qup/+mfCXJ0YBek420hH/OgoKqXzISqkUcVGNGTYMB?=
 =?us-ascii?Q?ynJJNdO1JBVWapdWsxNQwavGjVdQGle0yDD3V59ltr02/8VGJetbjlYRxe1e?=
 =?us-ascii?Q?OjhNbSgjCsrpCEIfgU/ty6A3jD08OW50RhcuW32/vA2fezv1aMabjWxnR21V?=
 =?us-ascii?Q?NYtBOAsefV2iA4UpsrAo7jbc86expM+zpIcsmBlmvCG6XQueTsQsFTAtke4G?=
 =?us-ascii?Q?h24ipw2BXiJsigTBIeDLFXawokrfg2aIWcSFF9VO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eafff6f-16ef-401b-5cff-08db866cb774
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 02:22:49.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4h2xBFCSZ8DhPIxu7+dW1ORPw6Bwf+SYkKYUYLpECi5AmuQ/PGExDmkt5JHL5OQBndVAb5KjY4gdA0jxApe0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5787
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR_OR_NULL() judge the vcap_get_rule() function return.
in lan966x_ptp_add_trap() and lan966x_ptp_del_trap().

Fixes: 72df3489fb10 ("net: lan966x: Add ptp trap rules")
Signed-off-by: Minjie Du <duminjie@vivo.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
V2 -> V3: add 'Reviewed-by: Simon Horman' tag.
V2 -> V3: set the target tree in the subject and add 'Reviewed-by:' tag.
V1 -> V2: add Fixes tag.
V1: fix parameter check in two functions.
---
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 266a21a2d..59dd14247 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -59,7 +59,7 @@ static int lan966x_ptp_add_trap(struct lan966x_port *port,
 	int err;
 
 	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
-	if (vrule) {
+	if (!IS_ERR_OR_NULL(vrule)) {
 		u32 value, mask;
 
 		/* Just modify the ingress port mask and exit */
@@ -106,7 +106,7 @@ static int lan966x_ptp_del_trap(struct lan966x_port *port,
 	int err;
 
 	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
-	if (!vrule)
+	if (IS_ERR_OR_NULL(vrule))
 		return -EEXIST;
 
 	vcap_rule_get_key_u32(vrule, VCAP_KF_IF_IGR_PORT_MASK, &value, &mask);
-- 
2.39.0

