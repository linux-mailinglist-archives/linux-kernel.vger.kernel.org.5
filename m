Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981D77DE724
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjKAUra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjKAUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:47:28 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E415B10E;
        Wed,  1 Nov 2023 13:47:22 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A1JMnox005126;
        Wed, 1 Nov 2023 15:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=Wws+Pp9Eea2NjMHKQIUpOhaTrONyIvLp9ytqSGrW+
        ng=; b=cWKr2Dhtm83U+DArMhIGiX1vX3eh/BkrLWtQZV4GRFdwjJfaSXcriRtZK
        q/U3+OD/kLwZH6gQY8l6FUgiRo+OUkPz7a0v3z63iwu2vZJWU/PGiUvYo8JdIknd
        OSLhZPNKEB8oWQofykyordr0fnauc0GRa8Vf3ckdgGEs0ikNCnRKlGGMSTvXR4YW
        XI+srGSf8tpvtebExVkPUBjqDNNTrK0Omdx5ytTbfE2xurol6ee45Y3OSNryWICb
        kW5FOXEbJ2O3iabNw6PcuIyhTmvUZLPMWW6kKsCaJYikoONb+oaa7qj5JtMbouYT
        kryAvwrDsYQxF9D3rBlPzDpxB3P0A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3u0ypxfxqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 15:47:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNQNvNK/pRIXuFCg+soSvFzQN2q/n1U69zbbgd5WXujqC62CS/QFoD+es7sFs1XT7lltoVgM6GPpOxw6P/z5N5lV19gwlaerRXtbPGCPagattxlP64iUPi5AiuXRXzQtf1eEhCKodgnO4o9WTMQJJCJbtTdJM2jQlFPRNfTWkeqcgjRk0e99YuTzo3ujEnN0CjaGSxzjyRj2dfvxh0YWpm1K+SK0p94ej5dAJxIpWTV/1bytVPy1qQpZdRIwGTCL6AxpAoMuUhp/uYvzdGKdix64HQw4NJ79JslZnvViXZwsMpWFdfkwxyb9NWZBM1LsCITbAgiRMnWdnU1rIbjl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wws+Pp9Eea2NjMHKQIUpOhaTrONyIvLp9ytqSGrW+ng=;
 b=nsPrdxiPvd5aKNBRn8Opdr2/vbyAzlg5Z3f5S55QbudjyauKcxqUeaCknTWSY5PnL9dXCNHwLvY986zyW0b09gRXHdD+DKn5wcWzLJgC0nHL/p7Uk4gvVBvdz1wj3nCOz/ZLBk5JgW4xKMMmrBOZ6BrI4kBX8ZTd3wdsiSAr5COC0JPZAw8E7zw3ifGkU/lQsfmkH5jjtxITiCvra6uK1yG7nbYz+a2BD6gFOUu5+3dh99G2X4SsrLGaHnAsXTn2ulxCj8V+GSZY3lSKHc6yWj1Zt3evBDrVADJlauZbchc3T7kd8RvRJgyiCKJ9oyr2lpjoc24jiEY/mVud1vGQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wws+Pp9Eea2NjMHKQIUpOhaTrONyIvLp9ytqSGrW+ng=;
 b=rlN4WJbmavfRp3miW7OaqnldJeprYEU8WlJHrEuy4kZEPmLAfaJpzDdMZvF9/NNXaV4rwOPphw98X/RSmb5nmoFCxmdnBxuhDWIxX44Lp37uiPYACFwajGCIYFZ/S0SHTien1YeesQIpuXs6R/ZpCcpkTv449+1+sVIdumCqWPk=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by BLAPR19MB4273.namprd19.prod.outlook.com (2603:10b6:208:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 20:47:07 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::afe5:fe4:70fd:e67f]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::afe5:fe4:70fd:e67f%5]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 20:47:07 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     James Ogletree <james.ogletree@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Thread-Topic: [PATCH v4 4/4] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Thread-Index: AQHaAeygIIsKqHuCVE+at9isGtyemLBZ27gAgAwpioA=
Date:   Wed, 1 Nov 2023 20:47:07 +0000
Message-ID: <120DA9BB-2607-4A85-B96C-5A2490E50876@cirrus.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-5-james.ogletree@opensource.cirrus.com>
 <ZTiFbmutojF0LRZU@nixie71>
In-Reply-To: <ZTiFbmutojF0LRZU@nixie71>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|BLAPR19MB4273:EE_
x-ms-office365-filtering-correlation-id: a7bd5508-5a90-49b9-82d9-08dbdb1bb6b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRfLUeIFjNKZjmXFM1Z92rWr9qP/g4ZhnBIWgTxsctwQSHvcgc40TkPAfSuDUzJ3WhTUCAuweG2r8KRY9OfyxLgmICXZJQMy7b/Fnk17DkpQ34cBmq3AB8vvsgCb3eJ2fvHckR/NUitAkLZMbrd5UtzqNDw31kFZut8q1nu7OrnH+wltibgS4cyYuVZkOop8igKXb3RetsoS9spmG0f1xQST5iFiHvhcYbMbFyM3iy1TIFBU4yIwRl3zCA2InfHko/ZDg9IaOhrSfsZv2+6otQRb/w6z/l/TmRn12Q/PjaUk2L/tt9pfkLwg0CTyBAIFxaN4aFVbFaimWtsOvHWhdvXeiL37jZ1gYpx3MI/bqRdkl83QU2+ENsQOmsw39asbzYSbd3fFaI/gzOmdAQT2F/jEsrj+B9++uYcXRJ4LK3VgXzvf8NTXOrbRZjjXzAbXdt5GOlDOsgeMUJEDKbBV1b0fGmFHO6gmFgnapLG43sf5qxLoISLbtOjBskOb5FyS0Udsc8jQXbou9iwAmtXkEhZobtveGkwidO1jomyYhxUH3dTjw8eULHnjP0NdcgLMFWAyLO7O6hYCtNDrPJRKbBz5ZgcAhOKwprUrekvKl1YQhqw8uwY9rjJ2f2HPe2sTkOlyERiztYRL/FRAWdDfeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(346002)(366004)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(122000001)(6512007)(86362001)(33656002)(53546011)(2616005)(36756003)(6506007)(71200400001)(38100700002)(38070700009)(2906002)(478600001)(83380400001)(6486002)(66446008)(64756008)(54906003)(41300700001)(66556008)(66476007)(6916009)(316002)(91956017)(76116006)(66946007)(4326008)(5660300002)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uldacm0zUTN4VTFYSFNrS3M2TUNsQjRlYXZJWFdkcW0zdGxyZWFYclNUYWxa?=
 =?utf-8?B?V3hKaTlHMk5hRmVhYlc4bXFyc3pCc2hIYjliWGM3ZUxSRE9mb29jVmc4cnI2?=
 =?utf-8?B?Ni9HOVhKMVduU2IyT3MyY1RQcjRZTnN6NDNkbHMvVVNBYmZrN2pkSGNXcmdI?=
 =?utf-8?B?cWVSSEpoMlRUci9jTXQ1cnpOTXNKZzZiTFI2bnpYd1U3VUpRNjFTYkJGYWRi?=
 =?utf-8?B?dGtUSXZRYXNUM1J4ZVp6bEo3NkhnT0EwaTNaWTYzMVE2V1NIOWhQK2V5WjVZ?=
 =?utf-8?B?dU5IRzVJTVZCVUNVaG42c3Y5azFaZUtycDRkL3BncWx4U2g1SHVDZUJDVHF5?=
 =?utf-8?B?YVJzdll4KzVpRlphdTRVZjIveFBIVi9neVdGOGN2czVMT2FDOEJNZFNzNXBI?=
 =?utf-8?B?V0pTeWhJWGt1ZllHeGk0NGxydmF1ZmhMZk5MUWUyWWFEeVo4VVYyUFNESE5X?=
 =?utf-8?B?THVJdmtvNDdOWEdnT3hGSElDZGRPQnVmNWVSWWdIb2c2dUdIeE9KMTJmMy9G?=
 =?utf-8?B?U3VVajBVU1I5aDRRN1RYQ21NZDFhV3hjS1g3TjhsaURzTGY0ZkdFaG5UT09l?=
 =?utf-8?B?VHBXYjhZKzlkb2JOQnVzUmg2ZFVMSnE1Y3FJRnRPNzE1V2pacjAwSkdsZDhP?=
 =?utf-8?B?QVVPcWdJMU9WVG9DSW15bXYzZUxKWVR0TjFlRTBXT2taUUFCTHpMMWZ3RWdm?=
 =?utf-8?B?MzVGZ0JnMTllMjhVa3FmYkNRZmlQdXhRdE9DQ2ZmRUxCWnU4VXFOWkpDVUh5?=
 =?utf-8?B?OHF1M2w0SHFsVldZeGZvdGhLZ1JBSElQb2d4R3pSbGw5OFdVelhLakltTXhz?=
 =?utf-8?B?a20rUWJyZTFQTUdyMVVMb2tHL3hoK1k1SkJXL3VvUUpnZXNMSEx6ZnF5RUxX?=
 =?utf-8?B?Z3RTVWxVakcvWVpSbyt1QTJTY3BpT2ZualY0cm5FWTdlWUR2VkFmM3M0THpV?=
 =?utf-8?B?VkVKYnJoaGh1VWZXUE44UzdlZ1g0ajFzVGt4MTJlTXpidlJrbTdPUFYySlhN?=
 =?utf-8?B?VGxUWGpHcjU0aFBLNmdMelE3elBZYTBqcmNJMzJHditZK2s0N0NmTlozSHp6?=
 =?utf-8?B?ekZwcW5qL0I4N1JiTzkwN2tBdWNDbGE0aTZ6U2dHWmFBRHJLcTI2eXdMYlll?=
 =?utf-8?B?bFdDbktxMGs1dmx6ZHVlc0xKd3pXS1JJRHhUQTZ4ZnRVeks2SDRnTmd1SUJj?=
 =?utf-8?B?WFZMdlhsZ3ZTWG1FWm9XNDJYTzRhbHNLc2F6RWNMejJKV2ZacjMyN1VTaCsz?=
 =?utf-8?B?ekZRK2JXUzFVS09Ca1JqS2tVSnpNUXZTVXpoc21nZXQvVEVXZ0x0Vk9MYjQw?=
 =?utf-8?B?T1NyZVJtNEVlZ0dJSzlVQUsyajhlTTF2dDdjaUUxdFFnTWpIcnI4ZDl3eU1D?=
 =?utf-8?B?d1FnTkJEczZpcmFtcDNMVTZhTWRKNjJMa1ZwOWdmU2NPSVd0QU9ZQU40YlFz?=
 =?utf-8?B?cmJ0K1I5STZ0c1h5N1pSMVlQaXQ3WUxXMVQzS1NJVVNpdEFDNE04OU9TMFdS?=
 =?utf-8?B?aDZhWEZCeUt2Y0IrYmJFVUZ1d2ZsblZUZDRqVTNrS01NL3JFcThKdUxuTnF5?=
 =?utf-8?B?UE9jUFFpNDllNXRsSElwdVRsK0d3dklxRnl2R09jR3hJeGI1MzVlMUJUR000?=
 =?utf-8?B?SEVBcXdrd2kweVlzejRNYldrV0dKb29EcHNkT09lL1kySXdxV3EydTg2OFNv?=
 =?utf-8?B?alpZQ3JuREFLM3BZcGNKNXVuQTlFVHJ5ek9NY3BNZFNnWmpObkJPZHhjcXBM?=
 =?utf-8?B?aXp5WndnbGlKMWJYYmpIOE5WZExWQ0FDNGt6S1dmcTBqNDdBSFR2NDZMUlJG?=
 =?utf-8?B?ZytpdzBFOEZ1T0hFNmZwVGE4NkE5eFpEYVZBTFprVkFlbGFaWm1RL0xyajcr?=
 =?utf-8?B?SVV5OVUvLzVPbkxYY2Vqc0VjZUFVdkRsV3EwQ0FWdktjMmg5bTZsd1lYNk4w?=
 =?utf-8?B?SDZWVklnMk5kcElMT2J0VjF1RTEzVnBwbE93REpNaVN3SmdjdUhEeXBQOC94?=
 =?utf-8?B?R3FKOUl3WG5jbm9Ea1VuM3M5by9LSUxBNkI3bWlwK2dIMmpUNFJsY2orb3pk?=
 =?utf-8?B?bW8yZTZ6VTRTYlVnbmhvMUxVRVc4MDJWZ2haZXhFay8xL3h5ZWw1ME1OVXJS?=
 =?utf-8?B?UkNsYk8yckJSVU12Um9YYlBiajMzNlNXam00TkdjcEMxMEh2dGJTeXgzeCti?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68EC8379F3F3D4459873AAFCD2419199@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bd5508-5a90-49b9-82d9-08dbdb1bb6b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 20:47:07.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NB0MOh8LbvyjwDU5jygXfdZmEefvqdoSUk0gz+p6Hkjvd7WBmRVfSCF1ODqdAZwwFtrJn4R4oq/L4PZStGqX1UzuyIqmmFtkNKDfxgK3hp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4273
X-Proofpoint-GUID: _xSr8uW1H6MkJlzH4UgIG7RlvHGtyDJe
X-Proofpoint-ORIG-GUID: _xSr8uW1H6MkJlzH4UgIG7RlvHGtyDJe
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmVmZiwNCg0KPiBPbiBPY3QgMjQsIDIwMjMsIGF0IDEwOjAzIFBNLCBKZWZmIExhQnVuZHkg
PGplZmZAbGFidW5keS5jb20+IHdyb3RlOg0KPj4gDQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBj
c19kc3BfY2xpZW50X29wcyBjczQwbDUwX2NzX2RzcF9jbGllbnRfb3BzOw0KPj4gKw0KPj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgY3NfZHNwX3JlZ2lvbiBjczQwbDUwX2RzcF9yZWdpb25zW10gPSB7
DQo+PiArIHsNCj4+ICsgLnR5cGUgPSBXTUZXX0hBTE9fUE1fUEFDS0VELA0KPj4gKyAuYmFzZSA9
IENTNDBMNTBfRFNQMV9QTUVNXzANCj4+ICsgfSwNCj4+ICsgew0KPj4gKyAudHlwZSA9IFdNRldf
SEFMT19YTV9QQUNLRUQsDQo+PiArIC5iYXNlID0gQ1M0MEw1MF9EU1AxX1hNRU1fUEFDS0VEXzAN
Cj4+ICsgfSwNCj4+ICsgew0KPj4gKyAudHlwZSA9IFdNRldfSEFMT19ZTV9QQUNLRUQsDQo+PiAr
IC5iYXNlID0gQ1M0MEw1MF9EU1AxX1lNRU1fUEFDS0VEXzANCj4+ICsgfSwNCj4+ICsgew0KPj4g
KyAudHlwZSA9IFdNRldfQURTUDJfWE0sDQo+PiArIC5iYXNlID0gQ1M0MEw1MF9EU1AxX1hNRU1f
VU5QQUNLRUQyNF8wDQo+PiArIH0sDQo+PiArIHsNCj4+ICsgLnR5cGUgPSBXTUZXX0FEU1AyX1lN
LA0KPj4gKyAuYmFzZSA9IENTNDBMNTBfRFNQMV9ZTUVNX1VOUEFDS0VEMjRfMA0KPj4gKyB9LA0K
Pj4gK307DQo+PiArDQo+PiArc3RhdGljIGludCBjczQwbDUwX2NzX2RzcF9pbml0KHN0cnVjdCBj
czQwbDUwX3ByaXZhdGUgKmNzNDBsNTApDQo+PiArew0KPj4gKyBjczQwbDUwLT5kc3AubnVtID0g
MTsNCj4+ICsgY3M0MGw1MC0+ZHNwLnR5cGUgPSBXTUZXX0hBTE87DQo+PiArIGNzNDBsNTAtPmRz
cC5kZXYgPSBjczQwbDUwLT5kZXY7DQo+PiArIGNzNDBsNTAtPmRzcC5yZWdtYXAgPSBjczQwbDUw
LT5yZWdtYXA7DQo+PiArIGNzNDBsNTAtPmRzcC5iYXNlID0gQ1M0MEw1MF9DT1JFX0JBU0U7DQo+
PiArIGNzNDBsNTAtPmRzcC5iYXNlX3N5c2luZm8gPSBDUzQwTDUwX1NZU19JTkZPX0lEOw0KPj4g
KyBjczQwbDUwLT5kc3AubWVtID0gY3M0MGw1MF9kc3BfcmVnaW9uczsNCj4+ICsgY3M0MGw1MC0+
ZHNwLm51bV9tZW1zID0gQVJSQVlfU0laRShjczQwbDUwX2RzcF9yZWdpb25zKTsNCj4+ICsgY3M0
MGw1MC0+ZHNwLm5vX2NvcmVfc3RhcnRzdG9wID0gdHJ1ZTsNCj4+ICsgY3M0MGw1MC0+ZHNwLmNs
aWVudF9vcHMgPSAmY3M0MGw1MF9jc19kc3BfY2xpZW50X29wczsNCj4+ICsNCj4+ICsgcmV0dXJu
IGNzX2RzcF9oYWxvX2luaXQoJmNzNDBsNTAtPmRzcCk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRp
YyBzdHJ1Y3QgY3NfaGFwX2JhbmsgY3M0MGw1MF9iYW5rc1tdID0gew0KPj4gKyB7DQo+PiArIC5i
YW5rID0gV1ZGUk1fQkFOS19SQU0sDQo+PiArIC5iYXNlX2luZGV4ID0gQ1M0MEw1MF9SQU1fQkFO
S19JTkRFWF9TVEFSVCwNCj4+ICsgLm1heF9pbmRleCA9IENTNDBMNTBfUkFNX0JBTktfSU5ERVhf
U1RBUlQsDQo+PiArIH0sDQo+PiArIHsNCj4+ICsgLmJhbmsgPSBXVkZSTV9CQU5LX1JPTSwNCj4+
ICsgLmJhc2VfaW5kZXggPSBDUzQwTDUwX1JPTV9CQU5LX0lOREVYX1NUQVJULA0KPj4gKyAubWF4
X2luZGV4ID0gQ1M0MEw1MF9ST01fQkFOS19JTkRFWF9FTkQsDQo+PiArIH0sDQo+PiArIHsNCj4+
ICsgLmJhbmsgPSBXVkZSTV9CQU5LX09XVCwNCj4+ICsgLmJhc2VfaW5kZXggPSBDUzQwTDUwX1JU
SF9JTkRFWF9TVEFSVCwNCj4+ICsgLm1heF9pbmRleCA9IENTNDBMNTBfUlRIX0lOREVYX0VORCwN
Cj4+ICsgfSwNCj4+ICt9Ow0KPiANCj4gVGhlc2Ugc3RydWN0cyBkZXNjcmliZSB0aGUgRFNQLCBh
bmQgaGVuY2UgdGhlIHNpbGljb247IHRoZXkgYXJlIG5vdA0KPiBzcGVjaWZpYyB0byB0aGUgaW5w
dXQvRkYgZGV2aWNlLiBQcmVzdW1hYmx5IHRoZSBEU1AgY291bGQgcnVuIGFsZ29yaXRobXMNCj4g
dGhhdCBzdXBwb3J0IG9ubHkgdGhlIEkyUyBzdHJlYW1pbmcgY2FzZSBhcyB3ZWxsIChlLmcuIEEy
SCk7IHRoZXJlZm9yZSwNCj4gdGhlc2Ugc2VlbSBtb3JlIGFwcHJvcHJpYXRlbHkgcGxhY2VkIGlu
IHRoZSBNRkQuDQoNCkFja25vd2xlZGdlZCwgYnV0IHdvdWxkIHlvdSBjb25zaWRlciB0aGUgbGFz
dCBzdHJ1Y3Qg4oCcY3M0MGw1MF9iYW5rc+KAnSBhcw0KYW4gZXhjZXB0aW9uPyBJdCB3b3VsZCBn
byB1bnVzZWQgaW4gYSBjb2RlYy1vbmx5IHNldHVwLg0KDQpCZXN0LA0KSmFtZXMNCg0KDQo=
