Return-Path: <linux-kernel+bounces-20989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D079E82882C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D613B1C2443F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A8739AF8;
	Tue,  9 Jan 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Eud9dH6v";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sw0Iadw9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13AF26AFD;
	Tue,  9 Jan 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704810841; x=1736346841;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W9gtB9M/6bmNG1V+o+E3V6GIKF2NU3Itw3HPeKrLAPM=;
  b=Eud9dH6vs/F7yLI3d5NzbY2xo7vppdiZfB+UKPo6et3IrGMYqzn1LQGC
   Q0cDfspciII5VpW+gbIEND8Kgiu5Or8LXizsqUgPLe2/k8AVIPWLbRIJ8
   dgK3zOvCOxS/22IVSrIX3ZGVQTkzj5qHrQiYxp7QkpnxzrsS5NifLWhKO
   JbUdILUC4ol6zZa32x9bkZzu6e/p2xZMp+lxzcwi+uvIvHmvpwuqevSfa
   d0z0VeoNuTK4YxWbY/rNNcyouSE6FeRfmmdM8r8WiRSUNYTPAztQFPj7A
   qLeKc9avBaM6EGtRdUkbBMWL62e1imptCnDzsg8O9G1mbcxRG9d29RxIk
   g==;
X-CSE-ConnectionGUID: HanqUjDTSDSsoho4SZL0xA==
X-CSE-MsgGUID: JrV/FzjmQi+HZupCW2a86A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="15590973"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2024 07:34:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 07:33:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 07:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoAJuK4Pjf0CfarCQwZ7mLwOTe8mXdg24698e8c2cNU6q3igjG4g2EtEalOj0n7EbCZBZ6rI9Yzi79T2k8TeMJ3yU9PmJSOux1bp3WiZUWKvP4ta9TKsUhjNxEmWdwPEy5p4GJCRKn3AJrGLnfhrAvINS+Wfo8+WXhhcHE7jj4cBzCXNbHUfctZYpd82NzmC0GIYnyX6aPX9u8yXWky/AM0RoLP58wElbXNqHFlbsXubCoKh+aJuDrX7XRcS01ScF0QHrfdRdjcoKmCXhfuCDMN6/FEk8+hWC60Ougb9PXMWKWClA46eBoerrcinE+jQqtyHQFek++oEElTXy+e8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9gtB9M/6bmNG1V+o+E3V6GIKF2NU3Itw3HPeKrLAPM=;
 b=XeW/nyyFVYgWzwF6+6xpTZTHq/On4m+eIVAkH+9scfQhDN/l89rJ4omLwEl7eUw9CTdWiLnxdK7iivD5ui4una7YBW5nhSQpoBLrPtmxRYUPAkauCtE+q6fTzMWgVZp7edI9+LQiijA4ZbNUpndbrOgjpUm7vfnJwWSl/HAfPnU0K9+Min/uul0oCzRmfiG8KTR10Bt7MISZzhAk9FIjdsC0wUd9TbQ1fnCI0jjPYvNaenj5LJ+CE6JOjgCbID+7kZZXXkI927WFMUBMweUxEO7H6mh1ih+BepXLCBvQMjl8EqSFz4HgvyvedIBqysS6x3IK/eRxCrIM3Uh3XPp+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9gtB9M/6bmNG1V+o+E3V6GIKF2NU3Itw3HPeKrLAPM=;
 b=sw0Iadw9llc6k+ke2oVDkHMe/kKBQjX3CsqT7pjZhBf19ObvWMCsaWO3nJUG8gAcrRc5Q/caUW1azCPEKGvGXeKVEn5bUn1sQq3m03L8BKIeX+sBdfNvriVcKCqfEDkFbjrG4NI4A1XZTmq6whFcHpBsVpA52VMOvR5QLdV3noj0wBvdKjxPLOB/6i0DTNppOt3pkaj5IqYyaXKGj1tCdLBxzQuzhw3/L4SD9i5ys7n5+M8tCbhUJh8JLkyc0Fbcy6ibHx8dx+nTwxLniRVAiuuDQsO/wrHv17nvF1/59QQj5Rg19TsfjFe/wyD9vSz1nQtTusjtYPaq7agLH9eYhg==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 14:33:47 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 14:33:47 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [RFC net-next v2 3/3] net: dsa: microchip: implement PHY loopback
 configuration for KSZ8794 and KSZ8873
Thread-Topic: [RFC net-next v2 3/3] net: dsa: microchip: implement PHY
 loopback configuration for KSZ8794 and KSZ8873
Thread-Index: AQHaQuKDdRf0GJR4lECCtTi9M42NLbDRjCmA
Date: Tue, 9 Jan 2024 14:33:47 +0000
Message-ID: <5adfec6cbd3ba5fa7c36474d9f395839a2b5b590.camel@microchip.com>
References: <20240109095753.1872010-1-o.rempel@pengutronix.de>
	 <20240109095753.1872010-4-o.rempel@pengutronix.de>
In-Reply-To: <20240109095753.1872010-4-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|DM6PR11MB4531:EE_
x-ms-office365-filtering-correlation-id: 72ef0c4e-ae34-4d17-fbb4-08dc111ffd9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O2sabSqfptWk4antNHhGJ/WNjzpPHpiH5Vs4f39MkhemFFsA+cBdxYj+O2rqtM3XGanHcxnCGBrssMlqb8IBBT3Jm+kxbnjl5jPWFjd/EluosgdraVCv1EQOLJjN9trORG5RKRFWdMQwDOWvYYv/LM+WY/NgpKswqZ+3OREwZdl+0PtkY8f2Ku6stsDPf08GUN6kXhDb8db+imFDvWxaRlURepep5M5M4DaDNVMBwph7L3TE4yZ4+HsFzlSRfRQDuSmwxJgsic1NmfL9jjxzrkqtEFZpTu2rRpge9lBw6a4X7dEDQe3pn8y3M6hCWnrkAQZh+Sg+G8HnTxYPueDsYvqaMz3Z1D8BHTB1S+mFzJlCsg34+DBVm0+R2mbcUKv/umXNK2OOVzcLauPZMsezK6/4QooV/a006diabhxKaVsSAKlWJYqUXCkRcECVQtkXOgdWujynvCDpyQh+S7sx2++YisSr9/Z8M5ZdkUlSF9d0vvWRURaQL68/0SxJUgy0g2/4n3Po8sSS9Om6+IkM/uPEwXYpLjDukLTRbWQ0o29QJUh8D4UBgo676muUG9fRPzAuJIAJuRL/MLuwaYveKMSn/ajX1r+YyE2rXOvLO4dmedceiFl8eXNTVbvUQMOAxTlR2tC18hZK3JFW2dIlh8PHjxn5Gc44wpXkEUqRpNk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(2616005)(26005)(71200400001)(6506007)(478600001)(6486002)(6512007)(122000001)(38100700002)(36756003)(86362001)(5660300002)(7416002)(76116006)(41300700001)(83380400001)(38070700009)(107886003)(2906002)(91956017)(110136005)(66556008)(4326008)(54906003)(66476007)(64756008)(66446008)(316002)(8936002)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2FVVmhiQkRtTTJtUmZyREZkZFFzc3RQcXlnRTFVa3I0N015d3hHMG54RFhN?=
 =?utf-8?B?TWhxUUhWWFQ3S3NacXNpSlQwOHdUc1JhTkZRMkxKMG9iTWEyQmpGamx6MEd4?=
 =?utf-8?B?dm1vNVR3RTFxQklaTlphOEh4NXVmZHpjVHdsdXVhRkJBRktMZXl5NHZnclZx?=
 =?utf-8?B?ejRuYlkvZ09PMW5GUlhIcXBKai80d2pwK3R4M1hZb0NoVkF1ZW5aTVhjeEUw?=
 =?utf-8?B?T3ZDVVAyZ0Q3RzZZOUJkZk1uQnQ3dk11anZoekJJZjNyRTRWdlBaUFBQckxG?=
 =?utf-8?B?TGV1aGpmSWlKYksyTlJWS2VLMWZvalpWTjdoRVdha0U1NEloQXJhSGNtWUFK?=
 =?utf-8?B?RmpNeXZtcTJnS1dPT3NhZHMzVFNYOHFFSGFMYUF0Rk9rU3FqVXpZS2hOWWJD?=
 =?utf-8?B?dnVIckI4Q0dMWlFjRW5uZCtMcTdlcmRtQTJaOWZHbSs5WlpWOXBlakxITmY3?=
 =?utf-8?B?bzJ0VTFDNjZySHhUa29zNkxSYytlZHl6MEdsbjdGZzNvWGZsejVYcEdGZWRy?=
 =?utf-8?B?SHI4N2d0T2Z6MlRFcnlWS3dBejFUVkVLcVIwU09UcFJZbWhBU3JPVU5lTTlE?=
 =?utf-8?B?bVpqcEZFNndYdVcvSVNSZDFOam1Ka05JOVFlbHRBc2JVYjdQY2tONTQ5enFl?=
 =?utf-8?B?RnhEVElDTlAzWC9YSzlZOHpXeU5jV1YyTHd1Ym9MK1F2dXpmbkdoWklDeVA2?=
 =?utf-8?B?R01PZHBGSUwya2Vxd3p1UExjYlJLbUVpS01xVGVmTjR6Y2NpY1cyZUZpSWVI?=
 =?utf-8?B?czV0SXBnbnJTZi9RbnFaZ2J4akhlK0NaV3VlZ3Y1MnhGL3dJN1dwa0twY1Bm?=
 =?utf-8?B?Qi9Bb1hYb2EyaGpzQ2JqblBEVS9Gc3o1dGJYcGx2QXRWbjV6dVFpd3lHNnFu?=
 =?utf-8?B?M0g1dGc3NlZoWHNuM1hUS1FuSFg3NzZrQzR5Q3BJbTF6d09tenFyQ0hwU3dD?=
 =?utf-8?B?eDFpUzRWT2o1VWNaMks2VU9HV0IrMjZPakpIUGtyTnIyd0ZQdm9PWU1meHlk?=
 =?utf-8?B?emJQYWRPMG12QVFXa1VHNkFzMjN1UXozRWM1b2tnV2R4ZGJvMVpEWkxlTEh5?=
 =?utf-8?B?VE1rWDQxVkoraHdGWTlwWENEUDZSL3RWN1IycityajJqSFMyb3NLalVRdnhj?=
 =?utf-8?B?VmVUbHpoSEtKckRkVEM5NHF4eEZLTVVVK1NKQjkrUFFTWDZXVlYrTXJseGN2?=
 =?utf-8?B?enpaZmZ2K3czZWxENGs5MWhneXlNejZpdkNqdytvNW93bGpRcTBMMENSOGdw?=
 =?utf-8?B?TjIwck5Lc28yRThOaS85U3ZJa0Q2a1V5Wk9rd2J4RFNreDVSRjBhelQvemxq?=
 =?utf-8?B?RjFCNm0zNldoMmZDZ3hXc0t1Lzdtc3FIeW1ueEdWVy9ncTFLbmJvVHEzd0xT?=
 =?utf-8?B?bFZPY1cyaG9WLzNIUGZpaWhiVWVXZWJHQS9WUmwzSVViU0JmQnNXYm9CVkZu?=
 =?utf-8?B?SFJQWC9Oc0U4M29BOG5hT2ZwN1BIUUc4b2NyMXowVjJwZi9KbnUrcEprRnV2?=
 =?utf-8?B?SFhyZmZYM2oyMGRFR0R4YWZaYzl3TmJ6VU1TVURCcFVlb0Y0RURnSkdVVlFx?=
 =?utf-8?B?eTU2OGJHaXJCYnczZURoZFVZNVdtOFEzekJ1ZlJVSzBkZkhpdXFjcFQzMExj?=
 =?utf-8?B?Qk5QRHcyNjg5cjFsN3l1WVU5V3pBd28rcWR5ZUo1SWtUV3R5dkJ1OW9XNyt3?=
 =?utf-8?B?bkRQRnZRNWszRHZuV3VndmVESG5mcEFveU9Nc2lIeU9FeXRzQzFvbjZ0Z3dv?=
 =?utf-8?B?ZFlxS0Rtd3JkbEEwMVN3R0ZJRVI5YTlzNS9LVElvQlJkSzQwQVdLVkpsZUlV?=
 =?utf-8?B?SUVEVGM4OW1YTkczak1xTnFJUWpsN05BSUxJY2R2MWNZRWVQblE5OU9NYXNu?=
 =?utf-8?B?bS9YbWx1OUEwSDZwc3lWeThrelNlQzZVTm1qcUZpdFpiaGxmR2RXelhzMHgz?=
 =?utf-8?B?WUFDKzJhbFdJSHZIWHZvTjFubjFIdVJ2L1NJSWNJTXNVOW9HQzE2c1ZFeGNp?=
 =?utf-8?B?a1kyQlZ1U251Y0RobDBZQWlZNUJlZ1dkZ0tjQ3dtZyt3clJRdFhNSGtxd25C?=
 =?utf-8?B?TUxLa1dsV0JHMTRiVUppMHY1ek1adll4NVM0VU5SZ0pMWEtNc2tpTlBrREx1?=
 =?utf-8?B?TURKa2hMdGhCd001b1BWNGpYZUtISjNjTjBJNi9VY0cyZnpEbFpEckZla3ZS?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA4A86975242694CAAD7FBA57BF064F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ef0c4e-ae34-4d17-fbb4-08dc111ffd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 14:33:47.5799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hqb0iGgkCRxlSMHmytXqjouLo0y6dgkgTmkTyjbM2IDCMqInGBSL7JpdiMIPWP6mQOQozcPwpBrpnQuGjYPoUOqR8lMQd1UEbsX2oPkX/Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531

T24gVHVlLCAyMDI0LTAxLTA5IGF0IDEwOjU3ICswMTAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBDb3JyZWN0IHRo
ZSBQSFkgbG9vcGJhY2sgYml0IGhhbmRsaW5nIGluIHRoZSBrc3o4X3dfcGh5X2JtY3IgYW5kDQo+
IGtzejhfcl9waHlfYm1jciBmdW5jdGlvbnMgZm9yIEtTWjg3OTQgYW5kIEtTWjg4NzMgdmFyaWFu
dHMgaW4gdGhlDQo+IGtzejg3OTUNCj4gZHJpdmVyLiBQcmV2aW91c2x5LCB0aGUgY29kZSBlcnJv
bmVvdXNseSB1c2VkIEJpdCA3IG9mIHBvcnQgcmVnaXN0ZXINCj4gMHhEDQo+IGZvciBib3RoIGNo
aXAgdmFyaWFudHMsIHdoaWNoIGlzIGFjdHVhbGx5IGZvciBMRUQgY29uZmlndXJhdGlvbi4gVGhp
cw0KPiB1cGRhdGUgZW5zdXJlcyB0aGUgY29ycmVjdCByZWdpc3RlcnMgYW5kIGJpdHMgYXJlIHVz
ZWQgZm9yIHRoZSBQSFkNCj4gbG9vcGJhY2sgZmVhdHVyZToNCj4gDQo+IC0gRm9yIEtTWjg3OTQ6
IFVzZSAweEYgLyBCaXQgNy4NCj4gLSBGb3IgS1NaODg3MzogVXNlIDB4RCAvIEJpdCAwLg0KPiAN
Cj4gVGhlIGxhY2sgb2YgbG9vcGJhY2sgc3VwcG9ydCB3YXMgc2VlbiBvbiBLU1o4ODczIHN5c3Rl
bSBieSB1c2luZw0KPiAiZXRodG9vbCAtdCBsYW5YIi4gQWZ0ZXIgdGhpcyBwYXRjaCwgdGhlIGV0
aHRvb2wgc2VsZnRlc3Qgd2lsbCB3b3JrLA0KPiBidXQgb25seSBpZiBwb3J0IGlzIG5vdCBwYXJ0
IG9mIGEgYnJpZGdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogT2xla3NpaiBSZW1wZWwgPG8ucmVt
cGVsQHBlbmd1dHJvbml4LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAv
a3N6ODc5NS5jICAgICB8IDM2ICsrKysrKysrKysrKysrKysrKysrLS0tDQo+IC0tDQo+ICBkcml2
ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejg3OTVfcmVnLmggfCAgMSArDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4Nzk1LmMNCj4gYi9kcml2ZXJzL25ldC9k
c2EvbWljcm9jaGlwL2tzejg3OTUuYw0KPiBpbmRleCA1MWUwMTk0NDUzZGYuLjFkODM3NzY0MGEz
ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4Nzk1LmMNCj4g
KysrIGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4Nzk1LmMNCj4gQEAgLTczMSwxNiAr
NzMxLDI1IEBAIHN0YXRpYyBpbnQga3N6OF9yX3BoeV9ibWNyKHN0cnVjdCBrc3pfZGV2aWNlDQo+
ICpkZXYsIHUxNiBwb3J0LCB1MTYgKnZhbCkNCj4gICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IC0gICAgICAgaWYgKHJlc3RhcnQgJiBQT1JUX1BI
WV9MT09QQkFDSykNCj4gLSAgICAgICAgICAgICAgICp2YWwgfD0gQk1DUl9MT09QQkFDSzsNCj4g
LQ0KPiAgICAgICAgIGlmIChjdHJsICYgUE9SVF9GT1JDRV8xMDBfTUJJVCkNCj4gICAgICAgICAg
ICAgICAgICp2YWwgfD0gQk1DUl9TUEVFRDEwMDsNCj4gDQo+ICAgICAgICAgaWYgKGtzel9pc19r
c3o4OHgzKGRldikpIHsNCj4gKyAgICAgICAgICAgICAgIGlmIChyZXN0YXJ0ICYgS1NaODg3M19Q
T1JUX1BIWV9MT09QQkFDSykNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgKnZhbCB8PSBCTUNS
X0xPT1BCQUNLOw0KPiArDQo+ICAgICAgICAgICAgICAgICBpZiAoKGN0cmwgJiBQT1JUX0FVVE9f
TkVHX0VOQUJMRSkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICp2YWwgfD0gQk1DUl9BTkVO
QUJMRTsNCj4gICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgICAgdTggc3RhdDM7DQo+
ICsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IGtzel9wcmVhZDgoZGV2LCBwb3J0LCBSRUdfUE9S
VF9TVEFUVVNfMywNCj4gJnN0YXQzKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsNCj4gKyAgICAgICAgICAgICAg
IGlmIChzdGF0MyAmIFBPUlRfUEhZX0xPT1BCQUNLKQ0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAqdmFsIHw9IEJNQ1JfTE9PUEJBQ0s7DQo+ICsNCj4gICAgICAgICAgICAgICAgIGlmICghKGN0
cmwgJiBQT1JUX0FVVE9fTkVHX0RJU0FCTEUpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAq
dmFsIHw9IEJNQ1JfQU5FTkFCTEU7DQo+ICAgICAgICAgfQ0KPiBAQCAtMTAwMSw4ICsxMDEwLDcg
QEAgc3RhdGljIGludCBrc3o4X3dfcGh5X2JtY3Ioc3RydWN0IGtzel9kZXZpY2UNCj4gKmRldiwg
dTE2IHBvcnQsIHUxNiB2YWwpDQo+IA0KPiAgICAgICAgIHJlc3RhcnQgPSAwOw0KPiAgICAgICAg
IHJlc3RhcnRfbWFzayA9IFBPUlRfTEVEX09GRiB8IFBPUlRfVFhfRElTQUJMRSB8DQo+IFBPUlRf
QVVUT19ORUdfUkVTVEFSVCB8DQo+IC0gICAgICAgICAgICAgICBQT1JUX1BPV0VSX0RPV04gfCBQ
T1JUX0FVVE9fTURJWF9ESVNBQkxFIHwNCj4gUE9SVF9GT1JDRV9NRElYIHwNCj4gLSAgICAgICAg
ICAgICAgIFBPUlRfUEhZX0xPT1BCQUNLOw0KPiArICAgICAgICAgICAgICAgUE9SVF9QT1dFUl9E
T1dOIHwgUE9SVF9BVVRPX01ESVhfRElTQUJMRSB8DQo+IFBPUlRfRk9SQ0VfTURJWDsNCj4gDQo+
ICAgICAgICAgaWYgKHZhbCAmIEtTWjg4NlhfQk1DUl9ESVNBQkxFX0xFRCkNCj4gICAgICAgICAg
ICAgICAgIHJlc3RhcnQgfD0gUE9SVF9MRURfT0ZGOw0KPiBAQCAtMTAyMiw4ICsxMDMwLDIyIEBA
IHN0YXRpYyBpbnQga3N6OF93X3BoeV9ibWNyKHN0cnVjdCBrc3pfZGV2aWNlDQo+ICpkZXYsIHUx
NiBwb3J0LCB1MTYgdmFsKQ0KPiAgICAgICAgIGlmICh2YWwgJiBLU1o4ODZYX0JNQ1JfRk9SQ0Vf
TURJKQ0KPiAgICAgICAgICAgICAgICAgcmVzdGFydCB8PSBQT1JUX0ZPUkNFX01ESVg7DQo+IA0K
PiAtICAgICAgIGlmICh2YWwgJiBCTUNSX0xPT1BCQUNLKQ0KPiAtICAgICAgICAgICAgICAgcmVz
dGFydCB8PSBQT1JUX1BIWV9MT09QQkFDSzsNCj4gKyAgICAgICBpZiAoa3N6X2lzX2tzejg4eDMo
ZGV2KSkgew0KPiArICAgICAgICAgICAgICAgcmVzdGFydF9tYXNrIHw9IEtTWjg4NzNfUE9SVF9Q
SFlfTE9PUEJBQ0s7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGlmICh2YWwgJiBCTUNSX0xPT1BC
QUNLKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXN0YXJ0IHw9IEtTWjg4NzNfUE9SVF9Q
SFlfTE9PUEJBQ0s7DQo+ICsgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgIHU4IHN0
YXQzID0gMDsNCj4gKw0KPiArICAgICAgICAgICAgICAgaWYgKHZhbCAmIEJNQ1JfTE9PUEJBQ0sp
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0YXQzIHw9IFBPUlRfUEhZX0xPT1BCQUNLOw0K
PiArDQo+ICsgICAgICAgICAgICAgICByZXQgPSBrc3pfcHJtdzgoZGV2LCBwb3J0LCBSRUdfUE9S
VF9TVEFUVVNfMywNCj4gUE9SVF9QSFlfTE9PUEJBQ0ssDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RhdDMpOw0KPiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCg0Kbml0cGljazogQXMgaXQgaXMgaW5kZXBl
bmRlbnQgdGhpbmcsIGl0IHdpbGwgYmUgZ29vZCB0byBoYXZlIHdyYXBwZXINCmZ1bmN0aW9uIGZv
ciB3cml0aW5nIGFuZCByZWFkaW5nIHBoeSBsb29wYmFjayBpbiBzdGF0MyByZWdpc3Rlci4gDQoN
Cj4gKyAgICAgICB9DQo+IA0KPiAgICAgICAgIHJldHVybiBrc3pfcHJtdzgoZGV2LCBwb3J0LCBy
ZWdzW1BfTkVHX1JFU1RBUlRfQ1RSTF0sDQo+IHJlc3RhcnRfbWFzaywNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIHJlc3RhcnQpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL21p
Y3JvY2hpcC9rc3o4Nzk1X3JlZy5oDQo+IGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4
Nzk1X3JlZy5oDQo+IGluZGV4IGJlY2E5NzRlMDE3MS4uN2M5MzQxZWY3M2IwIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejg3OTVfcmVnLmgNCj4gKysrIGIvZHJp
dmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4Nzk1X3JlZy5oDQo+IEBAIC0yNjUsNiArMjY1LDcg
QEANCj4gICNkZWZpbmUgUE9SVF9BVVRPX01ESVhfRElTQUJMRSAgICAgICAgIEJJVCgyKQ0KPiAg
I2RlZmluZSBQT1JUX0ZPUkNFX01ESVggICAgICAgICAgICAgICAgICAgICAgICBCSVQoMSkNCj4g
ICNkZWZpbmUgUE9SVF9NQUNfTE9PUEJBQ0sgICAgICAgICAgICAgIEJJVCgwKQ0KPiArI2RlZmlu
ZSBLU1o4ODczX1BPUlRfUEhZX0xPT1BCQUNLICAgICAgQklUKDApDQo+IA0KPiAgI2RlZmluZSBS
RUdfUE9SVF8xX1NUQVRVU18yICAgICAgICAgICAgMHgxRQ0KPiAgI2RlZmluZSBSRUdfUE9SVF8y
X1NUQVRVU18yICAgICAgICAgICAgMHgyRQ0KPiAtLQ0KPiAyLjM5LjINCj4gDQo=

