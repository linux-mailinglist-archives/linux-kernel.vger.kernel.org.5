Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B4977982D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjHKUIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjHKUIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:08:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA5630E7;
        Fri, 11 Aug 2023 13:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYNBFvoE7OKWKnHkiMcpepvoMDHl4pLTjOLgi7hxwqirBB1adx2PbjQEUtbQb77qUyg2vOAS5wGOkRZVlBFraM57RrH1gXQxBxYr3U9sevadlBSUzPmazLNIitPBkK7IiwYYUOFO38/zqy64yt/21MB8YcqIpw9Q6O4TyaKHFW+cVjiFcR8AEWFp8Mr6TD4E6Zg/nrWdE2A8Rird/2vjyJ4Bj8nMsGDAwAI0vzuMkYGTP+Qe1p/K+K0N5C6jgjCj1uaWBueDPQUO67QIUfwZWA2dICB5J4JDUGmROj/DQY4SMplO2tlyDdpwpxrJFKwV8VuoxT3LbLp+IrtQIpMBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZubyjA+9JDk/F+Y33G3p1KJngkD6RzG+M8qaQDR5pCU=;
 b=U9y5BcwZAa+L3ScQtCIB+98jZJVGCuIZDzAToOXnZCOylQJOyC8kjVmNc8Zc/CyyfwP4ziH4KY3qSFLFgLxfTnEMrEuDTq1k/9UXDz/7D2CBqUpWQounKTL+NBq16F12RLp03GTs+CObd1+vCmotHSMBzm4yX1wNWZvvn3UyIVyEwa0Mh+/fV07Z40kGWfp5gsyvIzmsBZ1BrSvqQwluxJjojr/jUqYgvO6BW6uxtMkhePVmfm8NVgmW7LkawOqpQrMc2vTjpernwtZjN1sSHnzbk6/XJqOt+LSgfaECEBKz/z00vPhgojYeCs96LY8oF9Z2MtoYfCdkLOhxl5jylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=csgroup.eu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZubyjA+9JDk/F+Y33G3p1KJngkD6RzG+M8qaQDR5pCU=;
 b=SvgpMsyCM5drPabg6wSFVBvFP2cv1CMGHHtfjWKtmLd1FrIveMqGkrXzX6AWE9FnjqMNK6K8CFT4DvMj2y76LKfo0FY0BfllB0NtydDIEmOnY1QNF3O9FspIQ0KIXVqFdugHzPwZwm6AScZhhXcr9GDmAFiN8cPP5KAvQC5t4mA=
Received: from MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::10)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 20:08:14 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::5b) by MW4P220CA0005.outlook.office365.com
 (2603:10b6:303:115::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 20:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 20:08:14 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 15:08:11 -0500
Subject: [PATCH v7 0/8] x86/resctrl: Miscellaneous resctrl features
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
Date:   Fri, 11 Aug 2023 15:08:10 -0500
Message-ID: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d91e5fa-74af-4341-f717-08db9aa6b211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnosHyRThcxKPHsPPHyRalkM3gyofNxcJ2yIu1GXXP6mPAw65L5uaNPYTIDOGHFSCE7JGxy6ExiYXIh5gm6LRr0MAzV1FzTnLNxdXPoBZql46Qht4GghTODpd0MuH+zO0BE+MEauDSyNSh+hWmPVG94q3/D6SVGBMUy6jUye/knDe/Stdy1WZUEwGnxx3GdI2htyLu0gDouSn3TJpmUF1wfzL84JBWuJWJvvVjNsXy6R57qIEbX+ailrkY1ZIK7x5znwkx7Rj0jSvsS1EschwktgbbKVxzb7uAYVIoq2d29uwBDDRRIfAodVvPecx6o2wOXY3ng3Teic1DCDpPIqrQhKcfXdGiHOrStOgFxxuIMbzqvGuBiB2sI2zNHqpeXHn+UpBXFWTCH6ZJ4aZtk9370F3kqk4luWxno+deAw6Q7t3HLd9d42BMeysfoA77g8KxQtQvP/BCUiO1u0lyyw9Wf6D6QYh3jmmAtUjWVVPqkj0RLKmlUefc3XjuMacDoWsyC18BtgnO70ZWRzyczF+6jwXI0TI4LGeyQ2e4H9uu7YGi3FCSaX1WmZsoM6yBq0HrUPpRy8ozt/ROIy5Vw/40QnNcqOhFuSJCAx3uh6MtYc5TdzZHjSafYLaBEIh2oZrGuEG3qfgysvLF6l3nvlB+6XT91tILr90Dm7BfLizGNfbPevaOALzKWkhmv5X5a4b2xwWkilRrO7nVNy8otD53x1Vg9jPs3UG26PwFgbT/mwpN0GEqIr8SPSQDHttIsDRwb7EAIqhrnWFh9VWQn067tyM1+D4oRd7ZQ2kH+4jRgo5u8yEtiLQnjOK/MadxSXZykL3nP1bptLgQd8zS4LTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(186006)(1800799006)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(54906003)(110136005)(16526019)(26005)(70206006)(336012)(478600001)(70586007)(103116003)(86362001)(426003)(47076005)(83380400001)(966005)(36860700001)(16576012)(33716001)(44832011)(316002)(41300700001)(7406005)(7416002)(4326008)(9686003)(356005)(2906002)(81166007)(8676002)(82740400003)(5660300002)(8936002)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:08:14.4265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d91e5fa-74af-4341-f717-08db9aa6b211
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series adds support few minor features.=0A=
1. Support assigning multiple tasks to control/mon groups in one command.=
=0A=
2. Add debug mount option for resctrl interface.=0A=
3. Add RMID and CLOSID in resctrl interface when mounted with debug option.=
=0A=
4. Moves the default control group creation during the mount instead of dur=
ing init.=0A=
5. While doing these above changes, found that rftype flags needed some cle=
anup.=0A=
   They were named inconsistently. Re-arranged them much more cleanly now a=
nd added=0A=
   few comments. Hope it can help future additions.=0A=
---=0A=
v7:=0A=
   Changes since v6:=0A=
   While moving the default group file creation on mount, I also moved the=
=0A=
   initialization of default group data structures. Reinette suggested to m=
ove=0A=
   only the filesystem creation and keep the group initialization as is. Ad=
dressed it now.=0A=
   Added a new function rdt_disable_ctx to unwind the context related featu=
res.=0A=
   Few other minor text changes.=0A=
=0A=
v6:=0A=
   Changes since v5:=0A=
   Moved the default group creation during mount instead of kernel init.=0A=
   The rdt_root creation moved to rdt_get_tree as suggested by Reinette.=0A=
   https://lore.kernel.org/lkml/8f68ace7-e05b-ad6d-fa74-5ff8e179aec9@intel.=
com/=0A=
   Needed to modify rdtgroup_setup_root to take care of this.=0A=
   Re-arraged the patches to move the default group creation earlier.=0A=
   Others are mostly text changes and few minor changes.=0A=
   Patches are based on tip/master commit 1a2945f27157825a561be7840023e3664=
111ab2f=0A=
=0A=
v5:=0A=
   Changes since v4:=0A=
   Moved the default group creation during mount instead of kernel init.=0A=
   Tried to address most of the comments on commit log. Added more context =
and details.=0A=
   Addressed feedback about the patch4. Removed the code changes and only k=
ept the comments.=0A=
   I am ok to drop patch4. But I will wait for the comment on that.=0A=
   There were lots of comments. Hope I did not miss anything. Even if I mis=
sed, it is=0A=
   not intentional. =0A=
=0A=
v4: Changes since v3=0A=
    Addressed comments from Reinette and others.=0A=
    Removed newline requirement when adding tasks.=0A=
    Dropped one of the changes on flags. Kept the flag names mostly same.=
=0A=
    Changed the names of closid and rmid to ctrl_hw_id and mon_hw_id respec=
tively.=0A=
    James had some concerns about adding these files. Addressed it by makin=
g these=0A=
    files x86 specific.=0A=
    Tried to address Reinette's comment on patch 7. But due to current code=
 design=0A=
    I could not do it exact way. But changed it little bit to make it easy =
debug=0A=
    file additions in the future.  =0A=
=0A=
v3: Changes since v2=0A=
    Still waiting for more comments. While waiting, addressed few comments =
from Fenghua.=0A=
    Added few more texts in the documentation about multiple tasks assignme=
nt feature.=0A=
    Added pid in last_cmd_status when applicable.=0A=
    Introduced static resctrl_debug to save the debug option.=0A=
    Few minor text changes.=0A=
  =0A=
v2: Changes since v1=0A=
  a. Removed the changes to add the task's threads automatically. It requir=
ed=0A=
     book keeping to handle the failures and gets complicated. Removed that=
 change=0A=
     for now.=0A=
  b. Added -o debug option to mount in debug mode(comment from Fenghua)=0A=
  c. Added debug files rmid and closid. Stephane wanted to rename them more=
=0A=
     generic to accommodate ARM. It kind of loses meaning if is renamed dif=
ferently.=0A=
     Kept it same for now. Will change if he feels strong about it. =0A=
=0A=
v6: https://lore.kernel.org/lkml/168980872063.1619861.420806535295905172.st=
git@bmoger-ubuntu/=0A=
v5: https://lore.kernel.org/lkml/168564586603.527584.10518315376465080920.s=
tgit@bmoger-ubuntu/=0A=
v4: https://lore.kernel.org/lkml/168177435378.1758847.8317743523931859131.s=
tgit@bmoger-ubuntu/=0A=
v3: https://lore.kernel.org/lkml/167778850105.1053859.14596357862185564029.=
stgit@bmoger-ubuntu/=0A=
v2: https://lore.kernel.org/lkml/167537433143.647488.9641864719195184123.st=
git@bmoger-ubuntu/=0A=
v1: https://lore.kernel.org/lkml/167278351577.34228.12803395505584557101.st=
git@bmoger-ubuntu/=0A=
=0A=
Babu Moger (8):=0A=
      x86/resctrl: Add multiple tasks to the resctrl group at once=0A=
      x86/resctrl: Simplify rftype flag definitions=0A=
      x86/resctrl: Rename rftype flags for consistency=0A=
      x86/resctrl: Add comments on RFTYPE flags hierarchy=0A=
      x86/resctrl: Unwind the errors inside rdt_enable_ctx()=0A=
      x86/resctrl: Move default control group creation during mount=0A=
      x86/resctrl: Introduce "-o debug" mount option=0A=
      x86/resctrl: Display hardware ids of resource groups=0A=
=0A=
=0A=
 Documentation/arch/x86/resctrl.rst     |  21 ++-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |  71 ++++++--=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 230 ++++++++++++++++++-------=0A=
 3 files changed, 251 insertions(+), 71 deletions(-)=0A=
--=0A=

