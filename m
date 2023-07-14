Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6B753220
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGNGi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjGNGiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:38:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D412D5F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:38:47 -0700 (PDT)
X-UUID: 12f8c480221111ee9cb5633481061a41-20230714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=arcjXnNJw9gGm7vOEbGZXn/a+hFNQ7vaxDwxWsJ+Yek=;
        b=SnhKkz/L3z5MOssrwu2JkJ81G+n1UlJAD8vi/O++kfTkEVE8lfiiu7pLHt5Y9wa90FuEAsOoOda/G7dhDiP5qwL99cMouggFNZM8dGL10wV84eqLIo4MhWtF6kjtX6XqLUWzz9C5bQ5kkCX19+f1Jtqbyn5jb4jcLp9WSd0stL4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:787e6d5a-8d1b-49ae-9a95-752a4e9379e3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.28,REQID:787e6d5a-8d1b-49ae-9a95-752a4e9379e3,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:176cd25,CLOUDID:9cc99c87-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:23071414384380MLYEI7,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULN
X-UUID: 12f8c480221111ee9cb5633481061a41-20230714
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 936339996; Fri, 14 Jul 2023 14:38:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jul 2023 14:38:41 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jul 2023 14:38:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ff9QITpZOOHIUktayI2SKnePLUICUudAVuWd0PCGUoUwLyYELbCGla9Ho3lF+n/BFRMkwzg8R7KC3VPu/rf1V0UdANwxjjvxf/n/fo9ZUvKsHFq7eiezB+4N1Um3S7xN4FlklJHdJBM5D1u4XZxbzy+lAgj02c5vLEeHTsdHgLmkQaLKCFTFBUL+wkPFrYEGTC8VHS0RIKxn2DjOXqjQadXM1KHFlUmW2UVGgIyy3RiwQIhv56M4+/j7OOHdmarRnJQZ+MLz6ZNbcIwNWr1HQ6ZMoAgd0c5EErMmkmk1wYKFl9fNQQRZLFqYigwjA7urFLScIDWpRMrU+kpafjkmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arcjXnNJw9gGm7vOEbGZXn/a+hFNQ7vaxDwxWsJ+Yek=;
 b=A0k1NL3bmuOqBdvAFNvN81Fl2nGM3JRT9T/8Fe3q5oF46GcGCdsGrP0S5wWq/ZO2kFIt02xPTSsz5qGLlmVKeqxUxgCSoE2OSR06SnQtnyKzwz8WfRqKnzApSOU3e5MA3btR+lBfPEmBhjQSZX9Re5NxbB4M7YwbcjlAhKp82BgxQIiFot4hSnKt8xewoeB+D35XCqADx2ewDZ6yVUT+ZTPd4RaE/uyiNnF1RCQV98foz/3+AxeRrZbXDiTfS0Vi/CS3JDldLD5Yz9/v1ulbvft0wLZ6oJdctlkEgNR1Pe2rygKPDzr8pDQsU/+azb/uMDBZ4/S0DSlG+LGD+9eWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arcjXnNJw9gGm7vOEbGZXn/a+hFNQ7vaxDwxWsJ+Yek=;
 b=CCb3KGm0r4aB80VtuGUlQfy44HzTGf3ZlTgRaCo1Xt+hhjx50l5Vq6OnMEl3O6hI/gcaImy3d+FObA9TSbYYW1Z+z1cvIESSOow0FuRq1iVRUFv6Dly5/csbAx9FWSMoJDEea4Zxm8EzsyzemfEGU0cBqw7tgLZ15VVRvPoaqgY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR0302MB5395.apcprd03.prod.outlook.com (2603:1096:820:35::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 06:38:38 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%7]) with mapi id 15.20.6588.022; Fri, 14 Jul 2023
 06:38:38 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 1/2] drm/mediatek: Fix iommu fault by swapping FBs
 after updating plane state
Thread-Topic: [PATCH v3 1/2] drm/mediatek: Fix iommu fault by swapping FBs
 after updating plane state
Thread-Index: AQHZsxGQzYk8hucAn0qlwzkDBu6yh6+41YEA
Date:   Fri, 14 Jul 2023 06:38:38 +0000
Message-ID: <e546b039ea36bd66b327f6597daf9340419a3306.camel@mediatek.com>
References: <20230710093253.32224-1-jason-jh.lin@mediatek.com>
         <20230710093253.32224-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20230710093253.32224-2-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR0302MB5395:EE_
x-ms-office365-filtering-correlation-id: 74d60bd7-1761-42f4-e691-08db8434f507
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XzzesS1qjHbX7gHHNttLvDDvuF4If7LgDUkgCRW/lb6ZNhkmiZu/U9Q0KcCboES+aRmVxQMO421AqUV73WoAwleJZFELfsc1hYRMB8nKaCV0PjsjMZ9XpIP6RqqDkobPwuPEmZK7/PB1w59uE7IDip6ibv9ZpdnNGtr2KjWENkH67YW0Xgq6rsPXnqqmxaFg8FRnV2V20gTir5fVxrmFGvPhnuv6sHO/gEQJETZ+/c9OERjCZET6SJ79S4iD9HMym8LUUD4EbNNzZUuvQ0QA5J/34Nl6pnZQOtrGmRDpGdWFaPCXHgC865wkpCG2CjwVjAfmws+vUtxWTyJlZWfEoo7khrOixP5BxrLAznk88x+IrwPL2F4U53kYzCXLvETE4CYo02ffr24DZm/GiYI7jIBqpBX3X8ZbM6vaqHym+vjyy5V3hPLyLyBGhHoTT2h/QrbS5xiWwmYgVaZal1FCoKW/u+0ytbQZZOhPUiXv+vBSvLvTikoY2NsoDO0ajuax5H8pS12S9XUu2o8gEQz1mZI+Ic4gdCsggxL59VEMsLumppWSw/77p8eevDye8EQZIli0d4hQ8WOAI+sJEr02rCxz72QoxblIqbXRh2N1tiBf0gIlBR3vuTJ+QDc8NHyRHDIq+ckw91dZKy+FHX4zP5iHOhKz9Aj0Ac7SI1qBEp4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(110136005)(41300700001)(54906003)(66476007)(66446008)(64756008)(76116006)(4326008)(66946007)(66556008)(478600001)(5660300002)(2906002)(8936002)(8676002)(316002)(71200400001)(6486002)(6512007)(86362001)(26005)(6506007)(186003)(83380400001)(38070700005)(36756003)(2616005)(85182001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFVvemhYRWtIN0hFaWtORHFpdzIxYnhleVgwS3lQM2djTFd5QVEraTR2SXNx?=
 =?utf-8?B?bkxyVGVPM0hQcHZmSHIxb3VRWDBIbjJvVVJRYmR4VVRsNzBIUjRrZTAxdkw0?=
 =?utf-8?B?M3ZjMVdNNEJuS2pJczV2MFF1Q0cvWmJML1dDbHc2RXV3Mm13TjRkYUpvaHlz?=
 =?utf-8?B?Rno0Q0dWM1p1SWF5Q0JGS0g1VDR5UjNsNmFpQ1BBUE4zNjd3ZktBRXR4NVpI?=
 =?utf-8?B?NmdadCtEWnpoamJORytwMDE0WTl1K0xRQmVuNzZwK1UxVGxmNWtVTUtOUC81?=
 =?utf-8?B?WGlMWjkvZzc2bHhvZ09XK3BRTjFzTTRtdmd1SkhKU3Z2Vnp2aXVqV1ZxZ2VO?=
 =?utf-8?B?VDNxTlV1VXQzYTlaeWRXOGU1UmhsVjBmNUZWQWxXOUF2VUxMVE9zdkl1anBm?=
 =?utf-8?B?Z1hzeUs5NHNKc3ZiYktMS2NiSmg4c3hRREhDTzZKOFd5WUdOMmtmT0FHNlgy?=
 =?utf-8?B?YTVrcTlHcVc2YWY3UERSeStScnJ6OW0xMzUzeGlWdnVrUlc3eHV5T1JSN0dy?=
 =?utf-8?B?Vi8rK1poSFZENW1aamlDTHRZc0Nxc3hvWFYyU0hHbW9VUnp6SHZXblFtd1NF?=
 =?utf-8?B?alIvcjVXM21RSkJCOVB0MUdTdU5rL2I0aFZsSjc3NWJDYnpyU2c4bzFhWksw?=
 =?utf-8?B?UE0vd0dKK3NEVFhnalZFLzk4dmkxVjFvMTN4R2dDNmFRNzEraHphN1BvT3V1?=
 =?utf-8?B?THRrcngyUmQyM2IrKzNWenZYUW01Ri9QdmVGdGtpekxtVS81Vms2SWNUdmto?=
 =?utf-8?B?dHZ4bFMzSWxnSzFna0JvVVJJcytsblpTbit2ejhKbjhuVnMxOUFRQmY5TzNv?=
 =?utf-8?B?aHdWUFM2Yno0OVBwZ3BNN3V6Rno0V0xqRE1nQ1hQc0xpY2hEbWZyQXh6SXlX?=
 =?utf-8?B?OVhxU2lVYlNoUWJXaEpXUTRleFJPd3RvUEllMklhZ2ZSdVVXZ3A5Vm9wejlv?=
 =?utf-8?B?Yi93YTJRa0s2ZnhhRDNDb2NZYkV3WFhnbUF2WEdOVVVjdDlKVjd5ZGJKZFhp?=
 =?utf-8?B?anVENk1FUmdjUDJzMjJiQXpVeFlkYUNIMkNFTWk5MWlVenRHRzBGME1SUTFF?=
 =?utf-8?B?NWFCN0NuSURmUGg1ZEl4dmF5RG54eHBBRnlLK011cDlUMEtpa1hBYUtvcXp1?=
 =?utf-8?B?N2RFRExvT3hFRFd5U25zNWo4UEFrZkRHRUxFQzRLZ3BYUkM4YXc2ZjZrVHNk?=
 =?utf-8?B?VXpsaTRNMmNKakZBdlY0YU1mRnhjTDl0YVFHb2xsOGxQaithZHRHRmVuNlBR?=
 =?utf-8?B?UXVQYXE4NFlpalZCalFLdnc0S2htM2NLM1RQNThqalJNeENUOTlwbWkvcUZa?=
 =?utf-8?B?bjBHdXJkNmNLZThPcjZ3bkx0R3NlNGhrYWpaOTlxQ1FuSkhPeE5POXVBVkFn?=
 =?utf-8?B?bEMyd0E2TklRVnBCN0NRNDBydHJCaSs0bVYyRnkraEcxRy8rUFg4SFNnTVg2?=
 =?utf-8?B?TElhT3NiQUNRM3hFUTM2cWpqZVR2N2dRYUtId0hHb2NpSG1kY2IwYVV6NmFw?=
 =?utf-8?B?M05NRXJYMzZRaXZHTkx5RkJob2daODVJVU5PMkZReExzRkdVay9RYWhuS0I4?=
 =?utf-8?B?WUpCNnlLTXpLNzhobndWVnY1Wis4ZjYvNG5zeUt4V1Y0U2MwSTM5ZkVnS1pq?=
 =?utf-8?B?dnVkVUZCdk0vVmV1dS9sZHM4QWl4bk5SSjdKR3FWTjNEUlZGdlpkRDNOOW9B?=
 =?utf-8?B?ekluVHgzYjBoUUVERWhJZDgrSGE5TzJmdENyM05uM3dvRlFFWHFrQkZWUjFN?=
 =?utf-8?B?T09Bby9qYjRqQ1VkQ3FKK2pxSUFuUkFOQmlnZTdwcDkreTA4VFczRCtTb0dT?=
 =?utf-8?B?c1MweUEyVTlxZ2hsSmgyU3BQamU2Z2VWekduZnRmMEgvUi9SSVBIUFVQZ09I?=
 =?utf-8?B?OFE3UERkMXk0eXcrVjJ6blBKa3dQZ1dJY1VGMU93eGZFKzRxUHdJSHdYTG8x?=
 =?utf-8?B?NFE0dVAzSXM2NndxaDBySzBxMDZkRk1oOVg3RnVCS2kxcm1pdEtSZnQ1Q2pF?=
 =?utf-8?B?TnoyMy96SUNLVjdTekVham9ack80QjcvcjlCQUR2TUhYV2hDRnNkQ1NXbXNv?=
 =?utf-8?B?SkZSN1BoUzEwdFY0SmdqbXJicmxFQkV0ZFFWS3Bzc2U3VlFEM3U5NVQ0TG84?=
 =?utf-8?Q?vln/930Uxh52ZQ6daLiR+cpGB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2C87DFC06D8A64F8D36B92003C1422B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d60bd7-1761-42f4-e691-08db8434f507
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 06:38:38.6895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2POqcN4r2u1FflXhceRvU79DccxHRLu3zwOQfhdyoP5n0sXdS5y7D/F0l3KZZHyIIBeliOpiv+IhD5PsMDp1Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5395
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjMtMDctMTAgYXQgMTc6MzIgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWNjb3JkaW5nIHRvIHRoZSBjb21tZW50IGluIGRybV9hdG9taWNfaGVs
cGVyX2FzeW5jX2NvbW1pdCgpLA0KPiB3ZSBzaG91bGQgbWFrZSBzdXJlIEZCcyBoYXZlIGJlZW4g
c3dhcHBlZCwgc28gdGhhdCBjbGVhbnVwcyBpbiB0aGUNCj4gbmV3X3N0YXRlIHBlcmZvcm1zIGEg
Y2xlYW51cCBpbiB0aGUgb2xkIEZCLg0KPiANCj4gU28gd2Ugc2hvdWxkIG1vdmUgc3dhcHBpbmcg
RkJzIGFmdGVyIGNhbGxpbmcNCj4gbXRrX3BsYW5lX3VwZGF0ZV9uZXdfc3RhdGUoKSwNCj4gdG8g
YXZvaWQgdXNpbmcgdGhlIG9sZCBGQiB3aGljaCBjb3VsZCBiZSBmcmVlZC4NCg0KUmV2aWV3ZWQt
Ynk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IEZpeGVzOiAxYTY0YTdhZmY4
ZGEgKCJkcm0vbWVkaWF0ZWs6IEZpeCBjdXJzb3IgcGxhbmUgbm8gdXBkYXRlIikNCj4gU2lnbmVk
LW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiBSZXZp
ZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5v
LmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fcGxhbmUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9wbGFuZS5jDQo+IGluZGV4IDMxZjk0MjBhZmY2Zi4uYjFhOTE4ZmZlNDU3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gQEAgLTIxMCw5ICsy
MTAsOSBAQCBzdGF0aWMgdm9pZCBtdGtfcGxhbmVfYXRvbWljX2FzeW5jX3VwZGF0ZShzdHJ1Y3QN
Cj4gZHJtX3BsYW5lICpwbGFuZSwNCj4gIAlwbGFuZS0+c3RhdGUtPnNyY195ID0gbmV3X3N0YXRl
LT5zcmNfeTsNCj4gIAlwbGFuZS0+c3RhdGUtPnNyY19oID0gbmV3X3N0YXRlLT5zcmNfaDsNCj4g
IAlwbGFuZS0+c3RhdGUtPnNyY193ID0gbmV3X3N0YXRlLT5zcmNfdzsNCj4gLQlzd2FwKHBsYW5l
LT5zdGF0ZS0+ZmIsIG5ld19zdGF0ZS0+ZmIpOw0KPiAgDQo+ICAJbXRrX3BsYW5lX3VwZGF0ZV9u
ZXdfc3RhdGUobmV3X3N0YXRlLCBuZXdfcGxhbmVfc3RhdGUpOw0KPiArCXN3YXAocGxhbmUtPnN0
YXRlLT5mYiwgbmV3X3N0YXRlLT5mYik7DQo+ICAJd21iKCk7IC8qIE1ha2Ugc3VyZSB0aGUgYWJv
dmUgcGFyYW1ldGVycyBhcmUgc2V0IGJlZm9yZSB1cGRhdGUNCj4gKi8NCj4gIAluZXdfcGxhbmVf
c3RhdGUtPnBlbmRpbmcuYXN5bmNfZGlydHkgPSB0cnVlOw0KPiAgCW10a19kcm1fY3J0Y19hc3lu
Y191cGRhdGUobmV3X3N0YXRlLT5jcnRjLCBwbGFuZSwgc3RhdGUpOw0K
