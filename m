Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6789876BBF1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjHASIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjHASIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:08:10 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E724E103;
        Tue,  1 Aug 2023 11:08:08 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371Hn07K014036;
        Tue, 1 Aug 2023 18:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=pFjnewi1vLLVy5mT4Srml6ka8/hKtyIdC4RGqJDS3pI=;
 b=EmDaK98elVVefA3jQHwuNjscCipSj0/TBEMhcJ1Cpc3hm1svxA0yKFokQtTbp+iE2oeM
 4/ILM7Df1FMSot0e9VpsLvtDGje4r+BfMGmUtD7W/obLeFJPQKWdU/Q45ehYOxoaWEZ+
 Wo9NZw5sUuQstg2RiSlWQ7snG/wDAue75jPwcQdSN0PTu5JA5q9RLfDseRDXqfrfxXHJ
 PbkjkPHkLI4sqEG4gHHQ7Znf1VLuGOYgtRvL8t3TCkxWLaA3OpQkFsjN2mT4p4ssyfgz
 Ungw11zdhj12TJt4UMvqx+RNnSrXS824ebi38o5IX1dbQMXloC0/s7f9bX0xdxuxgy4J gA== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s6w8pnsv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 18:08:03 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8AB95800EC5;
        Tue,  1 Aug 2023 18:08:02 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 1 Aug 2023 06:08:02 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 1 Aug 2023 06:08:02 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 1 Aug 2023 06:08:02 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg9fRQHxsboyt/mlU1QmWIH4dlDLRYA5OqY+EG8xIBkPkb2/JSIXZt+gjry2Qsc7cYfI/Iv65ydPRGC6Mlnq3tVHXpSEK+KD4I871f5HChZOAW6PkReqjEeJvBu4P7cw1TwWfGm/TjOntebhHiP6K/GAAqHd42CIewq5oPWEK7pAEXYtiyhp2JavW+Ir6mxRKvSmug15Q7zbatph8Rc06YZ1fwnOavVFYN/MAXFAi3j8GtIkDRrfr9uEvg+4TnS/hFQxxav6xDNKm0XBQnDXOxxiLY7lNy8xR5IkyzmFznLneD3BOoYJyHY6vTxqlocMLbBMAAuu6cPFLLiro13zAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFjnewi1vLLVy5mT4Srml6ka8/hKtyIdC4RGqJDS3pI=;
 b=lsI+olnw4vSL+tT6kRD32P0IMizsPeOacHbdpHyGBwY1nF3wsLTsJ8t1aHHj6jUsAjAqP7kKdoyLG+ylWidWFt3WIUEbLE9j5woHZe+wvChp92bjsdm1O9oGAW3ZzaLZ2SWi1KaFXPTMU6BZPSJ/1ISsbTxp8YDlP44JJzTFso4geVpvu0SRttxOPwMvpggozJnK5oI3bpbFV4fLnY/jHDRFtx15NcuWniazphKemh9eKHl+Xzxe2Qd/gu+zEXeF5dNOqL6vkRL48Y+BRz8al+f7x9XRJ2u0SGRJkprjSE66hITTTOWCgTVdG0DCEIcc4uXdzuRio/C2uLyuj9KnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::14)
 by MW4PR84MB1804.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 18:08:00 +0000
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d0e:da5f:f782:9327]) by SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d0e:da5f:f782:9327%4]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 18:07:59 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/3] dt-bindings: usb: Add HPE GXP UDCG Controller
Thread-Topic: [PATCH v1 1/3] dt-bindings: usb: Add HPE GXP UDCG Controller
Thread-Index: AQHZsFXDXRwLTnyj+EG3EOG0eweVQK+t+ScAgCfp9zA=
Date:   Tue, 1 Aug 2023 18:07:59 +0000
Message-ID: <SJ0PR84MB20854B4A444283E31025FA398D0AA@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230706215910.78772-1-richard.yu@hpe.com>
 <20230706215910.78772-2-richard.yu@hpe.com>
 <9f1bd0f1-d93e-243a-4622-721319fd1235@linaro.org>
In-Reply-To: <9f1bd0f1-d93e-243a-4622-721319fd1235@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2085:EE_|MW4PR84MB1804:EE_
x-ms-office365-filtering-correlation-id: 9862c54a-213b-4ae7-489f-08db92ba3da8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61WeoJOJhai+wGRwQsIwHYUpWhEWdsjf6v2eqPKvqXvvaYKnx51KAQEsN07hqDbFYFQfMqtLpciWWugNpQmRcWSANT2j9eXi/886lK6YLvZW3P5N/hNuhU3pmONosuqiSsVLM+QMuDU6LCNP4qBhVTL2jgw6rZpZnLGoN1PYHozhWwSNLc/54SAMBBxj2NLRreDyprJW7e0+7nQA6GFt+pAhVQV3vVcWYRTVbjdnu2T7DRaxMuqhfkumJXm2r76goPoUwgABd1aks+nq0KXsCGfDlDamWrUTcYe6IyjDe1s2gPKuN3MXUq2nGX75GU2PBThsgx5jM/w+ER3XDCANMSrr88U281iK8WJOrloTneWxdO4nu+ZfIlr/pvsSRvFWcgYWyl6iAOfpBESs4d7RNH6Zoh+QWFSRdO2nTkEuvmbclqBPoI/ssP/jMFDyuKtVXz2eWMSAFE1vUwlH9qHJIZngMtdVDd467XQPbpZ7QlaG4nYVBncSpeKggCQKrd0UZsHrJu2CaQiibBbld3Vha7ZHfUErPtxNFmBYRoyrow0NSZL9N4CCD8ARaTmFO1zXiDyHicLvbzc5/Dgd0W0m7B5kdX6HUzR3mO3QDIbGRrOzWQr7aq2U+M970ai01UgoObp0qfgU1N+nYIGR7kbSTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199021)(64756008)(66556008)(66946007)(66446008)(66476007)(83380400001)(316002)(7696005)(9686003)(71200400001)(110136005)(478600001)(186003)(76116006)(55236004)(6506007)(26005)(38070700005)(2906002)(86362001)(33656002)(52536014)(41300700001)(38100700002)(921005)(122000001)(82960400001)(55016003)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3BPRjZOcjRiNUJPWEhmbmpSbEMzWUdjbGVTWGFRbXFaSzRyYXhpNkJxenA1?=
 =?utf-8?B?bFdTZGxHYlN6bStlaXFmS0NBd2YrNnE5ZXRaKy9GaGZyK1g1RGwzSnZQWE1y?=
 =?utf-8?B?amc0RncyTW14UDlBZjYyNE9wV210cExnM0VCNnpaTlBaWkV6enk3a2FzQTJR?=
 =?utf-8?B?cXVRUFdJR2VjaE11K2xPbDZ1RXViNVJTS0tybnNvZjdBaWkyTFRiaGpBQWdF?=
 =?utf-8?B?MG1qVGEyc1poVllsRzAyQm1TOXlWN3JXcExUKzRISUgzMmRHbm9aZlErRUxE?=
 =?utf-8?B?Y3hZQkhWbURxNDdvLytla2xFZWpCaUU4cFpQdnlZbjlDN1Jsb2xCb3lMYWRw?=
 =?utf-8?B?bVFGWW11NkVBblhOUjFFN3pzV0k5Z2VzTjliR3BiZkVUQ0h2ZFJiVFJZUnZO?=
 =?utf-8?B?SlRoczg5VmEveDV5enY5SFBXWTUrOENQdVZ1MmUwZHhRV3NBRkFiS3Nmd1Y5?=
 =?utf-8?B?NzJSK1ppck14M2xNcE1KL1lTS1RXODl2ckIrYTQ0My9rZlFDa09KVWZUKzFy?=
 =?utf-8?B?dGlhbEM3dVBxbEEreEVadStSWVhUUjVBaDlLNGs1NGlWdHlmeTg3dVByOVBj?=
 =?utf-8?B?NkxsN2o4Q2Q1UlduQ3ZDakwxYjdCeUlDQjlKMlRBeUZQSFl0bXF1WTkrUnhv?=
 =?utf-8?B?U1RTN0gvZEZPWWJzMW1PSFQxVHlId0dmZTNiN2xuL1VqNnJFTks5TEpGR1RR?=
 =?utf-8?B?WmVPSkQ3VkdtaVVXZFZlZVBqK25mRnQrc3J3SUVhbHpmTk5qWFJXS1JPYUNU?=
 =?utf-8?B?eGptc1VrR0lxMjcrMnBiOTZKelhPbUxNZGVVNXU1N0ZhVHB4S0NWMTNTcWZT?=
 =?utf-8?B?V3FIeFROZElVbEFIcE1OenNERHRDK2Evbm1TTjdtS0dDd0JpeVVHMnNwdy9S?=
 =?utf-8?B?WS9vTmN6Y1luMjZSazEzRWlCM3gvQmVMS1JkRnZhejZCamw5c1hwNlBIemZ6?=
 =?utf-8?B?WWtvL3dzaXFDdnNlOEd0OTlxK3R4b3BmSG0ySGtXcDlDWER3Rk9DNDJJMkxr?=
 =?utf-8?B?UlA0U283Ym0rYjg1SWFPZnYwRk5EbmJLbFpnV3lXTlM2YVZiMXZBY1A2ZXJo?=
 =?utf-8?B?Z09aN2JzWGloMEN0TUZkVDNRWVNkZkhkTFpxNHZycHNLcWg4c0VMaHBmdEd3?=
 =?utf-8?B?My9kUDU0aGpxUEtua2YrUGRTUVIyT1diVjJVdlg4WVJRMHlSQW9TV1ZiMGlG?=
 =?utf-8?B?enFhcWRweUJndW5TWGYzVjJZQVA5MGZSUENHdkZjdUtYdXJjZkt4WVpzNWpP?=
 =?utf-8?B?OE5xYlZLd3Z4eTNUUzVkYU4vQmQ0VGtnWUx0QVBTdTN0VjBoSlhSSjRwNVhS?=
 =?utf-8?B?bGVJSFhiYXJEWVVyeUZyL3RpbVlYek9ZK1I0SVZ6Y1JsTGFmNTBqdk1ycVBF?=
 =?utf-8?B?YWV5eEhNZ0RNRmZJa0lDbVFYUG9aTGd3UHB2VTlDY0VUK0xIcFJLUzJERXNW?=
 =?utf-8?B?bU5TQUNIZ2VjaHhVcTNNVTJ6d3hPZDlNdThoNGxrWXVrUFZtM0tYb0R1NzR6?=
 =?utf-8?B?cnpIbXFDakNpeVVmeVdtOXRSeXBXQUpSWmJHZFF3UUVVL0pGYzJRU09BVERB?=
 =?utf-8?B?Mm5YQVpQRnRVcnJjSUxCczZKL1IyUWJKcUhtRlA3TjBrTDZORmJNdkZ5NVMx?=
 =?utf-8?B?RnlaQ05ncjV6Mk1Ibnh3VC9FbTVtVHVJK0hIc3dSYjRoUjY2TTQvamhYdmth?=
 =?utf-8?B?V2RtMFRzbTJZZnhXRndYeUtnUm56RGticjU1V3o3RDk3WDB4ck1uY2ExYTJx?=
 =?utf-8?B?YXNUaWU2YTVxTmRKeHd1WHNqZk12NGxUWUhPVGNubmFkK3VUenErTlVTSW4v?=
 =?utf-8?B?MmpzV0huWUM2dEtrVFZaYjE1V0RZSy9HQ3B3WWwxaXNRWUNuVVRUQWJsT0h5?=
 =?utf-8?B?MENpZ1VqZXNwcWkrVldFdnFaWkR3cmttZlJXeDdHbDhGb0xBMEIreHZvejFI?=
 =?utf-8?B?aFZxQVRJTFZjeDFBdktWV1VmVXBsZGZJSjFOZHdjQ2hqcHg1SEl5R1ZlWDBv?=
 =?utf-8?B?eDRCdGFIdkZHNUZKVThJbEI4cTBlQU43b3VzUFJoUU4xU3M0YVY5WHFXVGRv?=
 =?utf-8?B?d1EvN3h5T2tWWDkxY2FSZUR2aU5neEgxTlVqR2tXc0RtUHVMNkdoREtsU1hL?=
 =?utf-8?Q?HwyQCHQ4pQ8dokYjQBhoNrysc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9862c54a-213b-4ae7-489f-08db92ba3da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 18:07:59.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Etjh16aCmXVF6Z6Js0sf/yq2+RBzoty4BV91RN318YbRuJoGZtaP2PwIckXMQoG3hwGhxQp2Qdg4GaciPFyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1804
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 0GQ4ty3nYm67FfKZflMyRRHZJv6KStjH
X-Proofpoint-ORIG-GUID: 0GQ4ty3nYm67FfKZflMyRRHZJv6KStjH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_16,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=363 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiArdGl0bGU6IEhQRSBHWFAgVVNCIFZpcnR1YWwgRUhDSSBjb250cm9sbGVyDQoNCj4gVGhl
IHdvcmQgInZpcnR1YWwiIGluIGJpbmRpbmdzIHByZXR0eSBvZnRlbiByYWlzZXMgcXVlc3Rpb25z
LCBiZWNhdXNlIHdlDQo+IGRlc2NyaWJlIHVzdWFsbHkgcmVhbCBoYXJkd2FyZSwgbm90IHZpcnR1
YWwuIFNvbWUgZXhwbGFuYXRpb24gaW4NCj4gZGVzY3JpcHRpb24gd291bGQgYmUgdXNlZnVsLg0K
DQpIZXJlIHdlIGFyZSB3b3JraW5nIHdpdGggdmlydHVhbCBkZXZpY2VzIHRoYXQgYXJlIGNyZWF0
ZWQgYW5kIGhhdmUgbm8NCnBoeXNpY2FsIHByZXNlbmNlLiBXZSBoYXZlIG1vZGVsZWQgb3VyIGNv
ZGUgb2ZmIG9mIEFTUEVFRCdzIFZIVUINCmltcGxlbWVudGF0aW9uIHRvIGNvbXBseSB3aXRoIHRo
ZSBpbXBsZW1lbnRhdGlvbiBpbiBPcGVuQk1DLg0KDQo+PiArIFRoZSBIUEUgR1hQIFVTQiBWaXJ0
dWFsIEVIQ0kgQ29udHJvbGxlciBpbXBsZW1lbnRzIDEgc2V0IG9mIFVTQiBFSENJDQo+PiArIHJl
Z2lzdGVyIGFuZCBzZXZlcmFsIHNldHMgb2YgZGV2aWNlIGFuZCBlbmRwb2ludCByZWdpc3RlcnMg
dG8gc3VwcG9ydA0KPj4gKyB0aGUgdmlydHVhbCBFSENJJ3MgZG93bnN0cmVhbSBVU0IgZGV2aWNl
cy4NCj4+ICsNCg0KDQo+IElmIHRoaXMgaXMgRUhDSSBjb250cm9sbGVyLCB0aGVuIEkgd291bGQg
ZXhwZWN0IGhlcmUgcmVmZXJlbmNlIHRvIHVzYi1oY2QuDQoNCldlIHdpbGwgcmVtb3ZlIHJlZmVy
ZW5jZXMgdG8gRUhDSSBpbiBjb2RlIGFuZCBkb2N1bWVudGF0aW9uLiBJdCBoYXMgYmVlbg0KbW9k
ZWxlZCB0byBmb2xsb3dpbmcgQVNQRUVEcyBhcHByb2FjaCBhcyBtZW50aW9uZWQgYWJvdmUuDQoN
Cj4+ICsgaHBlLHZlaGNpLWRvd25zdHJlYW0tcG9ydHM6DQo+PiArIGRlc2NyaXB0aW9uOiBOdW1i
ZXIgb2YgZG93bnN0cmVhbSBwb3J0cyBzdXBwb3J0ZWQgYnkgdGhlIEdYUA0KDQoNCj4gV2h5IGRv
IHlvdSBuZWVkIHRoaXMgcHJvcGVydHkgaW4gRFQgYW5kIHdoYXQgZXhhY3RseSBkb2VzIGl0IHJl
cHJlc2VudD8NCj4gWW91IGhhdmUgb25lIGRldmljZSAtIEVIQ0kgY29udHJvbGxlciAtIGFuZCBv
biBzb21lIGJvYXJkcyBpdCBpcyBmdXJ0aGVyDQo+IGN1c3RvbWl6ZWQ/IEV2ZW4gdGhvdWdoIGl0
IGlzIHRoZSBzYW1lIGRldmljZT8NCg0KVGhhdCBpcyBjb3JyZWN0LiBXZSBjYW4gY29uZmlndXJl
IHRoaXMgVkhVQiBDb250cm9sbGVyIHRvIGhhdmUgb25lIHRvDQo4IHZpcnR1YWwgcG9ydHMuIFRo
aXMgaXMgc2ltaWxhciB0byB0aGUgYXNwZWVkIHZpcnR1YWwgVVNCIEhVQg0KImFzcGVlZCx2aHVi
LWRvd25zdHJlYW0tcG9ydHMiIG1vdmluZyBmb3J3YXJkIGluIHRoZSBuZXh0IHBhdGNoDQp3ZSBh
cmUgZ29pbmcgdG8gdXNlICJocGUsdmh1Yi1kb3duc3RyZWFtLXBvcnRzIg0KDQo+PiArICRyZWY6
IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPj4gKyBkZWZhdWx0OiA0
DQo+PiArIG1pbmltdW06IDENCj4+ICsgbWF4aW11bTogOA0KPj4gKw0KPj4gKyBocGUsdmVoY2kt
Z2VuZXJpYy1lbmRwb2ludHM6DQo+PiArIGRlc2NyaXB0aW9uOiBOdW1iZXIgb2YgZ2VuZXJpYyBl
bmRwb2ludHMgc3VwcG9ydGVkIGJ5IHRoZSBHWFANCj4+ICsgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQoNCg0KPiBTYW1lIGNvbmNlcm5zLg0KDQpXZSBpbnRl
bmQgdG8gY2hhbmdlIHRoaXMgdG8gImhwZSx2aHViLWdlbmVyaWMtZW5kcG9pbnRzIiBmb2xsb3dp
bmcNCkFTUEVFRCdzICJhc3BlZWQsdmh1Yi1nZW5lcmljLWVuZHBvaW50cyINCg0KPj4gK2V4YW1w
bGVzOg0KPj4gKyAtIHwNCj4+ICsgdWRjZ0A4MDQwMDgwMCB7DQoNCg0KPiBOb2RlIG5hbWVzIHNo
b3VsZCBiZSBnZW5lcmljLiBTZWUgYWxzbyBhbiBleHBsYW5hdGlvbiBhbmQgbGlzdCBvZg0KLi4u
DQpXZSB3aWxsIHVzZSB1c2ItaHViLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2ssDQpS
aWNoYXJkIFl1DQoNCg==
