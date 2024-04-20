Return-Path: <linux-kernel+bounces-152113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4A8AB94E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9651D1C20BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259DD51D;
	Sat, 20 Apr 2024 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGLqjNia"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F772563
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713585517; cv=fail; b=XyfHO2YC8ClBy4ppqBZNcSlZUQhoFRsWf9xzKCBViXRONPVIFB6GPr0sF96Y91zBPKOR1LK+ch0Db0SCthH+GUhyL4zgl6cDeMbh+23UITxdTwGUoDVNKl83EOjUWELUJJhNsGzQ7qc2ZjJ5d3HZYBvHyFuCdBfZtn5HNmt8wQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713585517; c=relaxed/simple;
	bh=TIfSGzv5Z1RSUs5H8G27aQFnApVKqMW2zwqhKyFFPoU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NCloGWOd/zSGO4blicXjsabM9oLvIHB99bZtNJJ2F6cXCXI/bewFl8cKUsNGy9LR84clpYGX7cmDer8OBTuqQP/CFVeX4YtaRyHdXwdUXVi2xyImsCQEOjZWe35unMdrxdV7dg0it5y/kX9+ZQ0ROsoDAfQmjpkwhPaFa/wy4ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGLqjNia; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713585515; x=1745121515;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TIfSGzv5Z1RSUs5H8G27aQFnApVKqMW2zwqhKyFFPoU=;
  b=QGLqjNiaooEpi0cMPyPEjoTBb+8iXEUNiTj0QVG6EyXY5qJogmTBNq/w
   5cUu5m2Wso/0D5z6NzFBX5A8/GRqLPwcRqsqWiE50vohGTuxUofJR/CtM
   YWAjkE+TPRMP1HHsVuu+IE75GPY05i24wteyUinW9OZYFqM4fs03I29rm
   z3PBWEdLLqZL86aTnCBdEWL10tn/mYGL2BP94VjK2hUl51GEW/UVqKzJo
   GQ246VLq7PTm/lyB5dKrYLqrHZCGS6pM7/B+yIxXP59jTySB/vCOjgVUa
   b8nhPR+3JxByD4VY4ckMdGFczXd8bGDCq9Z9jZ0O1z/oQDyFxJ2va5H7b
   Q==;
X-CSE-ConnectionGUID: gXmkWyJRS+2Dy+ptHhNNMA==
X-CSE-MsgGUID: arfHDJftQ9CNkTiTNrkdww==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9120225"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="9120225"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 20:58:34 -0700
X-CSE-ConnectionGUID: JH7EV6t6TKaKLXGH/+45yQ==
X-CSE-MsgGUID: vzKRGeboTEKU665wCyPJUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="28170607"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 20:58:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 20:58:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 20:58:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 20:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqMJZRxcqxGucdN9H1lc+0XJZhq0bRwqpEtDeZQkj4YkS+MeLarEOP8UMQqvOCGn1nHgUX796k/Bq5dVgm3pm/ZZDF9I74/JXj4U5qh+7JRDMAVPVjPuwaVVr93qPbSp/uSNQEknGNElmXmOEYC5RVRpc8QhTWWhchszt6IjV8mRGN7oGzd3GeIulCdIisMUw+58JllOkpcmrmX8hTP9ToQePOZ+9nNonRjgPSAvEsQzDbTE4NPiPMJaF/zSwkcZ/YSl1agz6cHfpAJyS+h+fFywHONoyDCwvV+KbZ9QOi23soxazlU96IsaPgYYpVYGrqYxwxi7tcBGg22pwJlBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOY5gmXF5BkVWz9PCquLZpInw8uSaruyKsdOjOzgddc=;
 b=fQnTIWBKULCcnv/JMClm8ztVgTbictEaRbiWg6OAQQmnbD00g2Z4wKyoUrcoWo0wjWWClaRNjvhAGL8q6tqhH+24NVRyg0KhHqwrkLMIHjHNGZeLcCJGHLJZsTxOjZ+XGCvxR/1+Lmsj1CzvMxbuTlMojx6zadgN93JVqiQu5hGzvW+FhayV7jT7kPD20meVTcPxUosteMbGNgQnF8ga/28he/+lk4iY+99dKUZaLBWaN2RJ4oYvm8o9fxtEt7TIlUo4C8m3OtMPgjQgCeEIbEk8RJzJ5JJU149fH9DiGinoNd9423xILxjwRs1GXsoCymnv514a+yNHADBOapmZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Sat, 20 Apr
 2024 03:58:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.010; Sat, 20 Apr 2024
 03:58:22 +0000
Message-ID: <7e424ab4-e769-4eb5-b3d4-8ff7e7a76012@intel.com>
Date: Fri, 19 Apr 2024 20:58:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/31] x86/resctrl: Remove rdtgroup from
 update_cpu_closid_rmid()
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
 <20240321165106.31602-6-james.morse@arm.com>
 <6bbff669-cbe5-4284-b64a-4825a541b35f@intel.com>
 <ZhldWJVck7VmU3G3@e133380.arm.com>
 <0698418a-aede-40d6-90ce-dbf6e8796916@intel.com>
 <Zh6kchkH9Dy+ywXc@e133380.arm.com>
 <069c0e2e-81e1-4343-8a9f-21f1cb74bde6@intel.com>
 <ZiE6X3nKu1ACFQDc@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZiE6X3nKu1ACFQDc@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5c7e56-5775-425c-a9f7-08dc60ee1f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUFOaDhzWFFSNjZwQzFhNkJiZm9YeldhQTlrb3VvalplRXhxenJONEhWWU9W?=
 =?utf-8?B?dy91MFN6QjVrdTFrdmZMMmN3dTJWSDRadWJYWVRvbzl3dFIxTkFmSVlJTTJn?=
 =?utf-8?B?UFhoZWpHdnN3RUFlMkRzdktRNzVCWWJtNW9JekZpSEhrWDVzL0ptMlg3Zm9U?=
 =?utf-8?B?MW5ENnNsQzhkeXJjWnRqSHdleU00dGpTTS9CY3lybzM0K29vSzdpdG40UU4y?=
 =?utf-8?B?R3lxc2g5MjhkbngxT2pzb3R6MW52d0I2UkgzSEtPcnpDUXJuNTN2bzZvbzVF?=
 =?utf-8?B?TXA4YnFPQzhyckpNOEt6NS82TzJLNkpwUVlVWEs2NkFwcGpROG00Z0hIYW1L?=
 =?utf-8?B?NGxIUmo4bUpKKzZHRnFoNUdFZEZzVmYwdTlhT2xRQ3laS1dvWFEyWVVRZ3JW?=
 =?utf-8?B?YXRCM0VXRituTkx6R00xRzRBcWpoRllTcXJsVWJIOTFUUFJiZ0NBY1MyYUNm?=
 =?utf-8?B?KzFDUHlJWlVFYWx6UjlNdFhXdWtTbmJvdmY2L3dLd1BiRndwSnpvTXJSNEE4?=
 =?utf-8?B?M0FuMnNXNTRmWHo2MWc0Q3pVZ2V6eXJDMStuNkF0TXgxRE5kbHVVNlN2RmRq?=
 =?utf-8?B?MmkyWDNxRmxCRDhyNHZWTHQ4RU9ROUpFYmxPNTFoTEpwUERjeU9CNDQrMHZO?=
 =?utf-8?B?bnFhNGhndExwdUNuQUhaSGlKNCtDbHVoYXYxc1NuT3lVNTg3dDdHTXdOdGN1?=
 =?utf-8?B?VkRJaGw1eXRBUlBta09Fc3JwbDIxTURoU1RCNWtsc1E1Nkl6TUJmb1AwR0x1?=
 =?utf-8?B?djF1Q3JYQ0FralFVdnpYZ1pSeVVyRHdDZmx6TFRjTnQ0U1hHRDVHZG5WSmdO?=
 =?utf-8?B?ZlViL1UxWlY2dlV4ZjZTRlUvZ2FybHVDMnh2RFA5SVRyTW1IQUJPdFE1c1Vy?=
 =?utf-8?B?Rm10SUdGNnB4SE1MSUxtUTh5QVB6by9jdEpGNXp5Y3JiNU1kaktWUHh5WDFs?=
 =?utf-8?B?WDlyL0xIWmFhU2hXcnhld2ZrbjluZGlzNEUxd1hVR2NzQm8wemNxZEMzYnJY?=
 =?utf-8?B?OGR6RWhkdmpBMm5HTFNRendkR1ZZNnVpazFsY01UeGlsSzhBeFJxbHVxdnN6?=
 =?utf-8?B?RXcvU1FmajJuZ0xHYm51Vlp1Mm5oM1hOcUE3RG93NzRWUER4ZGJ2eWZkU2da?=
 =?utf-8?B?a2JqTjc1amx1aEdoWHBQNGlRZndOV0JEd09LMUwyUW1PSFVFa1BvZVJWOG0w?=
 =?utf-8?B?QzdyRStXdzNkOG1zRUZjNWFERnRsQ3BDUXg2ckFCU2tya28zNlFieEV4ZDIw?=
 =?utf-8?B?eFJiL3AzaDVxK2VjVEhxMFR1aWVHREVGZXc4SGlGYUQ2RWFDZ1ZVWFZmNEdW?=
 =?utf-8?B?cVRpK1N5ai8rRlNkSDE5bXIwNUZWVG5LSXVXYXovY3hSTE0zT2gzb3FibzI3?=
 =?utf-8?B?NmpSQ1NFRlorb2pkV1VRbU00VXF3YTM5OWVUVU9aNDlMWGUrUHVSaXVzRTFF?=
 =?utf-8?B?bzZRYTNobnF5VFZJdHU3M3UyMlNYOVdXNWk5ZEU4SEtqWkp1L3hnV2NDbHZp?=
 =?utf-8?B?RzVWc2tEOEpTRG1MMnRyU1ZWekkzTU0xSGFOcEZrNUpPc0tuUVhLRHNwZnhk?=
 =?utf-8?B?V0pNODhMTkowU0JibkJjZ0lRUWhjNzM3b09sTHNseDJPUTZmOHpDN1duNWUz?=
 =?utf-8?Q?uG2ztUMLn8xBEDsFppqynUb335pt5rqrQ/SvtdQWZoms=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGRESnBpbWNhUXpTL0Z1OEdtSjRJaTIwdWpQVVQ4MmRDQUZvcFR1VE1iQi92?=
 =?utf-8?B?RWVSYkRXdUtBTjRSNDFRUDU1VGM5aCtwT3hBSFh2RzYzRlhrdFFLVlZVR2ll?=
 =?utf-8?B?MDZ4eER4RTIrbk5kMW1qYVJlb2ZIMEpsY2RpZzV2b3ZNZDlCWDEyOWdQVUx1?=
 =?utf-8?B?M2tVZkxCZXY3anZSQzRVZ1BLQkZ4aGluNUdyV0NOYUo5dmdQbCtvR1FIZWRv?=
 =?utf-8?B?VmVUVmZGUVVsTElYZTRtakVLSmdKWWlIUWFpTVczakJ3YkNZbFBpTTZta2NO?=
 =?utf-8?B?ZWNWMXVHWWNKdndsRURpNzg3NkwwdW4vWEd3dGd0ZUlKU21uT2lKbzdKalBz?=
 =?utf-8?B?cytsYWQ1MHdVNGRsdGM0UE8xOURINnFLYlUwMkNEeGJBWGgyNVh5M3Bka2xX?=
 =?utf-8?B?eUxwZ01aOWc2aCtNdFpIZEs4cTcxYkgwVjlBMVV5Tm9ubWRQcnhCNVoxcFdS?=
 =?utf-8?B?ZWx1QzFiUUhqSVhLWHJCbjN6YjhWWDhTbmozeHEySFFET0lXd2dkL205Smdq?=
 =?utf-8?B?dDVzTGxTMzhNTisrZndKS3ZuYlVaT2dYcGpLanRJWTdsQTZYbWlsWS9odVN2?=
 =?utf-8?B?QWxvZFFpSGUyYXl1cC9RcHRYYmF6RTRuYzFJTVpreEI0VGxNSHBUVVB6eHVz?=
 =?utf-8?B?YzZiQ1V0azU1S0F6TUU1b1dpdDFJWW9TbjVEc0xBL0VHNVdUcDBMWnBRSE5k?=
 =?utf-8?B?YXBpcWNLeXM0OFd2NHVrV1hLQnZEN0xiSWFCT3BKKzhRR1dmYm13bDNjRHBp?=
 =?utf-8?B?T3V0R0E3MHNocFB3ZUcxckZzN0lXdk8xZDdKZFlWY3VITThOVlZ1a3FCbzRW?=
 =?utf-8?B?cDFKMnZrcnRQaFlEa2lTdmxUNVZwcmNPZnp1bE5pMng4SWJMelltR245cU5C?=
 =?utf-8?B?NGd5QW9ram5NRkF6TWphbExtdFJnZXdiUnY2Nmp4MGM0SnhEU29Vb2NBaS9Q?=
 =?utf-8?B?Mnd5czBLRXUwYzJ2cDlOUlpBS1JzRzRCeG96R090Sy90OFNnd2tpZkUwemtz?=
 =?utf-8?B?YXFIb3dVbGx4andEaDFsK2RXWmFESzNXbUwrTXVPcy9PTnZ4VFdkeXJpVUNU?=
 =?utf-8?B?RVpIdnNqcWV1VG5TVjMxOS9DaXBOOFVRSlZBYmlFR1NkSDhZNkl3UGFGcUJ0?=
 =?utf-8?B?MlNZNjA1Q0lLL1d0K2RTSmZyVENxa3pXODVsUitwTnRWMDlxam00cXhsekxW?=
 =?utf-8?B?NzAzbFhNc3p3YlNEV1FRNDRHNHRPeFlSc2ZkY3pMNnNuY09pMURUVGh5TGJ1?=
 =?utf-8?B?c1U1WE85b3JLVmpINS84STVieDhTMjZtZlg3YlJFOWV0SC9kdXB4SlRpcWxv?=
 =?utf-8?B?eDN3eHZPRHFPenU3OGRZTzJ2QWpFU04zdHQxQVNnNkpRRlkzRGp4RDR0am1m?=
 =?utf-8?B?L2FvRjB3UWw2bkVncTA5eE5MbnQ3THRPNU54cnc5aExBMjlvTFBXVXJWUmgx?=
 =?utf-8?B?Q0lQVjAvZXpha3M5YVdjQk54NFV0SFJ2VDljNE1Hbi9SamVmQ3pSTmxSMGhk?=
 =?utf-8?B?R01mSFlFVEFjWjFIdjVTbUF5M3lXR1o5bEZySDRkd09ENTVtMUdDTVMvUWVm?=
 =?utf-8?B?VnhrM01HSk1XZWNtRFFZZGpNeGlmOU1rOW8vanBYZFlzUmpNVGhGM3ZtcC9J?=
 =?utf-8?B?RTM5eGlSajJPMnY4Vi9qNDAxUlpmMFdnMjQrWTl0eXM0cmo5WDhKMjR3cXN4?=
 =?utf-8?B?dnJQcVhJK1JwK1h2dnJVb2wvQlZ6VnhHaytjK3hrZzBzamxRQ0k1b0FzTkFH?=
 =?utf-8?B?QTRLWWlaWTZNOENnaGZSRWhTS3Y2SzRWQXBkQmNqN2pHUWhHd2VPTjR4azQy?=
 =?utf-8?B?WW5iUThtT1N1c1RhTDlOTS9NNW9YbW53ekJBclVkT2oyQlBUaXlObFNNRU4z?=
 =?utf-8?B?elNPTWFZQzg3ZUtTWnFEYkVNV0VyUExnaXpkcnQwLzBzVXVydUk1cWJ6bFNZ?=
 =?utf-8?B?dVozY21KSDEwOGYxNVRpZ0lqRnRtTjlsTjcyOUlBVHR2MEIzRVhjOENYdGVa?=
 =?utf-8?B?WWlUZFV6RkMwMEZOS1pBam1PVzdrRWxWclhnZGs2dFVNOVF3bExhZDZPMkt5?=
 =?utf-8?B?dVAzYXZNTTVsNUdEN285MFlBd2hBSmtlZGZpOEt1cmxOdUtJVm1EUHRWY3pI?=
 =?utf-8?B?bWNMOVN0Tm83ZEY2RStNQnRUckhaemwwN1hUQ00vN2FiNmx5aUlSK2pDd0tZ?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5c7e56-5775-425c-a9f7-08dc60ee1f85
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 03:58:22.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/bAwWOrUyHNWTvqxF+37j5o/SfT0ohRjxJugdcbjdJfzvlqwttnJGzBO6fTv8YBv8REjJOSn9F8ySPNaKgREIhftKYG4TuUG0vYzpChENU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com

Hi Dave,

On 4/18/2024 8:21 AM, Dave Martin wrote:
> On Wed, Apr 17, 2024 at 10:12:35PM -0700, Reinette Chatre wrote:
>> On 4/16/2024 9:16 AM, Dave Martin wrote:
>>> On Mon, Apr 15, 2024 at 10:47:55AM -0700, Reinette Chatre wrote:
>>>> On 4/12/2024 9:12 AM, Dave Martin wrote:
>>>>> On Mon, Apr 08, 2024 at 08:16:08PM -0700, Reinette Chatre wrote:
>>>>>> On 3/21/2024 9:50 AM, James Morse wrote:
..


> <aside>
> 
> Although probably out of scope for this series, I wonder whether these
> two paths can be combined?
> 
> update_task_closid_rmid() selects the cross_call target by task, where
> update_closid_rmid() selects the cross_call target(s) by cpu.  But the
> backend work that the arch code needs to do seems basically the same:
> possibly update the the CPU default group membership, the reconfigure
> the MSRs for the running task to ensure that they aren't stale (with a
> possible optimisation not to bother if we sure that the MSRs are not
> stale for the task actually running, or if we know they wouldn't be
> changed by the write).
> 
> Even the check to see whether the right task is running seems somewhat
> redundant: we already paid the cost of taking the IPI, and we have to
> cope with spurious, idempotent updates to the MSRs anyway since this is
> all racy.
> 
> Is there a high overhead to writing the MSRs on x86?

The MSRs do not all have the same overhead. MSR_IA32_PQR_ASSOC is intended to
be updated quickly but it is not free and I'd prefer to keep avoiding
unnecessary updates where possible.

> 
> For arm64, the relevant system register only affects EL0 (i.e.,
> userspace) execution, so we defer synchronisation of a whole bunch of
> stuff until the return to userspace.
> 
> </aside>
> 
> 
>>
>>>
>>>>
>>>> ..
>>>>
>>>>>>> + * struct resctrl_cpu_sync, or NULL.
>>>>>>> + */
>>>>>>
>>>>>> Updating the CPU's defaults is not the primary goal of this function and because
>>>>>> of that I do not think this should be the focus with the main goal (updating
>>>>>> RMID and CLOSID on CPU) ignored. Specifically, this function only updates
>>>>>> the defaults if *info is set but it _always_ ensures CPU is running with
>>>>>> appropriate CLOSID/RMID (which may or may not be from a CPU default).
>>>>>>
>>>>>> I think resctrl_arch_sync_cpu_closid_rmid() may be more appropriate
>>>>>> and the comment needs to elaborate what the function does.
>>>>>>
>>>>>>> +void resctrl_arch_sync_cpu_defaults(void *info);
>>>>>
>>>>> That seems reasonable, and follows the original naming and what the
>>>>> code does:
>>>>>
>>>>> What about:
>>>>>
>>>>> /**
>>>>>  * resctrl_arch_sync_cpu_defaults() - Refresh the CPU's CLOSID and RMID.
>>>>>  *				      Call via IPI.
>>>>
>>>> Did you intend to change function name?
>>>
>>> Er, yes, I meant to use your suggestion here, so:
>>> resctrl_arch_sync_cpu_closid_rmid().
>>>
>>
>> I'm a bit confused here when comparing with your response in [1] mentioning
>> a change to another name. 
>>
>> [1] https://lore.kernel.org/lkml/Zh6kgs1%2fbji1P1Hl@e133380.arm.com/
> 
> My bad (sorry Babu!).
> 
> I read that suggestion carelessly and assumed it was aligned with
> Reinette's.
> 
> The most important thing seems to be to transfer the "defaults" from the
> name of the function to the name of the struct, since the struct is
> about defaults (and only about defaults), while the function is about
> defaults and the running task.
> 
> To avoid extra busy-work, I'll stick with
> resctrl_arch_sync_cpu_closid_rmid() for now, but I don't mind changing
> it if people prefer.

resctrl_arch_sync_cpu_closid_rmid() sounds good to me.

Reinette

