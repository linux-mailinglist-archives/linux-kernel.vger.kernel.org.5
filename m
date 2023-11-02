Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AD17DEF08
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345775AbjKBJgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345797AbjKBJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:36:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F0123;
        Thu,  2 Nov 2023 02:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlB8RKUm5QEc7UJdVvK/cG54kCK/m3yaGYxDq12RzyJL8LaGO2pKrSPl8JlWh/LoolEaPGRoZ14f7uhtGTYY3XbHP1umz/KEjxGEWO1kNeJ/QNi+gCGhd+OBtDOFDDjlN9aHEuQSAnmYdD+QRvRAt4wTeNjK9sivF/h9ToRCqOCBcyWJiwEcATBSNttbCjIpeFj2yxXhNydYp3+usB45tLF+E4nYQKuarTU+q+D2D20+H4n8qFfjOwOGOZ6Uc8mwkGbGSeTQ6NiKd0REGU4hUU7Wk7K+zAsB/+KDE1l4tfZnhlfqUzNPo092yMr3YKW7amoj954E+52ecjCDNq0C5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pquRgceUHQEpluTkrmopiYyjq4xjUSGvH/6ZsJJQr4M=;
 b=SeA56GwUWSelYDQWQIins/ac0U15zBwCVT8DLFE62Yr3hokqCmAL6uD3NzXdhQbsklW74Q/FX8W3UP0uZda78+fXFUIYcon1BUO05J1Ntw/K9YyfgRGiqngZaNSYw5PI8fXjH9PhXZxcioYeum1QV/Dh/udds4M7uCqPHrKkioliSv00135ZmeSI8jyrdc+8G6a0Lb7rg+jr1xgNal9z6LXS5GKZ6axqFJ5nQ0daKCmIrlWYarv3l69C4IfOtBichl5kldDcA1EahqLrBlfEwWOiSAJlY9T8sVGtSkohmrc9dWZdqOdTWfbKVoUEpdXviJUg7x//K/afa9lAljhZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=micron.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=micron.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pquRgceUHQEpluTkrmopiYyjq4xjUSGvH/6ZsJJQr4M=;
 b=lEJQuqQbZDVyGDl4jTeQzRdsi3x+AxKAxcu6MJ6Rk3Got/wIMaiAaz9nlL3SlNIhpyPh8N8YY/tu7qW8ZNJgFAplOeojjc5U3OgTCEL7dqQajHhZf+/LGS9I9yoU+o2FtMHAKA5FUyjhdABrqdpMhp2tYW6WsMhJhgfs6Ls7G9qEMwQH+ploeRRbWvXNxsso+7DgBlYqtazBtWl7lwHY946KZn8u+jr4H43DvX2vE/6U30eMshSZXiasBFi4USDwN8dOhqbd/YIA6K8HMPOe+TUBZqR6EdzuhPtZMMZve5A2G7iOna/LiADC2H/GHmlG9vXYMM5ECgD0ziz6VMUSWQ==
Received: from MW4PR03CA0001.namprd03.prod.outlook.com (2603:10b6:303:8f::6)
 by BLAPR08MB6884.namprd08.prod.outlook.com (2603:10b6:208:30d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 09:35:51 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::bc) by MW4PR03CA0001.outlook.office365.com
 (2603:10b6:303:8f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 09:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 09:35:50 +0000
Received: from BOW36EX19B.micron.com (137.201.85.154) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 2 Nov
 2023 03:35:49 -0600
Received: from VENKATARAVI-LAP.micron.com (10.3.99.248) by
 RestrictedRelayBOW36EX19B.micron.com (137.201.85.154) with Microsoft SMTP
 Server id 15.2.1258.12 via Frontend Transport; Thu, 2 Nov 2023 03:35:44 -0600
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
Date:   Thu, 2 Nov 2023 15:05:42 +0530
Message-ID: <20231102093542.70-1-ravis.opensrc@micron.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87a5rw1wu8.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <87a5rw1wu8.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|BLAPR08MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad04d71-4ffa-4079-5d79-08dbdb871a12
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLbthI9v9fXjYMs4boDz1xzYsb2R1RnNFYv9zPFAtIGhF16zi7u6oRulvuZV1RTEUukF731bjXhWOJcsglWF8isxQaVsni5JBcEQ2luJzFdfZO03bD/thUIGDfnJcZWWV5MOAFv9Q7pcbuikk8MLgmHOVQjEv9thmcES7UAB39JyBZBqn04Zn7LZiGabO6eF/dEFsaKyz6TlTwxC87hpXSaHeSLIRHtP5sUuTfbKygUBiiDjHlnrkJ+oOrNkDXPtrFkaBP/BCpDuh0p6rDCIr/Agg/4+UQlBhvKKEKJVGStAwXy5sFfGH/0XSsGPyYShSmGPrWYZg9hDwJHmpGOjKopm5p8SrLJoeqOkk72cPhjGkl6oev1yCNlcWB/VEUZj/sfZ+s56TD8ekwlzVSiG5LLHtA8JYkAEm8DiTBOa7R3kAKObmH5kS4B8r8KBYr8I3gq/QujmEEflbA2Zwg2F4mlgZetsxAg8H87LXTKLacVfRX/fMZ/Im7esuobJueNcoru9z0cNwqBebRLyyr3U5mNcI1dR62wlHUH1HjEqZ9eJ/WcMo7PHCal0A7Zam7q1pEdVFLDp2UOXlpOMEJuumuINVZbVHgcGOFDkBK38wBAJgAbDpRc0tbWWw1hO05d4l8CXjU78pv9pX8P7UN4xFrcxjVuKktj8dGoP5PoFKZFO/WjOluikJd8qQUrha0NZyD8Q/yBnH8ep5uYA6QdWeBSiQbxYLuMpSz1L27/3L9Kc5u7Pek6kFcoXbrhQkgaE4oVrgedp01Zfy+seC5YFFA==
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(40470700004)(46966006)(36840700001)(26005)(36756003)(1076003)(54906003)(316002)(70206006)(70586007)(6862004)(8676002)(4326008)(336012)(8936002)(2616005)(478600001)(426003)(5660300002)(40480700001)(36860700001)(47076005)(7416002)(2906002)(7696005)(356005)(40460700003)(41300700001)(7636003)(82740400003)(66899024)(86362001)(16393002);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:35:50.6442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad04d71-4ffa-4079-5d79-08dbdb871a12
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR08MB6884
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

Should Node based interleave solution be considered complex or not would pr=
obably=0D
depend on number of numa nodes that would be present in the system and whet=
her=0D
we are able to setup the default weights correctly to obtain optimum bandwi=
dth=0D
expansion.=0D
=0D
>=0D
>> Pros and Cons of Memory Tier based interleave:=0D
>> Pros:=0D
>> 1. Programming weight per initiator would apply for all the nodes in the=
 tier.=0D
>> 2. Weights can be calculated considering the cumulative bandwidth of all=
=0D
>> the nodes in the tier and need to be programmed once for all the nodes i=
n a=0D
>> given tier.=0D
>> 3. It may be useful in cases where numa nodes with similar latency and b=
andwidth=0D
>> characteristics increase, possibly with pooling use cases.=0D
>=0D
>4. simpler.=0D
>=0D
>> Cons:=0D
>> 1. If nodes with different bandwidth and latency characteristics are pla=
ced=0D
>> in same tier as seen in the current mainline kernel, it will be difficul=
t to=0D
>> apply a correct interleave weight policy.=0D
>> 2. There will be a need for functionality to move nodes between differen=
t tiers=0D
>> or create new tiers to place such nodes for programming correct interlea=
ve weights.=0D
>> We are working on a patch to support it currently.=0D
>=0D
>Thanks!  If we have such system, we will need this.=0D
>=0D
>> 3. For systems where each numa node is having different characteristics,=
=0D
>> a single node might end up existing in different memory tier, which woul=
d be=0D
>> equivalent to node based interleaving.=0D
>=0D
>No.  A node can only exist in one memory tier.=0D
=0D
Sorry for the confusion what i meant was, if each node is having different =
=0D
characteristics, to program the memory tier weights correctly we need to pl=
ace=0D
each node in a separate tier of it's own. So each memory tier will contain=
=0D
only a single node and the solution would resemble node based interleaving.=
=0D
=0D
>=0D
>> On newer systems where all CXL memory from different devices under a=0D
>> port are combined to form single numa node, this scenario might be=0D
>> applicable.=0D
>=0D
>You mean the different memory ranges of a NUMA node may have different=0D
>performance?  I don't think that we can deal with this.=0D
=0D
Example Configuration: On a server that we are using now, four different=0D
CXL cards are combined to form a single NUMA node and two other cards are=0D
exposed as two individual numa nodes.=0D
So if we have the ability to combine multiple CXL memory ranges to a=0D
single NUMA node the number of NUMA nodes in the system would potentially=0D
decrease even if we can't combine the entire range to form a single node.=0D
=0D
>=0D
>> 4. Users may need to keep track of different memory tiers and what nodes=
 are present=0D
>> in each tier for invoking interleave policy.=0D
>=0D
>I don't think this is a con.  With node based solution, you need to know=0D
>your system too.=0D
>=0D
>>>=0D
>>>> Could you elaborate on the 'get what you pay for' usecase you=0D
>>>> mentioned?=0D
>>>=0D
>=0D
>--=0D
>Best Regards,=0D
>Huang, Ying=0D
--=0D
Best Regards,=0D
Ravi Jonnalagadda=
