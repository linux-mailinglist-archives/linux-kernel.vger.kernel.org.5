Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D1D7E0D02
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 02:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjKDBL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 21:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKDBL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 21:11:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FE4187;
        Fri,  3 Nov 2023 18:11:17 -0700 (PDT)
X-UUID: 093105067aaf11ee8051498923ad61e6-20231104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MTCL2yY/ZTi6YazhPqE0sQOgdW8O7dWEyXtRmnduYqk=;
        b=BlfgnYB9EsLuoOLCrB+IoNmkXjFUy3P427QMSzT9wIvnLoS/A1CDoc4QehUIkEuFrpS64yki7zbUvk/Fwbvs9MdLYheCUX45QLrFKPmh4QMqGQeHvcRQXaRn6xxuVQ0KwpciQ+lhnG+qExPdT6Mt+/21a5bzBwuteeNV8vD+SJg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:9e8b555d-0650-44ea-b3ae-4459c5cb18bd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:3526ff94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 093105067aaf11ee8051498923ad61e6-20231104
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 236670745; Sat, 04 Nov 2023 09:11:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 4 Nov 2023 09:11:07 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 4 Nov 2023 09:11:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB9KKrq3xz28Disw7C2HQp0h3YPsWMbT1c4IeJe58bUxlDKNUkV4No7cuxJordUJEDOfze7LPmZjhXt8ZQIwHm1i8SMRwdWV6G8snY7vm5yPxWqugNvB97WE1Tc9Ih+yc1uiqXVNuNkJ4BNv1GB22tr2bXs8WoU1VhpgCAjJwIzpLaa2gUYqbbGY9klSszMMoDe4qdPzHjijjMp66gjMdWnRD++Fdb0jJM3LP3jTpMf4CIeFYzhOPW/9a8c/pR5sIkVtwxMaPr3DQa7AZC1ddH61Dn0fbuniZkWWzqAu0nP1/2h5RphosXsb4/IFqEaEa06LESu2dUaMU0pj0VFHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTCL2yY/ZTi6YazhPqE0sQOgdW8O7dWEyXtRmnduYqk=;
 b=Ni+0CxZyIhMkutaUka5iT27CqZmlu5vgBHWkIlLPGTR2l6Ol6LE+x8M4Km64wcq3CbWs9V59Zp5DNPSii81ozaVQJOW3vbGcEihksC4ajFfXhprWNdg2Pdc3A8B9RH3iqYfiOnmpsBmqX+HXSRyi4Ex8G+eM3sjw6lTT5eysZV4Y1oCKuuxlB+mQdkRR79j1ohB6zM5bJdkvvi25y4IOnh2jytRywj/2xj0t3wrg+JpclXpS7zGk8RyfHntgna12i9HDsJ8URlVXiSi8jG2A96wIqrgHnpLMOwoNxfo6rB3caQhUJlniRwwJom5A/sNIHYlbTPyqDdBt1xStY3+V+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTCL2yY/ZTi6YazhPqE0sQOgdW8O7dWEyXtRmnduYqk=;
 b=Y3sLviq3RAnMLRQSN8CIViJfMDihMBx8pPgdyesU/VYf+YEOVdbFaLpjVXbosmnx4S/3w0eAQCDW0NcqSybDPSuinSQZ18Y9xYjgWeG5OnwyF+VXfnOqCWaOfRpotom/oJkwsBRQHJb/NMRnYd2PNaI58xYUUy/BAB9nEc1PMS8=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 JH0PR03MB8665.apcprd03.prod.outlook.com (2603:1096:990:90::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.24; Sat, 4 Nov 2023 01:11:03 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9%5]) with mapi id 15.20.6954.021; Sat, 4 Nov 2023
 01:11:02 +0000
From:   =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To:     "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     =?utf-8?B?V2lsbCBTaGl1ICjoqLHmga3nkZwp?= <Will.Shiu@mediatek.com>,
        =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] block: Check the queue limit before bio submitting
Thread-Topic: [PATCH 1/1] block: Check the queue limit before bio submitting
Thread-Index: AQHaByTnzFC4rhYmWUKg+y7lOe9n1bBkxn0AgAQOpYCAAJQggA==
Date:   Sat, 4 Nov 2023 01:11:02 +0000
Message-ID: <cf09a768d0e116bfaf01a1592a7ae95a10b4c2cf.camel@mediatek.com>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
         <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
         <ZUUd48QF/TEGFzPy@fedora>
In-Reply-To: <ZUUd48QF/TEGFzPy@fedora>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|JH0PR03MB8665:EE_
x-ms-office365-filtering-correlation-id: b2f89da9-42ec-4432-de29-08dbdcd2e9a6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r07J683/S8DFhv9sDz6K1nR69Qn5geZTFBf5yLPuOenml5PkCnSmkjRCxOs24Wu20TrgwV+xCuYXnSK/8dg+atIUBqzjmaX02nMCEr6wyP7E6WtHuE2rY8E0O8GJ7pFuHnKi/UCuWtJlttmAWcDxlhrdEeL+tJRaV+aMKRcKUEvf39try8+/zbGITp6k1blqyvac1W1mOWzci6Kcw+qzTnMgVAH3+Lk6Ly8lbLx5sLjd9wCyvQ3mXza3K0dxWnADRMKuoGxlTlsq88SV1WMp5R4Hy1dsXDQGgFWjQ25ItGzsvuOUlhkiG914tgBy/c3L8k0/yM2w+g+HD8/dtelPOBpoc+y1n0qIaFWjEv1ndTP3VaHMcNUC2Ce6VYJBjiYhKld6516xa3cOJsTX6ShMP6lXFQnbMmfSgFWmy4/DE9YQWPdM1omLHcyZAx9S6d99NLWmLtcHX1RjSYXcRJv2JkyZNZPzE4WlzDa7BDrRYhp58flwR9rHwHsJ3gHmmQ/cTfRCxbw2uYJiugVh4m1WbOjm3tILs8Ztdp2Nk0vizsrpCCJM5AD+mmD8FZ4e2G7EVCh55YjM5ZUFdRgCV5DW3pXkbLtJQar7lsuXiVwdubNQwFekpxc/2HWpIbC3t0E8F81W9Pb2CebULelpxKW+c8Q5m3CxN5Fco+vRre/fxjY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6506007)(71200400001)(2906002)(38070700009)(122000001)(86362001)(36756003)(85182001)(38100700002)(26005)(2616005)(4001150100001)(6486002)(6512007)(83380400001)(478600001)(91956017)(76116006)(6916009)(66556008)(66476007)(66446008)(66946007)(316002)(8936002)(8676002)(4326008)(64756008)(5660300002)(41300700001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWV1WGZqaW4weFVURWNYakxPSG5iTzlCTGxRZmpoMkVYemorQUJpcmlXdFky?=
 =?utf-8?B?cjNtUFpvWnRXeGUzNStaeFR5YUJYbTMrTkN6UTNhV3Ztb1h0Zk1UUmt6bXFR?=
 =?utf-8?B?Q0hUbUlad3pUV2EyamJtRXJKcmVrR0tGYUVwekxRSmw3VjRRY1ZWL2tCUlM5?=
 =?utf-8?B?U21iUXJlMy9uSFlJVEVmRGc4cHRPWCtrZlgwVlhJMUdBWVk0V2tDblBLTVNU?=
 =?utf-8?B?a2V3ME4rVXNvOGsySW9UcTNFTTlyRGZ5K25hYTFaY3NyRGhaUS8xOFhWNmQv?=
 =?utf-8?B?UitHL0p1MHg5RU9SM3NPZG1tWlZtemhSSllQZnpaMDU1dWtqbTJjNCtNMEwx?=
 =?utf-8?B?RkQ0bk53Qm9ZN2hyeFFXc0dZWkRKY1FibE4zRFB3SWFkYnZGTkpNRk1hT0sz?=
 =?utf-8?B?Z1RJM00vZlFoNnVVYmY5WERCY2pOaHNwTjBiM0JlS2JMaEEzYVo3ZDJzUlhj?=
 =?utf-8?B?cXRXZklTajhhK1BNTUZsVWtFTkU3b0N3YmYvM29LYTVsUXRGS3FDc21wRDJs?=
 =?utf-8?B?TUl1NGNRK3NWUUxzSjg4dWp1VWNSWStjQVRYNGFjcEFQK3MrRE1KQ0pCQkVR?=
 =?utf-8?B?RU5ZOVVtb0t1eHVST3VHWjkvVGxKcWhITEdBK3BYZWUzOXNaWmVQTXdCbWV6?=
 =?utf-8?B?MmF0aXA5ZlRudFlWR1hKc3FNWXhNaGpDL3U4UC9pOHVQN0FxVTNrYTB0VWE3?=
 =?utf-8?B?VGIvZFppc1JualQ0NnpwYWhvYm9OalAra1lhdEplN3o4dU9OYUg2ZUR2bW55?=
 =?utf-8?B?eC9OTFF0NHJrMTBxNnlrcHA2SzlZMHUxVDAyNmMxMnZrWjU0cFl2TXBreUp2?=
 =?utf-8?B?K2VPOUtVN3JXZGVjbWoxenJFZjF6WkphYnBMTi8yeVlOT2dmRE55WktXdVNR?=
 =?utf-8?B?SnpOUk1zRUhHTS9VMi9jUnExbC9QcmtLeDBsU1JENlFQTVNUY1J0QWdmcGd5?=
 =?utf-8?B?eUZzV0hyTHJEaC9RNUlZc0JFTEg4Tk5tc28yZnRDWkdtQTVMbUpWcThhRHVW?=
 =?utf-8?B?S0J6WE5LV3RaeWdVTVovcE1IQ05STjEyMXJtOGxJclp4OGpML0tYaHZheHJh?=
 =?utf-8?B?bDJwdTNJK05MVHU4aTUrZEg5cXpjaCtlbTR4Si9lcXVzMjhrbHlLbGZJV0JL?=
 =?utf-8?B?ZE9wMTZSUFlvUUlQckVtakdIZ2pnU0ptQWNaUDlBV1crV1Vmc0NaakJnZ3FU?=
 =?utf-8?B?dXZhRU8xTVVuQ1ZsYTAvQTVoQW9DQ1BHZmp5V0ZSdnVRcWVIdjVadnhVOU9Q?=
 =?utf-8?B?ZmwyWUdkeFFEYm4yaXB0ZDdOWFVWQUh3amZzZzR6UjBOWk5RbmV4YkR6UkRT?=
 =?utf-8?B?N3F1QmpkKzluZzhWK09KODJ2RVZHcXU2VXQya0VHUXVNekdYNHV5MndWV3ZT?=
 =?utf-8?B?YVk5bFhiUG1kY1huV2p3Si9RNnA5em04OC9WTkhMZi90aGNyblRzTTZnRDNF?=
 =?utf-8?B?RzJCeXNLeFRhSWRYKytjWEJxclFUazErSE50MEM3RkpGbkVWSVJPbUhRUERy?=
 =?utf-8?B?RUwwc1l0a2cyM3hSMTYzZ2Q2bGxsZGRMNFVZVk53K3BjcUl2YjVCZzUrSlJk?=
 =?utf-8?B?R3c1UmJkT2I1NzY2Kzc0MGdKSS9SR0doUTRGS1RhWW5zVm85c3E5VUpqN1lw?=
 =?utf-8?B?ZW91OG54Y2ozVTFXdHBWVDU1bUN5R1dZc3NzM2ZZYTJDVURtRFV2ajJ6MHhG?=
 =?utf-8?B?Y2lldFhmTFZWV29ZSDZzUmJWWXp1ZmdrVzdpU3NBQUkrb3Uwd1JEK2pmYjFL?=
 =?utf-8?B?bmcvYU1odUVQemxJVHpqUVBUL3J1dlovb01pSk1DWGxWQ29vNE9pSWl3dHVi?=
 =?utf-8?B?Vk5BYWhRUE9ISlFJSG9qOUl4NUUwSlVlRWdEY25DSWp5Sk5naUJZVjQ1MkNV?=
 =?utf-8?B?aHJHODhzM3RsVDJLQ1pWaVU3ZjFCTW83dkJGZUwzbCtnNmN3OVhZNmVYNkZp?=
 =?utf-8?B?UzFCWDd6SCtXTUNJTmc4YU10czcyeVY0cURaTndsYkhXU1VpWVJKMEs0SlRk?=
 =?utf-8?B?NTQrSVkvMG8vUTA0OXRaV0I3eWIyK2xseGMxTDNncUZxNUJiZjU3RWMyeEVB?=
 =?utf-8?B?OGdyZ1VJalhxNlVWUEk0S1NhdVFQMjRHdTRXUWJTSVNEVXVTZWt5UXZJVHJP?=
 =?utf-8?B?ZXJNT25sd01GMDRsSFZzWXpNTGFUR0dKYlF3RVFTNzZldy84WW12Rnk0T2tH?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07011088A9C72C48B53C6A6AB631E717@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f89da9-42ec-4432-de29-08dbdcd2e9a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2023 01:11:02.4175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUKI1/v6/7n2GB/Mpe2Gc2h9Z1Nt+WtPYf+mERE04HsDZkGLoEP3b46OwfKCA6NrTeqT3H/pcg0S8rx5WpHdmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8665
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--35.242900-8.000000
X-TMASE-MatchedRID: EpAKQ3/s2vnUL3YCMmnG4oSO7UPzxVPTjLOy13Cgb4+qvcIF1TcLYECI
        5/RruPKpWGbH9rlTsRwaH2v8HV+LCkRnYcSaaqPLvGTc5oROod6H7D1bP/FcOmhUuzmCSj0v0Ze
        BCmEdCbFEEzI2PVW/3JP2pKqg6KY84OOYe6VoKlF8l+tJjGm/SOt/wJpAYk9OKmFjQyJrNzeKqv
        zS2KCdDo9e22PZX4hu4lzbiv1ztHRw08wUkhf6c0hwlOfYeSqx4tNMMr1V2cVh7WbOnt2TByzEU
        5V3Ctgti3vbkrk2WWpMNbrUuyXyo5Coy9iDotiwYx1jPJKy+Dw0hOFI+Ko5QblmMfLNiukaNYEP
        TO7h0Xv22GT2dtGCZVn9tMazC/E367nOAh2fYqJCnGIuUMP0VfCrUlDnEXiS1VTshZ4BQIvTZNK
        +pGSjkEqLuIc287W85xPUiUcii1KOkKYrsG6nI8dDwwczffCuWwKGivsEuI1aW2Ktn+I8/iJxLW
        GJIfIZRxUr8frtv3y4wnXN50s0cRgZ7Tcj60QbFp8tduyF+iAHgh3sKJBzP2eZJz/mXY10U2nHQ
        1Gu65+ABaZivyt2RhgppAOAWeo1b8p9swPLC4F82pEOO2q38H0tCKdnhB58pTwPRvSoXL2y5/tF
        Zu9S3Ku6xVHLhqfxvECLuM+h4RB+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--35.242900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DDF5236AC55CD63762B053F07F19616ACFEC224D7F337895DB11F360FA9D84F22000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTExLTA0IGF0IDAwOjIwICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gIE9u
IFdlZCwgTm92IDAxLCAyMDIzIGF0IDAyOjIzOjI2QU0gKzAwMDAsIEVkIFRzYWkgKOiUoeWul+i7
kikgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDIzLTEwLTI1IGF0IDE3OjIyICswODAwLCBlZC50c2Fp
QG1lZGlhdGVrLmNvbSB3cm90ZToNCj4gPiA+IEZyb206IEVkIFRzYWkgPGVkLnRzYWlAbWVkaWF0
ZWsuY29tPg0KPiA+ID4gDQo+ID4gPiBSZWZlcnJpbmcgdG8gY29tbWl0IDA3MTczYzNlYzI3NiAo
ImJsb2NrOiBlbmFibGUgbXVsdGlwYWdlDQo+IGJ2ZWNzIiksDQo+ID4gPiBlYWNoIGJpb192ZWMg
bm93IGhvbGRzIG1vcmUgdGhhbiBvbmUgcGFnZSwgcG90ZW50aWFsbHkgZXhjZWVkaW5nDQo+ID4g
PiAxTUIgaW4gc2l6ZSBhbmQgY2F1c2luZyBhbGlnbm1lbnQgaXNzdWVzIHdpdGggdGhlIHF1ZXVl
IGxpbWl0Lg0KPiA+ID4gDQo+ID4gPiBJbiBhIHNlcXVlbnRpYWwgcmVhZC93cml0ZSBzY2VuYXJp
bywgdGhlIGZpbGUgc3lzdGVtIG1heGltaXplcw0KPiB0aGUNCj4gPiA+IGJpbydzIGNhcGFjaXR5
IGJlZm9yZSBzdWJtaXR0aW5nLiBIb3dldmVyLCBtaXNhbGlnbm1lbnQgd2l0aCB0aGUNCj4gPiA+
IHF1ZXVlIGxpbWl0IGNhbiByZXN1bHQgaW4gdGhlIGJpbyBiZWluZyBzcGxpdCBpbnRvIHNtYWxs
ZXIgSS9PDQo+ID4gPiBvcGVyYXRpb25zLg0KPiA+ID4gDQo+ID4gPiBGb3IgaW5zdGFuY2UsIGFz
c3VtaW5nIHRoZSBtYXhpbXVtIEkvTyBzaXplIGlzIHNldCB0byA1MTJLQiBhbmQNCj4gdGhlDQo+
ID4gPiBtZW1vcnkgaXMgaGlnaGx5IGZyYWdtZW50ZWQsIHJlc3VsdGluZyBpbiBlYWNoIGJpbyBj
b250YWluaW5nDQo+IG9ubHkNCj4gPiA+IG9uZSAyLXBhZ2VzIGJpb192ZWMgKGkuZS4sIGJpX3Np
emUgPSAxMDI4S0IpLiBUaGlzIHdvdWxkIGNhdXNlDQo+IHRoZQ0KPiA+ID4gYmlvIHRvIGJlIHNw
bGl0IGludG8gdHdvIDUxMktCIHBvcnRpb25zIGFuZCBvbmUgNEtCIHBvcnRpb24uIEFzIGENCj4g
PiA+IHJlc3VsdCwgdGhlIG9yaWdpbmFsbHkgZXhwZWN0ZWQgY29udGludW91cyBsYXJnZSBJL08g
b3BlcmF0aW9ucw0KPiBhcmUNCj4gPiA+IGludGVyc3BlcnNlZCB3aXRoIG1hbnkgc21hbGwgSS9P
IG9wZXJhdGlvbnMuDQo+ID4gPiANCj4gPiA+IFRvIGFkZHJlc3MgdGhpcyBpc3N1ZSwgdGhpcyBw
YXRjaCBhZGRzIGEgY2hlY2sgZm9yIHRoZQ0KPiBtYXhfc2VjdG9ycw0KPiA+ID4gYmVmb3JlIHN1
Ym1pdHRpbmcgdGhlIGJpby4gVGhpcyBhbGxvd3MgdGhlIHVwcGVyIGxheWVycyB0bw0KPiA+ID4g
cHJvYWN0aXZlbHkNCj4gPiA+IGRldGVjdCBhbmQgaGFuZGxlIGFsaWdubWVudCBpc3N1ZXMuDQo+
ID4gPiANCj4gPiA+IEkgcGVyZm9ybWVkIHRoZSBBbnR1dHUgVjEwIFN0b3JhZ2UgVGVzdCBvbiBh
IFVGUyA0LjAgZGV2aWNlLA0KPiB3aGljaA0KPiA+ID4gcmVzdWx0ZWQgaW4gYSBzaWduaWZpY2Fu
dCBpbXByb3ZlbWVudCBpbiB0aGUgU2VxdWVudGlhbCB0ZXN0Og0KPiA+ID4gDQo+ID4gPiBTZXF1
ZW50aWFsIFJlYWQgKGF2ZXJhZ2Ugb2YgNSByb3VuZHMpOg0KPiA+ID4gT3JpZ2luYWw6IDMwMzMu
NyBNQi9zZWMNCj4gPiA+IFBhdGNoZWQ6IDM1MjAuOSBNQi9zZWMNCj4gPiA+IA0KPiA+ID4gU2Vx
dWVudGlhbCBXcml0ZSAoYXZlcmFnZSBvZiA1IHJvdW5kcyk6DQo+ID4gPiBPcmlnaW5hbDogMjIy
NS40IE1CL3NlYw0KPiA+ID4gUGF0Y2hlZDogMjgwMC4zIE1CL3NlYw0KPiA+ID4gDQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBFZCBUc2FpIDxlZC50c2FpQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0K
PiA+ID4gIGJsb2NrL2Jpby5jIHwgNiArKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9ibG9jay9iaW8uYyBiL2Js
b2NrL2Jpby5jDQo+ID4gPiBpbmRleCA4MTZkNDEyYzA2ZTkuLmE0YTFmNzc1YjllYSAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2Jsb2NrL2Jpby5jDQo+ID4gPiArKysgYi9ibG9jay9iaW8uYw0KPiA+ID4g
QEAgLTEyMjcsNiArMTIyNyw3IEBAIHN0YXRpYyBpbnQgX19iaW9faW92X2l0ZXJfZ2V0X3BhZ2Vz
KHN0cnVjdA0KPiBiaW8NCj4gPiA+ICpiaW8sIHN0cnVjdCBpb3ZfaXRlciAqaXRlcikNCj4gPiA+
ICBpb3ZfaXRlcl9leHRyYWN0aW9uX3QgZXh0cmFjdGlvbl9mbGFncyA9IDA7DQo+ID4gPiAgdW5z
aWduZWQgc2hvcnQgbnJfcGFnZXMgPSBiaW8tPmJpX21heF92ZWNzIC0gYmlvLT5iaV92Y250Ow0K
PiA+ID4gIHVuc2lnbmVkIHNob3J0IGVudHJpZXNfbGVmdCA9IGJpby0+YmlfbWF4X3ZlY3MgLSBi
aW8tPmJpX3ZjbnQ7DQo+ID4gPiArc3RydWN0IHF1ZXVlX2xpbWl0cyAqbGltID0gJmJkZXZfZ2V0
X3F1ZXVlKGJpby0+YmlfYmRldiktDQo+ID4gPiA+bGltaXRzOw0KPiA+ID4gIHN0cnVjdCBiaW9f
dmVjICpidiA9IGJpby0+YmlfaW9fdmVjICsgYmlvLT5iaV92Y250Ow0KPiA+ID4gIHN0cnVjdCBw
YWdlICoqcGFnZXMgPSAoc3RydWN0IHBhZ2UgKiopYnY7DQo+ID4gPiAgc3NpemVfdCBzaXplLCBs
ZWZ0Ow0KPiA+ID4gQEAgLTEyNzUsNiArMTI3NiwxMSBAQCBzdGF0aWMgaW50IF9fYmlvX2lvdl9p
dGVyX2dldF9wYWdlcyhzdHJ1Y3QNCj4gYmlvDQo+ID4gPiAqYmlvLCBzdHJ1Y3QgaW92X2l0ZXIg
Kml0ZXIpDQo+ID4gPiAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBwYWdlc1tpXTsNCj4gPiA+ICANCj4g
PiA+ICBsZW4gPSBtaW5fdChzaXplX3QsIFBBR0VfU0laRSAtIG9mZnNldCwgbGVmdCk7DQo+ID4g
PiAraWYgKGJpby0+YmlfaXRlci5iaV9zaXplICsgbGVuID4NCj4gPiA+ICsgICAgbGltLT5tYXhf
c2VjdG9ycyA8PCBTRUNUT1JfU0hJRlQpIHsNCj4gPiA+ICtyZXQgPSBsZWZ0Ow0KPiA+ID4gK2Jy
ZWFrOw0KPiA+ID4gK30NCj4gPiA+ICBpZiAoYmlvX29wKGJpbykgPT0gUkVRX09QX1pPTkVfQVBQ
RU5EKSB7DQo+ID4gPiAgcmV0ID0gYmlvX2lvdl9hZGRfem9uZV9hcHBlbmRfcGFnZShiaW8sIHBh
Z2UsDQo+ID4gPiBsZW4sDQo+ID4gPiAgb2Zmc2V0KTsNCj4gPiA+IC0tIA0KPiA+ID4gMi4xOC4w
DQo+ID4gPiANCj4gPiANCj4gPiANCj4gPiBIaSBKZW5zLA0KPiA+IA0KPiA+IEp1c3QgdG8gY2xh
cmlmeSBhbnkgcG90ZW50aWFsIGNvbmZ1c2lvbiwgSSB3b3VsZCBsaWtlIHRvIHByb3ZpZGUNCj4g
PiBmdXJ0aGVyIGRldGFpbHMgYmFzZWQgb24gdGhlIGFzc3VtZWQgc2NlbmFyaW8gbWVudGlvbmVk
IGFib3ZlLg0KPiA+IA0KPiA+IFdoZW4gdGhlIHVwcGVyIGxheWVyIGNvbnRpbnVvdXNseSBzZW5k
cyAxMDI4S0IgZnVsbC1zaXplZCBiaW9zIGZvcg0KPiA+IHNlcXVlbnRpYWwgcmVhZHMsIHRoZSBC
bG9jayBMYXllciBzZWVzIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2U6DQo+ID4gc3VibWl0IGJpbzog
c2l6ZSA9IDEwMjhLQiwgc3RhcnQgTEJBID0gbg0KPiA+IHN1Ym1pdCBiaW86IHNpemUgPSAxMDI4
S0IsIHN0YXJ0IExCQSA9IG4gKyAxMDI4S0IgDQo+ID4gc3VibWl0IGJpbzogc2l6ZSA9IDEwMjhL
Qiwgc3RhcnQgTEJBID0gbiArIDIwNTZLQg0KPiA+IC4uLg0KPiA+IA0KPiA+IEhvd2V2ZXIsIGR1
ZSB0byB0aGUgcXVldWUgbGltaXQgcmVzdHJpY3RpbmcgdGhlIEkvTyBzaXplIHRvIGENCj4gbWF4
aW11bQ0KPiA+IG9mIDUxMktCLCB0aGUgQmxvY2sgTGF5ZXIgc3BsaXRzIGludG8gdGhlIGZvbGxv
d2luZyBzZXF1ZW5jZToNCj4gPiBzdWJtaXQgYmlvOiBzaXplID0gNTEyS0IsIHN0YXJ0IExCQSA9
IG4NCj4gPiBzdWJtaXQgYmlvOiBzaXplID0gNTEyS0IsIHN0YXJ0IExCQSA9IG4gKyAgNTEyS0IN
Cj4gPiBzdWJtaXQgYmlvOiBzaXplID0gICA0S0IsIHN0YXJ0IExCQSA9IG4gKyAxMDI0S0INCj4g
PiBzdWJtaXQgYmlvOiBzaXplID0gNTEyS0IsIHN0YXJ0IExCQSA9IG4gKyAxMDI4S0INCj4gPiBz
dWJtaXQgYmlvOiBzaXplID0gNTEyS0IsIHN0YXJ0IExCQSA9IG4gKyAxNTQwS0INCj4gPiBzdWJt
aXQgYmlvOiBzaXplID0gICA0S0IsIHN0YXJ0IExCQSA9IG4gKyAyMDUyS0INCj4gPiBzdWJtaXQg
YmlvOiBzaXplID0gNTEyS0IsIHN0YXJ0IExCQSA9IG4gKyAyMDU2S0INCj4gPiBzdWJtaXQgYmlv
OiBzaXplID0gNTEyS0IsIHN0YXJ0IExCQSA9IG4gKyAyNTY4S0INCj4gPiBzdWJtaXQgYmlvOiBz
aXplID0gICA0S0IsIHN0YXJ0IExCQSA9IG4gKyAzMDgwS0INCj4gPiAuLi4NCj4gPiANCj4gPiBU
aGUgb3JpZ2luYWwgZXhwZWN0YXRpb24gd2FzIGZvciB0aGUgc3RvcmFnZSB0byByZWNlaXZlIGxh
cmdlLA0KPiA+IGNvbnRpZ3VvdXMgcmVxdWVzdHMuIEhvd2V2ZXIsIGR1ZSB0byBub24tYWxpZ25t
ZW50LCBtYW55IHNtYWxsIEkvTw0KPiA+IHJlcXVlc3RzIGFyZSBnZW5lcmF0ZWQuIFRoaXMgcHJv
YmxlbSBpcyBlYXNpbHkgdmlzaWJsZSBiZWNhdXNlIHRoZQ0KPiA+IHVzZXIgcGFnZXMgcGFzc2Vk
IGluIGFyZSBvZnRlbiBhbGxvY2F0ZWQgYnkgdGhlIGJ1ZGR5IHN5c3RlbSBhcw0KPiBvcmRlciAw
DQo+ID4gcGFnZXMgZHVyaW5nIHBhZ2UgZmF1bHRzLCByZXN1bHRpbmcgaW4gaGlnaGx5IG5vbi1j
b250aWd1b3VzDQo+IG1lbW9yeS4NCj4gDQo+IElmIG9yZGVyIDAgcGFnZSBpcyBhZGRlZCB0byBi
aW8sIHRoZSBtdWx0aXBhZ2UgYnZlYyBiZWNvbWVzIG5vcA0KPiBiYXNpY2FsbHkoMjU2YnZlYyBo
b2xkcyAyNTYgcGFnZXMpLCB0aGVuIGhvdyBjYW4gaXQgbWFrZSBhIGRpZmZlcmVuY2UNCj4gZm9y
IHlvdT8NCg0KDQoNCj4gDQo+ID4gDQo+ID4gQXMgb2JzZXJ2ZWQgaW4gdGhlIEFudHV0dSBTZXF1
ZW50aWFsIFJlYWQgdGVzdCBiZWxvdywgaXQgaXMgc2ltaWxhcg0KPiB0bw0KPiA+IHRoZSBkZXNj
cmlwdGlvbiBhYm92ZSB3aGVyZSB0aGUgc3BsaXR0aW5nIGNhdXNlZCBieSB0aGUgcXVldWUgbGlt
aXQNCj4gPiBsZWF2ZXMgc21hbGwgcmVxdWVzdHMgc2FuZHdpY2hlZCBpbiBiZXR3ZWVuOg0KPiA+
IA0KPiA+IGJsb2NrX2Jpb19xdWV1ZTogOCwzMiBSIDg2OTI1ODY0ICsgMjE0NCBbVGhyZWFkLTUx
XQ0KPiA+IGJsb2NrX3NwbGl0OiA4LDMyIFIgODY5MjU4NjQgLyA4NjkyNjg4OCBbVGhyZWFkLTUx
XQ0KPiA+IGJsb2NrX3NwbGl0OiA4LDMyIFIgODY5MjY4ODggLyA4NjkyNzkxMiBbVGhyZWFkLTUx
XQ0KPiA+IGJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgNTI0Mjg4ICgpIDg2OTI1ODY0ICsgMTAyNCBb
VGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgNTI0Mjg4ICgpIDg2OTI2ODg4
ICsgMTAyNCBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX2Jpb19xdWV1ZTogOCwzMiBSIDg2OTI4MDA4
ICsgMjE0NCBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3NwbGl0OiA4LDMyIFIgODY5MjgwMDggLyA4
NjkyOTAzMiBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3NwbGl0OiA4LDMyIFIgODY5MjkwMzIgLyA4
NjkzMDA1NiBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgNTI0Mjg4ICgp
IDg2OTI4MDA4ICsgMTAyNCBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3JxX2lzc3VlOiA4LDMyIFIg
NDkxNTIgKCkgODY5Mjc5MTIgKyA5NiBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3JxX2lzc3VlOiA4
LDMyIFIgNTI0Mjg4ICgpIDg2OTI5MDMyICsgMTAyNCBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX2Jp
b19xdWV1ZTogOCwzMiBSIDg2OTMwMTUyICsgMjExMiBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3Nw
bGl0OiA4LDMyIFIgODY5MzAxNTIgLyA4NjkzMTE3NiBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3Nw
bGl0OiA4LDMyIFIgODY5MzExNzYgLyA4NjkzMjIwMCBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3Jx
X2lzc3VlOiA4LDMyIFIgNTI0Mjg4ICgpIDg2OTMwMTUyICsgMTAyNCBbVGhyZWFkLTUxXQ0KPiA+
IGJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgNDkxNTIgKCkgODY5MzAwNTYgKyA5NiBbVGhyZWFkLTUx
XQ0KPiA+IGJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgNTI0Mjg4ICgpIDg2OTMxMTc2ICsgMTAyNCBb
VGhyZWFkLTUxXQ0KPiA+IGJsb2NrX2Jpb19xdWV1ZTogOCwzMiBSIDg2OTMyMjY0ICsgMjA5NiBb
VGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3NwbGl0OiA4LDMyIFIgODY5MzIyNjQgLyA4NjkzMzI4OCBb
VGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3NwbGl0OiA4LDMyIFIgODY5MzMyODggLyA4NjkzNDMxMiBb
VGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgNTI0Mjg4ICgpIDg2OTMyMjY0
ICsgMTAyNCBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgMzI3NjggKCkg
ODY5MzIyMDAgKyA2NCBbVGhyZWFkLTUxXQ0KPiA+IGJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgNTI0
Mjg4ICgpIDg2OTMzMjg4ICsgMTAyNCBbVGhyZWFkLTUxXQ0KPiA+IA0KPiA+IEkgc2ltcGx5IHBy
ZXZlbnRzIG5vbi1hbGlnbmVkIHNpdHVhdGlvbnMgaW4gYmlvX2lvdl9pdGVyX2dldF9wYWdlcy4N
Cj4gDQo+IEJ1dCB0aGVyZSBpcyBzdGlsbCA0S0IgSU8gbGVmdCBpZiB5b3UgbGltaXQgbWF4IGJp
byBzaXplIGlzIDUxMktCLA0KPiB0aGVuIGhvdyBkb2VzIHRoaXMgNEtCIElPIGZpbmFsbHkgZ28g
aW4gY2FzZSBvZiAxMDI4S0IgSU8/DQo+IA0KPiA+IEJlc2lkZXMgbWFraW5nIHRoZSB1cHBlciBs
YXllciBhcHBsaWNhdGlvbiBhd2FyZSBvZiB0aGUgcXVldWUNCj4gbGltaXQsIEkNCj4gPiB3b3Vs
ZCBhcHByZWNpYXRlIGFueSBvdGhlciBkaXJlY3Rpb25zIG9yIHN1Z2dlc3Rpb25zIHlvdSBtYXkg
aGF2ZS4NCj4gDQo+IFRoZSBwcm9ibGVtIGlzIHJlbGF0ZWQgd2l0aCBJTyBzaXplIGZyb20gYXBw
bGljYXRpb24uDQo+IA0KPiBJZiB5b3Ugc2VuZCB1bmFsaWduZWQgSU8sIHlvdSBjYW4ndCBhdm9p
ZCB0aGUgbGFzdCBJTyB3aXRoIHNtYWxsDQo+IHNpemUsIG5vDQo+IG1hdHRlciBpZiBibG9jayBs
YXllciBiaW8gc3BsaXQgaXMgaW52b2x2ZWQgb3Igbm90LiBZb3VyIHBhdGNoIGp1c3QNCj4gbGV0
cw0KPiBfX2Jpb19pb3ZfaXRlcl9nZXRfcGFnZXMgc3BsaXQgdGhlIGJpbywgYW5kIHlvdSBzdGls
bCBoYXZlIDRLQiBsZWZ0DQo+IGZpbmFsbHkgd2hlbiBhcHBsaWNhdGlvbiBzdWJtaXRzIDEwMjhL
QiwgcmlnaHQ/DQo+IA0KPiBUaGVuIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgeW91ciBwYXRjaCBp
bXByb3ZlcyBzZXF1ZW50aWFsIElPDQo+IHBlcmZvcm1hbmNlLg0KPiANCj4gVGhhbmtzLA0KPiBN
aW5nDQo+IA0KDQpUaGUgYXBwbGljYXRpb24gcGVyZm9ybXMgSS9PIHdpdGggYSBzdWZmaWNpdGVu
bHkgbGFyZ2UgSS9PIHNpemUsDQpjYXVzaW5nIGl0IHRvIGNvbnN0YW50bHkgZmlsbCB1cCBhbmQg
c3VibWl0IGZ1bGwgYmlvcy4gSG93ZXZlciwgaW4gdGhlDQppb21hcCBkaXJlY3QgSS9PIHNjZW5h
cmlvLCBwYWdlcyBhcmUgYWRkZWQgdG8gdGhlIGJpbyBvbmUgYnkgb25lIGZyb20NCnRoZSB1c2Vy
IGJ1ZmZlci4gVGhpcyB0eXBpY2FsbHkgdHJpZ2dlcnMgcGFnZSBmYXVsdHMsIHJlc3VsdGluZyBp
biB0aGUNCmFsbG9jYXRpb24gb2Ygb3JkZXIgMCBwYWdlcyBmcm9tIHRoZSBidWRkeSBzeXN0ZW0u
DQoNClRoZSByZW1haW5pbmcgYW1vdW50IG9mIGVhY2ggb3JkZXIgaW4gdGhlIGJ1ZGR5IHN5c3Rl
bSB2YXJpZXMgb3Zlcg0KdGltZS4gSWYgdGhlcmUgYXJlIG5vdCBlbm91Z2ggcGFnZXMgYXZhaWxh
YmxlIGluIGEgcGFydGljdWxhciBvcmRlciwNCnBhZ2VzIGFyZSBzcGxpdCBmcm9tIGhpZ2hlciBv
cmRlcnMuIFdoZW4gcGFnZXMgYXJlIG9idGFpbmVkIGZyb20gdGhlDQpoaWdoZXIgb3JkZXIsIHRo
ZSB1c2VyIGJ1ZmZlciBtYXkgY29udGFpbiBzb21lIHNtYWxsIGNvbnNlY3V0aXZlDQpwYXR0ZXJu
cy4NCg0KSW4gc3VtbWFyeSwgdGhlIHBoeXNpY2FsIGxheW91dCBvZiB0aGUgdXNlciBidWZmZXIg
aXMgdW5wcmVkaWN0YWJsZSwNCmFuZCB3aGVuIGl0IGNvbnRhaW5zIHNvbWUgc21hbGwgY29uc2Vj
dXRpdmUgcGF0dGVybnMsIHRoZSBzaXplIG9mIHRoZQ0KYmlvIGJlY29tZXMgcmFuZG9tbHkgdW5h
bGlnbmVkIGR1cmluZyBmaWxsaW5nLg0KDQpUaGlzIHBhdGNoIGxpbWl0cyB0aGUgYmlvIHRvIGJl
IGZpbGxlZCB1cCB0byB0aGUgbWF4X3NlY3RvcnMuIFRoZQ0Kc3VibWlzc2lvbiBpcyBhbiBhc3lu
YyBvcGVyYXRpb24sIHNvIG9uY2UgdGhlIGJpbyBpcyBxdWV1ZWQsIGl0IHdpbGwNCmltbWVkaWF0
ZWx5IHJldHVybiBhbmQgY29udGludWUgZmlsbGVkIGFuZCBzdWJtaXQgdGhlIG5leHQgYmlvLg0K
DQpCZXN0LA0KRWQNCg==
