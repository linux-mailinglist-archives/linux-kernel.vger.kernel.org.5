Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EF575BC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 03:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjGUB7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 21:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGUB7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:59:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F38270B;
        Thu, 20 Jul 2023 18:59:07 -0700 (PDT)
X-UUID: 2a289ce4276a11eeb20a276fd37b9834-20230721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=m618rLBF3iV9ham+Aqm8xsAsgqCYYQRqc/OCawhyMwA=;
        b=EFH8GQSmj9vTxl/boin/WBxPSgH5g7fXl4zDXJKYjw3RK2Q6GfHXcK6so7lI32rv7UeKmUM6QkHF9i1tGuFtW0pPEl/QCUFC8FD9oJtkEDEjFbe/oDQcuht3QnyFwLTE3xQf7PrRt7t0ePDckKwefAzi2gfOEemgIGvHxc+gSE8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:5f4d0ef6-cf1a-46f4-9a69-bbc3a23ba051,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.28,REQID:5f4d0ef6-cf1a-46f4-9a69-bbc3a23ba051,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:176cd25,CLOUDID:bc84dd87-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:230721042221000MZVSE,BulkQuantity:7,Recheck:0,SF:38|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-UUID: 2a289ce4276a11eeb20a276fd37b9834-20230721
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1377904553; Fri, 21 Jul 2023 09:59:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jul 2023 09:59:01 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jul 2023 09:59:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE1bAYfoEvGHq2tyQ0XCVlAoNssbWB8zdS7Hn8keDjlYPma945mIukONYZbic4ZyTCGhAtXxa0TN7sj0Qf5a7j3QvisYf63uALEjwDyPcB54lH+E6Twls1bqUkE/t4Gev1O0nj289C9J5Ths9CvgaY8odnXgJhcP50becLD2+W3S2jaTK5DdwFdxpupQlYMTVPi9/gPFl8xi8Qt5RdsyRzO24FbXheLXi2W/xs0r2iNDQyNdq0VOX6dhbjXKSqS/Ue2GBUJp47XRC2G+0moAggSlQiIjkNVjOTklzfIqWiI64mmtxTrh0fVVO5IZI2Wvt8aqDxIj6vZAMg42yFo30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m618rLBF3iV9ham+Aqm8xsAsgqCYYQRqc/OCawhyMwA=;
 b=aC9uDXQ8oc1HkjLoBGPZyuPZRnEqyJgxOGhrLmqzLamhOy835+94IV8VGuTLDaIhsXni7WtV43P+t3bDpmR3laBDg0odY/OHGo4xdaQXdZ4nthAawdkEhCw3kpx4fx02PZC6apZe/xHcDszvLjqoXXWbFmvJHfDUZrr1zVrf9lsZEDcAp7eKdC4q3LgSUD49wALvlZaj/VtD1sNypVfWY+leH/L8vHu/2n+mthALJqVBGk1cJ6RNeh/e40ohy64GTZYurlNLWmc/NLvTVwGRlQsko8fVm55NMie8KZw3CN+Y5rFMYoI69v0N5BWhNPxt3kRE8D9w4U7mcuQyB7Jw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m618rLBF3iV9ham+Aqm8xsAsgqCYYQRqc/OCawhyMwA=;
 b=TRzCglnjrPucYJiJVPFXcHFU98gA+9Y/uRLgvCbDji0Bq6ZJtvdJMK8ANgjZCX9/zlDZw/veU/CPmvi6yUsvLodjjmpo74BrZOheFlgQ5kN3JWkcVoHsFiVy6/1bo3J6soljzQLNIkK1arMhjOnTY3W5o9HBGBDKPIgMDclzcCY=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SEYPR03MB7986.apcprd03.prod.outlook.com (2603:1096:101:168::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 01:58:56 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::b637:cc4e:c9bd:64d]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::b637:cc4e:c9bd:64d%3]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 01:58:56 +0000
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
Subject: Re: [PATCH 1/2] media: mediatek: vcodec: checking decoder ack message
 parameter
Thread-Topic: [PATCH 1/2] media: mediatek: vcodec: checking decoder ack
 message parameter
Thread-Index: AQHZuIal7FHnO7WCh0KfYXT25uw+a6/DHqYAgABeG4A=
Date:   Fri, 21 Jul 2023 01:58:56 +0000
Message-ID: <9c4fc4ec11988b7068ed0f8ae4bf5e969383979d.camel@mediatek.com>
References: <20230717081319.12542-1-yunfei.dong@mediatek.com>
         <02e3f58e3dc009eadd1f37ac3d7d65a95706c9a6.camel@collabora.com>
In-Reply-To: <02e3f58e3dc009eadd1f37ac3d7d65a95706c9a6.camel@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SEYPR03MB7986:EE_
x-ms-office365-filtering-correlation-id: 239e1065-f1cc-41e7-0e21-08db898e0ad0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2PsebLHqYvicIpdD4UZMNGQ/CX7NANy/O1inAdv/JMYnhjhraSBoHiCQswXFC4By20Hvqg++jc8ZMR+J3h5upFjZYNII1ETbeyaEisKbtv4zC2vhxIgG/tdqZNn/VAQFNke6oyX3ysyQGYm/TkubjiHu5Ow6P+Wsp6dgPII9lCXAPner9LTz+3IqERS0zuAtqy/s4zlWUV/2pVXdM8ximDTsLdcwdL2hK52IT6oP+0TIWxKcDPnXhnOHs/8R6rnOXeU36brAaZlolCfiDfLsOkCu14sNTPHwLkA9Tfud5HhQq3awDMT6HD5PHJXKtG6rl9eWNLqgr5QQ2JObOWyHaWqfRZD0nMC0DnxKIM7D5+9zJ71D/tYSf7wcycMCvTB7dqVo6laaJgaDQtTD85auVCzmy0wihpfVwlNFlZtFd/yiW1rT+GGqB9y42PCeJn4F+KikMTaxL3WnN8sN+ELd+Zf0nXSmI96QBnp+dfk+ZLv8mLGQqpVnohIKPSj+ji5ycE7DClQ3Y6AEgkBItGBHfiXtwTnBySPzkILMexTTED7o0o/LDix4GB3MijFhTn3+X48ErVY5Wg44IgpooELTb8+Go8Dpt0D95ej3IwVBPggrnH+niv9D2GYxQrkQaL8cYknfnT5ZFXffTOyfmvuKZkKVLvLxZFHGYcRUrXd2YHnfvqv/A1+RxCGB8AnwWgFB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(478600001)(6486002)(91956017)(54906003)(110136005)(71200400001)(2616005)(86362001)(66574015)(85182001)(36756003)(38070700005)(15650500001)(2906002)(122000001)(4326008)(26005)(186003)(6512007)(6506007)(83380400001)(64756008)(38100700002)(76116006)(8936002)(5660300002)(8676002)(41300700001)(66476007)(7416002)(66946007)(316002)(66556008)(66446008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFZwWmJCZUNMZWdkUGxZQTA1RDlDZVgyVmRSL1FVbGFrVGgzYTdBanRYYTdU?=
 =?utf-8?B?NWw3aE9MMENUMmdUUlFFN3h0OFZrUE9DSTc2cGNlQXZYRmVsWnNtMnd2UWc3?=
 =?utf-8?B?Uno3MEM1WU9OVUZvc2t5dkgwR0haTnJvUDJmRm5YRmZxQmxrcFlTdGF5VHN0?=
 =?utf-8?B?Vml3dDJiZko0djZuNnd5bDJ1OHo2UWpXT0dqbEJBSlF2UDhFOXkrakRBQ1J5?=
 =?utf-8?B?OXNOQjhyOG5USlhpRUI0L1VZNHVjV3UxTGVLYklBQ3lpK0dMV1F6V0pqZkVM?=
 =?utf-8?B?bXkyenkrdWo3V0hWV0VWb2xMU3FOakNOTEdjRS9LK3ZWWXM2RmFDNFVQajVL?=
 =?utf-8?B?M1VrWCtTTlBVWmlLSHFYNGhTL3NGWUVaVmhNdWhibTJ5NlpWNndNL29OVWVi?=
 =?utf-8?B?eGJ1WmR0ZmJpQWVSaDhBRllpdTBvRXFVYk1CU0VUV0RFTzBRN2hXenU3dk0y?=
 =?utf-8?B?d2pvV3lkNWxsL0diMktHbEhtL2x6Nk1NOWZhVTZLa0dRU3phMHJValluOWxt?=
 =?utf-8?B?cjdacXJWTWVGWlVZTHR1a1kySnNscXExZWU4WFJzWE40QmsvNkI5bzRrREZq?=
 =?utf-8?B?SE11NUlCZmxGUllFREFEdER4T2M5K1NHR1NxSXlPNFBQYnFMLzRwajZyYkcy?=
 =?utf-8?B?NllseUpYZXU4WFFxbDFCMUF5aWMwdkRYYUpvRFJ1SHIySzJuN0ZrWVRwWXJM?=
 =?utf-8?B?dEU5ZFdJd3VpUDJpRTMvVzN3QWJUREIwNklFNm5TWUJ0ZFpWOG1nZnJhOFZa?=
 =?utf-8?B?bW1lN3VPUGk5V3VvM1phNEE0NjZ5NG5pK1NuMDR6T1pBelNYRjhLZjFQd1Y0?=
 =?utf-8?B?dWVJTDBHUVVBM2MxdTNFRWFHWmdDTzhQQU84dWYra1YvMCtCUXVMWjNpTVpB?=
 =?utf-8?B?NmMxdE5yTFc1MFZ1bUx4UFMySmRvcXRTLzVRNks0TndSd1FSZlhwL1ZFaUFn?=
 =?utf-8?B?bi9jZzB6NWh2TFN2bXV3WStyV3NiYlFaVDFDQzVCcXk3U282VWlDbVZvTVdP?=
 =?utf-8?B?YXhWbUh3OFIvWkZSOEpmMUZmT0lLSnlFRDFDWVhRSGFuYTJQcnhPNG80ZzZC?=
 =?utf-8?B?djMzMDhMOWxpMFcyTnM2WEp2aWFVbnlmMnBSb1BtZnJuMGhYR1JraVg2M09p?=
 =?utf-8?B?T2g3YTRVOG8rZ3BzTFllSEQxQmxSOFVoNjlIN1RFT0xBalJ1RktpOU1aTGpU?=
 =?utf-8?B?NTJsdnFwMXVPeFQzUVVlZXlBL1Z5a2MzTE1VUS8zc1ZrdnE3eVFZenhvdGVx?=
 =?utf-8?B?R1RtZFhYUmJndmJ0eXFoV1A1VU92Mkh4MVM3VjNoQUduNm9kRDNncWQ2akhK?=
 =?utf-8?B?Ny90WXVpSGdSUUluOUJtVXN4bDBKM2lZNnQ5bWl2Qm52dWxPdDRkTy9GQlBu?=
 =?utf-8?B?QzVMZlhiRHhXckM1djUvRThCNnNCZm1JKzVqMEdnWUdHNGhVRlFMejlicUdj?=
 =?utf-8?B?T2JYdDZ3SUcybVVKRVRiU0wyV0QzM1d1VVJOOG05K2RDUnhoMXJUMGxDdTJB?=
 =?utf-8?B?cndMdDR3K21SYmNJK2NOU2RiT05kUDdIUzR1Slhzckl2cFUwRUxwSWo2Zk9V?=
 =?utf-8?B?a04xVjBHV0VYQnE5SDE4OGlhbDVYS1RnWHhpSjZpWm82Zm0yNzNQRndpaDRx?=
 =?utf-8?B?VHZKcjRLWVpyQisvK0EyZUF3MzFvQXN0S1NPVENWbFl3YnpTUGhUenZ2OVFQ?=
 =?utf-8?B?aEY5ck5sRGtRbjZoVm54RXh5QUJabTBrNTJJWCt2ZTBiK3grcVRhdVZiOWxW?=
 =?utf-8?B?ZlZKTmtxZ1lvM1ZYUUZkRS90VnRMdGtWVk9nTkFHbFdBdllMWUxNc0ZmR2Rx?=
 =?utf-8?B?aEZwM2hTZDdIaVl4alZzK2tzMGs3WDZKOE9lVitpTm8wWEx5d0VwQnEySVAx?=
 =?utf-8?B?ZkQ0Ti92R1MrdDZhODV3bVhkUjJwUWZCcWMrNkd2WGRVOHJVMHdaSXJYMExE?=
 =?utf-8?B?MzUxVWVvOWg5alBibEVyeWRYMld5eHA2VW52T2hRZzIyWE9yOTEwdHh6MzND?=
 =?utf-8?B?ajdLNzc5Y3R0K1JxUU9xYkdOeW5aUEYwM082RkpEaVRYL3luWFMybVRrc0JJ?=
 =?utf-8?B?WDFoLytOZ2drNDFLeURtcWtBUnNQbllCblRKaHFsQURZbXNUWnFkYjdlSmVU?=
 =?utf-8?B?ZStBeUJDM0VSUlJ6Qng4S0NNejhHQlpNeERwNTNmNHZoaVEvYnE2Q2VUcHo5?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B00C36F89B8ED94E9E9F79693D0136AA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239e1065-f1cc-41e7-0e21-08db898e0ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 01:58:56.2566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9iCe2c0DOw9em72+YkrnTALfNSETJ4blshn7+eZOSqYyGlB8hnYuujRWKSzePUITKA7koWvlndPPyYhoRZKcR7h6a7jCflXnvpoMGAnj1UE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7986
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KT24gVGh1LCAyMDIzLTA3
LTIwIGF0IDE2OjIyIC0wNDAwLCBOaWNvbGFzIER1ZnJlc25lIHdyb3RlOg0KPiBIaSwNCj4gDQo+
IExlIGx1bmRpIDE3IGp1aWxsZXQgMjAyMyDDoCAxNjoxMyArMDgwMCwgWXVuZmVpIERvbmcgYSDD
qWNyaXQgOg0KPiA+IE5lZWQgdG8gY2hlY2tpbmcgYWxsIHBhcmFtZXRlcnMgb2YgbXNnIGRhdGEg
YXJlIHZhbGlkIG9yIG5vdCwNCj4gPiBpbiBjYXNlIG9mIGFjY2VzcyBudWxsIHBvaW50ZXIgb3Ig
dW5yZWFzb25hYmxlIHZhbHVlIGxlYWRpbmcNCj4gPiB0byBrZXJuZWwgcmVib290Lg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIC4uLi92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19kcnYuaCAg
ICAgICB8ICAyICsNCj4gPiAgLi4uL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWNfdnB1X2lm
LmMgICAgIHwgNzcgKysrKysrKysrKysrLS0tDQo+ID4gLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDUyIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQNCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIv
bXRrX3Zjb2RlY19kZWNfZHJ2DQo+ID4gLmgNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
bWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfZHJ2DQo+ID4gLmgNCj4gPiBp
bmRleCBjOGI0Mzc0YzVlNmMuLjFlYTVkYmI0NzVkZCAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19k
ZWNfZHJ2DQo+ID4gLmgNCj4gPiArKysNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVk
aWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfZHJ2DQo+ID4gLmgNCj4gPiBAQCAt
MTYwLDYgKzE2MCw3IEBAIHN0cnVjdCBtdGtfdmNvZGVjX2RlY19wZGF0YSB7DQo+ID4gICAqIEBo
d19pZDogaGFyZHdhcmUgaW5kZXggdXNlZCB0byBpZGVudGlmeSBkaWZmZXJlbnQgaGFyZHdhcmUu
DQo+ID4gICAqDQo+ID4gICAqIEBtc2dfcXVldWU6IG1zZyBxdWV1ZSB1c2VkIHRvIHN0b3JlIGxh
dCBidWZmZXIgaW5mb3JtYXRpb24uDQo+ID4gKyAqIEB2cHVfaW5zdDogdnB1IGluc3RhbmNlIHBv
aW50ZXIuDQo+ID4gICAqLw0KPiA+ICBzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfY3R4IHsNCj4gPiAg
CWVudW0gbXRrX2luc3RhbmNlX3R5cGUgdHlwZTsNCj4gPiBAQCAtMjAyLDYgKzIwMyw3IEBAIHN0
cnVjdCBtdGtfdmNvZGVjX2RlY19jdHggew0KPiA+ICAJaW50IGh3X2lkOw0KPiA+ICANCj4gPiAg
CXN0cnVjdCB2ZGVjX21zZ19xdWV1ZSBtc2dfcXVldWU7DQo+ID4gKwl2b2lkICp2cHVfaW5zdDsN
Cj4gPiAgfTsNCj4gPiAgDQo+ID4gIC8qKg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvdmRlY192cHVfaWYuYw0KPiA+
IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci92ZGVjX3Zw
dV9pZi5jDQo+ID4gaW5kZXggODJjM2RjOGM0MTI3Li4yM2NmZTVjNmM5MGIgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci92ZGVj
X3ZwdV9pZi5jDQo+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29k
ZWMvZGVjb2Rlci92ZGVjX3ZwdV9pZi5jDQo+ID4gQEAgLTcyLDYgKzcyLDIxIEBAIHN0YXRpYyB2
b2lkIGhhbmRsZV9nZXRfcGFyYW1fbXNnX2Fjayhjb25zdA0KPiA+IHN0cnVjdCB2ZGVjX3ZwdV9p
cGlfZ2V0X3BhcmFtX2FjayAqbXMNCj4gPiAgCX0NCj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGlj
IGJvb2wgdnB1X2RlY19jaGVja19hcF9pbnN0KHN0cnVjdCBtdGtfdmNvZGVjX2RlY19kZXYNCj4g
PiAqZGVjX2Rldiwgc3RydWN0IHZkZWNfdnB1X2luc3QgKnZwdSkNCj4gPiArew0KPiA+ICsJc3Ry
dWN0IG10a192Y29kZWNfZGVjX2N0eCAqY3R4Ow0KPiA+ICsJaW50IHJldCA9IGZhbHNlOw0KPiA+
ICsNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnkoY3R4LCAmZGVjX2Rldi0+Y3R4X2xpc3QsIGxp
c3QpIHsNCj4gDQo+IEknbSBub3QgcXVpdGUgZnVsbHkgYXdhcmUgb2YgdGhlIHRocmVhZGluZyBt
b2RlbCBpbiBwbGFjZSwgYnV0IHRoaXMNCj4gY3R4X2xpc3QgaXMNCj4gbm9ybWFsbHkgcHJvdGVj
dGVkIGJ5IGRldi0+ZGV2X211dGV4LCBhbmQgaXMgbm90IGJlaW5nIHByb3RlY3RlZA0KPiBoZXJl
LiBJIGFsc28NCj4gZG9uJ3Qga25vdyB3aGljaCB0eXBlIG9mIGludGVycnVwdCBoYW5kbGVyIHdl
IGFyZSBpbiBoZXJlLg0KPiANCklmIHRoZSBkZXZpY2UgaXMgb3BlbmVkLCBvbmUgY3R4IHdpbGwg
YmUgaW5zZXJ0ZWQgdG8gY3R4X2xpc3QsIHRoZW4gdGhlDQpoYW5kbGVyIGludGVyZmFjZSB3aWxs
IGJlIGNhbGxlZC4gDQoNCjE6IFRoaXMgZnVuY3Rpb24ganVzdCB1c2VkIHRvIGNoZWNrIHdoZXRo
ZXIgdGhlIGNvbnRleHQgaXMgcmVhc29uYWJsZSwNCm5vIG5lZWQgdG8gYWRkIG11dGV4IHRvIHBy
b3RlY3QgYmVjYXVzZSB0aGUgY29udGV4dCBhbHJlYWR5IGluIGN0eF9saXN0DQppbiBvcGVkIHBl
cmlvZC4gVGhpcyBmdW5jdGlvbiB3b24ndCBiZSBjYWxsZWQgYWZ0ZXIgZGVpbml0IGN0eCBmcm9t
DQpjdHhfbGlzdC4NCg0KMjogVGhpcyBoYW5kbGVyIHdpbGwgYmUgY2FsbGVkIHdoZW4gYXAgc2Vu
ZCBtZXNzYWdlIHRvIHNjcC4NCg0KQmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCj4gPiArCQlp
ZiAoIUlTX0VSUl9PUl9OVUxMKGN0eCkgJiYgY3R4LT52cHVfaW5zdCA9PSB2cHUpIHsNCj4gPiAr
CQkJcmV0ID0gdHJ1ZTsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsN
Cj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIHZwdV9k
ZWNfaXBpX2hhbmRsZXIgLSBIYW5kbGVyIGZvciBWUFUgaXBpIG1lc3NhZ2UuDQo+ID4gICAqDQo+
ID4gQEAgLTg0LDQ0ICs5OSw1MSBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfZ2V0X3BhcmFtX21zZ19h
Y2soY29uc3QNCj4gPiBzdHJ1Y3QgdmRlY192cHVfaXBpX2dldF9wYXJhbV9hY2sgKm1zDQo+ID4g
ICAqLw0KPiA+ICBzdGF0aWMgdm9pZCB2cHVfZGVjX2lwaV9oYW5kbGVyKHZvaWQgKmRhdGEsIHVu
c2lnbmVkIGludCBsZW4sIHZvaWQNCj4gPiAqcHJpdikNCj4gPiAgew0KPiA+ICsJc3RydWN0IG10
a192Y29kZWNfZGVjX2RldiAqZGVjX2RldjsNCj4gPiAgCWNvbnN0IHN0cnVjdCB2ZGVjX3ZwdV9p
cGlfYWNrICptc2cgPSBkYXRhOw0KPiA+IC0Jc3RydWN0IHZkZWNfdnB1X2luc3QgKnZwdSA9IChz
dHJ1Y3QgdmRlY192cHVfaW5zdCAqKQ0KPiA+IC0JCQkJCSh1bnNpZ25lZCBsb25nKW1zZy0NCj4g
PiA+YXBfaW5zdF9hZGRyOw0KPiA+ICsJc3RydWN0IHZkZWNfdnB1X2luc3QgKnZwdTsNCj4gPiAg
DQo+ID4gLQlpZiAoIXZwdSkgew0KPiA+ICsJZGVjX2RldiA9IChzdHJ1Y3QgbXRrX3Zjb2RlY19k
ZWNfZGV2ICopcHJpdjsNCj4gPiArCXZwdSA9IChzdHJ1Y3QgdmRlY192cHVfaW5zdCAqKSh1bnNp
Z25lZCBsb25nKW1zZy0+YXBfaW5zdF9hZGRyOw0KPiA+ICsJaWYgKCFwcml2IHx8ICF2cHUpIHsN
Cj4gPiAgCQltdGtfdjRsMl92ZGVjX2Vycih2cHUtPmN0eCwgImFwX2luc3RfYWRkciBpcyBOVUxM
LCBkaWQNCj4gPiB0aGUgU0NQIGhhbmcgb3IgY3Jhc2g/Iik7DQo+ID4gIAkJcmV0dXJuOw0KPiA+
ICAJfQ0KPiA+ICANCj4gPiAtCW10a192ZGVjX2RlYnVnKHZwdS0+Y3R4LCAiKyBpZD0lWCIsIG1z
Zy0+bXNnX2lkKTsNCj4gPiArCWlmICghdnB1X2RlY19jaGVja19hcF9pbnN0KGRlY19kZXYsIHZw
dSkgfHwgbXNnLT5tc2dfaWQgPA0KPiA+IFZQVV9JUElNU0dfREVDX0lOSVRfQUNLIHx8DQo+ID4g
KwkgICAgbXNnLT5tc2dfaWQgPiBWUFVfSVBJTVNHX0RFQ19HRVRfUEFSQU1fQUNLKSB7DQo+ID4g
KwkJbXRrX3Y0bDJfdmRlY19lcnIodnB1LT5jdHgsICJ2ZGVjIG1zZyBpZCBub3QgY29ycmVjdGx5
DQo+ID4gPT4gMHgleCIsIG1zZy0+bXNnX2lkKTsNCj4gPiArCQl2cHUtPmZhaWx1cmUgPSAtRUlO
VkFMOw0KPiA+ICsJCWdvdG8gZXJyb3I7DQo+ID4gKwl9DQo+ID4gIA0KPiA+ICAJdnB1LT5mYWls
dXJlID0gbXNnLT5zdGF0dXM7DQo+ID4gLQl2cHUtPnNpZ25hbGVkID0gMTsNCj4gPiArCWlmICht
c2ctPnN0YXR1cyAhPSAwKQ0KPiA+ICsJCWdvdG8gZXJyb3I7DQo+ID4gIA0KPiA+IC0JaWYgKG1z
Zy0+c3RhdHVzID09IDApIHsNCj4gPiAtCQlzd2l0Y2ggKG1zZy0+bXNnX2lkKSB7DQo+ID4gLQkJ
Y2FzZSBWUFVfSVBJTVNHX0RFQ19JTklUX0FDSzoNCj4gPiAtCQkJaGFuZGxlX2luaXRfYWNrX21z
ZyhkYXRhKTsNCj4gPiAtCQkJYnJlYWs7DQo+ID4gKwlzd2l0Y2ggKG1zZy0+bXNnX2lkKSB7DQo+
ID4gKwljYXNlIFZQVV9JUElNU0dfREVDX0lOSVRfQUNLOg0KPiA+ICsJCWhhbmRsZV9pbml0X2Fj
a19tc2coZGF0YSk7DQo+ID4gKwkJYnJlYWs7DQo+ID4gIA0KPiA+IC0JCWNhc2UgVlBVX0lQSU1T
R19ERUNfU1RBUlRfQUNLOg0KPiA+IC0JCWNhc2UgVlBVX0lQSU1TR19ERUNfRU5EX0FDSzoNCj4g
PiAtCQljYXNlIFZQVV9JUElNU0dfREVDX0RFSU5JVF9BQ0s6DQo+ID4gLQkJY2FzZSBWUFVfSVBJ
TVNHX0RFQ19SRVNFVF9BQ0s6DQo+ID4gLQkJY2FzZSBWUFVfSVBJTVNHX0RFQ19DT1JFX0FDSzoN
Cj4gPiAtCQljYXNlIFZQVV9JUElNU0dfREVDX0NPUkVfRU5EX0FDSzoNCj4gPiAtCQkJYnJlYWs7
DQo+ID4gKwljYXNlIFZQVV9JUElNU0dfREVDX1NUQVJUX0FDSzoNCj4gPiArCWNhc2UgVlBVX0lQ
SU1TR19ERUNfRU5EX0FDSzoNCj4gPiArCWNhc2UgVlBVX0lQSU1TR19ERUNfREVJTklUX0FDSzoN
Cj4gPiArCWNhc2UgVlBVX0lQSU1TR19ERUNfUkVTRVRfQUNLOg0KPiA+ICsJY2FzZSBWUFVfSVBJ
TVNHX0RFQ19DT1JFX0FDSzoNCj4gPiArCWNhc2UgVlBVX0lQSU1TR19ERUNfQ09SRV9FTkRfQUNL
Og0KPiA+ICsJCWJyZWFrOw0KPiA+ICANCj4gPiAtCQljYXNlIFZQVV9JUElNU0dfREVDX0dFVF9Q
QVJBTV9BQ0s6DQo+ID4gLQkJCWhhbmRsZV9nZXRfcGFyYW1fbXNnX2FjayhkYXRhKTsNCj4gPiAt
CQkJYnJlYWs7DQo+ID4gLQkJZGVmYXVsdDoNCj4gPiAtCQkJbXRrX3ZkZWNfZXJyKHZwdS0+Y3R4
LCAiaW52YWxpZCBtc2c9JVgiLCBtc2ctDQo+ID4gPm1zZ19pZCk7DQo+ID4gLQkJCWJyZWFrOw0K
PiA+IC0JCX0NCj4gPiArCWNhc2UgVlBVX0lQSU1TR19ERUNfR0VUX1BBUkFNX0FDSzoNCj4gPiAr
CQloYW5kbGVfZ2V0X3BhcmFtX21zZ19hY2soZGF0YSk7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwlk
ZWZhdWx0Og0KPiA+ICsJCW10a192ZGVjX2Vycih2cHUtPmN0eCwgImludmFsaWQgbXNnPSVYIiwg
bXNnLT5tc2dfaWQpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCW10a192
ZGVjX2RlYnVnKHZwdS0+Y3R4LCAiLSBpZD0lWCIsIG1zZy0+bXNnX2lkKTsNCj4gPiArZXJyb3I6
DQo+ID4gKwl2cHUtPnNpZ25hbGVkID0gMTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIGlu
dCB2Y29kZWNfdnB1X3NlbmRfbXNnKHN0cnVjdCB2ZGVjX3ZwdV9pbnN0ICp2cHUsIHZvaWQNCj4g
PiAqbXNnLCBpbnQgbGVuKQ0KPiA+IEBAIC0xODIsOSArMjA0LDEwIEBAIGludCB2cHVfZGVjX2lu
aXQoc3RydWN0IHZkZWNfdnB1X2luc3QgKnZwdSkNCj4gPiAgDQo+ID4gIAlpbml0X3dhaXRxdWV1
ZV9oZWFkKCZ2cHUtPndxKTsNCj4gPiAgCXZwdS0+aGFuZGxlciA9IHZwdV9kZWNfaXBpX2hhbmRs
ZXI7DQo+ID4gKwl2cHUtPmN0eC0+dnB1X2luc3QgPSB2cHU7DQo+ID4gIA0KPiA+ICAJZXJyID0g
bXRrX3Zjb2RlY19md19pcGlfcmVnaXN0ZXIodnB1LT5jdHgtPmRldi0+ZndfaGFuZGxlciwNCj4g
PiB2cHUtPmlkLA0KPiA+IC0JCQkJCSB2cHUtPmhhbmRsZXIsICJ2ZGVjIiwgTlVMTCk7DQo+ID4g
KwkJCQkJIHZwdS0+aGFuZGxlciwgInZkZWMiLCB2cHUtDQo+ID4gPmN0eC0+ZGV2KTsNCj4gPiAg
CWlmIChlcnIpIHsNCj4gPiAgCQltdGtfdmRlY19lcnIodnB1LT5jdHgsICJ2cHVfaXBpX3JlZ2lz
dGVyIGZhaWwNCj4gPiBzdGF0dXM9JWQiLCBlcnIpOw0KPiA+ICAJCXJldHVybiBlcnI7DQo+ID4g
QEAgLTE5Myw3ICsyMTYsNyBAQCBpbnQgdnB1X2RlY19pbml0KHN0cnVjdCB2ZGVjX3ZwdV9pbnN0
ICp2cHUpDQo+ID4gIAlpZiAodnB1LT5jdHgtPmRldi0+dmRlY19wZGF0YS0+aHdfYXJjaCA9PQ0K
PiA+IE1US19WREVDX0xBVF9TSU5HTEVfQ09SRSkgew0KPiA+ICAJCWVyciA9IG10a192Y29kZWNf
ZndfaXBpX3JlZ2lzdGVyKHZwdS0+Y3R4LT5kZXYtDQo+ID4gPmZ3X2hhbmRsZXIsDQo+ID4gIAkJ
CQkJCSB2cHUtPmNvcmVfaWQsIHZwdS0NCj4gPiA+aGFuZGxlciwNCj4gPiAtCQkJCQkJICJ2ZGVj
IiwgTlVMTCk7DQo+ID4gKwkJCQkJCSAidmRlYyIsIHZwdS0+Y3R4LQ0KPiA+ID5kZXYpOw0KPiA+
ICAJCWlmIChlcnIpIHsNCj4gPiAgCQkJbXRrX3ZkZWNfZXJyKHZwdS0+Y3R4LCAidnB1X2lwaV9y
ZWdpc3RlciBjb3JlDQo+ID4gZmFpbCBzdGF0dXM9JWQiLCBlcnIpOw0KPiA+ICAJCQlyZXR1cm4g
ZXJyOw0KPiANCj4gDQo=
