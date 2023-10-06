Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234767BB2BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjJFHzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjJFHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:55:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121FE9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 00:55:31 -0700 (PDT)
X-UUID: b57f4fa0641d11eea33bb35ae8d461a2-20231006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8TD1ndJJK+wfhg7R3S8cGRUx+XSp5cMvTmabnJkoozY=;
        b=YfCTzMrHD9xtbjyBO3JKLjENPaWMipWUXM1fI0WMmR9ZeGnaMEmBcYC+cQQ6YSeTN1fa4lUyW/oWzHSXKMkw7n9LIOk8hcHQHorzkrXfQwom5EuOiRPP/fiFl++Ub/wRnLaIXs/yzmUnPl8wAomRUiseKB2BNgr/k02W6dCAuoA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:b8b44c93-4011-4a39-a6f7-12a4dea5a70a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:dca2d7c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b57f4fa0641d11eea33bb35ae8d461a2-20231006
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1755831846; Fri, 06 Oct 2023 15:55:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Oct 2023 15:55:24 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Oct 2023 15:55:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoOKi6wmCNS5lW3VwqZGqBTl2fqUJcN79R3x6QPNo+f6bCkVg0hAvNl/6WUrJR6Ioq4fDxZFMpTNZP9l2S1rpUZVVssVmIJmBARUUy0t3yjPyDVvhEuBJ+Xy3x485S13Jdak2sNcBmOgoplTeYThM1HiQj9V0FZhboufYpNxPF92jMHBsdRDEWzFcpbbElmJmlCvHNaeT9JNcNpl2R0xTxqZ8SRtEicgA0Tgy6+MmTz8P03ipV5ul9q0RCtGyXpfaMFkZB3Y/L5OA5P1hq8P0oK+iRDczZ51faIM8+mzEwC7qMbbBmDmQ5CNoqijplsgIHerZ69xvAi14LnGhMp3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TD1ndJJK+wfhg7R3S8cGRUx+XSp5cMvTmabnJkoozY=;
 b=knjk4WDVuVKTcwajnK4AS5hK+QGXXj7YF0tdL/P0mAqtGwgHL1BsfkZoWa56dqoalEDNT+XUSMosjUl9ynzAFsi5Gpy9jhv0BS4ipcqonzV2ggCt+NhtU/IpVuNgGs5ofMQRoFvfhWvt6UZxzt/48PjqnWQik9qYs95m3nx71hsHEX1jx3t/Y30p/F3k21ih1Re/gscPpoJW7kGh+TQkjLqeouhXwkvMy+r9zjLDmUS19noGqDRS51nFtUayXKw5WJ1wnLh2gNTl9t7kxQPzpFydyOobMkYGera2F+WZbmJDTuNO228OJXEY64wFPkXsIrXlgbZhPN8bGhfgF58r8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TD1ndJJK+wfhg7R3S8cGRUx+XSp5cMvTmabnJkoozY=;
 b=AePHvIpuJ5i0G1tl09cWOOrZERTIUU+TjgDnB2chD3pIOXyZwimMNgKKKsOMvGrpfveWtHcZ73PoJOkiyCQV83Y4EJ9cdYEItSKPOSKWqsNn/1A2iL/Wr9bp/icEOKw1hBVUxUy3xc5kfWeBzrNNmAPrvuUHxKOOW5QkN9wdabE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8165.apcprd03.prod.outlook.com (2603:1096:400:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Fri, 6 Oct
 2023 07:55:22 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6792.026; Fri, 6 Oct 2023
 07:55:22 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v11 6/9] drm/mediatek: dpi: Support dynamic connector
 selection
Thread-Topic: [PATCH v11 6/9] drm/mediatek: dpi: Support dynamic connector
 selection
Thread-Index: AQHZ9mw8CbjtUCJo+EWGHZVVzwgL3bA8aBCA
Date:   Fri, 6 Oct 2023 07:55:22 +0000
Message-ID: <e71b49166b1826c668b580e68a496906ae69c6ae.camel@mediatek.com>
References: <20231004024013.18956-1-jason-jh.lin@mediatek.com>
         <20231004024013.18956-7-jason-jh.lin@mediatek.com>
In-Reply-To: <20231004024013.18956-7-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8165:EE_
x-ms-office365-filtering-correlation-id: 148b84eb-ccaf-4d19-73d8-08dbc64197ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9p4Ngp9rSWiutNfIjqkrr7qOLffXNrKS82lQ8L8S7gsHsOaxuLR0n2tug2z2JalRoFFWWAK4VCcvPYVxUds/0H4VZIgOOodY+ItLdgKAh2D5CFGZ1eOhRYyMK7uU1WsmKD1H/CGkdNQDMDKGJ78z/gIZDv9weOUYAH6u6IT1VIWUpq/TMX+47vGI5sg6TfWt1IjwsvKDiYF9sWcO29YXEsMMiVkv1Jf/yeXgAN1P7nX0rq4qvM56p2sDkZ1ScgZmTzcuE/OOIaDfuhSK3sSFQDp9Nzgsvl7z5D4RrwAl7Rkyq3fxPbjZi2oXLpsTxFJnPBrxjrlZZkVcRjebaFRtAAjAOzxn7kIK80JNoqxLHQfTIeTQKp0c8j6qJFMFDj4f2AVemBQYBRfZjjCwmuAyxH9s2AGmZLQ8liPZKOs4Ky0U53hhboohjlWMe6/nb5lc1jPFdpEjlL5OeS0nYFKrvcPrDt8Bw4dQgBARhOqBT29CO+oVLgmbURrzELS1Aiw/OR4F9cBJzCD/peFZpRZzM5q5KMzy3zcXTxPMpvSJyyVpBRdDQgo8DQR9rApnCyxjKZHRRkXKvTnlMvgY62T54G4dHbrcKYWyhMc203WwBj4kvLPjn9AQAk/e9MPrVTKf5/MPwUinMGGZfMdm1vlldq04f6L9PyKZSVCxTeM6bIU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(54906003)(64756008)(66946007)(5660300002)(76116006)(2616005)(6486002)(41300700001)(316002)(66446008)(66476007)(478600001)(66556008)(8676002)(2906002)(71200400001)(110136005)(8936002)(4326008)(6506007)(6512007)(26005)(38100700002)(85182001)(36756003)(86362001)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dExTUm1tR0krYjRIdTM2bHFvSllLT3FNcUw2b2ZwN21jTldEWnNieUFGc2Zx?=
 =?utf-8?B?Tmtwd3EwMUhxTzcybnNnWDJTVmVKOTlPY3VzVVlrK2dTN2xxNUVMVTEvcTVQ?=
 =?utf-8?B?TXhqUlFHSU8rUUJhZC83aHZNUDdGTi9ML2swSHhNRWJ3SjhJK21IbDVGaUxX?=
 =?utf-8?B?LzBEMmNIbXhVNFhuRGhWelgxVHVYZzFtUE1JYmo2QTJIMktLTGFCQ0hha1Ay?=
 =?utf-8?B?ekRmcnBKYnRad0hZNERRbEN3OFdYZjZNNS8waXI2SzVKTnhZd0RqUnEwN0NU?=
 =?utf-8?B?R2hueHVIRkdJVmt2WHhxR1d6UWR4VUkzNjcvdSs2K3JYckE3bTMza3had0ZS?=
 =?utf-8?B?bmt5am1HUDBJQTdyUlNlbWFnditjdXN5R0t1allQY2dJTlBXL2VsMmJxb0s4?=
 =?utf-8?B?WWdCS2d4bGtXeUpGbnQvVjZiVm5FY2tBRVJNWm4yNHlNK2pOcEx4aEJuMDlM?=
 =?utf-8?B?eldpYmlBdndtUkk1K1RtRkJjZkZmMU5ZVDJkY2IzTFBaN1YxZU9uekhYTzgr?=
 =?utf-8?B?UHdQM1A1TUhBd2lNRFFybDFBVkZXMTJBbExYQTNoK0dBRzJFd05uUlVNSDlU?=
 =?utf-8?B?MHlhaFNDdkhUVTRMZkZ1RWVUdEJWa25yZHlXL1F2TFRHbEwvSHhyOUhwcmFr?=
 =?utf-8?B?aDhZWGxtRGZ3aENadzErKytNNzJIM3UwNE91bjhmTWxCeGI3SGE3WXkwZ2lO?=
 =?utf-8?B?ekxHbHljN2F0N0dsVnZtUnZDY0RkaURVdnh2b3kyMVNhSXdXbm5wLzkzUW5n?=
 =?utf-8?B?dU5zYmFOaS9IenFpNDRLZXRYY2hXanc3SmRTbmswTUZBd3BKZXdpbFVLM0ox?=
 =?utf-8?B?QTN1VS9TSzIxc3ZaenVIamRuekdkQm1xbitBTVQvYnlhY29HajNEajg4Wkw5?=
 =?utf-8?B?S1JBdUtFcDRxTEpTRGs3VGpUR0FMQnhQQmxwcy90Q1I4UlJwcnp3Mnc4VmhX?=
 =?utf-8?B?VlUwZGFRSFNTSTg2MVpYUllXTWlJa3N2S2VXNmUxTHNGOHNUNVZnTUMvMXFs?=
 =?utf-8?B?NkxrdDUzUVMra0MybzBpYm0yNzdHT0NZTE1TQm9wdFo3eWZZYkg3TVNqdGNH?=
 =?utf-8?B?b3ZGOFpJN0FaK3k1eHhSK2pNejNOMnhFcUxUYUMwTGdURGw1ckJvYzBLM0tu?=
 =?utf-8?B?bXdQM0dUTVRLbitMcGNKSFA2YVZHS09MdTFHNHlDbkJ0azdYZTd5TTF0SWZa?=
 =?utf-8?B?NmtBRk8wVXpONlRSZ3Z0ZlVPd0JJTmh5QXNOVXNLeHRYRXp4UXRBc2ZDV2t6?=
 =?utf-8?B?RlloaTZTUGl4UTl3MXJVUjhxSmwwdWYvTHBmb3hCaVFYTXQ2ejVuSDk2dlRH?=
 =?utf-8?B?SkpYTE92Q0prZUlBQ2IvNTNaK2IrQnIyTXlhK0FLNHZUNkVNZ3FGUFRHUnVL?=
 =?utf-8?B?YWxqYmZpdXROdEk5bWRaYXN3bkZkNWRGT1RzWlF4SjJMdk5DeVEweWxKRFor?=
 =?utf-8?B?LzZvQjg4MFo1VlpPUkIzMkNUNGo4bmJRLzBHQ3BNbllKbER2RDl6Q3N6TklU?=
 =?utf-8?B?alBnUFk1QzYyZmJvRHU1VFFFclZaYlE4bEFoNGkzdmhTWTRhU0tQWEtLMGdS?=
 =?utf-8?B?WUpFSk9VSUpISE5uTjJ3UmFsQ0NaV04wcVIwRFM0YWQ5SkJITmJBUFc3QVJY?=
 =?utf-8?B?Q2FoZ0lZd3N4UmQ4bUcyM1k1MFRxRjV1UFd0dFZYVUh2bHViMk1wNldNVHJU?=
 =?utf-8?B?RlhkREpxMUh4TW5qaFpvL2V5dEJWL2lxcE9IcGtsK2dBb253cC9OM05lcGVJ?=
 =?utf-8?B?SG1BWkNrVjg1eFF1Z3FMcXFMWXZPcFVXTkcwTXBNLzJYRkUrQThpWW1mVVNJ?=
 =?utf-8?B?YlpmY3cranBhS2FMQlM5eUlOUXdEMHVtd0FNWDZUUzYzNDJ0dzVST3FHdVZM?=
 =?utf-8?B?dlRvU0ljcUkrb2lvTWdEb05Ob0x1K1hrdUFDRFF5WWMxK1dYanR4cXkzMmha?=
 =?utf-8?B?aU4rNVM0cGFQQ1hZWkc4M1FiWTJ2dk54MndEUGsvMVp0d044cnoybzdLa1V6?=
 =?utf-8?B?NXlhL1NCTEhaSFF1eVl3MnM3YmtmcW4vSDl3QTE5aWNlTW5kTk1VQ2llTzVH?=
 =?utf-8?B?MXV2VnMwK1BBVk1Cbmtmb3BLNjhIb0JrcVhPQTZ1YzJTU2JmMDUvV3hpZ3ZK?=
 =?utf-8?Q?rH1pzjpxfi0/7qzD2I3TN50+N?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <462298B69AFDAE4BADE25FA58557D794@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148b84eb-ccaf-4d19-73d8-08dbc64197ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 07:55:22.2466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veIPUbWiK42vJ/lgMNqkIt8eV7tWEVbOYyvLm6iprD9tyD4JaTVtvrRzGSoZTPIsjhv1Pic2lBEJmAFEjRz6qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8165
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.171600-8.000000
X-TMASE-MatchedRID: fgYTp5XatxYOwH4pD14DsPHkpkyUphL9MZm0+sEE9mv/evmlVf9xZqUo
        SyVrNB2cGQdEeHBaW03ijpjet3oGSG5/NyTKlG69HPYwOJi6PLn0O7M3lSnTW5soi2XrUn/J+ZL
        5o+vRV7yhMIDkR/KfwI2j49Ftap9ExlblqLlYqXKFX2I1+SHejbtLCoqHhl2s87XdOKw0PUMFqG
        h7wCxDrU+GDrKoNRraebMycoUNg3FY8w6zH8R/NcsyDBS3rYb3IQpgSZ/9BlJa/1URsdCEdvlKO
        L16vqpsyIs3grCOsANC1Jo8i9w2UnPmli6osFKp
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.171600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 227C16F3F633E75F8C3E8668082D2F798E50E9E587E97633623AFF73F2CE660B2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBXZWQsIDIwMjMtMTAtMDQgYXQgMTA6NDAgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIGltcGxlbWVudGF0aW9uIG9mIG10a19kcGlfZW5jb2Rlcl9pbmRl
eCB0byBtdGtfZGRwX2NvbXBfZnVuYw0KPiB0byBtYWtlIG10a19kcGkgc3VwcG9ydCBkeW5hbWlj
IGNvbm5lY3RvciBzZWxlY3Rpb24uDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0
ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxp
bkBtZWRpYXRlay5jb20+DQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdu
byA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgIHwgMSArDQo+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jICAgICAgICAgIHwgOSArKysrKysrKysN
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgfCAxICsNCj4g
IDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBpbmRleCAyMjU0MDM4NTE5ZTEuLjVmMDcwMzc2
NzBlOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Ry
di5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBA
QCAtNDQsNiArNDQsNyBAQCB2b2lkIG10a19kaXRoZXJfc2V0X2NvbW1vbih2b2lkIF9faW9tZW0g
KnJlZ3MsDQo+IHN0cnVjdCBjbWRxX2NsaWVudF9yZWcgKmNtZHFfcmVnLA0KPiAgDQo+ICB2b2lk
IG10a19kcGlfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX2RwaV9zdG9w
KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICt1bnNpZ25lZCBpbnQgbXRrX2RwaV9lbmNvZGVyX2lu
ZGV4KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICANCj4gIHZvaWQgbXRrX2RzaV9kZHBfc3RhcnQo
c3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX2RzaV9kZHBfc3RvcChzdHJ1Y3QgZGV2
aWNlICpkZXYpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cGkuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gaW5kZXggMmY5
MzFlNGUyYjYwLi40ZTNkOWY3YjRkOGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cGkuYw0KPiBAQCAtNzgxLDYgKzc4MSwxNSBAQCB2b2lkIG10a19kcGlfc3RvcChzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ICAJbXRrX2RwaV9wb3dlcl9vZmYoZHBpKTsNCj4gIH0NCj4gIA0KPiArdW5z
aWduZWQgaW50IG10a19kcGlfZW5jb2Rlcl9pbmRleChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7
DQo+ICsJc3RydWN0IG10a19kcGkgKmRwaSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArCXVu
c2lnbmVkIGludCBlbmNvZGVyX2luZGV4ID0gZHJtX2VuY29kZXJfaW5kZXgoJmRwaS0+ZW5jb2Rl
cik7DQo+ICsNCj4gKwlkZXZfZGJnKGRldiwgImVuY29kZXIgaW5kZXg6JWRcbiIsIGVuY29kZXJf
aW5kZXgpOw0KPiArCXJldHVybiBlbmNvZGVyX2luZGV4Ow0KPiArfQ0KPiArDQo+ICBzdGF0aWMg
aW50IG10a19kcGlfYmluZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UgKm1hc3Rl
ciwNCj4gdm9pZCAqZGF0YSkNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuYw0KPiBpbmRleCAwMmYwYWRhMzc1NGIuLjYwMTc1NTkyNTUyMCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IEBAIC0zMDQs
NiArMzA0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgZGRwX2Rp
dGhlcg0KPiA9IHsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRk
cF9kcGkgPSB7DQo+ICAJLnN0YXJ0ID0gbXRrX2RwaV9zdGFydCwNCj4gIAkuc3RvcCA9IG10a19k
cGlfc3RvcCwNCj4gKwkuZW5jb2Rlcl9pbmRleCA9IG10a19kcGlfZW5jb2Rlcl9pbmRleCwNCj4g
IH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRkcF9k
c2MgPSB7DQo=
