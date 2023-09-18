Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F147A3F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbjIRDKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjIRDKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:10:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903D4DB;
        Sun, 17 Sep 2023 20:10:24 -0700 (PDT)
X-UUID: e599c94655d011eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uOWX35KxS4cFACfJYONZu9ofLuG+rGfdyJrdSBhIqrw=;
        b=YF8mOT1U4kH+F13mdtAFW7NPJjmgEPW4eSCEpQuvKHPTFL3mbwt3gcNq7RpcuDVfMn00/Boub/6HG+L0lbJwG22E8EqFHV4Rr5kDJQmXxE2SUfKGvC7i1BqxuI2BJ1wuMAqs0oMwWx+tPhMRoBpwGWH9qj3XZu6ET6per7UU+3g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:42ba5b90-b981-439d-9661-f5af87148ec3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:5f21cfef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e599c94655d011eea33bb35ae8d461a2-20230918
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1660577089; Mon, 18 Sep 2023 11:10:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 11:10:17 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 11:10:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwkPOmagD9DJWZNOlwa7hc1UJBzFcqrBe4mn5c6pS7XbjKOGnpxt6dujzvb41inDg8bu9LlSucn/lGm8YBI+GBclvdWH0XrjtCAl4oh+Afvm5pu4vwP4z6qXnOJEIec17ccOdWtpeT2hJ+OAj4Vc+spqcHcQ1LIZ8gXd1Gf6s9whuFSB478IXIjCYyhIVuBagTUFz31z23+Jjw3Ez+LLO4htj4qGQ+eHrOHbTBsCUJQUBp69l/S4a8GhtJNkKMsDdpTT0x7n73TgRaprx3RyHFDZelXmaoTBC5vPMq9MfEUBEdbCtOJlAGyOZKNbJAPNJBz+L2IUQXE0Co/T2pzwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOWX35KxS4cFACfJYONZu9ofLuG+rGfdyJrdSBhIqrw=;
 b=BstFqNHxuldnaSFq/Y28XmTsEkkRhl/ekwCH4LphnpW08kTHCAZdOxnd76Xjq6yQDXfO2b/xEsuuWZKvpaREW2yzNr9Ee5YQY7LlTftWgtkWw6OxAmqcYxouQqRTCowsRtYLuBnJBdZVfOz8Fs8zhAaldPspmsF/csT6XBKsKXE6YIMQJf45S0Bx4aOYH7m6ZnTnm73QxrD8CUEev35kXnZKNPq+Xug5IDDGnFDQ+AmkFjxoHZJXcwUTbJstqKi1ita86m5kSBY2aZAXfiAp3sAeCgRIYuXLMe/N4tzO3HH8m2cnjzo/U62wak2vvOXjtbOw9qGkjJKyT9iLxWxovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOWX35KxS4cFACfJYONZu9ofLuG+rGfdyJrdSBhIqrw=;
 b=PE4R7ZjxjfX7kDXmjL19YvJl2+29ceRypW9XkwRDpKtlnfNcjzuLkvXkEvzKT8JvxvtWsK5g3k5DP19xG3B+MedwB2Ma+ax+wky22/NptCJ0b3zh/vuG4wRN5f/+sot0WC/tjWSdWOhl/rJehHTZxZJkpV8th562i1/qAsDqlvI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6083.apcprd03.prod.outlook.com (2603:1096:4:14d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 03:01:11 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 03:01:10 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v6, 2/4] drm/mediatek: dp: Add the audio packet flag to
 mtk_dp_data struct
Thread-Topic: [PATCH v6, 2/4] drm/mediatek: dp: Add the audio packet flag to
 mtk_dp_data struct
Thread-Index: AQHZ1KJdKwc7wwDTVk2riP/o3/9ibLAgD3sA
Date:   Mon, 18 Sep 2023 03:01:10 +0000
Message-ID: <a2cdc50122a1548e4e99270fab986bb156a4c374.camel@mediatek.com>
References: <20230822024155.26670-1-shuijing.li@mediatek.com>
         <20230822024155.26670-3-shuijing.li@mediatek.com>
In-Reply-To: <20230822024155.26670-3-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6083:EE_
x-ms-office365-filtering-correlation-id: f510ee86-66e3-4978-7623-08dbb7f38323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bArl4bcVVeS2/vDSK+evp+y4HAyhnm86Y4aWAl6T6CUyqrwlmCcCuNHmnQQd2SL+eiyIIEEX79KN//iDdyGhJ7i0t36cHLtwBk3IXwUZ5tOlXZjkoFuEk+e1QQTfnpNgKPKnKWMaMnHRx4lj1YcUhVL3r3wNFCzDNkBa7xZoXbBuecEOk0IYnB9S1XCTxv77yhI2pjAmwG6T2K1HOLuUoH1YHAkRaszKsvahddoJFTQckWXh30CFwRHeHIz2v2gwxPC5C3xZUSMkZxqbxWYaV8ukG++loU+SeBfeF3J9hbbPXxphJ/J/24Abd6C8lYLcCh5grGb/qLNHdusC9yvVT0j5MTqSHnnb5lpr5MSK5DxUZ2QRH6pHGFZGrgZoJP5XdiJOx72GA5Vlfp3r6lWyE/bGlGVCC65KDcHjlbmx4yZNk/Zy7g/yNHY3LXBh5i5k+U/KRXuwpTXZTp91++iECMdklQ6k9SjkotUucbKxqkYT+y9ycUtg6v+5P4uxT9YQNdkfr5yZ+sBF8yY3W9/iHy8sPgvV2N4rRtITZO5ZZ8/WFyRN+4XphQ5/6rdxu+yvtOGcTFxUQxO7UQXskRbe+xTgjfM3XDADPiJseZPBKk5813ezzy55fCcHz/sBiQ58+puSz/UXALQK1Zd4xoznYzaUytcmCo3lMnxAGfBHcNasKBL3dYsKk6SgUQR/W4Qr0Mj4D6Bxs7q4r4emdAMKKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199024)(1800799009)(186009)(36756003)(85182001)(26005)(107886003)(2616005)(2906002)(5660300002)(38100700002)(38070700005)(7416002)(86362001)(8676002)(4326008)(8936002)(316002)(122000001)(921005)(41300700001)(76116006)(66946007)(66556008)(54906003)(64756008)(66446008)(66476007)(478600001)(966005)(71200400001)(83380400001)(110136005)(6486002)(6506007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N044SWhKOUlqYTVxUk5vaTVqQ2hjTlNLZWJjVmVvWlZxeTg2L2IrMjNTTUY0?=
 =?utf-8?B?QTJyMU04UFJaaHhvaVVDb21TTHk3NEpLb29qK0haY29kaTRaVzN1dE1qVzEx?=
 =?utf-8?B?a3FZSFplZmpyZDBPb0R0VkRDMjhneDRQbjMrVC9aYmZERVVKV0FNU1ZpOGJw?=
 =?utf-8?B?bUs1b09FUkVkMEM5MWVDeFBDc21mVnR0YkNac3FkVXg5TFdYMFFVZHlMak5l?=
 =?utf-8?B?czNaR3VaR1JMWmNDRnNHL3IwdHplVHIzcTFhZ1NmMkwzOHRabWVSdjFUcGFj?=
 =?utf-8?B?WTl2aFZQVzNPb3ozdmhVaEZkeHNEOGxsaFZKWXA5NlY1OU5HZ1AzYTRPTWJF?=
 =?utf-8?B?bW50R1FqdDVCZ01sc0ZXUFppWEErbWlQWGJ2blFIZzc5NTBrcFJuSnpiRVIz?=
 =?utf-8?B?ekcyZFBsZlNvZEdZODJ2aFlCZjFNR2twTmFGTk03ZW9KL0t6UUM1YTlOMW1X?=
 =?utf-8?B?RktuNFl0RllDMUt4elZERk1PRUxoNTRmcW84UUVqblFraU5RMVdxaU1Hbnh4?=
 =?utf-8?B?ekFqUC9Bd2oybk1vTWh0eHNvRUFSV09GM3JZVlJMWlZDR05GVEYySWZpaS94?=
 =?utf-8?B?d1hCRUQ3b0k2UGpnUVFsM3dEY09keitmSVFxWS96M2dCMkRIYWZUVER5WkJU?=
 =?utf-8?B?VitWUGJKSGRueGRQWXRWdERGcWtBeG5ySHdRaWpSUmJmRVpPN1YxTHN6Sy93?=
 =?utf-8?B?dGhiMVFiN2xVZDZsNmtuY1lJMm96M1FPMkl0Rk5DVjg2cUhqSy9iczdxaU0v?=
 =?utf-8?B?Qnp2QTFwVXJGdFF3K2R3TnpuZGphRVZlcVFqVWU0NmUvejhGR3RpOWdHVU9m?=
 =?utf-8?B?ZEY4RjJKSkZCOUIzZWhNbmo0MExrb0lzOWc1b2tqcXZlSFREZ2s2bFgvcTAv?=
 =?utf-8?B?eG4xelhXazNsVk1tc1crYWNoR3piK0J2dlZoeHUzcTJqMG1yb2JZUk1DZG8x?=
 =?utf-8?B?akE3ZGJSbTBseFdFRUFOcFkvanN5MVJiSk9KK1dDUnFkYUVrNUJoU3E2TnhT?=
 =?utf-8?B?WmxDUks5Z2lvMWNnSUJGRTlOdW1XUml5Zlh3ajBkREdaNjdsYW5uUjR2V1dV?=
 =?utf-8?B?Qm1xTng1ZFkxVy9pemJpMld1ZTJtYUFlUkhwRjdyYkFYNGVJTGc3b0NUaU96?=
 =?utf-8?B?MlltNlBzMEgyb25Zc2xkWklYSm4ycVJSRkc0bnBzSVBUSTUrM2VwY3ZtYTYr?=
 =?utf-8?B?L1Z0RkFjSThLNk5kUDRlSE9OYzAxbDFDOGt0d3MyV212K0xid2gwZkRwbGxi?=
 =?utf-8?B?aGZkd0pnTlNlZU0zRlhmczlBdHhzeUgyeENwazIvZ2NVWEpIZWhKUm1ZZmxT?=
 =?utf-8?B?bklhQTlEdTlONjhhb0FRMWo1RWVxdjQwWkxMV1puRjN1Q2VqNmRWZ2R4VDBu?=
 =?utf-8?B?U29JdGhaUG0zU1hqL1prOUdVcURYV3g4NkVaUUpuSmRMbUNuZ1BLY01jVzg0?=
 =?utf-8?B?dWlNWjVkcDRhWEl4QVVkNXBIcWRTZTV4VitNSXJLN2ZjSHhIaW9CNmltWWFu?=
 =?utf-8?B?KzRWUTZQTElDckxaV25aY2czM09lNENvOHRaMnR0UWxtcjZIb0d2VXhIUCtP?=
 =?utf-8?B?aENmcHN6eSsxd1dLQXF0S0xESU13bEtpQWR1RXZtNHlvYXA5R2l3NXJFNmda?=
 =?utf-8?B?d1hsVVVCNTZ1OVkxNkgwUFJLSWZkYWpSSVh2ODVKUEs1bStTSExGRGhyeTZX?=
 =?utf-8?B?amdybCtJdDFyVFlvOWV0ZUNWcS8vL0cyUXZtMG5LV3JoMmFNL0cwQm5OR3Nj?=
 =?utf-8?B?KzZtZ09Dbi9WdXluWjZSZmhZU2xNMmtRTTZXb0NqVnVKMTc5Rmd5NFFrT3h3?=
 =?utf-8?B?R1RMOFgxMHJleGtVQUV5OUo5TTkveUE2NzZkZDRKU3cycjIycWg1ZHZrL1RU?=
 =?utf-8?B?Z3E0eW9ydEk4R0czQUN4dWJKYXZqOTJoTlo0SDFoKzJnT0NxeEIrRFA3WTgw?=
 =?utf-8?B?YkxtbUwyT0F2Wk5DUlVpamNhY0JhSzFwMlVidG1GcU5yNHdsOG5NSjRpdzda?=
 =?utf-8?B?TXlJU3ZSenNCNEZHbFRwYTVuc3BaemtxRmdGUnBSVVBPK1ZyaEJkc1FWaklq?=
 =?utf-8?B?TzZTZk5DcmxPZTNzZXNzamFMVDA2TlRSRDJwTGFrYksyalBLMUU5WHBFVzRL?=
 =?utf-8?Q?z5Uvo6Rl/K7AjBEbfF/DC4FJo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <674F8C66D3853E47963E3A022657332C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f510ee86-66e3-4978-7623-08dbb7f38323
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 03:01:10.7777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2XUmgwhHpD2iYcU5Uj2MJDZlgCl2WRfaeANmiHoCYns6pfy72k5wt41rQzbQcA0aiaE487u7jAflMSmqhdniA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBUdWUsIDIwMjMtMDgtMjIgYXQgMTA6NDEgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBUaGUgYXVkaW8gcGFja2V0IGFycmFuZ2VtZW50IGZ1bmN0aW9uIGlz
IHRvIG9ubHkgYXJyYW5nZSBhdWRpbw0KPiBwYWNrZXRzIGludG8gdGhlIEhibGFua2luZyBhcmVh
LiBJbiBvcmRlciB0byBhbGlnbiB3aXRoIHRoZSBIVw0KPiBkZWZhdWx0IHNldHRpbmcgb2YgbXQ4
MTk1LCB0aGlzIGZ1bmN0aW9uIG5lZWRzIHRvIGJlIHR1cm5lZCBvZmYuDQoNClJldmlld2VkLWJ5
OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaHVp
amluZyBMaSA8c2h1aWppbmcubGlAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2
NjoNCj4gTW92ZSBtdDgxODggcmVsYXRlZCBjb2RlIHRvIGFub3RoZXIgcGF0Y2gNCj4gcGVyIHN1
Z2dlc3Rpb24gZnJvbSB0aGUgcHJldmlvdXMgdGhyZWFkOg0KPiANCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8zM2U2Y2NjNGU5N2IwZWYyNWY2YTIzNjAzNzIzMzIxODBmMWVmODkxLmNhbWVs
QG1lZGlhdGVrLmNvbS8NCj4gQ2hhbmdlcyBpbiB2NToNCj4gU2VwYXJhdGUgbXQ4MTg4IHJlbGF0
ZWQgY29kZSBpbnRvIG10a19kcF9kYXRhIHN0cnVjdHVyZSBhbmQgbXQ4MTg4DQo+IGRwL2VkcCBm
dW5jdGlvbg0KPiBwZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+IA0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9jMWM4NDYxNmYzZGE4M2E4YTJiYzI0NWIwZDNj
NzY5NzE1M2NkODFhLmNhbWVsQG1lZGlhdGVrLmNvbS8NCj4gQ2hhbmdlcyBpbiB2NDoNCj4gZHJv
cCBtdDgxODhfZWRwX2RhdGEgYW5kIHJlbW92ZSB1bm5lY2Vzc2FyeSBtb2RpZmljYXRpb24uDQo+
IHBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvYmRkYjFhMWE0NDVlYWQ4NTA1NjIwMmMzNTU2Mjc2OTgwNTFmMTJj
OS5jYW1lbEBtZWRpYXRlay5jb20vDQo+IENoYW5nZXMgaW4gdjM6DQo+IFNlcGFyYXRlIHRoZXNl
IHR3byB0aGluZ3MgaW50byB0d28gZGlmZmVyZW50IHBhdGNoZXMuDQo+IHBlciBzdWdnZXN0aW9u
IGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sL2UyYWQyMmJjYmEzMTc5N2YzOGExMmE0ODhkNDI0NmEwMWJmMGNiMmUuY2FtZWxAbWVkaWF0
ZWsuY29tLw0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIGNoYW5nZSB0aGUgdmFyaWFibGVzJyBuYW1l
IHRvIGJlIG1vcmUgZGVzY3JpcHRpdmUNCj4gLSBhZGQgYSBjb21tZW50IHRoYXQgZGVzY3JpYmVz
IHRoZSBmdW5jdGlvbiBvZg0KPiBtdGtfZHBfYXVkaW9fc2FtcGxlX2FycmFuZ2UNCj4gLSByZWR1
Y2UgaW5kZW50YXRpb24gYnkgZG9pbmcgdGhlIGludmVyc2UgY2hlY2sNCj4gLSBhZGQgYSBkZWZp
bml0aW9uIG9mIHNvbWUgYml0cw0KPiAtIGFkZCBzdXBwb3J0IGZvciBtZWRpYXRlaywgbXQ4MTg4
LWVkcC10eA0KPiBwZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+IA0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9hYzBmY2VjOS1hMmZlLTA2Y2MtYzcyNy0xODll
ZjdiYWJlOWNAY29sbGFib3JhLmNvbS8NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RwLmMgICAgIHwgMTQgKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBfcmVnLmggfCAgNSArKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGluZGV4
IDY0ZWVlNzc0NTJjMC4uYmFkYjIwNWZmZmYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcC5jDQo+IEBAIC0xMzksNiArMTM5LDcgQEAgc3RydWN0IG10a19kcF9kYXRhIHsNCj4gIAl1
bnNpZ25lZCBpbnQgc21jX2NtZDsNCj4gIAljb25zdCBzdHJ1Y3QgbXRrX2RwX2VmdXNlX2ZtdCAq
ZWZ1c2VfZm10Ow0KPiAgCWJvb2wgYXVkaW9fc3VwcG9ydGVkOw0KPiArCWJvb2wgYXVkaW9fcGt0
X2luX2hibGFua19hcmVhOw0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
ZHBfZWZ1c2VfZm10DQo+IG10ODE5NV9lZHBfZWZ1c2VfZm10W01US19EUF9DQUxfTUFYXSA9IHsN
Cj4gQEAgLTEzNjIsNiArMTM2MywxOCBAQCBzdGF0aWMgdm9pZA0KPiBtdGtfZHBfc2RwX3NldF9k
b3duX2NudF9pbml0X2luX2hibGFuayhzdHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+ICAJCQkgICBT
RFBfRE9XTl9DTlRfSU5JVF9JTl9IQkxBTktfRFBfRU5DMV9QMF9NQVNLKQ0KPiA7DQo+ICB9DQo+
ICANCj4gK3N0YXRpYyB2b2lkIG10a19kcF9hdWRpb19zYW1wbGVfYXJyYW5nZV9kaXNhYmxlKHN0
cnVjdCBtdGtfZHANCj4gKm10a19kcCkNCj4gK3sNCj4gKwkvKiBhcnJhbmdlIGF1ZGlvIHBhY2tl
dHMgaW50byB0aGUgSGJsYW5raW5nIGFuZCBWYmxhbmtpbmcgYXJlYQ0KPiAqLw0KPiArCWlmICgh
bXRrX2RwLT5kYXRhLT5hdWRpb19wa3RfaW5faGJsYW5rX2FyZWEpDQo+ICsJCXJldHVybjsNCj4g
Kw0KPiArCW10a19kcF91cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9FTkMxX1AwXzMzNzQsIDAs
DQo+ICsJCQkgICBTRFBfQVNQX0lOU0VSVF9JTl9IQkxBTktfRFBfRU5DMV9QMF9NQVNLKTsNCj4g
KwltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfRU5DMV9QMF8zMzc0LCAwLA0KPiAr
CQkJICAgU0RQX0RPV05fQVNQX0NOVF9JTklUX0RQX0VOQzFfUDBfTUFTSyk7DQo+ICt9DQo+ICsN
Cj4gIHN0YXRpYyB2b2lkIG10a19kcF9zZXR1cF90dShzdHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+
ICB7DQo+ICAJdTMyIHNyYW1fcmVhZF9zdGFydCA9IG1pbl90KHUzMiwNCj4gTVRLX0RQX1RCQ19C
VUZfUkVBRF9TVEFSVF9BRERSLA0KPiBAQCAtMTM3MSw2ICsxMzg0LDcgQEAgc3RhdGljIHZvaWQg
bXRrX2RwX3NldHVwX3R1KHN0cnVjdCBtdGtfZHANCj4gKm10a19kcCkNCj4gIAkJCQkgICAgTVRL
X0RQX1BJWF9QRVJfQUREUik7DQo+ICAJbXRrX2RwX3NldF9zcmFtX3JlYWRfc3RhcnQobXRrX2Rw
LCBzcmFtX3JlYWRfc3RhcnQpOw0KPiAgCW10a19kcF9zZXR1cF9lbmNvZGVyKG10a19kcCk7DQo+
ICsJbXRrX2RwX2F1ZGlvX3NhbXBsZV9hcnJhbmdlX2Rpc2FibGUobXRrX2RwKTsNCj4gIAltdGtf
ZHBfc2RwX3NldF9kb3duX2NudF9pbml0X2luX2hibGFuayhtdGtfZHApOw0KPiAgCW10a19kcF9z
ZHBfc2V0X2Rvd25fY250X2luaXQobXRrX2RwLCBzcmFtX3JlYWRfc3RhcnQpOw0KPiAgfQ0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcuaA0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVnLmgNCj4gaW5kZXggODRlMzhjZWYwM2My
Li5mMzhkNmZmMTJhZmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHBfcmVnLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcu
aA0KPiBAQCAtMjI4LDYgKzIyOCwxMSBAQA0KPiAgCQkJCQkJCSBWSURFT19TVEFCTEVfQw0KPiBO
VF9USFJEX0RQX0VOQzFfUDAgfCBcDQo+ICAJCQkJCQkJIFNEUF9EUDEzX0VOX0RQDQo+IF9FTkMx
X1AwIHwgXA0KPiAgCQkJCQkJCSBCUzJCU19NT0RFX0RQXw0KPiBFTkMxX1AwKQ0KPiArDQo+ICsj
ZGVmaW5lIE1US19EUF9FTkMxX1AwXzMzNzQJCQkweDMzNzQNCj4gKyNkZWZpbmUgU0RQX0FTUF9J
TlNFUlRfSU5fSEJMQU5LX0RQX0VOQzFfUDBfTUFTSwlCSVQoMTIpDQo+ICsjZGVmaW5lIFNEUF9E
T1dOX0FTUF9DTlRfSU5JVF9EUF9FTkMxX1AwX01BU0sJCUdFTk1BU0sNCj4gKDExLCAwKQ0KPiAr
DQo+ICAjZGVmaW5lIE1US19EUF9FTkMxX1AwXzMzRjQJCQkweDMzZjQNCj4gICNkZWZpbmUgRFBf
RU5DX0RVTU1ZX1JXXzFfQVVESU9fUlNUX0VOCQkJQklUKDApDQo+ICAjZGVmaW5lIERQX0VOQ19E
VU1NWV9SV18xCQkJCUJJVCg5KQ0K
