Return-Path: <linux-kernel+bounces-21178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FCB828B58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A599B23B83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC63B790;
	Tue,  9 Jan 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="UL4FxFcw"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928739FF2;
	Tue,  9 Jan 2024 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POYMTdYb8hFknrjVmvPlX6puFWQrQxG1AA5X/Hq878aRrV8FHsgNueG7BQlkRGmnCrAckTqFqygYE5RZeYtftN3xG7Jq3Qu2KHEAp6bLHWiO5oXWhaNapQ59ldtiabP3O34zsyfYjF4mKSpMe7hITEJUgKPqi7se7N9rUgctWu2QHaggSoQM/bIvfnir4AyV21K/LY5W35NNI35hsH7U8vReSMCRZ6q1DMLXMibqC5TMQgM3apjjzVSh0sphNyqmC4S3Hq+ngCEMkrFVoOwIZ78IvWNbgP7uTLVGrNot/DTsgRPDtsLTW544CSlvmPFTyTRshFjQb4hwIdOeC+8jIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjOuvY7UBb25gmCYkb2hCJsWlb7DInLEbKRdAfFxVqw=;
 b=FWdwrER5qXiUPad/uX89h62EtuNZroVxm/XiOZU2d6YBuP42Yyq606rWkJzOufBq3sr1MOPCLgTTYpFR3s/QlPO+o+kUOWMr9Ky4sEMDP5NOIF0FfvouktWtBzIIIRLFX3fi+VpW73unuGK3KvFTSHe0ugsIrz4hHdUVg/+gDM9uulmVn5WT6soWEv1Q++7h2vsfDwTToX3MgVKgJT8kE3ZJHmkmq/7bNqBCF3W1NDwRCSV3fOzsJvpdrz5EOtv0nISmPjF6pErf4/DCjg1PIoCwQL+86apSdo6jwYQiO2iWbjsQFaPNenG2PTboIoVuRwqh7e5/6bkVM5ElTFZJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjOuvY7UBb25gmCYkb2hCJsWlb7DInLEbKRdAfFxVqw=;
 b=UL4FxFcw6JUsh4sR+i4GSe6gUiWFJtizBt9TUof+6Csb8iTHmdZFtzNyYfulPPtACuSEMjzixYY0MbooBwN1gXCiS2UdPh7p8QZMVcWPiXAwJ+gMKZ4B8v7wSwiRlhrdp36jZoYSpBrgjT1foZitmrj+7dPoj7u9AB0gOTt0QLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4631.namprd17.prod.outlook.com (2603:10b6:a03:374::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 17:34:28 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 17:34:28 +0000
Date: Tue, 9 Jan 2024 12:34:24 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Srinivasulu Thanneeru <sthanneeru@micron.com>,
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
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Wei Xu <weixugc@google.com>,
	Hao Xiang <hao.xiang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Message-ID: <ZZ2DoPT8LzNzXyme@memverge.com>
References: <ZXyQIJOim1+tE0Qr@memverge.com>
 <87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZZwrIoP9+ey7rp3C@memverge.com>
 <87o7dv897s.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7dv897s.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:a03:100::18) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: 718b7cbf-197d-487b-216d-08dc11393b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vZN28pkpuhmJ4jyNt5W6DAjrXyczgwEA2sZLpzpgh45G77HTw/Tho90wKnxx6d1cJOMtP9cMdj+OflGEgfhLa0CLpsTPu6aI+av4fzkdY5fx30lrhPiHKGyHNN1HYXdV8hJj2sW3/rS53yK0dQJvs644ZP5YICzN//m0jL2ARhrrkXS2n7fCHAidIMRqsvVEmwQMMMDk6vl/b6sPSDglZg04QbnjrRD2CD6Au4hwEEmItQwDET36TVJxNHWnCuTzhL6XWK1DMk2bN493qRjtcoT5T1DSNYePIUjIzjCM0kc6lEKGye3Z3VrAEcCIDtDCeJxg0wZDH0VzRisGKzwhiO9FdOiwNFweiyVkvWW3paZegLQHCCpWLRh0FQPO7v//CTGZ7quGxOMvFVboyQrY+6TmvcWNsNYZXebrmoQzJYtbjTWIq7fnItfRLVTwdeMdtoS//7gcV7vTA3Y9RJzaJ9Ms3of5TAZ1TgKkK6KJqagxAIxVEhx4PwUI08hgYSaRJadvFxcKgiDCzL0W04+dKW+3yXyp3ssiPJyOUyiCDeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39840400004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66946007)(66556008)(66476007)(316002)(4326008)(8676002)(8936002)(478600001)(26005)(66899024)(2616005)(83380400001)(966005)(2906002)(5660300002)(7416002)(41300700001)(38100700002)(6916009)(86362001)(6666004)(6506007)(6512007)(6486002)(54906003)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l593e5e8+m1zaNVUffG5jI/KfHq6r1572WN1s9IflGSmrSrRy5rP6tO/49oI?=
 =?us-ascii?Q?mOEVph1Mkmz4a0P0tj13iHXtcuXj5lb/4X/7AjhNP9fqhDALxGdX96I7kBKg?=
 =?us-ascii?Q?l+XL31VVGQKqNuMLBVCO35I+CqL8hc3M5dfMY5Uu4DGk0OIdmYbR8jXmIuWk?=
 =?us-ascii?Q?+Y1/Ymg5YXRJlRb2a1XIu0M7GZhhr1l55yYwADPTbkJevzqwGPfvZbzxikF2?=
 =?us-ascii?Q?c6jccY62zrKK/DTHg77O5HBv2Kz08G1K6W015XI3nPknEsxVZwn36BDwjQxT?=
 =?us-ascii?Q?yqRbXxTNwuXzcflwptJME6Kp7tsqvsRRFv6r6yJy3OQj65HDFZoLfn2qWahV?=
 =?us-ascii?Q?G4fvmnOIRTYMkNMU03kbIOJH8OhfYyqNgaGZ3Fs4nhOUWDY/DYVXIynPsEAs?=
 =?us-ascii?Q?Q++ixbqr3x0qt9fFxYrhpMZFkrrzl1NxmGnsBvmgAbvCwCD8i4q2jLSbaZvJ?=
 =?us-ascii?Q?4zwBrheIJZqbFX6N2xJrU0CRUy1U93X+DcCCIi7xJQY7gXuNKB/3N8ommdvj?=
 =?us-ascii?Q?zzWznvhUqhN0X3HrynY6FG26tauqeQ58AVYh7lC2XhLO+oEbweIbM5DjGQBT?=
 =?us-ascii?Q?cLO7Ce/CnZWieVcS1q+sPrrqBBhASkLBnfrM7FVMkcwejxYTOu5KaHI0YTlN?=
 =?us-ascii?Q?VN4EEcebs6zSequ0d7vRn0jZ6rBNhaq41vKQ3JjIrd92FiDqh5d4Moqa6sbj?=
 =?us-ascii?Q?UQ+YRbkeT0qB+BY9N4oZg47z6PKCP8putfa+7SKf/cxQQHwVLEnnMoIbqzEu?=
 =?us-ascii?Q?nrwAWaJv7JBNTLFExLTi/5alejnKr3N33g1nQ4vXQIymEsl8pKWFPc+4NQAF?=
 =?us-ascii?Q?mKPVwNCrq1ryKodSKXhX+2dxbOC9fiK1UuaAD6Hl/y8Ir9kAQYFmE2Stqyde?=
 =?us-ascii?Q?5wM8YJTqed75g7vD4MMO4nZIrPbHjDwkHSeOIEdN8r3+keu93Ek4gS4yBzXP?=
 =?us-ascii?Q?XbJT8XLMnDYdSusGGdmLLDwo1Pk0QsbX6ZrTVvFg3SqakBecLhq4xwnmpYfa?=
 =?us-ascii?Q?Corg1kJLAibFH92yu0solxep/ve3Q/2l9twAjOS7vNS27Tq9fOuMgwph5KYP?=
 =?us-ascii?Q?2iH6XqfSIJEZS4PCDRUydJmK8VzKd0yCpq1YWumlVjqdVbcXne1+pTTZT7Gy?=
 =?us-ascii?Q?4WfEKIsMINRnvzOjTqpjGUMam2vSEb6LxOj9csQy5OvGb8t1oQ5RtnY9DDOh?=
 =?us-ascii?Q?aJQ9D7MPt/M71Cp4ysQpya++mabqFepT3zmgAIgqMzketMKwNqTpOCJTRKny?=
 =?us-ascii?Q?ltnFnBJ6iEZETK8WKmZdnIt3BYbKoeif3Opy4IKBrF/ikv04dR6NABvE+n6Y?=
 =?us-ascii?Q?jDevoyw0IvvX1zayrNoqNOlG0WzjKl0ul+JMjPd4inkbVYgBiKwF1w8fbCDR?=
 =?us-ascii?Q?vd1qHKJnYmHUqMIVtSb6z3Lphe+jfm1woio0vKG5GLsepmJuQdXKX9HkwNL1?=
 =?us-ascii?Q?1RhgA1YxK02+c+yAc8/HoJchOwCglbPfEB0SZLW4J4aunHBHtqjipTsOhld0?=
 =?us-ascii?Q?5w2/NNCv0Yw8QicKWC+5yKT/ApjNigwIvUkeMrng78vRAwOnQwk7AruwfjP+?=
 =?us-ascii?Q?83WT5nVfcppv7znJuLt+Qgr0mdwKXRLI1lQgMvSdto//QUrftuIuqodbOkfk?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718b7cbf-197d-487b-216d-08dc11393b38
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 17:34:28.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR8uuaP79JKAtxBuJRB4y3jcxxaISCpbvaMuGflvYAbGH9CPNtEW5bOyZgp78TsiiiHKuq6sPep+PkTqTSm+TNAFTTLPHFWBZsZ7ORsE/54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4631

On Tue, Jan 09, 2024 at 11:41:11AM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote:
> >> >
> >> > From  https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf
> >> > abstract_distance_offset: override by users to deal with firmware issue.
> >> >
> >> > say firmware can configure the cxl node into wrong tiers, similar to
> >> > that it may also configure all cxl nodes into single memtype, hence
> >> > all these nodes can fall into a single wrong tier.
> >> > In this case, per node adistance_offset would be good to have ?
> >> 
> >> I think that it's better to fix the error firmware if possible.  And
> >> these are only theoretical, not practical issues.  Do you have some
> >> practical issues?
> >> 
> >> I understand that users may want to move nodes between memory tiers for
> >> different policy choices.  For that, memory_type based adistance_offset
> >> should be good.
> >> 
> >
> > There's actually an affirmative case to change memory tiering to allow
> > either movement of nodes between tiers, or at least base placement on
> > HMAT information. Preferably, membership would be changable to allow
> > hotplug/DCD to be managed (there's no guarantee that the memory passed
> > through will always be what HMAT says on initial boot).
> 
> IIUC, from Jonathan Cameron as below, the performance of memory
> shouldn't change even for DCD devices.
> 
> https://lore.kernel.org/linux-mm/20231103141636.000007e4@Huawei.com/
> 
> It's possible to change the performance of a NUMA node changed, if we
> hot-remove a memory device, then hot-add another different memory
> device.  It's hoped that the CDAT changes too.
> 
> So, all in all, HMAT + CDAT can help us to put the memory device in
> appropriate memory tiers.  Now, we have HMAT support in upstream.  We
> will working on CDAT support.

That should be sufficient assuming the `-numa hmat-lb` setting in QEMU
does the right thing.  I suppose we also need to figure out a way to set
CDAT information for a memory device that isn't related to CXL (from the
perspective of the guest).  I'll take a look if I get cycles.

~Gregory

