Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A7B7C66FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377335AbjJLHgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343617AbjJLHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:36:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B09B7;
        Thu, 12 Oct 2023 00:36:42 -0700 (PDT)
X-UUID: 1227128468d211ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7C4lxRYCSrLAKEbO3daf7SPu+eGkDJIY8BndLmCVzUw=;
        b=ClL0xcio7a7ywsUnFuYYCNU5zisz2T+oGkDvdOkJZnJlIL3hsV9WbtqCTMvExDj9nVLFu6gvBuOhHFzKeBBJ3soAEAFlLZ9+m1RoPEIOiMjzvr8Uqsy9E+oUwaXloe4Ug4yul6pxPuzyNxiLUwkLlW040kBTxNT3ObqlCyxfagc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ee77882a-7fab-4f6c-80df-6835494dff3a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:472609c4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1227128468d211ee8051498923ad61e6-20231012
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <bo.ye@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 320458609; Thu, 12 Oct 2023 15:36:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 15:36:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 15:36:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReMEjAT95n6hC5aMY/0xwIBaUa4wRV/ZfVPU3LCSfuS8xBJT5njlYpcsxti28tv0AY02u9Q7o9jKmDY4v6R3ezacCud6JXy0xJbA/rJOg6zY0hPqCG+WN5FpGFmcVWJfFO8o0K6u6I06eDygcHzvMJp3IDxLAQEOzDts54i/xoil0A2kbwZfNC+MZXTCkZd85bfy4Vk0tVWbUv5bkpjwTEz7wNfmUZtrnkkJeaOWL2Ozh/vLNBdCcx3jkDFX2S7T8knMf2Je1Tl6JA8fXTNCalpTUbjf5Vix3tky6hlrI9OQRYoucmIKV9+0P6TFJwH2mJdFYXIbeqF/zqrD/Xgthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C4lxRYCSrLAKEbO3daf7SPu+eGkDJIY8BndLmCVzUw=;
 b=fYTvSbCjcbTPBVRZd1sl8uG1ccatd8yYUHZC2H4no82iNRGqe2K7QNcVa20Qyq6TKrK8YFw8Jf0v55bYBK0m1roYbcAKOZnDUaFXrLNjvmbjCs2TCMcR9Y4jhoSmQPa63I9Yql4nwTLL6d6d2oamR96r79Fv/RRJV2B3VAvES5zWUb3cp0TP+tuaPiR9E+6Wc1YJRM7ye0JF8FSztqOwW6cZt/FnrrC+Yx/vLOd8dDUu8DYTxw4DewNQzp1LV8xOWAZKR8UCcg71XAFsIOUxcWGFg576XVsIn4fnA5vuHBFb+K38KdtjqtveJF1eWVEhj0fVSN8Ybx2GyoMkcqXeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C4lxRYCSrLAKEbO3daf7SPu+eGkDJIY8BndLmCVzUw=;
 b=ALAlNOZX6rGCQhZdcSIYZ4zXxZepaiSgvcnFXorxW37OkK916VsGiQQydeLwCH1TZh7FRD7njEsrd47lTXAsclXQv3Apa9CYnWd6h1tShoxMUQlmkbrF3WZRrMbLmZEwFe8rwiqPRoLpIArkxR+tqDvTMzcfqnoE4okt5TaXMBE=
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com (2603:1096:400:32::11)
 by SEYPR03MB7167.apcprd03.prod.outlook.com (2603:1096:101:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Thu, 12 Oct
 2023 07:35:37 +0000
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::b06f:65cf:b887:6fcf]) by TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::b06f:65cf:b887:6fcf%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 07:35:37 +0000
From:   =?utf-8?B?Qm8gWWUgKOWPtuazoik=?= <Bo.Ye@mediatek.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     =?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?= 
        <Yongdong.Zhang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QnJvd3NlIFpoYW5nICjlvKDno4op?= 
        <Browse.Zhang@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        =?utf-8?B?WXVnYW5nIFdhbmcgKOeOi+eOieWImik=?= 
        <Yugang.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] thermal: Fix potential race condition in suspend/resume
Thread-Topic: [PATCH] thermal: Fix potential race condition in suspend/resume
Thread-Index: AQHZ/N6xgCQByEGiEkOT8i2+eBLPSw==
Date:   Thu, 12 Oct 2023 07:35:37 +0000
Message-ID: <542a64a842d715329b35654db908681e074b0db5.camel@mediatek.com>
References: <20230916113327.85693-1-bo.ye@mediatek.com>
In-Reply-To: <20230916113327.85693-1-bo.ye@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5199:EE_|SEYPR03MB7167:EE_
x-ms-office365-filtering-correlation-id: 182b76a7-9de2-4be2-3cd2-08dbcaf5d41c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Li5lExgnEaUDwqumPw+Z3ERp0hZ9C9yeKa+IZ3GhfLq4FNp4TABdsNUFnnTRJs0JWDdk9z54rAywu9UEzQuvK7hmliDy3fN8t0r4gAUHqhzgDhA9WuU9Fwibw0JYFKX8COiux361asFMMlFpzGY4V8VU6Fz/HJz29NDOdANxr7bOPVc3ZBmup0ArAy7nWLcTJRiZoVunt9Hk7b13NCn0RJoYd18eUOmERt4D5sGXn97+HJ9oG7cy9c01EwLRuCQiqNQfqt1DQzDlEr1i6nPHi3BPCy4AdPRsiYKz3r9H75j7OzLgdaS5/d1pu08zxMQYhlf4I9SZuZp+9kmc1+PTRzGlAXwDgSEyEDr0//j/zfsgY5Nq9YA1kgjOPkyffPWx0RB1FQvBGGWpcXYQSL0vybrSKh6VTT8Ua+aUcJs4BzOFTGpCOWREABUZNBujkHqXgzAOuKWr31zAsPu30ShEnuD1Dzcq3ew44bWFe0/5F4oiG4WLDfDP3qcty5/9hsc/fis3OqeRWWAWOTp54NtJbLKIzf2ea9PBUQADPbn51lm5UQUaauz9Zup8Xikxv2Cqazfe9wOXYbxWxlI9l657+kotee77IsZrQvkAlKs1FPD0SGEJ42Hvp63bJEDN+/LLgIoMtgA8GuJxM+hJC9MukPUkOT4SN5h7t/x8yElfAzU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5199.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(2616005)(26005)(66446008)(110136005)(66476007)(66946007)(7416002)(38070700005)(64756008)(316002)(76116006)(54906003)(41300700001)(66556008)(91956017)(8936002)(4326008)(8676002)(38100700002)(5660300002)(122000001)(2906002)(15650500001)(85182001)(71200400001)(6512007)(86362001)(36756003)(6506007)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW9rR3NxaWdnWDZyTTlMcVRORkJkY0lHVGxzeW43YmkvQkNjTHhOY1dsTCsv?=
 =?utf-8?B?Z1JSWk8vTjJabVp4NU5DWnAyVy9FbTZzREdFMkZSajh4TllkTUhHSG56MXQ0?=
 =?utf-8?B?dzJCaFpYakw3MXBSM0FYaTV6WTcvSWYxOXQvZ2RvUmRocVVLRis3bW9oaUtq?=
 =?utf-8?B?NDBKeW16VUQwdHR3LzI3U08xa2pmSWpvRHFRRGppdGpGdklBK3pQTjcvTVJp?=
 =?utf-8?B?N09qL0pabmV1U3gvVUVZM2Ira2lwcHNCQlQrTDR1c09LKzJJaHQxekY5UUl4?=
 =?utf-8?B?U3hjajJZaXZWWUhUcyt0eTZ1MHM3TEZFTTg3YUxFeXVHQ09XZ1lrcEM4cTBj?=
 =?utf-8?B?cThuQkRBZklkTkRVSVIxejZCdmJlQzBHWUt1dU1GVUFNaFRyd0xhRERuUGw2?=
 =?utf-8?B?VHgrRWgrSkwxd2FNKzE5SytzU3cxbmtKS2NnTXRnZ2VkTjdPTkJxK3ZmMGNC?=
 =?utf-8?B?MmN1YXJ4eVMzWHplMmZiaGpXMG5jRjZVSWRaWVFQSXRWY1RIZUlvNjAwMFJL?=
 =?utf-8?B?aGdVTFg0SFVGelBHc2hTVVlNeFBTSXJzRHZrck9NcDFiVm1aTTEzSmoxV3hN?=
 =?utf-8?B?Wk0vWlZWY3lGYjkwb0pMMGVZUVNKUVpPNHgrdS8xdGpBT0lmaDNsOVlUQzBK?=
 =?utf-8?B?b1VJQTMxOHhSc0UrellHQ3VXQWNheFhsYndQaVpOY3dVTHNsOGh5ZENILzhm?=
 =?utf-8?B?VlA4Uy92Tlp4ZmRCMDUzRzlXMi9XaU5QYzNQQ09WWWttT1ZLdW8wVHV6WC84?=
 =?utf-8?B?NHRNOUQzSytobm0xVXBxSXpFK01kYlVOYzJSQXN6U2w5ZkVyWEF2NGdaTXpi?=
 =?utf-8?B?U0tUb3NITGFNZitsT3dBU2pWWHdIU2VhaDU4NFlIZXFlWlFidlNOUm9aOG1r?=
 =?utf-8?B?cnQvUTBuR0dhbjZIb1VESEN5ZzF0eXQwRk80R3BhanpsMGVxRUJ6YzFMR3pz?=
 =?utf-8?B?eHNTWFM4ZUE2UG90S1ZGamZLYXBWeHdVQm5jNSsxeDhkcWZmSlpUNVRSb1F1?=
 =?utf-8?B?MHZzeWw2WTRPWFM1VXpqKzZLaGFxazNueWJXQkNnUmo3UjRwNEV1b1lLYWg2?=
 =?utf-8?B?UjBPeWl5Z1lid0tsdnd4WEhBQ3pXamxPRTI2NVR6SzRFZkFHSnFiOWpSUHhS?=
 =?utf-8?B?aEdhUTh2Vnk3UXlHdEVFM3JpdWhOaGo3TEFsQWU2bXIvVTVkdXhBaTB4MDRo?=
 =?utf-8?B?N1NzN2NjdG5rMW9ZdmYrOXBNUjRsUjd5a0I5WHgvU3ZyVndXeGVNSHJ2SnRK?=
 =?utf-8?B?dGNBY1pFbHUzUzhuS1pTbzZXVkdLajE4LzY5alkvZEI2K1BVQmtOWVBlamhE?=
 =?utf-8?B?dGNCVHZkTXEwRlNSOTF6MEJNYnd2OGhTbkREemJCQ2F4ay9zSTRiMzhCOG5r?=
 =?utf-8?B?UkRRc2tBYmZGdDF0VFpkdmk1cC9aNHRhREMxTURBREsxTkx4M1hZMDJKMmFD?=
 =?utf-8?B?SllTTkxqNHpRZU94RG9NMjN6VlZUejJmSmZjK2JhWDJ6ZDBya2tnY1lkakVy?=
 =?utf-8?B?cmNGUEp1MWZiZW5HbUJVWG5HODR1VXZ2TEhPS1l2YVhHTHcvNWowUDF5cGNt?=
 =?utf-8?B?RVpwOXVCNW5ldnpGWXpTMnR1OTBBbGdpN3BsRHlldVpnM1pXRjMvdm5KQkJl?=
 =?utf-8?B?NUdrRlFsZ2pOTEd6T0VEbHZwdnpXMmQzUExKak1kN3N2VlBmcUhYMUNvS1l3?=
 =?utf-8?B?NnhDZW5LckdRSWo3Z1BaYW4veklnWkJ1SjdxOHFsY2FhT1hBeDNsU1l3R3Q5?=
 =?utf-8?B?QnBBblBPZ3BaM3hDc0NnMnNtUHBXQkNTNDZHY3A3K093MGM3VHNTTlBaaWIv?=
 =?utf-8?B?NU90eWN3SU9xZ0dtYndaTENJZno2ck1IQ0xMdkpNTFNESC9hbmVlbGovNWRp?=
 =?utf-8?B?SU5ydVg4VHc5R1BIbHc0bzlRcElDM2w1akpldkFuWnV6NE1RaEpBanFiR2R5?=
 =?utf-8?B?K2FlanhGeHJ5aVFLd0pvb1RjbjdUYXlmemRCNWVoMWxnTlkzK2xIN05LODB1?=
 =?utf-8?B?OEkyaEU4cFN2dHMwcVpBdGMwUGYwL3d1b1dQd2t3SitSSnlKNGJCYzR3akxE?=
 =?utf-8?B?NXBDSVE5ZTZLeE9oeE9aK09ac2czblowczBJSEhFbWo4Vi9ab1F4TGFLNnh3?=
 =?utf-8?Q?9aJIhqft/+MOpyQPIpcSFolhu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5953C916F867E5468EB54CC03154635D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5199.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182b76a7-9de2-4be2-3cd2-08dbcaf5d41c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 07:35:37.7416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lo53GpbZRYLONGDyLJuHsqNXQ0TTp1EaSUomEiuRHGat5iFoGlHrZszyos1kDuwhZxKoz5sjMcmvjgZiGHh9Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7167
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA5LTE2IGF0IDE5OjMzICswODAwLCBCbyBZZSB3cm90ZToNCg0KQ29ycmVj
dCBtYWlsIHRpdGxlIGZvcm1hdDogcmVtb3ZlICJTdWJqZWN0OiIgZnJvbSBtYWlsIHRpdGxlLg0K
DQo+IEZyb206ICJ5dWdhbmcud2FuZyIgPHl1Z2FuZy53YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+
IEJvZHk6DQo+IFRoaXMgcGF0Y2ggZml4ZXMgYSByYWNlIGNvbmRpdGlvbiBkdXJpbmcgc3lzdGVt
IHJlc3VtZS4gSXQgb2NjdXJzIGlmDQo+IHRoZSBzeXN0ZW0gaXMgZXhpdGluZyBhIHN1c3BlbmQg
c3RhdGUgYW5kIGEgdXNlciBpcyB0cnlpbmcgdG8NCj4gcmVnaXN0ZXIvdW5yZWdpc3RlciBhIHRo
ZXJtYWwgem9uZSBjb25jdXJyZW50bHkuIFRoZSByb290IGNhdXNlIGlzDQo+IHRoYXQgYm90aCBh
Y3Rpb25zIGFjY2VzcyB0aGUgYHRoZXJtYWxfdHpfbGlzdGAuDQo+IA0KPiBJbiBkZXRhaWw6DQo+
IA0KPiAxLiBBdCBQTV9QT1NUX1NVU1BFTkQgZHVyaW5nIHRoZSByZXN1bWUsIHRoZSBzeXN0ZW0g
cmVhZHMgYWxsIHRoZXJtYWwNCj4gICAgem9uZXMgaW4gYHRoZXJtYWxfdHpfbGlzdGAsIHRoZW4g
cmVzZXRzIGFuZCB1cGRhdGVzIHRoZWlyDQo+ICAgIHRlbXBlcmF0dXJlcy4NCj4gMi4gV2hlbiBy
ZWdpc3RlcmluZy91bnJlZ2lzdGVyaW5nIGEgdGhlcm1hbCB6b25lLCB0aGUNCj4gICAgYHRoZXJt
YWxfdHpfbGlzdGAgZ2V0cyBtYW5pcHVsYXRlZC4NCj4gDQo+IFRoZXNlIHR3byBhY3Rpb25zIG1p
Z2h0IG9jY3VyIGNvbmN1cnJlbnRseSwgY2F1c2luZyBhIHJhY2UgY29uZGl0aW9uLg0KPiBUbyBz
b2x2ZSB0aGlzIGlzc3VlLCB3ZSBpbnRyb2R1Y2UgYSBtdXRleCBsb2NrIHRvIHByb3RlY3QNCj4g
YHRoZXJtYWxfdHpfbGlzdGAgZnJvbSBiZWluZyBtb2RpZmllZCB3aGlsZSBpdCdzIGJlaW5nIHJl
YWQgYW5kDQo+IHVwZGF0ZWQgZHVyaW5nIHRoZSByZXN1bWUgZnJvbSBzdXNwZW5kLg0KPiANCj4g
S2VybmVsIG9vcHMgZXhjZXJwdCByZWxhdGVkIHRvIHRoaXMgZml4Og0KPiANCj4gWyA1MjAxLjg2
OTg0NV0gW1QzMTY4MjJdIHBjOiBbMHhmZmZmZmZlYjdkNDg3NmYwXQ0KPiBtdXRleF9sb2NrKzB4
MzQvMHgxNzANCj4gWyA1MjAxLjg2OTg1Nl0gW1QzMTY4MjJdIGxyOiBbMHhmZmZmZmZlYjdjYTk4
YTg0XQ0KPiB0aGVybWFsX3BtX25vdGlmeSsweGQ0LzB4MjZjDQo+IFsuLi4gY3V0IGZvciBicmV2
aXR5IC4uLl0NCj4gWyA1MjAxLjg3MTA2MV0gW1QzMTY4MjJdICBzdXNwZW5kX3ByZXBhcmUrMHgx
NTAvMHg0NzANCj4gWyA1MjAxLjg3MTA2N10gW1QzMTY4MjJdICBlbnRlcl9zdGF0ZSsweDg0LzB4
NmY0DQo+IFsgNTIwMS44NzEwNzZdIFtUMzE2ODIyXSAgc3RhdGVfc3RvcmUrMHgxNWMvMHgxZTgN
Cj4gDQo+IENoYW5nZS1JZDogSWZkYmRlY2JhMTcwOTNmOTFlYWI3ZTM2Y2UwNGI0NmQzMTFjYTY1
NjgNCj4gU2lnbmVkLW9mZi1ieTogeXVnYW5nLndhbmcgPHl1Z2FuZy53YW5nQG1lZGlhdGVrLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogQm8gWWUgPGJvLnllQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL3Ro
ZXJtYWxfY29yZS5jDQo+IGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+IGluZGV4
IDg3MTdhMzM0MzUxMi4uYTdhMThlZDU3YjZkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJt
YWwvdGhlcm1hbF9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5j
DQo+IEBAIC0xNTI5LDEyICsxNTI5LDE0IEBAIHN0YXRpYyBpbnQgdGhlcm1hbF9wbV9ub3RpZnko
c3RydWN0DQo+IG5vdGlmaWVyX2Jsb2NrICpuYiwNCj4gIAljYXNlIFBNX1BPU1RfSElCRVJOQVRJ
T046DQo+ICAJY2FzZSBQTV9QT1NUX1JFU1RPUkU6DQo+ICAJY2FzZSBQTV9QT1NUX1NVU1BFTkQ6
DQo+ICsJCW11dGV4X2xvY2soJnRoZXJtYWxfbGlzdF9sb2NrKTsNCj4gIAkJYXRvbWljX3NldCgm
aW5fc3VzcGVuZCwgMCk7DQo+ICAJCWxpc3RfZm9yX2VhY2hfZW50cnkodHosICZ0aGVybWFsX3R6
X2xpc3QsIG5vZGUpIHsNCj4gIAkJCXRoZXJtYWxfem9uZV9kZXZpY2VfaW5pdCh0eik7DQo+ICAJ
CQl0aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZSh0eiwNCj4gIAkJCQkJCSAgIFRIRVJNQUxfRVZF
TlRfVU5TUEVDDQo+IElGSUVEKTsNCj4gIAkJfQ0KPiArCQltdXRleF91bmxvY2soJnRoZXJtYWxf
bGlzdF9sb2NrKTsNCj4gIAkJYnJlYWs7DQo+ICAJZGVmYXVsdDoNCj4gIAkJYnJlYWs7DQo=
