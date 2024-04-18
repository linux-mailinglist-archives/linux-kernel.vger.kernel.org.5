Return-Path: <linux-kernel+bounces-149544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B618B8A92A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95631C20FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20435C5F4;
	Thu, 18 Apr 2024 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RO2sADgj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A956454;
	Thu, 18 Apr 2024 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419645; cv=fail; b=I9cF7X0cijBYfgaFwg1fteW2IoW9HpaCpUDaaxhL57qJx2//EswAwiKq2UqxIBnOnbz530oWpxueXyn0MJC+TNT26u4al8E4kXFqD/eNhq5dmS8gNVBqIZj2WVXimu7XrZ19SvGO69U5WT2Pzm2LOYnp0a5wUo2sneStlQDWuiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419645; c=relaxed/simple;
	bh=noKsGAr7rRfarU8JOhM7pcFGBRl4O30ocSt0H3YsIi0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qscAin5vG7VEWkthCAaq0AyFD/hGQ6ZuNB0nVyaxCeX+LhemH+0U7OuufmYmNoDEJ587EA6QgiN+Fm8cPONJaEaFUE8WpGd5RdWAd1G+nPplzZtd7YsIItkt0ZsCzIQzGnP+r/61uD1LrtDClUXCLH40B+koaU6LP9LwpGIdpHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RO2sADgj; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713419644; x=1744955644;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=noKsGAr7rRfarU8JOhM7pcFGBRl4O30ocSt0H3YsIi0=;
  b=RO2sADgjwgQ1Zr8KEGPd2li0LcN8omzl78T2tUBxApbkbl1eSjFz8V2c
   qwX8T3L3CXCFYfrtVT3p4Fn5URPuNtyXqTmkOi6iU9v+Yz6TVw8O57Mwy
   qYrAAcgB3SA4Dn9O1PtzKEkKowegcOs584ygxPBdChACtezTJHLl5GDza
   wkAKjPNucTyaaKU1UcClFdfXp3kZszs7Chli88RrO1yddEsrkyKhGD/hh
   WO8FR21zDYZYYb0qW0Lk5ZFGP9kh8QKCdpgQ6t0x1NylmLS0f7N8dF12i
   NrRa/cITi1rT38gsbuz3+g0LxFOg6+aayxglDqgmJnI6LuignjSYGxTCP
   w==;
X-CSE-ConnectionGUID: F8vxpX0HRseKGQ2VC47iHA==
X-CSE-MsgGUID: eEMKXUHlTWyp7dqHrCKVRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9099708"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="9099708"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:54:03 -0700
X-CSE-ConnectionGUID: jC+vjwaIQSWtA3fgi4/qFg==
X-CSE-MsgGUID: UsskGQ/eStqTjL88T+htHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="27289204"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 22:54:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 22:54:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 22:54:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 22:54:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 22:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+0kNYdcH1ncPMH4pVVEAJkCdHNKg/2OQIPvpyOZheAmOuD2V0DqlepoSvtnrApwqGRTPwuToLlIk8lUEQe/bBPf/6C7WBa4wkldUo2eTatLEjdemcVCjHhVJPIUi9pQQg2mgeZ8T4r0ZfSdO0pN16x3JPQ+NHuW7ag+akRdMG0TQ2X9VRb63pKZsFmLZGzq5PB356b6C16Ics+xc5la5hwHaI0ywxm/nNN8MBkvHQAPovHNajkK7zl+/3lSEcnrknOn9AzkMHqy0DntPypYLYRr4uNvEHTPoEqAel6ifBbVp4tDLwUFVa5eTOtN8Law75JnSxw79WlUCL8TJYusFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3dHh7BDGKww8qOhFKkCvnB7EAIWYXHteMas4LfckP0=;
 b=duGS4vtgLbOEnwByZIpNgAc+RI6se6aofqSQYyXsg/LnuOE30ZrG42He5sfnWFvsI1+uo+Z1B+O37CQumxFFWY3EZs/j1kEK9c7xuOoNftl7v/rQBEKJpn2hQsgMAGoOZ806bnHdlvQCQP4IwGVITLTDVAk8MuKWjbVkM0sFVCpjOsFD7WjQARaUQqSUoMDDqm/PNzm9+zy1hhrlDdQbXlt4McvGWDSWOil0pgB7NJCC+5bJ3/XTffD8ZDOCMsF61O1n5ab6+zoxjmKgzSCkjVIBtOROJ9kh0HhnIG9poZdHjvYFz+UZ4SdI/0UR0dJNcCINV9gWPetiyYiEHlRh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by MW3PR11MB4763.namprd11.prod.outlook.com (2603:10b6:303:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Thu, 18 Apr
 2024 05:53:59 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165%6]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 05:53:59 +0000
Message-ID: <f0b85a37-ead0-4954-b7e0-dd09cbd9ab09@intel.com>
Date: Thu, 18 Apr 2024 13:53:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] PCI/AER: Enable RCEC to report internal error for
 CXL root port
To: Terry Bowman <Terry.Bowman@amd.com>, <dan.j.williams@intel.com>,
	<rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-4-ming4.li@intel.com>
 <7172ec2f-7cba-460b-a6c6-9fff45ba938b@amd.com>
 <b4a721c2-567d-4ab3-8a85-963e3f323e61@intel.com>
 <91ddd182-cc71-480f-a1b2-e7c31b29a549@amd.com>
Content-Language: en-US
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <91ddd182-cc71-480f-a1b2-e7c31b29a549@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|MW3PR11MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: a63749e8-6c9b-447a-8e98-08dc5f6bf0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2/OwuBEExxlLvr5k8RAVyb8fBhIVWAd6Jq3Ut50WtUgOn9oSb8C9TPuJcOM9w3zKlBWV9yyA1pDuS4jhiHAxUX7pqQt/cJRKcXzoxT9PvqVuxJJrUN157A2pvbARtR9qOSy8v++wrvRvojF00ljdASK8QKmAlCSp4HkGUryuC2D502HALCgwy9Lze8VLliUwiuTANRoPVRSLOYbQdp4y6Iq/lNV5FdHgCZxGSfIMmQpcEAwZo++oFXi0RoDs6DJZ2sjx6D7JnjZ8dyMugiTh9fkeLsb0XX+epyRAOWY7uNhuOkGC86mVYnMwfzf5U6fk9XeBCatRLtGg4MwflZVPmnrJ+ZgqS8EF0lEmAia9OGMoEWT6rDoXOL4hUFsSYG+ELWBzvep84hDnwfJLGoMY9wxvcZ2y5UE6eijsziPsLcJ4x3Tz3s1reo0FI/cB98UwYEjLT2+3u41WrSHQHf96epwoSXJNGgctQUX3t9kibhciH3s393NfyF1+AZ1SEuX4v4yBQEAs6Z+q4dL97df7PHKqopwuEwkYNLF0yAqZK5gAE7UBJsST7hV5qZoVy/WANjQo7FWXeWCpAX0sZFXeOD4FvCgl5P9BCyEP6tkZK43EwEcHf0Ci9ff24hA8qywqipIc+TIf2LkX7i8HYkGousemom4PNlm3NS1boIXfuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVJenUzUjh5REtXL2hxWWFObm1pcmx5WHpZeGxwTXBJRWU0NkNVN25pNzh2?=
 =?utf-8?B?SEk1c0VJUkFEdGJxaEdTSmdBenJJN3NPNjR0OWdyc0l1RzdGNWdDb1pSOGs1?=
 =?utf-8?B?UnlEMzlVd052RTlrOXRDbVRTdXp3aTJZN3M4UGdVZTQvNlpnMXEzSFlYM2wy?=
 =?utf-8?B?YUVZc1k3UkNHVS9hbmhPMENrdk9EYmplajE4S0xwbVRlUjNwaHNzaXV3Q0F2?=
 =?utf-8?B?SDUvMHlDSUpnWkRVNWI5SVF0OTJSREtwalhGdnYzNEM4dEtybjA2TS9peHRz?=
 =?utf-8?B?WHR6TmtoSFZ5QS8waEJSUzJPRlg0QU1IT0ZmZWp1ZHluRDgvT0VYTWN3dXJT?=
 =?utf-8?B?MktXNFFhbXF1a0tWSVVsZEhvaDdRYWRMNE1mZ1JZV0lmeForTlhGazMwTVhZ?=
 =?utf-8?B?ME5DVVBNSGdSbkxkNzQxN2NVMk92SWY4V0hMR3NpUjdCNmFRaklETEd6S1NX?=
 =?utf-8?B?R2d4YVhLUjNIc0tJVURVekhWbzgvQnBYeHRaWGN6TU05c3kvSzRFMC9sRWxh?=
 =?utf-8?B?UXZJRUhzd09VWm8xZG1oWWZpLzZ0ZWtaWHJSbmlrYkJUektsbTF3U3NDWGtF?=
 =?utf-8?B?ODNnUGZjRkRSL1pXVDNuc1crSHBXbUxkTk84T25HdUhGUWR1MUlQSWcxUGJ4?=
 =?utf-8?B?M0VXUjNNaDduMU5Zd1lTRW5Ibm1vN2ZtNndCUUs1SzBGczU5NnJuQXRTQjUy?=
 =?utf-8?B?WXlWcGZmWkt1UkMxSFN6REg5ZGxqTzl0NS9uMi91RmpOeDV0MHU0RzJjcTVP?=
 =?utf-8?B?bmY1c21DekJ0VkJYbVFhOGRJTTFiS3o0WkZOZ2VvRG4vNVJ6cHk4dVJ2WVBF?=
 =?utf-8?B?SVd1OWxwajl3Q0JTWFFtVkp3a1FoYmVCajBLcUhrNGxUblZvaFFSZnZZeGwv?=
 =?utf-8?B?RkpRKzUwb0lKRTZ0SzQrY3BsbkVIQ3BUb2hqN3Y1MWxtZEIrdEMyYmF1QTJ1?=
 =?utf-8?B?L0dBWGU2Y0JkQTZIUEpqc2JqcWkrT1hiOVd0Skk1Ris2V2NlS1p6Z3ZabG9k?=
 =?utf-8?B?QU4zVFVIekMxSXNtRUVXQXh6bUNGVkM5L05pa0NGMXRvVjh6UnRPNmxHL28r?=
 =?utf-8?B?NEZpVHlSTXFNenNqT2hrM3A2NFFJd0szL2g3S0Vnc3I3RldydmdjaXlqL0Jt?=
 =?utf-8?B?a1hqbjV2UHhCdjdSNDNsT3VDc2xzR0RZRUZrdi9ldDZNbmp3aXp3Nks1ckFn?=
 =?utf-8?B?azMycmg1Y1hSRnMrOUcrZnpqWFVmUGVGbEhFenE4OUlZQVFvNHlLWEI2L0Nx?=
 =?utf-8?B?YzZWTzRkaVlYL3VYR2lKc2tlcnZibXNWRnFSUFZDazl6cG1SSmxRMW5qVWkz?=
 =?utf-8?B?d2FFVVc3QWthcHpWZDdiOTJET0tiMFEyMlV1MFMwMFkxLytMWUljSUZRSHFJ?=
 =?utf-8?B?OXk1V3UveWprVkQ5MmpNWG9aQ09DQWRjN2dEaEJYNjZZMkFGRjNSN2NRbjIy?=
 =?utf-8?B?RFBUWW1LRXNHb0dFZFpXaTNWK2RzNlNYZkxUVTNXLzVLVDFGM3ovb01YcStm?=
 =?utf-8?B?eWtQZjhFN2J6K0hvVlhNMHNTWnpiK05WRjExTEhZcE9rNmdlQ0ZQSmhtaHN2?=
 =?utf-8?B?aldjTmlqblZlNmhWYXh0cnZIa3o4QW9lejVQVDczRmZlSC94cWpOc0w2Vnl6?=
 =?utf-8?B?VGplcEk4eGdBRWV3UkhtZnBzZnpuS243ek1MOXRud1dUdWpqQVVLN1FTRXBO?=
 =?utf-8?B?Tm13VkFpUWNSZmdNVElPaSt3MjV3UlFmWm1pU1FrVXEwdTh0WjZPWndhdWRS?=
 =?utf-8?B?N3M4RDVVODJscGpOTWphOGgydDBteDhqNWNrVloyZ2FhVk5EZ3dEb3VBWGky?=
 =?utf-8?B?Ti9tcTdiMXp1OGtzS1l3Z1RDZER5MHpmdHVieFRUSHlaeUNwRTNFZEpGd1ZM?=
 =?utf-8?B?ZlZyVENNUVhzNHpWRjJjREZPdXBvaE4xcDdGUjBJeU4weDBvLzdrVnZFVDVX?=
 =?utf-8?B?RFFKRXdLVEpiN3VLMHYyWEFMeERRTGJyNEZwQ2QrdHhSUkI3NEVaRnNPcWZM?=
 =?utf-8?B?ZXdGWEtSTnJFOTBLME5JTU9SNnB0cXo5STRWVEsvSUNGTmM5dG9DSFM1S3ky?=
 =?utf-8?B?S3Q1aUZxRFlaRk56U0FBYmZDVUwwYnk5STcwY20xcGRDNDNTcFdTY1FkTEdy?=
 =?utf-8?Q?8AH3TlL6P2E70WN6JD+aEafTO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a63749e8-6c9b-447a-8e98-08dc5f6bf0d4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 05:53:58.9626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyp99GZUc9Vx+my5iPVlXAZUFeNHgWZv2VNQdIxVov1YqZYeTulOaCOABox24pdxcAlDOGXgU+LOlZTqFDkgbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
X-OriginatorOrg: intel.com

On 4/16/2024 10:46 PM, Terry Bowman wrote:
> Hi Ming,
> 
> On 4/16/24 02:27, Li, Ming wrote:
>> On 3/26/2024 3:42 AM, Terry Bowman wrote:
>>> Hi Li, 
>>>
>>> I added comments below.
>>>
>>> On 3/13/24 03:35, Li Ming wrote:
>>>> Per CXl r3.1 section 12.2.2, CXL.cachemem protocol erros detected by CXL
>>>> root port could be logged in RCEC AER Extended Capability as
>>>> PCI_ERR_UNC_INTN or PCI_ERR_COR_INTERNAL. Unmask these errors for that
>>>> case.
>>>>
>>>> Signed-off-by: Li Ming <ming4.li@intel.com>
>>>> ---
>>>>  drivers/pci/pcie/aer.c | 24 +++++++++++++++++-------
>>>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index 42a3bd35a3e1..364c74e47273 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -985,7 +985,7 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>>  {
>>>>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>>>>  
>>>> -	return (pcie_ports_native || host->native_aer);
>>>> +	return (pcie_ports_native || host->native_aer) && host->is_cxl;
>>>>  }
>>>>  
>>>>  static bool is_internal_error(struct aer_err_info *info)
>>>> @@ -1041,8 +1041,13 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>>>  {
>>>>  	bool *handles_cxl = data;
>>>>  
>>>> -	if (!*handles_cxl)
>>>> -		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
>>>> +	if (!*handles_cxl && cxl_error_is_native(dev)) {
>>>> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END &&
>>>> +		    dev->rcec && is_cxl_mem_dev(dev))
>>>> +			*handles_cxl = true;
>>>> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>>>> +			*handles_cxl = true;
>>>> +	}
>>> I understand a root port can be found under an RCEC. It's possible. But, does the downstream 
>>> root port forward AER to the upstream RCEC? My understanding is AER is handled and processed
>>> at the first root port/RCEC upstream from the device/RCH/USP/DSP.
>>>  
>>> Regards,
>>> Terry
>>>
>>
>> CXL r3.1 section 12.2.2 mentions this:
>>
>> "If the CXL.cachemem protocol errors detected by a CXL root port are logged as
>> CIEs or UIEs in an RCEC’s AER Extended Capability, it is recommended that the System
>> Firmware populate an RDPAS record (see Section 9.18.1.5) to establish the association
>> between the RCEC and the root port."
>>
>> I think it means that CXL root port is possible to forward its AER to RCEC.
>>
>> Thanks
>> Ming
>>
> 
> Thanks for pointing to spec details. 
> 
> In testing here, we used root port as agent to consume root port CXL protocol errors.
> The logic to handle the root port errors requires little to no AER driver changes.
> This results in a root port consuming VH protocol errors and RCEC consuming RCD 
> protocol errors. The RCEC and root port both use the PCIe port bus driver's AER service
> driver in separate instances for RCEC-RCD and root-port-VH.
> 
> The driver support is much simpler if RCEC does not handle VH protocol errors. Is there 
> a reason to forward root port VH mode protocol errors to an RCEC rather than consume 
> in the root port's AER driver and forward to CXL error handler? 
> 
> Regards,
> Terry

I agree that is simpler if only root port handle VH protocol errors, but I think that software has no chance to choose if VH protocol errors reported to RCEC or root port, it depends on platform implementation. So I think we should support both cases.


Thanks
Ming

> 
>>>>  
>>>>  	/* Non-zero terminates iteration */
>>>>  	return *handles_cxl;
>>>> @@ -1054,13 +1059,18 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
>>>>  
>>>>  	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
>>>>  	    pcie_aer_is_native(rcec))
>>>> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>>>> +		pcie_walk_rcec_all(rcec, handles_cxl_error_iter, &handles_cxl);
>>>>  
>>>>  	return handles_cxl;
>>>>  }
>>>>  
>>>> -static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>>> +static void cxl_enable_rcec(struct pci_dev *rcec)
>>>>  {
>>>> +	/*
>>>> +	 * Enable RCEC's internal error report for two cases:
>>>> +	 * 1. RCiEP detected CXL.cachemem protocol errors
>>>> +	 * 2. CXL root port detected CXL.cachemem protocol errors.
>>>> +	 */
>>>>  	if (!handles_cxl_errors(rcec))
>>>>  		return;
>>>>  
>>>> @@ -1069,7 +1079,7 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>>>  }
>>>>  
>>>>  #else
>>>> -static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>>>> +static inline void cxl_enable_rcec(struct pci_dev *dev) { }
>>>>  static inline void cxl_rch_handle_error(struct pci_dev *dev,
>>>>  					struct aer_err_info *info) { }
>>>>  #endif
>>>> @@ -1494,7 +1504,7 @@ static int aer_probe(struct pcie_device *dev)
>>>>  		return status;
>>>>  	}
>>>>  
>>>> -	cxl_rch_enable_rcec(port);
>>>> +	cxl_enable_rcec(port);
>>>>  	aer_enable_rootport(rpc);
>>>>  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>>>>  	return 0;
>>


