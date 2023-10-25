Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98937D6041
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjJYDIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJYDIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:08:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B59F12A;
        Tue, 24 Oct 2023 20:08:34 -0700 (PDT)
X-UUID: c5f18f0472e311eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Up6FEnUF3dvtNO5W1GIqfXhmQkE6O9h8odqMrhiDCj8=;
        b=Y5im22PyOfgDiFTIhR/tV/QuDUdli5n9jXl6z9PigJTd4HbUR1fkN/YpM1MUtUOGdOi7Tu4RdjdfVTwksOF2NkGwgF4UjffoJzdLZS935hwG0NN7GsTZpDUSKJNrmKXZ2r/syouLgMj0zepm3aa37Ud0f0cmPtQXIW+hXucHaQI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:567054b8-ba44-4688-9dd0-1079bed9e315,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:a36d9994-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c5f18f0472e311eea33bb35ae8d461a2-20231025
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 314639454; Wed, 25 Oct 2023 11:08:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 11:08:28 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 11:08:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqcpmM4m4ZV/5DwYObMQ7e4nq5idOCTPTBoPqCYMpvR7m9iiJvVegCq9lVP8C1uUEMw0v6ZoDjywnbkbp0fa8K7xE4rgUP24fu3Fp9vbFer98/iPQqL6brdg594m13sGjsKrpz5vxPp4sjfyx+Xc2mkv4cUa5nzzb79w3ZG8UmywxjJFw/qeJ7gNAwJwoCa1yV7aR/GtwaENolsvjoeTm4hXkVZulFinx5TId2kkbF3lroeC9yQesNuHpJe9wb/IXkrFct9RtUl653f0RWBSvBVba+9u5MrG+ILtLuWZ/inbZ5IAP+LG4lpIQEqZmxUpoRTEpO8UIGKTzOQfJbJO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up6FEnUF3dvtNO5W1GIqfXhmQkE6O9h8odqMrhiDCj8=;
 b=Fbr7Rohr0zO6EqxT92Uhmw17BJLwIe+fvL6rrE1kM6YhFmHQsizZPmiajxe4i6bRdXonrSAiu6lHC7zhpjaNjJmsGtD8xzYHcnu9q/O+5P82kdYMftbp38u8vj54V41DHqtFfG9tSFOXlotZXEu28ezoP591lfA9CbtcqsrCQRSZXkW6BNHBJgi3mDy9lq8JGknf8gjyYuOrVJBL7fPlX92l+spu1YvrlSo+3ichh6aqh0CzYxlwxStP3lYCukRMyA/Ul/WntrChEcjyKLYq7RUJCmLNt5SE4ifxCc6MlGzZYCwTecfA1zIGKv1WKvuGD0U38ABGNyzwebbR6HOyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up6FEnUF3dvtNO5W1GIqfXhmQkE6O9h8odqMrhiDCj8=;
 b=Jhw0Svz0MnaJoKFxUOyquGbHS9I+2TGP7q7khZl794nyLt6K4gHzBoBBQC+0ip4oVJ9LmYs0H2SOPwTJS7RvN8uz6b4Dsm0Eav+rO++hwAMt+o4yn4BqcwlSH1/Q+azXrl3NOFM+LdHU3HmYMUVG/an/AJ5R+delROXjXVKPyew=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6055.apcprd03.prod.outlook.com (2603:1096:4:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 03:08:26 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3%4]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 03:08:25 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Topic: [PATCH v2 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Index: AQHaBWwJYGbjWCm+FECrWQohGGln37BZ1jGA
Date:   Wed, 25 Oct 2023 03:08:25 +0000
Message-ID: <5d688b197946656bcfac74e8a6f0325a738260c4.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-8-jason-jh.lin@mediatek.com>
In-Reply-To: <20231023044549.21412-8-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6055:EE_
x-ms-office365-filtering-correlation-id: fa10d2b8-8bf0-4174-3316-08dbd507a7b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UwomYv2CuTW47KZrZMuKqZzajx6JZMRm3FjtucyhDL66B+Vj32X7HRYgtxQWWeiPbwYQ4ak2MYBv/Lplrw4X2c19MN6s25+UQVHMF/+qUORDGrws0AZ8vtrlL48jbbNt94uyaVcb+Z8tVPQ9GqnUwselgMfSoC8Bh5n4hTQHaQasfnONVAvw0Sim5xs2MnuEZ/xJMkOTy9LocIOJiJuJ8Js5wuyCt0ooYT133J6JHHEzPK33wHj1okI6dDj0tVonH+sCq0FuvrzqyXrg4KS3iSZHLtpdO0UAyOJdMUAjhNYTFGmqUOXjlAusS4siEX+GepLTvDo6R310AECzpJBaIx9TkfGhqtZPOm10M8hWl4Kqv4LG32F26ESHJOTEWI48RoJXuj7EQ0uhC4h9V1z2rkBHYk1Dm2CxpmAxx9yX0e++zUCuD3o1LY5i7NoV2N4IaRjev5C9lzQ6vuoxXHg3K0GK4QqxLr/+7aZvSSKI3TJdQqrR7o8o518Ru7piGPkrvgtfTl4d+P9IfFJHdiVN7J2H90iWSZJCR1WfGhmROZEjdGtzT5OGLtncj9vnO+iz2MRJgyAWPtOMZXhUPUSoHz7wZEdG/kLDqOPRqISncoarMeuYQqp5JMWpXg4BHoJ50deVJxWdPrDQ/qAJ3RFVYZnSVf9XC5tZN3/PEHghLMs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(83380400001)(4001150100001)(2906002)(26005)(8936002)(8676002)(4326008)(71200400001)(86362001)(41300700001)(76116006)(38100700002)(54906003)(66446008)(66476007)(66556008)(66946007)(64756008)(316002)(110136005)(122000001)(478600001)(6486002)(38070700009)(5660300002)(36756003)(7416002)(2616005)(85182001)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE1IclhUK2l0dWdyY0dZMno2b0ZLMXRndXJNVENKZjdiRnNIclZmd0M0ZHlT?=
 =?utf-8?B?UUUrMTczallxWW5KajUzMWE3d1d5NzF4MEFNOFBYOE1zUTl2N3c4eVpQM0Q3?=
 =?utf-8?B?RHVjQ1FQUmZwZGk3cFJEdTArMm5vM2hqaEkvM3d1NzZNVDlVVyt4cmZhTHNN?=
 =?utf-8?B?VWo0cjNlcVVOWHhvOUdKUi9BelpDVUlQRE9yOUx6NkQ5TXFRc2w0bXNBQUdh?=
 =?utf-8?B?UEFEN2VyblgwUjZBNHZJSDVoWXAzUjV2alZvZFlVSGNvRUhTUUkrSjcvRGl3?=
 =?utf-8?B?eEw4SHVhMEMzWnRqZFhDYWl4eEhkRjl5VVJrSmVFSHNrTnhSOGpsQVFWRW84?=
 =?utf-8?B?dnFpNjUweHdEOG93NW5zQk1EUGZXQUh0Sm1zVkt6by9tOGx4NTYwS1FsVHdD?=
 =?utf-8?B?OTJxczBQNGluaU13TGQxdVhBUlpRejNvaWU3WkxVSkVtaHNXRjlSaUZBbGp3?=
 =?utf-8?B?dnhGVklCT05jVWJhOWhlZFVsRVlxeERqRHBuUFRDTDE4SG1kN0gzUVdMWU9j?=
 =?utf-8?B?aTM4N2gvZStVQmFsc0dCZkI2N3c1RGhxWkFLZFJMYWpvSDBFUFVmSFFmV1Yr?=
 =?utf-8?B?Sk13Z1ZlSzFxOW9CTFY0K0hTNWRDcHpIUmx3K1ZTTVJBdzNJWjFrK1NOcnZX?=
 =?utf-8?B?RkVDeGdHbGxXY3RUckI0ZE81V0U0YTFFTWhnL21aUS9JQS8rSTRTMTJCckpD?=
 =?utf-8?B?Y1Z5SWV5Yll4VlVsai9pTFNPbytSWUJhVEg4dDBlU0tZcmgycDBkMUZtSlNX?=
 =?utf-8?B?UWVjaE5nRDRIZVhvYjFVc0M4ZEYvVjRFMGIzU0U3T1VnWXRNeUtWL1hFcHpD?=
 =?utf-8?B?aSswTk13SzgzalZiQzVvYmpFTVczN2JpamtLZTArV28wNXZoZmc2dU16ZXRW?=
 =?utf-8?B?M2J5SHIvT25hNExJdDZQVXlWclNwc0Q4bEhVcWoyOCtidGoxU251TG9xMDh3?=
 =?utf-8?B?VkVReWlwZFMxaWRmTkU2cE84cm05YU83TEkvNmhhVlk5Q3d0TGViQ055REdo?=
 =?utf-8?B?N3VLRHh3cmhySnF6WVdEQldYdkorWnZacVBEWTM4K2d2NVo4U2p0NDhaN1hv?=
 =?utf-8?B?RkhIaEVVTS9ZTUlHUGJaT2ppQjBLbHNLWHBrZ0J2SUxUMUd2N3NidXFOUjd0?=
 =?utf-8?B?dC9iVkNub1JwVjhnaWtCWXR4RU1oMVIxQnRRSVB5ZHhSNlprd3cvOGcrV2o1?=
 =?utf-8?B?Uk16a1Z0TmNFV256a3F6R1FaMi9NWURGdWtrdm1yRTNDMks4UnJCWmtBQVpY?=
 =?utf-8?B?SWoxbW9hNldhMWxXSjFxVjdZZThHd1hDc05Ick9oSzhLZVNDNG1SMDVJVFAw?=
 =?utf-8?B?VXVINm5pRTA1VnZ4RlRWaUZ1dkxBZ1VyYlpJTUxKQUxJNGpLeVZmRXlPZkwx?=
 =?utf-8?B?ZERRd3lpTHNsMlZYNmR6alBDSE9KL3NkN3huOXJmTTlXSDlhTXY5ZmJ0ZmRT?=
 =?utf-8?B?QlpTeFplZVNnRzZ2dmRoQnEwQWgrZngwZjRPUWZINHllYXVjOFdCQll1WjBz?=
 =?utf-8?B?RzJ5YW5RM2JUTk9LT01mVzFOc01xV25IRVM4K3ltK2dEeUxCS2kwd0I3QUxt?=
 =?utf-8?B?MmNWTlFsdVh4anN5ditvWjRhbWl0cTFUeFZxODFVVHE0S2VWQzgvcXVOblJ1?=
 =?utf-8?B?VjVXL0NSSzliTTlINEVDbjBrRTBLSVB3WUhPYTFYV0R6U1p2NE41eHhCNG9y?=
 =?utf-8?B?VFoyQnZXb2ZrOXJjRmpZUjlNTXp3NEFzdElQSHJvcWF3M2x5ODdCWnVmakJO?=
 =?utf-8?B?Tkd1enhHYWFQWFlLWUQ5b0I0T0NyWmtsVVJ1Ymc3VUpIc1Yrc0VYMElWMU9Q?=
 =?utf-8?B?SDhzVG9BT05pTk9pWEdjVlRlSmloK2Ntd3J3L1BmRmo4UDBlWURPajJpOHk4?=
 =?utf-8?B?RDBjdGZYdzg5cWhyTWJCd0syUEdhWDVVeVo5MG1zMHJVYVpJTU1GelNCNk5m?=
 =?utf-8?B?VzF3NFl4THMzcW9WejR3blpVYVZadUtDUTlEcEpJajNseWxqclRsVERvZzNJ?=
 =?utf-8?B?QW9ieTRsZ1B6KzlEeS9Xd3ZZSGJqcnFvRXBLSytOVStxUnljWjdFQkZTbjdZ?=
 =?utf-8?B?YnVKdXFKeFVYNklibDFBM1BtSXBQRERMM0J3eEhqN0ZtYmErS2xTUWhDc2FI?=
 =?utf-8?Q?/OvaklIly6KQOlLYtqXBzF/MC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <875BD32A58A6014596572C7F82D2EA4D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa10d2b8-8bf0-4174-3316-08dbd507a7b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 03:08:25.8058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Md4g59elqx/yvwE9vBq702wgXXTFAybZtTi7/YXZHAqea2r4Zwdm03OzsG1CHSRgognRCdjGna3b+9baFU5JWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjMtMTAtMjMgYXQgMTI6NDUgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIHNlY3VyZSBsYXllciBjb25maWcgc3VwcG9ydCBmb3Igb3ZsLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCAg
ICAgICB8ICAzICsrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMg
ICAgICAgfCAzMQ0KPiArKysrKysrKysrKysrKysrKy0tDQo+ICAuLi4vZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jICAgfCAxMiArKysrKysrDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jICAgfCAgMiArKw0KPiAgNCBmaWxlcyBjaGFu
Z2VkLCA0NiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBpbmRleCAyMjU0MDM4NTE5ZTEuLmRlYzkz
N2IxODNhOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X2Rydi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0K
PiBAQCAtOSw2ICs5LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1tdXRleC5oPg0KPiArI2luY2x1ZGUgIm10
a19kcm1fZGRwX2NvbXAuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX3BsYW5lLmgiDQo+ICAjaW5j
bHVkZSAibXRrX21kcF9yZG1hLmgiDQo+ICANCj4gQEAgLTc5LDYgKzgwLDcgQEAgdm9pZCBtdGtf
b3ZsX2Nsa19kaXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19vdmxfY29u
ZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ICAJCSAgICB1bnNpZ25l
ZCBpbnQgaCwgdW5zaWduZWQgaW50IHZyZWZyZXNoLA0KPiAgCQkgICAgdW5zaWduZWQgaW50IGJw
Yywgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCk7DQo+ICt1NjQgbXRrX292bF9nZXRfc2VjX3Bv
cnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50DQo+IGlkeCk7DQo+ICBp
bnQgbXRrX292bF9sYXllcl9jaGVjayhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBp
ZHgsDQo+ICAJCQlzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICptdGtfc3RhdGUpOw0KPiAgdm9pZCBt
dGtfb3ZsX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgs
DQo+IEBAIC0xMTIsNiArMTE0LDcgQEAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfY2xrX2Rpc2FibGUo
c3RydWN0IGRldmljZQ0KPiAqZGV2KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2NvbmZpZyhz
dHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3LA0KPiAgCQkJICAgIHVuc2lnbmVkIGlu
dCBoLCB1bnNpZ25lZCBpbnQgdnJlZnJlc2gsDQo+ICAJCQkgICAgdW5zaWduZWQgaW50IGJwYywg
c3RydWN0IGNtZHFfcGt0DQo+ICpjbWRxX3BrdCk7DQo+ICt1NjQgbXRrX292bF9hZGFwdG9yX2dl
dF9zZWNfcG9ydChzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wLCB1bnNpZ25lZA0KPiBpbnQgaWR4
KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHVuc2lnbmVkIGludA0KPiBpZHgsDQo+ICAJCQkJICBzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRl
ICpzdGF0ZSwNCj4gIAkJCQkgIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpOw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGluZGV4IDJiZmZlNDI0NTQ2Ni4u
NzZlODMyZTQ4NzVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292
bC5jDQo+IEBAIC00Niw2ICs0Niw3IEBADQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9BRERSKG92
bCwgbikJCSgob3ZsKS0+ZGF0YS0+YWRkciArDQo+IDB4MjAgKiAobikpDQo+ICAjZGVmaW5lIERJ
U1BfUkVHX09WTF9IRFJfQUREUihvdmwsIG4pCQkoKG92bCktPmRhdGEtDQo+ID5hZGRyICsgMHgy
MCAqIChuKSArIDB4MDQpDQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9IRFJfUElUQ0gob3ZsLCBu
KQkJKChvdmwpLT5kYXRhLQ0KPiA+YWRkciArIDB4MjAgKiAobikgKyAweDA4KQ0KPiArI2RlZmlu
ZSBESVNQX1JFR19PVkxfU0VDVVJFCQkJMHgwZmMwDQo+ICANCj4gICNkZWZpbmUgR01DX1RIUkVT
SE9MRF9CSVRTCTE2DQo+ICAjZGVmaW5lIEdNQ19USFJFU0hPTERfSElHSAkoKDEgPDwgR01DX1RI
UkVTSE9MRF9CSVRTKSAvIDQpDQo+IEBAIC0xMjYsOCArMTI3LDE5IEBAIHN0cnVjdCBtdGtfZGlz
cF9vdmwgew0KPiAgCWNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YQkqZGF0YTsNCj4gIAl2
b2lkCQkJCSgqdmJsYW5rX2NiKSh2b2lkICpkYXRhKTsNCj4gIAl2b2lkCQkJCSp2YmxhbmtfY2Jf
ZGF0YTsNCj4gKwlyZXNvdXJjZV9zaXplX3QJCQlyZWdzX3BhOw0KPiAgfTsNCj4gIA0KPiArdTY0
IG10a19vdmxfZ2V0X3NlY19wb3J0KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVk
IGludA0KPiBpZHgpDQo+ICt7DQo+ICsJaWYgKGNvbXAtPmlkID09IEREUF9DT01QT05FTlRfT1ZM
MCkNCj4gKwkJcmV0dXJuIDFVTEwgPDwgQ01EUV9TRUNfRElTUF9PVkwwOw0KPiArCWVsc2UgaWYg
KGNvbXAtPmlkID09IEREUF9DT01QT05FTlRfT1ZMMSkNCj4gKwkJcmV0dXJuIDFVTEwgPDwgQ01E
UV9TRUNfRElTUF9PVkwxOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyBpcnFyZXR1cm5fdCBtdGtfZGlzcF9vdmxfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2
X2lkKQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtfZGlzcF9vdmwgKnByaXYgPSBkZXZfaWQ7DQo+IEBA
IC00NDksOCArNDYxLDIyIEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmlj
ZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQkJICAgICAgRElTUF9SRUdfT1ZMX1NS
Q19TSVpFKGlkeCkpOw0KPiAgCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgb2Zmc2V0
LCAmb3ZsLT5jbWRxX3JlZywgb3ZsLQ0KPiA+cmVncywNCj4gIAkJCSAgICAgIERJU1BfUkVHX09W
TF9PRkZTRVQoaWR4KSk7DQo+IC0JbXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCBhZGRy
LCAmb3ZsLT5jbWRxX3JlZywgb3ZsLQ0KPiA+cmVncywNCj4gLQkJCSAgICAgIERJU1BfUkVHX09W
TF9BRERSKG92bCwgaWR4KSk7DQo+ICsNCj4gKwlpZiAoc3RhdGUtPnBlbmRpbmcuaXNfc2VjKSB7
DQo+ICsJCWNvbnN0IHN0cnVjdCBkcm1fZm9ybWF0X2luZm8gKmZtdF9pbmZvID0NCj4gZHJtX2Zv
cm1hdF9pbmZvKGZtdCk7DQo+ICsJCXVuc2lnbmVkIGludCBidWZfc2l6ZSA9IChwZW5kaW5nLT5o
ZWlnaHQgLSAxKSAqDQo+IHBlbmRpbmctPnBpdGNoICsNCj4gKwkJCQkJcGVuZGluZy0+d2lkdGgg
KiBmbXRfaW5mby0NCj4gPmNwcFswXTsNCj4gKw0KPiArCQltdGtfZGRwX3dyaXRlX21hc2soY21k
cV9wa3QsIEJJVChpZHgpLCAmb3ZsLT5jbWRxX3JlZywNCj4gb3ZsLT5yZWdzLA0KPiArCQkJCSAg
IERJU1BfUkVHX09WTF9TRUNVUkUsIEJJVChpZHgpKTsNCj4gKwkJbXRrX2RkcF9zZWNfd3JpdGUo
Y21kcV9wa3QsIG92bC0+cmVnc19wYSArDQo+IERJU1BfUkVHX09WTF9BRERSKG92bCwgaWR4KSwN
Cj4gKwkJCQkgIHBlbmRpbmctPmFkZHIsIENNRFFfSVdDX0hfMl9NVkEsIDAsDQo+IGJ1Zl9zaXpl
LCAwKTsNCj4gKwl9IGVsc2Ugew0KPiArCQltdGtfZGRwX3dyaXRlX21hc2soY21kcV9wa3QsIDAs
ICZvdmwtPmNtZHFfcmVnLCBvdmwtDQo+ID5yZWdzLA0KPiArCQkJCSAgIERJU1BfUkVHX09WTF9T
RUNVUkUsIEJJVChpZHgpKTsNCg0KV2hhdCdzIHRoZSBmdW5jdGlvbiBvZiB0aGlzIHJlZ2lzdGVy
PyBEb2VzIGl0IG1lYW5zIHRoYXQgbGF5ZXIgaXMgQUJMRQ0KdG8gcmVhZCBzZWN1cmUgYnVmZmVy
PyBBbmQgdGhpcyByZWdpc3RlciBjb3VsZCBiZSBjb250cm9sbGVkIGluIG5vcm1hbA0Kd29ybGQ/
DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwg
YWRkciwgJm92bC0+Y21kcV9yZWcsDQo+IG92bC0+cmVncywNCj4gKwkJCQkgICAgICBESVNQX1JF
R19PVkxfQUREUihvdmwsIGlkeCkpOw0KPiArCX0NCj4gIA0KPiAgCWlmIChpc19hZmJjKSB7DQo+
ICAJCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgaGRyX2FkZHIsICZvdmwtDQo+ID5j
bWRxX3JlZywgb3ZsLT5yZWdzLA0KPiBAQCAtNTI5LDYgKzU1NSw3IEBAIHN0YXRpYyBpbnQgbXRr
X2Rpc3Bfb3ZsX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJfQ0K
PiAgDQo+ICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVN
LCAwKTsNCj4gKwlwcml2LT5yZWdzX3BhID0gcmVzLT5zdGFydDsNCj4gIAlwcml2LT5yZWdzID0g
ZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gIAlpZiAoSVNfRVJSKHByaXYtPnJl
Z3MpKSB7DQo+ICAJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGlvcmVtYXAgb3ZsXG4iKTsNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRv
ci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMN
Cj4gaW5kZXggNmJmNjM2Nzg1M2ZiLi4yOGEwYmNjZmIwYjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IEBAIC04Myw2ICs4
MywxOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG92bF9hZGFwdG9yX2NvbXBfbWF0Y2gNCj4gY29t
cF9tYXRjaGVzW09WTF9BREFQVE9SX0lEX01BWF0gPSB7DQo+ICAJW09WTF9BREFQVE9SX0VUSERS
MF0JPSB7IE9WTF9BREFQVE9SX1RZUEVfRVRIRFIsIDAgfSwNCj4gIH07DQo+ICANCj4gK3N0YXRp
YyBjb25zdCB1NjQgb3ZsX2FkYXB0b3Jfc2VjX3BvcnRbXSA9IHsNCj4gKwkxVUxMIDw8IENNRFFf
U0VDX1ZETzFfRElTUF9SRE1BX0wwLA0KPiArCTFVTEwgPDwgQ01EUV9TRUNfVkRPMV9ESVNQX1JE
TUFfTDEsDQo+ICsJMVVMTCA8PCBDTURRX1NFQ19WRE8xX0RJU1BfUkRNQV9MMiwNCj4gKwkxVUxM
IDw8IENNRFFfU0VDX1ZETzFfRElTUF9SRE1BX0wzLA0KPiArfTsNCj4gKw0KPiArdTY0IG10a19v
dmxfYWRhcHRvcl9nZXRfc2VjX3BvcnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWdu
ZWQNCj4gaW50IGlkeCkNCj4gK3sNCj4gKwlyZXR1cm4gb3ZsX2FkYXB0b3Jfc2VjX3BvcnRbaWR4
XTsNCj4gK30NCj4gKw0KPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfbGF5ZXJfY29uZmlnKHN0cnVj
dCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50DQo+IGlkeCwNCj4gIAkJCQkgIHN0cnVjdCBtdGtf
cGxhbmVfc3RhdGUgKnN0YXRlLA0KPiAgCQkJCSAgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21w
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IGlu
ZGV4IDNkY2E5MzZiOTE0My4uZWVjM2ExY2MyZWQ0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gQEAgLTM3Myw2ICszNzMsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBkZHBfb3ZsID0NCj4gew0KPiAgCS5i
Z2Nscl9pbl9vZmYgPSBtdGtfb3ZsX2JnY2xyX2luX29mZiwNCj4gIAkuZ2V0X2Zvcm1hdHMgPSBt
dGtfb3ZsX2dldF9mb3JtYXRzLA0KPiAgCS5nZXRfbnVtX2Zvcm1hdHMgPSBtdGtfb3ZsX2dldF9u
dW1fZm9ybWF0cywNCj4gKwkuZ2V0X3NlY19wb3J0ID0gbXRrX292bF9nZXRfc2VjX3BvcnQsDQo+
ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBkZHBf
cG9zdG1hc2sgPSB7DQo+IEBAIC00MjQsNiArNDI1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfZGRwX2NvbXBfZnVuY3MNCj4gZGRwX292bF9hZGFwdG9yID0gew0KPiAgCS5yZW1vdmUgPSBt
dGtfb3ZsX2FkYXB0b3JfcmVtb3ZlX2NvbXAsDQo+ICAJLmdldF9mb3JtYXRzID0gbXRrX292bF9h
ZGFwdG9yX2dldF9mb3JtYXRzLA0KPiAgCS5nZXRfbnVtX2Zvcm1hdHMgPSBtdGtfb3ZsX2FkYXB0
b3JfZ2V0X251bV9mb3JtYXRzLA0KPiArCS5nZXRfc2VjX3BvcnQgPSBtdGtfb3ZsX2FkYXB0b3Jf
Z2V0X3NlY19wb3J0LA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBt
dGtfZGRwX2NvbXBfc3RlbVtNVEtfRERQX0NPTVBfVFlQRV9NQVhdID0NCj4gew0K
