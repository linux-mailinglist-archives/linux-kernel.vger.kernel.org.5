Return-Path: <linux-kernel+bounces-152679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7898AC2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC608B20D42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 02:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11654C6F;
	Mon, 22 Apr 2024 02:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRW9fyvm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E6F2F56;
	Mon, 22 Apr 2024 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713751626; cv=fail; b=HR19s0lQQHQvPynQwevYdDwIGRvmJUge4Ks8cmh9KIoTKS0J79JJzJPyRevwjQiSjcNOu/yc4lPe9cTPC3H9X6vZos5ddKqWcswc5HEM2b9MVUOPHfNFLxGlToi6FOkhB7qdHKKV/AcFBdBKLRQrGjN1PSHOx9jrZAl/zgub+jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713751626; c=relaxed/simple;
	bh=8nooxDJm50L0E6XyUHrb3pYHHJZh/pKsMA5mrHZ0s5w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GSa0S3GNdnkV2uVor+90PgNhKUQ1nSChyxI3nlsBJVWW3D5MCR1IO2jUbvEKC9Mng3UWQg/N/FcfpDIGza3MQqNsN1UXB+GfCgkzDYn71ybD/p8m5FqYdKW/208hfpctfejSg+JrqoEL2zQhsu780oBRQLCBErpK/NuDcYDVzGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRW9fyvm; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713751625; x=1745287625;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8nooxDJm50L0E6XyUHrb3pYHHJZh/pKsMA5mrHZ0s5w=;
  b=hRW9fyvmTHkgi8m8f3o/SWvku5W28VLPF37g9AJJhjU+PjO0XpPieHDh
   ZwaZEGtR5/NqmPuaDeej9CL9TxGuMALQhCcZsGIJO8aNu/uhYDveEBHg1
   YXPdOFBztYRVE4qerSZQ351D0bBErdchoHTknH4uxfqFvndXyv/qsNQxs
   Kcv5oQXiBkcdF5MxTgr/dv7YQ+XXU6OzlbW1zuIpGglSUdaHL1ArBMFmM
   0OabWLlN4l0SOYNvflJH8LgrE05iDNUttR7b0qBnmmNFaEQdz10RdwVU3
   Bx459nj5Wzu9pJJsm8EpDxFbQblA03NwdtaIsmNnEDQPFyk/f44vjr9eS
   w==;
X-CSE-ConnectionGUID: PloviRelTB6H+UFqrdOZlw==
X-CSE-MsgGUID: cTdvC87mQA6goWTSqw0tmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9192131"
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="9192131"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 19:07:04 -0700
X-CSE-ConnectionGUID: hJyYKL4wTjGa5IW1fGWMIg==
X-CSE-MsgGUID: MeoHmqyhSb6pOWHwoQVNMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="23840910"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Apr 2024 19:07:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Apr 2024 19:07:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 21 Apr 2024 19:07:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 21 Apr 2024 19:07:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y35o/0eRZ423pHl28JllQaXjkZJbOuAA3tcRDzhyHovjCgMMbeMP+IOSVaPAtDNVu+KYJBqojIseNhlT5tomKSs6/1ZDah/WRHMqo0Gb1PeOF+Xh1TwqaeQCmMhYDhXWsMrb+YbFSJO0/25Yzj93V9rPbKPIW5lYVMzOddags90BgMap1AxV6rVoqQGWRCHqdc7VJWYPttUKgclr3ZMXuG3tJOa/SkLsQi5cuqSA/2bku85zuKM6bhMlObbnTuKj7UBRPZ2tmEhE4UF2RlNbcfLbJK/UiXef80VstpNf1fWWxwjInP7YsiC9VQ6Ddqg4FgRThg516vVhz0hV/LJm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vgd6E+lkSp7DLLkV5ZlPXSPeJ9gTy3Ic5yn7YBru1E=;
 b=h18iQZJ9/kO5h3ILpwCsQCShgqBLedlCS6bVSVz1yXVEOfevKORcmc1Qok5VjyvbqwjVp5wlqXX6gebg68HuOOSnmViTifFm/FM46pWu3zlzODTaxiTZwTYcIi4BtUy3DX1SlbMGklA2KZY5TR7bKxUjqpDXRLQtE0q5xXBnBt/Nb3wPqlqh2Rqu/U9Xo6pkpO3nv82AgOyB/s0SlRVq3XG9I6+HJWnmUZubvAxv2E+2eD1yzuNaXd0HSZi0WxzNp83CmmO+JD6dON0gnbt/GljKzpPdpSwgQLSG+0qjC7YRlLBL7TQ57OZrgUWnZVz9P5eNO4YJakLL6O5y8eb2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DM4PR11MB7280.namprd11.prod.outlook.com (2603:10b6:8:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.19; Mon, 22 Apr
 2024 02:07:02 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165%6]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 02:07:01 +0000
Message-ID: <8a304a97-7825-4b02-a716-f25d0e9d4718@intel.com>
Date: Mon, 22 Apr 2024 10:06:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] PCI/AER: Enable RCEC to report internal error for
 CXL root port
To: Dan Williams <dan.j.williams@intel.com>, Terry Bowman
	<Terry.Bowman@amd.com>, <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-4-ming4.li@intel.com>
 <7172ec2f-7cba-460b-a6c6-9fff45ba938b@amd.com>
 <b4a721c2-567d-4ab3-8a85-963e3f323e61@intel.com>
 <91ddd182-cc71-480f-a1b2-e7c31b29a549@amd.com>
 <f0b85a37-ead0-4954-b7e0-dd09cbd9ab09@intel.com>
 <662134e290d89_5eec229450@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <662134e290d89_5eec229450@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DM4PR11MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f97ee5-3eed-4c6b-0632-08dc6270e60f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkJpZ3FHZzhXRE5KaHdac0Y0V1U3OEtSSjNIazlIendLc2pqZ1lMWnVGTFEx?=
 =?utf-8?B?NWEvelBBTHhkZjlGbmQ2Zy9pY1V1dDZ6R0dIOGVSbjhnekU5NzhjZUtWK1hp?=
 =?utf-8?B?RTNOU2F0TjlHd2ZscnJSQ0VYR0o2U3kvZHhrakZNMFlWWkRuQlZpeXZLR3lx?=
 =?utf-8?B?dTR6OFdHVng2T0RjcEg2YlJpMWdTUG1zVW5SMFlpcjQ5NHlMMk9ldEN5Znpq?=
 =?utf-8?B?bEdhYjhIYmNoSXhvUFhhUFV6ai9VUDhpcG5rWmtlTmVTRDRWTGgrOHdrTmRt?=
 =?utf-8?B?WFE0K2xKTW1meC9IY2FDZHZaUWZaeUxIdDJlalFCVVU2UjlYTXl5NTZ5VktQ?=
 =?utf-8?B?WGF3eGFramdTRWc2dTJzdkpwb2RTSGNsMmlGbm1LQ3pGUnc0TnhBVU1FcmEx?=
 =?utf-8?B?dkFySjl5SDg5NmJldXhtRDQ2RXE3ZEsxWFlGKzRBRGtFZU5FMVZwb1N5YkE1?=
 =?utf-8?B?bGVFbHZyL2FwRzU2c3pvVGpIZE43WXYwcVI5VCtZQno1UFdBWmtTclNucWt1?=
 =?utf-8?B?MGttd2VzVGxsbUI1NzV2REZKNndnREVtTjRaL09QcHBmNFZpYjZreERkSlMz?=
 =?utf-8?B?VjFvaXBleXBzYWFpM1Bvd1gxdmxVcS8xQWh1QlNnUTlXT2NydUJ6WmZvTHpy?=
 =?utf-8?B?Q3Z0MDI0TDBJaTJnRXo0UUZuZTVDMlhXdVd4bytzSFhJcFhiTXFUaExOVWRk?=
 =?utf-8?B?Z1Z5VCt5Y05jeGR3MXRqUC93ZXdRQ0kwb0RFV2R3QmJ2TFIxOUU1QmdpRHov?=
 =?utf-8?B?U3pZcmsrYytnc3ozajA5cGhtOEEzaXRTM3VDRmxiSi9YOEdDZHRQWXpHYTZW?=
 =?utf-8?B?NEZUb2NiYVhqWkd5OGh4OHNIK0Z2U3liQ3JVS0ZOZDhmOTB3M1JJRHFvVlFt?=
 =?utf-8?B?YmVUNWRqM0xialplRWp3RFJJNXBVL3h1eElsZVlod3BFTTVpY3lwWVBzbDFY?=
 =?utf-8?B?MERSeURUR0E4VGd5MFpFZHgvcEVnb3lkZWZVSkNWRERRWU03ZXJSOXliYUsw?=
 =?utf-8?B?YXJCcXJTcFNwOHJRbld0TnRnVXlNNk9CNGpwNVR1cDFENmJYR3AvN1JKem1q?=
 =?utf-8?B?NUFGQzI3UGRSRHQ2NCtBOUUwa21QUTU1V01BcVExdWdKM3FZM0p5eE1mTzF6?=
 =?utf-8?B?amN5L2svY1hQYVNSQ1BXMTNscXY1d01XVk1YekZ2UWhvN3JoT3pPK1M1UXNx?=
 =?utf-8?B?aGZvWUhaUmQrTStSbUovNm5WRkpGQ0QzcmhkN3RTdUZ2R2lRRDVxN1JFNHJX?=
 =?utf-8?B?TEtlRTN0dWxOeWducWFNTk5xNVdCR29PUDdqRXl6SXZQVEJoU1c0WlNyNkZF?=
 =?utf-8?B?NmtlS2JRTlQwUy9OSDJTVDBVWlBKVTNxZDRuRlROd3hJYjZRQkdKd09oYmZk?=
 =?utf-8?B?SWJBOEFwTUo0VzNzRy9nczVMYXZadG1JcXFhV053ZEdmb3BwZDlnNFBRc0Jx?=
 =?utf-8?B?SWROMi9ZRFpyaVJtTEUySTdHSkZvVUI4c2VrMGYzZm8xb1hqSGF4T3lBUXpu?=
 =?utf-8?B?eHJFZUJWbkw0Vm1IK285cGJDRDdkbjk0NVJiQU8rclgzM2d0T3hocllXcHg0?=
 =?utf-8?B?UWh2Uk8zSWxlNXJsWnpna2c1ZjlKOGprQlprZ2FOSnUzUVpzK3dZOU40WjIz?=
 =?utf-8?B?TDl5SGV3UkhkRGhWdHdSOVdseUU1eEE4L0VDdk1uSDJaNzgvczUxYVZra1ZC?=
 =?utf-8?B?RWJ0YzlzbERDQTRNSjZPbWt5M3dTWVFBa2Irb3FRTWloaUJKc2oyamt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si9ZZmtsSzBESUdwUnJMbmlVYnpGbERZSlY4WFdLYzVFWWRSRXlZT1VTVWQ3?=
 =?utf-8?B?K3VERVEzM1gydlpwcEVhejBBYTQxcy8vNVVWVkpERDJRN3k0cG9sWEMrTVdi?=
 =?utf-8?B?Y0diVnk2bFdaUlpWMUdXazFjcU9BUG1VV1JtZzdEYy9tbTYxUDBReU9iSVl5?=
 =?utf-8?B?cFVNS2MwR1FoSFZEcWluV2NmQXNxT25BRTlZL2F5V0ZFVTVvcVNDbUxycWp6?=
 =?utf-8?B?TmNoc2VBVmtHcWx2b1R5TTQ2dXdVNlZHcEUyUEZ4WVB3SytPdVRqaEZ0cy9R?=
 =?utf-8?B?ay9WbWpRcXBLV2NYVDVJMWpITjVnMmMvcVRUc3JiQ0hUa2o0N2hlcDR2L0xG?=
 =?utf-8?B?Z1N5QUYzU3h3M200WmVKcysySTlZZHdkSURKdjdESFlNOTZuU2lSeTR0Z2l2?=
 =?utf-8?B?cnNNdlBET3IxNlB4clZOVFBoQmZNcGtBN0hTRzJram9VMHRydm5iQTdoVXlL?=
 =?utf-8?B?TGpxWHRIQmJhQkxFbXNZNnZMRzc4djNLbVdjQ3IwUldsVE9WQlpERzR5T1dN?=
 =?utf-8?B?eWJUUEphNGZwY0hYOWwxc1poVS9sY1JVTmx6ZmVBNjA5a3FCSllFWGlXVXYw?=
 =?utf-8?B?Rk9OY1d1RlVLWnZMYXI5c0g3bExsQlJDWU1jM25xZkc2Sng5SmtpSmdZSm9q?=
 =?utf-8?B?RGdQaDNDV2JXdEJ0ZldqMmNlTktHWXFnZnE5cXJTUTNrVWpYVGNVQ2RaNE16?=
 =?utf-8?B?UU5HR0VmQzJYQ2NBOVhjMDQxZVd0L05iSDRDVm8wZnplOXBaNE15d3ppdWtQ?=
 =?utf-8?B?TzhjT09kaVRhamV6ejQxaHhFRGw5R2F1V1JuTFNFc3dwYVR6eVRycU1YK3lY?=
 =?utf-8?B?TWVLR2RjaTRRanE0cmRWR3dPZHBhdmx3Q0hHZGtJQlovN2RhczhhVXRLQ2w5?=
 =?utf-8?B?aEhnVmZOQTQ3OVMyajZTRXpLYVJ6TjdjbjR1VlB2SWtUSVRWcXBOWkJGc2M1?=
 =?utf-8?B?Wld6cmxWdllvZFRhOHk5MC8xOW92Vi9XdVp0SjFUbVF4cHFNOG0vTloyamR6?=
 =?utf-8?B?cmZiZytsalREc1dFQ3M2MW1Lak9ERVd4K0tpKzlPMkFGU2dGQkVnVnFHRmxZ?=
 =?utf-8?B?bEhVVWdiZGhCT0tPckw5MEFsTnA2UFhOT2x6WlNiamhNTUVhWlpxd01ET2tn?=
 =?utf-8?B?YWUxU1ZnMm5veDFBd3cwU0dPYUlWRXBBdVAwNDFxOXdySTdkSW93dG9qUlls?=
 =?utf-8?B?dXRkRVU2WjlCTEVzV25Kbmx3RjFtazNCZ2l1a1kvamp2dlBvTmdWRmlhZzRq?=
 =?utf-8?B?QStMK2k4eXZ6STRFbk9YaysvK0gvb0FheUp5b1Q0czFJYlIxWFQrd2poc3Jt?=
 =?utf-8?B?VVhmRXpGMis0TCtiOVlEbS9tc05hT2g2YllqM2hMRSszVlRSclU3OUZHb3JI?=
 =?utf-8?B?bHJvM2VvY0J6eWFDNERUNUxQYlNKTWFGLzM4ODlka3BUc0w3RnJlODR0ZzF4?=
 =?utf-8?B?c0FTdW5salQzM2xwZmVFSW1tZnQxZjhxT3FkR0hSRCtJeW1RNmtsRTZNN3Z0?=
 =?utf-8?B?MVpra3NvcjA1cWp1M09ORnNtb0V2N0pOQitoSU5COXlsckNvSW40SEZtT0Fx?=
 =?utf-8?B?TWw5Y0tWdXpWVGVPcC8vL0xxTUhCRDIzWGdkL3dScTFGTGJhVUFGbXoveks2?=
 =?utf-8?B?VGlNeW8xeHVOV2lWdkorV0pQMUVyL3lrWmJER2JwU2Z4ZDJINngrTS9WNklX?=
 =?utf-8?B?MGFqTVA1dG92UW8waldyV2VMdHNqcEJvcloyVnhZcU80ajMxUHRWYk8xb1cz?=
 =?utf-8?B?YTd2NytpK0FHSUN0Y2d2cSszRFp1UUdQVi9OWDNhWjlERStOREc5SVdQTGVx?=
 =?utf-8?B?OGpvNG9sSmtNQWJXZlN0SFA2MGJxU2txSWgzWEFVWGM4N25sVXhrTVMxNytF?=
 =?utf-8?B?MjFGeHpGazlwb3JSNXhIbjBoRkxYTEtOV05aRlJlYlhWZGRaZUIwMzhWM21j?=
 =?utf-8?B?TDd5K3pYaHNpVjBoZzd6S2Nwb1NxMTNXVVA1b09WbzhaS2IwbzZub1RnSXJG?=
 =?utf-8?B?RmZLOU1uejZ2UHl4SHE1WEVkMGUwVC9xRTI5ZjJudDhpNEpldERpZXVmeDN6?=
 =?utf-8?B?ZDFIeisybE1YaU1zRkxlNVFDTVIwb0FXWDU0SC9TT3hIWVVFSHB1TVM2ajVv?=
 =?utf-8?Q?S5Qb85+1OOe22YOEtCIVVKFmI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f97ee5-3eed-4c6b-0632-08dc6270e60f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 02:07:01.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7egTlO68/F+CATF9OSOIswO1HeSvqCHFdRqHfgjnhnAGAeYia/uWjZDsHeDMcIn+Vq0o9CxaVPBYBYImPe4InQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7280
X-OriginatorOrg: intel.com

On 4/18/2024 10:57 PM, Dan Williams wrote:
> Li, Ming wrote:
>> On 4/16/2024 10:46 PM, Terry Bowman wrote:
>>> The driver support is much simpler if RCEC does not handle VH protocol errors. Is there 
>>> a reason to forward root port VH mode protocol errors to an RCEC rather than consume 
>>> in the root port's AER driver and forward to CXL error handler? 
>>>
>> I agree that is simpler if only root port handle VH protocol errors,
>> but I think that software has no chance to choose if VH protocol
>> errors reported to RCEC or root port, it depends on platform
>> implementation. So I think we should support both cases.
> 
> The question is whether the CXL spec RDPAS behavior causes any problems
> for platforms that follow PCIe rather than CXL reporting flows for
> root-port errors. I.e. does it cause problems if Linux starts scanning
> root ports on RCEC notifications?
> 
> I do think the lookup needs to change to be based on CXL host-bridge
> detection and not CXL-type-3 endpoint detection, but otherwise it looks
> like CXL spec wants to invalidate PCIe spec expectations.

Hi Dan, if my understanding is correct, the CXL host-bridge detection you mentioned is that iterating all root ports under RCEC associated bus range for RCEC reported VH protocol errors case, and the CXL-type-3 detection is that iterating all CXL-type-3 endpoint under RCEC associated bus range. is it right?

