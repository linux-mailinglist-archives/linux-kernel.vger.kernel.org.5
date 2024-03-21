Return-Path: <linux-kernel+bounces-110287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C95885CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2A01F23512
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF13D12BE85;
	Thu, 21 Mar 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="a/s6aXMo"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2091.outbound.protection.outlook.com [40.107.8.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8F1E534;
	Thu, 21 Mar 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036505; cv=fail; b=mgEWUFzaBga8/rNZbRSPI5Ar1njIgx2TCgeUR31vsGlxFYjf5A+5V4UsbMLKAvcieYh8p0bAPfew5BG8Jx0nMb9XvGFPDMQk5mOmOREZOb/XMaafF46yOYME0jDwEYYlKkLnTKiq4PFEtYdrZqoPI0Yu57ChjUewiAQl7VyCgkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036505; c=relaxed/simple;
	bh=GmIdjcz41UGyDpmVX2bhK3RC8UfeSZ1AdAF/tAHJrSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nmQy0iZdJQtFKBMk07CNBSXphgHgIAtXP6x2szq3g5XJY1pdCM804SBy3XO55PjIExJ8gGUnb2d/34kRnqmYer8n8sIGZNzNayqG1Dp0B4XZP0Z0tyYyyoKPPeJeFO+YLJCztoHqPxktsx0PCc+AaJ7GhuLtH6uFRm3NfJipapM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=a/s6aXMo; arc=fail smtp.client-ip=40.107.8.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXBvhaCksU+yLfsKR7j9QTppXd3mDPcOYaD3DqtSQ1a5i1PUxYVRui54oedDGwD+8WrkRgASKIR36FaeBGlm/Dy6xm5iFm/T6FhWrRwrSKP3KRYRMXIARcYnzS8Sn4VN2zBY4AMh6Q3w/soHADW7WBNpgAqNxl5P/G0Cz12faYneVRevfh6YDlfAwi8FZxWW4MIASZQ86brnQ7XQJZdMqp+Tw1BBxSI6r8dNNgV67UqLBFJGelaz1YsOuiYtv5xacDZdK8d44nqDU3scNmxyxD7XIePK4vxExod9Pw2wXHcXOQhuuFS9GNIzAkQAwGeBFIta2ZMeC8pRuxiE27xPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmIdjcz41UGyDpmVX2bhK3RC8UfeSZ1AdAF/tAHJrSQ=;
 b=ShDrip1vZwOGDYNyIAZTNeA28sDHqlDheIStBCMDhkhaOidc5X8hcj2B6lA2jRRYPFqozOmWpysSSTX5YvkcTTtFlr/WoxmOl8xINEXrAMPveGdpUT+MjKBmbD7crhHPfw6kTpK612u9ZoM79DjUHg4XZutOhY+MLnCTJRUMiO3bYKefh82KFDW2z5anUHn9yvSsfdR8uXMqw/aX4zJJsjB03FdbgccL6ZCankQfy1G4lc0xzK95V7fE2wWRUaDHCBIfzchydZRDL7ux4Px9yl6tduNg/jfuIGz/bzbWFiVpuKqmvLdcsTo/tBNhC2bnReOy3nT77DZ65lMlh/pKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmIdjcz41UGyDpmVX2bhK3RC8UfeSZ1AdAF/tAHJrSQ=;
 b=a/s6aXMoM5cbSBNiebX1koWR99lsL1HAYM/BVLPXdZ5u2ihh5HPDPWwC/1A+KvmRI13UKLPOaADV82HGPylxs6dDmqAVFOXtCkyDCLCpYDq36kDeruMprOtXKluQwmnP7vYOFVn+MDtlfpIHhvHuyy/wfPNI35SxDmLvHtzT2Iw=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBAPR04MB7301.eurprd04.prod.outlook.com (2603:10a6:10:1a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 15:54:59 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 15:54:59 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Thread-Topic: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Thread-Index:
 AQHaes1eqLrk3YtcdE6GnHKqfgAD+rFAqraAgAAHmgCAAEjgAIABA8sAgABPQgCAAAxpgA==
Date: Thu, 21 Mar 2024 15:54:59 +0000
Message-ID: <597f2189-b719-41cf-8d2f-eaf26c91622e@solid-run.com>
References:
 <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>
 <Zfrt_dlYvBzlxull@nanopsycho>
 <c76c95af-71cb-4eb6-b3af-846ae318d18d@solid-run.com>
 <793649ff-990c-46f0-9132-bc6e95fcb94f@lunn.ch>
 <78211827-7ffb-41ac-bd78-a2641bca7c00@solid-run.com>
 <37af3d75-68dd-41ea-b97e-7ce020ebaa8c@lunn.ch>
In-Reply-To: <37af3d75-68dd-41ea-b97e-7ce020ebaa8c@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DBAPR04MB7301:EE_
x-ms-office365-filtering-correlation-id: bceecb9c-05e3-44aa-9c97-08dc49bf4320
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9gEEP6buY7f2XojYypIrhIQDK0te1JzKlAEwK1525iJoM1I6cpQJ8gLjekD+3VjJrfPlsTl6wIlP/1j4rfk1Ume3WVI1iZCDYtTGCm99c35EQfs16uzNtBgImCWyF2OJmY0iDvhZFmlCmmdlznkc6ISm1wiUXK1Hq4vmIM9sW0RHCVxwRGlhGrr9oUEtb6kdqBHgQBKw2O2qIzabN/q9OfzAXzRbNMfzyKwwrqLG8nDpodnTzGG9vu0Olm0Hv4Sppn2IZgIcJHAO5NmiL1bYwS4cjXF/X54lbQyGPMpoIRAI0to9iOrRvHhE5T2O0n3Pc+VMGGZdqGa56zpYMgduQzn4x7NGnxwwnqjsNTkgafbbyEn5fwPuLd0+ECoMybA5W+D23A61X70Kt7ka0BM0rDX24ONdi0OJLqwCe9+PQAMEesP0VcqCAGTY8sYHdK0BMmzfLB5d2SiqlQBfSJd4ahU1pBY9sCOaXHuTSnxyBfq0/JEEuBOH51ems0FZktvnVQGqDBdCiGf4t+sNswqk8thtw8er7/8gXsox57dSqtXEI3SAXmJWxztPoj4E/RA0We3BdZyKVScJ6HKQXluzMR/4QO+85CgxH1TKZpNlYJKW5RxfyzjaJ4zsOIGWoTqy4VtX18hXCkvmXFScN+h9oAZ2JdgBU73y04P3rr1Z55nEXFx4V46WetNJk3I/+v53cg++IkRjAIE96iw9XJrEyHV7oKXFdkx0GA2UMfenL+0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGcwSlBoUnVtVjByYSt4SUlkUVhQZkNzZDlhbHUzOEJuVG5PVGhNa1R5Nk5m?=
 =?utf-8?B?SVJMZ2hNOXhpY1I3MEZacWNLRGlLcmRDcTMwYUNvZmlsU3hkSkFhbFo2NW1U?=
 =?utf-8?B?NTQ4cnhNL0x2RVUwa2dxSlVBY1k5WWZ3anFWbDRpTVZZektPNUtJLzlqVGdJ?=
 =?utf-8?B?ZTBpeERSOVhzTFpiOGhUcXFaSC9hVnpxcDhzZGQrd3RGMFlQWUZud0hTc1VO?=
 =?utf-8?B?RS9DR1d5cndCRnZueWIvZDZIdEhyZ2RRcGlrUHlqdzdmaFk0Smk4WXkvK3hL?=
 =?utf-8?B?NHhNcGdldEs0VldxS1VDN0liSUtXSnQwMHZ2cTI4UGtsOXBMM3JDaCt5Lytu?=
 =?utf-8?B?RytqY0dtcFZ5dEpxdjVBbnpkL2ZyWWpHTmZJa1VPQlFrS3VaSmRjUjV2Nnlk?=
 =?utf-8?B?dS9VWTFzNDVFMjY0RXVqdHM5ZmlYcmxYdk5IZlRXU0wraUJmL2NHcTRLUXQw?=
 =?utf-8?B?bHRtQ2QrT0hrRlhDbi9zQUYrSUtQZmJ0djNjOTJsbkh2SjY4TGFnQnNJQkdr?=
 =?utf-8?B?bEhVSFFwcTAwWWFZS1laSW9qZFgrY0liSFArKzBiRjlkSjdlS3RwOFpaNENr?=
 =?utf-8?B?UXBNVEswOWNnQlB1MW81T3dhdnVta3J4ek9rbmhySmRURUxFTnRFdHNTVUtQ?=
 =?utf-8?B?K2l5NVBMUld6eHFuUDNjVGZyVUdqU0JoOHl1RExmSFhZeWJLWFpCMVE1MmRK?=
 =?utf-8?B?dE1CbE5Tb3grdXlIYWROVUFDTStEWWptdVArdVBaK0hYR3hSSkFBVll5eWQx?=
 =?utf-8?B?dHRKQzFWVXdaOWU2azJDWThjeWl1bGNSZU4wQlRCaHFuNDJMT3laMlVMK1dP?=
 =?utf-8?B?c3V5TEhMV1hSRzJEMEU3VGdCZVd0WEgrWTBZVXNYdzJKa1Nuck5SdVlmUFlX?=
 =?utf-8?B?eXJQTkRFdlJ2ciswUzQ2RG01RG00NlBMS0tLcG1SZzFxRkdldnVWa3pLQ2x3?=
 =?utf-8?B?Y3RTMXlyZDNhalo0Q3Y1YllUYXplTzFYOGR6ZlhCdVc4aldlRzdieFhTa3JC?=
 =?utf-8?B?dmllMVNaWm9Wc08zSmJ5T3AzVUJYTis1QmZGNjBZbFYwTUtlWTNXdndMaER1?=
 =?utf-8?B?Q1NEdEo1Y1UyMTF2OEp6Z3RMNUYxQXlJY0FYakdSK29YRllpLzRZd09Vamd2?=
 =?utf-8?B?Q2RGRlZRZlhaY3JoaVdvTjhmT3BsY0Yweko3MFozZkNxRVBBb0NXV2xMcnU1?=
 =?utf-8?B?Ui9CdllXZzZZTG4xRmQ4RllGWXl2ODhSSmREOW1lZE1SbHNPTjBnQTYzTy8v?=
 =?utf-8?B?bmF2NE9aNTlHbDNIWk5YZFVHaWR1WEh1bDFJNmlma0hRaHd5Q2QrcVp1MVpO?=
 =?utf-8?B?a1RMaUsyOEJwdjVyZmFRRDVjRmtGZy9JeC9SU095SS9GMVFlUmErNTd4MVlL?=
 =?utf-8?B?c0MwQWYzdUJMOWoyVm1qZHcwa0thUzZRRHU4d2FLa2xZM2xDekZkRkdkWXFR?=
 =?utf-8?B?dVhNaHk4UkJnZHk2UVI1MVZBWU52RGZrRDZwLzZSb0UzVkd5UHF4NWM2ZVBk?=
 =?utf-8?B?VlpkVy8yVnhaNDRvYVEvaW55aXZNd0xEbDBtRUlVT3FOdFZ3TndoaVBkR3Jz?=
 =?utf-8?B?T1h5RXZNNUtrRmhXQnIvOEo4UXhDUlVFUlBzemtqMkkxeW1EWGhoZ1d2TGIv?=
 =?utf-8?B?NFRZK1RxeFJZRllCQ2tIY0p3UjVHbTEzd2lmaENRc1F5cnVIbzR4ZHdQM0J0?=
 =?utf-8?B?ZHhEd0JuZE1SUTl3LzBYNDBtbE1XN0xrbHVLNEt3dGNsMzZvYy9nQnVsK1ox?=
 =?utf-8?B?dnBqL2Y3UGI5QnQ3QllmbzlObzRjbXdUdG9nME1WYnpIeEY0RmVKWUorc2dr?=
 =?utf-8?B?N2IyK3dEUVBoRVJDcnJEOTg1Rzd0VDlERGovUTJxcHFhQTF3ek00ZmJPc2Zr?=
 =?utf-8?B?OXhsRGZsc0p4bkJlTGdIMDlicHBHQm10b0FWbGZQdkRmbkpQYTJ5a1ZEZCt6?=
 =?utf-8?B?Rk9ieklMMFpqN0tta292elBVMzhMZWlwRzVIQ0YzeWJCblJleFgwM2RhT2dZ?=
 =?utf-8?B?dVJLRHFBMEpGS2IzOW5zVkhvc1loMEJ0NWc3TUxBYnFNMTVTZjEraGpXSmgr?=
 =?utf-8?B?QzdndVJLcC81U2IvMDhqckRRRWRsUlB6cEFrOWIvN0diM0NtUDZ4V2VWQ2Rq?=
 =?utf-8?Q?kpBk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <375BE395E1845A4A951617670FCFF0D7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bceecb9c-05e3-44aa-9c97-08dc49bf4320
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 15:54:59.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTADXMwWzBREPfKj6Ki+mTy1zOWgDANvt5VOVLqwXZwxvaDKQudSn1t/wn9jw77vhxuVnS7ASpnMax9QCeZJxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7301

DQpBbSAyMS4wMy4yNCB1bSAxNjoxMCBzY2hyaWViIEFuZHJldyBMdW5uOg0KPiBPbiBUaHUsIE1h
ciAyMSwgMjAyNCBhdCAxMDoyNjo1NEFNICswMDAwLCBKb3N1YSBNYXllciB3cm90ZToNCj4+IEFt
IDIwLjAzLjI0IHVtIDE5OjU3IHNjaHJpZWIgQW5kcmV3IEx1bm46DQo+Pj4+IFdpdGggc2VwYXJh
dG9ycyAoJyEnKSB3ZSBoYXZlOg0KPj4+PiBjcDAhY29uZmlnLXNwYWNlQGYyMDAwMDAwIW1kaW9A
MTJhMjAwIWV0aGVybmV0LXN3aXRjaEA0IW1kaW8NCj4+Pj4gY3AwIWNvbmZpZy1zcGFjZUBmMjAw
MDAwMCFtZGlvQDEyYTIwMCFldGhlcm5ldC1zd2l0Y2hANCFtZGlvLWV4dGVybmFsDQo+Pj4+IFRy
dW5jYXRlZCB0byBNSUlfQlVTX0lEX1NJWkU6DQo+Pj4+IGNwMCFjb25maWctc3BhY2VAZjIwMDAw
MDAhbWRpb0AxMmEyMDAhZXRoZXJuZXQtc3dpdGNoQDQhbWRpDQo+Pj4+IGNwMCFjb25maWctc3Bh
Y2VAZjIwMDAwMDAhbWRpb0AxMmEyMDAhZXRoZXJuZXQtc3dpdGNoQDQhbWRpDQo+Pj4gVGhpcyBo
YXMgYmVlbiBtYWRlIHdvcnNlIGJ5IHRoZSBEVCBtYWludGFpbmVycyB3YW50aW5nDQo+Pj4gZXRo
ZXJuZXQtc3dpdGNoQDQsIG5vdCBzd2l0Y2hANC4gQW5kIGkgZ3Vlc3MgY29uZmlnLXNwYWNlIHdh
cyBhbHNvDQo+Pj4gc29tZXRoaW5nIHNob3J0ZXIgaW4gdGhlIHBhc3QuDQo+Pj4NCj4+PiBJIHRo
aW5rIHlvdXIgaWRlYSBvZiBjcm9wcGluZyBmcm9tIHRoZSBiZWdpbm5pbmcsIG5vdCB0aGUgZW5k
LCBpcyBpbg0KPj4+IGdlbmVyYWwgYSBnb29kIHNvbHV0aW9uLiBIb3dldmVyLCBpcyB0aGVyZSBh
bnkgZGFuZ2VyIG9mDQo+Pj4NCj4+PiBjcDAhY29uZmlnLXNwYWNlQGYyMDAwMDAwIW1kaW9AMTJh
MjAwIWV0aGVybmV0LXN3aXRjaEA0IW1kaW8tZXh0ZXJuYWwNCj4+Pg0KPj4+IGFuZA0KPj4+DQo+
Pj4gY3AxIWNvbmZpZy1zcGFjZUBmMjAwMDAwMCFtZGlvQDEyYTIwMCFldGhlcm5ldC1zd2l0Y2hA
NCFtZGlvLWV4dGVybmFsDQo+PiBTaW5jZSB0aGVzZSB3aWxsIGFwcGVhciBhcyBsaW5rcyBpbiAv
c3lzL2J1cy9tZGlvX2J1cy9kZXZpY2VzLA0KPj4gdGhpcyBkYW5nZXIgZXhpc3RzLg0KPj4gSWYg
dGhlIHByZWZpeCBpcyB0b28gc2ltaWxhciwgd2UgY2FuIHJ1biBpbnRvIGR1cGxpY2F0ZXMgYWxz
byB3aGVuDQo+PiBjcm9wcGluZyBmcm9tIHRoZSBmcm9udC4NCj4+DQo+PiBTbyB3ZSBjb3VsZCBj
cm9wIGF0IHRoZSBmcm9udCBhbmQgcmVkdWNlIGxpa2VsaWhvb2Qgb2YgdGhpcyBzaXR1YXRpb24s
DQo+PiBidXQgKGltbykgc2hvdWxkIHN0aWxsIHByaW50IGEgd2FybmluZyBzaW5jZSBpdCBpcyBu
b3Qgd29ya2luZyBhcyBpbnRlbmRlZC4NCj4gVGhlIHByb2JsZW0gd2l0aCBhIHdhcm5pbmcgaXMs
IHdoYXQgZG8geW91IHRlbGwgcGVvcGxlIHdobyBhc2sgaG93IHRvDQo+IGZpeCB0aGUgd2Fybmlu
Zz8gSGFjayB5b3VyIGRldmljZSB0cmVlIHRvIHNob3J0IHRoZSBub2RlIG5hbWVzPw0KPg0KPiBB
IHdhcm5pbmcgaXMgYmVzdCBkb25lIHdoZW4gdGhlcmUgaXMgc29tZXRoaW5nIHdoaWNoIGNhbiBi
ZSBkb25lIHRvDQo+IGZpeCB0aGUgcHJvYmxlbS4gSWYgaXQgaXMgbm90IGZpeGFibGUsIGl0IGlz
IGp1c3Qgbm9pc2UuDQpXZWxsLCBvbmUgb3B0aW9uIGlzIG1ha2luZyBhIGZ1dHVyZSBjYXNlIGZv
ciBpbmNyZWFzaW5nIE1JSV9CVVNfSURfU0laRS4NCj4NCj4+PiBBbm90aGVyIG9wdGlvbiB3b3Vs
ZCBiZSBpZiB0aGUgbmFtZSBuZWVkcyB0byBiZSB0cnVuY2F0ZWQsIHVzZSB0aGUNCj4+PiBmYWxs
YmFjayBhcyBpZiB0aGVyZSB3YXMgbm8gbnA6DQo+Pj4NCj4+PiAgICAgICAgICAgICAgICAgYnVz
LT5uYW1lID0gIm12ODhlNnh4eCBTTUkiOw0KPj4+ICAgICAgICAgICAgICAgICBzbnByaW50Zihi
dXMtPmlkLCBNSUlfQlVTX0lEX1NJWkUsICJtdjg4ZTZ4eHgtJWQiLCBpbmRleCsrKTsNCj4+Pg0K
Pj4+IFRoYXQgYXQgbGVhc3QgZ2l2ZXMgeW91IHVuaXF1ZSBuYW1lcy4NCj4+IFRoaXMgZW5zdXJl
cyBhIHVuaXF1ZSBzdWZmaXggd2l0aGluIGEgYnJhbmNoIG9mIGRldmljZS10cmVlLg0KPj4gSXQg
Y291bGQgc3RpbGwgY29sbGlkZSB3aXRoIHNhbWUgc3RydWN0dXJlIG9uIGEgY3AxIG9yIGNwMi4N
Cj4gc3RhdGljIGludCBtdjg4ZTZ4eHhfbWRpb19yZWdpc3RlcihzdHJ1Y3QgbXY4OGU2eHh4X2No
aXAgKmNoaXAsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRl
dmljZV9ub2RlICpucCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29s
IGV4dGVybmFsKQ0KPiB7DQo+ICAgICAgICAgc3RhdGljIGludCBpbmRleDsNCj4gICAgICAgICBz
dHJ1Y3QgbXY4OGU2eHh4X21kaW9fYnVzICptZGlvX2J1czsNCj4gICAgICAgICBzdHJ1Y3QgbWlp
X2J1cyAqYnVzOw0KPiAgICAgICAgIGludCBlcnI7DQo+DQo+IGluZGV4IGlzIHN0YXRpYywNCkdv
b2QgcG9pbnQhDQo+IHNvIGl0IGlzIHNpbXBseSBhIGNvdW50ZXIuIFNvIHlvdSBzaG91bGQgZ2V0
IHRoZQ0KPiBuYW1lcyBtdjg4ZTZ4eHgtMCwgbXY4OGU2eHh4LTEsIG12ODhlNnh4eC0yLCBtdjg4
ZTZ4eHgtMy4uLg0KDQpUaGlzIGNvdWxkIHdvcmsgYXMgYSBmYWxsLWJhY2sgd2l0aGluIG12ODhl
Nnh4eCBkcml2ZXIuDQoNCkFsdGVybmF0aXZlbHkgLSBob3cgYWJvdXQgaGF2aW5nIGEgZ2VuZXJp
YyBoZWxwZXIgc29tZXdoZXJlIChub3Qgc3VyZSB3aGVyZSkNCndoaWNoIGNhbiBhZGQgYSBtYXJr
ZXIgYW5kIHVzZSBhIGdsb2JhbCBjb3VudGVyPw0KDQpFLmcuIGFwcGVuZGluZyAiIS4uLi0lZCIN
Cg0KQWNyb3NzIHRoZSB0cmVlIEkgZm91bmQgMzkgaW5zdGFuY2VzIG9mDQoic25wcmludGYoYnVz
LT5pZCwgIg0KDQo=

