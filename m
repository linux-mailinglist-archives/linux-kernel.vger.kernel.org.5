Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A86782360
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjHUGEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjHUGEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:04:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE2CD;
        Sun, 20 Aug 2023 23:04:35 -0700 (PDT)
X-UUID: 960fe5a23fe811eeb20a276fd37b9834-20230821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9OyxwK9L0E+tFgv8/f2quOlRKNuBZCHS+kL9jEXG9BQ=;
        b=mGKBm2xtg7KrzL15LRhwAg6vTZ6wE/sFJvHH8d9WMhfytm2gpV1hFvbED2/D74M284AoFfSOMHuq+3AWnPG9wCe/MI3sk9qaDM1RORAYPelEbTM8LtDvfPtzqQthlg1aw1loAIqoziKHg43y0s7GV8aRdsTpx+buP5M+4ZGmSIo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:3643a24b-502c-44e3-9294-092311aeb074,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.31,REQID:3643a24b-502c-44e3-9294-092311aeb074,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:0ad78a4,CLOUDID:be4215c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:230821140429ZMCDXK9K,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_FAS
X-UUID: 960fe5a23fe811eeb20a276fd37b9834-20230821
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 601788249; Mon, 21 Aug 2023 14:04:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 21 Aug 2023 14:04:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 21 Aug 2023 14:04:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4tD1GVDkC4WbD2ybda7UKW3bfCPLECv+KtL5iuSBMF8W/BHKRoqDm0HNxdKtLU8R9IgNY1RkZNta1c6x9qjwzEXsTUo0bOkFU+SX5fiW2E009e8tTza4tCYkEWoaeoPXvCjb5obToKlLheuYN0o47fyCPm6oSqW6K0oVaZ+l0GzwkrMF/tmm6wtCtDDsc1oX5uZWnLz5jTntoSM9SThmrzcqoD/hA1CTxVPXvSONwCpRyxso2zR3as90YOvDcnzWAHV19CxsaG+XKbzRQ921Z3bWl6wzRHqeyXb/yX7GFS45EnCZPvHBici1uzaQ/5JT3Og4BIWIqe1q3x6GQHBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OyxwK9L0E+tFgv8/f2quOlRKNuBZCHS+kL9jEXG9BQ=;
 b=Y6f+qez2rw+WHROusP8hwGPIaKeZN0IWmDUc9sqinfdc2laZ1JnA1X2GbyjydcaWVUOfrZa1CT7Ad7O8Whi+IbxjRJMvhDFD6saneswasFHUUIY4bCkccCaZ3RS8+KY8gsPgvu1n5VvF+UO1XIALAHzb8SixF31sfgzQ0sKM/yN+dqIaTaWZ7VTEzrfQGb6qEYGp5AE9I7lFs/KsTyoJ+IEfMlG5Pdsc/0rw20Koy4tRVC/d5SRTM3ByZUrL/32XaoiPRdU9KqbPwAKZxj8GiKt5PXRq3CsPBehV1d8fI1B4gSXGiDp+3PPqsK9ahedGv86wt4ksGn8IY3AMXPBACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OyxwK9L0E+tFgv8/f2quOlRKNuBZCHS+kL9jEXG9BQ=;
 b=ZXo6sgrPRSimB61nJRoly70rIOVdYsN7KNNxCSuAiCrsI/urAkblSgz3AGOa1snUDEk71wMJ+8joCsh6U08wbEI94Kyqaacsxf3N8HurgfNZENwPq3Y8KriZOvzUYeaB7wgBMod7CCBfZtgq4+BrsAxOdZdnDmym2Hnd6ZbRhlY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6615.apcprd03.prod.outlook.com (2603:1096:4:1e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 21 Aug
 2023 06:04:24 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6678.029; Mon, 21 Aug 2023
 06:04:24 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v5, 2/4] drm/mediatek: dp: Add the audio packet flag to
 mtk_dp_data struct
Thread-Topic: [PATCH v5, 2/4] drm/mediatek: dp: Add the audio packet flag to
 mtk_dp_data struct
Thread-Index: AQHZ0NQNTO8DgHhBDk+3FpvmfqDeDa/0SQAA
Date:   Mon, 21 Aug 2023 06:04:23 +0000
Message-ID: <33e6ccc4e97b0ef25f6a2360372332180f1ef891.camel@mediatek.com>
References: <20230817062635.8786-1-shuijing.li@mediatek.com>
         <20230817062635.8786-3-shuijing.li@mediatek.com>
In-Reply-To: <20230817062635.8786-3-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6615:EE_
x-ms-office365-filtering-correlation-id: 71ac0e2f-fd69-4fbb-4f85-08dba20c77c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3WULLhX+AMmRw4OgGHvw/FnBhjKBTO2KtuhNYKxloaTmlHza9r3DSwcgxI5LzUzUSqSkOXcdJipPgxk883ctgnIzAOdSVVDHudT+cnz0iaU2yzzDLqoy8Nsk1ySnSFsj9rpqdAsYhM4QtjBBw+qLANqY+sp5qAylLEFPfNLlYDGlnoLXOoIXE99Oh21Q0LxjrfnOIFdicP19mn4LAnxyODG4pbWoYPoATbArxg3RhUqTSVIPdbYz9ueI3c5vaOGQg9wNm5AMKGWxQnrWt/2ejmSjzBZbfmsHWtnbXlWeBKEUC4xHKuIUVdGDAC8m7E8FfsjM9+iW92QpjB2LbDJZdQtSlMdtjkqLOE9PL3bIBuBFp4OeLP5wXz83lOsu4miVQZqUEpBr+enTQMI5e8WrveVyW14KqQeHAyf01vbN2IEgwEbZbsxr2dG4d0Dm7p2OBjGjlfhlPdqm/9clRV0YJBBGwG4ETM079G0ksoBJgKm/W7tPEyB4np5WVJVVYccn7AMKLz1nXD/PqKr0HBRs4TaYE4r0/WpkFpIYlrvjPjxGOkJIHshJW/2RtyRIK5yBCLxiJWJzsg2JpaR0Jmi5V8OEgbgkX2MvnB6TPAVEZFvCzj/Tr1/jjbr9ktuXlfQ5tsgMu7cD3Bl7D5KuzaJrFu9/Eiu5RB4hkM9tUjjFol3AwFPbl6Ze3fptlc6PpyWQ2Ef6d8aF1h8P98OmL7prNb+9pUYI9VGy06CwegMiuo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(1800799009)(186009)(451199024)(83380400001)(2906002)(7416002)(478600001)(86362001)(6486002)(6506007)(2616005)(36756003)(71200400001)(107886003)(6512007)(85182001)(26005)(966005)(5660300002)(41300700001)(122000001)(66476007)(110136005)(66556008)(316002)(54906003)(921005)(66446008)(66946007)(76116006)(64756008)(12101799020)(38070700005)(38100700002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTlHTFpDa2htMDZSbVZ3VzV5Y1ZLUVdKWFplTGdwRVR3elhrc1ZLYll5SkZB?=
 =?utf-8?B?Tk1jNEN4bEpNQ0pvWEkxeHRrVzd6V204cEh3YTNFRUsxYm51K3BoejFzaExF?=
 =?utf-8?B?dk9saDAvWFhCcC81OFlBWkFTaVFlM2hBS1N5Yjd6YnJTT0QwUGR3VG1LTkVz?=
 =?utf-8?B?T0JpWDJaamRybXduY2crbU15SytSdjFpSzFpandRU3lCN2FQNXQrMmlUa2ht?=
 =?utf-8?B?bkdMVGJ3OU02aktGalViQ3pqK1REdlV5akQvbENnWW5zbnZJNnRmSFllaG5x?=
 =?utf-8?B?R1FOR2ZZR2tGVVArT3hQVkM4NEFOd3ZDS2VROWx4K0dMaDAwK1ZHOUd3NGJm?=
 =?utf-8?B?YURTZzNrOW42YUVSVE9tWUNUQk56dGtadjgyRHB6WmNOUlh5ZjRrcnBuNVVN?=
 =?utf-8?B?WlN5WHBWOVhLcVQydllEbWlaUkRpb3NsVDJZRk5TOHBLZTZyMmtxdkRRWWdF?=
 =?utf-8?B?MVhkVlcyb1pEQU1iRElObmNQMDBaSE1MUWI1TFNoVTlZLy8vWmkvM3JKY1Mx?=
 =?utf-8?B?S3ZCVTdXd1VuN0NmZzcxbHgrcXhNZlVSN3Roa0F5MGkveWVoTlFOalpocU91?=
 =?utf-8?B?WnN3enluaEJycERGZWhtUU5abmdhekhsRUs3YUo4bVBVdEpQdWh2WnpUSXlF?=
 =?utf-8?B?emdWTmFjNHRKZVhvYlhjTXpBS2d3Ny9OQXltUS9ibk9ZUjJwQUd0MGw0YTZ2?=
 =?utf-8?B?Q1BUeTB6b2QzRk9uZ0tZdnFSNTlHYnVOcDNxQUZuTzI1MGxJenpJbVl0elRu?=
 =?utf-8?B?YWJGZ2U2OVJaZTFCNVgwK21neFFKbXV4WlM1b3R6bVBFUVk3MlU2VDVrY1Ir?=
 =?utf-8?B?SjNhaXY3TmR3UkplQzU2eGZWbURPWnRBcE5RNExFMjFRb1hHT0pHeEJMdU5o?=
 =?utf-8?B?VjhFR3dXTStYZkg4VGF3TzV5dk9obFJScENuVUZYaVdwd21yNFN6MkRkWkFr?=
 =?utf-8?B?b2IyL0drUDYrQ3dIMEpoZkNQdTNnZHNIVW4yYmVNeXE0bGx2MnM4bUtNbmxQ?=
 =?utf-8?B?VC96S2N3cmJoTGpjaXhQa1pjOHFoWk1ndWIzMVdpTmVrYUJRWmxXQTlMZW0v?=
 =?utf-8?B?Z2t4eHE0NnlDRE9RbHRzRzNiZUMzK2EwMHNsTGhDampsczZacHpzSUZGT0Ni?=
 =?utf-8?B?OUZrK0dqdU1LTWpEMnl3NklpOVppem53b1FLWUd4U0tVRTlwM1FGUnNQOHRj?=
 =?utf-8?B?U0ltalVyaFFTSmdVYUJ5MWxFWDZJYmxTQlpXU2VGUDhHWVQzVXBOY3E1aWNC?=
 =?utf-8?B?NkhKZ2NBNkM0MzBpZ0o2L2l2ZEZzV05XcTVtMTVOL2N6VVlmT0ljRTcvMXRV?=
 =?utf-8?B?UmpielFuZG5OekZ3dk1mWjV4c0tOaitxcFV4R05XZ0I3dU5LQklobFg5dkQ4?=
 =?utf-8?B?T0N4ek14dFdtUVZsVXloYlFETlZNS3Bqc1g3VWI0cGR3WGc0eG44NmcvMWxo?=
 =?utf-8?B?UzdJbjAvdXdoOXdldTlYRFVSbkZId3NXTmtNL1M1M3AxSmhZUCsyZUVpb2pt?=
 =?utf-8?B?aTg1Rko2QWJ4MmNha3FJZzl3WkJxZnhYTjR4TzRXanNIQnkxZ3hxOXV4TlFs?=
 =?utf-8?B?b1F6OGlkc2NWOG80UzhpK3FYd0RCTmJ0a1VHVHVKcmhkTm84K2RaRGMxQ2wy?=
 =?utf-8?B?ZExIdllIeWs5bWlCZHpaU25wekR0NngxWUhXR1oxNHNVOE5wdDhuZlJobEtv?=
 =?utf-8?B?Vk9rQkhzNEg5aXdEY0d6WCtBVWl0cDBkSE5uYjFSN2NkYy8rdzNhejZFUnY1?=
 =?utf-8?B?ZDRmVU1uL3RpRXZBM01RcHVnQVNjNUVxbHBaUGZGWVBVVGg3M0JDRmZVTkdU?=
 =?utf-8?B?VXZ0ZldLcE9wUlVHSVRxZXJYT3RMNmFCT01EbWFrdkE4MGhBdjRNVUdFY2tE?=
 =?utf-8?B?N3VVbUxsaG1VT2padTFReU1KbTlzR1l6NlpncmlhQlZYd0t2eFBNRWw1WFF6?=
 =?utf-8?B?WWRIb0dkaTZtbi9jOG90Z0hGb01PVCs5dlVKd0tFcDVhV3h6dXBWY3o3ajZM?=
 =?utf-8?B?NmdxVzBkZlc2WDYrcGoxeDFuMmhHUkhUMTlFVXdNV1dOY0VxTCsvMHpYREVS?=
 =?utf-8?B?SDBQL1M5L2dwRkdYOEpscWxjeHBYa2E1WTVSczhodU01eCtLTjhiWTRBUDVo?=
 =?utf-8?Q?a4IRoD1pAvHVD1PFEW47rurn6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2036C2210D204444B48652402EDD26F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ac0e2f-fd69-4fbb-4f85-08dba20c77c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 06:04:23.5420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKNlV3qYN8OvZd0qhO5KTDJ/bLYmq2WWyuwL3JGVwS4uzxpCszsufIdkqDBHzOmyMiCTVYKZkreKqJc30E4zrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6615
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBUaHUsIDIwMjMtMDgtMTcgYXQgMTQ6MjYgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBUaGUgYXVkaW8gcGFja2V0IGFycmFuZ2VtZW50IGZ1bmN0aW9uIGlz
IHRvIG9ubHkgYXJyYW5nZSBhdWRpbw0KPiBwYWNrZXRzIGludG8gdGhlIEhibGFua2luZyBhcmVh
LiBJbiBvcmRlciB0byBhbGlnbiB3aXRoIHRoZSBIVw0KPiBkZWZhdWx0IHNldHRpbmcgb2YgbXQ4
MTk1LCB0aGlzIGZ1bmN0aW9uIG5lZWRzIHRvIGJlIHR1cm5lZCBvZmYuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBTaHVpamluZyBMaSA8c2h1aWppbmcubGlAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4g
Q2hhbmdlcyBpbiB2NToNCj4gU2VwYXJhdGUgbXQ4MTg4IHJlbGF0ZWQgY29kZSBpbnRvIG10a19k
cF9kYXRhIHN0cnVjdHVyZSBhbmQgbXQ4MTg4DQo+IGRwL2VkcCBmdW5jdGlvbg0KPiBwZXIgc3Vn
Z2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+IA0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC9jMWM4NDYxNmYzZGE4M2E4YTJiYzI0NWIwZDNjNzY5NzE1M2NkODFhLmNhbWVs
QG1lZGlhdGVrLmNvbS8NCj4gQ2hhbmdlcyBpbiB2NDoNCj4gZHJvcCBtdDgxODhfZWRwX2RhdGEg
YW5kIHJlbW92ZSB1bm5lY2Vzc2FyeSBtb2RpZmljYXRpb24uDQo+IHBlciBzdWdnZXN0aW9uIGZy
b20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
YmRkYjFhMWE0NDVlYWQ4NTA1NjIwMmMzNTU2Mjc2OTgwNTFmMTJjOS5jYW1lbEBtZWRpYXRlay5j
b20vDQo+IENoYW5nZXMgaW4gdjM6DQo+IFNlcGFyYXRlIHRoZXNlIHR3byB0aGluZ3MgaW50byB0
d28gZGlmZmVyZW50IHBhdGNoZXMuDQo+IHBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHByZXZpb3Vz
IHRocmVhZDoNCj4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2UyYWQyMmJjYmEzMTc5
N2YzOGExMmE0ODhkNDI0NmEwMWJmMGNiMmUuY2FtZWxAbWVkaWF0ZWsuY29tLw0KPiBDaGFuZ2Vz
IGluIHYyOg0KPiAtIGNoYW5nZSB0aGUgdmFyaWFibGVzJyBuYW1lIHRvIGJlIG1vcmUgZGVzY3Jp
cHRpdmUNCj4gLSBhZGQgYSBjb21tZW50IHRoYXQgZGVzY3JpYmVzIHRoZSBmdW5jdGlvbiBvZg0K
PiBtdGtfZHBfYXVkaW9fc2FtcGxlX2FycmFuZ2UNCj4gLSByZWR1Y2UgaW5kZW50YXRpb24gYnkg
ZG9pbmcgdGhlIGludmVyc2UgY2hlY2sNCj4gLSBhZGQgYSBkZWZpbml0aW9uIG9mIHNvbWUgYml0
cw0KPiAtIGFkZCBzdXBwb3J0IGZvciBtZWRpYXRlaywgbXQ4MTg4LWVkcC10eA0KPiBwZXIgc3Vn
Z2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+IA0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC9hYzBmY2VjOS1hMmZlLTA2Y2MtYzcyNy0xODllZjdiYWJlOWNAY29sbGFib3Jh
LmNvbS8NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMgICAgIHwg
MTcgKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBf
cmVnLmggfCAgNSArKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGluZGV4IDY0ZWVlNzc0NTJjMC4u
YmU1NTdiNmY1ODU0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RwLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IEBAIC0x
MzksNiArMTM5LDcgQEAgc3RydWN0IG10a19kcF9kYXRhIHsNCj4gIAl1bnNpZ25lZCBpbnQgc21j
X2NtZDsNCj4gIAljb25zdCBzdHJ1Y3QgbXRrX2RwX2VmdXNlX2ZtdCAqZWZ1c2VfZm10Ow0KPiAg
CWJvb2wgYXVkaW9fc3VwcG9ydGVkOw0KPiArCWJvb2wgYXVkaW9fcGt0X2luX2hibGFua19hcmVh
Ow0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBfZWZ1c2VfZm10DQo+
IG10ODE5NV9lZHBfZWZ1c2VfZm10W01US19EUF9DQUxfTUFYXSA9IHsNCj4gQEAgLTI2MTYsNiAr
MjYxNywxNCBAQCBzdGF0aWMgaW50IG10a19kcF9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiAgDQo+ICBzdGF0aWMgU0lNUExFX0RFVl9QTV9PUFMobXRrX2RwX3BtX29wcywgbXRrX2RwX3N1
c3BlbmQsDQo+IG10a19kcF9yZXN1bWUpOw0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19kcF9kYXRhIG10ODE4OF9kcF9kYXRhID0gew0KPiArCS5icmlkZ2VfdHlwZSA9IERSTV9NT0RF
X0NPTk5FQ1RPUl9EaXNwbGF5UG9ydCwNCj4gKwkuc21jX2NtZCA9IE1US19EUF9TSVBfQVRGX1ZJ
REVPX1VOTVVURSwNCj4gKwkuZWZ1c2VfZm10ID0gbXQ4MTk1X2RwX2VmdXNlX2ZtdCwNCj4gKwku
YXVkaW9fc3VwcG9ydGVkID0gdHJ1ZSwNCj4gKwkuYXVkaW9fcGt0X2luX2hibGFua19hcmVhID0g
dHJ1ZSwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4
MTk1X2VkcF9kYXRhID0gew0KPiAgCS5icmlkZ2VfdHlwZSA9IERSTV9NT0RFX0NPTk5FQ1RPUl9l
RFAsDQo+ICAJLnNtY19jbWQgPSBNVEtfRFBfU0lQX0FURl9FRFBfVklERU9fVU5NVVRFLA0KPiBA
QCAtMjYzMSw2ICsyNjQwLDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4
MTk1X2RwX2RhdGENCj4gPSB7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBtdGtfZHBfb2ZfbWF0Y2hbXSA9IHsNCj4gKwl7DQo+ICsJCS5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE4OC1lZHAtdHgiLA0KPiArCQkuZGF0YSA9ICZtdDgxOTVfZWRwX2Rh
dGEsDQo+ICsJfSwNCj4gKwl7DQo+ICsJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1k
cC10eCIsDQo+ICsJCS5kYXRhID0gJm10ODE4OF9kcF9kYXRhLA0KPiArCX0sDQoNCk1vdmUgdGhp
cyB0byAiWzQvNF0gQWRkIHN1cHBvcnQgTVQ4MTg4IGRwL2VkcCBmdW5jdGlvbiIuDQoNClJlZ2Fy
ZHMsDQpDSw0KDQo+ICAJew0KPiAgCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtZWRw
LXR4IiwNCj4gIAkJLmRhdGEgPSAmbXQ4MTk1X2VkcF9kYXRhLA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBfcmVnLmgNCj4gaW5kZXggODRlMzhjZWYwM2MyLi5mMzhkNmZmMTJhZmUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVnLmgNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcuaA0KPiBAQCAtMjI4LDYg
KzIyOCwxMSBAQA0KPiAgCQkJCQkJCSBWSURFT19TVEFCTEVfQw0KPiBOVF9USFJEX0RQX0VOQzFf
UDAgfCBcDQo+ICAJCQkJCQkJIFNEUF9EUDEzX0VOX0RQDQo+IF9FTkMxX1AwIHwgXA0KPiAgCQkJ
CQkJCSBCUzJCU19NT0RFX0RQXw0KPiBFTkMxX1AwKQ0KPiArDQo+ICsjZGVmaW5lIE1US19EUF9F
TkMxX1AwXzMzNzQJCQkweDMzNzQNCj4gKyNkZWZpbmUgU0RQX0FTUF9JTlNFUlRfSU5fSEJMQU5L
X0RQX0VOQzFfUDBfTUFTSwlCSVQoMTIpDQo+ICsjZGVmaW5lIFNEUF9ET1dOX0FTUF9DTlRfSU5J
VF9EUF9FTkMxX1AwX01BU0sJCUdFTk1BU0sNCj4gKDExLCAwKQ0KPiArDQo+ICAjZGVmaW5lIE1U
S19EUF9FTkMxX1AwXzMzRjQJCQkweDMzZjQNCj4gICNkZWZpbmUgRFBfRU5DX0RVTU1ZX1JXXzFf
QVVESU9fUlNUX0VOCQkJQklUKDApDQo+ICAjZGVmaW5lIERQX0VOQ19EVU1NWV9SV18xCQkJCUJJ
VCg5KQ0K
