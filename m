Return-Path: <linux-kernel+bounces-29586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25545831076
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D401C21E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94939E;
	Thu, 18 Jan 2024 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbhiIgKv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819819A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705537572; cv=fail; b=s8RebsIGfNLgoFBdDHmJRCCP2Y0tZtIEzN69ZhpriZTuZxBr6hX+Svyi4jwByZFFEbKqq/FklB40ixCtCvV9j01RyBY0/aI53SZhFwduaAJ6mLbbF1eBuCtRI5ZbYIvXcg29m9eX+Z+hz2y3wZWaQlGhbyc/HcrLouxQBmAVrds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705537572; c=relaxed/simple;
	bh=v7grw7038a59yQnrsMO/ZMn/2G+Mk8ohIjeHAGoHobk=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Message-ID:Date:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=DBeAo9osyQyaUGMj3VDXO5wEKFBk/oPZ3pRq8A964GhdLKqW7HgdH3cOwnzYHwK1se1JQW+306zqqBxZIn9y0i2GrVZF98RA1nrsp9new+9wuUp0WAxsixdQ3AbWhn3T3G6kkyGrcNCd5sWp8NcsT9Db+yqGF+T0C2pYoLAbkvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbhiIgKv; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705537572; x=1737073572;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v7grw7038a59yQnrsMO/ZMn/2G+Mk8ohIjeHAGoHobk=;
  b=JbhiIgKvWNOGoOn1yLX4b3nBvuawmSpAwXnhsqyKXr1BETmVRRKE3PnC
   QPCZ6+i1mzVopHwNHSA4gBVjw7+ho1MIqcjLUmQLnIg0scelER3v2mV/K
   obWMMPaIKGR0jHGYSKZqg4/xGSSMlYC8X33lKQOPrdBMBcWWZkUgOdjTD
   8KYkcxRrDWe6f/TMdGo3QgkpJQwDg9HiYXXidzaTzOy0vtnCd88hh6Agy
   ESVOhh5dWGc9B+1v0SptyHtMD7b6+EEJALO4u0mVAy5MPH5EToyXBgJ8T
   HOWcZI2kGSZ01vuJec3DEYZcFTr7cjN1WvnoCR/+vqRaYloXLkqwkZ0xb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7682345"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7682345"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 16:26:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="26318055"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 16:26:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 16:26:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 16:26:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 16:26:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 16:26:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyMQdZFRcAvWNy8zzklwMPd8dyG0kqkF3daHPsqntKJ4peGWM9Ld8BM0Zp8r+WbEYBN7T8TmggDVEFGML1Tp0j4WfnSbb0TOkqlk7VWiJHnAvkSFD3JZKJmefbsY4me12Y/TPUAqJnRtxQXIPYbC3GEDCJqCo4NwvRTeXX0iornx1J56nk6nbEjUr6jX9tyKwYSWQTZJkZf6mig+qm2/Gr+9UctRyULsgWC0HJzgACswEpCYNJR0GD7ZW/rxD0uNYCDJanfeU2v/+Vjo8WpXNGeRA3xD2NPMCOuA/VvDVo2Q3NPsC6IQBVB9sYhHxSVVUibo3ncAutqCumqrDPXEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=203Udq+uwkQEt78wma8q3nOfIzwufIm+8o8p8kLZSFA=;
 b=hIXzVLCzeuFDs0VpbS86NDBwYH28CU5v4i6eZBcx6L9wYX0we8foogShhpPWrRBx1sD9TYAk2Kr3/DPOwHQ6IdGfCLP3EiAVCi8z6mWPBsqwELGP3+4ytd26/YFKg9e/sjIDIKQanYIpATogVA3SloJEnbMyHk3R50+M6DZRvUK1+l0Yg6p0NoeKWXrq83GLIvIjoesiGSCgmpDbazVAY8rCs4UlLUM+ZL7wxIMoRAdnopvdKyYDJrd8+OZS0bogIJ8sCPq16Cbsz6f+ZUdFJJfPuYl9ZnA7jStaEi9AcSGHRXDnx+hH00cFCHOvogvflMiFXatf6GqQ7rxwraLxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4852.namprd11.prod.outlook.com (2603:10b6:303:9f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 00:26:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Thu, 18 Jan 2024
 00:26:04 +0000
Message-ID: <adaefdf7-4a9f-4055-be0b-ad30bf1683b8@intel.com>
Date: Wed, 17 Jan 2024 16:26:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Implement new MBA_mbps throttling heuristic
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, <x86@kernel.org>
CC: James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>, Xiaochen Shen <xiaochen.shen@intel.com>,
	<linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240109220003.29225-1-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240109220003.29225-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf07aca-7886-4c3a-fa58-08dc17bc0e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PW3DHkxIGJOunaCjTVmVLz91rnD9PUe/6+1Oay2fdIUy3MC8kV5IQ5QTnkXlC62uEbWs5JULOWWKLiOmPTEbkqpkDidm4Yhda28iikUatdc0urufsOd65up1dtVAknlWXPj6RgEFboze5k3gAprYAESTp/Ryp2C4vx1l2/hf8QIJq4vThFbUQaWpM1UkV8EyQqG6eSivR76yIik6HXjIcFq1VIGe0QNNbfgfY1CpXT2lkEGdo6DIixlsuKrTtE12hQEQvQ64uhvPPR2UgzhltY30BSoZI7ds5UTxSaTctMgCBow4bASLauuL/PnmrHjeb1BKD9yd0kK523gTc+g97N18BQEaI4PoHuowj260CB3pMdq0BP2hHEHHE00BrQCHFNvla9OiJHLf3uZbgp97bciCNL/5WiSsVOVzp+odUFtEYtHlPsr2TyZTu/EMCEmJHCIy/D7YRXe/iGFGeLqX6JFjbmiJJDyxjVlUbYxv462s/7AMppHtTckIVrtfv9WPwYTiaHjoyEFtvXtjIDdWJiGTeysAjo59O/j626QnkK74qFGM2YohxPZz2YfQh6XxXRuktpwJ4P0ao6KsbMPS+kC3/zkndMaXbqUsJUWmW0B4+Hr6fFL9bBqyw8wdGAU8k6x++htgpQFdvbBZSIKlFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(4326008)(8676002)(8936002)(44832011)(316002)(2616005)(53546011)(6666004)(6506007)(41300700001)(2906002)(478600001)(36756003)(26005)(82960400001)(6486002)(86362001)(6512007)(31696002)(31686004)(110136005)(54906003)(66556008)(66476007)(66946007)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1JqdTRIRzBMQjZRRVc0ZkJaK3prbWJRSmlzNHRxL25aRkhTTGxuMWtOdVhp?=
 =?utf-8?B?S2pqdlpmbzlTVktCczErOXJrRXJCaHV6ZjZySnBVbno1WlMzR1FYZzEvKzZK?=
 =?utf-8?B?eitkNlhRWmh1amkwUktNM2tpem95RXBqK1VxMm8rTkZvSC9ORGp5Q3p1M0Va?=
 =?utf-8?B?NGxCeVVTc0pUUlFxOFNVdzU3Q1ZsSWJuNTVsVnZGb0xRalZNekVDaU9CNDUz?=
 =?utf-8?B?eTcrUCtJcTd3QjBXQUhJVE96Zng5bmxiQUhEVytWdy81QjJnaGRtR2pVeDdQ?=
 =?utf-8?B?VE5DaE5vQ0tmeHIydXBGRlUrNnlKWko3TWlTd1N2TFJMeU5heHVQQ0JWRHpM?=
 =?utf-8?B?Q2ZuSjQzYzlCQVJJQnI0VEZLUEZXNFRmQURnUEgxWkNnK1A5aTlwK2dkTloy?=
 =?utf-8?B?c0hyMGt5aEh6Q1AvMDc3Y05pdFd2VXZXS3VpaTlaVkFvTXBOeHUrMnFtVmNx?=
 =?utf-8?B?ZkVtWVl6V3Irc25pV0lzTmtzRnRxZE5BdXlEdEJ4dHlUOTlHbmZDTW9rOXdM?=
 =?utf-8?B?dVJuZ2xTb1RoUFBWeW1nZnFDT1IyUm5oVlRicGJ0dWI3Wk1mMkwveldKdFRS?=
 =?utf-8?B?QmtmQzRwcUtyZEhlaXdPUlJoREttdTNMenU4Vm1XWEFEci9HVHNzOG9CQk1q?=
 =?utf-8?B?QlRPL2tHczlPeXBIMnQ4cDdpWUlpRzNwSkloUjM2SGs0M1NtT3lacWdLcVVG?=
 =?utf-8?B?dkNpdndSb1grMWhsSnZVUFFwbjFmTDg4WXViTGZhWWdJemdoZTU2Nld0RS8x?=
 =?utf-8?B?Z0E2cnJiSVMzYTFXcUZOeVkxZytBR2JEUG03aG5pSGlZMDJKVzUxUUgvUGJv?=
 =?utf-8?B?UUh1WjlZMEFXQmxnN0RvM2VYalpEb2Q2YWwyeVBzN3hJdE9rQm5JbFIrTjJa?=
 =?utf-8?B?aGxGNHBHMDQzajJ4SzhIVnJPYTBYOVU2ZzFoQzE1dHRza0VaVWFvRC9pVFZL?=
 =?utf-8?B?OXBmSXEweTVPbEZPNGxZK0xaNkNkNkhmNzlmM2g5eW9TQjJsN3VjNzVZeUR4?=
 =?utf-8?B?TjZ6cTEyTnJSbnRFbjk0S3pDdmhnbkQrYi83ZFh5dFFBMG9mbzFLcTRsczUr?=
 =?utf-8?B?TnB2bXZwTjJ0Q28reEJub2Npcm93b20zc2hQdEpBbE42b01IRFJjb3FwWjdl?=
 =?utf-8?B?TWN1U0VUQzM0MGFsSzFVdEpuWkI0aEt5QzR3UzkrZllLUDNtc05OdjVmNGpU?=
 =?utf-8?B?VWRFakFtQkVnbWZuUitEMHlRTjdGNDVhT1NnMWlFRGdldFc3S1ZzL0o0cGFm?=
 =?utf-8?B?MjMzRnBWbFlhQTYwWG8rbTY0a1RRbmxDa2VoMTJWSmtRRmhUcFc5MUN2ak54?=
 =?utf-8?B?WldsUzI4WUtNQUNBYWRWQVZTNUFIQ0tSdksvLzFZWDJ2OGZ5L2VkU29xVjdu?=
 =?utf-8?B?NkM4ZnhZWm5zUmVucXBFMkJvcjdxWTI1cHU3TldyZmRpR3AxZHB6amZ5amVR?=
 =?utf-8?B?dm5WclloeTVVMGZpVXl0SGJRSEduSXlyWlZyTitScndsVUFvQnFkZElhb3BE?=
 =?utf-8?B?UUFTMng2b3dVaEkwdUVqZmQvR2dkUExrc0E3ZGVTcmx0eGhhMElTK3FrMm9i?=
 =?utf-8?B?bG92ZWQ3b1F1bU9XTVArcm5MTmhIeTBXVUZwbmIwMFVESjQ1Z2tIbmhqelF5?=
 =?utf-8?B?UWh5YVBSNWpGRzh3OHlxVGVacEt6LzBnaXlTMVJHNGx3S2U3TGZkc01WUVdL?=
 =?utf-8?B?cGMzZVh4eXhPdnNUVld0QVF1c3Y0T3dSN2hITjRyNHQwSGVtRTlVQ01sa2pR?=
 =?utf-8?B?R3hxQVlack5laklWb3EyU2diaTRVYjBKWUdocTk0TkQ3ZmhENFhTeXdKa1Jw?=
 =?utf-8?B?aWxqMXQ5UmhjSjd6NFFkM0RSQTd3MlZsQ1RVdWxJTURrbk1YL2Z4T1VMMFVF?=
 =?utf-8?B?VVNHTzlSa3B4RWRZTWtqVUVkNlEwaDJ0dFRwb1NtS0wyR2R4clJTYkkyRjh3?=
 =?utf-8?B?WFY3dmovSXpMZ2pOdTl6NFZNSW81emhIUmZLYjlmTExOeFVOWkp0b1E4alVL?=
 =?utf-8?B?dlg2em9XS2MzMi9yQkU0VkRLVENOSTBrL0RmaEwwMjg1djBDaU43b1BhSVUy?=
 =?utf-8?B?cWVIaXhzUnQyQUpady91eGtyamxwQWdXK05xMVFZeExxaDVQcGk1bVdLRDJN?=
 =?utf-8?B?cGNmQmVFSVBQUFhNWlBvREFFVXFYNHF4RGVBME1GVzFvZmt2UER4ZnF0b0N3?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf07aca-7886-4c3a-fa58-08dc17bc0e5a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 00:26:04.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8EuIoKN0pkZ+KsT8mZyiJeVGkT+yId7+lgj/fHPzLZYJilqcc45yCTB3985TT4axMIkLM+y9cLNSu7uF5WLF7Un8IDh6GCWcVdqanK1TDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4852
X-OriginatorOrg: intel.com

Hi Tony,

Please note in the subject and changelog that the mount option
is mba_MBps. The subject and first sentence of changelog seems
to fuse the mount option with the software controller enabled by it,
but I do not think doing so dilutes the message.

On 1/9/2024 2:00 PM, Tony Luck wrote:
> The MBA_mbps feedback loop increases throttling when a group is using
> more bandwidth than the target set by the user in the schemata file, and
> decreases throttling when below target.
> 
> To avoid possibly stepping throttling up and down on every poll a
> flag "delta_comp" is set whenever throttling is changed to indicate
> that the actual change in bandwidth should be recorded on the next
> poll in "delta_bw". Throttling is only reduced if the current bandwidth
> plus delta_bw is below the user target.
> 
> This algorithm works well if the workload has steady bandwidth needs.
> But it can go badly wrong if the workload moves to a different phase
> just as the throttling level changed. E.g. if the workload becomes
> essentially idle right as throttling level is increased, the value
> calculated for delta_bw will be more or less the old bandwidth level.
> If the workload then resumes, Linux may never reduce throttling because
> current bandwidth plu delta_bw is above the target set by the user.

"plu" -> "plus"

> 
> Implement a simpler heuristic by assuming that in the worst case the
> currently measured bandwidth is being controlled by the current level of
> throttling. Compute how much it may increase if throttling is relaxed to
> the next higher level. If that is still below the user target, then it
> is ok to reduce the amount of throttling.
> 
> Fixes: ba0f26d8529c ("x86/intel_rdt/mba_sc: Prepare for feedback loop")
> Reported-by: Xiaochen Shen <xiaochen.shen@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

Thank you very much for catching and fixing this.

With the issues ("MBA_mbps" -> "mba_MBps", "plu" -> "plus") addressed:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

