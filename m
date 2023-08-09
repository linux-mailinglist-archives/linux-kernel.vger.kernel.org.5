Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B2775D0E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjHILdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjHILdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:33:20 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2014.outbound.protection.outlook.com [40.92.99.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEECFE3;
        Wed,  9 Aug 2023 04:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knbgAILMm/xYb3G3rARYpkD3DoWC5C5NO2UPiTEUNKwXxgJsvWp429VUbtq3m+PEmfyeqr4vZokBIUwh+QaBOKt059ttjT1T9y1843DLosO2IB8bV+n6mUcKjIf15wm8eq5yuiy3zto8ODoteehxmHfpk5367fgZ5IF1EuKqYCigW0LIBT/+VjARWpuz7JgeY600jrXUZOH46BB0z+Pr1L37QevrdDkM3JPLn7XOCnCFPcdDri+0Am++16oj3oaNjPJqpxkviRfJ7cQOYFyWWT3hBDHqWUQrR0Ork9SuC1I94G9Gxgvs/bLO+yOwRscIiHmK+RTDkW1XwgTYMHqJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJXegx+cBzSueSqhXVwY1eQzbqxo1Zs4In57286zPGM=;
 b=Bf4lZozCwedwTLs3HBzMsD97ai5q+qmbioiYSKN93X9wsuMpe+3l5FwpRjuZ5m/gLJOsfEoFgPftj6LONaeWsIWUIe3V5BAiMvv8GQQZfvQ1U3Lvtm3COEU4CiOw38oC05E5gBZh1Vtd5Rgb4yIT97BNcTDK2hkp+QV7SA3CP3+kOY439SchVOuGyn7hud7Benr5QaZRjiIaTqNqg+HGqUWKATSkfbYNmtnNXjZVlFvD37DZJGaXzjEna1SI+ZckxC8Jj0uA+YghD8JU2kF1LKf1k8z0L4TBqzF0ygOqSSWi4DAiP2cuL8MgXO6BBfR07HRfh4dQjA5cL9NVkrsXew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJXegx+cBzSueSqhXVwY1eQzbqxo1Zs4In57286zPGM=;
 b=G9BbAsQ462W9ihHbyQZmksbufzJRhlBM4HZeKhHEnyopXVSU9+pXQ1Hdu86EMwClKP+8xJTzExcZy0UFIThXz86rICIn//XmYNG77ZSR9EFA+dI5G7zd3ue2yH2zgWOqPyfs7kaxXh3MPbzUSrGl87aKzFthIEuC13ffeA+DpyyM9gMnTQwOqPLF574q+S7rMK/vWYpf8UNs9L13mREQcrvUYh1HpHajgSFVh+FQpt1mELcH9zsqcorX0SYGD2YlZrHd+KC1f1f77L2i5Mqy3npkWYzwx2id5qcZnED54k8qlSTKzODUQaT89UD1NxtHwrHbb5RRoBysVaxODIt1Nw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB1562.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:180::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 11:33:16 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597%3]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 11:33:15 +0000
Message-ID: <TY3P286MB2611D8048AC78466459C47759812A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Wed, 9 Aug 2023 19:33:01 +0800
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
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <20230809072846.GD11676@atomide.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kFT7tmY2YbPv6PQxHK00mLO5"
X-TMN:  [xi1rXLukCAe7fsOKGwpCTy1UXpG/6XDn/ml6SAfRnTmNbTcRZ8t3pHqth5euyY6D]
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <1b7837cd-25cb-8d72-fa9f-03e18b68bc3e@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB1562:EE_
X-MS-Office365-Filtering-Correlation-Id: e453f7ce-23d1-421c-6937-08db98cc6bbb
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnoHN5tIFZy799IEdbaP3Y0NadQFOtllwkPA8QsCB0JQyHUaiTBZ5xm29I2sPsQ28zcdzXjcjuEhp2bbgX/xX+7OBtm2H+PoZ1uazlaHvlpIJNM1fMPVSqAYfw5m/nV/BjiSKowoBko6UsrWsCvPrwAURRoZiZg2FVa2HxxPn4/C7ArQqQXZ+nXXo7Py7pRUTlpuMux2Aw6Uen5K0Pf8IjOEff4+GGqlk1YDnFrHP4wz71NJXTXTlY7AcGj8QhYsbh9bo6QxVoxdxGyPpSWdiWUHBEJdUO6rB6cOzlhiw7A9GvHPUmm8ksm7NtmyDk4x5+cJbpA2s0MBsEDiBLzi/WdMZwAth5j7gsQ1+H+kM7SEA5J1y4X8sppqQoUXc18uAJ4icNALXfARJ9jUAuSvirzbwgeXOpnDn8DVh3vCnaJWRQmuq9rs+GYyadh5E8BlkLA2Xvl7ZrQUyVnJ5hw0sd9aHyxJoZry89Q2U3siWq1+QxCYk5/vC1qlq/585ONIkFiqnMJkXd1ELRMtETJsgJCDFirHvkfwwc/qBPPEcRH7QnzEbKrcRC8IEj29W4Cv2ioUA1NgVGz1g/hho552bayLo7Bc8+AG+3grRfI1Lua2o+eu1INDlmjEqX5Zs7xj1gWNAUGqjLP8sHf1BWufx6midyUUjKRIkMSc49UITc9eBnrhZD9vcqsn35T1mwSoyNySWdFjMSItBAqornUkNW+XCeQdQPPY9N80wGYFXwVdixekp9VF5NklhEKJY8U6lhY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nw9PqFGQfgX+fr0iQyP+hSGMfIYMONx+tUH0WAkPu5kzvnjs3qbQw4GisBotLhU8yraPHMejEauk/5hsWLJ4XBLNzz176ui0uoZxhOVao7yP0gg7iAPd7rus1Tq7+3oxJU/u9tURlyMUvmFD3keQCc3AjgVU2H+y4Teu+gsilPRa69scYwbyk7f2hf5C3dK7rw7GB+3Q3qSLb32Pru4vU4++GJp/JHgY+eqW1lHkCQW6pdyqxIycWV++2CBPhHTt5Lf0cihxjYT0n8KkfJq+qNrfXfYtOi/vSTxYRqxM6TCnw6mqBnKQsJDNW6KYYGIxYQ324ZmgrRD1HMhQxdXcR2JtePVdGX8pk+X+H71ZwpAgLksKQLbefEqkZDbolcEmgbX/KKjhYHu5WaStwaNk2tUy3oO5kyBMWvArUIk653TsWXRMpRA/iewPG76RVW/+vdFhv5qos99QC0WMt4kRLW7Gjvngow5QKHwGzu0p7UPth9unHpQQFWBcBZlvWrl+BN7KzrV3BroXZ8wSMIg3Pr4NcRqHmeYiez3WWqDFhK3LYgngaHeYB93UbMhrzu8/LEhKBUbIKnJhz4ATd5rvFSjcDc79JOvYrfc/XHm+g1T6AFV8Y8dzS2/ik+xQ7fqM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhLSUJhSDB4czA0Yk5LUFZwWndyVnVmTzYvdTE2eEFSa1FaQzF3eFd4WnBh?=
 =?utf-8?B?OHoxaWRzckJWR0RIVU8yT2N4Z3BYNjRGbDQvWlRJYVo5eEc3OGJPM2o4ZUQ2?=
 =?utf-8?B?WVd6Z3E4VW9RTlpsL1BwZWovVEVVMmo0a3htNTkyWnU5c1UwMVg1NkdXa1Nm?=
 =?utf-8?B?RGxhd1p0NmJZTWIyOWNuelVNcW1OdzNJZlJ2U2ZSWGRFSSt2SWF2eGVMRlA4?=
 =?utf-8?B?RWlHWGpvREhkeXUxcENWUVRpa3VoOXBiWFdWa2dPZiswNjllNmUrTGdjR1RM?=
 =?utf-8?B?aE5OOHZzbjNjTmJ0bmswUHl1Wk5EbktiQ0lvUm9oYjhZSFVmRFhtRGFrc1p3?=
 =?utf-8?B?NDdNQUZDMHB4YWxXTi9QbmU3VzRaMk1uRTlSakxJUGMzYUE2WWhJOTQwMzVS?=
 =?utf-8?B?b0tGbW90cWxhS1JNYmVIcktSZFdDSWZWWTBnWjRjS2kyZi9MZGVBSi9CU0Iy?=
 =?utf-8?B?NWlJT3VocDJaVUVna1lJdHhxWG51YnNyTFptSXlhNVFyc3U5ZUhiZG9PSE9Y?=
 =?utf-8?B?c3dFRHR1OTg2VXpaR2FMYU1uS1RhR1JXbHVDc2pJMUNCdU04dTUvN0NNREVY?=
 =?utf-8?B?c1RlVnJ0UWhKc0xIT1hCV2MrM0plUnRxYXZpSjdvVHlXUXdIOWZnVEdSU2NQ?=
 =?utf-8?B?ckF0eFBaNnhTVzdXOGhwcFN2ZEY5aUZPa1hnQ3U2amNpY2djZmZENTNkUVRY?=
 =?utf-8?B?Njc2bnVrekVoQlJTaW0wNkV2aERQY3pnTWF4bng4amdJU3M5QXMySGNHSkZu?=
 =?utf-8?B?TzgyOENjeUV3a1hsNVdlWlBkV1hWMEhDVGxaa0lNQWFjZ1NMOXVXTFVGOHJJ?=
 =?utf-8?B?QzlLUW5rZnZ4UGVocmFQZEoyWGZtZ2JRZGlwZFl5L01IQmVLT25GTkFrc2ZI?=
 =?utf-8?B?WjU3Z0h2OUVDZG4rVEI2SnZPQS8wNkNxc2I0aGVtVktvWGwyWWdtQlA5TE1W?=
 =?utf-8?B?aXN5WUdzL1NLMWpGRXZ3Z1BpeUJsVC84dEwwcjBXYlNpeExqMTVEN1hUbFVi?=
 =?utf-8?B?VHpqeFZsMW9KWk1QMnErWkNWUExPS21yMWd3UzA0azlyWjZONVE3VjFsWHV2?=
 =?utf-8?B?RC9hQUZDOGlJMEFhQnB2ZXFMeWQ1VWNibjNaSHFzNWpnQVh2c2tUUW9DcER2?=
 =?utf-8?B?aFZZc243Yy92dnhuSnFTV3ptbzA1OS9ld0NNTFVlV0E5Q2RQMytQaG13aElR?=
 =?utf-8?B?UXliOUwzelF0cjJQbXRQVTZ3NmRFQ1hTSVYrS3g4OFcrQmJjc0xPa1Radkx0?=
 =?utf-8?B?dE83MVFSL2IvOHZFTWk0Lzh4SzJ3K2lEZnZJRXNkOXczaEtSNjJuZVMrd2RY?=
 =?utf-8?B?TmxoeXhWNklXVmZ6dGphRkFPWmdWRE5xN3pmbDVEb1RJRGF2Q1RvN0VuODBL?=
 =?utf-8?B?RXFQdjgvSFlZbFgyQkp3VUg2SHBpTnc2amQ4bGQxU1d5WjNUTmh1YnRZQXZ4?=
 =?utf-8?B?TkhrUnh6RXZqVm5lNVhCcXFZNHZYYkltY1ppNmF2K3d3RHZqSXdFRkgwc2M1?=
 =?utf-8?B?WHlBMW5hRko0dy9abkgwMTQwN0l0dkRRUnNvaWpEWEdJTy9qOHZKV29lV0x1?=
 =?utf-8?B?QTROdUxpbG9taEpOdEFEK0ZhRDl3TXFSYWJBRDFkMG5ScGIxbGpuV0dPN2NG?=
 =?utf-8?B?czRoZ3ZsRk5zK3pVN0M4RFNLbS95Ny85MVdWU3BRbGJDOVZFcXBFSjEwaEw1?=
 =?utf-8?B?azJWUHZUYXRha1VEWmNiOEpVN1NUQytGQU13MWdmaWhTakNhN2l6SnRnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e453f7ce-23d1-421c-6937-08db98cc6bbb
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 11:33:15.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1562
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------kFT7tmY2YbPv6PQxHK00mLO5
Content-Type: multipart/mixed; boundary="------------VCASQZE35Bmbrw6gCGobGyvb";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Tony Lindgren <tony@atomide.com>
Cc: wiagn233@outlook.com, bcousson@baylibre.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>
Message-ID: <1b7837cd-25cb-8d72-fa9f-03e18b68bc3e@outlook.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x-bone-common: Add GPIO PHY reset
 on revision C3 board
References: <20230806085044.1917-1-wiagn233@outlook.com>
 <TY3P286MB26113797A3B2EC7E0348BBB2980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230809072846.GD11676@atomide.com>
In-Reply-To: <20230809072846.GD11676@atomide.com>

--------------VCASQZE35Bmbrw6gCGobGyvb
Content-Type: multipart/mixed; boundary="------------xGZe0h4UBjmvniCArho0ELn7"

--------------xGZe0h4UBjmvniCArho0ELn7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8gVG9ueSwNCg0KSSB0aGluayB0aGF0J3MgT0suIFdoYXQgc2hvdWxkIEkgZG8/DQoN
CkJlc3QgcmVnYXJkcywNCg0KU2hlbmd5dQ0KDQo+ICogU2hlbmd5dSBRdSA8d2lhZ24yMzNA
b3V0bG9vay5jb20+IFsyMzA4MDYgMTE6NTFdOg0KPj4gVGhpcyBwYXRjaCBhZGRzIGV0aGVy
bmV0IFBIWSByZXNldCBHUElPIGNvbmZpZyBmb3IgQmVhZ2xlYm9uZSBCbGFjaw0KPj4gc2Vy
aWVzIGJvYXJkcyB3aXRoIHJldmlzaW9uIEMzLiBUaGlzIGZpeGVzIGEgcmFuZG9tIHBoeSBz
dGFydHVwIGZhaWx1cmUNCj4+IGJ1ZyBkaXNjdXNzZWQgYXQgWzFdLiBUaGUgR1BJTyBwaW4g
dXNlZCBmb3IgcmVzZXQgaXMgbm90IHVzZWQgb24gb2xkZXINCj4+IHJldmlzaW9ucywgc28g
aXQgaXMgb2sgdG8gYXBwbHkgdG8gYWxsIGJvYXJkIHJldmlzaW9ucy4gVGhlIHJlc2V0IHRp
bWluZw0KPj4gd2FzIGRpc2N1c3NlZCBhbmQgdGVzdGVkIGF0IFsyXS4NCj4gTmljZSwgc2hv
dWxkIHdlIGFkZCBzb21lIEZpeGVzIHRhZyBmb3IgdGhpcyBzbyBpdCBnZXRzIGFwcGxpZWQg
dG8NCj4gdGhlIHN0YWJsZSBrZXJuZWxzIGF1dG9tYXRpY2FsbHk/DQo+DQo+IFJlZ2FyZHMs
DQo+DQo+IFRvbnkNCg==
--------------xGZe0h4UBjmvniCArho0ELn7
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFaz
LV3FGBjT+9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q
4Ww/W87mQ12nMCvYLKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx
0HJ92zTBMzMtYsL7k+8ENOF3Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/
SJv0w2YmqZDIAvDXxK2v22hzJqXaljmOBF5fz070O6eoTMhIAJy9ByBipiu3tWLX
Vtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1el5WW/qxqrKCSrFzVdtAc7y6Q
tykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdromSrsD0gEmGcUjV7
xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB+X85sxcr
4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0x
i/KZIRpSlIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQAB
zSFTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX
5PUVXUNSaGVT2H/jUgzJGSnI5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
AQIXgAAKCRDjUgzJGSnI57GwD/9O6kei9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ
8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSiOnyyHrg8StmGLksQE9awuTnl
nQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHaJwFi1KATSI1AhsF3
CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9voraKhx+0Ds
ZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISF
gvZoGYdB9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaa
LZH/jzQf7FpIGGhDYnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2
yVu3w4tIchRT3wekMh2c3A3ZDeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yA
j6Ey0YrIUbW9NOhIVCGkP4GyJg756SGzyPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AE
H2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4TrXUR0ScTy1wTKV1Hn+w3VAv
6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23Fj4LK2mKTBoEwtC2q
H3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8aiQQUKyZ
dG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM
/pM4L0tPVCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwh
agPSYDV3cVAa4Ltw1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVyk
k4q2DDi0dSC6luYDXD2+hIofYGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjn
zuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQ
zRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoDIbtRm3xt2tFrl1TxsqkDbACE
WeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3CizcOmgc61pDi/B6O2
IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DBbUslCmkA
EQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3P
Pt4wkQkdbF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZO
pxb1EwWwvnVUwrLxCuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsN
VeqrWU0mDAOgvqB86JFduq+GmvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEy
uRmtKtqxTP/u6BzowkV2A/GLxWf1inH5M81QgGRI2sao6To7sUt45FS+y2zhwh62
excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFOjeBOYr+ZCCeARh+z4ilo1C2w
upQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrrmnEaZMsoRdS22fne
CVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/1aPc2Iox
cQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/a
LzG+FguuGNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2zsFN
BGK0OekBEACw8Ug2Jo4DF9q3NFOZ7/Vwb6SlKpj3OdBjGTPwRZjV4A5CzbEqXrkl
TKFNE9CRbxyoNXN1UXXrBb7VHKgyu0rnGPqOb0rtUABz+wMvYuShKOPcWmg6n9Ex
9UGIsYBMJ01IQMU87qcZUmfxo5eYfniyBnOGB+pbVf1jhOhZWIXlVdmxYbMc+xeh
W+VHI98BiL14vXWFmpBWFc85BO4AbijDzPtkZhPvB9mj2he+z/XUND+nG3to7xAY
I0Kxacw55w8HL35Nuv+G7EtUWX5uhpO/dDB0BMcW05s6L6rebpEAAMFVBKIAJUKy
pvTYcAN+E7yfQAzvl8mNtcVMsFHTr54wTSHR0Xx32G72Ad7dkeqy8HhfkT1Q/5V/
xzUz1qgmtQtWgA6jnSCYISGOXMjnFhzMG3DVuE5cI/RaPlybHfBsqrtQoxeMMoX1
qD3Tt3TvwFojOEw4KE3qz1zTcozqLHScukEbNhlcLRUv7KoqSIcnN56YEnhjMu9/
ysIbFuDyQo9DaieBBWlwTiuvq5L+QKgHsGlVJoetoAcDojCkZxw6VT7S/2sGCETV
DMiWGTNzHDPGVvutNmx53FI9AtV09pEb2uTPdDDeZZhizbDt0lqGAianXP+/2p1N
Zh0fMpHJp+W4WXPQ+hRxW4bPo/AXMPEZXkaqqDrMcsTHrwrErCjJ5wARAQABwsOs
BBgBCgAgFiEEl+T1FV1DUmhlU9h/41IMyRkpyOcFAmK0OekCGwICQAkQ41IMyRkp
yOfBdCAEGQEKAB0WIQRP/KgY/enlmX5EpW5fvkoEB8mxGQUCYrQ56QAKCRBfvkoE
B8mxGVNQEACNCgyibR1+BY00hem9CCIZGHqyWfJn9AfiPYIY1OB80LUJXhJULtT8
DeUUOgMZtywhJvu4rIueOufVzeuC5P0lfO4htBmi2ATQu8bT2h0YxcNL3YKYFoqe
+FiVI7RxR1G2C+fDecyCXUrPtry++NiXdLVeFdDxumCuHZKffqiqFpL/8yDLnaoc
3aVHPT2Wv0iDU1JeSOC5LKPWFNznA5ZX6uxfiKzSc4E1qi/vr+1twXqwiwfIc9Ib
NniN59mzfXyKd64Geu1UT2wf1dZzVAcsXWDM4orCyx11eVh7ZKPmmVe9mpwcdh+s
4t76/WDFbbUe6ZSixOwINRUn16CvUNBxpCKI5RXmpCLj8Z+oUBpyR6c1sdw0uk7F
o4TcjBsvQXtpkewqyXXyy4NcCpveWPICbh8RmvZx4ScTufXH0FmLMkthuRgH+TqD
HHFvKNyhHoXWeIQT7oez28oY2a81CKQ+m/TkgNeA6vqmBZYJ1kKK6nc3vbFLc4Jk
2SRVCNpIvr+E38hxHz5e2n6dtgfgCCb2EEA83TjmX8/2dWZJA4ndML7AaCjw3Xqr
NbTrVgP99oH+D+7tFxJ+LlLAhIjKs1efKEFlOsXH7QqyO13BUYldhFL+2KjrNFoG
X9s7f57xIaqwdTd/okf4eBNYkg1+Pcj/AMgEAvRcagMATy2pAGmxMF2YD/9Z6y3I
oPB+lkSrP3AE1fhBRL/OH7UaLB4pyCpeGLhG5X8xdM9dwRPX+kadflKH2F0GPqUi
x5O1tJUMEdCb/WpQ9gUAb6Ct1Zntis8hd8pNQIGUT+kpwnpiLVEhbeg5DX459ho8
N+o6erYR34cUz4o0WFa1TVNFQGKRTWfzyUxxGUUcW2QC5mCwPCPZv69zvW5c0Ddi
RwUcYGGruslC7cHWXbO8zQ/R2zQcCjnyIniqoyQDTsQlK1oBM6iQMALhej6fsMe7
zWlA8/0FNj27Ub6biaWmK9aohWTkZtv7bD3IKaQRaq/lBg+2OmDGrSHNREt5T4EO
85QqMJLnjzQ2/FbA62E+piWzRaChJVUy0Ol6SVJHGascnqT4fWBX0lpZx9A7+XQh
CtCbX7ETzHPzugeXXyAhVuleaV+yzoSc9+aF2y38WrFczSzFX5APegWZ/8JxEbhJ
KqOwqSlC+IMwblPA3naZbCiKuTYxiU0Ys3CSdZeFFvSXuvhLJk185anQQjQS874J
8pkvTd2ueYxp46hde0rCZaAKlhNrp3G1NNUpt5QpjLan6NhmpQ42XfILC4v1Qg7A
T4vGG0QPhmMhbGgPn+44EYuh8/941mkyaYL0fXyu6l2HoKEZiLerr8vqgc08NvAl
QW/1QnKz4zA5XUvOrxQsLFF9ie2eG6DWJkdh1M7BTQRitDoIARAAtZRhbhuAfenu
NS2kPytShodMn4bfP1lSNi/P6vSWVym6s+bQPIbuRYfNvMZMKR1hPF93ERpSCAx9
bEsLtXJ3w9p2gFOUkn77sw/14v0jPJokQbTfg3dO0PKb+/89q1oVuOyGLhgXW1P/
ZGdIred56i2vsVfz7NmvPkSATr1bPTocYgpqdGf1+FQp8pDN60aXQ0RJ7rZpOTGx
/5BvgeraLXCbpy3ibaJF92HDU5QM1AeBs7LpXybFc+DZ+wktULeKemAF2EDnFauQ
CfGi66MHXGz2Dgy77ladSpz+OvpLTMpubzVeiGXwkNsa/Fs6lv1+arY2dUtHjvvU
0kLf/arNT+mOCMD8c2aOapgUQhOhM2U2OwRgbJ1y6OVKyN0UN76kDpKSpSsQelpV
/TfUk4LMTOB+rIfeAwG0NfKsYCzxV2dvX9E4wgAupsryeHYhidFuUwQncPqckOVg
xXCwOA6GGtMVEQFR0snuVn4ulLgAJy0rJXbYSj8vac4V67X6l2CK8xvgvZUgm2C/
MoV9XcjoxQzNIMySFDNBmM+rtTOW7Rxn1mlI7se5TOKAlnq+cTuLAu+L/LKNRSoe
dKYsUUTjHGmewyUNlcHHHQcjMS3jwzZ2a9+YP5KpKJCsT/eqBZoiPAL6V9iCBiM+
02BKe2R86wK8OqehvxvR2mpFwVPk/H8AEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1Jo
ZVPYf+NSDMkZKcjnBQJitDoIAhsgAAoJEONSDMkZKcjn/ecQAJ1Da87OZQnYugWr
vPQOfsdV9RfyyXONrssGXe8LD/Y6rmzZVu+Bm49F9TF0Qxc+VOrJpv9VVsfOqFJi
0wykOwyESdVngNrAW9ZWzfIvkEDSpTlaxvzbNEY7pBpvb1xFoSMrou1ro3299XKf
tlA29RYHiwH1HIC1JPJBWsS4tlahZ9AtGo5p5wVoEKxN6D/SrjLCcFiQJlH1yISc
sZVFm3qgTuo2g0uzJM0o1Y2B7T8mK/rsm3hUHJlbCrPl/rkYEAlhSUKpawKhldRh
OeqUUCcjnfdmFgTH/HtTMIlEQA+Ck/T8M5+Zp/nhCpPCx0pTuDdUTRo3tWHL+Nri
wK+AuZNR+0pevuTYOyD6CV0Hng/3lU86i3gN16GVxNWQjUdQ1ps9InaQhLxsgevQ
msgzOqo6GUiHQIdxvAtcG7pXv7HRhxsZA+68h8lixiMeE1W30PH1nxn5gN/Ekldj
c5F9xBu1/vTSX9dGzer1zZZFn4J8lbD6R+keOaroF8Q9S1cYnQbh3vASshmzNgi+
ISmLtR1a4zjxY2AlKNv+jkdpItjot5dewxVeU5x5i1sXWJ3Dt4xNyFSs2PZs1IuP
Solmy00hVZdFiGmr8QuMmOo6YagSdVvrryw812k5vAskD5AMC9EGru1Y8e9FddsL
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------xGZe0h4UBjmvniCArho0ELn7--

--------------VCASQZE35Bmbrw6gCGobGyvb--

--------------kFT7tmY2YbPv6PQxHK00mLO5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmTTeW4ACgkQX75KBAfJ
sRmGsQ//S1Y0oaYk72JXatltvjojHoJ5sz7yCuYJ/adaczLUy0xLWeUYEyaViS5K
7MYIdTq4NYMm+suJ7M2OLfApV0RXAGo5V+b6nQESXBxMpLs+QS1hdw7ho1xo/Ap+
xjKr6+tAK5Pz0hJrG0viYpu06oO5fdCIhuEP49SX/KLrvJBF3ytA7uGnohX3LSOq
0syc0nT/jMWpTlCmlH7eVHMW8cApyGFgmWjwcQ+CWmZuEP9skLWYMulcSuo4UNC3
T4AHRgUiLuomR1FaWUlKqDFnRuzVn8+ZR4BDlLWzrL6QiZ/NOgJ2pIsheviYOgHd
yf1/JGAMF/72cszHmbU1J3vqsj6kmx7iVR6F8vedqa5aRoXTVTtZAFj7sZVZGAdz
ojpoVBw0vP43itfWFSxR1j1LCkLKu6inyEYFVET7yC+/JpDyZywmRgbKVb3WP1Lz
VKrs0NvCSxsvfZoQbOAszGcnnq+aOSj/p5C1HzmdWg/DeXMsMWxOfrwF/0KJYYl/
O0gs3/sXZKiuj5MPub4mFBloJM30NrTm6zglHn7uag785KqxlLRSxiBVYRe5GHpG
ZKlfBIFm5C72KbXmiIjXI/+JU+UMX5eTY0CFeLERQO+3g+Sypt3gdfA3s7glrPzA
5ZZd/kDTfU9dAxL09GnBA2EnpU+FAWX0YWWUgIfKYf9OeVAtR1o=
=vKBO
-----END PGP SIGNATURE-----

--------------kFT7tmY2YbPv6PQxHK00mLO5--
