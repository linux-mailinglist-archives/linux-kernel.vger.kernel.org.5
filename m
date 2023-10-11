Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23E57C501D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjJKK3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346288AbjJKK2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:28:55 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2048.outbound.protection.outlook.com [40.107.9.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8523EA7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:28:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpcvjIYxZq+npz93kQp2nz10yMMNN+1DdI8/8O/DVecOHvNWNCo/PSkcq+RffuJFHf5ZJrXQQFdVaNBUtX75CPTUnxvucW9Ok8bRmvNvefjPeOKb8Mn6Y7xDtvRG9hUwMvTK6dbLeHJFHtf/9UttdmkFcs6yT72rmG36r0YgVDfoSdCXS88Pzr8SmQb7Pj+A2XZlt1QIQiyb92fhEsqXDADZ7tIYonpchdo4lmOVVZ+rvqR70wBUK8YFiYsHhJowZolnHA4oIzSGNsEZ088dMrpj/1vopzpPg0OU78IQsPYbqEZZMHn04jETPJctw/ngMW0p/Z7sNgrbROL1zAw++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfZUDp3eUzKNK25OEX7aiCgG+uJEcmJCF53KVXuztSg=;
 b=NteqGHOobAUw1SdfRDxQWRtKarwkfugcc/Xfijf1mo8damNiRUXF6K/5wu7Tl+KJ1NObsLRn1yiUx4rUtrGRBzXtH4sa8jocSjo14/jzEy1s5GH5ZdftRrVF4pAn/KnyRVOjqBpSYyuP33gQe3PmLz8FLoxQXKEfAloIagukkwL5/z7IYlF/TF61f8IwKePkDYCDKair9IkUJCzVWaoz8D/JIVvYuYsSaW0X3ZDa44Jj0B5ONrykohTcq5LIGQLCijp2cfCnOFuCgpVDvJbXb5vlEhGis8ZsVjknt35fAunUVbAyjDPYCpX+fyTv5BMIOKZH7doaan/jnrLHS0fMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfZUDp3eUzKNK25OEX7aiCgG+uJEcmJCF53KVXuztSg=;
 b=dymtU5DxhbsEUS5QdTaJ5kZDWFECz/F9zeRVVO4zPSefwu/jWlatADWl5G4t8ZgyIv9AZfv4UDicAjAnPWjU8BUS2ZUYRx6ucp0R+Za537SdadJvyIP8FUyJOXZBgEpXZMgpxi8ickl3QMKM65cCi0PAKdZ5APakNJquyydKzTYsyNklcXD5cGn3efXNPMzd70GOfOfJ2NdUhtbuIvfmtViLddiVUxH1pODES9U8TpS3B2gIc8fJovlpWLbzLfa+DmdrittN8dztlNIcDZnmswKSg5IBcKFpVYHwa4/DopZFA5rpEqyERW0fe//eFksN8ZtbORTngZ1OLPGixVD9Wg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2195.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:14::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 10:28:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::165b:8c64:6165:9049]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::165b:8c64:6165:9049%3]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 10:28:49 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Dmitry Safonov <dima@arista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 00/23] Add generic vdso_base tracking
Thread-Topic: [PATCH v3 00/23] Add generic vdso_base tracking
Thread-Index: AQHYM9OLTa3qCxlr+U+sdKEFqnRDQay5IPoAgP3QdwCABu+ygIKKEqYA
Date:   Wed, 11 Oct 2023 10:28:49 +0000
Message-ID: <03c19f3c-da74-26f2-c29e-226c870bce3b@csgroup.eu>
References: <20210611180242.711399-1-dima@arista.com>
 <8bba9ed8-ae1f-7c98-fde5-808927935447@csgroup.eu>
 <6b2513db-7c31-8da4-38ec-0b9898c6589c@arista.com>
 <ad912d91-c6e8-12ab-f309-d52b8cd9a92a@csgroup.eu>
 <4e46e053-5240-aaa1-91c7-7aabdc7a2db3@arista.com>
In-Reply-To: <4e46e053-5240-aaa1-91c7-7aabdc7a2db3@arista.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2195:EE_
x-ms-office365-filtering-correlation-id: 9629cfd6-4f85-491a-d359-08dbca44db8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oxo4hxjxLwUtjclfutFOosrPoChog4AiMx9kAT/qGFcsMbRp4hOlYIkCgwjGWQ1jWpLyDJm0fC0HQ9K0KYdbku8fK5u3JFxmoMf2U6YUQoJuvn6B1Oq4p/eh+5dSMYAhNNJHksiFvcD0+LcHYJrJJ51KE+XtPm5cW/mafaRknTSu6yx8B4xuWt2ufFLRJj5I4rBP1TEKdUar2kmlaezUh+MixHALFPtTQ067b6qT3jbMKzCsdt4RoTo8iVdBW4BULz5BmAE0HE8F40W7thkDmfu5JqYH8Jxsz/LQHakpQMjnZPixfAiNsKUdgraAuCKefc2zin6EGMMKaICUAog3rjV2QVbtKbwT/SHYrhgS1x9UhYGE+vGIfX6gAAC+CAseqPJMNeBJ1B2Jj+JQcGfmQ+SeZjSWiUofPlmij2NHLM1s15X9nXo5haoNZqYeYi7D1RU1ISBa+7a2B9qscz5p6oharzlSI+lhlJx4sv1YeCK1k9V8XwFivxqaFDXMxgJig50MwC/2SELmD0EV9UVWmEfIX0yZk8dQLyI33mZR/mf/hmOBgRq9dyw3l2h7k/4QjbO530s4PoxtLexjIeWs98P5HSgqEkwJm8B97XknB3E67A4jg88bpPnjWJ877roeSgWhkHoeDBZkMqrnrUX8z8zQm8/tbkW8nPe13Ds7c1uhJ0Gl3nuZWWSAcAGDLxktCjwJWXmkqljZsdSQo5OisA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(366004)(346002)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(53546011)(2906002)(6506007)(122000001)(6512007)(38100700002)(26005)(36756003)(5660300002)(44832011)(41300700001)(86362001)(8676002)(8936002)(4326008)(6486002)(316002)(91956017)(66476007)(64756008)(66446008)(31696002)(54906003)(76116006)(110136005)(66946007)(71200400001)(66556008)(31686004)(4744005)(478600001)(7416002)(38070700005)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWJ1Q2xmdFNhM0daYXNVWlhuL0NUa3lYUzJEZHpVTmtXUFNRd3BhQ0UvaUZQ?=
 =?utf-8?B?YVFDOEovdHlzTHJqZUxDYkpXNUQ3YldTc0tMVEtvbTZBanZQVmFCRTR2YTJ0?=
 =?utf-8?B?aGRyYmNBQVVLK1VoRHp3aVdaUVVPUmRzRHRMbDNoU2lDU0twNHh5YTM2aFpx?=
 =?utf-8?B?U0VCSFBhSlRXcDB2VllLTW5vQmYwTFZUK29sdDhUWGF2UURlQVZkcVgzSWFz?=
 =?utf-8?B?R2pOd04wSERJQXpuK2tpRWduMFlBYUhsc1B4dy9qbmhaUUMwRDhsOVBKcWpD?=
 =?utf-8?B?cU9Ia0NWRGZtdGxoa09EeVRXd1BrcnRBd0ZWLzE5NFJVajNDUW00SmxSc1Fi?=
 =?utf-8?B?VDdKQ2Z4QmtMWHRpcEM4cUIvZDQzWk9FSmh0SVE4ZW9pNzhFeGtCYk5UREhS?=
 =?utf-8?B?MytGSzhTd2RCZ0I4THJpdzVSc05OaWhxMWt5Z3ZGTzFVc1R5d1ZJcFpTVjVn?=
 =?utf-8?B?ZTBRWXliOW5Yb0czWXR4eUQyRy9sRGc3SWtQeEhEVjJsSDVqYVhCOXBIeklD?=
 =?utf-8?B?b2RqU2RMMldBeVJ4WXVSYmo5azltVG9tUmNBQXBCRkd1anBLZ3hKMXhzQlpr?=
 =?utf-8?B?ckhaNEswU2swbHhrdlpRMHhZVFJNT2xKMHRFVG1QZlJnaXFnVUlVcnA3YVlT?=
 =?utf-8?B?M0dXL1QrNzMzdExtbzBDMmZvb0dTUkU3SFN5SWJpR002bjViei9DVk1wM241?=
 =?utf-8?B?emtuRFBHUER5WEJndlFFM0NSc3pNWElMOXBoKy9hbGFZVmxyVE8reC9ZVFdC?=
 =?utf-8?B?SWcyWmN6TW9MWjNReTVsMXFPY0xocjlXQko4OHVIVHpDazJ2TTROelk1TXVH?=
 =?utf-8?B?RGtlU243WFkrWnlWK0hxdmx2M1RRSTJYM2tVZkM4TXNCaE4va0d3TkhpRmN0?=
 =?utf-8?B?VEFXZlVvQ3RZSVd3UVp3RnQyK2pWdFA0L1Q3Ni9LQXZxTVU5QS8wVHJhZk5i?=
 =?utf-8?B?Vjd1NThTTjhvdUx4eS9QUHBtbGdzNmFOd1dvVnZNU05DcDJ0NjVWdzRxNTNG?=
 =?utf-8?B?eDBpdWxoU3E5ckhqMVNqTWd0NFp5a0xmUmF5SThtQW9XYWVEWS96LzNvWXZB?=
 =?utf-8?B?RlU2Z2MwWmlIUll0bjN0SjBsUW5ZUW1mU2N1VHdnS3N6aDgyYWNTMms3YVNK?=
 =?utf-8?B?WUtOQlg0UFJJTlFETXMxandYaUdaeFd0Mm5hbnNOK1lESE9LaEFPcGRMK2dK?=
 =?utf-8?B?Zll5U1BNdnh6U1c3VWthN0ZMUFRhN3k0MG9rcDkxdXk5ODZVTm01UGNCajl6?=
 =?utf-8?B?UGZicUNrd2hUUlkvRmh0Wi9qcVJBMUdRVEhwQzVjek9peC9CTTBKbzdPWVU1?=
 =?utf-8?B?cjRYU2VpaExETUt3R3B5UFhXNE50cjBGMm5uRXpLN1BPYU1TSENyUVdXK2Ex?=
 =?utf-8?B?MVBMUnI4Nm9UQ0xRbDhSNlc5NHJRbHljT0RCS1hYc25ybkFsSllucmdaamR1?=
 =?utf-8?B?S1lYeFdXMDh2aE10VERPNG1wWnFyYmtSblJtY1QrYUlJdjN2RVhVODlyeU9J?=
 =?utf-8?B?TURVdk9rbUczQ0xXdTNvOUlJT1JDbFJpTE5XeWkwYzVGTFFnL0dXb3Z0ejUw?=
 =?utf-8?B?RllJeTFXd0RpUUtqYVo3azlZS0RMYlZGZ0lWL1pXVzhBYm9OTi8yVVFCNHJB?=
 =?utf-8?B?OVNzTDVqeEQ1bFNVTXBXdkhZeUdMLzhxaGFad2pqQ0cyeWRUNW1hL3grdW5u?=
 =?utf-8?B?bHZKVG9HRk45anBaUEpHR1g0TDI5aFZvT2VENFVyMjMvc3NBSGREMHo5aFZ2?=
 =?utf-8?B?UGRMdFVZV01RYVR6U0hjWVRMNmEvMTZheStOcUpqSnJ6WllLUGFTQ2Irbmta?=
 =?utf-8?B?Z09iSVllcHRRL0JlZUQveSt0aW1GR0VFUlY3NHRQclpDSnk0VlBteThHRXpL?=
 =?utf-8?B?R3oxeGZuUDdBSytjMXpvR0RCV0VWREpVUHpWL0dYUzN1bFhsbmZZdGVoZFA1?=
 =?utf-8?B?eFRYZDlDcElWam11alRFTDFEOXFxaTZCQm0vdTcrcW9oMkxGbThveUF2Nmdo?=
 =?utf-8?B?T05NeUdGR3dJWUtRSHVUSy9CdHdhSXkzb09OeWE2aHlWcHBVZ054R1doeGN5?=
 =?utf-8?B?eVNmdlFMQzRXUkxlcUVyaHBJS01tK05uZTJ1VlhFRUhsNnBoVFkycDRaekJ3?=
 =?utf-8?B?MmQ4K0xDc2NETHpad3JhZVByZjZMeHJKcVRXRkk0WEpFeVhUdW9oSlUycE5E?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E1B645705115F409A75C687D3114AF0@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9629cfd6-4f85-491a-d359-08dbca44db8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 10:28:49.2312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dme3tG9O0+xUFiA4riBogTy0WwL0xkx5kEwi3NXzsXUu+VBzNKvdg9In64ja7O5vlxNAGDjzkOSgvUXTgLl/k0AnyHw3KRlXRtjY354sI8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2195
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KDQpMZSAyMy8wOC8yMDIyIMOgIDIxOjEzLCBEbWl0cnkgU2Fmb25vdiBhIMOp
Y3JpdMKgOg0KPiBIaSBDaHJpc3RvcGhlLA0KPiANCj4gT24gOC8xOS8yMiAxMDoxNywgQ2hyaXN0
b3BoZSBMZXJveSB3cm90ZToNCj4+IEhpIERtaXRyeSwNCj4+DQo+PiBMZSAxMC8wMy8yMDIyIMOg
IDIyOjE3LCBEbWl0cnkgU2Fmb25vdiBhIMOpY3JpdMKgOg0KPj4+IEhpIENocmlzdG9waGUsDQo+
Pj4NCj4+PiBPbiAzLzkvMjIgMTU6NDEsIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+Pj4+IEhp
IERtaXRyeSwNCj4+Pj4NCj4+Pj4gSSdtIHdvbmRlcmluZyB0aGUgc3RhdHVzIG9mIHRoaXMgc2Vy
aWVzLg0KPj4+DQo+Pj4gWWVhaCwgSSBwbGFuIHRvIHdvcmsgb24gdjQgYWRkcmVzc2luZyB0aGUg
cmV2aWV3cy4NCj4+PiBXRkggaGFzIHF1aXRlIGFmZmVjdGVkIG15IHdvcmsgb24gc2lkZS1wcm9q
ZWN0cyBhbmQgSSd2ZSBsYWlkIGFzaWRlIGZvcg0KPj4+IGEgd2hpbGUgdGhpcyBwYXRjaCBzZXQg
dGhhdCB0b3VjaGVzIGV2ZXJ5IGFyY2hpdGVjdHVyZSBhbmQgaXMgYmVzaWRlcw0KPj4+IGEgYml0
IGNoYWxsZW5naW5nIHRvIHVwc3RyZWFtLg0KPj4NCj4+IEFueSBwcm9ncmVzcyA/DQo+IA0KPiBZ
ZWFoLCBJJ20gYmFjayB0byB0aGUgb2ZmaWNlLCBzbyB3aWxsIHNwZW5kIHNvbWUgdGltZSBvbiB2
NCwgdGhhbmtzIGZvcg0KPiBwaW5naW5nLg0KPiANCg0KSSBoYXZlbid0IHNlZW4gYW55IHY0LCBk
aWQgSSBtaXNzIGl0ID8NCg0KQ2hyaXN0b3BoZQ0K
