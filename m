Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFFC759095
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGSIqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjGSIqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:46:02 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4B019F;
        Wed, 19 Jul 2023 01:45:58 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36J6x1Tn028103;
        Wed, 19 Jul 2023 08:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=6yU6neI1j39oYR9e8iYUILeg1U2uYVdlzm47woS+nFM=; b=
        fnLkv3mEdq/qhETx9Tsp6Wm8X+Juf2k0MqTI43deSwl6wdzhb6bTLZK6PkyS5ueX
        jR1Al2IYuP3qqOHTKclaiVF6+RYLGF1YLvkfVcKvi2oGHIW1QknbGwqb2GZMRtq6
        vMILvCSnZlQiYJSUCgGCqgj7TJs5iMM2PIRUKGWkOJOwLtMPK8OdZ9FFAKVTROz4
        +a6f+jONbYIKNPv/YvVkq08qNN2/ZbtYiLZpb+MZtk0Hcbg5F1G+jCRN/SHbAJ32
        ag3EUDMKzjBXxMQaiEXUKXrdMhSam6kad1hFsunbqHJ4N+mmNZeHK6UrAF8pY4mV
        bEjUXh12xeR3Shepocgjuw==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run8abf3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 08:45:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToejBk9uVEywyLhbbPZUiuHGTu1A5bSoplpCr/CH9SuDn1EFZP1upAs4/4w68SOFdDEv6JyzI52IL9Ju1+QvBmOJP+3SKxih5ibOnUULZjH4tfXe7un0ZCnYWoz0U4z1DeKGklyG//1/1uF+ghrqJ5MVO3HA4q97DCjb/QOeMy0UKbF9493jFHhAuaJibv+oqB3/gJrGfmdAbZstwY8yilhqlMDoNaqWlLw00Pz0kkPrIdy7zVPjnGLIUyI4J6WXN2TAo/dBX7JZ1en5OvubBNDapNQ1G1VPrUgSHcAZ1hLtgnaSXBmlaCsSPCgo05UfJ9Jftgiqa06sEzXOtyBTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yU6neI1j39oYR9e8iYUILeg1U2uYVdlzm47woS+nFM=;
 b=mwYoHER0g1q8DNfyp5lmiuxmZG9+Zn6p95JFfKDiV9ASkOCTQvTEQd1d97VFBbTsh99M2fLx1Pz5VSkFOnUCnhSIplZcs63/Kd1BNpcfI33apnuucPgTVwNc2bf4DQd3HBA9Qwd7k7O5iRXts14cGxqAuCJXFWPCr3lyiAmZVs9aMgamP8YIyEK3rTQGTmByd1D2galq+vEo0/c2fb3x8ldPiO2rORr28zw+7dx6nTCtJv3PLcSNra4b6+BtibrxS38fP0leK8yVG7LJSHLogixil7R9kAJnw9p10S3JMkoxo3k0C2T+lp7HlWriE4wl1kiLdHUIgeWUg/9lY+VsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by CH3PR11MB8545.namprd11.prod.outlook.com (2603:10b6:610:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 08:45:39 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 08:45:39 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] dt-bindings: usb: dwc2: add compatible
 "intel,socfpga-stratix10-hsotg"
Thread-Topic: [PATCH 3/3] dt-bindings: usb: dwc2: add compatible
 "intel,socfpga-stratix10-hsotg"
Thread-Index: AQHZueyAFusz4XumYEyDAazHOHYAza/Ao6MAgAAh9eA=
Date:   Wed, 19 Jul 2023 08:45:39 +0000
Message-ID: <PH0PR11MB51913FB3A55B1420B7798C01F139A@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20230719025509.3007986-1-Meng.Li@windriver.com>
 <20230719025509.3007986-4-Meng.Li@windriver.com>
 <488835c0-e08e-c0cc-abac-192f658b093f@linaro.org>
In-Reply-To: <488835c0-e08e-c0cc-abac-192f658b093f@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|CH3PR11MB8545:EE_
x-ms-office365-filtering-correlation-id: 7acba6f2-65bc-45da-fbc5-08db8834873f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uGxrnuI4M1u2sxUJgXJB0/TBvtEDNuN17XkD6zPYswd2iacrloAdZVWchB6wZdkKTPq4EZNWWISTf/h+swRXWknLKJlAmpvkryMRd3Lf+qzUI78moZzSDOXUqXtZhrvlPW5amNO6jYnOsCrxRVYveOxRzo/jZNYyFaz4tqQh7eivJxMQzfjJZnCLB6aNhWVwdA3z/qUsb82iWUneVFauAtZJ/Al7/3tMWBpq0XdbefILxcW9P6dxNCn8sqtk5AXenGGZNDTbSBor2dfu8yQ//3gRUa5pkLr/LnJyXxcElLq+VFdgIjcbqZs9gbuzsYacXbrZTHMlLrxW3+4fsJSEuiN0F1Qm1kW0dpl7JZD5CQxnSnSuK5g7W8prlC9Qp5Y36hdMk5LA+CWp3ApRtnc7tCAYH1tG1ZRue0t8fFvw8BYu8QU54uTcznh8rHx4kpufbhF27A+/z6/oUcvq9ES2hrXHK1d66kFPauI+5i1Bk7m5ipFinw9zgb3JDm6ZNL5fBKBOoG3p7qDHqUqZ5eKYm7avrHLTojv7YEQs6aV090kGKDRMyKDiYS6q1Lnydk6sAKxmjyJlKk0dTKDvkCu9NzGS68hOPHdPI/aIJL5WaegHr0ripb+0PA/hdNjQ1XjB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39850400004)(366004)(451199021)(7416002)(86362001)(2906002)(33656002)(38070700005)(55016003)(9686003)(186003)(83380400001)(53546011)(26005)(6506007)(38100700002)(110136005)(76116006)(7696005)(122000001)(316002)(66556008)(66946007)(66446008)(4326008)(5660300002)(52536014)(478600001)(64756008)(71200400001)(8676002)(8936002)(66476007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkdHeXp5YldBZHkya2NNblVKcHhvU0ZGeWxtOVlmc2RqWHlzS2dpckhrUGR4?=
 =?utf-8?B?a2pFSjUxbnp5UVVwV0lldEVmWnBEYytNRTFYZU5ndStiN0FTSHpRYUg1RGNG?=
 =?utf-8?B?K0JmQ2thaEhRaGRXSVVGMDJlZGowdGdxT1JYU2tMUXRLMmFocjRYU2xCSHpI?=
 =?utf-8?B?ZktNbCsxaWFReFErcGlKdFZ2cVMxckwxVmVUT0hvUVhVRTYvWUg4THpjdk1z?=
 =?utf-8?B?aExrMXRXdEVhWnJZa0pnb3UxTXhiY3NzQ1R3aGNzVHVTYWxTSXlJaHZiczJl?=
 =?utf-8?B?LzAydW1ydThicmtORlJSa2UxeEYwZ0h4K0JpM1lkUWREM2lWekV1VmRLTkt6?=
 =?utf-8?B?djd6TDIwdEdnSUZvejNPYkQzTGY0NnFJY1Y0dS9CbVRiQkFyVGVsTlF4cVBH?=
 =?utf-8?B?QkN6ODJ3UzFIeS9FWWhjYlF3b1lpcGpOSE5YeEZZVzArWnZDQ0lzUE5iTDFS?=
 =?utf-8?B?ZkRVRFRYbXVxQlAxWll0OWxVK0RIUkxJczZ3alRvaUVpSWFyKytmblBSS2xo?=
 =?utf-8?B?aDFnbEhxV1hzcStaK3ZkVTFJZk8xZlQ4ZWdxZ2xvUkdQYWZqTUVPaUpNd2xi?=
 =?utf-8?B?WERFVk9ZbjUxSEppT1pVajIrSGRVcjgvb1J1MVRQTzNHN0Y3VTJlUWwxczkw?=
 =?utf-8?B?RHpvb3kwZ3VJbW5zcEEwejlUMlVhbExMZnVEeFk4WUpMbzNrTkQwNmQ1djV6?=
 =?utf-8?B?RVluekJ3N2JZU05GblhQR2xqalI2ZklFejBIWEc5Z213d2lVUzIvUktoeHhS?=
 =?utf-8?B?Mm9MZUljT1Z1dmJtZFZiVk4yOVRSM1pDMEwzY1Urc3RZK28xSzlYajYrQTlX?=
 =?utf-8?B?a3NMbk04ZXp5WUE3TUhhMUZDd0M1bkNuVEFVSmhmdXdiS2wrelB0VUxvVk81?=
 =?utf-8?B?T25TRUhWUSsrWUxJQkt5czRxck5vZ05HWUFxUXNiT0ZBUmlOeFVIMDhyOUpU?=
 =?utf-8?B?Q0dZeWFqMlVSQ1Z3ODJ6NkYxSWRPWnpWamtVMWMydWUzRGpQYk9FRGVNSzc5?=
 =?utf-8?B?KzVEV0lURk12am9HUkl5Skt3Tlk4eGhOVXM0eGE3ZUVsSlFmWXVma1dqT2d1?=
 =?utf-8?B?dzVJb1Z4SGxoK040dVFHMXRxL01ZQjBjVS9HSmV5R0hRczdId2NsK1EwNlRs?=
 =?utf-8?B?UWdEZEY1SmxwbUtEbExnd0NlMEV1SU9RVEdHRFJKWHR5L0gvQjVVWU1rUTlB?=
 =?utf-8?B?NnBPeld5d0tHaitqTVJGUFgzc1ZFYVE1Q09CM3RaWEtrbXJRT241QmQ5b05B?=
 =?utf-8?B?VDRic0Z4MVFwUXNUeFZqWlNuU29QYVdPOWxSTjlQTG1IYmxPb2pXVFUrQ3Zs?=
 =?utf-8?B?emZ4MzJsb0ZwY1VtM3hKU25yMFVONXdMZ3hLaVZiNGJDQ0FHNmUxK3ExMEFU?=
 =?utf-8?B?ekUzVlNIR0FVNWE0YlpaSlQvU2RGdmNKZWdXNVhXSUh5Vlp1cjk3NHVYeXZR?=
 =?utf-8?B?dFpUeDY5eUxPejdiSXV0REtaMnBEOVVVMEdycnFhK2hINHM5d0JTL21Ua1Zk?=
 =?utf-8?B?dWczU2MvQ3AvNnFmcDhvVnBxYXdBYS92b2V4M2pmbi9zU25YNS8yaWRNN1Jl?=
 =?utf-8?B?YjlLWmlLd0tEcmdlNnNpUnNueXdXYm00ZHFvTGtLQjFUc1p2czRnam1BSnhM?=
 =?utf-8?B?d3YwWmJNLzhoTVExQmYvTXdsU2x1OFFpTnd1dzZFVzI3cU1Qc0FLMWhaZlZZ?=
 =?utf-8?B?WDFkYlpPZnZQaUdHVy92N1pxTGhUSERkdEh0M3diZDRLYkdwbTVTVXNLUlF0?=
 =?utf-8?B?YnFTUWlSR09CaEplQ1JRd3pqZzV3M3BZNUxMbm5CUFRVdmxvOGpScTVyb0Iw?=
 =?utf-8?B?bDIwUTFzaVMxOHBFdnBEK2dWQ3VtRXkxci9jaWNZSW12cDR1ZVM4bVE0Um9j?=
 =?utf-8?B?aFVFekJGNVhhYnhCRnR3cGNCamFFSDNUZ2tRRitEZVZFejRId25LYUkxY2V2?=
 =?utf-8?B?WEN6MjNMdERHU3U3WlFqOWVJQm0zeVJJak1LTUNCUllXRFVpSzU2eVQ2VFd3?=
 =?utf-8?B?RTRWS1VPOUJMTXQ0V3pvY3JMTmpKekJETWFiWGR6OEhqTzBTZ011ZElmUFha?=
 =?utf-8?B?bkR6NndVKzV2Q1VnV0pqVzlFdEd5TGY2Vjh1WEk2Y2ZVcW4vM2ExdWlIQ1ZB?=
 =?utf-8?Q?Q7GbyaiimfWWWKF6wNXbvv9zd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acba6f2-65bc-45da-fbc5-08db8834873f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 08:45:39.1562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cg97VENQqyErmeRu+MVGFE20erlfTb2AaQqzlf6YCvGC+la2VviO0HXWd3PMnwtCviMsqJBtvjXT6g1ANso6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8545
X-Proofpoint-GUID: SXmjRK8YpRR_-k83OpcygEQAGjvRbHj0
X-Proofpoint-ORIG-GUID: SXmjRK8YpRR_-k83OpcygEQAGjvRbHj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_05,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=893 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307190079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEp1bHkgMTksIDIwMjMgMjozOSBQTQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVy
LmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7
IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsN
Cj4gZGluZ3V5ZW5Aa2VybmVsLm9yZzsgaG1pbmFzQHN5bm9wc3lzLmNvbTsgbGludXgtdXNiQHZn
ZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGR0LWJp
bmRpbmdzOiB1c2I6IGR3YzI6IGFkZCBjb21wYXRpYmxlICJpbnRlbCxzb2NmcGdhLQ0KPiBzdHJh
dGl4MTAtaHNvdGciDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIGNvbWVzIGZyb20gYSBub24g
V2luZCBSaXZlciBlbWFpbCBhY2NvdW50IQ0KPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiBPbiAxOS8wNy8yMDIzIDA0OjU1LCBNZW5nIExpIHdy
b3RlOg0KPiA+IEFkZCB0aGUgY29tcGF0aWJsZSAiaW50ZWwsc29jZnBnYS1zdHJhdGl4MTAtaHNv
dGciIHRvIHRoZSBEV0MyDQo+ID4gaW1wbGVtZW50YXRpb24sIGJlY2F1c2UgdGhlIFN0cmF0aXgg
RFdDMiBpbXBsZW1lbnRhdGlvbiBkb2VzIG5vdA0KPiA+IHN1cHBvcnQgY2xvY2sgZ2F0aW5nLiBU
aGlzIGNvbXBhdGlibGUgaXMgdXNlZCB3aXRoIGdlbmVyaWMgc25wcyxkd2MyLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogTWVuZyBMaSA8TWVuZy5MaUB3aW5kcml2ZXIuY29tPg0KPiANCj4gTWlz
c2luZyBjaGFuZ2Vsb2csIG1pc3NpbmcgdmVyc2lvbmluZy4gVGhpcyBpcyB2MyBvciB2NC4NCj4g
DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdj
Mi55YW1sIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdj
Mi55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3YzIu
eWFtbA0KPiA+IGluZGV4IGRjNDk4OGMwMDA5Yy4uZjkwMDk0MzIwOTE0IDEwMDY0NA0KPiA+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMi55YW1sDQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MyLnlhbWwNCj4g
PiBAQCAtNTEsNiArNTEsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgICAgIC0gYW1s
b2dpYyxtZXNvbi1nMTJhLXVzYg0KPiA+ICAgICAgICAgICAgICAgIC0gYW1sb2dpYyxtZXNvbi1h
MS11c2INCj4gPiAgICAgICAgICAgICAgICAtIGludGVsLHNvY2ZwZ2EtYWdpbGV4LWhzb3RnDQo+
ID4gKyAgICAgICAgICAgICAgLSBpbnRlbCxzb2NmcGdhLXN0cmF0aXgxMC1oc290Zw0KPiANCj4g
U28geW91IGp1c3Qgc2VudCB0aGUgc2FtZSBwYXRjaCBhcyBiZWZvcmUuIEkgcG9pbnRlZCB5b3Ug
dG8gdGhlIHByb3BlciBzb2x1dGlvbg0KPiB3aXRoIGNvbXBhdGliaWxpdHkuDQo+IA0KDQpOby4g
bm90IHRoZSBzYW1lLg0KSSBkb24ndCB1bmRlcnN0YW5kIHdoeSBTb0Mgc3BlY2lmaWMgY29tcGF0
aWJsZSAiaW50ZWwsc29jZnBnYS1hZ2lsZXgtaHNvdGciIGlzIGFibGUgdG8gYmUgYWRkZWQsIGJ1
dCB0aGUgU29DIHNwZWNpZmljIGNvbXBhdGlibGUgImludGVsLHNvY2ZwZ2Etc3RyYXRpeDEwLWhz
b3RnIiBpcyBub3QgYWxsb3dlZC4NCg0KWW91IHNhaWQgIldoZXJlIGlzIFNvQyBzcGVjaWZpYyBj
b21wYXRpYmxlPyINCk5vdywgSSBhZGQgdGhlIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlICJpbnRl
bCxzb2NmcGdhLXN0cmF0aXgxMC1oc290ZyIsIGJ1dCB3aHkgaXQgaXMgc3RpbGwgbm90IHJlYXNv
bmFibGUuDQoNClRoYW5rcywNCkxpbWVuZw0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBL
cnp5c3p0b2YNCg0K
