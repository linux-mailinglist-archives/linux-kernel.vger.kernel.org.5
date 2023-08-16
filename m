Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFD677EB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbjHPVDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346343AbjHPVDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:03:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC0E69;
        Wed, 16 Aug 2023 14:03:18 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G7TCmF026638;
        Wed, 16 Aug 2023 16:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=pwsGgYmQSxNZvOBuLqHKzu6DdsS5BLTSYTymmgJ1v
        ro=; b=m9mUiNz2xzqYw0RNoITbtUqQf5Us/U7KmQ9VNKB8K+mzUA09mCkSzucrQ
        nRoY5j1Y5adJLtKsOL75S4dlbTqWaTn8JLHlMzvR+m0M1nGZ6vMAGPTrM6Zp+Rc4
        jdTJWpsiHWwFS9HK6UEa/gE699lcJcX30BDSqlxmuHwlMvM8kF6oFzhrIFcrqnrw
        ps9f7rndUmSmO7tIJFd6PlNql2VPviLHLNIdArhnZWP5DmlixIQ+c8Knk1COwV5g
        MCah+DZrEitEsiRKV6HoV8c3zYsMGoCh6pW7OSI+WR4zuDmRKJXyniEQ7wbK9SkK
        TLumO79oRu/8pD9daPlyjsWknixeQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqwj8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 16:02:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X05dyEaanzC01jTcPhBJ1MFqsUOtG+Rs4Mksg5P8wIFGztblCxMeuJV1+mDZ1CD4rw/2qM1djHpoQ1TdqW8jWHK5S0wFWFSxYa3Tni1ybsGNXxzw7LF8qEwFYzakNkH8hd1LtBpEumoRykDjmhodZhT8T/NDYtXUKwjqVdPMuXvBbIjcdtkhI/S7NEui4wzgqEec9jkUuBqcdH1x/aWQDTadFfXoEiXTUDWxAoIo+JEhhSyevv267A2d1X4TNCOcoY3WgrDtWJ0/hx+6VkDptBx++pCjLc+kZyrPtd4C7BI7b6kYm1chKCC6B11cxJ1MBHbR+6lTrGc37ydmntyOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwsGgYmQSxNZvOBuLqHKzu6DdsS5BLTSYTymmgJ1vro=;
 b=C6nG2cEztf228LIPyYPqrnHcL6ln3kL7q6mFlFc+Qnrmod1Db+QDCJ7sEUJXvXvInwat6kC2H6AgZ+3Osp7nSel1bJh94SGGt+WE1ogKsb52JZgWKGeavTIxjFY2sMklGDOJ9msRiNnc46sCfp8gOinD4tHrAmkbC4I78EiX7W2CBmU5Y8oYml1hnpX9tcGd0nz61kYKr2jtzuf3+RG9DEKtd0IMK6LNJIOjBGojRo6J2Yo6SCIHZgw44769SFgO06k1uG+rC2kYB82FUq5u5sbWewwvKRiX3p8Nvd7cE2G0n6oXCpdxTAVpQYuz6xQcjWPHc2TNAa87MGmxQd6sTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwsGgYmQSxNZvOBuLqHKzu6DdsS5BLTSYTymmgJ1vro=;
 b=s7vaId9nAAbszHpXLfgu5qWk7Lu4lbGVGdZQRCRcGq6zzGfxS8y8KPnd3Ok8ZQ3MO/MNKWYNsN+mF/QTc0TWG70Oqtv3yCeP5RARciyJjjCTGtm1XRLl8BViImaaJFSvYW14yPhtZs2LlRBHl2ldAFqFRfMi+ezI+4CQa3tIL7o=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by DM6PR19MB3786.namprd19.prod.outlook.com (2603:10b6:5:1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Wed, 16 Aug 2023 21:02:27 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8%6]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 21:02:26 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Jacky Bai <ping.bai@nxp.com>, Jean Delvare <jdelvare@suse.de>,
        Eddie James <eajames@linux.ibm.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Thread-Topic: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Thread-Index: AQHZyvU2Ki66M1P/ZUe1/Vm0xGH7Cq/kfKwAgAj3SAA=
Date:   Wed, 16 Aug 2023 21:02:26 +0000
Message-ID: <7C3D1F80-556D-463E-85AD-AFA48CADAF5E@cirrus.com>
References: <20230809191032.820271-1-james.ogletree@cirrus.com>
 <20230809191032.820271-3-james.ogletree@cirrus.com>
 <ZNWz7F7qLeNKDlG/@nixie71>
In-Reply-To: <ZNWz7F7qLeNKDlG/@nixie71>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|DM6PR19MB3786:EE_
x-ms-office365-filtering-correlation-id: df54d18d-c1f1-4a9b-5f77-08db9e9c189a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XaSeFaydBnhZJ+cgFwJnV9oGdV++Okih39uEgu+qVjFSkxQOsFpxVklKMhwGlXzsmXtmyBN/EHjvn2+UvH8z2kAECjnxDhMKZWusu8g9N6VK6corQycKeLn6VOCs56qDIGmox1px7IFPkyTpHoC05JmEWQ0nKSoCSU+qZIZPvSBpbdOIYEcdwpinWY7mPR+kz6qfcJcY38X9kDpGHwbQyFEMFRUZqhQUNLWviTJ9Z1VK+D3+CSI4XEyIVB+rCKNBoj+pAgIO/06fErbef+QEFSL+3ZPSOgDcORQ4Ki90IATRTip3jEUromySHdN9hMQhm6b5Q6PNjshraXMw9B9SFVADBLV/cHK4Vr1KgBkh+erEHliKRNgMMbfUfFKy2Jif+X+zhz3yh86HpktjRRtAs0pPusC8S9jMxDKMTil6vw4hiJN6KiyC8Z/PnE28xUCzUWTjjlQk2s1eTChRPRWuwnFcM3UkQIu/3pfv450EXZsse+PCHpBhoMhU3YjnLBxZ/juNnEsEadrwD29yZTWh7LTn/MkOQJ+9/5R0GINquH/G01dcCa2jTaxaKlwvB2rsGgBOjhp38+uSquLdt9V2gosgiDdh/KKAJzMeQ7AimFRZDkLnxxt4Hcd8TQngyHUAiTdHPX9IT/GDWKKQwuJhVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(396003)(136003)(346002)(451199024)(1800799009)(186009)(316002)(54906003)(6916009)(76116006)(66946007)(91956017)(66556008)(66476007)(64756008)(66446008)(122000001)(5660300002)(41300700001)(38100700002)(38070700005)(8676002)(4326008)(8936002)(66899024)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(53546011)(6512007)(33656002)(36756003)(6506007)(71200400001)(6486002)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVlmV3lFWUV6VHoxNkovbkwxWWFHUFZMV2YzcWhDWHNHUlN5bzJNZFA5MkU4?=
 =?utf-8?B?YUJEYmtuTWVyYm9wY0RuTjhabElmc1RpM1VpQTRna1czaXg4TmkwS2hGdnVU?=
 =?utf-8?B?UEt2bEFmOTlnbGZaNitTeVl5Uk5BbCtYUHJPL3BwY0hhL0ZBeWV3ZWpmaElM?=
 =?utf-8?B?V0NlSnVVQjQyRkptYW1RU0hkOGdUMGJwQm12azZodGF6NmdqZkhUTlpiWC9q?=
 =?utf-8?B?UkNyS0lDL1hSSGgvTWNXOHFZNVZBdTAySWJlZzg1a0NHVktlZEdrem9WZTg5?=
 =?utf-8?B?RE9WOHoycFBxTmc5QVhIYm9uK1k2VS9iWEJoN2NhVzVDLytQNXRjNkNURmRy?=
 =?utf-8?B?dU5jeXpHekFhaUFQVDlrS2JvY1Rwb0xvT0xSNWJyQXhzZW1aZWNSZHVnejI0?=
 =?utf-8?B?cnV2OGhFZVRxbTI1WVdEcWpEd013UlMzeG9JOGFHMW04OTlCM05uQmhBZjVJ?=
 =?utf-8?B?aTI3T1kzMjlhdVMyQ1kzcmpxM2ZkL3ZkWXdackRpaFRCZldlR1Fwdk1SWDNo?=
 =?utf-8?B?Sndhbm1CVldUTVY5YnIzeXVMNEZqcFkyVGtld3lGL2VpYThudlcvd2daNjVW?=
 =?utf-8?B?bm56YVB6NnhQRTlzQm5kdjIzcmpHTk42blgrUDRGSEZxNHlTYms5K0ZUTjFp?=
 =?utf-8?B?Mk9odTYxc0xkcmFEdEI5K2ZBVnVDVjkzcWxvaDR3ZXlra3dEbUxQNUVlaERC?=
 =?utf-8?B?TDF6cjkyTVM3b2p1NzRZS05WclpwREpiMlptQndSMU5oZ0JGRStrdHlVekxs?=
 =?utf-8?B?ZHM2UWJ1SVdVVzVtMWxEU014aDl6NHdzWFh1QmhtN0lZWnIyb0ZhMlZLa2gy?=
 =?utf-8?B?d0hnQVdDZFhiV2FQRk54ek5ndUFWUDErV0VEOEVjRWRrTENMNlJVU1U0eVcy?=
 =?utf-8?B?MjRRTVlsN0gzVndqaWJzYWZuMjlvRDRhRUsveGRha3hwM2NWUHNPY2MzakI1?=
 =?utf-8?B?eGVWczRvWnBSY00yWEpCbW1hNTFsZWhNNXEvVUFPeWFQUUsyeXR3OWxWdktK?=
 =?utf-8?B?ZzlJdE1yN1NZeFlkazk1V2tjQzRSWHQ3MDdjcWpQK0JpMWlTeTVrQW5wNDlJ?=
 =?utf-8?B?S1NpTHR6VS9OYldmYU53SGZpYnB1VFZkdDJwTUFoREZ6M05hQkhJclB6NEF3?=
 =?utf-8?B?dHo2VHY5T3NyRnJXREQxbzE1QTN6alY3bC9rR2E1YldQU3pFTldkSk5oYjRm?=
 =?utf-8?B?YlYvbHpJSUFLRW9vclYzN3I2eTd6QVZGekkwd3F6SDJVQ245S2YxZXpzVzkx?=
 =?utf-8?B?T09mckk5QzVrZkF3cjV4NHNZdHNCVklQN2NrcXpMeDFEcTZYM2F0K3M4emZN?=
 =?utf-8?B?Y1lYeXA1aCtZR0ZSK0U5Uzd1V0h0aS93cmFGKzhTQi9sRnVFTnFRMzdJZlpQ?=
 =?utf-8?B?NGJPTG8xS1pvczVZRHNLQmh4OFlXaEQ1d3VBNERycHZ5aGw0VlA3VE52MGNy?=
 =?utf-8?B?OXFlMUtYQWl3WlpyeldCM2RVeHUzN2ovdXVwdzhRSVZnT0NqVnUrSmR6NFZK?=
 =?utf-8?B?V1BRTUxCZVE3NERtWjRWZUJLbHNzbTVNZzhpMEU4NmE1NkEzT3hkN01YUUFE?=
 =?utf-8?B?Y003NUZOTW1pOTNWU2RDRlZHNE5ScGlTSzc3S0xuWTlSM0xVSU1jRVlSUFJ0?=
 =?utf-8?B?aVVUSURMaUJOMU4rVUpRUkR5c2RKMERTakZ2VjQxUksxOUxyVjgzdWJOOXB3?=
 =?utf-8?B?aHdDT1l2YXp1V0NicHNKS2NlMk9GRGwrQmZTNU1EUTVabVAxSDZyenp6VlFs?=
 =?utf-8?B?VGVqMm4zOGVPS3JCckh0eEpwWmZYdlJZSUpBOWFsOWVxOHNsdU1qSVBOaXNr?=
 =?utf-8?B?TWkyMmFhSzc5eUQ5Y1hTNzBxdmpEVUFERXpLY3hWYlAra2U0d3NDRVlUMWN6?=
 =?utf-8?B?R0RoRXQ3aE42RHR0L2VDMW9KWXU5K0lUZzVMTGFER3NzVmI0TXU4U25QV05U?=
 =?utf-8?B?Uk9TME1wUjVUMkRCR1JlL0xnNGozQkZab1hpeDEzdU5EaUdKdk55ckdLWWVO?=
 =?utf-8?B?ZDcrQ0RmeDhrSXcvSnl2dWV2ZnFmZnVjN0VVNTBSZjhhS0JnZm9ZTXp5Nlpj?=
 =?utf-8?B?VitydTdvRTZNYk1HRVluTC9rMVBrY05VWG1zNUZhWFZCS2UrMXFTbUN6Ui9R?=
 =?utf-8?B?RytDSXVtR2pNZHJWZTZQNzdBL1I1cjFRMWtTanJ2OHVKbDIrMzA1VlVqRUlZ?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3BDC4CAC32FEC4FB1D104709FEFE697@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df54d18d-c1f1-4a9b-5f77-08db9e9c189a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 21:02:26.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDLLf48PpxYDV+aEnV/PZ7k5KrlEkrpH1V8RdBQmM/EeqkKIKPWAGOpYiop9T/+Pc739iw96bZ81yHaNFBBvM6cXNyNtVLlICeujgcZCfQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3786
X-Proofpoint-ORIG-GUID: ybUL_0TvpS0xLx3K__fpPsM68Q6vcKm_
X-Proofpoint-GUID: ybUL_0TvpS0xLx3K__fpPsM68Q6vcKm_
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDEwLCAyMDIzLCBhdCAxMTowNyBQTSwgSmVmZiBMYUJ1bmR5IDxqZWZmQGxh
YnVuZHkuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgQXVnIDA5LCAyMDIzIGF0IDA3OjEwOjI4
UE0gKzAwMDAsIEphbWVzIE9nbGV0cmVlIHdyb3RlOg0KPj4gSW50cm9kdWNlIHN1cHBvcnQgZm9y
IENpcnJ1cyBMb2dpYyBEZXZpY2UgQ1M0MEw1MDogYQ0KPj4gaGFwdGljcyBkcml2ZXIgd2l0aCB3
YXZlZm9ybSBtZW1vcnkgRFNQIGFuZCBjbG9zZWQtbG9vcA0KPj4gYWxnb3JpdGhtcy4NCj4gDQo+
IEZyb20gbXkgZXh0cmVtZWx5IG5haXZlIHBvaW50IG9mIHZpZXcsIHNvbWUgb2YgdGhlIGNvZGUg
dGhhdCBmb2xsb3dzDQo+IGJhcmVzIHJlc2VtYmxhbmNlIHRvIHRoZSByZWNlbnRseSByZXZpZXdl
ZCBMMjYuIE15IGFzc3VtcHRpb24gaXMgdGhhdA0KPiB0aGVzZSBkZXZpY2VzIGFyZSBkaWZmZXJl
bnQgZW5vdWdoIGluIG5hdHVyZSB0byB3YXJyYW50IGNvbXBsZXRlbHkNCj4gZGlmZmVyZW50IGRy
aXZlcnM7IGlzIHRoYXQgYWNjdXJhdGU/DQo+IA0KPiBPbmUgcmVhc29uIGZvciBhc2tpbmcgaXMg
YmVjYXVzZSB0aGUgTDI2IGRyaXZlciBpbmNsdWRlZCBhIGNvcm51Y29waWENCj4gb2YgcG93ZXIt
bWFuYWdlbWVudCBvdmVyaGVhZCwgeWV0IHdlIHNlZSBub25lIG9mIHRoYXQgaGVyZS4gQXNzdW1p
bmcNCj4gYm90aCBMNTAgYW5kIEwyNiBhcmUgYnVpbHQgYXJvdW5kIHRoZSBzYW1lIEhhbG8gRFNQ
LCB3aHkgaXMgdGhlcmUgc3VjaA0KPiBhIGZ1bmRhbWVudGFsIGRpZmZlcmVuY2UgYmV0d2VlbiB0
aGUgdHdvIGluIHRlcm1zIG9mIHBvd2VyIG1hbmFnZW1lbnQ/DQo+IA0KPiBUbyB0aGF0IGVuZCwg
aG93IGRvZXMgdGhpcyBkcml2ZXIgaGFuZGxlIGhpYmVybmF0aW9uPyBJcyBoaWJlcm5hdGlvbg0K
PiBub3Qgc3VwcG9ydGVkLCBvciBkbyB3ZSBzaW1wbHkgZGVmZXIgdG8gdGhlIERTUD8gSW4gdGhl
IGNhc2Ugb2YgdGhlDQo+IGxhdHRlciwgd2h5IGlzIEw1MCBnaXZlbiB0aGlzIGZyZWVkb20gYnV0
IG5vdCBMMjY/DQoNCk9uZSBrZXkgZGlmZmVyZW5jZSBpcyB0aGF0IEw1MOKAmXMgSGFsbyBDb3Jl
IERTUCBpcyBzZWxmLWJvb3Rpbmc7IHRoZSBmaXJtd2FyZQ0KaXMgYnVybmVkIGluIGFuZCBubyBm
aXJtd2FyZSBkb3dubG9hZCBpcyByZXF1aXJlZC4gT24gTDI2LCBmaXJtd2FyZQ0KZG93bmxvYWRp
bmcgaXMgY29tcHVsc29yeS4gVGhpcyBkaWZmZXJlbnRpYXRlcyBkZWFsaW5nIHdpdGggdGhlIERT
UCBpbiB0aGUNCnR3byBkcml2ZXJzLCBiZWNhdXNlIHRoZSBMNTAgZHJpdmVyIGRvZXMgbm90IG5l
ZWQgdG8gZG8gYSBsb29rIHVwIGV2ZXJ5DQp0aW1lIGl0IHJlYWRzIG9yIHdyaXRlcyB0byBhIGZp
cm13YXJlIGNvbnRyb2wuIFRoZSByZWdpc3RlcnMgYXJlIGFsbCBzdGF0aWMuDQoNCk1pbm9yIHJl
YXNvbnMgYXJlIHRoYXQgdGhleSBoYXZlIGRpZmZlcmVudCBwb3dlciBzdXBwbHkgY29uZmlndXJh
dGlvbnMgdGhhdA0KcmVxdWlyZSBkaWZmZXJlbnQgcmVnaXN0ZXIgc2V0dGluZ3MsIHRoZXkgaGF2
ZSBlcnJhdGEgZGlmZmVyZW5jZXMsIGFuZCBhIGRpZmZlcmVudCBzZXQNCm9mIGV4cG9zZWQgZmVh
dHVyZXMgKEw1MCBiZWluZyBtdWNoIG1vcmUgc2ltcGxpc3RpYykuIEkgdGhpbmsgdGFrZW4gY3Vt
dWxhdGl2ZWx5DQp0aGVzZSBkaWZmZXJlbmNlcyB3YXJyYW50IHNlcGFyYXRlIGRyaXZlcnMuIFRo
b3VnaCwgSSB3aWxsIHRha2UgQ2hhcmxlc+KAmQ0KcmVjb21tZW5kYXRpb24gdG8gZmFjdG9yIG91
dCB0aGUgc2ltaWxhcml0aWVzIGludG8gYSBzaGFyZWQgbGlicmFyeSB0aGF0IGJvdGggTDUwDQph
bmQgTDI2IGNhbiB1c2UuDQoNCkxldCBtZSBrbm93IHdoZXRoZXIgeW91IGRpc2FncmVlIG9uIHRo
ZSBhYm92ZSBwb2ludHMgb3IgaGF2ZSBmb2xsb3d1cA0KcXVlc3Rpb25zLg0KDQpXaXRoIHJlc3Bl
Y3QgdG8gcG93ZXIgbWFuYWdlbWVudCwgSSBkaWQgbm90IHRoaW5rIHRoYXQgdGhhdCB0aGVyZSB3
YXMgYW55IG1lcml0DQppbiBpdHNlbGYgaW4gbWFpbnRhaW5pbmcgZXF1YWxpdHkgd2l0aCBMMjbi
gJlzIGFwcHJvYWNoLCBhbmQgSSB3YXMgaW5jbGluZWQgdG8gYWNjZXB0DQp5b3VyIHJlYXNvbmlu
ZyBmb3IgdXNpbmcgcmV0cnkgbG9naWMgb3ZlciB0aGUgcnVudGltZSBQTSBmYWNpbGl0aWVzIChu
b3QgdGhhdCB0aGUNCmxhdHRlciB3YXkgaXMgaW5jb3JyZWN0KS4NCg0KUmVnYXJkaW5nIHRoZSBu
ZWVkIGZvciBJMlMgc3RyZWFtaW5nIHN1cHBvcnQsIHNpZ25zIHBvaW50IHRvIG1heWJlLiBJIHdp
bGwNCm1pZ3JhdGUgdGhpcyBkcml2ZXIgdG8gTUZEIGZvciBWNC4NCg0KPiANCj4+ICsgcmV0dXJu
IGNzNDBsNTBfZHNwX3dyaXRlKGNzNDBsNTAsIENTNDBMNTBfQlNUX0xQTU9ERV9TRUwsIENTNDBM
NTBfRENNX0xPV19QT1dFUik7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgY3M0MGw1MF9w
YXRjaF9maXJtd2FyZShzdHJ1Y3QgY3M0MGw1MF9wcml2YXRlICpjczQwbDUwKQ0KPj4gK3sNCj4+
ICsgY29uc3Qgc3RydWN0IGZpcm13YXJlICpiaW4gPSBOVUxMLCAqd21mdyA9IE5VTEw7DQo+PiAr
IGludCBlcnJvciA9IDA7DQo+PiArDQo+PiArIGlmIChyZXF1ZXN0X2Zpcm13YXJlKCZiaW4sICJj
czQwbDUwLmJpbiIsIGNzNDBsNTAtPmRldikpDQo+PiArIGRldl9pbmZvKGNzNDBsNTAtPmRldiwg
IkNvdWxkIG5vdCByZXF1ZXN0IHdhdmV0YWJsZSBmaWxlOiAlZFxuIiwgZXJyb3IpOw0KPj4gKw0K
Pj4gKyBpZiAocmVxdWVzdF9maXJtd2FyZSgmd21mdywgImNzNDBsNTAud21mdyIsIGNzNDBsNTAt
PmRldikpDQo+PiArIGRldl9pbmZvKGNzNDBsNTAtPmRldiwgIkNvdWxkIG5vdCByZXF1ZXN0IGZp
cm13YXJlIHBhdGNoIGZpbGU6ICVkXG4iLCBlcnJvcik7DQo+PiArDQo+PiArIGlmICh3bWZ3KSB7
DQo+IA0KPiBJdCBpcyBhIG11Y2ggbW9yZSBjb21tb24gZGVzaWduIHBhdHRlcm4gdG8gYmFpbCBp
ZiByZXF1ZXN0X2Zpcm13YXJlKCkgcmV0dXJucw0KPiBhbiBlcnJvciwgdGhhbiB0byBwcm9jZWVk
IGFuZCBjaGVjayBhZ2FpbnN0IHRoZSBGVyBwb2ludGVyIHJlbWFpbmluZyBOVUxMLg0KPiANCj4g
SXMgdGhpcyBkb25lIGJlY2F1c2UgY3NfZHNwX3Bvd2VyX3VwKCkgbXVzdCBiZSBjYWxsZWQsIHdp
dGggb3Igd2l0aG91dCBhIHdtZncNCj4gb3IgY29lZmZpY2llbnQgZmlsZSBiZWluZyBhdmFpbGFi
bGU/DQoNCkkgZG9u4oCZdCB0aGluayB0aGF0IGNzX2RzcF9wb3dlcl91cCgpIG11c3QgYmUgY2Fs
bGVkIGluIHRoZSBjYXNlIG9mIG5vbi1leGlzdGVudCAud21mdw0KYW5kIC5iaW4gZmlsZXMsIHNv
IEkgd2lsbCB0YWtlIHlvdXIgc3VnZ2VzdGlvbiBhbmQgb3B0aW1pemUgdGhpcyBmdW5jdGlvbi4g
SSB3aWxsIGFsc28gc3dpdGNoDQp0byBhc3luY2hyb25vdXMgZmlybXdhcmUgcmVxdWVzdGluZyBm
b3IgVjQuDQoNCkkgd2lsbCBhbHNvIGluY29ycG9yYXRlIHRoZSByZXN0IG9mIHlvdXIgcmV2aWV3
IGNvbW1lbnRzIG5vdCBtZW50aW9uZWQgaGVyZSBpbiBWNC4NClRoYW5rIHlvdSBmb3IgdGhlIHRo
b3JvdWdoIHJldmlldy4NCg0KUmVnYXJkcywNCkphbWVzIE9nbGV0cmVl
