Return-Path: <linux-kernel+bounces-21199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEEA828BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD71285162
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434A3BB2F;
	Tue,  9 Jan 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="jdmNhfEG"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9A3C060;
	Tue,  9 Jan 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qe1usf59KUTxzzKmsKdUJ7jw4+OyQgt1tyoxcvFd9fx+WtGzRj58/x1M+KbYk6Ekd+laFOhmFh193gjyJrCL6AEENBKrEWh/KWSFkRmrB3SqlRRVhw/KlwW4M//uDo1nPqqdNFZz5n/tuw9HGhh+va9rMi1RTGuO036Gxre2Pma+Vw1umgYLPFWuuDpPqILH8LTK98mfVF9uudbH9uPhd1Q7x/ZnqZVZ1wH64FV4yZNma7YMd0AWj8NH5neUeWUFVcSqXTRt/vT3t/xKLNdG/d/C4VhXgEn+Zxb/A/eIcdHaf8967YGPXf0Lw3UgfEJVId3JSo3dhEJV1yEKTBiB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAjw8+Pl+ElblBN6Rrx18mNcttVZa5dtvaWcsS4/0UE=;
 b=KHl/pqr42ErlfA3lfhDLkvJgx1EwH6JnzqzNEIN/gTM0ILM/L/GIal2lKTzQZTPaj6TdoQd1DldbYCE+znN6A8e3gJK0xxygSNEHRQ5UTG/PheN7eJsBZmlGquwRpX6/URRn0n9uVoSqvg7qqJmZYVnAlJjD6CR+Oleqq0GvtorMXw75KM+oVWUzlmMhr/rGF0w7DbYZUXgWV5g21bdETM4D2FiLAUID9chKA/YnG4RbC1OR1HTC/Yp9/vlcV9UPg3+6aChmw1WGAtnvonk0mayBE8Smb2PSdCqCXAzVizkClITMG6NlZnQPdYp1fVQ1SSHzFuTIRVMPjdVeQAYS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAjw8+Pl+ElblBN6Rrx18mNcttVZa5dtvaWcsS4/0UE=;
 b=jdmNhfEGltuzdSFQi8g0AgTz+qROwCqA/MCHf2+fSdHcpWULGfSaNqPtMH75bAjvkSE9vauHhimLBej8dXY+J84VLQPVrP29y7XHGOHqvEg0jh9aaul2jerf2GegWRcdmfnG5mEpXxD/yIgUipb4r5t2FwaCk32LCcZW20TsP1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4434.namprd17.prod.outlook.com (2603:10b6:303:73::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 17:59:30 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 17:59:30 +0000
Date: Tue, 9 Jan 2024 12:59:19 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"tj@kernel.org" <tj@kernel.org>,
	"john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Wei Xu <weixugc@google.com>,
	Hao Xiang <hao.xiang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Message-ID: <ZZ2Jd7/7rFD0o5S3@memverge.com>
References: <87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZZwrIoP9+ey7rp3C@memverge.com>
 <87o7dv897s.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240109155049.00003f13@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109155049.00003f13@Huawei.com>
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: d4976895-2d91-45ff-e6c7-08dc113cba7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iN5jZyAvUDaAUVlFb8Au9f4BpiE7WIMo/rfiPaG2mnMQ769re2a23x3M/A+xG6X4BsLMZ2RExLLSASxvQGP2fZ9ayqnpDyB7qEMIBce8XOOYYofsg02MGL07b3gAAqLgsg97AaVErjB1g8hR7M58sPsay72toaPWynPip7ACU9ZUrEdoXR8suwuVAaYUWF1oO94faJg7CcNL149ErGodeTE7FD1aJ69Kd9YFOriXW10k0Pzib/puXHNQ1hI2YDhaX8CK45/CICqDb7zuQIDNVNF+EXnJN80+5dxvzcRWbHfcHZ+1ySv2u369w8Cjvo7VOJLlOeYTk79eoYpjVDos5bZrMhAfQDXR7Lrd81+3eRJUQgOsXUhmt57hg2Tita2lsickoi14znBao0/O55K0ZdBrGJYwzyedgJr7V7LZ9dL6sAruOIxCzIzL0FRrFdlIZhCkG2RUX6QvIgbgItvYCkRju5mhU0EJdu+uTH8QmoODMHjGU/Y/PYSMjxB9Id5n+WpoEEWIXRapi7xuxcHb0wnl96Qh1l8vWQ09SP6YjY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(7416002)(5660300002)(478600001)(966005)(6666004)(6512007)(6486002)(6506007)(86362001)(8936002)(36756003)(41300700001)(66946007)(8676002)(66556008)(2616005)(66476007)(316002)(54906003)(6916009)(38100700002)(83380400001)(26005)(4326008)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cUBRSKXzcbV3pVdbHwaIp/7apsDl/uadP26K03gnu+uTv+APQRM0e8Xe5Kq7?=
 =?us-ascii?Q?qbNwuUSJjWg+PAZlW1mWiCvDJfinHwpUcGZQ76clsfKBloyT8V0l3tMYXqY6?=
 =?us-ascii?Q?qh46Eenatd9ivc2RA9C7bdcYLRlWheyhvipi/JRH+JBKwVP/Liw/h1eL7x+i?=
 =?us-ascii?Q?I2lg9gddnU5M/jYMfYB5CcBxFScQKKPXmzL80M8z41FhowJFWO+RKKTVMCXK?=
 =?us-ascii?Q?d+W9v4Y//vH90YPukeyyQ+CMK/RW09OhcCL/5NzNr53pwEv3JQN1P8OWXmCn?=
 =?us-ascii?Q?K6fZx7YRikbUW2Nwy8oJERe7Mxr0MHwQcCyi/UTLepAmT8vYbHlvH/2dzzQ4?=
 =?us-ascii?Q?zyH221ybJLF0QOahfX1LgVCn/SUp+c8SmQ69v+iSD80502AcSSTlGCfC1JIe?=
 =?us-ascii?Q?Vbr++PC2RwrQhULrzWuvyiCBdQ+bt99L/2wBjB20ZXIZYhQ2yuWUIRlixRnF?=
 =?us-ascii?Q?ETFsb29rEbMgYYS2/GnHPAHg8glqiquq68qzWh2jPdhRRGmZQ38ZszUGy+JH?=
 =?us-ascii?Q?dJ0RSW3bkrTTNT7baVXI+T1dYEOv7+3O4t/H1SRQzZoms+emeVlmLjtMhf83?=
 =?us-ascii?Q?Ku4tMpKtkXVtbbpED/AgVwrSARfX6l64S+AWn6lDaJyEOyXbJyIDhFafRXm3?=
 =?us-ascii?Q?LQWtuiVV4kd1Gwf035BCK98FtSphx3iH/wjFb8seRtF7tE1ZAJ296vJMpBtN?=
 =?us-ascii?Q?VD4X9oetF2COm5PmcW41+GAqahPQiyU7xNbAbg2ENh0SMHNQW8+8uV0CfEN6?=
 =?us-ascii?Q?7k70aMVPp0trFCY5OH9kSCvLMuyzPCuZXLzBzQCJnaBcIpSiDrfnE5sGfzS2?=
 =?us-ascii?Q?zRLnApjWnZYhK028wHV48MLM44sukt5VVBU1x78RG6NxplsZfH8RUkhtr5Jn?=
 =?us-ascii?Q?YxjwArL4VEqdXrjFdtAEr/xDfga4jyxSwlKLyVxWs8VF1onIBobzX/eAaH/F?=
 =?us-ascii?Q?FYD/czIURBsozu+8oM0QZ/dl6egPm8B8c2WoVdysRpFXdZNHaqk14lRfrB5X?=
 =?us-ascii?Q?XT1QblB4V0mJkjaJlN3I9NCfKU0hRluzFKH/c9DxThLSiSDc2CyEVB10RkDO?=
 =?us-ascii?Q?wh1ldi/7zc2bNUw9pcRz/ACaE2LrlMhl0gZU8uUudKTomMqABRstylavXUc9?=
 =?us-ascii?Q?N4fjDuFWrbtQTz3o5tohjSWKbOV5LDLHJlnTWeZP5Pn6K0e4qQUbv+S3ldMZ?=
 =?us-ascii?Q?eLAdmInkrUaCt3lqAAWgD3Oltn9c5B4tjKKr5hllASYqvUlMkJRVmfehEgFA?=
 =?us-ascii?Q?CaP15btpRRhlVqg9SJ0Rm9vZZY3xL4S6ionlgf+09Y6jdILMnuGBHk64PXdk?=
 =?us-ascii?Q?NstJ7kFDLHl+JuUEzXnQowRW5wFe/v9/nuqAXpL91y0JiAjg2bidFb/g2UcI?=
 =?us-ascii?Q?/2bYat7dYd9kfHQkBFSgUs9+qS2lwoGDHGYa8HOg6ofQh+5r8+Lg1zszb+61?=
 =?us-ascii?Q?y7UV+U5qb22vymHHGMLU2IwhLBklMbgX9XySqBsUL3i1p/ASKPOhWogV7iO/?=
 =?us-ascii?Q?8/wYYY5fimq/PnuHei573jcyTUPNjVir/9zu9girqLeBoSpvJlDmmN/wlmhp?=
 =?us-ascii?Q?0FRTke8bGSDEbqmOxaUUXHtSZfBSZ7vAHPNrx+sDt5vA2inTbch7ZCvJUsiT?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4976895-2d91-45ff-e6c7-08dc113cba7a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 17:59:30.6244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H28jusB0ICSdlAcV0x5Bq1GaAicB7JG0y1P6hrOoDmp0PzWtcJaf2YeVL5yvl4SQFagS/vMh+B80A5zwS7+dkb+Iis+BFSlGc4HipcYS9AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4434

On Tue, Jan 09, 2024 at 03:50:49PM +0000, Jonathan Cameron wrote:
> On Tue, 09 Jan 2024 11:41:11 +0800
> "Huang, Ying" <ying.huang@intel.com> wrote:
> > Gregory Price <gregory.price@memverge.com> writes:
> > > On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote:  
> > It's possible to change the performance of a NUMA node changed, if we
> > hot-remove a memory device, then hot-add another different memory
> > device.  It's hoped that the CDAT changes too.
> 
> Not supported, but ACPI has _HMA methods to in theory allow changing
> HMAT values based on firmware notifications...  So we 'could' make
> it work for HMAT based description.
> 
> Ultimately my current thinking is we'll end up emulating CXL type3
> devices (hiding topology complexity) and you can update CDAT but
> IIRC that is only meant to be for degraded situations - so if you
> want multiple performance regions, CDAT should describe them form the start.
> 

That was my thought.  I don't think it's particularly *realistic* for
HMAT/CDAT values to change at runtime, but I can imagine a case where
it could be valuable.

> > > https://lore.kernel.org/linux-cxl/CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com/
> > >
> > > This group wants to enable passing CXL memory through to KVM/QEMU
> > > (i.e. host CXL expander memory passed through to the guest), and
> > > allow the guest to apply memory tiering.
> > >
> > > There are multiple issues with this, presently:
> > >
> > > 1. The QEMU CXL virtual device is not and probably never will be
> > >    performant enough to be a commodity class virtualization.
> 
> I'd flex that a bit - we will end up with a solution for virtualization but
> it isn't the emulation that is there today because it's not possible to
> emulate some of the topology in a peformant manner (interleaving with sub
> page granularity / interleaving at all (to a lesser degree)). There are
> ways to do better than we are today, but they start to look like
> software dissagregated memory setups (think lots of page faults in the host).
>

Agreed, the emulated device as-is can't be the virtualization device,
but it doesn't mean it can't be the basis for it.

My thought is, if you want to pass host CXL *memory* through to the
guest, you don't actually care to pass CXL *control* through to the
guest.  That control lies pretty squarely with the host/hypervisor.

So, at least in theory, you can just cut the type3 device out of the
QEMU configuration entirely and just pass it through as a distinct numa
node with specific hmat qualities.

Barring that, if we must go through the type3 device, the question is
how difficult would it be to just make a stripped down type3 device
to provide the informational components, but hack off anything
topology/interleave related? Then you just do direct passthrough as you
described below.

qemu/kvm would report errors if you tried to touch the naughty bits.

The second question is... is that device "compliant" or does it need
super special handling from the kernel driver :D?  If what i described
is not "compliant", then it's probably a bad idea, and KVM/QEMU should
just hide the CXL device entirely from the guest (for this use case)
and just pass the memory through as a numa node.

Which gets us back to: The memory-tiering component needs a way to
place nodes in different tiers based on HMAT/CDAT/User Whim. All three
of those seem like totally valid ways to go about it.

> > >
> > > 2. When passing memory through as an explicit NUMA node, but not as
> > >    part of a CXL memory device, the nodes are lumped together in the
> > >    DRAM tier.
> > >
> > > None of this has to do with firmware.
> > >
> > > Memory-type is an awful way of denoting membership of a tier, but we
> > > have HMAT information that can be passed through via QEMU:
> > >
> > > -object memory-backend-ram,size=4G,id=ram-node0 \
> > > -object memory-backend-ram,size=4G,id=ram-node1 \
> > > -numa node,nodeid=0,cpus=0-4,memdev=ram-node0 \
> > > -numa node,initiator=0,nodeid=1,memdev=ram-node1 \
> > > -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
> > > -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=10485760 \
> > > -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=20 \
> > > -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=5242880
> > >
> > > Not only would it be nice if we could change tier membership based on
> > > this data, it's realistically the only way to allow guests to accomplish
> > > memory tiering w/ KVM/QEMU and CXL memory passed through to the guest.
> 
> This I fully agree with.  There will be systems with a bunch of normal DDR with different
> access characteristics irrespective of CXL. + likely HMAT solutions will be used
> before we get anything more complex in place for CXL.
> 

Had not even considered this, but that's completely accurate as well.

And more discretely: What of devices that don't provide HMAT/CDAT? That
isn't necessarily a violation of any standard.  There probably could be
a release valve for us to still make those devices useful.

The concern I have with not implementing a movement mechanism *at all*
is that a one-size-fits-all initial-placement heuristic feels gross
when we're, at least ideologically, moving toward "software defined memory".

Personally I think the movement mechanism is a good idea that gets folks
where they're going sooner, and it doesn't hurt anything by existing. We
can change the initial placement mechanism too.

</2cents>

~Gregory

