Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F32797495
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjIGPkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245310AbjIGPfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35141990;
        Thu,  7 Sep 2023 08:35:26 -0700 (PDT)
X-UUID: 82a6e4c44d4511ee8051498923ad61e6-20230907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PMh6k7QC2XNswn4pnDuWE8mEfZ0mNwT2vZt3T52kZxY=;
        b=O+JbZZ07/JadTc0AX3w0muq/MeP/5f2ergnEXcX4PRvJsnMTKfP5W1JtFKQq9gBaUZM5xG7FmFCcnGlbpT7ys/hVt/5DL+Q28lzWic6FcRmZdJ3QJHNDqYtvmpBXRa57qiXRzRHf/lKd6iJ+05i25Thyxa6lQNJFSkDmPkhYli0=;
X-CID-CACHE: Type:Local,Time:202309071409+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:25764774-eb92-4244-9946-0a076f231fbf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:2d676aef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 82a6e4c44d4511ee8051498923ad61e6-20230907
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 369239540; Thu, 07 Sep 2023 14:12:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Sep 2023 14:12:22 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Sep 2023 14:12:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht/lzis6i0qDL4agwAurIDuTMqsrWdLizdg1lp1Crg550JCcr1oUq/uq7jjMGiC5M6OcjqT3rW0gKgHjAZniEzotPDbpPpkhVrHFQFbrbqbKB8SsJhnuIhU15gQ8/eZ43yqTBYCrL1PnUFN/XxycN0l2/NdZNXNKgl7klY5OE9mIjJrXDpXf+2imP6DpPvcfTVCM0GGaFOAoauv71KqyWGsfIKDo3jFR6Gz8c1ny7DSAPYH/I5IfhaGxxxVnmXEkTcaIOeMhI+srPHPwbnP+ThbGCSD1l62SAzyd67RWddbBE/zqbyVqn5ZG77KHa1o7wU6AxN15cfUmhzB6MzuV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMh6k7QC2XNswn4pnDuWE8mEfZ0mNwT2vZt3T52kZxY=;
 b=McA65sr7Z0mX+ElE/fDRj/5AMezKBWDjD2Q9mbd3vvu32cD4p+yOsztwe1ZkO/cuZCgGrEmetoSOFP9ffgF856bzull5Squ9++ObECi/5WJ/uhwOFlV2kS3Q6VaQfFSKDrFvLIMXZByQjw7eR51cypKWQV3Y6bd3run4GTUBaFP2eQHEtlsSSHIvOuZ1W/3uMcAa1igGLMVuTyIyELNmeyZ1Yn0iNoDo4HgH0HFePFalLwpfrTDTloaTyEJ4NgLkzzaquDXzvuWip5ivjNNEyyZihXvwFERW3BPk/Q0ifNMqDLs2AiHxDI6nah7zfN+ZDVOef8YZ7eN0vh1j0YHLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMh6k7QC2XNswn4pnDuWE8mEfZ0mNwT2vZt3T52kZxY=;
 b=tk1MqF8OiSofCYFNYVNqmETAGZ8NYsH9Ohv9gYvO394JAR/tSQBCmNwCxEZc/awkEE49D31lfJ5a9cFpiTQ9lf9f6KQdXk1K6lKrchrq0GeSukHofRBgYTTtu8s2DEKk8BXJXOV6Bl50A6ibz26F587EH3RWlblCmzjHUpDCb40=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8312.apcprd03.prod.outlook.com (2603:1096:990:4d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 06:12:20 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 06:12:19 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
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
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>
Subject: Re: [PATCH v2,2/3] drm/mediatek: Add mt8188 dsi compatible to
 mtk_dsi.c
Thread-Topic: [PATCH v2,2/3] drm/mediatek: Add mt8188 dsi compatible to
 mtk_dsi.c
Thread-Index: AQHZoCVaukQPOe/o9U6IjmLMU9LbZbAPYzmAgAAA/4A=
Date:   Thu, 7 Sep 2023 06:12:19 +0000
Message-ID: <338122485db025f6bfb8be550d426ca11698497c.camel@mediatek.com>
References: <20230616073659.26536-1-shuijing.li@mediatek.com>
         <20230616073659.26536-3-shuijing.li@mediatek.com>
         <67813ea6e688036d68c10fa979562b6aab80bda9.camel@mediatek.com>
In-Reply-To: <67813ea6e688036d68c10fa979562b6aab80bda9.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8312:EE_
x-ms-office365-filtering-correlation-id: ff37d9bd-0d3e-426a-a1c5-08dbaf6964ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: geQ6TNwI7S1AuvcChaQhDc3AF9yZ0fDzIZVtBq7Ami03bNzfyHq6AS6Lic6gkVhgE1j06B7e1WVMPfUx5k5uH61GvbC8WaygMMSQU7C/jxuPLlU6WyB1TdHMfWpsYT9athruMmoZuNIm0HRdaU6DyTwH3stLJSp3dbrTKlMt5IZ/lUIy5f9SPEAUGrsBBw1uA9dZAUcubfULhCeQ8AQ6N/hurkfZmYUYxbu8PWdy6OIrwndLYfHL/WST99GuJf6We00IFgVR8dZxyG2trn7IbtmJQ+OaB64QHhDvuf7Nf9AQlD1/GtbFNSfrBfKKjgHMDd/AI98CwbXD4FM2RY8fw2K8RLnbC9zBkotWhgB6JYaA/Wru6RYXXEb0BuQ40g01o0qV45fVQmttRNKDiTtuitO0P/rboIWkuR6P5KsS8fN86UFqNi+iSR/yhpm9LpIYyQQy+11vG2R/OIvYpUx0vSXxVZzLYenGciBUhkSj05gB9J1Aa3k1deimxP0wRYMUSfYL2ub9I2v8gEVl/1/T51luGeF0Ihms93VMkcs10abyRh7PZON7jZlybqks6VM17EkAc+DQWNajlj60eWaNsMhQG62KDKfZho1O84Vg2HmRSo8jppKM3+QKV+MGjSJbdeoibamP+we2nhXBHRxLtHg1tmnVIfglMlbbULR5feYefjNqMYeHi9yTyruW908H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(186009)(451199024)(1800799009)(921005)(122000001)(6486002)(6506007)(8936002)(71200400001)(36756003)(86362001)(38070700005)(38100700002)(85182001)(478600001)(7416002)(26005)(2906002)(83380400001)(6512007)(107886003)(110136005)(2616005)(4326008)(41300700001)(54906003)(316002)(8676002)(5660300002)(66476007)(76116006)(64756008)(66556008)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjFDRHlvcUV4b0hoSVVBT0IxWVp0Ri9kb3hmOWlKTmlFaVg0b2pET0JPQmNw?=
 =?utf-8?B?V2w2YlY0VDNvNytwbnQycFZzd1VPbDMxRG53VGEyeWVhOVlZS0c5QWdBYk9k?=
 =?utf-8?B?dWg5MjZEb2hFV1QwWWpIdUpqbjkwa0l0cExVWFBxM0F0NlBhRjBwWk9zTThp?=
 =?utf-8?B?a21rWjJoaEg5YW9uaXh3RzlwQkUrcWgyOVRxR2tRZUtBOXAzbzRpbHc5Q0dI?=
 =?utf-8?B?L2Z4Z2xCZTJTUUZYcWxlNElpM0toRUgrb1FPMjR2Sk4xYkhCdmpSWHJYS2Yw?=
 =?utf-8?B?NkV6cU1oS1NvNERjenlTcmZyS0ZiSlpuVGl6dXlwcjFGMXFRNVMyR2d5QTVo?=
 =?utf-8?B?L3FwblZjbEJlMHRtcUNrSFNyNkozQjZUMTlJNk1vcXE4YXIrQTFXRmIvSllx?=
 =?utf-8?B?R294WTJ1WlVGNXB4YjFNWG1mQWFoYVJ1VEV0YXMzWEJPUkhvc0tiYUpvZDI4?=
 =?utf-8?B?T0ZsUGZKMFRvV1czenhIMWkyK0FVdmNNNWtVVU8yOXNTdFRlZDZnT2JyMGg2?=
 =?utf-8?B?ZzZPanpvbEdRWEZCMzllSW1RUlFEMFBzcnErMEp2a3FjSThlV3Y1U09BdVp0?=
 =?utf-8?B?ZE00eTU4QWRxMjRXcUduY1RHMDF4UjN3azY2cGtBSmU4R3RDaTNaSHBlT05r?=
 =?utf-8?B?Zms4QUZFZzlBMlNkZjlWMEY3cEJ6MllzNkUydDRoV0UwUE1vZ1FlcVBlUHVv?=
 =?utf-8?B?Sm8rRWpXOENHbk5TUnYxRTc5YzBEVUtxN1Jad21vNm1PcnNuQkREVU8ySW1U?=
 =?utf-8?B?UFp4bzVvaTFZSUVGd2xFMHZEWWFTdG5oRTVHaitaVUh5R1ltdDlmazRLbDMx?=
 =?utf-8?B?TVYyMUhDVnlsOHBVamxFTS9XRVlOQTFWeXo1eGdsOGNNMGZ5Z3RXQ3l3VzYy?=
 =?utf-8?B?aUFMZWhNaE5SSVh2MTh1eUdmUXdramNrM21ZazBMcjBZVEo0ZGhTdHBONlBD?=
 =?utf-8?B?Z0lodlBvOGpINUxlcGI3U2s0Rk8xR2VGSjArUU5jbm9SZUhSY3hGNFpTb1NG?=
 =?utf-8?B?WGUyNzNESWIxZVZ6OHZlclpwZ2hlK216NGM3cExUK1E5VG1HbTFiNmxPdkFJ?=
 =?utf-8?B?VGp0aFpHVENVT0pHRjdQTmlURkU5SVVDNWRsYXNQR1FtVzhVRzhNdm5xUFJs?=
 =?utf-8?B?T1BySmZ6UTBmVUxDK1ZHQ1hZdlpaRWhySnZ3RUFadjN2VmxOVnFjT3NhZXQ0?=
 =?utf-8?B?L1ZCaXZGSXl3RnF3KzVQeFlIOXFPZTljSVROZlZWOFU3VnJpd1BBZm1ITUJE?=
 =?utf-8?B?aGV3T051ZU5XWU9RbGNxbWc2am5XanA4dnVHTXEzSkdTOERyTFhsaVVhL0hR?=
 =?utf-8?B?MnJQakRQVTJIYUJsOW1TM24wRG9yWjVxd2Z5Y25ETEtRUWQ0SGtiRjc0bzVH?=
 =?utf-8?B?M0cwYUNYNlRhUmloT0t2NFFsMVU3YUlzb1c0ZERHTEJ5eDJUUHRrN01VbXoy?=
 =?utf-8?B?OUoyc2NVb3QxNUdZVkUwMGZhaGhXbng0Q1VSenZTZzgvc0h2RHhxbkFNVTNN?=
 =?utf-8?B?MnBER2IzaVRjYnFHcFJmeVViK1BzYlM3V1FjTVVOd3VsdVFWdnlPZHNFSlBs?=
 =?utf-8?B?bHZKbG1XNEJuSzFDeHdxN1FveEJ6VENWWEpkdGtIZzFSUnpOczQ2bHd0cEZZ?=
 =?utf-8?B?SkVneml2WnRDKy9vQmxPSE1aSXBxUnJoVFhqS3lqd3czazBiV2FraXJHU0kr?=
 =?utf-8?B?Z3ZkSmUxam9QcXFUM3lveENKYmkrTUNndS9uUGNJTk1xZ2psMWIyYXBEZGEy?=
 =?utf-8?B?eStuK0Zrb29yVVh3VFNYK1V2aUpoUlNYRzYrWWRhZmlGcHloUWF6T3B2S1Yr?=
 =?utf-8?B?YzA2WVNFWUU5cE9xbXR2WlpZL3F3S0lOTXJ5dzlWOS9zcHdINjVzbmpxdmxL?=
 =?utf-8?B?SFFMWFd2T3N0djZEU056aDZrWE9xVmhpQmswMEt2VEhkTHlQYWl4cmpmc2pp?=
 =?utf-8?B?OVZjRFQvRFJKWU54Mk8rVUZtMkhIYTJRT0tDcWRTR1ZhcnAwd3YwWGQ2d3FD?=
 =?utf-8?B?TGI1QkZjZVhqVDFWSk1ENmhMeHJMTHJmZ1F6M3REN2pYRDkvdkF3U1ZUSUdF?=
 =?utf-8?B?ODByNDBBb1JhcC8wQW50am1SRFUvRUw4clNPYWRSTFFjemthUDZyRHpvUGFS?=
 =?utf-8?Q?dA0jJr4BXmqy22aXu2MI1ouDi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D569F77F17769749A07945722CD2021D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff37d9bd-0d3e-426a-a1c5-08dbaf6964ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 06:12:19.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6h6lKFCGaATSJd7EOEc5yi04EEXOBP6ULJxmijRs0Zjt2UPZY6RaTULAsAzgOy0WkVAaz3qDgia7y+3OsdeRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8312
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBUaHUsIDIwMjMtMDktMDcgYXQgMTQ6MDggKzA4MDAsIENLIEh1
IHdyb3RlOg0KPiBIaSwgU2h1aWppbmc6DQo+IA0KPiBPbiBGcmksIDIwMjMtMDYtMTYgYXQgMTU6
MzYgKzA4MDAsIFNodWlqaW5nIExpIHdyb3RlOg0KPiA+IEFkZCB0aGUgY29tcGF0aWJsZSBiZWNh
dXNlIHRoZXJlIGFyZSBkaWZmZXJlbnQgZGVmaW5pdGlvbnMgZm9yIGNtZHENCj4gPiByZWdpc3Rl
ciBiaXQgY29udHJvbCBpbiBtdDgxODguDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU2h1aWpp
bmcgTGkgPHNodWlqaW5nLmxpQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaXRh
byBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1hdHRoaWFz
IEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIHwgMiArKw0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RzaS5jICAgICB8IDggKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kcnYuYw0KPiA+IGluZGV4IDZkY2I0YmEyNDY2Yy4uMDA3MDg5NGQwMTQ4IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiBAQCAt
NzY0LDYgKzc2NCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gbXRr
X2RkcF9jb21wX2R0X2lkc1tdID0gew0KPiA+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RTSSB9
LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODYtZHNpIiwNCj4gPiAgCSAg
LmRhdGEgPSAodm9pZCAqKU1US19EU0kgfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTg4LWRzaSIsDQo+ID4gKwkgIC5kYXRhID0gKHZvaWQgKilNVEtfRFNJIH0sDQo+ID4g
IAl7IH0NCj4gPiAgfTsNCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHNpLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNp
LmMNCj4gPiBpbmRleCA3ZDUyNTAzNTExOTMuLjUwMGEzMDU0MjgyZCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiA+IEBAIC0xMjA4LDYgKzEyMDgsMTIgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZHNpX2RyaXZlcl9kYXRhDQo+ID4gbXQ4MTg2X2RzaV9kcml2
ZXJfZGF0YSA9IHsNCj4gPiAgCS5oYXNfc2l6ZV9jdGwgPSB0cnVlLA0KPiA+ICB9Ow0KPiA+ICAN
Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHNpX2RyaXZlcl9kYXRhIG10ODE4OF9kc2lf
ZHJpdmVyX2RhdGEgPSB7DQo+ID4gKwkucmVnX2NtZHFfb2ZmID0gMHhkMDAsDQo+ID4gKwkuaGFz
X3NoYWRvd19jdGwgPSB0cnVlLA0KPiA+ICsJLmhhc19zaXplX2N0bCA9IHRydWUsDQo+ID4gK307
DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHNpX29m
X21hdGNoW10gPSB7DQo+ID4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS1kc2ki
LA0KPiA+ICAJICAuZGF0YSA9ICZtdDI3MDFfZHNpX2RyaXZlcl9kYXRhIH0sDQo+ID4gQEAgLTEy
MTcsNiArMTIyMyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gbXRr
X2RzaV9vZl9tYXRjaFtdID0gew0KPiA+ICAJICAuZGF0YSA9ICZtdDgxODNfZHNpX2RyaXZlcl9k
YXRhIH0sDQo+ID4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4Ni1kc2kiLA0KPiA+
ICAJICAuZGF0YSA9ICZtdDgxODZfZHNpX2RyaXZlcl9kYXRhIH0sDQo+ID4gKwl7IC5jb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE4OC1kc2kiLA0KPiA+ICsJICAuZGF0YSA9ICZtdDgxODhfZHNp
X2RyaXZlcl9kYXRhIH0sDQo+IA0KPiBtdDgxODhfZHNpX2RyaXZlcl9kYXRhIGlzIGlkZW50aWNh
bCB0byBtdDgxODZfZHNpX2RyaXZlcl9kYXRhLCBzbyB1c2UNCj4gbXQ4MTg2X2RzaV9kcml2ZXJf
ZGF0YSBhbmQgZHJvcCBtdDgxODhfZHNpX2RyaXZlcl9kYXRhLg0KDQpTb3JyeSB0aGF0IG5leHQg
cGF0Y2ggd291bGQgbWFrZSBtdDgxODhfZHNpX2RyaXZlcl9kYXRhIGRpZmZlcmVudCB0aGFuDQpt
dDgxODZfZHNpX2RyaXZlcl9kYXRhLiBTbyByZW9yZGVyIHRoaXMgcGF0Y2ggdG8gYmUgYWZ0ZXIg
dGhlIG5leHQNCnBhdGNoLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gUmVnYXJkcywNCj4gQ0sN
Cj4gDQo+ID4gIAl7IH0sDQo+ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG10
a19kc2lfb2ZfbWF0Y2gpOw0K
