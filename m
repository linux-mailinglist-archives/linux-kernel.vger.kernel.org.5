Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AE478F020
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbjHaPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjHaPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:21:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1638F;
        Thu, 31 Aug 2023 08:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiS5D/3I/k4qAzIx86pLwYrUqn5NSrxFVQ6TrzS9aug90dgkjNvUOoC4i2u1o+KkoJhG1K8pjXNZjiOXZV7kxeCWpkwU8TsZiK+TBMyqsrtB7wvNgCQGMoxr3IhY/9yWCdDH7bDU2wgN58dBOQnkVLslgWcnHy32Is/zDWEFaPLdsBlgk7UbKNyGRhYUm+dRmswAXqpSk1L6buCKLkITTF9sArMofDt7NVMnmtykIo9xzW/VO5wEwaag/lZTUdmcPEyHR7pfR6xX+Guu5jcYm5DsLvjZEWFTxIurP1DgZ/t+iMzlc+6fU20HPsKiiMYN2r4Jplw0gUbyMG4UEs4D8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZ4GlraAN291VEm1cr/Y1nMq3W4TvpIRHKWhwfSz74g=;
 b=GuIBDEhvLGALW/PjVp7BUCFbGXslmTnfx+uM9QMkwZpKjVlorKdeuMIjfYIAsP9vSwBWyVSXWKw9OVY6edzvSHdu0k+hB1oae71eDNvXrcRNPIvhmysrIibFace4Y6MBgs9AXYgDpc+lmWUbufBFrz7GbQ/aEqXnL7bnGUvjeOZmVy3GjwOM2ugh5zu/eQyFbKHez/TIHaZSPrQmbqTj+YEueFVywLGM/onU8NFaDqgkobzHle55kJ+1UQMjfzezFVJ0AwPMKgP/nseaLWtyiy9OtqHsI/hSlTHXNPciKOgUwlrYtAwjQNTHCE+TfdOr5mlqVb3sM9lq22qAwR8wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZ4GlraAN291VEm1cr/Y1nMq3W4TvpIRHKWhwfSz74g=;
 b=LJckZl9Q03ndttWMo28/EGxIvz3jw2VT5gG2Zt8hn97wQjIEtLcc68KKN4+b1mRUJLwo9gfQVZWPZw3c6LRy3TuE6tbBkC439ST00XI/pltsw1OJLMkTAHHtxmchlnUA29ITejCCBUgBY0EMlFuyO3VwLBn2Epojs8vch+0ciQc=
Received: from MWH0EPF00056D13.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:16) by CH2PR12MB4104.namprd12.prod.outlook.com
 (2603:10b6:610:a4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 15:20:58 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2a01:111:f403:f805::) by MWH0EPF00056D13.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.15 via Frontend
 Transport; Thu, 31 Aug 2023 15:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 15:20:57 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 10:20:56 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 00/15] cxl/pci: Add support for RCH RAS error handling
Date:   Thu, 31 Aug 2023 10:20:16 -0500
Message-ID: <20230831152031.184295-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 56be5b54-b021-4b0d-fd1b-08dbaa35e06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4FPOs9i5VxsSP+oyertyjfcsqhndWAfqlxTCUrcbS62AuLQYZZdJrMK0jMrTTx9WhtgtYSdQCI+3ZjCE8NVMiDPLIDES6IXRrPMidnNuLJSMpHyUEEooz+1C8i573RZWPgo66xnz/mbE6hvwrVcR42gI9p/xw+8Frff8u1XywNzzGPS3fF7Stf/s6eO4Fq+iXHA7C9PBgTsVcuY36mLYXp38P6EkIGuHk8oDu0MWUAk3SrtYq0AqbkAw1jJM4xSJyhBrVpioXYdGMeJBUxlIEowjvESTSPbwlP0MIDFT6Va1YAT347iGl8jiI8gx3WrxAWM9tw2fzS4KwECnePT5p0nbdbBWQDMk4ZycFkjEA1/6TKjBRNq8/cQO1nKUyxfLo7I9odvjMeAUfYrrkQiEoP293H1F0oZ7Dwu/2gidSq1M2xcXdsGtWyP1qfqFGeBJIblCeD76D2G4ACeJhF1lTI6TVJ/rVGLNdIizO5tT0J2LjAk0EI6/JOczAg1HtqSJ2kSmdt9m70gmQ+pIhfGcvOQ9l5N9cQcGvaQSwN+KpaAhIoVAw/IS1zUVMOQbQ/0MvuTDe7cdyRQFaazdjBhpNZ20pq3TZPsVeDjUOH7gP6KLFzCytjEEjJL9u3KHFZy7hti6uap/3WauSbYQ09cG8EjtchB/3+87qbJ7R9d5NJg2+0HsnJWvtTgWEtCkaLnyeIZjb1gQgjWwbZfoxu54lC+VY1zAHapwcSaodNj6MnMdeHMPuKZfKXE+WZhl8A+rg9+djPStAMpHfhxPoT6Wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(110136005)(70206006)(70586007)(54906003)(316002)(82740400003)(356005)(81166007)(478600001)(40460700003)(7416002)(2906002)(36756003)(86362001)(41300700001)(5660300002)(44832011)(8936002)(4326008)(8676002)(1076003)(2616005)(36860700001)(26005)(336012)(426003)(16526019)(83380400001)(47076005)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:20:57.6591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56be5b54-b021-4b0d-fd1b-08dbaa35e06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables CXL RCH error handling. This is necessary because RCH
downstream port protocol error handling is implemented uniquely and not
currently supported. These patches address the following:

   * Discovery and mapping of RCH downstream port AER registers.

   * AER portdrv changes to support CXL RCH protocol errors. 

   * Interrupt setup specific to RCH mode: enabling RCEC internal
     errors and disabling root port interrupts.

   * Logging RCH downstream port AER and RAS errors.

Changes in v10:
  - Updated cxl_setup_comp_regs() in patch#1 to include
    cxl_register_map::reg_type default value initialization.
  
Changes in v9:
  - Added: cxl/regs: Prepare for multiple users of register mappings,
  - Updated use of cxl_map_component_regs() and cxl_map_device_regs

Changes in V8:
  - Rebased onto: commit
    0c0df63177e3 ("Merge branch 'for-6.5/cxl-rch-eh' into for-6.5/cxl")
  - cxl/port: Pre-initialize component register mappings
    - Added patch to pre-initialize component register mappings.
  - cxl/pci: Remove Component Register base address from
    - Separated removal of Component Register base address in struct
    cxl_dev_state to not break functionality.
  - cxl/hdm: Use stored Component Register mappings to map HDM decoder
    capability
    - Implemented a less strict check in devm_cxl_setup_hdm(), be tolerant
    if HDM decoder registers are not implemented.
  - cxl/pci: Map RCH downstream AER registers for  logging protocol errors
    - Fixed uninitialized access of map->dev in cxl_dport_map_regs().
  - PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem
    dev handler
    - Fix typo in patch description.
  - cxl/pci: Update CXL error logging to use RAS register address
    - Fix typo in patch description.
    
Changes in V7:
  - cxl: Updates for CXL Test to work with RCH
    - Removed Robert's DSO.
  - cxl/core/regs: Add @dev to cxl_register_map
    - Corrected typo in patch description.
  - PCI/AER: Unmask RCEC internal errors to enable RCH downstream port
    error handling.
    - Changed int variable to bool.
  - cxl/pci: Map RCH downstream AER registers for logging protocol errors
    - Corrected patch description.
  - cxl/pci: Add RCH downstream port AER register discovery
    - Reverted empty line removal.
  - cxl/port: Store the port's Component Register mappings in struct
    cxl_port
    - Update to use structure initialization in cxl_setup_comp_regs().
  - Remove first patch (already in the tree) and added patch 27/27.
    - Was a one-off error caused when merging branches during internal
    review.

Changes in V6:
  - Added patch for cxl test fixes: 'cxl: Update CXl Test to Work with
    RCH'. Patch from Dan.
  - Simplified: 'cxl/rch: Prepare for caching the MMIO mapped PCIe AER
    capability'. Patch from Dan.
  - Added patch: 'cxl: Rename 'uport' to 'uport_dev''
  - Updated patch: 'cxl: Rename member @dport of struct cxl_dport to
    @dport_dev'
  - Updated *map assignment to use structure init in 'cxl/core/regs: Add
    @dev to cxl_register_map'. Also fixed whitespace.
  - Removed extra whitespace in 'cxl/core/regs: Add @dev to
    cxl_register_map'
  - Updated patch subject: 'cxl/acpi: Move add_host_bridge_uport() after
    cxl_get_chbs()'
  - Changes to work with CXL test. 'cxl/acpi: Directly bind the CEDT
    detected CHBCR to the Host Bridge's port'
  - 'cxl/pci: Early setup RCH dport component registers from RCRB'
    - Removed parameter from cxl_rcrb_get_comp_regs().
    - Changed return value to EPROBE_DEFER for retry during ACPI
      initialization.
    - Changed map to us struct initialization.
  - Remove ENODEV check in 'cxl/port: Store the downstream port's
    Component Register mappings in struct cxl_dport'
  - 'cxl/port: Remove Component Register base address from struct
    cxl_dport'
    - Moved earlier with same removal for cxl_port.
  - cxl/pci: Add RCH downstream port AER register discovery
    - Flattened {request,release}_mem_region() and ioremap() into
      cxl_rcrb_to_aer().
    - Add check if OS is assigned AER handling before discovering AER.
  - Added CXL namespace import to cxl_core (drivers/cxl/core/port.c).
    Needed for using pci_print_aer(). In 'PCI/AER: Refactor
    cper_print_aer() for use by CXL driver module'.
  - cxl/pci: Map RCH downstream AER registers for logging protocol errors
    - Changed dport device used in devm_cxl_iomap_block() call to be
      port->dev.
    - Removed ENODEV check.
  - cxl/pci: Disable root port interrupts in RCH mode
    - Removed unnecessary 'rch' check.
    - Moved cxl_disable_rch_root_ints() into core/pci.c. 
    - Added OSC AER assignment check before accessing AER registers.
  - cxl/pci: Update CXL error logging to use RAS register address
    - Renamed function handlers.
  - cxl/pci: Add RCH downstream port error logging
    - Moved RCD check to caller.
    - Added put_dev() after call to cxl_pci_find_port().
                                                          
Changes in V5:
  - Split 'cxl/rch: Prepare for logging RCH downstream port protocol
    errors' patch into 2 patches.
  - Added:
    cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
    cxl/mem: Prepare for early RCH dport component register setup
  - Correct comments CXL3.0 to CXL 3.0.
  - changed cxl_port_get_comp_map() to static.

Changes in V4:
  - Made port RAS register discovery common and called from
    __devm_cxl_add_dport().
  - Changed RCH AER register discovery to be called from
    __devm_cxl_add_dport().
  - Changed RAS and RCH AER register mapping to be called from
    __devm_cxl_add_dport().
  - Changed component register mapping to support all CXL component
    mapping, cxl_map_component_regs().
  - Added cxl_regs to 'struct cxl_dport' for providing RCH downstream port
    mapped registers USED in error handler.
  - PCI/AER:
      - Improved description of PCIEAER_CXL option in Kconfig.
      - Renamed function to pci_aer_unmask_internal_errors(), added
        pcie_aer_is_native() check.
      - Improved comments and added spec refs.
      - Renamed functions to cxl_rch_handle_error*().
      - Modified cxl_rch_handle_error_iter() to only call the handler
        callbacks, this also simplifies refcounting of the pdev.
      - Refactored handle_error_source(), created pci_aer_handle_error().
      - Changed printk messages to pci_*() variants.
      - Added check for pcie_aer_is_native() to the RCEC.
      - Introduced function cxl_rch_enable_rcec().
      - Updated patch description ("PCI/AER: Forward RCH downstream
      port-detected errors to the CXL.mem dev handler").

Changes in V3:
  - Correct base commit in cover sheet.
  - Change hardcoded return 0 to NULL in regs.c.
  - Remove calls to pci_disable_pcie_error_reporting(pdev) and
    pci_enable_pcie_error_reporting(pdev) in mem.c;
  - Move RCEC interrupt unmask to PCIe port AER driver's probe.
    - Fixes missing PCIEAER and PCIEPORTBUS config option error.
  - Rename cxl_rcrb_setup() to cxl_setup_rcrb() in mem.c.
  - Update cper_mem_err_unpack() patch subject and description.

Changes in V2:
  - Refactor RCH initialization into cxl_mem driver.
    - Includes RCH RAS and AER register discovery and mapping.
  - Add RCEC protocol error interrupt forwarding to CXL endpoint
    handler.
  - Change AER and RAS logging to use existing trace routines.
  - Enable RCEC AER internal errors.

Robert Richter (9):
  cxl/port: Pre-initialize component register mappings
  cxl/regs: Prepare for multiple users of register mappings
  cxl/pci: Store the endpoint's Component Register mappings in struct
    cxl_dev_state
  cxl/hdm: Use stored Component Register mappings to map HDM decoder
    capability
  cxl/pci: Remove Component Register base address from struct
    cxl_dev_state
  cxl/port: Remove Component Register base address from struct cxl_port
  PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem
    dev handler
  PCI/AER: Unmask RCEC internal errors to enable RCH downstream port
    error handling
  cxl/core/regs: Rename phys_addr in cxl_map_component_regs()

Terry Bowman (6):
  cxl/pci: Add RCH downstream port AER register discovery
  PCI/AER: Refactor cper_print_aer() for use by CXL driver module
  cxl/pci: Update CXL error logging to use RAS register address
  cxl/pci: Map RCH downstream AER registers for logging protocol errors
  cxl/pci: Add RCH downstream port error logging
  cxl/pci: Disable root port interrupts in RCH mode

base-commit: 0c0df63177e37ae826d803280eb2c5b6b6a7a9a4

 drivers/cxl/core/core.h      |   7 ++
 drivers/cxl/core/hdm.c       |  64 +++++++------
 drivers/cxl/core/mbox.c      |   2 +
 drivers/cxl/core/pci.c       | 174 ++++++++++++++++++++++++++++++++---
 drivers/cxl/core/port.c      |  60 ++++++++++--
 drivers/cxl/core/regs.c      |  46 ++++++++-
 drivers/cxl/cxl.h            |  16 +++-
 drivers/cxl/cxlmem.h         |   4 +-
 drivers/cxl/mem.c            |   4 +-
 drivers/cxl/pci.c            |  13 ++-
 drivers/pci/pcie/Kconfig     |  12 +++
 drivers/pci/pcie/aer.c       | 162 ++++++++++++++++++++++++++++++--
 include/linux/aer.h          |   2 +-
 tools/testing/cxl/test/mem.c |   1 -
 14 files changed, 491 insertions(+), 76 deletions(-)

-- 
2.34.1

