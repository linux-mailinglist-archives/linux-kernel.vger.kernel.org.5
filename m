Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE567DDF28
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjKAKPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjKAKPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:15:52 -0400
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7267F102;
        Wed,  1 Nov 2023 03:15:46 -0700 (PDT)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
        by mx08-00376f01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A18Omxi018973;
        Wed, 1 Nov 2023 10:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=dk201812; bh=aUVWYvGUci2d6zZWWRnPMOf1jrZYUGpHmbnI0zzpPCQ=; b=
        Eg9iBXPBIycEBYl71CbCxnjYMZHjhjuy+xd4TGg3r12IMy/ox5OZ2krUnhcjU0uK
        tRIZVuXWGhGRbMlwFHvZvquzGAV9wJpLcb0K/FT7TPlVyJ4jBXcJRttEnFRhSXbS
        LeH3Ght4OxI0Z6cojJfQ9EgRF+IYCO03/eYigdwjEd0d17L6DTS383ETv2Lo3BX5
        yuRy431GEkjM9GQKVpu24EjTzXf36PyvmDhwRB/dbOlhpoMFl8jKyVnVZT9zwRYb
        u7o7N9ZzOSQhY2mXtlsPV15MElW3m/UR2fypYdqSbhNXxLZ206Ba3txiO/+cgrvn
        voY389vPjkMr7AK2ui7pkg==
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 3u0rjnu33e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Nov 2023 10:15:17 +0000 (GMT)
Received: from HHMAIL04.hh.imgtec.org (10.100.10.119) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 10:15:17 +0000
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (104.47.85.105)
 by email.imgtec.com (10.100.10.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 10:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA4Tb8Wg3Bm/AKQ+HuXaH2xlk5r+nGONX5kKLDwW4Y+QqXegrswrf9P/7YzDKu2e7RQW8VgtFDph0ErSng5MFF+/CpI2brocaQfWUxI6OzDN2m5R7YEpQRyh2AM1gEXqukGRRu9EU4rqvOoXKR2krURcClhINghUS69nbPVyKYb4X2BTxxA4Cu2b8WKIMx2rnlNFoHG7esQ61/M6NQiBbVMJ9LnKL80H33+ONVZfjJXNlfG9E0U0rse8LkDsRMpsWawBDU0fn/QunryUbaqDtbx7jGB5rF32r5kZRYbRNQyO7OGUkVN2SgsB9kNsbPnm0fNUAMTLh5sOZ6wgCW1xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUVWYvGUci2d6zZWWRnPMOf1jrZYUGpHmbnI0zzpPCQ=;
 b=gfF/aJwt4WodGe3daHWzTQg6DR31OZLHPpAuTLPgTNvwFg5JgziTp8NH7rygS3yf5DDTKGEqbhYxIwvWb1VgzeeCtQpTNvCqWoUKITmFI77zCj0VJ+yMtINyyCR7/M1/ffIoDvtQkKuamLulyhAId4wqkIJswJcn3CnbgjYoKTW5J0nlhyDz/Xi8F+KzWxQAZ2ytaxMekjJvQ9Vn2UBWJ+i2HcwfiSobqtQanFberKMJAY6MZ20avPOyRD3rFYACmqERvlJe07k19BUWOwVF7DOVP2ZvuPtJYQNYj0DwLh2cvrL98C7jE1KgU6L2YnQJ6mIglTbo/HbfWSLXwl3sgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUVWYvGUci2d6zZWWRnPMOf1jrZYUGpHmbnI0zzpPCQ=;
 b=XMaKlPzLMW26nUsKamMUa33DH3y0uieDLFJPPoeaEcSKkNQMQP1BYozkpg6rfFQQgsyZTCer077Xxbx6PlQAAPhxg8Cz1Q0dB+5QDHSikphQ+DeLVIGl6rnmHQ9cOeebuuRmjJ39T1+IMyaDc107+Gx2ZWz/zJ4MUohaRJ5BNnw=
Received: from LO6P265MB6032.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a5::14)
 by LO0P265MB5894.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 10:15:15 +0000
Received: from LO6P265MB6032.GBRP265.PROD.OUTLOOK.COM
 ([fe80::cbf2:a8a7:612f:3f7]) by LO6P265MB6032.GBRP265.PROD.OUTLOOK.COM
 ([fe80::cbf2:a8a7:612f:3f7%4]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 10:15:15 +0000
From:   Frank Binns <Frank.Binns@imgtec.com>
To:     "mripard@kernel.org" <mripard@kernel.org>,
        "faith.ekstrand@collabora.com" <faith.ekstrand@collabora.com>,
        Sarah Walker <Sarah.Walker@imgtec.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "luben.tuikov@amd.com" <luben.tuikov@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "dakr@redhat.com" <dakr@redhat.com>,
        "hns@goldelico.com" <hns@goldelico.com>, "afd@ti.com" <afd@ti.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "matthew.brost@intel.com" <matthew.brost@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH v8 00/20] Imagination Technologies PowerVR DRM driver
Thread-Topic: [PATCH v8 00/20] Imagination Technologies PowerVR DRM driver
Thread-Index: AQHaDAzEIXsjpmlqvUalR5Yt+05Rh7BkFzCAgAEpUgA=
Date:   Wed, 1 Nov 2023 10:15:15 +0000
Message-ID: <eb0dcfe7a5f4da207bdbbd9630e5d6e5c940dfa5.camel@imgtec.com>
References: <20231031151257.90350-1-sarah.walker@imgtec.com>
         <lg7cdw3qlak74zefbx25f5pnazrburteldueoqz7o7cphydqp7@q56er3qa5muf>
In-Reply-To: <lg7cdw3qlak74zefbx25f5pnazrburteldueoqz7o7cphydqp7@q56er3qa5muf>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO6P265MB6032:EE_|LO0P265MB5894:EE_
x-ms-office365-filtering-correlation-id: 49075318-4669-4d69-0e73-08dbdac37104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cH7qtLTHCnZs7Jeye4u7JY9Rb5yi0459FW2sKLP7IZVit4APyX2PaHe+fmVQ1cg2N/T3L0gG5A2fZIJOnSD85d1QoPa6o2u7VO89N0MYfHpc0Jz7Om9TaLxTWQ5wmedv+ZSOBeibprp4Cx2CDYsO1M2QtTIAMmXS33JrQK4sFsCg5zIpRwweH20fkLbBh9qNNxWkMDvbPYefEHNj/72RFQsitUVaHBVifnE43v3ecgYvSHVJeydRmNzk/citAd/2uL9bBrK+OmaLGZFAGoPhyE0FK4/om48BR8RAJjty9wT44x3HbzuXpFVlMsg7fhPGHzFqxbyKa8hbMLXedpUVt9K2JjlY5bsmXlMCV7m5PBsQJWHk6ThW5TqDgbrTSJ+viTCpryYtC+o4Yvg8NgMnx9LE8GUY8HPdq1lRb8s4U/uuKTL4k7cZR2DtctcqBBixyeTNZNLQarFFJ2WUG+8JC16kBGDPvH2rswqwE1MSWfDKkNqqntl0YvvVgPSqxL5Tjqg+m9BRsb/oTCKZ8GZeYyO+as3/KcBo/rxNOc+/JW3u5jE9HCK6hpwjiBhgxgRDX0fF+IzXExyGyfCDlVlUhxV7FUz3jU/L2pWubIAtALg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P265MB6032.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39850400004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(6512007)(26005)(478600001)(71200400001)(6506007)(83380400001)(5660300002)(7416002)(41300700001)(4001150100001)(76116006)(110136005)(966005)(6486002)(54906003)(66946007)(66476007)(6636002)(66446008)(8936002)(4326008)(8676002)(66556008)(316002)(64756008)(38070700009)(122000001)(38100700002)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzhuTEJ0clNkYXFnbWJUOGhjK2ZtRU1GNHV6cmV6Sy9RVjdHZVZvRS9STmxh?=
 =?utf-8?B?R2lVR0R4empkSTR3L2xuWkQzRk4wSkVKcXo4TGphLzVqUzNZazN5c3MzWkFE?=
 =?utf-8?B?R092N1dubTlmTkJvTi9ubTBuUzRzbDNqYzdYejBYa1pKNE9RNWZBYzZNS1ow?=
 =?utf-8?B?d1dkWUo3RWtkNWdYQVVBTGtjRTVHVGVjREFKRDBnKzA0eXZ0UDdIV3hneE15?=
 =?utf-8?B?bFVESnN2WWdqb3RiaDhMcHRoQm1rajdQY0tFWkNBMm84aVZVT1RwSURqbjht?=
 =?utf-8?B?VklLem9yNGlKL0VWbGVscnJCVTVpNGJ1aTNMR0t3RE1Sc0JyTWs2WFd0ekEv?=
 =?utf-8?B?SDBicVFWQkNibUthL3E3K2NiZytOOHpzWkZVWHYwMDlrN0NUaUp2eEVndXpG?=
 =?utf-8?B?UGlkcFFSdG9BSHUyaHdPeFh6UnNVa0wvMWVUVkNyb21xdHVBOTBBOHkyUHVE?=
 =?utf-8?B?ZUlSVXpzMThzUW11WkxHVjdCajI1WFRhaWg3MXUxQlhMOFNnSmJyZ0l2a0RX?=
 =?utf-8?B?bWhZRDErTndzdGw3ZzR0QVdReXMxUno0SEt3emsvQUNlY3RSWGdrRnNtTWF1?=
 =?utf-8?B?eGtRQ2JrOHRhdFBPSDVmeDlXVnBFMlpScU9XdzdJNm5NdVFhY1JMWEJUOXQ1?=
 =?utf-8?B?YmRSeHBteE11aXNuQnlBaDUxdWxkelM0bHhSMTM0emVPVjNVY2JxbGxBeCtG?=
 =?utf-8?B?amNXNlJvSUNKY28rWjNDVjFkQVYrSzFMa1NoNnIvWHhlTkZGQ0J6azlqN1d4?=
 =?utf-8?B?ZlY0YzlBVHRudEZ1RnlsTjlNdlEyaFZ4bW1GMmxPUzNyOCtLL3lITkVYSFp2?=
 =?utf-8?B?Rk0wdHlRMFk5c3ZRZEhJWUFzYTl4OTFGeUdFQjlVMTRYTWI1aXk4b1NYTHF5?=
 =?utf-8?B?cG8ydW1mNjVlQW9LN08wc0crQ0ljSDlMeDBrNld4dzdYZnQ1eVJQV2tSVEN4?=
 =?utf-8?B?MFZBVUI1YkpZTFRHTGswalVwWG5kWkZPaHkrZ2Q5TFdEMjZSTEpuOStrRmpE?=
 =?utf-8?B?ZHBSUnFuTENrL29WZllFYXp1Nyt2UjlCcUNsNW02OU1ST3pLZE1yTDFpeEJL?=
 =?utf-8?B?YTlVUFR0TWZja0pBVEp6YlVjVzl0cVZXUkl5MzFqbGdWUVF2OFluTi9pRm1L?=
 =?utf-8?B?eS9vanozOVFyRjgwcnR1bjlrcWVRQmZ5dlN3QXJhbHNia2x5K1BMRWREMUpU?=
 =?utf-8?B?SHlOV08vdjc0Yy8wM0FPSnNqYWlpZTA1bkxxWkRmdjVnVXZOUTNTM3U0TW1N?=
 =?utf-8?B?UWd5SmZJUEFoZUNMeGw4Ykk2WUtIRXBLL2daRjhESnkvUHRxd2RVLzJNb0dH?=
 =?utf-8?B?V1BWSEVKdmpYaFZCb0ZPQ3E4UGpiZXF2QW5QOHBKblRTTUI1dXFmOVhWMDBv?=
 =?utf-8?B?ektDMHRNQkxvZGRrd2x1RzI1S3oyZGJEMG5MeTNZUDN3eUhLREZYREo5THhq?=
 =?utf-8?B?a01Uc2VvS041QUtTL3NzSWdiV2o0VU9YT2d5eFNjRnpBbmErdjZEWGk4Zm5W?=
 =?utf-8?B?MkdGOVFPbTNqQUlQZlp4Nkt2WE43VUt3NzBCcUFCMFUrZFA3blUyNU1BWlpz?=
 =?utf-8?B?M1VQQWdoc1k3ZkxPMXNITHNUSGdwWnl1OTk0Y1pjTXo5cDZLbUlmcERKenVa?=
 =?utf-8?B?UlhsU1VlSlpXelZVNkgxbG5UYkNWSGo5STREZ1dDZ1F1UFFFMEg5cnBsVGdH?=
 =?utf-8?B?Wk5GUnhtR3FTOEZyY3JHVFFzWGZEMUtFYlhqYXlOdjhhRHZERjNrZlJnbFJv?=
 =?utf-8?B?MHNwNXNlN1JGTkp0NGRlNkZqWVNCNGprQnZ2N0NSRW9jaXRmUzk0NGtsR0pV?=
 =?utf-8?B?bDRhYmF0TGdEeDhTSDR0bzkzTloydE1CcUpDbDhMNlBhZjhCeGc1QkMxdWFr?=
 =?utf-8?B?MG9CaWZFWEpWQk5YQVlsTzJueUFYMEpUYzl4UDlLenlRL0RxWXdHcWlGQnYy?=
 =?utf-8?B?RFhKVmt2Z0pBalRxRVpHb1prWVlEVk5ySnhXMFV0RFU3VXdScGFMTFpnU2Fj?=
 =?utf-8?B?Z2V0UVhNWVhkeE9kKytwM2xsWk9WZmRrSUdRM21pdndFM0EvWUZTNXU5YnJi?=
 =?utf-8?B?TVN5STJmK28xOUpnb2xmYTZOVXhYd0NaaWFyZXpScjhZNWFzRUJ0WDhlUHR3?=
 =?utf-8?B?QkFOUlRRanBLdTRkZ2krQlQvUE8wTm5XcXNZeENxck9YWWljd1FtOFR0QmdH?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <978266053596984E9170BA889D4166B7@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO6P265MB6032.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 49075318-4669-4d69-0e73-08dbdac37104
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 10:15:15.2139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2Zn3z1W2aQc/1mW9jER1VsBZD328nDgrh5VDjDo7XjTpGS9utvh4iO+Wy3hyrZ3GvXZiy/KpttwNrFUwz+1lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5894
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: azFgf2qmVtSZgFKRhBolTJhd4_wFGBko
X-Proofpoint-ORIG-GUID: azFgf2qmVtSZgFKRhBolTJhd4_wFGBko
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF4aW1lLA0KDQpPbiBUdWUsIDIwMjMtMTAtMzEgYXQgMTc6MzEgKzAxMDAsIE1heGltZSBS
aXBhcmQgd3JvdGU6DQo+IEhpIFNhcmFoLCBGYWl0aCwgRnJhbmssDQo+IA0KPiBPbiBUdWUsIE9j
dCAzMSwgMjAyMyBhdCAwMzoxMjozN1BNICswMDAwLCBTYXJhaCBXYWxrZXIgd3JvdGU6DQo+ID4g
VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyB0aGUgaW5pdGlhbCBEUk0gZHJpdmVyIGZvciBJbWFnaW5h
dGlvbiBUZWNobm9sb2dpZXMgUG93ZXJWUg0KPiA+IEdQVXMsIHN0YXJ0aW5nIHdpdGggdGhvc2Ug
YmFzZWQgb24gb3VyIFJvZ3VlIGFyY2hpdGVjdHVyZS4gSXQncyB3b3J0aCBwb2ludGluZw0KPiA+
IG91dCB0aGF0IHRoaXMgaXMgYSBuZXcgZHJpdmVyLCB3cml0dGVuIGZyb20gdGhlIGdyb3VuZCB1
cCwgcmF0aGVyIHRoYW4gYQ0KPiA+IHJlZmFjdG9yZWQgdmVyc2lvbiBvZiBvdXIgZXhpc3Rpbmcg
ZG93bnN0cmVhbSBkcml2ZXIgKHB2cnNydmttKS4NCj4gPiANCj4gPiBUaGlzIG5ldyBEUk0gZHJp
dmVyIHN1cHBvcnRzOg0KPiA+IC0gR0VNIHNobWVtIGFsbG9jYXRpb25zDQo+ID4gLSBkbWEtYnVm
IC8gUFJJTUUNCj4gPiAtIFBlci1jb250ZXh0IHVzZXJzcGFjZSBtYW5hZ2VkIHZpcnR1YWwgYWRk
cmVzcyBzcGFjZQ0KPiA+IC0gRFJNIHN5bmMgb2JqZWN0cyAoYmluYXJ5IGFuZCB0aW1lbGluZSkN
Cj4gPiAtIFBvd2VyIG1hbmFnZW1lbnQgc3VzcGVuZCAvIHJlc3VtZQ0KPiA+IC0gR1BVIGpvYiBz
dWJtaXNzaW9uIChnZW9tZXRyeSwgZnJhZ21lbnQsIGNvbXB1dGUsIHRyYW5zZmVyKQ0KPiA+IC0g
TUVUQSBmaXJtd2FyZSBwcm9jZXNzb3INCj4gPiAtIE1JUFMgZmlybXdhcmUgcHJvY2Vzc29yDQo+
ID4gLSBHUFUgaGFuZyBkZXRlY3Rpb24gYW5kIHJlY292ZXJ5DQo+ID4gDQo+ID4gQ3VycmVudGx5
IG91ciBtYWluIGZvY3VzIGlzIG9uIHRoZSBBWEUtMS0xNk0gR1BVLiBUZXN0aW5nIHNvIGZhciBo
YXMgYmVlbiBkb25lDQo+ID4gdXNpbmcgYSBUSSBTSy1BTTYyIGJvYXJkIChBWEUtMS0xNk0gR1BV
KS4gVGhlIGRyaXZlciBoYXMgYWxzbyBiZWVuIGNvbmZpcm1lZCB0bw0KPiA+IHdvcmsgb24gdGhl
IEJlYWdsZVBsYXkgYm9hcmQuIEZpcm13YXJlIGZvciB0aGUgQVhFLTEtMTZNIGNhbiBiZWZvdW5k
IGhlcmU6DQo+ID4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2ZyYW5rYmlubnMvbGlu
dXgtZmlybXdhcmUvLS90cmVlL3Bvd2VydnINCj4gPiANCj4gPiBBIFZ1bGthbiBkcml2ZXIgdGhh
dCB3b3JrcyB3aXRoIG91ciBkb3duc3RyZWFtIGtlcm5lbCBkcml2ZXIgaGFzIGFscmVhZHkgYmVl
bg0KPiA+IG1lcmdlZCBpbnRvIE1lc2EgWzFdWzJdLiBTdXBwb3J0IGZvciB0aGlzIG5ldyBEUk0g
ZHJpdmVyIGlzIGJlaW5nIG1haW50YWluZWQgaW4NCj4gPiBhIG1lcmdlIHJlcXVlc3QgWzNdLCB3
aXRoIHRoZSBicmFuY2ggbG9jYXRlZCBoZXJlOg0KPiA+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNr
dG9wLm9yZy9mcmFua2Jpbm5zL21lc2EvLS90cmVlL3Bvd2VydnItd2luc3lzDQo+ID4gDQo+ID4g
Sm9iIHN0cmVhbSBmb3JtYXRzIGFyZSBkb2N1bWVudGVkIGF0Og0KPiA+IGh0dHBzOi8vZ2l0bGFi
LmZyZWVkZXNrdG9wLm9yZy9tZXNhL21lc2EvLS9ibG9iL2Y4ZDJiNDJhZTY1YzJmMTZmMzZhNDNl
MGFlMzlkMjg4NDMxZTQyNjMvc3JjL2ltYWdpbmF0aW9uL2NzYmdlbi9yb2d1ZV9rbWRfc3RyZWFt
LnhtbA0KPiA+IA0KPiA+IFRoZSBWdWxrYW4gZHJpdmVyIGlzIHByb2dyZXNzaW5nIHRvd2FyZHMg
VnVsa2FuIDEuMC4gVGhlIGN1cnJlbnQgY29tYmluYXRpb24gb2YgdGhpcw0KPiA+IGtlcm5lbCBk
cml2ZXIgd2l0aCB0aGUgTWVzYSBWdWxrYW4gZHJpdmVyIChwb3dlcnZyLW1lc2EtbmV4dCBicmFu
Y2gpIHN1Y2Nlc3NmdWxseQ0KPiA+IGNvbXBsZXRlcyBWdWxrYW4gQ1RTIDEuMy40LjEgaW4gb3Vy
IGxvY2FsIHJ1bnMuIFRoZSBkcml2ZXIgaXMgZXhwZWN0ZWQgdG8gcGFzcyB0aGUNCj4gPiBLaHJv
bm9zIENvbmZvcm1hbmNlIFByb2Nlc3Mgb25jZSB0aGUgc3VibWlzc2lvbiBpcyBtYWRlLg0KPiA+
IA0KPiA+IFRoZSBjb2RlIGluIHRoaXMgcGF0Y2ggc2VyaWVzLCBhbG9uZyB3aXRoIHRoZSBuZWVk
ZWQgZHRzIGNoYW5nZXMgY2FuIGJlIGZvdW5kIGhlcmU6DQo+ID4gaHR0cHM6Ly9naXRsYWIuZnJl
ZWRlc2t0b3Aub3JnL3NhcmFoLXdhbGtlci1pbWd0ZWMvcG93ZXJ2ci8tL3RyZWUvZGV2L3Y4X2R0
cw0KPiA+IFRoZSBmdWxsIGRldmVsb3BtZW50IGhpc3RvcnkgY2FuIGJlIGZvdW5kIGhlcmU6DQo+
ID4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2ZyYW5rYmlubnMvcG93ZXJ2ci8tL3Ry
ZWUvcG93ZXJ2ci1uZXh0DQo+IA0KPiBBd2Vzb21lLCB0aGFua3MgZm9yIHNlbmRpbmcgYSBuZXcg
dmVyc2lvbiBvZiB0aGF0IHNlcmllcy4NCj4gDQo+IEF0IFhEQywgd2UgYWxsIGFncmVlZCB0aGF0
IHdlIHdvdWxkIG1lcmdlIHRoaXMgdmVyc2lvbiBpZiB0aGUgY2hhbmdlcw0KPiByZXF1ZXN0ZWQg
YnkgRmFpdGggd2VyZSBmaXhlZCwgYW5kIGlmIHRoZSBNZXNhIFBSIHdhcyB1cGRhdGVkIHRvIG1h
dGNoDQo+IHRoYXQgbmV3IGtlcm5lbCBzZXJpZXMuDQo+IA0KPiBBcmUgd2UgdGhlcmUgeWV0Pw0K
DQpXZSd2ZSBtYWRlIGFsbCB0aGUgY2hhbmdlcyB0aGF0IHdlcmUgcmVxdWVzdGVkIGF0IFhEQy4g
VGhlcmUgYXJlIGEgY291cGxlIG9mDQpxdWVzdGlvbnMgRmFpdGggaGFkIGZvciBtZSB0aGF0IEkg
c3RpbGwgbmVlZCB0byByZXNwb25kIHRvLiBJJ2xsIGhvcGVmdWxseSBiZQ0KZ2V0dGluZyB0byB0
aGVzZSB0b2RheS4NCg0KVGhlIE1lc2EgTVIgYWRkaW5nIHN1cHBvcnQgZm9yIHRoaXMga2VybmVs
IGRyaXZlciBpcyBhbGwgdXAgdG8gZGF0ZToNCmh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9y
Zy9tZXNhL21lc2EvLS9tZXJnZV9yZXF1ZXN0cy8xNTUwNw0KDQo+IA0KPiBJZiBzbywgRmFpdGgs
IHNob3VsZCB3ZSBhZGQgeW91ciBSZXZpZXdlZC1ieS9BY2tlZC1ieSB0YWcgdG8gdGhlIFVBUEkg
cGF0Y2g/DQo+IA0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGhhcyBkZXBlbmRlbmNpZXMgb24gYSBu
dW1iZXIgb2YgcGF0Y2hlcyBub3QgeWV0IG1lcmdlZC4gVGhleQ0KPiA+IGFyZSBsaXN0ZWQgYmVs
b3cgOg0KPiA+IA0KPiA+IGRybS9zY2hlZDogQ29udmVydCBkcm0gc2NoZWR1bGVyIHRvIHVzZSBh
IHdvcmsgcXVldWUgcmF0aGVyIHRoYW4ga3RocmVhZDoNCj4gPiAgIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2RyaS1kZXZlbC8yMDIzMDQwNDAwMjIxMS4zNjExMzc2LTItbWF0dGhldy5icm9zdEBp
bnRlbC5jb20vDQo+ID4gZHJtL3NjaGVkOiBNb3ZlIHNjaGVkdWxlIHBvbGljeSB0byBzY2hlZHVs
ZXIgLyBlbnRpdHk6DQo+ID4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9kcmktZGV2ZWwvMjAy
MzA0MDQwMDIyMTEuMzYxMTM3Ni0zLW1hdHRoZXcuYnJvc3RAaW50ZWwuY29tLw0KPiA+IGRybS9z
Y2hlZDogQWRkIERSTV9TQ0hFRF9QT0xJQ1lfU0lOR0xFX0VOVElUWSBzY2hlZHVsaW5nIHBvbGlj
eToNCj4gPiAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2RyaS1kZXZlbC8yMDIzMDQwNDAwMjIx
MS4zNjExMzc2LTQtbWF0dGhldy5icm9zdEBpbnRlbC5jb20vDQo+ID4gZHJtL3NjaGVkOiBTdGFy
dCBydW4gd3EgYmVmb3JlIFREUiBpbiBkcm1fc2NoZWRfc3RhcnQ6DQo+ID4gICBodHRwczovL2xv
cmUua2VybmVsLm9yZy9kcmktZGV2ZWwvMjAyMzA0MDQwMDIyMTEuMzYxMTM3Ni02LW1hdHRoZXcu
YnJvc3RAaW50ZWwuY29tLw0KPiA+IGRybS9zY2hlZDogU3VibWl0IGpvYiBiZWZvcmUgc3RhcnRp
bmcgVERSOg0KPiA+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZHJpLWRldmVsLzIwMjMwNDA0
MDAyMjExLjM2MTEzNzYtNy1tYXR0aGV3LmJyb3N0QGludGVsLmNvbS8NCj4gPiBkcm0vc2NoZWQ6
IEFkZCBoZWxwZXIgdG8gc2V0IFREUiB0aW1lb3V0Og0KPiA+ICAgaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvZHJpLWRldmVsLzIwMjMwNDA0MDAyMjExLjM2MTEzNzYtOC1tYXR0aGV3LmJyb3N0QGlu
dGVsLmNvbS8NCj4gDQo+IFdoYXQgaXMgdGhlIHN0YXRlIG9mIHRob3NlIHBhdGNoZXM/IElpcmMs
IHdlIHdlcmUgZXhwZWN0aW5nIHRoZW0gdG8gYmUNCj4gbWVyZ2VkIHNvb24gYXQgWERDDQoNCkkg
c2VlIHRoZXJlIHdhcyBhIG5ldyB2ZXJzaW9uIHBvc3RlZCB5ZXN0ZXJkYXk6DQpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZlcy9kcmktZGV2ZWwvMjAyMy1PY3RvYmVyLzQyODYx
Mi5odG1sDQoNCkl0IGxvb2tzIHByZXR0eSBjbG9zZSBub3cuIFdlJ2xsIHJlYmFzZSBvdXIgcGF0
Y2hlcyBzbyBob3BlZnVsbHkgd2UgaGF2ZSBhDQp0cml2aWFsIHJlYmFzZSBvbmNlIHRoZXkgZ2V0
IG1lcmdlZC4NCg0KVGhhbmtzDQpGcmFuaw0KDQo+IA0KPiBUaGFua3MsDQo+IE1heGltZQ0K
