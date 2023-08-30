Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7478D2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 07:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjH3FO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 01:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjH3FNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 01:13:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D12E0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 22:13:46 -0700 (PDT)
X-UUID: fcf7190446f311ee9cb5633481061a41-20230830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+uILPFB2Bj85dvwb3/ifnsSbFt32qAeqi1BIF/voksM=;
        b=SB8sP0LD9xv906zb/SlRfZaIaD5XDWJ+BdcdJxym1BO5N2IAPps5SOdmPwR44cfBJ4DcaU3g8pThUO+PPKpyOQvUSd+nD+Fwkm3gLmSPsV3EuQRqpDvC/Qct2hzysQr4U7515+860NU9qx5FnTioxQopIvXOmPOGgIresgT9pZQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:f1331ac5-f502-47d3-8a0e-36ee2a2f406f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:8d271aef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fcf7190446f311ee9cb5633481061a41-20230830
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2008922794; Wed, 30 Aug 2023 13:13:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 30 Aug 2023 13:13:42 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 30 Aug 2023 13:13:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkHBax+0fxK+WRJhE+r/+iVu4CTO5/Q2z06Cm6fFP2o9s9aE7Z5tCR3ilFhQdA5GyrnmF7hrSYqrTf3hHjGUMITX7kNlJVjN3hemgmcV/llaFjCB6uqPm8g4WVccbh0NR4luPbi0/ByRH6GT4NHgRlfgWbW9ccycpMew0V1IemVxMesVo9A4TFPEOY/MbTjAlL/f+rLs4M3/CPBILIdbvi+6y2C8cHrgszSF7cUMrpIYU33m0KS7BwKNw4y95hN2LFrN/ba3Q5Kg8ZPIKEGpOK9pRPZWuHyF3JnbQzzsKyWb5pGTWJz8WeThMqwTcY+zq4XCmjlJIC1IpjLQDuSeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uILPFB2Bj85dvwb3/ifnsSbFt32qAeqi1BIF/voksM=;
 b=SciTSu7Y3J6Iq81+2oS8pIo102nPaRrep8xpUb8mJJkX8ag/EmtVREPsjfOv6vjFxl9nUs6Rzs12G+8oPhT8tfeslQvcqNMekNC6jbn275bNQ0Ctwefk7Y3KPdn7Ami53gz93lNHxon0z7e8uhYY2O7x0edmo8Ix2lwdb1z1rEiGVdFr/h74F8Fz7CxlXNK1auhdFVz0FD6aduD12Cqlz5Rf0HnJFgZfHLr8IsBALgpBQqQwLySYy/wj7/req56IY35xgXToYj2iV/l5vKIlGcDGhujB2y+yn01zM3/VRKyGgOpNzOVAciFowBjO6d02juzknAGsJQW5SAreZCWkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uILPFB2Bj85dvwb3/ifnsSbFt32qAeqi1BIF/voksM=;
 b=k1gQ1bLQZLP1ze9YFVJkA3vGiwAkT+bZDoZCVGKP8jf2E9aUSRTZnHLEngYMgAs0qVoKiwQ4GzenfHp3FGsB9Gi6/YDLmoZSqJRqDcvPD9S2d0/47p3Dky6W8vdamTI37MNyRHvIsR0jhDBE+Y9qRvMgXt3ZdTrGlDVGMesnAbE=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SG2PR03MB6827.apcprd03.prod.outlook.com (2603:1096:4:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 05:13:39 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a441:8f4:4de6:2437]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a441:8f4:4de6:2437%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 05:13:39 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
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
Subject: Re: [PATCH 11/15] drm/mediatek: Support CRC in VDOSYS0
Thread-Topic: [PATCH 11/15] drm/mediatek: Support CRC in VDOSYS0
Thread-Index: AQHZ1dSSV/xMoB67n0ynvIMpw2r+Xq/4uhiAgAmbtgA=
Date:   Wed, 30 Aug 2023 05:13:39 +0000
Message-ID: <476caaedd26b90ac4af51d783026e99468be5721.camel@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
         <20230823151332.28811-12-shawn.sung@mediatek.com>
         <949962e5bbafbc5a55addb155f649222cf369dbf.camel@mediatek.com>
In-Reply-To: <949962e5bbafbc5a55addb155f649222cf369dbf.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SG2PR03MB6827:EE_
x-ms-office365-filtering-correlation-id: 197caf2e-49b4-4903-f0ac-08dba917deff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lcm6/1iNe1CQEdLt1gPdUQC+XXC0zTerwVSdscYhErpA6mNWQon7KuDzrjlAnzhGzPLflZdHxF/rwqAUNNOF6EKDy3bmm/lvgoebAyx6hujQCgh3sX8rEGZa5ipOuCKue+UDx1SXxvKSvjT0+wnYeNBMbWDVY1aTsLmby9l91Y9ZPB3mQLlihVNfvSRwrB2HBJj62UVaNZHe5T+iI/WV+D+Az1Sg98l/XxUYKqZDyf95OVVL5ZPzs48tnjuqb3UtckR6ECOxMSdo3xXNQ6hnOMSvXI4SEFI3FkZf7lJfKwV8EZhSYnr4PiNe8EWtt3b76ZveY1jkLGrofvXJLbg89Rv01LnqwxcIN1Y/FlJwhX/l8t/4CG/9V+aKTc21XL7HDqCS9f25+IUiBATzIRS3J/ez8Kwk18OS3WKbEL++3iQKhOCvVVtUyWWD1KcvSQ6VkqYKlMoKdK48y6qZED6r93ixSW6nODinlwrfLgXIcuSQgorpNQiJGRQUawtb8K7MvYp45YQIrQU2qy8dl3WLuhTLAG7XRrGA027PoTZvQwJWwaLmQu5QOs8Nf7ZI+KHfoijpt2x3WaWjTcRARCs+0ri8oV1Z8rdJuPi/AIqsdOkysjx715rvUvDtLKUsWnGHKhrOQTM/GHlSZk4doN9l7mP0OMwWPE+Qy6QEmKg0jqU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(186009)(451199024)(1800799009)(2616005)(26005)(83380400001)(36756003)(107886003)(316002)(41300700001)(7416002)(6486002)(6506007)(86362001)(85182001)(71200400001)(6512007)(4744005)(38070700005)(38100700002)(4326008)(5660300002)(8936002)(64756008)(76116006)(66476007)(110136005)(66446008)(54906003)(66556008)(66946007)(8676002)(2906002)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHBFaXBxQWZBWmRQU1lkaVk4Y3c0NVhRL2hqRTNyZVRncFVEUWhCbFUwVVlY?=
 =?utf-8?B?WGxJc3pjR1UzTCsvcFVWR1RqWG9UcXlmK0d1Nm9sYTIxK2R3U0dscnczN3Ni?=
 =?utf-8?B?cGFzTUtFY2Y4ZlczRzRZeG9MYUV2UVdlbWo5OHVwVnZ0YlQ4anRXSnFoTGJ4?=
 =?utf-8?B?eFQ4ME40L2U2RVQxTjlVQUdEZTM1dTRWajc4T1ZoVXB2UjZIYmwzd0FiRFcw?=
 =?utf-8?B?UW1xWXdXcWp6SmRjdzF6UUtXRUxzZjdSTXVWbDRiUTFnNVVGamxsOG1acGFp?=
 =?utf-8?B?UmlOVUNUamNVSTNpdmEvcEVGeFdKemZsRVR5NVBSMWlRcjhnNUFRblRvOHBD?=
 =?utf-8?B?eUszMmlsZEY3MDE5Q3JRcjFVYWZZc0ZJODR0cHp6akhtUXFoSzY3ZWs2SGdJ?=
 =?utf-8?B?ckxDTmNJeSthQ21xNDZLQWdETGlRa016UlFWeDFSTmZnMi81MWVsV0NBWHVU?=
 =?utf-8?B?WGREbHdPWnJLL3I0OWY4YkxjQzNHY21Va2JHOXVUYmQvRFEyKzBjaGdta0Yw?=
 =?utf-8?B?b0RmeTBNdVZhcVJGanh5cXpmMTRyV0p3eFM0cG50am85TUtmL0p4bC9ETHhU?=
 =?utf-8?B?anJIK3djaE1zMFdOaHByK0FNUElycE9LZGhHUVJDQWRFd1ZNdDBML0ZzeFNQ?=
 =?utf-8?B?SjJaWFY3WmsrQWRpN2R1SGRCbVFKeHBSZ1ZQYXJRN2NBNFJ1TW0vVGVVY2lq?=
 =?utf-8?B?Y09qYUN4RWEzL3RBR2cvRnQ2TVhhR0FRZXRSTjJRa0h2VVJuR2xBb3dvQXBm?=
 =?utf-8?B?Q3gxZEVBV1pIek5JV25wa0psaC9LVEV5TUNuLzdrZnp5R0FBUUNqeVYvaHBv?=
 =?utf-8?B?NWpRbkdRV1ppU0lGdXdyUEF4ZFlnNUV2azJHQmw0bVlZS0RvUit0aTZyREpl?=
 =?utf-8?B?OFdZeXZHcUVWN3ZjdlpHTUtuRUF5Q283eDJqRlFlMHhwQm9JMW5tZGJjUncz?=
 =?utf-8?B?QXBRbGdDQVdPSVNnZ244UGswc1g0WG5hak1GMkM3Y2VYaHR5VSsyMFdXL25r?=
 =?utf-8?B?WkdwZTBDcW9yTjZEZC9lYW1mMUZhdW92SEltdERFWCtkV0N4dU5xUFhRNHN6?=
 =?utf-8?B?OVE2RmRRYXhtT2RsZjVjTndRQ3h4ZVlXNXYwZGZvOFZyK21GT3U5cXFiNGZa?=
 =?utf-8?B?ODZVWFpVVDdqdGJvUndrb2hNek9OMWJjMUlreGlLMmFqdnhaNWhmeTlEZ3lE?=
 =?utf-8?B?TUNhOWJQTTNxRVhYUUpUckhkeFNERVBXQk9Hc0t3Wm9CNUh2OWRBcDFpOGZO?=
 =?utf-8?B?NnJhWVBDeXFDQVRwS3ZlZjZ6L003QjFMcnBKcHlwdFB3a01kZXdoaVRUMVpo?=
 =?utf-8?B?YWxBVjZyRnVHcnhqT2FscmYyZUVFbmxBNko4ejF5cVVZQjVKN0lqazNMSE1t?=
 =?utf-8?B?MENXcFZRZUpNSXJpelJ6TUhaaTM5Q1JzQUNENFN1NXl3WTVvQmdnYksvOC9X?=
 =?utf-8?B?Ymx1N2d3VEJJc0hzYkRrUFVCTmNwaUw4bEFIb3Rka0E3bVlUODRBWTJNbkJE?=
 =?utf-8?B?UXZqR1ROMHpHaXQvYVZaayt1U0xmQmQrRGNaTWt5ME5CbkxMcG14V0RMZk9h?=
 =?utf-8?B?VExEMnd4N2tqQnNpZTl5THBBS3h5N2N5SjVKV1lzZTh0MjYxNmpZcm1qczJL?=
 =?utf-8?B?K1E5aHF6bWY2ZFFsNjFNd2RIWGVoUWNkdmNKWmNvb25yWnhyb3BDbkFCdnJw?=
 =?utf-8?B?eWhyaE1WV1ArWFJXWDR5QkxGb1RuYTR4RTIzczViWldVOVlGa0QrUVFkSGlY?=
 =?utf-8?B?L0hUU2M3SDJLTnNmeTdEY3hRL0p0d05hWFMyRktEVTBmem8vWVZEa0svanpP?=
 =?utf-8?B?Z3loOThEdGdBcjN1NTlXVmh6Lzk5S0tlV3JPTG5ySVl6UFd6K2wwRVgzZWhw?=
 =?utf-8?B?R0pmYURMQ0pZUWJscHphU0ZGMTFGQXNPS0U5N0NWUHVUWlNIMTZQN3BOaHNi?=
 =?utf-8?B?eVgweExMaEthUUtYTlhiL3J1UWNuc3ZwQXU0cUxvTGFTZ1N6QWdQckpQd0dR?=
 =?utf-8?B?TGtDTjI1Ris4U09IK1I0bHJJaXRMZTk1WVZnR096dkRtYXlpVXhvcWlDTFA4?=
 =?utf-8?B?dXgraGhJQzVEZlZqZlNDdVFkYzYzb1VUR3luZFZnTjJ3YktBSFcvemNVT2JS?=
 =?utf-8?B?WS83b2I3YzkvZXRPWGNzNE4rWUMwdVc4SUJUcXFKK3UxRFFPeFhFdjJ5Nnkx?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65EF4B8C0A52514E8A04B19A7831CFEA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197caf2e-49b4-4903-f0ac-08dba917deff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 05:13:39.3303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPq8kP4HXuYIoDBaZV3HDBHroaEcsG0MDhekeKdT5D/CFFrNZ9/6/Lp1W9PZFh7rVbUiIV+YAGy9nGDYFTcWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFRodSwgMjAyMy0wOC0yNCBhdCAwMjoyOSArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IA0KPiBSZWFkIENSQyBieSBDUFUgaW4gb3ZsIGlycSBoYW5kbGVyIGlu
c3RlYWQgb2YgdXNpbmcgY21kcSwgc28gdGhpbmdzDQo+IHdvdWxkIGJlIHNpbXBsZXIuDQo+IA0K
DQpDUFUgaXMgbGVzcyByZWxpYWJsZSB0aGFuIEdDRSBpbiB0ZXJtcyBvZiBDUkMgcmV0cmlldmFs
IGJlY2F1c2U6DQoxLiBTbG93ZXIgcmVhZC93cml0ZSByZWdpc3RlciBzcGVlZCAoMS8xNSBvZiBH
Q0UpDQoyLiBUaGUgdGltZSBJU1IgYmVpbmcgZXhlY3V0ZWQgaXMgbm90IGNvbnRyb2xsYWJsZQ0K
My4gQ1BVIGFuZCBidXMgY291bGQgYmUgYnVzeSwgb3IgdGhlIGNsb2NrIHJhdGUgaXMgbG93IGF0
IHRoZSB0aW1lDQoNCkFsdGhvdWdoIHdlIGRvIGhhdmUgYSBDUFUgdmVyc2lvbiwgdGhlcmUgaXMg
YWJvdXQgYSA1JSBjaGFuY2UgdG8NCmZhaWwgaWYgdGhlIENQVSBjbG9jayByYXRlIGlzIG5vdCBz
ZXQgdG8gdGhlIG1heGltdW0sDQp0aGVyZWZvcmUsIHdlIGNob29zZSBHQ0UgKENNRFEpIHRvIGRv
IHRoZSBqb2IgZm9yIGJldHRlciBzdGFiaWxpdHkuDQoNCldpbGwgbWVudGlvbiB0aGlzIGluIHRo
ZSBjb3ZlciBsZXR0ZXIgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KDQpIc2lhbyBD
aGllbiBTdW5nDQo=
