Return-Path: <linux-kernel+bounces-141692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0D28A220B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF868B21421
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7547A70;
	Thu, 11 Apr 2024 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtQecsta"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003217548;
	Thu, 11 Apr 2024 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876573; cv=fail; b=d+TVr5zZmGh19mU54LWLKdUP2YcNgdRw2oAzT9rwAJCF1KA4RB7qCwcO24ioN+5OMxdR1Plqf0wrS7DhoR4qZqj0RVxPR0mZKowG0wo3SUkwAw6Sumc84/5yRcUbr+W7LwRdGL4UCJ6H1RtkhPeON04K9whs6k0zBSLn3t7m51M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876573; c=relaxed/simple;
	bh=Bb8bCj5AT5dxh5Ekw1SFFW6EE24jkqp//KSK4Q7uqP4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oeADC1uaUAB5XIyWwfNQawLJYOJVDYl3qkpcujT6T26Z4pdDhTsHD+INVDY4eYtvo9drQ0FvzcO/kbRJODlSjby8Ykwe/sDKieMWx9KkRYNGQayHTffbAg8O0eAIGmKtNQQkWm94SS41BVC+JHB4G86/Uib9CKOecn+3rbO1Ckk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtQecsta; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712876571; x=1744412571;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bb8bCj5AT5dxh5Ekw1SFFW6EE24jkqp//KSK4Q7uqP4=;
  b=LtQecsta5NdZ0dYKqEVt3oATQKeSxoY2A+NVmyqfi0FNGCdozSZSTXXx
   fVVqPCUKG1OOhejUF/Zxkv1ZiKADqpMRWxLOL998e1hMDuAjKO9ljXyi1
   2kSPjpTFV5VO+vjw1KI37kfosOxakLvpLyDcQLKAetF5+HigMU5GBOjRY
   Zjy0Q+BZ/2nWGdmtkE0ts3zF0Buesa4CT42zjHj/OMQcfFau4fnhO0Gpp
   EZKxwMJV+onKSoQYflyX2CgXnSceuCea5gXii2fyKJRT2a5Sdhu0pKMm+
   /kMVn8/YkegTWSO3FN5KJrq6AdZk+TNhltGyZCPLsZCJOcIpxaRVs2Wtx
   A==;
X-CSE-ConnectionGUID: haYHUii2SOyNPRbQyS4ADg==
X-CSE-MsgGUID: Tue8vYQGTLOV0KLhi/lajg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19471393"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="19471393"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 16:02:51 -0700
X-CSE-ConnectionGUID: zyJou1y9SwO65vCWcqYQsQ==
X-CSE-MsgGUID: eG34ZKRdRAylnUkwVqmYyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="52016620"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 16:02:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 16:02:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 16:02:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 16:02:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN6sclF5vouiRSRjShVimD9rfz/Us4Rbd7dz0IFtIpAIQoy28R8yOXI1CnQtklD+uxUcknJf/e+DsvDKIgi+zFo/PgTGjU/uBKLOTJFCSpgK6spLwUirRYIw4J4bEqmQKg2LC7MQqygMaCWUrjnicT757G7fw4eaok0ucwuCKZIemUKghhb7FarcU41gRzTAMOulH7toQWcNLJSWpyyG4WY9ijzK7YxGUGe8zyNCFP4xqh5z6XNYWV8mTHyVYSu1oh/5v5IHZRi1O8KlCzfFQUnVZE6zP98+R+6ha32lbVN98QtWcdhhOEjw+frDwRt4d0VeNJv0ICr3pUiocYQ0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJbUwQHapJT+PNZLsUIOeydKxC9gH/ytVnLuYm2i4Rc=;
 b=Y8T1c1DKWUvOEIH01wsv4EYaS+8jN+nNHpe34HA3c/SEjs8cLYDbc+4Z8fnXvS0qd3MArQMfQMzNkYzKy3QmIojfgey0jEU8/KMNoFthw6+hv3VYmIRNhY4uYEZcHb0h3xypFBlVq1U6gLXdWbGtQ0OSdT8wY03FM8O3wGUCnC/MBWKV3xFiiN+tkk7/I88LKTHGA1mgr4RbS6xDgyzuPQAX8950GdtIJeVKz5FLwzFyVhJowofb2h8PVSFUJKKS5pzSk+2YmM3Rhk7FLmk5xjPCJewLrMymtr7183Oi50p6yasyxhLqZQc6dAmY5DBdwMyD5r1Q9Evwcc/7oJWbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM4PR11MB7400.namprd11.prod.outlook.com (2603:10b6:8:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Thu, 11 Apr
 2024 23:02:41 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 23:02:41 +0000
Message-ID: <f6a3f010-8fb5-4494-9ef0-23501ea01f64@intel.com>
Date: Thu, 11 Apr 2024 16:02:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [intel-next 1/2] net/i40e: link NAPI instances to queues and IRQs
To: Joe Damato <jdamato@fastly.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <sridhar.samudrala@intel.com>,
	<nalramli@fastly.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
References: <20240410043936.206169-1-jdamato@fastly.com>
 <20240410043936.206169-2-jdamato@fastly.com>
 <bb0fbd29-c098-4a62-9217-c9fd1a450250@intel.com>
 <ZhckCOFplMR0GMjr@LQ3V64L9R2>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <ZhckCOFplMR0GMjr@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:303:85::10) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM4PR11MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: e35eb561-6c1d-4c91-f4fe-08dc5a7b7d7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epNwY9OvChhSoD6HScuq90V/nFyGMp5sregRwbpBTyOfCm81Iqi4eYQAgaLHFr8zKnSgzLzdUezQRBVew57sXWEhsIZ7PF3a4vmvXcjcFbSl6g5PdYnBV0/to8VQ0/Ost1r0HzHpekg10pF8At/FZBM+RNvWrOrXWjGuhIHmNGXPkyQUGI2kBnCh/UFcABRgWjvs86RfqecvLGEAiANf98lTNZFW3iBwMrfiUgLy+3HbAMcKfEOAJVhkKCojB18CBWRZlbdf77OpzJ0mMmncViTQ3UyrJvoiaHuquXOKk7UTSkWZnz86WDdkJNxh0pezJ1fQG/qm8Kff7iksTRxpDuQWwk9rcVjaTL651LlhP9GB4QWr4IFnT5IyPCf8EzaWQQH4QQ4es//CQZIGsV7h2IlT4mFp4wXzRqiTMfMSVrQ9U5lRT/DBMX12wkAzLtqYd7P5Tshx60yQZYrZAJSMOCx0TIroOliE1O4sqeWQIdg3NR+ZNLoAkQbzVrmLw7D8qZc0476Ee+MYRkvnUkbdfbuqg9gniLkbGTIgPrAZGpR44U6SS+YMAFROWJgVD1i20cjATC82vX0mp9xpLcSflTwx0cNxepBRx/6rN5n/E03ybeEJBrRiWivUh4r/fnzw9qXZOFCtmljVul6XnfS/OBt/2OEFkEm7faJRmT2GR+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXJPWUpDRUJoSTVtTVBuLy9jNkhDSVUyY3VnSWZJOHdESE5LaFRFVXdQSkFa?=
 =?utf-8?B?MFRjQy9jQlVvNXE4OVNtczlQd1JnRHVvYmJXWjMrOFhxK1d0Wk1sSFkvOFNE?=
 =?utf-8?B?NXhFUnNXaktEbGhnbC9SSFZXOEZ4MkNNc0JUbFBVSWZIM1RaR0libHRLNmRi?=
 =?utf-8?B?dUVaV0xRZHNGYWx0U29vakpQWjRCMmFhK0lsaHd4VktsR2pDWnNyWGI1RGFs?=
 =?utf-8?B?T0NLaXRqNVNFWGkvZ1hBd29SUlptWnMvTUFJWTBZaHlYOHhlRjdxRy8zd2VF?=
 =?utf-8?B?Uk9CMnNGOGRsQkdwVXBPL2VMMHBmRXA3VEpraGFzdVJKUlRCckQzWVR6dmV6?=
 =?utf-8?B?V2FtLy9CZG9ENTFEeCt1V250OFRFV2ExWEhBaVBlT1YydEdISi9NaDg0TXhM?=
 =?utf-8?B?VjFWTVh4aUJlMnl6VmtMQkVwY0xnTzBvM1ZUMnJGUTVuR3NpSVpySTUyQzk4?=
 =?utf-8?B?K2Q0T3IwVmRjTlFkM2dsUHlXVjJscXdNVjRtL3BhZDBVditUenMzVFZIZkNV?=
 =?utf-8?B?a2ZuYVRJSmt4bWhCMGpDQWttSmZQMVdOdFNmV09kTUlMakxuNU92a1Jqd2k0?=
 =?utf-8?B?a1dnTEUzbElBTjZ5TGkzNFdldUg0WXM4Wk5pMkpiMGo0RE9NYW1LRE5SN21F?=
 =?utf-8?B?OWNZZHVlSWN2MEtsUVhDbGhtN2NiUkdjRlZWdzdQTmxTSGlMR1lQSGtJK0xV?=
 =?utf-8?B?a0JiRVI1NGRmQnY4YWpsNlN6SDdnQWhYaGpkNStrYjY2aDNhSXAyTDNUdmJh?=
 =?utf-8?B?UEJyRGZEaUI3aFV1bXlwamRVOHAzSnNncmU5VUpwVHViUUsyZklGaFFDbU5u?=
 =?utf-8?B?VHBKYmF3THlFNU9kUDhOWGt0bytSZXdoUjl1U3RISngwWHFZaWhldU92MmJm?=
 =?utf-8?B?a21TMFExVmI5TnZFKzN3Snhrbklvd2t0UFRNRXl3WDJ2c1cwTTZNTlFCK0dP?=
 =?utf-8?B?bUU0czY5Vkk4K0VpNXF0a04vL1hGb2Q2cUo0amkwN1FaR1RzNXlsZWhUcjhD?=
 =?utf-8?B?QUhvSUlsMEIrUHN0em1YZ1pZL3pGZ0JNeG5DcGphSHd1dVY5US9nS2tsdFpW?=
 =?utf-8?B?SXFmaERZN1p2M3RTVWp1Z0Z0NzR3WSt4aWhXWHpiQldsZ2FaREh1MnBmbHZQ?=
 =?utf-8?B?OUlTNElZTGFEMVlycXFFOWlOMkZ4QmFTb01ub3o3dmd3ekRpS3U4SWQ0UTUx?=
 =?utf-8?B?ODhCalFpWUtiemNtcHVYSlB2czArOVB0RWhFYnhPblJYQmlxMmZQaG5SN09B?=
 =?utf-8?B?OFk1UStxSlBDNHQ3Qzd3WGY5UnZub2xKVk5yeU5wR0R4SVJZaGM4Z0hLL1B1?=
 =?utf-8?B?cmZoWndjVGw0eitEUlBkNjl2MTBYRFFXZzM2MXNybzczVWF2UlFyN0pObjFB?=
 =?utf-8?B?ZnpQUGJxVXlmVDJrcWQwdDI1aHVwZUZSRHV0YlVJQ29sb0dYbHRVUG5iZ3VU?=
 =?utf-8?B?ak5BYnFFR0crNkdVVkt2ZE8wdXl2bEF5OHRrUlNhc3NoK1YrczNyTGYzaTBn?=
 =?utf-8?B?WnlKUWc3TEJaajBFNWFGeFlvZW96WElSdG8vNWt1ZThOWlA2VlZXN0VZSmxm?=
 =?utf-8?B?dGZ4ZDcwU0J6Vy9ubG5hMyt2MzJtWHJtZWFnTi9lY2w3dlJFUG1IMjZmeU9V?=
 =?utf-8?B?K1lialRuN1VRMHgxSnlYemtLMXVYL0FLVFF6MDg2SkNKK2gzNktwUzhuVFAy?=
 =?utf-8?B?QklKVXZIaHdaT0MwY0twNTgwMlI2WkJSWU9lMnFlcGJucTZZbEk5eFYxSUda?=
 =?utf-8?B?eVF1Y3dkYzNUZ1hYWTVIdys0cjRMWXZnMTNVVjh2RDhmSldJTWNDd1FvbHhk?=
 =?utf-8?B?T21uUmNzdGw3NFYvVFpYMm9MbnJxbDNlbE5oWURBdEQvZnlIemkxSDNpSHFX?=
 =?utf-8?B?SnNQVUx1eXVFL2NHSUQ4dzd4VytLeEVCd1N3eVorWjQ1OGVrcm0zTUFIUlk4?=
 =?utf-8?B?c0cyb0I0akVSNlEzVFBjM3FObDNKcUZEUUxOSE1WQlBCQ2c4enhRTEVpMjM5?=
 =?utf-8?B?SGZjNElHdXpPZjhQWjd0b1ozK2NqNlQ2cHcxWlZDeEZtUEovZlNCbGZBWkk2?=
 =?utf-8?B?L3hGbFFMbHNQdHN6NlAvK2pOb1duaGtMaDdSUVRwcC9ybWYzZWxJMHJxbTU3?=
 =?utf-8?B?K1BOWmhVZTZYRVg0ck9Oejl0enpkYTF6OVR1UVNrVHlWMnFwY2h1bWo3Q1Fs?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e35eb561-6c1d-4c91-f4fe-08dc5a7b7d7e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 23:02:41.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuF3feeG8S1dxNWQA9X9xTcm+q8xd1zBL0DgTMegBNMN5Kgt4h1NvEfwA298HEZDL3AO10cq3CFa0CAQUh/ke4zDy3riojtaSrHVsa3DZ7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7400
X-OriginatorOrg: intel.com

On 4/10/2024 4:43 PM, Joe Damato wrote:
> On Wed, Apr 10, 2024 at 02:10:52AM -0700, Nambiar, Amritha wrote:
>> On 4/9/2024 9:39 PM, Joe Damato wrote:
>>> Make i40e compatible with the newly added netlink queue GET APIs.
>>>
>>> $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>>>     --do queue-get --json '{"ifindex": 3, "id": 1, "type": "rx"}'
>>>
>>> {'id': 1, 'ifindex': 3, 'napi-id': 162, 'type': 'rx'}
>>>
>>> $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>>>     --do napi-get --json '{"id": 162}'
>>>
>>> {'id': 162, 'ifindex': 3, 'irq': 136}
>>>
>>> The above output suggests that irq 136 was allocated for queue 1, which has
>>> a NAPI ID of 162.
>>>
>>> To double check this is correct, the IRQ to queue mapping can be verified
>>> by checking /proc/interrupts:
>>>
>>> $ cat /proc/interrupts  | grep 136\: | \
>>>     awk '{print "irq: " $1 " name " $76}'
>>>
>>> irq: 136: name i40e-vlan300-TxRx-1
>>>
>>> Suggests that queue 1 has IRQ 136, as expected.
>>>
>>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>>> ---
>>>    drivers/net/ethernet/intel/i40e/i40e.h      |  2 +
>>>    drivers/net/ethernet/intel/i40e/i40e_main.c | 58 +++++++++++++++++++++
>>>    drivers/net/ethernet/intel/i40e/i40e_txrx.c |  4 ++
>>>    3 files changed, 64 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>>> index 2fbabcdb5bb5..5900ed5c7170 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>>> @@ -1267,6 +1267,8 @@ int i40e_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
>>>    int i40e_open(struct net_device *netdev);
>>>    int i40e_close(struct net_device *netdev);
>>>    int i40e_vsi_open(struct i40e_vsi *vsi);
>>> +void i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
>>> +			 enum netdev_queue_type type, struct napi_struct *napi);
>>>    void i40e_vlan_stripping_disable(struct i40e_vsi *vsi);
>>>    int i40e_add_vlan_all_mac(struct i40e_vsi *vsi, s16 vid);
>>>    int i40e_vsi_add_vlan(struct i40e_vsi *vsi, u16 vid);
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> index 0bdcdea0be3e..6384a0c73a05 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> @@ -3448,6 +3448,58 @@ static struct xsk_buff_pool *i40e_xsk_pool(struct i40e_ring *ring)
>>>    	return xsk_get_pool_from_qid(ring->vsi->netdev, qid);
>>>    }
>>> +/**
>>> + * __i40e_queue_set_napi - Set the napi instance for the queue
>>> + * @dev: device to which NAPI and queue belong
>>> + * @queue_index: Index of queue
>>> + * @type: queue type as RX or TX
>>> + * @napi: NAPI context
>>> + * @locked: is the rtnl_lock already held
>>> + *
>>> + * Set the napi instance for the queue. Caller indicates the lock status.
>>> + */
>>> +static void
>>> +__i40e_queue_set_napi(struct net_device *dev, unsigned int queue_index,
>>> +		      enum netdev_queue_type type, struct napi_struct *napi,
>>> +		      bool locked)
>>> +{
>>> +	if (!locked)
>>> +		rtnl_lock();
>>> +	netif_queue_set_napi(dev, queue_index, type, napi);
>>> +	if (!locked)
>>> +		rtnl_unlock();
>>> +}
>>> +
>>> +/**
>>> + * i40e_queue_set_napi - Set the napi instance for the queue
>>> + * @vsi: VSI being configured
>>> + * @queue_index: Index of queue
>>> + * @type: queue type as RX or TX
>>> + * @napi: NAPI context
>>> + *
>>> + * Set the napi instance for the queue. The rtnl lock state is derived from the
>>> + * execution path.
>>> + */
>>> +void
>>> +i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
>>> +		    enum netdev_queue_type type, struct napi_struct *napi)
>>> +{
>>> +	struct i40e_pf *pf = vsi->back;
>>> +
>>> +	if (!vsi->netdev)
>>> +		return;
>>> +
>>> +	if (current_work() == &pf->service_task ||
>>> +	    test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||
>>
>> I think we might need something like ICE_PREPARED_FOR_RESET which detects
>> all kinds of resets(PFR/CORE/GLOBR). __I40E_PF_RESET_REQUESTED handles PFR
>> only. So, this might assert for RTNL lock on CORER/GLOBR.
> 
> The i40e code is a bit tricky so I'm not sure about these cases. Here's
> what it looks like to me, but hopefully Intel can weigh-in here as well.
> 
> As some one who is not an expert in i40e, what follows is a guess that is
> likely wrong ;)
> 
> The __I40E_GLOBAL_RESET_REQUESTED case it looks to me (I could totally
> be wrong here) that the i40e_reset_subtask calls i40e_rebuild with
> lock_acquired = false. In this case, we want __i40e_queue_set_napi to
> pass locked = true (because i40e_rebuild will acquire the lock for us).
> 
> The __I40E_CORE_RESET_REQUESTED case appears to be the same as the
> __I40E_GLOBAL_RESET_REQUESTED case in that i40e_rebuild is called with
> lock_acquired = false meaning we also want __i40e_queue_set_napi to pass
> locked = true (because i40e_rebuild will acquire the lock for us).
> 
> __I40E_PF_RESET_REQUESTED is more complex.
> 
> It seems:
>            When the __I40E_PF_RESET_REQUESTED bit is set in:
>              - i40e_handle_lldp_event
>              - i40e_tx_timeout
>              - i40e_intr
>              - i40e_resume_port_tx
>              - i40e_suspend_port_tx
>              - i40e_hw_dcb_config
> 
>            then: i40e_service_event_schedule is called which queues
>            i40e_service_task, which calls i40e_reset_subtask, which
>            clears the __I40E_PF_RESET_REQUESTED bit and calls
>            i40e_do_reset passing lock_acquired = false. In the
>            __I40E_PF_RESET_REQUESTED case, i40e_reset_and_rebuild
> 	  called with lock_acquired = false again and passed through to
> 	  i40e_rebuild which will take rtnl on its own. This means
>            in these cases, __i40e_queue_set_napi can pass locked = true.
> 
>            However...
> 
>              - i40e_set_features
>              - i40e_ndo_bridge_setlink
>              - i40e_create_queue_channel
>              - i40e_configure_queue_channels
>              - Error case in i40e_vsi_open
> 
>            call i40e_do_reset directly and pass lock_acquired = true so
>            i40e_reset_and_rebuild will not take the RTNL.
> 
> 	  Important assumption: I assume that passing lock_acquired = true
> 	  means that the lock really was previously acquired (and not simply
> 	  unnecessary and not taken ?).
> 
> 	  If that is correct, then __i40e_queue_set_napi should also not take the rtnl (e.g.
>            locked = true).
> 
> Again, I could be totally off here, but it looks like when:
> 
>    (current_work() == &pf->service_task) && test_bit(__I40E_PF_RESET_REQUESTED, pf->state)
> 
> is true, we want to call __i40e_queue_set_napi with locked = true,
> 
> and also all the other cases we want __i40e_queue_set_napi with locked = true
> 
>>> +	    test_bit(__I40E_DOWN, pf->state) ||
>>> +	    test_bit(__I40E_SUSPENDED, pf->state))
>>> +		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>>> +				      false);
>>> +	else
>>> +		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>>> +				      true);
> 
> I *think* (but honestly... I have no idea) the correct if statement *might* be
> something like:
> 
>    /* __I40E_PF_RESET_REQUESTED via the service_task will
>     * call i40e_rebuild with lock_acquired = false, causing rtnl to be
>     * taken, meaning __i40e_queue_set_napi should *NOT* take the lock.
>     *
>     * __I40E_PF_RESET_REQUESTED when set directly and not via the
>     * service task, i40e_reset is called with lock_acquired = true,
>     * implying that the rtnl was already taken (and, more
>     * specifically, the lock was not simply unnecessary and skipped)
>     * and so __i40e_queue_set_napi should *NOT* take the lock.
>     *
>     * __I40E_GLOBAL_RESET_REQUESTED and __I40E_CORE_RESET_REQUESTED
>     * trigger the service_task (via i40e_intr) which will cause
>     * i40e_rebuild to acquire rtnl and so __i40e_queue_set_napi should
>     * not acquire it.
>     */
>    if (current_work() == &pf->service_task ||
>        test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||
>        test_bit(__I40E_GLOBAL_RESET_REQUESTED, pf->state) ||
>        test_bit(__I40E_CORE_RESET_REQUESTED, pf->state))
>            __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>                                  true);
>    else if (test_bit(__I40E_DOWN, pf->state) ||
>             test_bit(__I40E_SUSPENDED, pf->state))
>            __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>                                  false);
>    else
>            __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>                                  true);
> 
> I suppose to figure this out, I'd need to investigate all cases where
> i40e_rebuild is called with lock_acquired = true to ensure that the lock was
> actually acquired (and not just unnecessary).
> 
> Unless some one who knows about i40e can answer this question more
> definitively.
> 

I'll wait for the i40e maintainers to chime in here.

>>> +}
>>> +
>>>    /**
>>>     * i40e_configure_tx_ring - Configure a transmit ring context and rest
>>>     * @ring: The Tx ring to configure
>>> @@ -3558,6 +3610,8 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>>>    	/* cache tail off for easier writes later */
>>>    	ring->tail = hw->hw_addr + I40E_QTX_TAIL(pf_q);
>>> +	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_TX,
>>> +			    &ring->q_vector->napi);
>>
>> I am not sure very sure of this, have you tested this for the reset/rebuild
>> path as well (example: ethtool -L and change queues). Just wondering if this
>> path is taken for first time VSI init or additionally for any VSI rebuilds
>> as well.
> 
> Can you explain more about what your concern is? I'm not sure I follow.
> Was the concern just that on rebuild this code path might not be
> executed because the driver might take a different path?
> 
> If so, I traced the code (and tested with ethtool):
> 
> When the device is probed:
> 
> i40e_probe
>    i40e_vsi_open
>      i40e_vsi_configure
>        i40e_vsi_configure_rx
>          i40e_configure_rx_ring
>        i40e_vsi_configure_tx
>          i40e_configure_tx_ring
> 
> When you use ethtool to change the channel count:
> 
> i40e_set_channels
>    i40e_reconfig_rss_queues
>      i40e_reset_and_rebuild
>        i40e_rebuild
>          i40e_pf_unquiesce_all_vsi
>            i40e_unquiesce_vsi
>              i40e_vsi_open
>                [.. the call stack above for i40e_vsi_open ..]
> 
> Are those the two paths you had in mind or were there other ones? FWIW, using
> ethtool to change the channel count followed by using the cli.py returns what
> appears to be correct data, so I think the ethtool -L case is covered.
> 

Yes, this is what I had mind. Good to know that it is covered.

> Let me know if I am missing any cases you had in mind or if this answers your
> question.
> 

One other case was the suspend/resume callback. This path involves 
remapping vectors and rings (just like rebuild after changing channels), 
If this takes the i40e_rebuild path like before, then we are covered, as 
your changes are in i40e_vsi_configure. If not, we'll have to add it 
after re-initializing interrupt scheme .

>>>    	return 0;
>>>    }
>>> @@ -3716,6 +3770,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>>>    			 ring->queue_index, pf_q);
>>>    	}
>>> +	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_RX,
>>> +			    &ring->q_vector->napi);
>>>
>> Same as above.
>>
>>    	return 0;
>>>    }
>>> @@ -4178,6 +4234,8 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
>>>    		q_vector->affinity_notify.notify = i40e_irq_affinity_notify;
>>>    		q_vector->affinity_notify.release = i40e_irq_affinity_release;
>>>    		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
>>> +		netif_napi_set_irq(&q_vector->napi, q_vector->irq_num);
>>> +
>>>    		/* Spread affinity hints out across online CPUs.
>>>    		 *
>>>    		 * get_cpu_mask returns a static constant mask with
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>>> index 64d198ed166b..d380885ff26d 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>>> @@ -821,6 +821,8 @@ void i40e_clean_tx_ring(struct i40e_ring *tx_ring)
>>>    void i40e_free_tx_resources(struct i40e_ring *tx_ring)
>>>    {
>>>    	i40e_clean_tx_ring(tx_ring);
>>> +	i40e_queue_set_napi(tx_ring->vsi, tx_ring->queue_index,
>>> +			    NETDEV_QUEUE_TYPE_TX, NULL);
>>>    	kfree(tx_ring->tx_bi);
>>>    	tx_ring->tx_bi = NULL;
>>> @@ -1526,6 +1528,8 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
>>>    void i40e_free_rx_resources(struct i40e_ring *rx_ring)
>>>    {
>>>    	i40e_clean_rx_ring(rx_ring);
>>> +	i40e_queue_set_napi(rx_ring->vsi, rx_ring->queue_index,
>>> +			    NETDEV_QUEUE_TYPE_RX, NULL);
>>>    	if (rx_ring->vsi->type == I40E_VSI_MAIN)
>>>    		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>>>    	rx_ring->xdp_prog = NULL;

