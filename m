Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2167A76D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjITJHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjITJHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:07:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2036.outbound.protection.outlook.com [40.92.21.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DF2CF;
        Wed, 20 Sep 2023 02:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzDYlJfCGDtsB/sgdN4u5Xy7e+FRo3Hoe72m6hcxJAPjMJeJFCYWgZxDKflWXhEJfh4YLNOD946a5p5qEss7LhZ4BBIPMbzukwTX11JFybStqNLzvClUIO4t6mvFb6s3fkhwDFErrA9YyM9J7HJ9B0XLXDDT8zAs6gxRQc3dJPtrq29FwHpisPyl+11mNQS4KcYgYV0oYbU13xlmxnvciS/+XCMkjmJC6xwnkwr95hzjDYLr6XxIbHBwBY99njLtGO1HNNmpd3+mf8pwv55e3grqasBs8duSx6on4tGmKNoeluTd4tdXddAast/Kj1eibhsIVJhbOiRsCclsmly8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kENiXb4qlzWWnSu2KhmkK19p5zMSOn5d0b5G6RvJnZ0=;
 b=RSiaV3FQpOQr/2pCEDhMdYdYsmK4b0x1HJ7k5C5++miz4Dx6nn1WsDRvg3SFVh3QA03eLVsA/x0Km3mAK+OIO/IcJAbfwTB4yBx+Bw2Ke8DaZiApRBqSGSsuKBHdsymv3DobUtEbVWQU3kcSl600oFnGQEEFJ7+vvwXJxi+tvDr3MuYE+31cgq3+DyQuzMYaAdBQEgm4is9ZtLnD8ncxCBLGMVMhadJjup1VIqWNvnFVhoqkeT0h+QDtegLNCXRzcYE0ubbvP02ppQ2Bqf0yrJhPAHvxk/7D7KaSLo41qZ2WZ6afxturg+2bJG+kWpbs73BGoFnHLzCwoipRiXRqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kENiXb4qlzWWnSu2KhmkK19p5zMSOn5d0b5G6RvJnZ0=;
 b=bzrliBsJGYfn0TyWISuesDkEz2FT1cRSa41OiTYDZWG+aB25IyJVG2Cu79rzOlx9zLaE9Jx8ByOH5Ok4ETBdsaXhdWL6fsv+czsTbA462Q0mrt1oGAulK3WOmlVVrNEsE6Kx9c7qowcg5ugXjeu3WPhRVfTgWL1VxR79zHch4yiidqkfnSTzVDPebA0VNvPIQg1SBd8YewHR7me+Vh1GNreNSf9WkAISr90UGNvOldJsCkYUJf8/veD5uDHGqJIw2D7KwADA7LFfQ00Lnk/MCpb+trpNP3+iTKMoYw/GFHEZmwfxVxyhEesYiK/xvUU71AejdkZKU51izS5WrtxikQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB4569.namprd20.prod.outlook.com (2603:10b6:208:370::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 09:07:30 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 09:07:30 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Date:   Wed, 20 Sep 2023 17:07:26 +0800
Message-ID: <IA1PR20MB495308A2C6A11C42C25CE484BBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920-financial-declared-7b4b4baae517@wendy>
References: <20230920-financial-declared-7b4b4baae517@wendy>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ythxh9qJv6dRyLC2UQ6j1IjsFLq42j38EZ3VN/WXoe0=]
X-ClientProxiedBy: SJ0PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:334::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230920090726.143314-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2356f4-54c9-433c-1137-08dbb9b904bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sn1B1yy2r1/MV48Z7Tde7ilzjD18IrXaO83vULRpWx+pOIZ54b3vqLkoseN91nhb0Cg/DTq7fEg0LV5+ks8m34bBhcv2izW7+8fILhAG+D58JGLOJGtrjUR7Oj2z/3CXlze/AAViekt9BBzkccdT4I3+sDIusPIluockK6WAvwmJfuY2PXXlZ5nTVrWIodlrKQ2qvPnxxa2EbaTMGVUyxNXAUofmBXW8H4FJaO3YDLkWKNyLhybCmn98ePSCDGRC3RiWT8rDrZUrg9BzXf27T5UV4IAM0g3D08/LF14xOKwQI0lBUmQstGgdhxvK/SJAHzJiIzOao0nh0q7ZBzKB4QhcLVEqjDQE2zDdzkW0slF8XPs57sBw9RaIHiizfxBGC6BdueFpF0EOWq1DaYUjGoEtqXUcXb6RF+juBPSCLGf2a3bqcPBYinMz4yQ8w6QfTvOo/44kUnWA5jtS9S1yebuzpRTIKcGN3XYF2idyuTQKdirYuLftp7WwXrmsEsUO0wHd5pgCy6+oS0akfWVG9AxqNJri7ws6bNNpuHI0qy3Yq9Td5uRdOXXARYEJhDMyFMo2BExiMeezHaFVqpJCExKUlOuMV8PZ9g3odFN5utUBABL+Mv/E7im0mHdm62Yj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UdciULzY260B8eNmomoj75pCl6cxbc9wI99dgOJfgYaQFlla8J8XIuf+ovwQ?=
 =?us-ascii?Q?+uDHvDVaTeMQJY30xxdT3ID1Ws5nmT4uHsdFqlkl0pMuKVUatlI0HVVmavi+?=
 =?us-ascii?Q?FAM/LlL9f8Y0Rl85LpSUDcZ2RZnR0+F6t4lK2MjFC6B3ZCUb0u48iCq1h6PQ?=
 =?us-ascii?Q?uwNdJHoiNlT+JHnF34JZsXGlmOKvkLVu7qse2gp/kN3FyQ+uUzxI7OnY4+2z?=
 =?us-ascii?Q?MRDmSRQ67QhyKhVWULLPohq0chnyTs0xHfEy0slqQrMxENbfKoz0akWGnnlK?=
 =?us-ascii?Q?sz01jjwm+6nGGMZ+uq1TlEDMGZ8MyHqqk7jPMVmDbwh1kve8+Qd+1vMiJvf0?=
 =?us-ascii?Q?2hdjHC5c6h7/N66CZjecwt+4C66IW6EfacEsNZJvXGerBvX6Wx271s7pP+9i?=
 =?us-ascii?Q?1Xr57vgco76KV9RJoiKbI+NAifjSxKWh3j68VB4JLPC0mPrLQfYrF6GkszbY?=
 =?us-ascii?Q?epc6UevjawJ+ZlGUgK0mygzi3FmLQutwtB70mfzKezjfq38BMswCJSi5JFzq?=
 =?us-ascii?Q?uRLdIOluQrpFrH2a+c8I/QaSjOQOpP2xXniGXSQo0Ih1ul0yQWo2c4NNLEWF?=
 =?us-ascii?Q?VsDOrqAqzCGZ4qLuL398fCsFSdHljHXvWVXkP6CisDDSBLpcp3QfqszvazUX?=
 =?us-ascii?Q?SgwYtPU9QWQKkP+gDqMHvOHsRbM71f06FtmAcVJzri51RU2Uq6bZyuX0he78?=
 =?us-ascii?Q?o1vHNNIFSf0vrcp1nMZuTiig+OnkFr+4V8mf/VvX7SbqS19/lStKPoJAZMEq?=
 =?us-ascii?Q?iIJqPx5cKiAXsCni3VeZv19TX2uhTcVq5KZNnPyfuX6ekhM6Bg+QdUXw+e8A?=
 =?us-ascii?Q?8pJVgdh/UxBErFa7IxF5pUoptZ9QNSke3UwpRm/0SB9iVNjzi2kdMZPHrU0m?=
 =?us-ascii?Q?cOzYO+mEYxy8IZSxt07sKpLwClLb+idb/bZzkND3nSJ2PbprcB/cvL7pSQRK?=
 =?us-ascii?Q?MNcrE/3VGIjcH6WDXOohcbWgWLpO3YCjjxbc9vttuchwtvz6yH7zwuSknzUE?=
 =?us-ascii?Q?uh5uH+Ek2BYvD/C2mqvfJuLyGg/VlKQ8yRItjFJUH1A5Ur9q2o/BUM4ql9bm?=
 =?us-ascii?Q?1cfLtS6R1Ti9Jg/n8h6Mno/BtBj+Mhcm5ekUkeO6WWhNXIg45dOEmOuJJNmb?=
 =?us-ascii?Q?EkYOkBvHW5PUbjNu4IMXsnJkSCQcoEt9YPvO785c7w9Nv5NpxRrzXPnHQuy8?=
 =?us-ascii?Q?i/cVmLoNw8/V1NOdOezCMNTbKpDmZbkpFvPbqqK9i4Ph508OUQZykGt5SYo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2356f4-54c9-433c-1137-08dbb9b904bd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 09:07:30.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4569
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Sep 20, 2023 at 02:39:39PM +0800, Chen Wang wrote:
>> From: Inochi Amaoto <inochiama@outlook.com>
>>
>> Add two new compatible string formatted like `C9xx-clint-xxx` to identify
>> the timer and ipi device separately, and do not allow c900-clint as the
>> fallback to avoid conflict.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
>
>Have you ignored Krzysztof's comments on this? I don't see a response or
>a reaction to his comments about the compatibles on the last version.
>Additionally, where is the user for these? I don't see any drivers that
>actually make use of these.
>

Sorry for late reply.

The clint is parsed by sbi. As use the same compatible, the opensbi will
parse the device twice. This will cause a fault.

>Why do you need to have 2 compatibles (and therefore 2 devices) for the
>clint? I thought the clint was a single device, of which the mtimer and
>mswi bits were just "features"? Having split register ranges isn't a
>reason to have two compatibles, so I must be missing something here...
>
>Thanks,
>Conor.
>

Sorry for late reply, The clint consists of mtimer and ipi devices, which
is defined in [1]. This standard shows clint(or the aclint) has two device,
but not one. In another word, there is no need to defined mtimer and ipi
device on the same base address. So we need two compatibles to allow sbi
to identify them correctly.

[1] https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc

>> ---
>>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>> index a0185e15a42f..ae69696c5c75 100644
>> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>> @@ -39,6 +39,14 @@ properties:
>>                - allwinner,sun20i-d1-clint
>>                - thead,th1520-clint
>>            - const: thead,c900-clint
>> +      - items:
>> +          - enum:
>> +              - sophgo,sg2042-clint-mtimer
>> +          - const: thead,c900-clint-mtimer
>> +      - items:
>> +          - enum:
>> +              - sophgo,sg2042-clint-mswi
>> +          - const: thead,c900-clint-mswi
>>        - items:
>>            - const: sifive,clint0
>>            - const: riscv,clint0
>> --
>> 2.25.1
>>
>
