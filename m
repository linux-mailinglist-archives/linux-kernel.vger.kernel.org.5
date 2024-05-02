Return-Path: <linux-kernel+bounces-166994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6303B8BA311
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D074B1F21888
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC0257CAF;
	Thu,  2 May 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCLzfwuG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31857CA1;
	Thu,  2 May 2024 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688398; cv=fail; b=eD0F7C48V8x2brkG/5qSYg2bREfZTXC2ZkDyWQ06znA9KydU6KKXFigkIRg1xyNf+K5hUii/aZYh6zA4onaEcN9NbtIk00PE88c6X3oChIDn2Hs0Y+pgplyMsUZKpesFuVVhz4tXTehf3Fyzyy5alKaI0dBp9o+YbbpCzhDXTZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688398; c=relaxed/simple;
	bh=snobwtList+LPvr/gFPKi+vssbcy5TplaLybNLbBdgI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d6e/z31aQjEB4zjz6Z5BTy8o/MAYvCctbwNQcT+hoHaJ1fV4mizzba63Fx/YtS96JdlY0qeHPNb1LgjOXZVarmyubRJ0N9VZOBhokvO+Fl0Mg+n50o59yNPxgH39Vul6QQShXPNp9u/lj9irHb2xow8RRaF2DyfFeXIHCaRr2gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCLzfwuG; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714688396; x=1746224396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=snobwtList+LPvr/gFPKi+vssbcy5TplaLybNLbBdgI=;
  b=kCLzfwuGdyz+hhXVyB07DNczDvzDutfCZeEfNmTCnY4NYbemYUMdeL08
   WLcLtsSk5VO4/wv2Kj7cLSvnKatDd9djrYYN9dnEYT2MjgcJIxJa+Yvw3
   VD6CqmPkhYD15YqDyE3ynPGtWQG7mk9bGkqU/mXXQbh2zn/doXvW1Uo7O
   IftNQz3R64ncabDm/gxQ4agdSxOZ6VOHPYUi1tDYQw+hy/l5a2tNk1s5L
   eAoVmu9jgs3Ig0GE+MKWiAAxvTN8ihTNcqFAS3DTey3t1GbeUNicqZNdI
   dDjXR2CI2iDgPtE81mflIlS73YvoZJ9H71p+ikn+CJOBhjlR2gsWDIw+d
   Q==;
X-CSE-ConnectionGUID: 2wGUaU8ESjmDAxXe9UoUyg==
X-CSE-MsgGUID: rBTmEI+CQCiB9ZqegKH5DA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10358316"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10358316"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 15:19:55 -0700
X-CSE-ConnectionGUID: ospZr+lmR/GQ9BMLFQnatQ==
X-CSE-MsgGUID: E8DFl3YeQbCZRY7O60W+Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="32081516"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 15:19:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 15:19:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 15:19:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 15:19:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 15:19:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS+Yx1nuaFQJrEGB6bTwugIGbxmbocg/GKHNBlLzM3fXJfvbaXbG16e9+5Nnz1TpCwaldXxMw1NKYXz/9cIl8Sz8Zd1Rky9f2iaxsHfNomoVv5ORC5+XXeTujRsjO13VsfvZM3gwHieoUcmIds9n9gOt7IBr/FobANUCkUovWRb9wjoxE9787wCt98nLiWIjivkN8H7ahiRytiNgJcGsVC/bUM1c7DoZ/Cfvneer/z3ADhh0A+spQpGcHKcJAveVJCiDgf9QyqVEG200gryK4+yKQl3aZIpfkN5FzNPJ+XNnWcbk+De13yj8Iz0FOKvUIaMetHczN+wAOJXJfYdYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPvama6niS9WikqUPI2A/2dV8NVP6DHKM+8FXEMfM4E=;
 b=KfsquZz+82rdCOT/3CFqfwlj7LJEmWFgMawMBOWlbSojkdRVsTtI8vXlaNgo56qx1nrlfTOx/JuxADiZ57CRXTOqZK7NGoMgG7GLMBgS8qrHrhwwARbcNrVKEspk/izUnlQFVNNk8Afd8G33/8m+TVu8+DjCNIVoWVCIrCq9N0NQG5GOcQRLB6ZwxZ/6aeagO09dXaSCnduCe3cqOYWZZm7I+QbH2HWSyKCAjHxXdVsADoNDAOp8qaHKB9CMM5ps5OM6Zwdua5R9THS5izbAO/8db+088Ats6ZOWSEp9FNEOGXIcl1S5q3JHTY64zSHeXB5q/odpEgo8/1DP+8xSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 22:19:52 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5%6]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 22:19:52 +0000
Message-ID: <0c26f268-ea1e-4c03-bfc3-5cbe49c69d30@intel.com>
Date: Thu, 2 May 2024 15:19:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86/intel/ifs: Initialize AMX state for the
 scan test
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, "Hans de
 Goede" <hdegoede@redhat.com>, <tony.luck@intel.com>, <ashok.raj@intel.com>,
	<jithu.joseph@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240430212508.105117-3-chang.seok.bae@intel.com>
 <f97d4275-11b1-4b98-9491-ff6c5f117eee@linux.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <f97d4275-11b1-4b98-9491-ff6c5f117eee@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|PH7PR11MB6498:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcc330c-2922-409b-762d-08dc6af5fd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azFnaXhVZHhjUE1hcTUxZURtNlA0V0lkMWN6b0pjRXFrVlQ4OWZZR0VkaU42?=
 =?utf-8?B?aVZFSU45QlFVQmNEaDZ0eWhnT2lNTEEyTHBnWkJ1ektlNXRvSXJqc1haZEJW?=
 =?utf-8?B?Wm9PdExvRnFRNThWZC9WZWFBNnpEQ0xvdHFhSjRFNzZveGJpWVdTOUY5YlZy?=
 =?utf-8?B?OUxuZk92bTV1Y2FJWWN3RUpnZVVhVVpOWHpCczNtN2N5K0V5blo0VWRNenF4?=
 =?utf-8?B?MTZpQzk2MVNaREFWQnpzbDFtY0k3TDVUK2NGV2hHMjdoc0drZ3ZlVWxSaEtH?=
 =?utf-8?B?bnR0Tk5JMHQ1UDJ4REttWWZsQU5VaHpPQjJNcHNMSlZ1Q3lPa0pONUtWM0Jp?=
 =?utf-8?B?MGJZbW04TGJEY0tOK0QxZVFtRWN5Mk5mSXJ5d2FFYmwxZ0RRTkJleGJSV1k4?=
 =?utf-8?B?RUZHQ2RxcUVkeWdvYXAvVW55WWJGMkQ3Q2tuanpudUJkejF0Mzl0Y293TG5H?=
 =?utf-8?B?cmMzRVJ3RjFYWmZJZTA5QjlQc2xKTDYvVGdxdmR3K1pVUysxTXRNZlk1RmJC?=
 =?utf-8?B?SENIRlVJRU5rZmpFWWdXYllDRTBhTE5SZFE5NG1KcWlaV3ZWeG1zaVZIK0JF?=
 =?utf-8?B?UFJNb25teExBTGZtUi9lai9tTjI5SGFrWWxaMk0rMUVtTUU0cy9ZbEFYSy9y?=
 =?utf-8?B?bDQzU2NYWGFUU1hVVmgvNTA3ZVRXOGlYbzF3VnhTajljSmhmUElVcjBXOXFu?=
 =?utf-8?B?Z2NzQ2pwV25xbXY1L1ljeUlDNXdyZUJGcGY2VE9Mb2RCTFdqa3FKN09tMVQw?=
 =?utf-8?B?UC9jOEJsZUZ3emwwSVRoeHlPVnArQ1JXOGlic2xiQjcwbVBmb0wxUENaRml4?=
 =?utf-8?B?ZVk3MThNVWVRMEFCWW9ZTzR1aUlvNFRDb00yN1hEdklBVzhCaHdLY0tYRlcv?=
 =?utf-8?B?YlZPNmQvSFhWaXlMNjZ2UEdvQWswaUFSc0JFMHNuUll5MHFCTTFCcDBWVVZu?=
 =?utf-8?B?c1B4alZqcW9kRmVwdjJEVFJEUENBb0FxYnVLZVBaeXNqWU5aaHVkaE1aWVVJ?=
 =?utf-8?B?SXNFaEdqenArNEJCKytQbnZxRHBENjdwNE9LaHh0ZGRZUkFjY1ZGM2VEUkFz?=
 =?utf-8?B?Qi9qWSsyTFZzc1pXMFU4ZkZ5WXFCTCt2MG12UXlveTZraGJUaXZ1WnZKSXlL?=
 =?utf-8?B?VDcvczJJVE1JT0tXQzFSUGt5dTVrb1ZHLzVKdjRTckY0WXAvbEFHSFpnZ0xi?=
 =?utf-8?B?aWxFdFNkS2pjVUZCVmlmTW93WHRMZXBwVEFLSHVKSnJFWVl3T0VidEk2R0g5?=
 =?utf-8?B?K1ZUV0g1clVYNURiR1pPSkg1SU1hZ0ZEWTF0ekhzamdRa0NtaXJPVmNpQU9G?=
 =?utf-8?B?R0F5YU9TSkc3ZDdSaWdLOFF3ZC9MeWdOczFqY25YakJORGNmU0RNSUJDcHVL?=
 =?utf-8?B?dEEyVGpGR1NvNHp2NTIrdEwwMHV0QUJ3Q0RFQUFRNG5YOWxiaWRBN05DNjhh?=
 =?utf-8?B?N3Y1WE12VWcvRUcwajl6QnR1a3JwOGpSdFBRaENlWEsyWnhlNFhBelFtQ2ln?=
 =?utf-8?B?Vzh3cVFOaXZOWmgrb0dnUGNVUzVBQTZxL1B5QmVud1FCb0l4RnVGeW90aE1P?=
 =?utf-8?B?MEplTFBLUis5UThONXliZ2UwaytIbm1mMStGdGo5TTNrSGZtWSsxbDd3TC9C?=
 =?utf-8?B?eWJnKzErdzBGSHlxYVR6SUZvQ3U4bVV6VTk5blpJWEI1cGF6MksvVGZIVmF1?=
 =?utf-8?B?V3dtcFo3RWFxQjNmYWY3ZlQ4MzB6VENnYmIwRklGd1lKdXFQVWxVMHZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THNnY3ZFMXBoVlBNdWc3YWh1cjJCU295czlETk0zL2pzSFhxSldLVmxVUnlF?=
 =?utf-8?B?L055ZFo5QkFUeU1CMWZSRTdVdTFkR0dDYXk2Y1VjdVhBcGMxSGNnTEhmVlpK?=
 =?utf-8?B?L2FndG9IaFhXaE8zTHh2WEtoaXM0RlJManNYeVZzTHVLSS9uQTJBQk9JY2Ey?=
 =?utf-8?B?MEFxcnU0WVhIQWVPeCtEcmRwK3laZkk2UHdmVFRMMmJQZHdXVnZud1NyN29L?=
 =?utf-8?B?MDFKak16QVJITUxnTDU2Y0pzSnVzOWttcGxGQVhNRHpVNC9UVGhCTFM4ZGNP?=
 =?utf-8?B?OUhNUWZyVXQzZHRWNTFENUxpdkFRVHdxMmNpWXRGLzJjN0NoSXhwZDZXOGZh?=
 =?utf-8?B?ZUFydHNwVDFwT3VjUEpvaHBWanoyMFM1SEdkNVMzV1N5Wk5LQm9aZ3F5TjhW?=
 =?utf-8?B?QUs5aFNQWXRDQ0pDQlA3TExTZTN0N09nbXFsT0tyOUpmL1B3c1E3a0UvQkMr?=
 =?utf-8?B?d0hOWWVVSDZ5UU01Ri9IdklBdWFkS1U3MUk2cUhxUXFaTmJYaEo3M3NoY2Nq?=
 =?utf-8?B?NFJyWFhHZkRNbVc1V2psRHZzK1k3T1BvOUZFTjBUYVZWamt2SlpPaStDanZN?=
 =?utf-8?B?VHVCYTcxQ1lLbG10WTdsNlVOb0JtRk9MdWprWVVoTW5oNng0SVZpVjZlZElH?=
 =?utf-8?B?RnJUeWFkVnk3bWJIZ1UxTGtPSkhHSUZkVC9oL0R1ZTZkeFZhT3NDK1VNSUJi?=
 =?utf-8?B?OGVmcEJmd1lxMTl3c0JXK3NOZXQwaVhlVDk2cDFVY0loZTJvWU1mV0dGcjI2?=
 =?utf-8?B?VDJtaXI1WjcwdW8xa05iUVBxWGhmT21Nd0RTUFJweEhLK1h6dFFTTGhkdktm?=
 =?utf-8?B?UHY2OUJVVS9tVWJ5MWZEeXN0TWdHUFp3MjZjL1E1c1U4cDRGdDFiRTdJeDJ0?=
 =?utf-8?B?WGY1MTVublNkdmhhQnExT0hwSGlHZ3BXVnROc1FKaENQanppcWJsSlpMaTZN?=
 =?utf-8?B?Yy9FTnBCM3lKZE1rTkd1dHc4SURTbldxOFBSVU5CelRoV3c1SDVXWnNFQlFO?=
 =?utf-8?B?K1dLc2JPaUN1VUYydjhtZEtCVFk4NTgzV2l5NTZrc0NXUkw1TndxUk12MnlD?=
 =?utf-8?B?bnJYRlM2cTRDcUt0Z0VsMnVYYm1GRVErbnhlVHZtQVMvRTRzMTV1MCtPVCs2?=
 =?utf-8?B?ajVvb1NBeDlJaUVVa2J0ZlRIUndTODNheEdJVEYwNmthSTU4OXZ6cVR4NzNj?=
 =?utf-8?B?dEhJNzc3NU1zdVFBemJ4eWdnZTFTekFkT3M4aXlUSFFVckpWNDllWi8zcWdW?=
 =?utf-8?B?M3JIdG9vZDZ5RjZORFZ0VlU4VzFTREdNa2V5VDFPU0kwRUFnMG5jV1B5aHdr?=
 =?utf-8?B?a280NnNrVW1RRUxWK09Qa2pNNSs3aE1wcHg5MXN1cGtXbHpDOFg0REIwSEEv?=
 =?utf-8?B?WE9RYVFMMW1WaGRBMzQ3NHdxZUZUTFFmK0xXMXhMSEFrM09XOEx0ZFZkYXdu?=
 =?utf-8?B?Rnc4bW8yTmd5NVpJSi8xaDFjeFNkcEdTS3BMbE9oekFVVGNjNlkzVWpxdlBp?=
 =?utf-8?B?TG1kWXhiclZPVkJySEtRVFE3dk1sc0FqRmFQUnh4N1BxTVU5bDFzU0E4ejk4?=
 =?utf-8?B?amg0OVdscXNBSUZRQ0Iwa1dtK1h4MjFCQk5FUWNNSjFnWStML3Zjc2YrTnV3?=
 =?utf-8?B?U1JJR0FlYkJHenZlR3lSTDUxb1R1dHZ0Ulp0aWVGNDV2bEhnSGxwUElCQTJR?=
 =?utf-8?B?YU55WTJuTG1oNndjT1pPekpxV2MvZnNHSThXZXBOcVlYbXlOcDZoc2JLRm5v?=
 =?utf-8?B?R1FBUS9PUmlhN0RIaFdqMERSaEZEZ05wNHZ0QlVCKzZ0Ym1mb3FsNHZRdXdD?=
 =?utf-8?B?cFlKWVpXMnRYWTUxZUZseXlkMWVGQjNkR2dWaGtNemxlOFYyVGh6WXIwQWtp?=
 =?utf-8?B?dDU1UjJyOGVNU2xUOWd4eFV0TVNHTUFxNGFQMUZiVTZYTWQzNUFwVy9wMEkx?=
 =?utf-8?B?YWcyZUtOWTJ2S1l6R2RpMnFOUEhJL0NmUWNlUWN0bGJua2dKMmtORkR6TU9s?=
 =?utf-8?B?NWxaL09CUTdrQitxMFhDcjZ3cjE3NHdkL09VMHJlcDV2U3hJaUdHazdSSXk5?=
 =?utf-8?B?NkxkNzVKbXptM09NbTBLOWptWldaT1UzdzA4bWlyQWpmT2tITUQ2dXlqMmJT?=
 =?utf-8?B?ajJmZHVQeHg1MllNSHNKSXBSMmJhQ2NlOEZHL3lnQkNSQkIvQ1YzT0twdkhZ?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcc330c-2922-409b-762d-08dc6af5fd07
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 22:19:52.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6YPRDS0MtTlgmp6iqBhMlCi0r+JaDpcEcVzDjXLILqQHlZNE5d4cuGFkQdkRFu3KJp4A3e49OX4217IacBUANm2v4m8mp10N/8Ir53TpTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6498
X-OriginatorOrg: intel.com

On 5/2/2024 4:00 AM, Ilpo Järvinen wrote:
> On Tue, 30 Apr 2024, Chang S. Bae wrote:
> 
>> +	/* Prepare FPU state before entering the rendezvous loop*/
> 
> Missing space

Yeah, right. Thanks for spotting this.


