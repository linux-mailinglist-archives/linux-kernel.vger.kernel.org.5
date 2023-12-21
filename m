Return-Path: <linux-kernel+bounces-7905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA681AEF3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFB71F21643
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA40BE62;
	Thu, 21 Dec 2023 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vrO0+8xp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2F11719;
	Thu, 21 Dec 2023 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B75hqmOHyfW+jezpRK/QjA55ccAHqTZhp//UBqKQ7XQqRNSpr9ueyQV+rg9rQnamm7GelUvG+yA3Nwab3CL5XOGyOkFmWQUFhCPmG9z2m8hLS/o85OvJLvNG12YNVhhkAbuX0Tx2wKjPRTLpDCbCxp8coqqoNyzUAvK4WxEW0bGul6GvQ8W4o+NSY6ASHGvd3ZoYSBJ5Rt1tLsoP/Id+OPL1/0SysHxTitd6IpwrPIBWsgJD5LVzsxuVxxXGmKk2oUJoRn5dfup0Hhb3ZejhPnvN/824fjWHjP3uDb8SXP36N/c2a3qFCtKAVtWxLSzckKzBQUm3lsPyShOy/wIZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoaHEXw7g/wem4PuUHfB8p3nDu7+oAkdcF/+XFOTUbU=;
 b=ene0QntwWQ+qIxasHuPz8i4iLinHqqvVb2QITeBqKmPBnk22vE1LuAmKZqk05/W7HRQun9Jg8dcI8zqHCCnbbJLwxOMRB0b5yVkwTySZQZxAw2eNYNl1XRM2Xcc4q111zI2uJYRAEWqzYrgo+7dgZsdpCrYgJai9xHCFdlFcxgGUkeEJaYIfFgeKCK9gXRRXtCZg/UWyeigUN2040GzYvQqo2YmCdMQ/1fZCpFHpnNHsgwFYLQ2Vv3riwPzAHD+S1nNh/i04WSHDVPGpu3F8Ink2HDeJyGzz0SmIa4jW+xV5RictaJQsJOT89ylwoOF8yowqCWG9W254cTgElz8LJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoaHEXw7g/wem4PuUHfB8p3nDu7+oAkdcF/+XFOTUbU=;
 b=vrO0+8xpSXQhramAcBVGnCwyuXKS5+I3ReeSz+NMefvXPwGgTUgn39mZQWxgRmeL9+zsmjd7npXYPfJgrmWwNqY+nvNGm3r4AT11tGKEXNKEePeMtcfdd+7feZdu6tiGEl0zFPV3ecHP5pkWrPUcMvGbt6/8h4hRrWcDvlb2kVs=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 06:54:22 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 06:54:22 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "pratyush@kernel.org" <pratyush@kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"lee@kernel.org" <lee@kernel.org>, "james.schulman@cirrus.com"
	<james.schulman@cirrus.com>, "david.rhodes@cirrus.com"
	<david.rhodes@cirrus.com>, "rf@opensource.cirrus.com"
	<rf@opensource.cirrus.com>, "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael@walle.cc" <michael@walle.cc>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "nicolas.ferre@microchip.com"
	<nicolas.ferre@microchip.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Topic: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Index:
 AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAIABtmWAgAQ4ECCAAAuVAIAAD5dQgAAYdQCAAAF/8IAGJHEAgAFe7KA=
Date: Thu, 21 Dec 2023 06:54:22 +0000
Message-ID:
 <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
 <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
 <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
In-Reply-To: <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|SJ1PR12MB6148:EE_
x-ms-office365-filtering-correlation-id: 2af5c642-be5e-42bc-6cbc-08dc01f1a9bd
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u0qaZAV5h0xRHSxrSBxbtnRlr5oMJA6pqqsUTGDtnwRRMPT0U6vmgWnb8dL3JWH0b6MFHuy9ScoWhl5ZPiTiK5VNSHmkporN/q4CISI7LsHT1p1vPB3ZaPWFzfJHmBnQH9/5msMvYur/sQfAzeJVVxbFtBfWYJJxAdQlg2cwpABQrTzbs8/d7hZimr0Z5dfZS+tZz+ib+JpU0U+yfZz4Z0wd45EmsXtDwUskIuzaWCHwt8T/FBwU6n4ULQgA++RJeG33NK+yzb42RPJm3fNIFnR6JVAZwO9uJcwwF1330YdIKXwv8EPqxA29BwbOedCvapsgGlH+8d1jpizJFhz6PxrFYLvl7kZScWLlzcna1Gs8GpK496ml8GM19mvqtyTMc7LdXqAMmRa08N27wrt6tu/psKcXuYBixIuxAeImJXEfm94C0XaGqhWzTUemaiKvoTqoteFRjAIBmUh8tTVR47Isb2mYsvld7XYIhRVvMi2J40oV535WiRF2i4P7l59iirHafX5VpvJfiXNVpG2X4vyWMNBOP5UULt0p6xCNbojaLSoCMBUK7E2RHHDa8FKLjuhfZmRBU+kUy/KZiP51ipTmr6nn+kZPgBumCcRWOhKLZudqf4211Mv/e+Gcts+J
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(122000001)(86362001)(38100700002)(41300700001)(52536014)(4326008)(9686003)(6506007)(53546011)(8676002)(8936002)(7416002)(5660300002)(26005)(33656002)(478600001)(966005)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(54906003)(110136005)(55016003)(71200400001)(7696005)(38070700009)(2906002)(921008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDdublpzZXF1WWlFaFB5dWZZM0NETjJxeVZETG01TCt1ZEZ0K0ZlTkNtUzha?=
 =?utf-8?B?NUNyd1NSK29DVzBrNUNmb01nZXF2eFJVYlkwME44bUlZUjRBaHkycjUrbHRM?=
 =?utf-8?B?eCswMFBUUUh5YVFhcmxDWXliVFp4em1lbE5lK0hMNzZBNmdhWU01WHhoVXRZ?=
 =?utf-8?B?Z1FlWXFTd2x4Z0d2OHJTaUJFSy90Y3ZvazBoUWpFOVhmclVCSmZITVh5VW5s?=
 =?utf-8?B?ekJvZzdaeXo0NThwS09OUy91Yks5aFVET0dBTkVRSnRiejh1NFpINGhKdmdK?=
 =?utf-8?B?bnNEVFNqc2pNZzJBTlFGZTMvUm9YUzhaSHBYQXJhMzNVY0YrSlZ3T01YNmh2?=
 =?utf-8?B?NHhGU3hsd0RlUjdSS3hNTE5jbEl1dklRMlBabDR1eFYxYkhGenU0MjlCcmhi?=
 =?utf-8?B?NUptSWlLRjlMN2xYWEtxdENiK1dvSExVZVFDUjFCS0RpSWtXQXQwWWRtUU9G?=
 =?utf-8?B?N2ZUN0JDcHBNY0xuTnFyK3pPSEtEUThrcEE1MTVGNWlwbmUvSDc5cHFEZWI2?=
 =?utf-8?B?WEtOcm9odi9NUUI3Y2VZdmFpKzl2VmhaSVdXRkE5eC9vZWczaHdFVmdpckRq?=
 =?utf-8?B?VHRYSUlvaHkvczdzNHBMVDRLYlFMWnpnckNueVNpck40OG9ST2w4UFc0ZXhY?=
 =?utf-8?B?cEd6Q1pES2lSL20rVTRETkkweVpCSUhIMVVqa2FPRjZjVmh2Wk1sT2NpQ3Nr?=
 =?utf-8?B?dzlTZzFXcXEvTjcyeklpSmRobXF3LzgvVTZiQVpvdTVnMjk2VEc5dUhOR1J0?=
 =?utf-8?B?UkRtLzZGMnBGWVFBN29GY09OQTVJeG5KVVZ5VldwR0NEc2w5VGE2T3ZWS0NC?=
 =?utf-8?B?WUxoMUhqbG9DSGFsdUFQTzRXckN4V1dYQlo1YkY5N2w0Q0dKQW1GNU5LTGZU?=
 =?utf-8?B?K2x3U2l1VXNzZnovWnRRRGNJN1NiWGk5M3BJZEUrL3BWckI2UWpiUUNUaG9y?=
 =?utf-8?B?aDVqdzhmT1hqWkZpZTdjeFlXMEFwaEtqb3p0aml0aDVKOGxQeHN5QWdQWFgy?=
 =?utf-8?B?OVkxbElyNnduR05TUllvODdLcGYrbXRkQzJ0S2pwZ0Ezc3J6KzZwRWZiRHpj?=
 =?utf-8?B?dWE3QzBqV3ppS1Rzd1lBU3FuQzBPNGVLUlRkUHlKSm80R0l3Y1h5UXpwUWJW?=
 =?utf-8?B?T0ExL2l0ZnRZQWxkRXAzQ3BaQjZqNGVIQS9hTHZ6NytxQjQxbVZJL2NGeHBB?=
 =?utf-8?B?VkpzWDBVTktYT1BnRy9jdlV0TElWbUtoSWtKNnVmVnJtUTU5eGNLZ0ZxUWNM?=
 =?utf-8?B?ajVSYlp6NDRNRFB1RDhPWjVLT0Y0UDVtcjhwNzJPSzhUQ2Q5dVdFZGRuSWpY?=
 =?utf-8?B?NkhBMWt0TzJCRUdZdmFnQUMwVDYzbEtibCtwM2UwcCtseUZvVUlRZm9WSGlL?=
 =?utf-8?B?OHA0K0hTdkFHZnh1SUZ6ZC9PQVI0N0VGS24wNzVuaWE5U1VRWmtrSTg5d0pa?=
 =?utf-8?B?VzB0Y1FiZjBLTUtnVVNFWDZkSk1SSWdFTkw0LzE4OEpaOStxdnZaNkJjbStQ?=
 =?utf-8?B?bHNXUnczajJZaVNRU0V5QXBUSlNWQThneDlrR2dmQkZVWmNrZStHVXY0L01t?=
 =?utf-8?B?Y0ZYVFFLM2JscitGdG1JMDFTRHVpQWxMcU9MN2w2dDd0WlV0REFUaGx2OXA4?=
 =?utf-8?B?akovbmxZWWpoVG1WWTJVbGFxYnpJcTYzQmozWlAxeldKVkJaZndNUko4TUNt?=
 =?utf-8?B?ckNzRjhEOW9UcTV0Vm5IT1U3amN0eWJpRVBDQ3ZHSUFTbjZKdVJYMWY3R1hp?=
 =?utf-8?B?dzRPNzBDYTJ1UmdXWlJ6RTRpT1lnTFJmSHcrSzk0VGdwSDhzaHpKN2ZMbW1C?=
 =?utf-8?B?T01vV3N3aWNzK2k5aUMzQ3JUY3lxRDVpT1hFb1J6RFVnSTdQYTdZbjBCbUdK?=
 =?utf-8?B?TkJhREY5TEdMK2xNSEtacHl1V2pmbnFXQXRXWTA5MTBaVHZpSGk4UUFyTGlT?=
 =?utf-8?B?bGtVUWJBb0s2RVZmMWVsQkdtWDNZQnFiMllMTUMxcnFQdlBqOEpzQnZCUFBt?=
 =?utf-8?B?SzR6cDZFcXdTNjRDcGlLQk9BOEZ1NnVsNktLenhIak5uTUJHSVl4ak8zSmxm?=
 =?utf-8?B?V0pTTkRTaUxDczQzVXJKYmgyemhzYTJTSXluUHJraWJuaUliMTlrUklOQVUr?=
 =?utf-8?Q?3J6E=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af5c642-be5e-42bc-6cbc-08dc01f1a9bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 06:54:22.6065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6wOg3yv922iwQvSQxdiUM22riDLqdMz9F1eo02rFXq8x7/FiM7uZy30kBISfD1yK8ke+BaiXxfl46IuzAqZ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148

SGVsbG8gVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBE
ZWNlbWJlciAxOSwgMjAyMyAxOjU2IFBNDQo+IFRvOiBNYWhhcGF0cmEsIEFtaXQgS3VtYXIgPGFt
aXQua3VtYXItbWFoYXBhdHJhQGFtZC5jb20+Ow0KPiBicm9vbmllQGtlcm5lbC5vcmc7IHByYXR5
dXNoQGtlcm5lbC5vcmc7IG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb207DQo+IHJpY2hhcmRAbm9k
LmF0OyB2aWduZXNockB0aS5jb207IHNiaW5kaW5nQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsNCj4g
bGVlQGtlcm5lbC5vcmc7IGphbWVzLnNjaHVsbWFuQGNpcnJ1cy5jb207IGRhdmlkLnJob2Rlc0Bj
aXJydXMuY29tOw0KPiByZkBvcGVuc291cmNlLmNpcnJ1cy5jb207IHBlcmV4QHBlcmV4LmN6OyB0
aXdhaUBzdXNlLmNvbQ0KPiBDYzogbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbWljaGFlbEB3YWxsZS5jYzsgbGludXgtbXRkQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+IG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbTsgYWxleGFuZHJl
LmJlbGxvbmlAYm9vdGxpbi5jb207DQo+IGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldjsgU2ltZWss
IE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBsaW51eC0NCj4gYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7DQo+IHBhdGNoZXNA
b3BlbnNvdXJjZS5jaXJydXMuY29tOyBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAo
QU1ELQ0KPiBYaWxpbngpIDxnaXRAYW1kLmNvbT47IGFtaXRya2NpYW4yMDAyQGdtYWlsLmNvbQ0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMSAwNy8xMF0gbXRkOiBzcGktbm9yOiBBZGQgc3RhY2tl
ZCBtZW1vcmllcyBzdXBwb3J0DQo+IGluIHNwaS1ub3INCj4gDQo+IA0KPiANCj4gT24gMTUuMTIu
MjAyMyAxMzoyMCwgTWFoYXBhdHJhLCBBbWl0IEt1bWFyIHdyb3RlOg0KPiA+IEhlbGxvIFR1ZG9y
LA0KPiA+DQo+IA0KPiBIaSENCj4gDQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZz4NCj4gPj4g
U2VudDogRnJpZGF5LCBEZWNlbWJlciAxNSwgMjAyMyA0OjAzIFBNDQo+ID4+IFRvOiBNYWhhcGF0
cmEsIEFtaXQgS3VtYXIgPGFtaXQua3VtYXItbWFoYXBhdHJhQGFtZC5jb20+Ow0KPiA+PiBicm9v
bmllQGtlcm5lbC5vcmc7IHByYXR5dXNoQGtlcm5lbC5vcmc7IG1pcXVlbC5yYXluYWxAYm9vdGxp
bi5jb207DQo+ID4+IHJpY2hhcmRAbm9kLmF0OyB2aWduZXNockB0aS5jb207IHNiaW5kaW5nQG9w
ZW5zb3VyY2UuY2lycnVzLmNvbTsNCj4gPj4gbGVlQGtlcm5lbC5vcmc7IGphbWVzLnNjaHVsbWFu
QGNpcnJ1cy5jb207IGRhdmlkLnJob2Rlc0BjaXJydXMuY29tOw0KPiA+PiByZkBvcGVuc291cmNl
LmNpcnJ1cy5jb207IHBlcmV4QHBlcmV4LmN6OyB0aXdhaUBzdXNlLmNvbQ0KPiA+PiBDYzogbGlu
dXgtc3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
Pj4gbWljaGFlbEB3YWxsZS5jYzsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+
IG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbTsgYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5j
b207DQo+ID4+IGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldjsgU2ltZWssIE1pY2hhbCA8bWljaGFs
LnNpbWVrQGFtZC5jb20+Ow0KPiA+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGFsc2EtIGRldmVsQGFsc2EtcHJvamVjdC5vcmc7DQo+ID4+IHBhdGNoZXNAb3BlbnNvdXJj
ZS5jaXJydXMuY29tOyBsaW51eC0gc291bmRAdmdlci5rZXJuZWwub3JnOyBnaXQNCj4gPj4gKEFN
RC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IGFtaXRya2NpYW4yMDAyQGdtYWlsLmNvbQ0KPiA+PiBT
dWJqZWN0OiBSZTogW1BBVENIIHYxMSAwNy8xMF0gbXRkOiBzcGktbm9yOiBBZGQgc3RhY2tlZCBt
ZW1vcmllcw0KPiA+PiBzdXBwb3J0IGluIHNwaS1ub3INCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4g
T24gMTIvMTUvMjMgMTA6MDIsIE1haGFwYXRyYSwgQW1pdCBLdW1hciB3cm90ZToNCj4gPj4+IEhl
bGxvIFR1ZG9yLA0KPiA+Pg0KPiA+PiBIaSwNCj4gPj4NCj4gPj4+DQo+ID4+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJh
cnVzQGxpbmFyby5vcmc+DQo+ID4+Pj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAxNSwgMjAyMyAx
OjQwIFBNDQo+ID4+Pj4gVG86IE1haGFwYXRyYSwgQW1pdCBLdW1hciA8YW1pdC5rdW1hci1tYWhh
cGF0cmFAYW1kLmNvbT47DQo+ID4+Pj4gYnJvb25pZUBrZXJuZWwub3JnOyBwcmF0eXVzaEBrZXJu
ZWwub3JnOyBtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOw0KPiA+Pj4+IHJpY2hhcmRAbm9kLmF0
OyB2aWduZXNockB0aS5jb207IHNiaW5kaW5nQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsNCj4gPj4+
PiBsZWVAa2VybmVsLm9yZzsgamFtZXMuc2NodWxtYW5AY2lycnVzLmNvbTsNCj4gZGF2aWQucmhv
ZGVzQGNpcnJ1cy5jb207DQo+ID4+Pj4gcmZAb3BlbnNvdXJjZS5jaXJydXMuY29tOyBwZXJleEBw
ZXJleC5jejsgdGl3YWlAc3VzZS5jb20NCj4gPj4+PiBDYzogbGludXgtc3BpQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4+PiBtaWNoYWVsQHdhbGxl
LmNjOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPj4+PiBuaWNvbGFzLmZlcnJl
QG1pY3JvY2hpcC5jb207IGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tOw0KPiA+Pj4+IGNs
YXVkaXUuYmV6bmVhQHR1eG9uLmRldjsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5j
b20+Ow0KPiA+Pj4+IGxpbnV4LSBhcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsNCj4gPj4+PiBwYXRjaGVzQG9wZW5zb3VyY2UuY2lycnVz
LmNvbTsgbGludXgtc291bmRAdmdlci5rZXJuZWwub3JnOyBnaXQNCj4gPj4+PiAoQU1ELQ0KPiA+
Pj4+IFhpbGlueCkgPGdpdEBhbWQuY29tPjsgYW1pdHJrY2lhbjIwMDJAZ21haWwuY29tDQo+ID4+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMDcvMTBdIG10ZDogc3BpLW5vcjogQWRkIHN0YWNr
ZWQgbWVtb3JpZXMNCj4gPj4+PiBzdXBwb3J0IGluIHNwaS1ub3INCj4gPj4+Pg0KPiA+Pj4+DQo+
ID4+Pj4NCj4gPj4+PiBPbiAxNS4xMi4yMDIzIDA5OjU1LCBNYWhhcGF0cmEsIEFtaXQgS3VtYXIg
d3JvdGU6DQo+ID4+Pj4+PiBUaGFua3MhIENhbiB5b3Ugc2hhcmUgd2l0aCB1cyB3aGF0IGZsYXNo
ZXMgeW91IHVzZWQgZm9yIHRlc3RpbmcNCj4gPj4+Pj4+IGluIHRoZSBzdGFja2VkIGFuZCBwYXJh
bGxlbCBjb25maWd1cmF0aW9ucz8NCj4gPj4+Pj4gSSB1c2VkIFNQSS1OT1IgUVNQSSBmbGFzaGVz
IGZvciB0ZXN0aW5nIHN0YWNrZWQgYW5kIHBhcmFsbGVsLg0KPiA+Pj4+DQo+ID4+Pj4gSSBnb3Qg
dGhhdCwgSSB3YW50ZWQgdGhlIGZsYXNoIG5hbWUgb3IgZGV2aWNlIElELg0KPiA+Pj4NCj4gPj4+
IE4yNVEwMEEsIE1YNjZVMkc0NUcsIElTMjVMUDAxRyAmIFcyNUgwMkpWIGFyZSBzb21lIG9mIHRo
ZSBRU1BJDQo+ID4+IGZsYXNoZXMNCj4gPj4+IG9uIHdoaWNoIHdlIHRlc3RlZC4gQWRkaXRpb25h
bGx5LCB3ZSBjb25kdWN0ZWQgdGVzdHMgb24gb3ZlciAzMA0KPiA+Pj4gZGlmZmVyZW50IFFTUEkg
Zmxhc2hlcyBmcm9tIGZvdXIgZGlzdGluY3QgdmVuZG9ycyAoTWlyb24sIFdpbmJvbmQsDQo+ID4+
IE1hY3Jvbml4LCBhbmQgSVNTSSkuDQo+ID4+Pg0KPiA+Pg0KPiA+PiBHcmVhdC4NCj4gPj4NCj4g
Pj4+PiBXaGF0IEknbSBpbnRlcmVzdGVkIGlzIGlmIGVhY2ggZmxhc2ggaXMgaW4gaXRzIG93biBw
YWNrYWdlLiBBcmUgdGhleT8NCj4gPj4+DQo+ID4+PiBJJ20gc29ycnksIGJ1dCBJIGRvbid0IHF1
aXRlIHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbiBieSAiaWYgZWFjaA0KPiA+Pj4gZmxhc2ggaW4g
aXRzIG93biBwYWNrYWdlLiINCj4gPj4+DQo+ID4+DQo+ID4+IFRoZXJlIGFyZSBmbGFzaGVzIHRo
YXQgYXJlIHN0YWNrZWQgYXQgdGhlIHBoeXNpY2FsIGxldmVsLiBJdCdzIGENCj4gPj4gc2luZ2xl
IGZsYXNoIHdpdGggbXVsdGlwbGUgZGllcywgdGhhdCBhcmUgYWxsIHVuZGVyIGEgc2luZ2xlIHBo
eXNpY2FsIHBhY2thZ2UuDQo+ID4NCj4gPiBHb3QgaXQuIFRoZSBXMjVIMDJKViBRU1BJIGZsYXNo
IEkgbWVudGlvbmVkIGVhcmxpZXIgaXMgYSBkZXZpY2Ugd2l0aA0KPiA+IHdpdGggZm91ciBkaWVz
IHRoYXQgYXJlIHN0YWNrZWQgYXQgdGhlIHBoeXNpY2FsIGxldmVsLg0KPiA+DQo+ID4+DQo+ID4+
IEFzIEkgdW5kZXJzdGFuZCwgeW91ciBzdGFja2VkIGZsYXNoIG1vZGVsIGlzIGF0IGxvZ2ljYWwg
bGV2ZWwuIFlvdQ0KPiA+PiBoYXZlDQo+ID4+IDIgZmxhc2hlcyBlYWNoIGluIGl0cyBvd24gcGFj
a2FnZS4gMiBkaWZmZXJlbnQgZW50aXRpZXMuIElzIG15DQo+ID4+IHVuZGVyc3RhbmRpbmcgY29y
cmVjdD8NCj4gPg0KPiA+IFllcywgdGhhdOKAmXMgY29ycmVjdC4NCj4gPg0KPiA+IEknZCBsaWtl
IHRvIGNvbnRyaWJ1dGUgdG8geW91ciBlYXJsaWVyIHBvaW50IHJlZ2FyZGluZyB0aGUgcGxhY2Vt
ZW50DQo+ID4gb2YgdGhlIHN0YWNrZWQgbGF5ZXIuIEFzIHlvdSBjb3JyZWN0bHkgaGlnaGxpZ2h0
ZWQsIGl0IHNob3VsZCBiZSBpbg0KPiA+IHRoZSBzcGktbWVtIGdlbmVyaWMgbGF5ZXIuIEZvciBp
bnN0YW5jZSwgd2hlbiBhIHJlYWQvd3JpdGUgb3BlcmF0aW9uDQo+ID4gZXh0ZW5kcyBhY3Jvc3Mg
bXVsdGlwbGUgZmxhc2hlcyAod2hldGhlciBTUEktTk9SIG9yIFNQSS1OQU5EKSwgdGhlDQo+ID4g
c3RhY2tlZCBsYXllciBtdXN0IGhhbmRsZSB0aGUgZmxhc2ggY3Jvc3NvdmVyLiBUaGlzIHJlcXVp
cmVzIHNldHRpbmcNCj4gPiB0aGUgYXBwcm9wcmlhdGUgQ1MgaW5kZXggaW4gbWVtLT5zcGktPmNz
X2luZGV4X21hc2sgdG8gc2VsZWN0IHRoZQ0KPiA+IGNvcnJlY3Qgc2xhdmUgZGV2aWNlIGFuZCB1
cGRhdGluZyB0aGUgZGF0YSBidWZmZXIsIGFkZHJlc3MgJiBkYXRhDQo+ID4gbGVuZ3RoIGluIHNw
aV9tZW1fb3Agc3RydWN0IHZhcmlhYmxlLiBEb2VzIHRoaXMgYWxpZ24gd2l0aCB5b3VyDQo+IHVu
ZGVyc3RhbmRpbmc/DQo+ID4NCj4gDQo+IFRoaXMgd2FzIHRoZSBpbml0aWFsIGlkZWEsIHllcywg
YnV0IHdlJ2xsIGhhdmUgdG8gc2VlIGhvdyBtdGQgY29uY2F0IGZpdHMgaW4uDQo+IE1heWJlIHRo
ZSBhYnN0cmFjdGlvbiBjYW4gYmUgbWFkZSBhdCB0aGUgbXRkIGxldmVsLCB3aGljaCBJIHN1c3Bl
Y3QgbXRkDQo+IGNvbmNhdCBkb2VzLiBJIGhhdmUgdG8gcmVhZCB0aGF0IGRyaXZlciwgbmV2ZXIg
b3BlbmVkIGl0Lg0KDQpJIGhhdmVuJ3QgZXhwbG9yZWQgdGhlIG10ZCBjb25jYXQgZHJpdmVyIGVp
dGhlci4NCg0KPiANCj4gU29tZXRoaW5nIGVsc2UgdG8gY29uc2lkZXI6IEkgc2VlIHRoYXQgTWlj
cm9uIGhhcyBhIHR3aW4gcXVhZCBtb2RlOg0KPiBodHRwczovL21lZGlhLXd3dy5taWNyb24uY29t
Ly0NCj4gL21lZGlhL2NsaWVudC9nbG9iYWwvZG9jdW1lbnRzL3Byb2R1Y3RzL2RhdGEtc2hlZXQv
bm9yLWZsYXNoL3NlcmlhbC0NCj4gbm9yL210MjV0L2dlbmVyYXRpb24tDQo+IGIvbXQyNXRfcWxq
c19sXzUxMl94YmFfMC5wZGY/cmV2PWRlNzBiNzcwYzVkYzRkYThiOGVhZDA2YjU3YzAzNTAwDQo+
IA0KPiBUaGUgbWljcm9uJ3MgIlNlcGFyYXRlIENoaXAtU2VsZWN0IGFuZCBDbG9jayBTaWduYWxz
IiByZXNlbWJsZXMgdGhlIEFNRCdzDQo+IGR1YWwgcGFyYWxsZWwgOC1iaXQuDQoNClllcywgSSBh
Z3JlZS4NCg0KPiBNaWNyb24ncyAiU2hhcmVkIENoaXAtU2VsZWN0IGFuZCBDbG9jayBTaWduYWxz
IiBkaWZmZXJzIGZyb20gdGhlIEFNRCdzDQo+IHN0YWNrZWQgbW9kZSwgYXMgTWljcm9uIHVzZXMg
RFFbMzowXSBhbmQgRFFbNzo0XSwgd2hlcmVhcyBBTUQgY29uc2lkZXJzDQo+IGJvdGggYXMgRFFb
MzowXS4NCg0KWWVzLCBjb3JyZWN0Lg0KDQo+IA0KPiBJIGhhZCBhIHNob3J0IGNoYXQgd2l0aCBN
aWNoYWVsIGFuZCBoZSBoaWdobGlnaHRlZCB0aGF0IGluc3RlYWQgb2YgdGhlIHBhcmFsbGVsDQo+
IG1vZGUsIG9uZSB3b3VsZCBiZSBiZXR0ZXIgb2Ygd2l0aCBhbiBvY3RhbCBkZXZpY2UuIEkgd29u
ZGVyIHdoZXRoZXIgdGhlDQo+IHF1YWQgcGFyYWxsZWwgaXMgd29ydGggdGhlIGVmZm9ydC4gSSBz
ZWUgQU1EIGNhbiBzZWxlY3QgZWl0aGVyIHF1YWQNCj4gKHNpbmdsZS9zdGFja2VkL3BhcmFsbGVs
KSBvciBvY3RhbCAoc2luZ2xlL3N0YWNrZWQpLiBJcyB0aGUgcGFyYWxsZWwgbW9kZQ0KIA0KSW5k
ZWVkLCBjdXN0b21lcnMgaGF2ZSB0aGUgZmxleGliaWxpdHkgdG8gY2hvb3NlIGJldHdlZW4gcXVh
ZCBvciBvY3RhbCANCm9wdGlvbnMuIEhvd2V2ZXIsIHNvbWUgb3B0IGZvciBhIGNvc3QtZWZmZWN0
aXZlIHN0cmF0ZWd5IGJ5IHNlbGVjdGluZyANCm9ubHkgUXVhZCBTUEkgaW4gdGhlaXIgY2hpcHNl
dCBhbmQgYm9vc3RpbmcgdGhyb3VnaHB1dCB0aHJvdWdoIHRoZSANCnBhcmFsbGVsIHVzZSBvZiB0
d28gZmxhc2hlcy4gVG8gZ2F1Z2UgdGhlIHBvcHVsYXJpdHkgb2YgdGhpcyANCmNvbmZpZ3VyYXRp
b24sIEkgd2lsbCBjb25zdWx0IHdpdGggb3VyIG1hcmtldGluZyB0ZWFtIGZvciBmdXJ0aGVyIA0K
aW5zaWdodHMuIEdpdmVuIHRoYXQgcGFyYWxsZWwgaXMgYSBjb250cm9sbGVyIGZlYXR1cmUsIGl0
IGNhbiBiZSANCmludGVncmF0ZWQgaW50byB0aGUgZHJpdmVyIGZpbGUuIEF0IHByZXNlbnQsIHdl
IGNhbiBlbXBoYXNpcyBvbiANCmltcGxlbWVudGluZyBzdXBwb3J0IGZvciBzdGFja2VkIG1vZGUs
IGVpdGhlciB0aHJvdWdoIGEgbmV3IGludGVyZmFjZSANCmxpa2UgbXRkL3NwaS1ub3Ivc3RhY2tl
ZC5jIG9yIGJ5IHV0aWxpemluZyB0aGUgbXRkIGNvbmNhdCBkcml2ZXIuDQoNCj4gY29uc2lkZXJl
ZCBvYnNvbGV0ZSBmb3IgbmV3IElQcz8NCg0KTm8sIHRoZSBwYXJhbGxlbCBtb2RlIGZlYXR1cmUg
aXMgc3RpbGwgcHJlc2VudCBpbiBBTUQncyBuZXcgSVBzLg0KDQpSZWdhcmRzLA0KQW1pdA0KPiAN
Cj4gQ2hlZXJzLA0KPiB0YQ0K

