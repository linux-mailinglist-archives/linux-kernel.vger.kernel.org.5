Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033D979D455
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjILPGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjILPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:06:35 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2058.outbound.protection.outlook.com [40.107.12.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6055CD8;
        Tue, 12 Sep 2023 08:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPz9yix9T/A244PBVQ5EuMXPfI7B9ow/G4TrAKaTqtUX50ranQpjfVTB6h22ozU8eJWwiOiF4tepyks11Ww++VFUJGSdkYMOzuzIRojLjCX+t2SpPUPBFDCcCrC83VE7kL9eAwzhEKfdUoDOMazIOUTI3t34KMs90vJZnGQQelnbSDYCh42mmmf8rXv5M6oNU2gd3jjaCmIxns2FwPoHj2xkJHZbfQH3UEhQnzxd6GTucn5j52DqdhxeA+hxMouMScxHnEHFDWHbj6eKVE3t8xJixYZNMwFh3+ULOet8xnKKpeDiwVCeetlaWXqUYe9NZymIK4KpUy5ROpeLL93ZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmbBsth5mKOJLbAIP5QIcRR1rfRY9ySxR2J3fgM8z8g=;
 b=NIIUJJAdwb9BWl/6Cex327fqY+ejDoaZiXORvXtZWr/VSSs9T4hU5HkCF/TrGSzHcTzO7mBosSqSJF7ELcNaJm8ohxb0sIEWM/SexKfFAdNzi24o6omhj/09BdIXik3a6h1qf+WiBy3PAE+h4rwNrr9RghQFUkUbWFqxnpOY18KTBxVzEqOFNscFFyseJ/rcZdfXBycqDA5RxIDbeADRLSMYCBKFbyNHtuhuRBlE7xv/gwzl+G+aoY+o+kZwzIklvSP8FT9FvFRhkOKquszDTVHwhPPqnDFrgwgl/L7YwlvTI1bHnG34CU3t8EPY6XGQNVa+owx6ZnBxwdaf2btNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmbBsth5mKOJLbAIP5QIcRR1rfRY9ySxR2J3fgM8z8g=;
 b=N6n+uoLgYXWdp6F2hwAWj8POeXApvaZIOVZXLF3Gscnb4kwwCvg2RnKmk1yF0dpm0BrLmKf7BPL2tpiIJDZMl5zIBrW5abFACysoyKs46sI9p0F3y3JTiX5mx6CLCvZgb4aqsUD2jy7GVdeOSH+jUe2k51HlGhXZPC1bkmwUKLRfmfxY1pTMxetGyiZWshEpY6yTzVJ8DoP9L6uUSOf2gFP9uh8joBD52QGJxMsbmnDIrp5M9DIU7n0EZ3frqpNeHbKLkYowiXgoWEXch56jhIijeREY+JigAoTMEKjvvR+9xE53EXfxmN5O8/gs30AoQYdLCSb6zbbtZ55Hh5ZJcA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2231.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Tue, 12 Sep
 2023 15:06:28 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 15:06:28 +0000
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
Thread-Index: AQHZ0jZLGonsLT7psk6V57DL3sI7p7ABi0MAgAx8eICAACGXAIAAAcAAgAAJOoCACD39AIAAi4MAgABrJYCAAAgIAA==
Date:   Tue, 12 Sep 2023 15:06:27 +0000
Message-ID: <2a0657bf-2585-4b98-bbdb-dd38502c8555@csgroup.eu>
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com>
 <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver>
 <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <3e75add4-4d51-eab9-7029-25660e02b082@csgroup.eu>
In-Reply-To: <3e75add4-4d51-eab9-7029-25660e02b082@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2231:EE_
x-ms-office365-filtering-correlation-id: ced4c003-0267-4d0b-936c-08dbb3a1d6e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SdFN9TDThxfHo9331GmAoZA8tAvYC5gGJ+WdgI686cEQWtlg108kdgIGn1ABzFdLjFnNmz217cySsLMLO1AgnMbCuOIOUwRvPB5IXKphVno7+BW6CWVZm61Zwn4Zre0vwn7Oof+vwBGBA+yQzMQwDRdaNnUsC8d3+acNQeSPeGovIipxfp/fAc1Bub1G2Q+saec9b4MCJ71ToE68IY3OeIIBCRlhU2f060oe7N2mLyVKqOZiqZyTc4INZts5D28SfKymbN4gu6QGv6B83g66+tIunSV5UrA2iNutSBIJ+VruxvdDccVAjy4kLyTVyIq1L+la7Vgpw+AzD2E5FZ520pHk4qa/bgpqb2znVUTfw1SOBnLW0DvDDLJcjovkjadF948D1zRO/vUUlK+1JEra+yYq+0wF6gAZbrymgm8hoCLmQ7nG6DUL8SrmbecGCROGVRcfMIynY2th91egjlviFx25HGJussRhAloFPvpfhbARXo8InWzCBKAyV/6C85GkK2XGSgdfEBKr9IhOUKOhzEqW9csOVG39p2i500TnhR8jScJM83RVCAHjaMCSoIq636Exaj97D0TQBwWiD5rFFz4YDaEVaeWCde123FkCuX7UsOz4Bm4zFd893o8aUvjLmSGlF1tslhqwUz4vR90t4o46Gv0gkGk9Z/VGzawO9yvF3FvG52TkjD2DMmiO0g3nPPTNn6qdAuSukXjPD1DTbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(186009)(451199024)(1800799009)(66574015)(31686004)(5660300002)(44832011)(8676002)(8936002)(6486002)(83380400001)(71200400001)(6512007)(26005)(6506007)(2616005)(478600001)(122000001)(45080400002)(921005)(76116006)(316002)(66946007)(91956017)(110136005)(66556008)(66476007)(66446008)(64756008)(41300700001)(86362001)(36756003)(31696002)(2906002)(38070700005)(38100700002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjVJeW1XMldIN0JtWTZzdlVHV0lwOXB4aEovaGxRVlZHZDN6bjNrUC9KcEpG?=
 =?utf-8?B?MjArWWR6TlZ1b2Q4YkMybmppTm9ocVVjbEZTS3V2OVhlTERnQ0owRGd0Zlhh?=
 =?utf-8?B?dUgrSVVkbU5aQnVsVURXbUxHMDA2U3VoNnF6V0NpQnpzV1RiY2xXVXRTZ0xz?=
 =?utf-8?B?SEtoMHN5NmlhRjN3SXR6OTNXeFlRNFJWdWNkK2NJdDlWRStJOFphbjZWNG9q?=
 =?utf-8?B?RW5Kb05uSmJuTWE5LysxWEVzQytqYVprZHhNd0p2UUZiS3JaTkx6UDRRdWpo?=
 =?utf-8?B?ZktqN1BxSGNlRnVvK3ZpTUFvRXUzdWhlRmNaVEhwajE0YkRDYkt6MGJRWU1v?=
 =?utf-8?B?WEJUVWFJR28wSStQL2lWVVFFQmJqaks0cXN5TzNnck9Seng4cnlFaDBHSFk3?=
 =?utf-8?B?WXRqTVNrcGpuSDBPUmtJYTJZbjdkdjRpYk5oeWxmcjNCNGhaNXdJMzJkOWtW?=
 =?utf-8?B?OWpNdDhvdDhPT0c3UytaU0pQYmp3NkYyd2Y3RGFEVEpkazRHcGZYeFowV2FD?=
 =?utf-8?B?alNTb0JJaUpiWDkwSmpENG4ra0htR0x4YU5FMWRzN1ArbTJEcUQzYTRhRldj?=
 =?utf-8?B?V0w3K05sZ01tRnJ4dnNaeDRBQ0lpTXR5MFo0eHFZRDRaaXRMR21yOXhWOU9x?=
 =?utf-8?B?d2lEVncwNXNuS29kRFRRVEkydDdObnpyeUVORGd2b3pvclNIMEJpWTlYbmxL?=
 =?utf-8?B?aTJVbmhkWUgxbjZ4dUxOQlY5MVdHWmhybldSTk9pdzhWY2NPQVhyYS9WUVE0?=
 =?utf-8?B?aTNOSmtzckxQNllhaGJFKzVpcTBhcUp6Z0IyOUY5QzZiOVZUdDdERzRKSDNl?=
 =?utf-8?B?bjYzMlFMVlZLZ2o2V3VQR3dadXN3bEIrWGlLRmdmUGpNSFEzWmhramtRU2dS?=
 =?utf-8?B?eVNFbHV2V3czTWIwdi9NTzhKNnlab21MNnNJZ2VSYmQyTlFWbVJTcVQzS3hh?=
 =?utf-8?B?Z1FLd0F0aHpzaXlLRnV5TVBiR1QzN0N4SGRBL0NtWFNQMlZYMXJZd2FCdEdU?=
 =?utf-8?B?NmlxOVlDb1NkSWthTWVRVnhSb0JSa0ZVV0Z5dFNZVE1HUHJVb1pMYmpxdlpR?=
 =?utf-8?B?TU9FQ2N4TUVhN0pYenlJUStObTVVT0gxeTg4QzlhZ3ZMa1Fpc1lTMmZXWlJw?=
 =?utf-8?B?dlJZbmtxVTJTRkNlUTlzNXBUNWRnMkEzNjhaQVBVc01FOGtOcUs1SXljWlJP?=
 =?utf-8?B?RzhrLzJXTWFaazNrOXVpVzY5ZkRpNGZqb0V1VjRNWE5vV0dOWG1SSjExaDVP?=
 =?utf-8?B?VXNGR3drTk5Ma0dIcG13N1ROM0sva1lqQlB0TDRBVXd3bUZ4SXdVQkhXZGRJ?=
 =?utf-8?B?MXZxUHdKdlFmNTZLN2thZnJhRkp1dlcvWk5qYmtGbWtzNUMwV1ptVGt4ZHpR?=
 =?utf-8?B?VUY0SlE3QUQ2cUt6bWJlcWRwZ1FicXg0Sy9McUtYVnppc2crazIrTGFxWjRm?=
 =?utf-8?B?VEtkVXMzVkNRMzFPYWZkbytQQVlJTVVCME9qR0dqMDJQSkNWcVFPejAxTWZL?=
 =?utf-8?B?bmdPRFVyai9NOEhFajNNclowVXQ0VHgyMkg3dHVPMi8yRW9VRk9HS1N3Um0x?=
 =?utf-8?B?VjFiWFJqci9sblZDOUxxbmdDa0V3cDZ1bWRQaC9INndQb2k1QWhZNjhuWUI1?=
 =?utf-8?B?YWdBT1BZZ3N2VC9VbnlkYm9YLy9ydkI5eDRWN2puNTVjaGxNU21xK3FhSVBj?=
 =?utf-8?B?SDlRN2ZjdEdJT3czREczK1c0SU4zT29RMVFDMWUzbFVBb1N4dllyLzBzTkZV?=
 =?utf-8?B?TGMyTVY2MVc3U2ZNZkduWmpBK1NEM3Q4ZVRCU1ErcmhJMkk5Ym5BdnFEVzRN?=
 =?utf-8?B?Q052VVFUZ0hKakdBd1Npc2c0K21HNHp5WFBFMzlTcVV1Y0VHWVlHNCtrbS9u?=
 =?utf-8?B?c2hBQ3Y2cXQ4MEtiUmdRd1VXN29tdzJNYWpnbU5keEZZaXdYZnlpQU1TU1Z4?=
 =?utf-8?B?VFBCQkZtQThUblpTRld3M1h0dFNEMjM3K2NmQ2h5VkxIcVlBdXFFZ1NkQ1NQ?=
 =?utf-8?B?UHBmNWZyMkpCc21aZWFDSFlCaDNDWUsvRDcwZ3JJMTlPb1N4T3pKR2dRb0hn?=
 =?utf-8?B?cE9McUtQWkk1QXIvbGFERSs2VnM0Z0l4c3ZnMHZZRTB1UTRScnJZSS9VTjhi?=
 =?utf-8?B?YzkyWVhrMTJXalY4WDREZjBYeTIxUWk2Q3A4Q2s2RnNDMUtOR2J3Zis1dUxK?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38A262238E6CEA428AC7AC0C4C0B1D37@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ced4c003-0267-4d0b-936c-08dbb3a1d6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 15:06:27.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnD41KCdyTNAmnDbWw55nANnO5AhYG+o8+vBbo1dCb2dL6MBzRbj/V6DdCONSyyWwFFN1eglRCJd8XW/PFCZAHF+IDQ3v/pQ39J5ontWgGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2231
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDEyLzA5LzIwMjMgw6AgMTY6MzcsIENocmlzdG9waGUgTGVyb3kgYSDDqWNyaXTCoDoN
Cj4gDQo+IA0KPj4NCj4+IE1heWJlIHNvbWV0aGluZyBsaWtlIHRoaXMgaW4gX19zZXR1cF9pcnEo
KSwgcmlnaHQgYmVmb3JlIHRoZQ0KPj4gbXV0ZXhfbG9jaygpPw0KPj4NCj4+IAlXQVJOX09OX09O
Q0UoaXJxc19kaXNhYmxlZCgpKTsNCj4+DQo+PiBUaGlzIHdpbGwgZHVtcCB0aGUgc3RhY2sgdHJh
Y2Ugc2hvd2luZyBob3cgX19zZXR1cF9pcnEoKSBpcyBiZWluZyBpbnZva2VkDQo+PiBpbiBlYXJs
eSBib290IG9uIHBwYzMyLg0KPj4NCj4+IEFnYWluLCBnaXZlbiB0aGF0IF9fc2V0dXBfaXJxKCkg
aW52b2tlcyBtdXRleF9sb2NrKCksIGludm9raW5nIHRoaXMNCj4+IGZ1bmN0aW9uIGluIGl0cyBj
dXJyZW50IGZvcm0gYmVmb3JlIGludGVycnVwdHMgaGF2ZSBiZWVuIGVuYWJsZWQgaXMgYQ0KPj4g
YmFkIGlkZWEuDQo+Pg0KPiANCj4gTm8gdHJpZ2dlciBvZiB0aGF0IFdBUk5fT04oKSBJIGFkZGVk
IGluIF9fc2V0dXBfaXJxKCkgYXMgaW5zdHJ1Y3RlZA0KPiBhYm92ZSwgc3RpbGwgZ2V0dGluZyAo
cG1hYzMyX2RlZmNvbmZpZyBvbiBNQUM5OSBRRU1VKQ0KPiANCj4gLS0tLS0tLS0tLS0tWyBjdXQg
aGVyZSBdLS0tLS0tLS0tLS0tDQo+IEludGVycnVwdHMgd2VyZSBlbmFibGVkIGVhcmx5DQo+IFdB
Uk5JTkc6IENQVTogMCBQSUQ6IDAgYXQgaW5pdC9tYWluLmM6OTkyIHN0YXJ0X2tlcm5lbCsweDRk
OC8weDVjMA0KPiBNb2R1bGVzIGxpbmtlZCBpbjoNCj4gQ1BVOiAwIFBJRDogMCBDb21tOiBzd2Fw
cGVyIE5vdCB0YWludGVkIDYuNi4wLXJjMS1kaXJ0eSAjNDgxDQo+IEhhcmR3YXJlIG5hbWU6IFBv
d2VyTWFjMywxIDc0MDAgMHhjMDIwOSBQb3dlck1hYw0KPiBOSVA6ICBjMGE2MDUyYyBMUjogYzBh
NjA1MmMgQ1RSOiAwMDAwMDAwMA0KPiBSRUdTOiBjMGM0ZGVlMCBUUkFQOiAwNzAwICAgTm90IHRh
aW50ZWQgICg2LjYuMC1yYzEtZGlydHkpDQo+IE1TUjogIDAwMDI5MDMyIDxFRSxNRSxJUixEUixS
ST4gIENSOiAyNDAwMDI4MiAgWEVSOiAyMDAwMDAwMA0KPiANCj4gR1BSMDA6IGMwYTYwNTJjIGMw
YzRkZmEwIGMwYjkyNTgwIDAwMDAwMDFkIGMwYjlkMTI4IDAwMDAwMDAxIGMwYjlkMTQ4DQo+IDNm
ZmZmZGZmDQo+IEdQUjA4OiBjMGJhODBmMCAwMDAwMDAwMCAwMDAwMDAwMCAzZmZmZmUwMCA0NDAw
MDI4MiAwMDAwMDAwMCAwMDAwMDAwMA0KPiAwMTk5YWJmYw0KPiBHUFIxNjogMDE5OWIwYTQgN2Zk
ZTdmYTQgN2ZjNWFjMGMgMDAwMDAwYmIgNDEwMDAwMDAgMDFjNjkwYzggYzBiOTIwMTQNCj4gYzA5
YjRiZGMNCj4gR1BSMjQ6IGMwYzU1MjIwIGMwYWMwMDAwIDAwMDAwMDAwIGVmZmY5MTA5IGVmZmY5
MTAwIDAwMDAwMDBhIGMwYzZkMDAwDQo+IGMwYjkyMGEwDQo+IE5JUCBbYzBhNjA1MmNdIHN0YXJ0
X2tlcm5lbCsweDRkOC8weDVjMA0KPiBMUiBbYzBhNjA1MmNdIHN0YXJ0X2tlcm5lbCsweDRkOC8w
eDVjMA0KPiBDYWxsIFRyYWNlOg0KPiBbYzBjNGRmYTBdIFtjMGE2MDUyY10gc3RhcnRfa2VybmVs
KzB4NGQ4LzB4NWMwICh1bnJlbGlhYmxlKQ0KPiBbYzBjNGRmZjBdIFswMDAwMzU0MF0gMHgzNTQw
DQo+IENvZGU6IDQ4MDAzN2IxIDQ4MDIzYzA1IDRiYWI4OGVkIDkwNjIwMjYwIDQ4MDEzOWU5IDRi
NjU3Y2VkIDdkMjAwMGE2DQo+IDcxMjk4MDAwIDQxYTIwMDE0IDNjNjBjMDlhIDM4NjNiNzhjIDRi
NWU5Y2NkIDwwZmUwMDAwMD4gMzkyMDAwMDANCj4gOTkzODAwMDggN2QyMDAwYTYNCj4gLS0tWyBl
bmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQo+IA0KDQpGb3Igd2hhdCBpdCdzIHdvcnRo
LCB0aGUgaW50ZXJydXB0cyBzZWVtcyB0byBiZSBlbmFibGVkIGJ5IHRoZSBjYWxsIHRvIA0KaW5p
dF9JUlEoKS4NCg0KRGlnaW5nIGludG8gaXQgdGhhdCdzIGVuYWJsZWQgYnkgdGhlIGNhbGwgdG8g
X192bWFsbG9jX25vZGUoKSBpbiANCmFsbG9jX3ZtX3N0YWNrKCkNCg0Kc3RhdGljIHZvaWQgKl9f
aW5pdCBhbGxvY192bV9zdGFjayh2b2lkKQ0Kew0KCXJldHVybiBfX3ZtYWxsb2Nfbm9kZShUSFJF
QURfU0laRSwgVEhSRUFEX0FMSUdOLCBUSFJFQURJTkZPX0dGUCwNCgkJCSAgICAgIE5VTUFfTk9f
Tk9ERSwgKHZvaWQgKilfUkVUX0lQXyk7DQp9DQoNCnN0YXRpYyB2b2lkIF9faW5pdCB2bWFwX2ly
cXN0YWNrX2luaXQodm9pZCkNCnsNCglpbnQgaTsNCg0KCWZvcl9lYWNoX3Bvc3NpYmxlX2NwdShp
KSB7DQoJCXNvZnRpcnFfY3R4W2ldID0gYWxsb2Nfdm1fc3RhY2soKTsNCgkJaGFyZGlycV9jdHhb
aV0gPSBhbGxvY192bV9zdGFjaygpOw0KCX0NCn0NCg0KDQp2b2lkIF9faW5pdCBpbml0X0lSUSh2
b2lkKQ0Kew0KCWlmIChJU19FTkFCTEVEKENPTkZJR19WTUFQX1NUQUNLKSkNCgkJdm1hcF9pcnFz
dGFja19pbml0KCk7DQoNCglpZiAocHBjX21kLmluaXRfSVJRKQ0KCQlwcGNfbWQuaW5pdF9JUlEo
KTsNCg0KCWlmICghV0FSTl9PTighcHBjX21kLmdldF9pcnEpKQ0KCQlzdGF0aWNfY2FsbF91cGRh
dGUocHBjX2dldF9pcnEsIHBwY19tZC5nZXRfaXJxKTsNCn0NCg0KQ2hyaXN0b3BoZQ0K
