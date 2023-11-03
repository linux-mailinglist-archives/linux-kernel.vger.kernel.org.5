Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33907DFE0E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjKCCTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjKCCTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:19:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C70119D;
        Thu,  2 Nov 2023 19:19:28 -0700 (PDT)
X-UUID: 67504ad679ef11eea33bb35ae8d461a2-20231103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sSJMbV/pny0e079wO7mB7AGr2xe9PMAwuePsemu4E64=;
        b=Vvu/yifG4nhPXwwCsl72ScC46ktdgD4LnSR8QW8Ano2+VtbpBhJ+jdGdsYDTREfyIiitoXLeZa/aipu9pQyR9EatQWJz0zd3zTholnUm4lSAmuOiu27bmVEUf/o19KIeQRtaivvrRHRKQ9DkA7zX+JTXhfMsaOLLKXlAVKu0qt4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:c2591682-e4f1-43d8-a4a1-34bd901eba0c,IP:0,U
        RL:0,TC:0,Content:12,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:12
X-CID-META: VersionHash:364b77b,CLOUDID:bc7ff594-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 67504ad679ef11eea33bb35ae8d461a2-20231103
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 935211021; Fri, 03 Nov 2023 10:19:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Nov 2023 10:19:20 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Nov 2023 10:19:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMskYtbZjoFc14OHnKIx9VpQS1tU6i45nnrWdggUfsJHyzYqIEn6P9r0Iy7zF2yaz9xJRxkUZ+NB79C736B6PrW9Izxo0KmJ8A26mRYXg3QKtDLhEGHJIpgL05cJouHTCixRhUcxs1nSmQImV4sZ5ZrYNFq9TKMMHaiy/6Kfp8VJSISadK0vri6vS7AvTA+X/Theo3P/D8KpzLg181E96+4yWoaWtCXV9rSdHMzAgiah4kZoKaM7AXF4498WUb3lo6VafBW54U1ccLRq7GEWv/MCmBxehxyFRyEXj2QMAJehU8DxdcYic/xlZtC7NfuMGT1c4kK8N7090F7s8lvftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSJMbV/pny0e079wO7mB7AGr2xe9PMAwuePsemu4E64=;
 b=T3wmp4oyUih7kJuXIPy0WhgWqokmS4rOkgO7FTPFw0BimKpkTvkKM3bWt8bOyUKuUL5xWa36nVws8TWy7sxDf625+QKqN+Z1OhHq83dYq1TdX/k+65mxrBYPRLAP3TasMj1XmJxid3Cmfv80zV3BAmIbG6kqXF47DF9VUMNJwIQt+ElxKADq68GXkCCfHDda4VeaOI84VK/9r20VLUcSWDu0i+JmdHzUfBe+fjx3ik36PiIeppVNigXbDc1/H/zs3qd+JhrxlNH3p2fwe0G5b2Re2Qij4Xa4vb+7T4CcOMVrN2G8Oexdj4VCOVs2UPOUcpyOqGPTe4fV/ffc2EtScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSJMbV/pny0e079wO7mB7AGr2xe9PMAwuePsemu4E64=;
 b=PiQy5L9WV3onVW3bERJTh7ZlsUWA0Lt8uqwJUxTPMgICSFRq2VW5cv6xOJIb3HN2xUCXbA6oqo655OK3BnIu5QzSvN94Uku7MdnAZ0I9mtIeGNVDJLbiSaUUJy+kvg67In8qoVvyG2PmgsIzhfp3KG0P+XBNXzC4hE4C7wDnKew=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by TYZPR03MB5679.apcprd03.prod.outlook.com (2603:1096:400:88::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 02:19:18 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::7326:baa6:dc8f:dec8]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::7326:baa6:dc8f:dec8%3]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 02:19:12 +0000
From:   =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>
Subject: Re: [PATCH v3 1/1] ufs: core: Expand MCQ queue slot to
 DeviceQueueDepth + 1
Thread-Topic: [PATCH v3 1/1] ufs: core: Expand MCQ queue slot to
 DeviceQueueDepth + 1
Thread-Index: AQHaDU0smMitpWfdnUOr8kSqdsZu/7Bn3amA
Date:   Fri, 3 Nov 2023 02:19:12 +0000
Message-ID: <12eea0497bc366365f2835b30fd42ccabba44d99.camel@mediatek.com>
References: <20231102052426.12006-1-naomi.chu@mediatek.com>
         <20231102052426.12006-2-naomi.chu@mediatek.com>
In-Reply-To: <20231102052426.12006-2-naomi.chu@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|TYZPR03MB5679:EE_
x-ms-office365-filtering-correlation-id: 645abd5b-f3f0-45a1-e64e-08dbdc134543
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +uaDibWx9gMY+Ovtw8edSok/gLlA7yxyEfyPpIQr3+xZ9hOhx+ImCmRnjIHnLHQZI8yzLRL00aQeY2B/eawY/5OgmzxARjbsPUAaYjoFSbqCCPOh1J8+LEvlvVJ+xbBYUBcJeLNU8Pmg4yOqNuU/uIVuGuHuCSup0IQ2W1Kr7fWpxmUiUTddrnrAVluRvARk3gRkhcpapeYbnbrIJTjqhsnyza4zyRFzXTuDForj7Gq6QfK4Lm6CrvpMq1kK4f6BzSAVOyphy3DNYR4cF2J3pS0XxX4jlIQcF4SbrTS8ROYHYGTc2WLxHGbX6rgusbngOSllBKamMXqV4Co5vYMIHjWU02WBJiRaDlhAK0mM+D9bQemBI7PvZ29cYXh1qOKMwONGKMPO6fzJGdoaR8ieSBgcGu6CM+3Ne7EdDM2A9+mQaUJrveY+Q8JdXECWa8DlaOXyQPM6EJfQTje/Mm5THh4TTdt+MP3eKXgPl3lo7fj09UtpzsDddJwXXZ9CCRPegfVMx1hGo0z2evfCIAYweJcNp6x7OvL58c5CcU/wSG0NBeVwyUPlHyeis7NukFSO26ezJ02avcLUFqj9HwN+NbF9mybgO43h64+j2P6P2W31T1PhcrL7J0jwOjcly7QiXBYXylJKJsqMD+vG9APnZMUs4dlwyr3LTX4f9ODoBNfaOAxU151esE0JoTabxTnXM6wC6EtDRrvFIGj5Okr8Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(54906003)(66476007)(66556008)(66446008)(316002)(91956017)(76116006)(66946007)(64756008)(110136005)(38100700002)(5660300002)(2906002)(7416002)(86362001)(4744005)(6486002)(122000001)(6506007)(6512007)(38070700009)(36756003)(71200400001)(85182001)(921008)(478600001)(107886003)(2616005)(4326008)(8936002)(26005)(41300700001)(8676002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVJ2d2Y0M3YxZDJIbE15SDl0Q0lqdTNWRzE4UU5QZUI1T2x3MjFDcy82Ty9W?=
 =?utf-8?B?bGxJUExHY0dmTnVQWFg2T09teXh5Wlg4YnZIYlkzL1R3QlI4c1E2eXJCOWU2?=
 =?utf-8?B?Q1M1NzJDcWw4OUMzNytKNmZVWEFndHYrVWhSMU1ML1hLZHQ3clFFNFZMK3py?=
 =?utf-8?B?RGJrK2NadDlDekZ1SW5ZT05OTFlqUS9zOURGWXN6bTdwcVZGak5Jd3F1eVFX?=
 =?utf-8?B?b1JoK05YYWJCK05ibHFCK2JZMTNnVXpyQkJEQ0xFVzR2blhNeVpiUVRqc2hl?=
 =?utf-8?B?WlR4QXhUWnhQYkhlcVd0cTI1UHdPVFM5RW9hSjRJS0Q2TWNYSVE3U0RwMThK?=
 =?utf-8?B?Q1lqSjYreTlJVVgvdUVraGh4RVV3L2JMajJpMmJwMlBSVUV0aWtuWWRUTDNY?=
 =?utf-8?B?cDUyS0dOdHNjSGtCVFNIUWV2clU2bndDeFNSUFlqU0t6VDhrVkFiRis2Skxs?=
 =?utf-8?B?WDNOL2U1eUhSNDBENldnRHE1dXkvbkhnTlk2S1dWMWNNR29BRCtqanBLYURh?=
 =?utf-8?B?NG5IZ0tja2xlSXFqZTFSL2lha0owck5PalNTUnNFSWcxL2xPVjNaU2h0OXha?=
 =?utf-8?B?Wi9QeGdHN3VmZkMydVVXMThIV0tXQVBIa1lLQVhGOXEvc0V5Q0hPa3E1QnV2?=
 =?utf-8?B?ZjRCTHZwYWRnMG4yYWxOdXdDV0hPdmJ5STNGbjFMN1FXaGlvUlo3SW1Sb09T?=
 =?utf-8?B?c284T3pkUHdnUW5iZXh6dlZORncvNW1kVXpMWTRYOGxiaGQ1NTBjVGQvN0tn?=
 =?utf-8?B?NEtRVkpmSGN6MFlYcjZFRVlmUUlpb2JyTlhUMVJwVGZITDh2OEhwYndJYlJu?=
 =?utf-8?B?d2plQUdoVXB2ekJpenBBWllURGw3ZTRydkZrd0tBcWhZdmUxalAxUHYxbisv?=
 =?utf-8?B?aHlDSzNOQkp2aTRwcnBkSzBCNWRXcm95ay8rUkE3RzE5NW1sUGhsWUpzMkhV?=
 =?utf-8?B?NjlWam9tSTlPWmFYOHI2VWxGdTc1dXZFMFpidDlycUNacFVWalFsUy92MXZR?=
 =?utf-8?B?ZWF6b1Ixc0h5NzF2a2M2cGt5Nkh1Uy9JcGJUcWR6ekRvOUs2V01VM2Rxd3hx?=
 =?utf-8?B?L1pnNmhRSEF4TnJLbmZjb0NWOWZBTlN2YXlUbTNFNlBqWGw0R1owNmZUQmR6?=
 =?utf-8?B?UGpWZWh4bG95NHRGZlpGSmlMVkZuemdzd2k4OWFyL3hUMC9uL1dhRGJoaVRz?=
 =?utf-8?B?UzRwbUN1bGdneTlEbytEZXB0dHNsVDFEak9nT05TdHdhREl5akZ4Y2ZacndM?=
 =?utf-8?B?Z2dkT1hwTjZ4ZEkyNWQ4VFFSQmJjckFDMG9oeE9ma1Y4bHhEemEyaUE3UVNq?=
 =?utf-8?B?eFBrM0xJR0kyWHpEU0lMQnltYllSaUxLbTJIWDRhZVVIdDVZY05aeEpVd2Jl?=
 =?utf-8?B?bnFuSGtKWWF4OFZvMTdMZ05MWkxHZmVyRnFGUGRHYURoS2U2YVY3WG9TMDNx?=
 =?utf-8?B?YmpOSmVrcFkxZE1wWE1MdStqOU1WOTd2QVR3UVNNUUZieWZnWEpaU041WkZi?=
 =?utf-8?B?aU5IOG5OTi90TXgrSUFQdm5ud3UySStSZGM5TlVJYWQ3UjVIY1RkVHQrc3k4?=
 =?utf-8?B?QnNCZjJsVlVFczd1Tm1BWWhoUkF2SHl5bHg1Y2VmRys1dlIvaEhValVSVUFX?=
 =?utf-8?B?VysxMWM2NXYyWFhoelo1N3BQcmxwTG1QaDRBTTdIQ2VlckEzMTUwbDc1V0po?=
 =?utf-8?B?TWl3Yk5Cc0hnM2JjSnl4dWw3MW1uQmtWVjZlU1V1K1dHRnFiVFZneXd5T2lO?=
 =?utf-8?B?djh5MGhwTWhRcHV0OE92dG1yaitPMGxYajdzU21yUWYzcW1NcjdLdnB6Sjcz?=
 =?utf-8?B?SjJWeEl5Z1dYSHU5dUdWSFB5MkZRcFVHQ1d2elFiSkM3aTZpeGUwSGpOcVdw?=
 =?utf-8?B?M2N5T3RFRmJwdnNwV0g4ZStOZXdDZ3MwakhlVlhjYVl5WkU5dndlZG5MNGpq?=
 =?utf-8?B?MnVlb1p0NnUwVkR4eDY2TlA0QmtGVjl3MEpqbWlwZ2R6NEVycmFnOG5yb3dm?=
 =?utf-8?B?bFRSZnMxMnhoTUlzQnZnZDJnYm01eDdxa0N1YlFWd09JdWJqNVJhQ1RUTmZr?=
 =?utf-8?B?dXNhRTI5Y0VQRkNFaUlJdDdnMTFKVUUxSmRyQ3JjT1VnNVlieGZjWmJ6S1Jw?=
 =?utf-8?B?T3hNS2VTRG4xL21hR3VpL1R5RTdQZ0hZTXhTNjJXWXRXcC9JOXJpSnJFQXVU?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F1FEC48F605BC46A668208D89CDF540@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645abd5b-f3f0-45a1-e64e-08dbdc134543
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 02:19:12.7135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUn5Iuv939rsJG5vz0L6vRRL5e0/Z34c3e/rBQ9Df7mSPQ7LsoiTTeYmh50vwGuUDejf5mrLGeeBOzVLAYqUcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5679
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.838200-8.000000
X-TMASE-MatchedRID: qEAy/z09Hq3UL3YCMmnG4kg/Obfyza3YjLOy13Cgb4+qvcIF1TcLYOpU
        Olu1Vn8Qve0JGeHrI64SVwXUJuzxyBW18E4A1awijoyKzEmtrEd3T8gwfPR6+clXhVyLNg5tnWY
        3ix6jHm955MrUBR+0shvmHdgIY5hMlwV2iaAfSWfSBVVc2BozSlQshXUqyD333ZzbDar2Qzzakj
        6FuUTADwtuKBGekqUpOlxBO2IcOBb4GdgC8iD0mTcykCPFAvUDDIiYzxaHTRJ4uJZKsTmPzfS4C
        J2v1GQKtYKmgy/hRHp6myquVNZbsaCSvkH5b0KNAxBSRrPbDo+vZrXn/T4fmw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.838200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 15ED9099A4E3F3F4458F09BEC468070533BAEE5A5DF27BA9FED1C7EE0CE151C22000:8
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTAyIGF0IDEzOjI0ICswODAwLCBuYW9taS5jaHVAbWVkaWF0ZWsuY29t
IHdyb3RlOg0KPiBGcm9tOiBOYW9taSBDaHUgPG5hb21pLmNodUBtZWRpYXRlay5jb20+DQo+IA0K
PiBUaGUgVUZTSENJIDQuMCBzcGVjaWZpY2F0aW9uIG1hbmRhdGVzIHRoYXQgdGhlcmUgc2hvdWxk
IGFsd2F5cyBiZSBhdA0KPiBsZWFzdCBvbmUgZW1wdHkgc2xvdCBpbiBlYWNoIHF1ZXVlIGZvciBk
aXN0aW5ndWlzaGluZyBiZXR3ZWVuIGZ1bGwNCj4gYW5kDQo+IGVtcHR5IHN0YXRlcy4gRW5sYXJn
ZSB0aGUgYGh3cS0+bWF4X2VudHJpZXNgIHRvIGBEZXZpY2VRdWV1ZURlcHRoICsxYA0KPiB0byBh
bGxvdyBVRlNIQ0kgNC4wIGNvbnRyb2xsZXJzIHRvIGZ1bGx5IHV0aWxpemUgTUNRIHF1ZXVlIHNs
b3RzLg0KPiANCj4gDQoNClJldmlld2VkLWJ5OiBQZXRlciBXYW5nIDxwZXRlci53YW5nQG1lZGlh
dGVrLmNvbT4NCg==
