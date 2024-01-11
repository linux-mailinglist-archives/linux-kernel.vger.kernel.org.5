Return-Path: <linux-kernel+bounces-23571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B77C82AE85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1BA1F2471B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47C715AC0;
	Thu, 11 Jan 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eu2QgYqB"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2081.outbound.protection.outlook.com [40.107.14.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68AE156C7;
	Thu, 11 Jan 2024 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP53+wFsOgn+o3yYICAXT1CpsP+Y9+xSubbjTOIpmkJmDdqqMboqSn9752DOG/vKjuF2+/RWjK11C0eM1Bd12hdsft8LH0BngscVGZhYPd4U+Jj+mN5JdJywvPbaNmASVH3flFb4MYSAqW3DCcTpL0h7PzFMHeJOyX4fUQLHsdR46bRwxSo870HklcnM8fA0naP1s7XdBM8JZAIHHZPNpZCo7PP4bVB71UC+X9ThBmzdEzlGu+mpPh5Tb30T4/K7Qt46HqWzjjkowzlZhy8ts899Inpn4P3nmClCWOGNWxgOyUXv1lsCJS9r5rm3CV1PYExvBBtrAFI+TzUmwwABAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPl9sgGakJ1+RsI+rJVKggknMAMCajBtw2xK7PfowME=;
 b=Tmp9ozqORiQe0xJZORhTT+2sZFu8KbDUwJaT6FJirjLb6URYU7Cv21ridSbXnDStFqzJxeW8fo5S0iyXBPSq57gd87OLE+q5F6iCgTY3zSjUR5Z3iWs7cejWsTsyo3ORixacjrH6ioExs3wZLwHLgAR7mMeAQiWMioTujHw0dkxQVi+iYk6RayETllvG9CddcLB7vvHnp1G7DoARk6q2JKXye5y3wJRPZ/h2twklHtKpUG4Y26BvLI2TsLQbfhIsEzG3PsLsLC1GTcRGsgMUWZA6bcVQIXZ4tR2AEB9G5vwHkLn3egLu/4pVKojBkzwcpgET3Smd4LBnSM6ekXZioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPl9sgGakJ1+RsI+rJVKggknMAMCajBtw2xK7PfowME=;
 b=eu2QgYqBYZbc9x9F7DkINlimDdlKxAI/xQoaV/9p3biwC0508lLsCFNeNx8QjPps3ZRfIG04QeboQPpYnn2EJUfLlliP/VPNRvRaWCZuVRI73/QkxMEgKYVXyYeUyiXWa/2TlThUQFeB7Y88VqMxF7dkot/hhC5VNaaJv/e0whk=
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 12:15:03 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206%7]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 12:15:03 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sherry Sun
	<sherry.sun@nxp.com>, Rohit Fule <rohit.fule@nxp.com>
Subject: RE: [EXT] Re: [PATCH v1] Bluetooth: btnxpuart: Disable Power Save
 feature on startup
Thread-Topic: [EXT] Re: [PATCH v1] Bluetooth: btnxpuart: Disable Power Save
 feature on startup
Thread-Index: AQHaRHXmphpbCknOAkWfNkOjafhN27DUamEAgAAbd7A=
Date: Thu, 11 Jan 2024 12:15:03 +0000
Message-ID:
 <AS4PR04MB96920EF69184FBD8E875A32AE7682@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240111080642.270123-1-neeraj.sanjaykale@nxp.com>
 <9f776426-b01f-4204-b508-485d3f13e933@molgen.mpg.de>
In-Reply-To: <9f776426-b01f-4204-b508-485d3f13e933@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PR3PR04MB7241:EE_
x-ms-office365-filtering-correlation-id: 0a0b0ae9-72d5-48e3-9bf8-08dc129ef114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hCNmZoUpv3XOTJdocrMhrmRE8hPQS7DWQ0rUwYaVL8+11rp9EMHpV91cxJ7r1Ba5cjGMmOnr8ugVaOGFMd2rpvvelBYNhTk/nxXucCN6IaSCdTC8rGqtp3uF8tqThF2/2+ydP4zvZkA9vw3IqzayTdqrpKoThDkFG7kljJE/Bj0RuSJH+hcO54SedaWfIu6QmccRF+MFmc69LZpegx6e0Tb9g7LVnJ4G5xL5k35b01C6aleAKj+XEviGQksffNkWOwJojVPfSxk/cg2G99pL/f2TKehjQRhavt2+zGy4+a1S8m6IJoYY6JNIGjd3JX4CxuP1caNXb5W0ejDH8FFK9jYVK6TjS8B2T1P3OraRG7vCxwpA2pXcmyCK/dKVgl+6OL8fdNMOudEj0UxrQtmK9hUUxlEky6Va3ahxwzKWVvADKMnvX3uTv3+CKpEQHUx/YXIj0Z/bYdESK5VR1J7QMJrQ9ueQf6mWoUGa0SfqlrZo+xUG0hrTj+mQ65Vk5FxKzZrSnkezx6Mv9XUNWX8Nj8qZZJUCZXH6OlYkPCItNis8yUvQoAfiO9i8bBQ8uGss5KBubbfNOQP9PoQ77X726FpHi6WTwd6QLW0Xtj0eCZrYiAS+YWv/5p+ojDBgQreh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(9686003)(55236004)(6506007)(26005)(122000001)(38100700002)(8676002)(8936002)(52536014)(4326008)(5660300002)(2906002)(7696005)(478600001)(71200400001)(6916009)(64756008)(66446008)(66476007)(66556008)(54906003)(316002)(66946007)(76116006)(41300700001)(38070700009)(33656002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aThnM044WGp3bkJvUWZpUkNoUmpxZU4wK0t6QnhSMkRwdWFKYXd3U1BhUVJU?=
 =?utf-8?B?TkNlKysxUWM1ajFmRTkzblBpVDJEZnkwNlZoc285Uk9vOWM5ZTRmS2VSb09h?=
 =?utf-8?B?c0ZSSHFTclNWL0U0Rkg2VElIQzgwdHMrNUZ5NjVqOEtRZlVPRWE0MnJMQjZh?=
 =?utf-8?B?OUtkbHJnak54SldsVjdxcWZ4SHhTaTk3YWZra01UVGMwTERsNnlIcW9nOTZV?=
 =?utf-8?B?bTR2V1U2WGNXVWtDWUhrVU4wbkZwU0x2NjEzK05FM3VycnYwMnV0ZnNybEY2?=
 =?utf-8?B?N3grMmVwd3ZyRy9NRTBrWmZLblNvM0RUdzRaemgxWVBSMVBuOHFIRXVnOGhs?=
 =?utf-8?B?dXRPYUFzSERRcVNRNk85NTV1TVU0dHV5TEluNjFTUHBRYW1TeWgydzJRQmJN?=
 =?utf-8?B?WC8zdWErNndCbkRGUHVqQWlXa3JkV2g3WW8yTEpnUlNuUHZkK1JqR1NxSkZ5?=
 =?utf-8?B?eEN6QzNMVUNvVkdPYTZvNTFpOXZLRTVLYlRtY0xrM29GbU4ya3dqRXBoUkUy?=
 =?utf-8?B?TzRPb2piK044NCtSMVIySkpwNVFpc1A2bEErcFk3WTNiVUhZNVhhOUdzQlNZ?=
 =?utf-8?B?dXkzQnlWLzFwdVNySWEzVVN1bno4REVFcE9hdUh4WXB1Y0FHZ2U2KytBRnUx?=
 =?utf-8?B?SkhnTnFXU29Zb2RGUjI1a1RrVm5ObFdTbEJFYk1XdWZnK3B2eU9zVUF1b1pl?=
 =?utf-8?B?N2sxYzZ5K3BrcmphSEljZW04YkE3WVlkUTMwZXBvVmxMKzNTZkZEdUs2ZDdt?=
 =?utf-8?B?SmxsblFYdU85dVRpd1FFaFhta01vcmdDUC9vQVV0NFRwTjE1bzhvZFBPb2t5?=
 =?utf-8?B?cXByN3NVR2ttamI2c3Z2K1RiVVlEVEk1ZDRoRVRTZE1kcHN3eXM1S0w5UVVG?=
 =?utf-8?B?VXRNNVBwR2szbDJycXJxb0Y5NEU4MWlKUzJJWStTdURwRjl6MDVzTWZ1MXdx?=
 =?utf-8?B?ZzNYcjc2Q05ya1J1UFRaTGJGWm56ZTA1MmtnZkJuQUhpRUhoOWkwUVBjcWRw?=
 =?utf-8?B?TFNuVFY4ZnQwSDVmd0VsUXZxNFlKUGdQemg0NmZ2NEl2ZFhpd3d6RC8yektX?=
 =?utf-8?B?SDl5RUREWVcvQlZyZ2FDcHVTdUQ4dXZ5aUJOQnVuUndDMGxFSXl5VStOVzVl?=
 =?utf-8?B?Y011dU80NzdKeW9kNEt1QWRKZjR6dURTSFFEMGJra0ZrSVVKWkFhU1pzOWRV?=
 =?utf-8?B?eVJiV0IyVGhYVWN2dDZkZnRWcWZWbVhhb3Rqd05idnlxZUZUZ2UrekhkUDg2?=
 =?utf-8?B?YW4vVjNSQzVQN0FDNUpOZjlxaG9ScGFPU0ZjZnliYmx4RjlrZkJndGh5Mm1r?=
 =?utf-8?B?ZmhhREsvODZJOXRnd29ueTZvL01qalFadG1GYmRrTTRVOEU0M1BZQWFkMjVv?=
 =?utf-8?B?bWpwd0MwVkpKeExxL0tmOVQ3U0pLdnQxYzd6eEdXSHNGWHNCcnF6YS9EUlA5?=
 =?utf-8?B?V2Z6aHA3cG0rbWRxN1FTeW5COXVJZFRkNlZRUzNoQjBZSFNYdTNHa1A3Sk9F?=
 =?utf-8?B?WXRwOXJFa0tzSHcxS0dKWFNyRmg0UTRyK1FwY3Vrd3ZEVjNZTUx1S1NRQ1E2?=
 =?utf-8?B?b0xwK2pnbk5sTERSTHI0YkNsY0o0ZHBXMjRMMmpQUUprMi9xK0dYdHZ6Y2da?=
 =?utf-8?B?NWV3Z3hpUkF0V2xhZVJESUxLYXlkZnc0RGYzUWdGc1dBVlpKa081aWxxMDZV?=
 =?utf-8?B?VGtmc1V0SFJHTUIzZEtlSE9XQjUveTBiVVprVHJ3Wml3RmM3U2RCT1JaVGlB?=
 =?utf-8?B?WmloRW9Rb3VNTjY3UjNSYjduZFdMb0xnajE1VVhSMjR6dlhVWmwvNTdTZ28x?=
 =?utf-8?B?Z0FDcEJnL3o5UDJ0UjJlTmVyVTZWUFRDZkVQSVBBdURqcHdRWHl5QWoyOGdZ?=
 =?utf-8?B?SFFqMnhLRDVDdVZCcFZob0JoN0w2ZzFCMVZ0SXN5TDJkQmRNaTNDazB1Y21U?=
 =?utf-8?B?YmtVN1BFYkdrdU1GREtMUmdNTGJBOWNMOHJjRUtNYytpR0RLTzQ2b0kyUTg3?=
 =?utf-8?B?UUVKM0VOciszSHErb016d1pKTjdQVDRVUzE5UEZJSWJUUWxvR0l0T0lxMFlO?=
 =?utf-8?B?TjdWTGpQb0lNa0hJck01V1FQTk83OWIwNTRTa1NhaU41RTJ1cFFWMTZ2Y1lC?=
 =?utf-8?Q?QJzktEBLTjGmnRnnKsOW/mzRH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0b0ae9-72d5-48e3-9bf8-08dc129ef114
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 12:15:03.8189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7aeT6U1xt6NsjIOlQ+DIgwzi7ROcf3jKUy+yOhh4fCVOwOM4Eg1q3PcmgnJpq6et6mvohOJFbYBg/giJBXgIwsl7IA0/uW6Xji0C9A947U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241

SGkgUGF1bCwNCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLiBJIGhhdmUgc2Vu
dCB0aGUgY29ycmVjdGlvbnMgYXMgeW91IGhhdmUgcmVxdWVzdGVkIGluIHYyIHBhdGNoLg0KDQo+
IEFtIDExLjAxLjI0IHVtIDA5OjA2IHNjaHJpZWIgTmVlcmFqIFNhbmpheSBLYWxlOg0KPiA+IFRo
aXMgc2V0cyB0aGUgZGVmYXVsdCBwb3dlciBzYXZlIG1vZGUgc2V0dGluZyB0byBlbmFibGVkLg0K
PiANCj4gVGhpcyBjb250cmFkaWN0cyB0aGUgY29tbWl0IG1lc3NhZ2Ugc3VtbWFyeSwgd2hpY2gg
c2F5cyDigJxEaXNhYmxl4oCdLg0KSSBtYXkgaGF2ZSBwcmVzc2VkICJVbmRvIiBhIGxpdHRsZSB0
b28gbG9uZyBpdCBzZWVtcy4NCg0KPiANCj4gPiBUaGUgcG93ZXIgc2F2ZSBmZWF0dXJlIGlzIG5v
dyBzdGFibGUgYW5kIHN0cmVzcyB0ZXN0IGlzc3Vlcywgc3VjaCBhcw0KPiA+IHRoZSBUWCB0aW1l
b3V0IGVycm9yLCBoYXMgYmVlbiByZXNvbHZlZC4NCj4gDQo+IGhhdmUgYmVlbg0KPiANCj4gUGxl
YXNlIHJlZmVyZW5jZSBvbmUgY29tbWl0LCB0aGF0IGZpeGVkIHRoaXMuDQpBZGRlZCBjb21taXQg
cmVmZXJlbmNlIGFuZCB0aXRsZS4NCg0KPiANCj4gPiBXaXRoIHRoaXMgc2V0dGluZywgdGhlIGRy
aXZlciB3aWxsIHNlbmQgdGhlIHZlbmRvciBjb21tYW5kIHRvIEZXIGF0DQo+ID4gc3RhcnR1cCwg
dG8gZW5hYmxlIHBvd2VyIHNhdmUgZmVhdHVyZS4NCj4gPiBVc2VyIGNhbiBkaXNhYmxlIHRoaXMg
ZmVhdHVyZSB1c2luZyB0aGUgZm9sbG93aW5nIHZlbmRvcg0KPiA+IGNvbW1hbmQ6DQo+ID4gaGNp
dG9vbCBjbWQgM2YgMjMgMDMgMDAgMDAgKEhDSV9OWFBfQVVUT19TTEVFUF9NT0RFKQ0KPiANCj4g
SXQgd291bGQgaGVscCBtZSwgaWYgeW91IHVzZWQgdGhlIGZ1bGwgNzUgY2hhcmFjdGVycyBwZXIg
bGluZSBmb3IgY29tbWl0DQo+IG1lc3NhZ2VzLCBhbmQgd291bGQgbm90IGJyZWFrIHRoZSBsaW5l
IGFmdGVyIGV2ZXJ5IHNlbnRlbmNlLiBJZiBhIHBhcmFncmFwaA0KPiBtYWtlcyBzZW5zZSwgcGxl
YXNlIHNlcGFyYXRlIGl0IGJ5IGEgIGJsYW5rIGxpbmUuDQpGaXhlZC4NCg0KPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBOZWVyYWogU2FuamF5IEthbGUgPG5lZXJhai5zYW5qYXlrYWxlQG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYyB8IDIgKy0NCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jDQo+ID4gYi9kcml2
ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYyBpbmRleCA3Zjg4YjZmNTJmMjYuLjQyZTkyOWYwZDE0
MQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jDQo+
ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gPiBAQCAtMjgxLDcgKzI4
MSw3IEBAIHN0YXRpYyB1OCBjcmM4X3RhYmxlW0NSQzhfVEFCTEVfU0laRV07DQo+ID4NCj4gPiAg
IC8qIERlZmF1bHQgY29uZmlndXJhdGlvbnMgKi8NCj4gPiAgICNkZWZpbmUgREVGQVVMVF9IMkNf
V0FLRVVQX01PREUgICAgIFdBS0VVUF9NRVRIT0RfQlJFQUsNCj4gPiAtI2RlZmluZSBERUZBVUxU
X1BTX01PREUgICAgICAgICAgICAgIFBTX01PREVfRElTQUJMRQ0KPiA+ICsjZGVmaW5lIERFRkFV
TFRfUFNfTU9ERSAgICAgICAgICAgICAgUFNfTU9ERV9FTkFCTEUNCj4gPiAgICNkZWZpbmUgRldf
SU5JVF9CQVVEUkFURSAgICBIQ0lfTlhQX1BSSV9CQVVEUkFURQ0KPiA+DQo+ID4gICBzdGF0aWMg
c3RydWN0IHNrX2J1ZmYgKm54cF9kcnZfc2VuZF9jbWQoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHUx
Ng0KPiA+IG9wY29kZSwNCj4gDQo+IFJldmlld2VkLWJ5OiBQYXVsIE1lbnplbCA8cG1lbnplbEBt
b2xnZW4ubXBnLmRlPg0KDQpUaGFua3MsDQpOZWVyYWoNCg==

