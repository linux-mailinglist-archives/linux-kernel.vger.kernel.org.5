Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF687E1864
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 02:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjKFBhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 20:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFBhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 20:37:15 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69DDBB;
        Sun,  5 Nov 2023 17:37:11 -0800 (PST)
X-UUID: fee062da7c4411ee8051498923ad61e6-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VK+7BDx+fCE/oXxqP2tL27z7QlhaWpTtNQHQ/s4g6KI=;
        b=XCYdr22tRLZCSpCxf2KTcL2q3+lzwPZs5ioPf4SXtzTeZv9uG0s9Ftz/gH8wCqDH4g26eh9xQKd+3R0thzLiZKY6M6tPRNxE4pf9rnrhELeKe919xU35rORAYEHXND8zNTTLjWQ+8TTrhKKMnfQ0sBuJJ/xA2pICjCRKan4cmyY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:270bac4f-88ca-4d7d-ab7d-ff5ef5f3684d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:a4b9b55f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: fee062da7c4411ee8051498923ad61e6-20231106
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 461219139; Mon, 06 Nov 2023 09:37:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 09:37:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 09:37:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCvh8uiRjuYj4rjI7lDK8e/H1x4jds35YGpQdBCBI1DugtBifl8Kx+ZWfgD8iBsZ5L1A2NGIC04H5f8n8acjnZoUHc+4AW/Ekbr7enzU3JEpQ6nEGepWNXdorV32Mru6Be1WffE9v8zxfoa8zHL8lRRwkJ/yo+5Q2y5GUEsdkawXuxApaEA9Tg+OMJ12wExdpDJTPyJZfL9Lfq5V6qVWXXdHMleRQLQT6q8lX8yMCTuGhwZwmTMByx6xB1IqfYFudnww1RxPC3OxNN+h/LUB0Rx4IuP/73+HhyxuKCFaBRGmG1vFZDQp/i2I1W0qjuxc7PkMShlrJr9aBDszOBcqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK+7BDx+fCE/oXxqP2tL27z7QlhaWpTtNQHQ/s4g6KI=;
 b=G5LwOcA3SoCbLE3ZvNnnc2BVsfcjxlMW8YbfWJ3pOGDzHOAIIN4aq54EaE92ZaMtuTgtwn2ij8N9DXE4IMQv07GW4c3V++tFuMI8oDD+ZrW9pVGgXRLTRMUYOO0kZ7/7re+/AaUrdjIr9M6W+GyJ8/hFU+SH6Z2KHhaSB7ccW9YJmXmMO91j//lmfeJRhgJt6qF6OdrsG3hR6UDNbuRi1KIZAdAhLGAz1qJgV4vjyuAr2mrTEA5n5/lPzQbaq4h+BRz1XKfgSnpuV6TZ1z3sVS2wtA0KYDWH19AyVQH+s3OuWfX1eQqJBZuhkcTkhe6VJy6JRoTFjvB8x+cgqdC3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK+7BDx+fCE/oXxqP2tL27z7QlhaWpTtNQHQ/s4g6KI=;
 b=KxrCCbzvJt53pXu8dAssI/jVgIVXhSyGNt2yyhrNj5jJrLdcdFGN0/7kQS3k2ytp/Szj+XGLPiXh4BNQdJUxUwg5UyGvtGepjNjtiSfain11ex09CBtm8byhtSnT965YFs1ZtxaJ6xgc/RegNxW+Y9kw12m2MvMezNWGdLXOAng=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8282.apcprd03.prod.outlook.com (2603:1096:405:21::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 01:37:02 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 01:37:02 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 00/11] Add mediate-drm secure flow for SVP
Thread-Topic: [PATCH v2 00/11] Add mediate-drm secure flow for SVP
Thread-Index: AQHaBWv+DtPKKTElakCPQS1xZAUuxrBjNIAAgAidHQCAAMcEgA==
Date:   Mon, 6 Nov 2023 01:37:02 +0000
Message-ID: <aff783bfe5996ba322fce8a07daa07c92c80f83d.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <83ab8f76b48b27a5406a03c50467c968598b23db.camel@mediatek.com>
         <45eaa8a62bdb4a17b443c0ed8b3210a4b3b4a670.camel@mediatek.com>
In-Reply-To: <45eaa8a62bdb4a17b443c0ed8b3210a4b3b4a670.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8282:EE_
x-ms-office365-filtering-correlation-id: 52f9cf36-a891-44d4-c2c3-08dbde68e020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zx5nuYPzLgumy2WpqHM+8axut7aMAXAzgi7YMOFssmWf7bD29g5CaY0Rz7aHITE7xtCHOIeB9i1GLLoF4aUgtl+btrVc5Oz1sfCpADvB0xJ8ZdwUssZMPrwP3EEaA+2f/nvqzmKxIjoVA3UygxYrch1fjp/5GDcIp/RtkNTavMxb5XlyA/cOncAl46NgGU1T3Bsj2GsdVDCLp0EnZdjmmWB4rv9cxTEUTA6Fe3EOuCALa+SMM257yVfaVzHFe5vxhkpmYMsFUWt91mJrp9OXpmEKxJW8RXr+CGegieo667+L4Q39fI6uvjVj988Qatym5DYIEdRm1Yy8y/et5ujTzk/z5Zd6XifbJdKdxmaiA6CEiKlaAE4wu0iVOnJV8ipEGCOBUOnTP10LyH7xjZzeXcu1hW8dG+DD6bXlUfHpLXskambxKjGsQvQySNlI5tDYvlc8soJHzXOkekpYmN4VZ3hUTPEq9hv9qUfDT2wU7BeG35ECmRMHHvB5aJhjCGTgc/FVSYByYMDN4xxO+KJVS9+ZZ3s6YnouJI3yUltCf9Tun6S4zliKQjNmvdU1ru/dQiZi5wkkfHePMEpCX7z5jeptBxpjHclueOWVurViub/2GANcdIP798iMheb7ATRfZJ9EKTzhK2Dj0TKlJMaDcj+eEWzO6cjcUALBYTPFZpin9M4eOnjlnScBGBQI2WWC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39850400004)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(8676002)(4326008)(41300700001)(8936002)(36756003)(2906002)(38100700002)(5660300002)(6486002)(966005)(66556008)(6512007)(316002)(54906003)(66476007)(64756008)(66446008)(85182001)(4001150100001)(86362001)(7416002)(110136005)(76116006)(66946007)(83380400001)(26005)(38070700009)(2616005)(122000001)(71200400001)(478600001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1c0KzBVK2UvbE5sbEQwVWZUNU9nUVJhVmxNRkRvUUFrYkhWT3BodWRqK2Y0?=
 =?utf-8?B?T0FFcmJKOUkxTmxObUJCSUdJNnRqR1RYYXI4aU9NZit4aUFWWU1tN3lmM0hu?=
 =?utf-8?B?bFdTVlYxUzR0Zk8wRDJYRkZsZWo3a1RYcU93UWZlWEMzK2ZCOHd5ZkpJRVNq?=
 =?utf-8?B?YVdVdTlzcWRUZmJMaWdVQlZiQnV2YW1LZzFxTi9rWDV3ekZlditTRVBTZ0Zo?=
 =?utf-8?B?Mk9zcVZLWVJiaHBxdjhYMGZvNWtITVJCdUhQQk9zTmdQWFlOam5TbThKTzJC?=
 =?utf-8?B?cGhES3lqQ2FwWC9aekJmRnJFSGUzUDlXV0twRkVyaUw4SzlkK3ZhcXp4ejV0?=
 =?utf-8?B?dUMrQ2FGcTUrZXVNZDlFNXcvMGRXSGMrSFI3Y1ZZcU54ZU4wV0k4TlJBL1pi?=
 =?utf-8?B?TmxqQk1tc3ZXeVRGaEthSVh2SmlETGh3OU5UYWZseE1hc2xqajREbnJWVUtR?=
 =?utf-8?B?cDRaeTRLYmlkUGpkaEcxRUtyRkVhcDRMSGx2Y1lJaUt5MXpaNjdGUHBBL0di?=
 =?utf-8?B?Wm9yR3YydlFzMFY5Z0tKM0hmb1Q1dmxDQUkxYit5eXdMckVWcjd4eEEyZndQ?=
 =?utf-8?B?eEhQQ1BCWVQ1NEZIUkthMFhCRm5wY1FuTmlRcnRnNUMyZUNpaDNETFFtN2cw?=
 =?utf-8?B?MFZUVXNINHdBK3dOcmFLUXRtNVlMdnIrdHBGOGk1YmtTNU9QN0R2L3FtNTJo?=
 =?utf-8?B?VXRoazU1elUzeldkSUVkL2orOVVCRDQzckJZT3VhMEE4dkM5NHlGcTA1UzJa?=
 =?utf-8?B?OFdVdll3Wk1Zc1pEbC9vNTJac2VvSHJtTS8ySWR3SzVsZ25HdkZOK1hIS1kv?=
 =?utf-8?B?Q0RmNndvTFNYc2RMZmZvclp5SzBNcjhnbzZyRmZyaWJzbnpnUFMwMXpwbjli?=
 =?utf-8?B?VW5VV0ZPQkF5emxyTzVIV1JJeUFFK002R2VUL2ZRUXcwRnNWN0JyellaZ0JO?=
 =?utf-8?B?SzlVTjRwK0FiVXo3V2l1L3dnS0pmb3gxampGYW45RDJybUlTeFhBNVVPQXFS?=
 =?utf-8?B?NW5uQUZqUlN0MW1TNlFQWFFlZUdxYkVhM0RTM2luMXpZTkJKbSt5amxVN1lr?=
 =?utf-8?B?YzdZSHdOU29Ra016czJmbmd1cXp5WEN2bUVEQUlyeUNEa214T21Qdk5xbC9k?=
 =?utf-8?B?aGNHb3pqVUUwYUJUb1N3Wkg2QU5CUE01NGltZVZ4VjhRdW4wUFMxalZDUklw?=
 =?utf-8?B?amNyNC9KTkR1UW5Ta0hDSUNrcFNEN0ZWVGpxTHNVMFlWYXNEb2svVXQwYW84?=
 =?utf-8?B?UHJBQ3lsRTd3dVIrTFhHVFRQa3FrUFk0U0p6cUVvZzdmYkpzR2Evc3NlM1Nx?=
 =?utf-8?B?R2N1TWZrK0NmT2QvNHFjOC9hdUZ0ODh5MVQySUZ0K1Z5aTY4cXBGaFU3K0ZC?=
 =?utf-8?B?T1d6Y29GTHBNVXAwMEkyTW1DRzJIUGV0MHljbDRaYmRCNmhCOStHOEtKbUZp?=
 =?utf-8?B?NXBRVUpSL28zOVdMaENuK1E2MFQ4MVFCVm9mNy80cVJRMW44ZHNpaVVrVlBB?=
 =?utf-8?B?OFZEc01IY2h4YzJsUllFTWg3bVlkb3BRUWZlMmU2cjRrNUtjaG0xL2NCdVZB?=
 =?utf-8?B?bHF5RzFYbUlNd1RRY01JL21jU05qWGRaT1pXQW9sQWZMdVRkZExMZ0MwWVk4?=
 =?utf-8?B?WnFDeVJZL3c3NHJzWXc5MEhpdjNGR2ZTUWlrSUZHeklEZ0ZzRWEwTk5lK0w0?=
 =?utf-8?B?RGxjdHRQMEhtbEZIdTRtZVJQdlcySmdiK1o4ajFHRkRvR0xQVlpDWG1FSjhO?=
 =?utf-8?B?T0NTWGExMHdzSEdXa3hzY0pWaFYycEN5ekNveW80eWtKS0t0YmtzYnNWeXpO?=
 =?utf-8?B?VGtMVlVNZUhjVzRGamdlNG5QenA5NDFDL2dsNWxHbzhWVzFCbW1uUWlmdklU?=
 =?utf-8?B?ZUxhWm05WTYvUlVuWEUybmpFOGVpcUVlOEZLUTFEclo5WXpseWdGSmsyUU5X?=
 =?utf-8?B?YVdsV0JydUtjOUkrOHZiTE1YaklRaUE1akdXZlVuUDA0UkFkODJIZ2x3Wlp6?=
 =?utf-8?B?V0gyYklIVTZFSnRSU2pLRjNRMmZERmRVdlhyTUtONVp2REREQ04rV2p6UTkz?=
 =?utf-8?B?QWozV3RUemVlcHJJbmFMdDFHUkpEODhZL2pLUUJvR0VEZTNlVnB5M3VFdXph?=
 =?utf-8?Q?oPNeUJ8L22s480scPW/CF7plh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <143A820167CE2B42984963EBC13F8A19@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f9cf36-a891-44d4-c2c3-08dbde68e020
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 01:37:02.0895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D66Lk///t+xMjr7KjJDhei8/ljfELbH9EiYFkm3Dl24jwsVVaSNm16lAXzce1Ois9A1vHovf7N89+UGn2YJaqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8282
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.144400-8.000000
X-TMASE-MatchedRID: WMT2WRIkHPMOwH4pD14DsPHkpkyUphL9EtdrY/Wb3fPdywP+TFB0z7mn
        rGB/kwGM0qEnS62LQo+XQZXhovdntv/Js/ghYmSKhK8o4aoss8ooUVkB7ifJnjDJ9a3KikGoSuc
        qLHu3mZMk7FhZLnoFU/5FiV4N3Tf6fnx66e7JyubXIwmz2YEJxQd1gf75ubQYT7S4ZU4XTxCooO
        hgfg51ELGFv5k4++vVwTzZE6vGH1zU4D7YCSb+lFz+axQLnAVBZG3SCLP7QtIR34ro7k23naw3j
        KXVjW6NRw3fpQHgw3tMmA9tcmg664oNrmb7m9Z4TSPNp9e/u1NEFOBX+MGx2lSOymiJfTYXOnIM
        ExXg3X98RMc7UuMnj4QodpQAu3fBODilBbykZNhDiyuN5FvFNkyQ5fRSh265NSweOixQAJLN/sJ
        iE7zJ+OLzNWBegCW2PZex/kxUIHXkDYpm17LnQ/1vTGBiuZrt1GcRAJRT6POOhzOa6g8KrQQHvE
        ge5zaHeRYYrWODnLuYn84xae10d/qeZmRhQddjI7NFqud4jE4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.144400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 70D3812C81DF43DF5B4372F0FA4BEDEAB377837E0A62794AFC64D8AEAF952C742000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTExLTA1IGF0IDEzOjQ0ICswMDAwLCBKYXNvbi1KSCBMaW4gKOael+edv+el
pSkgd3JvdGU6DQo+IEhpIENLLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3cy4NCj4gDQo+
IE9uIFR1ZSwgMjAyMy0xMC0zMSBhdCAwMjoxMiArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3Jv
dGU6DQo+ID4gSGksIEphc29uOg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyMy0xMC0yMyBhdCAxMjo0
NSArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+ID4gVGhlIHBhdGNoIHNlcmllcyBwcm92
aWRlcyBkcm0gZHJpdmVyIHN1cHBvcnQgZm9yIGVuYWJsaW5nIHNlY3VyZQ0KPiA+ID4gdmlkZW8N
Cj4gPiA+IHBhdGggKFNWUCkgcGxheWJhY2sgb24gTWVkaWFpVGVrIGhhcmR3YXJlIGluIHRoZSBM
aW51eCBrZXJuZWwuDQo+ID4gPiANCj4gPiA+IE1lbW9yeSBEZWZpbml0aW9uczoNCj4gPiA+IHNl
Y3VyZSBtZW1vcnkgLSBNZW1vcnkgYWxsb2NhdGVkIGluIHRoZSBURUUgKFRydXN0ZWQgRXhlY3V0
aW9uDQo+ID4gPiBFbnZpcm9ubWVudCkgd2hpY2ggaXMgaW5hY2Nlc3NpYmxlIGluIHRoZSBSRUUg
KFJpY2ggRXhlY3V0aW9uDQo+ID4gPiBFbnZpcm9ubWVudCwgaS5lLiBsaW51eCBrZXJuZWwvdXNl
cnNwYWNlKS4NCj4gPiA+IHNlY3VyZSBoYW5kbGUgLSBJbnRlZ2VyIHZhbHVlIHdoaWNoIGFjdHMg
YXMgcmVmZXJlbmNlIHRvICdzZWN1cmUNCj4gPiA+IG1lbW9yeScuIFVzZWQgaW4gY29tbXVuaWNh
dGlvbiBiZXR3ZWVuIFRFRSBhbmQgUkVFIHRvIHJlZmVyZW5jZQ0KPiA+ID4gJ3NlY3VyZSBtZW1v
cnknLg0KPiA+ID4gc2VjdXJlIGJ1ZmZlciAtICdzZWN1cmUgbWVtb3J5JyB0aGF0IGlzIHVzZWQg
dG8gc3RvcmUgZGVjcnlwdGVkLA0KPiA+ID4gY29tcHJlc3NlZCB2aWRlbyBvciBmb3Igb3RoZXIg
Z2VuZXJhbCBwdXJwb3NlcyBpbiB0aGUgVEVFLg0KPiA+ID4gc2VjdXJlIHN1cmZhY2UgLSAnc2Vj
dXJlIG1lbW9yeScgdGhhdCBpcyB1c2VkIHRvIHN0b3JlIGdyYXBoaWMNCj4gPiA+IGJ1ZmZlcnMu
DQo+ID4gPiANCj4gPiA+IE1lbW9yeSBVc2FnZSBpbiBTVlA6DQo+ID4gPiBUaGUgb3ZlcmFsbCBm
bG93IG9mIFNWUCBzdGFydHMgd2l0aCBlbmNyeXB0ZWQgdmlkZW8gY29taW5nIGluDQo+ID4gPiBm
cm9tDQo+ID4gPiBhbg0KPiA+ID4gb3V0c2lkZSBzb3VyY2UgaW50byB0aGUgUkVFLiBUaGUgUkVF
IHdpbGwgdGhlbiBhbGxvY2F0ZSBhICdzZWN1cmUNCj4gPiA+IGJ1ZmZlcicgYW5kIHNlbmQgdGhl
IGNvcnJlc3BvbmRpbmcgJ3NlY3VyZSBoYW5kbGUnIGFsb25nIHdpdGggdGhlDQo+ID4gPiBlbmNy
eXB0ZWQsIGNvbXByZXNzZWQgdmlkZW8gZGF0YSB0byB0aGUgVEVFLiBUaGUgVEVFIHdpbGwgdGhl
bg0KPiA+ID4gZGVjcnlwdA0KPiA+ID4gdGhlIHZpZGVvIGFuZCBzdG9yZSB0aGUgcmVzdWx0IGlu
IHRoZSAnc2VjdXJlIGJ1ZmZlcicuIFRoZSBSRUUNCj4gPiA+IHdpbGwNCj4gPiA+IHRoZW4gYWxs
b2NhdGUgYSAnc2VjdXJlIHN1cmZhY2UnLiBUaGUgUkVFIHdpbGwgcGFzcyB0aGUgJ3NlY3VyZQ0K
PiA+ID4gaGFuZGxlcycgZm9yIGJvdGggdGhlICdzZWN1cmUgYnVmZmVyJyBhbmQgJ3NlY3VyZSBz
dXJmYWNlJyBpbnRvDQo+ID4gPiB0aGUNCj4gPiA+IFRFRSBmb3IgdmlkZW8gZGVjb2RpbmcuIFRo
ZSB2aWRlbyBkZWNvZGVyIEhXIHdpbGwgdGhlbiBkZWNvZGUgdGhlDQo+ID4gPiBjb250ZW50cyBv
ZiB0aGUgJ3NlY3VyZSBidWZmZXInIGFuZCBwbGFjZSB0aGUgcmVzdWx0IGluIHRoZQ0KPiA+ID4g
J3NlY3VyZQ0KPiA+ID4gc3VyZmFjZScuIFRoZSBSRUUgd2lsbCB0aGVuIGF0dGFjaCB0aGUgJ3Nl
Y3VyZSBzdXJmYWNlJyB0byB0aGUNCj4gPiA+IG92ZXJsYXkNCj4gPiA+IHBsYW5lIGZvciByZW5k
ZXJpbmcgb2YgdGhlIHZpZGVvLg0KPiA+ID4gDQo+ID4gPiBFdmVyeXRoaW5nIHJlbGF0aW5nIHRv
IGVuc3VyaW5nIHNlY3VyaXR5IG9mIHRoZSBhY3R1YWwgY29udGVudHMNCj4gPiA+IG9mDQo+ID4g
PiB0aGUNCj4gPiA+ICdzZWN1cmUgYnVmZmVyJyBhbmQgJ3NlY3VyZSBzdXJmYWNlJyBpcyBvdXQg
b2Ygc2NvcGUgZm9yIHRoZSBSRUUNCj4gPiA+IGFuZA0KPiA+ID4gaXMgdGhlIHJlc3BvbnNpYmls
aXR5IG9mIHRoZSBURUUuDQo+ID4gPiANCj4gPiA+IERSTSBkcml2ZXIgaGFuZGxlcyBhbGxvY2F0
aW9uIG9mIGdlbSBvYmplY3RzIHRoYXQgYXJlIGJhY2tlZCBieSBhDQo+ID4gPiAnc2VjdXJlDQo+
ID4gPiBzdXJmYWNlJyBhbmQgZm9yIGRpc3BsYXlpbmcgYSAnc2VjdXJlIHN1cmZhY2UnIG9uIHRo
ZSBvdmVybGF5DQo+ID4gPiBwbGFuZS4NCj4gPiA+IFRoaXMgaW50cm9kdWNlcyBhIG5ldyBmbGFn
IGZvciBvYmplY3QgY3JlYXRpb24gY2FsbGVkDQo+ID4gPiBEUk1fTVRLX0dFTV9DUkVBVEVfRU5D
UllQVEVEIHdoaWNoIGluZGljYXRlcyBpdCBzaG91bGQgYmUgYQ0KPiA+ID4gJ3NlY3VyZQ0KPiA+
ID4gc3VyZmFjZScuIEFsbCBjaGFuZ2VzIGhlcmUgYXJlIGluIE1lZGlhVGVrIHNwZWNpZmljIGNv
ZGUuDQo+ID4gPiANCj4gPiA+IC0tLQ0KPiA+ID4gQmFzZWQgb24gMyBzZXJpZXMgYW5kIDEgcGF0
Y2g6DQo+ID4gPiBbMV0gZG1hLWJ1ZjogaGVhcHM6IEFkZCBNZWRpYVRlayBzZWN1cmUgaGVhcA0K
PiA+ID4gLSANCj4gPiA+IA0KPiANCj4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nl
cmllcz03ODI3NzZfXzshIUNUUk5LQTl3TWcwQVJidyFtRkt4R2ZwWExFRjgtQXpobGpHR19OMTJi
ay1oN1cwLUpaZVRaWmtxeEpnQjVXRmJNVHhlRWphbHJzbExyQUozaXdZRjYtazI3M2pnelhLU1FY
Y2JnUFUkDQo+ID4gPiAgDQo+ID4gPiANCj4gPiA+IFsyXSBhZGQgZHJpdmVyIHRvIHN1cHBvcnQg
c2VjdXJlIHZpZGVvIGRlY29kZXINCj4gPiA+IC0gDQo+ID4gPiANCj4gDQo+IA0KaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9s
aW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9NzgyOTIyX187ISFDVFJOS0E5d01nMEFSYnchbUZL
eEdmcFhMRUY4LUF6aGxqR0dfTjEyYmstaDdXMC1KWmVUWlprcXhKZ0I1V0ZiTVR4ZUVqYWxyc2xM
ckFKM2l3WUY2LWsyNzNqZ3pYS1NJUHlDUXhJJA0KPiA+ID4gIA0KPiA+ID4gDQo+ID4gPiBbM10g
c29jOiBtZWRpYXRlazogQWRkIHJlZ2lzdGVyIGRlZmluaXRpb25zIGZvciBHQ0UNCj4gPiA+IC0g
DQo+ID4gPiANCj4gDQo+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIzMTAxNzA2
NDcxNy4yMTYxNi0yLXNoYXduLnN1bmdAbWVkaWF0ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3
IW1GS3hHZnBYTEVGOC1BemhsakdHX04xMmJrLWg3VzAtSlplVFpaa3F4SmdCNVdGYk1UeGVFamFs
cnNsTHJBSjNpd1lGNi1rMjczamd6WEtTck84Z21iSSQNCj4gPiA+ICANCj4gPiA+IA0KPiA+ID4g
WzRdIEFkZCBDTURRIHNlY3VyZSBkcml2ZXIgZm9yIFNWUA0KPiA+ID4gLSANCj4gPiA+IA0KPiAN
Cj4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz03OTU1MDJfXzshIUNUUk5L
QTl3TWcwQVJidyFtRkt4R2ZwWExFRjgtQXpobGpHR19OMTJiay1oN1cwLUpaZVRaWmtxeEpnQjVX
RmJNVHhlRWphbHJzbExyQUozaXdZRjYtazI3M2pnelhLU3Bvc0QyUmskDQo+ID4gPiAgDQo+ID4g
DQo+ID4gU2VjdXJlIGRpc3BsYXkgZGVwZW5kIG9uIHNlY3VyZSBtbXN5cy4gUm91dGluZyBjb250
cm9sIHNob3VsZCBiZQ0KPiA+IHNlY3VyZQ0KPiA+IHNvIG1tc3lzIGRyaXZlciBzaG91bGQgaGF2
ZSBzb21lIG1vZGlmaWNhdGlvbiB0aGF0IGNhbGwgaW50byBzZWN1cmUNCj4gPiB3b3JsZCB0byBj
aGFuZ2Ugcm91dGluZy4gQWRkIG1tc3lzIHNlcmllcyBpbiB0aGlzIGRlcGVuZGVuY3kgbGlzdC4N
Cj4gDQo+IFllcywgSSdsbCBtb3ZlIHRoZSByb3V0ZSBzZXR0aW5ncyB0byB0aGUgc2VjdXJlIHdv
cmxkIGZvciB0aG9zZSBTVlANCj4gc3VwcG9ydGVkIFNvQy4gVGhlIG1tc3lzIG1vZGlmaWNhdGlv
bnMgYXJlIHN0aWxsIGluIHByb2dyZXNzLiBJdCB3aWxsDQo+IGJlIHNlbmQgYWZ0ZXIgYSBmZXcg
dmVyc2lvbi4NCg0KQWRkIFRPRE8gaW5mb3JtYXRpb24gc28gdGhhdCB3ZSB3b3VsZCBub3QgZm9y
Z2V0IHRoaXMuDQoNCj4gDQo+IFJlZ2FyZHMNCj4gSmFzb24tSkguTGluDQo+IA0KPiA+IA0KPiA+
IFJlZ2FyZHMsDQo+ID4gQ0sNCj4gPiANCj4gPiA+IC0tLQ0KPiA+ID4gQ2hhbmdlIGluIHYyOg0K
PiA+ID4gDQo+ID4gPiAxLiByZW1vdmUgdGhlIERSSVZFUl9SRE5ERVIgZmxhZyBmb3IgbXRrX2Ry
bV9pb2N0bA0KPiA+ID4gMi4gbW92ZSBjbWRxX2luc2VydF9iYWNrdXBfY29va2llIGludG8gY2xp
ZW50IGRyaXZlcg0KPiA+ID4gMy4gbW92ZSBzZWN1cmUgZ2NlIG5vZGUgZGVmaW5lIGZyb20gbXQ4
MTk1LWNoZXJyeS5kdHNpIHRvDQo+ID4gPiBtdDgxOTUuZHRzaQ0KPiA+ID4gLS0tDQo+ID4gPiAN
Cj4gPiA+IENLIEh1ICgxKToNCj4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgaW50ZXJmYWNlIHRv
IGFsbG9jYXRlIE1lZGlhVGVrIEdFTSBidWZmZXIuDQo+ID4gPiANCj4gPiA+IEphc29uLUpILkxp
biAoMTApOg0KPiA+ID4gICBkcm0vbWVkaWF0ZWsvdWFwaTogQWRkIERSTV9NVEtfR0VNX0NSRUFU
RURfRU5DUllQVFRFRCBmbGFnDQo+ID4gPiAgIGRybS9tZWRpYXRlazogQWRkIHNlY3VyZSBidWZm
ZXIgY29udHJvbCBmbG93IHRvIG10a19kcm1fZ2VtDQo+ID4gPiAgIGRybS9tZWRpYXRlazogQWRk
IHNlY3VyZSBpZGVudGlmeSBmbGFnIGFuZCBmdW5jdXRpb24gdG8NCj4gPiA+IG10a19kcm1fcGxh
bmUNCj4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgbXRrX2RkcF9zZWNfd3JpdGUgdG8gY29uZmln
IHNlY3VyZSBidWZmZXINCj4gPiA+IGluZm8NCj4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgZ2V0
X3NlY19wb3J0IGludGVyZmFjZSB0byBtdGtfZGRwX2NvbXANCj4gPiA+ICAgZHJtL21lZGlhdGVr
OiBBZGQgc2VjdXJlIGxheWVyIGNvbmZpZyBzdXBwb3J0IGZvciBvdmwNCj4gPiA+ICAgZHJtL21l
ZGlhdGVrOiBBZGQgc2VjdXJlIGxheWVyIGNvbmZpZyBzdXBwb3J0IGZvciBvdmxfYWRhcHRvcg0K
PiA+ID4gICBkcm0vbWVkaWF0ZWs6IEFkZCBzZWN1cmUgZmxvdyBzdXBwb3J0IHRvIG1lZGlhdGVr
LWRybQ0KPiA+ID4gICBkcm0vbWVkaWF0ZWs6IEFkZCBjbWRxX2luc2VydF9iYWNrdXBfY29va2ll
IGJlZm9yZSBzZWN1cmUgcGt0DQo+ID4gPiBmaW5hbGl6ZQ0KPiA+ID4gICBhcm02NDogZHRzOiBt
dDgxOTU6IEFkZCBzZWN1cmUgbWJveCBzZXR0aW5ncyBmb3IgdmRvc3lzDQo+ID4gPiANCj4gPiA+
ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpICAgICAgfCAgIDYgKy0N
Cj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgfCAg
IDMgKw0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAg
ICB8ICAzMSArLQ0KPiA+ID4gIC4uLi9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFw
dG9yLmMgICB8ICAxNSArDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jICAgICAgIHwgMjc0DQo+ID4gPiArKysrKysrKysrKysrKysrKy0NCj4gPiA+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmggICAgICAgfCAgIDEgKw0KPiA+ID4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgICB8ICAxNCArDQo+
ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCAgIHwgIDEz
ICsNCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAgICAg
fCAgMTMgKw0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5jICAg
ICAgICB8IDEyMSArKysrKysrKw0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2dlbS5oICAgICAgICB8ICAxNiArDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fcGxhbmUuYyAgICAgIHwgICA3ICsNCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9wbGFuZS5oICAgICAgfCAgIDIgKw0KPiA+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuYyAgICAgICB8ICAxMSArLQ0KPiA+ID4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuaCAgICAgICB8ICAgMiArDQo+ID4gPiAgaW5j
bHVkZS91YXBpL2RybS9tZWRpYXRla19kcm0uaCAgICAgICAgICAgICAgIHwgIDU5ICsrKysNCj4g
PiA+ICAxNiBmaWxlcyBjaGFuZ2VkLCA1NzAgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0p
DQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvdWFwaS9kcm0vbWVkaWF0ZWtfZHJt
LmgNCj4gPiA+IA0K
