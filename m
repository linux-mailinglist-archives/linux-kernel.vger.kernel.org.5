Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633FB7A45E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbjIRJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbjIRJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:27:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0744129
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:27:27 -0700 (PDT)
X-UUID: 922ae4d6560511ee8051498923ad61e6-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1IT+iAmk+2aqBwUC850EJ3xhkn8p9ojvXyAKRUG+Cvk=;
        b=o1MzbvHahDlJhqw7Gm57fD2qX/eqhbckMp03ea5inwlBH49+rDeEkkOVw1idB5NEireytiN3fdFxniVwxepvKLz5fSbxVsuLJWDFkjB0H3SdFDTsbP/guaIWlveU8dwuNB4ntv1PNNLeUUanMNyiD810yZYdpJX1Kw4ky9fncx4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:533a8bc8-50f7-4e09-a379-c19238bcd68d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:881ef7be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 922ae4d6560511ee8051498923ad61e6-20230918
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1167498125; Mon, 18 Sep 2023 17:27:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 17:27:21 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 17:27:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUIFEzA+sMvkyU5ke94RT9TvKnZTZ6dMzXSrnSNY7hRajlIfBf97yuxMWZ9wihZmByvHpk1XxfChatNKRo87iRdddFaQqoyp+1OordgETho0f72qVGWrjj60giuCRHXUuALs7Uf87jCEILmVIxsfXV4yDpltwwJFhQRDeqKeOlVJR5DOuxusPD6aHV8SiQnjtziAG0UK63/e/1HhYxK4wWVDE59X6qxBioCsBRlkQWVPu6Ikjrur4xZW2oehfXAmo7QIktCDVDXd6Rw1EnObIhEiTL17sxzCDI0ptHchKVsAM2GxsR60DmKl+b7n4qqPOXFAprAMclwG1JN1NEvnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IT+iAmk+2aqBwUC850EJ3xhkn8p9ojvXyAKRUG+Cvk=;
 b=SSOVDOy0BtD71A5kn0CcWqxhtSuea4l+9BnGJdSISu1RnaC0Lqo8ItvMhqfYZdebsCWKvPKFwed6UbNBtBIq/vfAhy+ync6VQ0EAN5FuR0TdDO2VB3CAzZuHN0pB/rDJWhmj8eR5eie4fSVQWq1Rz2P/igyxWFPVVXgpSUB2D0+3WzCHMlWlIcWJ4zoYQ91dBg1lyX7ihIuJ0kSWusnMUarbW8mkvwpb5JbqbHhTcAbaE2AweFH7+QXejISLXw81hyfoYN42pdbDleH/HbKrn7nEkCCqpigWV+FxoNuihWh8lZsuZbE6HEQEPmD/6pHH2wq3QfQVKH47oPtT6rc2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IT+iAmk+2aqBwUC850EJ3xhkn8p9ojvXyAKRUG+Cvk=;
 b=uynGUQu4g4h5CE5XEsI1C2t2mu0RBJFIzb5sGmWTS8MIPd2nZHEk7ZJgx+zM3qb5/4zasnVvuSNwZ+UpqWrWc+AN0kn0nRJdHyZXiy+k6fJr7EefNDYd6K601QI6M/Y1c9WZfwNSw6QuOiDgCU0TpoLqgdF8fU4UCS58ExNl5Yk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7915.apcprd03.prod.outlook.com (2603:1096:101:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 09:27:18 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 09:27:18 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH v2 04/11] drm/mediatek: Add OVL compatible name for MT8195
Thread-Topic: [PATCH v2 04/11] drm/mediatek: Add OVL compatible name for
 MT8195
Thread-Index: AQHZ6gwiYoEmHBjFLEC9YeMNqxBairAgS3iAgAADhACAAAGOAA==
Date:   Mon, 18 Sep 2023 09:27:18 +0000
Message-ID: <38acab5ba98948ad496daacff9b3e374ee0e547c.camel@mediatek.com>
References: <20230918084207.23604-1-shawn.sung@mediatek.com>
         <20230918084207.23604-5-shawn.sung@mediatek.com>
         <ffcf35cb8ca1ff0fe0a0f0176e3199b9c944b3b9.camel@mediatek.com>
         <30cc93a5-b3de-d23f-fd4d-e695551a71e3@collabora.com>
In-Reply-To: <30cc93a5-b3de-d23f-fd4d-e695551a71e3@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7915:EE_
x-ms-office365-filtering-correlation-id: 9b4703a0-fc1c-4fb7-21b5-08dbb8297452
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7khfIox21FU2kQFcVX4GC8MmAWATI7zTyibSl5sjYV1vMvU+bb5PmZIf/vjt80WDxFbQYomqPja8pMo5NELF31LAWcheU+RZuAw71qs5By5jCydb2o+fXlas+n+KqhAamDp/vOq5A4RxSiyTH7HSXRr+2jaQCrAEHo4EtN75eBqDM4a5CtfXvQuSViEiyEm9QmrfWT4T9utSjYKmcPVKhOb1HsdOOX8xCDw4ERoD/+nPQSGFVqUuInE0e2lGNFOe62a586jmD9bHBlGNgvB6zhmyQS6CN36gRHnezfD8TIRvFaYw0eCANew8NwEeQ1WQO98+KaDYg7/1cafE18uaQ1RZFm+A50DIyDIL4mnBdzGQ2q/GnZsEu60/l0LjewWVLKi7YUsAb0z/YiI6Z0uQZovPMckj0fqJc1lCAAESae9ssr0DLOuOPasLaTObzhEeufqtt6Tyn+YH8pxQur0ZuyDTQikaIoW0bxGP2yDv6mIm0bcBIxw0jSFnqbtb/cyR6lCVVMtnmlvrv+YiAizvzZQk5w/VVjKS1XRdB6gOBYCpye3rU75RWQcJhkB0QP1hLHYpIMdPevL3uRUoFAQXYBcksWzib1qjxrfGxbLaxrt1AEo6qbSnoFAgCWPld35OFB4wp/Jc7BoCoKlNpw6Ylet6RAQ5cvv5zekEmbcbjXA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(1800799009)(451199024)(186009)(7416002)(2906002)(8676002)(4326008)(8936002)(5660300002)(41300700001)(66446008)(54906003)(64756008)(66556008)(66476007)(76116006)(316002)(110136005)(66946007)(478600001)(122000001)(36756003)(6486002)(6506007)(6512007)(85182001)(26005)(2616005)(71200400001)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVh1ckx1N3dYYWZWeXF1VnVKNkVOZVZHa0RZdGNzTWRRaGdHUEcrbUFCdU84?=
 =?utf-8?B?YWczTXQ3Mi9tL0krQUs0ZE5ERXZrOUpUN1R3NGw0bTlyNXp4NjNYQ0ZZK0ty?=
 =?utf-8?B?ZEs4SlhNNWFIcWVKRFh1MDdPb2xTdks1V0JRTUtQYTV4WFRKSkszbTRxQmFs?=
 =?utf-8?B?eUZWRmRiNks5NDZxZ2RyN2ZNLzNVdkdvdEdKQ2dHYUZCQm5IODVQUXQrbnU2?=
 =?utf-8?B?YW5EQlZ6YnUwZzdKMlRzKzl0U3FKOThyVTQvcWFhQUh0a1c3dFdLVElMU2JF?=
 =?utf-8?B?M2dIOFdiN1Y0R0hZb09MRDh4K3RJeG95c0U3K3EraEwwd3h6anh4VXlzaERt?=
 =?utf-8?B?T1JGV21UZFVDMTZQRkxVejBVbmNkZUQ0ZVZWVkxmNUlBcGtPWWgrSDMra25I?=
 =?utf-8?B?Mi9JbzBId3luR3JaU0tBd0UvUnZwa015VnRsL2JtdXU5WFUxTG1XamFGejRv?=
 =?utf-8?B?ZzBTeTJyaWZzL2d0cER4OVdpTVVneVBhYWFCTVN4VEpTN1dHNkVwRGNlNUZI?=
 =?utf-8?B?RGJmbVFiOCtOZFpZRmVBYWU1UWRJNGJ1ODlzdVB5RnNKVXFPYW9jdkNabjdG?=
 =?utf-8?B?UjRFSk1vNkVFSm5pUWZ1RGlLUXlJcVVuYlBkblhiRGNkeGNBdk5jeStCYlcx?=
 =?utf-8?B?aGptL2dlWGFCZG1CR0xWK2ZoMjBydEpIWnNmbk1ReGtGaFl5Z29WeTlxQ3Rn?=
 =?utf-8?B?NmQvYnJvOGhEcy93WGlpVFdDclhST1dhMnFIYm5ZdXpJSW0wY2ZhSUZlOHJa?=
 =?utf-8?B?UXl5QTRKQXRTT2hRS1BRWGFBVWh3dGkyMjFlSUhibGpCNy9XTVFXMFJJQW5t?=
 =?utf-8?B?amRSM2Q4b2JjVm9pb0lNeWV5U0hKY2JuOXFqdTVBaGw5a0VVV3NqdHNLa2h4?=
 =?utf-8?B?T1V1cWVGV3hKU0lDbmVmdTUxdTQ0cFVKejhidWRFV0NMaEYyakJjZEZRWXJP?=
 =?utf-8?B?QkU4Z0k2WGwzRzB5YWk3K3hkY3M4MG94RzRwK1VwclBxREN0MWlVdTNCdjlJ?=
 =?utf-8?B?VEp1T0N4aEQzOFNMZEhBUUNkRVVUSVVMcGFYRnZQdjF6OG1yKzF2TVh6bUxa?=
 =?utf-8?B?bitwejVUZ0QxcWtJT2NZazMyY21MODNZQ2lldExkTURSaVZ5OCtIOHBzcVV6?=
 =?utf-8?B?RStVTTJ2WnAwL29GVmZpMUNhWk5kN1VNU2txZDdVbTBrcHJ3bjQ1RlVKWnE1?=
 =?utf-8?B?Wm51ZDRUakZId2V6NWNDV1ZrKy9EcnBhV0daRFdVNDR2K3lTdlhMbmRhcmd5?=
 =?utf-8?B?TS9HeGxDbzYvbFZvU040RVZiTlUzZ1FhRyt2cDZhZlEyU01OQUxWcDdzRktH?=
 =?utf-8?B?c0ljY0ZNOGFFOC8vbGp5dzNEbXlvNmVTdTJYNW1SZlR3SE5XVkVtZ1FEZ29m?=
 =?utf-8?B?QzVVYzRFTXBneE1oUVZKMVoxUjM2QTNCZmJ5M0hqYVNHVWRNUExkeWlWMnky?=
 =?utf-8?B?RDdUTkZlVjRRak9LRno4MThobzhNdk1mT1dBdVk4dHcwVDV4ZlpRb045YW1s?=
 =?utf-8?B?cFlPQTcyVndyanFkZ2hZYzhuaFRxNzI1TFpzSkp5NGo0ODZpQlJBQktTckI1?=
 =?utf-8?B?TXhLdGtXT1EzNlJNTXJsQWdjRTV5RDg5UER0NVpTdW1LRmxOL0lmRUJNRTJX?=
 =?utf-8?B?ZWgxMmFuOHYyZmRJK3hrZzN0T3NPQ21yNTBPOXlhY0UzQnBZaGhoTWRlYXky?=
 =?utf-8?B?UVI4RU82MWpWVlpIRVRLbWxGdXJ4TmdOU28xZWU4TjVUZG95TjFzRnFLQm55?=
 =?utf-8?B?dFRvTlM0d1JxY3VXaDFSTUladHhqR1ZHMXluWkNXSCtzT1Jwd21DR3BxZWNi?=
 =?utf-8?B?cjRqYWtYMytyZm5mS0VEYzcrdy9VMEJQTFV2MWhWbC96N0ZKQjVQbkU0d29i?=
 =?utf-8?B?MkpYNkF2L3hpN2dRY3N0WFNxSllzbzRHQjJmaE5wTXZ4Q0RHQUo0UEo2OUpn?=
 =?utf-8?B?Wmd0TkQzeDFOcHcyTE1YRnppMGVyRVE4ZFFZZVI4eHd6VDY0c2dmNW5oUVNj?=
 =?utf-8?B?VVlsVDMvT2RoUEMyblV2NmJiWUJWLzJscnNLb1hXek9yRnRUUXB0aUxSV0tG?=
 =?utf-8?B?cDFoVFhUSnVhY25Fdm5kMkRDenlQUE52T1hRSFFMSzFETjZWNnRDczlwZ1ZN?=
 =?utf-8?B?NGY3cy9hWFl6ZUlwZERVS09yaHJNYURQaVI3cCtnYzBDelVhWmJoeGovUXd1?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C325300900D8A745901EEA78AB3D17C5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4703a0-fc1c-4fb7-21b5-08dbb8297452
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 09:27:18.7409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23BKP+aKp748Y7GQma80FXbLTnF9DexpD/OdDMrqORDBBadwpD6w2mkdNaqaKNvish6zBIT74+EPXqU+81dixA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7915
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTE4IGF0IDExOjIxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTgvMDkvMjMgMTE6MDksIENLIEh1ICjog6Hkv4rlhYkpIGhhIHNj
cml0dG86DQo+ID4gT24gTW9uLCAyMDIzLTA5LTE4IGF0IDE2OjQyICswODAwLCBIc2lhbyBDaGll
biBTdW5nIHdyb3RlOg0KPiA+ID4gQWRkIE9WTCBjb21wYXRpYmxlIG5hbWUgZm9yIE1UODE5NS4N
Cj4gPiANCj4gPiBSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gPiAN
Cj4gPiBidXQgaXQncyB3ZWlyZCB0byBwdXQgdGhpcyBwYXRjaCBpbnRvIElHVCBzZXJpZXMuIFdp
dGhvdXQgdGhpcw0KPiA+IHBhdGNoLA0KPiA+IG10ODE5NSBkcm0gZHJpdmVyIGRvZXMgbm90IHdv
cmsgbm90IG9ubHkgSUdULg0KPiA+IA0KPiANCj4gVGhlIGRyaXZlciBkb2VzIHdvcmsgYmVjYXVz
ZSB0aGUgZGV2aWNldHJlZSBub2RlIGRlY2xhcmVzIHR3bw0KPiBjb21wYXRpYmxlcywNCj4gIm1l
ZGlhdGVrLG10ODE5NS1kaXNwLW92bCIsICJtZWRpYXRlayxtdDgxODMtZGlzcC1vdmwiIHdoZXJl
IHRoZQ0KPiBzZWNvbmQNCj4gY29tcGF0aWJsZSBpcyBtYXRjaGVkIGluIG10a19kcm1fZHJ2LCBh
bmQgdGhlIGZpcnN0IGlzIG1hdGNoZWQgaW4NCj4gbXRrX2Rpc3Bfb3ZsDQo+IGFzIGJvdGggYXJl
IHBsYXRmb3JtX2RyaXZlci4NCj4gDQo+IFRoaXMgY29tbWl0IGlzIG5vdCBuZWNlc3NhcnksIGV2
ZW4uLi4gOi0pDQoNCg0KQWdyZWUuIFRoaXMgcGF0Y2ggaXMgbm90IG5lY2Vzc2FyeS4NCg0KUmVn
YXJkcywNCkNLDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCj4gPiBSZWdhcmRzLA0K
PiA+IENLDQo+ID4gDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1
bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIHwgMiArKw0KPiA+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+ID4gaW5kZXggOTM1NTJkNzZiNmU3Li43NzU5YTA2
ZTVjMGUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kcnYuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2
LmMNCj4gPiA+IEBAIC03MTUsNiArNzE1LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQNCj4gPiA+IG10a19kZHBfY29tcF9kdF9pZHNbXSA9IHsNCj4gPiA+ICAgCSAgLmRhdGEg
PSAodm9pZCAqKU1US19ESVNQX09WTCB9LA0KPiA+ID4gICAJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxOTItZGlzcC1vdmwiLA0KPiA+ID4gICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJ
U1BfT1ZMIH0sDQo+ID4gPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWRpc3At
b3ZsIiwNCj4gPiA+ICsJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfT1ZMIH0sDQo+ID4gPiAg
IAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kaXNwLW92bC0ybCIsDQo+ID4gPiAg
IAkgIC5kYXRhID0gKHZvaWQgKilNVEtfRElTUF9PVkxfMkwgfSwNCj4gPiA+ICAgCXsgLmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWRpc3Atb3ZsLTJsIiwNCj4gDQo+IA0KPiANCg==
