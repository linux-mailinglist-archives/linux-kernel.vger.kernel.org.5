Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7769D7CCC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344106AbjJQTSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjJQTSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:18:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEB3C4;
        Tue, 17 Oct 2023 12:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpR/Ls/ClpTcTm+wj6BmArw6zgKti2kuvTSZqY0qbnUr0MUKRp7LAFEMrUjfkPZMIm9vBRSnbzFcAeGb/vh+SSoa/J0XJY/eSKhPNXp4QmqxgSjTG0wmY3wqazYnujPdKLyR2EY6m1ft9XYWPoXvfrxbPAj8Ctv5iC2naPUM/ZiEGl3C9YRZMU+9E54+g/wUv+N4HYvyQOxmDrZ9rlIKKgJUQDrHg43FwoTy9MbhmUX6Vg2ZEqi0CpgEgW7nbtaAsMlXGWlItM9NSUhjt3IylQfxp3LaoIS2fJE+NfdEwkwxPQ+ahG+NkElxFchl58/Fo+hINzOt3T4otRdMnAYuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZYpm6AA9cqtkEN+eUbZQzekEI9zyYDL8m4nO/Fw8Vs=;
 b=AmVVREX3CKm0wtYafPkASwIKQt36VszMkgDHNqxo9RArdVvw0wUiZwmG+NgOP01M0Nd7KQWAq3abLFfxrGcZbvl7GItkAqFZAIB4JJ1cU4TdKWWrEh7/ZZWR5ipcqRGdCZcoLVmu2CIqotgto6N1aCEENgEjldT+zLeJRdUn5WDeJpLQNm94DyPH7nBCYxTzotyLsT45NPhwZ/G5mnuWI6l9Zbx/R1ftJPuEoX1RMXuAD8mCLBsaUfLi5JxAv0lQ8uWa/SHI5Ql9ikfLb56HqQPIHMALEZvm+gI6ICFM7dleHMcG3E21A2Ck0nJZDsLQ+dSS0j9MgDjSYc1UCP1bnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZYpm6AA9cqtkEN+eUbZQzekEI9zyYDL8m4nO/Fw8Vs=;
 b=w2JrJHZa/t3It9q2W/FMtFT7IdlxMzdXEPNSFfyW6EHb748KPh3wVie24uxUfC1cT/o/ZLFg2pSY0cuzbFFG0h1JkXX0XsK/yOv7OQb68O6E4ZhxVRegbQx1Ea0gBgWGbaFAm02x9z4cC+n2jy3/1xK7W00gYcS/yjZXiZ9qjzs=
Received: from CH2PR12CA0015.namprd12.prod.outlook.com (2603:10b6:610:57::25)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 19:18:38 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::54) by CH2PR12CA0015.outlook.office365.com
 (2603:10b6:610:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 19:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 19:18:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:18:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:18:37 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:18:32 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <linux@armlinux.org.uk>,
        <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v8 0/3] net: axienet: Introduce dmaengine
Date:   Wed, 18 Oct 2023 00:47:51 +0530
Message-ID: <1697570274-798170-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|SA0PR12MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 949f4439-beae-4420-04b1-08dbcf45dd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4LMx8fSXFw8+0kzxbFIE1nz57gM/pi7PEBDZ3hDp2hlbXwkgRG/eix64pP6E67U+UwQWCLNQMgcpc8ZU8mTpEwPUCT6Au4Pk6ZFxRNhhFOmenwCci0+w7ZDG3EZylmWl+x+6H6nPTuXz70GyYqWq1/eLbdcLIgTx9ZmqCxDsgJzByJG3ScmDbNj7xXvtRsscJMW6uUXEQBsNZkMbxw8Nrr/XmMidRV0A6PRZKkEXLkTQ6OpusHxC7NdZCCx3K/axjKhwtuIyXaBnvBeLhFcl723QzrP9jaoNojU+cGJggWe3G6T5OyfPX9VYGT5wiYKt+fMLsNWARp45trXotTQK4MGNS6Vi2SUWk+5PDsIkLuIhrap4q90mNrYUBVItToeTxA8y+3luLTXlOxeapMmMjZUAcA+APSSgWa4taspuLRgdRBwiUUxYssSgCRwp+0G/A6Etlys6fvA0MiL9A7kqxf4SLM2RgBam3uqyPQ73XoYqAb4Y2e0FgyBx5PMlfc8U6Lrc6cQtYhCdKPT/YZUJN7Zvb/3R9krIugoLo3y7cH1kSglz8Dxz1eIf8wrdODavXGC7FUmgNZTwedHfzqHDX4NsAflF+0EeItPh2WqAVmRJRI3ttZ54LI/V1SnrnZV5x0NoKpayvGKiP9wwluR6Yd6ziUyClEoq+Qm8c5yPxuGqCJqLg3TWmeyTPrjlSB1bSrKxRNVmAh/4mW3u+WE5iymL4LIKgJrIzcnVu0GqLANBcVjQ1SYX5BlQFpC2GtFGBrwLryv3GBAcVjgClXNZh3XYCIrfn+1FfIx/aSkt60l1BcR9dm7XTg+HhcPzkik
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(36756003)(66899024)(40460700003)(110136005)(54906003)(70206006)(86362001)(82740400003)(921005)(81166007)(356005)(70586007)(316002)(36860700001)(83380400001)(336012)(8936002)(966005)(26005)(2616005)(426003)(6666004)(2906002)(478600001)(8676002)(7416002)(5660300002)(47076005)(41300700001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:18:37.7402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 949f4439-beae-4420-04b1-08dbcf45dd75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The axiethernet driver can use the dmaengine framework to communicate
with the xilinx DMAengine driver(AXIDMA, MCDMA). The inspiration behind
this dmaengine adoption is to reuse the in-kernel xilinx dma engine
driver[1] and remove redundant dma programming sequence[2] from the
ethernet driver. This simplifies the ethernet driver and also makes
it generic to be hooked to any complaint dma IP i.e AXIDMA, MCDMA
without any modification.

The dmaengine framework was extended for metadata API support during
the axidma RFC[3] discussion. However, it still needs further
enhancements to make it well suited for ethernet usecases.

Comments, suggestions, thoughts to implement remaining functional
features are very welcome!

[1]: https://github.com/torvalds/linux/blob/master/drivers/dma/xilinx/xilinx_dma.c
[2]: https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/xilinx/xilinx_axienet_main.c#L238
[3]: http://lkml.iu.edu/hypermail/linux/kernel/1804.0/00367.html
[4]: https://lore.kernel.org/all/20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com


Changes for v8:
- Use dev_consume_skb_any() in transmit callback.
- Fix queue stop logic in _xmit_dmaengine().
- Fix skb leak in _xmit_dmaengine() error path.
- In dmaengine tx path use dma_device pointer to call prep_slave_sg.
- In rx submit use rate limiting for mapping errors and fix error
  handling.
- Revert dev_err_probe from _init_dmaengine().
- Remove unnecessary new line after call to _init_dmaengine().
- Move free_irq(lp->eth_irq) to error path.
- Have separate netdev_ops for dmaengine flow.
- Remove spurious new line and inline attribute from axienet_init_legacy_dma().
- Drop indirection for xmit() func. For dmaengine flow have separate
  netdev_ops.
- Improve axienet_dma_tx_cb and axienet_rx_submit_desc documentation.

Changes in v7:
- Fix comment spaces.
- In xmit use correct XAE_FEATURE_PARTIAL_TX_CSUM define.
- Rename app to app_metadata.
- Switch to __netif_rx.
- In axienet_rx_submit_desc() add mapping error handling.
- Introduce new workaround 4/4 patch to enable lkp_test
  build coverage. To be dropped for mainline.

Changes in v6:
- Remove patchset 1-7 as it was applied to dmaengine tree in v5 version.
- Added Krzysztof reviewed-by tag for dmaengine binding patch.
- Rename struct axi_skbuff to skbuf_dma_descriptor and removed
  __packed attribute.
- Drop kmem_cache implementation and switch to using ring buffers.
- Remove __inline from axienet_init_dmaengine().
- Name labels after the target.
- Add error check for platform_get_irq_optional().
- Fix double space and no empty lines between call and its error check.

Changes in v5:
- Fix git am failure on net-next
- Addressed DT binding review comments i.e Modified commit description to
  remove dmaengine framework references and instead describe how
  axiethernet IP uses DMA channels.
- Fix "^[tr]x_chan[0-9]|1[0-5]$" -> "^[tr]x_chan([0-9]|1[0-5])$"
- Drop generic dmas description.
- Fix kmem_cache resource leak.
- Merge Xilinx DMA enhancements and optimization[4] into this series.

Changes in V4:
- Updated commit description about tx/rx channels name(1/3).
- Removed "dt-bindings" and "dmaengine" strings in subject(1/3).
- Extended dmas and dma-names to support MCDMA channel names(1/3).
- Rename has_dmas to use_dmaegine(2/3).
- Remove the AXIENET_USE_DMA(2/3).
- Remove the AXIENET_USE_DMA(3/3).
- Add dev_err_probe for dma_request_chan error handling(3/3).
- Add kmem_cache_destroy for create in axienet_setup_dma_chan(3/3).

Changes in V3:
- Moved RFC to PATCH.
- Removed ethtool get/set coalesce, will be added later.
- Added backward comapatible support.
- Split the dmaengine support patch of V2 into two patches(2/3 and 3/3).
https://lore.kernel.org/all/20220920055703.13246-4-sarath.babu.naidu.gaddam@amd.com/

Changes in V2:
- Add ethtool get/set coalesce and DMA reset using DMAengine framework.
- Add performance numbers.
- Remove .txt and change the name of file to xlnx,axiethernet.yaml.
- Fix DT check warning(Fix DT check warning('device_type' does not match
   any of the regexes:'pinctrl-[0-9]+' From schema: Documentation/
   devicetree/bindings/net/xilinx_axienet.yaml).

Radhey Shyam Pandey (2):
  dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
  net: axienet: Introduce dmaengine support

Sarath Babu Naidu Gaddam (1):
  net: axienet: Preparatory changes for dmaengine support

 .../bindings/net/xlnx,axi-ethernet.yaml       |  16 +
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  35 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 666 ++++++++++++++----
 4 files changed, 597 insertions(+), 121 deletions(-)

-- 
2.34.1

