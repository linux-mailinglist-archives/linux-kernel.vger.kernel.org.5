Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56727AD442
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjIYJLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjIYJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:11:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA5C9B;
        Mon, 25 Sep 2023 02:11:42 -0700 (PDT)
X-UUID: 87082be45b8311ee8051498923ad61e6-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vD1c/M1Nf+/vxxmGR8DG8cl+xRr43Ii9OER6BL4XJnk=;
        b=Z34nBY1lZmF5nb0mwSgR2hJGfJGpocztIz2nLN7l5LHzpl9IK8ALc3zkY2NZevN1zVkLfaJ/uy3O40NC0brnE8/QLGlu6iBFy4ZPESzpdsB7ZqQ8nwj6vfe8Ptu8Dsd++LXK/FId/Tc0onXLcjiNalUtxQ4P/XvBVDMhTpU7ZXg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e1cb24cd-5a92-4a27-a360-185c9251b953,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:870c5814-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 87082be45b8311ee8051498923ad61e6-20230925
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1787474115; Mon, 25 Sep 2023 17:11:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 17:11:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 17:11:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNrP2QOkfOE2u25N96fskxhzL11l+8yV7p7W8EOxJGoIuDq98I+Z0lWPUPBDYpiw1CE44hQNaRabN/6JHj0B5KaVw7QzNynLR9d2gXvfVZ8o96BSQiHcBRtc4QQjvBGzioTEqUAsGUUqUWH31YggweNobKAbm9eIvDZmeb30wRGOdkbdwT/FtRyA2krSPCJ3/WIKA+zKDglezEh37Hq/1m4UirRgVcaTLzcSFzz5lYgSerFzLmMR8cp7mQb2JJpqprwsF1UT4TNDuRVxXvPIhrzf3ZpwQcUWLNcsOj+4EerOl/p50MVlMiuGnuwttAf5L7Fy7N3tQCXRurU2+zxeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD1c/M1Nf+/vxxmGR8DG8cl+xRr43Ii9OER6BL4XJnk=;
 b=jVvQKIcQjGPrRQd1zqY/lnBpoqERBrVnY7bih9fRJHRX5YSkWr7RMrYVjEpbslYt3mLq8Wox0aOKPMAYc56on+xrigkAiJhLeX/Fhfjpj7c6JZCUzvP5zVg51JlspMKw5pTasJ0d6knr1eXpVIR44CATmNh3BQCQe9eD1eSDgiteau9dKzEuOVHhq/PvOzCeOl/V5ErdxYk4vyuneCzAyG5IhShl74sAaBhYf624tsdM/hc3jHNwasVhktqwDDEmtCBOv26gm16qQPi5vfQXeHN4hBElEE16LcVfR4gGg/So/UwBz2SrWZY0/viPuDHMvj0afbyRe18TVlalN9ZVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD1c/M1Nf+/vxxmGR8DG8cl+xRr43Ii9OER6BL4XJnk=;
 b=LJx8jvztc+hUzd5GgpX56EuaNkU1iM/HepC58Fp/M/URH7c2GAqfJewaVGFpj4l1CIj5XEHH3SV1a/fxdsS/COW1jjExtAxHdDRhfR60osIUgNU9llSW/EiFeWlihMdDSzydXVOd1eABA+bQXKCOYyJBvyehpII+lvo9mYXlNX4=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB6376.apcprd03.prod.outlook.com (2603:1096:820:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 09:11:30 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 09:11:30 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 02/15] dt-bindings: gce: mt8195: Add
 CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Thread-Topic: [PATCH 02/15] dt-bindings: gce: mt8195: Add
 CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Thread-Index: AQHZ6mVuaEaAeOxsw0iaYveBj8ZT1bAouz6AgAJLx4CAABsCgIAAKbeA
Date:   Mon, 25 Sep 2023 09:11:30 +0000
Message-ID: <354bb70cd3f1921dd58629a044af7bfe4f3306c0.camel@mediatek.com>
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
         <20230918192204.32263-3-jason-jh.lin@mediatek.com>
         <20372e40-e4fc-467a-d91a-fcf8e26728bc@linaro.org>
         <1f324b04cbd8faa7510a3519eb718c0be25af2be.camel@mediatek.com>
         <e69ca292-e0b9-4ee2-9f4e-6e9300a636a6@linaro.org>
In-Reply-To: <e69ca292-e0b9-4ee2-9f4e-6e9300a636a6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB6376:EE_
x-ms-office365-filtering-correlation-id: 981e9e9f-c217-4664-f53d-08dbbda767ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tVRLYxsngyjajtQEsRwMbrcuJhdjEvBGH6fsjsNdWiyIiMDRGQ3rp2ufcltSSg1xkZ2vephGA3CP8kll0KSBRMhgMOSJ4zUWdQCKEfO9ehHT0i6nloRdYXxbjXDslsVusiUsQqsX22ziAFR67iCkWaA4uea6pwSA/w6rClLBBxHM+VOanTTqtLZnKx/3H1QAEw2Rq5/4XE0fIZO0L3uK2GkpXHmEpFEwM1j3/JrTusf2pZHybbb+Zg+OQfRXIae/LKmrBvelV32Jfg3hxlAZpUsH4HiUNdBsmNTPoloUVD8ey5Co+jix+LMfdSRPFAiSqeEhKTxZqWx9/pD8QYvWKZBrnIhJvrHR2ZDDuErZ9KfmyFrvYMIEn5r8s+QXIhSwfBRTIw409v/1ui1TvFJ71ULKVNqOc9AetzyAlubhCQpsNL2Ty9e3mVFWD/Z83CxxwsxB6dsQYuh6pMBfSNUd/w2UdgPGhPkHZ00M/a532NsuWX7WVpIAWL/mnjJPGAHzp7Fq+fjz7Fo3EnRDsa0MS+/EqJfsl+aL0CoXlL630Fs0UlTYAFiXUjZKMekS2CYhpS5WTMtE/+KArdES1rcdKhyFLB/UPn6Z4w9gaRthlhuDee4J9EbNn1xrXqVrWvt96BWJlklq4mlEMZllFLQREvI+nbGw39moSm8aex0hmPA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(6506007)(53546011)(6486002)(6512007)(107886003)(26005)(71200400001)(2616005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(86362001)(110136005)(91956017)(478600001)(122000001)(38070700005)(38100700002)(83380400001)(54906003)(2906002)(8936002)(8676002)(4326008)(85182001)(36756003)(5660300002)(316002)(41300700001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWIrWUJTV0YzRmZFZjc5NDhxSUR3aFBJNC8vdTNOdjFiQ1N4RkxKTzhqUXNK?=
 =?utf-8?B?T3hLQUtYWENOWGlFWUlYQmdoWWJqY1lmdlJpcU9nNlZmZEh2NTgwcUZwTEtC?=
 =?utf-8?B?ZXMvbkUwV1dvOU9rbkh2QlV3MzE5RkhqNmVxUmlCN0N3TjlQZjVnVC83Q05Q?=
 =?utf-8?B?ajFOeHQwMjdZakdObXZseFlOQlpuVSttVklvcVc3WmJwZCtqSi9IbjhkZ2NG?=
 =?utf-8?B?OGFVWHBZZ2NPTTdSdzQ0YzFpWkNFVmVLVEFTbWdHVnpISFRia0ZPYkZjVjdX?=
 =?utf-8?B?TEpEeVhsd1VvSzdnRFJLNnkyZzJCQnpVNncvdmdwdTFUOC9DWkFiY0VtWmlX?=
 =?utf-8?B?VmI2bU4yU2lNTTRFRFVWczJ2VkVBdUlNQ2tacGFEWmZHZTRLYnJyUUZDcFFo?=
 =?utf-8?B?cDRFRFRUU25LZFZOc2lNVE4wckxmeVlOMnNxcHkxald5UWtuUHIweDFGSUln?=
 =?utf-8?B?RHdmZUtqVEZ0Vkc2aGR3SmF0YlhKYlZHMGdJclNPWU5vM3RueFRNZjFLTUxD?=
 =?utf-8?B?QjNzdjdWbVNMaEFTTk5RbjczNjNhMkp4RFNadVdsZUlhWWEzM0NCa0JNNWZ4?=
 =?utf-8?B?MVdBbDJPTzRmQVI3clN1QjZhV3U1QUpFZ0VSUDV2MzBaZzZEdEttcGIzSXpP?=
 =?utf-8?B?S1NTVXhOT1dzRWJHbjJOWHIrdnBiRnpqUWxJTVhIcnVvMzBJc2xlaDBCWjV2?=
 =?utf-8?B?NTkxcDNvbVdhYjcrRStRcDI5NHdnMG5BbllaM2VYNi9Id2JMS1VscFNqRmhz?=
 =?utf-8?B?N0xlWFdpR3FHTFBiYzVPQlhUZFRpaHU4S2xLblZuQ0Y3dldSemYxakhTN1RT?=
 =?utf-8?B?RC96UVAwaitUa2F2cEJsc0Y2RTdYYmpnK1lXVXEydzd6amxnZC9RVWtGVkVs?=
 =?utf-8?B?c0sycWhYZk9qcTVKQ2FhTmtNbG9NNFJZSnZMTUhNbjNNY2diSnh4V25Yb1l5?=
 =?utf-8?B?RU1INGFVb29MdHBJZmxEK0V4V0dabHJXN2lpVXllRDR1U2ZpMXdJdjhMdXlw?=
 =?utf-8?B?N0V4bmE4bVNRamdNOE5tWEtsRU9jNC9kVUFkb3NtK204WG9mTk81b0ViMnBt?=
 =?utf-8?B?MC9SdDRobmdYVzRZUmZaMnRaNzFCb3ZHNHM2WnRMMUhGOTNFVXFMaGhpTGZi?=
 =?utf-8?B?WnM0VkFTV0VXdmsyZy9IT3dML0ZCRTN2blMvRXFIeEFvd1Jab2R3U0ZwTGlC?=
 =?utf-8?B?WlFPcnFmOWNrTWQ4ZzVTV3lpT1ArN3J4emhhWS9IRzRwZWFLTElhZWt6K2dL?=
 =?utf-8?B?eXFSVkdpVVY2SXZ4SG9MS3VNQU5uQUh2a3ZJYkpSWk5CR2hqVWpwVlQ4cXpm?=
 =?utf-8?B?bFQ4ZmxYWm1mVk9VS2NyTFl4a0F3cjcwYWxZQVFlRWZZWU5MZURZV1duN3pn?=
 =?utf-8?B?cy9hZldlSDNwL2JxRFRiZmYrc0hvVk5EKy8wcVB3V29kQnJkY0tPTndpQ0hF?=
 =?utf-8?B?UDRkZlo0TWZwbmp1c2t5TlNYblVBMVcwalZZZDZNc1ptbHpwOVJ4amVUVVAy?=
 =?utf-8?B?SG5sei9QMFZPTk1zYzlwRUdsUXo1UVNqeFdHY3VUc3U4d2hnQ3IrUTRub0kx?=
 =?utf-8?B?cGFBSDJLMStZTllZN0VZVlJvcktUT0x2TWdnTWphQVlEcDcxbm5yZnl4UE0v?=
 =?utf-8?B?ZHE2UHFaNjZ6S0hZKzYzK0xUL0l6UEN2M0dKZmQ2TW8vdDhsYmFNd2IrWkhj?=
 =?utf-8?B?eTAyS1JYcjBpbjZMTjF2U09IN2ZuRzZ2amtPR1dWcGR0ZDBzTytFV1JOcDlW?=
 =?utf-8?B?Um54c1IwTDJLc0VaOVhwWklrdWJVMy9uWm5iWjZsbUlrUVlCTVE3U3lxd0JZ?=
 =?utf-8?B?ZG0reFVBWXZmUC9wdjhYNE5Cc2dYK0tOWXlIdktEMEtiYWhlQVV2S2JKbDcr?=
 =?utf-8?B?TjBGTE0rOVgya0VzaFZwNUJWMHROcVlFKzFhdCtUWCtML2w3a2ROeEZiTHM1?=
 =?utf-8?B?bTRSejl1YTlMMWE4T0FjUlVSNFM2b05KTmRMaTczbHd0TUxvMGpMNTNFcmtv?=
 =?utf-8?B?KzFHeU01QjFnVUhuSlh0cTJ5Z2R6QkxpNU94WG1GOVU1M2VJNE45eUtsOUUr?=
 =?utf-8?B?RFROemlqQnMxTzhTZkFCcDlIKzJFc2ZmSGpWanRCNEYxQUFlbkplcll4bzVQ?=
 =?utf-8?B?UzlaWHIyclZmR3ZBZjhBUFpDazV5ZnFCVzZBSTR2WFZCaVluejJoNEJ3Rm03?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B19A915DFD87314990646C230BBCCD40@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981e9e9f-c217-4664-f53d-08dbbda767ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 09:11:30.3345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGomSWz5Uby69dgZ1KeN3ofAcSRhZYkx6YUy+6vkaZvt/b46oytbN4CIWxiwKNZp4qg06HS9jY4IcXdFGn4E3/qCH6CQSSTxfkJ2sd3yBwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6376
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTI1IGF0IDA4OjQyICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI1LzA5LzIwMjMgMDc6MDUsIEphc29uLUpIIExpbiAo
5p6X552/56WlKSB3cm90ZToNCj4gPiBIaSBLcnp5c3p0b2YsDQo+ID4gDQo+ID4gVGhhbmtzIGZv
ciB0aGUgcmV2aWV3cy4NCj4gPiANCj4gPiBPbiBTYXQsIDIwMjMtMDktMjMgYXQgMjA6MDEgKzAy
MDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4+ICAgDQo+ID4+IEV4dGVybmFsIGVt
YWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+IHVu
dGlsDQo+ID4+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
ID4+ICBPbiAxOC8wOS8yMDIzIDIxOjIxLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4+PiBDTURR
X1NZTkNfVE9LRU5fU0VDVVJFX1RIUl9FT0YgaXMgdXNlZCBhcyBzZWN1cmUgaXJxIHRvIG5vdGlm
eQ0KPiBDTURRDQo+ID4+PiBkcml2ZXIgaW4gdGhlIG5vcm1hbCB3b3JsZCB0aGF0IEdDRSBzZWN1
cmUgdGhyZWFkIGhhcyBjb21wbGV0ZWQgYQ0KPiA+PiB0YXNrDQo+ID4+PiBpbiB0aGVlIHNlY3Vy
ZSB3b3JsZC4NCj4gPj4NCj4gPj4gSG93IGNhbiAjZGVmaW5lIGJlIGFkZGVkIGFmdGVyIGl0cyB1
c2FnZT8gRG9lcyBpdCBldmVuIG1ha2UgYW55DQo+IHNlbnNlDQo+ID4+IG9mDQo+ID4+IGJlaW5n
IHNlcGFyYXRlIHBhdGNoPw0KPiA+Pg0KPiA+IA0KPiA+IFRoaXMgZGVmaW5pdGlvbiBpcyB1c2Vk
IGluIHRoZSBtdDgxOTUuZHRzIGF0IFtQQVRDSCAxNS8xNV0gYW5kIHRoZQ0KPiBDTURRDQo+IA0K
PiBObywgdGhlIGRlZmluZSBpcyB1c2VkIGluIHByZXZpb3VzIHBhdGNoLCB3aGljaCBtZWFucyB5
b3VyIHBhdGNoc2V0DQo+IGlzDQo+IG5vdCBiaXNlY3RhYmxlIGFuZCBub3QgdGVzdGVkLg0KPiAN
Cg0KRG8geW91IG1lYW4gdGhpcyBwYXRjaCBzaG91bGQgYWRkIGJlZm9yZSBwYXRjaCAxPw0KDQoN
ClRoZSBleGFtcGxlIG9mIGR0cyBpbiBwYXRjaCAxIGlzIHVzZWQgdGhlIGRlZmluaXRpb24gb2Yg
bXQ4MTg4LCBzbyBJDQp0aGluayBJIGNhbiBhZGQgdGhpcyBwYXRjaCB0byBkZWZpbmUgdGhlIGdj
ZSBldmVudCBpZCBmb3IgbXQ4MTk1IGFmdGVyDQpwYXRjaCAxLg0KDQpJIHdpbGwgc3dhcCB0aGUg
cGF0Y2ggMSBhbmQgdGhlIHBhdGNoIDIgaW4gdGhlIG5leHQgdmVyc2lvbiwgaWYgdGhhdA0KY2Fu
IG1ha2UgaXQgbW9yZSBhcHByb3ByaWF0ZS4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KPiANCg==
