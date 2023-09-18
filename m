Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FD27A4588
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbjIRJHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbjIRJHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:07:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D591AC5;
        Mon, 18 Sep 2023 02:07:04 -0700 (PDT)
X-UUID: b8b33606560211ee8051498923ad61e6-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uo1vS7lxXCG1Kp+KGz5UtJtrE8VmgDflHarKDQ9zxB0=;
        b=vGknM+kdmSynOU0O55AkkzYXwyAg2dhpM/Ghe0RxrD94vLEf7qS9iJxaaWl1LR3eU/o5pc0Jsw8B1EMkgEwDgt0kLf6jrXhWSQzyiYEheVTd0hvRB/yHt4EWeq8Di44Ga6hORR4B3cAweUcXwdN1woDAVIN0LdwM798KOynsg4I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:7b7de3b1-9893-4464-b511-dc0560aeb5d0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:3d3fd3ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b8b33606560211ee8051498923ad61e6-20230918
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 85522545; Mon, 18 Sep 2023 17:06:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 17:06:57 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 17:06:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksPbSis0Nv98owFTMNZ/giNtKt3n/fNT6wFKH6wSxzx+d7CFlKNl4qyvyA4zBgf6UlRrrT6m748B/suU2mReNuYtq11YkyfOrEOcp5DYy+5m6xPojRmW33E5eMbCDaqEw7Tmp+ptMuIJcvrFNntFYsV8+xe6Jdi3wm7aLL29qOxPkJp8hmBJ4dl9eDusnS4OoCi1wYqa/9uJiMS26p+7SHszeUgruTvKtJ0uapO0taSEmYf8YOjMILmELzWTb3CQYsziwFA1VA6XEPJumjpUSPRuxSpy1Gf4lz4HUD+pRVc+kn9cu6VpGqUMKMOEUfBw4+zTbLkZ5vBmX82dB+8aKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo1vS7lxXCG1Kp+KGz5UtJtrE8VmgDflHarKDQ9zxB0=;
 b=jtuN5ntotr9y35suk+Po+NZ1qoEv0OBwKSCgFa6VlbAA7DCkjFMj9oYXeF6PMBI2n0UBs484DAbBNCRPZx+2w4iNZhEF+V5757lNkNx0cPtEokhOayb0cwCh1uqvy65g7GtD2mVcYV7HrGf6tc3Mr7bY+MuqoZI23mrRL299bLzhxaSPvZ4sKyeVkOE1QJ8no4SlcmdqOvoIorXjoZ2RO7kSgIIAbMqY7XQhb92j47A8bxc7fE9+iaknYdTkfNkaMYDrVp+1urRDzOhCS3xRxOqXlQDP553uS/AzlCtGQVHftG0UoWCoYPj/THXn2qT8Sf2gPW+DrvtdS2UrpBAmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo1vS7lxXCG1Kp+KGz5UtJtrE8VmgDflHarKDQ9zxB0=;
 b=X+lwXjUwBATexETb625TO4CuzoF+I4DnjINSCXryFztZWyLa5OK0ZRKL7pKTmnu9IdLwIg2FPrTHpgL8fyqy0Gt0NbW2Y2Dsd/JPbm0q6qV3YNYyemH+AG3CS6vmy2SMrarHMcjMtpk9RSw9I1QlHLOGIfTX8YsazanjhDmsYc8=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by KL1PR03MB7718.apcprd03.prod.outlook.com (2603:1096:820:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 09:06:54 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::34d1:7152:7f28:8af8]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::34d1:7152:7f28:8af8%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 09:06:54 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder
 driver
Thread-Topic: [PATCH 12/14] media: medkatek: vcodec: set secure mode to
 decoder driver
Thread-Index: AQHZ5K/xmXjsPSANs0u2pLMArEpvXrAVxwwAgAEnPICABKSZAIAACFCAgAS6XYA=
Date:   Mon, 18 Sep 2023 09:06:54 +0000
Message-ID: <7efb40d0ff7b81e7b1b4bd001196b699cf639639.camel@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-13-yunfei.dong@mediatek.com>
         <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
         <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl>
         <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
         <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl>
In-Reply-To: <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|KL1PR03MB7718:EE_
x-ms-office365-filtering-correlation-id: e3ba85e4-db9c-40d8-a8d5-08dbb8269a64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGx97yXYyIQIcxyS3xtqWEl2Z1CtsIwU0F+5p4E+o2EOqmXEZnlKzO5JScbvNqAo9Q9/v41K49RiG3qPadfoooKiMu6FtVQcd9D46qq4Ur4P3DgbCInbp7LnuE8G6rzTqMEvo8DC1yFSZHlZ4K5OVpvkgmRw7TBTk3ex0JgtvN+vCyRxmx9uSqDRz+ovqAKdKqqJfVoGGKum+C4p4wl6Pp4rlfbFQEGFOuOqVqibnbpe21dYsUOuj0vcf5lEbTGBGtOL3le10xsd7hdGHxTmq3jtXGyzVSG2EKyYerjXHPSF7om8CggrKgnXgVUpLpfXiSBHAeo1h4Y48UkISJgUvNlnNLXYZaYRAFMb1i86Y6zNIY6KXrzpxYUhD1N+e11fdrQmTTeXzz/G0k8i1NUfYqoN4bwd+ukAO82Bj5y38cWxSJ8igx1Ce9elQ06Rm3Wqu736o/+8HyvIYAQjDGnZMcChU9aHLYWU4/KRRmE7mbIQZT4dp24K3XF3RA6AZHScz4MV0RHaiyUGBnvbmyv9gpCxlpU6JpMt4dS74auYusSiEkemIaX/brWU8DHkSIXFZLl9IAMxLxuXvarR+uDMCJv7gp452sBikWNud7vHCOTTlQcRsXbd119eN+eFaBSuACsJBNkhxiMfYq77ZDj0UmfN8VI0w/hBxVvQpGU5M9SqpDn3jCRv2bWGI6a7+ODY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(1800799009)(186009)(451199024)(6506007)(53546011)(6486002)(6512007)(71200400001)(83380400001)(478600001)(26005)(2616005)(66574015)(2906002)(7416002)(64756008)(66446008)(76116006)(54906003)(66946007)(66476007)(66556008)(316002)(91956017)(110136005)(8676002)(5660300002)(4326008)(8936002)(41300700001)(85182001)(36756003)(86362001)(38070700005)(38100700002)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjhGb3dOdmo4YnIyY0Z4VEVmbGRtZHdTRWtHRUtQcVJDRXdnMlVDNDlLKytn?=
 =?utf-8?B?aVJZTGJkRWExNWVrOVduSThrUjBZTGk1NHYvZWRlalhydkpoM1JYUm9DTHRU?=
 =?utf-8?B?SFZZYkI3d1FuV1lDNHpMNHFtcFJYbVY2b3p4a0FReURxZi9hVUlRZEdIZzht?=
 =?utf-8?B?L3FuR3J5LzNackRHWEQvei9WVWw2ejdhWGdSdWl5S2xrWkZVR1JCdm9SWHJu?=
 =?utf-8?B?TFhoc0QzcCszUDNJanpNVWdzZXhITnBhSzNvZUtPeWd2R1hrbWhYTkV3UEJZ?=
 =?utf-8?B?UWFONUFBWDBueW0rNUJSNFFhNWQ2cmQ5a1J4OFNhaWQzOFk4Y3VjU1poM0JK?=
 =?utf-8?B?TVlNY2kxUm9ucEl0QW85R21VaWFhN0hNSGExcFJPazk4MVg0OElYWmZFckky?=
 =?utf-8?B?M2xLQVhOUk1mektzVkdrRXc4YVN4RlFZYWNlWmlGUDc2R1IzNmZJNFdwTkVM?=
 =?utf-8?B?VEo3WjVsVEdCS01YZnBJR01sTWFvNWhqVXNsQzZleC9pdXpVZHp3K0ZFZmdu?=
 =?utf-8?B?em10a25LYk5QRkwrZXJ2UzZ0cnExRGhzb3g4SW4xd1c2YitST2pHYVMyUVpp?=
 =?utf-8?B?UlA0bDJQaHpVU3E0Wm1PS0l2TXp1L0dnMmNremxmYk5nOVlmcUlRSm0zSWJN?=
 =?utf-8?B?cVp5b1RvVERmNEdnd3o0eXFpMDM0S01QaFlNVDJZcmN4ZEd3K0dMR0xSUm8r?=
 =?utf-8?B?OXVjcUJWNHlKVXR5V1gwNDIwQzczVUVoWGtoQ2dtWjVFaGNLMWlpaTZaNXdl?=
 =?utf-8?B?R2hGV1NmQTkxWHpYRi9adFJCQm5GN1c1WXNHd080MmY0WEYvcFRkVTlUWlJ3?=
 =?utf-8?B?aDBBWkQyTlM2dStGUU5zeXAzSUx1VkhKSDFxRmhRTnRPVkRLSjVvdzUwaHZQ?=
 =?utf-8?B?N1BYZHNUd2c0bDVPS3h1ZTBFSmRLM2dwYVF4aGVEUTcxVnh5aUhyWDFmY0xW?=
 =?utf-8?B?VDlGTjF2U3ZaTnZQTnpraUt3Mk1PTnFZTXNaeWNoR3NpVVZLSUJMLytiTlF2?=
 =?utf-8?B?d1E2d0lvaWVwd1lMNk15Tnd3OCs5OS94b0E3M0pubFVyZTREdjllRDZMTkRo?=
 =?utf-8?B?NHViN1kzYjk1WFRYT3B2VkxscGJob2VUNkdzSHBWZGVpa3JTT3ZhbHc4T05E?=
 =?utf-8?B?WmhNUy91c2EzZ0xKUllMSElPRjIrc3ZYYkt5YTVuczV1NFljVW1HNHBsSFJH?=
 =?utf-8?B?M3k5MUdwOXY2L3ZKckJnWGJSdHp6VDBmRHI4SlYxMklPbkdPRHdiaHg1UHJi?=
 =?utf-8?B?a1JYKzVYUGFTQ1lRUlpiSjErYWFlUys3TWlENldiSndhc1ZQa2dOaW53eWdQ?=
 =?utf-8?B?OURhV2ZKbFJkWVIxMHdOZ0VuZnA4WmtOdmQ3OEUxMHcxQjZla0dWT1pmTVpG?=
 =?utf-8?B?eDlTWW82MHpXWFhPelEvRkNCYlA5eXpEdjlYN01yN0tpalRSQUp3Tlgrb21l?=
 =?utf-8?B?TEhhbjRqKzNBWXA4eGsxeWY3YmVrQ3ZYaUh6bFVJVFZqeEw0S2V1OHVNUktq?=
 =?utf-8?B?cUovSnV2Z0hPSzZCVWRYak8xeHZDN3p4T1pTbDNQdjRjVmlYOXVFRlRUc2V5?=
 =?utf-8?B?WXhVVlVxdUJqYi9RZTYyU29hUVZsRDRtU0RvQjVLS3NYL1NQNlZtWTFlb3lz?=
 =?utf-8?B?TDFTb1JJVml5U1JvUXhJenRpYWpzT0xRZEhYYzlOdmdFMUZtRkNoK3ZOam1Q?=
 =?utf-8?B?UnU1VlJIL0UwWUdvOFRjc1oyc1V3b3FjNm40MHRDZHZBcmp1dEhzcmFJTTJj?=
 =?utf-8?B?YkFQMWFPdXJSMm5FYUE3Q3dHMVdjOGtVSFdtMXZsaVdVMXhlU1JIOEl0YlhI?=
 =?utf-8?B?K2hWcGFBUVdsOUkxc1VYeXdpQWhRRGwyblF4NkpORXl2cE5RV005OXE0eFNm?=
 =?utf-8?B?ejRqcVBkYVl4S3ZMSERWZzhyZzlEek5JZkQwWGNxbXN5L285YWNlTWlwY3Bx?=
 =?utf-8?B?b1JxYUxKWHBFNzlzNXgxUUh3NmJoaXB3MkZxOVUrdHZkRmRxM2VoK1NkeTJI?=
 =?utf-8?B?eVB0UWpkT01JMVhPV1dFUi84QmIxcnBsVUxvNFR1djBKZVp0UWorTGFHbXlj?=
 =?utf-8?B?OG5weEZCMURZMUFYc0o2UzdsRkpGLytDTXJaWGNkRlhRdE9lTHhyYU5RdVZr?=
 =?utf-8?B?S1drbHFNRDZSdDQ1UzdUTjh0eEVTQTJidXhNODFHNkd6dU1maVg0bG5KTkYv?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7146FA9FED1BB34FB9EEFAEA3A80CE44@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ba85e4-db9c-40d8-a8d5-08dbb8269a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 09:06:54.1012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmvYC4uCVg+2qvP7+59EXVeyKkcKxsGP3G0eMikcO7AQyIvdiZRUqICSUmobsdnLlM4qEIYRzaWWNAayQ77BxOFqFCj7ZCR6mbUKhDDDcWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7718
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KVGhhbmtzIGZvciB5b3VyIGFkdmljZS4NCk9uIEZyaSwgMjAyMy0wOS0xNSBh
dCAxMDo1NCArMDIwMCwgSGFucyBWZXJrdWlsIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1h
aWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwN
Cj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIE9uIDE1
LzA5LzIwMjMgMTA6MjUsIFl1bmZlaSBEb25nICjokaPkupHpo54pIHdyb3RlOg0KPiA+IEhpIEhh
bnMgJiBOaWNvbGFzLA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgeW91ciBhZHZpY2UuDQo+ID4gDQo+
ID4gT24gVHVlLCAyMDIzLTA5LTEyIGF0IDExOjMwICswMjAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6
DQo+ID4+ICAgDQo+ID4+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+IHVudGlsDQo+ID4+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4+ICBIaSwNCj4gPj4NCj4gPj4gT24gOS8xMS8y
MyAxNzo1NCwgTmljb2xhcyBEdWZyZXNuZSB3cm90ZToNCj4gPj4+IEhpLA0KPiA+Pj4NCj4gPj4+
IExlIGx1bmRpIDExIHNlcHRlbWJyZSAyMDIzIMOgIDIwOjU5ICswODAwLCBZdW5mZWkgRG9uZyBh
IMOpY3JpdCA6DQo+ID4+Pj4gU2V0dGluZyBzZWN1cmUgbW9kZSBmbGFnIHRvIGtlcm5lbCB3aGVu
IHRyeWluZyB0byBwbGF5IHNlY3VyZQ0KPiA+Pg0KPiA+PiB2aWRlbywNCj4gPj4+PiB0aGVuIGRl
Y29kZXIgZHJpdmVyIHdpbGwgaW5pdGlhbGl6ZSB0ZWUgcmVsYXRlZCBpbnRlcmZhY2UgdG8NCj4g
Pj4NCj4gPj4gc3VwcG9ydA0KPiA+Pj4+IHN2cC4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gVGhpcyBp
cyBub3Qgd2hhdCB0aGUgcGF0Y2ggaXMgZG9pbmcsIHBsZWFzZSByZXdvcmsuIFRoaXMgcGF0Y2gg
aXMNCj4gPj4NCj4gPj4gYW4gdmVuZG9yIEFQSQ0KPiA+Pj4gYWRkaXRpb24gaW50cm9kdWNpbmcg
VjRMMl9DSURfTVBFR19NVEtfU0VUX1NFQ1VSRV9NT0RFLiBJIHNob3VsZA0KPiA+Pg0KPiA+PiBu
b3QgaGF2ZSB0bw0KPiA+Pj4gcmVhZCB5b3VyIHBhdGNoIHRvIHVuZGVyc3RhbmQgdGhpcy4NCj4g
Pj4+DQo+ID4+Pj4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBZdW5mZWkgRG9uZyA8eXVuZmVpLmRv
bmdAbWVkaWF0ZWsuY29tPg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICAuLi4vdmNvZGVjL2RlY29kZXIv
bXRrX3Zjb2RlY19kZWNfc3RhdGVsZXNzLmMgICAgIHwgMTUNCj4gPj4NCj4gPj4gKysrKysrKysr
KysrKystDQo+ID4+Pj4gIGRyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY3RybHMtZGVmcy5j
ICAgICAgICAgfCAgNSArKysrKw0KPiA+Pj4+ICBpbmNsdWRlL3VhcGkvbGludXgvdjRsMi1jb250
cm9scy5oICAgICAgICAgICAgICAgIHwgIDEgKw0KPiA+Pj4+ICAzIGZpbGVzIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQN
Cj4gPj4NCj4gPj4NCj4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9k
ZWNvZGVyL210a192Y29kZWNfZGVjX3N0YXRlDQo+ID4+IGxlc3MuYw0KPiA+Pg0KPiBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNf
c3RhdGUNCj4gPj4gbGVzcy5jDQo+ID4+Pj4gaW5kZXggZDJiMDljZTlmMWNmLi5hOTgxMTc4YzI1
ZDkgMTAwNjQ0DQo+ID4+Pj4gLS0tDQo+ID4+DQo+ID4+DQo+IGEvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19zdGF0ZQ0KPiA+PiBs
ZXNzLmMNCj4gPj4+PiArKysNCj4gPj4NCj4gPj4NCj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjX3N0YXRlDQo+ID4+IGxlc3Mu
Yw0KPiA+Pj4+IEBAIC01MzUsNiArNTM1LDE3IEBAIHN0YXRpYyBpbnQgbXRrX3ZkZWNfc19jdHJs
KHN0cnVjdCB2NGwyX2N0cmwNCj4gPj4NCj4gPj4gKmN0cmwpDQo+ID4+Pj4gIGN0cmwtPnZhbCA9
IG10a19kbWFfY29udGlnX2dldF9zZWN1cmVfaGFuZGxlKGN0eCwgY3RybC0+dmFsKTsNCj4gPj4+
PiAgbXRrX3Y0bDJfdmRlY19kYmcoMywgY3R4LCAiZ2V0IHNlY3VyZSBoYW5kbGU6ICVkID0+IDB4
JXgiLA0KPiA+Pg0KPiA+PiBzZWNfZmQsIGN0cmwtPnZhbCk7DQo+ID4+Pj4gIGJyZWFrOw0KPiA+
Pj4+ICtjYXNlIFY0TDJfQ0lEX01QRUdfTVRLX1NFVF9TRUNVUkVfTU9ERToNCj4gPj4+DQo+ID4+
PiBTdGVwcGluZyBiYWNrIGEgbGl0dGxlIGFuZCBmb2N1c2luZyBvbiB0aGUgQVBJLCB3aGF0IG1h
a2VzIHlvdXINCj4gPj4NCj4gPj4gZHJpdmVyIHNvDQo+ID4+PiBzcGVjaWFsIHRoYXQgaXQgc2hv
dWxkIGJlIHRoZSBvbmx5IG9uZSBoYXZpbmcgYSAic2VjdXJlIG1vZGUiID8NCj4gV2UNCj4gPj4N
Cj4gPj4gYXJlIHRvdWNoaW5nDQo+ID4+PiBpbiBnYXAgaW4gdGhlIG1lZGlhIHBpcGVsaW5lIGlu
IExpbnV4LCBhbmQgdGhpcyBzaG91bGQgY29tZSB3aXRoDQo+ID4+DQo+ID4+IGNvbnNpZGVyYXRp
b24NCj4gPj4+IG9mIHRoZSBnbG9iYWwgQVBJLg0KPiA+Pj4NCj4gPj4+IFdoeSBpcyB0aGlzIEFQ
SSBiZXR0ZXIgdGhlbiBsZXQncyBzYXkgR29vZ2xlIEFuZHJvaWQgb25lLCB3ZXJlDQo+IHRoZXkN
Cj4gPj4NCj4gPj4gZXhwb3NlIDINCj4gPj4+IGRldmljZSBub2RlcyBpbiB0aGVpciBmb3JrIG9m
IHRoZSBNRkMgZHJpdmVyIChhIHNlY3VyZSBhbmQgYSBub24NCj4gPj4NCj4gPj4gc2VjdXJlIG9u
ZSkgPw0KPiA+Pg0KPiA+PiBQZXJoYXBzIGl0IGlzIGEgZ29vZCBpZGVhIHRvIGZpcnN0IHBvc3Qg
YW4gUkZDIHdpdGggYW4gdUFQSQ0KPiBwcm9wb3NhbA0KPiA+PiBvbiBob3cgdG8NCj4gPj4gaGFu
ZGxlIHNlY3VyZSB2aWRlby4gSSBzdXNwZWN0IHRoaXMgaXNuJ3QgbWVkaWF0ZWsgc3BlY2lmaWMs
IG90aGVyDQo+ID4+IFNvQ3Mgd2l0aA0KPiA+PiB0ZWUgc3VwcG9ydCBjb3VsZCB1c2UgdGhpcyBh
cyB3ZWxsLg0KPiA+Pg0KPiA+PiBBcyBOaWNvbGFzIHNhaWQsIGl0J3MgbG9uZyBrbm93biB0byBi
ZSBhIGdhcCBpbiBvdXIgbWVkaWEgc3VwcG9ydCwNCj4gc28NCj4gPj4gaXQgaXMNCj4gPj4gcmVh
bGx5IGdyZWF0IHRoYXQgeW91IHN0YXJ0ZWQgd29yayBvbiB0aGlzLCBidXQgeW91IG5lZWQgdG8g
bG9vaw0KPiBhdA0KPiA+PiB0aGlzIGZyb20NCj4gPj4gYSBtb3JlIGdlbmVyaWMgcG9pbnQtb2Yt
dmlldywgYW5kIG5vdCBtZWRpYXRlay1zcGVjaWZpYy4NCj4gPj4NCj4gPiANCj4gPiBXaGV0aGVy
IHlvdXIgaGF2ZSBhbnkgYWR2aWNlIGFib3V0IGhvdyB0byBkbyBhIG1vcmUgZ2VuZXJpYyBkcml2
ZXINCj4gdG8NCj4gPiBoYW5kbGUgc2VjdXJlIHZpZGVvIHBsYXliYWNrPw0KPiA+IA0KPiA+IFRo
ZXJlIGFyZSBzZXZlcmFsIGtpbmQgb2YgYnVmZmVyOiBvdXRwdXQgcXVldWUgYnVmZmVyL2NhcHR1
cmUgcXVldWUNCj4gPiBidWZmZXIvd29ya2luZyBidWZmZXIuDQo+ID4gDQo+ID4gb3V0cHV0IGFu
ZCBjYXB0dXJlIHF1ZXVlIGJ1ZmZlcjogdXNlciBzcGFjZSB3aWxsIGNhbGwgdGVlIHJlbGF0ZWQN
Cj4gPiBpbnRlcmZhY2UgdG8gYWxsb2NhdGUgc2VjdXJlIGhhbmRsZS4gV2lsbCBjb252ZXJ0IHRv
IHNlY3VyZSBoYW5kbGUNCj4gd2l0aA0KPiA+IHY0bDIgZnJhbWV3b3JrLCB0aGVuIHNlbmQgc2Vj
dXJlIGhhbmRsZSB0byBvcHRlZS1vcy4NCj4gPiANCj4gPiB3b3JraW5nIGJ1ZmZlcjogY2FsbGlu
ZyBkbWFfaGVhcCBhbmQgZG1hX2J1ZiB0byBnZXQgc2VjdXJlIG1lbW9yeQ0KPiA+IGhhbmRsZSwg
dGhlbiBjb3ZlcnQgc2VjdXJlIGlvdmEgaW4gb3B0ZWUtb3MuDQo+ID4gDQo+ID4gVXNpbmcgdGhl
IHNhbWUga2VybmVsIGRyaXZlciBmb3Igc3ZwIGFuZCBub24tc3ZwIHBsYXliYWNrLCBqdXN0IHRo
ZQ0KPiA+IGJ1ZmZlciB0eXBlIGFyZSBkaWZmZXJlbnQuIE5vcm1hbCBpcyBpb3ZhIGFuZCBzZWN1
cmUgaXMgc2VjdXJlDQo+IGhhbmRsZS4NCj4gPiANCj4gPiBVc2VyIGRyaXZlciB3aWxsIHRlbGwg
dGhlIGtlcm5lbCBkcml2ZXIgd2l0aCBDSUQgY29udHJvbCB3aGV0aGVyDQo+IHRoZQ0KPiA+IGN1
cnJlbnQgcGxheWJhY2sgaXMgc3ZwIG9yIG5vbi1zdnAuDQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5n
IGlzIHRoYXQgd2hlbiB5b3Ugc3dpdGNoIHRvIHNlY3VyZSBtb2RlLCB0aGUgZHJpdmVyDQo+IG1h
a2VzDQo+IHNvbWUgb3B0ZWUgY2FsbHMgdG8gc2V0IGV2ZXJ5dGhpbmcgdXAuIEFuZCB1c2Vyc3Bh
Y2UgbmVlZHMgYSB3YXkNCj4gY29udmVydCBhDQo+IGRtYWJ1ZiBmZCB0byBhICdzZWN1cmUgaGFu
ZGxlJywgd2hpY2ggYXBwZWFycyB0byBiZSB0aGUgRE1BIGFkZHJlc3MNCj4gb2YgdGhlDQo+IGJ1
ZmZlci4gV2hvIHVzZXMgdGhhdCBoYW5kbGU/DQo+IA0KVXNlciBzcGFjZSBuZWVkIHRvIGdldC9z
ZXQgaW5mb3JtYXRpb24gZm9yIHNvbWUgc2VjdXJlIG1lbW9yeSB3aXRoIGRtYQ0Kc2VjdXJlIGhh
bmRsZSwgc3VjaCBhcyBpbnB1dCBidWZmZXIvZnJhbWUgYnVmZmVyL3RtcCBidWZmZXIsIGV0Yy4N
ClNlY3VyZSBmZCB3aWxsIGNvbnZlcnQgdG8gc2VjdXJlIGhhbmRsZSBpbiBrZXJuZWwgc3BhY2Ug
dGhlbiBpbiBvcHRlZS0NCm9zIGluIHVzZXIgc3BhY2UuDQo+IEluIGFueSBjYXNlLCB1c2luZyBh
IGNvbnRyb2wgdG8gc3dpdGNoIHRvIHNlY3VyZSBtb2RlIGFuZCB1c2luZyBhDQo+IGNvbnRyb2wN
Cj4gdG8gY29udmVydCBhIGRtYWJ1ZiBmZCB0byBhIHNlY3VyZSBoYW5kbGUgc2VlbXMgYSBwb29y
IGNob2ljZSB0byBtZS4NCj4gDQo+IEkgd2FzIHdvbmRlcmluZyBpZiBpdCB3b3VsZG4ndCBiZSBi
ZXR0ZXIgdG8gY3JlYXRlIGEgbmV3IFY0TDJfTUVNT1JZXw0KPiB0eXBlLA0KPiBlLmcuIFY0TDJf
TUVNT1JZX0RNQUJVRl9TRUNVUkUgKG9yIHBlcmhhcHMgX0RNQUJVRl9PUFRFRSkuIFRoYXQNCj4g
ZW5zdXJlcyB0aGF0DQo+IG9uY2UgeW91IGNyZWF0ZSBidWZmZXJzIGZvciB0aGUgZmlyc3QgdGlt
ZSwgdGhlIGRyaXZlciBjYW4gc3dpdGNoDQo+IGludG8gc2VjdXJlDQo+IG1vZGUsIGFuZCB1bnRp
bCBhbGwgYnVmZmVycyBhcmUgcmVsZWFzZWQgYWdhaW4geW91IGtub3cgdGhhdCB0aGUNCj4gZHJp
dmVyIHdpbGwNCj4gc3RheSBpbiBzZWN1cmUgbW9kZS4NCj4gDQpJdCdzIG5vIG5lZWQgdG8gYWRk
IFY0TDJfTUVNT1JZX0RNQUJVRl9TRUNVUkUsIHY0bDIgZnJhbWV3cm9rIGNhbg0KY29udmVydCBz
ZWN1cmUgZmQgdG8gc2VjdXJlIGhhbmRsZSBkaXJlY3RseSBmb3IgVkIyX01FTVJPWV9ETUFCVUYu
DQpVc2VyIHNwYWNlIHdpbGwgcXVldWUgY2FwdHVyZSBhbmQgb3V0cHV0IGJ1ZmZlciwgdGhlbiBj
YWxsaW5nDQp2YjJfZG1hX2NvbnRpZ19wbGFuZV9kbWFfYWRkciB0byBnZXQgc2VjdXJlIGhhbmRs
ZSBmb3Igc2VjdXJlIG1vZGUsDQpnZXR0aW5nIGlvdmEgZm9yIG5vcm1hbCBwbGF5YmFjay4NCg0K
SWYgdGhlIGRyaXZlciB3YW50IHRvIHVzZSBtZW1vcnkgdHlwZSBNTUFQLCBtYXliZSBuZWVkIHRv
IGFkZA0KVkIyX01FTVJPWV9NTUFQX1NFQ1VSRS4NCg0KPiBGb3IgY29udmVydGluZyB0aGUgZG1h
YnVmIGZkIGludG8gYSBzZWN1cmUgaGFuZGxlOiBhIG5ldyBpb2N0bA0KPiBzaW1pbGFyIHRvDQo+
IFZJRElPQ19FWFBCVUYgbWlnaHQgYmUgbW9yZSBzdWl0ZWQgZm9yIHRoYXQuDQo+IA0KPiBOb3Rl
IHRoYXQgSSBhbSB0aGUgZmlyc3QgdG8gYWRtaXQgdGhhdCBJIGhhdmUgbm8gZXhwZXJpZW5jZSB3
aXRoDQo+IHNlY3VyZQ0KPiB2aWRlbyBwaXBlbGluZXMgb3Igb3B0ZWUtb3MsIHNvIEkgYW0gbG9v
a2luZyBhdCB0aGlzIHB1cmVseSBmcm9tIGFuDQo+IHVBUEkNCj4gcGVyc3BlY3RpdmUuDQo+IA0K
SXQncyBhIGdvb2QgY2hvaWNlIHRvIGNvbnZlcnQgc2VjdXJlIGZkIHRvIHNlY3VyZSBoYW5kbGUg
d2l0aCBhIG5ldw0KaW9jdGwgY2FsbGJhY2ssIHdpbGwgY2FsbCB0aGUgaW9jdGwgbWFueSB0aW1l
cyBmb3IgdGhlcmUgYXJlIG1hbnkNCmJ1ZmZlcnMuIElmIHRoZSBkcml2ZXIgaW4gc2VjdXJlIGZk
IHRvIHNlY3VyZSBoYW5kbGVyIGNhbGxiYWNrLCB0aGUNCmRyaXZlciByZWdhcmQgdGhlIHBsYXli
YWNrIGlzIHNlY3VyZSBtb2RlPw0KDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0KPiBSZWdh
cmRzLA0KPiANCj4gSGFucw0KPiANCj4gPiANCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gWXVuZmVp
IERvbmcNCj4gPj4gUmVnYXJkcywNCj4gPj4NCj4gPj4gSGFucw0KPiA+Pg0KPiA+Pj4NCj4gPj4+
IHJlZ2FyZHMsDQo+ID4+PiBOaWNvbGFzDQo+ID4+Pg0KPiA+Pj4gcC5zLiB5b3UgZm9yZ290IHRv
IGRvY3VtZW50IHlvdXIgY29udHJvbCBpbiB0aGUgUlNUIGRvYywgcGxlYXNlDQo+IGRvDQo+ID4+
DQo+ID4+IGluIGZvbGxvd2luZw0KPiA+Pj4gcmVsZWFzZS4NCj4gPj4+DQo+ID4+Pj4gK2N0eC0+
aXNfc3ZwX21vZGUgPSBjdHJsLT52YWw7DQo+ID4+Pj4gKw0KPiA+Pj4+ICtpZiAoY3R4LT5pc19z
dnBfbW9kZSkgew0KPiA+Pj4+ICtyZXQgPSBtdGtfdmNvZGVjX2RlY19vcHRlZV9vcGVuKGN0eC0+
ZGV2LT5vcHRlZV9wcml2YXRlKTsNCj4gPj4+PiAraWYgKHJldCkNCj4gPj4+PiArbXRrX3Y0bDJf
dmRlY19lcnIoY3R4LCAib3BlbiBzZWN1cmUgbW9kZSBmYWlsZWQuIik7DQo+ID4+Pj4gK2Vsc2UN
Cj4gPj4+PiArbXRrX3Y0bDJfdmRlY19kYmcoMywgY3R4LCAiZGVjb2RlciBpbiBzZWN1cmUgbW9k
ZTogJWQiLCBjdHJsLQ0KPiA+Pj4NCj4gPj4+IHZhbCk7DQo+ID4+Pj4gK30NCj4gPj4+PiArYnJl
YWs7DQo+ID4+Pj4gIGRlZmF1bHQ6DQo+ID4+Pj4gIG10a192NGwyX3ZkZWNfZGJnKDMsIGN0eCwg
Ik5vdCBzdXBwb3J0ZWQgdG8gc2V0IGN0cmwgaWQ6DQo+ID4+Pj4gMHgleFxuIiwNCj4gPj4NCj4g
Pj4gaGRyX2N0cmwtPmlkKTsNCj4gPj4+PiAgcmV0dXJuIHJldDsNCj4gPj4+PiBAQCAtNTczLDcg
KzU4NCw3IEBAIHN0YXRpYyBpbnQgbXRrX3Zjb2RlY19kZWNfY3RybHNfc2V0dXAoc3RydWN0DQo+
ID4+DQo+ID4+IG10a192Y29kZWNfZGVjX2N0eCAqY3R4KQ0KPiA+Pj4+ICB1bnNpZ25lZCBpbnQg
aTsNCj4gPj4+PiAgc3RydWN0IHY0bDJfY3RybCAqY3RybDsNCj4gPj4+PiAgDQo+ID4+Pj4gLXY0
bDJfY3RybF9oYW5kbGVyX2luaXQoJmN0eC0+Y3RybF9oZGwsIE5VTV9DVFJMUyArIDEpOw0KPiA+
Pj4+ICt2NGwyX2N0cmxfaGFuZGxlcl9pbml0KCZjdHgtPmN0cmxfaGRsLCBOVU1fQ1RSTFMgKyAy
KTsNCj4gPj4+PiAgaWYgKGN0eC0+Y3RybF9oZGwuZXJyb3IpIHsNCj4gPj4+PiAgbXRrX3Y0bDJf
dmRlY19lcnIoY3R4LCAidjRsMl9jdHJsX2hhbmRsZXJfaW5pdCBmYWlsZWRcbiIpOw0KPiA+Pj4+
ICByZXR1cm4gY3R4LT5jdHJsX2hkbC5lcnJvcjsNCj4gPj4+PiBAQCAtNTkyLDYgKzYwMyw4IEBA
IHN0YXRpYyBpbnQgbXRrX3Zjb2RlY19kZWNfY3RybHNfc2V0dXAoc3RydWN0DQo+ID4+DQo+ID4+
IG10a192Y29kZWNfZGVjX2N0eCAqY3R4KQ0KPiA+Pj4+ICANCj4gPj4+PiAgY3RybCA9IHY0bDJf
Y3RybF9uZXdfc3RkKCZjdHgtPmN0cmxfaGRsLA0KPiA+Pg0KPiA+PiAmbXRrX3Zjb2RlY19kZWNf
Y3RybF9vcHMsDQo+ID4+Pj4gICBWNEwyX0NJRF9NUEVHX01US19HRVRfU0VDVVJFX0hBTkRMRSwg
MCwgNjU1MzUsIDEsIDApOw0KPiA+Pj4+ICtjdHJsID0gdjRsMl9jdHJsX25ld19zdGQoJmN0eC0+
Y3RybF9oZGwsDQo+ID4+DQo+ID4+ICZtdGtfdmNvZGVjX2RlY19jdHJsX29wcywNCj4gPj4+PiAr
IFY0TDJfQ0lEX01QRUdfTVRLX1NFVF9TRUNVUkVfTU9ERSwgMCwgNjU1MzUsIDEsIDApOw0KPiA+
Pj4+ICANCj4gPj4+PiAgdjRsMl9jdHJsX2hhbmRsZXJfc2V0dXAoJmN0eC0+Y3RybF9oZGwpOw0K
PiA+Pj4+ICANCj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRs
Mi1jdHJscy1kZWZzLmMNCj4gPj4NCj4gPj4gYi9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwy
LWN0cmxzLWRlZnMuYw0KPiA+Pj4+IGluZGV4IGQ4Y2YwMWY3NmFhYi4uYTUwNzA0NWEzZjMwIDEw
MDY0NA0KPiA+Pj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY3RybHMtZGVm
cy5jDQo+ID4+Pj4gKysrIGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJscy1kZWZz
LmMNCj4gPj4+PiBAQCAtMTA0Miw2ICsxMDQyLDcgQEAgY29uc3QgY2hhciAqdjRsMl9jdHJsX2dl
dF9uYW1lKHUzMiBpZCkNCj4gPj4+PiAgY2FzZSBWNEwyX0NJRF9NUEVHX1ZJREVPX1JFRl9OVU1C
RVJfRk9SX1BGUkFNRVM6cmV0dXJuDQo+ID4+Pj4gIlJlZmVyZW5jZQ0KPiA+Pg0KPiA+PiBGcmFt
ZXMgZm9yIGEgUC1GcmFtZSI7DQo+ID4+Pj4gIGNhc2UgVjRMMl9DSURfTVBFR19WSURFT19QUkVQ
RU5EX1NQU1BQU19UT19JRFI6cmV0dXJuICJQcmVwZW5kDQo+ID4+DQo+ID4+IFNQUyBhbmQgUFBT
IHRvIElEUiI7DQo+ID4+Pj4gIGNhc2UgVjRMMl9DSURfTVBFR19NVEtfR0VUX1NFQ1VSRV9IQU5E
TEU6cmV0dXJuICJNZWRpYVRlaw0KPiA+Pj4+IERlY29kZXINCj4gPj4NCj4gPj4gZ2V0IHNlY3Vy
ZSBoYW5kbGUiOw0KPiA+Pj4+ICtjYXNlIFY0TDJfQ0lEX01QRUdfTVRLX1NFVF9TRUNVUkVfTU9E
RTpyZXR1cm4gIk1lZGlhVGVrIERlY29kZXINCj4gPj4NCj4gPj4gc2V0IHNlY3VyZSBtb2RlIjsN
Cj4gPj4+PiAgDQo+ID4+Pj4gIC8qIEFWMSBjb250cm9scyAqLw0KPiA+Pj4+ICBjYXNlIFY0TDJf
Q0lEX01QRUdfVklERU9fQVYxX1BST0ZJTEU6cmV0dXJuICJBVjEgUHJvZmlsZSI7DQo+ID4+Pj4g
QEAgLTE0NDIsNiArMTQ0MywxMCBAQCB2b2lkIHY0bDJfY3RybF9maWxsKHUzMiBpZCwgY29uc3Qg
Y2hhcg0KPiA+Pg0KPiA+PiAqKm5hbWUsIGVudW0gdjRsMl9jdHJsX3R5cGUgKnR5cGUsDQo+ID4+
Pj4gICp0eXBlID0gVjRMMl9DVFJMX1RZUEVfSU5URUdFUjsNCj4gPj4+PiAgKmZsYWdzIHw9IFY0
TDJfQ1RSTF9GTEFHX1dSSVRFX09OTFk7DQo+ID4+Pj4gIGJyZWFrOw0KPiA+Pj4+ICtjYXNlIFY0
TDJfQ0lEX01QRUdfTVRLX1NFVF9TRUNVUkVfTU9ERToNCj4gPj4+PiArKnR5cGUgPSBWNEwyX0NU
UkxfVFlQRV9JTlRFR0VSOw0KPiA+Pj4+ICsqZmxhZ3MgfD0gVjRMMl9DVFJMX0ZMQUdfV1JJVEVf
T05MWTsNCj4gPj4+PiArYnJlYWs7DQo+ID4+Pj4gIGNhc2UgVjRMMl9DSURfVVNFUl9DTEFTUzoN
Cj4gPj4+PiAgY2FzZSBWNEwyX0NJRF9DQU1FUkFfQ0xBU1M6DQo+ID4+Pj4gIGNhc2UgVjRMMl9D
SURfQ09ERUNfQ0xBU1M6DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92
NGwyLWNvbnRyb2xzLmgNCj4gPj4NCj4gPj4gYi9pbmNsdWRlL3VhcGkvbGludXgvdjRsMi1jb250
cm9scy5oDQo+ID4+Pj4gaW5kZXggN2IzNjk0OTg1MzY2Li44OGU5MGQ5NDNlMzggMTAwNjQ0DQo+
ID4+Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3Y0bDItY29udHJvbHMuaA0KPiA+Pj4+ICsr
KyBiL2luY2x1ZGUvdWFwaS9saW51eC92NGwyLWNvbnRyb2xzLmgNCj4gPj4+PiBAQCAtOTU3LDYg
Kzk1Nyw3IEBAIGVudW0gdjRsMl9tcGVnX21mYzUxX3ZpZGVvX2ZvcmNlX2ZyYW1lX3R5cGUNCj4g
ew0KPiA+Pj4+ICAvKiAgTVBFRy1jbGFzcyBjb250cm9sIElEcyBzcGVjaWZpYyB0byB0aGUgTWVk
aWFUZWsgRGVjb2Rlcg0KPiA+Pg0KPiA+PiBkcml2ZXIgYXMgZGVmaW5lZCBieSBWNEwyICovDQo+
ID4+Pj4gICNkZWZpbmUgVjRMMl9DSURfTVBFR19NVEtfQkFTRShWNEwyX0NUUkxfQ0xBU1NfQ09E
RUMgfCAweDIwMDApDQo+ID4+Pj4gICNkZWZpbmUNCj4gPj4NCj4gPj4gVjRMMl9DSURfTVBFR19N
VEtfR0VUX1NFQ1VSRV9IQU5ETEUoVjRMMl9DSURfTVBFR19NVEtfQkFTRSs4KQ0KPiA+Pj4+ICsj
ZGVmaW5lDQo+ID4+DQo+ID4+IFY0TDJfQ0lEX01QRUdfTVRLX1NFVF9TRUNVUkVfTU9ERShWNEwy
X0NJRF9NUEVHX01US19CQVNFKzkpDQo+ID4+Pj4gIA0KPiA+Pj4+ICAvKiAgQ2FtZXJhIGNsYXNz
IGNvbnRyb2wgSURzICovDQo+ID4+Pj4gIA0KPiANCg==
