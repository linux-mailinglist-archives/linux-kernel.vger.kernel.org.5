Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E245F77983F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjHKUJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbjHKUJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:09:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E54B30FF;
        Fri, 11 Aug 2023 13:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+bp3fXyqCw10ZW5/w8MIodCPuJKrrvdF53hjmDXDSVoLIaeoG2lpbI24uMHHb9yQ3bQkiF9jq30nM13uKnEkCgQ0WY6yZ6VLLoatCtdbygdEbK7dqMWmXDomk5M3RaWGMMcQhUpPQG0BX0gF8eyWaHd77ZDmhtCOCQNhwFfCeFWjscKFu5pLzyUq5V92fGFNTAST7Jn4KxvTWgeXzJact+yuHVjIOMAcmcfCnFCUkvAhs+ISDlWfFEFTu95rczbc3fw9LYhG+OS8eRn3kra6qQum3YioWam5GcVIMN3pPJ81LR/AValq56mLvBqt4mkuhC3wRK9APS3iW1dT1cRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8el2da/9RO2c6hM6AU3CGQgm/f4ArVbL9fHz+gLBZU=;
 b=hhi/5KiGKjYcVUT1Bj8jyLDH7X5fHIHxHuDKpqzKtheE2oqc3R57VuXnUcZFEEkAtnrCIX1XkYpRB0rLmlLSkCaxOk8U6oCMQmP0SXkTGRDs+Ut83Y6eHn7m4w59zX1PhwzdS2gtBtmiCmD2/+yFRgREXkeRepvEsmPTH3TC4p49Pd3CCI+3qbzS1grbQHId5ZmAWvoY4dORHhnp9bWyKM8GPubh52Vj2yCGcewQXBoJcQ5aDy3jwrm1RHEZjHfPaVajDnR0ND5Gl9O2MGSmYFXBVcquEK4wO64c5q2rBdXvvp1CqEvx6BwFZmewxFKmeuic7C5KLE0snTOsPFkvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=csgroup.eu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8el2da/9RO2c6hM6AU3CGQgm/f4ArVbL9fHz+gLBZU=;
 b=P2E474/jnqtM2/CuFvVrzUdveAp2K2BsefhEXGic1sB7D0RAWZzbQawLvVENz7vdRDSHNlSH8aRkq0in5DAo1ipVYNRB3umSSqfC+rZlEJqhJZsA/37th0p/d58Qki7J9pZVJIdW7Xc1c1wW9HBB8pVctzKvc7K6yIfidjowUL4=
Received: from MW4PR04CA0256.namprd04.prod.outlook.com (2603:10b6:303:88::21)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 20:09:35 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::92) by MW4PR04CA0256.outlook.office365.com
 (2603:10b6:303:88::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 20:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 20:09:34 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 15:08:39 -0500
Subject: [PATCH v7 2/8] x86/resctrl: Simplify rftype flag definitions
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>, <babu.moger@amd.com>
Date:   Fri, 11 Aug 2023 15:08:37 -0500
Message-ID: <169178451786.1147205.17416534865851883140.stgit@bmoger-ubuntu>
In-Reply-To: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d58944-47ba-4a67-1806-08db9aa6e200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hcUzEqBjQyX/US9pHIt1DFet3ho2/P1Di9T6KLUH+SgmOvyOObJ2mdnE0nGXOw52Dda4tavjXTPkfFCRl1JOFtuMOYrOvK5WM9ZpqXyHZG6Qj0vz3UfmIc9x4hk4hUoRXKOngS2nxPXZvtmikfpTy5JfG3UXWb3e5HNvLTXgdtZVF/aad7vWuNuTqvY1kAtPgXdArnElBxMrXeb+tCM9z2OEcYuRRbqZing8xejlAoc9nBxKCspMtrWfdQ7TPQ+8ktE9nqcoDjVb1IvyDXqztlpc7Ee/Wb4sjHzkCHUFR+L9Gogj0+xjPov7XfoqnNI/7O8FjYq6VzCcfSk9RSSgOmay1rzJb2otTl5lcsSpA4/BxYZEmydCPSoqqKoow1KcunqWpi5KK+XqXBU6RAl/QcrOe3LAysnHTlB6uhsHNC3+vFya6WZ3MQSCNKgRGtJKLjik9Yr0azAie9c/4JTheKr2YNvw+k6zUNDXMSh7z8MsSi6vvtOHdpDJsmar56/WYdA/9ZCFEG2YYKRZupWy+0r93qtVhlbUrmxyqrwmgY6gGBt0OXg+ZS3qnZV9zktoeOLS5Zabw7LHmFRD9my3zjX/Uti5fkDcWobtGAfebVwX90gPs4nwIvuUScujtcXscGp8oQ8tQ9mRo68PjLUB1i1B/kGjrC3GUkxCXItpcmbaY1StkcHnsSqa0sR4EzAi1AUnRsDTyye2UbkSZtRpL4MHbEW6096N4PPYKzPW09jPKw3B9v4+iUPxOh+HjDCUm1G8J5DVvzTWbn8cuDZ2kBHuB1I84UEy5VZPSum8oHw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(376002)(136003)(346002)(396003)(451199021)(186006)(82310400008)(1800799006)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(336012)(70206006)(26005)(54906003)(478600001)(110136005)(103116003)(70586007)(16526019)(47076005)(36860700001)(83380400001)(426003)(44832011)(8676002)(41300700001)(33716001)(7406005)(316002)(4326008)(9686003)(2906002)(7416002)(86362001)(16576012)(81166007)(5660300002)(82740400003)(8936002)(356005)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:09:34.8400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d58944-47ba-4a67-1806-08db9aa6e200
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rftype flags are bitmaps used for adding files under resctrl=0A=
filesystem. Some of these bitmaps have one extra level of indirection=0A=
which is not necessary.=0A=
=0A=
Make them all direct definition to be consistent and easier to read.=0A=
=0A=
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>=0A=
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>=0A=
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    9 +++------=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    6 +++++-=0A=
 2 files changed, 8 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 85ceaf9a31ac..62767774810d 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -243,12 +243,9 @@ struct rdtgroup {=0A=
  */=0A=
 #define RFTYPE_INFO			BIT(0)=0A=
 #define RFTYPE_BASE			BIT(1)=0A=
-#define RF_CTRLSHIFT			4=0A=
-#define RF_MONSHIFT			5=0A=
-#define RF_TOPSHIFT			6=0A=
-#define RFTYPE_CTRL			BIT(RF_CTRLSHIFT)=0A=
-#define RFTYPE_MON			BIT(RF_MONSHIFT)=0A=
-#define RFTYPE_TOP			BIT(RF_TOPSHIFT)=0A=
+#define RFTYPE_CTRL			BIT(4)=0A=
+#define RFTYPE_MON			BIT(5)=0A=
+#define RFTYPE_TOP			BIT(6)=0A=
 #define RFTYPE_RES_CACHE		BIT(8)=0A=
 #define RFTYPE_RES_MB			BIT(9)=0A=
 #define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 8c91c333f9b3..2f1b9f69326f 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -3242,7 +3242,11 @@ static int mkdir_rdt_prepare(struct kernfs_node *par=
ent_kn,=0A=
 		goto out_destroy;=0A=
 	}=0A=
 =0A=
-	files =3D RFTYPE_BASE | BIT(RF_CTRLSHIFT + rtype);=0A=
+	if (rtype =3D=3D RDTCTRL_GROUP)=0A=
+		files =3D RFTYPE_BASE | RFTYPE_CTRL;=0A=
+	else=0A=
+		files =3D RFTYPE_BASE | RFTYPE_MON;=0A=
+=0A=
 	ret =3D rdtgroup_add_files(kn, files);=0A=
 	if (ret) {=0A=
 		rdt_last_cmd_puts("kernfs fill error\n");=0A=
=0A=

