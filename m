Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D947D12F8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377770AbjJTPj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377751AbjJTPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:39:27 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7124C1A8;
        Fri, 20 Oct 2023 08:39:25 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39K6lqtt010597;
        Fri, 20 Oct 2023 10:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=QMf0A8r928idDgt6b6lsBzia+PXs/DeUiWk98dW1f
        QE=; b=mIUVAkuTQO6/Qdmu3au9DECIi7oa8JNGXqJQ21itvbwAamXnvG4sUHMGe
        A6fjzaFqPqFENxrz26Ork1CExUtc/783QfQft8FIyB8hLjWhGKsSlJeYYv7Ir/5u
        1xxKP5E9IyK4w2ed/kL4MTwqyXDTa+e9InBPX+z4tbaM08ZlqxSbAlk4VZnv5bHP
        jzKWqKdB2RprpgRupnnm2yppnTvNBAypyOq/w4NFad6l+/0J55z0AAMygCqgW5R0
        B5fgcAu3U2i9tSCnj3C1l0nkzzARR2uHAp7sN6XsWwY7UNXfsPamlXrQmHYBOpVu
        LJZEYOIrKcE5jEZTzmddC0rDISCOg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tubyns7uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 10:39:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4AjWm50bcXdvvEZx0Im9Oc7PVueeOZJkHGc8SCR+64GMbA3rwyTN01UUMxp4gJpCNZyrNDmzVDBv4jeo1IeTMDGba1tvOo2+B70bcTfYTBIYRSeMfCrDLrD/UXvmq1yRF+6zCX5beLY11OJ7ohYUBteoYbTV8i6rZYpYRZrNK1639dSqDQpzugV0/zgcN4D1w9+LPLhC+fAzo7PJqejQdmav8Pd1dkqbzalamWQ1PBbp4I9G8XRxPZYTPaha4bySZSrTghhMvvf++JN7TyPVRop3c2AveQtku6pxEQbo23QhFRgCu/iJVTKBtS2Y9YOQsu6ONb+79a7aqHl9AcrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMf0A8r928idDgt6b6lsBzia+PXs/DeUiWk98dW1fQE=;
 b=A5lFCpcMrmV0Go4tia/UaFPwibFOEOcAb/j1/WYY8+vzj/3RpYCEd7fw07gGgVx7S0VguNkyDrmY6XzFh2cgCSWFuvpHEee0aW+L96uONt1gYOPC3G0l8JV7T/rzUjWIidU+KF//ItvUuiBVtolqn7OJxcrCuCBc6Dg5OLqbipgajTI+byR5PFkFEVHhYRG3J5AZe2bQnxVkZQTHBQ9ua90G/1G2gOKsPqLw5FQwI2sNhSeONhbI+AiqqLyNq/uGuEqyaMri8uFNNkAZvdZLgCA75fxVCdlyvlL3rgDfrose8X2VVKFvqyucIOLLQxYQq3HzUVPpCc5Tm+CEV0s5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMf0A8r928idDgt6b6lsBzia+PXs/DeUiWk98dW1fQE=;
 b=YZoRHfTqrVZ5tXeusFjd6oW55l8w9ML3KRSsH0Vs//JNJRLuwJyEazhCjoRAr3sVAfo7+zZG7+kEPD56x0Y/u13U+al3yKtYasLnghpkHyd1fIVA0g7Bb1xB1I8LEYniXv/lOACx+s1jK3/AI/2zX2BcS03w1ZnXR39V0sANB5s=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by SJ0PR19MB5365.namprd19.prod.outlook.com (2603:10b6:a03:3dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 15:39:11 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::8a74:6925:435d:19a5]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::8a74:6925:435d:19a5%6]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 15:39:10 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Lee Jones <lee@kernel.org>
CC:     James Ogletree <james.ogletree@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Thread-Topic: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Thread-Index: AQHaAeyf+2JrjyX4UUi0J9ryDkVps7BRTXqAgAGFxAA=
Date:   Fri, 20 Oct 2023 15:39:10 +0000
Message-ID: <E3224624-7FF4-48F6-BA53-08312B69EF9F@cirrus.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-4-james.ogletree@opensource.cirrus.com>
 <20231019162359.GF2424087@google.com>
In-Reply-To: <20231019162359.GF2424087@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|SJ0PR19MB5365:EE_
x-ms-office365-filtering-correlation-id: 1b3c290b-8762-4bc3-36f4-08dbd182b45e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6cmq1E9xbHEp3C6Erf3jHBQ2iQTumIn44gM7Em3Bv6ti6vxJiiPUbPDjb7MdJlC9XRtvDFvPZ2xENHaE9qisc+93NnbXmwGIxQo+9dzJaRXDzxXyDQRwREGb7+LlDauLlRceoXcUv4+X5QjY8oI5GMbWT369rzpBCsy3JYmibO3yXVwUpf5KjeovNR0ghBUeRuQwiZRvGI/JCUbf1atn+ikRQ8AJqrE7K08qqH4zMiUXrW1dCP5IfVVs3HNFSr+FESaIioju7vE4/ad15dafa/BkwoWqF+FyhSa3MS9Er/zImEIt6gZdkdlPyJ7xNeJRCuQn8vOw+VkYFMEEBB7QUtAHZsJEHpljsjezGORCy8bRijDsb2mDtumxw0xA8FDjgI8+yGGqTv0nFMyeAS/9srQtNYn9+TmAPwm+KnxmBR85/XmUhIaVf8P0Pa4aiiWQKV91FEIhtTUlca2w3JO1mncyn10r7dQEsfSO0ydtWgXt4AXRyUHuC+SCCCkqCKOeUBEthi28OYjCyX9tpzRFldy1D4OEuzJxhJlML1DawhAmGLInVdacqjAE374Y1pue7eYNOxMFP5cILO4n2ud2fcZlrDtxz/+lyrazfityorbqe1ZEbhnM7+J6h+ijnSwzdRTJGttWmZNAeMIsQ38qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(366004)(396003)(346002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(36756003)(6506007)(71200400001)(6512007)(6486002)(54906003)(41300700001)(66946007)(26005)(83380400001)(66556008)(2906002)(316002)(76116006)(8936002)(91956017)(66476007)(66446008)(64756008)(5660300002)(8676002)(6916009)(4326008)(38100700002)(86362001)(122000001)(33656002)(2616005)(38070700009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk9nSzY0NE1uQ3ZjZTFVbDJvdUFpNXBrcjR6LzdFa3F4YlA1bWc5NmNFdGVH?=
 =?utf-8?B?VFpTWnRHNkl1VlNydEtvcHhuaVNGR0FFc2g0clBod21sTlAxOGVLN2FFaXA0?=
 =?utf-8?B?OEYrUWJGMEQ2L1o5N21xcDFFQkh6MzdDL2FLU2Z1eXJ0VDZQYk5qQ0tEd3g1?=
 =?utf-8?B?ZUJ2RlRnOXRGMzVUMjFMQUtuc1hSSGxRMi9Bem4xVExQNDEzV05PSlRON1Mw?=
 =?utf-8?B?MFBQRlNGbDNIYTJtNVRScFMvLzZVUEZaVGVnenp0aUd1YTgrQXpqeWVKand5?=
 =?utf-8?B?T1pwYzQ2TWxPejgrcGg5azE1enliTWVvUE1kV1J5WjRYSGtyRExQL2pWdVJM?=
 =?utf-8?B?dTlEak1pWDd4bGxmSXZQdWl2OFN4WlJoS3g3RndCdEM2dEJLenp5cjl1WXFG?=
 =?utf-8?B?bDE1TzZienFUdWNDb2JBRlhPVFl4cko4UjJLMmNpaGorbmxvZkdZR25scWxq?=
 =?utf-8?B?YVJrK0UxcDdmZTFxdkpWMWpab1hUV3luSjgvWDV4NzZRWTdKU0JZbHVuM2JF?=
 =?utf-8?B?MG8vWXo5VEFrdVFRTUJMREI2OExOOEpXaSt6dWFSak1yRU8zckFsL0MvNUFt?=
 =?utf-8?B?RmE2WTJuREJBNlFreHdTUlM3aEdSWUFwRVBJMDVLUmtQT2pNWmtWZ1U4ZUxM?=
 =?utf-8?B?KzJBc3dOOFBhVkdSYnB1UFhqWEswdHd5c3hQTFJ2ZjFzNkpGOVE4cnFqVWNX?=
 =?utf-8?B?aEdxSzZiWmRpM1pIOWdRK1ZZNlJiQmNaZDRqZVJvZllPekJFWDZOWTVWRFN6?=
 =?utf-8?B?Z1NGUU5IY1lBb1RBOGJxbUxIUVM3YmJDbVhGNGNGN0tGOXNvbnJzeG00TGR6?=
 =?utf-8?B?MU9adndnOENna29iNkNOWDAwNDd3SUZpU3BGbnN4M3RJS2dSOXJmekNrSjN0?=
 =?utf-8?B?MERoY215Si9LbmV5M21IS3RnQWF2ekNBemRmcXljazlkUVlxQ3l4a0txRVBs?=
 =?utf-8?B?SGFhaGZjMCtmMnNYQjhyQXlVbWE0TzdtWTIxL1lXZHVsZ0tqaHZ4QXZWM042?=
 =?utf-8?B?cnJHRngwQitvTGlNS1g2TjBjUC9UejhVR0plRWlYaFRONnpqa1E4eFBPaG9m?=
 =?utf-8?B?SE1neWV0MC9NTWFIOG0yYlBXN3V2NThMSnRMNW5mTkZqUmxEck82ZjgzS1Fh?=
 =?utf-8?B?UG9UVmovWisyV3ZvMTdMN05BclRENGhhRkJYbUlIQXdLSGowcjNjMUJMZEdV?=
 =?utf-8?B?ZWtIY0ZzYVlVVG1hT3RQRVRsQ0Q3a1ZXWERTYlc5dVJnKy9KU09mU3NCSDNW?=
 =?utf-8?B?V2pWQnNpSGpKQU42ZVFzbkE0cVZJdjlMcVpvOFZsdkE5R2pLVzhMdUdxc2Zr?=
 =?utf-8?B?ekc3K0lack1JVHNwai9nbFF2ZGt4MXJXS29IaVJjSXNlTUU0M0w4MmMvUkQ4?=
 =?utf-8?B?KzZodktJazhldzhFUXQwN0VEWDg3bXY4c01nTjN5dGFTWDVoN2tnZW5JU0Vv?=
 =?utf-8?B?aHVMcUt0ZExNRUJ1L2xtK1ZuV0dLNHdQbmx0V25ONDI2Qk5pSlN1RnVqanYw?=
 =?utf-8?B?YUszbkZWcS9rQVhBN05wSEtKNGl5UTNCUGFaVGRxRWR4NWlzMS90NEdsa2xQ?=
 =?utf-8?B?Nkh4dGhFY1VIQms0dmxVdmVKeWZZcXZqSEZyYlMvc2oyWGZIZU9qYUZkU3F1?=
 =?utf-8?B?YjBJbXkzbmt0YzlUTlNqaFUyb3NZdlQ1YUVJMDNoWEhxc3BOblpJQ09weE95?=
 =?utf-8?B?WHlPaEtGNThVWEFuajRoQm53WDRXYUlsQkJKRUMxZHZMUXlHZTlyaFNWWXNp?=
 =?utf-8?B?NzF2OHNsYTByRnozMmFjblFNU3lVaWFPSXo4OU4wV2ZTZXFNK1NxeFluaEx2?=
 =?utf-8?B?aUlIWW5FdTcrY09zckhUWC82cXhycDlDeU54Ukh4eFMzM0kyQjlYVTFkZ1pC?=
 =?utf-8?B?aWRNMVNtbmEydk05OExHVm9oa2ZURUN1Z2I4WGRJZlA5ZG1tdzNXOWtwWmpE?=
 =?utf-8?B?NjkrR2NNdkVNUFdnMlIwUktVaDd4YmN6V2MrSVFCSEo3TUNMUUo2ZGFHNXNM?=
 =?utf-8?B?bTNENHJwaitnd1hmbzE1MkRsejVDRlg2OE1XSXkzL1pBcDFHZ2trbjFFTnIw?=
 =?utf-8?B?TDZqTGo1THlqY3NkVGJNN3BQQ1Z4aTFhN1BSWFFZRDFHUnBBVi9CWWdvc2JQ?=
 =?utf-8?B?eE9TMmE4U2pVdXlIL2ZpTEhCTmljaVNWalo4UWtYTnNBaDAwakdSRUQ5anc4?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8FA8555EDA1E044944F1CD359C571E1@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3c290b-8762-4bc3-36f4-08dbd182b45e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 15:39:10.4819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxsWiNI7nxIqoQB8NALWFUjUB/15pNuZjZoxkdXR6wFQd0QWsWLROFuJXEmqWYr02YL321Fv5PziI7hh9FCWWdoZYeoIs02lgPWbL0Qbsgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5365
X-Proofpoint-GUID: W7oTtzoCGOEArOdwfSjJAzUFnUzxBteq
X-Proofpoint-ORIG-GUID: W7oTtzoCGOEArOdwfSjJAzUFnUzxBteq
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGFuayB5b3UgZm9yIHlvdXIgdGhvcm91Z2ggcmV2aWV3LiBBbnl0aGluZyBub3QgcmVwbGll
ZCB0byBiZWxvdyB3aWxsIGJlDQppbmNvcnBvcmF0ZWQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0K
Pj4gKy8qDQo+PiArICogQ1M0MEw1MCBBZHZhbmNlZCBIYXB0aWMgRHJpdmVyIHdpdGggd2F2ZWZv
cm0gbWVtb3J5LA0KPiANCj4gcy9Ecml2ZXIvZGV2aWNlLw0KDQpDUzQwTDUwIGlzIGEg4oCcaGFw
dGljIGRyaXZlcuKAnSwgbGlrZSBhICJtb3RvciBkcml2ZXIiIGluIGEgY2FyLiBJdCBpcyBhbg0K
dW5mb3J0dW5hdGUgbmFtZSBpbiB0aGlzIGNvbnRleHQsIGJ1dCBpdCBpcyBzdHJhaWdodCBmcm9t
IHRoZSBkYXRhc2hlZXQuDQoNCj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG1mZF9jZWxsIGNzNDBs
NTBfZGV2c1tdID0gew0KPj4gKyB7DQo+PiArIC5uYW1lID0gImNzNDBsNTAtdmlicmEiLA0KPj4g
KyB9LA0KPiANCj4gDQo+IFdoZXJlIGFyZSB0aGUgb3RoZXIgZGV2aWNlcz8gIFdpdGhvdXQgdGhl
bSwgaXQncyBub3QgYW4gTUZELg0KDQpUaGUgZHJpdmVyIHdpbGwgbmVlZCB0byBzdXBwb3J0IEky
UyBzdHJlYW1pbmcgdG8gdGhlIGRldmljZSBhdCBzb21lIHBvaW50DQppbiB0aGUgZnV0dXJlLCBm
b3Igd2hpY2ggYSBjb2RlYyBkcml2ZXIgd2lsbCBiZSBhZGRlZC4gSSB0aG91Z2h0IGl0IGJldHRl
ciB0bw0Kc3VibWl0IHRoaXMgYXMgYW4gTUZEIGRyaXZlciBub3csIHJhdGhlciB0aGFuIGFzIGFu
IElucHV0IGRyaXZlciwgc28gYXMNCm5vdCB0byBoYXZlIHRvIG1vdmUgZXZlcnl0aGluZyBsYXRl
ci4NCg0KU2hvdWxkIEkgYWRkIHRoZSDigJxjczQwbDUwLWNvZGVj4oCdIG1mZF9jZWxsIG5vdywg
ZXZlbiB0aG91Z2ggaXQgZG9lcyBub3QNCmV4aXN0IHlldD8NCg0KPj4gK3N0YXRpYyBpbnQgY3M0
MGw1MF9oYW5kbGVfcmVkY19lc3RfZG9uZShzdHJ1Y3QgY3M0MGw1MF9wcml2YXRlICpjczQwbDUw
KQ0KPj4gK3sNCj4+ICsgaW50IGVycm9yLCBmcmFjdGlvbmFsLCBpbnRlZ2VyLCBzdG9yZWQ7DQo+
IA0KPiBlcnIgb3IgcmV0IGlzIHRyYWRpdGlvbmFsLg0KDQpXZSByZWNlaXZlZCBmZWVkYmFjayB0
byBjaGFuZ2UgZnJvbSDigJxyZXTigJ0gdG8g4oCcZXJyb3LigJ0gaW4gdGhlIGlucHV0DQpzdWJz
eXN0ZW0sIGFuZCBub3cgdGhlIG9wcG9zaXRlIGluIE1GRC4gSSBoYXZlIG5vIHByb2JsZW0gYWRv
cHRpbmcNCuKAnGVycuKAnSBoZXJlLCBidXQgaXMgaXQgdW5kZXJzdG9vZCB0aGF0IHN0eWxlcyB3
aWxsIGJlIG1peGVkIGFjcm9zcw0KY29tcG9uZW50cz8NCg0KPj4gK3N0YXRpYyBpcnFyZXR1cm5f
dCBjczQwbDUwX3Byb2Nlc3NfbWJveChpbnQgaXJxLCB2b2lkICpkYXRhKQ0KPj4gK3sNCj4+ICsg
c3RydWN0IGNzNDBsNTBfcHJpdmF0ZSAqY3M0MGw1MCA9IGRhdGE7DQo+PiArIGludCBlcnJvciA9
IDA7DQo+PiArIHUzMiB2YWw7DQo+PiArDQo+PiArIG11dGV4X2xvY2soJmNzNDBsNTAtPmxvY2sp
Ow0KPj4gKw0KPj4gKyB3aGlsZSAoIWNzNDBsNTBfbWFpbGJveF9yZWFkX25leHQoY3M0MGw1MCwg
JnZhbCkpIHsNCj4+ICsgc3dpdGNoICh2YWwpIHsNCj4+ICsgY2FzZSAwOg0KPj4gKyBtdXRleF91
bmxvY2soJmNzNDBsNTAtPmxvY2spOw0KPj4gKyBkZXZfZGJnKGNzNDBsNTAtPmRldiwgIlJlYWNo
ZWQgZW5kIG9mIHF1ZXVlXG4iKTsNCj4+ICsgcmV0dXJuIElSUV9IQU5ETEVEOw0KPj4gKyBjYXNl
IENTNDBMNTBfTUJPWF9IQVBUSUNfVFJJR0dFUl9HUElPOg0KPj4gKyBkZXZfZGJnKGNzNDBsNTAt
PmRldiwgIk1haWxib3g6IFRSSUdHRVJfR1BJT1xuIik7DQo+IA0KPiBUaGVzZSBhbGwgYXBwZWFy
IHRvIGJlIG5vLW9wcz8NCg0KQ29ycmVjdC4NCg0KPj4gKyBjYXNlIENTNDBMNTBfTUJPWF9SVU5U
SU1FX1NIT1JUOg0KPj4gKyBkZXZfZXJyKGNzNDBsNTAtPmRldiwgIlJ1bnRpbWUgc2hvcnQgZGV0
ZWN0ZWRcbiIpOw0KPj4gKyBlcnJvciA9IGNzNDBsNTBfZXJyb3JfcmVsZWFzZShjczQwbDUwKTsN
Cj4+ICsgaWYgKGVycm9yKQ0KPj4gKyBnb3RvIG91dF9tdXRleDsNCj4+ICsgYnJlYWs7DQo+PiAr
IGRlZmF1bHQ6DQo+PiArIGRldl9lcnIoY3M0MGw1MC0+ZGV2LCAiUGF5bG9hZCAlI1ggbm90IHJl
Y29nbml6ZWRcbiIsIHZhbCk7DQo+PiArIGVycm9yID0gLUVJTlZBTDsNCj4+ICsgZ290byBvdXRf
bXV0ZXg7DQo+PiArIH0NCj4+ICsgfQ0KPj4gKw0KPj4gKyBlcnJvciA9IC1FSU87DQo+PiArDQo+
PiArb3V0X211dGV4Og0KPj4gKyBtdXRleF91bmxvY2soJmNzNDBsNTAtPmxvY2spOw0KPj4gKw0K
Pj4gKyByZXR1cm4gSVJRX1JFVFZBTCghZXJyb3IpOw0KPj4gK30NCj4gDQo+IFNob3VsZCB0aGUg
bGFzdCB0d28gZHJpdmVycyBsaXZlIGluIGRyaXZlcnMvbWFpbGJveD8NCg0KQWRvcHRpbmcgdGhl
IG1haWxib3ggZnJhbWV3b3JrIHNlZW1zIGxpa2UgYW4gZXhjZXNzaXZlIGFtb3VudA0Kb2Ygb3Zl
cmhlYWQgZm9yIG91ciByZXF1aXJlbWVudHMuDQoNCj4+ICtzdGF0aWMgaXJxcmV0dXJuX3QgY3M0
MGw1MF9lcnJvcihpbnQgaXJxLCB2b2lkICpkYXRhKTsNCj4gDQo+IFdoeSBpcyB0aGlzIGJlaW5n
IGZvcndhcmQgZGVjbGFyZWQ/DQo+IA0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgY3M0MGw1MF9p
cnEgY3M0MGw1MF9pcnFzW10gPSB7DQo+PiArIENTNDBMNTBfSVJRKEFNUF9TSE9SVCwgIkFtcCBz
aG9ydCIsIGVycm9yKSwNCj4gDQo+IEkgYXNzdW1lIHRoYXQgbGFzdCBwYXJhbWV0ZXIgaXMgaGFs
ZiBvZiBhIGZ1bmN0aW9uIG5hbWUuDQo+IA0KPiBCZXR0ZXIgdG8gaGF2ZSAyIGRpZmZlcmVudCBz
dHJ1Y3R1cmVzIGFuZCBkbyAyIHJlcXVlc3RzIEkgZmVlbC4NCg0KSSB0aGluayBJIHdpbGwgY29t
YmluZSB0aGUgdHdvIGhhbmRsZXIgZnVuY3Rpb25zIGludG8gb25lLCBzbyBhcyBub3QNCnRvIG5l
ZWQgdGhlIHN0cnVjdCBoYW5kbGVyIHBhcmFtZXRlciwgb3IgdGhlIGZvcndhcmQgZGVjbGFyYXRp
b24uDQoNCj4+ICt7DQo+PiArIHN0cnVjdCBkZXZpY2UgKmRldiA9IGNzNDBsNTAtPmRldjsNCj4+
ICsgaW50IGVycm9yOw0KPj4gKw0KPj4gKyBtdXRleF9pbml0KCZjczQwbDUwLT5sb2NrKTsNCj4g
DQo+IERvbid0IHlvdSBuZWVkIHRvIGRlc3Ryb3kgdGhpcyBpbiB0aGUgZXJyb3IgcGF0aD8NCg0K
TXkgdW5kZXJzdGFuZGluZyBiYXNlZCBvbiBwYXN0IGZlZWRiYWNrIGlzIHRoYXQgbXV0ZXhfZGVz
dHJveSgpDQppcyBhbiBlbXB0eSBmdW5jdGlvbiB1bmxlc3MgbXV0ZXggZGVidWdnaW5nIGlzIGVu
YWJsZWQsIGFuZCB0aGVyZQ0KaXMgbm8gbmVlZCBjbGVhbnVwIHRoZSBtdXRleCBleHBsaWNpdGx5
LiBJIHdpbGwgY2hhbmdlIHRoaXMgaWYgeW91DQpkaXNhZ3JlZSB3aXRoIHRoYXQgZmVlZGJhY2su
DQoNCj4gDQo+PiArc3RydWN0IGNzNDBsNTBfaXJxIHsNCj4+ICsgY29uc3QgY2hhciAqbmFtZTsN
Cj4+ICsgaW50IGlycTsNCj4+ICsgaXJxcmV0dXJuX3QgKCpoYW5kbGVyKShpbnQgaXJxLCB2b2lk
ICpkYXRhKTsNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0cnVjdCBjczQwbDUwX3ByaXZhdGUgew0KPj4g
KyBzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+PiArIHN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCj4+ICsg
c3RydWN0IGNzX2RzcCBkc3A7DQo+PiArIHN0cnVjdCBtdXRleCBsb2NrOw0KPj4gKyBzdHJ1Y3Qg
Z3Bpb19kZXNjICpyZXNldF9ncGlvOw0KPj4gKyBzdHJ1Y3QgcmVnbWFwX2lycV9jaGlwX2RhdGEg
KmlycV9kYXRhOw0KPj4gKyBzdHJ1Y3QgaW5wdXRfZGV2ICppbnB1dDsNCj4gDQo+IFdoZXJlIGlz
IHRoaXMgdXNlZD8NCj4gDQo+PiArIGNvbnN0IHN0cnVjdCBmaXJtd2FyZSAqd21mdzsNCj4gDQo+
IE9yIHRoaXMuDQo+IA0KPj4gKyBzdHJ1Y3QgY3NfaGFwIGhhcHRpY3M7DQo+IA0KPiBPciB0aGlz
Pw0KPiANCj4+ICsgdTMyIGRldmlkOw0KPj4gKyB1MzIgcmV2aWQ7DQo+IA0KPiBBcmUgdGhlc2Ug
dXNlZCBhZnRlciB0aGV5J3JlIHNldD8NCg0KVGhlc2UgYXJlIGFsbCB1c2VkIGluIHRoZSBpbnB1
dCBkcml2ZXIsIHBhdGNoIDQvNCBvZiB0aGlzIHNlcmllcy4gSWYNCnRoaXMgaXMgbm90IGFjY2Vw
dGFibGUgaW4gc29tZSB3YXksIEkgd2lsbCBjaGFuZ2UgaXQgcGVyIHlvdXINCnN1Z2dlc3Rpb25z
Lg0KDQpCZXN0LA0KSmFtZXMNCg0KDQo=
