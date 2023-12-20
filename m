Return-Path: <linux-kernel+bounces-6441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63E8198DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DD81F21377
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B9C13ACD;
	Wed, 20 Dec 2023 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EK7HKc4F";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KeUmAJ2x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35441D525;
	Wed, 20 Dec 2023 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1703055344; x=1734591344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UdAdpdOAixt1dbZDd9ahXI1pPzzXXVfbEHQeVuNFH4U=;
  b=EK7HKc4FBMX9/ZcTGDP7Uwbo7IwXh4pbGbOWj3uXjEPWaCHwowp4ANuH
   6SFTlDIvPW8OeuEOmkCkzwgNJd+gPcNhN9FcGNmYm/cLI2TToH0wQenVM
   sqiGlOmDWkfn8PpKkCvhX+AEnmCykLEgeHzA0R8I23HuD200av8Qn9D7v
   oYQHr8XV8tWFPCHnECjIB8WGI4zwYTUNbW4PX2hVV4R0rF5hGjRik+Hmf
   8nSYsuxJDJpHOx4/AAGdEtiH+RlBe2NaLrzbJ+PGnf+PBd8tEPrBScRJq
   UzpgQ6AtaKAI/nKz6vzw/JxkcI5FGRGof0I7hRYpS2ITgkwGmpom+HIRC
   g==;
X-CSE-ConnectionGUID: deyZ3ArUT9O14vM1LzonaQ==
X-CSE-MsgGUID: s9SSGvVDRdKdesX9V7vvBg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="14001546"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2023 23:55:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 23:55:15 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 23:55:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZC/vBwzNFP2zFehX8iMAhaN5Qd8utpV2z/ngJNCuvM55FGf4ePhVIqvX69zeFrQRPwOdWH1dqoUwyHklaLRqAEAtpdbAhAjvef52X8tWwiTx8cVT2ZO+4slApGpOxH9smPks/eO7WKDSyicPzPOe9dQPb4fBxfHMDbz07WPbfs6AtxjUnvovtgeRRU8GSw/hNCBeG049zRbsPNt4wGnIzrHeyWDssMDa6Ku2II5luAnn5dbLD0wlHdL05VmeoIe+wjreGOlB5io971vEudJrfbPxeFH1rCT0Mc8yjPzSNy1SoTGNhqCI4H/T7tqGTSGxX8i9/NjCAgMdl4qY1ZZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdAdpdOAixt1dbZDd9ahXI1pPzzXXVfbEHQeVuNFH4U=;
 b=QHI8UqAYeTDtekr0pB15EAY/sL/ywfHIB2J3J8rA6xy/2sns+oJFvXix97KWc7zbgKKsKo2oMmn6kRNCuonGjfcPjQmMM2N3nrUJAI0nqiBIAIKAfxv6dz8te2TYZfkTLSiLAqOMO7ZWLedhzI6FCdyi7fP31v65lLLUVvq7MZFA2Nec+JFPO2Tv9yZC4U1/jvcqvltGluDojzyQE/GS0Uy0/haaOH1GELomXjvm6d4lKGqE0+Ckc1EkSJB32xmXUiHlaFJ14REOGJBlqXUBIZl+soKRyTnOk0TUriIpzC3EuC4G4c4UxjB6IophHFuChwlF2gxZgT+0h+QUBK7M6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdAdpdOAixt1dbZDd9ahXI1pPzzXXVfbEHQeVuNFH4U=;
 b=KeUmAJ2xAvVV7UAJxx65NcfaptOcxO2TcCDIzaCa7s8io9CLERSl3Nrc8G2/FB336m41155lJyPy85rw1GmdvxqnVyhnUYEnBDmwZO/rS0f70sPLE9mB1Q86dsnB5ZkM1xyXuLlmtafhQq3MyK7o0Hol/yGsBnV9/zKVppGPAiSlpgy7W9JzmkLFMFzWtBl+rkn49wLwHL86CyWyJtwYP2rS7esN4pTQs8K1Q7YR++jntbvuEnBlbbDTz4Rk50gyh+Fciq2kygigYIO4dH7sS0tayhgku1p6+rrAx+cQIZ0km2UvFoLhIIFwDhdz84YgNG3loMIRQ9zVLondbV30kg==
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH7PR11MB6769.namprd11.prod.outlook.com (2603:10b6:510:1af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 06:55:13 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::6f84:a64c:8a54:e714]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::6f84:a64c:8a54:e714%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 06:55:13 +0000
From: <Thangaraj.S@microchip.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <Arun.Ramadoss@microchip.com>,
	<Jegadheesan.GopalManoharan@microchip.com>, <linux-kernel@vger.kernel.org>,
	<Kumaravel.Thiagarajan@microchip.com>,
	<Tharunkumar.Pasumarthi@microchip.com>, <Ronnie.Kunin@microchip.com>
Subject: Re: [PATCH SPI for-next 2/3] spi: mchp-pci1xxxx: DMA Read support for
 copying data into SPI Buf
Thread-Topic: [PATCH SPI for-next 2/3] spi: mchp-pci1xxxx: DMA Read support
 for copying data into SPI Buf
Thread-Index: AQHaL1rAmSLpl9BUp0iMs3XDDQQLEbCxw8aA
Date: Wed, 20 Dec 2023 06:55:13 +0000
Message-ID: <25eade66ead38960f13ce1e0f35bbbc5d3f2a9f0.camel@microchip.com>
References: <20231215114748.152319-1-thangaraj.s@microchip.com>
	 <20231215114748.152319-3-thangaraj.s@microchip.com>
	 <677a17b6-39a6-4b1e-87f5-2c01b19bbe3f@sirena.org.uk>
In-Reply-To: <677a17b6-39a6-4b1e-87f5-2c01b19bbe3f@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|PH7PR11MB6769:EE_
x-ms-office365-filtering-correlation-id: 86fc8063-53ae-4924-8c4b-08dc01289dd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDP3f+7VA/zTM6j2b0OBpBsgEKnqLUN43tW8prXG8zAg13OzlHYZ9X9Sesq1BSWEGhjIum20Bg+QZGIMHhXhWpaFOFeFwAr8VWW5hTy+skjECetihar2DUf5kFSXt9s1H+oPfaSylFnXQi8GKkbnncfXNF+2u1sNczF1W8lJ9RMI6oeoQHe7w9wXeZ4wYTPDRxME0rdrNqcCBor3cTVP5IEvlStdVQ9YDGiS6aHzVyncD27nxjI6PXpX2P1I2NORAP+4WOYc3TrhKToHXNAZ+3LijTaKsg2sszV+XWd6J9fv71+8UBsR55z//pyOFBEGh1nqhOJpTRDCbamJxhMsI7FEBgk3cFG/uJg+ojFxzgbWePnrzAZ9aKBSLjImQ6titDBAlJ76Yc63nlIw6+9yx6mXgmTsgu9yCSVrARSla1HnxiPVES6QmlPjS96iQG6a6LFknXi4Wt4gsAS9uNYHpOWD5BDUrYOs4OnFAmMRu0kmbSBnr/epkeFbo6Z6nrIZ1X9GIRzijwHO0UhRd6xNVB3r5HnblZLc/ZjIkAVXMmFaHXQvu3jQZXlNtegf75TbRAk8UdKhsfJ9hjaMlN5ns6aBY7sX79L5VelXv7Z+UhXYtBodiypXWrHQqFvvyBomBDDK9oN5DMNM93sZcte7280YofHLnypSNVUFIx0TgMg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(66946007)(66556008)(6916009)(91956017)(107886003)(83380400001)(54906003)(2616005)(66446008)(316002)(76116006)(66476007)(64756008)(38100700002)(478600001)(6486002)(26005)(4326008)(8676002)(8936002)(6506007)(71200400001)(6512007)(5660300002)(2906002)(86362001)(558084003)(4001150100001)(122000001)(38070700009)(36756003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkFBKzF0R3F6NDB2Q2xLcVJRMXEydUlsaFFqZjR6MkxuSTg4VUkrVWhtdXdI?=
 =?utf-8?B?R3RCaHlBWVU1THl6TEJDVlpSbUxwZ3NHdEJDNkQvVmU4Q0l3by9jQU56MmRn?=
 =?utf-8?B?K0pDOWMvbVE0TmVBdG90MTMyai9zclJWeWdEcWVVcXJROW5iWFBTVWhvQ0Qw?=
 =?utf-8?B?WG1uYTI1NXRNczc0WXBIVThvcytjVEVxL1ErYmV6Y1FLNy9WVE93WXpjTStu?=
 =?utf-8?B?SDQweU5jdXhHNXlLUmRiaTJCSWcyeVlGSmJ4TDVvQVRvbzlWN0lTS3BVYWpp?=
 =?utf-8?B?ZnM4OFlWTldJZDhTZksrRmVJaTU1cTdEWXNYdGVwUE1IcVFPbEZYc2svYnBo?=
 =?utf-8?B?UUs2eHFvS3NTOFVZWitrZXNNcFQ5NGlqcnBWY3FHZVhFS1NpaWdMWmt3cUVU?=
 =?utf-8?B?K0JrV2NBeSthM3dtRyt1SHgrcndPSks0ZEdGQi82dGl4Y2Q4MFpPenZVSE1h?=
 =?utf-8?B?bHhzVzVhZDVHRE0xMDdneUgrZndyaERabHErTHpOaGNXRzFBSElMb0wyeXZT?=
 =?utf-8?B?WDBpUmNVVFJkTC8xUUJmU3VrQ1NKbGVzSGxzMkE2SkFLRVZwRjdXYmZLYnp3?=
 =?utf-8?B?SDMrM0RaNU5OVS85S1JOQzFIQzN0NW5CbWR3U1FJejBXSW1ybSt0QzUwTjN6?=
 =?utf-8?B?V1ZIWjBOVGlQLy94MGorMncxVzBSMjJEb01DQXo3OGlkdHdjeldLNEZpeXEr?=
 =?utf-8?B?eTdHL0hLVWdvLy9IUWVBSHp1b1JXR2NWeHpXMGtNazFoZWpVQ2ZJZ01GSmJq?=
 =?utf-8?B?UW5ZclpxNVJVWjZGWmFEVmVoY3RIWkcwOTc1OE9LRXhEWU1rRkl4N0xXSFFO?=
 =?utf-8?B?WmVCZjJ0SVpGVUJ2MS9nWFFuUXF2SzZ3ZHpoTlkzMUt6WU96eDF4SHk5NnF6?=
 =?utf-8?B?eTd5eks4dEFVbXJvbEZKYStKcVFybUhGblRqcHFqSnZ5SjdVRnBaTVFQTkJw?=
 =?utf-8?B?cVVpNGppZnFwSWtXVksyMmszcGh6WDNCU2U4QUppWFArN0hFbHJEaGIrb1Bq?=
 =?utf-8?B?ZXkveWdnc01UV3FnUllOQnZiYWF5Zmk3alk0clRhbmJkbnFMK0JZSnZmSVBk?=
 =?utf-8?B?V0RySzVleTJJWWhJNit4c1ZwbCtIeFhwTW8zL3JDTEV1L3JNQVcwMENCK09t?=
 =?utf-8?B?QWlUS1QrRStWUDJhUWp1a2dXQld4bzc4YW1Mb1ZXeGJnd2dVaVNsTnJjeGM2?=
 =?utf-8?B?SlpLNkxMZzV3M29MSmg4UmhNWG13TkNIcWJ0YUJGQlJoZ1dQSzBiMEovM0Vs?=
 =?utf-8?B?dXMvZ0FYSDRZbWsrM0JUSForUkNXNXVxZEp5K1VOeURmc3NPUUVQam9PQ2Zn?=
 =?utf-8?B?M2orZ1lENEhCclhGYmV1MjFBSnY0SFZWbjlpRUs1VzlGUjZTM2xrY21jeUhy?=
 =?utf-8?B?cy9zVWVVNnYyU21Cc0tpYUtOSFJnSlMxR2ZmWlVGTHJnRkNLQlkwMXJuSS8x?=
 =?utf-8?B?S3E1cURlM01Nd1lTQ1l6NFN0RVhwSUpsZ2ovaktIaFQzVGExRGplK2tDUnBl?=
 =?utf-8?B?MDBOb3FzOEpIbm5sVzV4VkxQbXU3VkxnaGFCMVdnd0dkQ3ZTeFQydUdDMGdk?=
 =?utf-8?B?dk4wOUxqdk9zMDF6S2owRUVmZ3FncVJPOTZvNFc5eFVuc3ZFN21UK0hxUEFu?=
 =?utf-8?B?ckZTVWcwUVZ2SjYwSkNOUEtUaU5wNURqejJaOTdYRWxZNGFmaEJGdXJTcWtF?=
 =?utf-8?B?R1hZUXkrQTVpOFp0VjA1QkJRZVVXT1lvZWRmWDhjVVB4a0J6Y25EV1Z3M0RP?=
 =?utf-8?B?VDJuTnFzVFF6ZFZzcE9UK2xZOVoyTTBhUHBERmNUZzROc3hhQU5BblQrZW9B?=
 =?utf-8?B?eS9VdkVmMmtackdRdzhBaXhwQ0pHU2U4dHB5eXBXZEwvd3A1dkRGRU04L295?=
 =?utf-8?B?alNCNWxzNVdmV3JQcEMxdzYydVpqQmtIMEoyNFZCS3NJcVAvbHFIcVFlRFRF?=
 =?utf-8?B?TVMwUVpoNE9tMUgzMnVEeWt5KzdEMTdNTURUSWRlY3RCR1IzRlhhanRTcHpn?=
 =?utf-8?B?Q2JLR2E3Y1lzMnFpN1JWYmJOZzVtZFdnZEdCRGNwZU9pekhPT0dEVk9GMXRB?=
 =?utf-8?B?RGZrQThYdWNMWHdBSXhxUG1qZU1aUUhDOEJnckVVY2Z4KzJOQVRBWXF6Y2Nm?=
 =?utf-8?B?VWlDNk55RnBMMVdYMlNoOUNOSCtXK2QxVDB1Y2Z2RjdoQTZxclVxUHpaUTdn?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29EAF7E06CB23E45916128F60C21F821@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fc8063-53ae-4924-8c4b-08dc01289dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 06:55:13.7754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7HKxoj85uOJ4C0YLByKrUN+vHM1wGA9POey7eyFCBkBcMyJOya82m02C3sjgYeGmGnh1Bi6YXF+SrqKa3n30pfGTD7uvrURR9qspAm02YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6769

SGkgTWFyaywNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4gV2lsbCBzZW5kIHRoZSB1cGRhdGVk
IHBhdGNoIHNob3J0bHkuDQpPbiBGcmksIDIwMjMtMTItMTUgYXQgMTM6MjkgKzAwMDAsIE1hcmsg
QnJvd24gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0K

