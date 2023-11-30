Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116627FE6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjK3C2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3C2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:28:34 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593F83;
        Wed, 29 Nov 2023 18:28:33 -0800 (PST)
X-UUID: 240cd70a8f2811ee8051498923ad61e6-20231130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ohTjSCub61IEFSVwDaK+ZyqC7CRGMyzUKS4KlGdih60=;
        b=PB2eNdeEO2Zh9wOafuSyYlvOtSg4GifnW/dA8xDGBBLSKw0pNw/3iMT/CSVhFpUWC19AXVEdslXaFFkLSEImjlCfeLXsWH/coQLFiGyzXKA5aN4H8iX4OdRKa9xD76WeH2vYjpIOPLV9TBXG7XbRXhgypGtAt6REKnSsewpmuA0=;
X-CID-CACHE: Type:Local,Time:202311301001+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:dd24d4c4-d067-4583-9ec2-aa339c2b45e2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:8e8cf895-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 240cd70a8f2811ee8051498923ad61e6-20231130
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 785767120; Thu, 30 Nov 2023 10:28:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 30 Nov 2023 10:28:24 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 30 Nov 2023 10:28:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ9Q7z6sNwXvJIpRueSHCfst+GBv36+sxvKC2Fis1ly1RVYBrZcjsVoOoMzedjOqev+YwZHhwN2VhnDRcrLt4cselJGRMNAXxowpkARHVS2lDDmatbASplCjqAVSPDjrCPSMDKm2eO8bpWHOM3UGg+IM9PqZFqc7O1D7hmd0rTIoK3teb7Ff8/MsLKYshCnPP4cYZU+D+a2huxeWwB0dg15MnlO8q4zBh9OkV8miWcpEUwc/X6FqSJHuEXNbZgImfJCo3wjyQUBNPMwrGQZABE/hYqgSYIkVih0hJrBnRl+Ge1rMLwvBOMzgVMXJvCXReBItQUkxXjdVu/omY/bJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohTjSCub61IEFSVwDaK+ZyqC7CRGMyzUKS4KlGdih60=;
 b=WqMCLcAbn+aU0C3eOgY3rEj7wbRxOiN1fjIlTbPyWNI9g0KJCSLMborX9SZxQuITBgZ+guQlCLE+eZMU/HiIyg9AqXNkxeY4f7aeDgPtb/0jQ7ER9e/THAtdMlyUx1/LxYpvoR8mqDaNHqpgr1DW6JW3prtdYm+ZuiVkULNm8Bye2h9yPeqYccstwf17HIB8gbMlQt1lmMM7sNJ1dRfx48S2SF3ud9vpzq2OHxu1FWfQ4t4LMwWB+mR0uQoBgkuMewqnaCYkRfunkNktB//9Yjk2p3urLWZm3ofpF1Tsd77G2wPRjSNI0+movrSX5RAytECDxca6hpFRwQRN2CFwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohTjSCub61IEFSVwDaK+ZyqC7CRGMyzUKS4KlGdih60=;
 b=vCLmKqXVpNBgtYQhF9AWnY8cpvyRnY6WwWlPvW0fZwS2iip41kJVROV5Mj6bi7v0vkemBIxl/kdLQqSYj+tK8JHp21Yh7ciFH/jRbnKvJo4WFMyHpjxYI/iUvgzobTVDfM6EuElQfFaRLPlY83L0MaWI2+zm29Ai00/Z6BL3gMc=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by SEYPR03MB7293.apcprd03.prod.outlook.com (2603:1096:101:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.24; Thu, 30 Nov
 2023 02:28:14 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 02:28:14 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= 
        <bear.wang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek: tphy: add a property for
 force-mode switch
Thread-Topic: [PATCH 1/2] dt-bindings: phy: mediatek: tphy: add a property for
 force-mode switch
Thread-Index: AQHaHz31Z+QBjWZtBk+dlN+S28FsW7CK2GgAgALqXwCABGh5gA==
Date:   Thu, 30 Nov 2023 02:28:14 +0000
Message-ID: <b351bdfeb1e782bd559f3c33da916de6a24b3446.camel@mediatek.com>
References: <20231125012303.760-1-chunfeng.yun@mediatek.com>
         <e34c2746-8e93-48b8-9c96-690242fbf6e9@linaro.org>
         <239def9b-437b-9211-7844-af4332651df0@mediatek.com>
In-Reply-To: <239def9b-437b-9211-7844-af4332651df0@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|SEYPR03MB7293:EE_
x-ms-office365-filtering-correlation-id: fa7d2cca-f322-46ad-7585-08dbf14c0154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZufxmnJqrBlabC9LQMLPYSVcPQx/hO3EU7rOaZDxGBPHqXoy9L2PNg+VibvMVmuouewX26EGR2A0rG8+uEeVKm3dsjIlEE+IeWm5WXicvklhDT5AmWCLJkREJtQK96j9R96wEPgDmO/yHrQ74+bGs7k3k9kZdnK/NTgMPdK4+ynT6/6ffn4tO+Xe6UlFefF50KEQM/U7WZ26Soco1yZ+bM4GkGFmEHJPR7r9JdD4LZLPnG5Sw1S7O8tJ2fhYortC9Yt/IU7XbZgEzTruKxBnOX7R7zWVVPPYqUh6m1XqkO8yyCduqzz8lm0FjG3l6ALF0+v64qwux+SGXBxY3CLRkoEu0Bd3HjRt0hsa87I18BVzYAgxJC3SVVxQ9iqIAnf3b+/qThho+oIQl0gfcTZWa+i0i6czH3zbWx8PSYp7gRD808UQW90qAJ2RMu+ckq2udce8pEIrRHEKw8c9+TLlHXD1ZIXWaQkW7hDiMUaI/xMlNfE0+I6bk03WyidP+3xx5Syc8aR6Wo1yHTx6np70KVlAJ5VwAXg1ho0bkKaXPMTDnU026MDkA+smVSOeSCaTjgfMvSu5o6D1GbaousWwCmrx2min8Id86b4lfNhxgylTCJYan/ztzUxBydh4BcTydtpn+19h9GPbnFd3mZpPFhXxREQa1jZijKsUVmdU2fpRqKAbOUlpwU4o8pa76b4tmHSxCRQ5Wvj0ndQIPHoKWI99jVThLwbM2ZQ0+lE8ywAgM+TP7mHx8FSk5sy2BTJB64/3tCv8VxoXwNFkIvvKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(8676002)(4326008)(8936002)(83380400001)(85182001)(122000001)(7416002)(36756003)(2906002)(86362001)(38070700009)(4001150100001)(41300700001)(202311291699003)(38100700002)(5660300002)(53546011)(66946007)(6486002)(26005)(71200400001)(6512007)(478600001)(2616005)(316002)(54906003)(64756008)(66446008)(110136005)(76116006)(66556008)(91956017)(66476007)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2lOL0UyVHFBbG4yN2d0UHkwcVc5SHFyZlY2NEkza1ZKOVhIS0N0bk5qcy9F?=
 =?utf-8?B?dHVPd2FGOEZkM2JGc3J0aFlsdlhNT2dFVVNYanF4ditrZmVLb0MrbmdkMUJx?=
 =?utf-8?B?MitmUmNCMGYyclV2ZW5hNG1HNWtNSjlRRHloYzVaM0xqaVN2RW4rSUJkUHdQ?=
 =?utf-8?B?Z3FKc3pkVWltUGNUeUxpZE5EREQ0MkgwR3NFVXM1Zm1OQVpOZVl3TEVWdUlw?=
 =?utf-8?B?L2NEUllBOS9QODZpQUVVTXloaG9xVmhqQ3R0MzA0TUd3a1dLQXNFenNrOFJ0?=
 =?utf-8?B?ekFTOHFiVnUvaGZENUhUdUlFZ2diNklETi9Dckh2VWc4bzhsWGxRcDRxZUc0?=
 =?utf-8?B?YmNUcEhDQ2hCUEJKZDlQRFg3TGFHdEJSTkp0dXQrT3g5SGowSXVzUTVUL3Zq?=
 =?utf-8?B?dHdCaDU1UFVPKy9RV1QxZjRrWnJNeDN5VTlhRlVHRW9scHBKa1B1Z1JiSEZ4?=
 =?utf-8?B?eG16MmhDaVU1Vk9NenIvNVZZZTQ4WWR4ZHo5bTNBZzZYaVBLY1NDc25rTW04?=
 =?utf-8?B?UllEZDNMMHRRQWxVZnhFWVF0YlE3VWthdkU5OXppcnlNZnRaelQ5UVlpYzBQ?=
 =?utf-8?B?czB6LzVTRUpaVnBpVUZhTk1xN2kxRHo1RXdLS0hSc1BlVXg2S0J6TEdsUGh5?=
 =?utf-8?B?Vk5yWlZNMFVMVG9tSUR1cTUvWElzNUk2SlRkejdkeXFoT082MThqM1c0OE5z?=
 =?utf-8?B?RDN6OWRlUXdYK093b2YvaFRiUzQyWk5nd3hpMXM0aEY5d0JoUWRCTHBtUG53?=
 =?utf-8?B?UmRMUGJ0ckJiQTBiakRzNE9iemRWYmFON3dqNFZzb2dCcDJmdlJDd2NlamhN?=
 =?utf-8?B?TkZ4MFJnQ2FHVkZzL3RvZjNSS2VRTkpLTDZqemt1VVVtRHRiZ2QzWS9ObjhN?=
 =?utf-8?B?LzJqTFRwK2RwVHpqWkgwT2E4dTQvUjZ2enYzNGlkV0RQYVRYUlo1UWdZMnAv?=
 =?utf-8?B?MFpBdUtvSTJVLzNqN0NQRUQ3bzBFQ2t0b3VOa0hVOFlwZjR6NGFISWxPRFZ1?=
 =?utf-8?B?T3c1KzVpUGFvUi85UFZVdlllOHdjakJ4ZFhzUmxQMHVIVDkwOVBkKzFjZGh4?=
 =?utf-8?B?OHd3YTM3MVhLT3NHVEJJckw0dC9oNHpjVTRkcjZsbnRGbkIzWlo3ek5SRVVO?=
 =?utf-8?B?K1REUFlEZmxEaDZ6aTV5Q04zVlkyeC9BQzNWTENaUURtNUhWUHZGbGFOKzhZ?=
 =?utf-8?B?c1o3ZzVpd0dPd3UzQXc1clI1ZW5OZjJDNGszNVd0eXI0bnB6dWJhT0Q0aGdy?=
 =?utf-8?B?LzNqSE1vTTAyUGRuUDJkUk5XamNzRlk4b0liNTJTMGNmZHRic3V1azdSK1dB?=
 =?utf-8?B?eUxGTnVpandlZzE1Ynk2TmNBL1hhNGRBemNPSnRtWWVSMGx4V1MwV3locWtr?=
 =?utf-8?B?cXJMVFpLazBnOURGUU4yRVRXSVNwT2xHeVIySzNsNElSUmpTdUJEM2RrVFgx?=
 =?utf-8?B?cDVvV2xnck1EYmptUG1mQXdXNnFBMlp6VmFTOGo5dUhualFBVkNWb1BRWXFy?=
 =?utf-8?B?QWFUdU5ueC9tNTMzVFNpa1B3d2dPclRoUVlMbVVOeFl4b1hzYlNuekRucnVB?=
 =?utf-8?B?S1ZMY2ZtKzZDMXI3ZHEyWmpNblN5U2Ezc2E2cDVNbUFPMnRTUWo3bW5KUTlH?=
 =?utf-8?B?eEdDcTZEZnhmZ0I2clFocytyT0RPamZXVjNXUHl5bmovZHlJcWJpUi95QzNG?=
 =?utf-8?B?bnpkQlBMNGl4U01vZmRNZFYxRytaYm8rNE5oNk1XQVdzdDdmcnVDUjVIenhp?=
 =?utf-8?B?T2RHQmRWSHpwellaY094TTNVTEJONkU2a2VmODl1UnkydWNsOGp6alRtZHZX?=
 =?utf-8?B?YVpuK1hVUkJFNDQxM2JZejY1ZzBxNUVkbTl0K3Y0Mkc2QityMG5uK09NaDVL?=
 =?utf-8?B?NENKOHBUYzlHTy80Y0V6OTdHZCtWWFlNUC9XR1FCOEhKb0hhVU80SmpuY0xj?=
 =?utf-8?B?OTZyVU1LYTlvWGdjbDZsMktlSXFZZnNsaTcvdUlhTGllVGNRaDJQRzk2d245?=
 =?utf-8?B?ZG1kV1NFWXpHRG1YWFllVW4yYlZ6c1dudW1zblhQS2lCWThDdmorVXZudzhq?=
 =?utf-8?B?UWp0MnluQUFlOW5RcTJPbnpvamc2VGxueFNuREVBaTh6d0dEZExpd1FUWUgz?=
 =?utf-8?B?T241ZkJJdUlBSHJpQVVhUTQxcVZBR3U3NDUxRzR5dk02U0dxOWtrVWdLd1k2?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3A4BF68C8ABF843A5A7C493A7094464@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7d2cca-f322-46ad-7585-08dbf14c0154
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 02:28:14.5005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78xSwpdZ5zvady1j1LLjpnzs0RmTDoHEI6B1xpee+QVlvVPUcC2BR6vCY8N+Ovm/jZ9Ex/isTPICdUX27BVwzbKemSnGH18sUSOSFcs1nio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7293
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--34.227300-8.000000
X-TMASE-MatchedRID: 9Mh434hFDFXUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/TEy+FT1zrl40e
        ly2iMqdYyksWSdvP+9GsXAiB6VK48AbbLE2rYg/9wvqOGBrge3shmbYg1ZcOntvpj5+dNlQvMC/
        K/e26+Q0tIcNCL+1lT4IDpXRi97xlDcy28oDHlwJc/msUC5wFQX5ErfRqpilVZ5yuplze9psVWT
        DhfTuSaNoUzlM8Yt0I0wOo8Q6y8JusVSjuVu0TEENTnAhL0/m3HznaOB9+eYio+b+yOP0oGEDH7
        fYNhjWYpLHkqMumMNqfJm8PXdmqu4qtuuQ+CE7v98sqn8kK3uGyNcEJTKJGJs2mvbig5LjG8Z5E
        7FtTRPZCBxbVTmCgug4BODg3LBohOzEyQBr3GYwSEYfcJF0pRYEcpMn6x9cZ8Ule2AXgYUvppfx
        NgiuPWwITVNParjYe8WW0jr6feERCR/FskDJObqngbqTYC4GHKx5ICGp/WtGsIMnczyxe53MuLK
        lM8AY7tgYCUMHTkb48KzNYBChyYo9oUcx9VMLg0gVVXNgaM0pZDL1gLmoa/PoA9r2LThYYKrauX
        d3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--34.227300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 3F75C111EA6D528458C56BAD0FC9804C1E330D4B3046D8C24458D734C99A36D32000:8
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTI3IGF0IDE1OjA5ICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4g
T24gMTEvMjUvMjMgMTg6MzcsIEtyenlzenRvZiBLb3psb3dza2kgYW5kIENodW5mZW5nIFl1biB3
cm90ZToNCj4gPiAJDQo+ID4gDQo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gPiB1bnRpbCB5b3UgDQo+ID4gaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+IA0KPiA+IE9uIDI1LzExLzIw
MjMgMDI6MjMsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiA+IER1ZSB0byBzb21lIG9sZCBTb0Nz
IHdpdGggc2hhcmVkIHQtcGh5IG9ubHkgc3VwcG9ydCBmb3JjZS1tb2RlDQo+ID4gPiBzd2l0Y2gs
IGFuZA0KPiA+ID4gY2FuJ3QgdXNlIGNvbXBhdGlibGUgdG8gZGlzdGluZ3Vpc2ggYmV0d2VlbiBz
aGFyZWQgYW5kIG5vbi1zaGFyZWQgDQo+ID4gPiB0LXBoeSwNCj4gPiA+IGFkZCBhIHByb3BlcnR5
IHRvIHN1cHBvcnRlZCBpdC4NCj4gPiA+IEJ1dCBub3cgcHJlZmVyIHRvIHVzZSAibWVkaWF0ZWss
c3lzY29uLXR5cGUiIG9uIG5ldyBTb0MgYXMgZmFyIGFzDQo+ID4gPiBwb3NzaWJsZS4NCj4gPiA+
IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BoeS9tZWRpYXRlayx0cGh5LnlhbWwgfCA2DQo+ID4gPiArKysrKysNCj4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQNCj4g
PiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0cGh5
LnlhbWwNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRp
YXRlayx0cGh5LnlhbWwNCj4gPiA+IGluZGV4IDJiYjkxNTQyZTk4NC4uZWVkYmE1YjcwMjVlIDEw
MDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9t
ZWRpYXRlayx0cGh5LnlhbWwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9waHkvbWVkaWF0ZWssdHBoeS55YW1sDQo+ID4gPiBAQCAtMjM1LDYgKzIzNSwxMiBA
QCBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiA+ICAgICAgICAgICAgU3BlY2lmeSB0aGUgZmxhZyB0
byBlbmFibGUgQkMxLjIgaWYgc3VwcG9ydCBpdA0KPiA+ID4gICAgICAgICAgdHlwZTogYm9vbGVh
bg0KPiA+ID4gIA0KPiA+ID4gKyAgICAgIG1lZGlhdGVrLGZvcmNlLW1vZGU6DQo+ID4gPiArICAg
ICAgICBkZXNjcmlwdGlvbjoNCj4gPiA+ICsgICAgICAgICAgVXNlIGZvcmNlIG1vZGUgdG8gc3dp
dGNoIHNoYXJlZCBwaHkgbW9kZSwgcGVyZmVyIHRvDQo+ID4gPiB1c2UgdGhlIGJlbGxvdw0KPiA+
IA0KPiA+IEkgc3RpbGwgZG8gbm90IHVuZGVyc3RhbmQgd2hhdCBpcyB0aGUgImZvcmNlIG1vZGUi
IHlvdSB3YW50IHRvIHVzZS4NCj4gPiBXaGF0DQo+ID4gbW9kZXMgZG8geW91IGhhdmU/IFdoYXQg
YXJlIHRoZSBjaGFyYWN0ZXJpc3RpY3Mgb2YgZm9yY2UgbW9kZT8NCj4gPiANCj4gPiBBbHNvLCBw
bGVhc2UgcnVuIHNwZWxsY2hlY2suDQo+ID4gDQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IEtyenlz
enRvZg0KPiA+IA0KPiANCj4gVGhhbmtzIQ0KPiANCj4gMS4gSSd2ZSB0ZXN0ZWQgdGhpcyBwYXRj
aCBhbmQgaXQgY291bGQgc29sdmUgdGhlIGNsb2NrIHVuc3RhYmxlIGZvcg0KPiBYSENJMSBvbiBt
dDgxOTUgb3IgbXQ4Mzk1IGR1cmluZyBzeXN0ZW0gYm9vdCB1cCBvciBkdXJpbmcNCj4gdW5sb2Fk
L3JlbG9hZCB0aGUgcGh5IGRyaXZlci4NCj4gDQo+IFRoZSBlcnJvciBtZXNzYWdlIGhhcyBiZWVu
IGxpc3RlZCBhcyBmb2xsb3dzLg0KPiANCj4gWyAgIDEzLjg0OTkzNl1bICAgVDcyXSB4aGNpLW10
ayAxMTI5MDAwMC51c2I6IHN1cHBseSB2YnVzIG5vdCBmb3VuZCwgDQo+IHVzaW5nIGR1bW15IHJl
Z3VsYXRvcg0KPiBbICAgMTMuODUxMzAwXVsgICBUNzJdIHhoY2ktbXRrIDExMjkwMDAwLnVzYjog
dXdrIC0gcmVnOjB4NDAwLA0KPiB2ZXJzaW9uOjEwNA0KPiBbICAgMTMuODUyNjI0XVsgICBUNzJd
IHhoY2ktbXRrIDExMjkwMDAwLnVzYjogeEhDSSBIb3N0IENvbnRyb2xsZXINCj4gWyAgIDEzLjg1
MzM5M11bICAgVDcyXSB4aGNpLW10ayAxMTI5MDAwMC51c2I6IG5ldyBVU0IgYnVzDQo+IHJlZ2lz
dGVyZWQsIA0KPiBhc3NpZ25lZCBidXMgbnVtYmVyIDMNCj4gWyAgIDEzLjg3NDQ5MF1bICAgVDcy
XSB4aGNpLW10ayAxMTI5MDAwMC51c2I6IGNsb2NrcyBhcmUgbm90IHN0YWJsZQ0KPiAoMHgzZDBm
KQ0KPiBbICAgMTMuODc1MzY5XVsgICBUNzJdIHhoY2ktbXRrIDExMjkwMDAwLnVzYjogY2FuJ3Qg
c2V0dXA6IC0xMTANCj4gWyAgIDEzLjg3NjA5MV1bICAgVDcyXSB4aGNpLW10ayAxMTI5MDAwMC51
c2I6IFVTQiBidXMgMyBkZXJlZ2lzdGVyZWQNCj4gWyAgIDEzLjg3NzA4MV1bICAgVDcyXSB4aGNp
LW10azogcHJvYmUgb2YgMTEyOTAwMDAudXNiIGZhaWxlZCB3aXRoDQo+IGVycm9yIA0KPiAtMTEw
DQo+IA0KPiAyLiBUaGlzIGlzIGEgZml4IHBhdGNoIHRvIFhIQ0kxIHNpbmNlIE1UODE5NSBoYXMg
YmVlbiB1cHN0cmVhbS4NCj4gUGxlYXNlIGFkZCAiRml4ZXM6IiB0YWdzIGFuZCAiQ2M6IHN0YWJs
ZUBrZXJuZWwub3JnIiB0byBiYWNrIHdhcmQNCj4gcG9ydGluZyB0byBwcmV2aW91cyBzdGFibGUg
dHJlZXMuDQo+IA0KPiBGb3IgZXhhbXBsZSwgYWRkDQo+IEZpeGVzOiA2YjVlZjE5NDYxMWU1ICgi
cGh5OiBtZWRpYXRlazogdHBoeTogcmVtb3ZlIG1hY3JvcyB0byBwcmVwYXJlIA0KPiBiaXRmaWVs
ZCIpDQo+IGlzIHN1Z2dlc3RlZCBzaW5jZSB0aGUgZm9yY2UtbW9kZSB3YXMgbWlzc2luZyBpbiB0
aGUgcHJldmlvdXMNCj4gaW1wbGVtZW50YXRpb24gd2hpY2ggY2F1c2VzIGhhcmR3YXJlIGZ1bmN0
aW9uIHdhcyBhYm5vcm1hbC4NCj4gSG93ZXZlciwgYWRkDQo+IEZpeGVzOiAzM2QxODc0NmZhNTE0
ICgicGh5OiBwaHktbXRrLXRwaHk6IHVzZSBuZXcgaW8gaGVscGVycyB0bw0KPiBhY2Nlc3MgDQo+
IHJlZ2lzdGVyIikNCj4gd2lsbCBiZSBiZXR0ZXIgc2luY2UgdGhlIFVTQiBzdXBwb3J0IGZvciBt
dDgxOTUgaXMgYWxyZWFkeSBlbmFibGVkDQo+IGluIA0KPiBsYXRlIDIwMjEuDQpJdCBkb24ndCB0
YWtlIGludG8gYWNjb3VudCB0aGlzIGNhc2UsIGl0IGFzc3VtZSB0aGF0IG9ubHkgdXNlIHRoZQ0K
ZGVmYXVsdCBtb2RlIChQQ0llKS4NCg0KPiANCj4gMy4gSG93IGFib3V0IHdlIHJldmlzZSB0aGUg
ZGVzY3JpcHRpb24gYXMgZm9sbG93cyBmb3IgbW9yZSBwcmVjaXNlbHk/DQo+IA0KPiBtZWRpYXRl
ayxmb3JjZS1tb2RlOg0KPiAgICBkZXNjcmlwdGlvbjoNCj4gICAgICBUaGUgZm9yY2UgbW9kZSBp
cyB1c2VkIHRvIG1hbnVhbGx5IHN3aXRjaCB0aGUgc2hhcmVkIFBIWSBtb2RlDQo+ICAgICAgYmV0
d2VlbiBVU0IgYW5kIFBDSWUuIFdoZW4gZm9yY2UtbW9kZSBpcyBzZXQsIHRoZSBVU0IgMy4wIG1v
ZGUNCj4gICAgICB3aWxsIGJlIHNlbGVjdGVkLiANCnNlZW1zIG5vdCByaWdodCwgdGhlIG1vZGUv
dHlwZSBpcyBzZWxlY3RlZCBieSB0aGUgcGh5IGNvbnN1bWVyLg0KDQo+IFRoaXMgaXMgdHlwaWNh
bGx5IHJlcXVpcmVkIGZvciBvbGRlciBTb0NzDQo+ICAgICAgdGhhdCBkbyBub3QgYXV0b21hdGlj
YWxseSBtYW5hZ2UgUEhZIG1vZGUgc3dpdGNoaW5nLg0KPiAgICAgIEZvciBuZXdlciBTb0NzIHRo
YXQgc3VwcG9ydCBpdCwgaXQgaXMgcHJlZmVyYWJsZSB0byB1c2UgdGhlDQo+ICAgICAgIm1lZGlh
dGVrLHN5c2Nvbi10eXBlIiBwcm9wZXJ0eSBpbnN0ZWFkLg0KPiAgICB0eXBlOiBib29sZWFuDQoN
Cj4gDQo+IFRoYW5rcywNCj4gTWFjcGF1bCBMaW4NCg==
