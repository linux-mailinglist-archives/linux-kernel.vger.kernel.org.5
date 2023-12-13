Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF2C811444
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441845AbjLMOIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441830AbjLMOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:08:53 -0500
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2180.outbound.protection.outlook.com [40.92.62.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5B3E8;
        Wed, 13 Dec 2023 06:08:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMD9VJbM5MW8NFU75hYP5pKGybXmJeAQRTdlGytodqtQrR1Ln9K8cVD1Mw4fy2roV7ZIChfAjcOnAoFPDhIXBTX0pgFl1Mlo0j05aY55aNDxigKdVPWB5NI+vmQfaz/0Ki/e6WKsXo/EgVUHc2egANjO3MD0Bq9UQPykxJxPh0sOBZ8LV6JCGoYXy6i4W1jCQn5vVKlOpmOCxfadUZ2ZBa9gNXpNXy4Z4bmi76wxuckyHZmdK7hLzgw+JXSqulJB661NP3JnbYdKrsAM2lQOGZQHEypP6SzbyJPNZI/m1DaWf/xHJQ1SJpJ/I8ZrWFfP54wFpgC6Imh2V7sTDY7T7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2KtRr3WCtrReSwstsc9KwdMIfSFZXO0wtAjYmeFEPE=;
 b=QnaYLuPPNIxHdyShNVS4yDeKisVVhWyJkd9q6SqyDHdmOev6o0fIFZydzFIVvOsbNI6btB6RAMgM71+AbgiDFck08Vcz/uzQcLKVkvKAX8UuV4XSn9k9O4hamqR0uoUbK0cKWOm13xxxuCBrvlaC6PKSKvd5fupkaX1RDbkm+ctz/LcLlbBvme4oxwV5MTOVSaswdt0tMdGgyZMsZGCuRu8OaC7YHC35MDKURjA1VhLLKy5CJqyvEdSkBxKj0XiEtJnCCQj4hUXGThQ0I+bHRVNAYa2n7bjNLLKJaw4rp6Sk3zCRU6r5NI0OktxgVJ1xepi9/jUI/lNxtl1A3MRnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2KtRr3WCtrReSwstsc9KwdMIfSFZXO0wtAjYmeFEPE=;
 b=o0A2HgF6Wxu14Ay2UsFBYz36PKPfH2zHO50ypmvOcM6T9QWZfk8LGe7j/xRI/FVafhlV5It2RnggJXeqXdV2Tx0oToUAUfq6ncAD9Q026THWMY3g6mRAKphlyIo3iWnbkDGET+7FaNsvcUtsnyn1tUkTaGfCrrR8WoYSFcTZoTd5gFMc/tYmuoO7/R3mF+CIX6x7Jp2OAZSfhTbysyFNShEQq7CldYNPmLlX7i5cyIo27Itii6s6u7W0MlxsFgSwJc2CK3ORmY3yJxzxkiZgY6BxUcDnSQGZ+181mTv/uWESggQkZR5JhtBQ9TmSzrwM3aYYBM6Bo8e7keq0ztWzTQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB1090.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 14:08:51 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6867:103:3120:36a9]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6867:103:3120:36a9%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 14:08:51 +0000
From:   Jinjian Song <SongJinJian@hotmail.com>
To:     Loic Poulain <loic.poulain@linaro.org>
CC:     "chandrashekar.devegowda@intel.com" 
        <chandrashekar.devegowda@intel.com>,
        "chiranjeevi.rapolu@linux.intel.com" 
        <chiranjeevi.rapolu@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "danielwinkler@google.com" <danielwinkler@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "nmarupaka@google.com" <nmarupaka@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        "vsankar@lenovo.com" <vsankar@lenovo.com>,
        Joey Zhao <joey.zhao@fibocom.com>,
        "Qifeng Liu(Qifeng)" <liuqf@fibocom.com>,
        "Fuqiang Yan(Felix)" <felix.yan@fibocom.com>
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Thread-Topic: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump
 support
Thread-Index: Adotx6RhyheAzqyESlWX8tIBqbXlZg==
Date:   Wed, 13 Dec 2023 14:08:51 +0000
Message-ID: <MEYP282MB26978CC014D395597DDCF1EFBB8DA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [GwTaloBsajXd/HXwUqJvZzFi4Tk3++wf]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2697:EE_|ME3P282MB1090:EE_
x-ms-office365-filtering-correlation-id: 985ccd92-f92d-4fd6-680b-08dbfbe5089c
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RQ25/UwxFitFifqLGTr0Z7ynBDnlkGhz6uOS5cbbD/jGEyITHdAOR9t58XDPONcKsbhKOP3rQHoL5w4HimiI0BaR6kVXfTghF0XsniNCp8bvCZmyMhnPc+LxpUqQRs4Ercvq0JM62PfTfwHdrbyVyGxU45tbptfPpiDXOHjEa+4aIKSFoKd0lJJLjqszS0xVUep2tN6TXlznL1e+gxQH9fFT2peGWx/r6FR80KserK9Kahl9MSoDcl0JEmn9IZZ7SG5yCUx641nryUU/ab7alIaRJHXSkQKjrgr479M0p3oSqqJTbtMiT8u7q0GNKq2MA6dj8uw+rB5xgD1g+VjwCnHHFSUXZnDYbIbxb5exCSmFXcO2HVmtMrHnlZ971HVZ1a7zzz4RcOjEVgEshXHsBJxODxB7J7qyvgE7m09J3BNl1xwjF+GXAWgcbCYLtXbaRbUDcf8hONZIypqNGX9wQ/TKhV7pM84V4GGHcWOwH+wz5ZcEeJreQwkyMKw0Eyt+pyfPU4g3R1wsYkuGWgn2QY7rQ+3ZKq7YvqMzf9mKqK0zTxwOb9eQSTy9FqNDzFM8W7rwB/I9uoGWKsgznKnUbLTd4YfZaoqTy9EnDJD79Zc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTFOR1ZtMmlLRWZrM0NUb0NkVEpYdm43NE9ra0hYMGxUWGorN3BreXZjTTAx?=
 =?utf-8?B?RCtmbUZyb1A2V2E0MTdUdkxPNVhRYXJ1aEFJakhURSttSDBGZGk0WkFNc1hR?=
 =?utf-8?B?bjZEbDBCTXFwNmsvN2E2aXFlN2dQWGV6RGwyd2k1V2oycC90aloyUER6NkJ0?=
 =?utf-8?B?cVBnS0JDelNpWGpoeWpKbHNLeTgzVXZrVndxNjFjT0s1Zm84Rmh1ZG54WDhz?=
 =?utf-8?B?a051UTZuWG1EN1VRWFdpTVlOb0x6eHpSbWd1M1BIS25CVUE2U2hEVzhwSFBF?=
 =?utf-8?B?RjI2L0pYenZnaEI1MVovWXdXZ01hcmRVVHBYZFFXb3UxWE5QdkpqRW9XTmQz?=
 =?utf-8?B?MklXbVpmYmQxQlJGMERXMGJtd29kbGJJVDBybmQ0d2hTU0t2Wm1tVENHbmZr?=
 =?utf-8?B?VDhaUDRabTJzb2NEdWlock1MZE1hZVUyRkU0NVh5Q0R3ZDRPMzZrWFU2VnBm?=
 =?utf-8?B?SFNLTjhSWHFqb215V1ozQy92RXRocndSdVU4UDJ4SHBoTmg5SXNDQ2NsZjlr?=
 =?utf-8?B?Q2pKOTAyamkwODhaRHJtenZZb2ZpbHBUbDEzc3l1THJYYzhkZW03SU9TbzZ5?=
 =?utf-8?B?Q2lWRDNkM0J0Z05MRUg1eEhLMVRhSXhydUNObHJkK25ITElrUTJ5WjlyL2xE?=
 =?utf-8?B?ekdsQ3FBdHQwdG56Y0xZNDlneDdheFp0dkxlQjk0aFRiOU5zdkpxZXhrWVFD?=
 =?utf-8?B?anNNems0cGFNSysrc2VWcjc1bjVUTWltdjJTL0FmcUJJY1prdmFiUTN1d0gr?=
 =?utf-8?B?eGtLUWdQL0YvMW5UYzFvRFMyYldhUnNCUVVkYW04Q2JlMktsbUxpU3g4cGUr?=
 =?utf-8?B?K0VaYjhVOFArYWw2ditEL2wyUEdad3JvU3JGdTBMVHlqOFhoSXZ3Tk9MVWxP?=
 =?utf-8?B?bWFpZGZPMStwTkMzSzNjWktqYlNlYmhTQUF1ZmtkcklleVArSXFNbDU0UlZY?=
 =?utf-8?B?WG1ycVljbnp0ZEdra2k1enFZRk1SdzhSOUQ3OHd0Q29WTEtoMjJzR2UzQW44?=
 =?utf-8?B?bGJOU1U4MjZPTTlVK2EwNTdOTWp2UGdzTWVzaXpHRlN3SHFKRWQ0d0o3NzRx?=
 =?utf-8?B?L2hpNnM5UkhsNk5VcjBaQWF0NitKQUV6dzJRbEZEdW52Wkt2SHVpTGRBSndr?=
 =?utf-8?B?V3MreXVudklmOEVUS3hKenNQRktZRyt6N2diU3FwMEswWCtPUWVib09WUUg5?=
 =?utf-8?B?THBKQWpIMWQ0aEVHNjB6REJHbndqSWFJMUVCNmw0TmRoUjRCbk1iZlFOT0ow?=
 =?utf-8?B?N0VSeVZXTHpxOXAxWU52NEw0eERkNkZSOFUybkJxWW5VWlBsSHRSaVFHVFdR?=
 =?utf-8?B?a0hNTC9HaC9UWFY0dWVjOGVSL2YwSkZLdEdwZHJ2VFVITFBRSFppeTR1Zk5E?=
 =?utf-8?B?WWtpQU9Ebm52L2gwelRkc3kyRGJwdkJMaHQ5NTVlK3Roc0Z6WlEycUZlbSta?=
 =?utf-8?B?cGk1bld5ZW9hcysvbHpOY2JMamNaY0lwdU92N0xOZ2Y4U2ZTNDdzTS9BSmVn?=
 =?utf-8?B?cC9OZ2VPVVVtZGNibnFiWU5GRnNJNkMzek90VUxKYXVRa0pDZ3loNmJmUXg1?=
 =?utf-8?B?OEwreVAyUUlweFhTcXM0OEJZNHhGakpLZHNIOUpralpNYjgyZ291KzdNeDFr?=
 =?utf-8?B?ODJYZ0c2Vmx0ZEthVmJSeFRTd1czRGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 985ccd92-f92d-4fd6-680b-08dbfbe5089c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 14:08:51.3426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTG9pYywNCg0KVGhhbmsgeW91IHZlcnkgbXVjaC4NCg0KPk9uIE1vbiwgMTEgRGVjIDIwMjMg
YXQgMDM6MDYsIEppbmppYW4gU29uZyA8U29uZ0ppbkppYW5AaG90bWFpbC5jb20+IHdyb3RlOg0K
Pg0KPiA+ID4gPiBNb24sIFNlcCAxOCwgMjAyMyBhdCAwODo1NjoyNkFNIENFU1QsIFNvbmdKaW5K
aWFuQGhvdG1haWwuY29tIHdyb3RlOg0KPiA+ID4gPlR1ZSwgU2VwIDEyLCAyMDIzIGF0IDExOjQ4
OjQwQU0gQ0VTVCwgc29uZ2ppbmppYW5AaG90bWFpbC5jb20gd3JvdGU6DQo+ID4gPiA+Pj5BZGRz
IHN1cHBvcnQgZm9yIHQ3eHggd3dhbiBkZXZpY2UgZmlybXdhcmUgZmxhc2hpbmcgJiBjb3JlZHVt
cCANCj4gPiA+ID4+PmNvbGxlY3Rpb24gdXNpbmcgZGV2bGluay4NCj4gPiA+ID4NCj4gPiA+ID4+
SSBkb24ndCBiZWxpZXZlIHRoYXQgdXNlIG9mIGRldmxpbmsgaXMgY29ycmVjdCBoZXJlLiBJdCBz
ZWVtcyBsaWtlIGEgbWlzZml0LiBJSVVDLCB3aGF0IHlvdSBuZWVkIGlzIHRvIGNvbW11bmljYXRl
IHdpdGggdGhlIG1vZGVtLiBCYXNpY2FsbHkgYSBjb21tdW5pY2F0aW9uIGNoYW5uZWwgdG8gbW9k
ZW0uIFRoZSBvdGhlciB3d2FuIGRyaXZlcnMgaW1wbGVtZW50IHRoZXNlIGNoYW5uZWxzIGluIF9j
dHJsLmMgZmlsZXMsIHVzaW5nIG11bHRpcGxlIHByb3RvY29scy4gV2h5IGNhbid0IHlvdSBkbyBz
b21ldGhpbmcgc2ltaWxhciBhbmQgbGV0IGRldmxpbmsgb3V0IG9mIHRoaXMgcGxlYXNlPw0KPiA+
ID4gPg0KPiA+ID4gPj5VbnRpbCB5b3UgcHV0IGluIGFyZ3VtZW50cyB3aHkgeW91IHJlYWxseSBu
ZWVkIGRldmxpbmsgYW5kIHdoeSBpcyBpdCBhIGdvb2QgZml0LCBJJ20gYWdhaW5zdCB0aGlzLiBQ
bGVhc2UgZG9uJ3Qgc2VuZCBhbnkgb3RoZXIgdmVyc2lvbnMgb2YgdGhpcyBwYXRjaHNldCB0aGF0
IHVzZSBkZXZsaW5rLg0KPiA+ID4gPg0KPiA+ID4gPiBZZXMsIHQ3eHggZHJpdmVyIG5lZWQgY29t
bXVuaWNhdGUgd2l0aCBtb2RlbSB3aXRoIGEgY29tbXVuaWNhdGlvbiBjaGFubmVsIHRvIG1vZGVt
Lg0KPiA+ID4gPiBJIHRvb2sgYSBsb29rIGF0IHRoZSBfY3RybC5jIGZpbGVzIHVuZGVyIHd3YW4g
ZGlyZWN0b3J5LCBpdCBzZWVtZWQgdGhlIGltcGxlbWVudGF0aW9uIGNhbiBiZSB3ZWxsIGludGVn
cmF0ZWQgd2l0aCBRdWFsQ29tbW9uJ3MgbW9kZW0sIGlmIHdlIGRvIGxpa2UgdGhpcywgSSB0aGlu
ayB3ZSBuZWVkIG1vZGVtIGZpcm13YXJlIGNoYW5nZSwgbWF5YmUgbm90IGJlIHN1aXRhYmxlIGZv
ciBjdXJyZW50IE1USyBtb2RlbSBkaXJlY3RseS4NCj4gPiA+ID4gRXhjZXB0IGZvciBRdWFsY29t
bSBtb2RlbSBkcml2ZXIsIHRoZXJlIGlzIGFsc28gYW4gSW50ZWwgd3dhbiANCj4gPiA+ID4gZHJp
dmVyICdpb3NtJyBhbmQgaXQgdXNlIGRldmxpbmsgdG8gaW1wbGVtZW50IGZpcm13YXJlIA0KPiA+
ID4gPiBmbGFzaChodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9uZXR3b3Jr
aW5nL2RldmxpbmsvDQo+ID4gPiA+IGlvIHNtLmh0bWwpLCBJbnRlbCBhbmQgTVRLIGRlc2lnbiBh
bmQgdXNlIGRldmxpbmsgdG8gZG8gdGhpcyANCj4gPiA+ID4gd29yayBvbg0KPiA+ID4NCj4gPiA+
IElmIHRoYXQgZXhpc3RzLCBJIG1hZGUgYSBtaXN0YWtlIGFzIGEgZ2F0ZWtlZXBlci4gVGhhdCB1
c2FnZSBsb29rcyANCj4gPiA+IHdyb25nLg0KPiA+ID4NCj4gPiA+ID4gJ210a190N3h4JyBkcml2
ZXIgYW5kIEkgY29udGludWUgdG8gZG8gdGhpcyB3b3JrLg0KPiA+ID4gPg0KPiA+ID4gPiBJIHRo
aW5rIGRldmxpbmsgZnJhbWV3b3JrIGNhbiBzdXBwb3J0IHRoaXMgc2NlbmUgYW5kIGlmIHdlIHVz
ZSBkZXZsaW5rIHdlIGRvbid0IG5lZWQgdG8gZGV2ZWxvcCBvdGhlciBmbGFzaCB0b29scyBvciBv
dGhlciB1c2VyIHNwYWNlIGFwcGxpY2F0aW9ucywgdXNlIHVwc3RyZWFtIGRldmxpbmsgY29tbWFu
ZHMgZGlyZWN0bHkuDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGRvbid0Lg0KPg0KPiA+IFNvIHRoaXMg
aXMgY2xlYXIgdGhhdCBkZXZsaW5rIHNob3VsZCBub3QgYmUgdXNlZCBmb3IgdGhpcyB3d2FuDQo+
IGZpcm13YXJlIHVwZ3JhZGUsIGlmIHlvdSBzdGlsbCB3YW50IHRvIGFic3RyYWN0IHRoZSBmYXN0
Ym9vdCBwcm90b2NvbCANCj4gcGFydCwgbWF5YmUgdGhlIGVhc2llciB3b3VsZCBiZSB0byBtb3Zl
IG9uIHRoZSBnZW5lcmljIGZpcm13YXJlIA0KPiBmcmFtZXdvcmssIGFuZCBlc3BlY2lhbGx5IHRo
ZSBmaXJtd2FyZSB1cGxvYWQgQVBJIHdoaWNoIHNlZW1zIHRvIGJlIGEgDQo+IGdvb2QgZml0IGhl
cmU/IA0KPiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9kcml2ZXItYXBpL2Zpcm13YXJlL2Z3X3Vw
bG9hZC5odG1sI2Zpcm13YXJlLXVwDQo+IGxvYWQtYXBpDQo+DQo+IDEuVGhpcyBBUEkgc2VlbWVk
IGZpdCBoZXJlLCBidXQgSSBoYXZlbid0IGZpbmQgdGhlIHJlZmVyIHRvIHVzZSB0aGUgQVBJLCBj
b2RlcyBpbiAvbGliL3Rlc3RfZmlybXdhcmUuYyBzaG93biBzb21lIGludHJ1ZHVjZSwgSSB0aGlu
ayBpZiBJJ20gY29uc2lkZXIgaG93IHRvIGltcGxlbWVudCBvcHMucHJlcGFyZSh3aGF0IHRvIHZl
cmlmeSwgaXQgc2VlbWVkIG1vZGVtIHdpbGwgZG8gdGhhdCkgYW5kIG9wcy5wb2xsX2NvbXBsZXRl
PyBBbmQgaXQgc2VlbWVkIHJlcXVlc3RfZmlybXdhcmUgQVBJIGFsc28gY2FuIHJlY2lldmUgdGhl
IGRhdGEgZnJvbSB1c2Ugc3BhY2UsIGlzIGl0IGEgd2F5IHRvIHVzZSBzeXNmcyB0byB0cmlnZ2Vy
IHJlcXVlc3QgZmlybXdhcmUgdG8ga2VybmVsPw0KPg0KPiBJbiBhZGRpdGlvbiB0byB0aGlzLCBJ
IG1heSBoYXZlIHRvIGNyZWF0ZSBzeXNmcyBpbnRlcmZhY2UgdG8gcGFzcyB0aGUgZmlybXdhcmUg
cGFydGl0aW9uIHBhcmFtZXRlci5BbmQgZmluZCBhIG5vdGhlciB3YXkgdG8gZXhwb3J0IHRoZSBj
b3JlZHVtcCBwb3J0IHRvIHVzZXIgc3BhY2UuDQo+DQo+IDIuSG93IGFib3V0IHdlIGFkZCBhIG5l
dyBXV0FOIHBvcnQgdHlwZSwgYWJzdHJhY3QgZmFzdGJvb3QgYW5kIGR1bXAgY2hhbm5lbCwgbGlr
ZSBXV0FOX1BPUlRfWFhYLCB0aGVuIHVzZSB0aGlzIHBvcnQgd2l0aCBXV0FOIGZyYW1ld29yayB0
byBoYW5kbGUgZmlybXdhcmUgb3BzIGFuZCBkdW1wIG9wcy4NCj4NCj4gSG9wZSB0byBnZXQgeW91
ciBhZHZpY2UsIHRoYW5rcyB2ZXJ5IG11Y2guDQo+DQo+IEkgd2FudCB0byBpbXBsZW1lbnQgaXQg
dXNlIHRoZSB3YXkgb2YgdGl0bGUgMiwgY3JlYXRlIGEgbmV3IFdXQU4gcG9ydCB0eXBlIHVzZWQg
Zm9yIHRoZSBjaGFubmVsIHdpdGggbW9kZW0uDQoNCj5JIHVuZGVyc3RhbmQgdGhhdCB0aGUgZmly
bXdhcmUgdXBkYXRlIG1heSBub3QgYmUgYXMgc2ltcGxlIGFzIHN1Ym1pdHRpbmcgYSBzaW5nbGUg
YmxvYiwgYW5kIHNvIGZpcm13YXJlLXVwbG9hZC1hcGkgbWF5IG5vdCBiZSBlYXN5IHRvIHVzZSBh
cyBpcy4gQnV0IGNhbiB5b3UgZWxhYm9yYXRlIGEgYml0IG9uICdhYnN0cmFjdGluZyBmYXN0Ym9v
dCcsIG5vdCBzdXJlIHdoeSBpdCBpcyBuZWNlc3NhcnkgdG8gYWRkIGFub3RoZXIgYWJzdHJhY3Rp
b24gbGV2ZWwgd2hlbiBmYXN0Ym9vdCBpcyBhbHJlYWR5IHN1cHBvcnRlZCBieSBvcGVuIHNvdXJj
ZSB0b29scy9saWJyYXJpZXMuDQoNCkl0IG1heWJlIG5vdCBuZWNlc3NhcnkgdG8gYWRkIGFub3Ro
ZXIgYWJzdHJhY3Rpb24gbGV2ZWwgZm9yIGZhc3Rib290LiBQcmV2aW91c2x5LCBJIHRob3VnaHQg
dGhhdCB0aGUgb3BlbiBzb3VyY2UgdG9vbHMvbGlicmFyaWVzIHdvcmtlZCB3aXRoIFVTQiBkZXZp
Y2VzIGRpcmVjdGx5LCBidXQgYXQgdGhhdCB0aW1lLCBJIHRob3VnaHQgaXQgbWlnaHQgYmUgbW9y
ZSB0cm91Ymxlc29tZSB0byBhZGFwdCB0byBQQ0llIGRldmljZXMsIHNvIGFic3RyYWN0aW9uIG1h
eSBiZSBhbiBlYXN5IHdheS4NCkN1cnJlbnRseSwgSSB0aGluayBjcmVhdGUgdGhlIGNoYW5uZWwg
aXMgYmV0dGVyIHRoYW4gdXNpbmcgZmlybXdhcmUgdXBsb2FkIEFQSSwgSSB3YW50IGFkZCBhIG5l
dyBXV0FOIHBvcnQgdHlwZSBmb3IgdGhpcyBjaGFubmVsLCBhbmQgdXNpbmcgZmFzdGJvb3QgcHJv
dG9jb2wgY29tbWFuZCB0byB3cml0ZSBkYXRhIHRocm91Z2ggdGhpcyBwb3J0Lg0KZS5nLg0KdDd4
eCBkcml2ZXIgdG8gY3JlYXRlIHRoZSBjaGFubmVsIC9kZXYvd3dhbjBmYXN0Ym9vdDAgd2hlbiBu
ZWVkZWQsIEkgd2FudCB0byBjaGVjayB3aGV0aGVyIGZhc3Rib290IG9wZW4gc291cmNlIHRvb2xz
IGNhbiB3b3JrcyB3aXRoIHRoaXMgY2hhbm5lbCBkaXJlY3RseSwgaWYgbm90LCBjb25zaWRlciB1
c2luZyBjb21tYW5kcyBkaXJlY3RseS4NCjEuY3JlYXRlIHRoaXMgY2hhbm5lbCAvZGV2L3d3YW4w
ZmFzdGJvb3QwLg0KMi5kb3dubG9hZDpzaXplID4gL2Rldi93d2FuMGZhc3Rib290MA0KMy4iZmly
bXdpcmUgZGF0YSIgPiAvZGV2L3d3YW4wZmFzdGJvb3QwDQo0LmZsYXNoOnBhcnRpdGlvbiA+IC9k
ZXYvd3dhbjBmYXN0Ym9vdDANCg0KUmVnYXJkcywNCkppbmppYW4NCg==
