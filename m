Return-Path: <linux-kernel+bounces-128557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47463895C67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18CA2868D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F9015B963;
	Tue,  2 Apr 2024 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gve1GNFR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556215B569;
	Tue,  2 Apr 2024 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085849; cv=fail; b=eXDsWaVQMiIvNiK1NMta5PrAEjAYdyytLf+BhhlcfspMdtKREhmCbHvkIF1exVU8kKEJovh3WlMQs9SAvlsMAQlX1GVkkMt/roySBfHzPc/7SAZIS3f22Ec7elCsWp6cRRjUWevaIWqxw2a/PVXclPPkF8eHUvnCEcEXTGNl6jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085849; c=relaxed/simple;
	bh=8QAVvpzIHyv3ukXSkYnQwCaaW43cpPhn6rCH5vtj8+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UotXRrdYmU6V1ZceCHcO0OUpNPl4Bmn102uccSCSehVFB+AKoBc9/Tzx7U373Y+WKq0qRin0i50n8wspaEgor5w12bgCNjLw3cmPxTzixWj6St8H8GEzGffG/7pNqltL+CtXN2sXJQooVNXjlA384cOERf60VS+yRKEZyC7com0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gve1GNFR; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712085847; x=1743621847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8QAVvpzIHyv3ukXSkYnQwCaaW43cpPhn6rCH5vtj8+U=;
  b=Gve1GNFR3w8K253ey02uiA6oz8Va6mRxMRgmc7H1e0mxjxLFndY0tcNp
   yFQsnngZgImRjbBbxLkLoSpvRxufiC1wuinLOAvLPGjoDgy5ewoWfdx5f
   sdQTBlqRoaj541MbYZromTV95+LGvXxDv+/cOJc7pSegoGIrYssYh+fpd
   CEsbVvQvWelpGiL+Iwxj39FgoMJyhWRAn+4nh1YvxiRFenXKzXQZduHvA
   Prg96ZRp8xMviJ27yPiLLne4LOKr3poz1iJwD0VcSh2sXwH6ogqP4zQvD
   rV5blCtr1lOVbVyUPnx04jaluzU5SXRmwbe8Zj4Eh9sO6fFBnG180RcXF
   Q==;
X-CSE-ConnectionGUID: LHAMCRaZSJOI6ATBym65rQ==
X-CSE-MsgGUID: SPbGkVpgQbOcDLgXeFnIXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7465124"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7465124"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:24:04 -0700
X-CSE-ConnectionGUID: XISXx1ZkQ5SyQ6LZU1FouQ==
X-CSE-MsgGUID: aj+0Kjz+TsGyGuWf/Kv3dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17991605"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 12:24:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 12:24:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 12:24:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 12:24:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 12:24:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm6GXRHFkw+Jrdoki2BXDFr0oLgngmeEeNCjh3kn0/PS4bQHIzisDlK22EFT9W1Fpave1hr6F0bJ7m1TAPAY4FWOz9DpyZ+F+/sCpqbFZ8qW0plDskJq29tjdCNsMvOD4TjdzCDAhmeBu7D/vvyuq7zyTjvMbquP765nQ5KkdBF9n7C9rgtNs+vKk1hIzCMDcYI+4ySv5O2Qk0fDR+jgiNBfRpUdaNvLZfJDS7nzS6HNRFZlzLcrCmMXnxldVpnFgYL7+ffB31j+XmH0gfYaFRPwi9VzGFXz+O+UZgEEXeT9yE2Ogn/NcMmHXu2SYojgqMUL2ivNqMRrY9DnDCB0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QAVvpzIHyv3ukXSkYnQwCaaW43cpPhn6rCH5vtj8+U=;
 b=flBm8aHIjovOY073Tg27u7acyi1gjPll8pc2by0sK9mtymWbXpa2FgMsfBUliGMTBhFOE2fXx/FlhtnA0qxTlEWSb6xURALxrrAiAHHvcz32wWp8Qfz8O6unNAd6usLau99tg+f/STC4uX/47aMR7ks66W0Kg0sZf07EfT8pL79OImDp/aFYMfnTl9wSM6GGuHgxIBK1XhftxC0sbEiOX5OcF7NU75dvILhY11YZLBoUJH8ZYBrWVxjb0kgp71nH8hdzeQsuUxOjpcJ2KWSlInZMdb5u8yNB2HvjERThP8btne/0cWLOf1gLBwis36AvOFqan6vfMxcYymLnAZG4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by DS0PR11MB6423.namprd11.prod.outlook.com (2603:10b6:8:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 19:24:00 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5997:c66:5650:3bed]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5997:c66:5650:3bed%3]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 19:24:00 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "Wu,
 Hao" <hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>, "Rix, Tom"
	<trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Thread-Topic: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Thread-Index: AQHahK6bkQoReb334EG4W8nSL0W2eLFVXUEA
Date: Tue, 2 Apr 2024 19:24:00 +0000
Message-ID: <1956417c03e8cf5b51c2edd3342b6c0b657ac0a1.camel@intel.com>
References: <20240329000429.7493-1-peter.colberg@intel.com>
	 <Zgt7fA/Jfks/iKYi@yilunxu-OptiPlex-7050>
In-Reply-To: <Zgt7fA/Jfks/iKYi@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|DS0PR11MB6423:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5bRfTfKp2bfZxLNiudwiryEfJafXESLIfy1FROp28IxehNjfaKZG7ZbalVr+8qkX6/Z93at8BNBL73r1ba6WgPhspOmUJNXXt196UI0VnlHWedvGqF1gXtO7j+rl+jcZrfSwg2XwlLSDUtjxS7vkXvo/eUoIINPXezR51NADMnSstfj8xSxyJmVwIydC+xTz0jdtZDMgaw9kzTL2yLeC6TGcxn41WR89zb+zuXuugRAKEgtB0KCuqk4HEv6sw9FCk/ISOGfnM48IrnGHX2ULfuV20Ga7khqOb5TUi91kRJxotyFf8XGyL4ggUf1+2YvCfZ6w+SKPQI6fRe2nFuzZ1jTbNxWUp2Z+3Sidp9KQzHFMT14g8bhewt6eZ6DX2bSeVimMrj1qS3Dbvo1h90FKQ1mfvZyYguOZMCLD1qR2C4NQjyn+XwegolqDAs4QSpuQtAWyP4lrtuChwb2RfaoEnIB7TsfoVrNzctQdhiO+lLhHQrst96mOdh3/c/kXBh00/0LMbcCgV6cMZo84d8n8LfRevif/L8at19KGSL1jpFGPMl1lM+Z3wFQzFngDTqY4jdDJFSCt28+qdnrV14hlXi1hqWJuwp7boCxwS8K3OCWCZjpegG2j5PywiQNCW/KZFiUyBtcA+HxBihNkifpQPkf5OGPLSPHAuDjMQmj8EPI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWFjbVBuQUxjU2U5SExiVG1QVC9ra2xDK2NxZC9aS3pubzFNT1NMaUs3ZGZl?=
 =?utf-8?B?cnBINk5TNmozd2VqNSt2aFFUbGttWW1zODA2RjBoR2dmWGJ0ZEh6VkpBUDcv?=
 =?utf-8?B?c0FCd1RyUlJCUHhrb2RFcjNmUzl4bEgzQUlZdE9mRTB6amNTRFZZMDRISzE0?=
 =?utf-8?B?MUZ1bEx6cnVpeFNKZUhuOHRrZ3hIc2wzMzdVZVFGaUIyNTk2eXZBZnBCZEVY?=
 =?utf-8?B?R3MyQXN6UExickFUeitxd3NVQnRmU29GZGthVVhMeUI0dThtTjdyb0xaR1ZM?=
 =?utf-8?B?S0hSTEd4UGs4OUJ1dFVLT0c4THVLZVpycm5lN252QmFvMmZ1TjBQd21obTFq?=
 =?utf-8?B?NUxnYnlpQms0MTZiRW9abG44WjhxMUFtTklFT29ybVJwZTBpbHR0VDZTUERk?=
 =?utf-8?B?eW5HNDVQeDlDaFJOK3VDcGhwT0tIczdhSkR5SG10OU5TNGFOVkFaZ0laNnVk?=
 =?utf-8?B?TVlJODB2RXJUZytTQ0pHLytqZTlkTGZiM3QzOXU0eDZ3OUhYRWk3eUY3NDhV?=
 =?utf-8?B?YVBvenZTVGpUcHE5NEVTWjRXS3FUbnNieGloOUdZeC8zWGh4akhtdXhxRnBF?=
 =?utf-8?B?RGM4OWtHdit4YmFwUVB4YnU5UlcybDRveTYwRXNRNllURlo1dXNYZnVZUmFC?=
 =?utf-8?B?ZFVnb0EwUCtyOURKSXpETTBxZEF5TlgvSlg1c0U3RWtNSm9QbTJWR0NuRnVJ?=
 =?utf-8?B?OHVCdG5xSWdIdWJ4ZkVFK0RLVS84ckxTOEFxNVBTaHM5eG5WQlcxSVlJdkN2?=
 =?utf-8?B?Ry9KOUFJUHpVaytMZzJiNm5VZGlpNllwMHorbzNtbjR6SElTRStPTEd3WUYx?=
 =?utf-8?B?Z0FYbk1VTW13L09kd2NPM21OZDVDeVVHTk1OMTVBNTNUYmhTRjFOYk1PQlFO?=
 =?utf-8?B?aUJsV1lzRjF2aHB6RTVWbjRUQ252UlphUGpqRnQ3SXRNTzdzdmIwbVJYd0JB?=
 =?utf-8?B?ZmM2Yk15Vm5sUzNjQmRhdHNHdk5qdjZWdnJCUG9sODkyZ0N2UXRwWFJIM3hl?=
 =?utf-8?B?a2daRG12SHdmUEtLN3NBdVh2QXh3WTY4b0ZhSUhUUWxhM0U0TzNuZEc3dlBD?=
 =?utf-8?B?RFV0YktaZU16Q25GcXoyalUyNVZDS2ozMDlsdE9WWFVZYlFDY3IzZk9tZFZh?=
 =?utf-8?B?dWJUbjZZYzMrZnY1YXZ2TDNudG54VVI2eVFDY1pMdGdRUGZNdUZqUUdqYTFo?=
 =?utf-8?B?b05XYjRHOEo3WVI2TXlyMGhXZDRWTFpvd3JSaHlQY1FldkxhMzBTRHo4WDRk?=
 =?utf-8?B?Q2RGcEZrRmVqeldVdmJxR3VIVXBWYWFOMFVabFpCYTZkcXMwcEtreEYwYjdB?=
 =?utf-8?B?MEpwTFhyT3l2R3VRaE9tTnlyNStaY0tWclJxWmlkdytPL0VLQ1pkNWxzd1RN?=
 =?utf-8?B?Y1FpaEltd1pKdGk5NG9BckUvMERIYUdNTXFpdzNobHgxU1ZEVjZXTForR1E0?=
 =?utf-8?B?czFUbmpVdXUya0lhOExPTWE3OFNMbm1BRUgwMUpFdXBlUEJmR1oyQW9uYWhH?=
 =?utf-8?B?R1B2dlhpZWVDQzZrd3ltakpoZHcwdFBQMW1Ed3A3WnpUMG9aSGdDZmtyTHdG?=
 =?utf-8?B?UVBsUkZQSVErTTh0WjVpdElpUkM4bHYxUVRhMW9JaVBSbHFoYUFSQklQSXdD?=
 =?utf-8?B?MUVsMytON3AyZktkaUdBNVRRMTd4VzNUSXlld0hCTmUxTkQyV29FTWYrSHRi?=
 =?utf-8?B?WUpDWUhXcjBoRlByWVN0ZUI3Nmpva1VQS2VqVlhQK2s2cmF2anBNL0ZWU1F3?=
 =?utf-8?B?b1hJVE1DYkVnKzZpUlgxVERYQVBYTzVTYUJVc0J2UWFqS1NrSmRwUTNLWUUy?=
 =?utf-8?B?REVZN1JvcXhUYUNjN2dIOE9hQkNiYUZxZVpkOEZrMjV0eWxmdERranNUYXFM?=
 =?utf-8?B?VjZheW9iOHV1b09sTm9hZmZUeDhXcVMrbzhWK0gwanJHN1RsamRKaFJYYkRk?=
 =?utf-8?B?RjN0U2cxRlpSYVYxdFBPQjdad1E4QzRBRnVhYUtWTGNEUHFsME91U0V2WjRR?=
 =?utf-8?B?Q2NmNDI1U2xQYXhFSkhneEYvWEdHcjNDckljTFpxazNkRnZ2eThCVmdXMDN0?=
 =?utf-8?B?bk93YzNiWXZIVlFycmQ3UDNudDU1M3dJUWFJdnhRMVZnZ3FwOXNoWWlCMHZx?=
 =?utf-8?B?bkdXNlFJL0wwL3NIa0RSQWNCSFY4ZVBlbTNheXl4eFpSM2dES25VZVlBYVkv?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32BF343B943A0C439CC5E15F74E582A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68600b1-b92c-41b4-ee74-08dc534a7328
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 19:24:00.3998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfwrCMfxQ4o0hrBvoDVZxTlDssHut0MqWKyM7ianuvP2u6R1g1q4ywb9uUXhlWMWt+cWd6Ru96ZP4HTX+g+RUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6423
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTAyIGF0IDExOjI5ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VGh1LCBNYXIgMjgsIDIwMjQgYXQgMDg6MDQ6MjlQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBPbWl0IHVubmVlZGVkIGNhc3RzIG9mIHU2NCB2YWx1ZXMgdG8gdW5zaWduZWQgbG9u
ZyBsb25nIGZvciB1c2Ugd2l0aA0KPiA+IHByaW50aygpIGZvcm1hdCBzcGVjaWZpZXIgJWxseC4g
VW5saWtlIHVzZXIgc3BhY2UsIHRoZSBrZXJuZWwgZGVmaW5lcw0KPiA+IHU2NCBhcyB1bnNpZ25l
ZCBsb25nIGxvbmcgZm9yIGFsbCBhcmNoaXRlY3R1cmVzOyBzZWUgY29tbWl0IDJhNzkzMGJkNzdm
ZQ0KPiA+ICgiRG9jdW1lbnRhdGlvbi9wcmludGstZm9ybWF0cy50eHQ6IE5vIGNhc3RzIG5lZWRl
ZCBmb3IgdTY0L3M2NCIpLg0KPiANCj4gVGhlIGNoYW5nZSBpcyBPSy4gQnV0IEkgc3VnZ2VzdCBq
dXN0IGRlbGV0ZSB0aGUgdW5uZWNlc3NhcnkgZGV2X2RiZygpDQo+IHNpbmNlIG5vdyBwZW9wbGUg
bm9ybWFsbHkgZG9uJ3Qgd2FudCB0aGVzZSAiSGVsbG8sIEknbSBoZXJlISIgaW5mby4NCg0KRG8g
eW91IGhhdmUgc3BlY2lmaWMgY29tbWl0cyBpbiBtaW5kIGFzIGEgcHJlY2VkZW50IHRoYXQgcmVt
b3ZlIHNpbWlsYXINCm9jY3VycmVuY2VzPyBUaGlzIHBhdGNoIHdhcyBpbnRlbmRlZCB0byBiZSBj
b3NtZXRpYywgd2hlcmVhcyBkcm9wcGluZw0KZGV2X2RiZygpIHdvdWxkIGludHJvZHVjZSBmdW5j
dGlvbmFsIGNoYW5nZXMgaW4gYSBzdHJpY3Qgc2Vuc2UuDQoNCj4gPiANCj4gPiBUaGVzZSBjaGFu
Z2VzIGFyZSBjb3NtZXRpYyBvbmx5OyBubyBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+ID4gDQo+ID4g
U3VnZ2VzdGVkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBDb2xiZXJnIDxwZXRlci5jb2xiZXJn
QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiBUaGlzIGlzIGFuIHVubW9kaWZpZWQgcmVzZW5kIG9m
IHRoZSBzZWNvbmQgcGF0Y2ggb25seSBmcm9tIHRoZSBzZXJpZXMNCj4gPiAiZnBnYTogZGZsOiBj
bGVhbiB1cCBzdHJpbmcgZm9ybWF0dGluZyBmb3Igc3lzZnNfZW1pdCgpIGFuZCBkZXZfZGJnKCki
Lg0KPiANCj4gV2h5IG9ubHkgcGljayB0aGlzIHBhdGNoIG91dCBvZiB0aGUgc2VyaWVzPw0KDQpU
aGUgdHdvIHBhdGNoZXMgd2VyZSBjbGVhbnVwIHBhdGNoZXMgYnV0IG90aGVyd2lzZSB1bnJlbGF0
ZWQuIEkgc3RpbGwNCmhhdmUgdG8gY2Fycnkgb3V0IHRoZSBwZXJmIHRlc3Rpbmcgb2YgdGhlIG90
aGVyIHBhdGNoIGFzIHlvdSBzdWdnZXN0ZWQuDQoNCj4gDQo+IFsuLi5dDQo+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLWZtZS1tZ3IuYyBiL2RyaXZlcnMvZnBnYS9kZmwtZm1l
LW1nci5jDQo+ID4gaW5kZXggYWIyMjhkODgzN2EwLi5kYTNjYjljMzVkZTUgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9mcGdhL2RmbC1mbWUtbWdyLmMNCj4gPiArKysgYi9kcml2ZXJzL2ZwZ2Ev
ZGZsLWZtZS1tZ3IuYw0KPiA+IEBAIC0xNTAsNyArMTUwLDcgQEAgc3RhdGljIGludCBmbWVfbWdy
X3dyaXRlX2luaXQoc3RydWN0IGZwZ2FfbWFuYWdlciAqbWdyLA0KPiA+ICAJcHJpdi0+cHJfZXJy
b3IgPSBmbWVfbWdyX3ByX2Vycm9yX2hhbmRsZShmbWVfcHIpOw0KPiA+ICAJaWYgKHByaXYtPnBy
X2Vycm9yKQ0KPiA+ICAJCWRldl9kYmcoZGV2LCAicHJldmlvdXMgUFIgZXJyb3IgZGV0ZWN0ZWQg
JWxseFxuIiwNCj4gPiAtCQkJKHVuc2lnbmVkIGxvbmcgbG9uZylwcml2LT5wcl9lcnJvcik7DQo+
ID4gKwkJCXByaXYtPnByX2Vycm9yKTsNCj4gDQo+IEknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIGFu
IHJlYWwgcHJvYmxlbS4gTWF5YmUgd2UgY291bGQga2VlcCBpdC4NCj4gDQo+ID4gIA0KPiA+ICAJ
ZGV2X2RiZyhkZXYsICJzZXQgUFIgcG9ydCBJRFxuIik7DQo+ID4gIA0KPiA+IEBAIC0yNDIsOCAr
MjQyLDcgQEAgc3RhdGljIGludCBmbWVfbWdyX3dyaXRlX2NvbXBsZXRlKHN0cnVjdCBmcGdhX21h
bmFnZXIgKm1nciwNCj4gPiAgCWRldl9kYmcoZGV2LCAiUFIgb3BlcmF0aW9uIGNvbXBsZXRlLCBj
aGVja2luZyBzdGF0dXNcbiIpOw0KPiA+ICAJcHJpdi0+cHJfZXJyb3IgPSBmbWVfbWdyX3ByX2Vy
cm9yX2hhbmRsZShmbWVfcHIpOw0KPiA+ICAJaWYgKHByaXYtPnByX2Vycm9yKSB7DQo+ID4gLQkJ
ZGV2X2RiZyhkZXYsICJQUiBlcnJvciBkZXRlY3RlZCAlbGx4XG4iLA0KPiA+IC0JCQkodW5zaWdu
ZWQgbG9uZyBsb25nKXByaXYtPnByX2Vycm9yKTsNCj4gPiArCQlkZXZfZGJnKGRldiwgIlBSIGVy
cm9yIGRldGVjdGVkICVsbHhcbiIsIHByaXYtPnByX2Vycm9yKTsNCj4gDQo+IFRoaXMgaXMgYSBy
ZWFsIHByb2JsZW0sIGlzIGl0PyBDaGFuZ2UgdG8gZGV2X2VycigpPw0KDQpUaGFua3M7IHllcywg
ZGV2X2VycigpIHNlZW1zIHJlYXNvbmFibGUgYW5kIGlzIGNvbnNpc3RlbnQgd2l0aCB0aGUNCmVh
cmxpZXIgZGV2X2VycigpIGFmdGVyIHJlYWRxX3BvbGxfdGltZW91dCgpLg0KDQpQZXRlcg0KDQo+
IA0KPiBUaGFua3MsDQo+IFlpbHVuDQo+IA0KPiA+ICAJCXJldHVybiAtRUlPOw0KPiA+ICAJfQ0K
PiA+ICANCj4gPiAtLSANCj4gPiAyLjQ0LjANCj4gPiANCj4gPiANCg0K

