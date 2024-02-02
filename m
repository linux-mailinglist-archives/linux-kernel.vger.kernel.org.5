Return-Path: <linux-kernel+bounces-49078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B053846599
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652E5B24754
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF3C8BE1;
	Fri,  2 Feb 2024 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="eDZJ9GLn"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2105.outbound.protection.outlook.com [40.107.128.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D988C1C;
	Fri,  2 Feb 2024 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838907; cv=fail; b=eqQ69yXe78ZDvFXbAdytzuU45toCAjte4JzNbPrIW4ugzeGQ3MoijZNcU/WrymN4kImWUg/74wi44HcKreLczXSgujzaVNKHpGQrB0S27Gn4jtOFn4aHUzuWxOa4XtMByRYw9Zi6YuX+KWpENLOGGO9+4D/xftEkj/gaqIz1ALg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838907; c=relaxed/simple;
	bh=dhmY++V6oxWSrPfjdh4R3PStNDkw1nmBXtnymWVJitc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t/ePX209NNA3ObxSXHaiP8wOY3sUQ/s/04Duw+PJA7IgLTpMCbhpxHqSNMvqatIP624BT8T9K/dF4kJtVeenq2NuRcDYecNAPxBylMFy+JN/OHm+Ko8Pruvy3fqlwxHtrtuXJherv3m2lJUYIbEo0xLn3eclgUWmK87CNsxUETk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=eDZJ9GLn; arc=fail smtp.client-ip=40.107.128.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WESK/OJGQsTlJVjvsD5NODSmB5jHHxixv5XnM1lUtfh8P6OpTGobxHM3Eb40qJhHj2drKsTgzlyOZdqyOTEr6vQoo4OmsFerurz50wkb7nw0yQcIgOXuFH+546vrYUcwfE19+VKgNi/G2sgGvG2PtjgKnMniTImDcWSlQfmK9vZKRR9fiBMWVOJL6Yyt0Gxzq6Dm6PgxW5C+muLTyi6+/MDEjv4GFSndPUsuSpXaCVPuo7nCWujo/8tWPBsZrDTeIYJe7u3TUZwz48xWHkcqd/s2RpvD1mNlCXryx71jKJi1rPjqtpfYnpQGpewomfbLF6JEfmyJs5TJ2NrK2PaV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhmY++V6oxWSrPfjdh4R3PStNDkw1nmBXtnymWVJitc=;
 b=NX44C8PuBpI6z4JJvG1nMcP7wo4GS6BzsOnkHIOXTAPtBuXaY2tgX3a6WvxFt3kKKqUlhV8WxG/EWzQv8IA0N/ZgpSfEdF9GiEYfM/qnGfdpGfEW/N497K8G0DEeooP1Fwie/JI4hK3NBkGZ1KenR+J4z6cC4gkhWB/4fyHM0zuxzE44s9UHrnSqom6LZFk1mbao1Vbe3OTywZuXUNN8M0L8t4XUxMsEu1fIZfwIc6dYHJim2cyR4YbrPa+Dj1DWrqx14F0R/cOBwsEEXWsKZimlfLN8ceFGUu+cL4MPHaRKZZy+2vbNc+xY6YkMTW6BGi7UnW02d+ZfGtxQocb1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhmY++V6oxWSrPfjdh4R3PStNDkw1nmBXtnymWVJitc=;
 b=eDZJ9GLnSYWPIbXZLtdehkT26tjguP3vKHi+IFMRft9jsMPS1UWnPARG2otj6v8VyRXHPNXHizXdNvsech6yBMSHx0v4uPUZZf2eupaYPr6Fm47RUCJrtjsH/JHS2FWicFBsFWob9XnG57qPEp5u8iyU5CPyUzZwNRe+nbqGMkI=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE2P216MB2540.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1c5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.30; Fri, 2 Feb 2024 01:55:01 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 01:55:01 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Andrew Davis <afd@ti.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nas Chung
	<nas.chung@chipsnmedia.com>
CC: lafley.kim <lafley.kim@chipsnmedia.com>, "b-brnich@ti.com"
	<b-brnich@ti.com>
Subject: RE: [RESEND PATCH v0 4/5] wave5: Use the bitstream buffer size from
 host.
Thread-Topic: [RESEND PATCH v0 4/5] wave5: Use the bitstream buffer size from
 host.
Thread-Index: AQHaU+UiBCN323q3Wk+wjU7xgb3u8LD0MFoAgAIdQvA=
Date: Fri, 2 Feb 2024 01:55:01 +0000
Message-ID:
 <SE1P216MB13037D1F9AFCAE15F4C01A83ED422@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
 <20240131013046.15687-5-jackson.lee@chipsnmedia.com>
 <7bc035db-607a-48db-b497-4bc29d0a805c@ti.com>
In-Reply-To: <7bc035db-607a-48db-b497-4bc29d0a805c@ti.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|SE2P216MB2540:EE_
x-ms-office365-filtering-correlation-id: 6377bc58-f6c6-44a5-7903-08dc2391f7f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lF2FOFZkJPEHW/oTBVTlvuWvgwVDeuNFdBBWNfKiCNXPfXmud8fyOrG2Oq0INQk+5YzDWd9q05Nq1KAu+v8TjQy6/zMYTPDq7TXbZ4LpiX30L6Eu5/a+XM9SOZwmPYmqHNa+8UDIzLUfVzjCpmJfn16d84J2kgb/hREDLdHxMtt1TWNJ5UVT2Yu0wKI8FH0EwedubGl3aFjiV4b26WnpPibMHox1qIzXdWBpp9FLefKBM/Nmbwny4Do+3Ly1iZKS3EvlQ3JWyyrN1WXnLfuygEFSbjlKnvxFw6aNtwczNgNZFTZCSifT6yvt/ER8WuNgjzAOmkqG08Imvf2XBhMhi3ZZk7rz7C+YN9JYPZHrVCn59OAPZdx6bowgnD3/Ko7AUtQvsQ8pVnFa9MX3iAxgRv5RX7Yn5yFabmithptG/+CDcAMxXcUoHEXg76kldThcDXZh2K6JnYjSqU13IHQTaokgxHfKtV5JC6KxNCMo50sfdJRFwxvXvNqB0n3dE+l2fmGbsv5GGvPL/KFI4+SPkD9Q/ydV+sxl7wMSwqqskt2Iw+mFKxnua0dv0Q20d04NxVS24dVCjtg+0hcotF4pZRZcPPGkZJfdOmtxdWp4c98R1lP51+j9RgPEPvLLm5TK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(396003)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(83380400001)(33656002)(41300700001)(86362001)(38070700009)(122000001)(9686003)(26005)(8676002)(38100700002)(66446008)(8936002)(478600001)(7696005)(6506007)(6636002)(52536014)(2906002)(316002)(66946007)(76116006)(110136005)(66556008)(66476007)(53546011)(64756008)(71200400001)(54906003)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0NaNi9vdnhmVTJCSzIyT290cmpjbVVvaTB0a2NTYzNEYlNNNERZTGVxbldn?=
 =?utf-8?B?cC9JN1JLNXhHQ0lHSE80WDVuRXRPK2o1MGxBTnY2MEFEN0psbkFySkl0STh6?=
 =?utf-8?B?Uk13Y2RueHNPbWVoY20xTHNYN2tTdUUxSXIyc3UrOWNNbXNZanJuMVNTOUZm?=
 =?utf-8?B?WHE3Q2ptVE03NFVrUEJMQUlJK2loMFdzZkVLTlFjc2dLeFY1Mm9IY2pHZEN1?=
 =?utf-8?B?TFVINFljSzhsUjJFb1o4VnBvdFZhUitFREhsWFBVeEhDRm1kVEVwUEtPdTFR?=
 =?utf-8?B?SVR2Mk9aeGVJT3VJQWs4R052MnRmTUF1ZGJjY1NQZ0hJTWlEZFpxQ0w5MS9o?=
 =?utf-8?B?ZWNCa1o5SXEyNDU1VVliQVRCK1U2dXhwOElKcGl3NDY3WmdRdUpYRkJwVjZo?=
 =?utf-8?B?WDd3NHFHMzY2OWF6WmxNK0FiMEZqa2JIL3lPeUpLRk9tYkFGSnNLQUxTci9X?=
 =?utf-8?B?c1h4eVhKMk85VlgxL2Y0KzZXekFSY1ZuUVdGMzZXUU45c1hndVdGUjgrZWI1?=
 =?utf-8?B?Q3dPaVo4elBSK2dFc1M1cmxyaEdxOU4yT29oWHVINFN2WEJ3V0xXMVgvU1pa?=
 =?utf-8?B?UEpqMVJUSStjWmlieFl5STQ0ZDhEN3hUY1dvTkYxOWQzckg3WTJNVUtIV1U4?=
 =?utf-8?B?bm9HMlRnSkpIQ0NTN3lIUUdtSzlHcUl3Z1BZakpsZkFBTVlEbWo0bno3RzVP?=
 =?utf-8?B?WVpQWVJXNFlnaDhULzE0Mk1RMnZIZW1lY01abCtqaTNGek91dDhSWi80MlEr?=
 =?utf-8?B?eFN6VEx4emxPZkp2U2ZTendVYzNlWTAva3hVWlM2UUVBTk8zclZnYUg1M0tU?=
 =?utf-8?B?Vm8yTVFpRFV6ejBBYXREK2N5Ni9HYWpXZ0diNFUveVdJVlEzakNYR09scTRB?=
 =?utf-8?B?bCs5dDE3eFdSTGpDZnZvS2c3RE56UVlHY01SRGtJY1AwaEJRMS9pb0hEaG1E?=
 =?utf-8?B?Um9HMWNBaVI2VytYODhwL2pPWS96M2VSUkw1T2E2RlpwNEhOc3FQa0M0YW9L?=
 =?utf-8?B?aVVOYktDWTU1K2ZROUhkT1ZHb3pFL2JXbWRGdW1XaE1BcFhleTNwVlV1SVJo?=
 =?utf-8?B?SFlGQjdwQTd0MnloVGpIMUkxcTRPTWxxc0xsWVc5RG1oSHRxdy9rK29MdHUz?=
 =?utf-8?B?NnNpUklEK0dNb3F4L0VBSjZjZlVudHlGdklCRldtcDNmZGkwMEJqWEtvTk9m?=
 =?utf-8?B?Ryt6aWVyYTU3REJFT3JqbTZsSjdVK1I4WU16N250L0tIYWg4dWlYNkxuOXdw?=
 =?utf-8?B?UTFzWTI2c3FGQ1pSUFJOWDBpdklEWmZtUVdUTWJab08wRkNYV0o2UVRHWlZu?=
 =?utf-8?B?bndkV3loSHNVcE9WQVdiRnFKS212anJQN2d3RzFnUFBMWFdhZVB0RUhiTTlV?=
 =?utf-8?B?dHZ3RU1uUFQ2WlpMUDFZMVJlNDZtc0RTS1FUM0t1TFJ1Q3RtdkI4eGJLd01Z?=
 =?utf-8?B?KzFUUmxjZVNIYTZUMENlWm9reE5WekRGcU1EbkRoYXNOU0x1WHVxQVd0WkNs?=
 =?utf-8?B?RGgvQlBaNWNFWTdRN1UxSWplVE53VEpxbFlKVXJzSHhTMTgxWEw4K1BPblZL?=
 =?utf-8?B?RDNIcnRtVWNEZllSTzBIZ3BFMGd6ZjMrdjRIdE5sK0VJTS9xSFUySW51K2E4?=
 =?utf-8?B?bm1hTUpCN1lxQUYyTWI0SWhEbFZkRStBRmJOVCt2bmdnWlgvUGI2dlBXZlVz?=
 =?utf-8?B?c01zRGZQNXhOTnZlelVxOVFPN2FpVzZ1bGhlVXlsM3JZTnhCMEVqTlRuTnRI?=
 =?utf-8?B?aDFpSVR0WXRXZ2U0WkR3YVBhZlFTSUwxY0cvelEzdHpoRlp0a3dNdy9jU3Z4?=
 =?utf-8?B?ZnhndjMvYm1EMU8wT0ZROGN3cnZRakRaSjNwR0l2TjdtblJzOXRIMmJYaURm?=
 =?utf-8?B?S1R0Z1BHYk1PWXoyZkx1MlhILy9ibEdKcVpubkpEOFJIbkdldkJUVE9xV1pT?=
 =?utf-8?B?bjgwYTZ5Q3RGWVZJbVBDb0VKSUhVN3RTcWJLVXNHdVVyUEE1bTdTK2plWDJn?=
 =?utf-8?B?T2dmVDJNdUFKaEg4dEcwdWREV2xvRmdpeEMyb1NoMEVYU214VVBROFBFZkJ3?=
 =?utf-8?B?SmJCS1ZKNk1ScE4xbnNTazc0ZjhXd3BZQ0c4VXR3bzVncHEyZXRSRDRUTklD?=
 =?utf-8?B?bHNvcWwrUmtGQ1pteFkwdEZ0RU5UUEdvY0xtM1V5dWk3VGV4aityQytoTjNO?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6377bc58-f6c6-44a5-7903-08dc2391f7f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 01:55:01.6967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vxMSFc0LuoKeuakHb9XwE9wmkovwl4JbNgEq/ECB9MKRokN28jmxmQHGUF01nUlLfOQNvU6FEulylt1Y04gE33bPYlKSkv4Mz86jJQ227c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB2540

SGVsbG8gQW5kcmV3DQoNCkkgd2lsbCB1cGRhdGUgaXQgdG8gb25lIGxpbmUgeW91IHN1Z2dlc3Rl
ZC4NCg0KVGhhbmtzLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFu
ZHJldyBEYXZpcyA8YWZkQHRpLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDEsIDIw
MjQgMjozNyBBTQ0KPiBUbzogamFja3Nvbi5sZWUgPGphY2tzb24ubGVlQGNoaXBzbm1lZGlhLmNv
bT47IG1jaGVoYWJAa2VybmVsLm9yZzsgbGludXgtDQo+IG1lZGlhQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTmFzIENodW5nDQo+IDxuYXMuY2h1bmdAY2hp
cHNubWVkaWEuY29tPg0KPiBDYzogbGFmbGV5LmtpbSA8bGFmbGV5LmtpbUBjaGlwc25tZWRpYS5j
b20+OyBiLWJybmljaEB0aS5jb20NCj4gU3ViamVjdDogUmU6IFtSRVNFTkQgUEFUQ0ggdjAgNC81
XSB3YXZlNTogVXNlIHRoZSBiaXRzdHJlYW0gYnVmZmVyIHNpemUNCj4gZnJvbSBob3N0Lg0KPiAN
Cj4gT24gMS8zMC8yNCA3OjMwIFBNLCBqYWNrc29uLmxlZSB3cm90ZToNCj4gPiBJbiBWNEwyIHNw
ZWMsIEhvc3QgY2FuIHNldCB0aGUgYml0c3RyZWFtIGJ1ZmZlciBzaXplLg0KPiA+IEFsbG93IHRo
ZSBsYXJnZXIgc2l6ZSBiZXR3ZWVuIGRlZmF1bHQgc2l6ZSBhbmQgaW5wdXQgc2l6ZS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEphY2tzb24gTGVlIDxqYWNrc29uLmxlZUBjaGlwc25tZWRpYS5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmFzIENodW5nIDxuYXMuY2h1bmdAY2hpcHNubWVkaWEu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93
YXZlNS93YXZlNS12cHUtZW5jLmMgfCA3ICsrKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdS1lbmMuYw0KPiBi
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2ZTUtdnB1LWVuYy5j
DQo+ID4gaW5kZXggZmY3M2Q2OWRlNDFjLi4xOTAxOGFjZTQxYjYgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS12cHUtZW5jLmMN
Cj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1
LXZwdS1lbmMuYw0KPiA+IEBAIC0xMSw2ICsxMSwxMCBAQA0KPiA+ICAgI2RlZmluZSBWUFVfRU5D
X0RFVl9OQU1FICJDJk0gV2F2ZTUgVlBVIGVuY29kZXIiDQo+ID4gICAjZGVmaW5lIFZQVV9FTkNf
RFJWX05BTUUgIndhdmU1LWVuYyINCj4gPg0KPiA+ICsjZGVmaW5lIERFRkFVTFRfU1JDX1NJWkUo
d2lkdGgsIGhlaWdodCkgKHsJCQlcDQo+ID4gKwkod2lkdGgpICogKGhlaWdodCkgLyA4ICogMzsJ
CQkJCVwNCj4gDQo+IFRoZXNlICJcIiBhcmUgdGFiYmVkIG91dCB3YXkgdG8gZmFyLCBhbmQgbm90
IHRvIHRoZSBzYW1lIGFtb3VudC4uDQo+IFdoeSBoYXZlIHRoaXMgaW4gezt9IGJyYWNrZXRzPw0K
PiBXaHkgbXVsdGlwbGUgbGluZXM/DQo+IEp1c3Q6DQo+IA0KPiAjZGVmaW5lIERFRkFVTFRfU1JD
X1NJWkUod2lkdGgsIGhlaWdodCkgKCh3aWR0aCkgKiAoaGVpZ2h0KSAvIDggKiAzKQ0KPiANCj4g
QW5kcmV3DQo+IA0KPiA+ICt9KQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdnB1
X2Zvcm1hdCBlbmNfZm10X2xpc3RbRk1UX1RZUEVTXVtNQVhfRk1UU10gPSB7DQo+ID4gICAJW1ZQ
VV9GTVRfVFlQRV9DT0RFQ10gPSB7DQo+ID4gICAJCXsNCj4gPiBAQCAtMTkzLDcgKzE5Nyw4IEBA
IHN0YXRpYyB2b2lkIHdhdmU1X3VwZGF0ZV9waXhfZm10KHN0cnVjdA0KPiB2NGwyX3BpeF9mb3Jt
YXRfbXBsYW5lICpwaXhfbXAsIHVuc2lnbmVkDQo+ID4gICAJCXBpeF9tcC0+d2lkdGggPSB3aWR0
aDsNCj4gPiAgIAkJcGl4X21wLT5oZWlnaHQgPSBoZWlnaHQ7DQo+ID4gICAJCXBpeF9tcC0+cGxh
bmVfZm10WzBdLmJ5dGVzcGVybGluZSA9IDA7DQo+ID4gLQkJcGl4X21wLT5wbGFuZV9mbXRbMF0u
c2l6ZWltYWdlID0gd2lkdGggKiBoZWlnaHQgLyA4ICogMzsNCj4gPiArCQlwaXhfbXAtPnBsYW5l
X2ZtdFswXS5zaXplaW1hZ2UgPSBtYXgoREVGQVVMVF9TUkNfU0laRSh3aWR0aCwNCj4gaGVpZ2h0
KSwNCj4gPiArCQkJCQkJICAgICBwaXhfbXAtDQo+ID5wbGFuZV9mbXRbMF0uc2l6ZWltYWdlKTsN
Cj4gPiAgIAkJYnJlYWs7DQo+ID4gICAJfQ0KPiA+ICAgfQ0K

