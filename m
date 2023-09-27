Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DD67B0C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjI0Tdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0Tdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:33:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B639ACC;
        Wed, 27 Sep 2023 12:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OngXH/fj2ZXeMBZBWQnvHSO8NUAxvNm2IAoKQA3kxVWTikvkEHEhhB4pEJSMKgX7T7Zsh17ZFQGbPfs9hX0IbBWA7xNgYhJIluBqiy2mL2HK89V15fg0y3NtNmUMQcI5pv3v4yLkOgZEuo3YHfRGUfkh314Tjf8pXNN6vhz/bk5MvLYIvoW/NAIyDhjwVgG3MAmahBszKP7Syn1ZoB3QGu5VLKVXIdk0fv/lnYczpUKtTizV2At7TbtBrZF4Tq8yrpVQBOJOpYW8CCyn8pL/BzEzZ7xPgIJTl9ylYrMk+KtLTnufhpT3zm8Zdq/UdSCxXUM2ObFZbcoC3zivgK6T0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zziH9t7vbk/m59jbFMUiSGdEkSs6z+MpaZ6XBEHoRfk=;
 b=RPMOeodLizLCRLNuhRfy279tTrntXQZGKwCufNgkbfgUQ5AO8vVNY6uwqpa9MLGkXGGf1/Px592wSo/fOiKVFsJXFEhPDQUxiO9Ym/cD34SPzQGxrB0p65NGP8IK0ZFlPDA8sMvapkbLgQLPUgFYgB0j3aMdIBZO6jewk5xVytVcrPTvkDU/imh1Cr3Ce+JPONdtHSCUe/0ocEmVSzUSg1euyZxP+yjYBmyOa95GWCV0zUSffCCKc4hC4pZE6wmPwQjt6Yd/Z0MDeid0lQ0OANrJL0D52/a90xPHGz42MD5vAmvX+nU6HaSzODMcsg5jFgUm1t0yLSrgDLdETbY0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zziH9t7vbk/m59jbFMUiSGdEkSs6z+MpaZ6XBEHoRfk=;
 b=ULt+xNZq8/VBSjqkOp1r1eiHye5Z+QhJNBdGSCx9FJKtNJ9kCL2o76re2Vwtb9ZM6JeWNB7YH59VQNMMHkvPRqznwmKOrw9FpXWdEy1lFZs2P6NF1yoJTr/FvXl3mdzPoPNBYP9T0v97UgnDKPAz8hQGU43sf6W7YwuQ5Oua/fo=
Received: from SA9P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::25)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 19:33:37 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:25:cafe::72) by SA9P221CA0020.outlook.office365.com
 (2603:10b6:806:25::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 19:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 19:33:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:33:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 12:32:48 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:32:44 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <linux@armlinux.org.uk>
CC:     <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v7 0/3] net: axienet: Introduce dmaengine
Date:   Thu, 28 Sep 2023 01:02:28 +0530
Message-ID: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: f5cae31b-ac08-4699-e2fa-08dbbf90a42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1ZlH2rirmEKwyWxlPICh2raUY+3J2BYuOJL3amRhLymZ+aaDOh5WikaGLctNdzGH8XABy0JBJuNzD23Ps5RRjLQDZH9a++aIUqEbKpoT5Kget32KklM9Ak5Mjnm13usv1AcHkef5E5XzbJ58aelvt8uJwxzoKWLXVpu7F2ePfnAytBafKgxWo9RQyZ4/8or3EaOdoeeHAGUaX3b9/a3JkE9NAU8s9+hq8o2Hk5ULLK0y5hFjpqiNM/ToSYDFD8Sdaum0Btvj9XNOr1sFV7dEcXcItP4790dBtG+4VmpARoHWwgjPLgysOmwDppyEaBEVT/mNEuGtcE7wPus8NJxMyMt0mD35jfOZ1MpRyr2HQNSwqcVZHML4qFdNFkenj/nllo5RrxwxuRYUkSej0M/AUkKsZDSPcr/1AODK02bXr0DPOdHil+/9zb7V0n2dxn90KfvZWC0ASkDOwS9Nm595XgqMZ8W2qoB093wgw6Wbt0j+MOQxv7iqjdmVk/PWopFU+IRyzQTMdzp1/nhIptx03bN0uCSQZc+vY4NivaNmLnKvOhzNC03hzQGIaN1U5QeGRPJXqdTTiFJstVkMpkGfW1VVIAnEavQrDttjL77iZZ5IAWJp77ak4K4asyp3J2T7yplq+JwhB7Vl4IVM9kVXNXC5lQP17ohChK6fFnsFXAUlcrRpkqrnqMEpSYybjw5l/WUnRSXOXk7Nys3+4nJdQ6GbuxqkGjMrBEeYwiTWPbssz4mAhb/sQbGHBBsfLMf8zs3IMUQyXJXw2qCtuGnAYy1lg5BWF242+xWZwxp29Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(316002)(7416002)(478600001)(2906002)(5660300002)(4326008)(110136005)(8936002)(8676002)(70586007)(70206006)(966005)(6666004)(66899024)(2616005)(26005)(40460700003)(41300700001)(426003)(54906003)(83380400001)(36860700001)(47076005)(356005)(36756003)(86362001)(40480700001)(82740400003)(336012)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 19:33:35.3123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cae31b-ac08-4699-e2fa-08dbbf90a42b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
X-Spam-Status: No, score=-1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 667 ++++++++++++++----
 4 files changed, 596 insertions(+), 123 deletions(-)

-- 
2.34.1

