Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C045771CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjHGI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGI7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:59:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83678E6C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:59:18 -0700 (PDT)
X-UUID: ae372d04350011ee9cb5633481061a41-20230807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TsH6PhCurKH7AAugnKn2fcsOGOmn+qNo3Y5xiTjKB2g=;
        b=qLqU/jLs7MwqGt+8ycJl1TxVaAlAVe6EFV7GMYxXqQl9weGq/poZGfwSBpv1gWICtk9Y/TgbNe63sjWJL+z8DZ+jaV0MtFlEvRK6NrB6XwqcgbsoiSkWP8wBv2aZJryFpEaClHHSyELW5TZmHC/PqFOhFYCsUY9okxopy3OiVag=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:95408c1a-c19a-406b-aab7-b4bcc2282a34,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.30,REQID:95408c1a-c19a-406b-aab7-b4bcc2282a34,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:1fcc6f8,CLOUDID:a0a6e542-d291-4e62-b539-43d7d78362ba,B
        ulkID:230807165914VND9HJNH,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: ae372d04350011ee9cb5633481061a41-20230807
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1477246254; Mon, 07 Aug 2023 16:59:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Aug 2023 16:59:12 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Aug 2023 16:59:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/NDjbhF/TVxLowFEfSPD9gcSp2sK+UtVV+M7DUVwO+EEDiCNulRUHqCIV4gekel/Wbo3AEQN/zhi8NxzuT+dPZMKTefENrQEBTQFBPIzAVryuzmnq8wuMUOVZSk4WRzKxfpAVwimt1nz0SV2rPaJzFbDy3PERqFnAnvYWg8XY6ZjvMuctaD26SJUCbz8+ef74IMsTuow3rlklP8hp3uBP0jWK4MYqoYbOVhs9IXCYNJFy9SZPdMx506xKsURAXWzRyeyZfdUh9lkRqqiWZ+aW8a6PKPhVQNjszOZMnrrH2AOynsAE2/esl3pxnhLsvhrj5aIEuB0FYZOxBSq+QH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsH6PhCurKH7AAugnKn2fcsOGOmn+qNo3Y5xiTjKB2g=;
 b=gP/yIJbYmm+kbf0Kn8L8zZlYeKWttjO3An7h3W7Lnujhe66UtfYPgohQTwPJP+O/DjA5VUSx026IkhceUktYXWyR1d2r9+KMbgJIEnS9aUrsDIfU6y5N0MfFKV/7k7ODiRT0i4yWUmTn026u2Uhvj5Oha2XlbHRSeEhIAEMkCJVRjUSzpXcu+Xvpb7KPnslU2MmixD+LemYjyzlCxIK6m/KF0b6vqmUPVCG3B/hiqB6ERZbzsbXc33J7s3xLudIuNn4kJaXOL9l4Mmvd/EeJ+oODbKjwlAfu8L+Qhxrfbwyb7IosHGic3lKXnQ5Gyx0aPn1FKy/U/02tVk8sBbppoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsH6PhCurKH7AAugnKn2fcsOGOmn+qNo3Y5xiTjKB2g=;
 b=UhR2XpNsZJ3VRhHGcMtAdbDDU2pZHqqjL9uVKN5glrg+kAFycCXGbiJWdtXAtstYsVsYPgA7S23MHL7QRYPMfguM95Pw6d7Chjjn39XmkHKcftr9+xhRG8DHCuH08xBSQNLjGYVY785F6a/O2rT8kzMWM9c2aBmf86xToQUOidw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7971.apcprd03.prod.outlook.com (2603:1096:820:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 08:59:10 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 08:59:10 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND v4 2/2] drm/mediatek: Fix iommu fault during crtc
 enabling
Thread-Topic: [PATCH RESEND v4 2/2] drm/mediatek: Fix iommu fault during crtc
 enabling
Thread-Index: AQHZyNG+FsizTgWRg0G/DVBCFYkp76/eiTeA
Date:   Mon, 7 Aug 2023 08:59:10 +0000
Message-ID: <10c997127b0d6aa4c94b455f35d2429445d1d31d.camel@mediatek.com>
References: <20230807015110.30579-1-jason-jh.lin@mediatek.com>
         <20230807015110.30579-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20230807015110.30579-3-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7971:EE_
x-ms-office365-filtering-correlation-id: e2a550c8-3a27-4117-004f-08db9724906a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: olGsjbddG9KVd3/3lKjbUwfAmrZaD33H9DdqUNMwN+Cd4TvvvojiC1e+xLcMjkfTj8vg99ZJywwSyG3ixD9Pqv0cJPjTP1I6Jn+EsJfWbjRj838jZ8UDXdV+JIHxmVrD/US5hyJam1PM51nhOOCayIoVB3AM/pX66SWFORp6xKNeoyuMcX7RYOagIw7wDtrPK90YQLZXQAZ/9+pe2K3u5IjcydfXJlm4/Rcwf5kHG4EvpyShqu6ewm9SkmGFI1Ri5OEb4uzVmtd0qQi8ZiysZBq8UajO4aZUqQtvhU8kMzwxFGfFsTsyUl26mQ18CB/evxxq/7KbI21+j/3x/FJa1wT8stZcCwCzUcJ8peYqzKpWXhGqrMzcyHAEFsmZ8gY5CaQBEdapHQq8medDQsASDyGVVIcYplV9kRhHRzCZbEeNFcZDyAMWpTKNrfPib7QyxcltyKhaTTrAuitUCVA4SqYwtiQ9yX30pj1PZ1t3BPCU0DzqVGJ0qwtkau70Ndc0I2OD8c3tOcveC5Hl7WpNDwubACv7UzsOMAixH83ItikvO3pRWnEdYQb6GZAaYSCE7SfY2PxDNfVKAbCUVsCsU3yI9JFcNy/gXxEhAQIM7Lx4OVM8N2dlApWZjbvprmmRfmuv6dCis+Tgt0y4q5yI6mPBWAA0oa2ULixdolPiAZn09u0eL/rgN+Qw8Lgk//iAdZhrvhBuu1bpUPgLHwsZnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(376002)(396003)(186006)(1800799003)(451199021)(12101799016)(122000001)(38100700002)(5660300002)(36756003)(85182001)(2906002)(38070700005)(4326008)(76116006)(6512007)(86362001)(26005)(66946007)(66446008)(41300700001)(66556008)(2616005)(8676002)(8936002)(64756008)(83380400001)(316002)(66476007)(6486002)(54906003)(6506007)(71200400001)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1lUQlF2M1h5YStCcmEwOFZERFBmWnczeHAxZG1DQWhtYW5RMXRrTUpQeHNm?=
 =?utf-8?B?QWVOS1VTNjhtZmZPcVpBVm9hbHRLZWtlYzVINzhtWUpJaDd3bXBCMDFDYzhT?=
 =?utf-8?B?eGRtbUVIb2hzeVpPVEZOT3ByenFiR1hreHZUVzRiUHhTd0NKRVlsNE1aK3lG?=
 =?utf-8?B?MVJxMWNkNFY2cHBJSkUySzNOU3A2Q2RpUzVzalppZWJlSUlMdWpMTGhuVTl1?=
 =?utf-8?B?QWg2djZHM1NJK1UwdmR3V0hwRm5xbDEydGRmSGVjK1h2SFVGVEJ2VzZmdlhR?=
 =?utf-8?B?QUZiazAyZjFBZ1Z3K3RRaStoQk9iNTUrUWIzUGNkR3phQkhGSk9wUmdsRDRY?=
 =?utf-8?B?ZGJITUg3V0haTW5CY2hyMGZjckpQUUZYenhzY0J3VTBrSkdlYXdwTmw1Njlh?=
 =?utf-8?B?SldaSWFTWGVmTGRMMXlKdkh5SnB3NUF3dzEwdFFPOUtMQTRFWmdxYnJXY0cr?=
 =?utf-8?B?TmptT2VVSmVBbXh4ZXZkWEpJb3MrdnY5SFMvSXhYMnZYSEZhWDdWcDhVWW9F?=
 =?utf-8?B?UW5zZlZiSUJ5bk9KMmZLeWZ6eFdUWmRadXNKMVBZbXRjbVd6Z2trRmNDdXRN?=
 =?utf-8?B?RkpIUmUvYS94K3J6M055WnRhaGl4WGVyaTVpMHFDTlNkMVpxQk1Ma1hBR0ps?=
 =?utf-8?B?UUkzN0RjbVMvWTJMN1NMMVNQeko1cWkyWmlEaUFzZTdCSWxnazdHeFlkZk1P?=
 =?utf-8?B?T3J2SmF3c0piQnZQd2hyUmhiaGJHTGhNYXFBY3VWK0xRN1ZpcDhlV0t1V0lv?=
 =?utf-8?B?eGhSMjc0TE9Da1Y4SjhIZ244d0lBYUtNanhCS0x4SVZvS0FJUWxOSWN3bWVs?=
 =?utf-8?B?OGtGT0VxUFd3WGFaZzJaWWFRdnlVTkhaaGNueTFWM1ZWQ1FxM2d3NmhjS01t?=
 =?utf-8?B?Y1luMi9RZEVwYWFZeEdvM29yalJnYjlHeDdWUHhKNU13WXk3R2dpSHNTYkVB?=
 =?utf-8?B?amYwc1gxRnJOZDB3TmFYbXRBcHIzcXh1NENJS0hkd0J5TjB5Z3l0dXFXUTVx?=
 =?utf-8?B?KzFQR1Q0U0w0eC9VU1ppV255YlVPYjJGYVJWQWNxK3VRZWFJdU1NdERCUklB?=
 =?utf-8?B?SXdIbE1hSm1tSnR2ZDluemhvcTFEZFJDc1p1MHQrcGN6ODMyNXZOby9ZNkxE?=
 =?utf-8?B?TEVPSncrMDNzV0FJblI1Z0VCNG1oQy9xU05OUk9EbXVmMUJJcTl1NVZ2ZUR6?=
 =?utf-8?B?TFhuTHpJNjVja0QwaUpBd2lpMlduUVduNTdQQXpDb1gvS3JjRVd1N2FrcTli?=
 =?utf-8?B?YnIvaGdZUWRIeXJGQmFPOTVJalJtRVJ0djdCSUNQZVhmTFhtNVBnVWZJSEpz?=
 =?utf-8?B?YXNUT1IzZDJNaW5oSzhtdGZMYnBhTlF6RVgxL2tVQWVibnd6blkvMHJSTzVn?=
 =?utf-8?B?Ry9mbHBScjIxR203Qk1wMFY0eUd3a3FFbGFVcC8ycnRxRDZsR2xRdzIyMk02?=
 =?utf-8?B?OXZQQ2NFVjRwbDZyT25BVitaTk5UYzdiQWpzSWl4MExhaVhPazlFQjA1MW9h?=
 =?utf-8?B?UHppMGxiT2h5TWtXWFdaRDczUG5ZaVgyVDFGUkMrVGNXVTM5d2djSkdxbEJD?=
 =?utf-8?B?N1NseDZtQW9KVkl1ZUNqKzZNTkpPeVFhQjROSmM5MjhQMm0ybjlaUWpQRWor?=
 =?utf-8?B?UnJTRWZ4YWhDSEdjUDZlQk9UY083WjliaWxRT3FVeit4RnFRdi9oaTJpQ2M1?=
 =?utf-8?B?Z0g1THhxdjRZVXg3SUV4dUhtMjJJYzd6eU80Wjg5U21QZ01MS1FJcDZ1d01l?=
 =?utf-8?B?NUx3NXFOamhhSzJlZEZaWUZFY3ZXTGpGdkptQlVLWmkzVzJzRmVFMHVCUnhs?=
 =?utf-8?B?Ry9yVjBDTFhLMmVOdjlRZ3htOFAycElya25jWG9DZGhpMjVlcWY0eU01S3BZ?=
 =?utf-8?B?Ykk2dXBFSVNySVZxNThzcnJXMlNoUDc3L21GbDJIODVIT2doeE5QTWVrRVBG?=
 =?utf-8?B?aWdrWVlhWWhZK29hZ29MK3NnamJFOWpJMkJJZ2pkcVVZRE9YSTlhcmc5Risw?=
 =?utf-8?B?UEUzVGFEQkh4V0NqTlJBM3NOYWhzNUtMTTcxRWpNUnl2N1gzci9BRXovQ3hq?=
 =?utf-8?B?OWdtMW1RRk9pV0hNRDJlV0UwMzYyMGJLRHZpYmJka2kzZmdWUnpWTXFhWERZ?=
 =?utf-8?Q?QaE/fjgXusS4XVqZoxBFawNpV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63E67616145CD84C8EC83B197E4EC0CF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a550c8-3a27-4117-004f-08db9724906a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 08:59:10.0327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddZ38aSpJza5CB09F46GLu6Bavpzfwl7KAhPPIcEwdjqX1hiiMEzSgf9AGxDQIfXnvxV6qGXSTLPbbZmBjZdTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7971
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjMtMDgtMDcgYXQgMDk6NTEgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVGhlIHBsYW5lX3N0YXRlIG9mIGRybV9hdG9taWNfc3RhdGUgaXMgbm90
IHN5bmMgdG8gdGhlDQo+IG10a19wbGFuZV9zdGF0ZQ0KPiBzdG9yZWQgaW4gbXRrX2NydGMgZHVy
aW5nIGNydGMgZW5hYmxpbmcuDQo+IA0KPiBTbyB3ZSBuZWVkIHRvIHVwZGF0ZSB0aGUgbXRrX3Bs
YW5lX3N0YXRlIHN0b3JlZCBpbiBtdGtfY3J0YyBieSB0aGUNCj4gZHJtX2F0b21pY19zdGF0ZSBj
YXJyaWVkIGZyb20gbXRrX2RybV9jcnRjX2F0b21pY19lbmFibGUoKS4NCj4gDQo+IFdoaWxlIHVw
ZGF0aW5nIG10a19wbGFuZV9zdGF0ZSwgT1ZMIGxheWVyIHNob3VsZCBiZSBkaXNhYmxlZCB3aGVu
IHRoZQ0KPiBmYg0KPiBpbiBwbGFuZV9zdGF0ZSBvZiBkcm1fYXRvbWljX3N0YXRlIGlzIE5VTEwu
DQo+IA0KPiBGaXhlczogMTE5ZjUxNzM2MjhhICgiZHJtL21lZGlhdGVrOiBBZGQgRFJNIERyaXZl
ciBmb3IgTWVkaWF0ZWsgU29DDQo+IE1UODE3My4iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1K
SC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiBDaGFuZ2UgaW4gUkVT
RU5EIHY0Og0KPiBSZW1vdmUgcmVkdW5kYW50IHBsYW5lX3N0YXRlIGFzc2lnbmluZy4NCj4gLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgIHwgMTQgKysrKysr
KysrKy0tLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMgfCAx
MSArKysrKysrKy0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUu
aCB8ICAyICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+
IGluZGV4IGQ0MDE0Mjg0MmY4NS4uN2RiNGQ2NTUxZGE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC0zMjgsNyArMzI4LDcgQEAgc3RhdGljIHZv
aWQgZGRwX2NtZHFfY2Ioc3RydWN0IG1ib3hfY2xpZW50ICpjbCwNCj4gdm9pZCAqbXNzZykNCj4g
IH0NCj4gICNlbmRpZg0KPiAgDQo+IC1zdGF0aWMgaW50IG10a19jcnRjX2RkcF9od19pbml0KHN0
cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0KPiArc3RhdGljIGludCBtdGtfY3J0Y19kZHBf
aHdfaW5pdChzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YywNCj4gc3RydWN0IGRybV9hdG9t
aWNfc3RhdGUgKnN0YXRlKQ0KPiAgew0KPiAgCXN0cnVjdCBkcm1fY3J0YyAqY3J0YyA9ICZtdGtf
Y3J0Yy0+YmFzZTsNCj4gIAlzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yOw0KPiBAQCAt
NDA1LDExICs0MDUsMTcgQEAgc3RhdGljIGludCBtdGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1Y3QN
Cj4gbXRrX2RybV9jcnRjICptdGtfY3J0YykNCj4gIAkvKiBJbml0aWFsbHkgY29uZmlndXJlIGFs
bCBwbGFuZXMgKi8NCj4gIAlmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmxheWVyX25yOyBpKysp
IHsNCj4gIAkJc3RydWN0IGRybV9wbGFuZSAqcGxhbmUgPSAmbXRrX2NydGMtPnBsYW5lc1tpXTsN
Cj4gLQkJc3RydWN0IG10a19wbGFuZV9zdGF0ZSAqcGxhbmVfc3RhdGU7DQo+ICsJCXN0cnVjdCBk
cm1fcGxhbmVfc3RhdGUgKm5ld19zdGF0ZTsNCj4gKwkJc3RydWN0IG10a19wbGFuZV9zdGF0ZSAq
cGxhbmVfc3RhdGUgPQ0KPiB0b19tdGtfcGxhbmVfc3RhdGUocGxhbmUtPnN0YXRlKTsNCj4gIAkJ
c3RydWN0IG10a19kZHBfY29tcCAqY29tcDsNCj4gIAkJdW5zaWduZWQgaW50IGxvY2FsX2xheWVy
Ow0KPiAgDQo+IC0JCXBsYW5lX3N0YXRlID0gdG9fbXRrX3BsYW5lX3N0YXRlKHBsYW5lLT5zdGF0
ZSk7DQo+ICsJCS8qIHN5bmMgdGhlIG5ldyBwbGFuZSBzdGF0ZSBmcm9tIGRybV9hdG9taWNfc3Rh
dGUgKi8NCj4gKwkJaWYgKHN0YXRlLT5wbGFuZXNbaV0ucHRyKSB7DQo+ICsJCQluZXdfc3RhdGUg
PQ0KPiBkcm1fYXRvbWljX2dldF9uZXdfcGxhbmVfc3RhdGUoc3RhdGUsIHN0YXRlLT5wbGFuZXNb
aV0ucHRyKTsNCg0KZm9yX2VhY2hfbmV3X3BsYW5lX2luX3N0YXRlKCk/DQoNCj4gKwkJCW10a19w
bGFuZV91cGRhdGVfbmV3X3N0YXRlKG5ld19zdGF0ZSwNCj4gcGxhbmVfc3RhdGUpOw0KPiArCQl9
DQo+ICsNCj4gIAkJY29tcCA9IG10a19kcm1fZGRwX2NvbXBfZm9yX3BsYW5lKGNydGMsIHBsYW5l
LA0KPiAmbG9jYWxfbGF5ZXIpOw0KPiAgCQlpZiAoY29tcCkNCj4gIAkJCW10a19kZHBfY29tcF9s
YXllcl9jb25maWcoY29tcCwgbG9jYWxfbGF5ZXIsDQo+IEBAIC02ODcsNyArNjkzLDcgQEAgc3Rh
dGljIHZvaWQgbXRrX2RybV9jcnRjX2F0b21pY19lbmFibGUoc3RydWN0DQo+IGRybV9jcnRjICpj
cnRjLA0KPiAgCQlyZXR1cm47DQo+ICAJfQ0KPiAgDQo+IC0JcmV0ID0gbXRrX2NydGNfZGRwX2h3
X2luaXQobXRrX2NydGMpOw0KPiArCXJldCA9IG10a19jcnRjX2RkcF9od19pbml0KG10a19jcnRj
LCBzdGF0ZSk7DQo+ICAJaWYgKHJldCkgew0KPiAgCQlwbV9ydW50aW1lX3B1dChjb21wLT5kZXYp
Ow0KPiAgCQlyZXR1cm47DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9wbGFuZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxh
bmUuYw0KPiBpbmRleCBiMWE5MThmZmU0NTcuLmVmNDQ2MGY5OGMwNyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IEBAIC0xMzQsOCArMTM0LDggQEAg
c3RhdGljIGludCBtdGtfcGxhbmVfYXRvbWljX2FzeW5jX2NoZWNrKHN0cnVjdA0KPiBkcm1fcGxh
bmUgKnBsYW5lLA0KPiAgCQkJCQkJICAgdHJ1ZSwgdHJ1ZSk7DQo+ICB9DQo+ICANCj4gLXN0YXRp
YyB2b2lkIG10a19wbGFuZV91cGRhdGVfbmV3X3N0YXRlKHN0cnVjdCBkcm1fcGxhbmVfc3RhdGUN
Cj4gKm5ld19zdGF0ZSwNCj4gLQkJCQkgICAgICAgc3RydWN0IG10a19wbGFuZV9zdGF0ZQ0KPiAq
bXRrX3BsYW5lX3N0YXRlKQ0KPiArdm9pZCBtdGtfcGxhbmVfdXBkYXRlX25ld19zdGF0ZShzdHJ1
Y3QgZHJtX3BsYW5lX3N0YXRlICpuZXdfc3RhdGUsDQo+ICsJCQkJc3RydWN0IG10a19wbGFuZV9z
dGF0ZQ0KPiAqbXRrX3BsYW5lX3N0YXRlKQ0KPiAgew0KPiAgCXN0cnVjdCBkcm1fZnJhbWVidWZm
ZXIgKmZiID0gbmV3X3N0YXRlLT5mYjsNCj4gIAlzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKmdlbTsN
Cj4gQEAgLTE0Niw2ICsxNDYsMTEgQEAgc3RhdGljIHZvaWQgbXRrX3BsYW5lX3VwZGF0ZV9uZXdf
c3RhdGUoc3RydWN0DQo+IGRybV9wbGFuZV9zdGF0ZSAqbmV3X3N0YXRlLA0KPiAgCWRtYV9hZGRy
X3QgaGRyX2FkZHIgPSAwOw0KPiAgCXVuc2lnbmVkIGludCBoZHJfcGl0Y2ggPSAwOw0KPiAgDQo+
ICsJaWYgKCFmYikgew0KPiArCQltdGtfcGxhbmVfc3RhdGUtPnBlbmRpbmcuZW5hYmxlID0gZmFs
c2U7DQo+ICsJCXJldHVybjsNCj4gKwl9DQoNClRoaXMgc2VlbXMgZG9uZSBpbiBtdGtfcGxhbmVf
YXRvbWljX3VwZGF0ZSgpLCBzbyB5b3UgbWF5IGNhbGwNCm10a19wbGFuZV9hdG9taWNfdXBkYXRl
KCkgaW5zdGVhZCBvZiBtdGtfcGxhbmVfdXBkYXRlX25ld19zdGF0ZSgpLg0KDQpSZWdhcmRzLA0K
Q0sNCg0KPiArDQo+ICAJZ2VtID0gZmItPm9ialswXTsNCj4gIAltdGtfZ2VtID0gdG9fbXRrX2dl
bV9vYmooZ2VtKTsNCj4gIAlhZGRyID0gbXRrX2dlbS0+ZG1hX2FkZHI7DQo+IEBAIC0xODAsNyAr
MTg1LDcgQEAgc3RhdGljIHZvaWQgbXRrX3BsYW5lX3VwZGF0ZV9uZXdfc3RhdGUoc3RydWN0DQo+
IGRybV9wbGFuZV9zdGF0ZSAqbmV3X3N0YXRlLA0KPiAgCQkgICAgICAgZmItPmZvcm1hdC0+Y3Bw
WzBdICogKHhfb2Zmc2V0X2luX2Jsb2NrcyArIDEpOw0KPiAgCX0NCj4gIA0KPiAtCW10a19wbGFu
ZV9zdGF0ZS0+cGVuZGluZy5lbmFibGUgPSB0cnVlOw0KPiArCW10a19wbGFuZV9zdGF0ZS0+cGVu
ZGluZy5lbmFibGUgPSBuZXdfc3RhdGUtPnZpc2libGU7DQo+ICAJbXRrX3BsYW5lX3N0YXRlLT5w
ZW5kaW5nLnBpdGNoID0gcGl0Y2g7DQo+ICAJbXRrX3BsYW5lX3N0YXRlLT5wZW5kaW5nLmhkcl9w
aXRjaCA9IGhkcl9waXRjaDsNCj4gIAltdGtfcGxhbmVfc3RhdGUtPnBlbmRpbmcuZm9ybWF0ID0g
Zm9ybWF0Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
cGxhbmUuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmgNCj4g
aW5kZXggOTlhZmY3ZGEwODMxLi4wYTdkNzBkMTNlNDMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fcGxhbmUuaA0KPiBAQCAtNDYsNiArNDYsOCBAQCB0b19tdGtfcGxh
bmVfc3RhdGUoc3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqc3RhdGUpDQo+ICAJcmV0dXJuIGNvbnRh
aW5lcl9vZihzdGF0ZSwgc3RydWN0IG10a19wbGFuZV9zdGF0ZSwgYmFzZSk7DQo+ICB9DQo+ICAN
Cj4gK3ZvaWQgbXRrX3BsYW5lX3VwZGF0ZV9uZXdfc3RhdGUoc3RydWN0IGRybV9wbGFuZV9zdGF0
ZSAqbmV3X3N0YXRlLA0KPiArCQkJCXN0cnVjdCBtdGtfcGxhbmVfc3RhdGUNCj4gKm10a19wbGFu
ZV9zdGF0ZSk7DQo+ICBpbnQgbXRrX3BsYW5lX2luaXQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwg
c3RydWN0IGRybV9wbGFuZSAqcGxhbmUsDQo+ICAJCSAgIHVuc2lnbmVkIGxvbmcgcG9zc2libGVf
Y3J0Y3MsIGVudW0gZHJtX3BsYW5lX3R5cGUNCj4gdHlwZSwNCj4gIAkJICAgdW5zaWduZWQgaW50
IHN1cHBvcnRlZF9yb3RhdGlvbnMsIGNvbnN0IHUzMg0KPiAqZm9ybWF0cywNCg==
