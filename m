Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF08F77B966
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjHNNIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjHNNHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:07:43 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2093.outbound.protection.outlook.com [40.107.247.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDECE65;
        Mon, 14 Aug 2023 06:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrsjNSePg8HJR+aQPYzRAhaAyo6V0ACQF+s80VXuYzSKim3pW5L+V6y2hCpZoOlKmj90E+465ArMNOdTUFvm0oPdzX0XcIUnuSbs3yrGB5a7flfuXF98hXsLLyHoKbZJpcVcBlAY7+4uA/iNo8FCL10pSrESE5A8Ppp209/2maOz8KWnSz7hfIAndQoV3/UidbZWf9j343UZQAkGp2QLyrZRGWQvpjW5QjTMSF1udWzml/Ac7e8kYo9t4+woJbb9vCI2RW89U1j1aZFnz4tek8/E37hHRXP3TUUJttAuu6o0SF6S/syQZpbbTf3zdw/cEosSUAQtrV8PuXuaWOrNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgV2z+pmoDGz9G3xekhEyoYtS7mBXzrM2T9xacgxM7k=;
 b=JAhoPVIBh27r+xewvjAltcultP3Fn6S8xJ0gn9ONFoHviKbvnk/gB/cnGMzTWKgX/YH4kFtjabJnzC1U5u5K3KYWk54xvWnqTlrMHUdSeLeXtmwUx19/MOs2Le1+65915snco4uSshhLTKOcMSJNwHPdtiE0bW44hnuCAQoQ0rE202hR0V2uBq75IwhaeSV8dWlVJ/r3OY5yPPTZLY7jlREl+v0/firLDi9VND1Fkc1KAktH5LQjFn36sda6VnKlV3+kZL/ieHxGLsHqVws/R0tzuD8qFPyGUjjdqhQvjmZx4mTyn7Of5wvL0CEOkNS4xaYIts1xMZOH0/Vgk5q0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgV2z+pmoDGz9G3xekhEyoYtS7mBXzrM2T9xacgxM7k=;
 b=cvh7KXl+PbmIhYYW7qrDI/QuF843LLoQ1dmSS4C48rKJrYvADcRyogGnX+5GyrnY9PLw1Keuvp/eYrgjAPJRkGT5G2sW4EQZAPXNEdvjM+LEf99wRgBQgP8oyBLIo4WRMZJtpU1EF4JwMbYXo6op9nMHZLxPmo9rFRK5nLj0nl8=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by VE1PR04MB7406.eurprd04.prod.outlook.com (2603:10a6:800:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 13:07:37 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 13:07:37 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver
Thread-Topic: [PATCH] Add Silicom Platform Driver
Thread-Index: AQHZuZEcSTfJXOh+tEO5M8hB8nDqzq/BAaYAgAhCLzCAD07vAIAIVRGwgAMN/4CABfeDAA==
Date:   Mon, 14 Aug 2023 13:07:37 +0000
Message-ID: <PA4PR04MB92220B529E4B24219878767F9A17A@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <94cbb7d-68a-765-8bdf-5c8f8e41891@linux.intel.com>
 <PA4PR04MB922224D96319862CF987FE459A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <58da791d-866c-ce2f-94bb-1feff8506c2@linux.intel.com>
 <PA4PR04MB922238E924D10FE9A5B2625D9A13A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <a44a0433-9afc-a73a-43f9-6489ecf2c533@roeck-us.net>
In-Reply-To: <a44a0433-9afc-a73a-43f9-6489ecf2c533@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|VE1PR04MB7406:EE_
x-ms-office365-filtering-correlation-id: 72988b28-5928-44bc-e4d7-08db9cc76ed9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t6dC1kmkdU/Ayu7FiX6f2B6vh1BVdM1VsVV0nMYvFTKWg+XNnFigp32uPwp6Z/guW4du62qOK3ZA1pOld0+fGrR2GiH/QYGxZJecF/y2XRjm5bDJpidVrFnwBY8NaRCi7c679lgFCONza1YJTg3QptesLeIGUNOE+UeOOfn8+5x/jZobHCEOzyL/9t74znUTZr/487aSBJWKvR9Bt6CJ4+Z/VAQ8BlQDB6qXVZRpVQhwoMbY4fyRAqOa5wLGZUG89XhH7HmXYnLo6CXBSxctXmEAC19GSaZr23IuOvsAaZTysBzakiZRmGyRHvgQoQDir5StgNuTW+Wex8iTESY93UIGxSzFSVaqsgoP/iOJPYwvNzKikBSCvnnySlIznwGs9x6tOgDG4sbxx7B+14/4tclNdh+cTbRUjQDS8SuTgyh9hCdHQyl/j7jtPsVvfn8fs+NS9odl6JQC0MJjPA8CWNpKbibGEpdsKULCMLFyAUniBptEfqsdWdaER4bElicRCSCoSLyzx5TASXkAWX86FjJ265E0l1Cu1qvDgbqLYX5EPcEaz3Jqc/2Nx9NAxnXkPf8DaUtt1vSlHsJlyInSRJf+2zVFhX/zR9ZvROeytUI5tmMMKH9BmkB22h2W4XiZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(366004)(346002)(396003)(376002)(136003)(451199021)(1800799006)(186006)(71200400001)(45080400002)(76116006)(110136005)(6506007)(7696005)(478600001)(66574015)(33656002)(86362001)(83380400001)(7416002)(55016003)(107886003)(66946007)(53546011)(2906002)(9686003)(38070700005)(38100700002)(122000001)(316002)(52536014)(4326008)(66556008)(64756008)(66476007)(8676002)(54906003)(66446008)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2JGdFZZRWVldkhYREJkYmRtaUIveWpJSUFmQnJzV2t1ZC9QRm5sMktVV2Ny?=
 =?utf-8?B?K21vd3JUSzFROVoxbFRzZkdxbVIyMTJvMTh3b2hWL3RXUitlNmRiMkN4MFdR?=
 =?utf-8?B?QmNUT3BoS0NoMml5cVYzbjc1VkM1RnRWdW9XUm94YVg5bFFGYldHSG5tS3cv?=
 =?utf-8?B?ekNkLzN5MTdmaWs4SjBrL2NNbVlQVkUreE9IWU5vd1JENjJLWHNyOTExZFhX?=
 =?utf-8?B?bVU1Tyt1cXBLaTBSRERiRUd1WC9TaHA5RWJmTEhiSVo4d3psUEdoc241Tld0?=
 =?utf-8?B?RjBZaThPSjF3NUJ2OHF6S09DRWRKUVR2dDJocEpDQjJ5eElmMHE4cm95VVph?=
 =?utf-8?B?RHdTL3Zqc0NDMTcxU211aXZWaDNHQnFGbjVpREJLZXlZSVZaUlg1b1IrTDFh?=
 =?utf-8?B?bDZTUUpNWG1XeEdNd2tmTlpMNkJWM1RvNjU4cEovNk1ZQ1lrZlVtcUhFMW5N?=
 =?utf-8?B?UllsdmNCdnkxdnIxRkRLVCtIUTd6MitZZHo3Sk9LeW5YUlduWEdHa1RxRnBY?=
 =?utf-8?B?YllzN0w5ZlVTcGVjM0RWU2NvcTQyRWt3QmQvUnpjRWtBUlZ5U0FFVW5IL2Jl?=
 =?utf-8?B?RHdpeUFyMUpRTjJ1N1l6TzgvWTl5aHBwVWZ6eHhiQkN1K1pBVTcrMUIvY2tP?=
 =?utf-8?B?cFVyTC9XK2M1UThwMkhibC9pQmdwZVZ1dURFREllbUVtelpYeUcvZUFrM3JB?=
 =?utf-8?B?OTRTSDF1clc3NW44VUN1N3U3NFdoUVFNekZyMlp6bFpYTjNIMTAwK0xhSHIw?=
 =?utf-8?B?ZktJcWltM1ZYTDd1dHpvZGdsTWxoQU4rZGxjMWEvNE9MT0pHQkc2S2tWY09h?=
 =?utf-8?B?a3llL2dMNFJjcHRTazAzQy9OYTZTaHFTRG5GTzliZlVjVXk0ZEQ3WmlIcEhE?=
 =?utf-8?B?eEFLdFc3eEhuTzAxcXBVWEFWbjkyZXlXSFNkbDY3b1c2ZXVWMWcyeVVTNkxG?=
 =?utf-8?B?bC9lU2VZalZtb2hIcnBvMlVpRzRvQmtOdmU0NkYrTjVtK0NNWmVKY3ppaWVO?=
 =?utf-8?B?WmV4RFBveWxzaE54czg5d1I1RlBvbFlmYnIwSVBpdTZZblA5QW9qM2RHYlhZ?=
 =?utf-8?B?eEVFaXdHb3BPNGdUTUlrR0ZJU0NEdFNJMTUrVFE4LzFybVpjSkNzVzFNSy9B?=
 =?utf-8?B?MVdwTDkyUFVXRm5EdmJ2ejkwVnBpdkFpV3RXVkRiK0g3bDA3Y0VLWjNkNW0r?=
 =?utf-8?B?dGtsSzJqWms1MWI1Q3A4U1BnM2FoQTN4cVRrdHYrMTFHTmJGNWdFNGN0RzZ5?=
 =?utf-8?B?NWZ0WktDZmwyMUFzTXZOOXluQU52Q2NnS1RWZFZpUUtFYzByUStOYm4zVWls?=
 =?utf-8?B?K0VjSUFnRWRlVitkRXVYZWwwY3NKTXczMmF3YWVuM0dvbTFyQi96MlkrbkJH?=
 =?utf-8?B?c2NjcitFSWhjTWNMY3JXc2RMTmZ0eGNobzhwNEt2cjRHUnViakNMSFg5Z1E2?=
 =?utf-8?B?QTRPM1Z0d1gwTTFHWWJxOWFwdDllaU9ObDlIUGJ2dGRheWcrdk1qUDdicG56?=
 =?utf-8?B?eTlxTWdGZzZhM0xRZC9aWmtkSzU5cjFRd1F0VjJpcTl5QlpManVxVzVTQXlr?=
 =?utf-8?B?Vm5ORVYvMkJFV3VpMmEzaFlmdlRReHRZdzhHem5TTjVnRmRuNWF0Vjlkbm1k?=
 =?utf-8?B?bGVWMGc4c1RYYzAzM1ArdTRUL055d1lXUTVKemZScDFjYVI4WWNKZVl4S29m?=
 =?utf-8?B?WDYzOGQ0SzI4STk1azluVVdhVlFvU3M0akxKZS9xelA0NkhvM0JKcFhtMmVL?=
 =?utf-8?B?dTFZR0s4dG1ZNUg2UDZVZE9wZVRxWHF5QkVPOVd5TXVpa0xiQmVXV0JGcEs1?=
 =?utf-8?B?VHRhM1JBTWREYjUzYUkxS3lFcDRlQ1F0OHZwMjZnOWdCclY4NXlvZGU5SHFw?=
 =?utf-8?B?U0huaDZ3UkRTVXA3QWRsZUluclJVUFp2Sk9ZVFkyK2dEdlJmaWZweW1QM1Q5?=
 =?utf-8?B?dnNCb1RWeVVEcW9DWHR2ZHNCN2xJZjI4Q2VIWnhqSFNFZjVUL3lma1JoVm9M?=
 =?utf-8?B?VXdIR21NSjdPeU1UcHh4VzFQUmVVNHNReElSTittRXUxU1oyQmdqWlhTc1hi?=
 =?utf-8?B?RnhnbERqREhrMDY4bDFidnE4QWtKSkl2ZjNJVWkwWW9YOTlMSWRXbmU4ZUsr?=
 =?utf-8?B?VW5HNDFPMTJvd2lnOE1HZkNGMUlsdW93TVdFV1pXNjBQOVdmNmp3dTZGZE12?=
 =?utf-8?Q?sxEEtMol0n/Cic5euCr7KXGsKxo+usDMIKp+gV5Gb/w2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72988b28-5928-44bc-e4d7-08db9cc76ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 13:07:37.5121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMpmp6MJ46bQJnopupsPcooS6VQPLfiivd1H7z8oh7SDPGF0fMA5rn2+ajig+vc9RUd4hmtd/Ksh0jHWmgoSTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7406
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBHdWVudGVyIFJvZWNrIDxncm9l
Y2s3QGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIEd1ZW50ZXIgUm9lY2sNClNlbnQ6IFRodXJzZGF5
LCBBdWd1c3QgMTAsIDIwMjMgMjowMCBQTQ0KVG86IEh1aWJpbiBTaGkgPGhlbnJ5c0BzaWxpY29t
LXVzYS5jb20+OyBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+
DQpDYzogdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGU7
IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmc7IGhwYUB6eXRvci5j
b207IGhkZWdvZWRlQHJlZGhhdC5jb207IG1hcmtncm9zc0BrZXJuZWwub3JnOyBqZGVsdmFyZUBz
dXNlLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgcGxhdGZvcm0tZHJpdmVyLXg4
NkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZzsgaGJfc2hpMjAw
M0B5YWhvby5jb207IFdlbiBXYW5nIDx3ZW53QHNpbGljb20tdXNhLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0hdIEFkZCBTaWxpY29tIFBsYXRmb3JtIERyaXZlcg0KDQpDYXV0aW9uOiBUaGlzIGlz
IGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mg
b3Igb3BlbmluZyBhdHRhY2htZW50cy4NCg0KDQpPbiA4LzEwLzIzIDEwOjQ4LCBIdWliaW4gU2hp
IHdyb3RlOg0KPiBJbHBvLA0KPg0KPiBTZWUgbXkgY29tbWVudHMgYmVsb3cuDQo+DQo+IFRoYW5r
cy4NCj4gSGVucnkNCj4gLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbHBvIErD
pHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5
LCBBdWd1c3QgMywgMjAyMyA4OjA3IEFNDQo+IFRvOiBIdWliaW4gU2hpIDxoZW5yeXNAc2lsaWNv
bS11c2EuY29tPg0KPiBDYzogdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBi
cEBhbGllbjguZGU7IA0KPiBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IHg4NkBrZXJuZWwu
b3JnOyBocGFAenl0b3IuY29tOyANCj4gaGRlZ29lZGVAcmVkaGF0LmNvbTsgbWFya2dyb3NzQGtl
cm5lbC5vcmc7IGpkZWx2YXJlQHN1c2UuY29tOyANCj4gbGludXhAcm9lY2stdXMubmV0OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyANCj4gcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZzsgDQo+IGhiX3NoaTIwMDNAeWFo
b28uY29tOyBXZW4gV2FuZyA8d2Vud0BzaWxpY29tLXVzYS5jb20+DQo+IFN1YmplY3Q6IFJFOiBb
UEFUQ0hdIEFkZCBTaWxpY29tIFBsYXRmb3JtIERyaXZlcg0KPg0KPiBDYXV0aW9uOiBUaGlzIGlz
IGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mg
b3Igb3BlbmluZyBhdHRhY2htZW50cy4NCj4NCj4NCj4gT24gRnJpLCAyOCBKdWwgMjAyMywgSHVp
YmluIFNoaSB3cm90ZToNCj4NCj4+IElscG8sDQo+Pg0KPj4gVGhhbmtzIGZvciB0aGUgY29tbWVu
dHMuIFNlZSBteSBjb21tZW50cyBiZWxvdy4NCj4+DQo+PiBVcGRhdGVkIHBhdGNoIHdpbGwgYmUg
c2VudCBvdXQgbGF0ZXIgYWZ0ZXIgcmV2aWV3IGNvbW1lbnRzIGZyb20gb3RoZXIgcmV2aWV3ZXIg
YXJlIGFkZHJlc3NlZC4NCj4+DQo+PiBIZW5yeQ0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNv
bT4NCj4+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxOSwgMjAyMyA4OjEzIEFNDQo+PiBUbzogSGVu
cnkgU2hpIDxoZW5yeXNoaTIwMThAZ21haWwuY29tPg0KPj4gQ2M6IGhic2hpNjlAaG90bWFpbC5j
b207IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgDQo+PiBicEBhbGllbjgu
ZGU7IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmc7IA0KPj4gaHBh
QHp5dG9yLmNvbTsgaGRlZ29lZGVAcmVkaGF0LmNvbTsgbWFya2dyb3NzQGtlcm5lbC5vcmc7IA0K
Pj4gamRlbHZhcmVAc3VzZS5jb207IGxpbnV4QHJvZWNrLXVzLm5ldDsgTEtNTCANCj4+IDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5l
bC5vcmc7DQo+PiBsaW51eC1od21vbkB2Z2VyLmtlcm5lbC5vcmc7IGhiX3NoaTIwMDNAeWFob28u
Y29tOyBIdWliaW4gU2hpIA0KPj4gPGhlbnJ5c0BzaWxpY29tLXVzYS5jb20+OyBXZW4gV2FuZyA8
d2Vud0BzaWxpY29tLXVzYS5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBBZGQgU2lsaWNv
bSBQbGF0Zm9ybSBEcml2ZXINCj4+DQo+PiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVt
YWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRh
Y2htZW50cy4NCj4+DQo+Pg0KPj4gT24gVHVlLCAxOCBKdWwgMjAyMywgSGVucnkgU2hpIHdyb3Rl
Og0KPj4NCj4+PiBUaGUgU2lsaWNvbSBwbGF0Zm9ybSAoc2lsaWNvbS1wbGF0Zm9ybSkgTGludXgg
ZHJpdmVyIGZvciBTd2lzc2NvbSANCj4+PiBCdXNpbmVzcyBCb3ggKFN3aXNzY29tIEJCKSBhcyB3
ZWxsIGFzIENvcmRvYmEgZmFtaWx5IHByb2R1Y3RzIGlzIGEgDQo+Pj4gc29mdHdhcmUgc29sdXRp
b24gZGVzaWduZWQgdG8gZmFjaWxpdGF0ZSB0aGUgZWZmaWNpZW50IG1hbmFnZW1lbnQgDQo+Pj4g
YW5kIGNvbnRyb2wgb2YgZGV2aWNlcyB0aHJvdWdoIHRoZSBpbnRlZ3JhdGlvbiBvZiB2YXJpb3Vz
IExpbnV4IA0KPj4+IGZyYW1ld29ya3MuIFRoaXMgcGxhdGZvcm0gZHJpdmVyIHByb3ZpZGVzIHNl
YW1sZXNzIHN1cHBvcnQgZm9yIA0KPj4+IGRldmljZSBtYW5hZ2VtZW50IHZpYSB0aGUgTGludXgg
TEVEIGZyYW1ld29yaywgR1BJTyBmcmFtZXdvcmssIA0KPj4+IEhhcmR3YXJlIE1vbml0b3Jpbmcg
KEhXTU9OKSwgYW5kIGRldmljZSBhdHRyaWJ1dGVzLiBUaGUgU2lsaWNvbSANCj4+PiBwbGF0Zm9y
bSBkcml2ZXIncyBjb21wYXRpYmlsaXR5IHdpdGggdGhlc2UgTGludXggZnJhbWV3b3JrcyBhbGxv
d3MgDQo+Pj4gYXBwbGljYXRpb25zIHRvIGFjY2VzcyBhbmQgY29udHJvbCBDb3Jkb2JhIGZhbWls
eSBkZXZpY2VzIHVzaW5nIA0KPj4+IGV4aXN0aW5nIHNvZnR3YXJlIHRoYXQgaXMgY29tcGF0aWJs
ZSB3aXRoIHRoZXNlIGZyYW1ld29ya3MuIFRoaXMgDQo+Pj4gY29tcGF0aWJpbGl0eSBzaW1wbGlm
aWVzIHRoZSBkZXZlbG9wbWVudCBwcm9jZXNzLCByZWR1Y2VzIA0KPj4+IGRlcGVuZGVuY2llcyBv
biBwcm9wcmlldGFyeSBzb2x1dGlvbnMsIGFuZCBwcm9tb3RlcyBpbnRlcm9wZXJhYmlsaXR5IA0K
Pj4+IHdpdGggb3RoZXIgTGludXgtYmFzZWQgc3lzdGVtcyBhbmQgc29mdHdhcmUuDQo+Pj4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBIZW5yeSBTaGkgPGhlbnJ5c2hpMjAxOEBnbWFpbC5jb20+DQo+Pj4g
LS0tDQo+Pj4gICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnICAgICAgICAgICAgfCAgIDEy
ICsNCj4+PiAgIGRyaXZlcnMvcGxhdGZvcm0veDg2L01ha2VmaWxlICAgICAgICAgICB8ICAgIDEg
Kw0KPj4+ICAgZHJpdmVycy9wbGF0Zm9ybS94ODYvc2lsaWNvbS1wbGF0Zm9ybS5jIHwgMTEyMw0K
Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDExMzYg
aW5zZXJ0aW9ucygrKSAgY3JlYXRlIG1vZGUgMTAwNjQ0IA0KPj4+IGRyaXZlcnMvcGxhdGZvcm0v
eDg2L3NpbGljb20tcGxhdGZvcm0uYw0KPj4+DQo+DQo+Pj4gK3ZvaWQgbG9ja19pb19tb2R1bGVz
KHZvaWQpDQo+Pj4gK3sNCj4+PiArICAgICBtdXRleF9sb2NrKCZtZWNfaW9fbXV0ZXgpOw0KPj4+
ICt9DQo+Pj4gK0VYUE9SVF9TWU1CT0wobG9ja19pb19tb2R1bGVzKTsNCj4+PiArDQo+Pj4gK3Zv
aWQgdW5sb2NrX2lvX21vZHVsZXModm9pZCkNCj4+PiArew0KPj4+ICsgICAgIG11dGV4X3VubG9j
aygmbWVjX2lvX211dGV4KTsNCj4+PiArfQ0KPj4+ICtFWFBPUlRfU1lNQk9MKHVubG9ja19pb19t
b2R1bGVzKTsNCj4NCj4gVGhlc2UgYXJlIHVudXNlZC4NCj4NCj4gSGVucnk6IFRoaXMgd2lsbCBi
ZSB1c2VkIGJ5IGFub3RoZXIgU2lsaWNvbSBkcml2ZXIsIHdoaWNoIHNvdXJjZSBjb2RlIGlzIG5v
dCBwdXNoZWQgdG8ga2VybmVsIHJlcG9zaXRvcnkuDQo+DQoNCk5vdCBhbiBhcmd1bWVudC4gRXhw
b3J0IGl0IGlmIGFuZCB3aGVuIG5lZWRlZC4gSWYgdGhhdCBvdGhlciBkcml2ZXIgd29uJ3QgYmUg
c2VudCB1cHN0cmVhbSwgdGhlIGV4cG9ydCBzaG91bGQgbm90IGJlIHVwc3RyZWFtIGVpdGhlci4N
Cg0KSGVucnk6IE9LLCB3aWxsIHJlbW92ZSB0aGVzZSB0d28gRVhQT1JUIGZ1bmN0aW9uDQoNCkd1
ZW50ZXINCg0K
