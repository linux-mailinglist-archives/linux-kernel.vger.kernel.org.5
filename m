Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460D1767BEB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 05:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbjG2DcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 23:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjG2Db6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 23:31:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6352D44BE;
        Fri, 28 Jul 2023 20:31:55 -0700 (PDT)
X-UUID: 734194f62dc011ee9cb5633481061a41-20230729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4T6sdv+LvMW/MG2TFX60jpyca9gCpekQCG4/pKFLzuM=;
        b=ErgQDyEbOp2+E99BYG5o+U9Rhd128lAEx+Jqvy4OHcVXE+UoFLfnEV0Ofi3rlgyk3RPCsMUhuypnDx20Wy4BObvuezXfJ8zmImcQO6/hiQc+lUnSg4+uVvOFfq7WhYRNiFmBrAmsjVDVB3cfylSo+E5/BGshAY4OaYfDbqfb3rw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:40665960-6a75-413d-9392-17ef5b297b72,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:2ed8e9b3-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 734194f62dc011ee9cb5633481061a41-20230729
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1120676641; Sat, 29 Jul 2023 11:31:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Jul 2023 11:31:47 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Jul 2023 11:31:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIugH+WTVY2d6ZWjwqcbkKc7DUumcMX6q75AA6SDb8gJLizLniUKv+lqEUMpLm/+qSDj3OWh1eDxY56jrahjtTTn2ZRSRrrG3jz51CsT3Mwzgnyo9BYwrE+F8qxsce7XCbf6pkINCHsbjgoTiyG2bkZSL68wJ06cDnHsdrcOcaqyipDS6S45tc3rKP8ZdN9sIZOH1h/9CQBvzpWylLr7d1dL8U7jDo+aJuG2nikGXqelKYu9V+2qBsOTv+SLhDlMvwXqdL8js6ulaDNaCC34gdvrTvNZPmmfucEBqhFk1YX69QIj+ZXTlWkrKwP63meKMg+EPtV1Z2hL3Dm2NcKfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T6sdv+LvMW/MG2TFX60jpyca9gCpekQCG4/pKFLzuM=;
 b=mf95cebOOaj7mJKSK8s1ttIzZHCHDtcKv31R3TsQ4myT1nB7a9oijHhXu5uZRf5bGSFqfBDAPTSnXuHG0vEjTG1N+hKSLZOy4acPBR4Kp3qF60nvS5m0E4j9d7OAdofkrNmdA0xccj8PjFbBuPPSgonivvSNEWvYazMrUh0ajBKx/MOXZiboQ6q3gY3Qb2PySoJeDlA3y5XWzV7WzhCL31EVtRdxCWSA2Pi7Q+fxfeofcjbyR8vO4HROrq3jZRdVrEKS2uGup6AoJR7eACOpJU0jKMT3K0G5NYCd2uvAXgJTtOzoR8TlKPepXq9WW5R4OKO1euP37lChr3RCuDl0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T6sdv+LvMW/MG2TFX60jpyca9gCpekQCG4/pKFLzuM=;
 b=qmBMUnsFKV/6TCx5QHMNX7kvEWmIq6kM5es/tKJi5rTGfIXaWhaoNkcHCj6lD6s2jowFtkZ33VAwiKG0h+3Y7eQYY23rw1kFeoR6QSG68U5zZzRve+0eiCrOIXteiitOwtQWwnz6eeklXsz68EeXkb235s+qr4z3iGfwoDy4Imo=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB6495.apcprd03.prod.outlook.com (2603:1096:400:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 03:31:45 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::b637:cc4e:c9bd:64d]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::b637:cc4e:c9bd:64d%3]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 03:31:44 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        =?utf-8?B?TWluZ2ppYSBaaGFuZyAo5byg5piO5L2zKQ==?= 
        <Mingjia.Zhang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2,0/3] media: mediatek: vcodec: Add driver to support
 10bit
Thread-Topic: [PATCH v2,0/3] media: mediatek: vcodec: Add driver to support
 10bit
Thread-Index: AQHZvHBx/huLhEsfFEGsbf+FOHiHJK/JWA2AgAbJdYA=
Date:   Sat, 29 Jul 2023 03:31:44 +0000
Message-ID: <a733d1a42f7a73e227552f54b3214015bdbd533e.camel@mediatek.com>
References: <20230722074448.30671-1-yunfei.dong@mediatek.com>
         <0c8877c39ced8e664c2901ad20fd36fbb90d9d4f.camel@collabora.com>
In-Reply-To: <0c8877c39ced8e664c2901ad20fd36fbb90d9d4f.camel@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB6495:EE_
x-ms-office365-filtering-correlation-id: c572288c-d8bb-4833-5466-08db8fe454e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DZNh32UaSXaXl6YYlsNk5NtRPIv5ZzMABCQ8wgAwwtslRwkWnroT5sp1GNLmv9fFASsRxzZRjx867pUzABjhFxtdmKEh7tKIjzcdCfcuAqTpdLs5/QYpHwk9qExBKI3cOGU60y+Wq5G8IApsU5Z+R0h7oUdBq/Vl98zXo4HD8QLwOJz0qBYhiUutmljLFEBwNv8NZGSyb0qwYL6ocGMO2kWiy8HpNlBG4oav2WM5eUJWrCCvijyWsGhta8JS8e/FyfP7Sreh4VrpV/6Ws8lg8rrUbvRH+71F8VELxXBIiHOOZB3eWNqwoXDLgTw4oNMW1LqzvMDykWdhIQjTJLnUjixvk35NbKQ1znnRQWXyPv1vjlCLTKi+w2BenNTizsLo8ep2QtGO/6w3dKM39hCCDzhoT8ZC1gaeioUcT+7vO2E3epCp3hhl4UKAcL1DvecySfK9qygwQIUvd9orcvHlT8fWBkqjHtqdpHRBsCmuONXcMF7dVF2qXF3FZbAsRZTn5q7TpWvF5PchflP7QaHGMhbOyIZjmG8NBZiqw1yj5KaFqWb2nfXb97fzLQbCMJXZw8BGRV20psnt7POSAFwEwfgrh8TY6VJgAXqKtYHwfZCEE74Qk/SgcRijAjVEw0aFMDMSg6k2YKtSQ41kcWaHmIAqoEjWWxJgzItwLT1jJZqC157Zr2WDohLR+P8RRpxK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(71200400001)(6486002)(83380400001)(6506007)(6512007)(26005)(478600001)(38100700002)(66946007)(76116006)(64756008)(110136005)(122000001)(66446008)(66556008)(54906003)(66476007)(4326008)(186003)(66574015)(91956017)(2616005)(5660300002)(7416002)(38070700005)(41300700001)(316002)(2906002)(8936002)(8676002)(86362001)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFhwWTd0OVVwUnk4NkRjQ1dFVXNaTnpZRitPZGRnbE90WGhTZGF1YldlNnVi?=
 =?utf-8?B?RUZrVFZsTFFyT2MzOWVXS1V3Nmo1OGI3ajBmcXI2cGRTUlhpUUxsV2ViS0hL?=
 =?utf-8?B?cC80RUU3U3lkNXFtTEVBT2hSZVN0QTRzUFhXdlZ3TkkrQnJCOXBjdlVneElB?=
 =?utf-8?B?TmIzUFRxdWNoWVFHWThXdktjczBDRU8wTGF2bWRwTFhtQjRwT1dpSXRHbWxC?=
 =?utf-8?B?d1ZHYXlRWkxKQ0NjbDM5V1ZQVFpQSHVXb1FTem1FeExBaFh3Z0FlZU0vSFBX?=
 =?utf-8?B?cGI3Nm92NFFTMEhaRDFBMkUyWlpGM3hMODN5N0hiS3R2ZHl2dGppZkVlL1kz?=
 =?utf-8?B?bmJkV3E3dU9UWHZXRWxpQ0p5amJXQ2czeG5NVFpueGtHOFVsVm9PcDFvYldP?=
 =?utf-8?B?SE1JVHc0eHNQYlRUck1DT1FmcFlTTjhYRDFQUENja1luQ0ViWDMyRlRKaVNZ?=
 =?utf-8?B?ZmdTdEgvZUpCbXNZK01EQ0RlY1JWSkk3R2ZzRk9DTE56Y084TmROVjFPbVky?=
 =?utf-8?B?bDllSlN2bUJGUTBiOERyTzE0Nk9PcFppa0lHNFRGYVh1TTQ5US9rWk13UUdZ?=
 =?utf-8?B?SzB2SXhHRnhNQmx0NjdqcXJKVk9yRkhRWGxMVEFtS3ZEM3NpTmNvQlpQbEJw?=
 =?utf-8?B?N2lBYjMvL2hmMlJiVVB2a1NTcE5WWHdhc0VCMHJMSUlHbnZucG5qWm8zL3Zu?=
 =?utf-8?B?YU9PbCtMbmQ3M1NnN1QyaU5LRTNDd1JQVUhxOEJtTUcrajhFTXQ5dm5LQ05Q?=
 =?utf-8?B?d2tCOVBidE5MK1Rzd0V0M01Zc294MzJBTVRZTWgzL3BYdHpxVng4MXZQZVFR?=
 =?utf-8?B?ZEltUi9vb1M1YXgrN2pFekhrU2tNMFpTclVuSG0vSlVCbzE3SE9wMTBueFhN?=
 =?utf-8?B?QzRueDZCR2dlcHgrRDZrWVJJV2NaSjJMZk9JaTFnQXlZZ25jUzVCZ1JCRk84?=
 =?utf-8?B?RW11RnhSYyt6ZXNVOGpNdFFyRG1TcGNpbHdJVThsQm1UZGJibmFBV1dVQWM1?=
 =?utf-8?B?ZEhGT0N5M2IwZUVzdzhoNlYzclhTaTJHTXBCSllEaEZIcWc2d0grL0VLeWNW?=
 =?utf-8?B?QlNDbU1xaWVoaDh5bmpEaE16Q3BWT2hSVXE5VUZzb2VWZ25za2NmWGRIYzI2?=
 =?utf-8?B?YmlIUXZmeWVCWFJsVzBzVXYxUDFlY0tKditneDhEeHdlNUtUSVowZzVtZ2xP?=
 =?utf-8?B?am4yYStuaE9aZldYWCtVV1RZZDlHS2w2THFaVWRCTzZWNW5xSTlOMGNxazRB?=
 =?utf-8?B?djFCdDdFMVFEY0RTRkJwVkJ2cUd5akZVMWUxdHdLTVAwems2ckE2NXJNamxi?=
 =?utf-8?B?L2N4dWNrVXhvWE5uRHQ4Znc4TnJ6Q1dIZW9UYWJiVGtoUDFuNC9ZVmxCZUdo?=
 =?utf-8?B?bi9Hd2UyUzlOMVlqSGp6bFB1UUpLU2hOYmx0UXVYOGNYZUh6dkJob2VQeENw?=
 =?utf-8?B?KytKenJmbHlLK2loa1I1NStOSFo0YXkyTk1FVjE5Y2VhSkxYSGNWdHhJSzVV?=
 =?utf-8?B?ZjFlVUFqQ1p0ODJxRGZMUFVESDBZMEw4QkNYVnkzVW93L2ZZYVpLN2x5cTZq?=
 =?utf-8?B?WjZSd2RaUzZTdHpNdG9yTDZBVk9QRkVwMkw5OVhnSmpWYmhhVjBRWEpKdnNT?=
 =?utf-8?B?T053ZGxlZmhTUE1PSERIRFhyVVdkRVFaRm1lMlI3ZU0zRHNUQytOWEtRbW5x?=
 =?utf-8?B?RWxyWUVyd1ZmZGVQeE51R2psVkNsZ3NDOVZrWnpiOEY1OFQ3NThSNnAwL3ov?=
 =?utf-8?B?ZStLalp1ZzI5SUFNK0FzUXNneER1OG9reVlYaFNTWGN4Q25xMkdkaFVjcTNh?=
 =?utf-8?B?aGhPVlF2Wkhtd3JLRXRJc3MycHE4Zm9SKzF5TTVaeFJMWU5yK2Q5TTVkNU51?=
 =?utf-8?B?N2dxWUFtMGtxWFR4NFk5WmtxS0tqWTA1Z3RnVjZ1bVRFWTlGcFBteVE5Y0Zx?=
 =?utf-8?B?Q1N4ZFo1ZHZPY3d2ek0rUDdnU2xSTStMSmhIUForUVZUZUlTbEZWTHJOa0Ev?=
 =?utf-8?B?bGY3Y0RzTUJaQkxKVHRuaVQ5NmZwNHRNRDZZWGNrbzZwTWRFYndXT3crWjJU?=
 =?utf-8?B?bDFpT09ZQVc0SVlRcnI4clFUYlRIYThuLzJDSnZBampKVUxOeTFuR3VVb0xK?=
 =?utf-8?B?NnZVT0tMU0szNVpHRGt2RE44TkF1TUVjaW9PQVJIdllrTFlTSE80SlFGUlRX?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BB5B518A1066749A73A9769BBE802A1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c572288c-d8bb-4833-5466-08db8fe454e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2023 03:31:44.2259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwTIycqsrNgGGylD366WujxJm0zr67XHn4vxFB+YtbwyqLmf3NJxasFfA0BwTDbUoE+DFSs7ysDsEDvUehy6xawN4nRDQaQNfWthBq1vKAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6495
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KT24gTW9uLCAyMDIzLTA3
LTI0IGF0IDE1OjUzIC0wNDAwLCBOaWNvbGFzIER1ZnJlc25lIHdyb3RlOg0KPiBIaSBZdW5mZWku
DQo+IA0KPiBMZSBzYW1lZGkgMjIganVpbGxldCAyMDIzIMOgIDE1OjQ0ICswODAwLCBZdW5mZWkg
RG9uZyBhIMOpY3JpdCA6DQo+ID4gRnJvbTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlh
dGVrLmNvcnAtcGFydG5lci5nb29nbGUuY29tPg0KPiA+IA0KPiA+IERlZmluZSB0d28gY2FwdHVy
ZSBmb3JtYXRzIFY0TDJfUElYX0ZNVF9NVDIxMTBSIGFuZA0KPiA+IFY0TDJfUElYX0ZNVF9NVDIx
MTBUIHRvIHN1cHBvcnQgMTBiaXQgaW4gbXQ4MTk1LCBtdDgxOTkgYW5kIG1vcmUuDQo+ID4gR2V0
dGluZyB0aGUgc2l6ZSBvZiBlYWNoIHBsYW5lIGFnYWluIHdoZW4gdXNlciBzcGFjZSBzZXQgMTBi
aXQNCj4gPiBzeW50YXggdG8gZHJpdmVyLg0KPiA+IA0KPiA+IFY0TDJfUElYX0ZNVF9NVDIxMTBS
IGlzIHVzZWQgZm9yIEgyNjQsIGFuZCBWNEwyX1BJWF9GTVRfTVQyMTEwVA0KPiA+IGlzIHVzZWQg
Zm9yIEFWMS9WUDkvSEVWQy4NCj4gPiANCj4gPiBwYXRjaCAxIEFkZCBkcml2ZXIgdG8gc3VwcG9y
dCAxMGJpdA0KPiA+IHBhdGNoIDIgQWRkIGNhcHR1cmUgZm9ybWF0IFY0TDJfUElYX0ZNVF9NVDIx
MTBUIHRvIHN1cHBvcnQgMTBiaXQNCj4gPiB0aWxlIG1vZGUNCj4gPiBwYXRjaCAzIEFkZCBjYXB0
dXJlIGZvcm1hdCBWNEwyX1BJWF9GTVRfTVQyMTEwUiB0byBzdXBwb3J0IDEwYml0DQo+ID4gcmFz
dGVyIG1vZGUNCj4gPiAtLS0NCj4gPiAtIGNvbXBhcmVkIHdpdGggdjE6DQo+ID4gLSBGaXggc2V0
IG5vbiBzcHMgcmV0dXJuIC1FSU5WQUwgaXNzdWUuDQo+ID4gLSBEcml2ZXIgdGVzdCBwYXNzIGlu
IG10ODE5NS9tdDgxODggd2l0aCB0YXN0IGFuZCBZb3V0dWJlLg0KPiA+IC0gUnVuIHY0bDIgY29t
cGxpYW5jZSBpbiBtdDgxOTUvbXQ4MTg4IHBhc3MuDQo+ID4gLSBmbHVzdGVyIHRlc3QgYXMgYmVs
b3c6DQo+ID4gLSBoMjY0OiAoSlZULUZSLUVYVDogMjkvNjkgIEpWVC1BVkNfVjE6IDk1LzEzNSkN
Cj4gPiAtIGgyNjU6IChKQ1QtVkMtSEVWQ19WMTogMTQyLzE0NykNCj4gPiAtIHZwOSA6IChWUDkt
VEVTVC1WRUNUT1JTOiAxLzYgIFZQOS1URVNULVZFQ1RPUlM6IDI3Ni8zMDUpDQo+ID4gLSBhdjEg
OiAoQ0hST01JVU0tMTBiaXQtQVYxLVRFU1QtVkVDVE9SUzogMjIvMjMgICBDSFJPTUlVTS04Yml0
LQ0KPiA+IEFWMS1URVNULVZFQ1RPUlM6IDExLzEzDQo+ID4gLSAgICAgICAgQVYxLVRFU1QtVkVD
VE9SUzogUmFuIDIzNy8yMzkpDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBmbHVzdGVyIHJlcG9ydHMs
IEkgY2Fubm90IGNvbmZpcm0gdGhpcyB5ZXQsIHNpbmNlIGl0DQo+IGRvZXMgbm90DQo+IGFwcGx5
LiBOb3RlIHRoYXQgeW91IGhhdmUgZm9yZ290IHRvIHByb3ZpZGUgVjRMMiBjb21wbGlhbmNlIHJl
cG9ydCBhcw0KPiByZXF1ZXN0ZWQuDQo+IA0KDQpJIHdpbGwgYWRkIHRoZSBjb21wbGlhbmNlIHJl
dWxzdCBpbiBwYXRjaCB2My4gVGhlIGNvbXBsaWFuY2UgcmVzdWx0IGlzDQpwYXNzLg0KPiA+IA0K
PiA+IC0gc2VuZCB0aGUgZmlyc3QgdmVyc2lvbiB2MToNCj4gPiAtIFJ1biAxMGJpdCBWUDkvQVYx
IGZsdXN0ZXIgdGVzdCBwYXNzLg0KPiA+IC0gV2lsbCByZXR1cm4gZXJyb3Igd2hlbiB0aGUgMTBi
aXQgcGFyYW1ldGVyIG5vIGNvcnJlY3RseSBpbg0KPiA+IGZ1bmN0aW9uIG10a192ZGVjX3NfY3Ry
bC4NCj4gPiAtLS0NCj4gPiANCj4gPiBSZWZlcmVuY2Ugc2VyaWVzOg0KPiA+IFsxXTogdGhpcyBz
ZXJpZXMgZGVwZW5kcyBvbiB2NiB3aGljaCBpcyBzZW5kIGJ5IFl1bmZlaSBEb25nLg0KPiA+ICAg
ICAgbWVzc2FnZS1pZDogMjAyMzA3MDQxMzEzNDkuODM1NC0xLXl1bmZlaS5kb25nQG1lZGlhdGVr
LmNvbQ0KPiA+IA0KPiA+IE1pbmdqaWEgWmhhbmcgKDMpOg0KPiA+ICAgbWVkaWE6IG1lZGlhdGVr
OiB2Y29kZWM6IEFkZCBjYXB0dXJlIGZvcm1hdCB0byBzdXBwb3J0IDEwYml0IHRpbGUNCj4gPiBt
b2RlDQo+ID4gICBtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogQWRkIGNhcHR1cmUgZm9ybWF0IHRv
IHN1cHBvcnQgMTBiaXQNCj4gPiByYXN0ZXINCj4gPiAgICAgbW9kZQ0KPiA+ICAgbWVkaWE6IG1l
ZGlhdGVrOiB2Y29kZWM6IEFkZCBkcml2ZXIgdG8gc3VwcG9ydCAxMGJpdA0KPiA+IA0KPiA+ICAu
Li4vbWVkaWEvdjRsL3BpeGZtdC1yZXNlcnZlZC5yc3QgICAgICAgICAgICAgfCAgMTMgKysNCj4g
PiAgLi4uL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjLmMgIHwgIDIyICsr
LQ0KPiA+ICAuLi4vdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfZHJ2LmggICAgICAgfCAg
IDUgKw0KPiA+ICAuLi4vdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfc3RhdGVsZXNzLmMg
fCAxNDQNCj4gPiArKysrKysrKysrKysrKysrKy0NCj4gDQo+IHZjb2RlYy9kZWNvZGVyIGRpcmVj
dG9yeSBubyBsb25nZXIgZXhpc3RzLiBDYW4geW91IHJlYmFzZSB5b3VyIHdvcmsNCj4gcGxlYXNl
ID8NCj4gDQoNClRoaXMgcGF0Y2ggc2VyaWVzIGlzIGJhc2VkIG9uIHBhdGNoICdzZXBhcmF0ZSBl
bmNvZGVyIGFuZCBkZWNvZGVyJy4NCnZjb2RlYy9kZWNvZGVyIGZvbGRlciBpcyBhZGRlZCBpbiB0
aGF0IHBhdGNoLg0KDQo+IE5pY29sYXMNCj4gDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0K
PiA+ICBkcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWNvbW1vbi5jICAgICAgICAgfCAgIDQg
Kw0KPiA+ICBkcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMgICAgICAgICAgfCAg
IDIgKw0KPiA+ICBpbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmggICAgICAgICAgICAgICAg
fCAgIDIgKw0KPiA+ICA3IGZpbGVzIGNoYW5nZWQsIDE4OCBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiA+IA0KPiANCj4gDQo=
