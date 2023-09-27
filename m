Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725877AF8B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjI0Dgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjI0D2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:28:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A1655B1;
        Tue, 26 Sep 2023 18:51:12 -0700 (PDT)
X-UUID: 51d12cfe5cd811ee8051498923ad61e6-20230927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=s4RK2NFQjB7r3OsRpGyzJEH7h8Qs+g0YMgf7ny5Hdp8=;
        b=A0oQonmu/MlCfn8FDV0Uh/n5/k7zwjo8USG9jQAW/CwkMI2FicDON98gCgzIUJSCGZSLzHpEwEMYTjKnZyFrHcqFR9CLagvCCQ97y/WQF0lKGScS71u3Ybp9z0YLtxx2CemJGPOuAopSi6bsXSPj7dWzEF6lM7WO1NCIMdTlzYM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:7fb2cb21-5ede-499e-8752-8eb8e8b9d49f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:cead80c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 51d12cfe5cd811ee8051498923ad61e6-20230927
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1921917109; Wed, 27 Sep 2023 09:51:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Sep 2023 09:51:03 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Sep 2023 09:51:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0TjQyzF+Uv6ho43qoT4m+orr/TxYjdu+tvyc9PqQAv2GiDNckVUrrxJe+6BqhzY3nBDa48TRRPJDy7U3CXJgK2BCTsFz7jr+xxyVpYE58CVOkAhAeQHnmHPBsaNwMi/RaXl08PPocdNxgItkYAjbon9cJq0a1CHRrMWE0DmizPPjWJo8vWLQf8elC9OQp1F5WowwtzzWnZAoX8ubqnliWfy6ISETLeIm5zvGqBGl6cRa3guMjbkwNK5/zbs99Vm01u+zql7jJRYdBmVzo3RBYxZ3pEk+aRGWWr6IxM9nZ8/gD+ZG+po2hSNhjSX94g4ePmmqMloFAynXRWZu03mJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4RK2NFQjB7r3OsRpGyzJEH7h8Qs+g0YMgf7ny5Hdp8=;
 b=A68PxwqcIiK26f0wtE2+DZzt0cRiFlD0T9nHK34ibQBgS09mj6ODqNCcFH6i5SQHCN6BnmfppODuz+9pBQznVFmf1lKGcYEwWWXWcJTbtVH9R/wz6QOYXS1/8BMiUeOHGCuQ9681bT7UcfpUwq3fZRapTto6OF8+JczkSY/iIDBydmucNlGNw65H7z5pBhe3awXQD8j6jrWLZmZSzgVeg15setNRSuApAMlfaB1gRcRcRho9RWNKhOsnEKHWMc+wc6sIjTDumhtS1fhj/bbwdf261hYTHfozcXtfuPQkXJKNCBLjzBRrhKYGxRZceGp0OtEmzt/cd+EZYEBhyL8sMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4RK2NFQjB7r3OsRpGyzJEH7h8Qs+g0YMgf7ny5Hdp8=;
 b=PlO6twzsmaK3GDRyVH5aTTiwThc84Ajt7yJ5qLITsYZxSIcUdgDU9EH5DJNPvzM4ZAa+0v/Kk72xAsIO1BRsKzrJ69wshiNfjoVyYRBjxBTj9+ImZhofQy8wWuU9nMKbw2LyllLERePTNyCC9bLSOOzMPrGu6nMzOdbzZ/PdTeY=
Received: from SEZPR03MB7947.apcprd03.prod.outlook.com (2603:1096:101:187::6)
 by KL1PR03MB6976.apcprd03.prod.outlook.com (2603:1096:820:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 01:51:00 +0000
Received: from SEZPR03MB7947.apcprd03.prod.outlook.com
 ([fe80::5b2b:aa9e:68da:f47d]) by SEZPR03MB7947.apcprd03.prod.outlook.com
 ([fe80::5b2b:aa9e:68da:f47d%4]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 01:51:00 +0000
From:   =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] media: mediatek: vcodec: add encoder power management
 helper functions
Thread-Topic: [PATCH] media: mediatek: vcodec: add encoder power management
 helper functions
Thread-Index: AQHZ72Ur/HUO6fcCj0CGtkc1bloDmbArQl6AgAKo9gA=
Date:   Wed, 27 Sep 2023 01:51:00 +0000
Message-ID: <b1d0ad1c3e722eee749d370ba4723c1476abd637.camel@mediatek.com>
References: <20230925040200.18220-1-irui.wang@mediatek.com>
         <6df2b962-fa21-d58f-7f39-fe46d049f97e@collabora.com>
In-Reply-To: <6df2b962-fa21-d58f-7f39-fe46d049f97e@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7947:EE_|KL1PR03MB6976:EE_
x-ms-office365-filtering-correlation-id: 59e9b96a-b72e-4d66-d220-08dbbefc3346
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M0DKiy6dXR9gj/xBH5+LU1ZaKG8DYftB4Uusp+F10wB1tWk+YMAyFs7LY5CQfigo3iE7+tovXh6BQ7X+Bnl4Ab3f12KtgZDfHKmPiQVI61ZkrafjQebt17nsQ/pzP4OWH0C1m/VdKbTqqcVlzu/xVmPAjImSn7c4TFJFvwNRH3mq8h5IkgGHWKIYvS0BkGSjhdYExKtbQgEEXGzFQD71KZxi+TCIBKIg/+7tAGQ4j69EKAQbgJMAnJkQ87P80sBoVVOgHEisQyGvlr0aCHvFCSZM13ij+cN++1ZJtRkgkO1UWNx0uGjJZ5j/WyBqBMkbMmSZCjhGSLFRt2cSvajXd7nQXdYiDO/0vRa3ocXeYjs2Nn0fFzipjiSVOIN28E0WAmOou1pCHfwh1YgcV+K0QeWS7ghIYXyJvuFRUijS6gQLthe5cWmjAOPNuxTf7O82v1WuMaSBoYXnskRBCyrC55xK3f9x4J69C3obIU2nwxotlAj2r9+kN9Wt8EkFRs67C1BVAAlA7h6H9zK/D6dWIfOn9ogQAdswnHnlrme3thW26NcYmCS6OVDOuA/C9P8vcVJq40OUVP3UYYpNGc4sPez13/iAC76A8Jrugvl+dNT90PFnvvRgi7BEgpwrgA2Qpg2Ybkrl5o2TVwXJfudKjSyIUu6ZaspZlbTW+iLHZzs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7947.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(316002)(5660300002)(8936002)(41300700001)(8676002)(4326008)(6636002)(110136005)(54906003)(66476007)(66446008)(66556008)(64756008)(66946007)(91956017)(478600001)(76116006)(2906002)(2616005)(6506007)(6512007)(36756003)(85182001)(6486002)(86362001)(71200400001)(83380400001)(38070700005)(38100700002)(122000001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDhzN2pEU0lFRGJCR1ZoQjJhRVNPbmUreHdBdDVodXFvOGxmOE44ZUJYb0ps?=
 =?utf-8?B?b2JvVURxNm9uYjNxQVdjNE5Vd29NemgwVkxBTUZ2QTJ1bTRVRjVvS00yZWpz?=
 =?utf-8?B?N0gxcnpxeDNTeDNYQU5ERkI1MUprVTNIdkRLMHRCN2ZKOHRlNjI2Q25Mditr?=
 =?utf-8?B?NGlzRHZESGZneGpvUU5WNTJQODZoYmxQb2hHUUtENkNiTlkwZ0VwNWgyZlNN?=
 =?utf-8?B?Mmp0ZkdFdmRUQmgwUlQrcWJxdFFmaUtpeDBDN05lM1lzLzdDL2I5bGdSV1ky?=
 =?utf-8?B?VVN0TzJyTG5PQ0xKSE1oc1I4eWUzQklaVW5qMnJVV3prZ0Q2bm9aMyt5anNI?=
 =?utf-8?B?L1dMZzFrMlphV1hkMlZpVFJ3QjVXOXR6bCtLbUtHZ2RnNVptTXlNekhjUHZm?=
 =?utf-8?B?UloreFFEUDdHYWNNZkY2NFMxcnhMNzB3ZU5pWEFWOVZCa0VadlZZT0NvdW9X?=
 =?utf-8?B?SUNoQzYxY3REV1ExckpFSGQ4dTM0MXNoOWs1eE9ZbVoxUW9kV1h2TzN4UVp1?=
 =?utf-8?B?N2NuVDlrbUNjL21DYzJpWmo2d1pERm1hRnFRajQ1TU5CTlVKRlNJaksydnlZ?=
 =?utf-8?B?NFRyK0pjem9ETitmeFdIQXZVVXZDSzZsYm14Zk92ZmdieklZYjdMaCtwY1gz?=
 =?utf-8?B?RngrTm5USDRRTExDVDZqWVVEYW9mV3huRE4xN3lneEtJWW1XOWtEb28yVjVS?=
 =?utf-8?B?QlhXbUNNZUxDcUZBSDA2VnRXZkxWZ09pUkFRR1BNRHhRVFRFNnBIKzdZbjVt?=
 =?utf-8?B?UlUzZWxTc0JsSyt2czlBOHREM0lLVHlvSkk0S0tmTTNGZVp2QlBack1UbFQw?=
 =?utf-8?B?WVdWaTVoSEZ0bVVneVB2L3grVWJXSXJUSVJPRW4wcW0zZFVpUVMwSHVSMzBa?=
 =?utf-8?B?ZWFwOGZpY09iako1Y1M3eUNzYnl2OVo1WFBLam8xRkt6WnJoOVF6RlZTSTRV?=
 =?utf-8?B?ZjdxT1VxaVJmSkRYTS9vdzhKZWw2TTdiU2N4cXdPd1kyVW4xd2ZBSXoyYWVy?=
 =?utf-8?B?cyt5WlpCM1RUeHBWNTNOSCtwbnFmbW1YVGtTQVR1WkpwTzJCVXJ1RjdwTTRS?=
 =?utf-8?B?VnJFZzdWMDMrN01XekFVOHkrRmh3YUtGaFBpZDJIZGo0M1MzVkpGZFVROS93?=
 =?utf-8?B?azBFRGwzem90MWpMcnRQNFJlY054MkVWMmdHR0E2U2JLWHNZRkpOR3d6WTNY?=
 =?utf-8?B?bnpjSHpOcDZzWG5RUzVaOEhQZnFJK0hoZExzWTdQbmdtZDlXRzBHbEVGeE9B?=
 =?utf-8?B?dmdpZWY2SmZzSzAvRWVJLy9yb2hCN2I1Rk8rSThSS1dRZkNYVTZvUDlHVC9Z?=
 =?utf-8?B?ayttVmp6eUZhbG9wU0dLakoraXRRRFQyS2JEMlZPTStkSG5EYnBYYzZHaWM5?=
 =?utf-8?B?MUpETlRzbkdSZkJKVkxwSXVmYUs0Y1lxN3B0aGxRN2d3T2ZNckQ5dHBiZ0Zy?=
 =?utf-8?B?bUR0WXVTRjZHOUw3elM3aUJNc2lSNmZ4eHlyWk9BSENtN1ZLTkYwRmxsa2ZO?=
 =?utf-8?B?dHpwcFVmdzdWcEJtQWtKVlNmT3hGWWN6MEFkRE5DamlGL3hybUZPZTFqbWRE?=
 =?utf-8?B?UFNsZFE1cGtPM3F5VTdpbTVZMWdzaTY5VXZTMk9DbFFOMTlaR1R0eC9XNDBy?=
 =?utf-8?B?VkFkY1BrRlE5dTBOMGt5OFcvY0xSb3lRT0NoS0dMcm1rcXJWbXR2YmZwMmRz?=
 =?utf-8?B?UTVnTHNJQ05oTHdvbHNEeGtiQnpqQnF6VXd4eUNhYmpOZVBJb0krR05XSjBi?=
 =?utf-8?B?VklveU1PZHpyS1dzZXpGZ3VVZkNqdFZiVGdLNW9haktxSFZ2WDJaQjVJbno2?=
 =?utf-8?B?b3BocTU3eUQ3SWdRVmp4WEJqZ1h1TUJpcVBNejNGcDRqVVBFcGlVaFJmd2po?=
 =?utf-8?B?S21iTlFZRWpQSjRPVzBhZU5DODZHQ0lqemhjN2hiczVPZGNETGpKM2xLcFc1?=
 =?utf-8?B?RmloRFZzZnQ0S0EvRGtDTkZ0Mm9qZEZhRW9lVlp5QWZsKzJDU0xodmZ2RVVB?=
 =?utf-8?B?L3VuZFJOR1pTZWZScThGQjBCeWhycVc3ZVBzdU9KWjV0VVRzaGN6UmVrN0xG?=
 =?utf-8?B?LzJCcWNnNmQvNGZlaFFvUVluT1dsakF5ZSt6eXIwVFJVOThONFl2bkp4VUN3?=
 =?utf-8?B?QzVmZVBUWHRDNjcxVVNHZ3BOdHFlMzYwNktad0tySEZFcVJoV1VlMkc0NlAx?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90F029E9C0AEE04580FCA1312A604D3E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7947.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e9b96a-b72e-4d66-d220-08dbbefc3346
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 01:51:00.4275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUbAeXwrt4+uzrYpY/eg3tzAF2oivPRAjzIHWIK1cw22glSV9kz8Wvr3RFaZM0DPBKG0WcHV+SJ+bwic7yGL5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6976
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.329400-8.000000
X-TMASE-MatchedRID: dc8Jy61QoRrUL3YCMmnG4qwOh3D3JSTGEtdrY/Wb3fPagsZM0qVv17Ft
        VeNnmiVIA8+wLcXiwMrlPWOZdnoFfGQkHQEHAoWZx6hrpRSrYiudpfncOF/0WdgJ+YNQuvvyZSg
        PkksZfMDz+cGaEZD4biQDNtERbP2bneTDMjnpUR0D2WXLXdz+AStovaaHxlUrCqIJhrrDy28FY/
        2/e7ATLvPzAcEBOxQZ8MLFADlk4NeDiNkfvbHj3s36paW7ZnFoOhJ9m53n4aDFpA1uJFd1mrouM
        63AneY0+n4exm8tpYbrRyRZQmPKTDlcyhHfhEXKngIgpj8eDcDBa6VG2+9jFNZE3xJMmmXc+gtH
        j7OwNO0CpgETeT0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.329400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 60FA117F022B674EE066E0BDD3148F5CD0BE634F935BC0F07E0D3E7DDAF868A22000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbmdlbG8sDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXdpbmcNCg0KT24gTW9uLCAyMDIz
LTA5LTI1IGF0IDExOjEzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToN
Cj4gSWwgMjUvMDkvMjMgMDY6MDIsIElydWkgV2FuZyBoYSBzY3JpdHRvOg0KPiA+IFJlbW92ZSBQ
TSBmdW5jdGlvbnMgYXQgc3RhcnQvc3RvcCBzdHJlYW1pbmcsIGFkZCBQTSBoZWxwZXINCj4gPiBm
dW5jdGlvbnMNCj4gPiB0byBnZXQgUE0gYmVmb3JlIGVuY29kaW5nIGZyYW1lIHN0YXJ0IGFuZCBw
dXQgUE0gYWZ0ZXIgZW5jb2RpbmcNCj4gPiBmcmFtZQ0KPiA+IGRvbmUuIE1lYW53aGlsZSwgcmVt
b3ZlIHVubmVjZXNzYXJ5IGNsb2NrIG9wZXJhdGlvbnMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogSXJ1aSBXYW5nIDxpcnVpLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgLi4u
L21lZGlhdGVrL3Zjb2RlYy9lbmNvZGVyL210a192Y29kZWNfZW5jLmMgIHwgMjEgKysrLS0tLS0t
LS0tLS0NCj4gPiAtLS0tLQ0KPiA+ICAgLi4uL3Zjb2RlYy9lbmNvZGVyL210a192Y29kZWNfZW5j
X3BtLmMgICAgICAgIHwgMTgNCj4gPiArKysrKysrKysrKysrKysrDQo+ID4gICAuLi4vdmNvZGVj
L2VuY29kZXIvbXRrX3Zjb2RlY19lbmNfcG0uaCAgICAgICAgfCAgMyArKy0NCj4gPiAgIC4uLi9t
ZWRpYXRlay92Y29kZWMvZW5jb2Rlci92ZW5jX2Rydl9pZi5jICAgICB8ICA4ICsrLS0tLS0NCj4g
PiAgIDQgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay92Y29kZWMvZW5jb2Rlci9tdGtfdmNvZGVjX2VuYy5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9lbmNvZGVyL210a192Y29kZWNfZW5jLmMNCj4gPiBpbmRl
eCAwNDk0OGQzZWIwMTEuLmViMzgxZmE2ZTdkMSAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2VuY29kZXIvbXRrX3Zjb2RlY19lbmMu
Yw0KPiA+ICsrKw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMv
ZW5jb2Rlci9tdGtfdmNvZGVjX2VuYy5jDQo+ID4gQEAgLTg2Niw3ICs4NjYsNyBAQCBzdGF0aWMg
aW50IHZiMm9wc192ZW5jX3N0YXJ0X3N0cmVhbWluZyhzdHJ1Y3QNCj4gPiB2YjJfcXVldWUgKnEs
IHVuc2lnbmVkIGludCBjb3VudCkNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgbXRrX3Zjb2RlY19l
bmNfY3R4ICpjdHggPSB2YjJfZ2V0X2Rydl9wcml2KHEpOw0KPiA+ICAgCXN0cnVjdCB2ZW5jX2Vu
Y19wYXJhbSBwYXJhbTsNCj4gPiAtCWludCByZXQsIHBtX3JldDsNCj4gPiArCWludCByZXQ7DQo+
ID4gICAJaW50IGk7DQo+ID4gICANCj4gPiAgIAkvKiBPbmNlIHN0YXRlIHR1cm4gaW50byBNVEtf
U1RBVEVfQUJPUlQsIHdlIG5lZWQgc3RvcF9zdHJlYW1pbmcNCj4gPiBAQCAtODg2LDE4ICs4ODYs
MTIgQEAgc3RhdGljIGludCB2YjJvcHNfdmVuY19zdGFydF9zdHJlYW1pbmcoc3RydWN0DQo+ID4g
dmIyX3F1ZXVlICpxLCB1bnNpZ25lZCBpbnQgY291bnQpDQo+ID4gICAJCQlyZXR1cm4gMDsNCj4g
PiAgIAl9DQo+ID4gICANCj4gPiAtCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoJmN0
eC0+ZGV2LT5wbGF0X2Rldi0+ZGV2KTsNCj4gPiAtCWlmIChyZXQgPCAwKSB7DQo+ID4gLQkJbXRr
X3Y0bDJfdmVuY19lcnIoY3R4LCAicG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCBmYWlsDQo+ID4g
JWQiLCByZXQpOw0KPiA+IC0JCWdvdG8gZXJyX3N0YXJ0X3N0cmVhbTsNCj4gPiAtCX0NCj4gPiAt
DQo+ID4gICAJbXRrX3ZlbmNfc2V0X3BhcmFtKGN0eCwgJnBhcmFtKTsNCj4gPiAgIAlyZXQgPSB2
ZW5jX2lmX3NldF9wYXJhbShjdHgsIFZFTkNfU0VUX1BBUkFNX0VOQywgJnBhcmFtKTsNCj4gPiAg
IAlpZiAocmV0KSB7DQo+ID4gICAJCW10a192NGwyX3ZlbmNfZXJyKGN0eCwgInZlbmNfaWZfc2V0
X3BhcmFtIGZhaWxlZD0lZCIsDQo+ID4gcmV0KTsNCj4gPiAgIAkJY3R4LT5zdGF0ZSA9IE1US19T
VEFURV9BQk9SVDsNCj4gPiAtCQlnb3RvIGVycl9zZXRfcGFyYW07DQo+ID4gKwkJZ290byBlcnJf
c3RhcnRfc3RyZWFtOw0KPiA+ICAgCX0NCj4gPiAgIAljdHgtPnBhcmFtX2NoYW5nZSA9IE1US19F
TkNPREVfUEFSQU1fTk9ORTsNCj4gPiAgIA0KPiA+IEBAIC05MTAsMTggKzkwNCwxMyBAQCBzdGF0
aWMgaW50IHZiMm9wc192ZW5jX3N0YXJ0X3N0cmVhbWluZyhzdHJ1Y3QNCj4gPiB2YjJfcXVldWUg
KnEsIHVuc2lnbmVkIGludCBjb3VudCkNCj4gPiAgIAkJaWYgKHJldCkgew0KPiA+ICAgCQkJbXRr
X3Y0bDJfdmVuY19lcnIoY3R4LCAidmVuY19pZl9zZXRfcGFyYW0NCj4gPiBmYWlsZWQ9JWQiLCBy
ZXQpOw0KPiA+ICAgCQkJY3R4LT5zdGF0ZSA9IE1US19TVEFURV9BQk9SVDsNCj4gPiAtCQkJZ290
byBlcnJfc2V0X3BhcmFtOw0KPiA+ICsJCQlnb3RvIGVycl9zdGFydF9zdHJlYW07DQo+ID4gICAJ
CX0NCj4gPiAgIAkJY3R4LT5zdGF0ZSA9IE1US19TVEFURV9IRUFERVI7DQo+ID4gICAJfQ0KPiA+
ICAgDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICANCj4gPiAtZXJyX3NldF9wYXJhbToNCj4gPiAt
CXBtX3JldCA9IHBtX3J1bnRpbWVfcHV0KCZjdHgtPmRldi0+cGxhdF9kZXYtPmRldik7DQo+ID4g
LQlpZiAocG1fcmV0IDwgMCkNCj4gPiAtCQltdGtfdjRsMl92ZW5jX2VycihjdHgsICJwbV9ydW50
aW1lX3B1dCBmYWlsICVkIiwNCj4gPiBwbV9yZXQpOw0KPiA+IC0NCj4gPiAgIGVycl9zdGFydF9z
dHJlYW06DQo+ID4gICAJZm9yIChpID0gMDsgaSA8IHEtPm51bV9idWZmZXJzOyArK2kpIHsNCj4g
PiAgIAkJc3RydWN0IHZiMl9idWZmZXIgKmJ1ZiA9IHZiMl9nZXRfYnVmZmVyKHEsIGkpOw0KPiA+
IEBAIC0xMDA0LDEwICs5OTMsNiBAQCBzdGF0aWMgdm9pZCB2YjJvcHNfdmVuY19zdG9wX3N0cmVh
bWluZyhzdHJ1Y3QNCj4gPiB2YjJfcXVldWUgKnEpDQo+ID4gICAJaWYgKHJldCkNCj4gPiAgIAkJ
bXRrX3Y0bDJfdmVuY19lcnIoY3R4LCAidmVuY19pZl9kZWluaXQgZmFpbGVkPSVkIiwNCj4gPiBy
ZXQpOw0KPiA+ICAgDQo+ID4gLQlyZXQgPSBwbV9ydW50aW1lX3B1dCgmY3R4LT5kZXYtPnBsYXRf
ZGV2LT5kZXYpOw0KPiA+IC0JaWYgKHJldCA8IDApDQo+ID4gLQkJbXRrX3Y0bDJfdmVuY19lcnIo
Y3R4LCAicG1fcnVudGltZV9wdXQgZmFpbCAlZCIsIHJldCk7DQo+ID4gLQ0KPiA+ICAgCWN0eC0+
c3RhdGUgPSBNVEtfU1RBVEVfRlJFRTsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+IGRpZmYgLS1naXQN
Cj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2VuY29kZXIvbXRr
X3Zjb2RlY19lbmNfcG0uDQo+ID4gYw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRp
YXRlay92Y29kZWMvZW5jb2Rlci9tdGtfdmNvZGVjX2VuY19wbS4NCj4gPiBjDQo+ID4gaW5kZXgg
M2ZjZTkzNmU2MWI5Li5hMjJiN2RmYzY1NmUgMTAwNjQ0DQo+ID4gLS0tDQo+ID4gYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9lbmNvZGVyL210a192Y29kZWNfZW5jX3Bt
Lg0KPiA+IGMNCj4gPiArKysNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsv
dmNvZGVjL2VuY29kZXIvbXRrX3Zjb2RlY19lbmNfcG0uDQo+ID4gYw0KPiA+IEBAIC01OCw2ICs1
OCwyNCBAQCBpbnQgbXRrX3Zjb2RlY19pbml0X2VuY19jbGsoc3RydWN0DQo+ID4gbXRrX3Zjb2Rl
Y19lbmNfZGV2ICptdGtkZXYpDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4gICANCj4g
PiArdm9pZCBtdGtfdmNvZGVjX2VuY19wd19vbihzdHJ1Y3QgbXRrX3Zjb2RlY19wbSAqcG0pDQo+
ID4gK3sNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gcG1fcnVudGltZV9yZXN1
bWVfYW5kX2dldChwbS0+ZGV2KTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJZGV2X2VycihwbS0+
ZGV2LCAicG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCBmYWlsOiAlZCIsDQo+ID4gcmV0KTsNCj4g
PiArfQ0KPiANCj4gVGhvc2UgYXJlIGV4YWN0bHkgdGhlIHNhbWUgZnVuY3Rpb25zIGFzIHRoZSBE
RUNPREVSIGNvdW50ZXJwYXJ0Li4uDQo+IGluc3RlYWQNCj4gb2YgZHVwbGljYXRpbmcgdGhlbSwg
Y2FuIHlvdSBwbGVhc2Ugc2ltcGx5IGNvbW1vbml6ZSB0aGUgZnVuY3Rpb25zIGluDQo+IG10a192
Y29kZWNfZGVjX3BtLmMgPw0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQoNClllcywgdGhleSBh
cmUgdGhlIHNhbWUgZnVuY3Rpb25zIGFzIHRoZSBERUNPREVSLCB3ZSB0aGluayBFTkNPREVSIGFu
ZA0KREVDT0RFUiBoYXZlIHRoZWlyIG93bmVkIHBtX3J1bnRpbWUgaGVscGVyIGZ1bmN0aW9ucyBm
b3IgYSBiZXR0ZXINCnJlYWRhYmlsaXR5IGFuZCBmdXR1cmUgZmxleGliaWxpdHkuIEFuZCB5dW5m
ZWkgaGFzIGhlbHBlZCB0byBzZXBhcmF0ZQ0KZGVjb2RlciBhbmQgZW5jb2Rlciwgc28gd2UgcHJl
ZmVyIHRvIHNlcGFyYXRlIHRoZSBwb3dlciBtYW5hZ2VtZW50LCBpdA0KbWlnaHQgYmUgbW9yZSBl
YXNpZXIgdG8gbWFuYWdlIGxhdGVyLg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoDQpCZXN0IFJlZ2Fy
ZHMNCj4gDQo+ID4gKw0KPiA+ICt2b2lkIG10a192Y29kZWNfZW5jX3B3X29mZihzdHJ1Y3QgbXRr
X3Zjb2RlY19wbSAqcG0pDQo+ID4gK3sNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0
ID0gcG1fcnVudGltZV9wdXQocG0tPmRldik7DQo+ID4gKwlpZiAocmV0ICYmIHJldCAhPSAtRUFH
QUlOKQ0KPiA+ICsJCWRldl9lcnIocG0tPmRldiwgInBtX3J1bnRpbWVfcHV0IGZhaWwgJWQiLCBy
ZXQpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgdm9pZCBtdGtfdmNvZGVjX2VuY19jbG9ja19vbihz
dHJ1Y3QgbXRrX3Zjb2RlY19wbSAqcG0pDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IG10a192Y29k
ZWNfY2xrICplbmNfY2xrID0gJnBtLT52ZW5jX2NsazsNCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9lbmNvZGVyL210a192Y29kZWNf
ZW5jX3BtLg0KPiA+IGgNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNv
ZGVjL2VuY29kZXIvbXRrX3Zjb2RlY19lbmNfcG0uDQo+ID4gaA0KPiA+IGluZGV4IGU1MGJlMDU3
NTE5MC4uMTU3ZWEwOGJhOWUzIDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZW5jb2Rlci9tdGtfdmNvZGVjX2VuY19wbS4NCj4gPiBo
DQo+ID4gKysrDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9l
bmNvZGVyL210a192Y29kZWNfZW5jX3BtLg0KPiA+IGgNCj4gPiBAQCAtMTAsNyArMTAsOCBAQA0K
PiA+ICAgI2luY2x1ZGUgIm10a192Y29kZWNfZW5jX2Rydi5oIg0KPiA+ICAgDQo+ID4gICBpbnQg
bXRrX3Zjb2RlY19pbml0X2VuY19jbGsoc3RydWN0IG10a192Y29kZWNfZW5jX2RldiAqZGV2KTsN
Cj4gPiAtDQo+ID4gK3ZvaWQgbXRrX3Zjb2RlY19lbmNfcHdfb24oc3RydWN0IG10a192Y29kZWNf
cG0gKnBtKTsNCj4gPiArdm9pZCBtdGtfdmNvZGVjX2VuY19wd19vZmYoc3RydWN0IG10a192Y29k
ZWNfcG0gKnBtKTsNCj4gPiAgIHZvaWQgbXRrX3Zjb2RlY19lbmNfY2xvY2tfb24oc3RydWN0IG10
a192Y29kZWNfcG0gKnBtKTsNCj4gPiAgIHZvaWQgbXRrX3Zjb2RlY19lbmNfY2xvY2tfb2ZmKHN0
cnVjdCBtdGtfdmNvZGVjX3BtICpwbSk7DQo+ID4gICANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9lbmNvZGVyL3ZlbmNfZHJ2X2lm
LmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2VuY29kZXIv
dmVuY19kcnZfaWYuYw0KPiA+IGluZGV4IDFiZGFlY2RkNjRhNy4uYzQwMmE2ODZmM2NiIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2VuY29k
ZXIvdmVuY19kcnZfaWYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0
ZWsvdmNvZGVjL2VuY29kZXIvdmVuY19kcnZfaWYuYw0KPiA+IEBAIC0zMiw5ICszMiw3IEBAIGlu
dCB2ZW5jX2lmX2luaXQoc3RydWN0IG10a192Y29kZWNfZW5jX2N0eCAqY3R4LA0KPiA+IHVuc2ln
bmVkIGludCBmb3VyY2MpDQo+ID4gICAJfQ0KPiA+ICAgDQo+ID4gICAJbXRrX3ZlbmNfbG9jayhj
dHgpOw0KPiA+IC0JbXRrX3Zjb2RlY19lbmNfY2xvY2tfb24oJmN0eC0+ZGV2LT5wbSk7DQo+ID4g
ICAJcmV0ID0gY3R4LT5lbmNfaWYtPmluaXQoY3R4KTsNCj4gPiAtCW10a192Y29kZWNfZW5jX2Ns
b2NrX29mZigmY3R4LT5kZXYtPnBtKTsNCj4gPiAgIAltdGtfdmVuY191bmxvY2soY3R4KTsNCj4g
PiAgIA0KPiA+ICAgCXJldHVybiByZXQ7DQo+ID4gQEAgLTQ2LDkgKzQ0LDcgQEAgaW50IHZlbmNf
aWZfc2V0X3BhcmFtKHN0cnVjdCBtdGtfdmNvZGVjX2VuY19jdHgNCj4gPiAqY3R4LA0KPiA+ICAg
CWludCByZXQgPSAwOw0KPiA+ICAgDQo+ID4gICAJbXRrX3ZlbmNfbG9jayhjdHgpOw0KPiA+IC0J
bXRrX3Zjb2RlY19lbmNfY2xvY2tfb24oJmN0eC0+ZGV2LT5wbSk7DQo+ID4gICAJcmV0ID0gY3R4
LT5lbmNfaWYtPnNldF9wYXJhbShjdHgtPmRydl9oYW5kbGUsIHR5cGUsIGluKTsNCj4gPiAtCW10
a192Y29kZWNfZW5jX2Nsb2NrX29mZigmY3R4LT5kZXYtPnBtKTsNCj4gPiAgIAltdGtfdmVuY191
bmxvY2soY3R4KTsNCj4gPiAgIA0KPiA+ICAgCXJldHVybiByZXQ7DQo+ID4gQEAgLTY4LDEwICs2
NCwxMiBAQCBpbnQgdmVuY19pZl9lbmNvZGUoc3RydWN0IG10a192Y29kZWNfZW5jX2N0eA0KPiA+
ICpjdHgsDQo+ID4gICAJY3R4LT5kZXYtPmN1cnJfY3R4ID0gY3R4Ow0KPiA+ICAgCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJmN0eC0+ZGV2LT5pcnFsb2NrLCBmbGFncyk7DQo+ID4gICANCj4gPiAr
CW10a192Y29kZWNfZW5jX3B3X29uKCZjdHgtPmRldi0+cG0pOw0KPiA+ICAgCW10a192Y29kZWNf
ZW5jX2Nsb2NrX29uKCZjdHgtPmRldi0+cG0pOw0KPiA+ICAgCXJldCA9IGN0eC0+ZW5jX2lmLT5l
bmNvZGUoY3R4LT5kcnZfaGFuZGxlLCBvcHQsIGZybV9idWYsDQo+ID4gICAJCQkJICBic19idWYs
IHJlc3VsdCk7DQo+ID4gICAJbXRrX3Zjb2RlY19lbmNfY2xvY2tfb2ZmKCZjdHgtPmRldi0+cG0p
Ow0KPiA+ICsJbXRrX3Zjb2RlY19lbmNfcHdfb2ZmKCZjdHgtPmRldi0+cG0pOw0KPiA+ICAgDQo+
ID4gICAJc3Bpbl9sb2NrX2lycXNhdmUoJmN0eC0+ZGV2LT5pcnFsb2NrLCBmbGFncyk7DQo+ID4g
ICAJY3R4LT5kZXYtPmN1cnJfY3R4ID0gTlVMTDsNCj4gPiBAQCAtODksOSArODcsNyBAQCBpbnQg
dmVuY19pZl9kZWluaXQoc3RydWN0IG10a192Y29kZWNfZW5jX2N0eA0KPiA+ICpjdHgpDQo+ID4g
ICAJCXJldHVybiAwOw0KPiA+ICAgDQo+ID4gICAJbXRrX3ZlbmNfbG9jayhjdHgpOw0KPiA+IC0J
bXRrX3Zjb2RlY19lbmNfY2xvY2tfb24oJmN0eC0+ZGV2LT5wbSk7DQo+ID4gICAJcmV0ID0gY3R4
LT5lbmNfaWYtPmRlaW5pdChjdHgtPmRydl9oYW5kbGUpOw0KPiA+IC0JbXRrX3Zjb2RlY19lbmNf
Y2xvY2tfb2ZmKCZjdHgtPmRldi0+cG0pOw0KPiA+ICAgCW10a192ZW5jX3VubG9jayhjdHgpOw0K
PiA+ICAgDQo+ID4gICAJY3R4LT5kcnZfaGFuZGxlID0gTlVMTDsNCj4gDQo+IA0K
