Return-Path: <linux-kernel+bounces-138798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B6289FA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E7A1F2DE3A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7098D16D9DB;
	Wed, 10 Apr 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAy6ytnX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9B16D9D0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760078; cv=fail; b=RwkVEjPwyEkr8Sor4Z8x+dYen0sAGWKnIP2shUu4AHGivn02zTXAn9Pjai75f4Xp8p3CE6pCHcoIZSsvxGgmBpAcZ//yEYDpCS3JnPL7IA+sIOsw+n3c6Sej8MgTvvOUdc0ijKWxIsYnVVorlktQkmdYtfyZc/3aZ//+JzMSgX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760078; c=relaxed/simple;
	bh=+wmv539NzYaISibItOaGd0nhPCaie+Jo3vPR4RNzQuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G9HkNm+alLozXwI2PqcZ7bDpwoIMy6CMqrDH0UFUvJBfgdQDKApcuMFPJ6ThRFlxuHYLC0CgkdX+1R8E+AcRKdU6QF7NXJoYiwpk34YHL+7HcDcIIWh6c8ErjgwKXA60imjKeVR3UQObuh1arf4Nm9hqm5uwKUWr3SOFoCHtE5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAy6ytnX; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712760077; x=1744296077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+wmv539NzYaISibItOaGd0nhPCaie+Jo3vPR4RNzQuw=;
  b=nAy6ytnXMLBm1w6k9ouBlprbmcroPqhc8jEt9SA/S1wqoK+UFTvFYuoy
   zHQtPprTJqk6A03cBvockC3mSpF+13gnp9L8MmjZW+KU3N14zDlIeqNpp
   K5atgny3dfATd0ufT2fyVLTfalhbrqyI2CJ2LuJzBsmTUIxCBK5sJ3YyZ
   6xtOTIYwOr9W9HMOkML8bGZZbL9ZYBZXDQ4xuhn5rJ4p8rg0N74PZL8AB
   u8aMw4yUSfCkBm4KQIrYTb6LC9nsWhuDKcw5h2yLVnOspxJLKpoPaNPZl
   oihnSkhF/13raghxG1BTdgf+PFZeEskZFUIR6IUUNFsXpfguD7I/frvGt
   g==;
X-CSE-ConnectionGUID: t8Q6/SDtSEmD5QuLBO7zSw==
X-CSE-MsgGUID: NGzNsKMpQMG0pttBoUd6lA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7984054"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7984054"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 07:41:16 -0700
X-CSE-ConnectionGUID: 380xAYzzTZi7Vc0IhPlOQg==
X-CSE-MsgGUID: RptTX7BSQr+8DwtNsZWVzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20597991"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 07:41:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 07:41:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 07:41:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 07:41:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+YJCKgasjRx+5ShYV0g+3KI/f7pjDQbHpaKKarRAOaEUYqb4I8aU6RE9RalpQ8ell5a7eZ4PN1Du1/R2V2GmL3LsmNRzkpgzBvzBAxWg1hoP59m32qZVgBe/i5Y6xmZ2bXC4QqCSUxSpcIVtrN2nskK7k35YuFl55F2BtsqrVpouBylOHOBuq9lhpWWz9jGIJqYAtqHRcCRmBbRewnrs3ifVnVhqH38Sw7fHAxpWXpvbak+pA20J4uYzDD9QNB7SXfs7bBszFIF5KgEQEvGTlTNJwkwgm1D/If+kqd6TCG6vt39pEUQrMbtTf+FdyaJDLzGqkyMFt8DtmXT3WjvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wmv539NzYaISibItOaGd0nhPCaie+Jo3vPR4RNzQuw=;
 b=LzmTNUYy/QQjkICfsAe4iVmBg0M0+3hhZUBjQiBdUfbfjShB16QDICUiMmEtLfXvp/tlpAl18AMd8Yuc0lC06U9dOnpQnzTgiun716XAiMy85bq5vQQRfG+mrphv28ChNQLjLfZkucSrhM3l2CCUuEsHOSREvk3IOpxOujsw8y8vgDz6WiaxQUOp27uioe17I8iX5YHMTFjB8HpggJtDQdfGbfNxdpEh9pRAhpgPJ2d1PhmG+L988qR4+Fb/GUqFIKYFMCTmviXUYNofW6Fq4DaDJ0a82U/CZ84wh7f7VKhRb+50egQXIqHYNk/uaSxyTX8VRPyzs9kK8wg7SlLoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7042.namprd11.prod.outlook.com (2603:10b6:806:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 14:41:13 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 14:41:13 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv2 0/4] x86/tdx: Adjust TD settings on boot
Thread-Topic: [PATCHv2 0/4] x86/tdx: Adjust TD settings on boot
Thread-Index: AQHafqGvjWJLBDxl7UOL6WDDV1721bFhq+qAgAABFgA=
Date: Wed, 10 Apr 2024 14:41:13 +0000
Message-ID: <46cb81e0dda6196a1339cdfc93ea93f2d13c3e4b.camel@intel.com>
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
	 <sbunoj5dm6xifhqog5aaeujrbiilfqufum5msoiqtp2di3nsbs@wdoa37qkziwe>
In-Reply-To: <sbunoj5dm6xifhqog5aaeujrbiilfqufum5msoiqtp2di3nsbs@wdoa37qkziwe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7042:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YJf6GipyMuYmvYLrPH0YA+MfH6GKnA7DqeJkT4kQWc0h8viR+qMljJEVDL9Mb9OAa4VxswlCIouHHnFjF45UGTl2c2WMBWUl3lWmUswgJSiMB4hi5UP5Bejjqnud93pAFfW6E8AEUToUxz+22hKYJoUnPrwjh04GxpnDD9GBEcth/F6qWyAX9csNtRze9+YP5gV8K8D8WTNBv6DfLVTuTUm0xgk6vh/CiJLSLlF6+46aUTuMCkLPIvWPlO/tEuSY++Mlki9HcahT8yL0TTgS4OE5C/ysiZlocEKRn7DhPg5MKDv44DOPU+Qn11DEf+Ng8RYJIhXLQBZF8oJ9x51khSkYwC8dYElaOX0Rte/BOMeOTJzAJOk/QEfY5ckNfWv+14wCsZcRVY0gIQoa/1lM0gguNRn3bVUhrf9xobeN4l4E8modoSwSemNbOoHaq1+hrTznxiQLBEeP5PJkBDm2cxcrCakU8vmD/WqHR2I5+9y5wB7PRF1kuvnTt3J93B5upVu30wWhdQ22C51nU/g3lTbPOZewFcCR2RiBloxFemUQ1qhkLJA9NZz2LhOnRKi6Afv4VqYDjOGdJvPMXfUL+SljMJNnnfDC0WkTnY+pGjS85AKpYQDP225C/rMOYi0FIrOHdIJJu5fA7SuC4elG2Wk9EMVbCgd3r6cCzl9h5Ug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?USs2ZDhJZUp2Vm5wbnA2SmdBdUdvaTBHWFBrVXFyRmdNV0NiajgyUXM2Snd1?=
 =?utf-8?B?VTJVNTBnUDBVUGNsUmZ6c3ErNE5hSGJZUjNHbEVteGNIWFRMWi9XSlZDSWk3?=
 =?utf-8?B?amJ4SjN2aXdhS1lOOStPakpYZUZreHJSV2cyUnRhQnh1eTFBWVN6YTQzR2hD?=
 =?utf-8?B?cjdkTEYzZFVxM2RQN0h3ajN5bGtyUmNZc0JzYjhhWWpIYXp6Mll5OVZTSGg0?=
 =?utf-8?B?dzZTNTNmRlh0MDVsT3NsQjJFUUtmRk1kelRHQW5uZ0hPMjY3Y0JiVUxiOFl2?=
 =?utf-8?B?NnQvT29wNDR5Tngzekk5M1NiWTdQUHNWS3R3eUxiWFhwdk00eW91bnpwVXFj?=
 =?utf-8?B?aWp5bkQ3YlJTY1ZXRkJJL0hnYndZaFZFSWxjM1drdjBhWXkwY2kzdGVDRWxN?=
 =?utf-8?B?MmE0bVFUTUd3cHJYRnJpQU9DTTBzYXNRcVgwNXdFRzd6NkFRVDZsMUpiNUR5?=
 =?utf-8?B?OGJIYVJhemdtZmw4Q2gyblROVXkzaUM0Z3Q0VDRSTFlHY0VJdU5xdk5PRnU0?=
 =?utf-8?B?UHZDclpMTFFrekY2VU5xZ2JvZ2tFRXJqS2RXTlRrR0JheUJ0OGx2RnZvRVNC?=
 =?utf-8?B?YVVVYXRpMDU5aEpIOGJOWnhZMERnWTNkTndkZS9ESCtYOW1ZSE5qa09ZR1BK?=
 =?utf-8?B?Y2tSWUp2ZWhSWm8yS0NwcUVnV1l4M1B2ZVJuR0JYRnBjZkVNdXZ4aDBDWFdB?=
 =?utf-8?B?cVNOT21oM09yTzdSakVmMWpEUGx1TmpNbFIwRU9kc29KU2p1ZG5jT3RSNzc5?=
 =?utf-8?B?TWpSK0dMTkpmVWVwbFRzR1ZCTXNJbnIrd2JyS0ZEby8zYUFITUlDb1NYQXpl?=
 =?utf-8?B?OGdzWlJEUFVqeUNoNGpOOGlkbVl3M2NQamZ0aSt6UzFTTkp4UkpGVmxuVHhw?=
 =?utf-8?B?M0xHZHAyWkZ1emRrUkFsNm9qalNaM0dmdEFBVFNmWDZzSFl4RVRXY3BWSm9t?=
 =?utf-8?B?QlVuekIvZm9peEh5ckhGZEcrbHpBbEkvc1VIZ1dPSDFOYk45T1F4WGFvelox?=
 =?utf-8?B?N1FqVEMxZzVRdWJJTUg5R1VIUXNoaWpseUNhbG56YzlCMG5ub2syMVl4R1cv?=
 =?utf-8?B?TU5BQjhEa29lN2FHaG9uQU5hbTFmZ0xxYzJDZEE5S0ltTXhpM25RQmU5clh0?=
 =?utf-8?B?V1o0VFA5Vy9XRmgwVXo3aFVJejE4VGhIMnhpb3lZVTY2cTVPKzgvOEZWMzBO?=
 =?utf-8?B?OCtwc3kzeTBMaE5pcE02eEIwOFMzN0UxRXJvYk1sZksvRGhrY3lqNVBBK1c5?=
 =?utf-8?B?NmlDNk8rRVRWdGc5SmtBZ0tGeWs3SjhsUUpmMWdQNCtYcnRuUVltcnJyNGNV?=
 =?utf-8?B?UVVFZmF6NytYREU5L01YajNWa1hXby8zcUR0c09PcGtWYit1R1Z2UjlzcUdk?=
 =?utf-8?B?VSsxYzdRWWhWdk9UQWphdkZ0ODhyaGNBVUZlZ0lKSElGT1Z5MVVveWlJMzZy?=
 =?utf-8?B?TEh2d1Y1YjFOSG4rNDdja1BNVG5jWUhtbTVjVGRQUS8xMFdQMHFpU28rdkF1?=
 =?utf-8?B?Y1l0ZElFbUZ3NnlkRUlNMDcyazZYQWgyUEIvZ3dHQmd5aGVBMG9ZNG1OMFVH?=
 =?utf-8?B?TUM3R04vTTZ3WU8zRjV0MXJFNG83Wm1iL0NrMElrczQwbVNuejA3QUJvdzlI?=
 =?utf-8?B?VlA3eDBUUy9IaHZCM0RqazRZZ3RCNGlwMWRCZVFhelkvK3dRd0Y5MWJLeTlU?=
 =?utf-8?B?bEkzMWFNUVpVcGdUWU1mK01Gb2tsYmR1SGZJNW1IejJ5TW1tM0o3ZVdXdVZQ?=
 =?utf-8?B?TzN0YWRWd0tBdkZremYzQ1VvTG1pbi8xaWxKTTc2Q0xUY1JtTWtMZ01uWVg5?=
 =?utf-8?B?emZYY1pKMjRHZytvcWJIUGh6N3hUazdnL0dHMnJEeVd3ZU9DOGgxMXZGQU9q?=
 =?utf-8?B?NGNEdWphc1EyVGIxb2tvSWFvUVlUOUNmNEk4VGNnc2hXZFJjVE9mS0g0L1Bh?=
 =?utf-8?B?VzBwRE1vbHg2RmZYdVpJcDZ0U25QN3JKbGVqaWhqWnlvblRMVEdjSVUzYXFo?=
 =?utf-8?B?cFBZM1RDWUtrditGbnozeDNTVTJzYTZxMnFkT1NPenFNNkxuOTFPNzdvc1NU?=
 =?utf-8?B?aGlkUlZqbVBNcW80LzErUGZvMit1SklKb3B6ZVVrVGpjNis1OXlFb281Unpv?=
 =?utf-8?B?QXBjS0JLUVJqRnNwLys1aXJJdFUva1hBSDFsMkpXYnYrdXlzcS9tbFRZTE5W?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D649244181CA049BEAE0230CAF3769B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1f8945-7ef3-45ca-4fe0-08dc596c455f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 14:41:13.4417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhp6A7fOUzR70Jn6Y/8z3At1MmjOmIeR+sFEAOEru2Ls8m2opIpdcyzV4Xv0O68ZWBkJ7OWNnlCy5jGeJbfPxCuE80DBYG6fDJw6gM+0s7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7042
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA0LTEwIGF0IDE3OjM3ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIE1vbiwgTWFyIDI1LCAyMDI0IGF0IDEyOjQ2OjAzUE0gKzAyMDAsIEtpcmlsbCBB
LiBTaHV0ZW1vdiB3cm90ZToNCj4gPiBBZGp1c3QgVEQgc2V0dGluZyBvbiBib290Og0KPiA+IA0K
PiA+IMKgwqAgLSBEaXNhYmxlIEVQVCB2aW9sYXRpb24gI1ZFIG9uIHByaXZhdGUgbWVtb3J5IGlm
IFREIGNhbg0KPiA+IMKgwqDCoMKgIGNvbnRyb2wgaXQ7DQo+ID4gDQo+ID4gwqDCoCAtIEVuYWJs
ZSB2aXJ0dWFsaXphdGlvbiBvZiB0b3BvbG9neS1yZWxhdGVkIENQVUlEIGxlYWZzDQo+ID4gwqDC
oMKgwqAgWDJBUElDX0FQSUNJRCBNU1I7DQo+IA0KPiBBbnkgZmVlZGJhY2s/DQoNCkl0IGlzIG1p
c3NpbmcgYSBsb3Qgb2YgdGhlIG5vcm1hbCB0aGluZ3MgdGhhdCBjb21lIGluIGNvdmVybGV0dGVy
cyBsaWtlIHdoYXQgaXMNCnRoZSBwcm9ibGVtIGFuZCBpbXBvcnRhbmNlLiBJdCBtaWdodCBoZWxw
IGF0dHJhY3QgbW9yZSByZXZpZXcuDQo=

