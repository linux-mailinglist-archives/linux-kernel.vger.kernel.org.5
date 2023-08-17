Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50C877F1BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348683AbjHQIDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348751AbjHQIDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:03:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628E4E48;
        Thu, 17 Aug 2023 01:03:17 -0700 (PDT)
X-UUID: 83600d683cd411ee9cb5633481061a41-20230817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kYX4Xd3sitoAMSJjEvWegf9FXCtEBCZ87RtzpglMfBw=;
        b=rmhpFuO7+KeQj+mC6IiLtgV+0ynfy21NsM+q9vJxHyxROipx57oMgQd34ht3SoUQvK+WR9Ty+Oksc5RQcMJp/SyGu2Tla7WstKg1eJtG2Vzuj1xH2mKVCeiIOygMTUlYIywaOzT/rp8xeCGhhkChly/N/bNQKwClYgQ3W3C/KmA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:c2ce8db7-356f-45aa-a80e-93b4c99db720,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:6f50df12-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 83600d683cd411ee9cb5633481061a41-20230817
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1551104597; Thu, 17 Aug 2023 16:03:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Aug 2023 16:03:11 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Aug 2023 16:03:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBwybJe3FNKz0XELlk0IUtuUD7IbHzspiAVGAaLIx8bqnx0iXQM/VX+CKAwx6H6UR+B/yHyJYqxKAd7e3F0nXnRpTafcj62HPQBURYzuT2W/Ok/L+qmKG+vP0sJam31npR5A4Rfxei6zDMTwdhiragSVKfn8Rh12iaR0gDIv1NqL9QbUP49XE8/1VGW8Mnzh2xS80kECQ8d4zVqY6Cwgx+itQB8Iwa5vMw1fqBdT133wYmhkTd+X8W52iL3vAt5RKjsK3c54n3Ckm2Kg4WedFiar1T/x4qq5ztl6njg0oOSohI/DZIBxzwKIpH0bxTEc/PRmluXOZs0vKEj2kJrAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYX4Xd3sitoAMSJjEvWegf9FXCtEBCZ87RtzpglMfBw=;
 b=SYmDBJ/gx5vFVJuZk4cb1Gy9hMXLg4ThJ0lHrpuu0NdQUXbcECKEleGxcgJRClQXZDnSnlcRFGZ+15xDUSUq4fDC3BlkyZc++oDiQyNHhhFnGbZC01vR98aZACTeYPahWTCcpshNWD4ecz9NK2O0fyHCyIhpxWRy50D7iztGtwbXVnGxxOgb1bT9CXRsf5Ck4uv/KsmOPVfvjHKYjvW09Fzovzm5zQyd6yHRTnG1oz1GIZwxDheBXqrF9Gm2dJGU3VjmSSaUm/A8ltbN6yDtYsApaJC4AwRcCu4qAXqRFqOsNp231DQbtpcU/HFXVcrI/5dgAOUh3a86oy8dwGK44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYX4Xd3sitoAMSJjEvWegf9FXCtEBCZ87RtzpglMfBw=;
 b=iuFezu2kDi839AxeYVqQAcRLW/sQ6h2JBeRSbjE4zQqwrfnfUpfHmN/L1JboM9FB5yQgWdpAPKzuJeUvWfBB3HK2xwz0JVEqab6n4ujGyjEuf/32pwZOLJ6MxZOE9HbcerjtjCYhG7v+L5QkVgh3QpKJ61OlVcST+qLHtEYi3Yw=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SI2PR03MB5644.apcprd03.prod.outlook.com (2603:1096:4:12d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Thu, 17 Aug 2023 08:02:00 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::8c43:33cf:6057:fdfe]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::8c43:33cf:6057:fdfe%7]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 08:02:00 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v12 5/7] iommu/mediatek: Add MT8188 IOMMU Support
Thread-Topic: [PATCH v12 5/7] iommu/mediatek: Add MT8188 IOMMU Support
Thread-Index: AQHZlTFol72i25hY8ESS/o7MevPsra/gkh6AgANOQwCAAP23gIAE9YkAgAASpICABK2cgA==
Date:   Thu, 17 Aug 2023 08:01:59 +0000
Message-ID: <2607586420f4c81a2e2fd9f3395263e85d1f83ef.camel@mediatek.com>
References: <20230602090227.7264-1-yong.wu@mediatek.com>
         <20230602090227.7264-6-yong.wu@mediatek.com>
         <CAGXv+5EKwvn-axETPcuxTpxRkUGLroymeDYL+kr4QW8duAymmQ@mail.gmail.com>
         <b695962fa3c3baac08f8be5202e6a5697e7826a0.camel@mediatek.com>
         <CAGXv+5EVqODJJ4Ck+EcB9sn1bTjG5yFrWLi9mHTfVa0sB4wsug@mail.gmail.com>
         <810a3cbca7e837925b5750fd2eb1d1a261e865dc.camel@mediatek.com>
         <CAGXv+5G=CM9203GR42szWXx8K7F+swkvKJ_M3ev5_bGTk_zjGg@mail.gmail.com>
In-Reply-To: <CAGXv+5G=CM9203GR42szWXx8K7F+swkvKJ_M3ev5_bGTk_zjGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SI2PR03MB5644:EE_
x-ms-office365-filtering-correlation-id: 28ed75f1-d09c-447f-57dc-08db9ef83c0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xv23aJkXcaK58JqHZz3cAg4lOQCKjyqGYF4Fup91y4kpNg/t0akGMl3VG9D8D/VsZ++N2nqY8A1FKBVAtzF0VO3nJnjxs+t7tQhTKJ/ZOlhSX8sC50Q3VTqqAo7jVM2VA/Cv82U616IkERO3DyM+swi4wl1y4MPw0vbVc8xIzzr3UKxLrBDMnC5KJnYPLPm0etxblYLxlZw3ka+psGVLWn2IY9LdrnPrRnhEueiyXgB99jA3FukpCjZ1Uvd2cP7AsY63Uw1HK369AsN3x+q9HQ5ahfXxCBf5ud6YUZeqjpiFobTioRp+vbwKG+x583WgDGminZU8CtusPW5dhkpBOn9if3+J7RS7CZq+NL3197jgpj8TCGrXnPEierJIhq65QOXj5IFdfKvcOKd5Km+gFceSctpqSCh/fmjNg+DT4SfeVkn3mSbeIcbr1cfPhNf7piRxLP4PJAOfav4Y3uNqI5DfqaUQaOEZJ79Xcs4+ZojYWNF7cB/cHa0BMJ3I8Qz6IjoUlDpvBK3ZvwrcxeMztIeosifLXdgqHmQ4o3iN1OLt4dEBWiSGQ9OsZd1CVAr+oykL4r168rriexHXNh5Lufw3eYcIKFelRWmJl8z++PhHNtBl+5U/Pz5O/AQKgM4PloFjYhE43V27wZ56nZ7w6Bm1eTZnbiuzFen2snETM+sSk7WnGJqXBZNQD/pgbP5sHKwpsRHUTSNrZfCAULLOvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(1800799009)(186009)(451199024)(6916009)(66446008)(66556008)(66476007)(66946007)(76116006)(316002)(64756008)(54906003)(12101799020)(5660300002)(41300700001)(2906002)(478600001)(8676002)(4326008)(8936002)(86362001)(7416002)(38100700002)(38070700005)(71200400001)(966005)(6506007)(53546011)(6486002)(122000001)(6512007)(2616005)(26005)(36756003)(83380400001)(85182001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTU5b0xlb3hoNXQzd0ZHaDlvcGVlZTlrU1hjMmZDaXFmcG1zUm56SEdudk8x?=
 =?utf-8?B?bFkrcEcvR3B0QnpIbHRKbHA5dFRjVndQVURkRFg4MjNZU1A4YytiWjBMTVNU?=
 =?utf-8?B?bmtLdHFkZjYxbGxNcmZWVmE3TEFGSkdkWisyaGJhekFIckUzanpwNGROc0tv?=
 =?utf-8?B?VGdyeDZnd3lSTnZxOXhoM1FMcWZUR01zci9rZndpb1lqUmtyV2hPclFwY0xZ?=
 =?utf-8?B?eGVscWJyYVR5WWNISE1vaWpvQW5LVGowMTZXMVJHaTFEbXF6RWtQNmpWNVFI?=
 =?utf-8?B?cG9NeS9ySFdwZmNDZjkvM0J0aytvMFEvU3hHRGIvRFU4Rk5uejB3WWNnVCtM?=
 =?utf-8?B?SjVoR25sbEI0TWFodGYwZ25JNDJTVTNHMVdSdk9pcU9qTmFQdEJPeGFFN0Fv?=
 =?utf-8?B?T3FuN3ZMcjZjSjVkV21zVXJmQTJnWkg1WU5FaVR3dUtFY0pSdnp3bVE1THU5?=
 =?utf-8?B?KzBPMldLLzJBRkUvOUxhdWE5L3p0SXNtWDQyak5sV1g1c3hlZnVDNjhnYm00?=
 =?utf-8?B?SUgwclF2eWd4Tkx4Y2sxWThmM2NaYnlvU3JKUjVRNlNXRUppam9OcmltdE1v?=
 =?utf-8?B?bll2VnQ0TjRVSCtaUUQzSDhEMlZQMVhNNkhLNnlESmZFN0NPTXd4cEJjWkNy?=
 =?utf-8?B?eHd4TkROOG5jekZoM2NzRnVhOWRhU3pkSGs3VmR5NXVWeEpmRUU0VFA5dFhj?=
 =?utf-8?B?N090R0N6dS84UU5FYXdHTEtBcmlZOHJ3WWdVdmduKyttS3MrTmNqTGM0OVRQ?=
 =?utf-8?B?VnVobzlMU1pEZkRGbmlxTW1PeHVWRWgyVFVHS3pEM2M0d29wbGdaMXZQaTJo?=
 =?utf-8?B?WXNzaGJjcmJZUDdvVUYrMG81dHJ4bFBSdUhHS2FTRVRCRFk2WlRUSmVxUk9F?=
 =?utf-8?B?VmdSa01VWUpjZnZsTFVxcjlyNnAyQkRBL2NMRExYYkVVbzhrZGQ0VThsbW85?=
 =?utf-8?B?cnNpV2hiS3hXRG9TZVQ5QVpOWXZnMnZWRVBFR2tTdWpOKzNValN0OGdYVjBP?=
 =?utf-8?B?QkQwejBOeWgyV0IvTzQrWDNzdVAyejlWRlJ2a00wTlBnQjdmSFp1R01xeEt5?=
 =?utf-8?B?Z0VpaUMyUXhFQ1Vxc1FURE1LTlhsRE50YlZnOEdWdVRBMHFKakNPaFM5MVZH?=
 =?utf-8?B?NndvYmtGUG44U083djBteW55eFFJRzVFN3ZHNjhPUW1rb3BFTStGTWRtV0xk?=
 =?utf-8?B?MGNHUmg0YmMzcXF3UFNXTzRpeWpNSHZ4VGZYenRrVkdxbG10QU9OTFVHaXA4?=
 =?utf-8?B?S0NpZ082V3ZzblJJNWRyMk9lc3o3eHJ3ckZMQTl0V3BjRjVaYlhxUkNqT0FP?=
 =?utf-8?B?YXE3Qmc0NTVoem9nOTFWQTNIVnlHQUFCRW1vVkV1NzdOT3E1a2d5MHl3SFd2?=
 =?utf-8?B?SkU1K0pTNCtnd0dhNnJUV2UrQVZka0VaZGRRaU1aeit4VzJLUHVGTGJlc25t?=
 =?utf-8?B?a0NpL0hMMmc5WklXY2U0U3F4TUptdFNuVFRNdTZSMHprQ0EwelNXNm80QUpl?=
 =?utf-8?B?MGVIdXhkakU1V1pkaGQvSzlXUTZ0ZTlHWkZtVTBQRUlPQTlZK2Z4dkxaaFpL?=
 =?utf-8?B?Z2xXS280U25MdW8vZ3dHb2VnRVBrT01iOUNEa2VaT1A0ckIrYmVnOC9jS09u?=
 =?utf-8?B?VjhhVmRkUTJhRFBzSkowZkRpdisvT0N1d0NuV0c2WHlZQXhST3J2QkFha1Q2?=
 =?utf-8?B?ZjN1QnVqNmVJMGkybnBOSEQ3dlJwd3Rqc3lLdVhNaVg5WXlYVDNQMWVSaFlK?=
 =?utf-8?B?dGU2bUlndTRZazQvbVY2VlJ0dmRvbFo3Um9aTVYxTzNyejFCOE5EK21TN0w2?=
 =?utf-8?B?K2xYdCtHSVNqTXYxVU14aDR6WW9YRy95Q0VyVEZWcHlmMHJHbGI2SVhjeTZq?=
 =?utf-8?B?SWd4K1I1a2FJTmdBbFFreFo2MkxLd1JBdks4enUvcDBicC9COCtXa25XbGVQ?=
 =?utf-8?B?dUR5OHVOUlRwM1lROWEzcTdGK05XWktqMFNlcmRTSW9hTHZ0LzBoOGNIL0N0?=
 =?utf-8?B?TEpiY0VERGVqSFUxaksrV242YnJVZTV0VzBVdUI0OENzWGpPWWZXd0k1a21G?=
 =?utf-8?B?KzFPSTVpclFEbEtGZUxOKzBMM09aQ20xY3BLQmxHTHpUWGR1RTFFMmcwL21k?=
 =?utf-8?Q?FtgcIb8pfS/2q1qCsQxqIF3rG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4F415FE3141E44E9948C83C08111010@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ed75f1-d09c-447f-57dc-08db9ef83c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 08:01:59.9734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xz3gmpW74dp5g6sCsO5bDaUZtQ1m+SbkbE9rL1p1W/T+oBA/Nhwto3Ac/+4j0TvWQOYctwL5si9s93ZvwsFofA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5644
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDE2OjIxICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gTW9uLCBBdWcgMTQsIDIwMjMgYXQgMzoxNOKAr1BNIFlvbmcgV3Ug
KOWQtOWLhykgPFlvbmcuV3VAbWVkaWF0ZWsuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZy
aSwgMjAyMy0wOC0xMSBhdCAxMTozMCArMDgwMCwgQ2hlbi1ZdSBUc2FpIHdyb3RlOg0KPiA+ID4N
Cj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzDQo+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gIE9uIFRodSwgQXVnIDEwLCAyMDIzIGF0IDg6MjPigK9Q
TSBZb25nIFd1ICjlkLTli4cpIDwNCj4gWW9uZy5XdUBtZWRpYXRlay5jb20+DQo+ID4gPiB3cm90
ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24gVHVlLCAyMDIzLTA4LTA4IGF0IDE3OjUzICswODAwLCBD
aGVuLVl1IFRzYWkgd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6
IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Blbg0KPiBhdHRhY2htZW50cw0KPiA+ID4g
dW50aWwNCj4gPiA+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiA+ID4gPiA+ICBPbiBGcmksIEp1biAyLCAyMDIzIGF0IDU6MDTigK9QTSBZb25nIFd1
IDx5b25nLnd1QG1lZGlhdGVrLmNvbQ0KPiA+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBGcm9tOiAiQ2hlbmdjaS5YdSIgPGNoZW5nY2kueHVAbWVkaWF0ZWsuY29tPg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE1UODE4OCBoYXMgMyBJT01NVSwgY29udGFpbmluZyAy
IE1NIElPTU1Vcywgb25lIGlzIGZvciB2ZG8sDQo+IHRoZQ0KPiA+ID4gPiA+IG90aGVyDQo+ID4g
PiA+ID4gPiBpcyBmb3IgdnBwLiBhbmQgMSBJTkZSQSBJT01NVS4NCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaGVuZ2NpLlh1IDxjaGVuZ2NpLnh1QG1lZGlhdGVrLmNv
bT4NCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsu
Y29tPg0KPiA+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IDwNCj4gPiA+ID4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+
ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwg
NDkNCj4gPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4g
PiBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiA+ID4gPiA+IGluZGV4IDljODljZjg5
NGE0ZC4uNWM2NmFmMGM0NWE4IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYw0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KPiA+ID4gPiA+ID4gQEAgLTE3MCw2ICsxNzAsNyBAQCBlbnVtIG10a19pb21tdV9wbGF0IHsN
Cj4gPiA+ID4gPiA+ICAgICAgICAgTTRVX01UODE3MywNCj4gPiA+ID4gPiA+ICAgICAgICAgTTRV
X01UODE4MywNCj4gPiA+ID4gPiA+ICAgICAgICAgTTRVX01UODE4NiwNCj4gPiA+ID4gPiA+ICsg
ICAgICAgTTRVX01UODE4OCwNCj4gPiA+ID4gPiA+ICAgICAgICAgTTRVX01UODE5MiwNCj4gPiA+
ID4gPiA+ICAgICAgICAgTTRVX01UODE5NSwNCj4gPiA+ID4gPiA+ICAgICAgICAgTTRVX01UODM2
NSwNCj4gPiA+ID4gPiA+IEBAIC0xNTkzLDYgKzE1OTQsNTEgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dA0KPiBtdGtfaW9tbXVfcGxhdF9kYXRhDQo+ID4gPiA+ID4gbXQ4MTg2X2RhdGFfbW0gPSB7DQo+
ID4gPiA+ID4gPiAgICAgICAgIC5pb3ZhX3JlZ2lvbl9sYXJiX21zayA9IG10ODE4Nl9sYXJiX3Jl
Z2lvbl9tc2ssDQo+ID4gPiA+ID4gPiAgfTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE4OF9kYXRhX2luZnJhDQo+
ID0gew0KPiA+ID4gPiA+ID4gKyAgICAgICAubTR1X3BsYXQgICAgICAgICA9IE00VV9NVDgxODgs
DQo+ID4gPiA+ID4gPiArICAgICAgIC5mbGFncyAgICAgICAgICAgID0gV1JfVEhST1RfRU4gfCBE
Q01fRElTQUJMRSB8DQo+ID4gPiA+ID4gU1REX0FYSV9NT0RFIHwgUE1fQ0xLX0FPIHwNCj4gPiA+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBNVEtfSU9NTVVfVFlQRV9JTkZSQSB8
DQo+ID4gPiA+ID4gSUZBX0lPTU1VX1BDSUVfU1VQUE9SVCB8DQo+ID4gPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgUEdUQUJMRV9QQV8zNV9FTiB8DQo+ID4gPiA+ID4gQ0ZHX0lG
QV9NQVNURVJfSU5fQVRGLA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRldJVywgQ0ZHX0lGQV9NQVNU
RVJfSU5fQVRGIHNob3VsZCBub3QgYmUgdGllZCB0byB0aGUNCj4gY29tcGF0aWJsZQ0KPiA+ID4g
PiA+IHN0cmluZywNCj4gPiA+ID4gPiBidXQgc2V0IHZpYSBhIERUIHByb3BlcnR5LiBUaGUgSU9N
TVUgY29udHJvbHMgYXJlIHNlY3VyZWQgYnkNCj4gPiA+ID4gPiBmaXJtd2FyZS4NCj4gPiA+ID4g
PiBJdCBpcyBub3QgYSBwcm9wZXJ0eSBpbnRyaW5zaWNhbGx5IHRpZWQgdG8gdGhlIGhhcmR3YXJl
Lg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgZmxhZyBDRkdfSUZBX01BU1RFUl9JTl9BVEYgbWVhbnMg
dGhlIHJlZ2lzdGVycyB3aGljaA0KPiA+ID4gZW5hYmxlL2Rpc2FibGUNCj4gPiA+ID4gaW9tbXUg
YXJlIGluIHRoZSBzZWN1cmUgd29ybGQuIElmIHRoZSBtYXN0ZXIgbGlrZSBwY2llIHdhbnQgdG8N
Cj4gPiA+IGVuYWJsZQ0KPiA+ID4gPiBpb21tdSwgd2UgaGF2ZSB0byBlbnRlciBzZWN1cmUgd29y
bGQgdG8gY29uZmlndXJlIGl0LiBJdCBzaG91bGQNCj4gYmUNCj4gPiA+IEhXDQo+ID4gPiA+IGlu
dHJpbnNpY2FsLCByaWdodD8NCj4gPiA+DQo+ID4gPiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5
LCB0aGlzIGlzIGZvcmNlZCBieSBzZXR0aW5nIHNvbWUNCj4gcmVnaXN0ZXJzLg0KPiA+ID4gVGhl
IHJlZ2lzdGVycyBhcmUgc2V0IGJ5IHRoZSBmaXJtd2FyZSBhdCBib290IHRpbWUuDQo+ID4NCj4g
PiBUaGUgcmVnaXN0ZXIgd2lsbCBiZSBzZXQgYmVmb3JlIHRoZSBtYXN0ZXJzIHRoYXQgaGF2ZSB0
aGUgImlvbW11cz0iDQo+ID4gcHJvcGVydHkgcHJvYmUuIElmIHRoZSBtYXN0ZXIgZG9lc24ndCBo
YXZlICJpb21tdXM9IiBwcm9wZXJ0eSBpbg0KPiBpdHMNCj4gPiBkdHNpIG5vZGUsIHRoaXMgcmVn
aXN0ZXIgd29uJ3QgYmUgc2V0LCB0aGVuIGl0cyBpb21tdSB3aWxsIGJlDQo+IGRpc2FibGVkDQo+
ID4gYW5kIGl0IGhhcyB0byBhY2Nlc3MgY29udGludW91cyBidWZmZXIuDQo+ID4NCj4gPiA+DQo+
ID4gPiBTbyBpZiBhIGRpZmZlcmVudCBmaXJtd2FyZSB0aGF0IGRvZXNuJ3Qgc2V0IHRoZSByZWdp
c3RlcnMgaXMNCj4gdXNlZCwNCj4gPiA+IHRoZW4gdGhlIElPTU1VIGlzIGF2YWlsYWJsZSB0byBu
b24tc2VjdXJlIGtlcm5lbCwgY29ycmVjdD8NCj4gPg0KPiA+IE5vLiBUaGUgbWVhbmluZyBvZiB0
aGlzIHJlZ2lzdGVyIGlzIHdoZXRoZXIgdG8gZW5hYmxlIGlvbW11LiBJZiB0aGUNCj4gPiByZWdp
c3RlciBhcmUgbm90IHNldCwgdGhlIElPTU1VIGZvciB0aGF0IG1hc3RlciBpcyBkaXNhYmxlZC4N
Cj4gDQo+IEZvciBjbGFyaXR5LCBJJ20gcmVmZXJyaW5nIHRvIFBFUklfTVNUX1BST1QgWzFdLCBu
b3QgdGhlIHJlZ2lzdGVycyBpbg0KPiB0aGUNCj4gSU9NTVUgb3IgTEFSQnMuIFNvIG5vdCBhbnkg
b2YgdGhlIHJlZ2lzdGVycyB1c2VkIGluIHRoaXMgcGF0Y2guDQo+IA0KPiBJZiB0aGF0IHJlZ2lz
dGVyIGRvZXNuJ3QgcmVzdHJpY3QgYWNjZXNzIHRvIElPTU1VIHJlZ2lzdGVyIHNwYWNlIHRvDQo+
IHNlY3VyZQ0KPiBvbmx5LCB0aGVuIEkgYXNzdW1lIGl0IGlzIGNvbnRyb2xsZWQgYnkgZnVzZXM/
DQoNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uIFVuZGVyc3RhbmQgdGhpcyBub3cuIElm
IHRoYXQgcmVnaXN0ZXINCmRvZXNuJ3QgcmVzdHJpY3QgdGhpcywgdGhlIHJlZ2lzdGVyIGZvciBl
bmFibGluZyB0aGUgaW9tbXUgY291bGQgYmUNCmFjY2Vzc2VkIGluIG5vcm1hbCB3b3JsZC4NCg0K
PiBbMV0gDQo+IGh0dHBzOi8vcmV2aWV3LnRydXN0ZWRmaXJtd2FyZS5vcmcvcGx1Z2lucy9naXRp
bGVzL1RGLUEvdHJ1c3RlZC1maXJtd2FyZS1hLysvYmU0NTcyNDhjNmIwYTdmM2M2MWJkOTVhZjU4
MzcyOTM4ZDEzZGVjZC9wbGF0L21lZGlhdGVrL2RyaXZlcnMvaW9tbXUvbXQ4MTg4L210a19pb21t
dV9wbGF0LmMjOTMNCj4gDQo+ID4gPg0KPiA+ID4gVGhhdCdzIHdoeSBJIHNhaWQgdGhhdCBpdCBz
aG91bGQgbm90IGJlIHRpZWQgdG8gYSBwYXJ0aWN1bGFyDQo+IGhhcmR3YXJlDQo+ID4gPiBwbGF0
Zm9ybSwgYnV0IHNldCB1c2luZyBhIGJvb2xlYW4gZGV2aWNlIHRyZWUgcHJvcGVydHkuDQo+ID4g
Pg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSWYgb24gc29tZSBvdGhlciBwcm9qZWN0IHRoZXJlIGlz
IG5vIHN1Y2ggc2VjdXJpdHkNCj4gcmVxdWlyZW1lbnQNCj4gPiA+IGFuZA0KPiA+ID4gPiA+IHRo
ZQ0KPiA+ID4gPiA+IElPTU1VIGlzIG9wZW5lZCB1cCB0byBub24tc2VjdXJlIHdvcmxkLCBhbmQg
QVRGIG5vdCBldmVuDQo+IGhhdmluZw0KPiA+ID4gPiA+IHN1cHBvcnQNCj4gPiA+ID4gPiBmb3Ig
dGhlIFNNQyBjYWxsLCB0aGlzIGJlY29tZXMgdW51c2FibGUgYW5kIGhhcmQgdG8gcmVjdGlmeQ0K
PiA+ID4gd2l0aG91dA0KPiA+ID4gPiA+IGludHJvZHVjaW5nIGEgbmV3IGNvbXBhdGlibGUgc3Ry
aW5nLg0KDQpUaGVuIHRoaXMgbWFrZSBzZW5zZS4gU29ycnksIEkgZG9uJ3Qga25vdyBpZiBzdWNo
IHByb2plY3QgZXhpc3QsIEkNCmd1ZXNzIG5vLCByaWdodD8gd2UgY291bGQgYWRkIGl0IHdoZW4g
bmVjZXNzYXJ5Pw0KDQpUaGFua3MuDQoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IENoZW5ZdQ0KPiA+
ID4gPiA+DQo=
