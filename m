Return-Path: <linux-kernel+bounces-138224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D71E89EE44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A231F228A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F7A15A49E;
	Wed, 10 Apr 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaLLmzVx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636241553BB;
	Wed, 10 Apr 2024 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740264; cv=fail; b=ViGeaCQPvXgBhCkYCk0KoT1j7WjrpGqiVAjIcpEGoIqK6pHrtj3oy2i/yDUMy7TUQt00LSFmbPYJx/ddb8PPCXki9Ocq+O1iT/hLXb4PSoRUfF+SSN02q9Qz4xcFHecsOPdjC5XjAIefk5HHatVv1OtuYR2C5imZQWU41RdfBbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740264; c=relaxed/simple;
	bh=ji6RmE7VTuefPAwQtMuzrce8oxDcLujb5F9CHZmvHoc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MzTREAxS1Xn0XfcUHQDiqpqxE+SmiADoxwZepChtwBHFKHTUQlpQvrt6JlOhb2O+dD8Si/o64RAlNcKWXU23F2Q5cH56okme67BRrAk6GRglrMVNPATSmI/abqapfs0xIj06+SIkuLhh0jy3DUypxpxQ2Lfnvg2WnO0+sypnzX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaLLmzVx; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712740263; x=1744276263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ji6RmE7VTuefPAwQtMuzrce8oxDcLujb5F9CHZmvHoc=;
  b=FaLLmzVxgdjIm4WHeSJL4JbLp7GlK9vmMsb4IwOfCEhgsDbumMNh027b
   rQdW3hvsC8Z9PCiNMxnS+p4Jd/Dcw+3z7nUBidrxE2M2X6k0du9n3zYZt
   i8ClCeLjEPjdfSpXPM6QYCQmnStVhbTA+ZHsHQ3UYmB8OACShn2ox/vjF
   TkO8Tj7zXLtk+BjSLmImMsdf21yfRZbplnxYxESfVUKKRjALcjt8UV+TH
   tiFRPblQwWqXJjV8uVzfOTKttewdCU6Ocu0Dls5hDA+O7NxNht1CNsCmy
   9Tti7+qsbOrfZrqHAiQVqnk2NFcsDK9rpUDVVSUqyKsciQZvyprGgRuTs
   g==;
X-CSE-ConnectionGUID: FDdAPwNAS0Se+7bqCLeliQ==
X-CSE-MsgGUID: 2EORgpzBTyy+6hcFyBVPOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7948578"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7948578"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 02:11:02 -0700
X-CSE-ConnectionGUID: K0O9n/EZSpuy0/VER3ySBQ==
X-CSE-MsgGUID: SgiZMsT3Tj+sFgcKDhyfnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43740616"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 02:11:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 02:11:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 02:11:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 02:11:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 02:11:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBB6GPgkbnqy3SC3AWzX9cYOx3XgDdepFFAnbY7rQ2nWZ9jrfWxz7a5b4nsAQo+VQydpnAfBrVuvSQpYwovKg/czt7IzG61qOgdsgg8/XYQuelXJCXaqcP3V4It3/zYjAC3sdPTKk8O8Ti4L/0XTCovMxPbyJlqhgWDWuKXyuxAKTtTT0qbEujxl0t59wyrB7lq6JMR/fs1Q6AZgA17F4qoJaDN8mVfiMh1dU+K7IHSDAdhtePYPn8jdglxWaiBn4T3FN2F3LDFO/5zlIUdyQkEnvNmGrrReQhyqPQjOecpE5hiZlB8wrNVCGVHrPoF6vCtn7IWxSugBb/DANqN40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHnwee8odR6cnYaXhu3rmSeBZDNIPjElEti3yKpVyYA=;
 b=MCuTrJRfSJBsvaHqtZBYQ0JOKWZPUDydaxHXnc7t42C0oGMe+iyr4PDuO0BTJTFskpk9Eo0uemo9eUnTytnErqgjdLygEILtNBqOXBicjez4ccK1CmfwmXoB/2dUSvhBBWy5P+qlAl0Cy+ruuTODYGcHSHldPMenPX0uFAy/iLkZKqKXbdrwk57w87iN3fYOKTooR2mNa/EhRo67wy75sw0ZcRucP3nDkg/8H9ok18tshRmUvu0t3vVMKm52jIzFxRmdrSxuPtzVFAuHxeSOSjLaLtLurdAO/BsY8Ni2elQUkMKf7ooWqJDfKB7rt5NSgWyHPn03/kYyMptfxJK5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.25; Wed, 10 Apr 2024 09:10:56 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 09:10:56 +0000
Message-ID: <bb0fbd29-c098-4a62-9217-c9fd1a450250@intel.com>
Date: Wed, 10 Apr 2024 02:10:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [intel-next 1/2] net/i40e: link NAPI instances to queues and IRQs
To: Joe Damato <jdamato@fastly.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>
CC: <sridhar.samudrala@intel.com>, <nalramli@fastly.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240410043936.206169-1-jdamato@fastly.com>
 <20240410043936.206169-2-jdamato@fastly.com>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240410043936.206169-2-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:303:87::30) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM4PR11MB5971:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pHA0KpAJfV0uVMoH+zej/MS3a+jr08Qmc21rthQT+X5F1xIiY4w6u8BuIbDpv7ST1LntZs++XAUkG4BweE9xsDFy5Z5kmGUho12tz3Zjz0Stz4N2/sKCFdWYRakbLzHsGmi12SAvshRUd0R5NqbnJauQA74Nu5v4p0PvQ56BF3cIYFuk3ZaXPTfcu3pVrKRhl3/fWRDezFmY0hWbwBSkyOEKB0MUXcLoOK/zR1/wASbJgakLcKTQ+zdHc8C94V+t3fnQm2VbzI1OcEOJsLAuuTYs2bENpZMyE0N8em6cCfsV1wZbU7bl2FJ0lbAxRMQWv3stkvN7WSCNHhgPf4KAXhxY9Vr8YjDGwDxoJhJCTIiJfHsT74DU2kXeU/IGZjFri0grxK/VMbQHbENAyrqn6sE6SZFJKOfEPg19nUGQHjASrYDqBlIX0NZiretcYf08T4k7H0axLjSOOanEluyeYFhz+YtZnLxnRnJ6g8r8rZP8VV+oHVwNMnaYgZNC7XvhrKbrNFurmq8rTGsjsME1wdigsgcK0pAEpxIxQcQIeH0GA8xYIQ8JXnlsnJJ0kcQiYP5m+gQVhsAU7iCUM1N9n2jr1qwM/aP6hqoRZJmQlYITAeLuL3swFvQ7rVn/sLASQ6VS2+VBF9C+IjkKRDSDDCrqPANKl9WsdEotRP4z8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THkrWlRuTnNJRmxkYkttVjgrMUhhZXdwRVBXa21HTm5ZYzVnd2Q2RUduL3lU?=
 =?utf-8?B?R3hmekk2RllOQmZtK25XWDdDL2tvS3BKOEZwNXpXQkk2NkhVaHhEQVd6T3Qv?=
 =?utf-8?B?NFNZU1JtMytyWWI1STAxT2lkYzA5VEtxSTNNRGdsTDdUUUJoL1NQNUFpd0lj?=
 =?utf-8?B?ZzVGNnNpWitxWEd0cmduRDJScXZQdENsMlBiL3Izd2FGRGhvcmFxc2NKL3Ro?=
 =?utf-8?B?cjcyTFZMZkFiSy9KS1I3Tm8wTUJ0aytDclptTkZCVDYvQ3loaXZRNmdQVWZY?=
 =?utf-8?B?cDdyUkx6eTBXWHlwdWs3aFhpdDN5cFlOaVpLcEtROVM1WjNFU3MwSk80V1Vw?=
 =?utf-8?B?VWNsTFFZQkF3WGZOb0ZibmxFQlBMQnVKbS9ySUJ0QXpEaEhLZUFUNGRCVEU3?=
 =?utf-8?B?QXYvYzBwckx4OGZRMXNZN1BSK3JjN0ZyNjJBbWw4L1h1WnZiR0pwN2wxVG94?=
 =?utf-8?B?M2p4dUZ4bkJqa1FXZ1VReHBhd0FBSTNldDd6Sk8wb0dRZTBLNEVObURuWEdn?=
 =?utf-8?B?WkdRcFpkdnlUY3paQWppOHF3M3lSaXlWQ3dVWjBUalJjMDdEdjFFMUhiZkpO?=
 =?utf-8?B?NFI5UUNwbUY1ZFBDSXh1UEErZzZaRnVOM2x3T0NmK3hkdE5SbXJmOGZGQkxM?=
 =?utf-8?B?SzYraUhQTjI2SFVzbmwwZldwVkVGV1Y0UEdCdXZBYnpDa0pFRWNuaHlwVnNs?=
 =?utf-8?B?S3FnRStzVUFLQmNvTE43UXJvRFhhTTUwaS80c1dVd3RoOVpZamJkQXpqVGdM?=
 =?utf-8?B?SWpsZGhPQUsybTJXV3l3TFkreFVQUG1naXl1V0VjQ3ZjSVF5V0VKVGR5Qkds?=
 =?utf-8?B?ME9uL24rN2tGV3Q5SjRYdFQxSGtZYU9HMXJGVTlWeWpoMTcxdXRLaFMrSGdu?=
 =?utf-8?B?Z2hMcFRTN2pDM1ZiZTQzRVg4VU9YOUI3RXlpemZWeGhvSTY1bDdha1dMeEwy?=
 =?utf-8?B?S2FvcVRRYlAwRS90MzEvVUNuVGk4UVA3aUdPNWt5aG0rdWhobTBPQkljb3hD?=
 =?utf-8?B?ZkkrRExNWlhwRkdSbEZrQnMzNzJFZ3lSR1NNb1d2Z2JZSVBCNmY0RVNJNTl2?=
 =?utf-8?B?MlhyRXZiOG1jOXg2TXRBSG9qY2ZubVJ0VDgrYmVLNUozeUo2elZPNHR0bHZj?=
 =?utf-8?B?SExxcDFocTdrQ1JRcktkSERlVzA1WTlWR3dTNVNRNWFxemVENENxaWJlbzgw?=
 =?utf-8?B?VERhTW9PNUxja2ZidDJEWlVFczBSOXZDY3ZUZVhIRVg1WjFUOE1CNk9RUW42?=
 =?utf-8?B?MmRZQ2NZNVB6QXFULzZacC8zVjFkODUyL1cxUnJmMjdCSzlpZHVsUEJIMmp2?=
 =?utf-8?B?NjNyeDgyYmhMeXJtYTg3LytOY2liV0dhaVJyZlRHdktJKzBwSSs3QjR3eUww?=
 =?utf-8?B?WU83eGFGN0JXQ3ZKZHFMaEdzOC9ySzI2ZWVtcFEydkNSQVE5eDFlekQzL0cy?=
 =?utf-8?B?MmRNQkppWm43RjRWbDN0NnlvaWp1NVJ6WXl1ZUFLY3o2b05oUUh2S0FjUDJm?=
 =?utf-8?B?QlBvNy9jRUl0WmdzUWc4M0IrVVNuM1J1RjZuYjJvRHRtQlhFNHgrUUJ4RG9n?=
 =?utf-8?B?KzhDeHJIaXZWdGVJWnRub0ZhSGM2UmdTRDVBOUd2OXlubHhDMXJEQXdPbWdn?=
 =?utf-8?B?YXcwcG1palQzZzcrN2J2T2NpWWJMTE9lMTJQVi93VG0wdlZBSk81UlpWTCtt?=
 =?utf-8?B?SzI5UEREOFdlelY3bGQ0SERzZmdXYWdUajZxVWR0Sno4NDJZdUNmbG1ON1RD?=
 =?utf-8?B?R1pjTkVCd1REZWxWUFJzYWVQMVlYUi90M3U5ZHE4VWJaSlphTS93eDB2UWY1?=
 =?utf-8?B?U01uWVIrRWZnb2lEUGZPRWQvN0dYMUdQNWNFUGJZTWlTdlVXa0VsRlBhMHh5?=
 =?utf-8?B?ekhHS1NhanJUS2gzSG5SMFoxOHJ0VHEyYVVOMzNQRVFWMVVTNTlCYlE4VHFw?=
 =?utf-8?B?bHZibmt6S255N1p0WmZCVVJXSzF4b2QzeklKNHBJYWVKQkhZdXF4WnJWd0xT?=
 =?utf-8?B?eVNXZTRoMm1mUHltVXFBdVllYUYrZ1hwdDcrVVV6ek1kY0VmTW1IbmdhTnMr?=
 =?utf-8?B?MGFZUmFVMmhWUVVha21YVTdMTUErUFU1YkhmNlY0SjE3NTRZcG56M3lPZENR?=
 =?utf-8?B?V3h6NEdnSFZwbHV1NXc0Z1lsV1RHVDl2Z0JYRkdwUXJZcUd4bDE4T2lrOHRH?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b54bf2-5912-443e-782d-08dc593e2124
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:10:56.0889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRgE1uuO1ArTl0tpfzEjHDI9G01Obj4Fsl9XSsFzx36X6m8sm0OBLxZCobC88cf4DXUzQDdJ6lFu1O9dqgvb1N7n7/UDnzNWLdAGtrP2WpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com

On 4/9/2024 9:39 PM, Joe Damato wrote:
> Make i40e compatible with the newly added netlink queue GET APIs.
> 
> $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>    --do queue-get --json '{"ifindex": 3, "id": 1, "type": "rx"}'
> 
> {'id': 1, 'ifindex': 3, 'napi-id': 162, 'type': 'rx'}
> 
> $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>    --do napi-get --json '{"id": 162}'
> 
> {'id': 162, 'ifindex': 3, 'irq': 136}
> 
> The above output suggests that irq 136 was allocated for queue 1, which has
> a NAPI ID of 162.
> 
> To double check this is correct, the IRQ to queue mapping can be verified
> by checking /proc/interrupts:
> 
> $ cat /proc/interrupts  | grep 136\: | \
>    awk '{print "irq: " $1 " name " $76}'
> 
> irq: 136: name i40e-vlan300-TxRx-1
> 
> Suggests that queue 1 has IRQ 136, as expected.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h      |  2 +
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 58 +++++++++++++++++++++
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c |  4 ++
>   3 files changed, 64 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 2fbabcdb5bb5..5900ed5c7170 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -1267,6 +1267,8 @@ int i40e_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
>   int i40e_open(struct net_device *netdev);
>   int i40e_close(struct net_device *netdev);
>   int i40e_vsi_open(struct i40e_vsi *vsi);
> +void i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
> +			 enum netdev_queue_type type, struct napi_struct *napi);
>   void i40e_vlan_stripping_disable(struct i40e_vsi *vsi);
>   int i40e_add_vlan_all_mac(struct i40e_vsi *vsi, s16 vid);
>   int i40e_vsi_add_vlan(struct i40e_vsi *vsi, u16 vid);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 0bdcdea0be3e..6384a0c73a05 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3448,6 +3448,58 @@ static struct xsk_buff_pool *i40e_xsk_pool(struct i40e_ring *ring)
>   	return xsk_get_pool_from_qid(ring->vsi->netdev, qid);
>   }
>   
> +/**
> + * __i40e_queue_set_napi - Set the napi instance for the queue
> + * @dev: device to which NAPI and queue belong
> + * @queue_index: Index of queue
> + * @type: queue type as RX or TX
> + * @napi: NAPI context
> + * @locked: is the rtnl_lock already held
> + *
> + * Set the napi instance for the queue. Caller indicates the lock status.
> + */
> +static void
> +__i40e_queue_set_napi(struct net_device *dev, unsigned int queue_index,
> +		      enum netdev_queue_type type, struct napi_struct *napi,
> +		      bool locked)
> +{
> +	if (!locked)
> +		rtnl_lock();
> +	netif_queue_set_napi(dev, queue_index, type, napi);
> +	if (!locked)
> +		rtnl_unlock();
> +}
> +
> +/**
> + * i40e_queue_set_napi - Set the napi instance for the queue
> + * @vsi: VSI being configured
> + * @queue_index: Index of queue
> + * @type: queue type as RX or TX
> + * @napi: NAPI context
> + *
> + * Set the napi instance for the queue. The rtnl lock state is derived from the
> + * execution path.
> + */
> +void
> +i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
> +		    enum netdev_queue_type type, struct napi_struct *napi)
> +{
> +	struct i40e_pf *pf = vsi->back;
> +
> +	if (!vsi->netdev)
> +		return;
> +
> +	if (current_work() == &pf->service_task ||
> +	    test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||

I think we might need something like ICE_PREPARED_FOR_RESET which 
detects all kinds of resets(PFR/CORE/GLOBR). __I40E_PF_RESET_REQUESTED 
handles PFR only. So, this might assert for RTNL lock on CORER/GLOBR.

> +	    test_bit(__I40E_DOWN, pf->state) ||
> +	    test_bit(__I40E_SUSPENDED, pf->state))
> +		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
> +				      false);
> +	else
> +		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
> +				      true);
> +}
> +
>   /**
>    * i40e_configure_tx_ring - Configure a transmit ring context and rest
>    * @ring: The Tx ring to configure
> @@ -3558,6 +3610,8 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>   	/* cache tail off for easier writes later */
>   	ring->tail = hw->hw_addr + I40E_QTX_TAIL(pf_q);
>   
> +	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_TX,
> +			    &ring->q_vector->napi);

I am not sure very sure of this, have you tested this for the 
reset/rebuild path as well (example: ethtool -L and change queues). Just 
wondering if this path is taken for first time VSI init or additionally 
for any VSI rebuilds as well.

>   	return 0;
>   }
>   
> @@ -3716,6 +3770,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>   			 ring->queue_index, pf_q);
>   	}
>   
> +	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_RX,
> +			    &ring->q_vector->napi);
>
Same as above.

   	return 0;
>   }
>   
> @@ -4178,6 +4234,8 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
>   		q_vector->affinity_notify.notify = i40e_irq_affinity_notify;
>   		q_vector->affinity_notify.release = i40e_irq_affinity_release;
>   		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
> +		netif_napi_set_irq(&q_vector->napi, q_vector->irq_num);
> +
>   		/* Spread affinity hints out across online CPUs.
>   		 *
>   		 * get_cpu_mask returns a static constant mask with
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 64d198ed166b..d380885ff26d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -821,6 +821,8 @@ void i40e_clean_tx_ring(struct i40e_ring *tx_ring)
>   void i40e_free_tx_resources(struct i40e_ring *tx_ring)
>   {
>   	i40e_clean_tx_ring(tx_ring);
> +	i40e_queue_set_napi(tx_ring->vsi, tx_ring->queue_index,
> +			    NETDEV_QUEUE_TYPE_TX, NULL);
>   	kfree(tx_ring->tx_bi);
>   	tx_ring->tx_bi = NULL;
>   
> @@ -1526,6 +1528,8 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
>   void i40e_free_rx_resources(struct i40e_ring *rx_ring)
>   {
>   	i40e_clean_rx_ring(rx_ring);
> +	i40e_queue_set_napi(rx_ring->vsi, rx_ring->queue_index,
> +			    NETDEV_QUEUE_TYPE_RX, NULL);
>   	if (rx_ring->vsi->type == I40E_VSI_MAIN)
>   		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>   	rx_ring->xdp_prog = NULL;

