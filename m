Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9947880AD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjHYHLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241914AbjHYHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:11:19 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E8D1FEC;
        Fri, 25 Aug 2023 00:11:05 -0700 (PDT)
X-UUID: 889be548431611eeb20a276fd37b9834-20230825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wXMKz09eWY1DUv4NyUezqG65ZgyfjPnGr9lPyqhvmHo=;
        b=DlhraF/6TA6mUSIVlAyYzn8wqj5HXGZPVgDR8vwtK1o9JVxogGThwTm45pHV1eDDI3aH8mqpVXzGGsZ9cNN9GwQ/WnGR0gC7w99q1cY8niWAUYAukfCBaR33sdC/cLFOHJCLyirNTEbMfwDIIOgIjU89D7/9bWxZa7/TPhuUuCU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:7e4d53d3-e176-4d07-9f9c-b557fb60bedf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:38d143c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 889be548431611eeb20a276fd37b9834-20230825
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sharp.xia@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 549131379; Fri, 25 Aug 2023 15:10:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Aug 2023 15:10:54 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Aug 2023 15:10:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVQk66JunQ2/vp6P8ZnNIIcLk5P9leg18i2d3HizkrTIB3v82k1vu/aHe6hbuC+UByHiz5BToVcC2A0LoDJ7EZp4JDZkvDKR8mgf6YISL70TzFRSm28sn+0LBSkZH41KfyFcG7qJSii/WGpxhS01sH3VlM9kzIo4E/6C46eh5a3V0as59wcJHQK8NvwPLsRdgvHC7hPXimCymOJfIin1tdFn37HA/vB4FkQEjTA5K2Eddp1cVWEWFZAioNdAAiIvVZ/7lSrlQGZnGUpoUdHOpn7lfvGMC5f8Eck6KTLKbHzdhkG/uAqGLWkxXoTpW+ayObIDbLw0+pGU7zDn46cYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXMKz09eWY1DUv4NyUezqG65ZgyfjPnGr9lPyqhvmHo=;
 b=g1ntm7cpCxlY50YvpUPBsLHlCz/9YsbdSigfJp6iVlqkNaEEeoefxo0tERE7muXgZaVI4EOEk6AeDpZXrjkTm++tlf902HH4QrthKv0YSs9F6kLtMebfudO0xPxtICksT2OU2UNxI6XsHTO+xJlzCrmo06gljmJAVAYbYxpeGjNAUDsTbeDOw1h49huqJTzppR2Geo0Usc7iYAnGVobwqixtvLODj9xWHHRk9jCqy23vGxaS5Jya+fyxp3trCuQ1ZETNzZLY+vXPO/XoN8c8v3+hihcP1SPTd50RQ53yBY7WzRyaMelMD4MDTZrVX1cS/UAECms1LAhUk+gUErAWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXMKz09eWY1DUv4NyUezqG65ZgyfjPnGr9lPyqhvmHo=;
 b=ffBthg7yHI6rL+baaxpYgapwPFD7hwYXnXLd3S8M8AUR1KhC33jKseCpGexjOxkFcd/w+OfUXn3f7t8EyysQKJMSl2A6to5jWCFN/5+f+s9+4bQdC6B7unjMuVI2O6bJBn0aJJ+n93w0ygPutOPS5XxBvfo/HpgiDDsdNagIU7U=
Received: from SG2PR03MB6585.apcprd03.prod.outlook.com (2603:1096:4:1d6::7) by
 TYZPR03MB7846.apcprd03.prod.outlook.com (2603:1096:400:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 07:10:50 +0000
Received: from SG2PR03MB6585.apcprd03.prod.outlook.com
 ([fe80::d979:9114:c5e2:d40e]) by SG2PR03MB6585.apcprd03.prod.outlook.com
 ([fe80::d979:9114:c5e2:d40e%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 07:10:50 +0000
From:   =?utf-8?B?U2hhcnAgWGlhICjlpI/lroflvawp?= <Sharp.Xia@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
Thread-Topic: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
Thread-Index: AQHZ0X4bQGWGKv+wY0Gyx8yF1gT/66/5T/qAgAFO3YA=
Date:   Fri, 25 Aug 2023 07:10:50 +0000
Message-ID: <f71672cc699900b57d257c56b325e185f2b6fdd9.camel@mediatek.com>
References: <20230818022817.3341-1-Sharp.Xia@mediatek.com>
         <CAPDyKFqN0K=2e4rijUBz=9LXVfhEVvDzNgqXTyTgvaPRK-PBNQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqN0K=2e4rijUBz=9LXVfhEVvDzNgqXTyTgvaPRK-PBNQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6585:EE_|TYZPR03MB7846:EE_
x-ms-office365-filtering-correlation-id: 3cfb887e-e1b5-492d-b396-08dba53a69ea
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +LQ7i8HC7htYOryJE1UWa314JeAZHxmn/6npNQ8bsf/xbFfFEpJH+d74ROSwN2MzmKtO/e7jbP19XFh4VXVGYHb7FKjhXj6cJuCzVRmQyfk1DDJEHzsqYIai9H/+XVtBt/q9izET8lwZsWCMt3hKYgJCRcQgjSGTRwoLawNE4LTVtEQ2fk81x/WSuDoaEsdvOU8EOqzl7NbEZMfuM0/NezAg3Ez+5tciGcsXfyu0wUIvc6PxOlPxVNs3NAM8wxaVpzO3/9oasccNQhUjnu6QMtwlzz60Lvqq3XUXw3EewpQUQ5aOygSVcQcnH0hibopaGfknjCjOhd6Z5ZovC+q/QvOPbC+crOk50iI7t1oCwhTmPm6KGbKp48LPjDra2RXRwFmqRl6BArZsJjnI0fSMDPgkV3T7iwD1MEZsNGa9r0uyHtEL9sq6empmDJBxiBxxphx53FA/oUL6LbrHc4oAMIgWpMoFtKzwEulWU85hRxHxk6o0MjP58Eja08sPC3koaKuTsrhRgBj6DfYeKTfZe72vKYmAzqOUbYGNPlHpPLaRp+MAFJLDLpMRzQqv9UrdbY2O6h028ae00S0Owx3QSuBo5odYWcNVg3kVwNJGRbnlZo/KuOwxJ2xQvv5tOJbWclLx0IZge7H0RFt6Oih9T7TB5KQ/Hl8bKYv7F2+f1Dnbf9HVC6Xq4SA6sLT2I3gpLgffla4pBUNKbGshafmZ6gvutXKh6jjhvaWqmAeWd8E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6585.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(186009)(1800799009)(451199024)(2616005)(5660300002)(4326008)(8936002)(8676002)(85182001)(36756003)(83380400001)(2906002)(26005)(71200400001)(38100700002)(38070700005)(6916009)(122000001)(66946007)(66556008)(64756008)(66446008)(54906003)(76116006)(66476007)(316002)(91956017)(478600001)(12101799020)(41300700001)(6506007)(6512007)(86362001)(6486002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1MvNmliUmRkNFlGaUlrMmhPQzRmVXpLTThkWlBRaEtvV3dHVG54MTBYb2R4?=
 =?utf-8?B?YmNGQVFvZ2I5U2xkRlhpVnVlYnNOT29xaVdPRmx0RTVUWnlORUNXZ3BLMWps?=
 =?utf-8?B?QTVzQ05DWEQxWVlBWnQzV3J1SWY2SXE3WVY0cnBPblV4OENJSTFnMTErMCtB?=
 =?utf-8?B?WXoyQlAvVU04ZHh6bzBqTXBwZnZJV2lWMSsrbE1mN2JDUWhLZnRHRStBTW9j?=
 =?utf-8?B?a04vR2lFbGpuRXhMUXByRzZzQ1AvRU1vaTZjRk0xVk5kUmc2ZFIyQldwd2pu?=
 =?utf-8?B?K2l4Vk9xeHQ0UHFKSkpTOXozWTRMbW5MSlNlU003MU94MlRNMmFmYWtPbmdn?=
 =?utf-8?B?bjg5cVVJUDFQTDluTHpob3I2UWRFUmxNYm9QcmtLdUxrc3RWSkRnZndHeCt3?=
 =?utf-8?B?b2U3cDJGWTRxOEpVT0RxQW5xMVc3dkEwVFJybG1RYUpiRTVabUJPQUZkeW1Q?=
 =?utf-8?B?bFhhZTZXcXR0QlFpWGdhY2dnc3F0dHNCQ1lodmdUNE1xWVhuVk1wVUJZMyti?=
 =?utf-8?B?Y0R0ZjFQdDRMUy9mcmFZaU1FOG1vTzlMdC9aWDNJT1JKM3hYcG5qWGZWVFV0?=
 =?utf-8?B?QXNwYmdCQis0K2YyNGlia2d4b2NWU2pNSFQrdjQxZVJPWVcxeU4vRWFZZVhZ?=
 =?utf-8?B?cXN3UEh5NFhzTXEwanlhTk04bHB6dEo5SVdGNzI4NzlIT3RWQndwbUlRaTlu?=
 =?utf-8?B?OEZqVU05TjdZenA2T2Q1UFN5U3BGZHc4ZW1ZUHpycHdxTk1FWkFIUk1zWWVV?=
 =?utf-8?B?eXoyYVYrV2puUFNzNmdZMEZEV2hxSlkvblJ1d3NkU0VUWGtUdDJrSzY3UzVR?=
 =?utf-8?B?RTVKYWFqMHhjZSswRnBNc2tPQi9pVlM2bldNU29NNXlLTlNrT3FTT0UyNVhl?=
 =?utf-8?B?UHhIRkh2OHpRK0RFWWMxeXJrNU1ZMDdwMVc1dVJsc2tpT0dHOEVMUTVvM2l6?=
 =?utf-8?B?Wm1QMTNGVy95OGsxcEtuZXVYdnk4MkJ5bDNFcFRSRzFPNkJjTDJULzNkYW9x?=
 =?utf-8?B?b0FUdWx2S3VFMmlEdnZuaDIxbnVRd2djM2lhdzlLckRDMDFsUGZtK0hKY3I0?=
 =?utf-8?B?anpWbjF1NGdWSkNTcjU3YjhjVUF5aVRkUFExV0FhNGZBc1AvbTU4MndxU1Jn?=
 =?utf-8?B?eEJUeElFVEVVK0JzTkhPdmZ1TnlKLzRRL1huMTFoWlJ3VSsvTFdiQnZtMTVQ?=
 =?utf-8?B?cWtUU1o3M1ZtUnlWVzEzUE5yYkdrVkMrQlViOUE5Q3o4RUZTV28xQzVRQk1o?=
 =?utf-8?B?bk85aTZRc2o5WFp0V2ZnSkR4cnJub0drZVhsUmlmVThjN25Wa0NjM1p3UmZQ?=
 =?utf-8?B?VS80cXNyalFWaEY3R3J6Q3lWQlJFd1dockhnWmc2OWgzNU5tcnFwNXVZVzlZ?=
 =?utf-8?B?eFZ5L0dqNkw2eWkyTkRkZmZkVVNQbzhwYzViVFFPOUR3cnk3WXZDdkhlSUwy?=
 =?utf-8?B?RVdSQ3RoZm9BL3cvNlJoL2JSbURjT1FCZ1o2MWZzRXFpN0RST0RCdkNCK1pl?=
 =?utf-8?B?R3dUM0pYckJ5UnpOSWxGVmtyUTE3bWoxWGdUTmR3OEMyTnRNc3hldnhiWUlY?=
 =?utf-8?B?YlBGbXlYdVhsWjMxUDIrOVdxRzkxRVNwbW5WL1ZoUjZycEc4WEFNQ2p3aFpa?=
 =?utf-8?B?Z09HeUF1RnNGUEc1NWkzeWc2V25vTEFJOFk4ZU9VV0VyNlhTUS90R1p6THF6?=
 =?utf-8?B?M1ZEWnJkcmgyZEdKTjhnMUtzTlV0Wlc0WC9kNTdNU3RoTXB2bS9JVXVjZzBy?=
 =?utf-8?B?NU9DaUcvdnIxeDAwU296YTY1bUNoMkl3MFczNTNBekxORXlWZmJzQ2VpREpm?=
 =?utf-8?B?SG9YZmQ5N0FoSzArdzliSUhCOHN4WjJpaU4raUVWazZiZWF3MEZFNmxEblZC?=
 =?utf-8?B?UWJ6SllDd1FyOEVTMTFBMUk2TVJGT0Q3L0g2UUEvUVpsaHhNalpDQjI3UExI?=
 =?utf-8?B?bnBvNEg2aWlFY2hiSTFud01ZN2QvTGltbmR6ZEhUaWNNZDIzaUtOajRoVzRZ?=
 =?utf-8?B?dWlCVFlnbzBXOHRSQ3pNVktDbjVrcUpwZ3dDeTNQa0ZkM3l3ZFBRdVZ1LzZy?=
 =?utf-8?B?a200dUkxU3NiK2hDVDJ4cGcva1ZEWUhuTXNJTnJEMDdmKzcrY0xxdGFDS3px?=
 =?utf-8?B?aEwrS3ZCMk9oUWpydXNnWXRvTDR4eWp0dTk5UGMyK1RpN3lWOEY0WE85U1o4?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1C28FD61E93524BB7FA3FC7DF9DD034@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6585.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfb887e-e1b5-492d-b396-08dba53a69ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 07:10:50.6659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECHi+lddQySVWSAXawqZWKw5iCBpDA2MywHvvE8MCTopH1iIlPEsXfsY3JbwoZyAK8AgcfrzCKbPr6t3jcTPBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7846
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

T24gVGh1LCAyMDIzLTA4LTI0IGF0IDEyOjU1ICswMjAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBGcmksIDE4IEF1ZyAyMDIzIGF0IDA0OjQ1LCA8U2hhcnAuWGlhQG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBTaGFycCBYaWEgPFNoYXJwLlhpYUBt
ZWRpYXRlay5jb20+DQo+ID4NCj4gPiBNTUMgZG9lcyBub3Qgc2V0IHJlYWRhaGVhZCBhbmQgdXNl
cyB0aGUgZGVmYXVsdCBWTV9SRUFEQUhFQURfUEFHRVMNCj4gPiByZXN1bHRpbmcgaW4gc2xvd2Vy
IHJlYWRpbmcgc3BlZWQuDQo+ID4gVXNlIHRoZSBtYXhfcmVxX3NpemUgcmVwb3J0ZWQgYnkgaG9z
dCBkcml2ZXIgdG8gc2V0IHRoZSBvcHRpbWFsDQo+ID4gSS9PIHNpemUgdG8gaW1wcm92ZSBwZXJm
b3JtYW5jZS4NCj4gDQo+IFRoaXMgc2VlbXMgcmVhc29uYWJsZSB0byBtZS4gSG93ZXZlciwgaXQg
d291bGQgYmUgbmljZSBpZiB5b3UgY291bGQNCj4gc2hhcmUgc29tZSBwZXJmb3JtYW5jZSBudW1i
ZXJzIHRvbyAtIGNvbXBhcmluZyBiZWZvcmUgYW5kIGFmdGVyDQo+ICRzdWJqZWN0IHBhdGNoLg0K
PiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
aGFycCBYaWEgPFNoYXJwLlhpYUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
bW1jL2NvcmUvcXVldWUuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3F1ZXVlLmMgYi9kcml2
ZXJzL21tYy9jb3JlL3F1ZXVlLmMNCj4gPiBpbmRleCBiMzk2ZTM5MDA3MTcuLmZjODNjNDkxNzM2
MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3F1ZXVlLmMNCj4gPiArKysgYi9k
cml2ZXJzL21tYy9jb3JlL3F1ZXVlLmMNCj4gPiBAQCAtMzU5LDYgKzM1OSw3IEBAIHN0YXRpYyB2
b2lkIG1tY19zZXR1cF9xdWV1ZShzdHJ1Y3QgbW1jX3F1ZXVlDQo+ICptcSwgc3RydWN0IG1tY19j
YXJkICpjYXJkKQ0KPiA+ICAgICAgICAgICAgICAgICBibGtfcXVldWVfYm91bmNlX2xpbWl0KG1x
LT5xdWV1ZSwgQkxLX0JPVU5DRV9ISUdIKTsNCj4gPiAgICAgICAgIGJsa19xdWV1ZV9tYXhfaHdf
c2VjdG9ycyhtcS0+cXVldWUsDQo+ID4gICAgICAgICAgICAgICAgIG1pbihob3N0LT5tYXhfYmxr
X2NvdW50LCBob3N0LT5tYXhfcmVxX3NpemUgLw0KPiA1MTIpKTsNCj4gPiArICAgICAgIGJsa19x
dWV1ZV9pb19vcHQobXEtPnF1ZXVlLCBob3N0LT5tYXhfcmVxX3NpemUpOw0KPiA+ICAgICAgICAg
aWYgKGhvc3QtPmNhbl9kbWFfbWFwX21lcmdlKQ0KPiA+ICAgICAgICAgICAgICAgICBXQVJOKCFi
bGtfcXVldWVfY2FuX3VzZV9kbWFfbWFwX21lcmdpbmcobXEtPnF1ZXVlLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbW1jX2Rldiho
b3MNCj4gdCkpLA0KPiA+IC0tDQo+ID4gMi4xOC4wDQo+ID4NCg0KSSB0ZXN0IHRoaXMgcGF0Y2gg
b24gaW50ZXJuYWwgcGxhdGZvcm0oa2VybmVsLTUuMTUpLg0KDQpCZWZvcmU6DQpjb25zb2xlOi8g
IyBlY2hvIDMgPiAvcHJvYy9zeXMvdm0vZHJvcF9jYWNoZXMNCmNvbnNvbGU6LyAjIGRkIGlmPS9t
bnQvbWVkaWFfcncvODAzMS0xMzBEL3N1cGVyLmltZyBvZj0vZGV2L251bGwNCjQ0ODUzOTMrMSBy
ZWNvcmRzIGluDQo0NDg1MzkzKzEgcmVjb3JkcyBvdXQNCjIyOTY1MjE1NjQgYnl0ZXMgKDIuMSBH
KSBjb3BpZWQsIDM3LjEyNDQ0NiBzLCA1OSBNL3MNCmNvbnNvbGU6LyAjIGNhdCAvc3lzL2Jsb2Nr
L21tY2JsazAvcXVldWUvcmVhZF9haGVhZF9rYg0KMTI4DQoNCkFmdGVyOg0KY29uc29sZTovICMg
ZWNobyAzID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzDQpjb25zb2xlOi8gIyBkZCBpZj0vbW50
L21lZGlhX3J3LzgwMzEtMTMwRC9zdXBlci5pbWcgb2Y9L2Rldi9udWxsDQo0NDg1MzkzKzEgcmVj
b3JkcyBpbg0KNDQ4NTM5MysxIHJlY29yZHMgb3V0DQoyMjk2NTIxNTY0IGJ5dGVzICgyLjEgRykg
Y29waWVkLCAyOC45NTYwNDkgcywgNzYgTS9zDQpjb25zb2xlOi8gIyBjYXQgL3N5cy9ibG9jay9t
bWNibGswL3F1ZXVlL3JlYWRfYWhlYWRfa2INCjEwMjQNCg0K
