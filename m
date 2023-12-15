Return-Path: <linux-kernel+bounces-718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E5C814509
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A17B226E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BED918C1D;
	Fri, 15 Dec 2023 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lggi/sno"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3C19454;
	Fri, 15 Dec 2023 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDrf3Qcq7Z9uQNNYpGI0q7ewIyB7jk22PScQWVMjNJ21oxD9uTnXmReFaDiz53PtQ6ot8jrP0os8OIHYuBXzleh7wbKQ0R1yruVihNznjm6yQsP2OUj/67lHEWU6PjL9wFxDhLFoxiybhxRBkxTYiy1fd0EF1I7DeooNrRg5ZwwvKlgD5LNvUZR/ctKuoUxAPG6F8Ka4nGaTN59wPSbuejare7XM2iYcXFkBxwrUjCTaaVRZb7ZxFt41z5W8LDCwQXqnv1/19tymhqqJkFl/ubD/Wi05XNXvqVWzhxVmEeTOx/PBiBPJa/rCQ1F7jg2kFKufQd66nPNo+fzLNX7jdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju9jttwgQLV9hq1j2Mc/o56uNoxQe3l0aZgXsMWXjqs=;
 b=dVehN9IEEaT5nx7ZMvNAEtlvGroyoIcFOqdKpc0xZeTR64iqF0XYjHpVRZfdlc+6OIIfJF2ZI217Mm74dCrzfeG9ZMLWRxhdsYzem8SijrwhoKkjJpxX41oBO9t70j0Em31rymhqP5z3sflMfOj9INkHJITZ+Ce1nYkG7ZrCaIZhRLiEwb2+94netrlKelpb+pXCHViobslcxJLHgFiwnx8OblMLVHPMiIyQlKBkeJML2vzLYoOUXPBLzn+1gZvCWaN4hap0aq2Z5+u+fRykV5ZaS0GEujVjO5JyZQx/77bSMB8LB1cj8vTh5z100skrIfIrUik1/LJ56cPM9/sOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju9jttwgQLV9hq1j2Mc/o56uNoxQe3l0aZgXsMWXjqs=;
 b=lggi/sno7YTeZHqwBoICnQmODCTUaRi32ky6Akxy8EmiT4Um6R9F5hR/m+/xJ/MiCdpYox01rSLkq80wRZv0hM7Tfj/7eOAjgJxrDCRNde7fLUfoM725qC6QCzs6e8l7/KcTWackMXpBqZbmk0Z4gpfVpVziK7hBW9cUAsJjhdo=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 10:02:31 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64%7]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 10:02:31 +0000
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
 AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAIABtmWAgAQ4ECCAAAuVAIAAD5dQ
Date: Fri, 15 Dec 2023 10:02:31 +0000
Message-ID:
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
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
In-Reply-To: <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|MW6PR12MB8707:EE_
x-ms-office365-filtering-correlation-id: 39b07c3c-2c3d-4cb7-bc5d-08dbfd54f413
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hGqeiJJctC7OJjYlh3liX8W3WgboyL+YhDMNlRps3I3CEmBtm3I3R6O5SaNmrX0skwL7ZtN8h0OCoz72bK2hsNIDI1Ke8WuY9PDvPCDngQoAWzzT0UiSTfb0LTOF8ZIaftlWxuML2CkbZx/xRaG2CrOKwp8SYC0S/ZFOlob6C3BypKwAT5UQud+MJasVc3uXh+RH+60bsGviYFT2RkJIMGi6hdRBVrfk11uKlBRBZelbeTm4XI+XWfn5PemBuV8gzKoCGcPgJGjNswbisDOh7UbDKvORD2Mp4+6p4lTXrTn1qxjnACTs/HVPH0gZMNd2v7l2/DgBEEMc6hUJjk1oVjAxHVjCM56Jkan8Ig4Oj2V9dWTsmQN+m8Pfl5jPCAOfdREg8Hj7ktkAcg6eNhx1QLRl8S8yxqfQrRFfSOcVy/1BBThkRmS5e5fPbmOrM/ejTKDpesA17lT8Nw7E1scsGPjg0WPAGb8hDGRBtbz9NvU/uh3JwG3RuG5qpw7h8K4tolopwLtHlNgHy3AFUw8ohJNXoCrcZocACqr3fLEZjkw7iiWR2fIT+aafGpf5Tsgopcj7zgZ6NqT7aICzYt4vFUj4OG/4WNIX4Us4n3b129ZKQWj5AJgdlrQidnUHLBNi8yixj0WI2Q5QHXXics/KpQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(83380400001)(6506007)(53546011)(71200400001)(110136005)(5660300002)(9686003)(52536014)(7416002)(2906002)(41300700001)(478600001)(316002)(8676002)(8936002)(4326008)(76116006)(64756008)(66946007)(66446008)(66556008)(54906003)(66476007)(7696005)(86362001)(33656002)(38100700002)(122000001)(38070700009)(921008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVlSb2NUTG1aSDFUUExnM21XbElGOFczU0VPekNKcERkeC9GMW01SHpubCtP?=
 =?utf-8?B?dkxzenNvSXh3dmd2c1VOZ1pOTDVIYVV0bnBnR0xKV2tScWt0NkZQR29OanVE?=
 =?utf-8?B?M3ZFMlBqdVZBV1VnVHUyT21EL3VsK3piS0FGRlpGdURURzRVUlA5NzIvZzA1?=
 =?utf-8?B?SkRqeVV3c3JOdUF0NXRPQndWTXpndWlwb0RxYXpYR2RDSHR1ZXBzRzJYRUNH?=
 =?utf-8?B?VnpUOHBKN3AyTTM2SnJEdzdqYUNIaWIvbElZZ0lzKzdaMWxDaWNlVi9nWXV0?=
 =?utf-8?B?OWVITkk1MFh4d01GOE5vRGNyRlZEcVg5RkF0YnY4VHZMZXI0QUhscVlVeWgx?=
 =?utf-8?B?S3g5VnN5RUZheEhMU1J4R3dUdHVLWGZaaUNFL3d4L0NVQWxtWTYzbVV4dWZL?=
 =?utf-8?B?UG5SNDNHK05kSDVaKy9XaDlxSytzMUxHSW9xazVTZDdyYzZtYVBRSzUySFFI?=
 =?utf-8?B?eWhBNUM0WXh0N0FoSUtXb1AvNVl1WFRETzg5RXR0eGV6cnozK2dkVktCdUh2?=
 =?utf-8?B?VXdaZTF5WEhEa2hkZmRaRkhGWTZpNEdrb21SZ3dSNldvMlU2WnJjMVlJeG1O?=
 =?utf-8?B?SzhaRks5U1JNN2JzYkZ3VENQT3QrVE13b05JN2ZkQ2NaZ1NTcjlEL2pTc00x?=
 =?utf-8?B?QmN1ZVhtazFMamM5K0l4ZlNxT2xoSlJHUEpyZlRzZDVkU0dZeVVlTlVlY1Z1?=
 =?utf-8?B?cEpBSlhBdHJHYk1oZm40eWVGTis5N3RjRGxnS2t1UWxUS20vSmkrWndPZUNq?=
 =?utf-8?B?bUNjeVpzSlE5R2F5SGlDTFZFY3duOU5BblRiMWNBQ3R3RnZXNTZlUGI2RnVI?=
 =?utf-8?B?eHVzRjFBNjlubHVVOFNaRUdQektjU0svYWNoQVFpTXUrdm05L1ZHeWRYVFRk?=
 =?utf-8?B?aG1Pb1k2anY2YU1vU2dqTVVLM2QvRnhNdTRjVlJZVUEvdFIxaHZYelk3NjlJ?=
 =?utf-8?B?R2VqS2xUSWN1UVEwc0ZQOUxSbnRSTDZjUStzTHFqWE95ZExsaVh6L0FBNVkx?=
 =?utf-8?B?NmF1UnNEUE5CWjFjNmdYdGgyOE5kWFI3bG51VEZHT1pSakF6N1J6bW9nK3d1?=
 =?utf-8?B?UWF0TFYzeDMwKzJIK010Y1k5Vm1DdVlKRGFYNWMyU2g2U2ZCSjlQVUM4L1N2?=
 =?utf-8?B?Qmt3RHk3L0QrR0FXbE5DWEFDQzNheVJ5eFFZUlVUNXFoYkY4Qzh3NFFoQTdU?=
 =?utf-8?B?ZXkwdTlOMGJzLzhIQzVGcVVtVnZEMUQ5cFNiVTdORWszMnB0Ti9uWUk4eE5X?=
 =?utf-8?B?Mk1hemI5RlY2SFU5Wm5SRktabVpPb1JQN0UrbUpMa1dZWjhHKy80dkFxdGZ0?=
 =?utf-8?B?NHdzbkxBVjRwVU9Td0tiM2pheWl3SWNUbW4xclh4TVVTQ05BQjY4OWl6YUd6?=
 =?utf-8?B?aG9rWnFUdkRGWG1HM3F4V0NGUHZ2K1Z6RlR1YU11QThGQkcydWZnaUoxMzBl?=
 =?utf-8?B?RG5mQmVacmNpY0liTnlFMVJFQlFMQ0NZNmtyZmE5aUFMcHpXZTBEdjh2c3pQ?=
 =?utf-8?B?S21kWkZ4U1loUlVaNlVhQmYrSXpTekNwcmZwTXpXQnFSTzAvSVAxaHVUczNo?=
 =?utf-8?B?cTVxNUJTN2pPd0xCZ3JMT0V5aFNsMGVVOGRaK3V3MXc2MUpvN1hDa3NSQUlM?=
 =?utf-8?B?Q21mRFhUa1pVSlNyWmpxeWQvTHVENHE1VGlNc0cvQVYwSmRjekJyTFM2Rzcr?=
 =?utf-8?B?aWxNd1NrYlB1V2lKVDJuM3FSRW42SzJPN0V6U2JWMHVwZnoxcjBIL3lPcGNW?=
 =?utf-8?B?STNLSitJcDBrMHd1bzE3REJZajBvVWZidHE1eGZwbm1KOURaSjRGUDlKRmRx?=
 =?utf-8?B?Nnd6S205NysycGxMSXI1SktpSnpzVExRemNHd1pEVXFpb0dpMEsrWjJjUFE0?=
 =?utf-8?B?LzhOSWFJTkJkNVA3SDdZQ1MvK0x6ckdOOXhxVmVSdGlEOEJodTNuWW9WYmhv?=
 =?utf-8?B?RWRlNE9OSmpyNWRGbUtmOVFjWXozNXBlY1lmZzNLQUM5LzEyVWpDcnhXUzY1?=
 =?utf-8?B?U3J6ZnE0cDBGWThFUkx5aW1IbnRlaDRKTmhMei85bDUvcG5GMWJWV2VGRVJX?=
 =?utf-8?B?THhrU1RqOWpaWWI1Z1lkWFBjQ2lEaXNzZGRHYnNLbzJwOHcxcFptOHkvOHBk?=
 =?utf-8?Q?BGK8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b07c3c-2c3d-4cb7-bc5d-08dbfd54f413
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 10:02:31.7038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjXyigQ/5AwLIsFYk4ErAyaEFNnEy+Y6/sK2ZZJLMVB72dFjCUrypyw0Dj2NatvP/eMqV8HcvpvnF5tEe5nPsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707

SGVsbG8gVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIERl
Y2VtYmVyIDE1LCAyMDIzIDE6NDAgUE0NCj4gVG86IE1haGFwYXRyYSwgQW1pdCBLdW1hciA8YW1p
dC5rdW1hci1tYWhhcGF0cmFAYW1kLmNvbT47DQo+IGJyb29uaWVAa2VybmVsLm9yZzsgcHJhdHl1
c2hAa2VybmVsLm9yZzsgbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsNCj4gcmljaGFyZEBub2Qu
YXQ7IHZpZ25lc2hyQHRpLmNvbTsgc2JpbmRpbmdAb3BlbnNvdXJjZS5jaXJydXMuY29tOw0KPiBs
ZWVAa2VybmVsLm9yZzsgamFtZXMuc2NodWxtYW5AY2lycnVzLmNvbTsgZGF2aWQucmhvZGVzQGNp
cnJ1cy5jb207DQo+IHJmQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsgcGVyZXhAcGVyZXguY3o7IHRp
d2FpQHN1c2UuY29tDQo+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBtaWNoYWVsQHdhbGxlLmNjOyBsaW51eC1tdGRAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gbmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tOyBhbGV4YW5kcmUu
YmVsbG9uaUBib290bGluLmNvbTsNCj4gY2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2OyBTaW1laywg
TWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IGxpbnV4LQ0KPiBhcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsNCj4gcGF0Y2hlc0Bv
cGVuc291cmNlLmNpcnJ1cy5jb207IGxpbnV4LXNvdW5kQHZnZXIua2VybmVsLm9yZzsgZ2l0IChB
TUQtDQo+IFhpbGlueCkgPGdpdEBhbWQuY29tPjsgYW1pdHJrY2lhbjIwMDJAZ21haWwuY29tDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjExIDA3LzEwXSBtdGQ6IHNwaS1ub3I6IEFkZCBzdGFja2Vk
IG1lbW9yaWVzIHN1cHBvcnQNCj4gaW4gc3BpLW5vcg0KPiANCj4gDQo+IA0KPiBPbiAxNS4xMi4y
MDIzIDA5OjU1LCBNYWhhcGF0cmEsIEFtaXQgS3VtYXIgd3JvdGU6DQo+ID4+IFRoYW5rcyEgQ2Fu
IHlvdSBzaGFyZSB3aXRoIHVzIHdoYXQgZmxhc2hlcyB5b3UgdXNlZCBmb3IgdGVzdGluZyBpbg0K
PiA+PiB0aGUgc3RhY2tlZCBhbmQgcGFyYWxsZWwgY29uZmlndXJhdGlvbnM/DQo+ID4gSSB1c2Vk
IFNQSS1OT1IgUVNQSSBmbGFzaGVzIGZvciB0ZXN0aW5nIHN0YWNrZWQgYW5kIHBhcmFsbGVsLg0K
PiANCj4gSSBnb3QgdGhhdCwgSSB3YW50ZWQgdGhlIGZsYXNoIG5hbWUgb3IgZGV2aWNlIElELg0K
DQpOMjVRMDBBLCBNWDY2VTJHNDVHLCBJUzI1TFAwMUcgJiBXMjVIMDJKViBhcmUgc29tZSBvZiB0
aGUgUVNQSSBmbGFzaGVzIG9uIA0Kd2hpY2ggd2UgdGVzdGVkLiBBZGRpdGlvbmFsbHksIHdlIGNv
bmR1Y3RlZCB0ZXN0cyBvbiBvdmVyIDMwIGRpZmZlcmVudCANClFTUEkgZmxhc2hlcyBmcm9tIGZv
dXIgZGlzdGluY3QgdmVuZG9ycyAoTWlyb24sIFdpbmJvbmQsIE1hY3Jvbml4LCBhbmQgSVNTSSku
DQoNCj4gV2hhdCBJJ20gaW50ZXJlc3RlZCBpcyBpZiBlYWNoIGZsYXNoIGlzIGluIGl0cyBvd24g
cGFja2FnZS4gQXJlIHRoZXk/DQoNCkknbSBzb3JyeSwgYnV0IEkgZG9uJ3QgcXVpdGUgdW5kZXJz
dGFuZCB3aGF0IHlvdSBtZWFuIGJ5ICJpZiBlYWNoIGZsYXNoIGluIA0KaXRzIG93biBwYWNrYWdl
LiINCg0KPiANCj4gPg0KPiA+Pj4+IGNhbiBjb21iaW5lIGEgU1BJIE5PUiB3aXRoIGEgU1BJIE5B
TkQgaW4gc3RhY2tlZCBjb25maWd1cmF0aW9uPw0KPiA+Pj4gTm8sIFhpbGlueC9BTUQgUVNQSSBj
b250cm9sbGVycyBkb2Vzbid0IHN1cHBvcnQgdGhpcyBjb25maWd1cmF0aW9uLg0KPiA+Pj4NCj4g
Pj4gMiBTUEkgTkFORHMgc2hhbGwgd29yayB3aXRoIHRoZSBBTUQgY29udHJvbGxlciwgcmlnaHQ/
DQo+ID4gV2UgbmV2ZXIgdGVzdGVkIDIgU1BJLU5BTkQgd2l0aCBBTUQgY29udHJvbGxlci4NCj4g
DQo+IEkgd2FzIGFza2luZyBiZWNhdXNlIEkgdGhpbmsgdGhlIHN0YWNrZWQgbGF5ZXIgc2hhbGwg
YmUgU1BJIE1FTSBnZW5lcmljLCBhbmQNCj4gbm90IHBhcnRpY3VsYXIgdG8gU1BJIE5PUi4NCg0K
WWVzLCBJIGFncmVlLg0KDQo+IA0KPiA+PiBJIHNraW1tZWQgb3ZlciB0aGUgUVNQSSBjb250cm9s
bGVyIGRhdGFzaGVldCBhbmQgd29uZGVyZWQgd2h5IG9uZQ0KPiA+PiB3b3VsZCBnZXQgY29tcGxp
Y2F0ZWQgd2l0aCAyIFF1YWQgRmxhc2hlcyB3aGVuIHdlIGhhdmUgT2N0YWwuIEJ1dA0KPiA+PiB0
aGVuIEkgc2F3IHRoYXQgdGhlIHNhbWUgU29DIGNhbiBjb25maWd1cmUgYW4gT2N0YWwgY29udHJv
bGxlciAodGhlDQo+ID4+IE9jdGFsIGFuZCBRdWFkIGNvbnRyb2xsZXJzIHNlZW1zIG11dHVhbCBl
eGNsdXNpdmUpIGFuZCB0aGF0IHRoZSBPY3RhbA0KPiA+PiBvbmUgY2FuIG9wZXJhdGUgMiBvY3Rh
bCBmbGFzaGVzIGluIHN0YWNrZWQgbW9kZSDwn5mCLg0KPiA+IFRoYXRzIGNvcnJlY3QgLg0KPiA+
DQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IGhvdyB5b3Ugd2FudCBtZSB0byBwcm9jZWVkIG9uIHRo
aXMuDQo+IA0KPiBJIGdvdCB5b3UuIFN0aWxsIG5lZWQgdG8gYWxsb2NhdGUgbW9yZSB0aW1lIG9u
IHRoaXMuDQoNClN1cmUuDQoNClJlZ2FyZHMsDQpBbWl0IA0KPiANCj4gQ2hlZXJzLA0KPiB0YQ0K

