Return-Path: <linux-kernel+bounces-141412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626718A1DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852E71C24EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFDE85277;
	Thu, 11 Apr 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3qN8xu/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F11E892
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857055; cv=fail; b=Kj8w9x8XNu1mKaLYASZWW2rbmcm+qdE+/aIvTLdxGaNTW7Sbbp2JKUGx3hDS1d0LIZR5LbjUNS8NwMr5JwHJxXS92osO3yNT25K0+Wo3rL6QsZGwquvfKC6f6wDeoOzkrg4mdiIPegYGkExJAUQ5rSz6z/QXBF71T5bVCmMUsy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857055; c=relaxed/simple;
	bh=/yyyxdntoJXS+Luv6/uQefQ3xVoFTWa8f7fqvzVnFC4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JsjU/Djol8bRUzZkLkvffMF00l08LVeDp9XJiXzK48UFMOWyhjayIDGKmmwb+mNBS0mvvGuA2ipiCgarWoym+cRiU+1C++GtGs08uuJAfcWYLzEsM0tFIpjF1n6iVjOIjzQSEckzjl+k+AEAT8SeiVOYwx0Y08QsOfFL6AmOkJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3qN8xu/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857054; x=1744393054;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/yyyxdntoJXS+Luv6/uQefQ3xVoFTWa8f7fqvzVnFC4=;
  b=k3qN8xu/L1x8VDfRI6Ad/hXUl9VUd8d5ga4xo48JC+dDssmjl1//C2V2
   iPbSk4txXIRzsefzRm0v9T+Mmk5kJ4qPNxhhuuxgZiMk0ebqUlf/cPreD
   GE3uE+rDCIoGI26Qxtz39HrHMWrb1Wy2cIxT4m6ymUSSTcdewQkppHrtI
   B/kwSwFrLNi/I5DnmcHwFNMF+vC154FopmaBqrcoQ3vHQuEMzgzMZ5KLV
   Yo3Ni7MDcyhayJM5VCRu+ov5qxdnsz1iSWKTAAbNf7wupJS0d23yXiuJE
   7Bvp4P5IqVVkrjhRjnyJlF71t8Zj5APTvgW+qanSGI5j19QrLEBXIDhi2
   g==;
X-CSE-ConnectionGUID: XFZVSSkYRWSHro0UqceyPg==
X-CSE-MsgGUID: Ma6ImYFBQUuRvvw1OxFtYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="33682577"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="33682577"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:37:33 -0700
X-CSE-ConnectionGUID: p+F7HskqQ1WOOWrmAYYrEw==
X-CSE-MsgGUID: 6WinneohS7eJrBsuK82P/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25753065"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:37:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:37:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:37:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIB4CMIyoZpp9pZt0JcBqtyW8TS89OcHeoqO27luc7L5TGMbRTeWM55Zi8TsD11Kb+ks0O51pZ8hCiMUunidf8aAE96TeAMuFfLKShAnkXIK3TbPFWEKsAg+Bo4MOnKjZOLd/VL5Q65DOj1QQPtAZ1/aJYRmQd5sQbaxqYTDrFdSlmuP2gBJjQBqLO5osQShOFYCeKoMkFHoEA6EM8eFJAVOPSIOVfFk2kcy9CmJn58e0Q6lwo/qDhcBP8qwck37Db9ykWXmdsuNPi7XZnBJ/UIrz5jyB4WIOHWct5vpgg1pznkfNW99o9FLB9urHti48/d8238jF2X6viCjtBLbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAxlYTaITCo48Zn9yPjt8Vpxz2VcQEI8QmPUv0ldbug=;
 b=VfCkLRM4jG+CmaYjTip0ZWY12mRlINLBv04leW6Ne5MfiqkCO8I2pTPnfCsqu8ys/Lyw3sumuvBzZbbR5zpez5Ksx1ew5LDs6G9l67Ur6/NeADJEeHsdG0S7ITIDXLq3LJ8iAqeLr+AZeXztL0hs64EOwgq+5uLRzlOsqKyFq50FmJc3ZCGAzSp3jgnNM5Myo9LZRFpPblGXrZPKFEwwWKfr+EKR5dTY94q34ye9Ktle9jW/CCvAzaqRM3N6lhD1C57LgO5y9xR8JK+slKB1QADOtIwj5AsXlyQMSPE36pgs4CY8HbO/4J0rEQ88feUEqQ8zAHlqUNt8oQGgLMBTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 17:37:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:37:29 +0000
Message-ID: <f919fdc9-e0e3-43ad-979e-024ae0cdd997@intel.com>
Date: Thu, 11 Apr 2024 10:37:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/31] x86/resctrl: Move monitor exit work to a restrl
 exit call
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-12-james.morse@arm.com>
 <92187846-374f-4b45-865e-543ba198b6b9@intel.com>
 <Zhfwe6Xhyec20LzC@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zhfwe6Xhyec20LzC@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:303:84::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1dbda8-959a-4812-e1c1-08dc5a4e0f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZdcrcW3eY1xhUeDKLXN19AMrY/40mqbefj8wdaMsmGrm6qCHMp0ld5h5dTq+BCbXpWtI+Emje54zDhsfCvCB/xODLDzxJ4DbbzA2JG1+4Qy+tRADwEbi78J4gr4VmL9z4zy+Psa48fN4l9fv5fL0XO8CveJ//1XuAmjKvgK+NQWVfT1oW+cKHA40WcE2flBgv28ouj9n1oeGHdo3/tK/twPtP4PKRVOqn/HRRO4rRubaiafU0ki0iw1vc2NQ7n7nB0e7fpmGz6aOnBoLbnx9re+b4RrL7ExTJLdZlCEBJQCWhVa9bQ3/oDMmVo53Pxv42gtejrRkPxw8nLEU54ZUu/Jq8mhF+13M0bSbmSok3cVvv2tKIQIBLrswMXIw/pvQ/gOSFEqtb0ylKsEkn+QxbIEYp6ZTISrHjgcCPq6aJ6+c2ZgAoJjoyi7w8TPCdt6RJv+89NkYeMRLBqCDLADbbTIOQvM4A0MgWiwwOvxt1tzm3OURU1KRsyjZO/zOu66YG/xMeUzcuvlSYa6nyMhr4WODBav5BNlGpJL0IzZC60ipMFmWTF+iDOLLTsjX93OisQScdO6NUK/LaeKAuu1RqwBdna+gXWiknVFpp4hNzzrLwlItP+kB1vs2ZrpwwH3gS3MrVJO2f1APaVdMtir+DP1im7naOtkGQTcCz8udR8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3JNL0xLZ28zd3g1OUN2ZVBUcWNQb2R6OTBuajh3TVVXVEFMQklCU0VRQ2N2?=
 =?utf-8?B?eGJ6ZFJ0Z0sxb2RoV0UwcjBHbjBCZW1BUVlpTkR1cHQ0b3ZFazhva0FKeFlV?=
 =?utf-8?B?ZGpJZ0tRa0RqVW12U2cxR2RDZjhpYVhoZzVFMDF5eGEzVzJEd0pmKzcvckVG?=
 =?utf-8?B?RVNCQ0k5V2tUcG5yaDZCWVB4RzR5VnpYeUdwK3hVcGJZTFIzdS83S0Y1bDVm?=
 =?utf-8?B?QU84WGlCQUlrUzN6NGp1OC9zWXhsSWl0SmVQL2lsMHR5ZmtHNi85ZnBhR1Zj?=
 =?utf-8?B?b2Rwcm9VWldQMHVyR1U1ejJQSCs5ZTVFaExMdHJoMkVxQzRkMkhjbi9WSmpu?=
 =?utf-8?B?S0lDdDlzVDhibUxVWVQ3bWowYS81cW9ldDhXdXRjaStQdkg4cWlNSWszeG9L?=
 =?utf-8?B?ZCtUVEVkb0grRGQrSFlOTDFiNHBsZXlhV3E5SStBbjRzN1lIK2pCNFlCTTlQ?=
 =?utf-8?B?dUc2QTJGM0ZVNVJnbFU5aVJzc3Y4RzgyM2g3cHF5M3pqei9qbXE0ZHQ3TmJt?=
 =?utf-8?B?ZmRpVE5tTWd3aWJhRjFkOTdPWVg0dDdBVFlRN1ZieFNKOFRCVVVBMk1Db2Vi?=
 =?utf-8?B?WjVsU0o1OUlaMGxwR2Uyb1BSMzJTZ25sNnhndldndDRXS0EyajNZUHczd2Jm?=
 =?utf-8?B?OEtDSVAxaEJrWkd0c0psSG0vcjNMZ1ZRcXZUbDJUYzk4N0RKeGFlNW9NQ3pq?=
 =?utf-8?B?QjIwc3I0emd4dzh1NnQ2Wlc1MTB6Q1ZrdkpZT3d0MGZlVlpoRVRNMm9pOXNv?=
 =?utf-8?B?UXQ2aUV3aUgwYnRkdi9paWRhN0Voc3NROHdQc2FsVkJmZldxa0JPOHNLN3do?=
 =?utf-8?B?SU5CeUFNUVIyNXNzRFRzME1iSlpTVzNYL2J4UG9FcHdPVWFjNFYya2loZEV5?=
 =?utf-8?B?UHgwNWtwWkRjbllGUGpQR2ZqQm1SdkswSkNpOTFvaSsyWXowVDRtVjc0ejBE?=
 =?utf-8?B?Z0RlQkZ5ZmIrcittVUpkYSt1LzhLRzlrVFNCTUtrUlRTMDNDRTRjRjZKU1NL?=
 =?utf-8?B?TmZ4eXFSQTRRRTdmZDZUeVR0ZGg1WlpaZkI2OHpFbW9vRVZIZlg3c1lmV3di?=
 =?utf-8?B?UUgvL3plYTVvY1NuQVRXcHBydnN6dnFNWlFpTC9HUFJrWnZiaDN2TkJmOVgx?=
 =?utf-8?B?NjVLQmxuaDEvSE8rdGRKN2FSQlhVd0xpNWhVblcrOXRCY3dhT0theXRoVXMz?=
 =?utf-8?B?aHhrcVp2SURUMnE1N3Y1MjB4TkUvVlc4djFCc0pxREJWUVlLUEczZVRXTkp6?=
 =?utf-8?B?VFpNWitNc2FtN1N1dGFwVi8vbEtVY1ZuSGViUjlldkJuT0dkQmc0Y010UEpx?=
 =?utf-8?B?M0ZPOGpRczY5SU1BNnFuM2RRYnp5YW9kK3kxN3VKTldMekV4SEtnMml3Y01l?=
 =?utf-8?B?TmVKVEdwWUwrNHdrMXpBd0xpbVZXcnlJNTJvR3ZwSnRIRlpuOElRd2xwZENz?=
 =?utf-8?B?QlV2bW9FclpzNGNpM3lDR1J5WVh1Qm9PancrdUNid0lIOEJ5K0tKSzZqcnN5?=
 =?utf-8?B?SjUyNUgxa0k2MGRrNkxSTGxhaWlOWWNmaTdxUDJmY29SRjFSZ1ZuYXYzRUpa?=
 =?utf-8?B?eVBwZmd0bHZjU2FoUjNyOEFsVkpueURyUm1HNXVIdDRqY1RzVWlURmtza1lL?=
 =?utf-8?B?NCtKVXJ6a01nbmtEeEJsREF3RHlSYzRIY01NQ2JSREZyNkwzcUlPNTNvcGh1?=
 =?utf-8?B?aDVXVHc0OHh6RkxtcE1XbStiMVdpWmpaQjRELzVTOUxWNlQxOGZRbHRFUEYx?=
 =?utf-8?B?YlNwZ29aZEJBQXJTM0dZcDl1NVRuVTQxTVE4NVlWSWlCMURtbmdhVkI2WmF6?=
 =?utf-8?B?alhhYStQazBmL090ZG1QWEhWVzM3dWpUNDVlcWFnaE52ZUtpQy9qZ3Rha0F6?=
 =?utf-8?B?TUVKeDYyL0E3bVc3QlpCUmtsdUhTOFUxenp4SXppVHdWajBLN3BZWldOSDYv?=
 =?utf-8?B?MlBDWERpQUs1M2hoUTZBM3JuNW40OWVCYmx5YlVUVnBiSHJPakw5ejI3MXBD?=
 =?utf-8?B?N3Ntc1FEVmE4QmhDTVFlSDNpZExLK1Q4Tzl4eG45Y21NS01mWTdDc2t6SDhv?=
 =?utf-8?B?ZERLaERHS2drQTFhaVpWRXFFdnZXbWhvNkZXZjUzYnFjcjBzZkFQdFVsUFFo?=
 =?utf-8?B?V1R1T0JJQ255RlFIY3laUVluZ2IvbDg3aDIzdHNaMmduc0lRQ0lRUjhsc3lp?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1dbda8-959a-4812-e1c1-08dc5a4e0f8d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:37:29.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJDg/wf+oelooiuzD2xewMYnJQvliEpzB2rsSbh4Hdf7z5iKb0JIzv9fAZJjKJRW+icgB2+jzPiTTCnZwVFg6jYCIlvKW/CAAArstqURxPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:15 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:19:00PM -0700, Reinette Chatre wrote:
>> On 3/21/2024 9:50 AM, James Morse wrote:
>>> rdt_put_mon_l3_config() is called via the architecture's
>>> resctrl_arch_exit() call, and appears to free the rmid_ptrs[]
>>> and closid_num_dirty_rmid[] arrays. In reality this code is marked
>>> __exit, and is removed by the linker as resctl can't be built
>>
>> resctl -> resctrl
> 
> Noted, thanks (also, there is "restrl" in the subject line.)

Thank you for catching that.

> 
>>
>>> as a module.
>>>
>>> MPAM can make use of this code from its error interrupt handler,
>>> a later patch drops all the __init/__exit annotations.
>>
>> Reminder:
>> https://lore.kernel.org/lkml/85f8756a-23a0-444e-b37d-a7817b600f46@intel.com/
> 
> The "Drop __init/__exit on assorted symbols" patch speaks for itself,
> I guess. I think it's probably sufficient for now to comfirm that this
> patch is deliberately not changing the annotations for now.
> 
> Does the following work?
> 
> --8<--
> 
> Since there is no immediate need to change them, leave the __exit
> annotations as-is.  This will need to be revisited as and when there is
> a need to call these functions other than at __exit time.
> 
> -->8--

Sounds good. I find a big focus on the __init/__exit annotations
distracting. As I understand this has nothing to do with the goal of
this patch, which is to move code from architecture side to filesystem side. 

Reinette


