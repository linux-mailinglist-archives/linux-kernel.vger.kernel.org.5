Return-Path: <linux-kernel+bounces-131978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4179898E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1511F2D00F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1926131BDA;
	Thu,  4 Apr 2024 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7yHfUAS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01913173C;
	Thu,  4 Apr 2024 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256232; cv=fail; b=pbiIPl2nsM9J8bBHq2BNeV/dExW/CgnIG1ldC+GW+u/CZWUD0ieM4x3cbzr1wWcRWPSyRCGLAFLx6B6b06PDTh4RbToyx0pWKlD5DqhiNUKdvqJ7qIL+HhPT3aOVZNdBUVcVUWddlAfYn/g3EEN4C+cwCYRYPWVZ/ASOzxKFoQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256232; c=relaxed/simple;
	bh=emI5CMANOrLtUusioKlQIYor9Aa8Cfx6BVPxk/88WGk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GJAlzvkQdjWIH1jtk5/kabcl91LANpcD50aojfusG0MnAeoXuDa3foFi+x77SGuruOlZ07uKPvjsnln56TniRuh4TGTEyShKlgkmnG8aJvX5XrvQTlepl2yuZYaqUCkoll9fggad8eDZDPIGyd09F1fw3rxTu+vOAXzkXHyATxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7yHfUAS; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712256230; x=1743792230;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=emI5CMANOrLtUusioKlQIYor9Aa8Cfx6BVPxk/88WGk=;
  b=X7yHfUASuf7GyiPkH0srlAWe1UPV7imKzsWKWOiA9WmUkBU135l9FZDR
   pCojD+GhPLb6e2VvG51HTwDYJz3lNVUX3BxnPFjJu5VTk9Jks6f/Yzrzs
   l6VQ9+dWGr98sPXRY0zrj48xe80sEvXKLyq8KHj1ilG3k9V4Zu2HE+5BW
   FhA26J5D4wG/0kMkuiMfKTvEe0DKF9sSnjf+dWesD+Ua9MES9GUmct7dc
   H+pCRS7Lr7nzmOuGmc3Z9cC6CSboOcWNpX4XUoLGWGd80X6iknOS4ZGwR
   1VvwKcenKx4IG1jUn/cWVHx3ugfjDvAGmDvejEYIZ2DQk+RmrDYPJPxb8
   g==;
X-CSE-ConnectionGUID: ZZjDmJ63QOaVikVQJ97Z/w==
X-CSE-MsgGUID: 9GDXu3TkSVWH1RXnvmI5ow==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7431596"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7431596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 11:43:49 -0700
X-CSE-ConnectionGUID: zR/YNCs4T0Wa/U0yot2SVQ==
X-CSE-MsgGUID: WeKTLWriQQGp/1M0EGBI2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="19487673"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 11:43:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 11:43:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 11:43:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 11:43:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 11:43:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiFQ7f01VDtJlfFLr4ToercRA8JAp4JxuIQAdKYZmKpjVM+IpJgbqjLZEHF1p7q1bne0EH/Al+HNVHkr+iDOro3+yTgjY4iGPY7ld0V8cEI8JucrPi1drTiOdsjS7El5paEZptPQD6wV3/TE35/MkVrN71Woy7/HtyhNXBOxTwVrVdu1l1HmLf+ysyHgPgbf5vFLfVT8oRPklyzyfG7tgNypAnlq8tOp3fc9L8t6Dnd1RRx/Q8V/Y+89rHBiU/bOzNMk00IILvdJBK8rzfLiUyUlNhQBNdgEI9uV2R7U/4Y1P1LM0gVbXTj6T5MUB9KIc5s24PLu2f9OBbZLZzer4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bufgIWexD+L6y1z7nMeAw8NB4OB2IbmpLlNrPh3OHZI=;
 b=VWPXfM1WqXf8K8drFhl3tyOijejxc+oQcEZHC8teBKTd+X28kOwHm/UhJ0bZRv6j2/Uj72smn9xS2NLnlLzhR0Ka5/e/rJZ/jSdTRbDN5qHVEKbQTTcZM97v1jrpu/xuuwBB30Ycct9TAJSdxcj+NkFGedeVH7yiT8Wmpn5grn7YOkR8EsSzQx5br+fcMVB0D0hAzedB/f9YAIaFVBjxX8DlScmFA76l4Pajk6a7PEuoSFRTwx2z5NYk/NKlGFRrQIWE0D36MZ66xR9M36st5hM86/PbAAmyydgPAGb0kIYSWvxyvXCtfq4e6UdYfTC+EKC2n/GE7F1O6rliBKHN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 4 Apr
 2024 18:43:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 18:43:40 +0000
Message-ID: <08c8162a-f7d7-4e78-8a2a-d9c86780429c@intel.com>
Date: Thu, 4 Apr 2024 11:43:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/17] x86/resctrl: Add support to enable/disable
 ABMC feature
To: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>
CC: <corbet@lwn.net>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <0db75c94886da62b8da498ef159d8fe27b0b3811.1711674410.git.babu.moger@amd.com>
 <CALPaoCgRtYLnzpkL6uVjb+LvBbxD8ANRuzACP1UQ=rkzk8TCqg@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCgRtYLnzpkL6uVjb+LvBbxD8ANRuzACP1UQ=rkzk8TCqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:303:b8::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6999:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAeh3BDtLXNZ+AR/EKw2/yp/oXtq31O5R3Q9YiajQiqVfCbmvBTRk7bKJE+wRShEeJ1LZ4h/htw2XybP5Jl38BS3zBKf2dKC1TibUDqU5yKbOUzuouTaPrI70xErU7vZqDFkQwnVI7A7A+JnIdFtTlQDporCL3/D8j9oewZzd4oFGLARau/B4kKAx7FbkU1FCa19WpdHVkrYiObWY3JcIL1ToxszGMKeXSaZj+rTR6FqJU6sbifPMUa98LRARvam4ebVni7PjzEvHkdISzBzOnl8wB9zwdlKxPwUtju19D8UOz3NTAXYC1uULu6O+7xwMwejaqF/8kQCdrvgiT0TLS9XmtL4idU6CuUYJHRdivMpmaLqofgxoYPxbr+XfXi/zXc4OD1YyTDAS8HsT3EM1C+2u5o65bB/r07y0+WL3p+ehwW/a8i8CGtlIF74c0QRYcnYiLUwot2qM3oI0keTd7f6i71zKwCJJ38NAzPl8e6V32aBF9qXgDzXCw3r/Sc3yCnrnGEksqSbxurNW5Mmnj0PbY/0XpFZ7s3pfK9gLVk2ACfO/0tVMugr54bC16pkTzsaGhwSU6F4FTg+wyMs/RmUQFPGiducdTFTfKuVLfCExvGYc0odpmTBQiYFUvzZJuPTZlerqDK9wGNt6YehcKQ4DdzvxWsuaG9kWWy89FQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1o0MGU1UnZJRmVNNWVjN1FrYm04aUwwSHdZR0JUK2RaMFBwY2lNbXhZMU9z?=
 =?utf-8?B?cDVXUWs4WTdYUmVEcXVTYVRrNmFWS0JQOE1WTHZWMUMzRTV6Z2ZCT3ZvMDk2?=
 =?utf-8?B?bFE4Uk1QL3M2dCtFdTlPcllSVWYrWnpObXJwanFVUHBmQkppU3dyYldIeStn?=
 =?utf-8?B?SHR4SkFaWVBVaTBoZ0VVbmNRNEVXeWFiVm1WejVNaDIxaWRFK3lMWGtOb2sx?=
 =?utf-8?B?cE1JWjRhc3lOZGFwYndHRHFnT3M1bm1QRllrNHRJb254TlhiNlFoY0xxOUhI?=
 =?utf-8?B?QmhVOTc3T1Y2K2ZKVWZuYXpVaVFWUHRwa0IzSklqV1duMFJIc1Z5cEErL3kv?=
 =?utf-8?B?dUkweXlMK0VCaVl1K2h1Unl0b2djRTluSHczemszd2VOWEljMEFWR3JrSUxK?=
 =?utf-8?B?dnZlYXJ0YjhuSmZiYklqQ2tiR3RLaE5wQ3ZMSno1OXVBTkpYS25ncWpTTW43?=
 =?utf-8?B?ZE10SWovYUlOaUpITjFkL0laYkQvZDhjWERycFJZcUtGVHNuWjl6d0pPYmMy?=
 =?utf-8?B?Ti90YTUrS3BsRnZ2RjdvVDkwWmMwY091aUJucWRSNXIvKzZwL1pKTHRZeC9R?=
 =?utf-8?B?L3MxVlJWbTc1R2Uwc2oxdnJDMm1ZaUlnWk82MkhJQzdZU0NJRzFBZWJmVENM?=
 =?utf-8?B?TFIrLytLZzg1RDZ3cTlEampBejRuYXIvZnZmY2VuYW8wM3Y2WERXa2R3YWZy?=
 =?utf-8?B?OVMyaVBJcG1qWkFpakg1WnBncTFYR2VMR2NrSmFoOHNicGR2Uzdab0c5ZUtH?=
 =?utf-8?B?UDZxV0tEYjA1blhvL3ZaZnl5cktJdk1GeFkwYzlyMytsRGRSV241ZG9IcEpB?=
 =?utf-8?B?VEJyYzVld2F5SDBNdG5aUnJXQlBscDlwZ0ZuV1lQd1FaeW81Y3duUUV4UFlq?=
 =?utf-8?B?d0FNbllYSE8wZjlRTVNvbHFGQmgwOWtWQlBkNHpuUklJNEtwRzJjUU5STzRn?=
 =?utf-8?B?aFh5dXU5VGxXT2UvQURvcmppZXJBeDJkWmtKcE0yNDBQcVFUdW1jRE1xZjM4?=
 =?utf-8?B?RmttWkJVb0RKUFcvWjFFcDdEKy9oRC9VTmpIMnM2TW56MUNpWVl3UzJqWHUz?=
 =?utf-8?B?MGkrSmZQZE44V1FTYUZJVjdlS2laVlZRdjJuNEYwVXRPN1FKZDY0U0NUN1Nl?=
 =?utf-8?B?YW5xUWN6YzdBR2NpbGNQWGVrOGZvMmRGSDJwcGZjUFpuR0J0NngzZk5PdDZ5?=
 =?utf-8?B?M3FPZjVUTm8wRFhDbE5VeXZ2bVlFTFQrenA5U2d1MWlLaTNKUTFrT1JRd3ZJ?=
 =?utf-8?B?S2ZlOXlnaXhCZWJpTU1ScmVEdjBnU0t1OVRvWVpHS1NnR3VuL2JLYWFFQWVV?=
 =?utf-8?B?cWVZSWErZ0FDbkhIRHRUZHExUnNBbUZLV3BUSWRHUXI4eUd0b1p3ODdqWHNU?=
 =?utf-8?B?YUhkM1QyUHUzbXpZRytvNFByUjV1UFZvWTRqWkZIazNRcnUwQnpRZ3ZLY0lu?=
 =?utf-8?B?RzRJaDB4QlIvdXhwMU4yT1lDejNWRVY5TWkzMDdBYkxVQUpWVVJCZkU4V2dt?=
 =?utf-8?B?bjFJeUlWeDI1K0NhdG15b0E5S2x3Q2lWbmtMZVhXbUExOTgxOURycEovU2Zk?=
 =?utf-8?B?TUtlRXdSMk9FaDVCSHc2SlVEdGM5VlJGQlU4YlpkSlpnRDJzVE4zRkR6aGVX?=
 =?utf-8?B?RGMwcEs0M3NLdUwvdHZjN3p0SkdpQzJQZUVjOVI2RnVzVEI2SXFzUklpcjl1?=
 =?utf-8?B?ajlaUnA2eWo5QVZFb2FqMmV0bTZGZjdyeFZVTGxwRmE2cGs3UDFkZ0JhUGt6?=
 =?utf-8?B?WHZCRDNMWG9nc2twTVNvTklhbVl4dWtPNEtoN2tXeERGcTVBRlkvcStWbjdI?=
 =?utf-8?B?WmpzdndsRnFxU29Xa1U3SUpYd1RDNHhsa0ZtNWd6Z3JnbDBzRVZaVG9PUHRL?=
 =?utf-8?B?d01HbW1kQVkzZWh6Y3pOaTQvRGlYWmovT3VrU1dKSW1oODFpRUE4NkhhVFk1?=
 =?utf-8?B?MTAxNFBLVFhneWNCVlFsT0ZPejNKZnEzbE9NYlBwQWdFdGYxSGVtMUM2SXVx?=
 =?utf-8?B?NjJHTG43YXZEczVkZ09jcnMvL2lxN2hzMnlVcUcwWTNTYVFMZkNKcUpYNGtN?=
 =?utf-8?B?cFVMbllRenN0YlZDRURGNCtWdWdVQ3FPNm5IdEpNVUp1d0Izd0ZRK2VwV25m?=
 =?utf-8?B?eEltUmFTR1NhbnBzN2g3Z0kxQzJtOUVRT3EvcHBIM3RkR2tGZXJXeWloc3hM?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf42732-34a7-4327-3c8f-08dc54d7258a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 18:43:40.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bk+heWsaQLbZYJ3x87joYuoI4t4W07oYYig0HEjRsPOAes1/hJNiXskX1rKBBBxS2ub+MzsdPnnZfDGZh3xLpWe818xanK36hkQQDh0aWm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999
X-OriginatorOrg: intel.com

Hi Peter,

On 4/3/2024 5:30 PM, Peter Newman wrote:

..
> 
> Presumably this would be called holding the rdtgroup_mutex? Perhaps a
> lockdep assertion somewhere would be appropriate?
> 

Considering that you are digging into the implementation already, can
it be assumed that you approve (while considering how "soft RMID" may
build on this) of the new interface as described in the cover letter?

Reinette

