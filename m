Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDB07E19E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjKFGHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKFGHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:07:03 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADCDFA;
        Sun,  5 Nov 2023 22:06:59 -0800 (PST)
X-UUID: ae14604c7c6a11eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2XVaUrfhOBitiyFwbJIr/jZmqWdyctsu1n/b/JIHn7Q=;
        b=tH1yejyZG6Eskf5PbjSIOagTcGe/GLwJXOt+BTcyO3/7qR198FuMPf5Vtav1NJyfEhee6HI4DI+pLoSq05jINumQzOZsq7EW9Ho8o/bFBXfpn/U5bXeO7uM5k02ie3WbpuiiG5+wwBFtsijVOvjUXqhBSlhbgzOvHGUr7/5j8I0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:3c2bc500-6eb6-4b8f-959e-e432701ae0f6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:08fd0d95-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ae14604c7c6a11eea33bb35ae8d461a2-20231106
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <chris.feng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1178621896; Mon, 06 Nov 2023 14:06:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 14:06:51 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 14:06:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLJBDUOxLEmQUFFTqzZ8dZnTnRFbj62tJXlcNfQJgmJbQto8CTe8Z2rG33K8fsHpVJ9jmtRD/MQhTe5d2qE7PYnYnYrrRKiLAI7XxEWatP9V/qt4GCHthE2/DPVnUdb+hNqrLXL/TBbaLe9qVkCbbfmQnM12CkiFTifYerqnNC1gexnxbXrapKqTshpU7kuqtIlhNUafRfpahX42GwHDhlcury3f2Qt5VxxpLCh/qvLEpST0TQLXLoYOdOlIbUYI/jYfnSXWBMy0Edq1D71vfEx/MCy4IjnZyc1PxVbbiYZ/ksCtJ0z5RKvAaB9ajbG/Fv+MON3ryY7fk+RSL7WdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XVaUrfhOBitiyFwbJIr/jZmqWdyctsu1n/b/JIHn7Q=;
 b=NWFTvnb1FFlXtEAanD8pqdHSLq12kORDf15NOMurTcz05Cs7w+HC2hwQsLnWuS9BvnLh8XPaMAQH3eMDUSps3q7IhlBrqXbSJu3InwRAwdHcAc1JLjKEkNICzQUkhVDHjRiToQsCWjm7GRhybUdOSxu+8i6wx5JJh4Mfn54qYFBerkfgIhYNyU4ESra9owtZ+0HPgassgI7dxMp6o/qtJ7zg08iVK50kRfjba+Ek9cNW8N+4DGieuwDMC5tKPjEJ6CE8IfUKgwc6DOCqXzNPmsT63viWiSwZW7RUgyAfdWf6CqVAB75/pR/SklV6afnaCFyBlAIiD90o1mLT4RMeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XVaUrfhOBitiyFwbJIr/jZmqWdyctsu1n/b/JIHn7Q=;
 b=beedqXGHIwf8JJge7pQ2g4z6I9XCo07qL4Pi9J58BOqKMIDLHVeYXe3WIB5Dk+vsQEbOTwAMbkUUBA0Y6E43xV+9ZwXjIbiH288wKk2y6+WfNNUl3teMlh0D/aCFxzPKlu+lUgL25OFXCERsSS+STFQ3whqRAYvyGZEMVbAo1nc=
Received: from SEYPR03MB6433.apcprd03.prod.outlook.com (2603:1096:101:3d::14)
 by PUZPR03MB5822.apcprd03.prod.outlook.com (2603:1096:301:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 06:06:35 +0000
Received: from SEYPR03MB6433.apcprd03.prod.outlook.com
 ([fe80::4a29:15d:a1d8:8add]) by SEYPR03MB6433.apcprd03.prod.outlook.com
 ([fe80::4a29:15d:a1d8:8add%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 06:06:35 +0000
From:   =?utf-8?B?Q2hyaXMgRmVuZyAo5Yav5L+d5p6XKQ==?= 
        <Chris.Feng@mediatek.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        =?utf-8?B?SHVhIFlhbmcgKOadqOWNjik=?= <Hua.Yang@mediatek.com>,
        =?utf-8?B?TGlhbmcgTHUgKOWQleS6rik=?= <liang.lu@mediatek.com>,
        =?utf-8?B?VGluZyBXYW5nICjnjovmjLop?= <ting.wang@mediatek.com>,
        "len.brown@intel.com" <len.brown@intel.com>
Subject: Re: [PATCH] PM: hibernate: Fix the bug where wake events cannot wake
 system during hibernation
Thread-Topic: [PATCH] PM: hibernate: Fix the bug where wake events cannot wake
 system during hibernation
Thread-Index: AQHaBlqs2FcXGYka+UCcrtjn8n/dNLBa1UEAgAJJI4CAD8OtAA==
Date:   Mon, 6 Nov 2023 06:06:35 +0000
Message-ID: <648b79eea9f1853f801e61f7c974871bb1bb47b6.camel@mediatek.com>
References: <20231024091447.108072-1-chris.feng@mediatek.com>
         <CAJZ5v0iLCsiPncA1t7ogtpch9gjGjzjtDU6G5E+PHB8ZCHgY0A@mail.gmail.com>
         <2b470a20496a0e181078b0e18774e9348c7ffae8.camel@mediatek.com>
In-Reply-To: <2b470a20496a0e181078b0e18774e9348c7ffae8.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6433:EE_|PUZPR03MB5822:EE_
x-ms-office365-filtering-correlation-id: 0a5c4da1-0f6f-45bf-a7a6-08dbde8e8815
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4k0GzXuowsBYQ0iMnmrBIr5QeWmoj2aL71c2kfEEBlA0aycNX/WqxQrDh4HqIhE0UeE567P1zy67CErDc3A2UEib4Z+U7gI+vxcFOZmhLXfv9o0o4schtkkU6GWMMevYwjVIZV3YZhRC6bipcDuBpZjAHv0VYttkXuGqzEevwa/BgaZ1zXUe4ys4Fviqe2DLl0xMSRe+BoRPHZAKNIQ4hbD0OFxa7LY3M43KTTkPebLWTxABSHBqwf8rzlGA3WVWaZDO4V92oGQD18xch5j/RnzpT13PJ6h1sdU3XN2F7bG+ntu9xMjN+328rYcyOQQI5EpJayhV2o3ZEKY1+ZCOHquwH6ag1Uh71eMrI1ES0dRejzJro+VXpr3dVHH3SQuiyV2gWc3urxw2loWfhhMRre40H//1A26E5Fbqbf2MPrPDu8h2Uh0L/YFpL0qu0iSmev6Avnl9GaeQXZ/8VBoXIU5nfRj9BzbHHpXAmZVT5G1Y7ljiZJqbKflXjg548vY7b1AhzhPP4PaT5wXysohXIcBXsIsvNP3PNv/+1L/f7NK7U+A6QWGavFk6Gu21v+fQR60IU00A+mcU/zfLBXX+50FZ0yoP+U+k10Qmp0gnjKjkE98IYy3DSO3mLsyovQiFQAQ1FeQrT/kb5GKCPNHnxtATQz6kNFyKX3qN43c8BhA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6433.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(2616005)(6486002)(53546011)(6512007)(71200400001)(478600001)(6506007)(83380400001)(26005)(66556008)(66946007)(4001150100001)(5660300002)(54906003)(66476007)(41300700001)(64756008)(66446008)(316002)(6916009)(91956017)(8676002)(4326008)(8936002)(76116006)(38070700009)(36756003)(38100700002)(85182001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUZCUzdpZmwzOXdVL3lNbStLWDh5ZDUweVltWWFVSzBFL3VwQ1NYLy9mVk1R?=
 =?utf-8?B?M0JsakZCS2lYazM0ZjhyUkkyN0V2SnBjYytiOWVjTlFiTmVhSW5pNmIwQWJh?=
 =?utf-8?B?VmdqeUhlWWlPWjRKcjh3ZXUyN0FzdjRSWDNkSzBNUjlOdk5ESExJRExmK1hz?=
 =?utf-8?B?REwwWUhPU25ydjRNNWhBb1JGUW02VW4rWkRjZmpkV09oTUM3VmVjbnNVbitn?=
 =?utf-8?B?bTExU1RWemYvVTZ2eWpNNjJJcGwrajR3ejZoMjJqWUpyTFlxOHBLbDZ1N3Rj?=
 =?utf-8?B?RFhabmRZaUtUOGcvQjJDalNibnh6UE9leFhhc2hmd3FkRU1hZGdzZHlwSnh2?=
 =?utf-8?B?cXZsRUp4Nkc3dmg2SE43ZzFaOU9wNmpCK0pLSTZvVXdHem1udGFBenk1ZDFH?=
 =?utf-8?B?WFUvemhUQUhnL25oRzBnd0VLZlphUnpYN09MbWFQbTBPcGhia3N2Uk5wM001?=
 =?utf-8?B?eTF3a2dyQ3QyUDRGZWtDZk13QzZ5LzZLQXBjcnRSbjBMNnhwbHVXR2NyanhM?=
 =?utf-8?B?UWxqN3NoRlRrNVlMMTQ3UFlkaS93aDZhMEpMNWh4c25HRVJlTW5rZE5JaEIx?=
 =?utf-8?B?UXQ5bzdmVlhiY1VGc0NlYmJpZFgzbHZsVkVPZlNTNmtpUEYrL1ZxNVhucWpp?=
 =?utf-8?B?d2RHOWR5T2FZY2Z3SnFyVStCOUNPTVAzZWg2T01iMmxrUzlaRTFlUkJVL3l4?=
 =?utf-8?B?bnkyUE4zZzJWQWNuczJHZE54YkphbGJ5QzU2MEtCaExzK0piNktFcnJEZFU4?=
 =?utf-8?B?M01vdHNhU0lOTitYQUhVcTdUcS9wL3ZZeEp2TzRuWTNwdGl1UjFwOGFNczdE?=
 =?utf-8?B?aFBWUDR3dm94S1VVdFlPZEhaamF3dXR0SXZWemFIdVVHa25FbEdPcXU2cjQy?=
 =?utf-8?B?ZVRUNUNMRVN5RytKTWdnRGcvdm9IQmdqMWpTd3BnbVJaakNFY2lVdm1lOUE4?=
 =?utf-8?B?WWN3ZDVCYmhIbkRxTWVNWUovV09xWlU4R1B5MDhZaWd3WVJHTnFKNXBpWmV2?=
 =?utf-8?B?RVZiWWNheG8vUWVHYlEvYWZ5YmNiM2pBSHFyNVd3d2RGMVFVeHlkNlFyWXdm?=
 =?utf-8?B?RzZKUlk5WHBURXVWZ2tWRlB6WDAyTzdRa2VKYkNJNms3Y1Ria3U3cU41SUtm?=
 =?utf-8?B?WVIrWG9VRkJEMDlZSng0UEx5MWFIdC9HVzVGb25iUThGVFI5cVBXR0NHdFZ2?=
 =?utf-8?B?KzY3U3RSbE5ZcUxjSmNnNEhuTkN5L1NWRGpJbzhETVcrQTBZV2Nvd2VYdDRN?=
 =?utf-8?B?U0YwbG41YUJWeWVZQXJlK3FNQzlaelJZYmwwYUlWdGR3Zy85L0VPekhRZk80?=
 =?utf-8?B?SW1SV2l6MEV2QzhQd2t6R1NCWnNxUXRSZE9WZ0kycm53ZXkxMTRXNWVkM21N?=
 =?utf-8?B?T2ppanhLQlpKazRsdmVTZnZEMlIxRURMWCtZNGFtV3Q3Smdzeld4K1duNEdT?=
 =?utf-8?B?R1ZlWE9rSE5pOVFDNGNRNnIwYjhGZjdtNUs4b0xvcURPRFI2OE1TZkpad2ph?=
 =?utf-8?B?ZUlKWm5aWUlyZjk2QURMQnIzQUVBYS9haUJNOTRpUEgwdkdObnFvQ0N5OFVK?=
 =?utf-8?B?dWxFQVMra2hsaklVa3N4U25YandQcnJWUWdnTVNoM0hoQWRQL1JVajlxUFJW?=
 =?utf-8?B?djJncFJBVnllRFhrR1Rybm9hdko2YTVWZ093OHFkNHMwUld4cStkQklBNm1X?=
 =?utf-8?B?cFlLZWVzOGF4ZVN1MUNIcG5oaEd6WWFDS1VVcW1qd3VJN1RvVjI0TGtCN0FP?=
 =?utf-8?B?Nys5ejdFNWEvMklGQUVCL1BUWVhtZ0JNOGRJQkxVd2JjRWkycy94M3p1R2xx?=
 =?utf-8?B?Q2hMY3Y0czJkM0w1YmVjVDltbUZ4WHduSlJHQUNyemRTbjg3WWdVOGtCbmUv?=
 =?utf-8?B?OGpLUFRpMkRXc2p5ZXYrL2U4ZzlLRU9ObUVSbHBtODMydGNCTWJWSUFlZjlm?=
 =?utf-8?B?Szl2OWNUTnB2RWFoMmlHY3RkcitEcnBHYkdBNWFzQ21ZUFRsdEVEQy91WkFv?=
 =?utf-8?B?THk4Nk8razVHa3Q1SmFYbERqRm1RY3pxczhyQTcyOVBEbHB0U2pYSVowb1Rs?=
 =?utf-8?B?TDRHZXVyQkZ3MnlkSUg4SzI1N0lHbzVaQWNYZUJQbisxL3JnK0cwK1NFYTlK?=
 =?utf-8?B?ck51dHpBTlpZNWUzSm9GczVRcGVmRkh3QmVSNWl3MGRFN2l3TGFuUEFNOXA0?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCD6FD2C6E237C47899826B865DF7844@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6433.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5c4da1-0f6f-45bf-a7a6-08dbde8e8815
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 06:06:35.2475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zToo/c9m57AVcBJzf/dTKwqGRYzQsPcZLvgXQX0ojKF9weHEE2a1onuGZwDBEijH6u2X4o0HlSON9OEujtfBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFmYWVsIEosDQoNCk9uIEZyaSwgMjAyMy0xMC0yNyBhdCAxMzoyMiArMDgwMCwgQ2hyaXMg
RmVuZyB3cm90ZToNCj4gT24gV2VkLCAyMDIzLTEwLTI1IGF0IDIwOjI4ICswMjAwLCBSYWZhZWwg
Si4gV3lzb2NraSB3cm90ZToNCj4gPiBPbiBUdWUsIE9jdCAyNCwgMjAyMyBhdCAxMToxNeKAr0FN
IDxjaHJpcy5mZW5nQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IC0tLQ0KPiA+
ID4gIGtlcm5lbC9wb3dlci9oaWJlcm5hdGUuYyB8IDEwICsrKysrKysrLS0NCj4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4g
PiBkaWZmIC0tZ2l0IGEva2VybmVsL3Bvd2VyL2hpYmVybmF0ZS5jIGIva2VybmVsL3Bvd2VyL2hp
YmVybmF0ZS5jDQo+ID4gPiBpbmRleCA4ZDM1YjlmOWFhYTMuLjE2ZDgwMjdhMTk1ZCAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2tlcm5lbC9wb3dlci9oaWJlcm5hdGUuYw0KPiA+ID4gKysrIGIva2VybmVs
L3Bvd2VyL2hpYmVybmF0ZS5jDQo+ID4gPiBAQCAtNjQyLDkgKzY0Miw5IEBAIGludCBoaWJlcm5h
dGlvbl9wbGF0Zm9ybV9lbnRlcih2b2lkKQ0KPiA+ID4gICAqLw0KPiA+ID4gIHN0YXRpYyB2b2lk
IHBvd2VyX2Rvd24odm9pZCkNCj4gPiA+ICB7DQo+ID4gPiAtI2lmZGVmIENPTkZJR19TVVNQRU5E
DQo+ID4gPiAgICAgICAgIGludCBlcnJvcjsNCj4gPiA+IA0KPiA+ID4gKyNpZmRlZiBDT05GSUdf
U1VTUEVORA0KPiA+ID4gICAgICAgICBpZiAoaGliZXJuYXRpb25fbW9kZSA9PSBISUJFUk5BVElP
Tl9TVVNQRU5EKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgZXJyb3IgPQ0KPiA+IA0KPiA+IHN1
c3BlbmRfZGV2aWNlc19hbmRfZW50ZXIobWVtX3NsZWVwX2N1cnJlbnQpOw0KPiA+ID4gICAgICAg
ICAgICAgICAgIGlmIChlcnJvcikgew0KPiA+ID4gQEAgLTY2Nyw3ICs2NjcsMTMgQEAgc3RhdGlj
IHZvaWQgcG93ZXJfZG93bih2b2lkKQ0KPiA+ID4gICAgICAgICAgICAgICAgIGtlcm5lbF9yZXN0
YXJ0KE5VTEwpOw0KPiA+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gICAgICAgICBj
YXNlIEhJQkVSTkFUSU9OX1BMQVRGT1JNOg0KPiA+ID4gLSAgICAgICAgICAgICAgIGhpYmVybmF0
aW9uX3BsYXRmb3JtX2VudGVyKCk7DQo+ID4gPiArICAgICAgICAgICAgICAgZXJyb3IgPSBoaWJl
cm5hdGlvbl9wbGF0Zm9ybV9lbnRlcigpOw0KPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChlcnJv
cikgew0KPiA+IA0KPiA+IFRoaXMgZXJyb3IgbmVlZCBub3QgYmUgLUVBR0FJTiB3aGljaCBtZWFu
cyBwZW5kaW5nIHdha2V1cC4gIFRoZXJlDQo+ID4gYXJlDQo+ID4gb3RoZXIgZXJyb3JzIHRoYXQg
Y2FuIGJlIHJldHVybmVkIGZvciB3aGljaCB0aGUgZmFsbGJhY2sgdG8NCj4gPiBzaHV0ZG93bg0K
PiA+IGlzIHN0aWxsIGRlc2lyYWJsZS4NCj4gPiANCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBj
b21tZW50cy4gSSBoYXZlIHNvbWUgcXVlc3Rpb25zOg0KPiBJbiBmdW5jdGlvbiBoaWJlcm5hdGlv
bl9wbGF0Zm9ybV9lbnRlcigpLCBpZiBmdW5jdGlvbg0KPiBkcG1fc3VzcGVuZF9zdGFydC9lbmQg
cmV0dXJucyBlcnJvciwgaXQgZ29lcyB0byByZXN1bWUgZGV2aWNlcyBmbG93Lg0KPiBBZnRlciB0
aGUgc3lzdGVtIHJlc3RvcmVzIHRoZSBkZXZpY2VzLCB0aGUgc3lzdGVtIHNodXRzIGRvd24uICBJ
cw0KPiB0aGlzDQo+IGV4cGVjdGVkIGRlc2lnbiBiZWhpdm91cj8gIElmIGl0IGlzLCB3b3VsZCB5
b3UgaGVscCB0byBnaXZlIHRoZQ0KPiBkZXNpZ24NCj4gcmVhc29ucyBpbiBzaG9ydCA/IEZyb20g
bXkgcG9pbnQgb2Ygdmlldywgc2luY2UgdGhlIGRlaXZjZXMgYXJlDQo+IHJlc3VtZWQsIHdoeSBk
b3NlIHRoZSBzeXN0ZW0gZ28gdG8gc2h1dCBkb3duIHN0YXRlID8gQW5kIGFsc28sIGFmdGVyDQo+
IHRoZSBzeXN0ZW0gc2h1dHMgZG93biAsIGFuZCB3aGVuIHRoZSBzeXN0ZW0gaXMgd2FrZWQgdXAg
YnkgcG93ZXIga2V5LA0KPiB0aGUgZGV2aWNlcyB3aWxsIGJlIHJlc3VtZWQgYWdhaW4gd2hlbiBy
ZXN0b3JpbmcgdGhlIHNhdmVkIHN5c3RlbSdzDQo+IGltYWdlLg0KPiANCg0KV2UgYXJlIGxvb2tp
bmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5Lg0KDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBzd3N1c3BfdW5tYXJrKCk7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBldmVudHNf
Y2hlY2tfZW5hYmxlZCA9IGZhbHNlOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJf
ZXJyKCJIaWJlcm5hdGlvbiBBYm9ydC5cbiIpOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuOw0KPiA+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiA+ICAgICAgICAgICAgICAg
ICBmYWxsdGhyb3VnaDsNCj4gPiA+ICAgICAgICAgY2FzZSBISUJFUk5BVElPTl9TSFVURE9XTjoN
Cj4gPiA+ICAgICAgICAgICAgICAgICBpZiAoa2VybmVsX2Nhbl9wb3dlcl9vZmYoKSkNCj4gPiA+
IC0tDQo+ID4gPiAyLjE3LjANCj4gPiA+IA0KDQpUaGFua3MhDQo=
