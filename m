Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB9792866
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349063AbjIEQSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbjIECsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:48:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CA6CC6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 19:48:11 -0700 (PDT)
X-UUID: a27325344b9611ee8051498923ad61e6-20230905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RiyUfq/oUZ79cTfk7WJKn1P8+JzVxNpoaqbAsyXxo9Y=;
        b=Nchoh89vWhVO0wVlAQq8HBXnY3MoteZmr1Tkpg9xnuPbM+U11re4kLi4mQuOyIFaxN7Ivksjxqi7pDPdvqP9uUlMSpvjy+S5ZRWK+rdlK6Bfy7fPCuT//CuIjCQQwhlzsdtSx70WTZH4q603csx+1vWSM1ddYlHGx2aOKRI+ZPo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:7c23d6a1-511f-4214-bdf5-149e40bde4df,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:cb1750ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a27325344b9611ee8051498923ad61e6-20230905
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2035160323; Tue, 05 Sep 2023 10:48:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Sep 2023 10:48:03 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Sep 2023 10:48:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyMpstS7Qt+O3biljYWOEAYq2wgNmzwimOT7/CNW7mu9wkUTQLHB5roGIL1YPsyWemrJjacWf00x+co6awYEg3kl8VOPfuIN/Dx22qaIkpiZnuyJgGe8WrF2ZQVS6q3Dp8Mfdv2HwLuWC6f2RPjezdW+kIXmTAF/JL2n/z/vEK6ddeMzoYENdhzGIre3EoMjXKZvka6pJqanTHNkelino4katyc1/xlsV4xWhj1ZvOGmvdATm/It6f9eX5a65QvxoyhiRiaeu9We5qcydl5cjMDmVGik+sakbdd/z4OWhh1juwFl7gd2GYPTQEXD0En9H+XkcU4vY5N+8GPcan4C3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiyUfq/oUZ79cTfk7WJKn1P8+JzVxNpoaqbAsyXxo9Y=;
 b=cmnbeW0x1TCiv5P8jHTnVzmmNEOR/l6AlSUacPey8fLdcS1g2eYXxur3B/3TvC9/O1ACaNe9XZqZHU0+DQR4n3RUCH/1pObmaORcN3SqpI+UGifibgcxnlxqayyR313GeCihenLYlqR0ZHOFV9uOosb68eilUfjEURE8FGQz+5jRatM+x3RdkF/TSYV2HahnqaBxW4ThbFBYgqh1DpWhKnYNre1YScf0t1BAp1Q1fkzp0aUDr+pR4wi7EIYdbzCvdIi8knYOUeUZh6wlZmdeX/3IwldqICS7J7QsbKLCRmaom1JrHs5Pkdos6AG8QcEywyuudvkXzcVzNC3CABcCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiyUfq/oUZ79cTfk7WJKn1P8+JzVxNpoaqbAsyXxo9Y=;
 b=HGGPbO/BhTOn7LsqWU+S1pXge2gGCtOKPEKPPmawvIg7ShoyGnLsZphbg5BCQ6y/PWV0Y36CAN+CU6vGcZTXHn0eYtWr1hFPGqMufm19emtmhVPWVNOZsWB5EgCri3fEzRyWuVBSME9yeCwyBQdLKesWS7YkdJf18mjvilY0qPo=
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com (2603:1096:301:b4::11)
 by TYUPR03MB7229.apcprd03.prod.outlook.com (2603:1096:400:358::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 02:48:00 +0000
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::4731:7196:588d:ba27]) by PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::4731:7196:588d:ba27%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 02:48:00 +0000
From:   =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
To:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>
CC:     "andreyknvl@google.com" <andreyknvl@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        "elver@google.com" <elver@google.com>,
        "eugenis@google.com" <eugenis@google.com>,
        "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCH 00/15] stackdepot: allow evicting stack traces
Thread-Topic: [PATCH 00/15] stackdepot: allow evicting stack traces
Thread-Index: AQHZ36GyQqx7aOyG9USa8MVVyLP1i7ALh3kA
Date:   Tue, 5 Sep 2023 02:48:00 +0000
Message-ID: <3a372d658246c5dd1ab1d95f4b601267b0fb154e.camel@mediatek.com>
References: <cover.1693328501.git.andreyknvl@google.com>
         <3948766e-5ebd-5e13-3c0d-f5e30c3ed724@suse.cz>
         <CA+fCnZdRkJTG0Z1t00YGuzH4AFAicGUVyxFc63djewRz0vj=pQ@mail.gmail.com>
In-Reply-To: <CA+fCnZdRkJTG0Z1t00YGuzH4AFAicGUVyxFc63djewRz0vj=pQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5964:EE_|TYUPR03MB7229:EE_
x-ms-office365-filtering-correlation-id: 96642851-7d91-48e4-29e6-08dbadba84c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IycZlfgoamv48mUkpEjk6olPhogpqj+ZSgAuecJokpaNr/nBG6X/xtAbF5QVOAeIdD5CQyb5RHY1q2vaTwI2f8WtvRvBBkd6mk7f0SK2jwOSbFZq4wnvXCCfmNVuIzOVZZw9Fbh1BIT0Id2xr3lNqbQ3Gt8U6URi0UAG9+WOPD89g8MqSUBPtGiKw4RJZiXQ8q8MysFlbXsYRyNaA/anb0ZnfpLPIfvTwUDcbH+PnmuOvqGHNjiOrpFnvFfYxm1Al4RijHhIZ+UE2lAUchSrGD72YHhDPKiKJ3NDS14VPrOmadFR0HQAa9ir5JIYjcUfxgYUzGudDgMASf5FCEyEjP7AKey6y946aZOgtXdmnwIqqLIvZo7af9GVu9T/OvtmnHDl3HMpbW/STUUUQ3p+2LdmYR/FnQ8T4jl4aUH7TOfpl+pMWdKeLy5ygOKQWuRYNqP1/oYVVsTVajYDgwcUuA1bppjTyN9H8l4Dh7KftZ8DC6KymIvZ/NygHu2TUo3kamfbgSKtA3sXnuV9HgsTWTER3Ee2MpQVjJD6WYQXG9ae+bun1Cqx1odTkQkpOakZN97qBRUz8XpmzLyfhUBgepsChZBBDorTyR5zGGKoO8QctFwOKlhnLp0w7TZfeoFh0AWVLXTFh9gD50OZx8tbb5ZKD1PcIa8ABScsPlko4OWy2k9eWIwTym1jVxTbTl+0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(38100700002)(122000001)(38070700005)(83380400001)(41300700001)(5660300002)(85182001)(36756003)(7416002)(86362001)(66556008)(66946007)(66446008)(66476007)(76116006)(26005)(64756008)(71200400001)(478600001)(2616005)(110136005)(91956017)(8936002)(53546011)(8676002)(4326008)(316002)(6512007)(6486002)(54906003)(2906002)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2p4UVpIcStRZEtQUnhWZ21iUzUxeStEYW5rMmJVdTNOR1FlekU3aTBmNTlE?=
 =?utf-8?B?UVBaenVJdkt1TDJrM0JETUZmQzR0REtjUkszd05wWndaeTh0Y25RL28vVnpJ?=
 =?utf-8?B?Z1VKdXkyZm5TTW5zZ01vbDRvNVdpc2RMYm1HQ3VjV3kwQVZMMGVOU2R3ZmRW?=
 =?utf-8?B?eW94dWZ3Wk43c1AwZXNQN0VzZWRDczVkOTM2cFBZeUhIcVhvNmdSdHBoakpN?=
 =?utf-8?B?UU42UnExMGl0dzJlVGFrbXlZS0JWcFRwODNqTWMzNGZlWkpJRVQrdGNIdWhr?=
 =?utf-8?B?UGphNDVZRyttNjhWR1EwSnU1cngyZGxxTWptdkQrem8xL3BvcCtkTFdyaUt6?=
 =?utf-8?B?OUluNUNnOGQxeENiTTlHMjlDajIxUldXdXFWVXRYYUt3UTVuM0IrVnQ1eWhk?=
 =?utf-8?B?WTNhSGJ2cU5MT2djcnIvVXJ6cEpkdzdGK2k2Znp0Yy8zbXJadVVEdURPWFho?=
 =?utf-8?B?byt5dEU1cU04OVk1b3FjdDhaSzdDYlFKUmgzVXRJNkJrQ2lUbm96T2dPZlpH?=
 =?utf-8?B?WmNWbzUxOFdoOG9EeGRBV1ZhT2RmZXFmaCtoays0ZHFUQmlPRVc2aWkvQ0w0?=
 =?utf-8?B?T2hBMy9tZE5WUCtUWXZQZ3ZHbFpYaGZFQUFDR2Y2bjcxVXNKL21IRmtwKzhT?=
 =?utf-8?B?ZGJUSmdYSGM5cEdPYlFlbzlzY092TG1kM1dON1BpK1NjTGhhUG5SWlFsbUs2?=
 =?utf-8?B?RVIwNDAzVzl5ZUxBY1Vha2o1VmhTbWpGaUQ1VmU4SVRtWkdGSWc4TERpM3o3?=
 =?utf-8?B?Wk1ZK3pjOXUzMSs0Rm12bXhkYVh4NDVhUU82QnVOS0IvejdmcTZKd0JPbWxM?=
 =?utf-8?B?bFVkVE5XRmIxQ3JXRG9SWVFmZHVZNUdWT0ZXTzk4YStjQ1BRZk9BZURTV2ZE?=
 =?utf-8?B?RUo3VUtmb2xEODFCeVFKb014T25OUnBFVXNKRjA0YzRNMFNPeFRESDVHblRj?=
 =?utf-8?B?aWFqQlFDVGxheUQ1R2s2dEt3a0tpZ2FlcVZkbmRZYTZVWUk3TmJFMFFsMHZD?=
 =?utf-8?B?bHAvcjYwOTZ3VnZKSWFlc2ZXZit0WURuSWxiUk5LWUJoalJ2SW5CdTEvb3I1?=
 =?utf-8?B?NzRNVHVpZmFrSU9mWm5OOVQ1ZEd5ZFhTZGc5YWl2cEM2bkFRR3lXWVgrUlhB?=
 =?utf-8?B?eEU3bW1hMjllQlVhenpFRTRNcWc0SWVud2Q1WlM3d2VXWWhNUTlPTXE2RUEz?=
 =?utf-8?B?bjlNUzRYem0yRWpORXoyK0JHRlZ0WFFabjRDUnRMYUtUbWdCVXNKcnJNYk9C?=
 =?utf-8?B?dnNQRVpnMUtXSXdtTm0rU2swRlJkNG83cTljRDhvZlVqWlk0Rlh4UWFONVcz?=
 =?utf-8?B?cGc0b1kwT1lVM2Z5OUdZQmxyUm1EVXlpV3lFUjF0OWhyVEh2UG1xZkczbFBB?=
 =?utf-8?B?REFvdVhPa0FDd256K2lFT1NqeENrbzc0cmpESElCRTUyMGlLa0pZWW13OENX?=
 =?utf-8?B?dUpuTlg2bDBPemNGQjR3eU4vUEdrV1B1UzFVODdVZHNUcnNJRnIzSkJCTUsy?=
 =?utf-8?B?UUQrVXZvMFI5d0lFLy82SnNoVWlLTi8yVnpKckpnb0F5OUlyU0RZa1IxSitY?=
 =?utf-8?B?TjZjdTh0SXdkdUlNelc2dTJJN1d2UlByOG9iQ0lING9oeGtPcVRlN3plZlhw?=
 =?utf-8?B?VWU0NzR3NHJUakhyRkxDMGhNckVtRS9zbTkzQUJqeVlKYW96ZG8vRVdwU3p1?=
 =?utf-8?B?ZlBOaS9URThtbS9GTHpOLzRjVVQzOFREUkRtL3Q1RXU0cFM3bUw1S0gvNitl?=
 =?utf-8?B?UWJxbXk2dEpXS21tSUNPQVpPUXNSdzh5OVd6MzAvQVVWbUIwNUIxdWVKa2k1?=
 =?utf-8?B?OTRjREJyb0tsaDZRSVZFOFdzZnZ4VnU4U2t0cjVuNnVUbjkxV0p6aU9maFBk?=
 =?utf-8?B?SG8zeHZvczg0eU5vZVcrMlJadkt6QllkUzEvUXpqZTVQazYxRThZMzU4VXBq?=
 =?utf-8?B?S0hXZFBhUDIvd0FQTU9RN1o4STdTa3VhOE1NdzJkcWVrMnFNWXIzVm9MQzdU?=
 =?utf-8?B?TElaTkREYTh3eTlaSVAyRUR3ditBNVdyZ0ZwdWtPTzdja2Q3aVhmdG5kcDFi?=
 =?utf-8?B?M29sZ1k0bmVoS3FPOEZHUUtqKzBXY0xqelRlMFRSUXBLeEhDUkVEMXc1ZXlZ?=
 =?utf-8?B?QWQrNGJSMTczTitsenIzb0FGMHZLNXErMlJlSEo0L3ZNU1pBdU5Dc3Nyekd3?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <088D6DD7BED7F647B8EA131597FD3C9F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96642851-7d91-48e4-29e6-08dbadba84c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 02:48:00.5550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFo75OqRqbYuegaMszafx4hSmeJUKm/Ja65nyskvj1I1Rj8ON742XIsBnUxHUGTD5ssKA2a8LKkdJdNtLPcnF1IPNB72tExKAcOhoYD9OqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7229
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTA0IGF0IDIwOjQ1ICswMjAwLCBBbmRyZXkgS29ub3ZhbG92IHdyb3Rl
Og0KPiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBhdCA5OjQ24oCvQU0gVmxhc3RpbWlsIEJhYmthIDx2
YmFia2FAc3VzZS5jej4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gSSB3b25kZXIgaWYgdGhlcmUncyBh
bHNvIGFub3RoZXIgdGhpbmcgdG8gY29uc2lkZXIgZm9yIHRoZSBmdXR1cmU6DQo+ID4gDQo+ID4g
My4gV2l0aCB0aGUgbnVtYmVyIG9mIHN0YWNrZGVwb3QgdXNlcnMgaW5jcmVhc2luZywgZWFjaCBo
YXZpbmcNCj4gPiB0aGVpcg0KPiA+IGRpc3RpbmN0IHNldCBvZiBzdGFja3MgZnJvbSBvdGhlcnMs
IHdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gY3JlYXRlDQo+ID4gc2VwYXJhdGUNCj4gPiAic3RvcmFn
ZSBpbnN0YW5jZSIgZm9yIGVhY2ggdXNlciBpbnN0ZWFkIG9mIHB1dHRpbmcgZXZlcnl0aGluZyBp
biBhDQo+ID4gc2luZ2xlDQo+ID4gc2hhcmVkIG9uZT8NCj4gDQo+IFRoaXMgc2hvdWxkbid0IGJl
IGhhcmQgdG8gaW1wbGVtZW50LiBIb3dldmVyLCBkbyB5b3Ugc2VlIGFueQ0KPiBwYXJ0aWN1bGFy
IHVzZSBjYXNlcyBmb3IgdGhpcz8NCj4gDQo+IE9uZSB0aGluZyB0aGF0IGNvbWVzIHRvIG1pbmQg
aXMgdGhhdCB0aGUgdXNlcnMgd2lsbCB0aGVuIGJlIGFibGUgdG8NCj4gY3JlYXRlL2Rlc3Ryb3kg
c3RhY2sgZGVwb3QgaW5zdGFuY2VzIHdoZW4gcmVxdWlyZWQuIEJ1dCBJIGRvbid0IGtub3cNCj4g
aWYgYW55IG9mIHRoZSB1c2VycyBuZWVkIHRoaXM6IHNvIGZhciB0aGV5IGFsbCBzZWVtIHRvIHJl
cXVpcmUgc3RhY2sNCj4gZGVwb3QgdGhyb3VnaG91dCB0aGUgd2hvbGUgbGlmZXRpbWUgb2YgdGhl
IHN5c3RlbS4NCj4gDQpNYXliZSB3ZSBjYW4gdXNlIGV2aXRpb24gaW4gcGFnZV9vd25lciBhbmQg
c2x1Yl9kZWJ1Zw0KKFNMQUJfU1RPUkVfVVNFUikuDQoNCkFmdGVyIHdlIHVwZGF0ZSBwYWdlX293
bmVyLT5oYW5kbGUsIHdlIGNvdWxkIGV2aWN0IHRoZSBwcmV2aW91cw0KaGFuZGxlPw0KDQo+ID4g
SW4gYW55IGNhc2UsIGV2aWN0aW5nIHN1cHBvcnQgaXMgYSBnb29kIGRldmVsb3BtZW50LCB0aGFu
a3MhDQo+IA0KPiBUaGFuayB5b3UhDQo+IA0K
