Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625EA7BB20D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 09:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjJFHPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 03:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjJFHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:15:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3467E4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 00:15:50 -0700 (PDT)
X-UUID: 2a716aec641811eea33bb35ae8d461a2-20231006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GPRpAVlv0j6EuthApOy3r9m24sfbGeZ3VShDEECtjeY=;
        b=Hl4ahX7uxHksX7c0SpsxpUvWnLt264Eeajos6hVF7B8C1GAYmA9fuGSov1EhnYFpXc8oEKJF2jiL0XTLsEU0/CtrXz/7OcjLep1pny6nFuOVY/6rVCpnbjLkOZcY6mcF77RJr71ysGWIC69gmljG/nDOx+S6Gmpq2Rhbm5Lhpsg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:fca2ae84-aa1f-4241-9c9a-f1390d726655,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:219b82f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2a716aec641811eea33bb35ae8d461a2-20231006
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1109097178; Fri, 06 Oct 2023 15:15:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Oct 2023 15:15:43 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Oct 2023 15:15:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxK+l8imy7EIJxk+tUtd7db4j4koiexC9JCfn8DhV04juCR8dxUTbW6yX3y0lilnZ8SsBdwfqnCJ5ca/whlpB39ti/M36cm+FgdEAN9LjRRE6dvaS913sPoTICnquuqifN/bnvJgprQ0bgNyTQGXFAfOiZ5kBdeIreW2s3/NokTw7TSJShs3FyquIIloCLPLkChBnQsxEYr6oHIWrlGWBYRUs1yWP2jxh/xCwOmJJ4+Vh3nFc3wxJ31RVRWsXJPHieX69KMunFlQlqIuWdfRdFvSl3Cb1VMPc+hekPVnuIO7FydiazQhgBLvZGgAa01/R4CMBwhL0E49nka23Sf0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPRpAVlv0j6EuthApOy3r9m24sfbGeZ3VShDEECtjeY=;
 b=SM/ofWZLotp1J6X+RmWi+RSpwrhLb+F1yf3LVNZ5kSf9gvWUuKJyXjgKGM6WvGQksNF7jdrT/429t2sPFBYqqF1xgkZ38a+Eb+SBIPqe3alP+YjUQOakagvstNcZIJo6uHyR8Au2e2/V2r7HrbpgJt956w+95J4u95U9Ot0wc7QUdaf0ybtCUbiM57iYI7py6CHmeTMV4UqQNy/ESuUWZdjsnW+CRt3xYkmm4qt+N3FRdoxLHH+3tZZsVcaMzU89l+/BA8vDBk49tteAwbzIEHPrKOf/0kiERh7vCiga2uplYjvlBZDHqnfJ9I1+oyrdsiQyeGsMnDD/fA/mYTal+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPRpAVlv0j6EuthApOy3r9m24sfbGeZ3VShDEECtjeY=;
 b=C3w4w8e10X1xko7RasAfxDlxDQjSlq5ILiVkIfus+BvN7DGeGG3TVHXSns7q6StUGd5DeyTyita/hlw6bNjdgHKLBizqyfRIaRjGZZM0AjKdiRfzJdqSDRDW9KGOCFT7TU8b+c9qDX2WugiDzdp0GlvuMf90y0jEmYgJahHDH5M=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5858.apcprd03.prod.outlook.com (2603:1096:4:142::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 07:15:41 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6792.026; Fri, 6 Oct 2023
 07:15:41 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v11 4/9] drm/mediatek: Add encoder_index interface for
 mtk_ddp_comp_funcs
Thread-Topic: [PATCH v11 4/9] drm/mediatek: Add encoder_index interface for
 mtk_ddp_comp_funcs
Thread-Index: AQHZ9mw/NyY62LReaUqm5D1KavECPrA8XPoA
Date:   Fri, 6 Oct 2023 07:15:41 +0000
Message-ID: <e1f306995937bf1fdbcee8d4d0875062d21cffa0.camel@mediatek.com>
References: <20231004024013.18956-1-jason-jh.lin@mediatek.com>
         <20231004024013.18956-5-jason-jh.lin@mediatek.com>
In-Reply-To: <20231004024013.18956-5-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5858:EE_
x-ms-office365-filtering-correlation-id: b2a55a01-68c8-401d-eea5-08dbc63c0c5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JsrJY2u5mJwddpUSXuLHQxE/XjYDWc1qsNpDf2A2SyKaFol/Zx5n9saEDcOkuJ9R0rmLHdV7ASGEJtvVWRd0PurI2RtO1eFfzAr7UwQP03QU83xOV28WBLY9o0NCRCRMhBBC3kSBJI7wtZ8luKp5RbwMV2J/obeFur8G62P0zqch+NtXz+UNmBxhKitZAii8PEHijkGWOt14V/vXPIiQmiershDJk9b2GPWVYVuTfMM6wvO2B9uX3m1DwYr/qxqK9HDtfFiqNjcIhq8crQY/c62Um8v/ibnGLG61fTNjCnj0U8Lqpq00AH5Sa4f6Q0nYkg6uJvdFBjpQlraWkVN7zpjx36GtFVtDNNaE4U6lkpBhfa4VC8BjlWlsYVzOgNCi3/AVuGTBWYN10oMWs+E+bAlYxXRmTlI7Il6XRhEAt3HMntuETnBipgsc4Bm1sle21gQRC9k1N+rQVfih4Q+rpNE1ljkj2JHFhJuTwoIy3zJvrEo99wLKLKVDZZZS0OL5kZwfJXe0AMagLpReXadUnhUvxdHfq8Dm762dHzaBjTuoI3r4NJfLDfbUiIDw+ANyPQIUul0lVuYHXl4CWtZnnEuzy0IEgtv+n4yqGOYLjYebULBOYa0kK+hxudEHDCMXiG4RsiiWyGB1wmnTosWTos9Loz+vyDjAq0j+J5kMvIk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(71200400001)(26005)(6486002)(6506007)(6512007)(478600001)(110136005)(76116006)(316002)(4326008)(41300700001)(8936002)(66946007)(66446008)(8676002)(64756008)(66556008)(66476007)(2616005)(54906003)(5660300002)(122000001)(2906002)(38070700005)(38100700002)(36756003)(85182001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3dINkUzL2hwdS9XQXZwQXNnSWo4a0lHVUpCNk5SUjJYNEVnQVlacFY1SDE2?=
 =?utf-8?B?Nm9HSysydGFXUWdyd0lZOFJYaTVHSkxsbVUrNzVyV1BXRWtrc2FkbEZoY0cr?=
 =?utf-8?B?dDBYUm9nNTVlWlIzYSs5VnpQZjVCTXMvamNvZ0F2SkZrMmNzVTVpVFhTY0VQ?=
 =?utf-8?B?SGoyc2tNMHBKTEZpUCsvcXE2MTE5NitWVm1NL2pWcHB3eFNBK3FudG5VK3lB?=
 =?utf-8?B?UHhxVi9hQzRFbkFBNDJadVh0Uno4b3grTElzQm02OGRkcC9rYnNjWEdyM0li?=
 =?utf-8?B?SlFvUEdkNWRLL2owdlc0VmE0M3RLeGMxc2ExempOSEdlSFFlNkt5VWVvNlVv?=
 =?utf-8?B?QlJINmJVdGd6dXJ3NFEwRDM1RXFwMFN2bmx3ZEZYdkZKSGdyZ1IwdHMyWWNG?=
 =?utf-8?B?SS9GZlBBY2FLT2pqQjVDNGpCYVU2eDM2NG1LNlgrT3NjWmZkTXY1aWtuZzNn?=
 =?utf-8?B?UDFHeWNJaFRZT0VCa01vd2JFMUU1MDFFMm50TE9ocmpNS1JwMy9TNmtNdThm?=
 =?utf-8?B?MUwwWGJrWXlvRnN6KytUUm5Ba1VHcHB4UEFLYlFmOEFNMmxWVzlnNVlYeHJV?=
 =?utf-8?B?dDBzSnpaOG9lVmxhQnBNQnpLTGN6UjdwNUlFY1FtZitWRHpNdnllSXh6VGVL?=
 =?utf-8?B?MUNsNkhKaXhzcnlVNXJiRVFZU0xaM3hoOUdrVWQ3M3NPNXFFcHlMR2Z1YkpZ?=
 =?utf-8?B?TmZ0MUtVS3JVOGlRSGhNU055NGc4UFdZdk9hY2U4a0xHLzJxK0pPVjNTYlln?=
 =?utf-8?B?aE5uVFUwUHFKQitLajJIRmVmMmkyVzR3cGQycVhIV3FaYXM1MUFaL0MvNjJu?=
 =?utf-8?B?UkNMcjRrcEpFeUYzV25SSzM2bE1DN21xeHpwNzlqQ25tM2kwaDhIRktveEQ1?=
 =?utf-8?B?TnRvVE1uREhxNkdqVVBaWDRUYzFVSmptczZ4cU93bllicDQ4T2tVRHJ4OEZv?=
 =?utf-8?B?Z0dyTy91UUdJZHNqTE02Q1dNSEtLZzBXaGNOT1UwMFMzTHhEc000TmhicEll?=
 =?utf-8?B?dlVkRHE5UElvUEc5QkxnbWFuUW5YbVlrSWg2d1FDbC9TRHE5dHY5Q2xWUFRi?=
 =?utf-8?B?RVRnWlREbjBHbml6bzBsMjVMK2FSTUdVNzd6ME9mN3o2WVBHVDhPL2RYbnl2?=
 =?utf-8?B?VUpwTXZKbmVYeERuU0FaMVFJY2dRSU1FT1k4MHdpak1sS0hnYXdZVjB3aits?=
 =?utf-8?B?NDFSRGJzWWJuS3h0dVpacHlmSnNsT3FkNWNvSldyZDBOUTBMUG9iKzdSTlhE?=
 =?utf-8?B?N0gwajRQNW1vQmtsRUVaZlBBcWlyNGRpWjNremVBWC9NOHNqRjlVY1NWcnJu?=
 =?utf-8?B?RkNMTzdENlFZSVdSSzVMaUNzcmI5K09hL3lvZEJrejd6c09vRjh1TTlCV3Zm?=
 =?utf-8?B?TkdZenZmMFlUQ0dzTHJiOEcwY25CUkQrdDRncEpSTHBhZWQrY3l2UlJjbUVK?=
 =?utf-8?B?KzZSb2Q0QVZHd2ZxdmFUV1NtL0J1RDNMWlpoQlF1d2Y3KysxSmppTkpjZHpl?=
 =?utf-8?B?bGNPcHdqazdUdW9HS2tKdjBrQWNFelNocFZ6NlRXRzVLV2hlL25nNXN1YzEz?=
 =?utf-8?B?N2x6ZW83SWZlUmI0eWVuODQ0Z1YvNFprWUphUzFrKy80YU0zUlE0UFRTeFRa?=
 =?utf-8?B?b0ZxUmgzdVhXU0U1dUxwdVVyR1hwbGQ2WlgyNGRVRXFaK3NBNUJUOFNUUEhE?=
 =?utf-8?B?SXZvdkgxUCsxR3A0NEZBOStJWVJZZXpsTURhUzdiQ3JvczZwbmQzU3dqRS8r?=
 =?utf-8?B?OC9QMnVDNWxONTdPd1hpQ01jRG04bTdmUmkyT2VLNzdWN3NtTzh4ZmUweU9l?=
 =?utf-8?B?NGxwcnZYQXUvbUxqUUttOVFtdkhzNHVrNzRpaVJndUVhdXk3K09TNUUwcXpl?=
 =?utf-8?B?d0tDMWJUTHh0akY5UEd3ZkVVOE1hTUl1STBsL1JlMkpqWlJDU0dxN1VNb3ds?=
 =?utf-8?B?YnVpSUVhT3BDYkE1UGNHZnhodFFDMUxSNXM4d21YNlZwdlNLdUJKd1BGempa?=
 =?utf-8?B?dlJBSXB1TlhrblF0bEtSYUorajRUM2d5Kyt6R0NkejJKL0hIcTBwSzMwbjRX?=
 =?utf-8?B?OFc1b2dLR09KOHVVOHJ2clMxeDd3ZGJrNElWZEhOTVBudWMxcjJ5ZVFCM2V3?=
 =?utf-8?Q?XOtLI5KjsmqdVMhla7NRj73k6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA6509FDB96FE347B409325D5B0C602C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a55a01-68c8-401d-eea5-08dbc63c0c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 07:15:41.0689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 309rGR4YxLwE7253X4EP2cqvlFK8g7fqMFx7Z5rS3Q5faK9Ih7Tzi8xlFdY5/y5WkzTl0VBteImurgxPCjCnFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBXZWQsIDIwMjMtMTAtMDQgYXQgMTA6NDAgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVG8gc3VwcG9ydCBkeW5hbWljIGNvbm5lY3RvciBzZWxlY3Rpb24gZnVu
Y3Rpb24sIGVhY2ggZGRwX2NvbXAgbmVlZA0KPiB0bw0KPiBnZXQgdGhlaXIgZW5jb2Rlcl9pbmRl
eCB0byBpZGVudGlmeSB3aGljaCBjb25uZWN0b3Igc2hvdWxkIGJlDQo+IHNlbGVjdGVkLg0KPiAN
Cj4gQWRkIGVuY29kZXJfaW5kZXggaW50ZXJmYWNlIGZvciBtdGtfZGRwX2NvbXBfZnVuY3MgdG8g
Z2V0IHRoZSBlbmNvZGVyDQo+IGlkZW50aWZpZXIgYnkgZHJtX2VuY29kZXJfaW5kZXgoKS4NCj4g
VGhlbiBkcm0gZHJpdmVyIHdpbGwgY2FsbCBtdGtfZGRwX2NvbXBfZW5jb2Rlcl9pbmRleF9zZXQo
KSB0byBzdG9yZQ0KPiB0aGUNCj4gZW5jb2Rlcl9pbmRleCB0byBlYWNoIGRkcF9jb21wIGluIGNv
bm5lY3RvciByb3V0ZXMuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29t
Pg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRp
YXRlay5jb20+DQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+
IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oIHwgOCArKysrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+IGluZGV4IGZlYmNhZWVmMTZhMS4uMDc5
N2IzYWM3NWQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kZHBfY29tcC5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cF9jb21wLmgNCj4gQEAgLTgwLDEyICs4MCwxNCBAQCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNz
IHsNCj4gIAl2b2lkICgqZGlzY29ubmVjdCkoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2
aWNlDQo+ICptbXN5c19kZXYsIHVuc2lnbmVkIGludCBuZXh0KTsNCj4gIAl2b2lkICgqYWRkKShz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtdGtfbXV0ZXggKm11dGV4KTsNCj4gIAl2b2lkICgq
cmVtb3ZlKShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtdGtfbXV0ZXggKm11dGV4KTsNCj4g
Kwl1bnNpZ25lZCBpbnQgKCplbmNvZGVyX2luZGV4KShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAg
fTsNCj4gIA0KPiAgc3RydWN0IG10a19kZHBfY29tcCB7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2
Ow0KPiAgCWludCBpcnE7DQo+ICAJdW5zaWduZWQgaW50IGlkOw0KPiArCWludCBlbmNvZGVyX2lu
ZGV4Ow0KPiAgCWNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgKmZ1bmNzOw0KPiAgfTsN
Cj4gIA0KPiBAQCAtMjc1LDYgKzI3NywxMiBAQCBzdGF0aWMgaW5saW5lIGJvb2wNCj4gbXRrX2Rk
cF9jb21wX2Rpc2Nvbm5lY3Qoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgc3RydWN0IGRldg0K
PiAgCXJldHVybiBmYWxzZTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGlubGluZSB2b2lkIG10a19k
ZHBfY29tcF9lbmNvZGVyX2luZGV4X3NldChzdHJ1Y3QNCj4gbXRrX2RkcF9jb21wICpjb21wKQ0K
PiArew0KPiArCWlmIChjb21wLT5mdW5jcyAmJiBjb21wLT5mdW5jcy0+ZW5jb2Rlcl9pbmRleCkN
Cj4gKwkJY29tcC0+ZW5jb2Rlcl9pbmRleCA9IChpbnQpY29tcC0+ZnVuY3MtDQo+ID5lbmNvZGVy
X2luZGV4KGNvbXAtPmRldik7DQo+ICt9DQo+ICsNCj4gIGludCBtdGtfZGRwX2NvbXBfZ2V0X2lk
KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSwNCj4gIAkJCWVudW0gbXRrX2RkcF9jb21wX3R5cGUg
Y29tcF90eXBlKTsNCj4gIHVuc2lnbmVkIGludCBtdGtfZHJtX2ZpbmRfcG9zc2libGVfY3J0Y19i
eV9jb21wKHN0cnVjdCBkcm1fZGV2aWNlDQo+ICpkcm0sDQo=
