Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B4C7F3786
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjKUUf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKUUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:35:25 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2181B9D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:35:22 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3ALKV0Of032746
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:35:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6IE/0zvBBy74dzZcKKx0GkpOaFR2RLHFVwA7PXAMm3s=;
 b=VRFh+tG4MNUc23ee+TzPP6AyJtxOeJYBglz7zUNsX0EjV23oEyYgJ2juLCTRMx3vSo92
 5nWTcV/kq1J17sZJGySDcd81hOHw2KIPihrsyJZ4D+i+FddbvZpKmrbiydO/mADTIfAp
 o6EaejxB+u1TkVIpVqRRhCo3UWLgIuvqUGxftaJem8CfZCvKc0+RfIJ1ZpfSzpuMgMse
 ohNyUBOokcO/JNFeg8Ohduvt1HsdD2BKA2hqZx58dfj7Wbcl/d5QD++ZarNw6s5q/Npd
 n5Gbxt7FE7Rxip4Rtj3DI6lNj7UYrcro4/S2YnzXhcxCH7Rj2y62s/zoGRuzozDbQHQB cg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by m0089730.ppops.net (PPS) with ESMTPS id 3uh3n781ep-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:35:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnmqH3ISXCJxicAoeIyTGF8vnEw1R+qRBtzLgDQWp1/bMHYN2+zqrdn/t8K2+JlNsdWstCOj4AlSpdLnsgzyIKlbpQnYko10Xb4hHHVbH93y2DvTYf9AJT+GyHskx0VPltBzGFjJZ6a4XWQWC0nEkn246iDso3pF2a5sHRlEn/L0v6IWs6dHXXzQKtPupIHp+h7K0eLECSqiQjsCcjMhMUOhFrMKuaa0ksbJ4PkIruebvYbbtQpf0YKbQf08Ch4licfpcScb5hFKvAcXtR7qpLA3h53WqCpMvOj5o2wNGO9gyu5037/NPknpJJcwaNE0rvXmFhRqe0KLYaJ3CnQcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IE/0zvBBy74dzZcKKx0GkpOaFR2RLHFVwA7PXAMm3s=;
 b=HW0UJHxo5AOAk36m6VYVTnP3EXWtNHy99OaRZptHjqHInwvBu7pEYlUJG6EhZK8wUeOBQQ78u1euxC3COZ+/prLhXvlQdQay2kACfdH/yAxxfUh/G6J7Lt09dbl95TuVz1zJmKYqcgGwF2xTBOfE6yZER5ggm3xaYtNuJDFxwwbjhmMH5n/kBPnGfFx/7f3zOQXUnjIaxVVXupul4MuJxEuofOjGHzip2OD10UvmtUJZVH4HU+c1mPOxRkFfyzhIqACBHvZs1ZAAlJbwbx1+BvDM43OgSKjzQp2bwt87STLpEp+2537v94lCcaa8G4RmLRxUf0CPizzTHKkaR4kihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by PH7PR15MB5173.namprd15.prod.outlook.com (2603:10b6:510:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Tue, 21 Nov
 2023 20:35:18 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::cbea:e86f:62db:9b00]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::cbea:e86f:62db:9b00%3]) with mapi id 15.20.7025.017; Tue, 21 Nov 2023
 20:35:18 +0000
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
Thread-Index: AQHaHBTz4ziGxvjb9UezyAE3hPe067CFBqAAgAAroQCAAAO+gIAABkSA
Date:   Tue, 21 Nov 2023 20:35:18 +0000
Message-ID: <41F084AA-F027-4288-9F26-E33337E1516A@meta.com>
References: <20231121010318.524570-1-nickrterrell@gmail.com>
 <20231121010318.524570-3-nickrterrell@gmail.com>
 <CAHk-=whL+1xR_LJwJ7DRhFo2gkDv0jrRMX5PJoULoSBXppEV8A@mail.gmail.com>
 <D42705E6-94D3-4E3B-9BA8-AFFCE4B8E4E4@meta.com>
 <CAHk-=wjcft4VEVBwSeaczuonUAGyT4BKt5PimekDpL9ygHC5cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjcft4VEVBwSeaczuonUAGyT4BKt5PimekDpL9ygHC5cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|PH7PR15MB5173:EE_
x-ms-office365-filtering-correlation-id: dca7fda9-6ae2-4ea9-04ce-08dbead16009
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EnRLgfs3wF01LfnU421twByPQ6Bf1+r1BVBbvST56Ipw7uFqY5jRvbCS5DEPK5hSdsVZ4yLTo61dIQvi494FGakqcvqa3xVEWmIdKAzsumk8TURfwzLYRBmjObhRHrUgFA4y1EkGQDkDxSi2hBpYF86ETWcT+RqMtsp1yefb6QK+aMqKYOhx57YmmGCOnVC/fbd0GwcP9hSWU7BxK9B55FjM+u+L7Lz3DuMiWLL/kNni3cs2re6sVPbxScYdEbDMEBTYjGEdm1zUoqvCPh1pCtsa58721fKlWWt0WyAJPsvBlRnIgvOpG1W/v/mP8iSsJGAcokRp50+HuJrBUS77+6rpd7OJGdYTYU3O9JdD3KoiIdcDRkK9pq6DLaxkI0gf/PCp5B/n4akhvzWcUkNsUHErF2ToTOFeXNowAOL0rUe2WxjZmEj0SFEFegrrTAIZqY2oTwWvOUK4nHTXNlosuwQn+9qyqYVMic2jxCEdS3pb1LmlwboVuwMiu5N2QqFnyucc98aXF+UAV5L8mC3bF43L73cqUCQqOZjSFO5ZFwTmlqjU/5OfqGEsMoTLg5HJqmo5dcTYhr+6A43M6KireZ7WAWOk4HmdEGzYtmmsjBp1VfFTYF5V3PkP5EAtedDo8AEcB1eelgwuL6GouQSGr1GxZM+d1e7oioLndFxBi9lqEJxmQwm7G7OoLTUdjCBP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(1800799012)(64100799003)(36756003)(41300700001)(33656002)(86362001)(5660300002)(2906002)(38070700009)(122000001)(966005)(6486002)(2616005)(53546011)(83380400001)(6506007)(71200400001)(478600001)(38100700002)(26005)(8676002)(8936002)(91956017)(4326008)(64756008)(66446008)(6916009)(316002)(76116006)(66556008)(66476007)(66946007)(54906003)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjRoc0RyOGd2QXR1eHdEVENxWWlaQUttT1d2RTI0WjN4V0xjMTFYUDFnRWU4?=
 =?utf-8?B?T09CT3IrcFZkNXI5RDZ6ZG5mbTdRb0gzTjZVQlQranlkb2ZLbGZwWHFRb01v?=
 =?utf-8?B?ZG8yejhJNFNLVC9ySTV2TXJrQzJkT0l3MVJnaEsyV0dJa1VWRWp5QTBiZnEy?=
 =?utf-8?B?a0srTlZlZGdhNXNHOVQ4UFpYajRZU2JKUWJtN1dPaTFreFZKN0ZIRkFQOEth?=
 =?utf-8?B?TzRGd00rMG5QclhTc0Z3WGlya0FWa0l0dW5xd1FEckp1TFU3ZEQzaWtTb1dQ?=
 =?utf-8?B?cWNRMUtBT2Njakk5U3ZaQmtYbXNrQ0p5THhLNnZTVGZtUjY4dExGK3l6SndY?=
 =?utf-8?B?YlFmWWczaExsdFpUN3NFVFJPMmVFNithZkI5Y0R0TzJjOC9aaXgwaVBoY21F?=
 =?utf-8?B?SkJ2aldIdlZvS2hUWXdkcHhnSFJkemk5blpydUNyYVllRXdwUXdYUW5LOFhL?=
 =?utf-8?B?UUhwLzFTRDFQMldCSkxxNnNuMEZWblNjVFlwZXJxYmYzVWRFZ0tIVGR5TDNC?=
 =?utf-8?B?Qlk4eEVvb2V0VFhUV0VGUWJXUWJTdlBXaFV4WUtRd2hTRWJIU3NoTit4WnQr?=
 =?utf-8?B?K1VIOXVWYzdtdFhlakhXRVBpUjhKVHhwcm93S0t3bFJ2WG9LdXhoSk93dkNp?=
 =?utf-8?B?MGluV3ZtNzJsMVY3NUJ0aGp5UUhnT0xiQ0t6Q2UwRFkvbGgzaW1TbzB1dkhK?=
 =?utf-8?B?b09lZkNzdnk0NFJEcW1TYXN3Nm1VcG1SVEYvY0t5azJ4ZUtNL3FSRzluU2Zs?=
 =?utf-8?B?TG4wUXdSRkh5SEJ4b3N2ZExiNWxQOTlPcUtKOGtFam80ZmlRS2MvdXBEaWJV?=
 =?utf-8?B?aDlCcEJVRU8rYW5DQjcramJiTDk4MXpybHJwK3NkYWx1dG9uZERKREY4SUww?=
 =?utf-8?B?R2V3dEx6TjZjcGd1WnBLb2hiSUFtTjNiQi83WjkwcFh5cTB1Y3lmQ1pvR2wy?=
 =?utf-8?B?aWxJZHpTbHczZ3Z6ZllDanN0SGVrY2V6aGs4dkpHTWhTcWFCWEk5VGNuOWZ4?=
 =?utf-8?B?Rmh4SWFFbEFKMkRVRUV2OHZ1bUJaQ1RvZ1RramtVcHVSYXpNdksxTWxhUlVU?=
 =?utf-8?B?TXJIRUFBaDZNY1lRdFBiZ0lmcmdWbHBibDZPVE1FVGVDSk9DY0xDelVoUVND?=
 =?utf-8?B?WEN5eXlkU25HRUdlRlZpejQrZWJ1WUNDZWh1S1ZEWnlUNnEvRzJ0Vk1hWkQ2?=
 =?utf-8?B?L3NPK2szWnVkZGRveGpWaS9QYmEzWnpnTUs3Umc2Ly9uSWxZMzFCMUViL1ZZ?=
 =?utf-8?B?ai9mUFlReWVqOEpyUVJsc29OeENoc05aa25ZVHgxKzE4NU80ZzdtMDl2ZGxX?=
 =?utf-8?B?d3gyN2dnUlBob3hsL1p6dVFjWjhWYjBiL3ZVQVdRbFplRjBzOUk3Zi83K1Zz?=
 =?utf-8?B?N0p6MVZxVXZiWW1IS2VGOEE4ZHZkRTU1LzFxTjhPOFpUYzdRR0ZMRGtJbktB?=
 =?utf-8?B?QWs5NHlTUEpWenFKZFhTS0VYa3pmZ0FvZXVDNXRCdnIrQWdvYmRYL1RhZElF?=
 =?utf-8?B?SEU5YVk2RUNYYUorNDhadnBTWC94VnFwZ1ljMXJ5RTVhNTlzeDNxQnpqVElQ?=
 =?utf-8?B?Q25VVEJ3MU1jZFJ1dWlIVWFZUGd1U3U3S3NST1d0VzJqbk5GWlQxaTl5UmRG?=
 =?utf-8?B?YThISlJkdXBEQ2JoUHhtanNnZFRBa2tSaWtIcVlUaEtWRW93VlBtWkJ1NUVD?=
 =?utf-8?B?dHQwOEEwWkx0UUl0Wlplby9MM09FL2JNRUJsZEY4Qm41b2NBTGNYbjM5d291?=
 =?utf-8?B?SElHNTRXdkk5a0t5NUhSUkZxQllQQlhiTmVMT0pERFZqL0NrOVF6ZGhDQVRp?=
 =?utf-8?B?bXJjcUxNSURiMlM5RG8xaktLZWRURjhza2lCY0pqU1VlRVpoMGVsT1ZIZm5C?=
 =?utf-8?B?QjNmWEFnTlhvdTVwWGtrTFVsMkQ4bUVRWDcxZFBWdFdFZE1WZzIzbnhUbFNa?=
 =?utf-8?B?a1hBU1I1dHU2QzJDRmt4VUlKMXA3bUdQbWtDcFRpb3oyY0V4VXRzcEN4UzVQ?=
 =?utf-8?B?SnVVejhuRGQzdzdFQ1E4MmxoNDJtdEFIbllOTWxZZ1J3Ukk2SHBaRWJIZ1Nt?=
 =?utf-8?B?RS82QVdDQ21wSG1ORnlWSkZNM25MbzNONllNcXIrZmNpaG1jeXhZUTBtd2tv?=
 =?utf-8?Q?taNDOd8QNQbrOP+1H/okSd4Gk?=
Content-ID: <B80640435D441A41AEBC98C7F57A589E@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca7fda9-6ae2-4ea9-04ce-08dbead16009
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 20:35:18.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDn2TisFmSKIRTBqZdNi7M9QkaYLYdnI/DNCLHLSVzeEuETzRYcrMqvgneOP5dR7df11lKnkUiRGNKIFvENZ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5173
X-Proofpoint-GUID: ZFa2YCQk8gjRc9zYwUXv460jAFBnz3lN
X-Proofpoint-ORIG-GUID: ZFa2YCQk8gjRc9zYwUXv460jAFBnz3lN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDIxLCAyMDIzLCBhdCAzOjEy4oCvUE0sIExpbnVzIFRvcnZhbGRzIDx0b3J2
YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4g
IFRoaXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcg0KPiANCj4gfC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0hDQo+IA0KPiBPbiBUdWUsIDIxIE5vdiAyMDIzIGF0IDExOjU5LCBOaWNrIFRlcnJlbGwgPHRl
cnJlbGxuQG1ldGEuY29tPiB3cm90ZToNCj4+IA0KPj4gVy5yLnQuIGRvIHsgfSB3aGlsZSAoMCks
IG91ciBvbGRlciBWaXN1YWwgU3R1ZGlvcyBDSSBqb2JzIGZhaWxlZCBvbiB0aGUNCj4+IGRvIHsg
fSB3aGlsZSAoMCkgbWFjcm9zLCBiZWNhdXNlIGl0IGNvbXBsYWluZWQgYWJvdXQgY29uc3RhbnQg
ZmFsc2UNCj4+IGJyYW5jaGVzLg0KPiANCj4gV293LiBUaGF0IGlzIHNvbWUgdHJ1bHkgaW5jb21w
ZXRlbnQgY29tcGlsZXIgcGVvcGxlLg0KPiANCj4gSSBtZWFuLCByZWFsbHkuIEFzIGluICJXaHkg
d291bGQgeW91IGV2ZXIgdXNlIHRoYXQga2luZCBvZiBnYXJiYWdlIg0KPiBpbmNvbXBldGVuY2Uu
DQo+IA0KPiBIb25lc3RseSwgYW55IGNvZGluZyBydWxlIHRoYXQgaW5jbHVkZXMgImRvbid0IHVz
ZSB0aGUgZG8td2hpbGUtemVybw0KPiBjb25zdHJ1Y3QiIGlzIGFjdGl2ZWx5IGJyb2tlbiBzaGl0
Lg0KPiANCj4gUGxlYXNlIGp1c3QgZml4IHlvdXIgdXBzdHJlYW0gcnVsZXMuIEJlY2F1c2UgdGhl
eSBhcmUgaW5jcmVkaWJsZSBnYXJiYWdlLg0KDQpZZWFoLCB0aGF04oCZcyB0aGUgcGxhbi4gVmlz
dWFsIFN0dWRpb3MgZml4ZWQgdGhhdCBjb21waWxlciBidWcgaW4gVlMyMDE1IFswXSwNCnNvIHdl
IHNob3VsZCBiZSBzYWZlIHRvIG1pZ3JhdGUgdG8gc2FmZXIgbWFjcm9zLiBJ4oCZbSBnb2luZyB0
aHJvdWdoIGFuZA0KZG9pbmcgdGhhdCBub3csIGFuZCB3aWxsIGJhY2twb3J0IHRoYXQgdG8gdGhl
IGtlcm5lbCBvbiB0b3Agb2YgdGhpcyBzZXJpZXMuDQoNClswXSBodHRwczovL3N0YWNrb3ZlcmZs
b3cuY29tL2EvMzY2NTg3ODMNCg0KPiAgICAgICAgICAgICAgIExpbnVzDQoNCg==
