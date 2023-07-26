Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66B0763548
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjGZLjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjGZLj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:39:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5250A35B1;
        Wed, 26 Jul 2023 04:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAXMWDKetx8RDzE5PscFPcbZzWMMze/Eh3wz4nWQsiw/kf8vQNx5iFnMb5886GeY681tkXBarDPmrSAX9D21xGhZcC8X8YDQP+p8oTREBC5K8Ty2p6uFsPF3vGQFXNsEVuQSk9yx5myKsQDNd+/TAMw5KnElXTBR99L93kPmMmuJ4CJ+wpgZ5vQtosrEMNIcIdLMTyhJq+qPmCW2EI4S/6iTRLthJ5M++BRk/PeghqekRv2UkVLsH97bFAxFlWxgYwHLcC3pgyIoheLYKrIqS4tlnE5gu5vmrhmz1POAR6wEmaiUBQc8prES/s9gt8aHeMee89tVvINlUY3w4+KZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0jeoy51v9vZAUvOAlmfybQXK/uZ/OdysOm9ckguVB4=;
 b=HZYnTYq17xH6aRJ8ceh/VwGCTYvkA4PJz2xxBfgG34bwPaA2sxeOhixcKkdQ59+sdQjSGqBgJR1+FGYO5WdqnPum9Gpxw2RjpbuO5mGx5tBRJVndmpcv0oJ70AdxQb1xdEO8N6OaIL7OioyHqotoT7G3Yvgv07p7DIMLazlxNf4T7iJMGMA0ES3hpWpR/kUrK2//bKXULbFx1gMzYecUsr62UZWQPVlPfObRVbcpwekHTPcG9tBgQIWxLvb4nIBvqTeZC1ues1TPoLX1mo/Z1IuLEnFWglFybqMsZfkiwfJmGBa4rH96tJqzvT2w96W89hMeZNpgJjOysg62tMzGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0jeoy51v9vZAUvOAlmfybQXK/uZ/OdysOm9ckguVB4=;
 b=RlilIR0ftERmn4F4OpgVGa1ZUJIrEaFQvi/V4Y41kp27BsyfChL8j7bnp/Is6NrFbOmki+omyLx52qPwbMFbJUJ9M6q2KW6grCNqcygWfgzEns8D/DP++/ZzVp1RE27Rtg4zky4oLmAseqAnGHKXwcyfx0iL3/Wt8qb5IRYI7xh1qitbRoIbzgbFb4N209f2W71nCVg8/MseJKyi/wBGtrEg8CEKD7d9/CnXQn8+StRgMy0doxQxOwH3fon2nfXeVsS+5StTXmVQMIkT+q8QY0/5NmKYW9KpLnzXSVVcQs8z8KFRONuAz0qapNDh1i+rzS1RnBmfSB6XFdOmyWj8lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:38:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:47 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/30] usb: ohci-da8xx: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:00 +0800
Message-Id: <20230726113816.888-14-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: e08dc11e-93e2-4967-c4db-08db8dcce01b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYfwoXTMCohUybNF3qR1XotistKQ0dkvDD0LXI1bGpAdIAnaPvkpXqsp6nNtQTolaCUbAEx9RsvCL99W7E1Vue6FE5QRxTR5v/O7qt9tePIAeYmgkZvUk4R/WLxaSyUzMeLdf2JSMSdEvSAZpKwtr7JUWbyj/lZQZoeTwHkuB9nJyu1fOIjLNyuhTw1Sjm4L7XZbzQ5yfNQ9HFet2GOLcW2kaCVsc5+djgoXgRy4HTOJULaRFk7PPpTmvU9X15uZnG+kjslOQvPkjwj1HfapuodO4zVJkNoLoxSOG+dBDZw7ye1WLHZroE0ghVGv/V6dLhin8tVkYHQTxL+/0u6/r5j2LSM3spS+F3JpEFHMLXxzIVNMUEU2K8qAfoWAlWbjh9O0F9fEHlH/fN07tcQO11swPv2+Yu0WJy2+Rbzk6iszFtzy7n1GpTvlXH2g/iC/6+aCrAkTMuBHthwO7Ss3lLsEgJl3EdST7JvGDPzDORrz/OgPl3nOwUcyHNtAgpkf6YNc534Ax4BA5rGrHZrAY7YzQc0dvCeFXVdv5zwYHFoB3iC/CGE/BUJiid4wAWZKykM6EoOryXIlPUwy+cwjefQFFj2p/Oy1pUmPUZDKeRp/kxjs9sJ1J0W/1kBUAHJp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hrlHJyGxEqJrerMl6qnOmNEegQqBh295JBNjcTURy8nesKbOYqP2skvAuuzj?=
 =?us-ascii?Q?mfe8Fc8wt/bi7J6O4bvZ8AiN+jMtzh5Hsjc1sGUR5Kn1nN+rzbWJiMc4QxaB?=
 =?us-ascii?Q?hG6MbHKmUbdqJhqpVAHS5PMeXDJVfg/Eg5RK8bL+ZKVwFxJo744klyBUpAWD?=
 =?us-ascii?Q?lZ+ltxqvhvsRkNP0IcO2VAbF8k9Aqp7tzW3Y1JKKPSc+dO/IHy9zAKidZTbt?=
 =?us-ascii?Q?3nfjlM/Yv3mjXN0xs18P56ci6G7xDhP1KUtaoOxlBnHj54oWMDfVL3ppHslf?=
 =?us-ascii?Q?HjcxXerBaO47svwMwbBUPypqdBcgPX7RCjAVQiy5ffuczklTsIRbP3r9S6YZ?=
 =?us-ascii?Q?Uh71cSGGLKXU7+5sOKLZpX4SDDWlvT8NgSN0/2uZHKdOYJ1l0mbYt5qM7pUw?=
 =?us-ascii?Q?ZP/3aXbNC3sornYhj7WkrFl5sBe3SZhBQEw6Yt5FMZsaIYBPmJ2jRf7rZIYf?=
 =?us-ascii?Q?wAwxf/BdT1eNnSdS/YjOTnBmk7EZ8i5JLWEWnFi1fYFyPtecBothkNa6r1bO?=
 =?us-ascii?Q?S/mL8X5J2kxdc+Rw6gjrrY06Yj0KgHnnCyljAF9JrSwlSgVc/vRGe6XdeUYe?=
 =?us-ascii?Q?rzLPmFk2TH5/uGGOw1nIIVR2vHZxcCJt7r0AyJBwZLhryU+EZ+TEPzUGaKop?=
 =?us-ascii?Q?3PK59PQx0BwcDsDhe5HORIX5j6DhlxIq94J1zpVTFnAsZ8iEXSlJXi6RJY9r?=
 =?us-ascii?Q?R6H4Al6M3F31eZRZ1ECNfoFd+R8aYotdhgWEc1pJAZxs6ddJ6KfFnNoTbSWE?=
 =?us-ascii?Q?Hzv6PtI7R/4uj+iaypHJ3qBt/357tIJzdwSaVarL1ui2t/U3WRPGyxJEBbk5?=
 =?us-ascii?Q?v6xgEqCrFobfemZgEUCXu5Ph2Z3E9vo10UvQLLLI7A2cNmheGgjzfPGpIQh/?=
 =?us-ascii?Q?4/nq5zW4XhvyjhzRE4srxvSEVsTRAHfsVGJfLUl6dSSBSpqQ5gxHYsLf2i+S?=
 =?us-ascii?Q?Dp18qw7gArcBLkmo9dpsW0lHMBbigUwfcD5r7GZbGex9DB5MsjB88odxHoJW?=
 =?us-ascii?Q?ISLYx1WSUYaJqwUV2MB+q3f3VfcLEV7lZ4xj3WZUN9k2AVcsNtd5LiRHoBWG?=
 =?us-ascii?Q?RLy6xKNiQW6zDLXoHETnvWAbDf653evWKoiuYJ6BytiBUmT7N7PdQyLWiAby?=
 =?us-ascii?Q?oBBMhOSAZ1/XV4aQhYBJALpCzRhKrQ1v7xisM+kzLD4atD8AF17nVbUnNAZC?=
 =?us-ascii?Q?yi22JNFq/uTsaHXuyGg0ntOji87GbvSrycQmK1iwv4rSQYmvttD9b7ik9ylQ?=
 =?us-ascii?Q?svsbPZ0jSpuAP5xI/lgKlrpUgWfRvok+4oP+IPftj32PgXofC9LFeZrUdvoL?=
 =?us-ascii?Q?EWJAJcIn02EHBPcc9BTDyO/8nklX9SY/64IEU/DvOJ1OxzqZyPkHPIrrHv8p?=
 =?us-ascii?Q?+u8vJrqExhNzJOiTgp1Rvb8OzTp5VV0DuklgtZc084RitDpz/wY7esODEk1U?=
 =?us-ascii?Q?CZ+8KTAM9vq/6jKOelXfLlgBXPaDuObbVymB6JZFyX+U7tGccttiy+vrOzy0?=
 =?us-ascii?Q?jT87K0paoETfKuBhOfDLJBb9UhFkmEKZXftDGasnS1cGzlCVTbkU9LwoaGOG?=
 =?us-ascii?Q?FTvtjm9r6gezG6maL/AHlKgyoaVWpr0pAgx9HVU1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08dc11e-93e2-4967-c4db-08db8dcce01b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:47.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUnvf++cBH/NYGOmTw/buWCFcvjiea3+wjKOqUF+/iG8WI1+c0z2+Lx9wsrEoEpqIrqCOr171O02Vu3dNlSl8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/host/ohci-da8xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index e4191a868944..40ec70080717 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -435,8 +435,7 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 			goto err;
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(dev, mem);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(hcd->regs)) {
 		error = PTR_ERR(hcd->regs);
 		goto err;
-- 
2.39.0

