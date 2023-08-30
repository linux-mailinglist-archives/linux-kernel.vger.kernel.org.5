Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5371578D1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbjH3CPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241664AbjH3CP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:15:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD8B1AD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:15:16 -0700 (PDT)
X-UUID: 0c6db47e46db11ee9cb5633481061a41-20230830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mUCpY1LMqYfM+LemNHpYXLr6h7OENNCaLYNxSRERgng=;
        b=BryrxvBLDfH5gQrGb4st6npJPdIqE4bKZARM3Fnns+XOEAuQXalAUQJISK1BEDYIUlSKFUon1U6R9q/L2Tiqb5jfzlyjheHOYLLqJX2YIiYEvgIVbdxWC2SIdBZHltuypCVGKer3dQ74VRKXq9HcVg/igyNeWHRH7kInGFqpiOI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:b7d5bbfa-bdf2-4be5-bb76-caa319172fd2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:cfcfe51f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0c6db47e46db11ee9cb5633481061a41-20230830
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1484584395; Wed, 30 Aug 2023 10:15:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 30 Aug 2023 10:15:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 30 Aug 2023 10:15:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdsilkFAKi5J9OoG/jOzC6RdYn3Iuc2My3Gq11SaIpmrf9cS40Wq/QZYQqopI+PjpVfC/j2iq+nThlQSpj+EsM8SgBCRPJ9nsoEiJk18DPScx3aNiuZlTPzVJu60QHFwrKfeQrLfgntfL8+pWr8lfwekzup1DeB+ejnQcr57ZY68XV9n2ZsKurZxz7cSvz8rsOcgBBjTupk+Ij6dQo+AcVyW+QWHJqet4YcTMEK8w1VOsAaRgRJB8c/yVRb74dc+xeGHfN8GeLFCeC7n+tONNSTkWASyHh/JynXPXvx8IijzA8j1Pyj9NwmmQQVvXd2DNRA2qkudcQtMhyIGiaw10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUCpY1LMqYfM+LemNHpYXLr6h7OENNCaLYNxSRERgng=;
 b=h/IcCczcyCmQvYLiiOD6KpEpBWtlSdhPAOO8wpEDNxmmYzhA4xJ4sc/mCYNmJu0w+qOzdSwWJnR9FApqlapN8Z5IK7hDpkTKkbMSg+rdIVwGDP6X1hFkEczzqTIsAduYDQOgWtYuSqZD6PUij8SXF/pZwVMv+nS+e62gNORadLqJYbB1UmI4rTorRoHiXonPKkvoJazTpFNG8ZPx0ZAIPsbhjrPz5bRa9uvU/txAtLV/64psimbpJi0W5kesq3SFALijqYRQFKw/8GV084LdSCPC1MFLaQoA7vMqKdlrE4fc7gyEbp33RIRwY4mh7NuoqwfoNwpHTI4IeduDL2N+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUCpY1LMqYfM+LemNHpYXLr6h7OENNCaLYNxSRERgng=;
 b=ricm3juv8VVpkA7dH+nQnyzqGKOrTVh2mlwraTDsSPvnLNbM2+Y64Xui9p+bY2XwSQ89DJeemNdTNyDZ0mV5zZ2Mj2yvc7KNJaR+bwXOCWumHYgnoSoj9GPZVy3Ti7APSSGURaQxPA44oVnmynlNRGlkCDMPrsGMxOejwgkZj3Y=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7975.apcprd03.prod.outlook.com (2603:1096:990:3f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 02:15:07 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 02:15:07 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 03/15] soc: mediatek: Support GCE thread loop
Thread-Topic: [PATCH 03/15] soc: mediatek: Support GCE thread loop
Thread-Index: AQHZ1dTJ7ZnGVh2PU0mkRDVN13twfbACI+wA
Date:   Wed, 30 Aug 2023 02:15:07 +0000
Message-ID: <3813feae1052428045e9897694521e790974d3a7.camel@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
         <20230823151332.28811-4-shawn.sung@mediatek.com>
In-Reply-To: <20230823151332.28811-4-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7975:EE_
x-ms-office365-filtering-correlation-id: d4195bf1-08b8-4d61-c897-08dba8feee03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hntIQSXCDySXHG/obS1GvwvdztLk+7A+G52EXbfIFA2NCn16j/5XkzP3rQJMkxp4l8lMnflzVJBAZfXsPkjKOd6rVQZ1NZ4a2ts4eeAuo5jwUlt1FQRZJwiOAuKkHo/vlZgO9i3WfziV5gztDK5lRwcb+UEChWpsKJpi7kl8Nz8mYrxGzTURTpg4hHsZYs5c5JkPT9qNs0GO7ftMN83XP6mjA3kZlQg/2KlOcMx7+QZYfzXZyG97Qr9QCnkQ40anilZRCOkwv7uVp4XvRuZG1qhgFvTp10efC86xtevQbsk3g/vo08fs07pMK6YZMNeXwaOuZVcQpFZ0bojctKcUM6BCcNBxDLYPYqgvsYGMQub6M2HPT9bw17RTLb8R0BzE3QGS5PgLtyP9cTiEhzo2Zy/aduycbSrL+H77miCUMnsWGx9zF6Ob4USkvLadBwOxyb6sE8WREsnXUGMgHoiyJq/pp6MPrXzh99M36LPPC94Ohq+S9pewWbdISLOClhpJ6O8XgXMiNxfsT6TALdwKh+GPqfKTYB8+tf+mFRlQMomq0Rs82Xgx6Ddydx3bfRoiw/uVHV4P7bRZmVp2QDoLG8v+iugIZnlyivcc6DLDJenGl6Ht+cZPfYbyvh/wbWRromrDEcx1C0XIO5LkM6Bx/j2O4tum/JnMVGBgOCeGAgg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199024)(186009)(1800799009)(6512007)(6486002)(6506007)(71200400001)(107886003)(83380400001)(76116006)(26005)(7416002)(8936002)(2616005)(316002)(66446008)(41300700001)(8676002)(66556008)(66946007)(5660300002)(66476007)(54906003)(2906002)(4326008)(478600001)(36756003)(85182001)(86362001)(64756008)(110136005)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enNzUGlTdTdOMWVXTDE4c3VkRkZaVEdJVWJueG9QS2Z0SFduL0tIaUpYUlVS?=
 =?utf-8?B?bHEyV2VpczlpOU9GajdDcFMrVkpZTzFTTTVQRGE0L0RkK1RuT1I3dXhZdzZC?=
 =?utf-8?B?U0tnMWwveVVjVnV0TjBVYThpdWVucGpoNThwaVRaSHpUdHd3dXlCSDRhanlI?=
 =?utf-8?B?aGxpSEFTcnd1dG44OWR0eXBxcHhlQlU1a0lPR1hManR3d2poOHBWckhyb3NL?=
 =?utf-8?B?akh2eXhlaVBCTzRIT0hGWXNXK0JYWkZNVWVkendLZjU1cW4zZHZaVFBXdUFH?=
 =?utf-8?B?TE5WQXM5M0RpSExib1lyYzZlM0dNNEVyODA4Z2dIcXhwR1BjVktRTkF4YTlI?=
 =?utf-8?B?V0gyMm9ucHIxd3VoZkdqaW5zVWw3QTAyWEdVMlJIU2lLMVdsTmRQSTNlWk5O?=
 =?utf-8?B?SGl4eXF2di9QMW1JT3NWZ1diSkxKeG9QN1lObXh4ZXZLSGQwS1BEZWs2SG5Q?=
 =?utf-8?B?VGtOSUZpN3RRWkJheVRiQzE0K0dITys4cm1WcWdUdEJDdHIyYm1FQW04d0dR?=
 =?utf-8?B?VHNDTDhwa0FjVjNHTVhnaXhxMFBpMlhEdEZnWEJNWEQzVmZQRnRCNHh2Zk05?=
 =?utf-8?B?VFhLQ1p2VktHdWliMVRLaHZQNTVXd0lyVnl2U0swWThtbXcwa0xEc2VTMHZv?=
 =?utf-8?B?WEd6Z3VuMUhPWmg1REpXeU1vNGozUFZSeExSdEVCdzB3VUpzODF2eWxlZCtC?=
 =?utf-8?B?UlMrNUdyUXZ2dzZDSEJIR3BpN0pzb01QcjRKeVhVaE1SWldBMmgxaG9zRVFw?=
 =?utf-8?B?ZXdFZ0kyMTJGNzBHM0FGNW5ERUtSeFowVnJwTjhjc1F5bWlEUFkyRFN4Ykhi?=
 =?utf-8?B?Q0F5V1JXK2Erd1ExM0psaG95U3YvRjEzTjVRd1hza2IwNFU1TVRpZEhBQ3ZZ?=
 =?utf-8?B?QldlbVI0NXhtMnE3TzBlNkUzT2JNNGtFK0ErUCtNSW1pNnFSZ0hBdkZUdklH?=
 =?utf-8?B?bTNMaDVQV3daOGJiMEovc0ZRU1RpUFo1USs5UDcxakwvNkhBeGE4SGtsWERP?=
 =?utf-8?B?ZUFRZ3MvZUtzOVZuR3Y0dkk5Qm5QekxraThwUDU4OTlYOU5OOGYwN21nSlFn?=
 =?utf-8?B?eE51Mm5sejdUamprOEFkYnlWK20rb1V0UVk3YzR6eitrTFpobk5ESjlhU0t4?=
 =?utf-8?B?S09DNytQM0Urb0tlN3JweDBXN0N4djMyYkt1K0l2azQvVDVvb2dsUUJBSDEy?=
 =?utf-8?B?YURqa1o4OW9tN3MvRk5rcVdTZ3NQUUxxTnd0NXgvTXN3RkNxWnhtWHA2aUNV?=
 =?utf-8?B?aXZxS3U5TStNRStCZlY0OTZ4S21jc05qem1Ud2hzcE9ad08yaEdjSTJaSG52?=
 =?utf-8?B?dW84UnZkYmlSUGYvRjhSTFVVSThxZklUMldCaVl2ckMrQXd1WldtZUZzYldD?=
 =?utf-8?B?VjF5cGJuZTcwY3Q3MUViZCsrNHo0d2xaa1V0NVo5RVZSTUJra21SSUZRSCtB?=
 =?utf-8?B?eWMxMEZJdkpDZnZkMSt5enJZNlpkTWpVeS9qK05oTDA1N2tCK2RZTHFDN3FD?=
 =?utf-8?B?eGsyMVM5em1JdUwwdkovVGlWSk5EZk4ydXhtak96eGo1ZDh4aGhpT2FLSmNs?=
 =?utf-8?B?VENQMzFiSFUyQjU3bTJoWlZGQWRFOVI4c1NSSzFPQU5waDZmdHRKbTd0MTU2?=
 =?utf-8?B?N2dhQzM5b0RrcmwyNmJvME9pcG5nV2NCRUEwbUlzNjRYZDN1UVJxbkRURml0?=
 =?utf-8?B?YlI1QzJRaEhJZVIzV0w0aVlzSTYxV1VNb1pJSU13TDlqSEpaOExwSzFCb2Vu?=
 =?utf-8?B?WnRGRlRiUzRDOFQ2dmN0Z3NjVGxsUWk5RjZCcjMyMGMwbXUyZ3V1TXRyOEpJ?=
 =?utf-8?B?Vlc0ZlMrRHVKaG5SN1REZ2FYeUdpVEVVK1R6WjU0bml4RWx6UHFyWnFYOHFR?=
 =?utf-8?B?aTN6UkFyM3NydEtkdXpDanZ3RUtaK0hLZnVUSUV5c2k0Zk5CbSt2L1VtSmM2?=
 =?utf-8?B?ODFHYmtPQlhRNldpSDNZclltaHB1WXhic09BS3ZZZ2R2eFJSZEhGQUt5ekVU?=
 =?utf-8?B?TnNvOTNEY3E0WmtHc0VnVzVrWWphU2RHRFkwRnpQNE5yTFNaNzJKU243bXc3?=
 =?utf-8?B?ZUNSOFNQUitPS2gxVm1yMGxpTWpLMW42TFVmWkdrY3lyUFJxeURzUlNuVUVo?=
 =?utf-8?Q?b1vQnP/Pm3o0XxEez70PVbPNk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3273C9D18D01214D99CCBBAE46FAA68A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4195bf1-08b8-4d61-c897-08dba8feee03
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 02:15:07.1287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TyZIIc1ZpFqO2A0dbaqFypdvnT0Y4hd/6Gdk11ToTgq0MXeLFVCcdO1yjbrIX+oFZBmV1gQQVHy9TW/VWsxiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7975
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBXZWQsIDIwMjMtMDgtMjMgYXQgMjM6MTMgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IEFkZCBhIG5ldyBBUEkgdG8gY3JlYXRlIEdDRSB0aHJl
YWQgbG9vcCBieQ0KPiBhcHBlbmRpbmcgYSBjb21tYW5kIGF0IHRoZSBlbmQgb2YgQ01EUSBwYWNr
ZXQNCj4gdG8ganVtcCB0byB0aGUgaGVhZCBvZiBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhz
aWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMzANCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwg
IDIgKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGIvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gaW5kZXggYzE4MzdhNDY4MjY3Li43
ZDUwM2Q0OTFjMGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
DQo+IEBAIC00MzAsNiArNDMwLDkgQEAgaW50IGNtZHFfcGt0X2ZsdXNoX2FzeW5jKHN0cnVjdCBj
bWRxX3BrdCAqcGt0KQ0KPiAgCWludCBlcnI7DQo+ICAJc3RydWN0IGNtZHFfY2xpZW50ICpjbGll
bnQgPSAoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbDsNCj4gIA0KPiArCWRtYV9zeW5jX3Np
bmdsZV9mb3JfZGV2aWNlKGNsaWVudC0+Y2hhbi0+bWJveC0+ZGV2LCBwa3QtDQo+ID5wYV9iYXNl
LA0KPiArCQkJCSAgIHBrdC0+Y21kX2J1Zl9zaXplLCBETUFfVE9fREVWSUNFKTsNCg0KVGhpcyBm
dW5jdGlvbiBoYXMgYmVlbiBjYWxsZWQgYnkgY2xpZW50IGRyaXZlciwgc28gZHJvcCB0aGlzLg0K
DQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICAJZXJyID0gbWJveF9zZW5kX21lc3NhZ2UoY2xpZW50
LT5jaGFuLCBwa3QpOw0KPiAgCWlmIChlcnIgPCAwKQ0KPiAgCQlyZXR1cm4gZXJyOw0KPiBAQCAt
NDQwLDQgKzQ0MywzMSBAQCBpbnQgY21kcV9wa3RfZmx1c2hfYXN5bmMoc3RydWN0IGNtZHFfcGt0
ICpwa3QpDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2ZsdXNoX2FzeW5jKTsNCj4g
IA0KPiAraW50IGNtZHFfcGt0X2ZpbmFsaXplX2xvb3Aoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQo+
ICt7DQo+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ICsJaW50
IGVycjsNCj4gKwl1OCBzaGlmdF9wYSA9IDA7DQo+ICsNCj4gKwlzaGlmdF9wYSA9IGNtZHFfZ2V0
X3NoaWZ0X3BhKCgoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbCktDQo+ID5jaGFuKTsNCj4g
Kw0KPiArCS8qIGluc2VydCBFT0MgYW5kIGdlbmVyYXRlIElSUSBmb3IgY29tbWFuZCBpdGVyYXRp
b24gKi8NCj4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX0VPQzsNCj4gKwlpbnN0LnZhbHVlID0gQ01E
UV9FT0NfSVJRX0VOOw0KPiArCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5z
dCk7DQo+ICsJaWYgKGVyciA8IDApDQo+ICsJCXJldHVybiBlcnI7DQo+ICsNCj4gKwkvKiBqdW1w
IHRvIGhlYWQgb2YgdGhlIHBhY2tldCAqLw0KPiArCWluc3Qub3AgPSBDTURRX0NPREVfSlVNUDsN
Cj4gKwlpbnN0Lm9mZnNldCA9IENNRFFfSlVNUF9SRUxBVElWRTsNCj4gKwlpbnN0LnZhbHVlID0g
cGt0LT5wYV9iYXNlID4+IHNoaWZ0X3BhOw0KPiArCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21t
YW5kKHBrdCwgaW5zdCk7DQo+ICsNCj4gKwlwa3QtPmxvb3AgPSB0cnVlOw0KPiArDQo+ICsJcmV0
dXJuIGVycjsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0woY21kcV9wa3RfZmluYWxpemVfbG9vcCk7
DQo+ICsNCj4gIE1PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gYi9pbmNsdWRlL2xpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oDQo+IGluZGV4IDNlYjk1ZWYzNGM2Yy4uNGMzMGY4OTFkOTI0IDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ICsr
KyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gQEAgLTI3Myw2ICsy
NzMsOCBAQCBpbnQgY21kcV9wa3RfanVtcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwNCj4gZG1hX2Fk
ZHJfdCBhZGRyKTsNCj4gICAqLw0KPiAgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRx
X3BrdCAqcGt0KTsNCj4gIA0KPiAraW50IGNtZHFfcGt0X2ZpbmFsaXplX2xvb3Aoc3RydWN0IGNt
ZHFfcGt0ICpwa3QpOw0KPiArDQo+ICAvKioNCj4gICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkg
LSB0cmlnZ2VyIENNRFEgdG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZQ0KPiB0aGUgQ01EUQ0KPiAg
ICogICAgICAgICAgICAgICAgICAgICAgICAgIHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBl
bmQgb2YgZG9uZQ0KPiBwYWNrZXQNCg==
