Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0470D76E34C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjHCIjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjHCIiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:38:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC5B5259
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:37:22 -0700 (PDT)
X-UUID: ebd51ed031d811eeb20a276fd37b9834-20230803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XQcRM4WyvGW+E3vB99trVUI+H69ivc5cFCF1tN4hHUU=;
        b=AbRp28YmyrExUb+3c2VRgw9LM7eGBzDLquJDu77TTWMUijAOoWRNO3mhG9K0rKFZvdZ+TsnnaEwYebVhtVaHiTCPsAovt1KiisT4CNE+vvKpAeU9BZH1xI4VaGTnPNgA0WM9nAcpbR5vBPX61xP0QkP5HDxkbb/8bZYEGN4L8Is=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:63e3aa2d-0f12-4ca2-986d-1ea211801b37,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.30,REQID:63e3aa2d-0f12-4ca2-986d-1ea211801b37,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:1fcc6f8,CLOUDID:3982d8a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230802142435MNZ91OK9,BulkQuantity:33,Recheck:0,SF:28|17|19|48|38|29|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_FCD
X-UUID: ebd51ed031d811eeb20a276fd37b9834-20230803
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 424333741; Thu, 03 Aug 2023 16:37:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 3 Aug 2023 16:37:02 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 3 Aug 2023 16:37:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6a+eS1vIrGfoCb1s6CV0Izu9xnaRLqHJ0zvMaM9bi3mOxDYlzucVNoid/+8U08mTz0Qub6waKY06UnmP/wgQmV32mh20pBU2btMyzuQZ79VEF1x151enO90IdUccqqwRANiTVpO1Vc+5jIp4Uwyu9qjb+fTSsmQT3v7dxT195SO5MfTdib1dN+4Kl5HHJBErcMAp4uBPs4p52zUHW5sYslYS0x7/0jYTJcwwguth8SVBmMxGYKlsWCfkwG5ejpBUtzeX8YpdmBjUaIr1KzqWEdpuPTg90N9eRv8hSml6lwxC6Oir5EYBT5ousrxt9ytSA9zeImiGGZsv3A4cvXmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQcRM4WyvGW+E3vB99trVUI+H69ivc5cFCF1tN4hHUU=;
 b=ZO2MkfNOnqgAGv3wgtBT5r12QYXbsnVE11U0RiksbKbgy9k2EhAMxIm9wg8jxZYGV+dLStGYJrH3D2tuF91VkKrXEE5WlQ5IQzK+lbEFRETFDIk15YriCmJ/bce35K1UJ390Dhw2bwISKzJO3HtP4rS2+hvuTQ+9ytyYTEvtp7lrAWOa6z3kG8bZAzSi4L7wyUPSaE+bqPbEbqumn2GKByEJ6cMwL/OD/LutnUITtqqbMlY2sOWb67vdWttFL34hFQKTqJlHWCKEFAi+ARCqaSgfAfU9avj2XIaW2x9XYGKo7tX9zR4du+iQ/P9tOdloXjxlqghqlSKWqCu5A+Iyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQcRM4WyvGW+E3vB99trVUI+H69ivc5cFCF1tN4hHUU=;
 b=Y9sE4AmkZN9e76Zg/K4zIgs9odwrIn3YxM9y6jGQf4pO4YKBSszuPTVyu96/0Ej2nuucNYotj4v2tYgWt5qZ4niLp0vkyiQoIqekwLfSCV8HmLWAhsnAJQsk6yOxYM7aXqyV3n/MYKSoY7N8NxP81ceakeuivIaoy5aDJXUmm3s=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB6341.apcprd03.prod.outlook.com (2603:1096:4:178::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 08:37:00 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 08:37:00 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/3] drm/mediatek: Dynamically allocate CMDQ and use
 helper functions
Thread-Topic: [PATCH 1/3] drm/mediatek: Dynamically allocate CMDQ and use
 helper functions
Thread-Index: AQHZpbghA43V0G2y6EGRogXrDPk526/WyH+AgABHuACAAUvMgIAAILQAgAADLoA=
Date:   Thu, 3 Aug 2023 08:37:00 +0000
Message-ID: <7175ec117988657c2fb7bf6d50b67d60038e3a54.camel@mediatek.com>
References: <20230623094931.117918-1-angelogioacchino.delregno@collabora.com>
         <20230623094931.117918-2-angelogioacchino.delregno@collabora.com>
         <bd19faf644fa80f8fa77ed0841a724aa3ca871f5.camel@mediatek.com>
         <0acd286d-d4f4-97b2-c296-b2860a00def6@collabora.com>
         <e8e60556e53ccf319358cbef203bc84c418a352b.camel@mediatek.com>
         <d29d342b-37f4-8d7b-ed7d-c441cc928393@collabora.com>
In-Reply-To: <d29d342b-37f4-8d7b-ed7d-c441cc928393@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB6341:EE_
x-ms-office365-filtering-correlation-id: eb6d1bae-24f8-457b-e13f-08db93fcce42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8rQecBAqwrLqvm2AK+hU1BGRgML9wjzimVv36oDMCWQ5yuQnvoYBvcMIbRemt/A1kVZrUFK0l7+cKbaegUci8rOqZgXT95t6c3gF2IcPkJMAGsAcUUQn51A0FHgggdLUR2FIep0we9dzNMhrkHzMyOlTeNG/EGIllxm2vtSXw6fTIBwi1WmH9fdL0BvC9WvcMtuxpx/PEk587U51hJH3TQB599LU3Jiea0gLR76esciickgM6sD9pWLsUsB9zqiXI5vV7viUAvFhNsUTARqIi1hQQJXTShTqAtR3Z5tGbki7i2j7TuKOahuBoboDZl8JufjE/bRSj0iHsvXJK/xLCDRweO5EKC0An6l6qERWfi3LAwhSNzzG8c9PvbxqOMswxB6mKfTT+XqMOmjRr9d/G95MIoYLVO+32kTs0RiLcyY65VvCfJHRq5TCmOssAJgiwQfW5Vw1CGdeCn+aFNNGeRN35WSDmkQ5JP1EboZTCy9g4eERRHZ7kASa5XrK3JQdpzBovma5Dp4dvm4LKYlAJH3ykyUNFCoVa5KS4j5+g76yyFHWvASW99LQZvTBa6RG1ODHXarg5Op8ODiwW5uVfn+qM4pNktB34a6Cbh3VkEn621ocsu1065UFN31Z/JhENTaXNwspYsNb4WtjJNc4pgs9sna3hS05Jp8/Yr/ZajM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(122000001)(6506007)(26005)(38100700002)(186003)(38070700005)(2616005)(83380400001)(2906002)(85182001)(36756003)(5660300002)(478600001)(8936002)(8676002)(110136005)(54906003)(86362001)(6512007)(71200400001)(6486002)(41300700001)(316002)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y25mQWcwMyszS2hMRUo1aFJXTGpwZVVkdDBzU2dlUnlQSjRKeEZtWjEzQXFw?=
 =?utf-8?B?YzVMVGp4VGtFbHNkT29xZWJoYTdzbjRKdHhsaUg2OHE2ZDhIUEhIMHBQMk85?=
 =?utf-8?B?T0JyU1ZYVml5RW9uUWVSZ2Y2YkpLcW9SMmRjazJZSnd1UmdJSzF3QzBoOVVO?=
 =?utf-8?B?TVRNZmorM0R4QlpTR0Rka0RmRjRHVXR6cnAwTlVXMFIxZUs5bVNZZitsZGdJ?=
 =?utf-8?B?cXp6ay9oS1ErMkxWc1hDeXN4eXhVS3JiS1dzVzhTK3U4SVRaR3ZqaTFoVE9L?=
 =?utf-8?B?OENJZGY5cXBCQzVoVE9wekk1MFVWclkrczd1MlA5dDBpZFNhMEM3cG81Qmhy?=
 =?utf-8?B?TWZ4NjFpRVRWUzJ4RjFpL0p0Qm1iUG5vWVArcTlXaTRxUVc4bmc3TEtpLzFO?=
 =?utf-8?B?OFQrNi9lV0MxT2RNVUNVUmVKMkJOMUorbFJDcDVpSUdZQ2FaR0w0cHZYaWJj?=
 =?utf-8?B?ZHlOMkJzRHBCdEZXSGFoZSs3TmZlU3FLcXJUenhGY1NkaW8yTjU1RDJuS1o0?=
 =?utf-8?B?TUJQUi9LRkNSR3Y1azhuUW5FdnI2bnBWNWE1QkZJeXJLYklldTJPdnJWZWNW?=
 =?utf-8?B?RGVaanRNcW1OVy84Y1F3TDZRVXNHNXR5Mms3cDNZVlhyKy82WXlNTkR5RmFn?=
 =?utf-8?B?dnJaeFo2cWE3S1JoUTBaSDkrc2w1NUxCQVpvcEtxY0liek5SWkplVXpGNTky?=
 =?utf-8?B?dGVERUlNY09LZ2krenFJUnpDWjhadXoyOVJsVTlXTWZQTzA4M2NlTENZTlpL?=
 =?utf-8?B?ZEE2cnNBeGtYZnFmMFBXSTA3UHhxZnVieGlVUm5HR1k2N2FWRGx3QmF3MmxO?=
 =?utf-8?B?Mk1JL3Qrb1JiNHVYSkJ5Q1YrNTgyamhSK0k0dEVyU0VMN0JIWTMrNUhlMXdY?=
 =?utf-8?B?cXlPclRZVWV0cll3VGUwK2tFakpCTi9EY1JJb3lxc0lqNHcyVGtrdUFZeHlS?=
 =?utf-8?B?ejVwUm1PNHN6OW9MbkFLcHlFSWZvZk9BQnVMT0s5YzEwRGtJLzVJVy9iWENW?=
 =?utf-8?B?NnJGTVJLR2F3VkN0RURvdUpURTB5S053QW4wUzlyYi8zeEVvUTlSeGloZ2g0?=
 =?utf-8?B?cWVmZ1dnWFVxVFY3RVBVOVZBb0paUWNVOW5UOWgzMEVCaExOMmNrVXJSK0Iv?=
 =?utf-8?B?dHZiVWF0SkZnczhCaCs1U3JZTElHUGZLQml6OG5aNjJkOW1FMHJCSXNScThl?=
 =?utf-8?B?ZitCSjQvM2IxcjJZbVBydEwrZ0FZSjc0SDMvTjFlL210TDYyeTNxMG1MMWhF?=
 =?utf-8?B?QjdUazVvUDRKVjg4MjVrL3l3NmlFdm5CaTNKeTEwNXl5L1dHVzhJZkgwT1N5?=
 =?utf-8?B?YThNRU9tQjd2U2RwUEhoTGREaDRTTmluWW1jcDJKeTdIWGszdkhKajJMV001?=
 =?utf-8?B?bXVIbEdsRTI5MUYvY1crM3Y5T1dKc3VQWGdmYUt3QUg0aW5iMzJka0t4ZC9a?=
 =?utf-8?B?QWNIVks1WFlxY21kbnhWNnR6VCsxMUlvaDBmMDhqSC9ZWEQvaG9vT2kxUlFU?=
 =?utf-8?B?UFE4MTczbFFmVFVHTGhDa203MzE2M3doSUs5eGYybVZWbnU2RENIR0gxU2dZ?=
 =?utf-8?B?dkxKV0RmMFJlS3IyNE1QSUdoVkVFRVBiVzlUU3QzV3U0LzUwM2R6OUtSSGpm?=
 =?utf-8?B?QVh0NDRPVUNoUDFGZTB4Z3RUQUlxTHZhTllMWVIzL0YvN0xCYk5Sc0lZdjFY?=
 =?utf-8?B?aW50c3FjSjMxMW42MjFuSXJFN0F4L0d6VlpndTBkOWswSmxYMGhCQmtnQWZQ?=
 =?utf-8?B?ZFRnQzNSZzFvWGlEN05jV3hsdXBjRkVHakwxbnBmd0JDYUZwbHl2NThOVDBW?=
 =?utf-8?B?SThwY2kyQ2hvYkVJeWo3RzFwdmFLU1NxU0pUeWlWU3VHTnNqd1NZeG5ua0Fo?=
 =?utf-8?B?T0xyMkQ3M3MwbGpqb3BNSUdDcGl5WWNrK3dKZ21xdHFNRG5CZU42anl6VDgw?=
 =?utf-8?B?MlBUcEsvMFh6VWh1eXkxSHMzTHBOZFkxcWwvRWRYNW42VVhuWnVuNUUyZDB5?=
 =?utf-8?B?bVR1SDJRVERBbmVKYUJ6bmtYY0lTbURPQnZRZFRzNUlTck5kd3JFc010R3g1?=
 =?utf-8?B?aVVnaS9tSU80SysrVENIQzhUYTQrNDJOd1JiRUxiTzQxZmxOSW5FK2lOVitq?=
 =?utf-8?Q?lRyQbX/32ftDTfPobs0lbn6OF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91AABBFAFAF44F47931D2AAD0ED7A755@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6d1bae-24f8-457b-e13f-08db93fcce42
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 08:37:00.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/W0LmVTiJ+bhUM/NLmYOz2PSLEEoUEv/70z3ObD/Y2Rcf5zBaOwxGVPeI7eTBlAWrWkgFjwKA8woXx1N6wopA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6341
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTA4LTAzIGF0IDEwOjI1ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMDMvMDgvMjMgMDg6MjgsIENLIEh1ICjo
g6Hkv4rlhYkpIGhhIHNjcml0dG86DQo+ID4gSGksIEFuZ2VsbzoNCj4gPiANCj4gPiBPbiBXZWQs
IDIwMjMtMDgtMDIgYXQgMTI6NDEgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+
ID4gd3JvdGU6DQo+ID4gPiBJbCAwMi8wOC8yMyAwODoyNCwgQ0sgSHUgKOiDoeS/iuWFiSkgaGEg
c2NyaXR0bzoNCj4gPiA+ID4gSGksIEFuZ2VsbzoNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIEZyaSwg
MjAyMy0wNi0yMyBhdCAxMTo0OSArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4g
PiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gICAgCQ0KPiA+ID4gPiA+IEV4dGVybmFsIGVtYWlsIDog
UGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuDQo+ID4gPiA+ID4gYXR0YWNobWVudHMN
Cj4gPiA+ID4gPiB1bnRpbA0KPiA+ID4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ID4gPiA+ID4gICAgSW5zdGVhZCBvZiBzdGFjayBhbGxvY2F0aW5n
IHRoZSBjbWRxX2NsaWVudCBhbmQNCj4gPiA+ID4gPiBjbWRxX2hhbmRsZQ0KPiA+ID4gPiA+IHN0
cnVjdHVyZXMNCj4gPiA+ID4gPiBzd2l0Y2ggdGhlbSB0byBwb2ludGVycywgYWxsb3dpbmcgdXMg
dG8gbWlncmF0ZSB0aGlzIGRyaXZlcg0KPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gdXNlDQo+ID4g
PiA+ID4gdGhlDQo+ID4gPiA+ID4gY29tbW9uIGZ1bmN0aW9ucyBwcm92aWRlZCBieSBtdGstY21k
cS1oZWxwZXIuDQo+ID4gPiA+ID4gSW4gb3JkZXIgdG8gZG8gdGhpcywgaXQgd2FzIGFsc28gbmVj
ZXNzYXJ5IHRvIGFkZCBhIGBwcml2YA0KPiA+ID4gPiA+IHBvaW50ZXIgdG8NCj4gPiA+ID4gPiBz
dHJ1Y3QgY21kcV9jbGllbnQsIGFzIHRoYXQncyB1c2VkIHRvIHBhc3MgKGluIHRoaXMgY2FzZSkg
YQ0KPiA+ID4gPiA+IG10a19jcnRjDQo+ID4gPiA+ID4gaGFuZGxlIHRvIHRoZSBkZHBfY21kcV9j
YigpIG1haWxib3ggUlggY2FsbGJhY2sgZnVuY3Rpb24uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+ID4gPiA+IGFu
Z2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4g
PiA+ID4gPiAgICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgfCAxMDcg
KysrKysrKy0tLS0tDQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gLS0tLS0tLQ0KPiA+ID4gPiA+
IC0tDQo+ID4gPiA+ID4gICAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAg
IHwgICAxICsNCj4gPiA+ID4gPiAgICAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyks
IDc2IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ID4gPiA+IGluZGV4IDBkZjYyYjA3
NmY0OS4uYjYzMjg5YWI2Nzg3IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ID4gPiA+IEBAIC01MCw4ICs1MCw4IEBAIHN0
cnVjdCBtdGtfZHJtX2NydGMgew0KPiA+ID4gPiA+ICAgIAlib29sCQkJCXBlbmRpbmdfYXN5bmNf
cGxhbmVzOw0KPiA+ID4gPiA+ICAgIA0KPiA+ID4gPiA+ICAgICNpZiBJU19SRUFDSEFCTEUoQ09O
RklHX01US19DTURRKQ0KPiA+ID4gPiA+IC0Jc3RydWN0IGNtZHFfY2xpZW50CQljbWRxX2NsaWVu
dDsNCj4gPiA+ID4gPiAtCXN0cnVjdCBjbWRxX3BrdAkJCWNtZHFfaGFuZGxlOw0KPiA+ID4gPiA+
ICsJc3RydWN0IGNtZHFfY2xpZW50CQkqY21kcV9jbGllbnQ7DQo+ID4gPiA+ID4gKwlzdHJ1Y3Qg
Y21kcV9wa3QJCQkqY21kcV9oYW5kbGU7DQo+ID4gPiA+ID4gICAgCXUzMgkJCQljbWRxX2V2ZW50
Ow0KPiA+ID4gPiA+ICAgIAl1MzIJCQkJY21kcV92YmxhbmtfY250Ow0KPiA+ID4gPiA+ICAgIAl3
YWl0X3F1ZXVlX2hlYWRfdAkJY2JfYmxvY2tpbmdfcXVldWU7DQo+ID4gPiA+ID4gQEAgLTEwOCw0
NyArMTA4LDYgQEAgc3RhdGljIHZvaWQNCj4gPiA+ID4gPiBtdGtfZHJtX2ZpbmlzaF9wYWdlX2Zs
aXAoc3RydWN0DQo+ID4gPiA+ID4gbXRrX2RybV9jcnRjICptdGtfY3J0YykNCj4gPiA+ID4gPiAg
ICAJfQ0KPiA+ID4gPiA+ICAgIH0NCj4gPiA+ID4gPiAgICANCj4gPiA+ID4gPiAtI2lmIElTX1JF
QUNIQUJMRShDT05GSUdfTVRLX0NNRFEpDQo+ID4gPiA+ID4gLXN0YXRpYyBpbnQgbXRrX2RybV9j
bWRxX3BrdF9jcmVhdGUoc3RydWN0IGNtZHFfY2xpZW50DQo+ID4gPiA+ID4gKmNsaWVudCwNCj4g
PiA+ID4gPiBzdHJ1Y3QgY21kcV9wa3QgKnBrdCwNCj4gPiA+ID4gPiAtCQkJCSAgIHNpemVfdCBz
aXplKQ0KPiA+ID4gPiA+IC17DQo+ID4gPiA+ID4gLQlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4g
PiA+ID4gLQlkbWFfYWRkcl90IGRtYV9hZGRyOw0KPiA+ID4gPiA+IC0NCj4gPiA+ID4gPiAtCXBr
dC0+dmFfYmFzZSA9IGt6YWxsb2Moc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiA+ID4gLQlpZiAo
IXBrdC0+dmFfYmFzZSkgew0KPiA+ID4gPiA+IC0JCWtmcmVlKHBrdCk7DQo+ID4gPiA+ID4gLQkJ
cmV0dXJuIC1FTk9NRU07DQo+ID4gPiA+ID4gLQl9DQo+ID4gPiA+ID4gLQlwa3QtPmJ1Zl9zaXpl
ID0gc2l6ZTsNCj4gPiA+ID4gPiAtCXBrdC0+Y2wgPSAodm9pZCAqKWNsaWVudDsNCj4gPiA+ID4g
DQo+ID4gPiA+IEkgaGF2ZSBhIHBsYW4gdG8gcmVtb3ZlIGNsIGluIHN0cnVjdCBjbWRxX3BrdC4g
QnV0IHRoaXMNCj4gPiA+ID4gbW9kaWZpY2F0aW9uDQo+ID4gPiA+IHdvdWxkIG1ha2UgdGhpcyBw
bGFuIG1vcmUgZGlmZmljdWx0LiBTbyBJIHdvdWxkIHBlbmRpbmcgdGhpcw0KPiA+ID4gPiBwYXRj
aA0KPiA+ID4gPiB1bnRpbCBjbCBpcyByZW1vdmVkIGZyb20gc3RydWN0IGNtZHFfcGt0Lg0KPiA+
ID4gPiANCj4gPiA+IA0KPiA+ID4gSSB0aGluayB0aGF0IHRoaXMgaWZkZWYgY2xlYW51cCBpcyBt
b3JlIHVyZ2VudCB0aGFuIHRoZSByZW1vdmFsDQo+ID4gPiBvZg0KPiA+ID4gYGNsYCBmcm9tDQo+
ID4gPiBzdHJ1Y3QgY21kcV9wa3QsIGFzIHRob3NlIGlmZGVmcyBzaG91bGRuJ3QgaGF2ZSByZWFj
aGVkIHVwc3RyZWFtDQo+ID4gPiBpbg0KPiA+ID4gdGhlIGZpcnN0DQo+ID4gPiBwbGFjZSwgZG9u
J3QgeW91IGFncmVlPw0KPiA+IA0KPiA+IEkgdGhpbmsgcmVtb3ZpbmcgaWZkZWZzIGFuZCB1c2lu
ZyBoZWxwZXIgZnVuY3Rpb24gYXJlIGRpZmZlcmVudA0KPiA+IHRoaW5ncy4NCj4gPiBZb3UgY291
bGQgcmVtb3ZlIGlmZGVmcyBhbmQga2VlcCBtdGtfZHJtX2NtZHFfcGt0X2NyZWF0ZSgpLg0KPiA+
IA0KPiANCj4gSSBjaG9zZSB0byBkbyBpdCBsaWtlIHRoYXQgYmVjYXVzZSB0aGlzIGZ1bmN0aW9u
IHdvdWxkIG90aGVyd2lzZSBiZSBhDQo+IDEwMCUgZHVwbGljYXRlIG9mIHRoZSByZWxhdGVkIGNt
ZHEgaGVscGVyIDotKQ0KDQpSZW1vdmluZyBjbCB3b3VsZCBjaGFuZ2UgdGhlIGludGVyZmFjZSBv
ZiBjbWRxX3BrdF9jcmVhdGUoKS4gQW5kIHRoaXMNCmlzIHJlbGF0ZWQgdG8gZGlmZmVyZW50IG1h
aW50YWluZXIncyB0cmVlLiBTbyBpdCB3b3VsZCBiZSBhIGxvbmcgdGltZQ0KdG8gcHJvY2Vzcy4g
Rm9yIHlvdSwgb25seSByZW1vdmluZyBpZmRlcyBpcyB1cmdlbnQsIHNvIHVzZQ0KY21kcV9wa3Rf
Y3JlYXRlKCkgaXMgbm90IHVyZ2VudC4gU28gbGV0J3Mga2VlcA0KbXRrX2RybV9jbWRxX3BrdF9j
cmVhdGUoKSBhbmQgeW91IGNvdWxkIHJlbW92ZSBpZmRlZnMuDQoNClJlZ2FyZHMsDQpDSw0KDQo+
IA0KPiANCj4gPiBSZWdhcmRzLA0KPiA+IENLDQo+ID4gDQo+ID4gPiANCj4gPiA+IFJlZ2FyZHMs
DQo+ID4gPiBBbmdlbG8NCj4gPiA+IA0KPiANCj4gDQo=
