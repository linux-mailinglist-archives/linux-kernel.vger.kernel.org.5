Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FEB7D8D64
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjJ0DZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjJ0DZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:25:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E6B129;
        Thu, 26 Oct 2023 20:25:37 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R3JGA4012228;
        Fri, 27 Oct 2023 03:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=A1ZW5IbcEQLaY3iYt/772ERg7LpeqzpZN9MUNF1RkQg=;
 b=IbJ2MJSIwJUByrOd17WjKITSyoL3zmZrrCXEQuLNzVHQEqtRQA4iuVEZuA+tn3q/VMYE
 +yL/OWNH1HeKRT18CGlW9iirzjSGdMb5o2Riy1NwcEmrkoSN8AqmCq5JyE6LaRheKLgN
 FcEkpyb3VI91bwoo/60CRFHYSwpLCuTvr46BmUPb72Pg8jrl4hWx3FBNyhlcF34OohBh
 BpcRkZr4pp+2Jr9GvJ4UAXpJLvRqJH1cGPAXrO937fdqGwmcadwjHGY0foi+Kr5PZLYc
 6V/j/112G2jvuqnCmGvo0pRVqENhPkbe4wIvRzwsVnFC9JFcQWT6KyotOW6GS0m7lfWl rw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u056p067a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 03:25:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2+UzaviEz+PV0r8CjuAzmF2+pxs763xSbOdwIls6svwY3hMdBdtHhim7UYkOKCRkGiDnh7VaglaSHlxK4Gel2BP7nfT5CeyIReyPSwI3DbdvD83cP+Fsp3JYY+lm/qeQpd3OVslHq7bhF2AB/Z38OtwAlw3Lf2GbTRjZlv19ZZwLwA/GGugLZasqFOY5CZi3gi6AU55/dgA5sqlLgdtbk2Rh22lRC4E6Wz6ICcW63jqvRKfSjGOzioQfcihxz04k7dZ3k3JXLNpp9IYg90qCkJf4w91NPd06dvbxcve3cxx5VIWqrai9sYG32DrpQ0XuCKQINtA8gLOOj1C8MDULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1ZW5IbcEQLaY3iYt/772ERg7LpeqzpZN9MUNF1RkQg=;
 b=CLcJ/d/Z9gUcNrgzIjvgWTw6wldTROfuPBQjzvZ9ZGBkqOqlA/uoJN++qoXa0j7cauYPDZG2KruEdEnIO/KNw2KPpfXGJiXsbdF3AW+9HLguCwD8K0R9ZJquq8bpT7H59fsgcWNLtD6VVrQ1Uw+MqPDhCSJ+4l96cLIKSqw5IZP9yS+afeuAbAhBOkA8AAeTyhMJJrmGXCZ9bT600vtNEIJKnPqFY093rASkGnsdm04cQuPjjHK0r/qDv1WAbBc60VLVyl14gxR2hnDKl6mEWzanFclDkuAvrsVWXRXEMksKaufcTiD2MOlg5CEWFb4tDL+KMTrjB2hOGhZUFmKJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3898.namprd15.prod.outlook.com (2603:10b6:303:43::24)
 by DM4PR15MB5565.namprd15.prod.outlook.com (2603:10b6:8:10e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.11; Fri, 27 Oct
 2023 03:25:15 +0000
Received: from MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::6b98:b5af:76f4:8825]) by MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::6b98:b5af:76f4:8825%6]) with mapi id 15.20.6954.011; Fri, 27 Oct 2023
 03:25:15 +0000
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "ninad@linux.ibm.com" <ninad@linux.ibm.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] hwmon: (pmbus/max31785) Add delay
 between bus accesses
Thread-Index: AQHaCFouEojCmBryp0OOmHYu5lRw1LBcsD0A///1ogA=
Date:   Fri, 27 Oct 2023 03:25:14 +0000
Message-ID: <E8022352-9856-4910-AB38-134BBF4C4E53@us.ibm.com>
References: <20231026221708.1582518-1-lakshmiy@us.ibm.com>
 <0bd4fede-2d11-c781-98af-5a27ba454346@roeck-us.net>
In-Reply-To: <0bd4fede-2d11-c781-98af-5a27ba454346@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3898:EE_|DM4PR15MB5565:EE_
x-ms-office365-filtering-correlation-id: 119abec2-ee87-4954-eaa2-08dbd69c5606
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0NKu1Ig2+D+KZ5qW8y8ka7Dmv2RK2L9MRIfmBWXN4vBOYznEdpUPyKplVAo2sVkTPzXdgzTkOs+11y8Gj17lFlS3LbDubM3Hf69vy9VP/bCacovzx7Ftnw2NCFeKV6wimKut8U6Qt1yV77ip5HerzWevuTNUv1/N1GWZrhP8UShcdGtLYwq4Dp8DkAiLI9lZafJ0ieI3AM9TzsF2FjMLBaQu7VhRJHk2w2+voSHw0l39p/nDACgA2nvAhUFbfJrSwUtDcNIoScEDA6m9LqaHZz/Z1fELhip3R8+qc3WFegzxJmin9kUHLaEl0pW261mppU/nIt2GZVFOljPSXyS8xxwsuXK+vM5msXX3sovfPO23Ti8ZA1rmTYPR1eykn47678LmSN/mn7FqdXkr5hMU1Walqx+bSX2KyWSBXKBlFz5X2xX3guu3Nn9/5sCeueUN8VAptdV+C7D5uW/q6QdFHvwffIj/QmRclS16G8vz8g3A76EQYrA9VnDhtsDfDAWcgOgaISZXzKiNLOJlB7GBZD8PYsFD+/WpYSbbrHO51kl5K9MW4/RZuif/JflyJl4ocWVzUbMjhsn/7mJ+3TMTT9m0/bondhYIdqrVIxoYDDo/8zLqpQrt/D8m2lxCHSG7cp6F+XsjlqyV+4LKl8yB6PBZqYsc1LgU7et/VMBa8gUQz2FvjJiWk+4KFrp+KLf0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3898.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799009)(64100799003)(451199024)(38070700009)(91956017)(110136005)(2906002)(6486002)(86362001)(33656002)(8936002)(8676002)(4326008)(53546011)(6512007)(66556008)(478600001)(2616005)(66946007)(6506007)(66476007)(38100700002)(66446008)(76116006)(122000001)(54906003)(64756008)(316002)(41300700001)(5660300002)(83380400001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RE9JNHMrWFVya1JRREFXUzNsNlVTS21sbkxlUTNkM202RHdSVTg1YjF3b0Ns?=
 =?utf-8?B?SnJkbGF0SHpiT05Kd1ZNTzY4ZG1CZHNDR3hrV0Z3RXE4Z05HcDVEdEJVSUNZ?=
 =?utf-8?B?TktnVVhDN1U5N0JibDVFK0JRdm11QVhDNWgvemw2VDhKaEtqekRSREdyN1Ux?=
 =?utf-8?B?NFhEa2t0dU1LWE5kUVVuNFhZQ1JNcURoaEh6aUgrOXF4Vmg1TTVvamJwblIx?=
 =?utf-8?B?akM4cUIxNkwxTXhvUmI1emxvb0JDSklyblFrM0cvdU5TMWx0dDRMYTN1NlBq?=
 =?utf-8?B?OWhnZzRzOEN2VGxzb1FCR3FOSHRETVUrSElHeVF3aEhpU0VYZkZWbWt6QUpm?=
 =?utf-8?B?YnlDbFUyWjVoL09RaUU4ZDFranREcXJkaTU2VDJaT3dUcldXZi9tbWNYYnAz?=
 =?utf-8?B?V1ZZTHlDSlRtayswa3Q5VEtQeW5tVHo2MzMreldSem5uN2RYWDNzQVQ2UWJL?=
 =?utf-8?B?NTV2dmk5VVNxcC9OOG1PY1FtbXNicnE2dzVsVERTa2kwNytMMDhSQWthVnNL?=
 =?utf-8?B?YlhWT0ZoM2FqQXVzYk9vVDAzZzN3Q0hBYThJZEtmOHNVQmJ6VWZObmJVWHJO?=
 =?utf-8?B?YWppRkVIY3BicXBJOU5pWng1ZHBzYk5sQUExenZwby9XL3NRclhYS3lIMWNN?=
 =?utf-8?B?RENWL3pEYXpnYi9yeS83YVAzWXhIOXFzcFBhN3dPYWtxN3hraE8zYmw0V3JV?=
 =?utf-8?B?ZXRoRHRCeXRXQlRYNDJzbjF5Slg3dW83alVSK3ZrUys1dG9PaWtwalowUGJ4?=
 =?utf-8?B?cGw2K2txTWpRU2dwRGJobFhRRjAzWVhVMXYvODVJcW5WaW11N2hodGNiZzIx?=
 =?utf-8?B?eDlsK2VKczNST3JScWtwaHQ2T1R5QUppMG9UQzhXLytsQWhDanhBclZkakIy?=
 =?utf-8?B?N2d6QzNTR09may8vUm5xUDV2RHBqNjY3d2x6N2ZqeDl4UzdtSG92VE41TUVu?=
 =?utf-8?B?dU1xN1k0dHR6dUFhNzVBWTFaRTdJcFN6T09VY1hseEtocmtpbEluWDQ0UlRr?=
 =?utf-8?B?cEZrK3Q3d0IzNUlwMUw0TGJkenowRzk5Z3hSMzZEaHd1Syt4bHd2S1NTbEtJ?=
 =?utf-8?B?N1BTd1hWUkI1c2tZUVRzU3NuMWgyZnpGdjR4d2M3MjA4MHAyT1VzYkZPb0tB?=
 =?utf-8?B?VmVJY1JWUmhNODF1ckI3YjlhYllrYWFSTmxIRzNRN3hxcWJ4UGV5c3BTcFJT?=
 =?utf-8?B?VEZVdXlyQWhaMGxnUVZPR3hDTGozTXJEanZxYjdxOXhjTmxTRmJzcTl6SGY5?=
 =?utf-8?B?UGl0VG9ENE1kVzhMQXlPMWc4VG43aHdJZnpKNG1wbFFkTGFPN1g0dWEwZllW?=
 =?utf-8?B?cmhYU250ZzV4dWJLeE5rUW5FSk16MnVSVEdGME0xZjlPUnVPQmhCeTQwSkxU?=
 =?utf-8?B?UUx0Q3JKNkhQekI2WGQ0eFBZSTBaTXJFSWgrdWZRWEZwZy9SVWZEaVhmZjdu?=
 =?utf-8?B?cWNZYTk2TXQ3dUtMc01hVDBEZEE1eEo2NjQ3VlVWSGlaMXkxdUdZaUs2bzFN?=
 =?utf-8?B?dkxJMm5CUlhMUmQ1dkIxSG1oMEp3S1ZTeTZOQk8rakNJZW1DSW5TbS9HbEVQ?=
 =?utf-8?B?U0NyalY4WGVXUEFieEp2QXZQTkU0cGpncjZRazRYZXNXa1hkdjA4TzFqUE1M?=
 =?utf-8?B?MDNSdVdiWjh0NVlZNm1Yc000d1NTSWZXU1JTRERoSHR6WDBCT0o1Z0VMODZn?=
 =?utf-8?B?NFEvOTVMMEVpdmhMMlhVbHNZTDBEWE1QdDBTWTMxVlVzNzVtS2F0V21wcmFx?=
 =?utf-8?B?VnVkdTVxelk4aTk4cmZVVXNmSStYRHgwcXpqSG1QSUh5NTdpMGFBeUtXdGJU?=
 =?utf-8?B?M0kwcHduenIwL2NsazRzRmN3clNSbkpUMU5KalV0empaZTN3WEU2T1J3SWYy?=
 =?utf-8?B?allQWkg2N0pqOTdNaVhhbHNpQXhyQXR6SkJpTXVsVUhGekVPZUh4NWt2S25j?=
 =?utf-8?B?U2lJWTNXazcydVVkRDd3T2ZRSUR4QVhHNlNZUnA1NHFGeThMQ3VDVkt0RzlR?=
 =?utf-8?B?RitLNDdzNmRqQ0l2UzFiKzFnc0ZBTVR0OHZLVTk2SGZrcllVZ25obFJ4VkNX?=
 =?utf-8?B?TVVGMFo5WnVuTEI3T0FOb2ppd0tod3lEMGF6MGMwTC8rMnFQbHYzVHFiRFdI?=
 =?utf-8?B?MWJISTJhcmozR2NOZlRZY0U5d0M3NUFHUEx4OUJpMnA2QzV1dlZDZVJINjF6?=
 =?utf-8?B?R1FjMWU0dXNyOTZZVURSUklOWEZubWp5ODhFbG5RMi9TV0NLK3M5eDJtV1Bv?=
 =?utf-8?B?TnR5NVQwSXA1SDFlNFduVEtLQXRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E9F65178C18B44B88D86F7CB1F6478E@namprd15.prod.outlook.com>
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3898.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119abec2-ee87-4954-eaa2-08dbd69c5606
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 03:25:14.9272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YTQBG7+krZZaNJhXVaXQ0yjuSLgrk5+nlVKR4Qa1k6WGlOl/00wtMk0m3xlWaPzeFKZjQ6IZBirZ3pUYDnFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5565
X-Proofpoint-ORIG-GUID: HtMOaNzT5p997AbambQF2wzM8C-oVRLy
X-Proofpoint-GUID: HtMOaNzT5p997AbambQF2wzM8C-oVRLy
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH v4] hwmon: (pmbus/max31785) Add delay between bus accesses
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_22,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=745 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEwLzI2LzIzLCA2OjAyIFBNLCAiR3VlbnRlciBSb2VjayIgPGdyb2VjazdAZ21h
aWwuY29tIDxtYWlsdG86Z3JvZWNrN0BnbWFpbC5jb20+IG9uIGJlaGFsZiBvZiBsaW51eEByb2Vj
ay11cy5uZXQgPG1haWx0bzpsaW51eEByb2Vjay11cy5uZXQ+PiB3cm90ZToNCg0KDQpPbiAxMC8y
Ni8yMyAxNToxNywgTGFrc2htaSBZYWRsYXBhdGkgd3JvdGU6DQo+IFRoZSBNQVgzMTc4NSBoYXMg
c2hvd24gZXJyYXRpYyBiZWhhdmlvdXIgYWNyb3NzIG11bHRpcGxlIHN5c3RlbQ0KPiBkZXNpZ25z
LCB1bmV4cGVjdGVkbHkgY2xvY2sgc3RyZXRjaGluZyBhbmQgTkFLaW5nIHRyYW5zYWN0aW9ucy4N
Cj4gDQo+IEV4cGVyaW1lbnRhdGlvbiBzaG93cyB0aGF0IHRoaXMgc2VlbXMgdG8gYmUgdHJpZ2dl
cmVkIGJ5IGEgcmVnaXN0ZXIgYWNjZXNzDQo+IGRpcmVjdGx5IGJhY2sgdG8gYmFjayB3aXRoIGEg
cHJldmlvdXMgcmVnaXN0ZXIgd3JpdGUuIEV4cGVyaW1lbnRhdGlvbiBhbHNvDQo+IHNob3dzIHRo
YXQgaW5zZXJ0aW5nIGEgc21hbGwgZGVsYXkgYWZ0ZXIgcmVnaXN0ZXIgd3JpdGVzIG1ha2VzIHRo
ZSBpc3N1ZSBnbw0KPiBhd2F5Lg0KPiANCj4gVXNlIGEgc2ltaWxhciBzb2x1dGlvbiB0byB3aGF0
IHRoZSBtYXgxNTMwMSBkcml2ZXIgZG9lcyB0byBzb2x2ZSB0aGUgc2FtZQ0KPiBwcm9ibGVtLiBD
cmVhdGUgYSBjdXN0b20gc2V0IG9mIGJ1cyByZWFkIGFuZCB3cml0ZSBmdW5jdGlvbnMgdGhhdCBt
YWtlIHN1cmUNCj4gdGhhdCB0aGUgZGVsYXkgaXMgYWRkZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBMYWtzaG1pIFlhZGxhcGF0aSA8bGFrc2htaXlAdXMuaWJtLmNvbSA8bWFpbHRvOmxha3NobWl5
QHVzLmlibS5jb20+Pg0KPiAtLS0NCj4gVjMgLT4gVjQ6IEZpeGVkIHdhcm5pbmdzIHJlYWx0ZWQg
dG8gdGhpcyBjb21taXQNCg0KDQo+SSBhbHNvIGFza2VkIGFib3V0IHRoZSB1c2Ugb2YgdWRlbGF5
KCkgaW5zdGVhZCBvZiB1c2xlZXBfcmFuZ2UoKSBvciBmc2xlZXAoKS4NCj5JIHNlZSB5b3UgZGlk
IG5vdCBjaGFuZ2UgdGhlIGNvZGUuIEZpbmUsIGJ1dCBwbGVhc2UgZXhwbGFpbiB3aHkgdGhlIHVz
ZSBvZg0KPnVkZWxheSgpIGluc3RlYWQgb2YgdGhlIGFsdGVybmF0aXZlIGlzIGRlc2lyYWJsZSBv
ciBuZWVkZWQgaGVyZSwgYW5kIGRvbid0DQo+anVzdCBpZ25vcmUgcmV2aWV3IGZlZWRiYWNrLg0K
DQpTb3JyeSwgSSBtaXNzZWQgdGhlIGNvbW1lbnQsIEkgd2lsbCBtYWtlIGNoYW5nZXMgYW5kIHNl
bmQgaXQgYWdhaW4uDQoNClRoYW5rcywNCkxha3NobWkNCg0KPlRoYW5rcywNCj5HdWVudGVyDQoN
Cg0KDQoNCg0KDQo=
