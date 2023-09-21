Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FBF7A95FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjIUQ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIUQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:59:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAC1739;
        Thu, 21 Sep 2023 09:57:02 -0700 (PDT)
X-UUID: dca35d3c588e11ee8051498923ad61e6-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GeZOTZjwz9okyQf5fvztgUp5NTIV5ME9uMecs3RgOGA=;
        b=ZRFkriJyXMK/JexexICC56vkrly9ticC9MceacQ0ncyLZZ8MrUZIYhPp03iT530CTMV+EU6DBfbVZQujbA2nVgGy3+lmUCkoCTGatNYHnW24IhidkeBjkghsXrBb+5aaVogunUNiYxte4YCOC3G38ITTmrUO4V7dlG4bJbqMhkE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:8f261f3c-cdb5-4b77-b4dd-5af549d944e2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:defff8ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: dca35d3c588e11ee8051498923ad61e6-20230921
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 52239654; Thu, 21 Sep 2023 22:55:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 22:55:09 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 22:55:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtUTNUJSxNxh+D/JV1MUodWkE22z2DktTEhQcJeDrpSCMnapb5VOCOWFXOfK47EEtHXjOaAglL6R5IWx0usJ9+UXYtLsPkFQxdgnsPJBb+VfmE6t+NDshjYfd/y5OtmtRT6YnAOCU8OKl3diuaA9dwwqufPvkw6Zu6PuRVBRwLnrA9NGG3kgz0fT3idPhoxPFcKuJLKl+ujN68XFIe0ZldAcSHM+hyMy2ab8gIexUvtayIjr4Qcs1+/xkdLt6KbWLvML2ePJ5ZYtW3WhXBQQUW/XeYyOevfJfvyryR/cz8KrRSoScoPrdaHAEsoLD06Lt/nSo7XokIg9VJcYF0oLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeZOTZjwz9okyQf5fvztgUp5NTIV5ME9uMecs3RgOGA=;
 b=fZwxcuGmtbN91Wgv01QNFwaUhX0n4xcsw9LGNiSBNerxiE087aHFH+ITb3XsatlFic3tTTkyoyH920QdgfMG7PZ61nriN50BT7E7wB3JyCjgY9LOTZIQrEs4aVnc0z0jiLCEgr+oupbFx1L4Ds3fF74+NwHmhJVp1ib6xH1kycdvmRBSRhjixn2AjZZHCbYSA/XWVogPZOZMyAUNODm/4JPBmN3XShuwU/uhqcyL0KLaEBdJ1i3/YUQjiUHiC1yeSxrg3ycPcGlLMwslfMDhabqwVuYbjFAF5hjuDh8th9tCE2Rvj7UE5rxCP+uP1OjwXjxzc8y69pu1Jnse7pz7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeZOTZjwz9okyQf5fvztgUp5NTIV5ME9uMecs3RgOGA=;
 b=PrFobzFYaVLCHj9yXw88tIhTYGhifw3bXpGM9pseAOEeVQtLPaxTYIMvz2jE+DVk57dv+NqYR78NE8slRbhI+yol0JIBMb4T7FPewQQaWmHjG0+OhoBi00Rw77qIMFzXPFBnfO17dICP9/LH/8tVslU0p0VZhUpffhq0sApSd+Q=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB6460.apcprd03.prod.outlook.com (2603:1096:101:51::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 14:55:06 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 14:55:06 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 00/10] Add mediate-drm secure flow for SVP
Thread-Topic: [PATCH 00/10] Add mediate-drm secure flow for SVP
Thread-Index: AQHZ6qYEdO5WCsCYu0+t+bshYdi40LAjMCaAgADaFQCAAHclAIAA4IqA
Date:   Thu, 21 Sep 2023 14:55:06 +0000
Message-ID: <9d6e628e1a420edf1106895eddeced7b9847ce8c.camel@mediatek.com>
References: <20230919030345.8629-1-jason-jh.lin@mediatek.com>
         <a0b32a1d93bc9d991f77ad3408fe7b177bb32889.camel@mediatek.com>
         <CA+ddPcNPeo=z42fG24uoSMJ8M0uWB-huzXVKBm-seG=7b+50JA@mail.gmail.com>
         <0f828842524f1518ccb6f75e6b34efd849466016.camel@mediatek.com>
In-Reply-To: <0f828842524f1518ccb6f75e6b34efd849466016.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB6460:EE_
x-ms-office365-filtering-correlation-id: 09caed60-1e91-45c1-0413-08dbbab2be67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76YRDCjk3vtCrgFSrfujtfp65avurnJNawhGrLpTAAZRWTUVy3KFgC5y9/q8YtWbMuDo9sugacPYT8q9Aalel/cWf5T3144Y2Wr2r6UV6UkagIIAiwoXV5iQIv9YSJ3hxKAYd/PBC37VVqM7y4UJfyBUrxJmUZepu1OP6G3IYRhyYApXHFM9cC6xs8cjB0Y6E3M68QzCBBQ9SVhqvVmRfxhmQ9zYIociifuog4OJ9bVzPfiLEKzEaG+6nVNsWdogjmDBxHd15EJTmNpXesBWpEc2x3BZS4PSHsdMMXMZ2voAGbV9mqLjqHe3wOOyzqh1vaSRtED7zn1TrJmc6Sx5JVpAdstMcUrWcmg7DrPlGzhPmpUcl7O1nAZE/qKWtDOY41r7MnV1R5Wu4YLx0x6WnnqK8GLj2J0UjzfR2m8EpbJASqsombj6EkvyA5scrnISEtT8bVbJ2NehC0E0PUi+SXG9zUCxXI6Th0GJuZjWQatueT79UB7SA3wDWiuIzuCCx19fNivdD55LCo2QThecnlqA4kiXly+441Vqbs7Oao7srGioXeL494L+Ku2XRCbZgjxTW3mGPKubvsDwSFh53n1cXzVJl5r6WlDCfiiKMwI+fLbMbGN3AAKhOFcW/lyoFc8xMZk0XHTmton9GyMpnALVXERodEP4nBuq33ziZt45DSVskYTZwS56Ey0BbUBv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199024)(1800799009)(186009)(53546011)(71200400001)(6512007)(6506007)(6486002)(122000001)(86362001)(85182001)(36756003)(38100700002)(38070700005)(26005)(2906002)(2616005)(966005)(478600001)(7416002)(83380400001)(8936002)(91956017)(5660300002)(8676002)(4326008)(54906003)(66446008)(66476007)(76116006)(41300700001)(66946007)(64756008)(316002)(110136005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aS9wREZlVXlFYkkzSmt5aUdha0NGcG9rSVJHUU1lSGNwNitxOHVWaE5SVEg0?=
 =?utf-8?B?SHMxOC9jeFNyOEVmK2hJcDB2MWFsMUMzeFBOL2JDUXJWNnFBMytydWdOdk1T?=
 =?utf-8?B?RG0vZVhtY2FzOFJSWmp4NmExNzJweVVtYnZwbnFlRVJiY2F2VFVaV01IU0tk?=
 =?utf-8?B?WFRPTUkvZ3RoQTFLRHByV0FmOUduT2s0RzJ3REhMdHdycVpYMCtTaldmWWFP?=
 =?utf-8?B?cFgwR3VlWTRiQWozUk9ZWFBROU1GRHZBYUZtaElUQm8wYlJIOS9FcmtRTVll?=
 =?utf-8?B?NW5LMldrTHZFK0NYelk4eTVTOGNNMXJkcEVxKzE5ZmVka2hXUmN1eG5NUjhv?=
 =?utf-8?B?Mnc2U3g2UnkwZkhrcXBzOEExeTQyK1Q0a3pQTXQ1KzRxSjBBTWFhOTVCSjl5?=
 =?utf-8?B?NlJETFlITW9HWG9aWU1TVUYxOThYSkdJMTBzNE8rNjk3bWRVTmNuZ3h4Ni9o?=
 =?utf-8?B?NHowZHNCdWxabnpOeW5qeE1WelJNSjVEdVFIcTk3ZVhIUWhCMFJtK25hTy8w?=
 =?utf-8?B?ZEljTUtmOVUyTjlaUTNoeHhTZE5JTVA0bVVKYitKTVF1aHhsYWVNNG9ycWhF?=
 =?utf-8?B?dDZEQU5XN1NkRytwaWhWY0RlSU54bS9pZEYvUWxrLzdWcHVSWTlIYzYvT29a?=
 =?utf-8?B?QUhlelBUQVlPejRHRVZ1MGZhTHhEWEdKeDBHbmNTOElwUXRGbmM2dmg2RjNJ?=
 =?utf-8?B?aDE5S3JFY1V4OW5vd2lpSTByeGx3cElaQTJBSTYrRGg5NUlSNTJHUVlEZFNW?=
 =?utf-8?B?cThhbVVEYUFBM083MzlWWUhOaHIvRDlhVXFCYnMrRnpNemJyR0RxZnRselpi?=
 =?utf-8?B?a1B6VVB0YThiWFcyMC9BaUVaUlM0V1lTRi96RjZJc3g2bUxiSTlvZVR3VjJY?=
 =?utf-8?B?VUlEdG45NU8xMzJESjVsZ0s0OXIrN3pnN0lhUS9UQmJmbG9zMlcrbzJuOWlX?=
 =?utf-8?B?QzFxc2NTT1pyaGNZRG1VeE83eHBsRXNKaTd5d2VaRHkxU1FlQkw0aXpDUjR1?=
 =?utf-8?B?MFlCcmJUNnQ0THNKb3JPSGdQbGZBdHp3TWN6Z01PdVU0U3pNZi9uYS9DT3Rr?=
 =?utf-8?B?aEsveGlxMjBLNUFrSGlIWEFlQzlDS0VSQVVqdlA2MWIxVWZPeEl2R1RGb2xZ?=
 =?utf-8?B?cFY1aEJmUzJ1K1htbXRyVmg3ZEY2c25vejliL1BIa3h3Tml3cVpLdjdoc2VU?=
 =?utf-8?B?a05zcEdGNElOTzJxODhyWENUZUFLeXppK2xPSENNQzlyQXhJUGkyRGdON2Vl?=
 =?utf-8?B?UkpFU3kyK1RESEgrTFRNUWw1Z0w0NnVxOFpaRHViTm5DVXRscDdqUkpML1l3?=
 =?utf-8?B?RElYdGR0NlN5Q0tWanBhUU1NdVBrbGxXSFd3YStoSGszbVdaWlJYK0lLWHlE?=
 =?utf-8?B?SmtKandTRENlNmFSMVcrcEN1RjcvYjg3VXZOTmp5bFFGNUlFdnJ3SGpXOW1o?=
 =?utf-8?B?LzhlcmJvV29GQ1o5VVV1S1EwZ3B5UDl4d21qNEFVV1Z1TFQxZWw0Z1RGUXhr?=
 =?utf-8?B?N2pKOEUyeVlSemRuY0pad1dIMEVBbXp6aDJ4M1lNell6bFNYbTMvWTZTMjBV?=
 =?utf-8?B?YlRPVGlENFlwTEVxQ2RNbUhDQm5paVJZTHM4L045VHJLcElWd1c3c0J4Q0Z2?=
 =?utf-8?B?Unk4WHlOSlovSGVaVC9oNFlGVUVXQXNxNDZxMk90SFFGODhwVU9SZWtIc3Nr?=
 =?utf-8?B?VCt1T3JUbUZEckR1RWxzU3BBL3F6cFdHV2RDQVp0Nk9oMmxrV3NHeDdLemtZ?=
 =?utf-8?B?Tm8rQXlZcC8yZFdwUGsyeHZUKysvWkprNFk5N2ZhVWxpbTBwcUV1bVA0UWR5?=
 =?utf-8?B?SHgrUlp2WHlDM2hEOFl1UHo4NEs0ZkJzbDJYRmZ6VmRvUDlPYkdKQnNpTkpo?=
 =?utf-8?B?R01wV0dMbk9mejlML0xiL0FYNVM1M1poZndla3JtZWxRN3ZNWHcydytmamo4?=
 =?utf-8?B?dWV4S1gyVmdQNjJYaFZ5VmkxYk9kNEJ2OXF6dGtocDJSUjNSMHZsa014cm45?=
 =?utf-8?B?UC9vNkc3dHVBSGF3VW1RV0ZLUFNaeTlVUXNjeEhLWUtLYThwdktIbUFBVUgr?=
 =?utf-8?B?dk1qMjYyemhpWUZtRVRTZE1UbDJvVTkyZlVmVFE4T21kTS9tZ0tZREFLbmlq?=
 =?utf-8?B?M3FoVmJJdmdHUEFZTWZSUklqNm5CUlB3ZGM0OXozU1hlVktnM2FqRi9zK2ZM?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA8F253E04075349BBC3F47450460E11@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09caed60-1e91-45c1-0413-08dbbab2be67
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 14:55:06.4044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3kmo3+g7jNzQuF5x2v25OUd5Hg6zRD0pCsWdEjakI/Ni2KNikYb+MjuiAixmuwlABZm57RjYgUoiT6enaDhpL/i3BezpYHS3H0/b9OVg1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6460
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCg0KT24gVGh1LCAyMDIzLTA5LTIxIGF0IDAxOjMxICswMDAwLCBDSyBIdSAo6IOh
5L+K5YWJKSB3cm90ZToNCj4gT24gV2VkLCAyMDIzLTA5LTIwIGF0IDExOjI1IC0wNzAwLCBKZWZm
cmV5IEthcmRhdHprZSB3cm90ZToNCj4gPiAgCSANCj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFz
ZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+IHVudGlsDQo+ID4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiAgT24gVHVl
LCBTZXAgMTksIDIwMjMgYXQgMTA6MjbigK9QTSBDSyBIdSAo6IOh5L+K5YWJKSA8Y2suaHVAbWVk
aWF0ZWsuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBIaSwgSmFzb246DQo+ID4gPiAN
Cj4gPiA+IE9uIFR1ZSwgMjAyMy0wOS0xOSBhdCAxMTowMyArMDgwMCwgSmFzb24tSkguTGluIHdy
b3RlOg0KPiA+ID4gPiBUaGUgcGF0Y2ggc2VyaWVzIHByb3ZpZGVzIGRybSBkcml2ZXIgc3VwcG9y
dCBmb3IgZW5hYmxpbmcNCj4gPiA+ID4gc2VjdXJlDQo+ID4gPiA+IHZpZGVvDQo+ID4gPiA+IHBh
dGggKFNWUCkgcGxheWJhY2sgb24gTWVkaWFpVGVrIGhhcmR3YXJlIGluIHRoZSBMaW51eCBrZXJu
ZWwuDQo+ID4gPiA+IA0KPiA+ID4gPiBNZW1vcnkgRGVmaW5pdGlvbnM6DQo+ID4gPiA+IHNlY3Vy
ZSBtZW1vcnkgLSBNZW1vcnkgYWxsb2NhdGVkIGluIHRoZSBURUUgKFRydXN0ZWQgRXhlY3V0aW9u
DQo+ID4gPiA+IEVudmlyb25tZW50KSB3aGljaCBpcyBpbmFjY2Vzc2libGUgaW4gdGhlIFJFRSAo
UmljaCBFeGVjdXRpb24NCj4gPiA+ID4gRW52aXJvbm1lbnQsIGkuZS4gbGludXgga2VybmVsL3Vz
ZXJzcGFjZSkuDQo+ID4gPiA+IHNlY3VyZSBoYW5kbGUgLSBJbnRlZ2VyIHZhbHVlIHdoaWNoIGFj
dHMgYXMgcmVmZXJlbmNlIHRvDQo+ID4gPiA+ICdzZWN1cmUNCj4gPiA+ID4gbWVtb3J5Jy4gVXNl
ZCBpbiBjb21tdW5pY2F0aW9uIGJldHdlZW4gVEVFIGFuZCBSRUUgdG8gcmVmZXJlbmNlDQo+ID4g
PiA+ICdzZWN1cmUgbWVtb3J5Jy4NCj4gPiA+ID4gc2VjdXJlIGJ1ZmZlciAtICdzZWN1cmUgbWVt
b3J5JyB0aGF0IGlzIHVzZWQgdG8gc3RvcmUNCj4gPiA+ID4gZGVjcnlwdGVkLA0KPiA+ID4gPiBj
b21wcmVzc2VkIHZpZGVvIG9yIGZvciBvdGhlciBnZW5lcmFsIHB1cnBvc2VzIGluIHRoZSBURUUu
DQo+ID4gPiA+IHNlY3VyZSBzdXJmYWNlIC0gJ3NlY3VyZSBtZW1vcnknIHRoYXQgaXMgdXNlZCB0
byBzdG9yZSBncmFwaGljDQo+ID4gPiA+IGJ1ZmZlcnMuDQo+ID4gPiA+IA0KPiA+ID4gPiBNZW1v
cnkgVXNhZ2UgaW4gU1ZQOg0KPiA+ID4gPiBUaGUgb3ZlcmFsbCBmbG93IG9mIFNWUCBzdGFydHMg
d2l0aCBlbmNyeXB0ZWQgdmlkZW8gY29taW5nIGluDQo+ID4gDQo+ID4gZnJvbSBhbg0KPiA+ID4g
PiBvdXRzaWRlIHNvdXJjZSBpbnRvIHRoZSBSRUUuIFRoZSBSRUUgd2lsbCB0aGVuIGFsbG9jYXRl
IGENCj4gPiA+ID4gJ3NlY3VyZQ0KPiA+ID4gPiBidWZmZXInIGFuZCBzZW5kIHRoZSBjb3JyZXNw
b25kaW5nICdzZWN1cmUgaGFuZGxlJyBhbG9uZyB3aXRoDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBl
bmNyeXB0ZWQsIGNvbXByZXNzZWQgdmlkZW8gZGF0YSB0byB0aGUgVEVFLiBUaGUgVEVFIHdpbGwg
dGhlbg0KPiA+ID4gPiBkZWNyeXB0DQo+ID4gPiA+IHRoZSB2aWRlbyBhbmQgc3RvcmUgdGhlIHJl
c3VsdCBpbiB0aGUgJ3NlY3VyZSBidWZmZXInLiBUaGUgUkVFDQo+ID4gDQo+ID4gd2lsbA0KPiA+
ID4gPiB0aGVuIGFsbG9jYXRlIGEgJ3NlY3VyZSBzdXJmYWNlJy4gVGhlIFJFRSB3aWxsIHBhc3Mg
dGhlICdzZWN1cmUNCj4gPiA+ID4gaGFuZGxlcycgZm9yIGJvdGggdGhlICdzZWN1cmUgYnVmZmVy
JyBhbmQgJ3NlY3VyZSBzdXJmYWNlJyBpbnRvDQo+ID4gDQo+ID4gdGhlDQo+ID4gPiA+IFRFRSBm
b3IgdmlkZW8gZGVjb2RpbmcuIFRoZSB2aWRlbyBkZWNvZGVyIEhXIHdpbGwgdGhlbiBkZWNvZGUN
Cj4gPiA+ID4gdGhlDQo+ID4gPiA+IGNvbnRlbnRzIG9mIHRoZSAnc2VjdXJlIGJ1ZmZlcicgYW5k
IHBsYWNlIHRoZSByZXN1bHQgaW4gdGhlDQo+ID4gDQo+ID4gJ3NlY3VyZQ0KPiA+ID4gPiBzdXJm
YWNlJy4gVGhlIFJFRSB3aWxsIHRoZW4gYXR0YWNoIHRoZSAnc2VjdXJlIHN1cmZhY2UnIHRvIHRo
ZQ0KPiA+ID4gPiBvdmVybGF5DQo+ID4gPiA+IHBsYW5lIGZvciByZW5kZXJpbmcgb2YgdGhlIHZp
ZGVvLg0KPiA+ID4gPiANCj4gPiA+ID4gRXZlcnl0aGluZyByZWxhdGluZyB0byBlbnN1cmluZyBz
ZWN1cml0eSBvZiB0aGUgYWN0dWFsIGNvbnRlbnRzDQo+ID4gDQo+ID4gb2YNCj4gPiA+ID4gdGhl
DQo+ID4gPiA+ICdzZWN1cmUgYnVmZmVyJyBhbmQgJ3NlY3VyZSBzdXJmYWNlJyBpcyBvdXQgb2Yg
c2NvcGUgZm9yIHRoZQ0KPiA+ID4gPiBSRUUNCj4gPiANCj4gPiBhbmQNCj4gPiA+ID4gaXMgdGhl
IHJlc3BvbnNpYmlsaXR5IG9mIHRoZSBURUUuDQo+ID4gPiA+IA0KPiA+ID4gPiBEUk0gZHJpdmVy
IGhhbmRsZXMgYWxsb2NhdGlvbiBvZiBnZW0gb2JqZWN0cyB0aGF0IGFyZSBiYWNrZWQgYnkNCj4g
PiA+ID4gYQ0KPiA+ID4gPiAnc2VjdXJlDQo+ID4gPiA+IHN1cmZhY2UnIGFuZCBmb3IgZGlzcGxh
eWluZyBhICdzZWN1cmUgc3VyZmFjZScgb24gdGhlIG92ZXJsYXkNCj4gPiANCj4gPiBwbGFuZS4N
Cj4gPiA+ID4gVGhpcyBpbnRyb2R1Y2VzIGEgbmV3IGZsYWcgZm9yIG9iamVjdCBjcmVhdGlvbiBj
YWxsZWQNCj4gPiA+ID4gRFJNX01US19HRU1fQ1JFQVRFX0VOQ1JZUFRFRCB3aGljaCBpbmRpY2F0
ZXMgaXQgc2hvdWxkIGJlIGENCj4gPiANCj4gPiAnc2VjdXJlDQo+ID4gPiA+IHN1cmZhY2UnLiBB
bGwgY2hhbmdlcyBoZXJlIGFyZSBpbiBNZWRpYVRlayBzcGVjaWZpYyBjb2RlLg0KPiA+ID4gDQo+
ID4gPiBIb3cgZG8geW91IGRlZmluZSBTVlA/IElzIHRoZXJlIHN0YW5kYXJkIHJlcXVpcmVtZW50
IHdlIGNvdWxkDQo+ID4gPiByZWZlcg0KPiA+IA0KPiA+IHRvPw0KPiA+ID4gSWYgdGhlIHNlY3Vy
ZSB2aWRlbyBidWZmZXIgaXMgcmVhZCBieSBkaXNwbGF5IGhhcmR3YXJlIGFuZCBvdXRwdXQNCj4g
PiANCj4gPiB0bw0KPiA+ID4gSERNSSB3aXRob3V0IGFueSBwcm90ZWN0aW9uIGFuZCB1c2VyIGNv
dWxkIGNhcHR1cmUgSERNSSBzaWduYWwsDQo+ID4gPiBpcw0KPiA+IA0KPiA+IHRoaXMNCj4gPiA+
IHNlY3VyZT8NCj4gPiANCj4gPiBTVlAgKFNlY3VyZSBWaWRlbyBQYXRoKSBpcyBlc3NlbnRpYWxs
eSB0aGUgdmlkZW8gYmVpbmcgY29tcGxldGVkDQo+ID4gaXNvbGF0ZWQgZnJvbSB0aGUga2VybmVs
L3VzZXJzcGFjZS4gVGhlIHNwZWNpZmljIHJlcXVpcmVtZW50cyBmb3INCj4gPiBpdA0KPiA+IHZh
cnkgYmV0d2VlbiBpbXBsZW1lbnRhdGlvbnMuDQo+ID4gDQo+ID4gUmVnYXJkaW5nIEhETUkvSERD
UCBvdXRwdXQ7IGl0J3MgdGhlIHJlc3BvbnNpYmlsaXR5IG9mIHRoZSBURUUgdG8NCj4gPiBlbmZv
cmNlIHRoYXQuIE5vdGhpbmcgb24gdGhlIGtlcm5lbC91c2Vyc3BhY2Ugc2lkZSBuZWVkcyB0byBi
ZQ0KPiA+IGNvbmNlcm5lZCBhYm91dCBlbmZvcmNpbmcgSERDUC4gVGhlIG9ubHkgdGhpbmcgdXNl
cnNwYWNlIGlzDQo+ID4gaW52b2x2ZWQNCj4gPiBpbiB0aGVyZSBpcyBhY3R1YWxseSB0dXJuaW5n
IG9uIEhEQ1AgdmlhIHRoZSBrZXJuZWwgZHJpdmVyczsgYW5kDQo+ID4gdGhlbg0KPiA+IHRoZSBU
RUUgZW5zdXJlcyB0aGF0IGl0IGlzIGFjdGl2ZSBpZiB0aGUgcG9saWN5IGZvciB0aGUgZW5jcnlw
dGVkDQo+ID4gY29udGVudCByZXF1aXJlcyBpdC4NCj4gDQo+IEJ1dCBpbiBbUGF0Y2ggMDcvMTBd
LA0KPiANCj4gaW4gbXRrX292bF9sYXllcl9jb25maWcoKSwgdGhlIHNlY3VyZSBpbnB1dCB3b3Vs
ZCBlbmFibGUvZGlzYWJsZQ0KPiBkeW5hbWljYWwgaW4ga2VybmVsLCBNZWRpYVRlayBTVlAgZG9l
cyBub3QgaGlkZSBhbGwgY29udHJvbCBpbiBURUUsDQo+IHNvDQo+IEkgd29ycnkgdGhhdCBzb21l
dGhpbmcgbG9zdC4gVG8gYWNoaWV2ZSBTVlAsIGRpc3BsYXkgaGFyZHdhcmUgc2hvdWxkDQo+IGhh
dmUgc2VjdXJlIGlucHV0LCBzZWN1cmUgcGlwZWxpbmUsIHNlY3VyZSBvdXRwdXQsIGJ1dCBpbiB0
aGlzDQo+IHNlcmllcywNCj4gSSBqdXN0IHNlZSBzZWN1cmUgaW5wdXQuIE1heWJlIG90aGVycyBp
cyBkb25lIGluIFRFRSwgdGVsbCBtZSB3aGljaA0KPiBwYXJ0IGlzIGRvbmUgYnkgd2hpY2ggc3Rl
cC4NCj4gDQpXZSdsbCB1c2UgY21kcV9zZWNfcGt0X3NldF9kYXRhKCkgdG8gYnJpbmcgdGhlIHNl
Y3VyZSBzY2VuYXJpbywgc2VjdXJlDQplbmdpbmUgZmxhZ3MgYW5kIHNvbWUgc2VjdXJlIG1ldGFk
YXRhIHRvIFRFRSB3b3JsZC4gVGhlbiB3aWxsIHVzZWQNCnRoZXNlIGluZm9ybWF0aW9uIHRvIG1h
a2Ugc3VyZSB0aGUgcGlwZWxpbmUgaXMgc2VjdXJlLg0KDQpXZSBkb24ndCBoYXZlIHRoZSBzZWN1
cmUgb3V0cHV0IGZlYXR1cmUgY3VycmVudGx5LCBzdWNoIGFzIFdpRmkNCmRpc3BsYXksIHNvIHdl
J2xsIGRvIGl0IGFmdGVyIHdlIGhhdmUgdG8gc3VwcG9ydCB0aGUgZmVhdHVyZS4NCg0KQWxzbyB0
aGVyZSBhcmUgSERNSVRYX0hEQ1AgYW5kIERQVFhfSERDUCBUQSB3aWxsIGNoZWNrIHRoZSBIRENQ
IHN0YXR1ZQ0KaW4gc2VjdXJlIHdvcmxkIGFuZCB0aGVuIENNRFEgVEEgd2lsbCBnZXQgdGhhdCBz
dGF0dXMgYnkgY2FsbGluZyB0aGVpcg0KQVBJIGluIFRFRS4NCklmIENNRFEgVEEgZ2V0IGEgSERD
UCBjaGVja2luZyBmYWlsZWQgc3N0YXR1cywgaXQgd2lsbCBpbnNlcnQgc29tZQ0KaW5zdHJ1Y3Rp
b25zIGluIHRoZSBzZWN1cmUgY21kIGJ1ZmZlciB0byBtdXRlIHRoZSBESVNQIEhXIGZvciBlYWNo
DQpmcmFtZXMuDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBSZWdhcmRzLA0KPiBDSw0K
PiANCj4gDQo+ID4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBDSw0KPiA+ID4gDQo+ID4gPiA+
IA0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gQmFzZWQgb24gMiBzZXJpZXM6DQo+ID4gPiA+IFsxXSBB
ZGQgQ01EUSBzZWN1cmUgZHJpdmVyIGZvciBTVlANCj4gPiA+ID4gLQ0KPiA+ID4gPiANCj4gPiAN
Cj4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTc4NTMzMl9fOyEhQ1RS
TktBOXdNZzBBUmJ3IW1Qb2NiUXdaNC0yNURtaWR2QWdkOUs1ZVhqTkVoU3lJS3B2dllIUHBkcnEy
UGdTLWhrWXlIb2h6RHZvSnlkRDQ1VVpwNUp2WTlEdURWRmoxbHRWbmhHWSQNCj4gPiA+ID4gDQo+
ID4gPiA+IA0KPiA+ID4gPiBbMl0gZG1hLWJ1ZjogaGVhcHM6IEFkZCBNZWRpYVRlayBzZWN1cmUg
aGVhcA0KPiA+ID4gPiAtDQo+ID4gPiA+IA0KPiA+IA0KPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRp
YXRlay9saXN0Lz9zZXJpZXM9NzgyNzc2X187ISFDVFJOS0E5d01nMEFSYnchbVBvY2JRd1o0LTI1
RG1pZHZBZ2Q5SzVlWGpORWhTeUlLcHZ2WUhQcGRycTJQZ1MtaGtZeUhvaHpEdm9KeWRENDVVWnA1
SnZZOUR1RFZGajEwc0Q0a0hFJA0KPiA+ID4gPiANCj4gPiA+ID4gLS0tDQo+ID4gPiA+IA0KPiA+
ID4gPiBDSyBIdSAoMSk6DQo+ID4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgaW50ZXJmYWNlIHRv
IGFsbG9jYXRlIE1lZGlhVGVrIEdFTSBidWZmZXIuDQo+ID4gPiA+IA0KPiA+ID4gPiBKYXNvbi1K
SC5MaW4gKDkpOg0KPiA+ID4gPiAgIGRybS9tZWRpYXRlay91YXBpOiBBZGQgRFJNX01US19HRU1f
Q1JFQVRFRF9FTkNSWVBUVEVEIGZsYWcNCj4gPiA+ID4gICBkcm0vbWVkaWF0ZWs6IEFkZCBzZWN1
cmUgYnVmZmVyIGNvbnRyb2wgZmxvdyB0byBtdGtfZHJtX2dlbQ0KPiA+ID4gPiAgIGRybS9tZWRp
YXRlazogQWRkIHNlY3VyZSBpZGVudGlmeSBmbGFnIGFuZCBmdW5jdXRpb24gdG8NCj4gPiA+ID4g
bXRrX2RybV9wbGFuZQ0KPiA+ID4gPiAgIGRybS9tZWRpYXRlazogQWRkIG10a19kZHBfc2VjX3dy
aXRlIHRvIGNvbmZpZyBzZWN1cmUgYnVmZmVyDQo+ID4gDQo+ID4gaW5mbw0KPiA+ID4gPiAgIGRy
bS9tZWRpYXRlazogQWRkIGdldF9zZWNfcG9ydCBpbnRlcmZhY2UgdG8gbXRrX2RkcF9jb21wDQo+
ID4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJlIGxheWVyIGNvbmZpZyBzdXBwb3J0IGZv
ciBvdmwNCj4gPiA+ID4gICBkcm0vbWVkaWF0ZWs6IEFkZCBzZWN1cmUgbGF5ZXIgY29uZmlnIHN1
cHBvcnQgZm9yIG92bF9hZGFwdG9yDQo+ID4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJl
IGZsb3cgc3VwcG9ydCB0byBtZWRpYXRlay1kcm0NCj4gPiA+ID4gICBhcm02NDogZHRzOiBtdDgx
OTUtY2hlcnJ5OiBBZGQgc2VjdXJlIG1ib3ggc2V0dGluZ3MgZm9yDQo+ID4gPiA+IHZkb3N5cw0K
PiA+ID4gPiANCj4gPiA+ID4gIC4uLi9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUtY2hlcnJ5LmR0
c2kgICAgICB8ICAxMCArDQo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfZHJ2LmggICAgICAgfCAgIDMgKw0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX292bC5jICAgICAgIHwgIDMxICstDQo+ID4gPiA+ICAuLi4vZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jICAgfCAgMTUgKw0KPiA+ID4gPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICAgIHwgMjcxDQo+ID4gPiA+ICsrKysr
KysrKysrKysrKysrLQ0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5oICAgICAgIHwgICAxICsNCj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcF9jb21wLmMgICB8ICAxNCArDQo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oICAgfCAgMTMgKw0KPiA+ID4gPiAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgICAgICAgIHwgIDE2ICstDQo+ID4gPiA+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYyAgICAgICAgfCAxMjEgKysrKysrKysN
Cj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5oICAgICAgICB8
ICAxNiArKw0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUu
YyAgICAgIHwgICA3ICsNCj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X3BsYW5lLmggICAgICB8ICAgMiArDQo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX21kcF9yZG1hLmMgICAgICAgfCAgMTEgKy0NCj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfbWRwX3JkbWEuaCAgICAgICB8ICAgMiArDQo+ID4gPiA+ICBpbmNsdWRlL3Vh
cGkvZHJtL21lZGlhdGVrX2RybS5oICAgICAgICAgICAgICAgfCAgNTkgKysrKw0KPiA+ID4gPiAg
MTYgZmlsZXMgY2hhbmdlZCwgNTc1IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiA+
ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvdWFwaS9kcm0vbWVkaWF0ZWtfZHJtLmgN
Cj4gPiA+ID4gDQo=
