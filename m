Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3D979D743
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjILRJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjILRJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:09:38 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2080.outbound.protection.outlook.com [40.107.9.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B16E7A;
        Tue, 12 Sep 2023 10:09:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTOb7GHGkugP4E0DFPNshOItKtPD2C1p6C1ldyM4HGSJpy9TMxvAF3vZjW3O6WpTe0GgyN7DM4iLwMPzku5ydULyxv/PeL+dG1avDnd1RSjmtEkJdnGF1+CUHtcC+CywBMTCVteDV/dYATebORF0ASjauJ/Ubk6ggF5sn9+5Fk6nxzzk8NdF4GbiOUQcdX74nnoSmVQg4gSzrseGXN06LwwLK3RHO7fzjhBT0Bt2qoNAGLU2UjlhatmifVpyMitAT3KoY024RBS8qn6IZRr8udMDywCWw0GC3DLoWoM8whJRmbzT/wzaP7xTBHc7xzSZUKC96kA/4NEipySkWbNnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86fM2SK3dUzOqm7cSjNfpyHVOrOIgQDwa8fgPSUk/wc=;
 b=W8IfKK4lwtAN21lh3Ll9EjRmUDQtAQbu+OklL4acKcfoGd+6TsXt4ulRKCYUeH1Lq41b7GhIx3/XaVWzGGlNmnRDCILGzc9SCwJcDlZNDstbAGTZzmdv6xVaGpctCXvd0NNdTP8PQzJJTYK9Gw1ezcy5mYBzILqsJ4WqniGmCQq6H0rGqsMC7gvbuHLbWslr4b2p1ljp/8Puh8rDYGBi+WUC6xpVDZDliD1i28vAI5jC+hiUts97ZNoWsxHR9A+v9QOeY46cUCTTPXInwql23ZARuQ/WLX0F891prR8YHfvbY0HcGDMNa9q3SrGbIr/Sb2jjyk94iNMdccAOxk8EAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86fM2SK3dUzOqm7cSjNfpyHVOrOIgQDwa8fgPSUk/wc=;
 b=T0xXrHqAj1nXoHb0FcJUdQFfL6vKfSoqtoOeJ4+OhkQMoMRuGIIazwpZdugtJVISPFu1sq+S3aCpdKLObDv4NpkMX0RRJiSE/BBLMPZ7IGXYo8RQlvUD0NOYzvJZ4REq77Sni2Wzf6ffou7mqCzWJO7v/gdVmYfRlU7a+ZAM92bYgXyGyqrFCdV3abVcfxpsEIx0HtY0580kdDqgPPc6XxaYeKLjB96NvWXv82EQ79tgZ6Phzn13I3sXlCfQdvfuUJJXTrW8Rvvta78CIVDqK29/gvkYrS44w5qQOHz3cYqC3X7OUoqsYC2lwgHrCFJgmQAVOrjTe7Q8RdDM27D69g==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2425.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 17:09:32 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 17:09:32 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Thread-Index: AQHZ0jZLGonsLT7psk6V57DL3sI7p7ABi0MAgAx8eICAACGXAIAAAcAAgAAJOoCACD39AIAAi4MAgAACooCAAAHPAIAAAUwAgAAX4ICAAEH3gIAAE8cAgAAKbYCAABfIAA==
Date:   Tue, 12 Sep 2023 17:09:32 +0000
Message-ID: <2a4ec37e-bd31-7863-ff8e-1720c62213a0@csgroup.eu>
References: <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
 <20230912135617.dnhyk4h5c555l2yg@revolver>
 <9e85adf9-2e1f-4bed-a58e-9ca629c03579@paulmck-laptop>
 <20230912154423.gcb5rzwzh4jbcaw7@revolver>
In-Reply-To: <20230912154423.gcb5rzwzh4jbcaw7@revolver>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2425:EE_
x-ms-office365-filtering-correlation-id: c27c4b38-f269-4406-a8f2-08dbb3b30858
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: psB4QYq4P/80aIL4pWvwhTTLwNuU8f6bzLIAlbvxIJo6phkfwUGlwxTtK9MIVDus4z+NDY1h1Qv7gozj2I2SmFtBSZlUCY1/Mze4shLmz/6D1bkn9JAuw4Sv9NJyMyItDkLdBx4hrCbTVohHRx2jeBDG8iY7zjbc2kGfh/iotXwqmwF/PHqJ5InTDDLHEPhyu+sbfDtsr2z1UPVQRrqnBDk00rcq/iViWTVvphDSZi4GYte87N1Ry6URwzagbm5ifvGbX7IvuqfiCr43VmctI/fJF3jooz+AdYkUvhpkC3vQb1Equ5w9lmNrF89zRZeNBtVTDMJTbNLhr5iBYdUVRvFxlOjfv6QfgGaLfDuC0ie567Sh73iQqOq+HIvfCa7Q5ciY2pDWniZJ0gt+O7TIZxrhyrxlDlR2UTUqH2K4x8xwV/0wzRQWx/9Spr263Vl3okXr1E51bAggTXZb7gUiecwxsTOCury2Mry1HIfjETRd9myP2WrzqgR7/LeqkXkfVjAEv8H0KFr6UF/mccWbdOGS+3vS82wf2x7JObojDG1Lc72/KszEhULj4KYTWomL00xCYGF3tW0AoZYvz3raIKS+B3fkK27xZ5cliyeeq90UehYCnyB+bPRoHu94+WE8RWcBC1MFsimOEKMzNbI8vNIpx2zljIEc/cFVEF9LADrfelAY6gI+UvGXxeydVdllmUzprt3a9BD1uwCpLSpxZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(186009)(451199024)(1800799009)(7416002)(6512007)(31686004)(5660300002)(6486002)(71200400001)(6506007)(26005)(478600001)(2906002)(4744005)(2616005)(83380400001)(44832011)(8676002)(8936002)(921005)(66946007)(41300700001)(66574015)(122000001)(36756003)(110136005)(91956017)(66446008)(38100700002)(316002)(64756008)(86362001)(38070700005)(31696002)(66476007)(76116006)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1F1U3lWT0NzczZCL21WWlVCMWY1V1ZmZGlXbldUK3FxN3lid3ZraDhTM0RW?=
 =?utf-8?B?cElLazdTTTBDbGZ2UnpKQXJTZlM3OUdWWHB2UzFyZ2MrbllaRUJiUkU3ZHh3?=
 =?utf-8?B?WkNMaWF1dm42b1hvTXR0dy9IQlJQTVd1NC9yWDV6RHlBWjRpclJHYVNMSDZk?=
 =?utf-8?B?dC9USXNYVWdyeUVtSldOYzFkZlN3MVl5SG1rMUkvcFhIQ2dhT0kxaWhOUXVQ?=
 =?utf-8?B?aE5IazlKTit4dThPaENlZnVLYldVNjB3RURLZk9VTEU0RXZSTVFEVlBsQ29h?=
 =?utf-8?B?T3J1R3dBeGtyN21TbnZ6eUtFSEpJU3BPWDUyRU5UcURDNGJnTzMzN1ptOUV1?=
 =?utf-8?B?Z3NISlRLYUR0SFhxSDB5NFl3b3hLZEl0bUh6Sm02NVYzWUJTZlV4Y0VaK2Ix?=
 =?utf-8?B?Z1doQmtXN3k5QnBVK0dnTEMwSTJzWjF4NFlpZ0I2bHJ5c0FGdmJWTms3cW54?=
 =?utf-8?B?R2UvM1NmTTIxQXRjSmVKM283QVFORHJtaDZEZVgrOHNialh4Q0JwQ2dwLzdi?=
 =?utf-8?B?akVFanFCMFNISEdyTXVUd3dxenVNcEZQRHN5SmNaMlFtc2tsRFZaVXdKMExW?=
 =?utf-8?B?MVIrb1h2ZFU4b1F6UmsyZmdqeklPeWN0Q2tVWGlCR3Z1cXhQbXhRenpkNVB5?=
 =?utf-8?B?cW14TzVIMEhUTFFxdE5Ta00reENEQTBlZGtJeUljREc4aGVMVEFoV2RLY2JP?=
 =?utf-8?B?ZUp6QTVqMTcwdlV6U3VQbTA4TkU3UWFONmJnWDlQMW94U2ZrVXdTS3R6cnQx?=
 =?utf-8?B?VGcxNXE1dFNNM2c2bk9YcU9oSWkvTHZRcDFxa29iS3J5TDAvUEE5ZUxiZkI5?=
 =?utf-8?B?d3RxWXBKSnVrTjhhdUhCVzBJeHhoOG1HRWJhU3gwNmdCS2lidjkyRUluemJY?=
 =?utf-8?B?b2NDWFArWTZ6dDNiY3FkQjRBUlNZVGtmV2QwdjBObUlQMGJzNjFXSUVQalpR?=
 =?utf-8?B?VFl5enplWlhHK0JGalFoWFdKSmgyd0d3ZC84S3FBMmFuZ05WQXl0ZmFnYTND?=
 =?utf-8?B?Wk1kYXhpdmlaNzlNUEkybFc1NmZNMlVuS0c2bzFMQ2dTTkt5QjdUK0x6c3RF?=
 =?utf-8?B?b0ZEbTNzVlVVMW5odzRmWXhQdkI1a25xMjRwVmVYUVRBK0RQY0hKYTBPSU1S?=
 =?utf-8?B?Z05qbDRoMmQ4UVZ1bFliK0hNb29lcnJOVkVYR2NwY1pLUWlidXpJUlZ6RzQv?=
 =?utf-8?B?STIwYVBDbEhHQXUwRUZXNVVMZ2UzdjVzV2R1c1NQSGVPOS9JeDZ2Qm5KYlY0?=
 =?utf-8?B?MXArTzlUb3pyUWpRU1UzTjArQk5zK1lkTzRNN0ZxcHBuNFRWSkJPaG1waDRR?=
 =?utf-8?B?VUhpVGNoY2E4cllXTVkzMU9OU002WEtQeDJ4OGVOSXRlU1ppbFIrZXNIQVhk?=
 =?utf-8?B?TlNxWjJEQnRnMWQ5UytMQlpMQVk4RUpSOU1vQktCM3ZrU2I5S1BSQ2hqSFEw?=
 =?utf-8?B?VUdQY2J4MG9ZYkxCWWhqaml0bi9kTzUrVGZYUkN6ek9rUENsbVllVnk1b3ha?=
 =?utf-8?B?VWwxMklmM2UyUHFXNXc4L1RXdzZXd0tPMWI3ekpzWTFpSnJxWnNFM0dSSGVZ?=
 =?utf-8?B?ZDdqNnRzLzB6YjRMOTN6M3dvR0JwZHBQR2pkN3VLWTQ5alR2OUJBbE1lUURj?=
 =?utf-8?B?OVozTWZzVTVjSUhieWxBTXRxSStHaW53dmZ5OGdWUStaK1V3RXFTZHpjOXMy?=
 =?utf-8?B?akNFTmZLVDN6R1dCMTg4cXdzRDJOVjZPcm5hNmh4WXJNdG5qSUNHNjUwZldz?=
 =?utf-8?B?Yng2ckZuWnR3UVJWRUUvbjB2YVVOWEdBMzJHU0pWblZtWkM2MTk0Vks0eXl6?=
 =?utf-8?B?cVRmbExnSFZWdUp0SHNwd0l4UTBUcGdVbXAyLzJIcnQwYlVFYlF2UEgrZmlD?=
 =?utf-8?B?UG1qQ1lpYXdEY1pldGtXWENoczh2dXJ1ZkdMQ1VpL2xITUJqbGhvcDdZV3ZY?=
 =?utf-8?B?S1JBWjhmWG96QzFXSEVxVTVsVmh3bkc3R1FNOUhKTzkwc0FmalF4WkhFVUpa?=
 =?utf-8?B?RGlIaWhkWE1NcmI4WWRjT29qRUM0WDR6MzVRbjU3Wmh0RzdPTXNHWS81cEF1?=
 =?utf-8?B?TmEwVFc0cThvOGxRUDh4MDlnTnJ6NFJFYlRIaW1OV1k3SjFwZXViZ3MyUEVi?=
 =?utf-8?B?RjdpOEswdjErSmpyOGtDUjFnWmZIWmtwZWtndG9RODNZbk9CbFN2aFZCeUV0?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62A2EA9751E99244856202B31F8FA500@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c27c4b38-f269-4406-a8f2-08dbb3b30858
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 17:09:32.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vj3Xm9mPga3Y2nMAvW41JCFh7BArhQpNDSJkp9ngOVEbIgEH9w3RQZVdmWeffRPLrID8EaZoUOtg498DGgyt8lILhW/vA6fYITmVHRJCXrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2425
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDEyLzA5LzIwMjMgw6AgMTc6NDQsIExpYW0gUi4gSG93bGV0dCBhIMOpY3JpdMKgOg0K
PiBkaWZmIC0tZ2l0IGEvaW5pdC9tYWluLmMgYi9pbml0L21haW4uYw0KPiBpbmRleCBkYmUxZmU3
NmJlMzQuLmZkNDczOTkxOGE5NCAxMDA2NDQNCj4gLS0tIGEvaW5pdC9tYWluLmMNCj4gKysrIGIv
aW5pdC9tYWluLmMNCj4gQEAgLTY5Niw3ICs2OTYsNyBAQCBub2lubGluZSB2b2lkIF9fcmVmIF9f
bm9yZXR1cm4gcmVzdF9pbml0KHZvaWQpDQo+ICAgCSAqLw0KPiAgIAlyY3VfcmVhZF9sb2NrKCk7
DQo+ICAgCXRzayA9IGZpbmRfdGFza19ieV9waWRfbnMocGlkLCAmaW5pdF9waWRfbnMpOw0KPiAt
CXRzay0+ZmxhZ3MgfD0gUEZfTk9fU0VUQUZGSU5JVFk7DQo+ICsJdHNrLT5mbGFncyB8PSBQRl9O
T19TRVRBRkZJTklUWSAmIFBGX0lETEU7DQoNCklzIGl0IHJlYWxseSB3aGF0IHlvdSB3YW50IHRv
IGRvID8NCg0KUEZfTk9fU0VUQUZGSU5JVFkgaXMgMHgwNDAwMDAwMCBhbmQgUEZfSURMRSBpcyAw
eDAwMDAwMDAyIHNvDQoNClBGX05PX1NFVEFGRklOSVRZICYgUEZfSURMRSBpcyAwDQoNCg0KRGlk
bid0IHlvdSBtZWFuIHRvIGRvIFBGX05PX1NFVEFGRklOSVRZIHwgUEZfSURMRSAgPw0KDQoNClJl
Z2FyZGxlc3MsIHdpdGggZWl0aGVyIGNoYW5nZSBJIGRvbid0IGdldCB0aGUgd2FybmluZyBhbnlt
b3JlLg0KDQoNCg0KPiAgIAlzZXRfY3B1c19hbGxvd2VkX3B0cih0c2ssIGNwdW1hc2tfb2Yoc21w
X3Byb2Nlc3Nvcl9pZCgpKSk7DQo+ICAgCXJjdV9yZWFkX3VubG9jaygpOw0KPiAgIA0KPiBAQCAt
OTQzLDYgKzk0Myw3IEBAIHZvaWQgc3RhcnRfa2VybmVsKHZvaWQpDQo+ICAgCSAqIHRpbWUgLSBi
dXQgbWVhbndoaWxlIHdlIHN0aWxsIGhhdmUgYSBmdW5jdGlvbmluZyBzY2hlZHVsZXIuDQo+ICAg
CSAqLw0KPiAgIAlzY2hlZF9pbml0KCk7DQo+ICsJY3VycmVudC0+ZmxhZ3MgJj0gflBGX0lETEU7
DQo+ICAgDQo+ICAgCWlmIChXQVJOKCFpcnFzX2Rpc2FibGVkKCksDQo+ICAgCQkgIkludGVycnVw
dHMgd2VyZSBlbmFibGVkICp2ZXJ5KiBlYXJseSwgZml4aW5nIGl0XG4iKSkNCj4gDQo=
