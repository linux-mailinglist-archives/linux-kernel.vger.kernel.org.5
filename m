Return-Path: <linux-kernel+bounces-32284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8CD83596A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698A51F21021
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865E15D0;
	Mon, 22 Jan 2024 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H8j5vhYh"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5248EA5F;
	Mon, 22 Jan 2024 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890963; cv=fail; b=pALJXLqBc344ECZEvskbOOgHc8bEkqYr9EM0f7B0VOFSp6jHPxxXBfl57PgHSg1pxgkIlRjRKZKP5oQ46b70HrM/Xs3NVK3VzTlMT7G3be7YQj4WZ2yJm0b87dGEncmQqBNCRHrlV5I/wlSmvTCjkCR2HbjMIvcv/mDgu+pmJ1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890963; c=relaxed/simple;
	bh=w0xgOvjsR68Q/E7ELhzVd1czkvEFrCBw94zhaVBZlG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WoFRMrnyQuEG0c82YqmYZShgnSK5NOTFT3LGk8hck26DRJjjIC3Hxn8VnEYX+er3KyKdHEjcp8bUqs8ejWvUcOGFQTwQJlEjaz0J0j6CMbNzGu/u8eqoYVjDiH+JoQXBvrV07ZXPUJOLgUItVDGdxGMnboTvv2m+zAzlfw+M2VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H8j5vhYh; arc=fail smtp.client-ip=40.107.105.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpnH9SXqGD5fTKDEGn4FoR0tJltBQjnzuiWDE9BXVSSkcbpSvI1va2WjDu7S/dASFzoNRqmgeIEGjLE1ltug8dRlyRp8yQuJTYEwRQglAmFhQlvryVmW9Cxqjc+9uZtvInL9i7yI7/aAvnNsz71jCNuSZcpuhrMagSqodZgt11xiUhHPnZ2HypY6QKMgO3jGPoaSs+yeZn7P5AuGqFQcz4DxGgJAxYdChZngFFXwB5jf5cCiAsh0gZaKMoDMxJ+f496v7IVnDngAL3JtsRyxjQTOzSZOU9GHg/Z4UDl4PRqTz9IkCdj+ZETcbHpHf0Oz8aNBREmF8PqnIunjnGo6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0xgOvjsR68Q/E7ELhzVd1czkvEFrCBw94zhaVBZlG8=;
 b=fpmi7UW/3h/Y4XTalSr+sB53uU4kR7cMBkNAZQJ6y/KoxvQ6hYwUEj3xspJyORDUW3A/v+1yFfe7FvRBdYtDnArhrB/Hzb0umlb0elkU+MqtG35KfSExNlhoSUDGqGtJYYL0b8/0WMnmw4yOut0sc7f9fi3w/nidLmJF1duWGZKJO1tO4fbafXIF62SWObbCIgzvw2NyfqZqt4fYF/8m+PEPxFdBwYsP5j9gZ3jk1iy8ptWA7GKofGGpeWp2UO5Ivv9rg7JrqSo9xo5WZlMjPcUpTZ53N5GKo+QKgIq3AZAB3pRpio1FRxqnWLr5G4OiOCiY7MxC0DQFW4xKaVlMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0xgOvjsR68Q/E7ELhzVd1czkvEFrCBw94zhaVBZlG8=;
 b=H8j5vhYhU6XEoOOO28vYPdfAwp71v7jxqSgzsQbgCCFf4QVjvjhf1XUr/bmRHD/rusP3PN0GnVoyCnltM0qBnGDygJPgiB31AVYXOF5lWTxyoyuC+7Ww8bY93w2Ju8gDyia+PEEktfKe2rpcj6ii81aof9xRy8ahHG0jwkxWF28=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB8680.eurprd04.prod.outlook.com (2603:10a6:10:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 02:35:58 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::b0b2:5cbb:3f6a:6630]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::b0b2:5cbb:3f6a:6630%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 02:35:58 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Rafael Beims <rafael@beims.me>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHaSjEAO+HQnD/Ih0ixtnf/7VSxSLDlIrtQ
Date: Mon, 22 Jan 2024 02:35:58 +0000
Message-ID:
 <PA4PR04MB9638F9053080108359356E6CD1752@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
In-Reply-To: <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DU2PR04MB8680:EE_
x-ms-office365-filtering-correlation-id: 87aeca14-036d-40d4-bfad-08dc1af2ddcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xw2w2REljT06mP/d6YJOm/ipO8Qm5K6chQF8p1fcDr8W9KDSIv4Rx6My01vo9AuZ3/UFkw+5Qurc+lc9zo+kOErP6wWlwyyU4OF8Fn0l64kKYmrtvfP5FKKYMJuAVyrNy2vIqtPfo3AuGeIXNXxZu7edum3YVq+V5h5bJQHzfWdRgFFSvw41qmXh2MheuEmn/GGTn3DwOihJ4cvwHuyNmSiAs8p//3YtaYc1ChT3ZyT2tEkwdSeE1n8YjBI/fJaQEi3c9Qq+VabrFABi/l19hAby6pXjzH7ZcwJy903rHlse7/hqbObaPaNlgCQCJuJPpfQtDQXGjwa7WgeBqD4Aya0goGZq3/uyTrRkj9RUqW6Tr4UKgPApbfxQJ9NaP7aaXjXmvnNrsRG4uLJ9uj/tVMd5iRbFBrh8F5sA7vXQlFTQGZPXRf37j4v/UPBidCJxqbhBmGU1mwWU1b4URDgWn1VxbgvbT8CKzl8t+wEFsEeV3zC+zDjXBqGlgK4VcVPkQH64dDVbxqLmrm3QAdR8SlXGE/f8PwqlkifRF5PCLGORy5zgIwPA21bJ5/zzBuZw1Vcf10mKeN5Sd312qrEHHmgV/yFp+BTuHsCMqEIHcX8ERx07BccG3ZXnh45mSKZNttXArniT489XLoI9Vsi/ooRY3CbiaIsoUTHdt0VpCW8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39850400004)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(55016003)(7696005)(6506007)(9686003)(26005)(33656002)(53546011)(71200400001)(86362001)(38070700009)(38100700002)(52536014)(41300700001)(8676002)(8936002)(4326008)(83380400001)(2906002)(5660300002)(122000001)(316002)(478600001)(66476007)(66946007)(110136005)(76116006)(66556008)(66446008)(54906003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjdlckJaRU8zdU5oZXpQVGt1aWsyU2I0dm9iK09LL1h4eSttUFlkNm1reWxC?=
 =?utf-8?B?dFRTc3cxVnRPLzZQZUFDZ3JQbGVNQ3p5WDB3TU9RTWdLcWczcnNPTi9kQStL?=
 =?utf-8?B?bnpadDRhU0svdy9tUGFwT2VlMlBDdUVlMGYyVTU4Wm1XUlAyMUQ3bTNLM0Zn?=
 =?utf-8?B?elg2T1NrR0dVSHNuQ1UrQ2Q2K2o2d3FEbklZNGs1dXlHeG5NK0NYNkt2UVB3?=
 =?utf-8?B?TStSZ25ObUw4VnpRR2FxSlVOdDZ2YkpZSUZrWDJkZmQ1b1NnQ3Zxb0ZJaFN3?=
 =?utf-8?B?cmhiQjRqbjlkWVg2UVZ4WXljVXlydnVqMHJNeUwxbVhpL25ydFI5clZ0UGZU?=
 =?utf-8?B?bnlyRkJzZGVxTFRHd2dobS9ST3ZJZURSZzRCZmpxRy9BdE9rUDJDSjEyKy9p?=
 =?utf-8?B?amlUNzN4VThkUE1FaTBpS21rKzljWFJqaDVldzRtTWpYeElLSUxack84Qnpl?=
 =?utf-8?B?bWVmK3MzU2N0cHJqbnlJMGRic2V2bGxBYWNLb2RtZ2V6SVZ3SHBwYzdwMU55?=
 =?utf-8?B?R1ZoSVhoZDlodldERGtqVlcvdEhFeHFrMkx1VWovUVlIOE1QdnpxalNZRUpa?=
 =?utf-8?B?K2Y0a2tyUjhIYVpaRDhROTFhWmdlM0FTNkVGYjBNUk5vNTBqU1VPVkI1Q1hL?=
 =?utf-8?B?Qzl0TDk4N1ViR29wc0RjbmZ6QmM5WlZwNUFjcXBmSHBBNXg1a2FQUDVWUjEw?=
 =?utf-8?B?c2xVSWswOGRBUmQxazhXdmJPdGxaRFN1WHI2S0JLOHVBYTdtbEJYZlVBMTVO?=
 =?utf-8?B?Y2JiTWpuY2RRWGdEUGRCTndvYzJjVGtmN0syTkxJbUNlZURWYXBaS01zbTNN?=
 =?utf-8?B?b0c3ckN3dSs2N0VjNjR3RktCb0thS1ptSHNTaTErTndEUHA5UXpKMEpYMkd3?=
 =?utf-8?B?MDMxanRVSkNpWkFhZUFDWUI1UTFmWXNXdUJDVjRpaVovNFFKZjZvVW1obldk?=
 =?utf-8?B?NWROTUxBRU1QZE54Ym1DcjMyNTZXTENlUC9xRHVHNldNcXZFYjNUcEk4Ukgr?=
 =?utf-8?B?NVIrL05uT2V2YzVPbkJkOGZKRkpYMEo4QXdDbnNsUmhIVkFGeTlUTTB2U0h1?=
 =?utf-8?B?dGNINzNMUlUrS24xN0MzZmgzcFZzR25lSzFFUGJRMWtQU0RqWDBEK2pGQnVl?=
 =?utf-8?B?bnM3TXlrZFUxendvbUVEd1J4bVlkaFZtalh5RVlLdG9DbGZ3Z2lkY21hc1or?=
 =?utf-8?B?SG03dERxZmlFKytmNHZPUGxnTTY5K1hVOUhCQUJwYmdyemhaSi9LUHEzWGhK?=
 =?utf-8?B?ZGhURHpHWllXMGRQT0FSMWIwTDd0aFdFOEdTU1ZTSnF0Z1lRQjE4QTBHZ3Rv?=
 =?utf-8?B?ZnJoa2NqYXNXWHdTSUxOKzgxTFJSQmc3SEZXY1FpVEFRWWJuU2hveUhEQlMy?=
 =?utf-8?B?SGtLZDhyZ1h1ZDk4QWdpYUl4WTg5ZDRSb2psNVFvNW5RVnBtenU3QjhFVWVQ?=
 =?utf-8?B?dW9YUTRiNnduOTU3MTFwL3VmL0lTYzlrWWNzWDZhS1o1NXNNWWpNR3JEM0pM?=
 =?utf-8?B?NlB4b05vMnhMZ3JiaUdnVGw0ZGNxbHNCNmJodkZMZVZab0NxRjZnQ0lhV1pv?=
 =?utf-8?B?U1UrYWhDbDBwbGRIaDhYMHZsUm9YUERlaWl0SXBGZDlES0FnZDJxOUkzVlgy?=
 =?utf-8?B?bENoT1RtazFzeWQ4VXJBcUVRanp6VUlldmNaNXZLRURmcWNsRzdGMzdVcnYx?=
 =?utf-8?B?RHZDSnJQZ3czSkQwQUgrK0xuRGNyZzhpcWNlQ1l1MVNzQVRGYTh1S2VTc2Qr?=
 =?utf-8?B?MWFRRkFZRTlEejNRUDYwTWMrUEpydzFvTU1pRWdWMUNQNU5YR3pybW8zSWln?=
 =?utf-8?B?ZmVNNllEUVN3bjV4azVHYUlOWjBKOVdLNXRrOTgyTWxyZGZWYVVwNlppNUdZ?=
 =?utf-8?B?bldPUWFrRmRwNnVncjhnZHR1ZFByeUpkMWZkbUhNTWdHV0l6V1hIbHVOMmdn?=
 =?utf-8?B?L1hyeGFnRFdyVk51TDFucS95U0N0RXQ0dHlyRm1vN011UThLL0VWL3YyK3px?=
 =?utf-8?B?UWFtMGZ3QTFDY3ppUTNKNzdBb1BoK0hUWkRoTUlBNG9VNTViNnBzUkp1SGxa?=
 =?utf-8?B?VTFua1FpVHV5VURqZkVRNmJERm9kazFNVFFRc2wrdjY2bUNjQjZHa3RjNTU0?=
 =?utf-8?Q?KhhBFgbMCqzkkbrJ78YJEgYLZ?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87aeca14-036d-40d4-bfad-08dc1af2ddcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 02:35:58.5386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1u/rtMtOs3C/Heydpwmy+gppp6b2KTvYW8+p/wmOVxEI6nnm3+KYa4NtK0EvmlD4Ek5GhhGWFtbOpQt+ISowfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8680

PiBGcm9tOiBSYWZhZWwgQmVpbXMgPHJhZmFlbEBiZWltcy5tZT4NCj4gU2VudDogRnJpZGF5LCBK
YW51YXJ5IDE5LCAyMDI0IDE6MDkgQU0NCj4gVG86IERhdmlkIExpbiA8eXUtaGFvLmxpbkBueHAu
Y29tPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc7DQo+IGt2YWxvQGtlcm5l
bC5vcmc7IGZyYW5jZXNjb0Bkb2xjaW5pLml0OyBQZXRlIEhzaWVoDQo+IDx0c3VuZy1oc2llbi5o
c2llaEBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY4IDAvMl0gd2lmaTog
bXdpZmlleDogYWRkIGNvZGUgdG8gc3VwcG9ydCBob3N0DQo+IG1sbWUNCj4gDQo+IENhdXRpb246
IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2lu
ZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQg
dGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0K
PiANCj4gT24gMjIvMTIvMjAyMyAwMDoyMSwgRGF2aWQgTGluIHdyb3RlOg0KPiANCj4gPiBUaGlz
IHNlcmllcyBhZGQgaG9zdCBiYXNlZCBNTE1FIHN1cHBvcnQgdG8gdGhlIG13aWZpZXggZHJpdmVy
LCB0aGlzDQo+ID4gZW5hYmxlcyBXUEEzIHN1cHBvcnQgaW4gYm90aCBjbGllbnQgYW5kIEFQIG1v
ZGUuDQo+ID4gVG8gZW5hYmxlIFdQQTMsIGEgZmlybXdhcmUgd2l0aCBjb3JyZXNwb25kaW5nIFYy
IEtleSBBUEkgc3VwcG9ydCBpcw0KPiA+IHJlcXVpcmVkLg0KPiA+IFRoZSBmZWF0dXJlIGlzIGN1
cnJlbnRseSBvbmx5IGVuYWJsZWQgb24gTlhQIElXNDE2IChTRDg5NzgpLCBhbmQgaXQNCj4gPiB3
YXMgaW50ZXJuYWxseSB2YWxpZGF0ZWQgYnkgdGhlIE5YUCBRQSB0ZWFtLiBPdGhlciBOWFAgV2kt
RmkgY2hpcHMNCj4gPiBzdXBwb3J0ZWQgaW4gY3VycmVudCBtd2lmaWV4IGFyZSBub3QgYWZmZWN0
ZWQgYnkgdGhpcyBjaGFuZ2UuDQo+ID4NCj4gPiB2ODoNCj4gPiAgICAgLSBTZXBhcmF0ZSA2LzEy
IGZyb20gcGF0Y2ggdjcuDQo+ID4gICAgICAgQXMgaXQncyBhIGJ1ZyBmaXggbm90IHBhcnQgb2Yg
aG9zdCBNTE1FIGZlYXR1cmUuDQo+ID4gICAgIC0gUmVhcnJuYWdlIE1MTUUgZmVhdHVyZSBpbnRv
IDIgcGF0Y2hlczoNCj4gPiAgICAgICBhLiBBZGQgaG9zdCBiYXNlZCBNTE1FIHN1cHBvcnQgZm9y
IFNUQSBtb2RlLg0KPiA+ICAgICAgIGIuIEFkZCBob3N0IGJhc2VkIE1MTUUgc3VwcG9ydCBmb3Ig
QVAgbW9kZS4NCj4gPg0KPiA+IHY3Og0KPiA+ICAgICAtIEZpeCByZWdyZXNzaW9uOiBEb3dubGlu
ayB0aHJvdWdocHV0IGRlZ3JhZGVkIGJ5IDcwJSBpbiBBUCBtb2RlLg0KPiA+ICAgICAtIEZpeCBp
c3N1ZTogT24gU1RBVVQsIGtlcm5lbCBPb3BzIG9jY3VycyB3aGVuIHRoZXJlIGlzIG5vIGFzc29j
aWF0aW9uDQo+ID4gICAgICAgcmVzcG9uc2UgZnJvbSBBUC4NCj4gPiAgICAgLSBGaXggaXNzdWU6
IE9uIFNUQVVULCBpZiBBUCBsZWF2ZXMgYWJydXB0bHkgYW5kIGRlYXV0aCBpcyBtaXNzaW5nLA0K
PiA+ICAgICAgIFNUQSBjYW4ndCBjb25uZWN0IHRvIEFQIGFueW1vcmUuDQo+ID4gICAgIC0gRml4
IHJlZ3Jlc3Npb246IFNUQSBjYW4ndCBjb25uZWN0IHRvIEFQIHdoZW4gaG9zdF9tbG1lIGlzIGRp
c2FibGVkDQo+ID4gICAgICAgKGltcGFjdCBhbGwgY2hpcHMpLg0KPiA+ICAgICAtIEFkZHJlc3Mg
cmV2aWV3ZXIgY29tbWVudHMuDQo+ID4NCj4gPiB2NjoNCj4gPiAgICAgLSBDb3JyZWN0IG1haWxp
bmcgc2VxdWVuY2UuDQo+ID4NCj4gPiB2NToNCj4gPiAgICAgLSBBZGQgaG9zdCBiYXNlIE1MTUUg
c3VwcG9ydCB0byBlbmFibGUgV1BBMyBmdW5jdGlvbmFsaXRpZXMgZm9yDQo+IGJvdGgNCj4gPiAg
ICAgICBTVEEgYW5kIEFQIG1vZGUuDQo+ID4gICAgIC0gVGhpcyBmZWF0dXJlIChXUEEzKSByZXF1
aXJlZCBhIGZpcm13YXJlIHdpdGggY29ycmVzcG9uZGluZyBLZXkgQVBJDQo+IFYyDQo+ID4gICAg
ICAgc3VwcG9ydC4NCj4gPiAgICAgLSBRQSB2YWxpZGF0aW9uIGFuZCByZWdyZXNzaW9uIGhhdmUg
YmVlbiBjb3ZlcmVkIGZvciBJVzQxNi4NCj4gPiAgICAgLSBUaGlzIGZlYXR1cmUgKFdQQTMpIGlz
IGN1cnJlbnRseSBlbmFibGVkIGFuZCB2ZXJpZmllZCBvbmx5IGZvcg0KPiBJVzQxNi4NCj4gPiAg
ICAgLSBDaGFuZ2Vsb2dzIHNpbmNlIHBhdGNoIFY0Og0KPiA+ICAgICAgIGEuIEFkZCBXUEEzIHN1
cHBvcnQgZm9yIEFQIG1vZGUuDQo+ID4gICAgICAgYi4gQnVnIGZpeDogSW4gV1BBMyBTVEEgbW9k
ZSwgZGVpY2UgZ2V0cyBkaXNjb25uZWN0ZWQgZnJvbSBBUA0KPiA+ICAgICAgICAgIHdoZW4gZ3Jv
dXAgcmVrZXkgb2NjdXJzLg0KPiA+ICAgICAgIGMuIEJ1ZyBmaXg6IFNUQVVUIGRvZXNuJ3Qgc2Vu
ZCBXTU0gSUUgaW4gYXNzb2NpYXRpb24gcmVxdWVzdA0KPiB3aGVuDQo+ID4gICAgICAgICAgYXNz
b2NpYXRlIHRvIGEgV01NLUFQLg0KPiA+DQo+ID4gdjQ6DQo+ID4gICAgIC0gUmVmaW5lIGNvZGUg
c2VnbWVudCBwZXIgcmV2aWV3IGNvbW1lbnQuDQo+ID4gICAgIC0gQWRkIEFQSSB0byBjaGVjayBm
aXJtd2FyZSBlbmNyeXB0aW9uIGtleSBjb21tYW5kIHZlcnNpb24gd2hlbg0KPiA+ICAgICAgIGhv
c3RfbWxtZSBpcyBlbmFibGVkLg0KPiA+DQo+ID4gdjM6DQo+ID4gICAgIC0gQ2xlYW51cCBjb21t
aXQgbWVzc2FnZS4NCj4gPg0KPiA+IHYyOg0KPiA+ICAgICAtIEZpeCBjaGVja3BhdGNoIGVycm9y
IChwd2VbMV0gLT4gcHdlWzBdKS4NCj4gPiAgICAgLSBNb3ZlIG1vZHVsZSBwYXJhbWV0ZXIgJ2hv
c3RfbWxtZScgdG8gbXdpZmlleF9zZGlvX2RldmljZQ0KPiBzdHJ1Y3R1cmUuDQo+ID4gICAgICAg
RGVmYXVsdCBvbmx5IGVuYWJsZSBmb3IgSVc0MTYuDQo+ID4gICAgIC0gRGlzYWJsZSBhZHZlcnRp
c2luZyBOTDgwMjExX0ZFQVRVUkVfU0FFIGlmIGhvc3RfbWxtZSBpcyBub3QNCj4gZW5hYmxlZC4N
Cj4gPg0KPiA+IERhdmlkIExpbiAoMik6DQo+ID4gICAgd2lmaTogbXdpZmlleDogYWRkIGhvc3Qg
bWxtZSBmb3IgY2xpZW50IG1vZGUNCj4gPiAgICB3aWZpOiBtd2lmaWV4OiBhZGQgaG9zdCBtbG1l
IGZvciBBUCBtb2RlDQo+ID4NCj4gPiAgIC4uLi9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4
L2NmZzgwMjExLmMgICB8IDM5NA0KPiArKysrKysrKysrKysrKysrKy0NCj4gPiAgIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9jbWRldnQuYyB8ICAyNyArKw0KPiA+ICAgZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L2RlY2wuaCAgIHwgIDIyICsNCj4gPiAg
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9mdy5oICAgICB8ICA1NCArKysN
Cj4gPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9pbml0LmMgICB8ICAg
NiArDQo+ID4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgvaW9jdGwuaCAg
fCAgIDUgKw0KPiA+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L2pvaW4u
YyAgIHwgIDY2ICsrLQ0KPiA+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4
L21haW4uYyAgIHwgIDU0ICsrKw0KPiA+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9t
d2lmaWV4L21haW4uaCAgIHwgIDE3ICsNCj4gPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZl
bGwvbXdpZmlleC9zY2FuLmMgICB8ICAgNiArDQo+ID4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9t
YXJ2ZWxsL213aWZpZXgvc2Rpby5jICAgfCAgMTMgKw0KPiA+ICAgZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWFydmVsbC9td2lmaWV4L3NkaW8uaCAgIHwgICAyICsNCj4gPiAgIC4uLi93aXJlbGVzcy9t
YXJ2ZWxsL213aWZpZXgvc3RhX2NtZHJlc3AuYyAgICB8ICAgMiArDQo+ID4gICAuLi4vbmV0L3dp
cmVsZXNzL21hcnZlbGwvbXdpZmlleC9zdGFfZXZlbnQuYyAgfCAgMzYgKy0NCj4gPiAgIC4uLi9u
ZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L3N0YV9pb2N0bC5jICB8ICAgMyArLQ0KPiA+ICAg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L3N0YV90eC5jIHwgICA5ICstDQo+
ID4gICAuLi4vbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC91YXBfY21kLmMgICAgfCAxNzEg
KysrKysrKysNCj4gPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC91dGls
LmMgICB8IDEwNCArKysrKw0KPiA+ICAgMTggZmlsZXMgY2hhbmdlZCwgOTc0IGluc2VydGlvbnMo
KyksIDE3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4NCj4gPiBiYXNlLWNvbW1pdDogNzgzMDA0YjZk
YmRhMmNmZTlhNTUyYTRjYzljMWQxNjhhMjA2OGY2Yw0KPiANCj4gSSBhcHBsaWVkIHRoZSB0d28g
Y29tbWl0cyBvZiB0aGlzIHNlcmllcyBvbiB0b3Agb2YgdjYuNyBidXQgdW5mb3J0dW5hdGVseSB0
aGUNCj4gQVAgaXMgZmFpbGluZyB0byBzdGFydCB3aXRoIHRoZSBwYXRjaGVzLiBJIGdldCB0aGlz
IG91dHB1dCBmcm9tICJob3N0YXBkIC1kIg0KPiAocnVubmluZyBvbiBhIFZlcmRpbiBBTTYyIHdp
dGggSVc0MTYpOg0KPiANCj4gbmw4MDIxMToga2VybmVsIHJlcG9ydHM6IE1hdGNoIGFscmVhZHkg
Y29uZmlndXJlZA0KPiBubDgwMjExOiBSZWdpc3RlciBmcmFtZSBjb21tYW5kIGZhaWxlZCAodHlw
ZT0xNzYpOiByZXQ9LTExNCAoT3BlcmF0aW9uDQo+IGFscmVhZHkgaW4gcHJvZ3Jlc3MpDQo+IG5s
ODAyMTE6IFJlZ2lzdGVyIGZyYW1lIG1hdGNoIC0gaGV4ZHVtcChsZW49MCk6IFtOVUxMXQ0KPiAN
Cj4gSWYgSSBydW4gdGhlIHNhbWUgaG9zdGFwZCBvbiB2Ni43IHdpdGhvdXQgdGhlIHBhdGNoZXMs
IHRoZSBBUCBpcyBzdGFydGVkIHdpdGgNCj4gbm8gaXNzdWVzLg0KPiANCj4gDQo+IElzIHRoZXJl
IGFueXRoaW5nIGVsc2UgdGhhdCBzaG91bGQgYmUgZG9uZSBpbiBvcmRlciB0byB0ZXN0IHRoaXM/
DQo+IA0KPiANCj4gUmFmYWVsDQoNCk91ciB0ZXN0IGlzIG9uIHY2LjEuIEkgd2lsbCB0cnkgdG8g
dGVzdCBvbiB2Ni43LiBUaGFua3MgZm9yIHlvdXIgaW5mb3JtYXRpb24uDQoNCg==

