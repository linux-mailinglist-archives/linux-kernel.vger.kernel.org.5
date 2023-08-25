Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92D078925E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjHYXdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjHYXcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:32:36 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60069268F;
        Fri, 25 Aug 2023 16:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EetZUndM79Lub4fDCkVrlYFten2JeIqpM1FgduA79qNUo0ovl8qjWBv4VJtXZDcPWJneQU5yFaaGL4x8DtC6HBa3FmyBbOHhe5AeF57T1Jo89VYj5CxdZq1SrGr+ztIlqOxb/YDcenDm35VK3nF0cJxS/GSw2zAu2UZIV1CesjFrWiyEi26RtQTUrZ980VpSWbGgK0gJZ2CQmWbvWN3XFqL8FCPHKoHiCjUEVUQDOWLeJgEhakLTewRCU3LpiNYNNr6sOl+p96JlF7YTrd2J1Ng8V4Xp21R3JnyKkS2d/UG/VywLPXfTmyXCm9uRpoddMxT1AXqraYKZdoILmTW3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsxxhBnkwd1/pcsZ73HqvWdiALYMbQQTZ9nAysZ6RX0=;
 b=YrrU/yTERPW1ZWUAjvmmjJW3+CmB5Ezh95EpDnsrOS3m1vghgOpl6xVh2c04mUOz7Hece2of9XLibAHqGhyDKPVjGyLfDgSP5A5MWEzVaRxtR/PwNAyiAM7eniQUHbpO+EceFRYmi0jH852WLwHwIrhvZVULvHwCF8h5P42mZobQVzU31sbKi6xTNar8daRzxkFqu92FF6Rmi5vw6tXbH1hrGhJtC1ry0c5wqe1lhmAQDGSxUJHFdQh62VbxdJFYa4OOlVIIW0cZZywTqqF/rGD4Gdzk9vtEylhzJCzqfEL8eQTTerKQQQxzVLeClKVATqcSs006sJKk94FT6la3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsxxhBnkwd1/pcsZ73HqvWdiALYMbQQTZ9nAysZ6RX0=;
 b=qdARlh2OzWMDUXB1838GFfu6RsbhE5FibnqgFShye1jZvkLOmxm04oQrpIzPvt5Lr33J6Ip8xBR/2oMKbgdMrvcMfZ4SlDwUZnZhVnNjsMAS5KtLTyHjVZ7rzxZWKvSV4BAl7fKP12OeMGs9DXhlGuUFsNFtOO/C3zQU7eUEYc0=
Received: from DS7PR03CA0179.namprd03.prod.outlook.com (2603:10b6:5:3b2::34)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Fri, 25 Aug
 2023 23:32:18 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::88) by DS7PR03CA0179.outlook.office365.com
 (2603:10b6:5:3b2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 23:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 23:32:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:32:16 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v9 00/15] cxl/pci: Add support for RCH RAS error handling
Date:   Fri, 25 Aug 2023 18:31:56 -0500
Message-ID: <20230825233211.3029825-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: b7277452-df30-4672-ca88-08dba5c3855c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: da6AG8csac38EknUeo/yJ/u6bizTGvAKkEG5hgKUCEKaz96NAnXbZPLjPVizhqCn3VYwA6fguP5GkKmF0mOltPYBTLAUVXUWTClA2W14mwpsmMN5Y//RV7rZFeBS853Gp7UtCFqiBzaX9q+RQpyjBx2K+rqloFg4DdetUMDW2kRxWDjfnUXoCD1Heargp/DHpOUbPrS74uTCP7lrKarWUdXnz9ms0pvh+yVXKvvDPnw2E1CMkqS5wjWhyCKuhvoPPxRFEXxtkqPlzvzbD95Bs/A4wqHrCpqJdbSat+eVT2XMdYe80gp2Bfe2Zqzay8+ElDP3wyb0VBNP7naV99rtM4W2PwyuqbRl5BewYl+4g16ehoOY66s/WWkJT3AdrEu3ljlTdi6d2TwStR4FtLOFXB98cEurNLyNNLWruZ1Sj5oFffequ0PuWzR600bSXvhbiPxUy6FUJCd3P2XE3y5+k4nhaxQvdH/KnLQif28dCn31KtXOwZQhEYV7YclFaUWtPurG59l2h+7r/Q3y5xIeq/aXbL1OwNJNWH9OisyoclSt+unK6nsO93zssR/250i6lThJObCzpc6qyoJPd8fI+3TL4qQIPlNr1c125Mv9wN/IGDruQFSr4+vVOFY5vB4VTtip9LsNLE/qbqZJkY0IvbqvPNlhREtRP2JJcEpJL4KkklJm/97A3QyHHm9X66q9bI2IGcpajMx6idJ6/zHz/chzeSu57dCgwWkXtGTGeydBbx9FSIU8CQiyMCteUuOOD5SO4P9M/e7mvB/jMabo37E7DB9F0Xg+6NO47DaXa2Vwhw1KFoFYWCsWlqwEH+Bu
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(7416002)(40480700001)(83380400001)(7696005)(426003)(44832011)(336012)(16526019)(5660300002)(47076005)(36860700001)(86362001)(26005)(70586007)(8936002)(2616005)(4326008)(316002)(54906003)(110136005)(70206006)(82740400003)(478600001)(356005)(8676002)(81166007)(40460700003)(36756003)(41300700001)(6666004)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:32:17.6620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7277452-df30-4672-ca88-08dba5c3855c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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
 drivers/cxl/core/port.c      |  59 ++++++++++--
 drivers/cxl/core/regs.c      |  46 ++++++++-
 drivers/cxl/cxl.h            |  16 +++-
 drivers/cxl/cxlmem.h         |   4 +-
 drivers/cxl/mem.c            |   4 +-
 drivers/cxl/pci.c            |  13 ++-
 drivers/pci/pcie/Kconfig     |  12 +++
 drivers/pci/pcie/aer.c       | 162 ++++++++++++++++++++++++++++++--
 include/linux/aer.h          |   2 +-
 tools/testing/cxl/test/mem.c |   1 -
 14 files changed, 490 insertions(+), 76 deletions(-)

-- 
2.34.1

