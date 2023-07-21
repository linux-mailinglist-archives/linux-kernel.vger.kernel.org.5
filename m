Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BE175C2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGUJV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjGUJVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:21:48 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A169930D0;
        Fri, 21 Jul 2023 02:21:45 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36L719BZ027870;
        Fri, 21 Jul 2023 09:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=lDpaChisG80HwzQ+KDU/5fMOfa9WMt/1foFIvhOdAk8=; b=
        Hrz8puNqGJU/s8YUNU4cHEbCm+YuMS5ccUqTMFj9uD3Z1riufHUwk8gW7AXhgIsJ
        8SJtRTXU9/fL+7J/tnKqrT4EVNspd7VQTQolt3s/eO97RH9LxA2plN6gBlUUSOa3
        5xW8twNVeXdnREKes1k+ph+7CR7GK9r9VXWeq3lBIS3L0hWLZpa2mk2mxhGgPsI9
        5QgwD17voAYYBSa9YnZDbvRIneZ5pzW4wxjuzzksrAw+H2Q+0rJpHmqOthuFJMiQ
        CRY8GXzUKGtq3YQjkyNJQFGh5GammZ8bJ6EHmUpLcdGW+HITEE2AoKP1t7LLkCx2
        rfI7RR0eWHp9+EQxXCq6EA==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run8adh4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 09:21:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Em2h4nZ/U6h630pic0NJn6QvKFoy5YWIAiAFSyq62MvmCOGJYxfSSD9WfYSJUv3c1eRjUfLlvif8Gmd4FXzEMWYsKG8YU+K5CBBG/mcpkG+CzRGr4ndNx3OZFmgj+mcTSm6m4D9TFkpsT6ri3QtBWMsWNg6kT+ADl8NU21niJ++A3MqxQLURXWQlCSv9nJWs6MJUcDAO+rqK2pBTp9+m4L+LkJ7u8+KhViq2rJr7ALjdZV/QBff5Pk5SDpmytEscZhOIe5/lhkhbyugoqTZgG35F9YHTSFBNsNI6zyX1Kz/SZb+8G1eSsAV4XIj+14H9EGjjPmPdd1iIg2t1HYTgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDpaChisG80HwzQ+KDU/5fMOfa9WMt/1foFIvhOdAk8=;
 b=b/wol0K4PphCKMrW7H0A8PrBJhxNV5M3LTLiAWjqtcxekDcoeqQkzK94LEEWqwDnDddQ2pyrt1eJFxbzIZ+O8bWIiO+jA+Xjodd2zUsuORe1Y8rQhvIzUM+W7hOcWrfZ5uqPCUS3bMnIPBROLNPKlSKRBeqsw0uUvJG2VvbPtkLyDoWKmQz+4YbHJuTy9f8GSZpQToscX6xoVUzIQvAWjzIEf04Tgq36+Rljf1l3LGUIJyHFRTPIPmR080hkbbH4bEA1KDEdh24j3ZWbTamCO9CEQLc6J+o5bPW5lnZVtERst1F7OZRWR3o0NHPKZ86GuSKz8lH1+usykFseBSnfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by MN2PR11MB4616.namprd11.prod.outlook.com (2603:10b6:208:26f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 09:21:37 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 09:21:37 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v2 PATCH] arm64: dts: stratix10: add new compatible for Intel
 SoCFPGA Stratix10 platform
Thread-Topic: [v2 PATCH] arm64: dts: stratix10: add new compatible for Intel
 SoCFPGA Stratix10 platform
Thread-Index: AQHZu67AcgeVg8NpVU6sDsseuKM3QK/D6aGAgAAAxwCAAABzoIAABo4AgAAAquA=
Date:   Fri, 21 Jul 2023 09:21:37 +0000
Message-ID: <PH0PR11MB51918208B7FE0413548F2DE5F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20230721083821.1820881-1-Meng.Li@windriver.com>
 <b8333812-df9d-368a-939b-3495878a2e5e@linaro.org>
 <884ed5d5-8863-ac76-5f00-4ed58480e9ab@linaro.org>
 <PH0PR11MB5191F52F01EF337A5965F848F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <2dac9cb5-2582-2e5d-689d-49ced2dbde5b@linaro.org>
In-Reply-To: <2dac9cb5-2582-2e5d-689d-49ced2dbde5b@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|MN2PR11MB4616:EE_
x-ms-office365-filtering-correlation-id: f57a48b1-d1f5-4c9e-188c-08db89cbe28c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WtWPiS/R9MVhKLPNwElgVmwnmfKCyQgm8vWFpy9EWIIT2gS1CEXfNui9G49v76u+LuP0trkTNIIMeLnRkm88Yo59obDpZngJa5O1rB3tUZQlb+bZEtw/9WvJG1wDOZqnUePO7IHn6kW8PCK0+sMKD054ESg5klkaklDKg/JzbQNedFOY6bA0dN9GYpSliOK8yWeL/RaXburgIqzuIobc+RblkhPxWgOEvRoVfUhYLsXNeICAo0RaOT+kj4ldlutxjShQVGrfMEtWXyGMdEs0daJOq4/NstyBV2ytgG3U/3bwFSwIRkETRmueutLNQ1wY8Fd7SFN3kOI/T/1BJAGbInOGZHiInSCrRFx0u/9hOc+ndkydSnF/GEUt9Dsw2tRa9pMUgISTFAId88j3Ck53etqqq2tQbg193g0XntXAdFw3wrIf1YMru/ajj/jyqR3dm2ml1rX8ZrfE6wog5CgHN4fZvxBVFsA0KlCrlwHGjF1zkIZnpVQGjSqHth5jumVCRsobtUrj0ZVILs3OrVXtNOdDj5t3Nv/q5TCPGCSi4Kja39UZ5IblmH2vBQpqM5LP4e+SpTUpuJztzNcymh7SeWs6EiVmZzxQ3DIKVnD7pTU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39850400004)(136003)(376002)(346002)(451199021)(9686003)(55016003)(966005)(71200400001)(38070700005)(4326008)(66556008)(66476007)(64756008)(66446008)(7696005)(2906002)(316002)(110136005)(66946007)(478600001)(86362001)(76116006)(6506007)(53546011)(83380400001)(186003)(38100700002)(122000001)(5660300002)(52536014)(33656002)(8936002)(8676002)(41300700001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1JRdFZmanNQZEpkYlJkU1FkMXRGdDRVQ3ZYWmNiUE9ZZ2RQWkgybm5xMW9u?=
 =?utf-8?B?QTJtWXZIako5TkV4WUQwOE05WXdDVUxkeFBvYlZGZDJZZlpLS2lnbVUvNFVv?=
 =?utf-8?B?cHByMnhCOG1QYkpKT0xwMUIyT2p1dGFZdFZmZy9wSG8vNFR2c1B3VWR3YnZu?=
 =?utf-8?B?SGZXeVZiK1JsNzdpMUR3ZFpFZnRpVVphRzY5bzFuTENhOHd0SW51aXE4cjlE?=
 =?utf-8?B?ZzFWOVhOaTNHWTFnN1k2SmdCQnZlelBVVDRsdzhsZEsyTTduZFdtOTJpVlIw?=
 =?utf-8?B?Y1VKakhYbEZLVXVUeTJndVlOSVBHQzB0UVFCWHR3Y3hEV0ttYVBiMDNJZW4z?=
 =?utf-8?B?OGwvRXlIMlVXdGpxeGtHd3BXMkFQL3NGTmN4a1g1WXlpdWM5YVZpQU02Q24v?=
 =?utf-8?B?R1NyVXFqUjh0dkRadjFnZWFkRWxLVnNJUHJHNk5XMDRac3hUdXd2TmZvZDBk?=
 =?utf-8?B?Mnhwc3YyNncyOU5CTzg0VEQwY3dobmc3cmozdkZMNjVqVUkwWTQzVWcyYVZN?=
 =?utf-8?B?dlBXS3JIZDBJa2lKa1JscTlNQzJwMnlzdjl6VTYxV2FlN1hEUzRDclUvMmFt?=
 =?utf-8?B?SFVPVlJlbEhrN3JhaU91S253aEI3Q1BQam9BeFlVaS9BUEhHL1J4TEV4Y1hN?=
 =?utf-8?B?VE4zUlRsTnJUVEE5MmN4eENHRE1LOEd2UjY4b0hrZkhrMmFUdkVvNVFpakxm?=
 =?utf-8?B?V1pSL3hBSklIY1lHRDNRd3R6eExVaTFuYUU3VTV1LzZMeDB0NDBTd213cmJa?=
 =?utf-8?B?elpTRml1c2ZPVVZJYzd0RVNOUjdkVkV3eUNlOGJMbHNwbWNEbUFCMERSVGtI?=
 =?utf-8?B?c3lkeEFTWkJvM28vSURGL0JxR1YrcUJnT1N6YU1zRE1JSWZaMXlST05qTzRa?=
 =?utf-8?B?SVBxNDVqSmJpd1pkMXhRdWVpeFlLNjhOSmVIdE9PbDIwcjQ0TEZnMDdrdWdw?=
 =?utf-8?B?RFBuNzBTaUVqY2pFeERqVWtsSUFvc2ZuOFQvSTlWUWVwUGY2UEM2Y1l5Ty91?=
 =?utf-8?B?RGQ2VUxTQVhjTDgrRzdxUlhQeEl5RE9MTGFiM3EzZElOZ0pSODUrN284SU5H?=
 =?utf-8?B?Wm5reW96aE8vZEFNbGJEcFhBOVVob0VITjNNeXo1djA1eGp6TEpMOWdDenB3?=
 =?utf-8?B?OUltYy9ZUG1IdCtFNWFENEZQUXQ1NjdBeWRNUmcxV2Z6MllYOWxOMi9jcGs4?=
 =?utf-8?B?S2FZZzh0N24wdjhpZFRURENteGk4Z1Fvc2RzUENhTUEzOUFPV042TjNySWR4?=
 =?utf-8?B?YlJkMUczYXNpeVNnZmJWTnFRQUpWQVNOb3lnS2xQcFo1YlRDZEp4VGo5a0VU?=
 =?utf-8?B?OFJhWE9JODY2aU9SK0lpeE1GR1NzYXJaQitBamV0QmkxKzdYeldEQ0FydENq?=
 =?utf-8?B?MkVJY0RKekZKMU5IVGlCcnN2ZVZwTXZWYjVzOER1SnV2ekovcnN0c05qaEFk?=
 =?utf-8?B?OXpZdGRxbFplL20rZG5reGRKUzZ3Yi85cmRLUE1pN3lVZGNyVVgyT0xhNFdJ?=
 =?utf-8?B?NzBpeTR3T1hHRDk5dDlzR3FqSHM5aE1zTWpPbzBNK3d4U3gwM3ZENVZpSllT?=
 =?utf-8?B?clpDTTJSbHQveXRvaWpYYUoxOEhRLzFhNWt1cGhhT3AyaTl4UFJ3MXNLaEZC?=
 =?utf-8?B?Z3FjNG85TXBwQ1Q0b1crR2owMWJ5Q295ZXZkcWl3MjV2M0VsTHlvSW9KZEhu?=
 =?utf-8?B?RkhQL25DcHphNENEdHM1K1FpVWpyR0dzT1lhQ3lSM2pVdGhSRm5WQkR2T1Jh?=
 =?utf-8?B?VUhNak40Yys3UUZCaGFRYnJrTjBrQUh0VTJxMGpUT0pvNEQ3bUVMcXBxU0JH?=
 =?utf-8?B?RGNMNjhCMHROY2xKMkx4STFuSFJFWWxsdFNUWVQzMnNSKzB3a0ZBMGtzTUY5?=
 =?utf-8?B?R2NtY0N3NjdiQ1dnS0pUem1tWlZxL0hPTFZXdEUyenNybkxKSU0vdytkcjhX?=
 =?utf-8?B?MlNZTXZaVHpFYUxBMnp1aWZqeXVaL3UwZ0tVb1k2cGNDSmx0eHh4T2p3SlZn?=
 =?utf-8?B?NUorRkNDN3BabmhnZSs3dkU4eGcvVDZVSzZDY29ObXEyclBRc3krQ282OTYx?=
 =?utf-8?B?ZGg1K1c0b1g3d2JjNnZPQk5aK2pSWkI4aHNWZlBBdmxuU01ZaDRCQkNrMzlS?=
 =?utf-8?Q?ut4oN+nHIihIiZxabChVhXIUe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57a48b1-d1f5-4c9e-188c-08db89cbe28c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 09:21:37.5124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mz+dy2fFqvnkbzT8bJotJA5O/54FBKVGDT+QVAwBbML9PFOGz4BFI1hEXGosRGV/1JshbGkf8zWuFlVqzx5orA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4616
X-Proofpoint-GUID: JWTzLVWBAaaW7kL5bZAzhHO6w3WozV9f
X-Proofpoint-ORIG-GUID: JWTzLVWBAaaW7kL5bZAzhHO6w3WozV9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_05,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307210083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1
bHkgMjEsIDIwMjMgNToxOSBQTQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVyLmNv
bT47IGRpbmd1eWVuQGtlcm5lbC5vcmc7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW3YyIFBBVENIXSBhcm02NDogZHRzOiBzdHJhdGl4MTA6IGFkZCBuZXcg
Y29tcGF0aWJsZSBmb3IgSW50ZWwNCj4gU29DRlBHQSBTdHJhdGl4MTAgcGxhdGZvcm0NCj4gDQo+
IENBVVRJT046IFRoaXMgZW1haWwgY29tZXMgZnJvbSBhIG5vbiBXaW5kIFJpdmVyIGVtYWlsIGFj
Y291bnQhDQo+IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kDQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4gDQo+IE9uIDIxLzA3LzIwMjMgMTE6MDUsIExpLCBNZW5nIHdyb3RlOg0KPiA+DQo+ID4NCj4g
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+PiBTZW50OiBGcmlkYXks
IEp1bHkgMjEsIDIwMjMgNDo1NCBQTQ0KPiA+PiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJp
dmVyLmNvbT47IGRpbmd1eWVuQGtlcm5lbC5vcmc7DQo+ID4+IHJvYmgrZHRAa2VybmVsLm9yZzsg
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiA+PiByb2JoK2Nvbm9yK2R0QGtl
cm5lbC5vcmc7DQo+ID4+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+ID4+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbdjIgUEFUQ0hdIGFy
bTY0OiBkdHM6IHN0cmF0aXgxMDogYWRkIG5ldyBjb21wYXRpYmxlIGZvcg0KPiA+PiBJbnRlbCBT
b0NGUEdBIFN0cmF0aXgxMCBwbGF0Zm9ybQ0KPiA+Pg0KPiA+PiBDQVVUSU9OOiBUaGlzIGVtYWls
IGNvbWVzIGZyb20gYSBub24gV2luZCBSaXZlciBlbWFpbCBhY2NvdW50IQ0KPiA+PiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUN
Cj4gPj4gc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+ID4+DQo+ID4+IE9u
IDIxLzA3LzIwMjMgMTA6NTEsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4+PiBPbiAy
MS8wNy8yMDIzIDEwOjM4LCBNZW5nIExpIHdyb3RlOg0KPiA+Pj4+IEludGVsIFN0cmF0aXgxMCBp
cyB2ZXJ5IHRoZSBzYW1lIHdpdGggQWdpbGV4IHBsYXRmb3JtLCB0aGUgRFdDMiBJUA0KPiA+Pj4+
IG9uIHRoZSBTdHJhdGl4IHBsYXRmb3JtIGFsc28gZG9lcyBub3Qgc3VwcG9ydCBjbG9jay1nYXRp
bmcuIFRoZQ0KPiA+Pj4+IGNvbW1pdA0KPiA+Pj4+IDNkOGQzNTA0ZDIzMygidXNiOiBkd2MyOiBB
ZGQgcGxhdGZvcm0gc3BlY2lmaWMgZGF0YSBmb3IgSW50ZWwncw0KPiA+Pj4+IEFnaWxleCIpIGhh
ZCBmaXhlZCB0aGlzIGlzc3VlLiBTbywgYWRkIHRoZSBlc3NlbnRpYWwgY29tcGF0aWJsZSB0bw0K
PiA+Pj4+IGFsc28gdXNlIHRoZSBzcGVjaWZpYyBkYXRhIG9uIFN0cmF0aXgxMCBwbGF0Zm9ybS4N
Cj4gPj4+Pg0KPiA+Pj4+IEFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yu
a296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4+Pg0KPiA+Pj4gRnJvbSB3aGVyZSBkaWQgeW91IGdl
dCBpdD8NCj4gPj4+DQo+ID4+PiBEaWQgeW91IGp1c3QgZmFrZSBhIHRhZyB0byBwYXNzIHRoZSBy
ZXZpZXc/DQo+ID4+DQo+ID4+IEkganVzdCBkb3VibGUgY2hlY2tlZCBteSByZXBsaWVzIGFuZCB0
aGlzIGZvciBzdXJlIG5ldmVyIGhhcHBlbmVkLg0KPiA+Pg0KPiA+PiBOQUssIGRvbid0IGZha2Ug
cmV2aWV3cy4gVGhpcyB2ZXJ5IGltcG9saXRlIGFuZCBkZXN0cm95cyBlbnRpcmUgdHJ1c3QuDQo+
ID4+IFRoZSBtb2RlbCBvZiB1cHN0cmVhbSBjb2xsYWJvcmF0aW9uIGRlcGVuZHMgb24gdGhlIHRy
dXN0LCB3aGljaCBpcw0KPiA+PiBub3cgZ29uZSBmb3IgV2luZHJpdmVyLg0KPiA+Pg0KPiA+DQo+
ID4gTm8hIEkgZG9uJ3QgZmFrZSBhIHRhZy4NCj4gDQo+IFJlYWxseT8gVGhlbiBJIGFzayBzZWNv
bmQgdGltZSAtIGZyb20gd2hlcmUgZGlkIHlvdSBnZXQgaXQ/IFByb3ZpZGUgYSBsaW5rLg0KPiAN
Cg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDcxODAzMDg1MS4yMDE0MzA2LTEt
TWVuZy5MaUB3aW5kcml2ZXIuY29tL1QvDQoNCnRoYW5rcywNCkxpbWVuZw0KDQoNCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
