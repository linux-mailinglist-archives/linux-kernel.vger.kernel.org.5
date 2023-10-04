Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DA87B821A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbjJDOSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjJDOSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:18:30 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2081.outbound.protection.outlook.com [40.92.102.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C40C1;
        Wed,  4 Oct 2023 07:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOEcB0+jT+ClB4LZmcHmUJ5N1t+zdORTQeGMWBOCSYUcPJx/wUNcCv7ZZ5H0tHl2izlhyyfpLiDECS8zV2bRUA1Brj9Xzlrikncvp3aXMBxZXbapXCCy9qhJQO7K8Hn1E/IScP776rpGTV/7FDa18/0rgxVTE3QZZ14wrURUoDtd25Vlmno53+oEDdctXRAJNoaFn0QiucroP6QiKF30xz2AZGk+Hyrn7gUJNAd1kQ7SCB7fLMBx61NQSQuoHPY0qYMNF35mAtu3v1V0e8kNGQell932cJCUns6JZVlSkuQajpWM2LJBLbyY5GqMsYvFlKJ94Q3DEPCNcR/A5SeUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUpC3nnMsQ2YxyJ2Gs1n8J0MK43DiwcS5EkDVnyQ05A=;
 b=hPbckH1De+0FnYI3YajfKUn658wePML/jVd7PLzrvm/AgjuwHu7VVCh4zSdakAmWnKKYDj2CHISUl0jGo71EAu7sD3f2gWwNELtbIH17xAgEXGZK0bZYiAjURSWeeI9sm5v0v1goKTSpOFMlp/i481w7BD7D1iXpCY/997RueMi28VbLrBosgTsPGDoybOIYZy2W6kRdIwPlmU7uFlakPr/xuG85HrhOyePK0k0NKFAHDLim4b6nv+9u9WvXDRWh4FSKbgNeFhMIH1um4VIAz7xN6LYtI3ac3I0jDW5zR+YtaPQG6vqjVZ29AKOdHi3dmAOiJOS/U3KRIpzmL7YVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUpC3nnMsQ2YxyJ2Gs1n8J0MK43DiwcS5EkDVnyQ05A=;
 b=P06i5YpgdfErxLzp2wldo3NF9ZbybTspL5tHdu2z1WTYxmSAAag/EStoeZo3BJGZ9NUscfnnnU6dGmEqCMyL6b096ZikxIYxMuYbyUf5knRm71Jm3ZPZ9Wj+qvfnlGlZsGFm1zb4ozculJeXmMAxA+/o94fMG1fCOYz2pWtiShHlogj9hEoadff3BrlyDi2Bfc9dG1MwFOcRGIZMhEBiiDZ8WGcXgNXNt/wV6GY+PICmkngRKb4/fTm766P0fAT1sCzuhb9Ny6qelIzikchIifsKjyRH5/HsSu887mqpSIfApU6Qkr121tWbtUk7a4YvbPq9Al++J4BqzWpDlLZ0tQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB0995.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:146::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Wed, 4 Oct 2023 14:18:17 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 14:18:17 +0000
From:   Chen Wang <unicorn_wang@outlook.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v4 00/10] Add Milk-V Pioneer RISC-V board support
Date:   Wed,  4 Oct 2023 22:17:36 +0800
Message-ID: <MA0P287MB03325FBDFBDF9243635FB9FCFECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Ykg+6MSJXQmA0Jc5L5BqRL1fYcUjEiZ7]
X-ClientProxiedBy: SL2P216CA0164.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::8) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <cover.1696426805.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB0995:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fd06c1-3ef0-49a0-2ed4-08dbc4e4c0e4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNt4JVYNI3eKRQjNjl0/bh/oaaSaXx8MxZIMfIY4ADK2jcJ94xLz7c1rq4Rpt3i55n/BG7EIk49XcX+C18GJAFx//ZgxDAB4JjFmePv3gcAZsLSXguUVKRC29J1qZ2uHG/YMFRlrQ76Uyzbyz1PIK6JGIXaFgRuhdq5KhN4g3//uh8tjkadn+zPRaHc5Iary+7T7yKY3T7Oz7P0K+NWnx302HjuwlxAyLFZ1lzZknDerMS5IhhIB0QOB4gJV2IcGZCsBrbgyRWID8phXxtYHY+M9I0DFAe2DhyEEA+dIpN/i6q/M3ZPeGz0XIhuM8wTQbtXYi0IPZQTS25i3Xr6QuCsB7NIftvyz4c5KnXoyJJ5pLeVbJaf+eGV3C4xwSLEPywwjMLT6tu5/CMgNmMVteW1GNiUHiY4wg8JAAB9GOcklhuZgyloP5oOr+apw3tx4HZFjsH0S4pGQC+7w7A7uPElbe9l37PCY+IHOuIRcoTKDTGkn8jBON1h4usnUWiMvOQnZTogjOhfnHbHvUmYtSnqiEuCTN+rOZYVS+SwT3vGEq6YIns4TbBoDWNPBPXvve0wNOX2lhvXnK0toS+YFw2P/D5o9vGOZDiVr3n04bJTQKoxem26r+P3b1UBIUgZzml+j/iOyWdoUR2yn+9KoxoEABzwBzwPjk8rleCEmYy4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LZ9NLdIVw6sjjjvsGWk8eLe770F93uHdaJPhe3UW+dVMu+6HD01xBYN1pEGX?=
 =?us-ascii?Q?BV8neSPKeNLsbZIVrCLkFymBcRT9KghMLy8BQl8/apKSLe3MDF8qPAqchlZr?=
 =?us-ascii?Q?3RqpSAtU/MZdHNToErgLjTnQsqjZfZ0bbseajnzTBhX8OMHugDwIbeUABpVX?=
 =?us-ascii?Q?NqT2HWc2z67zNNN5YvBBwSjWoFazvDWMfJTDiKFd50nqMFDl1Iv4EVPbUvd7?=
 =?us-ascii?Q?+Hq9TkYt4d1gvCu++SpZLwM6Z8T+LZ/RsPgxEyQGG8gPq1DEuBIMZlr4DyeG?=
 =?us-ascii?Q?zvHu28Wa2enAEJlKdL9T/F0db4uHSeuRiJRAY9ZpvxlyJT2vH1T3jIDCBlK+?=
 =?us-ascii?Q?dQBxYD1EEE6XFjAcQuykBxb4em5yMXFq8YtOywmnzfPFYnGzP0q8osxoJo7T?=
 =?us-ascii?Q?W30C7YVr1iA7grcvLSSbHaj5qkcTygXThF7jdv1waxIFl/zE3cbn2E3T+PUx?=
 =?us-ascii?Q?FgAe3ClpcAPTL16PcC+w0XMpjF7G2NIN1FTlwbNVjxBvK8bOzvLrON3SzfPe?=
 =?us-ascii?Q?0jnwDDaA05GtNErnX+m1tTNlwfj9Uyrz3YnEoSRdTwpq2PxAw7F6YrOgYNaD?=
 =?us-ascii?Q?OrxA7TqP6vwRzSjFs2PwzWVgSLwQuiWz5ELp/M3qDrEu3i2shfXkr8h5lpHw?=
 =?us-ascii?Q?O3AMJRGe8IGybcgWxzuQ4AGJuejbFP1ChJRnzA2agehH6PmbqJXa4SmChSl8?=
 =?us-ascii?Q?GVQ3LzT9Ydx6vMiRZf14sjNHqfLuTAYjlZpibCXFRK48LhZAeccG9Zzpz73i?=
 =?us-ascii?Q?e9Lr9Fdtit/zVAVRy7wR3kcf3/Te9cBxt2Xw/4sWc+81ZT4EPI6EYaOmJINs?=
 =?us-ascii?Q?yVQyWeYTxkehXENnh4cotO1lf9SkMbEHS92i5EWSSpVr61nChDKGCeu2ilWb?=
 =?us-ascii?Q?UJJ5g/JGExmZB/muVpNxESaGMy7YFWcbbY8SXVj86i+8l1YYxDqUNeNgZEa2?=
 =?us-ascii?Q?HwtfaB5aYrEmwNAEqdZJWpaqSBw9hV9OKv4M7uaU/08p+ygQc70j/xT0qC0P?=
 =?us-ascii?Q?w5fkrECL/INy/ZV/kj7eJLktp7ThxOublTswgxALgs7SqTob4ADk8iHUI29d?=
 =?us-ascii?Q?QgX6W2n8IX+Tr8i25aHxViSMXJejbTlcBCerorpyC8wgAxpReWxXDVDXgxGR?=
 =?us-ascii?Q?5xqfSTeTITJK3M8q7P6EsiHvTXTxL1Gg6ps2AQv8xIi9V9Q0DlK5Ias0cQtK?=
 =?us-ascii?Q?Bo9/6xVBC2tjAJpjaTAuq3nda6y56Vuor1WmM6ARk/a9/IB0HGuv4liDnH4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fd06c1-3ef0-49a0-2ed4-08dbc4e4c0e4
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:18:17.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 [2]
in a standard mATX form factor. Add minimal device
tree files for the SG2042 SOC and the Milk-V Pioneer board.

Now only support basic uart drivers to boot up into a basic console.

Thanks,
Chen

---

Changes in v4:
  The patch series is based on v6.6-rc1. You can simply review or test 
  the patches at the link [6].
  - Update bindings files for sg2042 clint as per intput from reviewers:
    - rename filename from sophgo,sg2042-clint-mswi/sg2042-clint-mtimer
      to thead,c900-aclint-mswi/thead,c900-aclint-mtimer.
    - rename compatible strings accordingly.
  - Update dts as per input from reviewers: don't use macro for cpus's isa
    properties; use new compatible strings for mtimer/mswi of clint.
  - Use only one email-address for SoB.

Changes in v3 [v3]:
  The patch series is based on v6.6-rc1. You can simply review or test 
  the patches at the link [5].
  - add new vendor specific compatible strings to identify timer/mswi for sg2042 clint
  - updated maintainers info. for sophgo devicetree
  - remove the quirk changes for uart
  - updated dts, such as:
    - add "riscv,isa-base"/"riscv,isa-extensions" for cpus
    - update l2 cache node's name
    - remove memory and pmu nodes
  - fixed other issues as per input from reviewers.

Changes in v2 [v2]:
  The patch series is based on v6.6-rc1. You can simply review or test 
  the patches at the link [4].
  - Improve format for comment of commitments as per input from last review.
  - Improve format of DTS as per input from last review.
  - Remove numa related stuff from DTS. This part is just for optimization, may
    add it later if really needed. 

Changes in v1:
   The patch series is based on v6.6-rc1. Due to it is not sent in thread,
   I have listed permlinks of the patchset [v1-0/12] ~ [v1-12/12] here for 
   quick reference. You can simply review or test the patches at the link [3].

[1]: https://milkv.io/pioneer
[2]: https://en.sophgo.com/product/introduce/sg2042.html
[3]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal
[4]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal-v2
[5]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal-v3
[6]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal-v4
[v1-0/12]:https://lore.kernel.org/linux-riscv/20230915070856.117514-1-wangchen20@iscas.ac.cn/
[v1-1/12]:https://lore.kernel.org/linux-riscv/20230915071005.117575-1-wangchen20@iscas.ac.cn/
[v1-2/12]:https://lore.kernel.org/linux-riscv/20230915071409.117692-1-wangchen20@iscas.ac.cn/
[v1-3/12]:https://lore.kernel.org/linux-riscv/20230915072242.117935-1-wangchen20@iscas.ac.cn/
[v1-4/12]:https://lore.kernel.org/linux-riscv/20230915072333.117991-1-wangchen20@iscas.ac.cn/
[v1-5/12]:https://lore.kernel.org/linux-riscv/20230915072358.118045-1-wangchen20@iscas.ac.cn/
[v1-6/12]:https://lore.kernel.org/linux-riscv/20230915072415.118100-1-wangchen20@iscas.ac.cn/
[v1-7/12]:https://lore.kernel.org/linux-riscv/20230915072431.118154-1-wangchen20@iscas.ac.cn/
[v1-8/12]:https://lore.kernel.org/linux-riscv/20230915072451.118209-1-wangchen20@iscas.ac.cn/
[v1-9/12]:https://lore.kernel.org/linux-riscv/20230915072517.118266-1-wangchen20@iscas.ac.cn/
[v1-10/12]:https://lore.kernel.org/linux-riscv/20230915072558.118325-1-wangchen20@iscas.ac.cn/
[v1-11/12]:https://lore.kernel.org/linux-riscv/20230915072624.118388-1-wangchen20@iscas.ac.cn/
[v1-12/12]:https://lore.kernel.org/linux-riscv/20230915072653.118448-1-wangchen20@iscas.ac.cn/
[v2]:https://lore.kernel.org/linux-riscv/cover.1695189879.git.wangchen20@iscas.ac.cn/
[v3]:https://lore.kernel.org/linux-riscv/cover.1695804418.git.unicornxw@gmail.com/

---

Chen Wang (8):
  riscv: Add SOPHGO SOC family Kconfig support
  dt-bindings: vendor-prefixes: add milkv/sophgo
  dt-bindings: riscv: add sophgo sg2042 bindings
  dt-bindings: riscv: Add T-HEAD C920 compatibles
  dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
  riscv: dts: add initial Sophgo SG2042 SoC device tree
  riscv: dts: sophgo: add Milk-V Pioneer board device tree
  riscv: defconfig: enable SOPHGO SoC

Inochi Amaoto (2):
  dt-bindings: timer: Add Sophgo sg2042 CLINT timer
  dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi

 .../sifive,plic-1.0.0.yaml                    |    1 +
 .../thead,c900-aclint-mswi.yaml               |   43 +
 .../devicetree/bindings/riscv/cpus.yaml       |    1 +
 .../devicetree/bindings/riscv/sophgo.yaml     |   28 +
 .../timer/thead,c900-aclint-mtimer.yaml       |   43 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    4 +
 MAINTAINERS                                   |    7 +
 arch/riscv/Kconfig.socs                       |    5 +
 arch/riscv/boot/dts/Makefile                  |    1 +
 arch/riscv/boot/dts/sophgo/Makefile           |    3 +
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 2000 +++++++++++++++++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   19 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  325 +++
 arch/riscv/configs/defconfig                  |    1 +
 14 files changed, 2481 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
 create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.25.1

