Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D53A77646C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjHIPwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjHIPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:52:37 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50991BD9;
        Wed,  9 Aug 2023 08:52:34 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379BVdGU023137;
        Wed, 9 Aug 2023 15:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=hGhNnVq4ZNu7CBBpuyT9mO25/Akfae2lvcJmksPag9E=;
 b=fFvZYX67114uafymn5+W/VWC8NWdjsvJef7ZfYMFpQtUgPzTDyp8CimxtFG4zZTJHdMN
 dqRn5fazJa/ew1+pi/VFKRcE8G4U8+mRtrS4VK4jQqg0ZUKz8ZziHnuOmFesQ8hA9RVs
 xQ7CUkXNliGWURNALimEU322GaDLA1J3d9uUkaAlg47zYONl5iDHo1PXKerH5dvqgtPE
 0L4808a12L2T4Q2JCkWaS0hWGhvSpEuO+lSJAErITiF85cMQF5HK66VAqoPRgHJ0Ov4p
 jdvZz1Ln7i38OTbigWRnsCoBUrFpKN34pR9sNPUT67jyZmnhbJ+5zdxfE2HizH1zk2yb Bw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sca0h2aaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 15:52:27 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 72E4E800189;
        Wed,  9 Aug 2023 15:52:26 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 9 Aug 2023 03:52:25 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 9 Aug 2023 03:52:24 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 9 Aug 2023 03:52:24 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 9 Aug 2023 15:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jC6BB1VaEAKFHmYiXmhGGOHRB3TWBLDKG4a8wfPRKMK6PzcU15IS9OR9zcUifvWlC5/YiBfVtYBYVLdEa6iwf8OILBJHm21OyS06GG7F0NOhlOVRP5GwhqQehul7FWKmaPMCUf/FRw2OoJklIAYoSFMTYe+NNeGRPecKVzJqDaR9Ypj7D9KjzXJOz38lXYXMrmvkWrTCQI6svJJEf31cMCStAkqDTGklWbqavCzOEo4qmB0+8LbuXSWARmK1eM7b/zDwwcJ0fcCk9iRCLOtDPdm0xWnDlSrzxm8zeMi4wTg/uBW/y1BzacJVuxtYTHD+Mfg+vFzcz4oudlFgBpSDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGhNnVq4ZNu7CBBpuyT9mO25/Akfae2lvcJmksPag9E=;
 b=TXCjhL+Bj8yYh8e3PfETZ+MvbtdBZ8XpwEil43wdgbUWKCd+s5Iew9w/6pqDz6FQGL0ez+0HLsLRe0OUvh/nrjuFtiRX4AMc5DwI8TEzliNCZT1Rr+/i6L3mp+9QDLnhg9LFp9nlDJdFQqMOaEMAh1Mr++a0/Ch3b5OohhKwtXt1GRyM52lG1uPGpjDH7YdRpNVsxNeabIbpaNdbPPsPHwqeopZnzDTR8Dx8OGT972uNhyNiw0OIyY+BF4EP2lXcDg4q+O3IGmm3YLCjS7mdI8Ryjt3MJm/z+7r3iiy3AzvraPmXOgLE3SVoK4LMNG4eoUuDnOnkppTClCshczxH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::14)
 by LV3PR84MB3555.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:52:19 +0000
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d0e:da5f:f782:9327]) by SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d0e:da5f:f782:9327%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 15:52:19 +0000
From:   "Yu, Richard" <richard.yu@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chang, Clay" <clayc@hpe.com>
Subject: RE: [PATCH v1 1/3] dt-bindings: usb: Add HPE GXP UDCG Controller
Thread-Topic: [PATCH v1 1/3] dt-bindings: usb: Add HPE GXP UDCG Controller
Thread-Index: AQHZsFXDXRwLTnyj+EG3EOG0eweVQK+t+ScAgCfp9zCABlytgIAF9gGA
Date:   Wed, 9 Aug 2023 15:52:19 +0000
Message-ID: <SJ0PR84MB2085BDDFD7C46A73C489A6E48D12A@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230706215910.78772-1-richard.yu@hpe.com>
 <20230706215910.78772-2-richard.yu@hpe.com>
 <9f1bd0f1-d93e-243a-4622-721319fd1235@linaro.org>
 <SJ0PR84MB20854B4A444283E31025FA398D0AA@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
 <e2e7c830-07f4-a34e-6bf8-c9e8dc33bf57@linaro.org>
In-Reply-To: <e2e7c830-07f4-a34e-6bf8-c9e8dc33bf57@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2085:EE_|LV3PR84MB3555:EE_
x-ms-office365-filtering-correlation-id: d580a07c-bb33-4c29-0f6a-08db98f09cfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T9Qvpj3eEzZv8HWALHJNOZ1xmBKzBV73pvAq50qlTkqbmUHJORCnrBIvzSkJ438UhANxvdJZ/zPOSETJPVNHqZhdT0/X53ms/Sk95I5KNPiuVLD/4EA579NUeSGjJ+k22POkdPaYR+tAaPPiVJXjwNVr/YM/NOpZmS1DLBCbWb7qk0avEX46bzm9nfPizTsJBSIyJj+FBUu83McsTDUe9c5zBkjHlq+TWOl4nCgFWKwukmHxuMdBn4rmGiVtPsy6icfalX0K1rLG+O4IGpfxpRXNiP4ewnVwHdtoafJbf+fbX32Gh0uNsDiS+eibamsYyCoCR24H/ta+38LEj7LFOJqMgYGfkS1Pc+C8Os7K4UCSL+LjRLniHQnG+Q3AtrxVbCz+JUEYuBi9NHEbkVPFinKDtTcfI6jMgM2mfm5VztrcgjNglJvLVWmSwwrlT4VLZvysSfuNGOFQqzUru3cDf4Hd9Fl3wGM0Ky8JZmC25SxWOyvCJ3huSHzeoLb45VNnOicewYclzCIcfxePPGE8CqnxVcdeekrk0cY9FQVGgqYgC5TErqJc+zryac3r2sIQ1CQBD+rv/jy7YTUl6gnX8A9VxuwbWHn/DMaZdAk+YWv8dv/yLFO587Ot0tr7+0f+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199021)(186006)(1800799006)(9686003)(55016003)(26005)(53546011)(6506007)(55236004)(33656002)(38100700002)(110136005)(52536014)(5660300002)(86362001)(38070700005)(6636002)(2906002)(76116006)(66446008)(66556008)(66476007)(66946007)(41300700001)(8936002)(8676002)(316002)(64756008)(71200400001)(7696005)(122000001)(478600001)(921005)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTFZK1hrM2lHOHZMTmJMRnJZTzVZUDNVOS9UR3RWRTdHKzhldXVWczIrTTlo?=
 =?utf-8?B?QXkzVnQxdWNUenNBSTNTSC93VjdJUnE0a0ZEdm1iU3o4RlpINy9XRHduNUR0?=
 =?utf-8?B?L3VaUnFSTjRtK1hrNmZqYm1Vem5SQk9Vam9TRTYvWUN1NlMveDkxVzduTGsz?=
 =?utf-8?B?Y0hYUW1GcnZkT0hEVjIxU3ppVDluY0MzbzROd3VaTHBLbi9EcVcvdFhRZXV4?=
 =?utf-8?B?L3F1TVQ4SU9CZ1FSQVdEdkpSUngxeSswdnFLaHdnbFJXZ3JFOGE3Sy9wd2JW?=
 =?utf-8?B?anRkNU1rN3hrV1pUTDJNVGdpWmk5Z1UxSW5BMVJWemdqN0tpNy9JVUx4U3F1?=
 =?utf-8?B?QWNUZlBBdCtJQjNDYkVVVWhmVk11MEx0a05rdVF2Q1pqRlowZGVyVEdPSzV4?=
 =?utf-8?B?N2VrTDRmVzllOE1FWlZzUjlSTVQ3WUttQ2tiQjBGbmkweHdMTlNScDhZcTZx?=
 =?utf-8?B?dkFCT2NoV1BUSUdkeWNBTEZjdnhFS0ZDYlJUUTJ3VW9JQXFUUEZ6NFI5NW9r?=
 =?utf-8?B?ZDdOQzVzWUhpNnd1c0tDU3dsZ2VzZnlranpMdnZLcXo3MzYrb253SVdoV3R0?=
 =?utf-8?B?VEtBUnlwQjRTdzRBTUc0eHl3VFRPd2U5YmN4QXJVMzBYZG9XRlh0UXVYKytr?=
 =?utf-8?B?UDBaUDNGL2VTSEhMazVOMDBFQVZYVnR2ajhWL0lmR1lnYllYWWZ1bXJ0bzZx?=
 =?utf-8?B?VmFvcFFmZkY1K2F3cGtvSXZqMS94RXFKYWpud0NGR3pFY3VwRTNkb1cxTFVm?=
 =?utf-8?B?QTRubWpkQ2tZeFBDYkdtRW1Tcm5ITkUrd0FjbFhZeUx2TFVaN1BDakk5RzBQ?=
 =?utf-8?B?SUpPeldGSWx0clVLbWJ2Smt5djh0aitxWTRQdHc4Y2d6c01SdXlyd1YvTzVE?=
 =?utf-8?B?WS9jZjlaZTZuQ3VYay9mSEpTSVcyb09rK3VNZm5vc1liakNWWkR6R0hBUjJt?=
 =?utf-8?B?RXBjcWNRelFZTkdRZ052Kzc4TEx4Q3Vsbzd3ZUJ3QVkvQ1RYNFRhcUFCL0xH?=
 =?utf-8?B?WVhPTUswWVZMTTNlYk1qMVJab0VLRVBkZXo4Tno4aWlKbXJBOVNWdExuVnpL?=
 =?utf-8?B?S3VzSFd3aFN2QWdmRXZJbWp0N054ZlhPa3hVc2tnUXFpQVdTUWNUZE0va3lh?=
 =?utf-8?B?QU05SFZRV21adEU0NFhZYnhyYm4waHpPRG85aDhydXA1K1NHYVVta2FXWlR5?=
 =?utf-8?B?NlRqVmJyNVB2Z0p0Tk1mZC9EK0xXZDgxVGUwczQyTnVTV1BGaFpvUlhoQTFq?=
 =?utf-8?B?KzNBOU52WnhFSjlhTkI3ZFBoZlZGTVc4aHZhMUJ6QVRTYldCMy9tM0tHb3Z2?=
 =?utf-8?B?eWNadDRLTnBFcFRUa2prZC9MWC9ubUFIY1JZemdJSnZzWTFpN3JGUkZkeFM2?=
 =?utf-8?B?akVSQi92eUhEQ0hIQ1Zzc0JUTHo0OU1FaTBreWdKM0s3Zi9hb1BtekxvUmVa?=
 =?utf-8?B?a3lRUXF3U2o2OFI1V3BOQjREZ2laM2svSkg4NVI4endpdDBuRktGQTNHMDg5?=
 =?utf-8?B?QW1sWXhZamF5SkNKc1k0L0FDMXNuVFFWSWRpVmg5YjY3NEJCalpYYUNKTnRU?=
 =?utf-8?B?ZVA0QW9EZjBBMmZ2bk84ZExrQ1RVSTIrN0VOZFJDc3hHcWNwYktJVSs0bFFj?=
 =?utf-8?B?cW41TkV5b1ZhWFpGZ3FuYklDOWJCWlp2a2tjbUZwTXY5aittTHhaQ3ZxRHoz?=
 =?utf-8?B?R0E0MVZrTnRDMjcyNzA2Qmk1NTIrTzNnK3ltakNQR2VScVVVY0dTeDV0MytP?=
 =?utf-8?B?eXBYZEE0SzlBQjA5eWJZOVBnbzJHanJBaU8vd05laU9CRkJTMSs5bTZremxm?=
 =?utf-8?B?WHRTZzAvak9zRUtQbS83WUxmZlFLYjkyeWl3TTJOVldUVDRTeGlNcWMyL2l0?=
 =?utf-8?B?eUl5cTE4SWpCM000VkJaN2tKVzB1aUN1NWxxRWhuc3VjUEQwMll6MlE2WDJt?=
 =?utf-8?B?QmJzc241SXFKajUyR05OTi9zV2xiSlBiUHVBcklaN08wOEc5MnYrKzNUK0RE?=
 =?utf-8?B?NCttUllXRENaS0ljRUlQOXFxMVJ2b3ZzZ1V2Vk1wclh4TnJZNGxxeVVCRnov?=
 =?utf-8?B?emI3VWFqRE1BdGdLRWF2cmxlVUlIUUxEWVpvMVAzQmptRzJKVXhmZndLdGlZ?=
 =?utf-8?Q?2eQM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d580a07c-bb33-4c29-0f6a-08db98f09cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 15:52:19.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NVnHLPmQxXG3VqEKS/Qr1zyHWBAZPtIy7bS/G81aIu4n+tU6XOGKL7IsZf5vTsL+r+8+3xsOWYjC4VKQJxnew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3555
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 65SkiBC1ZnfiPVHnpq-KeNJQed70EK9m
X-Proofpoint-ORIG-GUID: 65SkiBC1ZnfiPVHnpq-KeNJQed70EK9m
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_13,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=851 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91LCBNci4gS296bG93c2tpLCBmb3IgeW91ciBmZWVkYmFjay4NCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5r
b3psb3dza2lAbGluYXJvLm9yZz4gDQpTZW50OiBTYXR1cmRheSwgQXVndXN0IDUsIDIwMjMgMjow
OSBQTQ0KVG86IFl1LCBSaWNoYXJkIDxyaWNoYXJkLnl1QGhwZS5jb20+OyBWZXJkdW4sIEplYW4t
TWFyaWUgPHZlcmR1bkBocGUuY29tPjsgSGF3a2lucywgTmljayA8bmljay5oYXdraW5zQGhwZS5j
b20+OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5
c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGxpbnV4
LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvM10gZHQtYmlu
ZGluZ3M6IHVzYjogQWRkIEhQRSBHWFAgVURDRyBDb250cm9sbGVyDQoNCk9uIDAxLzA4LzIwMjMg
MjA6MDcsIFl1LCBSaWNoYXJkIHdyb3RlOg0KPj4gDQo+Pj4+ICt0aXRsZTogSFBFIEdYUCBVU0Ig
VmlydHVhbCBFSENJIGNvbnRyb2xsZXINCj4+IA0KPj4+IFRoZSB3b3JkICJ2aXJ0dWFsIiBpbiBi
aW5kaW5ncyBwcmV0dHkgb2Z0ZW4gcmFpc2VzIHF1ZXN0aW9ucywgYmVjYXVzZSANCj4+PiB3ZSBk
ZXNjcmliZSB1c3VhbGx5IHJlYWwgaGFyZHdhcmUsIG5vdCB2aXJ0dWFsLiBTb21lIGV4cGxhbmF0
aW9uIGluIA0KPj4+IGRlc2NyaXB0aW9uIHdvdWxkIGJlIHVzZWZ1bC4NCj4+DQo+PiBIZXJlIHdl
IGFyZSB3b3JraW5nIHdpdGggdmlydHVhbCBkZXZpY2VzIHRoYXQgYXJlIGNyZWF0ZWQgYW5kIGhh
dmUgbm8NCg0KPiBVbmZvcnR1bmF0ZWx5IEkgZG8gbm90IGtub3cgd2hhdCBhcmUgdmlydHVhbCBk
ZXZpY2VzIHdoaWNoIGRvIG5vdCBleGlzdCBwaHlzaWNhbGx5LiANCj4gSSBoYXZlIHNlcmlvdXMg
ZG91YnRzIHRoYXQgdGhleSBmaXQgRGV2aWNldHJlZSBwdXJwb3NlLi4uDQoNCkluIG91ciBIUEUg
Z3hwLCB3ZSBoYXZlIGFuIEVIQ0kgZGV2aWNlIHdoaWNoIGl0IGlzIHByZXNlbnQgdG8gaG9zdCBh
cyANCnN0YW5kYXJkIEVIQ0kgY29udHJvbGxlci4gIEhvd2V2ZXIsIHRoaXMgRUhDSSBjb250cm9s
bGVyIGRvZXMgbm90IGhhdmUgDQphbnkgcGh5c2ljYWwgcG9ydC4gVXNlcnMgY2FuIGZpZ3VyZSB0
aGlzIEVIQ0kgY29udHJvbGxlciB0byBoYXZlIDEgdG8gOCBwb3J0cyANCih3ZSBjYWxsIGl0IGFz
IHZpcnR1YWwgcG9ydHMpIGFuZCBhdHRhY2hlZCAxIHRvIDggVURDIGRldmljZXMgKHdlIA0KY2Fs
bCB0aGVtIGFzIHZpcnR1YWwgZGV2aWNlcykuIFVzZXIgY2FuIGZpZ3VyZSBlYWNoIHBvcnQvZGV2
aWNlIHRvDQogaGF2ZSAxIHRvIDE2IGVuZHBvaW50cy4gDQoNCkkgYW0gd3JpdGluZyBoaXMgZHJp
dmVyIHRvIGNyZWF0ZSB0aGUgZGV2aWNlIGRlc2NyaXB0b3IgZW50cnkgZm9yIGVhY2ggcG9ydC9V
REMuDQogL3N5cy9idXMvcGxhdGZvcm0vZGV2aWNlcy84MDQwMDgwMC52aHViLzgwNDAwODAwLnZo
dWI6cDEgLi4uLiBUaHVzLCANCnRoZSBPcGVuQm1jIEtWTSBjYW4gdXNlIHRoZW0gYXMgdmlydHVh
bCBtb3VzZS9rZXlib2FyZCwgdmlydHVhbCBOSUMgLi4uLiANCg0KSSBhbSBpbXBsZW1lbnRpbmcg
dGhpcyBkcml2ZXIgdXNpbmcgdGhlIEFzcGVlZCB2aXJ0dWFsIGh1YiBkcml2ZXIgYXMgZXhhbXBs
ZS4gDQoNCkp1c3QgbGlrZSB0aGUgQXNwZWVkIHZpcnR1YWwgaHViIGlzIGluIHRoZSBEZXZpY2V0
cmVlOg0KDQp2aHViOiB1c2Itdmh1YkAxZTZhMDAwMCB7DQoJY29tcGF0aWJsZSA9ICJhc3BlZWQs
YXN0MjYwMC11c2Itdmh1YiI7DQoJcmVnID0gPDB4MWU2YTAwMDAgMHgzNTA+Ow0KCWludGVycnVw
dHMgPSA8R0lDX1NQSSA1IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KCWNsb2NrcyA9IDwmc3lzY29u
IEFTUEVFRF9DTEtfR0FURV9VU0JQT1JUMUNMSz47DQoJYXNwZWVkLHZodWItZG93bnN0cmVhbS1w
b3J0cyA9IDw3PjsNCglhc3BlZWQsdmh1Yi1nZW5lcmljLWVuZHBvaW50cyA9IDwyMT47DQoJcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCglwaW5jdHJsLTAgPSA8JnBpbmN0cmxfdXNiMmFkX2Rl
ZmF1bHQ+Ow0KCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQp9Ow0KDQpJbiBteSBjYXNlOiAgKEkgYW0g
cmVwbGFjaW5nICJ1ZGNnIiB3aXRoICJ2aHViIiBhbmQgcmVtb3ZlIHRoZSB2ZWhjaSByZWZlcmVu
Y2UpLg0KDQogdmh1YjogdXNiLXZodWJAODA0MDA4MDAgew0KCWNvbXBhdGlibGUgPSAiaHBlLGd4
cC12aHViIjsNCglyZWcgPSA8MHg4MDQwMDgwMCAweDAyMDA+LCA8MHg4MDQwMTAwMCAweDgwMDA+
Ow0KCXJlZy1uYW1lcyA9ICJ2aHViIiwgInVkYyI7DQoJaW50ZXJydXB0cyA9IDwxMz47DQoJaW50
ZXJydXB0LXBhcmVudCA9IDwmdmljMT47DQoJaHBlLHZodWItZG93bnN0cmVhbS1wb3J0cyA9IDw0
PjsNCglocGUsdmh1Yi1nZW5lcmljLWVuZHBvaW50cyA9IDwxNj47DQp9Ow0KDQo+PiBwaHlzaWNh
bCBwcmVzZW5jZS4gV2UgaGF2ZSBtb2RlbGVkIG91ciBjb2RlIG9mZiBvZiBBU1BFRUQncyBWSFVC
IA0KPj4gaW1wbGVtZW50YXRpb24gdG8gY29tcGx5IHdpdGggdGhlIGltcGxlbWVudGF0aW9uIGlu
IE9wZW5CTUMuDQo+PiANCj4+Pj4gKyBUaGUgSFBFIEdYUCBVU0IgVmlydHVhbCBFSENJIENvbnRy
b2xsZXIgaW1wbGVtZW50cyAxIHNldCBvZiBVU0IgDQo+Pj4+ICsgRUhDSSByZWdpc3RlciBhbmQg
c2V2ZXJhbCBzZXRzIG9mIGRldmljZSBhbmQgZW5kcG9pbnQgcmVnaXN0ZXJzIHRvIA0KPj4+PiAr
IHN1cHBvcnQgdGhlIHZpcnR1YWwgRUhDSSdzIGRvd25zdHJlYW0gVVNCIGRldmljZXMuDQo+Pj4+
ICsNCj4+IA0KPiA+DQo+Pj4gIElmIHRoaXMgaXMgRUhDSSBjb250cm9sbGVyLCB0aGVuIEkgd291
bGQgZXhwZWN0IGhlcmUgcmVmZXJlbmNlIHRvIHVzYi1oY2QuDQo+PiANCj4+IFdlIHdpbGwgcmVt
b3ZlIHJlZmVyZW5jZXMgdG8gRUhDSSBpbiBjb2RlIGFuZCBkb2N1bWVudGF0aW9uLiBJdCBoYXMg
DQo+PiBiZWVuIG1vZGVsZWQgdG8gZm9sbG93aW5nIEFTUEVFRHMgYXBwcm9hY2ggYXMgbWVudGlv
bmVkIGFib3ZlLg0KPj4gDQo+Pj4gKyBocGUsdmVoY2ktZG93bnN0cmVhbS1wb3J0czoNCj4+PiAr
IGRlc2NyaXB0aW9uOiBOdW1iZXIgb2YgZG93bnN0cmVhbSBwb3J0cyBzdXBwb3J0ZWQgYnkgdGhl
IEdYUA0KPiANCj4gDQo+Pj4gV2h5IGRvIHlvdSBuZWVkIHRoaXMgcHJvcGVydHkgaW4gRFQgYW5k
IHdoYXQgZXhhY3RseSBkb2VzIGl0IHJlcHJlc2VudD8NCj4+PiBZb3UgaGF2ZSBvbmUgZGV2aWNl
IC0gRUhDSSBjb250cm9sbGVyIC0gYW5kIG9uIHNvbWUgYm9hcmRzIGl0IGlzIA0KPj4+IGZ1cnRo
ZXIgY3VzdG9taXplZD8gRXZlbiB0aG91Z2ggaXQgaXMgdGhlIHNhbWUgZGV2aWNlPw0KPj4gDQo+
PiBUaGF0IGlzIGNvcnJlY3QuIFdlIGNhbiBjb25maWd1cmUgdGhpcyBWSFVCIENvbnRyb2xsZXIg
dG8gaGF2ZSBvbmUgdG8NCj4+IDggdmlydHVhbCBwb3J0cy4gVGhpcyBpcyBzaW1pbGFyIHRvIHRo
ZSBhc3BlZWQgdmlydHVhbCBVU0IgSFVCIA0KPj4gImFzcGVlZCx2aHViLWRvd25zdHJlYW0tcG9y
dHMiIG1vdmluZyBmb3J3YXJkIGluIHRoZSBuZXh0IHBhdGNoIHdlIGFyZSANCj4+IGdvaW5nIHRv
IHVzZSAiaHBlLHZodWItZG93bnN0cmVhbS1wb3J0cyINCg0KPiBNb3ZpbmcgZm9yd2FyZCB5b3Ug
bmVlZCB0byBhZGRyZXNzIHRoaXMgbGFjayBvZiBwaHlzaWNhbCBwcmVzZW5jZS4uLg0KPiBBcmVu
J3QgdGhlc2UgZGlmZmVyZW50IGRldmljZXMgYW5kIHlvdSBqdXN0IGZvcmdvdCB0byBjdXN0b21p
emUgdGhlIGNvbXBhdGlibGU/DQoNCkkgZG9u4oCZdCBmdWxseSB1bmRlcnN0YW5kIGhlcmUuIElz
bid0IHRoZSBsYWNrIG9mIHBoeXNpY2FsIHByZXNlbmNlIHNpbWlsYXIgdG8gdGhlDQpBc3BlZWQg
dmlydHVhbCBodWIgZHJpdmVyPw0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClRo
YW5rIHZlcnkgbXVjaC4NCg0KUmljaGFyZC4NCg0K
