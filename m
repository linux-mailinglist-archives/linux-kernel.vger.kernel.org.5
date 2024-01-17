Return-Path: <linux-kernel+bounces-29005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD88306A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E5D1F23EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45C1EB45;
	Wed, 17 Jan 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQMRtTGH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3341DFDE;
	Wed, 17 Jan 2024 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496914; cv=fail; b=t5NKbcq4ddlMo9WvI51mk7Ck8EDKihhPJ9ezSZNzJrGL/3JlNETo8fB5gYBP1BFQqOMcjVkRd+nlMs6L0jxVTNR/6B14wPlhiuDmanWAOEC0RuSRdPJrMb9Guc0XF06ji2R7fjlaXzl1yUJbrGlQF000RwUSb/TyDoPokyVSOOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496914; c=relaxed/simple;
	bh=+/a7PTzwqMxzsa9IoZcnstsA98E+MCdqLUKX0vSfRx4=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=P37MaiboQnfmkaLJyVt3jUYSwdsE0BVIEedwA+ra4B4Lc9PUnVV4zQlThTvXUMNXHGMBgLCyIgMOiFgf5yfxp4OWoNGWpek3c11X56Yqn8AsIGwjN3O2eieYUmURMCKw+sh0gN5JZ9jmL0iEr8I+p3eQKEO/xFPQju3oRmPQ2is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQMRtTGH; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705496912; x=1737032912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+/a7PTzwqMxzsa9IoZcnstsA98E+MCdqLUKX0vSfRx4=;
  b=YQMRtTGHhLzhXgMfMpf16MwpE8TaCGUL9w14ErVkwGgLF0oz6FWOFn1r
   EKUgHxcVw6GhFV1IKIWQK16DvrlYMxZpAoMRHDTNF//WAsB7qrVLd8HJV
   36r0d5buxbMY8YMjFZEfwMyCczmPXh/AxZPBYY2SrXpAa/4aovJtRFIHJ
   eSeoHN+BYcbSGrkBVLE5UfCdPl/wMK/qZP7rBbtBz3jcT60Vt5bhUB0g3
   ObrkFfjds2pWfnJ5t18P8g30H3EMKBNRgTjDqlgNRIE7WFRue75/StOFW
   cL9oT0vIobAylzUgzNo/2uHaqfdlo0j+urPbSeuFP3xu7RccoP28AU5x7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6878977"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6878977"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 05:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="27944"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 05:08:31 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 05:08:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 05:08:16 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 05:08:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2s/U7Inq1sFZqztEaZgy1PichOwfUWX+sFy4i+Ry08SwvjpH1dj8ZDaEz5/8JkiRHpzPxSwRrHgtQEvyIcKNfpQ3XrXj3ql7Qo+rGhUNKn7y3k7Vcra2VAQ/cdOe7bgfNzmTX9w3qyQxPRCRqqE14dy4i1ekOUYsOxOwxnyr7pegh+n3FS0oUdg18a1c3z3jnwzVCTP6GjjkVLGRnZsw77PfmWHuq/fwZjgPNlCbU6eRFCfj/mA1Ijpa1bWCXzwco3VuAHr0xll29LuRMUEoLQ8KFetzZtyYni7YzaBWg20cJh7cLyXhNsP/uTuqy4PsthZh+A5LUp+oaCU+e1j5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/a7PTzwqMxzsa9IoZcnstsA98E+MCdqLUKX0vSfRx4=;
 b=n6B9FSaa0DcwzFpLpDSqVL58vsHb0xdDZUtqkb6k1HizbmCPbD+1wWcK22WRxHHdak6WLoJYFQjxshl0XuSQWPuJ6A22KCKekPObwNHabeUrd7r3SIlh/FlMhRn75L3ouMTUAC4JBkc9jRcwjipvuvPwNFxmdFz8uYXDsf7d4eGAC8S96mpjvQ+rqAGNzrotpt8V3VRCRqUYS5rgSgsqk6rXqPLv7yEi/v9H4/3tR7DnqWF0I9+xiahKlYF88SojriSK1gRh6qYlgrOwY+3DvCgdCda2Q5kf5HdQN2vaYYp5KhWNfHmFUlEkvfH2uxj13fJK4OuOHv9rYZrwvuRQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by BL1PR11MB5269.namprd11.prod.outlook.com (2603:10b6:208:310::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 13:08:14 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f%5]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 13:08:14 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness
	<john.ogness@linutronix.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Hao3" <hao3.li@intel.com>, "Li, Lili"
	<lili.li@intel.com>, "Gao, Jianfeng" <jianfeng.gao@intel.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: RE: [PATCH] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
Thread-Topic: RE: [PATCH] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
Thread-Index: AQHaSRHUAxkUsa53fEifHKPAjcTOAbDdquOAgAAAXhCAABtsAIAABfgAgAAic8A=
Date: Wed, 17 Jan 2024 13:08:14 +0000
Message-ID: <BN9PR11MB53709FD2BC70878B49059107EC722@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <20240117065226.4166127-1-junxiao.chang@intel.com>
 <871qagtlk2.fsf@jogness.linutronix.de>
 <BN9PR11MB5370065F4E7443FEA156347EEC722@BN9PR11MB5370.namprd11.prod.outlook.com>
 <87y1cos2dv.fsf@jogness.linutronix.de>
 <20240117102446.itexUYMc@linutronix.de>
In-Reply-To: <20240117102446.itexUYMc@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5370:EE_|BL1PR11MB5269:EE_
x-ms-office365-filtering-correlation-id: 55ca8faa-18f8-431d-538e-08dc175d5d3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZeLkvgOg5NiRDQuUVHc6sGEv962lMmy/YcphV+N2tQ2h74LOyPenpMHiiODK86JYXs24dqoI6F5yQazChsfcHeCr8dNIpSqWtw4XpU1t0fVyNLAAiacOiv9HaBep/PFwHY17jlzA5diuhyJXxVgeXCXcKHjvaSjK5d3yjzTbh6287b8oc56qTAlenh8ax2YozibTZOhINLymsIdX1GXb7BaShAZvndbJoiAuVA03cuD1FAJt0I7K0EBfuPO/froPOSavyaDmfIQAfrmvszstqFqhDS30NTWw45CslNRYt09dkrPm141zB0ImKBX8UZCAXpAM7BCTcImhQwaXYzSy9fvonebDEGJyN2iQt5np50PgO/pEniPbesYHmW1LEJTjuZ1zu64HSyIAtzE5dunUeDmWRiG9XK0RfPJ2ivcFE9zwdVJa/wSAsDU+3IQTyyP3/MBLdO6OHpGdifU1xJMhf68eXXgi5aAdC7VCJMQqI3134uMo5Re65bFt7LCTsLXIS6uLwN6Wof+F+iCB51SQXRIjPOYKt1IbYklLe+Ll597KRJYGjzh1LelB5BJ6dLQNI1u/3qHslo5eJSbA66qaJTvhNZdqoAwHqAeEhaG/G/Rfln0Cb31nYkOtLAkBuSNL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(26005)(53546011)(7696005)(6506007)(71200400001)(83380400001)(86362001)(33656002)(38070700009)(122000001)(82960400001)(38100700002)(5660300002)(41300700001)(4326008)(52536014)(9686003)(66476007)(66446008)(64756008)(110136005)(54906003)(76116006)(66556008)(66946007)(2906002)(316002)(8676002)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWRCeTR1dm1ZQUpmNXY3Z2NwR0hVUmh3a0J1MEJkK0ZndzRLVUFOWjdxWWgy?=
 =?utf-8?B?VHRVeU9vUEdRZmp1WXEydS9UQXJWZ2p5d2RSMmJBa2RGaU14dmdBNUZLSnF4?=
 =?utf-8?B?TFlkUjlUWk1odkx2WWJxWWxrVloyeXhpdC9WNUdTQ0ZReFlHa3NpbjlMa0NV?=
 =?utf-8?B?MlNrbktqUnZIcGJpbkkrNTg4V3FjNjlJcGt3R3EyeXUydVNxZG5ESmNEcE9t?=
 =?utf-8?B?d25DcEFhTzU0amtzTkhyajJqY1R1UzRLNkExZ1hQMDFiREZhTTI0aGhTRlEr?=
 =?utf-8?B?VmhqK1dyamtOQ3EzM2FMa0NtQkZMOEtmVUNUZ3FXM1p5Q2VmZHY2V0lSMTdK?=
 =?utf-8?B?aEpZOTZCdERuNGw3bURldWY1R1AxNncvd0g0VHNEc2lNWEh5S2dkVEhPK3hT?=
 =?utf-8?B?WFd2aFJlQXd4T0ZmMHRlUUhpUWd6ekwwaXFwK2ZFdUJzOXRzc2d3UFp2L29P?=
 =?utf-8?B?cjlJb2xRYkZLbmc4cFVMZHNXSmc0ekYwQ1QvalBMTUJaWG9pTTZObEY0ZG8r?=
 =?utf-8?B?TktXZDQ4SlNuWDlUQ3RwdllHVWNjVGhMZGZ5MDhTR3ZhRld0NlJLVUtSYXFU?=
 =?utf-8?B?RUhNb05KdWFjM3JiK1dsWlBkcFNpVkxjcDdXR2dkQnE3SVppRWhnWFRNbHFr?=
 =?utf-8?B?RWIxT011OSthUkdwQjFRZUhwaGZPYkszbGc5ZXBoRHRyZjdycTNzUWg1ZUNl?=
 =?utf-8?B?QVNzdkt3V0czRVNKTVQzRGJES3U2YWZ0b3NqL2ozMktJNTNDbTg4Q0pUczRo?=
 =?utf-8?B?aTFXdzI5NlJoTUJGRnd3dGx0bHY4OWdPS1owaS9Xc3piMUNNSXVWenVhUW9I?=
 =?utf-8?B?LzFsRURmZ1VrZjlsVWN2VjB5aUFaV2FTb0FDUmJ5bFBiQ2RvbXVuRjYzVU9k?=
 =?utf-8?B?TTN2dERtV2Ntb3Vad2M1QW5pWEp3bVBwWFh5NXRDZDZiM3NLS1FzRFkyaXNK?=
 =?utf-8?B?M1BVcmJKQndTa3VSWnVNWDJLcEs4cUtOaUNQRDQwS09rUGdHMlJ4TFV5WTdt?=
 =?utf-8?B?SzJoUWpmeW1MdHI4cDZQcnJtbGcvVlVObHBqVmpoMkhOZzNKUlEyVll3bnl4?=
 =?utf-8?B?Wk1XTWhJY0tqeS9aazZPNXluS1hpZFltSUJabHYvY0xObmplaVNnQW1ObDZL?=
 =?utf-8?B?dGE1YkdiRDVFN3E4U2hGOUw4OFVBYkdKY3JQSWdZS0hBbzZobnV0Y0xHY2gz?=
 =?utf-8?B?c2VMcHpGTUdta1BlcjlCVkQyTUhFR3hjelVBcHVSUDRodDI3OGRuVXQvam1m?=
 =?utf-8?B?RVJwU2ZDKzNzSmxRaWpVdzZ5S1laZHFjdzhQTyt4dzl0dlJHSXZCeGdxb0VU?=
 =?utf-8?B?Q2pNdTdxOTVZRjRGWTc3VWtDajNuQTFlQURDTEhTS3NSZ094QmliQnV3eWJl?=
 =?utf-8?B?V3d6SVZpRkV1VmRjTE5HeUJSc01KcUxyZFJMNENrcGZBY3NqMDFPN0VCQVJP?=
 =?utf-8?B?QzIwbHBHV1NDM3AzQ1VrQXJhZEVGK3p0ZWlQQjlCU1NPT04wQUUwNlhEcWth?=
 =?utf-8?B?T2xqSTFlTC9iWjV0Y0o0eUl0eEU2RmFJdThiRDc0TW9CZ1dTUHhMdTE0UEFh?=
 =?utf-8?B?SUxHYmZ0U1d1Vko5SVFNbENvSi9SMG1kNU1rTmFxMCtLRXJjbU1yZXhzU3VW?=
 =?utf-8?B?S3U4TStQc241RVVZNGlqeDl3d0lwSVpWN0VsajBkUGlpR0ZjUTdHdUtTNTVq?=
 =?utf-8?B?bWJFTUFDWUZlTjJuWWp3VHlCS2oxTllZc09kcG9sd053d09YbWZzdVYvSEtL?=
 =?utf-8?B?OFNOK3FKeUVIYm90cDhYNXg4Nm44UFh3WWpwVkpISzBtMlNVandieFgvbm1Y?=
 =?utf-8?B?U1FEcUljSWh5NnV6MHhFUmJCRG5RV0R1aCtVK0cvbmp4V293S0IzTWxuOHdC?=
 =?utf-8?B?NGRnNG5vbXJvSmd5K05xZ0pXcnZqUWlDN25CblU1aVhkM0hKYVl6eEJhOFQy?=
 =?utf-8?B?MVp5VmZPTk9IdWhENGJCQk9TWjJGU0ZEemRlTjY1bmhpRnE2Tmp4QXFSM2NR?=
 =?utf-8?B?OHhSaWQ4djhOZ08zNWJOZ1VjZU5WK2JQQ1NRb0p3c3ViZVV4WlZyQndQVmlS?=
 =?utf-8?B?c0VwUXhkeVNaVExiS2xyU0dtOHNVMVNObnhnZ2ppOWY1d0NWRG13em91TGRq?=
 =?utf-8?Q?o/yEs/bXt37ij3MowIY0X7Juu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ca8faa-18f8-431d-538e-08dc175d5d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 13:08:14.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hunrz05GzbhignobpTRxlidCiSNwIzcZRQ254easNhJrFSltiSYwp7WQDuF/ZWGLRyAXY68Ogx6a2Akaeqd8/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5269
X-OriginatorOrg: intel.com

SGkgSm9obiwNCg0KQXMgeW91IG1lbnRpb25lZCwgc2FtZSBjb25zb2xlIGRyaXZlciBpcyBvbmx5
IHJlZ2lzdGVyZWQgb25jZS4gODI1MCBjb25zb2xlIGRyaXZlciBpcyByZWdpc3RlcmVkIG9uY2Us
IGl0cyAic3RydWN0IGNvbnNvbGUgKm5ld2NvbiIgcGFyYW1ldGVyIGlzIGFkZHJlc3Mgb2YgInVu
aXY4MjUwX2NvbnNvbGUiIHdoaWNoIGlzIGRlZmluZWQgaW4gZHJpdmVyc1x0dHlcc2VyaWFsXDgy
NTBcODI1MF9jb3JlLmMuDQoNCkhvd2V2ZXIsIGluIGVhY2ggc2VyaWFsIHBvcnQgZGV2aWNlIGlz
IHJlZ2lzdGVyZWQsIHRoZWlyIGNvbnMgcG9pbnRlciggInN0cnVjdCBjb25zb2xlICpjb25zOyIg
aW4gInN0cnVjdCB1YXJ0X3BvcnQiKSB3aWxsIGJlIGFzc2lnbmVkIHdpdGggc2FtZSBjb25zIGlu
IEFQSSBzZXJpYWxfY29yZV9hZGRfb25lX3BvcnQ6DQoJdXBvcnQtPmNvbnMgPSBkcnYtPmNvbnM7
DQpUaGF0IGlzLCBtdWx0aXBsZSBzaW1pbGFyIDgyNTAgdWFydF9wb3J0IGRldmljZXMgaGF2ZSBz
YW1lIGNvbnNvbGUgcG9pbnRlciB3aGljaCBwb2ludHMgdG8gYWJvdmUgdW5pdjgyNTBfY29uc29s
ZS4NCg0KSGkgU2ViYXN0YWluLA0KDQpUaGUgQURMIGhhcmR3YXJlIEkgdXNlZCBoYXMgdHdvIFVB
UlQgZGV2aWNlcywgb25lIGlzIGxwc3MgODI1MCwgYW5vdGhlciBpcyA4MjUwX2R3LiBVc3VhbGx5
IHRoZXJlIGlzIG5vIHNlcmlhbCBwb3J0IGluIGNvbnN1bWVyIHByb2R1Y3QuIE1heWJlIHRoZXJl
IGlzIHNlcmlhbCBwb3J0IGluIEludGVsIEFETCBpbmR1c3RyaWFsIHByb2R1Y3QuDQpXaXRoIG15
IGhhcmR3YXJlLCBoYW5nIGlzc3VlIGNvdWxkIGJlIHJlcHJvZHVjZWQgZXZlcnkgdGltZSB3aXRo
IDYuNi43LXJ0MTggaWYgc2VyaWFsIGNvbnNvbGUgaXMgZW5hYmxlZC4gSWYgeW91IG9yIEpvaG4g
bmVlZCBtZSB0byBydW4gc29tZSB0ZXN0IGJ1aWxkIGFuZCBnZXQgZGVidWcgbG9nIHdpdGggbXkg
aGFyZHdhcmUsIHBsZWFzZSBmZWVsIGZyZWUgdG8gbGV0IG1lIGtub3cuDQoNCg0KVGhlIG1haW4g
cHJvYmxlbSBpcyB0aGF0IHRoZXJlIGlzICJuYmNvbiIgY2hlY2tpbmcgaW4gbmJjb25fYWNxdWly
ZSwgYnV0IG5vIHRoaXMgY2hlY2tpbmcgaW4gbmJjb25fcmVsZWFzZS4gSXQgbWFrZXMgbmJjb24g
bG9jayBub3QgYmFsYW5jZS4gTXkgcGF0Y2ggaXMganVzdCB0byBhZGQgc2FtZSAidWFydF9pc19u
YmNvbiIgY2hlY2tpbmcgaW4gbmJfcmVsZWFzZS4NCg0Kdm9pZCBuYmNvbl9hY3F1aXJlKHN0cnVj
dCB1YXJ0X3BvcnQgKnVwKQ0Kew0KCS4uLg0KCWlmICghdWFydF9pc19uYmNvbih1cCkpDQoJCXJl
dHVybjsNCgkuLi4NCg0KVGhhbmtzLA0KSnVueGlhbw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4
LmRlPiANClNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAxNywgMjAyNCA2OjI1IFBNDQpUbzogSm9o
biBPZ25lc3MgPGpvaG4ub2duZXNzQGxpbnV0cm9uaXguZGU+DQpDYzogQ2hhbmcsIEp1bnhpYW8g
PGp1bnhpYW8uY2hhbmdAaW50ZWwuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOyByb3N0ZWR0QGdv
b2RtaXMub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMaSwgSGFvMyA8aGFvMy5s
aUBpbnRlbC5jb20+OyBMaSwgTGlsaSA8bGlsaS5saUBpbnRlbC5jb20+OyBHYW8sIEppYW5mZW5n
IDxqaWFuZmVuZy5nYW9AaW50ZWwuY29tPjsgbGludXgtcnQtdXNlcnNAdmdlci5rZXJuZWwub3Jn
DQpTdWJqZWN0OiBSZTogUkU6IFtQQVRDSF0gcHJpbnRrOiBuYmNvbjogY2hlY2sgdWFydCBwb3J0
IGlzIG5iY29uIG9yIG5vdCBpbiBuYmNvbl9yZWxlYXNlDQoNCk9uIDIwMjQtMDEtMTcgMTE6MDk6
MjQgWyswMTA2XSwgSm9obiBPZ25lc3Mgd3JvdGU6DQo+IE9uIDIwMjQtMDEtMTcsICJDaGFuZywg
SnVueGlhbyIgPGp1bnhpYW8uY2hhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBUaGVyZSBhcmUg
c2V2ZXJhbCBzZXJpYWwgcG9ydHMgaW4gb25lIEludGVsIEFETCBoYXJkd2FyZSwgdGhleSBhcmUg
DQo+ID4gZW51bWVyYXRlZCBhcyB0dHlTMCwgdHR5UzEsIHR0eVM0LCBhbmQgc28gb24uIE11bHRp
cGxlIGNvbnNvbGUgDQo+ID4gb3B0aW9ucyBtaWdodCBiZSBhcHBlbmRlZCB0byBrZXJuZWwgY29t
bWFuZCBsaW5lLiBGb3IgZXhhbXBsZSwNCj4gPiAiY29uc29sZT10dHlTMCwxMTUyMDBuOCBjb25z
b2xlPXR0eVM0LDExNTIwMG44IA0KPiA+IGNvbnNvbGU9dHR5UzUsMTE1MjAwbjgiLg0KPiA+DQo+
ID4gSW4gdGhpcyBjYXNlLCBzZXZlcmFsIHVhcnRzICJjb25zIiBwb2ludGVycyBhcmUgc2FtZS4N
Cj4gDQo+IFNvIEkgYXNrIGFnYWluLiBQbGVhc2UgZXhwbGFpbiBob3cgdGhpcyBpcyBwb3NzaWJs
ZS4NCg0KSSBoYXZlIGhlcmUNCnwgMDA6MDM6IHR0eVMwIGF0IEkvTyAweDNmOCAoaXJxID0gNCwg
YmFzZV9iYXVkID0gMTE1MjAwKSBpcyBhIDE2NTUwQQ0KfCAwMDowNDogdHR5UzEgYXQgSS9PIDB4
MmY4IChpcnEgPSAzLCBiYXNlX2JhdWQgPSAxMTUyMDApIGlzIGEgMTY1NTBBDQoNCmFuZCBJIGhh
dmUNCg0KfCByb290ICAgICAgICAyMzE1ICAwLjAgIDAuMCAgIDU0ODAgIDE3OTIgdHR5UzAgICAg
U3MrICAxMToxOSAgIDA6MDAgL3NiaW4vYWdldHR5IC1vIC1wIC0tIFx1IC0ta2VlcC1iYXVkIDEx
NTIwMCw1NzYwMCwzODQwMCw5NjAwIC0gdnQyMjANCnwgcm9vdCAgICAgICAgMjUwMiAgMC4xICAw
LjAgICA1NDgwICAxNzkyIHR0eVMxICAgIFNzKyAgMTE6MjAgICAwOjAwIC9zYmluL2FnZXR0eSAt
byAtcCAtLSBcdSAtLWtlZXAtYmF1ZCAxMTUyMDAsNTc2MDAsMzg0MDAsOTYwMCAtIHZ0MjIwDQoN
CmFuZCBJIGNhbiBzdG9wIGJvdGggb2YgdGhlbSB3aXRob3V0IGFueSB0cm91YmxlLiANCkNhbiB0
aGlzIGJlIHJlcHJvZHVjZWQgb24gYW4gb3JkaW5hcnkgeDg2IGhhcmR3YXJlIGdpdmVuIHRoZXkg
aGF2ZSBtb3JlIHRoYW4gb25lIFVBUlQgKHVwIHRvIGZvdXIpLg0KSXMgYW55IG9mIHRoaXMgQURM
IGhhcmR3YXJlIHVwc3RyZWFtPw0KDQo+IEpvaG4NCg0KU2ViYXN0aWFuDQo=

