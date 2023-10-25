Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659477D5F49
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjJYA4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYA4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:56:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F44110D5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:55:56 -0700 (PDT)
X-UUID: 3d19cb7272d111ee8051498923ad61e6-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=951OpLFx3FSDX146CSfQa513oUbl9zfz5hVAC7zk+jc=;
        b=Q2X3nvtQQ+ux0Psd72v5kpBJW+ALvnNG6MFU9F4rWLHSoEYZzKw2GsNU2pvhjciq8OCtNQJOTl79B4v82UGVr8PIXf8xOT6MaN4oCfRNtmFrhcUZP2vJZOzbFwfomfQGGPa3p7M9kPvgJQQnjcxXraqIMyTIFplZfUCDvSHOSbA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2aa96946-46ee-4871-8c4b-a1659634bcfc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:f0efbafb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 3d19cb7272d111ee8051498923ad61e6-20231025
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1603273476; Wed, 25 Oct 2023 08:55:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 08:55:48 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 08:55:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrWY3J7x01JLisBkah1YTZYp21AqV1+BeMUytiCY9jB/BSyBgGPmNIOJP5gFI1MfYp1BOiS7TGQKkLZaIC5UreeKYjopjcXiyXzMvaQxKn50MLM/PINJs+ia6aimozi1jgLwFKOf2Xxb2WnYsdUC47oR/GvnPuy2NOWW+OiW7f8GvMHI/J3CIzdHZGUUOi3rmPWLLFZcRex8Jn8Hu5xarR0X4607AJNJ4oO+Uam/k3zXuUagBx9GKaihHozUhsmslmVBbF87x9dJRo2yW15xh8lubuZQFptEJ941a5daVzNo4GZi+WSsemkGQM1BBCbxgASiAp7kcv47NSJ1omO0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=951OpLFx3FSDX146CSfQa513oUbl9zfz5hVAC7zk+jc=;
 b=VCqiLs3Bdr/KUTVkbzWNkabGY6WURzy4G/AiHHBwhnMyJTErRtwX9I10VdwmzOHI60HtMX0HK43gX+YxREpqpu+gMAGnz9QjQC/6w3yVmnW2DlsbQgExL4XMmiCEoQn9YZdZ22t/k7LQFb1I1RGIjd0NXQaZzM1VXp8aUZQodPJegvhfb72HqBCim1RsYbu1wt38KN739mYS0aRhK5CqalcGQKnyLCdvZzyzhtdn55tyhgClqYCDKnW6lcemapkKAIBqrwiqP/AxgWUQqVQ++1mLJYyBcyRnHlMO87UWPsiXmEb0H7IcnSVzHHUarVnXxZJvp/3dRIzddWRbYnKNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=951OpLFx3FSDX146CSfQa513oUbl9zfz5hVAC7zk+jc=;
 b=RjP5Yiz0vJBJa6isIfBK3pYs1jVk74Z9cebjeAK9ETHcVsytHznYlDACnES0qUqAPZ2TzCK66nlciNIXko1xscIJJl5MTMwpnqLd2xu2wlTkiZtfrvo2moF4c6/qwUMswp/t0dJf521mBnkIprFGR3nbDKm1FNN8Twr9d817KBg=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB7120.apcprd03.prod.outlook.com (2603:1096:101:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 00:55:45 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 00:55:45 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 5/9] soc: mailbox: Add cmdq_pkt_finalize_loop to
 support looping cmd with irq
Thread-Topic: [PATCH v2 5/9] soc: mailbox: Add cmdq_pkt_finalize_loop to
 support looping cmd with irq
Thread-Index: AQHaBWq+z3650JdDFUubOvIB3aGgkrBXIdgAgAKPSQA=
Date:   Wed, 25 Oct 2023 00:55:45 +0000
Message-ID: <6d9c38efc2acb4eeb4c46e1bb9fa89d21e948982.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-6-jason-jh.lin@mediatek.com>
         <e7668af8-f2b4-479b-80a3-2677d180e641@collabora.com>
In-Reply-To: <e7668af8-f2b4-479b-80a3-2677d180e641@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB7120:EE_
x-ms-office365-filtering-correlation-id: c99d99cf-7fca-42ec-4eaa-08dbd4f51ecf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tS8mSjmXDiB0jyJnJKhOPRIuu2jIQAfwg0XtGCSh6wAZvKziEwz1VvwO6bviMrF4raJEF+RDWnM9h0fUxXSdGSj3uCY3e+hruGz13Pt15kXdbEgvRPYxb8qbw7jzVpu124rhvFCu1JL4b3gwuphP3CyPO4hfCiWjDpkagKnqE6LXB1m5seyezK8r97LiCeML1n0YAQh8JrAGb7Rlnimy0E/jPmboy7rpEsa+J00mfxOC5jkWW+nng6hEdLWx89uay7bUbaaxPomhYFyC+x86ffWt/5+UeXFS8/DjptkDPMOCb25Uydr+/zYQ41oYfE8ptJulWFE2GyN184+JCU06hqU/owsR0gTJ/+RmVWvPjZzQlUYfJriaQS0XEhYlfe2N0Y6DFjKsU0JKqFMkV9d4SNsq+n2G7TjzJqBCwpqMcZKtzc+M8nMCDH/rRaBNdvELnrKRhMbUEVah+meOZdL4Zj/SJd0dsO6dD1U7l6UDQJg3V5WjXFwvr4ZLOo7YF2Tuz8ADaY8728XkmryqC76nRUmXbTYv8dXqjpL0oJY2L2WpVJI+3S4jquuCsCsD2HoVOUS1/rEFPArB+cX+bB8rSabgigjZwuQ6lNouH/RlsE8RmT8F+YTgxI/Q9U194q3S/cWwW0Dzq4cOe4rSBmOwtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(2616005)(6506007)(478600001)(6486002)(966005)(71200400001)(83380400001)(26005)(2906002)(15650500001)(4001150100001)(5660300002)(41300700001)(7416002)(66946007)(54906003)(316002)(76116006)(66556008)(64756008)(91956017)(110136005)(66476007)(66446008)(4326008)(8676002)(8936002)(38070700009)(38100700002)(122000001)(36756003)(85182001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU5Oc0h0NktOcVd6aUtvaHRpbnU5U3FKTmdSYWgvWlpzTlNwSnF0V1pseWRF?=
 =?utf-8?B?WVpFa0RTL3Z2NW92a1I4MVo3WlVyWU9YLzFMK21yN2FuQjlZM3dORWdXdkRB?=
 =?utf-8?B?SytDSThEUVVzWm9IblB5RGw3MlFqbmE3OURiRGFtS0QvektiRGpoZ1puMGs2?=
 =?utf-8?B?Nmo5NEVVTVQwYWZmWXZUN0ZXOUZ2QmlWSFA0QjFiVS90c1FSZ3JUQkRzNlVu?=
 =?utf-8?B?SEhiWHRYbk1BbzUvQ0RuTDJtdmprWEFKb0ZHaWVmOWFucVVEMTFuRFRWU0tS?=
 =?utf-8?B?YUhCUXZSZ2dqMVBUMGJyVlBaOC9WcW0vKzdLNFc3YzgySHNRNmxMWC93K0Vk?=
 =?utf-8?B?SDFVMlpVMnZ1Z0RaN1BsMzM5YVZ6dHFyQ1hOb1JwL2lPWktTUXN1N1pQUkw0?=
 =?utf-8?B?YzBmZzV1NzhBb25rVmVKS0VTQzVCTzgyRnVaQXAzeks5b3U1czBQQ2IrK09J?=
 =?utf-8?B?ZVlkUStIYVZTaVBGUHY1TXhld3lMSWZSblBXWXhOeXk2bGNvME1PZVVtMGMy?=
 =?utf-8?B?NDJWZ0hSVE1BZkt6YjRqL0RubXNBajJmKzZmdmsrM3FNV2RaQmIvNW5KTDNF?=
 =?utf-8?B?LzlpUFpRTyt0bG9KRWxuek96cDRWYUFXRFdSRmErV3ZQTm1GTC93dCtBMVN2?=
 =?utf-8?B?eE92UW9QWmdPbjUrcG5kcGltSlNySlpMNWRDTytiV0lWL2FST3pIdmU1ZjBQ?=
 =?utf-8?B?eDVvczdHVzJyRy9hbWRzV3ljNFJBVnZqV3p3SlRuYXdvRWFWenJZQ2xhTFpu?=
 =?utf-8?B?cHlxUFRBRlM1ay9zREQzdG9ManRzV0Y0c25xUmt6NlUyM1U1dXZhU1IyM3Jn?=
 =?utf-8?B?YjJZMi93WktGYkFRREt1SHlPUjFlRHdlODlwdnFPcHltcVFzZ3MrcklWYjQx?=
 =?utf-8?B?V3pveFFSODd4MnJXQnVFbFIrK2NxeEcvSjF3b0dHbFV2SjJ5eFFtcFIyVEZI?=
 =?utf-8?B?dW1sRGlzUlFiRUxJNmtVa29JQ1kvU2NSTUFUSjlxT0VIbklHQWtCN0dyak1V?=
 =?utf-8?B?WGRnUjlPb0l3TzVPeUw4SUZRdXBhT3JMTTgvREtkWUhJYXVPRllrU1B1Qzhz?=
 =?utf-8?B?NEVlb2ZHc2pzR08ra05qRmVjdjVRd0d5cG9rMThONjUvRGdvbmN0L1M0dkM3?=
 =?utf-8?B?QzhPSDJkZy9Nb2drRW9vNmQrcTRxMUVhaGdmemxNcEpTVHp6MWlvc2d4YXN1?=
 =?utf-8?B?YUxCTzB0RjArTk5rSTBCV1lRbU9qT09BVXJ1ZGxMS3ZUcldRcU1VdktVQXFn?=
 =?utf-8?B?ODlndWNvUldSdzdkV0xUK3hITVNaSlpwYit1UVdDZDJ1a1hMRVRiK09ZWXM1?=
 =?utf-8?B?UTlqV0Y1OTAvMmhVV3ZtaG9YMkQvRndMN0F1Mzd5T3BrVkdvOEJBWkExU290?=
 =?utf-8?B?NzV0OFA5MFRzVnZVK0pROS84ek54OGFndXYvMmZsNk8zSkVkekVDb0NZL0t0?=
 =?utf-8?B?UWpFekM4UFVYZTNCY3Q3K1ZEOVV4ajRhQU1PeUM5Vyt4MHQzcTVaNVd6cWh1?=
 =?utf-8?B?OHhRMGJvWjZsNGhOT0xFRld4NURQUjYrejJmOHVUY3ZhTUhncXVpUFAzcS83?=
 =?utf-8?B?YVNrK0ttT3lqRWJpbFg2bUU3WVQ2c0VDWHpVc2VKWXF6REY2elY3Z2ZpMmJ4?=
 =?utf-8?B?SWlERUk2RTcrNUVMbGt5UzJaNjF4ZHU3VWhXT2FMaU1KTUJEWkQ2WmJQNGlZ?=
 =?utf-8?B?ZG9uM2NHd3NRRHVSd2VtVzZydWs5cmJsekgrNlhNbms3UzNZaUNVUEtlNTJT?=
 =?utf-8?B?UXM0NmsyY0FWUFVKWmNTL2pFbk52a3FqZ0FLaE5zeXM0bnM5Qmg2VVZlb1Yz?=
 =?utf-8?B?RHFzOS9mM1FjU2JtTDl5ZVZTemJBeEgwZmhPU1FjclQ4dDZwaWhNUVF4K0ZR?=
 =?utf-8?B?Q1VUSUpqZFhneEpVQlJFbHZhVEJlUU56TExQNDcrOXQzN2NWcWdSeVkrNzhC?=
 =?utf-8?B?a29CKzkvRkhvR0tkMWtGUStoOVNuZXpjZmxrc09vdEw3aVk5LytCLzYxZEdk?=
 =?utf-8?B?R2FXQVRHS0JvT1pqdXZxZVI2V3VEK21nL1prYkwvQy9xVVBySGgwd2U3blE5?=
 =?utf-8?B?TGdLWlZHT25XaGZJSkJFRzdFUVpDM2VCMXRsT2FjVEUxbFRjTDY4aXNEV1Fn?=
 =?utf-8?B?NlJwc3ZQRm10L015YnR1Y2tPcjdnbzhjMnlVTDJBaHR0M2p1eUZHTTY4NVRK?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEDC7B6BA5150B4C9D46257D94F5F7C4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99d99cf-7fca-42ec-4eaa-08dbd4f51ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 00:55:45.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TdjsoeuB7E97nEQ5XdIXXxMtGEa0Jxa8wSA3eiKu7pWeObswz/kCN+qQpHTqvH+Xn17qrpKL3tfdBTDhQkyuv8IWqmdeO8p3+JznXh1T1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7120
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDExOjUwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjMvMTAvMjMgMDY6MzcsIEphc29uLUpILkxpbiBoYSBzY3JpdHRv
Og0KPiA+IEFkZCBjbWRxX3BrdF9maW5hbGl6ZV9sb29wIHRvIENNRFEgZHJpdmVyLg0KPiA+IA0K
PiA+IGNtZHFfcGt0X2ZpbmFsaXplX2xvb3AgYXBwZW5kcyBlbmQgb2YgY29tbWFuZChFT0MpIGlu
c3RydWN0aW9uIGFuZA0KPiA+IGp1bXAgdG8gc3RhcnQgb2YgY29tbWFuZCBidWZmZXIgaW5zdHJ1
Y3Rpb24gdG8gbWFrZSB0aGUgY29tbWFuZA0KPiA+IGJ1ZmZlciBsb29wYWJsZS4NCj4gPiANCj4g
PiBHQ0UgaXJxIG9jY3VycyB3aGVuIEdDRSBleGVjdXRlcyB0byB0aGUgRU9DIGluc3RydWN0aW9u
Lg0KPiA+IENNRFEgY2xpZW50IGNhbiB1c2UgYSBsb29wIGZsYWcgdG8gbWFyayB0aGUgQ01EUSBw
YWNrZXQgYXMgbG9vcGluZw0KPiA+IHBhY2tldC4gSWYgdGhlIENNRFEgcGFja2V0IGlzIGEgbG9v
cHBpbmcgcGFja2V0LCBHQ0UgaXJxIGhhbmRsZXINCj4gPiB3b24ndCBkZWxldGUgdGhlIENNRFEg
dGFzayBhbmQgZGlzYWJsZSB0aGUgR0NFIHRocmVhZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
ICBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jICAgICAgIHwgMTEgKysrKysrKysr
KysNCj4gPiAgIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAyMw0K
PiA+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5oIHwgIDEgKw0KPiA+ICAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaCAgICB8ICA4ICsrKysrKysrDQo+ID4gICA0IGZpbGVzIGNoYW5nZWQsIDQz
IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210
ay1jbWRxLW1haWxib3guYw0KPiA+IGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3gu
Yw0KPiA+IGluZGV4IDRkNjJiMDdjMTQxMS4uNTZmZTAxY2Q5NzMxIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiArKysgYi9kcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IA0KPiBJdCdzIHRydWUgdGhhdCB3aXRob3V0IHRo
ZSBjaGFuZ2VzIGluIHNvYy9tZWRpYXRlayB0aGlzIGlzIG5vdCBkb2luZw0KPiBhbnl0aGluZywg
YnV0DQo+IG1haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIGdvZXMgdGhyb3VnaCBhIGRpZmZlcmVu
dCBtYWludGFpbmVyLi4uDQo+IA0KPiBQbGVhc2Ugc3BsaXQgdGhlIGNoYW5nZXMgdG8gZHJpdmVy
cy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyBhbmQNCj4gaXRzIGhlYWRlciB0byBhDQo+IGRp
ZmZlcmVudCBjb21taXQuDQo+IA0KPiBIaW50Og0KPiAxLiBzb2M6IG1lZGlhdGVrOiBjbWRxOiBB
ZGQgY21kcV9wa3RfZmluYWxpemVfbG9vcCBmb3IgbG9vcGluZyBjbWQNCj4gd2l0aCBpcnENCj4g
Mi4gbWFpbGJveDogbXRrLWNtZHE6IFN1cHBvcnQgR0NFIGxvb3AgcGFja2V0cyBpbiBpbnRlcnJ1
cHQgaGFuZGxlcg0KPiANCg0KVGhhdCdzIHdoYXQgSSBoYXZlIGRvbmUgaW4gdGhlIHByZXZpb3Vz
IHZlcnNpb24uDQpCZWNhdXNlIG9mIEtyenlzenRvZidzIGNvbW1lbnQgaGVyZToNCmh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIzMDkx
ODE5MjIwNC4zMjI2My04LWphc29uLWpoLmxpbkBtZWRpYXRlay5jb20vIzI1NTI3NDUwDQpJIHNx
dWFzaCB0aGVtIHRvZ2V0aGVyLiBJJ20gbm90IHN1cmUgaWYgSSBtaXN1bmRlcnN0b29kIHRoYXQu
DQoNCkJ1dCBJIHRoaW5rIEkgc2hvdWxkIGZvbGxvdyB0aGUgbWFpbnRhaW5lciB3aG8gY2FuIGFw
cGx5IHRoZSBwYXRjaC4NClNvIEknbGwgc3BsaXQgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0K
UmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IFRoYW5rcywNCj4gQW5nZWxvDQo+IA0K
