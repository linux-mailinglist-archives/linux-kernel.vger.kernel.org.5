Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A557C7C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjJMEBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMEBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:01:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D5CB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 21:01:08 -0700 (PDT)
X-UUID: 1db5fe7a697d11ee8051498923ad61e6-20231013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lQMv3cKvh6BNNi+v/v9mrtO/yxE2SJI7synzU3Ou+Yc=;
        b=NQcEEujNbG44A82zTaq/4zLtgDEX/1D/AXkJYSQ1q0Z3J8Hq+nr8V94Mu7a2CD45u4pvcU9oMPy3SEVrsqNMWxCr9PaYxvuteY/sUaN0xPCItM7MFa8b8Q7lsZkZVM7efxgssSqXRmWd+4gNw6huFgOQDDF3s5Ib6Y8mqyMRk3g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ff76ef08-4064-4b33-8fa0-2a3861bfa1bd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:d057e1bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1db5fe7a697d11ee8051498923ad61e6-20231013
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 396177429; Fri, 13 Oct 2023 12:00:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Oct 2023 12:00:57 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Oct 2023 12:00:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwdhwxDi0CPg07IoepTmUJqRicTYjIg5JpeytfSP/W05owxgTyBMEjURQqtNVCqwCZTW7Ub6zLIPbdieswox8rBr/Yw8m8kOUSnxLn6UcGclUHN+Kfwy6Dr52fX5rUHcl1eCtXMrQ5pknQ37WmbDmQSdqu8HL8OSlZj8e7LkhkbJ4wZlO6eCmwo/lja3m9rjWBTNv6Qb4vI+j2y4ydL9cyHNM3VWX5+a3qLENb8f3/Kew69ZqwcBasZ3fA0qMaTHhJX73AnXamIt1JtYzdqUVyWtHV4ld2KHOIDXLlyuHfkpHMpXWYxtfYnLu1u4+JZZBIKYlmFJuSF3JUggL6gOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQMv3cKvh6BNNi+v/v9mrtO/yxE2SJI7synzU3Ou+Yc=;
 b=GbYA13hQlhroHERUfqq3JgXeKql6luQzNa7zaw0NouCKmqRQnsuaiCRh7Hiu7Dn5ECHhz0LWeb7UjniAs7bqiu9u8/0GS/+bo3K2p1b0DV/5bPHdWIqjhF79LayLufDKNJ8u+jxmd/xaIx5xsLrshkX1BvW3UbQ8xqMS63hDGmIQH9lX4w1CfQzBC6f1QksOxTdhrUqLKNu10dBCJtDct2SQeH7nJ5EEDg/9XHFtoWegtgEx0xaFEtyb8kmypk+s1pTzJmrsbTDsFo5rV72UPnE8reb2fcpzWGAPtmRMdcI2DPF0GA8uofvR5/GWnn4VLXX3HHzR5hkW/2APq2uzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQMv3cKvh6BNNi+v/v9mrtO/yxE2SJI7synzU3Ou+Yc=;
 b=px/nCTvqRh+s/FCM/TruHo3+NkJqh4kR2/mfoY/CezaqlEMA76Pv7w/PIPU30Z8YTh2lrKn6oJO0pm/WX4ClFn4fu0YJqln70zM3Gbynf4OpNEfqTPrN698Aa/+1XE/ZpnDvJu0Y417Kf6fuBN8ZqTxtgC6fTSjYd3/WUdDEg2g=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8147.apcprd03.prod.outlook.com (2603:1096:990:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 04:00:55 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 04:00:55 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v11 06/16] drm/mediatek: gamma: Use bitfield macros
Thread-Topic: [PATCH v11 06/16] drm/mediatek: gamma: Use bitfield macros
Thread-Index: AQHZ/PLGggVzGm7beUC6mczPU5IBY7BHGdMA
Date:   Fri, 13 Oct 2023 04:00:54 +0000
Message-ID: <3399bf15a6e3d3d4ed5228c858b06c7b28b40aea.camel@mediatek.com>
References: <20231012095736.100784-1-angelogioacchino.delregno@collabora.com>
         <20231012095736.100784-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231012095736.100784-7-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8147:EE_
x-ms-office365-filtering-correlation-id: 61eb4ad4-c1b5-41c6-0717-08dbcba0ffc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNA0/cHqGPuabvQbVR5ZB15A4kGURRSfrQCx+JG+G6R4N+yFc/DiAwUUKwikI/CyKBAr55gcBmHlqtc54yETsGNidqj6y2bB0fHbJ/mF/rtyWYmT23OocSMPU55dUei+1S1PpGo1+UUJURz+BE967WGLb8L2e3IMl7mKXe1dfB0uCX159WOrn8d/UciwjbIC1ePdaqFdQHkFY5h+XauqwBPL3SzVfn4cpkkFV2gb6BYNy6MhajMHcP53EBu5hvQeVeZFBFUh1E6CF46kv4nQrSj4rtn+hsqfNUj83//M8pbDe/IzNoLSxL1EL+A8zxf2TwJnkIgxN7yDuZQOg4VDH+jdV3EWKaMxSrECSw06/TsV6z7Kg5Iiy7Sbzskaa/j93GUbt4z2oE+/7nr4b12aNYv94qwLjyvKspE0f2TdykSZTjE20Gg1BkVlE5F+WHrrxLRGQ18Qf9rOcOj66yPtL6GqqLmbCaiN1o/OViwMTi/2LWEeMG9YEFdBihqaV7SXzOo3KTa3Et4dzz9TZmYnq2Nui4s0irJ5P6a8f/srjER9EsecHu1vHN++FZFxDm3IP73vjUq7asYZr/LV/YexzQ8hrv99Qguq9ZwkuVRW2afGmcr5tad5NrxLdCmmrMD3k43aSqN2MMb4Tx02Kr/51AXu44iZK7qu49bQgoyfOw8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(8676002)(4326008)(41300700001)(71200400001)(5660300002)(7416002)(2906002)(83380400001)(4001150100001)(85182001)(38100700002)(36756003)(86362001)(38070700005)(122000001)(8936002)(26005)(2616005)(316002)(64756008)(54906003)(66446008)(66476007)(110136005)(66946007)(66556008)(76116006)(478600001)(6512007)(6486002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0lzNm1XZGVySDl0TnlGOXZ0eGlvSjhtclprOWVyRSt4bU9rV2N1ZjNBdVNh?=
 =?utf-8?B?ZjlGelQwMklDaEd6QzRuajVUSytQSGxHeFhPd1p2T2FoTlBFTTNrQzN4cmZk?=
 =?utf-8?B?UHhoQzNvckpKbXNpbHpKUGlNTHlIdzBKa25XVFpqanN4VjRrdlVObUtrR1Bm?=
 =?utf-8?B?RWR3R292eW8vVEVQUUFRR2tOK0cyOUMzUEhQMzRFK3hCSTNSOTE0bVlndWlW?=
 =?utf-8?B?cVY4cEk4Zmt3Yk11U242bzduMkRIY04zWXpDL3E1Zm1JUkhnK0N6RDZWWXlD?=
 =?utf-8?B?UVI5SS9pNUNDRUFGK1VJWmlKT0NBUzJuUTJlK2UrcFFvT3AySFRvaWVZaktM?=
 =?utf-8?B?aGVmd3loRnhnVEs1a1pZa0o1d2s5U0plVVRRbU5ZbnNPLzdjVWVJUmpwQnd4?=
 =?utf-8?B?cG1nRjVzbDI2azBER2VqdHVLV3NSMkZlY1BnWnFJMHU3Z2h3UHpWa2VtOGhQ?=
 =?utf-8?B?dzVoL2ZPUEtNVnhjNFltQW1Fc2FHdlpEMVlhOERJK0dLZ0xHRXZ6Y0lnbHBZ?=
 =?utf-8?B?ckx0Y0dsc2EwSzg0QmFXWkQ0UExQM3A0RzJFUFA2Tk1zQ01zWCsvL0gzekVv?=
 =?utf-8?B?TC8wbjQ3VGttNzA2OW10M3VJd0lzdzlDWDQ1ekE0d3poQVNiYXZkZzEzTmpO?=
 =?utf-8?B?TzJ5cUZqSndCU1d6MkdxQ2svSG1mOGI2L21laXFlNDRrRTdNeENDUmpTdTJN?=
 =?utf-8?B?SGdFTU1pMUU2SXZZdU9iRW1CNXExeWVnRDZtMml6SkhPNG9jR2VLTDl5bC8z?=
 =?utf-8?B?NUhtNzFjZDU5bkxjRHg4K2FLTmp3dFhMdTZRbnhUcmhpRmZ0OWVSVHdodlE0?=
 =?utf-8?B?cW1jOW1Qb0M0RVIxODRtN1RtcTE3bHh4aE5seW8xcTFKTzhadVlNd0M2WVIr?=
 =?utf-8?B?K3ZQd1VCVWZjdG8wVjBFWldQZHkvZ2xCYmMwSzFOS3RYVEVLVjVXclN0OE9h?=
 =?utf-8?B?TmJ1RnV2N0hsNWdIOG9wN2FISkZRWENlcHoxT2lNbTdPZ2g1cFg3ZSt6SUxP?=
 =?utf-8?B?dXhCdHF5SWFvNnpLVm10U3dFWEI2cXFoRE93N29WbnY4MCsxb214WElnd3d3?=
 =?utf-8?B?eEFwZmdhRmQ0NTlVQVlGNWJsQjY3T0VTNk1SVGliamlUMTVvckc3emNhcVdm?=
 =?utf-8?B?QUpiWEFsQ0JoQmw3V1Q1V2VHZjc5WmJ3bXZoL3JCQU94L2YrVDdJNFF5VkI2?=
 =?utf-8?B?OFpUWGxoMk92ZElhaHlPVW1VM0k3b09YRkNPbWJVYUpwbzdab21ZZ3ZWWlpF?=
 =?utf-8?B?QjltUEJEbkhLTGNTV2Y0Z2hCZEcrUmJ3aEhMK0Z5alpVS2Fya1NLOFpNQ3Nx?=
 =?utf-8?B?Q2VTVXF6Y2VJeW91Skh5NFNJRzd5bHNyR0hCS25UTnA1V0hoaGxTcVFheTJW?=
 =?utf-8?B?RnYxUXltMmp4eGdJZlRjZ3N5cDNUK2tkbXZMVVRSLzF1Y0wyUGFkVVdPcVc2?=
 =?utf-8?B?WW5CTGJTRTFYUThNVVVNVW1PZ0FwL3A5VHlNTk96R1RNZndYMkgxYjNoT1R4?=
 =?utf-8?B?QUFLZVh1QXRxejVMU3o4RW5ycFk2RUpLblAyNVovZFY2TkpyK1B1SVhKVFpP?=
 =?utf-8?B?eUdyV00rMkVnYU5vL2xNU05KaFIyZHNBSW1qeG93aUExMEplYm82RHM4UCt6?=
 =?utf-8?B?bWpGcGRDUDNBWU1DQTBCcmg5YldUODZPNHhNWExDaXM5eWFLZjVsV0tyWDgz?=
 =?utf-8?B?anR0UFhta3lBLzMvOC9peVIwWFNNSGZIOXIzZmJuMUVYK2Uwejh0VDdqbk5T?=
 =?utf-8?B?MUdvZm13dkkrY2Q2TzNKRnNESGhuMjBYT0l6dDNmSm0vSXpzSmVwMk9Lc1pJ?=
 =?utf-8?B?M1VpdnhVMlpJWDNublovTVFEU2NsR2RLYWZsZTFkc1JQdk9mQmhPa2JVRjM2?=
 =?utf-8?B?ZndXa2h0ZkovZUV0MHByRnVGdTBwMWc3YzVyQmFEbERJaExJbjRMbDA0SnA1?=
 =?utf-8?B?andWeHJrb3djdWk4eStPN3Q4VGlLZVpEdzhHdUppL2dzRnczTnhsdkxBRVRJ?=
 =?utf-8?B?WkdEZ3NPUXEvODVHektSQ3U2d0V3SWx6QnVsWGUwT1Znd2RGMnk2bmNrTjZm?=
 =?utf-8?B?S2U1K21BWFkzU2dUb0hyeG42Rk5IU1ZpczZTWUhWUWlJdkY2NTg4N2dNam9r?=
 =?utf-8?Q?T0kb9pSng0xv0U8NJJpGFSQE/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <288301DC017E2541A59787529A10DD04@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61eb4ad4-c1b5-41c6-0717-08dbcba0ffc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 04:00:54.9300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrFExGo44Xeh9QALs3v+Jz7HN/x6P0H9CqSaNS8Q8ZDbp7wXHi7Nc8uAiF5z80pbGaJ4f07VlL+D9b8HTt1ErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8147
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTEwLTEyIGF0IDExOjU3ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTWFrZSB0aGUgY29kZSBtb3JlIHJvYnVzdCBh
bmQgaW1wcm92ZSByZWFkYWJpbGl0eSBieSB1c2luZyBiaXRmaWVsZA0KPiBtYWNyb3MgaW5zdGVh
ZCBvZiBvcGVuIGNvZGluZyBiaXQgb3BlcmF0aW9ucy4NCj4gV2hpbGUgYXQgaXQsIGFsc28gYWRk
IGEgZGVmaW5pdGlvbiBmb3IgTFVUX0JJVFNfREVGQVVMVC4NCg0KV2hlbiBJIGFwcGx5LCBJIHdv
dWxkIHJlbW92ZSB0aGUgZGVzY3JpcHRpb24gb2YgTFVUX0JJVFNfREVGQVVMVC4NCg0KUmV2aWV3
ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFJldmlld2VkLWJ5OiBK
YXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IFJldmlld2VkLWJ5OiBB
bGV4YW5kcmUgTWVyZ25hdCA8YW1lcmduYXRAYmF5bGlicmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVn
bm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfZ2FtbWEuYyB8IDI4ICsrKysrKysrKysrKysrKy0tLS0NCj4gLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiBpbmRleCBkMzVlYWY2ZGJj
MmQuLjgxYzA0NTE4YTVlYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX2dhbW1hLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX2dhbW1hLmMNCj4gQEAgLTMsNiArMyw3IEBADQo+ICAgKiBDb3B5cmlnaHQgKGMpIDIwMjEg
TWVkaWFUZWsgSW5jLg0KPiAgICovDQo+ICANCj4gKyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5o
Pg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2NvbXBvbmVu
dC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiBAQCAtMjEsOCArMjIsMTQgQEAN
Cj4gICNkZWZpbmUgR0FNTUFfTFVUX0VOCQkJCQlCSVQoMSkNCj4gICNkZWZpbmUgR0FNTUFfRElU
SEVSSU5HCQkJCQlCSVQoMikNCj4gICNkZWZpbmUgRElTUF9HQU1NQV9TSVpFCQkJCTB4MDAzMA0K
PiArI2RlZmluZSBESVNQX0dBTU1BX1NJWkVfSFNJWkUJCQkJR0VOTUFTSw0KPiAoMjgsIDE2KQ0K
PiArI2RlZmluZSBESVNQX0dBTU1BX1NJWkVfVlNJWkUJCQkJR0VOTUFTSw0KPiAoMTIsIDApDQo+
ICAjZGVmaW5lIERJU1BfR0FNTUFfTFVUCQkJCTB4MDcwMA0KPiAgDQo+ICsjZGVmaW5lIERJU1Bf
R0FNTUFfTFVUXzEwQklUX1IJCQlHRU5NQVNLKDI5LCAyMCkNCj4gKyNkZWZpbmUgRElTUF9HQU1N
QV9MVVRfMTBCSVRfRwkJCUdFTk1BU0soMTksIDEwKQ0KPiArI2RlZmluZSBESVNQX0dBTU1BX0xV
VF8xMEJJVF9CCQkJR0VOTUFTSyg5LCAwKQ0KPiArDQo+ICBzdHJ1Y3QgbXRrX2Rpc3BfZ2FtbWFf
ZGF0YSB7DQo+ICAJYm9vbCBoYXNfZGl0aGVyOw0KPiAgCWJvb2wgbHV0X2RpZmY7DQo+IEBAIC05
Nyw5ICsxMDQsOSBAQCB2b2lkIG10a19nYW1tYV9zZXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRl
diwgdm9pZA0KPiBfX2lvbWVtICpyZWdzLCBzdHJ1Y3QgZHJtX2NydA0KPiAgCQlod2x1dC5ibHVl
ID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGx1dFtpXS5ibHVlLCAxMCk7DQo+ICANCj4gIAkJaWYg
KCFsdXRfZGlmZiB8fCAoaSAlIDIgPT0gMCkpIHsNCj4gLQkJCXdvcmQgPSBod2x1dC5yZWQgPDwg
MjAgKw0KPiAtCQkJICAgICAgIGh3bHV0LmdyZWVuIDw8IDEwICsNCj4gLQkJCSAgICAgICBod2x1
dC5yZWQ7DQo+ICsJCQl3b3JkID0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9SLA0K
PiBod2x1dC5yZWQpOw0KPiArCQkJd29yZCB8PSBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEw
QklUX0csDQo+IGh3bHV0LmdyZWVuKTsNCj4gKwkJCXdvcmQgfD0gRklFTERfUFJFUChESVNQX0dB
TU1BX0xVVF8xMEJJVF9CLA0KPiBod2x1dC5ibHVlKTsNCj4gIAkJfSBlbHNlIHsNCj4gIAkJCWRp
ZmYucmVkID0gbHV0W2ldLnJlZCAtIGx1dFtpIC0gMV0ucmVkOw0KPiAgCQkJZGlmZi5yZWQgPSBk
cm1fY29sb3JfbHV0X2V4dHJhY3QoZGlmZi5yZWQsIDEwKTsNCj4gQEAgLTExMCw5ICsxMTcsOSBA
QCB2b2lkIG10a19nYW1tYV9zZXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gdm9pZCBf
X2lvbWVtICpyZWdzLCBzdHJ1Y3QgZHJtX2NydA0KPiAgCQkJZGlmZi5ibHVlID0gbHV0W2ldLmJs
dWUgLSBsdXRbaSAtIDFdLmJsdWU7DQo+ICAJCQlkaWZmLmJsdWUgPSBkcm1fY29sb3JfbHV0X2V4
dHJhY3QoZGlmZi5ibHVlLA0KPiAxMCk7DQo+ICANCj4gLQkJCXdvcmQgPSBkaWZmLmJsdWUgPDwg
MjAgKw0KPiAtCQkJICAgICAgIGRpZmYuZ3JlZW4gPDwgMTAgKw0KPiAtCQkJICAgICAgIGRpZmYu
cmVkOw0KPiArCQkJd29yZCA9IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9MVVRfMTBCSVRfUiwNCj4g
ZGlmZi5yZWQpOw0KPiArCQkJd29yZCB8PSBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklU
X0csDQo+IGRpZmYuZ3JlZW4pOw0KPiArCQkJd29yZCB8PSBGSUVMRF9QUkVQKERJU1BfR0FNTUFf
TFVUXzEwQklUX0IsDQo+IGRpZmYuYmx1ZSk7DQo+ICAJCX0NCj4gIAkJd3JpdGVsKHdvcmQsIChs
dXRfYmFzZSArIGkgKiA0KSk7DQo+ICAJfQ0KPiBAQCAtMTIwLDcgKzEyNyw3IEBAIHZvaWQgbXRr
X2dhbW1hX3NldF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LA0KPiB2b2lkIF9faW9tZW0gKnJl
Z3MsIHN0cnVjdCBkcm1fY3J0DQo+ICAJY2ZnX3ZhbCA9IHJlYWRsKHJlZ3MgKyBESVNQX0dBTU1B
X0NGRyk7DQo+ICANCj4gIAkvKiBFbmFibGUgdGhlIGdhbW1hIHRhYmxlICovDQo+IC0JY2ZnX3Zh
bCB8PSBHQU1NQV9MVVRfRU47DQo+ICsJY2ZnX3ZhbCB8PSBGSUVMRF9QUkVQKEdBTU1BX0xVVF9F
TiwgMSk7DQo+ICANCj4gIAl3cml0ZWwoY2ZnX3ZhbCwgcmVncyArIERJU1BfR0FNTUFfQ0ZHKTsN
Cj4gIH0NCj4gQEAgLTEzNyw5ICsxNDQsMTIgQEAgdm9pZCBtdGtfZ2FtbWFfY29uZmlnKHN0cnVj
dCBkZXZpY2UgKmRldiwNCj4gdW5zaWduZWQgaW50IHcsDQo+ICAJCSAgICAgIHVuc2lnbmVkIGlu
dCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpDQo+ICB7DQo+ICAJc3RydWN0IG10a19k
aXNwX2dhbW1hICpnYW1tYSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArCXUzMiBzejsNCj4g
Kw0KPiArCXN6ID0gRklFTERfUFJFUChESVNQX0dBTU1BX1NJWkVfSFNJWkUsIHcpOw0KPiArCXN6
IHw9IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9TSVpFX1ZTSVpFLCBoKTsNCj4gIA0KPiAtCW10a19k
ZHBfd3JpdGUoY21kcV9wa3QsIGggPDwgMTYgfCB3LCAmZ2FtbWEtPmNtZHFfcmVnLCBnYW1tYS0N
Cj4gPnJlZ3MsDQo+IC0JCSAgICAgIERJU1BfR0FNTUFfU0laRSk7DQo+ICsJbXRrX2RkcF93cml0
ZShjbWRxX3BrdCwgc3osICZnYW1tYS0+Y21kcV9yZWcsIGdhbW1hLT5yZWdzLA0KPiBESVNQX0dB
TU1BX1NJWkUpOw0KPiAgCWlmIChnYW1tYS0+ZGF0YSAmJiBnYW1tYS0+ZGF0YS0+aGFzX2RpdGhl
cikNCj4gIAkJbXRrX2RpdGhlcl9zZXRfY29tbW9uKGdhbW1hLT5yZWdzLCAmZ2FtbWEtPmNtZHFf
cmVnLA0KPiBicGMsDQo+ICAJCQkJICAgICAgRElTUF9HQU1NQV9DRkcsIEdBTU1BX0RJVEhFUklO
RywNCj4gY21kcV9wa3QpOw0K
