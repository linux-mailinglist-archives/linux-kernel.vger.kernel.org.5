Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1CF800133
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjLABq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLABqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:46:25 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CACD67
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:46:26 -0800 (PST)
X-UUID: 6d6196de8feb11ee8051498923ad61e6-20231201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=U1aX9bEw3vza7MPPhSiicfM2OcRVCOveph6vp+8grio=;
        b=AZ/hWgwepq4o3te7nxgl7vCxjbfxTzV2m2RyNeWFobk3GQdvZ6yGlA5u+VCW0WeZbSzzWkOVr5eoFCj97BKzxrcyxcg8niW1KjF4FlsXqkl9XzVX2H+ePeylYr7VdvRyXA1dcQ3gIdlw6lnJ4x5psuB9gFGbaoi+ru6R6MhC+XE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:bb0d2d16-8f71-47c6-a9ee-6c94859cc0d3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:186b4673-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6d6196de8feb11ee8051498923ad61e6-20231201
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 858087150; Fri, 01 Dec 2023 09:46:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Dec 2023 09:46:19 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Dec 2023 09:46:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKEZ1c00Us/VbT/C85njvErQJpuOMaGjgbmdytjD32tLD1oeGWn4Ick615x7zQMbtI0ZR8GVSBJmlw9QlDueEjRlxWiZA4osuQ43daVZXSUM+prKX/+hjpr6zu188wgbyGLJVKl/1bDu8tbcv4cKo8kVmk2evG8c3Wz6PeJSddZyjUnr/7Q2NpwMIAs6HMt6FWEfHtVmICxAw9JtNqNBExjn+OL9NQKktBqaR40XEEuJCXe8dTBs6+AnvAcyPIt0XfXHI/KDQmQJK5AcYvn8UeOkT7fCKNCTf/F47P4Da9fHNIKGLImdcispLpaja7xsS0VEcHNABEPwe8Cj7UZwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1aX9bEw3vza7MPPhSiicfM2OcRVCOveph6vp+8grio=;
 b=ETrDEVJ4rR+RF+L7Uqm8f1k0HLtTXnKN1tl+g9fqNAw0XBr7r7ELCiOAtIG7vU4jn9BEk570XrgO0ai2oXOq7/QXDb7qBHr1PdGnXgDUknrYFWMFgduQ09tlxEJNCm2h13xfzzSaC5cdgs/E5uVEk56h6B9KmFBqMGT5annrPeXitC2bLedyDFip0w2hhHm7cJwg3zrHBsTZpDm2GO5p7OrPDDnyrkTiXJx3uEJulxwrI48jfcbtxaUnj3+llqUiRgq+JpB5qwzOh/Z1mWsGWkw1n6axi9ZFnh6Ky2RL8lj9ds9alvvQwJs7KfvvpaNzKO5wdopDVgU4vtjAPFhhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1aX9bEw3vza7MPPhSiicfM2OcRVCOveph6vp+8grio=;
 b=g1fAGKgRtG3izuy/GTxdzGN1gkh4e6UwTcwsZC6AL3B3Q7H2CtM4PiF6MHsii0RfAYqKEfAOdUx7TQkRuztAWwKI0Cca+U2EfW0O2ZCsK56MpNvf8oAPMt1SUL57+Nw3Tv+jl/qV6JFkaEd3f6pT50xTibN9/AHTlFX3Ca8jZOQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5887.apcprd03.prod.outlook.com (2603:1096:4:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26; Fri, 1 Dec
 2023 01:46:17 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%6]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 01:46:17 +0000
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
Thread-Index: AQHaHrPjdunoffcOCEGmErF8vNrJIrCTsvAA
Date:   Fri, 1 Dec 2023 01:46:17 +0000
Message-ID: <8fff59b5567449d8201dd1138c8fa9218a545c46.camel@mediatek.com>
References: <20231124085346.26602-1-mac.shen@mediatek.com>
In-Reply-To: <20231124085346.26602-1-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5887:EE_
x-ms-office365-filtering-correlation-id: ef20a5d1-4ed5-4584-f421-08dbf20f4f59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sVyoejX7exA/mmoo0KLjRnn6fB/ZvQ0uAzyUCHPcA2RZRSyDWCDzOHj1pR0F+OydisrL+FoWmcgUGcKA3Wc2xAoOCNSH59qm6puNC2lMkGC7DjX2wxAQJklpfYekwN7MR8uP0TJKNMd0tjSlrO4q32yBWqt0KAtbQlDR/SVoQmauMTVvy4fzK7zZTQLxGgqgDSU4+R7UStiuZ9MA3GpJy/lcFnVmNUrSrTygmjXo3jtg68ZBNhNfHGBU4C2B3Sqy+DKJKWybHj5+6OuoYn+NvkXVnZLqct0KS8/+UnAXzy85OD9N20AhtQCqn/jeljM2EGdkgXO0ykzuX5hvyj8eyA2+IQM+eys0+RgLNyVl/FyYqfpIWqWUBuJcsJKp6YOGIh0WCEP74ZwiUZAtyleEX0CUsEFk2FE3sKameRWr83iQdaPEbTXmBIWLhGEMObFHPCZFknv8Wx8XmgGcZoFCHu5XgS9CMgMo1hfpSZqsXKIl9GvUvLfYe+fPAaK/gpB0jkTb4Euf/0lxdlHf8RhjrDOfJDSYGhyidZ5boqBEN4/4Kvu8F/7Fgbt1pSz6xcZBN/GWPzTvQQNSOOg8ThksxHpyaoOoB+8XOxv3Vk8jEheABnI9JRRyuo6Ub56fosAfSRyS6pw3S5KxkMvHokMwxYVg9tLBZoDt1tnE0+liQB8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(110136005)(8676002)(4326008)(8936002)(478600001)(6486002)(122000001)(38100700002)(107886003)(6506007)(26005)(2616005)(83380400001)(316002)(54906003)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(71200400001)(6512007)(38070700009)(5660300002)(7416002)(4001150100001)(86362001)(2906002)(36756003)(85182001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEtqZHFxWHpaVS9malNpcnpDL3ZSVUNBSmZSNlZRUlZUYUNXeGt1Yys0NkRO?=
 =?utf-8?B?NHpVV015aXF4VEpqVlhEaU9DRmx5Vkl5dzdlby9IQm85di8yQjlsSFR2dkJq?=
 =?utf-8?B?ZjZ1WVhIWXRxRS80bGkrY2dHL3pRWDQwamZFWlZMQWt0SFI4cm1ZaEpVRU1k?=
 =?utf-8?B?Si90eWE0ME5FTFhhVGo4RVZ5Ri95MzZKQlFtTVdzeXRwdnk4TWJvai84RS9Q?=
 =?utf-8?B?dmpCMFMzMzlGUGtucUdiWjQ3UytWbksvYzN1aTl2ZGpoNmZhQy9tRTNGbk9T?=
 =?utf-8?B?WGZSbEo0YSt0WkJ1UUNwSjJ4cHlyV05WUmFiOG5jYlcyVlk1T2VWbVZsMnp4?=
 =?utf-8?B?YWl1ZUJUS3NyYnFtS0VwYjdwZU1PeXpmWXROaUkyQTNvZ2M4dU9yODE3UW1O?=
 =?utf-8?B?UlhvcGtuZG5KQ2hYemwzRmZpY3NkU0traGFFcjRBQzNySytjL3ZjeUlSZlFU?=
 =?utf-8?B?aGRWUkw4UExGbldvbE5KTkpjSlY1NEZ1MGNyMk1TTXdscVZPRjNRSDUwbGwr?=
 =?utf-8?B?TThCVVhDQmFCRk54cEZyMzN3aGs5Y3BqbVBVVENJRGxKVTlGbThOcHU2a2ha?=
 =?utf-8?B?UlFYaWN6dnpzejJvenR5SFhqbXc0eG5ybGJZMDRjVmZQelN4L2FZdzRmYm1z?=
 =?utf-8?B?c1hXODMxRkNCU09uRnR2M2lhTm81Q3BHUExlSlMwa3VlSWJKdzlyQ0ZuYWo5?=
 =?utf-8?B?OFc4UGYrc1pxL3F0b3o1T0hxY003L1BuaDNKSVliSVhQZlZhZXVhMzd6WFh6?=
 =?utf-8?B?Y0dERFVzOHJvNmRmTHhaYk52dVU0K056VnlmMDBrRDFMTmpnejJpSjhwSERF?=
 =?utf-8?B?QTN2TmE5Nklva1NnL2szbW85NGJLdGhHRzJMQmZsMjlWUFdURlJwcWltdkt0?=
 =?utf-8?B?djN6NW1XV2pBQlgvZlMvc21VUHhDWUJ4RXZOOHVyTkJnQ01Yb0lWZk9VSGVL?=
 =?utf-8?B?aTVJelZ1Z25Ld3VlRk1tTkpUWlVhMmhKdVc5bHBiMk1zN1ZFZUJGSHJRb0pl?=
 =?utf-8?B?RUNuSmEwZlpxNjJRaEpuUFZrSmpiSkg1a1NJTFM0aTZMVjZRR3FYNjRUdXMv?=
 =?utf-8?B?UzVxWUcrVVRQUzVnRGluL3k5TTRkemZmWVlyY2NvNXJ4WC9JUWJ5WFh2UzBC?=
 =?utf-8?B?RFF5OENqaVdxdUVRT1ZIbTNSa05IenFCZXIxRFpSYjFKazl5ZW1FOURsMDNp?=
 =?utf-8?B?UWQ0RDM1Mzk0TnE3M1lEbWQ1aDRmcThtV3l2U09heTM3Ukl6Mm83b2lTaktT?=
 =?utf-8?B?aWxJa0pKMmFJYzM3VVpJYk5EN3YrYzBTMWRNMEZpd3hwci9VYm5pNWZKVDVR?=
 =?utf-8?B?MktNS0d3Y0pORHc3LzJ4NThEVjdiNXhoMnkvbXZ5cytpekVSNURpK3Z5UjlR?=
 =?utf-8?B?R3pjTWU2bmUxOUdUSTZyUmpoRlpOcDlaaTJ3WXpGS1kwaDBMVlRmUE4vSEZS?=
 =?utf-8?B?QVFLTmhtQVdjem5UM0hsSkVwWDFtOUQvdG41N2VQU29lSU9oOTBvQVp3M2or?=
 =?utf-8?B?ODVZY2R2dXM4bFI3NE5oWllFSE5WeWN0MFIyQ2JIbC83QXVUMGNiUllLYXIx?=
 =?utf-8?B?VWt1c2RrWVZzUGllbnEwa1owbzRlT3RWMWdyaTRmMDBjNVl2dVNPWmZWWWRq?=
 =?utf-8?B?N2xPdmdObStsR0FaMHQvaExMNmNBOUNDR253dWZvK2wvTnk4eDZleTVCeEt0?=
 =?utf-8?B?RmZrQnM5QzNGNmplZHYrSWFsWHo4MXFIcmxZZkwwUGwzSCt0WXdmbG5GU2dm?=
 =?utf-8?B?THR1MjJES2Rldi9lSys1Mnl4b1JYelI5ejhvMU04ZmVzbm5CaW5lc2lYZHVK?=
 =?utf-8?B?VFRTYjlua0RqbndrT2t4bE9xbWhRS1YrMXlxZEFlcE9GeEIxOVQ5emxYUms4?=
 =?utf-8?B?ekZmS3NHdktVWENuRkx2NUpGSlJsdWNHTzRCL3lZdE9kNWxSZlh0WEQzVHRT?=
 =?utf-8?B?cTVnMUszQzNuZ3kwclpQdHJVcW5lVTlmTjBaWVZWODJ6SDFiU0doRGdqbTAv?=
 =?utf-8?B?T1pEYVI1ZUo3UEwzTytvVmY3dkpXV0lZTWZKTWpOT1ZOY2FCVy92MnJwdlYy?=
 =?utf-8?B?aE8wSU5ZV1N6N2VNN3ZhdUR0c0lSZVJWSU1rZmc0ZU5aT2JvYXhuMy9WUXcz?=
 =?utf-8?Q?r7g6r6s9ng9eQKD1w/BpJUfzv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57401A7C1911BC4DAFE61448665A4BB9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef20a5d1-4ed5-4584-f421-08dbf20f4f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 01:46:17.2170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esmpEoCUKPOdNbi41dwvtVTuq3RrEadYREkNT4J3JlfDFAP4uSrZSWniyiVAqM4bDrqWzbDAKNLkHTFHkppRbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5887
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.555400-8.000000
X-TMASE-MatchedRID: +c13yJDs903PaPH51LTU5Ca1MaKuob8PC/ExpXrHizxcKZwALwMGs8uj
        Rkt05a7cDhHi8Puyjunwo358o3n9Lcd/lQ4y1YeUHcQQBuf4ZFsdno82+C/ZxDUsHjosUACSuiV
        mRyWjcdkcVMb6dLIlmpGTpe1iiCJq0u+wqOGzSV0PXo4gvwUD3foA9r2LThYYKrauXd3MZDVI+p
        SomlIJG4kpcGa/pRim8a//wcFckLfjlAhHCn2799kW9V9UkgzJ
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.555400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: FC95A61E3B6530FCA5257EF4C214B17C9CDA8E3FB65D9E59EB85B1D4F2D328752000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hYzoNCg0KT24gRnJpLCAyMDIzLTExLTI0IGF0IDE2OjUzICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQWRkIHRlZSBjbGllbnQgYXBwbGljYXRpb24sIEhEQ1AgMS54IGFuZCAyLnggYXV0
aGVudGljYXRpb24gZm9yDQo+IERpc3BsYXlQb3J0DQo+IHRvIHN1cHBvcnQgdGhlIEhEQ1AgZmVh
dHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IG1hYy5zaGVuIDxtYWMuc2hlbkBtZWRpYXRlay5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAg
fCAgICA3ICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvY2EvdGNpLmggICAgICAgICB8
ICAxNDMgKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvY2EvdGxEUEhkY3BDTUQuaCB8
ICAgMzYgKw0KDQpVc2UgbG93ZXIgY2FzZSBmb3IgZmlsZSBuYW1lLg0KDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvY2EvdGxjRHBIZGNwLmMgICB8ICA2MzggKysrKysrKysrKysrKw0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL2NhL3RsY0RwSGRjcC5oICAgfCAgMzA1ICsrKysrKysN
Cg0KV2h5IG5lZWQgYSBjYSBmb2xkZXI/DQoNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHAuYyAgICAgICAgIHwgIDE1OSArKystDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwLmggICAgICAgICB8ICAgMTcgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcF9oZGNwLmggICAgfCAgMTU0ICsrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHBfaGRjcDF4LmMgIHwgIDY0NiArKysrKysrKysrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RwX2hkY3AxeC5oICB8ICAgNTUgKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBfaGRjcDIuYyAgIHwgMTAwOA0KPiArKysrKysrKysrKysrKysrKysrKysN
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfaGRjcDIuaCAgIHwgICA3NSArKw0K
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcuaCAgICAgfCAgICA2ICstDQo+
ICAxMyBmaWxlcyBjaGFuZ2VkLCAzMjMzIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9jYS90Y2kuaA0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9jYS90bERQSGRj
cENNRC5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL2Nh
L3RsY0RwSGRjcC5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL2NhL3RsY0RwSGRjcC5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcC5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcF9oZGNwLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RwX2hkY3AxeC5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9oZGNwMXguaA0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfaGRjcDIuYw0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfaGRjcDIuaA0KPiANCg0K
VGhpcyBpcyBsYXJnZSBwYXRjaCwgc28gSSB3b3VsZCBsaWtlIHlvdSB0byBzZXBhcmF0ZSB0aGlz
IHBhdGNoLiBNYXliZSANCmNhLCBoZGNwMSwgYW5kIGhkY3AyLg0KDQpSZWdhcmRzLA0KQ0sNCg==
