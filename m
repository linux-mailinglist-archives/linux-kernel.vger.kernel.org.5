Return-Path: <linux-kernel+bounces-148922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D428A8907
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C9B8B24BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD55117109A;
	Wed, 17 Apr 2024 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIK6xSzZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB5147C8D;
	Wed, 17 Apr 2024 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371934; cv=fail; b=HsgsUXGpqMOmxGGHDkP3aU6QPlwJzt2TBtfb1MpUlg9VQ7QryJGx1p5gRu6nRzMjdpiOHYwvHB/nVtszxBtqWec+f5hwhb0oZD7mH1ZNl/jfbw3Kukyy1ngD17VatQuZ6SRuYFzHq810JvKZYmSluL6pCjX+BoM0uBfhWPiR4AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371934; c=relaxed/simple;
	bh=H6UXoqJjtNjlZoVMwJtGrlurr2cifNYBVXqotsTIABk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e89ra8WGmPbEwR+fqji/T/6gPPKogTlgV1mNbKTf6X+ZZNfCmTlZj1NeYjM8AlkZ3VZ4WFiXWOdVbHWmH5VAHRIIK5gwmIBwvC3FjnpuWuMUEWDmJwSnmyySTppbxyUCDPCV1G0NFLAOX7KbYJZwxBanTqac4aqfTlIpJxsuLQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIK6xSzZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713371932; x=1744907932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H6UXoqJjtNjlZoVMwJtGrlurr2cifNYBVXqotsTIABk=;
  b=hIK6xSzZcogjk0+rCBkB54ivOPaRpAhUEWFOFdMnGRMZ+zF9CA7FWQJM
   f/EM91l6Q5omZvQ9RzZsMd+IUNH48jYFqMtFAdRmcXCQKhkSpY5CkLWY/
   ZAdMQE2WxX7TGAlWJvOylZ7LGVJJD/BY1yIuQEaHGDENUc/J8gcQGE4SH
   C6neO0bIIXHwdrDpt1nYxvHSv4gdQ3n2YLQcj0E5AIz2Ra2wewFQKfrhc
   hBNu9+L+S9jAVqMxmnmLGliC11OKAojUaJZ5wgBiWpZ/D5LXK1GORLl40
   0adyxRnqUPjdqpr8Bxu9Ya4jKqh5i7wOy9bQjTTfgGxEu7NEA4ZxVw8Dq
   w==;
X-CSE-ConnectionGUID: 9G6y1jIzRfaC/ETWedCjfg==
X-CSE-MsgGUID: cqemHZ+qQVKnY2lR8uvibg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12657461"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="12657461"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:38:51 -0700
X-CSE-ConnectionGUID: Nvo+OHzgSk+OiFpnSrfpqw==
X-CSE-MsgGUID: hdefRZlYQ1K31A9EdysxWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="53626831"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 09:38:51 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 09:38:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 09:38:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 09:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dodirD6BSL3f7T+gZH+mfE+4v5Yk+hmMYXrHxbvBM3SGC0unN/JvzNjgUUNaVuAU0Mu1fqgSFiMQR2k9yubyB9Ez4vXoXhyk3n0Qp626nSwsh+5UpSfuH/yew360r1KK/VgfCLpUZEaXSzcjjVH+Gk9INOwcCa0ooYTtzCUWyEh13CbKuJrXqcMhyPL2xCo5DDi7TlDSqyhSPaQ5kjcLBkLPAJ0BioSW8a4qw/RPtmUhYhLUqJ9Ioz7ThCw2MH9d/f3f19EDChK+5qdIuFKvKzNw4s9RDGUREmx6gonoOAqCH4aHRQaRAN0O1xdH7BgkSn9NqlGx6uW2oLnbY4z0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6UXoqJjtNjlZoVMwJtGrlurr2cifNYBVXqotsTIABk=;
 b=BAs3fsWt4sxMR4Q5y8zzRQozbayNN4PPY5Tir4sXnnEAsygpojqj/Vgj8V2Z4DQdoPiJvyW6//1KpPF/KqflYdnARr+yaj8wOe88Ath0D7r6jw17g/U8E+xs/eNXaeNCjkvERAWXem/jrh0IDwCkHa/D/6i23g5xpCNMoS57y/LLqkJdh9rro6Qcmics6ecc9E8xJ/rRd2XvDuAEXjL1Q8kQHM0Nsw/JvPgD9g7/Lt3E7n06syUM9gMRIdPeSUVLNhtadDmiyuMvbEFVorW0KXvEBkBd/MK/+j+gujxEPX5u5PV7uZL9YcBvAgzC9LeXoaichfsrBFm8LwpITshdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7830.namprd11.prod.outlook.com (2603:10b6:8:f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Wed, 17 Apr
 2024 16:38:48 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 16:38:48 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>
CC: Jason Gunthorpe <jgg@ziepe.ca>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v3 42/74] x86/cpu/vfm: Update tpm files
Thread-Topic: [PATCH v3 42/74] x86/cpu/vfm: Update tpm files
Thread-Index: AQHakEQmjfJi/G5ghU6aC9ZX8qBX2bFsmwUAgAAOsCA=
Date: Wed, 17 Apr 2024 16:38:48 +0000
Message-ID: <SJ1PR11MB6083CC350A16FED86B109C81FC0F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212202.9452-1-tony.luck@intel.com>
 <D0MIG62V6JNV.3OZB5M1T63T7@kernel.org>
In-Reply-To: <D0MIG62V6JNV.3OZB5M1T63T7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7830:EE_
x-ms-office365-filtering-correlation-id: 9230c680-e7b1-4c87-3faa-08dc5efcdb26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: awUxBgbtMEmeRYAQUb9tKIvhrjK87mG5SXQvBGrojrx3XX23zUtrqiVIrT1xDppY/589wZN9Xwv8U5Ftf5DAbzbwVThFPaXwQoFaU8G4Sy9DWM+TBkHsvyKmc6GPGlafBfrG0eiFDG4kbhlNwuxxQSbMLflq2CS0XwW+h4qp0/HyyPwUPkMocSJm/tP2r9kocHtObkr282VzWdUsicwhgk/OY6bsJTWymp5gISwgTffo6a8v4rhR6nDTIYhlouRvQdDZwnHozFEjWZ7JcY/OoX4vLdIA/NPnX6Y+2oZWrRrWWmhh3F9BPs3XjCM9XkVTN7M8wVCp1ThwovfrGM5R8/t/CMXPbq9AwUH3NYLQokzPWs/rn2tkgmj9R/NDQvFDFNE71YpnW0LT7wB/riKYLgs0nokzQSD6nyUlcA/d7OKdhF3lxftn6kVndZXroBbl1BgH1ZpbQ+7bBB1OxDGogJEhRjnd+2qd/a4khArwS0nZ4N3Kc/yXdcfYGOiWpoBfBEglTMFPhT8MCgcDW0NFXMFvBqFGZ/ZUvHSkLL3kZnjxmtQcwbb039WVUSJGAPCd9iKl/kUmFKjZlxik5VDTtoxGirJTm3WmQmTq++/a2b5ExBVtYwCG0Lru0Gbe5bxuIl/OsaoDKuzyqhFbLtXD3dKspFI8fgjN9IMiKuZnAGQkIxl1hCS+XPelMm3ujlAmE2cupOIIYBduKQOOHVOLkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXh3NGFYNnpxUzdIODkzWkNWMEIwZzRRMmZnQ0Vab1dISDNUL2tiWWtjbzJQ?=
 =?utf-8?B?OTZoaU91MXp3c0hZTHRHWFRHSEk0OWFYL2RVMDBJOUlhYTc0RTRqV2NUZWNB?=
 =?utf-8?B?aUMzU21IVUN6YlFNdVNtLzBIOUROMGxBOHQ3UTdMREhJOTBYRTNBZW9HWmR2?=
 =?utf-8?B?LzNMdXRJbjduUGVLaVBVblNIM1pvY1lCVDNJRitQTTJFR2c5MHdzMytUemNz?=
 =?utf-8?B?YXZSTVZpZFR6M2FObVJRWFFlQTVLZVNubUpoNzlpWWpGNWlCaXFwamNYTFQ3?=
 =?utf-8?B?SHRzMTU0WThOSjViYTdncDRiRDhWQUNaQWpkenJQbFdPaVJVUDYyTGdTalJ3?=
 =?utf-8?B?T3hLZlg2ME53akkwMWlGZGFMRGluRnZSTWp4RkJJTDhETmo5T1NYdWFoK1lY?=
 =?utf-8?B?aUVQUTVvYnJHVDZFckppQm1sYzlNYVpWMFArT0paMlk5RVFlMlhEa1JVSkIv?=
 =?utf-8?B?akgvcHBCalV4RXZSL0NSVTBHOVBYamZLVlNUOXl4ZTFxaVFoZE0xZ1pjYnhE?=
 =?utf-8?B?U3RsK2V2bENsMHYrT2x6YUlFOEJjM29LZmgvbmt0aEMwamsycjcxRzNVMU9Z?=
 =?utf-8?B?VllKc0E4cmZxYWo4MDN4QlI5UEtpbWpjYnlWeTVldHlOWVptWC9mM2FIWUdU?=
 =?utf-8?B?SnBpaEpZTk03akhheStWN0xIeS9ERW94cUF4bXRYTmpjblNWdWF2aFZJRVdQ?=
 =?utf-8?B?NllpTVFlNmI4Q3R3Z3JremZ5RkJYZ0xqMVlyb1RQRENpTjQ4S3Nid0VsMmp6?=
 =?utf-8?B?bVB1SUFxYVEzWWFZNzFpNnU0RjFJTW5kQjkxc29abHUrUkhGbWRnRWNhTWx5?=
 =?utf-8?B?VmdQTU12T0prQ3pNTytSZWo0dTRnUWRnVkhhM2dnMHVDcW82NzBoQ2ZGTUFM?=
 =?utf-8?B?LzR6by9USEFqWEYybWpoTW83bEw1amVvNHlYWFRpaENGQkFXT0RDTlZsSzFJ?=
 =?utf-8?B?RWw2VDJ3QXUzSW54WXB4aS8vOUNvY1JEVzMwcE5jRjZ4OFdTcWo1ajBvb1Q1?=
 =?utf-8?B?OGtzaUhQYzBuMWpjS0xGZHVOOXMxcU9TRlIzdVVDUjVVYnpTRGhGYXNUUXgx?=
 =?utf-8?B?K3NjNlZNMHUreEo4cy9vN0VWSzNWeEtjaVhBWVVINW45VWRMcWNNczk1SXpX?=
 =?utf-8?B?ekxISkNKQ0d6L3hRU1R3T004bFE0RVQyd0I3RytiZGtmR1o4SFczSzhmMzAz?=
 =?utf-8?B?c3E5VnQ4L3U5Wm5YcHJ1UmlMNW53S1pmU2hwZHpxZFVTMHFLN3hqNmlLYUdl?=
 =?utf-8?B?ejZvckxjd3J6T3lxWXgwY0VkTGVSZHZ1MUI0a3JPajhZTzBoUGp0NnBGWkhT?=
 =?utf-8?B?Q3E5Z3BsMDZ3S2JuN05RNXNPSVV3YVdwS3Z1VzUwYTV3cnVXOGJreHNZK1k2?=
 =?utf-8?B?THRiVTVRdXlnTHRiWDlqOEQyaGVxMTcrL0RoRjd4bGhtdmZkSUR2VjU4bGox?=
 =?utf-8?B?NC9QaGhVYlJnMXZvS1NGQlRZUDlacG16bkdOZUhyZ1ozNklPVXRVaThVWmJt?=
 =?utf-8?B?YmhscHFqdVJaY1V2cjhnUkU5L1pOK2loeVRWWXZvaURBOWE5bE0xbjM3WHRY?=
 =?utf-8?B?eE1iUFE0RGNORVgxVit5U2RwTFVDT1EwR0tsZjdRTEtWVzZZMHVqd0hNM3VE?=
 =?utf-8?B?ZmxhWVJzNmRqYWVDS29ZTXJZckpvem9iSFNveEwxQ2MwSk11Zm9FVE56d1pO?=
 =?utf-8?B?UURKYjZyMCtSUWVjeUdWelNBRnFjQktyMEorc2x1NTNsZkVSZHlFQmJCQzJm?=
 =?utf-8?B?SXNlL3U2cEhuZ3dJZGs0ZFEvNExkMHJ6ODR5ODFVamF0cEpnTHJKVVZuc1JY?=
 =?utf-8?B?ekZuWFEvQnlXWFdvSU5BSCticXVJeTlzZDE5WXVtNWswWEppTWZZSlZDYVlJ?=
 =?utf-8?B?ZmxWbWxZbnFiUGJzbjhyb09SZFg0OWZ2OE5PWVcrZ0NQL1FzZytVRFZCQk1P?=
 =?utf-8?B?S1dlMmNzd3p2dEFibzBsV0ZyNnowOXoycHFqemVMUTRJYzBCZFJkTWV6QnVj?=
 =?utf-8?B?MHhWYURIUTVHKytIMk1Wc3ZpWnhkN01hTmxDeWdXWEdmRE44RkVSblRtdjhF?=
 =?utf-8?B?ZzVhcW1aU3VtNndlRG5oMHk1TytBTlZYTHp2UWt4ZWI5UUhmMWRtZFRMWWRp?=
 =?utf-8?Q?ym8jqB0hUu39bKj6uSCuEoMGF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9230c680-e7b1-4c87-3faa-08dc5efcdb26
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 16:38:48.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kll/Bq1GzjHvDvj3gIYAFZJSXUwXghYZs/iVtPNLIPp/ZLfWkbFep5la8stGIu3nxRxSiwK/Sk116ZE8x7w59w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7830
X-OriginatorOrg: intel.com

PiA+ICAjaWZkZWYgQ09ORklHX1g4Ng0KPiA+IC0gICByZXR1cm4gKChib290X2NwdV9kYXRhLng4
Nl9tb2RlbCA9PSBJTlRFTF9GQU02X0FUT01fQUlSTU9OVCkgPyAxIDogMCk7DQo+ID4gKyAgIHJl
dHVybiAoKGJvb3RfY3B1X2RhdGEueDg2X3ZmbSA9PSBJTlRFTF9BVE9NX0FJUk1PTlQpID8gMSA6
IDApOw0KPiA+ICAjZWxzZQ0KPiA+ICAgICByZXR1cm4gZmFsc2U7DQo+ID4gICNlbmRpZg0KPg0K
PiBUaGFua3MhDQo+DQo+IFJldmlld2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJu
ZWwub3JnPg0KPg0KPiBZb3Ugd2FudCBtZSB0byBwaWNrIHRoaXM/DQoNClRoaXMgZGVwZW5kcyBv
biBwYXRjaGVzIDEsMiwzIGluIHRoaXMgc2VyaWVzLiBCb3JpcyBtYXkgYmUgYXBwbHlpbmcgdGhv
c2UgdG8gVElQIHNvb24uDQoNCkFyZSB5b3UgT2sgd2l0aCB0aGlzIHBhdGNoIGFsc28gZ29pbmcg
aW50byB0aGUgVElQIHRyZWUgdG8ga2VlcCBhbGwgdGhlIHBhcnRzIGluIHN5bmM/DQoNCk90aGVy
d2lzZSBpdCBjYW4gd2FpdCB1bnRpbCB0aGlzIG1vdmVzIGZyb20gVElQIHRvIExpbnVzLiBJJ20g
bm90IGluIGEgZ3JlYXQgcnVzaC4NCg0KLVRvbnkNCg==

