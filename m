Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4A87C62BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjJLC32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjJLC3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:29:25 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89F8A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:29:22 -0700 (PDT)
X-UUID: 21a7ee8e68a711ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=m+aTFoQ0ush+LndCXzRtGmXtFSC6DDOT/f/vTfgqgsE=;
        b=CkvWJfyhulFK9TWLihIdEHeAGRa1a7kqMPCPa/KND2aoZ9vle8y45pP2gBzb85tfbpqCNUJLqVDgzzLtP6XJIrvDNi2EhOEyqGhoq3IDe2f0mUdm1OXJAeGrUTytFHzii9T3X5KNcoHIdIruBo9mwr8/MCx7EMD9oh3RqUCwLTM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:f159c285-f71e-4dff-9fcf-d1262c35c004,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:adf9b0f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 21a7ee8e68a711ee8051498923ad61e6-20231012
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2065776135; Thu, 12 Oct 2023 10:29:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 10:29:12 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 10:29:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgxEK8eqezhznd2jKcc2XTg25EmFOmFPsn7vopedilf3kY7Q7RbV8Ipw2KTkVf4CrDPkMeg1yLUB1eNm4HL2j2xE06l9Rx1ppM3bbFvIMEeFdzB36K8Mt+zzfU0W0fnjcaFulZyif9x0fIb/uFI7oBZ5+RPtFpVDv3boKo6pADIezy1PKXEEKzKmZzCGGl7Qs59Y3lUMX0qbTJ7Jw5R5SxvmSsdfTtCYKdCjrLZj1bqY7Rcq7W0OzyQA+9dfDUDPbnQVmpoQm+P5TcAQ4lqI028x9brNJqXmb8/a3QVbmB/qaArpMGsHMlAUgP9qGWfDEM/LhmV/ufQF3Jl1uBsoBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+aTFoQ0ush+LndCXzRtGmXtFSC6DDOT/f/vTfgqgsE=;
 b=fi0f2Ou1bHkM2dYQj6eAW0gbgltBnbnR5zWj54koVXxIKjgdUGzYmyccdNme8FOfbnX1J4Z7aIPzRjaagp7293Kety1Do9pqxEKuukviVelm2cD+zj4BTup6AQgY9I+a7ThF7buSDDG2ftqGFy42TriAwMkoXc0tjg3WpCayap5P7caQiK5nJnMpx2q+wFDClPur0lYUPbUj83BqxVvMWEWpknYxZZb6VYgWBd5v7LYyysX0sUoZxlhirifOxe5o3RrJarAGVdFRi33pNlW6EJiGvaZLLYgsM/mIXIcQZ5uhTIih4RiHKruBtfeJ+5G5HgxjzEOl3ulZ7I8aslaOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+aTFoQ0ush+LndCXzRtGmXtFSC6DDOT/f/vTfgqgsE=;
 b=DqEXYACVP1eNu+UnBFiisk3G81YOPoTMDytm8MDxcQoU95SR1DhFzNVAJYOGmVXpnuiPDnpHwYhKk8uCrJdWmqpsCHLPIxt+/7qYHJ7de/cWgBdYAFD3e6KYaoZ63AZFdITjGmO7ZfEZ7qJP/H7gntCd5HiPTDbGSxRJ56Pk5VY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB5336.apcprd03.prod.outlook.com (2603:1096:301:45::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Thu, 12 Oct
 2023 02:29:09 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.041; Thu, 12 Oct 2023
 02:29:09 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v10 12/16] drm/mediatek: gamma: Make sure relay mode is
 disabled
Thread-Topic: [PATCH v10 12/16] drm/mediatek: gamma: Make sure relay mode is
 disabled
Thread-Index: AQHZxqWLTrCgmCZIyUWuGcl95PleprBF2neA
Date:   Thu, 12 Oct 2023 02:29:09 +0000
Message-ID: <4c7070164bae0a20e615b34767104ef045f84add.camel@mediatek.com>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
         <20230804072850.89365-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230804072850.89365-13-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB5336:EE_
x-ms-office365-filtering-correlation-id: 928170f1-3450-4a12-df76-08dbcacb0411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IIs89uVzv8vhi/9UWXIToeCr9yIUyllpzMTCmT7Kb9jxcKji7ThKG+/8jsKxXF1CdTy+1DlkomHulxRHgAYLWT4VAqu6SQYH/OSlGeONEGaudXw8s/yqN3NzJc66nWQuI/p+xlfgq/am3i6zD0yMv6pJte70PIL0KsWPYtxzOttY6NmRUoKYoV0+3xXf8HJiAC4JdWWHMfld3hKrzgs+wcUvVIIXz+Zk3c3CfIPhVtNn8UUzMqn7w34bvxnhSQFb6A4ZQnXIieDt4lGmy7buAG4jFPZboB+4TpVqZTn80hmoJpW57zHRTmJFlVbfNxCR2m7dF8cM/BvCoQ+tEK9KgbonPZMEGqvUZAzQF3l8/dOY/w9Be71tcfowNrpGST5bwdr1JOucPC9mHqG1HDVvIPdVOF5Lx0GYzNtULI7XZVVrIeeAQbvPv0nSpxw402PfjOmijE45LiNvz5DdIMbvCHiS0c6wlZ4KqvZJkqBATuKNbnrsXJDd/uyj5IqggLaJa1QLk+wJpuXrFuWkr3zw30FgoZbDhxAobN8+eiCydqsMz7rz7iXxD3dNQwlz1bjlLh++W87dGiu7J6nAbFezp6a01CDhA5Iq2s3SbX9D+u76fMvBqx7MF5OjR016unov0qm9uw86qvHX94p5xpfdzY3XjjGzOJwkYxT0FFXMydI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(71200400001)(478600001)(6486002)(6506007)(5660300002)(7416002)(4326008)(8936002)(2906002)(8676002)(2616005)(38070700005)(38100700002)(76116006)(85182001)(66446008)(66556008)(36756003)(316002)(110136005)(66946007)(66476007)(86362001)(64756008)(54906003)(41300700001)(6512007)(122000001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDg5ODBqbU5lZk1UV1U3SWx6akVxZTY5TDR0OUpFNVgzOFVEdzR2QkZNNk9Q?=
 =?utf-8?B?czBSSWJIYWh0bzFudmlnY3JvOWxRUVdHVzJnUVBsa1ZSN1p5MWtiTTVBUWdm?=
 =?utf-8?B?djJDaEJFM0hwa1BPbkU1TUlRWk50THRSOTcrcHJ3S1dweFBXaXZUUDAzUjFC?=
 =?utf-8?B?QVB6V0lBb21VSFN6cWhMYWVYRTlTQkZnUjd2bWlYREFhVVJtWmgrYnE4RDRt?=
 =?utf-8?B?SUg2RFJlbXVPRUZMNVUwUlpodVZKbXl6T2wya0c0SVZBWVFDUndzNm44RHJJ?=
 =?utf-8?B?dzh3SXZrYkF3QWpTcVRZOWlDM21ORDluaTUraHRER3d1OWJFcENOc2tBWEdi?=
 =?utf-8?B?ZjNSZDJub3Y4a3RKUFFoOE0vTm5ST0p3Zld2Z21hdEcrRENaYWJQdDl6VDU5?=
 =?utf-8?B?SDlNNXVBVFVnci8vZHZQWWhTd2w4T3FCVjJzWkRxMU11NDdmY2JhRENVRnd3?=
 =?utf-8?B?azFqYldDNmJJVTZ6M0Q3OWV0MktBbXFsZWZWVE5oVkVkcFpCbzRUK0F3elph?=
 =?utf-8?B?MkNQa2Zkc2ZiKzR5cWNTdDJHL3lhZ2ZweEZKaGNTN3ZsSGJKeTFtUVVTdmtF?=
 =?utf-8?B?WDUzUmExay9IUXZGMnliaDhCSHFVMVhnODZ4M2VyNmhsbFQ0RGVKZnYyR1gy?=
 =?utf-8?B?ZlNKL0ppMzV1b3pmMXk0bGloYUVabHcxd2dCMkZ0RVdHQ1B6K2kvbXBIZ2xp?=
 =?utf-8?B?M05LVTRrVFZzb1RubXR6d3BQM0hzeVRZSlFUZnI5MDV5UjU3SVZYdEMxalpX?=
 =?utf-8?B?QUlsM1R3NVBQVGZzQTkvU0RtRllYYTg0RFl2dUt1dS9LMFBsVmRpUWIzUko0?=
 =?utf-8?B?UnVtZmJ6aEg5QTlCZU5BeHd2bTU5eE5CdkNpWEp6a1cxRkpJZ3BPQW5vSkF2?=
 =?utf-8?B?VjVrQzJIUUZRU0oxUitrNms2eVVaalo5QUNrSzk0RmxZMWRwNWNpeWNCMHc1?=
 =?utf-8?B?SEs3MUhMdXhxZHRhWVpkMWFZdEFUM0ZWVlUzdzk4WURqTkt0bjYzUW83Wlc5?=
 =?utf-8?B?TnQwdWpHOUVlbnZCWlNRL3RLQUtvdytsMmU0NTg5WmdnR3cyMUFoclVBNVkv?=
 =?utf-8?B?aTBFUzIrSVFWcjE5ZURGa3dmVUlZbDQ1bHAzai95OVJpZ0VMc3ZxRWRlMXBR?=
 =?utf-8?B?RDNDR216UVd6TGpIRU9GKzZmTFZ5QXIvYVFCeWRCR1NlMHhBZTJHZmNTY2VR?=
 =?utf-8?B?OVZpWUpFQVVCNzBZL1BwblVJa3huTytaemNrZ1NBZ0luNU13dUI2NkZaWFJP?=
 =?utf-8?B?a1ZxUDZQdm9qdDFSWDdqMmtFamllcHA4ZG91dHNSWWpOZ2Y1SGhVSWY0cWZ1?=
 =?utf-8?B?SFZXaFpXVEx4YWU2dXhETTRQa2R4VHpLcHNwVnVxR09idW5ESjVWT0VhL0NI?=
 =?utf-8?B?QXduSVd2L3hZcEhzZ0tLaENyK0xDWlFsaWxiMytsa2FoVjVOeVU2WnBCY2FB?=
 =?utf-8?B?VFR0bTZ2Y2pVRzNiNFJybHU4Uld6RE95d1FSdndRM1dCQTBsTVl5K2w0SW5Z?=
 =?utf-8?B?c2RuZ3ZLWlpFb011Qk9ZNEIraUNwYmI4WERpU0RUUFVHQ1lYbXlYenpoQk9J?=
 =?utf-8?B?Y210N3RZSkh2ekhzRStvazNDdUp5dndHbU53bmE2em54SkdTUG1TeUpMOUtj?=
 =?utf-8?B?Y1QrL0ZmdnN3SE4xUnc3OHJhSFdYU1NRb2ZFYXJXRjJzZEczcW42R25lQzlH?=
 =?utf-8?B?Z2tFVTZmOGFyL1VQWlJFYnpQdjQ4NmtBR2MyMW9FUVloY2NMUVBKT0xjYWw2?=
 =?utf-8?B?STBCWEY0RVpHd2o4WFZZNklBQzJUTk5lWkxCRHNkMktlc2xncjlkeGxFbjZK?=
 =?utf-8?B?OVI1MVp5akJMekhScWkzUU55Q0JTdEYwZHZ3WThmS0V5Y3NZbUpueXJvZnRR?=
 =?utf-8?B?TzRhc2hNMnJYWElIM01SblVyWjVWVHRnNUo5Q1RpQnVPNTEyNUxQUHFyTW5W?=
 =?utf-8?B?NlVDV2NIaElkZmpyUHZXeGNTcHkwaHVqWWsybzc0NWVQY1k4bUQ2RDRQRjNo?=
 =?utf-8?B?Y2ZCRFUxa0cyQjl1d1pTSkgzTFBZUXNMeU1HOHRZRUFpdERzdmVZNVFIVjBu?=
 =?utf-8?B?WFZ6YlFWRmJ5Y29qRzlsd25zN2JiWWVCVGJ6czYyQ0JTZ1YwN2s5Uy9iYTVS?=
 =?utf-8?Q?fipFlBgMU4WAfTFeITDLY1lM7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF3520FBF53EA848940DDD351170AA00@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928170f1-3450-4a12-df76-08dbcacb0411
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 02:29:09.8493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XbKAZHcaHve6qg/oIyn1cHyDPqpM0KJFsD+r2ctM99bbPQeZ77zSmreKIFhnEvqeBLb3eOS6slNWuzcIr16i5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5336
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gRnJpLCAyMDIzLTA4LTA0IGF0IDA5OjI4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRGlzYWJsZSByZWxheSBtb2RlIGF0IHRoZSBl
bmQgb2YgTFVUIHByb2dyYW1taW5nIHRvIG1ha2Ugc3VyZSB0aGF0DQo+IHRoZQ0KPiBwcm9jZXNz
ZWQgaW1hZ2UgZ29lcyB0aHJvdWdoIGluIGJvdGggRElTUF9HQU1NQSBhbmQgRElTUF9BQUwgZm9y
DQo+IGdhbW1hDQo+IHNldHRpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2FhbC5jICAg
fCAzICsrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMgfCA0
ICsrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2FhbC5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2FhbC5jDQo+IGluZGV4IDIxYjI1NDcwZTliNy4u
OTkyZGMxNDI0YzkxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfYWFsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Fh
bC5jDQo+IEBAIC0xMjIsNiArMTIyLDkgQEAgdm9pZCBtdGtfYWFsX2dhbW1hX3NldChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdA0KPiBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+ICAJCXdyaXRl
bCh3b3JkLCAoYWFsLT5yZWdzICsgRElTUF9BQUxfR0FNTUFfTFVUKSArIChpICoNCj4gNCkpOw0K
PiAgCX0NCj4gIA0KPiArCS8qIERpc2FibGUgUkVMQVkgbW9kZSB0byBwYXNzIHRoZSBwcm9jZXNz
ZWQgaW1hZ2UgKi8NCj4gKwljZmdfdmFsICY9IH5BQUxfUkVMQVlfTU9ERTsNCg0KSXQgc2VlbXMg
dGhhdCB0aGUgcmVsYXkgbW9kZSBpcyBkZWZhdWx0IHR1cm5lZCBvZmYuIEJ1dCBleHBsaWNpdGx5
DQpzZXR0aW5nIGl0IGlzIGdvb2QgdG8gbWUuIEFmdGVyIGFkZGluZyBBQUxfUkVMQVlfTU9ERSBk
ZWZpbml0aW9uIGluDQp0aGlzIHBhdGNoLA0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1l
ZGlhdGVrLmNvbT4NCg0KPiArDQo+ICAJd3JpdGVsKGNmZ192YWwsIGFhbC0+cmVncyArIERJU1Bf
QUFMX0NGRyk7DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX2dhbW1hLmMNCj4gaW5kZXggN2QyZjgwNDJhY2UwLi5mYmZmOWY5N2I3MzcgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IEBAIC0xOSw2ICsx
OSw3IEBADQo+ICAjZGVmaW5lIERJU1BfR0FNTUFfRU4JCQkJMHgwMDAwDQo+ICAjZGVmaW5lIEdB
TU1BX0VOCQkJCQlCSVQoMCkNCj4gICNkZWZpbmUgRElTUF9HQU1NQV9DRkcJCQkJMHgwMDIwDQo+
ICsjZGVmaW5lIEdBTU1BX1JFTEFZX01PREUJCQkJQklUKDApDQo+ICAjZGVmaW5lIEdBTU1BX0xV
VF9FTgkJCQkJQklUKDEpDQo+ICAjZGVmaW5lIEdBTU1BX0RJVEhFUklORwkJCQkJQklUKDIpDQo+
ICAjZGVmaW5lIERJU1BfR0FNTUFfU0laRQkJCQkweDAwMzANCj4gQEAgLTE3Nyw2ICsxNzgsOSBA
QCB2b2lkIG10a19nYW1tYV9zZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QNCj4gZHJtX2Ny
dGNfc3RhdGUgKnN0YXRlKQ0KPiAgCS8qIEVuYWJsZSB0aGUgZ2FtbWEgdGFibGUgKi8NCj4gIAlj
ZmdfdmFsIHw9IEZJRUxEX1BSRVAoR0FNTUFfTFVUX0VOLCAxKTsNCj4gIA0KPiArCS8qIERpc2Fi
bGUgUkVMQVkgbW9kZSB0byBwYXNzIHRoZSBwcm9jZXNzZWQgaW1hZ2UgKi8NCj4gKwljZmdfdmFs
ICY9IH5HQU1NQV9SRUxBWV9NT0RFOw0KPiArDQo+ICAJd3JpdGVsKGNmZ192YWwsIGdhbW1hLT5y
ZWdzICsgRElTUF9HQU1NQV9DRkcpOw0KPiAgfQ0KPiAgDQo=
