Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA017BFB17
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjJJMTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjJJMTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:19:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D486C6;
        Tue, 10 Oct 2023 05:19:03 -0700 (PDT)
X-UUID: 2d6711b4676711ee8051498923ad61e6-20231010
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=p+cVNFQbSS5xahEGzEq+Iyll3mNzqu7j1zEP5t40UEI=;
        b=oI8p3+d8UmYK9Qkd1nzfF3YOp6pIx9oYBKFOseR5RXdvqwTKETadGoUMEvEE+WWA3H2NXXnvUAPUwkGoFjshttQ9ut0Jqtsoop/X0eFE/hu94bm/2F303/Al8ZagUBxSHMRTjOcllKSFZazqOUvpA4Y4hTMfKJcLxk/FvaVWlmU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:be4fe2dd-a47c-4d69-9300-7b8c32e36748,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:3debdd14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2d6711b4676711ee8051498923ad61e6-20231010
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 694985767; Tue, 10 Oct 2023 20:18:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 10 Oct 2023 20:18:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 10 Oct 2023 20:18:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmf7zGkC+co0YV1z8R2rpcSJJVhopFhGQVZ96zZHySetD8Fxk1CZI9hGRfqc7xTTiFNvG8KYe/afcuiWnf0AoL/rm5dplS2cFiBW7usGMQvl5lkVQQMZbp8tXWSC9AL8iGYLjP9mtvCz3PzsK2NI9EuxDYZ2eogkPNnxA6N9PUy2LWideLTMZk2jGt7WuIoQwHEJ2x9ln5UN6Nsj2WLwer/24HfnRaAh/+MEe/NRUPk2wUgNdq/kQ+ljrT2H8hOuuIcw+J6sHvvtLo4hKlbHq+AeaPyzcOEmiSGW1khOH0XGF02t4+4GmskvugybtMnfNuguxU7X9tRyjH0Na+BviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+cVNFQbSS5xahEGzEq+Iyll3mNzqu7j1zEP5t40UEI=;
 b=bZP15q7r8MsT6mhQpsLcamBFSb3QlDp6A6mwO3W5sm0py5+Sw0dL+5fC0tUPEf96AnkhodVWZYrBCExxpTOW2SYKj/1/TZipY3eUl9bi7IQw+VCF99s78xhBtchyPQOwR9VrZh4ZYBH6UVu4CcGmz73tmR8fVkM3UNPNneL/qfK8ZJ+P+hOsIcamN3nhtlDGZFqURsZqp7WFcZ/sYXyYFcoV9FocSEseSsOFJuExDhlgy6CzacSOT6Yji2MgtjoFMSnjp5QyAxfsPpF7hqyZ02gKe18eXeS2G8HXd5z5ARLWGs9/7m5SGRpew158ShhvQSp+2JKa4ovtBHUIjbzVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+cVNFQbSS5xahEGzEq+Iyll3mNzqu7j1zEP5t40UEI=;
 b=aCS/VjDJn71a3x7pyy4BHxUFEZXYMHgIZJjAQrlrO+J/zsVMR8DE/sNoYD29ek07hTtP0G99WpN3t/7kCcZb7TkQB6qtCwPB67yI7GxV6WAFirqB+9pPtYHCiGnrVEx9dAKP4tVeZPSq/LIYAfokX6y2PulXjSLTKtuWu+OMqyI=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by PSAPR03MB6249.apcprd03.prod.outlook.com (2603:1096:301:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 12:18:50 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::d451:c5cd:4a93:2a62]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::d451:c5cd:4a93:2a62%4]) with mapi id 15.20.6813.017; Tue, 10 Oct 2023
 12:18:49 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
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
Subject: Re: [PATCH] media: mediatek: vcodec: using encoder device to
 alloc/free encoder memory
Thread-Topic: [PATCH] media: mediatek: vcodec: using encoder device to
 alloc/free encoder memory
Thread-Index: AQHZ+ZZg94Q2rCMFMECi9MbZUpaMiLBBYYYAgAGTJAA=
Date:   Tue, 10 Oct 2023 12:18:49 +0000
Message-ID: <9b19e6cc53881c2259277f2006d589f2030ff4dc.camel@mediatek.com>
References: <20231008031909.32146-1-yunfei.dong@mediatek.com>
         <42fab116-ce4e-b4bb-c457-821a92ff85b6@collabora.com>
In-Reply-To: <42fab116-ce4e-b4bb-c457-821a92ff85b6@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|PSAPR03MB6249:EE_
x-ms-office365-filtering-correlation-id: 76398fd7-87c1-49bb-ff1a-08dbc98b0f4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t4SQzVqX9NN7Kg2rSrKBHr3YWs/GR96jzf6Lh+wZWKnBh6RcJauWOJVIcl1RvnEg+lQ6XSTSxuiuBCFmlS/misX6G6mBxGMLeBK5c+frrRvMbSgoTJe9uMOuANLdMr2TeKwOTjuj2aZRpV/neWfu4yI0VXijG95QtEYl4G0ecLAMOh5A1KimigK7qlY8AQzVDDB4m5QtFuUSNukt3oYi4NL325Lmaz2Zemh1lsOitrs+oR1ycTNzpuU+ayBKUVelj6QMQvhhzOMs5dT9H9t/FSsnRbkdrP3vKFqHgoq9bjj/J5sCBxI6jWqyN7vnDcs6cDkizxRpQpjrb77Lq5lTtQF+e0RyE6/hyX8czEsPXHTkvHRBeFbazlwaNCmFy3nSEPjj+FR/fxc+ViDBNmHKyT1ZlbcXn4JwTUnO7YE+VXptEZi0XsWygG3qpnAwzEEyKMZ4u5SRwhvs/E/kR1Sf7aSp+4gC/kDym4rGO9tkQBDIsUfkKi7lyEubiCyVX+iNYE5s8sWGVxzXonPQlrr46+h8pkGYJtB67YsO3zbgWMBz/AsrABjxlKSBGBjKTGt6B1d+QkeMNnZAFcW6YrZjOxQDKbckJJ9gjmCkFEkjxbd2UmvQ96ISVuAP+VwcQfxlf9oi+rEbtjzjzrLH9mstHCU5t0oG24x0venAVeQ+S4xi2ksG6dRf4f+CBJJDHmZV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6512007)(2616005)(6506007)(478600001)(316002)(41300700001)(6486002)(71200400001)(83380400001)(7416002)(2906002)(66476007)(91956017)(76116006)(66556008)(66446008)(110136005)(5660300002)(54906003)(64756008)(66946007)(8936002)(8676002)(4326008)(26005)(85182001)(38100700002)(38070700005)(36756003)(122000001)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEVxS1JYUXZlVEdaS0ZWWDB0TzJvaUNoY3dYZDV5MDBQNnNlaHFoNHg4R2Fs?=
 =?utf-8?B?WDVOTHhEaW5SWmpuZXpkeURMdTJ4Z3kzNnQ4RU5LTm9GaStxRXhNU3N3MGhq?=
 =?utf-8?B?VTM3cWwzeWV0bks1dTQ4MGF0UXo2WWJHeTE3WHE2eDJ6TG5JbW4yUTZHQnYw?=
 =?utf-8?B?MmlSWTFXbzR6STVKQTBFVlNza0NmWSsvMDF3cG1oVXZ4NEhzRC95eTZEMita?=
 =?utf-8?B?WW1mb0orRmNrUm9zWWdPekpNOFJIT2ZNeXowTVlHSWxRQngxc2s4eWdqem1L?=
 =?utf-8?B?Q1JpMy9qeXhQWEZnWWxnYnNpeFp6VHVONHorYVVvNEFXV3lMN0lPZVl5RGha?=
 =?utf-8?B?UDg4VW1SbXlIUUl0ZUtzMkhDRjJROWhjL2pvRkRwWktVeTBreTQ5SGl1anFM?=
 =?utf-8?B?RktpNHFrQ1ZDTmtSeFRNbnZFR1dBaUtyM3k0SURxUVAvQ1BxQTd6MUJPNGRC?=
 =?utf-8?B?TWpkb2RnNFZia3RkOU43cEI2STEvK1d2WnFtb0NINTV1MWJRMVVwbzJyL3JN?=
 =?utf-8?B?TDNpUDJJTjVEMjRxdGpOWXdvUTdNdVJFZ3FjN082dGpiOGVmQ3M0Z1VCT3J5?=
 =?utf-8?B?NUJwTW9nYWg2cUxOVW5BZEZtVnNQRExnZEphN1RWRk5Bd2tDOXFySnU4cGg0?=
 =?utf-8?B?ZnRZYlJhTFVJSml0K2VFWGxHU0hONHhrSkNZZ0J0dC9GSXN5S0Y5UUxZMUhi?=
 =?utf-8?B?MzR4UXdJNGtqWXhJRUtZTzNja0VESi9wSU8yQlVWczM0djZ5R3MvcHZ1cmlN?=
 =?utf-8?B?S3VKajZiVEsvUVpTdWJjN2p1M2YvSkMzVElLZ3I4R3ROZGlWaXRlaG9iajR3?=
 =?utf-8?B?WkNxUFRnOXB5NUpud1BnenNJa3orbFNtTy9NZm02MDI3djBCQUVqOXVVa0hN?=
 =?utf-8?B?c0hML251YWlJRWtnNUM0eVlZZmJtL0ZnMk5lNlBsR2E1VkpzVlF4MHpLN2Qr?=
 =?utf-8?B?Y3B6VzhNZlRqTGowb3Zjak5kdzVnK3ZyR3FOOEpUSVAzWElpRWg2VW95T1A3?=
 =?utf-8?B?VHRMT1BsUDYxelZTaGkxOGFGOGRWWGRhSFRPSTdkL3lhbE8zL25HMTJUV0Rh?=
 =?utf-8?B?WFdsQXZXZFdPcEk0WW0rMWthQkFhOWZySVdjdGhJS3ZqcFNZYlRiUkdHVHl3?=
 =?utf-8?B?aUN1MWFFM0lHZUlnTngzMkY3dDBoeVBxaFFVdFdDSkNXcnJIMjNDMXRiZTE2?=
 =?utf-8?B?amxlWW9ZQ3haTUtyRGVPMW1KODNTRWZiY1E2allzVXVUOElSUnhpUURqcy9r?=
 =?utf-8?B?RnNvVkxNZWU5REw4YnlYVDlQbnd0SUJxR2gxdzFuR2tqaXhBbDdPaVJHYTRk?=
 =?utf-8?B?RW5LVmY5dTFBMEZmNFRyOUVIb3RzdDNwdXZPUmNUS3BLbDdQM1dQNWNhY2wy?=
 =?utf-8?B?bGwwUnVnUU1FWG5oYS9pZnJha1hZRWxmV0E1d2NRUEtGSTVyaVN2MW8yT2Mx?=
 =?utf-8?B?cWpIbk5VTGpQbGVPOHhnYUdEeWRWMzJrRUx5VDIyZzdzd05RZDVDNkl5RHZa?=
 =?utf-8?B?S0NtNDZ6dStUZ2FLWTRKYVhQNjlRZVEwMW1VbkNjVWtiZlhDWHg2L29pUm5s?=
 =?utf-8?B?cVQ2VmZ5OHRsQmYxK3VaOHFWcWk2WFFNcHZKdFY1bUV5ams1SkFGU0t6TVp1?=
 =?utf-8?B?RUYxREtVUFlRRGFIb1NqZmVSR2V6L3QvQVUzWGkvTGFJL0l6MFoxdldLR001?=
 =?utf-8?B?a2RQNTVHd0lZRzduaVF5ZkpYYmxTUWJnWUxYZG9JOEE0cTljYlgrQ1c3RHQx?=
 =?utf-8?B?VXd6VGE2aW9wWDJzWVBMV3VKNVlXTkp6QXFxU0JJRUZOblVlRStqYi9jWHFB?=
 =?utf-8?B?cEdJd1VVMnVvaHBKZWJUL1BaQzA4aXIwMFFBNEJ6UWVSRTRUcGU4clh3VEx0?=
 =?utf-8?B?YkJRMUVWUmtlc2pWT2JEMWdBNTBGcVZHdWtSMXNzZ3BrQWNJcENZeXcrTnRC?=
 =?utf-8?B?TS9URzlCdTUxTjRFcktVT1gycXZrMFBCMjhNS1l5ZGZhUG56SEZ2NFhLU0hs?=
 =?utf-8?B?VWZ2dXNFSGRIdm92QkFTR2xUMy9PaWV5cXB5a1FxVm1sRVpGRUFUY3ZKZDdm?=
 =?utf-8?B?clg4bWdIVGtSckY1cVlrM0VxNkphWTAwNExoZmpWL1p6bndoOVJKaThiNGFT?=
 =?utf-8?B?Y3FISWxBdEJTR29TWmx6enFkOWxRUm9uTzBtKzNLdmxSdGF0STNyckRkQ2JU?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBED05EA077E084295664C9FA7BAC923@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76398fd7-87c1-49bb-ff1a-08dbc98b0f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 12:18:49.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7uVBZoXASxHt5wsy5PQeBgZEa3dJn4dRcz/OhjBypjtAVE//SXXAchJUHwFr7RSfBEC17pa2d3ljo2TRrC7Hqy/ANO8BQLv+ORIXY/6sRes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6249
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIGFkdmljZS4NCk9uIE1vbiwg
MjAyMy0xMC0wOSBhdCAxNDoxNSArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3Jv
dGU6DQo+IElsIDA4LzEwLzIzIDA1OjE5LCBZdW5mZWkgRG9uZyBoYSBzY3JpdHRvOg0KPiA+IE5l
ZWQgdG8gdXNlIGVuY29kZXIgZGV2aWNlIHRvIGFsbG9jYXRlL2ZyZWUgZW5jb2RlciBtZW1vcnkg
d2hlbg0KPiA+IGNhbGxpbmcNCj4gPiBtdGtfdmNvZGVjX21lbV9hbGxvYy9tdGtfdmNvZGVjX21l
bV9mcmVlLCBvciBsZWFkaW5nIHRvIGJlbG93IGNyYXNoDQo+ID4gbG9nDQo+ID4gd2hlbiB0ZXN0
IGVuY29kZXIgd2l0aCBkZWNvZGVyIGRldmljZS4NCj4gPiANCj4gPiBwYyA6IGRtYV9hbGxvY19h
dHRycysweDQ0LzB4ZjQNCj4gPiBsciA6IG10a192Y29kZWNfbWVtX2FsbG9jKzB4NTAvMHhhNCBb
bXRrX3Zjb2RlY19jb21tb25dDQo+ID4gc3AgOiBmZmZmZmZjMDIwOWYzOTkwDQo+ID4geDI5OiBm
ZmZmZmZjMDIwOWYzOWEwIHgyODogZmZmZmZmODAyNDEwMmExOCB4Mjc6IDAwMDAwMDAwMDAwMDAw
MDANCj4gPiB4MjY6IDAwMDAwMDAwMDAwMDAwMDAgeDI1OiBmZmZmZmZjMDBjMDZlMmQ4IHgyNDog
MDAwMDAwMDAwMDAwMDAwMQ0KPiA+IHgyMzogMDAwMDAwMDAwMDAwMGNjMCB4MjI6IDAwMDAwMDAw
MDAwMDAwMTAgeDIxOiAwMDAwMDAwMDAwMDAwODAwDQo+ID4geDIwOiBmZmZmZmY4MDI0MTAyYTE4
IHgxOTogMDAwMDAwMDAwMDAwMDAwMCB4MTg6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiB4MTc6IDAw
MDAwMDAwMDAwMDAwMDkgeDE2OiBmZmZmZmZlMzg5NzM2YTk4IHgxNTogMDAwMDAwMDAwMDAwMDA3
OA0KPiA+IHgxNDogZmZmZmZmZTM4OTcwNDQzNCB4MTM6IDAwMDAwMDAwMDAwMDAwMDcgeDEyOiBm
ZmZmZmZlMzhhMmIyNTYwDQo+ID4geDExOiAwMDAwMDAwMDAwMDAwODAwIHgxMDogMDAwMDAwMDAw
MDAwMDAwNCB4OSA6IGZmZmZmZmUzMzFmMDc0ODQNCj4gPiB4OCA6IDU0MDBlOWFlZjIzOTUwMDAg
eDcgOiAwMDAwMDAwMDAwMDAwMDAwIHg2IDogMDAwMDAwMDAwMDAwMDAzZg0KPiA+IHg1IDogMDAw
MDAwMDAwMDAwMDAwMSB4NCA6IDAwMDAwMDAwMDAwMDAwMDAgeDMgOiAwMDAwMDAwMDAwMDAwY2Mw
DQo+ID4geDIgOiBmZmZmZmY4MDI0MTAyYTE4IHgxIDogMDAwMDAwMDAwMDAwMDgwMCB4MCA6IDAw
MDAwMDAwMDAwMDAwMTANCj4gPiBDYWxsIHRyYWNlOg0KPiA+ICAgZG1hX2FsbG9jX2F0dHJzKzB4
NDQvMHhmNA0KPiA+ICAgbXRrX3Zjb2RlY19tZW1fYWxsb2MrMHg1MC8weGE0IFttdGtfdmNvZGVj
X2NvbW1vbg0KPiA+IDI4MTlkM2Q2MDFmM2NkMDZjMWYyMjEzYWMxYjk5OTUxMzQ0NDE0MjFdDQo+
ID4gICBoMjY0X2VuY19zZXRfcGFyYW0rMHgyN2MvMHgzNzggW210a192Y29kZWNfZW5jDQo+ID4g
NzcyY2MzZDI2YzI1NGU4Y2Y1NDA3OTQ1MWVmOGQ5MzBkMmViNDQwNF0NCj4gPiAgIHZlbmNfaWZf
c2V0X3BhcmFtKzB4NGMvMHg3YyBbbXRrX3Zjb2RlY19lbmMNCj4gPiA3NzJjYzNkMjZjMjU0ZThj
ZjU0MDc5NDUxZWY4ZDkzMGQyZWI0NDA0XQ0KPiA+ICAgdmIyb3BzX3ZlbmNfc3RhcnRfc3RyZWFt
aW5nKzB4MWJjLzB4MzI4IFttdGtfdmNvZGVjX2VuYw0KPiA+IDc3MmNjM2QyNmMyNTRlOGNmNTQw
Nzk0NTFlZjhkOTMwZDJlYjQ0MDRdDQo+ID4gICB2YjJfc3RhcnRfc3RyZWFtaW5nKzB4NjQvMHgx
MmMNCj4gPiAgIHZiMl9jb3JlX3N0cmVhbW9uKzB4MTE0LzB4MTU4DQo+ID4gICB2YjJfc3RyZWFt
b24rMHgzOC8weDYwDQo+ID4gICB2NGwyX20ybV9zdHJlYW1vbisweDQ4LzB4ODgNCj4gPiAgIHY0
bDJfbTJtX2lvY3RsX3N0cmVhbW9uKzB4MjAvMHgyYw0KPiA+ICAgdjRsX3N0cmVhbW9uKzB4MmMv
MHgzOA0KPiA+ICAgX192aWRlb19kb19pb2N0bCsweDJjNC8weDNkYw0KPiA+ICAgdmlkZW9fdXNl
cmNvcHkrMHg0MDQvMHg5MzQNCj4gPiAgIHZpZGVvX2lvY3RsMisweDIwLzB4MmMNCj4gPiAgIHY0
bDJfaW9jdGwrMHg1NC8weDY0DQo+ID4gICB2NGwyX2NvbXBhdF9pb2N0bDMyKzB4OTAvMHhhMzQN
Cj4gPiAgIF9fYXJtNjRfY29tcGF0X3N5c19pb2N0bCsweDEyOC8weDEzYw0KPiA+ICAgaW52b2tl
X3N5c2NhbGwrMHg0Yy8weDEwOA0KPiA+ICAgZWwwX3N2Y19jb21tb24rMHg5OC8weDEwNA0KPiA+
ICAgZG9fZWwwX3N2Y19jb21wYXQrMHgyOC8weDM0DQo+ID4gICBlbDBfc3ZjX2NvbXBhdCsweDJj
LzB4NzQNCj4gPiAgIGVsMHRfMzJfc3luY19oYW5kbGVyKzB4YTgvMHhjYw0KPiA+ICAgZWwwdF8z
Ml9zeW5jKzB4MTk0LzB4MTk4DQo+ID4gQ29kZTogYWEwMDAzZjYgYWEwMjAzZjQgYWEwMTAzZjUg
ZjkwMA0KPiA+IA0KPiA+ICdGaXhlczogMDFhYmY1ZmJiMDgxYyAoIm1lZGlhOiBtZWRpYXRlazog
dmNvZGVjOiBzZXBhcmF0ZSBzdHJ1Y3QNCj4gPiAnbXRrX3Zjb2RlY19jdHgnIiknDQo+ID4gU2ln
bmVkLW9mZi1ieTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvY29tbW9uL210a192Y29kZWNfdXRpbC5jICB8
IDY2DQo+ID4gKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDY0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEv
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvY29tbW9uL210a192Y29kZWNf
dXRpbC5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9jb21t
b24vbXRrX3Zjb2RlY191dGlsLmMNCj4gPiBpbmRleCA5MDg2MDIwMzFmZDAuLjYyYmI3MjkwYzU2
ZCAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsv
dmNvZGVjL2NvbW1vbi9tdGtfdmNvZGVjX3V0aWwuYw0KPiA+ICsrKw0KPiA+IGIvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvY29tbW9uL210a192Y29kZWNfdXRpbC5jDQo+
ID4gQEAgLTQ1LDcgKzQ1LDcgQEAgaW50IG10a192Y29kZWNfd3JpdGVfdmRlY3N5cyhzdHJ1Y3QN
Cj4gPiBtdGtfdmNvZGVjX2RlY19jdHggKmN0eCwgdW5zaWduZWQgaW50IHJlZywNCj4gPiAgIH0N
Cj4gPiAgIEVYUE9SVF9TWU1CT0wobXRrX3Zjb2RlY193cml0ZV92ZGVjc3lzKTsNCj4gPiAgIA0K
PiA+IC1pbnQgbXRrX3Zjb2RlY19tZW1fYWxsb2Modm9pZCAqcHJpdiwgc3RydWN0IG10a192Y29k
ZWNfbWVtICptZW0pDQo+ID4gK3N0YXRpYyBpbnQgbXRrX3Zjb2RlY19tZW1fZGVjX2FsbG9jKHZv
aWQgKnByaXYsIHN0cnVjdA0KPiA+IG10a192Y29kZWNfbWVtICptZW0pDQo+ID4gICB7DQo+ID4g
ICAJdW5zaWduZWQgbG9uZyBzaXplID0gbWVtLT5zaXplOw0KPiA+ICAgCXN0cnVjdCBtdGtfdmNv
ZGVjX2RlY19jdHggKmN0eCA9IHByaXY7DQo+ID4gQEAgLTY0LDkgKzY0LDM5IEBAIGludCBtdGtf
dmNvZGVjX21lbV9hbGxvYyh2b2lkICpwcml2LCBzdHJ1Y3QNCj4gPiBtdGtfdmNvZGVjX21lbSAq
bWVtKQ0KPiA+ICAgDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW50IG10a192Y29kZWNfbWVtX2VuY19hbGxvYyh2b2lkICpwcml2LCBzdHJ1Y3QNCj4gPiBt
dGtfdmNvZGVjX21lbSAqbWVtKQ0KPiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBsb25nIHNpemUgPSBt
ZW0tPnNpemU7DQo+ID4gKwlzdHJ1Y3QgbXRrX3Zjb2RlY19lbmNfY3R4ICpjdHggPSBwcml2Ow0K
PiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJmN0eC0+ZGV2LT5wbGF0X2Rldi0+ZGV2Ow0KPiA+
ICsNCj4gPiArCW1lbS0+dmEgPSBkbWFfYWxsb2NfY29oZXJlbnQoZGV2LCBzaXplLCAmbWVtLT5k
bWFfYWRkciwNCj4gPiBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghbWVtLT52YSkgew0KPiA+ICsJ
CW10a192NGwyX3ZlbmNfZXJyKGN0eCwgIiVzIGRtYV9hbGxvYyBzaXplPSVsZCBmYWlsZWQhIiwN
Cj4gPiBkZXZfbmFtZShkZXYpLCBzaXplKTsNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwltdGtfdjRsMl92ZW5jX2RiZygzLCBjdHgsICJbJWRdICAtIHZhICAg
ICAgPSAlcCIsIGN0eC0+aWQsIG1lbS0NCj4gPiA+dmEpOw0KPiA+ICsJbXRrX3Y0bDJfdmVuY19k
YmcoMywgY3R4LCAiWyVkXSAgLSBkbWEgICAgID0gMHglbHgiLCBjdHgtPmlkLA0KPiA+ICsJCQkg
ICh1bnNpZ25lZCBsb25nKW1lbS0+ZG1hX2FkZHIpOw0KPiA+ICsJbXRrX3Y0bDJfdmVuY19kYmco
MywgY3R4LCAiWyVkXSAgICBzaXplID0gMHglbHgiLCBjdHgtPmlkLA0KPiA+IHNpemUpOw0KPiA+
ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQgbXRrX3Zjb2RlY19t
ZW1fYWxsb2Modm9pZCAqcHJpdiwgc3RydWN0IG10a192Y29kZWNfbWVtICptZW0pDQo+ID4gK3sN
Cj4gPiArCWVudW0gbXRrX2luc3RhbmNlX3R5cGUgaW5zdF90eXBlID0gKigodW5zaWduZWQgaW50
ICopcHJpdik7DQo+IA0KPiBJIGFncmVlIGluIHRoYXQgdGhlIGZpcnN0IG1lbWJlciBvZiBib3Ro
IG10a192Y29kZWNfe2VuYyxkZWN9X2N0eCBpcw0KPiB0aGlzDQo+IGVudW0gbXRrX2luc3RhbmNl
X3R5cGUsIGJ1dCBubywgeW91J3JlIG5vdCBwYXNzaW5nIHRoYXQgYXMgcHJpdjoNCj4geW91J3Jl
IGFjdHVhbGx5DQo+IHBhc3Npbmcgb25lIG9mIHRoZSB0d28gc3RydWN0dXJlcywgYW5kIHRoaXMg
d291bGQgYWRkIHVwIGNvbXBsZXhpdHkNCj4gaW4gaHVtYW4NCj4gcmVhZGFiaWxpdHksIGFuZCB3
b3VsZCBhbHNvIG9wZW4gdGhlIHJvYWQgZm9yIG1pc3Rha2VzLg0KPiANCj4gWW91IHNob3VsZCBh
dCB0aGlzIHBvaW50IHBhc3MgdGhlIGluc3RhbmNlIHR5cGUgdG8gdGhlIGZ1bmN0aW9uLg0KPiAN
Cj4gaW50IG10a192Y29kZWNfbWVtX2FsbG9jKHZvaWQgKnByaXYsIGVudW0gbXRrX2luc3RhbmNl
X3R5cGUgLyogb3INCj4gaW50LCBidXQgSSBwcmVmZXIgDQo+IGVudW0gKi8gaW5zdF90eXBlLCBz
dHJ1Y3QgbXRrX3Zjb2RlY19tZW0gKm1lbSkNCj4gDQo+IC4uLmFuZCB0aGVuLCBzaW5jZSB0aGUg
b25seSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIHR3byBgYWxsb2NgDQo+IGZ1bmN0aW9uIGlzIGp1
c3QNCj4gb25seSBhYm91dCBkZWJ1Z2dpbmcgbG9ncywgeW91IGNvdWxkIGNvbW1vbml6ZSB0aGUg
YWxsb2NhdGlvbiBwYXJ0Li4uDQo+IGFuIGlkZWE6DQo+IA0KPiBzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2Ow0KPiB1bnNpZ25lZCBsb25nIHNpemU7DQo+IGludCBpZDsNCj4gDQo+IA0KV2ls
bCByZXdyaXRlIGFsbG9jYXRlIGFuZCBmcmVlIG1lbW9yeSBpbnRlcmZhY2UgaW4gcGF0Y2ggdjIu
DQoNCkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQo+IGlmIChpbnN0X3R5cGUgPT0gTVRLX0lO
U1RfREVDT0RFUikgew0KPiAJc3RydWN0IG10a192Y29kZWNfZW5jX2N0eCAqZW5jX2N0eCA9IHBy
aXY7DQo+IAlwZGV2ID0gZW5jX2N0eC0+ZGV2LT5wbGF0X2RldjsNCj4gCWlkID0gZW5jX2N0eC0+
aWQ7DQo+IH0gZWxzZSB7DQo+IAlzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfY3R4ICpkZWNfY3R4ID0g
cHJpdjsNCj4gCXBkZXYgPSBkZWNfY3R4LT5kZXYtPnBsYXRfZGV2Ow0KPiAJaWQgPSBkZWNfY3R4
LT5pZDsNCj4gfQ0KPiANCj4gbWVtLT52YSA9IGRtYV9hbGxvY19jb2hlcmVudCgmcGRldi0+ZGV2
LCBldGMuLi4uLikNCj4gaWYgKCFtZW0tPnZhKSB7DQo+IAltdGtfdjRsMl9lcnIocGRldiwgLi4u
Li4pOw0KPiB9DQo+IA0KPiBtdGtfdjRsMl9kZWJ1ZygmcGRldi0+ZGV2LCAzLCAiWyVkXSAgLSB2
YSAgICAgID0gJXAiLCBpZCwgbWVtLT52YSk7DQo+IA0KPiAuLi55b3Ugd291bGRuJ3QgZXZlbiBu
ZWVkIG9uZSBmdW5jdGlvbiBmb3IgZW5jX2FsbG9jIGFuZCBvbmUgZm9yDQo+IGRlY19hbGxvYywg
YXMNCj4gdGhlIGxvZ2ljIHdvdWxkIGJlIHByZXR0eSBtdWNoIGNvbW1vbml6ZWQgbGlrZSB0aGlz
Lg0KPiANCj4gPiArDQo+ID4gKwlpZiAoaW5zdF90eXBlID09IE1US19JTlNUX0VOQ09ERVIpDQo+
ID4gKwkJcmV0dXJuIG10a192Y29kZWNfbWVtX2VuY19hbGxvYyhwcml2LCBtZW0pOw0KPiA+ICsJ
ZWxzZQ0KPiA+ICsJCXJldHVybiBtdGtfdmNvZGVjX21lbV9kZWNfYWxsb2MocHJpdiwgbWVtKTsN
Cj4gPiArfQ0KPiA+ICAgRVhQT1JUX1NZTUJPTChtdGtfdmNvZGVjX21lbV9hbGxvYyk7DQo+ID4g
ICANCj4gPiAtdm9pZCBtdGtfdmNvZGVjX21lbV9mcmVlKHZvaWQgKnByaXYsIHN0cnVjdCBtdGtf
dmNvZGVjX21lbSAqbWVtKQ0KPiA+ICtzdGF0aWMgdm9pZCBtdGtfdmNvZGVjX21lbV9kZWNfZnJl
ZSh2b2lkICpwcml2LCBzdHJ1Y3QNCj4gPiBtdGtfdmNvZGVjX21lbSAqbWVtKQ0KPiA+ICAgew0K
PiA+ICAgCXVuc2lnbmVkIGxvbmcgc2l6ZSA9IG1lbS0+c2l6ZTsNCj4gPiAgIAlzdHJ1Y3QgbXRr
X3Zjb2RlY19kZWNfY3R4ICpjdHggPSBwcml2Ow0KPiA+IEBAIC04Nyw2ICsxMTcsMzggQEAgdm9p
ZCBtdGtfdmNvZGVjX21lbV9mcmVlKHZvaWQgKnByaXYsIHN0cnVjdA0KPiA+IG10a192Y29kZWNf
bWVtICptZW0pDQo+ID4gICAJbWVtLT5kbWFfYWRkciA9IDA7DQo+ID4gICAJbWVtLT5zaXplID0g
MDsNCj4gPiAgIH0NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIG10a192Y29kZWNfbWVtX2VuY19m
cmVlKHZvaWQgKnByaXYsIHN0cnVjdA0KPiA+IG10a192Y29kZWNfbWVtICptZW0pDQo+ID4gK3sN
Cj4gPiArCXVuc2lnbmVkIGxvbmcgc2l6ZSA9IG1lbS0+c2l6ZTsNCj4gPiArCXN0cnVjdCBtdGtf
dmNvZGVjX2VuY19jdHggKmN0eCA9IHByaXY7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAm
Y3R4LT5kZXYtPnBsYXRfZGV2LT5kZXY7DQo+ID4gKw0KPiA+ICsJaWYgKCFtZW0tPnZhKSB7DQo+
ID4gKwkJbXRrX3Y0bDJfdmVuY19lcnIoY3R4LCAiJXMgZG1hX2ZyZWUgc2l6ZT0lbGQgZmFpbGVk
ISIsDQo+ID4gZGV2X25hbWUoZGV2KSwgc2l6ZSk7DQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCW10a192NGwyX3ZlbmNfZGJnKDMsIGN0eCwgIlslZF0gIC0gdmEgICAgICA9
ICVwIiwgY3R4LT5pZCwgbWVtLQ0KPiA+ID52YSk7DQo+ID4gKwltdGtfdjRsMl92ZW5jX2RiZygz
LCBjdHgsICJbJWRdICAtIGRtYSAgICAgPSAweCVseCIsIGN0eC0+aWQsDQo+ID4gKwkJCSAgKHVu
c2lnbmVkIGxvbmcpbWVtLT5kbWFfYWRkcik7DQo+ID4gKwltdGtfdjRsMl92ZW5jX2RiZygzLCBj
dHgsICJbJWRdICAgIHNpemUgPSAweCVseCIsIGN0eC0+aWQsDQo+ID4gc2l6ZSk7DQo+ID4gKw0K
PiA+ICsJZG1hX2ZyZWVfY29oZXJlbnQoZGV2LCBzaXplLCBtZW0tPnZhLCBtZW0tPmRtYV9hZGRy
KTsNCj4gPiArCW1lbS0+dmEgPSBOVUxMOw0KPiA+ICsJbWVtLT5kbWFfYWRkciA9IDA7DQo+ID4g
KwltZW0tPnNpemUgPSAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICt2b2lkIG10a192Y29kZWNfbWVt
X2ZyZWUodm9pZCAqcHJpdiwgc3RydWN0IG10a192Y29kZWNfbWVtICptZW0pDQo+ID4gK3sNCj4g
PiArCWVudW0gbXRrX2luc3RhbmNlX3R5cGUgaW5zdF90eXBlID0gKigodW5zaWduZWQgaW50ICop
cHJpdik7DQo+ID4gKw0KPiA+ICsJaWYgKGluc3RfdHlwZSA9PSBNVEtfSU5TVF9FTkNPREVSKQ0K
PiA+ICsJCW10a192Y29kZWNfbWVtX2VuY19mcmVlKHByaXYsIG1lbSk7DQo+ID4gKwllbHNlDQo+
ID4gKwkJbXRrX3Zjb2RlY19tZW1fZGVjX2ZyZWUocHJpdiwgbWVtKTsNCj4gDQo+IHNhbWUgY29t
bWVudHMgYXBwbHkgdG8gdGhlIHh4eHhfZnJlZSgpIGZ1bmN0aW9uIGFzIHdlbGwuDQo+IFlvdSdy
ZSBpbiB0aGUgImNvbW1vbiIgc2NvcGUgaGVyZSwgc28geW91IHdvdWxkbid0IGJlIGZvcmNlZCB0
byB1c2UNCj4gdGhlIGVuYy9kZWMNCj4gc3BlY2lmaWMgbG9nZ2luZyBmdW5jdGlvbnMsIGFzIHlv
dSBjYW4gdXNlIHRoZSBtb3JlIGdlbmVyaWMNCj4gbXRrX3Y0bDJfe2RlYnVnLGVycn0oKQ0KPiBh
bmQgbXRrX3Zjb2RlY197ZGVidWcsZXJyfSgpIGZ1bmN0aW9ucyBoZXJlLCB3aGljaCBhcmUgKnBl
cmZlY3QqIGZvcg0KPiB0aGUgY29tbW9uDQo+IGNvZGUuDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vs
bw0KPiANCj4gDQo=
