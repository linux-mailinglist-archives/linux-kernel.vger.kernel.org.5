Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9A75C267
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjGUJFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUJFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:05:45 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA3E74;
        Fri, 21 Jul 2023 02:05:43 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L8sVsA030501;
        Fri, 21 Jul 2023 02:05:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=901A/BVwpZTDRNEHfdSq5vDzqs9mNjdWJ6GCDmITbqM=; b=
        tEzDO6QGTCiahrUDLu/MNAN3Y6IJywLnsW9QCi/qGS6AFe7+aKY+GHFyRfqr6kLa
        SiR20WNeYiYB9WK2IFfT5rr1VR6RGN5dCx7+QuXXLhrxFZ/bzYGLCQEMSbfpzS0v
        NzpAiLC5LYMcCZ3BIsKSid8VzAzu8r5GubcpynEC2S5NP72hybddpFUmZBtb9i+N
        Z3ySoa+hgh4DuruL0IqKLwsLMq+2rauvqotd9p61hNJi2bpugSp1T7h5daE1XSzN
        gEfGBcTooVwzs2fh6IDEa0Xk8dEnn3oIqvfuH6RI07QaZmZEbcfw6y46Ga/jsnU2
        iXk68ryFNCjsivBtZueFug==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rupqydjs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmxAkNP099gd9tXx1hElhFttbo9pBt8LbPJwewbX8Zn6dt5r8KVEGwOBg3003U1yt+WRoMu9qj9oPPfcgaY+oobx1XSHQ/vswyvWtiL3udJ+CLoXJacg96uPbh9tdiMNncSuHGy9dibrOh/P1eyHU0VkKRfjMSi+jV6NI7ywgI9WUORD06zmc57jktTWT0uMKKK9TmUBWoUqjpbUz8C3Wk3NQl6QhRS3e6lpk2bcWeaKDO7/sFFu7FAWvyJ3x/grj/DycArPMZkfHoix4ZDYbaV0HeQXg23ZxRlOcoxO6SA0yLiwil52lK42RdhHxOaQ7HVMKB0UvSUjOfSsvRcEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=901A/BVwpZTDRNEHfdSq5vDzqs9mNjdWJ6GCDmITbqM=;
 b=kcyMA4zDEhXz130b4ikEn+mfJFfwZ5+4Surk0igqy2V8VLk+CIbpyFb2oTzOGgYpMZY61txbFXN7J9xHXCbiPnhOJR5wtejeXH8MY1e8ogIpAtdtjcZmUXjenv+53jhWjvXOI8AFkW2uqzyi1Zja9t5dVKb2rqmRNgfCTv3M9ftJcA7hOfNf06mBhPjZm1W2FM/R4yPJnDd5mK0ZY/gVqtx27W9ivMN96aGgEVO2RJ7otvriQM0bQPSkE2YLBXjjX/2+TDAXTpe28GhYpLcZ9UBkbDaq8bSW2yo+mftbPnb1M7skDP6I12SovJxa90lvf5/YP0cEbpRRMIFxaA5fEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 09:05:36 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 09:05:36 +0000
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
Thread-Index: AQHZu67AcgeVg8NpVU6sDsseuKM3QK/D6aGAgAAAxwCAAABzoA==
Date:   Fri, 21 Jul 2023 09:05:36 +0000
Message-ID: <PH0PR11MB5191F52F01EF337A5965F848F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20230721083821.1820881-1-Meng.Li@windriver.com>
 <b8333812-df9d-368a-939b-3495878a2e5e@linaro.org>
 <884ed5d5-8863-ac76-5f00-4ed58480e9ab@linaro.org>
In-Reply-To: <884ed5d5-8863-ac76-5f00-4ed58480e9ab@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|MW3PR11MB4588:EE_
x-ms-office365-filtering-correlation-id: dcf8c262-9824-4a67-88b5-08db89c9a5b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPXPHqrzrzbkzYefZoTR8aRwrt88wP0LWpnBLTQwlMoi/LJHUzL9y9XfjtPIC0pXBINSNRw2lvEIPiuOvy3zcSEDsBYZ6vnkynIsw7sofA9PuvJiP2ElrLsLaatHPpFuVFwgM0A+I2doOgPJ442OYg7H4p+UyC1aoOO8z9QKH1dIrHTjJ0MEdSSE4Xev6TgFE5sQSz/j9QAguv3t1/OMCWyYfecnF/N+E5Og3/dQczuzqKB/UMP2v1uvLt8RczVJWprKWCdI+6+8oKXtRVz2S94fnV81FPoHkg0dRbMGtBkOAG5Jkm81giZpwcg9bOLOqOfDQQAr7saWPlwfjavVJVdJyD/5unXbb+4HJYDNWeKRqQXTOidoeDYKV55m1N4hkyoYI1Dd3FHhCTIHPGJ9f8vmGPDZSmZkhkfEVMWyQ5MZOgZU0laIPcan+zKlu+w0pE0QFxNL6GEzgfs2hMG6IXlqsgsHALbjIpeWqp26BFKpbBtzRgoHu22v7y/t5WpmilEVV0S089SWR6Ky8HqsvS0Sq8vVRdhvHWHDYaWzcTUDQIxoASI6oaCQGYhOweSMXLcGdOmV0Nu7maD57pkhECOsxojiPmGUfgKuhGnxOC3kjSM+xWB0aDDCuP7X3MF/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39850400004)(376002)(136003)(346002)(451199021)(5660300002)(8936002)(52536014)(41300700001)(26005)(83380400001)(53546011)(8676002)(6506007)(186003)(122000001)(71200400001)(4326008)(66446008)(64756008)(316002)(76116006)(66476007)(66556008)(66946007)(55016003)(33656002)(86362001)(7696005)(38100700002)(9686003)(38070700005)(110136005)(478600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmhjM1pnL2FXK2dudFZpSFRITEVJamlNNGRwWjNDYnVFTUN5aVRRTkJRb0Zp?=
 =?utf-8?B?ZzlvNW9NMFpCUEh5elhGZy93V0pOOXJrRGhCUzlzMFNXY2FzallSaEVaL09r?=
 =?utf-8?B?NHB3TXVhREhJZHhNdFYrYmNmeXBEVFpzNk9DMEU2bUU4MGZ6SWZONkU2Mzlj?=
 =?utf-8?B?ejRDRHdibmlzcFdKbmFiK205d0dpRjRhcEFoZTBQb2pJNlh1UmpHNUxlM3I3?=
 =?utf-8?B?T3k4cFo3ZUFXNThjbEFueG9Pa3Y4ODNiR3NkbS9IZHh4UDVmMFJXNFdjVHJZ?=
 =?utf-8?B?SkpZS3BtYUFYTXEwN1FaOWVWa0k0eURvd2xEWFE2bm82Q1hSaUlFTEwwSjN6?=
 =?utf-8?B?aEduTXFzcXd4Y253UzQyQStDaUNwTGtlTytTemlUTVhETjdqVkF5NmhqMHVu?=
 =?utf-8?B?eHdETVBoTThrZDQ5Y0JYYkxERy95YXJJejZVRUFHSk9TOGdHQkNyT0RQbzFW?=
 =?utf-8?B?c3FYbCs2SFhFbVhhem8vZkJTanFEeVVHWWtMajdwSzAxN2tsc3ZneGhvVStS?=
 =?utf-8?B?RysxWmlMb0Rod0luKzhnUnZPMlQrTE1sWTU0U2puWnNBZ2xhSUY1Q08zKzdB?=
 =?utf-8?B?NHVka2VUTEd0aFc4bWViQ0p2KzFoOXpDMklHZzluUFlsRXJBQWIrYmVzN1dN?=
 =?utf-8?B?SXEyLzY4eSt3ZERhUmNIMlluam04VU9IblBlb1hicUdqSVlaTUM5T2F4MU1G?=
 =?utf-8?B?TFA3WlR4MFFRNzArNi91OG05ZVMwZVdEMjB4QkhkU241elB5WVU4Z1ppMk52?=
 =?utf-8?B?YjZ5Zk1HZ1NYZWJLN3FzUTFUWEZHYXAzYzRIQWVjZGxKRllzSTIwanE1K0E4?=
 =?utf-8?B?WCtMTVN5T284MHpndVBEandxRnBzNVE2WXdIRXJRbWRhSDcrZWRTME95d1d6?=
 =?utf-8?B?WVFNU1hzZDJ0cWhQREN2VVdYT3EvTkY5Yi9CRjZndkkvTVlVYWdCbVNHRDMz?=
 =?utf-8?B?UzNWcHppNlUvUTc2YTd5WXMyS2Zpb1hLMVp3WWt3L2JsYnh6blV2Y0U5a3lE?=
 =?utf-8?B?NlRidHIvdnBoZm9pQkE2MWZEUmRMOHRZS1VVVWZBN2RqL1cxdk1XVmpuZE40?=
 =?utf-8?B?RHRRWFlNN1J6Nkp3b3VyMDZ1K2pmS3Z2cVBuckNoSEttNmRxRndSU2dUN0JE?=
 =?utf-8?B?Yk5DaGFtemM4ZmpTNUw4VTJsdjNWUDlsdmx1K0psenNFeTBDampLM3FuS2Vv?=
 =?utf-8?B?dUIyZHk2cnBBVHZvektmNzN5L0FMdmprUlY0cGc1ZWZXc1R0bG1VVTVTTDdh?=
 =?utf-8?B?T1Rady82N241TFB0S05HUTVxdW9DeVRuTHdyYnl4WnlPZmNJOGdlVHl6ckVR?=
 =?utf-8?B?MGhEVGZzUjJkREZCanJhTjlMaW9naVdmcjRVc3NSdDF1Vm9nQml6QTY4OEoy?=
 =?utf-8?B?WUtjMW5YODZ5bXRtS3FBaWZxempLMUlQWTVjRXJ3UitQQ0pRdldzUksvTkFv?=
 =?utf-8?B?My9qL0VoMEt4ZlJYeHo4c1R5MW5mcUJIQzFPYlNBUXBKNGZmZGNETHNXSjVW?=
 =?utf-8?B?TmdabGtYVUhvRDh1Wm1Fa2NpWS96amtxUDFTTktHNGd2MWkzcUR1TU03eWFS?=
 =?utf-8?B?bjZmZmhNT2paa0xGYkdiOHJuSHhXMUQ0eGtDdTQyUitxS0NCYjlmVGx0WFZs?=
 =?utf-8?B?TEtGaWZtZlJaa3FTSkZob0hZbjAzdXRjT09sTDA2NzlVYWYySDA2bm15WW56?=
 =?utf-8?B?bTQyUUdEZGZNRHdIc0o3Z2swVFRDS0sxcXU2d243bUpTOVMyTnJBU1M0dVQy?=
 =?utf-8?B?QktiaDB1aDB6UmtwK3NCMmUzcjduM2pOSjg3SWNjZFR4cU9Td2tQNEtmLzQ0?=
 =?utf-8?B?dlpabjNrK2FXMjkrMXZjTDY0aCs3dGhVQmorVHYwWHN2azhjcHZkTUJKZ24w?=
 =?utf-8?B?SmpkRm9KbHBkL3ZyOHhPU1oyeW1mU3lvN2h5T0RNYktNNmRhS1pVYmF2ejIr?=
 =?utf-8?B?ODF1MXVSbUd4a2VLNHJyM0Q2SFMxOG1naUJPT2JHZk1OeEx6SjRTTUNyaUlu?=
 =?utf-8?B?N09MaFhSS3hkUm5qeWliOVovOXNpejA3T21hMW5LNmtBRDh6M1RoVWd6UFpm?=
 =?utf-8?B?blhBZXpxUzA3ci96WUJkYVR4aE9jOW9ySFRETHU4azRsT3dBRFZjWXRKZGxh?=
 =?utf-8?Q?smWjVWTm9JomvxAp5zghuIgJB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf8c262-9824-4a67-88b5-08db89c9a5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 09:05:36.3825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJpzJWqsi9Ue6b1lQYhcylJ+CoHCtZvqRC7U8+KsEIL/kr7mQurG2jGOZDBjljl0W8iP08pfw1gOdWLNAuWzAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-Proofpoint-GUID: XMgBuz5QNNTxANE0yE30yQ27Tcuo4MF9
X-Proofpoint-ORIG-GUID: XMgBuz5QNNTxANE0yE30yQ27Tcuo4MF9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_05,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307210081
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
bHkgMjEsIDIwMjMgNDo1NCBQTQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVyLmNv
bT47IGRpbmd1eWVuQGtlcm5lbC5vcmc7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW3YyIFBBVENIXSBhcm02NDogZHRzOiBzdHJhdGl4MTA6IGFkZCBuZXcg
Y29tcGF0aWJsZSBmb3IgSW50ZWwNCj4gU29DRlBHQSBTdHJhdGl4MTAgcGxhdGZvcm0NCj4gDQo+
IENBVVRJT046IFRoaXMgZW1haWwgY29tZXMgZnJvbSBhIG5vbiBXaW5kIFJpdmVyIGVtYWlsIGFj
Y291bnQhDQo+IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kDQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4gDQo+IE9uIDIxLzA3LzIwMjMgMTA6NTEsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+
ID4gT24gMjEvMDcvMjAyMyAxMDozOCwgTWVuZyBMaSB3cm90ZToNCj4gPj4gSW50ZWwgU3RyYXRp
eDEwIGlzIHZlcnkgdGhlIHNhbWUgd2l0aCBBZ2lsZXggcGxhdGZvcm0sIHRoZSBEV0MyIElQIG9u
DQo+ID4+IHRoZSBTdHJhdGl4IHBsYXRmb3JtIGFsc28gZG9lcyBub3Qgc3VwcG9ydCBjbG9jay1n
YXRpbmcuIFRoZSBjb21taXQNCj4gPj4gM2Q4ZDM1MDRkMjMzKCJ1c2I6IGR3YzI6IEFkZCBwbGF0
Zm9ybSBzcGVjaWZpYyBkYXRhIGZvciBJbnRlbCdzDQo+ID4+IEFnaWxleCIpIGhhZCBmaXhlZCB0
aGlzIGlzc3VlLiBTbywgYWRkIHRoZSBlc3NlbnRpYWwgY29tcGF0aWJsZSB0bw0KPiA+PiBhbHNv
IHVzZSB0aGUgc3BlY2lmaWMgZGF0YSBvbiBTdHJhdGl4MTAgcGxhdGZvcm0uDQo+ID4+DQo+ID4+
IEFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFy
by5vcmc+DQo+ID4NCj4gPiBGcm9tIHdoZXJlIGRpZCB5b3UgZ2V0IGl0Pw0KPiA+DQo+ID4gRGlk
IHlvdSBqdXN0IGZha2UgYSB0YWcgdG8gcGFzcyB0aGUgcmV2aWV3Pw0KPiANCj4gSSBqdXN0IGRv
dWJsZSBjaGVja2VkIG15IHJlcGxpZXMgYW5kIHRoaXMgZm9yIHN1cmUgbmV2ZXIgaGFwcGVuZWQu
DQo+IA0KPiBOQUssIGRvbid0IGZha2UgcmV2aWV3cy4gVGhpcyB2ZXJ5IGltcG9saXRlIGFuZCBk
ZXN0cm95cyBlbnRpcmUgdHJ1c3QuDQo+IFRoZSBtb2RlbCBvZiB1cHN0cmVhbSBjb2xsYWJvcmF0
aW9uIGRlcGVuZHMgb24gdGhlIHRydXN0LCB3aGljaCBpcyBub3cgZ29uZQ0KPiBmb3IgV2luZHJp
dmVyLg0KPiANCg0KTm8hIEkgZG9uJ3QgZmFrZSBhIHRhZy4gDQpJbiB0aGUgdjEgdmVyc2lvbiwg
dGhlIHN1YmplY3QgaXMgIiB1c2I6IGR3YzI6IGFkZCBuZXcgY29tcGF0aWJsZSBmb3IgSW50ZWwg
U29DRlBHQSBTdHJhdGl4MTAgcGxhdGZvcm0iDQpCdXQgaXQgaXMgbm90IHJlYXNvbmFibGUsIGJl
Y2F1c2UgdGhlIHBhdGNoIGlzIGZvciBkdHMgZmlsZS4gU28gSSBjaGFuZ2VkIHRoZSBzdWJqZWN0
IHRvICJhcm02NDogZHRzOiBzdHJhdGl4MTA6ICINCkFuZCBhZGQgU29DIHNwZWNpYWwgY29tcGF0
aWJsZS4NCg0KVGhhbmtzLA0KTGltZW5nDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg0K
