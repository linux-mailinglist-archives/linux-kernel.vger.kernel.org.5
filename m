Return-Path: <linux-kernel+bounces-133215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF6F89A0A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2261F22120
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B1F16F841;
	Fri,  5 Apr 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTuz4HPw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBEF16F293
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329548; cv=fail; b=U5Z4FKvH+MZHue+fc9z2ZYOw3XDPzWaZkiqueDoTIv6ImI3d2JUfo/Iinvh0LnbCha3YQo93auWJW6cscZJ/cA0GB+06Z5XhgAO0DaMApxJmCABtwi6o5ZtGmAOLbeGGxq+hECRx3J6GvwohSb68seM2FWX5wyzqks66B/mVesQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329548; c=relaxed/simple;
	bh=ri1IYmShq1ZSBf9O+ziWs/IfPJWtwkyH/zok7kphwyg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sLND0EGZs/XDWjPJhRZEpGtd8K7f/WpThjx0HmDBm7TCm5Z5YuLyfd96HFbvY+aHIWuoNFk2+Oc10Xw+FXpO+nX9paBL+gkH/bXzFbT+fwiUKsMufwdjfiiYnfo63uImtGVEtJvbzUYDGYKZ2lrLYThf7CBufJt5EdWrsntbaZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTuz4HPw; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712329546; x=1743865546;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ri1IYmShq1ZSBf9O+ziWs/IfPJWtwkyH/zok7kphwyg=;
  b=VTuz4HPw1JNRG0cQSM/5/dZDKORztxsXMMb2PZxTbMGs0vTlKAdqnpS2
   s/C8r0dgBz2td3tOfSicuc+Oaa5rshg1wRXNMYHXlyJ1BheaFZ+tt1Dqh
   YY0ljxXo9FQDbO07A3AIxNZfwfo6G5JQ2XX6qz5RdRex4qKIGQnspkCaJ
   e+Q/1FXFJBtMCpsX5nQdgejy10BuvdYuBjq1EuPNLyL9kQfDIT50IMI2C
   YiCqmgg+QzMeK2t98AiD/6eUXekvjbXTyn8kyL/3dXFbZdlx5DpmiAsjm
   4D9myKpyjWBsCpaLB77CuHi6LtHvePVBfGvGq1WlurF5dkdflHJG0LCr7
   w==;
X-CSE-ConnectionGUID: KHbmZn9TTBCTXfnuAAHy3A==
X-CSE-MsgGUID: xSrjvXJNRRelM0WPMM79iw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="10632402"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="10632402"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:05:45 -0700
X-CSE-ConnectionGUID: kCnjGWqkQR2b5GP/6WiEEA==
X-CSE-MsgGUID: PgWYIus8S5Kb4r8dQR2sRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19640430"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 08:05:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 08:05:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 08:05:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 08:05:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 08:05:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jX3wQsXA4BOnE+FMb3Bua5PxQ7fyctlSGj6AYbWnElCasgV5v1Oa+y1lNm7Q60JNgM9N3iyLF+VPWvsxqexvGcppchL3WaLnWBIlHXz5z36In8/0rxuJ1z0iKVig/3FGViQmkdtMMlc1VEzlShDrO59IpKerSw4Y/RcaiYpGGh3ryO1UQJYr5+BcWQMY4PtXF/oITfwXl/zRkB256K2RqJe9x1U+Gbm6VP22JgMPQBfXyFZSpbbxw1IUK51OlwIpfU/bvNz1SAN+IRQdUQkAt/LSfzLxrnwYwwN5DoCi74a51VNposUGSgukKuc8TpZs+2dMnYt3Ex58JU4FAM5thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri1IYmShq1ZSBf9O+ziWs/IfPJWtwkyH/zok7kphwyg=;
 b=AEtNKtih/emq3BDCOC7zd6jUMDdIQRS6uHPBg8W/u3TOmRWtNY+c/AOyBDI0/tc2a3xG7ARQ1ErDD+WigyYFBJYDOadUB/oUeptK5zVPPIH/tg5yNDaCLjmEvx6fd2mB0LcqeSjTW/guAe6nFrCYJxdlwiJho0hffDmfQK1yfUlBzDcxZkaEJVjjZZPqSRRVQwwSMsKYOyMF1IQpsafQEqZ2VgBZRuEYa+ecsZqZG1cvfIbNaXBRz047qmeDl7SL34vq2UzIddOizyi2nP1XnEMjs/b/hMQjU6g8CB3hS9M44wyTq2a2YgQ3jatND6zWnG/4QxrUWXGqBlvcFge4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA3PR11MB7533.namprd11.prod.outlook.com (2603:10b6:806:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Fri, 5 Apr
 2024 15:05:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 15:05:17 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Machine check recovery broken in v6.9-rc1
Thread-Topic: Machine check recovery broken in v6.9-rc1
Thread-Index: AQHahymLPB0TDn1nE027XBXiiAzj6bFZxGew
Date: Fri, 5 Apr 2024 15:05:17 +0000
Message-ID: <SJ1PR11MB6083AB3E55B7DE0D3FBE185EFC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <Zg8kLSl2yAlA3o5D@agluck-desk3>
 <1e943439-6044-4aa4-8c41-747e9e4dca27@redhat.com>
In-Reply-To: <1e943439-6044-4aa4-8c41-747e9e4dca27@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA3PR11MB7533:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c4GKdipb7xfQfEUWm18Jv/aviTlrMCz7hV6njALW2cFCKW3dhMNEF+Nt/SidR6nCxUJQgGzG4xEeeL3YjD7MwVDe2vMbchPgGJd7iIbHqjv7ZOTCM6CUPBjOKRwpsF7q0Iy1brUKfrrr7CKwRowhgATsotzmkwt0A7pYcxQ9bUVCYx2PNHnsnV15XPLs2CI/MflluDLOKer8NRVQBHarSd3GzBQQvoMy1BFW4BKdlw/q9xC3mz0Kf6ZQexQgFvrAKUtZ1cHJwN18B7O8RPzQZymaxpXfRnn086x2/MeuLwSb1Xu9T0t02abtb7bOief3HcNamuXZ1KosU2oZbXzs4ckHC7xq+MFAp/z0xw338E8ktI9+Nt+hWDcUPRl4Pmf2FOP5TtekMn9wH1L+Kz/6lwrlu9vJDlhlLZMGB5/xxxnfIOiSDMg3CvhViZbX7YUUC4Lm96LQQSdJKgSHc4Mrh4lDtkI5eSyFHmMoBrnC+Fbowb0TVrHFuHjQZNbuxJs/HSGofmvdCLgpwoXng3+/AcvZC6x4Ey7EphoDNXUieb4eUGW0xxh7go72C8MNjos1cfhlcDryjrbG9Hj/RE3osuMNpgzOtuLGivUSjS5LbEVIQfsx2eMLuRo37e5O1xl/U5stot+2RiJS3CaqitzpjkT8MYLt3rkju8U7S25cNbA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2wwK1AxT0lzS3dLSkRJSVJxSnB6QmFENEtmRWozU2o1cEhqN3BGVFVrQ3FN?=
 =?utf-8?B?b0RrZ3c5dkF0ZlIyakV4c2dPRjZiT3Zyb0FVbzZwcDgrRWJRcEx4Sm0wMHBB?=
 =?utf-8?B?UXlQcDRFcXFWUFN6cUNjNll2ajZ6TkNrSmZpMFNDOENQeWM1NURBTUNWM1NO?=
 =?utf-8?B?Mk5YVWVmNmkxNmFLQTRiL0N6UWZhMFR2ekR2UFZ6TFBWUk5VUDJVanN3Y1Fo?=
 =?utf-8?B?SE9QTGVKdDhLNkt4SHBxdmtWYndZdlhXOWYrdDZGZ3FHSFU1MG1jaTB2czNY?=
 =?utf-8?B?a0laeFprMENFdVIrR1JCc1NBa3FFVmk4Y240S2k0S1IxZG5OZlBRR0YvUTZC?=
 =?utf-8?B?VVE0eG5mcXlDQUxXZGw1T3pYMHdwbEJ1WTVEK1BOZU1IeUsvSFh6NXdPSXJX?=
 =?utf-8?B?M05IcVJHVWJ4cEQvNzNsVmNVb3M1WlVrUmxyYmpxeU5id3YvVXlBQlB1NXJr?=
 =?utf-8?B?NEduSm9UT2FSbXVaeWR3RTlHUElCK1NZNVJCREdsMkVJd04xaC9tditnZElR?=
 =?utf-8?B?VjlMTGV6V1F3ZmdWcGtxY0pYVnAxcWt1by90MlhYa2puYTAvbklnQXprZXJB?=
 =?utf-8?B?T0ZWWHY1S0xXcUZMYk5BUFFaUWxTM0JIYXk3ZC9UQytlMExnamo4WVVweVFF?=
 =?utf-8?B?eWZQOUdaSUZYQjB5U2YyQU8vUDlJbkljQVQrYzllSmQ1THJuMllwMDJwd2ds?=
 =?utf-8?B?TC9xelZSa0ZCZWhJMUZTamRPMEovd0tRTnhhK003UzEvbklyWlNWVVZxZmRx?=
 =?utf-8?B?YmVscEw0bXJYUVNaNkJnakF0ZTB6aTVSUFVpQTBia0NITC9Cd1VuaENjbnVj?=
 =?utf-8?B?ZWg4a1luWEVSMTc2aThBb1RMSVZWQlVZbDFZL1FRMTdtUkltZ2x1K1ArcURQ?=
 =?utf-8?B?NlVUM0ZxZmlsWGlraExPMiszdFlkQldteU1xekJZSlVPbXBmMnhTVG9pb2NP?=
 =?utf-8?B?MHZTdEVsQnUrN0R0SWl6ZG9MOE5xTWJwL281RGFkQWo1Z3RraG0zbVB1N1kr?=
 =?utf-8?B?b2ZZcm1uY1pSRjR1T0pEYTFUejVYbWtLZ2ZEMlVGb1ZWdkM5dVRCb2gxNnJR?=
 =?utf-8?B?emE5M250RVBXNkhQVElZMEE0M25Mb3paNXBxZ3p4dGcxazdvU3ZGYnhhNFVM?=
 =?utf-8?B?dlpRODh0TTYzM0R6bHlQS3daWmxUYTZZc1dLZmtrcHkwNlRuOWVZWUgzcFd6?=
 =?utf-8?B?aWxvYlAxNUhiQnFHQXowY0JUby9LWGs5emQwVEpET0p1QlZacjlLVkhieUZ5?=
 =?utf-8?B?K3hFNks1UFF1c0RIU213OGpvMDArT052bHRJdnJYS0RVdS94NEEwNnFtM204?=
 =?utf-8?B?YTNiKzFmcUZ6c3h4NHJ1OFNlWGpjMGtidVhXTlFVcGc0cnBVR0FCUTBkNzZN?=
 =?utf-8?B?UzlzSFZNNWhKZmNoNWphZC8yU0g2cjY0a0VNMmdFS0lnNVVOZGxST2RWVUkx?=
 =?utf-8?B?K282WXRMRys4VDhNMjY5b2l3eThwRGw2cUVOcEFiSzNncTB2NkxIK2pKMzV3?=
 =?utf-8?B?NlVEVVVlWmhyd0lCTUZIVU5JR0N1TnlCYTFSSHA3d3BLcnJlZ294K2Yva0ll?=
 =?utf-8?B?Y1NCclFnczdLaXJPVHJKSVZnUmFGSFErd0thNDhLS1JYQUF1QU53ekRNZVI1?=
 =?utf-8?B?c0UyU2FmN0dhVlArNXAvVTNZb3p2SnRSaEE4dlQ5cGJWV3FvbjVtSXNBVld2?=
 =?utf-8?B?WHVjaUVVMkowZnFqWXhPZUZlUWhlQlNQZzYwWkJEMEZOaEErWmlLSnYzOEVB?=
 =?utf-8?B?a2xGdHRhZTRLRGg0ZU9ORlVXNEdmVlFweFhlbkU5T0xTUWUwRVNLTzFIZXRt?=
 =?utf-8?B?MFhDRkpvVmE1WW9vdVVQdStDUUNVdm5wS1pmb3RKMExqOFJQc0ord0xyeFE0?=
 =?utf-8?B?TWs3T0FoeS9YeEhRQnY0YU5STjFUUWY0QUg5eEtQZFlLWWEyR05CVnZNZmVR?=
 =?utf-8?B?NXhXT1NtTUhiNlEzQUlPMXVneFZ5VWpNOWl4dTRyc2dmSE5lQzFkUzZYZnJB?=
 =?utf-8?B?aGdKdW9ndmFvNGtobVk3TSs0WXBoUkx0ek05a1hZMXhVbXQ1QWRPT0hnZWV5?=
 =?utf-8?B?Z2t1OHhTU2tzYXZlalhvQzlMKzI4eWEzbGhRY0NvRUlFb0RDeC9tR0pQUjAz?=
 =?utf-8?Q?fXghBKHxyxZX8qzheRdnJTtW8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e293bb-7bb2-46ba-0667-08dc5581ce40
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 15:05:17.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LaP3jiPl3wkR+ocqXkV+HoRdMidQFIiMBXEbaG9Ufp4xqe2llQC40YdGPxy2DgKtlcObzSJWMZo7lGya7O1Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7533
X-OriginatorOrg: intel.com

Pj4ga2VybmVsIEJVRyBhdCBpbmNsdWRlL2xpbnV4L3N3YXBvcHMuaDoxMTkNCj4+IA0KPj4gMTE3
IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBzd3Bfb2Zmc2V0X3Bmbihzd3BfZW50cnlfdCBl
bnRyeSkNCj4+IDExOCB7DQo+PiAxMTkgICAgICAgICBWTV9CVUdfT04oIWlzX3Bmbl9zd2FwX2Vu
dHJ5KGVudHJ5KSk7DQo+PiAxMjAgICAgICAgICByZXR1cm4gc3dwX29mZnNldChlbnRyeSkgJiBT
V1BfUEZOX01BU0s7DQo+PiAxMjEgfQ0KPj4gDQo+DQo+IERvIHlvdSBoYXZlIHRoZSBmdWxsIGJh
Y2t0cmFjZT8NCg0KSXQncyB2ZXJ5IGdhcmJsZWQgYmVjYXVzZSBtdWx0aXBsZSBDUFVzIHNlZW0g
dG8gYmUgbG9nZ2luZyB0byB0aGUgY29uc29sZSB0b2dldGhlci4NCg0KSSd2ZSBhbHNvIGdvdCBz
b21lIG1vcmUgZGV0YWlscy4NCg0KMSkgUHJvYmxlbXMgd2l0aCByZWNvdmVyeSBnbyBiYWNrIGZ1
cnRoZXIgdGhhbiB2Ni44LiBTdGlsbCBsb29raW5nIHRvIHBpbiBkb3duIHdoZXJlIGl0IHN0YXJ0
ZWQuDQogICB2Ni4wIHNlZW1zIGdvb2QgKGNhbiBydW4gaHVuZHJlZHMgb2YgaW5qZWN0aW9ucyAr
IGNvbnN1bXB0aW9ucykuDQoyKSBJdCdzIGNvbm5lY3RlZCB0byBhIEJJT1Mgc2V0dGluZyB0aGF0
IGVuYWJsZXMgQVBFSSBsb2dnaW5nLiBJZiBJIGRpc2FibGUgdGhhdCwgY3VycmVudA0KICAga2Vy
bmVscyBkb24ndCBoYXZlIHByb2JsZW1zLiB2Ni4wIHJ1bnMgT0sgd2l0aCB0aGlzIHNldHRpbmcg
b24gb3Igb2ZmLg0KDQpJJ20gYmlzZWN0aW5nIHRvIGZpbmQgd2hlcmUgdGhlIEFQRUkgaXNzdWUg
YmVnaW5zLg0KDQotVG9ueQ0K

