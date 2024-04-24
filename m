Return-Path: <linux-kernel+bounces-156270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9116A8B0091
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 020A2B228AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D6F14265E;
	Wed, 24 Apr 2024 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHuX+6PZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF41422D4;
	Wed, 24 Apr 2024 04:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933010; cv=fail; b=kIHI49N8ISQ0FtWSOE6/q/xCYx8/Wjsf8+ubQZFpdtnKIrshIA/K0qrlMDDc1wjgoQmhJcPwBbWuC/U2TjDzgXU3zIEmsAwB5WRMTnuuZr3kntyTQ9wVTurDKYhqOcXK5JJG/vwYp1zQiIGCiNFLBe+qzDTLz0RPR2E+6fKw/Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933010; c=relaxed/simple;
	bh=nFRGdbsW9q26o3SERls9l0mHBJnGKG4nWhaSEMWobeA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mkuVW98HQaaV/R4U8wkNIWzPnUdVrweks23oUgNSrkLdHbJwmv32SHF0JpygqgcnsYcvrz3b0R2ry1p5O+nmUUZI9GXHn7cTlziIj/dZxQ7pIjYCG91dkr2LCipnCssnC8lHZpc6wfgOoV9rkZ9it5ii8YirPUf7Ah46ruDbjH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHuX+6PZ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713933008; x=1745469008;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nFRGdbsW9q26o3SERls9l0mHBJnGKG4nWhaSEMWobeA=;
  b=LHuX+6PZHEBo0xKcqna3OqfRB4xZIrsVSVUxcNeVKBNm2K32hCiEWctl
   1tzHrqJIgHoClUH7kpqW4ZQQgFBisufZMTM8jIiHKDQNbbBP07xOsx2a3
   liWrn1IDzO5D41zzYBRlPOYZotiM7Mw2twaDnPSvJKLjqHbijZCcarXNz
   +iyuWqfjIFjHuMNohdlZfi64s73lW23LZeTMId1KvWt1/QcLfZmO0y7sN
   EcgKjxUGzxvczo5ItbrrLt7qFryQp2oJcaOPhzH+HfKhtkmoui4IPSx9+
   CsYG4qVSAvtWC9Fq/lESfvJapk9s7b83CiVkH2KZr3iMUkudKA37VB+OS
   g==;
X-CSE-ConnectionGUID: KVpOCdf4QCSuxMrEFjhk0g==
X-CSE-MsgGUID: 07G1yMh9SEutdpGXlQywwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9470980"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9470980"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 21:30:07 -0700
X-CSE-ConnectionGUID: WlDZ9+S2SvqAVakMIS7BlA==
X-CSE-MsgGUID: clG/llTfRyCSfMkxKjIouQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24622385"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 21:30:07 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 21:30:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 21:30:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 21:30:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0Y2fE818kkoBRKPwAAXIorti/8F/t4Kr7Fs056zWLX+KtoqE9SoTUmEoK3uSV5wNOaGoMgxCxzWen7nw6ImLzaJN/Da65F9s5KNirb/HyRz/XXQu5wfRCKHfxYjRowODXx6u/+Y70k95loiTIrK6wY1xXlh0wiHRhMQwruWtlJcOm04Wallv/jK4c4nNp2WdDRse20yAzW9q3c3yeVjFRLMHHzMH+ZpzXqfdF7Yxu2L3vPrlJ1oRJtSNdUzpS6MZ3AGxB5PEjzm+bDOf/U2FX8ni/MF3yjG8z1zzegbQGpqn+3id2foAVrSQiZj+CM6IzAeRNeQtgb9IpbLW9CPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gkb29REEqAj6KD04b2tNu5QXiZKSbGEldN37s7GVbTc=;
 b=esZzNUJPXFgnjYx2icU5AgPPoKFhbyiTKUZThfrGpWFtAmwJMutDb5CMafr2/1nItpccc/cCrQjjiM3nFT/OACwa+sSPJNvfRQ+RC2ryhQnqT8Lfi20XTORl4Zcwnx6UDptVmeoLn6x4SQ66dO/rTTdBdRtfyhC07QVWWXnUuLriuUDGrEmRrZVKyRmGMjxWLl9GrHpXlREWEfDPv1VE86fJx/5ctrXSfs4A20WgzT9VIjCcF0i8CVs/Erbn62GnJPj+StEmGDPP3M0IZHDlSoI915/+JtPG14/FAV+019YJabU3+hDkwirPo27WgSyLpOH1uZ0+95FMbGzw+WEd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8046.namprd11.prod.outlook.com (2603:10b6:806:2fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.30; Wed, 24 Apr
 2024 04:29:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Wed, 24 Apr 2024
 04:29:58 +0000
Date: Tue, 23 Apr 2024 21:29:55 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, <dan.j.williams@intel.com>,
	<axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Dongsheng Yang <dongsheng.yang.linux@gmail.com>
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
Message-ID: <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
X-ClientProxiedBy: MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 95528d86-121b-4d2d-43a1-08dc6417332f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3pYSVUcJ8/gFKPbOzSiMuxlHUQcB6QNybDyw3mqU3iRp8LBjK3nf4KROIA5E?=
 =?us-ascii?Q?8RTo8mjhBLTl+0UcXZrGi4C7t8PaQhYubSVF/aTeW7HHay/1TG8WSc43wKHV?=
 =?us-ascii?Q?9PG9XhBRIiQ9GQRBfEjBvbQ6iCyohGyv/F+DEt+Bpq97lNTJuQDU3vmk6tQY?=
 =?us-ascii?Q?6dn1WRVHE7oVDNkWqr7tHkJuYMPU0k9p9tw/I648aZ5ZHeCoAv1FMCtHD6bR?=
 =?us-ascii?Q?dGwLaF2WKB5iL3g/0ZtigcisjLzMBHuHxI4xH3rslEpXZSw+S9GkDhh0HyuM?=
 =?us-ascii?Q?sYcmb+h+4d2R7auMMbG/MXL79VCkC33VIooentRfVdODx0CtBX9z2Q5DbW9Q?=
 =?us-ascii?Q?K8Iz+mtPpxJCyf/ANv4a50uYgHNzkYcc/d73uc2Ee5SUOcRcertF2arWy6Mi?=
 =?us-ascii?Q?V5Yzt8xvKU2zXWwPgUls0+xXBCsFBJLSpr0NuP9KHBE+cA873dROriYP0pHe?=
 =?us-ascii?Q?Iy0LSaLg6PUk8pXDyx4ELxl0XdUZ7UjzpRYtiQGY79dBSaS2zH/WCLYQLcU7?=
 =?us-ascii?Q?k9WXcfUUTAqVsWbTTNh/P2fvEOgtAWnIkaSYk3TMiuQIjA1UDkt3b7tZqkZg?=
 =?us-ascii?Q?Os92+PZ4Fid3bEbyJU280ez9ww4IK+fBAcnLuPMT+/W240X2m4PWNzfIaEr/?=
 =?us-ascii?Q?HlpUpsdLvlXp2zaB9cr74CU2c/rTOOTd/FTVhi0GfYpnaK75fRvCtqNzV7OV?=
 =?us-ascii?Q?JJejFq6IRGW4x8CjsavhCNrKlaoEaeMN/5abqFiwfXhauGAL3eYsoYrASEi8?=
 =?us-ascii?Q?3IHIbAKCK2AZDjtaaqCZ7XZ1owgIKD8w/8IT/HkHMXYIq/NMIFphG3aRjjRi?=
 =?us-ascii?Q?UnLwUP7T2B5BV0x5MzGcD7KGAPJn3CRVVREcL9PHySmK3uqCVc9YM53ONFPf?=
 =?us-ascii?Q?FHT2sYQwssD49+4UTcXeWB4pFQ5bD+r9oZHIh45g/yTtwKvBM6dgFzwgrWM3?=
 =?us-ascii?Q?bntxXcevghAUQ9xtdN/2f3o4eV83ShyhmvZu+061wUcMZhTybEtsLzETF+fX?=
 =?us-ascii?Q?BrSWnS3GGxcWFsnwPj2BPjPoWYfxAhSDgaZOAA3Y6QUfjLY+eFLd2nCsxqBI?=
 =?us-ascii?Q?5IBSDLiOm7hhGMYWpHp2PKquGjZlav1zDVYC0lqoL7QN0hlw3TAGvEtmXyDE?=
 =?us-ascii?Q?mOOgohBVMihue3iIuED0It+eOPdU+sCxKEXVPbVAO895mvFipCDh4FRer5Y+?=
 =?us-ascii?Q?utHDbCDZab4956eHuyFq1OZ0uT9ZOg8UQ2j0bffn86v5EC29SjhX+kqqJrgE?=
 =?us-ascii?Q?p9LEPgRUZnPCxjt9fVLwT/UhaEZrTRKJg/YYfMTjLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+aYCOFmEcz9QjB3MxpQ4ljpBQyU1FNciVxq3Jk5Tc0tIyKc16xyU4vQxmD3S?=
 =?us-ascii?Q?+3ce5phFwVnnx+vbQg9X9UXjoxzAdAWKAOjsd4vxpJgCWbIuFt46vz6s/WVs?=
 =?us-ascii?Q?q8bHWDyYKHDfXMkwZgCSJLPoOmWCg2C26Enrz+NxV4L9mdrHTCRBoIjioIeZ?=
 =?us-ascii?Q?YS9hyC/trr+da+c7G0S12gPDgglpUZBtFkarL9jGfehHh3hhCcDl3WlHSB8X?=
 =?us-ascii?Q?X4rX1n1LoQzSGFvptBnx+1nSiqU8/dr5GLhRVKZwOx4z27Sc7xkI6ZWCwu6t?=
 =?us-ascii?Q?7tyCcLJC3KXuYTl03uN6w0Loujv5PgZblF54CCv+MNPZDZaJ0bdrdYTOULE1?=
 =?us-ascii?Q?GReWpi7TtHxybkDc/Q8rxQ7S/zjHNRSFFUVxXDRPWwUSMxkuIWk1gkXDpGk0?=
 =?us-ascii?Q?DtCBGkqtv1t0vf5XpnqvAxdpePkfasYDmio6fkABcqBn0gAIdguLEjvlwf2o?=
 =?us-ascii?Q?hmzNe7iCrMH3O79hBjKWf0LwhUMRyH9gr5JikvdXAKfCjCRLX2wQOmMJA3WS?=
 =?us-ascii?Q?4lDfkyaMRsQdm3D2vHOEWE1rhoQ16ef5E6kLQUrHDKWbSVI3QLzQ7A4nIpoV?=
 =?us-ascii?Q?sDNDFnHbSyZrv1XfiNmpmg1qMi6/fBeKwJAiR2uuJM/EQyAyZiMEWGP8zBtZ?=
 =?us-ascii?Q?esvhPvMGL1WOh9cK6A9zyPQGvBVjWBXVLlTSP1lZelvBrQcPCQUz9I3KnnLq?=
 =?us-ascii?Q?S9Rk/TQpF/JMRcnf0I5x0KjwP+So6elD/jwG8zJb3CceY0TZmj8C4laJ4ZJ0?=
 =?us-ascii?Q?Z+FJhejhUWlecNk/H/Z+sSgjL3YVxUu9heTryg9P9DAZW8knlUJf3TOEnWza?=
 =?us-ascii?Q?2e3xOSnDCAJALbQ3xS6cth0gvBT0nTGH4/HhDTK1yqM5/ZsF04QagMp8JtIA?=
 =?us-ascii?Q?TSOHWEHHADTgUarGuHjJNxRvAM7oENqbDyRUNb2MOznibw5B4fYrpLRzm5P4?=
 =?us-ascii?Q?eVuasIQIuqPJQbZNCQy/qRx/ZE/+PR4CBDj1nkedzSPvDWONSvvxscSBOzBH?=
 =?us-ascii?Q?TrbwM0aMRrTpp9BSdHJCmduCYWdIGcTHR20p+MfAkBsPrtCUCB8uBopouOLA?=
 =?us-ascii?Q?1bhe5SRZ5ZuYhOWVh8OzineUXZJfibBk7ZsS+QV1egP1fTWiYaQnjCUoppRA?=
 =?us-ascii?Q?xPmpUn4aLJNow9nKowr7aaMdK6JtD3ppO2xPAUG33o5WPnHAnkzobiTXEdOd?=
 =?us-ascii?Q?ssyG16Uxe+npNdYEI+H9B6VHkl6qYog+afS1vi+KUN5YuBVLdSx+zVgOrJRU?=
 =?us-ascii?Q?UwDP4eaiO1LSnqwrbigH1vwHH0ibTFbT4uyRU8YK8Byq8PHM0mDgg86JZH6E?=
 =?us-ascii?Q?PXiRnXdd6+rok8yywTwqGMvOuNX4IehlwApReShrbji8/CGHDuNifb8hey6C?=
 =?us-ascii?Q?NULZxD1x5X6xqQZpBcbK4Fnmpfx/Mb3SS26XX/iZb0hdZ/5GVX1v+M9O6ONR?=
 =?us-ascii?Q?AX9ITOhWi2GptLRSDr/Oz/1PguaKkioLShO4lZESfpofJGf0gaXzcaaWbJQH?=
 =?us-ascii?Q?xHnhWJXASNHNhSZUNtTTYqimMU9M+z3l53SpBjZt04WpJsJO/hf+JGhctnNN?=
 =?us-ascii?Q?mgwuEpr3SAVXGqWPHEVu/zqOvWBaz75Udl1FWyjmGiz4AqAiAd0eBncrA/zp?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95528d86-121b-4d2d-43a1-08dc6417332f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 04:29:58.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gbnyie4J57pO42BLbIR0mNi/EG62ZXXnIXFDFFMPCdJCJ4KAwGQ03jZQc0LvVUWydT2qd2ZhukyWY3buZlQuakt5+uzcfvj2zQ+8kZC4YBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8046
X-OriginatorOrg: intel.com

Dongsheng Yang wrote:
> From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> 
> Hi all,
> 	This patchset introduce cbd (CXL block device). It's based on linux 6.8, and available at:
> 	https://github.com/DataTravelGuide/linux
> 
[..]
> (4) dax is not supported yet:
> 	same with famfs, dax device is not supported here, because dax device does not support
> dev_dax_iomap so far. Once dev_dax_iomap is supported, CBD can easily support DAX mode.

I am glad that famfs is mentioned here, it demonstrates you know about
it. However, unfortunately this cover letter does not offer any analysis
of *why* the Linux project should consider this additional approach to
the inter-host shared-memory enabling problem.

To be clear I am neutral at best on some of the initiatives around CXL
memory sharing vs pooling, but famfs at least jettisons block-devices
and gets closer to a purpose-built memory semantic.

So my primary question is why would Linux need both famfs and cbd? I am
sure famfs would love feedback and help vs developing competing efforts.

