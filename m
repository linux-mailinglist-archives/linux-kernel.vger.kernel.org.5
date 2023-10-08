Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54E7BCBE2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 05:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbjJHDTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 23:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344339AbjJHDTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 23:19:48 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2143.outbound.protection.outlook.com [40.92.62.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABD0C2;
        Sat,  7 Oct 2023 20:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L12HhWpioAWmdAK7hdf6Jyh8JPv4E5lFAvgeWmqIKInStuF8JRx+DGzbyg6kd7EYlSY12TyVTGzPYinlmyVcbpB5aeaHtvEQtwPoOXvIsFgCJ5Xktn9voKrM5H0cYzk3SDoV/lmAKCiPhUr6269TlZo4UWcmsU/56QZKndgHF1B7+cPIhRT3SD32hj0NDIfz/K/QEfFrM+MH/nZZuW7cjbtJVlZLSNrMTWFHgblKkjFz7zxPVIG/Plauv2wzGWV6X04CiFNPmYqYUYDK+jLSH5M6qEjHQvZ/HPeW0IXXPQRuSAU2yWQ7TpHeLNKzJWP4qW5VeOYrdExKDhuw+hrKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/aaoT2idtL79k2Mr8Ipn7s/8QIYzq5dU4hKuKLYl5g=;
 b=bKt/MJfnONhmi/yzEvtm+iAkfMY5UAFcqbndDUbMbn6RW0v9wc+b0DYqC8s2mAkwUZbGJPk5yfu/nWGPh0HZlBY7HaD4XqEvkWw9pJivrkgR0ZDBj2cFvCVV2HqV3zkdxZ+FFMQ7/0se+wY/ySyaHEIHGT2g8k+qM/33mlTE/fwYlXYlFYaRpifC8uz9zMwT6tWOkbr/OaS5NyRXF3+umg8Y3AExdaLPyXA7/82xJqkXnalUZbKB3DhHqAffekhOEjW5BJ8IXU9VsE1Lm2aQTDf+6I9X2ihZpc7JkEZplGjPj9SJL7JQlPfMpPVZPRTbHk/M5qb9XVVol4hhMnEkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/aaoT2idtL79k2Mr8Ipn7s/8QIYzq5dU4hKuKLYl5g=;
 b=bU4Jm2rTPTGWh7PqoC+UGWT4a0a46bjL4ESp3TluhiM2tAHrlKtLdxSfnFQdBxvr2SPlwOgSkkiNz9FNg25Hbkw+dXYpPM0ZhdLDgvnzMIFIWZSEKKnbzxaGnVN135Zx7GkqncJBQXWtyaH1GwD9uASJvDzs60kOZiYuDv3PBV9Uk1tfB0t+Hbx877SeemxADrwPrrrPmkpRG0TU6mugkRLw18viDAP7qJcSonHHoMyA97/Ua8cml+yQkJNqpzAQn+qsKLtSzshkAUzXOu6PO1rWr7pTd0q/xTTSKz2hPQCaH8/EfwSmmCsrFPKmOO98OXjyJoxLocOzNHO2bML25g==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB2129.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Sun, 8 Oct
 2023 03:19:38 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9ab5:8709:b0ff:ade1]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9ab5:8709:b0ff:ade1%4]) with mapi id 15.20.6863.032; Sun, 8 Oct 2023
 03:19:38 +0000
From:   =?utf-8?B?6JCd5Y2cIOiLsembhA==?= <SongJinJian@hotmail.com>
To:     Loic Poulain <loic.poulain@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "chandrashekar.devegowda@intel.com" 
        <chandrashekar.devegowda@intel.com>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "chiranjeevi.rapolu@linux.intel.com" 
        <chiranjeevi.rapolu@linux.intel.com>,
        "haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
        "m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
        "ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nmarupaka@google.com" <nmarupaka@google.com>,
        "vsankar@lenovo.com" <vsankar@lenovo.com>,
        "danielwinkler@google.com" <danielwinkler@google.com>,
        "Fuqiang Yan(Felix)" <felix.yan@fibocom.com>,
        "Qifeng Liu(Qifeng)" <liuqf@fibocom.com>
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Thread-Topic: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump
 support
Thread-Index: Adn5il7hk6+Uv1GTTG6ttM7jhvHy8w==
Date:   Sun, 8 Oct 2023 03:19:37 +0000
Message-ID: <MEYP282MB26973271CE109D4EF1643C0ABBCFA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [5LJYesyMhY7sXIxZiCGH0+eax/Z/2RQu]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2697:EE_|ME3P282MB2129:EE_
x-ms-office365-filtering-correlation-id: 4fd91af1-6bf1-4c5f-166f-08dbc7ad675e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKTUeyHlEhHOPSkqXZgwTWTzjYkeNLWTHE0YXduXTqj8dGR8BKNN8QVT6nAb47CoUit+6UKhwkPMyhsmvQKn3dzUqtXaWi56v5VgGW1jui2uY67+4x6fHHy4xxcs4TulFeAnzr9IPq3Ogcz26olKPZPRYNXx3UfcWmxhQjgceg9OC0M8yjpa/0aC/JVTUh/spuG3nUJTEjb2gnecTNorKhNiUJrSTh8uFVP9Zr6NRGrGXW44tFOkpVrTiI3YnYZsTtBsD7hzjggFMgM20Mev47pmJYTOvXiGgREI2SOeDFLxU9KijJf5vJ1GD6qWnMoJNP6DkvwBMTlsTUW35RlVlcpB+pOv/y/Wn9hvMwgMdf+8UOhWJPt0QQwLTJmV5khQH6xdxC0x0IkufgPn96a/JYT0fcIurGoyvEIXKPrrrubzcm1Wvr69Lk/SOqdpARrVjsl6vWPNS209V1UFdy8bStLbGAAtCcLNaKXS9CoQhP4l+DFPLSbwwnGo5y/thYb8j7Mdqyio75Bh/MQJIfbxtxR/UKHo3DXxE/dOwxivM0HJxTMkIBNjnoYNyLdcOgWw
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzY0Q1RKWjM5dE1OeXZXSzdXODJ6azhDaU9CVlNQU3dXa3RtbnRtY1F1SE5G?=
 =?utf-8?B?TWc0cWZRRDFCaEpYWmpNYTZZcHc2dGwzanVLTGFBeWEwOUNueWRjay9zKzJn?=
 =?utf-8?B?WDNMamoreExBRVEvMFliSTBOYTdsQXI0M3p3OTliVzB3RDE0SEovNTc3bWVp?=
 =?utf-8?B?ZFRPeU5qZGlsYnUvN1FZTkFqc3dmTWxPdlhXaHY4bmZMVTd3d0Y0eEFxcjVH?=
 =?utf-8?B?VHlQaVRKSDZKeVdBTjlDSHlWc2h5UCtWMklYV0VXV3FRYk9YNVl2MkNKV0pU?=
 =?utf-8?B?dHRFbHJOWGViaFd5Vlhad3RxdHFDM3RURDlRZDBQRmxmMDdGcGhEajh0aDZa?=
 =?utf-8?B?bmFGRWl5ejZJTk5MWFozQTU1QWdha2pDRGlObzQ4THlWTFBLQ20rYjhpYWo0?=
 =?utf-8?B?RXpLbGdwNGNIbVZ4NktTY1dqVlNZOExKUFhTd1hyTXJJdHBaQzBYYlBocFJa?=
 =?utf-8?B?UDlOV0pjbk9paW5TanNGVmJDYkpuSXBLcmtnMHBlUWFhdTdLbGlCb2xFSlc0?=
 =?utf-8?B?KzF5OWdjV2xRbUJFcDVlVDF5bmhCWmFoUHQzR3pvYnJ5ZzlWR2xuZjFRTmNN?=
 =?utf-8?B?VDI3Z1ZkTFYvVyt0TDk5dG9lYzc1eWwzQWtiUHgrRExDb1A0c1FzOEhicnly?=
 =?utf-8?B?OHc3QnYyQVcySWJvNmxrd2JkeFE1Mk5mR3JhN003RW02dnIrdlo1SWpiMnhi?=
 =?utf-8?B?WlpRd1RQOUZFb2ZUSURYK3hkUUJGMXNueHMvdCtwYmdWSytZOEVjSllqWTBM?=
 =?utf-8?B?TStQdUU1U0pSZ2tadEI5d1RkYlByMGtsRDU1anpWZ3hoVHprU3dxVXN2R3JC?=
 =?utf-8?B?VllxWWk1bDExNDlvNGszbXk0S2ZBY2hMOTRpU2IwZng5K3pWdUdUZmNpMFhp?=
 =?utf-8?B?R205Szl6WHR6ZDBDWmhhUXl3WS9QRGVZZS9RNWtWZ3U2TEw4OThQNURXeTRo?=
 =?utf-8?B?U1NaREJUWXBuY3ZITzdYTkluVUxLZkFKOC91Y2lSMktUb2R3K3pmMDFGZTZ1?=
 =?utf-8?B?b0JOa2txazRIZFQwa2ZmSEVDNmV1T2E1Uk9OcmtMOGY3dnVHeEdBVmM1d0lD?=
 =?utf-8?B?T0hoUnljRVFKM252TUZMWEZpN2JuaWVrVm9zZGJWb250L2k4Y2VZaDdtRS9W?=
 =?utf-8?B?T3h5L3U2VzFnaDRVdTU4S1l5ZnhyWEtFNW9xejFhMFdOaHlBWVlCcCtiV0xr?=
 =?utf-8?B?ZEpTalVJc09wbWpLc1ZHL2Vqckx1aWF1SjhYTHBud24xUnVMcUY3enFmU3E2?=
 =?utf-8?B?SENLN1FibVJFaWU4QmlhSWllQSt0SFFENWVhUFhCa1VLSVF0dnlWcDBIRG9y?=
 =?utf-8?B?L3QzMEVNNllUOC91bU5DQnVXd3RwdUN6UzIwK1liWFdWamhyMFdoSktBU3hx?=
 =?utf-8?B?bkRVNmtDMzhhS2JBYXhCV0tvOXl6KzVmOUNHdmlMNmVMREM0ZHdEVmw5MjB1?=
 =?utf-8?B?cGc3a25hOUxtVkljeG1TZ1J5WHN4N3FXRmNKNEVMUGx1amZxeE10NjU1RXV6?=
 =?utf-8?B?QTRDL2tRSW40UGE5SjJEbm5jcFRHYTBacjdQeENVWG9xMHBNSXRaeEdCc1JS?=
 =?utf-8?B?K3UxMDBudUxZV0x0WWRoVllCRDhZYWFiYmFEQUJxWVo3MDg4NHlCTUtoMUd5?=
 =?utf-8?B?ZHRNVDY2RCtsaE1UVmNScTJDdWxLL0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd91af1-6bf1-4c5f-166f-08dbc7ad675e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2023 03:19:38.0104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB2129
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIFdlZCwgMTMgU2VwdCAyMDIzIGF0IDExOjE3LCBKaXJpIFBpcmtvIDxqaXJpQHJlc251bGxp
LnVzPiB3cm90ZToNCj4+DQo+PiBUdWUsIFNlcCAxMiwgMjAyMyBhdCAxMTo0ODo0MEFNIENFU1Qs
IHNvbmdqaW5qaWFuQGhvdG1haWwuY29tIHdyb3RlOg0KPj4gPkFkZHMgc3VwcG9ydCBmb3IgdDd4
eCB3d2FuIGRldmljZSBmaXJtd2FyZSBmbGFzaGluZyAmIGNvcmVkdW1wIA0KPj4gPmNvbGxlY3Rp
b24gdXNpbmcgZGV2bGluay4NCj4+DQo+PiBJIGRvbid0IGJlbGlldmUgdGhhdCB1c2Ugb2YgZGV2
bGluayBpcyBjb3JyZWN0IGhlcmUuIEl0IHNlZW1zIGxpa2UgYSANCj4+IG1pc2ZpdC4gSUlVQywg
d2hhdCB5b3UgbmVlZCBpcyB0byBjb21tdW5pY2F0ZSB3aXRoIHRoZSBtb2RlbS4gDQo+PiBCYXNp
Y2FsbHkgYSBjb21tdW5pY2F0aW9uIGNoYW5uZWwgdG8gbW9kZW0uIFRoZSBvdGhlciB3d2FuIGRy
aXZlcnMgDQo+PiBpbXBsZW1lbnQgdGhlc2UgY2hhbm5lbHMgaW4gX2N0cmwuYyBmaWxlcywgdXNp
bmcgbXVsdGlwbGUgcHJvdG9jb2xzLiANCj4+IFdoeSBjYW4ndCB5b3UgZG8gc29tZXRoaW5nIHNp
bWlsYXIgYW5kIGxldCBkZXZsaW5rIG91dCBvZiB0aGlzIHBsZWFzZT8NCj4+DQo+PiBVbnRpbCB5
b3UgcHV0IGluIGFyZ3VtZW50cyB3aHkgeW91IHJlYWxseSBuZWVkIGRldmxpbmsgYW5kIHdoeSBp
cyBpdCBhIA0KPj4gZ29vZCBmaXQsIEknbSBhZ2FpbnN0IHRoaXMuIFBsZWFzZSBkb24ndCBzZW5k
IGFueSBvdGhlciB2ZXJzaW9ucyBvZiANCj4+IHRoaXMgcGF0Y2hzZXQgdGhhdCB1c2UgZGV2bGlu
ay4NCg0KPlRoZSB0N3h4IGRyaXZlciBhbHJlYWR5IGhhcyByZWd1bGFyIHd3YW4gZGF0YSBhbmQg
Y29udHJvbCBpbnRlcmZhY2VzIHJlZ2lzdGVyZWQgd2l0aCB0aGUgd3dhbiBmcmFtZXdvcmssIG1h
a2luZyBpdCBmdW5jdGlvbmFsLiBIZXJlIHRoZSBleHBvc2VkIGxvdyBsZXZlbCByZXNvdXJjZXMg
YXJlIG5vdCByZWFsbHkgd3dhbi9jbGFzcyBzcGVjaWZpYyBhcyBpdCBpcyBmb3IgZmlybXdhcmUg
dXBncmFkZSBhbmQgY29yZWR1bXAsIHNvIEkgdGhpbmsgdGhhdCBpcyB3aHkgSmluamlhbiBjaG9z
ZSB0aGUgJ2ZlYXR1cmUgYWdub3N0aWMnIGRldmxpbmsgZnJhbWV3b3JrLiBJTUhPIEkgDQo+dGhp
bmsgaXQgbWFrZXMgc2Vuc2UgdG8gcmVseSBvbiBzdWNoIGEgZnJhbWV3b3JrLCBvciBtYXliZSBv
biB0aGUgZGV2Y29yZWR1bXAgY2xhc3MuDQoNCj5UaGF0IHNhaWQsIEkgc2VlIHRoZSBwcm90b2Nv
bCBmb3IgZmxhc2hpbmcgYW5kIGRvaW5nIHRoZSBjb3JlYm9vdCBpcyBmYXN0Ym9vdCwgd2hpY2gg
aXMgYWxyZWFkeSBzdXBwb3J0ZWQgb24gdGhlIHVzZXIgc2lkZSB3aXRoIHRoZSBmYXN0Ym9vdCB0
b29sLCBzbyBJJ20gbm90IHN1cmUgYWJzdHJhY3RpbmcgaXQgaGVyZSBtYWtlcyBzZW5zZS4gSWYg
dGhlIHByb3RvY29sIGlzIHJlYWxseSBmYXNib290IGNvbXBsaWFudCwgV291bGRuJ3QgaXQgYmUg
c2ltcGxlciB0byBkaXJlY3RseSBleHBvc2UgaXQgYXMgYSBuZXcgZGV2aWNlL2NoYW5uZWw/IGFu
ZCByZWx5IG9uIGEgdXNlcnNwYWNlIA0KPnRvb2wgZm9yIHJlZ3VsYXIgZmFzdGJvb3Qgb3BlcmF0
aW9ucyAoZmxhc2gsIGJvb3QsIGR1bXApLiBUaGlzIG1heSByZXF1aXJlIHNsaWdodGx5IG1vZGlm
eWluZyB0aGUgZmFzdGJvb3QgdG9vbCB0byBkZXRlY3QgYW5kIHN1cHBvcnQgdGhhdCBuZXcgdHJh
bnNwb3J0IChpbiBhZGRpdGlvbiB0byB0aGUgZXhpc3RpbmcgdXNiIGFuZCBldGhlcm5ldCBzdXBw
b3J0KS4NCg0KQXMgZmFyIGFzIEkga25vdywgdGhlc2UgcGF0Y2ggc2V0IGNyZWF0ZWQgYnkgSW50
ZWwgY29sbGVhZ3VlLiBsYXRlciwgaXQgd2FzIGhhbmRlZCBvdmVyIHRvIG1lIGZvciBmdXJ0aGVy
IGZvbGxvdy11cC4gSSByZW1lbWJlciBJbnRlbCBjb2xsZWFndWUgbWVudGlvbmVkIHRoYXQgdXNp
bmcgZGV2bGluayBmcmFtZXdvcmsgaXMgYW4gb3Blbi1zb3VyY2Ugc3VnZ2VzdGlvbiwgYnV0IEkg
dW5hYmxlIHRvIHZlcmlmeSB0ZW1wb3JhcmlseS4NCkFmdGVyIEkgcmVhZCB0aGUgZGV2bGluayBm
cmFtZXdvcmssIEkgZm91bmQgdGhhdCB0aGUgY29tcG9uZW50cyBvZiBkZXZsaW5rIGxpa2UgZmxh
c2ggYW5kIHJlZ2lvbiBjYW4gYmUgdXNlZCB0byBpbXBsZW1lbnQgdGhlIGZlYXR1cmVzIG9mIGZp
cm13YXJlIGZsYXNoaW5nIGFuZCBjb3JlZHVtcCBjb2xsZWN0aW9uIHdpdGhvdXQgb3RoZXIgdXNl
ciBzcGFjZSBhcHBsaWNhdGlvbiBhbmQgd3dhbiBpb3NtIGRyaXZlciBhbHNvIHVzZSBkZXZsaW5r
IGZyYW1ld29yay4NCg0KWWVzLCBpdCBzZWVtZWQgbXRrX3Q3eHggZHJpdmVyIGNhbiB1c2UgZmFz
dGJvb3QgcHJvdG9jb2wgZm9yIGZsYXNoaW5nIHdpdGggZmFzdGJvb3QgdG9vbCBidXQgSSB0aGlu
ayB0aGlzIHdpbGwgcmVzdWx0IGluIHNvbWUgb3RoZXIgdGFza3MgY29tcGxldGluZyB0aGVzZSBm
ZWF0dXJlczoNCjEuRHJpdmVyIGV4cG9ydCBhIHBvcnQgdG8gdXNlciBzcGFjZSBmb3IgZmFzdGJv
b3QgdG9vbCBhbmQgdGhpcyBwb3J0IG11c3QgYmUgc2NhbiBieSBmYXN0Ym9vdCB0b29sIGZvciBm
aXJtd2FyZSBmbGFzaGluZyBmZWF0dXJlLg0KMi5BIG5ldyB0b29sIHdpbGwgYmUgbmVlZGVkIGZv
ciBjb3JlZHVtcCBmZWF0dXJlIGFuZCBkcml2ZXIgd2lsbCBhZGFwdGVyIGZvciB0aGlzIHRvb2wg
Zm9yIG1vZGVtIGRldmljZSB1c2UgdGhlIHNhbWUgY2hhbm5lbCBmb3IgZmFzdGJvb3QgYW5kIGNv
cmVkdW1wLiANCg0KSUYgd2UgdXNlIGRldmxpbmsgZnJhbWV3b3JrLCBpdCBzZWVtZWQgbW9yZSBj
b21wbGV0ZSBhbmQgdW5pZmllZC4gU28gSSBob3BlIGl0IGNhbiBiZSBhbGxvd2VkIGFuZCBJIHdv
dWxkIGxpa2UgdG8gY29uZmlybSBpZiB0aGUgY3VycmVudCBkcml2ZXIgY2FuIGNvbnRpbnVlIHVz
aW5nIGRldmxpbms/DQpIb3BlIHRvIGdldCB5b3VyIGhlbHAgdG8gbWFrZSBzdXJlIHdoZXRoZXIg
dDd4eCBjYW4gdXNlIGRldmxpbmssIGlmIGNhbid0ICwgd2UgbWF5IG5lZWQgdG8gY29uc2lkZXIg
b3RoZXIgc29sdXRpb25zLg0KDQpSZWdhcmRzLA0KSmluSmlhbg0K
