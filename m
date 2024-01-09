Return-Path: <linux-kernel+bounces-20982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29075828818
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAFB286DE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D92739AC4;
	Tue,  9 Jan 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="acKqlZM3";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jWLPB0eY"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C139AC0;
	Tue,  9 Jan 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704810579; x=1736346579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BrAKMgPJHgjForyxXyo1CaQNJv9NMZJa7NUrV+geBtQ=;
  b=acKqlZM3TLy5R8v5UwQ4DAsTR3t57+QEqZEjF3E8Qcxe/dMCmVszkO7i
   0LhPuF+/vWSP4C+ljnzWoWv+gA+CYj7Iva7cdP8WjAlw/i6EFFHDukjLC
   JTdFEzX7eMoAcH76qgjszwT6tyXWXApKpeoaeaJuhHpsqghjlGS9EDne/
   XKW6gSCUumWpn7iv9KpOMybNGDUxMTMPPVNfZ0YLrZ0HK7/VBoXUVzUJ6
   94VNamyY1ELMWdueVDonmZJUVKKohhevuIyKJxDqWuFExuuqA9uQ2kL6i
   O/2OIEvS24cz4PgJ7gbJiTjMJgPV+Ij8fFGVF2tgR4ebWtYzUNEZ1oi2a
   w==;
X-CSE-ConnectionGUID: YUo/rvHsRLW3Z2DQ3bg3gQ==
X-CSE-MsgGUID: hwS2C0IjRwy2vQwW62CGCg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="14486452"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2024 07:29:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 07:29:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 07:29:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFnCRFBmWDwMdOsMXgRTOo6UFwFgL1KihbdQxS+4R11tukfAswVtrqW7gwcIwLyAJYen06nr5jT+0urESKIIyd1IhXL+18ue+sojAVTPC3PAnHgAA68u2FxQUK8TdIqa4SPZ7UzeHC2TtRsBFMvn8vHWvoZI6LRTg96uTyhC5ZCvaEI4hau3HftEfbhHcnB1qIZWNzU+1xzMTt2lCfU36vAZa9/BQRSFaVZg5EtWh1YpiLkRl31IlBCBXJP+SkSQIeu4bJnRebJ7EzKRbTXMme/7+8hSIl/nnl3XZRT8vz9dETocY+qM8wUmUPeQwtCQP1ohAX41Bn1tYUUmtRimMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrAKMgPJHgjForyxXyo1CaQNJv9NMZJa7NUrV+geBtQ=;
 b=MQiWPEcXhxJU3qrD12uCgynPAlfDzx0M5ftUc+IfTgrfQamnN9sohcs6yXf5l/KRjXU1Wps9AHX+skVVJycvrOJBMPo7nJP0z1wipJS+AvmdEIxydXcAUKBRH1Gn+G90J/ZH2qeqF48Wit03CwBHelCdSv1ALjjaPJFQDfwMof/2uYcYWXB7wZb8+B4IKBMMmDkwXPWn0ShblZOvas/wcASYoGnjVPhVv/5o9icS59CfHNZQ5uHKPS6AUGxIEgy6jASMqsAI0vMCnMMI9KKOKphiT5ja9P99VP382MGa6UuSDpuq7fZI47juOLm0ItIJaMQ3rFYJdz1wej7lXn2lCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrAKMgPJHgjForyxXyo1CaQNJv9NMZJa7NUrV+geBtQ=;
 b=jWLPB0eYYqAoumiiAC0KhnNIOXVWIYxAvh3BDz3cuyvy+S2sE7+/FRhvuNcgtDuePKzyGfVVTz0oVpF3J+5ULXmmu2HxRtB8MLokihhiwRhB0II6Zf36lOmiYkJN8gFuHkcoIdjc1p82uwWWi+rykMOPok4Zx9Jkw2A8YhKlw0f9kZuKdGocSTXqjkOMmz2hYO/TEuJeNegd+3XlFKenNoHmsYfc14VfVTD3Pwk8TTEex19tdXl/J0tMqh/mYu59Ul59E4JbtNYLGaUMmY5ey69jdn6c+OxC3P7pR3ata8mPekXsQo+CAujtcZaQ0sy2Pv351QdcV3XgcBTwuHTWJA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 14:29:28 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 14:29:28 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<vladimir.oltean@nxp.com>
Subject: Re: [RFC net-next v2 1/3] net: dsa: microchip: ksz8: move BMCR
 specific code to separate function
Thread-Topic: [RFC net-next v2 1/3] net: dsa: microchip: ksz8: move BMCR
 specific code to separate function
Thread-Index: AQHaQuJi05XSeWv7c0S2UK9LVu/TNrDRivIA
Date: Tue, 9 Jan 2024 14:29:28 +0000
Message-ID: <4f7f62917931e08edafc3f95debe3908f443806f.camel@microchip.com>
References: <20240109095753.1872010-1-o.rempel@pengutronix.de>
	 <20240109095753.1872010-2-o.rempel@pengutronix.de>
In-Reply-To: <20240109095753.1872010-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|DM6PR11MB4531:EE_
x-ms-office365-filtering-correlation-id: 7cc1a474-31b4-41e7-fefe-08dc111f6316
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21vGFz48bdQk+P6Jva3ytzpHCnOj8JjoJpdC7+UhD8FnAvL2/Ew42cyySWdgnH1hr2IWyCZR8rsuzzr7/xTBEZTESnZJvt1NN2Kq6fi/qOhNQ31uZLfvdu+ySZ33oQsmh4Cc6XRLh2Tkylu3wvPM9y3Yf12229GJCeRNjdkgrEtYYIl4GDhU+J/GJ5EYcY0I5Di18Q5FXA/YgIRmFlXMuYzP8aACWaGUdjBxGfZSZeg3noId6PwUSOPlGweMGXrbfCt42TDFLLVxdda2FOpT/+YupEMIgb+feu0dK6JplbFJdLOh8iCyGBv/huFp31+JZynT/8BV6Q6IJrfroU7s7TdY1y2KJotysa05mMDGE/KRx+LKhbN3u/+TVOKIjxCBNRdaQE/oDdvVWxTNjWdiHx+408U6P006+Gp9DIzvaVnAQyW+pynjn7OfNBM1+mimhVnQl+QDOoYDmk+hw41+p5qtVTMexTVE1Dn+Cn7zQmxnxRftp3psIWpOTiJX3vnDW54LL+YyijXSnWZ86eERrJLw8lb7mp56I769yzlcYLZ3pXSHb02WPBguXWR5Xnl7ZZWbKry4u1tv1k1uWili6ASEGYPElRfYGlbjXB06Ti9a1F6G/05UCiZrNlw3WfiBMSZipbCxFJ8MyzDG1EHWnz3VBhPT/87FNvT/daPSykw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(2616005)(26005)(71200400001)(6506007)(478600001)(6486002)(6512007)(122000001)(38100700002)(36756003)(86362001)(5660300002)(7416002)(76116006)(41300700001)(38070700009)(4744005)(2906002)(91956017)(110136005)(66556008)(4326008)(54906003)(66476007)(64756008)(66446008)(316002)(8936002)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R011cFpSQUJSb1Z3Z3J5MGhRQWVScE1MdCsvOEh3a1B0Uld1U1lJN0haZy9C?=
 =?utf-8?B?VGZ6MGpET2FoZCs4cURSWUt6NWZVWWF0UHNXQjdNeSt3Y0NPRmpMbXlIVVl6?=
 =?utf-8?B?TVZtb1dXVzhhTWE4UmJNM3U0ME5nbFhBYmQxajJpNER1ZkNTY0IzQkpMdzJZ?=
 =?utf-8?B?VVRUQUV6RzB4Y1ZQUExVYzk5ektSWUZJeE1GQW1FNDZzamdkdVJlRjZlNmVq?=
 =?utf-8?B?OWJzdVcveGVFMHIrUlpSUGthSno5bElPSk5XSUlYMjdNemE4K1IxM0NWTmx6?=
 =?utf-8?B?YTBxOHY1Rjg2TitTNUEzOVdZeWNJN0F2SU5IUVhlbVJEenZKcDRaY3pDNjZx?=
 =?utf-8?B?MXJrQmwyR1lmRVhyL3BNbzJDUXNsWjNuTWZuWWlLdnpaZGhBK1VPMEVrdXhU?=
 =?utf-8?B?OVpEOU5kem1QZTBCVUV5MzJKSjFNa3ZuZU1xMFR2d1hwWXV6T241dGx4dVlJ?=
 =?utf-8?B?WE5QQ0dNL21yVThiM1VObUZyOURtR3pIUktTMFJ2c3hTKzhzcCtXOW1BRFZk?=
 =?utf-8?B?ZkhONTFvUUxVdjlRQ1hudTZxZndkUTlnK2FlditKc24xWUFGQTR0c2NndUk3?=
 =?utf-8?B?ZjRQU05ueFZOSmU2ckZlR0JPNHJDc3VUSFdwM1o3OUlCdEQxUXpURFY4SklL?=
 =?utf-8?B?UWNPMVNUU2puUDNWcFFIMTFRVGtIMXZjUzY4eldScytqbE56Y2xjSW9DWWhP?=
 =?utf-8?B?MnQzRitBZWZwL0pZVzRHYnZuR044QWl3eE5hUzZCU1B3Z2pSeGNKM0VhdjE2?=
 =?utf-8?B?OWduaWJyMm5hNTFrdXBHcHdFTTM0eW11NWE4TTE3V0VrcFhVbDZXY1ZaSEV6?=
 =?utf-8?B?N2ZWU2lOQS9idHRBWlBaOVFWSTBqZDgwVEE1djY1VWNnWXhlYjFWSkFKNW9O?=
 =?utf-8?B?YVZTTGRKOXZoSFJveERxdHFQcmFSTzFKaEp3blpFR21zcnlTV0hWeVBybUVw?=
 =?utf-8?B?QWxaY284a1BpMEU5T0hZd2FlRmxSb3RXeU1rYkVMM0pFc1pualErdUUyWlFx?=
 =?utf-8?B?RS9TYXI4QzB2UjdMVGxXUDJEaDJyQTBGcElHZHUxWnhkQzh6Mm1UQVcvaUJ4?=
 =?utf-8?B?RlR0YWZGU0s1NnNaSkk4UUozOUFuaGtRTmhOQlZtRDFIcm9vb1BhcS9sR0tK?=
 =?utf-8?B?NzVFL2xPZFlRTUtTenZtcTlBcUNJb1gzOTNZbkg4NDhlY3F4WHBxaUJXdWpL?=
 =?utf-8?B?SmNwMzM2WTVZS29uejVBakx6cFRacVJFUXhVanhDWUt4UEF3N2RhSXFYMUJP?=
 =?utf-8?B?SWpmT3lveEVpZHI5YmxhdDZzVmdUUDhGQm9OSkVxdk9BK0tHUE4vVlR3b0o5?=
 =?utf-8?B?Z2RHTStFS2pLOFlTaWxUa0lOanRoTys5QkkvTG9iY0hJSUdrTDRnaEszam1s?=
 =?utf-8?B?YzFzNmRGeHgwTExBUFRoa3d1TTZWcEpNTTFyNWhVOXQ0RlNDUDRPUVA2TUFO?=
 =?utf-8?B?TzQ2M3VWSmt6V3luZjk4U3JQTE5aQ3doZXgrVTc3ZmM5MjJJakVjZHBQUThU?=
 =?utf-8?B?WG9SZ1hqVVpheWVZdGtXRGY1QUtSWVlDTWU2WUVrUEpZZTcrczFaRzRBSzI5?=
 =?utf-8?B?QzRhT3gzV0xjU29idlJqc3pCNzQ3T24ybjVZN2tQREttZEpYWVRrQmwwODNF?=
 =?utf-8?B?R0ozVStiOGw2ekJiUXhBSnEybVVWUEFiTDdxcjJJK3JlSUxKTHpjSVNpSDZu?=
 =?utf-8?B?ZGdRSnBPVFVZaGZlSG9pL1RsK0JLWDZMazJtcGRFdXo2UmdSdUNjcnhralVF?=
 =?utf-8?B?MjNJdVMwWXcrUjZXVUFHTERIVll4K3lvbFpsdS8wTDZieUkwUVZmU1hIclQ1?=
 =?utf-8?B?WExranZVY2FFNENYTEI2U1F1RTI2RE83OXVHcnNHR3B5N1QzNFhvWXJUSzVS?=
 =?utf-8?B?aDR5VWZvcmt2R0FZMHNZNDFMVEl1T3AwRG1yczZYUVZleGZzZVFXSVl3aFgv?=
 =?utf-8?B?a1EwbmpwWldWZDRjMm0rTHNRYWtib0F6QXZhOEVaMktDVW5DQkhzMG1RU3Vh?=
 =?utf-8?B?aGhtWEQ5N25FdDEzSk1NdzFoZklDRVoveURIeUZCRFlUM3lwZUd2QTM4RHJo?=
 =?utf-8?B?K0ZFTHNmQzM0a2E5eWVYWXMwOU5ZdWRWYStJcWxDdGZoRG5PYUdGeml0R29r?=
 =?utf-8?B?QnRFUXdvOUxmWlhLckNHQlUzRitYUEVZM3c0cXcrTUxzMTVuSG85RmtHNHVT?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4A11C5BAC2B844981C6869DB7845A3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc1a474-31b4-41e7-fefe-08dc111f6316
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 14:29:28.3522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2GAK/WDW173VA1JF+8xA2vAJ6Ru77zniF+CKupuLxFe0Xqm7kBPgRB4XSnZxIxndFqdNPJ+pCf4vRpOlRSH6xnHl751gS+L8hLCwPOWLJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531

T24gVHVlLCAyMDI0LTAxLTA5IGF0IDEwOjU3ICswMTAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJc29sYXRlIHRo
ZSBCYXNpYyBNb2RlIENvbnRyb2wgUmVnaXN0ZXIgKEJNQ1IpIG9wZXJhdGlvbnMgaW4gdGhlDQo+
IGtzejg3OTUNCj4gZHJpdmVyIGJ5IG1vdmluZyB0aGUgQk1DUi1yZWxhdGVkIGNvZGUgc2VnbWVu
dHMgZnJvbSB0aGUga3N6OF9yX3BoeSgpDQo+IGFuZCBrc3o4X3dfcGh5KCkgZnVuY3Rpb25zIHRv
IG5ld2x5IGNyZWF0ZWQga3N6OF9yX3BoeV9ibWNyKCkgYW5kDQo+IGtzejhfd19waHlfYm1jcigp
IGZ1bmN0aW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBl
bEBwZW5ndXRyb25peC5kZT4NCj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGlt
aXIub2x0ZWFuQG54cC5jb20+DQoNCkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFk
b3NzQG1pY3JvY2hpcC5jb20+DQoNCg==

