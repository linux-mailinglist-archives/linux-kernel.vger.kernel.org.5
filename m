Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF907EF2A3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjKQMaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQMaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:30:04 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2074.outbound.protection.outlook.com [40.92.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80493120;
        Fri, 17 Nov 2023 04:29:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co06BH6iWnHGnXdQ1QwJaoWseLKjgW9D50eQNGLy8USf2Cfkhdd/GgZjTbbTVgKo19oSClSnTd7rlmNzArUpKb/vlhtRbUER87NGF8gYk31gYSuGXqvXcsIUAs2w5qe1859HnHWGdlwPXidzTGRIDUOBALDD3DX0kSrOOMzhAaiV67BxkGSBr9PbMZzg1k1lj+fe6E2Axs6gLytV6rG6qZpVbPw4YN0lhVZPQ138ezczbU2SpCCcY+tBrc97IlY5ALM0YHFL7eFpcVXzWW2LkyEdPWiMe+a44/Nr1AoSLuPsoS89wQuT4KBV4Ta9TGEMMGAcpIvSm8WpHganECjmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgb9MnYg92WAdlAIt0V37YY42Eq44e6tJfsI1M9LBjo=;
 b=RWImgo39Yfk+kItCVINP9OaPeDNAyCtO/DrCJ44Smo6uEe9GepRQmz1wkVwesnuntuY7rqGzTcHgn2POh4ulsGR9Hwkp6QiuTfTpvHI09i4Vjb9uGbJ2clq4hefxCMBAxp6xsZUJg9od7wRaJpjbE8i7WGhjbK8x5JQoxAeLMR+vyhyKS8MPvOvblXuse8Z/BB/YNW8adsfgmwdG2nKxSsYDZVrEdlBxom7s2K/KKRr1nLGy+EPcujDhGxihmdV4ddzOxTXziaS+cG1q80Iyo2mH3l+XtXFUzRHUyQR7kwlsJXiyNiJgQICunezJ55DTvK1sagq0Bc4crrbGV3h4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgb9MnYg92WAdlAIt0V37YY42Eq44e6tJfsI1M9LBjo=;
 b=sixIIizjopSG8PSc7hB+IBgmBYO2avSV4Ka60mS8d2Ia1kaqYNT/7gdl8DjIrwcEe8LwamX4kbHelZSEpmzwReVKm4I59G/2e+BwFIcVY/fXN+WZMbRxm/aD6UfR1M3Tr+wakf5yusa7F4kxJIUpML92axFjOjSmorlNl2jb1FRf8atw1hiNVsp7juVWCxmu7YgB2r2hydKwgWjhynkXZFDRCRZeUBGSsIJlBBWlXEYKVsgqb24I0pdemUz7cHjRukqY10OcaLEB0sgm893mk6zxX9AjrHkxV8MasbSlw2uBFHls7gW4dSzq6kSyxI3FXHSF4UD1rOl5MDcO0Vq3mA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB6063.namprd20.prod.outlook.com (2603:10b6:510:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Fri, 17 Nov
 2023 12:29:56 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6977.029; Fri, 17 Nov 2023
 12:29:55 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
Date:   Fri, 17 Nov 2023 20:30:21 +0800
Message-ID: <IA1PR20MB49532AF0A7C6DA5A2184B250BBB7A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <184ab92d-9246-43e4-a40d-465d51208585@linaro.org>
References: <184ab92d-9246-43e4-a40d-465d51208585@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [pwcW6CZLAbcI8+ZBEEC3mAoNSh9lqSZdv9M7ksQBUu0=]
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231117123021.1056247-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab8e22e-bd7b-440e-1ee4-08dbe768e7a4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /or+8REnQI9qFdZgPceGkgqMlParxX3Quov2bcgg7wE1YQMOzxNm09gfIXHgUDj55ECPOGLyIFmKae6JyR5JS5UW4sL6Mlao5kPEehf6v5usMUyiQbl1ydh6fsnJZkqieqmgNze/fdiwOGStZ58UowFdWgQY9Bf0uPFRnvY2Ed0aCWJXNWbkwvHkLZSzCAb63IXvGTlc22lOxJYDOk8X/TY3MWw63pBQOrviUi+2PUb7PyLvPOo/OROyA46HB6PTbBj+sJ7dKzdSaDCg6ERaPrDxk+AR7CGYHEMAl23raCKsZowehn0HqHYAw9NcLrM7EuquEziAxInbr0IQgtpGfgB78yvFy3R9EwMZmxge7sDjlwPc0wqaGLw3yPoVF+Cf067AOix5hTnUhA29CgrbRNklS1Wc/5/sLgogot+eo1Dun0VofREaTalKwSa+1GljCI6enM/Q9I21aZbPkb4mSyilkGYuTdc+MNkgDUyuSo3F29SoN/wMpH/m8yVwB3V2uRozvxcRlcQd71cR+vL1emDDha2Wes6c55SIYnoPoH1piGKwmYopZEeJlDKg8bc+lcR07+9keGCA+GWYPpwnvT/wsdk9Zw9pgUjUKcqfratP4H0MX1u7mvVKfw8hkdxB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WMY1a7w0QEIBrHzCuBSq13Pu4H6884TwIkghQT6znC6eFe+AUtPnztyobMSw?=
 =?us-ascii?Q?w0mMFowhvKzPN8MWsVjan5EPp4bFvpu65iXFeDKh6D1OHtrxwQvGqKNcSHAJ?=
 =?us-ascii?Q?xBryoxwL5JRvwepg071K6JLShaCTaH2Y6kSZycjsx+nIr4dPhEqy7RWm4o9d?=
 =?us-ascii?Q?fpK8cgiO5n9IFSGi/5+Vo5h2rrIHWgg5rTdxfeajfwPMoMNYI6bvMaE9fM49?=
 =?us-ascii?Q?6bG2NdxTqxdHIxvMrkwBMKRmzfvOn+w5XPsHCPDXP4r+dBNlySUDtOXlJoQM?=
 =?us-ascii?Q?5vHGa/JrzGjri9u9fk6WTG1Kv9s53BOLwwSI+rq/rf4YXu0P+zgubO02hqtA?=
 =?us-ascii?Q?9MME9O+iW6reImU6cuDlu1fguuSiYZbSdo0UvRM6vIh3/esAgtTXU1CJYD0R?=
 =?us-ascii?Q?jyEou92vCBrKe5m+hoMqwFXgbmF8dkl7RZFTnwtInS/pavIrfjF7NvHN/AUS?=
 =?us-ascii?Q?A1cHhfQbegLAPlzXPJwnE5QiZdCxrZjpNE98/zv7heQTYe8lme7ns/uyt9s0?=
 =?us-ascii?Q?xP3kWyoTnU5g4EcrbUE0dZayDnNCYsaozUhbGTjYtcyRY55VT64+h5hQ1ipQ?=
 =?us-ascii?Q?hzAqlqkBii3KErEI+ksp9iqOKcTDG09jCOGrdF78Mna27kdTPEuAdh8y2B9Z?=
 =?us-ascii?Q?1c2Kha3Yudbrt9IThXDwozUKxZV82ceoENX7zyujF8CDAiMEGcDcTToN09Z4?=
 =?us-ascii?Q?bwbASuNb2udlcwOU3MS93bpLlURhufCblq3/HWW1Q68/2muiI38x4a6tBDdC?=
 =?us-ascii?Q?r7+InrHOAWwo63+1qEH4X+1dshoUbf5VbcgR8uAgo2sQYxCH+4DbNoW20vkc?=
 =?us-ascii?Q?+jt6Fc4TM1Ut5XqRs4pUwAVpbd/0rf/ZKdGW+8Z2j7EI0pNnwk8xNewn/Kok?=
 =?us-ascii?Q?aiDplUKpabnA5pirmc7+fXvhOlh7i6Ocn1s5dPalPS9k/kIPacbDrViJWbb+?=
 =?us-ascii?Q?bnoprCIlUggSKgE/ZYCVKIZtPDIcHUHQ9f81ZtniBWsB2I3LddKpxIidL8B9?=
 =?us-ascii?Q?wDgnwweZLugoxLsWRrw4LuFljgw9LTKXft+7mv9ObD79cvWIQOKiulrBfodA?=
 =?us-ascii?Q?ZWE62GK+d0+MBpl7INcKy+eqDNt+9L4ikjrXD9N5bMNooItwX+9nlGvrtqub?=
 =?us-ascii?Q?bpKQW9yoQlzK8rCSV5zj0wuD/qucXdiZvOzKTL8zKSgl4VXb40gWE0472zvL?=
 =?us-ascii?Q?Iiv60TziqxuLfVWS6Ct5boY+tJRCBi/QpFquT8OYYq5TA/n8NE7zoMhQ0FE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab8e22e-bd7b-440e-1ee4-08dbe768e7a4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 12:29:55.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB6063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On 17/11/2023 06:07, Inochi Amaoto wrote:
>> The timer registers of aclint don't follow the clint layout and can
>> be mapped on any different offset. As sg2042 uses separated timer
>> and mswi for its clint, it should follow the aclint spec and have
>> separated registers.
>>
>> The previous patch introduced a new type of T-HEAD aclint timer which
>> has clint timer layout. Although it has the clint timer layout, it
>> should follow the aclint spec and uses the separated mtime and mtimecmp
>> regs. So a ABI change is needed to make the timer fit the aclint spec.
>>
>> To make T-HEAD aclint timer more closer to the aclint spec, use
>> regs-names to represent the mtimecmp register, which can avoid hack
>> for unsupport mtime register of T-HEAD aclint timer.
>>
>
>I don't understand this reasoning. You had one entry, you still have one
>entry. Adding reg-names (not regs-names) does not change it.
>

If no "reg-names", all the register of ACLINT should be defined. However,
T-HEAD aclint timer of sg2042 only supports mtimecmp register. If no extra
prompt is provided for the SBI, it will fail to recognize aclint timer
registers when parsing the aclint node with one reg entry.

There is another way to avoid this by using an empty entry to identify
unsupported mtime, but Conor have already rejected this. See [1].

Link: https://lore.kernel.org/all/20231114-skedaddle-precinct-66c8897227bb@squawk/ [1]
