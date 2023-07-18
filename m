Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E919675750A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjGRHKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGRHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:10:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F6CC;
        Tue, 18 Jul 2023 00:10:01 -0700 (PDT)
X-UUID: 18b44b16253a11eeb20a276fd37b9834-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WVvrtnt3Vn4hK69o2+bTXUpGH8l7WEGOCi1ebN4ly8k=;
        b=TS+zR0KHTvoX5hwHqj8DbYic8QcNQs1oFdLm4/Qe5Aw9y0PtIsv1cUQs0y2R7Iipux0o2Hsw/2wHRl0tqZ/TssbrsPUabgTQbp9Ff8QbNYLLnWA9dJDXN9ML054nYsh2Q+YPkw5wj5B4vXqEi3mqKgY0/cVHhcPMA+lAcusqzNA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:a4ee8235-068a-4751-8e9b-9b329b093d1c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:3931d54c-06c1-468b-847d-5b62d44dbb9b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 18b44b16253a11eeb20a276fd37b9834-20230718
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 812308959; Tue, 18 Jul 2023 15:09:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 15:09:53 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 15:09:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2ZqErl6u+QmFU5YQ+FkMOHIN90ZC9t+TKEUumVxmRbSXKYVZpk48ifB/phf2ao/GQowvsLOcbQQ7E7DIR3eh80TNAYo49rupZT3N0ZFXMCpKOhYCDsyLkesJC1ZulFRzUNKQN+TeIFJQG5ynPOs5rHrv+1+sxPBfSacfdilPltYBC/zsWOtI7HA3VrI6QnSYwMEAhznDfCmqkwEiudNlGVR2lDrEequ27AFaqTm1izHtWIXMolOf7adgh7Qcg91/VpSHI5LSN6Dj4hKB26Ejm7vJ7c/SgHood3xyNB6SWMbnQzKTrWew5KxKRr+NbXeC0Gn4iRF64tXK4Kctbc+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVvrtnt3Vn4hK69o2+bTXUpGH8l7WEGOCi1ebN4ly8k=;
 b=bDwM1/cbertQyrzK3mN9kD1lyVmoJIbQ/RLqKTfh/x3X1wdg9lx6SW8Z+g7hdQxl9AAVn3HUSmlTC4tpjKsg0ILxCudYhmZFm1Re0zjxf375YzMiejyrW0+csprTw8T4CzLwUPGYoKQC0jIT3i7sENXJdzIUjJmo3elqyqE9qZTxodmEs7W1uRBHBs4PZg/+RXVGw6jFUKblE3gg4gEtGu50zQlC2TMbMLeF5DM2/FqXQq6W/bXJCORBzqoyHP3dT8TH7fC9ESbvUxeRhm0I7lheJ0ZtFp9VbblbJ2pvFFMmqPwjb8uC4bYafLN6NiDhaqD7BJ9/a+bb9nf/pojh6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVvrtnt3Vn4hK69o2+bTXUpGH8l7WEGOCi1ebN4ly8k=;
 b=AIhXezjdCFJgNcleCcpn7MGDbazqYNXlW3c7pmK2cP8UjrO0+coLSPlHePSBp3OOmFRR2zMsJ55YP21Wo2b1v4ucvN7ugT4a0y2IZnb740o7UKwa3PTYMqDAYjwj3bg9r9DhvN6jd3cLIJfA0D/FMjgsMehBxIjOmg7lvBbNGVU=
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com (2603:1096:820:73::5)
 by JH0PR03MB8049.apcprd03.prod.outlook.com (2603:1096:990:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 07:09:50 +0000
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b]) by KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 07:09:50 +0000
From:   =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT8188
Thread-Topic: [PATCH v3 3/4] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT8188
Thread-Index: AQHZuKa+mCNwE2yJYUy0H3wXIybGVa++X+qAgACykoCAAACQAIAACVSA
Date:   Tue, 18 Jul 2023 07:09:50 +0000
Message-ID: <eaf7c543a20559d83d314276592f5fc648ad2e2d.camel@mediatek.com>
References: <20230717120300.21388-1-jason-ch.chen@mediatek.com>
         <20230717120300.21388-4-jason-ch.chen@mediatek.com>
         <9e46c996-3e3b-b437-f2c4-2ca86a1c7e6c@linaro.org>
         <054014f207e24e1507199cd9833085346ed8cbd6.camel@mediatek.com>
         <6ae63cd6-7e57-d81b-fd08-5699b4e6256b@linaro.org>
In-Reply-To: <6ae63cd6-7e57-d81b-fd08-5699b4e6256b@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5650:EE_|JH0PR03MB8049:EE_
x-ms-office365-filtering-correlation-id: 2531dadb-9e64-44c4-1a8b-08db875dfa40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjYBYJ7K3DJotwzp7qhvPpV42F9IA78aHEe1sQPwCSJhwoyr3XBOZFapw3YTbYkYoKCL/nnDcVjmKBRVmaEfPoJXpKIU8nNS1ksWzM3NNt0VF3nVsWu16x+cYMPKWFCohNCzVk4J/nwHxF7QnKd8H3QEgiWBfPtwDzeJ2YkC1AGG/G2DNfblPvopuLkE8jnFkzoJbXzlxu+yawnYHwzw6AigPOPkwq96P1jy/MTan32Vwsg3DfIT1TcTxGhf2vOWs3j4bXxqPnkj/Wm9FigPGzq7XM3i5aJ/y8aKqK75jbRsKGaddJtV2EWJT1JUJ7fGeDShsRjpijvvnCLijoMlRt5UjVtxNl0uK3noPrTbDvlJ8B33f24nxrThjuH2CN5Pnw/fzRysw89lnItwo9pOFc/lHABndwF0UeS4ZSj3OrM2ibE6nGyor8E4OAjKqFB56BaQT4pqxHxckIUkcwJyTHRySOThnqaz6KsXVNsSy69xcwGf27kCNM9ee5KilWQd9q/RH1nzLfr/EU+n4kudPH/aeYHW2pSuGuqzydi0Wb7PBbPV5A0bzag+0unpWwdck23zHs9JkBalvmvP1AhkVVkBirXoSix08B1ebEDpfrDUZFttuSMIiCmOmAQdkYj/rYl/d7tb6LxtYl6dUjcxvpyLA9FTKoZS9sZZ6bAzRNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5650.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(86362001)(2906002)(85182001)(36756003)(7416002)(38070700005)(6512007)(83380400001)(186003)(53546011)(6506007)(26005)(54906003)(6486002)(91956017)(122000001)(110136005)(4326008)(76116006)(66556008)(66476007)(316002)(66946007)(66446008)(64756008)(38100700002)(71200400001)(478600001)(8676002)(8936002)(41300700001)(2616005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVY2YVBJeFpFa2FuNHNYTUE0bXB1T2IydG1IL0VnMjBncE4xOWVxZGU5b0Jr?=
 =?utf-8?B?UHowQzVzUXp0b0lLZE0yQUZjcTBobTBCdy8reXVySGs4Wisvb3NVcFM1MExY?=
 =?utf-8?B?TW52YUlPTWsyV01NeGQwY3JjZysrTXFGMWlaTHdnVzRXbDdzdkpZbXdYcXdu?=
 =?utf-8?B?N2k2aGFpcjBhWXlSakpsMlBnTzE2emFHeXF5VmlyUDZPY1lEU2NwOUh4UE9M?=
 =?utf-8?B?M0M4RVNUOXBlRHdUNmJHUFlKQi9WbUlqZCs0dGFFdnNGSFNNeEl1SHhZa3ho?=
 =?utf-8?B?VlBpMlg3VzFSZ0FESGo4Z2VCZkpiR2FIMVNtaThLN2FtR3RMbForN1hnKzFX?=
 =?utf-8?B?Nm9veGlqR1FmYnozMGZQOS92MFVWT0krOTA1ZUJJK0N1L042dXBaNHFzTXl0?=
 =?utf-8?B?SWVkM2xlR292NkJSRWwwVnFnNnpPWWlIYVVBKzlGVDVuSUs0ZFlkMnk5QmpZ?=
 =?utf-8?B?cmVEd1BEQW5YYmdKUEVUTHJuSnhIOC9KVFhPNUhpUm5vS21WRWEvblpSd2Vz?=
 =?utf-8?B?MlVCV0N1WGZPV0ljdzFxajZWdEp0ZVAyblpuQVBwUWlrQUY3UnRxQk5sTlNS?=
 =?utf-8?B?ZnpuSDd2ZVo1R3RTQXFKVWUzTlFFOFg2c25MU0dqejMwdUpmUnB6a2V1a3Aw?=
 =?utf-8?B?QWZVOXF3QnlRSkpKN2JkSmN5ajZpQXNlWHNvVlg0a1pVQk9uWGZNN3B1M0J5?=
 =?utf-8?B?dXVEZzl4QVgxb0NqSWdNS3NpY1Ntd0V1YlA1d0NBSDI2R0orc1pXd3RMbklV?=
 =?utf-8?B?eWxmM203ZVVQSFdIYmR3bVpoWVpmNzV2MTBpVGtCRTBSRzFhNTRueGNWSTJv?=
 =?utf-8?B?REtsUmpEQTRxMlFPRlR5WVAydXlyVUFxNkhMNzIrTno2UHV2V0o0YnBqaUFS?=
 =?utf-8?B?M3RlUUxSd3d6U0JmSmExclFqSWlCL0UvOEhuRGo0ZnFnYm1aOVNLVzU2enRs?=
 =?utf-8?B?OCtIRnE2aVhYQWd2azArblRIb0xGNGVVU2p0QkJ1Zlg0cHVDSUtEZFRab0Jx?=
 =?utf-8?B?Nk9ud0xvdVo4Rk83STZMd2lZUVE0MWQzaVZWNFVuWG1HNTRZSW9HZTVRVGlp?=
 =?utf-8?B?amRHODdteDBoL3oxRW5pbXB2NDNFU3RUWitobC9MbXdaNk05TlVWYnFHY052?=
 =?utf-8?B?MXh2bEI0WEYyK3R1ZG11R2wwTEhzcENoRmVLZnkwQXZ0SFpnRUFFeVo5dHRF?=
 =?utf-8?B?cWhONGNFQ2w4K1VpczV6MXhYeTU0WUdwaGx4RW94d2RFUG1rLzFQRHg3UHhw?=
 =?utf-8?B?bzEyOGV2cEF0cldPNHNGOU5mclhWY1lRQ28yR04vYVg5QzhBNmtBL2R6QU1k?=
 =?utf-8?B?M3Z0RU05K2gvaldDZW15MVE0bmd1UU90RUoyZVQ3RExUb0M2Tm9acm9JZTFI?=
 =?utf-8?B?Y0orY25rbGEyTlJXUjZoTmFFQmVJVmMvcDl2SEMxQUh5UmVHbkNXbDl6ZzNt?=
 =?utf-8?B?eFJrdE16aDhkTUFiaG9sZm1OaGtEME84UFpxZFVmcEZNWUJJRS9tTGVzaDVi?=
 =?utf-8?B?S1ZWTmRRdDBpdktUY29waUdFNnMzOEhCOTNCRlpiZHRqc2h2aUE1YXVvSUxv?=
 =?utf-8?B?VHpFVHA0eTNmYjVjU0kwWnUxbXZ3Q1NEcXQvVkM4N1lWVmpkc09paG9uVjNu?=
 =?utf-8?B?Vi8yRVFhMVhkYk1pZUJZaFNxYU9zbjUxdTdDZG1aM1duTnlpRWloSDlxbnYx?=
 =?utf-8?B?c2VKM0ozYTAwWEVWQW1CbktpZy9ZMFBheXlFTFNvWEk1MFZGQXpnbExKMnVM?=
 =?utf-8?B?bFNIcUd3WVJKdTl0VTdkU3l5Y2hNaUVNdlkzSmE2bUlnbkRtdDlTSThIQXJl?=
 =?utf-8?B?R1dsb3Ntekwrc2NJbkhrZURNVTROOVllbjloNjExdG41MFFFUHJzQUpXcXBt?=
 =?utf-8?B?a1FMdTlRZTNUdXRna0JXV1RmcEY0OVEwQ0pqMHR4NFk2SUNaL0xxZVh6UWlH?=
 =?utf-8?B?ZUNMUHV0MGRlOU9UbTRRTlR0ZzI2bDlITnFSQ2dBdGIwcW5EWU51MzNoYVBX?=
 =?utf-8?B?N1lmc3FoNk8wcHl3enpVUDlpWVNiZmhqVFJNNEpmREF0RGpsN1VnLzV2alVJ?=
 =?utf-8?B?R0JWNC9XSlVvQU5qUnNqTXhPVGh2VkJHRGNzVDFwSG1idStzWm9pbjlobS96?=
 =?utf-8?B?WXMwZGpoc3M0ZEM3MDJXd2xPUEZMNVRYUTBvVm9TRFo0OTAzWGtxamRKNUV1?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B139121681A66B40A473A8562F40815B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5650.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2531dadb-9e64-44c4-1a8b-08db875dfa40
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 07:09:50.3187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5PorCcprIRqJJirFuf5xAEmZtXk4ujP37L+6FGmQpAMemw+ZmXsCTuSgvMjI2TK4LFEMgYrXOWf8cWc4Ks0nLM2WjDkej5SuhPauEN1JGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBUdWUsIDIwMjMtMDctMTggYXQgMDg6MzYgKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gMTgvMDcvMjAyMyAwODoz
NCwgSmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKSB3cm90ZToNCj4gPiBIaSBLcnp5c3p0b2YsDQo+
ID4gDQo+ID4gT24gTW9uLCAyMDIzLTA3LTE3IGF0IDIxOjU1ICswMjAwLCBLcnp5c3p0b2YgS296
bG93c2tpIHdyb3RlOg0KPiA+PiAgIA0KPiA+PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+PiB5b3UgaGF2
ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+PiAgT24gMTcvMDcvMjAy
MyAxNDowMiwgSmFzb24tY2ggQ2hlbiB3cm90ZToNCj4gPj4+IEZyb206IGphc29uLWNoIGNoZW4g
PEphc29uLWNoLkNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+Pj4NCj4gPj4+IEFkZCBNVDgxODggUE1J
QyBXcmFwcGVyIGNvbXBhdGlibGUgdG8gYmluZGluZyBkb2N1bWVudC4NCj4gPj4NCj4gPj4gTm8g
aW1wcm92ZW1lbnRzIGhlcmUgLSB0aGUgY29tcGF0aWJsZSBpcyBhbHJlYWR5IHRoZXJlLiBTdWJq
ZWN0DQo+IGhhcw0KPiA+PiB0aGUNCj4gPj4gc2FtZSBpc3N1ZS4gRXhwbGFpbiB3aGF0IHlvdSBh
cmUgZG9pbmcgYW5kIHdoeS4NCj4gPiANCj4gPiBUaGUgcmVhc29uIGZvciBjaGFuZ2luZyB0aGUg
cGF0Y2ggd2FzIHRoYXQgd2hpbGUgTVQ4MTg4IHVzZXMgdGhlDQo+IHNhbWUNCj4gPiBwd3JhcCBh
cyBNVDgxOTUsIHRoZSBvcmlnaW5hbCBjb2RlIHdhcyBhcHBsaWNhYmxlIHRvICdjb21wYXRpYmxl
ID0NCj4gPiAibWVkaWF0ZWssbXQ4MTg4LXB3cmFwIicuDQo+ID4gDQo+ID4gVG8gcmVzb2x2ZSB0
aGUgRFRCUyBjaGVjayB3YXJuaW5nIHRoYXQgJ1snbWVkaWF0ZWssbXQ4MTg4LXB3cmFwJywNCj4g
PiAnbWVkaWF0ZWssbXQ4MTk1LXB3cmFwJywgJ3N5c2NvbiddIGlzIHRvbyBsb25nJywgSSBtb2Rp
ZmllZCB0aGUNCj4gY29kZSBhcw0KPiA+IHBlciB0aGUgY3VycmVudCBwYXRjaC4NCj4gDQo+IEV4
cGxhaW4gaXQgaW4gY29tbWl0IG1zZy4gRml4IHRoZSBzdWJqZWN0IGluIG5ldyBwYXRjaC4NCg0K
VGhhbmsgeW91IGZvciB5b3VyIGtpbmQgcmVzcG9uc2UuIEluIHRoZSBuZXh0IHZlcnNpb24sIEkg
d2lsbCBleHBsYWluDQppdCBhbmQgY29ycmVjdCB0aGUgc3ViamVjdCBhY2NvcmRpbmdseS4NCg0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQpSZWdhcmRzLA0KSmFzb24NCg==
