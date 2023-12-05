Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE0E805176
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345044AbjLELCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjLELC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:02:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2076.outbound.protection.outlook.com [40.92.41.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FD810F;
        Tue,  5 Dec 2023 03:02:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVSq+Z3KdiVhbS7YddLG5kvDbx3EkK+ihGV176BYN8p8Dlau1zio74iPanGOGfJPl7e+NreBAFieWr7nlmwV54C9GtOLuLrSKEtBiDfqbjf5RR7FDUiXxbqIkrMQ6QktRPCtyOkbsk7qPqJ4WUpolJ9MJTU5pilRzdssuuGnqTvsr/887ala7YDtGmTmtf2r0UioexjRRJDlwUmAxeypWqgPWrZvVhKDh+O03uLpFN6x3Sq7UfSgAGONL+TLkgfPimZTJI1LHquzz5zxBz8chXr0kHioPPtUcq4NBGSk8MXwAv+0nceBzIGj0eu8JZ9pNJ3WFSzMuEuQZ6x3JzvIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWTBreLWmrV4RdzBxhHiuBz+w0l7oGr5dRypcKGvWbE=;
 b=VQzmS6wpoX/UQcjmqxTEBdvnVUq/IA4Kkb5RJKpUxhkjy2N0NTRBeUBEnpubkOjRuhv3bRTZQPaECBLanpcLlPwMEDP17kDLn8r9UvNUYUki1Ss90htjx/4jnsEvkP7LuOr6aJTxAZL0g/vqMMvMyFtMKNqumCSf1LQwljaW0jfUCOmMejfPUBJbR0pp/FHDZMV9u/0McGz2RYX1L4IUSDGFgagsa4mD80y7dlcr+TkEaJuHC1hXakwgs030YGzM2ZNHI3J6f+qkjCFOs0vbOrWUgPSHmK5aXY19aALXkR2wqN77kvl/uv8eGGQ/BaTUjzlzvnnV4GmzVV3uDUXRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWTBreLWmrV4RdzBxhHiuBz+w0l7oGr5dRypcKGvWbE=;
 b=nF4nEzBjQeOARUVKctxkCEbZwiF8Zpu/e9crt/hXdmwqKQMN9pYYAD34NN3md5rQhQijbA+YUGNGqYgTDZJ3T3cxg+PRQNQDh8txyJ1NcJbOHc18wJ6QQTgIaDO3C+aFMqhLSVeXc5N0e7+ri1shbD6mLDkfAqPpISgoFXZs29AppP7V7SnlxgMRAmrxQLc7Xgg99CLcZHnODozuECtcRYj0eBYDAAi9qgPwe3Wv6S5VfBmXKql3/Eqbci1ETZH/rkR9XqTfYo1YZoCmh5NuY4Q2iz1e3f91Sq2ackKg0q8dPt4hoAZfmC+iIxoOH+qLSax0gskZ+TPg6I5QsZN4+w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5141.namprd20.prod.outlook.com (2603:10b6:510:1b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:02:31 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Tue, 5 Dec 2023
 11:02:31 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/4] riscv: sophgo: add clock support for Sophgo CV1800 SoCs
Date:   Tue,  5 Dec 2023 19:02:34 +0800
Message-ID: <IA1PR20MB4953948963D792F889396B37BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB495382B725AFF6FC2C336BA6BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495382B725AFF6FC2C336BA6BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [uVoNrPE5tZ0jk6ozmFW057+LfJlJM0kktZAx7ChtA7E=]
X-ClientProxiedBy: TY2PR06CA0041.apcprd06.prod.outlook.com
 (2603:1096:404:2e::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231205110234.979342-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe25801-f749-4eb7-4c6a-08dbf581ad12
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olpotJh3jDkMYaAxsPX4UnKjpxrRq8NWr2cWeGscBkJOI/1cgHlqLgZYb8dsZclfDnejwE5tjnBztHei1zHDqFFoXwOoFGHNKBEzBfsY932QgT2rlc76OC/G8zrOBOZuQhTlLuVx49uJieb4RMLKtmTObTCni4b6Nb8qTZnJcDE+4ekNMsbwOuSlhLrJ3HgZ+hOP+zULZHRtC3QbTNKG94S8UZaLxEeAqYNE9i5QmLEnr9l/TAfGVW8ySiuD1ZpdketCWZYsMEa9g7RwLuvLSIz5Omi2752URWVWY5GCIzLjhJ3mEf4XISw1dklEY23v2NNO9kAD9dq4gdP+ePO3DY4Oh8lk6E7BmbgxciXyiOMiVBKOD72hO7lSsjCK3sED5B5/iCTsQDBZ+mIYrpcIE4ziCsnwj4MRgRr6xKUfu34h8MVv6f8OvDhYZiXIKzUMd/Pg+A1zw2HzRqIwaKtQycaoQwAsX0Vqs9JiyOhublOqYJQ79PgjUmi7497MaQgrlSisSBXt1B8DqbPCqxgismY0QvJXkYIg9ggt5fHJFIvrwVYXneMP8NVj2K/It/jn/ZfpBnlPeokXR5ZhWvGhIkjZNv3WDoRh4uCnNuvhE2JLBm+NBoPTcMfBfiY4Ki6n
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d8cc0buXfkcWWyoRGODh6jRvLxEm8OBpSCA3bFaRMV07P9qwsbSoNmyl0uzY?=
 =?us-ascii?Q?H7rmxW1tWxVQib2TlJZ2apSq3CA/PLihbX0irNvt4NorRpsYmIifFr+siSae?=
 =?us-ascii?Q?N4UB1ANthtTdi1axooCi+7UMiyq5r24uIc/cKOhFnyinWH6ZoscWzl2Cmj2e?=
 =?us-ascii?Q?Wp9ywVF/LSz4M3R6Ok+w5h3Mr1BaO+9O6bRSMPfcI6qyr19quytOD6u9aAsO?=
 =?us-ascii?Q?zE6COWoDwPhRY2s+5R0VJ6fnU2K7+ZqCAn0HKALw7YCQyUYF1MYa+EerTb9A?=
 =?us-ascii?Q?N5oI7nxsvRXDMi7mwWA4AV/WC6xXeigcIDh4oxWBiFHfDDY6bf5VjwHQfWEc?=
 =?us-ascii?Q?7iitKWX8QjTOyUn8FmH/15CjBbJx9kg0n01cSlwhJqf7OrV2hv01SkZLmorP?=
 =?us-ascii?Q?SvjDLdo6XQqHCJdpm7yHf7yhPnqCTwitju1ny71CnZ5kxsUIUfXwUjhcV3FR?=
 =?us-ascii?Q?3MqM1oZ/9KOsKhw6zrS2SB219T1STK6k/Ig7dSvuqg5OT8NLXhbaef+1wsXw?=
 =?us-ascii?Q?r9kyigYR6MnTh6kZvEmlyeZ4r9aTdSgh+swgqUzeWEdUg1AsTWzNWZ7/hg8I?=
 =?us-ascii?Q?AZ+U1iiRUguPDZwn5KxHiICE251rw80zW3jX3E5JReM/+blxPOAVpQis4Lle?=
 =?us-ascii?Q?jDoZuQ48BG1F7zjZZ+dX9nHvvZO1p6MlBcQ/l11cu7o91WH8eK+46qYpax6A?=
 =?us-ascii?Q?Q6Vyorb0yepPlwOep84pl/jeF+jfW0Ue+qhzhdAAN3t9hiXvm4ViXD3Bw6Dn?=
 =?us-ascii?Q?IkSWlakaXVs4oE0U2iBcbfI9Qn6qa8cynYZvdh9mqPg5umPzKq0fjmEe7hMi?=
 =?us-ascii?Q?IpG9KH36zZze80zUdB0x155yd4/+aLx3sNIZWIAqwOM8+1nmz9S0xoeBF7pE?=
 =?us-ascii?Q?ZbhnkXZrAmkdrMjuhJRsG6ISDfe9kYhzSU3jMMQNZEL0X9F1NngaStosf+Rx?=
 =?us-ascii?Q?SQ9nNm1YWqXE/6F3XebBrMb/P2uQXm0IhyyNv0tt5JabQNOVm97Dl/2YlHlW?=
 =?us-ascii?Q?bLmM6bmhdj/XxSF0ZJ35T5stSATDkvZ25Yg3v3FttL743CDrwl7/biYULSwp?=
 =?us-ascii?Q?AvugKlBNBClT7qD0+tzjtcOg1xu0ootN7RdbOHkANNLWDZzLIODWJl0Zos7M?=
 =?us-ascii?Q?GEldcrq0VgzkHRIURF4lRtQ7HD3p2DKmMlFkaYHmi7olS64TGcmlMSJ4YKv5?=
 =?us-ascii?Q?hbycvdqF6JiBZN4Dq/uetcuw3v1HA77wjRV4gnx7xyOHqy70MDhiq/P58Fk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe25801-f749-4eb7-4c6a-08dbf581ad12
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:02:30.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Add clock controller support for the Sophgo CV1800B and CV1812H.
>
>Inochi Amaoto (4):
>  dt-bindings: clock: sophgo: Add CV1800 bindings
>  clk: sophgo: Add CV1800 series clock controller driver
>  riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
>  riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
>
> .../bindings/clock/sophgo,cv1800-clk.yaml     |   53 +
> arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |    4 +
> arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |    4 +
> arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   28 +-
> drivers/clk/Kconfig                           |    1 +
> drivers/clk/Makefile                          |    1 +
> drivers/clk/sophgo/Kconfig                    |    7 +
> drivers/clk/sophgo/Makefile                   |    7 +
> drivers/clk/sophgo/clk-cv1800.c               | 1548 +++++++++++++++++
> drivers/clk/sophgo/clk-cv1800.h               |  123 ++
> drivers/clk/sophgo/clk-cv18xx-common.c        |   76 +
> drivers/clk/sophgo/clk-cv18xx-common.h        |   85 +
> drivers/clk/sophgo/clk-cv18xx-ip.c            |  898 ++++++++++
> drivers/clk/sophgo/clk-cv18xx-ip.h            |  266 +++
> drivers/clk/sophgo/clk-cv18xx-pll.c           |  465 +++++
> drivers/clk/sophgo/clk-cv18xx-pll.h           |   79 +
> include/dt-bindings/clock/sophgo,cv1800.h     |  174 ++
> 17 files changed, 3814 insertions(+), 5 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> create mode 100644 drivers/clk/sophgo/Kconfig
> create mode 100644 drivers/clk/sophgo/Makefile
> create mode 100644 drivers/clk/sophgo/clk-cv1800.c
> create mode 100644 drivers/clk/sophgo/clk-cv1800.h
> create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.c
> create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.h
> create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.c
> create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.h
> create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.c
> create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.h
> create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h
>
>--
>2.43.0
>

This patch follow this patch series:
https://lore.kernel.org/all/IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com/
