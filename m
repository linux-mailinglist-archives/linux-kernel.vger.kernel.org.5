Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB52375A2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGSXVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGSXVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:21:53 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3B22103;
        Wed, 19 Jul 2023 16:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDrXR2rO5CMDCzaSzMa+HXOSYoqOvmV89aCPO9H+zcrNWnTN5ubXeNiy2bEwIjNaFgaTjeFd6Gr3ZvND34EfKpqPD+BDLAOobuIom+Kc9QBDVLYtPswft6MaILlEKMoYz0BYN/NZBxGrdPuSst0WNwY18/GFVBO+dCL/ID3s1gTnHKEy2YNstUzwNk+YcP+RrGKjIhNZNnegIjqMS1hzUOkq2bfhqgdlkqrUYLIdkhLgUVyxXrWomPRFpqCx8vO0w2Vu3j+Qe02C2kzpHkXDQQlT2AVIkBn/6DPRouwkyeWFMOHT+SbVjVOTQlyg7GabRLelz+Cnv0ROHK2Ii+PJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjCNKrhhNf0pmqvwTZRd9NA4wMpFYN1ufrYeBdf3TY4=;
 b=QdrkzXfHLCM3P8u6Dzy6HlLw7bWiE/gAg6jJaDGWaDtQnOI7FKxTcaOe5vuxJIusq7oTEB3IgEBZ7oeCZ272bdhZ2dpFbAtVUQocqji3P6+A/KOwKomhSO/7jvhs2gDyQ0Q3TgmZPkdvgC8ln6TKog3nGsDFdhpPgMCUnaPfc1zHonQsbzMH/YnE1wkpW9bH8Wz0OMBHL/iAfu46VW1Ap1TftrO5WWBwlav/IDe6U+mGeCwW48Abx9yLeLGzhlq53ib8ssDswZDKMUgsYufC+ioh1+DikPxW/eH8k4CBz0VKvNBpG/AnEbeDdU1w534tOuwlRNg7y5pnp6EqLa8UHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjCNKrhhNf0pmqvwTZRd9NA4wMpFYN1ufrYeBdf3TY4=;
 b=EVZKWxgkL04XXWGnfhMI5MfUcmthD84YA7oGhdwjaSkBb9+WJFtVXHBQumOSj4U5PidW3O279toVzpwUR31ATRJrrhSc8pLf1yw7MXcyAmPFrMbCwIlF9hahnwwsuMfDyEWs3uokOopwecusz1hpY59no2zvRnIUG042WVTl5t4=
Received: from BYAPR03CA0023.namprd03.prod.outlook.com (2603:10b6:a02:a8::36)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 23:21:43 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:a8:cafe::e1) by BYAPR03CA0023.outlook.office365.com
 (2603:10b6:a02:a8::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 23:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 23:21:42 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 18:21:39 -0500
Subject: [PATCH v6 2/8] x86/resctrl: Simplify rftype flag definitions
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
Date:   Wed, 19 Jul 2023 18:21:33 -0500
Message-ID: <168980889343.1619861.8836711283953792286.stgit@bmoger-ubuntu>
In-Reply-To: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 91472890-a00b-4cc3-5a6d-08db88aee94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IFqKvEPW4HWMnUQlHCqdMTIw1rHM2wUHYy/wZcuCdIFJWiZpDlvIkN2QK7jiSlmGGXjF02Xmmxh36wnI+3rXSUvDQonMh+sjD8pteWWTash1ZiuYsdXxhN0TxSJPMHWqOzEYPuicBBEg8MZcMgYqubLuCae9A/+75L8hRGd9JC+z5BMZBvq2rEvrdX6k+5ekUev62SSrGO9vHGORUm7BVO+sriX8KmWJam5uhfENXJ7Z9yMocn3JGp9L95YDFx+jAL+M8v3k3i7myQBIdGj33GZRzbqCfR5Uz7ntUDkk5XHsxJehuUFOcXopoqFrEMSY0ji7QyKqjHoYxIcSkD++ZETRRelWGdgIOiPQt2DWmRU9SYonWL1faSoA0tGjbvcBOG4GYwIGPHFcNRIpK1fOvFsmbfjyEXduSULJ2Xwwe3HF9wr3ll0MOJbhsZ/Fq8hnJ0edIllQnX56TGoSUgU4GnzFH1BVg5eMGWv5KpPxIlZbgDZyHhpAFXD30yEMIy6lWXiYxTbnhBDP+bGJQe9SlvcfQQQrgAtxM1f6mmh/ylqsrDxhaAAc03ouAMFyQ1wZ97mg5F051BK67flfvOxv6e0LTE4EjGl7kGU17anbhvkwYCakWflDfvzg8MZLWojkCU3oDnFgxuWsHyfSCxtPIJXf5ggq3uQeZzDbeCOkBvA8a81qaTrhvAY0BX6fBt/3p/57C+FeAlMmIdKXnKL2WRxP3siNG3g2FyoHcsB0cS1srk4iHH+Sf27hgSKrGyQSCFqN3TNAlHE1lfmCYd+LE2WRqCtC5vNkCe7+gubT80=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(81166007)(356005)(103116003)(82740400003)(33716001)(86362001)(40460700003)(6666004)(9686003)(110136005)(478600001)(2906002)(36860700001)(426003)(26005)(186003)(336012)(47076005)(16526019)(7406005)(54906003)(16576012)(8936002)(41300700001)(7416002)(70206006)(70586007)(4326008)(316002)(40480700001)(5660300002)(8676002)(83380400001)(44832011)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:21:42.1927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91472890-a00b-4cc3-5a6d-08db88aee94a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
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

