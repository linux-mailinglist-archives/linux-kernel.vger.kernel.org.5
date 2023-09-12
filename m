Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC179C391
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbjILDCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241498AbjILDCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:02:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CD71A39BB;
        Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
X-UUID: 34bcea36510c11ee8051498923ad61e6-20230912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ynjw/oY5wbaKFokiCbDPSLbsi3x0hbN/g/24MVY9xnM=;
        b=nV6TNTULj3YNU+Ag+eRblFToyHODMlg8LzW7kOxMwPrNw6zIO3PLI5ouli2Bpcr/a6zdHNyVyjtlLfCQK26NWvZwoLI2oKOqDK8msN7aPBXchdgNdWDTyx6hqoKhECzNXWKqPW7O0Opui2hQADuaqj3hnPDAYH9jdYUTS6qsWq4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:c83625c5-c344-4ac8-ab04-4fdf471ff75f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:e564b8be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 34bcea36510c11ee8051498923ad61e6-20230912
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1453691667; Tue, 12 Sep 2023 09:32:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Sep 2023 09:32:15 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Sep 2023 09:32:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1JR3CllXMcpnVmhmLba/mCQnqYFtNEnYb7NQw0K0yBWErzgtPK17xixL6lN2N4Eb3hwCVCtjfvBXRsTg/fWIKUckeJFd5Y+cnyrr+aa0HS9l2vKhsD4irOSWAbUdYfr8/Y5Qih9xYICa6yeg/91TF22ax+3pQhDPIA/QZYM7qWRgZQIL+XyYoQzGgenp9xKbJMjyVYV/1pr16qqgFmkk+N9bWIkzqSCeF6zH6ElvxsebuFOxoJY2gBSa0AWUY6Blr6AfNT4OOYMNg4R0x6bGF6wK+MXh01sZUvN6YV+FPmTaQOrvnNFLL1xAkG9rSjIYplHo6Ci1sBeQbQECFK27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynjw/oY5wbaKFokiCbDPSLbsi3x0hbN/g/24MVY9xnM=;
 b=KM5xrx7WmfOfZ/INXaSOJPP4Ppcr34GhXkbfEtJ87+FzGwuFtOVzdy1M8CPlpNi+uwsiYgeab8qzMPseuy07bE/rsN5Vm37WtKg4jsfqfCDihn6Ta0XFg9Oy8dkmN7KMQxQvvyewYSfV141JxrM4jFInn6sXuJMm+lavsjVzx+OfoD5gNhCjULBWz4/jUsP311Y4TGCQPxR4f0dV+JzUaN0LCGF+wLe0NckQ2mJ7M7w15vPscXbCTGiO63rwle7f/ZLSnehp4VeVnysjivfZFQHuMgy/shZmff5dz5qwO+KD+TRvQWUoAh82tMJZy9sxFAUrhIQGsHVy5Ci3dgxVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynjw/oY5wbaKFokiCbDPSLbsi3x0hbN/g/24MVY9xnM=;
 b=pONLy5+w02+2o34TgY0CzQzTKWxkUcXQsLSlsnxsi1hCnAjZJ5KuRtEpgmTPCfSg45hGaYz6/SFFCylUjbvbEK6QopQeUc4fmzw2iLcdWzmuQ39o158fzCmOkoQMjBJxgcFCi8dlWGA/cymY1go0voHPve1AIhJ6KX9mZiisMUk=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SG2PR03MB6384.apcprd03.prod.outlook.com (2603:1096:4:17f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 01:32:12 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::9a3c:4c0b:e835:1004]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::9a3c:4c0b:e835:1004%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 01:32:12 +0000
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
Thread-Index: AQHZvHBx/huLhEsfFEGsbf+FOHiHJK/JWA2AgAbI9QA=
Date:   Tue, 12 Sep 2023 01:32:12 +0000
Message-ID: <d7a3e08e8c1a04702b041c822439e85df166cd0a.camel@mediatek.com>
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
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SG2PR03MB6384:EE_
x-ms-office365-filtering-correlation-id: 58c5c8ba-c81c-4a87-027a-08dbb33016be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8QPbOnCgC5j6QFKuAhxi6vFqRiVf1jrqgFbzxd/iJ1j6PHz1FWIclbUN2GM/yN+zggbrzQAvhFn9eZ2JnJXcDs2FRCC87u7z0eK9d5Wkdg46SnCMrGEN0razuPmOJPNEFAW19izAeNVsBZpF06n3bVh8ZvwWlBYxpfJmon43iiLb3FQizK6gvwyfmloSvS2PN1UtyYmSnO0vewb+ygIiGgPnFBV9MZh7QlN1y49hJ/PwX/1W1OBLZMmrHibvB00RqwwtDMfHE4myBPDQPOm8znTC3DPaVIjXOpuKcGVAG3cZOtHSRmJVrHCgGoLWZP00vg2a/We0C7IzolkVgmhk5S8G/9HQFWFLFIw5aLCA2M8hdS9xg/azukEuMtYcp7P8K+D6P0XkdAjVZf40zxriE3O9w4rvH7AEgv1EsCNFuUNn9kxJVGFLxNVfM/18zScLEYzQU9BXg3l0c68hXL8fGjsyylVzut3bmBlicC/m7TmAP2sqqn1Lbslj2nEW5BHY1iQ3Jl3s1Yo2tE02nINbp38FhDj2yhAQ+04GCFAgubRZvI5Aj9XoIKIwAD7QRu00zOWVqvXVmKmu9xuPB6XHubjTAAExHGaKx42Nn96YdrfoEeG5X2SXjYaITas6opkEnhRYyL9ZGt3s8bz+KEUs8SFTf/dREVY7KlXCnXg1KfzXV0aRpu2Cv6S/1jB6AEa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199024)(186009)(1800799009)(91956017)(71200400001)(6506007)(6486002)(6512007)(478600001)(83380400001)(66574015)(26005)(2616005)(2906002)(7416002)(64756008)(66476007)(66446008)(66946007)(54906003)(66556008)(41300700001)(110136005)(76116006)(316002)(5660300002)(8676002)(4326008)(8936002)(86362001)(85182001)(36756003)(38100700002)(38070700005)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWxIbVR4Ums0WGpWYi9FbHgvVlJUUHgvdzRvcG5HOVhCU2t4cWh4cUhrVzcy?=
 =?utf-8?B?dDdRYURoRUI5dS8zNm54SVJtLzFvcFFrU1V0OHNka2s4YnBLVEpEVExXeUhx?=
 =?utf-8?B?MzJkLzMwTWQvb3BzZ0VUSkdIOHpyN3YxM3hwK0ZkYUxGWXVwNldUYkRZdHBt?=
 =?utf-8?B?cjUwMXVCNGZlbXlSeEFMNTZIL3Uza3c1MnhPS3FvWlltYmZZSkY5bEFybzZQ?=
 =?utf-8?B?bXh6dFJoZzZ0WFM4czFTMlNKYmt2TVFlOWpNZ2FyRkJZcGlOYU9HcTBpUGdl?=
 =?utf-8?B?cEZybEl4OXpodGJLQzFCQmtqaWFDRGhtREFOa1dlWTljYjJ1OUtKT0x5YVNh?=
 =?utf-8?B?WTgrS2xFZ0NRazduemk0WWNvU2pybi9HbXR4QVlWbk1mOUFRY0Q2UHRONTFY?=
 =?utf-8?B?bGx1YXNvckdXY1N5SmNiejJBU0hnaFJtdmtjNGgyc0hnNlovTXhiMllwM2xO?=
 =?utf-8?B?SHhtekFxWFdxN3RLMURKN2NDTlZERmxRaHN2cDMvdEtoVUR5RGk1ZFAxQlZG?=
 =?utf-8?B?ZVdHa0lWL0xpeDkrUlFCM0preXBCaWMzOWlIc05CM2grKzVhM1drdG5xUnd2?=
 =?utf-8?B?dWVhV0d6ZCtsVk9mZG85V1B4aWFxU1RWR2loa1dDa3NLQU5DUk1XTEs1Njgw?=
 =?utf-8?B?elh2RmtsOUdUVGZ1MHpiSVE0aEE0UWlSYmpXTFUwMyszdmZvUkNJYzlDNzlX?=
 =?utf-8?B?V2QzbE9ZVjBTb1dGeVluRS96OWFCMzVwZVV3VytKTE9mYzJCN1JqVU5xd01l?=
 =?utf-8?B?NWI2bkY0anJlaGlLbHl0cEg3Wlp6cWJkY09MakFhU1hXZ3N5bnBuWFdrSDZZ?=
 =?utf-8?B?M1R6K2h0MG9GenBLOFdSVlV5UnJ2aDEzaldQUnByVFc0dFE4cmRHT1ZrOTBw?=
 =?utf-8?B?V0wva1lpWFFiSEQvVlh4OTNGaWlrbVJwNmZDWGJPcXR1ajdRYjdXR2ExV291?=
 =?utf-8?B?dTN4MDR5NHJQVEVyV2lsbXR3QU9NZDBWOVVZSWIwejA1R05xNExIVkdaZnJx?=
 =?utf-8?B?a251d3lhYlA1QTRTSTV1dWZIQ1ZNNEFXZFZCSkVGYXUyZ2tFZnQ1bkJLbTlO?=
 =?utf-8?B?VHU0dWRGaFVyTXNMOVpKRFV5Ny84M3RxSFVsYnEvZnlTbUZQQ1Z6MjlrWk8v?=
 =?utf-8?B?dFgzenVGTjEvQmpQSG5lY1pJdUpPeHJpZ0d3MUpOUUpzaUpDRkxtWDgwdFBa?=
 =?utf-8?B?d2NvRi9DVnRSd0JvaHV1Q3lBekNQTmNMMW5XNTAvdGhrR2JpeUFqYTlqZlQv?=
 =?utf-8?B?ZE5YTUIyN1RJclNTRFVFcU1tZVJQeWQyZDRIRzVBODZpMjBNVFdDYnpORk9p?=
 =?utf-8?B?V2N3TUFXWVVzRWY2ZDl3NkNFb2QvRHU0bTFTd3g2OFc3VUpLRUNpcHEwRys3?=
 =?utf-8?B?QW9QazdMblR3eGsrak84Q1BtSmVhc3BXZHpCSkFSRmNEeXFCSlgrVHhaOE9X?=
 =?utf-8?B?TjdwNEc2ckRwaW1sUXppYVJTdXM5ZTNKL0xSNisyeTVlY2pQSEh1MkhGdVR3?=
 =?utf-8?B?U3Vxc3dXNDVuMCtlSGpVYlB5VDVIbGN4VWhSazFlN25EOWNiL2tQaXpNRmRV?=
 =?utf-8?B?TCtXVDIwb0RiVExZaXRkVVdiYkVZUFNRMjJIZk1WaGFrb2NzTVRiOEI4cUM4?=
 =?utf-8?B?ZEV0bWdwVXhBdWV3ODloa05Cd1ZuV1ZOamVnMmpvOFJuQkkraGF2dDBhNS9U?=
 =?utf-8?B?emtEVmExMnI2a2dwN3B5U1AwMFhlSHFCWWk4YmhZMWlucExZOHpWTklaWmJP?=
 =?utf-8?B?U3NPZkFYa1YvcjNDdHpsOW02bEk1SHQ0bjYzOHVjOXFiRk16NkdyU2w5MjM2?=
 =?utf-8?B?QUVFQkhiclB6N0syZDFKcGZrWnRKOTFZSTJESXhWeWdSVnJwTEw5VTdabmh5?=
 =?utf-8?B?Y3huRklRUXk5RmVQYVg5YVFsczVSYURkZFRkSi9BOXpVY2wydjZEQkFyM282?=
 =?utf-8?B?N3JIVGF4eWxQSFUvKzVuUCtWcGlVYU8yV05DU1hrYUJOMXFHZEdXeXJVYnZM?=
 =?utf-8?B?bk1VQXMxNW9jall5MDMvUTlXVW0zYnBud3N4Qll0SkVlemE0a1l0RCsvY2pp?=
 =?utf-8?B?R3BQa2J3WkFaa1VFNU02VlR5ZzF3TU9qa0xOanIxdmNMa2RFcEhwWEF0dXpr?=
 =?utf-8?B?MVdySlROSEpObTR5VFNVVmR6VEZDak92ZTVWVVQ0bXpwZkxLSmdlMmZzMjRT?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4CBE53D5977D142B3A21D143179B420@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c5c8ba-c81c-4a87-027a-08dbb33016be
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 01:32:12.4306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOJZtk+RzqE6FIgwMjQxkfod1a9DYrStRw46ywlceEm1VwWjp2wnYaDnw8GJRqKtGM2FkL5vPKenZC0G+0K+Uz/ZcV5Z1tZqcBwQgt4ak7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6384
X-MTK:  N
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
cG9ydCBhcw0KPiByZXF1ZXN0ZWQuDQo+IA0KSSB3aWxsIGFkZCB0aGUgY29tcGxpYW5jZSByZXVs
c3QgaW4gcGF0Y2ggdjMuIFRoZSBjb21wbGlhbmNlIHJlc3VsdCBpcw0KcGFzcy4NCj4gPiANCj4g
PiAtIHNlbmQgdGhlIGZpcnN0IHZlcnNpb24gdjE6DQo+ID4gLSBSdW4gMTBiaXQgVlA5L0FWMSBm
bHVzdGVyIHRlc3QgcGFzcy4NCj4gPiAtIFdpbGwgcmV0dXJuIGVycm9yIHdoZW4gdGhlIDEwYml0
IHBhcmFtZXRlciBubyBjb3JyZWN0bHkgaW4NCj4gPiBmdW5jdGlvbiBtdGtfdmRlY19zX2N0cmwu
DQo+ID4gLS0tDQo+ID4gDQo+ID4gUmVmZXJlbmNlIHNlcmllczoNCj4gPiBbMV06IHRoaXMgc2Vy
aWVzIGRlcGVuZHMgb24gdjYgd2hpY2ggaXMgc2VuZCBieSBZdW5mZWkgRG9uZy4NCj4gPiAgICAg
IG1lc3NhZ2UtaWQ6IDIwMjMwNzA0MTMxMzQ5LjgzNTQtMS15dW5mZWkuZG9uZ0BtZWRpYXRlay5j
b20NCj4gPiANCj4gPiBNaW5namlhIFpoYW5nICgzKToNCj4gPiAgIG1lZGlhOiBtZWRpYXRlazog
dmNvZGVjOiBBZGQgY2FwdHVyZSBmb3JtYXQgdG8gc3VwcG9ydCAxMGJpdCB0aWxlDQo+ID4gbW9k
ZQ0KPiA+ICAgbWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IEFkZCBjYXB0dXJlIGZvcm1hdCB0byBz
dXBwb3J0IDEwYml0DQo+ID4gcmFzdGVyDQo+ID4gICAgIG1vZGUNCj4gPiAgIG1lZGlhOiBtZWRp
YXRlazogdmNvZGVjOiBBZGQgZHJpdmVyIHRvIHN1cHBvcnQgMTBiaXQNCj4gPiANCj4gPiAgLi4u
L21lZGlhL3Y0bC9waXhmbXQtcmVzZXJ2ZWQucnN0ICAgICAgICAgICAgIHwgIDEzICsrDQo+ID4g
IC4uLi9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlYy5jICB8ICAyMiArKy0N
Cj4gPiAgLi4uL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjX2Rydi5oICAgICAgIHwgICA1
ICsNCj4gPiAgLi4uL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjX3N0YXRlbGVzcy5jIHwg
MTQ0DQo+ID4gKysrKysrKysrKysrKysrKystDQo+IA0KPiB2Y29kZWMvZGVjb2RlciBkaXJlY3Rv
cnkgbm8gbG9uZ2VyIGV4aXN0cy4gQ2FuIHlvdSByZWJhc2UgeW91ciB3b3JrDQo+IHBsZWFzZSA/
DQo+IA0KVGhpcyBwYXRjaCBzZXJpZXMgaXMgYmFzZWQgb24gcGF0Y2ggJ3NlcGFyYXRlIGVuY29k
ZXIgYW5kIGRlY29kZXInLg0KdmNvZGVjL2RlY29kZXIgZm9sZGVyIGlzIGFkZGVkIGluIHRoYXQg
cGF0Y2guDQoNCkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQo+IE5pY29sYXMNCj4gDQo+ID4g
IGRyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY29tbW9uLmMgICAgICAgICB8ICAgNCArDQo+
ID4gIGRyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItaW9jdGwuYyAgICAgICAgICB8ICAgMiAr
DQo+ID4gIGluY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaCAgICAgICAgICAgICAgICB8ICAg
MiArDQo+ID4gIDcgZmlsZXMgY2hhbmdlZCwgMTg4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+ID4gDQo+IA0KPiANCg==
