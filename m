Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0BE781883
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjHSIsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHSIsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:48:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2904DEEF61;
        Sat, 19 Aug 2023 01:48:17 -0700 (PDT)
X-UUID: c43d1d003e6c11ee9cb5633481061a41-20230819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kx1X60h5ic6A0XcWKzSydOF+BP+wsAUDFAI2yZGA7cE=;
        b=DPnf8IoloS+XUH7puRC5KnA8zT3lx1O5v/RU1Y2j2ylkTz651JQ6qjhSROiL+9mysAsn39P3Qgr6oUCE1J6p2N8tur36PCQMFPUm2l+euCGCoJ72qodjBXX4FI0UgXUTh2B0d9vuVBQS7gSGivdNnjk5ZVi14Qg7x4URwBxKVeQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:aefbe764-94ba-4348-985b-7f1c81ab5330,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:092cf212-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: c43d1d003e6c11ee9cb5633481061a41-20230819
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 998597047; Sat, 19 Aug 2023 16:45:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 19 Aug 2023 16:45:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 19 Aug 2023 16:45:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3oiDwaRqPb2645CRlG46RQsLpzEH8v8wlOxrsT5saMA01AAL2ccsNRSKsgxs7lMqCeniz645dHv6ZgUpFkSLPOF3PSFNTrr7L2m8Uj0d+T741OEc/ds0PcZq/FnJ3+XbI77wMHipfCUaBzjaldUNT4pCL55Wsqu7UfWl3VSEPriaWgEjmRNcs5xbAjvmSAlEJwslr2Akns/0h7PapsoGvkUUrKqxB+G7F8gGf5+Tvjc6XT+uzC9czoPmKgHjS/Jdl3BKJ1mh1YQjCP/uKAibwZwkxhC6jb7H+51I2rrs5ADjSNuFhrVkH0S8fqY1wx1CWzI9W6iOCMgfend8EIHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx1X60h5ic6A0XcWKzSydOF+BP+wsAUDFAI2yZGA7cE=;
 b=jjif9f4s/2SPwCEk7WHCaVTAdGXI2rpIUk4uhburB5KY/uryV2b6R85BqEIR8PLoNDkSdpxle8HBQoNRP6oyP/8O4sJuZv5bZ8aMgBZtLApIM2VMfElJY6TCaZ8p6TAyv6IEUShtE4PWoci6wxMIkGlMzMqHqvD4VjK6azxaiHBTmfLBPwNvv2SdvPHAakeY6SHXArFSirGtQUbcAnJiHg86cnB4y5WqSmO+Jf6L8tGMOj985BAmL10aWmFxVCEfhCHXn3lWMa/J8zGRWUpsst/ntn8mIXAXf/UpFnOSh4ElLRyZrZKK4+nYsy8H3U5oJJAl4am4wtUJYfJU5zaLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx1X60h5ic6A0XcWKzSydOF+BP+wsAUDFAI2yZGA7cE=;
 b=XUcCOMv6V8earZZzNxDKYKmp0rah/trWifvd6CyYqNRSWfsIfQJ1AxiqogCHr8aTufOggWvePvOSwEDb8qAc70eOSJlKb+Y3e18j34SfYPNZrcXhPWcgiSvQWfa0XI/Z7BDypVGpKo7NNhZWjXyIRaGal4IW71eqmu7ecJ4+lpM=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEYPR03MB7399.apcprd03.prod.outlook.com (2603:1096:101:149::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Sat, 19 Aug 2023 08:45:32 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::8c43:33cf:6057:fdfe]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::8c43:33cf:6057:fdfe%7]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 08:45:32 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "laura.nao@collabora.com" <laura.nao@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v12 2/7] iommu/mediatek: Fix two IOMMU share pagetable
 issue
Thread-Topic: [PATCH v12 2/7] iommu/mediatek: Fix two IOMMU share pagetable
 issue
Thread-Index: AQHZlTENzYxCckXOEkeiWAvUdEBXlq/wqqYAgAEd/YA=
Date:   Sat, 19 Aug 2023 08:45:32 +0000
Message-ID: <12c6d8c39b402b63c57800189c18bffcf091e52f.camel@mediatek.com>
References: <20230602090227.7264-3-yong.wu@mediatek.com>
         <20230818154156.314742-1-laura.nao@collabora.com>
In-Reply-To: <20230818154156.314742-1-laura.nao@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEYPR03MB7399:EE_
x-ms-office365-filtering-correlation-id: 75fd3b98-e7f4-4191-d0b9-08dba090a5e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PK0GAH3Bf/Uy3BDmKsfNGIGxtmK2i3iBZ3zG4IMaqLm+nlOVUd51MMqu2WOKInLRBuyQ/1u61DOK/spONTyr0kXNljbhgt2Q4/LpGhMd9lzpKVkkrmnGS28Wy1tnIBBiE7oPZ1FROJK61BEGeNVZre5PFcOjM0frZGV32sHMsFS87Og8Eq8WxQNJA2XbkFgeVI94GYarAmlmy7icYgMtK2tmDHmUVqBx3QGNDsASrNHU58avHJ/fN+QQ/QrgWGLb0DhIkTD4nu+kHROtD4LEdCw4IDrV7Uec/EonumpdTMG7aK64y/GoEGMNUta+VFycE8CNAcMEXKnbkBoiZnkUPn26fE9rU9s65bq44MSiqEBfo3FXsGRLdG0R5pJ60U4pfwzYO7kjeH24EhbVG7eZHVePvqaiUFkwPj/FDJw6b6b0GqHC2K5YitKVm+/b2V4zRZ+06RwXKu1Sk823m/0Uu95gOkeTPpWSQrqGGm/0yWPcc8dbbDJQLtsLXERaymTeuRe8ClmKzVE4EC72Zt+FCBEuldLQ/fQGnc/fqY2WVXDiU5lrXuR0m/2iyZG8uurxwtsDveeKVKTlws9Tf/XPcbiWgZ9Rsmd7xcm531IrqdG+FZy5UWDqACy3f5Aba3nJaYsz5wVaRVJcFiVKJW38R6iME4GSqHHu6b3qoJzRwq6cuBkMeY3c6S4x9IDQGo8kPX9tu4vzftS5eCbiP1+afg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199024)(1800799009)(186009)(86362001)(2906002)(38070700005)(38100700002)(7416002)(5660300002)(8676002)(4326008)(8936002)(316002)(41300700001)(36756003)(85182001)(122000001)(54906003)(64756008)(66446008)(76116006)(6916009)(66556008)(66476007)(66946007)(71200400001)(966005)(478600001)(6486002)(6506007)(12101799020)(26005)(6512007)(2616005)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGsveHNJd0s1cThNMDBGNXQvVGtvY21LTHIrd05MU09iUGNYWUVvNFFKM0pn?=
 =?utf-8?B?cTNvVTcrSkZFZXVrSTVNbCszeVFGQmNkYmhCcEg4QW1kYjlkejlqZnVuL0ZQ?=
 =?utf-8?B?aVdPZUlFdTBsR0JUY3RkVDlWZWloQnNDZGxTaHlXYWtaOXptcVN6MTY4Wndh?=
 =?utf-8?B?WXdmOVE0YlVyS1NxeVZKMlBsMEsyTFFwZFpuYjJUZUpvWGNONUFrYW9nUER2?=
 =?utf-8?B?eHlnRG5raU1lckh2RjJtMHcxOEF2NUFnUFNtb1NNV0srcnJlM1RIcFQ1MlRw?=
 =?utf-8?B?dFZqRFNvRTQ3d0JYY0FBV2NqSTk1bXhnbEpON21OMGpySEExdnZPZVY3ODFz?=
 =?utf-8?B?MGM4VnpHS1lWSHVuTWZRTWtSaDIvMWJ1ZkUzTW45Y3FVd3M3MjJRWkVEdThX?=
 =?utf-8?B?cFFiSnZleGFmZC8rV1grSGNBYTFNOEd6VVBNa29ab1R0Nm1adEt2MTF2Rnli?=
 =?utf-8?B?RC9YM0xBYTdRYkNqUGIrVldqQlg0ekMydG5kN1dqRkpQVEhQMDg1TEVQUkh3?=
 =?utf-8?B?WFRDYVRlWkRtQy85Zlp1dXRkb1k5a3ljZkZOSmlFUUxYK1pGa0ZWWFcyaytD?=
 =?utf-8?B?WTBlanNVb0JVZlU3dnR1RjJnRDVuWTQraUZjMHJ0eUFzWlRWemNIanY2alJQ?=
 =?utf-8?B?Qm1RN3hiQ0hXOFFVcHRyYmJ3eFJaeXJMUXVyeFpEeUsySE9jeTYyUTRRb2My?=
 =?utf-8?B?Q2lMMU5aamJGcFB6Nzd0SldYSVRoa3FWa1dZUkhaTzR4ZXZ6Q3FXWWZhUFRa?=
 =?utf-8?B?ZzFzK3FuSU1KMmIvT2RpWGF0RGFvaVJlcklwNDFNWUlGczRtV3NlREhCTnRN?=
 =?utf-8?B?aFZhMU9JY2JISWxpMi9sMk1KWWRLUU5Iczdsay9FSFRpU29xYWF6M3M4QTlq?=
 =?utf-8?B?QXNaVWFhTERONlkwOTNzeVhFZHNGZ0hUVk85VVFCd0p6dXRTUTlsWjFsQWtT?=
 =?utf-8?B?N2lMVjlCTkZIVjBleWFyR1pMSHlEMkFqMHV0anRqcSt0NU54UlNvZDd4V2g1?=
 =?utf-8?B?U053aFVyNjcrRTBQeXFjTEsyQ1ZZeE44S0FIQ2pZRkRPS2VicDd4ZU5Ja1Yz?=
 =?utf-8?B?Szc0TUFQNm9ReUErK1hwM1RuRGpOZEZPcXA5OVhWQmtTb0lQWGd2QVpaMGt6?=
 =?utf-8?B?dW1SRUszRW5vTTMzVHFROEJvamFGcmNXYnZSREtxSUVueTZobksxRkZ1Y1h3?=
 =?utf-8?B?TjRFUytoSUYyK1B1STNER1FOVmxzeFQyNjBnZlNKVUZKSmRoWHE4Z25NNFU2?=
 =?utf-8?B?ekJxS2c5R1M0SlhLcHh4RmFSNSs1N2E5bmt2TlZvK1RXUVBSQ0dYUHhWc2RD?=
 =?utf-8?B?WDFNVitlUjBXY0s3WDBDWldzaVJ4Qm55STFQRnJ5b1psMGhzUUVmTS9HeVRW?=
 =?utf-8?B?N1I3bkpHQkZZM00rVFJwTzgxaWFOWm5qRVl6ZGptS2hzejBaNHRvRjZLbERZ?=
 =?utf-8?B?SWVFNk9HRWc4QnZMNGFHcmVYRGltUkpTT0IzZkJYOGRUSGtZQzNYR2MxR0xL?=
 =?utf-8?B?eEZkYVdyeVMrRythbThKOFJ1NlpVbTd0bkExU3JiS28waDZPOWFDNmllVEF4?=
 =?utf-8?B?dGpiS0E3TjJ3ZE9uVzVibTJtL3BQeWZKMi9pME8zOGViRWg0MWE0cjlsRW9B?=
 =?utf-8?B?MC9QTWg1ZEJCTXdEZ25yY1BhVU8zNFcxM01CRElrNlBYY1RUWDdvOWZmT2Zu?=
 =?utf-8?B?OTFCcE9UTEpSVDk4L1NENlZzUndGdGdMTy80TmpvcTdyUE42T0FHUzRsa3NH?=
 =?utf-8?B?SVJRWmYwN0ZtSnJzeElJTmtROTMzY1FBOVladDJZd2JOb1FHbXhPenJBYWJV?=
 =?utf-8?B?SFo3bmdUVWRHb3BqbnQxM1p4QW9yNE5SUFp5cG85UHhKeGxERkYxNlJjR0NC?=
 =?utf-8?B?L0JiNlpBRWpja2thMVF2TGczeW53bEZmdGR6azlvNzEvaGphYXVOZFF6K3cy?=
 =?utf-8?B?dTNzUUQydzBNWEtYNS9YR1piYm9SaSs1S1hlbmhKbjU1Z3NZSnVMS2E3ZlR3?=
 =?utf-8?B?MDVOUUlwM1Rsc2FBeDBVL1JYT21JYjhYYjJiZ3dxbngycHdlSUVwaCtXM3Jr?=
 =?utf-8?B?VjBLZVRRSUhseDE5WDlnVjNOdjJ2eFpMUlZkRnlnZk5NclQ0a2RrNGZqK202?=
 =?utf-8?Q?Iw4A3zywDSZND/LXNfdXLs2bL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C558A3FE51FDA7429A2C1D13F917DFC4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fd3b98-e7f4-4191-d0b9-08dba090a5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2023 08:45:32.2027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYSKn8ADpMtb9xqxuqD4UyTBg2HC19S6wwE1bU1BTQHKg9FWdmYrvrT3UX5zD+da3472/U0P2n12TiO6rmZeFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7399
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmEsDQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHlvdXIgdGVzdGluZy4NCg0KT24gRnJp
LCAyMDIzLTA4LTE4IGF0IDE3OjQxICswMjAwLCBMYXVyYSBOYW8gd3JvdGU6DQo+IEhlbGxvLA0K
PiANCj4gVGhpcyBwYXRjaCBpcyBjYXVzaW5nIGZsdXN0ZXIgdGVzdHMgdG8gZmFpbCBvbiBNVDgx
OTIsIElPTU1VIHJlYWQgYW5kDQo+IHdyaXRlIGZhdWx0cyBhcmUgcmVwb3J0ZWQgaW4gdGhlIGxv
Zy4gSGVyZSdzIGFuIGV4dHJhY3QgaXMgZnJvbSB0aGUNCj4gVlA5IHRlc3RzOg0KPiANCj4gbXRr
LWlvbW11IDE0MDFkMDAwLm00dTogZmF1bHQgdHlwZT0weDI4MCBpb3ZhPTB4MWZmN2MwMDAwIHBh
PTB4MA0KPiBtYXN0ZXI9MHg1MDAwNDgwKGxhcmI9NSBwb3J0PTApIGxheWVyPTAgcmVhZA0KPiBt
dGstaW9tbXUgMTQwMWQwMDAubTR1OiBmYXVsdCB0eXBlPTB4MjgwIGlvdmE9MHgxZmUzZWUwMDAg
cGE9MHgwDQo+IG1hc3Rlcj0weDUwMDA0OTIobGFyYj01IHBvcnQ9NCkgbGF5ZXI9MCB3cml0ZQ0K
PiANCj4gVGVzdHMgYXJlIGZhaWxpbmcgZm9yIEgyNjQsIFZQOCBhbmQgVlA5IGRlY29kaW5nIG9u
IG5leHQtMjAyMzA4MTcNCj4gd2l0aCBmbHVzdGVyIGluIHRoZSBzYW1lIHdheSwgY29tcGxldGUg
bG9ncyBjYW4gYmUgZm91bmQgaGVyZTogDQo+IC0gSDI2NDogDQo+IGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwczovL3N0b3JhZ2Uua2VybmVsY2kub3JnL25leHQvbWFzdGVyL25leHQt
MjAyMzA4MTcvYXJtNjQvZGVmY29uZmlnKmFybTY0LWNocm9tZWJvb2sqdmlkZW9kZWMvZ2NjLTEw
L2xhYi1jb2xsYWJvcmEvdjRsMi1kZWNvZGVyLWNvbmZvcm1hbmNlLWgyNjQtbXQ4MTkyLWFzdXJh
ZGEtc3BoZXJpb24tcjAuaHRtbF9fO0t5cyEhQ1RSTktBOXdNZzBBUmJ3IWc1Q2tWNFRteDhnWl9M
bDZBTXBvRW9zVGpTZ0tiZGZHMlJOd0pKRmRucFg0Zy1NVzBJZEFtdDNiWHBoaUlJZlNQbUdiYlBP
MXRGTTRiOHdTbHJnb2d3JA0KPiAgDQo+IC0gVlA4OiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vc3RvcmFnZS5rZXJuZWxjaS5vcmcvbmV4dC9tYXN0ZXIvbmV4dC0yMDIz
MDgxNy9hcm02NC9kZWZjb25maWcqYXJtNjQtY2hyb21lYm9vayp2aWRlb2RlYy9nY2MtMTAvbGFi
LWNvbGxhYm9yYS92NGwyLWRlY29kZXItY29uZm9ybWFuY2UtdnA4LW10ODE5Mi1hc3VyYWRhLXNw
aGVyaW9uLXIwLmh0bWxfXztLeXMhIUNUUk5LQTl3TWcwQVJidyFnNUNrVjRUbXg4Z1pfTGw2QU1w
b0Vvc1RqU2dLYmRmRzJSTndKSkZkbnBYNGctTVcwSWRBbXQzYlhwaGlJSWZTUG1HYmJQTzF0Rk00
Yjh3YV84M0VadyQNCj4gIA0KPiAtIFZQOTogDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL3N0b3JhZ2Uua2VybmVsY2kub3JnL25leHQvbWFzdGVyL25leHQtMjAyMzA4MTcv
YXJtNjQvZGVmY29uZmlnKmFybTY0LWNocm9tZWJvb2sqdmlkZW9kZWMvZ2NjLTEwL2xhYi1jb2xs
YWJvcmEvdjRsMi1kZWNvZGVyLWNvbmZvcm1hbmNlLXZwOS1tdDgxOTItYXN1cmFkYS1zcGhlcmlv
bi1yMC5odG1sX187S3lzISFDVFJOS0E5d01nMEFSYnchZzVDa1Y0VG14OGdaX0xsNkFNcG9Fb3NU
alNnS2JkZkcyUk53SkpGZG5wWDRnLU1XMElkQW10M2JYcGhpSUlmU1BtR2JiUE8xdEZNNGI4eGFP
VDJTTHckDQo+ICANCj4gDQo+IFJldmVydGluZyB0aGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZS4g
DQo+IA0KPiBGcm9tIG15IHVuZGVyc3RhbmRpbmcsIG9uIE1UODE5MiB0aGUgMTZHQiBpb3ZhIHNw
YWNlIGlzIHBhcnRpdGlvbmVkDQo+IGJldHdlZW4gZGlzcGxheSwgdmNvZGVjIGFuZCBjYW1lcmEu
IFRoZSBpb21tdSBkb21haW4gY29uZmlndXJhdGlvbg0KPiBmb3IgdmNvZGVjIHdhcyBsb2FkZWQg
ZnJvbSBmcnN0ZGF0YS0+YmFua1swXS0+bTR1X2RvbSAodmNvZGVjIGlzDQo+IHByZWFzc2lnbmVk
IHRvIGEgc3BlY2lmaWMgaW92YSByYW5nZSksIHdoaWxlIGFmdGVyIHRoaXMgcGF0Y2ggYSBuZXcN
Cj4gcGFnZXRhYmxlIGlzIGNyZWF0ZWQgaW5zdGVhZC4gDQoNCkV4YWN0bHkgUmlnaHQuIEl0IGNy
ZWF0ZXMgYSBuZXcgcGFnZXRhYmxlIGZvciB0aGlzIGNhc2UuIEkgc2VudCBhIHBhdGNoDQpmb3Ig
dGhpcy4gQ291bGQgeW91IGFsc28gaGVscCBjb25maXJtPw0KVGhhbmtzLg0KDQoNCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LW1lZGlhdGVrLzIwMjMwODE5MDgxNDQzLjgzMzMtMS15b25n
Lnd1QG1lZGlhdGVrLmNvbS8NCg0KPiANCj4gRG8geW91IGhhdmUgYW55IGluc2lnaHQgb24gaG93
IHRvIGZpeCB0aGlzIHdoaWxlIGtlZXBpbmcNCj4gY29tcGF0aWJpbGl0eSB3aXRoIE1UODE4OCBh
bmQgTVQ4MTk1Pw0KPiANCj4gQmVzdCwNCj4gDQo+IExhdXJhDQo=
