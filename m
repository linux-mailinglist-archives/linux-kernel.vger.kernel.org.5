Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B689B7BB47A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjJFJsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjJFJsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:48:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBFB9F;
        Fri,  6 Oct 2023 02:48:10 -0700 (PDT)
X-UUID: 718cc736642d11ee8051498923ad61e6-20231006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qSWGUs4j1IKqVoZYuFW82NacSDNEC6uuoP6VUz2Xqxc=;
        b=Porpn5uEGU3MsshPfteda4Y6ArozqsdDW/v95H+uqxpk1YCq1OwDWui8caWUbc1BGsL2X3D6f83LO6Vwe6LDSnsmeT9cYqFO14DOaX5JRNHq77a2VZDvKFj5KJbLH8Ie/6G+osposbcpXeKRp69HyEVIioG8wVUmvpBYFoHZ054=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:deb25491-9cae-4d5d-a0da-14f90ef8dbee,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:8ddda7bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 718cc736642d11ee8051498923ad61e6-20231006
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2030301495; Fri, 06 Oct 2023 17:48:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Oct 2023 17:48:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Oct 2023 17:48:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZT1F2dw8VekSQx4HEA59wPtqdDluRvzBn6pCu8Cxcxx+qxYVit1LI4craTXQ7Nl04XjDnqqM29z3JUg+iQuMlYmhoNPdtySFgCIxzYLACG4bpEPnNe7b2uGlQ/XuMpVGqV2k1/GrT0tSCSA33E/0VNthEMuxC3Dn3qNHv2hMXbAFGc0ECiU/25eZE1/2Tj/dBqqDjr+ATp6pHabODEYUJ9KrIIFd6gOJqTpM4tLeWdNWCXsyxZbAVWApnfL5M23bpgqJCKKEbAu9blHYhLA52siumJu4p1bDOflhxvspzsY6sclE6jJpRXXYfNoFvZTHv/aaxFoaRNW/C/yReKuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSWGUs4j1IKqVoZYuFW82NacSDNEC6uuoP6VUz2Xqxc=;
 b=Kfc3TE8L9LSzGIm/OL1EGbljGNzH2Gd5p3CGIabpZNT/LkNlYPe+A/fcUmxfhrkcpGTCJUCOwFP9DAKJT8qRw0V2bd43D/F1YeD0aEbf5Fi/hBMQV2PDnNfvcJGKu5Wfu3AKTIWlEJtHmMzrMQSz9Ev3QS/dnXvUOpq5Q3R8r2mGTKIWuKbnPGaZINVVvofnkTcqUqgdnwYR+v8x75KxPb+/Vqss3PT8LgvREY0cOY5RuXOL+RXP/l0NiChIY9tKjqGacNsG2IBCSeuwSrBU8OL7Q8ZLAQsm3lm9Eb0L6JDHmeuo+RAEVhAE00soDT4o05izkQLi4hnYR1euzB78ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSWGUs4j1IKqVoZYuFW82NacSDNEC6uuoP6VUz2Xqxc=;
 b=cmTZsFh3ZcpAI1qvDGj1/U/4ORDUpqQ9pqqyEhq0PEDsb+JMldufhjlqplnBQB60v2GUCEy3gJ5Vfd8PyEspYWIw+uECCh0VucCFUF+UByd5wsjzQ01gesvM3VKndUffBiyqiuN189nBl+1GSavisDlEdGL4SoK5ykrG87lKBP8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7475.apcprd03.prod.outlook.com (2603:1096:400:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Fri, 6 Oct
 2023 09:47:59 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6792.026; Fri, 6 Oct 2023
 09:47:59 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 22/23] drm/mediatek: Power on devices in OVL adaptor
 when atomic enable
Thread-Topic: [PATCH v7 22/23] drm/mediatek: Power on devices in OVL adaptor
 when atomic enable
Thread-Index: AQHZ+Cgt1mwO93ZOYUmbYG85Lhw/2rA8hA8A
Date:   Fri, 6 Oct 2023 09:47:59 +0000
Message-ID: <40c039f4b6ae85c6838982ad0c3014fd463a62dd.camel@mediatek.com>
References: <20231006073831.10402-1-shawn.sung@mediatek.com>
         <20231006073831.10402-23-shawn.sung@mediatek.com>
In-Reply-To: <20231006073831.10402-23-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7475:EE_
x-ms-office365-filtering-correlation-id: 37402f29-a67c-4d72-314a-08dbc651532c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: noyN4lcy21ujpIroGgBe39eXl6NYfUGrNZEITdlZpD9qQoGGqUNZbyUp+48jUkcstLEY7SN0YcaPGadIWSbDVzXzS156vmJvYG0AHpLyEGhguB1dwJb1sO0u2aYobRmsGdLbQMT9wV4RdAYhB32cWbsobWOglOEP2AWbhmfBF2K3R5pVxXvUXTonWF72zBH3Z/jttzbG3/FppuYYTWqWGxW7/NwRjWhsG21e4rNiW7wewgSiPI8GJtfVB1+iio/oUc3S5WAo9iYqiqCfQO0Lqq3I0GtEKTeCa9owPc2W95Fb5D2p8BbqrXNEeMAH9HDzVGteDn3Ug3rVJwpVNkZ8/lm92XB9hSrar69+tuYqiq39kecMj3PpqmZKltuHPR6XBQndBLHXZwyZTyL/H5Q18zhN5Fd5I+pfZFk0MlLshjOycHtM7vwNv5N4974JriprZY4r2iBKXej0qehJri9uB0JrXkfVr1d9/6vMjFlMhULoctHFBZj9ZbOxaLMccow9f7tmTH9m/PLVUd5LkNGFEOo6SXk1HlQnCHe2n0bg042K3sQmTsmhB5BKK/yAUutVeoATIo4fnZjg/xQlpFJcO/f/P7uJ2sMrvXXmVaf9Nc6nQPdbvPmeDa2dtdYpG8db24EXSZevgfFZm0QvC14lgPhlJddiDyR0t16xeGQNJNU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(36756003)(26005)(71200400001)(85182001)(76116006)(38070700005)(54906003)(64756008)(122000001)(110136005)(8936002)(66476007)(4326008)(8676002)(6486002)(478600001)(66946007)(66556008)(2616005)(41300700001)(66446008)(38100700002)(316002)(6512007)(7416002)(5660300002)(2906002)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDg4LzF6Sm5jY1VXSDJaVzdrY2gySFdidUdCY0I4T1ZSdUkwTVBWa3Q0bTZ1?=
 =?utf-8?B?UUVGdVhGN1Q2bmFUUllHMm1tUGkzWEt2REFZWWVzSkwzZDBBN01nUGRJUVFm?=
 =?utf-8?B?cnNkVWU1NjZtTXAxYk9aZ2FmdEdpcGk1Vm0raG51UDA2SzZqOWZqaUluUGZG?=
 =?utf-8?B?dHJiaVIrdHNqcW9NaFdoYi80ZWpjcTRNSEt4UWcycTBQemc2Y2xKSi9BeXJE?=
 =?utf-8?B?Q1diNjVFcEIvdjdJQnpmQ2w0cUEyRFQxUlk0bXJlSWc3SXlnOHpTMXZMK05S?=
 =?utf-8?B?a0tlUlNzNnVNNEZSNmhFdHFFcjhwcVoxNlRCUEQxRGYwcEpDTzRqMmxuNXUz?=
 =?utf-8?B?RXBHRXFrV2pCazRoTHg0dEZMYjBiZlhFL3RnRzR6TE1LOXIzemhxKzNqSUpY?=
 =?utf-8?B?QzlBQUwxUmlLS1k1R2VZY2QreHRCK1MrUHpxVWRab2JJVG5VWVgxNGpJQTNK?=
 =?utf-8?B?U1QwZ2ZMMXhWNTR1YytGR3o5TlJaTkZPbnhQWEppdnIvT1g5V2RiU3FyVWRv?=
 =?utf-8?B?d3laQklRbEsxUnA0ZkRlTkJxM1J3V3dCL1Y3VEJYdEtoaiszcmNIcEhRbXNH?=
 =?utf-8?B?eldhL3lwYzFVRDdaRVZ4VVk5OFpYRUk1bmNiUkg3bmNRZFA2ZlRLTkJqMG9h?=
 =?utf-8?B?T2g0N2M4eEhhRkphTHNYRG83ZWhFK1J0dTFKOGU5R0c0Y2lHVkNIWmRReTRG?=
 =?utf-8?B?d05MVnIwTk1HTFY5WXpoM29RcUI2SFh5L2QvTDkxcnlGbzNXK0ZnTG1HWFM3?=
 =?utf-8?B?Ym1PY2xkM2l1WVFiaVBWVUppbzVucTVIdUx5bWtCN2VIUVRsZWo0eVVFQ3cr?=
 =?utf-8?B?QWZNWWkxUk9uVlkxaHpJY2tBR1JpYm9GSHFXamJSOVJTMHlvSHplTkJ2REpP?=
 =?utf-8?B?WHFmM3JXVlpiMVBzVEJ0azUwSzN1K0FPdHR6S2NHMGFwd2xuRUtuUTkyYmNo?=
 =?utf-8?B?VXBTYm9aU3FobFZZYUlaUlVjR1BkVUovYzAxaXN2YzBPT1Npaks0dUc2bXky?=
 =?utf-8?B?bGVYZENTS1FBdThnall5ME1XbWVoVlhCMWdOMTE0aHRSNTVtalB4aGpGRERP?=
 =?utf-8?B?a21UelN0aTVqeEJ2UWIzU2YwVHFjQlp6S1Y1QjNnbHRnTTIycXMzYmdFUUFM?=
 =?utf-8?B?SVRDSWpmcHdjWmJyVGpkU3k1elQvK0F1QStKM1UxME9uWkdwWk44SVhrRFdH?=
 =?utf-8?B?QUwrRlg3eEU1bldUUGtQKzc0ZmJ6dXFzQkcxV1VnU3BjRVJ0VzVldXZFSzVh?=
 =?utf-8?B?Y2laVnMrTFhqblE2RU1DdlVsQURVanJHd0x1TGVvNHdORVJURCtGcjJuTGxt?=
 =?utf-8?B?Y1IrN0VoTmwveXRmTU16V0wxZUtKZW93NzFxQ3lLbHFHK3VTRitYMVlJRVNh?=
 =?utf-8?B?L2ErNTM1RkQwbTBiL2U1TnMvL0JVYkw1ZHZLaVZmQW5xSDNENzBkSkwvRUFi?=
 =?utf-8?B?M2Fka2cwNUpFTEc0STIyUzJ0dzgxQ28xc0M5WGJ6bEE1dkZhQnBwNU4zZnZG?=
 =?utf-8?B?cnM0T1R3ZG5WUW9qWTBEd3NIcGRDT2dYTFFqWTFOSXRiUmpKM2tVRHUwMU5j?=
 =?utf-8?B?VkhrVnowUktIQlJMZHNFNVBQVzIzR3FmS2VvMXJkV09leW5rcS9kMUVwUUZm?=
 =?utf-8?B?YWVGdU9mZWJCeVVISTlRMzl5RGJ1WHdpcGJpL3lzaGw4eFkyb05FMml1QStL?=
 =?utf-8?B?Kzl2SGJFOWFHbTFaeE9iZkhWSU9tajNObnkrY01yb1lDUnF6ZHFBRHJJSU1j?=
 =?utf-8?B?Tkt6MDd5b2tmdmdLLzFDWDAycmxmZHkxdXNxVTRZalVxSnJYT2lkSHU4ZFBR?=
 =?utf-8?B?bkgycVNuYk1XOExscU9SRW5qUDJsN3VSWnhmSGlURGVzMDE1K0dXVWhSelA4?=
 =?utf-8?B?NE9oQUh6UkUwUitkak53dW1UMGt4emI0MUxtbForKy9seFRMbU9CUVVGdHpH?=
 =?utf-8?B?NWg2UHlxVW04b25wN3RDd3J4bjVtcFFsQ05zRXdTbnhxYUdvam1md3dVRG51?=
 =?utf-8?B?Q2FFSGF3ZllWR1BQczlQRkcwNXNyTlR4b1FSbldleWJSdGRHQ1dXOU9TZFg2?=
 =?utf-8?B?N1hjUUdENTNISVhWTHBHSlVOU05JTEUxN2NQd0RBQ0NVaXhwQmVkSE0reGp2?=
 =?utf-8?B?NS9JdFZKMGR6OENob1M1NytMajlYNXczS0ZvU1doWW9XbklhZE9CMU9LY3k0?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE3BF5876DB7ED4CAD128FD50461733C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37402f29-a67c-4d72-314a-08dbc651532c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 09:47:59.2490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+a7iwM4/0Xp/eRLiWlKSrfKCmeVXoS/ll+8NVPVsKIKn/BaiCabv/XipfwLkMt9Lom3YcXmazhGBnjgIDmDSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7475
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBGcmksIDIwMjMtMTAtMDYgYXQgMTU6MzggKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IERpZmZlcmVudCBmcm9tIE9WTCwgT1ZMIGFkYXB0b3Ig
aXMgYSBwc2V1ZG8gZGV2aWNlIHNvIHdlIGRpZG4ndA0KPiBkZWZpbmUgaXQgaW4gdGhlIGRldmlj
ZSB0cmVlLCBjb25zZXF1ZW50bHksDQo+IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKQ0KPiBj
YWxsZWQgYnkgLmF0b21pY19lbmFibGUoKSBwb3dlcnMgb24gbm8gZGV2aWNlIGluIE9WTCBhZGFw
dG9yIGFuZA0KPiBsZWFkcyB0byBwb3dlciBvdXRhZ2UgaW4gdGhlIGNvcnJlc3BvbmRpbmcgSU9N
TVUuDQo+IA0KPiBUbyByZXNvbHZlIHRoZSBpc3N1ZSwgd2UgaW1wbGVtZW50IGEgZnVuY3Rpb24g
dG8gcG93ZXIgb24gdGhlIFJETUFzDQo+IGluIE9WTCBhZGFwdG9yLCBhbmQgdGhlIHN5c3RlbSB3
aWxsIG1ha2Ugc3VyZSB0aGUgSU9NTVUgaXMgcG93ZXJlZCBvbg0KPiBhcyB3ZWxsIGJlY2F1c2Ug
b2YgdGhlIGRldmljZSBsaW5rIChpb21tdXMpIGluIHRoZSBSRE1BIG5vZGVzIGluIERUUy4NCj4g
DQo+IEZpeGVzOiA1ZGIxMmY1ZDg0M2IgKCJtZWRpYTogZHJtL21lZGlhdGVrOiBBZGQgcG0gcnVu
dGltZSBzdXBwb3J0IGZvcg0KPiBvdmwgYW5kIHJkbWEiKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICAgIHwgIDEgKw0KPiAgLi4u
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyAgIHwgNDkNCj4gKysrKysr
KysrKysrKysrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5j
ICAgICAgIHwgIDkgKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRw
X2NvbXAuYyAgIHwgIDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRw
X2NvbXAuaCAgIHwgIDkgKysrKw0KPiAgNSBmaWxlcyBjaGFuZ2VkLCA2OSBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Ry
di5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IGluZGV4
IDQ1YjMwYTJmZTExYS4uOTcxZDY0MjYxZmI5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX2Rydi5oDQo+IEBAIC0xMDcsNiArMTA3LDcgQEAgdm9pZCBtdGtfb3ZsX2Fk
YXB0b3JfY29ubmVjdChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHN0cnVjdCBkZXZpY2UgKm1tc3lz
X2RldiwNCj4gIAkJCSAgICAgdW5zaWduZWQgaW50IG5leHQpOw0KPiAgdm9pZCBtdGtfb3ZsX2Fk
YXB0b3JfZGlzY29ubmVjdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UNCj4gKm1t
c3lzX2RldiwNCj4gIAkJCQl1bnNpZ25lZCBpbnQgbmV4dCk7DQo+ICtpbnQgbXRrX292bF9hZGFw
dG9yX3Bvd2VyX29uKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICBpbnQgbXRrX292bF9hZGFwdG9y
X2Nsa19lbmFibGUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9y
X2Nsa19kaXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19vdmxfYWRhcHRv
cl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gaW5kZXgg
YzMyNmE2NThkYzYzLi5hZTNiNmJhNjU1YjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IEBAIC0yNDIsNiArMjQyLDU1IEBA
IHZvaWQgbXRrX292bF9hZGFwdG9yX3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCX0NCj4g
IH0NCj4gIA0KPiArLyoqDQo+ICsgKiBtdGtfb3ZsX2FkYXB0b3JfcG93ZXJfb24gLSBQb3dlciBv
biBkZXZpY2VzIGluIE9WTCBhZGFwdG9yDQo+ICsgKiBAZGV2OiBkZXZpY2UgdG8gYmUgcG93ZXJl
ZCBvbg0KPiArICoNCj4gKyAqIERpZmZlcmVudCBmcm9tIE9WTCwgT1ZMIGFkYXB0b3IgaXMgYSBw
c2V1ZG8gZGV2aWNlIHNvDQo+ICsgKiB3ZSBkaWRuJ3QgZGVmaW5lIGl0IGluIHRoZSBkZXZpY2Ug
dHJlZSwNCj4gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpDQo+ICsgKiBjYWxsZWQgYnkgLmF0
b21pY19lbmFibGUoKSBwb3dlciBvbiBubyBkZXZpY2UgaW4gT1ZMIGFkYXB0b3IsDQo+ICsgKiB3
ZSBoYXZlIHRvIGltcGxlbWVudCBhIGZ1bmN0aW9uIHRvIGRvIHRoZSBqb2IgaW5zdGVhZC4NCj4g
KyAqDQo+ICsgKiByZXR1cm5zOg0KPiArICogemVybyBvbiBzdWNjZXNzLCBlcnJubyBvbiBmYWls
dXJlLg0KPiArICovDQo+ICtpbnQgbXRrX292bF9hZGFwdG9yX3Bvd2VyX29uKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gK3sNCj4gKwlpbnQgaSwgcmV0Ow0KPiArCXN0cnVjdCBkZXZpY2UgKmNvbXA7
DQo+ICsJc3RydWN0IG10a19kaXNwX292bF9hZGFwdG9yICpvdmxfYWRhcHRvciA9DQo+IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IE9WTF9BREFQVE9SX0lE
X01BWDsgaSsrKSB7DQo+ICsJCWNvbXAgPSBvdmxfYWRhcHRvci0+b3ZsX2FkYXB0b3JfY29tcFtp
XTsNCj4gKw0KPiArCQlpZiAoIWNvbXApDQo+ICsJCQljb250aW51ZTsNCj4gKw0KPiArCQlpZiAo
Y29tcF9tYXRjaGVzW2ldLnR5cGUgIT0gT1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRNQSkNCj4gKwkJ
CWNvbnRpbnVlOw0KPiArDQo+ICsJCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoY29t
cCk7DQo+ICsJCWlmIChyZXQgPCAwKSB7DQo+ICsJCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBw
b3dlciBvbiBjb21wKCV1KToNCj4gJWRcbiIsIGksIHJldCk7DQo+ICsJCQlnb3RvIGVycm9yOw0K
PiArCQl9DQo+ICsJfQ0KPiArCXJldHVybiAwOw0KPiArZXJyb3I6DQo+ICsJd2hpbGUgKC0taSA+
PSAwKSB7DQo+ICsJCWNvbXAgPSBvdmxfYWRhcHRvci0+b3ZsX2FkYXB0b3JfY29tcFtpXTsNCj4g
Kw0KPiArCQlpZiAoIWNvbXApDQo+ICsJCQljb250aW51ZTsNCj4gKw0KPiArCQlpZiAoY29tcF9t
YXRjaGVzW2ldLnR5cGUgIT0gT1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRNQSkNCj4gKwkJCWNvbnRp
bnVlOw0KPiArDQo+ICsJCXBtX3J1bnRpbWVfcHV0KGNvbXApOw0KPiArCX0NCj4gKwlyZXR1cm4g
cmV0Ow0KPiArfQ0KPiArDQo+ICBpbnQgbXRrX292bF9hZGFwdG9yX2Nsa19lbmFibGUoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiAgew0KPiAgCWludCBpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jDQo+IGluZGV4IGI2ZmE0YWQyZjk0ZC4uNWJkNjIwMjcxOTBiIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC0zNjQs
NiArMzY0LDE1IEBAIHN0YXRpYyBpbnQgbXRrX2NydGNfZGRwX2h3X2luaXQoc3RydWN0DQo+IG10
a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAgDQo+ICsJ
Zm9yIChpID0gMDsgaSA8IG10a19jcnRjLT5kZHBfY29tcF9ucjsgaSsrKSB7DQo+ICsJCXJldCA9
IG10a19kZHBfY29tcF9wb3dlcl9vbihtdGtfY3J0Yy0+ZGRwX2NvbXBbaV0pOw0KPiArCQlpZiAo
cmV0KSB7DQo+ICsJCQlEUk1fRVJST1IoIkZhaWxlZCB0byBwb3dlciBvbiAlczogJWRcbiIsDQo+
ICsJCQkJICBkZXZfbmFtZShtdGtfY3J0Yy0+ZGRwX2NvbXBbaV0tPmRldiksIA0KPiByZXQpOw0K
PiArCQkJcmV0dXJuIHJldDsNCj4gKwkJfQ0KPiArCX0NCg0KSSB3b3VsZCBsaWtlIHRvIHJlcGxh
Y2UgYmVsb3cgc3RhdGVtZW50IGluIG10a19kcm1fY3J0Y19hdG9taWNfZW5hYmxlKCkNCg0KcmV0
ID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChjb21wLWRldik7DQoNCndpdGgNCg0KcmV0ID0g
bXRrX2RkcF9jb21wX3Bvd2VyX29uKGNvbXApOw0KDQpBbmQgZGVmaW5lIG10a19kZHBfY29tcF9w
b3dlcl9vbigpIGFzDQoNCnN0YXRpYyBpbmxpbmUgaW50IG10a19kZHBfY29tcF9wb3dlcl9vbihz
dHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wKQ0Kew0KCWlmIChjb21wLT5mdW5jcyAmJiBjb21wLT5m
dW5jcy0+cG93ZXJfb24pDQoJCXJldHVybiBjb21wLT5mdW5jcy0+cG93ZXJfb24oY29tcC0+ZGV2
KTsNCgllbHNlDQoJCXJldHVybiBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGNvbXAtZGV2KTsN
Cn0NCg0KQW5kIHlvdSBzaG91bGQgYWxzbyBkZWZpbmUgbXRrX2RkcF9jb21wX3Bvd2VyX29mZigp
Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICAJcmV0ID0gbXRrX211dGV4X3ByZXBhcmUobXRr
X2NydGMtPm11dGV4KTsNCj4gIAlpZiAocmV0IDwgMCkgew0KPiAgCQlEUk1fRVJST1IoIkZhaWxl
ZCB0byBlbmFibGUgbXV0ZXggY2xvY2s6ICVkXG4iLCByZXQpOw0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gaW5kZXggNzcxZjRlMTczMzUzLi5l
Mzk4NjBmMmJlNzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcF9jb21wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuYw0KPiBAQCAtMzk0LDYgKzM5NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRr
X2RkcF9jb21wX2Z1bmNzIGRkcF91Zm9lID0NCj4gew0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgZGRwX292bF9hZGFwdG9yID0gew0KPiArCS5w
b3dlcl9vbiA9IG10a19vdmxfYWRhcHRvcl9wb3dlcl9vbiwNCj4gIAkuY2xrX2VuYWJsZSA9IG10
a19vdmxfYWRhcHRvcl9jbGtfZW5hYmxlLA0KPiAgCS5jbGtfZGlzYWJsZSA9IG10a19vdmxfYWRh
cHRvcl9jbGtfZGlzYWJsZSwNCj4gIAkuY29uZmlnID0gbXRrX292bF9hZGFwdG9yX2NvbmZpZywN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21w
LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+IGlu
ZGV4IGZlYmNhZWVmMTZhMS4uNGZlZjI4M2YxN2QyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gQEAgLTQ2LDYgKzQ2LDcgQEAgZW51bSBt
dGtfZGRwX2NvbXBfdHlwZSB7DQo+ICBzdHJ1Y3QgbXRrX2RkcF9jb21wOw0KPiAgc3RydWN0IGNt
ZHFfcGt0Ow0KPiAgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyB7DQo+ICsJaW50ICgqcG93ZXJf
b24pKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICAJaW50ICgqY2xrX2VuYWJsZSkoc3RydWN0IGRl
dmljZSAqZGV2KTsNCj4gIAl2b2lkICgqY2xrX2Rpc2FibGUpKHN0cnVjdCBkZXZpY2UgKmRldik7
DQo+ICAJdm9pZCAoKmNvbmZpZykoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywN
Cj4gQEAgLTg5LDYgKzkwLDE0IEBAIHN0cnVjdCBtdGtfZGRwX2NvbXAgew0KPiAgCWNvbnN0IHN0
cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgKmZ1bmNzOw0KPiAgfTsNCj4gIA0KPiArc3RhdGljIGlu
bGluZSBpbnQgbXRrX2RkcF9jb21wX3Bvd2VyX29uKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAp
DQo+ICt7DQo+ICsJaWYgKGNvbXAtPmZ1bmNzICYmIGNvbXAtPmZ1bmNzLT5wb3dlcl9vbikNCj4g
KwkJcmV0dXJuIGNvbXAtPmZ1bmNzLT5wb3dlcl9vbihjb21wLT5kZXYpOw0KPiArDQo+ICsJcmV0
dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbmxpbmUgaW50IG10a19kZHBfY29tcF9jbGtf
ZW5hYmxlKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApDQo+ICB7DQo+ICAJaWYgKGNvbXAtPmZ1
bmNzICYmIGNvbXAtPmZ1bmNzLT5jbGtfZW5hYmxlKQ0K
