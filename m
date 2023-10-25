Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6138A7D6F03
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344565AbjJYOQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjJYOQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:16:44 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2098.outbound.protection.outlook.com [40.107.247.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4920C13D;
        Wed, 25 Oct 2023 07:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kttCnbqTVEkan/ovrpuQ7rVNXmf0CBGPeUB5Bu7O8ARpv48Cm77yDKxMVr+dtxboTWBxKmS+qA4SaqPkC3/Y+wuXIaMjlf+MeF3CjvA3LvSyHrcwVJYQGZdOntVFn7JZjo1kdwI3UkWm0tVhqbIZWNwwHvDyNGogt9ENzVGzizKkzvGxLMAJRzfqZWEKWBcXkctkd7Ds36JrlTYq5FsdIC/0cK29rqJRuaFtG8O73XUM3jsmoM42pOy11N0pMCnV8PXSQT0NCTIZkrIEWbaON0ziK5IUXnWL0nTK+IVtIKNbx4LZaF6W6AS/q97CQ8h9+nXCkvGVrzlHzR3BW276Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfZPgs5x9hKXVW3b+7u/iCLqQp85fT9LoED95sx75iU=;
 b=mX+Gdn1MjJzuOWTsYMJZNgay+YMWmLvzZZ3hn/IXFgDFn8Ch8G8pMDpjL7jpNZxC46q+FRprEtu83wFTxL5LvGfLrkuIp+QxkRi5kRs7GCjnG43ZGhXK4qy4UWRSNZpni6tP6IKDx1j+JLcKZJrXk/YcAEM8iqMdYljXB9usDtKMRR6PkHKeeDGojV4ngwJt+mdwtK6s9rJqKi6wWJEZck+sfuHTG2/dhR3ZroHrZQ0XGRGKewwGSrfV5NB6LJcIrqKGaVoYrANL4PRa3y0wPEDFO3BRr8Aq2aTxKl8M5pgXQgv/oUvEI1NUYNPiEEjj5NJGm1qWUyj/OQ6shD8b9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=none action=none header.from=esd.eu; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfZPgs5x9hKXVW3b+7u/iCLqQp85fT9LoED95sx75iU=;
 b=nCB0SqzhtqIXiYnDT0h+zj2KS9stFOEG/APmWuR1CbpcM3oJ9eQTKHydbKncivf0DGVLBjpZX269XCJRPWPVrZAmjWAmLkNFyavvn81YmInmPbdxdJe/EJd3aqAKqe9gmDlo1pF1xGHH+ZKqs1UUBnGuUysKj+pKsUU3bKNhPZI=
Received: from AS9PR04CA0132.eurprd04.prod.outlook.com (2603:10a6:20b:531::27)
 by AS8PR03MB6838.eurprd03.prod.outlook.com (2603:10a6:20b:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 14:16:36 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:531:cafe::11) by AS9PR04CA0132.outlook.office365.com
 (2603:10a6:20b:531::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 14:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server id 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023
 14:16:35 +0000
Received: from esd-s20.esd.local (jenkins.esd [10.0.0.190])
        by esd-s7.esd (Postfix) with ESMTPS id 446D57C16C5;
        Wed, 25 Oct 2023 16:16:35 +0200 (CEST)
Received: by esd-s20.esd.local (Postfix, from userid 2044)
        id 2D4B22E44E1; Wed, 25 Oct 2023 16:16:35 +0200 (CEST)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v8 0/2] can: esd: add support for esd GmbH PCIe/402 CAN interface
Date:   Wed, 25 Oct 2023 16:16:33 +0200
Message-Id: <20231025141635.1459606-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|AS8PR03MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: b2350b69-8115-4ec8-345b-08dbd564ff21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLcDudafrXCQQdEmislAXvzAqEcULcr8mAWTyBjjzKsv9NDHYGYJTlhjn4ke72F/xJe6xwZUiSw+bGRxoOBLeGFbDwqf8uCoiw1dQNdNIsTdddgImpmimAAYyRlc/bRXYMwb5UXkh79apGzJMkxaIH9Lt8Mk/tJwoPezCc7vdueoO792ze5P0LUQAo0ebMbB8gq9oJLRpIQI4Lo/NLAnUCBfh2eFdZzwjfMR6+kuJnzXqdfnvGJF/iOCjpzCzofl2pHRSxcbK9RVm9/BoXXOyvA+u94uD4bA8ohlR5Lw5Z3T28DLHIqn/WfI6cXrBhTb9MGDzUHtnz2OrEceey7H/v5wZahZh6uRr4jdke/aEIYHAUlZ7DQiRjPuyCe+JHk0iIGkvvusKe4sKc24cPicexs/Y86LFxf+D+tk5ABoNyOSbPQvNJmxMU1xJYd5o6IPbpAj4KsDo2J+aJS5W4yqDTC4f4IZ0e8ZOs/bsIyAgYEBN2zqp67kysH7Ib1phRmU9rCHT6VDWt9njEtmMQlmDh4DxsPShxEQ0p2B9SGt0vcAlX6gWacOapxJkEciNcsrlV0qa8CE+ITP84nQjTZSlR/jp0sjeU9OnoEzhsVVRU6vcInEClKyiDf8lQBFDnKLnw/Yh4gppumBPLnRrmrVIiy9X9OvKMNEa3SDKyWVPUEWAgu3RNLAvm6FtvtIwi0AuR8j06kQsbrtMv8kxmmYHQ==
X-Forefront-Antispam-Report: CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230031)(4636009)(39840400004)(396003)(376002)(136003)(346002)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(36840700001)(46966006)(83380400001)(40480700001)(1076003)(2616005)(5660300002)(2906002)(316002)(86362001)(36756003)(8936002)(41300700001)(70206006)(70586007)(42186006)(966005)(4326008)(478600001)(54906003)(8676002)(66574015)(336012)(26005)(356005)(81166007)(36860700001)(6266002)(47076005);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:16:35.6087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2350b69-8115-4ec8-345b-08dbd564ff21
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6838
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch picks up the work from last year. Any comments on needed or
recommended changes are appreciated.

The purpose of this patch is to introduce a new CAN driver to support
the esd GmbH 402 family of CAN interface boards. The hardware design
is based on a CAN controller implemented in a FPGA attached to a
PCIe link.

More information on these boards can be found following the links
included in the commit message.

This patch supports all boards but will operate the CAN-FD capable
boards only in Classic-CAN mode. The CAN-FD support will be added
when the initial patch has stabilized.

The patch is reuses the previous work of my former colleague:
Link: https://lore.kernel.org/linux-can/1426592308-23817-1-git-send-email-thomas.koerper@esd.eu/


The patch is based on the linux-can-next main branch.

Changes in v8:
  - Rebased to 6.6-rc2 on linux-can-next branch main

Changes in v7:
  - Numerous changes. Find the quoted with inline comments about changes
    below after the changes list. Stuff that I don't understand and
    where I have questions is marked with ????.
    Unfortunately I will be AFK till 28th of November.

Changes in v6:
  - Fixed the statistic handling of RX overrun errors and increase 
    net_device_stats::rx_errors instead of net_device_stats::rx_dropped.
  - Added a patch to not increase rx statistics when generating a CAN
    rx error message frame as suggested on the linux-can list.
  - Added a patch to not not increase rx_bytes statistics for RTR frames
    as suggested on the linux-can list.

    The last two patches change the statistics handling from the previous
    style used in other drivers to the newly suggested one.

Changes in v5:
  - Added the initialization for netdev::dev_port as it is implemented
    for another CAN driver. See
    https://lore.kernel.org/linux-can/20211026180553.1953189-1-mailhol.vincent@wanadoo.fr/

Changes in v4:
  - Fixed the build failure on ARCH=arm64 that was found by the Intel
    kernel test robot. See
    https://lore.kernel.org/linux-can/202109120608.7ZbQXkRh-lkp@intel.com/

    Removed error monitoring code that used GCC's built-in compiler
    functions for atomic access (__sync_* functions). GCC versions
    after 9 (tested with "gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04)")
    don't implement the intrinsic atomic as in-line code but call
    "__aarch64_ldadd4_acq_rel" on arm64. This GCC support function
    is not exported by the kernel and therefore the module build
    post-processing fails.

    Removed that code because the error monitoring never showed a
    problem during the development this year.


Changes in v3:
  - Rework the bus-off restart logic in acc_set_mode() and
    handle_core_msg_errstatechange() to call netif_wake_queue() from the
    error active event.
  - Changed pci402_init_card() to allocate a variable sized array of
    struct acc_core using devm_kcalloc() instead of using a fixed size
    array in struct pci402_card.
  - Changed handle_core_msg_txabort() to release aborted TX frames in
    TX FIFO order.
  - Fixed the acc_close() function to abort all pending TX request in
    esdACC controller.
  - Fixed counting of transmit aborts in handle_core_msg_txabort().
    It is now done like in can_flush_echo_skb().
  - Fixed handle_core_msg_buserr() to create error frames including the
    CAN RX and TX error counters that were missing.
  - Fixed acc_set_bittiming() neither to touch LOM mode setting of
    esdACC controller nor to enter or leave RESET mode.
    The esdACC controller is going active on the CAN bus in acc_open()
    and is going inactive (RESET mode) again in acc_close().
  - Rely on the automatic release of memory fetched by devm_kzalloc().
    But still use devm_irq_free() explicitely to make sure that the
    interrupt handler is disconnected at that point.
    This avoids a possible crash in non-MSI mode due to the IRQ
    triggered by another device on the same PCI IRQ line.
  - Changed to use DMA map API instead of pci_*_consistent compatibility
    wrappers.
  - Fixed stale email references and updated copyright information.
  - Removed any traces of future CAN-FD support.


Changes in v2:
  - Avoid warning triggered by -Wshift-count-overflow on architectures
    with 32-bit dma_addr_t.
  - Fixed Makefile not to build the kernel module always. Doing this
    renamed esd402_pci.c to esd_402_pci-core.c as recommended by Marc.

previous versions:
v1 - https://lore.kernel.org/linux-can/20210728203647.15240-1-Stefan.Maetje@esd.eu/
v2 - https://lore.kernel.org/linux-can/20210730173805.3926-1-Stefan.Maetje@esd.eu/
v3 - https://lore.kernel.org/linux-can/20210908164640.23243-1-stefan.maetje@esd.eu/
v4 - https://lore.kernel.org/linux-can/20210916172152.5127-1-stefan.maetje@esd.eu/
v5 - https://lore.kernel.org/linux-can/20211109155326.2608822-1-stefan.maetje@esd.eu/
v6 - https://lore.kernel.org/linux-can/20211201220328.3079270-1-stefan.maetje@esd.eu/
v7 - https://lore.kernel.org/linux-can/20221106224156.3619334-1-stefan.maetje@esd.eu/



Stefan Mätje (2):
  MAINTAINERS: add Stefan Mätje as maintainer for the esd electronics
    GmbH PCIe/402 CAN drivers
  can: esd: add support for esd GmbH PCIe/402 CAN interface family

 MAINTAINERS                            |   7 +
 drivers/net/can/Kconfig                |   1 +
 drivers/net/can/Makefile               |   1 +
 drivers/net/can/esd/Kconfig            |  12 +
 drivers/net/can/esd/Makefile           |   7 +
 drivers/net/can/esd/esd_402_pci-core.c | 510 ++++++++++++++++
 drivers/net/can/esd/esdacc.c           | 771 +++++++++++++++++++++++++
 drivers/net/can/esd/esdacc.h           | 393 +++++++++++++
 8 files changed, 1702 insertions(+)
 create mode 100644 drivers/net/can/esd/Kconfig
 create mode 100644 drivers/net/can/esd/Makefile
 create mode 100644 drivers/net/can/esd/esd_402_pci-core.c
 create mode 100644 drivers/net/can/esd/esdacc.c
 create mode 100644 drivers/net/can/esd/esdacc.h


base-commit: 93e7eca853ca0087b129433630ddd89288d2b8b4
-- 
2.25.1

