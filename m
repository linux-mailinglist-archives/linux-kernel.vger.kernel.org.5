Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9237F7DB6CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjJ3Jz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjJ3JzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:55:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B4100;
        Mon, 30 Oct 2023 02:54:47 -0700 (PDT)
X-UUID: 59c42686770a11eea33bb35ae8d461a2-20231030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=F/QnsRCyS48+aS5wHTiElG6FRu61A71BtC6kejl8tZc=;
        b=S5eGsT7Lp/n6EjApwCWleXNUVOp0eqfUVKeTXO8dwa0BQuSoXKamwFP3kTBDICnsfRRdP7KFG+dJKBPBKewei6boYdffNdKugIuQQlRCQXLXtwGDXmXQfXudUGqdFLR4AWbD1oHkXmNzuwct3ZSTrUfalAVCZOBlmqnYZAOKHIs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:82380f32-e630-4b8d-b066-92d3c8305b33,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:1dfdeefb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 59c42686770a11eea33bb35ae8d461a2-20231030
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <lena.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1402082849; Mon, 30 Oct 2023 17:54:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Oct 2023 17:54:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 30 Oct 2023 17:54:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6BnNdplrzVM/zPfAvFOTvmxuwoAeWN9b23C2i6c60n53277VvIaC8rfwvD/EE8r4jgoE6JD2Ev2gC3n/OIih2+CaQ9Oj1tfWkzsi0+Om35pSGykjbxnfmPKomYDwvqBggLTNwQQ3yI1+txiG0bHT5TPjwk3mis38fck9dZYh+3CqAQeynM5MZi7dyoJUAAH1/3EE2sxF6n+ysGT3Ak4y4gVHpc5PJmEhfO9uKbiJBm0/3HfPjvtJTgNGF6ZE5/4ITDJPYAcpjwLY13E5j0gzOuXXAxHuqVHnu7ST8g7Bv6c3+uW5YMlTa8meJfa2EsUe5/E9AroWmI47K5TLMLOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/QnsRCyS48+aS5wHTiElG6FRu61A71BtC6kejl8tZc=;
 b=RWpB1PBBRMS6COzFW+B72IX/4rotlfhQJqmMr7/yeeRfRhd4aSgIHSjqsDq/CT0byiM7tAM6xJNo06Cu6k4o5p8P9hm6GcbTnZYtflwkN6kYCZ5DNflRJHNSqUP8SidHoSpxm4elpI1gP+k+2dfxwOhq0YA4XjTLXo5tPKbpMwmOso0aSMlRbMWD8w/oIIS63NL+jpe2p/N7geuLTRJo+HoLiYO0auhpR28lbCqTXqfgteBFFH7AoWgL1SPdfs+tTsDTAbLXtI5uxDD1aAJtFwdDkr0DskiNq0gFjw2jiUg2YP0AU/qNP1Aan1ON84q+szYVuHMe3rdO920Ha9GrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/QnsRCyS48+aS5wHTiElG6FRu61A71BtC6kejl8tZc=;
 b=tIxs1XlcBYXo6Xv1wrcoIumS7A8MVpWHLNAggI++qn3k+VrzzZb1efn2wDWhI4J6l458E1fdI/4w5trFs3H4yfJGtKY82M/hooVp5qUz9uwr83Fv5VzBR8vzC1NMlT4fI+uawbPe7aZQyo86efc8DZcXyqyZNKWEod/MUJ5UGc4=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TYZPR03MB8249.apcprd03.prod.outlook.com (2603:1096:405:1e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 09:54:39 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::d556:7c13:6e10:9a97]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::d556:7c13:6e10:9a97%4]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 09:54:39 +0000
From:   =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To:     "edumazet@google.com" <edumazet@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "maze@google.com" <maze@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "cmllamas@google.com" <cmllamas@google.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net-next] net:prevent shared skb corruption on rx-gro-list
 segmentation
Thread-Topic: [PATCH net-next] net:prevent shared skb corruption on
 rx-gro-list segmentation
Thread-Index: AQHaCMi3juco6AiSCEKGZptWFr/UorBdk8sAgASEbAA=
Date:   Mon, 30 Oct 2023 09:54:39 +0000
Message-ID: <a42fffbc5d547a1a7d0270ba89c86caaa68e8c2d.camel@mediatek.com>
References: <a6f256694783a0692f2f079e7ac76ace621308c3.camel@mediatek.com>
         <CANn89iK4M-=v0k_Aw_noWb_duDUZ54_3WKZV57BFRSQ1fhxcZA@mail.gmail.com>
In-Reply-To: <CANn89iK4M-=v0k_Aw_noWb_duDUZ54_3WKZV57BFRSQ1fhxcZA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TYZPR03MB8249:EE_
x-ms-office365-filtering-correlation-id: 3f83eec1-bb15-40f9-544d-08dbd92e3bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBmIeVc+BdG0YQo1FxlVccR/WJzaCjFkYliNdMljAFGCUMym02I02qt/YoXskUa+CM7+Ym9EG7EFfZvJTPR0k1axGWnDythVxK9I4Ne+PO1UZmzO82lDUuQkRZFR3hVXRIOO2vqxLILUzyDo/K71mzV6DgU3/dqrfO1aeVxkPwjf873v2IObODiFQuUXqmVe+NMH87sRBJsVHlCXX9WwUikFN7TyAGKFktjNdlx7N3IENTBMAF0ldnAthZlKDczXVK95D9XgybxOgOlmfUaH7lJjKFKCsnjZhXEWlctw7UsbFipnNchV9H1bhPxu+Qr45lVXIdC5W3xta4tfM9+eZJVMnd//46agQapShhVzGQXi3N/ZjeDiOAftKm3ZxfirY+4sl5l5euE1wEaVD8CHTvm1BA0lM1IvCxj6PtscvJPo0dI63le0OwHuu2N2pdy3dtS4++6I3abRHhg1hABDoVoqkL1YPBn9oJ3lnYS538HQseDS3QiBVWa8UF6JpVtqy5LOPIxtiaNzQhrYBgZ5eUTcapp5dLctOkP1CzxV3g1h6Ywsmifvw8h8icJt7pMkW0X54kUtECKW6RCQK/HNdtogQYPTtLywnvNILcTA0vKmbfJ+MvzuG2rHpwV6d/REhZs1PBzrWZO/9/ce/3x10A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(8676002)(8936002)(5660300002)(66946007)(66446008)(66556008)(66476007)(64756008)(54906003)(76116006)(7416002)(91956017)(4001150100001)(71200400001)(478600001)(2906002)(966005)(6486002)(316002)(41300700001)(6916009)(6512007)(6506007)(2616005)(26005)(38070700009)(122000001)(36756003)(86362001)(85182001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkVmQ0M1aFBxRitiQzNPaW9JQUZ4VVo4THJ0cGI4N1A5SmF0OVFpellSQXcy?=
 =?utf-8?B?RC9acTVoM2dzcS94dVhlOXRVUVIrRllrMEhIOWFRSTJYWnJNQi83WVZEdFd5?=
 =?utf-8?B?VXptWG9vUE9OYWZGdkJFbGl1WG9WY292ZWVFcnowZ1dSY0ZFbnJ3VGpURzV4?=
 =?utf-8?B?eWNobUdMelZkK3RGa2h6MlZlTjh4OFp1M0dDd0VXV2RIMmpQcDhVQTNnbXQy?=
 =?utf-8?B?ekErK2xacFZEOWNqbWVTQ083enFuV0RnYUcrVGVabTl1NWM4K1RLdXp3TEIv?=
 =?utf-8?B?bEg1NDRRQ2JwSXNKZk1vNE95OGdhQ3VjamdMOTl4K1dVYno0Zncvc2tXZG4z?=
 =?utf-8?B?WFE3SGpTVzllY001R1d5dXhwdzlWNnpZc29lMk13MnN0OFFUMmlJSXE2dlBj?=
 =?utf-8?B?NGl6MHJIc0ZqVS9iMGFkTitmcXAyM2pvK1lZcGxVTnNheXZqSVBlb2xHRkdX?=
 =?utf-8?B?UjhRMXhZbW5ZRVZnaHgzVDQ5OEdSM21uOWplemZ2U043RThlOUZkUk1VdHhz?=
 =?utf-8?B?VUJxQVdSREtWMkdwK1JLVWJyMXk4VGhMczVvbTJURHVQZ2xoM0ZZbGQwRWlu?=
 =?utf-8?B?bE9pdlVzWlJRblF1OEZ3MWNnbkNvOVp0cnU1TkxlRjRrbGcxN1VFeUNrdUpQ?=
 =?utf-8?B?V255RmYramxJMkhGNHZpRHJ4VFlNNUNvcWJYRlJZd2EvY0FLTHdXQmhlaks5?=
 =?utf-8?B?MDZrQlpxTkV2enJTaFZPS2c0WTVtUG9xT1Znb1RaZHNZMkh4dzJabHRxK1da?=
 =?utf-8?B?TGlPUnREZXJmSGpNSDEyWUxWemhkUVpienhxY24yRUE5T1ByZGRFaEVWS0FY?=
 =?utf-8?B?amk0NlZ4Rmx0djk3WXdiSkV5UlVkeHd6dG9hS1pNSjlFc2Z3MGZFaXlnMCtG?=
 =?utf-8?B?bmJmcmw2Z290WjA4ZW5uaWVSNURydEptM2o3ekhWUENZdkZuTFZZYi9JaHNr?=
 =?utf-8?B?Y3pRSTZqektGRXRsdDkwUnE3NDE4MVhwN3RqOXUvTmNZWEt5aGJJNjAreDVm?=
 =?utf-8?B?cjFPMWVLMEswaGJCVFNkWGxCTkJRa3RSTUhiUFNuTmhsWDI1ZGt0MkovQWJI?=
 =?utf-8?B?U0FZbXBmYzI0NVNMWlcrOGNXbXpGUFhjRjZYQmdQa1NLblVObTNYYWNYWTE3?=
 =?utf-8?B?MjM3Z1FpYm0wcytFa0xGZEdjK1IxZEpVUVlGa3V5c0FOeU4vVGRWR1lCR1pL?=
 =?utf-8?B?bjA4MWlMNk5tTEhmc0dpeEJJYlRuVG0rN2tXMXh1MnVvcVM4MWVIeE9VMTZW?=
 =?utf-8?B?azBTMEJxZElVZDk3T1dLUkhKTngvbUtHOEkxYUVQSnF1dFR1ZWQwR1JkUkRk?=
 =?utf-8?B?TU9VRjdVb0dKZWNFMlp5QjN4Q3g4bHF0SkFPNDZudkljWmZMTWNJTWVnQ1g1?=
 =?utf-8?B?ZXVVYjhnbTdWZ1VRdUpzakxMVENHcmNoQ0ZLaktHdmxnZmlLb1BWRUhaSlRs?=
 =?utf-8?B?SmplaTNoRjdOQU0zdi9tZzlDamZaRWJPNHdjMTAyVEhORGR0VnJPYW0vVWV6?=
 =?utf-8?B?SGRwd25NZlhjWFBOSEtQc3ZHS0J1MmpBVXd0akpoc1lkdHhBVjlGUk5QS1E1?=
 =?utf-8?B?STVDM28zQklPWEYzUVZYb3AvOHkwWkYvanY1K0o0TjA1RENycDJoUkhjS1Bk?=
 =?utf-8?B?ZXlXQm9mVElSNkVZanVvQ3JVYVFZOWhNdzJsQTZzRzU3NVUyU0RrcU4yMmZv?=
 =?utf-8?B?S0JQa3dmZDVUQzJRUEZJOTdiN0lpMW82M2JOWWg2MUhGbVNQMEI5L3pKeFdE?=
 =?utf-8?B?Y28vdnpGMkk2ZnBCUTByWjRZL0VpRmJvYithZFVHL05lclhwSFRCMnNsS3JH?=
 =?utf-8?B?NlN1ajRkbEdBN0kzSEZtZlBGRWJwWWg0ZCs5Z0dkYm9FKzlEQW9PK0xQdmlq?=
 =?utf-8?B?WmVSUUp5UytBNHJzUGRaejEyYk0xWlhZT3RyUzhoSXFBczZGNmJaVzZhYm5I?=
 =?utf-8?B?NXJkWU9TVy81NFEvZlhpVFhOdXFQb2ZuOWpuOW1aQWdBemxEc0lJd1p6SkJE?=
 =?utf-8?B?Y2NiZElaMmtVK2RVaHFITkRZTEgxOURrNkdVclNJcVNtekViRDFFdmc1aE5i?=
 =?utf-8?B?NFhFeWdQb1VZUm56aGJTQUxDYWpHOU5VbEt1SUtWcmk0RTFVRUlCQnhodGFv?=
 =?utf-8?B?RzZVQ0hWQi8rR0NwUDk4UFBOZ2Fad1UrdE1FZmd3dFRIU00wWTV4ZjVEY2Fi?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <050375022E8719498CDDEB26E60F8F00@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f83eec1-bb15-40f9-544d-08dbd92e3bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 09:54:39.6840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CR49oYkdEmoRJl6Z+mbx/wJck3MntNpxLSDNNTupYENqMT8Voed9G2mzuAkcr/g5ezS0G+vkAT8aJSUDg00v/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8249
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.229200-8.000000
X-TMASE-MatchedRID: 0dFPYP4mu5T4ECMHJTM/uSa1MaKuob8PfjJOgArMOCbb6Y+fnTZUL4sT
        ++zNXrEMNSgylceqzD4+jgBHpxu6djxz5tDhhD0GutvHF25zoU+4vBuE2X0HlVeilmPI7oJlns7
        fbmSSSa3YK7fnL8T5IpQwQHf/8TQ5YFa6Zcuh7o3zh2yKdnl7WL7FSH7SYOcOC/+dM49Ci+xDiO
        sqMEIgkvQAGnwdE7nfQ0NMCpJuJ+qwU1cNMNaaEFt3XMydUaMXBdebOqawiLvpIQbXtRF5DQBKG
        kW9znn5aOb4EnDCAVGjtFDUjWTw8u2niodCoJB/nJ5tL+LbGOM4gG1vqBBN+AJJmsCdNLQG5sZT
        wYHfBM5xS/YD65karCaNPvkMKAC/K/cEK/RlbJCrVklnbP5Jth0PsyMp50OOyhQspzcTQVSUhdp
        Tc3HdB0yl9ggbAv9cubks+aKtT3VCBQieSpAGz54CIKY/Hg3AwWulRtvvYxTWRN8STJpl3PoLR4
        +zsDTtAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.229200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B7C2BB40AA2006733A55A457C8757D4D81FDFA862817D7F9D6E3FAB551B7D0502000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTI3IGF0IDE0OjM5ICswMjAwLCBFcmljIER1bWF6ZXQgd3JvdGU6DQo+
ID4gSW4gc29tZSBzY2VuYXJpb3MgdGhlIEdSTy1lZCBza2Igc2hhcmVkIHdpdGggbXVsdGkgdXNl
cnMuIFRoaXMNCj4gPiBzZWdtZW50YXRpb24gdG91Y2hlcyB0aGUgc2hhcmVkIGhlYWRzIHdoaWNo
IHNldHMgZnJhZ19saXN0IHRvIG51bGwuDQo+ID4gQWZ0ZXIgbGluZWFyaXphdGlvbiB0aGUgc2ti
LT5uZXh0IGlzIG51bGwgd2hpY2ggcmVzdWx0cyB0aGUNCj4gY29ycnVwdGlvbi4NCj4gDQo+IFdo
YXQgc2NlbmFyaW9zIHdvdWxkIGRvIHRoYXQgPw0KPiANCj4gUGFja2V0cyBzZW50IHRvIG5kb19z
dGFydF94bWl0KCkgYXJlIG5vdCBzdXBwb3NlZCB0byBiZSBzaGFyZWQuICh3aXRoDQo+IHBrdGdl
biBleGNlcHRpb24sIHdoaWNoIGlzIHdlbGwgdW5kZXJzdG9vZCkNCj4gDQo+IEEgZHJpdmVyIHdh
bnRzIHRvIGJlIGFibGUgdG8gb3ZlcndyaXRlIHBhcnRzIG9mIHNrYiAoc2tiLT5uZXh0IGFuZA0K
PiBtYW55IG90aGVyIGZpZWxkcyksIHRoaXMgaXMgbm90IHNwZWNpZmljIHRvIEdTTw0KPiANCj4g
QSByZWFsIGZpeCAoaWYgbmVlZGVkKSB3b3VsZCBwcm9iYWJseSBiZSBlbHNld2hlcmUuDQo+IA0K
VGhpcyBjcmFzaGVkIHNrYidzIHVzZWVyIGNvdW50PTIgaXMgYWRkZWQgaW4gdGhlIGxhc3QgbGlu
ZSBvZg0Kc2tiX3NlZ21lbnRfbGlzdDogc2tiX2dldChza2IpLiBBcyBpdCBpcyBjcmFzaGVkIGJl
Zm9yZSBpdCBydW5zIHRvDQpjb25zdW1lX3NrYiwgaXQgaXMgd3JvbmcgYWJvdXQgbXkgc2hhcmVk
X3NrYiBndWVzcy4NCg0KDQo+ID4NCj4gPiBTbyBmb3Igc2hhcmVkIHNrYiwgaXQgbmVlZHMgdG8g
Y2xvbmUgZmlyc3QgdGhhbiB1bmNsb25lIHdpdGggaGVhZGVyDQo+IGFuZA0KPiA+IGRhdGEgc2Vw
YXJhdGVkIGZvciBkaWZmZXJlbnQgZGV2aWNlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IGxl
bmEgd2FuZyA8bGVuYS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFdoeSB0YXJnZXRpbmcgbmV0
LW5leHQgPw0KPiANCkkgYW0gbm90IGZhbWlsaWFyIHdpdGggdGFnIHVzZWQuIHNvcnJ5Lg0KDQpU
aGlzIGlzc3VlIGlzIHJlbGF0ZWQgd2l0aCBwYXRjaDogW1BBVENIXSBuZXQ6IGZpeCBOVUxMIHBv
aW50ZXIgaW4NCnNrYl9zZWdtZW50X2xpc3QNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9Z
OWd0NUVVaXpLMVVJbUVQQGRlYmlhbi8NCg0KWmhhaVlhbiB0b2xkIG1lIGluIG1haWwgdGhlIHBy
b2JsZW0gc2hlIGVuY291bnRlcmVkIGlzIHJlbGVhdGVkIHRvIEJQRg0KZGVjYXBzdWxhdGlvbiBh
bmQgbWlzY29uZmlndXJhdGlvbiwgd2hlcmUgVURQIHBhY2tldHMgZnJvbSBhIEdVRSB0dW5uZWwN
CnRyaWdnZXJlZCB0aGUgY3Jhc2g6R1JPIG1lcmdlcyB0aGUgR1VFIHBhY2tldHMgYXMgZGF0YSBh
bmQgYSBCUEYNCnByb2dyYW0gcHVsbHMgb2ZmIHRoZSBHVUUgaGVhZGVyIGF0IHRjLiBTaW5jZSBp
biB0aGlzIGNhc2UgdGhlIGlubmVyIElQDQpoZWFkZXIncyB0b3RhbCBsZW5ndGggaXMgbm90IHRv
dWNoZWQgYnkgR1JPLCBhZnRlciBkZWNhcHN1bGF0aW9uIHRoZQ0KaGVhZCBza2IgYmVjb21lcyBp
bmNvbnNpc3RlbnQgd2l0aCB0aGUgcmVhbCB0b3RhbCBsZW5ndGggb2YgR1JPIGNoYWluLg0KaXBf
cmN2X2NvcmUgdGhlbiB0aGlua3MgdGhpcyBwYWNrZXQgaXMgdG9vIGxvbmcgYW5kIHRyaW0gaXQg
dG8gZml0LA0Kd2hpY2ggaW5oZXJlbnRseSBkcm9wcyBmcmFnX2xpc3QuDQpGdXJ0aGVybW9yZSB0
aGVyZSBhcmUgc2V2ZXJhbCBsb2NhdGlvbnMgdGhhdCBtYXkgYWx0ZXIgdGhlIHBhY2tldA0KbGF5
b3V0LCBsaWtlIHBza2JfcHVsbF90YWlsLiBJdCBjYW4gaGFwcGVuIHdoZW4gc2tiLT5sZW4gbWlz
bWF0Y2hlcw0KaXBoZHItPnRvdF9sZW4sIGZvciBleGFtcGxlLg0KDQoNCldpdGggemhhaXlhbidz
IHBhdGNoIHdoZW4gaW4gdGhpcyBzY2VuYXJpbyBza2IncyBmcmFnX2xpc3QgaXMgbnVsbCwgaXQN
CndpbGwgYmUgYSBza2Igd2l0aCBza2ItPm5leHQ9bnVsbCB3aGVuIHNrYl9zZWdtZW50X2xpc3Qg
aXMgZmluaXNoZWQuDQoNClRoZW4gY3Jhc2ggbW92ZXMgaW50byBfX3VkcF9nc29fc2VtZW50X2xp
c3QgLT4gc2tiX3NlZ21lbnRfbGlzdChmaW5pc2gpDQotPiBfX3VkcHY0X2dzb19zZWdtZW50X2xp
c3RfY3N1bSwgaXQgdXNlcyBza2ItPm5leHQgd2l0aG91dCBjaGVjayB0aGVuDQpjcmFzaC4NCg0K
V2hldGhlciBkbyB3ZSBuZWVkIHRvIGltcGxlbWVudCBoZXJlIHRvIGlnbmVyZSBpdD8NCg0KDQpU
aGFua3MNCkxlbmENCg==
