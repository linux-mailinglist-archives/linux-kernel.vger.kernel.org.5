Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10DA7ED7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbjKOWyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjKOWyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:54:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADCEB0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:54:02 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3AFMlRi9022748
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:54:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=43q+ZYEvk/C15FGvGSBnNmb+onzPlj/Z3eZKLpcMCTo=;
 b=XiMpfofPmpa4Ijp+NThYk3daYXw5WV6tTw68cOcqgVm4avUabogvotJOq3CglkSmYto5
 enozpuottvE9JfY5ZnXQBy13nsy8lub6BCn7z5PXav7jmQHL7277r5RETj5aZ3ee/1Fo
 joCFexLMFVEv6gz41GkEsZzCq1tm0jnEsuGsTOyW2yJCrSGncX8LLOt6qNYec1zfRwy3
 rhNotmlaQFmByoF7gqtP6lXkYc4gjzUWSK4gVPXx5HE1u0AZ6dmusTYeRW5i351r++VC
 0W+yyP+YI1oXK4hD9tC1en4TKvxSkcxg4RyyBEDV/FYdwBblCviLpHot2gPMgpHvP0Ts oQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ud739r106-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:54:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcNc85L6Rys/mimi9u6m2e20Zsex9sLQA+wBDTZbz1Soe4KbjmSRK1b/dC0bpEwOfqoHB9SCyZEk5ZCPuQFq6zJWy14o+f3DWyVqxekzUz9Ormnm85W5kLgkWEHrwYFeECV0ctp/a08KbMKdOJTuvbnBHhEk8jnJHtloI0MKJEuT69s1D/bAMKfi09biXKN0Auue0y2DtubfDwrZ2K4cjQeBJSMBFrxBRLTxHTXqHB2EeOTMLs8K2SEdU3x0ivXvBV+M9WNm+zyWWXR8ctwDqf0b1r2P7eI5HjXPu2e2jdIK5UYxqsZxzm1jwAtXHmtrdgD30A1Bto2udxLHztwtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43q+ZYEvk/C15FGvGSBnNmb+onzPlj/Z3eZKLpcMCTo=;
 b=J/7cX1da0TZrIX2yYVGugemv5LG++8iy4Ucr+MRtU/oDG/0ogoqtTPx9rUtQPfErrQ/i775724SSARfQRszvLBzmSEagRXbAdv6fZagiypx+qbRTyw4tLqn0YJSwFfIjJ4SMXDIXer/KWQsbGJZzTI6fbdf0x4h0B9yqqiJPB4FBJHp2Dujy0GVRB3oWMrciJ/L9ubm0L1vKTi0uIKxsHCqbfKYFv0lU0Tu7EC7MQGqJZMt9x8hOZKbnJdCVZ+yWCGj9kBA6wbAY2I0LoufvjTh53uhsF5crbge+PKrdkROP6krT9M885ba/DzMFP7MraLNFhdSq6j+wDc8PT71cRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by CH3PR15MB5973.namprd15.prod.outlook.com (2603:10b6:610:157::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 22:53:59 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8ac6:61ac:17f8:b62e]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8ac6:61ac:17f8:b62e%4]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 22:53:58 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Nick Terrell <terrelln@meta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>
Subject: Re: [GIT PULL] Zstd fixes for v6.7
Thread-Topic: [GIT PULL] Zstd fixes for v6.7
Thread-Index: AQHaF2F6xzdOtZ/e9UWjsukLkoyCJ7B6ypKAgAEygIA=
Date:   Wed, 15 Nov 2023 22:53:58 +0000
Message-ID: <99FB2702-BF9A-49A5-8180-A6BDBB34DC9F@meta.com>
References: <11692A57-6A65-4ADE-BAE3-169D50A1FC16@meta.com>
 <CAHk-=wgSBZG6ZaYe0pFm7iJL9Yab64zGdOVkLg2-FfhsXTtx+g@mail.gmail.com>
In-Reply-To: <CAHk-=wgSBZG6ZaYe0pFm7iJL9Yab64zGdOVkLg2-FfhsXTtx+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|CH3PR15MB5973:EE_
x-ms-office365-filtering-correlation-id: be8f4209-01c8-45b6-7f5a-08dbe62dc0c9
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VQPVpG5HyCJ1MJfBnIf75etqb5OPaVl/CimoUpYISJhz6YM+FgDIhGdrpu7tNhOnJ0U8w8FUnwQVd2X9r1mA+A8Z6l0MWBb+9p8B6hivylFtGiFFmR7RlOsqvR2A00gwmHhG3HbF9Zb5vlLsjyZMPRlMMyWMZXg8YglBobcTmEYTk9kbzB8T3te/Ra6soN2LSRgjM9VaOy6U8ewfavdJthjHJatvG0zXIl9B202zI9q1upEDJVzsMzwzQ1aafnceDb4Uc9e8hwsLz6o1qEh5HVWlNeTRMZKn1aZ8Y7IQwOnVERjgqONOEnY3Hg5A2AHIgcRdfKSo7BfF8Zba5FJoefC4Z1UGIajWVTm1SENVacZ3qXVSm1JaIZOKmyRGsGbxfPL+RFF9nL9pkt4+aj1TGeP6WcGLUkKAd2/xafWvUjTJtTYABspSHSzR5wU95nU1dn20ErdDfwF7vatC9brS3NPgGoJgBXtjSMNJhpGirTeyYi3tdZAjBplkBwe81UxpBneZaEqkRUxs4h/OjdWV08nXD1bZWSQ5VymhI9qxBDbeC0v0grgdFAYBz1E2XVffl9wvrWI3Txchrz63CcxEdj/C2IU/zAvZcun3JxSJVM4cO49yUoAaV0f9dzDBgc2tIsWbN4QQSDMwhDCr/s2BI3xpHFFIrfjlm7PHiqS2Z+F9JqvlwPJRJku8VRJrOukF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(1800799009)(451199024)(6512007)(2616005)(33656002)(38070700009)(478600001)(6486002)(36756003)(8676002)(4326008)(66946007)(86362001)(2906002)(41300700001)(5660300002)(66476007)(76116006)(66446008)(66556008)(316002)(6916009)(8936002)(54906003)(64756008)(53546011)(71200400001)(6506007)(122000001)(83380400001)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHNrOVdKZTdSdERudS9vZjNTSE51MHM3eVppS0x0cnFZbCs3R3o1MjNVNTBT?=
 =?utf-8?B?bHZYelJEM2FmcXV1WWNuRGVCWnVJT1FseFlQMFBNc3ZFOFQ1cWpCUFptMjNy?=
 =?utf-8?B?YlpWTFhlYXJCQzZtdHNPN1E5ZjNmN1hqckM4UXRDUUlnRWx1dnJ2Nk5GclZH?=
 =?utf-8?B?M05kTHJhMU1mUXNPMktLbEpCcktUYlA4NTNRYU9KdzJWRlAvcjNKdmgxbEF2?=
 =?utf-8?B?aERlMHdua2I0RzhhRzJleW1Bc29VaVhpM08vaTVxbC9pR2FOMmQva1NkbDlX?=
 =?utf-8?B?eDF4eVJUOGpIM0EvZEhJSnNOaHUzQURFbzdiQnBVMlhaNFdycTdUUkQ4ci8r?=
 =?utf-8?B?VWZCaDhXNTVhR2VrUzJlM00wZk5QYnNicTkrTHJDak8rRGxQY1J2OVUxSUEr?=
 =?utf-8?B?TnhoblJJdjJyOGNWSXlwUGpMdzdBNTg0NTNMWHcyL0Z2L212U1pRVWhBNDRF?=
 =?utf-8?B?YTB2RkhHNUlZTC9Zd2d6RnhYK3grQWNJeitjSHZDb0xMZEY3ZTgyYU5RMmVj?=
 =?utf-8?B?QVo4emVGc3FJeUlNQ29nRGxnY3hHS2RKdFNlVzA3Uk1QZU9ib2cvUVV4WHdq?=
 =?utf-8?B?VVJ2NkxhVXc0eTBQMVpDdnBsYTRMV1BuR3JyalRCaVd2T1FINk5wZDRxZmtQ?=
 =?utf-8?B?Rkk0TnhxU25vVnBCYURhMDZSVGxKSmZWQ3U3YXBCU1ZTVFh5bXhTeStxbTN6?=
 =?utf-8?B?WEllc0FVZ0tPMHhBbnpqaXMyZWErTCsxR09TOUF4cEtqRk5ZQVErb3ZYd05T?=
 =?utf-8?B?NjB0MUZrM3dvL1I1YjVQTzVZdHE3SERFSzFVWE9ZYmR0T3IxeVRDaTRGNTRK?=
 =?utf-8?B?VGJrNXJ5QlorMG1YbzJrWWZ5bTMvd0dkbFhBQkRmdXRTcE5wZzdUS2pHZkxM?=
 =?utf-8?B?Z2tMZjY3ZXV4SFZFK3VjTFlrdm50dXlkdXVldnZxNURDSnNsdWc0NlZ1MWtF?=
 =?utf-8?B?M0ZRdngyNkp3QjV6MzFIOEU0djFoeXVXZndVRlBxMmhCYjhnanlKbXlDRGk2?=
 =?utf-8?B?WXFCRXpQQzNDZ3hFY1hiWm5Ka3cyL3drcTJRS2RwVkFuZnErVVNXbzdTaDNk?=
 =?utf-8?B?ZlBiZ2VZUkhKN2FmN2dNcmpUVGNXbGgyUG8ya1RPQURKTjNVUGt2UGh6eTZk?=
 =?utf-8?B?SktydE81V2tmV21DL0VjUklIZHAzeGRMLzdMYVdLRDFSOGszbEppeEZGKy9I?=
 =?utf-8?B?RnhGL056b2dFRmcyVDBLNjZBcHloQXNVSmZqLzExRWhYWkJiYW1ndmRRYmEr?=
 =?utf-8?B?RXRkVzczaWdIMjFVZjkzNjB6cWlxSjVWMCt6eEV4TFBZSFhhcGx3bnN4ZTRz?=
 =?utf-8?B?aHByTEI4MXNKbUJtS3c1cXV5aFh4bnJVL05vZzNPQWNtVGxpaXNIOEp0WFpo?=
 =?utf-8?B?cWVCdzUxU3BDd2IvYzc5VGhsbUNzL3llTE9mcVB0NTZwSVZRSnpZMXdibUNJ?=
 =?utf-8?B?a0Nnd2pMLzhXaTNsSmxEMnBuSmNEcFNXc2FULzQya0lSdG1EYmdaZWdUSnds?=
 =?utf-8?B?SmRnNnhwVG1iZ0lxRjluZDBrcDhVcG9yUDdnRTRDUitsVjVnblBqbGpqVFhH?=
 =?utf-8?B?dVprd3hHZXM1akhQZFdNcGRnSndHUGhtZU1JdDU5cytJdSsxN1oweTFteitD?=
 =?utf-8?B?RHVlUGVYL3NhSldnZDVFV05RU0c2M3RuVTRRSWNORXlMWjhIcjdEMi9XeHBK?=
 =?utf-8?B?SUZHWVRkWTh5clBzdmJXUkpHTXdkWFd5Z3FMY2d3UVlQS2xyeGZZM0NIcGtF?=
 =?utf-8?B?enNVYjF3SnZQSGZqTXZlNGYwa3U0VjRobWVyUVZJeFpqS3hZVFJOem9XSU5C?=
 =?utf-8?B?bHNWS2JEdnNLK2ZHZ0RwdHA3SVFHMEV2Nk5mbHQ5eUg5Y3p1S0Jicjh2dENP?=
 =?utf-8?B?TDdUcU9DL256aExSZUJ3akcrNVNDdVA5MlFlWUdCRHJNVG5PQy9GN1dTcVBz?=
 =?utf-8?B?bDl2SVliSzArOFlpcWkzWXRXemFwZ05zbldOMG81WFNiZ1NIOTZpNWpwK08r?=
 =?utf-8?B?a292d0pFVFBzc2t5bzVWMTV3NEFaUFBFMWVxMGxickNHaDgxTTdkOTljcDFq?=
 =?utf-8?B?NHlweWlDOUxZeXlnMWphbDdjbU0zZ2FiTWVpa0g1cFlYcEZZUy8rQXR3b2Yx?=
 =?utf-8?B?SDZsbE9KdDRmVHRLazc0dlprdkkzYmRsVit2cUxIdG53eWpaWTFEaXpneFJr?=
 =?utf-8?Q?BHBzf1lJRWt/kSn/C9ACJbM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CCA8F310EE26947ADBC64CC3A4825F2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8f4209-01c8-45b6-7f5a-08dbe62dc0c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 22:53:58.5065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMTsrRYLJP5sVcm1cls/kBYwcM8Cog0YfaWt73je74Oliog3NfWUVQIP3Xm+7ZszYy7GIu7l4Zhgh/m53LEJoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5973
X-Proofpoint-GUID: oTZpCR7ZPrqmBRdlcsPQeXh958Zgslgk
X-Proofpoint-ORIG-GUID: oTZpCR7ZPrqmBRdlcsPQeXh958Zgslgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDE0LCAyMDIzLCBhdCA4OjMx4oCvUE0sIExpbnVzIFRvcnZhbGRzIDx0b3J2
YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDE0IE5vdiAy
MDIzIGF0IDE3OjE3LCBOaWNrIFRlcnJlbGwgPHRlcnJlbGxuQG1ldGEuY29tPiB3cm90ZToNCj4+
IA0KPj4gT25seSBhIHNpbmdsZSBsaW5lIGNoYW5nZSB0byBmaXggYSBiZW5pZ24gVUJTQU4gd2Fy
bmluZyB0aGF0IGhhcyBiZWVuDQo+PiBiYWtpbmcgaW4gbGludXgtbmV4dCBmb3IgYSBtb250aC4g
SSBqdXN0IG1pc3NlZCB0aGUgbWVyZ2Ugd2luZG93LCBidXQgSQ0KPj4gdGhpbmsgaXQgaXMgd29y
dGh3aGlsZSB0byBpbmNsdWRlIHRoaXMgZml4IGluIHRoZSB2Ni43IGtlcm5lbC4gSWYgeW91DQo+
PiB3b3VsZCBsaWtlIG1lIHRvIHdhaXQgZm9yIHY2LjggcGxlYXNlIGxldCBtZSBrbm93Lg0KPiAN
Cj4gSG1tLiBZb3UgY2xhaW0gaXQncyBiZWVuIGluIGxpbnV4LW5leHQgZm9yIGEgbW9udGgsIGJ1
dCB3aHkgdGhlIGhlbGwNCj4gd2FzIGl0IHRoZW4gcmViYXNlZCAqbWludXRlcyogYmVmb3JlIHlv
dSBzZW50IHRoZSBwdWxsIHJlcXVlc3Q/DQo+IA0KPiBUaGF0J3MgcmVhbGx5IG5vdCBvay4gUmVi
YXNpbmcgbGl0ZXJhbGx5IHJlbW92ZXMgdGhlIHRlc3QgY292ZXJhZ2UgeW91DQo+IGhhZC4gV2hh
dCBwb3NzaWJsZSByZWFzb24gd2FzIHRoZXJlIGZvciByZWJhc2luZz8gQW5kIHdoeSBkaWRuJ3Qg
eW91DQo+IG1lbnRpb24gaXQ/DQo+IA0KPiBTbyBzdG9wIGRvaW5nIHRoZXNlIGRvZGd5IHRoaW5n
cy4NCg0KSeKAmW0gc29ycnksIEkgd2lsbCBkbyBiZXR0ZXIuIFRoYW5rcyBmb3IgdGFraW5nIHRo
ZSB0aW1lIHRvIHBvaW50IG91dCBteQ0KbWlzdGFrZXMuDQoNCj4gSSBoYXZlIHB1bGxlZCB0aGlz
LCBidXQgZGVzcGl0ZSB0aGlzIGJlaW5nIGEgInRyaXZpYWwiIG9uZS1saW5lciwgSQ0KPiB0aGlu
ayB0aGVyZSBpcyBhIGJ1ZyBpbiB0aGVyZSBzb21ld2hlcmUuDQo+IA0KPiBJbiBwYXJ0aWN1bGFy
LCB3ZSAqdXNlZCogdG8gaGF2ZQ0KPiANCj4gIHR5cGVkZWYgc3RydWN0IHsNCj4gICAgICAgc2hv
cnQgbmNvdW50W0ZTRV9NQVhfU1lNQk9MX1ZBTFVFICsgMV07DQo+ICAgICAgIEZTRV9EVGFibGUg
ZHRhYmxlWzFdOyAvKiBEeW5hbWljYWxseSBzaXplZCAqLw0KPiAgfSBGU0VfRGVjb21wcmVzc1dr
c3A7DQo+IA0KPiBhbmQgaW4gRlNFX2RlY29tcHJlc3Nfd2tzcF9ib2R5KCkgd2UgaGF2ZQ0KPiAN
Cj4gICAgRlNFX0RlY29tcHJlc3NXa3NwKiBjb25zdCB3a3NwID0gKEZTRV9EZWNvbXByZXNzV2tz
cCopd29ya1NwYWNlOw0KPiAgICAuLi4NCj4gICAgaWYgKHdrc3BTaXplIDwgc2l6ZW9mKCp3a3Nw
KSkgcmV0dXJuIEVSUk9SKEdFTkVSSUMpOw0KPiAgICAuLi4NCj4gICAgd2tzcFNpemUgLT0gc2l6
ZW9mKCp3a3NwKSArIEZTRV9EVEFCTEVfU0laRSh0YWJsZUxvZyk7DQo+IA0KPiBhbmQgbm90ZSB0
aGF0ICJzaXplb2YoKndrc3ApIi4NCj4gDQo+IEJlY2F1c2UgaXQgaGFzICpjaGFuZ2VkKiB3aXRo
IHRoYXQgb25lLWxpbmVyIGZpeCwgc2luY2Ugbm93IHdlIGhhdmUgYW4NCj4gdW5zaXplZCBhcnJh
eSB0aGVyZToNCj4gDQo+ICB0eXBlZGVmIHN0cnVjdCB7DQo+ICAgICAgIHNob3J0IG5jb3VudFtG
U0VfTUFYX1NZTUJPTF9WQUxVRSArIDFdOw0KPiAgICAgICBGU0VfRFRhYmxlIGR0YWJsZVtdOyAv
KiBEeW5hbWljYWxseSBzaXplZCAqLw0KPiAgfSBGU0VfRGVjb21wcmVzc1drc3A7DQo+IA0KPiBz
byB3aGlsZSB0aGUgbG9naWMgYWN0dWFsbHkgbG9va3MgYmV0dGVyIHRvIG1lIHdpdGggdGhlIGNo
YW5nZSAobm8NCj4gbW9yZSBvZmYtYnktb25lIGVycm9ycyksIHRoZSBmYWN0IHRoYXQgaXQgdXNl
ZCB0byB3b3JrIHdpdGggd2hhdCBsb29rcw0KPiBsaWtlIGFuIG9mZi1ieS1vbmUgZXJyb3IgaW4g
dGhlIHNpemVvZigpIGNhbGN1bGF0aW9uIGp1c3QgbWFrZXMgbWUgZ28NCj4gIkhtbSIuDQo+IA0K
PiBJbiBwYXJ0aWN1bGFyLCB0aGF0DQo+IA0KPiAgICB3a3NwU2l6ZSAtPSBzaXplb2YoKndrc3Ap
ICsgRlNFX0RUQUJMRV9TSVpFKHRhYmxlTG9nKTsNCj4gDQo+IHNlZW1zIHRvIGhhdmUgcmVtb3Zl
ZCB0b28gbXVjaCBmcm9tIHRoZSB3a3NwU2l6ZSB2YXJpYWJsZSwgYnV0IGl0DQo+IHN0aWxsIGVu
ZGVkIHVwIG5vdCB0cmlnZ2VyaW5nIGFueSBsaW1pdCBjaGVja3MuIEhtbT8NCj4gDQo+IEVuZCBy
ZXN1bHQ6IHRoaXMgbWF5IGJlIGEgb25lLWxpbmVyIGNoYW5nZSwgYnV0IGhvbmVzdGx5LCBJIHRo
aW5rIGl0DQo+IHdhcyBkb25lIEhPUlJJQkxZIEJBRExZLiBUaGF0IG9uZS1saW5lciBoYXMgc2Vy
aW91cyBpbXBsaWNhdGlvbnMgYW5kDQo+IGp1c3QgYSB0cml2aWFsIGNoZWNrIG9mIG1pbmUgc2Vl
bXMgdG8gc2F5IHRoaXMgY29kZSBpcyBvciB3YXMgc2VyaW9zbHkNCj4gYnVnZ3kgZXhhY3Rsa3kg
d2hlbiBpdCBjb21lcyB0byB0aGF0IG9uZS1saW5lci4NCg0KWW914oCZcmUgcmlnaHQsIHRoZSBj
b2RlIHByZXZpb3VzbHkgaGFkIGFuIG9mZi1ieS1vbmUgZXJyb3Igd2hlcmUgaXQgY29uc3VtZWQN
CjQgYnl0ZXMgdG9vIG11Y2ggb2YgdGhlIGB3a3NwU2l6ZWAuIFRoaXMgd29ya3NwYWNlIGlzIGEg
c2hhcmVkIGJ1ZmZlciB0aGF0DQppcyBzaXplZCB0byBhY2NvbW1vZGF0ZSB0aGUgbGFyZ2VzdCB1
c2Ugb2YgaXQsIHdoaWNoIGlzIG5vdCB0aGlzIGZ1bmN0aW9uLg0KU28gdGhlcmUgd2FzIGVub3Vn
aCBzbGFjayB0aGF0IHRoZSBleHRyYSA0IGJ5dGVzIHdhc27igJl0IG5vdGljZWQuDQoNCkJ1dCBJ
IGFic29sdXRlbHkgc2hvdWxk4oCZdmUgbWVudGlvbmVkIHdoeSBpdCBpcyBzYWZlIGluIHRoZSBj
b21taXQgbWVzc2FnZS4NCg0KPiBBbmQgbm8sIHJlYmFzaW5nIG1pbnV0ZXMgYmVmb3JlIHNlbmRp
bmcgYSBwdWxsIHJlcXVlc3QgaXMgbm90IG9rLg0KPiANCj4gICAgICAgICAgICAgICAgICAgTGlu
dXMNCg0K
