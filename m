Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260EA78BEE2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjH2G5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjH2G5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:57:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759981A2;
        Mon, 28 Aug 2023 23:57:10 -0700 (PDT)
X-UUID: 442b4040463911ee9cb5633481061a41-20230829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=erVs1O9lkEQHHoqgCbDDewN1pj/ejuQeQbewRyebloQ=;
        b=cM3zMaZXeVxSW/mbjaOndgNwTFFHj0XDCiMmhDh3yNAre+dDvRQs1SlIQ2yOKLy8aiaTH/MehHmqbnqvah31Djjj9n5pbFWnSa/EWEkMBBno63Y57mOZB68EHKOmfXuR3I5B768zm7LAjKPWPFQV5I8Iv+ofEpJ4FtpnDzCnkXQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:8b0a47cc-ed0d-47e9-b59c-ebb17898b095,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:21154e13-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 442b4040463911ee9cb5633481061a41-20230829
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1047744555; Tue, 29 Aug 2023 14:57:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 29 Aug 2023 14:57:05 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Aug 2023 14:57:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlxIkWMg9slvdn0rAaD9lpoenkSlV2XqbuUdLMdYF6RE+7OHvoykCVo83r+nt1U66sJvEFxbjsZYlUveRrlaX+j4G5mWRj+xEWW+JYcE4jsL9cSB2wiZkPyfqa4/tCv3vVPJxj1m5BU5PsKbibR9Ld3QP63zi4z6kL63Dw719CDtP1rQgbjD+wuHl3NaRWaVkNvE4Vhzb1y6zWWOQZME429og+LxqUHxu4NOKwC5pkO5TtVaAuyPOgO3PttTxjIavREJ81aQFgsJ5PSYFYLWUSLttJihd4GG4hCHz5vLO3lAVQnnR+tV6/IDh245n6saFrXnRp8N5p0ZVFMULkTP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erVs1O9lkEQHHoqgCbDDewN1pj/ejuQeQbewRyebloQ=;
 b=Gv8iNb8gBorBN7I7GJosOY0763QQiaDOXSluwaEsXs461oIl5VNyXlpX2f7tmadEiB6VRTCFtOR5j1Oy9JGCN/F+flz0+VrdOPpDYAcAuKUFT7r3TgJx651H/Pa1YfMcnlFq4ifcAzqVA4yIGauNru7rVdu6A8QKv+iMTgo8yLq7/l2wtXE0dCADT0voTVQT457+JDvcLMuZv8VMIkIOqnZ0ad45GitxYKCvp/JUrJFT1jYFlSHtLY6XdKFJS3357Gd4bFdsaUt0iGAUlsof7jv4hZAUbpqMRvvOD52z+6/ygq4xVu3XG16TceMb5VfTSI4X4Xm9BdNdM7qS3usZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erVs1O9lkEQHHoqgCbDDewN1pj/ejuQeQbewRyebloQ=;
 b=bTlJelCe6Ho8JTdXtako+9gZhVqCvXXfH8sNfbSU741tsIv05tCb3YQ6Ol7ck0NHqAmLOaLVX/syxUuBNcIn3NOdU2lTxgXY1uXOc/0ENiUDvj6Yl8j+dfBMzAo38va1PKyVQQ8muxmZ9SGCAJoPEeux4uZMFhsaBQWA4P9P9TY=
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11)
 by SEZPR03MB7776.apcprd03.prod.outlook.com (2603:1096:101:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 06:57:01 +0000
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::699f:9f30:a65b:547d]) by PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::699f:9f30:a65b:547d%5]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 06:57:01 +0000
From:   =?utf-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?= 
        <Chun-Jen.Tseng@mediatek.com>
To:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sumitg@nvidia.com" <sumitg@nvidia.com>,
        "sanjayc@nvidia.com" <sanjayc@nvidia.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] cpufreq: mediatek: change transition delay for MT8186
Thread-Topic: [PATCH] cpufreq: mediatek: change transition delay for MT8186
Thread-Index: AQHZ0Xi9TfPkbDiP9kmQ3+dUnwTXR6//UboAgAGXWAA=
Date:   Tue, 29 Aug 2023 06:57:01 +0000
Message-ID: <86f49ce84f32941185c961da8a5c671e7aed46b1.camel@mediatek.com>
References: <20230818020616.4748-1-chun-jen.tseng@mediatek.com>
         <20230828063904.r7huxclehlblkkjx@vireshk-i7>
In-Reply-To: <20230828063904.r7huxclehlblkkjx@vireshk-i7>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5351:EE_|SEZPR03MB7776:EE_
x-ms-office365-filtering-correlation-id: 0f0931b0-e060-4250-588e-08dba85d2547
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xfRxpONYxPWbHK1LYGpV0jTNlDjxBS8wQRUC5W6Y4YBzaUGVFJbW4RyA+MqGama2+OiP58nxSXHLDnACY1Ufo83hqNqpaB+wVz1rxRscEHuo/iSzD3tnaxO1saVwZeGFC/ee5KSiXvC6SL2CF0tJRglvaODj5Z40hEIKoXHktg/Pboc+2T9OVobi5Sd3rtx/JYVKbDWduJWKPoi1/27o2GzlDWe0q6gUlHOIDd97YBZHDVqroc9/ltPeJUMpIcGXDzFPtN1BWbUEIKCZi5IFx293VsKujP9ew3+KE5osNjW2QtRSxqYsTMfNRxUnMrG0AMcrhLXLy/dh/6o7OS3aBNMdvZZJBkdqa6jqkxkMF4cktiH24DpdP+Fvoy+PiitNymNtd5FNdHmYWt1GwwJQ5xKbA2oWu24k/4IGjDRWfAX64WI0k4hTjkQa+kVlT1LbJlI7sX7LiYisiZGSAVAy+dnzrY2lEb82tMmY5P7PxLYbuKd+UwUr9D/u1ZyLdMGF+ETxQtP9S+d55DVRRTrZ9bckLhcYN/G3hMMVbWY+omzSHoF4UwlhrYhPFanJNOkiEu1i00P+wxBiuYF9dKY2y04aaGyKvMYFEd/wKCpBsyeHlZdgMZMdcJn2De9wd9J2TXJOW0bKM5eGpIJCTOjGxKHa103Y06nNbATJBMrjFrotPox4F795FyUFqNcvzCNc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5351.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(8676002)(4326008)(5660300002)(8936002)(6486002)(53546011)(12101799020)(6506007)(6512007)(71200400001)(26005)(2616005)(83380400001)(122000001)(478600001)(38100700002)(38070700005)(6916009)(316002)(66556008)(66946007)(66476007)(66446008)(91956017)(76116006)(54906003)(64756008)(36756003)(86362001)(2906002)(85182001)(7416002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU9jVjlNZisyb2YvTmJhTUozd3dXd2ppZmQrRVF1ZkNDMDN3MHpoV082ZWNE?=
 =?utf-8?B?RFRrL2F2TGdPWk1JOWw3czFvV2RtUkI4MWNON3VUSUREZ3RqY3hQZmN1SFU1?=
 =?utf-8?B?WFVIMmo3eDZtejRTQm5CSUZqZ2hremdqZzQ4MEhPVUNHR2JYaWMvajM2TDV0?=
 =?utf-8?B?LzhMTnZ2NVFFRFMvOHpESTJhTFFHNkFVSDYrc29EY1Zma2RQc1pzbys3WUky?=
 =?utf-8?B?NWJ3ZkNNMGVLc1FrV3lPWkRoL2JaN25yTDM0djlXM05IdWdLZnBZMDl3YlJk?=
 =?utf-8?B?SnJjVVB0aXVCUHorWWx4VHVqV1EwWjhXdUovMDUyVUhCYnhidEN2RlVGQjFR?=
 =?utf-8?B?QnFXOEpXMDVmNTJUeFlhaXRsWEVoeWJKRE9hdDlkVFEwRi9qRkpKVURMU0lU?=
 =?utf-8?B?ZFN4dlczYUp0cXFrZDBpeHZYcmtsdDFUVHFMeHUyczd0V1p1aVJqTVZsWnBL?=
 =?utf-8?B?N0haWnZzTnlCWWZYMjZ3TmROOHpDc3NxZ2lmUUhRV1o1c3pNalJPY29QMXNa?=
 =?utf-8?B?SHRaVll3WUFkbGFQZ1NWeXlqR2Q0KzB2NXoxajNxRGgzYkNodWRnWlI1aFVn?=
 =?utf-8?B?Umpoei9iUW5uVjYyZUtkUEpicmc2cmNac2U3eWJ2cjFpZmZ5YU1LWit3T3dw?=
 =?utf-8?B?Y2U1TFlFcjhZSGZOc3laRVFxQ0VrYWo4Z1d1aWViQk43UnJGZGdHeTVxcGlI?=
 =?utf-8?B?QktRRE1uNTZjZzUxUHVzcEs3eVl2OHVuUGliYmtNL1F0azg3amFyOWxLU2Vo?=
 =?utf-8?B?UmZ4VEtWT2RpUk1zNnJwK0wxLyt2RXJHakRrMFUxcHRaWURmY21DcU9GY0dI?=
 =?utf-8?B?T3kzNWZtc0ltK2RKN0NjMlFMMTk4TTdNYWRLMnZqTXBPMTFISzlWdzAzVmUx?=
 =?utf-8?B?d1ZFK085TDFBS2VrQi9XSU0xd0svbTJ5blV0UUl5cFJ5MkNyYTJTbTQrcXFh?=
 =?utf-8?B?VmR2NzBpZ3VMV0xPVVVKMjd5TXhKOWZ0UGlEV1h1NnBHREQ5dVpnd3Y1aTNa?=
 =?utf-8?B?TzZ1WTZQV0tmbzAxaWEwV2gzb1l4Z251N2FHUGpESXBubDlTSTl6MHRiMEd4?=
 =?utf-8?B?Y1phQkVYdzZpeHpZU2tibWh1bFdjQVZoUUlaajl6TWpQNEMyaGcrTUlDY1Jq?=
 =?utf-8?B?ckdLcm5ibzlFOXhtanZjU3pqMWF1RGRsanMwZVI0VG5JUnl6bWwvblB3R1Ar?=
 =?utf-8?B?Nmo5SitWVStZSXlrMlN1OXpkWk9ycjR2VmZLVy9qSWJoUGJicTJualN2Vkww?=
 =?utf-8?B?WitqbXZCSGFmbExleS8wVFcwdGkyWWh1TVhOQXBvWGxobVlwOE54R3ltWCsv?=
 =?utf-8?B?aVRpcitLMk02aWxkUGkzWk1wVHQzL0VrWFVJdDUvTzUrZ1FVam82a052NEc0?=
 =?utf-8?B?UXF0S24zWGJweTRNYUhpcXpOOFZibTh4RWNOai9zRENPUlh0ZFF5R2xzajdF?=
 =?utf-8?B?SVVIWnR4RHpFN3plaUNvU1dCcWw3ZnZWVU5aRzg0aHRHUEc5OW0zWE0vbU0v?=
 =?utf-8?B?WkZzNjRLMkNoSkdIelpyeTdSUWJBcTFwcSt2dHAveFNsUFdLZGM4Z1lhUi9y?=
 =?utf-8?B?QnhXQkxYSUtwMUhMVkJSVUFiRlVCdFhmMkE1Si96Q212T1hQWFVUY0ZCdk1Y?=
 =?utf-8?B?anlHYjJvS0Z2WFNvQmFCYkt2UWVreVJGZ2ZEVWVBaFp2QWlQSlF6bUZuRWsv?=
 =?utf-8?B?SW55UWE0czg0WUs2SXBXOXJtTkNQYVJwTTdjZkNvdUdyVExKUkpzMUduK1hF?=
 =?utf-8?B?M2dtQzlWNEh4VUl3T0NvelBtVU51VllvSHlmcGRPVHhZc2s2Qi95TEhSclhK?=
 =?utf-8?B?M2V6anhXQVVNWjQ0REdpYWVCZVJ5M09aQjRYbEczTXdzUDJta3E4NGdaSGdQ?=
 =?utf-8?B?ckNIcmN5ZDBaS2phWFBRWENWanFlWWlmbi9hVCtKOWhvTERjekFpcHN0Z0E4?=
 =?utf-8?B?cWJCalBYV3hxOTYxRk0wSzBjQkJ0Mko0UGV5cDZ4d2tEYXdzSUNRamJhNkhL?=
 =?utf-8?B?OVplVklRZkdqNHBlRFVjZW5JbnRSZUhNN1dkeWZTRERwdDIzMjBlRk1DTVJX?=
 =?utf-8?B?QUpoZi96SUMrRmxIUVRxVDYzU1FTVkJwOGdvV1VNMU1PbWdZMzZ5SndyRWhE?=
 =?utf-8?B?ZnlHTzhvTm95SDkyZUZkZ2VpZlJRdm1xRDRVV2Nsbit2T1BSRWk3aG5iUmcw?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69C2AA27AA7ABD44BFF80DB5C4341C47@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5351.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0931b0-e060-4250-588e-08dba85d2547
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 06:57:01.3655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uepUjDOoHt3kqWtT/3AZ93DzWuVawQv07Rb/nwW83QAJjMA/w6Y+Q+R3XWQf+NhNIn/8/WeQeFn80M260Qnl5oUgp27q9gxn5g+k26/ZBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7776
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTI4IGF0IDEyOjA5ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgSGkgTWFyaywNCj4gDQo+IEkgYW0gbm90IGVudGlyZWx5IGNsZWFyIGJ5
IGZldyB0aGluZ3MgaW4gdGhlIGNvbW1pdCBsb2cuDQo+IA0KPiBPbiAxOC0wOC0yMywgMTA6MDYs
IE1hcmsgVHNlbmcgd3JvdGU6DQo+ID4gRm9yIE1UODE4NiwgaXQgaGFzIHBvbGljeTAgYW5kIHBv
bGljeTYgYnkgZGlmZmVyZW50IGdvdmVybm9yDQo+IHRocmVhZCxzbw0KPiA+IGl0IG1heSBiZSBj
YWxsIGNwdWZyZXEtPnNldF90YXJnZXRfaW5kZXgoKSBieSBkaWZmZXJlbnQgY29yZS4NCj4gDQo+
IFdoeSBkb2VzIHRoaXMgbWF0dGVyID8NCg0KRm9yIE1UODE4NiBzZXQgZnJlcSBtdXN0IEJpZyBD
UFUgLT4gTGl0dGxlIENQVSAtPiBDQ0kgbGlrZSB0aGlzIG9yZGVyDQphbmQgaXQgDQp0YWtlcyAx
MCBtcy4NCg0KQnV0IGluIGNwdWZyZXEgJiBkZXZmcmVxIGZsb3cgLCB3aGVuIEJpZyBDUFUgb3Ig
TGl0dGxlIENQVSBjaGFuZ2UgZnJlcQ0KLCBpdCB3aWxsIGNhbGwNCkNDSSBzZXR0aW5nIGJ5IGRp
ZmZlcmVudCBwb2xpY3kuIEl0IHdpbGwgYmVjb21lIEJpZyBDUFUgLT4gQ0NJIHNldHRpbmcNCm9y
IExpdHRsZSBDUFUgLT4NCkNDSSBzZXR0aW5nLiBIb3dldmVyeSwgSXQgd2lsbCBjYXVzZSBDQ0kg
c2V0dGluZyB0byB3cm9uZyB2YWx1ZSB3aGVuDQpwZXIgMW1zIGNhbGwgZ292ZXJub3INCmFuZCBj
aGFuZ2UgZnJlcS4NCg0KPiA+IEluIGdlbmVyYWwNCj4gPiBjYXNlLCBpdCBtdXN0IGNoZWNrIEJD
UFUsIExDUFUgYW5kIENDSSB0b2dldGhlciB0aGVuIHRha2UgYWJvdXQNCj4gMTBtcy4NCj4gDQo+
IEJDUFUgaXMgQmlnIENQVSA/IExDUFUgaXMgTGl0dGxlIENQVSA/DQoNClllcywgaXQgaXMuDQoN
Cj4gU28gYXJlIHlvdSBzYXlpbmcgdGhhdCBjaGFuZ2luZyB0aGUgZnJlcXVlbmN5IHRha2VzIHJv
dWdobHkgMTAgbXMgZm9yDQo+IE1UODE4NiA/DQo+IA0KPiA+IEF0ZmVyIDQ0Mjk1YWY1MDE5ZiB0
aGlzIHBhdGNoLCBpdCBtYXkgY2FsbCBjcHVmcmVxX291dF9vZl9zeW5jKCkgYnkNCj4gPiBjcHVm
cmVxX3ZlcmlmeV9jdXJyZW50X2ZyZXEoKSBiZWNhdXNlIGN1cnJlbnQgZnJlcXVlbmN5IGlzIGJp
Z2dlcg0KPiA+IHRoYW4gY2xrX2dldF9yYXRlKCkgb3ZlciAxIE1oei4gQnkgdGhlIHNhbWUgdGlt
ZSwgaXQgbWF5IGNhbGwNCj4gDQo+IHMvb3V2ZXIvb3Zlci8NCj4gcy8xTWgvMSBNSHovDQo+IA0K
PiANCj4gPiBjcHVmcmVxLT5zZXRfdGFyZ2V0X2luZGV4KCkgYWdhaW4uDQo+IA0KPiBXaGVyZSB3
YXMgaXQgY2FsbGVkIGZvciB0aGUgZmlyc3QgdGltZSA/DQoNCnRoaXMgcGF0Y2ggKDQ0Mjk1YWY1
MDE5ZikgLCBmaXhlZCBjcHVmcmVxX291dF9vZl9zeW5jKCkgY29uZGl0aW9uIGZyb20NCjEwMDAg
TWh6IHRvIDEgTWh6Lg0KU28sIHdoZW4gY3B1ZnJlcV92ZXJpZnlfY3VycmVudF9mcmVxKCkgY2Fs
bCBjbGtfZ2V0X3JhdGUoKSBvdmVyIDEgTWh6LA0KaXQgbXVzdCB0byBkbyBmcmVxIHN5bmMNCmJ5
IGNwdWZyZXFfb3V0X29mX3N5bmMoKS4gSW4gTVQ4MTg2LCBpdCBvZmZlbiBvdmVyIDEgTWh6IHdo
ZW4gY2FsbA0KY2xrX2dldF9yYXRlKCksIHNvIEkgbW9kaWZ5DQp0cmFuc2l0aW9uIGRlbGF5IGZy
b20gMSBtcyB0byAxMCBtcyBmb3IgbWFrZSBzdXJlIGZyZXEgc2V0dGluZyBkb25lLiANCg0KPiA+
IFNvLCB0aGUgQ0NJIGZyZXEgbWF5IGJlIHRvbyBsb3dlciBmb3INCj4gPiBCQ1BVIGNhdXNlIEJD
UFUga2VybmVsIHBhbmljLg0KPiANCj4gSSBhbSBub3Qgc3VyZSBob3cgYSBsb3cgZnJlcXVlbmN5
IGNhdXNlcyBrZXJuZWwgcGFuaWMgaGVyZS4NCg0KSW4gTVQ4MTg2LCBpZiBDQ0kgZnJlcSBpcyBs
b3dlciB0aGFuIEJpdCBDUFUgZnJlcSA3MCUsIGl0IHdpbGwgY2F1c2VzDQprZXJuZWwgcGFuaWMN
Cm9uIEJpZyBDUFUuDQoNCj4gPiBTbywgaXQgc2hvdWxkIGNoYW5nZSB0aGUgZGVmYXVsdCB0cmFu
c2l0aW9uIGRlbGF5IDFtcyB0byAxMG1zLiBJdA0KPiBjYW4NCj4gPiBwcm9taXNlIHRoZSBuZXh0
IGZyZXEgc2V0dGluZyB0aGVuIGdvdmVybm9yIHRyaWdnZXIgbmV3IGZyZXENCj4gY2hhbmdlLg0K
PiANCj4gVGhlcmUgYXJlIGZldyB0eXBvcyBhcyB3ZWxsIGhlcmUsIHBsZWFzZSBmaXggdGhlbS4N
Cj4gDQo+ID4gRml4ZXM6IDQ0Mjk1YWY1MDE5ZiAoImNwdWZyZXE6IHVzZSBjb3JyZWN0IHVuaXQg
d2hlbiB2ZXJpZnkgY3VyDQo+IGZyZXEiKQ0KPiANCj4gSSB0aGluayB5b3Ugc2hvdWxkIGRyb3Ag
dGhpcy4gVGhlIGlzc3VlIGF0IGhhbmQgbWF5IGJlIHZpc2libGUgbm93DQo+IGFmdGVyIDQ0Mjk1
YWY1MDE5ZiBpcyBhcHBsaWVkLCBidXQgaXQgY2VydGFpbmx5IGRpZG4ndCBjYXVzZSBpdC4NCj4g
DQo+IC0tIA0KPiB2aXJlc2gNCj4gDQo=
