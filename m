Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4047B8258
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbjJDOaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbjJDOag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:30:36 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2088.outbound.protection.outlook.com [40.92.103.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C212BD;
        Wed,  4 Oct 2023 07:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDSokN4bSJYcZJVbNpsB5Ybpfp82yBuZzFi8Qj6byrBmeXD7mCEEvv3LjSiYCF3HNXBMqo4JimLSum8K843XbnolZ5dPMWKUN/lFSe9b0UwSKdXP/s3TTnTMyuru4nUJ8U4hCIGEPlnt4vZx8X+aLd6jbQcQY7DN87a0HmThR9Y8OEFF6udn5/BO4VMbrsVvtsk1M7YrcKFCSZN4D5cvgrsE0zyWGkRmwgQNxrMhOr4p4uBTggFi536kL6KBgXe1xGK2yHduM6TJWfsO9t1z8eUNwFXcc2pGbQbuLqXcWS8pmnh+jRoR5oyy640oVmJe3D9wT8KklAOYnE04CQ7uEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSZPjem+x8S3gXooCm3KHQj+CDSvUrj/LZz5GOAFoZ4=;
 b=jrD/a8eBfh3pN5Jkle/hapnjnS5hkhsEZ9w2PSnncQ6A54l90zsS7Z71eaTbW67W/0X8X0Z5T/2x6Ee/9hdV5irSpsrKrMOIx0W0cs6mBISeb0lQ56MUKKsQf0CbKGjpoFCh5JsxR4yaEo+6IBSWrVA744cHJmzBox7/gKRfaNyl7M06cubZtjfgZdic5rxAqrJF5A3FbajE5Ue/uIaFjgfGJAhljdaXQ8Ox08bvkZllV802KTSQPaSFBQ84Z2HKXQgXAO1Jt0gtuwepwiD4ee7BA0xI8UN5+1rrTfzszK5uqEvDuah07m2iNl6nYNy7a34VDkwMohWhvCs4Cgz97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSZPjem+x8S3gXooCm3KHQj+CDSvUrj/LZz5GOAFoZ4=;
 b=i8ZPOgaoZxmF2b3+W3UHSsBTOHfJAzYKC8QA+a7fx6mBRG8Wsej5rr7ILldq+CYdLRl1wYh50sVLjC/h8LHm+fYRJhLeGy/o6Y+Hqzf3/K+QKqLO+ZfM9EbyNIDru6olnsCK5IPYfQ1Mh+Ws9fyQ4L+zITA7HQFKfkN9FlxSYClbF2VP+62XwpagHaa1Auc8QqIvcq9MOHGE08t+xnpIHd76pTujDR6S/u9YEId5orvpbuXWUJmD8ESxjezl9iS+yu1mDkf/rve9XAp90FnKJIp5FNRb50xsjaQh7hqqPmpG9ssx9VK3QIw5e2I5EQ3E0G8gE4dJiucbky5RJqzwWQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MA0P287MB1418.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Wed, 4 Oct 2023 14:30:23 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 14:30:23 +0000
Message-ID: <MA0P287MB0332CBCFD67E52B1DEBD34B8FECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 4 Oct 2023 22:30:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Add Milk-V Pioneer RISC-V board support
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
References: <MA0P287MB03325FBDFBDF9243635FB9FCFECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <MA0P287MB03325FBDFBDF9243635FB9FCFECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [D2JQEyRIaf35x16W9IFrFDMRzJAKd4SL]
X-ClientProxiedBy: TY2PR0101CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::27) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <9e352d6e-aea9-4f01-8749-c5c385f6e8c6@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MA0P287MB1418:EE_
X-MS-Office365-Filtering-Correlation-Id: b40456eb-09c6-4d53-9190-08dbc4e671d0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xx7e6VHBsslPE9B/vRhXLSIKzwbWdY7NNAKb7Q4BN35iFH8+N6q0s3BzNWra/YNyqPfHUTTzbOrkDpXRgPYtdOP/18XSe5qUdsNvZ2/7023q2fGAAYO727RgsJ7xCtJiv+1xRQFf3fSR/vnEhaTRw2l4us25XhN0pbLN9tBTGklNzRfYdvuJPGgvuYamk44c7Ytk5FIMgWsDmNd3a1x6eH7YNc+Q1vt1A6+zjECIqHfZLTqbR+WfNBNY+X3tXKTVexLYY3B2k2r+GoUQIv8UAOjDQ9SzfhVTwzU1mgyBTm3NV60y7N/v452GbE0NpjiO18YSlZl4Ac7x5QxhwlForJGf09hhS9DkX8gS8WefFVFtLmjRl72B/KBhyjZ0lBQ+sFhb5BWqfEhoeliD8a7Rp4ErGbij7gT4XJLv4ybx3JZogkJKXaqB1dbS+ip55K1spPhk6SeiDMK+gWqcJUaeipXgAb9WTxj6ItG8jUxl83SbUfc05hUGN0UdqipGxd+/Jhzymb2qICH9VXQbOkSbCZcR5oVyCHrgs6eHYOai8NTCsTsI3XSzRbNTWXQshbD+dub9NDfdWMrz4D3ghkxOgmuq9LRNI4TNEhCxe6Y7IKd045VuByFQULG09I0TzRF+5LgIWbFR6ASkMVLLDPCJCA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnNMSlNXMGFjZFF4Rk1Pc1owbXA0NTFSRXlhcXMvS3VCOWtoeGtoaGZSZXVG?=
 =?utf-8?B?cVBMWGhkblhyaVNmaUR0NHkvb0luek9NSGowRGZyYkExYkJEZGp0aDcwZlN0?=
 =?utf-8?B?NGVIRDNkeXowZ3NoVW15dXVoeGtnSWd2TDJnTzlJd3dBc01XZTllWEFXYjRI?=
 =?utf-8?B?eXIzcEtIcWFoamlBckk0YzBOME43Q2J5MDh6K2JyNHVyTEFpV0pIMERVa0M1?=
 =?utf-8?B?eUtPVkFPcVRWOHRFQjFTV2N5Nnk0dlA1WE5PMlBkcnl4ZDVuTkdzcDhEdEZn?=
 =?utf-8?B?SU1oN1pxWnpOUEsxQjRaQzk1dU9US1ZjMkxHSVZ5ZEZxVlRQWkR0V0thMy83?=
 =?utf-8?B?T3l0cWdiZFBOemNQWGR4OHNOUUkrcEs1SVZuUjZUdENpZkhQNDYzb0RTVThn?=
 =?utf-8?B?YmR6cGZBei9ndmhqUWhpNjVJN2ZNRHNLRXk2Q1RjMndJRXVxVHN0UFczSS9m?=
 =?utf-8?B?U0ludGFUazU2SEc0aGhHa1dZbS8vSWdBeTZqU3RYazFTbHBlaU5mNHlNa1N6?=
 =?utf-8?B?ODRJS3Ruc1NWRE8wUzh1WU94M1hjNEx2S3RxZGRXcVUxazIyTVQvZllzN0Vn?=
 =?utf-8?B?dWw1V0lCNWVwU1I1a0JTVnBlb2EzSDdZT053QWpSWjVVS3hpUk9LeDNKd3hv?=
 =?utf-8?B?emllTlk1bTgwMW12UXZYZS83TW5haVNKOXpIckZxYVRzU0gxK29TV3J6QWEz?=
 =?utf-8?B?S2lpM2E0K2U5TFN2enhFSEg1WVpUQzR3VzFKejhPSEZQWmZqSzc5Ujd0WHpL?=
 =?utf-8?B?WERmSEcrQVo0ZVNFbUw2cXdDSm0zOGRmWkZqeEhWdTF4bFZpbzlMMUxOYXls?=
 =?utf-8?B?SFlIT2dDVGovajRjU2dPTEptNlVtdjlEM3RSTjNOc1VhT0NiNXc2YjBvWEJW?=
 =?utf-8?B?ZXhhZERGU2N3ZERhRlB3c3N5REFpbzM4aC9yY2I5Q09IN0FOWXo3MHoxcWNK?=
 =?utf-8?B?eUxWQ3Jlc3JqV1Y5RmNyQ2ZXVmFBUGlyd0xZcFJUU2Jtbk5lLzk5MlBleHov?=
 =?utf-8?B?OGZEWDQvV3lKYnFOL2VwQnpmQUJ2dm9aTEkxRnQvdEJmeFVheVNRa0dTOGJS?=
 =?utf-8?B?ZjZtZEdnanlNM3ZrOGJBMVJzdFFBdXBrK1J5Vm4wSmxjNEZHSkZNRmpWdHl0?=
 =?utf-8?B?a0NzQmcvNEtaTzdGdGVteGZ1ZFVCZlcrQS94S0tHRlVObG8zMDdoaEo0MlEr?=
 =?utf-8?B?U09keGF3QjFUSEpRRXo5TGVKSVhkeEZRY0RxbkNqeUwxNCt3ZGh0MkhaRUJv?=
 =?utf-8?B?dHVINUFaUnRMa3Y0cHlJSm90eElkU0xwMTVRUUxUbEVZN3FucXpZcHh1Y0Er?=
 =?utf-8?B?OUNLcDByZCtwdVZZWVBISlNXU0l5VTFQS0RBeUd5eTRhYlBZTGwybWlSL2Zl?=
 =?utf-8?B?TXJmYllaTzNkRDBFQUdxeUlTQ3NKd0VVSERnQ2xVRjEvZkR1Y25YVlhZUXhm?=
 =?utf-8?B?L2kvTEpCLzVWRytOTXBoQ3ZjbHI2WTkzdS81ZDNibGlKWG45R09WSldzaE9F?=
 =?utf-8?B?RWJTREJWcThEZU9CR0Mxd2g1UjRhWU11MERzWXdwdXdkMXMzT3lRNkNuWjkx?=
 =?utf-8?B?cnlFblpQdVhvV0FveHBBMGVLY0ZwbUt5RTVjeXBKWitPL0lDTjVQQ3VFMVFt?=
 =?utf-8?Q?/rlhtNlqYEugmuOj56wTSEqLNajdZ5V4GPZeDe5CSMhM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40456eb-09c6-4d53-9190-08dbc4e671d0
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:30:23.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1418
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry,  please ignore this email due to not sending out in thread.

On 2023/10/4 22:17, Chen Wang wrote:
> Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 [2]
> in a standard mATX form factor. Add minimal device
> tree files for the SG2042 SOC and the Milk-V Pioneer board.
>
> Now only support basic uart drivers to boot up into a basic console.
>
> Thanks,
> Chen
>
> ---
>
> Changes in v4:
>    The patch series is based on v6.6-rc1. You can simply review or test
>    the patches at the link [6].
>    - Update bindings files for sg2042 clint as per intput from reviewers:
>      - rename filename from sophgo,sg2042-clint-mswi/sg2042-clint-mtimer
>        to thead,c900-aclint-mswi/thead,c900-aclint-mtimer.
>      - rename compatible strings accordingly.
>    - Update dts as per input from reviewers: don't use macro for cpus's isa
>      properties; use new compatible strings for mtimer/mswi of clint.
>    - Use only one email-address for SoB.
>
> Changes in v3 [v3]:
>    The patch series is based on v6.6-rc1. You can simply review or test
>    the patches at the link [5].
>    - add new vendor specific compatible strings to identify timer/mswi for sg2042 clint
>    - updated maintainers info. for sophgo devicetree
>    - remove the quirk changes for uart
>    - updated dts, such as:
>      - add "riscv,isa-base"/"riscv,isa-extensions" for cpus
>      - update l2 cache node's name
>      - remove memory and pmu nodes
>    - fixed other issues as per input from reviewers.
>
> Changes in v2 [v2]:
>    The patch series is based on v6.6-rc1. You can simply review or test
>    the patches at the link [4].
>    - Improve format for comment of commitments as per input from last review.
>    - Improve format of DTS as per input from last review.
>    - Remove numa related stuff from DTS. This part is just for optimization, may
>      add it later if really needed.
>
> Changes in v1:
>     The patch series is based on v6.6-rc1. Due to it is not sent in thread,
>     I have listed permlinks of the patchset [v1-0/12] ~ [v1-12/12] here for
>     quick reference. You can simply review or test the patches at the link [3].
>
> [1]: https://milkv.io/pioneer
> [2]: https://en.sophgo.com/product/introduce/sg2042.html
> [3]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal
> [4]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal-v2
> [5]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal-v3
> [6]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal-v4
> [v1-0/12]:https://lore.kernel.org/linux-riscv/20230915070856.117514-1-wangchen20@iscas.ac.cn/
> [v1-1/12]:https://lore.kernel.org/linux-riscv/20230915071005.117575-1-wangchen20@iscas.ac.cn/
> [v1-2/12]:https://lore.kernel.org/linux-riscv/20230915071409.117692-1-wangchen20@iscas.ac.cn/
> [v1-3/12]:https://lore.kernel.org/linux-riscv/20230915072242.117935-1-wangchen20@iscas.ac.cn/
> [v1-4/12]:https://lore.kernel.org/linux-riscv/20230915072333.117991-1-wangchen20@iscas.ac.cn/
> [v1-5/12]:https://lore.kernel.org/linux-riscv/20230915072358.118045-1-wangchen20@iscas.ac.cn/
> [v1-6/12]:https://lore.kernel.org/linux-riscv/20230915072415.118100-1-wangchen20@iscas.ac.cn/
> [v1-7/12]:https://lore.kernel.org/linux-riscv/20230915072431.118154-1-wangchen20@iscas.ac.cn/
> [v1-8/12]:https://lore.kernel.org/linux-riscv/20230915072451.118209-1-wangchen20@iscas.ac.cn/
> [v1-9/12]:https://lore.kernel.org/linux-riscv/20230915072517.118266-1-wangchen20@iscas.ac.cn/
> [v1-10/12]:https://lore.kernel.org/linux-riscv/20230915072558.118325-1-wangchen20@iscas.ac.cn/
> [v1-11/12]:https://lore.kernel.org/linux-riscv/20230915072624.118388-1-wangchen20@iscas.ac.cn/
> [v1-12/12]:https://lore.kernel.org/linux-riscv/20230915072653.118448-1-wangchen20@iscas.ac.cn/
> [v2]:https://lore.kernel.org/linux-riscv/cover.1695189879.git.wangchen20@iscas.ac.cn/
> [v3]:https://lore.kernel.org/linux-riscv/cover.1695804418.git.unicornxw@gmail.com/
>
> ---
>
> Chen Wang (8):
>    riscv: Add SOPHGO SOC family Kconfig support
>    dt-bindings: vendor-prefixes: add milkv/sophgo
>    dt-bindings: riscv: add sophgo sg2042 bindings
>    dt-bindings: riscv: Add T-HEAD C920 compatibles
>    dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
>    riscv: dts: add initial Sophgo SG2042 SoC device tree
>    riscv: dts: sophgo: add Milk-V Pioneer board device tree
>    riscv: defconfig: enable SOPHGO SoC
>
> Inochi Amaoto (2):
>    dt-bindings: timer: Add Sophgo sg2042 CLINT timer
>    dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi
>
>   .../sifive,plic-1.0.0.yaml                    |    1 +
>   .../thead,c900-aclint-mswi.yaml               |   43 +
>   .../devicetree/bindings/riscv/cpus.yaml       |    1 +
>   .../devicetree/bindings/riscv/sophgo.yaml     |   28 +
>   .../timer/thead,c900-aclint-mtimer.yaml       |   43 +
>   .../devicetree/bindings/vendor-prefixes.yaml  |    4 +
>   MAINTAINERS                                   |    7 +
>   arch/riscv/Kconfig.socs                       |    5 +
>   arch/riscv/boot/dts/Makefile                  |    1 +
>   arch/riscv/boot/dts/sophgo/Makefile           |    3 +
>   arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 2000 +++++++++++++++++
>   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   19 +
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  325 +++
>   arch/riscv/configs/defconfig                  |    1 +
>   14 files changed, 2481 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml
>   create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml
>   create mode 100644 Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>   create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi
>
>
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
