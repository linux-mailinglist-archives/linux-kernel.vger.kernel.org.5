Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292667F702C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjKXJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjKXJl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:41:28 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F91ED7F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:41:27 -0800 (PST)
X-UUID: a0af583e8aad11ee8051498923ad61e6-20231124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=A50PkrkjVm73soEeUS1e+ARTGxBonffrsOLXzqs/Nr4=;
        b=gKfPePmi8kOe0c4WLBc5D9ZY3+VaKZ+Y4FT3ObIWiNbSCfMKpwSvXMyYbdJRLRU19Il0OO8ZMukZnan8Q8U4TwjG830nsvDIas17h7pxlT7P2qnC2O4g86ouDwOTJOeNxFdjKOcjMF0Ug7/WnZc3fJAW4u+LD/vKc1QfYbR5jag=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:8fbef745-c3b8-4d5e-a362-707427bade8c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:72900773-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a0af583e8aad11ee8051498923ad61e6-20231124
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1921472126; Fri, 24 Nov 2023 17:41:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 Nov 2023 17:41:21 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 Nov 2023 17:41:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVlcj+FGBpJHOkGUKiVlcNRrWoQGSZt4QHcA52GiMKT0wl3NzMdmqLcMqn7F8+aK7IcnlR2NL0gWyMe1rws9lfo4erEgMZCYQ8SzQy77mdXzYBw0bYodYYq4M4L/jc+R1f8ZM8o10N5FYdR/zVtmT3T8zSIiJs5FLHoFHwZ3JHrNBDWilgZS424JOkBTeXRp1q94Zo6WpHSMpE+zLS72BWIfR9EsatvIkTVKg9Ct2LRmDBvPT4Fui+Y6Qxbo34qREFwQXYWuH5hhSC7nJO8odFQwsQz4JwXY7YT0lwLdn57PURoCpTUYjonJkpYD3ANXr1qdDz8H1sGFFbZNSaa6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A50PkrkjVm73soEeUS1e+ARTGxBonffrsOLXzqs/Nr4=;
 b=hjd+EdgVsLCcEayoKWjf2r1kAtG+Rqu6EKXfjB+KyQfuc+N/y1XJ3OsOqcbObNXbZoIrDNF1h/tcC4tE2kyelPHzV2h730/NzB2g/xA+Ed4Ch7zvq5dRCDaLUmlMMhsCdxNxpsc2yk+vJsOSCMzP4/eFx8UQblAxxPF5peqb/+gh/Q3zqteVIk0wQlxRd+dA6Y7cTIhBfA7VymW9z+Nym3ZJc0E9FXrz6SMMew3nq4Qqp7IF9FFBVDbAoDa0nqzOKuSP1XY876Na333AwiiWvEuj3Os9f1Ntj/K//wn447erdingIyUOk+VZSwzLIrxfyiIgBWfVTda0kIzHUIO2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A50PkrkjVm73soEeUS1e+ARTGxBonffrsOLXzqs/Nr4=;
 b=fzINResXjSHdGREe+c5Cj2H+m6cdRooOjS1jLsAUshAnNwhAOwS8usQHb6QlCZpgdeenbFGr8xOulc3VSfltULX0pUdrU1OYmc71QBrrLOQKh63lYvXJ5GPGErntzndXhZ8Tk0k5G+rHRvwTSSp+vbPD4wOKMv5OjItXO8m6k+0=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SI2PR03MB5787.apcprd03.prod.outlook.com (2603:1096:4:152::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 09:41:17 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::7a6f:69a8:742c:af8f]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::7a6f:69a8:742c:af8f%4]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 09:41:16 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Topic: [PATCH v3 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Index: AQHaG4D743PBreAULUCc1WIhhpc+hrCEFeKAgAUn2QA=
Date:   Fri, 24 Nov 2023 09:41:16 +0000
Message-ID: <8caf6b3f146850636a7decdedf487e5dc067de18.camel@mediatek.com>
References: <20231120071246.30823-1-shawn.sung@mediatek.com>
         <20231120071246.30823-2-shawn.sung@mediatek.com>
         <e7316d95958f9628186e8768f10f691657ea77a1.camel@mediatek.com>
In-Reply-To: <e7316d95958f9628186e8768f10f691657ea77a1.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SI2PR03MB5787:EE_
x-ms-office365-filtering-correlation-id: e2594ebb-52c3-4f21-e51e-08dbecd1818c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQ3TulTxsmON6IAXyFHdSjCv1Qe4TBsvad37PcUoEDvWFqCEGoIYzRJ0ScEUnTBgJbPKjiJB04DoXGUzswNn01Jt+dzV1ynlPaws050K8b5MNaXyJUVvJp6Gou77MqUgqgQaQpTfD4n8Jf4B79zq7MIWRhYMmwHTZ5wHsMY3HAR5p81cxB93IH1g/jQlwB6DHSzUE2MyGOwJth071yCFk7PnjLf/w3lzJlVuMnEhxMw3wxSCP1myAww6BkE3UsCjuE5QDl5KkePrFpugzszKHsR1u+99gfN0fGYMVxKIEsUow/k7GmernFnuxrk/xb6Jr/kDoCSKmPPOSb1YoJ9umOITT/FEzJb3Xb07tleVyBYGG4HB/rbtcVma7X6p8ZGoB+pAlXjSJbEjUW5Mnza1bPYDxcVT78ZKByVGmPyy+i+lXS6OXUNXthr/JqrLRA8pddqwmH1e5rRuc+uu7tAgImTIW8hrlS7sn+I8AkbhaOJHDJbDdVHCX+6qgcAf6ja2OWqZEOHW+w9IzKPiB/KrZmT/3NPNdF0dbWs60wYWrStzzvml3ZLxfwtjlPbu2DCYYsz/GK8mLfiKMlxovQEZlB4U2b+SQdaDfzMzIOpzB7hzi6MYON951/ynhVcNMv7Zp+/VPswpn4IcpQvUnSbGqpifzn2uBIHJJZvlWEIOUYk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(7416002)(5660300002)(110136005)(2906002)(6486002)(85182001)(4001150100001)(38100700002)(4744005)(76116006)(122000001)(66446008)(316002)(66476007)(64756008)(66556008)(66946007)(54906003)(36756003)(38070700009)(8676002)(8936002)(4326008)(6512007)(2616005)(86362001)(41300700001)(6506007)(83380400001)(26005)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTVJcEZCZGZ3UFltMFVXQkUwblBDb21KS1AxZGxscklEZDNYQTJxcVNtOXh0?=
 =?utf-8?B?d1NIWVlWOXRVdUl5UEFBWlFHdWhBVWhMNzBSdFJLbndORHpLMzZEYXRvNm1y?=
 =?utf-8?B?a0xxRDJvbmEvQXJxbjI2OXhMSnY0V2JNbTVYY2FvYTN2aE0xZVpFdGJrSlls?=
 =?utf-8?B?QzhvTVhRRzJhUkpoeDcrTE5VU0JyaHZJSTQvWmdBbHBGZTJwUzZJME9MNUto?=
 =?utf-8?B?aFBwL3pOUWJDZE1SaThHUnJRWGp1NmpCOG5XMWJ2N1pWcmxEK2pEWjgxeXdq?=
 =?utf-8?B?Z1YvL2x2bWdtandUMTQ1WFN1ZlZIeGhuTWplRUNyaFRvdXNqK0N3NkJnMVhU?=
 =?utf-8?B?SkxxVFF5SXVHQjNWNWVXMWJRZ0d3MUFuVFVFMytLM0gzV1QvSk1rZEtDSnhS?=
 =?utf-8?B?RnNpUlR1MTcyeFVTSzNpSUpXbmZ1REhqNmJIcWhXWmxHcFJ0Q1lHaUZYWHhM?=
 =?utf-8?B?dzRhaDgxTkpYUnJ6MlprQlNpa3JMcW41bFUrcVJxVUdsbFdFNm5mYVZkbWJp?=
 =?utf-8?B?S3RvZ1phaXNNbDRZWXNaczc2dFVrUi83bmw0MkJDTDgyN2JCMmhTdGNYL3Vv?=
 =?utf-8?B?RUxWekRlT0hXdXZvcEZxeXA1U0l4ZTBKcTNVUytEbWgrS05tOXIraHNRSTBL?=
 =?utf-8?B?SjdVcWIrY2tJK1M3b2lSVFhmS29jL3hKUWM2aWNXK0RmNWRzZzFjdmdmOHpQ?=
 =?utf-8?B?L2cvdEt4M3hUZW5nMXZsK2UyYTdoWmZ4dytTYzRwSldHenRqRGtDWmNLSDdS?=
 =?utf-8?B?ajk3Nm9xcUVyU0FnMlExNU93ZUxGekRaZm9SSkQzS1k1Vkh1RkhsaXZpUjln?=
 =?utf-8?B?SU5YY3pGd2FMeVVYUFFLMmx4WnArRVhzanp5Tm9BMVJOM28zYm5kdDZKMnRB?=
 =?utf-8?B?YmxRTnZsRnE1M3JKWkRTNEt1d2lFTEhLaTJMZFpYSXF1Yms1akdhWHVsS3FD?=
 =?utf-8?B?Z3NERzBCYXdkdlhwQnBFM1lWdjBYa1BDVVh2VWF2WHJSM3VVRHlxVW15cnVR?=
 =?utf-8?B?bkJ2TlNlbnRMYk56cmljdDg5bHE1WFZsYjc4MGNkTGlNTVBFMGZqTzhVQzQ5?=
 =?utf-8?B?RzBIbXZ4b3RpU1RYU3ZyKy9OdVZNOXMrZTArZ2JySFArSnZraUx5cldUOHc0?=
 =?utf-8?B?WjZlWHAzUitUd21jeWgyQitzUFcyNVZKM3BXcWxzUlBzZ3Z3N0pzaGZ2SUdO?=
 =?utf-8?B?L0VFU0R3VU9hU1p2c0pqUVRKY3VKUlMrdFN6MkdIZGZDS1NVQ2gxLzhXL3Ja?=
 =?utf-8?B?VlZOWWdXREpxcGh6dno2OGpDeEZOSE1selI0MTJjdFFmN0pFL0k1R0F1YURs?=
 =?utf-8?B?ZFhjV0d6QldYamZNVUg3aHVOS1g0YjAyNHkyU2ZPVWlpb0xVT1VNanJuRXkz?=
 =?utf-8?B?WnZ6bmJiM01BR21xMHk0LzhDcG5ZazU3TG1xLy9rTDJheWVtTUtBRGlMblcr?=
 =?utf-8?B?WTlvSHYwMTFUL0FtczNFcmVYZkx3V3lqZGJEYWxmSHNUc2UvbzVyZ1ZoOUtH?=
 =?utf-8?B?REUxWW9FeVNmaGJ1QU1TKzNoSjd1VCt2b0VvUGFVZ0hoaTRLck5UK1hTUGxp?=
 =?utf-8?B?ajFiNFZLR1F5K2lJdHlQWTdENmJRTnhCZmcyc2tFcWsxOHJBSXVnNzd2MVQx?=
 =?utf-8?B?WWlTWUpIeG9FRDh2NW51eTB5S1Q0SGpnVFF3K09SaWFrekwrWktSeVMzcE8y?=
 =?utf-8?B?RFVoMTlVZFhnY3RwNW9aY3BJQXo2aWtSV2dJYm9zU0kwbTFydHllMHdUNDBL?=
 =?utf-8?B?VEd0bXcxblhqamo3YkRSdDFuNVJLTnVnS1RpWTFjckZ1TXd4RGpjRERScThW?=
 =?utf-8?B?VkEyVUNYNHpHb1NRR0RTUjVDb2NlVElqbTl1Z3A5SFpIajBUK0U2Nk1MVUd6?=
 =?utf-8?B?SHFqcXA1Q0hvTTUyMWVwWEZYNXArdEhmbFczTVhFeTgvdXM3UHdXZTJsOXlE?=
 =?utf-8?B?RUIraEMrdGxCWCtZOHQ2d04xQjgyQ0k0T2s0T2p5aDVMMjZuTmU1L2wrNjdq?=
 =?utf-8?B?K0pSS3BLbmhjdnlvblN5MFBDWUJib0JDWmI2ZnlsV2NodWZtR1dGcVdwaWQz?=
 =?utf-8?B?cUdCZnF4UmlQd3JMRkVDSlJ1UXNlcEQveldXWG1zeUZHMG1BWWFkVjJaRTZB?=
 =?utf-8?B?RmtpT1BBUFJYcXN4L0dtNDdaRmFucmMvN0VRVWlaYTVRNkw1T2daRVJDNFFI?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB893E57F4DA2644A4142A6909565846@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2594ebb-52c3-4f21-e51e-08dbecd1818c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 09:41:16.8726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEuY2XC2fSkQ05zXLV5blTKFEZucUohv/KHFMR/PnknZtmXgESk78bNl7YZCyUa02TpBhk7l1JNUJI79Y93ibw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5787
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAyMy0xMS0yMSBhdCAwMjo1NyArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBIc2lhby1jaGllbjoNCj4gDQo+IE9uIE1vbiwgMjAyMy0xMS0y
MCBhdCAxNToxMiArMDgwMCwgSHNpYW8gQ2hpZW4gU3VuZyB3cm90ZToNCj4gPiBDcmVhdGUgcm90
YXRpb24gcHJvcGVydHkgYWNjb3JkaW5nIHRvIHRoZSBoYXJkd2FyZSBjYXBhYmlsaXR5Lg0KPiA+
IA0KPiA+IEZpeGVzOiA4NGQ4MDU3NTM5ODMgKCJkcm0vbWVkaWF0ZWs6IFN1cHBvcnQgcmVmbGVj
dC15IHBsYW5lDQo+ID4gcm90YXRpb24iKQ0KPiANCj4gSW4gU2VhbiBQYXVsJ3MgcGF0Y2ggKHRo
ZSBwYXRjaCB5b3UgZml4KSwgb3ZsIGRyaXZlciBvbmx5IHN1cHBvcnQNCj4gbXQ4MTI3IGFuZCBt
dDgxNzMsIGFuZCBJIGJlbGlldmUgdGhhdCBTZWFuIGhhcyB0ZXN0ZWQgb24gbXQ4MTczLiBJbg0K
PiB0aGlzIHBhdGNoLCBvbmx5IG10ODE5NSBvdmwgc3VwcG9ydCByb3RhdGlvbiwgd2h5IGRvIHlv
dSBkbyB0aGlzDQo+IG1vZGlmaWNhdGlvbj8gUGxlYXNlIGRlc2NyaWJlIHdoaWNoIFNvQyBpcyB3
cm9uZyBpbiBjb21taXQgbWVzc2FnZSBzbw0KPiBJDQo+IGNvdWxkIGtub3cgaG93IHRoZSBjb2Rl
IHNob3VsZCBiZS4NCg0KVGhhbmtzIGZvciBjaGVja2luZy4gQWNjb3JkaW5nIHRvIHRoZSBjb3Zl
ciBsZXR0ZXIgYnkgU2VhbiwgaGlzIGZpeCB3YXMNCnZlcmlmaWVkIG9uIG10ODE4MywgYnV0IGl0
IHdpbGwgYmUgYXBwbGllZCB0byBhbGwgdGhlIGNoaXBzLiBTaW5jZSBmb3INCm5vdyBPVkwgb24g
YWxsIGNoaXBzIHN1cHBvcnQgc2FtZSByb3RhdGlvbiwgd2lsbCByZW1vdmUgaXQgZnJvbSB0aGUN
CmRyaXZlciBkYXRhIGFuZCByZXR1cm4gcm90YXRpb24gcHJvcGVydHkgZGlyZWN0bHkuDQoNClJl
Z2FyZHMsDQpTaGF3bg0K
