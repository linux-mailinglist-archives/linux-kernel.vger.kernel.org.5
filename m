Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147F975A2B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjGSXVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGSXVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:21:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958DC172D;
        Wed, 19 Jul 2023 16:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJaB1n2HxlJnC8YHPREzYl67e4CH1I+vCX0aNgXOliGfqmw1a3RMyXl5zgVzcI3IcPRFSxcVCOf7VHiIcqAp0ofBFSq0Tx5Dlwhd/75LmaikZROI3BhtcHCRgR1QIblN5M2W+mGEmfIw3PvH6Z96DwRc41waSzbSj/leHC0EwDIEwR+HIryT1DJ9fSv1R4nwXiJVimHYh2DvDvBp5TrOCBrKf+4yXQwHjwYyXC6Z3jJvCXvUpn4c8Ir9mH2CCJr6RRIk3iWBP7uaAq+S1v/E9XWJ8TR3n/yZrYFMjL1yozNBDZf98/4WvyRZzE4H9abQOfTR1dnHD1eg0Rz93ax9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzo0pwBTcd8NuQT1oNJLgK42ergAptIW6T22GFp0oJE=;
 b=n+ToD5+iwMs8RLGfpdk8Y71351+dYFJqKlDThprDUzX3PjCZ+SMyoWfNgQ5KtCCcCvhCtH40SS4ABRLw4j7hR1gcvqXCxWFRtlwfeYCU3VZE+5W6/c8/GwRc8fjCA3f+pcMmi4zkaaG8kPkB1Jd2WcFdugzvRrzfyr7lyHrIzPZqG0MaALVrn6m3O9ibUP759DyNujyWxO/+N11jHlQvkHGeSitNh2MbT/1sdGYTCbZf6VVVOpUnf+vBi85deAoiCMfYhh30ceI/sTBWnzl0o/v0yslBwfkKq0ODWp0WfB5IT8Ja2lflaPB1/IEj9xwCym0Of6R6cJhSw7mMOW8QWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzo0pwBTcd8NuQT1oNJLgK42ergAptIW6T22GFp0oJE=;
 b=ef8GZpHs2EAstHNlA0DcDj9kLKVY4+MPfDDxbSqxUXRlVwgn1hPbGOHX8YBdQvLUuvfTqtH2Wlw52fcJhmp7ostaI3loBmtz0Pz4bd4Frtm613obAuuWm+CMO3R1Nrnt/VPAn9n1CmeXq1xorY5IWbBArmLZMaRiH4fNF8HOTtM=
Received: from DM6PR13CA0051.namprd13.prod.outlook.com (2603:10b6:5:134::28)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 23:21:17 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::93) by DM6PR13CA0051.outlook.office365.com
 (2603:10b6:5:134::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 23:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 23:21:16 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 18:21:13 -0500
Subject: [PATCH v6 0/8] x86/resctrl: Miscellaneous resctrl features
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
Date:   Wed, 19 Jul 2023 18:21:07 -0500
Message-ID: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|BL1PR12MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a0d827-45ea-4829-dc08-08db88aeda0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUtj1rJ3WTde65s3/VWLKvasTZUuWCQQbOMFM7BYjcEQLWk+atllh5VGARsZDpJMHKB+CkZZRc/9elOE1eH0scurLy9hJA900J7ahBA1INYBwoeeodbzHWdU84SHwnExb85IQcCavnVoSBEIUtH3YZ3SIKPnlaFla8uiMWJsZbCkkw0dTZzpTdBTkPqv1JtjsnP6R7dO09HE/OtzEzCFr3oJySaLsvWs4HOw76O+Mkl5BdkhAbpyhi6Wa0knD6mYjxyzwSETmQdCY+hwzdgHyELOxfj/i38igO36AlujYeY6QNM7PpDRIUUL6Vrx3b8+zKNx1epjBnfieDtXS0TCJpYm17Shgu841qmEtxfo/3N/4wBIytpoRq+4OZvcky3tmoKB2mnHZjTHjzB1LLKZtER4C30F7C8n1FfbfVUCUk4Ojfi69fx7jx1i6JWK53+PmFbIrbAzB37tDJdRNjjIAm/nCqZQyzRK5DAgX0aYQzsh3LzgiQwNidDRwPgykN1mZxmAPoQyDWUM1xYOE1qiiMYLHKh32o4kxyI30OlKaLqGfmagMadoMys5oAp+2aD11dwTS9lE7Wmb4fpMMkjZ4UA6JVZvSxNYytwJWp81VYGNI1zvFL/P93bF/mWYAac3BJPa8ZxXXfWnCwyin0NKpWviYH8b3KW9ubcm1WYTw8LEsSEUUUqKz0wss/w28QonZo58ApS9/9HdghAsvZwDXcrdZIhfcX+R7PGdIADG96WyVC/eeK9SnmOpyPCkWnQLahptGefw+Jsq3+0syqOUS/aIlmk4fAVdoJFKSonqXUYd3dx2M4Cj3qEWEsvJKeEJyRP2trdLRI+I3+VLppUcsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(7406005)(8676002)(7416002)(16576012)(4326008)(44832011)(41300700001)(5660300002)(82740400003)(103116003)(8936002)(316002)(47076005)(426003)(83380400001)(9686003)(70586007)(81166007)(356005)(70206006)(2906002)(86362001)(110136005)(40460700003)(33716001)(54906003)(478600001)(16526019)(6666004)(36860700001)(966005)(186003)(26005)(336012)(40480700001)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:21:16.6369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a0d827-45ea-4829-dc08-08db88aeda0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
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
=0A=
Babu Moger (8):=0A=
      x86/resctrl: Add multiple tasks to the resctrl group at once=0A=
      x86/resctrl: Simplify rftype flag definitions=0A=
      x86/resctrl: Rename rftype flags for consistency=0A=
      x86/resctrl: Add comments on RFTYPE flags hierarchy=0A=
      x86/resctrl: Unwind the errors inside rdt_enable_ctx=0A=
      x86/resctrl: Move default control group creation during mount=0A=
      x86/resctrl: Introduce "-o debug" mount option=0A=
      x86/resctrl: Display hardware ids of resource groups=0A=
=0A=
=0A=
 Documentation/arch/x86/resctrl.rst     |  21 ++-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |  70 ++++++--=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 217 ++++++++++++++++++-------=0A=
 3 files changed, 236 insertions(+), 72 deletions(-)=0A=
=0A=
--=0A=

