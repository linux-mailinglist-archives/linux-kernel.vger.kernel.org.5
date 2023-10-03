Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57347B5EAD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 03:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbjJCB3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 21:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239039AbjJCB3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:29:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002349E;
        Mon,  2 Oct 2023 18:29:40 -0700 (PDT)
X-UUID: 4d27332a618c11ee8051498923ad61e6-20231003
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ShENZ1K2eRQhUHCB/xaqNFRxZ/3AfEjPYXRSHtZsi5o=;
        b=hSwVeipWGbyG0QKFnhMBjxLTnsHgt5MR/7tUgI+nhYgK62YtX/Sx5MZ/ZDKOGHiiPN2rvIVdoK7NV38JZur4Gac2nbgR7gtSbjlPq1V8rRA8QOQGnIg5VCHb9gEd7LmMZc4QzmTz23bQbRgyse0FCwK/5o89i2XFwNmKbUGxWOA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:1c7015b9-a4b4-4206-b770-702497a5c2ac,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:c5ab82bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4d27332a618c11ee8051498923ad61e6-20231003
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 212877799; Tue, 03 Oct 2023 09:29:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 3 Oct 2023 09:29:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 3 Oct 2023 09:29:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtpHSgtW0blSiN2JJeQvelQxt79eaMc3HcLppD9IszeeYZaOGKQdJpX7r/qIQ7lmMze+ZGdP9preoCrrDF+XKoYes5YJLBYRRcKdWuSCmlekf088apvQmiWGsCgqAvSSVW+8BxkcKBMl9CvdO+5vEPNuEzrpdPVY10nmbc4sTzlz+UPJBL+y/xH7lfHiQvVJv6QbMeunPSJ7i7+7nEcIgZdzqqXHrWZrqY2l7E7+1lsWtkLuLDW3vSb+ep/efgdRmUj/2J0GDKt0/OL8lCfL8dMR50HuchpbZa26lw8NPMQYdRmPULzVD/xyxTAF7Nv+GAvk82fF0FzLvuQqgILMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShENZ1K2eRQhUHCB/xaqNFRxZ/3AfEjPYXRSHtZsi5o=;
 b=REkNkzgyXvvPKTPPdyFbi2QOiV826qLyra2G/LfeU0OEh/M0Vqmh9GT70xWWoGWTyfU19AlB8HuFm4+t3gHgCo5dgQpVyBTAVffMhbQYM6MAL+xIff2ttMyM3giMH2SfBmXoNsgnGlSU9QtgKDgzqu3KTBf+8Etr+uJ3ykoWslUfV/iPv1oSbLcaypqqvi+ZGGRiQutBW16PQImKDwDEadmKCW1Edv1CyeDFjuL2HSCu+MY4fQfB6FlXPvg7k+D/GmKBegGdQWiTJ1L9EBzbKEAad9imoWdMG0om7wcgS80ebhw+2Ctv3zxt2sOM7kjsOx2IqjY7MgXPLc0w6gs6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShENZ1K2eRQhUHCB/xaqNFRxZ/3AfEjPYXRSHtZsi5o=;
 b=aA5DAyEeeg0isP/K94w8V9mkP4BF0rUJ14ApQBerGSXQWCbPR/kt1mpFJjVwngHOjkinR3E6Ei0xZWpInVESXSIAlH2+90Vww3LlAGW3andnb4SXORYOD6/N+r7A4/BflkoCKZ32gSsG7UNu5Ohapy3eZKjL6I24OJOOjt+otqs=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SEZPR03MB7443.apcprd03.prod.outlook.com (2603:1096:101:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 01:29:15 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b%3]) with mapi id 15.20.6792.026; Tue, 3 Oct 2023
 01:29:15 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [RESEND PATCH v6 17/20] drm/mediatek: Support MT8188 Padding in
 display driver
Thread-Topic: [RESEND PATCH v6 17/20] drm/mediatek: Support MT8188 Padding in
 display driver
Thread-Index: AQHZ5IO+b14cG19tBEeUoyKVCLRvfLAvqD2AgAAJhYCAAHEpAIAHRhYA
Date:   Tue, 3 Oct 2023 01:29:15 +0000
Message-ID: <a68dfc02b2a383c455c0025c8eafeffb51825aaa.camel@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
         <20230911074233.31556-18-shawn.sung@mediatek.com>
         <9fc58793d90b7a984dc3d40ac44719e9869b1202.camel@mediatek.com>
         <f28018229a5c0c232535da929e9d27cb7f649b7e.camel@mediatek.com>
         <5d1669c0-64c3-8a5d-6f4e-88f72d4b40b4@collabora.com>
In-Reply-To: <5d1669c0-64c3-8a5d-6f4e-88f72d4b40b4@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SEZPR03MB7443:EE_
x-ms-office365-filtering-correlation-id: 442b315a-657f-4ddf-ebb8-08dbc3b027bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qK9fJUJypKhTjo70SIOlpopJyaE/diKYB8C7nF30eIkmym7z1ThxCjO83CYzoXvEREUXcW56Clv9gGjzmVFPgrIZFqutlZsHkJjtZsfhpcKSQz1c8votMkLWG1F0YDNpN1BSvNntw+HXG9Qgzpf8sk+SrP8o2EIhOFuzy6Jc/jhtlmrthQTC4ZL/XnloplJVE/rphv7gYJ4utbYfADV66ji4fa2W2pJ300oJVaAZnBsolhHEMqWIXyb9waUOD+sdfpyYxKwBlOeqluVj+y9wIpAFjZj4V1UBONY8l5E0dXg3ivVNNtInYjhncYl5PzWS4kLSgXbCfcOKTVyUTlk+Sj1vhfs+UZSaqDWHxfekTpG7ZeEqchrw1IOHJyahv0KfqOVM3L1ZsXKnUFbVHys5qsxXjwmpQ2SbE2UZnBrf8JrDKDx7cYTePXsEAmVzzmOW8L6xuiie30BAkVYgXqDDeoK+Nokg8Gk6m3cauElViZxCbtZv21ZmFtNmwI2a1wdMSue5yfOBl2GTxjNqMXN+97NINCUrWcOklfYmJWa1rwpTZXkX1N/iUAuhFAA2vGQiNIDUBiNKOg4cHbvEKOEEQK401E2OgnxYt7UPxFGUZsR7IxoHA2cVpuybDQkIObTruPyySmCexSmCUYGJApslfeM0H2bSZ75EsZ61N8VBMQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(83380400001)(86362001)(76116006)(66946007)(66556008)(110136005)(5660300002)(7416002)(2616005)(26005)(122000001)(2906002)(6512007)(6506007)(71200400001)(38070700005)(38100700002)(6486002)(478600001)(36756003)(85182001)(4326008)(8936002)(54906003)(66476007)(66446008)(64756008)(66899024)(316002)(41300700001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHF5ZjcrdE0vTC96TVBES0VJNmo3M1JuMEVxVm9RSjFpdUlmZlpHTk9vZXh1?=
 =?utf-8?B?VXFmZi93bU9tdzRjTDVISjJHVWUzMkM4eFAxa2tuTnRScEJheVhzc0NlRkFM?=
 =?utf-8?B?aW4wRnlVSG92MzNQbVFMWGN3dnR0WHJaNHk5THFnbXpiU0Rza0haUEhNVWs3?=
 =?utf-8?B?V28ySzBnUVJweGdMR2RiUEg4QUlWeGtsY2VHMm1YTFVnSVE2RmlyRHFRMUJ3?=
 =?utf-8?B?UWM4Q3J0VFdJamNtbElCY2lPb0lady83Vm9uRS9Fa2NiY3dzZVNNSlE5R3JW?=
 =?utf-8?B?WGh3Tk9TSGs1OWQ3THJ2OHVyR1l0RndqR1hzNmZ3UWMxam51REgwekVvUU0z?=
 =?utf-8?B?ckpWY3BnQmtXMG80RGN2U1BNTXByQWxBdVRkcU9rcFYwSjlPWmlCR0VDb3oy?=
 =?utf-8?B?RHd1ekU1ZkpPN2lVOUhwcSt4RlBDOGN2M0hnTkRHZmcwcldKYi94RE42bjJR?=
 =?utf-8?B?R2RKUUVWNVFUc3UxMkhDM3owME42R1Y4MTgrT0wwc25JS21KR3h3aVlyN2Qr?=
 =?utf-8?B?U1RrQ0dSb2NnTEN0dWxqcEZlUG9Ja0MyQUg0QW5rby84eE9US3JaaVV5SWNq?=
 =?utf-8?B?VGRpR3FYN0hCMHcvRlI4aFg5S0p2YjhhRktHZ1lHYkhacnBpMksxQ2o4SEVz?=
 =?utf-8?B?MUowcU9mTnY2UEJtb2h6cGRVR1pQZkhsN09QVHNZM0t4NUtaV01xRWhwQ25i?=
 =?utf-8?B?WEVGdXAxeURvZG5WNFNPTExGbUlnV0JXSHp4bUlIQW40SWphM3VVdjNIbWI2?=
 =?utf-8?B?bm13OCsrdHZ4QlhwREt5OVBNNFlkeXptc0xLVUE0d0g1YXM5OWhlYXRYdSto?=
 =?utf-8?B?bjQ4OFNHR25KUStjQnY5V091RnN6Z3Z6MkdCbEZoWXFXb1QzaVVNUElwUElo?=
 =?utf-8?B?eEZGcUlKODZkbFNLdk5qS05DQ1lTeXJFVHNFSlBQMFhHOW9rYzVyMlc0dVk2?=
 =?utf-8?B?TlhrMWh0alhvb3ExT2FxZHRWMytFSERJcnVPc2tCM1dFVzlxRkJQOHBNMzZB?=
 =?utf-8?B?WVU3QXduQXFXT0dtT3NzY0Q1UmRockJDY0xoV0p4WmpETlRmNUlUSWZNY0pQ?=
 =?utf-8?B?S2tnZWMvT0N1Vm5Db2txTHorNm0vSVFveWRsOEc4OWZPbjBzaFEwN0lOd3pu?=
 =?utf-8?B?S2l1STRZSlJUTmFIbHpJYUw5elA4MXFrdGhlUTVMc3NmeUl5d1VNU2tEZWtJ?=
 =?utf-8?B?U3duL1ZYTlV3eW9KVWFmZE85NlFSVlJETmJrUm91YXJBYm1TMFlvMzBpMXdz?=
 =?utf-8?B?OXVJcFRlaXlZVFNxaHh1bmpKcEhzcyszRE5mNjlaNkJOby9PcmlxdWl5UFdK?=
 =?utf-8?B?TmVBYWRBSnNvY1ZWZm93azRrdFB2VjBZVzc5SHhYSTNWTlZCVTVBeHFYeXBK?=
 =?utf-8?B?N2VxVXNPZStDUkJ0RDVlcHZOZUt1N0dLeExHUmJWb2ZvMFBPUm8xN2RMRlNH?=
 =?utf-8?B?aHZGUzdFMHB5bXBwWkUwemlGUUV0VTNHeGRodHpvUTZBdU9IZnpYM0QvbzZX?=
 =?utf-8?B?aGxGWkNLMEVKSlRodXIwejFNVnMzZHlDYTRBUllvWkNuU3pyN2FGSno5cU1v?=
 =?utf-8?B?K0V1c0tsZjZ0RnJHMGl3TzZ5OHF0N1hXc1FDZlBPUlM4aXZxNE54TmhXR1Zt?=
 =?utf-8?B?dmkxMUx5VFBHcnZVSkVXcHRwcnY3eDZNMG5URjFlVCt0SFdISFZlYzBTYzZs?=
 =?utf-8?B?d3hqTjhKV210enBmTlUwWjdrUEhrTStGK0N6bnhyZUprcTZiVXFxOStna05F?=
 =?utf-8?B?SHI5OFIxZ1JQK2ZlTCtaVTk0dmZkblJjTTZLZ3JTblNBRHc1ME9wVWxNblE0?=
 =?utf-8?B?UmFBWitmZ2VJemJmVmtZRWtITy90R3VPZlJyRmgwUzFNYXdTWFUvSXl0VitM?=
 =?utf-8?B?TkR3cW9XMXl5MmNreEhaaUFLNFNhOVNVTGw1YWRuMHoyU29PNG1rV0oxUldM?=
 =?utf-8?B?QUxmUjJnc2tPV1ZOUWFGSTBBOTBpNmJaVGdMT05uVURUS2lnVERoUTV6alFJ?=
 =?utf-8?B?MnUySU5kRWoydVNRQjR2YnJrS1Jhc2hscDdsSUgrcGdTNmVTT3FIU3R5L0sr?=
 =?utf-8?B?d1VHU0pubVhndjAweUN2R0FYL2h6WWRvWGllMDRlYThoSUk4M0ZaaEpwL2Jz?=
 =?utf-8?B?ZXZLbm1SVnUrT0lGWmxqR1BJRlRCN1FObGV0R3ZVOXNBY3htV1RrdmxJM3Fy?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65515505F0C99D48A7FBDB8874403EEC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442b315a-657f-4ddf-ebb8-08dbc3b027bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 01:29:15.0982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QED1PAhYj7lYtdBfbzrd0jn7w1XXmnhhPPrUgtXp7RWY/NStxeAGUbAA53C2kpWcydsqz7G1U23m1cwfflJFNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7443
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUaHUsIDIwMjMtMDktMjggYXQgMTI6MjQgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAyOC8wOS8yMyAwNTozOSwgU2hhd24gU3Vu
ZyAo5a6L5a2d6KyZKSBoYSBzY3JpdHRvOg0KPiA+IEhpIENLLA0KPiA+IA0KPiA+IE9uIFRodSwg
MjAyMy0wOS0yOCBhdCAwMzowNSArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+ID4g
PiBIaSwgSHNpYW8tY2hpZW46DQo+ID4gPiANCj4gPiA+IE9uIE1vbiwgMjAyMy0wOS0xMSBhdCAx
NTo0MiArMDgwMCwgSHNpYW8gQ2hpZW4gU3VuZyB3cm90ZToNCj4gPiA+ID4gUGFkZGluZyBpcyBh
IG5ldyBkaXNwbGF5IG1vZHVsZSBvbiBNVDgxODgsIGl0IHByb3ZpZGVzIGFiaWxpdHkNCj4gPiA+
ID4gdG8gYWRkIHBpeGVscyB0byB3aWR0aCBhbmQgaGVpZ2h0IG9mIGEgbGF5ZXIgd2l0aCBzcGVj
aWZpZWQNCj4gPiA+ID4gY29sb3JzLg0KPiA+ID4gPiANCj4gPiA+ID4gRHVlIHRvIGhhcmR3YXJl
IGRlc2lnbiwgTWl4ZXIgaW4gVkRPU1lTMSByZXF1aXJlcyB3aWR0aCBvZiBhDQo+ID4gPiA+IGxh
eWVyDQo+ID4gPiA+IHRvIGJlIDItcGl4ZWwtYWxpZ24sIG9yIDQtcGl4ZWwtYWxpZ24gd2hlbiBF
VEhEUiBpcyBlbmFibGVkLA0KPiA+ID4gPiB3ZSBuZWVkIFBhZGRpbmcgdG8gZGVhbCB3aXRoIG9k
ZCB3aWR0aC4NCj4gPiA+ID4gDQo+ID4gPiA+IFBsZWFzZSBub3RpY2UgdGhhdCBldmVuIGlmIHRo
ZSBQYWRkaW5nIGlzIGluIGJ5cGFzcyBtb2RlLA0KPiA+ID4gPiBzZXR0aW5ncyBpbiByZWdpc3Rl
ciBtdXN0IGJlIGNsZWFyZWQgdG8gMCwNCj4gPiA+ID4gb3IgdW5kZWZpbmVkIGJlaGF2aW9ycyBj
b3VsZCBoYXBwZW4uDQo+ID4gPiANCj4gPiA+IFlvdSBqdXN0IHNldCBwYWRkaW5nIHRvIGJ5cGFz
cyBtb2RlIGFuZCBub3QgY2xlYXIgc2V0dGluZ3MgdG8gMC4NCj4gPiA+IEFueQ0KPiA+ID4gdGhp
bmcgd3Jvbmc/DQo+ID4gPiANCj4gPiANCj4gPiBTaW5jZSB0aGUgZGVhZnVsdCB2YWx1ZSBvZiBh
bGwgdGhlIHJlZ2lzdGVycyBpbiBQYWRkaW5nIGlzIHplcm8sDQo+ID4gYW5kDQo+ID4gd2UgYXJl
IG5vdCB1c2luZyBQYWRkaW5nIGN1cnJlbnRseSwgaXQncyBmaW5lIGlmIHdlIGp1c3Qgc2V0DQo+
ID4gcGFkZGluZyB0bw0KPiA+IGJ5cGFzcyBtb2RlIHdpdG91dCBjbGVhcmluZyBvdGhlciByZWdp
c3RlcnMuDQo+ID4gDQo+ID4gVGhlIGNvbW1lbnQgaXMganVzdCBhIHJlbWluZGVyIGluIGNhc2Ug
d2UgZm9yZ2V0IGl0IGluIHRoZSBmdXR1cmUuDQo+IA0KPiBEbyAqbm90KiByZWx5IG9uIGRlZmF1
bHQgcmVnaXN0ZXIgdmFsdWVzLCBiZWNhdXNlIHlvdSBkb24ndCBrbm93IHdoYXQNCj4gYm9vdGVk
DQo+IExpbnV4IGluIHRoZSBmaXJzdCBwbGFjZTogeW91IHNoYWxsICpub3QqIGV4cGVjdCBhIGNs
ZWFuIHN0YXRlIGFuZA0KPiB5b3Ugc2hhbGwNCj4gKm5vdCogZXhwZWN0IGEgY2xlYW4gYm9vdC4N
Cj4gDQo+IEJlc2lkZXMsIHdoYXQgSSBzZWUgaXMgdGhhdCB5b3UncmUgc2V0dGluZyBHRU5NQVNL
KDEsIDApIHdpdGhvdXQNCj4gZXhwbGFpbmluZw0KPiB3aHkgaW4gdGhlIGNvZGU6IHlvdSBoYXZl
IHRvIGFkZCBhdCBsZWFzdCB0aGUgZGVmaW5pdGlvbnMgZm9yDQo+IFBBRERJTkdfRU4gYW5kDQo+
IFBBRERJTkdfQllQQVNTLg0KPiANCj4gSSBhbHNvIGRvbid0IHNlZSB3aHkgeW91IHNob3VsZG4n
dCBhZGQgYXQgbGVhc3QgYmFzaWMgaGFuZGxpbmcgZm9yDQo+IHRoaXMgYmxvY2ssDQo+IGFzIGl0
IGxvb2tzIGVhc3kgZW5vdWdoOiBhZnRlciBhbGwsIHlvdSBhbnl3YXkgaGF2ZSB0byBtYWtlIHN1
cmUgdGhhdA0KPiB0aGUNCj4gcmVnaXN0ZXJzIGFyZSBjbGVhcmVkIC0gbWlnaHQgYXMgd2VsbCBq
dXN0IGFkZCBhIGxpdHRsZSBtb3JlIGVmZm9ydA0KPiBvbiB0b3ANCj4gYW5kIGFjdHVhbGx5IHNl
dCB0aGVtIHRvIG1lYW5pbmdmdWwgdmFsdWVzPyBUaGF0J3MgdWx0aW1hdGVseSB5b3VyDQo+IGNo
b2ljZSwgYnV0DQo+IEkgZG9uJ3Qgd2FudCB0byBzZWUgYW55IEdFTk1BU0soMzEsMCkgd3JpdGUg
ZXZlbiBmb3IgcmVnaXN0ZXINCj4gY2xlYXJpbmcuDQo+IA0KPiBQbGVhc2UgbWFrZSB0aGlzIGRy
aXZlciBwcm9wZXIuDQo+IA0KDQpUaGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9ucy4NCkknbGwg
aW1wbGVtZW50IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNClRoYW5rcywNClNoYXduDQo=
