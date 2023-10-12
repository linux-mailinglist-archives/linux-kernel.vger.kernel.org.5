Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6317C63C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 06:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343517AbjJLEMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 00:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbjJLEMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 00:12:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FBFC6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 21:12:35 -0700 (PDT)
X-UUID: 8f7671c068b511ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AmI3HQCdC3wf4QWMFV9qFctTQEnnKtree9jLXLVtXsY=;
        b=YB5nvciccBF12ZOAQLppCEMZH6bFldDupa+X5avYJ/fMYR+hjMMUeyZD+veQpHw8tbMkSBk/yVJK1mvMVZr5bw16KBeIHqpVzOnoUiD9GAn6OEqIoDjP0joqCpNjX5st5y9w+s4c/ZKWgj9bJ54X1oI446oqgf4wuj2sFLzONy8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:5a49b5ad-997c-4071-ad44-0d5cbbca7cfa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:aa13f014-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8f7671c068b511ee8051498923ad61e6-20231012
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 12302437; Thu, 12 Oct 2023 12:12:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 12:12:29 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 12:12:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWkgX7kkBi56at+RpV9gCtgwzqvXHutUidTVNiKeSxE8ZaRb1oXMVO0j1syJ/118IP1VzNPNITnjq9qbpV3yV36yUlMaizP+jfZT5nAtwgzWCaFNaDdUw9sUjJNWPC0Sy9gRyzcLiMJ1AlRRDKbBlZ7Md9KysFp8Tb2bjVV1Df7PzEnXHnTC31pm34eFB+KtJAxU2TCApGcmAP0OP8l5G+0PC2QIKxBcgwzrAIr3haJtmJED0urSNnw0vVUFeFoYw3yi2UIr7T6fU9TjaEqOT7DpYY3hp6+5HpGbICeTqGCVKPgVQ9/LPDtb4WM5CChHJvxyXqHkg+SasfYsiiDZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmI3HQCdC3wf4QWMFV9qFctTQEnnKtree9jLXLVtXsY=;
 b=ofSzLm+eOKHiY+WsD7B4q1rVh/TdZ0tj5vTsL91puMr0haJ2da2J/WRF3llRSnCSkD6nd0o7DT7FEbuvo5fWDUnfMTyTSRddZjg0sJP0QWbRiHmN9N8ZiEkihCIpxSODtoXHGQ1yCVW2HCZDljiKkJ41AP66CC8NaWb6rpFoB0LSvFxHa7f8lnkTK/eiuOQIZhyQP5i4Y4TAqXm+DEFB77jj4xVFh30BvvRDA3LzSHYQQggn4iS06pTKAaIJUPTdbqjpTwTb9tEojAcNZv996zTP5LZ/4qvNyORGp3/q36ZoE27clL7AdvlVbKgMRo7yGqUKN0oGIjyjZm8ggjI16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmI3HQCdC3wf4QWMFV9qFctTQEnnKtree9jLXLVtXsY=;
 b=Q8ynLgwx7Roo8CJYpfociyy2nE0SO+sP1gs5WLW19y1ZLIMsMS+l0+cizqDN85v/2W2QTEyep2DvqKN+RK6S2Zba2plj+LxxnXeW1wImksnaWEEKHxs/jBxq9pXc7ALLVcimBkOaJfCizuK9zyY56v4QTCYgtUPNChjUdAcpy1A=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB5438.apcprd03.prod.outlook.com (2603:1096:400:39::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 04:12:27 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.041; Thu, 12 Oct 2023
 04:12:26 +0000
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
Subject: Re: [PATCH v10 06/16] drm/mediatek: gamma: Use bitfield macros
Thread-Topic: [PATCH v10 06/16] drm/mediatek: gamma: Use bitfield macros
Thread-Index: AQHZxqWK6h5/8Okv5EGLTnAcpAZ1nLBF91IA
Date:   Thu, 12 Oct 2023 04:12:26 +0000
Message-ID: <9e3cf398f455e592b6361c63c35495693c0a14a9.camel@mediatek.com>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
         <20230804072850.89365-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230804072850.89365-7-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB5438:EE_
x-ms-office365-filtering-correlation-id: e47b7d91-70fb-4d91-5bc3-08dbcad971c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h/EsH4qotLBv7bMGn/ZaJz4CVxmYr2jHlB0uvu2LY38yAWDliTtB3wUVXz+cdGtxeX96OfUy/Dw7nYE88I5R+/JwJBxnSeaCIC+ZoBKc74e73/Qg4VHgfJeOGpAfsy5/eeUWYdLeP9QxcHlllN3Aadja5tYIMkYHsakCrt/U7Me7VFJmDyAjG4Wx/1tTxos4aTmwPGrTxYwefy/3s5Pek0SHRuBMERMnGd1wKUVsqXOIZk+B3Z2ckbDeF0f11AGKLEVPPkMa9fIAjdT9rSrmuYf5kh/Am8j7ZeSopAVMMKnYmUlKnvfnyr0wzCkRfJIz7WDLnV+6SF3qXEXNdM12/3pyhLWIderCpaUwdz4e9X44Ss1yAvnOyTSOHNhGgjuc7HaBdjwVdYiqIMuOrJxyQRi659lLoQRD486akr4AymaMkrBi3D0hHLLFEWKztW6/iwDWG0GOYl6qRACSXLVWdepJCl7Yb8P2+SToyDfQIpEhxwa2SQxHTF1ocl+3kx4YsJYuGcYslhViytfjA9o1MglBRvEK4vNxbN3pHQeqqxxSP6BlDP+IcpTGmMs4k1dLxZ6dcA4FR0Iva6sgpNSmD2oLprtj463VsARQ3Y6KrxA3f+dxFB3kvwgm7z7smEPBuMKNlWZ1nVatjzgCy0xVEonebzmFpEWNS6uU4ZsKPzs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(2616005)(478600001)(6486002)(6506007)(83380400001)(86362001)(71200400001)(36756003)(41300700001)(8936002)(4326008)(8676002)(64756008)(54906003)(316002)(85182001)(76116006)(110136005)(66476007)(66446008)(66556008)(66946007)(7416002)(6512007)(2906002)(38070700005)(38100700002)(5660300002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGtFRVFMTSt3SE5tYnV0VG9BZHBmbHN2R0ZEa2R5OFoxMDhGZ0ZKWWU1eVNB?=
 =?utf-8?B?OEVlaGpqZEFSMk9qYTg0bUU4bWZWVUNqTkNMQnFKTmRxWjFpeUlGeXdCY0hF?=
 =?utf-8?B?Sjh1SmVpYTBrdjRKS2xRaDhnQkJDUUloWUd5bm0xelRRNUkvR0hCRHRTMUJT?=
 =?utf-8?B?Qi92MXZpMXJEWGNWajQ0MkNnZHY1ZWpBaWJGNjhZTjRUUWtoM2xZRU5Nb0Ra?=
 =?utf-8?B?cjZMOVZGNUd3a3BEK01uSjJvWDdPVEt2OWxWbEZvaGgyTzVwRXpXYzZWbk43?=
 =?utf-8?B?ajFPQVo3M0YxL0JEWkhXZEdPdlpXL3YycVdUZFlIRHdzRVhpREVMUXBFZHJR?=
 =?utf-8?B?UUxaaEZkUnV4UjZja3dnU2NLS1Y3eUtyQUVIU1o1ZnVuWmpHNmp2bjdoY01j?=
 =?utf-8?B?ZmsrUUY1V05FMk8wSGZBM3BmdHc1cWNBSmpRUGdFUHpuUnUyRXNDZWFtYlov?=
 =?utf-8?B?QmowaVRhRndxcjI0OU1UNTM0OTRtQlVuVFF1ZFh3bC9JVm9EMVJuV1hqWE13?=
 =?utf-8?B?bC9jR3FFUW5mYVR2dWk4akVFSTJEeUZvbFEzemxDamhnWU5PclFtaGREaEdH?=
 =?utf-8?B?RHA1U0twSWR1dGJVZnQ3OXk0di9GNmI5azBKYXo1VFRjQnlJbjFkbVFiNEc1?=
 =?utf-8?B?QzVlbEZybFJUTVBnazZ3Z1BzVGtTdElTTUFOZkl4dkFYK2ROaVhsZlljMWhJ?=
 =?utf-8?B?YW1CRmlZZmFiWFRRLzdIMCtNMXV2NXZkQWUwOVhSUG5yOGhWaW8rcHgzUVBP?=
 =?utf-8?B?V2h6UjlpK2lIbmNtV09Ea3hDU2ZDelJlU2pVbzFpYjYvTytlRmtuckU0TWtU?=
 =?utf-8?B?MHJ0eVFRbkd0Z1g5UkdGUmtVL0krVzYwMUlsNnMxc3Y5dWtiWk5STUo3dEN2?=
 =?utf-8?B?bGtYcmxJZjM3NVhqV2hVTllzMUxIMWJkclJ3OVd5bzREYkFrU3hpRTJzVGFP?=
 =?utf-8?B?b1J1c3YrTE9nZFNHYWFzMVc1YTZwR09TekZRV2NLU284LytBODRJZytXei9p?=
 =?utf-8?B?MkJZbXREN1hmWldFMXdJaFluM1FDSUJiREVVMGxvR2RkTUxsZDFaSnc3ODJm?=
 =?utf-8?B?V01FVGhSbGMydXBZY0ErQ3JBbnU1THdhZnpxWTg0VEJNNHN4T3E2ZkgzOGdo?=
 =?utf-8?B?cmFPc2ptbXhiUjFDSklJK0ZJbWtwakxLd1Z1N1VocE5tUGRJOEJYZFRlb0FE?=
 =?utf-8?B?bkkrLzBrUnNyb0cvUm5MeHJ1cXpEcDAvdjVEdHd2K3ZmZnI3cUhjWXZTRzhX?=
 =?utf-8?B?MnNkTmtkcTlIRndBRkg4V2ZUbVpoSFRqTmNkeEN6Ymo4Q0FMU1lOUjJrRUV2?=
 =?utf-8?B?a1hPTzdZSEY4RUlWaGkrd01lSGM3c2NOdHRDMGE0VFBUWW42QzdjM1poZTFI?=
 =?utf-8?B?cG1DVVBZbWhnNzJBTXI3RUVWd1JYWkFDZTJVY01nRmFONSt2U3FaMUNiV2p3?=
 =?utf-8?B?RGcrOXVGOGdaKytscXNKblBuMEpYeDduclF0T0pxeElNcHpNYTg1cFVWZG5L?=
 =?utf-8?B?Q0Fhak9xSXQ1bUk0M2hiQ1EvMmlrRjI1TUt5MmR4TGlBcFk0S3B1ak5sakw0?=
 =?utf-8?B?NmtRT1A0N3NsYTRaVVVCYTFIZ01wU1NLS21pMFhIQmJmdmIvaTQ0VzNBd2g2?=
 =?utf-8?B?TFBLTGZmcjNnaDRwOHpTSkRNWlZJMlNDdWJaci9lcm9UUGt0QTMrRFoxWEpE?=
 =?utf-8?B?czRDSkZHencxbnl3eUJBRmQ5NGRVdzc1eXBWZXRuZ0tiNVJBVS81QUQ2NC9I?=
 =?utf-8?B?TkhTZVZqa2ROUnJWKzVaaVVjRVJ5VGcxOTBPd3ltbFJVNVFLcFk1c0ljdWlv?=
 =?utf-8?B?dVg0YTRGZVhOKy9oWEcyN0s3YytwUEUrRkgzbHZoeUluaEloeU81NXdWbWYr?=
 =?utf-8?B?V3pIeWNNTmFHbU1hRkR4cWRhbktpR3Z5Q0dsVWFtUDhtOGpqN21UTGRGUzlP?=
 =?utf-8?B?UWtBOGJ5SnVkQnZib2NaTktvU2JVU204UHRtOE1wNWtkVXBIZnhsaDc5bCtw?=
 =?utf-8?B?T05mT25NNnBPOGo4YkZZOW1xRTB6c1JxdElPeUJTMEFqOStBRElqL0wwN3Fn?=
 =?utf-8?B?UXNHMnlXTFRFUDBOS0VRdTF5aW91Z3cyZmp6K3M4NDRCT1BkejRyajVIZlZR?=
 =?utf-8?Q?YOAJ63Mx1gqhdNIUDCHpsgMRZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED38244EDE61094F9F67862E5863073C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47b7d91-70fb-4d91-5bc3-08dbcad971c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 04:12:26.8209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AezYG3nAKf9x40Tep5rnyYTwzZRF6rJDykht6fpO2mNvPtBd0yN+uWVRR/tj2hjDzFpZKFWc+WO7DmwdLjDRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5438
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.596600-8.000000
X-TMASE-MatchedRID: 9zTThWtzImsNtKv7cnNXnSa1MaKuob8PC/ExpXrHizzJYIv7y0tu9tj3
        ZmXrgmMgg3/S9FbDj8Zxec6bnKstogDNPxu11HXjhK8o4aoss8qscK/K2DlvjhS11FlOYRohdjd
        NwycGaR+M6LK6ZGOVCrRd0WwZSVdN3Mfe2WVWXDKHZXNSWjgdUzuvYa1v2IFhOskReVg8GDajxY
        yRBa/qJRVHsNBZf9aRAYt5KiTiutkLbigRnpKlKSPzRlrdFGDwHw1fH6yhp/VBjPZSUOrsNPJtZ
        n6AttWXryuk3kiTEGPUtOLcuMOdzw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.596600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 3FA203B68CF8C77D0820B44F2C133F0FED2C091D0B1D3881A1368B037C48D3B22000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gRnJpLCAyMDIzLTA4LTA0IGF0IDA5OjI4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTWFrZSB0aGUgY29kZSBtb3JlIHJvYnVzdCBh
bmQgaW1wcm92ZSByZWFkYWJpbGl0eSBieSB1c2luZyBiaXRmaWVsZA0KPiBtYWNyb3MgaW5zdGVh
ZCBvZiBvcGVuIGNvZGluZyBiaXQgb3BlcmF0aW9ucy4NCj4gV2hpbGUgYXQgaXQsIGFsc28gYWRk
IGEgZGVmaW5pdGlvbiBmb3IgTFVUX0JJVFNfREVGQVVMVC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdu
b0Bjb2xsYWJvcmEuY29tPg0KPiBSZXZpZXdlZC1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5s
aW5AbWVkaWF0ZWsuY29tPg0KPiBSZXZpZXdlZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJn
bmF0QGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfZ2FtbWEuYyB8IDQxICsrKysrKysrKysrKysrLS0tLS0tLQ0KPiAtLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gaW5kZXggMThiMTAyYmVm
MzcwLi5lYTkxZDM2MTk3MTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9nYW1tYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9nYW1tYS5jDQo+IEBAIC0zLDYgKzMsNyBAQA0KPiAgICogQ29weXJpZ2h0IChjKSAyMDIx
IE1lZGlhVGVrIEluYy4NCj4gICAqLw0KPiAgDQo+ICsjaW5jbHVkZSA8bGludXgvYml0ZmllbGQu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9jb21wb25l
bnQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gQEAgLTIxLDkgKzIyLDE2IEBA
DQo+ICAjZGVmaW5lIEdBTU1BX0xVVF9FTgkJCQkJQklUKDEpDQo+ICAjZGVmaW5lIEdBTU1BX0RJ
VEhFUklORwkJCQkJQklUKDIpDQo+ICAjZGVmaW5lIERJU1BfR0FNTUFfU0laRQkJCQkweDAwMzAN
Cj4gKyNkZWZpbmUgRElTUF9HQU1NQV9TSVpFX0hTSVpFCQkJCUdFTk1BU0sNCj4gKDI4LCAxNikN
Cj4gKyNkZWZpbmUgRElTUF9HQU1NQV9TSVpFX1ZTSVpFCQkJCUdFTk1BU0sNCj4gKDEyLCAwKQ0K
PiAgI2RlZmluZSBESVNQX0dBTU1BX0xVVAkJCQkweDA3MDANCj4gIA0KPiArI2RlZmluZSBESVNQ
X0dBTU1BX0xVVF8xMEJJVF9SCQkJR0VOTUFTSygyOSwgMjApDQo+ICsjZGVmaW5lIERJU1BfR0FN
TUFfTFVUXzEwQklUX0cJCQlHRU5NQVNLKDE5LCAxMCkNCj4gKyNkZWZpbmUgRElTUF9HQU1NQV9M
VVRfMTBCSVRfQgkJCUdFTk1BU0soOSwgMCkNCj4gKw0KPiAgI2RlZmluZSBMVVRfMTBCSVRfTUFT
SwkJCQkweDAzZmYNCj4gKyNkZWZpbmUgTFVUX0JJVFNfREVGQVVMVAkJCTEwDQo+ICAjZGVmaW5l
IExVVF9TSVpFX0RFRkFVTFQJCQk1MTINCj4gIA0KPiAgc3RydWN0IG10a19kaXNwX2dhbW1hX2Rh
dGEgew0KPiBAQCAtOTYsMzMgKzEwNCwzMyBAQCB2b2lkIG10a19nYW1tYV9zZXRfY29tbW9uKHN0
cnVjdCBkZXZpY2UgKmRldiwNCj4gdm9pZCBfX2lvbWVtICpyZWdzLCBzdHJ1Y3QgZHJtX2NydA0K
PiAgCWZvciAoaSA9IDA7IGkgPCBsdXRfc2l6ZTsgaSsrKSB7DQo+ICAJCXN0cnVjdCBkcm1fY29s
b3JfbHV0IGRpZmYsIGh3bHV0Ow0KPiAgDQo+IC0JCWh3bHV0LnJlZCA9IGRybV9jb2xvcl9sdXRf
ZXh0cmFjdChsdXRbaV0ucmVkLCAxMCk7DQo+IC0JCWh3bHV0LmdyZWVuID0gZHJtX2NvbG9yX2x1
dF9leHRyYWN0KGx1dFtpXS5ncmVlbiwgMTApOw0KPiAtCQlod2x1dC5ibHVlID0gZHJtX2NvbG9y
X2x1dF9leHRyYWN0KGx1dFtpXS5ibHVlLCAxMCk7DQo+ICsJCWh3bHV0LnJlZCA9IGRybV9jb2xv
cl9sdXRfZXh0cmFjdChsdXRbaV0ucmVkLA0KPiBMVVRfQklUU19ERUZBVUxUKTsNCg0KWW91IGZp
bmFsbHkgZHJvcCBMVVRfQklUU19ERUZBVUxULCBzbyBpdCdzIG5vdCBuZWNlc3NhcnkgdG8gaW50
cm9kdWNlDQppdCBpbiB0aGlzIHBhdGNoLiBMZXQgdGhpcyBwYXRjaCBvbmx5IHVzZSBiaXRmaWVs
ZCBtYWNyb3MuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJCWh3bHV0LmdyZWVuID0gZHJtX2NvbG9y
X2x1dF9leHRyYWN0KGx1dFtpXS5ncmVlbiwNCj4gTFVUX0JJVFNfREVGQVVMVCk7DQo+ICsJCWh3
bHV0LmJsdWUgPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W2ldLmJsdWUsDQo+IExVVF9CSVRT
X0RFRkFVTFQpOw0KPiAgDQo+ICAJCWlmICghbHV0X2RpZmYgfHwgKGkgJSAyID09IDApKSB7DQo+
IC0JCQl3b3JkID0gaHdsdXQucmVkIDw8IDIwICsNCj4gLQkJCSAgICAgICBod2x1dC5ncmVlbiA8
PCAxMCArDQo+IC0JCQkgICAgICAgaHdsdXQucmVkOw0KPiArCQkJd29yZCA9IEZJRUxEX1BSRVAo
RElTUF9HQU1NQV9MVVRfMTBCSVRfUiwNCj4gaHdsdXQucmVkKTsNCj4gKwkJCXdvcmQgfD0gRklF
TERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9HLA0KPiBod2x1dC5ncmVlbik7DQo+ICsJCQl3
b3JkIHw9IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9MVVRfMTBCSVRfQiwNCj4gaHdsdXQuYmx1ZSk7
DQo+ICAJCX0gZWxzZSB7DQo+ICAJCQlkaWZmLnJlZCA9IGx1dFtpXS5yZWQgLSBsdXRbaSAtIDFd
LnJlZDsNCj4gLQkJCWRpZmYucmVkID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRpZmYucmVkLCAx
MCk7DQo+ICsJCQlkaWZmLnJlZCA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLnJlZCwNCj4g
TFVUX0JJVFNfREVGQVVMVCk7DQo+ICANCj4gIAkJCWRpZmYuZ3JlZW4gPSBsdXRbaV0uZ3JlZW4g
LSBsdXRbaSAtIDFdLmdyZWVuOw0KPiAtCQkJZGlmZi5ncmVlbiA9IGRybV9jb2xvcl9sdXRfZXh0
cmFjdChkaWZmLmdyZWVuLA0KPiAxMCk7DQo+ICsJCQlkaWZmLmdyZWVuID0gZHJtX2NvbG9yX2x1
dF9leHRyYWN0KGRpZmYuZ3JlZW4sDQo+IExVVF9CSVRTX0RFRkFVTFQpOw0KPiAgDQo+ICAJCQlk
aWZmLmJsdWUgPSBsdXRbaV0uYmx1ZSAtIGx1dFtpIC0gMV0uYmx1ZTsNCj4gLQkJCWRpZmYuYmx1
ZSA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLmJsdWUsDQo+IDEwKTsNCj4gKwkJCWRpZmYu
Ymx1ZSA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLmJsdWUsDQo+IExVVF9CSVRTX0RFRkFV
TFQpOw0KPiAgDQo+IC0JCQl3b3JkID0gZGlmZi5ibHVlIDw8IDIwICsNCj4gLQkJCSAgICAgICBk
aWZmLmdyZWVuIDw8IDEwICsNCj4gLQkJCSAgICAgICBkaWZmLnJlZDsNCj4gKwkJCXdvcmQgPSBG
SUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX1IsDQo+IGRpZmYucmVkKTsNCj4gKwkJCXdv
cmQgfD0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9HLA0KPiBkaWZmLmdyZWVuKTsN
Cj4gKwkJCXdvcmQgfD0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9CLA0KPiBkaWZm
LmJsdWUpOw0KPiAgCQl9DQo+ICAJCXdyaXRlbCh3b3JkLCAobHV0X2Jhc2UgKyBpICogNCkpOw0K
PiAgCX0NCj4gIA0KPiAgCS8qIEVuYWJsZSB0aGUgZ2FtbWEgdGFibGUgKi8NCj4gLQljZmdfdmFs
ID0gY2ZnX3ZhbCB8IEdBTU1BX0xVVF9FTjsNCj4gKwljZmdfdmFsIHw9IEZJRUxEX1BSRVAoR0FN
TUFfTFVUX0VOLCAxKTsNCj4gIA0KPiAgCXdyaXRlbChjZmdfdmFsLCByZWdzICsgRElTUF9HQU1N
QV9DRkcpOw0KPiAgfQ0KPiBAQCAtMTM5LDkgKzE0NywxMiBAQCB2b2lkIG10a19nYW1tYV9jb25m
aWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgdywNCj4gIAkJICAgICAgdW5z
aWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkNCj4gIHsNCj4gIAlzdHJ1
Y3QgbXRrX2Rpc3BfZ2FtbWEgKmdhbW1hID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsJdTMy
IHN6Ow0KPiArDQo+ICsJc3ogPSBGSUVMRF9QUkVQKERJU1BfR0FNTUFfU0laRV9IU0laRSwgdyk7
DQo+ICsJc3ogfD0gRklFTERfUFJFUChESVNQX0dBTU1BX1NJWkVfVlNJWkUsIGgpOw0KPiAgDQo+
IC0JbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgaCA8PCAxNiB8IHcsICZnYW1tYS0+Y21kcV9yZWcs
IGdhbW1hLQ0KPiA+cmVncywNCj4gLQkJICAgICAgRElTUF9HQU1NQV9TSVpFKTsNCj4gKwltdGtf
ZGRwX3dyaXRlKGNtZHFfcGt0LCBzeiwgJmdhbW1hLT5jbWRxX3JlZywgZ2FtbWEtPnJlZ3MsDQo+
IERJU1BfR0FNTUFfU0laRSk7DQo+ICAJaWYgKGdhbW1hLT5kYXRhICYmIGdhbW1hLT5kYXRhLT5o
YXNfZGl0aGVyKQ0KPiAgCQltdGtfZGl0aGVyX3NldF9jb21tb24oZ2FtbWEtPnJlZ3MsICZnYW1t
YS0+Y21kcV9yZWcsDQo+IGJwYywNCj4gIAkJCQkgICAgICBESVNQX0dBTU1BX0NGRywgR0FNTUFf
RElUSEVSSU5HLA0KPiBjbWRxX3BrdCk7DQo=
