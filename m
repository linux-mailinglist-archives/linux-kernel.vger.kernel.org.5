Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41D47CE484
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjJRR3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjJRR3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:29:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22657136;
        Wed, 18 Oct 2023 10:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxmk5vz1DSZitovsFtc+ixOFtEPzXyTcfmXrqqbHiqVyfnLr6fqK7uenkl0pLNOJICufza/IFgNU5d/plXV39b7KL3BZavRXr4/ngpiAKZq9AMb9xSde04mEsoHsFnUuPtxte7Zj+x4G8Ry/siS+CpRkb6Yc0fdd6w2Eg5O2ayeut3ELGVWTJzX89WDNuk+D8B37KCAWetEvDJMU55KFBzmUPl/JTOR2caH8h88YKmQkW5gDc2MC65g1aPAq0oMf/Ywky1pjvzkpEz2QS5oQrI1tL9X2y1ClREG3mjSaBk6WkTIJTbU/l66/2VKtywdpMvbUY44nqChxE9B5eGAryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0fjZQRYd1qEkBdWL9e5tSVrE5wSgDIBusdtCoEF6kg=;
 b=V1v35i9ZwWVRFhDELT/ettIYj21PD985kNR6yPPfsC9zDOFznDmqTEobalLXA0JEYGf8JYjht/mOVBFA8rIjEAlGPCNXeY6puyOVRTlvkYm91QCa0ylLQA10oHQBBas7FppL8bLAc36YFf+FQVKxkojjtPQMBTWpvetYlp8cg0PSyzgDUtl+1eDg5TRV8UmvyMadaOOvX3XmRveMCbmWw1jAwq6/4qXfbZmYc97QmfmQOPxSim3e2riVPSpcj5AqbeHDawK1TL3qmsktjJmEPYk101tGHd7DtPJtY/yk+SncTXc3DSDY+ZW1MXl3ac9lPti37di0z9w9rShRiL9XtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0fjZQRYd1qEkBdWL9e5tSVrE5wSgDIBusdtCoEF6kg=;
 b=nzUJfzO7Xh9SG/ey4qcyWB9kt2e5YgubfjvFglWayf9uvro5iCaMtfhRMdeO2R/lqFZUyeG2zsX1UXTi3ef/2Moj0qYzmcmn7XI2OnSOOgvS2wVXzJuyldAGCgzvS4KJRjUo/M5RXug5CQ3+Mu2TzRMdLTzMz1SdnlcPoCMNOok=
Received: from SN7PR04CA0082.namprd04.prod.outlook.com (2603:10b6:806:121::27)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 17:18:04 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::26) by SN7PR04CA0082.outlook.office365.com
 (2603:10b6:806:121::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:18:04 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:18:00 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v12 00/20] cxl/pci: Add support for RCH RAS error handling
Date:   Wed, 18 Oct 2023 19:16:53 +0200
Message-ID: <20231018171713.1883517-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: e1222fb5-0e81-4de7-521a-08dbcffe304b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQna2x97WCSz32Nr6aqEz3IN2+RwL7CF5Fwcb4Zg2IjqgVLdZFmM8sJmzdCbeoTAiA3/lnco6jKuT5idO06fD63so59A6C3VA+gj2oUcsRjBo9zZOa+eGj7vV6B+S6uTNHwbff2BAO8nMZXE5J3JrYjm9snQvBvpFgQWDo5/ROCArFYjRXbhFJDtojrFrtlbMpM9HUVxTAdatsL4QS+HwS56PI+XynAvqIxPyObIew4G6PqwHVkg4qy2hnbihll3JdKlZvIaWltItcmqwt9ZoY/qYqAVnsn4jFjAmcBVMHDB9wdr3IcUSM4828zod9BrBLfg4R0EOgcU2NPh2f9VcuP+qiTuwHrDEghn7RaP1dVMvulF8D+yDzQAsXdu/KtyzNOv81g6l/ljRsRftVrhZh5twGSbMvjU43dyIJeTKbUcE/gqo96/wh6vZqS8GyyTwbZR3VuPrv+5B0SUnmOPVh5f4FhhoaoNf07OeUIbPj3MKfI/v2e9jFc9o+3ZUvSkEvncfT3loY7bpz6NhrbuFwW6bmgOp17geIvZQ6RhoejLd/9hXd1zxSOHNlZYTifhuxxZ7/hrSjLT5zpteKk0Vnf8n2faRPNbxakxq+/M+dfT3tnC8XMHxVAFwTgx00Lu0EaG/iaybo23KZJJlozYEPljJ97MRnBpiw5cY6iB89kdV8nEiCsOKreq1QAGamX7r7iYCYSey2X7TIiIr5ddd9B6uwAmJ4umzcs3rHqHhhi7oe6HPDM/EjLXDByjR+mLEQFkMFxa0aMIPHTJONTsHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(30864003)(47076005)(2906002)(316002)(8676002)(4326008)(8936002)(41300700001)(110136005)(70586007)(70206006)(40480700001)(54906003)(36756003)(2616005)(5660300002)(336012)(1076003)(426003)(81166007)(82740400003)(16526019)(356005)(26005)(478600001)(6666004)(7416002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:18:04.1317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1222fb5-0e81-4de7-521a-08dbcffe304b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
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

Changes in v12:
  - [terry, rric] Addressed Jon's review comments:
    - Renamed function devm_cxl_setup_parent_dport() to
      cxl_setup_parent_dport()
    - cxl_rcrb_to_aer(): Using goto as exit path, added comment
    - devm_cxl_setup_hdm():
      - Initialize @reg_map immediately
      - Added comment
      - Early exit on success
      - Change debug into error message
    - cxl/port: Fix @host confusion in cxl_dport_setup_regs()
      - Moved rename of @comp_map to @reg_map into next patch
    - Updated SOB chains
  - [terry] cxl_error_is_native(): Removed native_cxl_error check as
    this is for CXL device error handling only, not protocol errors.
  - [rric] patch #1: Added Fixes: tag

Changes in v11:
  - Rebased onto cxl/fixes (c66650d29764)
  - Added: cxl/port: Fix release of RCD endpoints
  - Added: cxl/core/regs: Rename @dev to @host in struct cxl_register_map
  - Added: cxl/port: Fix @host confusion in cxl_dport_setup_regs()
  - Added: cxl/port: Rename @comp_map to @reg_map in struct cxl_register_map
  - Removed: cxl/regs: Prepare for multiple users of register mappings
  - Modified: cxl/hdm: Use stored Component Register mappings to map
    HDM decoder capability
    - Dan: rework to drop cxl_port_get_comp_map()
  - Added: cxl/pci: Introduce config option PCIEAER_CXL
  - Modified: cxl/pci: Add RCH downstream port AER register discovery
    - Moved AER discovery to devm_cxl_setup_parent_dport() called when
      memdev is probed
    - Fixed devm_cxl_iomap_block() release by fixing devm host
  - Modified: cxl/pci: Map RCH downstream AER registers for logging
    protocol errors
    - Reworded description
    - Moved register mappings to devm_cxl_setup_parent_dport() called
     when memdev is probed
  - Modified: cxl/pci: Disable root port interrupts in RCH mode
    - Call cxl_disable_rch_root_ints() in devm_cxl_setup_parent_dport()
      called when memdev is probed
    - Fixed resource release by fixing devm host
  - Reworded description of PCIEAER_CXL config option
  - Added: cxl/core/regs: Rework cxl_map_pmu_regs() to use map->dev for
    devm

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

Dan Williams (1):
  cxl/port: Fix @host confusion in cxl_dport_setup_regs()

Robert Richter (13):
  cxl/port: Fix release of RCD endpoints
  cxl/core/regs: Rename @dev to @host in struct cxl_register_map
  cxl/port: Rename @comp_map to @reg_map in struct cxl_register_map
  cxl/port: Pre-initialize component register mappings
  cxl/pci: Store the endpoint's Component Register mappings in struct
    cxl_dev_state
  cxl/hdm: Use stored Component Register mappings to map HDM decoder
    capability
  cxl/pci: Remove Component Register base address from struct
    cxl_dev_state
  cxl/port: Remove Component Register base address from struct cxl_port
  cxl/pci: Introduce config option PCIEAER_CXL
  PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem
    dev handler
  PCI/AER: Unmask RCEC internal errors to enable RCH downstream port
    error handling
  cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
  cxl/core/regs: Rework cxl_map_pmu_regs() to use map->dev for devm

Terry Bowman (6):
  cxl/pci: Add RCH downstream port AER register discovery
  PCI/AER: Refactor cper_print_aer() for use by CXL driver module
  cxl/pci: Update CXL error logging to use RAS register address
  cxl/pci: Map RCH downstream AER registers for logging protocol errors
  cxl/pci: Add RCH downstream port error logging
  cxl/pci: Disable root port interrupts in RCH mode

 drivers/cxl/core/core.h      |   1 +
 drivers/cxl/core/hdm.c       |  49 ++++----
 drivers/cxl/core/mbox.c      |   2 +
 drivers/cxl/core/pci.c       | 223 +++++++++++++++++++++++++++++++++--
 drivers/cxl/core/port.c      | 104 +++++++++++-----
 drivers/cxl/core/regs.c      |  73 +++++++++---
 drivers/cxl/cxl.h            |  34 ++++--
 drivers/cxl/cxlmem.h         |   4 +-
 drivers/cxl/mem.c            |   7 +-
 drivers/cxl/pci.c            |  14 +--
 drivers/pci/pcie/Kconfig     |   9 ++
 drivers/pci/pcie/aer.c       | 159 ++++++++++++++++++++++++-
 include/linux/aer.h          |   2 +-
 tools/testing/cxl/test/mem.c |   1 -
 14 files changed, 558 insertions(+), 124 deletions(-)


base-commit: c66650d29764e228eba40b7a59fdb70fa6567daa
-- 
2.30.2

