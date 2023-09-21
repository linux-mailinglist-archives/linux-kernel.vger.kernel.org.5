Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951F27A9674
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjIURHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjIURGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:06:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E1C4237;
        Thu, 21 Sep 2023 10:04:00 -0700 (PDT)
X-UUID: 67b0c9c0588d11eea33bb35ae8d461a2-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DUxyL+g2f5JjO517AAk61+P+WPYdtr46kJjWnHYImT4=;
        b=nga8oPzTiANM44yYQpUtd4mjkhANsWnVd3VlUWuxlgzJpAuVj0+ayohRabcJhBWeRHBr8wGlj3ysCbUncpdoZxoO2E6U86WMGaEjxHdP0hgKEMUpoJP+f/KkB0UiXVw+niYIAsJ+jogHVHYDMDMPK82RMM48NwtRz18vJjbcT1E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c205bee0-6045-490e-af15-6925df6d14b6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:21c33614-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 67b0c9c0588d11eea33bb35ae8d461a2-20230921
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1085752868; Thu, 21 Sep 2023 22:44:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 22:44:43 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 22:44:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bL27AnOdoUW2M2QuHXLLX6wqyBm2Z8jfLV5JC/+ooLOtfsMXa1Ly7RxmUUhdibpwCV+N+RaNN31TtGu/lI9vLVmIxHjYAKJ2ZmkwymoW3lcDXi9EmW8X/Zn8QyQ8Ub5881Anu4gG/rkVuNuR5ONbRBWUCdQKfR72VAOYGYPz5s4K+DLiRk/0Pf+uLRmknubXhoFcMS55uLELqHTKmPXy2E/h+zCQK/3tldB0gBVSbAvopIejCISZMjrBqnYt+Mkw/uwP6LAJ6oVHNYK3FfV2yGSElofKBXOFNh8cKny7EJXWsXgqPKwSzjYkbumM187L3GUFYMnskIdHrGxd8ODtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUxyL+g2f5JjO517AAk61+P+WPYdtr46kJjWnHYImT4=;
 b=ZI7k/LJqiZ/6okIqMmAn0En/7LZSCfw/lClHWcAv5QNYUSKBUDfnrDNugCPuRg9Jv0TFEV3GT4ZgeGadwmvVOcLP1sR8DHrh3FQFKmidwVF4vjlj8FEeTpOwr4adBLgD3vRxdpvDpw8pN6YPt1r3GJbzGp2uwq5MlpxiplTy3pgFQJkN/yA7QDdBG8bmW+ix6AZn4PqU1eqBVT1WqR3bROyVvehf9FSaR8//W3rVQhHmvJXwo9q9RHYMiLFhZxVNgpZUSNK+5W8BuneYW0kbSD6N4Bz9o3XTuUn5tNTMxqQMgu9toRye1tHpVaOTvVtZ/GcUOXSvmpCtUyF4YsNtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUxyL+g2f5JjO517AAk61+P+WPYdtr46kJjWnHYImT4=;
 b=CoG4tP9LRFU7GPKlaIRvmcdjqdjzzrrov0LOVlqH1F0hTJyAotnnONkVxVJe3x9q3IILsKg3G6j62lnBNyEHiWdy2t4TQnrJhHvWxQrJCkDmeYIzp5ltCkKm/tHgpdjL1uKRtnSTH6wlnkal055PRfbYkCIdeq9uZe/uBPsLyEQ=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI2PR03MB5915.apcprd03.prod.outlook.com (2603:1096:4:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 14:44:41 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 14:44:41 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 00/15] Add CMDQ secure driver for SVP
Thread-Topic: [PATCH 00/15] Add CMDQ secure driver for SVP
Thread-Index: AQHZ6mVuPQQZezwywkelz/yPpUfJNbAjCo2AgAJU9QA=
Date:   Thu, 21 Sep 2023 14:44:40 +0000
Message-ID: <65ea3723d217fcbeca41a7a1ed4fac4f97ff8beb.camel@mediatek.com>
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
         <45125e763bbc4b68e328aaab9f5310a65b26def7.camel@mediatek.com>
In-Reply-To: <45125e763bbc4b68e328aaab9f5310a65b26def7.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI2PR03MB5915:EE_
x-ms-office365-filtering-correlation-id: abd30e5b-c84b-46ef-24bc-08dbbab14995
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NP6Pji/0DGUhcEwX2t+VfEf8Vk8gD721Bky6cB/1TmlZgx1rhauJY/MiPHicFKPEhyXAyww++1LrrYyqoHN21W6KIUxGRUmfo9w0P5w9qpOlrvsGtE84j/OPCcEnidWYD9rlsfC03Fv5W5mu+TMESOXZL6yh9BAMjio6zN659XjVczU7Xtd8P0V0S6z6O1TSbb8qcSc1uXN/USFUgKvqvDOYkxT5I4JMVtc9kqJ79xIyzwqR+1bbQJznXMAMBYhJqY+QORWgU4HDtaWWumQY6mi3z5rOuZNIOv8f/EyZzoIpmuU5fTSt7GzSE0bUMmw0g1qG8asKYwQx4W4JBHXpX9E63fQm0XeWFDN0fRdGHkPrGxvSB6iezySNk0z7ACDqQH7lgiRvxQ99V9LLPtYzxJC40a1hv7Ep/B6B4qdYWIeWvDn0yNV9XZOm4+ndKeVkR3GUV00DPewpKxpaMj89Z73X1CZ+Oq+Y8jp9XP/iIuI6kTDRzvPaLEzhDic/ZI7QmjyGBsMjflXo6+EoMwo3q8HZsPdd2OpRZMJNFtQQkqu4dFLeffvGqXfUI2/AvOjwaKsDTnE++2NnTzjcd8sFt0LhqlGBi2pS6jnrL4Ejar7e8QnY2dDNduGK5wMptoPZkctq2w1+qRdKJbE/OREcDNy6i1lsnZyZCaruc5mOtic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199024)(1800799009)(186009)(76116006)(66946007)(66556008)(91956017)(66476007)(54906003)(316002)(110136005)(66446008)(64756008)(6506007)(6486002)(71200400001)(6512007)(478600001)(5660300002)(2906002)(85182001)(38070700005)(38100700002)(122000001)(7416002)(36756003)(86362001)(41300700001)(4326008)(8676002)(8936002)(83380400001)(107886003)(2616005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWw1Qk1qQU9jb28wWTRYQkUyQVV2VFZDVGZxTWtZejFKYlVCN3J2L1lxc2VV?=
 =?utf-8?B?UW12emgxS1VOL0x2Qm5KZ2U5UW4zajBkemQwTld4VUplWlhlV1BrRUM3VDVM?=
 =?utf-8?B?dFNSaGRtRzd6Y0JRNzd3SXlTOUV4QjRnaTFKUC90ak8xMHowY0U3dUx4d2JB?=
 =?utf-8?B?OEtuMFE2czI1VkVDRDVNdllTL3lqZnl0YU1iSVhoemRsazM5TnU4QXRGbjg1?=
 =?utf-8?B?M0xrUnB2cG9PUkttVVRKQXJnN0Vqc0tXNENoYkhTMFhab3UrMmFobUFkSWJC?=
 =?utf-8?B?ekc0d1VsUUQ5Tm5vM241M21LNHlqL2pYRUt2ZHIyUUFSa0dMSGlmdFFGWVk5?=
 =?utf-8?B?bnpvS3hpQ2pWUmwwM1R0c0VMcWFaem9TMWJvWW5kNWVFUjgvL2R1MmFVZnhN?=
 =?utf-8?B?TElyZjJxOUxvaGYrM1JJYnM4VVpCemN2OGFsS2dVemRyU3RDTUZlYlFWYUdV?=
 =?utf-8?B?N3prSmZrVlAxRjA3S0dQcWhsYTh1NDJncUlzSGEzMUtQY1ppOEZhWWwrYnB5?=
 =?utf-8?B?a25HazBYNmJtTmNaWlFFS2NENUVvaEM4SnBzczVJRERvUjNDU0ptMVZyQ2or?=
 =?utf-8?B?c1VaQkNNQTE4d2tXU0JwZ2VZc3JjWFcvT1JuSitFNnd4aGYvbTBlL0p4WGt5?=
 =?utf-8?B?d3haVFp4dG5KckVCV21HN3FlVWZHYUQ2UmxXOHI4Ym1sL0RNVW1RaHZmWGt4?=
 =?utf-8?B?VmZxY1R2RFdreGZpNisyZ01MdExGeXl0MWNpd2NRNW5OUmFsbDlLSndEWnhP?=
 =?utf-8?B?ODBHZEpESTZyYURESmlJM3l4UmN5b3lFRkdiQm85YW1VTE4rREZTYlNCL21z?=
 =?utf-8?B?bTRHZURTZmg5Y3ZzK1k3a1ZFZDF3TnlZNmUrZGZMY1dua2FiSGpXYnlEbTdK?=
 =?utf-8?B?a0h1aVVmNkNBVE5td2VqM0wxclVpRDNId0ZCb3ZMSHJHa3VZelhNbjQ1Q3c3?=
 =?utf-8?B?czhqcTE0S1h2MFBuRGh4Nm5KMmlGTkhuWUlic0c0MCt1R3d3eERMTFhjMklY?=
 =?utf-8?B?Tnc2WTdXZ2FkMnVWbk0rNlMzUDUvOXY2UVlaNitXVkJBYk1zVEdpNCsyNGhF?=
 =?utf-8?B?ZlllemExbzh4VWg0ejREK1A3OG83aU1Vd3FzbXg5cElXVWo5QW50ak56N1gv?=
 =?utf-8?B?QnJFejUvaE56V0wwQmIzY2pHRzc0RTlQZDBQUkl4bDFCZ3QwdjZoM0pYQzZO?=
 =?utf-8?B?WDhuTjRZaE1CdHdMQk14ZHBnNmVuNXFOMmQwb1VIbWowQ1I2R1IxMVdoa0VF?=
 =?utf-8?B?N0VyY1NGc1FSRjFyZjJNcjUvcDY5dDhDMmlNaVhMbitXZjVBV2xBMktOZGRV?=
 =?utf-8?B?WER5U0oxZXBrVnZSSTJ6RkxObDdGODY2VXgyRDNhckdYMGplZXlsQVRPTnRn?=
 =?utf-8?B?WjFyWWthRnFyU21EZUtJcHhPUkpjQVNZYWF4L0prVmE3VXJMKzVqTEV5cVIv?=
 =?utf-8?B?am5hWEFiMytCVk1PU0prczdnRzBCK3BveWREK1VZaHFsZlFFcEpTelMvQ25N?=
 =?utf-8?B?VXowajBjWXl5K3VzTklvOThlbVZYWDEzbm14ZnM0b2ZPaCs5VUs0NHhBVjBP?=
 =?utf-8?B?K1RRUkpLRjBRNTZicGJlalJKWllDTXFWT1hOTGc0N3dmTk83RHRNekIyR2xU?=
 =?utf-8?B?Qm00VkRsc1NqS04wZFA3bVhMQmdIRlJMVVZnbzNvZC9PMkRFcFpVSFZpZWh5?=
 =?utf-8?B?KzJxQVduRkFqMHVEdmxlUGVqMm40d0pMc0tsKzZwZ2xQSjhLWnRlbTZNVXR2?=
 =?utf-8?B?TXVTZnhIN2F2dE5IUXR1aTVOdDcyWGRnaXlzVUxXb2FhSEd6TGo3M0lZWXl1?=
 =?utf-8?B?RkFGSkE4a3BhanVDN0FjazVwZWNWSWxSaGI4NkdlZHI0NXFoSWtrejNwcGZs?=
 =?utf-8?B?YXVQdDhQMWd2OFhKRFlaSGVZOFZHSXhJdm14bHpmVUhNek4rK0ZhZmlQcXp2?=
 =?utf-8?B?eTFsMlBoTnVsMExmOTJycnFJTVhyaFlZK3R4TExaY3E2c3l5R29WVUdWY0o0?=
 =?utf-8?B?Q2ZXME42eTJmMUpQRjcvQmlhU1FrWW82MnROVE9lODVJQ0lEOWUzWHQwTXBM?=
 =?utf-8?B?TC83d2tBcmhFNk1qWFY1WW9PZnBwMXViNU9maGpuNGMzSzdyc2ExK3BOT2ow?=
 =?utf-8?B?RGl1T1NCVTBuOHA0R3dLWEZ2VUNicGx0ZjIvczFDNTFuMHJVN1UvNjJlVjEv?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ADBF7DC7B656944ADD9B949E5E64012@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd30e5b-c84b-46ef-24bc-08dbbab14995
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 14:44:40.9159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxsORvK8bJ3h5o87BghS889cub11FK5tuQFCfJLvHOH59CM6n1njkxjmLCUmlTfyWc4wjIJFljyf/wD9o3zMdtH2SUw7M5DhXtVNafSL3Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5915
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.493900-8.000000
X-TMASE-MatchedRID: vEvJ7Rh1lGgOwH4pD14DsPHkpkyUphL9fjJOgArMOCb3bBqxmjinTeXo
        AzgBreAWFXLD8NIP1b0Czq5TuNJae5TZ9V50RBQ7FyqkfsPWu1Bt3qsaFY4DBH3hz57t9YhwwaP
        rbwLa7q+YmVXmgbm45LeMjJ/qwQ7ObbH8KGCkYT5IcJTn2HkqsVAI6wCVrE3vrPk8Ppt+QlXrxM
        sQ8kkfmtQr8mLciOiiOHY3aadbY80PquTweLs4F1z+axQLnAVBmX+W7bzPOQEREeTKxBqIeaTSR
        JZysx4f5YfG/EnxtB2becf43a8oCcLGbSqN9np0Dko+EYiDQxH/wK4D5v9hhKVznMmzBIHPZ/bj
        8Q3O+RyjkL1tNPFpRq2xWLKCsvPazcCZ20yMYlXuykw7cfAoIH0tCKdnhB58pTwPRvSoXL2ZMPC
        nTMzfOiq2rl3dzGQ1A/3R8k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.493900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 43E852232C09E4EFF2CC34D66421D2B59C2C5A53FB4AA2E1B8994C0E0516B23E2000:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFdlZCwgMjAyMy0wOS0yMCBhdCAwMzowOCArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4gDQo+IE9uIFR1ZSwgMjAyMy0wOS0xOSBhdCAw
MzoyMSArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IEZvciB0aGUgU2VjdXJlIFZpZGVv
IFBhdGggKFNWUCkgZmVhdHVyZSwgaW5jdWxkaW5nIHRoZSBtZW1vcnkNCj4gPiBzdG9yZWQNCj4g
PiBzZWN1cmUgdmlkZW8gY29udGVudCwgdGhlIHJlZ2lzdGVycyBvZiBkaXNwbGF5IEhXIHBpcGVs
aW5lIGFuZCB0aGUNCj4gPiBIVyBjb25maWd1cmUgb3BlcmF0aW9ucyBhcmUgcmVxdWlyZWQgdG8g
ZXhlY3V0ZSBpbiB0aGUgc2VjdXJlDQo+ID4gd29ybGQuDQo+ID4gDQo+ID4gU28gdXNpbmcgYSBD
TURRIHNlY3VyZSBkcml2ZXIgdG8gbWFrZSBhbGwgZGlzcGxheSBIVyByZWdpc3RlcnMNCj4gPiBj
b25maWd1cmF0aW9uIHNlY3VyZSBEUkFNIGFjY2VzcyBwZXJtaXNpb24gc2V0dGluZ3MgZXhlY3V0
ZSBieSBHQ0UNCj4gPiBzZWN1cmUgdGhyZWFkIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gDQo+
ID4gV2UgYXJlIGxhbmRpbmcgdGhpcyBmZWF0dXJlIG9uIG10ODE4OCBhbmQgbXQ4MTk1IGN1cnJl
bnRseS4NCj4gDQo+IEknbSBkb3VidCB0aGF0IEdDRSBjb3VsZCBiZSBzZWN1cmUgZW5vdWdoLiBI
YWNrZXIgd291bGQgdHJ5IGFueSB3YXkNCj4gdG8NCj4gaGFjayBURUUuIElmIHRoZSBpbnRlcmZh
Y2UgaXMgc2ltcGxlLCBpdCdzIGVhc3kgdG8gY2hlY2sgaW4gdGhlDQo+IGludGVyZmFjZSBlbnRy
eS4gQnV0IEdDRSBjb21tYW5kIGhhcyBlbm9ybW91cyBjb21iaW5hdGlvbiwgaG93IHRvDQo+IGNo
ZWNrDQo+IGl0J3Mgbm90IGhhY2tlZD8gT25lIGV4YW1wbGUgaXMgdGhhdCBoYWNrZXIgY291bGQg
dXNlDQo+IGNtZHFfcGt0X3JlYWRfcygpDQo+IGFuZCBjbWRxX3BrdF93cml0ZV9zKCkgdG8gZG8g
bWVtb3J5IGNvcHkgYW5kIHNlbmQgdGhpcyBwYWNrZXQgdG8NCj4gc2VjdXJlDQo+IEdDRS4gQ291
bGQgdGhpcyBtZW1vcnkgY29weSB0b3VjaCBzZWN1cmUgbWVtb3J5PyBPciBkb24ndCB3b3JyeQ0K
PiBhYm91dCANCj4gdGhpcywgb25jZSBoYWNrZXIgZmluZCBhIHdheSB0byBicmVhayB0aGlzLCBq
dXN0IGZpbmQgYSB3YXkgdG8gZml4DQo+IGl0Pw0KDQpXZSBoYXZlIHB1dCBhIGxvdCBwcm90ZWN0
aW9uIG1lY2hhbmlzbSBpbiB0aGUgc2VjdXJlIHdvcmxkIHRvIGF2b2lkIHRoZQ0Kc2VjdXJlIHZp
ZGVvIGNvbnRlbnQgcmV2ZWFsIGZyb20gb3VyIFNvQy4NCg0KVGhlIGhhY2tlcnMgbWF5IHRyeSB0
byBhZGQgc29tZSBjb21tYW5kcyBpbiB0byBjbWRxIHNlY3VyZSBwa3QsIGJ1dA0Kd2UnbGwgY2hl
Y2sgYWxsIHRoZSBjb21tYW5kcyBpbiBzZWN1cmUgd29ybGQgZm9yIGV2ZXJ5IHNlY3VyZSBwa3Qg
YW5kDQpmaW5kIG91dCB0aGUgaW52YWxpZCBvbmUgd2l0aCB3aGl0ZWxpc3QgcmVnaXN0ZXJzIGNo
ZWNraW5nLCBEQVBDIEhXDQpwcm90ZWN0aW9uIGZvciB3cml0ZSBpbnN0cnVjdGlvbiB0byBEUkFN
IHdpdGggY29uZmlndXJpbmcgV0RNQSwgbGFyYg0Kc2VjdXJlIHByb3RlY3Rpb24gZm9yIHJlYWQg
c2VjdXJlIERSQU0gZnJvbSBub3JtYWwgd29ybGQsIGNoZWNraW5nDQpyZWFkX3MgaW5zdHJ1Y3Rp
b25zIGZvciBtZW1vcnkgY29weSB0byBhbiBpbnZhbGlkIERSQU0gYWRkcixldGMuDQoNCk1heWJl
IGhhY2tlcnMgd291bGQgZmluZCB0aGUgd2F5IHRvIGJyZWFrIHRoZSB2aWRlbyBwbGF5YmFjaywg
YnV0IHRoZXkNCmNhbiBub3QgZmluZCB0aGUgd2F5IHRvIHN0ZWFsIHRoZSBzZWN1cmUgdmlkZW8g
Y29udGVudCBieSBhZGRpbmcgYQ0KY29tbWFuZHMgaW50byBzZWN1cmUgY21kcSBwa3QuDQoNClJl
Z2FyZHMsDQpKYXNvbi1KSC5MaW4NCj4gDQo+ID4gDQo+ID4gSmFzb24tSkguTGluICgxNSk6DQo+
ID4gICBkdC1iaW5kaW5nczogbWFpbGJveDogQWRkIHByb3BlcnR5IGZvciBDTURRIHNlY3VyZSBk
cml2ZXINCj4gPiAgIGR0LWJpbmRpbmdzOiBnY2U6IG10ODE5NTogQWRkIENNRFFfU1lOQ19UT0tF
Tl9TRUNVUkVfVEhSX0VPRg0KPiA+IGV2ZW50DQo+ID4gaWQNCj4gPiAgIHNvYzogbWFpbGJveDog
QWRkIFNQUiBkZWZpbml0aW9uIGZvciBHQ0UNCj4gPiAgIHNvYzogbWFpbGJveDogQWRkIGNtZHFf
cGt0X2xvZ2ljX2NvbW1hbmQgdG8gc3VwcG9ydCBtYXRoDQo+ID4gb3BlcmF0aW9uDQo+ID4gICBt
YWlsYm94OiBtZWRpYXRlazogQWRkIGNtZHFfcGt0X3dyaXRlX3NfcmVnX3ZhbHVlIHRvIENNRFEg
ZHJpdmVyDQo+ID4gICBtYWlsYm94OiBtZWRpYXRlazogQWRkIGNtZHFfbWJveF9zdG9wIHRvIGRp
c2FibGUgR0NFIHRocmVhZA0KPiA+ICAgbWFpbGJveDogbWVkaWF0ZWs6IEFkZCBsb29wIHBrdCBm
bGFnIGFuZCBpcnEgaGFuZGxpbmcgZm9yIGxvb3ANCj4gPiBjb21tYW5kDQo+ID4gICBzb2M6IG1l
ZGlhdGVrOiBBZGQgY21kcV9wa3RfZmluYWxpemVfbG9vcCB0byBDTURRIGRyaXZlcg0KPiA+ICAg
bWFpbGJveDogbWVkaWF0ZWs6IEFkZCBzZWN1cmUgQ01EUSBkcml2ZXIgc3VwcG9ydCBmb3IgQ01E
USBkcml2ZXINCj4gPiAgIG1haWxib3g6IG1lZGlhdGVrOiBBZGQgQ01EUSBzZWN1cmUgbWFpbGJv
eCBkcml2ZXINCj4gPiAgIHNvYzogbWVkaWF0ZWs6IEFkZCBjbWRxX2luc2VydF9iYWNrdXBfY29v
a2llIGJlZm9yZSBFT0MgZm9yDQo+ID4gc2VjdXJlDQo+ID4gcGt0DQo+ID4gICBtYWlsYm94OiBt
ZWRpYXRlazogQWRkIENNRFEgZHJpdmVyIHN1cHBvcnQgZm9yIG10ODE4OA0KPiA+ICAgbWFpbGJv
eDogbWVkaWF0ZWs6IEFkZCBtdDgxODggc3VwcG9ydCBmb3IgQ01EUSBzZWN1cmUgZHJpdmVyDQo+
ID4gICBtYWlsYm94OiBtZWRpYXRlazogQWRkIG10ODE5NSBzdXBwb3J0IGZvciBDTURRIHNlY3Vy
ZSBkcml2ZXINCj4gPiAgIGFybTY0OiBkdHM6IG1lZGlhdGVrOiBtdDgxOTU6IEFkZCBDTURRIHNl
Y3VyZSBkcml2ZXIgc3VwcG9ydCBmb3INCj4gPiBnY2UwDQo+ID4gDQo+ID4gIC4uLi9tYWlsYm94
L21lZGlhdGVrLGdjZS1tYWlsYm94LnlhbWwgICAgICAgICB8ICAgMzAgKy0NCj4gPiAgYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaSAgICAgIHwgICAgMiArDQo+ID4gIGRy
aXZlcnMvbWFpbGJveC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKy0NCj4g
PiAgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyAgICAgICAgICAgIHwgICA2NyAr
LQ0KPiA+ICBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtc2VjLW1haWxib3guYyAgICAgICAgfCAx
MTAzDQo+ID4gKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9tYWlsYm94L210ay1jbWRx
LXNlYy10ZWUuYyAgICAgICAgICAgIHwgIDIwMiArKysNCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMgICAgICAgIHwgICA4MSArKw0KPiA+ICBpbmNsdWRlL2R0LWJp
bmRpbmdzL2djZS9tdDgxOTUtZ2NlLmggICAgICAgICAgfCAgICA2ICsNCj4gPiAgaW5jbHVkZS9s
aW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCAgICAgIHwgICAxNSArDQo+ID4gIC4uLi9s
aW51eC9tYWlsYm94L210ay1jbWRxLXNlYy1pd2MtY29tbW9uLmggICB8ICAyOTMgKysrKysNCj4g
PiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLXNlYy1tYWlsYm94LmggIHwgICA4MyAr
Kw0KPiA+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtc2VjLXRlZS5oICAgICAgfCAg
IDMxICsNCj4gPiAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICAgICAg
IHwgICA2NSArDQo+ID4gIDEzIGZpbGVzIGNoYW5nZWQsIDE5NzEgaW5zZXJ0aW9ucygrKSwgOSBk
ZWxldGlvbnMoLSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWFpbGJveC9tdGst
Y21kcS1zZWMtbWFpbGJveC5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtc2VjLXRlZS5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xp
bnV4L21haWxib3gvbXRrLWNtZHEtc2VjLWl3Yy1jb21tb24uaA0KPiA+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLXNlYy1tYWlsYm94LmgNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1zZWMtdGVl
LmgNCj4gPiANCg==
