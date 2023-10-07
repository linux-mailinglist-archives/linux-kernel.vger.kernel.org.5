Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7317BC3E5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 03:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjJGBtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 21:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJGBtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:49:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1433B6;
        Fri,  6 Oct 2023 18:49:42 -0700 (PDT)
X-UUID: c5044d2c64b311eea33bb35ae8d461a2-20231007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vX5X6/ugProL7a2CYeWbRJg2dAyrJrf81xZT6wz6v/s=;
        b=BNrxiFIfn98l5Wlm1Cxpts1g1+WOjlCbz84VtrBKvISwi1o4DoUitX0/QFeBd3aSt3N4CBs6VREF5ImpDaEicGsONKs05kCjm+ecyuyUhxpuIhv8lxXmmNI2/cD2UeCONYKYCPjNmLaFcweRW9P2KXusvLLmAre8DMDJNBKmnqM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:257dad40-9a67-4a8f-ba72-6e4fc5b69359,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:df2689f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c5044d2c64b311eea33bb35ae8d461a2-20231007
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1632934427; Sat, 07 Oct 2023 09:49:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 7 Oct 2023 09:49:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 7 Oct 2023 09:49:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcjXJu7jQpdZ4Cd3H/och5sbIibNWd8vy8NykJsz4khGUahvH3+/RvNyzlU5dyzRSN9fihuAHU2eosq4+0D8AhUmMhhG4RUsnZWw+8wzGeIbJZ26ReZNwjAKOYUZUldlqd6Lku+PSnudIfalbc3PzPnJsQP8IwM41gfAohX9S/NR6cVQRzmduGkMuwAO79CxmHp61CVFxWFvuDO6Ouk/CU7ipUSJDgv2FJexa94lNGb4itoNW+7ecAyN3/RWvGB/tfS1O/ur4HAkflapEAjPDeYTbo90id2ctbN3DLzwJ0JGaUsrWW5gMPuWo43tsdIan4qFnEw5fA+mSd4bE+toQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX5X6/ugProL7a2CYeWbRJg2dAyrJrf81xZT6wz6v/s=;
 b=agOzgkIOWkkfVZUa467XVXCdGbYtLl+cEl/HSdY8lmnWFQHY+U9/spztWOfH/L73LyJyXpHxeidVAEAbAV1jXtEGHGDjbd1wKuXQeb2thoiutxVXKaoPhr3Gw192t19TPXjG0bAoblkUX9WY8QfyYNblJ+ChNS/vQ4Yoa+YlGGSzpOLkoVwniWz5YBAYtyM9ADQl0khOgDbpQvDhFWvu4NPzZodkVcycIf5GUKratlf+cviM5HqcY0SO4XFKQi07AyncMrWHnqCQ1iIC1U7G13XYq6xMqi690aqn/gof1f0rd1Mmce6Nd25ayNOEVKNND6kvwRcJn74AwfhW+nCxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX5X6/ugProL7a2CYeWbRJg2dAyrJrf81xZT6wz6v/s=;
 b=uZ1Grb5nz/NuMX+fmeJyPJKPKII80/FXxaCw07s85I+vay0kV8rJuioz9GKZ+hIMj7H6MSbHQ3OJkYW5G5lTsRJzBOUQZTCTuwNuxpCazoPFZhFa0mZ6PIs6fRrSUT8VUEryg485SSsousqe/bkhNsbhL1Fu876WqMoVKIjQ5CE=
Received: from SEZPR03MB7947.apcprd03.prod.outlook.com (2603:1096:101:187::6)
 by TYZPR03MB5775.apcprd03.prod.outlook.com (2603:1096:400:89::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Sat, 7 Oct
 2023 01:49:33 +0000
Received: from SEZPR03MB7947.apcprd03.prod.outlook.com
 ([fe80::c468:315e:d2f2:c3e]) by SEZPR03MB7947.apcprd03.prod.outlook.com
 ([fe80::c468:315e:d2f2:c3e%4]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 01:49:32 +0000
From:   =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
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
Subject: Re: [PATCH 1/2] media: mediatek: vcodec: Fix encoder access NULL
 pointer
Thread-Topic: [PATCH 1/2] media: mediatek: vcodec: Fix encoder access NULL
 pointer
Thread-Index: AQHZ8GL1WluehHzAaEyDLlbMzNGOyrA2VFmAgALqHICAAbGOAIACsCcA
Date:   Sat, 7 Oct 2023 01:49:13 +0000
Message-ID: <507eec52c2d91508feacc4c24de27328477fee4b.camel@mediatek.com>
References: <20230926101909.15030-1-irui.wang@mediatek.com>
         <36356e37-9abd-4dec-a716-9822b67bd0fa@xs4all.nl>
         <54962983-fa23-4ecc-9874-f59a1387cf70@xs4all.nl>
         <ef1d5a63-6a83-46fc-b593-2d507a1ce097@xs4all.nl>
In-Reply-To: <ef1d5a63-6a83-46fc-b593-2d507a1ce097@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7947:EE_|TYZPR03MB5775:EE_
x-ms-office365-filtering-correlation-id: 188204f7-bfe8-4f21-1f0b-08dbc6d79b82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k207K1WJgutPsrOJWh7sdAakTTDx4po8LLYslV0t1PjWNB8NbUhj9OD480fzzJO0pDwPNQMogSSaXJykhEZKKZBL41LYuukqIjTHBgjvUALxelc/pnq0ssHAHXzc8BKd0GIQCPt4+rVTKPlNf60jGtuPlj8J6kWLLZJOmBRcdHX0/nVWpFN7JYpc7RBi+aLM3G5ah3y/xAa7xPBV3t2S8jMG3acEiUbRu1KjI9GwGG87QsVxFRix3QsrYsm7Hq9ZPkSgnqco5/wDu0H10az1ee/4rvB/dD4doyUVI7rekEjHDHKyuN9/VwfdBNAu2Aj8GyWyW25dbGLEDqb3VKatJpk7Eh0GdSKg9R0TJkuEXCoCaJQwg2du2szeby7O1PmsHwU7Wv3HC6nHA94UBdwiRD7LNC2WeZU1YCTFHo4DCbu+08dX6FxX2q4c/6TtoY9p1WGVlYEqSCulTdKqvCv3j0U/5N/Tv0LQbjMMGn0n95Nvs0q7HtQx/CHSztBe02zQWjMzPAPbFs5DRDqFMX/oEjFKp0Ik+5h4Kz9jqkJ9qliwCLKYVtolf1erUjJP0pfbyMFhu+QJi+BLq0VgRcMQs65jZSdnqTPQX+1ElkP1PUpDtGnBzTl9dje5HX00x0LA1jGciuA13eayKGFv/dNRkrVAwF//xlWExFa/bu+/Ngc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7947.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(6506007)(53546011)(2616005)(478600001)(6486002)(71200400001)(6666004)(83380400001)(2906002)(26005)(7416002)(64756008)(66946007)(66556008)(66476007)(66446008)(54906003)(110136005)(91956017)(76116006)(4326008)(8676002)(316002)(6636002)(8936002)(41300700001)(5660300002)(85182001)(36756003)(38100700002)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDRUbHVhMWNFN2Z1NlF2SG82K1FVc0JMbDRVcWs4LzVPQmkraGx0YnNoWVA4?=
 =?utf-8?B?MzBvUkVXN1RybEM3M0ZMMUJnM0RoMTF3Y2VHR08vRVpsRVJNaVlvbGZEVzJQ?=
 =?utf-8?B?dThKWUluWW1XeDFLeHZkM3VHOVlnUWdZT0VPSTB5MUpRSzBPTWtVM0piQjRj?=
 =?utf-8?B?bThOUDJlZnpXQ0hlSmlHdGlSeUdLMCs3RGVVekMyeE42aWR0RkRvK1cvc2o4?=
 =?utf-8?B?K2pjUEdvNWh5UG0xNGkxOHVuM1p2VnFzQngxSWQ4eHVKcEN3NlA2RG1yaGV5?=
 =?utf-8?B?ZnhuUG8zZXB2QW5DUDFIT1VTVzZTVVcrcDhCRCtuVmsydGRYYzZJSHNubjJm?=
 =?utf-8?B?QWNqZGVvMnliRkUxSVh5YVVkNzNEOVdDc04xSDBCaVBNL0xUYlZVckMxbjYw?=
 =?utf-8?B?WWpHSG9nTlNXdzhWbHdObVJNTjBSci9RcEpjcmRWRmxiUno2SWw4MFRqUlAx?=
 =?utf-8?B?T3hjTlM1RUNjOXN3c200dG1IMXpmWTJUU0tCMXBDMm1zOUtDUW5DSURCRzBm?=
 =?utf-8?B?UTUvZitxaVc3aVVnTW03OUlkUWxRR0FPaHZONkQ4Q05LdFRMSXNEeGIxd05s?=
 =?utf-8?B?d3hyMzl5emoxNlY5VzVrVUx1ZTkreHBvTmtXajRveTNmdlVNWFhIWFFZOGMz?=
 =?utf-8?B?WG12dzZRT0tINUN1NDFZRXM1dHpPekp0QTVycmNPUThFdGdsZk83TUlCb1Ro?=
 =?utf-8?B?U1hzTkpUTzA5YkZFNG5BNmtMTXRkMyt3dzI3L1hXS3luZjBRcFFXdmVOdGtv?=
 =?utf-8?B?QmorVUliRXc1UThaQTVDV21PZGFJT25PMTVsSEpLSjV6ZDFacWUvc0dTeDUr?=
 =?utf-8?B?SzJNYmRQcWs2N1oyZWNqRUpxeXpQdGtDKzJlNnZtTE1EWkxQMDVGdUQ4N3Vn?=
 =?utf-8?B?MDJodFRpa0N4ZXI5UDB2RjlXQmgzSEdiQXpWTmhBVmlFMEpSVE1vM2tuZVh5?=
 =?utf-8?B?ZjU3TlZTNDNoVTJ3YjFWQXNSbXBJNHFUa1pCcjBBbit4SjU4cVd1Wm95NVlV?=
 =?utf-8?B?UXM5aU44clFOVWpxUEVDcTRHUWZqRi90ZjFhM0NVSTdnN291U2hLN0JodEF0?=
 =?utf-8?B?U1pERFJBSk1Vb3BuU2piNUxpYTRpU05keXIvMmtPbXhKMU1tM2pqaHBRYWxT?=
 =?utf-8?B?Q3IvRWxJdDVnRUdJRTZ1SXNtS0dGdFhZZmlSUE1xQVYrcmdhZkVpaWozYmk3?=
 =?utf-8?B?aUp5K2dDNTJMZDRHU1lVODBDNGJBclFyQ1ZtWHBPRkQyMWk4ekZKbjlQV1Rj?=
 =?utf-8?B?RWZhWEFoQ3ZMUFFjTnVHdkVqYUZPVmozSFJqZnRkWUM2MzA0YkFjL3VwODJI?=
 =?utf-8?B?NG1uenVkeEd3NnVjTEFSM3JUbkxSTG5kZFovUkZTZlRrK2tBWmNxUnRjNW5p?=
 =?utf-8?B?QWkyYUh5cmpXbVcxMEZnbEFUTDdDNHFpL210SnlmTzNqQTBtMjNJZ0gwd29Y?=
 =?utf-8?B?eWIyNTJrYkxCRWcvK2RYM1FiTkRndDZtNjBNS2ZRWUNlK3k2ck1GWHZEdFM1?=
 =?utf-8?B?eWRtMXAvazdycmc0Tm5zaGlYWjFLSzJ3aDBZekVwcGs5TjBiS1FIWFZkK3pi?=
 =?utf-8?B?OGJ6cGtCa3lNMWZVblRVSlFvRXVONmcrbTV2VTczLzQ3YUNqazNqTkZPcG5r?=
 =?utf-8?B?Q0s0RTdXdWZZdjJuNEhGQTA0alVDN01ZUk1nTnAxZmM2eWY4VmdXOTVtaUdF?=
 =?utf-8?B?NVI1YURzY3ZDZDBjdDZFVU4vSExFMXlkdkdhODd5d05hL1Zaa29yQTd6VDNM?=
 =?utf-8?B?L2FEN0pZbStBc2VDaWliU2dVcHJoRS93Z1RqNmozQWJoZDVIS2lFRk8ySVgv?=
 =?utf-8?B?KzZSeFRqMGhsN2owTWt2UVlYSFN0djA5NUpvU1RJYVdoZkRoU2pnRkhjWmFk?=
 =?utf-8?B?UEZEb3kyUnlydTRNK25MMjdZR0U1bkpONWFIWDV4YTZxWWZQZDk0Tmd6ZjZr?=
 =?utf-8?B?TXptM1FvN3VJcWRSaUlmSitrdGNTOCtTTHp4Mit0dFBaZXcvbDZOMkV4T0dN?=
 =?utf-8?B?bkFaTDVtb3RkM0M1SDgweHdmZVg1OURSZ2o2alp0K2FWRlQxTUlZVjdyY3ZS?=
 =?utf-8?B?ZzRYaVJyVTBWamtYdkpWY2c4aERsWnQ2UVRnaGx1eEZlUlRVd0VCd05kWUxw?=
 =?utf-8?B?UWIwK0xqNXBYOTNraTFwVm5qeHRTTFV1Ky9YYWxHblhUT2Q4alBoOVI1aXJv?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD7C33AA272FDE49B4FB447684448AF0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7947.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188204f7-bfe8-4f21-1f0b-08dbc6d79b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 01:49:13.1753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Utv9Ak2vmmXG3sd9nt5iLE3Gomf7EWl3hTswxW6kmbomEKmqL3t/ekYVu8lqZyegGuhztOSUQ+Z9XUen4bbD/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5775
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBIYW5zLA0KDQpTb3JyeSBmb3IgbGF0ZSByZXNwb25zZSwgd2UgaGF2ZSBqdXN0IHJldHVy
bmVkIHRvIG9mZmljZSBhZnRlcg0KdmFjYXRpb24uIFllcywgaXQncyBhIGZpeCBhbmQgdGhhbmsg
eW91IHZlcnkgbXVjaCBmb3IgYWNjZXB0aW5nIGl0Lg0KDQpCZXN0IFJlZ2FyZHMNCg0KT24gVGh1
LCAyMDIzLTEwLTA1IGF0IDEwOjQ2ICswMjAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiAgT24gMDQvMTAvMjAyMyAwODo1NCwgSGFucyBWZXJrdWlsIHdyb3RlOg0KPiA+IFBp
bmchIElzIHRoaXMgYSBmaXggZm9yIDYuNiBvciBub3Q/DQo+ID4gDQo+ID4gUmVnYXJkcywNCj4g
PiANCj4gPiBIYW5zDQo+ID4gDQo+ID4gT24gMDIvMTAvMjAyMyAxMjoyNCwgSGFucyBWZXJrdWls
IHdyb3RlOg0KPiA+PiBPbiAyNi8wOS8yMDIzIDEyOjE5LCBJcnVpIFdhbmcgd3JvdGU6DQo+ID4+
PiBOZWVkIHRvIHNldCB0aGUgcHJpdmF0ZSBkYXRhIHdpdGggZW5jb2RlciBkZXZpY2UsIG9yIHdp
bGwgYWNjZXNzDQo+ID4+PiBOVUxMIHBvaW50ZXIgaW4gZW5jb2RlciBoYW5kbGVyLg0KPiA+Pj4N
Cj4gPj4+IEZpeGVzOiAxOTcyZTMyNDMxZWQgKCJtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogRml4
IHBvc3NpYmxlDQo+IGludmFsaWQgbWVtb3J5IGFjY2VzcyBmb3IgZW5jb2RlciIpDQo+ID4+Pg0K
PiA+Pj4gU2lnbmVkLW9mZi1ieTogSXJ1aSBXYW5nIDxpcnVpLndhbmdAbWVkaWF0ZWsuY29tPg0K
PiA+Pj4gLS0tDQo+ID4+PiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMv
ZW5jb2Rlci92ZW5jX3ZwdV9pZi5jIHwgMw0KPiArKy0NCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdA0K
PiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2VuY29kZXIvdmVuY192
cHVfaWYuYw0KPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2VuY29k
ZXIvdmVuY192cHVfaWYuYw0KPiA+Pj4gaW5kZXggZDI5OWNjMjk2MmE1Li5hZTYyOTBkMjhmOGUg
MTAwNjQ0DQo+ID4+PiAtLS0NCj4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zj
b2RlYy9lbmNvZGVyL3ZlbmNfdnB1X2lmLmMNCj4gPj4+ICsrKw0KPiBiL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2VuY29kZXIvdmVuY192cHVfaWYuYw0KPiA+Pj4gQEAg
LTEzOCw3ICsxMzgsOCBAQCBpbnQgdnB1X2VuY19pbml0KHN0cnVjdCB2ZW5jX3ZwdV9pbnN0ICp2
cHUpDQo+ID4+PiAgdnB1LT5jdHgtPnZwdV9pbnN0ID0gdnB1Ow0KPiA+Pj4gIA0KPiA+Pj4gIHN0
YXR1cyA9IG10a192Y29kZWNfZndfaXBpX3JlZ2lzdGVyKHZwdS0+Y3R4LT5kZXYtPmZ3X2hhbmRs
ZXIsDQo+IHZwdS0+aWQsDQo+ID4+PiAtICAgIHZwdV9lbmNfaXBpX2hhbmRsZXIsICJ2ZW5jIiwg
TlVMTCk7DQo+ID4+PiArICAgIHZwdV9lbmNfaXBpX2hhbmRsZXIsICJ2ZW5jIiwNCj4gPj4+ICsg
ICAgdnB1LT5jdHgtPmRldik7DQo+ID4+PiAgDQo+ID4+PiAgaWYgKHN0YXR1cykgew0KPiA+Pj4g
IG10a192ZW5jX2Vycih2cHUtPmN0eCwgInZwdV9pcGlfcmVnaXN0ZXIgZmFpbCAlZCIsIHN0YXR1
cyk7DQo+ID4+DQo+ID4+IElzIHRoaXMgYSBmaXggdGhhdCBzaG91bGQgZ28gdG8gNi42Pw0KPiAN
Cj4gVGhpcyBsb29rcyBsaWtlIGEgcmVhbCBidWcsIHNvIEknbGwgcXVldWUgdGhpcyB1cCBmb3Ig
Ni42Lg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCg==
