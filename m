Return-Path: <linux-kernel+bounces-157855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949458B175A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A96A1F23932
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C116F26F;
	Wed, 24 Apr 2024 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXEGCm3y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450CC13A3E6;
	Wed, 24 Apr 2024 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002290; cv=fail; b=Ltv7060JeQX7eBsFm/xLux7qBA9zHwLSEJIQhg6xX85kd8fCtAbFPFURv3XOPzSGAm9x2590LXECJlbGnH5Lw8ULE6KkTlTkxSWv5fRNyiOixSgeHGrAG3vR96WKUTHsHFlnJXkzbS86F2kklFKYL3aV7nCYLgJzco6jYOwsRJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002290; c=relaxed/simple;
	bh=bjb8H0yT7KLr3GA3Y6QsHZ7jdBgJyFpg17GgyoT9KpQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VNYO6/7syIJ9E4GEB3Sxpfju+3kjmJcDly4XmpQm/5Ml3blRoG0Y+9+KwAU3dAsutoUZLQ2/CgoOEXLRTnjF+mXLc1QwdfQQfn7kS0qwfVah8RAYVjXUoKmo++oDh96OP4n+VTWapm/pb+XLfQ6QN5feHvVmGJcLgqemyT3ntlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXEGCm3y; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714002288; x=1745538288;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=bjb8H0yT7KLr3GA3Y6QsHZ7jdBgJyFpg17GgyoT9KpQ=;
  b=NXEGCm3yRch7RWEZlycDvpGx920Y27qgB/BEWsMik0O+BdbSWgieWS/B
   n9nkjUlYQDPdsWk1lQJzTGH/YKCZafgYejuGnG6uGdvwBdrscEGR/c8Yy
   3yyxzkA61R107jQtSp96NEra++0fu4NCxX1JTgJtui0OkbuCcuWRJGMQQ
   7NBCXhyldrDbbMg/SQwAqPrJdK0/uQuS9N0qWg/rBrJz5HoOj9nT04VF9
   ahcg5anUovz+N4njJxJzdsWrAuqfMvrDBNk++ysS6BtWYKnbb6L4QVoGy
   D8kBoF0Hopj0j4eHqsg0S2jJmRgP07aoUcoqi5UbpXWLYQ0oyF83Z+e5h
   w==;
X-CSE-ConnectionGUID: Ed2oKftbSbGXUtUYw3jyPA==
X-CSE-MsgGUID: tyfvrUbjQoWE2C+a/qOpLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9527886"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9527886"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 16:44:47 -0700
X-CSE-ConnectionGUID: JSNnu0jPTBuUg1i7A80OGA==
X-CSE-MsgGUID: 5aAy58j7RlCSNfmXwBQ/Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="25304673"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 16:44:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 16:44:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 16:44:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 16:44:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 16:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXa4dnv2ahZfW0e0/b1TBDMh+wgboe5AGA1kK6RVhHZL74T7UYy02df3pNbc1PHepbG+jx0S3DqGBkgyE4vXsG7jc/fz0MCuWmBTYb3oK/I6UxrMOyg0hyGaeV/KmYUr+4/CmQukipZYzJwGPKp3uscK44VjuNtpzjWMfHUWio5TNJqIyJtOrRn+Nv9CK5Lj/TFa7iJJnF3LWBg8xgmIbPmsZ43MtRdRQWizfa3xA118S+wLKT3zI7w7gN04D52OjZunQCE27KALHqUb7wWzztxW40s0vDBCkx/W8LR35miuBqfjBhFLXEn8+D4BFrF28mTmHSBUVwhl56Ztan7dfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMx1DnK+w2QppQavrkZKyXx/MiAuh6HCl+8H47zem0Q=;
 b=WlrcW8HnxnrRRlA4IqqWeDyXNnyiv6R4OqYYkIWS4a9GIoNSQGJTq80mQDsTd4or+02pJRIDkWo63HztmWU6PVYkhPjD6V0Keu8s6dJBG85k3Qd3vqBj9M/4qbXOuSDdW6dpW+73/aBtSpgR0XUUvHWQA1xAHUMM+ekR3IBPFvYRidKvTk93XVtMqeYYxdrxEBuPPIcHX4GDDK43mnGNn3rGVVsMiCtc1aFLDgE6c/BmjSVpWbtdfXOq/FjDBm8zWcImgogdBqt2BcnAWdifDFXe7azocjU+E+Ia69ii0gB2dPbFjeZ4uNXuB8KdV6pzjlvYrah+dm1pVII+Wgvuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by DM3PR11MB8681.namprd11.prod.outlook.com (2603:10b6:0:49::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Wed, 24 Apr 2024 23:44:38 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::c625:ce3f:cb4a:db14]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::c625:ce3f:cb4a:db14%7]) with mapi id 15.20.7519.020; Wed, 24 Apr 2024
 23:44:38 +0000
Message-ID: <3f4262e2-58b5-4ede-ac55-f20285da7b1b@intel.com>
Date: Wed, 24 Apr 2024 16:44:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD
 duplicates
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240423144100.76522-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <20240423144100.76522-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|DM3PR11MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a92fbd-7735-4da5-cb2c-08dc64b88123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHNHd3BVem9LV24zY0U3c2d6MG1qN3Y5eTBHZHdSblJYaU83ZE14dXBvMENs?=
 =?utf-8?B?NSsvd3BqOU1BQnJKM0V3eGFYZzNLTUkvT1VoV3loSW9rbEJlS3Z2L0hSN0Yx?=
 =?utf-8?B?VnRycWxEVGdrTVVyMGx3ayswK3RiYi9URDlXaVdhd2dIa0ZkbG1aZ0FkbHZi?=
 =?utf-8?B?OHV1bnQ2YmdzUzlLMDVoc05ZNksrb1FnUGJBU0FWTkNqbFZSRFRvNng4NkE4?=
 =?utf-8?B?dTM1cURCZTRvak9UeGJRcGszSVJiQ2hVc3F5UHZMUVJRclNETit2SzhwdU00?=
 =?utf-8?B?TFl5YzJOeGFLNTJjQUlHQk1OV0xHa2Qrck9TNjY5LzZzWWE0aWw5TzJrRUR0?=
 =?utf-8?B?OEwyQkVwTUZ4RURWcDdiZzVxOTgzdURTQnA5K2pubzNSUVhmK2V2Sk9VQmo4?=
 =?utf-8?B?czBiemJZWGdMU1ZQd25odFNDMTBrR1RRZFI4UEJIWVpDSXZ3NDUrK2E2QlZj?=
 =?utf-8?B?dk1Uek1zT2w3SEoxMkdRU21mRmdVb2ZkWFFCa1RML1p6MGtkRkQxRTIxaUcw?=
 =?utf-8?B?dzRlTCtPTGQyMkRMWUtmV2VQTzVNbG13RzMxSmtGVmF3NnNLRmRNOElOU0Zj?=
 =?utf-8?B?aXV3Zit1N1ArTVM3ekl1cGlEU3JISUJpS21sM0g0TmQzcVVBT2F6b2E3Ukdt?=
 =?utf-8?B?RjhPM1ZvTnE3T29Ga0JlK0RicHNnbU1VeDJzZG9sVTcxbmRyeHpUbEp3OERw?=
 =?utf-8?B?bEhKdUZOZ0ljV3MzWjNqNmlPN0x6MVJNbFRiY2FUSGN5ZUdkUm02NUtWSC9Y?=
 =?utf-8?B?c1JvK2tJc0tmU25yQjU4Q0Job3ltM2J4QkcwNFVmWkRjT0dTWk05RTlHdm41?=
 =?utf-8?B?Y2NWRndiK0RycWtuOWVEeWFsWStYYnh4YWVoRnlJeWpMS0lpb3lrb0UzWXpL?=
 =?utf-8?B?eVJJWE53Y3lTWnZYZ3k5ZjZqK1RBMHNpMGErZUpkcGk4UWVxbTB3YmhsT2xx?=
 =?utf-8?B?OUNSaW1LU3MrdUxSa3lpZkovL0JoaG9QVldyS2dpZkRqK29kVENOWWREUklO?=
 =?utf-8?B?WnZUak51aGVNSVF5TVE3SXFzajlEcDl3MkR6a3ZPVk5Qdmx4L1B3ZHdZWWhK?=
 =?utf-8?B?VGRUdjFkeFd0L0ZDaG9pM2Q1UW55UThhd3l6UVA2RTlteHdaN250bmhWRTV0?=
 =?utf-8?B?VUd1U2NKcFc1VnJpUWZMNEF4RmZ0Z2NOb3hESE9NaXVKNklXS3IydEFuVmNn?=
 =?utf-8?B?VWgvS0gyYitXa0k4SDJ2MWtEOXNDS1FCd3I4K21qcHlIajFqQWlKazIzRlJh?=
 =?utf-8?B?L2ZvNlVoWDBLRzNrMVF3RTRIZWxMOVNMazlwSm05Y2p0NGxnWXJFaEhhTzMw?=
 =?utf-8?B?eUdiUU5RcGNueldtMUxUQkxqN1BhNG12N0xBSFFMaDV1OVBmcnhNc0RtQytq?=
 =?utf-8?B?MHlOYWxpenpWOHllR2swVnpEZWladllRZHlQWU9Ocmdxc0xvMDN3bGpxVTMr?=
 =?utf-8?B?SXg0OGR3NUxDYWtpZEFPOGswbldnU0o2WFpQbTBqSmhYSWlJV29Nc056RjhB?=
 =?utf-8?B?YWdDMXZJeCtQcTVwL2ZpM01HbkNya0JuNmN3cHJ1UHNPZlRWM3lYdGRNVU9V?=
 =?utf-8?B?RGsxWjNaNEN0OE9VcExKWDEvWDNkOU9iai8xU3VjdGJ4QmtXOWtpYzFQOENN?=
 =?utf-8?B?UnZTRVZxa0x0Y3FJeVJWVThVUXRvNG9kT3lZdVpRcGtzTXdwNEZvMXFxNjU0?=
 =?utf-8?B?cU9ocm9RQTM3Vm5talI3V0cxUUdKYkpGbHFlYkhIdUpBM2gzQndlTjNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2NJdWswWmlCNEhqY25zYWoyVDRnMnhvRDZYK1ByRkQ5bzVkVURFQnJFQ0Ew?=
 =?utf-8?B?SlNnOWczYk5CbHdFUzZjL0dObDJSa3ErNnpLay9YNzAzRjdYT1k2U05uZHRV?=
 =?utf-8?B?c0JYTEszMDZFTXR2NytWem5UU2diL0o0NWF1ZHY2N01zeTRwT2VwSGRQcVl4?=
 =?utf-8?B?RHJzWGhKK2VIdGFsZFUxWjhJd0VHa1E5YUtzVkxla3pYenlITFB4NDl5NnlU?=
 =?utf-8?B?QVIzajhaWkJ4YTdueGtHdWQ5blZMVHdxVDN1enRReXc3SFoveUY2YmNsQ2lW?=
 =?utf-8?B?YVhIYTUrMGRZWHlvQ3lXZzlMWlFvdzVzMGY1amtLc0pnQ1RHbkIxR092Zlh6?=
 =?utf-8?B?WUhkUE5ubHVXaUlBcmxYZ0tiNGo0bEJRK21VRXRVek8rbC84RVNiSnMyWk1t?=
 =?utf-8?B?Wm1aUWZacVB2akIwSXFBcVJUcmtVajd2RExwSHF6c1RJQU16eUt5dERwM1pT?=
 =?utf-8?B?WG1oajIzVWpOQWFDZlM3aC9GejVYc3hEcnF3YjJPNWNrMnlKZ0JxZGFhVkZ4?=
 =?utf-8?B?dWpCRWg1YVFDZ0FpYktsSDU4VFRJcyt1QThNK3luZTNnc2NSb0ljRHd5SVU3?=
 =?utf-8?B?SkloMnNKUkJOV01oZGc4NU5QN1ZvOG1WU21rVWpYZi92Rnowb1JZWWdWeE5p?=
 =?utf-8?B?ZHpJODAxcmR3ZDFBNnNjZUJqN0tlV1VPekxyNkY4aG04eUhsQWxHSVdKSnhD?=
 =?utf-8?B?anFGQmdtL0ZtUitEa0RleUZnUnc5TTNaSHRyNkdLME9VVmRhcmZJcHl0c0RX?=
 =?utf-8?B?dEZWV2llMTJaZDhFUzNlT21KSTJ2RGNodzRiVi9ZQ3hpeHlSRUxZaFNRaXRr?=
 =?utf-8?B?T1o1RWpMeVI0eS9ZbW1vVlI2QWhTRUlwZ2w0UzFBY2F4QnB2OFl3bVNzRXJB?=
 =?utf-8?B?RHJuQ1JZTUZnUFg5NEs3ZHdUeTZOdjQ0bk16Q2NtSmFOSlg3NCtkeVZoZ0hW?=
 =?utf-8?B?a3RNSGJLOGlKdi9UYmh2V2RDVWg3TDVsWS96MldSd3ZGUnRoWEd3aS9lOXNp?=
 =?utf-8?B?cnBDdXJ5OVcvVlhjdnd2ajgyVk01K2ZYS0szem9vRUlVRHNOakl0U2JnSVlG?=
 =?utf-8?B?ckRiTDBucU9sazNuSTdIbUhvYkZoR1FOclZIckx3Q2tCdUhxWUVZdklvNHNz?=
 =?utf-8?B?Y09MemlkTGlucEVnb2h3VlpkQ0JYK0IxU1RBRkFlN2pVWlZYRUNRZVk1VDBz?=
 =?utf-8?B?SW5vbkM2ZnVMZEpldDlHS0VMRWl4QkZGelE0UVN2ZXZQczl2bUMrLzBadmFV?=
 =?utf-8?B?UVhFem9rS3RWeDdHVWVxTGxiejBWRldOZE5OWjQwNzk4NzhQZno2ckttMGRu?=
 =?utf-8?B?aVNEbkNzdTQ0NjhLYTgyNnVPd3NKVnByNlhmYnlSM2RiRlN1M3IvZndxYVRG?=
 =?utf-8?B?eVNlVENBZkNaMDdRbzZDK2tUcnYzNEZuZ3ZuYXJtWEVKKzEvaE1nMnFNU2tC?=
 =?utf-8?B?NHVNd3Ruclo5OG9oeFRYa3R5RExvTDRuWjdJMTliUzI1TGNjTFEvcDNKeHNJ?=
 =?utf-8?B?NTZNTjlSSnorZDgzeW9jcjBGL2xVQWFpZzh0TExRUWd2Z295LzZaUUI3WGNN?=
 =?utf-8?B?RDB3b0FDaXhhSUNJam44YXpnTjhEUzFKaXMrUFAzZWFUeHF0QnNFd2g5RnZw?=
 =?utf-8?B?MFRaT2R0MkFjb1hsNytsd25VWGN1cWRKY2Yvb1l3YVFiUGhmV0p4UWE4RVFZ?=
 =?utf-8?B?M09KcVA2a2R2MU5qaU5ZUHpQWFd6YXVyNHpaOVJWdHpTaHFwZi9nL0pYbnk4?=
 =?utf-8?B?ZndMdkFYV0ZjamE5Y1lzVGVISlJyTTQ4RE15YVQrM2hLeTRBMkREN0g1emVm?=
 =?utf-8?B?Y2dJNWNubkg0dGxZV0NueWowWGNhMk9NN1NscVRGbFV6eHVrUjhvWFVxY1Vz?=
 =?utf-8?B?QXVxZStLcTh4TGF3cjUwSmJSUDhUdnh4NzhjNW1Kak1zQitKeEU2Rk85bitZ?=
 =?utf-8?B?WVRKejZrUFkxN3FnQkpGZXZGM3cvMStYaW5vODBKZkJWRVhUenowZXZaNFFE?=
 =?utf-8?B?NXZ2TVA5Mm5tT01pUmFXUE9DM0hlZ2lOWmxvNkR3WjMxWnlmYUJHZ2Y2dmFz?=
 =?utf-8?B?VWRWZFNJKzlrSVhuaTlJNnNZUURQTk5YNjBTYnlPR2IwSm5ML3FYSFdQU3JX?=
 =?utf-8?B?dUpTQ1lqd0N0YngwL1NQTHg4WHNSQnhJSkpZVE15bUw3SlJnbUVzVlM5UWZG?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a92fbd-7735-4da5-cb2c-08dc64b88123
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 23:44:38.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0McAmibd/b6dJm4yo2iLPAA+TS8HLtQxrkODYiMd5RHUgWKO80Jfc8lJNI6t31UJvSEjbdGWJfnhr5NXDQjjcjyX3N5QtrwNFO7nu5uYOyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8681
X-OriginatorOrg: intel.com

On 4/23/2024 7:40 AM, Ilpo Järvinen wrote:
> PCI_HEADER_TYPE_MULTIFUNC is define by e1000e and ixgbe and both are
> unused. There is already PCI_HEADER_TYPE_MFD in pci_regs.h anyway which
> should be used instead so remove the duplicated defines of it.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks Ilpo!

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>



