Return-Path: <linux-kernel+bounces-21883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359E829602
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08590281D63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA63C495;
	Wed, 10 Jan 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IfxRwHbt"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249271113;
	Wed, 10 Jan 2024 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXREnSpuokaJ20c99n/h469+xC/53w85X35tilZaQJAQju/PnQ8J8qkXgAkUnuiMaNpw0Wq8m2DMfxqwB+S5WTjraDiKLzUwExbZZJn3ypMEQFOo9P12k7cMfBzEca51Oeflqj6lQ1sq2MS2daO3Hkrrhqk62xpI7YkMVAOMzk5wttBuc5wbmOnsgO/McHEMBn2X65dAByIB2ALLizKGvXKtrDqT1uFr2ozpwMG8yGSQzu7nz+LSrp2jCE2UdmrY1pJF3dYwFrA8Sh3/dVhiFUlB46pnkYWRVy5b1JUiMVaMUzTOoj1WLnwhyybix8X5gcYDLhX/ZXqd/IiCjtS67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jOJN71ZENUb/YdbjMGCmBU/qll1BZKwxg43ACXsdGA=;
 b=OLL9K8QneTOxzQWao5N2eZer5GleGiJA4gOUzms9zdf9jei7dxrOsj9saDkGGBtSUQzztk9mvjCdfTQ1WbPZf6voomyRZlOLGMM4zGd+HRpzsteb3YmVyX6mUqmdj8o9jVW4UnCTLe6B20fQpCKAMwGNPeO8NzYkrSmKwDZ0B7AUX/D8E/Cr8XCTzDgcR0Vh/5GZwNzifGcJr+DAOjen7TcfWpbd0HodOZ1MIHZcdSjteCrIB60oOojQZMbage6rmr699SkTFXGwlEYe4hKfJe1cseX3/tPNXz0gH/013PlvpGkjMq+KfoGGncuqsI3opg3XWzBKsdYnoIgUCoXHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jOJN71ZENUb/YdbjMGCmBU/qll1BZKwxg43ACXsdGA=;
 b=IfxRwHbt6Vk14CodToMHDcCtYS1FG4EpZrzH23pkVH+IyychKqwb7aqGL716hdYuWn0PoYPl956uNr46HjEu2ZvqCcPNUjwLhcx7QOr9IKCUC1oK5D7Ekf4s5eDRhbRSvtbhkpVPx/mNThKD78kjLdGiFPYYMgoKHGSZ0nCqyQo=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 09:14:39 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::aea:c51c:23ee:6b49]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::aea:c51c:23ee:6b49%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:14:39 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Dan Scally
	<dan.scally@ideasonboard.com>
CC: Kuen-Han Tsai <khtsai@google.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>, "Mehta,
 Piyush" <piyush.mehta@amd.com>, "Paladugu, Siva Durga Prasad"
	<siva.durga.prasad.paladugu@amd.com>
Subject: RE: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Topic: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Index:
 AQHaDVvg8JAIX7opVUGPeVND2R+OwrBm7bwAgAlqngCADGtuAIABEQoAgAAcxwCAVT1twA==
Date: Wed, 10 Jan 2024 09:14:39 +0000
Message-ID:
 <MN0PR12MB59538FF4FF9C753EB9264E21B7692@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <80a05f4a-eaae-4db1-9604-c5eed9ff594c@ideasonboard.com>
 <20231108114848.794045-1-khtsai@google.com>
 <d040f84a-b55e-4b1d-85c1-b6cec6554198@ideasonboard.com>
 <20231117014538.ro6bo2ho2jgl7l6s@synopsys.com>
 <20231117032832.6k4msq2vlp56asho@synopsys.com>
In-Reply-To: <20231117032832.6k4msq2vlp56asho@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CH3PR12MB9314:EE_
x-ms-office365-filtering-correlation-id: 37213192-0a10-437a-5463-08dc11bc92d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GNDe8lGZGTrqQdlqwkiF1QpX7qQMZTJoN2gI97GfHufmA8pIvy8mQpSXwmoEv0Eu3YUu6uPaFXVm6vqV+xWnldyryZisMwGNXCgqdLXOFQmrZwKVT91DmRuj0/HxnN9VdeG6TbTLxx2r/Y3JCr96kVhDwmpT+ztUcEAPezvrU8URsY9JvxPjZWTOL96xsoazQFj7LWkM6czggqm3BKy5eiYi/Gx/9ObuZIA044Y24Y6Tnxw9ioywlnBb+eRVTOUO24P5u682sVA01mM0eaa7hRvUOBOfKeTxuyn/E9gWF0hH99rG0nXZo72Syb07R1sr8uIyrjiM80sSuppWr3gqQ+v8R0ycHeP0UBV4Zw0IsVeoZcjTTc/ZpV5DaHT09BZgiKFXDVnVA/F5/1VDIdDngVrh1T1199Iuf1TqZ5JG7Xvt6Tbd8dZdcRsr1vJNaivdG0rJlpDqURrFcP9DpulvaBRADKKaOJecQzLDq+0Q9aohLZ3jYEmqbVzh+ABMZTkrPsZpoEg73xHFagTfrTAJtR9+id3fcUdAthkYDCj84wARX/xuLFMuH0P9XYmoP2kGEo/svR9nawpn3EkYCHin45rrt3RlIh12/yssZXFflOTmqYjTC4D0IOgG8KdDzukx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(5660300002)(2906002)(38070700009)(86362001)(41300700001)(122000001)(316002)(54906003)(110136005)(8676002)(8936002)(9686003)(55016003)(66556008)(76116006)(66946007)(66446008)(64756008)(26005)(66476007)(478600001)(83380400001)(7696005)(53546011)(6506007)(33656002)(52536014)(4326008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V05oNXlnc0d4K1IvYnI3NlhHSzNvVkQ4TWJCdkVDWUlTNi9rb09WTVR0Vkg5?=
 =?utf-8?B?T2pIa0IxY0wxYzdQeW1aUUI4YzJ3ZER6R0FoSWhaSHNCdXhqZVptUTExKzcw?=
 =?utf-8?B?YThLSEgzQUMvSUNXMHNMQUZMYTBVY2orTnhRR01VUmt0SEplaW9YSWlLL0NT?=
 =?utf-8?B?cml3YXJxWVZWM08wMnllemJnSytWeFNwQnNZNU9RUk1hcVRuSHA1ZnVFTnVw?=
 =?utf-8?B?RWpKSG5qRFdGVFNleTRVRFpyOGh1V2E1NXFVV0wrNDgyVEVNTDBSdVI2aGRR?=
 =?utf-8?B?cDh5ZFlONUc2OGtvbDVvRWh4OGM1bm9aWVlMRWVsVnF3M3ByMUdnNE5qVTRn?=
 =?utf-8?B?c2ZjbTFXelBYS2pkL1hiaU1ya01KT3JlbVRRWW9obVJ3MFF1d0RKcGQrTGtW?=
 =?utf-8?B?VDRaM1RMcWROZzYzVkt2UjRRUnlKTTRURFp3RUdMWkJybGhDQ3Z3cUJVTEUy?=
 =?utf-8?B?aVEwS0NkVk8yQzdqUE5BM2F0aEhzRmJZbmZ4cVFtNkRHWkpOc1Nud25Pc2ov?=
 =?utf-8?B?K0o0TWExb3djWGNmUlFQZXZRN0FRSjNSNng0aWZhNTVHMUhKM1BPMVQrQmtT?=
 =?utf-8?B?MkgxZElSUzhUOHdiM1Z2MS9rVUI5aGgzU29wdy9xYmdBenVRQVYyV0k2VlJp?=
 =?utf-8?B?bXJNVkFzUnhYTkpyWjJ4ZFZhdjJOTkRYQTZ3V1ZQZGt6dVFlS0Y4bjFLMU0y?=
 =?utf-8?B?eG9pNldaSTdVYVVuQ256cUkraG9MVENOL2p3aERWMFBqclA5K1M5MzJTZmo4?=
 =?utf-8?B?bHU3R1Z4SmNHUVZSUytyOXNZR1FHQWpSemtuSjlRRDR0UHk1anRqZ0xUc1E0?=
 =?utf-8?B?dG1va0VPeUJVOFhSdi8zZFM2dmNtQUowVzkya3BjQ1VZYjByMGkyY0twYkdD?=
 =?utf-8?B?OStFd1NGeUxEbDROT0FVanBhYzl4RW9RdEx4Mm9KR29WUTFLRUV3dkJrSTlE?=
 =?utf-8?B?QjBHeGtoZkJEUEwzeGxyUHFIa1VHc2NhdzBHd1pJNTI1MnJSUURrRDA5OEVD?=
 =?utf-8?B?eS9wK0FJdnJFdkUyTCtNZldLL2NSY2JKRzZkeTJQNmNHQ0RJQ2hvSEVzd2F4?=
 =?utf-8?B?b0JScUxuWG1YMGVHeFpKSlJ0N2s2bVhIQzFyU0tpRmI5cTdOdkNSc0tNdk1i?=
 =?utf-8?B?UjZYakczN1VqZU9NWTdwN2RUSlgwY0ttVzE0Y2c0QzFBbW5la0tLTTNQZGFM?=
 =?utf-8?B?ZnpPVGs2MGFvUFYyZkhKZkw3QkYrd0p1YkRmSU04bFhYNjZNMFM4a0drd3FT?=
 =?utf-8?B?cWtRV2lZTFY4V2FTUXU0WUV4R3JnbTlmMWllMjArcDJONCtBS1V1ZzdjNWxo?=
 =?utf-8?B?c1Y5WGdwN3ZRRTFlVmRyQWUzV1pqcWJtR3NUVng1cjlqOVBUaDlNbVF3UXZr?=
 =?utf-8?B?eG82SUthWnZMVmVoTUxCMy9sTnhnWFl2OTl2ZFNUakpSZFUyRjR6bit0S0xh?=
 =?utf-8?B?NFpER3hxTkhjNDhHQ05ZbmkyYVVCQjJJZEI5dnIvMkk1SkhETFArLzY0M0Fm?=
 =?utf-8?B?Z2U3SGl6c0JsNU5ZMDBRWjJ5SDVLUUU2ek1kcTFsUjlOeDZqZnY0cDBpMDZo?=
 =?utf-8?B?T0dVUXZGby9EZ0NySWR4cUpuTWFqSUE0WlVRN3ljelpmVmt0MjZ4MjhLTmhD?=
 =?utf-8?B?bCt0bjNPdnpiL2t2YVN1UGNjMGIwUG5iK1pXSUJzR2F3cHowZDVmUEZ2YnpJ?=
 =?utf-8?B?N0pTcU9reEU3VVVPUlFrOGRwN3FVRkJENlZTUEhwejI0d3IwU1VzcmZSSC95?=
 =?utf-8?B?bjdlTEhQajVVcGlsMVIvWEtVWE45czhkSTZENWYrR2s2eXcwcVRtNmVNKzFP?=
 =?utf-8?B?YUlUTkdzVVdCRnBqZEdHekdhRmhMejJmVnF0dGxrUms3U2ppWTBBdzBBd0RV?=
 =?utf-8?B?R3lNUHU0QnIvWTZIOVVLaGt4ckhuaGdKa3FRZDdPbjZaUU16NytqNUVLTFFx?=
 =?utf-8?B?cFhlR1pJekVOSi9jQTRScTJON1Z1dWFJQk5scTVRb0NwbUtsQ3lwS3NGcVg4?=
 =?utf-8?B?dXpueVErV3hGYjRnWjNJMitTdE9jdHJtUVJNMncvZXF0WkMyYWFSWEpDR1Vk?=
 =?utf-8?B?Tm41NDJlckZCTVVWZVlsUm1ibG4yeTVURS9mZUJBM005cSt4ME9UV0svTEVX?=
 =?utf-8?Q?Wtus=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37213192-0a10-437a-5463-08dc11bc92d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 09:14:39.3896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGyXYrcqvjiULvW5dlVRC8AIMPrETPBodJYZxnDIP2oosP9lTejzi7k63qFKDCF3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTcsIDIwMjMg
ODo1OSBBTQ0KPiBUbzogRGFuIFNjYWxseSA8ZGFuLnNjYWxseUBpZGVhc29uYm9hcmQuY29tPg0K
PiBDYzogS3Vlbi1IYW4gVHNhaSA8a2h0c2FpQGdvb2dsZS5jb20+OyBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZzsNCj4gbGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gdXNiQHZnZXIua2VybmVsLm9yZzsgU2lt
ZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBNZWh0YSwNCj4gUGl5dXNoIDxwaXl1
c2gubWVodGFAYW1kLmNvbT47IFBhbmRleSwgUmFkaGV5IFNoeWFtDQo+IDxyYWRoZXkuc2h5YW0u
cGFuZGV5QGFtZC5jb20+OyBQYWxhZHVndSwgU2l2YSBEdXJnYSBQcmFzYWQNCj4gPHNpdmEuZHVy
Z2EucHJhc2FkLnBhbGFkdWd1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjog
Z2FkZ2V0OiB1dmNfdmlkZW86IHVubG9jayBiZWZvcmUgc3VibWl0dGluZyBhDQo+IHJlcXVlc3Qg
dG8gZXANCj4gDQo+IE9uIEZyaSwgTm92IDE3LCAyMDIzLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gSGksDQo+ID4NCj4gPiBPbiBUaHUsIE5vdiAxNiwgMjAyMywgRGFuIFNjYWxseSB3cm90ZToN
Cj4gPiA+IENDIFRoaW5oIC0gc29ycnkgdG8gYm90aGVyIHlvdSwganVzdCB3YW50IHRvIG1ha2Ug
c3VyZSB3ZSBmaXggdGhpcyBpbiB0aGUNCj4gcmlnaHQgcGxhY2UuDQo+ID4gPg0KPiA+ID4gT24g
MDgvMTEvMjAyMyAxMTo0OCwgS3Vlbi1IYW4gVHNhaSB3cm90ZToNCj4gPiA+ID4gT24gMDIvMTEv
MjAyMyAwNzoxMSwgUGl5dXNoIE1laHRhIHdyb3RlOg0KPiA+ID4gPiA+IFRoZXJlIGNvdWxkIGJl
IGNoYW5jZXMgd2hlcmUgdGhlIHVzYl9lcF9xdWV1ZSgpIGNvdWxkIGZhaWwgYW5kDQo+ID4gPiA+
ID4gdHJpZ2dlcg0KPiA+ID4gPiA+IGNvbXBsZXRlKCkgaGFuZGxlciB3aXRoIGVycm9yIHN0YXR1
cy4gSW4gdGhpcyBjYXNlLCBpZg0KPiA+ID4gPiA+IHVzYl9lcF9xdWV1ZSgpIGlzIGNhbGxlZCB3
aXRoIGxvY2sgaGVsZCBhbmQgdGhlIHRyaWdnZXJlZA0KPiA+ID4gPiA+IGNvbXBsZXRlKCkgaGFu
ZGxlciBpcyB3YWl0aW5nIGZvciB0aGUgc2FtZSBsb2NrIHRvIGJlIGNsZWFyZWQNCj4gPiA+ID4g
PiBjb3VsZCByZXN1bHQgaW4gYSBkZWFkbG9jayBzaXR1YXRpb24gYW5kIGNvdWxkIHJlc3VsdCBp
biBzeXN0ZW0NCj4gPiA+ID4gPiBoYW5nLiBUbyBhdmlvZCB0aGlzIHNjZW5lcmlvLCBjYWxsIHVz
Yl9lcF9xdWV1ZSgpIHdpdGggbG9jayByZW1vdmVkLg0KPiBUaGlzIHBhdGNoIGRvZXMgdGhlIHNh
bWUuDQo+ID4gPiA+IEkgd291bGQgbGlrZSB0byBwcm92aWRlIG1vcmUgYmFja2dyb3VuZCBpbmZv
cm1hdGlvbiBvbiB0aGlzIHByb2JsZW0uDQo+ID4gPiA+DQo+ID4gPiA+IFdlIG1ldCBhIGRlYWRs
b2NrIGlzc3VlIG9uIEFuZHJvaWQgZGV2aWNlcyBhbmQgdGhlIGZvbGxvd2luZ3MgYXJlDQo+IHN0
YWNrIHRyYWNlcy4NCj4gPiA+ID4NCj4gPiA+ID4gWzM1ODQ1Ljk3ODQzNV1bVDE4MDIxXSBDb3Jl
IC0gRGVidWdnaW5nIEluZm9ybWF0aW9uIGZvciBIYXJkbG9ja3VwDQo+ID4gPiA+IGNvcmUoOCkg
LSBsb2NrZWQgQ1BVcyBtYXNrICgweDEwMCkgWzM1ODQ1Ljk3ODQ0Ml1bVDE4MDIxXSBDYWxsIHRy
YWNlOg0KPiA+ID4gPiBbKl1bVDE4MDIxXSAgcXVldWVkX3NwaW5fbG9ja19zbG93cGF0aCsweDg0
LzB4Mzg4DQo+ID4gPiA+IFszNTg0NS45Nzg0NTFdW1QxODAyMV0gIHV2Y192aWRlb19jb21wbGV0
ZSsweDE4MC8weDI0Yw0KPiA+ID4gPiBbMzU4NDUuOTc4NDU4XVtUMTgwMjFdICB1c2JfZ2FkZ2V0
X2dpdmViYWNrX3JlcXVlc3QrMHgzOC8weDE0Yw0KPiA+ID4gPiBbMzU4NDUuOTc4NDY0XVtUMTgw
MjFdICBkd2MzX2dhZGdldF9naXZlYmFjaysweGU0LzB4MjE4DQo+ID4gPiA+IFszNTg0NS45Nzg0
NjldW1QxODAyMV0NCj4gPiA+ID4gZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jYW5jZWxsZWRfcmVx
dWVzdHMrMHhjOC8weDEwOA0KPiA+ID4gPiBbMzU4NDUuOTc4NDc0XVtUMTgwMjFdICBfX2R3YzNf
Z2FkZ2V0X2tpY2tfdHJhbnNmZXIrMHgzNGMvMHgzNjgNCj4gPiA+ID4gWzM1ODQ1Ljk3ODQ3OV1b
VDE4MDIxXSAgX19kd2MzX2dhZGdldF9zdGFydF9pc29jKzB4MTNjLzB4M2I4DQo+ID4gPiA+IFsz
NTg0NS45Nzg0ODNdW1QxODAyMV0gIGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlKzB4MTUwLzB4MmYwDQo+
ID4gPiA+IFszNTg0NS45Nzg0ODhdW1QxODAyMV0gIHVzYl9lcF9xdWV1ZSsweDU4LzB4MTZjDQo+
ID4gPiA+IFszNTg0NS45Nzg0OTNdW1QxODAyMV0gIHV2Y2dfdmlkZW9fcHVtcCsweDIyYy8weDUx
OA0KPiA+ID4NCj4gPiA+DQo+ID4gPiBJIG5vdGUgaW4gdGhlIGtlcm5lbGRvYyBjb21tZW50IGZv
ciB1c2JfZXBfcXVldWUoKSB0aGF0IGNhbGxpbmcNCj4gPiA+IC5jb21wbGV0ZSgpIGZyb20gd2l0
aGluIGl0c2VsZiBpcyBzcGVjaWZpY2FsbHkgZGlzYWxsb3dlZCBbMV06DQo+ID4gPg0KPiA+ID4g
wqDCoMKgIE5vdGUgdGhhdCBAcmVxJ3MgLT5jb21wbGV0ZSgpIGNhbGxiYWNrIG11c3QgbmV2ZXIg
YmUgY2FsbGVkIGZyb20NCj4gPiA+DQo+ID4gPiDCoMKgwqAgd2l0aGluIHVzYl9lcF9xdWV1ZSgp
IGFzIHRoYXQgY2FuIGNyZWF0ZSBkZWFkbG9jayBzaXR1YXRpb25zLg0KPiA+ID4NCj4gPiA+DQo+
ID4gPiBBbmQgaXQgbG9va3MgbGlrZSB0aGF0J3Mgd2hhdCdzIGhhcHBlbmluZyBoZXJlIC0gaXMg
dGhpcyBzb21ldGhpbmcNCj4gPiA+IHRoYXQgbmVlZHMgYWRkcmVzc2luZyBpbiB0aGUgZHdjMyBk
cml2ZXI/DQo+ID4gPg0KPiA+DQo+ID4gTG9va3MgbGlrZSBpdC4gVGhlIGlzc3VlIGlzIGluIGR3
YzMuIEl0IHNob3VsZCBvbmx5IGFmZmVjdCBpc29jDQo+ID4gcmVxdWVzdCBxdWV1aW5nLg0KPiA+
DQo+ID4gQ2FuIHdlIHRyeSB3aXRoIHRoaXMgcGF0Y2g6DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
PiBpbmRleCA4NThmZTRjMjk5YjcuLjM3ZTA4ZWVkNDlkOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiA+IEBAIC0xNjg0LDEyICsxNjg0LDE1IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9r
aWNrX3RyYW5zZmVyKHN0cnVjdA0KPiBkd2MzX2VwICpkZXApDQo+ID4gIAkJCWR3YzNfZ2FkZ2V0
X21vdmVfY2FuY2VsbGVkX3JlcXVlc3QocmVxLA0KPiA+IERXQzNfUkVRVUVTVF9TVEFUVVNfREVR
VUVVRUQpOw0KPiA+DQo+ID4gIAkJLyogSWYgZXAgaXNuJ3Qgc3RhcnRlZCwgdGhlbiB0aGVyZSdz
IG5vIGVuZCB0cmFuc2ZlciBwZW5kaW5nICovDQo+ID4gLQkJaWYgKCEoZGVwLT5mbGFncyAmIERX
QzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcpKQ0KPiA+ICsJCWlmICghKGRlcC0+ZmxhZ3MgJiBE
V0MzX0VQX1BFTkRJTkdfUkVRVUVTVCkgJiYNCj4gPiArCQkgICAgIShkZXAtPmZsYWdzICYgRFdD
M19FUF9FTkRfVFJBTlNGRVJfUEVORElORykpDQo+ID4gIAkJCWR3YzNfZ2FkZ2V0X2VwX2NsZWFu
dXBfY2FuY2VsbGVkX3JlcXVlc3RzKGRlcCk7DQo+ID4NCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+
ICAJfQ0KPiA+DQo+ID4gKwlkZXAtPmZsYWdzICY9IH5EV0MzX0VQX1BFTkRJTkdfUkVRVUVTVDsN
Cj4gPiArDQo+ID4gIAlpZiAoZGVwLT5zdHJlYW1fY2FwYWJsZSAmJiByZXEtPnJlcXVlc3QuaXNf
bGFzdCAmJg0KPiA+ICAJICAgICFEV0MzX01TVF9DQVBBQkxFKCZkZXAtPmR3Yy0+aHdwYXJhbXMp
KQ0KPiA+ICAJCWRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9XQUlUX1RSQU5TRkVSX0NPTVBMRVRFOw0K
PiA+DQo+ID4gLS0tDQo+ID4NCj4gDQo+IEFjdHVhbGx5LCBwbGVhc2UgaWdub3JlIHRoZSBhYm92
ZSwgdGhhdCdzIG5vdCBjb3JyZWN0LiBJJ2xsIHNlbmQgb3V0IGEgcHJvcGVyDQo+IHBhdGNoIGxh
dGVyLg0KDQpUaGFua3MsIFRoaW5oLiBJIGNhbWUgYWNyb3NzIHRoaXMgdGhyZWFkIGFuZCB3YW50
ZWQgdG8gY2hlY2sgaWYgeW91IA0KaGF2ZSBzb21lIGZpeCByZWFkeT8NCg==

