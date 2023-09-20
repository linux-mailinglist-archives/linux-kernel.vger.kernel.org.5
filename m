Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780437A76DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjITJIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjITJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:08:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2088.outbound.protection.outlook.com [40.92.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E789E;
        Wed, 20 Sep 2023 02:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLdflFnR+HPuoBI2nCvJ7yB2qrBpdolWECdNw7Omay0+JDj66ilP/wRbgKGPNP4VbjBFO1Q0hREIAKEFC/rK3bS03PDzvhP3puGeV00+kfJpyCVK+GIbZ5ZEathtnH4+BgbUVy8ZhGyamvrFJX8r7ctmcOHxpCeqtOWPUeTTWSqwgBJBgeYxf82DjEPSZvBh2sKsmPOANTAXh9LmPlJ6IpIt5aDj38V9l2HCRzAu7R+IAnqrMSvs8C96dblHzQLISkkxgoHBFQ2qU8X0n1evJj6Gdkout1DWpGE3rIP5+fqcX3y9L9xUFRy+vtR6Qbh/yV1MY8vYmy/Gl32dJ40pzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2004DzGeC6coQZs3AHp6ktsDp/xDwNg1yLk1bVQjHc=;
 b=J5THhALUK+3hBuAVeyGwY5Eiws8kGLBnGj899aezYhnYJlnqw6S0fMLnIJJEbAPcl+zOKEsOnTDTbnJoXpzuO2a5vf2orIy1vo+2uvtG3zas/Tw7bMofe+aYLQGIrfZL/DP7V8ESbAU2MKIgXQV5OLMyfzXCzLaonFAekHCxWsMlcWNtTZVZomsemNqqHV4c5G/7nqZQHewKqqbdUmj343csDYW2iyGXvGy/xT/Z8/dUBBfTiQE4FG2aokdlRbgOKznuxgNJN41MFODpAMgwLgMHCJ48YtctHEfsrkpenOwGOac/E+Ivplr6Dvb6ezXhxmLc3GCAMMrqxJuhSyHfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2004DzGeC6coQZs3AHp6ktsDp/xDwNg1yLk1bVQjHc=;
 b=cU3VD3KRgbVFaClwgkNZ6m+BuIusaZN79NpOktKajMMaDGKy1jVoeH/hFFtYHDK2tAjCeJSmw5YGyGOR2n+J0pA5w2+mIUik278gz0hdIHEFHLQ/GTb6+j3qJ4IEwHG2pS2Lqnk5WsVLkVR4KOMCGy0kmMq0rx3lXc2wIrGi9d84JAl4beQ8i/rgPw+3Q6UR5ZRRbA49Riz+Zifx6RmENZgkKivXQDCINNRxucQ6PkxQWwM6PeOlnDkxqmskH8roP14vX0mfKSwzG5RGS4EIDoI6UEviUDoorYuNQqpm8V6s7lD16Xzdt32c8Xibs0XwBjSW3N2WjiPv1Gbz1RPHlw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB4569.namprd20.prod.outlook.com (2603:10b6:208:370::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 09:08:44 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 09:08:44 +0000
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
Date:   Wed, 20 Sep 2023 17:08:41 +0800
Message-ID: <IA1PR20MB4953F5FB42B8CAE4BEAC924CBBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920-recount-chili-f80d5dc125e8@wendy>
References: <20230920-recount-chili-f80d5dc125e8@wendy>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [6Q2zstPR51trXKoDeA1bqLlhs5D990e5INgqLupg+as=]
X-ClientProxiedBy: TYCPR01CA0103.jpnprd01.prod.outlook.com
 (2603:1096:405:4::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230920090841.143561-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: f51d9027-db6d-4f0a-a739-08dbb9b930e9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yhcb6RxKGB3nOhZH6MnC8Ji6TxBs/E/vArEtdK60Y4WnnENKfXgeiefJBsFsRiDOXzlUF41kOj/tteZex2qcWuU8ufSbO36zUTLvxMBtPbG0HTEVUjM9ZjQgvXazkKmi1W5EyAC2ZPCfsCdl9mCCTpV7FjMgAWuucopk/jWUfMORVQ79dIJphSLYg476UpsaJ6cvTsQ8IlQzsVy2GKYNti8Hb1BsHi0nJ3NAheOkk2Sou5xQYxaV+XmNvpZe4dqMX0bs9uScHDzYV+Tmi+eI7Ajh3QaKJCanQWL0M/P0S5tcUkDnoFZwmsJlHYM4d+xPVybaepUo8iaa579rw/LzepApTcHm/kbUYmeZK+LVeu3/pTRxVBz7KE4OoqLoQkJwqzwh6VdFkty8Fzm6hDynmtdOKZxe16bWDVSCHbF1YkfKTXfAhCMSMyjz2aMGMmSd6coSZA6tXnz0rTWkxYsrOMxLrxIpZmBTEcPvcFVPkfIQFEh3rD2MiN0YeDsPKcgJWwlwgUsyak9r5ruCtcXarp+bouDpGR/7BLfVgC4bztZUFxReEW23YwESSO7g1HheB48XXxgMQSWTI5DoXd3YHa6Y15kilgA7TSyB0QXrvqG4U6gbrQxbY2dAxjm1dkj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oz/xRaV5x3cRVUMBsUb6edIWVN9cqvsncslYM0ttP2XWVdjS4f3T6kmwFpAj?=
 =?us-ascii?Q?sofRhxWKeGeoNwf+82HyX2sePIu8IwIuaGRF4NY17wuqqcVGyO7DVOdPzQ1B?=
 =?us-ascii?Q?d8ErIV/1ert8GfKzT89OyZUo9Qvws3Llf40v4veJwTcmwlrR6RAqnymaZ+13?=
 =?us-ascii?Q?Jic+MyHgkOu4vhrdvj/khLR0HI8AwjW+3PzHPOXgu3FIJl909ikDxqYhsTyT?=
 =?us-ascii?Q?SSx8DWQqWtdRU12VFiUDThnuO7vPk7o8ELyMQByo1585LVeBV/52VS+EcGK7?=
 =?us-ascii?Q?KikBeuTmpTAmrqlka+SastOqWi7FjO3OpbrE0MEvImCs9aVpEBXBnyL2/kip?=
 =?us-ascii?Q?5TFRLU4s74cfObXe17rqU/t8sDEaOJUXcl4mwuQk0BCb5SO6QoyOElEyXsQ6?=
 =?us-ascii?Q?o80ALpcG4pxLqqpXKsPkcOgHS7x2+OUbqVSUL+GUWxaTHONG+tF91WRCYeUe?=
 =?us-ascii?Q?PxwYBcipxTuj2EBNlFHVvWxa/2Fmqac04qLg1P0F7QNnI3xEJwAohTeikejO?=
 =?us-ascii?Q?sUBK53GWOblrh12ezTsEoEbpDO0bxta49nfbfh5+1f7QoStxhLZ2gKFh1axb?=
 =?us-ascii?Q?RMxPPIT7DuzIX4mo9v9tDR5nJDRGh3J/dwOcM6PcIZ3MPUNg921cQYTTKLZI?=
 =?us-ascii?Q?srx25C67L1S++SQyUffQ1c+D0YrkGbBaInb203WJ2rQbezPHvtNOGBdTv7IX?=
 =?us-ascii?Q?CdImhKm7ZNJwFeydk/8NRrN4eteE7UIPhnx5Xbb7QUJYielJyCB29p+ngu3m?=
 =?us-ascii?Q?7nmqwFlkzDD9hZP8MpoFWG39wMHoTsWoxIXyqj6LjVbB7zdZsY0nWqNqDd4x?=
 =?us-ascii?Q?vl7r3yNHse+Sxm29qUS3iXU8muOiSsrDj4VJ8op4urlf5Ih/4IHhlTwS2RLM?=
 =?us-ascii?Q?20eqMwQaBQQRLsQEHwJuMZS/ie0C5NQXW+GYhxQVfY9vdRVnwe9aezPSzXFf?=
 =?us-ascii?Q?3XSZ8mmS0ncA0VhXr6pmhDDDv5p9EXSKqLU1jc8noS0IK1cRJUKu34syRwSb?=
 =?us-ascii?Q?O1yHWwve+dCuGkSMpztqIA45Xqv/seraLV1XYEgAvZdxuy49iofBd8D9+nQ/?=
 =?us-ascii?Q?aYklf4A2Jy0jF+wNEg8D6S+F+30Bjw+lnQp3ZYTjW+WPpbGjfq2hzcnqPNhI?=
 =?us-ascii?Q?pUtGa+gXxxghrggUtwieN3H6X9eNxscZ2vguYFohaaaE8YhOK3yPrHli+vGW?=
 =?us-ascii?Q?0NmgbddKph4nPWJUC3Lo0RHBKmPzC2LeAZkqGHIkkU0HoZpqwCJHDfHhdtk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51d9027-db6d-4f0a-a739-08dbb9b930e9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 09:08:44.5934
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

Sorry for late reply and wrong message-id.

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
