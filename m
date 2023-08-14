Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E551277C29F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjHNVpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjHNVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:45:11 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DAD110;
        Mon, 14 Aug 2023 14:45:10 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37EL1FNj001555;
        Mon, 14 Aug 2023 16:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=RFrnse4ll1hVhrAYLJDey37wnimFPyl7OQxhxz3V8
        J0=; b=BCvu0zo00g880OySucBh1lVnRjRDoLHMOKJCocyo6UsoyRNTUqwQpy2dJ
        q5IToFY+eDjVsQYI2pBIhGxNzvsAIq28/XLN+XISmRXUtHT9QLc6HHjBt2kG5HYr
        S/uizT8JC7hkvYDmluHVH0lMkXVDVeJ830TZ8UH7QPubx1kXGehbVMMgiCwLTMJJ
        4Jmfwz2IgQbMKN1+vN+yrf9ubdZNY63H+OmcgiXGl+laS+L3ICjQPy3RcVDYEWVv
        gcVsTOe2OhPdrhr9mliAmLmdaaokFGHGdcqGKHAwj56S4vGlQGUvszU9XOj7R7Wf
        +hZQ1Nqrt4X9GpZAtevSwX4dJ3ikQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhjb96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 16:44:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7KQVVroRXR2kKtA71nNDe8uriQxaHsIi7WczI7LW10btOqGJ4LQxHxKN91HbYJFNfxInJwp6uE5W8h4S9OXR1rnegq0Yb+YlxhgcuU+qrXK+P0vQuLmKULwrkwgrEdf5uUsXxquGVqBjYwN9sve6X7GSLHheBHkHhwtNmFUCAzBhhN2sx7mPWRpoX3bNNG8SVFBBGeRt8HCWdBDDDL15TVhV3T8xr2LYJQFn2QFZRzVL6zkfOUkvl6+yVydG8K3fJBE4VqRcQGksIVgI9D3iKZXm+eADoKpuf1LWzpD/efMb4m0Wm8Q79xUdEiD28xcCa0FxTr1bFqlhpw1sOdb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFrnse4ll1hVhrAYLJDey37wnimFPyl7OQxhxz3V8J0=;
 b=Ba9fe0jRRzTjZ/UenuNfjXOWkDthJDnlPNA4p8+crfGCJ6+mqiF1Iu9xlmXbQ92kQDLZZr6hy5l3eKIX4yail7Cjq6PFqD4AtexD3uiNkm4a2aMEU/VK8xHklVdjet0GNTNFXu2QFfOK+4ORfAfN3a/oSyx6JamUTuR+P6xZwN5/MsTPGH1EZLxl3LQ2l/BeTbUTN0RsXKpPVWlj1tK+hfzTok30BNXRRnKlFYKBPgPya8ewlxvfGpOzRQA1jzv8dFXRuuML90DLau21I95N7Sij88u1spiITFgqy0yyC49FeU5o2MEaY+qYCtDp7BrkqOSEbImOeGZhPzOxfpVGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFrnse4ll1hVhrAYLJDey37wnimFPyl7OQxhxz3V8J0=;
 b=haKnWQqcnX8/KdHXuINoAE1u+eV8NqjeYBZ8XBwADBrEUA960fji5XlrOVnERh11sC79EMxGQ0pLmEsEnWenGG+2KTFQdZ5cPMRS/mWVxCVGZtANZYHHUhx8Tc79R6Safni2B2YPrbmBLYvdiBEYkCGmLrAfmrEFD6YPwpEbH/4=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by CH3PR19MB8035.namprd19.prod.outlook.com (2603:10b6:610:17c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Mon, 14 Aug
 2023 21:44:33 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8%6]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 21:44:33 +0000
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
Thread-Index: AQHZyh7OBljw2/gB2Ee1hzhfi1Ulg6/hhmeAgAC8mICAAMwZgIAHTaMA
Date:   Mon, 14 Aug 2023 21:44:33 +0000
Message-ID: <E3A9D2CF-333D-4238-8013-346135AC001B@cirrus.com>
References: <20230808172511.665787-1-james.ogletree@cirrus.com>
 <20230808172511.665787-2-james.ogletree@cirrus.com>
 <065fbe51-928c-4728-efc2-bde87cd48cb3@linaro.org>
 <ADCCD2C5-B79B-4C50-B3CE-007B1FBF5A5E@cirrus.com>
 <3f406442-d46e-7f9e-426d-22a96f893103@linaro.org>
In-Reply-To: <3f406442-d46e-7f9e-426d-22a96f893103@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|CH3PR19MB8035:EE_
x-ms-office365-filtering-correlation-id: d6db51cf-deb5-4532-a26a-08db9d0fa5ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: siJXhv911e881K1aj2HPV3aAdrY5cflq11VsBElTlIGMAT2bcSzvB2n2sDXDcRFQClCw0qzomys0JaJugO6JKqc2Q/5J9M33vpRlmkkI2lEriiWX6TTt1MEfLhByu7JbdAhisLPeioOWFu4GgpvDYeynGxhJzsrZ5MYkS0HilWua7Oijw6AdWUVoG7eSS+T9JMkpFRdYtcEXqRp67D65HKY6qNB1sju1eFGYicTOqIJ647ybc0HqfF1wt2GvSKbTeWHNWm6n89LUafxhdBHDxdQEml0CYtv2V6E0UbB5ubzywnBkbfJpCxNp4zsQY161OUY3MNZF8FyfZnN1vBjkV3jzlfzL504Z4j1JHOmiBN6oqTRq/dSs6eECb4A0rwFZNxHicKW2ZLjzIGRmU71xOcbDHl+EAZetYvlyIQcpawamdjPTAUWQkBceC7dplyA9Zq9mJzgqBtnSChs57tSBH3st/WNmsuIxhrHC9759YCnbmhVW1DrsKm22F8dvaq5pkEiHs0hPn1rexDgiX8mchNhAOUSFRSaYAtvt1Z3M/7BftNSNIYIB12a9nfwNndNeBntn69k/oCgk8zNSvWA0NTLJPjhSExUox/HWIYi1UfPW58R245PFGTNZQ8dMHwR6zDJPMcE+19Ai/nXf6YEzjZunOJclTcrvPhfcP6+rh88=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39850400004)(376002)(346002)(136003)(186006)(1800799006)(451199021)(38100700002)(478600001)(66446008)(91956017)(122000001)(54906003)(4326008)(316002)(33656002)(64756008)(6916009)(41300700001)(36756003)(86362001)(6486002)(38070700005)(6512007)(66476007)(5660300002)(2616005)(71200400001)(8936002)(8676002)(7416002)(2906002)(26005)(66556008)(66946007)(76116006)(53546011)(6506007)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czFxS1ArNGlFUTlUQXkvaEhXS0hLQmozR0RPYk9kZnBrdFZLbGJVejN1elFi?=
 =?utf-8?B?K25wSlM0MFNmS3lTV1BPT1JET2M3RzNKMGhMR3E1NHB3bVhMTEVJNXNFVlpM?=
 =?utf-8?B?UGdWR3pUbExicjJEVzRmRXhOVUtybEhsT0IrRnVnK2ZUc0VObzZKUUtuMWFR?=
 =?utf-8?B?amZHcmY0R1lEeklZN2hFSENqYTJUWVdFbnBYWktxSktkb0Y0d3lrNC80MTE5?=
 =?utf-8?B?SUlQZkdGTHF2VUtmSE1mU3U3Z0t2dVN3SFVYTG5waG9SYXZFZUY1b21Pc0hX?=
 =?utf-8?B?eG44RTVhT3BsOUNIZXJIWlNmelJydTI1M1pjSFJQQTZtSk1TSjQwdUFVR1Qr?=
 =?utf-8?B?bXhTVUdZNGZ3TzM0UU5iYUdNL3BvVlhvQ0JIMHFYOGh4bWNVRkZ2V1NGbW9i?=
 =?utf-8?B?Rm12czJ1RC96WjRrK1l6UE4rYUR6M05OTTRJNkNYU0NFR2NOUDJVWUNsVHhF?=
 =?utf-8?B?Z1BTVDVtUXNxMnhvVFBiWUpUV29MeFVMV1hoWnhKMUl0bXZlOFhSSGN5TGpN?=
 =?utf-8?B?ay9nZ2h2cThPTG90VGlNdlpiVXNVT2tURy9YNmY5RkRnWnlodi9wejVHVTRz?=
 =?utf-8?B?ekRaOUZ4ZUpDS0hxU3RzeEVCN1dVU3M0cXlIbVFSZzcyYS9JUVFwbldGV0VQ?=
 =?utf-8?B?L0Z5UE9uWmxmVlIxRFJuT012YWN0bzlGTDVBaUtnVUZpTUdURFJIc1hFVmhL?=
 =?utf-8?B?dDN1RE9YbEJlMTBwQWFjUzRGWWI1LzZIRmV6QVJBa1N3eFJNdnVjdmJFTGE4?=
 =?utf-8?B?MEM4cUxuN3V4L1JMYm1vMlEvME82N2NkZ3NZdlYyWFVscW1zakRZcktVamhW?=
 =?utf-8?B?enVBdmxzdDF2Y1FqdnAvaXZmc3VtZ2hXTDBybHFqbEJZb3VMQmpJd3VZU2lX?=
 =?utf-8?B?Rm5nNC9ET09adThMblJ0eFV2TVJmdWozUzdaOXlEQ3ArR0NXZDYxQUxqVkEy?=
 =?utf-8?B?d1ZMSEUrdGhDMlZNUW5IQlU5NjgyclZkQUlFeE16bUZIdVVKTTc3UFIrTVpQ?=
 =?utf-8?B?QzNzd2hoUGlyUnlyMFBJNldTUk5UckVpZUV1c01zSU5SNyt5TGNWc1dvRmZ0?=
 =?utf-8?B?V2NPVDJVQzdha2tsYjBPS2g5K0Y3Z1N3Sk80b3hZS1Z5VysyeG52NHQyTnVB?=
 =?utf-8?B?YUZvYkt2OFEyaDMzVVhGcjQwa01XRFRQckp6RkN2UjFlWnRTTTArZ0FZejV4?=
 =?utf-8?B?TmpydXVUYzZYSGRmV1RZTzBOVWw0aXpZcGlQbmdPTG8wMmdrQXdJTWJtdDdv?=
 =?utf-8?B?K0JxUHZwcjFVcjlPL3lEZ2NzWExWTU4vcjd4SW5RajhQS1I3eUVuVEJIemhJ?=
 =?utf-8?B?S0k5Y2hZOEpsRlFBMXhYRWNRcWNjV2pPMTN6MVR4c1d5SzNyTDhKbFFhb29Y?=
 =?utf-8?B?NmdHQnJ3ZFBkWE4xUXhsL0E5ZzR5U0JhaGU5OU50RDRab3UvNm1QYS9FV0kw?=
 =?utf-8?B?RkhwWmp0SVpQcHNRcEVGeWl0b0QveTBKMjJEVGsxRE94eE9XVERoMzRLWTN0?=
 =?utf-8?B?MjVsRVVGMlRHeTFTdWtPUUVJMzRNSEdGWW1lKyt3RlkzSjB2c0lEenFxNWlT?=
 =?utf-8?B?WC9pL1YxRWRzdkZMYkhmNmEyNkxBaFRURjNjOTVVbEs0MkxPRXF6Ry9PclNX?=
 =?utf-8?B?Z2ZxR1FBQnFWRWxZSmR2MEswMGtXWEVxaGVzdFE0N3U3NlA1OTR2TDRsaG94?=
 =?utf-8?B?YUYwM20yTHl0RDZHYXQvcXgvZXZCV0Nsc3htaE9RaWJNL09Jb0wwZVNFM2lU?=
 =?utf-8?B?SGN0US9UVjAvR2RsWmJIdjcrS3pXcjJ3UHdxejl2MnZ0RWFGc0t6a2tPQWpK?=
 =?utf-8?B?amY4d2NFMjBJdmEvK2VYNWV2aDRpcTFTRUFoK3JHeDhEUVdxaDVEcGhyWkli?=
 =?utf-8?B?ZkZUVktFQTZZWi9uZ0xLV2srNWpDSGcxRWUzNzdpWEhuL3BPOXVEZ3oxN2Zx?=
 =?utf-8?B?ZjJiYnVYbjlQSFN4K25rbWtYZU5Gci9lWGhjUXZNV1U4ZXhHQjRBczdLckhu?=
 =?utf-8?B?UDE0Mno0NTdCWFBsai9jTWZKaTRvMytzNVFpSkRlMnp5WENVUWRmUFpHSFlJ?=
 =?utf-8?B?V1Y2SjVkdnh3TWVJNjVWRnpDNG81VmJHamNnckFUUTBEZmg2NDBBTDZSSGFa?=
 =?utf-8?B?YVNoazhVdEFNZGhRWlo2aVBpV1hpQ0VtOUtWZmNBU2lwMWpxS0RobWxJKzkv?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C9BF0EF0CE32045B5FBD82DCB671D1E@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6db51cf-deb5-4532-a26a-08db9d0fa5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 21:44:33.6628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkkGcNyv92cFAwnniHwhiip7qgmt95D00O6KMKZKu9DHhEraZQasIxqhpWkPawdxJCLJo1snfnWnPBcnSbEpEOIPVx5/Mv2aDjlMuxCiyZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8035
X-Proofpoint-GUID: ZBchmQEatrT_Y-l1sgsPgX3R5Jb4CA28
X-Proofpoint-ORIG-GUID: ZBchmQEatrT_Y-l1sgsPgX3R5Jb4CA28
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDEwLCAyMDIzLCBhdCAxOjEyIEFNLCBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+IHdyb3RlOg0KPiANCj4gT24gMDkvMDgvMjAy
MyAyMDowMiwgSmFtZXMgT2dsZXRyZWUgd3JvdGU6DQo+Pj4+ICsgaWYgKGNzNDBsNTAtPnZpYmVf
d29ya3F1ZXVlKSB7DQo+Pj4+ICsgZmx1c2hfd29ya3F1ZXVlKGNzNDBsNTAtPnZpYmVfd29ya3F1
ZXVlKTsNCj4+Pj4gKyBkZXN0cm95X3dvcmtxdWV1ZShjczQwbDUwLT52aWJlX3dvcmtxdWV1ZSk7
DQo+Pj4+ICsgfQ0KPj4+PiArDQo+Pj4+ICsgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGNzNDBs
NTAtPnJlc2V0X2dwaW8sIDEpOw0KPj4+PiArIHJlZ3VsYXRvcl9idWxrX2Rpc2FibGUoQVJSQVlf
U0laRShjczQwbDUwX3N1cHBsaWVzKSwgY3M0MGw1MF9zdXBwbGllcyk7DQo+Pj4+ICsNCj4+Pj4g
KyByZXR1cm4gMDsNCj4+Pj4gK30NCj4+Pj4gK0VYUE9SVF9TWU1CT0xfR1BMKGNzNDBsNTBfcmVt
b3ZlKTsNCj4+Pj4gKw0KPj4+PiArTU9EVUxFX0RFU0NSSVBUSU9OKCJDUzQwTDUwIEFkdmFuY2Vk
IEhhcHRpYyBEcml2ZXIiKTsNCj4+Pj4gK01PRFVMRV9BVVRIT1IoIkphbWVzIE9nbGV0cmVlLCBD
aXJydXMgTG9naWMgSW5jLiA8amFtZXMub2dsZXRyZWVAY2lycnVzLmNvbT4iKTsNCj4+Pj4gK01P
RFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4+PiANCj4+PiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgYSBt
b2R1bGUuDQo+PiANCj4+IEl0IGNhbiBiZSBjb21waWxlZCBhcyBhIG1vZHVsZSB3aXRoIENPTkZJ
R19JTlBVVF9DUzQwTDUwPW0uIEhvd2V2ZXIsIHRoZXJlIGlzIGENCj4+IHR5cG8gaW4gdGhlIEtj
b25maWcgZW50cnkgZGVzY3JpcHRpb246IHRoZSBtb2R1bGUgd2lsbCBiZSBjYWxsZWQg4oCcY3M0
MGw1MOKAnSBub3Qg4oCcY3M0MGw1MC1jb3Jl4oCdLg0KPj4gVGhhdCB3aWxsIGJlIGZpeGVkLiAN
Cj4gDQo+IFJlYWxseSwgKnRoaXMqIHVuaXQgZmlsZSBjYW4gYmUgY29tcGlsZWQgYXMgbW9kdWxl
PyBXaGVyZSBpcyB0aGUNCj4gbW9kdWxlX3h4eF9kcml2ZXIoKSB0aGVuPw0KPiANCg0KQXMgSSB1
bmRlcnN0YW5kIGl0LCB0aGUg4oCcbW9kdWxlX1hYWF9kcml2ZXIoKeKAnSBoYXMgbm90aGluZyB0
byBkbyB3aXRoIHdoZXRoZXIgb3Igbm90IHRoZSBmaWxlIGlzIGJ1aWx0IGFzIGEgbW9kdWxlLCBy
YXRoZXIgaXQganVzdCBwcm92aWRlcyBjb2RlIHRvIGF0dGFjaCB0aGUgZHJpdmVyIHRvIGEgYnVz
LiBCdXQgdGhpcyBpcyBhIGJ1cy1hZ25vc3RpYywgc2VwYXJhdGUgbW9kdWxlIChub3QgYSBkcml2
ZXIgaW4gaXRzZWxmKSB0aGF0IHByb3ZpZGVzIGltcGxlbWVudGF0aW9uIHRvIGNzNDBsMjYtaTJj
IG9yIGNzNDBsMjYtc3BpIGRyaXZlcnMsIHdoaWNoIGRvIGNvbnRhaW4gdGhhdCBtYWNybyBhcyB0
aGV5IHNob3VsZC4gVGhpcyBkb2VzbuKAmXQgYXBwZWFyIHRvIGJlIGFuIHVuY29tbW9uIHBhdHRl
cm4uDQoNClJlZ2FyZHMsDQoNCkphbWVz
