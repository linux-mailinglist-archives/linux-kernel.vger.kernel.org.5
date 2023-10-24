Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153707D4C17
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjJXJ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjJXJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:26:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7081730;
        Tue, 24 Oct 2023 02:25:39 -0700 (PDT)
X-UUID: 4870cf2a724f11ee8051498923ad61e6-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=radsxxGhvz0N/hazyKGoLm3wbBwpAfXckGdNSc60hG0=;
        b=RPnkQUu1OX5wjvn/tkaaOya2RmFBs6MMu53L+ASoBKwGIzfpjJt11K+ZdYCRTWZ1vaSnjpHtCpwXw5MqQWlr7gdBkr/bo0XUEepY0f1FmI8Z6i8eGYhjm8J4F5W1TJLp0uarhfkEirYWDoul57uKbjlmvKiqlgVR/Om+Jnzc84o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:0d654daa-7ddb-4c6a-82cc-46461b07597c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:501241d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4870cf2a724f11ee8051498923ad61e6-20231024
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1447953106; Tue, 24 Oct 2023 17:25:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 17:25:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 17:25:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDD/sj0LsNqXGeg2IfyLmFdNNdJWFavBltssBv6MLVgGrT8bxsNoKQTLVLQt7QHtfpHcQZBTZv1T1O8tvFyk72xTStWqxR/k1M936hC/XNmvqM4CjyNuWTWdrCKpYunReGoe4Nij5ZqA2HNXUPy5EAAv0ydjOSqtC1Du3xmum+sp9qxQUVzOJstI8GvlKUvMGh1bY0pb2QECirOOzRRYISRMDlvihYq9oVFbyo4MuKw4kaptPMA37dxaTSsOGG3lqy0M9R+IFtiEVHdVHg/e/Z+ngYehsfajpQ9EU5VW08yQ5NL66rCjDxqX/+8SXApvH5n8UTnc82rIJdPI47J+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=radsxxGhvz0N/hazyKGoLm3wbBwpAfXckGdNSc60hG0=;
 b=j5qE3MZ3xcT7CEbWsPc3NTU+yNir2MIYgfr8OLdROt35t6AVUjNbtjkDjcW5bsXiMyc+V5N0P/ur+qv7Bzjo1gY9sWk3CQL3cIYnTaGF9nP/E1XAqSX04g++n+h9jCyEfyL4T8mHlS2wGNMG6qXpp05hIBhcFXU0kDNnvPZoa8VTu3EmR4PdXy4ccJ0qk9L5danqqOH/KqsCIkiTkxd+BWr5uzGJ9X6wwoC02ASNmHZhYL+Uo+P/ydtD7Ub+aUgef+iZEiLzcoKDyw83/i3Dxq+uDoUPOkh4FgvIgdA//nmN4FY1srIi1aTZHQ4RalV4Gk1zTED9WmeNE7sX+fqIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=radsxxGhvz0N/hazyKGoLm3wbBwpAfXckGdNSc60hG0=;
 b=jBjTUIOz8DCGpvOL4/ZnsUpOmsLLxhsfivyCbHJeY/qq3bsXWmpqe+K/h5d4EnLCBJihbiWtWibLTjUGRzw3MR7w8Nv7JQ0of6gWD5YUaNogjjc4MxVYGfVPInv3rdkEGBnpEJUgjP9E3HwzZMRmkSKRaGkUaoXkbV1B4qvHaqg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7840.apcprd03.prod.outlook.com (2603:1096:101:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 09:25:30 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3%4]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 09:25:29 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v10 15/24] drm/mediatek: Remove ineffectual power
 management codes
Thread-Topic: [PATCH v10 15/24] drm/mediatek: Remove ineffectual power
 management codes
Thread-Index: AQHaAlEm0dkQ5m+JsEiSR2VqoxkRGbBYs2yA
Date:   Tue, 24 Oct 2023 09:25:29 +0000
Message-ID: <1f85f397425fa3332bd594e4b953593a1665287f.camel@mediatek.com>
References: <20231019055619.19358-1-shawn.sung@mediatek.com>
         <20231019055619.19358-16-shawn.sung@mediatek.com>
In-Reply-To: <20231019055619.19358-16-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7840:EE_
x-ms-office365-filtering-correlation-id: 7528dbe7-2fb3-4f36-5770-08dbd4732a46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZmImt8BbsNjiFsk6c8EFFFQAo3+ajO4oaL1ECen3/OjOV2fA7OCtLAjW5gErGsOMedSGHJbQQWDbWw6+ToZVj8HvcL4rRwPjNuAXY05utIRR+lwZCi1u86uC1Ea+XvXHganKzg8rwbNXQU7HrtyjzWHwYc9kc5aEP2kT5rqtwYGZeQIqzH5BI/T+tcpKCJfN1Ak/yzJ3ltxZJAfZNANRaBffnxWkkhLhN+qGi4JCZbvWXYTkly2UCpKnt17DKK3W4WWlz19cTjmXYEsrd645ZntFYgN7w54kViNAKVCzLcfJGiHsdPFdp8P9rhmz4GuHdd4UFIv93W0+PFUn38DncHpUxPa3HZY6uxzvGTwrhOkFkncbV/9t69PP4hLaE6XRMq/j7i31FTAhwJnhCYR6dXRYy3lvZx2RweX6DE1P62qgY7UmpAFXhEW2VXxbsUeteViyZ7Yoe2WUF6j6N31rI1EWZd/+aUez84Ct8A2myZP3JVdTmfsF5/niIWYcajTr4pmd940g4dJmnb+E3FgAMvbvV0jmss6+d200y6of9Zayxf74KbZkk7DCqzQexy7E1ch8cAyKh+F0byj+cH73fcyoADpRTaNj0NxgEKhmH9fQ+VdXvcOuwLLRGt93hct8HGzk5O9x6gtCDm4qTM9Smi44QruQAvgxwHXDzpv1BUk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(2616005)(316002)(54906003)(26005)(6512007)(86362001)(110136005)(76116006)(66946007)(6486002)(478600001)(6506007)(71200400001)(83380400001)(122000001)(38100700002)(64756008)(7416002)(85182001)(5660300002)(66556008)(41300700001)(66446008)(66476007)(8936002)(8676002)(4326008)(36756003)(38070700009)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlcvbGE5RzRHajJjT1dqUEh5aDFZdkhDc2hMZGRMQWFJMUkyQnUrWmJtZWFs?=
 =?utf-8?B?cHFLcUhDZG9EMCtrT1EzeXZSSm9hMmVJRTNOU0Z0OGV3NzMzMURwR1lLdk9n?=
 =?utf-8?B?Rm9WSUpoRU4zeEg2ZHUzdDZoWGRlNExPRUdVQzNaRGRCeFVSL0c4dG1yU2VF?=
 =?utf-8?B?OWp6MDBxL0ZsK1oxUE13cjJKMUJNWlJWR3RLS0c3R0hoVXl2RVFIRmw1czNI?=
 =?utf-8?B?bTRwdU1mallld1lJV1N6blBFK3BUR1dYWmNqKzZZY0sxa1BTMFhLMnVlRXBV?=
 =?utf-8?B?cTFtODNVdHZEdHZZTy83NllJN0VvU0xBWEFiVk9GOU5SQ2VGYW1yZEg1Y1Bv?=
 =?utf-8?B?bGE3SUpvelFjbndFa2hZMHhRRHlNUlpqbmJvbXNHbVIyK1hrVWVxNUdnUUhJ?=
 =?utf-8?B?T2dKNGpRMzlaWXVCcUI0UlpHZVJ6dlNybFJXeU83aDFmQVRDOUZVUmRaMzFi?=
 =?utf-8?B?ZjdZZmtzN3Z0aEJ1Z3daNnVzTGZoNWcweVNWTmdyNzhHVDlZU1UvdVFWdlV5?=
 =?utf-8?B?UlU5Uy9PdTlvYzdFcE03MHVJMzhWRXArbjVzaGFqbDRmRTUxWlVUaHBrVDUx?=
 =?utf-8?B?ZnlURzNkZStXMVhqZnQzeWIrc0laMDJRTy9QcDFuemxaTnZ4a2FUS3RiU2dP?=
 =?utf-8?B?RWFxbUZ6WCtTb3Q1YjZmS3I3SkduOFliYTUxemxxd0lTVnM2aGx2UEM0czVh?=
 =?utf-8?B?QllmNkxWNDl4Y3hxT2ZZQmMzTTZsMmwvZXdPL0Q3U2NlWG1PUVF1dVdpOUNJ?=
 =?utf-8?B?MFh6KzYxY2dvTVdrUnJrQXRJWjRXWlFIVnRBRTROMk1tTWdDWXMzc2Nnd0U4?=
 =?utf-8?B?KzA0a2VmNWZSSHMzdG16T0VWbTZ5WEZEUlB3V05xQTJkQkRJbG5pS0ZUdVVW?=
 =?utf-8?B?OXJJa0htdnkxTEc1ZWhCb0V2YThVRDhmN1pZOFFSVzJZYmxNcXBoYUdlSFV3?=
 =?utf-8?B?ZVl0V3J3VlI0R3RvRk1rdUIzZzgyRjZLc3hrV01lWXd0aVZzTlc5LzhaZnhZ?=
 =?utf-8?B?YjRVQjBJWThEWFNMY1M2R3JiWjg1UUVsTzhqMHJxY1l2MDltUTlyWnR5Y3dL?=
 =?utf-8?B?STdLdktPeTB5SG9MUm1HWUR3a1pKbzZYQllBcVUzYnptSGFxNnFOZEZRYkZE?=
 =?utf-8?B?THV1SU1yaFNzeG1HbXJ0U0VOdDZsU1liTm0vOWhka014WEdLZGFjNklQdGVK?=
 =?utf-8?B?YWNYOGdnQlhqRFMrTE5scXhiMGpZc3J1NlBaU055aVY3dy9iWGtqT2hjd3pq?=
 =?utf-8?B?cGxSYzVuLzhFMkJpa2xpRWt5R2cvR0VibXFrY3RxVFQ5cTE2Y1BnRHpWNHpZ?=
 =?utf-8?B?a0NKaCtXbm52SHpxMTRaYTE5c091TkpsOUFNTzdtVVJqeGl6TEIrQWdiNWJH?=
 =?utf-8?B?QkNENnJyZ21Kak1pUlBid2dJNGlaTno4MmlKSlVRT3NSZUovL2JNNStENzdH?=
 =?utf-8?B?b2QwTHBIQ1V1eUQzZFZveWF1TWJpV0JTd0dRVVBSMDJnNGNEMDBEM3FPei9j?=
 =?utf-8?B?aUtkQUpTR0ZmSCtNamZIQXFLVEJyaFBWRW05MnhKQWEyV2ROVEpFQjhwLzdD?=
 =?utf-8?B?SjE2d2JpWXdxOXVicjVmOWJYcWI0MTFkVGFza1RYeENzOWp3NzJaallPL3k3?=
 =?utf-8?B?bDBYVy9uK2sxZk5HekpPd2dmUk1xR3RFZEhKcEdBemJJcnJLc0NmYU45eGlU?=
 =?utf-8?B?R1ZFVXBOWE9rUnNnbGpUc1FkaUs1M2JKR3lVdkJLOWNhMWFENmRJa0k1dWpD?=
 =?utf-8?B?UlU1akRsNkoyYWxyVHJhTVB0WnNVYXVqVitETFJkTm9Bb3dHVWpmKzkvRVpP?=
 =?utf-8?B?eUNuRGhoVkltNVBQcVVZaXM3MkplZDMxVTNkVHFkUW9oYTNwTnllUVkzdVZx?=
 =?utf-8?B?cEx6eC85Y2VjZzhlQ2J2MjRpa3lsYXZVRjNOYkxhTlZtdFdpWDAxdDZHTVY3?=
 =?utf-8?B?RzJOVE1jSzVlbjJ2elZhS1dpNmF6RlJhNFpLZHVBeGpVRnJ3Z2VocnNYVE90?=
 =?utf-8?B?WG9vb0Q4dTZhTkswTDBHNm1rQUhzTHJiT3EwZHlYb2Z4b21nVGpna2ExR2RW?=
 =?utf-8?B?aXNNNExpV0RNUXdFL2dDU0V0ajhoRWFSSGFwaUszUEMxMEtvM2szS3V4NnEy?=
 =?utf-8?Q?0DgkHBjtrsEkEqQPImmGKnc4+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E03E56B4896855459E25B506180EA809@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7528dbe7-2fb3-4f36-5770-08dbd4732a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 09:25:29.8385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RdDMvX3Yr6wukUk/2xiEClo8GCB4yk/HD1LXB6dkPYifnEv+0cr2czyHmSzI906XhG9rHCigOX91dfqmmLelQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7840
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUaHUsIDIwMjMtMTAtMTkgYXQgMTM6NTYgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IERpc3BsYXkgbW9kdWxlcyB3aWxsIGJlIHBvd2VyZWQg
b24gd2hlbiAuYXRvbWljX2VuYWJsZSgpLA0KPiB0aGVyZSBpcyBubyBuZWVkIHRvIGRvIGl0IGFn
YWluIGluIG10a19jcnRjX2RkcF9od19pbml0KCkuDQo+IEJlc2lkZXMsIHRoZSBEUk0gZGV2aWNl
cyBhcmUgY3JlYXRlZCBtYW51YWxseSB3aGVuIG10ay1tbXN5cw0KPiBpcyBwcm9iZWQgYW5kIHRo
ZXJlIGlzIG5vIHBvd2VyIGRvbWFpbiBsaW5rZWQgdG8gaXQuDQo+IA0KPiBGaXhlczogMTE5ZjUx
NzM2MjhhICgiZHJtL21lZGlhdGVrOiBBZGQgRFJNIERyaXZlciBmb3IgTWVkaWF0ZWsgU29DDQo+
IE1UODE3My4iKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24u
c3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fY3J0Yy5jIHwgMTggKysrLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gaW5kZXggYmM0Y2M3NWNjYTE4Li5jN2VkZDgwYmU0
MjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gQEAg
LTYsNyArNiw2IEBADQo+ICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvZG1hLW1hcHBpbmcuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tYWlsYm94X2NvbnRyb2xsZXIu
aD4NCj4gLSNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVr
L210ay1tbXN5cy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstbXV0ZXgu
aD4NCj4gQEAgLTM2MiwyMiArMzYxLDE2IEBAIHN0YXRpYyBpbnQgbXRrX2NydGNfZGRwX2h3X2lu
aXQoc3RydWN0DQo+IG10a19kcm1fY3J0YyAqbXRrX2NydGMsIHN0cnVjdCBkcm1fYXRvbWljDQo+
ICAJCWRybV9jb25uZWN0b3JfbGlzdF9pdGVyX2VuZCgmY29ubl9pdGVyKTsNCj4gIAl9DQo+ICAN
Cj4gLQlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGNydGMtPmRldi0+ZGV2KTsNCg0K
Y3J0Yy0+ZGV2LT5kZXYgaXMgbW1zeXMgZGV2aWNlLiBJbiBtdDgxNzMuZHRzaSwgeW91IGNvdWxk
IGZpbmQgdGhhdA0KbW1zeXMgaGFzIGl0cyBvd24gcG93ZXIuIFNvIEkgdGhpbmsgd2Ugc2hvdWxk
IGtlZXAgdGhpcy4NCg0KUmVnYXJkcywNCkNLDQoNCj4gLQlpZiAocmV0IDwgMCkgew0KPiAtCQlE
Uk1fRVJST1IoIkZhaWxlZCB0byBlbmFibGUgcG93ZXIgZG9tYWluOiAlZFxuIiwgcmV0KTsNCj4g
LQkJcmV0dXJuIHJldDsNCj4gLQl9DQo+IC0NCj4gIAlyZXQgPSBtdGtfbXV0ZXhfcHJlcGFyZSht
dGtfY3J0Yy0+bXV0ZXgpOw0KPiAgCWlmIChyZXQgPCAwKSB7DQo+ICAJCURSTV9FUlJPUigiRmFp
bGVkIHRvIGVuYWJsZSBtdXRleCBjbG9jazogJWRcbiIsIHJldCk7DQo+IC0JCWdvdG8gZXJyX3Bt
X3J1bnRpbWVfcHV0Ow0KPiArCQlnb3RvIGVycm9yOw0KPiAgCX0NCj4gIA0KPiAgCXJldCA9IG10
a19jcnRjX2RkcF9jbGtfZW5hYmxlKG10a19jcnRjKTsNCj4gIAlpZiAocmV0IDwgMCkgew0KPiAg
CQlEUk1fRVJST1IoIkZhaWxlZCB0byBlbmFibGUgY29tcG9uZW50IGNsb2NrczogJWRcbiIsDQo+
IHJldCk7DQo+IC0JCWdvdG8gZXJyX211dGV4X3VucHJlcGFyZTsNCj4gKwkJZ290byBlcnJvcjsN
Cj4gIAl9DQo+ICANCj4gIAlmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmRkcF9jb21wX25yIC0g
MTsgaSsrKSB7DQo+IEBAIC00MjYsMTYgKzQxOSwxMyBAQCBzdGF0aWMgaW50IG10a19jcnRjX2Rk
cF9od19pbml0KHN0cnVjdA0KPiBtdGtfZHJtX2NydGMgKm10a19jcnRjLCBzdHJ1Y3QgZHJtX2F0
b21pYw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4gLWVycl9tdXRleF91bnByZXBhcmU6DQo+
ICtlcnJvcjoNCj4gIAltdGtfbXV0ZXhfdW5wcmVwYXJlKG10a19jcnRjLT5tdXRleCk7DQo+IC1l
cnJfcG1fcnVudGltZV9wdXQ6DQo+IC0JcG1fcnVudGltZV9wdXQoY3J0Yy0+ZGV2LT5kZXYpOw0K
PiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIG10a19jcnRjX2RkcF9o
d19maW5pKHN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0KPiAgew0KPiAtCXN0cnVjdCBk
cm1fZGV2aWNlICpkcm0gPSBtdGtfY3J0Yy0+YmFzZS5kZXY7DQo+ICAJc3RydWN0IGRybV9jcnRj
ICpjcnRjID0gJm10a19jcnRjLT5iYXNlOw0KPiAgCWludCBpOw0KPiAgDQo+IEBAIC00NjUsOCAr
NDU1LDYgQEAgc3RhdGljIHZvaWQgbXRrX2NydGNfZGRwX2h3X2Zpbmkoc3RydWN0DQo+IG10a19k
cm1fY3J0YyAqbXRrX2NydGMpDQo+ICAJbXRrX2NydGNfZGRwX2Nsa19kaXNhYmxlKG10a19jcnRj
KTsNCj4gIAltdGtfbXV0ZXhfdW5wcmVwYXJlKG10a19jcnRjLT5tdXRleCk7DQo+ICANCj4gLQlw
bV9ydW50aW1lX3B1dChkcm0tPmRldik7DQo+IC0NCj4gIAlpZiAoY3J0Yy0+c3RhdGUtPmV2ZW50
ICYmICFjcnRjLT5zdGF0ZS0+YWN0aXZlKSB7DQo+ICAJCXNwaW5fbG9ja19pcnEoJmNydGMtPmRl
di0+ZXZlbnRfbG9jayk7DQo+ICAJCWRybV9jcnRjX3NlbmRfdmJsYW5rX2V2ZW50KGNydGMsIGNy
dGMtPnN0YXRlLT5ldmVudCk7DQo=
