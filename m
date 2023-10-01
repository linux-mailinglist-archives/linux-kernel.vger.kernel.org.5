Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF27B4854
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjJAPP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjJAPP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:15:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8F3D9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 08:15:24 -0700 (PDT)
X-UUID: 52cc5b72606d11ee8051498923ad61e6-20231001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BRlEDp5LKZLnqBzJXxNMhXJKYMff8teiXnGrqXn/rCw=;
        b=hvAMWlsCeto9NUeLjtFb8Um6hj1s/pkoJSGzXuVSg5cb2CWF/Ezt25n83gBzBs9xvhUe1QZWy6ZpYWnscgE/3OaXfZqS/WvmfMR/hAoH8vMObdiDb4KNLJ5qWDfYYBhTM7G1bau8IOPirbphn51MwocMrnMoeQF6AC2YLhmdNeQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c41312d1-faa5-4da2-9238-02722530bcbf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:5ccea5c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 52cc5b72606d11ee8051498923ad61e6-20231001
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 432762201; Sun, 01 Oct 2023 23:15:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 1 Oct 2023 23:15:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 1 Oct 2023 23:15:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcCghAhK8lkzb2+vxSbt9Qdhimco2O2KbI46NhLSDNNrZsmyVTQ6iyIw9Hn9CcYHtCKNKPu7jv/S+jXvrftvI4mofHZzqX+EoWvBQz7C0MiaeIMH1UhUX5xT+G074MogWjXsxL1b4wgIkgFz0c85l8Zbq51Ypo4g1vdVGICDPbxlP7yp4v2bZ5f21APw/GoyTWDNUR7HVYE9YLx3NtymijL7AHi4OywNz1HYU0eNJcyA86MO6o2axmdkav7xb9vGgto2va4Xz1hE5Xba10CFS2+a2NcJcQYck10TcWGrbGzlKgf2c9pevcdDhc8uOZ+OOt33MPLTn5sDeYcmjzchXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRlEDp5LKZLnqBzJXxNMhXJKYMff8teiXnGrqXn/rCw=;
 b=E8YG3ypitpJHURdBgaj2PYNybI3uAxAMwrJY4FTB5jkWkKR4dqLchirwHpz9p70uINd+QABpKlWgVJjK7mgtJR9wTur4xQcg2hABGEAA5pfu/kbrwSIHtBraMlDnZq5oP6CB4WPfK02ZMUMJ+7mmVggDIjt6jDO4wDWC5zeS3hlc0s/R3Q6h+1vDmWlc6HxhYFSGVefkzi5PC+ZtHXpoEc6mra7GztYQgzJYLirY/Dv4c3O79ijNih72zHfXO8Wo81vfOj089yKt1a/9JvAdhtuOP3xYk5CPq4hSspwh6k1t0dr9eOTxRjju4k+GKlsoH7a2iZiHSoagmyXxtvPnWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRlEDp5LKZLnqBzJXxNMhXJKYMff8teiXnGrqXn/rCw=;
 b=f16YndWFNnC+hWLtCJdw+iinHQZqclVb8JD98RBLbczSptIqTTIoF7+vQuVhe+E+1bVwnd4QBz2Bko6etA/nrZSeHBRsYkoRgBlKpPUwxlawiYdyv51Tvo2CaTbYyVJ7hsXqQlot2mnibCJYGVEBPR4Hp+kdAE7PhKOnyBvRT0o=
Received: from SI2PR03MB5580.apcprd03.prod.outlook.com (2603:1096:4:12e::5) by
 SEZPR03MB6593.apcprd03.prod.outlook.com (2603:1096:101:75::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.28; Sun, 1 Oct 2023 15:15:10 +0000
Received: from SI2PR03MB5580.apcprd03.prod.outlook.com
 ([fe80::a8c0:4146:462f:76e6]) by SI2PR03MB5580.apcprd03.prod.outlook.com
 ([fe80::a8c0:4146:462f:76e6%4]) with mapi id 15.20.6838.029; Sun, 1 Oct 2023
 15:15:10 +0000
From:   =?utf-8?B?S3V5byBDaGFuZyAo5by15bu65paHKQ==?= 
        <Kuyo.Chang@mediatek.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] sched/core: Fix stuck on completion for
 affine_move_task() when stopper disable
Thread-Topic: [PATCH 1/1] sched/core: Fix stuck on completion for
 affine_move_task() when stopper disable
Thread-Index: AQHZ8PONNdMSrYrApES66NU/CC/LkLAuUcoAgACC+ICAAsbJgIADdq2A
Date:   Sun, 1 Oct 2023 15:15:09 +0000
Message-ID: <4b0acbb118018bacdcd88979e4083b118c164594.camel@mediatek.com>
References: <20230927033431.12406-1-kuyo.chang@mediatek.com>
         <20230927080850.GB21824@noisy.programming.kicks-ass.net>
         <b9def8f3d9426bc158b302f4474b6e643b46d206.camel@mediatek.com>
         <20230929102135.GD6282@noisy.programming.kicks-ass.net>
In-Reply-To: <20230929102135.GD6282@noisy.programming.kicks-ass.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5580:EE_|SEZPR03MB6593:EE_
x-ms-office365-filtering-correlation-id: d204575a-d263-4bb5-dd84-08dbc29133f0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OBpZHW9DzZ3ke4fKSUXqlCpzHCU/HvN//aieWeNxtEoKp3MY+30S0QcTFdEF1XLXGL+RzPOpX/o+H4uyNeXtolt5hqaqxGI9KpiradEgyrTS8L+BXBpQoT9M3kDEDjJqk2ZxCagKCrGY3WgM4d6LqdETzpuwyEk/slHDzFh67LXC5KRB1dQIdoYGc+aabUSm+oycTJZY87IqHaG1pnIucShkFtg4nA04TJ1om6ZUtwDpGEKOREDbyNYZn6ut/fiEtlqSZAtkQPvfFAniHvyJo9cG3YVjNIdG/AHSWLuoETEf88tn1Whu10ztRB4Fvl7G+Qt5nph7bcK7ZPr2R8Jg1Iv6zOsZdpLX2+K3ld7xChnzLoIfJFD1weq2SWUwITsCW2qiqxy5W2zm+HOr1dlhm/FAV2/AbrSyabdlvGevQEQ4If6dQzKlAa6QrD3u6DHINn3Vzxsrq7sg5tdT+30xBr/vNSlh87tTPPic6ywHDTOQdEXAsSTfOfYX15tzDH5JhoC0fcssSruEIKGDumvobWGwkyrTIWolD1ZNiSRolDxrUCqoBjYrWlazvwjUTYg9/YwwSL+NUIfUe+PgwvTsxewcyyuYhpp6PGYUxFLjHu7FD5G4tsqNAL/AxY94mT/pnmFX/IWpPkIsV+FOerS2h5YPMuQ4uySw4JlNqRkPuLE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5580.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39850400004)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(38070700005)(38100700002)(4326008)(8676002)(8936002)(2906002)(7416002)(6486002)(71200400001)(6512007)(36756003)(85182001)(86362001)(2616005)(5660300002)(478600001)(41300700001)(76116006)(66946007)(91956017)(6916009)(316002)(54906003)(64756008)(66446008)(66556008)(66476007)(6506007)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG52UWlyMTBqbXMzUzN4TWFPaHRmMS96SER0RnpmZlRIamcvL0J6NXFXak8z?=
 =?utf-8?B?VSs5TVFZSlJxaURyZlFRMjFzQkpLL2l4eGh1bHRhN1FUY25yMzlrMnJZdlM4?=
 =?utf-8?B?WkM0TnU4YXNrQi9pcjQ2YU5id2FCcEgreThkR2xlTVQ0SitKWFJQL0dyUnBj?=
 =?utf-8?B?eU1hVWo3cFh1U1VRQVdnVGF5TnloTHFJU25zcks5WWFGZlB2U0hPem5ySkl2?=
 =?utf-8?B?NnVRUTQ5ZGlMTVQ4TFgxdjVHOU5uTlA0ZUxUaUFVU2ZpdnZxUVdBK3F4ejJh?=
 =?utf-8?B?Q28zWjVwendCbFo0RFcvTkZOM3hmdFZEQjA4MDdNMlJLU3p4WXBFSEFuNVBN?=
 =?utf-8?B?RlRqaWxzNHdxdkdMZ1dZVW5pZHV6MWRJT3Q0ak5XMk5tM285RTZhdXg3VEN3?=
 =?utf-8?B?YWtiYVlKY3AvUnZaYWl2LzRIZFJ6MDJldFhxRTJKVXFHUFRiNzkvQ0p2MDhI?=
 =?utf-8?B?Wk1GQ3F2Z1dqSnJPV05QUTFKVnZYV2xMVk1wc2IwV1BhQS9RZ2t4Nk5najBS?=
 =?utf-8?B?bXQxa3Ntay9Rd2pJSnBlUjljVi8yRUE4MU1sVWYvTXJRSnJhR1ZNb2lGUDFp?=
 =?utf-8?B?cUlzKzF0a3ozYTUzaDl0WGx0V3NmdFB3R1Zqb0x4YlExZ3lWTmdjTDgwLzRX?=
 =?utf-8?B?c0NRS01Heno5U3hyY2c0VElsTU9SQThrNHNWdHhIVWR3TnlSTVBVUlFRT3Vh?=
 =?utf-8?B?dStwRXRVRTRDaWtpTUh4L0JmL0VobHo2bjh5STZ5bU43L0lKN1RWV0tLcm5w?=
 =?utf-8?B?dTBQdXNQbG81WWtkUTlVMEVKRG1rQk9BSzFEbDVHV2QwVlFYVGdyM0NQOEFV?=
 =?utf-8?B?WGdJTFRjbERjLzlrZWt2ZW5EeDJ2NitCdXlxdGZNamthend1ZVNqMGdyOWJw?=
 =?utf-8?B?Q1B4N01aVFp4Y2ZaUWoxeUd4RHN1V3pUcFZQenFVNDJ1eUo1UVBoWklmeXB4?=
 =?utf-8?B?NTlYeWVzWVRxTXU2aGJBeFhjQXVBS0x4K1JZL1lhZVhMRFBKVzRlaFlUMmdV?=
 =?utf-8?B?aStKMlI5ZVZSakJOeEQwVThORHNOZ2tZZmFDWWVqZFJVT0svbXJodncrcGF4?=
 =?utf-8?B?QTR3aFRSRElQREhGYWhabjZMRHJFY1lmTHJkODVaNWs2cG11SVB3V0hvOE5i?=
 =?utf-8?B?Zm1HVFErdlZSVktqZWppdDR2SzByKzNraHZ3RWgvaHNNY3ZndW1GRFgyVmN4?=
 =?utf-8?B?ZVhlTFhZd0xYMVVmRFlBdy9UUEhhaDNCbjJndzJ6UTlkSml5TjFESE1raXc0?=
 =?utf-8?B?S1hBclc4VHB3cTllTzRVMXZ6WmxPZmtGN01oQVFiUDUvMWppODRoUTVtYkx4?=
 =?utf-8?B?M3dCcXZibS9JaWEvcENWTkVYRlQ5R1ZFZ3R1MDZVOCtxUytmaTRpalluL0Rs?=
 =?utf-8?B?dEhKUk14RnFaY0taeHFqeFdVc0lWYW1vTVAzakR4SHhmOTlESlJ3WkFPNCtn?=
 =?utf-8?B?bTJkOE9BRGIzTEhKaWFQOGsxMnBnTGgvOEJMNGtQdG9RbUJOd283TDNqVk83?=
 =?utf-8?B?T0lXOUhWNGxPVVZPYmFqaDNDUStUeGpVQm9ScGxtaE1jQmZGcWZIM2orOHZE?=
 =?utf-8?B?dXBELzNUcEZWWDN3Mk9Tano5NWh3T3UyQVJYZmVMREtSVy8xOHVUZXVhZmpG?=
 =?utf-8?B?QVpCZ2Rka3ordG1pM2hMeTZGc3IrSmxDLzJ4V0pYa2ZmRmRUTWZzVFJFbllv?=
 =?utf-8?B?bmJxTG1kZnN3YVBsSk92YWtOZDNaRmJjeG55TE1kR2FYTTh5WmVSTlZhWlo0?=
 =?utf-8?B?b1NaU1Z4NTM3dC9rWm0rNFFHOG5QS2VHb0RxMjhMSWpsYzVGb2RRK0huN3NH?=
 =?utf-8?B?dHNSSGs3Y2Y5TGgxVWZUa2xwdkc2T3l6N21MSmgrdXF6S2lYNUJyMHkrTHVn?=
 =?utf-8?B?bVJEN1gxQUgvdG1XMWFKbWZLM21ZMmRtcStBR3FyT3VxQUYvalVnM251dnc2?=
 =?utf-8?B?SFVWdDNHdGcxTTlIRENLSkRDOWtWYlkxNjBWMk9yVmNhaUxBenEwRndsTVRa?=
 =?utf-8?B?cmthaDZvREtoSURLNnZvVVY2a3BlWXEyb09CU1hHSWZBcFVkQytwZzNhNEtu?=
 =?utf-8?B?RE04L0hpUWdWekJHSjdEVENzWWNLMW9WSERmNFgzbld5ekI3RnZkZCt5Rm1q?=
 =?utf-8?B?NHRjWWhmUXdQSktHajkvdVBNU0lYUlZNNDZMWkhQVHlabkhDLzhEZGZ3L2Qr?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0C01643427FAE4FB5AAA3A1DED0FC79@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5580.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d204575a-d263-4bb5-dd84-08dbc29133f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2023 15:15:09.9923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mG+IvbpPlKYIOjH9YAop2HUt0RNboq5JYGCr4aHfbeH738jVNRsQLA7vMCz/90mKywSyL8pzuH3rFjlqrlMxfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6593
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTI5IGF0IDEyOjIxICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBXZWQsIFNlcCAyNywgMjAyMyBhdCAwMzo1NzozNVBNICswMDAw
LCBLdXlvIENoYW5nICjlvLXlu7rmlocpIHdyb3RlOg0KPiANCj4gPiBUaGlzIGlzc3VlIG9jY3Vy
cyBhdCBDUFUgaG90cGx1Zy9zZXRfYWZmaW5pdHkgc3RyZXNzIHRlc3QuDQo+ID4gVGhlIHJlcHJv
ZHVjZSByYXRpbyBpcyB2ZXJ5IGxvdyhhYm91dCBvbmNlIGEgd2VlaykuDQo+IA0KPiBJJ20gYXNz
dW1pbmcgeW91J3JlIHJ1bm5pbmcgYW4gYXJtNjQga2VybmVsIHdpdGggcHJlZW1wdF9mdWxsPXkg
KHRoZQ0KPiBkZWZhdWx0IGZvciBhcm02NCkuDQoNClllcywgdGhlIHRlc3QgcGxhdGZvcm0gaXMg
YXJtNjQgd2l0aCBrZXJuZWwgY29uZmlnIGFzIGJlbG93DQoNCkNPTkZJR19QUkVFTVBUX0JVSUxE
PXkNCkNPTkZJR19QUkVFTVBUPXkNCkNPTkZJR19QUkVFTVBUX0NPVU5UPXkNCkNPTkZJR19QUkVF
TVBUSU9OPXkNCkNPTkZJR19QUkVFTVBUX1JDVT15DQpDT05GSUdfSEFWRV9QUkVFTVBUX0RZTkFN
SUM9eQ0KQ09ORklHX0hBVkVfUFJFRU1QVF9EWU5BTUlDX0tFWT15DQpDT05GSUdfUFJFRU1QVF9O
T1RJRklFUlM9eQ0KDQo+IENvdWxkIHlvdSBwbGVhc2UgdGVzdCB0aGUgYmVsb3c/DQoNCk9rLCBs
ZXQgbWUgcnVuIGl0IGFuZCByZXBvcnQuDQoNCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9j
b3JlLmMgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQo+IGluZGV4IGQ4ZmQyOWQ2NmIyNC4uMDc5YTYz
YjhhOTU0IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvc2NoZWQvY29yZS5jDQo+ICsrKyBiL2tlcm5l
bC9zY2hlZC9jb3JlLmMNCj4gQEAgLTI2NDUsOSArMjY0NSwxMSBAQCBzdGF0aWMgaW50IG1pZ3Jh
dGlvbl9jcHVfc3RvcCh2b2lkICpkYXRhKQ0KPiAgICogaXQuDQo+ICAgKi8NCj4gIFdBUk5fT05f
T05DRSghcGVuZGluZy0+c3RvcF9wZW5kaW5nKTsNCj4gK3ByZWVtcHRfZGlzYWJsZSgpOw0KPiAg
dGFza19ycV91bmxvY2socnEsIHAsICZyZik7DQo+ICBzdG9wX29uZV9jcHVfbm93YWl0KHRhc2tf
Y3B1KHApLCBtaWdyYXRpb25fY3B1X3N0b3AsDQo+ICAgICAgJnBlbmRpbmctPmFyZywgJnBlbmRp
bmctPnN0b3Bfd29yayk7DQo+ICtwcmVlbXB0X2VuYWJsZSgpOw0KPiAgcmV0dXJuIDA7DQo+ICB9
DQo+ICBvdXQ6DQo+IEBAIC0yOTY3LDEyICsyOTY5LDEzIEBAIHN0YXRpYyBpbnQgYWZmaW5lX21v
dmVfdGFzayhzdHJ1Y3QgcnEgKnJxLA0KPiBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHN0cnVjdCBy
cV9mbGFnDQo+ICBjb21wbGV0ZSA9IHRydWU7DQo+ICB9DQo+ICANCj4gK3ByZWVtcHRfZGlzYWJs
ZSgpOw0KPiAgdGFza19ycV91bmxvY2socnEsIHAsIHJmKTsNCj4gLQ0KPiAgaWYgKHB1c2hfdGFz
aykgew0KPiAgc3RvcF9vbmVfY3B1X25vd2FpdChycS0+Y3B1LCBwdXNoX2NwdV9zdG9wLA0KPiAg
ICAgIHAsICZycS0+cHVzaF93b3JrKTsNCj4gIH0NCj4gK3ByZWVtcHRfZW5hYmxlKCk7DQo+ICAN
Cj4gIGlmIChjb21wbGV0ZSkNCj4gIGNvbXBsZXRlX2FsbCgmcGVuZGluZy0+ZG9uZSk7DQo+IEBA
IC0zMDM4LDEyICszMDQxLDEzIEBAIHN0YXRpYyBpbnQgYWZmaW5lX21vdmVfdGFzayhzdHJ1Y3Qg
cnEgKnJxLA0KPiBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHN0cnVjdCBycV9mbGFnDQo+ICBpZiAo
ZmxhZ3MgJiBTQ0FfTUlHUkFURV9FTkFCTEUpDQo+ICBwLT5taWdyYXRpb25fZmxhZ3MgJj0gfk1E
Rl9QVVNIOw0KPiAgDQo+ICtwcmVlbXB0X2Rpc2FibGUoKTsNCj4gIHRhc2tfcnFfdW5sb2NrKHJx
LCBwLCByZik7DQo+IC0NCj4gIGlmICghc3RvcF9wZW5kaW5nKSB7DQo+ICBzdG9wX29uZV9jcHVf
bm93YWl0KGNwdV9vZihycSksIG1pZ3JhdGlvbl9jcHVfc3RvcCwNCj4gICAgICAmcGVuZGluZy0+
YXJnLCAmcGVuZGluZy0+c3RvcF93b3JrKTsNCj4gIH0NCj4gK3ByZWVtcHRfZW5hYmxlKCk7DQo+
ICANCj4gIGlmIChmbGFncyAmIFNDQV9NSUdSQVRFX0VOQUJMRSkNCj4gIHJldHVybiAwOw0KPiBA
QCAtOTQ1OSw2ICs5NDYxLDcgQEAgc3RhdGljIHZvaWQgYmFsYW5jZV9wdXNoKHN0cnVjdCBycSAq
cnEpDQo+ICAgKiBUZW1wb3JhcmlseSBkcm9wIHJxLT5sb2NrIHN1Y2ggdGhhdCB3ZSBjYW4gd2Fr
ZS11cCB0aGUgc3RvcCB0YXNrLg0KPiAgICogQm90aCBwcmVlbXB0aW9uIGFuZCBJUlFzIGFyZSBz
dGlsbCBkaXNhYmxlZC4NCj4gICAqLw0KPiArcHJlZW1wdF9kaXNhYmxlKCk7DQo+ICByYXdfc3Bp
bl9ycV91bmxvY2socnEpOw0KPiAgc3RvcF9vbmVfY3B1X25vd2FpdChycS0+Y3B1LCBfX2JhbGFu
Y2VfcHVzaF9jcHVfc3RvcCwgcHVzaF90YXNrLA0KPiAgICAgIHRoaXNfY3B1X3B0cigmcHVzaF93
b3JrKSk7DQo+IEBAIC05NDY4LDYgKzk0NzEsNyBAQCBzdGF0aWMgdm9pZCBiYWxhbmNlX3B1c2go
c3RydWN0IHJxICpycSkNCj4gICAqIHdoaWNoIGt0aHJlYWRfaXNfcGVyX2NwdSgpIGFuZCB3aWxs
IHB1c2ggdGhpcyB0YXNrIGF3YXkuDQo+ICAgKi8NCj4gIHJhd19zcGluX3JxX2xvY2socnEpOw0K
PiArcHJlZW1wdF9lbmFibGUoKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgYmFsYW5jZV9w
dXNoX3NldChpbnQgY3B1LCBib29sIG9uKQ0K
