Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB14F7E016D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346197AbjKCHmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjKCHmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:42:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7D81A6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyEXn7nMRXc3innWyS9dW+DnwKJV4jFJ0Q7HeJcg4oU6nP6QhoFvI1nuXdx2SnsY1n7EUE3moHwa1S7GoTP0kh5/Co4UD/SaoIcEAyM/lumTiu8RfREmgrBs0RyLo7SVCPTpNyoM0WG8nAJMO4+DdczP8MNsLKco5JxO/U6amR7x0ZfiTkSdAZZ6Oi6DXbLWG1kDmCW5NItMtq/S2NJJcKel436iLvu86uaKcgEf+9ZQYJHN+/x+rhjOUrbPEpKMZxLsioVOqlYKV50Nw8tWhftAqBUZXrOayKcmPldIAJef7MGTJoNzRZkGFoUqmr5t/DU2dGQr7dpeMk3oZyRSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbCTJz+/AMiDihj13TXUqJyyrAGtZ7GIungA37tS0KA=;
 b=YrQpJhhgCAtEujGw05uoDV47az0aJjMGPmqyMRF2XX8tXRHmPUXGGucUs6pISZ1sy0e/TZUFuwYigF7bxiD73eYUg0rN7BTzgmbE6zkuaihszguygoCtBzFLhKZywtUPVXqvSeFGm5UKLjLHvyxWC6oc+4iuZUEi4X0S+CcIUU9sf8a/ZnAuSFJO+BktPmcQfPSu7KwlId73BFrDRG11jxnRn9j/iq/4GbVPvFs8Ml3gjxw0GQhjrfwOm6XTRiluVqT5KxpR5VYyNp9QTy8P9niCumkIrhzDAg6lpr3AWRqiTS5jmbzoKnMv6JwjY1QnHfjFLR2rugR88s0F5qsQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbCTJz+/AMiDihj13TXUqJyyrAGtZ7GIungA37tS0KA=;
 b=XRe0JmP2paoGEs4auGabIJzfQmpaH0D5CTXVsMTgD5QiVFH+ICvJWbVGXpccwMUQ2gINk8kQgdV5zLTOVA9/hQEoxEvZeUOgbl9hGxQWY3temYmvM+HiOjTsssbLkr/c6F8VEg+Ywex0P0tp8GXvN3r1gIfZf4Thg2EDNWP3cWbw2YruGC3F4zX4uDt84ydvrK3tjlZ52N4vjItdlrUTOqKoqJZWwiFurUpn6Bioi+/wxa0rhFW0xm7KcHfQyNXPs+NEYRQVXNi6rsIiLLUdtIJcxfdfRRm4Sej4qo/KuSYbzSq4ic0/dyJETwkvWRJsTF6WmTFGpCTxHWtduHAdKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by KL1PR06MB6178.apcprd06.prod.outlook.com (2603:1096:820:d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 07:42:43 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::7ce2:1ea:7294:50fd]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::7ce2:1ea:7294:50fd%7]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 07:42:43 +0000
From:   Rui Zhang <zr.zhang@vivo.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Rui Zhang <zr.zhang@vivo.com>, opensource.kernel@vivo.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Only increment use_count when enable_count changes
Date:   Fri,  3 Nov 2023 15:42:31 +0800
Message-Id: <20231103074231.8031-1-zr.zhang@vivo.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|KL1PR06MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 21498d60-8597-4ab5-ad2d-08dbdc4076bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPX6Zjm1tQZwBIOMIz6WHuxMu+KG40ba7yTZshpMiNRxbqzI74Vxs6A7l/b6VqsVz9g4NRw5VDL5achOxbzwC0vtMsWmCQo/T1JmU2lXSR0bfwDQEqEdEd5aDTHsXRLK5hWk+mLfRq26Hzkcil6c96I6y3JvXW1rGfjThuzUE2LaT7oblK5gQe3AmoJ5L2d9ym9xzy5znIfN1jFOjuTOM2aHEVEcm4vajvGbYBr6oEusILdwtWUX1TEhsIYkWq/d/opJMZbtrYvbF+9L7QWKJci8EJMYkKBfKgyloCodx9nFbucX/UiUlQhAcEIjTFQyXbsvyuDqrKT8WUKAjd/B0GAIxtnxDU10917Q+RD4lNfSQ4XZRF596NU7Vh3cZrn9P9PKHUOHGZzDoB8dscTMfQ9XLbWQjjJtSSIc6LqSd6CqZS9gicAh9yv0mkMT2npUosRUf2Mcuu3bZ+f8Ov3wrkZJEvF5ZJJm5Gmr0cjomM3fSZPfC0M4mQdugyrPP8kMqfm/9Xkelk8jIvJFxEtjQkEjNQAI9l7x17or578C3zOvvrsQOSdyXk6YiSH2Kw0hhvgCO1SgIh4L2di9xsw2kRBMYfCz4kPzcXlKx8FUUffHyXlbb9MWAhucZjIKGYFk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2616005)(6512007)(26005)(38100700002)(86362001)(38350700005)(2906002)(83380400001)(478600001)(4326008)(6506007)(1076003)(52116002)(6666004)(8676002)(54906003)(66556008)(66476007)(6916009)(36756003)(316002)(8936002)(6486002)(41300700001)(5660300002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsrzu0DNz2BL9vFzPpPNEYCVg1a8pdvUaOAxP1soslOAIL8bduLwBaRLx2gx?=
 =?us-ascii?Q?bJwnpdk+sg9hJgCSLDsqROlICYfLr/w7ok50WyUSbmOtQMft1Yx9SxxltjkL?=
 =?us-ascii?Q?i2aoWyJIU26r4l+vaPFXujb36/3Mny4+5Lc2YhvI80Mw2N1wiuCrf6q0esCA?=
 =?us-ascii?Q?osNP10z2N6mAKJiSVs31+KIX6AU64up60Ian3YAK4tmqmC4zTBYcf8HT8UDz?=
 =?us-ascii?Q?9OodlwNZIJVnWLcdR6iYkWjhz0KMGRTA/0gj8q/2BPPaMZL6R3lGOlYB/QcA?=
 =?us-ascii?Q?DhKf2VaqJ9Yix0I9e8PSAs1KHiwrqz6CvJ9l3tLcuI2XiSDid1G8k7Pk9YTh?=
 =?us-ascii?Q?zjIMfH80eWL+iAgDgOBAtm11sz12M8f/yvkDkecnBq6XE0xlPATOrDMNWvX/?=
 =?us-ascii?Q?Ob3EQZdeEBnc2y8BmdsCGX/2OFDqDlN4wkPm1muC8uLkYP70qa2hXUoByjmH?=
 =?us-ascii?Q?/xHpAOWfgweBHUkXbKB3lj29P2rjxsTaWU6/GVZ2EBsw8PPxnsMggua0ldZ0?=
 =?us-ascii?Q?4W5nr9RYgmA1TsCsr6PA5XmVoGyGdXwSxnr5dHKD3iqsDhhxPGaWvenuLEpm?=
 =?us-ascii?Q?VWTbrWFrnVSQReoMOOLXy3VEDucCbRl2PQ/lEYOO73moy8yNfCdzqx7XZsCX?=
 =?us-ascii?Q?knKVjKmlYADF5dyAMCWYGfyRhMEwe9MdJd2V5PCznXIa1HnjmN32qGMy/eG5?=
 =?us-ascii?Q?mFb7h3iuHVE6DpdCGJ6O13XgpJUK0Qnii0IT1OT4dg+bzc61W+eiqG+SEzEe?=
 =?us-ascii?Q?WcJL7zbouS+mZFbBOIb8PI8xx5hsqCF6FiJZNNjDl1Kf3Vj7uDfpVABbmZQu?=
 =?us-ascii?Q?c5pdznObWe7iMl3EeiSFK9/vIRSHKCTZTKzHGzfwjAXRQYUTxcE2k8igQm04?=
 =?us-ascii?Q?ilMB11qE/6ts4J6oeKjwabRfR6pNitIhqM6gHP/cfFjhJaY7o1LWPOCp/OHE?=
 =?us-ascii?Q?FOaAzyE6rJvbDPFzRT+mehqaIUCuapEgLn3B/3M02WyzafYzkH/JQnaBnMLH?=
 =?us-ascii?Q?32EG0QOXywzEh+cAata6Oyxdh+PzOl0G+5dSsnXTkjmVTz73RvKuFT4G2nSk?=
 =?us-ascii?Q?winZOZ90VXEBRDqPSVgiyDFcTL4pBWSWqHBiY3E1aD5OX6TR9jIXOx9Cq0p/?=
 =?us-ascii?Q?VBF5EsRYEgdFnuEJZNMSAxbTRrqSQz4uh+ecNuEClc9eZT1jcmg5u5tp6G8L?=
 =?us-ascii?Q?+c0A+5mdo2fAW9GXd7YjZRFJ1r6B0QdSFkiw3Mz3SA7QaZ+23rfYdL5KkQyH?=
 =?us-ascii?Q?5DPvlNTXoxEQWgk/WoGRC+Dufm4KrHSZwNdpQXVSKbzHFjlxJ6W27u8tHFA4?=
 =?us-ascii?Q?4Gej6vtlxN6QwFOl5YbKcnhGSVqU337YvvSgV3DxGDGDIzi0Ur3GBZg+CwDb?=
 =?us-ascii?Q?1FOxqtlgrOJlQnupJWsZdj52RpO3vRSersm/kgyuD5Z1J3jGEg6n43ecN8UV?=
 =?us-ascii?Q?wJ6LKE3EmqM4K2nle0qrNpwtWiQRp6fJflX9Gji/GcFIhfNaoDYXmlDDpmrl?=
 =?us-ascii?Q?rE0z0fd/H598nzvDSxrYcRun3qxiURVU0Wl9Cc2Z1wgMTKw/ZNxYDnjHmXU0?=
 =?us-ascii?Q?RJlnv6ELsl7Ro9LrqHqPMSatQwvgUzyAqf40Z8g1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21498d60-8597-4ab5-ad2d-08dbdc4076bc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 07:42:43.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFfCgKl96FBXV3oGSZTFTH0Qi85tD2ScOWbiJrzQl2eRexcnnykzl2seeAk4ntuJ3Vet0VSVbHEoePWSG0mnXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6178
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use_count of a regulator should only be incremented when the
enable_count changes from 0 to 1. Similarly, the use_count should
only be decremented when the enable_count changes from 1 to 0.

In the previous implementation, use_count was sometimes decremented
to 0 when some consumer called unbalanced disable,
leading to unexpected disable even the regulator is enabled by
other consumers. With this change, the use_count accurately reflects
the number of users which the regulator is enabled.

Signed-off-by: Rui Zhang <zr.zhang@vivo.com>
---
 drivers/regulator/core.c | 56 +++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3137e40fcd3e..a7b3e548ea5a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2918,7 +2918,8 @@ static int _regulator_enable(struct regulator *regulator)
 		/* Fallthrough on positive return values - already enabled */
 	}
 
-	rdev->use_count++;
+	if (regulator->enable_count == 1)
+		rdev->use_count++;
 
 	return 0;
 
@@ -2993,37 +2994,40 @@ static int _regulator_disable(struct regulator *regulator)
 
 	lockdep_assert_held_once(&rdev->mutex.base);
 
-	if (WARN(rdev->use_count <= 0,
+	if (WARN(regulator->enable_count == 0,
 		 "unbalanced disables for %s\n", rdev_get_name(rdev)))
 		return -EIO;
 
-	/* are we the last user and permitted to disable ? */
-	if (rdev->use_count == 1 &&
-	    (rdev->constraints && !rdev->constraints->always_on)) {
-
-		/* we are last user */
-		if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS)) {
-			ret = _notifier_call_chain(rdev,
-						   REGULATOR_EVENT_PRE_DISABLE,
-						   NULL);
-			if (ret & NOTIFY_STOP_MASK)
-				return -EINVAL;
-
-			ret = _regulator_do_disable(rdev);
-			if (ret < 0) {
-				rdev_err(rdev, "failed to disable: %pe\n", ERR_PTR(ret));
-				_notifier_call_chain(rdev,
-						REGULATOR_EVENT_ABORT_DISABLE,
+	if (regulator->enable_count == 1) {
+	/* disabling last enable_count from this regulator */
+		/* are we the last user and permitted to disable ? */
+		if (rdev->use_count == 1 &&
+		    (rdev->constraints && !rdev->constraints->always_on)) {
+
+			/* we are last user */
+			if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS)) {
+				ret = _notifier_call_chain(rdev,
+							   REGULATOR_EVENT_PRE_DISABLE,
+							   NULL);
+				if (ret & NOTIFY_STOP_MASK)
+					return -EINVAL;
+
+				ret = _regulator_do_disable(rdev);
+				if (ret < 0) {
+					rdev_err(rdev, "failed to disable: %pe\n", ERR_PTR(ret));
+					_notifier_call_chain(rdev,
+							REGULATOR_EVENT_ABORT_DISABLE,
+							NULL);
+					return ret;
+				}
+				_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
 						NULL);
-				return ret;
 			}
-			_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
-					NULL);
-		}
 
-		rdev->use_count = 0;
-	} else if (rdev->use_count > 1) {
-		rdev->use_count--;
+			rdev->use_count = 0;
+		} else if (rdev->use_count > 1) {
+			rdev->use_count--;
+		}
 	}
 
 	if (ret == 0)

base-commit: 8af4b4efdac959c02e2a82b4e2fbb8f2c0b57c1e
-- 
2.30.2

