Return-Path: <linux-kernel+bounces-168403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 582488BB835
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97B41F2451A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107284A3B;
	Fri,  3 May 2024 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXFDY0pH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242E558ACC;
	Fri,  3 May 2024 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778716; cv=fail; b=qqZW5n3ZPlqrbid5Zw0h3as9o1jTrTHrWjDKQa8wmT7zgtuIf1MJYrjTuADKwhOp/PaK3gOoj8wvT4gagPfZx7CaIg4ralOfb1ebaq5HJMow6dfvWAlxGMfNoPC5sAyqxZLOw37J+1iYR5ske3wczaBtnBCRCnpF92EgrINL6/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778716; c=relaxed/simple;
	bh=xLRzzhz4QFfeW5FiOVrY3y7TfqxuQvgFqIIvySaobVA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WzsxLAcgn+B4yWuhElyfARmDcZVCGB/l9w9Nm41p9dQW3T8KlRcTApaDPZC561+Ajzk8G1NnQ8w9K1ilIgXgSo9A3nPwy2OBGk2vE2Uv8815anN2NFXPzoDwOI8/Agw+nau/DhB3y40LU2B1w78VNmaeUx+dtqDk+SJu4CiBKSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXFDY0pH; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714778715; x=1746314715;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xLRzzhz4QFfeW5FiOVrY3y7TfqxuQvgFqIIvySaobVA=;
  b=hXFDY0pHzqnIkWyOl3qhSEzqIIukvtD8DSEdCMOmgznDtrxttbKK5Q80
   NHn56wPIDQKuX3ep3N73ykznO67i6GKKj8b+u+UrKFA4Dcwim8UDdYtmq
   4iCPrBvwtmAwNJdoKWaBPcThy+p2Mz5Co2XspV4aM2YaZgfWCEcL13hE9
   UEdsDq0A0gns7ACeRI/PC/ZJPsdF1G5ykluWMHEo1DZikYi1TFbpHoJHG
   JBRHGwuevUTYrEuEW/7m24rggHSefoLbtDw7qi/m2OJ5EW31OXRg06a1B
   5obWR3aVxQBj+WxHtNeev80JQZ+dAntvVPgHrZe4rxkwwAqS390aWm/fu
   g==;
X-CSE-ConnectionGUID: Kmm0SR2QR/K9hTVopRztyw==
X-CSE-MsgGUID: dMxkLl9mSH2Zlv/03sNcVg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="35989254"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="35989254"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:25:14 -0700
X-CSE-ConnectionGUID: ENAuR3iXRVCXlMmihi59FA==
X-CSE-MsgGUID: FaVD8784RWOWaM2jivsuww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="32200482"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 16:25:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:25:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:25:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 16:25:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 16:25:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aI8LZ3nNbwtvSPNQNAtOUuo94VnyYrHwtqO5ra4UCHfpsKWDSdLVKq2PNNXwWcP3X5Z8usA2OfO1AnL8mf4pbGLkiKM6FyA4dSDZK3J32XPV2dpVSV84TKGE4sPYN5DaDKVrQj/gFEjBeuq+71EIfEauOy3Ua+9cQTiarPi2Ygu+OhZOwdbb0FLy9x2FDUeeUtct+psZ0yJlF8a8lExLRG6Sp/dFf9qHeANZUKuMkCE/NoZLnGN+EboKqDVksK+3ZbFin5RUo2wvnf4JvRsUaIBjkRudAd/+2l2D+6oV3qw8qYj9t3AK7AynqiAtnezxIpnVQiOLDFljHFntYUxPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVPlo3ZnMpLSygw2FuCqUKfYSqNulZvIr00jiBuKP2Y=;
 b=SywVhjcX6Y/pv8rKMrC5kfYO7ptVu7nw9f1fmtl+xqXje5E5DIo96Jy/LKD/WDgY2iSE/W1So19Lil2yJyxnBp8Lq7cPc1dtPf5ogC4wY3jgomZaFQN7B2bqYZoISs6rrTsEWfpdmWnRyBxMmWpiD0GUvfhjzDvX5+QWVvlUpNN0c/hpigch8dItfRzxDSBopRjXvUqFM0BDWasMJcn8Z960k1T47UMNWjQVrAFIqeWRlpeRP3kDUp4ju2RRbVs4lcNYjuZitZhQ61f0Wb9r62xA+Xwvqr5BE0HIqy66cSkMM07uwoomUkwq7CIgCG7HSxIj0122MDwJW2E9PVbytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8607.namprd11.prod.outlook.com (2603:10b6:408:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 23:25:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 23:25:03 +0000
Message-ID: <46fe7620-24c3-4f0c-8877-a529626c5025@intel.com>
Date: Fri, 3 May 2024 16:25:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/17] x86/resctrl: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <1194d7c66607648368fe34460709649b76ab85e3.1711674410.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1194d7c66607648368fe34460709649b76ab85e3.1711674410.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:303:b7::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 6757f06d-dcc5-4d0e-1d84-08dc6bc842b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFkyaWJrcnVacFUzbkp5RHJBQktwaXMwTGNnS3FoRHFIUzFlTUt0dXhDNWpw?=
 =?utf-8?B?bklHamp2RmtlVUYyTWZlMU0xWTJzTHZ1R1ZMK1RFNEpJQWpEdWswTlBHSE1k?=
 =?utf-8?B?RGIzMDh4S3FaNDNkZ0tJVkZRTmRTYVNwaWhXWTUxa2ZxNVNJVHlZaUJweVY5?=
 =?utf-8?B?V2JvNDRPRTI1MmRYUTBod1lMNnZzb1hvWEtqVS9mWXhMTFNxckM0a09jVDNU?=
 =?utf-8?B?TTNsQmlGZVlhNWh4ZkNvL3ZmWk1HOGN4ZkxzVVZ5ejk1Z2p2d01nbXJXWkVz?=
 =?utf-8?B?bVExTmlEMDYxOU9Wc3NTN2dOaXp6RURkcjFvbU9KdGlZcldLT3NtSmkrUW9z?=
 =?utf-8?B?WjJWa1BMNjcvWjZSN3pxTjBaZ0xQclFrMDgvUU42WGJick5ML0RRZFhzVkFL?=
 =?utf-8?B?SEFsYll3QjBqajFnRCt4S3kraGFkVzVEYmtYSkNheHdobTBKSFRXNnZwbzR6?=
 =?utf-8?B?RzZTL2d4OVd2YWJqbGtvQ1FPaGxDZnBpS2hFblRQdkxPYjZ2b0NLMjJXNEsy?=
 =?utf-8?B?RUllc1N3Q0piWmJ6Q1NTNjVSUWduUmt6RWpVUlFwd1l3MHRNYzJnQjVMMkty?=
 =?utf-8?B?N2VDY1Mrd3ZieE9POFZzU3R4ajZ5d0RjNTZPS29kMDZSbDhVMWRNSTdJc0dQ?=
 =?utf-8?B?bzMyNmJMZmlCYkhhdkRNYXlHcWVFUGRaRXdCUjRYbnp2eWJCUWdpaUVoYVh3?=
 =?utf-8?B?RDkvWmsrM0RaR09yYkVVY1QzaEFaZVZBcWRRUU9VS000SUlWVW9wZS92U2Qw?=
 =?utf-8?B?OWJ6blk4T2s3UWQrS1dXeFlkdEIzYUtmMlVoTGgrNTRPaDgreVhaa3BJREk5?=
 =?utf-8?B?bEZXdm5uZjdoamprQTJIWlFhK09kREZmdVJFek56T1VrLytIaThSK1hKS0ZK?=
 =?utf-8?B?UDVxL2hNWUVwVVZlNUdpRHd4bG9qWVZ0T2RvMkY1ZG55aEZ0dHRMOUFPaDlI?=
 =?utf-8?B?Z2tBQXZlTHp2YzlzUmlSSnozRXRsZjZYemNXNFo2cWtpcy9KbzUzN1NIb1BS?=
 =?utf-8?B?RkxwcU5uOTdpVXp3TDd5bHZJeEQ1eVdXVnhucEZkYjBBMFZSUGpKRlhvMjMr?=
 =?utf-8?B?TWlkUDFzOWd1UXptMmFGWERwWWhvbFFDTUJDeHQzZWFrdEI5dGJSa3k1UEVB?=
 =?utf-8?B?U2RPUC9INGdmSUtQTUV2TzU4SWd3ZTlaTllFbEdwdTBZakFiZEZZTjdOeWl6?=
 =?utf-8?B?MHo1eFJjSXYxMFlsNi9nQlhPU2pYYmxpVkpPcTRFWWYzWFdhSDNoUGRuUlhZ?=
 =?utf-8?B?NWh5SEdmOC8rYVpQZC8xQjhDSk45MGhzTFBIVUtBQndMWGdYdHpFQWRtQ1lS?=
 =?utf-8?B?QmoreFQvZVVaR2Y2VE8wa01LcHRkQ0ZOWTF2RVR3V1hYdS9WbVhNS1lVRXRq?=
 =?utf-8?B?Tm5ha09hVnZIYXpkcVllMW95M1lrOUhHQnRxMXBuU0tnTFkrekRBMjZNWDB1?=
 =?utf-8?B?WDczMmwzNnpBa0lJUEhlbVdzSFR2M3k1OFhwYkRVeFRYaTA4UVp4WmdZZUVZ?=
 =?utf-8?B?SlNLNnIxRFZ5ZGJFbHc4VEJ2dVpIMEdiUXhXNjhkWk85TFFCdjcvUmlKYk5p?=
 =?utf-8?B?WHVzVmRLaU9GWG94emkwVmRmYlBLaWY2em5lZnVqM2NoSWtmZ3dLaDQ0cHdk?=
 =?utf-8?Q?YueLVpFleXQ271upwmwOASHvPhssiCKcT6eiljahYmQ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1R1MjRTL3J4NEduaEhQWXUxN3N5WmVtaTAxT09adDJzbFJRSUZFSWtXRllU?=
 =?utf-8?B?bm92VU9JOVVwaElKTThkdTJENzVjV0plb0JZUVRaeWpvbFBjVmVzbkFySzZY?=
 =?utf-8?B?dUduWXp6NXU1eVk4b243WXlXQzBXNXhvd20vWjdTOWhCakFHSkNXWXdubnF4?=
 =?utf-8?B?QkltQlR6QkhBeE1sRXRHU3d4eU04eG9jVk4xR2dNdkMzaFpHdDBIaWtVUExy?=
 =?utf-8?B?anRsajlEL1dkK29qemwxY1JaTkN0eDUydVdyZE9BZ2h3ODNVMU52SUlzYTZx?=
 =?utf-8?B?blJEVXFDMWpBQjA4ZHJBSE1McExaTnZQZStPek5ocXZHRTRFT1pkQzhrdU1F?=
 =?utf-8?B?TlhaWWVEcGRwVWlMU3BaY1Ryc3A3TVBTY1pXTXUyYUcxbHM3Z2FqRFNLbVdk?=
 =?utf-8?B?bmRvbGFqc0tkYURwV2dmaCswTENSUytVVEdZSmdBZmEwYkNKRVBCSXJBQ1hW?=
 =?utf-8?B?Y0lzRWRNRDZnQjcxWnhxQjk5MGhPcngrV1o3cEJZQXRyMmhJcndsdmdNQVpz?=
 =?utf-8?B?ZVNhYkhiOGMxcFZIQ25DL2V0K3BqSTRtUXo5TThnUk9ONURyb3ljVGZ3K29m?=
 =?utf-8?B?Y2liK2ZUdENWY0RpbmFqQkwvQStHM2F3aWI1bjNucDBPYy8vSXIvQ29HSW5y?=
 =?utf-8?B?bmNHblZXQ2FOeFRaR1JxQU1FY0F5ZHNnVWNIRVBUTUtYZm9rdHljK0Y3bE56?=
 =?utf-8?B?VHBFMDlKRXZNejNEeURueGZVSWYzVC8yYURDR2J5cU94aS9RbWNTMkxGcSty?=
 =?utf-8?B?eDh3RHhaN0taOHJvcGdYSnA4bDMwdmJXUWdFNFkzQjR2VnVqTVlCdHFSVjNh?=
 =?utf-8?B?Y2R2R0hiRGlRN1k2dXJ1SFN1dG5GeE1Yemt5RnQwRjFIcmd5S3NvcWpXRVU0?=
 =?utf-8?B?cktwR1hOZkt6aFdPbjIzQXRZT3RNdXB5cXhzSUFnRWFobUZmMWxtRHVPemU3?=
 =?utf-8?B?UVNRUGU3SnJybE1SaGdLM0s2NWMxcTZ3M3hUYVpKZ09rQlc2cWxaWEtRWGln?=
 =?utf-8?B?MmVTQm5OeU10WmJudDFleEhRcUdaYU9xMmhXaUJJV2tGeVQ3MmRoZWVoRmhy?=
 =?utf-8?B?QVZTckZOeSthMTljbm1lMElKVWxHd1JCMDJzMkczTlhXMlZORk16blVBczIr?=
 =?utf-8?B?RDR4aGNka1FuQ21KeHBDQmlMWTdEU2hxUlNXVloyY2FHZXU2NkthQVRCU0VW?=
 =?utf-8?B?a2R4bmY3OG5jNGIrOU9mZk1lRjFDdWlOcUNHeUN3RkozNytPei9kSVQvUW9I?=
 =?utf-8?B?YTVWWTZaaTg1KzdKWklQM0pyMU5IWkxnVmFyRmlmNzFsbWp5NFlwU2dGekdu?=
 =?utf-8?B?ZmlpTDJzQmtjMXc1MklERFQxL3pOQ0wrY25seHNPblBCR0dHdWlmREZCNjNJ?=
 =?utf-8?B?UjlOd2xJNmNPY3RTSEd3dGdjSzRmbWRSSXhIai8rUysrT3VIWkIvZDVmSGxp?=
 =?utf-8?B?NWRpaXBhMnFSck1Wek04UHVjOEwyNzcwbER1L1g1NXBWVUNTellnRUN2cW8w?=
 =?utf-8?B?NGd2b0tNRjljYnUvdXdDSzlVZkhxL09RUlhoVFlKRXpHSVhCVUExQWtUcjZP?=
 =?utf-8?B?anhLS0tlL2dPcHcwQW5YdW91T3cxZzIzdEhMY0Z3QS9CbEd2aytxVFZMeCtK?=
 =?utf-8?B?eDdxbXNVMnA5OWxHRFdmeTNqd3hRTW5ST0xzN0JYTENmNTFMOWRhVFZCU09w?=
 =?utf-8?B?dmZLQk5hbnNRSG1ZbDJFREIrUXUySGRxM3c5dFJOUG1QWE9zTVdqTkpPSmRU?=
 =?utf-8?B?NlBkeDA5OW05Qks3dEVVcVBsODRPc2Y2d3VGWVoyVVJUTzhuVGJwNDVVODR5?=
 =?utf-8?B?UUZDSmkzaGZ4enRjQnlWTkhLTFVBeEhVZ1VOWkpBL3B4N2loajZ5N2h1NFFu?=
 =?utf-8?B?WDhSQ2dOYS83VEVZM3h2SWF3dFo1U1VtamYvckFBUnFCWXJUL3J1R0M3bVQv?=
 =?utf-8?B?TVIrZFJyNlhDVUlmM0N2QUZRYTB6ZnJLaVFnaDRSQTVOK0xuTTQ5bktteXNi?=
 =?utf-8?B?aDBDUU1YWXVVUDB0b053VjIrWHMxekhxSEZVOG5JeHppRXhYVVA3WFkxaVBt?=
 =?utf-8?B?MTdQN0llMHpjdTg2NDE2V2UzaEdIL1d1bG96TUNqMkgrR0hodzgvL0lJcXhG?=
 =?utf-8?B?T0RjcDFxL011ZTkzTGN3RURvQ1BQWHVSMVBoOGhhZWpwZ2UycTN1WWg0c25C?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6757f06d-dcc5-4d0e-1d84-08dc6bc842b7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:25:03.8073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ag5w1I3LKkRSaN1BsTaMojli0SPNYi/oa86a4MVoMueuTE5E0E6xJJR4BZ2N1bEOAew7zKYTD2OpHgKUnLvOJ8N8DVJmb2W3hF/48ZhP3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8607
X-OriginatorOrg: intel.com

Hi Babu,

On 3/28/2024 6:06 PM, Babu Moger wrote:
> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
> feature only guarantees that RMIDs currently assigned to a processor will
> be tracked by hardware. The counters of any other RMIDs which are no longer
> being tracked will be reset to zero. The MBM event counters return
> "Unavailable" for the RMIDs that are not active.

I think it will be helpful to use consistent terms. For example, above uses
"tracked by hardware" as well as "active". "tracked by hardware" seems more
specific to me and I think it would help to understand this work if this is
used consistently.

> 
> Users can create 256 or more monitor groups. But there can be only limited

I think you write "Users can create 256 or more monitor groups." to match
with earlier "AMD hardware can support 256 or more RMIDs.". Can this be made
specific with "Users can create as many monitor groups as RMIDs supported."?
(please feel free to improve)

> number of groups that can give guaranteed monitoring numbers.  With ever
> changing configurations there is no way to definitely know which of these
> groups will be active for certain point of time. Users do not have the
> option to monitor a group or set of groups for certain period of time
> without worrying about RMID being reset in between.
> 
> The ABMC feature provides an option to the user to assign an RMID to the
> hardware counter and monitor the bandwidth for a longer duration.
> The assigned RMID will be active until the user unassigns it manually.
> There is no need to worry about counters being reset during this period.
> Additionally, the user can specify a bitmask identifying the specific
> bandwidth types from the given source to track with the counter.
> 
> Linux resctrl subsystem provides the interface to count maximum of two
> memory bandwidth events per group, from a combination of available total
> and local events. Keeping the current interface, users can assign a maximum
> of 2 ABMC counters per group. User will also have the option to assign only
> one counter to the group. If the system runs out of assignable ABMC
> counters, kernel will display an error. Users need to unassign an already
> assigned counter to make space for new assignments.
> 
> AMD hardware provides total of 32 ABMC counters when supported.

I am not sure if you want to mention this. As written this sounds like
a hardcoded value but it clear from later patches the number of counters
is learned from hardware.

> 
> The feature can be detected via CPUID_Fn80000020_EBX_x00 bit 5.
> Bits Description
> 5    ABMC (Assignable Bandwidth Monitoring Counters)
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

Reinette


