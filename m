Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D7C7575AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjGRHtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGRHtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:49:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D01B1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:49:20 -0700 (PDT)
X-UUID: 9675ec6c253f11eeb20a276fd37b9834-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bi3FrOeu2tx1eZdcTQYf1qkAXOZ3hd0JPb1seDRxi2s=;
        b=P5Zuu8uFZw/NiKJRM3FtJEYpAk/+Yu0pTzL90ijPZIZuZ5+h91j+GZ3iUyhyM5gn+aGU6zlV8r+4Xl/tvuRXI6EO90zBuaxn/RnfyNimrtWhfHrMszUMkIRFHbKw+YkAVHtKFW0unaLs6WVDsCIUy5Uv+XiJl7TqxEGzoXAeFaM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:a2417dbb-2ca3-494b-987a-389bae20b497,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:e7aed54c-06c1-468b-847d-5b62d44dbb9b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9675ec6c253f11eeb20a276fd37b9834-20230718
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1599583787; Tue, 18 Jul 2023 15:49:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 15:49:12 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 15:49:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB+pCEkqvUaFMmsQDU2OiPTDcl3b9kgOWsZL0QXG8a//1zw7X7DRbEliAwnvOGYTIlN2BstUGnQEx6zPJFElxmmVrIyHzaOkPhjhu+o3uKcCvUt5xXoZbvlSanrQDtJ4BSft+kVY2ip/PcMLB2fER/10UugUDuSFDnjirRx4dad77sjwTOOK7bDrRmRq4+/RkyJRga7MUwSdO4YmRe4mcBneLDhZIG/I4z5HFOHK2T1b1AjMpOMX+XUh70E/kcihetwlqJ4GGsPayqEQWbQsdroy8Na8F355XxNV5Ah7pPGJdvUyhj1bzqdUprgSoPaJJTaIUPXqC6NIYN3/Je9/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi3FrOeu2tx1eZdcTQYf1qkAXOZ3hd0JPb1seDRxi2s=;
 b=ZPcgq/X0V38kW6wM6lqm7Q4joudlWT+EUemURd9pKyrVCs2FJJUM6O4wiKwJ5J0QwCkQbF8Cz/2YoH52VinlBHu+3vVyWZc9jCvmRUEsK8rI2y3fLL17KCcZodmtEwFQbgGJiT1Y38iIR6HFrQF9IHdsi/2D7lVednYzCOX1zDEsYwbF4YGD91DH4PZPtvcmi123ZR0LXyQtPwbSR3r01lnnjlJKhxxB8ql/KH63rJ/Pa1cmuW00Wn6CuoL186o5qpmQ1TcGXiZa0y/e3q/clKTY+IrGFPVxfv1uAbsMy4sKcSD7+G+rls1FrmOjOb5wb4L9zRft97Ui/zGcaLvSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi3FrOeu2tx1eZdcTQYf1qkAXOZ3hd0JPb1seDRxi2s=;
 b=iV0D4tx9Z+H+c2ZQpJmkUgXUrABvnkPSQL0PGwf4Fkjy2l8boo51r0zBANZmeRvo0OmAb8VMCXXhbFCuKyyHJQs15ywogJKYCsnqD4QL1IVcgi7dAQZP9XiHXPz1TccbOPD+Kpt744mVWS9X323B73XUuCt+zw74/sJwuTzXEqo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7048.apcprd03.prod.outlook.com (2603:1096:101:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 07:49:09 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 07:49:03 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v6 02/11] drm/mediatek: dp: Move AUX and panel poweron/off
 sequence to function
Thread-Topic: [PATCH v6 02/11] drm/mediatek: dp: Move AUX and panel
 poweron/off sequence to function
Thread-Index: AQHZuLk/8l6F7TgackG+cr62q+bZY6+/JzAA
Date:   Tue, 18 Jul 2023 07:49:03 +0000
Message-ID: <75d2173daa9907865f904664a319af20f5bbb79b.camel@mediatek.com>
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
         <20230717141438.274419-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230717141438.274419-3-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7048:EE_
x-ms-office365-filtering-correlation-id: c1ddf3cd-3eb5-4bc4-5da5-08db876374a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ghzLBKTmKWqDOtZ+W+zYCob1AtDdOT+1J60kCfJyn1FyDTprCyAQ6hs8u1nCXH/EMk8eHtfRwhg9Mbx2F5meN6DC+/hjhdapomQ5aGfwJDCWTu1s/XokKCtQOoeQm7VVeD7rd/keFdpQ3HvO/s4fTMXwiTexR4LOlRxtwjDc4gBOVC/JjK2eybGsjyAAPc8h/SNh7LGZPu0NI8BgRJxqQvkxTUyDw8vvPtNVB7pEGwDUVu190vviC0wyImLg/x2ZzSKVAmDybtiEShzFRSPQuhz2BPqbMat3dHd7YnMwtTwRv9kN5Lk/LttFiVeSY7qMWNLUjlrzm5hY6As77DtrPGlj2BISnvOtCjFgOexVKFtUCxmeBGaPNiZrFIUN1dLqwSwR6Qt/ptqYfRTh1FTh9aKIdaD48mDFOLum65ha8fB2w50i3pf/cjHwS9oIAe7XW4rM2y66PbMstea+cSjm5W5tJ8aOSPhDipt0gSmT79C1NkMourEg2vMWcs/7Tdme7KipWaaBel8DAQoQ4ftocXHDD9jKxDfF9fYBv+TREVRFXuDSoj4uv6nYZWOh5jh7L7g6sFhc8d13sXIiH8bV98EsWmmxy1ba8m2Qe6QC60pE8otf3u7XUd1efPS2qlg6XB2jzykfd3x6nDyAQ6od/NGjZurLOZDDDiMwYwfxE8Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(71200400001)(478600001)(6486002)(91956017)(110136005)(54906003)(186003)(6506007)(6512007)(26005)(76116006)(2906002)(316002)(41300700001)(66446008)(66946007)(4326008)(66476007)(66556008)(64756008)(8676002)(5660300002)(8936002)(7416002)(122000001)(38100700002)(36756003)(85182001)(86362001)(38070700005)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlpMRkxuOVhTbkxCd09QM05PM3N3dEFhVkE2MHU3aG1PVmRGQStNT0Y2Vldh?=
 =?utf-8?B?MGlnKzMyQzRkVmF3OVlmeFpGMHVWemt2S0F3WkFtajkvMy90UXZURllMN2ZB?=
 =?utf-8?B?cXFnWFlpNk1HOXNhbllpUGsycTJOajNGa3dZL3c5K2xuNFZaOUhsL2RIUVRZ?=
 =?utf-8?B?RVJ3N2dpK08yNElEUngvYVU2bzNvSFBzWHRFSG93NlgvUlFJQ0w3cXNGMUlG?=
 =?utf-8?B?NDNnMjlvVXVaRTdQTHZvNGEzSTUyTVZOSjJVUjduZmx2Z01ZcmptT3QydnJS?=
 =?utf-8?B?YjJoUW1LRGZ2dUhKUjJZcmY0bVRNQVppK0VMeGozekpuL0dJcCtSRHhqWHA1?=
 =?utf-8?B?RW05cXVoZytpeG1uOHhST0ovRkdGZitVWGU0aVgrRk13aTV1M1VLOC9IS0hO?=
 =?utf-8?B?bTJRNTc1NEtzSTFqcjdQYTByOTFSTGlETVQyT3JJMDJ6cS9rN2tpQlo4WjJi?=
 =?utf-8?B?L0VDYTBHaDI2bVNKM1E3MWwyM3YwQXM2SjdBSE9IMHFmZFNrSkU1eDlBb2RG?=
 =?utf-8?B?RU5NS0NZOVJEZjJtRnZQNG0wS1ZWVTBIVGFscytoTEhlOWJDcXNKS1JZdWRm?=
 =?utf-8?B?UEhGTGhJQzVEaUNRbjlmMHV3TFcxSFhGNFZ3WDFNTjRqbFo0ZHh5SlUxQTFM?=
 =?utf-8?B?TVVOdmpiM0FCMnJKUk8ySjkwWGpCRFNzRFNFeFpZc3ZqSHE3Q3g2R3ZaUXBN?=
 =?utf-8?B?L0JnWDhjYjFzSTFLWkJ1RU5qZzNadUxuaHB5QXlpaFQ0T0tWUW9WZUlWNm5B?=
 =?utf-8?B?RjIwRTJlMUdyaHduZ2R3MDdUVllhRXFGY0tPc2RuQUErOVNvdnlCSXNZZUIw?=
 =?utf-8?B?bUJISURHbTdxaDBnZ1NOYzhUWERDWW04SGtkR3dOekxuUmd1WlE4U2diYnVG?=
 =?utf-8?B?aEpLTGlURm5JQVg0bnJua1pOMnVPRjRCNWxCKzVJN3NJUTFBTkgyem5ycnNC?=
 =?utf-8?B?OXpVNlpqUkhhTjNPNGV4RE5zSDBGanNhTkFGekhGWkdDbVlPNkZoVWhTRmJH?=
 =?utf-8?B?UVpRQlh4bWt1Y3hNSGdheUlSeC9PR3NaT1FURSttWTE2OHZGMHYrVDNhcWhY?=
 =?utf-8?B?K2tWRnlNcXl2NHptZW5uYW1rc0ZaMU5SaWs2eVlELzNITHYwbEZpOTlrNFkw?=
 =?utf-8?B?eFlseTdJVXpNSEtwWk81MFVRQWh6SmNmSW4ydVJVUGlsaU4wN25odzk3bGx1?=
 =?utf-8?B?QW80SlRwK0QwRE53T0taRklHNlEyd0FYdVp5VjlJOC9rU2JSQWp3YmIyaEkz?=
 =?utf-8?B?VVZGZmp1QWNsa0J4NmphcTBUazhmb3Fvd0JIOWVEdGR6eE1kMlNJeGxGblJU?=
 =?utf-8?B?Y1Y3RFdGUFhrV3g1S3kwUzM5bTNnT0VxcUVPSlJFVjE1YXc3M1JPUmMxM0ti?=
 =?utf-8?B?VW4wWVpweFY5aEszNHRCSkRqVEVTTW92cmRRaGRzUllCanYyanJ3VlBYRVIz?=
 =?utf-8?B?Rkx2b0dHMHpwL0RpOTJBSG5xRE0zNElydFFsWnNTeXltMW5aQjhvR3JxTEpX?=
 =?utf-8?B?YWJzcWkzWUR2Y251dUlMRGEwNVdMYWEzN2srb1VMb0dGMU1OWVArVjZlL0dD?=
 =?utf-8?B?YmZvaW5yUDFiQ25wN2wrRVVxOHhETDJEY1dRemdwQ2htZ252NWUwM2NLdWw5?=
 =?utf-8?B?Mk9BRGw5dVdWa2xFRm9oOFJ1WkNoRWFxcVlWeFZKQjAvbDBGNzZTeUxSWjIw?=
 =?utf-8?B?MmtZYTRWTUdJZjdDMXNuRTNNRU9mWjRsVFFrazNRL1I4WFZ0TCsxQW5hM0VT?=
 =?utf-8?B?RXhQaDVBMVUvZ0pGYzU3NkZFVE1ja2dLUjBac2l4RE9lNmxZZVpESDJGTXlK?=
 =?utf-8?B?bG9IV3kxTThSTFNZSjZ4aHM2MVhkZkxGTXYyNGJIWmxneUZKY09VVDNLU0Uy?=
 =?utf-8?B?Mk96SUNtZGVtbW5PQm0rUDY1UDQrZXBEV1BwQXlZU21pT0dtYVYybHpnTVo0?=
 =?utf-8?B?U2pHWDhQUXVMdzVWUG5LeWZQT2lZb2hxdWt4UzVlc2lHNmp4RDhkbDRoTnFC?=
 =?utf-8?B?bWdpSTlERk0zajNmajA5Sis4UzFWc3BqaUxxaDlzaTBDMG1iZTFKcmY4VGgz?=
 =?utf-8?B?VW8vemYya1FHYXZuY0RRdlJzRnBzTlpOUnlKVHNRZFhQN0xXdW13TFNPQjYz?=
 =?utf-8?Q?JLHKv4FiaU5RhssKf56evW/dT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F096AA9803F2494EB23446118EF376E9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ddf3cd-3eb5-4bc4-5da5-08db876374a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 07:49:03.0704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8olO3c6tOftGX871jroDMHOEIOfdxbg14UZcihbqzWl1hTQg74vOf8a3L9fac0Zrz0tjSL1HA5tunIKDXVRLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gTW9uLCAyMDIzLTA3LTE3IGF0IDE2OjE0ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBFdmVyeXRpbWUgd2Ug
cnVuIGJyaWRnZSBkZXRlY3Rpb24gYW5kL29yIEVESUQgcmVhZCB3ZSBydW4gYSBwb3dlcm9uDQo+
IGFuZCBwb3dlcm9mZiBzZXF1ZW5jZSBmb3IgYm90aCB0aGUgQVVYIGFuZCB0aGUgcGFuZWw7IG1v
cmVvdmVyLCB0aGlzDQo+IGlzIGFsc28gZG9uZSB3aGVuIGVuYWJsaW5nIHRoZSBicmlkZ2UgaW4g
dGhlIC5hdG9taWNfZW5hYmxlKCkNCj4gY2FsbGJhY2suDQo+IA0KPiBNb3ZlIHRoaXMgcG93ZXIg
b24vb2ZmIHNlcXVlbmNlIHRvIGEgbmV3IG10a19kcF9hdXhfcGFuZWxfcG93ZXJvbigpDQo+IGZ1
bmN0aW9uIGFzIHRvIGNvbW1vbml6ZSBpdC4NCj4gTm90ZSB0aGF0LCBiZWZvcmUgdGhpcyBjb21t
aXQsIGluIG10a19kcF9icmlkZ2VfYXRvbWljX2VuYWJsZSgpIG9ubHkNCj4gdGhlIEFVWCB3YXMg
Z2V0dGluZyBwb3dlcmVkIG9uIGJ1dCB0aGUgcGFuZWwgd2FzIGxlZnQgcG93ZXJlZCBvZmYgaWYN
Cj4gdGhlIERQIGNhYmxlIHdhc24ndCBwbHVnZ2VkIGluIHdoaWxlIG5vdyB3ZSB1bmNvbmRpdGlv
bmFsbHkgc2VuZCBhIEQwDQo+IHJlcXVlc3QgYW5kIHRoaXMgaXMgZG9uZSBmb3IgdHdvIHJlYXNv
bnM6DQo+ICAtIEZpcnN0LCB3aGV0aGVyIHRoaXMgcmVxdWVzdCBmYWlscyBvciBub3QsIGl0IHRh
a2VzIHRoZSBzYW1lIHRpbWUNCj4gICAgYW5kIGFueXdheSB0aGUgRFAgaGFyZHdhcmUgd29uJ3Qg
cHJvZHVjZSBhbnkgZXJyb3IgKG9yLCBpZiBpdA0KPiAgICBkb2VzLCBpdCdzIGlnbm9yYWJsZSBi
ZWNhdXNlIGl0IHdvbid0IGJsb2NrIGZ1cnRoZXIgY29tbWFuZHMpDQo+ICAtIFNlY29uZCwgdHJh
aW5pbmcgdGhlIGxpbmsgYmV0d2VlbiBhIHNsZWVwaW5nL3N0YW5kYnkvdW5wb3dlcmVkDQo+ICAg
IGRpc3BsYXkgbWFrZXMgbGl0dGxlIHNlbnNlLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1
QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+
IFRlc3RlZC1ieTogQ2hlbi1ZdSBUc2FpIDx3ZW5zdEBjaHJvbWl1bS5vcmc+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jIHwgNzYgKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0NCj4gLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCA0
NiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RwLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gaW5k
ZXggYzU4Yjc3NTg3N2EzLi43N2RhMGQwMDJlOWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwLmMNCj4gQEAgLTEyNTEsNiArMTI1MSwyOSBAQCBzdGF0aWMgdm9pZCBtdGtfZHBfYXVk
aW9fbXV0ZShzdHJ1Y3QgbXRrX2RwDQo+ICptdGtfZHAsIGJvb2wgbXV0ZSkNCj4gIAkJCSAgIHZh
bFsyXSwgQVVfVFNfQ0ZHX0RQX0VOQzBfUDBfTUFTSyk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2
b2lkIG10a19kcF9hdXhfcGFuZWxfcG93ZXJvbihzdHJ1Y3QgbXRrX2RwICptdGtfZHAsIGJvb2wN
Cj4gcHdyb24pDQo+ICt7DQo+ICsJaWYgKHB3cm9uKSB7DQo+ICsJCS8qIHBvd2VyIG9uIGF1eCAq
Lw0KPiArCQltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfVE9QX1BXUl9TVEFURSwN
Cj4gKwkJCQkgICBEUF9QV1JfU1RBVEVfQkFOREdBUF9UUExMX0xBTkUsDQo+ICsJCQkJICAgRFBf
UFdSX1NUQVRFX01BU0spOw0KPiArDQo+ICsJCS8qIHBvd2VyIG9uIHBhbmVsICovDQo+ICsJCWRy
bV9kcF9kcGNkX3dyaXRlYigmbXRrX2RwLT5hdXgsIERQX1NFVF9QT1dFUiwNCj4gRFBfU0VUX1BP
V0VSX0QwKTsNCj4gKwkJdXNsZWVwX3JhbmdlKDIwMDAsIDUwMDApOw0KPiArCX0gZWxzZSB7DQo+
ICsJCS8qIHBvd2VyIG9mZiBwYW5lbCAqLw0KPiArCQlkcm1fZHBfZHBjZF93cml0ZWIoJm10a19k
cC0+YXV4LCBEUF9TRVRfUE9XRVIsDQo+IERQX1NFVF9QT1dFUl9EMyk7DQo+ICsJCXVzbGVlcF9y
YW5nZSgyMDAwLCAzMDAwKTsNCj4gKw0KPiArCQkvKiBwb3dlciBvZmYgYXV4ICovDQo+ICsJCW10
a19kcF91cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9UT1BfUFdSX1NUQVRFLA0KPiArCQkJCSAg
IERQX1BXUl9TVEFURV9CQU5ER0FQX1RQTEwsDQo+ICsJCQkJICAgRFBfUFdSX1NUQVRFX01BU0sp
Ow0KPiArCX0NCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgbXRrX2RwX3Bvd2VyX2VuYWJsZShz
dHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+ICB7DQo+ICAJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19k
cCwgTVRLX0RQX1RPUF9SRVNFVF9BTkRfUFJPQkUsDQo+IEBAIC0xOTQxLDE2ICsxOTY0LDkgQEAg
c3RhdGljIGVudW0gZHJtX2Nvbm5lY3Rvcl9zdGF0dXMNCj4gbXRrX2RwX2JkZ19kZXRlY3Qoc3Ry
dWN0IGRybV9icmlkZ2UgKmJyaWRnZSkNCj4gIAlpZiAoIW10a19kcC0+dHJhaW5faW5mby5jYWJs
ZV9wbHVnZ2VkX2luKQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0JaWYgKCFlbmFibGVkKSB7
DQo+IC0JCS8qIHBvd2VyIG9uIGF1eCAqLw0KPiAtCQltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2Rw
LCBNVEtfRFBfVE9QX1BXUl9TVEFURSwNCj4gLQkJCQkgICBEUF9QV1JfU1RBVEVfQkFOREdBUF9U
UExMX0xBTkUsDQo+IC0JCQkJICAgRFBfUFdSX1NUQVRFX01BU0spOw0KPiArCWlmICghZW5hYmxl
ZCkNCj4gKwkJbXRrX2RwX2F1eF9wYW5lbF9wb3dlcm9uKG10a19kcCwgdHJ1ZSk7DQo+ICANCj4g
LQkJLyogcG93ZXIgb24gcGFuZWwgKi8NCj4gLQkJZHJtX2RwX2RwY2Rfd3JpdGViKCZtdGtfZHAt
PmF1eCwgRFBfU0VUX1BPV0VSLA0KPiBEUF9TRVRfUE9XRVJfRDApOw0KPiAtCQl1c2xlZXBfcmFu
Z2UoMjAwMCwgNTAwMCk7DQo+IC0JfQ0KPiAgCS8qDQo+ICAJICogU29tZSBkb25nbGVzIHN0aWxs
IHNvdXJjZSBIUEQgd2hlbiB0aGV5IGRvIG5vdCBjb25uZWN0IHRvDQo+IGFueQ0KPiAgCSAqIHNp
bmsgZGV2aWNlLiBUbyBhdm9pZCB0aGlzLCB3ZSBuZWVkIHRvIHJlYWQgdGhlIHNpbmsgY291bnQN
Cj4gQEAgLTE5NjIsMTYgKzE5NzgsOCBAQCBzdGF0aWMgZW51bSBkcm1fY29ubmVjdG9yX3N0YXR1
cw0KPiBtdGtfZHBfYmRnX2RldGVjdChzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlKQ0KPiAgCWlm
IChEUF9HRVRfU0lOS19DT1VOVChzaW5rX2NvdW50KSkNCj4gIAkJcmV0ID0gY29ubmVjdG9yX3N0
YXR1c19jb25uZWN0ZWQ7DQo+ICANCj4gLQlpZiAoIWVuYWJsZWQpIHsNCj4gLQkJLyogcG93ZXIg
b2ZmIHBhbmVsICovDQo+IC0JCWRybV9kcF9kcGNkX3dyaXRlYigmbXRrX2RwLT5hdXgsIERQX1NF
VF9QT1dFUiwNCj4gRFBfU0VUX1BPV0VSX0QzKTsNCj4gLQkJdXNsZWVwX3JhbmdlKDIwMDAsIDMw
MDApOw0KPiAtDQo+IC0JCS8qIHBvd2VyIG9mZiBhdXggKi8NCj4gLQkJbXRrX2RwX3VwZGF0ZV9i
aXRzKG10a19kcCwgTVRLX0RQX1RPUF9QV1JfU1RBVEUsDQo+IC0JCQkJICAgRFBfUFdSX1NUQVRF
X0JBTkRHQVBfVFBMTCwNCj4gLQkJCQkgICBEUF9QV1JfU1RBVEVfTUFTSyk7DQo+IC0JfQ0KPiAr
CWlmICghZW5hYmxlZCkNCj4gKwkJbXRrX2RwX2F1eF9wYW5lbF9wb3dlcm9uKG10a19kcCwgZmFs
c2UpOw0KPiAgDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gQEAgLTE5ODcsMTUgKzE5OTUsNyBA
QCBzdGF0aWMgc3RydWN0IGVkaWQgKm10a19kcF9nZXRfZWRpZChzdHJ1Y3QNCj4gZHJtX2JyaWRn
ZSAqYnJpZGdlLA0KPiAgDQo+ICAJaWYgKCFlbmFibGVkKSB7DQo+ICAJCWRybV9hdG9taWNfYnJp
ZGdlX2NoYWluX3ByZV9lbmFibGUoYnJpZGdlLCBjb25uZWN0b3ItDQo+ID5zdGF0ZS0+c3RhdGUp
Ow0KPiAtDQo+IC0JCS8qIHBvd2VyIG9uIGF1eCAqLw0KPiAtCQltdGtfZHBfdXBkYXRlX2JpdHMo
bXRrX2RwLCBNVEtfRFBfVE9QX1BXUl9TVEFURSwNCj4gLQkJCQkgICBEUF9QV1JfU1RBVEVfQkFO
REdBUF9UUExMX0xBTkUsDQo+IC0JCQkJICAgRFBfUFdSX1NUQVRFX01BU0spOw0KPiAtDQo+IC0J
CS8qIHBvd2VyIG9uIHBhbmVsICovDQo+IC0JCWRybV9kcF9kcGNkX3dyaXRlYigmbXRrX2RwLT5h
dXgsIERQX1NFVF9QT1dFUiwNCj4gRFBfU0VUX1BPV0VSX0QwKTsNCj4gLQkJdXNsZWVwX3Jhbmdl
KDIwMDAsIDUwMDApOw0KPiArCQltdGtfZHBfYXV4X3BhbmVsX3Bvd2Vyb24obXRrX2RwLCB0cnVl
KTsNCj4gIAl9DQo+ICANCj4gIAluZXdfZWRpZCA9IGRybV9nZXRfZWRpZChjb25uZWN0b3IsICZt
dGtfZHAtPmF1eC5kZGMpOw0KPiBAQCAtMjAxNSwxNSArMjAxNSw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
ZWRpZCAqbXRrX2RwX2dldF9lZGlkKHN0cnVjdA0KPiBkcm1fYnJpZGdlICpicmlkZ2UsDQo+ICAJ
fQ0KPiAgDQo+ICAJaWYgKCFlbmFibGVkKSB7DQo+IC0JCS8qIHBvd2VyIG9mZiBwYW5lbCAqLw0K
PiAtCQlkcm1fZHBfZHBjZF93cml0ZWIoJm10a19kcC0+YXV4LCBEUF9TRVRfUE9XRVIsDQo+IERQ
X1NFVF9QT1dFUl9EMyk7DQo+IC0JCXVzbGVlcF9yYW5nZSgyMDAwLCAzMDAwKTsNCj4gLQ0KPiAt
CQkvKiBwb3dlciBvZmYgYXV4ICovDQo+IC0JCW10a19kcF91cGRhdGVfYml0cyhtdGtfZHAsIE1U
S19EUF9UT1BfUFdSX1NUQVRFLA0KPiAtCQkJCSAgIERQX1BXUl9TVEFURV9CQU5ER0FQX1RQTEws
DQo+IC0JCQkJICAgRFBfUFdSX1NUQVRFX01BU0spOw0KPiAtDQo+ICsJCW10a19kcF9hdXhfcGFu
ZWxfcG93ZXJvbihtdGtfZHAsIGZhbHNlKTsNCj4gIAkJZHJtX2F0b21pY19icmlkZ2VfY2hhaW5f
cG9zdF9kaXNhYmxlKGJyaWRnZSwgY29ubmVjdG9yLQ0KPiA+c3RhdGUtPnN0YXRlKTsNCj4gIAl9
DQo+ICANCj4gQEAgLTIxODMsMTUgKzIxNzUsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHBfYnJpZGdl
X2F0b21pY19lbmFibGUoc3RydWN0DQo+IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gIAkJcmV0dXJu
Ow0KPiAgCX0NCj4gIA0KPiAtCS8qIHBvd2VyIG9uIGF1eCAqLw0KPiAtCW10a19kcF91cGRhdGVf
Yml0cyhtdGtfZHAsIE1US19EUF9UT1BfUFdSX1NUQVRFLA0KPiAtCQkJICAgRFBfUFdSX1NUQVRF
X0JBTkRHQVBfVFBMTF9MQU5FLA0KPiAtCQkJICAgRFBfUFdSX1NUQVRFX01BU0spOw0KPiAtDQo+
IC0JaWYgKG10a19kcC0+dHJhaW5faW5mby5jYWJsZV9wbHVnZ2VkX2luKSB7DQo+IC0JCWRybV9k
cF9kcGNkX3dyaXRlYigmbXRrX2RwLT5hdXgsIERQX1NFVF9QT1dFUiwNCj4gRFBfU0VUX1BPV0VS
X0QwKTsNCj4gLQkJdXNsZWVwX3JhbmdlKDIwMDAsIDUwMDApOw0KPiAtCX0NCj4gKwltdGtfZHBf
YXV4X3BhbmVsX3Bvd2Vyb24obXRrX2RwLCB0cnVlKTsNCj4gIA0KPiAgCS8qIFRyYWluaW5nICov
DQo+ICAJcmV0ID0gbXRrX2RwX3RyYWluaW5nKG10a19kcCk7DQo+IC0tIA0KPiAyLjQwLjENCg==
