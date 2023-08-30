Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10E78D21C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbjH3ChN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbjH3ChE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:37:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA9CC3;
        Tue, 29 Aug 2023 19:36:57 -0700 (PDT)
X-UUID: 112aa09646de11eeb20a276fd37b9834-20230830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=daKvlSztN9gWUbn4hEBeWRkhRvb2mM4oTQf//jh7i5A=;
        b=ihkgeJsw399ezPRZ9Bgr2d1wj0GxHqxM3sOBXgGIfEbtxLxwlbCUV4k+qmaT8xo+Ssb6SgAiOB+2Neakuy5p3CYhYf1hdrQV2plwbTARXW6XPdUU0DezMVt1/F26VReQZOPGmRvstkgfi4s5rLxqmEiP6t5OKNoiB1PnZqddT6s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:d51d79ba-4380-4009-ae11-0a62a67c2685,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:96415613-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 112aa09646de11eeb20a276fd37b9834-20230830
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1679817134; Wed, 30 Aug 2023 10:36:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 30 Aug 2023 10:36:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 30 Aug 2023 10:36:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvZ+gyHfbaMJ/KStNTrNgmbnzHbVDjFnqdTSImnmlOoAQr9u7A2Lx/Do06XfZ3y5WpN8WUiFO+WSy9I/sFZNmk96JymCqXZtU1nAH+/2ZptiKn1oProc0Ud75Tw7uOMpWH6+Cc8hPXE+Bgn78C7X9QBZ5gvPwNTiOyPtt7C1LcO/5YBX3f09UvpSqHOQl2Xa/Pbpemf6Vyh02DjSJsDsVNktU8dE+0NjmWXXPI8/HczT2e5tHPD64lYTKYxQEQVXeTcE/SqLCqxF9DuxOAaLccTffdLbbnQXQ2Yc9hFTDIiMi0c1b0KRT+L91XiWQmR9RIMQ2qmUeW4Xox2hM/FKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daKvlSztN9gWUbn4hEBeWRkhRvb2mM4oTQf//jh7i5A=;
 b=KYetsy1iWrN5Gp4eyslslUFfKEXONpLhBrpl+Slnc5QY3iG9x4DoyR9drylApI4fnBnEYPRH6uLM9Ows6P/L60eGxsq1xEEcD+CJMP2HziqiYqPC0DfDfJ7UsJz1xHxeEbvxP8OmBrMiITIdQV/ED4ybUzOk+h1rMcEtTgPesM+RyBgLs/75yvwr8TNHlffrrIODxE+PAo841pdtiWU8QiWGWw9fib2gN6n0iKRHrlTmMBcd+AgzauJVK8T2C2DMyYXBfri04kfDDqjgJVSxK2HNIvVAPA+dy50qSJPO40TZoCcGx4+YfK9GfkNbibAjxtEgluzbXf2wp2+x7zIZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daKvlSztN9gWUbn4hEBeWRkhRvb2mM4oTQf//jh7i5A=;
 b=Rb9ITRjozfjAyk4erTmGPOGc/BlUqD/OwoAJH2bFsH9lpifjFtvMJFwMbmGEZOED0aG8pizICI2gt9lURE7axX7u2MYg/LrrybC/VKooW2auqRCwKzJeE5FXPOT/uwD6/7KpA1fDuIxtDK4Yp3lfaBkRIE3BsfbAw6YiVaf1D1k=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by TYZPR03MB5391.apcprd03.prod.outlook.com (2603:1096:400:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 02:36:38 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::b6ae:482a:3913:2a8b]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::b6ae:482a:3913:2a8b%7]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 02:36:38 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v16 08/14] remoteproc: mediatek: Probe SCP cluster on
 multi-core SCP
Thread-Topic: [PATCH v16 08/14] remoteproc: mediatek: Probe SCP cluster on
 multi-core SCP
Thread-Index: AQHZwPzfA0+mOQOixkOGHD+Ys/vp1rAAMNyAgAIiwQA=
Date:   Wed, 30 Aug 2023 02:36:37 +0000
Message-ID: <060bd5a5de40c5a6feda867959bedf8cf78007d8.camel@mediatek.com>
References: <20230728023959.12293-1-tinghan.shen@mediatek.com>
         <20230728023959.12293-9-tinghan.shen@mediatek.com> <ZOzgja8mfNefRqP7@p14s>
In-Reply-To: <ZOzgja8mfNefRqP7@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|TYZPR03MB5391:EE_
x-ms-office365-filtering-correlation-id: 9e16b55b-2f2a-4b1d-587d-08dba901ef6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BIwCAeLoOz99AZ3E7G+2TkFzPpJbdIt3+whhWn9n9aZjHeecA4dqVjF71rEhQ8zf4ROejVfg9V4k/LiDOg3SjOhqqzQI3UaAuoma3/3EQOiu3+zDgOqQpG3pEED1DFieQogUWvHgDUwbDX0eL+PoCb/Je0c4bucU8piSZjs1Jio2SISn5Oh3kZblAQN01S44IpQ9RJMbgV6RrwPfGtb7wqh3n77/hff500TQBP2weSvuYHEiLknPPaWNDAl7PgXAnA4pO1FU55KUb7mg2H5M5PFFY0PRryCrHs44mBidUA1qJMVo3RqvtiNLut16c3rV7cdFalZBQPKcF0qbxzmqg5K/BXVwKEAK3YHQ11g22YmzXLX8dkqm8/NgFsPRqvAdjf2fZB/Ojp8WWfDoJrLLo/SmbkOKTEbiBbNmI4/hvH3dZVAvy9d6A/LFrpgZd47wMbmi+c30nJwhgW7tsGPNkwmI3NeIGvtd0Rz08VUauEzropcKx6fOeVBMm3JPsZ2In8q1i3I0hxLttHjZrhWASc+qB4Br0/kg8zge2XO1LIHg9EEVrqt1ZKdu5/ZXEwsl6EwMqckon8StM/QFhaa0B8JqOHSnuQQfRBYVt9ikXexoDHuVdV+Rsuj9sOruYjk3bDOpzB34zP2b28hc3+bAXpYc3tHS0epdofYQOyeBaTB5QnYsLobkGboHX5A/9IqqUVEb/iI6kAj5vBnUz/PqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199024)(1800799009)(186009)(8936002)(6486002)(6506007)(71200400001)(6512007)(478600001)(83380400001)(76116006)(26005)(91956017)(7416002)(66446008)(2616005)(64756008)(6916009)(316002)(54906003)(66946007)(8676002)(66556008)(4326008)(5660300002)(41300700001)(66476007)(2906002)(85182001)(36756003)(86362001)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzBXQ0tiYmM2V2VlUFhVdEdxZ04xcTZHN0huM08xUzNjUnRpVm5NQWIzdFhI?=
 =?utf-8?B?S3QzeUMyM3RtVjlGdG5UK0x5KzIvQTJjaW4vZEhnUDZYZ3ZrOVY5QWsxVnNV?=
 =?utf-8?B?T0pETWJVcGhaeC9peWhVR3J1OWlJeDhWc0RhZExOaVE0OUFucjVlb1FTaytH?=
 =?utf-8?B?emlabThwL1ZMa0Q4eUlPZlU1cXJ1NGFtcUNjWjBxdUtVbTl5RGo3MW9RRmJ6?=
 =?utf-8?B?cFFteTVQak1FQ21ldTIxaDNIaFFHUnZiVEQ4TnJhRFRDVkZXRVBZN1JpVGFr?=
 =?utf-8?B?a1dISmx0cVIzVnNJaFBETzlJd0x3dzFVQS9Rek5GS09USjhvMnZrbXRWSW10?=
 =?utf-8?B?STJOaUI5TWJBMWZ2dDE4a2U5OXpQQVR4VHdsd0FaUE5ZMUd0TS9Fb1FRMVNX?=
 =?utf-8?B?enpmaGk4Z3hpQk15OCtFY21ESURORzNVV1pBa3VYTlQxUHN5UjM3K2hINUFT?=
 =?utf-8?B?R3AxL1hyMngxdjJBSjhaSkRDUmk2MUhmdUd6NGR5MnNVQ2EvWFkxR3NPUDlT?=
 =?utf-8?B?bFpGTHAzQ09iKzY3QktWa0ZSYS9DQk5wS1VTanljVURjRlUxTmNoVTlrZlRO?=
 =?utf-8?B?V2w5RkxjOVJUc2VqbDFRWnV3UVJBNG1KMXNIUE5VYWdGZTduTjkvcWxQVE9Z?=
 =?utf-8?B?MDVJSWlTbWQ2VzRkNXpyRktPK1NYVHJpZmNCeE9LMTRrWnEzQ3lYYVZHdjAr?=
 =?utf-8?B?VkpZRDZ2OURzRHdraXowdlM5aXRCYXVxTGZUSlVOZmszQjBBektZc2NwVGIz?=
 =?utf-8?B?Q3crVFk5cHR6UmFRK0JqeTFreE54ZnNMOVI0clpGQ0NmZ2laODA3TzNCSng2?=
 =?utf-8?B?blM4NXErdnlXdVRXNDNoMnozMUFLUVhBZmg3bjhrVXgyczM3dW00ZXdoazkx?=
 =?utf-8?B?N3NwVy9YK1VIcVdoT2JLbjNIOS9QVCtZOGRyN01FK1UwbUdNdmVVa2FmSGh2?=
 =?utf-8?B?bTUxWDFlVmdNbVNiMVpaR0ljc2x2MU9hTzYrOUxWc2xXWG40V2RsKzBiWHBC?=
 =?utf-8?B?M0lobUtpVXo5OGpWTlFSZWI1ZEU2eG4yZHRqVjlhVUNocXNBUjBwcmRPWndS?=
 =?utf-8?B?RVZLckg3RGdCUXY2QVc1VnltNS9lUWpZMWNBWmk3NmJxZGJOcjRpaVFnY1Js?=
 =?utf-8?B?K2xjbWVYM09xWDdscDZKUXNEZVFRb0kzdTd2MHUweEtLUDFydWZWeHovYXh3?=
 =?utf-8?B?cmRIbURLTHNQdHovY3cwU1F4SlN3U1drd1NldkJMR2w2N05IUFJCaElzSEVU?=
 =?utf-8?B?V1lLMkd2cUNVM0cwMU16cm9lR0NDTVQzdUFwU0ZCWC9wNDJwM2VHdTBhM2wz?=
 =?utf-8?B?cUlwVkhUWmpWL1VYNjc1VnA5UlhpaTJBSFZSem9sZS9HSU1IV0pUQy81Z1pT?=
 =?utf-8?B?WmFmVlQwRytOTHdrVGVFdldiUGNZVzZSamovdnE5dzRBSW91bWxGV1FVaVZo?=
 =?utf-8?B?d0MzaC8rdytUZFpBRi90ak4zRFVka3YwaUkzb0NjRGtnVmFiaUZ1SE1IN2Vk?=
 =?utf-8?B?eFE2bjB5ZFpJRjNzWW03N0paRjlKUWtHM2V3c1Ixa1hNOTVpc1crT1BDRU1l?=
 =?utf-8?B?aDk4ZWhudGNkQmpYZkFoZ3dKN3pMYkRyQ0lPTHAvZjJsSHIvd2ptUmpJcHl1?=
 =?utf-8?B?ckVjVERwZXRBKzlqbUJWQUtMTDBPMTA0ZmxNUEFOZ1RtMjlHbGZDbHlyZnA0?=
 =?utf-8?B?VVY0TXhjNGMvKytvU2duOUZZd0RzM0lSNUJWT2lVN08vcTYvV2wxdDBDR1Yx?=
 =?utf-8?B?WWJraXNweGZoN0ZuQk5YTWFoVVFuYmVhaGwzbXNHTVJERnhPeVpIbmlnUGN0?=
 =?utf-8?B?dHpEVWxzR1lJcHpmRDAxbHRYVG4yTUgzVTg4dm9YdXhkUGZvdWlib1V4a21K?=
 =?utf-8?B?V2J4SjJvbkU4VkZ3eTZTalZBQ3k4VkdPOCs0UkdUS3pnNFM5cnVyaGJvSnBQ?=
 =?utf-8?B?TTI1aWRuMEo0YVVsSytwV0hZUHpENWtlRXBGMmNKSkVnWDFYL1Q4UC9PU2Jq?=
 =?utf-8?B?M243a3dpUy9zVHM0SXBSV1ArTGdMLzQzUjlWTFo4REc3SzZEd0k5ck02V2JN?=
 =?utf-8?B?bm1KZXZGQk1FbUdNcmlvWmRGK3MxeU8xbEF6cTZSbzhQckZrN2draVhSRFVo?=
 =?utf-8?B?b0JWWUhoaVFjY2ZPVnprWWNhblFtbW1TT2s3ekpxdStHekRZd05LalBuMXAx?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E4E5A9A5526AF48B4C25D6A967FB9EE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e16b55b-2f2a-4b1d-587d-08dba901ef6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 02:36:37.9495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMWGoJbjKR9CsMCZE2KpNSnPrJatzD5ezjdcdmbmepiln5lBgHb6sLZqpQz8g1tIPcL4qMSXu++wOkitW8Ap4mcULKbWB6JMaQchqoD5EvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5391
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldSwNCg0KT24gTW9uLCAyMDIzLTA4LTI4IGF0IDExOjU5IC0wNjAwLCBNYXRoaWV1
IFBvaXJpZXIgd3JvdGU6DQo+IEhpIFRpbmdoYW4sDQo+IA0KPiBPbiBGcmksIEp1bCAyOCwgMjAy
MyBhdCAxMDozOTo1M0FNICswODAwLCBUaW5naGFuIFNoZW4gd3JvdGU6DQo+ID4gVGhlIGRpZmZl
cmVuY2Ugb2Ygc2luZ2xlLWNvcmUgU0NQIGFuZCBtdWx0aS1jb3JlIFNDUCBkZXZpY2UgdHJlZSBp
cw0KPiA+IHRoZSBwcmVzZW5jZSBvZiBjaGlsZCBkZXZpY2Ugbm9kZXMgZGVzY3JpYmVkIFNDUCBj
b3Jlcy4gVGhlIFNDUA0KPiA+IGRyaXZlciBwb3B1bGF0ZXMgdGhlIHBsYXRmb3JtIGRldmljZSBh
bmQgY2hlY2tzIHRoZSBjaGlsZCBub2Rlcw0KPiA+IHRvIGlkZW50aWZ5IHdoZXRoZXIgaXQncyBh
IHNpbmdsZS1jb3JlIFNDUCBvciBhIG11bHRpLWNvcmUgU0NQLg0KPiA+IA0KPiA+IEFkZCB0aGUg
cmVtb3RlcHJvYyBpbnN0YW5jZXMgb2YgbXVsdGktY29yZSBTQ1AgdG8gdGhlIFNDUCBjbHVzdGVy
IGxpc3QuDQo+ID4gV2hlbiB0aGUgU0NQIGRyaXZlciBpcyByZW1vdmVkLCBpdCBjbGVhbnVwIHJl
c291cmNlcyBieSB3YWxraW5nDQo+ID4gdGhyb3VnaCB0aGUgY2x1c3RlciBsaXN0Lg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFRpbmdoYW4gU2hlbiA8dGluZ2hhbi5zaGVuQG1lZGlhdGVrLmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dp
b2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9y
ZW1vdGVwcm9jL210a19zY3AuYyB8IDExOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfc2NwLmMg
Yi9kcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jDQo+ID4gaW5kZXggZDY3ZGNhYmRhYjllLi5k
OTI0MmMzZWIwZDcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9yZW1vdGVwcm9jL210a19zY3Au
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfc2NwLmMNCj4gPiBAQCAtODU1LDcg
Kzg1NSw4IEBAIHN0YXRpYyB2b2lkIHNjcF9yZW1vdmVfcnBtc2dfc3ViZGV2KHN0cnVjdCBtdGtf
c2NwICpzY3ApDQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBzdHJ1Y3QgbXRrX3NjcCAqc2Nw
X3Jwcm9jX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gPiAtCQkJCSAgICAg
IHN0cnVjdCBtdGtfc2NwX29mX2NsdXN0ZXIgKnNjcF9jbHVzdGVyKQ0KPiA+ICsJCQkJICAgICAg
c3RydWN0IG10a19zY3Bfb2ZfY2x1c3RlciAqc2NwX2NsdXN0ZXIsDQo+ID4gKwkJCQkgICAgICBj
b25zdCBzdHJ1Y3QgbXRrX3NjcF9vZl9kYXRhICpvZl9kYXRhKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICAJc3RydWN0IGRldmljZV9ub2RlICpu
cCA9IGRldi0+b2Zfbm9kZTsNCj4gPiBAQCAtODc4LDcgKzg3OSw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
bXRrX3NjcCAqc2NwX3Jwcm9jX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4g
PiAgCXNjcCA9IHJwcm9jLT5wcml2Ow0KPiA+ICAJc2NwLT5ycHJvYyA9IHJwcm9jOw0KPiA+ICAJ
c2NwLT5kZXYgPSBkZXY7DQo+ID4gLQlzY3AtPmRhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2Rh
dGEoZGV2KTsNCj4gPiArCXNjcC0+ZGF0YSA9IG9mX2RhdGE7DQo+ID4gIAlzY3AtPmNsdXN0ZXIg
PSBzY3BfY2x1c3RlcjsNCj4gPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHNjcCk7DQo+
ID4gIA0KPiA+IEBAIC05NTEsMTUgKzk1MiwxNSBAQCBzdGF0aWMgdm9pZCBzY3BfZnJlZShzdHJ1
Y3QgbXRrX3NjcCAqc2NwKQ0KPiA+ICAJbXV0ZXhfZGVzdHJveSgmc2NwLT5zZW5kX2xvY2spOw0K
PiA+ICB9DQo+ID4gIA0KPiA+IC1zdGF0aWMgaW50IHNjcF9jbHVzdGVyX2luaXQoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldiwNCj4gPiAtCQkJICAgIHN0cnVjdCBtdGtfc2NwX29mX2NsdXN0
ZXIgKnNjcF9jbHVzdGVyKQ0KPiA+ICtzdGF0aWMgaW50IHNjcF9hZGRfc2luZ2xlX2NvcmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gPiArCQkJICAgICAgIHN0cnVjdCBtdGtfc2Nw
X29mX2NsdXN0ZXIgKnNjcF9jbHVzdGVyKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICAJc3RydWN0IGxpc3RfaGVhZCAqc2NwX2xpc3QgPSAmc2Nw
X2NsdXN0ZXItPm10a19zY3BfbGlzdDsNCj4gPiAgCXN0cnVjdCBtdGtfc2NwICpzY3A7DQo+ID4g
IAlpbnQgcmV0Ow0KPiA+ICANCj4gPiAtCXNjcCA9IHNjcF9ycHJvY19pbml0KHBkZXYsIHNjcF9j
bHVzdGVyKTsNCj4gPiArCXNjcCA9IHNjcF9ycHJvY19pbml0KHBkZXYsIHNjcF9jbHVzdGVyLCBv
Zl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KSk7DQo+ID4gIAlpZiAoSVNfRVJSKHNjcCkpDQo+
ID4gIAkJcmV0dXJuIFBUUl9FUlIoc2NwKTsNCj4gPiAgDQo+ID4gQEAgLTk3NSw2ICs5NzYsMTAy
IEBAIHN0YXRpYyBpbnQgc2NwX2NsdXN0ZXJfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2LA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3N0YXRpYyBpbnQgc2Nw
X2FkZF9tdWx0aV9jb3JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ID4gKwkJCSAg
ICAgIHN0cnVjdCBtdGtfc2NwX29mX2NsdXN0ZXIgKnNjcF9jbHVzdGVyKQ0KPiA+ICt7DQo+ID4g
KwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsJc3RydWN0IGRldmljZV9u
b2RlICpucCA9IGRldl9vZl9ub2RlKGRldik7DQo+ID4gKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpjcGRldjsNCj4gPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqY2hpbGQ7DQo+ID4gKwlzdHJ1Y3Qg
bGlzdF9oZWFkICpzY3BfbGlzdCA9ICZzY3BfY2x1c3Rlci0+bXRrX3NjcF9saXN0Ow0KPiA+ICsJ
Y29uc3Qgc3RydWN0IG10a19zY3Bfb2ZfZGF0YSAqKmNsdXN0ZXJfb2ZfZGF0YTsNCj4gPiArCXN0
cnVjdCBtdGtfc2NwICpzY3AsICp0ZW1wOw0KPiA+ICsJaW50IGNvcmVfaWQgPSAwOw0KPiA+ICsJ
aW50IHJldDsNCj4gPiArDQo+ID4gKwljbHVzdGVyX29mX2RhdGEgPSAoY29uc3Qgc3RydWN0IG10
a19zY3Bfb2ZfZGF0YSAqKilvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gPiArDQo+
ID4gKwlmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zfbm9kZShucCwgY2hpbGQpIHsNCj4gPiAr
CQlpZiAoIWNsdXN0ZXJfb2ZfZGF0YVtjb3JlX2lkXSkgew0KPiA+ICsJCQlyZXQgPSAtRUlOVkFM
Ow0KPiA+ICsJCQlkZXZfZXJyKGRldiwgIk5vdCBzdXBwb3J0IGNvcmUgJWRcbiIsIGNvcmVfaWQp
Ow0KPiA+ICsJCQlvZl9ub2RlX3B1dChjaGlsZCk7DQo+ID4gKwkJCWdvdG8gaW5pdF9mYWlsOw0K
PiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJY3BkZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKGNo
aWxkKTsNCj4gPiArCQlpZiAoIWNwZGV2KSB7DQo+ID4gKwkJCXJldCA9IC1FTk9ERVY7DQo+ID4g
KwkJCWRldl9lcnIoZGV2LCAiTm90IGZvdW5kIHBsYXRmb3JtIGRldmljZSBmb3IgY29yZSAlZFxu
IiwgY29yZV9pZCk7DQo+ID4gKwkJCW9mX25vZGVfcHV0KGNoaWxkKTsNCj4gPiArCQkJZ290byBp
bml0X2ZhaWw7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlzY3AgPSBzY3BfcnByb2NfaW5pdChj
cGRldiwgc2NwX2NsdXN0ZXIsIGNsdXN0ZXJfb2ZfZGF0YVtjb3JlX2lkXSk7DQo+ID4gKwkJcHV0
X2RldmljZSgmY3BkZXYtPmRldik7DQo+ID4gKwkJaWYgKElTX0VSUihzY3ApKSB7DQo+ID4gKwkJ
CXJldCA9IFBUUl9FUlIoc2NwKTsNCj4gPiArCQkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gaW5p
dGlhbGl6ZSBjb3JlICVkIHJwcm9jXG4iLCBjb3JlX2lkKTsNCj4gPiArCQkJb2Zfbm9kZV9wdXQo
Y2hpbGQpOw0KPiA+ICsJCQlnb3RvIGluaXRfZmFpbDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJ
CXJldCA9IHJwcm9jX2FkZChzY3AtPnJwcm9jKTsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4gKwkJ
CWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFkZCBycHJvYyBvZiBjb3JlICVkXG4iLCBjb3JlX2lk
KTsNCj4gPiArCQkJb2Zfbm9kZV9wdXQoY2hpbGQpOw0KPiA+ICsJCQlzY3BfZnJlZShzY3ApOw0K
PiA+ICsJCQlnb3RvIGluaXRfZmFpbDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCWxpc3RfYWRk
X3RhaWwoJnNjcC0+ZWxlbSwgc2NwX2xpc3QpOw0KPiA+ICsJCWNvcmVfaWQrKzsNCj4gPiArCX0N
Cj4gPiArDQo+ID4gKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBzY3ApOw0KPiA+ICsNCj4g
DQo+IEhlcmUgd2UgYXJlIHNldHRpbmcgdGhlIHBsYXRmb3JtIGRldmljZSBmb3IgQHBkZXYgdG8g
dGhlIGxhc3QgQHNjcCB0aGF0IHdhcw0KPiBjcmVhdGVkLCB3aGljaCBpcyBuZWVkZWQgYmVjYXVz
ZSAoMSkgc2NwX3Jwcm9jX2luaXQoKSBpcyBjYWxsaW5nDQo+IHBsYXRmb3JtX3NldF9kcnZkYXRh
KCkgb24gdGhlIGNoaWxkIHBsYXRmb3JtIGRldmljZXMgYW5kICgyKSB3ZSBuZWVkIGEgaGFuZGxl
IHRvDQo+IHRoZSBjbHVzdGVyIGxpc3QgaW4gc2NwX3JlbW92ZSgpLg0KPiANCj4gUGxlYXNlIGFk
ZCBhIGNvbW1lbnQgd2l0aCB0aGUgYWJvdmUganVzdCBiZWZvcmUgY2FsbGluZyBwbGF0Zm9ybV9z
ZXRfZHJ2ZGF0YSgpLg0KPiBPdGhlcndpc2UgaXQgd2lsbCBiZSB2ZXJ5IGRpZmZpY3VsdCBmb3Ig
cGVvcGxlIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBkcml2ZXIgdG8NCj4gdW5kZXJzdGFuZCB3aGF0
IGlzIGdvaW5nIG9uLg0KPiANCj4gT3RoZXJ3aXNlIEkgdGhpbmsgd2UgYXJlIGRvbmUuDQo+IA0K
PiBUaGFua3MsDQo+IE1hdGhpZXUNCg0KT2ssIEknbGwgYWRkIHRoZSBjb21tZW50IGF0IG5leHQg
dmVyc2lvbi4NCg0KSSB3b3VsZCBsaWtlIHRvIGV4cHJlc3MgbXkgc2luY2VyZSBncmF0aXR1ZGUg
Zm9yIHlvdXIgcmV2aWV3DQpjb21tZW50cyB0byBtYWtlIHRoaXMgc2VyaWVzIGJldHRlci4gSSB0
cnVseSBhcHByZWNpYXRlIHRoZQ0KdGltZSBhbmQgZWZmb3J0IHlvdSBoYXZlIGRlZGljYXRlZCB0
byBwcm92aWRpbmcgZmVlZGJhY2suDQpUaGFuayB5b3Ugc28gbXVjaC4NCg0KQmVzdCByZWdhcmRz
LA0KVGluZ0hhbg0KDQo+IA0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICtpbml0X2ZhaWw6
DQo+ID4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmVfcmV2ZXJzZShzY3AsIHRlbXAsIHNjcF9s
aXN0LCBlbGVtKSB7DQo+ID4gKwkJbGlzdF9kZWwoJnNjcC0+ZWxlbSk7DQo+ID4gKwkJcnByb2Nf
ZGVsKHNjcC0+cnByb2MpOw0KPiA+ICsJCXNjcF9mcmVlKHNjcCk7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBzY3BfaXNf
c2luZ2xlX2NvcmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArew0KPiA+ICsJ
c3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiArCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbnAgPSBkZXZfb2Zfbm9kZShkZXYpOw0KPiA+ICsJc3RydWN0IGRldmljZV9ub2RlICpjaGls
ZDsNCj4gPiArDQo+ID4gKwljaGlsZCA9IG9mX2dldF9uZXh0X2F2YWlsYWJsZV9jaGlsZChucCwg
TlVMTCk7DQo+ID4gKwlpZiAoIWNoaWxkKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRl
diwgLUVOT0RFViwgIk5vIGNoaWxkIG5vZGVcbiIpOw0KPiA+ICsNCj4gPiArCW9mX25vZGVfcHV0
KGNoaWxkKTsNCj4gPiArCXJldHVybiBvZl9ub2RlX25hbWVfZXEoY2hpbGQsICJjcm9zLWVjLXJw
bXNnIik7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgc2NwX2NsdXN0ZXJfaW5pdChz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBzdHJ1Y3QgbXRrX3NjcF9vZl9jbHVzdGVyICpz
Y3BfY2x1c3RlcikNCj4gPiArew0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSBz
Y3BfaXNfc2luZ2xlX2NvcmUocGRldik7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ICsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0ID0gc2NwX2FkZF9zaW5n
bGVfY29yZShwZGV2LCBzY3BfY2x1c3Rlcik7DQo+ID4gKwllbHNlDQo+ID4gKwkJcmV0ID0gc2Nw
X2FkZF9tdWx0aV9jb3JlKHBkZXYsIHNjcF9jbHVzdGVyKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
cmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IHNjcF9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAm
cGRldi0+ZGV2Ow0KPiA+IEBAIC0xMDA3LDYgKzExMDQsMTAgQEAgc3RhdGljIGludCBzY3BfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgDQo+ID4gIAlJTklUX0xJU1Rf
SEVBRCgmc2NwX2NsdXN0ZXItPm10a19zY3BfbGlzdCk7DQo+ID4gIA0KPiA+ICsJcmV0ID0gZGV2
bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZShkZXYpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1
cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBwb3B1bGF0ZSBwbGF0Zm9ybSBk
ZXZpY2VzXG4iKTsNCj4gPiArDQo+ID4gIAlyZXQgPSBzY3BfY2x1c3Rlcl9pbml0KHBkZXYsIHNj
cF9jbHVzdGVyKTsNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiBAQCAt
MTEwMSwxMiArMTIwMiwxOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zY3Bfb2ZfZGF0YSBt
dDgxOTVfb2ZfZGF0YV9jMSA9IHsNCj4gPiAgCS5ob3N0X3RvX3NjcF9pbnRfYml0ID0gTVQ4MTk1
X0NPUkUxX0hPU1RfSVBDX0lOVF9CSVQsDQo+ID4gIH07DQo+ID4gIA0KPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19zY3Bfb2ZfZGF0YSAqbXQ4MTk1X29mX2RhdGFfY29yZXNbXSA9IHsNCj4g
PiArCSZtdDgxOTVfb2ZfZGF0YSwNCj4gPiArCSZtdDgxOTVfb2ZfZGF0YV9jMSwNCj4gPiArCU5V
TEwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
IG10a19zY3Bfb2ZfbWF0Y2hbXSA9IHsNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTgzLXNjcCIsIC5kYXRhID0gJm10ODE4M19vZl9kYXRhIH0sDQo+ID4gIAl7IC5jb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE4Ni1zY3AiLCAuZGF0YSA9ICZtdDgxODZfb2ZfZGF0YSB9LA0K
PiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtc2NwIiwgLmRhdGEgPSAmbXQ4
MTg4X29mX2RhdGEgfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLXNj
cCIsIC5kYXRhID0gJm10ODE5Ml9vZl9kYXRhIH0sDQo+ID4gIAl7IC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE5NS1zY3AiLCAuZGF0YSA9ICZtdDgxOTVfb2ZfZGF0YSB9LA0KPiA+ICsJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtc2NwLWR1YWwiLCAuZGF0YSA9ICZtdDgxOTVf
b2ZfZGF0YV9jb3JlcyB9LA0KPiA+ICAJe30sDQo+ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0Vf
VEFCTEUob2YsIG10a19zY3Bfb2ZfbWF0Y2gpOw0KPiA+IC0tIA0KPiA+IDIuMTguMA0KDQo=
