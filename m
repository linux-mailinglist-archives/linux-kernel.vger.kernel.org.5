Return-Path: <linux-kernel+bounces-142415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4A08A2B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFEC21F217B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69C150A87;
	Fri, 12 Apr 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGZpX3q1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AD502B2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914275; cv=fail; b=PzHxc3v3faNcg1lG9sYZI5FCz/Gd6xcGXtk32FtMbzIrt85c+Hj3EktQSQNRoqiWHGQklIHflpBaFEFkVJiVUZfmIODZWXy90JovONsZ4z0wKb0Q36OCwSZnMEltbIT8eBMDy0ieLnAXtmDZDXCyoPu90sH4q21y2u6kMzeaoiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914275; c=relaxed/simple;
	bh=oMOx7QehY4MzhnJK+ufZIKrMrDDPxbMazOvA45XO1LQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A/s1OBkPe2kuqMnc4JGARowka/5Ih+C3KnOxpzMyf4+qOgCxeNxZvNZ8xiullwxu9WQj5Afux3Us18SdL0ffChxq3grIMDJd/8Ni/ONxNKrrmWuZbr2ncwZIrWzZ1X9nO2xiEDC21UHcQnuGOdUWwXmWPuF4JHjVU4CcsLcGlJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGZpX3q1; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712914273; x=1744450273;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oMOx7QehY4MzhnJK+ufZIKrMrDDPxbMazOvA45XO1LQ=;
  b=iGZpX3q1oscC8/xXYQpVeLYtbH1Ft6CLQ6w2z9pCaJNUPoRCAj8YUaDz
   FruPNcZPd7dW4OcIfKVuBKzgUxZ6MmX+zqRY3+gIIexCcZ9NV+g5VTsdE
   EfF9DPBZNp/JHGFKU3ORpsZP5u9RhMc98PLXfEF0q3RmadYpTBG/KrN7T
   3iTCLAahNNmDRReEYiUWazHCcbyFDUBtMv4gtgtZrR/CKrIuDoRHF1PO0
   wCt/5TGKfxi5BfXkif0eweyQ7K88Tz2NiDRZ1B68zsYtgq19gNXiAc+LE
   v0Soub7tPzKc4rIdrcJL7+Tg6MmL9SnHdLtlDOarmwigXtQu00OXEvku6
   g==;
X-CSE-ConnectionGUID: FQY5S9xZS6i8kxsC1lJpMA==
X-CSE-MsgGUID: cA6SKc5uSo2I/6rzESFPkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18971318"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="18971318"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 02:31:13 -0700
X-CSE-ConnectionGUID: NgMr861vQkSvf2ZJr6WoOQ==
X-CSE-MsgGUID: KJTYeAC9Q6qqnh4WkAtnaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21269108"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 02:31:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 02:31:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 02:31:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 02:31:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 02:31:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faV+E89BPZA7TMf1M5x/uLbz7LX/6fTS6u5M/rR2YeGWg3fDYuLAeeyLZNgrSv7E1DI7YrADHWVpMh10Lxgci3N6WBoGuIjseFCy0x2wwv8t7UOyg5MOOirF+qAuMY+mzkQjRdqjng3MeVv+wdxyEWlyFyQI0nIFO66/Z2lXKKpBKdTwJ80o392IZpEolSjTGpH3h0RH4LlABZoKe/XmQQdhc3LD2cKMLgKk/M7UL4Lq7F0kdTPdYCQnFb4JOM5uUZ5Dw/ZxHXqxBkQHLzcdHoCWkWX0H4iHoswFdKVX19cPqD0wmJEgainVUT6zSL1rNECYUd8sEwqr+zI7D7R3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9vfMFwuzZ0SdA1pyZ1yncDrjy4YUnwV4pthsxM0VD8=;
 b=Ec8qQdcJWDsslWuprqkVeqMuDHSvEbvwzHpEtuuJFdA4yyHH2SLqup5q8x+3BAvv3hi+v6J7mDP1SagUC5SeZ3513yIBWSIMk7Q7O/G7ystTaAs47TX+IsMXEMLw97w9I5aEKKQkB8GpD5OHlyir581a4V2pquPW0oH0jvjmxb/t83PslP3ZscWhiHtfucdFTG0r313+wDGyb1Ote/6DvgI8wZWhOdkerRi+LQ6nLK/+xc8kEEHnUMKZ0o2VEfbcgKgKZGHfip9F7Rs31qzQUv0WBDIpP+aun83LLUHNABy+FdhApTmUTIF5PBgboRKT2C8c6ZBsPPDoCTFUN+R0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB6398.namprd11.prod.outlook.com (2603:10b6:8:c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.21; Fri, 12 Apr 2024 09:31:09 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.7430.045; Fri, 12 Apr 2024
 09:31:09 +0000
Message-ID: <5e17af59-e544-4c5e-a718-2cd77b8a07a4@intel.com>
Date: Fri, 12 Apr 2024 17:34:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
CC: Kevin Tian <kevin.tian@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
References: <20240410055823.264501-1-baolu.lu@linux.intel.com>
 <7e78917f-f84c-4e98-a612-73b8013ae367@intel.com>
 <0231631b-44ca-45ee-adf9-0a5c8852cc27@linux.intel.com>
 <be0b254d-d6c0-4a94-8234-936f40538bbc@intel.com>
 <776ef2f1-747d-46f0-94be-747c6fca8ce0@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <776ef2f1-747d-46f0-94be-747c6fca8ce0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:4:90::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: dc71aa0e-765f-45e0-3205-08dc5ad3492d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPuWVKKLZgLNCuyWE7BsyhUt43cF/pz+9cu73mO5JQAuPF+Ndzo/ZhvR7KuKXv+p0Ns7p6RVfsjY6AxzFQY3YWE4Zz/HK459bOfLVxyqsO1Urgoui6ftQrsinaJ0sI0ledIrIDC3gs+MQ6ZLnqLABYkXxmd6yBaRPS2gPHfwoGJ92z1zIO5A8zmJcXFX1gA2GFc8463t8M2xkkqfQXi42uKSAlOME4q/9K5iuq0js0DPYvK41u3KEZuXnT6+XhlH9KqfLJ38jUchaD6ofvkd8MRBKuC+EMRMjcLD3UISIq4YeXJj+Z1OOPmYfnsHYftL3ZHzzKGWinnuVFozqphqF9UmjPfU6EXw9AiA07kl7gKeYBr418ErTG5IY69Q6kSZHfOKvwMnpNPYKKm10i/vXxrjRW0zGeg3jgjXayVEEjeYmyTgYjYbCL97CFnCw/5YlDV1FcE9BSzfhg+AKWYHui2CinePnJ63CmzRMq/d002xWG0iS75s+WosK+AckLiSTkf+aHLGTFHCYqD9kr0J/LTGH1i4kagN4VvcJ0UBCo01yk3cTBkBiYwz3U4nZlFAzdhYVBilRVbu4iQ+MPjkit2KmC+fyYcoGI8TjW+9CN/u+c/jZJNw5O8WQzANCVSlyS08rySk6Wma0trHDuiUF9rwIVh5ElwpnFUKnDrZRj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MytVVnZWKzZGaDVPQ0NDS2l5ak95U1prUDRMVzdzU0ZOTXJkb3lwTDROU2M0?=
 =?utf-8?B?N1hybm9SZHlSajdrdU5OemdhR3pFYXRySHdLbGxTUU9RTmZycWwyV2RMZG5H?=
 =?utf-8?B?UEt0T0xEaDQ3OE1RU1dRU3owenROMERKSFBzTTVLeHFUdVlKY3lWaWUvQk9K?=
 =?utf-8?B?T1NmZG0zYmQ2KzVIMWJtWFRTS0NldUkrRmtza0xUZktBeThZbGE1Z1BlQUt1?=
 =?utf-8?B?TzhVZkhGbHlURFJPYUZOUnRScTBHNWd3ZG52S3F1YWVXeVNsbDJzY0w1cjlN?=
 =?utf-8?B?NzU3blAwMmdsQlBKVllrUjN0ZlYySHcyTUhoWXM4WFFpcllPN1NnREd2eW5i?=
 =?utf-8?B?d29pQ3V5L0pYbmV6OW5RWVloTG05VVRjMkJjeGpscW11d3Z1VjlCZUpqZDBo?=
 =?utf-8?B?QnkxMXNqNmpGZVRENGxiYVZ3MVlMMVIwaG43dW9sNnpmL0h2eGkrTHJDYWo2?=
 =?utf-8?B?UmtXcFR0QzZZczhFUm1jVGZJM2RRM1llS3JkZEhtRGVmQUNRNXlRVVVLT2Ny?=
 =?utf-8?B?OExvWEtpakFWUjZDa1dHV0pveXEwMDBXV2lybDhncmwrbXNKWEo0NnB2bGZU?=
 =?utf-8?B?ZW1DMHA3MVM1Wk4rZkpLVVdPVlFTQ3FsVzFXbVpDQnU2MU44WlNWRHVhaW9Y?=
 =?utf-8?B?dDBSTnlvMFhXUUFXQ1FEaUdiNUhWbVIxWkw2dzhmK1pGdlJKQmRzVlQrUmhK?=
 =?utf-8?B?cEw0eFVuWFVhTXdKVFdOa1Y1QmYzMDBMZGs1UlQ5U2RoTDhRVDhtVHVFOWxt?=
 =?utf-8?B?MDUxRk1vZVlRdTZsbzZyeFliYVFBN0FUZUVCRk5zTHQ0T0JPVjEyejNqVUdQ?=
 =?utf-8?B?OXNxQlRHZU5sb3NhV0M3WUo0T09KejlxaUpOdUxCd2RwUmVvdmE5U3dHcGNu?=
 =?utf-8?B?VURLQkJDbTJxNHN4VGdqQTk0aWJZQXp1UVF3alYwVmo0SDY3SmpISTJSVWFr?=
 =?utf-8?B?WXNpaDBtMmcvZkkvVExGLzIrS0U4YTloT0ZxZ3Z0dnJLcWVlbTQveVJiMXlP?=
 =?utf-8?B?dVljUGY5RTVINUorSmRKOVVjM1NtYUJ0WnVYdXdrME5ZcXhZR0VCUUdydldF?=
 =?utf-8?B?aVJzc0QvV1E1cmNWV0JKY0VTanEzdzlyZWVFeGVYcWdkM05UczZXcTZPWFJh?=
 =?utf-8?B?ZTFYdmhTaVdwbHFORFlYaSs3aWtqM2R0c3RBcEJnZENHYTNuTHY2UGNlSlNY?=
 =?utf-8?B?ZUdsU0UvYjkxNFovVTUyamRObVg5MmNmV0ZreW1IQXU3Q2V2WUhOTGhJT0ZM?=
 =?utf-8?B?eENsYWRVaUtBTUx4MjNpT1F1U01kM0JPTDJJc2dXUmY4aHFxbzllKzd3SVZB?=
 =?utf-8?B?NVNrRXowVUdmZ2dkTlJma3ZLNTdvcWllc0FwRUY2b2JySEptYmo5MkJ4akg0?=
 =?utf-8?B?TkdyOUpkd1E2V3FoMFlWZStXUktyQmdOekNsZ0ExYVRRN0wyRHZNSkFDS08w?=
 =?utf-8?B?b2M3bXVJUFN1aVEzWnpBNnV3YThhWlgxY2JZYklnbFByelA1QitBczVXMnAz?=
 =?utf-8?B?a1ZIRU8zNjhtWTZnUHEzWXhqaS9aRW95N1R1ejhYNjhDRmRxSDBrTUV4bldt?=
 =?utf-8?B?b2REb2RUUEJDMGNoM0l5N0FMYW5KV1YzN1lrL09KbUowRUpsU2VRQ0RyU0RK?=
 =?utf-8?B?TkRvQ2tPSzhwZXVEQ3MyNFlsc1VGUjA1WkZWWmpCMHloQXFwYkFmNHFQb0JW?=
 =?utf-8?B?c2tMMXBoa0JPMkJFVmpnVEdrbU1ueFN5TUJFWC9YamMvNS8zc1Jra2hJVndt?=
 =?utf-8?B?b2duUHNwbjBQUDd6aUxHL05wYVJzQUcyUmNZVVozeVpGMlpHb1FVUit3T3NR?=
 =?utf-8?B?UUJWUGZpSzhyUXpiUzZIMzJ6WnF1THNWakYrMnR1WlYwaDV4QndVZXFrcW83?=
 =?utf-8?B?d0tKRlZFemlUekJoTFVPbXhrQWdoN3pWQ2tBWDhzektTeHpUQitCZkZ4UHRH?=
 =?utf-8?B?L2JMRHlGWUNQRHpoYkVjdS96UVBvY3JRbXpXeDB1UFRNK1RsS1Y0bjJhRVEr?=
 =?utf-8?B?NHpscFlPdWhpN1l5dXBZekZYaEdrUzBlcTlraFdMdEJNUkRQTHY3QkVLbzNk?=
 =?utf-8?B?NkUveVJmZ3BaWEZCRWhMMEFBQitGeFhNbzFEMGpTQTVXaThxajRUanNNWnJn?=
 =?utf-8?Q?prB2cgKgPrnaCGUzMbr2Gxxyg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc71aa0e-765f-45e0-3205-08dc5ad3492d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 09:31:09.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEYtSuA6qqxZfEWSHiro+d+79nX+fQzJvSCfhfs3aZWZ2hQhWA/TAXRaSCOd/ice8okkY4c8dj2wVFGmtPZUYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6398
X-OriginatorOrg: intel.com

On 2024/4/10 18:38, Baolu Lu wrote:
> On 2024/4/10 17:14, Yi Liu wrote:
>>
>>
>> On 2024/4/10 16:02, Baolu Lu wrote:
>>> On 2024/4/10 14:30, Yi Liu wrote:
>>>> On 2024/4/10 13:58, Lu Baolu wrote:
>>>>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>>>>> implementation caches not-present or erroneous translation-structure
>>>>> entries except the first-stage translation. The caching mode is
>>>>> irrelevant to the device TLB , therefore there is no need to check
>>>>> it before a device TLB invalidation operation.
>>>>>
>>>>> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
>>>>> mode check before device TLB invalidation will cause device TLB
>>>>> invalidation always issued if IOMMU is not running in caching mode.
>>>>> This is wrong and causes unnecessary performance overhead.
>>>>
>>>> I don't think the original code is wrong. As I replied before, if CM==0,
>>>> the iommu_flush_iotlb_psi() is only called in unmap path, in which the
>>>> @map is false. [1] The reason to make the change is to make the logic
>>>> simpler. 🙂
>>>
>>> Oh, I see. There is a magic
>>>
>>>          if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
>>>                  iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
>>>
>>> in __mapping_notify_one().
>>>
>>> So if it's caching mode, then
>>>
>>>   - iommu_flush_iotlb_psi() will be called with @map=1 from
>>>     __mapping_notify_one(), "!cap_caching_mode(iommu->cap) || !map" is
>>>     not true, and device TLB is not invalidated.
>>>   - iommu_flush_iotlb_psi() will also be called with @map=0 from
>>>     intel_iommu_tlb_sync(), device TLB is issued there.
>>>
>>> That's the expected behavior for caching mode.
>>>
>>> If it's not the caching mode, then
>>>
>>>   - iommu_flush_iotlb_psi() will be called with @map=0 from
>>>     intel_iommu_tlb_sync(), device TLB is issued there.
>>>
>>> That's also the expected behavior.
>>>
>>> So the existing code is correct but obscure and difficult to understand,
>>> right? If so, we should make this patch as a cleanup rather than a fix.
>>
>> aha, yes. As the below table, iommu_flush_iotlb_psi() does flush device TLB
>> as expected. But there is a NA case. When CM==0, it should not be possible
>> to call iommu_flush_iotlb_psi() with @map==1 as cache invalidation is not
>> required when CM==0. So the existing code logic is really confusing,
>> checking @map is enough and clearer. Since the old code works, so perhaps
>> no fix tag is needed. :)
>>
>> +----+------+-----------+------------+
>> |  \       |            |            |
>> |   \ @map |            |            |
>> | CM \     |      0     |     1      |
>> |     \    |            |            |
>> +------+---+------------+------------+
>> |          |            |            |
>> |     0    |      Y     |     NA     |
>> +----------+------------+------------+
>> |          |            |            |
>> |     1    |      Y     |     N      |
>> +----------+------------+------------+
>>
>> Y means flush dev-TLB please
>> N means no need to flush dev-TLB
>> NA means not applied
> 
> Yes. We have the same understanding now. :-)

yeah, would be helpful to refine the commit message w.r.t. this change.

>>
>> BTW. I think it is better to have the below change in a separate patch.
>> The below change does fix a improper dev-TLB flushing behavior. Also
>> how about Kevin's concern in the end of [1]. I didn't see your respond
>> about it.
> 
> I had an offline discussion with him and I included the conclusion in
> the commit message of this patch.

ok. So the key reason is that intel_flush_iotlb_all() is not called at
all if CM==1 after that commit. So there is nothing fixed by this change.
right? This just makes the logic cleaner. Perhaps no need for a fix tag.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

-- 
Regards,
Yi Liu

