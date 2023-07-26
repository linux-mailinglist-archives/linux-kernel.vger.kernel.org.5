Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCFF762927
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGZDOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGZDOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:14:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A6FE51;
        Tue, 25 Jul 2023 20:14:35 -0700 (PDT)
X-UUID: 8926137e2b6211eeb20a276fd37b9834-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7gocuSf8KjvtvSVEcAPdGR9R1cxeriaa3uune1Y93NM=;
        b=nIzdLuRREhIfFR6lZfMh/TOkRyk0AfUNVDiV1BYbB+s0RDa4FtxmjqJev6qcJ0lQLvcZHWoNMDDs8cZQm5mJVdAFCEDAkRkULii8RMs4/8JK8vRLvRJMLNsahhnPCW4K/L6WwkMZfaStrkF9ZMUQNPeK15mrTCjPr8RlI3V23SY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:5df4284a-c2c9-4cc5-a0bd-add45e40e991,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:2a07cbb3-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8926137e2b6211eeb20a276fd37b9834-20230726
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 230065630; Wed, 26 Jul 2023 11:14:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 11:14:28 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 11:14:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK0GpxvTzy1nyuD/R4C6tK9bXmuQcmDtyP6uSI1wJuxgOIqBp3TcShp/gcIXBbt7Vyl9owsOc664ZvNSHPyockLEKcwctFo1kP/4ueEsTyck3I4RpxQKM3EEczjbB93Bx32JyrSOYoMNLq4WOoogOKREmt2DklhF8/PKDlpObsTE0xJExb4pRmsRYWVUU7fyEnbMApjBas/gsg9TN4uwa93tOwBSLhRWyf6s+ZnkB27vwkZJQBPaldFTGl1koSS3nxa6rqiByIMesFuWtT0CnFLmnXFQ6EgHbWUshPwVOg0SpgRwK21aBBPsvhc/hkJcKLokGeCNfiiTFD1duYDIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gocuSf8KjvtvSVEcAPdGR9R1cxeriaa3uune1Y93NM=;
 b=oShAUtfICQIwNS077bzPpM/T2vS+TxfE32isLG4Bm5JYDzP7QxMiA6aEG93LAxPKHrZcsiEcacLlVfKqVeb5UzJGElWgmb4+VA2//ztBAMmxvCuiuNRZgbzZL2eKpLrqXxupdz+2gFTRSMZsjinUSfPeSwuD3aw4FqYiXuNmtXCxzQ1lf4QdJrvl0Hca7mG03NfsvFrp1liJVBlBCpThNd65dW8LVRLmtCZYQeCYQL8Qo157efZjfJ9+grbyqofI+ebQZWcGFlZs57ci7hB13CNWYNfTox0vprqoQLpEHLdQNkeokSBw0kN7Cz+G3IoaXn4P1SbNXU5aqe2cU5Nh9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gocuSf8KjvtvSVEcAPdGR9R1cxeriaa3uune1Y93NM=;
 b=apRDMICHdCN9Axkj5OcRdjPhSCEyqg2ct7FHrU6mJRy//sAqNdUcrTCluTt9uzpm/avn3Hx4Gw0wry9jCKGYpSXPumZYUSZQusoSEc/b+zHCrWO6SpEWXIDXLiDmDh4WRnEmkyYS8EOJKnJBhYoFoY7YoeQoenJzbneb3qkH8yo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB5632.apcprd03.prod.outlook.com (2603:1096:400:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 03:14:26 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6609.026; Wed, 26 Jul 2023
 03:14:26 +0000
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
Subject: Re: [PATCH v3, 2/3] drm/mediatek: dp: Add the audio packet flag to
 mtk_dp_data struct
Thread-Topic: [PATCH v3, 2/3] drm/mediatek: dp: Add the audio packet flag to
 mtk_dp_data struct
Thread-Index: AQHZuuQBbSzDYhODB0G5l2lKXGHNxq/LaMgA
Date:   Wed, 26 Jul 2023 03:14:26 +0000
Message-ID: <bddb1a1a445ead85056202c355627698051f12c9.camel@mediatek.com>
References: <20230720082604.18618-1-shuijing.li@mediatek.com>
         <20230720082604.18618-3-shuijing.li@mediatek.com>
In-Reply-To: <20230720082604.18618-3-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB5632:EE_
x-ms-office365-filtering-correlation-id: 2114ae82-2699-45b1-9eaa-08db8d866b43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iYuTUxCfyzBxfebU5lUV3sFWJRc/h/etIoDsNrZoOP37N32WLzDRCPFoqavq/ZX7XEdaHt6FVX46BA7QgXq+62avMW1QQ/cKA/FRs9tWXkxAzXO3yUelxGoeGbM0lr526zTmv5oMMoL/l20rofsawNGDlCiVHOslhDzDHYbkyJEIQRjzwB7VwsZ1EewQP874LR5rlCPrfqDJHh0TJKDe8H7ELG0Y7B4WIZX+NWV587K3ACwg1bNtXpjxp1/eX0tO48AyuTn1nwASeHeg3dzI/xEzwUYFjhEyDScwTTAHehV0o53j1Tj94p2g6feRS3OaNzORfGsEV7XypV9RGptjf4ZAXtjQ5nxyCXM5gmKkPoIzAkO3+VuN07rWHXjQ4Bf2bocn09bivSJ6tC4gmfWKQDDScnhT4UhvBZzm7Gj/mESPlnlnrCl65T3HpnxzPqhGeNqGb6aqjs1FRPQy9qPBpnq9n1J/3RJSZ+97kult5zash/B3Tz9H4rupRVy1TpPDnMqRg57bb4IB4AybFfj9LqiBgviBAzi0vds7QykxJBhBX5+xFMLyURCRMxzZpNWXqkngCpokHG63+HhBaG6FI4BqojZXuQTBXVoStAb0zE2luu7s6MIHBZ6hAg3kU3iYmO6m9QWdw0+iI67dNgtGwHNtajE9V7jDHYfOF62ur29UnMPJ05IEuz4Y3Ge/LKMOZAy5udXm5JfW/bEPzI48yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(4326008)(110136005)(122000001)(6512007)(38100700002)(966005)(6486002)(54906003)(478600001)(921005)(66946007)(66446008)(5660300002)(71200400001)(66476007)(8936002)(8676002)(64756008)(41300700001)(316002)(66556008)(76116006)(2616005)(186003)(83380400001)(26005)(6506007)(107886003)(85182001)(7416002)(86362001)(38070700005)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3ZtbkxkSklCdlkyMEEzVHVoZ2pVL0JJYVF4QTNmQUF0VS9RQVRZNmlWem1n?=
 =?utf-8?B?QktFR1hZQ1VvWFZ0aTlsQ0gxTGI3cWh4MFd0Tmh4TkV6TWZNR1hSbzd3WVJw?=
 =?utf-8?B?MXR6TlZTYkVHbG1SVWQzL2NGM1lyb0t3dEN6OTdKalZYTkZmd3E2bG5lKzRD?=
 =?utf-8?B?ejhQTm1FVnNycXhtYlJRbEF0T0Z0M3Z3YVZNQld1OXV0ZzVxeEtCSTFsZmps?=
 =?utf-8?B?Z09YT1RYUjV0R3QvZ3hhVmxRK250MlRpRVo5TUd6ZVhyWmt1RXhpMElxRzRW?=
 =?utf-8?B?VjJmdkVlcTdaTE9BRkpvSzVlVy81Z29QcWVyNXVGYWFiRDRPemRFbTBlWmRW?=
 =?utf-8?B?a20zNGgwR2JDb0VtdlpnQmdNMW5ESTlOVnAzcTF0NzJsSldDYk80U09aRFBG?=
 =?utf-8?B?ZjNwUmhJRFhrSTdCRFFieWlzRnRaaGdzVEpQMld4WDdlc1Q1dWNxYTlIaTg0?=
 =?utf-8?B?bjMyUDB4NzNuaHVVZkR1QWhJY1cxVjB2d3JaTzBaNjJPSnJHbGpDdkhjRXY5?=
 =?utf-8?B?aVRrS2Q5Nk9aOHUrVDRQUklTSitnd3p1VS9UU2VPeUwzRUtUdWZFcGJwazNE?=
 =?utf-8?B?N201bFMxa1ErVXc0dGV1QWVKNEh6TUtmZUJsWUMxRm5aZ2VjZGRTeTlnd2Jz?=
 =?utf-8?B?QlFKOE93YS9WTVIxYVBsRXpBWWNPbTVuMTZLSmhxK1pUc1BoKytQcStFaXlX?=
 =?utf-8?B?TUcrYXVxTUxpWmJyWEdmVElJcXJCTGhYaDRjZ25VNjVtU2J5RDVjdjlERVpX?=
 =?utf-8?B?SmVabjVnODhSZkliaC8yNUtsaTB6K3dNcXkwRmJwZGxQUHBYcUM2cTllbFJu?=
 =?utf-8?B?Tis5bGhLQjZTc1NwMXA4TXhpd1ZaWkpneFZheDd1ZmJQRVk5UGtXNzcyU1Vh?=
 =?utf-8?B?Q0NOR3F0N3YzL2xNMS90V0c2RlNvZFprWFdURzIzZzVJMnhXV0FORS8zVlEx?=
 =?utf-8?B?bTdlRC92YXowODZMT2tmaDJoNWR6aGNiYmhWd3FDejZjQmdvZGRnMlJjRVZh?=
 =?utf-8?B?ZC9MYUF0Ymo5ZHl4SlM4VlVMUFZScVRoQ2VHdjBsYjl4dHJlU3F5NWNRbHhY?=
 =?utf-8?B?TFU5cUtuaDlRLzBHRlVhdjhKOW8zWG1GaWFvRHdBdnlWSnZ0L0wza0N0R2gx?=
 =?utf-8?B?ZEFkeHRTaGFZRzBkczh6YmtVSWxGd0JUVFA5djZieldNTERzdjBCRDRWTEFr?=
 =?utf-8?B?RGJSbGRZakh3Q3d3QjFwU3k3QTF2V1IvR2hlVjRGSGFKU0ZrWU5Db2doYzl1?=
 =?utf-8?B?ODRQYkhPYVZaWC8rcy9zL1REaXR2T0ZnVmxvc2FKOWdYcmtTbWMwaG90YTBt?=
 =?utf-8?B?UVZjMzNsQndMWjZTRm1McSs4M2ZZMm5mU3VjZzlyUTdmNTZKU0xNc0tycTFm?=
 =?utf-8?B?S0Y3STd3cTR5M25JbERrc1NEdEFTYW5XV1NBNEVldFMxMlcxVmZjMGJGVG5t?=
 =?utf-8?B?ZTZSYzRnY2kxaVVZU0tscGtYekdGbVg2ekI3SDNQbmtSK3FqS0MxN2JuTWpr?=
 =?utf-8?B?NjRWaFFmdlMwQ1k3WjNXQi9sM2pLdzBtaFE4VDdQQUdsN1RTamg5ZTY1ME9m?=
 =?utf-8?B?cWdOYnphWk1ZVzRNMTN0VE9TeVN3TWdRcWYrZXFGYzZYUTk5d2xvVTd1WVkx?=
 =?utf-8?B?WHllTzRxeEVDQU0rWWFzQVBnVkoyUDEycGpqOVVLcWFHZjl5OGdwY2FNUjNW?=
 =?utf-8?B?bkF6bTV0UmFvNEdVaHJkSEtKQVR5VVZEenZ1djIrMzBrTXdxMlhNTG9jalNv?=
 =?utf-8?B?R040Z1VWc3g5N1R0UzEzY3QvdWVJZjgzdGhvMm16d3VkNnBGeDJ0dTk3WjMw?=
 =?utf-8?B?SW9BRjVGZ2xmUnJkTTJpeklEWTd3RUxJTGVib05PaUZzSVFyWGZUZi9nNHZM?=
 =?utf-8?B?OHJGNFFpMTBhb3F3UzlaZXVQQ1REMDRFMm55M3F0Z3BMWC8vWGNJdGpWUXJ3?=
 =?utf-8?B?WnJkOGRlU2R6OTVYWTN2SmtYMDJ2SENaWmJ1aWU0VFljZ3IxdlpLSmxxUENZ?=
 =?utf-8?B?OXJqd3pWVFZKU0ZITkVnRHhSZzA4SUhzZ2lZbjdzTnQ2dklOZWpHVFJ3bnN4?=
 =?utf-8?B?eDg2eHpMdy8vMElIVlJjd3I1YUE0VWhCaUpDalJ4Ym9wVWlWNWlULzhoaTJ4?=
 =?utf-8?Q?kUtlEs7uQSGsa4ieexd/gMswv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3382568A4AADCC43877BBBA970314AD8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2114ae82-2699-45b1-9eaa-08db8d866b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 03:14:26.7258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1XDaVcJx+6pz5t96H7msXMhq4JhPF6ovmZvP414j+00GyUKDSFO91istB/JuY73R7dMUflbeBEL4KoCdXoOAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBUaHUsIDIwMjMtMDctMjAgYXQgMTY6MjYgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBUaGUgYXVkaW8gcGFja2V0IGFycmFuZ2VtZW50IGZ1bmN0aW9uIGlz
IHRvIG9ubHkgYXJyYW5nZSBhdWRpby4NCj4gcGFja2V0cyBpbnRvIHRoZSBIYmxhbmtpbmcgYXJl
YS4gSW4gb3JkZXIgdG8gYWxpZ24gd2l0aCB0aGUgSFcNCj4gZGVmYXVsdCBzZXR0aW5nIG9mIG10
ODE5NSwgdGhpcyBmdW5jdGlvbiBuZWVkcyB0byBiZSB0dXJuZWQgb2ZmLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogU2h1aWppbmcgTGkgPHNodWlqaW5nLmxpQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gQ2hh
bmdlcyBpbiB2MzoNCj4gU2VwYXJhdGUgdGhlc2UgdHdvIHRoaW5ncyBpbnRvIHR3byBkaWZmZXJl
bnQgcGF0Y2hlcy4NCj4gcGVyIHN1Z2dlc3Rpb24gZnJvbSB0aGUgcHJldmlvdXMgdGhyZWFkOg0K
PiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvZTJhZDIyYmNiYTMxNzk3ZjM4YTEyYTQ4
OGQ0MjQ2YTAxYmYwY2IyZS5jYW1lbEBtZWRpYXRlay5jb20vDQo+IENoYW5nZXMgaW4gdjI6DQo+
IC0gY2hhbmdlIHRoZSB2YXJpYWJsZXMnIG5hbWUgdG8gYmUgbW9yZSBkZXNjcmlwdGl2ZQ0KPiAt
IGFkZCBhIGNvbW1lbnQgdGhhdCBkZXNjcmliZXMgdGhlIGZ1bmN0aW9uIG9mDQo+IG10a19kcF9h
dWRpb19zYW1wbGVfYXJyYW5nZQ0KPiAtIHJlZHVjZSBpbmRlbnRhdGlvbiBieSBkb2luZyB0aGUg
aW52ZXJzZSBjaGVjaw0KPiAtIGFkZCBhIGRlZmluaXRpb24gb2Ygc29tZSBiaXRzDQo+IC0gYWRk
IHN1cHBvcnQgZm9yIG1lZGlhdGVrLCBtdDgxODgtZWRwLXR4DQo+IHBlciBzdWdnZXN0aW9uIGZy
b20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
L2FjMGZjZWM5LWEyZmUtMDZjYy1jNzI3LTE4OWVmN2JhYmU5Y0Bjb2xsYWJvcmEuY29tLw0KPiAt
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYyAgICAgfCA0MA0KPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHBfcmVnLmggfCAgNSArKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gaW5kZXggNjRlZWU3NzQ1MmMw
Li5kOGNkYTgzZDZmZWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gQEAg
LTEzOSw2ICsxMzksNyBAQCBzdHJ1Y3QgbXRrX2RwX2RhdGEgew0KPiAgCXVuc2lnbmVkIGludCBz
bWNfY21kOw0KPiAgCWNvbnN0IHN0cnVjdCBtdGtfZHBfZWZ1c2VfZm10ICplZnVzZV9mbXQ7DQo+
ICAJYm9vbCBhdWRpb19zdXBwb3J0ZWQ7DQo+ICsJYm9vbCBhdWRpb19wa3RfaW5faGJsYW5rX2Fy
ZWE7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcF9lZnVzZV9mbXQN
Cj4gbXQ4MTk1X2VkcF9lZnVzZV9mbXRbTVRLX0RQX0NBTF9NQVhdID0gew0KPiBAQCAtMTM2Miw2
ICsxMzYzLDE4IEBAIHN0YXRpYyB2b2lkDQo+IG10a19kcF9zZHBfc2V0X2Rvd25fY250X2luaXRf
aW5faGJsYW5rKHN0cnVjdCBtdGtfZHAgKm10a19kcCkNCj4gIAkJCSAgIFNEUF9ET1dOX0NOVF9J
TklUX0lOX0hCTEFOS19EUF9FTkMxX1AwX01BU0spDQo+IDsNCj4gIH0NCj4gIA0KPiArc3RhdGlj
IHZvaWQgbXRrX2RwX2F1ZGlvX3NhbXBsZV9hcnJhbmdlKHN0cnVjdCBtdGtfZHAgKm10a19kcCkN
Cj4gK3sNCj4gKwkvKiBhcnJhbmdlIGF1ZGlvIHBhY2tldHMgaW50byB0aGUgSGJsYW5raW5nIGFu
ZCBWYmxhbmtpbmcgYXJlYQ0KPiAqLw0KPiArCWlmICghbXRrX2RwLT5kYXRhLT5hdWRpb19wa3Rf
aW5faGJsYW5rX2FyZWEpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCW10a19kcF91cGRhdGVfYml0
cyhtdGtfZHAsIE1US19EUF9FTkMxX1AwXzMzNzQsIDAsDQo+ICsJCQkgICBTRFBfQVNQX0lOU0VS
VF9JTl9IQkxBTktfRFBfRU5DMV9QMF9NQVNLKTsNCj4gKwltdGtfZHBfdXBkYXRlX2JpdHMobXRr
X2RwLCBNVEtfRFBfRU5DMV9QMF8zMzc0LCAwLA0KPiArCQkJICAgU0RQX0RPV05fQVNQX0NOVF9J
TklUX0RQX0VOQzFfUDBfTUFTSyk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIG10a19kcF9z
ZXR1cF90dShzdHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+ICB7DQo+ICAJdTMyIHNyYW1fcmVhZF9z
dGFydCA9IG1pbl90KHUzMiwNCj4gTVRLX0RQX1RCQ19CVUZfUkVBRF9TVEFSVF9BRERSLA0KPiBA
QCAtMTM3MSw2ICsxMzg0LDcgQEAgc3RhdGljIHZvaWQgbXRrX2RwX3NldHVwX3R1KHN0cnVjdCBt
dGtfZHANCj4gKm10a19kcCkNCj4gIAkJCQkgICAgTVRLX0RQX1BJWF9QRVJfQUREUik7DQo+ICAJ
bXRrX2RwX3NldF9zcmFtX3JlYWRfc3RhcnQobXRrX2RwLCBzcmFtX3JlYWRfc3RhcnQpOw0KPiAg
CW10a19kcF9zZXR1cF9lbmNvZGVyKG10a19kcCk7DQo+ICsJbXRrX2RwX2F1ZGlvX3NhbXBsZV9h
cnJhbmdlKG10a19kcCk7DQo+ICAJbXRrX2RwX3NkcF9zZXRfZG93bl9jbnRfaW5pdF9pbl9oYmxh
bmsobXRrX2RwKTsNCj4gIAltdGtfZHBfc2RwX3NldF9kb3duX2NudF9pbml0KG10a19kcCwgc3Jh
bV9yZWFkX3N0YXJ0KTsNCj4gIH0NCj4gQEAgLTI2MTYsMTEgKzI2MzAsMjggQEAgc3RhdGljIGlu
dCBtdGtfZHBfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIA0KPiAgc3RhdGljIFNJTVBM
RV9ERVZfUE1fT1BTKG10a19kcF9wbV9vcHMsIG10a19kcF9zdXNwZW5kLA0KPiBtdGtfZHBfcmVz
dW1lKTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBfZGF0YSBtdDgxODhfZWRw
X2RhdGEgPSB7DQo+ICsJLmJyaWRnZV90eXBlID0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCwNCj4g
Kwkuc21jX2NtZCA9IE1US19EUF9TSVBfQVRGX0VEUF9WSURFT19VTk1VVEUsDQo+ICsJLmVmdXNl
X2ZtdCA9IG10ODE5NV9lZHBfZWZ1c2VfZm10LA0KPiArCS5hdWRpb19zdXBwb3J0ZWQgPSBmYWxz
ZSwNCj4gKwkuYXVkaW9fcGt0X2luX2hibGFua19hcmVhID0gZmFsc2UsDQo+ICt9Ow0KPiArDQo+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcF9kYXRhIG10ODE4OF9kcF9kYXRhID0gew0KPiAr
CS5icmlkZ2VfdHlwZSA9IERSTV9NT0RFX0NPTk5FQ1RPUl9EaXNwbGF5UG9ydCwNCj4gKwkuc21j
X2NtZCA9IE1US19EUF9TSVBfQVRGX1ZJREVPX1VOTVVURSwNCj4gKwkuZWZ1c2VfZm10ID0gbXQ4
MTk1X2RwX2VmdXNlX2ZtdCwNCj4gKwkuYXVkaW9fc3VwcG9ydGVkID0gdHJ1ZSwNCj4gKwkuYXVk
aW9fcGt0X2luX2hibGFua19hcmVhID0gdHJ1ZSwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTk1X2VkcF9kYXRhID0gew0KPiAgCS5icmlkZ2VfdHlw
ZSA9IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFAsDQo+ICAJLnNtY19jbWQgPSBNVEtfRFBfU0lQX0FU
Rl9FRFBfVklERU9fVU5NVVRFLA0KPiAgCS5lZnVzZV9mbXQgPSBtdDgxOTVfZWRwX2VmdXNlX2Zt
dCwNCj4gIAkuYXVkaW9fc3VwcG9ydGVkID0gZmFsc2UsDQo+ICsJLmF1ZGlvX3BrdF9pbl9oYmxh
bmtfYXJlYSA9IGZhbHNlLA0KDQpHbG9iYWwgdmFyaWFibGUgaXMgZGVmYXVsdCB6ZXJvLCBzbyB0
aGlzIG1vZGlmaWNhdGlvbiBpcyBub3QgbmVjZXNzYXJ5Lg0KDQo+ICB9Ow0KPiAgDQo+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kcF9kYXRhIG10ODE5NV9kcF9kYXRhID0gew0KPiBAQCAtMjYy
OCw5ICsyNjU5LDE4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTk1X2Rw
X2RhdGENCj4gPSB7DQo+ICAJLnNtY19jbWQgPSBNVEtfRFBfU0lQX0FURl9WSURFT19VTk1VVEUs
DQo+ICAJLmVmdXNlX2ZtdCA9IG10ODE5NV9kcF9lZnVzZV9mbXQsDQo+ICAJLmF1ZGlvX3N1cHBv
cnRlZCA9IHRydWUsDQo+ICsJLmF1ZGlvX3BrdF9pbl9oYmxhbmtfYXJlYSA9IGZhbHNlLA0KPiAg
fTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2RwX29mX21h
dGNoW10gPSB7DQo+ICsJew0KPiArCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtZWRw
LXR4IiwNCj4gKwkJLmRhdGEgPSAmbXQ4MTg4X2VkcF9kYXRhLA0KDQptdDgxODhfZWRwX2RhdGEg
aXMgaWRlbnRpY2FsIHRvIG10ODE5NV9lZHBfZGF0YSwgc28gZHJvcA0KbXQ4MTg4X2VkcF9kYXRh
IGFuZCB1c2UgbXQ4MTg4X2VkcF9kYXRhIGhlcmUuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJfSwN
Cj4gKwl7DQo+ICsJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1kcC10eCIsDQo+ICsJ
CS5kYXRhID0gJm10ODE4OF9kcF9kYXRhLA0KPiArCX0sDQo+ICAJew0KPiAgCQkuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxOTUtZWRwLXR4IiwNCj4gIAkJLmRhdGEgPSAmbXQ4MTk1X2VkcF9k
YXRhLA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcu
aA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVnLmgNCj4gaW5kZXggODRl
MzhjZWYwM2MyLi5mMzhkNmZmMTJhZmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBfcmVnLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcF9yZWcuaA0KPiBAQCAtMjI4LDYgKzIyOCwxMSBAQA0KPiAgCQkJCQkJCSBWSURFT19TVEFC
TEVfQw0KPiBOVF9USFJEX0RQX0VOQzFfUDAgfCBcDQo+ICAJCQkJCQkJIFNEUF9EUDEzX0VOX0RQ
DQo+IF9FTkMxX1AwIHwgXA0KPiAgCQkJCQkJCSBCUzJCU19NT0RFX0RQXw0KPiBFTkMxX1AwKQ0K
PiArDQo+ICsjZGVmaW5lIE1US19EUF9FTkMxX1AwXzMzNzQJCQkweDMzNzQNCj4gKyNkZWZpbmUg
U0RQX0FTUF9JTlNFUlRfSU5fSEJMQU5LX0RQX0VOQzFfUDBfTUFTSwlCSVQoMTIpDQo+ICsjZGVm
aW5lIFNEUF9ET1dOX0FTUF9DTlRfSU5JVF9EUF9FTkMxX1AwX01BU0sJCUdFTk1BU0sNCj4gKDEx
LCAwKQ0KPiArDQo+ICAjZGVmaW5lIE1US19EUF9FTkMxX1AwXzMzRjQJCQkweDMzZjQNCj4gICNk
ZWZpbmUgRFBfRU5DX0RVTU1ZX1JXXzFfQVVESU9fUlNUX0VOCQkJQklUKDApDQo+ICAjZGVmaW5l
IERQX0VOQ19EVU1NWV9SV18xCQkJCUJJVCg5KQ0K
