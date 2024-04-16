Return-Path: <linux-kernel+bounces-146417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDAE8A64F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97469283AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3CC7F486;
	Tue, 16 Apr 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOzDcn0B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD86EB75;
	Tue, 16 Apr 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252198; cv=fail; b=aoT7ohemqiEPsEhwMvES9ByU7Dm22MUl1GfsFIVap3EYkjMXn22q7Jm/Agvh62j+ClDscIMuM++02Ch3RtiC7ilOZS25BsI1D/V3ovuCuru+aNGZnvP+S86DeC16kgE+chx3zflgAEpK+2wfQmJ09B78oqW0zC2JQU9hobMlIc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252198; c=relaxed/simple;
	bh=paOrGx+bOAwy3X3kjd6naAH2T4e8OOqtFfqS/wmZKk8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LybriMBIZfyIAD/9vuA3pcnE/WYoXJRo/osbupKF0z/HwKLyQhdKga1Npy/UnMevzC+tWZjyMgl7jcE9f877mIOAGmzO5WV54Fv5LBFwo3Cl94WCgGMzOG8VBbaNzrDUkFgNOP4gHS4H3WQxHFZ3SOsqyCzNUbFPgZw3bvS/g3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOzDcn0B; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713252196; x=1744788196;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=paOrGx+bOAwy3X3kjd6naAH2T4e8OOqtFfqS/wmZKk8=;
  b=WOzDcn0BOGdQ6tT1iiI4hPaZlV6Le2qGLQ3G77t5QmacRXPVG+XIMxqU
   CIgc6Wcs9B1P0+IYj7ZPQDXsRnOskfcD7yB5KPRljm5pxza/cx88oWN5y
   Ssq/Z0pKst/8D0BjONU3qJuZmhXtZT3jukcrKqRzR0ntshy5hgl4kjGRb
   eHYJTglKnOpZs+AgYfjyLWSXDkeRfD5CmT9/EZot7Qvjp1qJRwVRY8eQt
   2pS855Me7GmzT1X/BnheV2aYz1FoOIJ4qW11TrtuDb4Ahy36ReW0WRlJC
   REovnPeDd2eviSp/ZExim7MIBZXJXXEo76wJGhkzRynj24h9fvK4OqME8
   A==;
X-CSE-ConnectionGUID: Oq2OwW90Re2W2tg64YTmUw==
X-CSE-MsgGUID: v1OvoFHrR8iD+VySaDjSAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8505936"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8505936"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 00:23:15 -0700
X-CSE-ConnectionGUID: 1t/K6yTASwiv+07mbU6+MQ==
X-CSE-MsgGUID: nr/F79sVQ6Ky2eT7/J4ShQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22759600"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 00:23:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 00:23:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 00:23:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 00:23:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8gBMM7d+3HyPoVYe2teSG4qUKK/DI8zXp+CVN4RXt9Vm5v0VzukaIekZ9XJ3vflNKC/w0dH+n3xc/ON6r6OTj2ky276ZkcNJkc9uFQumVLiZ7yjCFKBV5Dv3mJGsR8eCKoD10emQSEmMeLU+YcOzi1i9fbKuXW9NbxlvH2xiAoM99aiYpEfZsjOQ1UMDbS6IXtq+Cb3mj5CUjyxKHe8YlVjhZP0LR3+ghh+oHW3s240bI2nY7rU+7HRJx1GarjFxNahPPheFEFnPLodioc+Ciqg68c1IauMLWJq7yDvIHUjsMk/4K14oA91LgKYzAHuyXxVNnEWTt4pUtpBiQtqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4qPHzeonDWLl8m8K6Kb+vozGx8y8Yo1zMV35X5YBMQ=;
 b=VuQ4kSHBp1WkBPP1af0pQoKRih/saObCl8nqyoRmH11rRpH4slVoSzayjiGapHoIVnIV68s8LVCGilVPr4IJM3vwJOYtw5b9F0dRX3i07/5WgILpp0IhGbmUloB0XM/rCemJOYQYdGeijZhei2asLbSMzHfdjS6+esCqGRbvmz9XKpDA7BSUWp4j4orHWz9XovrNNU0wWtXGpDdKV+9gMFeOIWbduGv+rAzVy7t5n86Hl5oLVXISMDj3GSmZ3z4qD3rjPDRn5kw6zUipaqANCpnggGJ575PDdkg5uHjAYNVZoYnxjhoq222zMFoKSxkaOaK6+77hqoM0OBB0djmmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by SN7PR11MB7604.namprd11.prod.outlook.com (2603:10b6:806:343::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 07:23:13 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165%6]) with mapi id 15.20.7409.023; Tue, 16 Apr 2024
 07:23:13 +0000
Message-ID: <bef8426e-d71b-429f-adc0-98ec1de0157f@intel.com>
Date: Tue, 16 Apr 2024 15:23:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] PCI/RCEC: Introduce pcie_walk_rcec_all()
To: Terry Bowman <Terry.Bowman@amd.com>, <dan.j.williams@intel.com>,
	<rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-2-ming4.li@intel.com>
 <d69c2157-a0da-4d8c-8684-d42afd285191@amd.com>
Content-Language: en-US
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <d69c2157-a0da-4d8c-8684-d42afd285191@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|SN7PR11MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 652e88ed-c29a-4b58-65d0-08dc5de6137f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRxP/VJry6XHTfsC0x8RRtjizMXu/TTk5ZdMPggbXD42UMtOq+ST0bsLZoSRMkJmvae1FXd2MNCozljK/DIKczG6oVYxXHGnN1bXKDPMwXKppomkm91k0JS448YKyrFW3qlur24Q+dt84V5gSe4V8WP/9Ltl+5ZUvf5HqWRZn03KL9sttlvLA3DFAGswjx5Dw+tEwGwFt1iVJr4r35GPU+OKszF5L/xNaIW5KihPuIffrTlXSaBQWZ1YRikjuZs8DlYqjqBcZRq22lgc9lVTKsX2ZOplrDz27N39q2aeikTeGZ0TUgEc/fRBEsQ+JAgOLs3AWF6zcFUqIih/9rJo9x0pGAT8ZRt9Y31idYxFT916PdsQnxspu2mXeqoTA2GRciWNZmhBVm1LTvKgY0W4jcWz6puv8AmL7g925jiQgKMFsqYBopgOpqpbY8LQSD/C/IbVdGTZjD6yHzXoPCguNMUDWird0eM4qqsiJIndkrDONlzDTVZ0UJZhMiYQ5GFg9urORryaiCa2qUDX5wepfAmsy9v6MjDB1q3J5QQqlE4qwQtKxgS6Au2h+MqonllWMSVtCM3oAmZck8ClAFCaREqieVGLg8LyUtHjE909yCvMyJpMHrdECIybsMvfs5o0jGaSG7uHfIUmLV4kjKOgp4EuTRE1wsjM+bE+UaLnA5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFdpdFNUUW00SFZDTXFSMG1vUjlONm84SndTTk1HL0RsVC93SkZ4b1ZqOG9U?=
 =?utf-8?B?YkVHSUdadkxGNUNRN0RUMVVFN2NGU1Zsc05MRTFhbmlFTk5iUzZqZU9SaFN4?=
 =?utf-8?B?YjVnNW01elA5WHFDV0tFTlplOE9BUlA2eGpKbkMrSnRhb3p0emlmZitDSHpx?=
 =?utf-8?B?NFYvMUJVa3E0WmwzbitPNkVLTkt0VWZhY3VIZFUxUnhJV0trbnFCbi9xbWFQ?=
 =?utf-8?B?ZWlyOFFvYUcvbmtucWJlTG9qQlpCOGY2WFRHT0VmV1FHc3RxcnhxQ3VDcjRl?=
 =?utf-8?B?OXZQMTNDSUhLWTBZdkNDc3RNNHVFSWllaFg3NWg4TTZyMjRmYVNJeUQ2TW41?=
 =?utf-8?B?T2tkZHhEZ3R2clM2UW5XZi85WUJ3SEpGbm0wRG9aNGVpZUtMc1YwUWZMaTNo?=
 =?utf-8?B?N0NVSTUrK3BEaVVsMWIyam43U1ZGQXNRbkZwWTJhR3FKbUhhNDJNOVV3c1F3?=
 =?utf-8?B?ZzYzT3ZxdjZ4dWpCbjdHSEJ2S29hL3FjSVQwdDZTakdCblVlOVdSMEx1Y2VC?=
 =?utf-8?B?elJ2SVo0cE81YTN2dDF1N3hrWUw3UHNMTVhjTFBsQjB5Q0VjbmM1QTNsL1gr?=
 =?utf-8?B?cGhYdEZPSHdVM3dUNUtHcTZnT0lINi95dmxLMmFOckRRQ3hDOWY1WFh6Z3Jp?=
 =?utf-8?B?ZWppQm9MMXdkWVhjTis3T0RSWVFkVVYrNEUzcnVJL2szZG4vemdmWStvak1W?=
 =?utf-8?B?eStsZWh3MHhvS1FjNFlxeE5hQTBjUnlYYnNiVkpzSzhiOGxmWmhtemNKRlZv?=
 =?utf-8?B?MDNnM0dmZXFqL2hoRG9yZkhQaFYvZldsM1hSdTFFWlJyQktBYXdET0M3OXV4?=
 =?utf-8?B?YUIza0ZLSWVsY0xxOTNKYUJFYzEvNWliQUVhUEhKdFh6NmdURjNHUjdLUEpV?=
 =?utf-8?B?TTRzYnRhNnZRNHVnUGJHbG9TMGl3YjZvSWcybFUxNjZZL09sYUdCeVY4dGp6?=
 =?utf-8?B?RUgrKytld1dZRnFuS3FtdUdVNlBwcEFMdUdGZ1A0M3RyOGM2K2RodThGcnlD?=
 =?utf-8?B?YWpyY0RBNHpWbmRlQmo1OWNhWVMvQ0VnNHpMMFJYR0JHZEpTOXowLzJMNFdJ?=
 =?utf-8?B?dENJZFM0Y2dzNTNuS2crdlF2Nlo1SkllTXhrNkRvam1OU29PM0t2Q3JaSy9K?=
 =?utf-8?B?cTZZbXRaZkorci8zZWw4aEcrN051RlZzeEZxMnRWSXR1NTlqczZKMmJpa25k?=
 =?utf-8?B?UnZ4WkVYa2hFQ2k0ekR0bjBIZHIxQkZhaDh3QTR1WkJ3bFBZd2VNSzFWd2pu?=
 =?utf-8?B?TnJRcGhtVmowVHBNalk4UWNhRmdqbHk3NVFrL3hPRFhkOVBCbmZNUTRxOEFu?=
 =?utf-8?B?c2FiVStsdHdxSm1uUy91NEJ5Q1BEM1R1VXB2Q0s1VzNwNEFQb1BzY2g2R2Ey?=
 =?utf-8?B?WFpIK2FFQ1pQQmZKdVJlWDJNYnVXZ2JCUVdBc2NvbUxyTzBheklNSXM1c3VB?=
 =?utf-8?B?Z2xGNmJ4Z21oNldJSkVwaVUyZHRiTlNzNlExVnVBZVIvcXJkWDFZLzBaMzI4?=
 =?utf-8?B?YkR0dVo0cENRcURsWlkvdWZzcStXSFJQWG50Z3A0Wm9xT2tVUVZPbjdFK3Jp?=
 =?utf-8?B?NDhyU1U0bWFmRVlra25kNUpWdjdQcjkrK3Q3Zy9GdVhLdUJOTGV5V2NmaGNr?=
 =?utf-8?B?Qlc4Qlc5US8zMlV2NlpDV2kxWUxQV0N0Yk1nSTZhK0lJVFZOTWJqU3ZqSVFr?=
 =?utf-8?B?YnNodGxFY1JtcE1yR3JLekN4TnprMkVvRlhWZUYyWlJIQjVsTmN1alo4dk16?=
 =?utf-8?B?dTRqVExtZmlxZVY0ZU9Cblpid0xsY3pnWStjNU9FT2FOS0NzUGlOd2N5ZnFn?=
 =?utf-8?B?cmhBRzNERDdPemVZQ1lKa21SM1VEZlFXUFpWZXlwQUhCbVVTV2s3eXQ2ZGhu?=
 =?utf-8?B?cWI0dWFSYjNIbTczenFaY1BwS1M5YVRYUUc0UkN0cEViaksrNFZWMEZpb0p3?=
 =?utf-8?B?Z3Q4VW9Oem5sbUg0RFZZNHRla0RHdWdkVkM4eTRWanpXMys1S0FtaUdQZ2FR?=
 =?utf-8?B?U0pVMzBVNFIxZUxlaitMT3dlSFBIdTVKRnpZdndVbkN4Zi9XU3dSVXRJN2My?=
 =?utf-8?B?NlR3RHdCZnVnM0F5bzF5SGRGMzJ0Q1RPQjZvNkEvOGwzYnU2S0xwK3ZJbVpD?=
 =?utf-8?Q?rx8kypslIGdMBH3DFQn6pb3aT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 652e88ed-c29a-4b58-65d0-08dc5de6137f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 07:23:13.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNOJbvYhMpCqHl/gVCOmi+I4x1BSv7qltUwGPtZmDoKxRJVrir2gGGr1Zq0MZo5L02yPPfkNs8BZ6s4bi+D0XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7604
X-OriginatorOrg: intel.com

On 3/26/2024 4:15 AM, Terry Bowman wrote:
> Hi Li,
> 
> I added comments below.
> 
> On 3/13/24 03:35, Li Ming wrote:
>> PCIe RCEC core only provides pcie_walk_rcec() to walk all RCiEP devices
>> associating with RCEC, but CXL subsystem needs a helper function which
>> can walk all devices in RCEC associated bus range other than RCiEPs for
>> below RAS error case.
>>
>> CXL r3.1 section 12.2.2 mentions that the CXL.cachemem protocol errors
>> detected by a CXL root port could be logged in RCEC AER Extended
>> Capability. The recommendation solution from CXL r3.1 section 9.18.1.5
>> is:
>>
>> 	"Probe all CXL Downstream Ports and determine whether they have
>> 	logged an error in the CXL.io or CXL.cachemem status registers."
>>
>> The new helper function called pcie_walk_rcec_all(), CXL RAS error
>> handler can use it to locate all CXL root ports or CXL devices in RCEC
>> associated bus range.
> 
> The RCEC-root port relation you mention is new to me. Typically, not in 
> all cases, RCH-RCD has a RCEC. And a VH mode system has a root port 
> instead. The RCH RCEC and VH root port are both bound to the PCIeport 
> bus driver that supports handling and logging AER. This allows the PCIe 
> port bus driver to handle AER in a RCEC and root port AER using the same 
> procedure and accesses to the AER capability registers. 
> 
> This is oversimplified but are you looking to handle root port AER error 
> in the RCEC from the below diagram? 
> 
> RCEC <--> CXL root port (bridge) <--> Endpoint

Hi Terry,

Thank you for your comments.
Yes, if CXL root port detected a CXL.cachemem protocol error, the error is possible to be logged in RCEC AER Extended Capability as Uncorrectable Internal Error or Correctable Internal Error.
But the cxl.cachemem protocol error is logged in the CXL root port RAS capability at the same time. So the implementation is not only handle Uncorrectable Internal Error/Correctable Internal Error on RCEC AER capability, but also find out the CXL root port reported this error and handle the RAS error in the CXL root port.



> 
>>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
>> ---
>>  drivers/pci/pci.h       |  6 ++++++
>>  drivers/pci/pcie/rcec.c | 44 +++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 5ecbcf041179..a068f2d7dd28 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -444,6 +444,9 @@ void pcie_link_rcec(struct pci_dev *rcec);
>>  void pcie_walk_rcec(struct pci_dev *rcec,
>>  		    int (*cb)(struct pci_dev *, void *),
>>  		    void *userdata);
>> +void pcie_walk_rcec_all(struct pci_dev *rcec,
>> +			int (*cb)(struct pci_dev *, void *),
>> +			void *userdata);
>>  #else
>>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>> @@ -451,6 +454,9 @@ static inline void pcie_link_rcec(struct pci_dev *rcec) { }
>>  static inline void pcie_walk_rcec(struct pci_dev *rcec,
>>  				  int (*cb)(struct pci_dev *, void *),
>>  				  void *userdata) { }
>> +static inline void pcie_walk_rcec_all(struct pci_dev *rcec,
>> +				      int (*cb)(struct pci_dev *, void *),
>> +				      void *userdata) { }
>>  #endif
>>  
>>  #ifdef CONFIG_PCI_ATS
>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>> index d0bcd141ac9c..189de280660c 100644
>> --- a/drivers/pci/pcie/rcec.c
>> +++ b/drivers/pci/pcie/rcec.c
>> @@ -65,6 +65,15 @@ static int walk_rcec_helper(struct pci_dev *dev, void *data)
>>  	return 0;
>>  }
>>  
>> +static int walk_rcec_all_helper(struct pci_dev *dev, void *data)
>> +{
>> +	struct walk_rcec_data *rcec_data = data;
>> +
>> +	rcec_data->user_callback(dev, rcec_data->user_data);
>> +
>> +	return 0;
>> +}
>> +
>>  static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
>>  		      void *userdata)
>>  {
>> @@ -83,7 +92,7 @@ static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
>>  	nextbusn = rcec->rcec_ea->nextbusn;
>>  	lastbusn = rcec->rcec_ea->lastbusn;
>>  
>> -	/* All RCiEP devices are on the same bus as the RCEC */
>> +	/* All devices are on the same bus as the RCEC */
> 
> RCiEPs are not guaranteed to be on same bus as RCEC. Details for associated 
> next and last busses:
> 
> "This register does not indicate association between an Event Collector and 
> any Function on the same Bus Number as the Event Collector itself, however 
> it is permitted for the Association Bus Range to include the Bus Number of 
> the Root Complex Event Collector."[1]

I agree with you, the comment in code makes confusion, actually, walk_rcec() already walks the bus same as RCEC's and the bus range defined in RCEC Associated Bus Number Register.

> 
> [1] PCI Spec 6.0 - RCEC Associated Bus Numbers Register 9Ofset 08h)
> 
> 
>>  	if (nextbusn == 0xff && lastbusn == 0x00)
>>  		return;
>>  
>> @@ -96,7 +105,7 @@ static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
>>  		if (!bus)
>>  			continue;
>>  
>> -		/* Find RCiEP devices on the given bus ranges */
>> +		/* Find devices on the given bus ranges */
>>  		pci_walk_bus(bus, cb, rcec_data);
>>  	}
>>  }
>> @@ -146,6 +155,37 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>>  	walk_rcec(walk_rcec_helper, &rcec_data);
>>  }
>>  
>> +/**
>> + * pcie_walk_rcec_all - Walk all devices in RCEC's bus range.
>> + * @rcec:	RCEC whose devices should be walked
>> + * @cb:		Callback to be called for each device found
>> + * @userdata:	Arbitrary pointer to be passed to callback
>> + *
>> + * It is implemented only for CXL cases.
>> + * Per CXL r3.1 section 12.2.2, CXL protocol errors detected by
>> + * CXL root port could be logged in an RCEC's AER Extended Capability.
>> + * And per CXL r3.1 section 9.18.1.5, the recommendation is that probing
>> + * all CXL root ports to determine whether they have logged an error.
>> + * So provide this function for CXL to walk the given RCEC, CXL driver
>> + * will figure out which CXL root ports detected errors.
>> + *
>> + * If @cb returns anything other than 0, break out.
>> + */
>> +void pcie_walk_rcec_all(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>> +			void *userdata)
>> +{
> 
> Is this identical to pcie_walk_rcec()? Is this addition necessary?
> 

pcie_walk_rcec() only walks all RCiEPs in the RCEC associated bus range, 
My implementation needs to walk all cxl root ports in the RCEC associated bus range to handle CXL root port error logged in RCEC AER Extended Capability case. 

Thanks
Ming

> Regards,
> Terry
> 
>> +	struct walk_rcec_data rcec_data;
>> +
>> +	if (!rcec->rcec_ea)
>> +		return;
>> +
>> +	rcec_data.rcec = rcec;
>> +	rcec_data.user_callback = cb;
>> +	rcec_data.user_data = userdata;
>> +
>> +	walk_rcec(walk_rcec_all_helper, &rcec_data);
>> +}
>> +
>>  void pci_rcec_init(struct pci_dev *dev)
>>  {
>>  	struct rcec_ea *rcec_ea;


