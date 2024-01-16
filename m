Return-Path: <linux-kernel+bounces-28265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ACA82FC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB87BB2A31A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B36250E8;
	Tue, 16 Jan 2024 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNOJY3HI"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA85250E0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437886; cv=fail; b=BbLUWF0iX76M1h5WuNHqThNZK6bjwfz8tWiSLQ5946Zyq2RNrKUcFypiBpkTlEFj17cmRSq5PmexFGtaPcpU1KnZdMgFDUpzrpjz0nQdkwx4kTwWJKnfGWCMXXhuvFTInZYnEN0/fCtJDaeX5BYh+Uw/2lRokf7rpR3QYc05i3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437886; c=relaxed/simple;
	bh=bu92IdavPEeDP7Vds6g97Bn9y/QE21/FmxeLT7ocVUk=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=KycQBbERKqCAxKDN0mbZ3fCbDx2fwseeZgvHD3v0PDIMD19POVhUlMeheICN0bb5AnuGlldSb0ZWBAG5oqMFFz1LvR1JDyUVY51MudWEbDlU4YGN9VgR/iH8aA0cJ280m22SMcf9lxTvLaHhem03tB5SeUfDKuLkxy3eBbAYkRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNOJY3HI; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705437885; x=1736973885;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bu92IdavPEeDP7Vds6g97Bn9y/QE21/FmxeLT7ocVUk=;
  b=bNOJY3HIXFeZCyN5iY2LMCJGAyl0xvDUqTBXVblSwgI+ivMOncUAXhxX
   O/SOHS5dLR1waLO6+QYKX+ombn/kskCAbya+Z3zWmVsOfPYTp5KcTzd0y
   4vRFRTQIrTgV9MtwiwbwsW6U/lfdcgNo4/whmADi8NcKub8+ODNqCw9dS
   YmM3G2Q4U6RbM45u4mI3p38s/3vNixBadELHla+VmzfU5TOd7JAtLRNEb
   dsWnUzBe88WOEyt/toIt986i6lxPuptSiEI78PwrAtHVqfWLvY5mIypuj
   6UK0c16OpoNvtLoW9EioBGj22GRkZMaTJAHCT1nURYBCYWLz09qOYKl1C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="431145033"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="431145033"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 12:44:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="1031114084"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="1031114084"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 12:44:44 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 12:44:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 12:44:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 12:44:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 12:44:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXBlSVlCk/xWhN2frfl/kclbjGwp+sLHng8squx0dIR3MJ8390ehZZ2FOmNDC5/i0GJBZn248BrPqnoSEkznpgb0kGM6UjE62l8EVwD7qT5Mo7lZR9rx+oT/2qwT4hM4Ry49vfO3IA+ZuOeaYLXiRmi47SKeJXFrXjZHNtqo8eLufU58piuTrWM3gE2bDg34gu76bI5qfOGlM9DJ/HDneiHZhcgJsk9/+9WuxbdsD8/ZeO4uqrwJPsbvL2cyIK38XYSy6rexLOBkReGK20v7/nreuSfWoMxpu/0w8W0BKPAZlYUSFFcLaLLZlKcQWyAedAV83mYBTsf9cUQiErIU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Spacb9LHlV7jl0j3ERtRm3LNVf9kbkBRNgitevBkTRM=;
 b=HWjq/Jw136OULbbSVdsVI3gLKFVoU0WoXRw31QDIOKMPVJBNWGEhcMuaQO9nF55+jy7YT1GSKoMyxtZD0lAqdsEXeXqMb1EuAl1tqYQWV55+x+yFhSZkCrWfp0tHQKFxcRnd5fWBuI7Y/yuEa+0lFtjh0de61Ru/aeqWxRiNfZO0gSWjv/pxrloSbx3V0H4TyJ7uB4y6nmfSSFVE0UASHkDXQs9adgOvqyZW5PHvfbGbaGlhPLVn3+f7LhsImplY31eEGbT8hnSsoDqqbyAdNWZAByOC8/1ICC1BbxiFxyWyQ5Ysok66gcZDVgy0eKdDlKZOiFEhumd3e2I8FadCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5001.namprd11.prod.outlook.com (2603:10b6:806:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Tue, 16 Jan
 2024 20:44:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 16 Jan 2024
 20:44:40 +0000
Date: Tue, 16 Jan 2024 12:44:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Samuel Ortiz <sameo@rivosinc.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 0/4] tsm: Runtime measurement registers ABI
Message-ID: <65a6eab6ad920_37ad29424@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240114223532.290550-1-sameo@rivosinc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240114223532.290550-1-sameo@rivosinc.com>
X-ClientProxiedBy: MW4PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:303:8e::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cbd81b-f96d-46c8-ca45-08dc16d3f64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8zVsFRmAwauOfUlf7p7ohHn/vRuM2CEmsDcZJyPHp9UbWcCE4xyD4o0KERw3NDFZOfsD6vDDKAJ3LjAc1pO5QhzRvB4HZbSbls0AcEjSLQQNo3Msg0Jc2q8fruoftyfT5Y8h+POjMpAeMXaA5nt2Wdeo0vF8Ml4YFuQlbenRJVK2KIypkuUpxa6LWFLNpvJIJGEno2vdxt/45TgPXXbqMhUexeFyF/AiHrZW4NUu6gAZZc7/aRTCWKchBGBtKhK0RL3GlXEblBBpmttilNbuHfuAFEa/Ho2sAVWLsa7G0GQUfrN99LxrgExZDbykFdxKuX962A3FCGrZIopy2jajNpcFmyFH8uLcJB/MFzoJwMdzH81FjqsZbNkbvE7hkpW+heUXHDvqiZDkkhbdapi4PXLaDqPABODG/G4jMqHv7AdSfYdjGzJmPg7eBVR8hSUOfUBXqdgAzm/UhEUjTHmAB/wIOStWrZZehQ6p9HJg2mHHm0dhi2CNqsPQdLsZvGy1R7i/yerfDXQIFSqoNWC94UI/3+8GPWnUGYuWajSzPlY1cflmO5EZSXOyMdnrf7J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(38100700002)(83380400001)(86362001)(82960400001)(110136005)(316002)(66476007)(66556008)(66946007)(2906002)(8676002)(8936002)(4326008)(5660300002)(26005)(6486002)(6506007)(478600001)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iCZ60zhc5CqJ6pg2EDhaVMaNrN64WFeDYFw5Y69BTy6YInEZt68QUjmKfrtv?=
 =?us-ascii?Q?+6bPVetE7TyfG51XTu868Qboo4VuBbAkaEntwa2NPgTSDx7GBYH3chrfeexv?=
 =?us-ascii?Q?SJP2ttmf5UGP3RNBjK55jk94nL7lpe/NOQ2xpUZyjPR9e08ZNLeSL8qbh66x?=
 =?us-ascii?Q?LnYwtYTTSp9fK2HHeFsqdFtSdwdrerhzYvpNqxiKgLyvX803jaqNY90iEkTo?=
 =?us-ascii?Q?BftUbbXyRcLwQAoDcRA5TbB9zOFxZNaINKQMKYgzruGXZfpvSowyvrem80bO?=
 =?us-ascii?Q?0z7Djs3DVEhaNdoVGZacQBQTp4qOWC2Hb5NKmYVWj6Gn/BH+jcRt7yKi+Qmb?=
 =?us-ascii?Q?NQnqbpWcaqvsN06qWTsNEFvDMUiASBuUN/6eGN1Xtcwyr5iVaUf+EO8OWb5C?=
 =?us-ascii?Q?6zxucbiNBXHj4MuozTp0hRv+IpQyv3n/vGE9te78+iRdgHPgQnkQ5D5sns6D?=
 =?us-ascii?Q?RkGyi7arj+fqeBKkYYOoLV787itqzpg0tBun9BWuX1EMIFNG6iEyh66dCthX?=
 =?us-ascii?Q?f/YwxafT8vz6kD90crO2RHwzlvk/lx85Uk3JcnEjZxYC1foAmYEN17PoZPm4?=
 =?us-ascii?Q?N+iIYadq73fKhRdpx+mLOCsh5Vi6XqHK+/kPrrPQuueQ5Rt0iQQmIscZGhtP?=
 =?us-ascii?Q?5F5jnoRYFA1kzVmFFW4OBpGHQxLB5J8OXZQn6bnrVuYCfGDY4qVQKEZXQjwD?=
 =?us-ascii?Q?WZ97utPR51JBcjOo4ilK7NJkAAn8o1g0FN6orOPuYKv3tqSVEud+plLMfL4h?=
 =?us-ascii?Q?w44w6AlJAKvRNv8hVpU4O6GM/5KuxulkpbnlJdLstzDgMzZfEPNvdkIbXnMD?=
 =?us-ascii?Q?1i+QUy2fbb+WrAlY5GKJhN6pQupYdteSi3NugvxZvT/lpx0OvRYy2fzschGn?=
 =?us-ascii?Q?f0RqlAiQxTBDGCEFS07gacIKTF2aMWPAy1uwgc924BDkeyxYHmWmBzAQioV7?=
 =?us-ascii?Q?vL7zhfQFrEskJXjE5FEWUF1gRpKJWv03onyTPd1iKcg4wBsI+n0R2HUD1F7K?=
 =?us-ascii?Q?Rv1f/q8/VyHnbAs6cnTWUdmNmUXg8oBLz8l/PcyR2YxNgL30+s5On7Va686L?=
 =?us-ascii?Q?sIzAC18alXyD+SWuB+2nbLzqiaJ19dLQMpazGAAm61ckgcpopJecWeMPE/eh?=
 =?us-ascii?Q?haR+wbG1jliKdCisD9wfxa4oPQfrR3dJ2Cz63FvmenWdKoqEHvyn2uj+agto?=
 =?us-ascii?Q?kBORYwgfGaoGpVzBY7bY1FccUvtEK8J26aUAOLfCdlN02GV9NQNJFpduVDst?=
 =?us-ascii?Q?1uCsB9NqpLzse71vfv/XvTZGIopIADWF9rWRuh04da2rm7M/+9/JS+mQ6BYh?=
 =?us-ascii?Q?yVYzlPgcPTml710X9JHT+HNWWc8PAA/3F2AHxQ3UXrOhv6zU6Asr7mqb0jlW?=
 =?us-ascii?Q?QGDvRTHiZgg/wCzBsF5PbO1ttluJb70HBILZIUWIQwg7cDJLDNJ/Aw3vb/8S?=
 =?us-ascii?Q?XFXsULekDGPkN9L6v+7j3w4gMaTag7kwbxKJ4oEhpdNMAx+9JWDBAEipGQod?=
 =?us-ascii?Q?PF4RpQz6RKQ6x5kVh3RKw+lVcMejFj2Es69ulisU0KlKPAtb0n01ccFByvnq?=
 =?us-ascii?Q?VeaLu7zYPrCYg9EZtgm8lQO7uiUv+XHFhFguJZ5wLwgBx1Rtj0ijgBQWhUZV?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cbd81b-f96d-46c8-ca45-08dc16d3f64c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:44:40.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju1rh5FWAszlSJyGbwdVrSz4FmnwCDnKizqZxI8l+tWHJg0NxAW7Wdr6Enavj+5l2z8SyKmP0gxS8gGmnhDT0kMmxzP7YABwWviuaBoORac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5001
X-OriginatorOrg: intel.com

Samuel Ortiz wrote:
> Some confidential computing architectures (Intel TDX, ARM CCA, RISC-V
> CoVE) provide their guests with a set of measurements registers that can
> be extended at runtime, i.e. after the initial, host-initiated
> measurements of the TVM are finalized. Those runtime measurement
> registers (RTMR) are isolated from the host accessible ones but TSMs
> include them in their signed attestation reports.
> 
> All architectures supporting RTMRs expose a similar interface to their
> TVMs: An extension command/call that takes a measurement value and an
> RTMR index to extend it with, and a readback command for reading an RTMR
> value back (taking an RTMR index as an argument as well). This patch series
> builds an architecture agnostic, configfs-based ABI for userspace to extend
> and read RTMR values back. It extends the current TSM ops structure and
> each confidential computing architecture can implement this extension to
> provide RTMR support.

Hi Samuel, this looks like the right direction to me.

One of my goals at Plumbers was to explore the tension of the perception
of RTMR being a one-off (Intel-only) solution, and that the ecosystem is
otherwise best served by preserving TPM ABI momentum.

This submission clears that first concern, several vendors have an RTMR
concept. The second concern, after talking with others, is that a
soft-TPM (e.g. vtpm_proxy) backed by RTMR can support the TPM ecosystem.
Such a layer on top of this achieves TPM support for several
architectures at once which seems the right thing to do from an upstream
maintenance perspective.

I will likely have some questions about the details, but that basic
"should we do this" threshold in my view has been overcome.

