Return-Path: <linux-kernel+bounces-138554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8694389F34A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B3EDB2496D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D518115B990;
	Wed, 10 Apr 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dq3ebnK2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9EF158DA7;
	Wed, 10 Apr 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754105; cv=fail; b=loAYxs4WkAB9/F4wfklW8npI55wDenG6ejBQGy9qbWn8KtXJua3pGXMAV2BIUC2bTf65zjJbEI+AJCRKDPROrw5WiAPqwB1y3oYY9E9NuiPVUMl3Xh6ujBuFSPP4Da4rmkAepIxZvEYaSgyjJNof82DaViADoHD/FEFL13oL4cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754105; c=relaxed/simple;
	bh=qgHuLOyx7MWIf58FxJo1rF1v8NPdIl3CEsuN4Q8dsyw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=deU6MT8LC7giCayyX2l7sPmdQsrBSQIy4OdpmUZemL7gJokmR5Jtv067SeIpQ399EJitWEnNap2VHsko0MDFt2LoCdlFnuIy334UX+3YPgeDvmEUJ7u/xSg5aF0sjWxLXIL4KDpEzg6CEk1xuAu+N/qhbYMlzDu8rWwR3+NqhZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dq3ebnK2; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712754103; x=1744290103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qgHuLOyx7MWIf58FxJo1rF1v8NPdIl3CEsuN4Q8dsyw=;
  b=dq3ebnK27JqXx/rhhp1veC0i8tcr/SvR44YRAcT37oeu8i4pjY2GsukY
   qt9qXEI8aqkMV8Cn1DUiEssmwi5160RtZ432fe+NVKb2gWrQCJXQgMNJL
   a1KROv/xefnRfGPNHPhESb/+fZgfVeMyhoJFhQ4DmvwNMibF3gouMXc6h
   KhxJyfkj0mTogCe6ENKIXUI5dyuaHHC8dps+kA0/q2VB/Lr8G/R/Pb9IP
   HmfSL4qrNV8YR1jSOAISLEO+qH8NssuPZB4eb313ekbOuXJHDXfLPGvUN
   S4FS1Aw1H4uxKnZU0U05hSb4/2LlzWMBukQvvud92Gr+sgP+tJLMQG9wM
   g==;
X-CSE-ConnectionGUID: QywNCTH+SsmA11DEMTE8zQ==
X-CSE-MsgGUID: pmS0IEA/T1iFZpxL7s5l8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11951003"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11951003"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:01:42 -0700
X-CSE-ConnectionGUID: WGZLhib6SpqaZMpu5rlw+g==
X-CSE-MsgGUID: VDnf34/SRLGaF7rsKxvbYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25178630"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 06:01:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 06:01:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 06:01:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 06:01:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 06:01:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH5Shuv3yJcYV5EyKmeePkUaWLzB6bBXPkPTiEhAXDkxQa9F+PWGJcVYEhYc5TOUFBDeRLVUu/IClm/Szaqj2POHyCH30Fkq7sGPVzYQCFkICCC7w/KAGOABpf4CNmuw/p2ACK5Owd9+8Mfnp6BTlz8m0zrLiA35/yKJJSS+I32tDGIaNTTS4r3QdqlEinIkZv0by3476iFSU23KKGGveCD5pdUp+Q4vvxecRS9QCkC+PFK/xaqMhxTyfbn2PviGH2gEXxvLt7G+eK/9XJ2pSuqlYQn4YvevbcZyMGnXjmlI+oGAMRDWsOjEYuwP//I6EoPPFcz6IIf+Pjd6ClY7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4cMIj+EqcCItM+efIRhnECUaWO7hZIbwpsxGS6pdU8=;
 b=c4Ia/3OLjeefKPAeNlvphgeJAENu+KcsyEPmE6Fwq0GsPBeTpcgXxULLnqrMhGBOur/uLzCKQAn6dy/Iy6awYs6WEG0+9Lx2bXQEnHPafDQrfEkFTozA2mL5QpZJAOin9pQYlBsqoPBkjMlx93+UEhkXJoTjtkKh2dHWWJMG5KCcZw3rWMKmyyEgQayJiO1ReLU6vS3xE2MwRczuuex3ETsf1x6yvsPxQJ0NDOdaL9MDSy7d8HGgbmyN6klSVSMsE/ctKIEikcabsUgseFlTNc8z4LZ7XUyBF3M6Ro62AUZ/TsGUOEHKWFpMCFcZ8bqChTq0FlU9WSff+N6jB2swnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB6753.namprd11.prod.outlook.com (2603:10b6:510:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 10 Apr
 2024 13:01:38 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf%5]) with mapi id 15.20.7430.045; Wed, 10 Apr 2024
 13:01:38 +0000
Message-ID: <61a952aa-1b3e-43c7-9f35-ab53e492305a@intel.com>
Date: Wed, 10 Apr 2024 15:01:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 7/9] libeth: add Rx buffer management
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexander Duyck <alexanderduyck@fb.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Christoph Lameter <cl@linux.com>,
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240404154402.3581254-1-aleksander.lobakin@intel.com>
 <20240404154402.3581254-8-aleksander.lobakin@intel.com>
 <45eb2bf1-e7b0-4045-82b3-93b9f81b7988@intel.com>
 <bebf1a1a-e4ec-4ec0-9d01-57a51bcf14ca@intel.com>
 <9d389192-63c4-44e8-b863-6323b45aec0f@intel.com>
 <36a067fa-75c0-4e7d-b704-229deea2d440@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <36a067fa-75c0-4e7d-b704-229deea2d440@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR02CA0018.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::23) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB6753:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K56s2h5XiN+caFpM69Bc+qJkuMALOYtc74NjQfMuHTC1nf2+Myky9n2Uj5zP3/vpl9Wsn5XRoHMEW58Gl3d33TU25sINqwbKBDVeXFxBfdHQspvA7aG5RdlDS96JO6kKCbTUhBxmkaaA5lG3Tbnx+vb1UoY2K7jOdgz+AGxHZP0Rot8ib5SaSJlHJdSuprfsk1UnYqEOHoYzl/7UFs5LTWu2hv5J2XDQpbLlCt8j6WNW/a+k/0MmCRs9cpWeWweuODQCPPckD6OI3ySruSWmxu+U6hMqgN55LRrJzo29UDv+I8Ad9xJtV9SZzjWyrm8qr5/qvfGoElmjSKBfOXqIcnYxzMc6idqBDQ6d0uhtmwXOFaAQtONHX3/aCdCVPYZJOZ+YS+2ZCB9V343z+J/W0iXOCjUjK+qQ2YJfu/M92LhPYNNlaDHoooXda9ojDc5ADLQcIG9p43SLCDnTsFtuiDevLWewyLuc2lgJIjPeSuWuHV9THr3Ar6jxziG6nRBIz6RgQvqAlVHHm4rtxbKEtUnVggbVQc1f1JZquHZNA6KDrg6HHwoZaP3SoMF/038R85Jgsc8K9KJw/M6Re5js6jxrMt9yYg0Xjk4eY7Nsbu/CrevG9l39ouo8AXVJE9JrUYNQ/ouT0Xe0krBtTUxMvZYFGxyhK1dNyPJjRJ6K8kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWpnZXFJeUhTTXJramNhWXVkN2FCSVJSaGl1VlVrWUdMa2xwY3VlSkVqRitq?=
 =?utf-8?B?NlZobDA4eXR3VHh6cUEyeFBSTnVlY3NCNmZpV1huWDFvNWQ4VE9pZldwYzZQ?=
 =?utf-8?B?bTFoNlI5aisybGo4VEpQYUxZUVFLRC9na3B3aDdjRDVQQThrK0pmQkd1UnlP?=
 =?utf-8?B?TDJlS0JhSHZYM3ZhZXNoNWZFTVR2TlFSM2RNMkJLWmh3Sm9jTWErckRubVYz?=
 =?utf-8?B?WjYyckQ2dnlFVTJnZzV6aG5YSFh5QUNPRlN3SW83U2didWhWUEQ5QVJuY08w?=
 =?utf-8?B?RlExKzdRazN1SHFTelkxelQxUHg3eHJ2N1J2aFlWb1lMQ2pyRXNXMmFiNVRj?=
 =?utf-8?B?aWpqTThuZko4elFJMnhrR2VrVVBZZjNRblVjZ3N6aVdmNndsTjM4WHVZSnBo?=
 =?utf-8?B?eEZWZElZcXhFTzdScTFzWmtuOTBKdzRacEdnVmd2SEJ0TTd4eG96ZEk2U2tq?=
 =?utf-8?B?QmhkdGdGQ1FON010bnFvZ3dBQ2NSNUtzQVRPd1VMQTFrMGR3ZWl5S2ErK2dB?=
 =?utf-8?B?QkFMQzBvMjRaSy85Q1ZtdkJ5U1NGS0xOOG1xMTdMS0JHQndzU3QvSU9xWXN5?=
 =?utf-8?B?TlozekprKzgrbmpLWVdCbEJhRWhaUVluSFVtdHp1RzhEY1RqWVErUENYQkRJ?=
 =?utf-8?B?OHdBYTBDaTRlUWFrTitmeTJXcFdTR2xNUkpXM3daL0NHU29wMHFMZXhlQjlt?=
 =?utf-8?B?aTZvWVZTcElHaklHZ2JpYmR3dnFWZ3JDdVkra05hS1hWalVsclBXby94UnNG?=
 =?utf-8?B?SDdpRU5UL2IzajUrOGpZYkpEdWVhR1FvQlNTRjB0MXh0Z09UbTN2SFNVd3h6?=
 =?utf-8?B?RGh0ZWkrUWFjcndRZnBFTnA5ckdFV3lZMlpISTlhSk9yL3dTYnM3SkRzemE3?=
 =?utf-8?B?NHNQcm10U1RJcUVBTEphTVhuNUkzbFlhZ2NXS0NVZkdNNlN0NzduNWtxK2hS?=
 =?utf-8?B?RkVIQlFrOFlDY0c2U2lzN2ZpaEFFOGcwOEJwMGlUclRoR3BTank2amdTeU1z?=
 =?utf-8?B?a09lOW5LVERoL0llU2xRR1pwME43ZThtNkwvRkROaExwOTE0WXpGVVRmeitt?=
 =?utf-8?B?NlJrY3o3L2FNbTVBSUtaRnFzQzh5bFpFVzJ6UkI0ZE5USnZyM3NDMkt6VWNo?=
 =?utf-8?B?ZWtsWVpBN21FQ0hZYTlXcW96VWYxcklWdU5BUXdjN0RlWGUwTlRYTG5rdzhY?=
 =?utf-8?B?MVEwS3JMRkZiVFg0QnduaFd3dUJFK3pkYm1ZakhnMEVjK2o0VExUVzhXM3h5?=
 =?utf-8?B?NW9CNUhKejBEODErS0V2V3UxY1BiYUhwU1VNVmduWWxWWVY5U2hJaU02anR0?=
 =?utf-8?B?VWFrQUpFcEYweklLc0ptdlNmbjVIOG04L3QyVURaazEzL29ueE9YMndvWkxw?=
 =?utf-8?B?ZXJMM3B1bnBybG1FQjIrb05PUjRia0VHdXpBanRCbUpFWWtsRmtwa3pVRUto?=
 =?utf-8?B?TDR4SGRyYWhOOUR2bmhyYS9CZjY1aVdyNEdYaG42TmM5aFNlNTNNS0xvT0gv?=
 =?utf-8?B?M3FTdHZGVnFiRVBNTSthdWFPMFJhMGxYUnVLdTBCNjFGVllON1hZKzMyRmRX?=
 =?utf-8?B?TEsyaWlGSEc0VVRicUg3ajVIRldCRWdtS2lMVkVYTHZSWEFKK0ZZUFJQM0p2?=
 =?utf-8?B?RUIxRkIwRmovS0lBWUdNYmFCZ2R2dlp1VnpXQ3JwellZcWtQOWc3UTBYV3dW?=
 =?utf-8?B?bFcxWGhRdXhCQlEwSlg1UkpuQ1ZNR2wxZ1djMkhHbDQ2NjAwa2p5YUt3RXNw?=
 =?utf-8?B?bTZzRHBhbFBRaTNPMytOaEg5UEoyditSMzBBTVVmVjUxT21YODVOekxhQ0lO?=
 =?utf-8?B?L2w5djUyYzc5L0pRVFJKRTlPVHV5UGNoYm01UkxoSUY0VVk4bnFoSy91ZmNa?=
 =?utf-8?B?REp6Qm5YSXVXU2JXVDNZbWRKeHdrSTdvSFlIczdKM3Z5eDlhd0llQWVKb2Nl?=
 =?utf-8?B?NlpUSERXWjJuRk0zZ0NEVGRjcWRtRURXcE9teE40MDRtS2I5eUowckZYbWtk?=
 =?utf-8?B?MjJZUXhVNlV5SnNFbmxYVUt4NkU4bFZMUzFNVEwzUDdSVTVrVTdvWTMyc2dP?=
 =?utf-8?B?b1JjZVR4RUhJL2NtcG9GcnZSMTN0OTRTL0gva25TamFuNHF4enRuUXRWV0RO?=
 =?utf-8?B?R3NMb0dpaWFLdGpxMG5VWFBNMlhORlJhc2pBa3AzNUhGZHBvcFNGOXVuQk9x?=
 =?utf-8?Q?OA8ZCDyB2PoAVZXhuiyRXr4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6716eec-4b81-45c7-26cc-08dc595e5bd4
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 13:01:38.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMY4kpeJTN2eqze3mcoMWhsVKrFyKyaQszj1ytoFZ0K5sKWpQ1Hh4JVoEsstmbBEnDlZIHONmEg4+eWSWVCQn0hkNW2Iqh9U66Im8hSPMqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6753
X-OriginatorOrg: intel.com

On 4/10/24 13:49, Alexander Lobakin wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Date: Tue, 9 Apr 2024 12:58:33 +0200
> 
>> On 4/8/24 11:09, Alexander Lobakin wrote:
>>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> Date: Fri, 5 Apr 2024 12:32:55 +0200
>>>
>>>> On 4/4/24 17:44, Alexander Lobakin wrote:
>>>>> Add a couple intuitive helpers to hide Rx buffer implementation details
>>>
>>> [...]
>>>
>>>>> +struct libeth_fqe {
>>>>> +    struct page        *page;
>>>>> +    u32            offset;
>>>>> +    u32            truesize;
>>>>> +} __aligned_largest;
>>>>> +
>>>>> +/**
>>>>> + * struct libeth_fq - structure representing a buffer queue
>>>>> + * @fp: hotpath part of the structure
>>>>> + * @pp: &page_pool for buffer management
>>>>> + * @fqes: array of Rx buffers
>>>>> + * @truesize: size to allocate per buffer, w/overhead
>>>>> + * @count: number of descriptors/buffers the queue has
>>>>> + * @buf_len: HW-writeable length per each buffer
>>>>> + * @nid: ID of the closest NUMA node with memory
>>>>> + */
>>>>> +struct libeth_fq {
>>>>> +    struct_group_tagged(libeth_fq_fp, fp,
>>>>> +        struct page_pool    *pp;
>>>>> +        struct libeth_fqe    *fqes;
>>>>> +
>>>>> +        u32            truesize;
>>>>> +        u32            count;
>>>>> +    );
>>>>> +
>>>>> +    /* Cold fields */
>>>>> +    u32            buf_len;
>>>>> +    int            nid;
>>>>> +};
>>>>
>>>> [...]
>>>>
>>>> Could you please unpack the meaning of `fq` and `fqe` acronyms here?
>>>
>>> Rx:
>>>
>>> RQ -- receive queue, on which you get Rx DMA complete descriptors
>>> FQ -- fill queue, the one you fill with free buffers
>>>     FQE -- fill queue element, i.e. smth like "iavf_rx_buffer" or whatever
>>>
>>> Tx:
>>>
>>> SQ -- send queue, the one you fill with buffers to transmit
>>>     SQE -- send queue element, i.e. "iavf_tx_buffer"
>>> CQ -- completion queue, on which you get Tx DMA complete descriptors
>>>
>>> XDPSQ, XSkRQ etc. -- same as above, but for XDP / XSk
>>>
>>> I know that rxq, txq, bufq, complq is more common since it's been used
>>> for years, but I like these "new" ones more :>
>>>
>>
>> Thank you, that sounds right. If you happen to sent v10, a bit of code
>> comment with this info would be useful ;)
> 
> The current kdoc in front of each struct and function declaration is not
> enough? :D
> 
> Thanks,
> Olek

I've asked my initial question just after reading it thrice, without
your reply `FQE` was as meaningful as `ABC`

