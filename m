Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D20D80063C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377907AbjLAIwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377837AbjLAIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:52:48 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1025D1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:52:54 -0800 (PST)
X-UUID: 006c1518902711eea33bb35ae8d461a2-20231201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+wZkCvW8SjU5J7dzWWM8u8QtBfUdZVZcfB8VjN2b1hY=;
        b=BbF34qTUJZ6WeMrz/KYjXDoP7uihuaXUiWgfa78XSThl7Ua7xuWloz3zRvB+0VvBl4tRN/ALrviDBLxzA/JQ/9iWVl2B4jl0LFLcdW0SdRy1KHv9fVI9flJOjBEp1KIQxWBZIfWQOOumk+MCQOf5ilv4qLq4HDDfJekbPR6ED9E=;
X-CID-CACHE: Type:Local,Time:202312011627+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:9cf91812-be92-43d2-9786-122361e66766,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:6e124b73-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 006c1518902711eea33bb35ae8d461a2-20231201
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2025847765; Fri, 01 Dec 2023 16:52:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Dec 2023 16:52:46 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Dec 2023 16:52:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLtMkcD6dV3Q9QmqxXsWoneyFL/Ig47AOrbYtFgHRRd9XcxQhlHoxpGzO2MLYqq6TZjn4UDEuiQ9CdQLXbHoxRVISwiKE3ZfYWhn5BJtyD7iA3j1YXM8Cx52LGsZQQl1JysKgq4reO6Nle776zw29nIZMGMX8spIdrfXMWrVlSjLyDUUK5+OZ7Bd13isT7OSyHze83gvETWtu8pn67gyJvdCBb+zjVWklN/o96F6q5O79C91pONnVCmZ6XfovkTFMYwnua4mb2NxV4ycZSeySaBYoa7LIYpR7t/nmAOAnnGZ31w3NoGHkmS6DbYMR6ekHdeRfE5UQVdOAFcyOoTFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wZkCvW8SjU5J7dzWWM8u8QtBfUdZVZcfB8VjN2b1hY=;
 b=BOTIuhkiRe3Ebj53OpN6OIRasuz/Gihd6ZsKp6VQ6Ql2nGjSMntl09YeIr48vSokEw0tVlZpse6t7sC2G5ejNWvi56/ORILsDVRa1i/DMf/5QIaTS+aJ53CKdKTNUcwlHzOljMdaY0+h591/x/1FLBQMLZqpSGMDtOH8NZYBRsHgLzQ06ck4amXnuqfw9qErGmDYm/+e3yONqs0BXfF67150aaaR5s1btuFhnClIXwjv/5yDKA3ytz6vaSxCLeEoeHbb6CqV7eNHmmvmu6JjX+C5l5eykrsTPftxpbu81rhq1GEA4ecSz4LhgB35KV0iN4TTGgwL7QqyYZbee4JUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wZkCvW8SjU5J7dzWWM8u8QtBfUdZVZcfB8VjN2b1hY=;
 b=npSDumx+PM3BpIAOZ/mFjwhiLTKzxT+NO0vDrmTb8pEF1jaaQ3o3jKWm7NQQPDD5bsU1u4at/YA1i3ND+pXhddlWhYgFLaQY4x8ap4cx+l2D4D248L0PMa2u+s7dbH37CcbXtTtddPILml4YXjXKE/cCcDs00VNTdbcLpeQtGgY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB5352.apcprd03.prod.outlook.com (2603:1096:301:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 08:52:43 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%6]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 08:52:43 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>
Subject: Re: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Topic: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Index: AQHaHrPjdunoffcOCEGmErF8vNrJIrCUKhaA
Date:   Fri, 1 Dec 2023 08:52:43 +0000
Message-ID: <cfa0f0daeaaf1d8909ad505cf7e36314d8a5367a.camel@mediatek.com>
References: <20231124085346.26602-1-mac.shen@mediatek.com>
In-Reply-To: <20231124085346.26602-1-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB5352:EE_
x-ms-office365-filtering-correlation-id: 61aaffac-cd7a-4e52-345b-08dbf24ae22f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5WgYEptym7jEXZl3MsuNgbB6nrxz4uLI3t13LXkOxtciQB3EEKfJn9IT9NAKfnWKJASao/egTblDP1wBBBkFVQXBNHGNqlm1NGQy3dFg8jcJpQlMbOTBeWgrz86IFWArhDrALQlBpa+oM8lkdurRUsKg1kdNfGcBMrZu7JmHEsxKLUvgSWKhICos6366SEhDvb9qTXb92m2hWTLhIMkoQ/+qgxcqfw4PcIQTfEiRyD0iyr9b+cl0Ra36TnOe2hK2lRvcTbconBjtAtvwRpIdD9ETv9cRze7kdh1UtSdkKeGsFSJh2zos7ua+l2gQe6GDxOLcpEZDNmI9QCmJn3xasRwwj5WUEaNrdOn5//yGg3rUUbbc8PR6SLc9dufSDln4BkaYI542leilibAOY73rc3lzR2mdDykEZNdS3y9n3s8ltQMaCofvrqC05mZpFlAKnvktQj7MWCZTEFpyb8PI8QS2PbGzaXAXdRbbBsRj3eiR1J8AGfc9hWr4NOHVA2NTYd4cyQk+k7SAJ/cwrKXPU50FUpLSjVcdRsm1DUcFT97xn1VzpbaPfBIdopKNAVyGljgBxsMXhThK7YAU9xj4Qw9XuquRlsWAWetzRp52v726ibcGNig+cvUZGrakxRpeZgRaE8Eq1hJdxunoCNUvCWIyDT/4qHSxzjlb56MuBs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38070700009)(4001150100001)(83380400001)(5660300002)(85182001)(41300700001)(2906002)(7416002)(71200400001)(2616005)(6506007)(107886003)(38100700002)(26005)(36756003)(6512007)(122000001)(6486002)(66446008)(110136005)(66946007)(66476007)(86362001)(76116006)(316002)(478600001)(64756008)(66556008)(8936002)(4326008)(8676002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2k2eVRlaXdINkdrdjY5VEhPVlQzeVRmOG56cXAxdnM4UjN5RTdmdVh0c3RZ?=
 =?utf-8?B?WXlldGJpQXZwSE9sNWNpMXBmUGZJZ1BYVDBKSWZ0bUIvNXVmN3Q5MU5aY2hS?=
 =?utf-8?B?NXlLT2ZNeGdHQ0JaNE5BMFF3TnYvMVZJeCtEOEhzUkl6N0ZnVXVxZktEbDc4?=
 =?utf-8?B?anZiZVhKNllpOEUyQUtjWkxybDdqZ0I3M094b254RnVKRzd2aEszZ2h0WEw1?=
 =?utf-8?B?amVLb3ZNL3RVWkE1Slp3R2ZUanVuZTZicUJHT0ljbnloSEdUc0xKM3RsdjZh?=
 =?utf-8?B?U0ZXK2tYcEJPSWZnN2RDSzlWL09xTFlyR29ZNXN0N2I4NHdjS0o4TDlGSmxI?=
 =?utf-8?B?ZjZnaXBqWS9HWW9PSzdDd2NlbVk0YnkwOWdlTGxVcTRBUktLLzE1c3hlVVdN?=
 =?utf-8?B?QzRtNThOWkxLZFpSZkduckg2YVcyM0VIeWo1K0RMdjltQTk4SzN5d3IvNWx0?=
 =?utf-8?B?N2xUUUNUMGJkZUNZYVcxVklNNHpkUmQyUERnNFR2QngwQ0I3Wmk3RzNiNzN5?=
 =?utf-8?B?bHJaNzk3MlU3SUJnQUU5WnpQMEt4V1RaTU1QTDlTS0xFaFZUWjZJYWc5TEN3?=
 =?utf-8?B?ODVRRzI1cTR3YzdCZWlPc2NQdjRNK2xyenBnL1VxNmM0YTJSVndUMXBWVkw2?=
 =?utf-8?B?dnR5azNxRTlUTXVmN2NlTG9nbnZJb0dON1Zmb09qb1ZOVm53bkExdkNYU0dV?=
 =?utf-8?B?WWw4ZjRaT0ZXSG5oMDNhS2lIUlNURHlzcThmV21VSFB3blU5dzZUUS95aXRr?=
 =?utf-8?B?by8rSmx5QTRCYlVZYnZ6VkN1ZzNGRWVlYTZBWkx3bTd2blBlMlNXKzZQN2RE?=
 =?utf-8?B?SUhKSGhXaDFhVCtUb0lpekw1SzBUTXhwT2NTOFZVRjdTT0JMcUcyZStHakwz?=
 =?utf-8?B?ZGVwemp5T2w0cFR4K3I2U2dtcnU5T1ArQkUzVmZYeUlkVDFSbHBFeEwwYWdK?=
 =?utf-8?B?QjNMdkJ5dWk0cXZOQ2xSWUx4TnY0dUl4S2M5MVlqV0NyclhUREM2RmZQUmFa?=
 =?utf-8?B?eURHWjJkWkUxRmpsVFZCQWFhU0swU0ZBYTVxUjQyajQ1aGlWOTdYalFlMm45?=
 =?utf-8?B?eEEwcWJLeUdOaXpkakpMQ01RcUR0Q3BRRGJlbFBuMFErWjdWYnBZaU5pbG96?=
 =?utf-8?B?M1NYZHUyTzhISnVVNytCV3dXMklkb0p1ZDVEZmM2djNZK0thblNOODhYRXQ5?=
 =?utf-8?B?aFVXbW0xaGVJY2RtdHdER2JaSTVrQ0s3YnJ0dnNKNjZiWUZaYnBzSGVQNDIr?=
 =?utf-8?B?THhpWHZVeWRjSTV3VnRCRXoyNHR5eFZDbVhtMWlaN3RnZEozdDRHOXdoOUFH?=
 =?utf-8?B?NEZTTmJvRDVkL1BMb2hhZTQ1ek5qVXNLYTU3Tm0vRm1XTFZiVnBqZlFJWTBm?=
 =?utf-8?B?T0t5MDE2ZFNjR2doZ3d0ZkdYVVJMSm1GZWlEOU42TEtxYWw1VjRwTjJzV3FX?=
 =?utf-8?B?ekQ3Ykt3RG9yNHVlZkdEcG54VzdxaDM2MlZSTk1EcURsMmJ3NHZnNFozTTli?=
 =?utf-8?B?cmw5dmVDdlQ3d0FHS3k4em1wQVVKQVJiWkpVKzBib2xhYVdsNWZSYWllVXZU?=
 =?utf-8?B?THFYTVp3S0NqUThKMGJIdVVVOGZhSS92NVVVUGwyekdZQno0OTZNQVFyMDhS?=
 =?utf-8?B?ZnltY3cxQVVBQ0NoTTg2dkZlT3VCZnA1Mmw5Mm9WZTBidmtTRzFKVStvbnNi?=
 =?utf-8?B?ejFYQXRpaDhWekZjTElTUDhqYWluVGZjVExxOG9zdGZIb01yenJFQi9Uck9F?=
 =?utf-8?B?WTF4UjY5Y2UrdzFhcUZNTXlvT2dHb1hIbHN0akx4UzZCTmNnTzh0Yml4eWRD?=
 =?utf-8?B?WUZpNUlKeEIrbDhERnhIV1FScmJMQ1Q4S1Z6bE4wWnE5Uy9Leit6TmhFM2Mw?=
 =?utf-8?B?N05qbkxZbkZYTi9Zalp3ZEdsdVBwZ1BJYmdDMThCaDgyK3l6OEUvdDJ4MWRS?=
 =?utf-8?B?UVZEN2VPNktLbE5oYUlCdWhTRVg4MXphN0RTZzZkM0VMTTBvTnB0Z2xuR0JL?=
 =?utf-8?B?Uk9Oa1RjOXR1dGowaHRzS1hsSm1JQnVWV1NCNmVuL2VaaXNPbk56VDBHVTNC?=
 =?utf-8?B?bXZ5T25lT1B2Z1F0YXBxbytYcFZ1TGJhT0Qwd2ZkZHZIT3MvVjZLQW1FajE1?=
 =?utf-8?Q?/CgTczoCQArNFoCyN2YaWVtmF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FC0CBE8020C4D4EBDD1848727305349@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61aaffac-cd7a-4e52-345b-08dbf24ae22f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 08:52:43.8861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPnFgjIRaD6vAWxd0HsDwSrpdxzYDm/Tz71gs8ergp7aqVbpKrsn+syHOPphqkFodhBwx5C9cUpnRAqPa9RRjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5352
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.417400-8.000000
X-TMASE-MatchedRID: nVQUmLJJeybPaPH51LTU5Ca1MaKuob8PC/ExpXrHizxcKZwALwMGs8uj
        Rkt05a7cM2MQQW7DL3i1q48Rh4wr9dB/8y3gYF9vogGd8wIUGIIHQj6IJQ7jnU4K0IMk2m3GyU7
        XgTs6W4LW423XW2hpe8BAWEWldCkNqZddSUIrsJJNa4UOfkJSNH0tCKdnhB58pTwPRvSoXL2y5/
        tFZu9S3Ku6xVHLhqfxIAcCikR3vq8A9JfeBNzyhici3CWbCRnjGhH8ZrSdEmgpU4FNkcqP9NBcw
        dt2lLWc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.417400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 3DE737D08ECC18C878B13A1327D9E583F0186D1A119A86301205BD931A6C3FB72000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hYzoNCg0KT24gRnJpLCAyMDIzLTExLTI0IGF0IDE2OjUzICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQWRkIHRlZSBjbGllbnQgYXBwbGljYXRpb24sIEhEQ1AgMS54IGFuZCAyLnggYXV0
aGVudGljYXRpb24gZm9yDQo+IERpc3BsYXlQb3J0DQo+IHRvIHN1cHBvcnQgdGhlIEhEQ1AgZmVh
dHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IG1hYy5zaGVuIDxtYWMuc2hlbkBtZWRpYXRlay5j
b20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArc3RhdGljIGludCBkcF90ZWVfb3Bfc2VuZChzdHJ1
Y3QgZHBfdGVlX3ByaXZhdGUgKmRwX3RlZV9wcml2LCB1OA0KPiAqYnVmLCBzaXplX3QgbGVuLCB1
MzIgY21kX2lkKQ0KPiArew0KPiArCWludCByYzsNCj4gKwl1OCAqdGVtcF9idWY7DQo+ICsJc3Ry
dWN0IHRlZV9pb2N0bF9pbnZva2VfYXJnIHRyYW5zY2VpdmVfYXJnczsNCj4gKwlzdHJ1Y3QgdGVl
X3BhcmFtIGNvbW1hbmRfcGFyYW1zWzRdOw0KPiArCXN0cnVjdCB0ZWVfc2htICpzaG0gPSBkcF90
ZWVfcHJpdi0+c2htOw0KPiArDQo+ICsJaWYgKGxlbiA+IE1BWF9DT01NQU5EX1NJWkUpIHsNCj4g
KwkJVExDRVJSKCIlczogbGVuPSV6ZCBleGNlZWRzIE1BWF9DT01NQU5EX1NJWkUgc3VwcG9ydGVk
DQo+IGJ5IGRwIFRBXG4iLCBfX2Z1bmNfXywgbGVuKTsNCj4gKwkJcmV0dXJuIC1FSU87DQo+ICsJ
fQ0KPiArDQo+ICsJbWVtc2V0KCZ0cmFuc2NlaXZlX2FyZ3MsIDAsIHNpemVvZih0cmFuc2NlaXZl
X2FyZ3MpKTsNCj4gKwltZW1zZXQoY29tbWFuZF9wYXJhbXMsIDAsIHNpemVvZihjb21tYW5kX3Bh
cmFtcykpOw0KPiArCWRwX3RlZV9wcml2LT5yZXNwX2xlbiA9IDA7DQo+ICsNCj4gKwkvKiBJbnZv
a2UgRlRQTV9PUFRFRV9UQV9TVUJNSVRfQ09NTUFORCBmdW5jdGlvbiBvZiBkcCBUQSAqLw0KPiAr
CXRyYW5zY2VpdmVfYXJncyA9IChzdHJ1Y3QgdGVlX2lvY3RsX2ludm9rZV9hcmcpIHsNCj4gKwkJ
LmZ1bmMgPSBjbWRfaWQsDQo+ICsJCS5zZXNzaW9uID0gZHBfdGVlX3ByaXYtPnNlc3Npb24sDQo+
ICsJCS5udW1fcGFyYW1zID0gNCwNCj4gKwl9Ow0KPiArDQo+ICsJLyogRmlsbCBGVFBNX09QVEVF
X1RBX1NVQk1JVF9DT01NQU5EIHBhcmFtZXRlcnMgKi8NCj4gKwljb21tYW5kX3BhcmFtc1swXSA9
IChzdHJ1Y3QgdGVlX3BhcmFtKSB7DQo+ICsJCS5hdHRyID0gVEVFX0lPQ1RMX1BBUkFNX0FUVFJf
VFlQRV9NRU1SRUZfSU5QVVQsDQo+ICsJCS51Lm1lbXJlZiA9IHsNCj4gKwkJCS5zaG0gPSBzaG0s
DQo+ICsJCQkuc2l6ZSA9IGxlbiwNCj4gKwkJCS5zaG1fb2ZmcyA9IDAsDQo+ICsJCX0sDQo+ICsJ
fTsNCj4gKw0KPiArCXRlbXBfYnVmID0gdGVlX3NobV9nZXRfdmEoc2htLCAwKTsNCj4gKwlpZiAo
SVNfRVJSKHRlbXBfYnVmKSkgew0KPiArCQlUTENFUlIoIiVzOiB0ZWVfc2htX2dldF92YSBmYWls
ZWQgZm9yIHRyYW5zbWl0XG4iLA0KPiBfX2Z1bmNfXyk7DQo+ICsJCXJldHVybiBQVFJfRVJSKHRl
bXBfYnVmKTsNCj4gKwl9DQo+ICsNCj4gKwltZW1jcHkodGVtcF9idWYsIGJ1ZiwgbGVuKTsNCg0K
dGVtcF9idWYgaXMgZXF1YWwgdG8gYnVmLCBzbyBkcm9wIHRlbXBfYnVmLg0KDQpSZWdhcmRzLA0K
Q0sNCg0KPiArDQo+ICsJY29tbWFuZF9wYXJhbXNbMV0gPSAoc3RydWN0IHRlZV9wYXJhbSkgew0K
PiArCQkuYXR0ciA9IFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfTUVNUkVGX0lOT1VULA0KPiAr
CQkudS5tZW1yZWYgPSB7DQo+ICsJCQkuc2htID0gc2htLA0KPiArCQkJLnNpemUgPSBNQVhfUkVT
UE9OU0VfU0laRSwNCj4gKwkJCS5zaG1fb2ZmcyA9IE1BWF9DT01NQU5EX1NJWkUsDQo+ICsJCX0s
DQo+ICsJfTsNCj4gKw0KPiArCXJjID0gdGVlX2NsaWVudF9pbnZva2VfZnVuYyhkcF90ZWVfcHJp
di0+Y3R4LCAmdHJhbnNjZWl2ZV9hcmdzLA0KPiArCQkJCSAgICBjb21tYW5kX3BhcmFtcyk7DQo+
ICsJaWYgKHJjIDwgMCB8fCB0cmFuc2NlaXZlX2FyZ3MucmV0ICE9IDApIHsNCj4gKwkJVExDRVJS
KCIlczogaW52b2tlIGVycm9yOiAweCV4XG4iLCBfX2Z1bmNfXywNCj4gdHJhbnNjZWl2ZV9hcmdz
LnJldCk7DQo+ICsJCXJldHVybiAocmMgPCAwKSA/IHJjIDogdHJhbnNjZWl2ZV9hcmdzLnJldDsN
Cj4gKwl9DQo+ICsNCj4gKwl0ZW1wX2J1ZiA9IHRlZV9zaG1fZ2V0X3ZhKHNobSwNCj4gY29tbWFu
ZF9wYXJhbXNbMV0udS5tZW1yZWYuc2htX29mZnMpOw0KPiArCWlmIChJU19FUlIodGVtcF9idWYp
KSB7DQo+ICsJCVRMQ0VSUigiJXM6IHRlZV9zaG1fZ2V0X3ZhIGZhaWxlZCBmb3IgcmVjZWl2ZVxu
IiwNCj4gX19mdW5jX18pOw0KPiArCQlyZXR1cm4gUFRSX0VSUih0ZW1wX2J1Zik7DQo+ICsJfQ0K
PiArDQo+ICsJLyogU2FuaXR5IGNoZWNrcyBsb29rIGdvb2QsIGNhY2hlIHRoZSByZXNwb25zZSAq
Lw0KPiArCW1lbWNweShkcF90ZWVfcHJpdi0+cmVzcF9idWYsIHRlbXBfYnVmLCBNQVhfUkVTUE9O
U0VfU0laRSAvIDIpOw0KPiArCWRwX3RlZV9wcml2LT5yZXNwX2xlbiA9IE1BWF9SRVNQT05TRV9T
SVpFIC8gMjsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo=
