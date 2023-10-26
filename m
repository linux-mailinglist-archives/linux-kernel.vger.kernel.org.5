Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF4B7D7A47
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjJZBmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjJZBmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:42:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD3FCC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:42:27 -0700 (PDT)
X-UUID: e811d4f073a011eea33bb35ae8d461a2-20231026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LscU3KWmzSnNboI/e9nw9otstu0QUACkiNnXgZfhH5M=;
        b=WfzkFaZfE884zmqL5tViYLpetqieTA6pIu9gPitAkOpSt+j0KCPc7V9EsbWhpMab9+pJEMRsVsED3WoMC/Qm1zEGdUGgaI2m91KyEOca4TJCJ1wnpXN+5F4GnYh617fV8MRPKyqym+StPj1OioVLLS6z+V9CKYSrVntmBzGaaks=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:48799525-7666-4296-9248-076724cf60b8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:bfa5eb28-cb22-4fa7-8134-287af20ad1fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e811d4f073a011eea33bb35ae8d461a2-20231026
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1011932322; Thu, 26 Oct 2023 09:42:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Oct 2023 09:42:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Oct 2023 09:42:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAoqSHNj1EwTVZc7YXbXUwRilYp28iG6PGURJ6NKjE1OEt3Jcbmo24pqDIQ1tefNz6i/l2/tA8zFjFwzih9F/d1lUNsPZbmUHf9pD8RPM8SGRJMcOptJCHd9v/XDXs/b0yCUsBn9RVKBJ43kAwLcvLigiJpJPqQe0g/nRfbyvOpU08NM4Gm0LOa+pRzHygNUdWEY6Z8Z+b7e3Bu1CroQf6+8nNUyMcZF9ldwYDYG5NTL43VurjTSU21WAaLMpI+qyyeZpyUBrOaEz5KTn+tDyftkRUq3nitgmA60eSMLavu4K8vHhDUoQxKbwufj4O0DW3yEbhjxJF1JyE8VJv1oHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LscU3KWmzSnNboI/e9nw9otstu0QUACkiNnXgZfhH5M=;
 b=Fxzv0ymcxiNs8AzP/hrmRWxnUucV50kbW4fKt/VfKqztpkfQQCHUBjMvvprzsXKKw0f5dPuh6wa0Z2jhpcUdxcSAf50dKkBdh62apRcSgGyfGG9msYhxxmPyf2C2Xuj6/ugB031OilIOf6GH8m0Svv/x+m2xTWfkd4I8b4Y8ssrc6iHK+8MUNFYwc+1sHrTCWAVbHprT1b0jqmF+I6tbuIrQJdTXUm/WyYsFmIBHkG+mPPUm3jS3A4UgrAP+QFOP4uhA1HP9+S5iFycWG+Q/JFS97l8bP9iU3z4HpkhUoAZnluqxLwpr7ocbFolycCIgn7qAx61+V4Ls8fOpvJC+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LscU3KWmzSnNboI/e9nw9otstu0QUACkiNnXgZfhH5M=;
 b=ECq2SXjAVnt+HINiqnha1G1YAHAbS4+8ldAG3BjUPNd/fFH6t9el1XqHN8i5n+Z66ho0i4sm9Ky/ZNb/UhYZ183ooPwaBlxRdiqKJ4O9e6Mz49WqzmP3cqrEMsGTX9HOv3OFL3QrYSBARfNgpppl4ffVkby29KkK88bsWZMM/1o=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB5501.apcprd03.prod.outlook.com (2603:1096:400:c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 01:42:14 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3%4]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 01:42:14 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= 
        <Bibby.Hsieh@mediatek.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/1] drm/mediatek: Add missing plane settings when async
 update
Thread-Topic: [PATCH 1/1] drm/mediatek: Add missing plane settings when async
 update
Thread-Index: AQHZ6f3ZJK6zauzp2UmDH/x2xITuFrBbh04A
Date:   Thu, 26 Oct 2023 01:42:14 +0000
Message-ID: <04e8b009609ea834c09f0139663432682c44f873.camel@mediatek.com>
References: <20230918070028.17915-1-shawn.sung@mediatek.com>
         <20230918070028.17915-2-shawn.sung@mediatek.com>
In-Reply-To: <20230918070028.17915-2-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB5501:EE_
x-ms-office365-filtering-correlation-id: 56e3a0ba-a253-41d1-c819-08dbd5c4c7d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RCbB2cJ/YV6yYiC5KUG0w5r7AXdg6CiGARjyqAoGSBMyl8g1WRi5VVHqZBRoROuDpJrkyfi0kkTcMaT4HSZmSwMmAW6l8oIdtNW9t29zXEZCxDQcPFu3nskGfYNqaGbslfRe7pS3HPV3t0sZCGo/1tNjHNK6FlfxTnpk3cQXh8hN1dEUTbVzsbbR1sbaKNgdUYnUiQXpWJ6ud/PM7t/6PZ/s68B+j+uQ9k4DcEr8nxuAWKiZndSQzaiEGlrXfCGVkVlWBA1HaayQmUgGZVuHjf1TSxL9yccvBMBgR1f2tlsULxrEKET0Bs5QLNg3fmgnWVC9j1YctwPI1kvJCXNxUFOkSjc/PuOZmVmxg6YSvIb9LPrULfm2XCYrafl3k5Wl14H80MAjsUKfx1eNWlON4ywXOEg6EGctwOJ5AaankcyxK17ADCrYpqd850DSvgJrsbmIauzaEyQnMO8foUbuffS2MFqvtvuvPtOqhbT2XYCJs/C2sZV1m9gcRSyuPyCIQTZ9tytDV37FyAa24jDDDSEEQraOdhh0+20plTndtH1QAMm4vd7JRGu8N0+q6aboxzINyDPhR8ZDDIiYLw0Pj7xKusbpS/bx2InYfC36/sFZRI32yZsekoCJnaZiWbbhzz80EnGpQ1LhsEuJ96FaqOjp/KfLigSnDwqySKbayRg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(15650500001)(41300700001)(5660300002)(2906002)(4326008)(8936002)(8676002)(38070700009)(54906003)(76116006)(66946007)(66446008)(66476007)(64756008)(66556008)(316002)(110136005)(86362001)(71200400001)(2616005)(26005)(6512007)(6506007)(85182001)(36756003)(83380400001)(122000001)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlpxMWRKbWRiVFVBR2xQSExhQk91UHlZckJnbDVUZWJSY3JxSklEektGNFdn?=
 =?utf-8?B?OThsaVNrT1NmMmxvRFZUZTBDSWpZU1JVeTNLbXBreDBVOEhpRUljcmNPRTIz?=
 =?utf-8?B?MjhBd3pvME1xWlV1NkVRRUdvTXVZQzRZVW55YXdBNktML3JaRHZocWhUQlNY?=
 =?utf-8?B?Z0JIRmhMTFhMRzE2dmpmbnBRSUJNMmdmSGt1LzBsNlZVTlRXVzdXcTlmQnVy?=
 =?utf-8?B?SzFKVm5XRFNyVC9Ld2ZaQm5nNUdWcDN5RXZHSWpwWmh4eGtGVWFxYjJONjBh?=
 =?utf-8?B?UTFHb29EOEhTV3dUbXR2V2dUcDMvNEFaU05DcTkvNENrZzhhSlgzbHpTblp5?=
 =?utf-8?B?Q0VTUENka2gyTjlLcDBwVkJGK2owM3lnYlZSYmlMR2FGRVJBd0kxSnRzbW1w?=
 =?utf-8?B?dTNiM0NnK3ZOaUNZYTI0UCthYk9DclUxdzVVK01TTUd6Y1FaVjlXUmFFYUgw?=
 =?utf-8?B?Qmt1Z0d3NTZPM2JaUWV5eFhWRm4zdTFPMWxRUHRzYVRZYVVFOForOWxydFRK?=
 =?utf-8?B?MHl6d0xLeU80b3dHRG9wcUNiaU1QZ25WRGh0Vm5aVHNIaUhGcU5SUDk0cStH?=
 =?utf-8?B?L2dHM3VTMmI5YzZSMXlpTVZQOGMvcysxaU16S1NSWlo3YUdvUmI4TlpHOTUx?=
 =?utf-8?B?emdNL1hTbkpLVTBmbmwvdWF6ZDhUTmNGMjRGRCtZZkYvSHIxS2lBRy82T2tK?=
 =?utf-8?B?Y002K0haeldJc2xSbkNRcjdGRVBycW5OR1FaVnRJSS9salpVZForUE82TGhD?=
 =?utf-8?B?S3lldW5xUEpyMDZocjd2NmVNVS9GT082LzlXL21IY1Y0THhYeDYxYzZFbkdp?=
 =?utf-8?B?WHJsQnJoOTdxRTJZQmk2eU9IQWdMY0xoSHFIUFFNWktGS3NwcFhwRFM5Vlls?=
 =?utf-8?B?SDUwRkpidFEzSnNiWFVOMkZOUml3RnkrQlR3NlBuV0RSTmhWRGxraUdUMTVS?=
 =?utf-8?B?LytvVlAzd0M3NFJMMmlVcnFveGVqd1VpdjlzWFZkMjE2QmdKb1BjaHc2Q0RS?=
 =?utf-8?B?Rjc0WmZLdTk2RUVVSmhDcmpnRkZKQVBUdXBRSHdmR3B0a0hqYkR5UnRKNFZX?=
 =?utf-8?B?eEtpRUpJYmhIUGJIdTFBQ0Jmd0J2T0ZUUE9WemVSY000SEd2SjFuOXlrWGdI?=
 =?utf-8?B?MG92aFQ2TUxqNFNaT0Q0R3R2b28xSnNoSDBUV3pPb1dJOXBJcXVTWWRKemhR?=
 =?utf-8?B?UUdVRHNlUEwxTUs5ZVI4d1BEZkJEM1VKemxNdXNLSXZSQ2t2eC9YTG45cnBZ?=
 =?utf-8?B?WElCU3dkZUtVRnMyVGFvTUxDcjBLeEtteDVUSlp3Yjk2dU5kQUh2S3FKZ0F1?=
 =?utf-8?B?dVMyaXhqbW82SngzalAxNkFZdExqaEtNVHVNZ1RwZStYb0tVcEw5aXB3WEtX?=
 =?utf-8?B?VmRQS3I5KzI0aU9lVEtEZC82TmtvNjZOdnFmMjVYSEt0MDIxRm9zaUdQN2xM?=
 =?utf-8?B?N1piY2p2aGdDdEhUbHZSczdQaXc4Nk0rQjhKSWttUG44MHR3Q05pQ21tUEI4?=
 =?utf-8?B?eGJ0Nm5YU2RKUHViTHREcnFUREYxbVJNdWRGdmVmdkpsNkhiMzhycnpkUFpx?=
 =?utf-8?B?ZWFqOTNiRU16ZW1sUDcyWHBMRkRDN1VQK3FEdGRWNHJJSlJhKzJXQVRaZHY1?=
 =?utf-8?B?eUNEenlMbUNkWUZWVlVpQVByUlJYaWFwV0ZveW1sZjVWVCtONXlZeFJWNitD?=
 =?utf-8?B?UEFJWVRnb2VUbndXcitOcEZFMmkvQjR5OGJWaXhRNnBxZk1ja1YwK09XZm5t?=
 =?utf-8?B?UWljZitjUzNpRk9nSG9WQXFkbEdHbnNZNldNUW13aXRRR2tsYjFjMkdDSTcw?=
 =?utf-8?B?L1d2YlVJa3JxWXEvY2xzOGFSL0dIZ0JnNm16TWVuM09yRU5uaDR5eFVsOHRI?=
 =?utf-8?B?aUR4M3JvRFFvMG5hMjlXOGZ5U0h2Y0UxVzhLdytaNllZTVRtRFo5Um5VUEhB?=
 =?utf-8?B?T3FUSEp5YU9QbGMwODZoM09nN1lFVWlMWkNKS2JHT1AyYzN6UWNhVFc5NkVO?=
 =?utf-8?B?eEtzQ3ZOMDJraFA0NVZiYzJWVjd4b3c2VVNPOTl2d1ZISTJxQjVFRDRHbzNz?=
 =?utf-8?B?V3BUS2lqR0VLY1VsZm52SFBRM1ZmeGhxNnlGQWJFRExnZzNZMjdWbCtLeTdt?=
 =?utf-8?Q?mqKWD8EEJUB1zoZiDAbPgVWk4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A790A3A17349FF43AD5F8DD2B3C76ED2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e3a0ba-a253-41d1-c819-08dbd5c4c7d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 01:42:14.5801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijHRk32IalAxZXmJAQh+HIOSkzPkKarGvcSIE4mm6hhjfgdRBNOkyBgkYaDi1gSWyi/L9fIuTnH9L1r6J9wNBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5501
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMDktMTggYXQgMTU6MDAgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IEZpeCBhbiBpc3N1ZSB0aGF0IHBsYW5lIGNvb3JkaW5h
dGUgd2FzIG5vdCBzYXZlZCB3aGVuDQo+IGNhbGxpbmcgYXN5bmMgdXBkYXRlLg0KDQpSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gRml4ZXM6IDkyMGZmZmNj
ODkxMiAoImRybS9tZWRpYXRlazogdXBkYXRlIGN1cnNvcnMgYnkgdXNpbmcgYXN5bmMNCj4gYXRv
bWljIHVwZGF0ZSIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3
bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9wbGFuZS5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3Bs
YW5lLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IGlu
ZGV4IGRiMmY3MGFlMDYwZC4uNThlOWY5M2MzOGM0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gQEAgLTIwNiw2ICsyMDYsOCBAQCBzdGF0aWMgdm9p
ZCBtdGtfcGxhbmVfYXRvbWljX2FzeW5jX3VwZGF0ZShzdHJ1Y3QNCj4gZHJtX3BsYW5lICpwbGFu
ZSwNCj4gIAlwbGFuZS0+c3RhdGUtPnNyY195ID0gbmV3X3N0YXRlLT5zcmNfeTsNCj4gIAlwbGFu
ZS0+c3RhdGUtPnNyY19oID0gbmV3X3N0YXRlLT5zcmNfaDsNCj4gIAlwbGFuZS0+c3RhdGUtPnNy
Y193ID0gbmV3X3N0YXRlLT5zcmNfdzsNCj4gKwlwbGFuZS0+c3RhdGUtPmRzdC54MSA9IG5ld19z
dGF0ZS0+ZHN0LngxOw0KPiArCXBsYW5lLT5zdGF0ZS0+ZHN0LnkxID0gbmV3X3N0YXRlLT5kc3Qu
eTE7DQo+ICAJc3dhcChwbGFuZS0+c3RhdGUtPmZiLCBuZXdfc3RhdGUtPmZiKTsNCj4gDQo+ICAJ
bXRrX3BsYW5lX3VwZGF0ZV9uZXdfc3RhdGUobmV3X3N0YXRlLCBuZXdfcGxhbmVfc3RhdGUpOw0K
PiAtLQ0KPiAyLjE4LjANCj4gDQo=
