Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36827F718A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbjKXKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345637AbjKXKcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:32:52 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4303D170B;
        Fri, 24 Nov 2023 02:32:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF7jbfUZNEfxfNRxG8sO/nFXt9A/M9UHovG+afSynSB6gHIxbciazaWxR8p51qyxVJZjMjMOiOQ807l7tHkGQ4rUxJqqo4f2p4xuUZnPOJ9jv6uu/mPDMDMQd4Hp7lmsheadjE6RCv/UghgqLJD48YTBbMy5oFDUGg13gNeEQqVx+I7N022zg/ahzNCinFUpz47E/I5ewrRTLJaVoSjGxGLp+8AsUS+l04eIgqdHR4Ugx/5YIVorN2vMKH/ldJWwCxKo98ODDCtiXScxySBcwcUeidw4YMhz9fpWNCqVR+QaBugASbsHXuHx5dhZxHzyRVeV3XH/3PkM4zNhfmgmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHvc4BKwStqQA0mMtY0qg7RSbFxFpvC6+1F28McXELg=;
 b=SsRthqOPyrmDPqRyhVVyvC6uHQP++PYjCoAHNDo5aa9o0liPknULGDc6CcFFqzc9+Sa4bkaXQ21hodRoub/1wTsmS7dwajWIMTlWNKzc9AI30P8OtZvoeGqC9HnuaqgoBQNiR9cFA1yxPF5FYSWzGM/1jrE93Ydf80idy0/N9HWevSvMZVYSN2aCLUmR72qwFUMrfpSXfUJjHAmtsTwGnAhms2ZV6K10BVVdL/5oKkOeZjWL6z3oWxgTBlchH8ARIdtz8DEkfnR+2NX5vL6OSEf6pqMBCW2IJ572jLFnakzCpAlTK/kO6S5OxdZ1BOscJpjLrHkxlyNtls96DdCDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHvc4BKwStqQA0mMtY0qg7RSbFxFpvC6+1F28McXELg=;
 b=viv+5MesI7nRJP96bwEUfx2B7E74qRNAqttiX4XcLHvbdh0dmmjfG63ybmYCuDH6wUklegXaW8WSie/SRGWSCq1yP3mVltRX8m6h0ngEXG6c0UZtYbQI/jPT6hQAOXmGHKT3VJZiS2INpq8/m184fhR4P+QzBKY5gqy+RU0qfKc=
Received: from CY5PR15CA0034.namprd15.prod.outlook.com (2603:10b6:930:1b::15)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 10:32:53 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::9d) by CY5PR15CA0034.outlook.office365.com
 (2603:10b6:930:1b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.22 via Frontend
 Transport; Fri, 24 Nov 2023 10:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.20 via Frontend Transport; Fri, 24 Nov 2023 10:32:53 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 24 Nov
 2023 04:32:28 -0600
From:   Jiqian Chen <Jiqian.Chen@amd.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Stefano Stabellini <stefano.stabellini@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        "Julia Zhang" <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>,
        Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC KERNEL PATCH v2 0/3] Support device passthrough when dom0 is PVH on Xen
Date:   Fri, 24 Nov 2023 18:31:20 +0800
Message-ID: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fc0759-f160-4039-0bfe-08dbecd8b72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJ/AXH150rg6qQAoqiltsKc2oYUmie6uNosLRds/KhvlxakpO9gaiTFvnUPf3nKOBVIQERuWLNvYlx7bO7DcLyiCOyjUhm+dm6wxifRFA8hQzLZ+QbCDqT9EEafEEulkCSLZRbx8BtVuJGUpPWj3LZLvAYgHAj1hsf/8pCComAMnvjzlDBvDKZwzT/DeG5go771nOoZDuAi3n0P2+ueT2PVfkdLcqRb7MnAr+fbtpWPxNWLKhY5aRpZONnMlEPbes+OoHZZr/o7+e7MaKCH6hzBwDywOnzlAGzbsCY1GWOmsD7w9I4n8MJlu3d7LnqJD6M3ixcuV32u8AbhZQULJnb1miX5NP8IUKXmigSFe5ZVrznmu9GEyGHiE4Qo3LWEWxq5LP9Uev5JwI3PGgyrdCtJ0Dm+K1IoSXhd4tuGe1xORbrLW8A/H7faRHcpZW4z35ZWb9p6VyNhCc8U4TfDxdDiNozI2q8M1JUIiVX0Jwxuc+W2QOfc1gLofZmQgDL9VsCsE5mbpIBDMCRCe+glHMdWgDRegSOgHAdpxicQ/PZbumagP0X4IiJnFDkR4A/ixk9ANSRxol7az8+eXqVWABEigpwWud+epwQ/ycsLJv3xe0Leu8TfKOOgxOyckFFYNDZfAyPYrGEzTVwEkfjwKVpDU4N4fNriL2q9litO/2ZP552DHCnCG3I2IBnp2HpjxSFRjxIWHv6sPxkjGTAhbN11FBzipq0a7O4PrM7BeAz/YWf3OGxdPI/ifx1vM3O5pGeEpc6srn/aTKDz2ZoHY3UD0mBV0Yh1932ipk+6eKjlNGlEwxHJYOWLrrXdJoQ5a
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(426003)(336012)(83380400001)(81166007)(356005)(921008)(82740400003)(47076005)(40460700003)(36860700001)(54906003)(70586007)(316002)(110136005)(70206006)(8676002)(8936002)(2616005)(41300700001)(7416002)(5660300002)(2906002)(4326008)(1076003)(36756003)(16526019)(26005)(40480700001)(6666004)(478600001)(966005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 10:32:53.2040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fc0759-f160-4039-0bfe-08dbecd8b72a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series of patches are the v2 of the implementation of passthrough when dom0 is PVH on Xen.
We sent the v1 to upstream before, but the v1 had so many problems and we got lots of suggestions.
I will introduce all issues that these patches try to fix and the differences between v1 and v2.

Issues we encountered:
1. pci_stub failed to write bar for a passthrough device.
Problem: when we run “sudo xl pci-assignable-add <sbdf>” to assign a device, pci_stub will
call “pcistub_init_device() -> pci_restore_state() -> pci_restore_config_space() ->
pci_restore_config_space_range() -> pci_restore_config_dword() -> pci_write_config_dword()”,
the pci config write will trigger an io interrupt to bar_write() in the xen, but the
bar->enabled was set before, the write is not allowed now, and then when Qemu config the
passthrough device in xen_pt_realize(), it gets invalid bar values.

Reason: the reason is that we don't tell vPCI that the device has been reset, so the current
cached state in pdev->vpci is all out of date and is different from the real device state.

Solution: to solve this problem, the first patch of kernel(xen/pci: Add xen_reset_device_state
function) and the fist patch of xen(xen/vpci: Clear all vpci status of device) add a new
hypercall to reset the state stored in vPCI when the state of real device has changed.
Thank Roger for the suggestion of this v2, and it is different from v1
(https://lore.kernel.org/xen-devel/20230312075455.450187-3-ray.huang@amd.com/), v1 simply allow
domU to write pci bar, it does not comply with the design principles of vPCI.

2. failed to do PHYSDEVOP_map_pirq when dom0 is PVH
Problem: HVM domU will do PHYSDEVOP_map_pirq for a passthrough device by using gsi. See
xen_pt_realize->xc_physdev_map_pirq and pci_add_dm_done->xc_physdev_map_pirq. Then
xc_physdev_map_pirq will call into Xen, but in hvm_physdev_op(), PHYSDEVOP_map_pirq is not allowed.

Reason: In hvm_physdev_op(), the variable "currd" is PVH dom0 and PVH has no X86_EMU_USE_PIRQ flag,
it will fail at has_pirq check.

Solution: I think we may need to allow PHYSDEVOP_map_pirq when "currd" is dom0 (at present dom0 is
PVH). The second patch of xen(x86/pvh: Open PHYSDEVOP_map_pirq for PVH dom0) allow PVH dom0 do
PHYSDEVOP_map_pirq. This v2 patch is better than v1, v1 simply remove the has_pirq check(xen
https://lore.kernel.org/xen-devel/20230312075455.450187-4-ray.huang@amd.com/).

3. the gsi of a passthrough device doesn't be unmasked
 3.1 failed to check the permission of pirq
 3.2 the gsi of passthrough device was not registered in PVH dom0

Problem:
3.1 callback function pci_add_dm_done() will be called when qemu config a passthrough device for domU.
This function will call xc_domain_irq_permission()-> pirq_access_permitted() to check if the gsi has
corresponding mappings in dom0. But it didn’t, so failed. See
XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH dom0 and it return irq is 0.
3.2 it's possible for a gsi (iow: vIO-APIC pin) to never get registered on PVH dom0, because the
devices of PVH are using MSI(-X) interrupts. However, the IO-APIC pin must be configured for it to be
able to be mapped into a domU.

Reason: After searching codes, I find "map_pirq" and "register_gsi" will be done in function
vioapic_write_redirent->vioapic_hwdom_map_gsi when the gsi(aka ioapic's pin) is unmasked in PVH dom0.
So the two problems can be concluded to that the gsi of a passthrough device doesn't be unmasked.

Solution: to solve these problems, the second patch of kernel(xen/pvh: Unmask irq for passthrough
device in PVH dom0) call the unmask_irq() when we assign a device to be passthrough. So that
passthrough devices can have the mapping of gsi on PVH dom0 and gsi can be registered. This v2 patch
is different from the v1(
kernel https://lore.kernel.org/xen-devel/20230312120157.452859-5-ray.huang@amd.com/,
kernel https://lore.kernel.org/xen-devel/20230312120157.452859-5-ray.huang@amd.com/ and
xen https://lore.kernel.org/xen-devel/20230312075455.450187-5-ray.huang@amd.com/),
v1 performed "map_pirq" and "register_gsi" on all pci devices on PVH dom0, which is unnecessary and
may cause multiple registration.

4. failed to map pirq for gsi
Problem: qemu will call xc_physdev_map_pirq() to map a passthrough device’s gsi to pirq in function
xen_pt_realize(). But failed.

Reason: According to the implement of xc_physdev_map_pirq(), it needs gsi instead of irq, but qemu
pass irq to it and treat irq as gsi, it is got from file /sys/bus/pci/devices/xxxx:xx:xx.x/irq in
function xen_host_pci_device_get(). But actually the gsi number is not equal with irq. On PVH dom0,
when it allocates irq for a gsi in function acpi_register_gsi_ioapic(), allocation is dynamic, and
follow the principle of applying first, distributing first. And if you debug the kernel codes(see
function __irq_alloc_descs), you will find the irq number is allocated from small to large by order,
but the applying gsi number is not, gsi 38 may come before gsi 28, that causes gsi 38 get a smaller
irq number than gsi 28, and then gsi != irq.

Solution: we can record the relation between gsi and irq, then when userspace(qemu) want to use gsi,
we can do a translation. The third patch of kernel(xen/privcmd: Add new syscall to get gsi from irq)
records all the relations in acpi_register_gsi_xen_pvh() when dom0 initialize pci devices, and provide
a syscall for userspace to get the gsi from irq. The third patch of xen(tools: Add new function to get
gsi from irq) add a new function xc_physdev_gsi_from_irq() to call the new syscall added on kernel side.
And then userspace can use that function to get gsi. Then xc_physdev_map_pirq() will success. This v2
patch is the same as v1(
kernel https://lore.kernel.org/xen-devel/20230312120157.452859-6-ray.huang@amd.com/ and
xen https://lore.kernel.org/xen-devel/20230312075455.450187-6-ray.huang@amd.com/)

About the v2 patch of qemu, just change an included head file, other are similar to the v1 (
qemu https://lore.kernel.org/xen-devel/20230312092244.451465-19-ray.huang@amd.com/), just call
xc_physdev_gsi_from_irq() to get gsi from irq.


Jiqian Chen (3):
  xen/pci: Add xen_reset_device_state function
  xen/pvh: Unmask irq for passthrough device in PVH dom0
  xen/privcmd: Add new syscall to get gsi from irq

 arch/x86/include/asm/apic.h        |  7 ++++++
 arch/x86/include/asm/xen/pci.h     |  5 ++++
 arch/x86/kernel/acpi/boot.c        |  2 +-
 arch/x86/pci/xen.c                 | 21 ++++++++++++++++
 drivers/xen/events/events_base.c   | 39 ++++++++++++++++++++++++++++++
 drivers/xen/pci.c                  | 12 +++++++++
 drivers/xen/privcmd.c              | 20 +++++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 10 ++++++++
 include/linux/irq.h                |  1 +
 include/uapi/xen/privcmd.h         |  7 ++++++
 include/xen/events.h               |  5 ++++
 include/xen/interface/physdev.h    |  2 ++
 include/xen/pci.h                  |  6 +++++
 kernel/irq/chip.c                  |  1 +
 kernel/irq/internals.h             |  1 -
 kernel/irq/irqdesc.c               |  2 +-
 16 files changed, 138 insertions(+), 3 deletions(-)

-- 
2.34.1

