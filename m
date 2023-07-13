Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4172751AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjGMIEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjGMIEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:04:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC4210B;
        Thu, 13 Jul 2023 01:02:16 -0700 (PDT)
X-UUID: 704f793a215311ee9cb5633481061a41-20230713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zBFrJeaVuOlZJ5x60FP6yVcCWdT4J5D5DM/RntOP7yo=;
        b=b5nu5evhHPXhxOJs8qFAv4nwcwqLcfYVH1Z/N55nD749VleqfFrOd3gumfQavV1EemsjMak2UNC7/2t+yHEjf2hxhGYVC72eJ/ozM+2jS5JpEaYC736saz2pm/8Ud6pU6VRA8dkLQKoFH87SGB7Jr5AfwwDrc+2js/eK4xmGwUA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:47de3a54-aa67-40e9-a923-0fa14bb4b115,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:95462f68-314d-4083-81b6-6a74159151eb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 704f793a215311ee9cb5633481061a41-20230713
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 73462708; Thu, 13 Jul 2023 16:01:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jul 2023 16:01:13 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 13 Jul 2023 16:01:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT3huqZRi7WfuATAdfR7n+GqKM5Spx053FuILabfAQz/g9/4fxpO4s7N4ZcJts+4dAYyw1npwQiotAsWR+DfwieKCvl8FfP/UXMJL1qz1OYP27Uj7vIJ9hDykTEconPj/k9BNCeKZ//F93khGe4lviAEvfuR72N1eC56fTarwnPrlUuphCPPnH9fjMSPXUoWXPp/bDkSMNxZsxnH4/QfJFVmW43IpkecKpgxcdnDNAnyC0sDLK3PT/uuG2TRHlMm3B/GqTnZuRykF5xp6FE/Odgj95/bEQauxfhvhVe0cdsxjQEzcLtfwafvOVFtlOhJNpKmXSP21kPiPgkV94kE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBFrJeaVuOlZJ5x60FP6yVcCWdT4J5D5DM/RntOP7yo=;
 b=Xk+pYMUFKLj2QhdZ0nbrMCwZJTLRFSuwUNNCzs0VynvkpSN2axCupwmluABg+sFNjCmVHCZRzhrKlZnBKur4MZXzxLUbibhmwYN6iWjLOniFji0xG+XjgBGmMIO4ON4T5xM4EXhRF+sYD1zJbaI4pb3RA0oyMqUf5sbo4aq0vp2J4Re/VFnho+4WpHOenTVPiph756A7XwMLC4TnxeGCyC14AkEDC8u/JPW98Mr+U5aFo9XkrNm9/SVZyuOTXB28da8+LhPN/gG/yiWP2Ri4JYplSuIQq4bobMC4+oip3qNHYyN+Eo9f5XG8uOx+LSapuZO9Oaq6I+ahgXr6lo+BTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBFrJeaVuOlZJ5x60FP6yVcCWdT4J5D5DM/RntOP7yo=;
 b=R33tz+6Cp6Te9dF/DdeoANV2tMwPyIwOv1XXKuEkHN7TQw1nvVHTpDmdh+xTgeCZeyKnHHCsnToBNPXlfJ+OjjNI8fQI+s3RRL0dKcnKYRmlkPOyewSXRrinpUQPMHmPKPg3uLMaeIGLlS77Lpdu4q8JqC2+DDL/AZJX1ztG0uQ=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by SEZPR03MB6596.apcprd03.prod.outlook.com (2603:1096:101:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 08:01:11 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::308:e3ed:1ec8:f918]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::308:e3ed:1ec8:f918%3]) with mapi id 15.20.6588.022; Thu, 13 Jul 2023
 08:01:10 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v14 10/12] remoteproc: mediatek: Report watchdog crash to
 all cores
Thread-Topic: [PATCH v14 10/12] remoteproc: mediatek: Report watchdog crash to
 all cores
Thread-Index: AQHZsJO6wBJMBqxuAUKCjzqp4WPqrq+2j6IAgADPlIA=
Date:   Thu, 13 Jul 2023 08:01:10 +0000
Message-ID: <315df6fe5006cab529f776500e0474bd1d5bc7ff.camel@mediatek.com>
References: <20230707052612.27521-1-tinghan.shen@mediatek.com>
         <20230707052612.27521-11-tinghan.shen@mediatek.com> <ZK8BJOXcBjjLXUlu@p14s>
In-Reply-To: <ZK8BJOXcBjjLXUlu@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|SEZPR03MB6596:EE_
x-ms-office365-filtering-correlation-id: 4a01e294-600d-46b5-006f-08db8377525e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /dNav+sKQA5kJrZff0zRkRsCDZvf/ATCo+fML42kpd2Mm4CFSPOKj1FZeR3UoFbjDiLhMIX4Ajb0LPIfkgoChWHfqQilI1NLbMuVyG5qIf8bpoSKC0qT1fFbV/lpXL2BombGeWWO/DT04giRna3EHvzXf5tpc0mK/7D6vi+XMU1jFyjU+fdTUUgh3SiIAP9WL4OH9KtiPacLE9ysK/93QIQUS25nsY3cY7FiY3JbzLGpcVSbhpA88wWjnvj2dpsomVKZPDDnx54ANR6nqA1FB3J/6ZnsrUkl2dGGhtaI0+V8VDbddbcOWshFVPDgx61sTxDOPe08HkE1EL0rGiyIFCyYaS20dWJMZAmXLupndCP4GIQBdacZNamqvTX6qZ1agSCyJYVHDR73UAIHuXvGrIzOQsV5yZlVJOEJTDxUAaC0yrrpsOotTl7Sv2/oG8E1Pi9rwtX3IcsQNc4WDmsgmBBivPwGbSa9MCGrgzI+dlOQQO66WYUxPQRKTy/W1gJ/Z9Sxt/GHbBE1E4/KuXRdyc+3QqzCtT1zJKjCCZ0sIS5pTZEXMPzpf38b3HWKsuw6wVwBTLcNWyg7zwKQswZksQgNvCG6Fzxx1hqLjeJ+PAocAxKrnlmKO/YAL9ia+Q1QJ+KFnTpGuq/GRO//hYKmnxpPxJK4VedCqhjkkPElNYw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(186003)(26005)(6512007)(6506007)(2616005)(83380400001)(316002)(66446008)(41300700001)(2906002)(7416002)(66556008)(6916009)(8676002)(64756008)(4326008)(8936002)(5660300002)(478600001)(66476007)(6486002)(66946007)(71200400001)(54906003)(91956017)(76116006)(85182001)(36756003)(122000001)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXZCV0tvbndOOVltWGwvVDNudmZYQktsOE5mWXBpYkRzYlFseFA1Ui9iSTJp?=
 =?utf-8?B?YlJwa3ZSNTk2alVmeXRXbjl4bjI3Q3RDYTBIY0s0dFBlRTdXOUhWT2RzTTFX?=
 =?utf-8?B?bEFlc2g0N0JVbzJ6MlFCamxEY0YrbStPaFJNakpFYUp4WlQrT25UekQycDFp?=
 =?utf-8?B?bGxBcStrRzhhYTY4VjJSRnRkM2EwcU9VVTBHVkZMZkpoUWRuSFhLR2VFa1pP?=
 =?utf-8?B?SVJEOVM1aWc2RkovZWVlY3lsallLQ203TkZ6RXF1WjNQOWs5ODFDaXlXeTNp?=
 =?utf-8?B?UlM5TytqbzJhWnRmVzRqVDE3QzVGNmQ1ZVNpcE82a2tPQnNiZS9QTklGYjlU?=
 =?utf-8?B?U2MxT2R2bzN1NjZMUEgwUEFzOGZsVkUyQnYvTGdkclgzbEVDS20vc0xpSHpi?=
 =?utf-8?B?U0VZMFIyV0hSTmhkL0FTVkFzZ2hvU2tNcHF1ZWpBTGlkdjJVN1FUazBvaHIz?=
 =?utf-8?B?MlJtbCtYNm5ZVmZ0WGxlcUZmaEg5bnhYNXdadkczT1JDYTlqWmV1VUJhbW1t?=
 =?utf-8?B?a0t2aENrVkQyYitQRXhQVlZmRnNyNzcvMXI4WXh3aTgyMWdUV1hFWHZGbkFV?=
 =?utf-8?B?cWoyRXNHQ3hMZ21SMnZEVGI3RTdiby9kU1U2bEVJWU9mTWw5UUw1cVM4dnBT?=
 =?utf-8?B?THQ4VWZ0NmlLQVA5bzBKMEQ1QTV4amc4RmtMUzVidld0UHpWUXJUY2x3ZzhJ?=
 =?utf-8?B?TTRnOTFYTW9yUmdzTFo5TGU3QUZhcE9TM2tQa1FmYXF4cHF6eDhDYThBYmdM?=
 =?utf-8?B?c2JwK3kwckttS0VORExwNXdPOWt1UWs0aFJKL1F3UHgrZXJLQ2o1RGFiVy96?=
 =?utf-8?B?dnVWK2ZwOW8vYXVaVHZMSmFDZlBMZ2RtVEtIS3hYUldYakpNZmFza29FWEIy?=
 =?utf-8?B?L1VXbEI0dHJqT1pRL2QybFdzZEFVV2EwdnYrbGJOVDF4SEMrNTR6eE1XdFoz?=
 =?utf-8?B?cWJwYTNXY2JFYVNUcFo5V3NabzFjSDdKNUlkaVBxeFBzdTBxaXgvbUx0U1g1?=
 =?utf-8?B?UDFOUmx3V3orZ1ltM0E5YWZuTmtxZGlEK1RVTWpWSkV0dS9jVWdzTzd6TkdQ?=
 =?utf-8?B?Z2lQa1l2aitCV0txbUtlUFJhZU13bkNFU21kSEpOakFERGZyMXZjS1RMVjRQ?=
 =?utf-8?B?MTFFQzRXN0k2b1dDU1o4S1ZQTG9USUEram94cnY5dmdiVE5ETVlrQUhGclFU?=
 =?utf-8?B?S0c4UVorUUpVbUE4VmswQkxwb2QxTUJkUzZSZUZUYVJSSGpoVy8zTHpvL1JN?=
 =?utf-8?B?cW85UmVKcS9qa3dzVmdJdnZ5VHMvbmgrRGFEMTI2NnVMeVE0Vm1tNnkxQUJq?=
 =?utf-8?B?TDZSc2tQbVMyUFE2aDk2bFlYMm8xNzBLcGZRUlVLUWpxK09LV080RjI3dENz?=
 =?utf-8?B?bnFLRlNpR1N3UUtveWFhVFhid211WXNUQ1BHV1Z4NVZUeDhRbE1EYVY3dTBQ?=
 =?utf-8?B?bnJTc2wxWXNYN3RlN3VoZHBianJud3BoQS9PeElobGhDZnZaOTBNWG53MERX?=
 =?utf-8?B?Y0tkVzVEUkFKTVpWeFdNU3dhaHEyQ3lPZFplbkkxZTNoT2ZxbW4vQ2pwZU5T?=
 =?utf-8?B?WkJFbEdCZTJMYk1VQTM3Q25tUUJ2amNNNEJVZE45bDVWSmtGakxEdjlBTDJT?=
 =?utf-8?B?MzJhQ3c1NTJzWEhQNzkrb2UwZHpMZmF3cG94bE45S2VsbU9NcFdlNW9rVnk0?=
 =?utf-8?B?akdHR1I5YXpjUnlGb0tXYUUxZk1EWUtaeW1QdThGUjRKZHJQT1JEa1pubHpu?=
 =?utf-8?B?dVl0MVAwMWppNkNLMXIycmZ6eTZ2QVdHTGhsTTRnOEx5ZHFoLzZrY1dVTVhv?=
 =?utf-8?B?U0VkNXU3cncxbkV0RGhNUGFXQ3BCN3hpc3UvdE5EbXU0L1RFaWdBTE8zR0pS?=
 =?utf-8?B?c0JCRE9YUkYzNis3MDhiQlVzdW5JT3lxRUdGS2NKUFBOUnhHcmhOTTBRd3FS?=
 =?utf-8?B?MXR5OTg0WlBRMWNkU2FldUxzaXduaGtmVk9RdkNVeXdUTlZVMS9CakpBNGdy?=
 =?utf-8?B?ZmFjOE85cUxEZE1NSmdhMm5Xc3NBckhFd0lOZzlidlZNYUZYZExxbHJLWjhX?=
 =?utf-8?B?aEhHQy9BZWZLYmx5WnF3bGhsK3VHOU1mNlNEcGFVbFhhTmRLN2dOQklVcEdQ?=
 =?utf-8?B?aGxaZk53Si9KVVd6bGFRbFc4Lyt2aEhFNzVvNG5vMXArb2JrWXp3aTkzVkxZ?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA1F7F334F78F74FAA0C0C74186862A0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a01e294-600d-46b5-006f-08db8377525e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 08:01:10.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kjk2A/SmjD9qSOmMpDYn/kmZnAUhsYlaK7oCaj53vFgsQRltgq39HoS8Oj/NfTH8SDDivh9m9u4errn4NYJii/fBVaU98mPLo6ueyXi0Kac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6596
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldSwNCg0KT24gV2VkLCAyMDIzLTA3LTEyIGF0IDEzOjM4IC0wNjAwLCBNYXRoaWV1
IFBvaXJpZXIgd3JvdGU6DQo+IE9uIEZyaSwgSnVsIDA3LCAyMDIzIGF0IDAxOjI2OjEwUE0gKzA4
MDAsIFRpbmdoYW4gU2hlbiB3cm90ZToNCj4gPiBPbmNlIHRoZSBTQ1Agd2F0Y2hkb2cgdGltZW91
dCBoYXBwZW5lZCwgdHJpZ2dlciB0aGUgcnByb2MgcmVjb3ZlcnkgZmxvdyBvbg0KPiA+IGFsbCBj
b3Jlcy4NCj4gPiANCj4gDQo+IFlvdSBhcmUgbWlzc2luZyB0aGUgbW9zdCBpbXBvcnRhbnQgcGFy
dC4uLiAiV2h5IiBpcyB0aGlzIG5lZWRlZD8gIFdpdGhvdXQgaXQgSQ0KPiBkb24ndCBrbm93IHdo
YXQgaXMgZ29pbmcgb24gYW5kIGNhbid0IHJldmlldyB5b3VyIHdvcmsuDQoNClNvcnJ5LCBJJ2xs
IGltcHJvdmUgdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpJIHRoaW5rIHRoYXQgdGhlIFNDUCBzaG91
bGQgaGF2ZSB0aGUgc2FtZSBiZWhhdmlvciBhcyBhbiBTTVAgc3lzdGVtLiBJbiB0aGUgZXZlbnQN
Cm9mIGEgd2F0Y2hkb2cgdGltZW91dCBvY2N1cmluZyBvbiBhbnkgb2YgdGhlIGNvcmVzLCB0aGUg
ZW50aXJlIFNDUCBzaG91bGQgYmUgcmVjb3ZlcmVkLg0KDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogVGluZ2hhbiBTaGVuIDx0aW5naGFuLnNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jIHwgOCArKysrKysrLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfc2NwLmMgYi9kcml2ZXJzL3JlbW90ZXByb2Mv
bXRrX3NjcC5jDQo+ID4gaW5kZXggOWZlZDUxNjFmMDk0Li43ZTc4NmFhZjA0ZTEgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9yZW1vdGVwcm9jL210a19zY3AuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
cmVtb3RlcHJvYy9tdGtfc2NwLmMNCj4gPiBAQCAtODAsOCArODAsMTQgQEAgRVhQT1JUX1NZTUJP
TF9HUEwoc2NwX3B1dCk7DQo+ID4gIA0KPiA+ICBzdGF0aWMgdm9pZCBzY3Bfd2R0X2hhbmRsZXIo
c3RydWN0IG10a19zY3AgKnNjcCwgdTMyIHNjcF90b19ob3N0KQ0KPiA+ICB7DQo+ID4gKwlzdHJ1
Y3QgbXRrX3NjcF9vZl9jbHVzdGVyICpzY3BfY2x1c3RlciA9IHBsYXRmb3JtX2dldF9kcnZkYXRh
KHNjcC0+Y2x1c3Rlcl9wZGV2KTsNCj4gPiArCXN0cnVjdCBtdGtfc2NwICpzY3Bfbm9kZTsNCj4g
PiArDQo+ID4gIAlkZXZfZXJyKHNjcC0+ZGV2LCAiU0NQIHdhdGNoZG9nIHRpbWVvdXQhIDB4JXgi
LCBzY3BfdG9faG9zdCk7DQo+ID4gLQlycHJvY19yZXBvcnRfY3Jhc2goc2NwLT5ycHJvYywgUlBS
T0NfV0FUQ0hET0cpOw0KPiA+ICsNCj4gPiArCS8qIHJlcG9ydCB3YXRjaGRvZyB0aW1lb3V0IHRv
IGFsbCBjb3JlcyAqLw0KPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShzY3Bfbm9kZSwgJnNjcF9j
bHVzdGVyLT5tdGtfc2NwX2xpc3QsIGVsZW0pDQo+ID4gKwkJcnByb2NfcmVwb3J0X2NyYXNoKHNj
cF9ub2RlLT5ycHJvYywgUlBST0NfV0FUQ0hET0cpOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0
aWMgdm9pZCBzY3BfaW5pdF9pcGlfaGFuZGxlcih2b2lkICpkYXRhLCB1bnNpZ25lZCBpbnQgbGVu
LCB2b2lkICpwcml2KQ0KPiA+IC0tIA0KPiA+IDIuMTguMA0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClRpbmdIYW4NCg==
