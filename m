Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D2C757A62
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGRLZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGRLZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:25:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50902D8;
        Tue, 18 Jul 2023 04:25:04 -0700 (PDT)
X-UUID: ba57c0f6255d11eeb20a276fd37b9834-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=o6A0kgE0RNVZkpDR5Vb2uz993zV3sdow3i8lL3Q3fU0=;
        b=D6/n44S7yKqoTYKofyW9rMoZ43EDA2mMR4FWprSUG4TY5ohfS271eC2xJFjNgRHn3eR9mo0II9dWW8noUUpTAp2Tri/Lr9ocK8hGjvf9u1gNrWMZUWJve9fLSctvF8aVLWT1PgdWQV9gSmg33HQO/9dh+erzZnsz3STzzlXEIog=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:94274d0d-98ab-4a4d-93b2-bdc0c4126dee,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:1109d84c-06c1-468b-847d-5b62d44dbb9b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ba57c0f6255d11eeb20a276fd37b9834-20230718
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 312997043; Tue, 18 Jul 2023 19:24:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 19:24:57 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 19:24:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj+oUNYxMVrrSKHJ/XzA+9oUNdmtFDY2V4ah2uXmpNgzc5pu84d1LLnTPBVaU4fS0uoWzIj/v3elXqfYGm4ndJfcJf233O+blD/Utcn3h4Ofqllg3YMw/48Deq94ow7/9hMYHi9m6cFp59j91oszjBw4ndFtzLt2VJZnnX05sIWPKABVBmSYhmMs1TPH5eKHITK1wNdApj8zvrwp5GrdYW4Z3ZPI0kfaAEaVpndz5pIR73fd3CPTaInAKEKV6PARWXBmmO5cY987nPiWhimbxfwb53ZqxZbDt2zco1e8wC7H1DWWcOYApynm1vpcv2ZEfMgWDa80P6jsqlCJUOzEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6A0kgE0RNVZkpDR5Vb2uz993zV3sdow3i8lL3Q3fU0=;
 b=hj+8DMoiv5l/bROEPiYIJswkkt5JAYasRx+vtzzEWoL94zJyP2hx8SN6D9WluRpBUc8DTO/J5UYR4S6Ijuz+igecV7hglri1vRYx6eRksNuasM0acV5UGtFTB+4yxazI6Xb6hPWPw+cqjZsEkY4C4RrFRAGNB7rTu/B7JyBEJIiRBUlmlqcnfWXzrv3IKNIe7+ZA7hQ4muBu+F3KZuMdu7ZCcOhw4L2Tj6jyx7RfgvnlqJscVOoDFVnUykwEWkkR/AwiIIfGssbCW9ad8FcLolKYhF3WPYeO/gN+geRHaGyM9akH4/3oawV7jJzPMcwIGzivuYyeVWQc3XtknlvLFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6A0kgE0RNVZkpDR5Vb2uz993zV3sdow3i8lL3Q3fU0=;
 b=bNqecpXiHwCUN4dF1QUV6IAx5I3KxaeMpcsckXle+p6ZG60fyJMsYzDtewE+NTcdO43IkPihf9wRwnrMEBjDbD3HBNn9g4GjHZOQuqH2olBqtJr4SpXBGu60Rslb2mlKHsf2fEUXvTTwrJgQA61ZkLEpWxwHY9MRmLkVLK0I7/I=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYUPR03MB7111.apcprd03.prod.outlook.com (2603:1096:400:350::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 11:24:49 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a441:8f4:4de6:2437]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a441:8f4:4de6:2437%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 11:24:49 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "fshao@chromium.org" <fshao@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 00/14] Add display driver for MT8188 VDOSYS1
Thread-Topic: [PATCH v5 00/14] Add display driver for MT8188 VDOSYS1
Thread-Index: AQHZqMJC4tyviik+BESGu/gpOlEQLK+/TKqAgAA2vQA=
Date:   Tue, 18 Jul 2023 11:24:49 +0000
Message-ID: <8b30158153abf2b24a78e6d0aad782876b63eb20.camel@mediatek.com>
References: <20230627063946.14935-1-shawn.sung@mediatek.com>
         <CAC=S1ng0sLRt0vhB2Rpk_vetQLu9Kro+JREWf-wpkkO6dNKiwg@mail.gmail.com>
In-Reply-To: <CAC=S1ng0sLRt0vhB2Rpk_vetQLu9Kro+JREWf-wpkkO6dNKiwg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYUPR03MB7111:EE_
x-ms-office365-filtering-correlation-id: 403f069b-d360-4d15-690a-08db87819917
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xVzU8OQHPfjZ5hJuge1GiDQDi6ypjEA+r2gSb4Twn5CPFI1nvXEoyZ9jy+x44+1edx5Ptg+IFUq/wtNSTdgSQyW+LrYZwwLGJJuH0iMVhojlsDRl0bHfYMdwuJsb6mYJEh8Ba+ZQFZ7YK2f9r6uTMXBzB1pFXNRvvBxTd5NSSUML4//s/ocbFtclWeZh8GPUNRB2DwMjObfqpaHAz7qFsEqTcVkbDPTy5HymljatQK+NH/GSREA/R1215/ivFgzgzirWkJRkyHPwuiDT6mKczgPXWuHBlsO/xrzZoMCmuzkrmB8ZOMMlP5rL/TSHFzIafgkQhbSby20L/IT/nSPzEh5+HnHM9BHEevZX00CU9a004TEDHM6esh5owqgAZNxvFbddUckOAScdoiRN4EOf4lkKq0OOOpZDsKiSG1lZoU4Zpj2bO1X+HMgB8w+7vDZA30fr3XrRT9V1sW0V+aXM8g3nkvnRY385oEgZDcXi/3biMwYM6EudHcxj/ZOzd8NEaOBlWCvrnUlhM1It2GcloR0OddDSrBI0JYLAlWzmZYqpTPODunqyaOxVZehycAow8xW9tun1rrsoBfofDg+zJpZ/M9KaOfFO45oAv5e+ollhP8Vn1cLsvhFI9zyfCDrRwos0/4UR4c9jtttRAM0Nhv3TYw3gqBWxh8L62n4XklA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(8676002)(41300700001)(7416002)(66476007)(66946007)(6916009)(2906002)(66446008)(4744005)(8936002)(66556008)(6486002)(54906003)(122000001)(76116006)(86362001)(4326008)(316002)(2616005)(64756008)(36756003)(5660300002)(6512007)(38100700002)(83380400001)(186003)(26005)(71200400001)(6506007)(85182001)(53546011)(38070700005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWdQL2Ezd1d4RjVJSkdkS2w2M215a0Z1VHdZV3lxS3BZRHZqclR5OVpKYWl2?=
 =?utf-8?B?b2ZudGM1WlhNbTRUNHgyWDBhN1dBSGtEUXoyOGNVZ25XQkZETC80WjJueFZn?=
 =?utf-8?B?WlF5TzdaK0FINXN4R0pHWTE5Y01Uc0RDbGlOYm5Xb0ZqQU8yMTIyM1k3N3Ri?=
 =?utf-8?B?eWk0dFgzQytzY254KzN1c0JPbk1DVXRIQ3dMQm1SdDdaN3c5dWx6NkxPRjh4?=
 =?utf-8?B?clloSVlhK1Nmdy9IR2FjWWY0L0Vhb1NPRUNvQi9ObkprYWN3aVdUUC9RT0h2?=
 =?utf-8?B?U0NVMHc3RStSRTRlN1poSE04QnYyZkkxSEd0dmp6ZEVEd29KaytJVGNqRWFX?=
 =?utf-8?B?UnpaQ21MWXpHdjhNaHhNV2lEOS84OHVDem4xNnRGb0dlaWlPSmxJdWVXL2F2?=
 =?utf-8?B?L20zR3QyNzhBakZIN2xadkxJN0dnRlZXeFdybzBQZzYzSzRpS3lpN2lMcjFM?=
 =?utf-8?B?eGhJbWp1YmZQWHFlNmhCZnhkNnZLd2sybWxPT1pkbExmbnQ5bUkxbjJJZ1hs?=
 =?utf-8?B?MW1sN2QzNjBPbzRYd3RRR1BzY2YvNVBXcTk4cmdRa25KTjd1ZEdURDRIYlhT?=
 =?utf-8?B?ZUJFNWpxbURyK3R5dEU0b2ZrZU01ZjhDR2JhVG54YkMwSkxFWDYyZEdrL3cz?=
 =?utf-8?B?TDF3SXZmQ1d1KzBmcFNzczJpMkc1MnMxYTc3VzZROGlwaFdFWWdzWWxPdXA3?=
 =?utf-8?B?Q2gzWk1GTnZGOWJHbmRIa0E2K1F0WEZxTXJqbkxibmJxN3d3K0praHRwK0ZQ?=
 =?utf-8?B?amNwS29nYjIzTHg4aGo0R3lrUjJsQjFHdW9zSUswbGVTQkZhWlhyd0lvczNH?=
 =?utf-8?B?NnllMVVTWVVyTnFVc3ZsaUFuQTRZdStQZWxhem1NMys5b28wTCs1Z2tnSmxZ?=
 =?utf-8?B?U1l6ekcrc2ZoM05IbFU5aElWS2d0b2RYMGE5S3U2a0JNNEhjTGZpdXE3SjZP?=
 =?utf-8?B?M0cxRkFzTWxNOXN4YkdpR05YeFdWUmZ6bGZuQ0Z6cHVnUnE3dTdYWjMrS1Z5?=
 =?utf-8?B?eG9BZFRJbUNOeXF4SjltWmZuNXdGSFRLbmtwUGgyMXRqbnpIT3F1TTlUUDlZ?=
 =?utf-8?B?eVV5dU0xRzN5WEl1MEZQNWVHcFFIUHRROTBNRHZPN0ZXZWgxTnVZd0RKY1N1?=
 =?utf-8?B?eXNWc2lXbk5zQnk1UmxvTWsyKzBGMzR3R3EzWmRnM3ZTby92MHNWSzR0eURa?=
 =?utf-8?B?eWkxY3A2M3NKMGxJaUdqSm9zYTFUV2xqSjRrYmc4djAyRzBoSmNaZmhMS3pY?=
 =?utf-8?B?Q0NnWUdzV3AzSU9ZeUFUalRndEdQYkwvV2xRYnJ0ZzJUSndzOS9hSk9wQ2JH?=
 =?utf-8?B?SXBZR1dVVXJ5Nkh5VHF5by9zeExLd0kxT1ZnM0V1eHg1NXI1MkVHOTNEOEx1?=
 =?utf-8?B?NkhUUVE4ZGs3UWd6YmQwQTd1OUpQa2QrVHF2T0lzNktOQjZlSkhQNVpaK0JB?=
 =?utf-8?B?WFcreldFVzYxUUZhSEJKNTBkc2FtdmlhaGZDdC9wNXg5N1JqSzIwV3VSMU5s?=
 =?utf-8?B?UEh6cTVQL25qUC8wUFovK3ZWZ20rQ280L0JjQVc3TWJUQVMwblRQN0dvNGY5?=
 =?utf-8?B?WjVLbytURG9JYzJUMTFjc1U2NVVRNE9BNERhaWRyWGx1NDdTNXc1Mkc4NEI5?=
 =?utf-8?B?RWNWeFBLQTVNU0p1eStuOVZnWWgwM0ZNR2dEbDVxUlByV0xlRmlTR0g0ZmRV?=
 =?utf-8?B?TkQ0cjM0dmhzZDcxMnNadTZKa0tVQlFoVytZdzBISjlkSVpRNHFLTDhmcEFX?=
 =?utf-8?B?eDlOU25BNTd3OEdTVWpwaHIvdU9MbXl2czdlSWg1Vmp3N2hKVHBLV2hCQWEr?=
 =?utf-8?B?djRFdWwwb2o4Wk9NSE9iVWMvMUR0b2E2ZXBXVGwxZi9YRG5wc2ZScjQ1QjZl?=
 =?utf-8?B?cFl0TVhVdjYzd2JmaC9GV0hRbEEzR240aGVEZUxnWjMvckx3V0JBM2tsTGk0?=
 =?utf-8?B?bDdyQ3VERkk0SGlYak1Hb0d5WE0zTXRybHNmdzBFQzB6Q29MdVJzMHV6UlBi?=
 =?utf-8?B?QzRiTkl5ZWFuVnBEV04yOEJCbUlHVUZRLytXcVhRWWsxZUtSdEMxcDc4N0Qz?=
 =?utf-8?B?bmFkVlFZQXB5Z0hmTHY0RzZMNHhUZkh3RXUxMXNwc09qVFpmYVpjUjRLdFN1?=
 =?utf-8?B?K0I4L2tucDVRc09qZXJHY1A0dG1pQ1pRcWs0RWJKQWFaYlllMWw1L1QvVFVT?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94CD492E6887164996FB0C64FE382605@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403f069b-d360-4d15-690a-08db87819917
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 11:24:49.1562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfk2sZ0W9cl28x38PnYLkEJA+TAGlClB5PuOBfduaQ2vm0p1HXleWF6suKvno6dt+2wGf4+yCw+tQuBmFiSDsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVpLA0KDQpPbiBUdWUsIDIwMjMtMDctMTggYXQgMTY6MDggKzA4MDAsIEZlaSBTaGFvIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIEhpIEhzaWFvLUNoaWVuLA0KPiANCj4gT24gVHVlLCBKdW4g
MjcsIDIwMjMgYXQgMjo1MOKAr1BNIEhzaWFvIENoaWVuIFN1bmcNCj4gPHNoYXduLnN1bmdAbWVk
aWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IFN1cHBvcnQgTVQ4MTg4IFZET1NZUzEgaW4gZGlz
cGxheSBkcml2ZXIuDQo+IA0KPiBJJ20gdGVzdGluZyB0aGlzIHNlcmllcyB3aXRoIG15IGxvY2Fs
IE1UODE4OCBzZXR1cCArIGFuIGV4dGVybmFsIDRLDQo+IGRpc3BsYXksIGFuZCBJIGZlZWwgdGhl
cmUgaXMgc29tZXRoaW5nIG1pc3NpbmcgaW4gaXQuDQoNClllcywgdGhlcmUgaXMgYSBwYXRjaCBm
b3IgZml4aW5nIERQSSBtaXNjb25maWd1cmF0aW9uICguaW5wdXRfMnBpeGVsID0NCnRydWUpLCBi
dXQgc2luY2UgSSdtIG5vdCBEUEkgb3duZXIsIGRpZG4ndCBpbmNsdWRlIHRoYXQgaW4gdGhpcyBw
YXRjaC4NCg0KPiBXaXRoIHRoZXNlIHBhdGNoZXMgdGhlIGV4dGVybmFsIGRpc3BsYXkgY2FuIGJl
IGxpdCB1cCBvbiBteSBlbmQsIGJ1dA0KPiBJDQo+IG9ubHkgc2VlIGdsaXRjaGVzIGFuZCBubyBt
ZWFuaW5nZnVsIGNvbnRlbnQgaXMgcmVuZGVyZWQuDQo+IENvdWxkIHlvdSBjaGVjayBhZ2FpbiBh
bmQgc2VuZCB0aGUgdXBkYXRlZCBzZXJpZXMgd2l0aCB0aGUgZml4Pw0KDQpXaWxsIGRpc2N1c3Mg
d2l0aCBEUEkgb3duZXIgYW5kIG1lcmdlIHRoYXQgZml4IGludG8gdGhpcyBzZXJpZXMgYW5kIHJl
LQ0Kc2VuZCBpdCBhZ2FpbiBpZiB5b3Ugd291bGQgbGlrZSB0by4NCg0KPiANCj4gVGhhbmtzLA0K
PiBGZWkNCg0KVGhhbmtzLA0KSHNpYW8gQ2hpZW4gU3VuZw0K
