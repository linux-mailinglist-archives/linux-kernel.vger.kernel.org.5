Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6707766E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjHISDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjHISC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:02:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D28171D;
        Wed,  9 Aug 2023 11:02:57 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379H7xR5014771;
        Wed, 9 Aug 2023 13:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=n7Y3aPxjVbza/MQSONsOgoKKfwkmc9jxsL39Rvjha
        k4=; b=NP01Q3Q8Ueq5WqqBfqY83ZmDqScjNLxuJW/jx4f0Wx2vWESTLt1N7Av2F
        td8JqYIy1zMkjl+BoTI0U92LAGH/6G5Bekifhb0maoHQHa7X1vubuY++HML0Xo8Z
        97qVrjOKWE5/9i11q01PENLw/Cobw8s/Cz6N06C0/ZWoIfysqRForMPtboya7VcW
        S1k5XxdFfCcG2ZSg++FTua7d8PY3iPRha/VU0IV6KYBLKLtSs5rHSPuAfoQlNnx3
        UPH11Q1KP6eU/P4aD5M1H1b7a2sizrGriD2ZKdpxS+W24LGC5PBWD6A1HlApR1fL
        DOITQktnNlscWwM1pWkAdR63axXaA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhv124-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 13:02:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+1LgzfzlqfH4tGfnY61mQNAFqI6dl6qtDW9xRc7AvIloDLreV5C+0vg+1oYqTpS2OPpI55F62b8D4eF5oRdZdP97hN0Ze9BEE9hmlhIzz+YCvpMlYdnv3mK8KwV4o+lF8a3+8XUyYnDvKbzDFVAhlBKV9g1C1mCsZ/U1nU47uB2eO/lwkew8Jo3oj++28owTsppCqWw0rd8GSCbgFdOF0VsN2q90gUAlKxItvsxdnB6GggZC6U3t2Rbc/h3SO7FWP2ozij7r5EDS7EtVGnMMqspGDyZY8AlhHKaAiBgtOnWtA0I15smQVEEOyGxu9/rMwAV0SbAgOKLjzvQXk0Jew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7Y3aPxjVbza/MQSONsOgoKKfwkmc9jxsL39Rvjhak4=;
 b=DbV7RSq4x55oqD6x2YzdJqCBjntptOU6T/h1Awdr/+6DIALcHCvkfdo0wxofI9yr82hukBTLWK2ub3DMNqy4weAZxCBeglnaYkmr1YWd339tD8OKqXDtav3zOOC49Trz9ToMKaj1W8m6QSwRrTeL+NuXdYuJ50Cic0JGu0MTVPYZJHPV+/bSMgga3igkOjSNtLm9sBG08OLsbM45sllwi4XWV7teNSaxZcVkvOBJJdsFtj7iARMt0hY1pn6dUspaNhMfOzDnFdrAiNSJReTMgALNgBEhzWntstztrdtcxg9EYs09DnG22q0RiQPHkFRsRofBMrF3xXVx2c13c+Ry5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7Y3aPxjVbza/MQSONsOgoKKfwkmc9jxsL39Rvjhak4=;
 b=xlw/jeFKmXBZyzWaND72tERwf44zZ/MJC2x2qn1EyR0Ny/NVyY1fk8o2Rz8xx0BrJjMvPs7AmflgIZptnmDGJvTDUweS4kaKWmf6nnna9SM0Vb7UJPOr2fZbClKnDG7e8gs4quLRiOgWbnO4rqawsa0aKtCrCFFeGkBL9fcBwE4=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by MN0PR19MB6432.namprd19.prod.outlook.com (2603:10b6:208:3d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 18:02:22 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 18:02:22 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Jean Delvare <jdelvare@suse.de>,
        Jeff LaBundy <jeff@labundy.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eddie James <eajames@linux.ibm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Jerome Neanne <jneanne@baylibre.com>,
        "patches@cirrus.com" <patches@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Thread-Topic: [PATCH 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Thread-Index: AQHZyh7OBljw2/gB2Ee1hzhfi1Ulg6/hhmeAgAC8mIA=
Date:   Wed, 9 Aug 2023 18:02:21 +0000
Message-ID: <ADCCD2C5-B79B-4C50-B3CE-007B1FBF5A5E@cirrus.com>
References: <20230808172511.665787-1-james.ogletree@cirrus.com>
 <20230808172511.665787-2-james.ogletree@cirrus.com>
 <065fbe51-928c-4728-efc2-bde87cd48cb3@linaro.org>
In-Reply-To: <065fbe51-928c-4728-efc2-bde87cd48cb3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|MN0PR19MB6432:EE_
x-ms-office365-filtering-correlation-id: be83eb8c-d041-4d2a-c8fb-08db9902c78b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4b7sIPM+AgMONiymtGBfU7NNiDsL0PT+yDuimjsEsU8lYds4adrqob3DcmnRIsuAZ8whsGQNE2mIjoDr8F54nakx6IybvarK6YICn6Y5O5NMumunUOCNSJEiQOOzs3M4HjGbWzJItj7v2BFHuTZsCxWQuaw5A8+lTk+/oGcFQc8rknkVeaMJzwQS3AQKO+ZGDPgLJKUbc6omO9iLdkZ+S5LR8uDxr79glEEmK7oBd6hIfQPxdQ37TE1cc2mhriOGkG9IKLm6R3S/Y93947ovlGOP3c0aJHfb2T4gY+Ci9QMWP+YLeiucykVLi6HXtZTomGNqfIDCAJN8Nj7sHvQRP8Bnw0PqGRXuGKlzv1byZiM+fXa3fSripn4jy7A3JeVhoh5gIMdZC2hW0ap99q3BjsN0Tszu58jhSg7EMrIPRbpzHms4gAhKynfE1ns5CDP/jgwe7xgyMY44A9/unsx2k72UsLcCV1GsTOUt+w7lw1xjM+FkK/UwwXSf7AhKrJ943bPa/8gxye6jMLiDBG7zWlCX/2tpd+xv21Lx7GsghrcJ7NxUr5bNpuWc3W/PF2RhnzyY2I9LS1sSO1UfhwnzhunR3r1qJMitk6BEf36120SdcJYpkJqqTq66eWoWzwWJcXLJcYunpW9vw9ij16nFCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39850400004)(346002)(366004)(1800799006)(186006)(451199021)(86362001)(7416002)(5660300002)(2906002)(38070700005)(33656002)(41300700001)(8676002)(66476007)(8936002)(66556008)(64756008)(316002)(54906003)(83380400001)(38100700002)(36756003)(2616005)(66446008)(4326008)(122000001)(478600001)(6916009)(66946007)(53546011)(71200400001)(6506007)(26005)(76116006)(91956017)(6486002)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU5wYVVWQ25yNENtVlhrbmRHSjJwaDBKUzJvcXJ1WmNJOXYxcmRBUnNYWWJ0?=
 =?utf-8?B?UksrdExsZFVMdG1zZ2o5bkxqemZURENCT2dRdFY1aWV3eE1KRlRxTHZaVE95?=
 =?utf-8?B?SjhzMWF5K2FJdTZaS3VLeitXSDkxZnY3aU9qelg5Y1dOU2xLTk9FREwwZWxv?=
 =?utf-8?B?RGVVQytMVEFrTFNXSXhyci9vQmFDdVVqaHhWZWZST1FSK2kvbE5wS29sdkg1?=
 =?utf-8?B?OTN1dWg5NnI2UHd2b2g1ZjNBQXZXWmJTWm9rQU02ajdzd25RcnNabkp3bVlP?=
 =?utf-8?B?NXBMQUlxalFzdk9CeHFpOExFcGMzM1Z5TFREMTFMQlY5cW5DejV6Qmdkb0h5?=
 =?utf-8?B?WHZIS2xXTVZXYVNXNFh6dFFScVhYZ2lMeUJRL3MrLzFPV3I4UmJUeWRqSlZY?=
 =?utf-8?B?VnNqOUhweFZJSitVWVp2SHBWeEowNm5Lcnp0eHFJWWhwR0c2ZUp6a1NISDc2?=
 =?utf-8?B?SnBXQjNxeGJQUzFPNC9pYXZTUTdFUUcrUjFvRlB4UmxMb1lJTHVLRklMNkQw?=
 =?utf-8?B?WGtzMjF3SXJ5QmZoOEExd3c2TTFJbzJNcFZSSjk0VTI2U05rWjJSMjJrYTN4?=
 =?utf-8?B?bjFCdTRaTXFSbExqWmRhNGFwUlc1em4zTVljbnlSNHhaeHQrOFRGMGJJb1pq?=
 =?utf-8?B?Vlp4R1VDR0hyVWRLMm5kQmp6K1U2UEV2UWxiTXZXWkpPbFFaOHdyc0lHSytJ?=
 =?utf-8?B?NmsyWlhPcEUzSi9FUDNZd3YyK3B5VUpJNmN1UkQvMWRTTHhxSVNYN3ErdFlT?=
 =?utf-8?B?SFFJMjFEVHViNENwWE1VM0gvenhmUTlHUll3WHpHdmtkZUoveUlyOHNDTk8r?=
 =?utf-8?B?dmNGQzFDODB4NnBoWSt6bzlpOWV3NDRvRzJ5M1B3YTRtOU9OQjh0eVppcExM?=
 =?utf-8?B?QnI5RDZIa2tYQnVscWppNFhjZll2Slgwc1pQL1R5dk9DWnl3SEU2ZU9rb2gv?=
 =?utf-8?B?alVjSXQ2Vlp1NndSN0ZGblJ6SFY3MnRjbFplUmZEMU9nUUIrbWN4N3E1b1VH?=
 =?utf-8?B?akRNWGs0Z0NDOXhpNlVzZG5oZkRVY1dUT0xIS1dlZC9iRGhZM2dwcUhCTFBm?=
 =?utf-8?B?NTZWNUg1WnFGR2xLYnYxbHgrMFpGdHB6cHBuNlMxc1o5c0h3OFhpZlZ2azAw?=
 =?utf-8?B?WjY2SjBnZHZWL3VUcUhOaDFCZGhFOGkrL0c4WDJhQnhvT0FtaDFwVWh3Q1BV?=
 =?utf-8?B?K0pUcXozZzUwWFV2THpueC8vQTZhS0ZId1dBMEY1S2huejdIdHVIL0t4MjQv?=
 =?utf-8?B?SzFZejBid2JzcUlUMUlFSm9jYWhIcUtlUWJOYXJCaGk0L216SGNXS0lXcHNJ?=
 =?utf-8?B?cW5GNmpraFFIcGpWRm5rR0l1VFdYYWtGZmdBMDdmK203OG01Y0VydXI0R2ZQ?=
 =?utf-8?B?MzV2aFF6NEhXMDFGcXZKVHp3MFVVRzZyS3E5dkJSbzlseDhhUzdpY3VWbUhO?=
 =?utf-8?B?ckNRNXM0c2laSUNkRzlMaUtBRklHUEUxRjZTRmdqdkRJaWtxQlltZ3dvV0Ro?=
 =?utf-8?B?MjdEaFQ4UHdJYXMraXNwc3dDdytUV1IveHkrNklWRFFqeUhNRFNvc0J3RmVx?=
 =?utf-8?B?c0srR2tSWWRRODNnNFhpcWROQlFIVmdEZXRyRmtMVlFGZkFWRWdEM1V3dmk3?=
 =?utf-8?B?ZmU3N2xqL0o5MlEwZ25mTFBnNHVLN2VYMkdOb2t1TVZJbi9VRnltUHlBL3hX?=
 =?utf-8?B?MFBlM2wvc2w0RlZBcFVNYm1sT1FweE9jSXl2ZG9QdWt6QjJqTTErRkJmVWZL?=
 =?utf-8?B?NXdHdDlhMEtMczh1cldXSmdrTThNOEszU0FVdFRJYnRHN0I4cHlWMDJUMGQ3?=
 =?utf-8?B?eWQwZ3lRTzdCVUhzdUFsTGdrRlNLWHVVQXZjajNhZDkxUjM3eDdWRjgrR0RY?=
 =?utf-8?B?aWtLOUJxOEJ0M3M5cTZxVjIyZy9oWFdIek5VT1hFYldBMXFVbzVaQk1NemRX?=
 =?utf-8?B?Y2hmdEJWTmowenE1cTcxdEpnNmJDOXlNM3ZobDEyRE1PdnQvMUtINFByaEp3?=
 =?utf-8?B?RG1OVTFnbjNway9CbzJEaDZiei8vaWpDUDJKL2JPZkhBd3Q4bHFpMUNxZHVw?=
 =?utf-8?B?U04wSG9wYlpMd3JCbXA0M2xBVDV4TUJ0Q25EZStTUXVDeEZIejhRYjh3azRa?=
 =?utf-8?B?WUErekw3MGdGeCt0ZGxqWGxnVzEySXhhRmZBZm9WVHNhQ25IeGZINUZVaGtZ?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E54D707F385DDA428438F8656C6B9C68@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be83eb8c-d041-4d2a-c8fb-08db9902c78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 18:02:21.9384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zw4R0ksGiujes//suExVYwC2LOMfp+1MsrdMkQ/tZ1w/H62nktkXuWQaMo2QBoX0YL4tlvHF69Mfu8FVVEvgtzJvuekNFnzjqhl54d7L5ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6432
X-Proofpoint-GUID: 5qTaDB_px8rcTip3W7Aet88UuQLT0z7w
X-Proofpoint-ORIG-GUID: 5qTaDB_px8rcTip3W7Aet88UuQLT0z7w
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDksIDIwMjMsIGF0IDE6NDcgQU0sIEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiAwOC8wOC8yMDIz
IDE5OjI1LCBKYW1lcyBPZ2xldHJlZSB3cm90ZToNCj4gDQo+PiArIGdvdG8gZXJyOw0KPj4gKyB9
DQo+PiArDQo+PiArIGNzNDBsNTAtPnJlc2V0X2dwaW8gPSBkZXZtX2dwaW9kX2dldF9vcHRpb25h
bChjczQwbDUwLT5kZXYsICJyZXNldCIsIEdQSU9EX09VVF9ISUdIKTsNCj4+ICsgaWYgKElTX0VS
UihjczQwbDUwLT5yZXNldF9ncGlvKSkgew0KPj4gKyBlcnJvciA9IFBUUl9FUlIoY3M0MGw1MC0+
cmVzZXRfZ3Bpbyk7DQo+PiArIGdvdG8gZXJyOw0KPj4gKyB9DQo+PiArDQo+PiArIHVzbGVlcF9y
YW5nZShDUzQwTDUwX01JTl9SRVNFVF9QVUxTRV9XSURUSF9VUywgQ1M0MEw1MF9NSU5fUkVTRVRf
UFVMU0VfV0lEVEhfVVMgKyAxMDApOw0KPj4gKw0KPj4gKyBncGlvZF9zZXRfdmFsdWVfY2Fuc2xl
ZXAoY3M0MGw1MC0+cmVzZXRfZ3BpbywgMCk7DQo+PiArDQo+PiArIHVzbGVlcF9yYW5nZShDUzQw
TDUwX0NQX1JFQURZX0RFTEFZX1VTLCBDUzQwTDUwX0NQX1JFQURZX0RFTEFZX1VTICsgMTAwMCk7
DQo+PiArDQo+PiArIGZvciAoaSA9IDA7IGkgPCBDUzQwTDUwX0RTUF9USU1FT1VUX0NPVU5UOyBp
KyspIHsNCj4+ICsgZXJyb3IgPSBjczQwbDUwX2RzcF9yZWFkKGNzNDBsNTAsIENTNDBMNTBfRFNQ
MV9IQUxPX1NUQVRFLCAmdmFsKTsNCj4+ICsgaWYgKCFlcnJvciAmJiB2YWwgPCAweEZGRkYgJiYg
dmFsID49IENTNDBMNTBfSEFMT19TVEFURV9CT09UX0RPTkUpDQo+PiArIGJyZWFrOw0KPj4gKw0K
Pj4gKyB1c2xlZXBfcmFuZ2UoQ1M0MEw1MF9EU1BfUE9MTF9VUywgQ1M0MEw1MF9EU1BfUE9MTF9V
UyArIDEwMCk7DQo+PiArIH0NCj4+ICsNCj4+ICsgaWYgKGkgPT0gQ1M0MEw1MF9EU1BfVElNRU9V
VF9DT1VOVCkgew0KPj4gKyBkZXZfZXJyKGNzNDBsNTAtPmRldiwgIkZpcm13YXJlIGJvb3QgZmFp
bGVkOiAlZCwgaGFsbyBzdGF0ZSA9ICUjeFxuIiwgZXJyb3IsIHZhbCk7DQo+PiArIGdvdG8gZXJy
Ow0KPj4gKyB9DQo+PiArDQo+PiArIGNzNDBsNTAtPnZpYmVfd29ya3F1ZXVlID0gYWxsb2Nfb3Jk
ZXJlZF93b3JrcXVldWUoImNzNDBsNTBfd29ya3F1ZXVlIiwgV1FfSElHSFBSSSk7DQo+PiArIGlm
ICghY3M0MGw1MC0+dmliZV93b3JrcXVldWUpIHsNCj4+ICsgZXJyb3IgPSAtRU5PTUVNOw0KPj4g
KyBnb3RvIGVycjsNCj4+ICsgfQ0KPj4gKw0KPj4gKyBJTklUX1dPUksoJmNzNDBsNTAtPnZpYmVf
c3RhcnRfd29yaywgY3M0MGw1MF92aWJlX3N0YXJ0X3dvcmtlcik7DQo+PiArIElOSVRfV09SSygm
Y3M0MGw1MC0+dmliZV9zdG9wX3dvcmssIGNzNDBsNTBfdmliZV9zdG9wX3dvcmtlcik7DQo+PiAr
DQo+PiArIGVycm9yID0gY3M0MGw1MF9jc19kc3BfaW5pdChjczQwbDUwKTsNCj4+ICsgaWYgKGVy
cm9yKQ0KPj4gKyBnb3RvIGVycjsNCj4+ICsNCj4+ICsgZXJyb3IgPSBjczQwbDUwX2lucHV0X2lu
aXQoY3M0MGw1MCk7DQo+PiArIGlmIChlcnJvcikNCj4+ICsgZ290byBlcnI7DQo+PiArDQo+PiAr
IGVycm9yID0gY3M0MGw1MF9wYXRjaF9maXJtd2FyZShjczQwbDUwKTsNCj4+ICsgaWYgKGVycm9y
KQ0KPj4gKyBnb3RvIGVycjsNCj4+ICsNCj4+ICsgZXJyb3IgPSBjczQwbDUwX3BzZXFfaW5pdChj
czQwbDUwKTsNCj4+ICsgaWYgKGVycm9yKQ0KPj4gKyBnb3RvIGVycjsNCj4+ICsNCj4+ICsgZXJy
b3IgPSBjczQwbDUwX2NvbmZpZ19ic3QoY3M0MGw1MCk7DQo+PiArIGlmIChlcnJvcikNCj4+ICsg
Z290byBlcnI7DQo+PiArDQo+PiArIGVycm9yID0gZGV2bV9yZWdtYXBfYWRkX2lycV9jaGlwKGNz
NDBsNTAtPmRldiwgY3M0MGw1MC0+cmVnbWFwLCBjczQwbDUwLT5pcnEsDQo+PiArIElSUUZfT05F
U0hPVCB8IElSUUZfU0hBUkVEIHwgSVJRRl9UUklHR0VSX0xPVywgMCwgJmNzNDBsNTBfcmVnbWFw
X2lycV9jaGlwLA0KPj4gKyAmY3M0MGw1MC0+aXJxX2RhdGEpOw0KPj4gKyBpZiAoZXJyb3IpIHsN
Cj4+ICsgZGV2X2VycihjczQwbDUwLT5kZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgSVJRIGNoaXA6
ICVkXG4iLCBlcnJvcik7DQo+PiArIGdvdG8gZXJyOw0KPj4gKyB9DQo+PiArDQo+PiArIGZvciAo
aSA9IDA7IGkgPCBBUlJBWV9TSVpFKGNzNDBsNTBfaXJxcyk7IGkrKykgew0KPj4gKyBpcnEgPSBy
ZWdtYXBfaXJxX2dldF92aXJxKGNzNDBsNTAtPmlycV9kYXRhLCBjczQwbDUwX2lycXNbaV0uaXJx
KTsNCj4+ICsgaWYgKGlycSA8IDApIHsNCj4+ICsgZGV2X2VycihjczQwbDUwLT5kZXYsICJGYWls
ZWQgdG8gZ2V0ICVzXG4iLCBjczQwbDUwX2lycXNbaV0ubmFtZSk7DQo+PiArIGVycm9yID0gaXJx
Ow0KPj4gKyBnb3RvIGVycjsNCj4+ICsgfQ0KPj4gKw0KPj4gKyBlcnJvciA9IGRldm1fcmVxdWVz
dF90aHJlYWRlZF9pcnEoY3M0MGw1MC0+ZGV2LCBpcnEsIE5VTEwsIGNzNDBsNTBfaXJxc1tpXS5o
YW5kbGVyLA0KPj4gKyBJUlFGX09ORVNIT1QgfCBJUlFGX1NIQVJFRCB8IElSUUZfVFJJR0dFUl9M
T1csDQo+PiArIGNzNDBsNTBfaXJxc1tpXS5uYW1lLCBjczQwbDUwKTsNCj4+ICsgaWYgKGVycm9y
KSB7DQo+PiArIGRldl9lcnIoY3M0MGw1MC0+ZGV2LCAiRmFpbGVkIHRvIHJlcXVlc3QgSVJRICVz
OiAlZFxuIiwNCj4+ICsgY3M0MGw1MF9pcnFzW2ldLm5hbWUsIGVycm9yKTsNCj4+ICsgZ290byBl
cnI7DQo+PiArIH0NCj4+ICsgfQ0KPj4gKw0KPj4gKyByZXR1cm4gMDsNCj4+ICsNCj4+ICtlcnI6
DQo+PiArIGNzNDBsNTBfcmVtb3ZlKGNzNDBsNTApOw0KPj4gKw0KPj4gKyByZXR1cm4gZXJyb3I7
DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKGNzNDBsNTBfcHJvYmUpOw0KPj4gKw0KPj4g
K2ludCBjczQwbDUwX3JlbW92ZShzdHJ1Y3QgY3M0MGw1MF9wcml2YXRlICpjczQwbDUwKQ0KPj4g
K3sNCj4+ICsgZGlzYWJsZV9pcnEoY3M0MGw1MC0+aXJxKTsNCj4+ICsNCj4+ICsgaWYgKGNzNDBs
NTAtPmRzcC5ib290ZWQpDQo+PiArIGNzX2RzcF9wb3dlcl9kb3duKCZjczQwbDUwLT5kc3ApOw0K
Pj4gKyBpZiAoJmNzNDBsNTAtPmRzcCkNCj4+ICsgY3NfZHNwX3JlbW92ZSgmY3M0MGw1MC0+ZHNw
KTsNCj4+ICsNCj4+ICsgaWYgKGNzNDBsNTAtPnZpYmVfd29ya3F1ZXVlKSB7DQo+PiArIGZsdXNo
X3dvcmtxdWV1ZShjczQwbDUwLT52aWJlX3dvcmtxdWV1ZSk7DQo+PiArIGRlc3Ryb3lfd29ya3F1
ZXVlKGNzNDBsNTAtPnZpYmVfd29ya3F1ZXVlKTsNCj4+ICsgfQ0KPj4gKw0KPj4gKyBncGlvZF9z
ZXRfdmFsdWVfY2Fuc2xlZXAoY3M0MGw1MC0+cmVzZXRfZ3BpbywgMSk7DQo+PiArIHJlZ3VsYXRv
cl9idWxrX2Rpc2FibGUoQVJSQVlfU0laRShjczQwbDUwX3N1cHBsaWVzKSwgY3M0MGw1MF9zdXBw
bGllcyk7DQo+PiArDQo+PiArIHJldHVybiAwOw0KPj4gK30NCj4+ICtFWFBPUlRfU1lNQk9MX0dQ
TChjczQwbDUwX3JlbW92ZSk7DQo+PiArDQo+PiArTU9EVUxFX0RFU0NSSVBUSU9OKCJDUzQwTDUw
IEFkdmFuY2VkIEhhcHRpYyBEcml2ZXIiKTsNCj4+ICtNT0RVTEVfQVVUSE9SKCJKYW1lcyBPZ2xl
dHJlZSwgQ2lycnVzIExvZ2ljIEluYy4gPGphbWVzLm9nbGV0cmVlQGNpcnJ1cy5jb20+Iik7DQo+
PiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIGlzIGEg
bW9kdWxlLg0KDQpJdCBjYW4gYmUgY29tcGlsZWQgYXMgYSBtb2R1bGUgd2l0aCBDT05GSUdfSU5Q
VVRfQ1M0MEw1MD1tLiBIb3dldmVyLCB0aGVyZSBpcyBhDQp0eXBvIGluIHRoZSBLY29uZmlnIGVu
dHJ5IGRlc2NyaXB0aW9uOiB0aGUgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIOKAnGNzNDBsNTDigJ0g
bm90IOKAnGNzNDBsNTAtY29yZeKAnS4NClRoYXQgd2lsbCBiZSBmaXhlZC4gDQoNCkJlc3QsDQoN
CkphbWVzDQoNCg0K
