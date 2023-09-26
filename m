Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790927AE425
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjIZD3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjIZD3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:29:10 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425FD19C;
        Mon, 25 Sep 2023 20:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjBb5RfZ/IUkMvJwuHwg/zpXf+K45sFGyAsbZQthl685QwaPKb1gVbamoKiiiYLUW9K17Vn9bCqE+wD0nAIio050c5abTn9Ses/omJvq31tDk/VyNbYg2eTpZMb8Y6aiOjKGWWJDjiOWMvIhxrcZ5ZO+JCSf7AxEE+jJqSO8LLD1JxIrb57YGrNKFUr3RgLshoGJa1zAm4vl1uBDppFSHAF/PJLrgIgVui4nk5UM1mYcrAuWEeDToHpIIaH+c3tTstrAUTjKIcqTTQYnnvQV0JhIsGddZ+SjnOaqAvTnjW/bDOKHZSP6GvhWTU6JP+OtXDnLk1o5GMef1eNBKt6Efg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUYg7ecVMzlJxOq90M5sG3FHyN4xSPKHy4KtOlukKkQ=;
 b=LZCDK+LhO3KWgAxteYF58RpQrbLKWUbd1SfLAzOgZxG3MtOV3nvwrlgUtIoVn5ceRCLMx1/y3nmUsrH6KRfgTvXXO/fQNFLqezzxdOrpxg1DhOSpn7sx4CFjAu8clFwL4tS9fwoXgRITlvlUsGdKK+ts4wJA+VnpJnpTtBzwyN+04f7jBPErTSK2OIO2Ya/rFEYySqKjGqo9vdfGbrPvEzeWYLqmGzEEzYpkCXEVBVi3H8VWJUM+31zjBP42oXaIOsl8gR/oJ1K2vfReDaOAdbZDGIvnn1BYceWhiYQfRW1U0O6YFCpZ7fvJzn/nBqpPUSchoEt+atrbiKZgfI66NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUYg7ecVMzlJxOq90M5sG3FHyN4xSPKHy4KtOlukKkQ=;
 b=Oksy2TMk+yEGki1b2gZ0t3hWdR64FX/HiwAc7/FcUnXoNYc8WR3IBS9VJPm39CnZLPP9SCke+c3vrvwdbJSgqqOQ7QqDc4RgjEoKEQwWNpS6gkBfpnLtivNIhDOq9BY9VSK+RvY43qEidATMi19Nvhe7/QZ0e8dfw1kKIPql1To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 03:29:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 03:29:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 26 Sep 2023 11:33:19 +0800
Subject: [PATCH v4 3/7] dt-bindings: gpio: vf610: add i.MX95 compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-vf610-gpio-v4-3-b57b7f6e8368@nxp.com>
References: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
In-Reply-To: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
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
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695699209; l=767;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=bqj5w9KLakqJpVgkOAy+Vm5e7QyS1473PO8SpQf9Vaw=;
 b=NOhGJWSA+JQcsMGH36e/sk8ONRrcC0ZLOz7xHT2edjb1j+qt7UqFd/lTTVLcihvN998B6IuyN
 CZrqIu2WKqhCORKh+CUXJopIBTvSVp6HY2uzkAV5vUsIp1XKP3VSnTD
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0a480e-dbd6-4db6-09b1-08dbbe40b960
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvUz8weZQc+3kfmeOVB3LwpknoIaM0rLDErR2dvy6zqe0kys13gEy+auA+mjABX3/psl7Zv1z4J0+lq/VYmAaUP0uGECakOEL7OeU1haajGr9gWfU6yZLs4EV7Ki79Jg9LbU7S3PzhggyW2M/qQwfVzhqYybLAAUlUv/3HMQ7Hgc88EJiXX/cu3tn6/9RPty7DZ7KI7dF3DiS67KvJpX3zoH6JgkxVsqB9rRInUJLHWruTjoNQUPG5lDAfHsqOrfc5ELR+YqrB6eoUqGw6ETZCq4WlUs0JX7NK8QpcDsP06fRY8Dqjev3bOl30frpFicyL9qTVJhfJnjytlkxsrbJRNwHVfe5iJ4LGnSrgR1l6oKLXlda2CVcsxWVxePfG6Wze8to6Ua1QnfO4jd00wxbO/BPrnyoQ1kr3BogOfn+4/7LFZX24ryxK5W7SutyB4ywysoLnOH89R7D7a4s71AY8C3ZQtJii3UhVf2ymXXcWYNsybh/7AhmJ4mCzRjJ/r8p5zqY+iCDHyWdm9YqklM1+59UDMhy3JG/FxabXoiwDa0RxdReJ+OcDdo0aclq6DZW++FLUSfzdyxA16L6Dey72awhdlOODGkj8PQZhCSx4v/0u2kCYnbJAE/TUBxbT7Z7b/sn2RitqQ9kZrFr2Oo9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(8936002)(4326008)(8676002)(7416002)(54906003)(66476007)(66946007)(66556008)(316002)(26005)(110136005)(86362001)(4744005)(2906002)(921005)(6486002)(478600001)(38350700002)(36756003)(52116002)(38100700002)(6666004)(6512007)(9686003)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckw3MDlBUVBxQ0hvU3lFb2pRYWdwTS9tS3ZCTGdSNEwybElLSFR4VmFZVUti?=
 =?utf-8?B?VHFKV1pnRGU5UjU4SCs0ZFdLZnZXM1Mza0U4NHRZVG1yT2R3SC9BYXNhU1BJ?=
 =?utf-8?B?SjBUdy9tYW52ZXhjYjVNYWlqb2xEODJGTVYyNkpJT01iVHZuNTdMYSsxZStX?=
 =?utf-8?B?NzlsbnNqbzhzQWpFVHc4eGIyMnRTSEdkcU1iNkpyM1Nsc0JMb1NkWXNxclNk?=
 =?utf-8?B?cjg2ejRua3NqQkthTTBDQU9nd1VlYVJJQVRmek5HLzdYVE1YaGV6dVdHMUNW?=
 =?utf-8?B?L2RDWU9HQWkyS1d5MmtjZVZyQkxkOEwyZG1WQjJPT2xyYTd5WStzRGZHYWsv?=
 =?utf-8?B?b3IvaHBYOWswMkxyYTNZdzRIdXpuSVpqTVlPWDJtVzVvK1hheEJXaE1YemZm?=
 =?utf-8?B?QlY4U2FFalBsYzROQlBoaUo5L2JTWnRsakNJVXQ1cjFwZUJYUzJUajhyeHU5?=
 =?utf-8?B?M1dHRFpMN2hyNXBUR1NRRjg5R0Vqb0FuYnRrMUhXR1lqYTMrT0N4bFVDUlhm?=
 =?utf-8?B?T0w3S2s0MzBvQ0xuNXlpM2tTckkvQU10QndCQ01QTW43TFRtMWMwaUJ2T2lP?=
 =?utf-8?B?VU4yNnNJUGZmOURUYlNKOUYwc3c0Z0VCK3lpN3cvY1dvanpJU0dCMkFaMjU0?=
 =?utf-8?B?OHk5ZVNIUGxMcm83K1RkcUdEL0xLRHYzQys4eWF3Qmt5YVhXV1VHR1hSbGpB?=
 =?utf-8?B?bWFsbGdBVnBrcUpCOVp2QzY2UDJsd1ZrenFpcUgyOE5oa25ERXhqcHhnSkRP?=
 =?utf-8?B?dkphZ04yQUpLeEZFNytUay9CYWd5K2hGUU9MNEdySCtFRjZaTndUOERablow?=
 =?utf-8?B?RFpob1dmZm9uaVRPYWVNYjBuK0M3a2M0SE8raVAyZE9OQjZSWFg3WmhEanRx?=
 =?utf-8?B?MVdtZVVBSnE1NWM0b0Z6bnJUWWtUNTV1OXFuaWdIU05iR3hzYnM4SVF5Y3hB?=
 =?utf-8?B?aW9iYjl0SnVYeDA2eStYWnhpMXFkNFczWEdNU3gvdzFyakNGWm50RW5HamNH?=
 =?utf-8?B?ZEtPZEZ2WCsveU5XOGkvaEpHUGZ6anNoU00yNXBhcFJxb1A1NTFwSis3OVZK?=
 =?utf-8?B?c25ZLzEybUF6b2FORkEzRzhkdTFTTHZSWE1DVnVJMXc1UHJndjNXa2liZXVx?=
 =?utf-8?B?TzVhSTd6c1E2a2R3cDJzcGpvZlFEalkrMnRldGd0TzJ3enVtZkFEUFgyWGh1?=
 =?utf-8?B?Rk5HempsWXJUWlljMitkNXpJMk50bEZ5SUIrWVViUzgxcERhVE82T29WRTIv?=
 =?utf-8?B?L0hqd3hFN0dmS0JQREdEdFFVMCs2VmdkT0pkc2M0bkVkbER4N0VBaVczSUlp?=
 =?utf-8?B?eG5qaDROV3JQYkNIbExlTEdkV083L2RKb3hiWW9uM2FnTDR0ODVTdGh3bjV6?=
 =?utf-8?B?bThSUGQzMFJYbkR6cWxkT2YxODFHWFV4Z2RJMDRzM0V2YzRZM1QvUDYwTCtQ?=
 =?utf-8?B?ZEk2Q3lQZE85Zm1taTd1UnhuVHVQSWJHS1VzR2VsTk5TeHJLazR2aTQzN0Z3?=
 =?utf-8?B?eFRLMWhGL2tCNXdPSnZYL0xudHdHQzNXV0NlajArT1N0UWpDRHovRDZyT2Ur?=
 =?utf-8?B?YUROc2diRW0xWGRoQ3B3MWNJRzNydDQvSzBLVSt6N3M2bjhSTW5rWGNCbWl1?=
 =?utf-8?B?WjVveHlJUmxEYmV4R2k4d2FmRWxud21mbUxoYUROTVBMNlYrM2tPb0lack1O?=
 =?utf-8?B?bmRoWUg4QlZIa3YzUW5MSFFjOUdqNEk1dlM1OXZIbm81dURtekY3dVdWOGpw?=
 =?utf-8?B?OUpvdVA3VDNVdTgrNUkzSDhDU05ab0REOUlLU3pta29tcS9GSEJhZDVlR0VZ?=
 =?utf-8?B?cHgyTkxOOUJYbjRnb3NiRHVDaFkwekdmcW5jMThOR3R6alZVc2dKTWxLZHdN?=
 =?utf-8?B?czd3UGo5OWltdlFDcVNUYjZIQ0gyVzd3VG0zbC9PLzZ6UytRWnJLTHZ2VHg4?=
 =?utf-8?B?RHJ3SXgzd0NBMVI0WmxsV2dDWGt5TXBOWHRKNG0wQlFOM1ZaMWFEV2x0Zy9r?=
 =?utf-8?B?aU1raGgwZ0RQZnA5dWlLNzUzK1hzWE1Ra1hDbmwwR055ZmZ4VHdRK1E0RkYv?=
 =?utf-8?B?amtCUWw5QXVGbWxuTHFMTFNhYjVjRDNlZkhjZ1BxR2lWbzl1VGpVbThnc1BK?=
 =?utf-8?Q?vFB/pKMAORB5lswyNv6gfZEyC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0a480e-dbd6-4db6-09b1-08dbbe40b960
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 03:29:00.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50sWKABr3eocsqX/jHb49eCkqPf65HaxSpDEfu+m0ioGB+r2hoq86H4gZ0iRgpeQmt7M1k1rS2IZxUUB0Z8k9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 compatible string which is compatible with i.MX8ULP

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index 21199bf221ef..a27f92950257 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -28,6 +28,7 @@ properties:
       - items:
           - enum:
               - fsl,imx93-gpio
+              - fsl,imx95-gpio
           - const: fsl,imx8ulp-gpio
 
   reg:

-- 
2.37.1

