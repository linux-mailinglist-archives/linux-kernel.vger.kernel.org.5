Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177A27518A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjGMGLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjGMGLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:11:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79951BC6;
        Wed, 12 Jul 2023 23:11:08 -0700 (PDT)
X-UUID: 0af60928214411eeb20a276fd37b9834-20230713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pxiNdQyjHbnE+pV5knlBPgYKp9tlSBniVoOje69XH+M=;
        b=OIV9c7rf/s6BO28xZ25ItM1gjm33S33IYiOix65gx+3fS/f7O5o+ZSNU68E3eDyAJDA6zlUOZ55OZ13f/weeHtfWym1+qSftduqM8kBu7KpbtkxWnMy0G0BHUZfRIGkrmLe1hsRIlZX4m/m2L7+opCnYlRNn2MWHRTzxGFezn5g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:9d34f714-7176-4665-8442-84d139dd76da,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:5dfc2d68-314d-4083-81b6-6a74159151eb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0af60928214411eeb20a276fd37b9834-20230713
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chris.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 607520260; Thu, 13 Jul 2023 14:11:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jul 2023 14:11:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 13 Jul 2023 14:11:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qb3svoVz9umfuqZgIb+34X/57qqcIWLOiOPGgI09R987FRTp3+t5+iN0UQEWSb2Vg0iZT6uwre29CZf+uM0TrOzpWEaOSerm2fc68a2kns3TJyTVWO8UPLAe0jTTlflZi6Dq2dhUj3cAgLl20aNZ11urytM5x+Cj3kr6ZL29QRznYeEj+xMViPZikQ/J2jbOEHs0eNUT+CZyyUbnQ5/8rJX1HMnGu1ZJRKb5B82nVexC2erZ329hjF0noE3JBFhtV6NTgnAayTl0aHBCPtk9+9+Hf/om7Vz2ZcSeaSPvFsJDYn/kQMSzLwVwFiAd8D9vwlgstmYB37EVLEr7gFq6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxiNdQyjHbnE+pV5knlBPgYKp9tlSBniVoOje69XH+M=;
 b=fxxnxIiRoevIH9DXrjpMvWcu/coAKVr58gXIyVYZX6yXRg+BBWzgdh6LljPd5bGmIBz2i4zusbvd+l39awLJcG/FBCyMKPzBvWrg8JvtC58UAYqAwMsEpR5fzkTIqIEPqhRcdoQ+Gk0fEWrRKjjgM3SebQcmqbgGguO3ZRqIyybhLvswjJd96N5aNszzAKHf4erV9nHCNzyK5A6HszYdqC71SHqbK9aNgkh3waBBSLso43e+g+yBM6ram5brEnFY1DGxwGSIuG8h5VwON1H5Lqqea5qgiPs452Sn/F+BnCU8iSAaZhfEvTdqM1yInXNfT12ohPsYqOVWT0mVh5BUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxiNdQyjHbnE+pV5knlBPgYKp9tlSBniVoOje69XH+M=;
 b=SZ9WeweAoUxrm6Cbe42R58q7HlVi5bsiLorRsN6DSjyTarNfcXsm+gtT0UOwaRfVY++XY2/zdqOomaBBwQU4vNQmttc5L/+Z6FETLtWBELtlUeZTsXNfGz8K9izDuBkfT/Jb3eHp4Fsh6TMEi8wAjjmoDSrjD2gNGsAxsy6bF/s=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 06:10:58 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::8dfd:d707:163c:f0e7]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::8dfd:d707:163c:f0e7%3]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 06:10:58 +0000
From:   =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        =?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>
Subject: Re: [PATCH v4] Bluetooth: btmtk: Fix null pointer when processing
 coredump
Thread-Topic: [PATCH v4] Bluetooth: btmtk: Fix null pointer when processing
 coredump
Thread-Index: AQHZtME708mraD2/6kWl8zNvlfyhj6+2lbCAgACiYIA=
Date:   Thu, 13 Jul 2023 06:10:58 +0000
Message-ID: <97c0ef9580415d56086230761c5d10d392f58add.camel@mediatek.com>
References: <20230712130218.376-1-chris.lu@mediatek.com>
         <CABBYNZLoJtUpAR-yKpq9a1NCTjhdgWMNSdwGd7f9jtFR0LuEAA@mail.gmail.com>
In-Reply-To: <CABBYNZLoJtUpAR-yKpq9a1NCTjhdgWMNSdwGd7f9jtFR0LuEAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SEYPR03MB7682:EE_
x-ms-office365-filtering-correlation-id: e7175bc5-8036-4b74-f1fc-08db8367ecec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xikUsagq3rB3rGey1QtmBJfj50w2h4CGGcHMR5hhahC2TDmKwFt/oq5wbPsCTrbsbmfwGXWijmfJNvMYEHAfSFrQMlyLd0+KeNPD/gt5t/vE5pbsgbXg3d2zGrUvLhUW0UluLr9qpHZpWIf3abrpq3wwY68fAUcs4ECOg3b1WnCKYL2HgI0Cy7OhSeSmZjueye1h0FK4p2m0KatYYo/81XZERWB5URLxNVMwYnu09EthdzRdix6+cDpYB/A2gIhj5x7RQeDCj1D56Erc0jRhrJNbEV0YKdKppTnhLOPPBPgjI+Lior44Vt3SfEehXFM3AMBGgNpKYRWepYlntXtPQDdAP2oiS+ZcIqDhMir3HsiL0TQHcfUYUIMkafmG9ixqd6m14bep9zsrbX79cE/Wab7oC43uG9gtDd1D+rj4JeynmzNAFTy++9Ja/fNVT9kQ0SjIYviAZ2m63aL8L1myZD+UNuibmea/2sVRyiJ/6I6AykbvtJVfncYEW0H/idZd5DZpLbz3xz3+4+lQoF4y1dNnUZS62Ap7TlMbLCgRIgjgxeQFmecduKqWZ/XMz6cwjxEgsSS3LWxIib+ZW9WUnOsSbyS2H83WobpqhSnrWwBTHyTx1LaGj8veesziKboDeff9Eti9HOEBeJ5zRJ2E0usigWJ8lbh5nFovGZY/YSQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(41300700001)(316002)(5660300002)(6512007)(26005)(36756003)(85182001)(107886003)(53546011)(6506007)(8676002)(38100700002)(8936002)(83380400001)(86362001)(38070700005)(186003)(2906002)(2616005)(122000001)(71200400001)(54906003)(478600001)(4326008)(6916009)(6486002)(66476007)(66946007)(76116006)(64756008)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ylp0ZkIyUnk2UE9YMFlBZUNkV2owNnVFTkduYWRmMDZRMzZIbktsdEZZNmhB?=
 =?utf-8?B?UXlKa25sWFRRYXRVNmc3YVJsSCtuTEdlS01ub29ESzFqajNaOWlwVkRZaGRt?=
 =?utf-8?B?SHJaWjNKYjU4b0JlbEQrQkpYTWtNM29Bdis0d1BTZmhYYkV4ek5nUU83aDlG?=
 =?utf-8?B?d3ZKMS9DemNXeHNZWVBQaWduMTFGdXNWK0EvcGwwZTJNUTRCTlhSMVd6Vis2?=
 =?utf-8?B?dXJyZjlUeWwwRmtGSExqcWs5RVhyanpQNmc5MWREd01qQnVKanordzZVSnNC?=
 =?utf-8?B?elpDUWRyaCtyaUVyOXozbEtEUUhZcmtWSUpScFQvQXZrbWtlTUM0eW4rSllr?=
 =?utf-8?B?bi8rLzVadDNoVFZ4aEFrc2c5OUVOK0I1SkZoMFU2VWpFeFgwSTRWSkYrSi9w?=
 =?utf-8?B?R1YxQlF0TUtLbWpFQmxaeDRUTHY1dUdLeTZaSnJzdWtvNlkrcExFQ3E5NEI1?=
 =?utf-8?B?dUI3U3M1ODFBZ05tMEUxdzJRa3VDT3pmckNlWEt0VHNCTXcveDdkUmlhTm9U?=
 =?utf-8?B?ajIzaWl4cmxheFRsTHFqdVAya0w0ZlVxUHlZUjhHTFNZSmFpYk52ZjBScnRV?=
 =?utf-8?B?QzJvSGtWSi9YRFF3S3hTS1dNWVF5YzlGWHdBR0pGbUlQWGY2OUZWR0ZTU0pC?=
 =?utf-8?B?V1kwdkFHZ211WDZUZUVVcWU3TVVMUzZXTG51REFXUEIwYWs1ZTZIQTkvME9n?=
 =?utf-8?B?ZWVhbXVYamdvTm51ejU0SmErVjZwenc3Rzh0eVRkeVVMZ2xqNmVtREF1YmFD?=
 =?utf-8?B?NWVCY281WEhESnVWbUlBMXhZREtzZjFPb1IzWkpGWDdYaS8wVWgzREtVUCtN?=
 =?utf-8?B?ZHdXRnVWTEN5VVBZbVBnTGlmT3FmQnIxTjV1UDJBa3pwR2NjNG9iUFFWQzVB?=
 =?utf-8?B?WkVOY1h5cHJsODQ0M2ZlVCtqLzFESE1OTFJTU0tmS04yZUlrVGxCY1FzWVJz?=
 =?utf-8?B?bXI5bFZxTWNmSnIzckZLSXVMaHRSMHRXLzcxdW1EbTdoMUZRVFJpRG1qSTUy?=
 =?utf-8?B?dlE0WW1PaVl2cEUwSForMUN1YXhZVzZhVVNCeVY1a1RvblhrZUVlOXZCZUFT?=
 =?utf-8?B?U2o5MEFzalZnV0RuMVRJUEwzQVBYOTQzaG1QVFVuT2MvVjhqdzEveThwV2Nr?=
 =?utf-8?B?WlYxTEtxbjFaZmhFVVoxTUorQi9INWt1SlRSNzBKemZZTUVLbnVYekNHNnRQ?=
 =?utf-8?B?dExhY3JWeGgySXhCYnpwQVZoZEpxc0F4eGI1V0RVZlh0VHFBVWZTQk94bmd6?=
 =?utf-8?B?aUlBaFpxTW9yRFkyQWNXU3B2eUEzRW42RHEyZTg0OWlvaWdJLzhFNmlNMUF4?=
 =?utf-8?B?VVBadkxIaHR4WC83Uk5ST2Q3RkFmWVZFQ1puSDNpNktMZXJiR2pyajh3bng4?=
 =?utf-8?B?TU8vR2ZyNDhXWGJGbnR6VHpwZ1FjUHN1dElaMVZDaGIyNUUwZm8rSnloVEhx?=
 =?utf-8?B?TzMzc0Q0WVE2SnhjbTRQa210MDBBWjJENVFTQndNY3VQalkyVk5WVncxbmZo?=
 =?utf-8?B?NWd5cGxnSTQ4cjc0Rm1YV2pxbHZNZytRbHVKTFJlMklGaU9kUytpWkNab3FH?=
 =?utf-8?B?dEtQRmpIWVhTYjdjS0ZFSkNGa2RsV1JVTUNiL2NnY0x1WCtnZllERFV2Q0xo?=
 =?utf-8?B?bWpPV2M0akVwcUR1cTZvWlgzbnJwVGZIYUQwbXhydDNvOE1oVVNUaUVad2h2?=
 =?utf-8?B?d1owc1lubS90K2hwdXcveGkrRU5tNTdubnFZS0JhcE9FaHBsc3A1ZTlFblV3?=
 =?utf-8?B?V3FMUDlwUWsvMEJ2LzlIK29CMTJyMXNidGovSnhHQUZWY29GSUFpd1EwNGkw?=
 =?utf-8?B?V3dJeHBTS2YvdlJZL0lGa0ZJM29hTWR2cDMxYkxkcXMvWVhSdGkyQVdIN1RX?=
 =?utf-8?B?YW55YVQ2dXN4V0pPdlpZT2JuZTZtNDl6cGxzNWhiWUVMWFZyeGh5SFNIV0V3?=
 =?utf-8?B?cUIrY3pOeDlCUFNFRTd3WUR1QTR3R0JvbTZybC82bTg0ZHlldGF4UU45ZU4v?=
 =?utf-8?B?bmJBMmQxT0dhTjQvcHBETitMMGZLeE5sQzVISUU1OWJ4bXRqZzBORkJUcXRG?=
 =?utf-8?B?WnNVTmpRU25pd3hDVXBEZTRmODdYemV2VnZNN1BGdUI5R1hRMWN1ckhON2VK?=
 =?utf-8?B?YWNSRUlrMjAzTElQQ0JQZlJPdEYzQVh2N2h6di9MSXhlWFRzZ3lvazNNM1E0?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9974996B20E9FE428FE30E89161DDBC0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7175bc5-8036-4b74-f1fc-08db8367ecec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 06:10:58.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Q8l+rEOWKYRxL8VLtSMbXrGXZpZovNKIKO+aqwZvbpK58/vnLdKVCo30L0yDe+6xfKahymOYigY05WX4owwwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7682
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTEyIGF0IDEzOjI5IC0wNzAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNl
bmRlciBvciB0aGUgY29udGVudC4NCj4gIEhpIENocmlzLA0KPiANCj4gT24gV2VkLCBKdWwgMTIs
IDIwMjMgYXQgNjowM+KAr0FNIENocmlzIEx1IDxjaHJpcy5sdUBtZWRpYXRlay5jb20+DQo+IHdy
b3RlOg0KPiA+DQo+ID4gVGhlcmUgbWF5IGJlIGEgcG90ZW50aWFsIG51bGwgcG9pbnRlciByaXNr
IGlmIG9mZnNldCB2YWx1ZSBpcw0KPiA+IGxlc3MgdGhhbiAwIHdoZW4gZG9pbmcgbWVtY21wIGlu
IGJ0bXRrX3Byb2Nlc3NfY29yZWR1bXAoKS4NCj4gPiBDaGVjayBvZmZzZXQgaXMgdmFsaWQgYmVm
b3JlIGRvaW5nIG1lbWNtcC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENocmlzIEx1IDxjaHJp
cy5sdUBtZWRpYXRlay5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBTZWFuIFdhbmcgPHNlYW4u
d2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFuLndh
bmdAbWVkaWF0ZWsuY29tPg0KPiANCj4gWW91IHNob3VsZCBwcm9iYWJseSBpbmNsdWRlIHRoZSBG
aXhlcyB0YWcgb2YgdGhlIHBhdGNoIHRoYXQNCj4gaW50cm9kdWNlZA0KPiB0aGUgcHJvYmxlbS4N
Cj4gDQpIaSBMdWl6LA0KDQpUaGFua3MgZm9yIHJlbWluZGluZywgSSdsbCB1cGRhdGUgQnVnIGFk
IGZpeHMgaW5mbyBpbiBjb21taXQgbWVzc2FnZQ0KYW5kIHNlbmQgdGhlIHY1IHBhdGNoLg0KDQpC
UnMsDQpDaHJpcw0KDQo+ID4gLS0tDQo+ID4gdjI6IGZpeCB0eXBvDQo+ID4gdjM6IGZpeCBib3Qg
Y2hlY2tpbmcgZXJyb3INCj4gPiB2NDogcmVkdWNlIHZhcmlhYmxlICdvZmZzZXQnIGRlY2xhcmF0
aW9uIGluIHYzDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMgfCAxMiAr
KysrKystLS0tLS0NCj4gPiAgZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuaCB8ICAxICsNCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuYyBiL2RyaXZlcnMvYmx1ZXRv
b3RoL2J0bXRrLmMNCj4gPiBpbmRleCA3ODZmNzc1MTk2YWUuLjljYzc4OTI3MmFiNyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idG10ay5jDQo+ID4gKysrIGIvZHJpdmVycy9i
bHVldG9vdGgvYnRtdGsuYw0KPiA+IEBAIC0zOTUsMTIgKzM5NSwxMiBAQCBpbnQgYnRtdGtfcHJv
Y2Vzc19jb3JlZHVtcChzdHJ1Y3QgaGNpX2Rldg0KPiAqaGRldiwgc3RydWN0IHNrX2J1ZmYgKnNr
YikNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICAvKiBNZWRpYXRlayBjb3JlZHVtcCBkYXRhIHdv
dWxkIGJlIG1vcmUgdGhhbg0KPiBNVEtfQ09SRURVTVBfTlVNICovDQo+ID4gICAgICAgICAgICAg
ICAgIGlmIChkYXRhLT5jZF9pbmZvLmNudCA+IE1US19DT1JFRFVNUF9OVU0gJiYNCj4gPiAtICAg
ICAgICAgICAgICAgICAgIHNrYi0+bGVuID4gc2l6ZW9mKE1US19DT1JFRFVNUF9FTkQpICYmDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAhbWVtY21wKChjaGFyICopJnNrYi0+ZGF0YVtza2ItPmxl
biAtDQo+IHNpemVvZihNVEtfQ09SRURVTVBfRU5EKV0sDQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgIE1US19DT1JFRFVNUF9FTkQsDQo+IHNpemVvZihNVEtfQ09SRURVTVBfRU5EKSAt
IDEpKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgYnRfZGV2X2luZm8oaGRldiwgIk1l
ZGlhdGVrIGNvcmVkdW1wIGVuZCIpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGhjaV9k
ZXZjZF9jb21wbGV0ZShoZGV2KTsNCj4gPiAtICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgc2tiLT5sZW4gPiBNVEtfQ09SRURVTVBfRU5EX0xFTikNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoIW1lbWNtcCgoY2hhciAqKSZza2ItPmRhdGFbc2tiLT5sZW4g
LQ0KPiBNVEtfQ09SRURVTVBfRU5EX0xFTl0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE1US19DT1JFRFVNUF9FTkQsIE1US19DT1JFRFVNUF9FTkRfTEVODQo+IC0gMSkpIHsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ0X2Rldl9pbmZvKGhkZXYsICJNZWRp
YXRlaw0KPiBjb3JlZHVtcCBlbmQiKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGhjaV9kZXZjZF9jb21wbGV0ZShoZGV2KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICB9DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICB9DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmggYi9kcml2ZXJzL2JsdWV0b290
aC9idG10ay5oDQo+ID4gaW5kZXggNjgzMDlkZmUwNzZhLi41NmY1NTAyYmFhZGYgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuaA0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0bXRrLmgNCj4gPiBAQCAtMjQsNiArMjQsNyBAQA0KPiA+DQo+ID4gICNkZWZpbmUg
TVRLX0NPUkVEVU1QX1NJWkUgICAgICAgICAgICAgICgxMDI0ICogMTAwMCkNCj4gPiAgI2RlZmlu
ZSBNVEtfQ09SRURVTVBfRU5EICAgICAgICAgICAgICAgImNvcmVkdW1wIGVuZCINCj4gPiArI2Rl
ZmluZSBNVEtfQ09SRURVTVBfRU5EX0xFTiAgICAgICAgICAgKHNpemVvZihNVEtfQ09SRURVTVBf
RU5EKSkNCj4gPiAgI2RlZmluZSBNVEtfQ09SRURVTVBfTlVNICAgICAgICAgICAgICAgMjU1DQo+
ID4NCj4gPiAgZW51bSB7DQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPg0KPiANCj4gDQo+IC0tIA0K
PiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo=
