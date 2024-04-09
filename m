Return-Path: <linux-kernel+bounces-137469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2519F89E290
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7C628366D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31577156C7A;
	Tue,  9 Apr 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aupXZ7W7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7B13E3F2;
	Tue,  9 Apr 2024 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687463; cv=fail; b=AFnhFYIoVmzZC8tTX2AdBv+yzRzOnNuBswRzi9dnf9STIS20SAOGws9/YujdCZhxJp067IjIGIlMcUVqwHrDhQXvGEHOPC5ZYfO+l8vkdZiC/elkcMyYmPpTRvj3yyT//Jcr1TVrF83eHXdXwauOyFgNjPhMlX0skOw3hq1Zix4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687463; c=relaxed/simple;
	bh=/mxCpqjFtXA0vJrOijXC4AwhoX9nAhDKn5cD6hDiol4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o4TBfcPPzq4tpAwHix/oJ4TjVRPGOAFb8XowayVf43Gx9LKeLN9FZYoD9PnKwdSWBoEgG9VokcW94hSjMvImUuaIEHWLaHXEtI5yzsi4FKLhyrpKSSvuxr3IOSFdnuO4pY8Fx4xVNufyvaVdTrmS97VfqRyu6skKyud0RIbuO54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aupXZ7W7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712687462; x=1744223462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/mxCpqjFtXA0vJrOijXC4AwhoX9nAhDKn5cD6hDiol4=;
  b=aupXZ7W7IOZThkN9U54pkeHAbMPUeX9zD0L3Q3YB3BpNWVGfboYU5i6D
   S/qDDAj6CajXMg20PfS1P/ra7ObrKL5EYj9B4NrLFQXZEGVy6yrEbWcvz
   1Dbr4OgneuVIVzS8r+VHc4h5AsvKRJtKe85RSsptN3AmStr9xwAFxStla
   6fv/vRY65PKwtZqQjtQp/EQGGRXPa2uFgVLUGHBIq+j2oGEwIn8BZ4SL6
   vMCt/OPUiJ0JmHmMurouws/4yimv04apm9R4pO7pBN/rmKBFAKshGoMYz
   2fHNyD25HV8J7Q3JVOrwd8lQ7L4rg5WSfaK3RL+js6twxYzMuP/aSg9QA
   g==;
X-CSE-ConnectionGUID: 8TmyUg3STJS+/LgIl8yNgQ==
X-CSE-MsgGUID: tvDz/6DvQEiLWdhgglXNkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11795380"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11795380"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:31:00 -0700
X-CSE-ConnectionGUID: iiFewhAcQqmVuOwIVjir4Q==
X-CSE-MsgGUID: 3R6HOOnyRJikECbfTugcVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="57757505"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 11:31:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 11:30:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 11:30:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 11:30:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loci6B7LI7uB9Kj0W6h9RFrbQiIEigu7YGVNc9PjOGI09QeHaDav6MdrcjEK3OgAReQjgeGhJqvEUGYR3Ngk9Qw+TN2nnyUL6fN9jCh684PFr+pSm6sTA482Q+7WedJrS4LoXRKdAE4NOD16TlUffHnRFWFCMOESQ9RtZnO+fsBotBKkE8+ezKFKNI6qd38Zl7Jgo7baxBktmdU+x+O+2xbmwLa1h+qjct6A8nZZXO8XFd4RhVFhU+AQJrDwmRFywaPnS6aOHfzuz7aZvfrQaaVWQW6ldUxRwgSe1MEGds4ZFr2X1wkVVhXJDPplcdPtGi2O22i1eN3PnZ7X7J4+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mxCpqjFtXA0vJrOijXC4AwhoX9nAhDKn5cD6hDiol4=;
 b=jx0xmnIqdfP/Nw9yfrYO/CHpzeyacBAW2UrNvHTRRPNEK7180fZHF/mbzEyzCi85lYpnJe+ojxR42TxkON8weMeyq5F0OcbdQpGcKyBhLq7EOR1PLfB2QmjTmZfZrM6Rgdo/Fkk7D0lpF9eLjGa/m2E4A2Sd9ChFk9vAnvpYFWOgOZfi91Ts25bcIvc9OrbD7L4meQCB30apv4xosV+XD9HwcWygkoUvvOSKhO567W5Xlvzh2UNryduU+3HjFL108nTjMDvQ8eRBehQyHKH1/SZapBKWa3L9CbnKkPKJ7TgO6jvTlonA6iWLNQRFnnUb/ihNEdOSM8KKTS00aOe1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Tue, 9 Apr 2024 18:30:45 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b%7]) with mapi id 15.20.7430.045; Tue, 9 Apr 2024
 18:30:45 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: lkp <lkp@intel.com>, "enno.luebbers@intel.com" <enno.luebbers@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"luwei.kang@intel.com" <luwei.kang@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
	"atull@kernel.org" <atull@kernel.org>, "shiva.rao@intel.com"
	<shiva.rao@intel.com>, "russ.weight@linux.dev" <russ.weight@linux.dev>, "Rix,
 Tom" <trix@redhat.com>, "Pagani, Marco" <marpagan@redhat.com>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fpga: dfl: fme: revise kernel-doc comments for some
 functions
Thread-Topic: [PATCH v2] fpga: dfl: fme: revise kernel-doc comments for some
 functions
Thread-Index: AQHaii+O0IThw27c/EKdfoaKVZAO87FgQ68A
Date: Tue, 9 Apr 2024 18:30:45 +0000
Message-ID: <5106eb7c65599eca583f146bd18a5fd1836e9600.camel@intel.com>
References: <20240402204743.1069624-1-peter.colberg@intel.com>
	 <ZhS4fuijYnstZ6Rt@yilunxu-OptiPlex-7050>
In-Reply-To: <ZhS4fuijYnstZ6Rt@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|DS0PR11MB6374:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9f37V3Yqm77GI1339PdT2Okh5ZFAB1wIekYDgWmmOv2M9kRGTIzPHNC/bhc2ZT0lAetxMFdZUB2yaiMHAwqoa/u149QM5bkn6C8kE7IxDhAhgtmRyyQdRrtLBGUt9Ye6IuQvpflwMwZWSf3cV03XtoyLDEJgWdjtKIFbqIzwAnRStQIuDNF9YPt3qPq0oBjHfGwnjixW9mlEPqcakftlmSJtMWcilkFHxpIfAfq0RBhUYcnCeAa2AN6N1o2iLLRqZXdh7yCtepIfm70N+CNTD0yuenPx/A5Z7Bg27syzxNkUW5PsbF/k+rJ8XcTQjD0Tg7VsYcvz6vneeKD3J9WAeK33V0ulugmEz6h5UliKSM7YTZVBBSmx13d60FqAzGj9HDKaDL2jvkZdTLPF9YrnkxIrX0+6DBrxZ/WgdhY2Aq7OeExpMaeJI3ySD219Bcnq0jq5IYC7LoSjZ1WxMfGJLH1ecYVzSOULOEOdkkHKNmdsxpeXADgfJtqxwSw8z68W1tUg3VP025zl7RT5WqxxYXAA41ypDhMpAB21+UmDA1S5Vrx3F7v3Qy6OfVivVFUfdBpfOoUKHYusyW0aDpn2Xt7IceyHYJBoTHhcuvxG0MIeC9u3yuVdlua40YwS/5UoekoxttO3yhu7FDvbCNqeoP0HyWpvsTyDyQ2oAvbLGmY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGJxbzlvL3ZZWkhuV3Rkb1AxOTVmQmNFRWk4anhIeW9LQlUybWc3TFNpRjRv?=
 =?utf-8?B?b0VDTjJnYkpCMFNIclRuQ1l2aFJLb3JkMjA5Wi9aQzBiNGtGdVJYaWxEM0V6?=
 =?utf-8?B?Q21mdUxTOEtCdkxJSUVSZ2J6Z1lJRXZqNWhDUHRiU0VLYjhoWjRzSHY1WWJ6?=
 =?utf-8?B?TXpqc0QvL2FJR0hXTXhBc1hzVVhaeFYxbEVJWGVzaXpia1pPajNHclNFS0xG?=
 =?utf-8?B?Umw1dmlXdnJRZDZVMk9YMlc4Qk1vM0EvVCsrVEpXUzI0Q3pXck03Ri9wQjZ2?=
 =?utf-8?B?NWJseUFMOTFVeXAwNHRQa0daY0Y5VUkvVVdoZHNOcFB5emF4R2pWSW9Jc3Q1?=
 =?utf-8?B?RmhKY01Nd20xcHE0VkhrMjJxbGJKZ2Z3ZVNwc21Nai9hNXRrV3pnbFg0M3Ry?=
 =?utf-8?B?RlRuNURneXBnYlY4YTBKemVHZkRPSHUzS0pETXQ1Qm9CZE9DL3Q2Zllqb014?=
 =?utf-8?B?Y3VEVDR3d09JYnoxU2Z0S01qdjFFTUs4Rjg0RjlQNUVSS0s4RG1MaUxRR3R1?=
 =?utf-8?B?VjlrMExSMWNTZHNMem1ybHhiRlEvV1VKM041SVpDN2xJZkdlUmpyd3Y0a0xJ?=
 =?utf-8?B?Y3ZHN2UxKzZkNE1XR3o3SWMyTWd1MSswTG5nVnRIYkFZSFdGV1BVcldxUVhz?=
 =?utf-8?B?Y3gyaXd5VUJjcE5LdDEwL1ZmQjV1L29tejl3SmcwUlZpclBlYzlENjRmTGtQ?=
 =?utf-8?B?Y2piZGFtYUtQUG9nNXlKNjRFbHZlSjJvZ2hQcXJpTEJadWU3amt1UENjNCty?=
 =?utf-8?B?bEF1SENtMUk3cGJnb1J3VDhFWHZmQWppZ0NDY0dSRDJtQzd1NTVOTVZkZERF?=
 =?utf-8?B?Zk1DSDVkMVlHNHVyNisrL21vaEd2T1hFQkJJbG5CQkc0cHNxTGNlV0J3Zjkw?=
 =?utf-8?B?N3R0M0s4RUJqVDBwY2xoTWpJV0ZaWEFsK0dFejVJdFVINEcxdkMzK05aWUg1?=
 =?utf-8?B?c1haS2ZzMjREcTV6S0ZsejNmYWJENjMySmNTUFRydlFCanZrWW9YRnI1UGRn?=
 =?utf-8?B?M0hyUTRNUlJGa1hqemExZzRwSGxvWitIUEkvejU5TDNxd1dDOUU3YUQyNGdM?=
 =?utf-8?B?SkJNNWVtMGlRcTh5dmQ2d1ZQWWlrRXhabTRWL3ZjdGZkRkdqcjgzWEsrNTI4?=
 =?utf-8?B?Y2xzbG1qSHpRTjZNZlU3ck9YQkRmaUxBdU5lSldvM2RkMGdQTDVmUUZmYmVz?=
 =?utf-8?B?eDdzY2FCQnpiTGhNd3NJNUF2UXA4NFFmRnBYbXg1L0N2ODhwYllibnZSbVpB?=
 =?utf-8?B?ZUtSZ2t4SzhYcXc2dXJyRUpEeEpNRkVtdFhueTZDaHVHVnpiK1ppM1daUFgz?=
 =?utf-8?B?ZzNya2xNb3NWRy82elRvMmwxZjV0OWJlakpVcTREL3dnMHVFNHZQWFZvaDc5?=
 =?utf-8?B?N0FwNyt0YWpUK2ZCMEtwU3BBUXdlTWVjVmNzRXpqREFkN0hSWVpTd0l3OFQ1?=
 =?utf-8?B?VzNDa3kxUDE1NUJvaHJBS0NDWVdBVU5jcXBFSkVuNkRiMnFCQ05QaW41ZTQ1?=
 =?utf-8?B?MnVaZ1lGZGQxUmxSTmNZM2ZnMXl1aHFxT28veWZySHUxSDg5T2VvRkFESDRM?=
 =?utf-8?B?UmRBdUU2c1R1WTUxYXMzL1J6ZHAyUlhYWVQ5VXZWSERjbFlPenJiV3IvMXUr?=
 =?utf-8?B?bzk4RjFDdzV6R2J4anFvdUprQm9NN1h1Z1VHblVZQWplREJTb2FTc1BwQUg3?=
 =?utf-8?B?VW1MUExwZHlEaUwzdjNIbGZ5dXFMbTh3aVNwN21kMUEwWDJKVzJSOVllcDcv?=
 =?utf-8?B?aUZYeUMxNTdPeEZqeGlDR21CcXhyMmdHOXE5RnRvZEtSd2wxOTFlVi9jc3A1?=
 =?utf-8?B?YmVwWDhUQlBOc1RTNm1LZzdWUWhyQ2JTM1k5ZWtpdTJBQy9ueTZ3V0lZZXQw?=
 =?utf-8?B?eFBHUFR5YXQzVUNGY3VRNkpVYmFtQlJUZjUrTnNtU21WSXFWamo1VWxrdHRt?=
 =?utf-8?B?SzdBb3A4enBYalB3RmNaS2IzcG9GSUV6endmdUF1UVF6S3JvVzkvcXpYZHVt?=
 =?utf-8?B?S0d2ZzFsNjU0QnIvcG1CbjdxWjlPMGVpcS9GdlhDRjhKdlIxRDdVajRWWUVB?=
 =?utf-8?B?SFBCemYxd3UzYXluME1lTXY3TVBzMHViVFFCblZxUnU5N2xzZ1FiYWlHbVJl?=
 =?utf-8?B?UGwrTU80Skw1M25mRHRKVnV6bjIxUytVaEpQRndsOGJRT2dRbTdhNnZjb1Y2?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C543A8E51A17EC4799EF3CF6897F03CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9c861f-e906-4ed5-568a-08dc58c32b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 18:30:45.1790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fus8CQ/uqFviXeg2OUJnRgxm9+tkYyBBmZWNhOuz/CJ+R8Zgb/Dq0qVBiMouv8mkV6DQmlspaCZ5WL+Wc7y6xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTA5IGF0IDExOjM5ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMDIsIDIwMjQgYXQgMDQ6NDc6NDNQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBGcm9tOiBYdSBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPg0KPiA+IA0KPiA+IFRo
aXMgYW1lbmRzIGNvbW1pdCA3ODJkOGU2MWI1ZDYgKCJmcGdhOiBkZmw6IGtlcm5lbC1kb2MgY29y
cmVjdGlvbnMiKSwNCj4gPiB3aGljaCBzZXBhcmF0ZWx5IGFkZHJlc3NlZCB0aGUga2VybmVsLWRv
YyB3YXJuaW5ncyBiZWxvdy4gQWRkIGEgbW9yZQ0KPiA+IHByZWNpc2UgZGVzY3JpcHRpb24gb2Yg
dGhlIGZlYXR1cmUgYXJndW1lbnQgdG8gZGZsX2ZtZV9jcmVhdGVfbWdyKCksDQo+ID4gYW5kIGFs
c28gdXNlIHBsdXJhbCBpbiB0aGUgZGVzY3JpcHRpb24gb2YgZGZsX2ZtZV9kZXN0cm95X2JyaWRn
ZXMoKS4NCj4gPiANCj4gPiBsa3AgcmVwb3J0ZWQgMiBidWlsZCB3YXJuaW5nczoNCj4gPiANCj4g
PiAgICBkcml2ZXJzL2ZwZ2EvZGZsL2RmbC1mbWUtcHIuYzoxNzU6IHdhcm5pbmc6IEZ1bmN0aW9u
IHBhcmFtZXRlciBvciBtZW1iZXIgJ2ZlYXR1cmUnIG5vdCBkZXNjcmliZWQgaW4gJ2RmbF9mbWVf
Y3JlYXRlX21ncicNCj4gPiANCj4gPiA+ID4gZHJpdmVycy9mcGdhL2RmbC9kZmwtZm1lLXByLmM6
MjgwOiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvcg0KPiA+ID4gPiBkZmxfZm1lX2Rl
c3Ryb3lfYnJpZGdlKCkuIFByb3RvdHlwZSB3YXMgZm9yIGRmbF9mbWVfZGVzdHJveV9icmlkZ2Vz
KCkNCj4gPiA+ID4gaW5zdGVhZA0KPiANCj4gV2h5IHN0aWxsIGxpc3QgdGhlIDIgd2FybmluZ3Mg
aGVyZT8gRG8gdGhleSBzdGlsbCBleHNpdCBldmVuIHdpdGggY29tbWl0DQo+IDc4MmQ4ZTYxYjVk
NiAoImZwZ2E6IGRmbDoga2VybmVsLWRvYyBjb3JyZWN0aW9ucyIpID8NCj4gDQo+ID4gDQo+ID4g
Rml4ZXM6IDI5ZGU3NjI0MGU4NiAoImZwZ2E6IGRmbDogZm1lOiBhZGQgcGFydGlhbCByZWNvbmZp
Z3VyYXRpb24gc3ViIGZlYXR1cmUgc3VwcG9ydCIpDQo+IA0KPiBZb3UgYXJlIHN0aWxsIHRyeWlu
ZyB0byBmaXggdGhpcyBjb21taXQ/DQoNCkkgaW5jbHVkZWQgdGhlIGNvbW1pdCBtZXNzYWdlIGZy
b20geW91ciBvcmlnaW5hbCBwYXRjaCBpbiBmdWxsIHRvIHNob3cNCnRoZSBpbml0aWFsIG1vdGl2
YXRpb24gZm9yIHRoZSBwYXRjaC4gQXMgZGVzY3JpYmVkLCB0aGUgaXNzdWUgaGFzIGJlZW4NCmFk
ZHJlc3NlZCBhbHJlYWR5OyB5b3VyIHBhdGNoIG1lcmVseSBwb2xpc2hlcyB0aGUgdGhlIGRvYyBz
dHJpbmdzLg0KDQo+IEknbSBzb3JyeSwgYnV0IHBsZWFzZSBkbyBjaGVjayBhbmQgdGVzdCB5b3Vy
IHBhdGNoZXMgYmVmb3JlIHN1Ym1pdC4NCj4gUmUtc3VibWl0dGluZyBxdWlja2x5IGJ1dCBmdWxs
IG9mIGVycm9ycyBtYWtlcyBwZW9wbGUgZG91YnQgaWYgeW91IGFyZQ0KPiByZWFsbHkgc2VyaW91
cyBhYm91dCB5b3VyIHBhdGNoZXMuIEF0IGxlYXN0LCBJIGRvIGhhdmUgZG91YnQgaWYgeW91IGRp
ZA0KPiB0ZXN0cyBmb3IgYWxsIHlvdXIgcGF0Y2hlcywgb3IgaWYgeW91ciB0ZXN0IGNvdWxkIHN1
ZmZpY2llbnRseSBwcm92ZSB0aGUNCj4gaXNzdWUgZXhpc3RzIG9yIGZpeGVkLg0KDQpBcG9sb2dp
ZXMgZm9yIHNlbmRpbmcgdGhlIHYxIHBhdGNoLCB3aGljaCBoYWQgYmVlbiByZWJhc2VkIGluY29y
cmVjdGx5Lg0KVGhlIHYyIHBhdGNoIGlzIGNvcnJlY3QgYnV0IGNhbiBiZSBkcm9wcGVkIGFzIHlv
dSBzdGF0ZWQuDQoNCj4gDQo+IERvIG5vdCBqdXN0IHBhc3NpdmVseSB3YWl0aW5nIGZvciByZXZp
ZXdlcnMgdG8gZmluZCBvdXQgdGhlIGlzc3VlLiBNYXliZQ0KPiB5b3Ugc2hvdWxkIGFnYWluIHJl
YWQgdGhlIERvY3VtZW50YXRpb24vcHJvY2Vzcy8qLnJzdA0KDQpBcG9sb2dpZXMgYWdhaW4gZm9y
IHNlbmRpbmcgdGhlIHYxIHBhdGNoLiBJIHdhcyBub3QgaW50ZW5kaW5nIGZvcg0Ka2VybmVsIHJl
dmlld2VycyB0byBmaW5kIGFueSBpc3N1ZXMgd2l0aCB0aGUgcGF0Y2guDQoNCj4gDQo+IA0KPiBC
YWNrIHRvIHRoaXMgcGF0Y2gsIEkgdGhpbmsgeW91IGNhbiBqdXN0IGRyb3AgaXQuIEJlY2F1c2U6
DQo+IDEuIFRoZSBwcmV2aW91cyBmaXggd29ya3MgZmluZSwgdGhlIGRvYyBkb2Vzbid0IHRlbGwg
YW55dGhpbmcgd3JvbmcuDQo+IDIuIFRoZSAyIGZ1bmN0aW9ucyBhcmUgaW50ZXJuYWwsIG5vIG91
dHNpZGUgdXNlcnMuIExpdHRsZSB2YWx1ZSBmb3IgdGhlDQo+IGtlcm5lbCBkb2MuDQo+IA0KPiBT
byBubyBuZWVkIGEgZGVkaWNhdGVkIGZpeCBwYXRjaC4gVGhlIHByZWZlcnJlZCBwcmFjdGljZSBp
cyB5b3UgcG9pbnQNCj4gb3V0IHRoZSBuaXRzIHdoZW4gdGhlIHByZXZpb3VzIHBhdGNoIGlzIG5v
dCB5ZXQgbWVyZ2VkLiBPciB5b3UgYnkgdGhlDQo+IHdheSBpbmNsdWRlIHRoZXNlIGZpeGVzIGlu
IHNvbWUgbmV3IHBhdGNoZXMgd2hpY2ggcmVsYXRlcyB0byB0aGVzZQ0KPiBmdW5jdGlvbnMuDQoN
ClRoYW5rcyBmb3IgdGhlIHJldmlldywgSSB3aWxsIGRyb3AgdGhlIHBhdGNoIGluIHRoZSBkb3du
c3RyZWFtIHRyZWUuDQoNClRoYW5rcywNClBldGVyDQoNCj4gDQo+IFRoYW5rcywNCj4gWWlsdW4N
Cj4gDQo+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFh1IFlpbHVuIDx5aWx1bi54dUBpbnRlbC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUGV0ZXIgQ29sYmVyZyA8cGV0ZXIuY29sYmVyZ0BpbnRlbC5jb20+DQo+ID4g
LS0tDQo+ID4gdjI6DQo+ID4gLSBDb3JyZWN0bHkgcmViYXNlIHBhdGNoIG9udG8gY29tbWl0IDc4
MmQ4ZTYxYjVkNi4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9mcGdhL2RmbC1mbWUtcHIuYyB8IDQg
KystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLWZtZS1wci5jIGIvZHJp
dmVycy9mcGdhL2RmbC1mbWUtcHIuYw0KPiA+IGluZGV4IGNkY2Y2ZGVhNGNjOS4uYjY2ZjJjMWUx
MGE5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9kZmwtZm1lLXByLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2ZwZ2EvZGZsLWZtZS1wci5jDQo+ID4gQEAgLTE2NCw3ICsxNjQsNyBAQCBzdGF0
aWMgaW50IGZtZV9wcihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCB1bnNpZ25lZCBsb25n
IGFyZykNCj4gPiAgDQo+ID4gIC8qKg0KPiA+ICAgKiBkZmxfZm1lX2NyZWF0ZV9tZ3IgLSBjcmVh
dGUgZnBnYSBtZ3IgcGxhdGZvcm0gZGV2aWNlIGFzIGNoaWxkIGRldmljZQ0KPiA+IC0gKiBAZmVh
dHVyZTogc3ViIGZlYXR1cmUgaW5mbw0KPiA+ICsgKiBAZmVhdHVyZTogdGhlIGRmbCBmbWUgUFIg
c3ViIGZlYXR1cmUNCj4gPiAgICogQHBkYXRhOiBmbWUgcGxhdGZvcm1fZGV2aWNlJ3MgcGRhdGEN
Cj4gPiAgICoNCj4gPiAgICogUmV0dXJuOiBtZ3IgcGxhdGZvcm0gZGV2aWNlIGlmIHN1Y2Nlc3Nm
dWwsIGFuZCBlcnJvciBjb2RlIG90aGVyd2lzZS4NCj4gPiBAQCAtMjczLDcgKzI3Myw3IEBAIHN0
YXRpYyB2b2lkIGRmbF9mbWVfZGVzdHJveV9icmlkZ2Uoc3RydWN0IGRmbF9mbWVfYnJpZGdlICpm
bWVfYnIpDQo+ID4gIH0NCj4gPiAgDQo+ID4gIC8qKg0KPiA+IC0gKiBkZmxfZm1lX2Rlc3Ryb3lf
YnJpZGdlcyAtIGRlc3Ryb3kgYWxsIGZwZ2EgYnJpZGdlIHBsYXRmb3JtIGRldmljZQ0KPiA+ICsg
KiBkZmxfZm1lX2Rlc3Ryb3lfYnJpZGdlcyAtIGRlc3Ryb3kgYWxsIGZwZ2EgYnJpZGdlIHBsYXRm
b3JtIGRldmljZXMNCj4gPiAgICogQHBkYXRhOiBmbWUgcGxhdGZvcm0gZGV2aWNlJ3MgcGRhdGEN
Cj4gPiAgICovDQo+ID4gIHN0YXRpYyB2b2lkIGRmbF9mbWVfZGVzdHJveV9icmlkZ2VzKHN0cnVj
dCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSkNCj4gPiAtLSANCj4gPiAyLjQ0LjAN
Cj4gPiANCj4gPiANCg0K

