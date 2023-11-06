Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA257E1904
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 03:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjKFC7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 21:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFC7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 21:59:51 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4122BB;
        Sun,  5 Nov 2023 18:59:46 -0800 (PST)
X-UUID: 8807b8287c5011eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WkWcU96Fvs216VWu/vP1LOmxP2Fyb60guRJauZLYvQM=;
        b=VP2j1KKB2PiOtgXlt1uK5bgcbb53+Y1Swty0GcJY9bkZPqSG237ius54Cs8JH368sxU3NaJrFCBf+b3Eedsf84y0U78V3Vd7O1XAgPS/Hgknm15MNNhUTXos/vBmNdeINHi6NQZHh7YJCvFgXYkFoj5iIZE3mwNArSXlTjir8BE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:1f48459f-6184-4f36-8134-b8e66e943f90,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:3c694e72-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8807b8287c5011eea33bb35ae8d461a2-20231106
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 958188839; Mon, 06 Nov 2023 10:59:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 10:59:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 10:59:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOWYkgWcc4WC4mJVdW3ms1QDJOuVcHhWU+x/V03JMwAI0fSkUiFLtAhuC3B7kOt4MOItR5VB5U+3PUnibr5gHuTR/jfajb8TGl1TjhKwoORxXA4afJT5BtjdvaiiTQgUQLrmIKmOvNlo1jDjmJAc24bgbRT4jbHZB/kbOvqGJ/XPlkOgrKBAX79SGlGt4Gz2+nsJg3m5OTwBhVivfe5VfYdmAi7foV91nfSOX/wEPPL/sPZELd7ZaM172KRgmYnC51JU/YlcvRmlWsVEaMzSq80+4TJ76ydvwEFQNC73+KVZuvagZrAei9GQDS28NIrZGsuhxsboi47VnfGBD1xRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkWcU96Fvs216VWu/vP1LOmxP2Fyb60guRJauZLYvQM=;
 b=aUWmjSg+Z/xJ2dfpGauF8SyrDa0pydfwH63MM4WXdH8rPNQMISp06B3qRkx7NrWOVyeFeqWyG+2aUh13bUz/zFz6bmweqPHc76rwkwt+zN6b0U7+qN2coRZgckYAK/n6h2/EL2fx3gMJspbmKXXpWfTm8NCsU9hiIAsHV0LwdX4raCUSaJXtjItIeN+uwf8k1oDqkK7k9CbGQn0I3Es0XRPNwn+4rTUmhQ40Af75xgSd6w8RKHjVtyB3xXwAcnqhj0wSDdrQljjGApYBg9nBPrQS3mITbyZpMQHswyANlcI7lk2dcXeNfzuP1/TUZTdGrlhI986mMWZpR0N2jBOMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkWcU96Fvs216VWu/vP1LOmxP2Fyb60guRJauZLYvQM=;
 b=B4AAcQoHG03YhvgWcc8aHfX1qqrdS/4St8fRppmYMv63a16dsiLgT9Qr8d6UWJ1DwsXLPenUwxNLA7iRwmVUkRnxYK1JI/bRsGZjE7cWTbL7GdRLWkdt103jKGkFwMWJ0BCyE40jtGgU5DrnNBhzWBBm33gTqGdO5bU6Ihy+OL4=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB5677.apcprd03.prod.outlook.com (2603:1096:400:65::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 02:59:37 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.6954.025; Mon, 6 Nov 2023
 02:59:36 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Topic: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Index: AQHaBWvxkYcM1loCq06xiO/urU0GrLBjdJyAgAhR3ICAAM+UAIAAGaeA
Date:   Mon, 6 Nov 2023 02:59:36 +0000
Message-ID: <310f3588d65d18ead5e07c85ae656a8d94507a04.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-10-jason-jh.lin@mediatek.com>
         <02187af1e98093d20a170d0ce4b2b428c7eee37d.camel@mediatek.com>
         <c0b47da99e0a43e867a3fb27efc36786d4315aea.camel@mediatek.com>
         <137cd99b6749e7a2e3b7fa091fd9a20d3c798c53.camel@mediatek.com>
In-Reply-To: <137cd99b6749e7a2e3b7fa091fd9a20d3c798c53.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB5677:EE_
x-ms-office365-filtering-correlation-id: f99c178c-d763-461f-039b-08dbde746931
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uihVtJ+AbAXy4TC4xEPyOBum7pHku0L1GgGK8KaC8C3U4oR7r6DdCpEkqQlTEFPL2LJ4g0dOt3DD1s8hr/6P3xB0a2beUOln+JBgbuRsoP+k1CrI7PgRv2a0IMT3Qs6QbiF70j+qQAHNabgGlMPAT7yM6E6kfL5/ovtszD87wZzwG0N63oh/tZtiu8u/juudIqMBxFYpi0Byfpb/ue8gl0IpdkbXBAV/gOUB0WoRekf5LaDJlryk4HP6mllZgDJEajZnX+N3tL48ePWMY5kWvZKcCl9mea3/sxIs9dkrhGzbvFs80mA/ZgX7um6C6n2n0pJPqLI0QgxlY9gLa5aXkCr/cDsVzvwSjO/lPYNUYSDVbo1RApYLMnYw2L+BOIwrp3+T/Q1q0GisqMuQcDUuMQ4oN18yvVTPkXriXA01m+n9W/LkwRPRuN97BVb310ny8W26Y95XatrnS36BgPO6j6uHDKGtd4+9U3pNGE1n0czxlLFY6fR4NnE67t85xESaaAJWH/rSW4B1AQ6uxTUosMnB/GpMx2NDsgArscoDkntqJ43q8ho5tAAEqMwL/Dx/JmMljfcxf3ez2R3GpC6Bvad53FiCn3upECIXRUrTmIvfjEvIamQLnzVEpa9u6UPkBEDSOiSLMxWEcDytpq8RCGHcP5b+0Esi4nRhdeTWrrk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(2616005)(6512007)(6486002)(71200400001)(478600001)(83380400001)(26005)(76116006)(2906002)(4001150100001)(41300700001)(5660300002)(7416002)(66446008)(66556008)(64756008)(66946007)(66476007)(316002)(91956017)(110136005)(4326008)(8676002)(8936002)(54906003)(38070700009)(38100700002)(85182001)(36756003)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVYzaGl3amc1cDI1dm5VdFdIVFhUdXJhR2xheFpqN1NOaVZLZWlacWVBeWFY?=
 =?utf-8?B?VjErNzRRRUVWTWtWd29BWTJuY0VQZGNxNFlZSkNWMUxkSGlOaURvcHdkc1FG?=
 =?utf-8?B?MXdSeHZlOERmWCtwQk03VE5FbFBNQWY2d2NGU0pOait6b3p5dnZibkRwUVZl?=
 =?utf-8?B?ZDlKbjVua3JsblFvek91bEplRytFUWZuYkd4Y1JwQ2IrV1B6YUhjSEpQMmpT?=
 =?utf-8?B?SnJsdnhNS1Eyc3BzMEhtaVJFSjJ1bTgzTTBUeDV3MTVGeGtTNG9DaUJOOXVi?=
 =?utf-8?B?TU5ZMFVVU0tReGVSemtUU294Y213MXcvbUNVTW9RTm56RXBYMzRYdmZEUXdy?=
 =?utf-8?B?QUkveTVob1JDNmlaSG5QaG91WlVqYzBqamxoclREWEluOWlTUkYrZ2FvemJC?=
 =?utf-8?B?aTZvMjhWWWRIa1FYcTFyOFpleG43UUIwNFlaMExNL1RZeEFoR2ViY2dGMmFr?=
 =?utf-8?B?ZFZtekg0N0F4Yk1qTXBtcGF5SjhqWXRwdzdKQTlDOE1DdkkxaHhxRXlsQ0ox?=
 =?utf-8?B?RVhEVUY4ZjkyREdPWlh2c2FaNFgvL25kRHdWS3pNd2MxYS9jRHl6SHJaeXpF?=
 =?utf-8?B?UkpUQUt3dWdHUmxWaEpENHh3ci9lM3hoejY4dHJmZFptWXNKRHRkUldyOVFX?=
 =?utf-8?B?U3pYa0VkcEMwRXB4a0lyai9tM01xdXpVL0VndGdqc1BVcGEvck1WaDgzQnB4?=
 =?utf-8?B?ZGd2eGFyYnROYTh3Y0ZWcjYraURzYWlmTU56VmtON2FxdjZiVEF3Y3k3Ti9H?=
 =?utf-8?B?ckVSWGN6bXNBZ1lwRmo5UnJOOENXdVNIaVFYSFY5YUFTaFVJVnJMTW01TEdB?=
 =?utf-8?B?dnF4bmpHTkczUXRzcGpwM3pXVUxnVHJzdkxPcHo1K0dTYjR5UzhEZmFoaUN2?=
 =?utf-8?B?YXZMTisvNXBrYVlRbVdiMWJUM1MwZ1ByRzh0cGNBOGRuVVlYazh6dDVqQ0dY?=
 =?utf-8?B?MXN5OGhEbVBpZHh5SWZCVE9XR2tONTQ3THl3WmJtR2JHbUZsUVI2QVk2cUd5?=
 =?utf-8?B?N1F0YUFKaDEyQk5SSjVvcnNNU3JWcENwQXJWbGZPU2hwTFhYYXp6TldweWVW?=
 =?utf-8?B?VVJFRlFlZlNFa1Y3L2lDMjAyekV2dXNEWnpDZUo4eDNzZndUQis3NVZSWjVw?=
 =?utf-8?B?NkZPejcvVkJoalQ1SXAyaVpuNkJhV3M0RkJFQ2JyNUVycW9BaUwwYW1wdFNa?=
 =?utf-8?B?bEZDdWlNa1hOWS93dk5PL1NUaXpCOTZ4RWQ5VW9QeTZzMWFOc05ZNU1SWWV1?=
 =?utf-8?B?d0txS1VNMmw5Q25OTXlHUEgxMVQraGhVVGg4MU5uT0RtQ05uTG9aa2xEVVNP?=
 =?utf-8?B?WmZpRE42MUhsVmtPSW1TSnhjSU5RRFo1QnBPTU5vKzlnVDVMckVyQVo3QWhM?=
 =?utf-8?B?QjlGbGwxQko3M0lqQ3JWZEdPQkgzKzIyWi8zK0hXbnhBQTMwZ1ZwSWZtUnlt?=
 =?utf-8?B?V251bXZ6anhxNXVkUC96SE5URHd0bW04UWJBc0R2RU9rSjN3a0FTaTVEN0hI?=
 =?utf-8?B?dUJhWlNyTTJlTVhhVG5RSkVSUHFMRWV4dWxHQkJPZFZOYmdMM0ZUTGxJVGQz?=
 =?utf-8?B?MFRQUHpZV0ZkUTZ5RmlFRmJTWGZ1Rll3SEd0T1liL2tKYURvRU5KUDFIUjkz?=
 =?utf-8?B?cnExZlNKekFBYjJnWUluSXF5U21MYytjSWFtRnNyVklyaDNKYTNxOGR6OUpI?=
 =?utf-8?B?SE80UjNVT2N3b3BpaXVteDZrc25RclBWM05qcEVLNmtXbkQzQm5OUDJXeFhS?=
 =?utf-8?B?RFUrRnBydnd3dVpydjBadU1QdjhzSnAzbUNmaUM3MnNsS29pT0E2QXh1aXA3?=
 =?utf-8?B?emNPaHpTa0hTM3A5TU5ZbWZXbnJ4VnRJaEpGdVZTZjdkRmJ4ZE4vU0hTcVEz?=
 =?utf-8?B?c0l1bFRNYmhrQVYvU01ES0I4dHRIVzRNeGp1NG43MWpWK0IyUmJaSGRiTk0r?=
 =?utf-8?B?dXJWR1g2UlVRSHdxcWxjYkdUMzRGTHZ1L2JWVllNaWxoVmZWZnNJNTIxUnFo?=
 =?utf-8?B?K1JZVnRVMVZQRUdZbUwzVDV4YnBLZzVabWhtOVBGam93ZXk1RExPTy8xZWk1?=
 =?utf-8?B?dkpQbmtpeUduYWxmWkV5bXo5ZHBNbzdrek5oMWpIZGtJbnRlR0t2eTQ5QmxM?=
 =?utf-8?B?aVhMOWM1TVRwV1AwL0hEOTk3eXJ0NERIUXhhZ1ozRk9pTXlrcFdDdStpMnBt?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DA699DE8A970F499EF2D9E0C130AA70@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99c178c-d763-461f-039b-08dbde746931
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 02:59:36.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7JJbEZS65XnmQx3pOMcmT2n0VSEo9PrEXhUm7n6CvTSwNdDQFuHMUtA3ZlAukIPzS15nsx+AjBmRYsPm2X3vEyFQK/SREyAlGhJQdl4wUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5677
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.107200-8.000000
X-TMASE-MatchedRID: X4bcv0S75Kn4OiVTWoD8RCa1MaKuob8Pt3aeg7g/usCe9toQ6h6LE9j3
        ZmXrgmMgUP1MXr5ntoTa0d8z9Gm40BtlRBeFg9jMTd1FGyH+HrKZf5btvM85AenZDXpMs2JZGlS
        ob8qphoEZB0R4cFpbTf62rxjX6Lwx6fubsV+A+k+HZXNSWjgdU7uesBT0pDFR2viB/Jr4D1QfZ/
        c4tyoTbUIuHOzPMNGSCn3hS1T7H+eU2fVedEQUOzo39wOA02Lh+eBf9ovw8I0Cgjr7b0ytGcmL/
        yOcY1B66UiXS+55JmqvMY7/3p558hpTtEEj9y1VkX71Hy/ufOZA8JZETQujwizt4/lw8JZDq5e+
        OHSSDFz992Ze0+dF0EpKl9IzBLfbYDYgBcRN64qeAiCmPx4NwMFrpUbb72MU1kTfEkyaZdz6C0e
        Ps7A07QKmARN5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.107200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E2E266A0CDC02EF62441CC741984DCFF43FA109901F7D863AB06E59CD5FBB7FB2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTA2IGF0IDAxOjI3ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gT24gU3VuLCAyMDIzLTExLTA1IGF0IDEzOjA0ICswMDAwLCBKYXNvbi1KSCBMaW4gKOae
l+edv+elpSkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIzLTEwLTMxIGF0IDA2OjAxICswMDAwLCBD
SyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiA+IEhpLCBKYXNvbjoNCj4gPiA+IA0KPiA+ID4g
T24gTW9uLCAyMDIzLTEwLTIzIGF0IDEyOjQ1ICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+
ID4gPiA+IFRvIGFkZCBzZWN1cmUgZmxvdyBzdXBwb3J0IGZvciBtZWRpYXRlay1kcm0sIGVhY2gg
Y3J0YyBoYXZlIHRvDQo+ID4gPiA+IGNyZWF0ZSBhIHNlY3VyZSBjbWRxIG1haWxib3ggY2hhbm5l
bC4gVGhlbiBjbWRxIHBhY2tldHMgd2l0aA0KPiA+ID4gPiBkaXNwbGF5IEhXIGNvbmZpZ3VyYXRp
b24gd2lsbCBiZSBzZW50IHRvIHNlY3VyZSBjbWRxIG1haWxib3gNCj4gPiA+ID4gY2hhbm5lbA0K
PiA+ID4gPiBhbmQgY29uZmlndXJlZCBpbiB0aGUgc2VjdXJlIHdvcmxkLg0KPiA+ID4gPiANCj4g
PiA+ID4gRWFjaCBjcnRjIGhhdmUgdG8gdXNlIHNlY3VyZSBjbWRxIGludGVyZmFjZSB0byBjb25m
aWd1cmUgc29tZQ0KPiA+ID4gPiBzZWN1cmUNCj4gPiA+ID4gc2V0dGluZ3MgZm9yIGRpc3BsYXkg
SFcgYmVmb3JlIHNlbmRpbmcgY21kcSBwYWNrZXRzIHRvIHNlY3VyZQ0KPiA+ID4gPiBjbWRxDQo+
ID4gPiA+IG1haWxib3ggY2hhbm5lbC4NCj4gPiA+ID4gDQo+ID4gPiA+IElmIGFueSBvZiBmYiBn
ZXQgZnJvbSBjdXJyZW50IGRybV9hdG9taWNfc3RhdGUgaXMgc2VjdXJlLCB0aGVuDQo+ID4gPiA+
IGNydGMNCj4gPiA+ID4gd2lsbCBzd2l0Y2ggdG8gdGhlIHNlY3VyZSBmbG93IHRvIGNvbmZpZ3Vy
ZSBkaXNwbGF5IEhXLg0KPiA+ID4gPiBJZiBhbGwgZmJzIGFyZSBub3Qgc2VjdXJlIGluIGN1cnJl
bnQgZHJtX2F0b21pY19zdGF0ZSwgdGhlbg0KPiA+ID4gPiBjcnRjDQo+ID4gPiA+IHdpbGwNCj4g
PiA+ID4gc3dpdGNoIHRvIHRoZSBub3JtYWwgZmxvdy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiA+
ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMg
IHwgMjcyDQo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKystDQo+ID4gPiA+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmggIHwgICAxICsNCj4gPiA+ID4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMgfCAgIDcgKw0KPiA+ID4gPiAgMyBm
aWxlcyBjaGFuZ2VkLCAyNjkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4gPiA+
IA0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ID4gPiArDQo+ID4gPiA+ICsjaWYgSVNfUkVBQ0hBQkxF
KENPTkZJR19NVEtfQ01EUSkNCj4gPiA+ID4gK3N0YXRpYyB2b2lkIG10a19jcnRjX2VuYWJsZV9z
ZWN1cmVfc3RhdGUoc3RydWN0IGRybV9jcnRjDQo+ID4gPiA+ICpjcnRjKQ0KPiA+ID4gPiArew0K
PiA+ID4gPiArCWVudW0gY21kcV9zZWNfc2NlbmFyaW8gc2VjX3NjbiA9IENNRFFfTUFYX1NFQ19D
T1VOVDsNCj4gPiA+ID4gKwlpbnQgaTsNCj4gPiA+ID4gKwlzdHJ1Y3QgbXRrX2RkcF9jb21wICpk
ZHBfZmlyc3RfY29tcDsNCj4gPiA+ID4gKwlzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YyA9
IHRvX210a19jcnRjKGNydGMpOw0KPiA+ID4gPiArCXU2NCBzZWNfZW5naW5lID0gMDsgLyogZm9y
IGh3IGVuZ2luZSB3cml0ZSBvdXRwdXQNCj4gPiA+ID4gc2VjdXJlIGZiICovDQo+ID4gPiA+ICsJ
dTY0IHNlY19wb3J0ID0gMDsgLyogZm9yIGxhcmIgcG9ydCByZWFkIGlucHV0IHNlY3VyZSBmYg0K
PiA+ID4gPiAqLw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJY21kcV9wa3Rfd2ZlKCZtdGtfY3J0Yy0+
c2VjX2NtZHFfaGFuZGxlLCBtdGtfY3J0Yy0NCj4gPiA+ID4gPmNtZHFfZXZlbnQsDQo+ID4gPiA+
IGZhbHNlKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWRkcF9maXJzdF9jb21wID0gbXRrX2NydGMt
PmRkcF9jb21wWzBdOw0KPiA+ID4gPiArCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0Yy0+bGF5ZXJf
bnI7IGkrKykNCj4gPiA+ID4gKwkJaWYgKG10a19jcnRjLT5wbGFuZXNbaV0udHlwZSA9PQ0KPiA+
ID4gPiBEUk1fUExBTkVfVFlQRV9DVVJTT1IpDQo+ID4gPiA+ICsJCQlzZWNfcG9ydCB8PQ0KPiA+
ID4gPiBtdGtfZGRwX2NvbXBfbGF5ZXJfZ2V0X3NlY19wb3J0KGRkcF9maXJzdF9jb21wLCBpKTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmIChkcm1fY3J0Y19pbmRleChjcnRjKSA9PSAwKQ0KPiA+
ID4gPiArCQlzZWNfc2NuID0gQ01EUV9TRUNfUFJJTUFSWV9ESVNQOw0KPiA+ID4gPiArCWVsc2Ug
aWYgKGRybV9jcnRjX2luZGV4KGNydGMpID09IDEpDQo+ID4gPiA+ICsJCXNlY19zY24gPSBDTURR
X1NFQ19TVUJfRElTUDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWNtZHFfc2VjX3BrdF9zZXRfZGF0
YSgmbXRrX2NydGMtPnNlY19jbWRxX2hhbmRsZSwNCj4gPiA+ID4gc2VjX2VuZ2luZSwNCj4gPiA+
ID4gc2VjX3BvcnQsIHNlY19zY24pOw0KPiA+ID4gDQo+ID4gPiBJbiBjbWRxIGRyaXZlciwgc2Vj
X2VuZ2luZSBtZWFucyBlbmdpbmUgd2hpY2ggbmVlZCBkYXBjLiBZb3Ugc2V0DQo+ID4gPiAwDQo+
ID4gPiB0bw0KPiA+ID4gc2VjX2VuZ2luZSwgZG9lcyBpdCBtZWFuIHRoYXQgbm8gZW5naW5lIGlz
IHByb3RlY3RlZCBieSBkYXBjPyBJZg0KPiA+ID4gT1ZMDQo+ID4gPiBpcw0KPiA+ID4gbm90IHBy
b3RlY3RlZCBieSBkYXBjLCBJIHRoaW5rIHdlIGNvdWxkIHVzZSBjbWRxIG5vcm1hbCB0aHJlYWQg
dG8NCj4gPiA+IHdyaXRlDQo+ID4gPiBPVkwgcmVnaXN0ZXIgaW5zdGVhZCBvZiBjbWRxIHNlY3Vy
ZSB0aHJlYWQuDQo+ID4gPiANCj4gPiANCj4gPiBXZSBlbmFibGUgRFBBQyBwcm90ZWN0aW9uIGZv
ciB0aGUgZW5naW5lIHRoYXQgaXMgYWJsZSB0byB3cml0ZSBkYXRhDQo+ID4gdG8NCj4gPiB0aGUg
RFJBTSBhZGRyZXNzIHNldCBvbiB0aGVpciByZWdpc3Rlciwgc3VjaCBhcyBXRE1BIGFuZCBXUk9U
LCB0bw0KPiA+IGF2b2lkDQo+ID4gdGhlaXIgcmVnaXN0ZXIgYmVpbmcgc2V0IHRvIHRoZSBub3Jt
YWwgRFJBTSBhZGRyZXNzLg0KPiA+IA0KPiA+IFdlIGVuYWJsZSBsYXJiIHBvcnQgcHJvdGVjdGlv
biBmb3IgdGhlIGVuZ2luZSB0aGF0IGlzIGFibGUgdG8gcmVhZA0KPiA+IGRhdGENCj4gPiBmcm9t
IHRoZSBEUkFNIGFkZHJlc3MsIHN1Y2ggYXMgT1ZMLCBSRE1BIGFuZCBNRFBfUkRNQSwgdG8gYXZv
aWQNCj4gPiBzZWN1cmUNCj4gPiBEUkFNIGJlaW5nIHJlYWQgYnkgdGhlIG5vbi1zZWN1cmUgbGFy
YiBwb3J0LiBTbyB3ZSBkb24ndCBuZWVkDQo+ID4gdG9lbmFibGUNCj4gPiBEQVBDIGZvciB0aGVz
ZSBlbmdpbmVzLg0KPiA+IA0KPiA+IE5vIG1hdGVyIERBUEMgcHJvdGVjdGlvbiBvciBsYXJiIHBv
cnQgcHJvdGVjdGlvbiwgdGhleSBib3RoIG5lZWQgdG8NCj4gPiB1c2UNCj4gPiBzZWNfZW5naW5l
IHRvIHRlbGwgVEVFIHdoaWNoIGVuZ2luZXMgbmVlZCB0byBiZSBwcm90ZWN0ZWQuDQo+ID4gDQo+
ID4gQnV0IE9WTCBpcyBhIHNwZWNpYWwgSFcgZW5naW5lLCBpdCBjYW4gb25seSBzZXQgaXRzDQo+
ID4gRElTUF9SRUdfT1ZMX1NFQ1VSRQ0KPiA+IHJlZ2lzdGVyIGluIFtQQVRDSCB2MiAwNy8xMV0g
dG8gZW5hYmxlIGl0cyBsYXJiIHBvcnQgcHJvdGVjdGlvbiwgc28NCj4gPiBPVkwNCj4gPiBubyBu
ZWVkIHRvIHNldCB0aGUgc2VjX2VuZ2luZS4gQnV0IHdlJ2xsIG1vdmUgdGhhdCBwYXJ0IHRvIHRo
ZSBURUUNCj4gPiBzZWN1cmUgd29ybGQsIHNvIHRoYXQgbWVhbnMgT1ZMIHNlY19lbmdpbmUgd2ls
bCBiZSBzZXQgaGVyZSBpbiB0aGUNCj4gPiBuZXh0DQo+ID4gdmVyc2lvbi4NCj4gPiANCj4gPiA+
IEl0J3Mgd2VpcmQgdGhhdCBub3JtYWwgd29ybGQgY291bGQgZGVjaWRlIHdoaWNoIGVuZ2luZSBp
cw0KPiA+ID4gcHJvdGVjdGVkDQo+ID4gPiBieQ0KPiA+ID4gZGFwYy4gSWYgaGFja2VyIHNldCAw
IGZvciBvdXRwdXQgZW5naW5lLCB0aGVuIG91dG91dCBlbmdpbmUgd291bGQNCj4gPiA+IG5vdA0K
PiA+ID4gYmUgcHJvdGVjdGVkPw0KPiA+ID4gDQo+ID4gDQo+ID4gSWYgaGFja2VyIHNldCAwIGZv
ciBvdXRwdXQgZW5naW5lLCBURUUgd29ybGQgd2lsbCBjaGVjayB0aGF0IG91dHB1dA0KPiA+IGVu
Z2luZSBkaWRuJ3Qgc2V0IHNlY19lbmdpbmUgZnJvbSBub3JtYWwgd29ybGQgYnkgdmVyaWZ5aW5n
DQo+ID4gaW5zdHJ1Y3Rpb24NCj4gPiB3aGVyZSB0aGUgb3V0cHV0IGVuZ2luZSBpbnN0cnVjdGlv
biBzZXQgdGhlIHNlY3VyZSBoYW5kbGUuDQo+ID4gDQo+ID4gV2Ugc3RpbGwgbmVlZCB0byBzZXQg
c2VjX2VuZ2luZSB0byBjaGVjayB0aGF0IGFsbCB0aGUgc2VjX2VuZ2luZQ0KPiA+IGZhZ3MNCj4g
PiBhcmUgbWF0Y2hlZCB0byB0aGUgc2NlbmFyaW8gYW5kIGluc3RydWN0aW9uIHZlcmlmaWNhdGlv
biBpbiB0aGUNCj4gPiBzZWN1cmUNCj4gPiB3b3JsZC4NCj4gDQo+IFNvIGFmdGVyIHNlY3VyZSBz
Y2VuYXJpbyBpcyBzZXQsIFRFRSBhbHJlYWR5IGhhdmUgYSBzZWNfZW5naW5lIGxpc3QuDQo+IExl
dCdzIGNhbGwgaXQgVEVFIHNlY19lbmdpbmUgbGlzdC4gQW5kIG5vcm1hbCB3b3JsZCBoYXMgYW5v
dGhlcg0KPiBzZWNfZW5naW5lIGxpc3QsIGxldCdzIGNhbGwgaXQgbm9ybWFsIHNlY19lbmdpbmUg
bGlzdC4gTm9ybWFsIHdvcmxkDQo+IHBhc3Mgbm9ybWFsIHNlY19lbmdpbmUgbGlzdCB0byBURUUg
YnkgY21kcV9zZWNfcGt0X3NldF9kYXRhKCkgYW5kIFRFRQ0KPiB3b3VsZCBjaGVjayBub3JtYWwg
c2VjX2VuZ2luZSBsaXN0IGlzIGlkZW50aWNhbCB0byBURUUgc2VjX2VuZ2luZQ0KPiBsaXN0DQo+
IG9yIG5vdC4gSWYgVEVFIGFscmVhZHkgaGF2ZSBhIFRFRSBzZWNfZW5naW5lIGxpc3QsIEkgdGhp
bmsgaXQncyBub3QNCj4gbmVjZXNzYXJ5IHRoYXQgbm9ybWFsIHdvcmxkIGhhdmUgYW5vdGhlciBu
b3JtYWwgc2VjX2VuZ2luZSBsaXN0LiBTbw0KPiBkcm9wIHRoaXMgbm9ybWFsIHNlY19lbmdpbmUg
bGlzdCBwYXJhbWV0ZXIuDQo+IA0KDQpUaGUgVEVFIHNlY19lbmdpbmUgbGlzdCBpcyBhbGlnbiB0
byB0aGUgc2VjX2VuZ2luZSBsaXN0IGluIG5vcm1hbA0Kd29ybGQuIEkgdGhpbmsgdGhlIHNlY19l
bmdpbmUgZm9yIERBUEMgY2FuIGJlIGRyb3BwZWQgYW5kIGl0IGNhbiBiZQ0KZW5hYmxlZC9kaXNh
YmxlZCBieSB0aGUgVEVFIHNlY19lbmdpbmUsIGJ1dCB0aGUgc2VjX2VuZ2luZSBmb3IgbGFyYg0K
cG9ydCB3b24ndCBkbyB0aGF0IHZlcmlmaWNhdGlvbiBpbiB0aGUgc2VjdXJlIHdvcmxkLiBJZiBz
ZWNfZW5naW5lIGZvcg0KbGFyYiBwb3J0IGlzIG5vdCBzZXQgaW4gbm9ybWFsIHdvcmxkLCBpdCds
bCBjYXVzZSBpb3ZhIHRyYW5zbGF0aW9uDQpmYXVsdC4gU28gd2Ugc3RpbGwgbmVlZCB0aGlzIHNl
Y19lbmdpbmUgZm9yIGxhcmIgcG9ydC4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IFJl
Z2FyZHMsDQo+IENLDQo+IA0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gSmFzb24tSkguTGluDQo+
ID4gDQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gQ0sNCj4gPiA+IA0KPiA+ID4gPiArDQo+ID4gPiA+
ICsJcHJfZGVidWcoImNydGMtJWQgZW5hYmxlIHNlY3VyZSBwbGFuZSFcbiIsDQo+ID4gPiA+IGRy
bV9jcnRjX2luZGV4KGNydGMpKTsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKyNlbmRpZg0KPiA+ID4g
PiANCg==
