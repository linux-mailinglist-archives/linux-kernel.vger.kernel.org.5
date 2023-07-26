Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB64763776
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjGZNXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjGZNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:23:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5FFE2;
        Wed, 26 Jul 2023 06:23:07 -0700 (PDT)
X-UUID: 8c7d25b22bb711eeb20a276fd37b9834-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HZrXd0EJ7pGpfOVrYxPwku1jvpwdy4yz2Me+SsrBl6o=;
        b=Hqr5n8ocpLfNaUIGTmVqGL70tZPRacfdZBj8GGpykOqTnc0VW97iUrjctrPVHSly+nUBs4sW1n3D/cI85G01UJz+WZuIdwC7WuEmBYBjTn+l8XLF7eGN5L5goEK9bfGXtyAetAgnB3+6eldMfZKPwLg4WPr+JII8cEwZZabf4Wg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:32a5c5e5-7db5-4a43-beb6-7d0f23ce33b0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:71577b42-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8c7d25b22bb711eeb20a276fd37b9834-20230726
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 273110113; Wed, 26 Jul 2023 21:23:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 21:23:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 21:23:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksLZYWRXRAr8itVqA5U4IxEXhiEmJa9uCet99OdMMh3intgBnIRF4yWon5Lw9A0tM0H4obiNoKxhJ/vFmGdGRnNoGQ6cxHT9AwJpI3tbhr0PQLomKmhGKncwvt/CzeEon6kITgt7DxuVakJg62KXmKMKLZlT4JQyoNAJH8toI94KBucsA9cjX2kqs0zifrFQsNZ1zgON2nic+DF7/6VBfqPcgzNG+U7NH+w31LHtrmN/zLahsxDddTY72bMSBk5wlEAzZhCwYcY+mIO1a0vIWNtUme3mVLiCCHOdVeq2vWQRg8ZVEFpz8iveQrIPasEnHM941D5J9FCGhKdGyjRNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZrXd0EJ7pGpfOVrYxPwku1jvpwdy4yz2Me+SsrBl6o=;
 b=FAp5oDEUl66+TpOzFw8P/TnCjibF1gvsC5AVKCBnZsrzCXJCU+FT6NQxZl0kqyIJaQtrrvYpiS8ydZwihLL88EwIItOVqV6ei3OSH+Ad51SD4MN90k9bw8vOx3n3d9EwxHuPelca8S1i8xqc4o4Cm4SjVQa+iT0Byu4GlYED64PujeemYwNa3iX3z13YteM2nZMiZU+Hw0HXAE0fKk6WVWkw3b9Jpfx0J/IEImzGpFx18IkbbqCy1IP8jH1GEl8YJJjuTwZpqdoqi7EG/n+EGfBRVZBvYEksJJNeRF7ta1ZASf+9Cep/Vtb8LAz3Dv8ZKZtgcKs/Er8g5plyKehPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZrXd0EJ7pGpfOVrYxPwku1jvpwdy4yz2Me+SsrBl6o=;
 b=n5mYnkEUavqKEqYqRocY3XU/b0JeoUs5UDv/HUfu2GVUwcoFmJaVARjMtfxYQkYEvMScNkYnpKS5yCjQKv6Fy7xHJ94thEWQRvzQDR3SySWIJ+rbp8QRpWz17a2Q6czC5sHLusVmfxVKWJw8+q1og7zChfat+zwVc7uletYZDkg=
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com (2603:1096:301:b4::11)
 by TYZPR03MB5328.apcprd03.prod.outlook.com (2603:1096:405:5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 13:22:59 +0000
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::d7f2:5c66:dbd1:77f7]) by PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::d7f2:5c66:dbd1:77f7%7]) with mapi id 15.20.6609.035; Wed, 26 Jul 2023
 13:22:58 +0000
From:   =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Thread-Topic: linux-next: build failure after merge of the mm tree
Thread-Index: AQHZv4ApqwzMAhDEjUSNBgpmt8Q7M6/MCZSA
Date:   Wed, 26 Jul 2023 13:22:58 +0000
Message-ID: <bb47ea0fad0904f3beb74764dc7f7e58c9cd5a8e.camel@mediatek.com>
References: <20230726151446.1fc68a86@canb.auug.org.au>
In-Reply-To: <20230726151446.1fc68a86@canb.auug.org.au>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5964:EE_|TYZPR03MB5328:EE_
x-ms-office365-filtering-correlation-id: f2d61fea-ba11-441e-3762-08db8ddb6e0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sx6+rE6TBgL20D1Bi2Y8hAI3rg/MIX2mRDhSQAs3jqvkj1FYQ4CdwNtHV/K7HY3rGhe8gRQhiqHkHtDspfavOZfm8icG8KEGUXjrLuxi15KfIlwTeV7QMI/xW1oc93SShpc4XM4aXf/AMuseZKehdxvhU9KcU5tON8Dpjyr3kF9U4NrrDphaMojH4wtKhuyyz7m2E5SgiKg555O6BlB3NwzaLcJxWhe3iTV38QLywpaQC/uo4HTEB+eRFXFiO0tyf8IK748I7mG1UD6JEiEtAaWY5mDsoQArikiJ1AB0Ad6WHdZ3mf470i7xvbybLmGUMPD/plgrGwB1OxpCpPzODTtWN8qab+4yTZeGfdETaH2bQzplLYrswZQj82+KW5+++Ou4L3p7T3zaxznMNZsRZVfU7iR5uWPyMQruC0mk8WXqubWH0o+Y38dWKiOaw+ai43GdHTQBLF3ivKWFoqF2uKcZqw6tyv6TzyPXUn9zbul0nDZs8GnPNSPkYQQBIPQDaYtuZ10skwCqbk90rxJWPHYJ8qbWdLBdD9TjL+E9KhQhKbg+LKXGqtB3WbCtokz6FRtHZolBM2gJI4pOjpUxrWM7Y7XEM6K6pmIpjomU/pBuAR/NN80TK3EMoxGxsFrCNFF1vJQtv26or1fIkuzwdFFJUXznvgtlGM+VFrG+aKCWcIAfSyuKU2raj5xuEKFn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(110136005)(6486002)(6512007)(478600001)(122000001)(54906003)(71200400001)(5660300002)(41300700001)(64756008)(66946007)(66446008)(4326008)(8936002)(91956017)(2616005)(66476007)(38100700002)(66556008)(76116006)(316002)(8676002)(186003)(6506007)(26005)(86362001)(2906002)(4744005)(38070700005)(36756003)(85182001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3IvUlo0aXpBeW5SMlpyU2VxWHhQTU8rV0kreUc4dExySm05TXdRU2JhTFdw?=
 =?utf-8?B?UFFtWUtGK05HL2Y2TEg3cmh4cXBwbk0xQWZhdTBFSXhTaUYxNTlSdTRhSk04?=
 =?utf-8?B?dVJhdEVaYkhYMWRlMGtIckkrM1U1RUJqOEdSMFA1TVZNcmdLZjFDVnQ4amd1?=
 =?utf-8?B?ZFhXZVNKTC9iUzNUUU1jY0YrdHIxbnZ2TXkycmJXTjZRbWdJeHcyT3ppL3dv?=
 =?utf-8?B?SXlEVjN2Sk5zdEtuajhuR05xU1lINUwrbjNJSUU2NHAwWTNzTkVRM0k5UmJE?=
 =?utf-8?B?aXpjQXhiSW05aVgwR1JubVZwVS9HMTFMelVTamViOEN1NTYxTTQvdzNyVTdk?=
 =?utf-8?B?RkxjL3JzdVBtOTBsK1ljZDU2UkV2enQ0N2Jzb1M4ekZGbWZnQXZGeVpTbm5j?=
 =?utf-8?B?R0ozMnlWTUdsNkhjV1A1amt3T2kveFJzWStPa0J6UlJXSUIvVDVlcGVYU1Bk?=
 =?utf-8?B?VVYvaHhWZVdpL0Ric21YYUR2U29xSTluSWpNUXFXSFNlWHhoeEtaT2kzZ253?=
 =?utf-8?B?UXczWjFiWFMwT0VWUDBVMkNNRC9INHN3Ny8yeW5XeW4vQkwraEhndjFVR3pK?=
 =?utf-8?B?c24wekJUai9ucFhOb2l4elZXR0JWQVdMYXdGWGdnTFpuOTlTc2phWG01TEZr?=
 =?utf-8?B?ZXJXNGZPeTlmTDJQREF3Q256REJES0V5V1hXbkVaNWs5WnR6VHVUVDZBUk1z?=
 =?utf-8?B?cGNVMllLU21RQ0Z6ZHVXZGYxWDdvT0grWTdFTURqdStKU2hyakpMRjdYaHhW?=
 =?utf-8?B?clNPdVVWakxnVlVqb2phWGpjVC94blRvcW1CWkFsdG8xSjFIRnZOVEVkV2U0?=
 =?utf-8?B?c3NLL3plS2hDeHdubWIxUlJleHBwaFRQQXJqZk84KzBtQmN0eXFXV1Z5dDdI?=
 =?utf-8?B?MXFyZjJJOHlTa0FveTZFenRTN2MxODREK2tzTldNTm1VaVpiQzl6VWpkS09C?=
 =?utf-8?B?NGF1c3lxN01acElFZU8rN1RVWUFGaXczY3p3aEoyRllXSW1odkFzcTlOdGJ3?=
 =?utf-8?B?cTFKbTJJSG9rUmVZYzEwK1VkUjZMcWhtNjRnWEQxV1MwMlBaSFYrTUszMERI?=
 =?utf-8?B?MXZ0aTJSQXRvTnhadG9hWDhPYmQxVzJqNGtBRXBmQmlLeVdLOHkvcHN2MnpP?=
 =?utf-8?B?bTNicnZXZkhFLy9JZGYweDRMeHpSOUhKV2h3VzRkTUxkUVo3NmpIUEZFRkhq?=
 =?utf-8?B?dU9QWEhVbmxIRUFqaTdNOEgrUUVxeHJUa094R0FvU2tOMGJXTENhV0xNYlk5?=
 =?utf-8?B?VFpwaDdKeCswQ3Z1WmtHZTZCTUN6cWtqcHpsZDlibkZlbERrc0I2ZC9icGpJ?=
 =?utf-8?B?VXpDYzR1dmdWZmVHVTFLeS9yU1N6dmRmK1lyTU1CZWFEaTJRbmZPV3FKby91?=
 =?utf-8?B?S0RiWkJXSDJZbnh0dUxnNDNSblUvVThFQkR0eTgzU1NqUGlGWWJLU0s4YUd6?=
 =?utf-8?B?aXprcG9pV0s2ejdMNFVqTS9mWU5JbzI4RlFjOU05Z1dxY3VRUG90WG9jRlNL?=
 =?utf-8?B?NHZBOEZMWXQ3dC9nTHlwWGM3RjhiNTlQaWQ1ZEFrU3ZaYm5oMitiOHJGVm1t?=
 =?utf-8?B?aW1ZYzZ2NXBmczZoWWpxcVlGUlVnMkhrdnRubVc3UWl5dmRoMjczN0FkV3FZ?=
 =?utf-8?B?ck5PZE04Tms2NlV0NG04RGxIek9qRkxmUEw5L1o5R0lJT3BudEJLOHQ3U0RG?=
 =?utf-8?B?R3ZZTC9EdjZvUm1VUXV4eWpmU29RU1BFNEpLZHFoWkg4NmZQbnpZYmQ5eUtk?=
 =?utf-8?B?UnB6SGFIbGZwTHhrdHpIR1ZEQ0Y3LzVxZ0hna1ZFekxXcnphaDd1OUtEYlRv?=
 =?utf-8?B?Y0gxejQyd3pzUmo4V0dtSXpDdWorYnRpVjhHK01DNURmT21FVXBsQlhvV1Fn?=
 =?utf-8?B?UFRvUWIwcHQvOU9qdkZFblRGTm1lUDk1SVdkK2J0a2NZekEvd0pWZFdPVjQ2?=
 =?utf-8?B?TlNlcFdtbEEwYmVoVU9XakNzRTZscmNpd2s2ZUVlYXhDOE5XbkRMUjlQRVV6?=
 =?utf-8?B?cDNCRjBQV1BwS082M2huLzYwZ1dUZThwRnluOEdsVm5Oa2xPSU5VVDBpdUNG?=
 =?utf-8?B?YTZENllRLzNDQ1FkYWk3U01kdXFEL3dNNllrMWJrK3E5V0x2OXg4Mjh5dERL?=
 =?utf-8?B?a2Q1TGEzN3NQN0RZOGM0bnhVMVJLY04zTXRWSlpuYWM3RG4vU0JLTDMxVzBP?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C7548160F2F4B4298DD848595C9F61F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d61fea-ba11-441e-3762-08db8ddb6e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 13:22:58.6376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBn0HNWfh0LczCpg1eknNHgAoErJwYoemMV9MDHjwvZQfa6/AvImxWp2l1zIDLuTGU5GKblu6hDquVMmN6nWF0qLCFBbaj8uv4akhFBGa6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5328
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTI2IGF0IDE1OjE0ICsxMDAwLCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3Rl
Og0KPiBIaSBhbGwsDQo+IA0KPiBBZnRlciBtZXJnaW5nIHRoZSBtbSB0cmVlLCB0b2RheSdzIGxp
bnV4LW5leHQgYnVpbGQgKHMzOTAgZGVmY29uZmlnKQ0KPiBmYWlsZWQgbGlrZSB0aGlzOg0KPiAN
Cj4gc2NyaXB0cy9nZGIvbGludXgvY29uc3RhbnRzLnB5LmluOjI2OjEwOiBmYXRhbCBlcnJvcjog
YXNtL21lbW9yeS5oOg0KPiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ICAgIDI2IHwgI2lu
Y2x1ZGUgPGFzbS9tZW1vcnkuaD4NCj4gICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+fg0K
PiANCj4gQ2F1c2VkIGJ5IGNvbW1pdA0KPiANCj4gICBkYzdlNjZiOWM4MmEgKCJzY3JpcHRzL2dk
Yi9hYXJjaDY0OiBhZGQgYWFyY2g2NCBwYWdlIG9wZXJhdGlvbg0KPiBoZWxwZXIgY29tbWFuZHMg
YW5kIGNvbmZpZ3MiKQ0KPiANCj4gSSBoYXZlIHJldmVydGVkIHRoYXQgY29tbWl0IChhbmQgdGhl
IGZvbGxvd2luZyA0KSBmb3IgdG9kYXkuDQo+IA0KSGkgU3RlcGhlbiwNCg0KVGhhbmtzIGZvciB0
aGUgcmVwb3J0Lg0KDQpBbmRyZXcsIGNvdWxkIHlvdSBoZWxwIHRvIGRyb3AgdGhlc2UgR0RCIGNo
YW5nZXM/DQoNCkkgd2lsbCB0cnkgdG8gZml4IGl0IGluIHYyLg0KDQpUaGFua3MsDQpLdWFuLVlp
bmcgTGVlDQo=
