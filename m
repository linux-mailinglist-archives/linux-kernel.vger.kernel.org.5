Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70717D4992
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjJXIMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjJXIMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:12:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED48120;
        Tue, 24 Oct 2023 01:12:49 -0700 (PDT)
X-UUID: 1c254932724511eea33bb35ae8d461a2-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MDCrER3R3NjemRutREgbKHJiizhS0ITOqBR6VsbawP4=;
        b=I/OEokQw/G4JEPD/wfhiO4LdNaCiOMr/WZi+bM6UW8fTC7fHbtvbfbtdT/lp8OmobhZSaKGD7HlpiQHSz7jegKoahRAGEdui2Cvi010r4psj8x1fdJ6AeI/yuKhrULJvU/uUw1bf5hJzycHRt4S4SJYDJ6SXnye/OC+pylGZzWc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:fd2331a2-f478-4bac-b314-79f50a2ff511,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:841e40d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1c254932724511eea33bb35ae8d461a2-20231024
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2132815608; Tue, 24 Oct 2023 16:12:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 16:12:42 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 16:12:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlrYVEE3sEugsQb/NWMuc3r/QvqzbMhxgqdeVmMcDPRg7eB6Jzq94MYMHcz4DzQgwMKLY3wELeGalifjCFO4gDDQRCZBaYSRVfd+SP5eCZruj2R7FqGHJeazhyiAN54VbygKkZ0TbjgzVq5EhBGiHxQvldroeJ6bCkLl0HN9/nW3Hrl+84mRqHezV6xXUCvCf+mzM5+Gz1wptT5wq8f6PiAlZ93yS47Kx8gfceHE4rmJqzN3Gbiu0mngq1/IdgsYDfbFR7oSNLj8PIrBkTn1+hDnQPxaRQVRnLZwULYLNWVwI6EshopIM8b2c6AIQ/rIAjP2WT8PSwLeP9NC9ynFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDCrER3R3NjemRutREgbKHJiizhS0ITOqBR6VsbawP4=;
 b=SokuzrZQTdUBI2YeucTe9QJu9OSUIXRcMg4/BhnL8lmMhUnAh3Vhosv4bGu2V+I2QPrFuPQ0Cz/+atPQLWldsEY/VnmXLsDCcXQws9W3Vc5m98hrOROY2yYMhRJIbo/7Mbb0/ZJqDWzwotUkWhs+JuUYd9RH8AcUI/KArqL2UXq39J5wFJDpf+hs0cvFJVBKf6/TDcSOYqwmg96eQJ75o3J2HogjAiBGWQ0oY0lCVwuKYCE6q71ZNtlGwBpWh3l0cmtypKxK4SR2HJMkkgTRRYTz9dw9C+9KESiueSlMJLvVM8Ezx9tM6XqoJrWnfXsOYQl59uBcWTmjaVjUKJX0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDCrER3R3NjemRutREgbKHJiizhS0ITOqBR6VsbawP4=;
 b=bzHB22WjZoWaIZKnxM4fgy8ff87bKGTa6/1AlZld06KMd/TtenIpi8rV2yPthRov1NhfzGISnXp4wG5o0/YHKF6pyhU1NV2ajhDXfL5PBwFin5vGHG0SI2tFXBdTY/iG4rWdO0zqVgaDZrrAJfFWryDoD4IXLgWOlLaISCyY49w=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7857.apcprd03.prod.outlook.com (2603:1096:400:482::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 08:12:41 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3%4]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 08:12:41 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v10 14/24] drm/mediatek: Power on/off devices with
 function pointers
Thread-Topic: [PATCH v10 14/24] drm/mediatek: Power on/off devices with
 function pointers
Thread-Index: AQHaAlEgSzz/NhH8IU+6QfHXPElRprBYnxQA
Date:   Tue, 24 Oct 2023 08:12:40 +0000
Message-ID: <d01f4e1753d3880b8c096c2f69adf19c1f136c8b.camel@mediatek.com>
References: <20231019055619.19358-1-shawn.sung@mediatek.com>
         <20231019055619.19358-15-shawn.sung@mediatek.com>
In-Reply-To: <20231019055619.19358-15-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7857:EE_
x-ms-office365-filtering-correlation-id: 7fb0f0f3-06f4-4932-6736-08dbd468fe38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PXdxIXVXLZjc2tAhBBkjokbbZ+8Z8CR4nFpvV9IhMR0tqy1gOhXnIVY5rHcowm7QmJzHWMZVxBFfsWXGczEzEp+izB2XSPTJ2skmsnhDwG4LD+1qhymM1j1C0+QYYNhllJ5c9TPYjfc8+Zl/OFyISmUuYPsJDUdadB1U8JeWT6rGervzcvePKEUGD8qda8D1VR/wpgqNLPSBuaOZ7Br5gLxeAaMjFR4pLxW8NfVPWKUtsYxJmEc6WaWKpgxNZ+rppXP6XBQMPg5wDPqhEPOH5gz45b9vYP/z269mmZn3qUQTF8x+Ojiloys5NjLn+slxRkIJO9UNEiCLJpHmu8jEnehVwwIg8XfYl4B+0oYk3awpxYyv2UbtgNlnrsCsLGEpPwRMl1mI7ekOmW+dLqEzVWkGcF7RGojbdCnhDhd4wbZMOzgWPu/4JXdVKC/Fa377/kdYxyzFEbdX1Gs1nkT2GzCbsE3axprQcr9JCPhGWP1lTu3F/vK5tuxCoR0+KHliwHyVVgMlmABhZd7kL0FuHT6QNR07CrdLDcT7mDfl9nKTBqiYqPx769cLKpIg2ZdMbCpp6sQlVDyYyFetGpSQO58nJ8nfjzeLsog+aK1h9eh7/isfTCcatNm9ZAQ2AlchUtyvw8mpqgo71gBoqIEUrUXT9Ym0/iwAcib3y5mPBJQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(122000001)(38070700009)(38100700002)(83380400001)(26005)(2616005)(478600001)(71200400001)(6512007)(6506007)(6486002)(54906003)(76116006)(66556008)(66476007)(316002)(66946007)(8936002)(66446008)(64756008)(110136005)(41300700001)(4326008)(8676002)(5660300002)(86362001)(4001150100001)(7416002)(2906002)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm1WNm02UlVKZkk5YVRIbWwxUXVKcm5OTFJVcGdnQmtNSk1UNmZRMGxNSk52?=
 =?utf-8?B?ZGJlYndkQU9XSWQ3RFB1c1dZblEvcXFEYXZlMG9NTGo0aFR1aEQrejc0N2Z5?=
 =?utf-8?B?QkpwQVJpbTZ3SzdlRE81akRPazQybVFlUStySVlpZzdhOWpKdklIVW5BOEdF?=
 =?utf-8?B?MGoxbnRpZHhTMjhlU1dGWklxTXA5SlFpVjBnSjRvcFp2bGJDVjZ4eStrV09u?=
 =?utf-8?B?WDNkVG5DWlVwQ3R0NDlGbmxCNnlNZW5XcG96UHBTZ3ZOU2lPN0hENTIwaTJT?=
 =?utf-8?B?bE54aVRJaU4weHFOSkxtTGdOQURDZXhaVW02cHEwOHB2dHp5UWJFSU1pYzFt?=
 =?utf-8?B?a0kwWFJ0aWZnRmhxNGJaaXJMNkJiTUwyNStRdUh0WitWa3pqQ1JkbXFkVUx6?=
 =?utf-8?B?aUx5L213cFhqeFhXUndsSGhqNFRyWTZsQ0x0c3hrZlBKeno4TmFKZmMzTlVI?=
 =?utf-8?B?aWxSL3orbERDdktDbmlYZlRyZm1LaUF6VElkYWJaRkk2OEVJL1E4Y0pJNVQx?=
 =?utf-8?B?dUE0VDdIU0puVXd0clZLdHZGRHR1TXRkUExTZExhQ0ZqZ2pBY00vMnNvUlF5?=
 =?utf-8?B?TjZ4d2dvZHprMGJVMGUzN0FHTzl4Y1hLOGwvLzNYTDZkYTgzc2VMWkFPMUIr?=
 =?utf-8?B?dnN2SWtRWTJZb1JBNnNZMHZLM2g3Yi9BV3JGUjhDVWswaW5FUkx0NFVhNzdP?=
 =?utf-8?B?V1Z3TE5xNDFEQ2pCRkF6UUNOM1BUQ21WMVdQanRyOFllR3c4MXdSTmY1bkV2?=
 =?utf-8?B?b3VpbUVVY0Q5N09JRGZ2U3ZBTUh0Nk05S3RmM2VETUFISFJKSnM0eHZjKzg4?=
 =?utf-8?B?VlJUbkMyRTg2eEFBR282b2FpQ0dtNzRmZVdtYVdCcURNZ2Q3c3hIZ1A1MlRm?=
 =?utf-8?B?MmI2RWVoNHdSSVc4MHJiWDBpc3EyaGVqck1KbzNkVXBPeG0raWNrUmt2Snpt?=
 =?utf-8?B?ZFhaTEkvZGd3R2g2Y0F0V3RMK3NSQnIzbmFNb0JKU1RMVUFZY2hreDVSVE9n?=
 =?utf-8?B?VDRMNm1ua2xNZ0ZqaWNRc0xleWc0NlFEODA5MEtMV2lOVFJ0NkJHc2xsMTNZ?=
 =?utf-8?B?MlVpRlFRUGp3UDhiMEMzRDVLMzVjMDBEOUlQVVk5UGNoZjhybjNaMDBQeStu?=
 =?utf-8?B?MG1GRnRxVFdiYWpTS1g4WFA5YUxhZVNTcUxienFTMFppcUdlN0JUQ2VHcnhI?=
 =?utf-8?B?UkpWaW1Wb2QyOENNdEhnM2xvbis3ZjJHblZCQ3FkZHR3RGFYSjZYZEtpcWhj?=
 =?utf-8?B?clduRStXWjN1Tmt5dWNncXhvb1RWZXdMTjZ1Sks2YlJFUWI1YmMyU1dobUk3?=
 =?utf-8?B?OFpiZHU1c1Q5ZFRVejk2RkxzcnNXR0tsSCtXNFlnNURTWDdBd3czWGkwSjhS?=
 =?utf-8?B?OVZnMmdjT2NIL1hicUhZUFF6ZXRGR1pSYzhkWlQ1NFZ3NzZtZnBZaFIwNzBG?=
 =?utf-8?B?SW93Q3JGS1BFbHc3b0FGL2Y2dmJpV0tDdWtPeTR6ZTlDV2hPYWNmRVJDZGps?=
 =?utf-8?B?cnBqYndvVWZMQUx5eDVla3Y5RDg0ODAzWDB5RW9nV0RpdzljWk5WcXFhcW1S?=
 =?utf-8?B?My9YbjZST2xEeDZOVk05NVUvS2xHczhteDFsQzV0S2RiVXVUMmZGMUpjMzgx?=
 =?utf-8?B?Y1czMlg1S0x5ODVtdHFoc3JyRDdPN3lQRVFaeVdSQlZ2SjN2N0FXTVU3NHBk?=
 =?utf-8?B?M3hTbHpFa0F6SldtSGlpS3ltZXdjVVlDNFlGQ3JoZEhmV0R5UmZGTVY4a1lx?=
 =?utf-8?B?ay91ZVkyTEZCZGhVTVhBNHdZNlQ0OGI3b29mZVVQOS9OTmR5UnF5akJocmdX?=
 =?utf-8?B?NHFMREJFL3pYTDhvTVpNelpCZU05WktuNWRTMStVdTNVT1ZTcXF6VXArT1Z1?=
 =?utf-8?B?bDVCV25BZDA2UFRsZDFkZlVPK2M0d0NZaFVHWVk1c2pQRTFjOW9OMjVNeGcw?=
 =?utf-8?B?MHlEVWZiaExQMEVqb1R3TnFVYmZvTFNBdHRBNzkyOUdlVmVLWVp2bmdocFdO?=
 =?utf-8?B?NGcwaDBDM2dRVHZNRGY3OVhtQWdwT01BcVE5dlNvSnlLc1R6blRCRzZSRCtl?=
 =?utf-8?B?S2svaWh6aEU3MnRZMy8yMXZDK3BRYkcxVGtVSmFGeHZEenR6dUJxbUV2cEJj?=
 =?utf-8?Q?NXNlhJENTj/d8Iw6coSlD2tWe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC3A905C194B4D478BF58D302FAE2DC5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb0f0f3-06f4-4932-6736-08dbd468fe38
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 08:12:40.9812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RR/zVHOSK/MA51rseJnOTwBXYVEPeZsszj5p+Xnna+9cs++l9f/OhMuaV44u57zRItig/6e1ZAW7Rhj+K+4AFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7857
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.091300-8.000000
X-TMASE-MatchedRID: 6otD/cJAac0/XHdICuW5rya1MaKuob8PC/ExpXrHizx+YesuCgkiXIpv
        js0tCZ5OtmQ6b5fS6c89vqlZ6O698qLCTO1UKypvwe3HJzmxBMW+F//Mn3a2wyBs0OU9P6tbci7
        sFt/hNe2jmrD+IUq29ogmzRSnu+RYlDGXYtoZ5gD0mf9msa5zwYfsPVs/8Vw682HMiBe0UlVBTR
        ur1euDaWvx3MHWjkg7jT9P5y0g8a7sMtjYUbD8myNHByyOpYYCVnDkLUEBZnDDra5IbmQvVgKF0
        mkKX4aTJ8dRrx3bia6Vs4lq8QFlfjf6GcWCp0/ihK8o4aoss8p9LQinZ4QefKU8D0b0qFy9suf7
        RWbvUtyrusVRy4an8SAHAopEd76vORZDpUqjWiKhQD6nio3GXeHy9Xlpj8SkwmKCppxPIMgPQH+
        ShNZTpA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.091300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DF88569A98FA01D9787A73EEE4D52874241FA0CD6C16A2A88720E638AE2CBD632000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUaHUsIDIwMjMtMTAtMTkgYXQgMTM6NTYgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IERpZmZlcmVudCBmcm9tIE9WTCwgT1ZMIGFkYXB0b3Ig
aXMgYSBwc2V1ZG8gZGV2aWNlIHNvIHdlIGRpZG4ndA0KPiBkZWZpbmUgaXQgaW4gdGhlIGRldmlj
ZSB0cmVlLCBjb25zZXF1ZW50bHksDQo+IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKQ0KPiBj
YWxsZWQgYnkgLmF0b21pY19lbmFibGUoKSBwb3dlcnMgb24gbm8gZGV2aWNlLiBGb3IgdGhpcyBy
ZWFzb24sIHdlDQo+IGltcGxlbWVudCBhIGZ1bmN0aW9uIHRvIHBvd2VyIG9uIHRoZSBSRE1BcyBp
biBPVkwgYWRhcHRvciwgYW5kIHRoZQ0KPiBzeXN0ZW0gd2lsbCBtYWtlIHN1cmUgdGhlIElPTU1V
cyBhcmUgcG93ZXJlZCBvbiBhcyB3ZWxsIGJlY2F1c2Ugb2YNCj4gdGhlDQo+IGRldmljZSBsaW5r
IChpb21tdXMpIGluIHRoZSBSRE1BIG5vZGVzIGluIERUUy4NCj4gDQo+IFRoaXMgcGF0Y2ggc2Vw
YXJhdGVzIHBvd2VyIGFuZCBjbG9jayBtYW5hZ2VtZW50IHByb2Nlc3MsIGl0IHdvdWxkIGJlDQo+
IGVhc2llciB0byBtYWludGFpbiBhbmQgZXh0ZW5zaW9ucy4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1
IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVu
IFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCAgICAgICB8ICA0ICsNCj4gIC4uLi9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMgICB8IDc1ICsrKysrKysrKysrKysrKw0KPiAt
LS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgICAgICAgfCAx
MCArLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgICB8
ICAyICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggICB8
IDIwICsrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21kcF9yZG1hLmMgICAg
ICAgfCAxNiArKysrDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDEwNyBpbnNlcnRpb25zKCspLCAyMCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfZHJ2LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2
LmgNCj4gaW5kZXggYmYwNmNjYjY1NjUyLi44NDY1YmVlYWI0MzUgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gQEAgLTEwOSw2ICsxMDksOCBAQCB2b2lk
IG10a19vdmxfYWRhcHRvcl9jb25uZWN0KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gc3RydWN0IGRl
dmljZSAqbW1zeXNfZGV2LA0KPiAgCQkJICAgICB1bnNpZ25lZCBpbnQgbmV4dCk7DQo+ICB2b2lk
IG10a19vdmxfYWRhcHRvcl9kaXNjb25uZWN0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRl
dmljZQ0KPiAqbW1zeXNfZGV2LA0KPiAgCQkJCXVuc2lnbmVkIGludCBuZXh0KTsNCj4gK2ludCBt
dGtfb3ZsX2FkYXB0b3JfcG93ZXJfb24oc3RydWN0IGRldmljZSAqZGV2KTsNCj4gK3ZvaWQgbXRr
X292bF9hZGFwdG9yX3Bvd2VyX29mZihzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgaW50IG10a19v
dmxfYWRhcHRvcl9jbGtfZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19v
dmxfYWRhcHRvcl9jbGtfZGlzYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdm9pZCBtdGtf
b3ZsX2FkYXB0b3JfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+
IEBAIC0xNTAsNiArMTUyLDggQEAgdm9pZCBtdGtfcmRtYV9kaXNhYmxlX3ZibGFuayhzdHJ1Y3Qg
ZGV2aWNlICpkZXYpOw0KPiAgY29uc3QgdTMyICptdGtfcmRtYV9nZXRfZm9ybWF0cyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYpOw0KPiAgc2l6ZV90IG10a19yZG1hX2dldF9udW1fZm9ybWF0cyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYpOw0KPiAgDQo+ICtpbnQgbXRrX21kcF9yZG1hX3Bvd2VyX29uKHN0cnVjdCBk
ZXZpY2UgKmRldik7DQo+ICt2b2lkIG10a19tZHBfcmRtYV9wb3dlcl9vZmYoc3RydWN0IGRldmlj
ZSAqZGV2KTsNCj4gIGludCBtdGtfbWRwX3JkbWFfY2xrX2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpOw0KPiAgdm9pZCBtdGtfbWRwX3JkbWFfY2xrX2Rpc2FibGUoc3RydWN0IGRldmljZSAqZGV2
KTsNCj4gIHZvaWQgbXRrX21kcF9yZG1hX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IGNtZHFfcGt0DQo+ICpjbWRxX3BrdCk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IGluZGV4IDgxMDY3ZjQ5ZWE2OS4uYWFiOThh
ZGNkOWE0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
b3ZsX2FkYXB0b3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
b3ZsX2FkYXB0b3IuYw0KPiBAQCAtNzksNiArNzksOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19kZHBfY29tcF9mdW5jcyBtZXJnZSA9IHsNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIHJkbWEgPSB7DQo+ICsJLnBvd2VyX29uID0gbXRrX21k
cF9yZG1hX3Bvd2VyX29uLA0KPiArCS5wb3dlcl9vZmYgPSBtdGtfbWRwX3JkbWFfcG93ZXJfb2Zm
LA0KPiAgCS5jbGtfZW5hYmxlID0gbXRrX21kcF9yZG1hX2Nsa19lbmFibGUsDQo+ICAJLmNsa19k
aXNhYmxlID0gbXRrX21kcF9yZG1hX2Nsa19kaXNhYmxlLA0KPiAgfTsNCj4gQEAgLTIwMCwyMSAr
MjAyLDcyIEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiAgCW10a19ldGhkcl9zdG9wKG92bF9hZGFwdG9yLQ0KPiA+b3ZsX2FkYXB0b3JfY29tcFtPVkxf
QURBUFRPUl9FVEhEUjBdKTsNCj4gIH0NCj4gIA0KPiAtaW50IG10a19vdmxfYWRhcHRvcl9jbGtf
ZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gKy8qKg0KPiArICogcG93ZXJfb2ZmIC0gUG93
ZXIgb2ZmIHRoZSBkZXZpY2VzIGluIE9WTCBhZGFwdG9yDQo+ICsgKiBAZGV2OiBEZXZpY2UgdG8g
YmUgcG93ZXJlZCBvZmYNCj4gKyAqIEBudW06IE51bWJlciBvZiB0aGUgZGV2aWNlcyB0byBiZSBw
b3dlcmVkIG9mZg0KPiArICoNCj4gKyAqIENhbGxzIHRoZSAucG93ZXJfb2ZmKCkgb3ZsX2FkYXB0
b3IgY29tcG9uZW50IGNhbGxiYWNrIGlmIGl0IGlzDQo+IHByZXNlbnQuDQo+ICsgKi8NCj4gK3N0
YXRpYyBpbmxpbmUgdm9pZCBwb3dlcl9vZmYoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBp
bnQgbnVtKQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtfZGlzcF9vdmxfYWRhcHRvciAqb3ZsX2FkYXB0
b3IgPQ0KPiBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gLQlzdHJ1Y3QgZGV2aWNlICpjb21wOw0K
PiAtCWludCByZXQ7DQo+ICAJaW50IGk7DQo+ICANCj4gLQlmb3IgKGkgPSAwOyBpIDwgT1ZMX0FE
QVBUT1JfTUVSR0UwOyBpKyspIHsNCj4gLQkJY29tcCA9IG92bF9hZGFwdG9yLT5vdmxfYWRhcHRv
cl9jb21wW2ldOw0KPiAtCQlyZXQgPSBwbV9ydW50aW1lX2dldF9zeW5jKGNvbXApOw0KPiArCWlm
IChudW0gPiBPVkxfQURBUFRPUl9JRF9NQVgpDQo+ICsJCW51bSA9IE9WTF9BREFQVE9SX0lEX01B
WDsNCj4gKw0KPiArCWZvciAoaSA9IG51bSAtIDE7IGkgPj0gMDsgaS0tKSB7DQo+ICsJCWlmICgh
b3ZsX2FkYXB0b3ItPm92bF9hZGFwdG9yX2NvbXBbaV0gfHwNCj4gKwkJICAgICFjb21wX21hdGNo
ZXNbaV0uZnVuY3MtPnBvd2VyX29mZikNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICsJCWNvbXBf
bWF0Y2hlc1tpXS5mdW5jcy0+cG93ZXJfb2ZmKG92bF9hZGFwdG9yLQ0KPiA+b3ZsX2FkYXB0b3Jf
Y29tcFtpXSk7DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICsvKioNCj4gKyAqIG10a19vdmxfYWRhcHRv
cl9wb3dlcl9vbiAtIFBvd2VyIG9uIHRoZSBkZXZpY2VzIGluIE9WTCBhZGFwdG9yDQo+ICsgKiBA
ZGV2OiBEZXZpY2UgdG8gYmUgcG93ZXJlZCBvbg0KPiArICoNCj4gKyAqIERpZmZlcmVudCBmcm9t
IE9WTCwgT1ZMIGFkYXB0b3IgaXMgYSBwc2V1ZG8gZGV2aWNlIHNvDQo+ICsgKiB3ZSBkaWRuJ3Qg
ZGVmaW5lIGl0IGluIHRoZSBkZXZpY2UgdHJlZSwNCj4gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dl
dCgpDQo+ICsgKiBjYWxsZWQgYnkgLmF0b21pY19lbmFibGUoKSBwb3dlciBvbiBubyBkZXZpY2Ug
aW4gT1ZMIGFkYXB0b3IsDQo+ICsgKiB3ZSBoYXZlIHRvIGltcGxlbWVudCBhIGZ1bmN0aW9uIHRv
IGRvIHRoZSBqb2IgaW5zdGVhZC4NCj4gKyAqDQo+ICsgKiBSZXR1cm46IFplcm8gZm9yIHN1Y2Nl
c3Mgb3IgbmVnYXRpdmUgbnVtYmVyIGZvciBmYWlsdXJlLg0KPiArICovDQo+ICtpbnQgbXRrX292
bF9hZGFwdG9yX3Bvd2VyX29uKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3Qg
bXRrX2Rpc3Bfb3ZsX2FkYXB0b3IgKm92bF9hZGFwdG9yID0NCj4gZGV2X2dldF9kcnZkYXRhKGRl
dik7DQo+ICsJaW50IGksIHJldDsNCj4gKw0KPiArCWZvciAoaSA9IDA7IGkgPCBPVkxfQURBUFRP
Ul9JRF9NQVg7IGkrKykgew0KPiArCQlpZiAoIW92bF9hZGFwdG9yLT5vdmxfYWRhcHRvcl9jb21w
W2ldIHx8DQo+ICsJCSAgICAhY29tcF9tYXRjaGVzW2ldLmZ1bmNzLT5wb3dlcl9vbikNCj4gKwkJ
CWNvbnRpbnVlOw0KPiArDQo+ICsJCXJldCA9IGNvbXBfbWF0Y2hlc1tpXS5mdW5jcy0+cG93ZXJf
b24ob3ZsX2FkYXB0b3ItDQo+ID5vdmxfYWRhcHRvcl9jb21wW2ldKTsNCj4gIAkJaWYgKHJldCA8
IDApIHsNCj4gIAkJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBwb3dlciBkb21haW4g
JWQsDQo+IGVyciAlZFxuIiwgaSwgcmV0KTsNCj4gLQkJCWdvdG8gZXJyb3I7DQo+ICsJCQlwb3dl
cl9vZmYoZGV2LCBpKTsNCj4gKwkJCXJldHVybiByZXQ7DQo+ICAJCX0NCj4gIAl9DQo+ICsJcmV0
dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3ZvaWQgbXRrX292bF9hZGFwdG9yX3Bvd2VyX29mZihzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJcG93ZXJfb2ZmKGRldiwgT1ZMX0FEQVBUT1JfSURf
TUFYKTsNCj4gK30NCj4gKw0KPiAraW50IG10a19vdmxfYWRhcHRvcl9jbGtfZW5hYmxlKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IgKm92
bF9hZGFwdG9yID0NCj4gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsJc3RydWN0IGRldmljZSAq
Y29tcDsNCj4gKwlpbnQgcmV0Ow0KPiArCWludCBpOw0KPiAgDQo+ICAJZm9yIChpID0gMDsgaSA8
IE9WTF9BREFQVE9SX0lEX01BWDsgaSsrKSB7DQo+ICAJCWNvbXAgPSBvdmxfYWRhcHRvci0+b3Zs
X2FkYXB0b3JfY29tcFtpXTsNCj4gQEAgLTIyNSwxNiArMjc4LDEwIEBAIGludCBtdGtfb3ZsX2Fk
YXB0b3JfY2xrX2VuYWJsZShzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+ICAJCQlkZXZfZXJyKGRl
diwgIkZhaWxlZCB0byBlbmFibGUgY2xvY2sgJWQsIGVycg0KPiAlZFxuIiwgaSwgcmV0KTsNCj4g
IAkJCXdoaWxlICgtLWkgPj0gMCkNCj4gIAkJCQljb21wX21hdGNoZXNbaV0uZnVuY3MtDQo+ID5j
bGtfZGlzYWJsZShjb21wKTsNCj4gLQkJCWkgPSBPVkxfQURBUFRPUl9NRVJHRTA7DQo+IC0JCQln
b3RvIGVycm9yOw0KPiArCQkJcmV0dXJuIHJldDsNCj4gIAkJfQ0KPiAgCX0NCj4gIAlyZXR1cm4g
MDsNCj4gLWVycm9yOg0KPiAtCXdoaWxlICgtLWkgPj0gMCkNCj4gLQkJcG1fcnVudGltZV9wdXQo
b3ZsX2FkYXB0b3ItPm92bF9hZGFwdG9yX2NvbXBbaV0pOw0KPiAtDQo+IC0JcmV0dXJuIHJldDsN
Cj4gIH0NCj4gIA0KPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfY2xrX2Rpc2FibGUoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+
IGluZGV4IGEwYjJiYTNjYmNkYi4uYmM0Y2M3NWNjYTE4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC03NzQsNyArNzc0LDcgQEAgc3RhdGljIHZv
aWQgbXRrX2RybV9jcnRjX2F0b21pY19lbmFibGUoc3RydWN0DQo+IGRybV9jcnRjICpjcnRjLA0K
PiAgCQlyZXR1cm47DQo+ICAJfQ0KPiAgDQo+IC0JcmV0ID0gcG1fcnVudGltZV9yZXN1bWVfYW5k
X2dldChjb21wLT5kZXYpOw0KPiArCXJldCA9IG10a19kZHBfY29tcF9wb3dlcl9vbihjb21wKTsN
Cj4gIAlpZiAocmV0IDwgMCkgew0KPiAgCQlEUk1fREVWX0VSUk9SKGNvbXAtPmRldiwgIkZhaWxl
ZCB0byBlbmFibGUgcG93ZXINCj4gZG9tYWluOiAlZFxuIiwgcmV0KTsNCj4gIAkJcmV0dXJuOw0K
PiBAQCAtNzgyLDcgKzc4Miw3IEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y19hdG9taWNfZW5h
YmxlKHN0cnVjdA0KPiBkcm1fY3J0YyAqY3J0YywNCj4gIA0KPiAgCXJldCA9IG10a19jcnRjX2Rk
cF9od19pbml0KG10a19jcnRjLCBzdGF0ZSk7DQo+ICAJaWYgKHJldCkgew0KPiAtCQlwbV9ydW50
aW1lX3B1dChjb21wLT5kZXYpOw0KPiArCQltdGtfZGRwX2NvbXBfcG93ZXJfb2ZmKGNvbXApOw0K
PiAgCQlyZXR1cm47DQo+ICAJfQ0KPiAgDQo+IEBAIC03OTUsNyArNzk1LDcgQEAgc3RhdGljIHZv
aWQgbXRrX2RybV9jcnRjX2F0b21pY19kaXNhYmxlKHN0cnVjdA0KPiBkcm1fY3J0YyAqY3J0YywN
Cj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YyA9IHRvX210a19jcnRjKGNy
dGMpOw0KPiAgCXN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAgPSBtdGtfY3J0Yy0+ZGRwX2NvbXBb
MF07DQo+IC0JaW50IGksIHJldDsNCj4gKwlpbnQgaTsNCj4gIA0KPiAgCURSTV9ERUJVR19EUklW
RVIoIiVzICVkXG4iLCBfX2Z1bmNfXywgY3J0Yy0+YmFzZS5pZCk7DQo+ICAJaWYgKCFtdGtfY3J0
Yy0+ZW5hYmxlZCkNCj4gQEAgLTgyNSw5ICs4MjUsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2Ny
dGNfYXRvbWljX2Rpc2FibGUoc3RydWN0DQo+IGRybV9jcnRjICpjcnRjLA0KPiAgDQo+ICAJZHJt
X2NydGNfdmJsYW5rX29mZihjcnRjKTsNCj4gIAltdGtfY3J0Y19kZHBfaHdfZmluaShtdGtfY3J0
Yyk7DQo+IC0JcmV0ID0gcG1fcnVudGltZV9wdXQoY29tcC0+ZGV2KTsNCj4gLQlpZiAocmV0IDwg
MCkNCj4gLQkJRFJNX0RFVl9FUlJPUihjb21wLT5kZXYsICJGYWlsZWQgdG8gZGlzYWJsZSBwb3dl
cg0KPiBkb21haW46ICVkXG4iLCByZXQpOw0KPiArCW10a19kZHBfY29tcF9wb3dlcl9vZmYoY29t
cCk7DQo+ICANCj4gIAltdGtfY3J0Yy0+ZW5hYmxlZCA9IGZhbHNlOw0KPiAgfQ0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gaW5kZXggMTA0MDJl
MDdhNGE3Li45OTQwOTA5Yzc0MzUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZGRwX2NvbXAuYw0KPiBAQCAtMzk2LDYgKzM5Niw4IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRkcF91Zm9lID0NCj4gew0KPiAgfTsNCj4gIA0KPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgZGRwX292bF9hZGFwdG9yID0g
ew0KPiArCS5wb3dlcl9vbiA9IG10a19vdmxfYWRhcHRvcl9wb3dlcl9vbiwNCj4gKwkucG93ZXJf
b2ZmID0gbXRrX292bF9hZGFwdG9yX3Bvd2VyX29mZiwNCj4gIAkuY2xrX2VuYWJsZSA9IG10a19v
dmxfYWRhcHRvcl9jbGtfZW5hYmxlLA0KPiAgCS5jbGtfZGlzYWJsZSA9IG10a19vdmxfYWRhcHRv
cl9jbGtfZGlzYWJsZSwNCj4gIAkuY29uZmlnID0gbXRrX292bF9hZGFwdG9yX2NvbmZpZywNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+IGluZGV4
IDFjMWQ2NzBjZmU0MS4uMjU5N2RkN2FjMGQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gQEAgLTcsNiArNyw3IEBADQo+ICAjZGVmaW5l
IE1US19EUk1fRERQX0NPTVBfSA0KPiAgDQo+ICAjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gKyNp
bmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1tbXN5
cy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstbXV0ZXguaD4NCj4gQEAg
LTQ2LDYgKzQ3LDggQEAgZW51bSBtdGtfZGRwX2NvbXBfdHlwZSB7DQo+ICBzdHJ1Y3QgbXRrX2Rk
cF9jb21wOw0KPiAgc3RydWN0IGNtZHFfcGt0Ow0KPiAgc3RydWN0IG10a19kZHBfY29tcF9mdW5j
cyB7DQo+ICsJaW50ICgqcG93ZXJfb24pKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICsJdm9pZCAo
KnBvd2VyX29mZikoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIAlpbnQgKCpjbGtfZW5hYmxlKShz
dHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgCXZvaWQgKCpjbGtfZGlzYWJsZSkoc3RydWN0IGRldmlj
ZSAqZGV2KTsNCj4gIAl2b2lkICgqY29uZmlnKShzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVk
IGludCB3LA0KPiBAQCAtOTEsNiArOTQsMjMgQEAgc3RydWN0IG10a19kZHBfY29tcCB7DQo+ICAJ
aW50IGVuY29kZXJfaW5kZXg7DQo+ICB9Ow0KPiAgDQo+ICtzdGF0aWMgaW5saW5lIGludCBtdGtf
ZGRwX2NvbXBfcG93ZXJfb24oc3RydWN0IG10a19kZHBfY29tcCAqY29tcCkNCj4gK3sNCj4gKwlp
ZiAoY29tcC0+ZnVuY3MgJiYgY29tcC0+ZnVuY3MtPnBvd2VyX29uKQ0KPiArCQlyZXR1cm4gY29t
cC0+ZnVuY3MtPnBvd2VyX29uKGNvbXAtPmRldik7DQo+ICsJZWxzZQ0KPiArCQlyZXR1cm4gcG1f
cnVudGltZV9yZXN1bWVfYW5kX2dldChjb21wLT5kZXYpOw0KPiArCXJldHVybiAwOw0KPiArfQ0K
PiArDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgbXRrX2RkcF9jb21wX3Bvd2VyX29mZihzdHJ1Y3Qg
bXRrX2RkcF9jb21wICpjb21wKQ0KPiArew0KPiArCWlmIChjb21wLT5mdW5jcyAmJiBjb21wLT5m
dW5jcy0+cG93ZXJfb2ZmKQ0KPiArCQljb21wLT5mdW5jcy0+cG93ZXJfb2ZmKGNvbXAtPmRldik7
DQo+ICsJZWxzZQ0KPiArCQlwbV9ydW50aW1lX3B1dChjb21wLT5kZXYpOw0KPiArfQ0KPiArDQo+
ICBzdGF0aWMgaW5saW5lIGludCBtdGtfZGRwX2NvbXBfY2xrX2VuYWJsZShzdHJ1Y3QgbXRrX2Rk
cF9jb21wICpjb21wKQ0KPiAgew0KPiAgCWlmIChjb21wLT5mdW5jcyAmJiBjb21wLT5mdW5jcy0+
Y2xrX2VuYWJsZSkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
bWRwX3JkbWEuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuYw0K
PiBpbmRleCA1NzQ2ZjA2MjIwYzEuLjc2OWFlNzU2NGRhMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuYw0KPiBAQCAtMjQzLDYgKzI0MywyMiBAQCBzaXplX3Qg
bXRrX21kcF9yZG1hX2dldF9udW1fZm9ybWF0cyhzdHJ1Y3QNCj4gZGV2aWNlICpkZXYpDQo+ICAJ
cmV0dXJuIEFSUkFZX1NJWkUoZm9ybWF0cyk7DQo+ICB9DQo+ICANCj4gK2ludCBtdGtfbWRwX3Jk
bWFfcG93ZXJfb24oc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCWludCByZXQgPSBwbV9y
dW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGRldik7DQo+ICsNCj4gKwlpZiAocmV0IDwgMCkgew0KPiAr
CQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBwb3dlciBvbjogJWRcbiIsIHJldCk7DQo+ICsJCXJl
dHVybiByZXQ7DQo+ICsJfQ0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICt2b2lkIG10a19t
ZHBfcmRtYV9wb3dlcl9vZmYoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXBtX3J1bnRp
bWVfcHV0KGRldik7DQo+ICt9DQo+ICsNCj4gIGludCBtdGtfbWRwX3JkbWFfY2xrX2VuYWJsZShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0IG10a19tZHBfcmRtYSAqcmRtYSA9
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
