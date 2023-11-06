Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6EC7E19BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjKFFtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFFtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:49:13 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FDFCC;
        Sun,  5 Nov 2023 21:49:04 -0800 (PST)
X-UUID: 2c2d67c47c6811ee8051498923ad61e6-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YBxnyxQuBAPfY1bDlXMUSo6Kgthb2T0/uCI9jN3jWqc=;
        b=QdzG3vNdfGWKsQHXBeXDhUu1WUpqYFwW8az2I7hhuT3m+S6+PIFzOTHikd7VzdIuQ+zyEPGfLdidgkYEzR9Rb+HiKfnn591TQcB8r+g+Ne9FzKyEu4yuQ6JQM6k0F361WXZoov++8fK8MXSsldMsqUw2cE4ViV2Wdn4xCtpU5X4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:20066285-99f0-4858-b7dd-867047207c99,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:7598b85f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2c2d67c47c6811ee8051498923ad61e6-20231106
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 674916148; Mon, 06 Nov 2023 13:48:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 13:48:54 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 13:48:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLHQz2VyaY4UV3IZvxFDyVraek+eFIy6wiN1dMJVbjb0UUXv2VkRLs95R5bgpvaSsO5nUTCRwkJBkIB1uX3XaHhNVpjwFPDWdEbLJpQvKgN/n8FIDzrpxb0TrGL7OXM1M1DAeIDOTySCTWhy/GW3TczuvRnjAo5CGSzBF7Jx3VFJdmHFskq42gUnh1hq6DY5gXovioE6WVXtiNcF/xuFHXp3Oq3gIrqCzm7Dvkt0cHS/VYsOPtjagnIeLl6WPKU+dSbFPINlbSJ7jGP7PfS9W+842vwICmod6WZacrpo7t7iSlHHEqxTDV5wFCixUyLjdxblvfhaUXooKPmWegiBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBxnyxQuBAPfY1bDlXMUSo6Kgthb2T0/uCI9jN3jWqc=;
 b=aMy11fT55YXFV2ul4pNEw/YSXVsedL9HoeerVi+dO825sutodntLE4hg7PUMx/ZXbg06gBQyubTVQn4LfUaudLcOeoupdfGpfR+0ek4725e0D2e1XAiLMkQq7p7UKUHCqzeb416qEIpR3vR+OnMqdzz9dLZo9cAmk2BgHY7nOvI6PE7u0nCTc9gVQ5EIrAPPdYJzwcedbCUmW/0rygFVHEvoDhFx2dgRGU5ELoDgQd7WqO9aFDny0yE5Y3MftVznyPcKf8TKjl6UWiman2ajHiB9+O0saJuAOenrI13b5oI9QLzs4OgMmvUoXkeK7L0qX+winOQ3fAnw/XOGRbFWlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBxnyxQuBAPfY1bDlXMUSo6Kgthb2T0/uCI9jN3jWqc=;
 b=NyutROHL/ESZxrSjnDNQ6URzZBc74ApYxS6FqwYXf1GHEcytcWYSVxsnxXnsyvLB5QZZtGp4csvTYjnxWc4iiNLEqS2LtOd+PlwUya8hEp6EFGGYCjJEYHIdL7uIqxKy2lWF+Elld5tfLUeNegI1Tssrh+dTNkgmmBohB+V2U2o=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB7977.apcprd03.prod.outlook.com (2603:1096:400:47f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 05:48:50 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.6954.025; Mon, 6 Nov 2023
 05:48:50 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
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
Subject: Re: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Topic: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Index: AQHaBWvxkYcM1loCq06xiO/urU0GrLBjdJyAgAhR3ICAAM+UAIAAGaeAgAADUYCAACv4gA==
Date:   Mon, 6 Nov 2023 05:48:49 +0000
Message-ID: <74154b6504ec8f730eecbeb9938be97b8a0565ec.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-10-jason-jh.lin@mediatek.com>
         <02187af1e98093d20a170d0ce4b2b428c7eee37d.camel@mediatek.com>
         <c0b47da99e0a43e867a3fb27efc36786d4315aea.camel@mediatek.com>
         <137cd99b6749e7a2e3b7fa091fd9a20d3c798c53.camel@mediatek.com>
         <310f3588d65d18ead5e07c85ae656a8d94507a04.camel@mediatek.com>
         <a2ddf5604052e88b9b2790f23ef89d5e16fdb172.camel@mediatek.com>
In-Reply-To: <a2ddf5604052e88b9b2790f23ef89d5e16fdb172.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB7977:EE_
x-ms-office365-filtering-correlation-id: 26637f8a-48c6-43a2-4c4c-08dbde8c0d14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5yGNaArzAIjsENg/V9NIV30oNofTHpGJmSACWt7UeLqYqn+s6uRY2SNUhE3e3CoLfNO63/Z2ALc4kLwAFUK1z6aGdGb3TMns7SzIS8oGtqI4VrxPq47k7+TyUqoQH+u3AP88GyfSNKp2nVz2NOyUfRAkap8/AGWxQB+GWnZoGlzXIxw05BNS0TonAQN+Tee9RPOTyr4re6qC89VaAJnHl2T9PQfwm57MI88xXjaRAi/3YEyGraSoqhFa7Ad3DpW/01hGJqgJZWlnDs48UuRLNLQH3ifayMPsZvctOLO28Xh9y5bmLoJ4WeF1D15BlivVkVGEVc2O+FTLK5EVs+hZiXbaRybFxskziQztmm/NUdXgfaA9RnQyj9Qh7TUVQEBWHdVi4o0ZSz+lv3hWurujmLvJD3yenE5eb2yHxtrJIgxjxq2KDH6Wqn2xogThZ3RFj3qRJ86XJ2+40Mn68AhAF07Yl70XeAES9ihxr7n9T84HifUlo/WDX92W6Tsr0p2PJ+5PMHhI8qK0kUaBdidUvyRZr7OBEv4vBLr1oPP4muzfs7S9d68UXU87AaY/x1ej7qHolf05WQTdCFKuAqM5iRCl/bF3u+ToqHEIwiAd6AXk4fiy4khpY/6Acw/QuauH2KaJ5pFwawUJsienTkiNu2BTB78uxdFGZOudC8oCQ80=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(2616005)(6512007)(41300700001)(26005)(83380400001)(71200400001)(4326008)(8676002)(8936002)(2906002)(4001150100001)(7416002)(5660300002)(6486002)(54906003)(66446008)(64756008)(316002)(66476007)(76116006)(66556008)(66946007)(110136005)(91956017)(38070700009)(478600001)(36756003)(122000001)(38100700002)(85182001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2czK1AzOVhvNlJ3MXBIbUMyWkVLNU52Qjl3RXFpYnFacTZ5eGlJSDlhSzhs?=
 =?utf-8?B?NmZVd1pucFN6RnBPaTlFckxvWFJOb05ueDlpNTZaQlhvc2NONGl4NW9wMlFt?=
 =?utf-8?B?MDNLaVdYSVZzSTZBRWJOTG11TWo3Rm5zMGUxc1N1V1U4Mm9NeWRPS0J1bGtH?=
 =?utf-8?B?WmlwVkpEQnZjenhieWI5amZHNHpra0ZqZWxuWWFySitvRHIvQUg3WGttZHBF?=
 =?utf-8?B?MXRzU0RDQmNidTlMRk5VL1VEMHlwRlJrTVRZdlcxclpGMEcvVml0cGlKZVpq?=
 =?utf-8?B?Z2luVm5UdENCbXowaHphVGJBU04zWEF6SUVNeXh2RFdZN05JRUNzUWxWMEM1?=
 =?utf-8?B?Mkx1ZnF1QU1JZ2xIWGs4VUZ4NVVGNTBXems0dU1OMW9SdHJ2aGllbGg3OVRJ?=
 =?utf-8?B?Q08yaUs1a3Eybi9qdFZ0S3Z3eFhtZkdvYldkUFk0ZUw2U01meGlpdVE0QkxB?=
 =?utf-8?B?cGE2cHpxalVWUHRsUGh3aG11UHVoZkFtT3hiNEJIbDdCdFVWQWFDbTVLTCtt?=
 =?utf-8?B?WG1CYURDVDlkWWJzZ3NhcWxaZ2VJZTlsalRILyt4M0ZvTklkNVlOWkFScW1U?=
 =?utf-8?B?VHF4OXllVzVCQzNrT3FKV1MyaHRpZnp6bUx5d05abkIwWHpMZElhb0tOSjRW?=
 =?utf-8?B?aDNNZ3dqckxHbmR6ZFFROVhqTDFBbzFpMzlEOGFWcktXdk1UeXN1cTg2UlBj?=
 =?utf-8?B?aE13dEpGS3htdHZMdTl2QXlKTFQ1Z1B5YXV1QXg4ZFM5MHRUOVg2NWRKb1RU?=
 =?utf-8?B?QmNreFYxTUhXK1ZxN2x6bTZadjBJVG0rcUxtR1UxTDVOZEFLSUR1aXB0VFh0?=
 =?utf-8?B?UjRRRDE2S0tzd0cvNmdySUlxTFpoUlZ6SXp0RlVFYUd2N3R2bzBXWmVSdTI0?=
 =?utf-8?B?blhtTW5sNEYrWlErVHJSMVJjbTB5dGF4M3k0QkRlVGRvRmhLVmhOMFJPMVJk?=
 =?utf-8?B?QVcycXdMb21WMjdPT2pLakNnUVVvb2oyNTRuVmdPcjNOU0Nac1pJZTNYcFRU?=
 =?utf-8?B?eDFZYmlWSFIyU1JvL085MWwxSzhHMldreEN6c1dwS0t4dE1zTCsrY1FvWklo?=
 =?utf-8?B?NEVjSkdMLzBnNy9Jb1VGbk1GMXV1a1pQTU1oMzRjMEJQcE8rWmxGRUlIMnJi?=
 =?utf-8?B?TlR6MkVlMGxoczRYNWhjeE04VVpxSFBDaXNjcDE4c1pURjNuYml4SWpya3Nq?=
 =?utf-8?B?aElvRm1WTlp1K05USG9jWHdWbTRjdU9kcUt4TUgrTTN2UnhYclNTS2xMRy9H?=
 =?utf-8?B?WHFWVEM3SEZBTUN1cGZzdTkveFdvaTdZMGdSUzc4RWN5MzF3WkhNNGsrUWpH?=
 =?utf-8?B?M25rVW8wNU1aTytucFI0Z3BBdWFycjNZZmFzaC9jaU9URFpzNG85ME1mcjlG?=
 =?utf-8?B?M1hzNCtKTitsYWtmcnNZZWRISy9QaWUrR3RhZEtJNXUzSkVQcUc5QnY1VXBC?=
 =?utf-8?B?M0lhc2pIUFkxRkE4MTY2RmZUaERvbFdrc2JJa2JGSDNkbUNUUFZFeDZnWjg0?=
 =?utf-8?B?Yk10cGlSdXhrUGpTYkdpSlo5c2dzM0lrbk1pdXo3T3pvL0ZNaVdSaTZDNVZu?=
 =?utf-8?B?dVowOFNKRnYvSmxBVTE2ZEZ6dTUvUnNIT3QxVUdiTEFDK3hjdjZ0N2hRRWRz?=
 =?utf-8?B?dG82OHJuYU81VjlTZVFoY1BOME82RHFVQU9HdnNPYVBKcjh1UUEzVGFDNTNs?=
 =?utf-8?B?cmhSUW5FTDFCZVJkS3VvVktHMUx5M3B5S1ZFTkNlNlJLdGlvUThxVWFZL0pT?=
 =?utf-8?B?Z1g2VkFMVzU5L2RVREMvLzVTSUZjejd6dkQ2SUplb2xvZFA1ZGJxQVc4YnM4?=
 =?utf-8?B?RWEzemJ2eGdydDBEa3htaVk5NjJ3aTdVdGpvd3BCUVRidmZwcUFjRlV4YmdR?=
 =?utf-8?B?TUx0QWo4M3BFQzNLYmtNeXV4cnE3QkVkSlJxd3c2WC9JTmpEU2QxMEJCUHFF?=
 =?utf-8?B?UU5QaCsyWkt3Ni80TUpiL0FRZHNvdEM5WXNmYytHZ3dVOVdGaHZYSTJlR2l4?=
 =?utf-8?B?SlpLcGlCekJkQnFaL1pDc3IvalQrbkpMZ2l2MFV4QzZvR2tVRGMyQ1ZvQUk4?=
 =?utf-8?B?WnJjcGUyRUNHbEtPRktidGg3VDNmL0dvdElrNklObCsrbTdnOE5IQmJvbW9n?=
 =?utf-8?B?U2hXNXdJZUo4N1ZBTFBNWHU1Z1B2aTcvQkZyNmxnQ29NSDI1cnpEMnY4VTlK?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38D1CB2F22D0CC4D96C0940C9D20AFCD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26637f8a-48c6-43a2-4c4c-08dbde8c0d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 05:48:49.8944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddVU69Dz4yQRsP00xM32dqZ+KQD6zvdoGMWcDRmSuTRRraJcq2a2xb/zsx7eB9+Q/henygAbjXQl6JnlQS4qwUVqK/ruINtJRrJi31Ckyws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7977
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTA2IGF0IDAzOjExICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gT24gTW9uLCAyMDIzLTExLTA2IGF0IDAyOjU5ICswMDAwLCBKYXNvbi1KSCBMaW4gKOae
l+edv+elpSkgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIzLTExLTA2IGF0IDAxOjI3ICswMDAwLCBD
SyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiA+IE9uIFN1biwgMjAyMy0xMS0wNSBhdCAxMzow
NCArMDAwMCwgSmFzb24tSkggTGluICjmnpfnnb/npaUpIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUs
IDIwMjMtMTAtMzEgYXQgMDY6MDEgKzAwMDAsIENLIEh1ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiA+
ID4gPiA+IEhpLCBKYXNvbjoNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBNb24sIDIwMjMtMTAt
MjMgYXQgMTI6NDUgKzA4MDAsIEphc29uLUpILkxpbiB3cm90ZToNCj4gPiA+ID4gPiA+IFRvIGFk
ZCBzZWN1cmUgZmxvdyBzdXBwb3J0IGZvciBtZWRpYXRlay1kcm0sIGVhY2ggY3J0YyBoYXZlDQo+
ID4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+ID4gY3JlYXRlIGEgc2VjdXJlIGNtZHEgbWFpbGJveCBj
aGFubmVsLiBUaGVuIGNtZHEgcGFja2V0cw0KPiA+ID4gPiA+ID4gd2l0aA0KPiA+ID4gPiA+ID4g
ZGlzcGxheSBIVyBjb25maWd1cmF0aW9uIHdpbGwgYmUgc2VudCB0byBzZWN1cmUgY21kcQ0KPiA+
ID4gPiA+ID4gbWFpbGJveA0KPiA+ID4gPiA+ID4gY2hhbm5lbA0KPiA+ID4gPiA+ID4gYW5kIGNv
bmZpZ3VyZWQgaW4gdGhlIHNlY3VyZSB3b3JsZC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
RWFjaCBjcnRjIGhhdmUgdG8gdXNlIHNlY3VyZSBjbWRxIGludGVyZmFjZSB0byBjb25maWd1cmUN
Cj4gPiA+ID4gPiA+IHNvbWUNCj4gPiA+ID4gPiA+IHNlY3VyZQ0KPiA+ID4gPiA+ID4gc2V0dGlu
Z3MgZm9yIGRpc3BsYXkgSFcgYmVmb3JlIHNlbmRpbmcgY21kcSBwYWNrZXRzIHRvDQo+ID4gPiA+
ID4gPiBzZWN1cmUNCj4gPiA+ID4gPiA+IGNtZHENCj4gPiA+ID4gPiA+IG1haWxib3ggY2hhbm5l
bC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSWYgYW55IG9mIGZiIGdldCBmcm9tIGN1cnJl
bnQgZHJtX2F0b21pY19zdGF0ZSBpcyBzZWN1cmUsDQo+ID4gPiA+ID4gPiB0aGVuDQo+ID4gPiA+
ID4gPiBjcnRjDQo+ID4gPiA+ID4gPiB3aWxsIHN3aXRjaCB0byB0aGUgc2VjdXJlIGZsb3cgdG8g
Y29uZmlndXJlIGRpc3BsYXkgSFcuDQo+ID4gPiA+ID4gPiBJZiBhbGwgZmJzIGFyZSBub3Qgc2Vj
dXJlIGluIGN1cnJlbnQgZHJtX2F0b21pY19zdGF0ZSwgdGhlbg0KPiA+ID4gPiA+ID4gY3J0Yw0K
PiA+ID4gPiA+ID4gd2lsbA0KPiA+ID4gPiA+ID4gc3dpdGNoIHRvIHRoZSBub3JtYWwgZmxvdy4N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxq
YXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICB8IDI3Mg0KPiA+ID4gPiA+
ID4gKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9jcnRjLmggIHwgICAxICsNCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jIHwgICA3ICsNCj4gPiA+ID4gPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDI2OSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPiA+ID4g
PiA+IA0KPiA+ID4gDQo+ID4gPiBbc25pcF0NCj4gPiA+IA0KPiA+ID4gPiA+ID4gKw0KPiA+ID4g
PiA+ID4gKyNpZiBJU19SRUFDSEFCTEUoQ09ORklHX01US19DTURRKQ0KPiA+ID4gPiA+ID4gK3N0
YXRpYyB2b2lkIG10a19jcnRjX2VuYWJsZV9zZWN1cmVfc3RhdGUoc3RydWN0IGRybV9jcnRjDQo+
ID4gPiA+ID4gPiAqY3J0YykNCj4gPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gPiArCWVudW0gY21k
cV9zZWNfc2NlbmFyaW8gc2VjX3NjbiA9IENNRFFfTUFYX1NFQ19DT1VOVDsNCj4gPiA+ID4gPiA+
ICsJaW50IGk7DQo+ID4gPiA+ID4gPiArCXN0cnVjdCBtdGtfZGRwX2NvbXAgKmRkcF9maXJzdF9j
b21wOw0KPiA+ID4gPiA+ID4gKwlzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YyA9IHRvX210
a19jcnRjKGNydGMpOw0KPiA+ID4gPiA+ID4gKwl1NjQgc2VjX2VuZ2luZSA9IDA7IC8qIGZvciBo
dyBlbmdpbmUgd3JpdGUgb3V0cHV0DQo+ID4gPiA+ID4gPiBzZWN1cmUgZmIgKi8NCj4gPiA+ID4g
PiA+ICsJdTY0IHNlY19wb3J0ID0gMDsgLyogZm9yIGxhcmIgcG9ydCByZWFkIGlucHV0IHNlY3Vy
ZSBmYg0KPiA+ID4gPiA+ID4gKi8NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsJY21kcV9w
a3Rfd2ZlKCZtdGtfY3J0Yy0+c2VjX2NtZHFfaGFuZGxlLCBtdGtfY3J0Yy0NCj4gPiA+ID4gPiA+
ID4gY21kcV9ldmVudCwNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZmFsc2UpOw0KPiA+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ID4gKwlkZHBfZmlyc3RfY29tcCA9IG10a19jcnRjLT5kZHBfY29t
cFswXTsNCj4gPiA+ID4gPiA+ICsJZm9yIChpID0gMDsgaSA8IG10a19jcnRjLT5sYXllcl9ucjsg
aSsrKQ0KPiA+ID4gPiA+ID4gKwkJaWYgKG10a19jcnRjLT5wbGFuZXNbaV0udHlwZSA9PQ0KPiA+
ID4gPiA+ID4gRFJNX1BMQU5FX1RZUEVfQ1VSU09SKQ0KPiA+ID4gPiA+ID4gKwkJCXNlY19wb3J0
IHw9DQo+ID4gPiA+ID4gPiBtdGtfZGRwX2NvbXBfbGF5ZXJfZ2V0X3NlY19wb3J0KGRkcF9maXJz
dF9jb21wLCBpKTsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsJaWYgKGRybV9jcnRjX2lu
ZGV4KGNydGMpID09IDApDQo+ID4gPiA+ID4gPiArCQlzZWNfc2NuID0gQ01EUV9TRUNfUFJJTUFS
WV9ESVNQOw0KPiA+ID4gPiA+ID4gKwllbHNlIGlmIChkcm1fY3J0Y19pbmRleChjcnRjKSA9PSAx
KQ0KPiA+ID4gPiA+ID4gKwkJc2VjX3NjbiA9IENNRFFfU0VDX1NVQl9ESVNQOw0KPiA+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ID4gKwljbWRxX3NlY19wa3Rfc2V0X2RhdGEoJm10a19jcnRjLT5zZWNf
Y21kcV9oYW5kbGUsDQo+ID4gPiA+ID4gPiBzZWNfZW5naW5lLA0KPiA+ID4gPiA+ID4gc2VjX3Bv
cnQsIHNlY19zY24pOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEluIGNtZHEgZHJpdmVyLCBzZWNf
ZW5naW5lIG1lYW5zIGVuZ2luZSB3aGljaCBuZWVkIGRhcGMuIFlvdQ0KPiA+ID4gPiA+IHNldA0K
PiA+ID4gPiA+IDANCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+IHNlY19lbmdpbmUsIGRvZXMgaXQg
bWVhbiB0aGF0IG5vIGVuZ2luZSBpcyBwcm90ZWN0ZWQgYnkgZGFwYz8NCj4gPiA+ID4gPiBJZg0K
PiA+ID4gPiA+IE9WTA0KPiA+ID4gPiA+IGlzDQo+ID4gPiA+ID4gbm90IHByb3RlY3RlZCBieSBk
YXBjLCBJIHRoaW5rIHdlIGNvdWxkIHVzZSBjbWRxIG5vcm1hbA0KPiA+ID4gPiA+IHRocmVhZA0K
PiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gd3JpdGUNCj4gPiA+ID4gPiBPVkwgcmVnaXN0ZXIgaW5z
dGVhZCBvZiBjbWRxIHNlY3VyZSB0aHJlYWQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
PiBXZSBlbmFibGUgRFBBQyBwcm90ZWN0aW9uIGZvciB0aGUgZW5naW5lIHRoYXQgaXMgYWJsZSB0
byB3cml0ZQ0KPiA+ID4gPiBkYXRhDQo+ID4gPiA+IHRvDQo+ID4gPiA+IHRoZSBEUkFNIGFkZHJl
c3Mgc2V0IG9uIHRoZWlyIHJlZ2lzdGVyLCBzdWNoIGFzIFdETUEgYW5kIFdST1QsDQo+ID4gPiA+
IHRvDQo+ID4gPiA+IGF2b2lkDQo+ID4gPiA+IHRoZWlyIHJlZ2lzdGVyIGJlaW5nIHNldCB0byB0
aGUgbm9ybWFsIERSQU0gYWRkcmVzcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFdlIGVuYWJsZSBsYXJi
IHBvcnQgcHJvdGVjdGlvbiBmb3IgdGhlIGVuZ2luZSB0aGF0IGlzIGFibGUgdG8NCj4gPiA+ID4g
cmVhZA0KPiA+ID4gPiBkYXRhDQo+ID4gPiA+IGZyb20gdGhlIERSQU0gYWRkcmVzcywgc3VjaCBh
cyBPVkwsIFJETUEgYW5kIE1EUF9SRE1BLCB0byBhdm9pZA0KPiA+ID4gPiBzZWN1cmUNCj4gPiA+
ID4gRFJBTSBiZWluZyByZWFkIGJ5IHRoZSBub24tc2VjdXJlIGxhcmIgcG9ydC4gU28gd2UgZG9u
J3QgbmVlZA0KPiA+ID4gPiB0b2VuYWJsZQ0KPiA+ID4gPiBEQVBDIGZvciB0aGVzZSBlbmdpbmVz
Lg0KPiA+ID4gPiANCj4gPiA+ID4gTm8gbWF0ZXIgREFQQyBwcm90ZWN0aW9uIG9yIGxhcmIgcG9y
dCBwcm90ZWN0aW9uLCB0aGV5IGJvdGgNCj4gPiA+ID4gbmVlZA0KPiA+ID4gPiB0bw0KPiA+ID4g
PiB1c2UNCj4gPiA+ID4gc2VjX2VuZ2luZSB0byB0ZWxsIFRFRSB3aGljaCBlbmdpbmVzIG5lZWQg
dG8gYmUgcHJvdGVjdGVkLg0KPiA+ID4gPiANCj4gPiA+ID4gQnV0IE9WTCBpcyBhIHNwZWNpYWwg
SFcgZW5naW5lLCBpdCBjYW4gb25seSBzZXQgaXRzDQo+ID4gPiA+IERJU1BfUkVHX09WTF9TRUNV
UkUNCj4gPiA+ID4gcmVnaXN0ZXIgaW4gW1BBVENIIHYyIDA3LzExXSB0byBlbmFibGUgaXRzIGxh
cmIgcG9ydA0KPiA+ID4gPiBwcm90ZWN0aW9uLA0KPiA+ID4gPiBzbw0KPiA+ID4gPiBPVkwNCj4g
PiA+ID4gbm8gbmVlZCB0byBzZXQgdGhlIHNlY19lbmdpbmUuIEJ1dCB3ZSdsbCBtb3ZlIHRoYXQg
cGFydCB0byB0aGUNCj4gPiA+ID4gVEVFDQo+ID4gPiA+IHNlY3VyZSB3b3JsZCwgc28gdGhhdCBt
ZWFucyBPVkwgc2VjX2VuZ2luZSB3aWxsIGJlIHNldCBoZXJlIGluDQo+ID4gPiA+IHRoZQ0KPiA+
ID4gPiBuZXh0DQo+ID4gPiA+IHZlcnNpb24uDQo+ID4gPiA+IA0KPiA+ID4gPiA+IEl0J3Mgd2Vp
cmQgdGhhdCBub3JtYWwgd29ybGQgY291bGQgZGVjaWRlIHdoaWNoIGVuZ2luZSBpcw0KPiA+ID4g
PiA+IHByb3RlY3RlZA0KPiA+ID4gPiA+IGJ5DQo+ID4gPiA+ID4gZGFwYy4gSWYgaGFja2VyIHNl
dCAwIGZvciBvdXRwdXQgZW5naW5lLCB0aGVuIG91dG91dCBlbmdpbmUNCj4gPiA+ID4gPiB3b3Vs
ZA0KPiA+ID4gPiA+IG5vdA0KPiA+ID4gPiA+IGJlIHByb3RlY3RlZD8NCj4gPiA+ID4gPiANCj4g
PiA+ID4gDQo+ID4gPiA+IElmIGhhY2tlciBzZXQgMCBmb3Igb3V0cHV0IGVuZ2luZSwgVEVFIHdv
cmxkIHdpbGwgY2hlY2sgdGhhdA0KPiA+ID4gPiBvdXRwdXQNCj4gPiA+ID4gZW5naW5lIGRpZG4n
dCBzZXQgc2VjX2VuZ2luZSBmcm9tIG5vcm1hbCB3b3JsZCBieSB2ZXJpZnlpbmcNCj4gPiA+ID4g
aW5zdHJ1Y3Rpb24NCj4gPiA+ID4gd2hlcmUgdGhlIG91dHB1dCBlbmdpbmUgaW5zdHJ1Y3Rpb24g
c2V0IHRoZSBzZWN1cmUgaGFuZGxlLg0KPiA+ID4gPiANCj4gPiA+ID4gV2Ugc3RpbGwgbmVlZCB0
byBzZXQgc2VjX2VuZ2luZSB0byBjaGVjayB0aGF0IGFsbCB0aGUNCj4gPiA+ID4gc2VjX2VuZ2lu
ZQ0KPiA+ID4gPiBmYWdzDQo+ID4gPiA+IGFyZSBtYXRjaGVkIHRvIHRoZSBzY2VuYXJpbyBhbmQg
aW5zdHJ1Y3Rpb24gdmVyaWZpY2F0aW9uIGluIHRoZQ0KPiA+ID4gPiBzZWN1cmUNCj4gPiA+ID4g
d29ybGQuDQo+ID4gPiANCj4gPiA+IFNvIGFmdGVyIHNlY3VyZSBzY2VuYXJpbyBpcyBzZXQsIFRF
RSBhbHJlYWR5IGhhdmUgYSBzZWNfZW5naW5lDQo+ID4gPiBsaXN0Lg0KPiA+ID4gTGV0J3MgY2Fs
bCBpdCBURUUgc2VjX2VuZ2luZSBsaXN0LiBBbmQgbm9ybWFsIHdvcmxkIGhhcyBhbm90aGVyDQo+
ID4gPiBzZWNfZW5naW5lIGxpc3QsIGxldCdzIGNhbGwgaXQgbm9ybWFsIHNlY19lbmdpbmUgbGlz
dC4gTm9ybWFsDQo+ID4gPiB3b3JsZA0KPiA+ID4gcGFzcyBub3JtYWwgc2VjX2VuZ2luZSBsaXN0
IHRvIFRFRSBieSBjbWRxX3NlY19wa3Rfc2V0X2RhdGEoKSBhbmQNCj4gPiA+IFRFRQ0KPiA+ID4g
d291bGQgY2hlY2sgbm9ybWFsIHNlY19lbmdpbmUgbGlzdCBpcyBpZGVudGljYWwgdG8gVEVFIHNl
Y19lbmdpbmUNCj4gPiA+IGxpc3QNCj4gPiA+IG9yIG5vdC4gSWYgVEVFIGFscmVhZHkgaGF2ZSBh
IFRFRSBzZWNfZW5naW5lIGxpc3QsIEkgdGhpbmsgaXQncw0KPiA+ID4gbm90DQo+ID4gPiBuZWNl
c3NhcnkgdGhhdCBub3JtYWwgd29ybGQgaGF2ZSBhbm90aGVyIG5vcm1hbCBzZWNfZW5naW5lIGxp
c3QuDQo+ID4gPiBTbw0KPiA+ID4gZHJvcCB0aGlzIG5vcm1hbCBzZWNfZW5naW5lIGxpc3QgcGFy
YW1ldGVyLg0KPiA+ID4gDQo+ID4gDQo+ID4gVGhlIFRFRSBzZWNfZW5naW5lIGxpc3QgaXMgYWxp
Z24gdG8gdGhlIHNlY19lbmdpbmUgbGlzdCBpbiBub3JtYWwNCj4gPiB3b3JsZC4gSSB0aGluayB0
aGUgc2VjX2VuZ2luZSBmb3IgREFQQyBjYW4gYmUgZHJvcHBlZCBhbmQgaXQgY2FuIGJlDQo+ID4g
ZW5hYmxlZC9kaXNhYmxlZCBieSB0aGUgVEVFIHNlY19lbmdpbmUsIGJ1dCB0aGUgc2VjX2VuZ2lu
ZSBmb3IgbGFyYg0KPiA+IHBvcnQgd29uJ3QgZG8gdGhhdCB2ZXJpZmljYXRpb24gaW4gdGhlIHNl
Y3VyZSB3b3JsZC4gSWYgc2VjX2VuZ2luZQ0KPiA+IGZvcg0KPiA+IGxhcmIgcG9ydCBpcyBub3Qg
c2V0IGluIG5vcm1hbCB3b3JsZCwgaXQnbGwgY2F1c2UgaW92YSB0cmFuc2xhdGlvbg0KPiA+IGZh
dWx0LiBTbyB3ZSBzdGlsbCBuZWVkIHRoaXMgc2VjX2VuZ2luZSBmb3IgbGFyYiBwb3J0Lg0KPiAN
Cj4gSW4gVEVFLCB0aGVyZSBpcyBhbHJlYWR5IGEgVEVFIHNlY19lbmdpbmUgbGlzdCwgc28gY2hl
Y2tpbmcgbGFyYiBwb3J0DQo+IGNvdWxkIHVzZSBURUUgc2VjX2VuZ2luZSBsaXN0IGJlY2F1c2Ug
VEVFIHNlY19lbmdpbmUgbGlzdCB3b3VsZCBiZQ0KPiBpZGVudGljYWwgdG8gbm9ybWFsIHNlY19l
bmdpbmUgbGlzdC4gV2h5IG5vdCB1c2UgVEVFIHNlY19lbmdpbmUgbGlzdA0KPiB0bw0KPiBjaGVj
ayBsYXJiIHBvcnQ/IFdoYXQgaXMgdGhlIGRldGFpbCBvZiBjaGVja2luZyBsYXJiIHBvcnQ/IERl
c2NyaWJlDQo+IGl0DQo+IGlmIG5lY2Vzc2FyeS4NCj4gDQpBZnRlciBjaGVja2luZyB0aGUgQ01E
USBQVEEgbGFyYiBwb3J0IGVuYWJsZS9kaXNhYmxlIGZsb3csIEkgdGhpbmsgaXQncw0KcG9zc2li
bGUgdG8gaW1wbGVtZW50IHRoZSBzYW1lIHZlcmlmaWNhdGlvbiBsaWtlIERBUEMgZm9yIGxhcmIg
cG9ydC4NClNvIEknbGwgZHJvcCB0aGUgc2VjX2VuZ2luZSBmbGFncyBpbiBub3JtYWwgd29ybGQg
dG8gc2ltcGxpZnkgYW5kIGRlLQ0KcmlzayBmb3IgdGhlIHNlY3VyZSBjb25maWd1cmF0aW9uIHBh
cmFtZXRlcnMuDQoNClRoaXMgYWxzbyBuZWVkIHRvIGFkZCBhIFRPRE8gb24gY29tbWl0IG1lc3Nh
Z2U6DQp2ZXJpZnkgaW5zdHJ1Y3Rpb24gZm9yIGVuYWJsaW5nL2Rpc2FibGluZyBsYXJiIHBvcnQg
aW4gc2VjdXJlIHdvcmxkIGFuZA0KZHJvcCB0aGUgc2VjX2VuZ2luZSBmbGFncyBpbiBub3JtYWwg
d29ybGQuDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBSZWdhcmRzLA0KPiBDSw0KPiAN
Cj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IEphc29uLUpILkxpbg0KPiA+IA0KPiA+ID4gUmVnYXJk
cywNCj4gPiA+IENLDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+
IEphc29uLUpILkxpbg0KPiA+ID4gPiANCj4gPiA+ID4gPiBSZWdhcmRzLA0KPiA+ID4gPiA+IENL
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArCXByX2RlYnVnKCJjcnRj
LSVkIGVuYWJsZSBzZWN1cmUgcGxhbmUhXG4iLA0KPiA+ID4gPiA+ID4gZHJtX2NydGNfaW5kZXgo
Y3J0YykpOw0KPiA+ID4gPiA+ID4gK30NCj4gPiA+ID4gPiA+ICsjZW5kaWYNCj4gPiA+ID4gPiA+
IA0K
