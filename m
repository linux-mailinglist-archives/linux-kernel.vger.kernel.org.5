Return-Path: <linux-kernel+bounces-148387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02E8A81D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2188B1F21C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7D513C8FB;
	Wed, 17 Apr 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0ViFcA7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDADC13C80B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352522; cv=fail; b=qP2zp/h5olptAqJ1lT58gjwAjTrtcZ061ZUkUJukEqnUndYaFyvZKWk48Vq5fLqjm+Askp+FxvUq/64InsQ8GZ9tG0UQl2Jgbnxbb11bIZEQINa4V+PsLXiGMR4e7Qii7xngU869BgXFnjJ3Ry5Xm4fuc56H3Scboe1ggsboUK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352522; c=relaxed/simple;
	bh=/B295foRQ8orm+eOcAfijbrLafhBsZvGKTdWcmMkC84=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cnOwDmv4Azi2qDN+XqlgAw3NR5J+ga+jI3FDwn5KgZY6joeogYkMlup3AE+JKFS7A76eyAC4MPAwVPcrLhuW0Bt9UdzSeTXu1yEqy2y1BYe/vcq88j4QAFhNRJonP8vJ1UF/IIMho6g47v+1aMKGkI+XoY9E/g0EFqNeCsIoZDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0ViFcA7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713352521; x=1744888521;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/B295foRQ8orm+eOcAfijbrLafhBsZvGKTdWcmMkC84=;
  b=X0ViFcA7zHAQAxjAk/oIScFwA05FSX070gGmYZEquHIoGVjUUHLFC+lR
   FcLQ1pH+2ptmB+M/2CdhVhmiE4NSLZBgjBBwSPslT5GBSKe/Bd21bcsf3
   mWatlR44h9m+DOl+/FOEjZRyaQj6dDXLeXuRzS5eZf0e9cjjm7Jmjgmne
   U2UK1MSaiJ7K90xLSBmevSltAxwiFxmx+rWR6i1zJ3lMa8U0USYC6MAj4
   ul0dM8+MQBT4nHpIitDo4dc8Y+GQwGLVhm++nJMfdBDSudMdVq3a+4C9Q
   n42McpFGMSsZR7Nj2njSe+dZkpo1fsb5SmkTsU/uNiZ+iInQkzwUjy210
   Q==;
X-CSE-ConnectionGUID: aKEQUuytTZeqj98erdMw2A==
X-CSE-MsgGUID: cqWmGxyMTbiRdGIgF2pWSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20257564"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="20257564"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:15:20 -0700
X-CSE-ConnectionGUID: nFFRJ9ASRUG/L2cRKqVl7g==
X-CSE-MsgGUID: UikDofdWTqWHi/DDrZHlpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22651817"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 04:15:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 04:15:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 04:15:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 04:15:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 04:15:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7b7nH+1hAG+3rDa51iG0W5D8hF/vAdmlhJk3QVaOVZJm6qodt9NxJdNy19Bw8A/ZcOnr/nSEHuwVLNOg7OpwJ/UXsKId1z6SrLdRAYy1nR86/BPBJj/J6kSIczO73Nd0h4xu++N94BQTswW8JT6VepLwAI0dd6slxiJPKQ0PtnD5s4ipXhJ3Db0gdkRHzenHBR4981h3UW6pHivfssXf/sl4FOam11d0rlwflwtuyL72DrieU5LQ10MsZtWxAQHnZIHF7KAEHYziptJvsayDVvV63+SrePjFpwQ7Qy8EVWXuBnC69TrpjoD1aFs7gsT/jeecQPepfgMqZB1q9OQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWvw7x065g1aGjLDu1F5cJq+V2oMcTi+oXedhQHUYkQ=;
 b=QLntx+uzvtoOdPl0BGo5CsY/W0D9cLHjpM+ZYDsZEOZOcJLT1kA/kArkIZQ+K/yk55kmJYOJzhjhrF0ImxfAEmDlHt5OMT+KIjDij9RFukee7K2ey4W4yyJKPKRU2EwVydA97teKEx2NrYnkQslhMcxM0KudyMdyn7d1Sr5MScnxxQKlcUgRF0nlVfjJ+h79o7JNHOUTFe+vtNELN1spOdyEJ+qbpLE9St6NV4S1pDOxDELujlRuuCRZGDeZ13Z8dIwo3ffimj9ApCLiMof6V/FPaBCY+z9K9zCAjor6dm3LF/K7HBYheoHAHEsiEONS00c3IIyP5qWQMJ/yMgWM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Wed, 17 Apr
 2024 11:15:16 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 11:15:16 +0000
Message-ID: <186b252f-e37e-4152-b6c7-6fc3754f3b16@intel.com>
Date: Wed, 17 Apr 2024 13:15:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6193:12:
 warning: stack frame size (3368) exceeds limit (2048) in
 'dml_core_mode_support'
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, Yujie Liu
	<yujie.liu@intel.com>
CC: "Zhuo, Lillian" <Qingqing.Zhuo@amd.com>, kernel test robot
	<lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
	"Li, Roman" <Roman.Li@amd.com>
References: <202311200955.pmjdQEM1-lkp@intel.com>
 <a856cbeb-dd2e-436b-a7f2-74d3493df18e@intel.com>
 <PH7PR12MB583196EB28781C92A00970C1FB462@PH7PR12MB5831.namprd12.prod.outlook.com>
 <CH0PR12MB52845186C7D747A4547DA99A8B462@CH0PR12MB5284.namprd12.prod.outlook.com>
 <ZcL0cH1LZteapnTG@yujie-X299>
 <90138eb3-6203-4b89-b075-d0d6fd5207f7@intel.com>
 <CH0PR12MB5284F7B96B16E8F86E4740CD8B452@CH0PR12MB5284.namprd12.prod.outlook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CH0PR12MB5284F7B96B16E8F86E4740CD8B452@CH0PR12MB5284.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 6671f710-0c81-405b-937d-08dc5ecfa88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZzCy9YlcI/cv17vLgVYlR6+fm9D9UjcuDAmoKkqlfxOfBoLZzn5sW75NTIebWohG+x/FozTMQMpLvA64rZExQwtN0Ws05FbQmXOlHiRvGSS9ywt1fSQWsacmryYoMHwmJxTWEiMvfc9T0ThHP35f1LcCZ09Ad6N4aWefNfUEVcq2WSLJ743wlXPQg1y6GnXyqcgAJkEAYv+SeiIDgJiVajhbdhV9I3LzFqFWeg/f/eElTNCu39xn6N8+q6OKDEsuZGm+xU66zQzmKD/YbwBREAdcnTE8OG4O+G0P5Th8RinTxnGhBvhsq4lcYtpfRfJattNZYhCeoOaKMhyj6bUXbpP0NyLSSOEVymRZCTziW04DiJt69Cns34hLQpeba6oLDTWuQjnJmD5czI0i+At2P2QM1fkwP7GFxzW5L2PP3zt60+tNp9D8CUp/TV2QRAFL2CpMVmRYdiKyIeRRUiMirYBaB5PKLW0mzZtBOr1vrkIbkbv8WR9S8FFdDc1sH0BNadeN4uTROvHDWqH+kQbHE+3QMxr3daexNX/z2PpNqf2+eGQUhyMrT5B68nJyaxEMGEp60Mi6nFISBwCSHgFpHf4RKLg/kUq/5SsHL5Hws6uZYcqR1wgROevGc1jAxPYdcjh5pEdx8rE00GRQA6mkvrwZnc8zzL+jOhX0kMBXZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2Y3QVRDMENCai81T0NtOTNCV0wwOVk1c2R0ZVVCT2ZoaklxNkg3VHZCVTRF?=
 =?utf-8?B?bnpQUVNkRjdabVA2UFBkTEl2alhlTlZIQVRFdlZ6ZUZiK3EyRUR5NGJyNUkz?=
 =?utf-8?B?b1RWSVJmbXVGdFlKRWROa2E1bEVlVWJ3bkdUNGR4dXozTFdML2JhUjRHaXc2?=
 =?utf-8?B?UjBkcFZrcHFiUmNHcnIyYUVOTnEvNWQ1UUs4ZHovdEFGY1VBK0VXN003VFRV?=
 =?utf-8?B?VE45VEU1b3gwbkplVEVxNTV0d3h6ak5FTmptcVdlT0pyVVVKdHE4dkFFYmNZ?=
 =?utf-8?B?cmdyT3VYUzZMZjhkU21OOFFyVXRlU2NyUnlBOGppRUxSSXRFcE55L3MvcDBR?=
 =?utf-8?B?TnNwSWIrMDA0QmRCWmk3eUNRbXZ1dllJZ0VyN1FTY1I1eS9ubXJnNFNZT0Ji?=
 =?utf-8?B?NFVxbXdVSU9jaDlRTHJnK1NLZnBwMDZLOG5iMjJrbERWbUFxbE1WamhFWDgy?=
 =?utf-8?B?MnhjUUdTWVBjVmM3Tlk3L09jMUFSWlAzaXhXTGZHOE1CLzBVNFJZK2xhSjhx?=
 =?utf-8?B?WEVUZ200TTVpT2U2ZmZIclh4bktld21vTXBLZ3JFTjluOW5aWTBNZzRyRDVR?=
 =?utf-8?B?dXFBZkF0cTJ5RkFDeFU2N3lDdVkzQU1oVXcvdWxEM3RxMldzNEdlQldVSDVQ?=
 =?utf-8?B?WHlhb2JyMXpLT3NjODZnVlFTK0wyTWdQQmkwQmdkRkFROHlwUHh5RDl1OFlr?=
 =?utf-8?B?MldrSnNJNGFqS2wyd1FyK1RtY05CaDRxS3Q5RGd2WUZlUmZNNzJiSlhldnRj?=
 =?utf-8?B?dThoRUpNTTJtTEhyYWNKNDEvOXpydEptOFJST0VtbkdJVkMvc1VlZHQ3UVdF?=
 =?utf-8?B?UDdWVmhJYWMvb0FYSllvMy81enJoSHlWZmY3T0FISFNGRmNGVHRVRGdrMW4z?=
 =?utf-8?B?dnRKSVVQRTlhNzNVbVNTLzhGMDY3bzkvemlQUkwvMWRkU2IyOW9lN2dGQi91?=
 =?utf-8?B?dHlwV1BQazZRSW5ybmdEd00yNGdySTlOOXkwM0RXSmtiRVd5VWFoUlNxcUtO?=
 =?utf-8?B?TEJLZmRTQlNqc2poVG1yQklqWEJPUGlNU0V5bUUxRElHQ0R6RnFGVWJudzNQ?=
 =?utf-8?B?d1VmYWVDaWdYUjRIdTVYZ3Z0NXlpKzdiVzRRdDZCcmJHd3Y5aW5zOUVtdEtB?=
 =?utf-8?B?SUdJdlJqZ3RqYkd3clpha0xvaWRkdmZXZGF5eFdpdDRqT2J0d001dzdCbWww?=
 =?utf-8?B?b3FiY2x4U3dXUU5JSGtqWlVib1N5Z3NUUUN0NzZxQUlwNGhUZk5ZVmJ2NTla?=
 =?utf-8?B?dHlWY002M3ZzeHJGT1hxM2JxSVVSTVdWcWVVQjhiYVAycFl4bFRqQWZyV2c5?=
 =?utf-8?B?SXVVTnhiaEJKSUVnZ2ZmZ1hxS3Q4NVBxZ00vUDlXVjQ1QS9PMCsyUmpwWTg4?=
 =?utf-8?B?bmREQlpRTVNvTUJXQ2xlN1dZWTQ2NUMzUk5zalV4QnlTVjlSUkZ4SHlXa0t4?=
 =?utf-8?B?S002bXBBMnppelBVM1piTTdpMkhqV1M2bEM2ZVlmQkxGcnY2WWJKVnJYMFJq?=
 =?utf-8?B?VTB0WGducHVnaU43Y2ZNTGNCdGZ4eGlta3JXeWYzci9xS1lpYU5GazVSTkhm?=
 =?utf-8?B?QlYvVWh2ZG5JSmNJQXo3ZTk4Yk5oMHRMWm5MY29Mclg5KzEyOGw0ZklmT1Jr?=
 =?utf-8?B?TE16THU5QUhBM2ZwOUFzMnN6dFRLYTVjYm4vSDcvcTRFU1lKamhXaWFLSE1F?=
 =?utf-8?B?WVlHL2NVVEhCaURuWVczSXZ6bW1oa3VRMVVDdzMzSlpTWWVXWWdlbjdqYWtP?=
 =?utf-8?B?ek9ZVlF3N1liaTBLNFdIWm13cG9Zamo1M2JQditNRWtMZnFmc0tnWUppRGlu?=
 =?utf-8?B?WUxSUmhqejM3STF3eHlQdWZCMXVkakl2dzZuNjg2cTNIS3gwT0xFeUZZdWlR?=
 =?utf-8?B?NXdxV1JYR3hYQ2pOQlFkc2VHY0NUb0c2VjJTY0EzOGNCL3EvSmtRaExSZlpx?=
 =?utf-8?B?elJmU09tOWVhOHJ4eWRndWhYQ1R1YWlzVEtIMm0rUXo1aWk3djR4YjlQVWsw?=
 =?utf-8?B?RDA5MGV2WkVhUVZyREU4V0NPbXFrY0xYUjU1Q1dPQVA5NmdLendEbEdpOHdE?=
 =?utf-8?B?MFlQdDJWZU1oNkUraWo2a1p2Z3lsMUpPTndiVDFVYXVmWEMybjRkUW5JcUdq?=
 =?utf-8?B?NXJCL2RiaUo2cHgyajZhY3hxV3g4WUZZQ3crR2VacGVZTnRaOWFHVGFiYWkv?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6671f710-0c81-405b-937d-08dc5ecfa88a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 11:15:16.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4rDvF/Nd6cBu2mjWf8WHqtQuECmF3Y9RLrvE3+e7+ky29O8FaqlhlQPfi5nbUKVWJ7VYjS+tlFZjkpEN517QVkH01ARcE9Q/G/3/KGq9/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7736
X-OriginatorOrg: intel.com

From: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
Date: Wed, 7 Feb 2024 16:09:27 +0000

> [AMD Official Use Only - General]
> 
> 
> Thank you all,  I'm able to repro the issue and I have a fix. I'll have
> it run through the internal CI and send it out.

I'm facing it again on the latest -rc4 and Clang 19 (the latest master Git):

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6710:12:
warning: stack frame size (2128) exceeds limit (2048) in
'dml_core_mode_support' [-Wframe-larger-than]
 6710 | dml_bool_t dml_core_mode_support(struct display_mode_lib_st
*mode_lib)
      |            ^
1 warning generated.

Please fix it once and forever somehow, don't abuse the stack =\

Thanks,
Olek

