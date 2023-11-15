Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A54D7ED7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbjKOWyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjKOWyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:54:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B69B4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:54:03 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3AFMlRiB022748
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:54:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=43q+ZYEvk/C15FGvGSBnNmb+onzPlj/Z3eZKLpcMCTo=;
 b=cvCvgdJLp/VJCcwMFvFNAF2c7MzCNzsfh5sk0sh+T0PiHAkhQ3gdWjbs4iuS/O4iEvVi
 5vRp4Xbli5V15KPr3TEgcqm93nFR4E/YUdikalIQ1BZvccT6PlKbT8qxt9FiOBiivAYW
 wW3qnVaqLkwzEpkhydPJlYmR6tTjAieEGW5kODgXBOhyJFb/sei4NBvZ6NdrgosWv/43
 xZeJdLh8+sLMugzCtm0P8puo5dObBPHBmRNzWOmlVjnfF4Ov8lWwp1HtO4RMtfgnRsIB
 82TQIPSzQHnBhhaoR2jRzVja8gcPve1M0A4aWHwpGF102NX0qzMnoVZl7pCnQIGzYDIA Kw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ud739r106-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:54:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO/4MqIbhdZ2RF3NURi4Iw5FSjjJrNbltklEEbhtWhfYbFEZLopHflFoZrxMYpn4TbXjYada496fhlHuiV+lJ7dsFIaY3WIq8i/B54zcT6u5zPIPKWJMGr4DM/DEGf2GvthBOHlN6qzFV89W1KxykVBmbOumwoJRJuEBXuIQRBdAxngOu5Zo7D/EspXZIN0OD6umD/7oXopLrZLbRN4KbvLFpc/KfF+bwSIiZIv1N+SY7vtNXyVryT/8o28VSB0P4yjhfF+YiZauEfLvpeGgll9B+z77+kHatLAhwF4v2aOeE/P1Z8LHuYyx0LuYbs08XqHVTI9Jt+hZgdzeHYoUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43q+ZYEvk/C15FGvGSBnNmb+onzPlj/Z3eZKLpcMCTo=;
 b=LJ8viP4MY2+ggq1cn+mgC30+WyOGLHKMR1QVkMiGoiY9zuxtR4urIT23Nlg/oqVDO23TGh81qlF6XY+2dudT4ntOs6rMWmIPRVimjNSiPV3uuyLLAPgMlaDXZglK3I8HZGCUuZiAl38PKs/P70ZTEfdA7GrCARCPjJ3168NeHOeNDheRWzDukxRKIwpno36hWE87Ktag9QIMsyxpBT9sN5DlkR1cHv/9xWrAekiygRDZapP0uIbCwGH/+sS0CTvexbzeXZmMJflXR6w2Kmp1T+rehZX3pgDy0R747Z37WbzWIW8+qgI2Yg9svV081NZ9TF/zwJja5lItLwOGTmMgwA==
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
 22:53:59 +0000
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
x-ms-office365-filtering-correlation-id: 3198e87e-4916-4e2c-da43-08dbe62dc166
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ropnP9U5jZF3bjIdptwSCVET6T3JHDJEgzZjqMOodPcq/DAaKq7X+bRvKLrd8qN0Lc98sYw7+ucymRJKq3yJCttUJ+B2OEaMF4G+O+xcoMDaOQhh4u5vxXrznSCfGc9MqMC9zstq2Nb+XDJbfDqQEN41bDjbWKKHau8/FccaQd3qxS+b8i61wJg/u7n5Q+0V47mV/Ng/D8/zdR0I6Ic5+LInyf7/etvhDyw+wUzjhWpqIzDYbfLeSv2PSwTdN+9kOk/gOcF+xIACOw/JmX4JLNOOayeubYpNMsCUu51Wmy/Ug8vl8KZ6vd1dOIbGwnq632mg7pV9W8wRfl76bz9uEZe4iDNpjaoHICfNYUwn/j/5AI2YIeVoZL+hTfc8fyYddJkdrulaYUukOwxO462jW3dCew1t9oQJYg2U6/io9H1P9U44UdAtFvPAvcOuuOA7K4iVvZZT5rfIh+dodBTFHYHS65uAAuVhVK7BNzFPAyyWetONKnV1Vga7nmGMGLAyDioZ9nkrjraMQxg2/oGhZm6Js6T+EpSB1rLEl+wojxHgNUB8wl9imIhXzaau6DcgcjY6kxQGUtGtEq1GQTg+ZJI9nzULaMdU5JCWdKHGv7onYS6mG4jpPqEedqUkZ4bmMWNeFZ4xIkWJJIF0aoGwxdli5rEEb06W0uuFh47hH5dBbA6KKhB7ZWnF5FWg3kBo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(1800799009)(451199024)(6512007)(2616005)(33656002)(38070700009)(478600001)(6486002)(36756003)(8676002)(4326008)(66946007)(86362001)(2906002)(41300700001)(5660300002)(66476007)(76116006)(66446008)(66556008)(316002)(6916009)(8936002)(54906003)(64756008)(53546011)(71200400001)(6506007)(122000001)(83380400001)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHl5c1hsUGVqNDJmby9HU3dPdGd4S0ExdHN2YmR1NHljRE9zRWgydDJlSTMx?=
 =?utf-8?B?U05VcVkrWjAyV0JESFkwb2RBcWZLMTdVaUxKdkNlakd6NTVLQ3ZsdDlTNHd6?=
 =?utf-8?B?bFNhcWlobzF1UTgrTFd2T3A2V0RoTmdmZFVtay9uSGN1b25kdmhiZkxOZFNQ?=
 =?utf-8?B?SHdyYUNKbUJvVEFYV3FWQ29TOHBsUWdDVlZxd3plWEZsOTh4N0hHeGFOLzRJ?=
 =?utf-8?B?citxM2g2b2RlaUlkdTVKVnhmeXA4bGdHdkFUeVNqWFp5dnRXZXlRTS9NRUZN?=
 =?utf-8?B?aTIyMWRDaUl0cTZkbXc2NUpXMmY0R1ZGUjVyTWtLV3RvUnV4czdHM1B0WDhL?=
 =?utf-8?B?ckVRbERYRnZMTzRBR3YrOTNVS1hpRUhUUWwrVEFHcXZKT3IrUnJlMjlsRkQ5?=
 =?utf-8?B?Ly9UN1lISTZGSmdTdTM5dVNHSEROWktoNDRLMXk2enJrNUVOdEh0azlKTTU0?=
 =?utf-8?B?a1VDZUEwWThiQ1RVTzVTQXB0aEM1eGZoa3lvTFhFdUpueGo4UlhIL2phaElV?=
 =?utf-8?B?d3pERy8xZktLT1ZQdnlEd0VwSjlGaW1Scml5ZGxXd1orei9QcEE0c0xVdEda?=
 =?utf-8?B?SFViY3kvYU1DUUw5MWFHYUF2eUR4N1JtdDRteU5TbExrVlVKSXBQcXE4bXNr?=
 =?utf-8?B?cGljTVVhM3RXNHJEcldYUDljenBFVVBVbGVOS0tDWldyTzlHcm1SSWFFczdv?=
 =?utf-8?B?eG9COW9wRTN0RDF5djllRGFWb0lUdXBlcE1VOW1DVCt0ZGlVcVl4U29Qa01v?=
 =?utf-8?B?Y2lpTnZyN212NEF4Lys0d1lqOG9GTFlxZFFvQW16Q3ZZejJkR0pBdi83SlNB?=
 =?utf-8?B?ZG1FQUhwVkdlbnlpV0FCUWM3bmg5b1p1NzBoZnVVbXlBWUVjcE1NY1VIejRI?=
 =?utf-8?B?SkI0N1VkWUdId0ZWMEN4NTZCM21DRk45VU5Gdmc5clAzMStkTk10R2h2VmJL?=
 =?utf-8?B?QVROa0xUWkV3L2Z0b09tMzJkQnp0MituRGt1TnJEd2RpMmEvVjFpRENnbHRJ?=
 =?utf-8?B?ZjlGUEQ5WmoxZ2k3VU9OS042MEwyYzNFYzAyeEF5dmR0SlhwWlEzMHdTcjRP?=
 =?utf-8?B?VFNVS2VTc0tLd2p0TmRpbjEvajVjSUJuemFFdHR5V08vbnl2bDRoVGhsQjlH?=
 =?utf-8?B?SS9kVklDZGlmYm1HeW1xZkJ1VzJTak9CTnloUHhMWGpvNjVGdzYrRy93OXM1?=
 =?utf-8?B?cTV0ZUIwSHo3WnB5UkVMejd2VUs2eWJzbjdNc0llNVcxRXJrcnlYY3hVb045?=
 =?utf-8?B?SWNET2RVb1VEOCs4NW9LTFNLdUlOa2hOSGpnU2o5dlpZRVN5Tnlua09hQy9t?=
 =?utf-8?B?NFBsVFRQUU91WUZSSmJaMmZ5MnNoVmRLWVF4S2lOK0pNMDREUEFRTlpVdGw3?=
 =?utf-8?B?NThLbzl2cU1iV01EdFM1SktUNDdlRG1XMHMyZXpTTE9VYTFTRFM3MjNnT0JC?=
 =?utf-8?B?QmRXengrWWp4SXNCUDZXTnhtNFFiRC9KK25ENE5wYk8rQ2RaV2FtWC8zQ2FG?=
 =?utf-8?B?SUVzdmo0NndrU2YydE51RmZaSWlzckZaNGJNMyt2c0VGSHF3Uk1lVDEzRGkw?=
 =?utf-8?B?aUlocFhXczJsa3Z1b0YvOEtIak8yZFJxUGpTV1pKT2NVcFlvWkQ5blRObkUy?=
 =?utf-8?B?ZkFQWTlVc1Y4cUJGU2RtKzZRcG1wK0ltWjhQUHpNQzJTWlZNdkJFNVFSbU1H?=
 =?utf-8?B?T3dOQ2N1YXVNc1pxUjBacjVTU2JLdlBzMkI2N3BzazR2UzRvUks4UEk1R09p?=
 =?utf-8?B?T2dDS2VpaUZHcnRFYzg2MTN3UWsyQVdRMjY5K0o5aUVEM3dFeFp6MWlzbTVP?=
 =?utf-8?B?dUs0cTJCc29BVnR4UXFWUFR4eXNyU1gvaVJqS3BDQ0E5RW9tSnRxUXN4NjBl?=
 =?utf-8?B?a2E3Nk5vRDVzOUJZVUNENzBoSm5jQ3BpRlpIaW1TdEFEM1VVQmNLUzV4ZjhT?=
 =?utf-8?B?NnJIOURPRGp6bUtwWnh2VG8rUWJOZFRvVTMvc1MzL1BrQ2lsekdOcHdTWjk0?=
 =?utf-8?B?Y0ZoK1BSZDl5QlJCV1c1bFEvRk1VYmdoTHUzWFJlVks0NWhYRVN6RDZDeHRh?=
 =?utf-8?B?aXJpd0sySUo2SGFRWmdSbGN4NUlPbzFDNWRuUWVmMGM4L2hDZnhvQkY5Y0Z5?=
 =?utf-8?B?Yk1JUTJJUkxyb1JzM1RzaEpMZ1lCSGp1NExVQkIwQWFBOXNVQ0Z2SUdPY1FY?=
 =?utf-8?Q?zCvl8JsHqBtptRlHinTYOxQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28C0D0FC3CDDDC49ADD9FB09B80F0A42@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3198e87e-4916-4e2c-da43-08dbe62dc166
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 22:53:58.5238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmfEl5KoRbYrzNWM15sZ1geAmu8fDEenxOtK84M7Y7gT2pu6najJuPw6wnUvjTkiWfcxAYa1MNF8/ebkxksrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5973
X-Proofpoint-GUID: jMN4r9AzQ2v-63EdIYDlc3frvQ1IJI3v
X-Proofpoint-ORIG-GUID: jMN4r9AzQ2v-63EdIYDlc3frvQ1IJI3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
