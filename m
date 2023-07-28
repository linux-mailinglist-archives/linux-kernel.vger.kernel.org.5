Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CE1766A31
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjG1KXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjG1KXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:23:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE898E47;
        Fri, 28 Jul 2023 03:23:13 -0700 (PDT)
X-UUID: bdddc8122d3011ee9cb5633481061a41-20230728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=LvLikBTXVHokGwJ9qde6MhuEs27HfC2Y6VejdYP6Frs=;
        b=BMiQihpbQCekCmNG4FbO7PyrJPD5wRye1qkSwtFFR0AbnPJhlFHCUF7rtyp+FOZqLiKE4ZaZGu9NOxqNRBtroMR1Xg6Y4jOgkDpbkaq4HnsaBZDKk8jSX7IpXn5Y46ojGYL7AO8QCN4Fg4p7u9GMPyuXKQGPZtNeIwiy4eQyE7c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:5ddac066-d715-4d5d-af7b-e5a9c1d08357,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:865a8f42-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: bdddc8122d3011ee9cb5633481061a41-20230728
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 95158924; Fri, 28 Jul 2023 18:23:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 28 Jul 2023 18:23:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 28 Jul 2023 18:23:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPMva5aJH2wkZvkzyC+2nWDerWaHO6ipyqwgtLiE/MWGtSJMQ0bfQpk/Its/qJuQdHVbOLv2v9Oek2Xtu5I+LxkQhMuU+vbNP4M9IvoUOqCGYEXdNwFHGRPY9DsV+hoKCosU7j0lI543QIWMgUyX828bx8SkY3/JS+ctYJZ8oTnbdibpUTlH4QfPkkYImb1/vt9THn6pleoPElTpYaT5e6wI+/BvFNawf6ug7roL7BbnNLkfKD8iTcKw6EBLOaGOaMKpqYl1eJ6CxkL+q6TvGNgGZ/JHuFvkVd78rkaQviM0UtXYugJIkUyp1/POjPuVIJS0/PA2VCntuM/rixAt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvLikBTXVHokGwJ9qde6MhuEs27HfC2Y6VejdYP6Frs=;
 b=JIohElZ9AcEvYnIyFGF8lwfiUcxlSnn1kWP12N25FPwv/vH0Eck+trpf82gsUjyurse631QMSHnwW1WZEx0QcUda2uTm/VaxSo+eWEX/2iSs17csMeCO+o/B1LkmGZhUBB2d8Nm+7y9jmeX4rzTd5w72Y+76+O01rfjO11MMrEwRA01sa2zeby2fWmR9vW/gjvSMWXwWDIJ8SCJ4Md1YBDvc95+F/m9beZscVqy+fvTvwbMRsCD6OO2AJFVJ6iD5H4Z/PNu0Njt559kAEZTczViiqfBwXlqxDbC6wzljtylp5Sy5U66mdLYQ7SpBGL3iSwaQr1XcfiEh41jXQUC3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvLikBTXVHokGwJ9qde6MhuEs27HfC2Y6VejdYP6Frs=;
 b=uVPosmpweqhjz6JNyEopnjHwExTDtzruEgo4+GYp3I9VMuacHyNJQzUtN0AeWYHpWrniHUVFY7hYXAD3+kjvptrlmTvJKVwSeWTyNtHzMFJONyx6HlDUhw7hVT9WI9b+o7i1rduFFYlARk8dZEYpsAvu4oMfEuG0MCYd8osbFZc=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by SG2PR03MB6503.apcprd03.prod.outlook.com (2603:1096:4:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Fri, 28 Jul
 2023 10:16:22 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 10:16:22 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chenxiangrui@huaqin.corp-partner.google.com" 
        <chenxiangrui@huaqin.corp-partner.google.com>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Thread-Topic: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Thread-Index: AQHZwTM9qZx2VdeqykKSfnhu9XP0Bq/O8P2AgAAFtwA=
Date:   Fri, 28 Jul 2023 10:16:21 +0000
Message-ID: <ebfc016f57ec50ea8026efdce575813a75676b5c.camel@mediatek.com>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
         <20230728090819.18038-6-maso.huang@mediatek.com>
         <8e207baf-4a85-71f1-8ea3-08eab438b7cd@collabora.com>
In-Reply-To: <8e207baf-4a85-71f1-8ea3-08eab438b7cd@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|SG2PR03MB6503:EE_
x-ms-office365-filtering-correlation-id: 23e70b8b-7ea0-40fd-1cd0-08db8f53b11e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YtZab8E/To5zBuP+GhIUOaDbVsS2YiPNdHkput4Cy3nzyVFQNqEva1y4DjRfy5PJwHW6OGMai5iCkjC9wwZ3mEEld2d3dj//ixaVQxJOn3T1V2Zdtb2e/FAUx5CkXCDMaQ8k0pBJTa92qnL3bZ0tRQUVWcXQRLFBt5mhBhbsvBLbbhf+03F4VjS9U+jwZhysf5Bhst9uazBFP9t/4Cl3C7Njjt0HJnvP8IuGA9tVKKolP0UU9s3gvu0LFDYHmvTCOhzhguJfytbON3My7kMXCDYDD/3s/rM3/aXfgn9YjJofeQaVVComb6LWMiNaQVqvvHQDGFimDRCLBYKLZyqlt14l7qxITJ7N5KoAzik9XDbcjCCXA0FqqRcVCYJHEvhqmq5A0eZJON3L6p2uNHZ22w1/Z0Mpssr0A3jl9txGBJjzfxBq747U7a6ioVwJTerw+vDtuiTv2uni/aUGM0B1KPSff28lty/gtmpQkpLUp53W1KFu4HfFLoW0XKaOe/jCTK8Ngs+eGX56g80hzknjBM7Yi46Ig9TPagrXLAKzJf6Ra7U53rHZATSyGs4SxAbgfClQIYuCFl8gaTI2sL3GmXd3jKpirTw0ejl1sRiruLkJKKPUU7k6PVHKinXvQg5Ve8xzfBqnaSN7lMDGz5PLclTQLIoBmAEe59r+qYXaw+2c8e4IIBx5Pv1Ds1CuowxOaaMyTwYVo/+An9tr79vK3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(2906002)(36756003)(85182001)(86362001)(38070700005)(7416002)(186003)(6506007)(26005)(966005)(6512007)(38100700002)(921005)(478600001)(110136005)(71200400001)(122000001)(8676002)(76116006)(66446008)(66556008)(91956017)(8936002)(316002)(66476007)(6486002)(64756008)(5660300002)(2616005)(66946007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXhyWmRSSTZ4R2J6Ui9kTmhRQytjU3RDdXZpRHhNRTgvMXZUMHhJVlNuZGZs?=
 =?utf-8?B?ZHJjOUx4aG15c3JNV3dCWVhWQjlYNGlLRHM5ZmFJR3B2aHM1cHphNGdZbXRH?=
 =?utf-8?B?VnJLVjhxT2tQbFhJOG9VOEI5VmdoVnlPWWRxOGlXdWwwRE5Jb3pkT1dIc09y?=
 =?utf-8?B?Ujh1OU5ZQitRSFZuNUV6cXFjOFRMS2U0cFpKcm9hejV2YVpwMER0NUFVSXNG?=
 =?utf-8?B?N0tvd3FwQ2MyNXBFdGpqQ0RtUGlPTFVzaWdQN0Y3NHdSZGsyZklhSHFmbHhp?=
 =?utf-8?B?Q1lyWWJLYXNjYTh4aW90V05jR2lRajR0TzU1dEZTYnUyWmthQUdzeXp1VHA1?=
 =?utf-8?B?ZGEwLzZrNkRHb25ObmVqOUtvVEhUSWJyaTdjM1k3NWNybkxnNjJaVngyRGFK?=
 =?utf-8?B?MlF0Mk1OZW9WamEvd2JqeDI5dmZQdGhsbEhKMDRTTmlNQWxZenZRWU8vWUEr?=
 =?utf-8?B?enZPTzFXYzhxam05cC93Vy9xTXZ3NUFtTXhFTHVFdzd1Q2hINVhTV1JYU2Ry?=
 =?utf-8?B?L3NOUFMzMkFyMFM4bXJtckdSZ3JucXBQbUNnMXN0SlFBK2lmTUJDNlhjeXpi?=
 =?utf-8?B?WVI3L2w3dUwyVUNMZXBBTUFrQVB5RHBQRlljdVJ6bkJwVzVJTTNBc1R3Z0RV?=
 =?utf-8?B?SGJPRE1Sd1hqaWxLekhSTDdFOUdmUUFudHFIUmdrNEFjQStMbHFoL0JMY2hn?=
 =?utf-8?B?azczUyszWnZVUnh5bSt1Vnd4cXVVUTl5N1Y2ME5MNjdLSXVZODYyUXl2cmha?=
 =?utf-8?B?Wm56cTJ3cndCZDlqYmExWVJSU1N0R0MzNlB5Q2RSUHFEVFU5Tkk1V2NGWWsw?=
 =?utf-8?B?dFo1THdVREJQSjZRcm8xdFpKSHJTejJQcUQ5eW0xN3hnTEFjdS9PK2lCdjMy?=
 =?utf-8?B?QWlZdzlrUVJQMHhMbU53dVdzUzFDbnduUDVBUXp3SUhoTXpGRG8wU0Nlcml4?=
 =?utf-8?B?cnNqYm5QQjBoTUxTVlpDc1BDNnVYZnVZQnhNWlFVbGtTdjE5aVBHbFlUUlJZ?=
 =?utf-8?B?MzByNkVRcmtVZ2JGSjVQai92Sm9uYmRybS9uUGppVnVxVE54VnhJZDhvRHcy?=
 =?utf-8?B?cmV5aktIU1NDb2VVUHpmVEhMRHFxWkgrbXUxbWJSMFZsQWg0Mll5Wm5ndWJy?=
 =?utf-8?B?ZEptMm91dnFIR0RUSFNtV2JrSjIvTnhHQ3MzdDhhRXZNY2Z4M0tac3dibHVL?=
 =?utf-8?B?eHhhRHNabE5xTkxiaGd0TXZFYjhvZlByUkE4cnVscFRGVVk0aXhTbTBxaTFU?=
 =?utf-8?B?WnBDek1GamFZdm9CRVgzbld5Y1hTSXhKNlJWZjl4L24zaE1SRVlCN3U0a2tu?=
 =?utf-8?B?ZWR2N1duUG9CcFFEc2p4WGMybFZNTFVlaHVEb0hxNGt6dG5ycjIxUzJ5djBQ?=
 =?utf-8?B?cnpIdnVUVEZ3aVU3NW1Fd0toa3JidENWKzdmUVBWdG8vQUJIcXpzWCtxaVBR?=
 =?utf-8?B?NDBUUjAzY1JGZlpBMUgybjZtS3ExMEJIRTdaL1FNbzkrMTcySVIxei9BNGRj?=
 =?utf-8?B?em5reVdjS1V1cXZwQnFpNG4rNGZKazJjWWhBb3dxSmZYWkZhUzR0ZmowTE95?=
 =?utf-8?B?NllwRW1OZmZSMWQ2NG1yTXRteE9WTWd6aXNmeTJHYXU2QlBKMWx1VzlDRERE?=
 =?utf-8?B?Q2RqRkNiL3d5c0ZHN2V1bDA0d0lvUWNXU1RQZSthTEZsYmhXQWF2LytJeDRa?=
 =?utf-8?B?VGRMZ09GU0t5ZGNvTU5OM1FYNVBaVWFuRUNFMVRwUzMwdFdpamtDZ0FUelZG?=
 =?utf-8?B?VjVtcWE4azJiTWRFZkR0Ymora3VmbmdHWWZLMHNMUHRhOGdwNTFQaFNhSkhs?=
 =?utf-8?B?ZUhVSmJjTDVoRXdEblJjNXZSck1ZN2xvVlYvYmkyRm9pS0tyOHJ5NEY2Tk54?=
 =?utf-8?B?V3BGblRLSXhEYWMyWkxpNm1QV2ZXZjlLeTdjSUZPL3JyTzJaN0d4M2hoUFEw?=
 =?utf-8?B?dVAvbm55QlNROUZZQ09xSHRpSWdINXhYM2FKK1ZlWGE3Q1BhbzZ3cUFVK2ZF?=
 =?utf-8?B?KzdXRjcyU2dUanpTM1B0K2lGK0VzNGxRTlVmc1JtcWgwRGJRRlc5TnViU1VM?=
 =?utf-8?B?THZvN3dRWS9NbVBTbmVIaHM5RmpWQVdkNGFNVFdyTm9oNSsyWmJKaU4zNy9D?=
 =?utf-8?B?ekNCeGVqYVpiazJHaEZTcnJSVkdTTW9xVUxSS3RlYWRRVFdBY0lkQW5RSGw0?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EEBC1566621FC49A59C2AF6672B9FD6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e70b8b-7ea0-40fd-1cd0-08db8f53b11e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 10:16:21.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJ9OrCN+IFIsTnnu71MhlG2M57hpkD86toxKuaGcXbnmdLc4FdOlVXQ2vKHKh3/sD0Ny8saGu2nppiXNHlRRzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6503
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTI4IGF0IDExOjU1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjgvMDcvMjMgMTE6MDgsIE1hc28gSHVhbmcgaGEgc2NyaXR0bzoN
Cj4gPiBBZGQgZG9jdW1lbnQgZm9yIG10Nzk4NiBib2FyZCB3aXRoIHdtODk2MC4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBNYXNvIEh1YW5nIDxtYXNvLmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIC4uLi9zb3VuZC9tZWRpYXRlayxtdDc5ODYtd204OTYwLnlhbWwgICAgICAg
ICB8IDUzDQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUz
IGluc2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDc5ODYtd204OTYwLnlhbWwN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OTg2LQ0KPiA+IHdtODk2MC55YW1sDQo+ID4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OTg2LQ0KPiA+
IHdtODk2MC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAw
MDAwMDAuLjc2Mzk0ZjdlNTUwMg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OTg2LQ0KPiA+IHdt
ODk2MC55YW1sDQo+ID4gQEAgLTAsMCArMSw1MyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+
ID4gKy0tLQ0KPiA+ICskaWQ6IA0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb3VuZC9tZWRpYXRlayxtdDc5ODYtd204OTYwLnlh
bWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFsdTRaNnBKZVJpTDctOGw0VDNwdHFVQ001NEZuSFRC
aXloNUtXQk5xU2psNm1PT0k3V216SHBXRWQtWlNaLTJOSjRDczlQUGFBRl83NXl3bzJTS1cxNk1Q
UFJhUk90MCTCoA0KPiA+ICANCj4gPiArJHNjaGVtYTogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9f
O0l3ISFDVFJOS0E5d01nMEFSYnchbHU0WjZwSmVSaUw3LThsNFQzcHRxVUNNNTRGbkhUQml5aDVL
V0JOcVNqbDZtT09JN1dtekhwV0VkLVpTWi0yTko0Q3M5UFBhQUZfNzV5d28yU0tXMTZNUHR0WklM
QW8kwqANCj4gPiAgDQo+ID4gKw0KPiA+ICt0aXRsZTogTWVkaWFUZWsgTVQ3OTg2IHNvdW5kIGNh
cmQgd2l0aCBXTTg5NjAgY29kZWMNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0g
TWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0
aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBjb25zdDogbWVkaWF0ZWssbXQ3OTg2
LXdtODk2MC1tYWNoaW5lDQo+IA0KPiBtZWRpYXRlayxtdDc5ODYtd204OTYwLXNvdW5kIGxvb2tz
IGJldHRlci4NCj4gDQo+IEFmdGVyIHdoaWNoLA0KPiANCj4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJv
cmEuY29tPg0KPiANCj4gDQoNCkhpIEFuZ2VsbywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4N
CkknbGwgY2hhbmdlIHRoZSBjb21wYXRpYmxlIHRvICJtZWRpYXRlayxtdDc5ODYtd204OTYwLXNv
dW5kIiBpbiB2NA0KcGF0Y2guDQoNCkJlc3QgcmVnYXJkcywNCk1hc28NCg0K
