Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314F7F3B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjKVBKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbjKVBJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:09:57 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9917B10D7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:09:30 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALNMmmB030862
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:09:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=9ALdCNBub2FG8EpVPJaSh7DMiahUFEDTo/5p8mGoXEE=;
 b=DKZFGHEUgHJAVJkyJGO4wjgmp/f42xJXlopuEwDxPvyBLIy2ggYeMZLv2KfIsIQrTOvy
 pK76EGRV9iHTmWg1NEs82qTwhsqmFZYUTWSFh/yRKsiR/kzF9YZtb2BNhrJRcHaS3O0y
 re96D3nskEzQutQ6wesbeZOLISCoAeKpQ95v/YnxV/cTT48vVTNYrB7ecNPE9NUJNqHj
 98qHfZHrqQG8Yym8ZSlsHJrlnuJBGfACg5I1XE4wE3+mKv73auO1eo6tY64zPPXSlj+b
 Jm84ag1ObALQHukX2wkWMnT9l2tJL7l4pB258OmAqxLkMswGIJJBP6ufRjHjIH9ekCBy AA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uh65qrng6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:09:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6033p8Sz8Iltb3NOdRKKZ1VQgqCXRvBFskVl10L+DqYcrvTdXVLYylNVLDnQ4cgZnd6FVOAOyxQ8fVs6kxfwAjcUw8yTReu6itjkpn6w/7bHNVCvh0NRmy4eXoffQG3wT95nf7mAA/szAGCHy8oKHujRdtsPNpqKZ7bUjZFjSxP9oia4RVmdXRDydMqODs3HuU7mrP14ZanorWusR4eLPgRfD9IWjbts3vksuXRgim6VrQg5glrlsxmkVRnU9SnNqQH+qqMJyG/df5h6xkeqfAEpZAyZe3NIlLTnovv491BeqDx+Os1mXlKd5R+wtmHSVlLdngUVWZ6g7fsyU9Waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ALdCNBub2FG8EpVPJaSh7DMiahUFEDTo/5p8mGoXEE=;
 b=SF9UPwuZV+B4WgOiuOpQZnreRqePhd5iGNttxquZO6pFWsv7xA30fOSCiZ0ibltBJlvLUtH5ZSiFSLQ+oaRccstSUAOcQ38CaTwGJr2uvFFsAiDVeuFEsMfC8jfjAuSS9TnmjuKZ67o8k1McGCScLgIOOSew/0KOL4KSSPWyBDU5nl7VxrgXgp/qCBn4YI2yKxouYnP8y9nUErWWA6/chJVvnzJ1eXEhQYSosOsFw2UZKEKEuyr9s3VhTiq9OI5wUWsfaubCBPeYBoVovTRhqsqElZz5S8A8l7BnYeUKVl5tAhoinGpjrvBJCNA3AyXl1u0tg6vfWnr1Lizi/ptqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by PH0PR15MB4671.namprd15.prod.outlook.com (2603:10b6:510:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 01:09:27 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::cbea:e86f:62db:9b00]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::cbea:e86f:62db:9b00%3]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 01:09:26 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Nick Terrell <terrelln@meta.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yann Collet <cyan@meta.com>,
        Kernel Team <kernel-team@meta.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH 2/2] zstd: Backport Huffman speed improvement from
 upstream
Thread-Topic: [PATCH 2/2] zstd: Backport Huffman speed improvement from
 upstream
Thread-Index: AQHaHBTz4ziGxvjb9UezyAE3hPe067CFBqAAgAAroQCAAAO+gIAABkSAgAAFi4CAAEcOAA==
Date:   Wed, 22 Nov 2023 01:09:26 +0000
Message-ID: <1DBF3B5D-C19B-4D95-92B2-FF7EA4CC759B@meta.com>
References: <20231121010318.524570-1-nickrterrell@gmail.com>
 <20231121010318.524570-3-nickrterrell@gmail.com>
 <CAHk-=whL+1xR_LJwJ7DRhFo2gkDv0jrRMX5PJoULoSBXppEV8A@mail.gmail.com>
 <D42705E6-94D3-4E3B-9BA8-AFFCE4B8E4E4@meta.com>
 <CAHk-=wjcft4VEVBwSeaczuonUAGyT4BKt5PimekDpL9ygHC5cg@mail.gmail.com>
 <41F084AA-F027-4288-9F26-E33337E1516A@meta.com>
 <CAHk-=wgF4ooJa18rYNZZQucn4YvVv+f1PCzm35_WHysyeEL+ng@mail.gmail.com>
In-Reply-To: <CAHk-=wgF4ooJa18rYNZZQucn4YvVv+f1PCzm35_WHysyeEL+ng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|PH0PR15MB4671:EE_
x-ms-office365-filtering-correlation-id: e3d04b51-139d-40be-defa-08dbeaf7ac1a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9dH0pmo9a9TAb6dyW18AWiYEX/XhOTzNmhNnOSpIWHWocIWS9u3Xqe6V7LRnC4H0NziOiPcjYR20ZdVU8C8/V8JVPs8DH6Kp4Im5jwHDpEIcfd6CrkMDkkmAF5zehigJlL6gV5w4lXXPlSIsbz+SBeSOCK6YHO6NPXH5GhOcwmfArKpuJ5osuN5mll3IByRuWIqfGWgmPADze0aBuRpDyC1+gkuE3GhyIG2Ny+OOCMLfm81fWjgHw5C+Z5WSViheh87Pm2IfFusENZTj7TV5APa6xN4PSSMpaOcAOvTTblJ6NJ1Vg5A40ZVpP0OtEilNrddm6iLkvcWR5AHnZnCHKWKVZxpJi+ntdy45t1pvcJ72RD3aqsItpsWY4BIBUYSu9A8ZGDABUpHQJDLWwhIRRREqe3p1f+J+omTqS8YhkXNkjv9UbO8nLzUw5Mp+BKLqGHhF/XBxSTqxgde8KcSzvh9hOtNrN+mMKKy5d3vSxoIXwSmEn52Q7UUAT6cIWpSlQMLj5VikIO0EZ3vO+l/lFLwprgtbLpUbzHmQ14+dFAnBNjENeBQThveHMc1BOm2aB8OLq3XqcumDxaqAjMeUyKGp2pcYS4dn+TMcdGaXPX8CnlWyQdiqT2FEHPALEwuKa4IircPkMooaixovb9xsHQ2WQPR0TC2pn7KWkTMIem7B2hd3pZHcYNc+KzHDVB/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(1800799012)(64100799003)(6512007)(316002)(6916009)(76116006)(64756008)(66946007)(66446008)(66556008)(66476007)(54906003)(8936002)(4326008)(53546011)(8676002)(6506007)(83380400001)(5660300002)(33656002)(86362001)(6486002)(966005)(478600001)(38070700009)(122000001)(38100700002)(36756003)(26005)(41300700001)(2906002)(2616005)(91956017)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjJ3VkxyK3g0M2hrd091UlcrZlptUkpnTmlhWTltR2xPTjBtVGJxZWRIbUdi?=
 =?utf-8?B?ZXgzUXZBUnM1K3U2K3dWVmkwVlBuRFVheDVkTi9oZ0xERFNkOXY4SDFVQ0t1?=
 =?utf-8?B?UnM1TmJhMUw4Z0hkNHc3QlJZdWZ2MXF2UXpJTGI0aVp1ODZtVjdwUHhhSU1t?=
 =?utf-8?B?TWw5VXoyWWk5QmxjaWQ4b1VEeHl1dHlSb0UyNTgrL0FubTVVOVNBbDRsVnU0?=
 =?utf-8?B?MXkzL3RBaVl4VjM0NmZ4SHhWZ2NMajl5enRYZzFxMlBmWG4wN2Q4QU9GZFBh?=
 =?utf-8?B?TWY4SUNDT2ZCNmhJUFEzY1g3Zm1OQUExRVhYVWFHaHY0b3dhR1lCYXljemgr?=
 =?utf-8?B?ZC9ZSENUbXgyYkZwTVhTTHJRSHBSNFRWaEhvOEMyaGw5U0Y1MU9aS2JjaFd4?=
 =?utf-8?B?R0k3M0VRSzJ3ZTRZbzdBbXNhQTg3dzgrcW1DLzVUNjIwUldOUDVjdzFtZ2Vs?=
 =?utf-8?B?c21KNFc3L1NpeHltK01SdUtQSTEwU2RERlJ2TlJxM2RmZFlDREVEUytLRm4w?=
 =?utf-8?B?MUgwbDJ3aEIwbjRRVllWN2NSOGYxU0pzTkFuSVpwOU9jNGdtclVNVWdjZXNG?=
 =?utf-8?B?S3JNWktYRWRoSzZleEt1WFhwZkdCQlZ0WkUyTWVaaGhraVpQQTNtRmdpb3NJ?=
 =?utf-8?B?SU9OQi9VRlNIZkpaVERPc0hCY0daeitYaVloRmZyZkRpKzNvZkpsaGpGZUxm?=
 =?utf-8?B?eVZlTGgyWDlpKzNMK3QxN0xEQWJlTlZoYXQ2bDA3OTZlbDZlRGlCT0c0NHIz?=
 =?utf-8?B?Zk45K29nenBnUG1wNE1WRko1U0w3S2JMUmVDeXUrWCtwVzdXT1kxV2toZjZn?=
 =?utf-8?B?TTE0S3dWVFcxb29lVmNuZW9mY1dpb3BaaHo1ak1RMFc2SWpwTytVOWZFSDEv?=
 =?utf-8?B?R053ZEl4NnEvY1NpN1Q3M2w0TCtyL0FkMmowUGk3Nnhabi9YaHYwMWtaTUlx?=
 =?utf-8?B?eFViVllKSjc0OXZhV2VzdGJzVC9sNHdGYzdsdGZKa29qKzdqdi9BZEh0VWR0?=
 =?utf-8?B?SndtNHpmQzNiajBsUUIrQjZkMTZHL1JsSE1uYmFIS204Y3huMUNYblFlNXA2?=
 =?utf-8?B?Vkc1V0kxQnowdG1BQUVFckNBdXpYNWFpNEhpVkY1ZlRFMldGS0syYzdkTmhu?=
 =?utf-8?B?WTVnZjlrMUE5bnI2N243RUhVWlE4UTVrNHFPTmZyUUdwUzE3aHY1WmhVZzMz?=
 =?utf-8?B?NDU1RVZ0L0N3VnZ5OFFtYkFVenRLQXZuUmhFbmtTSS9aNjUvT1BzZDhOMnY3?=
 =?utf-8?B?V3dVcFhMdDFqbXZyWjlUZmJSbTBhelN6ZFMxNDJtUkJlVkFTOHd0d09tL0d0?=
 =?utf-8?B?Z2dQMjFld29JQWNMZXEvWXZEbk5KbGVRQlEyaUxPYnlqRDNwQXo0cE8rWTlw?=
 =?utf-8?B?bEFDdlAyamo3cmM0TnA4eTJLcXFVVktQTWRMVThqdkMwaUp0YnU1S1loWE1X?=
 =?utf-8?B?Q1A4ZlhDanE3UXpmbm9yc1ptV01pTGRuWnpLYWVJVVZraWhjOThOZlRlWlpO?=
 =?utf-8?B?VU5VRmg5VDZQNkpPM1RkMURwcmZLQ2JyQmZnUTBTekRZYUpGZ2RTUVA4OHV2?=
 =?utf-8?B?TERmM0k0elo4SzdJK00zSHdvaUtNU0ZoR3RWaHkvWlFITkNxV3VLOWRuVXNn?=
 =?utf-8?B?bDNJOGI2NUhXWVZxZDR6NHZpM2ZwYjJDVHM0cUYxSi8xRHEzUGc2YTNyZVp6?=
 =?utf-8?B?WlZnakdyankzUEgyY0ZHSFZlblFUUDRIeWNxUSttak0zRzR3VXducGpQUHRx?=
 =?utf-8?B?WkJpcnJDdVBBSytBNkZwWDhQSWYvTGJxU21RM1FBeEhpbnlHdDEwazhoMWRD?=
 =?utf-8?B?Rjh6M3c4STdzMVZXRkRpYkR2Nk93Q1JOV2JnNVZEZWRIb21LajliYTFtdUw3?=
 =?utf-8?B?NDJOQUd0ZzBPdENiRHc5N3BiVUE2VThRR2QxUXlHUjJIL05ZVWtsQ3lCRVk1?=
 =?utf-8?B?T2hraGpEWHJwVEV1eW41b2E0V2xrV1QzZXdDSTZPTlk4ZFJIUXgrK1grZUcy?=
 =?utf-8?B?bnFzeXJ5RFI1dUlvUDlBdFFScGlYNm5RaDJSZkNld3JtUGtCUVlTSnQycEw2?=
 =?utf-8?B?b3VpeWZXWjNmZHhzaU5DbXl4aC9IUTdDL0Q4dzF2UWhkWkhNYW1VdlNjVitj?=
 =?utf-8?B?VnllVTdYdzBYeEdLK2xqYStnSkpGZU9KTDhkbzFGVG1ybGtBNnNHdXNha29N?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <433ADE2155154947AD4A205C8C49FA28@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d04b51-139d-40be-defa-08dbeaf7ac1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 01:09:26.7745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Msd/x2K32Rf/KkH6zaXB6m9sYUp3mTpzcjxewaSgneNHtOTZbWGSoFDLXcbpcY7rBrLd1IG2dapiiahJ/Ty1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4671
X-Proofpoint-ORIG-GUID: QEfgjztiB-JV64TuG3cvwGWuz_kXxf97
X-Proofpoint-GUID: QEfgjztiB-JV64TuG3cvwGWuz_kXxf97
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_16,2023-11-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDIxLCAyMDIzLCBhdCAzOjU04oCvUE0sIExpbnVzIFRvcnZhbGRzIDx0b3J2
YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDIxIE5vdiAy
MDIzIGF0IDEyOjM1LCBOaWNrIFRlcnJlbGwgPHRlcnJlbGxuQG1ldGEuY29tPiB3cm90ZToNCj4+
PiANCj4+PiBIb25lc3RseSwgYW55IGNvZGluZyBydWxlIHRoYXQgaW5jbHVkZXMgImRvbid0IHVz
ZSB0aGUgZG8td2hpbGUtemVybw0KPj4+IGNvbnN0cnVjdCIgaXMgYWN0aXZlbHkgYnJva2VuIHNo
aXQuDQo+Pj4gDQo+Pj4gUGxlYXNlIGp1c3QgZml4IHlvdXIgdXBzdHJlYW0gcnVsZXMuIEJlY2F1
c2UgdGhleSBhcmUgaW5jcmVkaWJsZSBnYXJiYWdlLg0KPj4gDQo+PiBZZWFoLCB0aGF04oCZcyB0
aGUgcGxhbi4gVmlzdWFsIFN0dWRpb3MgZml4ZWQgdGhhdCBjb21waWxlciBidWcgaW4gVlMyMDE1
IFswXSwNCj4+IHNvIHdlIHNob3VsZCBiZSBzYWZlIHRvIG1pZ3JhdGUgdG8gc2FmZXIgbWFjcm9z
Lg0KPiANCj4gSSBkb24ndCBldmVuIHVzZSBNU1ZTLCBidXQgYSBtaW51dGUgb2YgZ29vZ2xpbmcg
c2hvd3MgdGhhdCB5b3Ugc2hvdWxkDQo+IG5ldmVyIGhhdmUgZG9uZSB0aGF0IHNpbGx5ICJhdm9p
ZCBzYW5lIEMiLCBhbmQgeW91IHNob3VsZCBhbHdheXMganVzdA0KPiBoYXZlIGRvbmUNCj4gDQo+
ICAjcHJhZ21hIHdhcm5pbmcgKGRpc2FibGU6IDQxMjcpDQo+IA0KPiBmb3IgTVNWQy4NCj4gDQo+
IEhvbmVzdGx5LCB0aGUgZmFjdCB0aGF0IHRoZSByZXN1bHQgd2FzIGluc3RlYWQgdG8gZGlzYWJs
ZSB0aGF0DQo+IHN0YW5kYXJkIC0gYW5kIHJlcXVpcmVkIC0gY29uc3RydWN0IGluIHRoZSBwcm9q
ZWN0IG1ha2VzIG1lIHdvcnJ5DQo+IGFib3V0IHRoZSB3aG9sZSB6c3RkIHRoaW5nLiBXVEY/DQoN
CkFkbWl0dGVkbHkgb3VyIGNvZGluZyBndWlkZWxpbmVzIGFyZSBvdmVybHkgY29uc2VydmF0aXZl
LiBBbmQgaGVyZQ0Kd2UgYXJlIHVwZGF0aW5nIHRvIG91ciBtYWNyb3MgdG8gdXNlIHRoZSBkbyB7
IH0gd2hpbGUgKDApIGNvbnN0cnVjdA0KaW4gdGhpcyBQUiBbMF0uDQoNCkhvd2V2ZXIsIHdlIGFy
ZSBhbHNvIHZlcnkgY29uc2VydmF0aXZlIGluIG91ciB0ZXN0aW5nLiBXZSBoYXZlIHZlcnkNCmV4
dGVuc2l2ZSBjb3ZlcmFnZS1ndWlkZWQgZnV6eiB0ZXN0aW5nIHJ1bm5pbmcgY29udGludW91c2x5
IGZvcg0Kc2FmZXR5IG9mIChkZSljb21wcmVzc2luZyB1bnRydXN0ZWQgZGF0YSwgcm91bmQtdHJp
cCBjb3JyZWN0bmVzcywNCmFuZCBtb3JlLg0KDQpXZSB0YWtlIHNlY3VyaXR5ICYgY29ycmVjdG5l
c3MgdmVyeSBzZXJpb3VzbHkuIElmIHlvdSBoYXZlIGFueQ0KcXVlc3Rpb25zIEnigJlkIGJlIGhh
cHB5IHRvIGFuc3dlciB0aGVtLCBhbmQgSSBzaG91bGQgY29sbGVjdCBvdXINCnRlc3RpbmcgcHJv
Y2VzcyBwdWJsaWNseSBpbiBvbmUgcGxhY2UsIHNvIHdlIGNhbiByZWZlcmVuY2UgdGhhdC4NCg0K
SWYgeW91IGhhdmUgYW55IGZ1cnRoZXIgc3VnZ2VzdGlvbnMgSeKAmW0gdmVyeSBvcGVuIHRvIHRo
ZW0sIGFuZA0KSSBhbSBncmF0ZWZ1bCBmb3IgdGhlIHRpbWUgeW914oCZcmUgdGFraW5nIHRvIGlt
cHJvdmUgenN0ZC4NCg0KWzBdIGh0dHBzOi8vZ2l0aHViLmNvbS9mYWNlYm9vay96c3RkL3B1bGwv
MzgzMQ0KDQo+IFRoZSBkby13aGlsZS16ZXJvIGNvbnN0cnVjdCBpcyBfc29fIGltcG9ydGFudCB0
aGF0IHRoZXJlIGFyZSAoc2FuZSkNCj4gcHJvamVjdHMgdGhhdCBsaXRlcmFsbHkgKnJlcXVpcmUq
IHRoZSB1c2Ugb2YgaXQuIFNlZSBmb3IgZXhhbXBsZSBNSVNSQQ0KPiBjb2RlIHNhZmV0eSBydWxl
cy4NCj4gDQo+IFRoZSBrZXJuZWwgcnVsZXMgYXJlbid0IHF1aXRlIHRoYXQgc3RyaWN0LCBidXQg
eWVzLCBkby13aGlsZS16ZXJvIGlzDQo+IHZlcnkgbXVjaCAieW91IHNob3VsZCAqYWJzb2x1dGVs
eSogZG8gdGhpcyIgYWxvbmcgd2l0aCBhbGwgdGhlIHVzdWFsDQo+ICJtYWtlIHN1cmUgeW91IGhh
dmUgcGFyZW50aGVzZXMgYXJvdW5kIG1hY3JvIGFyZ3VtZW50cyIgcnVsZXMuDQo+IA0KPiBXZSBo
YWQgc29tZSBSRkMgcGF0Y2hlcyBmb3IgdGhpcyBhcmVhOg0KPiANCj4gICBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMzA1MTExNTI5NTEuMTk3MDg3MC0xLW1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbS8NCg0KQWdyZWVkLg0KDQo+IEFuZCBvbiB0aGF0IG5vdGUsIHdoZW4gSSBn
b29nbGVkIGZvciB0aGUgc29sdXRpb24gdG8gdGhlIE1TVkMgYnJhaW4NCj4gZGFtYWdlLCBJIHdh
cyBkaXN0cmVzc2VkIGJ5IGhvdyBtYW55IGhpdHMgSSBzYXcgd2hlcmUgcGVvcGxlIHRob3VnaHQN
Cj4gdGhlIGRvLXdoaWxlLXplcm8gcGF0dGVybiB3YXMgc29tZSAibGVnYWN5IHBhdHRlcm4iLg0K
PiANCj4gVGhhdCBqdXN0IHNob3dzIHRoYXQgdGhlcmUgYXJlIGxvdHMgb2YgaW5jb21wZXRlbnQg
cGVvcGxlIHNpbXBseSBkbw0KPiBub3QgdW5kZXJzdGFuZCB3aHkgaXQncyBhY3R1YWxseSAqcmVx
dWlyZWQqIGZvciByZWxpYWJsZSBwYXJzaW5nIG9mDQo+IG1hY3Jvcy4gIFRoaXMgaXMgbm90IHNv
bWUgImhpc3RvcmljYWwgc3R5bGlzdGljIiBpc3N1ZSwgaXQncyBsaXRlcmFsbHkNCj4gYSBjb3Jy
ZWN0bmVzcyBpc3N1ZSBmb3IgZ2VuZXJpYyBtYWNybyB1c2FnZS4NCj4gDQo+ICAgICAgICAgICBM
aW51cw0KDQo=
