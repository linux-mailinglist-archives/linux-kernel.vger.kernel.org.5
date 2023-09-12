Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34C79D4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbjILP1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbjILP1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:27:23 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2058.outbound.protection.outlook.com [40.107.12.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2C610E2;
        Tue, 12 Sep 2023 08:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1MRTXgitYvIDJ1fplQx45kggFT+UnDiBnf67NMNFNadXiJj8PEG7ECd10hxaWYFD6Jz8Ivg1NZS5esYAxbz9jvbKoxIe1KBL7cMp2fz1ZiUrJI3awDXIIQnZ4jnoKIIULzx7hXFsLDbsL5Yb/txg/KthW+IKt0eF6sp3vnZLuUol1U/bKsDV76YeXBIY5vnXqBtyTixTgZVJs6Vghgby4ROQnQotW2RFt2OKS+4ceW99GdMIIMIjFYcyAUQi9UC8F8ay7gF+eZp/T8RETh8tSeo81ImdBiclJIfJ994+mAaATo+tikdngi0Xyt+oPAsS9VonJUNsWGHT3G1axlVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1/2exobiyg+SZBbavBE4x1Zd925PXMYL37SY0qACh8=;
 b=eW3g4O9av5K2LV4w+YT6EjwyPkNWA12Tq7DUvbwGuFdEod9zrdONLwIT2Le1jeKzQkjUQbOqIWxtd5SiD38LqoAilLIBHNuyP3oXT7+EyS7snxNtE7Y7YdQrIwlmeEb6feBqXf2qvToXT5kp7NF620gjWpCsUwKzJ6w8dW84Y8spo0bSml5wuLjCO3UIotEIwFURPiPeH2FauHHGI1yMoEnd5rQ/ZRh+hwLpu6WKBCj7n70EckdUwAAttpcID/jRxdacD2LAUnHFgmxIpZaTj+XH1+/OwRVKuHR/otY0zodqfYsBrOG2BxVHSJJyJr0268eJLsbElhG+ch/858f9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1/2exobiyg+SZBbavBE4x1Zd925PXMYL37SY0qACh8=;
 b=XFfte+8yoQ/SfRXh1gIACSWL2MvmYa8mPgSHMbA1p/3XkpDVwsustvn8Jbckh/i7vh5oU8P2qyANAxz5S1BiIKjrXs2w6K/c+DIp23+gKUaMwjEjTeAa18s8dv0g6KHEDPDAv7i5aGg6wX+xXsCdoN+leCCu0AbipRB0bfiFvCDujS++yrMjFlrQiN1WI8kFUdD8PxkpVCm3jeJHxCRrzd1OrFeJ5NCV6NXxzkJUAAdr5a3YcpNPRVLqTMKqsenNYS33tbtYQTHq1kvV37vYbH4jLpiHdaAHlKMSxlBTzgKnxWEgVNQtjMwvaPTRRNLUd7HzrdjzfH+I0TBFLuryRQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3292.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 15:27:17 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 15:27:17 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Thread-Topic: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Thread-Index: AQHZ0jZLGonsLT7psk6V57DL3sI7p7ABi0MAgAx8eICAACGXAIAAAcAAgAAJOoCACD39AIAAi4MAgAACooCAAAHPAIAAAUwAgAAX4ICAAEH3gIAACUgAgAAK+ACAAAUqgA==
Date:   Tue, 12 Sep 2023 15:27:17 +0000
Message-ID: <93aadecb-3c9b-6b0a-9c8c-2cc46bdd3955@csgroup.eu>
References: <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
 <20230912135617.dnhyk4h5c555l2yg@revolver>
 <20230912142930.xdautl7cabb67nap@revolver>
 <3f2e6497-ac8d-4da0-b677-c8a3975b6189@paulmck-laptop>
In-Reply-To: <3f2e6497-ac8d-4da0-b677-c8a3975b6189@paulmck-laptop>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3292:EE_
x-ms-office365-filtering-correlation-id: 2201bb95-7b1b-491e-0163-08dbb3a4bf6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b3wFCcGFMvAjzo2WVNpP2mRMqZCHIYeg3J1Ei0lKhMfGyJzWQW1ySGBJbYxH5LpkUyXpFrvu3lZ0bku6kFwHO1fnRDufP/s+eskKXuSzGrcfu765XHK7kJ5A/LcFpCzgFvEbXkClV4V6s257nGl5S+ihj/tmWaN9UJHRzKtw82BNrge4msV07eN4d/mwiebwAsNFi/ddp0YlfvHtM/Vj/xa5bOnB6WLC7akMYTHIwG1jJ8FuHJeWTM+4P/xezriBhOPCDLKJ2dyhlTJZUohT+iMGJkb9/junSsEjarXRCyWDLvV5SBkfIYPVadO1M50ofNawkPIWqZdGKvl1aba58kt08lic3NBcHmbM9DGDbY0C5nYTWH/qvj+8CDleOYlfqvenQNAGAC93ys0vhS7K+Amcyj9WQcWiIV5z8n3ivWLictUtiq7Rzij1qZTsPqbQYOGKirSfCcV0CisZON33LlJAR0P1lIysCrBs1qNqZ+/mJ1Z+gNkXsI+9FIp1GkPRPZ26GVcgI9BR9/8x4yH41cBfkvcyo7G5+9kKBa4SPLuGC1FQOtow3EJ4wv8uAMfL9AbWkTf+sjqENIFfALmLWbUTjGUhsfNpGD1OjwmtGyiQccdqdATMCthrfODdJdvnMZhP70Y7TopkoQwre5OOs1G+lc7thD4EdU80k4jPx33Z0x8cfzffPH92KW4F8vEH6k6FeD4E1Rpqdn+7HRM6jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(366004)(346002)(396003)(186009)(451199024)(1800799009)(6512007)(7416002)(31686004)(5660300002)(71200400001)(53546011)(6506007)(6486002)(26005)(478600001)(2906002)(2616005)(44832011)(83380400001)(8936002)(921005)(8676002)(66946007)(41300700001)(66574015)(122000001)(38100700002)(110136005)(76116006)(66446008)(66476007)(64756008)(38070700005)(36756003)(316002)(86362001)(31696002)(91956017)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bitIYnlsQWlDeFo0TDF0UFI4Z29TUG5LdmpQY2JkUmQycEZQRGVGUkdNSGVX?=
 =?utf-8?B?ZUh0ZFU5NkhlMVoyOUtvL0U2UzBxaXRqUlB0YkNYOUZQWlVkYlZMcE8rZTBh?=
 =?utf-8?B?bXhEQUtxVUVWaTJoMGdrUGVvcmZ5SlRHM3pmeTA2TE5HSGhlUlJZbTVUN05F?=
 =?utf-8?B?RTQyNVozR0pJU3Y2TjNGRUhyYlZqQTZnODdTNFJJQUYxdCs5WVF4eEh3UXJS?=
 =?utf-8?B?aXpwUlAyVFMxWlRhMlI4WWRtUGJNSFovaWRZaENack1hQmpOM3NhLzcwSGhR?=
 =?utf-8?B?akhJSWVXbkN6NElxcm1aTDRJWU9XNWpkZVY1dklURGlXeU4rQWV2SE9MUGds?=
 =?utf-8?B?TDZrcXovVi8zbk1ic3E5d0M5VkpGRms4RTRaYzdpOUYzSXpuU3NYYXpWNDgr?=
 =?utf-8?B?WUsyVDFBNFJJMFplQisyU1UyTzBHc0VaT0xoNTE5ZFI2K08zYVI2YVh6L1FT?=
 =?utf-8?B?ajJ0MEFNOFZyQjZvSEs5b3VHdzRCS0VpSGdlUTRkanNMb09oZ0ZOOEFzMEJk?=
 =?utf-8?B?bGlmdHZrRThwKzQxZ0VkQzJEc01tWWFGZFlxckkwb01LaGdnZlQwRldDVlhP?=
 =?utf-8?B?TFUzL2NSTEpKeEZyYUI2NE5GYzQxb3BpL1FSL05XdHJTYVkxK0ZkVjRmWlRQ?=
 =?utf-8?B?MmJSOXJaS042M3d2MGZxRUFTRnFDRnJxZUJjZC9GYlJrQklYV050M1ljRWtF?=
 =?utf-8?B?VnozTkMzYlRObElkcEtpeDBkMFMwOERiTWpKc1AvVDhTRTRIWGwvNktnK0Zo?=
 =?utf-8?B?ak1DOC9tWUdWZDJFdWgwUVZaSk1qTHhmRDJESEFaL2swaDNhL2tyZG0wQUZB?=
 =?utf-8?B?eEhtREY2cWdpMEloUXdha3lJOElBY004NFRMWlo2d3JvSXVTUmh5WjVpTjZE?=
 =?utf-8?B?bU42cmtLMUplWUdtU1dBUERId013NEYyVkJoZk9tS2VZb0gvZGMvU2JGem1X?=
 =?utf-8?B?OWJXOTM2VkU0ckx6TXRMc01ST3gyTk5WYU9pbkZaMFNsRG9zTmNCK2VoMkVN?=
 =?utf-8?B?T3NNTVhSdGkvbzRWUkd4VkdvelVTbWZQMWdFdzlNM1JBaG14YkJwR1N2TThQ?=
 =?utf-8?B?OXRweGpUSzZJaUtmRUJmY1NkN0JTM2xlUlNHdW5UWEl5STQ1cVRULzBmay9F?=
 =?utf-8?B?WTFUVXFldDRuYzZteGZXRmR5dGJNbk1GYUZQY25idUZuVjVkLzlraVcrZHl2?=
 =?utf-8?B?dkRyTmR4enhvUERpVEZ4YXVPbmxldHhKazRsRHFKbENPb1pSWE9ZZm9OK1hC?=
 =?utf-8?B?bHVpVjZoYzE1NGsvNkNSYXVyNmxPbEdCenFKd2d0clV4b05XS0g4K3ozM2RD?=
 =?utf-8?B?TWJ0K1RsaGxreUNiVDZTQ0ZPamxHSEhGRTBQZEpzSnpPeTBCUVlmOHhPZkxN?=
 =?utf-8?B?TUhLZStNNS9KbXc2eVRzYXAxbGtrWExScWF1Y1lScUR6akhZY0RDeGFVTlVu?=
 =?utf-8?B?ODU3bVQxc29neUlKQnVGdm5uRWdGQjc1M2Y4VDVFWit4N3lhRW1TNE00WUVP?=
 =?utf-8?B?eW9vZ3dRTUxpVzUrN0hnTjhjSk92eXljYktSWUphN2NiWW9ya08rYkRxbVQy?=
 =?utf-8?B?RCtYeVRuemdzbTNxVlpYc3QyKzJDeTFpeXE0eGV0eUZGSXQxQUV2aXF4bWpO?=
 =?utf-8?B?K3A3cFVwWmNSN1BoYXhaZjdqT2VvSmJaZUJodUxIVHV4bG5jczVudmcyNG1S?=
 =?utf-8?B?WnA2QmhwK1J5bDhVVnM5TGZ1azN5SU44bytRQUlrUXg1MEdrdkptdEdKQmhG?=
 =?utf-8?B?eVF4RklWUlNVWkhrbHNUVHNVV0FMRDVmMUhNbFZlcThBMTRMR1dzM24wRENO?=
 =?utf-8?B?OXhrWEpYZjB6Y3VLWVJIT2k3bkt2NkcvNjVld0N6cnp6eHBuTVNDR2hrWStB?=
 =?utf-8?B?cGRybEZxYm81dHNnTitJeEp2L0JBM0dXTnlsV1lSaHE1RGRVc1lwanErSm1l?=
 =?utf-8?B?VjFaQlVuMW03aVpnb25qeEY0dUhWR0FBdllYM0lqbmxDbjd1czVQK0NYNjdT?=
 =?utf-8?B?WFdGNjN3cDlwRWhkV2l1NjluMFNHbHRRYnJZd3dVSmswSzlKc0N6RWlKQTBh?=
 =?utf-8?B?M0VoWDQyTlVKbkF4enhNQjk3NnlWaDBITHQ3K0dqRDJQOExyck1JenE2dnRj?=
 =?utf-8?B?TTI5Ty80VEU2emwzYXFMVXpNTXFMVVU1MGtibEpiSjBYUnJMOEhnbUNKOFVB?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69E0DE2886D15A48BC0640C28D944ED9@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2201bb95-7b1b-491e-0163-08dbb3a4bf6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 15:27:17.0675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGad1+GWp3LcfTzjgajPzenpNyvzZZAem3qipB54b66BCBSopae9ESHqaRSCjVkpa9F3ddDXeq2E4Mm0kBf23Am6mmNZ7WnGANXTrXvp47U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3292
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDEyLzA5LzIwMjMgw6AgMTc6MDgsIFBhdWwgRS4gTWNLZW5uZXkgYSDDqWNyaXTCoDoN
Cj4gT24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTA6Mjk6MzBBTSAtMDQwMCwgTGlhbSBSLiBIb3ds
ZXR0IHdyb3RlOg0KPj4gKiBMaWFtIFIuIEhvd2xldHQgPExpYW0uSG93bGV0dEBPcmFjbGUuY29t
PiBbMjMwOTEyIDA5OjU2XToNCj4+PiAqIFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVs
Lm9yZz4gWzIzMDkxMiAwNjowMF06DQo+Pj4+IE9uIFR1ZSwgU2VwIDEyLCAyMDIzIGF0IDEwOjM0
OjQ0QU0gKzAyMDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4+Pj4+IEhpIFBhdWwsDQo+
Pj4+Pg0KPj4+Pj4gT24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTA6MzDigK9BTSBQYXVsIEUuIE1j
S2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4+IE9uIFR1ZSwgU2VwIDEy
LCAyMDIzIGF0IDEwOjIzOjM3QU0gKzAyMDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4+
Pj4+Pj4gT24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTA6MTTigK9BTSBQYXVsIEUuIE1jS2VubmV5
IDxwYXVsbWNrQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4+Pj4gT24gTW9uLCBTZXAgMTEsIDIw
MjMgYXQgMDc6NTQ6NTJQTSAtMDQwMCwgTGlhbSBSLiBIb3dsZXR0IHdyb3RlOg0KPj4+Pj4+Pj4+
ICogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPiBbMjMwOTA2IDE0OjAzXToN
Cj4+Pj4+Pj4+Pj4gT24gV2VkLCBTZXAgMDYsIDIwMjMgYXQgMDE6Mjk6NTRQTSAtMDQwMCwgTGlh
bSBSLiBIb3dsZXR0IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4gKiBQYXVsIEUuIE1jS2VubmV5IDxwYXVs
bWNrQGtlcm5lbC5vcmc+IFsyMzA5MDYgMTM6MjRdOg0KPj4+Pj4+Pj4+Pj4+IE9uIFdlZCwgU2Vw
IDA2LCAyMDIzIGF0IDExOjIzOjI1QU0gLTA0MDAsIExpYW0gUi4gSG93bGV0dCB3cm90ZToNCj4+
Pj4+Pj4+Pj4+Pj4gKEFkZGluZyBQYXVsICYgU2hhbmtlciB0byBDYyBsaXN0Li4gcGxlYXNlIHNl
ZSBiZWxvdyBmb3Igd2h5KQ0KPj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+PiBBcG9sb2dpZXMg
b24gdGhlIGxhdGUgcmVzcG9uc2UsIEkgd2FzIGF3YXkgYW5kIGhhdmUgYmVlbiBzdHJ1Z2dsaW5n
IHRvDQo+Pj4+Pj4+Pj4+Pj4+IGdldCBhIHdvcmtpbmcgUFBDMzIgdGVzdCBlbnZpcm9ubWVudC4N
Cj4+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pj4gKiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0
QGxpbnV4LW02OGsub3JnPiBbMjMwODI5IDEyOjQyXToNCj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgSGkg
TGlhbSwNCj4+Pj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4+PiBPbiBGcmksIDE4IEF1ZyAyMDIz
LCBMaWFtIFIuIEhvd2xldHQgd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4+Pj4gVGhlIGN1cnJlbnQgaW1w
bGVtZW50YXRpb24gb2YgYXBwZW5kIG1heSBjYXVzZSBkdXBsaWNhdGUgZGF0YSBhbmQvb3INCj4+
Pj4+Pj4+Pj4+Pj4+PiBpbmNvcnJlY3QgcmFuZ2VzIHRvIGJlIHJldHVybmVkIHRvIGEgcmVhZGVy
IGR1cmluZyBhbiB1cGRhdGUuICBBbHRob3VnaA0KPj4+Pj4+Pj4+Pj4+Pj4+IHRoaXMgaGFzIG5v
dCBiZWVuIHJlcG9ydGVkIG9yIHNlZW4sIGRpc2FibGUgdGhlIGFwcGVuZCB3cml0ZSBvcGVyYXRp
b24NCj4+Pj4+Pj4+Pj4+Pj4+PiB3aGlsZSB0aGUgdHJlZSBpcyBpbiByY3UgbW9kZSBvdXQgb2Yg
YW4gYWJ1bmRhbmNlIG9mIGNhdXRpb24uDQo+Pj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4+IC4u
Lg0KPj4+Pj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiAuLi4NCj4+Pj4+Pj4+Pg0K
Pj4+Pj4+Pj4+Pj4+Pj4gUkNVLXJlbGF0ZWQgY29uZmlnczoNCj4+Pj4+Pj4+Pj4+Pj4+DQo+Pj4+
Pj4+Pj4+Pj4+PiAgICAgICQgZ3JlcCBSQ1UgLmNvbmZpZw0KPj4+Pj4+Pj4+Pj4+Pj4gICAgICAj
IFJDVSBTdWJzeXN0ZW0NCj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgQ09ORklHX1RJTllfUkNVPXkNCj4+
Pj4+Pj4+DQo+Pj4+Pj4+PiBJIG11c3QgaGF2ZSBiZWVuIGFzbGVlcCBsYXN0IHRpbWUgSSBsb29r
ZWQgYXQgdGhpcy4gIEkgd2FzIGxvb2tpbmcgYXQNCj4+Pj4+Pj4+IFRyZWUgUkNVLiAgUGxlYXNl
IGFjY2VwdCBteSBhcG9sb2dpZXMgZm9yIG15IGxhcHNlLiAgOi0vDQo+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4gSG93ZXZlciwgVGlueSBSQ1UncyBjYWxsX3JjdSgpIGFsc28gYXZvaWRzIGVuYWJsaW5nIElS
UXMsIHNvIEkgd291bGQNCj4+Pj4+Pj4+IGhhdmUgc2FpZCB0aGUgc2FtZSB0aGluZywgYWxiZWl0
IGFmdGVyIGxvb2tpbmcgYXQgYSBsb3QgbGVzcyBSQ1UgY29kZS4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+
PiBUTDtEUjoNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiAxLiAgICAgIFRyeSBtYWtpbmcgdGhlIF9fc2V0
dXBfaXJxKCkgZnVuY3Rpb24ncyBjYWxsIHRvIG11dGV4X2xvY2soKQ0KPj4+Pj4+Pj4gICAgICAg
ICAgaW5zdGVhZCBiZSBhcyBmb2xsb3dzOg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+ICAgICAgICAgIGlm
ICghbXV0ZXhfdHJ5bG9jaygmZGVzYy0+cmVxdWVzdF9tdXRleCkpDQo+Pj4+Pj4+PiAgICAgICAg
ICAgICAgICAgIG11dGV4X2xvY2soJmRlc2MtPnJlcXVlc3RfbXV0ZXgpOw0KPj4+Pj4+Pj4NCj4+
Pj4+Pj4+ICAgICAgICAgIFRoaXMgbWlnaHQgZmFpbCBpZiBfX3NldHVwX2lycSgpIGhhcyBvdGhl
ciBkZXBlbmRlbmNpZXMgb24gYQ0KPj4+Pj4+Pj4gICAgICAgICAgZnVsbHkgb3BlcmF0aW9uYWwg
c2NoZWR1bGVyLg0KPj4NCj4+IFRoaXMgY2hhbmdlcyB3aGVyZSB0aGUgaW50ZXJydXB0cyBiZWNv
bWUgZW5hYmxlZCwgYnV0IGRvZXNuJ3Qgc3RvcCBpdA0KPj4gZnJvbSBoYXBwZW5pbmcuICBJdCBz
dGlsbCB0aHJvd3MgYSBXQVJOIGFmdGVyIGluaXRfSVJRKCkuIEkgc3VzcGVjdCBpdA0KPj4gaXMg
bm90IHRoZSB3YXkgdG8gcHJvY2VlZCBhcyB0aGVyZSBhcmUgcHJvYmFibHkgbWFueSBwbGFjZXMg
dGhhdCB3aWxsDQo+PiBuZWVkIHRvIGJlIGNoYW5nZWQgaW4gYm90aCBjb21tb24gYW5kIGFyY2gg
c3BlY2lmaWMgY29kZS4gIEFzIHNvb24gYXMNCj4+IFRJRl9ORUVEX1JFU0NIRUQgaXMgc2V0LCB0
aGVuIGFsbCB0aGUgY2hlY2tzIHdpbGwgbmVlZCB0byBiZSBhbHRlcmVkLg0KPiANCj4gVGhhbmsg
eW91IGZvciB0cnlpbmcgaXQhDQo+IA0KPj4gSSB0aGluayB3ZSBlaXRoZXIgbmVlZCB0byBzZXQg
dGhlIGJvb3QgdGhyZWFkIHRvICFpZGxlLCBhdm9pZCBjYWxsX3JjdSgpDQo+PiB0byBzZXQgVElG
X05FRURfUkVTQ0hFRCAoaG93IHdhcyB0aGlzIHdvcmtpbmcgYmVmb3JlPyAgRG8gd2UgbmVlZCBy
Y3UNCj4+IGZvciB0aGUgSVJRcz8pLCBvciBhbHRlciB0aGUgYm9vdCBvcmRlciAobm90ZSB0aGlz
IGlzIE5PVCBhcmNoIG9yDQo+PiBwbGF0Zm9ybSBjb2RlIGhlcmUpLg0KPj4NCj4+IEkgZG9uJ3Qg
bGlrZSBhbnkgb2YgdGhlc2UuICBJJ2QgbGlrZSBhbm90aGVyIG9wdGlvbiwgcGxlYXNlPw0KPiAN
Cj4gTXkgZmF2b3JpdGUgaXMgdG8gbW92ZSB0aGUgaW50ZXJydXB0IGVuYWJsaW5nIGxhdGVyLCBi
dXQgTWljaGFlbCBFbGxlcm1hbg0KPiB3b3VsZCBrbm93IGJldHRlciB0aGFuIHdvdWxkIEkgYWJv
dXQgdGhlIGZlYXNpYmlsaXR5IG9mIHRoaXMuDQo+IA0KDQpJIGRpZ2dlZCBpbnRvIGl0IGEgYml0
IG1vcmUsIGxvb2tzIGxpa2UgSVJRcyBnZXQgZW5hYmxlZCBieSB0aGUgY2FsbCB0byANCmNvbmRf
cmVzY2hlZCgpIGluIHRoZSBsb29wIGluIHZtX2FyZWFfYWxsb2NfcGFnZXMoKSwgd2hpY2ggaXMg
Y2FsbGVkIA0KZnJvbSBwb3dlcnBjJ3MgaW5pdF9JUlEoKSBmb25jdGlvbiB3aGVuIGFsbG9jYXRp
bmcgSVJRIHN0YWNrcy4NCg0KQW5kIElSUSBzdGFja3MgZGVmaW5pdGVseSBuZWVkIHRvIGJlIGVu
YWJsZWQgYmVmb3JlIElSUXMgZ2V0IGVuYWJsZWQsIHNvIA0KdGhlcmUncyBzb21ldGhpbmcgd3Jv
bmcgaGVyZSBpc24ndCBpdCA/DQoNCkNocmlzdG9waGUNCg==
