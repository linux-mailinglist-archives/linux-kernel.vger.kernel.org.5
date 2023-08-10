Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6F77782F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjHJMXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjHJMXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:23:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A221211F;
        Thu, 10 Aug 2023 05:23:04 -0700 (PDT)
X-UUID: a36cdb7e377811eeb20a276fd37b9834-20230810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kFmor9xy4eRAiqKQ0Poai4IrS+9BH5S6ye4cgCV6ZOA=;
        b=ZTmuep67T14SLC8of5yMn4+MCCw91yKRHYSt60FJJG2dVMPIgS9tgCGzKtFyNcXFbNCkpVomIyRREImmsqm4zZ46Hv9Tm6wpHaPB71+AE//VzP9BU2+UJEQgm3MH1fTPg0xBUbNy0plAVulYYBXSINVVP9CrAU2LqcVrksr/aNY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:018e4694-16c0-438d-8f00-8f363a262f59,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.31,REQID:018e4694-16c0-438d-8f00-8f363a262f59,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:0ad78a4,CLOUDID:377461ee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:230810202257NZQH41CX,BulkQuantity:0,Recheck:0,SF:17|19|48|29|28|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM
X-UUID: a36cdb7e377811eeb20a276fd37b9834-20230810
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1612961023; Thu, 10 Aug 2023 20:22:57 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 10 Aug 2023 20:22:56 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 10 Aug 2023 20:22:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyQjIicB4A/4aDwikodA2RjA27f8QP3KfZDjfelpvwxQX+PE4FaimTM9ZN9JbBD2SUdNznSDLpL5fr1XSp/I2cjRRhkN+lpXj8ASGHxEvh5gay/NTc8kUVc+Ah2NElML+bPfTqksy4u/Pfe72EeeLQ6+OpdnhO18+zLAfbOwSRJn6Tg/ZhVNgLCMVpNYw2tJBdfFJdavGweTIozLRhO8SX0/iLF6UmASQsyGum8is1N7RbNrCUzLmrbKf8dUXV0VCeRNSN3748EA05ggRn9Bv9zDmV0i2P70dAtgnZA15xWe5E0I9/+zse6+tuXO8Bu2rxHIi42nUncA0mXz8stDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFmor9xy4eRAiqKQ0Poai4IrS+9BH5S6ye4cgCV6ZOA=;
 b=Kfipfb95enG04ScyipeWESyQLhE6vk7q8lDyOxpQeGVfJKzyEScUt8TIBoKcJ8Zp6KIslOK6jjdQeJv8DEIJzfH0DfTcyXW+0Ib+d6tDx1K4eGs2FJe0/BK8ZO7avsCN5giGpLL2w9SFPbFYVQ4mOYoTXHbRWFVZj39HJLVcczYmDjH6ONrsuaV1hRI3r4PMzse2JUBfnpJI3IybVe2JooGUDATkyLxyEsLGEMMzG0Bp4PZ1ZgsGtIoxp+24StBvZpusSc8WG8PqQgsuPKpAmEtIxDc02+hVPfhOQJ92BQAm1ybnGsFWrz4PuqU5I1US8VX55yExx7L6x5upbuWRug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFmor9xy4eRAiqKQ0Poai4IrS+9BH5S6ye4cgCV6ZOA=;
 b=kUGpi92SnYY6o2QSioeSNXAOHkHv4ekBGLCl9Du2P5P5sMfHwXkkZk6STVdkXbACLEwub4Fz/PKuVuvPkQbHx7W6C5hf9reoeb8x89Wn9UGbqJUqK2pJyUyd8pNx283ohOov/cfLhshjQnDe7TNayTRxqbgJZo7Szzcqz/+Wcmo=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB5310.apcprd03.prod.outlook.com (2603:1096:405:5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 12:22:53 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::8c43:33cf:6057:fdfe]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::8c43:33cf:6057:fdfe%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 12:22:53 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHZlTFol72i25hY8ESS/o7MevPsra/gkh6AgANOQwA=
Date:   Thu, 10 Aug 2023 12:22:53 +0000
Message-ID: <b695962fa3c3baac08f8be5202e6a5697e7826a0.camel@mediatek.com>
References: <20230602090227.7264-1-yong.wu@mediatek.com>
         <20230602090227.7264-6-yong.wu@mediatek.com>
         <CAGXv+5EKwvn-axETPcuxTpxRkUGLroymeDYL+kr4QW8duAymmQ@mail.gmail.com>
In-Reply-To: <CAGXv+5EKwvn-axETPcuxTpxRkUGLroymeDYL+kr4QW8duAymmQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB5310:EE_
x-ms-office365-filtering-correlation-id: 88eac024-c2c7-4973-a82a-08db999c8563
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jwD7ZELMhGlG7AhNpXokd8k/Y1cvLQwlcq4dti23XazWAkfqirnbL9WxWrWCmVhq4gBPw1wa4D3aNfbKO3p1dCyxq0dW788Wb1IDKzh0ZY6wWFysVuDea5odyQM421f3bt/85ZCe6XNG0b+Ni07meTgjw4bp6A4qrjuOcpXJgPha9J3mDa0uoW3WIjrEOSKsfR3ntOUNu/CI4buPT1PnaQN2jRxyydeUqeazL+JLHSXl4qr5kh9SVvl+PyBP8bJQ/JYCuwlbbKHsoRhaIxvmfeiN0B8hxrSZu03oQrzmJ2vS7Hb9wDKft9saGijqP5hr5fvank9v89bg5vgzqebyY+DhYhfwjdScTi0L6CKBuxhIUuyb0axIuBMn3r0V2HOgIydHOtuy6yq38DrtiNOxVoORA6qbJxasP9q03KoGm+hWIW2P4neQwKUzfmAXIPsf27ol18Uj7AkG1BI2GC6LiU9dL7nZPWFtuaQupEChNBsX2Vz2nS22Y4zEbJGLuY1NL2JQ4taw5UuaYarnEcajFcRneibUppBgrlEYimkjlzMdmp4ziYbEaNTmI9yu+9/gX3u54p/PveeZGF8cTSuC3R1KYqusXW+JBEdoaYbceuLlXjt431XihtcOm8Lps1na1EbrhbUTuNn7GE9E8DRites5A03YqpWjMavMztd3Zn6T2z5UTAcnfmojDbpo/2sZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(39860400002)(366004)(346002)(1800799006)(186006)(451199021)(36756003)(8936002)(8676002)(38100700002)(122000001)(86362001)(41300700001)(38070700005)(85182001)(2616005)(2906002)(6506007)(53546011)(26005)(83380400001)(5660300002)(6916009)(4326008)(7416002)(76116006)(66556008)(66476007)(66446008)(6512007)(71200400001)(64756008)(66946007)(54906003)(6486002)(316002)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTVDbXQzeS9nNnp0SUVhTXdjVmtuT3g5cnVDVWNCZHg5YWpqTWovemdGdkFS?=
 =?utf-8?B?VnVLcWNwclVSNnZMSWtjcG1Fay9xRlFMbjBlckhHNDlrVGJ4K3l5VCtYY3kv?=
 =?utf-8?B?aTNtQUl0SDFLbDZuQ01yejZ4SWxWM1ZtN0VDbE80NmM0NkVpNkFJMEVyclJW?=
 =?utf-8?B?alpieTEwQmVYRDFocUhCdjBadU1SK2Y4WjlKSU1pTCtUV2xDejVYZTkyVUxx?=
 =?utf-8?B?THc3emdvVTJYRXh4ajlhNGxnRGN0VE9JMXAxVUVMQWxvdXNCSkpYTWpCSlZG?=
 =?utf-8?B?UExvaTBmdTcrSVZRTi9yVnYwbmJ1UFNGbmp6M2ZRZ2tFcXVSazFRTFl4NHl4?=
 =?utf-8?B?eDlnZU1aSE1oTUw2STQwbXJqVmYyR200VGQrdUxDejIvbWcycFRrWldDUzNX?=
 =?utf-8?B?aDhGMWRiUWJjbmdvalprSmc1VThTQ01jczQyaXkzeUNCZ0VTbkd4dzkwa1Bh?=
 =?utf-8?B?ZExTV3BscmlPYnQvc0o3MFJlalVXeENIeC9TZCt3c3A3a1RtY3k3RnI1SmM0?=
 =?utf-8?B?MnpjZDRvM0IyYWdPSEJndzd5NWxzb3ZRM2Y4ekx4MnR1OHZqa1hRR0t4UVlz?=
 =?utf-8?B?UVZOUjVUM0pZQjJWeGpsV1E2WUcrVmVKSmIxdFByTjlMSmdYbUhTOC9tOWxt?=
 =?utf-8?B?TVhVM0NjV0QveXlqMDJKMFkrbHNPL2ZUUHpJSTIzYVFyOTNpaU1uYW9YRzhM?=
 =?utf-8?B?QUxZUXUvVGQ3WWcvK0VRbmt6WldWK253UHdiNkw1bEJEVGJTdFRSRmtmZU1K?=
 =?utf-8?B?ZXVsQjg1L3BkVzhjRmo1bjBQT3B2LzNtUWxBQ2lTa1lQMnIxMFVtVEJpNWtK?=
 =?utf-8?B?eFAzdHNFNmgvaUZVbDRqdWdDVzZZUmhpc0MrSUhsSUNjTGt4b3h2RytZdUVr?=
 =?utf-8?B?aGxjbS9kc2JyNWY0OFYveHcxT3hLbmJhdE10dmFDUklwTWtpR2JNYnJwTUd6?=
 =?utf-8?B?Y0ZBdE00VDlmMnphWGw5RTlOTnRPdThaMWR5YnZuUVJ1bEl3eU1reW5OcG5L?=
 =?utf-8?B?OGVmTGNRVUpHTmV4UVlyWTNJUVdtb0J2ZCtVUUFleXlaajc5RWJ0VUdrelpy?=
 =?utf-8?B?QXdWcDY3bTdFRG96L3lvVE42MEE5VDlMRmpRS3JVajVRdHNSUGNzSXBMZUpU?=
 =?utf-8?B?ck1RWkxOSFBIaTFvbTFTY1d3d1ZiQ1dPRTBkN0NuT283c1AyZ2lXTGNSM1ZN?=
 =?utf-8?B?R3Q0SHphRnRTaU4wNmtmdWVGdExoWXRwM00wL1EvYTZ3WkwyVEMyYTBuMnpn?=
 =?utf-8?B?bEVRSERod2hvZCt5aDBWOFdrSi82QXVFa0dIekNQdU56elBuRWphRHd3UWZS?=
 =?utf-8?B?YWxQVnBhL0NCMjBIZVo5dkxnSXcwOUtub3lvVFJwVGVIZlg1clpGV05ERHVL?=
 =?utf-8?B?cmdlZ3VaUHMyS3g2elRHeThLdytoY1JzcTIySFRDYzVUZWI0VTVMK2Z3N2hh?=
 =?utf-8?B?RmVlTWN6NGRCQUZNdjZsYWhHK0h3ZWZzRnRjWVZXb3R5TW91b25MbExJR1NJ?=
 =?utf-8?B?dXVhaU5sMXd2K21WeG92Vjl3WHNWdi9tRVJ1U1htYjNadDBydlBKTmNWaG5n?=
 =?utf-8?B?bXJ0S3lSWEpoUVZQLzNEZHo4UXFtRzRCYW4yd0pJc0JVTUVYMEpKbkdMRU1J?=
 =?utf-8?B?ZEZhRkJyMGZFdmFzc01MU0YyakdtVndlS1BzOFVaNFZBK3M0QzlPTHdmSlF4?=
 =?utf-8?B?WUVoT1JEWFJhNkN5SnBaRHZzYXAxMFJyNGhrMUw4QTlSWjZJT0diRldnaUZu?=
 =?utf-8?B?RGcxNHA1MzJBeExhRE1qL1JtdmtxN1Q0dzZUUGNxT0E4NWovZzAvRFl6emVT?=
 =?utf-8?B?YXRkaVV1MG8vR0pXZC91ZjhSVGQxK3dIT0w0THh4b0IySjVmTDROcWV3eFFK?=
 =?utf-8?B?eERHNGJDZFo4WDJkZmlmK1BhaWRTaEE3Z3ZRTkJNSWlqeXVST0h4UHdJa1VW?=
 =?utf-8?B?Z0cxc2d5cGpkQWpjVldwbjB0SkV4WDlvN2RMaHFYT2VVYS9BRVBUUUhuRkYv?=
 =?utf-8?B?SG5WRFFkd01QMXVQSmJ3RU53SzJyaVIvSnU1bG9vOEJyZjJlbGlObFVncTNq?=
 =?utf-8?B?cE9ObU9FTEhtNHpXbjRDSzNta3FRbFhQczNNcWM3RjA3bndlQUwrU0Z2NGJm?=
 =?utf-8?Q?WQvnAoCRLiSxPdX/yoc55DdA9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6A22378D996AE4FA7821A74BE97482F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88eac024-c2c7-4973-a82a-08db999c8563
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 12:22:53.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzuDfIz5CuhvGin2BZgusWgnAgr0qA1l3TIa88E7aqupbOv4t6ypRe44KVxeFMkANpcVaum4Y/LquJ7ovZyPHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5310
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTA4IGF0IDE3OjUzICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gRnJpLCBKdW4gMiwgMjAyMyBhdCA1OjA04oCvUE0gWW9uZyBXdSA8
eW9uZy53dUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogIkNoZW5nY2kuWHUi
IDxjaGVuZ2NpLnh1QG1lZGlhdGVrLmNvbT4NCj4gPg0KPiA+IE1UODE4OCBoYXMgMyBJT01NVSwg
Y29udGFpbmluZyAyIE1NIElPTU1Vcywgb25lIGlzIGZvciB2ZG8sIHRoZQ0KPiBvdGhlcg0KPiA+
IGlzIGZvciB2cHAuIGFuZCAxIElORlJBIElPTU1VLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Q2hlbmdjaS5YdSA8Y2hlbmdjaS54dUBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
WW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJv
cmEuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgNDkNCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA0OSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBpbmRleCA5Yzg5
Y2Y4OTRhNGQuLjVjNjZhZjBjNDVhOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC0x
NzAsNiArMTcwLDcgQEAgZW51bSBtdGtfaW9tbXVfcGxhdCB7DQo+ID4gICAgICAgICBNNFVfTVQ4
MTczLA0KPiA+ICAgICAgICAgTTRVX01UODE4MywNCj4gPiAgICAgICAgIE00VV9NVDgxODYsDQo+
ID4gKyAgICAgICBNNFVfTVQ4MTg4LA0KPiA+ICAgICAgICAgTTRVX01UODE5MiwNCj4gPiAgICAg
ICAgIE00VV9NVDgxOTUsDQo+ID4gICAgICAgICBNNFVfTVQ4MzY1LA0KPiA+IEBAIC0xNTkzLDYg
KzE1OTQsNTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhDQo+IG10
ODE4Nl9kYXRhX21tID0gew0KPiA+ICAgICAgICAgLmlvdmFfcmVnaW9uX2xhcmJfbXNrID0gbXQ4
MTg2X2xhcmJfcmVnaW9uX21zaywNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTg4X2RhdGFfaW5mcmEgPSB7DQo+ID4gKyAgICAg
ICAubTR1X3BsYXQgICAgICAgICA9IE00VV9NVDgxODgsDQo+ID4gKyAgICAgICAuZmxhZ3MgICAg
ICAgICAgICA9IFdSX1RIUk9UX0VOIHwgRENNX0RJU0FCTEUgfA0KPiBTVERfQVhJX01PREUgfCBQ
TV9DTEtfQU8gfA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBNVEtfSU9NTVVfVFlQ
RV9JTkZSQSB8DQo+IElGQV9JT01NVV9QQ0lFX1NVUFBPUlQgfA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICBQR1RBQkxFX1BBXzM1X0VOIHwNCj4gQ0ZHX0lGQV9NQVNURVJfSU5fQVRG
LA0KPiANCj4gRldJVywgQ0ZHX0lGQV9NQVNURVJfSU5fQVRGIHNob3VsZCBub3QgYmUgdGllZCB0
byB0aGUgY29tcGF0aWJsZQ0KPiBzdHJpbmcsDQo+IGJ1dCBzZXQgdmlhIGEgRFQgcHJvcGVydHku
IFRoZSBJT01NVSBjb250cm9scyBhcmUgc2VjdXJlZCBieQ0KPiBmaXJtd2FyZS4NCj4gSXQgaXMg
bm90IGEgcHJvcGVydHkgaW50cmluc2ljYWxseSB0aWVkIHRvIHRoZSBoYXJkd2FyZS4NCg0KVGhl
IGZsYWcgQ0ZHX0lGQV9NQVNURVJfSU5fQVRGIG1lYW5zIHRoZSByZWdpc3RlcnMgd2hpY2ggZW5h
YmxlL2Rpc2FibGUNCmlvbW11IGFyZSBpbiB0aGUgc2VjdXJlIHdvcmxkLiBJZiB0aGUgbWFzdGVy
IGxpa2UgcGNpZSB3YW50IHRvIGVuYWJsZQ0KaW9tbXUsIHdlIGhhdmUgdG8gZW50ZXIgc2VjdXJl
IHdvcmxkIHRvIGNvbmZpZ3VyZSBpdC4gSXQgc2hvdWxkIGJlIEhXDQppbnRyaW5zaWNhbCwgcmln
aHQ/DQoNCj4gDQo+IElmIG9uIHNvbWUgb3RoZXIgcHJvamVjdCB0aGVyZSBpcyBubyBzdWNoIHNl
Y3VyaXR5IHJlcXVpcmVtZW50IGFuZA0KPiB0aGUNCj4gSU9NTVUgaXMgb3BlbmVkIHVwIHRvIG5v
bi1zZWN1cmUgd29ybGQsIGFuZCBBVEYgbm90IGV2ZW4gaGF2aW5nDQo+IHN1cHBvcnQNCj4gZm9y
IHRoZSBTTUMgY2FsbCwgdGhpcyBiZWNvbWVzIHVudXNhYmxlIGFuZCBoYXJkIHRvIHJlY3RpZnkg
d2l0aG91dA0KPiBpbnRyb2R1Y2luZyBhIG5ldyBjb21wYXRpYmxlIHN0cmluZy4NCj4gDQo+IENo
ZW5ZdQ0KPiANCj4gPiArICAgICAgIC5pbnZfc2VsX3JlZyAgICAgID0gUkVHX01NVV9JTlZfU0VM
X0dFTjIsDQo+ID4gKyAgICAgICAuYmFua3NfbnVtICAgICAgICA9IDEsDQo+ID4gKyAgICAgICAu
YmFua3NfZW5hYmxlICAgICA9IHt0cnVlfSwNCj4gPiArICAgICAgIC5pb3ZhX3JlZ2lvbiAgICAg
ID0gc2luZ2xlX2RvbWFpbiwNCj4gPiArICAgICAgIC5pb3ZhX3JlZ2lvbl9uciAgID0gQVJSQVlf
U0laRShzaW5nbGVfZG9tYWluKSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODhfZGF0YV92ZG8gPSB7DQo+ID4gKyAgICAg
ICAubTR1X3BsYXQgICAgICAgPSBNNFVfTVQ4MTg4LA0KPiA+ICsgICAgICAgLmZsYWdzICAgICAg
ICAgID0gSEFTX0JDTEsgfCBIQVNfU1VCX0NPTU1fM0JJVFMgfA0KPiBPVVRfT1JERVJfV1JfRU4g
fA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgV1JfVEhST1RfRU4gfCBJT1ZBXzM0X0VO
IHwgU0hBUkVfUEdUQUJMRQ0KPiB8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICBQR1RB
QkxFX1BBXzM1X0VOIHwgTVRLX0lPTU1VX1RZUEVfTU0sDQo+ID4gKyAgICAgICAuaHdfbGlzdCAg
ICAgICAgPSAmbTR1bGlzdCwNCj4gPiArICAgICAgIC5pbnZfc2VsX3JlZyAgICA9IFJFR19NTVVf
SU5WX1NFTF9HRU4yLA0KPiA+ICsgICAgICAgLmJhbmtzX251bSAgICAgID0gMSwNCj4gPiArICAg
ICAgIC5iYW5rc19lbmFibGUgICA9IHt0cnVlfSwNCj4gPiArICAgICAgIC5pb3ZhX3JlZ2lvbiAg
ICA9IG10ODE5Ml9tdWx0aV9kb20sDQo+ID4gKyAgICAgICAuaW92YV9yZWdpb25fbnIgPSBBUlJB
WV9TSVpFKG10ODE5Ml9tdWx0aV9kb20pLA0KPiA+ICsgICAgICAgLmxhcmJpZF9yZW1hcCAgID0g
e3syfSwgezB9LCB7MjF9LCB7MH0sIHsxOX0sIHs5LCAxMCwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAxMSAvKiAxMWEgKi8sIDI1IC8qIDExYyAqL30sDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgezEzLCAwLCAyOSAvKiAxNmIgKi8sIDMwIC8qIDE3YiAqLywgMH0sDQo+
IHs1fX0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21t
dV9wbGF0X2RhdGEgbXQ4MTg4X2RhdGFfdnBwID0gew0KPiA+ICsgICAgICAgLm00dV9wbGF0ICAg
ICAgID0gTTRVX01UODE4OCwNCj4gPiArICAgICAgIC5mbGFncyAgICAgICAgICA9IEhBU19CQ0xL
IHwgSEFTX1NVQl9DT01NXzNCSVRTIHwNCj4gT1VUX09SREVSX1dSX0VOIHwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgIFdSX1RIUk9UX0VOIHwgSU9WQV8zNF9FTiB8IFNIQVJFX1BHVEFC
TEUNCj4gfA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgUEdUQUJMRV9QQV8zNV9FTiB8
IE1US19JT01NVV9UWVBFX01NLA0KPiA+ICsgICAgICAgLmh3X2xpc3QgICAgICAgID0gJm00dWxp
c3QsDQo+ID4gKyAgICAgICAuaW52X3NlbF9yZWcgICAgPSBSRUdfTU1VX0lOVl9TRUxfR0VOMiwN
Cj4gPiArICAgICAgIC5iYW5rc19udW0gICAgICA9IDEsDQo+ID4gKyAgICAgICAuYmFua3NfZW5h
YmxlICAgPSB7dHJ1ZX0sDQo+ID4gKyAgICAgICAuaW92YV9yZWdpb24gICAgPSBtdDgxOTJfbXVs
dGlfZG9tLA0KPiA+ICsgICAgICAgLmlvdmFfcmVnaW9uX25yID0gQVJSQVlfU0laRShtdDgxOTJf
bXVsdGlfZG9tKSwNCj4gPiArICAgICAgIC5sYXJiaWRfcmVtYXAgICA9IHt7MX0sIHszfSwgezIz
fSwgezd9LA0KPiB7TVRLX0lOVkFMSURfTEFSQklEfSwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICB7MTIsIDE1LCAyNCAvKiAxMWIgKi99LCB7MTQsDQo+IE1US19JTlZBTElEX0xBUkJJ
RCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAxNiAvKiAxNmEgKi8sIDE3IC8qIDE3
YSAqLywNCj4gTVRLX0lOVkFMSURfTEFSQklELA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgIDI3LCAyOCAvKiBjY3UwICovLCBNVEtfSU5WQUxJRF9MQVJCSUR9LA0KPiB7NCwgNn19LA0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHVuc2lnbmVkIGludA0KPiBtdDgxOTJf
bGFyYl9yZWdpb25fbXNrW01UODE5Ml9NVUxUSV9SRUdJT05fTlJfTUFYXVtNVEtfTEFSQl9OUl9N
QVhdID0NCj4gew0KPiA+ICAgICAgICAgWzBdID0ge34wLCB+MH0sICAgICAgICAgICAgICAgICAg
ICAgICAgIC8qIFJlZ2lvbjA6IGxhcmIwLzENCj4gKi8NCj4gPiAgICAgICAgIFsxXSA9IHswLCAw
LCAwLCAwLCB+MCwgfjAsIDAsIH4wfSwgICAgICAvKiBSZWdpb24xOg0KPiBsYXJiNC81LzcgKi8N
Cj4gPiBAQCAtMTcwMSw2ICsxNzQ3LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQNCj4gbXRrX2lvbW11X29mX2lkc1tdID0gew0KPiA+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxNzMtbTR1IiwgLmRhdGEgPQ0KPiAmbXQ4MTczX2RhdGF9LA0KPiA+ICAg
ICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtbTR1IiwgLmRhdGEgPQ0KPiAm
bXQ4MTgzX2RhdGF9LA0KPiA+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
ODYtaW9tbXUtbW0iLCAgICAuZGF0YSA9DQo+ICZtdDgxODZfZGF0YV9tbX0sIC8qIG1tOiBtNHUg
Ki8NCj4gPiArICAgICAgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LWlvbW11LWlu
ZnJhIiwgLmRhdGEgPQ0KPiAmbXQ4MTg4X2RhdGFfaW5mcmF9LA0KPiA+ICsgICAgICAgeyAuY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtaW9tbXUtdmRvIiwgICAuZGF0YSA9DQo+ICZtdDgx
ODhfZGF0YV92ZG99LA0KPiA+ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
ODgtaW9tbXUtdnBwIiwgICAuZGF0YSA9DQo+ICZtdDgxODhfZGF0YV92cHB9LA0KPiA+ICAgICAg
ICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItbTR1IiwgLmRhdGEgPQ0KPiAmbXQ4
MTkyX2RhdGF9LA0KPiA+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUt
aW9tbXUtaW5mcmEiLCAuZGF0YSA9DQo+ICZtdDgxOTVfZGF0YV9pbmZyYX0sDQo+ID4gICAgICAg
ICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1pb21tdS12ZG8iLCAgIC5kYXRhID0N
Cj4gJm10ODE5NV9kYXRhX3Zkb30sDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiA+DQo+IA0K
