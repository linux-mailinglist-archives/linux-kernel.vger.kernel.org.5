Return-Path: <linux-kernel+bounces-145969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EDF8A5DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750B31C226DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FA5157A76;
	Mon, 15 Apr 2024 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6D3XiDe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950925601;
	Mon, 15 Apr 2024 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713219389; cv=fail; b=p6UfOPCixjfAg5Wyp5xDtzATlVhF4gFCzNFocg+VoC8nZT0uO62BC2SCW1vYzVaSgLmr8fWJAFEZ0tnqRhm92Wo9b0C1c9RqJBL2WrxY0r5bEBNe6S2RUBWyB79ZIHqW+jNOE9uLG4+1XQZtdmpz5eJWp/42f+W1my9B7nbkZuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713219389; c=relaxed/simple;
	bh=GVUxNhHv7hRyYTdnvVleGIBH7ufw5rUB8B/fHheYdBk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jgp9bSJp1snojvlX8T/u8sC1gze4BBhhdgDl/i3K0z6lfJsMG0WKgflbq1edf3UgwRYa1hv3Ipu/qtqio+/jVdt+qMirN+Z/zX8gZ6cQKqf/w7rotup+wf0KiY0uKgnXg2U9k4woFh0yleHodFZQbumEZszEwxBKUqN38I8qTj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6D3XiDe; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713219388; x=1744755388;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GVUxNhHv7hRyYTdnvVleGIBH7ufw5rUB8B/fHheYdBk=;
  b=T6D3XiDeH1FlS16XCEwKl1/JMXjEuRz5vROseFoiEdv7oT3XTdyVPyK9
   8IgxoJGJH+Ve5A9m9LvHe0ysYL3yDK2Sh2kZD8kW+ahuzkGaBVA8uC8nB
   goifdEDqND41eFfBapofjjBUf7Fsbz5T3XFvm2t8ezUcv3b9S10MyfUJZ
   RjvdjeEIGhLcug407h3OAdGV2biERTKye5jl+vEpDllrbx+l6gTW3OuoR
   hyQpdztRKQUY0YGWmdfCbbY2M5heM4S/sI1wrvAZ5wPwpZ4ub6opBq3ug
   Ch1ETylASXhrvdGKp5wXOuiGZvQ9uh4HkLxUG1PIDJajBXicvsPQpe6ph
   w==;
X-CSE-ConnectionGUID: IHoQ+lXFSNaGUPfghr/u7g==
X-CSE-MsgGUID: nCHysr1rQIiCnAgkKn+bdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8739221"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8739221"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 15:16:28 -0700
X-CSE-ConnectionGUID: mdEvMWO5RHqH4Kgs1qQDWQ==
X-CSE-MsgGUID: b4Efsu3KTCSCzhwJQ8R2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="26719271"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 15:16:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 15:16:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 15:16:25 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 15:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDzJnOczp7N4csUw0MInGmK2Vc82x7s8XHJ8AmQIv49pj0Jy1iodGlTn8XDTAVEjcY2z2L5pwfphE4qR91B/vaJCJDeHYhSbYLaSKwn/SwTdZuSpnhyZptRN3Zj6h65JzK4h9AiO20IubzCrzGfvuf9uTzvrcPIBYAWpsVoOQt0L1gA797bi7hdZab1cBNcJMtpzXsNYw4bLys3SiNApaiVg/j78+egl9GOQWytQTTrnUgYkzfd2XMXO2bDeZMEFUKqIYF+CZCiJah7uzrXBXCcVqHDpIDU3hAO3/ek9uac404yCw9Z50mdC8ixGqhRt9RObRtt3qTiAf6J+wuz/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuLky1K2ABpLJjE36R0X1tOgPbjdrpD+CrmBLTTwjg8=;
 b=ZP6BxuZQPZz7CUJqxOFtktveHRmVhowPvzv6ebNvzHYcIK5AHPK0ZM/drtA6wXMOiwNou0uxAnN+4rfJ53cDqzb79FuJSlTQdnjjV9IQIoRRRv/SdVhvPGpGlLxd/4A+ayb+Eqcxk6Wo8PLYr7RFNzr0FbxN0r+f9OCtlzvbaSxgYZweXo8HR1LZOD+1YNvZA9uFit75SumlVBShGXD+q9OoWHY6IHB+uikGs+ehzXRxkR7fS6hzgyXF7Qize3fcuDy+VQ+s362NvDjbE6QzUWj1vI02m7g19JmOq/yNdsm96Rs6OA2274nM3FnJSSdOjJ2heHcW6v1yPAP8tPm3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by PH0PR11MB4983.namprd11.prod.outlook.com (2603:10b6:510:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 15 Apr
 2024 22:16:22 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7472.027; Mon, 15 Apr 2024
 22:16:22 +0000
Message-ID: <8fbab9e8-a2fc-4fb2-a9c3-e7336fa50118@intel.com>
Date: Mon, 15 Apr 2024 15:16:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/14] x86: Support Key Locker
To: Eric Biggers <ebiggers@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<dm-devel@redhat.com>, <luto@kernel.org>, <dave.hansen@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <mingo@kernel.org>, <x86@kernel.org>,
	<herbert@gondor.apana.org.au>, <ardb@kernel.org>, <elliott@hpe.com>,
	<dan.j.williams@intel.com>, <bernie.keany@intel.com>,
	<charishma1.gairuboyina@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
 <13bb2f0f-5894-4366-be53-44658144a23d@intel.com>
 <20240408014806.GA965@quark.localdomain>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240408014806.GA965@quark.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a03:505::26) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|PH0PR11MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: a41cfffc-1ecd-4b88-5b26-08dc5d99ae92
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOQ1ipxLOq3uIPPTQ7Skazr1bZwrQ9eqSC7wLcKhD/FXO8HnNZDPutR6r9p5+KEF+KhLppBx1g6PdMpjf/Jswy/pxk1CuF8XcTVFhSnfrsJs9PSPmiiKzETaIcUrcEPuB2sZpKqenkbYTecfyOlapnis5CJAXAU5b90usFJ3aiLOEa/YCYIzwI957AjrhXT3RqEg8C5X4nBwCBF9OciM2fyq495d4Y47fd33HkKOZenRGfpCtgT1X+lpe6Kw/IP6LaTs2ANu+meUJwMzTrJJIWYAwwIZcyC6fXbO44avpCY3KzsJ7z0BTy5MRTVWLTG2cIdR27nZ5+o3b0lJm9pioA/B34Ch3YOneq4eAr45/O/+60D3LTxUDLO78U4biu1ERWtLOGeBZNFtZE6kN/1nJhhwh9ZvWcPHkymwilEJT+NuWlJmYJHJHGsg2lSQpd/voVY/bSewzYSZFCHscZg+t/Yh0ymWvcuOK3O9YKbePzhijFtQRdPWgnJ3O1D9eKs89LMRcYdJTNi4611ONVuwvHzA3s3SX9+Lns6Iox8K5P63s/COB5wQlPj/pa9k8cltnXdSsc5y1gP7ORwsnwEgd1Gfwt0MqAk8xuuqEsx4e9R1Z70o4LgYH8nlSNJsL5etZdL7518Mf9igWIUprl7ogVbhw+0ouczxDTztV2h3crQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzg4RDhocVBZRzNVeEl6dWFuNFZBNkpYcUxOVm1pcDdlaFpjem84cXdua2tn?=
 =?utf-8?B?VXdCS3J1LzkzWTRvdVV0TTRiTmoxTWtDZ0dGbjUzTlEzbVYxR2YyMGVPK25i?=
 =?utf-8?B?VnA5OFdyVXFFVzlhK2FXR3VOL0tJYWJ1Ym8xcDVRdWd2WlRtWThuZXZ0R3Y1?=
 =?utf-8?B?dGdWU1MvWXYxeTdpYkdSK2xHajFGZ0RZUmVEZXI1SnBOZDA3NXBYZFV4S25h?=
 =?utf-8?B?ZkhvR0ZMUHRaMHQ5WWpKVTRHY2g0S2IzZlNqd004dzdkbHJ3YnN4dExBbVBE?=
 =?utf-8?B?UEIwY2o4dGFpZDNSakl4b0s0VlRaVzRFcUpKQnVVVkNQT2JUaTk5U1JtMmRI?=
 =?utf-8?B?TFc0T3pPUXdjb1U0Vy9mNzJKWXJ3VTJGUzdjSEt2KytoRGN5NU9RTTFhRERs?=
 =?utf-8?B?WDhFNWdtSmNxY2s1T0E5UloxRExiSytWMmw0d1FldFUwVlpwSHUvZ2hkU1VJ?=
 =?utf-8?B?SCthYWdTTmw2TGNIWlRNN2ZtSGpMVmFLYVU0ZnZyUGgwdm9DbkVmaDBNempp?=
 =?utf-8?B?bWxqWnpVSnREWStiQVhqYnAycEltd1BRM3VjVmozUHZuS3RIZHhIb25tNnBy?=
 =?utf-8?B?QWlrVzJqbWFCekRqblpMUDRkTXZVNHdiU3F5SEpDS29NZi9qVldobDFGeHRa?=
 =?utf-8?B?VTdJMldZZ3ZnUkR6d1NYREs3ZFlOU3J0MVN2OGNoaGx1Z2gvSjY4RHF0dnZT?=
 =?utf-8?B?TFB2VURLeEl5bE5jMVV4dVVudUltZ3I4ZTU2dUR0aVlTTWdkZDhqSXhzUTMx?=
 =?utf-8?B?UkZZbWM5OFdWWXIxR1Q1Rml4UkJ2OWZ2T1BoWW9zT3VzM0JSbk5hRmNmWlFB?=
 =?utf-8?B?VjlRMWRRdkRhbWN4bUNhR0VRZDNPOEZGQUNuelpScGxzbnU0eHZlQWdYeERE?=
 =?utf-8?B?bURyVFVOYi9rTmJKZ2JkTFZiemhIT0hHZy9FeWM4OXZTU1M4MFRZVVRLclFD?=
 =?utf-8?B?eW9KRU5sclJ3bzRRWTA5ZVY1cnFMOFpCUVlWUWFYK1lSaWV1eE16UG8wN0lV?=
 =?utf-8?B?Vk5vK2hkaTZrdmhBczk5WlpBR3lGV3FBRWVVUGhnR0ZSYUNTS0cvTjhvSUV5?=
 =?utf-8?B?MGhHdVRQVEZpTVR6SE1yQTljNG9SUlVZQnRvUEU0cjB1QW5nVmVtSWFSU3ZY?=
 =?utf-8?B?S05HNlFwSUdqZncwZkFPT2V6SmE3MGpiVk92NTEyUHVMaUZxcUZiME9WNWZX?=
 =?utf-8?B?R0F6bEJpemV2OUZQZE9ocnNaanorVGplWUQxN3BkTDBQQkErZ3NoSVlERlB2?=
 =?utf-8?B?clBxa3F4OXFSbDQzNC9uWEdsd3N3ZENEY2lCZ2tYMUtiaWxBT3ZlMGhqdzha?=
 =?utf-8?B?WGltQXhHYS9MVDd5NUZBS2ZsdEdNM1VNTjNJbHk3VkJrd1ZhYVUyTEZIYWZv?=
 =?utf-8?B?NHVPcnNuTzU4NE82WnNObFhtOVQrQ1BxaWpORExBWWVIUXJpd1podzRBMzJj?=
 =?utf-8?B?N2hHV0pFcncrcElGZThnV29tbVRUZ1BsbEZQZGJuWkpzb1dKVUEvR1JrZnk4?=
 =?utf-8?B?Y3hnSEFJWldyalllOEluRlhpNVNKRUZobnRPUkhKOWtlWEtPYmkvbFUweEpY?=
 =?utf-8?B?M2lTaG42OGZTMHdnbHNQeitOMWprV1M3RUk5d29LS2Nzc1lvM28yN2s4Vk1M?=
 =?utf-8?B?NnU4M2U3MCtRSE5XcEx3dmJCcFBKNk9pQmxQTUFvd21IUjE5eXpEVlVuck5q?=
 =?utf-8?B?UVVNcFhnS3pZL1kxd1VTeWdEZWs0OE5wNUZDaXkzY0VPMzhVT1hKenVrMGQ4?=
 =?utf-8?B?TDM3YWNwVkkxbUd5eFBBY3NqWkRHczZWUE1OcmNOd2tRS2FVM3Fta3lmeDdZ?=
 =?utf-8?B?SkJaV1liNWkzOWRlMCtzNlBFZFQvSmprWmN1WFAzMXUzQmhkSlhjSDVTeHFQ?=
 =?utf-8?B?OWdSZG9vbEJnMzA2K1ZaaGpFWndLeUgzSlV4TC9hN05iUWxZMUY0a0d0UU9E?=
 =?utf-8?B?Z1J3eUdmMVdlTnF1NW9JdHFJbUR1ZmtEaVJibHl0OWJDMnpYaWtOUzVpZDNt?=
 =?utf-8?B?cUJ5VFBNVTJvc3hIZ2RqM3J0ZE5ZSzNRVUw3YlZ5Ulg2QmJnUUVaTmtHbFVw?=
 =?utf-8?B?SnZ5TDFjVERhSVlqeVRPMzVZWG9wUTJyUERDS2YvRVRSMXhLb2ZDQWp4WnJT?=
 =?utf-8?B?b1gxdUhyczljeVpQbGVucjlYeHhMWnd4bjgzY2VOdFBkTGJWaVhMbUJxOFc1?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a41cfffc-1ecd-4b88-5b26-08dc5d99ae92
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 22:16:22.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TCvwmZMlTYMEy4uNbxocDH4BtCE7JPpXajyjpyIgXoRmSQBss8pHCwVRIYDioYvRJXdL79aBueDcAM3V0zPMlr2keJ2D9AG2KZp85lQG+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4983
X-OriginatorOrg: intel.com

Hi Eric,

Sorry for my delay. I just found your message in my cluttered junk 
folder today after returning from my week off.

On 4/7/2024 6:48 PM, Eric Biggers wrote:
> 
> Do you have a plan for how this will be merged?  Which trees will the patches go
> through?  I think that the actual AES-XTS implementation could still use a bit
> more polishing; see my comments below.  However, patches 1-12 don't need to wait
> for that.  Perhaps the x86 maintainers would like to take patches 1-12 for
> v6.10?  Then the AES-XTS support can go through the crypto tree afterwards.

Yeah, this series spans both x86 code and the crypto driver. I believe 
the decision should be made by maintainers. But, I suspect they'll want 
to see a well-established use case code before moving forward.

> As you noticed, this cycle I've been optimizing AES-XTS for x86_64 by adding new
> VAES and AES-NI + AVX implementations.  I have some ideas for the Key Locker
> based implementation of AES-XTS:

Thanks for the effort! I agree that the code could be beneficial for 
daily disk encryption needs.

> First, surely it's the case that in practice, all CPUs that support Key Locker
> also support AVX?  If so, then there's no need for the Key Locker assembly to
> use legacy SSE instructions.  It should instead target AVX and use VEX-coded
> instructions.  This would save some instructions and improve performance.

Unfortunately, the Key Locker instructions using the AVX states were 
never implemented.

> Since the Key Locker assembly only supports 64-bit mode, it should also feel
> free to use registers xmm8-xmm15 for purposes such as caching the XTS tweaks.
> This would improve performance.
> 
> Since the Key Locker assembly advances a large number of XTS tweaks at a time
> (8), I'm also wondering if it would be faster to multiply by x^8 directly
> instead of multiplying by x sequentially eight times.  This can be done using
> the pclmulqdq instruction; see aes-xts-avx-x86_64.S which implements this
> optimization.  Probably all CPUs that support Key Locker also support PCLMULQDQ.

I'll revisit the assembly code to incorporate your suggestions.

> I'm also trying to think of the best way to organize the Key Locker AES-XTS glue
> code.  I see that you're proposing to share the glue code with the existing
> AES-XTS implementations.  Unfortunately I don't think this ends up working very
> well, due to the facts that the Key Locker code can return errors and uses a
> different key type.  I think that for now, I'd prefer that you simply copied the
> XTS glue code into aeskl-intel_glue.c and modified it as needed.  (But make sure
> to use the new version of the glue code, which is faster.)

I agree; the proposed glue code looks messy due to the different return 
errors and key types. Ard made a point earlier about establishing a 
shared common code as they're logically quite similar. But I suppose it 
is more practical to pursue a separate glue code at this point.

> For falling back to AES-NI, I think the cleanest solution is to call the
> top-level setkey, encrypt, and decrypt functions (the ones that are set in the
> xts-aes-aesni skcipher_alg), instead of calling lower-level functions as your
> current patchset does.

Yes, falling back is indeed one of the ugly parts of this series. Let me 
retry this as you suggested.

> If you could keep the Key Locker assembly roughly stylistically consistent with
> the new aes-xts-avx-x86_64.S, that would be great too.

Okay.

> Do you happen to know if there's any way to test the Key Locker AES-XTS code
> without having access to a bare metal machine with a CPU that supports Key
> Locker?  I tried a Sapphire Rapids based VM in Google Compute Engine, but it
> doesn't enumerate Key Locker.  I also don't see anything in QEMU related to Key
> Locker.  So I don't currently have an easy way to test this patchset.

No, there isn't currently an emulation option available to the public 
that I'm aware of. this feature has been available on client systems 
since the Tiger Lake generation.

> Finally, a high level question.  Key Locker has been reported to be
> substantially slower than AES-NI.  At the same time, VAES has recently doubled
> performance over AES-NI.  I'd guess this leaves Key Locker even further behind.
> Given that, how useful is this patchset?  I'm a bit concerned that this might be
> something that sounds good in theory but won't be used in practice.  Are
> performance improvements for Key Locker on the horizon?  (Well, there are the
> improvements I suggested above, which should help, but it sounds like main issue
> is the Key Locker instructions themselves which are just fundamentally slower.)

On our latest implementations, we've observed the Key Locker performance 
on cryptsetup seems to be roughly the same as what we posted earlier 
[2]. Yes, this sounds like a fair analogy to me, especially given your 
vAES code.

Thanks,
Chang

[1] 
https://lore.kernel.org/lkml/CAMj1kXGa4f21eH0mdxd1pQsZMUjUr1Btq+Dgw-gC=O-yYft7xw@mail.gmail.com/
[2] 
https://lore.kernel.org/lkml/20230410225936.8940-1-chang.seok.bae@intel.com/


