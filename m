Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70347BAFE3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjJFBF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 21:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjJFBFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:05:24 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2065.outbound.protection.outlook.com [40.92.103.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4BD9;
        Thu,  5 Oct 2023 18:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiX+fuWwAX4HNHGbPl74csGkhFnIt/++nw+99B6yaaaF7ktNyJ/Cr5o+jZYXL5nJzp4MAuk2IRxhU00TUK9XLqHI7NbzFyxAlVAg1vVtWbNnuEECI6+HklR27M1FGM4UG4oco50WXJQFmQ9WOtSScosJFW9zar3VaXAXu6yEN3gq17PvogfBs93M818sa6R9Zca7vqPkBDnafb9M4+JL0htz5SOcbSmf3aEstmKIWrxTQE8zlYJ8XuDcvM7ImPQEqj8ZaWtedlFyL6cMvkaUd9Ww6kbaRL/FACj2DIi4LUtH2JQzd0W37AZa/zQUxn69xnSccpaDAH0r9xhIVPxGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFDh/j/zyc1ZX+vuGj4lJxM3cw5jL1gVUUPFdf3a3EQ=;
 b=nuuIdwf8fWUxvnc0gX15IP6eL+H+oo7DcWhVP68FLmR6CjX6t9MpovAXBV5P+0kOQK9iAbmPUr4K2GR9CMBdWbZXh5yNK+9itq+RssXd6BTHH1/UUN+siJ27ujFGT5lDx09lC2iWsiNFLR9UzvU/MK8rtFjvqpo3HGRdK/UGV5lP127SZRtI+XwbmJPPcCSGzLF/QwJCOJL2s5J2EqdQXnYhJ05y/O4Kczj7eGXQbvaKLfd7SoRUdt2zL6Jt2MNzNyIGa+hG3z/Bn08ItnnN9BY4Bcr6BepHXmaoWASnGFFYwB9OBlfVhMc03dgTCgrWOrzfCm6GeDx5NCaEXxVtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFDh/j/zyc1ZX+vuGj4lJxM3cw5jL1gVUUPFdf3a3EQ=;
 b=P9K38ie9wuuTwoeg58ubQI3WyXam5R4gbzclu28RG+M2APdVUEXmJGv5ZvCjBb4xplSw+N8mUxDOaAh8A4OE4+AII6Umu6lknINU1z3F4AKOj6T3C1bLqgL0K8Y/kCUZV6E/fY5Pk3EcxUDTbOrsnHe/cj3RXyNT85KBjxcHpWCdrdZ0+73lACGI1wjCtZtLwfvYF+5bWHYh9KM/k7bQY2GJnvwmViKF3S8bnh5hFkgnnBSUnV0YGGJ4NYKZMw10kM661fFr6O7KVf/NZVbgET0OQiMl++gjKzYGxLs8uS+8nMugHK77hSH/fRRBMxGab19fHGNgT80ohqJhE/rG8g==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB2049.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1bb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.38; Fri, 6 Oct 2023 01:05:13 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 01:05:13 +0000
Message-ID: <MA0P287MB0332C274FB7B5EE329857286FEC9A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Fri, 6 Oct 2023 09:05:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Add Milk-V Pioneer RISC-V board support
To:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
References: <cover.1696433229.git.unicorn_wang@outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1696433229.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [4uhQZ5ujL7e2PPYLbpE1u2tA+Kv/JcWF]
X-ClientProxiedBy: TYCP286CA0086.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::12) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <5a196100-18a9-4c54-9e4c-08829e39d783@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB2049:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e54a07-0e2b-4ad7-aa22-08dbc6084b04
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0MFuYXRKLov2AoYTOE+A/E/Dh9uSIEafTqzg7jhLbgkvxn2Iwn5GvvRR3wcCAETYLfzltU8Oq9hTk3dgLh5fgFDYlRZMO/k6Ti6t039IutWog7GgJ0tc1NanTmSHKnSJdUzbZrcUHXrjE0pJKhLMrEDgkQMX2HE3GxUA1aEovRLZxVOuWQ5LBXpgV89+m/Jsg2m//H+cHnYhHvHFSBU+FFRfy+58t6BiOFHbAlLy5HjaJKPuqcJOwPWhs9Euy74M49Gx/dR+/RGLEgjkya15NGvR6soum8zgK9h4bAesI0UVFTcyep+Qcaq5VX5gHqH3iYB2LWuoMpghgXMl0Xw7eEiVu21FB/Z29Kc1YQjGsP1caUhd37vXDebs0eFTKzcBcOASaPHOS/mCnmLHwNeACoZoQxq0TYy8PzyspHn1Prk9qbjsgVkENvJK/4s7w12e1B5H+yNII68KdFUBhN7dPSbV9p72lw2sGFbTtUXVWYeh1J+TwNFTbXygtUtuw5Z/1HieeqflFRsjUMOpGmK8DEgaTXXjG914iVjoPa2V5w0Sa1U3gSdbk0Kxlp75eHCmjFPT76BB4vDYqf2wBDTe+yeV2gfOeE/t8Yvmwad+UsBv9gt6gMN9Im/6BZLdT68uZQH8jsIjKfCS24sClzRLg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0JYL1gxYUxWZW1YZXo4YVBjdWVXY1JlNm1wZXNyV29mZ0xWUWlTaW40d0ts?=
 =?utf-8?B?Y0pYYUxaYkxJeTdtaTIxWWNwc1I3Zmx3OWlFUi9KQkZKRHlqZ3E2TzNGeUNC?=
 =?utf-8?B?VG9jdFdGbHpzcEpZU3BxYTZsVk53b01pRW4vZ21IZWF6em5GQW9HZ0ozcGlI?=
 =?utf-8?B?eHp6RWw3RjJCYnkwNmZmSlJIemUrbUdjcUp1N05kcHE4d2JXdkVzWDZ1ajRk?=
 =?utf-8?B?MmRwT2tjbUt0QWE3THJHSjh2SXZ5ck1tRzZOUThSS0lzdWlzN253R0o2V1pV?=
 =?utf-8?B?NFVWRFVyTWFTVDBQdGJZenA5bUV0THJIY2lncnE2eFdBZUhlblJTaHlDa3VJ?=
 =?utf-8?B?VlJ5TWVVblhPQUx3TWlrWWFEZmhDM0pzdVhxUGFycWRkSllmL1BqbmdCS3h2?=
 =?utf-8?B?b3pUQldlY1B1RnNSR3EwNkVObEJNdzljTFA0NjVlbWtDYW5rYzQvQmg5K0VQ?=
 =?utf-8?B?VmhjN1pjZHk3MFQ2Smp6eDBHL1k1T08rMHVwbjkzenlQSXlXSmhtWExsb2Ju?=
 =?utf-8?B?ZkIxOHZJeEEyckVUUTRlck9SN0E0M1J4VFBSUTJsOVRIWGNWaEZuNEZJQk9l?=
 =?utf-8?B?Y0wzS09EbEZFS21SWFExNlZhN2pIQnVXWlI3Z08yck5iU1VaTksxL1dXckdS?=
 =?utf-8?B?QkJ5bk9jS2JXbUk4VHB1ekFkQ2o5WDV1UlNwZGplYUJwcjZmVXA4TnFKeWRC?=
 =?utf-8?B?ZjVKNVVNYjk3Wm1GeFExUWt4TTU4OU9wTHVCTW9PUkc4cE9LSmFEeXV6bEgr?=
 =?utf-8?B?bnRlVFF4TVFXVTlwR2l1RW5YSmF3eXpZdGtSYVFsdzFpUy9naUZUTCtTS0VP?=
 =?utf-8?B?QzQ1TXVBbXVqSXpUYXVzNHFvbkFWMHpLbTQ0ZWUxVnc2anNadnI4bEgwWWVp?=
 =?utf-8?B?a1AyZVM5RlFMK1ZEeVphSHNvbkY5d1NHOFpYTFd6ZUVoTElyYkh4ODVlMVJu?=
 =?utf-8?B?SVN1RlREeWp2VS9WSTZ3MjdMMWFiVHpySko1d3l3dEFnVkQvMkZMSzVpTllI?=
 =?utf-8?B?ZXpVQ05CVWtmUDVPUUdRS1crZkVpbFlqeDk0TkpJN2dKYVRUQm96NFNtNzUw?=
 =?utf-8?B?Qks5N2dwNkY0U21tSnYvWFBUZWlUY3lDOXF2bkxiSUFZWnVDV0s2OXdjSGVQ?=
 =?utf-8?B?OStubU0xcklEbzJYL0RRVjNVRU1GVGorNUV0cXZ1QVVWOThwbmhlSjVnQmFM?=
 =?utf-8?B?MFBYMmhKWmFPUWxjaVJkeGpmcHdpZnJDcmZpbzEvbFVWbXJpRWlLcDN1SDEr?=
 =?utf-8?B?WGNMaXM1dHZtNmZPSnJ6WXBwdUg4YjJVQW53UE5iRDFUcEVGTDRKSit6Y0Iz?=
 =?utf-8?B?ZFhZa2FodVpzMGMvQXFrRUo0TzE2MXlvOXQrdEZoNXl4QXk5MVA5NytETzFu?=
 =?utf-8?B?THFCRng1UEo3b0hvR0NZaUJWcFdqYXVTYXpWcFFPVDFBMFJTVFVQdkJVcmpn?=
 =?utf-8?B?NE8rOGVMSXlOZTZpYTZyZEZ4MEx1YUk3RjVTYjBrZVNjWHR3NmlRamdCMUYy?=
 =?utf-8?B?dGhWU2gzUEw3UmIveDN2MTFXTVNaa0gyYUwvUVpudGxPMmRZNEhDMENRa1Ny?=
 =?utf-8?B?bkM3Q2MyK3RwU0ovVnVoTFF6MXBFVFRHL3pOc0dxY0NJL1NkNVlyeWloVy9M?=
 =?utf-8?Q?PVYaTC4MpjB8sEL7QtSyoD2IDNaz/B/6pbxknEaD22XI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e54a07-0e2b-4ad7-aa22-08dbc6084b04
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 01:05:13.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2049
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/4 23:37, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
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


This is the correct patchset, please review this one. Because my 
incorrect operation resulted in two patchsets with the same name being 
sent earlier, but they were incomplete. Sorry for the confusion.

Thanks,

Chen


