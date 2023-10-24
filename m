Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D947D460A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjJXDgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjJXDgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:36:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5846A83;
        Mon, 23 Oct 2023 20:36:08 -0700 (PDT)
X-UUID: 7362f2a2721e11ee8051498923ad61e6-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EnW+EhUE3UrHqSoDe6uyuxJ/3/ZMLvFw0wxh+6XL554=;
        b=iqKGB2NeOAy1u00xuoTvyIs7J6HJ2IzTp1sNClI/SJTF2tT7V+cwJIFBHDsMfbfKkWvGP2HAEAKcu3pQ0yqmKzfQcuL/yJSRp+DO+twB0v33KeoCqAZ2iAjSLddkwirKUxlDLi80bOWVjK5vH71sDnJRzntEqgDYcqKiaEgt1fE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:cb280d2e-fcb2-4d4d-96bf-cca04048d62e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:55e83cd7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7362f2a2721e11ee8051498923ad61e6-20231024
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 91759415; Tue, 24 Oct 2023 11:36:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 11:35:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 11:35:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyzlGSh6jyinG43/ivmmgGQgShBq9NwqynrvM5eBgZrbVBVXGtmNfOD7DvFZ2a1H65amFA5fxJ0GmGnxI+2bIyAdRrBJuiV3hgw6ajxSF8IJNajWCzA49XumgltQQsaoHp/183gRUd4RCeP6ZRutq3VfmV50OCq+o8oHrs0arQODcu2G/9rtLODqSQ1W7v4kJU/PngPWknTlWIHXqwe0UZfXVBOzEE/dOQfgXj/keIwCadufr4qNyxXl+dBys7yCAAUlKGk8oTwbkRSiAOBuHfqJBYppP5s2W7tkM263Xt/6dKvilCJVn2+GAdICXgkVAuzRNpe7zWyBsGmPz5u5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnW+EhUE3UrHqSoDe6uyuxJ/3/ZMLvFw0wxh+6XL554=;
 b=FJVrhPYiS+47XkJ4U+AtKUdALErW2f30SwvZblF6bKfiHLQpNMYe60vTmsBgPkekHMW7GCSD4691/a6Z+apEosXFfhUunFnr8TNzjqCGed7RQuuatZ7EPZWokjda3G6fLtRDfHEvxFLC5vN1jjpT0DSk0YNxzrsb2LXhp3HIatAO8b0NaVIw6IOmI6ZqaMbU5aLxEymgJ4vrmfjNkeHEST8R61JwEDf87rYKVRiDAz4ui0/B/CHdOfRglSvpxlj0Dj7VcKzqcGz/BlTefldsk3LhycEYIzNIodHpEpdJFmX14kGtANArSqA5k9/170JvXFwVQIdn6jlh/+wUqYyM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnW+EhUE3UrHqSoDe6uyuxJ/3/ZMLvFw0wxh+6XL554=;
 b=LSlMH5Iq9+vWYakXGdWmlJmbiAtY1epWwSU4N6tMGHcEmZ9CdLkIMMtUo4a3HDt+/7nwgF5Iej3tnZvQkrV1WQlR+Z8oO33Ahz7hhPQ+KD7JrIwC84t7DpqJebuAHDQc2zyymTAWr2G21b4hvZoeBKPuvXfa2ZEzAJizap3wZ6o=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 03:35:56 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3%4]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 03:35:56 +0000
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
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 04/11] drm/mediatek: Add secure identify flag and
 funcution to mtk_drm_plane
Thread-Topic: [PATCH v2 04/11] drm/mediatek: Add secure identify flag and
 funcution to mtk_drm_plane
Thread-Index: AQHaBWv/MmZJMlN5SkaqVnsiHA8dYrBYS4uA
Date:   Tue, 24 Oct 2023 03:35:56 +0000
Message-ID: <b639b18e073e0eb38c439410c753f61486762a10.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-5-jason-jh.lin@mediatek.com>
In-Reply-To: <20231023044549.21412-5-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6896:EE_
x-ms-office365-filtering-correlation-id: c3b09231-f6a2-40a4-d2c6-08dbd4425527
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/5QIuUgVgK2cB2Ygk3yaUQRXj05Qdh4FqB9I7jz4WrpMou6qzU4z8Z/++Kmaw7FqkR/9Nw/UkTTdFzOMtsAA8u0w/CBuq3rVNnRDX4DUFWfqtunH/S3uuMn64nbn9TRsQ1mN7IbPBw9pV3lpG6iZ5HXAsacTfK7joDnS2dc7/MbYztaECuDrj06jxJQ751tfQ6NNVH6y+e8dSeimSlovv9ZdOb3f4Xdxc7Jm67ZlIU6ro4IkMPHvJ84jJhrq3QPJxKp2uhif8vPxGcBbMh/CyVmrSiVgyybOA3v1VZdLv+ZhxgiKAStMqCdkMjkE4jaY7ASXOUraagB0XqHXD3RI1/qy1uUTC5EXzdm/MzPIocT4rQUcKk5Ydh52whQiDrSnl4mFr15z/lRZCzW7nYu+xqcpVEiICZlR1qedkQc4Zj0gICxfQad1K13ODfteM/7cM9qIPUiWmCOV0OkDsCBnJvJCqUSqt+cdX8PsXEhKZCkrqE2d1ciRcUGSaCe01XjbTEEXHEMBsWa4qYgs1oT3KSxR7LgoMJAFuLHf4GSpBnQaEZ1B9bW6jZ/qJu6uo1BXllD3QQd2JufPbglyx5IMFlhZzK7MlnFtFqv71CU3xPx+vI2+Hhts7Ix0gmg1+kRuJFPjQALbjevFCc1ekFCD4Y8XztGq7yukcxfzExYQfU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(2906002)(38100700002)(54906003)(122000001)(66476007)(76116006)(316002)(66946007)(66556008)(66446008)(71200400001)(110136005)(478600001)(2616005)(6506007)(6512007)(6486002)(64756008)(4326008)(41300700001)(36756003)(5660300002)(7416002)(8676002)(85182001)(8936002)(26005)(38070700009)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlRSaW9LVU5qQ1l0K09aakhFUHNvSkdKaE16OTBIdU5IN0NPMjF0WGdFZ21w?=
 =?utf-8?B?NmV1dkpoeEJGS3c5cGF3N1picmk0azZwUk03bUo0OGQ3WGVjdHBXcmVMTmk0?=
 =?utf-8?B?UmY1VmV3SmNqS2pWdXFqM1hsbGJ3Mnp2NEdlUjNrdlBxekZSV3BFUS8wTWlH?=
 =?utf-8?B?YVI3QUFwTVBNdS9kU29nckx4aWpzTkk0YXZGblg2RXN5Q1hBL0x3TTJLMUlE?=
 =?utf-8?B?NENlY3cyTXBDck16M2piL3RDa2JjVStFdmxuWTg3dk9TVSthdUxrL1V6NFB5?=
 =?utf-8?B?TUw5blBjMHdyRnBCc29JVzFBMHIzNXFTL3UrMWlFVGtNR2NyZmwyVUJyenpI?=
 =?utf-8?B?WEZvbnJPY3Rub0tXRGk0K1ZyUnBhTkpHZndLcjVUSXFTTHR6cENzT0IyODhV?=
 =?utf-8?B?cUlUZEY3YURFL3VXOVRoaThabFFLU0JINFRmZjVGdWtSTU91RUdUSDBpNUM3?=
 =?utf-8?B?S04vTkpvalpnUkVPWkQrS1czOVFSMjY5TUNoanRtK2NiNWxyTU1WSmgzNEpJ?=
 =?utf-8?B?dTNKQXdwenlFN3BHQXdsekdqcnhRemN3ZjNZSm1JT2N5Z0ZyQ1dUMVVnbXUx?=
 =?utf-8?B?K1pjZW9SNFU2S0M2aUhuVk5YZXArVk9ZMFZucGFhZVhpVnFhcGRVVkgwdktQ?=
 =?utf-8?B?dnVoUnU0YjZlYTFtV0VscFN5dzhDU016ZHJCY1Jwb1ZvNkFCS3FFTGZORDhq?=
 =?utf-8?B?bndFMWJsZlNCWmwranhRQmRSdFhnUExzOUFud05MbVJxMlZ4RUJvaXBxb0VQ?=
 =?utf-8?B?Znc4T2hIdkhTZVpyU0tnbE5pSy9tZ0pJbEV0dW9QWGg0WnpoUW9QQ2RJQUU4?=
 =?utf-8?B?YlY2cmh5bGo0c29QVFlRbU1HNGF0QW1wU3ZGS1VIcHUrTXh0eTM2aDNsbDAv?=
 =?utf-8?B?c3hadG8ycnNRa2hsNExJNHoxWUxoOXc3b3VuR2hhM0RlZk9EUmMrb3NEbEpU?=
 =?utf-8?B?RlNOY0tHQ1psUzhqUlhFR0crMWY2eXBSVnNpcis4NkRPSWFraUgxRUd0OVI1?=
 =?utf-8?B?RVJTZGovQnRVSlNFd09kcUhaS1crRTB5OVhOcW1SRlJkS0lwTnovajRVb3lm?=
 =?utf-8?B?SVZtaDRhK0tHejBpc1VadzBoNTdvaENqWDNvNS94MkJxc3pVK2xhVzZGYlNV?=
 =?utf-8?B?WTNzb3VFdUt1MGlpQnFXNEtDOXhCTkVlcUh3cENqbW5TclBiQm1BdFVheFlr?=
 =?utf-8?B?c1NXWTdFeEd0QkNzYVNJeGxVQldSdm9IWnduOURRRnVBVmVWK3VBc1hLZDdS?=
 =?utf-8?B?MTdUdG0wNnpTQUpLMzREQ2J3T2RLK3hER3M4ZFE5UDJkS0lqU0RKd3hhSXBR?=
 =?utf-8?B?STI4cTNMMTJXOVdyMnBPL2VPdnBSM0VPYjFtSW02VUhlT04wRHhrTjA0RVpm?=
 =?utf-8?B?ZnQ3eWVwNjlzN0RiYkxmMVVvdUZnSzFTQXh6YUVrQ3N5Y1Q4TWtVNUhDUTA0?=
 =?utf-8?B?dkJhc0hHaG1CbkJtcFkrSmNPY3UybHMydFVxSEdSUGhMRURIU3VMMUJYM1pC?=
 =?utf-8?B?elh1eFZCbDVHWW1JS3RrdW1EWGRBWTk3aUp6VWJHMGpsN1Nibmc1RHZwTXpU?=
 =?utf-8?B?dUlXWE1lRUJqT1cyYWhsTVRkYUhxeDlDTGo1V0RBbDRzZ3ZHd0UrRnFSNWxl?=
 =?utf-8?B?VGNselBXQjlWYUxaMXVBOWFWRDVlZFdValNrQ0JmOWFUZDJvVzVxaTlqYitK?=
 =?utf-8?B?dnJZcVFMQk1LS1FDTWsvaFBKZ0xacy9BOGZaZitCM2JxRExFeFlqR3pZRGx2?=
 =?utf-8?B?c0NJWjNGMkNVbnpOMVhCdVZCZ2ZkbVBUVjE1RU9DWUxHd3VRbVdVbFIyalM4?=
 =?utf-8?B?b2xncFUwMUwzSUYrT1FOUWZ3Rzh0Q1BUMXdMd2VTcU5vSTZMNlZ1WCsvU0lE?=
 =?utf-8?B?MHJVeENZeU84WjlXeTlnNm5NY3BCMUNoc0tobjBFd0xHZkpKT0V2dXovS05L?=
 =?utf-8?B?R0hBSG9zTnN5WEpGQUk5NVF4RHgzb2VhQVdtNHcvejhHTTZPSzdNSWZBY3Vy?=
 =?utf-8?B?V0dBWG9wVFJFYUk5Qm1DR2JsTnAxL09lMXhyQVBpQnB3M0xQMnV3K2w3Yjl2?=
 =?utf-8?B?NytmTnlrZVNxY2tWR0J0ZGxnV3MxaEhKUkQyUWJta2cxaURDU0FNdVY4Zmx0?=
 =?utf-8?Q?dYzIWZH6aX1PM/0M+i0MFSSWz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <244C8EC97953CF4E997C50816057FCA8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b09231-f6a2-40a4-d2c6-08dbd4425527
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 03:35:56.4421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jzG80+wWICepeBWnzCc0N++xnxkyMB1TLFkR9yflVfxkk5m44AiGwg9NNVspfGfzSUUeQIDgjqqLV2W5fzd6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6896
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.922200-8.000000
X-TMASE-MatchedRID: fgYTp5Xatxb4OiVTWoD8RCa1MaKuob8PC/ExpXrHizxcKZwALwMGs5ik
        b8Hpudw4ubvf6ktW7XASqo3ZUfrHhxBAYzpZxAP8FYJUGv4DL3wcZR50t08gUZsoi2XrUn/J+ZL
        5o+vRV7yhMIDkR/KfwI2j49Ftap9EOwBXM346/+x50TuV+4cmQhK25QqUByXWA5vPgv0wct1h+e
        RSpyJ6ykrW+ws5e7ll
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.922200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 53C5848A073CAC2E612D95BDEF1555E03909EE6814ADEF9AF82A37DB9E58EDDC2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjMtMTAtMjMgYXQgMTI6NDUgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIGlzX3NlYyBmbGFnIHRvIGlkZW50aWZ5IGN1cnJlbnQgbXRrX2Ry
bV9wbGFuZSBpcyBzZWN1cmUuDQo+IEFkZCBtdGtfcGxhbmVfaXNfc2VjX2ZiKCkgdG8gY2hlY2sg
Y3VycmVudCBkcm1fZnJhbWVidWZmZXIgaXMgc2VjdXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmggfCAyICsrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fcGxhbmUuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX3BsYW5lLmgNCj4gaW5kZXggOTlhZmY3ZGEwODMxLi5mZTYwZTIwYTZlMWMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmgNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuaA0KPiBAQCAtMzMsNiAr
MzMsNyBAQCBzdHJ1Y3QgbXRrX3BsYW5lX3BlbmRpbmdfc3RhdGUgew0KPiAgCWJvb2wJCQkJYXN5
bmNfZGlydHk7DQo+ICAJYm9vbAkJCQlhc3luY19jb25maWc7DQo+ICAJZW51bSBkcm1fY29sb3Jf
ZW5jb2RpbmcJCWNvbG9yX2VuY29kaW5nOw0KPiArCWJvb2wJCQkJaXNfc2VjOw0KDQpXaGVyZSBk
byB5b3Ugc2V0IHRoaXMgZmxhZz8NCg0KUmVnYXJkcywNCkNLDQoNCj4gIH07DQo+ICANCj4gIHN0
cnVjdCBtdGtfcGxhbmVfc3RhdGUgew0KPiBAQCAtNDYsNiArNDcsNyBAQCB0b19tdGtfcGxhbmVf
c3RhdGUoc3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqc3RhdGUpDQo+ICAJcmV0dXJuIGNvbnRhaW5l
cl9vZihzdGF0ZSwgc3RydWN0IG10a19wbGFuZV9zdGF0ZSwgYmFzZSk7DQo+ICB9DQo+ICANCj4g
K2Jvb2wgbXRrX3BsYW5lX2ZiX2lzX3NlY3VyZShzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYik7
DQo+ICBpbnQgbXRrX3BsYW5lX2luaXQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgc3RydWN0IGRy
bV9wbGFuZSAqcGxhbmUsDQo+ICAJCSAgIHVuc2lnbmVkIGxvbmcgcG9zc2libGVfY3J0Y3MsIGVu
dW0gZHJtX3BsYW5lX3R5cGUNCj4gdHlwZSwNCj4gIAkJICAgdW5zaWduZWQgaW50IHN1cHBvcnRl
ZF9yb3RhdGlvbnMsIGNvbnN0IHUzMg0KPiAqZm9ybWF0cywNCg==
