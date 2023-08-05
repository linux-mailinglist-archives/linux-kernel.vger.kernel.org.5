Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4EA771061
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjHEPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 11:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEPn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 11:43:57 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2098.outbound.protection.outlook.com [40.92.98.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB9E139;
        Sat,  5 Aug 2023 08:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjkCNnm78zw/OL7MoEe4atvxg8KArrAvR+QJbmvID7qag5x/gMhdyZdzRIqIbHm89R0Amu/+2KxZqd/KrtP2xZz8VkTaUUSU13dVvjYWptyItT9ZYKPwkaizQCng3MKugb91hVXjRbGaQHpHwUhmJOzs1VpAU9LEviwMw8So4mGR48a9xJfVXz31xXlU/wX1nGpRgOVqH3lmh77oWDLRyHD1u79P08owdkOrVw9/I9CDaELh8XyXnSBQXFzvWn+MueXpl5fIkNoR/E99kQqcamCuesJaafmV2i8J8reEPidWo1rFk8CHI6TsvXkTozVf8NIoB/u9+T2/62hup3FzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct2ETmCjVrrU+ba4B0NUe0icXCjwO4V8tVi+b+POh/8=;
 b=QntqHhns3iOWqOyTdy1VXgDocgzQuj7KHvpoUQRHDzL4O7I5lBd3gKaUme0V55AA7hH4e7LRbiWfyMqJ5WJYz3ZGnbEUNmqfPl09hLXI0nwWIHabZHMoghhZxP743ZfyG3DA5reCCeMJsZ7clMijxPWaHYXnpA4q0uaT5IE46BVLnaCmIe6Na1M+d3TeI/QilVQq4//cmN2uOAoNDb25THLReKNF23f46fseVcU0nSvaLVanWFSj8lE+R/ArI1L1yWu1XisgrMc3wUcRtxfNjPhk3DvtXLy2vTrX7GH5Ld8mu1XohedKiptp7tAB5BIjtZvVqcm7bje3/U1gBE20XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct2ETmCjVrrU+ba4B0NUe0icXCjwO4V8tVi+b+POh/8=;
 b=o1qqg4c3u11PLtFgpS7jo/Rw1lIDKY0plg5nmXJ8+PupIjlMVgIz8MqxyVmxx6Sz/ddgzdqZNAmHvtm6Ja2vJu/l8+K6JDhqAw88oCGCX7sDfhEoqr7IOZbJLQVHgtPLW8kbsAtMkw//yoxxh6RZH/JXnzD5gpgBnJonbkxzoXhiIE0KISo3izFgxtZcJWDVyHuEtLa2cBhnOFJqR0LZflBgCpLQOgm2/bQfwaOEHowabK4Fyg7E8zI9lvqyoXGyglNt+EA92XWyuBWZC/zxCkYyLpcQLglPaC61O+xK6rArvZgkUybkniTUSEknDhybSIF1yace1qnabZKSWV7FiQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB2768.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:226::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Sat, 5 Aug
 2023 15:43:50 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597%3]) with mapi id 15.20.6652.025; Sat, 5 Aug 2023
 15:43:50 +0000
Message-ID: <TY3P286MB26117478116BEF63AE1548FF980EA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Sat, 5 Aug 2023 23:43:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     wiagn233@outlook.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Martin Botka <martin.botka@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
References: <20230802141829.522595-1-andre.przywara@arm.com>
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: make interrupt
 optional for more chips
In-Reply-To: <20230802141829.522595-1-andre.przywara@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hS00p4FNuo1QvxrUjBCvWv50"
X-TMN:  [0jFsOWA3k94TQzmU0GsgACAUyPuFOnOnYFijXyuPEgkVN1f3M1Tu1GHu3JNf1yXD]
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <22d67b26-59b0-00fb-58ea-3c8647bafbb0@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2768:EE_
X-MS-Office365-Filtering-Correlation-Id: de1e0c57-9e9b-4ab6-fd8d-08db95cac31c
X-MS-Exchange-SLBlob-MailProps: 70qbaZjg4mublvEQo4zYxvyfh04qgqhZUMGZGhNubCWc5+h+sG/L+kXhmF+VY4lB1qHfWskeBxlRcAO9irdKYcmNGRLGvDDX8UDDgE38tZSeXJ7G9OmScq90GlKbn9y2+ydgMDjERDEN7+1gnra5H+MEuolmOuFbVMoBK+5yMvPWZlHp7JOScR42TBr5ZES4Li/zQJEj91POY3vbnuaIsU5D7DWZZeFlCYKN2AsObtMZFrh8pcG+Ms5aKtXjpKHo49m6gQsI8zcEN3K6pofAXxG1EYBFTQ27vpVjgjhZp35SmNtgat0OaaBSOu4Sk74xTZlqBBFHpnPsXvQ6bjFP3LcONXHBWlkoTfpx1pd6DPY1WwA3VWrZ74N5aawGdT6V5eYZFLgLobyh+M0ICHcgk1bV1xh6TnFfzWvQbmrEVQfhAweYCW81W2wwAB8yb2hSwLpOB3TdFPL3N+uQ+0O6wsr6LWvtukHC5JHAxt7PKjPT2PpY1U/L3IcX+enJMg4MtRRU5WXoGEbQlAey2st8JrSyNhklMCIDqGFg6LsSZYUShV0KSG6r76P6Y11Hd5MQOROtPAn1Krtq9umwB3ls8oU+xLSbiJJKw6S/Cn2ZN3HzIIKf9JQxPZrO8rW3rGbY1kwYi1eifoHkxIfK2dwE6hv7Ul51TPpdUcJgH5exuFBVo+Nr/nkfeEfLKlqWv2qGzVI57gJC1jVhBQAlmUUar9RM7/7cDNuEdmU2hr9wauyn15fR9wHGTA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r64fEoLjQ77Ar9QAnTyWOHAyPxynH8bKl1iJ/LC0AqpLuL1+p33l5qSB0aMaZ6iMrNDC4jEzTDlcnK3ee9ytD/nHdwQ/T62BxMrJ1qH/BGgebuQ/rySTlBFb523OT+hloOE/Xu0eDDSvxo+PlHCpSYWVJNVEffzTOF0WsdbxNHzbYMSGe6aTI6Itc5GXvWiZe8X5DWDley2jjA2iJpbqUL3xB8BRjQU8e0cxudA5QlYINY6hYE8pRLJOcxdhJl590+IdqCZHrSSkMRno2i+vvs0pLm+C36YuFS2eC7G1HUmnm1LyamxFUAgsEydlS33l6DyPhQbtBLy5HSDDspWyfvJlLr7N09It+9WWDAzeJUBLlwtW0JquUo7JySvWFb3XpyfOHdY8eH6fuAKg4Bfad8RpK7cJFU2dx9uyNmFyCcQH9EurHxZ/MtJUjtVTOqNQ0xxvEjv4YR9FkI9f2TNMhwP7/587HhKCU8JgAt1sJShBpm0znMnIjdDqMTGtKeUgLjTy+ihKg0EstVYyLXM1K86EjrHkZ0xW1HxbhH9oAXRj5HG3JdaGYRrFDQ2xlP/sbsp3HAwjPX9jyt0p/s1X8WJ2YkwwwV9BsMlVicsjkM/HakOPlnWdiMamYaLIEfaZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm42aHZ3LzhROTNrMHd2bXV3ZnNWWDV4VGNLSXgya2V0djY5eS9XUDBPd1VJ?=
 =?utf-8?B?RUdVdEh1TWU5T3prSExtWHFnZURrYXhJZ0FNTFNxdWZ3U2F2c0o2M0tkd0o2?=
 =?utf-8?B?VXlNVjdiZFNUM1ZtNXMwTlBpQTEyM2VBYjFobjV2YU1SQXVmaEtxTlhaVVlZ?=
 =?utf-8?B?U2JJOVRMVk05NmEvenhGZk5DT1MvR2NvUDZHeVJFN09ObWhwejRneFNZTXFH?=
 =?utf-8?B?aXNwcS9hR2FxRXp0QjVFQzRnTi81Nk8wYjk2RHVlQThrUDNaME4vbVBxTkZ3?=
 =?utf-8?B?ekNIMEpzV3RSSE5VWlF4d2YzQnhjUHoxSkxUbHBJd2lqMGo0R1RrTjBVQ1ZB?=
 =?utf-8?B?MEl4cERjSWsveVR4RXlzTjA5Smoyakpzc1BENnBSdVBnOWJZVmZpY1dNZTVy?=
 =?utf-8?B?Qld5UWtSRzQzMHA5RjM5NHFma0RkUDg5WGc1QWRSdmhtY0hEbk8vMitPZWlQ?=
 =?utf-8?B?MlZjeW4rcVZvM2JxM3pvWjRkTmFvYk5JeEJxSGJMR0pZeFFQWjJhYmtkN1ll?=
 =?utf-8?B?NXh2M1huWllUeG95a2d4aUhwemJwNjJIUytOTVRXY2FpR29WZisyK1pka2Q5?=
 =?utf-8?B?WDFxRktKY1ZlQ3pGVEJ5SmNLUm1FQUs1cDFCWldUSEhWc1l6UThGTXJ4VWFz?=
 =?utf-8?B?bTg3M05vZ1BUdlgzK3RMSktrWEIyMm1PMW9QUGpYaHVLZXQweDB6bzBqUVdO?=
 =?utf-8?B?WFg5ZG4zWmNMOVVyTTNTcUl1alNtQ1VWQXpyeHlPTDFWaFAyc1RGK0ZBakRC?=
 =?utf-8?B?YnFxSHpJZXZWaFVPK1FRSFJ4S0ZYcEFWWTB5YzhBMm0vY1ZML1RZUFNsemJs?=
 =?utf-8?B?eVR1K0NxMHlqYUNIUmI4bjk2MHgzUjBEQXlkMm9PM1ZvYWNPTnlXdnNPWDVi?=
 =?utf-8?B?a1FXSUQrMXEzVWE1Z25Pc05wUVhLN0I1NjJ5bDVjcmcxVzRGNjFoZWE1YURx?=
 =?utf-8?B?Q09FNHZZdlRLWFg5cDdLdTBMMFZSZm9NMEZBeUQ5SFhiQTZQbEUxazRVNFdp?=
 =?utf-8?B?aGF1UWozclVnWVJCTkthZnR2UkIyMWxnSTJuLzQ0UndpKzkwWWErc2tDbU5G?=
 =?utf-8?B?QWNWbEp3SlZwbXJSOHQ3ZVQ5RUFzZFdYZXhTQ3dXUnpwRnlJQ09OaUU3Q0Z1?=
 =?utf-8?B?WmplUEdoZzU5OUxsWm9MVU1RYk9leithUjEvRTE4QUYzQWtrZkQrQW5JYzJF?=
 =?utf-8?B?bXUwNmxOZkVyTXJZdVlmWXJZSnBKaXlEZGdxSmhKVGt3QTdoNTd0ZEM2TE8z?=
 =?utf-8?B?dGtWOEU3NEVBSUx0M2hpcDNTUDFQNHZvSjZRSlVEaFpXdVZDM0Q1NWE0NkR6?=
 =?utf-8?B?ZUNQRXJteE1GaHg1VkRsb1ZJUmVTRVlBQXBHZE45T0dBankyQlV5azZyMEE2?=
 =?utf-8?B?UlpQRzk3TUdLb1NOVXZIcFZkUWNNRThKWXd1Y2pqaFlld0J2ZTJzdHp1OCt3?=
 =?utf-8?B?OEovcGdwNTFyN0NjaEZsRVlSdmM2SktmMk9yaFhOeE1ZRHFCZ2ZoMzZ4djB5?=
 =?utf-8?B?aGNlb1Y4cmQ2a213NXJUcGF6WFBCcm1mNW1oUmxlR0hHR3pRT0FpMFQ2WGs4?=
 =?utf-8?B?WmZFQ2ZKYW5zSVRsOFpnSlBFbmRJUStLU3VVOUJjVmF0WldEdzhLVytnclQy?=
 =?utf-8?B?YzFJdVY0cVlRUkRiME5sUXBVcFJidDM0QWo4S1hTRGhJQUV1ZURYdGVhN0N0?=
 =?utf-8?B?RnZLdGQ4ZENhQndjZHZ1dml4YlQxd0d3MGJFRC8veVY1VnZuV21uNmdRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1e0c57-9e9b-4ab6-fd8d-08db95cac31c
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 15:43:50.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2768
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------hS00p4FNuo1QvxrUjBCvWv50
Content-Type: multipart/mixed; boundary="------------HWiMvnuNatEoCCjAYhP87pIv";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Andre Przywara <andre.przywara@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: wiagn233@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
 Martin Botka <martin.botka@somainline.org>, Martin Botka
 <martin@biqu3d.com>, Mark Brown <broonie@kernel.org>
Message-ID: <22d67b26-59b0-00fb-58ea-3c8647bafbb0@outlook.com>
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: make interrupt
 optional for more chips
References: <20230802141829.522595-1-andre.przywara@arm.com>
In-Reply-To: <20230802141829.522595-1-andre.przywara@arm.com>

--------------HWiMvnuNatEoCCjAYhP87pIv
Content-Type: multipart/mixed; boundary="------------gnUdLCO8uFzHn9z2UjNfppU8"

--------------gnUdLCO8uFzHn9z2UjNfppU8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQW5kcmUsDQoNCk5vLCB5b3UgY2FuJ3Qgb25seSBhZGQgdGhlIGJpbmRpbmcgc3R1ZmYu
IFRoZSBQRUsgZHJpdmVyIHdvdWxkIGNyYXNoIHdoZW4NCg0KdGhlcmUncyBubyBJUlEgY29u
ZmlnIGluIGR0cy4NCg0KQmVzdCByZWdhcmRzLA0KDQpTaGVuZ3l1DQoNCj4gQWxsIFgtUG93
ZXJzIFBNSUNzIGRlc2NyaWJlZCBieSB0aGlzIGJpbmRpbmcgaGF2ZSBhbiBJUlEgcGluLCBh
bmQgc28NCj4gZmFyIChhbG1vc3QpIGFsbCBib2FyZHMgY29ubmVjdGVkIHRoaXMgdG8gc29t
ZSBOTUkgcGluIG9yIEdQSU8gb24gdGhlIFNvQw0KPiB0aGV5IGFyZSBjb25uZWN0ZWQgdG8u
DQo+IEhvd2V2ZXIgd2Ugc3RhcnQgdG8gc2VlIGJvYXJkcyB0aGF0IG9taXQgdGhpcyBjb25u
ZWN0aW9uLCBhbmQgdGVjaG5pY2FsbHkNCj4gdGhlIElSUSBwaW4gaXMgbm90IGVzc2VudGlh
bCB0byB0aGUgYmFzaWMgUE1JQyBvcGVyYXRpb24uDQo+IFRoZSBleGlzdGluZyBMaW51eCBk
cml2ZXIgYWxsb3dzIHNraXBwaW5nIGFuIElSUSBwaW4gc2V0dXAgZm9yIHNvbWUNCj4gY2hp
cHMgYWxyZWFkeSwgc28gdXBkYXRlIHRoZSBiaW5kaW5nIHRvIGFsc28gbWFrZSB0aGUgRFQg
cHJvcGVydHkNCj4gb3B0aW9uYWwgZm9yIHRoZXNlIGNoaXBzLCBzbyB0aGF0IHdlIGNhbiBh
Y3R1YWxseSBoYXZlIERUcyBkZXNjcmliaW5nDQo+IGJvYXJkcyB3aXRoIHRoZSBQTUlDIGlu
dGVycnVwdCBub3Qgd2lyZWQgdXAuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlIFByenl3
YXJhIDxhbmRyZS5wcnp5d2FyYUBhcm0uY29tPg0KPiAtLS0NCj4gSGksDQo+DQo+IGFyZ3Vh
Ymx5IHRoZSBJUlEgZnVuY3Rpb25hbGl0eSBpcyBvcHRpb25hbCBmb3IgbWFueSBtb3JlIFBN
SUNzLA0KPiBlc3BlY2lhbGx5IGlmIGEgYm9hcmQgZG9lc24ndCB1c2UgR1BJT3Mgb3IgYSBw
b3dlciBrZXkuDQo+IFNvIEkgd29uZGVyIGlmIHRoZSBpbnRlcnJ1cHRzIHByb3BlcnR5IHNo
b3VsZCBiZWNvbWUgb3B0aW9uYWwgZm9yIGFsbD8NCj4gQWZ0ZXIgYWxsIGl0J3MgbW9yZSBh
IGJvYXJkIGRlc2lnbmVyJ3MgZGVjaXNpb24gdG8gd2lyZSB1cCB0aGUgSVJRIHBpbg0KPiBv
ciBub3QsIGFuZCBub3RoaW5nIHRoYXQncyByZWFsbHkgcmVsYXRlZCB0byBhIHBhcnRpY3Vs
YXIgUE1JQy4NCj4NCj4gQ2hlZXJzLA0KPiBBbmRyZQ0KPg0KPiAgIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQveC1wb3dlcnMsYXhwMTUyLnlhbWwgfCA1ICsrKyst
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21m
ZC94LXBvd2VycyxheHAxNTIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZmQveC1wb3dlcnMsYXhwMTUyLnlhbWwNCj4gaW5kZXggOWFkNTU3NDYxMzNiNS4u
MDZmMTc3OTgzNWExZSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC94LXBvd2VycyxheHAxNTIueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3gtcG93ZXJzLGF4cDE1Mi55YW1sDQo+IEBA
IC02Nyw3ICs2NywxMCBAQCBhbGxPZjoNCj4gICAgICAgICAgIHByb3BlcnRpZXM6DQo+ICAg
ICAgICAgICAgIGNvbXBhdGlibGU6DQo+ICAgICAgICAgICAgICAgY29udGFpbnM6DQo+IC0g
ICAgICAgICAgICAgIGNvbnN0OiB4LXBvd2VycyxheHAzMDUNCj4gKyAgICAgICAgICAgICAg
ZW51bToNCj4gKyAgICAgICAgICAgICAgICAtIHgtcG93ZXJzLGF4cDE1MDYwDQo+ICsgICAg
ICAgICAgICAgICAgLSB4LXBvd2VycyxheHAzMDUNCj4gKyAgICAgICAgICAgICAgICAtIHgt
cG93ZXJzLGF4cDMxM2ENCj4gICANCj4gICAgICAgdGhlbjoNCj4gICAgICAgICByZXF1aXJl
ZDoNCg==
--------------gnUdLCO8uFzHn9z2UjNfppU8
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------gnUdLCO8uFzHn9z2UjNfppU8--

--------------HWiMvnuNatEoCCjAYhP87pIv--

--------------hS00p4FNuo1QvxrUjBCvWv50
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmTObicACgkQX75KBAfJ
sRkyZQ//bx4KeehrPbumhC+1xf0ZVutGkXGxHF/OuWbY0bEIIGHF2rnPSZT3QY25
hyNFTgQsdc75ZQwBZwwUT/C8cYVzKL3L20cFcNhefnUdfH/xAolAMIF7bLd2dF+L
2kAg8A/458k7Pjr0Zxr83IZ4QXtWL1Qj5iHqEMXy0McFUTWRlMNnpbHPzNKfEGIr
IU7TNBQbRaNq5rqerDKAUGDGZZj0n1hWqQMtHD5a1msVd3kRFBURh3a0+2wmE8ZS
JPbLN8MHbwNps0FA5BHnqTI0ZOXRVhnf6qUM9zmRNETC/JcCTBV4BVYGTAR2ifp3
i3LG3J8vmFZbZtGg62PGC4Pjm5qAsbozhHahUwmBsjUzGnEHq7GwB6VptfXlrIjB
LITZFPxtUlgxQHzcgYxF/ZLcaUb6o1dWgG5GYt71lV7p8i7qnoHctfb2RanrSdi4
mNu2O2yHTNtdVmHc/t1R9+qVo/97WFRj+2pXYgde3o8pME6ObYeXY3ypIJ98iILS
8H7uKUepm4vRrYwTD5KkAJ9ZQzQJxf5eo7gHsk3NQptPV1lUw6r3ebIax/Z5FmU0
bl+rCZngH/TEc/QYwyLK0WV5F6GNpRoVM9QHVSyzPXUo+yCh/sqfZWDGLnuNM3qj
1xW3fN+ab9cIoxUkWmr1fuFvgsmRWYZUFiQk3DQ0MRRTta/jW9A=
=Pn0p
-----END PGP SIGNATURE-----

--------------hS00p4FNuo1QvxrUjBCvWv50--
