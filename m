Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2248D7C47FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344878AbjJKCut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344880AbjJKCup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:50:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4A48E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:50:41 -0700 (PDT)
X-UUID: f177d0f667e011ee8051498923ad61e6-20231011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=owfH0kc43IRmn1zI3gxn/1It+Z8+CAnur4z6HY9U6T0=;
        b=XF0mkNFnMJjRIgmdvJ6CdgbtIyNZEE43oUgQKngiURbq80CCYNDVOlhhtdcZ+dRND/6R3YwAFbv0ya/3VAQYoiNxnPE6eDWsk/taLQu2P4v8dIAe9ZNyQT2sX2IIeij9K8LLGBKb4V2o6AskhmnPrEIbkFk4cNq2Jvfjk3OETUA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:087b1a8d-3456-4f3d-8723-3720bea36c66,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:5114fac3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: f177d0f667e011ee8051498923ad61e6-20231011
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2088182090; Wed, 11 Oct 2023 10:50:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 11 Oct 2023 10:50:30 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 11 Oct 2023 10:50:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWMnTFDVb7PYbrMNlRKna1VhkxOadSbPMJtITQYr5TL/K4FCNpr1rhBzEqonh/dknknbGuw6h6FUTamh+HvSWLWvIDGEvVqaaq68PCtieAVf+2A0qEdz2oCOzAvWvZMbOIcxdCnwWGAFM6fe4h7/mWiBfy9Tz9cOwCb2fsLVzUZle73Y9FfExvcAIl2KiVJm2LXCa80RcllxoG704SRvXUU63zjO+Ms7jukzlv7jAhtIv0W8/zYIwB5JE+dpZ1BFFdy9el4bOUN5Vxo+hyx8NLybte/vACLHSwmNCBA1bOF1WXLGlFR4bQKeW93fzuSbdi8KVaM+Oh81W6B8L0gOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owfH0kc43IRmn1zI3gxn/1It+Z8+CAnur4z6HY9U6T0=;
 b=VZvEZhttMNeixWq5Zb8KX+T9N+0YsHXlSIOtei7BxyqC1Dc3VfR12Hs8VBu3xSfejBnYQS76sZjTopHmGtqpDiGspOwkBwvhFLae0/j89wLNzc9IL9idQ9UdTcD840aVv9uqtPxbLjzzdlGnbketWHAPn3mz+eL0jTUERINn0plVEAAdqSKifMfWSffROu9MzwlhS8Z5sRZ/uAoO/T3xYhxOb4ZTe1fTkSdlhhUqHoj/o39afzCZHgP2bWXXOIFxbFPdbddjWNU8bbcSqt2iQCzwzg40+Qn+MZzBRAkznxb6Dn2UbkFuMaQE4TeeWTOsmvCbueJ3n6AncgmGDI8MEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owfH0kc43IRmn1zI3gxn/1It+Z8+CAnur4z6HY9U6T0=;
 b=Vu6wWI2IlBDGqqYXin8EH8fa+VSDJmEBzYK4kb3kbOeSyfD/N1Czs1jczmfRNM9G242+ozl7OORD6TnQ1M8OtCxtufe5H7y415Cb2MlyIMX6qfjiG/p65/Y7mEfBTR1PuRqlFQSyQ4VqQhF4SPQout+N50pCC+rOGghfBEGOtXo=
Received: from KL1PR03MB7648.apcprd03.prod.outlook.com (2603:1096:820:e1::7)
 by SI2PR03MB5627.apcprd03.prod.outlook.com (2603:1096:4:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 02:49:44 +0000
Received: from KL1PR03MB7648.apcprd03.prod.outlook.com
 ([fe80::c243:5f15:7d59:d6eb]) by KL1PR03MB7648.apcprd03.prod.outlook.com
 ([fe80::c243:5f15:7d59:d6eb%4]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 02:49:44 +0000
From:   =?utf-8?B?TWFyay1QSyBUc2FpICjolKHmspvliZsp?= 
        <Mark-PK.Tsai@mediatek.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "xuewen.yan@unisoc.com" <xuewen.yan@unisoc.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WUogQ2hpYW5nICjmsZ/oi7HmnbAp?= <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2] ARM: vfp: Add missing VFP instructions to
 neon_support_hook
Thread-Topic: [PATCH v2] ARM: vfp: Add missing VFP instructions to
 neon_support_hook
Thread-Index: AQHZ77KjtF0WjwrmskeKe6Df0HQ0nrBD+8SA
Date:   Wed, 11 Oct 2023 02:49:44 +0000
Message-ID: <7e68377e780a2f4312a69ce8afda0cda8ad84568.camel@mediatek.com>
References: <20230925131720.7672-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20230925131720.7672-1-mark-pk.tsai@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7648:EE_|SI2PR03MB5627:EE_
x-ms-office365-filtering-correlation-id: 11fd4dd2-501a-4628-b2f9-08dbca04b980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kAeRThfPJXafIRzBQ7Zd7FU+3v5VwU7vF0kkiijMJfE72uAi95OZUqDORBFBVth4gxaakzPC/ztgkJAoBgFV+CEjQAtb2IfzZNbEeiJq9mP+4DpZBE4jffzLwNah4osVNZEcOXkaw8W4NDv2o4eWouFLL3enrQXwKUAs7lsP4w4NzG7Mcrd6FEnW/+a/1SEi1lDFQo8v2NkfKPSUUUPHdwGsd9mLmlVwQ0tQmukAJjb9z2fIycoZ0SCW3l4oOVLFmYVZyJvJNjGOqE+Z5s7vYSw6cfcSd/F+m4V7pkt43ZolWThpQYaGYeIOfbjBMq2EBWQl152TAVS4dv/mU+XztNrToOTLkAVoAdRTdR9jJeGhpDWqrqS0OciSlDSSppGuaqX2uzy9B819SVlJTfpXvcuz2ztg345exPyfQhsT2AM01Ivhncn9DFETfhICZHG+3E/l9c7t8IoicusfxDRnXLnJToglDGoNW8DH64j1x1mc4GxljqcC9pp3UtfmDr+wUBbrRw1HC491wriTPUbZOMGXFDZNiTxNZQufr5wuqzFBN5wc1dX9SaKTw0grZEEJmEX2NejCbEncE7oZnjaPx8Y0cmN/hnc9rzLJry4ooybB4znx+yRGeOXERdBYhDQs0X4lrPzhZKYTomcPZ3bmjOnUdkl1BWbXelbTXQv28jHoqLcZALprJtQEJ4eCHZfi+KLWgd2rPf8pJoNEaQa3vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7648.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(107886003)(6512007)(85182001)(36756003)(122000001)(86362001)(38070700005)(38100700002)(6506007)(26005)(2906002)(6486002)(966005)(2616005)(478600001)(8676002)(71200400001)(8936002)(316002)(5660300002)(4326008)(76116006)(66476007)(64756008)(66446008)(66556008)(110136005)(91956017)(66946007)(54906003)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejFlTjlHTmhXWGNkSnphMnNnQkxuTHRvNzZEWHBlU2wweXVQQ1U4OGw1S25x?=
 =?utf-8?B?cEs0cXB5eXc5cFBNT0I0T2RjcEVjajl4TGN4ZVpHREFCVG1BTkM5TlFoZzFa?=
 =?utf-8?B?OU9BbG0reG8xeFkxekpjTlo3bzl2cEc2VGNhSHphTVkrSWZJTGxsMTFVMmI3?=
 =?utf-8?B?aFp5TnZsM0dtMjgwdTRGZ0JtMjlMV0lYcEtYTmoxWE5ncWtiNFp4YXNRSzlZ?=
 =?utf-8?B?aUNSOWVxS0taOVFML1Q4Ny9tNUxZK1FJM3NUNk11a1UzcmZGVE5ZalFaRmNs?=
 =?utf-8?B?cmRCT0hyVmp5WmIwTmtodHFYMkNGK01Ic3lOK0sxNlh3bmRkR3NYeUJXcmE1?=
 =?utf-8?B?aUJ0dTlQYXBZeUFlNE9mbzhOQlJIZkw1OG9pR0RWYzNhdWhCMndtWkZnMTQ5?=
 =?utf-8?B?eCtwcVVYSWp4Vm5WQ01MUTFybEFRSWEzemt6emdaUnVOeFBSd3ZTa0xKTkta?=
 =?utf-8?B?S2lXQnA0eGcxbEhwN1JNSjdQVk04OWl2MURPTjZuMS9lVVJ3MXE4RzA1aVdO?=
 =?utf-8?B?OEtyODVYMmlHREMvWmxqQUxsSWlpdGZvbnd4OWxSQjZjZE9nNXAvampJUVJW?=
 =?utf-8?B?TkIwYzBIeTE1S01uM1d0M0V3a3BiZHBzTEY1UFc1TmVsZzJxdDFZellOQWQ4?=
 =?utf-8?B?Rk1vSlQyaDAvQXRKcHphTjRiQWcyR04xMkJNdEUybSs2aXZ4OWZMa0luOWhT?=
 =?utf-8?B?S3pQRUZNc0JkbFd3Vy9EYllzcW85UTBzNWdraDkwclBlVHNiS3RiKzltb0FQ?=
 =?utf-8?B?aHp6VFMwSlZTRHd2R0pLcThuTWZudVVWWmhTTXhzNXFtREJET3VoRDRGcDV2?=
 =?utf-8?B?REpHQTR0WEJ6L3lpaHJhK3BkclJNOUVjRnlCd1RHQjBwcDhobU9iaDZKODQx?=
 =?utf-8?B?NDBIc3lDTm9ZQmJPMlQ2UTJkWUYvaFFoOXRpcjF1TThvVjZXMThlWCtVK1Ft?=
 =?utf-8?B?eVFXaTROOWw4RFFteUNGN0x0SkNkNzFzNmwwR2FSR0NCOHI4MC95WkZ1bVgz?=
 =?utf-8?B?ZitMa1lVZi9wVCs5UVJpTUg3Ky9PMDRUYjM4L1ZOdWdwdDh6bDFqTWlCL2U5?=
 =?utf-8?B?eWQrT3E0b3dPbDFqeW5Qcmt1ZDJrbEFTNXh4N3p3b0JrMmEzbWhiTi9rZS80?=
 =?utf-8?B?R2kzcEUxaGtUcjZKd3BsTkFLek5RS29OV2FNMTNxT1NJYmxLUzFoVXBKZXRk?=
 =?utf-8?B?aTZZMzV4RTVOZHpIbVlyd3BOQkt0YUR4OUV3eXZPV3ZMVUVXL1dqMHlabUlo?=
 =?utf-8?B?WUVaazMwNC9ic0hGcFZpQ2RkcHk5TWViSjNIdTQzc3E2N3VGZWlhNWw2dWlR?=
 =?utf-8?B?QWw4Z1F2Sk5kMjRHRGgvQVBhaHN1Q0J3eldVU1BSNVdGbzNrNU13ZmNDalND?=
 =?utf-8?B?SDhpczk3c0M2ZEg3ZVUwd3M1ekoxWlF1ODJxTlpvQWhlN2ZmanpNZWh6RDZJ?=
 =?utf-8?B?TFc1NzhGQXBRa0wyWEo0OGFoRVh5MWdhNGlWcDg3WlV3RG5HVk5rTWszUDR1?=
 =?utf-8?B?eC9EQTU2Y1pxMFJhYVRzMFB6aXN6M0E4UnlmRnN0d2tUZFZxRzJSNWNKWXBu?=
 =?utf-8?B?ZTVyV3VEQ3RicEEyaVdDc3NkSlczV2FCS1h4UCtveFpCSmlTc1ZxdHRIU0Z2?=
 =?utf-8?B?dGxtR3VMTFNycFY1RkN3UFNTY3ZlRWtVUU5xMGlYZXlYWkMvTGd5MmxWckFC?=
 =?utf-8?B?dWRoa252SkxRamtibTdjUmZQN1hGeFpGaUZ3NkNndkI1Vm1ocmREVTA3UTZq?=
 =?utf-8?B?UEtUUThQSGJlbVBBRnFUNUFSMUNqSUM5WnhwWFBmYTN0WS9WYjgyNUNpbnpU?=
 =?utf-8?B?RjRSVlRQbkxrZCt5T3ZveXdOR0ZxQ29qNWdHV1hSVEZQbDlqUGp2MHhxSWNk?=
 =?utf-8?B?MXlKOVh1VmZTN3h3WWNGd3Fwdlo3a1VvK2YxeElkOXo1RVI5eVFUY1QyUURB?=
 =?utf-8?B?eFJHMVhpNDhicGEyOEZWdnJ6VzU2ZU9MekovV1hUMUtySTdhbWkrT1FEU2JK?=
 =?utf-8?B?WEs5RzVqOHJLaVZzNDRoNW5IS1ZrMGhMRlRvVXRlSDRkOEhEdVBmcHFkcFhP?=
 =?utf-8?B?V2lJc1loV1V0Y3A0aTVEazlHeU1xMUNpc2duY1I3dW8zWk5CWC8za0NrVjMw?=
 =?utf-8?B?VmhhTkt1bnoraXRpb1p2aG1Nbkw1dEpnRGc4OUZOY2hzaStudkNtRXQrOVB2?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82D0D061B028C547AAE968AF2B43A5B2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7648.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fd4dd2-501a-4628-b2f9-08dbca04b980
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 02:49:44.3594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lw6dMKJY/u2DYcoG/fOrb2oU91lPEWgsjEvKhdlH2zIOsvpXSG6iJcZcTR9Fuvx6bRbQf3BJCLSr9S9gaYqGdC2nS0mwh6j/vja+IkcYUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5627
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTI1IGF0IDIxOjE3ICswODAwLCBNYXJrLVBLIFRzYWkgd3JvdGU6DQo+
IEFkZCB0aGUgbWlzc2luZyAiVW5jb25kaXRpb25hbCBBZHZhbmNlZCBTSU1EIGFuZCBmbG9hdGlu
Zy1wb2ludA0KPiBpbnN0cnVjdGlvbnMiIGluIFsxXSB0byB0aGUgVkZQIHVuZGVmIGhvb2suDQo+
IA0KPiBUaGlzIGNvbW1pdCBhZGRyZXNzZXMgdGhlIGlzc3VlIHJlcG9ydGVkIGluIFsyXSwgd2hl
cmUNCj4gZXhlY3V0aW5nIHRoZSB2dWRvdCBpbnN0cnVjdGlvbiBvbiBhIHBsYXRmb3JtIHdpdGgg
RkVBVF9Eb3RQcm9kDQo+IHN1cHBvcnQgcmVzdWx0ZWQgaW4gYW4gdW5kZWZpbmVkIGluc3RydWN0
aW9uIGVycm9yLg0KPiANCj4gTGluazogDQo+IGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9j
dW1lbnRhdGlvbi9kZGkwNTk3LzIwMjMtMDYvP2xhbmc9ZW4gWzFdDQo+IExpbms6IA0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwOTIwMDgzOTA3LjMwNDc5LTEtbWFyay1way50
c2FpQG1lZGlhdGVrLmNvbS8NCj4gIFsyXQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrLVBLIFRzYWkg
PG1hcmstcGsudHNhaUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vdmZwL3ZmcG1v
ZHVsZS5jIHwgMTggKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3ZmcC92ZnBtb2R1bGUuYyBi
L2FyY2gvYXJtL3ZmcC92ZnBtb2R1bGUuYw0KPiBpbmRleCA3ZTg3NzNhMmQ5OWQuLmI2OGVmZTY0
M2ExMiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vdmZwL3ZmcG1vZHVsZS5jDQo+ICsrKyBiL2Fy
Y2gvYXJtL3ZmcC92ZnBtb2R1bGUuYw0KPiBAQCAtODAwLDYgKzgwMCwyNCBAQCBzdGF0aWMgc3Ry
dWN0IHVuZGVmX2hvb2sgbmVvbl9zdXBwb3J0X2hvb2tbXSA9DQo+IHt7DQo+ICAJLmNwc3JfbWFz
awk9IFBTUl9UX0JJVCwNCj4gIAkuY3Bzcl92YWwJPSBQU1JfVF9CSVQsDQo+ICAJLmZuCQk9IHZm
cF9zdXBwb3J0X2VudHJ5LA0KPiArfSwgew0KPiArCS5pbnN0cl9tYXNrCT0gMHhmZjAwMDgwMCwN
Cj4gKwkuaW5zdHJfdmFsCT0gMHhmYzAwMDgwMCwNCj4gKwkuY3Bzcl9tYXNrCT0gMCwNCj4gKwku
Y3Bzcl92YWwJPSAwLA0KPiArCS5mbgkJPSB2ZnBfc3VwcG9ydF9lbnRyeSwNCj4gK30sIHsNCj4g
KwkuaW5zdHJfbWFzawk9IDB4ZmYwMDA4MDAsDQo+ICsJLmluc3RyX3ZhbAk9IDB4ZmQwMDA4MDAs
DQo+ICsJLmNwc3JfbWFzawk9IDAsDQo+ICsJLmNwc3JfdmFsCT0gMCwNCj4gKwkuZm4JCT0gdmZw
X3N1cHBvcnRfZW50cnksDQo+ICt9LCB7DQo+ICsJLmluc3RyX21hc2sJPSAweGZmMDAwODAwLA0K
PiArCS5pbnN0cl92YWwJPSAweGZlMDAwODAwLA0KPiArCS5jcHNyX21hc2sJPSAwLA0KPiArCS5j
cHNyX3ZhbAk9IDAsDQo+ICsJLmZuCQk9IHZmcF9zdXBwb3J0X2VudHJ5LA0KPiAgfX07DQoNCkNv
dWxkIHNvbWVvbmUgcGxlYXNlIGtpbmRseSByZXZpZXcgdGhpcyBwYXRjaD8NClRoYW5rcy4NCg==
