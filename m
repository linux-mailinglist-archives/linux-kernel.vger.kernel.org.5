Return-Path: <linux-kernel+bounces-137722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D286889E65D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F0FB22C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B336C1591E5;
	Tue,  9 Apr 2024 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtFmBywq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7E3158A27;
	Tue,  9 Apr 2024 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706450; cv=fail; b=iAB9sJ8LZHJMIJMkNvDCCnfIpJIfAUHyUN/uEVEvT8P7o0pHqoRUgM6vDEGeRcquDhd00bYsNR839twFL5xDFRh3JUnUwjuZELMdPeqJAibzcPexX6NUaUeIMEY4hF4XzfkPKzLqC2sOLlYaSpfSlv8zE11NTDZhE7o5O0Rza54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706450; c=relaxed/simple;
	bh=rxRguYut+kmmv1TNLyx1+a6gxFkuwrpxxA+B1oI+lr0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bCN/5gFx//KQLijj5ZPrJGkVI1G8E4jAvnJRkRpsJQJRx5/uMNIgrqps2zwPcdHPlPL7wLsAUpVAaVB+vH1dgkI03cmPhsGZbE1PGjVYA9T57aVi8LNQyQfFpeQCcEUSlcTuvncSPrhD8k5lHxpB8Ngevui+lTddUQ45E5L+q74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtFmBywq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706449; x=1744242449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rxRguYut+kmmv1TNLyx1+a6gxFkuwrpxxA+B1oI+lr0=;
  b=RtFmBywqwOUfQdAS8eOy9+6dR/MMuVXhY9+Hd+JLoa1RlaSFP2tL0Txi
   jWnAV9gRgZOaADcHA31YdILXNdeBvnr272LJLtEIEOkY/fll11lhedUqD
   PYLjnbXuZs6sH+ng+vZWSs8IXyOcNQ76/ANbfF6NoGpiet9RufOQxfH3w
   hjNNwN4QSktdgdmR69TRIPcwZhdLvoM3OSAtqg7o/PnmBKnzHZAeirH3A
   vcmqWgVpRf5gZUjfk4878aGl0XuKIC/aIJgFcxABGbFgoLqlangK2+/lS
   30F8NYvfpxiFszyXG/c8UrTSRoLhb9tqn+G/vyGFNVVhXEsiFeGxPuKBJ
   A==;
X-CSE-ConnectionGUID: JjSAWvYfRL+vdFVfwcxyIw==
X-CSE-MsgGUID: 8i9s0+qMR7GL2I/mod7baw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7919315"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7919315"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:47:29 -0700
X-CSE-ConnectionGUID: 14u/NxUiTri5PV6iYVPIAg==
X-CSE-MsgGUID: /QxfvtMiQ1+QCwr1ph5Pdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20855041"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:47:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:47:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:47:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:47:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBdOFkHIhxur9oIo2qmR646t71R0uxFAxejIJKAZ907eJQFDqDL6cpUMfS7b5Qepmhw1/eFSlNtxZxPBlGugX1grdLCTfH9i5gO85XYTZGkQyn8RjEWqu2nJ8pDgsU6cB5tbIDQjxLbQ8Ist6EHkIvookfKFYTBx2wAQmGnSxP6IlHtLYNdLBraRRVrwdhRh/y9SYojjP36DLGtxE3dKmdQ+BV69X2QCYpOxpsgvJ45grtL+VYPItK8djhiYE5SyrVyImCFUXAnYWAR6zQODEn8xO4Tjk4D2cuNzD64LLY3U+aBJZRl2VH48CViRdTtX/eVtqHIck3J+TcM/E1xmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec5BOsCHf9Mt090oZB2+Cfic7dnQsCrfDD4PptkCMYA=;
 b=O+icGQDTpGLqlBufVIsvEMsn6gGxBAwaRKfg/M2G66njEbQdGzBP3YGjLXatC+WC80QH1+fQCn2+ai72qDtHDGfmK5AyfJA1x1W6iUoTmQT6qWcWm8FqXbSy2cvyrOwN4gMmneSAtf+MwvHdU86DGxzLbvfKF6ZyIPDDAstltuDrsQxWePLVFoxrtXO6ywEUM+f8mhMaESw7tdXFBEQSoUKARWXxkTM767vNTdPH2K5QOs+UWyQQqB2w16EoC2HqSSVWoqfdKrGsxrLl+yVNd9/xAUquYeHXm/2WrNbP7uQI88zE8avA/ge4sBqv+ai5a9vq72JamfA4fHOqj/f4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 23:47:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:47:26 +0000
Message-ID: <5efeeb03-cbb2-4c79-837b-55ccbad28ed9@intel.com>
Date: Tue, 9 Apr 2024 16:47:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH] octeontx2-pf: Add support for offload tc with
 skbedit mark action
To: Geetha sowjanya <gakula@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<edumazet@google.com>, <sgoutham@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>
References: <20240408071629.26390-1-gakula@marvell.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240408071629.26390-1-gakula@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:303:87::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFcGDmXM962ioVPBxD1xcq39VbKNamQNuIzugaUcJJcW4n+os4DJuF/1W/WbsdH8JYjdpHJV5wPuf/pMIPpDXWXLThqNrtTsKTtmm0Jt0NVeNEOXRT3pNEolBc/QV5Ih7X3RBu4asXhR7xUrk6Vz446QwNi/kNrzMlBcHg367/6wTdowLamo60keiyX0WPreA8OuBfi0YeWwQ/KcfsoB4tlBxYRaVu4100llFRDNagaupXDUAnyfUTq+IopOflu1A7N3b6PesejvvKgl09Jwrw27SA5q4Ru1TZwfK2L7iRspcPqUiFUmRsYGPTbfqK/FNblvmxmeB1ycGaWqIR+SWWtbKcMGAV1gZhtFcv/Afyexf0XnAHO2xtKWzfkuGMyLCdeQmrJV9gDX+RQ3+i4Ic/ViyCv2npw4dGpYE7XmmKaOAjTQdvAIjP5/+5rm26bwnGQpQS+7JBFrG2V8azAOIqt/q4gH4D9OazGtWSBCg7jFd9NaJT5ZTlhMXF56fszGVNIoxj8wORjOiXSdZns4SwXx1d4S3D4dTGHJ9yXeCLFx6F3WOW1W9CcnWu/tEIASo4Kq3nn24dDdq95FeI2pecmd0L5d5wcSzcYr7Pu683ySAWeIFM5sHcemxULzR4vTMe4VJTOsJHEVhKtPqoCXxGQ1phKKlFEF9HZ1lz/beq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXF4bmVYOXZBOStLYXJjVjJTU3RGMVZPSUJQRDFYM3N0cGhaZDIyeHV3ZVJU?=
 =?utf-8?B?SlF0Y1JrZytEVE15bFNWaEJNQ0xFTTMwQXk5TzJyN0tFbitHN2RxOU14U0xL?=
 =?utf-8?B?cFVzS2JZRDN2YXNiVXFNZEdEM1V4T3kvOHQ4UC9ZcVkxUFZ0b3liTVFkYmhQ?=
 =?utf-8?B?V2xkcEJOaXBFcisraWZjaU93RTdSQ0JiZE1UdDJGRGtKT3F0TGY2QWl0d2pF?=
 =?utf-8?B?YUIyVGVtVXZ2UUxFTDRublRCN3NqUU9hTElyblBXc3ZNMU15cTZpWUhlVHVz?=
 =?utf-8?B?VnpON2tHOEs4OW1RMzRZdndPaVAwRFFnNkZSamhxN1dUNXBmMWZkczNPaHlN?=
 =?utf-8?B?Y2xhdldPb3R4Z0k2U3J5dE5sU3Q0aWVZNlhjcTlJdWxrQUJjMVNXNVNzcFNn?=
 =?utf-8?B?bWdnU3k3Q2tzeDNiRkYzSk1rOUQ5WTdQVnZTMW4vRVZSd2NHbEhZYmxsVHRI?=
 =?utf-8?B?U1dRS2QyNDBnS2JReVg5clAzM0lSZy9DUkQ1QWVZNkloWEhZNEoySGNtZ1c5?=
 =?utf-8?B?c3Y0R0tCbVZBRHZ2ZWFOdHNlamFUL2JKaDJHbFk1SXROZFJsV1RlRVpIbDk0?=
 =?utf-8?B?MkYyVGRoOVFxVUxhekJSRlJyNjhLcjI1SHdEWEpySFc5SXRvbnBCeksybjcz?=
 =?utf-8?B?OGMvRlh1bHhzMVNrbEFYVmxUenByODdOakQ5VDhoUUI3VzFWamhoOUtiMkVh?=
 =?utf-8?B?RXJDUFBjRGhZUUIrN3dHNXdxa1ora3VLeWVTTjlPcXRQN3VYbUsrSEVSaisr?=
 =?utf-8?B?SG9hZFFKczNFRG4xY2hGRHk1ZDNnL05YdG5mcXFJcHFBc0IzeVI5SmNhZnZs?=
 =?utf-8?B?RW43WFF3VjlRaDM2M1RkUWFXVTY3dEc3WU9ib0hsVlcrZjN5L1hvV1Q5ckky?=
 =?utf-8?B?VkFnTzFSemVoNUJRZGo4cVBpUkhMdjVRYmVBaFB4S3hhaTR0bTE4c0VSVGZo?=
 =?utf-8?B?amZLQ0J1MlRDdFZlcmJnNzY4cWJ0RDVsakJVcWlmc28wSWgwV3R0WmdxWVdx?=
 =?utf-8?B?WU9LT2RnYW9HWUhWYWVBUnFlRGJuVlZrZ3k5VzJIOUhacU1GWWp5Vy8xb1lu?=
 =?utf-8?B?YStVeEFNZmI3Mk9uclVxbVhNUHdsMkhkeExGeVpqbUUzY01UaU1VVU85ejdy?=
 =?utf-8?B?V2F0NGJ3SytsRmZvaUhJelAzVVlLZWxwZUdEN2Y5amlITTRDTXh6V21rUmJZ?=
 =?utf-8?B?K0Y5dEZ5dkJuRktGKzB3R3l2aHl5Y3hkL0YxWC9aVjQ4V3VRRlJvckgwUmJj?=
 =?utf-8?B?enVtMXBtYTJlYmw2bjVuajA1N0Rwa3ptK1dZQUxCZW9oMmFidTVZRWFmd1V0?=
 =?utf-8?B?ZTYrSnd4MmVSODlVRVYwTFJ1alYrdCtXYXd1cVlCZHpGaFF6MEpmaHk3UHpW?=
 =?utf-8?B?b1BObnlCSGI1VzhVckx3dFdVTjhVRXdjQXF4VmRUU0gxU09FbkEyYTZEbytp?=
 =?utf-8?B?cTM4QmR4eC91ZVhlUldtVzNWNEIyNGJtMFZKRHpNQjk2MHVCVERuM2pmVWk0?=
 =?utf-8?B?d3JaMjRJUzlNa2FEdVFjVGg3aG4rUThTM1dNMTlrS0RMV0pKRTBEMDBoakVI?=
 =?utf-8?B?NlV2OGdhSjNOT2ZWdlh2SXVCVkxOOG5JNXhMV3QvZWZWbWZmdndLZDVkcng4?=
 =?utf-8?B?R1V2dFJGM2NKU25ETVBzQ2h3V1pRQ0dhdnlBaERFRVBIS0dJa2dqMWpoRG9T?=
 =?utf-8?B?cmdTalNuUGl0R0w0dU91WkpKc3NHc0xpRzFXRWtBcmdmaDRNNFdrK2J3Smhs?=
 =?utf-8?B?YURtYWlUV2svTHNSUHp3ektxbFBhN05pK3crNEVVOEw4cEgwTkhNbHNKaVpq?=
 =?utf-8?B?OURIbXB3VnBId3QySHNWTUpFa0FQdFRlZU1qdDJEUU1veTZiOEYxMkhDZENy?=
 =?utf-8?B?bUR6N2VrZFI5eVBDc3VpQitOdU9SaEc5em1qdDFKVyt1TjJXb3pPb2VrL0tO?=
 =?utf-8?B?WG9qc0IwMS9VRU5ZWFVzUCt3UWJaK3pzZFlWUmNtWS9FTUgwWkk0Y29Lak1z?=
 =?utf-8?B?dWtJVkhsSkg2OHh4QmJ5OXBDNE5jMUNzREkxYnk4SGNNVDFhc29XaTk3L0NF?=
 =?utf-8?B?dG0yYzVEQWs1RkRPMWtJZ1VhTDVadm5HWUR2cVQ0TjhaaTExMkpqWUZCaDEx?=
 =?utf-8?B?V05kWHhpR2t2Q0plMWxzeVR3WEpQMGVrU2loRXVtejdJbXorMFozb3RvbEEw?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8782503b-2ce4-469c-029c-08dc58ef68f0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:47:26.1949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTBj8dZaD5CStAnWbbOm18H3W4fupHKv1wmZCaV7jlZ3t2XC/Gcb6Y/GGc9HQOSL3PIdFzR6WhbHavGF7H60wh3ywmidxH4UwxLFnxSNAxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com



On 4/8/2024 12:16 AM, Geetha sowjanya wrote:
> Support offloading of skbedit mark action.
> 
> For example, to mark with 0x0008, with dest ip 60.60.60.2 on eth2
> interface:
> 
>  # tc qdisc add dev eth2 ingress
>  # tc filter add dev eth2 ingress protocol ip flower \
>       dst_ip 60.60.60.2 action skbedit mark 0x0008 skip_sw
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

