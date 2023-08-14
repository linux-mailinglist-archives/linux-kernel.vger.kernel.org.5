Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2109177B22B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjHNHPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjHNHPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:15:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A64E71;
        Mon, 14 Aug 2023 00:14:57 -0700 (PDT)
X-UUID: 439267943a7211ee9cb5633481061a41-20230814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=99kKkJxXnOHusF17uzlv4cIeX6ZFTNnrl4paxNfjEuA=;
        b=TIcymlC3Ex+bz0usnnCpLFfKux3WsFlxyBf8u7uWSV56hTxoV7wgJWbjzDUyjg56eSK0n5yfVcfnB17pbk3vqko6HZW1tsSml48BVGjS22/NNnFZIG1GJoLwjOV0adlQg6bF2xwC9BjDJ/yGLj15RvnZlNFF2mEcQqA1zOMc58g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:f9b36c83-cbfb-46d8-ba22-8c2e3a9d6e21,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:bcdcd2c1-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 439267943a7211ee9cb5633481061a41-20230814
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 554467642; Mon, 14 Aug 2023 15:14:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 14 Aug 2023 15:14:52 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 14 Aug 2023 15:14:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGHnTvHMzt0oryF+X8Vl5zZeP2PMgYoAyRNvllMDfhyiC1w8C7fPn7OlIN6dsPki6XtxgItCgA+Vc1Uh19yLEfVtLNe1zL7Cl2/w/MExB/igRXOmdUn+KFddMPmxCfvKTfhyd0Sr20tP9nFNsjFrmrHdLhT/rXul8bcn+HIZxrYP/X90zWl5XLBGjBJSBdMIgNlRgD/va0a2vBWHxPOz9y1pt51SrWClPZQInU0GtmWCI5aRSThp6dXc/AHRykK5m7FR4d8ay4YrZDMzhdsQArZZUc+P1eNMyaESgjaA3T1n4h6HnHW4UJzrpCkw4BM2sx8WrZm0+SoF80al//tXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99kKkJxXnOHusF17uzlv4cIeX6ZFTNnrl4paxNfjEuA=;
 b=NKju+2zx+lTOs1ETFxAkZ6mSyzvmI2HayZXEzFBkjFvDdzilp5WA4ULSdTXqCHRIXw8Zif7F7jfC9rfqvcJ4nV93EtzPbHc3jc1V4hXQT+Surx4gxY5SbS39UdmWhpHOMd11mzkv7FhGVOzUWdfLMVdrEnaNALv4fSWbgaaF5VZE1kh+QbKIz3hCalrQmfgdXGLiaEx3x/vGS0pZ/QvlBwbl8B2XjzEU4BMjomjqPt6NqEWkovoMwxa8twqkPk6ic5CXj54L/2+gX42Z2kKfqo5DVqZ/6eUfBVJYgDCtOWiXlTKtLn5AO5BaFdpAFrvJVdMNueboyTfBYfJqWBxDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99kKkJxXnOHusF17uzlv4cIeX6ZFTNnrl4paxNfjEuA=;
 b=DGHN/h+KguUkDdXKDmRKP6UeMrpPSa4b5ZHiLWWdtAWRenbzVtWRnDs3XNzmgphTfRVJgwe+7q+W+MHJqxd8uPuAQhgGxz43i/wtvnpClKbXplJ4rbHME9gH+6YM4mmOfr6xAcPmBpLbgBKLZIZp62SxEZg9IrrHGDYGr99hKSk=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SI2PR03MB5371.apcprd03.prod.outlook.com (2603:1096:4:108::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Mon, 14 Aug 2023 07:14:49 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::8c43:33cf:6057:fdfe]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::8c43:33cf:6057:fdfe%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 07:14:49 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v12 5/7] iommu/mediatek: Add MT8188 IOMMU Support
Thread-Topic: [PATCH v12 5/7] iommu/mediatek: Add MT8188 IOMMU Support
Thread-Index: AQHZlTFol72i25hY8ESS/o7MevPsra/gkh6AgANOQwCAAP23gIAE9YkA
Date:   Mon, 14 Aug 2023 07:14:49 +0000
Message-ID: <810a3cbca7e837925b5750fd2eb1d1a261e865dc.camel@mediatek.com>
References: <20230602090227.7264-1-yong.wu@mediatek.com>
         <20230602090227.7264-6-yong.wu@mediatek.com>
         <CAGXv+5EKwvn-axETPcuxTpxRkUGLroymeDYL+kr4QW8duAymmQ@mail.gmail.com>
         <b695962fa3c3baac08f8be5202e6a5697e7826a0.camel@mediatek.com>
         <CAGXv+5EVqODJJ4Ck+EcB9sn1bTjG5yFrWLi9mHTfVa0sB4wsug@mail.gmail.com>
In-Reply-To: <CAGXv+5EVqODJJ4Ck+EcB9sn1bTjG5yFrWLi9mHTfVa0sB4wsug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SI2PR03MB5371:EE_
x-ms-office365-filtering-correlation-id: 8dc372bf-4183-4de2-0143-08db9c9625c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bx2SOe1ESWeSa/6a/zVZyEQd+B8Eh24mL7M5nc+P9UEwInAFXfALuPOWvTvlr1hW8Kl9L3SI+YOtSL39TKPOChBp3WZxFyVZ0RjNazGTJyaGJAaBu56EwHEBga/NTAQmnh3WXZ29Bq/+6RZbrzhcmB6BomBRLkSZ3BaBksRoBLyCEXlCvdv9znYvJxr4aZ+2yxuYg4okbGvCyi/03fXiZU+NqVcqiNu/U8cdamkT84TqOu2b9eW1JBFHov/qBnnYx8gqxeEyEY8i96zK3DRzs6r9y4zOoCq5dI5WT8ls81EoBIeAUnTr2O1xv+863z+q4hc07zBd4bgN7DoSak69E4ZGvV5mb+UFO0mxiB0N9rmnmeyDT9G9phlXQGGjBLkR7kndGBrbW+1OMTgOoG8L+3tn7DOinF/FEBuhExyYd0frZBFHLio3Dd2hGo6MML+0x8aKM8qK1UbSKK3tJ3b/0K9vuzsHGMz1MzWZORe9eVFx2yFjs6K6EFwqz9w8/3Jsv5pMMaJT0BTssqhGXgEI5KOAn8zrUesaRwt6DPxx3uaECvicrSYEqOMOni/ZWNWHJnpgz2Mo5oI5fX4FclU58zdlH6m75TuxaK/RjDSPMkGE/TFiXmneneAIPmOJUsEas6X0/lDdf927rogo3UAYLxBNNNSvONtXmEsqacBm8JrxBbMtJYqBXu8AojTf++53
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(396003)(376002)(186006)(1800799006)(451199021)(6486002)(6512007)(54906003)(71200400001)(85182001)(36756003)(86362001)(38100700002)(122000001)(83380400001)(6506007)(2906002)(2616005)(478600001)(8676002)(53546011)(8936002)(41300700001)(26005)(7416002)(38070700005)(76116006)(5660300002)(66946007)(64756008)(6916009)(66446008)(66556008)(66476007)(316002)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3BOb0hkV0RpYzZTWnZacVo0cXRYVWJ6VnNiaEJZbjhOVnRZQU4zYWxzK29U?=
 =?utf-8?B?cUpTMndCRDdQdzZURTlpK3kxZHVOMnNzRytuSmdXU29VaGE2SWRiZmhHcGpj?=
 =?utf-8?B?c3YyMXlJcS9VallrK2xjek11eWVkTUhWSDVNdFpOWWwreW5JSmxGWFo3TTJt?=
 =?utf-8?B?MjJhZ3Z0Wm9IYnFjdjIwcGsxdzN6Y3NtTmhaNDRQcmpzRHBxNVRrUlAyUWpM?=
 =?utf-8?B?dGhjcjdNeU1sVldiTjRDSDQzcEl2bko3em56ZXpVZmNuOXcyaVozQnpXRlF1?=
 =?utf-8?B?TmxnL3ZYMzNISStsRlNaaWY2aVBzTEZXUS8yZXpvWkpseTZrbU52aEFaV2p6?=
 =?utf-8?B?dlV3MmJ4T3pUS01BVEpFMDFJK1NsRm5TR1I5dUt4N1lQTzdGZ3R2UG56TFpa?=
 =?utf-8?B?eElic3ZVMkJockgwMTBXazJxa05vM3RmOWlXbDRTdC9HZUswcTVXdDIzdDFW?=
 =?utf-8?B?R2t6MzJhNkFBa3V3QStpVTFyei9ieXRmV2c5Rk80clhIblUvNE52c0hUUnYr?=
 =?utf-8?B?a1VaR3Nucy9tOVMyZkl5cTM2aFNramJFcC9FSzVPUEZuRWlUcHVMeGdHWm5F?=
 =?utf-8?B?YmFiTUZTWklRRlFSV3dGYVlnSmpRNEpkZHRLUHgxZWlvNmN5Mlc1cU00TnVn?=
 =?utf-8?B?U054ZUVUYm1lNXhGRlRzTW5KajhXTExvcjRCY1hwUVhRbHRDM3djQk9VaE93?=
 =?utf-8?B?cUJtV2pCUVRsUTcxQUxySEJHMld3UXMrZE52QjVTMzRnZ1dhbExoSHE2NUVT?=
 =?utf-8?B?cjlyQTZYcHdCU0xvNXhXYjYxallXSGpzekRqcWRFamdJb1BJcVJBVUFIUGZI?=
 =?utf-8?B?MGhWUGZna1ZMNks4SHplUXhuaDVldmZWNWZ3SHNzRGNneU1MZmdjaWxNclYx?=
 =?utf-8?B?SmNHWVdKNjI3ZXlXMSs3aWFDTnAzZVdITlQ4MzVNblgrVUlJNjJpUERTNXo4?=
 =?utf-8?B?VGN6Y3ZrVXp0MnJOcDBpZGRFS2I5WEtjRkF4UlRGa1VOSFVyQjQ5RHI1YUJO?=
 =?utf-8?B?WHF4RjRlNkxCZUhPc0ZaYi9MeXdaYVh5Zm9JTU8ySVg0QWxTTnphei90SU0x?=
 =?utf-8?B?M0I2a1FTKzA1MEtqTlVtaXZuTVYwL0krdDhOZEVIZWFUNWd6bzg3YWc4MGVw?=
 =?utf-8?B?ZXIrOU9WaHRIdWxROXpBaFFNN2VsSWROeE5rYm13ZnNrZktJbldkbHU1S0xa?=
 =?utf-8?B?VTMwVHJVM1R5d3FMcGNWUSs5WTdKNS9oN2N2WmFFc1cvTm9wSTJhSnVIYXVN?=
 =?utf-8?B?U21BVFpIL3pFL2ZxMFRwQlhJOE5DNnh3NTdxZWNnSE85UjJJSkFSb05Dc2dt?=
 =?utf-8?B?VzlXOWRzS2taSm1RLy9VU0xOWms3Z1ZaWGgvNTdqMkVzT3BMSUhFWnJTSlMx?=
 =?utf-8?B?TW5SbmhaYmJaczYxOXBvTm9lTGtLZUoyK21wV2RtVUs1eERCTVdYckFONnhD?=
 =?utf-8?B?endIMDRCQjNHbDNXWk40S2JsQmxaQ1dsUHNWcXpKTW5SRDcrRnpXdHlZdnNH?=
 =?utf-8?B?RklFNk9BZk5rbjdONllYRGlBQzVoNndhRFk3M3pqUkRjbmtQang0VVFTSVpT?=
 =?utf-8?B?TXFGcUs1VUo0WTVKN1FUVFF1OUFwc1N4TExhN1lYWGlrODk3MUxRR0I0ZWda?=
 =?utf-8?B?K3JIbG9qamtabStvMFpXbVh5Zyt5akE3YUNISCt5Y2I1cmJELzJOUC91a1Q0?=
 =?utf-8?B?SHFIR0JxSnl1WDBkRnVwdHRoVUlBWDRGMG9zYUt5OGNPNnBsMmdrZGZIQ0Fr?=
 =?utf-8?B?d1UzNDEyeXRtYmxkY0NrV3Z5SEd4b3M4cklhTzBuMkZQSWRRRHA5dVdKaEFy?=
 =?utf-8?B?MjlGMnhwUWZtK2xaL3FaNlJHUTJFTlg0dFZjQUsvcVNsc2NqM1pFenVxZmxD?=
 =?utf-8?B?TzFtNnFTYlFySmtleEVFK3g3WmVRdmRJNXRURm82L1lCTDRhcWlqamZCaVZ3?=
 =?utf-8?B?UXRZcFdKMmJFQW4vb0JYSlQ0K0tiWlNBT2QvLzhYdVZZM2h4bFdadVFWZUtJ?=
 =?utf-8?B?cUJMOHZjUVBsa3dXMnRTaHlNamFwdTc2cFhnejZqUTAvc0o5eG8yYSs5WkZB?=
 =?utf-8?B?NzRtMndydk03NWNjUDNKT1ZCRlVuc0hMRTI1VVh2MkZTbEM0WExQZk1FTVc5?=
 =?utf-8?Q?vpdBYJIOjPa/6C/eVZ91nnozd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3545657066FDCE42894932DA14DE2C32@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc372bf-4183-4de2-0143-08db9c9625c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 07:14:49.5883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tTZbz7Wk/NZSTn8ntKT/x3eV+n5vI0C4AAXgLCncr5ImeWCkkYEFjMZKUDrM/kVyEkrcAZTLO/Qq+zpgrCemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5371
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTExIGF0IDExOjMwICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgODoyM+KAr1BNIFlvbmcgV3Ug
KOWQtOWLhykgPFlvbmcuV3VAbWVkaWF0ZWsuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1
ZSwgMjAyMy0wOC0wOCBhdCAxNzo1MyArMDgwMCwgQ2hlbi1ZdSBUc2FpIHdyb3RlOg0KPiA+ID4N
Cj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzDQo+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gIE9uIEZyaSwgSnVuIDIsIDIwMjMgYXQgNTowNOKAr1BN
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+
ID4gRnJvbTogIkNoZW5nY2kuWHUiIDxjaGVuZ2NpLnh1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4N
Cj4gPiA+ID4gTVQ4MTg4IGhhcyAzIElPTU1VLCBjb250YWluaW5nIDIgTU0gSU9NTVVzLCBvbmUg
aXMgZm9yIHZkbywgdGhlDQo+ID4gPiBvdGhlcg0KPiA+ID4gPiBpcyBmb3IgdnBwLiBhbmQgMSBJ
TkZSQSBJT01NVS4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hlbmdjaS5YdSA8
Y2hlbmdjaS54dUBtZWRpYXRlay5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3Ug
PHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNj
aGlubyBEZWwgUmVnbm8gPA0KPiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJv
cmEuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMg
fCA0OQ0KPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMNCj4gPiA+ID4gaW5kZXggOWM4OWNmODk0YTRkLi41YzY2YWYwYzQ1YTggMTAw
NjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiA+ID4gKysr
IGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+ID4gPiBAQCAtMTcwLDYgKzE3MCw3IEBA
IGVudW0gbXRrX2lvbW11X3BsYXQgew0KPiA+ID4gPiAgICAgICAgIE00VV9NVDgxNzMsDQo+ID4g
PiA+ICAgICAgICAgTTRVX01UODE4MywNCj4gPiA+ID4gICAgICAgICBNNFVfTVQ4MTg2LA0KPiA+
ID4gPiArICAgICAgIE00VV9NVDgxODgsDQo+ID4gPiA+ICAgICAgICAgTTRVX01UODE5MiwNCj4g
PiA+ID4gICAgICAgICBNNFVfTVQ4MTk1LA0KPiA+ID4gPiAgICAgICAgIE00VV9NVDgzNjUsDQo+
ID4gPiA+IEBAIC0xNTkzLDYgKzE1OTQsNTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9t
bXVfcGxhdF9kYXRhDQo+ID4gPiBtdDgxODZfZGF0YV9tbSA9IHsNCj4gPiA+ID4gICAgICAgICAu
aW92YV9yZWdpb25fbGFyYl9tc2sgPSBtdDgxODZfbGFyYl9yZWdpb25fbXNrLA0KPiA+ID4gPiAg
fTsNCj4gPiA+ID4NCj4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRf
ZGF0YSBtdDgxODhfZGF0YV9pbmZyYSA9IHsNCj4gPiA+ID4gKyAgICAgICAubTR1X3BsYXQgICAg
ICAgICA9IE00VV9NVDgxODgsDQo+ID4gPiA+ICsgICAgICAgLmZsYWdzICAgICAgICAgICAgPSBX
Ul9USFJPVF9FTiB8IERDTV9ESVNBQkxFIHwNCj4gPiA+IFNURF9BWElfTU9ERSB8IFBNX0NMS19B
TyB8DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBNVEtfSU9NTVVfVFlQRV9J
TkZSQSB8DQo+ID4gPiBJRkFfSU9NTVVfUENJRV9TVVBQT1JUIHwNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFBHVEFCTEVfUEFfMzVfRU4gfA0KPiA+ID4gQ0ZHX0lGQV9NQVNU
RVJfSU5fQVRGLA0KPiA+ID4NCj4gPiA+IEZXSVcsIENGR19JRkFfTUFTVEVSX0lOX0FURiBzaG91
bGQgbm90IGJlIHRpZWQgdG8gdGhlIGNvbXBhdGlibGUNCj4gPiA+IHN0cmluZywNCj4gPiA+IGJ1
dCBzZXQgdmlhIGEgRFQgcHJvcGVydHkuIFRoZSBJT01NVSBjb250cm9scyBhcmUgc2VjdXJlZCBi
eQ0KPiA+ID4gZmlybXdhcmUuDQo+ID4gPiBJdCBpcyBub3QgYSBwcm9wZXJ0eSBpbnRyaW5zaWNh
bGx5IHRpZWQgdG8gdGhlIGhhcmR3YXJlLg0KPiA+DQo+ID4gVGhlIGZsYWcgQ0ZHX0lGQV9NQVNU
RVJfSU5fQVRGIG1lYW5zIHRoZSByZWdpc3RlcnMgd2hpY2gNCj4gZW5hYmxlL2Rpc2FibGUNCj4g
PiBpb21tdSBhcmUgaW4gdGhlIHNlY3VyZSB3b3JsZC4gSWYgdGhlIG1hc3RlciBsaWtlIHBjaWUg
d2FudCB0bw0KPiBlbmFibGUNCj4gPiBpb21tdSwgd2UgaGF2ZSB0byBlbnRlciBzZWN1cmUgd29y
bGQgdG8gY29uZmlndXJlIGl0LiBJdCBzaG91bGQgYmUNCj4gSFcNCj4gPiBpbnRyaW5zaWNhbCwg
cmlnaHQ/DQo+IA0KPiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCB0aGlzIGlzIGZvcmNlZCBi
eSBzZXR0aW5nIHNvbWUgcmVnaXN0ZXJzLg0KPiBUaGUgcmVnaXN0ZXJzIGFyZSBzZXQgYnkgdGhl
IGZpcm13YXJlIGF0IGJvb3QgdGltZS4NCg0KVGhlIHJlZ2lzdGVyIHdpbGwgYmUgc2V0IGJlZm9y
ZSB0aGUgbWFzdGVycyB0aGF0IGhhdmUgdGhlICJpb21tdXM9Ig0KcHJvcGVydHkgcHJvYmUuIElm
IHRoZSBtYXN0ZXIgZG9lc24ndCBoYXZlICJpb21tdXM9IiBwcm9wZXJ0eSBpbiBpdHMNCmR0c2kg
bm9kZSwgdGhpcyByZWdpc3RlciB3b24ndCBiZSBzZXQsIHRoZW4gaXRzIGlvbW11IHdpbGwgYmUg
ZGlzYWJsZWQNCmFuZCBpdCBoYXMgdG8gYWNjZXNzIGNvbnRpbnVvdXMgYnVmZmVyLg0KDQo+IA0K
PiBTbyBpZiBhIGRpZmZlcmVudCBmaXJtd2FyZSB0aGF0IGRvZXNuJ3Qgc2V0IHRoZSByZWdpc3Rl
cnMgaXMgdXNlZCwNCj4gdGhlbiB0aGUgSU9NTVUgaXMgYXZhaWxhYmxlIHRvIG5vbi1zZWN1cmUg
a2VybmVsLCBjb3JyZWN0Pw0KDQpOby4gVGhlIG1lYW5pbmcgb2YgdGhpcyByZWdpc3RlciBpcyB3
aGV0aGVyIHRvIGVuYWJsZSBpb21tdS4gSWYgdGhlDQpyZWdpc3RlciBhcmUgbm90IHNldCwgdGhl
IElPTU1VIGZvciB0aGF0IG1hc3RlciBpcyBkaXNhYmxlZC4NCg0KPiANCj4gVGhhdCdzIHdoeSBJ
IHNhaWQgdGhhdCBpdCBzaG91bGQgbm90IGJlIHRpZWQgdG8gYSBwYXJ0aWN1bGFyIGhhcmR3YXJl
DQo+IHBsYXRmb3JtLCBidXQgc2V0IHVzaW5nIGEgYm9vbGVhbiBkZXZpY2UgdHJlZSBwcm9wZXJ0
eS4NCj4gDQo+ID4gPg0KPiA+ID4gSWYgb24gc29tZSBvdGhlciBwcm9qZWN0IHRoZXJlIGlzIG5v
IHN1Y2ggc2VjdXJpdHkgcmVxdWlyZW1lbnQNCj4gYW5kDQo+ID4gPiB0aGUNCj4gPiA+IElPTU1V
IGlzIG9wZW5lZCB1cCB0byBub24tc2VjdXJlIHdvcmxkLCBhbmQgQVRGIG5vdCBldmVuIGhhdmlu
Zw0KPiA+ID4gc3VwcG9ydA0KPiA+ID4gZm9yIHRoZSBTTUMgY2FsbCwgdGhpcyBiZWNvbWVzIHVu
dXNhYmxlIGFuZCBoYXJkIHRvIHJlY3RpZnkNCj4gd2l0aG91dA0KPiA+ID4gaW50cm9kdWNpbmcg
YSBuZXcgY29tcGF0aWJsZSBzdHJpbmcuDQo+ID4gPg0KPiA+ID4gQ2hlbll1DQo+ID4gPg0K
