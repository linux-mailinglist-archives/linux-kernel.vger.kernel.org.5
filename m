Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCAF7ED87B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 01:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjKPATd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 19:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPATb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 19:19:31 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB8B125;
        Wed, 15 Nov 2023 16:19:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7FLw8wIj4n8NxWmL4Kuyi/PCvgVQibroygt3x2SWYz3PJ7JBxege5r0gYEQ4g2nCjXMvcYu0998d4252JtVwYli8GabfwZ8GAi0DT4b2I9CgoAdVppF9oCTmpl187VK5sVVIzXjw5Cr6gJ69xoKoZ0WsBhy5IoytPXZl3pLEYaqS65ngwYK30W1/JQAukpcjhqz/K5wqUdhoe/SguH4sHh4GqvkKUIzbr2YfK8XX3BoM7mrpdKU+lpfKbUX28PpZXl8UcyZXOxHWMaOqBO/la8nImM2gaQDtIhOVdTrdblGZMb0TqooYTMmq33Va5BLniTYidUeO17PYercZ5D8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJZw1ilAKaxYJ5a/ufcUn0IRp/33RDs34yyOOx/jY04=;
 b=Tx8QP9cXJpFQ/7bM6Rz8yvOMe9yNV/uwBfJCTlZdFu3Wh7V8C80RqsQG6r5878QXzjnbgJ4yLCV++9ZAzAXuYv70UAnL4pEbgWvtvMzSCFfjyTqghkABJT16PRH5naCnLEYtYFB5c/TKcqyZPW9Fe/TkZTJ8LsKXyyzxNIbR7d5dnzsPvyn7+LzsHcpUctl56rK9y7AnbD8uho89hFDiYMxy1PL3Ffazp+0UVIt+ygyagq98z35YbNQ0wPNeMJCp8o+aBbSS0ifcd6V5t65QZye8TcPTQk7TAvm+mr6KE79oOKr9TIBY0IINtfMLYRk8hGlN05LJ+pIhyEx68QZs1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJZw1ilAKaxYJ5a/ufcUn0IRp/33RDs34yyOOx/jY04=;
 b=u5e+qmafsJ4Su9BYs77qpCht3m9SEqr3BRYNlcJfCJ6P370ECeYWFE27NrXlfQgcTD8aof5xo0RKExpWEPbs4ph/j/+8T990qiWelHHVRkfD+NI5B3vkIsyBvxhZGstnDolp0OjfVrqEcavgu0sC9aiZJWeQEeaMxjJSgJbYj7Ogh/ufOxQo6EFRiwueM7B2/dvzdq3/vehExTupu1qiCQtbzaT1DQthTyIhilYTmkAvQteVpfP6AZ9AtyK/5ll32wTP9eeRTbs5xSzIEmxLeR+cmA8j5wf44dtsv1s1p9AUidj3Q1g6mTeoyP1wcOc47kj1y6NQI1KyuooqQk50JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Thu, 16 Nov
 2023 00:19:25 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::eeb0:9b32:19a2:8e12]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::eeb0:9b32:19a2:8e12%7]) with mapi id 15.20.7002.018; Thu, 16 Nov 2023
 00:19:24 +0000
From:   Chester Lin <clin@suse.com>
To:     linus.walleij@linaro.org, Ghennadi.Procopciuc@oss.nxp.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, Chester Lin <clin@suse.com>,
        Chester Lin <chester62515@gmail.com>,
        NXP S32 Linux Team <s32@nxp.com>
Subject: [PATCH] dt-bindings: pinctrl: s32g2: change a maintainer email address
Date:   Thu, 16 Nov 2023 08:19:13 +0800
Message-Id: <20231116001913.16121-1-clin@suse.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::7) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 32915fcf-90a0-43b2-729d-08dbe639afef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKvZhn+gE8DzD+JMYIsBXoyDsJ9bStJCt0tV2Q2T2VbjDFxZwZrGrlvNUbK3fZNjpBnBw0frfYUl/DZrihnik/zS3jGloL3+LtISM+RXuSPjcGg7/DQTl5jJm0rMXm4HQWZBaI5jLjd8ClW7baUsHfPwHS9/FmAVJZ3YX+1Vl0664GJzSQB3xSKeuZR8wdH9hK8zh3MUDJN92DIgQB9QJMgNll/vdlcDsW6/U0DgRr9nimELr4bo9uCBqk/L+VZMQfo/qGhmX0uPHtLpociRoegJND+gHRvcWwAqFHajPFv8GWtGJiMMPUkaqYD4mmU1fWM41MlEfcBz0xtkvGIDFuqf/BEfIjR1MhRxTWKEMJtwX+TJRyAYjnlfl1t8ZpOs3f1e/8yKLWCL2qbFB0eM06LNBgtDTp/0SmuPXePLfIb74BOnpZNmOUp8KA5PuyXK1IltQCjndNEOlqrF/9/RIhaJMh8JqC8+QUjukOtkWTvGiq2SPYGmSXAZny/yKMFdVuF0BDvFBwBVxMebob2TMT+MJ4xiq4XItvg043MdtjWKJW/vpVqmvrNcTj6lwwg0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(4326008)(41300700001)(316002)(54906003)(66946007)(66556008)(66476007)(8676002)(6666004)(478600001)(6506007)(1076003)(6512007)(2616005)(6486002)(26005)(8936002)(83380400001)(5660300002)(38100700002)(7416002)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzRBpisf099YVXyCr302KuyUs6p17slkpB8RCnyL9b8Wkwx7Bix63fQEO7vm?=
 =?us-ascii?Q?r+Z2+zIGxeWlYwx4L73ngVVWtAJ0m6b7lX4QFVHbkRINGEOZGEYzV8Y7yEqh?=
 =?us-ascii?Q?NtBYB5j+3qWi3rkpSTNojx40rH8wasIno1+1jzX5fU7jM0l9zVmTptYRUi6m?=
 =?us-ascii?Q?8qs+oe7Am+4T5AeQjfI3Ar4XoP7cBNn5qBuqO0sqGSL73uhfNgBLtutO2Glf?=
 =?us-ascii?Q?2j94JnDLpkWoNWFqdefjEd6Z+am9r+KXxc68OnWQuLyVM0s3sIYSqoBtl11e?=
 =?us-ascii?Q?nQxMSLtIf+PrfRziZ4oF3kwNuHXnlGLcmru21kzJY+T9ojGtaK/1aDz2Sr9M?=
 =?us-ascii?Q?TM+2/D8zieIXgRRSkTF0RljrUD0XSxXwNPx/TkJFT9YlxHeg4X4HdpH/01vi?=
 =?us-ascii?Q?M8gjnpiPnvMKGjj0IYhQWoawPTe8IncRwT61qMMgWaw7+TaCOGI79U1LgqnF?=
 =?us-ascii?Q?3O2DeElP0EVbQf2cRnKgoDtBgBtAspQbDXVPYLADyjtBSsPWoK19Cy5gw/Xk?=
 =?us-ascii?Q?FEWkoCFWHJkXW2K3NTfPeXncghDHpjjOaKCKkPmel9HRrl/bRiQNUltP9I1z?=
 =?us-ascii?Q?TylPJoLjFh+1CRty6/DcJwx1ILwnX2L0ywGWP8oB0HsVGHz3Dd7Bn35qmm3v?=
 =?us-ascii?Q?itbgQ4MOKPciyJWkJHWtPBUgQ8m+72Lrvgqj5p2KR2nICX3k/s4C7nP4TlcW?=
 =?us-ascii?Q?rloYGYk1bky8YTCHt0mbpHX/gnsHlYTV46ljCqaM220gkceD9EStLmHrESaw?=
 =?us-ascii?Q?nlPwurbub1gc032sExquDaVClbatWgz4a4OlUFycFB2T9ERIBB3KVhPn0Lnd?=
 =?us-ascii?Q?TZmn87blgac3plPClDHECa1sNm36NyrU6s37nQQxqIluPrVlO5Ea2rqJUyZY?=
 =?us-ascii?Q?s5txF8lXJOB/nYnatLbRZm2mnnqqr2UTVbnFW3vb7kc1RQOJs25E9e3JNxjD?=
 =?us-ascii?Q?E7vwkg65G2P1z7bO3lwwiToZeYxofgHZKh5q+OA5od+NbrAzG7thxop7hctB?=
 =?us-ascii?Q?1DIIDrszrn+uFqEHUPhYI1K+TZAZfAawQJTzR9Z38ikQaLVudd5SHvET6Ujm?=
 =?us-ascii?Q?GrSj4/U4DOlfjrvvjbZ2x/Gbt0Wd5mc/dQgR578UVIoRZuxGUbJseII04VS8?=
 =?us-ascii?Q?k29xy+GmayqahZrvJaCL3/VO0jhrJTRBcNbMMMM1u1dH6g1cYo7ekkJbN/mM?=
 =?us-ascii?Q?sJHA3NQUNwHAK5Q+5LRYWTyyHKlPY6Ujh9YXav62RkE9UKOtztZCaePf1vS6?=
 =?us-ascii?Q?ux0JJW/h0LS0ZHU238DjWdA4AulQw1bD8SlnwSqaOiYL98rqfq875wwjYWT1?=
 =?us-ascii?Q?Ehc7f0fgsEmzo6fqjclbn46Or5sbYPPGJ7ApjrI+X5JSXZ4rpVqe3Cky5AcR?=
 =?us-ascii?Q?VuuQm33kuPd6FsjqMuZwGp00VXg9aOuucSr6/DxrcHa6SPfvsvzyexXpQZ6d?=
 =?us-ascii?Q?srAvlwOEHGzLpdEL/q09FXTQGJW8FnDIxER2L1svRvbdjwvd2HHTf3s6TBFt?=
 =?us-ascii?Q?LOLwc+qNf1g6K8I5CAOZ+U6LBtjCfhnWO7o9wJ5deDSBlMvHU7oSOjhkkzZW?=
 =?us-ascii?Q?EBDNl3zvMTv+We3FxYc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32915fcf-90a0-43b2-729d-08dbe639afef
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 00:19:24.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heu9jaliMkUPgeQBVH94pITrs7ZuWcPgkr0gQSv9v/UmRPNlwAiX9wGte8rIDYa1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am leaving SUSE so the current email address <clin@suse.com> will be
disabled soon. <chester62515@gmail.com> will be my new address for handling
emails, patches and pull requests from upstream and communities.

Cc: Chester Lin <chester62515@gmail.com>
Cc: NXP S32 Linux Team <s32@nxp.com>
Cc: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Signed-off-by: Chester Lin <clin@suse.com>
---
 .../devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
index d49aafd8c5f4..a24286e4def6 100644
--- a/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
@@ -9,7 +9,7 @@ title: NXP S32G2 pin controller
 
 maintainers:
   - Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
-  - Chester Lin <clin@suse.com>
+  - Chester Lin <chester62515@gmail.com>
 
 description: |
   S32G2 pinmux is implemented in SIUL2 (System Integration Unit Lite2),
-- 
2.40.0

