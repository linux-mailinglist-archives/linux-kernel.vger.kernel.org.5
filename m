Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490837C7C78
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjJMEHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMEHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:07:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5B3B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 21:07:41 -0700 (PDT)
X-UUID: 0bb9a41e697e11eea33bb35ae8d461a2-20231013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/3D/fSa0mQs5d/t0ekZpd4CE08iFjeWwlDVPJJj6CZ8=;
        b=l9zwCy0JPpgpIq+onOkz4eQvbL+V2V5HGly2cjAESwsGyIxayx34jP+VSlX2Kk7SuEwA/gDcgktRRWjmyw8BDocaYzEu/9hh5kNd6Wdv0FDLKl3pIwneD0aHYO7BLKRvN+J/5BOZCrOunnxxlN2gMaca3DqK168dqh80qOGPlks=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:35362998-bd06-433e-bb82-e6e97bc14686,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:6e6de1bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0bb9a41e697e11eea33bb35ae8d461a2-20231013
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1023898239; Fri, 13 Oct 2023 12:07:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Oct 2023 12:07:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Oct 2023 12:07:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq8Bb325u0QEWm0a5lBomhzvENRmqNQD8v1LRGPWbPETXqGW4pni81fd+KzEBIUelvUiEvLexbvqlFqg/1Alguz8z7MDwz1AT9uPfIXfpcXZgJsaAdrj0nbPCG8DIUnMzzkpYerUAJJYW4B4vGYRjYwSqoAmUBqSyM4JN40WN8ZpZ58hYlyWWtOOUnDNQ3Q9Y6StnUSX4gvVtqEpjDMXHTY9DLtRBtAJMv81OXu0VGaEonj2Nze1DnH53E9QqIg+nRtoQMXoHdB3AoB8f6zgp1GVyWoCK/CjKhXMJiRF5WI6wLnSquZJhpO3disPXTisjSedLMPRYFP4JMhRHIu6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3D/fSa0mQs5d/t0ekZpd4CE08iFjeWwlDVPJJj6CZ8=;
 b=gSwXlsKR8S+BytJlq54L5JPOKBh7Dz2uZMa7LIjaRvBDnUodO64FCdvvwQ3KUNfus8GuB4QckJO5i+8DBPw43IlWSnenKz37S8YpL6bJxHnZfbWlxOcGIgJwNr7PKuyWAkMWLkcit8A9urY/v8kQnyFotJiqYnYs30JxWhf3Z1t7oI/Qsxu1OcLHIE09Tihoa1pY53i92vTiJwD1+Noh9nqJppfrZasWmosf2LLADP1q3+h44BEbLJ52FPWsl894+Fftmqyx035r4nM+7krCUHUP2EB6fGMu9mTAWADLV7g82JaBc7mOJ9qROmQVaOqac3T8SmBLJuqiBMzP7Nqdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3D/fSa0mQs5d/t0ekZpd4CE08iFjeWwlDVPJJj6CZ8=;
 b=JKs7WsUyryd16mm0GgndemAYS30fdWgHiL401M7MppuN/vYbxfsWjMl5uDbPd9XRBF+nUq1LGdDaO+Zz9KDQzHsStyxxCuKZmir9yjx4kyfcTJIemTU5Hqv1duGbbqfT8W45GxWKtMOuaTRszzz60Lno5mJYvUuniS0hlw5Kzxg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7561.apcprd03.prod.outlook.com (2603:1096:101:147::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 04:07:29 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 04:07:29 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v11 08/16] drm/mediatek: De-commonize disp_aal/disp_gamma
 gamma_set functions
Thread-Topic: [PATCH v11 08/16] drm/mediatek: De-commonize disp_aal/disp_gamma
 gamma_set functions
Thread-Index: AQHZ/PK1V2OVK057sUWyDwdC/4ldJ7BHG6kA
Date:   Fri, 13 Oct 2023 04:07:29 +0000
Message-ID: <36cdd47a7016cfb8814e65b341db83006af9cdd8.camel@mediatek.com>
References: <20231012095736.100784-1-angelogioacchino.delregno@collabora.com>
         <20231012095736.100784-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231012095736.100784-9-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7561:EE_
x-ms-office365-filtering-correlation-id: 48cf77b6-7e96-4943-7a17-08dbcba1eace
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yfrpUJVDzjHA6DI9agKqM7fgAvTrS1Fx7KS6z212XF3T7eocovwerGxScfad6O5jFBlL81ck6fd6gfB4Wlx1G3tFhzJc+y5fhquG7t2AR5kPf93B4aTBdbXiZmsIfMogSaIYxcGL60MSfRnjodpkaUgJH6XysW8gAJUxwFiBp9cROh/ky9YpNpkXXztDalce/0QDih7b4bXzRsZEo2DnE7drsBoLOonbJni/nbPU/Ul0ufpiTToSzYEU38vaGnrpsLs0Ug26XpCWM0XpRmMfIBcqC/ZfiT8wqnWC6oFh63d1hYgi0JPdAFF3nCUiQMGmhXM+LJQ0vcfbUL2D3J9KKv5WLij4H3rjkhwW8wpeEZ+2KTK8EmmK6e8bSalhEfKtnlOJgyhCC5Kr+2OsdtDN2VfRdn7q8vPoDSJeA/19tX8uzCxJYhX5Xo3G0LdCVv7x9FRCxZ0oI86x7EUNH6OLeFQxxYsTLMH2QeKx2hGx3v+Pq0G/68BwDKRonQT3R+PQwA5ShJEGknDdQ6qzWGxuR+47SVgy8JbjQNt3Lr+ccsqbST6eRbCOTB5LyvKQ1cIf20FXhnaUFwm1bpDcLgX5IasEKfI8hrfFIId3LsG1b+xdR5vQZDPuLc/HDw35mm2sOoJTe/B1NGtG4fjDU36k4x8tvIIPymf2y/eUzP3PW10=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(2616005)(71200400001)(6506007)(478600001)(6486002)(26005)(7416002)(83380400001)(2906002)(54906003)(66946007)(64756008)(5660300002)(41300700001)(110136005)(66556008)(76116006)(66446008)(66476007)(8936002)(8676002)(316002)(4326008)(4001150100001)(38100700002)(85182001)(122000001)(36756003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHh3aHBobm1rWFpkUWw0Y2ZxQlRkZXVjUGEweVo0b3Fnc2JjNFMzK0QrZUc1?=
 =?utf-8?B?blBOTkN2cFM2NzBzZFNmUUNOS0xFN3pENEhuOHRYZ3pHektkT2g1NVdaelZS?=
 =?utf-8?B?bSt0dm1oTkVMdStGQU84MnJWVGdzQXhCSGVMaXprT2hFWklreGlpbEg5ZENJ?=
 =?utf-8?B?N29SZzBBdnlRUVhkNVhGNVgvVWhTN0hvTVdLWUNCSXZ3TU9GcHkxTVVyd3Qr?=
 =?utf-8?B?bU1OUGVjRU1NTTBCalZ1STBnMzVzRi9hQ3NNK1ZnbEQ5VGtQQjhnVXEzVCtU?=
 =?utf-8?B?VkQ2V25LeDRuMVlDNHlyVDhNTXZrVjZucTVmRjl5WE1USHI4bU5ZMHQzU0lY?=
 =?utf-8?B?aDlpdlJLNzdKTjhrdTBSM2FoSG8rakVma2FYVGtGOGlNMXZ6bkVEYzlsWHk2?=
 =?utf-8?B?T084YTFiLzNPcjV2MjRLMk02Qnd2NGZyWmdkQ3lYUmswVlQyeXoyZk5Vd0Rx?=
 =?utf-8?B?WGlmaHFrbWE1U2piYldkRkpIcTRDazQyMU1rWnR6cWxaSTZ0L3hZUGNMeWEx?=
 =?utf-8?B?bWpaNzR0TGRzcFVXd1dCMVBTamxPakRTL1FPRTdQYlpwbkFYZGVZQ2h2clRB?=
 =?utf-8?B?YzVUem5VM3g5MjVmWFBWd0JVLzQzcm9IWFdtbnFOcnI0N3laNFFUZWFxRTJQ?=
 =?utf-8?B?aGlpRXhiR1F1eXdpaUtBd2xTV1UzQkpCYVFjWmt3aDluejF1QzNZMVNiMTlV?=
 =?utf-8?B?OHkyMGVPVzUzMzE2OVNnVCs0cEpHdXdmSmhSeUgzbUQ3RlhNb2haczV4RjhO?=
 =?utf-8?B?ZVR6RVNYVTFHUVJZWVREeitPbVJNRU9iUkUwOFpCZDhqWDJSZzU3SHRYaUpz?=
 =?utf-8?B?MUhpcEp2UmpqWnZLbHUyaXUrdi9rWFlTTGY5RDM2ME9HdEdhZWFLM0VnUm81?=
 =?utf-8?B?bGV4NEZaWm0vdzRSNEE0Mi9UT1BqeWFOYmovTFdvRjh2alExZlBtYW1XRDZ1?=
 =?utf-8?B?L3ZjNWl6VWMwa0ZTd29YR2FrQ1ZjbkR6ZnhpK3JuQVkwNExIR2tkcmt1Z2li?=
 =?utf-8?B?YTFpWjZLNmpkbkk4SHAyMVFJSUVWM0cyZHZFY2RzRkZGY1Z6VnJiakdvemNS?=
 =?utf-8?B?cUkzaWx5SHdDKzhQL0Q2eVhQSnh1STBqeE5tc2RvR2lkMmYrL3FzdXdxanJp?=
 =?utf-8?B?NGRiazV2OFlGRHVkcnRHOHY0RTF5T2NiSkdEbFpvRVFWZEhZQW8yV0pSVWZ4?=
 =?utf-8?B?MDlLdU1pSStlOWZyWUNqT0ZSRXhhVXpLa1pBT21jTnZVQ3JGUjFyZW1zclBV?=
 =?utf-8?B?dElCVlVZMFBid3ZHc0pzSkxXU0ZjWm1HRGFvcUo2cjYyT1c5QUhkYTBzSURp?=
 =?utf-8?B?ZlhvOERCUEtrcGxpZ2tmK3AzZVBGY1cwdzEyenpGZElhRG5iWVlFUnRtdk90?=
 =?utf-8?B?bCtZNlZDVitLTEc2V3Foa1J4aDl5RmMvT2lpUnhyTi9RZlVSVDk3cUJYa3Vi?=
 =?utf-8?B?TjFtOStkSjY1czVzNTdrUjcyS1ZtNE1iQUpRdnd5cmlqekFiTWNVeHBjenhI?=
 =?utf-8?B?V3RjTXNUOEhzNmhHdm9rZmdkOEJpRmFCUSswTEZCdzBHZWo3dXpWMjNXUjhT?=
 =?utf-8?B?VCt1S1hyVjVLK25PZ05EWHAwYzZMSk4rb0FBQ2tVaE9aUk9JL2x2bzFxMDFI?=
 =?utf-8?B?TVB0N3I1eUFPUlJweDYwUC8zVk5GbUJpVzc4VHU4Q2RQdHhNUHlSUi9tTzF1?=
 =?utf-8?B?RlBKRlR4VFF2ZkhsK0NoUkgrUFlrUFZ0WGtacmF1cFB6M0NDTHFKejR6RDQv?=
 =?utf-8?B?QkNrY1F1ZndkcVdPN0ZVWW8zUG1BbGRGaXkrdTBYelJ4cmc0MjhuaC9TTXAz?=
 =?utf-8?B?Z2hiNGY0Uy9jaUJHeVhmMVBjK1VmVEtZQXgwMno0NEFpV2dXOG03WW5BMWY1?=
 =?utf-8?B?S2cvK1ErRHVLYUhiaHZ6Y1hPZGY4YitmbmFxU2dWcUZQN3NyMjJVd1hxTmRF?=
 =?utf-8?B?M0dQcnQyY3NtbXFKRTRSYWhUMnRvbFh3b3VwcUVDVUdYSjdoZUZKaW5sbmhM?=
 =?utf-8?B?SFJzTEZ1UWJORkNGaUM5Sk1ZUzZGN0RxRURzY0pVR041SlB1RC9veENTKzdG?=
 =?utf-8?B?ekNZWGVYYmQyQjdmVTEvMlN4aDdtRmRBUHQzV0xxbjNJU0g2MXdpR044d25X?=
 =?utf-8?Q?+ahcjly2J1i6CsJVgkntvDvDL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D38A12518375304B910FCCF693ECE947@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cf77b6-7e96-4943-7a17-08dbcba1eace
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 04:07:29.2195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ok9NDGDIM94AYUhVKaDHBhmWU2A7e079KDEigIhTbyATVhKedbPSr/GdU9EydRSLeKibEYzF8Vxm2r1sWuafRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7561
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTEwLTEyIGF0IDExOjU3ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSW4gcHJlcGFyYXRpb24gZm9yIGFkZGluZyBh
IDEyLWJpdHMgZ2FtbWEgc3VwcG9ydCBmb3IgdGhlIERJU1BfR0FNTUENCj4gSVAsIHJlbW92ZSB0
aGUgbXRrX2dhbW1hX3NldF9jb21tb24oKSBmdW5jdGlvbiBhbmQgbW92ZSB0aGUgcmVsZXZhbnQN
Cj4gYml0cyBpbiBtdGtfZ2FtbWFfc2V0KCkgZm9yIERJU1BfR0FNTUEgYW5kIG10a19hYWxfZ2Ft
bWFfc2V0KCkgZm9yDQo+IERJU1BfQUFMOiBzaW5jZSB0aGUgbGF0dGVyIGhhcyBubyBtb3JlIHN1
cHBvcnQgZm9yIGdhbW1hIG1hbmlwdWxhdGlvbg0KPiAoYmVpbmcgbW92ZWQgdG8gYSBkaWZmZXJl
bnQgSVApIGluIG5ld2VyIHJldmlzaW9ucywgdGhvc2UgZnVuY3Rpb25zDQo+IGFyZSBhYm91dCB0
byBkaXZlcmdlIGFuZCBpdCBtYWtlcyBubyBzZW5zZSB0byBrZWVwIGEgY29tbW9uIG9uZSAod2l0
aA0KPiBhbGwgdGhlIGNvbXBsaWNhdGlvbnMgb2YgcGFzc2luZyBjb21tb24gZGF0YSBhbmQgbWFr
aW5nIGV4Y2x1c2lvbnMNCj4gZm9yIGRldmljZSBkcml2ZXIgZGF0YSkgZm9yIGp1c3QgYSBmZXcg
Yml0cy4NCj4gDQo+IFRoaXMgY29tbWl0IGJyaW5ncyBubyBmdW5jdGlvbmFsIGNoYW5nZXMuDQoN
ClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8u
ZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3BfYWFsLmMgICB8IDQxDQo+ICsrKysrKysrKysrKysrKysrKysrKy0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICB8ICAxIC0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jIHwgMzQgKysrKy0tLS0tLS0tLS0t
LS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
YWFsLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfYWFsLmMNCj4gaW5k
ZXggMDVmOWJlMjNmYTQ3Li5hNjE4YmU5YjNkYmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9hYWwuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfYWFsLmMNCj4gQEAgLTE3LDEwICsxNywxNyBAQA0KPiAgDQo+ICAjZGVm
aW5lIERJU1BfQUFMX0VOCQkJCTB4MDAwMA0KPiAgI2RlZmluZSBBQUxfRU4JCQkJCQlCSVQoMCkN
Cj4gKyNkZWZpbmUgRElTUF9BQUxfQ0ZHCQkJCTB4MDAyMA0KPiArI2RlZmluZSBBQUxfR0FNTUFf
TFVUX0VOCQkJCUJJVCgxKQ0KPiAgI2RlZmluZSBESVNQX0FBTF9TSVpFCQkJCTB4MDAzMA0KPiAg
I2RlZmluZSBESVNQX0FBTF9TSVpFX0hTSVpFCQkJCUdFTk1BU0soMjgsIDE2KQ0KPiAgI2RlZmlu
ZSBESVNQX0FBTF9TSVpFX1ZTSVpFCQkJCUdFTk1BU0soMTIsIDApDQo+ICAjZGVmaW5lIERJU1Bf
QUFMX09VVFBVVF9TSVpFCQkJMHgwNGQ4DQo+ICsjZGVmaW5lIERJU1BfQUFMX0dBTU1BX0xVVAkJ
CTB4MDcwMA0KPiArI2RlZmluZSBESVNQX0FBTF9HQU1NQV9MVVRfUgkJCQlHRU5NQVNLKDI5LCAy
MCkNCj4gKyNkZWZpbmUgRElTUF9BQUxfR0FNTUFfTFVUX0cJCQkJR0VOTUFTSygxOSwgMTApDQo+
ICsjZGVmaW5lIERJU1BfQUFMX0dBTU1BX0xVVF9CCQkJCUdFTk1BU0soOSwgMCkNCj4gKyNkZWZp
bmUgRElTUF9BQUxfTFVUX0JJVFMJCQkxMA0KPiAgI2RlZmluZSBESVNQX0FBTF9MVVRfU0laRQkJ
CTUxMg0KPiAgDQo+ICBzdHJ1Y3QgbXRrX2Rpc3BfYWFsX2RhdGEgew0KPiBAQCAtODAsOSArODcs
MzkgQEAgdW5zaWduZWQgaW50IG10a19hYWxfZ2FtbWFfZ2V0X2x1dF9zaXplKHN0cnVjdA0KPiBk
ZXZpY2UgKmRldikNCj4gIHZvaWQgbXRrX2FhbF9nYW1tYV9zZXQoc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUNCj4gKnN0YXRlKQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtf
ZGlzcF9hYWwgKmFhbCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArCXN0cnVjdCBkcm1fY29s
b3JfbHV0ICpsdXQ7DQo+ICsJdW5zaWduZWQgaW50IGk7DQo+ICsJdTMyIGNmZ192YWw7DQo+ICsN
Cj4gKwkvKiBJZiBnYW1tYSBpcyBub3Qgc3VwcG9ydGVkIGluIEFBTCwgZ28gb3V0IGltbWVkaWF0
ZWx5ICovDQo+ICsJaWYgKCEoYWFsLT5kYXRhICYmIGFhbC0+ZGF0YS0+aGFzX2dhbW1hKSkNCj4g
KwkJcmV0dXJuOw0KPiArDQo+ICsJLyogQWxzbywgaWYgdGhlcmUncyBubyBnYW1tYSBsdXQgdGhl
cmUncyBub3RoaW5nIHRvIGRvIGhlcmUuICovDQo+ICsJaWYgKCFzdGF0ZS0+Z2FtbWFfbHV0KQ0K
PiArCQlyZXR1cm47DQo+ICsNCj4gKwlsdXQgPSAoc3RydWN0IGRybV9jb2xvcl9sdXQgKilzdGF0
ZS0+Z2FtbWFfbHV0LT5kYXRhOw0KPiArCWZvciAoaSA9IDA7IGkgPCBESVNQX0FBTF9MVVRfU0la
RTsgaSsrKSB7DQo+ICsJCXN0cnVjdCBkcm1fY29sb3JfbHV0IGh3bHV0ID0gew0KPiArCQkJLnJl
ZCA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChsdXRbaV0ucmVkLA0KPiBESVNQX0FBTF9MVVRfQklU
UyksDQo+ICsJCQkuZ3JlZW4gPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W2ldLmdyZWVuLA0K
PiBESVNQX0FBTF9MVVRfQklUUyksDQo+ICsJCQkuYmx1ZSA9IGRybV9jb2xvcl9sdXRfZXh0cmFj
dChsdXRbaV0uYmx1ZSwNCj4gRElTUF9BQUxfTFVUX0JJVFMpDQo+ICsJCX07DQo+ICsJCXUzMiB3
b3JkOw0KPiArDQo+ICsJCXdvcmQgPSBGSUVMRF9QUkVQKERJU1BfQUFMX0dBTU1BX0xVVF9SLCBo
d2x1dC5yZWQpOw0KPiArCQl3b3JkIHw9IEZJRUxEX1BSRVAoRElTUF9BQUxfR0FNTUFfTFVUX0cs
IGh3bHV0LmdyZWVuKTsNCj4gKwkJd29yZCB8PSBGSUVMRF9QUkVQKERJU1BfQUFMX0dBTU1BX0xV
VF9CLCBod2x1dC5ibHVlKTsNCj4gKwkJd3JpdGVsKHdvcmQsIGFhbC0+cmVncyArIERJU1BfQUFM
X0dBTU1BX0xVVCArIGkgKiA0KTsNCj4gKwl9DQo+ICANCj4gLQlpZiAoYWFsLT5kYXRhICYmIGFh
bC0+ZGF0YS0+aGFzX2dhbW1hKQ0KPiAtCQltdGtfZ2FtbWFfc2V0X2NvbW1vbihOVUxMLCBhYWwt
PnJlZ3MsIHN0YXRlKTsNCj4gKwljZmdfdmFsID0gcmVhZGwoYWFsLT5yZWdzICsgRElTUF9BQUxf
Q0ZHKTsNCj4gKw0KPiArCS8qIEVuYWJsZSB0aGUgZ2FtbWEgdGFibGUgKi8NCj4gKwljZmdfdmFs
IHw9IEZJRUxEX1BSRVAoQUFMX0dBTU1BX0xVVF9FTiwgMSk7DQo+ICsNCj4gKwl3cml0ZWwoY2Zn
X3ZhbCwgYWFsLT5yZWdzICsgRElTUF9BQUxfQ0ZHKTsNCj4gIH0NCj4gIA0KPiAgdm9pZCBtdGtf
YWFsX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9kcnYuaA0KPiBpbmRleCBjYTM3NzI2NWU1ZWIuLjU0ZDM3MTJlMmFmZCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBAQCAtNTYsNyAr
NTYsNiBAQCB2b2lkIG10a19nYW1tYV9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25l
ZA0KPiBpbnQgdywNCj4gIAkJICAgICAgdW5zaWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0
ICpjbWRxX3BrdCk7DQo+ICB1bnNpZ25lZCBpbnQgbXRrX2dhbW1hX2dldF9sdXRfc2l6ZShzdHJ1
Y3QgZGV2aWNlICpkZXYpOw0KPiAgdm9pZCBtdGtfZ2FtbWFfc2V0KHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGRybV9jcnRjX3N0YXRlDQo+ICpzdGF0ZSk7DQo+IC12b2lkIG10a19nYW1tYV9z
ZXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCBfX2lvbWVtICpyZWdzLA0KPiBzdHJ1
Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRlKTsNCj4gIHZvaWQgbXRrX2dhbW1hX3N0YXJ0KHN0cnVj
dCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19nYW1tYV9zdG9wKHN0cnVjdCBkZXZpY2UgKmRl
dik7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9nYW1tYS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMN
Cj4gaW5kZXggODFjMDQ1MThhNWViLi4wOTI5Zjg4MzBkNmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IEBAIC02OSw0MSArNjksMjggQEAgdW5z
aWduZWQgaW50IG10a19nYW1tYV9nZXRfbHV0X3NpemUoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0K
PiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IC12b2lkIG10a19nYW1tYV9zZXRfY29tbW9uKHN0
cnVjdCBkZXZpY2UgKmRldiwgdm9pZCBfX2lvbWVtICpyZWdzLA0KPiBzdHJ1Y3QgZHJtX2NydGNf
c3RhdGUgKnN0YXRlKQ0KPiArdm9pZCBtdGtfZ2FtbWFfc2V0KHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gIHsNCj4gLQlzdHJ1Y3QgbXRrX2Rpc3Bf
Z2FtbWEgKmdhbW1hOw0KPiArCXN0cnVjdCBtdGtfZGlzcF9nYW1tYSAqZ2FtbWEgPSBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsNCj4gIAl1bnNpZ25lZCBpbnQgaTsNCj4gIAlzdHJ1Y3QgZHJtX2NvbG9y
X2x1dCAqbHV0Ow0KPiAgCXZvaWQgX19pb21lbSAqbHV0X2Jhc2U7DQo+IC0JYm9vbCBsdXRfZGlm
ZjsNCj4gLQl1MTYgbHV0X3NpemU7DQo+ICAJdTMyIGNmZ192YWwsIHdvcmQ7DQo+ICANCj4gIAkv
KiBJZiB0aGVyZSdzIG5vIGdhbW1hIGx1dCB0aGVyZSdzIG5vdGhpbmcgdG8gZG8gaGVyZS4gKi8N
Cj4gIAlpZiAoIXN0YXRlLT5nYW1tYV9sdXQpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAtCS8qIElm
IHdlJ3JlIGNhbGxlZCBmcm9tIEFBTCwgZGV2IGlzIE5VTEwgKi8NCj4gLQlnYW1tYSA9IGRldiA/
IGRldl9nZXRfZHJ2ZGF0YShkZXYpIDogTlVMTDsNCj4gLQ0KPiAtCWlmIChnYW1tYSAmJiBnYW1t
YS0+ZGF0YSkgew0KPiAtCQlsdXRfZGlmZiA9IGdhbW1hLT5kYXRhLT5sdXRfZGlmZjsNCj4gLQkJ
bHV0X3NpemUgPSBnYW1tYS0+ZGF0YS0+bHV0X3NpemU7DQo+IC0JfSBlbHNlIHsNCj4gLQkJbHV0
X2RpZmYgPSBmYWxzZTsNCj4gLQkJbHV0X3NpemUgPSA1MTI7DQo+IC0JfQ0KPiAtDQo+IC0JbHV0
X2Jhc2UgPSByZWdzICsgRElTUF9HQU1NQV9MVVQ7DQo+ICsJbHV0X2Jhc2UgPSBnYW1tYS0+cmVn
cyArIERJU1BfR0FNTUFfTFVUOw0KPiAgCWx1dCA9IChzdHJ1Y3QgZHJtX2NvbG9yX2x1dCAqKXN0
YXRlLT5nYW1tYV9sdXQtPmRhdGE7DQo+IC0JZm9yIChpID0gMDsgaSA8IGx1dF9zaXplOyBpKysp
IHsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgZ2FtbWEtPmRhdGEtPmx1dF9zaXplOyBpKyspIHsNCj4g
IAkJc3RydWN0IGRybV9jb2xvcl9sdXQgZGlmZiwgaHdsdXQ7DQo+ICANCj4gIAkJaHdsdXQucmVk
ID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGx1dFtpXS5yZWQsIDEwKTsNCj4gIAkJaHdsdXQuZ3Jl
ZW4gPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W2ldLmdyZWVuLCAxMCk7DQo+ICAJCWh3bHV0
LmJsdWUgPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W2ldLmJsdWUsIDEwKTsNCj4gIA0KPiAt
CQlpZiAoIWx1dF9kaWZmIHx8IChpICUgMiA9PSAwKSkgew0KPiArCQlpZiAoIWdhbW1hLT5kYXRh
LT5sdXRfZGlmZiB8fCAoaSAlIDIgPT0gMCkpIHsNCj4gIAkJCXdvcmQgPSBGSUVMRF9QUkVQKERJ
U1BfR0FNTUFfTFVUXzEwQklUX1IsDQo+IGh3bHV0LnJlZCk7DQo+ICAJCQl3b3JkIHw9IEZJRUxE
X1BSRVAoRElTUF9HQU1NQV9MVVRfMTBCSVRfRywNCj4gaHdsdXQuZ3JlZW4pOw0KPiAgCQkJd29y
ZCB8PSBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0IsDQo+IGh3bHV0LmJsdWUpOw0K
PiBAQCAtMTI0LDE5ICsxMTEsMTIgQEAgdm9pZCBtdGtfZ2FtbWFfc2V0X2NvbW1vbihzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+IHZvaWQgX19pb21lbSAqcmVncywgc3RydWN0IGRybV9jcnQNCj4gIAkJ
d3JpdGVsKHdvcmQsIChsdXRfYmFzZSArIGkgKiA0KSk7DQo+ICAJfQ0KPiAgDQo+IC0JY2ZnX3Zh
bCA9IHJlYWRsKHJlZ3MgKyBESVNQX0dBTU1BX0NGRyk7DQo+ICsJY2ZnX3ZhbCA9IHJlYWRsKGdh
bW1hLT5yZWdzICsgRElTUF9HQU1NQV9DRkcpOw0KPiAgDQo+ICAJLyogRW5hYmxlIHRoZSBnYW1t
YSB0YWJsZSAqLw0KPiAgCWNmZ192YWwgfD0gRklFTERfUFJFUChHQU1NQV9MVVRfRU4sIDEpOw0K
PiAgDQo+IC0Jd3JpdGVsKGNmZ192YWwsIHJlZ3MgKyBESVNQX0dBTU1BX0NGRyk7DQo+IC19DQo+
IC0NCj4gLXZvaWQgbXRrX2dhbW1hX3NldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1f
Y3J0Y19zdGF0ZSAqc3RhdGUpDQo+IC17DQo+IC0Jc3RydWN0IG10a19kaXNwX2dhbW1hICpnYW1t
YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAtDQo+IC0JbXRrX2dhbW1hX3NldF9jb21tb24o
ZGV2LCBnYW1tYS0+cmVncywgc3RhdGUpOw0KPiArCXdyaXRlbChjZmdfdmFsLCBnYW1tYS0+cmVn
cyArIERJU1BfR0FNTUFfQ0ZHKTsNCj4gIH0NCj4gIA0KPiAgdm9pZCBtdGtfZ2FtbWFfY29uZmln
KHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo=
