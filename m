Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7727E8387
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345467AbjKJULw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344735AbjKJULt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:11:49 -0500
X-Greylist: delayed 649 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Nov 2023 12:11:46 PST
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395769D;
        Fri, 10 Nov 2023 12:11:46 -0800 (PST)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AAC48rO020334;
        Fri, 10 Nov 2023 12:00:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=proofpoint20171006; bh=+YLnblYH38WKXIgNca+/JS4FUr2pPJVcl8iKdS
        AC6Zo=; b=YPp2JgpvyD79t+Sfqf9Tc5DG15GBuuwp2zizWUfs8wXM2nyKqyDnza
        8EGWmly/3bLipvVgVjnGkshCpOPJzu8ByeEgwIoXkphAPVJhY8uWYJ4iBsQtOU6a
        5iNBwqWHTMcgrUHB9Al/SAlRpUjhmiu/9GdDjAzGVJ1QOMuGuFTH919jcZ36L1pd
        o4iVkkWV96aGARZSGnwwWx7xB7HAC5eii5neUQ9g6udNwufZ+zybJsT/4qekS9Bt
        obgWyry9b85g2BaBfNvB8oPuQZf+9qPx8bOGc/0L2mZwSu0Isf2FlVg2dgh72Tbg
        LYGPI1rJr/z3/tuVWlDaw6hGqAnM54GQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3u7w4kq989-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 12:00:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=croXqhWjiHS0VT0VwHjFoyJhLL30JARZRWbuVXaGKEmWJ47jkQyozy2zyR83yronS3Eci4K/27yFdk2oCw9XCwMZ+j5ufOudg+zLFw1v+6M/u2YNS50oTD5/Nb4WOUxZSGofw24XUWF+t46SkW2ZTXSd+ckuDTxtKIJK64UaJC2R/lvc7MJLzoZOdtkqfOxd+X3313mLvZfh+LldfCnAphlrWXJbUWjINTU7JMHJ8nvZo1DPcYkBonGWkwYaDciDdULJNmX0ruILtcCxl68DTThBsOSoEnpcGHfeCMVhJN0ndHTfbXsqIlnG1udoGx4RoFtVul4gA10771ULqv/jOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YLnblYH38WKXIgNca+/JS4FUr2pPJVcl8iKdSAC6Zo=;
 b=FSYOn584G6TvQIR8u6T/viNrXqm/yA566J6vcXoPzZLeUizu0sSe0abWxwUx3JSjYO9zWCOC+HwofXv8m0xDdb7FGDtwmA50bDpHCBhdBQzhUy4GMJl16qKYX1UaB+KvLQbgl600IqbgeUjO4K6OUAxUfMrb4X+CPfLB9AVHG251nfptA1PZXdUUBRlEM5qSF4ai78lZyxCp0Ag2p+Ma3q8beXx4grcwAgvEbW0qt1d+vaPcBEhjdy9WKDmBW/juvfGrn+Apl8/iBYy+U0p73ewskeTfM9W3JJtVdgkT0VsMposcv/B2ui3zj6jPX/E5G7A8xspSXFXc3jnZ6et4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YLnblYH38WKXIgNca+/JS4FUr2pPJVcl8iKdSAC6Zo=;
 b=SHIVTu5cbzND8imHHGeaC0S22g9F6nIqhOa4Y9guvOLX+qCHauor1T17SgwDhu0Q7HxAdfY8QItuVmDuhjppRqQjz+c84VHUuaXdPvq3Pt+koLWzUApW6QpetAZ6qtpg7IjhgdIP3gxAg8g2tLYJKS5FLWNtXLAvE4GVtYoOzQIyIG57d8XKlhX0POp0RqkvADt4Jv0xCHR/dLM4UIOcLmt5OkWwy2dcPiGrjN7hug5NdxD+4DLLCyGcolHPAGOs63+j8KeOiKpCIcbb71YtaLXhjpJ50OeBTNdTgKL0B2TcKn4xIDLSqtvnNFZvilbf/yL7Yu7kngQhH8ks+5Em7g==
Received: from BL0PR02MB4579.namprd02.prod.outlook.com (2603:10b6:208:4b::10)
 by CH3PR02MB10245.namprd02.prod.outlook.com (2603:10b6:610:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 20:00:38 +0000
Received: from BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::4881:9c9a:42b2:78d6]) by BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::4881:9c9a:42b2:78d6%7]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 20:00:38 +0000
From:   Jon Kohler <jon@nutanix.com>
To:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
CC:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] intel_idle: add CPUIDLE_FLAG_IRQ_ENABLE to SPR C1 and C1E
Thread-Topic: [PATCH] intel_idle: add CPUIDLE_FLAG_IRQ_ENABLE to SPR C1 and
 C1E
Thread-Index: AQHYjLmyfZe8FiABAE6d6qT19cbe9a1pg+iAgAAKQYCDDXl9AA==
Date:   Fri, 10 Nov 2023 20:00:38 +0000
Message-ID: <22D82855-259A-425A-B401-2F51EEC3C746@nutanix.com>
References: <20220630194309.40465-1-jon@nutanix.com>
 <b35cf10b03b441a95704648e816ff1acc150f38b.camel@linux.intel.com>
 <20B0D65B-CB72-4F56-BF8F-7B212D04A7EA@nutanix.com>
In-Reply-To: <20B0D65B-CB72-4F56-BF8F-7B212D04A7EA@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB4579:EE_|CH3PR02MB10245:EE_
x-ms-office365-filtering-correlation-id: 8e27da15-02c4-49c2-30ca-08dbe227b5f0
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kfaDKyD4WQP6qvBeaVsSmF17ojGjjK3X0A4jN1n4gjY5I2Lq5HvglbKlpQdpqJHRYZxigD5FifDOWnv4Pj22yerfY9QXrFDB5rdhHan43bowuAA2/7VkcvGWT3k9Juews6ddIogputXq+4zQV3nTDkhx7exvT9ewtRYBviB4C28KpzBNwks0WLujqZHvPHyA3sR+AhAl3NAVNWpfSaA5fBkapSo6JlYw3VmXWJKTHYtJhVMihUc0ucRbGluPU6ZPbMHEjwSinJuW82izSodasTlgjeER0JFL6ygdiecJlmnXHaV6gf4eRayBsWVKYw/XwOrWBi0iGcNjQvhAirfVg1a7s9ndMhHTIBLkNRQF2bfthNtM2n2dmCDx3b4RXfyA7zhbiRXJZ5WxPjX57+8IoqTCqMlwL0OR7NXSEWDd69RaowCR1aLLqxD+RBz6PR0LeJlnkzFdc5H7Whs11rKnL45dEKBAXQ1cu0+wiUiqd8IyFgQ7BJIuDUIbZArc59ULTlQ+At4tQ1iSO9QVwjk9Xfw7uHEx1hrmCXg3Xg9j+qkxYpp+hpNllGASQo0Goo8Bis38v374zF970rdZR66ySh0kV/jE52eSGwQZSsVMvI+Q32qkwCsbIieX6p/CVhoj8h7S9RBh0nwbuViUllwwbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4579.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(5660300002)(41300700001)(8676002)(8936002)(4326008)(66946007)(6916009)(66446008)(316002)(54906003)(66476007)(64756008)(76116006)(38070700009)(91956017)(66556008)(6512007)(38100700002)(478600001)(71200400001)(36756003)(2616005)(53546011)(6506007)(6486002)(122000001)(83380400001)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzhwN2FwWVl6Ulk5czlXREVYaTlYVXRkYXF5MDJPL2ozLzIzYTNDdGJKUmNo?=
 =?utf-8?B?YmY0WmdFN2NpOWpXYnA3dUthMjU0bUdOUzJuVk1aRS94R1h0SXNsNktyR1hp?=
 =?utf-8?B?a3ZQemsyeDVTUDZkb3YvcHhyNVVWdGxCMUxIaFc3ckN4WDNKcHVzQlpQUGE3?=
 =?utf-8?B?bklXYzVQSjc0dmk0ZnR0Q1J0bGZ2MDIzSWgwdFhDU05udXZpVlhqcGUvMUd4?=
 =?utf-8?B?Z2E5UHdWYnVlSnI4RzdqM0hTaTI5dnJFRy9lQk8yeHQ0RmE2VDJ4c3cvaXJl?=
 =?utf-8?B?UFpUK0Iyc2p2TjNNVkJ3aG9lbTdIS0FLK3J4VXFtdjhpNWhEbit4MU9pUGhy?=
 =?utf-8?B?bzhCTTBCVUxVNGdOZ2F1bXA3TmUrcHI3L2krWktEV2FYTmYwbnY2bE1XdThj?=
 =?utf-8?B?dkcwYklOSWNhTnVlek53RlpSbkZrblZPNnZtelJJQ3R3WGJwMmh0UHlEaWVU?=
 =?utf-8?B?Nll4eWZTNkNuZUh1alZ0V3Ayc0tIMDRvcWVnYmwrbDNnN1d2N2lnMk9TRE9L?=
 =?utf-8?B?czZDckY1MzNoZFNNSkhlT0NZMnNHTm9aSG9HdzBrbUNNWUFsdy84ZFRpb2du?=
 =?utf-8?B?Mk1PQ2loMTRFT2pML2lvc2l0L21SSWxtdEVUSWlIQ1ZMWXVjQnhOcm1wbGFy?=
 =?utf-8?B?TnZJTjh4UHA5elJja293d0hmOWk0ZkNlUzhpZzlZY3BQMWUvU200dm1GRDVX?=
 =?utf-8?B?YUxBTlYxVTlTZEM1RnJYd0daYW0xQlRrUUViRjllVDB1R3dGU1BPUjYxYVg0?=
 =?utf-8?B?OTVGb0QwVmdIcElmTEYzQ3dsNERqVFpFdTlrMEFiRVR0dUdZUFJDbjJsTytN?=
 =?utf-8?B?WEZXbGdURzhzaGQxd1lXMUJmMXdLdnRLZno1eUhudTNtMGVNcFV0OG1NNU8x?=
 =?utf-8?B?YWlzVUhGM0hVeHhrNjB3UGkwVXdqSm5ZZ0ExbEVpYjg5RVdFQi92M1RocU5h?=
 =?utf-8?B?amRFTDVGSzhrcjVOb2xNQzBBT3JYd1hQWTBDR0dXVnB1OTUyc2hXRlJZMXRl?=
 =?utf-8?B?L3cycVpCdEZVcWttRTBIOCtIcmVLa1RWRHRBbDhDYzVVWkZRbk5BalZ2WnpI?=
 =?utf-8?B?MkZteGpieEJIeVZ4QlNsRHV1eG1MZDV1TE1PdHowaXk2V3YrTnRsWnNIaGdw?=
 =?utf-8?B?RG0rUzgyVjNiT2R3RW9ja3ptTTNMQmZ1c0E3L0hjWURWRU44TXplNHVLazFR?=
 =?utf-8?B?M1E2QTluR0FYa3dMdmVHQ0M1eDZjUmQ0TzB4T2N4MVRBNVpvWEZoZ2tqU2hQ?=
 =?utf-8?B?cFhZcXNHTFFqbHRreGhNd25vMGlYS2RpNXQ0bS9TWTV0UWQ0Uk9qclErckdl?=
 =?utf-8?B?VmpZc2UzZFZTODA1L3FiZnZmcy9KYXlObjgwWWlwTkp0MXhUTEVrZ1NYVkYr?=
 =?utf-8?B?d1hKeWJLZ2d3aUk4U2s1a3BqK2RSR05DSnFKaVRBelE5dVZ3S1d0ZWowQzU0?=
 =?utf-8?B?NUhPUUxEYzFNdUhZTldNcnlDU01tYWdncVRyMlMwVzFVSUkxblBOMWppOFhJ?=
 =?utf-8?B?RFpWK3A2RU15cHFKOEsvZE5SeFJPQ3BaWHlyWG5RdnpZRW1NNXNPYjhubG9m?=
 =?utf-8?B?Sk9VeUM4WndEQXZqY2xUWGYwd1A1L3JQWGpYSm4zRUVsTE5TZHBLdzYxdzBr?=
 =?utf-8?B?VEZxQWloaGQwYmd0aWZCdEMzQWN2UVpETVIxSG5RZEptUVIzdExqRkpwUTlP?=
 =?utf-8?B?TkFKTDRQc3NYVzhwVW5vTDVsVVppN2xNQnM2MDFPTDhHNE5SQVJYWERVc3Ax?=
 =?utf-8?B?YmJMOWNBWWVUcXp3c3R5VVllYWl6V0xSUzNtS2xKVFMyT1FjMGVLYkg2VFZ6?=
 =?utf-8?B?NlZPVnRRbUZPQXNTUHUxbkcxUk05RTZ6Y3pSTHU4ZFFLdm9qMVhEVUF3QS8z?=
 =?utf-8?B?NHF2SC90M0p5OWxncERBVmRSbGdacHNyYzFSaWJHQVZETG50UUZ2dWw0Z2gz?=
 =?utf-8?B?bzM5bnNmc2FVeWRTMkJKY0ZtOUR5emU1UmRrQk03OU1acDloMkY2VGUwYmo0?=
 =?utf-8?B?dHJrYkUwalA1SE1UL1FDclIzcTN4QndDcXY2M3VwU241TERNdFYyR1BlbE1a?=
 =?utf-8?B?TDZVa3RaenVGeGtaSDdsV2RVZUFxTTZERTk2N2ZCWTFrL3RBUUFCUmdtaUJI?=
 =?utf-8?B?Z20vU0VXMU85NXlXcFZmWTRzUXZETExKb3VVRUh2UzFTRDUvcXBjdDU0SnBW?=
 =?utf-8?B?bjUwNVF6Yk83TGFXeWhZa0FCQmhldjROUGpPaHNZVlJkZS96Wm1WNUVxZzlq?=
 =?utf-8?B?OTllZEUwU05vWG9NWCtiaUtsRldnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <129621DC1D84BE47A5960599CE04B838@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4579.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e27da15-02c4-49c2-30ca-08dbe227b5f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 20:00:38.6792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSMw5Ad6DTawehWHCvx5GwgmmBgKeylB4iZ+Eap3s8pSjsNrN2hQK7A4FF58ZYaEBh1AjO+M6cNGzbN6mPyoS7YLX4AFYRUuyVWupFaGmBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10245
X-Proofpoint-GUID: 9_lE1XhUwsC0UPLIKaCD9NL-i6ajUOes
X-Proofpoint-ORIG-GUID: 9_lE1XhUwsC0UPLIKaCD9NL-i6ajUOes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVsIDEsIDIwMjIsIGF0IDEwOjA2IEFNLCBKb24gS29obGVyIDxqb25AbnV0YW5p
eC5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gSnVsIDEsIDIwMjIsIGF0IDk6MzAgQU0s
IEFydGVtIEJpdHl1dHNraXkgPGFydGVtLmJpdHl1dHNraXlAbGludXguaW50ZWwuY29tPiB3cm90
ZToNCj4+IA0KPj4gSGkgSm9uLA0KPj4gDQo+PiBPbiBUaHUsIDIwMjItMDYtMzAgYXQgMTU6NDMg
LTA0MDAsIEpvbiBLb2hsZXIgd3JvdGU6DQo+Pj4gQWRkIENQVUlETEVfRkxBR19JUlFfRU5BQkxF
IHRvIHNwcl9jc3RhdGVzIEMxIGFuZCBDMUUsIHdoaWNoIHdpbGwNCj4+PiBhbGxvdyBsb2NhbCBJ
UlFzIHRvIGJlIGVuYWJsZWQgZHVyaW5nIGZhc3QgaWRsZSB0cmFuc2l0aW9ucyBvbiBTUFIuDQo+
PiANCj4+IERpZCB5b3UgaGF2ZSBhIGNoYW5jZSB0byBtZWFzdXJlIHRoaXM/IFdoZW4gSSB3YXMg
ZG9pbmcgdGhpcyBmb3IgSUNYIGFuZCBDTFgsIEkNCj4+IHdhcyB1c2luZyBjeWNsaWN0ZXN0IGFu
ZCB3dWx0IGZvciBtZWFzdXJpbmcgSVJRIGxhdGVuY3kuDQo+PiANCj4+IEkgd2FzIHBsYW5uaW5n
IHRvIGRvIHRoaXMgZm9yIFNQUiBhcyB3ZWxsLg0KPiANCj4gV2UgaGF2ZSB0aGUg4oCYYmVmb3Jl
4oCZIGJhc2VsaW5lIGZyb20gd3VsdCwgYW5kIHJlYWxpemVkIGFmdGVyIGRvaW5nIGl0IHRoYXQN
Cj4gSVJRX0VOQUJMRSBjb25maWcgd2FzbuKAmXQgc2V0LiBJ4oCZdmUgcHJvdmlkZWQgdGhpcyBw
YXRjaCB0byBvdXIgaW50ZXJuYWwNCj4gdGVhbSB3b3JraW5nIG9uIFNQUiBlbmFibGVtZW50IHRv
IGdldCBhbm90aGVyIHd1bHQgcnVuIGluIG5leHQgd2Vlay4NCj4gDQo+IFRoYXQgc2FpZCwgaWYg
eW914oCZdmUgZ290IGFjY2VzcyB0byBhbiBTUFIgc3lzdGVtIHNldHVwIGFzIHdlbGwsIHdl4oCZ
ZA0KPiBjZXJ0YWlubHkgYXBwcmVjaWF0ZSBhIHNlY29uZCBzZXQgb2YgZXllcy4gVGhpcyBpcyB0
aGUgZmlyc3QgZ2VuZXJhdGlvbg0KPiBvZiBlbmFibGVtZW50IGZvciBhIG5ldyBwbGF0Zm9ybSB0
aGF0IHdl4oCZdmUgZG9uZSB3aGVyZSB3dWx0IGhhcyBiZWVuDQo+IG9uIHRoZSDigJhjaGVja2xp
c3TigJkgc28gdG8gc3BlYWssIHNvIHdlIGRvbuKAmXQgaGF2ZSBhcyBtdWNoIOKAmXN0aWNrIHRp
bWXigJkNCj4gb24gaXQgYXMgc29tZW9uZSBsaWtlIHlvdXJzZWxmIHdvdWxkIDopIA0KPiANCj4+
IA0KPj4+IE5vdGU6IEVuYWJsaW5nIHRoaXMgZm9yIGJvdGggQzEgYW5kIEMxRSBpcyBzbGlnaHRs
eSBkaWZmZXJlbnQgdGhhbg0KPj4+IHRoZSBhcHByb2FjaCBmb3IgU0tYL0lDWCwgd2hlcmUgQ1BV
SURMRV9GTEFHX0lSUV9FTkFCTEUgaXMgb25seQ0KPj4+IGVuYWJsZWQgb24gQzE7IGhvd2V2ZXIs
IGdpdmVuIHRoYXQgU1BSIHRhcmdldC9leGl0IGxhdGVuY3kgaXMgMS8xDQo+Pj4gZm9yIGMxIGFu
ZCAyLzQgZm9yIEMxRSwgcmVzcGVjdGl2ZWx5LCB3aGljaCBpcyBzbG93ZXIgdGhhbiBDMQ0KPj4+
IGZvciBTS1gsIGl0IHNlZW1zIHBydWRlbnQgdG8gbm93IGVuYWJsZSBpdCBvbiBib3RoIHN0YXRl
cy4NCj4+IA0KPj4gSSB3YXMgYWxzbyBnb2luZyB0byBtZWFzdXJlIHRoaXMgZm9yIEMxRS4NCj4+
IA0KPj4gQ291bGQgd2UgcGxlYXNlIGhvbGQgb24gdGhpcyBhIGJpdCAtIEknZCBsaWtlIHRvIG1l
YXN1cmUgdGhpcyBiZWZvcmUgd2UgbWVyZ2UNCj4+IGl0Lg0KPiANCj4gWWVhIG5vIHByb2JsZW0s
IGhhcHB5IHRvIGdldCBoZWxwIGFuZCBhIHNlY29uZCBzZXQgb2YgZXllcyBvbiB0aGlzLg0KPiAN
Cj4gVGhhbmtzIC0gSm9uDQoNCkhleSBBcnRlbSwNCkNvbWluZyBiYWNrIGFyb3VuZCBvbiB0aGlz
LCBJIHJlYWxpemVkIHRoaXMgZmVsbCB0aHJvdWdoIHRoZSBjcmFja3MuIEkgd2FzIHdvbmRlcmlu
Zw0KaWYgeW91IGhhcHBlbmVkIHRvIHJ1biB0aHJvdWdoIHRoaXMgdGVzdGluZyBvbiB5b3VyIHNp
ZGUgYWxyZWFkeSBhcyBwYXJ0IG9mIG90aGVyDQplZmZvcnRzPyANCg0KSWYgbm90LCBJ4oCZbGwg
c2VlIGlmIHdlIGNhbiBnZXQgaXQgc3B1biBiYWNrIHVwIG9uIG91ciBzaWRlLiANCg0KVGhhbmtz
LA0KSm9uDQoNCj4gDQo+PiANCj4+IEFydGVtLg0KDQoNCg==
