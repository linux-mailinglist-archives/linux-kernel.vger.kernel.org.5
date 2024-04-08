Return-Path: <linux-kernel+bounces-134716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC689B5EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111262816A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4017F6;
	Mon,  8 Apr 2024 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDtR8JjD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853715CE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543297; cv=fail; b=aqMahbolAvWcxjvEkL2HPIJc2idrV7qTrAaluUi2Z4XrnHDFivV0nohMfuDJIF1jIRO+4VeCI+JXMA2ODKQ99/05wO1hRkuCtsnvmNG2YbwD7Erw6y+/E8XxVUdugcj3wynjOXsqTWiKj3SC/h1J2bkKtgl8gxQC+MSbCvFhOjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543297; c=relaxed/simple;
	bh=iGm3iWUhWX3iW0Uot7+t1DawzRQVinLc85uNyGhqiA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R+JuJ1NgxhoZoaiVSo+oMyT5mBinGQK4fkFHX1rSY5Xz8q7OWwCrZ1N1/bZ9LIcMUc4rqg9Ahd97X+KXbv5mE/0cug1HHQ4fPACmugoJ2PH9Lq6VpmLCvmP0t5X2U+FmXQAusGBmNcnCmv0TgJvvu/vrO9UxNYuZXN6uMjt7Qp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDtR8JjD; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712543296; x=1744079296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iGm3iWUhWX3iW0Uot7+t1DawzRQVinLc85uNyGhqiA8=;
  b=VDtR8JjDUPE/JeWWVw/+J6QdJ3Js11mr8lpVb5p5Jnx1Vj459Mf6ATUe
   t0gafHYFFxAZBKFFqFruL60/XT5728YNqXQys4Yutk/6Nfx8Nlz4IqpdO
   +Yu6SahXkbokUBpDx0qbZ5UOcfsWXhPhEqn+XbIqqhYo60O8v5iUCZ7Ni
   qP51t0qcmbss6s3PgXXwneMaFuijuawxCuD2mkJHXokBEZHle4WzP0+u0
   2oTj28W99fcCo261ZmbqVY+coUQ4w65ChX8rt7Zbo36cVylYeqKRYuYWG
   Zr0h+A0NkFMvkll5IFTmpKiBHwn7rRgS9fbHhXUTl8XLAmCNGZXiRfQBa
   g==;
X-CSE-ConnectionGUID: TLZwIAclQtSnm84NBAwzhQ==
X-CSE-MsgGUID: fnkWa4LAR6CQJJGxaVqVZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="11593413"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="11593413"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 19:28:15 -0700
X-CSE-ConnectionGUID: +DkfGGxZSLyRErqMYojf7A==
X-CSE-MsgGUID: //UFdG7LRpe1mhOeNA611Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19693607"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 19:28:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 19:28:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 19:28:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 19:28:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 19:28:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ghrqa4jwp8+yNS51h0SzoytC2kIB9iBayafyRIfY7UIOG+c2c53hu9EV8kLGozWWsMzc6lIvnoerNHHjm+B5BtvQmyQuZtHYt8irAo/XdzV0kCr3IIELh/bTKCSnCPVSzVXGUeCd5PGHu22Bm/uXxW4hIk6ahp5TokQDdz2aJit+lYUhhN0Mf6FwHTO0g30MuYiF2+dHqYP7RVab7Snw8pC1GXWO5etvtt4RqtHAqpfuETXaBVOLC4/rsqVAVPXEKaZTJikYUilEK/VOaecUtaqTibkVgWInV/oGb1gOynDLhKHReTXICODu0bw0ik1wYHVbsqBIwQWgmTyWD6m6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGm3iWUhWX3iW0Uot7+t1DawzRQVinLc85uNyGhqiA8=;
 b=TTasdyk/EP2B2H4pZwxvTAs8E0bQoYJoXQC9w7KWLZfVPe05vHfNnDHKwXUuqH32t8CTkze7O4viEByDlSbzfOdfu9ZznJwN/79UVi28YMq0mChJ0UTwRK0qt/dFapzqzvPI+c3Pbksk/7TLwzu/JnY8cPsg/s42Ky0t6tudEhIKrZwsBdmx4w+cyReI70UwgiFC2jX51nEkv2EXsS0HfLmHsUaBFe360lKTfAxs0+4ksrPGI14QrmW00p2Syx86dsvPQRjUM+PkWNa/0D08Sq+ys8c5m2G74bZ4krhFtcckJd7eFRbi2/oX5Zp33tHfQZD6kQ+3dUPh8Ugmkeg4tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6877.namprd11.prod.outlook.com (2603:10b6:510:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 02:28:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 02:28:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Topic: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Index: AQHaflqwfTup1ArZ00iKq9wT+H7xNLFMvHPggA6KUACAAQZvgIABbk6g
Date: Mon, 8 Apr 2024 02:28:07 +0000
Message-ID: <BN9PR11MB5276B7C895C79240EB3549078C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A6DDE82623A32FF80F4F8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bc76bb64-8304-4fdf-ae16-03f3e545fd67@linux.intel.com>
 <ae40a717-5a16-4872-a4fd-69c792905a0e@linux.intel.com>
In-Reply-To: <ae40a717-5a16-4872-a4fd-69c792905a0e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6877:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NC3w35xOPCp4lBCm/sz95yVcZ+stvhpUCWgRCYMTPcE7Hjm49GjsBqA7q4xpopeSYL+NGI4P1LgeRxAbq/mBr70QEGAb0x5fLjsQsU0M/eIEcXfptlzAENV6QdBeoaNfDA8KRkFQKy7piDdCAth4VmChOFL+ngRXNxHTPWbFpNJ90rcNTL7uy6XbAJryMEsHiAJNFD5WoeUUbOhmWzItuTmTsoWCbQs1+nwedYkhNUGHW6hL11jFMffwBnSpj9W/LQhnxNa2zeDLro7vIbxHMNUHpow5Xsk/3Z4dv1BT0CTUjf/OXwrwexqDGIHAnod4bVvbf2SxwGf9KssotX5fV+Wggif4gCbZaGg9HhUzumpgQXo/l7YnNV6lFepgJz9hDks0lDhg1raeOf1kpzDQWEOoVBJNrHm2Y2Py3DxsfmlZhMj5yIWAoMgJHaByUc1BIsRpNZMe5vkOMFI1HyL5fVnu/8a/eDSoU3bqK84SNdOJrfpr77S9RbgSrV9B+6ao1yVr+fL31sFrSXUhR8zMFZuq9LOB/fnSMKBW4hfT/WInEaJBgjvPC2V0tGkEOq8SWrPQeq9HtnnCuUo7Yb+SheBmHuY9BBStv6bXRflFE/n/JKeNUhgmT6GcovkBZqRnE3ulK/WYAyIqSe3NXEL7tXgbGx/9t64l6Td4FvFWUNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2NYa2Zhb0xWWlQrVEM0RVJBd1ptakVvcjZDWGNmQVBad1hlTGNRN2JxTW9q?=
 =?utf-8?B?U0QzaUtTYkRyZFlDczRVTzA3NnBYa2pJV3NoSWIrZjQvSHFzNzRvbEhSVjZG?=
 =?utf-8?B?NlJubEFuWTR5S0RBVVdMNWJBNW5YenJvRXJhaWE2MWNqcXM1K2xtcEhpMGhn?=
 =?utf-8?B?MTNVL1J4UVdOcXUzRWRLYlFNTVdBZW1FdFZMd01QTGdDWXM1OEZlOEMvcm95?=
 =?utf-8?B?NWk0MkloczJRQldQM09XVUdiWVpNcloxSmRteC9iY0RoM3gwODVDdmRDMVpt?=
 =?utf-8?B?cHMwUFU2NGxRcFh3Zi9PODJwekdTNU9XalljM0pLYmRpN0xlTVdCRk5EVVZL?=
 =?utf-8?B?dEM5aTRyLzJuWGRWQWdMSG9mQlhoK2ZrWGt3QjdlQjNnOWt4Q2RvVWt5Z0xk?=
 =?utf-8?B?Vm1TdlYzWDJFQ0dIWmJaMWJXZ2JRd1RsQXlXY0sxZlFCMjZDdzh2Q0pRdXFm?=
 =?utf-8?B?aTl4dzRaT0svWURzb2llQklOcmNxeEs4eHF0M2llalZkWXpDTVFjbmdkYWtP?=
 =?utf-8?B?K3pUMTFwR1NidkVmWGE0ZTBwYVAwUDlRL2xPRkVZSE1GTDVrVUN1R09nbFQz?=
 =?utf-8?B?SnhHZGVCdjlzcVZmcHYrbG9JbTVvYUdvWkt5VlYrZ3d2QW9jUTJ2WERUQVF4?=
 =?utf-8?B?S3RpMzdwTE9oM1RCNXpDeXpTcWZLbW81clQyMXpEOFRONUxWeXYyY3h6VHFV?=
 =?utf-8?B?TmxFYjl1NzVrQUNrYk5obDhGaFp6UDFLZ0JSUUhGaFBYbzZ5VW1qblgwcWl0?=
 =?utf-8?B?RVRtRFg1cWk1QmdPOGI2ZXJ3dGZ6UU51RHA4YVBxTkFJQm9rYjlIV1hPNVhK?=
 =?utf-8?B?bkUxd1htbUhmVXdOSDg4MDh0MVlvNzlmL3dabTlIWU0rdGpmSUxoMmVsTE8y?=
 =?utf-8?B?Sm1MajBKVHBNVVI5Ynp0bTQyNG5GeVRDZmx6cjNrb01QYlp6QTdDTCtjdmpG?=
 =?utf-8?B?bzRFQUc1QkFsdUxXb3ZJUVVRc3NTWmM4NUJJYWlnNzBhRkRiWlNrZjRoYkNG?=
 =?utf-8?B?bG5ZNzFvdzlZSEJEZm9sM1lubG0yRUxjN3JzTXdhek1wSkppdHVhS0dINXJE?=
 =?utf-8?B?d2tkY0Z0b3BxMGJrNjFXZTNLM0pBVWE4bFlhNEEvRnI2cDhPbGFwZ21hYWFP?=
 =?utf-8?B?N3U1SFNEaytnMjlYZTcyVVZCYW95U0tUcGNNUzRRRVQvUE9pRFZJL013S1BO?=
 =?utf-8?B?c2JxdnkrbmY0OTlVZ2xxTGtzNVFXNmFQUFE4T0tndk1ZM2NubUk2Yy9FalpF?=
 =?utf-8?B?aENWcG5NSENMOW9wY3REelcxT053V1MyTWJmaUE2ZWRUd3hZOHZJUE5EN1Ru?=
 =?utf-8?B?RHZsS0JLT2ZtdGI0dDdvVVFRNzlNaWYyZlVEK24rZ09WRmM3OHMvMjhNS0Ns?=
 =?utf-8?B?bmUyWjRlU0ZvVzFYdnFkWEFPK3BLTDFRM3lZeW9sZkJhSU44SmFKWDNhLzRL?=
 =?utf-8?B?TjFWQ0JzYmozUXIzNVU3clpsVFRVVVY0UGo0My9TaGQ4N3dndXZQMnFDWFgz?=
 =?utf-8?B?REthYjdMRERYMnBsU3NlWFJRaXJnWGI4akc3akZCUnNsYVcwaXcwVms5VUVU?=
 =?utf-8?B?NnkyalNFUlpLcmtKTUlnWXQwVlZpa1Jmd0NENXNpdElCVnY1bW5WdFdTejhn?=
 =?utf-8?B?dlNEVFVPWHNRakZXb25RWndHRDhodC95R1h0NmtJQmdMaXFQV0lTSnpHbDRT?=
 =?utf-8?B?eXdOR3NGc0dmWkRwYmlqRmxpOGl3VjVtT0FCWGxTRkc3WC81Wjlhd2tnRzN5?=
 =?utf-8?B?ZWhvZ3lWZ1BXbTNBQ2V2bXdJRU1DK3o5QldvOEY0aW5NVTVtaURxVy96NVBs?=
 =?utf-8?B?N3JaeEtCN0haNlRuOGVRTGhIa3ZFWXlJbXBZNHp5U1BvZHRmNy9jYTE5TFl3?=
 =?utf-8?B?UURvZ2NaeHRhT3hCdE9rY0kxMkpjMXpLRUo5MWZCMUc1STdMVjJpMlJUa3hk?=
 =?utf-8?B?QUNtZndxblhYMnovWXBiZVA2ZEpOdTE5czBzaUNheitoaDZUNlBJdkNJSk1F?=
 =?utf-8?B?SHlWR1hWOUNVclh0TEdiTC91ZW14OEZVYnNQQzk3ZHNRMHAxYnV2NzFIWDRu?=
 =?utf-8?B?R1pwYmlFM0JJWWJQVmNjRWpUajFzTEkxV3hpT3NrZi9NZmYvSkZqMGVqNWFn?=
 =?utf-8?Q?zfSQ1E15Xuv+q+kpYUrdKKkLN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa66acf-8bc1-449d-b2b0-08dc5773869d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 02:28:07.1046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqHjFTikr28HVAmK1LhiestHGEYjVlem1aBao3IynM7X4IM5rTeGBMyJVUYHayJUbwDgUgmDTkDdw/oG700bgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6877
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEFwcmlsIDcsIDIwMjQgMTI6MzUgUE0NCj4gDQo+IE9uIDQvNi8yNCA4OjU1IFBNLCBCYW9s
dSBMdSB3cm90ZToNCj4gPj4NCj4gPj4+IEBAIC00NjA3LDEwICs0NjIzLDExIEBAIHN0YXRpYyB2
b2lkDQo+ID4+PiBpbnRlbF9pb21tdV9yZW1vdmVfZGV2X3Bhc2lkKHN0cnVjdCBkZXZpY2UgKmRl
diwgaW9hc2lkX3QgcGFzaWQpDQo+ID4+PiDCoMKgwqDCoMKgwqAgKi8NCj4gPj4+IMKgwqDCoMKg
wqAgaWYgKGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fU1ZBKSB7DQo+ID4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgaW50ZWxfc3ZtX3JlbW92ZV9kZXZfcGFzaWQoZGV2LCBwYXNpZCk7DQo+ID4+
PiArwqDCoMKgwqDCoMKgwqAgY2FjaGVfdGFnX3VuYXNzaWduX2RvbWFpbihkbWFyX2RvbWFpbiwN
Cj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRkxQVF9E
RUZBVUxUX0RJRCwgZGV2LCBwYXNpZCk7DQo+ID4+DQo+ID4+IGlzIGl0IGNvcnJlY3QgdG8gZGVz
dHJveSB0aGUgdGFnIGJlZm9yZSB0ZWFyZG93biBjb21wbGV0ZXMsIGUuZy4gaW90bGINCj4gPj4g
c3RpbGwNCj4gPj4gbmVlZHMgdG8gYmUgZmx1c2hlZCBpbiBpbnRlbF9wYXNpZF90ZWFyX2Rvd25f
ZW50cnkoKT8NCj4gPg0KPiA+IFlvdSBhcmUgcmlnaHQuIGlvdGxiIHN0aWxsIG5lZWRzIHRvIGJl
IHRoZXJlIHVudGlsIHRoZSB0ZWFyZG93bg0KPiA+IGNvbXBsZXRlcy4gSSB3aWxsIGludmVzdGln
YXRlIHRoaXMgbW9yZSBsYXRlci4NCj4gDQo+IEkgcmV2aWV3ZWQgdGhpcyBhZ2Fpbi4gQ2FjaGUg
dGFncyBhcmUgZGVzaWduZWQgc3BlY2lmaWNhbGx5IGZvciBtYXBwaW5nDQo+IGFuZCB1bm1hcHBp
bmcgcGF0aHMuIFRoZXJlZm9yZSwgdGhlcmUgaXMgbm8gcmVxdWlyZWQgb3JkZXIgZm9yIGF0dGFj
aGluZw0KPiBhbmQgZGV0YWNoaW5nIHBhdGhzLg0KPiANCg0KT2theS4gaW50ZWxfcGFzaWRfdGVh
cl9kb3duX2VudHJ5KCkgZGlyZWN0bHkgcmV0cmlldmVzIHRoZSBpbmZvcm1hdGlvbg0KZnJvbSB0
aGUgcGFzaWQgZW50cnkgaW5zdGVhZCBvZiByZWx5aW5nIG9uIHRoZSBkb21haW4gY2FjaGUgdGFn
IGluZm8uDQpzbyB5ZXMgZGVzdHJveWluZyB0aGUgdGFnIGF0IHRoaXMgcG9pbnQgaXMgZmluZS4N
Cg==

