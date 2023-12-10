Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1076E80B9F0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 10:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjLJJKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 04:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjLJJKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 04:10:00 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A71B8;
        Sun, 10 Dec 2023 01:10:00 -0800 (PST)
X-UUID: e0001088973b11eeba30773df0976c77-20231210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=24TuwalHVVr+QldZRTqVD1YN+eKeuxLeiPNNocLb4so=;
        b=l70vWA9dWmdZjeJv+sTAr7/W618kcYPzdLyAaawM21BkDjjGIbd8I2jLiHZddk1SWKpch84By/zfS4yQmf4X4zKWaZvils82h8CyrysmQM0LqcXbvPUZ7nobWcrzmKE/3IdTID4vb7StVHzttRMTLGf5vN2g2RURpsqC00ndsKg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:99edb83a-c733-4962-adc9-40de8f8a9b8a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:19537dfd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e0001088973b11eeba30773df0976c77-20231210
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1294079896; Sun, 10 Dec 2023 17:09:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 10 Dec 2023 17:09:49 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 10 Dec 2023 17:09:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAGblP0uZRRej+v4ZPA0Yn00NAR8k15uvSUawHfZ7cT8Rr7pYgiw0LxATxRPrNAM6QD3No0cO08zrfIJ7t7WZRBlQgKfYLcFA3eBcgMESB+WAmbyZ891bvScW36Q7p+sOUkxa19Uen1HplPeP+s+TUIHc8F0TDEEolujU6HundlTim8diV3W1yAeSvlGUSH1zPFnjs6UhlrYLzTUhzTJ1r5ZLQ08qu+99Abvd95bLliylmahgkw8QBKE7dH8PMBcTcEBb7pFo0SHm4JsA6ZpUmzIW0FIEkZvt8YI0bTnJq6RyDxLgCaFSdV5RInK4p0YIveYS+xqn28nt2VWGxmF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24TuwalHVVr+QldZRTqVD1YN+eKeuxLeiPNNocLb4so=;
 b=ZcLNx1hh7uDwYjvz2tAQZrpNNJQWpoOK+B1IZ+SBUn2hb17WfjkOZLW51+qieybxmX0G+JnWpTm/3mA5uulE3SzpPTPJiwVNS79FAhsxqcdTIjEVwaCrbKsqZaGVyanRPiDz6rjRkJGkwTB1q2hG2hKEOEPSYJy8R3GzWA1qaOqIYFXkqfrzbNouykI4C+71Bc6ucuCrdJvZdmW8ZDWN+qi/OuIepo+dxNYpZSFoGBLz4aTy3k8mXJwjZ1TEM8R7pZJ34f60+/eaqUWp29n4q2TrYSPbEO63E3xyT+wrqwyA5fSTh5yrvmS+3BG7GwML7J/DwHDXsvmv637SV8k/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24TuwalHVVr+QldZRTqVD1YN+eKeuxLeiPNNocLb4so=;
 b=JI/v1rYuPpw8Zq9mrTeoy86wepXfOc0ARbivNL7txofsvV+IOEYgDyWN92KAn+2AuK2gH6bP27UbnxQxGn4RYcoILFJKbq9joHspdQnPbagd+bSqY15vLFr4isfzOp98T1Kgk5Iag/qBLXbI+QgnEzo2EZx1TxgR1hPVbufiBSY=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by JH0PR03MB7323.apcprd03.prod.outlook.com (2603:1096:990:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Sun, 10 Dec
 2023 09:09:45 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 09:09:45 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= 
        <bear.wang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek: tphy: add a property for
 force-mode switch
Thread-Topic: [PATCH 1/2] dt-bindings: phy: mediatek: tphy: add a property for
 force-mode switch
Thread-Index: AQHaHz31Z+QBjWZtBk+dlN+S28FsW7CK2GgAgALqXwCAAANiAIAEWt+AgABn1YCAD8nhAA==
Date:   Sun, 10 Dec 2023 09:09:45 +0000
Message-ID: <853a37c17a84a50866345481f4fd48ba82aa2b27.camel@mediatek.com>
References: <20231125012303.760-1-chunfeng.yun@mediatek.com>
         <e34c2746-8e93-48b8-9c96-690242fbf6e9@linaro.org>
         <239def9b-437b-9211-7844-af4332651df0@mediatek.com>
         <0dc24d82-e09d-45bc-98ae-1dfb6318cb96@linaro.org>
         <74957a9cc4663815e200d222483541a1eec43bbe.camel@mediatek.com>
         <50e56220-8068-4e2e-a586-9d0474963085@linaro.org>
In-Reply-To: <50e56220-8068-4e2e-a586-9d0474963085@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|JH0PR03MB7323:EE_
x-ms-office365-filtering-correlation-id: 184cd1be-2aed-4360-23cf-08dbf95fc0c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aVVizZsMBCqXDbbU6CaGDhq+1mibHNj834QnfbtE1XJjTM5x8jabpSbYDyHw31XfPBNuqKxJM1TB4Fiu7BVWOSR5jF9l5Xfyki6+lPjO5KlJckW9b7MV3mbRB6dkiA6e+OsWkC6auE6b0Pos5TtYFMJSrzr+IBpjMh51kKd5LZ5yXZuwa5NGACXCvnX9VIRuciyth3w+Nwdl4XVhkOQILBOPZ0nAsz1uc8AdS0/ZL+xa58QNxcWUIKDErd3JvBSfnb4dEHIXbylXPjrXGgT2rpXdumePBME95b0mSSYBfhp7pAQH//wtUGhgdt9YWAxgxz0muavhV0otDnTK5oKbBtaHNpKmCeukAXAa2WbIH7QwXULuynDCSEq/pedhKhyq3mgzyMtTIJLoBB81IiDzlt7G9ueuPzPK+4yds+/AxJAewj4am8yzpCfPO+Run56iLLyeCcHpGzqYaydWHM0EcXkdwv6DsKRbeA9PImuvvNydmDD4xHXjIndp25nb2fb897JdYgWMb5Yyc30dHk6oCrurqQyfu0fZmFgunQ4vxCunui4QNcWl6kHK519wcr8EF8MxK6kkPklcJ/VVyVxMv7K0DVRsZvtO30iKJZpowoPJ8JUbjOmJ9DLk1/DVMV049VAOOJkNE8Gu0FE+rLNL8nZjmP5EJDsNmAwpppdLF/SVCUcvF6y91tHVLeN62WUX4eWN+B3/6DWO8NxLaaLWfmam8udNZLlts8pHkeDM4Vs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39850400004)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(1800799012)(64100799003)(26005)(2616005)(38100700002)(122000001)(86362001)(38070700009)(85182001)(36756003)(83380400001)(7416002)(5660300002)(53546011)(6512007)(71200400001)(6506007)(66556008)(110136005)(91956017)(66946007)(76116006)(6486002)(8936002)(8676002)(316002)(66476007)(66446008)(64756008)(54906003)(4001150100001)(41300700001)(2906002)(478600001)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1BUaHRlWmxBT1NWZFBhS01PRC9kMlZoOGp4NzJ4anhJbEdlYUFxdzZTRFEx?=
 =?utf-8?B?OVc4RzYrV0MvVE1xbU1FYzRCOGNhWXh0eHJNTlAyS3BYUTdoZUdES1NOUy9p?=
 =?utf-8?B?TVZOZTU3Qng2YWwxVTVuOTFwclBHOThQS3FUeEp5Zy84V2NTcWJmSjZJUUp6?=
 =?utf-8?B?MXJBM2JFTndhQzlsQitqbHdGUjk1ZGh3YmdBWVlZdHowaWFXQlhmUWVMcE9R?=
 =?utf-8?B?TU1wTGZJMEtmSjMwRkg0RDNyLzFtRFB5RXNwUUh1TkVGV21TTk82YmwwNHhV?=
 =?utf-8?B?Q2xqc25OajBISjA1djZqV0wxRG1VS0RydHJEMHN2dTdKcFVReTVLUll6UjV4?=
 =?utf-8?B?RjIraTE1RU1obEJFQmNseVBDZEhaM0tXTmE0WmhLRDhHaEs1MFZLNlUyT2dB?=
 =?utf-8?B?WWE0Z2VtcGIvVi9qR0s3ZlpuYjBKbTZaMlNMM2UwR0RVZi9mSFV4NjBXaHZv?=
 =?utf-8?B?SHNiVkhjaHhlSEZpMC92c29GbndLWnFuTE1HRkNFYVF5U0VXV084UkpNSHl0?=
 =?utf-8?B?OXgwWkZFRUJsNXRlRnE4R01BUm5jRWx3dFdRem5VV0hDZjlkMTlFcm96ekls?=
 =?utf-8?B?OHJqVE9VZVV1NzVYOWdEMmJXWldveVdMVlQxOUlSeEpGYXI2VENPVFJ5VnhZ?=
 =?utf-8?B?ZjU3bDV0cEpPY0NJMkU5a0JucS8zQ0lmS3ZoZE9aRlFYWWsxSy8yMWF4ZWpl?=
 =?utf-8?B?K2VkT2F6YmFhamZKWGFhNGk4NUF5UFBSQXFEQkpHQzFpbnZtbXlmQUNkYklX?=
 =?utf-8?B?KzQ4b1QwZFdNMm9DYTZiREFEWkxwdGZqc1h3YXFaN1p1bUlQZkxpM3VYdlgr?=
 =?utf-8?B?Zyt5UWJaREtUZTh3L3dVRkFGTU03c3A2YitSWjJpYmIzS2EvVDFXZWNOTmNI?=
 =?utf-8?B?ZzFmNUord3J5NjZNbU03dzBGUWhvNWtiWXhCek1aWWI5VzdBTUEyenRCcHda?=
 =?utf-8?B?TTdkSEh1dXcvU0JBQ2lwUlUyaFlOc0ZTeHBvWGNGSTM5dzFEcG5jRjZQTTdN?=
 =?utf-8?B?YVVJbkp3WlBCekdScllyQlVGdnEyU0UrV2pYV2FacXE2OTF3RDU0V1NqZHRR?=
 =?utf-8?B?OFNIbTV6a3VQUkgrVjJtc01nK0g1U2RqY1g2djF5eGpuVE9zVStYQVdLSWxu?=
 =?utf-8?B?RG9qSDEvb0taUVpaZXZnVlZNbkdCZzlLSjlpUnNadENtdndoNGRPQ2liZ1JH?=
 =?utf-8?B?dmpkUzk5SGVhaGpBbTJ2cHBsUk5tT1hteDlIVHdRZWNsZzExVExoUzlxWWlE?=
 =?utf-8?B?V05Rakh3U08yUTErNjlPTlIrUURnRERJMk1yT29XRGR2ZDZqNDZTOHN1ajZi?=
 =?utf-8?B?QndpN0toNzhBMTBVcHdwUDVaN1ZRaTJ1dFNQS0doVURDQlhnNkZ3NW8wK3JO?=
 =?utf-8?B?TWI1RG9yV2dyelg2bCtYNUphZHl3VTF2MkVLUkdMeFRKczZpOVlmdXlFQmFK?=
 =?utf-8?B?T2hXV2IxdWFoT0JpNUorcXdBNnJiSHNOb2J6Sm9Cekp4Q2FqcEt5eG5KUFc1?=
 =?utf-8?B?WWdJdi9id0RlMEVjWnpLR01CMmhBclZOcHFpT1kvY2VIZUVXTDd1cjFpZmV6?=
 =?utf-8?B?eVh5cjl0Zkc4VVE4dGRPVGZROEw1NzJZa2ZPb0hkK0ZvbEd0OWlUYkhmS21P?=
 =?utf-8?B?NVpuTFhOZmdMVkxVWjhrbWp6S0taUml3K1BpQWtNR25EUlFNTUhDMjJEeTJy?=
 =?utf-8?B?OEF1ZkdPV3ljTjhVUENTZEkvbWdrU2E5UUpmalNZMzFXaUk1U3pjUXlMZEFl?=
 =?utf-8?B?SXFxL3dIVzZ2Zml0YXp3dHUxTnQ2azVtV3BwZ1R2R0NJYjR1M0JrQzhNdnRF?=
 =?utf-8?B?U0pQNGQ2TFBCanhjWklMdzZFbnFyRm5QSkZJRjJxV2dVUjdDRzdzMTJ0VENG?=
 =?utf-8?B?bjU0cWl1SjFscnVRUFVGY0N6VTZveEE5SlBlZjEyZGdTV0d3aHhuM3RYZVc1?=
 =?utf-8?B?ZTNkNEJoeDAxWnF2RFVlcnFkZENDT1kvSTlWTW1KSi8zaGNoZDZ2K1k3Mytz?=
 =?utf-8?B?NXI5bGpXNXVYd3Z6SHJZWUJOZlpLbGpMcW5reWFMeDNSMzN5R3B0Nm9STEt2?=
 =?utf-8?B?K2s5NFpRMWRta0lFd1N5L1pnWHRJZGprRXNXVHlNb0J0T0dsSGJMUUNKZWdm?=
 =?utf-8?B?OEdGQ3A1NUMwZ1E1T2o1dmlBOXpwVTNpMGs2VUM5ZHRDSHRRcU5yaTBKbUlO?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D587E82420C2F3498E76258B5607A74B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184cd1be-2aed-4360-23cf-08dbf95fc0c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2023 09:09:45.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voa2evSnBqqu4a+2EGTes+8bgqCstnej4c8Y8ZhyQJt0VXdP8xl0hVWM+pJzll5QGHOnEclDtWZEuGgZgliNLPT6yM64eusQwdagFIf0jWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7323
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTMwIGF0IDA5OjAzICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDMwLzExLzIwMjMgMDI6NTEsIENodW5mZW5nIFl1biAo
5LqR5pil5bOwKSB3cm90ZToNCj4gPj4+IDMuIEhvdyBhYm91dCB3ZSByZXZpc2UgdGhlIGRlc2Ny
aXB0aW9uIGFzIGZvbGxvd3MgZm9yIG1vcmUNCj4gPj4gcHJlY2lzZWx5Pw0KPiA+Pj4NCj4gPj4+
IG1lZGlhdGVrLGZvcmNlLW1vZGU6DQo+ID4+PiAgICBkZXNjcmlwdGlvbjoNCj4gPj4+ICAgICAg
VGhlIGZvcmNlIG1vZGUgaXMgdXNlZCB0byBtYW51YWxseSBzd2l0Y2ggdGhlIHNoYXJlZCBQSFkN
Cj4gbW9kZQ0KPiA+Pj4gICAgICBiZXR3ZWVuIFVTQiBhbmQgUENJZS4gV2hlbiBmb3JjZS1tb2Rl
IGlzIHNldCwgdGhlIFVTQiAzLjANCj4gbW9kZQ0KPiA+Pj4gICAgICB3aWxsIGJlIHNlbGVjdGVk
LiBUaGlzIGlzIHR5cGljYWxseSByZXF1aXJlZCBmb3Igb2xkZXIgU29Dcw0KPiA+Pj4gICAgICB0
aGF0IGRvIG5vdCBhdXRvbWF0aWNhbGx5IG1hbmFnZSBQSFkgbW9kZSBzd2l0Y2hpbmcuDQo+ID4+
PiAgICAgIEZvciBuZXdlciBTb0NzIHRoYXQgc3VwcG9ydCBpdCwgaXQgaXMgcHJlZmVyYWJsZSB0
byB1c2UgdGhlDQo+ID4+PiAgICAgICJtZWRpYXRlayxzeXNjb24tdHlwZSIgcHJvcGVydHkgaW5z
dGVhZC4NCj4gPj4+ICAgIHR5cGU6IGJvb2xlYW4NCj4gPj4NCj4gPj4gQWdhaW4sIHdoYXQgaXMg
Zm9yY2UtbW9kZT8gDQo+ID4gT3VyIERFIGRlc2NyaWJlIHRoaXMgYmVoYXZpb3IgYXMgZm9yY2Ut
bW9kZSwgYXMgeW91IHNlZSwgdGhlIGRyaXZlcg0KPiANCj4gV2hhdCBpcyAiREUiPw0KSGFyZHdh
cmUgZGVzaWduZXINCg0KPiANCj4gPiBwb3dlciBkb3duIGNvbnRyb2xsZXIgYW5kIHJlc2V0IHBp
cGUgdG8gc2V0IHRoZSBtb2RlIGRpcmVjdGx5IHdlDQo+IHdhbnQsDQo+IA0KPiBTbyBmb3JjZS1t
b2RlIGlzIGRyaXZlciBiZWhhdmlvcj8NCmhhcmR3YXJlIHN1cHBvcnRlZCwgbmVlZCBzb2Z0d2Fy
ZSB0byBzZXQgc29tZSByZWdpc3RlcnMNCg0KPiANCj4gPiBidXQgdXN1YWxseSB0aGUgcGh5IGNv
bnRyb2xsZXIgc3dpdGNoIHRvIHRoZSBtb2RlIGF1dG9tYXRpY2FsbHkNCj4gPiBhY2NvcmRpbmcg
dG8gdGhlIGV4dGVybmFsIHNpZ25hbCwgZS5nLiB0cmFwcGluZyBwaW4sIGVmdXNlIGV0Yy4NCj4g
PiANCj4gPj4gSXQgbG9va3MgbGlrZSB5b3Ugd3JvdGUgYmluZGluZ3MgZm9yIHRoZQ0KPiA+PiBk
cml2ZXIgYmVoYXZpb3IuIEJpbmRpbmdzIGRlc2NyaWJlIGhhcmR3YXJlLCBub3QgaG93IHRoZSBk
cml2ZXINCj4gPj4gc2hvdWxkDQo+ID4+IGJlaGF2ZS4gVGhlIHByb3BlcnR5IG1pZ2h0IGJlIHJl
YXNvbmFibGUsIGJ1dCB5b3UgbXVzdCBkZXNjcmliZQ0KPiBoZXJlDQo+ID4+IGhhcmR3YXJlIGNo
YXJhY3RlcmlzdGljcy9pc3N1ZS9ldGMuDQo+IA0KPiBZb3UgbXVzdCBhZGRyZXNzIHRoaXMsIGlu
IHN1Y2ggY2FzZS4NCk9LLCBJJ2xsIG1vZGlmeSB0aGUgZGVzY3JpcHRpb24NCg0KVGhhbmtzDQoN
Cj4gDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=
