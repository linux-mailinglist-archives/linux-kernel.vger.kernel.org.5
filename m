Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27197D8E17
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbjJ0FWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0FWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:22:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B5F1A7;
        Thu, 26 Oct 2023 22:22:33 -0700 (PDT)
X-UUID: d1199628748811ee8051498923ad61e6-20231027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SXDxGex+egKsLdfcYuQvhqf0UQFNxHdHE6gBP3Hbwgs=;
        b=lZSYsUjqxwIkSBKvXVWQvQBuZ70usnhPWKuHMgg+KDzYke41EvzRUIuKm6J1NeyiW01vXZwp7y1M6ayAfiMTyBaomHo/v5ObI0DyznOkwJgKmYKkTEV+arEvyJhmtiMg2AjQsO7mbedGpcEUtEAZUBNnlGlkZzemECuYHcdjvc4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ac8ba365-5b99-4245-afa7-2938e15d8313,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:98e3f471-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d1199628748811ee8051498923ad61e6-20231027
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <chris.feng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1277151033; Fri, 27 Oct 2023 13:22:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Oct 2023 13:22:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Oct 2023 13:22:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqHGniEmgdsu0pCvaJ7VNGiQ8tZtj+nCrXZVLC9S+d+4NYsujO1BiCI+0D9XFJVdbXYeOE2P1ZYBYuQ9G2rMDHPuSF0UDMiTTXj+d+ale7Z4vEx0Bv27oBoGTAf45YmleleldzetdLNm52LB6GxeGn2aIG/1sMJWnuQ7RyKPW5efDJ8M8MDpzR6Y+grSqOq8OJ2WVeitxNyYchuTt1frM4TmvBQbvOYQ+LK29NPA1zhsckVLG2FA45lKTajx1azc0jWnFg72UsIi9MquGkmwD8u5ryvpsF3Z92mDgzcNnzq9+WBQJwoyN/O+/YkLakDK1ceQxFlauK7RiN58ck4oOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXDxGex+egKsLdfcYuQvhqf0UQFNxHdHE6gBP3Hbwgs=;
 b=lwpDbCwO3E2ovp9h7mMEvZU9UZJ07qS7L3nGQ6aZgl16MrxQvqtSHTWTrGqtYu7zhEteZXpkgErbDMvg83KC1aRWlGR6ffhDbDNLFamjprgsstHPM79MZxPn+YdJdY599wCR8QGQyPjgovQjhclJfdWAViknVOJ1q1dQ5SVKwwPYcwwVHDSWJQ7WUrOPkDVM9fscefkwXW6jlFQ+bCvGuZDF94u+qSaKT//s8NvxwGkI+n492AsJJWhVzMQVE+2bMJpoT7ldvhk6QkIx/Lry0VzOA7U3eq9sCqL7awMg3OTc2/3svacJ5Skd5DVHGnA3kVq1Yv63iYIqQ03IlltWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXDxGex+egKsLdfcYuQvhqf0UQFNxHdHE6gBP3Hbwgs=;
 b=eIySXGjedSYApJU1nKLdmBu+Npk0nN2SeL8YQ9SdWUbne64x5RdQWidyoc9ajxJSFfb9jJ0YnBGSJC8SjERy5tzrw2+fx6e+N4SzOIKwDaSKn9Jwu57bFdlsYK92ksg5N0k1JJc9/52lj23L5othcfkrANigQLszNqIKOPbnP9g=
Received: from TY2PR03MB4206.apcprd03.prod.outlook.com (2603:1096:404:a7::10)
 by KL1PR0302MB5204.apcprd03.prod.outlook.com (2603:1096:820:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 05:22:23 +0000
Received: from TY2PR03MB4206.apcprd03.prod.outlook.com
 ([fe80::6f2a:4ba5:1d70:9822]) by TY2PR03MB4206.apcprd03.prod.outlook.com
 ([fe80::6f2a:4ba5:1d70:9822%5]) with mapi id 15.20.6933.023; Fri, 27 Oct 2023
 05:22:23 +0000
From:   =?utf-8?B?Q2hyaXMgRmVuZyAo5Yav5L+d5p6XKQ==?= 
        <Chris.Feng@mediatek.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        =?utf-8?B?SHVhIFlhbmcgKOadqOWNjik=?= <Hua.Yang@mediatek.com>,
        =?utf-8?B?TGlhbmcgTHUgKOWQleS6rik=?= <liang.lu@mediatek.com>,
        =?utf-8?B?VGluZyBXYW5nICjnjovmjLop?= <ting.wang@mediatek.com>,
        "len.brown@intel.com" <len.brown@intel.com>
Subject: Re: [PATCH] PM: hibernate: Fix the bug where wake events cannot wake
 system during hibernation
Thread-Topic: [PATCH] PM: hibernate: Fix the bug where wake events cannot wake
 system during hibernation
Thread-Index: AQHaBlqs2FcXGYka+UCcrtjn8n/dNLBa1UEAgAJJI4A=
Date:   Fri, 27 Oct 2023 05:22:23 +0000
Message-ID: <2b470a20496a0e181078b0e18774e9348c7ffae8.camel@mediatek.com>
References: <20231024091447.108072-1-chris.feng@mediatek.com>
         <CAJZ5v0iLCsiPncA1t7ogtpch9gjGjzjtDU6G5E+PHB8ZCHgY0A@mail.gmail.com>
In-Reply-To: <CAJZ5v0iLCsiPncA1t7ogtpch9gjGjzjtDU6G5E+PHB8ZCHgY0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR03MB4206:EE_|KL1PR0302MB5204:EE_
x-ms-office365-filtering-correlation-id: 72a4b33e-0c21-41a7-ceff-08dbd6acb359
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvDx2ZtecQCQpsxA+A6iwurzJPoe8Lg/leuOOsSJ8XprvAk05E/3rQgZe9qNIKGENwcXxip4WNU1Wbv4xS5Hr8rOXyCTVh42f7R9xsorja/mZpUwvC02YXKNwa1EA/7/C9CaSxeN1K6cgb8diO0UrJV7VeiNL1T4dhD+XBX1dj7sZcryXJ2hU28+AMYkccEJK8ipm7ZCkXLwqeDHHBfNXsMZNvtR9fgzQ65Ztubxl83WR8SQE1+TJN7oJg5rE7gwhgR2HlXdfPXUqRmBGZ8a0MU9ZvGuic2h2S3LuPGfgoRcKL9epZq1XYixp4whnId+JimeGVhnq92QQofeBVh2AyppdI6KfhdyUq9woYmtYP0dbWamDkOd8658mB41pLqE54RHd5uty7cUFpc/wjUDwRw/cnQJB2l2FuIY5UDkwLsEmiR4P5kLxKoOz2YHouIEmCsbh+J6+L9nzIJqa0LQ6j95pe/PgGAf0JwhJxFINiawjcQ7ChKhThrMCfkrdCk39G6nu0N9QBWAEj7ANBgnQljrzb7kpqLZBzJpLvP1nBrEMoPch1Kt0xvrwSfT4OV43oOL8TLwx0ugYCFr9RT6HoVHUk+Cvgki8S5tN7VilTuqpFidqSzjnNqom/d1vY7ZNay/2i1zUBwsyVx12+NOx+L2iIEHLu9RTn4TL4/n5XLA4ngPS7XD3AwyrrsHwjXNluR/29GhXkGXqBqkfKktNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR03MB4206.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230173577357003)(230273577357003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(4001150100001)(86362001)(83380400001)(38100700002)(2906002)(5660300002)(2616005)(122000001)(6512007)(41300700001)(91956017)(316002)(36756003)(66946007)(66446008)(85182001)(66476007)(64756008)(76116006)(66556008)(54906003)(53546011)(71200400001)(6916009)(38070700009)(6486002)(8676002)(26005)(478600001)(6506007)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHc0Vit4L1BOU1RwajROVFhwWjJPazJCaThvVXdRRHBkL1J3NVVJT0VZbXNV?=
 =?utf-8?B?a2l2LzFjVUUwNjZ2b1B1NjRYbHlPV3dHK25yTHltZXMrbEJJdys0OG1wbGt1?=
 =?utf-8?B?ZnV1VEFKc00yTVdvZkgyN1hTdUJqUEx3SnNlN2ppeFdtR2M2QWloQUxyVGY1?=
 =?utf-8?B?N0V3ZUhJYXJiRHlXV1RDSThVNG4wK1ViN01NRkFtWDFvS3pob2JvY2dFUWdv?=
 =?utf-8?B?K0xZb2U2dkZzb0U4NWFsTDNuK0xLTkE4VGo5RmFwazN6QnFFT3FpMW53eHZJ?=
 =?utf-8?B?TGZUMmtxVkRNdFdndEN2N1FyemdTdnFYWjJIRTZwbjZVZnlnK1NzbjJ4cFY4?=
 =?utf-8?B?Uk10RFg3Q3ZIbzZaY28zMEZ6VjBHTmVPSE1yK3Q1ejF1TWdFYVdicURNOW5L?=
 =?utf-8?B?U3dwcVBlbWpicEdBT1dRenRzVC9XdENqWUZtdUV5SERNNVJGbi9TQXZ6cnY1?=
 =?utf-8?B?QVN4dkx5Rlh1Q0x0RngyYU1ZM2dycUV6Z1ZheGlnQWI1ZnBrU1BFd0xxNG1n?=
 =?utf-8?B?Y0dPT2pHNSt4L0FMcjRlYXVOL3pLK0FHM1gva2g2WjUrcUJpS0h1M0k3bDd1?=
 =?utf-8?B?eTJGWVA0TE5NM0hKdHAyNkhwRGwwMW8wN2pKTm0wTHFaYzcxaTYvSEc2dFg5?=
 =?utf-8?B?ZTFBbUZNNnE3cE5LS2t0TVpISE9XdE5QaE8ycEQ1cCtNcVB5dExCRW85aDVT?=
 =?utf-8?B?Y3QzakhsVG4rdkFxcEh2aTZRbTlvTXYvL1drcHZQNDd1U2h5VTdhbWhoUTkv?=
 =?utf-8?B?T01IcWdqZnlmcmtOenVTVTNqYnhhYzdjMk1HUk5nLzV0aWxuSzJONjk5eGtX?=
 =?utf-8?B?Ty9YS2FvWDlFL3FNNGthWDBmQWZ5dXFWRFlJanJmNGJML1kvUUdnS2MvVFUz?=
 =?utf-8?B?S0NYcG93SzBrdHBNRndqZ1d4QWdSNkY2cElWUmM1OWFkKzBCcmNnemp6WGd2?=
 =?utf-8?B?bHJYRmxCT1JNbUo3YWIrYytxdXdlODhkT3dYOGpRZVl6NzZvTEJUWjduUFMv?=
 =?utf-8?B?aGliNkk2ZUJ3MWZxVkdlZVgyV2JJaVdqODlsVzRqN1h6S3RTWS84OWZ5NWxZ?=
 =?utf-8?B?R1BNeWNTNTlaajBuUUg0MjR6NE10UTJDUmxzVUpiV0RHeXV0MWU3NHNiY0tQ?=
 =?utf-8?B?d1ZNVHlvVmRPajhJTmhKMjlyeGVxRW54TVlsNWF0RkdxRHlEWXIxejZVamwx?=
 =?utf-8?B?MlBLb0tBNTM0anZFZXV6dVRiSU01eHEwelBBRVl4QkZJRDAvK3pwRzF2b3Vk?=
 =?utf-8?B?c0p0MkltUFBrY0QzOUZrWW91aW5WVURrYTIxYmlpbUJWWStpR3NmbDdxOGR3?=
 =?utf-8?B?c091eWxhVkNNVnQ1V3NzOEp3YUJ6WWtJUmFBVXh0cVRTQXEvY3RRWVlreitX?=
 =?utf-8?B?cFJnRVJPaGtTUEFScFNWSzNENFZDVUpvYVd6TGJIcWE3dVZWaUJRaXM0T1Jz?=
 =?utf-8?B?UFIyclhLNDNCYUszYmplREN5QWs5REZvOGM4Z0wyc2VvTlN3ODhXcFZqRjJP?=
 =?utf-8?B?N0Q2Ykx3NXdPczZ5dVB1UFBQOXBRaGRvbjA5SXd4ODBHbDFhY1pjQ2M1akxN?=
 =?utf-8?B?V0J0RDNkVnZsRnRQZXBTaHArZjNxWnI0Y1MxZjJ2Tk1ybU9ySmJSSUgwRVFj?=
 =?utf-8?B?TzI5cVNBcDcyWjJSeTNtM3FoaklzTzlDZzJneFZ0S0NuU3MxMGl5a0NRUFQy?=
 =?utf-8?B?Wmx5VmlkbXljR1RkaUxUZWo5bkt3eWducks4NGY3NU5VTjhWRnJ0M1VncmZT?=
 =?utf-8?B?KzdKeVJVWUlkd0ZRRm85VG4wQWZOQ0tiRHZ6ZXM3OXpaTCtTeTlla0E4bkNh?=
 =?utf-8?B?SHFXMjFiMUpvekJqV1NRMFdISDBXRGRGMU5xQUFBcU9JUVBEb3NqNHJjT0Zu?=
 =?utf-8?B?MUJ0RU1tTDZud2VWNzZEdDZISnBRbjN0M3o5dkdaTHZ1cm1ya0ZEM1dPd1Vu?=
 =?utf-8?B?S24vRW1LaE9jRkRrTzJ1Tlg0VEhJaXNza3MrY282cVJqcFhjekREUTkvYTJD?=
 =?utf-8?B?TktwRk5kN3F1MVRyS2RMVEtxSDg0cC9YRkp3ZktLajlWNW0za1BHMWZXQzZU?=
 =?utf-8?B?SHY3TjR2MDdTY1BBWVFET2hpM1JuVnJBMnlKemgxNnppaGhzRk41OHN3elJy?=
 =?utf-8?B?YUR1UnU3OEErU2k1d05GLzAvR3VKOFM0aDBqUFJFZU9zRVVpbExhUmZTT0Iv?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F70724E57150EB43800DCBF9ED7AC980@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR03MB4206.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a4b33e-0c21-41a7-ceff-08dbd6acb359
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 05:22:23.4462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvnPN7d/JHDEtdIchptTjqQdfmi3yC1z21m3uRXoC1K8kL89F6xDLx1az+1YZpziRUdQbz74w7YlFgU6COj7KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5204
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--26.819000-8.000000
X-TMASE-MatchedRID: HrJsCrYHOqPUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
        CsGHURLuwpcJm2NYlPAF6GY0Fb6yCh2BfeLATnEWu1I/E4R9B/5+Mk6ACsw4JpNc6E4k2FMOjr+
        cpPp0WrDBe2jPP90esTEptG9SICadHSz3+MGL4YFHL73iZZtH5tIv4RV84lHT/RM/+SKR6qdvt3
        LcV982TWq1wXJZXzDaixT7jnrUsEjEQS2ecfkpF7rbxxduc6FP7f6JAS2hKPgmu2XKsBcW8Ud0R
        zx07LDVJjovGzWxJ9RTe8VcvSMWMMK8bCqGv6ntSEQN/D/3cG6lAfiiC1VA/TMVY5itbDoDMwRy
        rAxy6J9i7RoXJhmTzrnJnWFrt5jOeJCRewnBMihjHWM8krL4PNFqG4/BpDVafUOf4Mp5xta7UoH
        J+9TgG8bdNGd9VfY8kZOl7WKIImrS77Co4bNJXVZ0V5tYhzdWxEHRux+uk8jpP8tMOyYmaA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--26.819000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 33C19E1425F56CD69AD63BEABC6FC5C771EEB9575B880E3F3FA7F59E4D092A7F2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTI1IGF0IDIwOjI4ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ICANCj4gT24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgMTE6MTXigK9B
TSA8Y2hyaXMuZmVuZ0BtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQ2hyaXMg
RmVuZyA8Y2hyaXMuZmVuZ0BtZWRpYXRlay5jb20+DQo+ID4NCj4gPiBXYWtlLXVwIGV2ZW50cyB0
aGF0IG9jY3VyIGluIHRoZSBoaWJlcm5hdGlvbiBwcm9jZXNzJ3MNCj4gPiBoaWJlcm5hdGlvbl9w
bGF0Zm9ybV9lbnRlcigpIGNhbm5vdCB3YWtlIHVwIHRoZSBzeXN0ZW0uIEFsdGhvdWdoDQo+IHRo
ZQ0KPiA+IGN1cnJlbnQgaGliZXJuYXRpb24gZnJhbWV3b3JrIHdpbGwgZXhlY3V0ZSBwYXJ0IG9m
IHRoZSByZWNvdmVyeQ0KPiBwcm9jZXNzDQo+ID4gYWZ0ZXIgYSB3YWtlLXVwIGV2ZW50IG9jY3Vy
cywgaXQgdWx0aW1hdGVseSBwZXJmb3JtcyBhIHNodXRkb3duDQo+IG9wZXJhdGlvbg0KPiA+IGJl
Y2F1c2UgdGhlIHN5c3RlbSBkb2VzIG5vdCBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIG9mDQo+ID4g
aGliZXJuYXRpb25fcGxhdGZvcm1fZW50ZXIoKS4gTW9yZW92ZXIsIHdoZW4gcmVzdG9yaW5nIHRo
ZSBkZXZpY2UNCj4gYmVmb3JlDQo+ID4gc3lzdGVtIHNodXRkb3duLCB0aGUgZGV2aWNlJ3MgSS9P
IGFuZCBETUEgY2FwYWJpbGl0aWVzIHdpbGwgYmUNCj4gdHVybmVkIG9uLA0KPiA+IHdoaWNoIGNh
biBsZWFkIHRvIGRhdGEgbG9zcy4NCj4gPg0KPiA+IFRvIHNvbHZlIHRoaXMgcHJvYmxlbSwgY2hl
Y2sgdGhlIHJldHVybiB2YWx1ZSBvZg0KPiA+IGhpYmVybmF0aW9uX3BsYXRmb3JtX2VudGVyKCku
IFdoZW4gaXQgcmV0dXJucyBhIG5vbi16ZXJvIHZhbHVlLA0KPiBleGVjdXRlDQo+ID4gdGhlIGhp
YmVybmF0aW9uIHJlY292ZXJ5IHByb2Nlc3MsIGRpc2NhcmQgdGhlIHByZXZpb3VzbHkgc2F2ZWQN
Cj4gaW1hZ2UsIGFuZA0KPiA+IHVsdGltYXRlbHkgcmV0dXJuIHRvIHRoZSB3b3JraW5nIHN0YXRl
Lg0KPiANCj4gV2hpbGUgSSBhZ3JlZSB3aXRoIHRoZSBwcm9ibGVtIHN0YXRlbWVudCwgSSBkb24n
dCBjb21wbGV0ZWx5IGFncmVlDQo+IHdpdGggdGhlIHBhdGNoLg0KPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaHJpcyBGZW5nIDxjaHJpcy5mZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
a2VybmVsL3Bvd2VyL2hpYmVybmF0ZS5jIHwgMTAgKysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2tlcm5lbC9wb3dlci9oaWJlcm5hdGUuYyBiL2tlcm5lbC9wb3dlci9oaWJlcm5hdGUuYw0K
PiA+IGluZGV4IDhkMzViOWY5YWFhMy4uMTZkODAyN2ExOTVkIDEwMDY0NA0KPiA+IC0tLSBhL2tl
cm5lbC9wb3dlci9oaWJlcm5hdGUuYw0KPiA+ICsrKyBiL2tlcm5lbC9wb3dlci9oaWJlcm5hdGUu
Yw0KPiA+IEBAIC02NDIsOSArNjQyLDkgQEAgaW50IGhpYmVybmF0aW9uX3BsYXRmb3JtX2VudGVy
KHZvaWQpDQo+ID4gICAqLw0KPiA+ICBzdGF0aWMgdm9pZCBwb3dlcl9kb3duKHZvaWQpDQo+ID4g
IHsNCj4gPiAtI2lmZGVmIENPTkZJR19TVVNQRU5EDQo+ID4gICAgICAgICBpbnQgZXJyb3I7DQo+
ID4NCj4gPiArI2lmZGVmIENPTkZJR19TVVNQRU5EDQo+ID4gICAgICAgICBpZiAoaGliZXJuYXRp
b25fbW9kZSA9PSBISUJFUk5BVElPTl9TVVNQRU5EKSB7DQo+ID4gICAgICAgICAgICAgICAgIGVy
cm9yID0NCj4gc3VzcGVuZF9kZXZpY2VzX2FuZF9lbnRlcihtZW1fc2xlZXBfY3VycmVudCk7DQo+
ID4gICAgICAgICAgICAgICAgIGlmIChlcnJvcikgew0KPiA+IEBAIC02NjcsNyArNjY3LDEzIEBA
IHN0YXRpYyB2b2lkIHBvd2VyX2Rvd24odm9pZCkNCj4gPiAgICAgICAgICAgICAgICAga2VybmVs
X3Jlc3RhcnQoTlVMTCk7DQo+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAg
Y2FzZSBISUJFUk5BVElPTl9QTEFURk9STToNCj4gPiAtICAgICAgICAgICAgICAgaGliZXJuYXRp
b25fcGxhdGZvcm1fZW50ZXIoKTsNCj4gPiArICAgICAgICAgICAgICAgZXJyb3IgPSBoaWJlcm5h
dGlvbl9wbGF0Zm9ybV9lbnRlcigpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoZXJyb3IpIHsN
Cj4gDQo+IFRoaXMgZXJyb3IgbmVlZCBub3QgYmUgLUVBR0FJTiB3aGljaCBtZWFucyBwZW5kaW5n
IHdha2V1cC4gIFRoZXJlIGFyZQ0KPiBvdGhlciBlcnJvcnMgdGhhdCBjYW4gYmUgcmV0dXJuZWQg
Zm9yIHdoaWNoIHRoZSBmYWxsYmFjayB0byBzaHV0ZG93bg0KPiBpcyBzdGlsbCBkZXNpcmFibGUu
DQo+IA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMuIEkgaGF2ZSBzb21lIHF1ZXN0aW9u
czoNCkluIGZ1bmN0aW9uIGhpYmVybmF0aW9uX3BsYXRmb3JtX2VudGVyKCksIGlmIGZ1bmN0aW9u
DQpkcG1fc3VzcGVuZF9zdGFydC9lbmQgcmV0dXJucyBlcnJvciwgaXQgZ29lcyB0byByZXN1bWUg
ZGV2aWNlcyBmbG93Lg0KQWZ0ZXIgdGhlIHN5c3RlbSByZXN0b3JlcyB0aGUgZGV2aWNlcywgdGhl
IHN5c3RlbSBzaHV0cyBkb3duLiAgSXMgdGhpcw0KZXhwZWN0ZWQgZGVzaWduIGJlaGl2b3VyPyAg
SWYgaXQgaXMsIHdvdWxkIHlvdSBoZWxwIHRvIGdpdmUgdGhlIGRlc2lnbg0KcmVhc29ucyBpbiBz
aG9ydCA/IEZyb20gbXkgcG9pbnQgb2Ygdmlldywgc2luY2UgdGhlIGRlaXZjZXMgYXJlDQpyZXN1
bWVkLCB3aHkgZG9zZSB0aGUgc3lzdGVtIGdvIHRvIHNodXQgZG93biBzdGF0ZSA/IEFuZCBhbHNv
LCBhZnRlcg0KdGhlIHN5c3RlbSBzaHV0cyBkb3duICwgYW5kIHdoZW4gdGhlIHN5c3RlbSBpcyB3
YWtlZCB1cCBieSBwb3dlciBrZXksDQp0aGUgZGV2aWNlcyB3aWxsIGJlIHJlc3VtZWQgYWdhaW4g
d2hlbiByZXN0b3JpbmcgdGhlIHNhdmVkIHN5c3RlbSdzDQppbWFnZS4NCg0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHN3c3VzcF91bm1hcmsoKTsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBldmVudHNfY2hlY2tfZW5hYmxlZCA9IGZhbHNlOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHByX2VycigiSGliZXJuYXRpb24gQWJvcnQuXG4iKTsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm47DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAg
ICAgICAgZmFsbHRocm91Z2g7DQo+ID4gICAgICAgICBjYXNlIEhJQkVSTkFUSU9OX1NIVVRET1dO
Og0KPiA+ICAgICAgICAgICAgICAgICBpZiAoa2VybmVsX2Nhbl9wb3dlcl9vZmYoKSkNCj4gPiAt
LQ0KPiA+IDIuMTcuMA0KPiA+DQo=
