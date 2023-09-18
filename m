Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5943D7A4573
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjIRJFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbjIRJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:05:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43F311F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:05:11 -0700 (PDT)
X-UUID: 76c5b1c4560211eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=apfj1LjM4ylc/h9BjwreBRozRvGZl/vi+Ne/WuXljO0=;
        b=FuvJjGZzUOmfOH5PTxCtBrFqIpqZyE69lGSEsvuvsEniEc0D/vPBaDX6ZNKdTTu3F1h73OV4tPCyWET/o+7GSF2PS8G7dftZpAZ3TToiht9rp1q78+Z6sr4UrJ7G3HxMx/jx1+i0Mh1PGycOKTeMLoRcA3AFBXWx/GfReucBcLI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:d70e26bc-8d33-4b8f-9736-8c5f7a12ea70,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:32dcf6be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 76c5b1c4560211eea33bb35ae8d461a2-20230918
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1559298147; Mon, 18 Sep 2023 17:05:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 17:05:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 17:05:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoB8lpSoXIhHQ5LnkYlBCS3luYpNF/WXss8py+EJijKjTqguTPu96CQAVvB6AZrouOnUthpeOdmA7Kn+lNeyEocDBw4jdzgU3VLRs6dHjvtNPSlKTHPCoHBLdfZ5ZvOfkR5yKbFRu+i8y8E0jy/Gw9SP5eTLP3iZ1qwTmj+XTGxLzcMQ7pJ/hIVabiZmM5eIiPMOapzia+6OaaxXvKJ2OFOZHLxM6SMU3RQoFYAFPhMxhAt8bPNtyipQn3SIwJlUNz5V6+Brm/dL1huYb9jfPBqILrRuKI5frRxPKcbVajYDlo8afHAuGfTbPIvPhyCXehMpnhTo8PQFgiM1+bFEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apfj1LjM4ylc/h9BjwreBRozRvGZl/vi+Ne/WuXljO0=;
 b=YRbtbOIxLYeZRHbF/JDkaeNQv+rdzh+qy8PAWtmKu3FlXHx9OepAf/wL5vr6s8xiX0pMUgiMMy8ZodDtRMBC9OG6zkjFC43hkU7Kx/iGTCaF35sE3tJV3iIwHTcy86fMS16HQmbE9Cetaay/okNaVqW4Ir/DvgUO56QSBlYffUmDNvwajrNqZ1fwCYvGl+RRLo45FU60k32GFUZatoDcGZ51LFSVIW8OV7h+ilbHJksEuV1dOUHklb/sRkIuCcRYknL76TK5dm7RsT2rkShak8PXEmWMpbD8hD4vWHknuMXv88ubQX2Tb1hsnZs9URwJSO4WcLxV5vfC51eXt4rROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apfj1LjM4ylc/h9BjwreBRozRvGZl/vi+Ne/WuXljO0=;
 b=MDVXdQ2celgD/Re+YCHa+n1d7gkCK3Xb0whiysmHn5NFh5zxetB6IMWYo7dI0Ly20nmk8lWqeOauiuHuTUeSwDywa7CUwUKYYxaga/hdHijdi7EFn4+sVaBdHF6c8bCKklQuGwMGgB8C7L6lj4f0VaSuWKa33hw/r5+xUBxO8NA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB7187.apcprd03.prod.outlook.com (2603:1096:301:11c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 09:05:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 09:05:03 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 05/11] drm/mediatek: Adjust DRM mode configs for IGT
Thread-Topic: [PATCH v2 05/11] drm/mediatek: Adjust DRM mode configs for IGT
Thread-Index: AQHZ6gwdAKw8l8Q7D0OBc3eBlFbcQ7AgSlOA
Date:   Mon, 18 Sep 2023 09:05:03 +0000
Message-ID: <d46f652fc9fde61d7e88bfeace62f27847d55d40.camel@mediatek.com>
References: <20230918084207.23604-1-shawn.sung@mediatek.com>
         <20230918084207.23604-6-shawn.sung@mediatek.com>
In-Reply-To: <20230918084207.23604-6-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB7187:EE_
x-ms-office365-filtering-correlation-id: d77bc8e5-a9aa-4368-17ec-08dbb82658aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CuQndbZn+Gg8YUJhwB0zLIijvgxU/ThbgHs0ADIBl2VfIOh593RvOkTxbI/4SooZbm6qSuT4wrmpv14XOBKGG6sb4/2xYSHUxn2y0mSYaW7P4X6Zz7EuTiQ3BMRLr1A9O4xSNSTXODuHIJ5ShbnslBPj2y10+LldwTXVKDZYsV9pdDJNDPitZASn/wluzvbxCRMVIwbrMwxV5UpZUFhje6ygjtIZH2rW6WW+ZB1o3GFnHG/8/ITyYfxraEBIppK3BEjW0DcRrmfObDD0/B3h7kEW6jhvWEsmQT28M+wUW953WnjvpMAAZrMDENuyF+FtGYh0JpM4sCLJWeEG+xL2CSkmOiahbbR3euThbIq0d0vfJ2kkUrALJ0AzyWBkKGPzI0pEH5tNXjJpOYfb/iXBogtHAJybu+GaQ5tqzOopmggiwOPgQEzOvJN9m7da7SsEsq3f2aVlhqn3Vu7XipNfTWKyTsFGKBYWRwJQ41EGSyuQ5QsRDThljgTPA1J2DPCF+qUeOukVuEc2iTJj4Wz36kSEV/jr5T1sJU1zIlaSckw9G6HsoRCGz6M+ixdcnfB515tertC+3FW8r/GaYK0FCftxDZXyUF1Wr8mZDq5/NIQg5Wo/ITzEHRCJdPev+GMoG06UzVY6XvPry5YVpRZTCa99nd8UAMVjVGWcHLbt5gs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(1800799009)(186009)(451199024)(122000001)(85182001)(36756003)(38100700002)(86362001)(38070700005)(6486002)(6506007)(478600001)(66476007)(64756008)(5660300002)(54906003)(66556008)(66446008)(76116006)(66946007)(2906002)(8676002)(4326008)(8936002)(6512007)(83380400001)(41300700001)(7416002)(110136005)(71200400001)(316002)(26005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU1kRjRBdWJZVkZWcG1TZGwzTTA5N1N3a2NXcnc1ZFBtaGpiVWdkeHRlOG1O?=
 =?utf-8?B?QnEwY0NZekdOZkJKcVB5THZBdXV0Q0tUNGZFVWVvcWFiRmZQbnlHVVk4Zm5v?=
 =?utf-8?B?SEowWWtadjVtc0FlZFNodVdOVElxVlY3clNxcHREeTN2VWl4TTkvVCtFOHFs?=
 =?utf-8?B?c0hvcktmQ2ozTVZDaS9pRzdwMDJzZS9SZnB4UkdIMDQwQlZ5c3hSY2JmSXVk?=
 =?utf-8?B?SVJYVExVTUZvK0lnNWxjTmhadTJCZDFHTzVkNkJweGdieHQ1OWI5aDR5VFc3?=
 =?utf-8?B?aEZWaFp4UzNCZTFpSlhQRStRazRUcUxhMndGMFhBQm1ZMUdrWXVsK2VIL25J?=
 =?utf-8?B?OGFwa0x0SjdNVUxhckt3anJ5RlRwODh5M1FOTkNWaVdTZWFRbmMrc0dBVERE?=
 =?utf-8?B?SXBMZWFQSGUvdjFxUGg4Z3dmYVBwRFo4MDhGTWExYm93RUtQMk1nZElmRHRZ?=
 =?utf-8?B?RlVMeFJpN0UraFdYd2NXNHBDMHVFeGhYUVNOTzNuYnZqVVliVHJYTjlISGh3?=
 =?utf-8?B?Z0IwS21wKzBZZnRid2RTSk9rbFBaYkhlcjkwcXIzTkFMYmx4VUMxMEhMUWhz?=
 =?utf-8?B?Y2ZBY0JBWUVXYTl6SGpqcUE0SWRYYzVTamhxOE9jd2pjNEsyMlNncVVzY3Va?=
 =?utf-8?B?NmdhUXQ3cldLbFlhb2UvN09vQVp2Q0pmdzZlOUNuZ25mUHl6aERnZ2RiZnFS?=
 =?utf-8?B?SnBiTlZ0N1RVQ1VtYmtiQlNUOW55ZEdqcFN0K3Rod21NWkNIa0RUMUVmanNt?=
 =?utf-8?B?THpKMWVRRVk1dmxwYUsxb3A0Q21KVE5FY3dDME9ldGExelJ6dHlLRnZHRW92?=
 =?utf-8?B?SnVKajAzZEtZbnZMcVo0RkRwYThNRjFPOW0weU51SU04Nm45NUlRU0lyNFZ4?=
 =?utf-8?B?NjBpV3lMenlWc2xiRmt5VXJ4UytENW9pYnpaUlZTTVAzb2x5RmJmZGRGam9w?=
 =?utf-8?B?YzZQZUxVTjdZazR1ZTN0amQvakRyRmxRNTlJaC8wWlVncUxXMzV2czI0UlF3?=
 =?utf-8?B?VFlodHhjVmlxY0hBRlRpMTNMN2o1bjhvWk5mZUhBdm9ZWUtzUElrWmNYT3M4?=
 =?utf-8?B?OG81WGpNRHFwOWQ2UE1sMUhGQzhXUU9VMWUzRXhHeVErekk2K0xpVDNkbDk2?=
 =?utf-8?B?SzdZY1JqMkNuUE9JanlaRSs5eGdFdTZIUjh4MkQrZm9GdzBGQzY4clZWN0gw?=
 =?utf-8?B?T2J5QURua3JBVVlvWE5vendHUU01UjVrZElUb2hRVTRWWkQ0aXNMa0NXTlNs?=
 =?utf-8?B?ZXRTdk0rZktHQVlqNjByTSsvU29aOFd0aTJkSDFIWlRoWGJPanl6R2Q3VlJq?=
 =?utf-8?B?ZDc5Qmlhc09qMTd3S05STUR5VWEyVzAwVlVLYXFvZm9oQWZqeHRZMmdFMVhS?=
 =?utf-8?B?Sks5eWRCVWF1ZFoxQS9DQjdsRjBndlN0RGNEM1BNbzdRaGJYOWdTUnNDS3l4?=
 =?utf-8?B?TVNhQVgrSXZMSWt3Zm1YS2paU1BqYkJpcm56K014dk8zV09FUVdqSXZpUnZj?=
 =?utf-8?B?Qm84bW91b3U3cGd0dzJKTndUSGJpR3dSZ3V0OWJpTFZLZHNxMmZsT01VcDBi?=
 =?utf-8?B?SXJWQmdzblNncTFZQ0lZQ0t3KzNCUlc5MGRYOVhvWEVyaTQzTVFXekdzc0tU?=
 =?utf-8?B?SzFzYnhyNjk3akltczdwUVJ1Q0FsWnJtZ1VDTFhZU2pPR0U5aERBeFRyMzFi?=
 =?utf-8?B?Sk4xVWg2eDdTcy9JWU5GcEc2SVFMSHZFU1B6WXBteG55ai9Vek1Jb3FOOE1R?=
 =?utf-8?B?cTQyVXpNdmJ2bG1nbmpOSWVMNndQVFJFaXNvcWxaaW1DZlQvWWZsWkNnV0JQ?=
 =?utf-8?B?cVprY3EveGhFdVNyeVY2MFpJaEt0YmhPNUY2ZGF1OXBHOCszOVU5V2MxNVRP?=
 =?utf-8?B?S1NJN09oRkVnVHEzb3FhVEpKblhCUWsrbC80NVdsNVQ2YStqUUlJTlMxYS9Y?=
 =?utf-8?B?VXJRMVN2dFVOWXB3MXBKcE5hdkU1cDcvS0dLYURLdFpDZXZ2dUptbFoxcHJ0?=
 =?utf-8?B?ZGxFY3Y2NUdJNzBJdTNmMjZJaXh4YXh1djc3VkRubi9aKzAvS0VFRTd3MWh3?=
 =?utf-8?B?ZklJM3ZBaXdTQ3dpV1Y2b3pjbTZ2NlBIbmVWc1ovRkl1WmI0MWtoYVVqVUJ5?=
 =?utf-8?B?MW5ydDVpd1Naa2V2b0VxN0tSZWZxR3JLVEpyZnF0VVkvdFlSQmN2aWRBL2N4?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E619038300C7F3448CD173AB30693101@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77bc8e5-a9aa-4368-17ec-08dbb82658aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 09:05:03.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtLH8OKyarsygOHV4f+aHGapZNZAwUVsbW2XzIE985HfzinlIGHPYTXkgVXjfarBENtidtL3mcJtee60lMuOyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMDktMTggYXQgMTY6NDIgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IElHVCAoSW50ZWwgR1BVIFRvb2wpIGNvdWxkIGNvbW1p
dCB0aGUgZm9sbG93aW5nIHBsYW5lcw0KPiBkdXJpbmcgdGhlIHRlc3Q6DQo+IA0KPiBrbXNfcGxh
bmU6DQo+IA0KPiBUaGUgc3ViLXRlc3RzIHBpeGVsLWZvcm1hdC0qIHdpbGwgY3JlYXRlIHBsYW5l
cyB3aXRoDQo+IHNpemUgb2YgMSBvciA0NTEyIHBpeGVscywgdGhlc2Ugc2l6ZSB3aWxsIGJlIHJl
amVjdGVkDQo+IGJ5IHRoZSBvcmlnaW5hbCBtb2RlIGNvbmZpZ3MuDQo+IEFkanVzdCBtaW5pbXVt
IGFuZCBtYXhpbXVtIHZhbHVlIG9mIGJvdGggcGxhbmUgd2lkdGgNCj4gYW5kIGhlaWdodC4NCj4g
DQo+IGttc19jdXJzb3JfY3JjOg0KPiANCj4gSWYgY3Vyc29yX3dpZHRoIGFuZCBjdXJzb3JfaGVp
Z2h0IGlzIG5vdCBkZWZpbmVkLA0KPiBJR1QgdXNlcyBtaW5fd2lkdGggYW5kIG1pbl9oZWlnaHQg
YXMgdGhlIGxpbWl0YXRpb24NCj4gd2hlbiBjcmVhdGluZyBjdXJzb3IgcGxhbmUgc28gc3ViLXRl
c3RzIGxpa2UNCj4gY3Vyc29yLXJhcGlkLW1vdmVtZW50IHdpbGwgYmUgc2tpcHBlZC4NCj4gU2V0
IGN1cnNvcl93aWR0aCBhbmQgY3Vyc29yX2hlaWdodCB0byA1MTIgcGl4ZWwgY2FuDQo+IHNvbHZl
IHRoZSBwcm9ibGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hh
d24uc3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZHJ2LmMgfCAxMCArKysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZHJ2LmMNCj4gaW5kZXggNzc1OWEwNmU1YzBlLi42MjU4MWIyYTQ3MGIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IEBAIC00MjksMTYgKzQy
OSwxOCBAQCBzdGF0aWMgaW50IG10a19kcm1fa21zX2luaXQoc3RydWN0IGRybV9kZXZpY2UNCj4g
KmRybSkNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIHB1dF9tdXRleF9kZXY7DQo+ICANCj4gLQlk
cm0tPm1vZGVfY29uZmlnLm1pbl93aWR0aCA9IDY0Ow0KPiAtCWRybS0+bW9kZV9jb25maWcubWlu
X2hlaWdodCA9IDY0Ow0KPiArCWRybS0+bW9kZV9jb25maWcubWluX3dpZHRoID0gMTsNCj4gKwlk
cm0tPm1vZGVfY29uZmlnLm1pbl9oZWlnaHQgPSAxOw0KPiAgDQo+ICAJLyoNCj4gIAkgKiBzZXQg
bWF4IHdpZHRoIGFuZCBoZWlnaHQgYXMgZGVmYXVsdCB2YWx1ZSg0MDk2eDQwOTYpLg0KPiAgCSAq
IHRoaXMgdmFsdWUgd291bGQgYmUgdXNlZCB0byBjaGVjayBmcmFtZWJ1ZmZlciBzaXplDQo+IGxp
bWl0YXRpb24NCj4gIAkgKiBhdCBkcm1fbW9kZV9hZGRmYigpLg0KPiAgCSAqLw0KPiAtCWRybS0+
bW9kZV9jb25maWcubWF4X3dpZHRoID0gNDA5NjsNCj4gLQlkcm0tPm1vZGVfY29uZmlnLm1heF9o
ZWlnaHQgPSA0MDk2Ow0KPiArCWRybS0+bW9kZV9jb25maWcubWF4X3dpZHRoID0gODE5MTsNCj4g
Kwlkcm0tPm1vZGVfY29uZmlnLm1heF9oZWlnaHQgPSA4MTkxOw0KPiArCWRybS0+bW9kZV9jb25m
aWcuY3Vyc29yX3dpZHRoID0gNTEyOw0KPiArCWRybS0+bW9kZV9jb25maWcuY3Vyc29yX2hlaWdo
dCA9IDUxMjsNCg0KQWxsIHRoZSBzZXR0aW5nIGRlcGVuZCBvbiB0aGUgaGFyZHdhcmUgbGltaXRh
dGlvbi4gVGhpcyBkcml2ZXIgc3VwcG9ydA0KbXQ4MTczLCBtdDgxODMsIC4uLi4gUGxlYXNlIG1h
a2Ugc3VyZSBhbGwgU29DIHN1cHBvcnQgdGhpcw0KbW9kaWZpY2F0aW9uLiBPciB5b3UganVzdCBt
b2RpZnkgdGhpcyBmb3IgdGhlIFNvQyB5b3UgaGF2ZSB0ZXN0Lg0KDQpJIGRvIG5vdCBsaWtlIHRo
ZSB0aXRsZSBtZW50aW9uIGFib3V0IElHVC4gSSB0aGluayB0aGlzIHRpdGxlIHNob3VsZCBiZQ0K
ImFsaWduIG1vZGVfY29uZmlnIHRvIGhhcmR3YXJlIGxpbWl0YXRpb24iLg0KDQpSZWdhcmRzLA0K
Q0sNCg0KPiAgCWRybS0+bW9kZV9jb25maWcuZnVuY3MgPSAmbXRrX2RybV9tb2RlX2NvbmZpZ19m
dW5jczsNCj4gIAlkcm0tPm1vZGVfY29uZmlnLmhlbHBlcl9wcml2YXRlID0gJm10a19kcm1fbW9k
ZV9jb25maWdfaGVscGVyczsNCj4gIA0K
