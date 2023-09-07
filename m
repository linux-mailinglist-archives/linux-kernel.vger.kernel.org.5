Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B179740F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbjIGPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241301AbjIGPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:31:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2866D10F6;
        Thu,  7 Sep 2023 08:31:20 -0700 (PDT)
X-UUID: fa7359504d4611ee8051498923ad61e6-20230907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/JYLnaTIbRnKheb1f8thax+D6YzEsiY1fJrUyxdcp9U=;
        b=rMminVtUHcEpb632FUl/1uVfLX3JBK/N5BzTDDwrkY6QHdSpGndg/vASZYTm9QRLWCWzjrXz4MTiGW6nidPRo3UkKWlzI3w59J6uJzr+7MNxI+Wv67lHhk380lYnQ6yai372rV2ZOSVnUoSyodEjohslZRdWUTtvO7/ouBE9UUk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:89717dd9-abd2-491c-8eed-bf8d8a1fe977,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:2,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:2
X-CID-META: VersionHash:0ad78a4,CLOUDID:40dcbec2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: fa7359504d4611ee8051498923ad61e6-20230907
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 336416878; Thu, 07 Sep 2023 14:22:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Sep 2023 14:22:52 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Sep 2023 14:22:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGsprs10BM/HE1byD/m21n3EXDGtScm0fEAvx3uJ/nDqCQkn+RWhH2T8Piu6a82rX5idY7nMebffz6vceeNYX7UZ5Qa3UvGqfGSK9H6bL0IDyx65hq1n6swxZsuqmWY3rTHXBmvF4va3vfuqZXP9jgPY6uAI4TWT+sUOqxyEopn2CCckLL6vwiyOsTseD0l1FeuznEnZ5xMsrIUSWse/yhgDbHm73tfB4QVNDFRw/4z+COCpmQ7c6zBUmXSVepXGrdIRnbu5ebIdlJlIAow4rhzoGSf672C7QLJQJ6lEiXrc4oWSaKpOt5AeP6e9lPYrVBqH0ZOXDa2M7SKbybTaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JYLnaTIbRnKheb1f8thax+D6YzEsiY1fJrUyxdcp9U=;
 b=Nqvz+DrFVw4wLvQnqs59JGv4Cl3tqEymhRaDc+l60yzlWHoViy9iZ5ISpyAX9fVCg6vFTHeGONwmMJK3OO0HIjyE6c8Uw9+NGUZpnTeVUaNlesAhuq/dv1ReEX3Uf7gr/uwoKcSpXreN5YN3U59KUUnoNUQ4He6N7n/0+y4bf0ocPmA2sju8bim0qjmzIjCw/PXXju/fKaHfARuf1KulPhfKp0UZFl6t2iaMzwm1kkZm/T0EQFkwexLi3D1/tC5IKKFl/tr4qOuKmZzuTZewAV8XTR+zdPIBqxxc7kCAyk00gNzZQTwxY/3zaaQKJ0GDjfJMzHZ721ZnbVVGiS4pcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JYLnaTIbRnKheb1f8thax+D6YzEsiY1fJrUyxdcp9U=;
 b=S/ux2PJ4JVPkHdJPPXqPm0f6KgwMYgjzoJdyx3ofPg5Bvb9DfSlkdzWDAQvb4tROpZMKBw5Fdrk5lB+fdRV4QYrUzV2l0G9CXU/UKfcwZF5TWzydHfoj6fVWV73t0KTHaumi9GLa/PsEVWYoUpiIAQVnZ+RxDDgctuLd9pPnjT4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6055.apcprd03.prod.outlook.com (2603:1096:4:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 06:21:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 06:21:49 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>
Subject: Re: [PATCH v2, 3/3] drm/mediatek: dsi: Add dsi cmdq_ctl to send panel
 initial code
Thread-Topic: [PATCH v2, 3/3] drm/mediatek: dsi: Add dsi cmdq_ctl to send
 panel initial code
Thread-Index: AQHZoCV7tKrfC+J4JEmcXcu1UwmN5rAPZt+A
Date:   Thu, 7 Sep 2023 06:21:49 +0000
Message-ID: <411ddbf95e2c2298b84899065691d478069ec273.camel@mediatek.com>
References: <20230616073659.26536-1-shuijing.li@mediatek.com>
         <20230616073659.26536-4-shuijing.li@mediatek.com>
In-Reply-To: <20230616073659.26536-4-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6055:EE_
x-ms-office365-filtering-correlation-id: 38e681b3-c9d7-44ae-4141-08dbaf6ab862
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9VTjsaWYQPu+z6HRf3rp65eKyS3LHqKh8e9NdMyw30WTvDz3Byym4EvlHQRs6sLpwPJZKWiSx1rUI8ZhBQeY6vhJLXKLLUAd5CNvmDdlpdGnMBL2QUBTMSuAoNetLOrkHaFMvYPPq6keM9oGfNAhcSqJ26WsJjXRldaMmVI6xKM9vhZMVoVWq4LFzYx9IZt0bJ6S+8d55x97SU1cR49k0SC3MZMX/tJKladAql4mMNhZbCjJ1jbMsRmj9t3xjhZXurc4jPeBXA4nO4iMcXbHimn14p8ixNtHdSan3Z2F10C2kHGd1LHEIHxxkj1E+ZUkVnWrLY2Nlm5V6Ohzq8btTKisIvk4GH5/ndPPCra8SME3xyEthO8E4ASl3W6zNAg/sErsCgqgHT0bJ1nZZO3x1JwsISGF52s02+2KJPnpPFOHW8KzVWidB/XOPnvGDfmW4q14iIMQDST9ncfjAoDnZ9nMXL/9yry7gpRokEjrpMQajR84DBigqKUQqZrPrVNDJjnWCyeoq4VwFMpQCZ7XribTZUfGhL3tCmNxAaeJ+BE8eWLeB8JGVAt3f/w5+OvgeocT4aBdmecTosZ6w+3OZ1CZbVRneazr+fL0bVY72P/qCSYlvZ+Syif39dNoAyOG/cnabQs6veBHOg+D9xRZWOPKzmfnu1J+3p4X8xieVDY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(186009)(451199024)(1800799009)(921005)(122000001)(6506007)(6486002)(71200400001)(8936002)(36756003)(38070700005)(86362001)(38100700002)(85182001)(26005)(6512007)(107886003)(966005)(2906002)(76116006)(5660300002)(4326008)(478600001)(110136005)(316002)(8676002)(64756008)(2616005)(66446008)(7416002)(66476007)(54906003)(41300700001)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlZ2YkNOWks2aFB6dCtCUXM2SzFxMnNsTHRQVGtZVXJKTzI2aHFSZ2c5aTV3?=
 =?utf-8?B?dkQxV0loV1VKbVVYUHB5aEdxbUI2dkJiNGdsYUtrTUVVODMwZkxyTWlIN1hZ?=
 =?utf-8?B?eGpWVzcxNmx5UmFBblBmQ1J5UnFhOXdIRHNUaDh2UzlXU0JPeEZBQUdEOHo0?=
 =?utf-8?B?QkN3NEtiWnZuWmRxSGo1T1d3ejlaUFFQcXJML2FEOVA1anE2czFISXJHQmVq?=
 =?utf-8?B?TWpFelpnaElTWkZjeW9PWnVKOVYzbEo1NkJEVDFtNURyZjQ2aHZrUDNmaHNr?=
 =?utf-8?B?UksrRmo3ZTlPRHJCd2NSYVZuSG40aFQ3WXhnbU95cXMyblRFT2grWDQzSmVh?=
 =?utf-8?B?MGh6cGtKRk9pY0RQb0t5OGVKRHdRVDVOMndMUllRYnE1V2I1S254L010c3dw?=
 =?utf-8?B?bzcxYjRhTDFndnNqbnNzbTVNaVYzS3BCTlVCZ3Z1bkxmVmdoTHg3Y3h3d0I2?=
 =?utf-8?B?K0cyVUxTcnNMaDhjM3hTaGNhSDNRMGU1SCtsMUp6UGlLSnlMS1A1NGtVcUJs?=
 =?utf-8?B?K2JqU3FhWU9sc210b3JacG4zOWJIekV2aUJqbE1CZnBrRm15TGEybFcwUHd6?=
 =?utf-8?B?SFJ6b2dLKzB1dkswT3VGc0V1d0Rtd3R6eHFEQ3hBODVCM3ZaZTFSK0hOdmNB?=
 =?utf-8?B?ZmFXbVRWQmIyWktsOGNhYTZuazl3dmVTTXg1QXVrMmNCbi9XTzZNTFE4OUFQ?=
 =?utf-8?B?amc0cWpham0yQzVIS3ArbStobmV5bjlDY3c0YkFBcWdZNU8vT1M5blJ1dzU1?=
 =?utf-8?B?Y1pHQUJwWkw4Qng4UlQ3bk1iZjdwSCsrTU8rMTdhN0xwRk9VYjE1akN4aVo0?=
 =?utf-8?B?ZGRsYVZaOUYzS2pkVHBWbVB4ODJ0dHhVMWNYdGw4MWo3UWlyYkVmT0FFRC9B?=
 =?utf-8?B?NFF3QWd3VlN5Y2h2RXlOUVVrU293VUxTN3BSSy9BYjRhQ1RjUndYbFpUQnp2?=
 =?utf-8?B?c0xrS1c4Sy9VeEd5ZzB0aDBKZmhSeTg2cEV5Z2kxck9XVm84Y3NKdzd5UTQw?=
 =?utf-8?B?R1NUT0szTXh6bDgxeE9RREVrV1NuaUtIeVhPekJmaFNiYUpFbXEwRC9xNnU0?=
 =?utf-8?B?SGZjZkVBbnNJcTczN2pHeWVHMGFKQ3pWNG5JTHJmVWR6c1g3YVY4cjdNS0k4?=
 =?utf-8?B?bDA4dGxQcnozN2Nka3VEdnNmY1diUXdObWY5dlZMendPWVFUY2cyUmNSNW9B?=
 =?utf-8?B?eWx6am4xT0Y5cU9zQWo3bldBbjZXWjZPMU0zSDE3MlUzV2JKM2c5NE53K2lP?=
 =?utf-8?B?RmQ2cnlNUWhOb2ZGNk11cGZwQzVmdDRMNU1aYzQxckZITzlwd2F2L1B4SDBE?=
 =?utf-8?B?YVZCU1JqZ3Mrako5dW5jSlY5K2pURVZPVGt6cFZxYWRoeEpaY0tHbEFCWmcy?=
 =?utf-8?B?Vks1Vll2MklnVmpYQUJqSFZyNnJVdXRDbmhkSTQwMXM5R1pTcCszNWhhZEg2?=
 =?utf-8?B?dUJvMDZWTGwxRU42MmVWd2JudU00YmJSQnZjRkVnd0x0dlJDdmhqOXB2ZEs1?=
 =?utf-8?B?ei95dXdmZmJoMWp3VElEa20wWlQzRlB1bzdvdUtVTzJNclBGaVRLb0tOV1dV?=
 =?utf-8?B?TGMwblBYT1JjWVdUR25RSDd2SkhhN0laTlIvQ1ZUbFZMeG8rZ3dEL3FMQmh5?=
 =?utf-8?B?UE50WlJ3Q05tOVY2TWdsNkw3VnVseHYxSFF1WDlvRDZQY1pmWC9uN0w4Wmp2?=
 =?utf-8?B?UEZOaDNWMDc1bDNBZ2k3aHNxcmxZc0Fxc3dDWEJQbktPc2lDakI5bENBb0tR?=
 =?utf-8?B?UElaVlhQSGRNSWM1K1FHZWgyZHlwOWdVZDhta25OdHA4dllrQjRFOEFSUWds?=
 =?utf-8?B?b3E5QTZUZnVDL2NFSWRKTUl1emZ4WWkvM1V1RTN5cmVjL0RhYWx4MkFjTFlY?=
 =?utf-8?B?Z1FhNnFiYnBEME9BOFlCYjVpNVk2SUUzYjE3K1luc05MRDVzTUMvWXJhdmtq?=
 =?utf-8?B?WXpwVU5TYTVsVXBaQ1h2RXg4M2JmajNnQ3ZUOHVuK0F3cW9abGtMSStPczZx?=
 =?utf-8?B?Mm5wcXRxWnl3Z3Fmc2EzRmEra0NLTDJMb2NTQ0JJMUZGVWNOWXdlUDAwbTRO?=
 =?utf-8?B?T1JvaWVSd0ZZczdlL0Z1SHZQSDVsMHVabFYxMWx4UVlxcFdQU05zMTV0NGI1?=
 =?utf-8?Q?EtRk1MTRgF+5j7ksD0FFOMLTX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF42F8E19E03FD498C8DFE0CAF99489C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e681b3-c9d7-44ae-4141-08dbaf6ab862
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 06:21:49.7817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRNEYr4LZ2XsGCieYiWyXRPJcBer6A6u/F3HKTXPOC/sGPgXzmLM+eJj1QzCWEhTGQWNm03w1ycyIHlB/YWcDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6055
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBGcmksIDIwMjMtMDYtMTYgYXQgMTU6MzYgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBGb3IgbXQ4MTg4LCBhZGQgZHNpIGNtZHEgcmVnIGNvbnRyb2wgdG8g
c2VuZCBsb25nIHBhY2tldHMgdG8gcGFuZWwNCj4gaW5pdGlhbGl6YXRpb24uDQoNCklmIHBvc3Np
YmxlLCBkZXNjcmliZSBtb3JlIGFib3V0IFdIWSBtdDgxODggbmVlZCB0aGlzIGJ1dCBvdGhlciBT
b0MNCmRvZXMgbm90IG5lZWQgdGhpcy4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2h1aWppbmcg
TGkgPHNodWlqaW5nLmxpQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hp
IDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gdXNl
IG10a19kc2lfbWFzayhkc2ksIERTSV9DTURRX1NJWkUsIENNRFFfU0laRV9TRUwsIENNRFFfU0la
RV9TRUwpOw0KPiBkaXJlY3RseSwNCj4gcGVyIHN1Z2dlc3Rpb24gZnJvbSB0aGUgcHJldmlvdXMg
dGhyZWFkOg0KPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMDE1ZjRjNjAtZWQ3Ny05
ZTFmLThhNmItY2RhNmU0ZjZhYzkzQGdtYWlsLmNvbS8NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgNyArKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kc2kuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gaW5k
ZXggNTAwYTMwNTQyODJkLi44YjQzZDlmNDgxNzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kc2kuYw0KPiBAQCAtODYsNiArODYsNyBAQA0KPiAgDQo+ICAjZGVmaW5lIERTSV9DTURR
X1NJWkUJCTB4NjANCj4gICNkZWZpbmUgQ01EUV9TSVpFCQkJMHgzZg0KPiArI2RlZmluZSBDTURR
X1NJWkVfU0VMCQkJQklUKDE1KQ0KPiAgDQo+ICAjZGVmaW5lIERTSV9IU1RYX0NLTF9XQwkJMHg2
NA0KPiAgDQo+IEBAIC0xNzgsNiArMTc5LDcgQEAgc3RydWN0IG10a19kc2lfZHJpdmVyX2RhdGEg
ew0KPiAgCWNvbnN0IHUzMiByZWdfY21kcV9vZmY7DQo+ICAJYm9vbCBoYXNfc2hhZG93X2N0bDsN
Cj4gIAlib29sIGhhc19zaXplX2N0bDsNCj4gKwlib29sIGNtZHFfbG9uZ19wYWNrZXRfY3RsOw0K
PiAgfTsNCj4gIA0KPiAgc3RydWN0IG10a19kc2kgew0KPiBAQCAtOTk2LDYgKzk5OCw4IEBAIHN0
YXRpYyB2b2lkIG10a19kc2lfY21kcShzdHJ1Y3QgbXRrX2RzaSAqZHNpLA0KPiBjb25zdCBzdHJ1
Y3QgbWlwaV9kc2lfbXNnICptc2cpDQo+ICANCj4gIAltdGtfZHNpX21hc2soZHNpLCByZWdfY21k
cV9vZmYsIGNtZHFfbWFzaywgcmVnX3ZhbCk7DQo+ICAJbXRrX2RzaV9tYXNrKGRzaSwgRFNJX0NN
RFFfU0laRSwgQ01EUV9TSVpFLCBjbWRxX3NpemUpOw0KPiArCWlmIChkc2ktPmRyaXZlcl9kYXRh
LT5jbWRxX2xvbmdfcGFja2V0X2N0bCkNCj4gKwkJbXRrX2RzaV9tYXNrKGRzaSwgRFNJX0NNRFFf
U0laRSwgQ01EUV9TSVpFX1NFTCwNCj4gQ01EUV9TSVpFX1NFTCk7DQo+ICB9DQo+ICANCj4gIHN0
YXRpYyBzc2l6ZV90IG10a19kc2lfaG9zdF9zZW5kX2NtZChzdHJ1Y3QgbXRrX2RzaSAqZHNpLA0K
PiBAQCAtMTIwMCwxOCArMTIwNCwyMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kc2lfZHJp
dmVyX2RhdGENCj4gbXQ4MTgzX2RzaV9kcml2ZXJfZGF0YSA9IHsNCj4gIAkucmVnX2NtZHFfb2Zm
ID0gMHgyMDAsDQo+ICAJLmhhc19zaGFkb3dfY3RsID0gdHJ1ZSwNCj4gIAkuaGFzX3NpemVfY3Rs
ID0gdHJ1ZSwNCj4gKwkuY21kcV9sb25nX3BhY2tldF9jdGwgPSBmYWxzZSwNCg0KR2xvYmFsIHZh
cmlhYmxlIGRlZmF1bHQgdmFsdWUgaXMgMCwgc28gdGhpcyBtb2RpZmljYXRpb24gY291bGQgYmUN
CmRyb3BwZWQuDQoNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RzaV9k
cml2ZXJfZGF0YSBtdDgxODZfZHNpX2RyaXZlcl9kYXRhID0gew0KPiAgCS5yZWdfY21kcV9vZmYg
PSAweGQwMCwNCj4gIAkuaGFzX3NoYWRvd19jdGwgPSB0cnVlLA0KPiAgCS5oYXNfc2l6ZV9jdGwg
PSB0cnVlLA0KPiArCS5jbWRxX2xvbmdfcGFja2V0X2N0bCA9IGZhbHNlLA0KDQpEaXR0by4NCg0K
UmVnYXJkcywNCkNLDQoNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rz
aV9kcml2ZXJfZGF0YSBtdDgxODhfZHNpX2RyaXZlcl9kYXRhID0gew0KPiAgCS5yZWdfY21kcV9v
ZmYgPSAweGQwMCwNCj4gIAkuaGFzX3NoYWRvd19jdGwgPSB0cnVlLA0KPiAgCS5oYXNfc2l6ZV9j
dGwgPSB0cnVlLA0KPiArCS5jbWRxX2xvbmdfcGFja2V0X2N0bCA9IHRydWUsDQo+ICB9Ow0KPiAg
DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHNpX29mX21hdGNoW10g
PSB7DQo=
