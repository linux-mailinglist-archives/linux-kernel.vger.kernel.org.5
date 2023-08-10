Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6017779E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjHJNsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjHJNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:48:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2093.outbound.protection.outlook.com [40.92.98.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2802129;
        Thu, 10 Aug 2023 06:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnqW0kBTEOHUMq0LxnPk273uYoJbIri66EU7gHm7HmJe+tBWb4BB9jfRGQzhWka+uPJgbOTgwsw7+cULYj6uMhCHG0SEs7iWGWSup1FGG0Ed7uo2HFGZ/v1TWcRkAFVxWot8RkOutRfgbxNuIcFHhzr/mxKD2aAS2k4BOOR22hE94IXnlqgTpnDlckHm/uXBw3XubRDhh/8wMvZJcnCMDAtLNG38cyHkkGo3eYqqy0W6F0CKAKISBjXFajHzPRrKoPlEhAD102EprbVJNDAB9d+WlWU6yhSKDKZCSObKS6phuAp9wDfLEcbHibvhKeGA14hR/bTvja+v3Zlkd0Tydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtHj/m4idsVYj7SfXszLy2N7vU2cJNDZc/OjoKp7Cqw=;
 b=hnDdWDkJIxWr0RGzvuAf+ciDyNaci1MVnqDGq5/zL6japFxob1Jy2FpEw7GDUNoRmb5ta8ujV8oBUOCTMhdWM1aUldnFDY+5bpj1BFCFC6nhd1seQfzvUuBg86AtDQ1sDdiuLO4Oxnzj3eSbwMvHceycGDrBSrzcP8IcS8jzfSM79hXQ0UtzO/elTjRAq84MWJYRcmz3zs/uFT6+x/WBzqxWBnWpD6yKZ5E5v00ZEhS8zMIGUJEMl9WxIfC/DcWbbjEEkba9U/Oi3AGlJZOY8g5SgCaJgTGveorqqRJd1MAwsYqkybN265JfSi1IA6TZgEyqny4Z/VCmQvZB8+pUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtHj/m4idsVYj7SfXszLy2N7vU2cJNDZc/OjoKp7Cqw=;
 b=uOb1aWHjvT0YZlh9OYMDiG5jW1oZ3Hkur/8iftTs6bTE2KR39OoKn1GUWa4KJZ1yMH97LvHsMOB9CLcU2wxteAz/GbMgptziLzdTe+YNTOZKzo5Ew/KqBkzgNldmc3pTlvS2srwepwIYvSWOlMETzjFdRPil3Iatd049wBlXxXiAKXQ3hozfAI8rNNc5Se4mFlNQLxMiiXhoVEsitYXsjxvffhb4UmoEavA57zNFYJhHHbdFLVVxUr/3kZiwnP8ewRGzOjUy/bwjeQcd6t+JWwrOci0BCk2n7dKGocp0SwyymTBeUuRoy4qE/rmu40f5km3hBkQ4Okx+PJF6NaA4kQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TY3P286MB2769.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:255::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 13:48:39 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 13:48:38 +0000
Message-ID: <TY3P286MB26110563ACD4C197532D0C8E9813A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Thu, 10 Aug 2023 21:47:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     wiagn233@outlook.com, bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x-bone-common: Add GPIO PHY reset
 on revision C3 board
To:     Tony Lindgren <tony@atomide.com>
References: <20230806085044.1917-1-wiagn233@outlook.com>
 <TY3P286MB26113797A3B2EC7E0348BBB2980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230809072846.GD11676@atomide.com>
 <TY3P286MB2611D8048AC78466459C47759812A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230810062717.GI11676@atomide.com>
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <20230810062717.GI11676@atomide.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------i1aPyvpilZ2VvrxKFBv33dFW"
X-TMN:  [cMcRQn4VcbWUc4cY/LXqRU1IWCcByvKkZCEcWcgAFQbjr/sZqMqrcsg1KdhT8iHM]
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <325e87ed-adc3-5646-6fb1-e3c25ad758a2@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB2769:EE_
X-MS-Office365-Filtering-Correlation-Id: a82df2c0-060e-40da-3a18-08db99a87ff3
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrno9wjYAXKTGsdm+oJuqSDEv7V/332WTwvYfMTTc6AlP/2Jq4fEuhAkE8V4XBPCGdBo/LNcLoTJYSPFM/hCYA8X3TkiORsbqoDVe7C8XF0IbC6IKvwJQk+TC91CJFQkIfbvrohKJljYvMu87Q4TCMfshcvJNG/qvRMUFcnqExbHq7nIYRebJNXLbGExnzBWFO1doU4JcdQEasA48lOk/k2GNtu48TXTvdMcfjUGO3KOL1Fy8MwsBx99WJdZeVYUmTMTooR7a0JVAvA2z3U0gM0KdVnXLMWoliMmBm72E8pSbHW7L1hmps3vt0qGKTP53d98+A4qA8cqjQeI199rudRDIK2/N6zZeC/9DLA7KSPgmsCFoMAQBL18TTteKdPZegn/n+IUeOqW9PqsF724wHEQwE2BORHUx+xzyjEcA+jok2OZvTgIUGTQKTkYJ0HblnXUXGKdsGaXcCfkYVDmwM67hETQkVgi6uNdXLsRItnyFickr80RjrioGBw9NO66ZPgLHXfRM8pO/S/2lV80w/rhs8fhWK6OYuxckVHHYSsAuyFRENGczQsx/Hy1BtfRx2m73lm0l0v8RlCrqhuNxuzFkHQs5NcwMIvPAGFj6BYxaKjwwJb7agFFIpy8QB0zDUNkObLx9n/6GyQCa+go96s4QFbBpirCTnzbPzQIGSv6ui9M78zjL6PfeNDTRD47Phpo8kHRXTXgUrw36Y/goxYAfG0ow1Qlox1lgZXMjumbSv3dFg3OkR7/MYP8ZENIIAWM=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgbHbyNIwfc9MAl9MrO5fM7SZ+jrkRr9B7nxwhBVkfdcSqhp0jRCOWFAG7PRbseRmku6ql1zHi8sobIiwEJsBol4sOGEVhiXMmG9LH8t0HsiNu47tvkTpvApcY2oAS43b6KTfJIraAxdi6mIjzWHMTnpbH2lpSZ0JhqqKaqbSBi/ChN1iF53Cbmh/n6j6Ckjn00ViAiv2P0bpS26npq2qlCpYJxbvWg/GCnZx9TSwK77gF9T+Hy44r1E3E/qyvLsc1aJ49bBISI4cln5orMCMXLuLoG0fdaJXKfQGFOOEfuvAtGP29ObD4AsLjR0sxqhC0kGQtyZLmmb7Rhg6+XGx14ZJ2KkbFAaZNxEk0NP2kkxefqIrLIlJp3TOFCcGgCNUA22xsUdasiMbPAs3CqkXUrm+BlLMqTAutOgIjzb/DIHysiJEhx1C/7umwBNfvqtmzivHYO5F151wrguDftuHQ3m00lLNamGkZyjhKivln7JB4HTCV2PSLFhGD06rbwSGQVn3XjbO7ARhwb8jfeZveCbrrAoUmbJlJ24zbkTVPRFD8KkjRDMImiGdl0TJh1OlgtNhYH5oUbN8dtK2HM76qOW002psN0Cb8FDabkunfuoxJUmGoM2F6uyjnY/stG/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czllV2h6VGJsT0cxdjl3bWJCQVJ6ZlMvWWFKNytic2k3SjVTc1RsdkZ5TTNj?=
 =?utf-8?B?MjRUK3gyamo4Q3RkaXZpM0d2ZVp5M2pOWU9GczVicDF3SERyczgzY3hUN3l6?=
 =?utf-8?B?enNoWXV5aEpiUG9DWmxPTTBVejZTZ1Z2b2VLMmx6N21iYkZCek1pbEtFSVN0?=
 =?utf-8?B?WEN4bE5Lc25QWnpFeVlmT2dJbTdIWEtTUUVJY0NhT1grMjkrMWJqQ0paTWs0?=
 =?utf-8?B?NVZ1ZmE5eFBCeXRkUTloS01sanBEbTN3MjNaaFNibDRiZWhhWklsRUxyYXFO?=
 =?utf-8?B?WWIrRWFML3paSExITGpJZUlSVm1WWk00WVRsYUhPL2hoL1BzL0tUaERmNWEy?=
 =?utf-8?B?UnNEUjYrVG1KanI3RDFwMk1rbVgveHFDNWRzemZYalFpQnVMcTdBK2NOYnph?=
 =?utf-8?B?bmhOVm9RV09GUHdNVWNOVHpxbHhpZG1jNVhTb1lITTVtM0srODZBc1ZFaE1o?=
 =?utf-8?B?U2d0SnBMdmN2NjgxTE90dEJONEZqMzBtZWVzQVhLa2RyejFSUmRuRGJHZ1li?=
 =?utf-8?B?NUdZN1NmMmc5VmlPR2lXbW52MTRNeWRDREwvSTVvZUdrOXRtMUZ0SWRHRzkx?=
 =?utf-8?B?VVJLNkRDMk94L3oyaitFWHExcXlhQnZLb3hvbmhSSElKelNEMW5YaEZWOEhh?=
 =?utf-8?B?Q3BjQlN3ajFXOGw5clVOUVJ5MEIxM0xGdWpUMEFSRndyUC9GSXc0TVM3d3NX?=
 =?utf-8?B?dUd3VXE1U2p1eDNSblRkZnBDY0orQVhkQnhlaG1BMXJiYjdjZGNvOG5lVVl1?=
 =?utf-8?B?WXNiR0NDRTUrZkdLZFdRTFZweTdaSDdvUmxWc2NLL2dCVHUwcmtzREdWcnpa?=
 =?utf-8?B?MFgxWmljbU1YSmh4MFJOZGJ5bVVGRERvRjJwOHJYNnRjRkZWSG41SkdaV3Q1?=
 =?utf-8?B?VmY0Z215WXUvRmFvNHRaR2JvUEdncEJRZ2hLTHlLd3crbzFIRmYxb05LbU1U?=
 =?utf-8?B?eE04OHNTNm1NSk9aeEFDNjhEeHJDZWFSUHRZWjZraUtlSDJ6UWM1SitsL2lK?=
 =?utf-8?B?MCtxdGptckdZTytWT3RBaWpDREdqdGIyT2lHdVdHRFBpY21NTTZDbGE4UFdn?=
 =?utf-8?B?ODVyWXdDbmVIWVhQNkl3NEtWRXZEQzVSMWZCeVMwa2VuVGJDM1pPR2VHMHh6?=
 =?utf-8?B?WHYyT2pscldlYmJ1Umg5bkgvNFZ4cGY4UDMwUWh6L0RMem9BSXBlTnpodGpa?=
 =?utf-8?B?Wkk5dzdKZkhFZUVvWi9Xc1VQaUI3c3ZycG94NndYZ2Z4aUtCbWNMZmFMTlYw?=
 =?utf-8?B?cVpvdGdGZElqSklRb1h0YXFCZkFuZUJnNGZ4Z3Vua3ZvdTNTc3pLdGJXSmc5?=
 =?utf-8?B?VXY5SGhSWGtuZzA1RFlFMWNKZmkzYnJDVzFEMWRRRVR0SnVNNVBjNmc5VlFo?=
 =?utf-8?B?V2NGNTZzTGd6SXVPYWlQR3VCaW9OdlhTUjlnVG8vVDJXTFl1c2dWWlYyS0lL?=
 =?utf-8?B?NkR1dDlGV1B4YjNlVUhzQ2JkaXdHN1EwWG5BeVRIUHFkMXNBT01Bc2pTbEp0?=
 =?utf-8?B?NEFhY3pQa0tGT2lvdnQzOVplcXpOd2Y1WTczL3o0Sk5kdWlsMlVCZ2FlcFln?=
 =?utf-8?B?QWlXSzVoMWhES2pYYzJhTVJHdkxyb2syb0c3Tk10Y0FTNjlrUnZhMEE0cHpF?=
 =?utf-8?B?WWRYd0pDRGFyazNLeGZJQ29OR0FxUjZ3eDNQMXZmcTdLQnM4dTUwWENZcGNB?=
 =?utf-8?B?UWpkeDdJMzJXTDBPdGQwakpQYTVrTWNra1pWUDBxTGxYZHBTMlRvakJBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82df2c0-060e-40da-3a18-08db99a87ff3
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 13:48:38.9214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2769
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------i1aPyvpilZ2VvrxKFBv33dFW
Content-Type: multipart/mixed; boundary="------------ts5cQKEVOvN6W1Z7oA0pMri2";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Tony Lindgren <tony@atomide.com>
Cc: wiagn233@outlook.com, bcousson@baylibre.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>
Message-ID: <325e87ed-adc3-5646-6fb1-e3c25ad758a2@outlook.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x-bone-common: Add GPIO PHY reset
 on revision C3 board
References: <20230806085044.1917-1-wiagn233@outlook.com>
 <TY3P286MB26113797A3B2EC7E0348BBB2980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230809072846.GD11676@atomide.com>
 <TY3P286MB2611D8048AC78466459C47759812A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230810062717.GI11676@atomide.com>
In-Reply-To: <20230810062717.GI11676@atomide.com>

--------------ts5cQKEVOvN6W1Z7oA0pMri2
Content-Type: multipart/mixed; boundary="------------430JPFJ0kSBsqfwH0GFGDYCB"

--------------430JPFJ0kSBsqfwH0GFGDYCB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgVG9ueSwNCg0KTm8gY29tbWl0IGlzIGZpeGVkIGJ5IHRoaXMsIHNpbmNlIHRoaXMgaXMg
YSBoYXJkd2FyZSBkZXNpZ24gcHJvYmxlbSBvbg0KDQpvbGRlciByZXZpc2lvbiBib2FyZC7C
oCA6KA0KDQpCZXN0IHJlZ2FyZHMsDQoNClNoZW5neXUNCg0KPiAqIFNoZW5neXUgUXUgPHdp
YWduMjMzQG91dGxvb2suY29tPiBbMjMwODA5IDExOjMzXToNCj4+IEkgdGhpbmsgdGhhdCdz
IE9LLiBXaGF0IHNob3VsZCBJIGRvPw0KPiBDYW4geW91IGNoZWNrIGlmIHRoZXJlIGlzIG1h
eWJlIHNvbWUgZWFybGllciBMaW51eCBrZXJuZWwgY29tbWl0DQo+IHRoYXQgdGhpcyBmaXhl
cz8NCj4NCj4gSWYgc28gd2UgY2FuIGhhdmUgYSBGaXhlcyB0YWcgYW5kIGl0IHdpbGwgYmUg
YXBwbGllZCBhdXRvbWF0aWNhbGx5DQo+IHRvIHRoZSBzdGFibGUga2VybmVscy4NCj4NCj4g
SWYgaXQncyBhZGRpbmcgbmV3IGZlYXR1cmUgYW5kIG5vIEZpeGVzIHRhZyBjYW4gYmUgc2V0
LCBJIGNhbiBqdXN0DQo+IGFkZCBDYzogc3RhYmxlIGZvciBpdC4NCj4NCj4gUmVnYXJkcywN
Cj4NCj4gVG9ueQ0K
--------------430JPFJ0kSBsqfwH0GFGDYCB
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------430JPFJ0kSBsqfwH0GFGDYCB--

--------------ts5cQKEVOvN6W1Z7oA0pMri2--

--------------i1aPyvpilZ2VvrxKFBv33dFW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmTU6okACgkQX75KBAfJ
sRnPmA//Q1dCiCnc81JQ58b+XcW0px/IVCuEay8aLxDfTn5ToolkY69DzfmYIP0O
pELL0X10OWfY1UW+Er2C5+EDraXrByxhUNkQg0Nk2nUo628BnbTzC6XELMeRFFo5
6RFHSHRBxDhKLEY+V+1TXL0ri+KqPksjdFTWxLRJj7LdQwTaPq9S1vMUGfEuw52f
IeFzwkkXssZg6QffzSsBqKUcC4WjGueEv/cwXs5ltZizbgUVb8lRpwsXG/fpqFy7
bRmn166dv3ZXZcRyKEMl3Zzv8jAe4B3JGZlWzxzosqr3YVk2Fc4x59QShFL9aqvA
+A4i2TOkyT9ZmPSKTMs1Wx0H7emtgWY7PkqqDxoK2o9IKb5SHPlaoQf3v1+Pdem9
kq6zcxuQhml240lqnuKvOcEfYE2L3MP+mHomqvi9f7/plTD9AAmPZj6A0rKN+Kkq
LEbPnIKo87GdknEnQiDxWSAxwli1YQ/XoqIrfERTrTzjq5pcY2h7xz8xj7L2cq9/
kiW0JyM5uCqVKFUcu3KBfCARgtu2xJRZyT7P7d3zzqbcl7cTgPV5KI8+QxwAU/kb
GxtEl1ZY8Gsg9+4GqETGRcX4SBcIfu+eG5aAOK4M8n7BuxWrRmAjSYnsTdlgw+tG
jKdK1Uhn1618/JytlGMvEKtLF57iOxMaC7JwhOMvY8UD1i+M8aM=
=fHsN
-----END PGP SIGNATURE-----

--------------i1aPyvpilZ2VvrxKFBv33dFW--
