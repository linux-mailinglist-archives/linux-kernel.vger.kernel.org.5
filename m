Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2089C7B40CA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjI3OSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjI3OSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:18:46 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2043.outbound.protection.outlook.com [40.92.103.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EB6C2;
        Sat, 30 Sep 2023 07:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjJk28pL/CbEmkeUzthhdunUsd4pPo7L92OIEg3QbwahXMc4XFPTvX1OSrwPZ5wp/gUWWbXVMD7fsEZDwwR547vfwflBFM7SB7UmosaFhQZU6usM9ejgiNby/M6YnXngLbo0W/MER4ZZwrzNlRBuMTxxLtEOqp3wDVlSV4KeXcWdRVMdYiUcgDgE9M5/admWRLSmcGkDXaSKygxn6d8CDPupjIc6gzOEjUHP9DSlTBSNCCkxo2NSCw3KHhVd5YsmK1bctx47VHpXTv/rBRN5flrnmrmsUGq92bd9c4Z5CbwMY4Tgr2b4Sb3SpcakDIjuZmA3gVAJLDc55dTO+juGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/Z09aNv/l1dLvCb3WIk9tQ48yXars6OE2nJuvxcW40=;
 b=FY+UXdxazmr4ztHKj0918nfpk6d/xMc5fpg8fG1l1rhK0lIS9HyTxvDCAyc0xmKepZdXDeZBR3AA7hm2+eRT40pZ6zt7oOhkWjzratn6kkDbw6Vn0fXINI0yCbsLJ5P88JY/BFG/ZzBpbv9z0EjenKZMzqOU+6BZ6Vnnex+oPi73xUU0ikgPQvLo1b1ZHu5g9t9g1EYqw/fagr9k+FUVnT/VYx7wENRvE0CXB+F+XKXtYNP+Mz8b2kpzUKBhrltPBqPGQfLNDPlL+XM5/PbBP4Zy11smAN6Z50hzj1S99qLEHjwOUU2s/Q1bOEJ4PyePQq8oYayWkj0RuACcELfFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/Z09aNv/l1dLvCb3WIk9tQ48yXars6OE2nJuvxcW40=;
 b=I2W9l4zkgdR9GIoHgnnvMXpx8tKuog6mAIrenr7dSh4EtoWOi5r/01iSTPD2roxaBM0QParB3lxBM9DCqSutdpp0WaKGjWpDDfi8T5BNRAGkGaUoUTuAI8jnZUupRryVZuZNMdkiSNVce+cIMngIKwWdkuezmpxUfQe6kFxikUpWYqVM+DzQoqx7NOhH1ZehCLHWjqCrjJbv8mFjFzJBVXwl1MjIYUJtRBzlrpWWK1oEe4mBfPBNvysBzGOZ0EylKVCbFTLM0Sw0gOMYiRXsM01RnIniqf6UDrYZ2eR3ii4yj3q4I0fk7v6kevwrq+rZjNTzN2+6YcZ/qOVHc/l+ew==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN3P287MB2108.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1d2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.28; Sat, 30 Sep 2023 14:18:35 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.028; Sat, 30 Sep 2023
 14:18:35 +0000
Message-ID: <MA0P287MB0332292A882CC400750788A8FEC7A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Sat, 30 Sep 2023 22:18:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add Milk-V Duo board support
To:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
References: <20230930123937.1551-1-jszhang@kernel.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20230930123937.1551-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [OcENkKcC6rr2ThiY3pkchXNLAmuCfedL]
X-ClientProxiedBy: TYWP286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::16) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <314ad51a-4fa9-44fa-a0e3-30f8fe84faae@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN3P287MB2108:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf091ac-6707-477c-65c9-08dbc1c021dd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rR6S7BpvHpk1+l6G1WIhUrUoUIiN/x22NaPqqAWmEnoLx+kI9l+fUq1wxSGl7ofxh3/l7qh99SIG7nnjMC/YiJCsasmQID0us5MygQTW8QY3rbNrJKwrusvX6Jl6E/vWQQNzsftcvPS516YbB25s/opMOr649MZP5bxKqAObm3Vop3W0ZCZwjbPa7D876ps+JlRrhZ4xYEb3iOG+aORyRp1fIjCv9JDFfNVawJfmnh0ud9vS5wsLw8u6ED0JavdqSsM3FVUZJAwDFenjwDpK/WoSDow/+Pzt7xQxd3xrd812/+c+G3aLxBAjkHCNBbQp20g6AMb2XmZw4cbv1xD6E48l+7OJGwONUYMiIkKdzenx3vfginFBYSocND6VO8FZgBe85OzorfeFunqYene6bYf3z5bhSgS/k0dUOrlFtVyKndkoZojD7j9pdFrwXsfn3u8QRGm596l6dINN0oLpXQRgu2lpAs3M/WB/KMvlwTAvRL0sQFfiH/23IraA+axtY7/ZtauxqAm0Uyj08o3xWcW+2q8U+mIvmgjthliIz7eDSlKo+wxwwOdk/NHsVgmgSlzRiqjAT46dP67WUMz/J6vl7K7WCvlNGIWxOqwOUKY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dWT3RuN2EzR1QyRVd4UklKUW1ta00zeHY0RDQ5c1NrOENha2tqdkRWN3Fq?=
 =?utf-8?B?Q3V6L2tObm9hTEtnV3ZyL0o2a2dnUXkzbDdyQ3RZSjVlOS83WmtWYlprMEZn?=
 =?utf-8?B?ZmVCaXU2ajQ0dHJoVmR0YkNidGFwaU1PUVJIVWdFamwvUlZYRnNDd21qbm9N?=
 =?utf-8?B?VzdaTTdTNmM5L0YrMVJnZFJJU05aSXZRZ1h0RGxXWTB6bk1BSGtZbTc3UmFw?=
 =?utf-8?B?NWZTTTZ1a0JZVU0rQzJzbmxjTkUwcDRweGV4d0JDQlQvK2NBdi9BaW1hYklG?=
 =?utf-8?B?bVVtNWhDSDUvL1kxSC9SUjdoTGlhM1JQVGxnNG1ROFU0QVFpT2JxMkRmY3RT?=
 =?utf-8?B?L3RJS0twR0EzVjFNTFdpNmVidzBqdHJwREJGamZnUjVQTVoyejU1emVnRElB?=
 =?utf-8?B?N3pUYitEcFJWQ1BYVUM3aVdDeEszdzhkK0E3K1REd0RrOWpsbmhPQjVKZUFJ?=
 =?utf-8?B?WjJEMXFEK1F3MVZtUiswZzNBVmU5REVtZm1yMnJPekdBTUpSMnlpNTFaeXRa?=
 =?utf-8?B?WTRHbVAyZnR5Rk80MXlVb1N5TEdVN294Z3Y5L2h5ZkxvZnJnUW9HbElSNW5O?=
 =?utf-8?B?VDlNYnNBaTZUK3ZtTml1bDNmRCs2RDF1RmFkek04aGJJYW5KOExBTUR3bEg0?=
 =?utf-8?B?aW5VNHgzT3FES296TFNmcHYyWlZDLzlydkdhR3pYR1ZLODgxblpBVXRjc1lD?=
 =?utf-8?B?anVFU3dEQUFmdXhzTkpCS1ZrSVFQdkhHSkZjRTFtTHR4ZWpRNXRHZVlheHgz?=
 =?utf-8?B?YU4vVzFzaEtmZjY3SUlkMVFsMStlN1I5SmxMM2cyZUJ1eGxRMWtaK3NKdCtX?=
 =?utf-8?B?VGFMbXZNUXY5Z2RMQVhWSTMydXBNT0ZhVGlTZlo4UERrcm1QaWdFQVFWSGox?=
 =?utf-8?B?VHBXaUhoTEdQWG56bjNodDhnWXVFYmRjR3ptRC9xS2Jsc3h2WTJaczVLaEhD?=
 =?utf-8?B?cGxFZzlIbUwycEhVNWI3bTVZUWQ2NXlUT1NuZHpJS0lIU2kzSitDdmNtc2s1?=
 =?utf-8?B?TWxHWHdLSTlnMWplT29aL2U4RmU0RlFVdXg5aDBBQ0hlOVdrcmo0RTllc0M1?=
 =?utf-8?B?RGppck9LTXh5OFcwbEZBZXRySmlKSE4yODN0alNQcTdWY29vbUZHNm5LdXFj?=
 =?utf-8?B?UVJuQ3FhZTBCcENBOENPSGZSRk9sUU4xcjhrai9oU2JZSEYvS0wrbS92TDFK?=
 =?utf-8?B?WnFneVNDZDJ3YStrMWhISVBOQ05rRkVzdnVIL1JxdFJ2eFhEV3RGMktKaXhm?=
 =?utf-8?B?Q2FNeFNtVEZKdzhqTDVVbm9XKzF1M3BGajN3SnJTc0xucW1GblBheU5yTHR2?=
 =?utf-8?B?MllCcFJwdlhidGtoM1Y4YzRWTGdoOTNXNHFDVUdFdEFPN3FqdnVCWnIrV2M4?=
 =?utf-8?B?TXpCaWlsM3ZCSDlabnZGdkF3RVY0ZHBnUERFWG11aHBNRHBnbHFUMmRGVGNj?=
 =?utf-8?B?RUhYTEl1dUt2R1JrUFhqSFNmNUpGMzNmRVc0UFdMckNyeTdhU2ZlZ0JjSWZG?=
 =?utf-8?B?U01DcjNLTUQ5NGlVaWV3elNHcDBOeEdLSVZheDdtcFQvQnZTS3hsNjBKazRF?=
 =?utf-8?B?VlFNb0Z1TWVGUmMwUk13M21Da0JMdDVtOFoxa1V3TEx5WmlneUxlUVNNc0lh?=
 =?utf-8?Q?r98CQ8+zOr1NR49Nxt/O6VVlMSzp6TaxApdp+guveRtQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf091ac-6707-477c-65c9-08dbc1c021dd
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 14:18:35.5477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2108
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/9/30 20:39, Jisheng Zhang 写道:
> Milk-V Duo[1] board is an embedded development platform based on the
> CV1800B[2] chip. Add minimal device tree files for the development board.
> Currently, now it's supported to boot to a basic shell.
>
> NOTE: this series is based on the SG2042 upstream series for the vendor
> prefix and ARCH_SOPHGO option.
Missing reference to [3].
>
> Link: https://milkv.io/duo [1]
> Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
> Link: https://lore.kernel.org/linux-riscv/cover.1695804418.git.unicornxw@gmail.com/ [3]
>
> Jisheng Zhang (5):
>    dt-bindings: interrupt-controller: Add SOPHGO CV1800B plic
>    dt-bindings: timer: Add SOPHGO CV1800B clint
>    dt-bindings: riscv: Add Milk-V Duo board compatibles
>    riscv: dts: sophgo: add initial CV1800B SoC device tree
>    riscv: dts: sophgo: add Milk-V Duo board device tree
>
>   .../sifive,plic-1.0.0.yaml                    |   1 +
>   .../devicetree/bindings/riscv/sophgo.yaml     |   4 +
>   .../bindings/timer/sifive,clint.yaml          |   1 +
>   arch/riscv/boot/dts/sophgo/Makefile           |   2 +-
>   .../boot/dts/sophgo/cv1800b-milkv-duo.dts     |  38 ++++++
>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 117 ++++++++++++++++++
>   6 files changed, 162 insertions(+), 1 deletion(-)
>   create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
>   create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>
