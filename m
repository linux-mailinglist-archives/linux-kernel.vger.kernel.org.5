Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D18B75316D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjGNFp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjGNFpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:45:25 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA16A211C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:45:16 -0700 (PDT)
X-UUID: 98f2fc3e220911eeb20a276fd37b9834-20230714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ogDVfwsrH55FK7+Sf+FmSRJ3fQg/yFnI90LaXuLBRWg=;
        b=LQvg0Ep4TfaSTnyVwK2O2TVu2TiVDaL+I0DtdxPPDm3ZoHW6dbhcCb76ru51rxI4ySN93kb8vKMHeTgk3SIiUfrsxMnVyIWVWJQ6EC4CtBrdjndzjzc8y45r/s160pCmNRfSk6b6ZAEQLuUtg2M+kMVIfLB/R+/Cj4EBPH7aIEk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:5618f20e-f978-407e-8ef3-9f02d2d759d4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:e2309c87-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 98f2fc3e220911eeb20a276fd37b9834-20230714
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1188307910; Fri, 14 Jul 2023 13:45:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jul 2023 13:45:09 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jul 2023 13:45:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyRCNpC57k4SwWaA/XG/XluswNYuGgZ1RcpJTXQGDArkE+bgSORgiRhAFp9QbMcquIIpch/T9RQgG1cU4t//ehNWjhMm7vmbK0U5Koo+JZ1JDdFdf4/cOZ/dAA8nBLck+p5qEqCp8kU142dLOXBmLvXKJpBJxcfwHRv3+AE9HbMqIA0gpid1Ny/0BW/s/kU13WvDtv3nlbN4w0TSLCUmHqJ+oAHSEN+j/9B8Ew+uRVpW0nhC96SDIEqopwlX2iahdU2bP2tkqFe55aKITI2LIukoSfHLHHCwNn0ySDMqrSlgK50p9r9RB8RnHf3kuscE0TubNgH+ZsFVpEZxorxRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogDVfwsrH55FK7+Sf+FmSRJ3fQg/yFnI90LaXuLBRWg=;
 b=KfAllkBhpffo6l+BBO8EZgLvIIbtodgii4fpP4a9wDNa+hwnhcgCStUZrdzDCxqgG/XuN8/G7euXIDbZkPvLRHoi60Iz+1C6togILOwcZYpmerjDx3vZpFNcrHbwNunRLDJNnlWF+V+it8q0R/reJCXTAwCqq5sTfDurZ/ksgwSCWZ5bTZzRw7/0V/8b2G7QSva2xSQJ3KgTmtcxoj5kockwdXt8SRSAZAkIUtC+wcnlRpfUdxXQYMtOJvQVkwDaLc7zp92QNx/OT0E9UiMcDeWO7WLOHX7RKES6qyoN1h2O8t8egixEg3u5k2xLJViy3NsuFEjDdLTzN/gwaqgn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogDVfwsrH55FK7+Sf+FmSRJ3fQg/yFnI90LaXuLBRWg=;
 b=bDro3RhBVFa99ig3/SdfVq5hgeKtwu6X1gSgI6VbK/CaWkSU2k48QIYRtx3dolbQOUi3+hkGCfbFo9R5Wf8pf4QzoJpkksJgR+BzvUqMPl+mYcYHKXyZ440eB0qxgnNUauzLPfGxwkV5Vtdob5VOJliZ96ukNm12CQjEFlmW5FQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB5850.apcprd03.prod.outlook.com (2603:1096:301:a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 05:45:07 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%7]) with mapi id 15.20.6588.022; Fri, 14 Jul 2023
 05:45:07 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
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
Subject: Re: [PATCH v3 3/4] drm/mediatek: Add casting before assign
Thread-Topic: [PATCH v3 3/4] drm/mediatek: Add casting before assign
Thread-Index: AQHZpCqUTKrrJEuKWkqGiyyqHs8U06+45FoA
Date:   Fri, 14 Jul 2023 05:45:07 +0000
Message-ID: <f8a838524f0ce324495fcf2994488d76768cae2f.camel@mediatek.com>
References: <20230621102247.10116-1-jason-jh.lin@mediatek.com>
         <20230621102247.10116-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20230621102247.10116-4-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB5850:EE_
x-ms-office365-filtering-correlation-id: 4d01fd94-4e69-4312-eeea-08db842d7aee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yv811l2GOHBeuH3AUboWPMQqAa76aYduWYIpNzwq2/QDWrJDVk2GZsPkaN5iE7W6U+R0apAuPwaAm4CaeIpFGfhspYo6LXUqFwGuXHjFgtBU52YCJnCZqIOAw4lH1rDnrJsZAKj6PdtG3TRTZ0QYy88J4dX2TqArt3iScIhocY+5S5uVqg+3smCy+9a8Cd5xQ5I65wXRuCiqokR6HvCFs4+aAAeLwfkZ63nUwfIldsJnItvr1zD3vQ8QFXNrLbbasDVFk6cX/hdmcHzB32i2UGsHelqSZvaT4B1yuxTjagEUfMLw3VajxHHvpV4Df9M24QlnqAAnTTvWf1xRU72uKpe4Ppq6r2vBJ5fBHCf9rY+7/mTu/6uOtuY/cNjbbGkgMoioeTk44u3HUOaCexri639nGQBcunq9BmjxvLYrT+Ne47QuJxoSwk+I9ZzxfDuQifxZ90ErOutjfe2DhDD13lU6VnGjAMyZ9usrq2l+QncvBSoBilNxZp6JcWEGSL4a9jWlKfKvzir9T3muhwTv11D0eAMTPfDTvFZ8NnnIfpBgNVbvATkw3wK09d/N+HUaGxclXD2Nyl8NgXA4wM/SrWFmBbLwvq7e70K5nehNUvNWPXS7q4+KICDS+NJKN24a2GwrTUO1cUxz+a68zEMe6rqBu2IBacDIQebyJ3OsTtqBtpNjiJjKHs2N+9fe4NAP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(6512007)(6486002)(71200400001)(83380400001)(186003)(2616005)(85182001)(36756003)(122000001)(38100700002)(38070700005)(86362001)(26005)(6506007)(66476007)(66446008)(64756008)(76116006)(4326008)(66946007)(66556008)(54906003)(110136005)(41300700001)(5660300002)(316002)(8936002)(8676002)(2906002)(478600001)(266184004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm9rSWY1NThZUktnN2hTSFc0ZFIyVm1OSlZEY3hMcklpY2ZxSU0rVXNDb2M4?=
 =?utf-8?B?eExwRmxJdEkxc3pKekJUNSt3V2FOaFI0TkRiYTVQZVlaOFRUbXlVK0xUemVa?=
 =?utf-8?B?dzRjRm1kUndEb2laL0tjcDdWMjR5V29CUERSWWtxcU8rTnZZdjRwbjgrU05T?=
 =?utf-8?B?QUZBQnJ3aCs2SkFuNHc2SUd6YUJKMDNWa2hRdEhub0RMYWtJWXpxOTVlZHov?=
 =?utf-8?B?TXlxQytXZ0svWE1iazdSM01reVBXbUFyNDloUWQvdEZUNlJweXNDNmh5Uk5M?=
 =?utf-8?B?dms3d0xSdlNPbDhxMWFiWmN0dWNEcHFDTW8xUHhFZHc3NVVjU3R5b0ZlZVhU?=
 =?utf-8?B?UWQxb1Bzc0w1cDV4eC8xSSt2QVI2VFNVUTM5NUx0NnRySmdjYlBrTkNWdlU4?=
 =?utf-8?B?cU8rVmxYSGh4K2htTnlwN0dhS2hpa2tkWDVOcTA4V2xHV21QVHhTL1l2NGFm?=
 =?utf-8?B?SVlwOVFBbExUdWNON0lOSFN3VGpRODV2SGphWTF3d0xvdzYvdDBEOEJIaXhq?=
 =?utf-8?B?L3pyMm5kcFNvWDdWSFYwaE5OS3dKR0V3NjNiejJkRkNwYW1tOVZFZXFkZ2tJ?=
 =?utf-8?B?eDVYd3B5bnNCZWREaWh5MTRkejZNTjhBZmgyTlJ0Skp5c0xiTHFWa21IL3No?=
 =?utf-8?B?TGV3S011V3N2U1FMbXpyakdrMTRXcXd5Q2ZuM3RXakJqTFZvcld0KzNJL3k1?=
 =?utf-8?B?VlFMMDIxMFc2SFhBWmwyMXFnQ0NRSVNJcVZmNWExaitSQXV6d3J2d1huR3lt?=
 =?utf-8?B?R3g4T2plclZpbnVQNXBOT0hDV2ZLb1IzelIvTkplUXkvZWJEVk1jL2daVjBB?=
 =?utf-8?B?alhHUUp6Umc3ZEpMUFYvdndGRURmQ3pRYXVYYkQ1U05DY2txdVUrR0VpZW5u?=
 =?utf-8?B?Wk1zeVZ2TjRZbmZqaUE3NlpsL1ZGT1R4QXJjSjdQVXpycG51K2xxZkpHdHVH?=
 =?utf-8?B?VUsvdFJpZ2xUempKSzdiZnZzSTN0SWVCV2JYcjdLNGpnMCtYNUVRTFNSYktq?=
 =?utf-8?B?UWJTd0E3SG5oazJaWE96SHRCakh4djJNT3U0YkYzWld0T1BZSkdxYUNxZ1RW?=
 =?utf-8?B?N3ZnNVJwZy9QSktwQmtrZEQvSUVyZEFiSlZQV1NJOHZTM3NqWGFDOG1XY1Ew?=
 =?utf-8?B?TnNLbGJpN0x4cVlzYWJCNGlhdjVnNWliL1RLZmtYYWo5ejhtUENrVmF5MDJH?=
 =?utf-8?B?MExFSFhnQm96R0wxQ2l0bDY3ZVU1bFNBYUxEdFdmZDhOUUttVnZMRzZBQnQw?=
 =?utf-8?B?Y0p6dUc1bnhaaTUxVzVlcDN4T1lHaG12NlhDa2YyMnJxMC9iY1hhdmdCWTBn?=
 =?utf-8?B?c2EraVo4UGc3Q0xUZjcyV1FxdUVvQmRjZG11dEdOMzc5aUlidDZIdXc2TTFG?=
 =?utf-8?B?Y3d5eDd1RU1BSWVVU012aTZ5QXNVRCswRThreG5TN1g2RmF5bER4eWZvQ294?=
 =?utf-8?B?ZjNVVTdnRnFuN1U5Q3Q1c1VxUDFLNVZmN0pJNk1jcWo0S1RtNjRCZTl3Q2Jz?=
 =?utf-8?B?aWhaZVpnUnZMWWVDWHh4eTR1KzNNems1WEJMVWVPdTRpVnl5WnRTQjk4WnhL?=
 =?utf-8?B?R1RDWndJa3dGNjZYZ0o1K1BUZ3RyY0gzbTBubmV6Z2Iwbm1mcEVuZWhtcGR3?=
 =?utf-8?B?WEswMWhObktUNkVvc0hFVHU1YUJ3YUhhUFFaRXpQSnNqOVFvMC9PcGQ4RU5T?=
 =?utf-8?B?QmdYOElaVnNTM3FaUjVkckJYc2F3VXR3VzhIdlVJOEhUZ1ZwaFlFcDVEY0hT?=
 =?utf-8?B?RHR5ZFFPWUNKanlDSnNtWmdYaWRTQ0lFaTlubjRUVGJSZC9EY08zdmdXQVZ6?=
 =?utf-8?B?Y1Q4NlNYOURKdHp4cThWQmJjc2NKWG04WjZremNjNkFiQWpyTURyQ21kRHVY?=
 =?utf-8?B?c20rZEN4SzVjS3g1Si9QWWR6VHVqVitWYlV0aldPbzJ5cSsxekdlRTNCOE5E?=
 =?utf-8?B?Y0R1dDQwaUF3MHBManUvTG5NQWhGTWlKZ3dEN1NBN0VrY21SOUpQeGhxYVIv?=
 =?utf-8?B?UUdGcjV3VXgrTmFOWWZMbkNtSGhkUjFHN1M3VDVDYURXRzFRY1gzRG9rbmpI?=
 =?utf-8?B?NTVWVnFJVjJwc0kzN0ppMGpGSmNjUERNUWlMOHYrcTJsWGxPM3NaSE1NZHZR?=
 =?utf-8?Q?P8pIG6DErmIVdBul733rAjdqX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB9D9220CBA5D440B9C886384D327E8A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d01fd94-4e69-4312-eeea-08db842d7aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 05:45:07.3428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSSduoixsWetGQFw0Rnunmb/RM/qFBMF8wW2G/XUIjUzYWyHVMWTAi6cHbfm5b5GMFxEKT766+TCrTXLMPkp8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5850
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBXZWQsIDIwMjMtMDYtMjEgYXQgMTg6MjIgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gMS4gQWRkIGNhc3RpbmcgYmVmb3JlIGFzc2lnbiB0byBhdm9pZCB0aGUg
dW5pbnRlbnRpb25hbCBpbnRlZ2VyDQo+ICAgIG92ZXJmbG93IG9yIHVuaW50ZW5kZWQgc2lnbiBl
eHRlbnNpb24uDQo+IDIuIEFkZCBhIGludCB2YXJyaWFibGUgZm9yIG11bHRpcGxpZXIgY2FsY3Vs
YXRpb24gaW5zdGVhZCBvZg0KPiBjYWxjdWxhdGluZw0KPiAgICBkaWZmZXJlbnQgdHlwZXMgbXVs
dGlwbGllciB3aXRoIGRtYV9hZGRyX3QgdmFycmlhYmxlIGRpcmVjdGx5Lg0KDQpJIGFncmVlIHdp
dGggdGhlc2UgbW9kaWZpY2F0aW9uLCBidXQgdGhlIHRpdGxlIGRvZXMgbm90IG1hdGNoIHRoZQ0K
bW9kaWZpY2F0aW9uLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gRml4ZXM6IDFhNjRhN2FmZjhk
YSAoImRybS9tZWRpYXRlazogRml4IGN1cnNvciBwbGFuZSBubyB1cGRhdGUiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMgICB8ICAzICsrLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYyB8IDIyICsrKysrKysrKysr
KystLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZ2VtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0K
PiBpbmRleCBhMjViMjhkM2VlOTAuLmRhMDg3ZDc0NjEyZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gQEAgLTEyMSw3ICsxMjEsOCBAQCBpbnQgbXRrX2Ry
bV9nZW1fZHVtYl9jcmVhdGUoc3RydWN0IGRybV9maWxlDQo+ICpmaWxlX3ByaXYsIHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsDQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCWFyZ3MtPnBpdGNoID0gRElW
X1JPVU5EX1VQKGFyZ3MtPndpZHRoICogYXJncy0+YnBwLCA4KTsNCj4gLQlhcmdzLT5zaXplID0g
YXJncy0+cGl0Y2ggKiBhcmdzLT5oZWlnaHQ7DQo+ICsJYXJncy0+c2l6ZSA9IGFyZ3MtPnBpdGNo
Ow0KPiArCWFyZ3MtPnNpemUgKj0gYXJncy0+aGVpZ2h0Ow0KPiAgDQo+ICAJbXRrX2dlbSA9IG10
a19kcm1fZ2VtX2NyZWF0ZShkZXYsIGFyZ3MtPnNpemUsIGZhbHNlKTsNCj4gIAlpZiAoSVNfRVJS
KG10a19nZW0pKQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fcGxhbmUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMN
Cj4gaW5kZXggMzFmOTQyMGFmZjZmLi4xY2Q0MTQ1NGQ1NDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiBAQCAtMTQ1LDYgKzE0NSw3IEBAIHN0YXRp
YyB2b2lkIG10a19wbGFuZV91cGRhdGVfbmV3X3N0YXRlKHN0cnVjdA0KPiBkcm1fcGxhbmVfc3Rh
dGUgKm5ld19zdGF0ZSwNCj4gIAlkbWFfYWRkcl90IGFkZHI7DQo+ICAJZG1hX2FkZHJfdCBoZHJf
YWRkciA9IDA7DQo+ICAJdW5zaWduZWQgaW50IGhkcl9waXRjaCA9IDA7DQo+ICsJaW50IG9mZnNl
dDsNCj4gIA0KPiAgCWdlbSA9IGZiLT5vYmpbMF07DQo+ICAJbXRrX2dlbSA9IHRvX210a19nZW1f
b2JqKGdlbSk7DQo+IEBAIC0xNTQsOCArMTU1LDEwIEBAIHN0YXRpYyB2b2lkIG10a19wbGFuZV91
cGRhdGVfbmV3X3N0YXRlKHN0cnVjdA0KPiBkcm1fcGxhbmVfc3RhdGUgKm5ld19zdGF0ZSwNCj4g
IAltb2RpZmllciA9IGZiLT5tb2RpZmllcjsNCj4gIA0KPiAgCWlmIChtb2RpZmllciA9PSBEUk1f
Rk9STUFUX01PRF9MSU5FQVIpIHsNCj4gLQkJYWRkciArPSAobmV3X3N0YXRlLT5zcmMueDEgPj4g
MTYpICogZmItPmZvcm1hdC0+Y3BwWzBdOw0KPiAtCQlhZGRyICs9IChuZXdfc3RhdGUtPnNyYy55
MSA+PiAxNikgKiBwaXRjaDsNCj4gKwkJb2Zmc2V0ID0gKG5ld19zdGF0ZS0+c3JjLngxID4+IDE2
KSAqIGZiLT5mb3JtYXQtDQo+ID5jcHBbMF07DQo+ICsJCWFkZHIgKz0gb2Zmc2V0Ow0KPiArCQlv
ZmZzZXQgPSAobmV3X3N0YXRlLT5zcmMueTEgPj4gMTYpICogcGl0Y2g7DQo+ICsJCWFkZHIgKz0g
b2Zmc2V0Ow0KPiAgCX0gZWxzZSB7DQo+ICAJCWludCB3aWR0aF9pbl9ibG9ja3MgPSBBTElHTihm
Yi0+d2lkdGgsDQo+IEFGQkNfREFUQV9CTE9DS19XSURUSCkNCj4gIAkJCQkgICAgICAvIEFGQkNf
REFUQV9CTE9DS19XSURUSDsNCj4gQEAgLTE2MywyMSArMTY2LDIyIEBAIHN0YXRpYyB2b2lkIG10
a19wbGFuZV91cGRhdGVfbmV3X3N0YXRlKHN0cnVjdA0KPiBkcm1fcGxhbmVfc3RhdGUgKm5ld19z
dGF0ZSwNCj4gIAkJCQkgICAgICAgLyBBRkJDX0RBVEFfQkxPQ0tfSEVJR0hUOw0KPiAgCQlpbnQg
eF9vZmZzZXRfaW5fYmxvY2tzID0gKG5ld19zdGF0ZS0+c3JjLngxID4+IDE2KSAvDQo+IEFGQkNf
REFUQV9CTE9DS19XSURUSDsNCj4gIAkJaW50IHlfb2Zmc2V0X2luX2Jsb2NrcyA9IChuZXdfc3Rh
dGUtPnNyYy55MSA+PiAxNikgLw0KPiBBRkJDX0RBVEFfQkxPQ0tfSEVJR0hUOw0KPiAtCQlpbnQg
aGRyX3NpemU7DQo+ICsJCWludCBoZHJfc2l6ZSwgaGRyX29mZnNldDsNCj4gIA0KPiAgCQloZHJf
cGl0Y2ggPSB3aWR0aF9pbl9ibG9ja3MgKiBBRkJDX0hFQURFUl9CTE9DS19TSVpFOw0KPiAgCQlw
aXRjaCA9IHdpZHRoX2luX2Jsb2NrcyAqIEFGQkNfREFUQV9CTE9DS19XSURUSCAqDQo+ICAJCQlB
RkJDX0RBVEFfQkxPQ0tfSEVJR0hUICogZmItPmZvcm1hdC0+Y3BwWzBdOw0KPiAgDQo+ICAJCWhk
cl9zaXplID0gQUxJR04oaGRyX3BpdGNoICogaGVpZ2h0X2luX2Jsb2NrcywNCj4gQUZCQ19IRUFE
RVJfQUxJR05NRU5UKTsNCj4gKwkJaGRyX29mZnNldCA9IGhkcl9waXRjaCAqIHlfb2Zmc2V0X2lu
X2Jsb2NrcyArDQo+ICsJCQlBRkJDX0hFQURFUl9CTE9DS19TSVpFICogeF9vZmZzZXRfaW5fYmxv
Y2tzOw0KPiArCQloZHJfYWRkciA9IGFkZHIgKyBoZHJfb2Zmc2V0Ow0KPiAgDQo+IC0JCWhkcl9h
ZGRyID0gYWRkciArIGhkcl9waXRjaCAqIHlfb2Zmc2V0X2luX2Jsb2NrcyArDQo+IC0JCQkgICBB
RkJDX0hFQURFUl9CTE9DS19TSVpFICogeF9vZmZzZXRfaW5fYmxvY2tzOw0KPiAgCQkvKiBUaGUg
ZGF0YSBwbGFuZSBpcyBvZmZzZXQgYnkgMSBhZGRpdGlvbmFsIGJsb2NrLiAqLw0KPiAtCQlhZGRy
ID0gYWRkciArIGhkcl9zaXplICsNCj4gLQkJICAgICAgIHBpdGNoICogeV9vZmZzZXRfaW5fYmxv
Y2tzICsNCj4gLQkJICAgICAgIEFGQkNfREFUQV9CTE9DS19XSURUSCAqIEFGQkNfREFUQV9CTE9D
S19IRUlHSFQgKg0KPiAtCQkgICAgICAgZmItPmZvcm1hdC0+Y3BwWzBdICogKHhfb2Zmc2V0X2lu
X2Jsb2NrcyArIDEpOw0KPiArCQlvZmZzZXQgPSBwaXRjaCAqIHlfb2Zmc2V0X2luX2Jsb2NrcyAr
DQo+ICsJCQkgQUZCQ19EQVRBX0JMT0NLX1dJRFRIICogQUZCQ19EQVRBX0JMT0NLX0hFSUdIVA0K
PiAqDQo+ICsJCQkgZmItPmZvcm1hdC0+Y3BwWzBdICogKHhfb2Zmc2V0X2luX2Jsb2NrcyArIDEp
Ow0KPiArCQlhZGRyID0gYWRkciArIGhkcl9zaXplICsgb2Zmc2V0Ow0KPiAgCX0NCj4gIA0KPiAg
CW10a19wbGFuZV9zdGF0ZS0+cGVuZGluZy5lbmFibGUgPSB0cnVlOw0K
