Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9224975C30E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGUJ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjGUJ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:29:15 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3612D7F;
        Fri, 21 Jul 2023 02:29:14 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L9GllL007255;
        Fri, 21 Jul 2023 02:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=b0ek7nH19wKbAjSiIyjVESn0v4q7S4KGpQO2+5G9rsM=; b=
        PJWnHrZd1Ve26mbeT4WLqi+QBVCb77Lr5bNSOeEUXCf4ftKsTN0cAFJgFOwpHDzk
        Ccc5cKE8nJTPSv2inPc94L1jpeSiSfEmFzAVgnumC/zx4pntIoArEvtZtCUy9QoQ
        XkEimQ692Jgjb7IomUUw/D2QxrCHVjM+eyNvH5sRFWNxmltupgnyNmpseY3tISXR
        tcM4rKGa8rSkamJu3Rg4csTd4PScrvRGdOc29jtkutKmcf8XdZXQNxi2roKS0DM0
        wfOKnX8mAaBjV5nuJWDccMyhAT4SFLJRbDGLDgf9q6qDbnRa35CddkxXlAi2UsJP
        tDr/n8iWuJnXuLhk1OpaAA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rupqydk9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8ut/295lnfzrSP0SM7dcBDenu8dxeYxeIU/Q++rScQmdxpsgdancSRTO5/gl2hBohu2CPyTsgmjRCjsJ3eBh/jSgKAOd/GzE57qeLNPZ397DhqiAur1dAWrgjB9CPtONFRjXkrNNHaIF6tP1US31FGmsmEDs5n6gbdfXnNGdCQkMYNFBRIynyVIAxpQ+3sP7Wq6L4o6ZnGUjUJu11N9xk7PZXUkv3u9nGibY5Kq/23BWbX9AeDyOdfyImiiwUAlL0Ucl5068eXEl+yqXF7kY2U5R40llnXP8vwX5RVHiAXJ8LaNXMCcVC5SGjkUdbDYsIW2uwYoXR/XF9m31/I+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0ek7nH19wKbAjSiIyjVESn0v4q7S4KGpQO2+5G9rsM=;
 b=oJ8Bl51TS67MXz/ehk6yo/yCdWGJ+t7c5dFusbCCwmkq7CwF8MBQ5VQum1rsM+v6MBY22PjAeNpDrnrdSC0nc6Ka65P3EqL1ygoc1uJgyPfCUiEaGjP/IOK0uxgCLtzsb4hRzSjX9rQlQqwXw0MQmSPeZ4LekBKg0xzLqpWVg24zdHu4T+2k5ffFiWXvmZE6+hd8Z472sliQZPNz7qFwetfEXsCtAsML2ufRpUpBnGVi29fuZR2xaassSs6yPNWMC+CoBcovjHf5ukcQkNhwTp5/cUvqD0GbqPtfnSfVkSDH4Njxwl0l4aAadJIPoP4/MQriOA2zIB5CZ3YdlpxMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by DM4PR11MB5343.namprd11.prod.outlook.com (2603:10b6:5:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 09:29:06 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 09:29:06 +0000
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
Thread-Index: AQHZu67AcgeVg8NpVU6sDsseuKM3QK/D6aGAgAAAxwCAAABzoIAABo4AgAAAquCAAABwgIAAAFcw
Date:   Fri, 21 Jul 2023 09:29:06 +0000
Message-ID: <PH0PR11MB5191D789F87D7C9546F192D0F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20230721083821.1820881-1-Meng.Li@windriver.com>
 <b8333812-df9d-368a-939b-3495878a2e5e@linaro.org>
 <884ed5d5-8863-ac76-5f00-4ed58480e9ab@linaro.org>
 <PH0PR11MB5191F52F01EF337A5965F848F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <2dac9cb5-2582-2e5d-689d-49ced2dbde5b@linaro.org>
 <PH0PR11MB51918208B7FE0413548F2DE5F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <846fad90-04b1-53e7-0f9d-1c243bbc6e92@linaro.org>
In-Reply-To: <846fad90-04b1-53e7-0f9d-1c243bbc6e92@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|DM4PR11MB5343:EE_
x-ms-office365-filtering-correlation-id: fffbbb76-5c99-497f-bd8b-08db89ccee17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7bQmM3dynKlpzYBR0DTAwh5MJwV5lF/lVW6pGK9MhmLkXx1DhfO++IaNOceQeBc+4wZPPc7j37FYqVFvnpN46NjyOjRvj2tZkVFuurdF+Q7Le22Hfk53royCBQ6d8tfpUGZi5/DNqhVGD3tdNymEGrZ9XNoLJOq86n49THTRIvROKzVUQkwLpLHUKB4qq620g3Uwlog379OI9pAb1F2Kmf1bOby6RfcYuULCQxmEZSREPP97F0qhTZiBu0hCE1JnCbeRiTjPqnWR3a6PfHYAr+pfrGpjdJGIKAY7f1/om4qjK/ZOYHZ1ButCEwDUQPzqwXaf/rxoG2pDW4tirZxzrXx2G9o3ySGhe2bj5n4uAvr5mAMQP4QkC4ucSMzVziyEe7QRBR69Uga2tB3FqnKWmEMS4NksfsiM0vffpVWRieXT7sDpVSf9iIMe0T8PjRFCwLxr+h8h4cojupZdo05BzEuxjUfYGryjUDk/3WqOjuR2nUIl+wU6Nm0dpDo3540WWB5p1gUJo6ShuANqa1q4kgmgF+bNTIVUugaxhKvfyUPRyD78VTFr9R6slOeL5dzXAUWI2SnYX6nM0K2GdK03a+6t+iMuP/qJjVKAw8Qg+x0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(451199021)(71200400001)(966005)(7696005)(9686003)(83380400001)(122000001)(84970400001)(55016003)(6506007)(38100700002)(186003)(26005)(53546011)(110136005)(316002)(478600001)(76116006)(66946007)(38070700005)(4326008)(86362001)(2906002)(64756008)(66446008)(66476007)(66556008)(8676002)(8936002)(33656002)(52536014)(41300700001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1gyWlU5OFg3RSszNHhyK0xpUmY1QmE0UldTb1I1ZUVualhZNnVVRGJVZlAx?=
 =?utf-8?B?OWp4THN2a2JaV2ZxK3lweWlURzUwYVF0UkhBdWtod3lGUy8wY1JCOEhSTzgv?=
 =?utf-8?B?RjNSejZvRkliam93ZUJxbTRwdzVhSEpwaWVVQXNGTW0xZDNHZXA5TzdDNnFE?=
 =?utf-8?B?QTZ6VWpNZTRpRUw5SVFwZ2FVTTRRQndRUzF3UTg5MFBlMUtNd2dONFNMLytL?=
 =?utf-8?B?VUF5ayszc2FsS1hRTmFKK3BHVEozd0piQU5hV2dkYlArUTVYNm9ua2t6RmlV?=
 =?utf-8?B?UHVHdFJodE10M1Zqd3FTMU9sYi95ek8rU01zMWU4L0ZmazhBNmpTcVZKQ1c2?=
 =?utf-8?B?K1pTUE8rTVRab242NSsyZHJTamY5UzI4UU1FeDhBNWQ4TU9rZnBqR0lIWHhW?=
 =?utf-8?B?bE5IN2dBTzdscnl4VUxPaGpHU3lYeXJSbmNYTDBNK3U4TTZEVExLTDd4NDBl?=
 =?utf-8?B?WW84MWNmaHcwQnpSbnpXZXhsc0hDZTBPQnF6dlRWYVdQczV6VTVjVVRyRGdD?=
 =?utf-8?B?UUpUcXB5UVY3UHJQbDBmbjFheVhMMElkazRZZFpzS2k0NGlyVlN5MS9kN1ZG?=
 =?utf-8?B?c2tJeTdCZm8yRmVHck40WVZEK2dxdlJUcWErRTZ1WERZTmVmVnlwTXZGYXNp?=
 =?utf-8?B?MG53NTBkZXprV09nMXZTU1pHWkxmdWxUY3VWVHVDQnBKTWZNVnEzR0psa3dF?=
 =?utf-8?B?TjFlTURQanRFRmVNU1o3elIrVlhDZVN1TzQxandqbGMvZGd3R0NZaVVWTThr?=
 =?utf-8?B?dGpVM1l2NTI5SEFtbnpZdytJNzJqM2lHMk53d2lVWk0wWWVnb21ZVytEZE50?=
 =?utf-8?B?ZFhKRmJBUGVLTW1NaE4yQ1lwOE8va2J3YXY5VzhibWxJbFB3SUFlYlRIQUtP?=
 =?utf-8?B?YTJFNXROYjhJWnhySzVhUE5WNU44bkxuaGQ0clFTYjZUT2dIL0twcHdoTEM3?=
 =?utf-8?B?ZmM3clFDc1k1clF5bzQ1cmxYdXdpd1ZYckJRTGhCMDJ0eG9EZkpORld5dzY1?=
 =?utf-8?B?Z0NXeUVMT1dkUGt2aDZETEtHR255SEFYeGIya29EWWVxVkVhVGdLMjNuemRq?=
 =?utf-8?B?YWx2QURON20vMlNZVmJ4TXQ0QXQ1UkdyYk9QdVNUZFowZk5vdEprMXpVWm83?=
 =?utf-8?B?Ty9aZHhleFIvZ2x2cFBvcjc1T3gwS2RINFhOSXBXVGtmc1htamhGMmQ1YnI5?=
 =?utf-8?B?UC8zQld2djl3WG92Z2VZSEl1c0ZNVnFld21ac1FEWE5Kek53MlBVa1V6NURv?=
 =?utf-8?B?eUlBRC9iblJ1WkVQcy9qNFJsNFFobWN0Y2xuV0lNcUlGTG1UVnFnZ2lYS1cr?=
 =?utf-8?B?UGdIS21oNTV3UUluN2FCVjBDczVwNkhxNytkcDUzNWdORXZTMi9tdVhKRllX?=
 =?utf-8?B?SjBKNzljNW5Kc2ZoU3l6VWxrWVkrME56ZSs3Ukw5ak5ZWTZtaHd4bmJRZ3RR?=
 =?utf-8?B?NVp4OTFjMEFicTdlQUdQSEdEL1Z5YURyazdudkV6cW10VjVjYnltMlcyRjBK?=
 =?utf-8?B?ZXhEYi9McTRLZU8vOHpXUzFPdWZ6YmU5YURzL1FtWWN2enJkY1R5bTdyNkJN?=
 =?utf-8?B?aklnM2djWS9qcUZOMmZ4NlhxbGpaOEJvU1g0YVpDUWpJcFZoMnFrY0t1WnlW?=
 =?utf-8?B?VUhVbXVUU2huKzJuYlNyWHM2RHlQdlcwdEtReXJId1pkSXQ2aEZ4S0s1c2N1?=
 =?utf-8?B?VWsvMmRQcXJrclR0em1JVnVHNWc0SjkwWlpCNnNkNndTbjdlM1ZPaC9Nc05k?=
 =?utf-8?B?bFcwRllnVHZpZ3ZVWWJmQWJEM2FZTEZ3SmxRYU54SHdCOUcrZ0M1Q05jVlIz?=
 =?utf-8?B?TG0xdSszaVpESStZc3pKdWZ4elR1ZGI1a0s4azhLb0RTUmtXL1p1TEhqNnE2?=
 =?utf-8?B?YUNjNHNpUFlFaEtlcGdpUERtQ2UwWE9Md3RUS21USHg0djdKalZRbnFUaGVt?=
 =?utf-8?B?THRYS1NGYTNiNVU2d0lRWTNuL3dxcDh0eUIxRHZoTkN5Qm9jVnBJYURRblo0?=
 =?utf-8?B?YTNGUXZ6OVdKeEh0RWVKRVhMdkZQVnU3dHJtalkzclRTeFNuK05XSGlkWjNH?=
 =?utf-8?B?b0lPb2p3QjN0azk5NTRxckdBd2ZIVTdNalUrN0dNSjQwWnVRMmxDdUFKLytK?=
 =?utf-8?Q?oH5sp4dkNzmu35HZJ1BJQXTkv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffbbb76-5c99-497f-bd8b-08db89ccee17
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 09:29:06.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMJgZwOVzaDV8iDaC6vpkqrHOZx6ouQCjrl96UV4gYwye1WVfaBZcWALBv5SOOwZKcosxB25KyuDz+p6koI/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5343
X-Proofpoint-GUID: cvyBAHxHAjykzhoQr0ypiwLUAi9Zwmws
X-Proofpoint-ORIG-GUID: cvyBAHxHAjykzhoQr0ypiwLUAi9Zwmws
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307210084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1
bHkgMjEsIDIwMjMgNToyMyBQTQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVyLmNv
bT47IGRpbmd1eWVuQGtlcm5lbC5vcmc7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW3YyIFBBVENIXSBhcm02NDogZHRzOiBzdHJhdGl4MTA6IGFkZCBuZXcg
Y29tcGF0aWJsZSBmb3IgSW50ZWwNCj4gU29DRlBHQSBTdHJhdGl4MTAgcGxhdGZvcm0NCj4gDQo+
IENBVVRJT046IFRoaXMgZW1haWwgY29tZXMgZnJvbSBhIG5vbiBXaW5kIFJpdmVyIGVtYWlsIGFj
Y291bnQhDQo+IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kDQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4gDQo+IE9uIDIxLzA3LzIwMjMgMTE6MjEsIExpLCBNZW5nIHdyb3RlOg0KPiA+DQo+ID4NCj4g
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+PiBTZW50OiBGcmlkYXks
IEp1bHkgMjEsIDIwMjMgNToxOSBQTQ0KPiA+PiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJp
dmVyLmNvbT47IGRpbmd1eWVuQGtlcm5lbC5vcmc7DQo+ID4+IHJvYmgrZHRAa2VybmVsLm9yZzsg
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiA+PiByb2JoK2Nvbm9yK2R0QGtl
cm5lbC5vcmc7DQo+ID4+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+ID4+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbdjIgUEFUQ0hdIGFy
bTY0OiBkdHM6IHN0cmF0aXgxMDogYWRkIG5ldyBjb21wYXRpYmxlIGZvcg0KPiA+PiBJbnRlbCBT
b0NGUEdBIFN0cmF0aXgxMCBwbGF0Zm9ybQ0KPiA+Pg0KPiA+PiBDQVVUSU9OOiBUaGlzIGVtYWls
IGNvbWVzIGZyb20gYSBub24gV2luZCBSaXZlciBlbWFpbCBhY2NvdW50IQ0KPiA+PiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUN
Cj4gPj4gc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+ID4+DQo+ID4+IE9u
IDIxLzA3LzIwMjMgMTE6MDUsIExpLCBNZW5nIHdyb3RlOg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4+Pj4gU2VudDogRnJpZGF5
LCBKdWx5IDIxLCAyMDIzIDQ6NTQgUE0NCj4gPj4+PiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2lu
ZHJpdmVyLmNvbT47IGRpbmd1eWVuQGtlcm5lbC5vcmc7DQo+ID4+Pj4gcm9iaCtkdEBrZXJuZWwu
b3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+ID4+Pj4gcm9iaCtjb25v
citkdEBrZXJuZWwub3JnOw0KPiA+Pj4+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+ID4+
Pj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4+PiBTdWJqZWN0OiBSZTog
W3YyIFBBVENIXSBhcm02NDogZHRzOiBzdHJhdGl4MTA6IGFkZCBuZXcgY29tcGF0aWJsZQ0KPiA+
Pj4+IGZvciBJbnRlbCBTb0NGUEdBIFN0cmF0aXgxMCBwbGF0Zm9ybQ0KPiA+Pj4+DQo+ID4+Pj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBjb21lcyBmcm9tIGEgbm9uIFdpbmQgUml2ZXIgZW1haWwgYWNj
b3VudCENCj4gPj4+PiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IHJlY29nbml6ZSB0aGUNCj4gPj4+PiBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZS4NCj4gPj4+Pg0KPiA+Pj4+IE9uIDIxLzA3LzIwMjMgMTA6NTEsIEtyenlzenRvZiBL
b3psb3dza2kgd3JvdGU6DQo+ID4+Pj4+IE9uIDIxLzA3LzIwMjMgMTA6MzgsIE1lbmcgTGkgd3Jv
dGU6DQo+ID4+Pj4+PiBJbnRlbCBTdHJhdGl4MTAgaXMgdmVyeSB0aGUgc2FtZSB3aXRoIEFnaWxl
eCBwbGF0Zm9ybSwgdGhlIERXQzINCj4gPj4+Pj4+IElQIG9uIHRoZSBTdHJhdGl4IHBsYXRmb3Jt
IGFsc28gZG9lcyBub3Qgc3VwcG9ydCBjbG9jay1nYXRpbmcuDQo+ID4+Pj4+PiBUaGUgY29tbWl0
DQo+ID4+Pj4+PiAzZDhkMzUwNGQyMzMoInVzYjogZHdjMjogQWRkIHBsYXRmb3JtIHNwZWNpZmlj
IGRhdGEgZm9yIEludGVsJ3MNCj4gPj4+Pj4+IEFnaWxleCIpIGhhZCBmaXhlZCB0aGlzIGlzc3Vl
LiBTbywgYWRkIHRoZSBlc3NlbnRpYWwgY29tcGF0aWJsZQ0KPiA+Pj4+Pj4gdG8gYWxzbyB1c2Ug
dGhlIHNwZWNpZmljIGRhdGEgb24gU3RyYXRpeDEwIHBsYXRmb3JtLg0KPiA+Pj4+Pj4NCj4gPj4+
Pj4+IEFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxp
bmFyby5vcmc+DQo+ID4+Pj4+DQo+ID4+Pj4+IEZyb20gd2hlcmUgZGlkIHlvdSBnZXQgaXQ/DQo+
ID4+Pj4+DQo+ID4+Pj4+IERpZCB5b3UganVzdCBmYWtlIGEgdGFnIHRvIHBhc3MgdGhlIHJldmll
dz8NCj4gPj4+Pg0KPiA+Pj4+IEkganVzdCBkb3VibGUgY2hlY2tlZCBteSByZXBsaWVzIGFuZCB0
aGlzIGZvciBzdXJlIG5ldmVyIGhhcHBlbmVkLg0KPiA+Pj4+DQo+ID4+Pj4gTkFLLCBkb24ndCBm
YWtlIHJldmlld3MuIFRoaXMgdmVyeSBpbXBvbGl0ZSBhbmQgZGVzdHJveXMgZW50aXJlIHRydXN0
Lg0KPiA+Pj4+IFRoZSBtb2RlbCBvZiB1cHN0cmVhbSBjb2xsYWJvcmF0aW9uIGRlcGVuZHMgb24g
dGhlIHRydXN0LCB3aGljaCBpcw0KPiA+Pj4+IG5vdyBnb25lIGZvciBXaW5kcml2ZXIuDQo+ID4+
Pj4NCj4gPj4+DQo+ID4+PiBObyEgSSBkb24ndCBmYWtlIGEgdGFnLg0KPiA+Pg0KPiA+PiBSZWFs
bHk/IFRoZW4gSSBhc2sgc2Vjb25kIHRpbWUgLSBmcm9tIHdoZXJlIGRpZCB5b3UgZ2V0IGl0PyBQ
cm92aWRlIGEgbGluay4NCj4gPj4NCj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAyMzA3MTgwMzA4NTEuMjAxNDMwNi0xLU1lbmcuTGlAd2luZHJpdmUNCj4gPiByLmNvbS9U
Lw0KPiANCj4gU28gd2hlcmUgaXMgaXQ/IFlvdSBwb2ludGVkIHRvIHlvdXIgZW1haWwuIFdoZXJl
IGlzIHRoZSB0YWc/DQo+IA0KDQpTb3JyeSEgTWF5YmUgSSBoYXZlIHdyb25nIHVuZGVyc3RhbmRp
bmcgYWJvdXQgVEFHLg0KRnJvbSBteSBwZXJzcGVjdGl2ZSwgSWYgcmV2aWV3ZXJzIGFzayBxdWVz
dGlvbiBvciBnaXZlIHNvbWUgYWR2aWNlcyB0byB0aGUgcGF0Y2gsIEkgbmVlZCB0byBhZGQgdGhl
IHRhZyB0byB2Mi4NCklmIGl0IGlzIG5vdCBhbGxvd2VkLCBJIGFwb2xvZ2l6ZSBmb3IgdGhhdC4N
Cg0KVGhhbmtzLA0KTGltZW5nDQoNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
