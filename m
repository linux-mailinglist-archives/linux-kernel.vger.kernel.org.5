Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80282754D15
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 03:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGPByD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 21:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGPByC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 21:54:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD3526BC
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 18:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/kWHnhQQ1HEsegXhibbnWnJiMZG+Pc6/bcoaD8xsuJmBvfmVg4qcgdvnNtoULkwNrs04ch6Fb4kp1uCocB9JQtiwANi7nPKeThoYmMxSopSx78BFbo2XR1vyLDQZHElSYi0qV15OwMa3xTrz3LKbOMNocl7AndKvc1KOkzgFQTHLcVFvXN4BNRc/4aVDIyxXmAueKr0nVg+lBQ0NiCb4AQox56dvlzgXhsJRbmeiCOk2sbXcbLoAZMEZk8Xr3G63WtvOO8zel37+znCZf4h3DvosDyngMCgwOfIcoxMLtHhLDIFJ1MvnQn4qtMUkgp+MTc+ZLozZu1EaiI6Uqtj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWYuoVpWhhKQL5VwsgR8Kf/sFEPwBvDwTW8j9Bz6Rfo=;
 b=N9AsiSnZN7OBSiXLhQ8KmuRgyXmSf2yceZUNh6U/Jmjrxq6EMPPNnS8SywalvtjcgNQj79Nev3C6tb7iXF/6icY4DL52rlp4scEG5qAFUnqUvutXeFWytsHYr8zdIDy4gsyQBWgW5Cxm/M+TmRwE3pLPIvu6mXeFAlYlp049KuiXBioUQ6x2pT5VPfSkH53vTwfrXywXlP9+zoRHAKASoFfDv7eOHU1Yot6CfcmfmGE481rSZ4RUN9Ae4+GQd2T5k6asX73zql+9wekQi1tCm5oh9nIBbt27HyXh7NCMJ5AUh3Pvs7mWprOSFZ2CxATKUFTDiB0cS6Pz4z/RWW/fgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWYuoVpWhhKQL5VwsgR8Kf/sFEPwBvDwTW8j9Bz6Rfo=;
 b=Oll1S2Us/GE2vUt6WmZm/3CHxNNhpjf3lSIz1ISQly84wJWBKbhJbyw+SHmxgZxa/U10L5cfOiothFsMMJBd3AI74WwYj2chdGHsg2MzYtBL2k2u6Dde0EahYV7YpkX+Y/4njbRHRhLHl6Pr22WF5ttxuiMumkBs+wFK18qDWbt+pVxicKHVlRuDevSmy1hd+oSW55nDwRX1I/pnA4pfhtRqeNdNEOYr7eMpaTf+jrKzYZGCbrntcfOynvDfUh79wg7wNvj43DjkMwnjhTK1QtcbEsbdyko0INVbArrS4fpiDVbtuKJM3jW5KJuTHz21EiY72Bg2fL9VU2Kh3xIHcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB6514.apcprd06.prod.outlook.com (2603:1096:400:454::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sun, 16 Jul
 2023 01:53:56 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 01:53:55 +0000
From:   Wang Ming <machel@vivo.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Gong <richard.gong@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2] firmware: Fix an NULL vs IS_ERR() bug in probe
Date:   Sun, 16 Jul 2023 09:52:57 +0800
Message-Id: <20230716015310.12293-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: da88161e-776e-4ec5-9df0-08db859f8325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAaXu6oFY2d4l3xhtG3aQ1nnDZL3LGMcfZGyKQAQg7OwNEp/asQFOgGou8zU73oGfDiNdldzTLUe8P8R/bHpFOExRft/SFKoB8MwnrbY+U+eDuLNSZnplas0ROnVeHHpjjOkUC68M7KTeDNBVYE1BXAUmmIiSbnGk/mtUAQXdGcDmFx9gPSeuVUMWpdJ7FTGxdEm+771QsZQ5nwpvvQr3o392E1SkZ1/PVmujOjw7uBngUgH1qNyGc5MndvUM2PflnrJsDdEDJJxKwh3QTvh43kFqpgegPVEyNUiPL43bOVPTBfIheWdBxeuuAcg4TpPW5W75pnKSzeoHKQdViaSG9NlwUMLZTyv9TSHSwIgICJkCRrAKOpQa/FSxg1k2BmlVSjPfcTKSs/n6Pzm4jD4CeTuznKwl+egkh8eSXGiGrtYJ1nQryD/es3HalVz55MvV+rmCN3HHstC2dswNuk2myhG51P9fV97be2ctHNOXls0AceXqrOJ/uNTUNZxQV1P2qPrWQcKZE6E0QSYs8g/4oOH46vgy6Fd9o5y3Q7kMpwwBUWKyfs2t0aAHqviIhnjz08v0omZ0quWBEk9d9DU0XOKb1a7+PAvZKuiNoZXWm1Xf/Y6CJlQqo/ogvFgj6Ak
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(346002)(396003)(366004)(376002)(451199021)(83380400001)(2616005)(110136005)(38350700002)(2906002)(4326008)(4744005)(38100700002)(8936002)(8676002)(316002)(5660300002)(41300700001)(66476007)(66946007)(186003)(66556008)(6512007)(52116002)(86362001)(478600001)(6486002)(26005)(1076003)(36756003)(6506007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+nswH9lyi/d/To5WMJgDMPow2qp8ETAaUmvNfovL84fbaQjXDlKHG2qGtuzK?=
 =?us-ascii?Q?Gqvq5Ihgc2r0CuZHOgeqHGow0j5b23df05jgl8vMBDAYZu36posXKg6phT1U?=
 =?us-ascii?Q?yfAsFWzWRCFMkHKj/64fBu7giTQ2RGnPEZbRkQkiMg78pAafSkjhBwLMvtNL?=
 =?us-ascii?Q?Cuwq1BGG3LhNOjc9QoCQuvPvXc7urZUpKSiMlPerUsevlI5tsDnoSd9YKIzH?=
 =?us-ascii?Q?R4XgDKCpaLUw1HoSd6oID/5iJPgSX2E9oIYrZndDRuvGpdjEC3WI6lOjDKUx?=
 =?us-ascii?Q?2WYmhWlqFb0aDK0P0p60t+6xdIvk5C5Nl11CJOOA/yb5eHZuyz6YUmzV51T7?=
 =?us-ascii?Q?7fx3ltkiHoUPMeNeGXvOpXPI3hWtVmhKUIiYRFVlD1DAz/ah3GfKDw7wg/+L?=
 =?us-ascii?Q?oGSF+u33DYlfe8GOnGeLYOCexQ+m8pvJ6y/W+pp+Ub4ydR5OgdsaL4XM6w6P?=
 =?us-ascii?Q?wm9IZOgq27Sd1vkiDhpv2rPrasIhqt1NEiL/llSaEyBYHG1OIq1LCKyuam+r?=
 =?us-ascii?Q?q96IjGHi+K+ZQK3N5LSAbVPwDJDU2OdBRuKZ5xYYOqdnGWrjt7zHGvZlql6u?=
 =?us-ascii?Q?BCQVDYF4GdKPKHT1b/Vzg0B0uRn2kWRUTx31aEXF4QrvC3nxG2T4HxL6UsUN?=
 =?us-ascii?Q?5BVgOyLjyLzba07MMK96RjNI5Mx/vFSVhA6aHVuE0i1qRp7Kc+olvF8PCDdt?=
 =?us-ascii?Q?BqzYH1kfYR6TiODRLG2onVzL1An0YB0L98J527XAeLgQBzCr5BWkmSr3O1u+?=
 =?us-ascii?Q?hvjBb22RGuj8eFZzAAd1Y8/W5xeRGtxsNSZPIWuZo5H5g029Hr/bTQFYtpFO?=
 =?us-ascii?Q?tsCACjmejS4NV8XGSqcgb0vhZrQzMDjY2peZij53oG8q3kCSVtoGJAFSH0Wh?=
 =?us-ascii?Q?UWeUiBiHctkLXLqZgyo1nVQBRktV0K1oiGrp7fhVlOcjw2WWPBFYU2F5c8bO?=
 =?us-ascii?Q?KG5Fmm54IFf5l1J1HF5LalwkAxH2KJt0SVtKICaTfV+dh78uEMvE+3qNf2g8?=
 =?us-ascii?Q?9coyHcEQ3G0XsSA67Z+HE0s+VCRy0X6GMS4/BTVr1MW2Y6ZagJAEUngflXjA?=
 =?us-ascii?Q?1Ztm46zAzO7A4DEuq30Bmk6ISFFH4bp9ey2w+oCebN6oN/gxr8gJPKsbhBux?=
 =?us-ascii?Q?zTkB6183DZs5XA1LdfrF9xux8bt7F0g2LVvW62UDnWILxUNWRSBTJTchYH7j?=
 =?us-ascii?Q?46c3dN5LCk401VAA4fB/VAuHmTaox+VyfjRI7d4Z+V85oPZ0Zs3pCWJQLPJE?=
 =?us-ascii?Q?5HwaBfXw74N5E9G8ihBmsS7Vz6+0kprQIOjYr3mxlq+N+sklb6LdKmn+jQBv?=
 =?us-ascii?Q?rz0GLDi2ErmC4kIzvjA22gwoNAbi8zOnRhh76+BCV6l/VPVD+qaVTSeVZdSs?=
 =?us-ascii?Q?Y/qh/3Vtj+Q4g0xPCeYoue5mlJ3zDUNL5/r38MQvtu5YSxnpiQ2I2z1EkjIQ?=
 =?us-ascii?Q?5ABezBrGhLoHhIZ9ZY8W6cxb8yHJjmQ9wctq3lAqnSWChwO1o0ZZ6Y9BFc8B?=
 =?us-ascii?Q?6hSICWtAc3hoJBePSBDWJKWbZnLIc3eLxuIodVSdpazeDn8MQD4ePiAOXHty?=
 =?us-ascii?Q?HtHSU73nFuD/Va1PYU8tVdIFR5LsSCcglx8ueRiL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da88161e-776e-4ec5-9df0-08db859f8325
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 01:53:55.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOEOWvOuUpE0pQSjGdHBTfusA5cDRzhpXyK2e0kp+vkzbOTWXhMYmW832D44OmoUIOT1UQ0SGPu6N23e9NjVrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6514
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_memremap() function returns error pointers.
It never returns NULL. Fix the check.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/firmware/stratix10-svc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 2d674126160f..935bc0cf913f 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -756,7 +756,8 @@ svc_create_memory_pool(struct platform_device *pdev,
 	paddr = begin;
 	size = end - begin;
 	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
-	if (!va) {
+
+	if (IS_ERR(va)) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.25.1

