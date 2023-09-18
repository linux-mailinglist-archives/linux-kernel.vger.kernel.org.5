Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809877A444A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbjIRIOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbjIRIO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:14:29 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C310C3;
        Mon, 18 Sep 2023 01:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edJJO6oTUABa43RhjokPtKmOrJrWMWjhLALBS3KZTPd//IRLDbBW0TCeiDZUwH98S/HPIt8j5dBnhip6D1XbJYRvNDfU6R4XO9/Uwm3wwBRk75smf4NVXmxyfTHRu9b9KVxeE/4h+HDvhyWJS2QP5z+Lr7Qsym/bN7TG97c35dDHiN+BGjqh1TtlpdVtQXwtOmN3s4+HJbD4F+26tLjiL3cpEdRHhVivns+SX+urUmFvZnscTJZAdCe78JGuspIKID3Gr3l3l/EMBrhfGTZFRLgN+W2bQ0P6rxpFFEHhVfVUBHA3x/U52l52b7Ccg9tQpOjRmW1rvj6hgDZ1cYi+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0vCdVPbYpxRxPq+8c933kiOq0iU0s8054t1UCYl/9I=;
 b=i8JVcgjzchHXUbx4sqi/wFhrSJpO1YyoDs57B6OPTznLEz8/KtS2o0rOCUxwYaUI/ZRxpyXyZN/PXCxcAi8CJBg4SUdMl1D/mN0nZJM8VAg8gVVGeFXAerMfjCj3OO+Ak0n3aY9N8VG3OFPv/Q3cdKKDNIgeVd3BmI/1fQAhU+kr5UvnQrjqPai2k3knaiEICoaYaO4m50b93Szxe3hqcoPwSLY0Wf12pb4I6Qt9yzsJMeqUgxiGtVYlwNPWThVlvM99emVfLEtOxjsIriwo+QEAL2DNRFSlLhf3bX0S9VjORc09YSDmMFzKoaPbeVYvhVxQ/m0qbqcRa02fLcXT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0vCdVPbYpxRxPq+8c933kiOq0iU0s8054t1UCYl/9I=;
 b=POSlahPqvNUauFjzGbrqpYbuIKXjfa3QZ2paIthHhbhiJKYvM90p+rQjVdQvyxtcvqkok7m2hn5iunJBnTzR2HX4/B7ySLrDlYuyjN+L+S3HBmglznbJGuqxEAGKk4DW3foMIkr/1W/iLCzGvDXtV9RKWsnrq5izdmNFiCuOkqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8706.eurprd04.prod.outlook.com (2603:10a6:20b:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:11:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:11:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Mon, 18 Sep 2023 16:16:05 +0800
Subject: [PATCH v3 1/6] dt-bindings: gpio: vf610: update gpio-ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-vf610-gpio-v3-1-ada82a17adc5@nxp.com>
References: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
In-Reply-To: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695024993; l=924;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Lk1/PR7ux5rPSbCqB5pk04ID0vKBmWjRU/5SR75uwqc=;
 b=btI7EGgXPVfyb54iMKquqAP8rT4hn19st58BXkclkiHLyEs4UKN5GdQnwvIJz0jY3xcaupal1
 W0bLRLHxO7iASHTICAYZmAwN32HBkyOcPi8rnFTv+E3gAijmwa57Tha
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: d131158c-e0ed-4174-7ab6-08dbb81ee830
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfhGXik8VT+HqdOH4EntHMSlVKbFLgTLYMPusUyDqZgno3iDi9D3339toPvY4aESDyTl/e9HipBTnWashWQH/yv/+QazSu0PQgfftJNZk2BHJQ/YSEwrcT5gFUSlRDA3g8dH6CTmvkhoNWWKI3FyBpxUSzfYujhaWcCJ9ga7UmgnDUA4f6vt6WOWeca9TiNpDqU3MfqwydKWD3JbbboBCf0a8W4ss24jYFlIcGvDbHuenoLMXfKSIds2HG4jWAXf6sJTnCCLt+aInJS3FHW0PtPSHgeHqwyYeyy5PxdFDL59eve24BQCCSvt8Zn5vISO0kDnM3s4qsr5YTlXGq1lJrnL/YdjI3em7Afr7Ck+YSUJ2rPiy11S6EirvB9NBDYQUPxlJneC+9+SICTo9ouzqxa+us+NKbnOjwtQp3X4l5Ml6d8t/SIYPKZfgRqu+yvQAhX8oZMUGipCFZVb+Hoa3faqE90Sg5msyUZXgnpFb5jVkDp7o9CJvGqLiSzPVBHc6zruO4jcH/wt+Nu5X9Z27IlR/g70TW3dN6hoMAHEAdQ3YxtWsPf9OPtqGv23C23jrNtH27AMD5RZ0h04i4/7nbv7C//TiBfNHOaEzC3B+01lGlSEVCnLUhxqq9GmVW/Ghqs/wltYmOlMxn2ei/Z7WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(478600001)(8936002)(8676002)(4326008)(921005)(86362001)(26005)(38100700002)(7416002)(15650500001)(4744005)(38350700002)(5660300002)(66556008)(66946007)(66476007)(54906003)(83380400001)(110136005)(2906002)(316002)(6512007)(9686003)(41300700001)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1NwWCtiMGZrVmJZdHZrcHJSbnUwQ2sxZ1VqRkVMNU5TOGJoZjRtbmJpQnYz?=
 =?utf-8?B?NTg0dVprY09QQXNxRVYxOVB5RFdSaXhZSFhGeUZ2cW5jeUcxSUhreUEyM2ti?=
 =?utf-8?B?QnhQM2plTWREWlE1QU9qNGE1bjQzSjgvcko3WlhicFcrUG5idU44UUltWWZu?=
 =?utf-8?B?U1VYM05Ba3N5WVh1QUZtelhNMUIrQ09Iak9NRGhvaDlWYVYycTcrWDJ6Nlg3?=
 =?utf-8?B?RTc4T0EwYVBwN3RrVEdTU2tCRWtHTWRibUhPK3hZVDFtSEZucnZVcU5xdkt1?=
 =?utf-8?B?eEQybnZhcUdTTUxSTE0yTGZCMytrUkp4MHFFOUx2T3VuQVAxL2hZZDBYL1Rh?=
 =?utf-8?B?c2hZai9IdFRrRU11dXVXeG16Y01Tc0ZQUno1cUhGYndhbHpyaDR2Zm9qbTk2?=
 =?utf-8?B?MU1nWEZYYk9EZXM4K3ladW5HYlRGSVM3YndKMmtlUGg1MytlRitXdGQrcW05?=
 =?utf-8?B?a3FwaGhYUktGRTZYcDZ2Vlp2dGpXVGZaQ29rbFpZaStoNFNOb1FndG4reGNT?=
 =?utf-8?B?clJGajY4ZjJ5T2tMZWZyUEhCS2JPWjhoMGdQcWZvS25GWHZKSE5KWXZNb2pD?=
 =?utf-8?B?VWlyTndxajBXOG1qbnFyaVBJYnJkM0RMK2JXTFMyaGFFVitPU0Rlc2wySHI5?=
 =?utf-8?B?c3BDdWZlMStFblNxcHY2bFVlWVNuL2JmZ3hMM3lsaFREdGJkSHNPb0czWUdN?=
 =?utf-8?B?SmhDU0F0WWhIaTZPVUlXOE9yWnFVd3ZhQS95YmhPUXFkS3VvNGZjV2NGQWgr?=
 =?utf-8?B?dXdQMGZCMXpMa0VLTG11dytrenA3QTdSQ1NwVDZxWHBQMWQ1Vkh0REhMOEVV?=
 =?utf-8?B?T1FXT3p0ODdDbVp5MkU4aXBQTFgzc0U1cGp5RitocCtFdmJYZERDOUVsbTFF?=
 =?utf-8?B?Z1JhYnhadDJwZXJ2ODdOS09nZWRCNUFMV2VTNjNFVWt6YTdqTVN0bHoyMk9p?=
 =?utf-8?B?L3BVa1VOUHRTblRmc2kyazRuUWh1QnlHWTRKWHpFVEk2cmdDUTNjbzZmQXV1?=
 =?utf-8?B?T2xjZ281MXd2S2RzNGtXSGRiZDA4UDJNUmQxYmlkRXhScFExT3lSMXZGYjNU?=
 =?utf-8?B?dU8zN01HN2tmNEhsSkhTWVhaUGpPOHl5bVE1MDlOQ0xHUU8vaEd2TzJvR1pt?=
 =?utf-8?B?Y0FqbkpzMWhnUStpVHpKYmtma1pKVkw4N2dBc3pOc3FicE94cmZha2FUYWh2?=
 =?utf-8?B?ZW83dXBxQnU1LzQ2WTk3UFZKeUdpOVI4SVpDUFhoeTBkSVhYVW9CRVhtcnBp?=
 =?utf-8?B?NjdLeC80emlUQno3Nnlvd0xXZXBGUTgwdVpzRUtwMjdUMGZGRHRCQmhpZmpa?=
 =?utf-8?B?TVpUaHZTTzVIYi92TEhUUEpMeGtqOU5xNStRcitGbmxGQm0xY3A2NS90bnVQ?=
 =?utf-8?B?VkZjSFV5T3Yvc240KzBlZGJMOU4vaWNseWF1ZFh6VVZtUzR5S3ArTVRuZTdW?=
 =?utf-8?B?OUlSbVh0elQ1Y1ZDaERsbjdTSHh5ajBtbEpIVXlSeFNxT1Q0aVJFd2UxRVZV?=
 =?utf-8?B?aXJRUC9oS1Q2T2Q2aUFkQXN2QTRUYXVTOG1jZDJYOFZKa3gwR0s2RkdaSnJo?=
 =?utf-8?B?TFJtS0Z3c01QcWpDUUdSQnF0VlRldlBmOWlGdG42dS9uYm9RQ2s0UnpaVkQy?=
 =?utf-8?B?aVV2WUxZaTVhRk04S0graUJNb0d2U2NsZjMwU1pCYllPSG9kMVJpTlFma3pq?=
 =?utf-8?B?c3g5OGw1TWV4UmorTEk1elNIMXMzNDNqL0lVdTh4dEdWejMxTXZnd3I0YXpq?=
 =?utf-8?B?SG1DU2pXV0tadFBUYUpUbllZSEhZTkYyWGQ2QzZ2WHRtbXUyNlM5VzNsNHc4?=
 =?utf-8?B?Q09iS05kMVUzM1J4aXNxRGpVZUxySFNEaEc0b200dFhhWG5pMGhuQ2I4NmRC?=
 =?utf-8?B?SU8vd3JFeFVwMzNpaHdtODA3eE1CSDVoZ2RFRVh5bE5LdXdnQy8xbm8xV1Ar?=
 =?utf-8?B?YWF3OStxMlBBbUVxbENYaVl5Y0RkcHdQcGswMDZCdnQrVC9DSzlkK0tVMGhk?=
 =?utf-8?B?L0dWQTJHQjJ4L3BJcE1ySk5ocTVQR0l0VnFSclBQc1dIaU94LytCY25ucDFE?=
 =?utf-8?B?VW84RWcxd1liaEVpc2JwTjhvamV4VGxhblNxdWhaOEtKUDNHeFVkNjZxWTFT?=
 =?utf-8?Q?QephicZK9XoFMZWec1eMjxxIp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d131158c-e0ed-4174-7ab6-08dbb81ee830
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:11:48.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScaY16THRyr14LKggCR11DSA60ezofZOks9RmpQNzOKfwArdNU9k8h2ZKlSzm9iVun4X3iRq4CbhB0lXnUKlkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8706
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 supports four gpio-ranges at max. To fix below issue:
"gpio@43820080: gpio-ranges: [[30, 0, 84, 8], [30, 8, 66, 18],
 [30, 26, 34, 2], [30, 28, 0, 4]] is too long"

 Update the gpio-ranges property

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index 7c2d152e8617..59427d97adf5 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -59,7 +59,8 @@ properties:
       - const: port
 
   gpio-ranges:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
 patternProperties:
   "^.+-hog(-[0-9]+)?$":

-- 
2.37.1

