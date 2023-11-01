Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143447DDE65
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjKAJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjKAJ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:29:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3098;
        Wed,  1 Nov 2023 02:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0wuKQoItWuR5oUJJmLCu4Uyyr5yOXrK9cPqXzATZPWm8sPxKKAJi3T7hY4mh9m201NYcOFG+KFYy81yuOdTxWGlDUn+EOJW0/IYx9yKS+vYAVXBXDiRN/zO7azYz00TJPa0IBEbQ5rYGf8xMdLyA+46ZGuQlrkBVKozd58+ol+FSc3A3ydthuys9OwYHoy7gzhwuSBmesXdqhUNd33OCzwlfq0ToAGKlxNTqTYcbS/GDBW3Zhwz5WTpAbrkX3M4L1esU41TcwV+u6SX4oVPJSxvvhqIu3/fj/icQEYzrU8VKN82xvx+wtn3YmXJhkqPdTb8hD2S020d6PcEyVK6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1a718EGSuvKUfXkIabojU6llpcv7CWBa/dcOub5YHK0=;
 b=MS4jXpBwSH+5uVxItj9tJbIBa5tHZm2b6PEmZdWELEPC3sKajLtwdhSrXcUqxrnRVINaeCQFdu5qRnDzhXif3d3gpW/zm1sHBlNA/c+D1SaQ3UDSJFFKMOKa2j5ZP3ube2evInjiKKpHwlyLaoIEpIWmAx/Jr4YrmPjVVWctX/0wseGOMMyhdvzR2OXdi0ou0lQ70o/i9MnFPMD7yFfgPtQVqV7bXogiFi2azrC/6fQRX+x9hFIGPa7z/Efpyj51mGhfkwirXkK68EXRo8f7LwfIbFJJYyfkua5/AZmMeO4u5bmY+Jt6RHjBKCVnjDcRVecvIwAE8g3IrxYF6bOpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=micron.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=micron.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1a718EGSuvKUfXkIabojU6llpcv7CWBa/dcOub5YHK0=;
 b=Jzs6oelGzQF0HMm+J22qyaA+wGS8nebQISa7CjyT7vLSSIp4xvb8y4z3syXN7I7vN2+W6huY6MnepAyiQ1AS5D6SkXRyZJkkAbAbVnX5lJ3XAepDw/Mydq5sp3E1H2H4BN6KYSxBQmn7q+CN6fgb5a5cVPSHYFFgnmuA8mkrMMQap0m8KzrlaxI2oYvaNuvyRUEajEFaBUOp5i1co4onYN3eqyimnH2AfoIhNylvxeD4wmoyZj8nKFmLkqQUGkbeVRWSmZ6HJ2jCzZVXiG5pPua0DvLRsfPdj8QHeJhDuerx9l44Ff8kBZJ1XPXJtTSodQ5RY53DCajJ78ovYDIYfA==
Received: from PH0PR07CA0112.namprd07.prod.outlook.com (2603:10b6:510:4::27)
 by BY1PR08MB8574.namprd08.prod.outlook.com (2603:10b6:a03:527::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 09:29:30 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::eb) by PH0PR07CA0112.outlook.office365.com
 (2603:10b6:510:4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 09:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 09:29:29 +0000
Received: from BOW36EX19B.micron.com (137.201.85.154) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 1 Nov
 2023 03:29:28 -0600
Received: from VENKATARAVI-LAP.micron.com (10.70.32.235) by
 RestrictedRelayBOW36EX19B.micron.com (137.201.85.154) with Microsoft SMTP
 Server id 15.2.1258.12 via Frontend Transport; Wed, 1 Nov 2023 03:29:24 -0600
From:   Ravi Jonnalagadda <ravis.opensrc@micron.com>
To:     <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <aneesh.kumar@linux.ibm.com>,
        <apopple@nvidia.com>, <dave.hansen@intel.com>,
        <gourry.memverge@gmail.com>, <gregkh@linuxfoundation.org>,
        <gregory.price@memverge.com>, <hannes@cmpxchg.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mhocko@suse.com>, <rafael@kernel.org>,
        <shy828301@gmail.com>, <tim.c.chen@intel.com>, <weixugc@google.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Date:   Wed, 1 Nov 2023 14:59:23 +0530
Message-ID: <20231101092923.283-1-ravis.opensrc@micron.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87il6m6w2j.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <87il6m6w2j.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|BY1PR08MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 26538c5a-04fe-41b9-d4a3-08dbdabd0c97
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlpJAwXB4y+SoEfQZ7HQFpJK9OhxNX1UDyE9g9hEjdHmaPr78wHCu0ZIlr7rSksTGHGa9nuvDA/yKYWI6ZQ2JtCyRtJn/l9hJxup4lvU8//vPsKlvAxgav/4DMfUvIswj5AhfrrWbwqkaTwE+8YNtri0KpCxbZSnsxlwqOoIIa+mBt0lMH9CWYWozfvRJW6om4l/Q9xzuheEYO90XXabUuCfx3tmQd/5sFOtoMTVURWr8RCsifMyPVwc2MOn0xnbDv+S5VqHU2KpFQbKtsS7vuPJXvtYZ3/ZGSWpnFtys4A05qfLSbp83aK3Th4nDQsC0gCxGdQWvbtq5y1WiMdPtc8wtCtW/SkSlWRDvM+vRHCZgJNDY27p70AmDmWOaqZhcT7tTtAobai6Vc2SgwzsplrxcD+xbM9CTQ/cBbJu9RGmrcp/cjT8DgsHVS1PlkN3P4KJbyKjDMVIlqlkFcj26WVE7L2xKQrWojCezBAh0HrSkSUIlvwgGVjj52/S433XsiYMP54TBx1BRomEb7LqCtZe2gVJiacMGFtCeJ4Q8DZlXan6nEU+NN3FSOtt3VE/TT3EkgBlb5kv/wSicjFX7/RWOQsOKZwOA/otegtgIqXjq8gcbgVDXDMXpL3+yBT1BiSx8zEZqg9X/TOCcaGQdp480yLu0zAm3ejcLvt+ZIyJk+Kin0BRC8IwdaVdQA9lXZnoUtiQpDtxkN1UhYYG2xNM1DMEooevKzaCG5koc2iFZfp0uAjLNcSJ+Ol0n+GTWlM664/naILZwTmiEhXkxA==
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(40470700004)(46966006)(36840700001)(47076005)(36756003)(86362001)(82740400003)(1076003)(26005)(70206006)(40480700001)(41300700001)(478600001)(7696005)(8676002)(8936002)(4326008)(6862004)(2906002)(83380400001)(2616005)(40460700003)(426003)(70586007)(5660300002)(316002)(54906003)(356005)(7416002)(36860700001)(7636003)(336012)(16393002);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 09:29:29.6914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26538c5a-04fe-41b9-d4a3-08dbdabd0c97
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR08MB8574
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Tue, Oct 31, 2023 at 04:56:27PM +0100, Michal Hocko wrote:=0D
>>> On Tue 31-10-23 11:21:42, Johannes Weiner wrote:=0D
>>> > On Tue, Oct 31, 2023 at 10:53:41AM +0100, Michal Hocko wrote:=0D
>>> > > On Mon 30-10-23 20:38:06, Gregory Price wrote:=0D
>=0D
>[snip]=0D
>=0D
>>>=0D
>>> > This hopefully also explains why it's a global setting. The usecase i=
s=0D
>>> > different from conventional NUMA interleaving, which is used as a=0D
>>> > locality measure: spread shared data evenly between compute=0D
>>> > nodes. This one isn't about locality - the CXL tier doesn't have loca=
l=0D
>>> > compute. Instead, the optimal spread is based on hardware parameters,=
=0D
>>> > which is a global property rather than a per-workload one.=0D
>>>=0D
>>> Well, I am not convinced about that TBH. Sure it is probably a good fit=
=0D
>>> for this specific CXL usecase but it just doesn't fit into many others =
I=0D
>>> can think of - e.g. proportional use of those tiers based on the=0D
>>> workload - you get what you pay for.=0D
>>>=0D
>>> Is there any specific reason for not having a new interleave interface=
=0D
>>> which defines weights for the nodemask? Is this because the policy=0D
>>> itself is very dynamic or is this more driven by simplicity of use?=0D
>>=0D
>> A downside of *requiring* weights to be paired with the mempolicy is=0D
>> that it's then the application that would have to figure out the=0D
>> weights dynamically, instead of having a static host configuration. A=0D
>> policy of "I want to be spread for optimal bus bandwidth" translates=0D
>> between different hardware configurations, but optimal weights will=0D
>> vary depending on the type of machine a job runs on.=0D
>>=0D
>> That doesn't mean there couldn't be usecases for having weights as=0D
>> policy as well in other scenarios, like you allude to above. It's just=0D
>> so far such usecases haven't really materialized or spelled out=0D
>> concretely. Maybe we just want both - a global default, and the=0D
>> ability to override it locally.=0D
>=0D
>I think that this is a good idea.  The system-wise configuration with=0D
>reasonable default makes applications life much easier.  If more control=0D
>is needed, some kind of workload specific configuration can be added.=0D
=0D
Glad that we are in agreement here. For bandwidth expansion use cases=0D
that this interleave patchset is trying to cater to, most applications=0D
would have to follow the "reasanable defaults" for weights.=0D
The necessity for applications to choose different weights while=0D
interleaving would probably be to do capacity expansion which the=0D
default memory tiering implementation would anyway support and provide=0D
better latency.=0D
=0D
>And, instead of adding another memory policy, a cgroup-wise=0D
>configuration may be easier to be used.  The per-workload weight may=0D
>need to be adjusted when we deploying different combination of workloads=0D
>in the system.=0D
>=0D
>Another question is that should the weight be per-memory-tier or=0D
>per-node?  In this patchset, the weight is per-source-target-node=0D
>combination.  That is, the weight becomes a matrix instead of a vector.=0D
>IIUC, this is used to control cross-socket memory access in addition to=0D
>per-memory-type memory access.  Do you think the added complexity is=0D
>necessary?=0D
=0D
Pros and Cons of Node based interleave:=0D
Pros:=0D
1. Weights can be defined for devices with different bandwidth and latency=
=0D
characteristics individually irrespective of which tier they fall into.=0D
2. Defining the weight per-source-target-node would be necessary for multi=
=0D
socket systems where few devices may be closer to one socket rather than ot=
her.=0D
Cons:=0D
1. Weights need to be programmed for all the nodes which can be tedious for=
=0D
systems with lot of NUMA nodes.=0D
=0D
Pros and Cons of Memory Tier based interleave:=0D
Pros:=0D
1. Programming weight per initiator would apply for all the nodes in the ti=
er.=0D
2. Weights can be calculated considering the cumulative bandwidth of all=0D
the nodes in the tier and need to be programmed once for all the nodes in a=
=0D
given tier.=0D
3. It may be useful in cases where numa nodes with similar latency and band=
width=0D
characteristics increase, possibly with pooling use cases.=0D
Cons:=0D
1. If nodes with different bandwidth and latency characteristics are placed=
=0D
in same tier as seen in the current mainline kernel, it will be difficult t=
o=0D
apply a correct interleave weight policy.=0D
2. There will be a need for functionality to move nodes between different t=
iers=0D
or create new tiers to place such nodes for programming correct interleave =
weights.=0D
We are working on a patch to support it currently.=0D
3. For systems where each numa node is having different characteristics,=0D
a single node might end up existing in different memory tier, which would b=
e=0D
equivalent to node based interleaving. On newer systems where all CXL memor=
y=0D
from different devices under a port are combined to form single numa node, =
this=0D
scenario might be applicable.=0D
4. Users may need to keep track of different memory tiers and what nodes ar=
e present=0D
in each tier for invoking interleave policy.=0D
=0D
>=0D
>> Could you elaborate on the 'get what you pay for' usecase you=0D
>> mentioned?=0D
>=0D
>--=0D
>Best Regards,=0D
>Huang, Ying=0D
--=0D
Best Regards,=0D
Ravi Jonnalagadda=0D
