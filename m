Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6243E7CDBF8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjJRMhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjJRMhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:37:46 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2036.outbound.protection.outlook.com [40.92.46.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A081310E;
        Wed, 18 Oct 2023 05:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMgN4LkNnvpQT9hxxWeWZymNrFyS4rAsdsee2eOxW0AuxmpfrqFcskMab/+J4UURRKBuYi3x6dKinQBePIVW2YeWNNwBCItrdZIQ+jGjNnj1sLoiuVZDqbqJ8W0/yXnryDAn8F3s6kr/Rue3hUrFgHDUNR/XyBUT9MUFp/b/lyvaCcV/ZiHWJHsM6khJtlACGea1dEH+bcGErvtekv10uEbQW3n7busTPy8BR5JE8Jo5KTgdLe7C/nB0P9J23lUHYBaHq98IFI5Z05PqaSYqNQikcHjaVgIxG7QuxK9OLODFDnZpbA0Ydth/2Nrwv+9eyAQdgKShWgoyQbt+4zZb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hr28upwkPn4oJyaNFmtTw6AwNt8aFNTRILMM4isSNuU=;
 b=kuCwtsynjBQgO3mYaU7olvJizhq9YAoFIRt3VjOLB3gDRiOZE37y3MSVLva98AQ3TNbiiH6USAirMYjlN6rj2Nan5E3wC/zx+YuVWppDQVElt9X5Tcg0CChEUu2UrhspwyaWe3LSN4V2ZeMX4b3JdV6Zz1Yx7QVe2X3BIZcpjO/RgJGEQfGUV0OG/bBbyCcGgxUvnvdCLbeAlEwu3552fy7HUdNt2Gs7ZQOeaw3BHA7fuPqn6aDYQy38C/0mWcrVpncIswicyRkcWk0OrKKrYOFN/Us6QuLUaaKRcFZs5PLvNYOiipHSswD7wdjLiA8NUr06wzF5s+aCgCjqU0Ga1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr28upwkPn4oJyaNFmtTw6AwNt8aFNTRILMM4isSNuU=;
 b=TISroFgOzblwdGQ6r3e661giPKB4/OrsXPyrrpbvIS7jQ8p9UBNNxpPpMQgr5LH11tnOzQbzWRPHSI3gIfD33+K1EhByetmR0T30COIXIf6Hc00Cu4Y9345wcMT+RsPgC6CZEpJtyhgDbzzBc/eDzEJ52bmG5buAZHI7BWDoxEyaI6E6nQXXDTQGYHYBFSsmw1ooUmPxVQAHoFXHcdxnDWWDR42s4Fgs1iCgjv+X4Ja6/tDTYeAt8Pr8KLrvS0+2vWtMImNt/JJpVJAhsBB3LCpmWEDm8xrnF1IzOJ7tjGfiRKYqPTngVxBoYyuXlW3KtfXhnqVHbx3/C5T+g/WWFQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6049.namprd20.prod.outlook.com (2603:10b6:806:33d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 18 Oct
 2023 12:37:39 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 12:37:39 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] riscv: dts: sophgo: Rename cv1800b device tree file
Date:   Wed, 18 Oct 2023 20:37:59 +0800
Message-ID: <IA1PR20MB49530B8580E22AE664B8D59FBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <4d98aa3b-003b-45e8-9a85-db07af73aa8a@linaro.org>
References: <4d98aa3b-003b-45e8-9a85-db07af73aa8a@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ifCJSrGIM896K1uM6O8wjHxgtiRJSugNdnS72cuVje8=]
X-ClientProxiedBy: SJ0PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:332::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231018123800.1630336-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b19ba9-04ab-4492-f5fb-08dbcfd703c0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDGfxsNKFsblgjQB5P1PVMLPwcQE0FMuuJHVzykrLd+Mlw9OSV1ykCrheyjOMHPz2T0j2FtuYVHr+hXySANYjd2Lh30CIjqZFy5HNxnQ+JTsetSAyzQsGL/mk3U+BYVAUG/RewG3MPxZk4TgSEqgbhKHsX1iQLjnQikKHi//qUtl9F9fNOxM3NQpzihyCmgItHEYdbZY8Q53M5l4ygfuyPPuxY/4anw2nYxBexm+U+BmxdajJvvOWV7ZW2YuE3/BP4+GLCPjy4hS8vbtb7gwYMa8sY/fKfha9isYYaIfFnTE2qns35s/r/KZxS6KGbYRuu6a/iRop2fRP9kqrey/IW2dsJ1FRCMCHRPWe9ZH2fZAQ3wdEjdHOFtgxoMlmSCopWBb4EBsMPk5IlFQPl43JETvAoNcBpMUPQ+X9Qm946l8cmvwKZ/pJKLo8y0sAHjfhlOI7WSK1cYe1g5xxgZsQK+3hi/Ecq9l8f3A7m83t71E4wAaTJBeLW3xgIm7mxajoXNQUPnnLku3i1ZyyC5huykcl3ErB3VyzBHIWtpKglKS9ptB8rE4dqb37zJDRs+WbNTN5Rep/Prf5247k0SwUr7K0ajpf1Owx69jCQyo3RL86zXOwQrCDAEcGs99a5Uu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7soomxCZwOpNEPlVGdvhVbd8mydGAcxUZb2VY+OLDYGmhfAvMySuYnXyCQYU?=
 =?us-ascii?Q?eU3/JRw+KMYop3hu9FFzoTUSoM2fmJvkorCYGeWlGVTT22luCpq6BwXqwA6m?=
 =?us-ascii?Q?YARCsK9V6hPg8+MPeHTm0OSBAzSFXsvVRB7zygsc8DX2R9qZcvxcyu0iHp5f?=
 =?us-ascii?Q?muDyu8FHtvk+ryLpV8dNjwv++3X4lZebAG6hJtusSGMdWS06abmjNbIRXQxR?=
 =?us-ascii?Q?Q4T8BNHDY9eDMvKir9GUgNJJtn1yE+/wgZeQk/egbKkA8HSIGE5tyFSqQQGj?=
 =?us-ascii?Q?2mTuYthtCxQX286e5W1Hi6vXNSdisfGeDGbBdemD1JpmloikzVa5N0+oEcff?=
 =?us-ascii?Q?2M4KurgPnx2OJIi4/4uWq5cWoU4bmnJACjwaUdBChEgAEHfFWH3guXEFI5FQ?=
 =?us-ascii?Q?EDCp9IzGMik7J1I3XpFTdkM464NRUti/rt198TF5j/TUGfYy5gFYyv87vCWQ?=
 =?us-ascii?Q?AeYTS+mXIebcf1oSDnyekK+qHN3s26zl0hJUVeUnxvRX8TRw4Rh8fIKb2waT?=
 =?us-ascii?Q?xRdEmJgBXn3KbyC4Ieq8JJzHdvVbpUOPFabaU8nn6Bwhhkt1Is2tw+yC+JKW?=
 =?us-ascii?Q?Y1NYI5igUInj++KEAkj/S3a4HvK+dLRe2XxaXamlsvHm/7Fkvfz8wRLZtYWr?=
 =?us-ascii?Q?Lnu7O6yr4O5VBqjHh4ONdUeWSEOA1lQzxxwEe5TKpBRik2uDKS5wFDjhb2Ib?=
 =?us-ascii?Q?rMdQY40blrI/ojl8TJ0fIhqkhhdnrm0mtsxU226zExjT3PO7KkJlX3dJq9H9?=
 =?us-ascii?Q?hNVaxj2KWG8Gn56VYjSSEs8fXtiGdwCHI/U5nKuo7GlRcxZuNatKLb1bjRP1?=
 =?us-ascii?Q?kPu+2L+pn2nX3yWGKAJGwmv/dYvrOBWSAr3x5wQtzthRB0UlebNrmSydcyL2?=
 =?us-ascii?Q?aVC+X/HncdzBg1lcl9LlKs2ctAbU5BlvfDZyydgbs7MryRKYGCCxhCzKOJe3?=
 =?us-ascii?Q?qppUxUFMAy3MXKuFCm7K4nQA5dLfko3xxE+FDX0HXl8lFNgeNlMaks4NiReE?=
 =?us-ascii?Q?kh/W+sA9HepkY9vl4dJykKSeM9PfHrSL9QetZB4x4Q5Of7TFi/PJffyftOmy?=
 =?us-ascii?Q?J07DJ74J5SBVb4JlpgwfHHIQrAaKCgijs7+Ol/StHTsHRa/xSc8OQbCUT0QZ?=
 =?us-ascii?Q?giv/gApHN9D64uiSWl1s/ny2vSGPeLsD14iID/adb9uWE2/YhrqbvoItVRCL?=
 =?us-ascii?Q?wXf6nrpfqGdny4DmkGMdJpuBL0gDz0eky/1Wa1V4uahL/Ei/krly/zKR8Wo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b19ba9-04ab-4492-f5fb-08dbcfd703c0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:37:39.5039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 18/10/2023 13:31, Inochi Amaoto wrote:
>> As CV180x and CV181x have the identical layouts, it is OK to use the
>> cv1800b basic device tree for the whole series.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> ---
>>  arch/riscv/boot/dts/sophgo/{cv1800b.dtsi => cv18xx.dtsi} | 0
>>  1 file changed, 0 insertions(+), 0 deletions(-)
>>  rename arch/riscv/boot/dts/sophgo/{cv1800b.dtsi => cv18xx.dtsi} (100%)
>>
>
>If nothing breaks by this commit, means the file is not used, so how did
>it end up in the kernel?
>

This commit breaks the including file cv1800b-milkv-duo.dts, which is
fixed in the next patch. For cv1800b, it only needs to set compatible
strings. The cv1800b and cv1812h have identical layout.

I use this commit to avoid wired output provided by git and make the
change more clear.

>
>Best regards,
>Krzysztof
>
>
