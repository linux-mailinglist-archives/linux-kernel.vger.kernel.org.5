Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D1978FE0F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbjIANG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjIANGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:06:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5C8E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:06:46 -0700 (PDT)
X-UUID: 6513547848c811eea33bb35ae8d461a2-20230901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=t0YRgkRIlS9+vnFMWn7gItbSc+nRJINg2/PDAFnBcbY=;
        b=ClwdAhc1JiKA3mgk4I65J1b+nUkP0nzXC9lNIv7KWfvdwwJFsa+y95bSRS9OT2NFGG2dM/aaoKKnmgryvlIE28cwsPIQyG1Z+4GYNOnqThOFA+zQllx48MTKfFdAakBJUeCcqRuGP9z+eT0ZxXxnE4lQv22HivZ2cXXnNJVQILc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:faa18feb-a2bf-4d22-b8b5-89a4395985c3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:147f0320-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6513547848c811eea33bb35ae8d461a2-20230901
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1421861690; Fri, 01 Sep 2023 21:06:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Sep 2023 21:06:41 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Sep 2023 21:06:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvPqLcoimgwhwEyCD0bq8Rgle77xBo9YI/LDDcRoX+6MaI0NfeomiSOP5UYVm/I91pesd1MHViQdisRo7wMmgtrZL9IXOGTUpSaf8qv+wnBS6u52mN9BfeHdpBdDHGAeEQU+2lecK6+gEOHWKuD9bOZD49tDLSfbywZXZlE5zjx/JxHUOh/0NDZSCYD4AEUKQ8qdZGDZmMdDnyLxOeLVo2vwEx1Vf9lzx4fWWTQSzpVHiQSVQKad6H+OFtIarORkP8xL5amiZNzQEX9WaAYZpe9DmaExqHcTR6kjU37qwPNCd27/qIcM5WqPP/6rHyfFtvu8QdojmGit9zanv4l4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0YRgkRIlS9+vnFMWn7gItbSc+nRJINg2/PDAFnBcbY=;
 b=IHhr1aApNtNypYQS2X92v9gYVyYANeGQUPbVf/ztHdnR+qpv/aQFW20saAGNF7NAdrMhvaMkGpIiLwWrWEcG+mX1OvsVZFs0idaBoKPHRFU09ffYd57ChDuOOAbshiUmXF1IHX4SWEMI+SONJx3Y5QRzygz/a0NOrd0AAJDypL3PfCEEGZBIiyTMvhhWb38Ozs8NvMFSO8dN5ZzEmd360xTdSbF9XB8JViRZihf+gR9ShO+6siKv7CZuUqebjbqU/fv0f1JdojlR4UlNQeukei5aVUO+18ajayrRTLfUQfNyrbURrv72X+85GPGDWw74VTlNQvU6obT6plFSYs+ycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0YRgkRIlS9+vnFMWn7gItbSc+nRJINg2/PDAFnBcbY=;
 b=jwy/7S8blhiYkppIuMaNNR3zn2yNsAtfOMVDxgSO1HxiG+8hJp+Aw8R33o7bDahVjfApNByRC/02RDLHnQKIw7teE7rScHtp4JVumZfpagfySyLCXihw/S9x7NgN3DOH4C9GOjJBsJq10OjCh2Shwn/mSi5kUObCR+vP688o1Dw=
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com (2603:1096:301:b4::11)
 by SEYPR03MB8031.apcprd03.prod.outlook.com (2603:1096:101:16e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 13:06:36 +0000
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::4731:7196:588d:ba27]) by PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::4731:7196:588d:ba27%3]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 13:06:36 +0000
From:   =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
To:     "glider@google.com" <glider@google.com>,
        "elver@google.com" <elver@google.com>,
        "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>
CC:     "andreyknvl@google.com" <andreyknvl@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        "eugenis@google.com" <eugenis@google.com>
Subject: Re: [PATCH 12/15] stackdepot: add refcount for records
Thread-Topic: [PATCH 12/15] stackdepot: add refcount for records
Thread-Index: AQHZ3NNZTBG64M2aWEav85Ytu2p3zrAF8J6A
Date:   Fri, 1 Sep 2023 13:06:36 +0000
Message-ID: <bb2f8a4f90432452822326b927e8cab58665cd09.camel@mediatek.com>
References: <cover.1693328501.git.andreyknvl@google.com>
         <306aeddcd3c01f432d308043c382669e5f63b395.1693328501.git.andreyknvl@google.com>
In-Reply-To: <306aeddcd3c01f432d308043c382669e5f63b395.1693328501.git.andreyknvl@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5964:EE_|SEYPR03MB8031:EE_
x-ms-office365-filtering-correlation-id: cb25dec5-435e-4a30-528d-08dbaaec45f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XLpC86w+Sfyw+a4kj3gEsOiAv0DriWnNDWRL4TINlPHJztRCjOPhSXeGeWtUmL/YkJEac78nuu4woUziYg6ns+zNk/E4u7vm+WtT/vJo/EKADV/DUD3l8YN0onSBXNKF36PuAUSeW/be0w/u//j+Gu+OJwqEUE998AcCdHVDvz7V9nL8g+WhPkDK+IiRErYyId4iyWR+BzX9Kd6fJlLcpY0bHTBuLmDm+EqY9cuuZs63/64JHAjeL1jgFt7fNrJdRKhGw+coMaTZZ9YLEtFf5CG/4XSCOw7VQI37Ib43y2QDwxG71THTRZWruNErYAGdQOJr7/QrQ0MYm0cFdm/yZ6KIVSXQMQiZjiN4YI5JNDPRYIsteX0twTfTu7VLNrdrPDSi14SrUtwuQgRgN9kKQjhF+Ac9AVbKQvHmn8dWXdGeFzFMHp1mVV62nzza7gu2sXWrrgdGVHqLcb0spENGVmyQ2rxxvFTQo0adVaXAUnkCwjTpPJZkCnVlCLHZINhIlb3hoyJ8Wu8Z+DGAVhTNHCcCeJa/bz/TV/KZq+oMFy97AqFkaRDXBRzvMaDB/bRe7BObSvZ78PPRQsFp/NN/mAd0XFgjwm5JLWYC54ROxDh7cnbjkr5Jh/S1GA8/peL+9AkgWaCJcPccR9IwDbHCNOpq8URSAdzYktVoUpnblnepTQJfKKn3nzGnN5FeASfU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(186009)(1800799009)(451199024)(71200400001)(6486002)(6506007)(6512007)(478600001)(83380400001)(26005)(2616005)(2906002)(7416002)(54906003)(64756008)(66446008)(66476007)(66556008)(316002)(41300700001)(66946007)(76116006)(91956017)(110136005)(5660300002)(8936002)(8676002)(4326008)(85182001)(36756003)(86362001)(38070700005)(38100700002)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlZWNDFmaXN0T09GL3dUYS9sL0FTaXlMdzIrZjZJdit5OE9kbCtib3RZNjAy?=
 =?utf-8?B?RTBzcDh6bGNIdC91UEF3dmZQbjdGaThNVUhjcXo4M0NlUXFkNkVESTNjeEl6?=
 =?utf-8?B?UEI2MGRkUXY1RzZ1c0ZWMFd5TW5GVmYycTVyOHJhbUczbEJwdkRCTUFTb1A2?=
 =?utf-8?B?Z1laQjhVejNSNzZScTYxUithV2ltWWQ4K1g1SnZOVXFIU0xDaEl2VkZMTm92?=
 =?utf-8?B?bmF3aDNhbVVybGMvQW9FMUQ1ZGtWZERFa1BhWUNZOEtKRDV5UmRqRGNOSm1I?=
 =?utf-8?B?VHJ5YWRIcUtyVWlSbHBGd01QRmhTa0VWbkZ5M2ZHZ3l2NW9PZmYvblhDSUVW?=
 =?utf-8?B?UDdaUTRieCs4U3Z0LzQzVWRXT09lYW41L1VKYmNSNE0xdXpBMEdCa1pyQWlR?=
 =?utf-8?B?ZS80SlZnQUNJSEF4V3ZhSnpwU21DU1REQ1o0c1EvWlNuWEtYYVVGZHIzT09w?=
 =?utf-8?B?NWZzM3hCOEtoT1hmNzlrZG9NdTFmRHZDS25vOTQvQzVPUXZON0hyVzUrTnc1?=
 =?utf-8?B?U0gwOGkySnhsYk93aUtyUEkzQ0MyV0NMeWFKeTFGUWhhTTQwRE9TRGhpWVg4?=
 =?utf-8?B?RWx3WnhUYnZFWEU1NThpUHdIT2paOWdkL0V3VDBzNy9sU3lVMHhnLzlGdnFD?=
 =?utf-8?B?MXFPYWE2LzF2M2hnblZaTGhDVjNwMlh2aTdpWG00S3plU3NhTFU3ZWxNTG02?=
 =?utf-8?B?UlBFQTdvR2VmUmNxditQSnZSTFBURlFvUmtIMGd6K05mMFliUHdqYzB1dmtr?=
 =?utf-8?B?d1cvdmd6Zk1vV0ZCZkxaU2kzUzFSMlhyWTlIUGJNY1MyY1IxUkRzdEN4R0Zy?=
 =?utf-8?B?MXJRcTdLclkyc2pjOUkwKzRzaUdRWjlGajd1VWZkODVGcmc1OWdBajF2RXlL?=
 =?utf-8?B?Q09DcWRRcVZ2aFJEZGJQTDVQWmV0Wld5UzdCSHlJenNnT1poZGZtSS9MVnYw?=
 =?utf-8?B?TVdaSUlVRFRMU0xsQWdKVGVaaGY1S2o2MFhXRjhDdUtpVkUxdnZkbG9rR2xm?=
 =?utf-8?B?RjhuQzNxTVI0aWQrYjFvZDk5b1VFZmZrcGgzRllUVER3M3BURy9uUU9lSlhK?=
 =?utf-8?B?a200cjkvNzFuWFpTdWNKTDhZbDRORndNZEt1aDRzZnQzbnNNN2pWdHN3Z05p?=
 =?utf-8?B?dEhhOE5LNDNIT1dLUDhYdGdja3RZSHVlelBtVElSUXJLS3JiR3RhZ2hOVCt0?=
 =?utf-8?B?QlZMdCtxQVgwaEpyVWRQaXk1dXN6NkdJSzZKWWl1NHVjTmFqcTJmQ2hRNncw?=
 =?utf-8?B?T2hoNHo5d0hhNFhxVmZITU1HUit1NUhWUzAzVHlqQitOc3pjUmtOWFVScUhZ?=
 =?utf-8?B?L2swZ1ZoR3pYWTNjc3Mxc2wyTFRqMnhOSmFXOHdQQUphSmFOTnZmcjYySDJN?=
 =?utf-8?B?STZZbHhxTTd3dXVBRGNaK0ljeThwZDBUL3VBaTFlUFhNNmJCeUNNTGdESStz?=
 =?utf-8?B?ZFhlRDBVVFp1QXh5Um9VWnc0WUhHWVpVcXhGTGhJWUVodG03ZkdGM0ZUYnI3?=
 =?utf-8?B?M2o5WjQ0ZExENW96eGx3VjdzMEI3N1JoTWxVbjgxbDlpMS9YTFZ1eG9mMStv?=
 =?utf-8?B?WkY5bnB0MUFBNEVjejdac2oyTURlalhidVBaaDNqd2JxMjI5SzFpcjNjOUZs?=
 =?utf-8?B?VGtaVlhzRTZXVUhUakNBZmIwK2Iwdm9OTFRRdmpCbWMzb3c2dk4vVmdCaFlI?=
 =?utf-8?B?N0lHemVuL1Y2UGp5Z2dhdXFaQlhQaWYrRTY5dUJIQUpGWFltN3E0UWd2dlpD?=
 =?utf-8?B?Q0NmN1JZaVJrV1UzbVBEeWRIdGhYM3Yrczd5ZDhHRnNqdlNOL0p6Zmw0QzJY?=
 =?utf-8?B?TGhVSGdza0xJS25wM2ZMVjlnYWF0TGFQNG5LVUVTaVErZ1RjcVU4SFVjMkU3?=
 =?utf-8?B?ekZCZUU2Sk1ZL2VkSTE4dlk4a1lWeE1vbGdwMUI1Nlovdm9BOGJmUUY4U2Fi?=
 =?utf-8?B?YnBPNjZsWm4zYzFpSWVtd3pjbVFmbFB6cC9ZMUdMdUIrbTVoU2l3WnhtL0lr?=
 =?utf-8?B?MjVwamZLbmRYbEJtV0ppaDd1YnNZUWZwVjJjUkVGRkkzdndtalF5Rm8zMnNn?=
 =?utf-8?B?Zm1waTdUMTRSbmJjYlk4bk5mSk1rSkFCSFZQYzdtNkJ4OExJNFNPUTQwN25w?=
 =?utf-8?B?RSsvYkszQ2ZDOS95V1F2ZlJIV0ZOb1hQQm1BREJ3RmRkY3V3UVErVmRjb3JM?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F88510005A1112479A34CD0732DF5D25@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb25dec5-435e-4a30-528d-08dbaaec45f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 13:06:36.5953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laC0eefhA2uYmxjqyZQSdJMunO9ay5AwBJ5SgHjGwnxyVZS/uO6EBo7HIUE595rVRHgPZHiEiVS0G6h3kRR9mhtU71OjtggCvjdsP6ZLy3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8031
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTI5IGF0IDE5OjExICswMjAwLCBhbmRyZXkua29ub3ZhbG92QGxpbnV4
LmRldiB3cm90ZToNCj4gRnJvbTogQW5kcmV5IEtvbm92YWxvdiA8YW5kcmV5a252bEBnb29nbGUu
Y29tPg0KPiANCj4gQWRkIGEgcmVmZXJlbmNlIGNvdW50ZXIgZm9yIGhvdyBtYW55IHRpbWVzIGEg
c3RhY2sgcmVjb3JkcyBoYXMgYmVlbg0KPiBhZGRlZA0KPiB0byBzdGFjayBkZXBvdC4NCj4gDQo+
IERvIG5vIHlldCBkZWNyZW1lbnQgdGhlIHJlZmNvdW50LCB0aGlzIGlzIGltcGxlbWVudGVkIGlu
IG9uZSBvZiB0aGUNCj4gZm9sbG93aW5nIHBhdGNoZXMuDQo+IA0KPiBUaGlzIGlzIHByZXBhcmF0
b3J5IHBhdGNoIGZvciBpbXBsZW1lbnRpbmcgdGhlIGV2aWN0aW9uIG9mIHN0YWNrDQo+IHJlY29y
ZHMNCj4gZnJvbSB0aGUgc3RhY2sgZGVwb3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkg
S29ub3ZhbG92IDxhbmRyZXlrbnZsQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgbGliL3N0YWNrZGVw
b3QuYyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2xpYi9zdGFja2RlcG90LmMgYi9saWIvc3RhY2tkZXBvdC5jDQo+IGluZGV4
IDVhZDQ1NDM2NzM3OS4uYTg0YzBkZWJiYjllIDEwMDY0NA0KPiAtLS0gYS9saWIvc3RhY2tkZXBv
dC5jDQo+ICsrKyBiL2xpYi9zdGFja2RlcG90LmMNCj4gQEAgLTIyLDYgKzIyLDcgQEANCj4gICNp
bmNsdWRlIDxsaW51eC9tdXRleC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BlcmNwdS5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L3ByaW50ay5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3JlZmNvdW50Lmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2Nr
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc3RhY2t0cmFjZS5oPg0KPiBAQCAtNjAsNiArNjEsNyBA
QCBzdHJ1Y3Qgc3RhY2tfcmVjb3JkIHsNCj4gIAl1MzIgaGFzaDsJCQkvKiBIYXNoIGluIGhhc2gg
dGFibGUgKi8NCj4gIAl1MzIgc2l6ZTsJCQkvKiBOdW1iZXIgb2Ygc3RvcmVkIGZyYW1lcyAqLw0K
PiAgCXVuaW9uIGhhbmRsZV9wYXJ0cyBoYW5kbGU7DQo+ICsJcmVmY291bnRfdCBjb3VudDsNCj4g
IAl1bnNpZ25lZCBsb25nIGVudHJpZXNbREVQT1RfU1RBQ0tfTUFYX0ZSQU1FU107CS8qIEZyYW1l
cyAqLw0KPiAgfTsNCj4gIA0KPiBAQCAtMzQ4LDYgKzM1MCw3IEBAIGRlcG90X2FsbG9jX3N0YWNr
KHVuc2lnbmVkIGxvbmcgKmVudHJpZXMsIGludA0KPiBzaXplLCB1MzIgaGFzaCwgdm9pZCAqKnBy
ZWFsbG9jKQ0KPiAgCXN0YWNrLT5oYXNoID0gaGFzaDsNCj4gIAlzdGFjay0+c2l6ZSA9IHNpemU7
DQo+ICAJLyogc3RhY2stPmhhbmRsZSBpcyBhbHJlYWR5IGZpbGxlZCBpbiBieSBkZXBvdF9pbml0
X3Bvb2wuICovDQo+ICsJcmVmY291bnRfc2V0KCZzdGFjay0+Y291bnQsIDEpOw0KPiAgCW1lbWNw
eShzdGFjay0+ZW50cmllcywgZW50cmllcywgZmxleF9hcnJheV9zaXplKHN0YWNrLCBlbnRyaWVz
LA0KPiBzaXplKSk7DQo+ICANCj4gIAkvKg0KPiBAQCAtNDUyLDYgKzQ1NSw3IEBAIGRlcG90X3N0
YWNrX2hhbmRsZV90IF9fc3RhY2tfZGVwb3Rfc2F2ZSh1bnNpZ25lZA0KPiBsb25nICplbnRyaWVz
LA0KPiAgCS8qIEZhc3QgcGF0aDogbG9vayB0aGUgc3RhY2sgdHJhY2UgdXAgd2l0aG91dCBmdWxs
IGxvY2tpbmcuICovDQo+ICAJZm91bmQgPSBmaW5kX3N0YWNrKCpidWNrZXQsIGVudHJpZXMsIG5y
X2VudHJpZXMsIGhhc2gpOw0KPiAgCWlmIChmb3VuZCkgew0KPiArCQlyZWZjb3VudF9pbmMoJmZv
dW5kLT5jb3VudCk7DQo+ICAJCXJlYWRfdW5sb2NrX2lycXJlc3RvcmUoJnBvb2xfcndsb2NrLCBm
bGFncyk7DQo+ICAJCWdvdG8gZXhpdDsNCj4gIAl9DQoNCkhpIEFuZHJleSwNCg0KVGhlcmUgYXJl
IHR3byBmaW5kX3N0YWNrKCkgZnVuY3Rpb24gY2FsbHMgaW4gX19zdGFja19kZXBvdF9zYXZlKCku
DQoNCk1heWJlIHdlIG5lZWQgdG8gYWRkIHJlZmNvdW50X2luYygpIGZvciBib3RoIHR3byBmaW5k
X3N0YWNrKCk/DQoNClRoYW5rcywNCkt1YW4tWWluZyBMZWUNCg==
