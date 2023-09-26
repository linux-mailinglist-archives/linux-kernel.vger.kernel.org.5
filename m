Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821FD7AE3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjIZCp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjIZCpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:45:25 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8906410E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:45:12 -0700 (PDT)
X-UUID: b28977bc5c1611ee8051498923ad61e6-20230926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6g79sSSz9uPnI5f5CkrL2Cabxfzj8VDUeCxpwMg2BFg=;
        b=WJ7HNlHWfOeIS11BxSVFSDG/fzZ/n8EF6RloE5UGyzta+AC8X89Rmt0jCxNB5pkpk3qasSuQ861oW/TUsLvc0X7ft1gPs2Z9AodTKj0yfTcDVLm80aup7BcdNmjWIjYgpnGGIWUrKFyHM0eBYoqZb8qocmU2CZToqWO85hHudLM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:d5ff3b36-9967-4c79-afed-7465f8144406,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:aedc75c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b28977bc5c1611ee8051498923ad61e6-20230926
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 364259677; Tue, 26 Sep 2023 10:45:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Sep 2023 10:45:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Sep 2023 10:45:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF5jCpaggWJv4idzGs6R/3cBM69cDgBKqePEwK29qEKlpRGu5BAXg9zXS7bnqJVkkg45cbkffSZWlv8Gzj3/MD6523j49J0vXOaWkIwhysePftSGuw55xO7TeQ/6QANfWfpQ/c/D5n6+YK7JbYYuuVLhSzT5TcpyJHO5EromyCiAKWMpq7iTMXf2M14rDlTgZI9yZHXuRU0kJIY0RpKD+xmPD+FpyJ0sxx9fVMi/wATY12yGhRytuxceWD7uDotFUh4bDGLSsZ2xj9Jfb65O68GOHlXgmiWV8QCOibDRPRJ94yDNLKKaBy5dsRqOt87cInHyD0GpMsaXVUMpc0BCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g79sSSz9uPnI5f5CkrL2Cabxfzj8VDUeCxpwMg2BFg=;
 b=GRe0rTOsxwUQGNzrw5KZMBV3eiv9MtaaGgPP7O0zn6xYqs8c/KNuWA0yzmGZTb9jzXlDb6GdCQSLjc4rIffCPHHhmQeySkrs7FxZ+gw3G+gzTdqt9vng5hf6E59tJSeVLScqL3dEreOAw70/70Bg2d+zE7n8DtApe8pIGN1ivteAh7xQMa9pjFCpulq9B8DBsqGEuCo9c//ZsNb749u/q0FdElfOrZ3DYlNHleR+Sdex4U3RxAbQzLnzXYBlqg1iUmuhMQuhEfhiqkJnTpyy5EGAX/BpGzn2dgsE313n/ExFFa/i2D0G7K1D4hY/S+ZVlMPlfihW9f7T6SMKURAxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g79sSSz9uPnI5f5CkrL2Cabxfzj8VDUeCxpwMg2BFg=;
 b=DhHfZXnLSjtTNxS9y2+WjI4nZS0SDgiy/5K38y5IuG0Gs3itbn95qiiVB6CjbKN9yc2HYK15+3JmG2xghXhCMTQDcHJFmOANgqYPQcIb2ClVNDDuvV53HXc4O1z8/sfUve7BGmF7JcmH+x4nUpLHPfU1+kRGuAIyeUyM5PIsccA=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 PSAPR03MB6236.apcprd03.prod.outlook.com (2603:1096:301:9d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 26 Sep 2023 02:45:01 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::e148:3390:1eb2:28e3]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::e148:3390:1eb2:28e3%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 02:45:01 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "tjmercier@google.com" <tjmercier@google.com>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>
Subject: Re: [PATCH 1/4] iommu/mediatek: Initialise the secure bank
Thread-Topic: [PATCH 1/4] iommu/mediatek: Initialise the secure bank
Thread-Index: AQHZ5E3qysHKk79NkEWZcXv/xfoJu7AVWnwAgBY6mQCAAFbYAIAAklIA
Date:   Tue, 26 Sep 2023 02:45:01 +0000
Message-ID: <270e2eb010d33c8720a46dc33a44cdcda9d7277d.camel@mediatek.com>
References: <20230911011751.29906-1-yong.wu@mediatek.com>
         <20230911011751.29906-2-yong.wu@mediatek.com>
         <28b81a20-5cfa-b474-41c3-c01b7b846e21@collabora.com>
         <409168b540948d312a91022f375fa71a470e9d60.camel@mediatek.com>
         <869d9122-6187-47a0-0589-9feeafaf984c@baylibre.com>
In-Reply-To: <869d9122-6187-47a0-0589-9feeafaf984c@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|PSAPR03MB6236:EE_
x-ms-office365-filtering-correlation-id: 10d9de45-d0fa-43ff-19b1-08dbbe3a94b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ZfVbB/JMTM2P2te9fsJvDS0DfRqIXinAwzxtI0D/ET356ZafyK4U9J26NGYx3whMEjVac9xqAJZUm9zIBZ8Nxb/Vz3G6KqKV8Eg9wDWVqp8CBnSimh3nAwWPr/c2CrgOmK6lmctOROQUOwepOmGZpEiOn5+r38hTcNcd4CZERbsqI+X9OItdt74PonGCqxObc/IMebxUGn/mUBXNQjDB2QrZ8bRsqEWT3dkdLskPXnPi/RhokrKr11nptPhpdEyfOy6VMVUg6I6JQaASdlHGQMVKHYzg9C2cWdL+vVaauZc8IK7wX/coY6lJBvMhege8a2HBPXK+uan7c1947u6ZGF1ZpeFa0pnekmdsJAVJdPUlLql6apvQ6LwJo31UpRSkf4ut6y3RGeEpFuPwtTfnNNRW6S7sY/Q3iL/zfbfgwABAXfquxcGErCYoRMaWE2HX8pqwJdWzOlim1dBJuIqQQyjJPTab3uX5YbBMoIabPKlLNQBhbiEKJUlmM2IkI5xcRcLBhO9hhXjD1X2gffRqGOP8ZLWpOupvB6JZYi7z6at/CdYnchn6Kp1K//ijPpIQQOZ9QCzXNRkKA5ir0g5WQj6+uqnMiMep/SAuAuUOHVh8xgM0v0U9j9AtJDPTWkkp+3AVEDQq2yoon78vSk0x+cl4Iv88DFxmtrBXG42PvYVrKcK10YCNI5I9nwrQI0S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(186009)(1800799009)(451199024)(38070700005)(36756003)(122000001)(38100700002)(85182001)(86362001)(76116006)(53546011)(15650500001)(6512007)(5660300002)(66476007)(2906002)(2616005)(66446008)(478600001)(41300700001)(316002)(66556008)(54906003)(64756008)(110136005)(83380400001)(66946007)(7416002)(6506007)(71200400001)(6486002)(107886003)(4326008)(8936002)(8676002)(26005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEc4QVkybStORVdEVVV5LzZ2RmVldEx0ZmhFaGlQN3kxUEZaY2NaWStrNE9Y?=
 =?utf-8?B?L20xN0hsdWF5RHBERXRWV1l3bWFqVUtZOStwdm9zWHhXU01XRU9SOEtHKzdy?=
 =?utf-8?B?RlVVMWpDUS96Y1B6VDYva2p2L0YxcEM3ZlVPOGNIdmIyNjM0RjZxQkNtc25n?=
 =?utf-8?B?YUlKYncra1NBdzlndXFWUkZiQnNJSzdKOXBYNVJreVYzVnVBRURwOUlPbkdF?=
 =?utf-8?B?VHd4R3ZYa1lVRmtlcm9aV2xZV1pvckRDcUtvVUkyMTVUT1FqUXpGdi9QSjZH?=
 =?utf-8?B?M1hrUDhLQkxObGJTb00wbUtwV0VIY2xYOWZrbEZaOS95THNhWmpzYXIrckZK?=
 =?utf-8?B?SUFOTFRDQzJKQTVNZDRRYmg5QmtDQ1daVDNMR081dHBqUytTMTlqWFBvTlRr?=
 =?utf-8?B?VUVsL3cwZ1M0RXpMMDlLUllvUnM5bkhKc3hSVHZEVXFER0xDK1psZVZ3R29u?=
 =?utf-8?B?WENvWE1HSHZlTCt6WTFBY2cyREg5WUh0WDhBWkJOU3dSL3R5dldwTzNxRHEw?=
 =?utf-8?B?NEdtZmRnWkFyQW5DelJzREpFekQ5RFB4bGFpOWZxVXlhVWc1c1FSQ3RrM1gx?=
 =?utf-8?B?Q2R6WXVBUG4vSXVmWFk3Zksvd1FERk1tQVM4UTh0NG1mVnZrQkVQUEt0cHUr?=
 =?utf-8?B?UElZQjE0dTdFdWVYbmlHUjFhSGJwa0hadXhCTTEwdWlUeDdkMDlpSFhEa0M5?=
 =?utf-8?B?Wi9ya25veGV4MkFTQVR4UHBRTExpcmVicVlBZVNhQ0xEWDQ4NzJ2bFFwMDdC?=
 =?utf-8?B?R202YURqeWNJeUNIMW1UUWgrR0svYjNkd1dPZUsyQzhzemdUTVhWampma3h6?=
 =?utf-8?B?cnBTSlkwWDh4aE9sbi84ZjRUTnFRK1ZLbVA2eVR4KzJOcHhZdm1IRTZESTZC?=
 =?utf-8?B?Q2NlTEw4ajNzS0FjZmR6a0tETGNvUXVCVTliQlR6eG1IV1ZXMVhuNVpGdnRL?=
 =?utf-8?B?a0QyUWtmOU9CRzU2akQvb0xJTEdqWGZ6Q25CM3E5ZTNiS3VzUTc5UmtPRlJo?=
 =?utf-8?B?anpkbzZoTEQ3MWViS2tmc3BCMGdCNHJJTnEvM1gzSkZxOUd0NjNVR09FaWFO?=
 =?utf-8?B?WG9ZbUQvQ0pRUjZJWHZaZEFTa25vWDVOTUhkcmNGenNreThrRjVNV3B0Z2hL?=
 =?utf-8?B?M2NSR25aN0xGd3JIUVNPRG0zYTUrREo4RytFcHBZUUtEK1hFanhtSUV5Y1k5?=
 =?utf-8?B?WEJnOUZKUUV0NE4zUDBLWGhDY3lNOXJqYlpweUhXcmkxSE1yUW1RRkt0cjZO?=
 =?utf-8?B?YnU1bHRsUjNUMTBOQmNkbEZiR2l4M0QyVzBtbXpaVld6SzVDTkp2andXejRC?=
 =?utf-8?B?dUtxUkVSekhvY3VHRkNrMTFXcGNlN216cDhmbThsa1lJU1pWZ3NXZXdKSWhl?=
 =?utf-8?B?TVgyT2dvSk1xVkRvVUZ4Z0ZvQWpwVTdqaW10TkU2bEl0YXUybDRwK1ZWazhY?=
 =?utf-8?B?cWJDRHppNCs2QWp6Y09yODZ2QjV2MVZDRVZIcDlabUs4UzB3Ukc1T3JLaXpz?=
 =?utf-8?B?M09nU09wZXZrNS9Ib0gzYm91ZGtaQ2tQbGJXMGErRCs2Q2xsMlVqUU1ZRDVK?=
 =?utf-8?B?endIeGZQdzBVOCtJUlRTMDVhMW5EZXNFblV1R3ZkblBYZEJVOHo2QTllbUpS?=
 =?utf-8?B?b05jL0grL3RKZEMzMzNvem1LcU9FWm0ya1ZNVWxVbXpUUGtEbi9JVVQweHd0?=
 =?utf-8?B?THlWRTQ5T1JKdm1KWktVbGFuZnZ1U3JzNlY2QW5IQnh2UzRXZDFDbmxnRWJx?=
 =?utf-8?B?MDUwWkRzcWRKMS9JQ0RINlpEdktpVExXQmhZRGxweFRpd3BKVXUrUTVEeHJa?=
 =?utf-8?B?b0RsTURuNXdsMzhXeEo5RytNUk9LOS9BN2haZkwydk9UWGIvRjBHVjhyWG9j?=
 =?utf-8?B?MW41OElob1RXNkVEeWlyd0M0OUxRS0E3TE5UaWw5eVk2SGFrOWJ5WEVOOEln?=
 =?utf-8?B?Znh4WWcwdHN6L2FhL0gzcG0vVWNsUTdaT3lqK1RqZ0tPZ1RSZC9ULzRKaXMv?=
 =?utf-8?B?ZkNYWmlDUUQ1NUhpZXBSdzRNbzZTTzk5SFdBU1I2Z2NKc3dZZlRGRUxCQ1ZD?=
 =?utf-8?B?WkpLTFNkVjc2YXZ0c01tV3o3a0cxKzhxc0p6SXlla1JFYkhtVFM4SGJYcUQ4?=
 =?utf-8?Q?RYb/ec0VjX4QLLuv2WnQCoWq/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1EE195C25C1054C9727C98E0FEFB128@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d9de45-d0fa-43ff-19b1-08dbbe3a94b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 02:45:01.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4ACMDM9szXOAS5nDwCpDPRnsHCjRoLi5vTLay/rL7lC8dBEOWIedSRntY2yGlY9H/Jchdqj5o6HuEkVkB2IxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6236
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

T24gTW9uLCAyMDIzLTA5LTI1IGF0IDIwOjAxICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ICANCj4gDQo+IE9uIDI1LzA5LzIwMjMgMTQ6NTAsIFlvbmcgV3Ug
KOWQtOWLhykgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIzLTA5LTExIGF0IDExOjIyICswMjAwLCBB
bmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiB3cm90ZToNCj4gPj4gSWwgMTEvMDkvMjMgMDM6
MTcsIFlvbmcgV3UgaGEgc2NyaXR0bzoNCj4gPj4+IFRoZSBsYXN0ZXN0IElPTU1VIGFsd2F5cyBo
YXZlIDUgYmFua3MsIGFuZCB3ZSBhbHdheXMgdXNlIHRoZSBsYXN0DQo+ID4+PiBiYW5rDQo+ID4+
PiAoaWQ6NCkgZm9yIHRoZSBzZWN1cmUgbWVtb3J5IGFkZHJlc3MgdHJhbnNsYXRpb24uIFRoaXMg
cGF0Y2ggYWRkDQo+IGENCj4gPj4+IG5ldw0KPiA+Pj4gZmxhZyAoU0VDVVJFX0JBTktfRU5BQkxF
KSBmb3IgdGhpcyBmZWF0dXJlLg0KPiA+Pj4NCj4gPj4+IEZvciB0aGUgc2VjdXJlIGJhbmssIGl0
cyBrZXJuZWwgdmEgImJhc2UiIGlzIG5vdCBoZWxwZnVsIHNpbmNlDQo+IHRoZQ0KPiA+Pj4gc2Vj
dXJlIGJhbmsgcmVnaXN0ZXJzIGhhcyBhbHJlYWR5IGJlZW4gcHJvdGVjdGVkIGFuZCBjYW4gb25s
eSBiZQ0KPiA+Pj4gYWNjZXNzZWQNCj4gPj4+IGluIHRoZSBzZWN1cmUgd29ybGQuIEJ1dCB3ZSBz
dGlsbCByZWNvcmQgaXRzIHJlZ2lzdGVyIGJhc2UsDQo+IGJlY2F1c2UNCj4gPj4+IHdlIG5lZWQN
Cj4gPj4+IHVzZSBpdCB0byBkZXRlcm1pbmUgd2hpY2ggSU9NTVUgSFcgdGhlIHRyYW5zbGF0aW9u
IGZhdWx0IGhhcHBlbg0KPiBpbg0KPiA+Pj4gdGhlDQo+ID4+PiBzZWN1cmUgd29ybGQuDQo+ID4+
Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogQW5hbiBTdW4gPGFuYW4uc3VuQG1lZGlhdGVrLmNvbT4N
Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+
Pj4gLS0tDQo+ID4+PiAgICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMTkgKysrKysrKysr
KysrKysrKystLQ0KPiA+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCj4gYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4+PiBpbmRleCA2NDAy
NzU4NzNhMjcuLjRhMmNmZmIyOGM2MSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPj4+
IEBAIC0xNDYsNiArMTQ2LDcgQEANCj4gPj4+ICAgICNkZWZpbmUgVEZfUE9SVF9UT19BRERSX01U
ODE3M0JJVCgxOCkNCj4gPj4+ICAgICNkZWZpbmUgSU5UX0lEX1BPUlRfV0lEVEhfNkJJVCgxOSkN
Cj4gPj4+ICAgICNkZWZpbmUgQ0ZHX0lGQV9NQVNURVJfSU5fQVRGQklUKDIwKQ0KPiA+Pj4gKyNk
ZWZpbmUgU0VDVVJFX0JBTktfRU5BQkxFQklUKDIxKQ0KPiA+Pj4gICAgDQo+ID4+PiAgICAjZGVm
aW5lIE1US19JT01NVV9IQVNfRkxBR19NQVNLKHBkYXRhLCBfeCwgbWFzaylcDQo+ID4+PiAgICAo
KCgocGRhdGEpLT5mbGFncykgJiAobWFzaykpID09IChfeCkpDQo+ID4+PiBAQCAtMTYyLDYgKzE2
Myw4IEBADQo+ID4+PiAgICAjZGVmaW5lIE1US19JT01NVV9HUk9VUF9NQVg4DQo+ID4+PiAgICAj
ZGVmaW5lIE1US19JT01NVV9CQU5LX01BWDUNCj4gPj4+ICAgIA0KPiA+Pj4gKyNkZWZpbmUgTVRL
X0lPTU1VX1NFQ19CQU5LSUQ0DQo+ID4+PiArDQo+ID4+DQo+ID4+IElzIHRoZXJlIGFueSBTb0Mg
KHByZXZpb3VzLCBjdXJyZW50IG9yIGZ1dHVyZSkgdGhhdCBtYXkgaGF2ZSBtb3JlDQo+ID4+IHRo
YW4gb25lDQo+ID4+IHNlY3VyZSBjb250ZXh0IGJhbms/DQo+ID4gDQo+ID4gVGhhbmtzIHZlcnkg
bXVjaCBmb3IgdGhlIGJlbG93IGRldGFpbCBzdWdnZXN0aW9uLiBCdXQgTm8sIGZvciBNTQ0KPiBJ
T01NVSwNCj4gPiBUaGUgYmFuazQgaXMgbWFuZGF0b3J5IHRoZSBzZWN1cmUgYmFuaywgYW5kIHRo
ZXJlIGlzIG9ubHkgdGhpcyBvbmUNCj4gPiBzZWN1cmUgYmFuaywgYW5kIHRoaXMgaXMgdGhlIGNh
c2UgZm9yIGFsbCB0aGUgY3VycmVudCBwcm9qZWN0cywgd2UNCj4gaGF2ZQ0KPiA+IG5vIHBsYW4g
dG8gbW9kaWZ5IHRoaXMgYXQgdGhlIG1vbWVudC4gVGhlcmVmb3JlIEkgdGhpbmsgYSBtYWNybyBp
cw0KPiBvaw0KPiA+IGZvciBpdC4NCj4gPiANCj4gDQo+IEJldHdlZW4gMiBzb2x1dGlvbnMgd2hp
Y2ggaGF2ZSB0aGUgZXF1aXZhbGVudCBjb21wbGV4aXR5IChsb2dpY2FsICYgDQo+IHJlYWRhYmls
aXR5KSwgSSBwcmVmZXIgdGhlIG1vc3QgZ2VuZXJpYyBvbmUgKGF0IGxlYXN0IGZvciBnZW5lcmlj
IA0KPiBkcml2ZXJzIGxpa2UgdGhpcykuIE5vYm9keSBpcyBhd2FyZSBhYm91dCBmdXR1cmUgU29D
LCBldmVuIGlmIHlvdQ0KPiBrbm93IA0KPiB3aGF0IHdpbGwgaGF2ZSB0aGUgbmV4dCBTb0MgZ2Vu
ZXJhdGlvbiwgSSdtIG5vdCBzdXJlIHlvdSBjYW4NCj4gY2VydGlmaWVkIA0KPiBpdCB3aWxsIGJl
IHRoZSBzYW1lIGluIHRoZSBuZXh0IDIsIDMsIDQsLi4uIGdlbmVyYXRpb25zLg0KDQpJIGRvbid0
IHRoaW5rIHRoZSAyIHNvbHV0aW9ucyBpcyBub3QgZXF1aXZhbGVudC4gSWYgd2UgYWRkIGEgbmV3
DQoiYmFua3Nfc2VjdXJlIiwgZm9yIHJlYWRhYmlsaXR5LCB3ZSBuZWVkIGFkZCBpdCBmb3IgZWFj
aCBjdXJyZW50IFNvQy4NClRoaXMgbG9va3MgbW9yZSBjb21wbGV4LiBJbiBjdXJyZW50IHZlcnNp
b24gSSB1c2UgYSBmaXhlZCB2YWx1ZSwgd2hpY2gNCmlzIHNpbXBsZXIsIGJ1dCBvZiBjb3Vyc2Ug
bGFja3MgZmxleGliaWxpdHksIHdoaWNoIGlzIHdoYXQgeW91IGFyZQ0Kd29ycmllZCBhYm91dC4N
Cg0KQnV0IHdlIHJlYWxseSBoYXZlIG5vIHBsYW5zIHRvIGNoYW5nZSB0aGlzLiBPZiBjb3Vyc2Ug
SSBjYW4ndCBiZSBzdXJlDQp3aGF0IHdpbGwgaGFwcGVuIGluIGEgZmV3IHllYXJzLiBJIHRoaW5r
IGl0J3Mgbm90IGNvbXBsaWNhdGVkIHRvDQptb2RpZnksIGxldCdzIG1vZGlmeSBpZiB3aGVuIG5l
Y2Vzc2FyeT8NCg0KVGhhbmtzLg0KDQo+IA0KPiBJJ20gY29udmluY2VkIGl0IHdpbGwgYmUgZWFz
aWVyIGluIHRoZSBmdXR1cmUgdG8gbWFpbnRhaW4gdGhlIElPTU1VDQo+IGNvZGUgDQo+IGlmIGl0
J3MgZmxleGlibGUuDQo+IA0KPiA+IFRoYW5rcy4NCj4gPiANCj4gPj4NCj4gPj4gSSdtIHRoaW5r
aW5nIGFib3V0IGltcGxlbWVudGluZyB0aGlzIGRpZmZlcmVudGx5Li4uDQo+ID4+DQo+ID4+IHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODhfZGF0YV92ZG8gPSB7
DQo+ID4+IC4uLi4NCj4gPj4gLmZsYWdzID0gLi5mbGFncy4uIHwgQVRGX1NFQ1VSRV9CQU5LU19F
TkFCTEUNCj4gPj4gLmJhbmtzX251bSA9IDUsDQo+ID4+IC5iYW5rc19lbmFibGUgPSB7dHJ1ZSwg
ZmFsc2UsIGZhbHNlLCBmYWxzZSwgdHJ1ZX0sDQo+ID4+IC5iYW5rc19zZWN1cmUgPSB7ZmFsc2Us
IGZhbHNlLCBmYWxzZSwgZmFsc2UsIHRydWV9LA0KPiA+PiAuLi4uDQo+ID4+IH0NCj4gPj4NCj4g
Pj4gLi4udGhpcyB3b3VsZCBtZWFucyB0aGF0IHlvdSB3b24ndCBuZWVkIHRvIHNwZWNpZnkgYSBz
dGF0aWMNCj4gPj4gU0VDX0JBTktJRCwgYXMNCj4gPj4geW91J2QgZ2V0IHRoYXQgZnJvbSBiYW5r
c19zZWN1cmUuLi4gc28gdGhhdC4uLi4NCj4gPj4NCj4gPj4+ICAgIGVudW0gbXRrX2lvbW11X3Bs
YXQgew0KPiA+Pj4gICAgTTRVX01UMjcxMiwNCj4gPj4+ICAgIE00VV9NVDY3NzksDQo+ID4+PiBA
QCAtMjQwLDkgKzI0MywxMyBAQCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSB7DQo+ID4+PiAg
ICB9Ow0KPiA+Pj4gICAgDQo+ID4+PiAgICBzdHJ1Y3QgbXRrX2lvbW11X2JhbmtfZGF0YSB7DQo+
ID4+PiAtdm9pZCBfX2lvbWVtKmJhc2U7DQo+ID4+PiArdW5pb24gew0KPiA+Pj4gK3ZvaWQgX19p
b21lbSpiYXNlOw0KPiA+Pj4gK3BoeXNfYWRkcl90c2VjX2JhbmtfYmFzZTsNCj4gPj4+ICt9Ow0K
PiA+Pj4gICAgaW50aXJxOw0KPiA+Pj4gICAgdThpZDsNCj4gPj4+ICtib29saXNfc2VjdXJlOw0K
PiA+Pj4gICAgc3RydWN0IGRldmljZSpwYXJlbnRfZGV2Ow0KPiA+Pj4gICAgc3RydWN0IG10a19p
b21tdV9kYXRhKnBhcmVudF9kYXRhOw0KPiA+Pj4gICAgc3BpbmxvY2tfdHRsYl9sb2NrOyAvKiBs
b2NrIGZvciB0bGIgcmFuZ2UNCj4gPj4+IGZsdXNoICovDQo+ID4+PiBAQCAtMTMwOSw3ICsxMzE2
LDE1IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdA0KPiA+Pj4gcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiA+Pj4gICAgY29udGludWU7DQo+ID4+PiAgICBiYW5rID0gJmRhdGEt
PmJhbmtbaV07DQo+ID4+PiAgICBiYW5rLT5pZCA9IGk7DQo+ID4+PiAtYmFuay0+YmFzZSA9IGJh
c2UgKyBpICogTVRLX0lPTU1VX0JBTktfU1o7DQo+ID4+DQo+ID4+IC4uLi50aGlzIHdvdWxkIGJl
Y29tZToNCj4gPj4NCj4gPj4gYmFuay0+aXNfc2VjdXJlID0gTVRLX0lPTU1VX0hBU19GTEFHKGRh
dGEtPnBsYXRfZGF0YSwNCj4gPj4gQVRGX1NFQ1VSRV9CQU5LU19FTkFCTEUpICYmDQo+ID4+ICAg
ZGF0YS0+cGxhdF9kYXRhLT5iYW5rc19zZWN1cmVbaV07DQo+ID4+DQo+ID4+IGlmIChiYW5rLT5p
c19zZWN1cmUpDQo+ID4+IGJhbmstPnNlY19iYW5rX2Jhc2UgPSByZXMtPnN0YXJ0ICsgaSAqIE1U
S19JT01NVV9CQU5LX1NaOw0KPiA+PiBlbHNlDQo+ID4+IGJhbmstPmJhc2UgPSBiYXNlICsgaSAq
IE1US19JT01NVV9CQU5LX1NaOw0KPiA+Pg0KPiA+Pj4gK2lmIChNVEtfSU9NTVVfSEFTX0ZMQUco
ZGF0YS0+cGxhdF9kYXRhLA0KPiA+Pj4gU0VDVVJFX0JBTktfRU5BQkxFKSAmJg0KPiA+Pj4gKyAg
ICBiYW5rLT5pZCA9PSBNVEtfSU9NTVVfU0VDX0JBTktJRCkgew0KPiA+Pj4gKy8qIFJlY29yZCB0
aGUgc2VjdXJlIGJhbmsgYmFzZSB0byBpbmRpY2F0ZQ0KPiA+Pj4gd2hpY2ggaW9tbXUgVEYgaW4g
c2VjIHdvcmxkICovDQo+ID4+PiArYmFuay0+c2VjX2JhbmtfYmFzZSA9IHJlcy0+c3RhcnQgKyBp
ICoNCj4gPj4+IE1US19JT01NVV9CQU5LX1NaOw0KPiA+Pj4gK2JhbmstPmlzX3NlY3VyZSA9IHRy
dWU7DQo+ID4+PiArfSBlbHNlIHsNCj4gPj4+ICtiYW5rLT5iYXNlID0gYmFzZSArIGkgKiBNVEtf
SU9NTVVfQkFOS19TWjsNCj4gPj4+ICtiYW5rLT5pc19zZWN1cmUgPSBmYWxzZTsNCj4gPj4+ICt9
DQo+ID4+PiAgICBiYW5rLT5tNHVfZG9tID0gTlVMTDsNCj4gPj4+ICAgIA0KPiA+Pj4gICAgYmFu
ay0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCBpKTsNCj4gPj4NCj4gPj4gV2hhdCBkbyB5
b3UgdGhpbms/DQo+ID4+DQo+ID4+IENoZWVycywNCj4gPj4gQW5nZWxvDQo+IA0KPiAtLSANCj4g
UmVnYXJkcywNCj4gQWxleGFuZHJlDQo=
