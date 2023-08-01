Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D678376A725
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjHACob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjHACoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:44:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3F1FC6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:44:12 -0700 (PDT)
X-UUID: 48c744e4301511eeb20a276fd37b9834-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=aJ6EdSljvVkIwR0KI2rQFT4N7p/nj5ylA4DZnVOzyPE=;
        b=dPNwjlOs2ZPT5iKwuRo5xLFnY4pA2LJnrtZMvJ8Zf7QE2oCRdQM+pIBtYzVxOtAK00y9k4jxg8Zz1pwkGd/4NyK3M4vib3cC71+LVu7i75xx4To9pH0AiBVg59o6cKlz4nqqWU9JxZn9dt7WxGWxDEySiVcjo6nsbmvQImwm/Ug=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:85c90baf-c6c3-4030-89b8-c06e3707faec,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:1d4301b4-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 48c744e4301511eeb20a276fd37b9834-20230801
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 663348762; Tue, 01 Aug 2023 10:44:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 10:44:06 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 10:44:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP3EVplUpVNPzvfuFWUk0ovupt5wmIWm+QAFUaG1wLtNm1D/7M1Rbm5DKAiCVlt3OQiiWZqXjkehSVoPNVNH8L8QCjb/sazzEK0mcFvfvQX/T7nS2EiyIPmaxogibZZaYgPTEYxLEFeTzu73gSwjDfBKWsWTp6madOSAt6D2ZFTCXcjevHD1ZScTJlDhQob7ZMUTk/F3lB25PyrkvWjZr95ozHPLOctWpqXsr6MsPU1VNHNlo5Tswh6SFb/bgD//0F2aWbBi6FzM4PhlvEdUsm2wTk72P3TfL1ibiadB5m+ROLiCsN5Z55ctcIgAm/U/cxuvTp5eTyaPhHFMvoRMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ6EdSljvVkIwR0KI2rQFT4N7p/nj5ylA4DZnVOzyPE=;
 b=ofFFjIegsRNqL/LypA5rDgRNbhxfeu7qYh9TaDs7zkBtucYMmXGdnE7Tzm/a/wZVLutO4GizHaEmk5gaPogsltDyH06ElUpuxCSgp7+FjB2Aapj9LxRipPFukQqJsw+FkKl2wczoYxoGgmNdVvfOf+zWL9wa43o+3JHbYfAP3Pmf+xrZz7WBngkBj7DSaXGf3nKGjLLkXucoGPZKeQjZ0DTs5DvGzgx2/BmfsWYLY2GMnFdgA3HX8sPW9H3Q8eiEBkw2VUS3z1nglduW8AJQaGiIXQGxEHslIXHcgeQNAPX6zkb5NMk6vIK2nen3/q23IZ0RoPK/FQit70ROxAkqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ6EdSljvVkIwR0KI2rQFT4N7p/nj5ylA4DZnVOzyPE=;
 b=RHudeBBS96qzrwgq6mnGKnuTPhScAckS/7eIPlCzEg4Z3/hLXV9jrwiiSiBp83X5dRgQqaSSMrrQhjsRkjsDhErjAWbCTBG6c4CiCVYf8+l82f6T/F5YZ9cF8X0QSJhPgbx4kyz8w1NbDD/LLhYD+Dgv8lTXaGqmCqxc2ROJVXs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB5507.apcprd03.prod.outlook.com (2603:1096:820:50::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 02:43:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 02:43:03 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v7 03/13] drm/mediatek: gamma: Support SoC specific LUT
 size
Thread-Topic: [PATCH v7 03/13] drm/mediatek: gamma: Support SoC specific LUT
 size
Thread-Index: AQHZw6/U0jXxApDFA0K0zyCfSIcgZa/UvGgA
Date:   Tue, 1 Aug 2023 02:43:02 +0000
Message-ID: <79ac432d198424671fb1cdeda52ae68d0497c9e7.camel@mediatek.com>
References: <20230731130441.173960-1-angelogioacchino.delregno@collabora.com>
         <20230731130441.173960-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230731130441.173960-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB5507:EE_
x-ms-office365-filtering-correlation-id: 901e63aa-a0d8-48dc-8613-08db923906e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4ZDyleliGOndlF3YDCbtOxtbXgJOBKibU2WV7hs+AxNhk5YG/vcb5PwG2YctUX8eq/oc4p7iedxIEBSq+QUlH/V14sG3zfl1HVlamnaAQVkSGrsZWMcEaagMOiPrS16vP8An2KnQlPgPU22scLg7wxgmj7MdBCRcMMbNSDh5UcxZa+IgtQO1QLsh3aTNp1TLUhCPHAKhno2xUJ0Ty3bozLL844PgnTigOD9CbjMHbEKrPATpdmAWrivVaYeE0UnIotgHTR5Dj1x+HGZH+q+Dlzllpv1eY4bYXInmbghaUKVBdERn1gmKc/FVIB7sL8AJKfpv6xcLs6fHhJc2hOy+ZW4Wi6XV77caaifhVKSAZ0vJ8mCcomNZFIagG3oD31LYsUIufzz1lGOtFrR4/GXVYsPwINDqn3YIaRy3qCyqOYJtUAET2wH9zApRsdDqVv6mU3JJwuOPDNCiSShlyNflIGPtwzDWfPNkxlrauooMWvesAlFGtz1x1vv082Agm9T3B6nefcQ3XY9rzj6sQjMyjR/BPA1pEcpC1O4OLdc+myl+zp+quSRyLsWr1v1JYZZDPKBuXqR192kkjRtiKjQiVU6xggbPolPOg/wf7jrjKew+8fRTYKxNhQtYBXQYa8eEDKa9DO7FpQEaaxI+/BqiLsiLSNITUHk8tCOqt0qlog=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(8936002)(8676002)(2616005)(86362001)(41300700001)(2906002)(83380400001)(36756003)(85182001)(5660300002)(186003)(7416002)(26005)(6506007)(66946007)(71200400001)(6486002)(122000001)(110136005)(54906003)(38100700002)(64756008)(66446008)(66476007)(66556008)(76116006)(4326008)(478600001)(38070700005)(316002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2lvRmdKR1krTzc5ZERSMlhZNmt0TVFsdkdNdWtLQlpPT2d6Tll3aklMakwy?=
 =?utf-8?B?cU5aNGxxMm5pa2tqY0NVWDZBdVlPQVN1TllkaklMODBLcVJJZTlTWm1sRy9D?=
 =?utf-8?B?MXFWSVZ2R1ZSQy9YYWZtZTMzbE1aNGZRQUdxcVcyM09kdTdUejVJejNPTUFI?=
 =?utf-8?B?c2lNS2haeWp5V1FxMHpZeFNPcitNZ0ZkR1AzamFRWEVkV2VRTWJUYW1mZitV?=
 =?utf-8?B?NlIyZHNQdnBkdWVWdzZWNW90OE1qWjB0ajVwZEhhOW92TWVFSGpZNFV0U2NJ?=
 =?utf-8?B?Q1RiTFROQnAvQzEwTzRxY05ZU010Q010NmtoVUUxbzU4ZFFmblJqOWYzQlJ4?=
 =?utf-8?B?V1dsUnJqcSt5Qm9rL0JMUmtNMDBpZWN3M3BHQ0ZXVDR6UW1OcEVqeTRXWjVF?=
 =?utf-8?B?dmtrOWJNQ0g3Si85TlFZVXhoT3pIMElyVFAxb0xndTJGSVlHcHF4L01RSldI?=
 =?utf-8?B?VFF3RjluZmZCZENFMmNtbm5sWHV3WWhXYUFjNU9nSXhKZGNkT05McXJsOTV2?=
 =?utf-8?B?eTZWU3RKcHFBQ1M2OE5jZHJ1SWF3L3VNNkdLRGRlZHM4N1pCWVJ6Z2J3b2t0?=
 =?utf-8?B?a0l0d2JPZE42NisyMk1ZU09mbTZvY2FrK3ppbTIwOWxzdDBpVTFRbEdjd2lS?=
 =?utf-8?B?Ulc2QTRVdzlZaGZQZXVJYWJtb1FISHpkQUwvZkR4bFVrZ3diUjY2THZmVVJJ?=
 =?utf-8?B?b3dUcE1SUzNTRWZwRlVSb0tQNnJ6Nk5zS3pSNEdTNndYb0tLS2ZIaWVsWHE3?=
 =?utf-8?B?MERQR1crOVJ3NFZ1WUUzNWJZbHFFZitVbmI1V1AyODB3bEFqVEZ0bkpUZmg3?=
 =?utf-8?B?dTd3MEVzR1dvZlBweWhReGduZm5FOHVFL2RaVWhIbk5vZm1NcmZGUlZRWFNH?=
 =?utf-8?B?YzlUQm8rQ2M4TEhwWW1aMlVRZzJZZDJkQ3NndHhVM3pHQWk4cHJBWXFKRkJ3?=
 =?utf-8?B?S09VbEZOdnhWdzhOdmt5MjIyUmRCZ2gzMVdRYkZWOXBLWFZOenV0WUFDblhL?=
 =?utf-8?B?Z0p3RHQ4TVNlV2dxYXE5aHh6czlZcCsxcVlTZStyOGJDdTY3M3E4RFdmVjhK?=
 =?utf-8?B?Rld0ckF3QXF6VFpGOS9wRFNrcHJtQXVCbXZPVDFnbGlDaFZiRWlndE5QcHFl?=
 =?utf-8?B?RnNVNWxtdERkSzR1RlBYUlhGcmI5TmRXQTlrTDhtNnFtYitSdUdNN1ZGY3ow?=
 =?utf-8?B?cE14Rk1VaFVOd1AzelB2TEc1bzZQbWRzK3hNM3IyQmxZYzVvcmlubDVQNWM5?=
 =?utf-8?B?U1VEelJvdkZiMC9jUnRnTWtFVGRxbk01T1VrYmI4eE1LVWVET1RxN3lYT1J5?=
 =?utf-8?B?a3lxNFdYalVwNzJ3Vy9ZVVdSN2lkeHlHbHFyUDlDR01HNDl6NkN6TkYxaFJ3?=
 =?utf-8?B?QnB1eE9hTDZMczcyUW5CaFM1SEY3WjBJT3JBbFlUT2l0Q1l5SzM3b2F1MEZj?=
 =?utf-8?B?TmFPaEhUYkNYNU1YMnNQdnlUd1FGc1Y3UXE1OFpXMmR4L0d4WmJ1d0NyQ0NT?=
 =?utf-8?B?OEpqSUtYSXhQUGQzdkQ4ZWQwV3hhVEZBbzQ0V2ZuSk9PSXU3SGplelVlN3Q3?=
 =?utf-8?B?ZWVrWkN4UGY2amxjTmVQNkhrNkRvS1ZsM2JlMWNkZjBFc1VVeEd3b1FtMTdn?=
 =?utf-8?B?VHdnemRSNzZYdVRlWTJGVmFJdFVMak90aDQ4bUhxakhjbUNqcXE4a0J5dndT?=
 =?utf-8?B?REZrYllUbGd1NmhCVFRmUjNPTndZaFlTR2VSZXVITHFnNE5PT1VUS3hFRlVj?=
 =?utf-8?B?UmN0dE1wazRpNE5RcXlzdVAzVExTUUdDbDRCbTgrZVJRZ2RBYnRrRjgwbDhw?=
 =?utf-8?B?QnJIUDdobFBEbVpYR3BuMm5BcFpOLzZQU0lSS3VvZnJHR2dEakR3S0dYWWV5?=
 =?utf-8?B?SC93bWNJdmJIcFpGbm8xUVFIMW8rdUtYa2haY2p4bDJvTjErZGp4MldCUllt?=
 =?utf-8?B?ZXplT212MHUwM0hKOGZXU0M5SU1SNnZ0T3FZTGpzc0YyUGFlMnBnd0dqZTVW?=
 =?utf-8?B?dm9SRlppaDQwV2R1dEl5V2hCbWIwY3JaTWVIejVITmM5dWhPQkFBeDlQTDFx?=
 =?utf-8?B?akJqbFpIaGF0VFI4eGNPdDN5VkdBeVkrL1JJZTlqNGtGc2Q3NklHRktQbXQ4?=
 =?utf-8?Q?rEPEbtoiX9pVbsE9kVHb5lFTW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D838053B09A1C41837F32089992A30C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901e63aa-a0d8-48dc-8613-08db923906e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 02:43:02.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0XNNuShbmbO/sBmk0mjf6DmLbeZajJyMhMsRwxtzG91OBlflEVvsCRZNqIQXh0F7+dqf6EEhK56YwS2jhS3/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5507
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gTW9uLCAyMDIzLTA3LTMxIGF0IDE1OjA0ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTmV3ZXIgU29DcyBzdXBwb3J0IGEgYmlnZ2Vy
IEdhbW1hIExVVCB0YWJsZTogd2lyZSB1cCBhIGNhbGxiYWNrDQo+IHRvIHJldHJpZXZlIHRoZSBj
b3JyZWN0IExVVCBzaXplIGZvciBlYWNoIGRpZmZlcmVudCBHYW1tYSBJUC4NCj4gDQo+IENvLWRl
dmVsb3BlZC1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+
IFtBbmdlbG86IFJld3JpdHRlbiBjb21taXQgbWVzc2FnZS9kZXNjcmlwdGlvbiArIHBvcnRpbmdd
DQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxv
Z2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBSZXZpZXdlZC1ieTogSmFzb24t
SkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiBSZXZpZXdlZC1ieTogQWxleGFu
ZHJlIE1lcmduYXQgPGFtZXJnbmF0QGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfYWFsLmMgICAgIHwgMTcgKysrKysrKysrKysrKystDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgIHwgIDIgKysNCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jICAgfCAyMyArKysrKysr
KysrKysrKysrKystDQo+IC0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmMgICAgIHwgIDggKysrKystLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5oICAgICB8ICAxIC0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcF9jb21wLmMgfCAgMiArKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuaCB8ICA5ICsrKysrKysrDQo+ICA3IGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2FhbC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX2FhbC5jDQo+IGluZGV4IDJmNjAyZjFmMWM0OS4uZTJlNDE1NWZhZjAxIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfYWFsLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2FhbC5jDQo+IEBAIC0xOSw3ICsxOSw3
IEBADQo+ICAjZGVmaW5lIEFBTF9FTgkJCQkJCUJJVCgwKQ0KPiAgI2RlZmluZSBESVNQX0FBTF9T
SVpFCQkJCTB4MDAzMA0KPiAgI2RlZmluZSBESVNQX0FBTF9PVVRQVVRfU0laRQkJCTB4MDRkOA0K
PiAtDQo+ICsjZGVmaW5lIERJU1BfQUFMX0xVVF9TSVpFCQkJNTEyDQo+ICANCj4gIHN0cnVjdCBt
dGtfZGlzcF9hYWxfZGF0YSB7DQo+ICAJYm9vbCBoYXNfZ2FtbWE7DQo+IEBAIC02MSw2ICs2MSwy
MSBAQCB2b2lkIG10a19hYWxfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQNCj4g
aW50IHcsDQo+ICAJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgdyA8PCAxNiB8IGgsICZhYWwtPmNt
ZHFfcmVnLCBhYWwtPnJlZ3MsIA0KPiBESVNQX0FBTF9PVVRQVVRfU0laRSk7DQo+ICB9DQo+ICAN
Cj4gKy8qKg0KPiArICogbXRrX2FhbF9nYW1tYV9nZXRfbHV0X3NpemUoKSAtIEdldCBnYW1tYSBM
VVQgc2l6ZSBmb3IgQUFMDQo+ICsgKiBAZGV2OiBQb2ludGVyIHRvIHN0cnVjdCBkZXZpY2UNCj4g
KyAqDQo+ICsgKiBSZXR1cm46IDAgaWYgZ2FtbWEgY29udHJvbCBub3Qgc3VwcG9ydGVkIGluIEFB
TCBvciBnYW1tYSBMVVQgc2l6ZQ0KPiArICovDQo+ICt1bnNpZ25lZCBpbnQgbXRrX2FhbF9nYW1t
YV9nZXRfbHV0X3NpemUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBtdGtf
ZGlzcF9hYWwgKmFhbCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJaWYgKGFhbC0+
ZGF0YSAmJiBhYWwtPmRhdGEtPmhhc19nYW1tYSkNCj4gKwkJcmV0dXJuIERJU1BfQUFMX0xVVF9T
SVpFOw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICB2b2lkIG10a19hYWxfZ2FtbWFfc2V0
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRybV9jcnRjX3N0YXRlDQo+ICpzdGF0ZSkNCj4g
IHsNCj4gIAlzdHJ1Y3QgbXRrX2Rpc3BfYWFsICphYWwgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBpbmRleCA3NTA0
NTkzMjM1M2UuLmNhMzc3MjY1ZTVlYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9kcnYuaA0KPiBAQCAtMTcsNiArMTcsNyBAQCB2b2lkIG10a19hYWxfY2xrX2Rpc2Fi
bGUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX2FhbF9jb25maWcoc3RydWN0IGRl
dmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywNCj4gIAkJICAgIHVuc2lnbmVkIGludCBoLCB1bnNp
Z25lZCBpbnQgdnJlZnJlc2gsDQo+ICAJCSAgICB1bnNpZ25lZCBpbnQgYnBjLCBzdHJ1Y3QgY21k
cV9wa3QgKmNtZHFfcGt0KTsNCj4gK3Vuc2lnbmVkIGludCBtdGtfYWFsX2dhbW1hX2dldF9sdXRf
c2l6ZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdm9pZCBtdGtfYWFsX2dhbW1hX3NldChzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZQ0KPiAqc3RhdGUpOw0KPiAgdm9p
ZCBtdGtfYWFsX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19hYWxfc3Rv
cChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiBAQCAtNTMsNiArNTQsNyBAQCB2b2lkIG10a19nYW1t
YV9jbGtfZGlzYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdm9pZCBtdGtfZ2FtbWFfY29u
ZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ICAJCSAgICAgIHVuc2ln
bmVkIGludCBoLCB1bnNpZ25lZCBpbnQgdnJlZnJlc2gsDQo+ICAJCSAgICAgIHVuc2lnbmVkIGlu
dCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpOw0KPiArdW5zaWduZWQgaW50IG10a19n
YW1tYV9nZXRfbHV0X3NpemUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX2dhbW1h
X3NldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZQ0KPiAqc3RhdGUp
Ow0KPiAgdm9pZCBtdGtfZ2FtbWFfc2V0X2NvbW1vbihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQg
X19pb21lbSAqcmVncywNCj4gc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSk7DQo+ICB2b2lk
IG10a19nYW1tYV9zdGFydChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiBpbmRleCA0Nzc1MTg2NGJkNWMuLjc1NzUy
Mzc2MjVkMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X2dhbW1hLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1h
LmMNCj4gQEAgLTI0LDEwICsyNCwxMiBAQA0KPiAgI2RlZmluZSBESVNQX0dBTU1BX0xVVAkJCQkw
eDA3MDANCj4gIA0KPiAgI2RlZmluZSBMVVRfMTBCSVRfTUFTSwkJCQkweDAzZmYNCj4gKyNkZWZp
bmUgTFVUX1NJWkVfREVGQVVMVAkJCTUxMg0KPiAgDQo+ICBzdHJ1Y3QgbXRrX2Rpc3BfZ2FtbWFf
ZGF0YSB7DQo+ICAJYm9vbCBoYXNfZGl0aGVyOw0KPiAgCWJvb2wgbHV0X2RpZmY7DQo+ICsJdTE2
IGx1dF9zaXplOw0KPiAgfTsNCj4gIA0KPiAgLyoNCj4gQEAgLTU0LDYgKzU2LDE1IEBAIHZvaWQg
bXRrX2dhbW1hX2Nsa19kaXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAljbGtfZGlzYWJs
ZV91bnByZXBhcmUoZ2FtbWEtPmNsayk7DQo+ICB9DQo+ICANCj4gK3Vuc2lnbmVkIGludCBtdGtf
Z2FtbWFfZ2V0X2x1dF9zaXplKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3Qg
bXRrX2Rpc3BfZ2FtbWEgKmdhbW1hID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwlp
ZiAoZ2FtbWEgJiYgZ2FtbWEtPmRhdGEpDQo+ICsJCXJldHVybiBnYW1tYS0+ZGF0YS0+bHV0X3Np
emU7DQo+ICsJcmV0dXJuIExVVF9TSVpFX0RFRkFVTFQ7DQo+ICt9DQo+ICsNCj4gIHZvaWQgbXRr
X2dhbW1hX3NldF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LCB2b2lkIF9faW9tZW0gKnJlZ3Ms
DQo+IHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+ICB7DQo+ICAJc3RydWN0IG10a19k
aXNwX2dhbW1hICpnYW1tYTsNCj4gQEAgLTYxLDYgKzcyLDcgQEAgdm9pZCBtdGtfZ2FtbWFfc2V0
X2NvbW1vbihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQNCj4gX19pb21lbSAqcmVncywgc3RydWN0
IGRybV9jcnQNCj4gIAlzdHJ1Y3QgZHJtX2NvbG9yX2x1dCAqbHV0Ow0KPiAgCXZvaWQgX19pb21l
bSAqbHV0X2Jhc2U7DQo+ICAJYm9vbCBsdXRfZGlmZjsNCj4gKwl1MTYgbHV0X3NpemU7DQoNCkFB
TCBkcml2ZXIgaGFzIGRlZmluZWQgaXRzIGx1dCBzaXplLCBzbyBwYXNzIGx1dCBzaXplIGZyb20g
QUFMIGRyaXZlci4NCg0KUmVnYXJkcywNCkNLDQoNCj4gIAl1MzIgd29yZDsNCj4gIAl1MzIgZGlm
ZlszXSA9IHswfTsNCj4gIA0KPiBAQCAtNzEsMTcgKzgzLDIwIEBAIHZvaWQgbXRrX2dhbW1hX3Nl
dF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LA0KPiB2b2lkIF9faW9tZW0gKnJlZ3MsIHN0cnVj
dCBkcm1fY3J0DQo+ICAJLyogSWYgd2UncmUgY2FsbGVkIGZyb20gQUFMLCBkZXYgaXMgTlVMTCAq
Lw0KPiAgCWdhbW1hID0gZGV2ID8gZGV2X2dldF9kcnZkYXRhKGRldikgOiBOVUxMOw0KPiAgDQo+
IC0JaWYgKGdhbW1hICYmIGdhbW1hLT5kYXRhKQ0KPiArCWlmIChnYW1tYSAmJiBnYW1tYS0+ZGF0
YSkgew0KPiAgCQlsdXRfZGlmZiA9IGdhbW1hLT5kYXRhLT5sdXRfZGlmZjsNCj4gLQllbHNlDQo+
ICsJCWx1dF9zaXplID0gZ2FtbWEtPmRhdGEtPmx1dF9zaXplOw0KPiArCX0gZWxzZSB7DQo+ICAJ
CWx1dF9kaWZmID0gZmFsc2U7DQo+ICsJCWx1dF9zaXplID0gTFVUX1NJWkVfREVGQVVMVDsNCj4g
Kwl9DQo+ICANCj4gIAlyZWcgPSByZWFkbChyZWdzICsgRElTUF9HQU1NQV9DRkcpOw0KPiAgCXJl
ZyA9IHJlZyB8IEdBTU1BX0xVVF9FTjsNCj4gIAl3cml0ZWwocmVnLCByZWdzICsgRElTUF9HQU1N
QV9DRkcpOw0KPiAgCWx1dF9iYXNlID0gcmVncyArIERJU1BfR0FNTUFfTFVUOw0KPiAgCWx1dCA9
IChzdHJ1Y3QgZHJtX2NvbG9yX2x1dCAqKXN0YXRlLT5nYW1tYV9sdXQtPmRhdGE7DQo+IC0JZm9y
IChpID0gMDsgaSA8IE1US19MVVRfU0laRTsgaSsrKSB7DQo+ICsJZm9yIChpID0gMDsgaSA8IGx1
dF9zaXplOyBpKyspIHsNCj4gIAkJaWYgKCFsdXRfZGlmZiB8fCAoaSAlIDIgPT0gMCkpIHsNCj4g
IAkJCXdvcmQgPSAoKChsdXRbaV0ucmVkID4+IDYpICYgTFVUXzEwQklUX01BU0spIDw8DQo+IDIw
KSArDQo+ICAJCQkJKCgobHV0W2ldLmdyZWVuID4+IDYpICYgTFVUXzEwQklUX01BU0spDQo+IDw8
IDEwKSArDQo+IEBAIC0xOTgsMTAgKzIxMywxMiBAQCBzdGF0aWMgaW50IG10a19kaXNwX2dhbW1h
X3JlbW92ZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19kaXNwX2dhbW1hX2RhdGEgbXQ4MTczX2dhbW1hX2RyaXZlcl9kYXRh
ID0gew0KPiAgCS5oYXNfZGl0aGVyID0gdHJ1ZSwNCj4gKwkubHV0X3NpemUgPSA1MTIsDQo+ICB9
Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX2dhbW1hX2RhdGEgbXQ4MTgz
X2dhbW1hX2RyaXZlcl9kYXRhID0gew0KPiAgCS5sdXRfZGlmZiA9IHRydWUsDQo+ICsJLmx1dF9z
aXplID0gNTEyLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgbXRrX2Rpc3BfZ2FtbWFfZHJpdmVyX2R0X21hdGNoW10gPQ0KPiB7DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gaW5kZXggOGE0MzY1NmVjYzMwLi5lYmUw
Y2MzYTFhNGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2NydGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMN
Cj4gQEAgLTk1OSw4ICs5NTksMTIgQEAgaW50IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0IGRy
bV9kZXZpY2UNCj4gKmRybV9kZXYsDQo+ICAJCW10a19jcnRjLT5kZHBfY29tcFtpXSA9IGNvbXA7
DQo+ICANCj4gIAkJaWYgKGNvbXAtPmZ1bmNzKSB7DQo+IC0JCQlpZiAoY29tcC0+ZnVuY3MtPmdh
bW1hX3NldCkNCj4gLQkJCQlnYW1tYV9sdXRfc2l6ZSA9IE1US19MVVRfU0laRTsNCj4gKwkJCWlm
IChjb21wLT5mdW5jcy0+Z2FtbWFfc2V0ICYmIGNvbXAtPmZ1bmNzLQ0KPiA+Z2FtbWFfZ2V0X2x1
dF9zaXplKSB7DQo+ICsJCQkJdW5zaWduZWQgaW50IGx1dF9zeiA9DQo+IG10a19kZHBfZ2FtbWFf
Z2V0X2x1dF9zaXplKGNvbXApOw0KPiArDQo+ICsJCQkJaWYgKGx1dF9zeikNCj4gKwkJCQkJZ2Ft
bWFfbHV0X3NpemUgPSBsdXRfc3o7DQo+ICsJCQl9DQo+ICANCj4gIAkJCWlmIChjb21wLT5mdW5j
cy0+Y3RtX3NldCkNCj4gIAkJCQloYXNfY3RtID0gdHJ1ZTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2NydGMuaA0KPiBpbmRleCAzZTkwNDY5OTNkMDkuLmIyZTUwMjkyZTU3
ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5o
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuaA0KPiBAQCAt
MTAsNyArMTAsNiBAQA0KPiAgI2luY2x1ZGUgIm10a19kcm1fZGRwX2NvbXAuaCINCj4gICNpbmNs
dWRlICJtdGtfZHJtX3BsYW5lLmgiDQo+ICANCj4gLSNkZWZpbmUgTVRLX0xVVF9TSVpFCTUxMg0K
PiAgI2RlZmluZSBNVEtfTUFYX0JQQwkxMA0KPiAgI2RlZmluZSBNVEtfTUlOX0JQQwkzDQo+ICAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21w
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IGlu
ZGV4IGYxMTRkYTRkMzZhOS4uZjMyMTJlMDhmMmNkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gQEAgLTI3MSw2ICsyNzEsNyBAQCBzdGF0
aWMgdm9pZCBtdGtfdWZvZV9zdGFydChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBkZHBfYWFsID0gew0KPiAgCS5jbGtfZW5hYmxl
ID0gbXRrX2FhbF9jbGtfZW5hYmxlLA0KPiAgCS5jbGtfZGlzYWJsZSA9IG10a19hYWxfY2xrX2Rp
c2FibGUsDQo+ICsJLmdhbW1hX2dldF9sdXRfc2l6ZSA9IG10a19hYWxfZ2FtbWFfZ2V0X2x1dF9z
aXplLA0KPiAgCS5nYW1tYV9zZXQgPSBtdGtfYWFsX2dhbW1hX3NldCwNCj4gIAkuY29uZmlnID0g
bXRrX2FhbF9jb25maWcsDQo+ICAJLnN0YXJ0ID0gbXRrX2FhbF9zdGFydCwNCj4gQEAgLTMyMiw2
ICszMjMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBkZHBfZHNp
ID0NCj4gew0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgZGRwX2dh
bW1hID0gew0KPiAgCS5jbGtfZW5hYmxlID0gbXRrX2dhbW1hX2Nsa19lbmFibGUsDQo+ICAJLmNs
a19kaXNhYmxlID0gbXRrX2dhbW1hX2Nsa19kaXNhYmxlLA0KPiArCS5nYW1tYV9nZXRfbHV0X3Np
emUgPSBtdGtfZ2FtbWFfZ2V0X2x1dF9zaXplLA0KPiAgCS5nYW1tYV9zZXQgPSBtdGtfZ2FtbWFf
c2V0LA0KPiAgCS5jb25maWcgPSBtdGtfZ2FtbWFfY29uZmlnLA0KPiAgCS5zdGFydCA9IG10a19n
YW1tYV9zdGFydCwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcF9jb21wLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5oDQo+IGluZGV4IGZlYmNhZWVmMTZhMS4uYzEzNTU5NjBlMTk1IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gQEAgLTY3LDYgKzY3
LDcgQEAgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyB7DQo+ICAJdm9pZCAoKmxheWVyX2NvbmZp
Zykoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQkJICAgICBzdHJ1
Y3QgbXRrX3BsYW5lX3N0YXRlICpzdGF0ZSwNCj4gIAkJCSAgICAgc3RydWN0IGNtZHFfcGt0ICpj
bWRxX3BrdCk7DQo+ICsJdW5zaWduZWQgaW50ICgqZ2FtbWFfZ2V0X2x1dF9zaXplKShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpOw0KPiAgCXZvaWQgKCpnYW1tYV9zZXQpKHN0cnVjdCBkZXZpY2UgKmRldiwN
Cj4gIAkJCSAgc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSk7DQo+ICAJdm9pZCAoKmJnY2xy
X2luX29uKShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiBAQCAtMTg2LDYgKzE4NywxNCBAQCBzdGF0
aWMgaW5saW5lIHZvaWQNCj4gbXRrX2RkcF9jb21wX2xheWVyX2NvbmZpZyhzdHJ1Y3QgbXRrX2Rk
cF9jb21wICpjb21wLA0KPiAgCQljb21wLT5mdW5jcy0+bGF5ZXJfY29uZmlnKGNvbXAtPmRldiwg
aWR4LCBzdGF0ZSwNCj4gY21kcV9wa3QpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW5saW5lIHVu
c2lnbmVkIGludCBtdGtfZGRwX2dhbW1hX2dldF9sdXRfc2l6ZShzdHJ1Y3QNCj4gbXRrX2RkcF9j
b21wICpjb21wKQ0KPiArew0KPiArCWlmIChjb21wLT5mdW5jcyAmJiBjb21wLT5mdW5jcy0+Z2Ft
bWFfZ2V0X2x1dF9zaXplKQ0KPiArCQlyZXR1cm4gY29tcC0+ZnVuY3MtPmdhbW1hX2dldF9sdXRf
c2l6ZShjb21wLT5kZXYpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyBpbmxpbmUgdm9pZCBtdGtfZGRwX2dhbW1hX3NldChzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21w
LA0KPiAgCQkJCSAgICAgc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gIHsNCg==
