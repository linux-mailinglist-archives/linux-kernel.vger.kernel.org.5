Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4080EED3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376605AbjLLOaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376810AbjLLOaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:30:15 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2046.outbound.protection.outlook.com [40.107.255.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54B58F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:30:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTgA59+G9zzocAJKHggfbQQRK/vXDh7jcmoNRS/WAxUHEwZgTPIqH9UfNdEY/Iu+0Ps8NFzTPPAVIGD0ZXSssK+ftZQB6QFqBpj/6zl4PesngZ15rHvAxoL02JFiTvF1GR1GwI00vW6erDEpVVjlwkRlu9jYJURzbZAMxQOgKu52hAhTZlU8Rs2pTLMaTutXYThQNXyT35D6RlDS7zML3PY3uyiBGrhnKaJWxuHl6Bvu4lfQ7XNneaELVSYI7+yoJUB/dXzk8bhfZLGO5ytC/A0j9pAuTWB7BYT1j4h8aIaQbZzsZCvYRwyOMrTa2Z9qxR224CL27/DbdE36yqX61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs2JnlESjRWqGqBGg+SibCUjA8qE5EJrjvHRLXF7yV0=;
 b=a+pvdYVLknswaM544qaUbnaVmR6605gV0oTgdvWBsbW5cKoSNMVmwITh3slDf4BF6Dlfa3ZUgxvfKckR1f7NFB9ZJcalECKrgqSVM4KGwac/vP2/1egLnDfwlgOVutXp+FK9XfZ+0oJhN7BMuL76/Owu5mRmvyC/8IWUcl/JZpEjl59K77swpLIYPbxro2kw6bHQX3/LFKnpksj2EsFZVAE60k8M+OgRGPXvQuoUmPcJrAuCs76cbj8m3ysuSoXbbQ9BXA8mesJOkW8XSD1d0KAwxQ5qUz48/dmsbIPMI7PWxdwvIjw4kMzC4hHYsHQx8nmA/DngN8BVxRyD4s7TXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5)
 by KL1PR06MB6260.apcprd06.prod.outlook.com (2603:1096:820:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 14:30:14 +0000
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c664:8a1e:66d6:4e62]) by SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c664:8a1e:66d6:4e62%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 14:30:13 +0000
From:   "Joakim  Zhang" <joakim.zhang@cixtech.com>
To:     "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cix-kernel-upstream <cix-kernel-upstream@cixtech.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIFYxXSBkbWEtbWFwcGluZzogU2V0IGRtYV9tZW0gcG9p?=
 =?gb2312?Q?nter_as_NULL_after_it's_freed?=
Thread-Topic: [PATCH V1] dma-mapping: Set dma_mem pointer as NULL after it's
 freed
Thread-Index: AQHaLLsf9zFew5uln021tGesBo/lHrCls20w
Date:   Tue, 12 Dec 2023 14:30:12 +0000
Message-ID: <SEYPR06MB62783EBAE40527D140F29B04828EA@SEYPR06MB6278.apcprd06.prod.outlook.com>
References: <20231212052130.2051333-1-joakim.zhang@cixtech.com>
In-Reply-To: <20231212052130.2051333-1-joakim.zhang@cixtech.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6278:EE_|KL1PR06MB6260:EE_
x-ms-office365-filtering-correlation-id: f680e4e5-a4dc-4bfc-1f92-08dbfb1ed9fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOPAJNvsEo8UiOMBM+CLHu2QpAqCBxWet0cKCq8apvvRUDMxkV9FmgEye1WhY4OvlHuypF9WepaF+pTwhCl84q0n6bWVgTBqT5+lTYYwX33eK+BDvFIc9fLQPTnKIZGC7wLMnd17uZ/cPTdwTPmf1ieVA5U+EAbkwNitwxoR93NYI03xSG8YVrYsy3Crj/8CBcfVjLHsolneAyKB9RGu9ahQh+MRNFs7adFhrEmfhsZyaqciJQkwoBL8MAsiluXqh478n3y8QRGmF2REODBdACk7EkuePMUxo8rHVEO41drx1htjaJfaxQ9CtxoNBxv+LtvtEsYMOmxuaQLbphMtTGZTqowxINXDbrwIQaW7gCsPLUWLZbTiEPAfzLmxAhDwmQKaTOt7YCf9uaYtKAnSyxyJ+hjxd58XdAUBkwMsKTJKlUpNbthwVQieKScGDsSiyiXhk68GLuV9a2gqZft68PqRfTb4H6gKmrWXhm7xPa3+NW/Z1tzAv7qRcXXuJ661QOVMJIaURBE2P6OoLfNw9U8rNib7hsWkkuM8HToiJYf6Svh8mP5Hq7OQnmVPMyxVz222TBe5J5dG8MGrbWoexTZyGECzfGP6w2RSMXmjlmi+J5rQgAR85yPKl3lya/HW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6278.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39840400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(107886003)(26005)(7696005)(71200400001)(9686003)(52536014)(5660300002)(2906002)(6506007)(478600001)(4326008)(41300700001)(66476007)(110136005)(8936002)(66946007)(76116006)(66556008)(66446008)(316002)(64756008)(83380400001)(54906003)(122000001)(86362001)(33656002)(38100700002)(38070700009)(224303003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dVpSWWp6L3dLempNdWRHcG4zR3RyenVwYytKc1FOdmUzUXpNWTV6YWJ5NHBT?=
 =?gb2312?B?VlRSeTZQOWdyYUFoaDdBRm9idGx0bGtaSTUyQWdEUmpKOUZvd2RoNllid3hQ?=
 =?gb2312?B?RGxnYXlVVmNSSk1ac0UxL21SYnlBZlJxUjhsSVR6MTZnN2N3WElkK2xCdWpL?=
 =?gb2312?B?K0pIZytYekYxYkZDUHN6UFJncGV6Zm1PYkR1cVB6Tm1GczBFdjN1YlZHc3Zw?=
 =?gb2312?B?bDJnL0o3dUdUY3ZWSkpUTFlSMm5Nb25xMDArQ25Mb0FaVjlpYllscktMWiti?=
 =?gb2312?B?dUVkL05WdUVWQkNmNXAwUHk0bzhkTktLSW9Ua3NacWtRaDUrblJLTEZvbXRm?=
 =?gb2312?B?d1NrVFp5L2xSOTYvRzduOU8xMlZDWVNBN3BONHIrelNlcjdrNktpdEVpVFNE?=
 =?gb2312?B?b2laRGZRL2IxN0ZWckNzYjhSQXduZ2JlQllEL1hNajZQOWNBcU5HZjR4Wmgz?=
 =?gb2312?B?akhvWDAxd0Qwa3VQR1p1YTcyS2RYZDJTa2FpWVI2dldMYjdxS3FBLzVWQUNa?=
 =?gb2312?B?b0UwWEZTUkUzdjUrUVBkRytUTmZOMWR6MXFFbmVOQmREK1BaNlphdWIxTits?=
 =?gb2312?B?MHVqeEl4NEFpYytOdGkrWmxpVmhMbzRrd29DODh5cE9veVo1c0tQNVJXT2cr?=
 =?gb2312?B?VUFpbEEwR3ZRWUxQcXpXNlVFWmo2T0NpdS9ENWNwVHZzcGZyYU4weVNnMFhx?=
 =?gb2312?B?eFEvOWRJa1lDY2gzOUpWTDdSV1BqWWQyenEvVUtSSm9DUnVBTStrdnUxK0Vw?=
 =?gb2312?B?bUZxR3hHbjhNdnVMMTZ0c2s1RERibExkWlo0Z1JmWXg5K0ZlM2w2RVZIeE1J?=
 =?gb2312?B?TWVjYXd1REY5RExiT0ZCMjd5c2FUV3BTQ1lBM1h4ZGFyYTc3Q01qc3hPYkJW?=
 =?gb2312?B?RzdvQUtkOTYzRlMxYjZuZzhPamhNVnh5d095eWtIc2hxNmdrdnNGZGtrdFJp?=
 =?gb2312?B?YTBpcitOeU1lOVhNVko0UlhLMm8yRW9obUtDR0pkNHd4cFdNNnY0RlFRVTZa?=
 =?gb2312?B?WTFJc0ZZWG81TnNhWDhzTndtdWZSN1ZPZGs3Lzd4eXlFSVhkQjR5a25aeC9i?=
 =?gb2312?B?TFByaHRxT3d4Z1Y2K2pjanpjOGRCL0Z1Wkw0UVllNi8ra1FmSTV4bnNqSnUx?=
 =?gb2312?B?OFNOK29GZ0xMUDRCU0tiVzNkSnkxTmlvc1U2a1VJZHdLREh2bnBBbWJ1U2Zm?=
 =?gb2312?B?SFRZZ2UrK3B6ZGk4RUEwK3BpbmVLQ3NKdFJ3TkUvMy9FM3VxNlJFQUx0TGxw?=
 =?gb2312?B?aFNyTUtXZHpkN3NVYldybktZQVg1N1p2Zi9CUjlneXZVNE9lczArWDRvaFpn?=
 =?gb2312?B?dGZxK0hxdXZTZU9SVzREbG5WazlmTDAzb1lnUE5tMjFqTjBDUE1oSnUrTURI?=
 =?gb2312?B?cXFDN3VHRnlqSkM0c1ZmZ29OQ2dzV0tIRmhmLzE1a1ZlQzdMVW0ra2N1WWNY?=
 =?gb2312?B?elBJOEFOUVptREY0bWRsVjd4NWl6cVZrblFUNzcrMDREMU5NSjI2MEVzeVp5?=
 =?gb2312?B?QlBZbFpacWxEQ2RqRkJMTG9laGlXSmJGOWJOQm90cUJhaXVLVWh5MzVva2l4?=
 =?gb2312?B?Z2hDT3JqVldxckdhUDJBaUF2M3ErUEl1SWE4SFRqR0hUbEtkZmdJN3J0V1d1?=
 =?gb2312?B?NUdzYkdaSWxNWk1PQUlOUzgycmxzVjJGdDI3TC9ndFlyNkI3eWdqeVlKZjZT?=
 =?gb2312?B?dUtJVzB2clQyQVlzaDlNWnU4ZUYzVG5oam5ZUGZMazdvZ0xFcnBKU2JHdTJC?=
 =?gb2312?B?eDRBR2VJUnZJRUVKRWswQU1tZEpDc1dEVGkzbzltSTFkQjc5K29QUk8xNkla?=
 =?gb2312?B?T0h2ekdoc0Zvb0dvb1VQbm0xek44aWdHaVBCWVRuSXUwT1FTdG15UGJjZkox?=
 =?gb2312?B?MXVmK1hwUjRxMnV4Lzdwekh3ZElacU0wV2NqcElSd1QyV0dNMzQxckd2bHRh?=
 =?gb2312?B?cDllWXpQdU56Y1h2d0RLd2EzTUxzSmJkaE5sTE55QWV1Uko3TWw2cHpCMEdR?=
 =?gb2312?B?d1VMT21KS2d5eHN3TDBSUmFXVHFHYXhpOU8rTGRTaXZpL0ErSER5cW9kVFpC?=
 =?gb2312?B?OWdUR3NYSmtnMmtiNWdVaDhLaHE5eWZ2QytuRWpTTXdDTkxrdHBkc2Z2NXQx?=
 =?gb2312?Q?PKEG3EWs/rkjSe9UooqdX0tkJ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6278.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f680e4e5-a4dc-4bfc-1f92-08dbfb1ed9fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 14:30:12.7384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pcP7uEZBSjG2RCCf0k1M7AWpPFSU+wGJPwRTPZP5S3N1HORx60FI9/PXjorc6yOGBFnK4ZlpBcbcf0X9AZ/VQI3kkLBVxZTAJsrESo8FZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6260
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBtYWludGFpbmVycywNCg0KPiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBKb2Fr
aW0gWmhhbmcgPGpvYWtpbS56aGFuZ0BjaXh0ZWNoLmNvbT4NCj4gt6LLzcqxvOQ6IDIwMjPE6jEy
1MIxMsjVIDEzOjIyDQo+IMrVvP7IyzogaGNoQGxzdC5kZTsgbS5zenlwcm93c2tpQHNhbXN1bmcu
Y29tOyByb2Jpbi5tdXJwaHlAYXJtLmNvbQ0KPiCzrcvNOiBpb21tdUBsaXN0cy5saW51eC5kZXY7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGNpeC1rZXJuZWwtdXBzdHJlYW0gPGNp
eC1rZXJuZWwtdXBzdHJlYW1AY2l4dGVjaC5jb20+OyBKb2FraW0gWmhhbmcNCj4gPGpvYWtpbS56
aGFuZ0BjaXh0ZWNoLmNvbT4NCj4g1vfM4jogW1BBVENIIFYxXSBkbWEtbWFwcGluZzogU2V0IGRt
YV9tZW0gcG9pbnRlciBhcyBOVUxMIGFmdGVyIGl0J3MgZnJlZWQNCj4gDQo+IEZyb206IEpvYWtp
bSBaaGFuZyA8am9ha2ltLnpoYW5nQGNpeHRlY2guY29tPg0KPiANCj4gUmVwcm9kdWNlZCB3aXRo
IGJlbG93IHNlcXVlbmNlOg0KPiBkbWFfZGVjbGFyZV9jb2hlcmVudF9tZW1vcnkoKS0+ZG1hX3Jl
bGVhc2VfY29oZXJlbnRfbWVtb3J5KCkNCj4gLT5kbWFfZGVjbGFyZV9jb2hlcmVudF9tZW1vcnko
KS0+InJldHVybiAtRUJVU1kiIGVycm9yDQo+IA0KPiBJdCB3aWxsIHJldHVybiAtRUJVU1kgZnJv
bSB0aGUgZG1hX2Fzc2lnbl9jb2hlcmVudF9tZW1vcnkoKSBpbg0KPiBkbWFfZGVjbGFyZV9jb2hl
cmVudF9tZW1vcnkoKSwgdGhlIHJlYXNvbiBpcyB0aGF0IGRldi0+ZG1hX21lbSBwb2ludGVyDQo+
IGhhcyBub3QgYmVlbiBzZXQgdG8gTlVMTCBhZnRlciBpdCdzIGZyZWVkLg0KPiANCj4gR28gdGhy
b3VnaCB0aGUgZHJpdmVyLCBmb3VuZCB0aGVyZSBpcyBhIGlzc3VlIGluIHJtZW1fZG1hX2Rldmlj
ZV9yZWxlYXNlKCksDQo+IHRoZSByZXNlcnZlZCBtZW1vcnkgaGFzIG5vdCBiZWVuIGZyZWVkIGJl
Zm9yZSAiZGV2LT5kbWFfbWVtID0gTlVMTDsiLiBTbw0KPiBpZiB1c2VyIGNhbGwgb2ZfcmVzZXJ2
ZWRfbWVtX2RldmljZV9yZWxlYXNlKCksIHdpbGwgbm90IGZyZWUgcmVzZXJ2ZWQgbWVtIGluDQo+
IGZhY3QuDQo+IA0KPiBGaXhlczogY2Y2NWEwZjZmNmZmICgiZG1hLW1hcHBpbmc6IG1vdmUgYWxs
IERNQSBtYXBwaW5nIGNvZGUgdG8NCj4ga2VybmVsL2RtYSIpDQo+IFNpZ25lZC1vZmYtYnk6IEpv
YWtpbSBaaGFuZyA8am9ha2ltLnpoYW5nQGNpeHRlY2guY29tPg0KPiAtLS0NCj4gIGtlcm5lbC9k
bWEvY29oZXJlbnQuYyB8IDggKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2RtYS9jb2hl
cmVudC5jIGIva2VybmVsL2RtYS9jb2hlcmVudC5jIGluZGV4DQo+IGMyMWFiYzc3YzUzZS4uNjAy
ZTA1NWZjMWJmIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvZG1hL2NvaGVyZW50LmMNCj4gKysrIGIv
a2VybmVsL2RtYS9jb2hlcmVudC5jDQo+IEBAIC0xMzIsOCArMTMyLDEwIEBAIGludCBkbWFfZGVj
bGFyZV9jb2hlcmVudF9tZW1vcnkoc3RydWN0IGRldmljZQ0KPiAqZGV2LCBwaHlzX2FkZHJfdCBw
aHlzX2FkZHIsDQo+IA0KPiAgdm9pZCBkbWFfcmVsZWFzZV9jb2hlcmVudF9tZW1vcnkoc3RydWN0
IGRldmljZSAqZGV2KSAgew0KPiAtCWlmIChkZXYpDQo+ICsJaWYgKGRldikgew0KPiAgCQlfZG1h
X3JlbGVhc2VfY29oZXJlbnRfbWVtb3J5KGRldi0+ZG1hX21lbSk7DQo+ICsJCWRldi0+ZG1hX21l
bSA9IE5VTEw7DQo+ICsJfQ0KPiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkICpfX2RtYV9hbGxvY19m
cm9tX2NvaGVyZW50KHN0cnVjdCBkZXZpY2UgKmRldiwgQEAgLTM0OSw4DQo+ICszNTEsMTAgQEAg
c3RhdGljIGludCBybWVtX2RtYV9kZXZpY2VfaW5pdChzdHJ1Y3QgcmVzZXJ2ZWRfbWVtICpybWVt
LA0KPiBzdHJ1Y3QgZGV2aWNlICpkZXYpICBzdGF0aWMgdm9pZCBybWVtX2RtYV9kZXZpY2VfcmVs
ZWFzZShzdHJ1Y3QNCj4gcmVzZXJ2ZWRfbWVtICpybWVtLA0KPiAgCQkJCSAgICBzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ICB7DQo+IC0JaWYgKGRldikNCj4gKwlpZiAoZGV2KSB7DQo+ICsJCV9kbWFf
cmVsZWFzZV9jb2hlcmVudF9tZW1vcnkocm1lbS0+cHJpdik7DQoNClBlciBteSB1bmRlcnN0YW5k
aW5nLCB0aGlzIGNoYW5nZSBtYXkgbm90IG5lZWQsIHNpbmNlIHRoaXMgaXMgcmVzZXJ2ZWQgbWVt
b3J5IGZyb20gZGV2aWNlIHRyZWUsIG9uY2UgY2FsbGluZyBvZl9yZXNlcnZlZF9tZW1fZGV2aWNl
X2luaXRfYnlfaWR4KCkgdG8gaW5pdGlhbGl6ZSwgaXQgd2lsbCBiZSBhZGRlZCB0byAib2Zfcm1l
bV9hc3NpZ25lZF9kZXZpY2VfbGlzdCIgbGlzdC4gRXZlbiBjYWxsaW5nIG9mX3Jlc2VydmVkX21l
bV9kZXZpY2VfcmVsZWFzZSgpIHRvIHJlbGVhc2UgaXQsIGl0J3MgdW5uZWNlc3NhcnkgdG8gdW5y
ZW1hcCBhbmQgZnJlZSBpdCwgc2luY2UgaXQncyAicmVzZXJ2ZWQgbWVtb3J5Iiwgb25seSBuZWVk
IHRvIHVuYmluZCBmcm9tIHRoZSBkZXZpY2UuIFdoZW4gd2UgY2FsbCBvZl9yZXNlcnZlZF9tZW1f
ZGV2aWNlX2luaXRfYnlfaWR4KCkgYWdhaW4sIGp1c3QgbmVlZCB0byBmaW5kIGl0IGZyb20gdGhl
IGxpc3QgdGhlbiBiaW5kIGl0Lg0KDQpSaWdodD8NCg0KSm9ha2ltDQoNCj4gIAkJZGV2LT5kbWFf
bWVtID0gTlVMTDsNCj4gKwl9DQo+ICB9DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCByZXNl
cnZlZF9tZW1fb3BzIHJtZW1fZG1hX29wcyA9IHsNCj4gLS0NCj4gMi4yNS4xDQoNCg==
