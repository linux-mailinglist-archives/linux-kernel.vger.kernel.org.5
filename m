Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540077B110D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjI1DFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1DFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:05:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F25D114;
        Wed, 27 Sep 2023 20:05:37 -0700 (PDT)
X-UUID: e3f69e6a5dab11eea33bb35ae8d461a2-20230928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Qpny3UoooX/udNnUGnuE05j21cB8YeBQD3/JiO1X+JU=;
        b=lY2qKtEkrt4l5GYZzeeABeJSGup1O27Zf3goo8eHjtGqp6awpL1L67BCbPzIhFYKKI31M01SuW1URGiqmAWLS8nzAu7JKP9fEG4saeKaSYqVAVIwRR0EEKSEtkf+2qJRx+jUSAhHdLB4hC8OmPVlMBPDbqzpAVRY/DQJ75NeTQs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:f7671115-64eb-407f-bd38-22234933a3c8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:88395cbf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e3f69e6a5dab11eea33bb35ae8d461a2-20230928
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 654807745; Thu, 28 Sep 2023 11:05:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Sep 2023 11:05:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Sep 2023 11:05:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNkejvUws5JxjrwGqJAUBJfn8F1VAT/oZudTr96IzyHHPu6sO/uo6eKq3800Dd3hYjavGLZpof2n5mAcG9D7CUgODNKRkmXOLggsZl22JsUdfYzlENFBdYrxuR0X0QTLLUaT3wPVZq42qdT0bORPbkUVsi2VLDMgFlI0LvQMIoj5Sn3xP2kwN/0gs8DhpiyoCsWuBYEXuR/YGCYFqYmBf00TKy1ErekkQFwZYN8Y7BcFAfxSZ6t4Z6VgmjuvkwcDv8nzR22LiNcsfWWHSAUiEtp4axmxIhMOVbPwApcxQ5jcO/K98GMBtfAPTPpzf5h4wDR8bfBs9lsY1BSu3tImbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qpny3UoooX/udNnUGnuE05j21cB8YeBQD3/JiO1X+JU=;
 b=YhvT9uKFk7gGVTpw6Cbi47gq6dmLL7QLCDiCJanpp8FccUXF/SUrg6V76Q/wmooSUUT6d7M102wrd71WG0XW0eVTbulDuYBlmbrDllv4ZQOv5Ck1FDt2lRwdUMQPt9jkYZ/ODLssHdWZuOQTz9lUCgzhLzWNDeM+QpnL4mfv4LcQSwt4hckos+kBlthDBvhPkGZnXxdZhAtgBNeXQUbm3kMD+RieAN3D0XuyVbFa654ODcygoXzfXVQJqCCgTwGA7qYUcAU8cV2f+TN95YtbWmUQ+YhDVrn1Be7UfKYTl0QibDkhQQIEJJEwMqlDP7StuX9UiMLthI55qxyCuMG5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpny3UoooX/udNnUGnuE05j21cB8YeBQD3/JiO1X+JU=;
 b=Amtj45QRIcWRto90UaoCv/n1mRYwTT14X1gvmNjyY7ZXNjYTo7DRuwzdYKu9PU9hAI/Mwb8fyVMYJbrbMplRC+TI51YjZE8pfSEm8tkVTJJj3qbHx7u8tu4PfmALRXgW0khXt9IxkroAStTa/aTFoUXCFSHYaDCNm2tb463dets=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5498.apcprd03.prod.outlook.com (2603:1096:4:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 03:05:30 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.026; Thu, 28 Sep 2023
 03:05:29 +0000
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
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [RESEND PATCH v6 17/20] drm/mediatek: Support MT8188 Padding in
 display driver
Thread-Topic: [RESEND PATCH v6 17/20] drm/mediatek: Support MT8188 Padding in
 display driver
Thread-Index: AQHZ5IO+9sPhD0781ECQTA3TJNZZLrAvqD2A
Date:   Thu, 28 Sep 2023 03:05:29 +0000
Message-ID: <9fc58793d90b7a984dc3d40ac44719e9869b1202.camel@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
         <20230911074233.31556-18-shawn.sung@mediatek.com>
In-Reply-To: <20230911074233.31556-18-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5498:EE_
x-ms-office365-filtering-correlation-id: 28a833a4-eda9-4c06-8927-08dbbfcfc59a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JYYm87Nbj5UymS/j7BB9ilufrbpPOgTAkHAUjVua3OUzDcpth4oryV7k7HzcK+xIPKmNT6Uhtk7p4ksFxyfzIyllobhkTNqRhX0jhcnKry3+tKqSKl69UcQ3uUd+l0IaUlkKvktQlC3vFf8QkjfHpmR/fJDuGnaqe80VP8ppzRCqTZxs+k4K7TBdQ0ulTqMV0NaH2oKIoHpYcw1aVaxYDg2XIlXZu2xqTMNBODA7Ynw3JbxgF75cMuqDv7DoDS+o/vcCTfP72pkzQ0pUlhR86PrzLMGhawCWgOO2piOBIBFJzqm/7o/thyzsZW7ggL5jMZmkSGT5IVZ1aQWyGh8SOthoqVGraWAffVckBRGcpHBUbiZ3NU34OFBxRdfM7qziJuFE78UZ022TOvEUqE5VH0gRTdC4JNoDeTQvHuxcGSXK3ESclELLPmg6j94hlSyvcIwmYUEQzIPFE5c5tXe+DFhEJ8BhyScAs5zcWOYdayxGsF+sgzzx+e5pq2XQveYjr0Hqqlw4okPgn+j5cvGN3vWGxVTrnztNwH6zv23T8ezoc4Wylhg97D5htj4rQ7co2KOgsaa6qjiBp5ExL/HKoLVIIMyEJ0j0t2vgB3RHgHGLFzAyRsmha8e3JGXETpRzFrFlP4+l0nz+GF3mmJX/I1oNh+G019tSrbW0pzkIVJ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700005)(38100700002)(36756003)(85182001)(86362001)(66946007)(76116006)(2906002)(2616005)(71200400001)(66556008)(64756008)(41300700001)(54906003)(110136005)(316002)(6486002)(5660300002)(478600001)(7416002)(6506007)(66446008)(122000001)(6512007)(66476007)(83380400001)(66899024)(8936002)(4326008)(8676002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2l6dEJ1elIwOXE0QmZzUGs0S3dHSXBQaHc5R3RHcGd1VFR3cC9kNmdjdWQx?=
 =?utf-8?B?RDJMdXF0YlVOSkZ3UGtNMXF1WEk3WVlQUy8wOEZ5WjR6bmMwNVlPZU5PbEJw?=
 =?utf-8?B?SDBVWmlFRi93ZUs3dXF3aXpJdEVXVTd6Q0hudDNTdkZsbCtmbzBjSUNSSVE3?=
 =?utf-8?B?ZVU1NXdJU2RFc3VSUVZ6QUNOQ0JXNXNUNHF0WXRmS2w0aWU2NjhBZVlmbE1X?=
 =?utf-8?B?NlVBaXBxZ1d3cjBLTDF1dGxYUWxlQjVGRzJ0WXFNZC9xczdiN01NTU5kc2h4?=
 =?utf-8?B?cDIwV3hSbmY3bkJvZVRoSWlRWmt3WEhVNDFod1VIRXJSRTBwQ0VKRlRVTXJy?=
 =?utf-8?B?V3RkR0Iyd3ZnRVBzOTduVlpqbStHa25PRGdpczYvTUZYYjJHSmxsQ3U4Wkgz?=
 =?utf-8?B?SjhnU2xRSWVXZ1RnM09IeGgxbnJZdWtPMXY2cDY2bTIzNm5mSnBJSXg2VlNj?=
 =?utf-8?B?a2F4bU1PUVN0cmNubjQwaDJVOVFoam5xZGk0RjE2Z2YyNjlUM1dSeGZNeWZN?=
 =?utf-8?B?NWJyRHliQTE5eUlNLzFlUEZqM3QzbTJpUUw4NVdCd0hYVWVHRmlyUmZ4QW50?=
 =?utf-8?B?RG9OcWZRSG45dXNsTFN6aEt0ZklLTTNDa2RDRzJzOFEzNk5zZzFlTDFEL1cy?=
 =?utf-8?B?TU0xblFJdjZzRzdlaUdqYlZaeThmb3NKekFiMjIzMnkzOUpFNnFiZzNvQ3hT?=
 =?utf-8?B?TzBybStOUTFnN2hvRDFaTTd2T1RlaVU0SXN6cHFNYmgxVlN1VlByZUd6ZTVG?=
 =?utf-8?B?VHFRYUlUVzJvcDRxWWpSOXRqRENoY0JsamZYVE5KNkhNMjl1TjAvUmUxMlpJ?=
 =?utf-8?B?NUszMkVKNnVjamhkWVdXYkY0TzRieXYvSjRTK0hXODVVQUdnWDFUbkkzSGlq?=
 =?utf-8?B?T244eWtseHFBVnFrY2Fid2N1clZSc0RpYlU3MDltbFdHdDdkTFFGR29JQmtT?=
 =?utf-8?B?SGpjemRuZnhPWjJ5L085N1huOVhkSCtyMng4WjlWalZaemJ1eDAzS0pOS2g3?=
 =?utf-8?B?a1BYbnZ2WVRuYTZpNk1kdDd5eG12Zi8zR1IyMEJXM3dabkw3aTk1MDhWS2pR?=
 =?utf-8?B?Z0VLcnpYVDdVcVIyY2FRWFFMT3NwNFdSN3ZwSE1lK05BckVZRDdBclhGTEF6?=
 =?utf-8?B?YnIxc0tFSk5haEVFRWdBQmpFOEVabUx4K0M2T1EvZEx6YmJDZDBJVlF1cDFE?=
 =?utf-8?B?VmVGaEpXcXByTStvd1lJUFRoZmpxVFE4aFF6WVBTaW5uc1M4MDVWR0JybW5m?=
 =?utf-8?B?QmgwS3RLY1V5emM3K3AzZ1FsWHJyMXZsVnRPUkNzTUU3eDBXSzRqWWdudmpS?=
 =?utf-8?B?ZUlGN3pDV2Jnb2VIN2d1clpMRnJHTGcwSWJVWFR3S25GOXJvbWtYRnVGMm41?=
 =?utf-8?B?NnFpei9CTlA1Mld2MjJacHhOV1MveDZSalhUS3FTUHFPRTlvTUY5TUpIUzhC?=
 =?utf-8?B?QnZOeG5nOVF6WEtNQWVLbnNwcWhKMkZQMkpVbWF2S3dVbk84bVhYR3JjYXVq?=
 =?utf-8?B?N2JCYXlvV1IwRU9sSkRRcGV1bmhjKzIzckNtYmg5ZW45NHlHRXJRNXNXS1lF?=
 =?utf-8?B?N0FUVHdvMW1ZbkxUTWNRM1FPWUpBL25yeTQ0V2NVR2VaZ3d1SXp2dmFEdFdI?=
 =?utf-8?B?RDFsa2tYTmlKYzRDdkpEV2RnSnJZU2haTVQvekZyMXA5V2h2VlFwV29Yd0pu?=
 =?utf-8?B?ZHY3MkhSMnl6ZU5xNUEweU9Zb0ZvUjMxMmZJQnRuT2ZtN2UwdEZXNjhJZUtB?=
 =?utf-8?B?V2RMT2owcVdUd25zNjJ0S3hxRU1hZnhuWlM0SHB5bFpVcjNBMjJKcE5CM2Qv?=
 =?utf-8?B?MkszZjBCcXZmQWRaYk8vMnVhU3NLMDFPUXFCMTR3QmtVdjJta2lrVWhXZENr?=
 =?utf-8?B?c0lNWkJzV0FrcGVmS0ZXMEFzN0o1U3NKRlpYVFAyK0JNbVdLT1lLY0JYRzZE?=
 =?utf-8?B?TTBUWFF3aWtEZEM4RDZoVkVPYTNUMkgwem5sTGFlNHlMOGZBWjFUcFlIdjNx?=
 =?utf-8?B?Y2NKSjM1anpzVFhtUUdJMVNQNWQvZWFvTTVycVlLbytIMWtYNjlFYVB6MDJK?=
 =?utf-8?B?cFdUWVVGY3YyYzh0SVM2dTBvTW9IMVhpNlB0Q1R0THNudG5BbkZHbVkrUXhM?=
 =?utf-8?Q?VCay4JGbAqlT1AagRA+7yx0HZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E218464C23B1094989D58355EA158D35@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a833a4-eda9-4c06-8927-08dbbfcfc59a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 03:05:29.7168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UsyxLtLRmW3j9HHvU4Pl8IfXAWLzzVW5pA34wZRJrpgcDV7RK0LznEPK05PSSP0IrWCWq7tO06VA1cWyyCr3hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5498
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMDktMTEgYXQgMTU6NDIgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFBhZGRpbmcgaXMgYSBuZXcgZGlzcGxheSBtb2R1bGUg
b24gTVQ4MTg4LCBpdCBwcm92aWRlcyBhYmlsaXR5DQo+IHRvIGFkZCBwaXhlbHMgdG8gd2lkdGgg
YW5kIGhlaWdodCBvZiBhIGxheWVyIHdpdGggc3BlY2lmaWVkIGNvbG9ycy4NCj4gDQo+IER1ZSB0
byBoYXJkd2FyZSBkZXNpZ24sIE1peGVyIGluIFZET1NZUzEgcmVxdWlyZXMgd2lkdGggb2YgYSBs
YXllcg0KPiB0byBiZSAyLXBpeGVsLWFsaWduLCBvciA0LXBpeGVsLWFsaWduIHdoZW4gRVRIRFIg
aXMgZW5hYmxlZCwNCj4gd2UgbmVlZCBQYWRkaW5nIHRvIGRlYWwgd2l0aCBvZGQgd2lkdGguDQo+
IA0KPiBQbGVhc2Ugbm90aWNlIHRoYXQgZXZlbiBpZiB0aGUgUGFkZGluZyBpcyBpbiBieXBhc3Mg
bW9kZSwNCj4gc2V0dGluZ3MgaW4gcmVnaXN0ZXIgbXVzdCBiZSBjbGVhcmVkIHRvIDAsDQo+IG9y
IHVuZGVmaW5lZCBiZWhhdmlvcnMgY291bGQgaGFwcGVuLg0KDQpZb3UganVzdCBzZXQgcGFkZGlu
ZyB0byBieXBhc3MgbW9kZSBhbmQgbm90IGNsZWFyIHNldHRpbmdzIHRvIDAuIEFueQ0KdGhpbmcg
d3Jvbmc/DQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGll
biBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgfCAgIDMgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9kcnYuaCB8ICAgMyArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kcnYuYyAgfCAgIDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZHJ2LmggIHwgICAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3Bh
ZGRpbmcuYyAgfCAxMzYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICA1IGZpbGVzIGNo
YW5nZWQsIDE0MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGFkZGluZy5jDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlDQo+IGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL01ha2VmaWxlDQo+IGluZGV4IGQ0ZDE5M2Y2MDI3MS4uNWU0NDM2NDAz
YjhkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlDQo+IEBAIC0xNiw3ICsxNiw4
IEBAIG1lZGlhdGVrLWRybS15IDo9IG10a19kaXNwX2FhbC5vIFwNCj4gIAkJICBtdGtfZHNpLm8g
XA0KPiAgCQkgIG10a19kcGkubyBcDQo+ICAJCSAgbXRrX2V0aGRyLm8gXA0KPiAtCQkgIG10a19t
ZHBfcmRtYS5vDQo+ICsJCSAgbXRrX21kcF9yZG1hLm8gXA0KPiArCQkgIG10a19wYWRkaW5nLm8N
Cj4gDQo+ICBvYmotJChDT05GSUdfRFJNX01FRElBVEVLKSArPSBtZWRpYXRlay1kcm0ubw0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBpbmRleCAyMjU0
MDM4NTE5ZTEuLmY5ZmRiMTI2OGFhNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9kcnYuaA0KPiBAQCAtMTU3LDQgKzE1Nyw3IEBAIHZvaWQgbXRrX21kcF9yZG1hX2Nv
bmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHN0cnVjdCBtdGtfbWRwX3JkbWFfY2ZnICpjZmcs
DQo+ICBjb25zdCB1MzIgKm10a19tZHBfcmRtYV9nZXRfZm9ybWF0cyhzdHJ1Y3QgZGV2aWNlICpk
ZXYpOw0KPiAgc2l6ZV90IG10a19tZHBfcmRtYV9nZXRfbnVtX2Zvcm1hdHMoc3RydWN0IGRldmlj
ZSAqZGV2KTsNCj4gDQo+ICtpbnQgbXRrX3BhZGRpbmdfY2xrX2VuYWJsZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpOw0KPiArdm9pZCBtdGtfcGFkZGluZ19jbGtfZGlzYWJsZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpOw0KPiArdm9pZCBtdGtfcGFkZGluZ19jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1
Y3QgY21kcV9wa3QNCj4gKmNtZHFfcGt0KTsNCj4gICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBpbmRleCA5MzU1MmQ3NmI2ZTcuLmNkZTY5ZjM5YTA2
NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gQEAgLTk3
Myw2ICs5NzMsNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciAqIGNvbnN0DQo+IG10
a19kcm1fZHJpdmVyc1tdID0gew0KPiAgCSZtdGtfZHNpX2RyaXZlciwNCj4gIAkmbXRrX2V0aGRy
X2RyaXZlciwNCj4gIAkmbXRrX21kcF9yZG1hX2RyaXZlciwNCj4gKwkmbXRrX3BhZGRpbmdfZHJp
dmVyLA0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgaW50IF9faW5pdCBtdGtfZHJtX2luaXQodm9pZCkN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oDQo+
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmgNCj4gaW5kZXggZWIyZmQ0
NTk0MWYwLi41NjJmMmRiNDdhZGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2Rydi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2Rydi5oDQo+IEBAIC02NCw1ICs2NCw1IEBAIGV4dGVybiBzdHJ1Y3QgcGxhdGZvcm1fZHJp
dmVyIG10a19kcGlfZHJpdmVyOw0KPiAgZXh0ZXJuIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXRr
X2RzaV9kcml2ZXI7DQo+ICBleHRlcm4gc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfZXRoZHJf
ZHJpdmVyOw0KPiAgZXh0ZXJuIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXRrX21kcF9yZG1hX2Ry
aXZlcjsNCj4gLQ0KPiArZXh0ZXJuIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXRrX3BhZGRpbmdf
ZHJpdmVyOw0KPiAgI2VuZGlmIC8qIE1US19EUk1fRFJWX0ggKi8NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGFkZGluZy5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19wYWRkaW5nLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5iYmI5YzVlMjg2Y2UNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BhZGRpbmcuYw0KPiBAQCAtMCwwICsxLDEzNiBAQA0K
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiArLyoNCj4gKyAq
IENvcHlyaWdodCAoYykgMjAyMyBNZWRpYVRlayBJbmMuDQo+ICsgKi8NCj4gKw0KPiArI2luY2x1
ZGUgPGxpbnV4L2Nsay5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2NvbXBvbmVudC5oPg0KPiArI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0K
PiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L3BtX3J1bnRpbWUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aD4NCj4gKw0KPiArI2luY2x1ZGUgIm10a19kaXNwX2Rydi5oIg0KPiArI2luY2x1ZGUgIm10a19k
cm1fY3J0Yy5oIg0KPiArI2luY2x1ZGUgIm10a19kcm1fZGRwX2NvbXAuaCINCj4gKw0KPiArLyoq
DQo+ICsgKiBzdHJ1Y3QgbXRrX3BhZGRpbmcgLSBiYXNpYyBpbmZvcm1hdGlvbiBvZiBQYWRkaW5n
DQo+ICsgKiBAY2xrOiBDbG9jayBvZiB0aGUgbW9kdWxlDQo+ICsgKiBAcmVnczogVmlydHVhbCBh
ZGRyZXNzIG9mIHRoZSBQYWRkaW5nIGZvciBDUFUgdG8gYWNjZXNzDQo+ICsgKiBAY21kcV9yZWc6
IENNRFEgc2V0dGluZyBvZiB0aGUgUGFkZGluZw0KPiArICoNCj4gKyAqIEV2ZXJ5IFBhZGRpbmcg
c2hvdWxkIGhhdmUgZGlmZmVyZW50IGNsb2NrIHNvdXJjZSwgcmVnaXN0ZXIgYmFzZSwNCj4gYW5k
DQo+ICsgKiBDTURRIHNldHRpbmdzLCB3ZSBzdG9yZWQgdGhlc2UgZGlmZmVyZW5jZXMgYWxsIHRv
Z2V0aGVyLg0KPiArICovDQo+ICtzdHJ1Y3QgbXRrX3BhZGRpbmcgew0KPiArCXN0cnVjdCBjbGsJ
CSpjbGs7DQo+ICsJdm9pZCBfX2lvbWVtCQkqcmVnczsNCj4gKwlzdHJ1Y3QgY21kcV9jbGllbnRf
cmVnCWNtZHFfcmVnOw0KPiArfTsNCj4gKw0KPiAraW50IG10a19wYWRkaW5nX2Nsa19lbmFibGUo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfcGFkZGluZyAqcGFkZGlu
ZyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJcmV0dXJuIGNsa19wcmVwYXJlX2Vu
YWJsZShwYWRkaW5nLT5jbGspOw0KPiArfQ0KPiArDQo+ICt2b2lkIG10a19wYWRkaW5nX2Nsa19k
aXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX3BhZGRpbmcg
KnBhZGRpbmcgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShwYWRkaW5nLT5jbGspOw0KPiArfQ0KPiArDQo+ICt2b2lkIG10a19wYWRkaW5nX2Nv
bmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBjbWRxX3BrdA0KPiAqY21kcV9wa3QpDQo+
ICt7DQo+ICsJc3RydWN0IG10a19wYWRkaW5nICpwYWRkaW5nID0gZGV2X2dldF9kcnZkYXRhKGRl
dik7DQo+ICsNCj4gKwkvKiBieXBhc3MgcGFkZGluZyAqLw0KPiArCW10a19kZHBfd3JpdGVfbWFz
ayhjbWRxX3BrdCwgR0VOTUFTSygxLCAwKSwgJnBhZGRpbmctPmNtZHFfcmVnLCANCj4gcGFkZGlu
Zy0+cmVncywgMCwNCj4gKwkJCSAgIEdFTk1BU0soMSwgMCkpOw0KPiArfQ0KPiArDQo+ICtzdGF0
aWMgaW50IG10a19wYWRkaW5nX2JpbmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNl
DQo+ICptYXN0ZXIsIHZvaWQgKmRhdGEpDQo+ICt7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyB2b2lkIG10a19wYWRkaW5nX3VuYmluZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdCBkZXZpY2UNCj4gKm1hc3Rlciwgdm9pZCAqZGF0YSkNCj4gK3sNCj4gK30NCj4gKw0KPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBjb21wb25lbnRfb3BzIG10a19wYWRkaW5nX2NvbXBvbmVudF9v
cHMgPSB7DQo+ICsJLmJpbmQJPSBtdGtfcGFkZGluZ19iaW5kLA0KPiArCS51bmJpbmQgPSBtdGtf
cGFkZGluZ191bmJpbmQsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgaW50IG10a19wYWRkaW5nX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICt7DQo+ICsJc3RydWN0IGRldmlj
ZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gKwlzdHJ1Y3QgbXRrX3BhZGRpbmcgKnByaXY7DQo+ICsJ
c3RydWN0IHJlc291cmNlICpyZXM7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXByaXYgPSBkZXZt
X2t6YWxsb2MoZGV2LCBzaXplb2YoKnByaXYpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIXByaXYp
DQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJcHJpdi0+Y2xrID0gZGV2bV9jbGtfZ2V0
KGRldiwgTlVMTCk7DQo+ICsJaWYgKElTX0VSUihwcml2LT5jbGspKSB7DQo+ICsJCWRldl9lcnIo
ZGV2LCAiZmFpbGVkIHRvIGdldCBjbGtcbiIpOw0KPiArCQlyZXR1cm4gUFRSX0VSUihwcml2LT5j
bGspOw0KPiArCX0NCj4gKw0KPiArCXByaXYtPnJlZ3MgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRf
aW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLA0KPiAmcmVzKTsNCj4gKwlpZiAoSVNfRVJSKHByaXYt
PnJlZ3MpKSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGRvIGlvcmVtYXBcbiIpOw0K
PiArCQlyZXR1cm4gUFRSX0VSUihwcml2LT5yZWdzKTsNCj4gKwl9DQo+ICsNCj4gKyNpZiBJU19S
RUFDSEFCTEUoQ09ORklHX01US19DTURRKQ0KPiArCXJldCA9IGNtZHFfZGV2X2dldF9jbGllbnRf
cmVnKGRldiwgJnByaXYtPmNtZHFfcmVnLCAwKTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIGdldCBnY2UgY2xpZW50IHJlZ1xuIik7DQo+ICsJCXJldHVybiBy
ZXQ7DQo+ICsJfQ0KPiArI2VuZGlmDQo+ICsNCj4gKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2
LCBwcml2KTsNCj4gKw0KPiArCXJldCA9IGRldm1fcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4g
KwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJcmV0ID0gY29tcG9uZW50X2Fk
ZChkZXYsICZtdGtfcGFkZGluZ19jb21wb25lbnRfb3BzKTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJ
CXBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOw0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYs
IHJldCwgImZhaWxlZCB0byBhZGQNCj4gY29tcG9uZW50XG4iKTsNCj4gKwl9DQo+ICsNCj4gKwly
ZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBtdGtfcGFkZGluZ19yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3sNCj4gKwljb21wb25lbnRfZGVsKCZwZGV2
LT5kZXYsICZtdGtfcGFkZGluZ19jb21wb25lbnRfb3BzKTsNCj4gKwlyZXR1cm4gMDsNCj4gK30N
Cj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX3BhZGRpbmdfZHJp
dmVyX2R0X21hdGNoW10gPSB7DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgt
cGFkZGluZyIgfSwNCj4gKwl7IC8qIHNlbnRpbmVsICovIH0NCj4gK307DQo+ICtNT0RVTEVfREVW
SUNFX1RBQkxFKG9mLCBtdGtfcGFkZGluZ19kcml2ZXJfZHRfbWF0Y2gpOw0KPiArDQo+ICtzdHJ1
Y3QgcGxhdGZvcm1fZHJpdmVyIG10a19wYWRkaW5nX2RyaXZlciA9IHsNCj4gKwkucHJvYmUJCT0g
bXRrX3BhZGRpbmdfcHJvYmUsDQo+ICsJLnJlbW92ZQkJPSBtdGtfcGFkZGluZ19yZW1vdmUsDQo+
ICsJLmRyaXZlcgkJPSB7DQo+ICsJCS5uYW1lCT0gIm1lZGlhdGVrLXBhZGRpbmciLA0KPiArCQku
b3duZXIJPSBUSElTX01PRFVMRSwNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gbXRrX3BhZGRpbmdf
ZHJpdmVyX2R0X21hdGNoLA0KPiArCX0sDQo+ICt9Ow0KPiAtLQ0KPiAyLjE4LjANCj4gDQo=
