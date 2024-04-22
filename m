Return-Path: <linux-kernel+bounces-152881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 519228AC5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77AFB215E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D284CDF9;
	Mon, 22 Apr 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlVSDcX2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905EE4AEFE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771352; cv=fail; b=g/aiiFNP4x+qSEcAlHx+3ne7K+KRJsy020wKREv1+AN1Q9KN5OHG673xO3QOCeBHlX39/0Bq9dzJ7i/UjwtkP3SHTbJzOvB8t47HxIXx5muwxvOBfsZDIzWAwl+euj7eLvd5UbGbsOaC0xKTAxbd+2Toqp5DlzSzY9Ae57nPFzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771352; c=relaxed/simple;
	bh=3G0gqmSWmvSAb1ZFXyNjxp9mch5tF3Ej0b6C+n8Czbc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C/nwbFG8gkJCfMMaUHfvTe/YK8fWrb2JGEAkLm9saN8d+n2v7EQ8iGs5W077EM4JC6eb8gCTqc1kNrBsNNzXtCUl+R0B7+EBnd2RpcLY2QrCs48uhcF4c76hCG95NJzw2DXxvsoNNw0Ohcj8OvPXkHQpIXmfFI+7sHReomyVXCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlVSDcX2; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713771350; x=1745307350;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3G0gqmSWmvSAb1ZFXyNjxp9mch5tF3Ej0b6C+n8Czbc=;
  b=YlVSDcX2YjF/hX4xezNllhsD1XFg1wnxqDaAb9vXsEyViJRWHObejb86
   RuM/EQrD8Vz0yrEfErUL+4a4qCn+PcY9RVBVqKwzkQdlUKr/c5sPqYWGT
   d61e4h5irZ4WN85iWqfiGEmmgJdITJNICGIQy2oc6Oy81uSQUTgeX7a2t
   u5ZTL262YKDAGIweuvuzvAqv2z3Cifty3P3UlVpMn+mmDYzaZXaadhM9y
   em349TfIZpCpOTXZDhT/HZDt1ZPkbyc9/JxBjzELGArJmvXPSmBv7KCRX
   k7gde4kM7WztzlYbf+7/hpvMcXU8wpcqTNFzJ6vb0+F/FSGeHrsXMf5Yq
   g==;
X-CSE-ConnectionGUID: fd03tTjhQZK7N5BHw7wwHA==
X-CSE-MsgGUID: DsJtFbXhRqKVUd36rQt+Vw==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9160754"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9160754"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 00:35:50 -0700
X-CSE-ConnectionGUID: ROqHT5+TRxShslYCQcIg+A==
X-CSE-MsgGUID: HJDSFrJ/Q0Ca7VNj5yyKZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="47223033"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 00:35:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 00:35:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 00:35:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 00:35:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpkcrIyJ152YSatj9P0R3Xlnl/N+UjHS7Dbw6VB4A0lYZb95gdHF2IWXVWNBnH+uM7ALlBr3Fa9bab1FURjdEr6IA2Y/F/xpW5+mh4E33A32mktcKPQXgV6d+0Kbn7r6J+ui1NzxquqOxkriLRwL8bT3rwbbiKse2wx1aEI+OJlsn7KkpbM6rigSZ33swM3SvbSBysMcvA0KbbE/3R0mBTYnaSqYeUbdeC0KzZceHBsUrAAbJ5F+uNSB/VqCwS+x7FFks0Cjk7U+Zx1R4ybPvE1R5HvGoEn0YlRvw9vvIewIYkGA7yMsnBBJmkJRpmooBYiSPnXd5pHpUcihTco0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1bQ2XycTcawoONllxV0JQ6VE0gS5wALsWK2S2Sw6OQ=;
 b=ns8EAZprriqG9G0itz/8u/sw0HzpWu6gWJ5pjULxptXcyFJdTkjTqam3vN9JtJtZnuZI2kEEcq6bYzhuImLNHK4kW9pwy7Pu/ES31aFqaag6SOuiGIMtFPYObhXdZFoNzOpfyg5JMNbxk52TPvPTo1+3+1l+I5ntjR11ErTP57XiNSdyAoT55gcM7QZKMliOtjJScSEwfZL7yKl0lpn4e6tbW60oSA1uvq9ODiVnHiA2vP/dvjffsjuF6ciaLv3yNYEZJF5VMYFY/i+SXPd9oU5WZWwL+uQg/e+JbRIlFwWL1pigDTISiBPWwsWve5Um2ni7eRqIFjEqmQQlbMwFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 22 Apr
 2024 07:35:47 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 07:35:47 +0000
Message-ID: <142380d5-27bd-4ddc-8c33-03a2f8701fa2@intel.com>
Date: Mon, 22 Apr 2024 00:35:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/14] x86/gds: Lock GDS mitigation when keylocker feature
 is present
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
	<charishma1.gairuboyina@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
	<daniel.sneddon@linux.intel.com>, <antonio.gomez.iglesias@linux.intel.com>
References: <20240407230432.912290-1-chang.seok.bae@intel.com>
 <20240419-gds-lock-v1-1-adcbef6ce24b@linux.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240419-gds-lock-v1-1-adcbef6ce24b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::18) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|SA2PR11MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4778c130-0e12-401c-9ef7-08dc629ed37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGhIM205d2xiT2Fkb2ZkSzVvQ1NUS3prSGdCNzV1NDlHZ2QrQThGMXRRdU9N?=
 =?utf-8?B?OW40djkrRUlZdHpmcFNBelNkSzIrVk9FM3hPbnhidi9UNnFyeUNJYTJBamJV?=
 =?utf-8?B?RGFDWXVrUlhUZ0gweE44K0RiZzAxZlpCRG5adzZ1eExqem14WU1qbFZxS2lh?=
 =?utf-8?B?TVBGaFl6aklGQXNJVUdHS21CYWZEOUQ4NjJPRmFybDgrQ05hcUgzcUVpb0M5?=
 =?utf-8?B?YVo1Vjg4d2dMWjcrYUQzT1pxTHlLeFh6aGFMQkRmMXg1MHQ2bWZyL3djLzh6?=
 =?utf-8?B?YTBLYWZyTis0U1NtZitLcU1xb0NOQ1lKc1NLRHFnRmp2SS9XVTZYM2c2bkhQ?=
 =?utf-8?B?OEJoWXA1OG11dXg0VmN5anNYZUZrKzBDcmlnTUV4dHdXOVptL2M3dDQ3dzZs?=
 =?utf-8?B?YjIxWDczaytodU1SL3FSMG5YUUZDVVdqaUtBV3FaMW1ZeVU2bGQxNzd0amVk?=
 =?utf-8?B?L1hYLzJ1TFQvVkxuSUNGcEI4Z3N2bTdNYVNKTTVpUFF5NHZlWkxUNkhXVzBi?=
 =?utf-8?B?R3pwbzFFMVQ0dVRKWWpvdnM3cmZCWlVaaVJRb2FZRG1iUUk2M0U5ckYrU1Zo?=
 =?utf-8?B?T3dNSUk2VVMwLzA3S0RHV01aUmZFa2ZaYWNUUnRldG15dVBsZHNsQjIwV0Nh?=
 =?utf-8?B?UklySVkwQU04NXpjeDhDNTdDbnduWUduY0pOL3oxTk9KdjNxQjBpVm1BeEt5?=
 =?utf-8?B?OWhVNHN1bkNySW9yOXBHTUN0SXV0ajJYRXAwSzRjWTk1ckc0VVhGalBEc1E1?=
 =?utf-8?B?Nzk1Ty9ENVk2N3BRNzZYaVhRc0ZpVGdZU25PVHloTDc3WUVUUlRGbG1XWCsx?=
 =?utf-8?B?Mkp6bWFib3pHV1M1TUxmWVJjcUtiTnl2czgrakZpSWV5Sm9nZ0Y5NFNrMk9E?=
 =?utf-8?B?bmJ1K2lGTGdHUCtJRWZmSnZBYW9UUFJBemM4dTJuTUEwa1QvZ0dMVnFlMXh4?=
 =?utf-8?B?NWo4OWlDRDlXZVJ5S01tUzd4MjNISHQzMWZ6OVVodjZtbWZsdUtwb1ZCSVdv?=
 =?utf-8?B?VGJSSzVQSTNUbGdKR09jRElBNnk2bjJvQzIvV0JWRnZNR3M0K29seDBjeS9I?=
 =?utf-8?B?MElwQnJZS0Y1T0pLSjJ0alB6ZHRvNlg2aDhpMklMc0lCNTdNZy9Rb2ZxdjRl?=
 =?utf-8?B?aWdOS01XbmN2REdnbDZhV2FqMFo3OXRieFdBVktpcmxFR2c1UHI0bXovU1h2?=
 =?utf-8?B?Njg4TXJmMnNWZElmTVZ6N1M1U3FteU4xOXMwU0hvTVpUQlZMNnJJVEJZbDVC?=
 =?utf-8?B?UksxZy82eVRYUGlBcmRMMERjYllCMUpMQUhURzZZTGY4dXZQOTVCbWU5Ni9C?=
 =?utf-8?B?aGducmw1UmNYbE5YdWZPTHdFZDMzNTVXQ0IrUVlRSXBBM0c3d3ppeXc0M3A1?=
 =?utf-8?B?MzlnSXppTkdZelhTb0xBNlpuK1l3R0d1N1RLUVZWekVmWEtuMDdxbzVMeGlN?=
 =?utf-8?B?aHV0cm0vbzd6Zm1mOGhrMVhNMjYyenZTbVoxd252bW4wOTJjOElOcmZJWC8z?=
 =?utf-8?B?bVh2aFFvaWhlZWVGYnBlUlZEd0NrNnYyYmpuTC90WmtsRFpFeU9uQzh3RG9y?=
 =?utf-8?B?eFpKK3dSU1RTVUdRNFk1N1pSRE9FMko0OHlNaUljMlZMZXg5d21idDRyY3JT?=
 =?utf-8?B?WEFUUFIzTkZMdVFzcml6Wm1SYjcxVU5HTWRYakx3MnhORlJpeWNuVk0ySnEx?=
 =?utf-8?B?NnpPdHAycklleDJFd3VwaSs4SUhxZElxQkZBZjRUUXpPekE2WTRPeGpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDdxaTZrUTEzTlR2YlljUFFJb0cxeHB5ajZmdmduTlVKby9ueDc3Yk1lWFV1?=
 =?utf-8?B?YWZQcDM2SDhiR1FyYjN5MzZZWWFSZ1JUVW10UEJGYlBPVUZqQldORkp6QThE?=
 =?utf-8?B?dXFoeDNpMitaWkdLMm1uVzl3a1pXOGJ4cXJyRFNJMDY0SnJZMkRFWUdkYm5L?=
 =?utf-8?B?OVZnYkUwa0xUUUoyRlprdDEwU3ZmK2dKSXdRbGdCK1R0eVlEY043MDN3VTRm?=
 =?utf-8?B?QWFTYjFTVU43aWVvaTZ6QkJkNEZIcy9vMm52bTRCdWREQUlQaExBY3lEWllY?=
 =?utf-8?B?NVRQQUFpd0ticVNEL2FYYnd0MGhWN2JVY0lvajU1VHJKZzY1UkNKU2puaGVs?=
 =?utf-8?B?NHlrSXN6QWxRcFhpV3N6Z2dYN0RvMVdVL09kQkYzYzRvdTJaaDZzU3BEcVdO?=
 =?utf-8?B?UFk4dzlIRmJIMklCMEpLRHBTZW1VQlN6SjdXdHNBOEJoNXUzWHV0VGhGaWNo?=
 =?utf-8?B?dHl0TTlmd3VSeFJ3RXBUZjlaMHV6dVozT015NXY4Y3FGSnhoanpYTWRqcTEv?=
 =?utf-8?B?VVd2ZU82Z3RXa2kvSXhsd2Y0b0hvQTFVcW9XODk2YjRETk9peWpyc0VzU2xq?=
 =?utf-8?B?MXpNU0s2R2FiUFR0Wm5UYWdzTVJVMENmTWxiWEo0ZGF1S3JRdHlUK2dUSFlY?=
 =?utf-8?B?RG1ZOGsrN3ZRTjBUOVNKaXJaVmltL25hdG5rTGlpZFVicUxjMFZKWDVkamVs?=
 =?utf-8?B?a1V3MFRxOExBYmpwSDVRbldUSktwY0pWWUlKMHVXK2lMNCtwMXZuWml2d1Ba?=
 =?utf-8?B?T2FReEdGMXhreGYrbmhMWWprc3VzSGZIa1FDM0FmaVRTMThpQllxYlByUmdJ?=
 =?utf-8?B?T2M1VFBQTUlRbGtMNVA1VzlSM0F2eUErOU9NaDVHd3JFbUZLWUdUNUx5NmNR?=
 =?utf-8?B?Y0p3Z0dqUmJ0Tm1OMGVEays3QXJOVm5PV2d4Z0h5V0ViQ1licGxCaWVZNEt2?=
 =?utf-8?B?RDg2WjFteDB6NTdvUkUrMXhJT0szL0YrdTR3bThYUVd0UWtBeUdud0hlQ3FZ?=
 =?utf-8?B?SmNFdkh5TlowdGc0ZHB0RWx6TWppNGdEdGNpQTBWbm1tVGF0KzBQU0ZiTkUw?=
 =?utf-8?B?VE9SNlorNFVvN1ZvZmhhcW1WdEUvWEM3N2VaRFVVcjVIcWlVNWMzbHJkbTNT?=
 =?utf-8?B?MTQ5MndPODN1SFljaERhZzVnQ05FdkMzNVFCTlNpSEkraWU3eUVTRVE3S212?=
 =?utf-8?B?TllyeFh5MkUrWU5aTEpOWWQyQnhsMTJ3b0RMVTBIemdrTEFZOGNNQ003OURR?=
 =?utf-8?B?RjlrY2JVVEVXWlVwOC9PMmw1ZUx1YWdubk03RzQvTFlUd3JENkRQSmpBWWt0?=
 =?utf-8?B?Tk5xSXZkQXpmRHFFaVk3cHhPcTdjcUhhVHRCcVc5WXlzQldZTnE0eWpsOG5N?=
 =?utf-8?B?R1hrNTFsNHRwSno4UHNkeXhQdHQwczlSTmxGTU9sa0xhMDZiQ2VGR0lZMDRu?=
 =?utf-8?B?VVFMR0lRWjhGYTFxUjRDYVhseWZKRlNrSTBqL05yY2RFV0xHYVkvQ2Q3aWEx?=
 =?utf-8?B?LzgxMllDa3RGdWluWUhQYlFVb09iNlJKNi9Jb2pReWZMb0ltVGtIL1MvRm1q?=
 =?utf-8?B?ZVJhWVJuNnU5ODZ5RDZ3c1pSamFpRXBLNDhMNHNyVDlXVmlNN0ptRk4wZGlC?=
 =?utf-8?B?MmtDb0VhUy9sRjdmc05LN3doWDFoVWwwbUJxZDE1cGpwRnF6SEJuVmQzd2FL?=
 =?utf-8?B?ampkYi9rb3gzRlZZbmRuVGk4OVlENUp4aUZ6Q0tOOUlHQXZPalB1NTJOT0lp?=
 =?utf-8?B?bDBiak9JeFh0ZDJRcGRJc01mcU1scDBnSEYxUUU5VlB3YzFwNXVsaU9Kd2Zq?=
 =?utf-8?B?NlBOb1BMRUIzbFEvOG15Y2YwbnM0Y29MWGtmVzBRQVRxOWJkMnVLQkhEdmpj?=
 =?utf-8?B?MzZqaXVtTXdDdUlGNThoeG5hMEl5Um03V1ZOdGxtTWZqRVFEa3plSklGaVhV?=
 =?utf-8?B?d3Z1bUozdjAwSXJuT1FuS0JrdEdYUmNMUmxYZWtkY1dsazQ0YWVoQjU1L1Uz?=
 =?utf-8?B?YUY5MGFiOStXZUtRYmZyWllKOHN3S1ZGZXZtODVkSmRIZktMamhCOWs5VGcx?=
 =?utf-8?B?eWMzSTVJWkNjdi90dDUzZWFEMHE5eHpCbUlITFpQYUVUbU1nWXJwNzNHaW9q?=
 =?utf-8?B?b1Q2Uk90bmZrZU0vN3JMYzlwd3h4VDBDU09zcDBIZXIrUzladnV0aUdvVHU4?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4778c130-0e12-401c-9ef7-08dc629ed37d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 07:35:47.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaLYQQ/jHA9gPYPONs/oI17WfL/KeBNzPiZuH9QD/okD/wiL48UXYTsTKtBmBy4snF/XeqMJTdHjm2Q0eJ51r8XisnHaYdm9htijmIxj01M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
X-OriginatorOrg: intel.com

On 4/19/2024 10:47 AM, Pawan Gupta wrote:
>   
>   	/*
> @@ -840,6 +843,11 @@ static void __init gds_select_mitigation(void)
>   		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
>   	}
>   
> +	/* Keylocker can only be enabled when GDS mitigation is locked */
> +	if (boot_cpu_has(X86_FEATURE_KEYLOCKER) &&
> +	    gds_mitigation == GDS_MITIGATION_FULL)
> +		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
> +

I'm having trouble understanding this change:

gds_select_mitigation()
{
	...
	if (gds_mitigation == GDS_MITIGATION_FORCE)
		gds_mitigation = GDS_MITIGATION_FULL;

	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
	if (mcu_ctrl & GDS_MITG_LOCKED) {
		...
		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
	}

	if (boot_cpu_has(X86_FEATURE_KEYLOCKER) &&
	    gds_mitigation == GDS_MITIGATION_FULL)
		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;

As I understand it, gds_mitigation is set to GDS_MITIGATION_FULL only if 
the gds force option is enabled but IA32_MCU_OPT_CTRL[GDS_MITG_LOCK] is 
not set.

Then, if the CPU has Key Locker, this code sets gds_mitigation to 
GDS_MITIGATION_FULL_LOCKED, which seems contradictory. I'm not sure why 
this change is necessary.

I'm also not convinced that the Key Locker series needs to modify this 
function. The Key Locker setup code should simply check the current 
mitigation status and enable the feature only if proper mitigation is in 
place. Am I missing something here?

Thanks,
Chang




