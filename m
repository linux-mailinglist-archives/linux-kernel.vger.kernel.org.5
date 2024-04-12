Return-Path: <linux-kernel+bounces-143223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E38A35EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56572825C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B414F10F;
	Fri, 12 Apr 2024 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxvNK7iS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180A3FBAA;
	Fri, 12 Apr 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947514; cv=fail; b=u41PGEiDc6xujIyc9AqkpRw5N/B5mj4npkrncptVl1LRO54ZhRt/3U/2GUKwXeafrzVGQWC9z7OMofZxNFMScwisKOvlj5VfCfR6F0lF7XqPCTxHfrQu1I7hHxW4Vz/kO8GDiXAHSmQ3LGXPhnTIBaW3JpmoGMJAEGsAjzRKQ1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947514; c=relaxed/simple;
	bh=SY8/xdNmTBFs+hRtElGs0fEpPvP4mpPRqbcLW2+4rcc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lOjW2H75c7KVBn3J4kyhYdPu2+Pyy7Mb1EXYCPJkYBGdcB7j6rpuzhK7rEuNgNS6cIWUtyr5iONyVtmORBGF5bKZo03iiXsafWcc3wG7aNP/80Bx0wJQjWB7MrjC2ZHmVFri/2b7H8f+6uilAlvCYtn2yt8gumslGZUs6Y3wD7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxvNK7iS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712947512; x=1744483512;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SY8/xdNmTBFs+hRtElGs0fEpPvP4mpPRqbcLW2+4rcc=;
  b=VxvNK7iSa+u81SGphNRfrf/hnd30PbC5i4tzhl1wYGFSMrdLIYn2xFW4
   We+SMcXztmzjHfD+a2evMLQV9yxxDjR1IzA17ZQvoi7f0TozQvHc+rh2R
   kfnX5rRo7sp+h1T+rgwU7N5smGHn2yIcdvoCFDeQSNgtyGRlFUZQU9VXF
   fSQrkwVQMzcv0YYmwWcqCnWEyumhSsjxuwp8djuYXvD3pix/thtCB7PL2
   pVCIlEh6eHboLI0SbMbeZn/ml2lDlkoNQFd1CKQOJxHdfQMOUJhFKH2fv
   TOwgxL/mMh4IR9Wf01MHXO/nlSxmPnLuEtc+6bKzQXDfJ6e9AxmIZUP8s
   A==;
X-CSE-ConnectionGUID: paXe2g20TRmODGp9wRzJkA==
X-CSE-MsgGUID: XVuJjf0kQzWg+pER/hFfkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8259249"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8259249"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:45:12 -0700
X-CSE-ConnectionGUID: vmwDGdFnRBmO6LAHz5cdyw==
X-CSE-MsgGUID: PRu/SFY6S4G/v3arRgykhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21380898"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 11:45:11 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 11:45:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 11:45:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 11:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9udD/rT7XTFfrbFvA9C7Fjga4GpkdamL3LEfPEPzV4tremuqIlx88dzcU5IsGGUVmuJbav/2XLofRrqWNZr5VJIiekuUFrAA8gQ7iFP1xwEgm5u2pMPQrwATD1BLJ/mtchqmA9XSUiWOnxD+QKs88Z+cftzVQNRfzFQbToMzyX6MV+uI54OHFss17VT6JJpcUrjgeTCTQvd6zOTF9JyVo5zlT5uVcnNwcPGcvmuVS3RVkNXNRjlkNwNJf0z8uPtUkNxutzRxqG4fxvawGY1j3m4C6ZJaCFa2dtbc6RFpm1nCl8b+6jApPegthRGDdvDDaFx4bGqFfVyHMksxhP2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTifzPkYEy6cdYiWDWKmWqo5IBmeOzCoM+9YdAYxtRQ=;
 b=Con/HEVwJW8Z3fZoEKnoiHTwNLgQIOTIcaJKxTCyAuwUoPtfzYONcKHDc6Cn6VkRu6aiGtDTl5qrEJlKImtEKfGTaz5d6EqLPZZuMIGsjP/c77MysJ5o0/IL5eCLhxWNUvpRUY3nuopVgM3/e1RL6tGH4ZjwC0z92v5fjn4iYcufER3qYm3+7yRuHnC+BrSsHt6L65tdp8y/IZcb2DfvAprNDXnwFJkx9CpGFr722j3Y0AsgU3+vj4pY40ywdnalNM+3cnwvQ+ZTW2tggTgiFMkcdWQqChxVhRVFpAJF2EqmlOlE29tam0gPq3DWEWLWi2zAD+PNpv+ad5jlGnqSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10)
 by SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Fri, 12 Apr
 2024 18:45:08 +0000
Received: from SA1PR11MB8279.namprd11.prod.outlook.com
 ([fe80::a196:98ba:164e:99f9]) by SA1PR11MB8279.namprd11.prod.outlook.com
 ([fe80::a196:98ba:164e:99f9%5]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 18:45:08 +0000
Message-ID: <9708f56f-dfe1-4425-abb8-dc7f1bdfd44d@intel.com>
Date: Fri, 12 Apr 2024 11:45:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] platform/x86/intel/ifs: trace: display batch num in
 hex
To: Jithu Joseph <jithu.joseph@intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<hdegoede@redhat.com>, <markgross@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<ashok.raj@intel.com>, <tony.luck@intel.com>, <rostedt@goodmis.org>,
	<ravi.v.shankar@intel.com>, <patches@lists.linux.dev>
References: <20240412172349.544064-1-jithu.joseph@intel.com>
 <20240412172349.544064-3-jithu.joseph@intel.com>
Content-Language: en-US
From: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
In-Reply-To: <20240412172349.544064-3-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To SA1PR11MB8279.namprd11.prod.outlook.com
 (2603:10b6:806:25c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8279:EE_|SJ0PR11MB4845:EE_
X-MS-Office365-Filtering-Correlation-Id: 1680aabc-d5af-49cd-8896-08dc5b20ad67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIlGmPtN/BGCh/HhBIibfuD9padXRQH41NoW02E3TPR+RwRElBjdhhTicLA5cDaqWUGILWYObvhH1aOxW2OVe4yud434BSbqYrRCp3cddzfNWNAIyylMA8wi9F9Ml8i956WRwjO+kbntQQvuFv45GRrvy7LZmVANn/xfudGCrR9l51s6Vyl/+xrZ7EZEH0gr4FPrC/66vhLUgLdx687swkZ8rnZLLacVolLSaNQeYjzKeNDi2+/hdERD5ax8ue89UqWPQeSBprAMuSK/ok3MeJxkDV+8q8JcW88KikPqFWMkuwbz0eiKq4YaYtbKKYw5+nxeQjNNAYPGfPwSIU7XAHtk2Oo8lIske+DkOUSbv4+II6YfiTtFKPaQp8pmQkBEn9rcKXTO/J2XQanMA6UGGlV9Q8LTivigYoOkyQ6eZI5LzZjBzlam95b+tOPiL3IjJ+UfrxiEF1OnvUjcxJ3klIJjI4Sw1yrv5BtpJCeN1a39EHRVsamx/168wwDzplzyO5RwdVVENnZkEHWJpX4ubrnmWsccE4UJCnWpVpKSkjle/OMcFSMZ+5zAiXlhpg2R0NB6x2IrPHoXa3EyBLHjJaN9tH7dcJq8mtLgnqr5TndKKMqFQWk6+3/sljwvqbTQ/TjQ8+1ClAzcv9z87WbkGOmnF5uG39JFsRDmVIu8ZnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8279.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXdYY25MeFdBNDRoenB1OVB6djBTZ3oreVQ0VDhuc2FhbThTVHBiZUNXWEtj?=
 =?utf-8?B?SThxenBxV3dGR0VVU0QxYStGbkRDMFF2SmJXbmx5ZUsxWEpNTHRFUERzeXJN?=
 =?utf-8?B?c3psMU1MaVZLaTVXQkJydDQwQnFTNkxnZ0ZxbCtvQlJ5WFpLMTFLZVFZeE00?=
 =?utf-8?B?Lyt3OUdoRGhsblZTcklNVkJqT1FUenhNeVh2TjVrSTUrSnhlb20xWmt4ODZ0?=
 =?utf-8?B?cE5KYWlUd2R2eHhiS3dSLzRkVFdsL1FsTThxWUllOTB4WEJnVlRkck56OW5O?=
 =?utf-8?B?RXpWMUU4OXJhY0tkTFhSdmdpaTcxUU1YT3BDVnBMT1VzQjZMNlorV3dSYit1?=
 =?utf-8?B?TE1veHJFRFFxeGwxZVhMVWZRRGJCdGhzSTF4TDlxMlJGMkpsM2d4Rm1iMWRr?=
 =?utf-8?B?b1ByY2JSdXF2enpydGhvSEhKN1hFU3BGR3grdkxqbUpaaFhqZHNSWVBSdVFm?=
 =?utf-8?B?ak9rVndHMVVMSVZhRHhFNGh6Wm1LMUpjbGM3QklMcnZwaXRZa0xkY0hNUk1W?=
 =?utf-8?B?SWJoWXhhblpNK3M0NU1RV1o5Y3RuWmQ3aDFRampDMXF2TGIySFRiRys1NEJE?=
 =?utf-8?B?bzhJU3BTcXVoMDlwa0pieDkzeGpnS0xzOExqNHVybGNUWEFUS2JjQmRnVVYz?=
 =?utf-8?B?R2ZZWCt1NFlWcEJ0dGlNOTBzNStIU1puSWp0Ujc0U2F3bFpWODRJb1FQaUNP?=
 =?utf-8?B?V2x4d2pnc3JjNm5NZS9vQ05IQ2o0NmdYUGl0dHE1NkxWbWpRMjA3bjNaMDhu?=
 =?utf-8?B?b2FzelFmdHY1U3lWOHdMS0h6MmVPS1R1OFFsUk5GQmFGeXFuRFl5KzlYS3dx?=
 =?utf-8?B?aG9zNFRFY3ZsVFMxdG9zczJQTzlUL2c4WXBURWVZNlFHaGJLaFg5YWo0U0w1?=
 =?utf-8?B?RTB6TjZYVTJiWTUybmNzbzc3ai9UUVhPc2FIcmxHeXpjb0MxSW1CcDNSNDE4?=
 =?utf-8?B?Sk9LT2lZNVc0ZGk3VTV2dDN2ZlJYQ2k3aUdGOWxuQ1lOZ2tYNEZuS3l3dGtz?=
 =?utf-8?B?elF1MXZqK1dYdkVxT2Z3V1RLN0JnRFNPdFRBZXgvRkMvUmlVbnNWZVhWWTc4?=
 =?utf-8?B?ZWYzOVo1L2NpRmJBbHBJeWZ0VlZjazQvYkhxNWg4RGFGbVRWRDlPZnhJUHJQ?=
 =?utf-8?B?MUF4MzI3c092cG9FZnR1eTFJWmFBa0NhMEVDM1dlbUU1dVZ2N2tCcnlEUmlU?=
 =?utf-8?B?NnRMSGVrWDZIZU9CTXk2akRZdjJLQURXdFNDT09mYWRYY2l3Y2VpNUxBaXp0?=
 =?utf-8?B?cVFsaXBNbWMvT0VEM0g5bFNidDRKSXhoalB1cGZ0YVF1R2w3M0FMUENiWVNL?=
 =?utf-8?B?emhNcGFRRFphcDlFUXBOL2dLclQvTVY0TkxNUjJOR3IzN2RhNlpPRXd5WnBp?=
 =?utf-8?B?K2hNbWZicnYvZWFkY2E2VG5wOFBkQ1BLS1FBS0VXRUtPMXY5aklLZEJpMDh1?=
 =?utf-8?B?VURiOVp0eXo4OHVBSkVpZ0ZZd2p2ZmlWeWNOcVZPQllsU1lWeFowOWIyY3VM?=
 =?utf-8?B?TVZEVU10WGJpUHgrbFBwaU9sbmYrSXhFQzdIVHdBbXRIWW51VzJHUDcxT2s3?=
 =?utf-8?B?UWJSb3pCSVZJR0lOWGRkZ3lNdDFUTDJLZHVaWDRjRk50bVhHSjJiN3FWSzhL?=
 =?utf-8?B?cjM0MG1abCtPWGxnRHpTaHFsd3pSdjg1LzFxNzd3djRNWmlhWWJMUWtJY1cv?=
 =?utf-8?B?d2NCS0xML3ZmcFk2QjNtTm4xb0grbUloS1BNU1BOMFN3YVpteDJKMFAwSUtu?=
 =?utf-8?B?dG5pV0laVUZGSnJQOXl4Q1dBNlMwb1MyOUJKazJLYTRXM1hVWWIrUk0rYXBj?=
 =?utf-8?B?amZZK1VYS1ZUUGtFa1BMbU5ja3F1MWRNcHpNV0cyRjgvd1lOOEFSQmhZOGZo?=
 =?utf-8?B?d25Zc0YwYmVTRURwSzNlaGk4RGVta0Q3c2NoQXk3ckxqdGVIcEFVeGN0QkM2?=
 =?utf-8?B?eTNIdkFnZU5pRjE2bkRBNnh6ZXU2Zk1JYmZ3d1I0QUhhcldJK0ttV2t1MzVr?=
 =?utf-8?B?eUVlcEQ5eTV3alhnOEgzQ3lWYzY2bldDeWFGYkYvSUluYzFYNXJkajJtZDVq?=
 =?utf-8?B?TUFwcDRvWlY1SXQzYW1CZkIweHByUUlseWlrTE9aSTR5VUN2cktDRkhaLzBj?=
 =?utf-8?B?aDMyTHFSLzhpc0pBQnB2ZGxqcXRrM1AycUUzL1J1MzlFc0lBMmo1YzBDSVhj?=
 =?utf-8?B?aE9mQmlKZFNONmRSZE1Bdk1xSGY3TzJvQXJ0elFYWkRFZGVIbno4Syt6a0VI?=
 =?utf-8?Q?1KKKJCsSgnCBKspvmfsuQIfsssk+rD+RmEbz3yRqTg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1680aabc-d5af-49cd-8896-08dc5b20ad67
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8279.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 18:45:08.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6c9Zr4/D647u0uu1s0qcH0ApmTwZJ3ggaNsLG394UQQHKKO00dEbhNwXfYmzdIhyXdnCM1CjB6Ued8cCLpDW6ijYCkNL6CVK38n8QibQKrGkBNg/RgYep6HsN9NwH+E0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4845
X-OriginatorOrg: intel.com


On 4/12/24 10:23 AM, Jithu Joseph wrote:
> In Field Scan test image files are named in ff-mm-ss-<batch02x>.scan
> format. Current trace output, prints the batch number in decimal format.
>
> Make it easier to correlate the trace line to a test image file by
> showing the batch number also in hex format.
>
> Add 0x prefix to all fields in the trace line to make the type explicit.
>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  include/trace/events/intel_ifs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
> index 8ce2de120f2d..0d88ebf2c980 100644
> --- a/include/trace/events/intel_ifs.h
> +++ b/include/trace/events/intel_ifs.h
> @@ -28,7 +28,7 @@ TRACE_EVENT(ifs_status,
>  		__entry->status	= status;
>  	),
>  
> -	TP_printk("batch: %.2d, start: %.4x, stop: %.4x, status: %.16llx",
> +	TP_printk("batch: 0x%.2x, start: 0x%.4x, stop: 0x%.4x, status: 0x%.16llx",
>  		__entry->batch,
>  		__entry->start,
>  		__entry->stop,

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


