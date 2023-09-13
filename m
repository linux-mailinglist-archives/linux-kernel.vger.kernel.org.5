Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421679E00F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbjIMGeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjIMGd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:33:58 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2045.outbound.protection.outlook.com [40.107.12.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175E81735;
        Tue, 12 Sep 2023 23:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdzg8ZGnXCo/1zrTxJf16sV3rXqvJr+OEfdjbUtmnEQ48tPuJsz+JuorznyXjS6TeUJ5W4kOXg8tmY5xbvovg6EKdaqazU55SlUynlSblcwksaZPnf/WZD5NuPyJtNTMCvWgC27VAY/aMKR9iPqKQjWVTKQUdgxiU9ByKLaFR69kmh37flVw4r6vyeK/eS3ao8nk6J1YHRp8fT8qxod9iHd1g+AnQoGHDSnGq6bv77z6xlntkMnpPkowvyLUPg+MRWKFT7HwwQEuMooPBk9wgxXokuA/HgMCSWmwX8jGVv7Srp2iON2jCnpAXfwvP8OJ+MD7bwn7t4Nz6PtG6E+mBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrurouRHBHmsKFP2yXVE6h9ZcQ6HHXsgwlWpaJRAjoE=;
 b=nJbXXyhhAeJqOifcsvbILUSoNNq+5OkBF9KefJgYw8Y/wCUVw2iHMCZdjaFAi5dI3bBIenXH927KEv21JAz+auXp828J6QWJgxKEGQ6GxctBda2nP5IEhzot6CYgD56YJ9gjktNd6g078EMrC0rIw3ZUI1qkd6pBlibFakMuS9FngJG48QOnwneEo136QQZPUvmYzM+mLI5u3gi/mIjVhYHzRVsocY6olEjTYWBeWkHq8cMOFowzuGHZ9cB60SrSZjUIJQfOBzuniSLq2UDpz3YPX7QAjpw7QlezXdZjvhfadR5JoXP8F0JBaEr58/yRrIPb8Cs98pHiHoQj/3DSGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrurouRHBHmsKFP2yXVE6h9ZcQ6HHXsgwlWpaJRAjoE=;
 b=cbL6ef4KuI5QWPTyROdzaF+t8C6uYXsLSVeTHULFfcv+z8GtlYQUf9BzjDn1YiHW+oX41oltHmcLjK4ZhVVdss39cNt/Jbgk7DCGvim0ALCZUA2ADP0G/tvwYxtuCFEhW7oFpMg7uvICc55i/UvsVwt4W9YLCCMdo8Dc8GRyjccDKkr9Lxp2qYAT/FBOE4qVBAjckORWvRJGjw3aapu2dpwAcpxO1Nb9ovdHdSW6oNl5/6GPzGXlqJQaDCkmbShqVW/+6+BtWcMrtccvpukHPRJd0ZsGanJ/J0gz3MbWJZycqaxdOEQKytmu03R4O4cz918psy0JxqQJCqZT21Tpyg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1619.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:15::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 06:33:51 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 06:33:51 +0000
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
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Thread-Topic: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Thread-Index: AQHZ0jZLGonsLT7psk6V57DL3sI7p7ABi0MAgAx8eICAACGXAIAAAcAAgAAJOoCACD39AIAAi4MAgAACooCAAAHPAIAAAUwAgAAX4ICAAEH3gIAAE8cAgAAKbYCAABIXAIAAA7GAgADiu4A=
Date:   Wed, 13 Sep 2023 06:33:51 +0000
Message-ID: <cf189103-5b42-cf82-41b7-d73df2e34d0f@csgroup.eu>
References: <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
 <20230912135617.dnhyk4h5c555l2yg@revolver>
 <9e85adf9-2e1f-4bed-a58e-9ca629c03579@paulmck-laptop>
 <20230912154423.gcb5rzwzh4jbcaw7@revolver>
 <1189edca-9029-4c2e-ba71-b3a1c15b61dc@paulmck-laptop>
 <f12ba12c-4625-1b13-a0c8-376138d94b45@csgroup.eu>
In-Reply-To: <f12ba12c-4625-1b13-a0c8-376138d94b45@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB1619:EE_
x-ms-office365-filtering-correlation-id: 4b675582-4597-4db9-9207-08dbb423651a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3gD+40Km66g1ZelyVBrwzToJk4TI46FvUScDFYBXWsRvQ3gO2xcSi8F+KsiVPXgaPHTLzD2LvKQiNcNLu+NtmgqQgLb/js/OtLaS3R6UivPvhK9P98v5qGj/2SzmWz32NJTm0MzDoI3JIsknXaUAykUvufbRz/DLDSFx7rMJlucxZQ4J4F3koa/QuofGlNh2LQHoVKhvMd6T//h66OFtXQ5lhSRyWobOZgqqqqiUCi6CSreftX3AiIKcgfNrGrym+50ss2651KUbaZACQleGi93kRm2ZksSJ4QUO/LsHlqAf/ZKyaSBe2K/awLTugf2W3e+9CiGOAbQshEH2aS5Jls5+deRNZRLUpseplz7aAkUjPapXJvBMAB0KhBq4sJMAbhMd5BNVQXU9u4qdUexC4s33lSR51pA+CD5mBzLXqiIGYO3v/6y8F3CGnHUz5fDMLnmETPDfNFYUhv+VJLT8r0Qq05xCyDhgEzhrH9f78jPooGift7G4SOtA+UvFZnitqlCIVLyKdWErK3U2ierSueHmiEpCm+2GiH6T2EDEXuFQU1CrQ1AEoK2eB1IMcwMJKjoNCkeXkgsWtVI6XUa5Tiv+SpqFmiTZXnUpddsSjdNL5Sd/pH7kEnDBRTp3+vLxsq34Lb4Y3Q6Y7cvbnCfwZFImVkkRjqay8QenrKHl57mAblVyAnn0+uWnD4f0eRpbKHEBzELpgHF2AejRhl8wSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199024)(186009)(1800799009)(26005)(71200400001)(122000001)(921005)(478600001)(6486002)(6506007)(38100700002)(36756003)(38070700005)(31686004)(64756008)(66476007)(66556008)(66946007)(66446008)(76116006)(91956017)(110136005)(6512007)(2616005)(316002)(41300700001)(8936002)(44832011)(2906002)(5660300002)(86362001)(31696002)(8676002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnErSGZLVEd3elEzZ2JXTklsQVBwaEtncGVxK1lPdEtXMlVhT1c3TnJybFcy?=
 =?utf-8?B?MWoxSUZvSDVTd1N1YjNYYTVXOHhqcngrTnlLTzN0WjBoRk5ZVzNLYmNObGFM?=
 =?utf-8?B?SjFhTlNld0VPeUFIZEg4T3pBZWk2d1RFM25BR0g0ZjJtTUJ6d2Q3YTBha3dB?=
 =?utf-8?B?TUQvNE9sMTFodEtLN2s0dlFrcTd4MjkwRXZ0S2JJQllSSGxMMTB6Z0R3NTZC?=
 =?utf-8?B?dDZwc1RqSHU1UGNpWDc2N0xzSlJEbVNGSWFxamJOUEdhVUhJekJ3NUgvSTla?=
 =?utf-8?B?LytCaEtHRGdhRXJBWWYwbjI0c1pYcVBFelZxTUxQa1c3bWw5SkIvSGhSSDBs?=
 =?utf-8?B?cWJGR2VleEplMk04NGVPcDZlc2YwaE5oVHI0ZVhTWGkzMmZXVVJMd29rcFZB?=
 =?utf-8?B?UmxWN1JFSXAxejBqM1Q3U2VqYVRSSWpyWWUvbmczK3ZuMVJlNTJmOFdibUZQ?=
 =?utf-8?B?eXJOMVlIUlhjOTFPZ1Z6clBPUUlEdUsrQ3ZWVlhLM2w2NjNWaVM5VkRibm5o?=
 =?utf-8?B?ZE9ub2JTMnY4QW9xcUZVNjFIaUh6ZGpDUE5WOEJUZktNaHVjOWpudURRQnZ1?=
 =?utf-8?B?UlZhL0xac1dQVjY0U2hPTU0vU296YjBLUzRFQkxSb0E5NUJ6eGR0YitCblFt?=
 =?utf-8?B?YkNudUNXUjJjMDJZZFhnU0hwdGtZRnJIRU9WbFEydVBYU1gvdU50aVhqOHpu?=
 =?utf-8?B?SUFuNk01WXVQOG02SmhKRlVlbjJGdEcwRDVXbjBucE9YVmhJemxxZmJnMy9P?=
 =?utf-8?B?WlRJY1hTRERPTGxoVDRvdWFXSDBFR0p4TENvVUxURXhyWUxsVVNOVHZ3NkFF?=
 =?utf-8?B?V21LbXE5MDRBRFZXM2ZvYnBMWmhScTFJTURvMDVDUlc3T0dHRFhkSTkxTHkx?=
 =?utf-8?B?aitiRERsbXBXbjRFc2kwMkhabXFIMjN1K0htTUVoVFRmclV2ZkJDSFVldXMx?=
 =?utf-8?B?RWdQYkluNys3REpIWnl0dXdweGNnb3d0bW5VVG9WZGg3aWF1M0o1NlpJM3pS?=
 =?utf-8?B?cFJCSW1qSGxTQkVQOURuSVd6ZVF4REFLTHVHVmVJWDJUQ0ZjYzRVWjNINUFr?=
 =?utf-8?B?SHV6S1JIMVhUYlNNbWg4TkdxSkZmWi8zTGRJeDNqMkRSUTcraGpmRDFxd05P?=
 =?utf-8?B?L1FqN29JQVhGMGlMOUxFK013TUlEdW12bnNzVzExL0NqZHZKSWlMUnBrV05Z?=
 =?utf-8?B?MllSdW5SVU1wTjltZkttTHFIL0ZLbEw5U1UzRHVUalBMK3YxOVhhaElFZVY2?=
 =?utf-8?B?Vko2V0RRODlOQ0YrcVBXTEp5eUpwNURYZHZLeVpxSHVaaExoQ0pBM1QvVnhL?=
 =?utf-8?B?VTF6c3o0aTlzS3V0enFYSm54WFo3akpCUXNUK0xaZHFEanN4M3hHenNuRytB?=
 =?utf-8?B?cDZ0NkZTZjU4MEoyR0xiZWpUVWRHSVIvUENrSWFrWVlBanA0Yjl5bnpoY3RV?=
 =?utf-8?B?d3pTRTZzS3h0UTQyVGlkSVUzZ29Sa3JSMmgrT0lBU3kzNTJ2TzFsR0NPd0Vs?=
 =?utf-8?B?NDI5Rm1zNXJaa0FkLzA1SE9ac2M5Z29MYitEeHNXL21HTWxsWkEwTzUrWWg2?=
 =?utf-8?B?eU5wZldscGZWV2JlMU5mSG54dEI4ek02RmR2ckxFZE53eDVJam0zMWp1QlJn?=
 =?utf-8?B?QklZWUlkNTJnMVJuUEEyZFcxZjVWRTVMY2NPcDVhNnV0R1VsVVF6dXJ2Z2Qy?=
 =?utf-8?B?UzFhQkIvRWZ3SVk2VUptYXQ5REh6RWQrZDQxcXJLRTV4RVNyRkdyMVFkUFdo?=
 =?utf-8?B?Wm5jaHg4eXd2UzRabVNGa3J3Nk00VXhEMDAveEFVVm1paVZ0R0R0RGZYdFFT?=
 =?utf-8?B?ZVlReVp1aFJva0NDRkpuT3I4U1BPOUJRemRxY1IrWkcvaWRMNk1Jd1RPMTQ2?=
 =?utf-8?B?RHhseDladUw5RjBoSUZTSGpUc0dRaGJLNm1Iayt1eng5ZjZHeVBGUXBOLytk?=
 =?utf-8?B?eDY4ZVRvL29tRURhREppUFJEdk5FMVZ4RC8zdXdnZnlBUkc3ckJsRGx0TUs1?=
 =?utf-8?B?V3JHemhnMzNjVVBycnVnWitCcTdPZmJTZ3NsTEF6WlBNYnBEMXZxNTJkbDBL?=
 =?utf-8?B?QmZONmRMUzl1OUxEQnFxUG0xZEVHQSt6TWFWZ1JqQTNkektMaVNHWmR3aTVL?=
 =?utf-8?B?VzdOUVpWVUpyNHpjQXFoUm9FQi9CeGtYV1V2SnNSSjVwNzVBbEtlL2E2Z0xT?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFCD98DDED9D4A458339F88796511BC6@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b675582-4597-4db9-9207-08dbb423651a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 06:33:51.5902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irTXPaNN2rm4XJ4jBDceKzRN1vKegCVPdlyXJCSkYL0B938SE7P2AXQuzqLIbscb09XzGRNMghKWxQqGKTSaEFSNKXH8y9eDcnY6wF8knC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1619
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDEyLzA5LzIwMjMgw6AgMTk6MDIsIENocmlzdG9waGUgTGVyb3kgYSDDqWNyaXTCoDoN
Cj4gDQo+IA0KPiBMZSAxMi8wOS8yMDIzIMOgIDE4OjQ5LCBQYXVsIEUuIE1jS2VubmV5IGEgw6lj
cml0wqA6DQo+PiBPbiBUdWUsIFNlcCAxMiwgMjAyMyBhdCAxMTo0NDoyM0FNIC0wNDAwLCBMaWFt
IFIuIEhvd2xldHQgd3JvdGU6DQo+Pj4+IFNvIG15IHF1ZXN0aW9uIGlzIHdoeSBpcyBpdCB1c2Vm
dWwgdG8gc2V0dXAgaW50ZXJydXB0cyB0aGF0IGVhcmx5LCBnaXZlbg0KPj4+PiB0aGF0IGludGVy
cnVwdHMgY2Fubm90IHBvc3NpYmx5IGhhcHBlbiB1bnRpbCB0aGUgYm9vdCBDUFUgZW5hYmxlcyB0
aGVtPw0KPj4+DQo+Pj4gSSBkb24ndCBrbm93IGZvciBzdXJlLCBidXQgdGhlcmUgYXJlICdwcmVh
bGxvY2F0ZWQgSVJRcycgd2hpY2ggZW5kIHVwDQo+Pj4gZ3JvdXBlZCAwLTE1LCB0aGVuIEkgc2Vl
IGFub3RoZXIgb25lIGFkZGVkIGF0IDU1IGFmdGVyIHRoZSBtcGljIGNvbnNvbGUNCj4+PiBvdXRw
dXQuICBJIHN1c3BlY3QgaXQncyBzbyB0aGF0IHRoZXkgY2FuIGJlIGFkZGVkIGFzIHRoZXkgYXJl
IGRpc2NvdmVyZWQNCj4+PiBkdXJpbmcgZWFybHkgYm9vdD8NCj4+DQo+PiBDaHJpc3RvcGhlIGFy
Z3VlcyB0aGF0IHRoZSBpbnRlcnJ1cHQgc3RhY2tzIG11c3QgYmUgYWxsb2NhdGVkIGVhcmx5DQo+
PiBvbiwgYW5kIHRoYXQgdGhpcyBhY3F1aXJlcyBhIG11dGV4Lg0KPj4NCj4gDQo+IFdlbGwsIHdl
IGNhbiBwcm9iYWJseSBhbGxvY2F0ZSB0aGVtIGxhdGVyIHRoYW4gaXQgaXMgdG9kYXkuDQo+IA0K
PiBJbiBjb21taXQgNTQ3ZGIxMmZkOGEwICgicG93ZXJwYy8zMjogVXNlIHZtYXBwZWQgc3RhY2tz
IGZvciBpbnRlcnJ1cHRzIikNCj4gSSBhbHJlYWR5IHB1c2hlZCB0aGUgYWxsb2NhdGlvbiBhdCBh
IGxhdGVyIHN0YWdlIHRoYW4gaXQgaW5pdGlhbHkgd2FzLg0KPiANCj4gV2UgY2FuIHByb2JhYmx5
IGRvIGl0IGxhdGVyIGlmIGl0IGhlbHBzLCBob3dldmVyIGl0IGRlZmluaXRlbHkgbmVlZHMgdG8N
Cj4gYmUgZG9uZSBiZWZvcmUgZW5hYmxpbmcgSVJRcyBmb3Igb2J2aW91cyByZWFzb25zLCBzbyBp
dCBpcyBhIHByb2JsZW0NCj4gdGhhdCBhbGxvY192bV9zdGFjaygpIGNhbGxpbmcgX192bWFsbG9j
X25vZGUoKSBlbmFibGVzIElSUXMuDQoNCkZvciBGV0lXLCBsb29rcyBsaWtlIGFybTMyIGlzIGRv
aW5nIHNpbWlsYXIgc28gdGhlIHByb2JsZW0gaXMgbGlrZWx5IHRvIA0KaGFwcGVuIGZvciB0aGVt
IHRvby4gRm9yIHRoYXQgYm90aCBDT05GSUdfSVJRU1RBQ0tTIGFuZCANCkNPTkZJR19WTUFQX1NU
QUNLIG11c3QgYmUgc2V0IGl0IHNlZW1zLg0KDQpDaHJpc3RvcGhlDQo=
