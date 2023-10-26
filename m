Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5A7D7AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjJZC1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZC1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:27:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1C8D8;
        Wed, 25 Oct 2023 19:27:04 -0700 (PDT)
X-UUID: 233db7b473a711ee8051498923ad61e6-20231026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=p3OpuwC0ubP4QM3tJd8tsmfvvgW+Km0JazGOriHYyP0=;
        b=ZQbQY6UAhkOvoi5NrJb0fDBhPR1M1woyHcl8qM9lBuTvZrjSUPx3+9/S52/zsVaCbdXOK6e204DY1giacFxhQfQKBk83Gk8xAEv8nyvSOGedCzJTQMQscZMhFF5ytc5HKDljIZkLuCsPe3YrcU6d64XcBXqSQCsHw2aEOl86JuU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ab1c332f-990c-4634-bcbe-18d5dbbc6158,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:af5e54d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 233db7b473a711ee8051498923ad61e6-20231026
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 582073194; Thu, 26 Oct 2023 10:26:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Oct 2023 10:26:57 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Oct 2023 10:26:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSBWbR/g88gxU94myBXBED3CVPhchCYC2zAdQFTei2PQ/EoW2gZA/Nx1rsnM//osFlUX+hQ4k7y4mAXAoQOiJfGXbCWiuftQrRZ8Rb6vcpDXOmpR4l6PCoAX0fBvfBjpNLzWjpEpeTgP3a4QBm5MuwxO6wHTd6AozvkLYsybZOY4MtPZJn7x0kYhTJ/pkr3yKRFsF/urrOYQR6kiijwaa5b33cRXFN5RuSiPunbqgUbcv41U3emZeH9UsYXlOzCYF5u0nPwPRg+1o0BQqN1JTNZ+TEyDpIuf9hRcZOB9Z9XgbRRZzVEXh/xBu6Q7mxqwIfmwMXYMZyxu7ytY8iMSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3OpuwC0ubP4QM3tJd8tsmfvvgW+Km0JazGOriHYyP0=;
 b=cDO1EcoDp+O2ZSzIEpOqqpr4/GysBFg2yZ17ChFeVdcZmeAQpC8ibrlWrdEHvhWAo+2Uvgs+shhfhfj4gsehLWt3YkzJEgVXXR+9aesifpA2IQVTKYUvZUpQ681xhoaiD8oME61ggv8g+tjkeipJ/CvLZkB2B/Ok/E30THJWTuDSf41IzeRk5+XDXBj7L5xxl5v9HFXhL/iAIJ6UuWv2S9v4P2DlsAcasH3yHpgFcy0jmVJmSJSzkEOHH1ESN6T+95O6dEUFxTCCdartYCV3ALh+DDa4tiSkF+8uDN0EVryUVR8KC2dp9vp2WzVWQjsYHfTaVbkSIAwdmw1igMwR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3OpuwC0ubP4QM3tJd8tsmfvvgW+Km0JazGOriHYyP0=;
 b=jSIxy82yNmLKdecgSl0b7CFSP9mRIjsTesaOih2siRIyyD17XigSsTYVQv2f7fg77HiXgcmheERIHIOkxtLZFaprLoPumRCcxH+f/nkqNecXIu+y/YYBnTK1wDlpYHFLpvkCrNdC5UBYHg9EjNK8VRo2O826U1E9ozILH1diKPg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR0302MB5411.apcprd03.prod.outlook.com (2603:1096:820:4f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 02:26:54 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3%4]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 02:26:54 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 10/11] drm/mediatek: Add cmdq_insert_backup_cookie
 before secure pkt finalize
Thread-Topic: [PATCH v2 10/11] drm/mediatek: Add cmdq_insert_backup_cookie
 before secure pkt finalize
Thread-Index: AQHaBWv+PhA/HnZqn02pJP46ox1LtLBbXOuA
Date:   Thu, 26 Oct 2023 02:26:54 +0000
Message-ID: <7e856cd887d2f0319810f9b3ec50f9f5a52a8147.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-11-jason-jh.lin@mediatek.com>
In-Reply-To: <20231023044549.21412-11-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR0302MB5411:EE_
x-ms-office365-filtering-correlation-id: 3922ad50-2121-45fe-7f79-08dbd5cb054d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HwZ2O+xmACheORIyCCehwmrsULrY/j7eODrMEftS7nm85eBgvNERcmprnEcjL+E3CaEjkewzgpfUwOG3mrw3X++yyYLuil8sG1NId0SlJ9VV1W0ROxdHdi9E3N5L4g0TFopcXEJOQCMeoE1spxxvfhQaoA3Wy5l5vqW1AOW7kY2DBxmCU3QdLp25Ric3EVUt9e77ELW+aJOcpvuD+o2AgqY6a2eSkgMiagHBOJJjH+dhw7RPj/GA8CZgw3kOSjNMFlQ+Z000RmLcgttj9QpZVPg+xbaigurztAT/itzMgC2BZPWwIGQuEsPAJSILGwJmcY812io+/BZKzkv0iv9e2i8HQh6KE4phaNXoOlTPKtjBWKI9Q9Px6Fxnh8TgGelWxoMVvh2x/9o50WWx4xWrnE+ogjUPjI4fW3gu8K50ZTrV/QBt8iwEOmym4dol/Z5X4uUYecyIQnYdHOjMj+n/4RwT5+GA+jKhcyG/lVmTuG6JzihwhhSeLYIyLjxMAvFPynfHjAxOI91n8lliyFkgPif+yrY/bvXTVCw4Ig0Ab1UhvUSesWXMImF6XVnZZ6d3o+cfthXUGuxrvD9yaNemoYRcbTinjxl1uWvrM6zs91zYDicSBEiyWVHhcT/DLNBW6mSwsxf/CaXHn2IH5w1lHpyfZuiGA68tIslcUsFFQUM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(110136005)(26005)(76116006)(478600001)(316002)(6512007)(86362001)(6506007)(66946007)(66556008)(66446008)(38100700002)(66476007)(64756008)(54906003)(36756003)(85182001)(38070700009)(2616005)(7416002)(6486002)(4001150100001)(2906002)(122000001)(71200400001)(83380400001)(4326008)(8676002)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y09ZcTU1Zmp2RXBSOGprR1JNbHBKVjQyVE85S21WRlN5RjJuaDk1ZVhRTWdy?=
 =?utf-8?B?Mm0zNi9sQWdybldOZkl0RzhlNDJTY0l5MUdkKzBUVFdZbks5Y0hnblpkQ3dJ?=
 =?utf-8?B?eEpzOEtlK3gyN2dNcjc1U1U0Q1NKVGJya1dYamZKYU9WUTV6SWYrb3hBQUpR?=
 =?utf-8?B?b3FkT3hqbS8wWUtzSFl4QzFjMDJNUTVkRXlmc3YvYUx4cEdUc041ajJJWGVX?=
 =?utf-8?B?V0RmdHlkM0hnSTJ6WTZ5N3ZHMm1lU0lJN3RvRU5neWlTQ1Fha2N0blo4T3dT?=
 =?utf-8?B?ampwdmE4aVdTa2hHeDkxUWtFSHNXc0Z3MUZXUFE0NFpaczByY3llVjZIZEk4?=
 =?utf-8?B?TDJUR1NpRStIODUyQ25ZVnZrdDdKL0hmMG9TbXhDR09ySFoySXF0NWxnaitF?=
 =?utf-8?B?a0RkY3BQVjRoUVVtR2JjMElZeE41SGZxbzQ1TlhqN3lBMG5zTUNKZHFaQnQv?=
 =?utf-8?B?bU1EU1BPUE9mWGFzREMzbk5FMkpXWGlyVkgwYnNOa2NncERMajMvN2dsbFVD?=
 =?utf-8?B?UVJLRS8wWFg5MzB1WktyUjNWYnhNNGltWk5wS2dBSFFvWVhEMngwQVFoUUZ3?=
 =?utf-8?B?anJuaEp5cHFzbitiRUhNM244QUxrbXFnWElkK0xWRTlsMUt1aWg5d0RLTEhF?=
 =?utf-8?B?UzhKKy8vZFB2aUFEWkNhTXBYNG9ySWZVc2pQcXNTMTlrS3dWNXRNM0k4WnVV?=
 =?utf-8?B?eXZCMEh4dDdsY2xUcjRaQWZiTEJYNERsc3YraTZrKzc2UXRvRGZyajFvTk1V?=
 =?utf-8?B?dFgxZUN2SGE1ZmgwbzJrMFRHcDlZQmlYNDU2eGk4QmZTVUhzTnpYc3BCRmZ5?=
 =?utf-8?B?L1paSFdRK2lTeDh3aExQNERITXNIdk5DZUs0YlM3dE52N01CbThMYUF2aStk?=
 =?utf-8?B?a2lsaDF1TUZnazY3UlRwUmRFZERNZU9Zb2R6L1RTN1F5SmMvUUM2YStTZ3dv?=
 =?utf-8?B?b21IY015cXlWaVpQZjI5Q3MyVWRMQ1FOUitTWERLU2xUcXB0NXR3am9NOUx3?=
 =?utf-8?B?Y3Z2M1BvUkJkZlZGcE5zamVtRStIcld0RllXK0RIandiVjkyZ2tRT0dkc1ps?=
 =?utf-8?B?QjhmVVkwSDgvc0VIZHVLWUI4SGVWd2NWZGx6Tnl3WVFUcnUyamtKMW13dlc3?=
 =?utf-8?B?aG9Ua0Fkb1FBY0FaQkc2Qjk5Sm1mUUlKelJyZUt2RU95aXhnK0FhcU9KcU1x?=
 =?utf-8?B?d3EwVE40T0hTU1hISmFvb21TZVcyVlZWVnBzamlsUjRlaSsvS2xtYXBoUHFJ?=
 =?utf-8?B?RWJOekQ1Uno0Q0FYT1c1TUpjeWRtR1A1d3ZtTXNFakFaclJ1Nk92bG9KRFNS?=
 =?utf-8?B?eHJZQkxTaHRaTUxPYk5tT2xVbWU2Ny9UQ1l3alRXeXZuZ0cxUlF1OHYweEFl?=
 =?utf-8?B?bmFyRkQzWDhmak9KdFJYSEh3cS9kQkV3QllJdzlIS1BoK2xiOWdwZ0c3Rk1N?=
 =?utf-8?B?RDZDZTBEM3diTkloczN4MGk4WVZncjVBb04veVVQc1gySEoyZjJmcDN5TExo?=
 =?utf-8?B?dXNJWExidWFnL2ora0NLYk5oV28vQnRxdVBkUzM5SHBOb0d0RVh4VE42NUdC?=
 =?utf-8?B?akszbXdlSjYwcllwNHRwV1Z2RnBvLzcwUjdUeGtuQi95b3djY2w4WWZjMm9J?=
 =?utf-8?B?Z3hVOUlMQUVzT2xSRDlIUGVOMlM1YVBBZzF0VkJnWU5qaVN1UXltc1d1VllW?=
 =?utf-8?B?a2NiQ3JzOFc4UGJ6eXlKUkFWdU1LUUNpK1Zlcm9ab2ZXQzl4THRpN2pYMStn?=
 =?utf-8?B?SW9uZ3UrbUUxKzJSSG1CNzFOa2RZMWluWEo1OCtYSzBpVzBEMzBnb2ZwRjJY?=
 =?utf-8?B?YzVxZEZ0MDU4L1gxYXJMTUpIOWt1RUhCakFoKzJTbklTaisxMnJNeFpqNkE5?=
 =?utf-8?B?bVpxMFdSSDdYcyttQmpmTk85MTdjTFY0UEJzakt2ZW5YU29nOFBJQjdTVzlQ?=
 =?utf-8?B?bHF0Q2pmbVZQUzhQbnB4NVYxLzBLMTN6VzV6QllOY1lLYXdCa2x3c3lQaVo4?=
 =?utf-8?B?Zm5PRWg4MWZOek5KU0NCamc1SUE1RHZQSEhlN2NQaURock1JNit2TDFjS3dD?=
 =?utf-8?B?UTljamNPbWg2T2JYR3RqWXR1OWp4V2NzcGcyWm1YQjZ6a3VtTkU2R2REOXgy?=
 =?utf-8?Q?jPi880aCije12mpV6OyD3Xx7f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8471207C4AA8F489FC55E9FF9413A7C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3922ad50-2121-45fe-7f79-08dbd5cb054d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 02:26:54.7100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5apySuACjtdvP+Llcv9axZI8KRxcxQ6i0G4J5OW0OPMGJ0+msdqhawv/HM9K0HFiC5Z2+fdS++UTir9pZusFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5411
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjMtMTAtMjMgYXQgMTI6NDUgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIGNtZHFfaW5zZXJ0X2JhY2t1cF9jb29raWUgdG8gYXBwZW5kIHNv
bWUgY29tbWFuZHMgYmVmb3JlIEVPQzoNCj4gMS4gR2V0IEdDRSBIVyB0aHJlYWQgZXhlY3V0ZSBj
b3VudCBmcm9tIHRoZSBHQ0UgSFcgcmVnaXN0ZXIuDQo+IDIuIEFkZCAxIHRvIHRoZSBleGVjdXRl
IGNvdW50IGFuZCB0aGVuIHN0b3JlIGludG8gYSBzaGFyZWQgbWVtb3J5Lg0KDQpJIHRoaW5rIHdo
ZW4gY21kcSBkcml2ZXIgaGFuZGxlciBpbnRlcnJ1cHQsIGl0IGNvdWxkIHNpbXBseSBjYWxsIGlu
dG8NClRFRSB3aXRoIGFuIEFQSSB0byBxdWVyeSBzdGF0dXMuIFRoZSBzdGF0dXMgbm90IG9ubHkg
dGhlIGV4ZWN1dGUgY291bnQsDQpidXQgYWxzbyBvdGhlciBtZXNzYWdlIGluY2x1ZGluZyBlcnJv
ciBpbmZvcm1hdGlvbi4gU28gaXQncyBub3QNCm5lY2Vzc2FyeSB0byB1c2Ugc3VjaCBub24tdHJp
Y2t5IHdheSB0byBnZXQgZXhlY3V0ZSBjb3VudC4NCg0KT25lIG1vcmUgcXVlc3Rpb24uIFRoZSBj
b21tYW5kIGJ1ZmZlciBpcyBub3Qgc2VjdXJlLiBEb2VzIHRoZSBHQ0UNCmhhcmR3YXJlIGV4ZWN1
dGUgdGhpcyBub24tc2VjdXJlIGNvbW1hbmQgYnVmZmVyPw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAz
LiBTZXQgYSBzb2Z0d2FyZSBldmVudCBzaWdhbmwgYXMgc2VjdXJlIGlycSB0byBHQ0UgSFcuDQo+
IA0KPiBTaW5jZSB0aGUgdmFsdWUgb2YgZXhlY3V0ZSBjb3VudCArIDEgaXMgc3RvcmVkIGluIGEg
c2hhcmVkIG1lbW9yeSwNCj4gQ01EUSBkcml2ZXIgaW4gdGhlIG5vcm1hbCB3b3JsZCBjYW4gdXNl
IGl0IHRvIGhhbmRsZSB0YXNrIGRvbmUgaW4gaXJxDQo+IGhhbmRsZXIgYW5kIENNRFEgZHJpdmVy
IGluIHRoZSBzZWN1cmUgd29ybGQgd2lsbCB1c2UgaXQgdG8gc2NoZWR1bGUNCj4gdGhlIHRhc2sg
c2xvdCBmb3IgZWFjaCBzZWN1cmUgdGhyZWFkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFzb24t
SkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBpbmRleCA2YzJjZjMzOWI5MjMuLjM5OWFhNmJiMmY4
ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBAQCAt
MTc3LDcgKzE3Nyw3IEBAIHZvaWQgbXRrX2NydGNfZGlzYWJsZV9zZWN1cmVfc3RhdGUoc3RydWN0
DQo+IGRybV9jcnRjICpjcnRjKQ0KPiAgCQlzZWNfc2NuID0gQ01EUV9TRUNfU1VCX0RJU1BfRElT
QUJMRTsNCj4gIA0KPiAgCWNtZHFfc2VjX3BrdF9zZXRfZGF0YSgmbXRrX2NydGMtPnNlY19jbWRx
X2hhbmRsZSwgc2VjX2VuZ2luZSwNCj4gc2VjX2VuZ2luZSwgc2VjX3Njbik7DQo+IC0NCj4gKwlj
bWRxX3NlY19pbnNlcnRfYmFja3VwX2Nvb2tpZSgmbXRrX2NydGMtPnNlY19jbWRxX2hhbmRsZSk7
DQo+ICAJY21kcV9wa3RfZmluYWxpemUoJm10a19jcnRjLT5zZWNfY21kcV9oYW5kbGUpOw0KPiAg
CWRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKG10a19jcnRjLT5zZWNfY21kcV9jbGllbnQuY2hh
bi0NCj4gPm1ib3gtPmRldiwNCj4gIAkJCQkgICBtdGtfY3J0Yy0+c2VjX2NtZHFfaGFuZGxlLnBh
X2Jhc2UsDQo+IEBAIC03ODYsNiArNzg2LDggQEAgc3RhdGljIHZvaWQgbXRrX2RybV9jcnRjX3Vw
ZGF0ZV9jb25maWcoc3RydWN0DQo+IG10a19kcm1fY3J0YyAqbXRrX2NydGMsDQo+ICAJCWNtZHFf
cGt0X2NsZWFyX2V2ZW50KGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0NCj4gPmNtZHFfZXZlbnQpOw0K
PiAgCQljbWRxX3BrdF93ZmUoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50LCBmYWxz
ZSk7DQo+ICAJCW10a19jcnRjX2RkcF9jb25maWcoY3J0YywgY21kcV9oYW5kbGUpOw0KPiArCQlp
ZiAoY21kcV9oYW5kbGUtPnNlY19kYXRhKQ0KPiArCQkJY21kcV9zZWNfaW5zZXJ0X2JhY2t1cF9j
b29raWUoY21kcV9oYW5kbGUpOw0KPiAgCQljbWRxX3BrdF9maW5hbGl6ZShjbWRxX2hhbmRsZSk7
DQo+ICAJCWRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKGNtZHFfY2xpZW50LmNoYW4tPm1ib3gt
PmRldiwNCj4gIAkJCQkJICAgY21kcV9oYW5kbGUtPnBhX2Jhc2UsDQo=
