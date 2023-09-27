Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C4E7AFE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjI0Idi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjI0Ic6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:32:58 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2038.outbound.protection.outlook.com [40.92.102.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D27C198;
        Wed, 27 Sep 2023 01:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5iRk8MT+W1kLPqaqrGNwknGpDMvGfYjazZJgPdnbynD3iq+wFpomM2a3tkUYGUxQ4gKTRS0uFhwi2RSEqVTMyqjTX8Rpz5pS/PuNIt8CF9xgOqkTmJSYQiAMQfS+b72RGyoX0Bzo3yY9BYKkO0tzgNgFepOXC0eH2qu83UBO5bohpK9Avvw59Hwe15M1tIpt6375RuvYNww+abG5TnhBGZ3euUKzQFtMcNsBIVMLvqRTBKwna4UBT/H8MEJsUPVgp511xk/cu+0tMun9Wk4srG7uD1HxtGpc/h9sVrQjIFvyGCcnK/nC+B2pQrBn+Vj4DK5Psa0dHIA0sl70rwRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuRO69vy8k+ez91ZELx0P68ENEr6f132mHC07CYv1/A=;
 b=ZP9+1aYP8v1d3NnzgiL8opIlvV5kSD121C1VJf2pLoDUT5XQfeIQ8LLjMsCErh5442jbz6ZTnKVjtlcYcqManSU7sZFJgb8lHN7RnXOwKyJEQ/PcDHfmrFmKqWK91jz254wxhOuD3r/NVx+kGnr4NmIzLJ2l6q8U2/gMFC7KkMLOA+jRvhZAumctRPsHX2RoeXjZt6MFaX6zEZAIylB7/9V1QMIAES3n5cd7Blwdz80QKwgMY3VLp0OOGRDw3OGs8BEEo1cg+d+X8MRU2kuxqPKwJqHGdlFdbYVZWkXJoaLbKgliqydyUcVTLlYQHVs4/dPn+GQijPZLg3f+DwkFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuRO69vy8k+ez91ZELx0P68ENEr6f132mHC07CYv1/A=;
 b=CXe+RoUs/wtl/j83Lf2B3BinYBmzfjezzjceuXEr+mb11gnUZjc+/iPSDPw2Hy1VfziRHIUw0h4KnjhrMNyFR3sar1XcUoY3TMT90oTGdz13ECzQ2ehuvaxwl9uL5+A2PCNKaT1l5aBMaLMYENql9PCEhkKp4TNbqu3lUrMtjbnUbTK58p54HoTaaZpZrN3POt2N8Cso2wQbAQIGNXpULyAC7zoJ1Gi6ONXdR1JMU5xm1uALy0FwNo0lP7nF5vKuPx3NT8PRuPwADrCKIiYm3ovX6cxlcVQa/lZTa1A7iQW15NpCeO60d1xXF2RFs1vMjZvUh4VUMzpuX1AYU7cz8w==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB2035.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1bd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21; Wed, 27 Sep 2023 08:32:41 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 08:32:41 +0000
Message-ID: <MA0P287MB0332C7B60DDF5E13D65F84B7FEC2A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 27 Sep 2023 16:32:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] Add SOPHGO SOC family Kconfig support
To:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
References: <cover.1695800389.git.unicornxw@gmail.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1695800389.git.unicornxw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [7G0ciwaGc/YzNRjDQFX0VySWn6ADd+d8]
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <a88e89e3-fdac-4ead-b431-d6ddaa47c396@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB2035:EE_
X-MS-Office365-Filtering-Correlation-Id: 2496b785-8bdf-4989-c7f3-08dbbf345048
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jGy+PMH6LwQScSWiO5FE7gBbh1k9Pydnkm46lN9Cw7w31/hUxAKfbUkqJ0aCb3tPRzG4fjSvjPgGwlSOBWYBoBGRDX6JR1ueROPUBid+Jkb4qVgqEz8vSlzvAEgmlRLsTnYz9Zz7EueAydTE8fQRx03ftSHYQ+cBnpvmQb65wDaNLEC/f/tyPNVCO1Ab3z4hTFraHjej96UMKGwT00s4ydY9P1/0DjzYSoj5phRnmLdnn1UKGmWH5vGZ7zRoI2LU//9knswkAXEhg92KgJ6juiK4pYveJHAnuroLundyS4A+w3e7id7F3/uJIYLmd1mj8dmhYVukys7gjRedxOHPVFGWyfj2I2aCEp7jVnFRLIFzA/E5bunWtSt1U+ndqavWZIs0VZfzWEaP9rG0Xm94dqIeAi/pmPnZIyRmapG5Godjffm1uOHLWEhBY8u2rWrQYG8kr4MrAa25JuyvcN66LAEZpf8AIgD/GQ3iMwH6iJpadWD98VUJXnJmJg/OD5DolsDRuITE/nUajwS6dMWp2YKqAaHVeZrudBiOGH1zIow4bDQqOXSrX4yQDqhPdxdILxGKv7dreSkgLeKUvsq9I0Lmr7HJ7WQTmWrIbIPA0c=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlIwNFRHY2V6K3lUTW8yUVR4dndkTHFOVGcwWjZ5cjZlOVZSQUlYRENMd1Vt?=
 =?utf-8?B?M2NZZExxTzdHcGpvbm4xdEYvTE8rdjVBU0swU3VFMFpiMnp1cXJ1Wis5NStY?=
 =?utf-8?B?L1g3SExDa0xjTHpaOGRiSVI5MW5LRnlucmFLRGw3OUtHVURXUlpJdEV4RnQ2?=
 =?utf-8?B?OUtmS3hoWGtXM1FCVHFyNVV5VXRGNE4zM0g0VHpHR3J4cDFHQmxrdExFL2V0?=
 =?utf-8?B?Unh5MVhmNTVtTWdhTW9sSjhkbzMxVFNHMGxTWmtiZ3dLQzhFaHlVc1ptV1o2?=
 =?utf-8?B?YmNyMVFpZVlTRnh1NWxXWlh6aFhrSVBPUGhyOUR2bDl1QjRRQjQvU2V2RGk4?=
 =?utf-8?B?WXZQQ1AvUzJCc2tlRkszYThCMS8yaldSakg1Zk1HOTJoWGFhVDdkM3dtRXVi?=
 =?utf-8?B?R1NjT0tGTmNYazBmeGNmM1VrQlhrV2lUUjRkdkRudk9EYy9tZmdjYWZEWjVt?=
 =?utf-8?B?bGdrYWFkRnhSVkFacGt2QWJJWHhzeTd5amZZbkpucXFCek5DQ2FrZENzUVVm?=
 =?utf-8?B?NGNoUmlHUE5NMDRYa1Z4WkViVVlwTzBOY2dGZnlhSTdMU3ZIemJwVnM5NlBF?=
 =?utf-8?B?S0tBN28vV294aFBUeldUYTFTaE1sZ09VU0JCZ09oak9YZEczUjFSZnRBNXox?=
 =?utf-8?B?WHkvQVFZNG4rWkFOakptVG1TeFJzRklDenZac0cyRVVmSFpaR0Jua3hzckxV?=
 =?utf-8?B?eDJKMWl3WnZjU0hPdittSlg0TFI5U2pXRUhwdkF1V1IzOGVUTFU4NXBsUlVL?=
 =?utf-8?B?bU84dW1QQTAzWExlOENCOXdpY1ZrN1cranpXU0JUand1UG0wMExXWlRLc3hF?=
 =?utf-8?B?NUhwaWRBOGtCVnFIRkVHYi9aNDQ2Yk5TOUNsU1RaWEJ1YlN0OXk0cUdjZTV0?=
 =?utf-8?B?RnZxc1RGbktQYktMdTRiM2J3WVpiSldMdnJIOXNjdGZYSXR6dXRWZGZwcmxF?=
 =?utf-8?B?cGwrSnQ4VGhmRzBtU08zSFJFWkNEcHUvOUlhb0RCL1ZSTHo4Ym9WL0RROUpV?=
 =?utf-8?B?V2g1Rmx4dVAzcUtKOEtGdUR5Q25WT1RXbEhGa0FxQjh3cXYrWVoxdFZZVWdB?=
 =?utf-8?B?cVAzOFVvTEw4czhDMHhQbmZMSm5Yakp5dzZTN21BdlRJVXo1Vkk2OGwyWlhx?=
 =?utf-8?B?S0pSWHFQY2ZBYWo5UUJLTlV2ZDdXSzk0VWRFMTltSG96aHJSNm03aHo5dFpr?=
 =?utf-8?B?SFdsSnU1OGFtVmpyOTR4dHV1VEdMakdmMmhxalBEY0luVEVFbEU2MkVBeDg4?=
 =?utf-8?B?d3kvcGN4eTloUjV2Q0xvZDVEYVF4QTF4d0tJU1k0U3kySktlajNMSDk5Z3FX?=
 =?utf-8?B?eVo0RGVZTHVaWTcrOE43dmlmSWgxOW8rUmJuYVI2N0R4dWFONExRcnBtUmRr?=
 =?utf-8?B?MjdXR2k1SFJKUElYUmExRmk3Wjl2bjFvbUx5WGtTQXNtNWFKUGp3aGtQRXEw?=
 =?utf-8?B?WFdPNi9KZ1M5dUZoRVNobmdKYjFFV3phT1BweDV3R3dNY2VzWkFPMEd4bUsr?=
 =?utf-8?B?Y2hNZkZDcno3VWROeXFVVjA2bUIyZlNtek1oTE1JNDU0cHVwVmtGK3RVYWlk?=
 =?utf-8?B?clJRT0VRejE5SGwxMGd2dEwvU3ArclVNUGlyelNsMWw0TUlRdkhmNnlMOGk4?=
 =?utf-8?Q?fLyk1POLNoczL1VYCRk22RkUBmSnGpTduSmbejF74leQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2496b785-8bdf-4989-c7f3-08dbbf345048
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 08:32:41.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2035
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this email. The subjiect of the email is wrong, I 
will re-send another one.

在 2023/9/27 16:26, Chen Wang 写道:
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
> Changes in v3:
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
> Changes in v2:
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
>
> ---
>
> Chen Wang (9):
>    riscv: Add SOPHGO SOC family Kconfig support
>    dt-bindings: vendor-prefixes: add milkv/sophgo
>    dt-bindings: riscv: add sophgo sg2042 bindings
>    dt-bindings: riscv: Add T-HEAD C920 compatibles
>    dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
>    MAINTAINERS: add two files to sophgo devicetrees entry
>    riscv: dts: add initial Sophgo SG2042 SoC device tree
>    riscv: dts: sophgo: add Milk-V Pioneer board device tree
>    riscv: defconfig: enable SOPHGO SoC
>
> Inochi Amaoto (2):
>    dt-bindings: timer: Add Sophgo sg2042 CLINT timer
>    dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi
>
>   .../sifive,plic-1.0.0.yaml                    |    1 +
>   .../sophgo,sg2042-clint-mswi.yaml             |   42 +
>   .../devicetree/bindings/riscv/cpus.yaml       |    1 +
>   .../devicetree/bindings/riscv/sophgo.yaml     |   28 +
>   .../timer/sophgo,sg2042-clint-mtimer.yaml     |   42 +
>   .../devicetree/bindings/vendor-prefixes.yaml  |    4 +
>   MAINTAINERS                                   |    9 +
>   arch/riscv/Kconfig.socs                       |    5 +
>   arch/riscv/boot/dts/Makefile                  |    1 +
>   arch/riscv/boot/dts/sophgo/Makefile           |    3 +
>   arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 1880 +++++++++++++++++
>   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   19 +
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  325 +++
>   arch/riscv/configs/defconfig                  |    1 +
>   14 files changed, 2361 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-clint-mswi.yaml
>   create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml
>   create mode 100644 Documentation/devicetree/bindings/timer/sophgo,sg2042-clint-mtimer.yaml
>   create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi
>
>
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
