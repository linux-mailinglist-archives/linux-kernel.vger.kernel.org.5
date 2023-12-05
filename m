Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A07804D76
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjLEJUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLEJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:20:06 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56A9C9;
        Tue,  5 Dec 2023 01:20:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrTBoedpl02UUGqvuhT3GpVvbQW2TJvMW/wXHCF7Kxzkk5pSls6YjeIUsoq/U2wrEneQEJ3W3DZrRPCf7ZJgPLQfjw16OlGnlJv8PorHrc1RjL7Ai+qTQgFwbY+nrcHH0KS9DrHgCx772gsL/21nisuUnvrj8mxidgEfS2ISALPq/X9Yf3NvH3BoNHW5beptkePaT/z9CHGydy7Su/4yQMMcW1oY07frssJ0KRnLYZzm6qdAZtweITVF8ViYSsWA0Sh/w1U65tWaiG0wjP0YN71LGHJ/4tboQB8tjqh34+/jus15vomYnE55c+RdHTnahDu2d2a8WrY+Fib/E2I/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7N8Vvd1ikAfbF0//M6JIVbeJYQv9kwXnaYLD+YqxWWo=;
 b=nypBDBRb8H2H0fPQlBm7azAYjjySLf7IwSfmKR0kVPtiw3XH34JFDzaAelYvbQMLUCP1X6bIIFv++HHBZd+eE4jNe0D6bGCb/NLgfghxRoKHe9f1ZhvK4AvtsFcAGZBNc5d9RV+xXJJHWVchmXmfoKaT8MIuU4jz/qCGEyUe9YUKOY30umvF1CNqhuwvjkcPecyTbZMLJ2TmSPsM5LZs0ZKfHGlPRMHYRPXSTEZInmJRH0KgSL905gjqYyPPP0wG7NsejQWzTTN9JPEdDMv8d9agYpH1gHnYq3Xp9eNmu8Wsglrxrneh5GfzAhMRWEUTstjKsG0GunrFIttP3DLKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=suse.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N8Vvd1ikAfbF0//M6JIVbeJYQv9kwXnaYLD+YqxWWo=;
 b=fvQUle0N3Vl91eT97DUSTJd2v2/8vl3bPtN1oIoKsOBPk2SVRmM3q0prgMNkmHtFaQR1KQGJZi5DAFX6aK76Vo0EmjRglbcLqgF6g4rsTsrDjHAEB6c8NcK/v1ubmv8nLeJ88FDUGN+Z5gl6YqbuirlS0UBbBORtONyyydMtFlf3FYMB+CE6vLhduHDLFusspb0GnFdt24XnyphxZiFYIpvv+rDHkoGsyHThBeVKgF4yHJNk7tSf0QBK8PwLoZrbnsdoPZFDvxl81eNN0FB16tWSiRcKiSKIh4iYkXMpigYmZBFxl+YKy0+g65RNmgvCpzaUNMbv7gUUztvP1NFmHQ==
Received: from DS7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:3b8::13)
 by CH0PR08MB8732.namprd08.prod.outlook.com (2603:10b6:610:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 09:20:08 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::27) by DS7PR03CA0008.outlook.office365.com
 (2603:10b6:5:3b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Tue, 5 Dec 2023 09:20:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 09:20:07 +0000
Received: from BOW36EX19B.micron.com (137.201.85.154) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Tue, 5 Dec
 2023 02:20:05 -0700
Received: from VENKATARAVI-LAP.micron.com (10.3.67.135) by
 RestrictedRelayBOW36EX19B.micron.com (137.201.85.154) with Microsoft SMTP
 Server id 15.2.1258.27 via Frontend Transport; Tue, 5 Dec 2023 02:19:59 -0700
From:   Ravi Jonnalagadda <ravis.opensrc@micron.com>
To:     <mhocko@suse.com>
CC:     <Jonathan.Cameron@huawei.com>, <Ravis.OpenSrc@micron.com>,
        <aneesh.kumar@linux.ibm.com>, <dan.j.williams@intel.com>,
        <emirakhur@micron.com>, <fvdl@google.com>,
        <gregory.price@memverge.com>, <hannes@cmpxchg.org>,
        <haowang3@fb.com>, <hasanalmaruf@fb.com>,
        <hezhongkun.hzk@bytedance.com>, <john@jagalactic.com>,
        <linux-api@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <sthanneeru.opensrc@micron.com>, <tj@kernel.org>,
        <vtavarespetr@micron.com>, <ying.huang@intel.com>
Subject: Re: [RFC PATCH 0/2] Node migration between memory tiers
Date:   Tue, 5 Dec 2023 14:49:58 +0530
Message-ID: <20231205091958.55-1-ravis.opensrc@micron.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZW7km-SED5oIGGnZ@tiehlicka>
References: <ZW7km-SED5oIGGnZ@tiehlicka>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CH0PR08MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b3770a-24d5-49f9-38d9-08dbf5735fbe
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3alZ0NoVvujfCXMQU57zeQqRF5v+INuMns/r4/8K1lmqMsp1PaTT2cFa4WBFRya2VBPTovtVwGVYDaqJZMFi8keAdcmQGErAC8zJT/76GtVDrwkq1B9aPAFwl4/zwQ16VFagcNvLIHxi8G1Jz09cgjxX1N8VZ2DM+G2Ue8XzFuGBJh5hBNSMtOKl8dPf4QvKF2iJhK54WkaTPF7aCxQS9VlQYtGuf1TJhjUS+ZADb0GMFiscsx76dx4XtMWSe/y+UvL1318CBRRDBO3fyZWW93PtYGcm4mdAYXn9xdt0+6ZO9hDXG5amEVuGFIpPw6z/ftJjmg6d2JNj0KeBl4DzOoTgBD4oA4RovKVG2Nte/pVFHx98UwI0N9LQ/QAt0mEwdftDgY/Jf64kQj67rjWwv6TXrlUEwpCXIAcHvkiMjHbprLSiJS6c5lu3/QGG1No52UHQ9O1zQ4sgwPn0nlfusgxtXh2CuVg2NnEen9MM6uA/J5VLf3t8L1d5Fqqyy/k84dbZrsgT5HMQUuWrMV9NouRDeK55FAyG6ptaTR/Yum+Q+nkQLypXkyeXbWpRK6orusKBpdwKY4I+aiVOs5vJByBetJYwIO7ZxayJUTbp9znVPgXZ/ys1JhgJzdHlg/EcDQVSk8dMpOEQfHi4XrR1pEVqAGrBFna2+3W12kjuqWNm2B/lY7UeS/tCzcrNzRMnJxradaRo64DH4AMkU+btKrAQdKDfaCxi0uXxhasHMvcluVnGoGbmuSHzO8TROYsC+O6UkbZmb7WjEZjPgdu/LQ==
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(107886003)(1076003)(2616005)(8936002)(4326008)(8676002)(7696005)(53546011)(47076005)(83380400001)(40480700001)(356005)(7636003)(36860700001)(336012)(426003)(82740400003)(26005)(966005)(478600001)(40460700003)(70206006)(54906003)(70586007)(316002)(6916009)(2906002)(41300700001)(36756003)(86362001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:20:07.8465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b3770a-24d5-49f9-38d9-08dbf5735fbe
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB8732
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue 05-12-23 14:12:17, Srinivasulu Thanneeru wrote:=0D
>> =0D
>> =0D
>> On 12/5/2023 2:05 PM, Michal Hocko wrote:=0D
>> > CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless=
 you recognize the sender and were expecting this message.=0D
>> > =0D
>> > =0D
>> > On Tue 05-12-23 01:26:07, Srinivasulu Thanneeru wrote:=0D
>> > > =0D
>> > > =0D
>> > > On 12/4/2023 9:13 PM, Michal Hocko wrote:=0D
>> > > > CAUTION: EXTERNAL EMAIL. Do not click links or open attachments un=
less you recognize the sender and were expecting this message.=0D
>> > > > =0D
>> > > > =0D
>> > > > On Fri 01-12-23 03:34:20, sthanneeru.opensrc@micron.com wrote:=0D
>> > > > > From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>=0D
>> > > > > =0D
>> > > > > The memory tiers feature allows nodes with similar memory types=
=0D
>> > > > > or performance characteristics to be grouped together in a=0D
>> > > > > memory tier. However, there is currently no provision for=0D
>> > > > > moving a node from one tier to another on demand.=0D
>> > > > =0D
>> > > > Could you expand on why this is really needed/necessary? What is t=
he=0D
>> > > > actual usecase?=0D
>> > > =0D
>> > > Hi Michal Hock,=0D
>> > > =0D
>> > > Following two use-cases we have observed.=0D
>> > > 1. It is not accurate to group similar memory types in the same tier=
,=0D
>> > >     because even similar memory types may have different speed grade=
s.=0D
>> > =0D
>> > Presumably they are grouped based on a HW configuration. Does that mea=
n=0D
>> > that the configuration is wrong? Are you trying to workaround that by=
=0D
>> > this interface?=0D
>> > =0D
>> > > 2. Some systems boots up with CXL devices and DRAM on the same memor=
y-tier,=0D
>> > > we need a way to move the CXL nodes to the correct tier from the use=
r space.=0D
>> > =0D
>> > Again, could you expand a bit more and explain why this cannot be=0D
>> > configured automatically?=0D
>> =0D
>> Yes, in both cases above, if hardware not automatically populated proper=
ly,=0D
>> in that case this interface would help to correct it from user space.=0D
>> =0D
>> We had observed case-2 in our setups.=0D
>=0D
>How hard it is to address this at the HW level?=0D
>=0D
>Btw. this is really important piece of context that should be part of=0D
>the changelog. Quite honestly introducing user interfaces solely to=0D
>workaround HW issues seems a rather weak justification. Are there any=0D
>usecases you can think of where this would be useful?=0D
>=0D
>-- =0D
>Michal Hocko=0D
>SUSE Labs=0D
=0D
Hello Michal Hocko,=0D
=0D
    It will be useful if we want interleave weights to be applied on memory=
 tiers=0D
instead of nodes.=0D
    Also, for near memory processing use cases where some accelerator would=
 like=0D
to have hot pages migrated to a different node with HBM, pmem or CXL instea=
d of=0D
CPU attached memory for performing it's operations quicker.=0D
=0D
There was a prior discussion on this functionality in a previous thread, wh=
ere=0D
Huang Ying thought this might be a useful feature to overcome limitations o=
f=0D
systems where nodes with different bandwidth characteristics are grouped in=
 =0D
a single tier.=0D
=0D
https://lore.kernel.org/lkml/87a5rw1wu8.fsf@yhuang6-desk2.ccr.corp.intel.co=
m/=0D
=0D
--=0D
Best Regards,=0D
Ravi Jonnalagadda=
