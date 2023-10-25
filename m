Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4F27D677D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjJYJui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjJYJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:50:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8599B4;
        Wed, 25 Oct 2023 02:50:21 -0700 (PDT)
X-UUID: e5d3ca7a731b11ee8051498923ad61e6-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YOVEoRbRz6Fg1oCC8cKTOW+ZX3zMMFKl2Sb2o0ZNxDc=;
        b=GbpGRAmDOfp5xurMxblKds9bCAL+RgMhY85fKIDRX1xzePdlWMDp/EHjrQNyVmFUYD1FFadKR4Vek6jUvZXIH+t0R86VeUzUSHp+ejzpGXKAloLotwl1VjHK/bjmp4oSCWck+QC6cnkJGWIqfB5IVTDJmpP3+SxNI4IuMam/ZVw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:301360cc-3c1b-4949-a312-a3b4e66e95e4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:ac8a4dd7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e5d3ca7a731b11ee8051498923ad61e6-20231025
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yu-chang.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 937342645; Wed, 25 Oct 2023 17:50:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 17:50:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 17:50:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVuuVWIFBiSXSw62CALEizPJlsrxtcMmNufbqtOlg7D+U3fiVX9aRvhd5PNVhtKUJ5ycQdDb1oLL3IwuaCr8bLael+QBA3kB8B+XIZKHCriFJdXiUle3bHlJlRDJ1Qh9l9yD6Rvb0OgOb7Kl7fGXRbUKnEY04zToGePN05ifieItL+F3t/E63ugLr1eX+bAlcKw1SqAXqFHakFnM01CP2vfm/eXo8JZl8si+i34WtRCCC7uIT9PptchAhZo47GU+Dsntz0/aLMgsj2x4br4n8mMakHEFAaY2iAnJeoLe/jtkqDA3tGhIx5wenrIyU6vHD7HBanz8BtBmfCY4DYDEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOVEoRbRz6Fg1oCC8cKTOW+ZX3zMMFKl2Sb2o0ZNxDc=;
 b=h67fBDzFa7Ly3lr0oS31WNpZ+TgHwSADyjW7N3PWKYkmQJVkh3M+7I8G204T472oUu7X5boHokUL337SerlATYq9wlasJnuaycGgHly2zbqh5JDEgVyzHBdOj6o8izFnBLbdR1t140xr9e2GTeCwr6xdjPQsRRBKC3Lro1Y5Xh7+hgemumpGA60VC7k4ZK5cklBuNzPuxstmm8MLIptMQZTgWTe87eReET6NykGIGxPpMQYApaVlMu5jJ1mOkYLLoHiT929FdTmLRT5rMts6Z+7QrSeo2qVwdhxw64wGg0AAU35Q1xDg99Bt1Xq5F54Y/OxQAgwRtILdoOWs9GNk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOVEoRbRz6Fg1oCC8cKTOW+ZX3zMMFKl2Sb2o0ZNxDc=;
 b=W4lU4CqjjglZq/fS32QTTcoIbW5p4waOQMIVm9/Dk/sbkJ2ZXw9CBHw6YvqtBnKtccCyfOI1PEhvuNQJeaOKA5fURTh/3NCbcX9+ocJNxvCWcUxxdL2+YtKIZE/2OT+AiV/bI90G++6ZulaFwnwl2C1plgdSOhpG66qxHNIO12c=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by KL1PR03MB7765.apcprd03.prod.outlook.com (2603:1096:820:ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 09:50:12 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::eae7:2692:e6a8:e278]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::eae7:2692:e6a8:e278%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 09:50:12 +0000
From:   =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent
 to infra
Thread-Topic: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent
 to infra
Thread-Index: AQHaBaaHQyCeGVCVIkaRHyl/V0yhJrBSGxiAgAYj9oCAAAG2gIAAUHkAgAAaCYCAAZq1AA==
Date:   Wed, 25 Oct 2023 09:50:11 +0000
Message-ID: <e049985de9da9958ba425824ab5f38c7cf41025b.camel@mediatek.com>
References: <20231019124914.13545-1-angelogioacchino.delregno@collabora.com>
         <CAGXv+5H0rUajeU-i8nYyV2xWFQTnzqxioZCCyyP_RZXKqmcugQ@mail.gmail.com>
         <283d18028590d57025e5654d18b8b5b7.sboyd@kernel.org>
         <CAGXv+5EpBLnXVdxnk9wBZi5F7U5wdJRfYH7fgg4Lkr1HJXm+WA@mail.gmail.com>
         <9c1e10b56db315e03daa3df5918cde844297c680.camel@mediatek.com>
         <CAGXv+5HQ2sVx=F3my2jOGMw3j3pU2aarEg+Dj1XgNzwio98ezA@mail.gmail.com>
In-Reply-To: <CAGXv+5HQ2sVx=F3my2jOGMw3j3pU2aarEg+Dj1XgNzwio98ezA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|KL1PR03MB7765:EE_
x-ms-office365-filtering-correlation-id: eb9fadcd-f318-44e4-c4ba-08dbd53fc81e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bPYjnxMh68aEzlDsWjEgO4CBPIgioZrRBPxnPdOyARTpG5lS9v2wjpvWu6mePgj/lkxYhne3t00ARqNRrZ00SsRAXx2niK1p/qYZMNs/sQ2mDw7zMGwbyjGDs27GBskLzzQtOmASjJ+D3vHeRePoIC37xIZu72Ro6iOMOkrgNh9FlkNKAq/9+eYQ7sWC1b43i4MV+RHCnb7V9JNIwiOlYEO3mNIDZWh/o4IxHPIQ42OXKbK744yeiIVbCbO66FP+nihd5Xk5Gl+fqiajMeaUETsKiLy5ExUA5iIDL68euQAUNyiAOIBn+3jxJs1AWj67htJ1Tpe/tSQcjDeuhjqYMxuYuIvnaGfmwW0H8lklQ2tWPnSNHcDsNExqtqTnxgzPciFHNwh/iRw7sIXZemFlpJCvrTfddzNkDEt9CTb+e1kd+KW1I377L+BDx0ceyfp8+RQJ+l8lB5rS1LGGed5jedCHXenP2cSN7C84I0Ca4JNexnB9PceeuMtpdnjkluct3NYjscOI24sq9fJtb7KxBT3oraJplV9u5s6xyKndo/WnQhh5n/6RRfdOWtf1nCPoJ83YMwsfiVqCe02MXCccTh8dCMoCI9559RAUMAD+KnLnTMLdrOBskG4og3goYzFVvnjbua7sI8uG6+UYKFl6Q8Ps/UTEhIezdlyDKPpeFE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(38070700009)(2616005)(6486002)(85182001)(26005)(71200400001)(83380400001)(6506007)(36756003)(122000001)(53546011)(6512007)(91956017)(66476007)(316002)(6916009)(54906003)(76116006)(66446008)(64756008)(66946007)(66556008)(86362001)(8936002)(5660300002)(41300700001)(38100700002)(4001150100001)(7416002)(2906002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U05BL1JyMG9CVy9ZaGt2eEVwQjJXbGxoUGlCU3hnVHJBaGcvSHNLempjWERx?=
 =?utf-8?B?d2pSRnlRbHQxQTlFK0U3YjNpNFIzQk9QOHN5MGR3YXpXeFdXTnNjT1FLVWRH?=
 =?utf-8?B?VkUzU0tJT2hKRWpERWFuQjVuK21NRDViU2VnWWNuaWZNN1JDbDZsRC9xa0kz?=
 =?utf-8?B?eG1pcmNMTFA2SngydWVQOCtFbXV6UE9UUW9jK0RzTWFEeEZRMDNUMlkvc2NY?=
 =?utf-8?B?TFBTZVhOR3k5Qll3bTN6YjkwTmo0dWJCdmsxZkZ1NXRqV1g0V2hDS2ExQS93?=
 =?utf-8?B?NGg1U2R4T0pYNDByWjlpYmlLdlMzdEFSMHRIb3hhMHM0bzBNMmQ4aWU0NVli?=
 =?utf-8?B?ZEU5Nk0vY1FqUWVJckxyM3Qwc0dNemwxU0tHUWhuQzVXTkpQLzlucnJDSU1o?=
 =?utf-8?B?NmN3TDFqbjU3c0t0TG9OeEtlVjdoSFVDQkZnYXNxRUpSMkVzTFNCQml3ZU05?=
 =?utf-8?B?b1BXOTM3TE4wNS9HVzQ3MlBGVXc0Z1FFVk1SdDNZdHFtSUlScEZ4cjUvSUEx?=
 =?utf-8?B?YkpPaFhZb2VsRFp0TG1jR0ZPRFcrejhhTE5OYnRMNmdHb1VSSHkrTEQxcnNL?=
 =?utf-8?B?OHUwNmVsSXlyMXNqVEV1Ynlva2dKczdFWi9nMVIxYWpTZVFKUlFNM3lHS3Zh?=
 =?utf-8?B?UE9pR1A1TWtNQ1BGK3ZwclRzZkErR2dqOWJiS0I1MjBKUDZtVGFkKzdtUml6?=
 =?utf-8?B?cEhjV1NvTGFnYlRmcDBsUzhYSTFMcmwrUFVLRUNaVmY2dEFqekhGWVhoYUht?=
 =?utf-8?B?c0RMZ2RZTlRVaHRCdFdXYkovY0hRSTlHWG94NkN6Z1NIT1lnT0JBNk9LYzF5?=
 =?utf-8?B?M05uTzQ5RzV1dXhzcktkRDRuaVY5aEYyd1pKdk1mVlY2L0NweGRhRHRXRlNp?=
 =?utf-8?B?MTJUMW9ucjFoeDV4RG9hM3Bqem9ud09oOXBTRzd4SGZDQlpvTnVKTlBRTnVW?=
 =?utf-8?B?cmlXeHNUVkxmei83NGFMRFhHR1JEZys4b1VUeHN6dTNVTmoycURGWWJieXMz?=
 =?utf-8?B?S2dYRnRZK2EvMENOSzJQdHlLRUdRZ1RCenZ6S0x5cWFNVDRBM01DajFlUlZq?=
 =?utf-8?B?bXZjejFyU0IwOW5qWlUzMklqUmpTdkduVUFYOW9DbldjcUJWUUxpYkQ1K04y?=
 =?utf-8?B?MXY5T0NwdGdXTU1MdStzM05iK1VITnhPU29mZm1zRC9FeFN5RVAvTVozMTFr?=
 =?utf-8?B?U0orY2RNd0xhTGJPdnRRTjNxNEZBaWNjdkZ1ZDFqai91TkgxcUJOaXkrWk1I?=
 =?utf-8?B?dG5USlYycmliaUE1a205UGtTaVZUdENCSmlHY2w3c2w1OUpXS1hySHpqWjR3?=
 =?utf-8?B?OUNhMnoyWE1ydVAweWFJaUlDYWc5Z0RQa1k1bWQzYjRURGtIVUJFbktLZy9U?=
 =?utf-8?B?WEF3VlQ3SGZmRlVsQmlBM1dua0FUUnUzTFNUNWN2Z1M1T0dWRU45N05jSXAy?=
 =?utf-8?B?VVBWSXhiaUg2OWdkUktQaXFOdmhIajU4WTR6UmdmNElEd2NXL25UcTdQZ0tI?=
 =?utf-8?B?QU01alBpUVBNWkVTVFZscUlaTDlKTTBpMFlwSXM4Qnhod1lJc2cxWEY0bnY2?=
 =?utf-8?B?OVdOMlUrb2hsZW5ENDlEZzE0eXNwRDRhUWpRLzJtalVvd3MvY1Roazg1d09W?=
 =?utf-8?B?QU9JMnpOazZLRityNHNTSmUwNnkwbU9HSWRmSXVVcnNwS0ZPSUl4TUxFRHF0?=
 =?utf-8?B?UG1Qek90SzVSMi9CcmZKZkFjamUzZ0g3WVF2czdxT3paOFdUMjFoNEpUQi82?=
 =?utf-8?B?V3VsczdHZ3B5eDVLQXEwczV5VUErVm9weHhIdVI2eVEyZUJSNXNIRjVnTVR1?=
 =?utf-8?B?OXZWdzhKUU1abno2YWZGR2p3ZzlTTDZqM3pMUFJVWjh2R0hDdzI1SU5WZGFP?=
 =?utf-8?B?YStmVnNGc1VZcEVPMDJwWW1QQTVESTZlWnNqcjRNemtWYkZDSjdSVmtoS2wr?=
 =?utf-8?B?aEp0RGRSS2N2cUFQUndzOGk2Tm9Tb2xFemZPRlBNSjhxNlhzRzhlS0ZQVVRz?=
 =?utf-8?B?UnZNUlZ3RVMzSVRoaVF2UU1MQXFjWjJyUmJQbk5naUhKdEF4aWRIdFcrVGVI?=
 =?utf-8?B?aEVCN0ZHYlJvNWpEQng0bUdKUC9wakxsek9BOXd2bXAzT09jNFdnU0xXU0Yw?=
 =?utf-8?B?NGxUcjBObllaNUdCa05ORVBzTG1Nam9INkE4ZWM5MENDNDlLVG9PVUR3eU9i?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <077820EB89B53C409F9E9282E600CCB2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9fadcd-f318-44e4-c4ba-08dbd53fc81e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 09:50:11.9968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xM/HfECQuUWE1/lW3Ddo9PMSuqYRf3XbP1o/f6bJkYN3e6VGTTZVevYUrgkk7OOLr+YeTYKwwY/1+fQw2REiKlhcqRh7EaaeS6rJ00WUVxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7765
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTI0IGF0IDE3OjIwICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgMzo0N+KAr1BNIFl1LWNoYW5n
IExlZSAo5p2O56a555KLKQ0KPiA8WXUtY2hhbmcuTGVlQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBPbiBUdWUsIDIwMjMtMTAtMjQgYXQgMTA6NTggKzA4MDAsIENoZW4tWXUgVHNhaSB3
cm90ZToNCj4gPiA+IE9uIFR1ZSwgT2N0IDI0LCAyMDIzIGF0IDEwOjUy4oCvQU0gU3RlcGhlbiBC
b3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IFF1
b3RpbmcgQ2hlbi1ZdSBUc2FpICgyMDIzLTEwLTE5IDIyOjA2OjM1KQ0KPiA+ID4gPiA+IE9uIFRo
dSwgT2N0IDE5LCAyMDIzIGF0IDg6NDnigK9QTSBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0K
PiA+ID4gPiA+IDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+IHdyb3Rl
Og0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEZpeCB0aGUgcGFyZW50aW5nIG9mIGNsb2NrcyBp
bXBfaWljX3dyYXBfYXBfY2xvY2tfaTJjezQtNn0sIA0KPiBhcw0KPiA+ID4gPiA+ID4gdGhvc2UN
Cj4gPiA+ID4gPiA+IGFyZSBlZmZlY3RpdmVseSBwYXJlbnRlZCB0byBpbmZyYV9hb19pMmN7NC02
fSBhbmQgbm90IHRvDQo+IHRoZQ0KPiA+ID4gPiA+ID4gSTJDX0FQLg0KPiA+ID4gPiA+ID4gVGhp
cyBwZXJtaXRzIHRoZSBjb3JyZWN0IChhbmQgZnVsbCkgZW5hYmxlbWVudCBhbmQNCj4gZGlzYWJs
ZW1lbnQNCj4gPiA+ID4gPiA+IG9mIHRoZQ0KPiA+ID4gPiA+ID4gSTJDNCwgSTJDNSBhbmQgSTJD
NiBidXMgY2xvY2tzLCBzYXRpc2Z5aW5nIHRoZSB3aG9sZSBjbG9jaw0KPiB0cmVlDQo+ID4gPiA+
ID4gPiBvZg0KPiA+ID4gPiA+ID4gdGhvc2UuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQXMg
YW4gZXhhbXBsZSwgd2hlbiByZXF1ZXN0aW5nIHRvIGVuYWJsZQ0KPiA+ID4gPiA+ID4gaW1wX2lp
Y193cmFwX2FwX2Nsb2NrX2kyYzQ6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQmVmb3JlOiBp
bmZyYV9hb19pMmNfYXAgLT4gaW1wX2lpY193cmFwX2FwX2Nsb2NrX2kyYzQNCj4gPiA+ID4gPiA+
IEFmdGVyOiAgaW5mcmFfYW9faTJjX2FwIC0+IGluZnJhX2FvX2kyYzQgLT4NCj4gPiA+ID4gPiA+
IGltcF9paWNfd3JhcF9hcF9jbG9ja19pMmM0DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRml4
ZXM6IDY2Y2QwYjRiMGNlNSAoImNsazogbWVkaWF0ZWs6IEFkZCBNVDgxODYgaW1wIGkyYw0KPiB3
cmFwcGVyDQo+ID4gPiA+ID4gPiBjbG9jayBzdXBwb3J0IikNCj4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiA+ID4gPiA+IGFuZ2Vsb2dp
b2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkn
bSBjdXJpb3VzIGFib3V0IHdoYXQgbGVkIHRvIGRpc2NvdmVyaW5nIHRoaXMgZXJyb3I/DQo+ID4g
PiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSXMgdGhhdCBhbiBhY2tlZC1ieT8NCj4gPiA+DQo+ID4g
PiBNZWRpYVRlayBlbmdpbmVlcnMgYXJlIHNheWluZyB0aGUgb3JpZ2luYWwgY29kZSBhbHJlYWR5
IG1hdGNoZXMNCj4gdGhlDQo+ID4gPiBkb2N1bWVudGF0aW9uIHByb3ZpZGVkIGJ5IHRoZWlyIGhh
cmR3YXJlIGVuZ2luZWVycy4gSSdtIHRyeWluZyB0bw0KPiBnZXQNCj4gPiA+IHRoZW0gdG8gcmVz
cG9uZCBvbiB0aGUgbWFpbGluZyBsaXN0Lg0KPiA+ID4NCj4gPiA+IENoZW5ZdQ0KPiA+ID4NCj4g
PiBBZnRlciBjaGVja2luZyB3aXRoIEkyQyBjbG9jayBoYXJkd2FyZSBkZXNpZ25lciB0aGVyZSBp
cyBubw0KPiA+IGluZnJhX2FvX2kyY3s0LTZ9IGNsb2NrIGdhdGUgaW4gYmV0d2Vlbi4gQW5kIHRo
ZSBjbG9jayBkb2N1bWVudCBhdA0KPiBoYW5kDQo+ID4gYXNsbyBzaG93cyB0aGUgc2FtZSByZXN1
bHQuIEdlbmVyYWxsbHkgc3BlYWtpbmcsIHdlIHdvdWxkIGxpa2UgdG8NCj4ga2VlcA0KPiA+IHN3
IHNldHRpbmcgYWxpZ24gd2l0aCB0aGUgaGFyZHdhcmUgZGVzaWduIGRvY3VtZW50LiBJIHdvdWxk
DQo+IHJlY29tbWFuZA0KPiA+IG5vdCB0byBjaGFuZ2UgdGhpcyBwYXJ0IG9mIGNvZGUsIGJ1dCBl
bmFibGUgaW5mcmFfYW9faTJjezQtNn0gcHJpb3INCj4gdG8NCj4gPiB0aGUgdXNhZ2Ugb2YgaW1w
X2lpY193cmFwX2FwX2Nsb2NrX2kyYyBjbG9jay4NCj4gDQo+IEFyZSBpbmZyYV9hb19pMmN7NC02
fSBhY3R1YWxseSB1c2VkIGJ5IHRoZSBoYXJkd2FyZT8gSWYgc28sIGZvciB3aGF0DQo+IHB1cnBv
c2U/DQoNCkFjY29yZGluZyB0byBoYXJkd2FyZSBkZXNpZ25lciBpdCBzZXJ2ZXJzIG5vIHB1cnBv
c2UuIEp1c3QgYSBsZWdhY3kgb2YNCnByZXZpb3VzIGRlc2lnbi4uLg0KDQo+IElmIGl0IGlzIGFj
dHVhbGx5IG5lZWRlZCBieSB0aGUgaGFyZHdhcmUgYW5kIGl0IGlzIG5vdCBpbiB0aGUNCj4gZXhp
c3RpbmcgcGF0aCwNCj4gdGhlbiBpdCBuZWVkcyB0byBiZSBkZXNjcmliZWQgaW4gdGhlIGRldmlj
ZSB0cmVlIGFuZCBoYW5kbGVkIGJ5IHRoZQ0KPiBkcml2ZXIuDQo+IA0KPiBDaGVuWXUNCg0KQWZ0
ZXIgcmV2aWV3aW5nIGhhcmR3YXJlIGRlc2lnbiBkaWFncmFtLCBoYXJkd2FyZSBkZXNpZ25lciBj
b25jbHVkZXMNCnRoYXQgdGhlIGNsb2NrIHRyZWUgaXMgaW5kZWVkDQoNCnRvcF9pMmMgLT4gaW5m
cmFfYW9faTJjezQtNn0NCnRvcF9pMmMgLT4gaW5mcmFfYW9faTJjX2FwIC0+IGltcF9paWNfd3Jh
cF9hcF9jbG9ja19pMmN7NC02fQ0KDQpzbyBJIHRoaW5rIHdlIHNob3VsZCBrZWVwIHRoaXMgY2xv
Y2sgcmVsYXRpb24gdW5jaGFuZ2VkLg0KDQpUaGFua3MNCll1Q2hhbmcNCg0K
