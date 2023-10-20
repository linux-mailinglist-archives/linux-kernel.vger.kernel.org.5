Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B717D06FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346903AbjJTDij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346886AbjJTDih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:38:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240DFD49
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHIf+L/3uvq/hiUsrUlx/JHnFEKHP4IRU9xV4jKB0SwA7B/Wk9Q4I0z9GzU81q/3s8hPImu0j5cdBW8E/p7BXUGMDnB+2oAJWIOnS0BPvNOpu9PPoz1DJplcccanackSGmenJujfW4Kdm5grQ/mhvGNtDtpP/lTu1+bA5pvW73Ms9qKE7Tsilx3DlOuHTNlRIVqLI2GiGx+DbogNOD11jhbyp/SrarqxBndbr2vlb8hGJkJN075+pvhElbkLlhvwCFvH19kGJ92EtscyAskssvG00v42pYwaUoM+3PEOf/BMu6fJ9jPYTiRGjIOuSbX1foG3+3MQAZw/Nx9jLiRrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuWr7Rhe75v/8uPIlT0yqUZTQmxBEOFnEvqWsHwc6Ug=;
 b=BG8+3a0nq/Mfq60uaDkUKm6HYlP9vh5YHHnNYuIFS2gdcWve+cugMXFjBsTw+3t4xsLOY1ctrk50nvvXOQ3WvrPbIi6OvOX2L7M/E7xTjUsSdqONnHs/kbOavOd9OiyOFjrsVpistrZ7NTYj1yJ+2k+ZGDe+zt8404BVk9QdSYIL1dUjQ4sETiE3FVIVq8GErGR4G8w2XDB2TNi/npK7DZ2z12hBF8quamBLl1fit84k2Hr95v6gX6D5byoU+/nyXa8s/whZfXIWNUBbWQVjCbgUticRbHOtO1gZPOsFOvbMWJ1ABmACUB3d7Oy2gi3kMMwt9KelMMsKwBP0WHM8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuWr7Rhe75v/8uPIlT0yqUZTQmxBEOFnEvqWsHwc6Ug=;
 b=0Htn6X8xa6N6dehsVz8dKsMc/gqn8KMMOKnQIve4h9jIMtOrwnJVU/xCpCR+2sj+xw3FC8v9PprG4JjdFTfbuOhePamLw7Je8OyVQZO5ICQIdKJERN7BD7apsx4m0t4QS/m4pLVGnAlO0LN0+rHtYl8cKNMlOnS2EEOLqb4ctGw=
Received: from CY5PR18CA0031.namprd18.prod.outlook.com (2603:10b6:930:13::14)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 03:38:32 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::3c) by CY5PR18CA0031.outlook.office365.com
 (2603:10b6:930:13::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 03:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 03:38:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 22:38:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <dlazar@gmail.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] x86/apic: Allow reprogramming IOAPIC pins the first time for non-legacy IRQs
Date:   Thu, 19 Oct 2023 22:38:05 -0500
Message-ID: <20231020033806.88063-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bac5145-6fe6-4f5d-c98e-08dbd11e087e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /V8lfBX73Cup9LaX3W5fAxbbrfEm8Ewrt6xp/heD4VxtTAM/b8zL8M3h67rzlc0plA0xi+KeY4BZ2JxVbCVraStXThbD2GAAhJJF3YNHUxaf+fZLTIJWyNt4xvle9uwPdp928gAlztskaKcGC4EKaiUDcTRwEbysbm5b+8aKcnPaq2ULI0Ifd/QvRBKttZI64ijZ0J5WyO9vLIoIUFZjmR2DGuGzOrqQN+ymD8coiTldnCX/2VRVA2jCNQc4AX7ilPrHyBsTivX3oSJIZJARn2MHdKEZwcZnh+KO+dXPqoW+ETJRNfoabtoPhv9KzGLLlAJ+uuiwDq/c7b3MgY6z3m6FE9EWz2wjX/8oI1r0yBRwHX2LrzVXhmjqTZwkH74wiRuGNyBmYYhMyJKYWn4ZyWk2fKgcsgKHjGQ/f4jvoCLdtKfFfoOXeRLan57sdK1D0LEsOOMi+r5E2UPZG4MtDnAO7tw0Jj/WSdXIjxLxoCe8YprEq7//anCPO4ij7yLmyagVO/nGrrxEa8c41OHeI3XLta0/feHG2zcSiyFpU6ShdE0918vY5xvNai597nKQJ1vkOakvaw3wJjFBQmd7PHQTvbGv7HKJXv1RoZTsTVFtkVJiCpvKwhi1P89TCGrCgnaGiXmEN0tOn/EUosLlGPuRC44xZPaN19Y1LpmPcc678yrHhWqIysO0rslDri7suuf25oB2LeOAC6ZSJRjO73FHdufJppsqXSLkEo9S4gePmxug4aeArR1RI0dmSUDuTMAFL2Y39O5cMCt/6YXMCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(81166007)(356005)(40460700003)(82740400003)(40480700001)(36860700001)(4326008)(8676002)(54906003)(2906002)(36756003)(8936002)(7696005)(6666004)(16526019)(478600001)(1076003)(26005)(426003)(336012)(2616005)(41300700001)(316002)(47076005)(5660300002)(966005)(110136005)(83380400001)(70586007)(70206006)(86362001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 03:38:32.3714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bac5145-6fe6-4f5d-c98e-08dbd11e087e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system is set up without legacy IRQs configured
acpi_register_gsi_ioapic() still needs to be able to program the IOAPIC
to match the values from _CRS which might not match what is already
programmed to the IOAPIC.

Reported-by: dlazar@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218003
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/apic/io_apic.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 00da6cf6b07d..27dd279dcc7b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -928,12 +928,8 @@ static bool mp_check_pin_attr(int irq, struct irq_alloc_info *info)
 {
 	struct mp_chip_data *data = irq_get_chip_data(irq);
 
-	/*
-	 * setup_IO_APIC_irqs() programs all legacy IRQs with default trigger
-	 * and polarity attributes. So allow the first user to reprogram the
-	 * pin with real trigger and polarity attributes.
-	 */
-	if (irq < nr_legacy_irqs() && data->count == 1) {
+	/* allow the first user to reprogram the pin with real trigger and polarity */
+	if (data->count == 1) {
 		if (info->ioapic.is_level != data->is_level)
 			mp_register_handler(irq, info->ioapic.is_level);
 		data->entry.is_level = data->is_level = info->ioapic.is_level;
-- 
2.34.1

