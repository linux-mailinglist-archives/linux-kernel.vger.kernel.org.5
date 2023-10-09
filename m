Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006697BD9B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjJIL2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346307AbjJIL2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:28:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2037.outbound.protection.outlook.com [40.92.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77216D55;
        Mon,  9 Oct 2023 04:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS0DGXP/lCEfI9GwhRYnH0Yji+hA2K/UtTQCwFNIa07NJ9BPP7NIPQTmrr6gPLzhB3fVi7YzKgzekXBawScbgxxPB6R/iHLk49rScvWgPRj71O5ztbjoN32bhWn4HaM055/Qu9jGGWy2o7qcCl55pFMpd5qNhNzbkWzGSjPn9639B2NfpPhjmzKTp5zp3r0/Tjtc9bKOkfI5DQjS+1ZoEIL51c4/LrHxBfF9s8nxXKM2bl4THz+pl0ZvP2IWvWe+C9H4lBNim72LZC0IgV181423QPjoVCb6Mmf4ZEcpry+ep0U5vCvBP2mD8qTMuH3poUIJUQRTopS2U1ltE2kcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXnbB5CW4hcWd2KYzqwgPMuwW8QdiH7A4QDaJ5+6seE=;
 b=BoA+d7QpTFCRklGFVU1n2GSXejdKLvp9l+a7wxZP46iC5MohkvP31HdIHoz4lkpPfGhZ0W5z9MxTEWqDoyU5RWVOu3go2JgwrFcx844S/B+9xij1c1SyGe0RaCUqf2AhNPLsEI0rI77jPE7y/EMdSSp9/5ZjaUuR/mnrqXPuSXP5dKh8YAzukd6Bs8RDPg8V00dkm08ZjCdS+bNJZRwUtQ+CjrLOLr0sGpFscu6rS3nN+6lZoWjk0KXpDRrfr0s/Ht+YctwcCn7B0/opvqp0Xa1cB+heRVkM0k6Gkp7fRQS3rG4xBl6oD3J+hbg5k5E1z1NizRJ1F+sGp+2ggo+vPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXnbB5CW4hcWd2KYzqwgPMuwW8QdiH7A4QDaJ5+6seE=;
 b=UqWYWpjPjQW2LdQN3b+OapyiEfmOBVL4YT8hTNtvkxAmCPIKPx40JWyivvFSbBz8C31nnj1uGL8K9MxsqPfep4+yTZt3XXWgMbYBF3lLeD9UHRRS18IthFlunHFDuTSQQWeV1yYpJtJE52WDqj5JZ+BC/tMMNkZk+GljPR1b24SgeW4XKD+j04izE7Mb2Wo4rxApZXIrLWJvSYu2zna93QhcEviiu+EAan9BaQjXpxPDUeR25tGYjt3UZYZ3AuoyHrgapvO9u2zmTYo9ldVRCn+eTapWqdOIg/rPw8dMy9yjBVf8NfplPG6fAyfeZMSa4OSHmkXrS7msr7AqLB8ZJA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB6129.namprd20.prod.outlook.com (2603:10b6:510:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Mon, 9 Oct
 2023 11:26:51 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 11:26:51 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/7] dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
Date:   Mon,  9 Oct 2023 19:26:34 +0800
Message-ID: <IA1PR20MB4953765820AEB14EF4BE75BABBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009112642.477337-1-inochiama@outlook.com>
References: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231009112642.477337-1-inochiama@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [69MCxFUQEp9rWRv/prgSpYGs4OJyIc4GX0Lw1vl1K2Y=]
X-ClientProxiedBy: TY2PR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:404:f6::35) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231009112642.477337-3-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b7759d-4d1a-4de6-ce83-08dbc8baa1ab
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSk6UeiwPjhtVlxUZe+XRo4j+4sxNh6zk+sr14d+WKhNQd44grVhXkUhWYmYpTegWkcvwfKr36N+EwGDt2zoZhPuFE/o6ZNOcfxWkxRmDYSNrpJSbzJPcYbhnmpvbxBzb7N1wU94L/u792p4HpC7ADJL74dtBFkVKe5LhM4LpAWZwz7TFctki9s0DN4xqJcslJwpkUGTpQ0x3SvBEYVIkNQOqtVNyXWHhlx7r13Ag/ZUf/8QlOMr1oLzDPK9CKj0uo97qGory0EVRNWpwjOa8/mV0Qzb+LAr+t1vG/7E1mTCJac9n0VoiggB6RNGPs1MB30JwJyUqqzO//vkuppJ5PU33aov+vXWxBHCKbT3Zihijk68clyzhh0akue1glWAwg5/c8rmxrg5Jnpf4XITODWRW/R5/7Jlz7ITxpkUX5Bf6Vr4Tam40fC01t52RyGgzGChpVTsmC2eJkEqUR4RvdDqLIiC3GHKcgXFAgK7TQWQgDfhxZlqH9z99uPv73++AvJAontpk/W6eY4o3wTdmG5aRjkU+9yzlQ95L63HXQGDI0Kt8OKi2WXtZiogPqNC9z5pH2N2C0TqbvWwabJofeHe1K/e9RuLnLSGK4NuPQETD97n+8kpq5B8ImGR5isT5UbMBNd65I4LGGwFXTZpy22YaApxOzIg8ImDLa/VjkQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lDRt2/gueHkLy2T1x63fwA3gBXf4CsWVuCM0D3/u2LIXftZFEfuuFp6qRf1P?=
 =?us-ascii?Q?pjuQm2LynJ/hTAaEAQsDRrL8KCOti8vdOI3LH7rwEd8o6i9tmeXMsLGA8OCD?=
 =?us-ascii?Q?1lHxj9gQ+s3w5nW+EEegqY6JGPgrW1923KiPhJUU1SQxqvXxHcGD6c9c4WTi?=
 =?us-ascii?Q?0iE+cksFHyGHFbdRH1wJhLkGPJvN4zld7k3leqoTl/eBM8BCeaiJnKXawJDE?=
 =?us-ascii?Q?Xcr/t9egXwUOuleb6w+BtJ1KL15JwKVKyp8RPDd+TeemIeyLjIHhdeqwETn3?=
 =?us-ascii?Q?1ORvSNGDc6eMeW15+2Ws0Jd0mGA/8QlP4DapOIdGRqb2GGHlE4G9qgozKd4o?=
 =?us-ascii?Q?ADHt31RA7Itk1eFfG2HOpvueQwBRKANzwCQRtcztrMSw5+1pxj/EZ3m7OZhU?=
 =?us-ascii?Q?D3d+TrmUZ6rejw5ZjKhL8Il5/5onrwCIskA17GO11ZeOF4iqdCqGUkm6gbP/?=
 =?us-ascii?Q?y2tonMjGUokdrZr45lC0OAZMqoyWL+m8Mg4co5D+A2FBGClJZ+jVzrIXY6m1?=
 =?us-ascii?Q?1s/hWf7RdauODu38j7O7v/vFaPlblT6H8pXzysK7FXQl+eOd/jj1FGrZrUAh?=
 =?us-ascii?Q?BHmkZAsvMzaDIO6hrNJYC0I2zl4xcVcclF6xT95BjYa36tKLixX5w8A+PyNy?=
 =?us-ascii?Q?fO9OXtLSjQBQfeYv3fLPrhHkJKwccV1uiVcs3nej4AmSWWsAilneoz/bqFyy?=
 =?us-ascii?Q?gsPqLhbYrTbnedShxECl91h/v2ACn8tOsIFwawsZ4/CfuYOTVd4b/LrWQszo?=
 =?us-ascii?Q?bDw3OHexTLxAmr3Qj0QafS3j5eY6jE8NDbJK99BLPYosC4MBRcHy8xSNoLpk?=
 =?us-ascii?Q?5LRD+2k6BQzQKOMO6gLq0dFYdJjue+6pOU80Cnmic4hJREYC7O0llKZGjUTy?=
 =?us-ascii?Q?mx+3ONoNZKTdI6OvcVdMPRt0Xkf35l0lL+xpQqBF0hG/I6HxQ9N5gznP3aQ2?=
 =?us-ascii?Q?ftlLnLqeIPyYZxhejb1UTedjbjU1qj29VQdylR09wuss44UK6c6YzBRAX6lU?=
 =?us-ascii?Q?l+Z8RYZnucmCcpyk4qbYM/lM9cQcIz2fG23xtdoK4FPHpZ1q/R9zCcFdT5zB?=
 =?us-ascii?Q?gckOoXyruDf4yWChKvZ3rFeKhJJQf66eAx3m5n9gCymu2/moafoRT02u3/Ki?=
 =?us-ascii?Q?k77moGq7z4cGwu5gXBgEDwQKRWaj9P2GpNYOWRGKbi9V8SAp9QxZ/GXfGYo+?=
 =?us-ascii?Q?i/VSs8X+/8mNcw+oa+BkhKKSwDe/es/KS/pExVFv0VXSKgfqE2ye/LJTtCk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b7759d-4d1a-4de6-ce83-08dbc8baa1ab
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:26:51.4101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB6129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible strings for the SOPHGO Huashan Pi board which
uses the SOPHGO CV1812H SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://en.sophgo.com/product/introduce/huashan.html
Link: https://en.sophgo.com/product/introduce/cv181xH.html
Acked-by: Chen Wang <unicorn_wang@outlook.com>
---
 Documentation/devicetree/bindings/riscv/sophgo.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
index 86748c5390be..9bc813dad098 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
@@ -22,6 +22,10 @@ properties:
           - enum:
               - milkv,duo
           - const: sophgo,cv1800b
+      - items:
+          - enum:
+              - sophgo,huashan-pi
+          - const: sophgo,cv1812h
       - items:
           - enum:
               - milkv,pioneer
--
2.42.0

