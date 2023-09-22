Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69657AAE2F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjIVJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjIVJdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:33:14 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2096.outbound.protection.outlook.com [40.107.117.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EF5199;
        Fri, 22 Sep 2023 02:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6yAMM8W92ITcW4nzgnUXQB2MGZmAfPh+3//NCMHvhGxQ/7N3+IKakI8/WXZggZfmxEjnVFkXR//WcC5gtn6MS1dGizvfRd97L1KVy7BNT9EkBOrmiJ1I4UxXMw5C+U/jpmr5egkTjWGOAMRhAWaZg7i9wsssS4AMqIwl7qATeNl1DqY/FNMFItZqzDhzsIosSVo8pIZEIH/lCabKPec0uhZXOBaNEr3dAaEE6m0nh0qKGr2WuRza9DwRJIzWC0eoxxjm2FhJeuVBLyUSJqu44tNw2YXRWdOWY5YDNEXpTMQad4mYnCaCf5yaixU1G6ImE1TObnTYK7SkIGLJq6+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUQrvVyL6ulD5qL3dEEVEBPP0X3LG4J/xBS8FGJ1EPA=;
 b=dStKlxbmX0qW6jt989rTMqecd2bs3fuprEA+Hsf8Ay9gRIxHFFWQcCA3Miff+rTVYK/kBVSD4sJol2fdG/lbaGVyURgAaCdAQHtNY9BSiNKcwyk/K4XTvsJ0l3uobFiFo6s4LJBeh8JroJz7Wuatle9D8X487LFPrPDSmRhZX3N7KgyHVyN7cW0IArnc9qG9CDrJ1+gRZ1vfSq3iDcLn621l6oliJsTCTxw56sIWkkKAJVe3q9Q2OpFnCPQ6Ot0YE3KqcU3fzqfR/a8Z6T2gLr0KrVT2oUz2/LbQkA2cCNj64zXkJI5Ol2gFEnkP0nNw/YftZ/vtdyuHAQwI5yzy3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUQrvVyL6ulD5qL3dEEVEBPP0X3LG4J/xBS8FGJ1EPA=;
 b=X00qI2oWVBQR9J2dWFwilwy2z5Y/ozRLiAMIRmhJAuQzGjSaEtDzIwlNbx9+9LCeF7e1zH7HphFwQA3MYJ5wXuKf9JA9Ns95bBbo++enoz4T0u6nKdyLKuuPTdhUen7dnmv5mJ7bWuuNqn1FgTNJXDspjdeHhQt2qGxxoT7FcbXeIYE1Q/qxpmO74dP6t5fGjh2c7DUO46v+11JY6Eqgl0QN8MX+GjjVJyL1SqXbEhWi6HgJfDlUa7QP9aWKM7KbtR4ajCXNBiic4SiqUvlnOxI9q8fLwYlkeblXVb7iBKzcFVTklF4fPp/JPpBefmsHBHJmeJiBnLW6ipQHOCEP1g==
Received: from SEYPR03MB7046.apcprd03.prod.outlook.com (2603:1096:101:d0::15)
 by SEYPR03MB7681.apcprd03.prod.outlook.com (2603:1096:101:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 09:31:43 +0000
Received: from SEYPR03MB7046.apcprd03.prod.outlook.com
 ([fe80::59de:bf6b:c22:4f8d]) by SEYPR03MB7046.apcprd03.prod.outlook.com
 ([fe80::59de:bf6b:c22:4f8d%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 09:31:42 +0000
From:   Cancan Chang <Cancan.Chang@amlogic.com>
To:     linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel.org 6.5.4 , NPU driver, --not support (RFC)
Thread-Topic: kernel.org 6.5.4 , NPU driver, --not support (RFC)
Thread-Index: AQHZ7TUhgs72H8AZFkqdmOUY4AB+vQ==
Date:   Fri, 22 Sep 2023 09:31:42 +0000
Message-ID: <SEYPR03MB704641091854162959578D7E9AFFA@SEYPR03MB7046.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7046:EE_|SEYPR03MB7681:EE_
x-ms-office365-filtering-correlation-id: 87e7626f-e578-42cf-7ee2-08dbbb4ebb6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBDZ4fSzNDW6fjnpE4WnNCFgwvQjTggCTbM3TDlolNEqlfmq0riM9be19ebXMrkVxRlsBTdre0CyzgkT6GqRCx5eDvWasJaoihuNsgXjg85jVY+RUNPfmz9qFllje+jm/750c6+Tu2IX9akUp/ctL+IH0W/dAgi2r8cqkurulHEhFGmg9kjXAYNF9+tPyJUJe+zG0vJaV+zy5+qPbRw/qBvsysu7TMmQw7hzauCJ60++YfDuPAOpSaIQo7LIs0BWJdjiOJql/18hbM3awD3en/yxY27Xty1qc7uVwZ7nCLfBUIfSL2qXAkSGPgR47aZEuK+w1HNFzJz2waEr4CNYu6x3JrMGIG6Q6vYjqK3C0slkddFFUGnM4tlop2Q0af7lEa8m0/rn9g+4xbuSdKX7JlSZ8TXxUxMbu0xx5nL4EhK0+G+whWd9aYME2UzDDLbZZRODlPaeH+UUr0mEinQsGVll+qjgNR1582lFHAODYCIzivztBoucO04wP5sescGmMk8BhBb/WRuwCWSLK95MMEg1qbsrRhxYD8QkTAxfcWWreLgadExqwQBXwiIdCwlQNkJtOzLhle/FYWKpHfc/+Hn0VPydPIh63GmMkhUuDT1wsXSQb+TShfmfn+MAywQhtmo5F1hMFjsn9uGPfJWWFYiZO9xfwfbqmOpMj6ZSUGc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7046.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39850400004)(136003)(366004)(186009)(451199024)(1800799009)(55016003)(450100002)(5660300002)(26005)(41300700001)(4744005)(2906002)(122000001)(38070700005)(86362001)(38100700002)(33656002)(52536014)(8676002)(83380400001)(478600001)(9686003)(6506007)(8936002)(7696005)(316002)(64756008)(71200400001)(91956017)(66476007)(66946007)(76116006)(66556008)(110136005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnQzMWVkTHE0V1hSZUdqYXY1akVoSkNPL2s2T0o4cHNYUkw4NWs5Qm93K1RF?=
 =?utf-8?B?b1JZZzFnRGFFbzcwK1JubTVWNDNUQ2tPeDRzRXNFWm1CSG9qMXo1T0Z6QVhC?=
 =?utf-8?B?S2dETGlqcVhybDlXRnBJTDFhVXZQZTQzeUh2Q3JYbWRvdklDaXlsOG11bHlK?=
 =?utf-8?B?NjJQbzlKdk1EQWZXRkZobXRXZ01ZNytobENMa2FJaUlVRWpmQnUvWFlXZHpv?=
 =?utf-8?B?T0s0eDc3a25nUVdmY0dxekRSMkk0TG9CbW9SL1ZYRm5lVUZ5VnpvMkZkb0lK?=
 =?utf-8?B?RVJxVGhPVzZYZkp3ODdrRXJFQlprZmNjcHhvYS9ob2xuSHZqWEtZbDdneE83?=
 =?utf-8?B?NE1uMkRaa1dTei85dGtGTXArV282YTQ2TndCcDV5cHBGN1JiV2J1TWlIb0Fo?=
 =?utf-8?B?VkNXODBNN2dCMmZkQ0RZZWwwRnpTRU5XcHRkNWR6ZVFTOGVPVEVWYXIrT3Zl?=
 =?utf-8?B?dTM0Y2M3Q3hVSk92bHBDUlpDRjJWd1JuaTRhdHh4OFVadTE4YmJIWnNwRFF5?=
 =?utf-8?B?d3Y2K1hTUVNVQUY4V2MvL2l6VzBGN2pGdGw4MUdGMlUxS3F3RVUwS3pDdjZu?=
 =?utf-8?B?b3draHpjL2U5dlordVl2NEFmTldjTG4zdWtJQ0QwVGhjRU1DWFY2THpwMVlV?=
 =?utf-8?B?K1FrUWlZZGdhNk84L2FRU2VHSzRFazJNaWYyT25id253ejZkd3RUSndPRWxx?=
 =?utf-8?B?L2NCTGhZTkJKZllzcURZQlBPZWRMWERCNWtLMmtoaUU2SmsxYU5CWUVmVW1r?=
 =?utf-8?B?eUtkYk9KVTRnMFUyZ2NieUpWdjNGdmw4dkF5RWVjRHJxemNOYkhPcW0zb09F?=
 =?utf-8?B?QkpzMmxKR0VWTko0YlN3SWxlV3hESDh0ZlplVlhEY2FxQ3ZJQml4VXhrRTRY?=
 =?utf-8?B?RUkvd0xrQnp5K1ZPTGJsUzFzb1RyNnoxRHYwMjZTbHJScEM2MnJ0T2ozNG1S?=
 =?utf-8?B?TC9yUmVQQkxFd0JrODNnL25RN0pMNlNaWEk2dnBlaGRXVURsT3FIeS9BdGFp?=
 =?utf-8?B?ZGRHa0dUaGM5MmhEOWlnZEpxK3pESUR3VlYyWnB6cUU0MEwvUkprd2ZyUTFm?=
 =?utf-8?B?V1J2UlNXOThxekVtYjVVVC9UT1B5bDhDTittaW0rQ3pkZndJVWF4NDFJT0s1?=
 =?utf-8?B?N0plU1ppWlZmeXYzSEFaNFJSTHppUmVlcVlxdVNCam12ZngvQzRVQjZ2bWJ5?=
 =?utf-8?B?S05QNjU5OFozS0FyNDRwVjhFb2M1YU00YmhKRHB1NURTcG5ZZ01RamNlVG55?=
 =?utf-8?B?dGVFZ0RhaXZlaEMrQWdML1N4WnRoYllFWE14TnpBdnpvY1JMdXJveUErZXU5?=
 =?utf-8?B?S1VLQnBZZ3lLenpaem91THd4ek1Zc1VuRDJkZlBsaEw4YXlQZm1FOEI3N21M?=
 =?utf-8?B?aWV3ekxzRC9LYlZMWFNrSmpHdHdzTElxeGRRTnpqTGdNeCtkYzFCTFRYbGxk?=
 =?utf-8?B?Uy9YWDllU1AvcERDV1lLeGFOOG1pc0pWWVRSSXZjV3ZXRDk0ZEQ4Zk5yam1R?=
 =?utf-8?B?TzhucDZORVBQaFVJNjkwZ244czdKNVFzdWptZ1U2cWovWDBjVUVBUjhiSTAy?=
 =?utf-8?B?M0Q2VnZzZ1RHWHZlaG51N3BpNDdFbWc0K0h3SC9WOW40SjVHM0hGSk9UK0kz?=
 =?utf-8?B?MVhDaEFRWTZHVXV4aG9BbENDYmhZQ3BoTUR6SURKN0RCOHNSWU9FRnhKWVJ5?=
 =?utf-8?B?SDI3bTlSMHlEUkFRY25WRmhxRHdjNjh0UnhSa1VGS2xIc2IwWExiSUtBQndJ?=
 =?utf-8?B?bC9xeWNUYjhkQm5OTk93WW12YkQvVDFDcGtBSXBORlZoVTVtcVRySXgyNm5F?=
 =?utf-8?B?cHY2N2RtOVBYV3pQZ3pjYy9QQkdSUEpGc0lNTklRMkJhKzF0dU1ZZXQ0WlV1?=
 =?utf-8?B?anYzWWdDMTUvaEkyV2FyOEdHczNBYm5JYXBYcHMxcFV3bjQ2N2NYQkpTRHNM?=
 =?utf-8?B?WXRXZkE4emM1WkJieG0yc3dzVXB0VHgra3FjMUJ3aXpaenpESFBxa3RrbXRl?=
 =?utf-8?B?V2IrcDBBRGNmY055b1htRElnZXNjekJmZktrbnJiQnhBTFVhSitPZThtSVF0?=
 =?utf-8?B?UHNTY1JGVHYzTFpLNzRRR0dFMWx5NWIyc3BsTkprSkVvRmxKNVZNTk8xTEFt?=
 =?utf-8?Q?jYhRMDTJy21YNDhijJLaYEF2W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7046.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e7626f-e578-42cf-7ee2-08dbbb4ebb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 09:31:42.9088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMb79qkA9OHDtWoyuUcblXPK4cB52qX+vXaT3NKYtb40LKz5oVeVfAbpLgY7D5YArgKzD6mOXrtaHYJJU+9GVl9Os1vq3u5wd1UULLDgA7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBNZWRpYSBNYWludGFpbmVyczoKICAgICBUaGFua3MgZm9yIHlvdXIgYXR0ZW50aW9uLiBC
ZWZvcmUgZGVzY3JpYmluZyBteSBwcm9ibGVt77yMbGV0IG1lIGludHJvZHVjZSB0byB5b3Ugd2hh
dCBJICBtZWFuIGJ5IE5QVS4KICAgICBOUFUgaXMgTmV1cmFsIFByb2Nlc3NpbmcgVW5pdCwgSXQg
aXMgZGVzaWduZWQgZm9yIGRlZXAgbGVhcm5pbmcgYWNjZWxlcmF0aW9uLCBJdCBpcyBhbHNvIGNh
bGxlZCBUUFUsIEFQVSAuLgoKICAgICBUaGUgcmVhbCBwcm9ibGVtczoKICAgICAgV2hlbiBJIHdh
cyBhYm91dCB0byB1cHN0cmVhbSBteSBOUFUgZHJpdmVyIGNvZGVzIHRvIGxpbnV4IG1haW5saW5l
LCBpIG1lZXQgdHdvIHByb2JsZW1zOgogICAgICAgIDEuICBBY2NvcmRpbmcgdG8gbXkgcmVzZWFy
Y2gsIFRoZXJlIGlzIG5vIE5QVSBtb2R1bGUgcGF0aCBpbiB0aGUgbGludXggKGJhc2Ugb24gbGlu
dXggNi41LjQpICwgSSBoYXZlIHNlYXJjaGVkIGFsbCBsaW51eCBwcm9qZWN0cyBhbmQgZm91bmQg
bm8gb3JnYW5pemF0aW9uIG9yIGNvbWFueSB0aGF0IGhhcyBzdWJtaXR0ZWQgTlBVIGNvZGUuIElz
IHRoZXJlIGEgcGF0aCBwcmVwYXJlZCBmb3IgTlBVIGRyaXZlciBjdXJyZW50bHk/CiAgICAgICAg
Mi4gICBJZiB0aGVyZSBpcyBubyBOUFUgZHJpdmVyIHBhdGggY3VycmVudGx5LCBJIGFtIGdvaW5n
IHRvIHB1dCBteSBOUFUgZHJpdmVyIGNvZGUgaW4gdGhlIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
YW1sb2dpYy8g77u/LCBiZWNhdXNlIG15IE5QVSBkcml2ZXIgYmVsb25ncyB0byBhbWxvZ2ljLiBh
bmQgYW1sb2dpYyBOUFUgaXMgbWFpbmx5IHVzZWQgZm9yIEFJIHZpc2lvbiBhcHBsaWNhdGlvbnMu
IElzIHRoaXMgcGxhbiBzdWl0YWJlIGZvciB5b3U/CgoKICAgIAogICAgTG9va2luZyBmb3J3YXJk
IHRvIHlvdXIgcmVwbHkuCgogICAgRW5nbGlzaCBpcyBub3QgbXkgbmF0aXZlIGxhbmd1YWdlOyBw
bGVhc2UgZXhjdXNlIHR5cGluZyBlcnJvcnMuCiAgICB0aGFua3M=
