Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9642F7E5D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjKHSb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKHSbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:31:23 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2041.outbound.protection.outlook.com [40.107.9.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13632102;
        Wed,  8 Nov 2023 10:31:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcHyTGDMo0wE8d44Clkr14OjZQMTHG1A9+8WqarCR6kXtJ8CnVgnRg4m2Kd1X2IFR8DsXHXPGtaEulu44hqkHkbmYYmBSXw5bzHg/7DA3Jgc3e9CodFo/idh6ws3Eym+AGb0osj408S6gRrrqUeHHML1TNvInXCX+MOd0b7YohmZN4Zl3xxpL2RpJWOdwXfE9lCaFOyFVmnpara1JFzyiNuZ0OGSOb17sxcenEIHYvWX9g9N/7084iSmXNWEUBBKwOiM/Hk+31xEUGBBuMjCmoJxhfVfs95q/E9F8UK0NuvjauzAu23t22FPnDivKOlplUlJ9koB3d+E5raJyLtyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEFd6rZP1yOqyMBQ2nhaCEUwOF4TlNx+anXdfKUppz0=;
 b=oJapebSQk52eyFXh0NuvvE5H+cMkXRRUdF96XqygtiD0P3z4viQWzBiTkmCv7bbKM1ZGJvdANV5Q7d1CULuipmrQ/pRlshWBKLkRr+kOXtiZ0DkSlGQfRqsXQtDfAsq5bvBAygHXQYVCtC4h3tIXPyx55P+9unwavUiGE6Hxc2onCdb8Y4OTVrD72S/aIx+IsVJ1REifA4CFQCR0ljlWwvhgKk2cPy/h4AjaIyjZ2F3Ry2u4ntkCUjPFdeHc85tN/ATG+NiNFSPtS6/f0ahBJKScrpsEeOE6yScSfniiVrW7XdVoLrUW4FgVs6S3r/hXYdO3tawo1SQgTO3ASFRtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEFd6rZP1yOqyMBQ2nhaCEUwOF4TlNx+anXdfKUppz0=;
 b=OoTaKz6SPvutw7/Wd1pDpyyunpFZAAwBZ+76Q9dEJE/V4yfXdd2YqneHgOHwPhNnTeXQX7+oLHc6ZFf+pZUt3wceTlQ1r2ir6S6zV9CqWgWTlhLPhJQqJfl/Mars4RaSoVU7+e2p2+69vOmwS0Zn5pAFbQGrDyBrgyPzTiMV6kMf7ANPGfrrV9blUu+I9X2JjtL4ugDmF/AoK7X3hnZ7fVzMXz7xax1ZkV17OOQxzQrj/xTNgTBrvFKpAJ97uNZIImVMu4td+3O6SnoJHHxJZhAV/cSnxWjvFVG8912jCfag37lCoV45h9WDt70d2qQ4jwQSVkSebuWoMtS1LA/Wmw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2388.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.6; Wed, 8 Nov
 2023 18:31:17 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5bfe:e2f2:6d89:8d97]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5bfe:e2f2:6d89:8d97%3]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 18:31:17 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Geoff Levand <geoff@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Woodhouse <dwmw2@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 15/22] arch: vdso: consolidate gettime prototypes
Thread-Topic: [PATCH 15/22] arch: vdso: consolidate gettime prototypes
Thread-Index: AQHaEkPkiwEWo83izEmVhjzNZW4UOLBwvvwA
Date:   Wed, 8 Nov 2023 18:31:17 +0000
Message-ID: <ecedb0f1-9543-35c6-18bd-723e6bf21173@csgroup.eu>
References: <20231108125843.3806765-1-arnd@kernel.org>
 <20231108125843.3806765-16-arnd@kernel.org>
In-Reply-To: <20231108125843.3806765-16-arnd@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2388:EE_
x-ms-office365-filtering-correlation-id: 5d1f5e49-f364-404e-467e-08dbe088e583
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fp1JRTmkWLncYFH910KAH3NWhUE3YgpRFeNA1BtkV6xRFNfgS3yir0I80UfoE+W7H2/wmeTqYR/zwgIh2VFOzp8cArrDMHEA129Ni8cLIbK0aHMD3hi0x3ieW1aTDzzS14/jPaobhRGgeMRAu/bD0M96+5i1GOBJL5Zvf1cRMfmAuZ2H/kOq8JMqHXR4LmZFELc7gjRL8u0jKNZxlHhVUpesX5UYL0LHVxTDonQJhAImDPFR/2qMQ4iEQbNsYSkC3BmQIkGw2c38g4VJk+00FLI9jtUZbVsAkhqEPU7VwelGibW6+LxZSH4pmOs6LTI7ASFh7dakyCSJBbDTxwvuW+jRXTFuVypxeeuYHkzT9qo4qI+RqIfHXWlYldPsU2uX8d4GltxLhYZdBSlOpO5/9Grm2A/k289CyFOk+4+C5mC8zpcOBTrCTw0a0GixSZX3BtbhQQD788u7pvj+1YxQul5EGuSa4T/Tdf2HbFJhSMJ8li8fP/GFIesVfIiqxEYOdUupSQdarucpnKcFU4TqcxkgqiTgNdOwumS8AYlDwlNcdD3rElUYgEpPwpnNBK1qi+0WUMsNElZucOJ8c7rbeG8nXQ2FV1/4pihNwcYu4jq5Ku29vfH5tiCeTRU2wWnKDBamSbNQ2NFy3Azj11UoWvO0GPR/sCcxwcS9XxFnkl21NSvcAT/ipXlUg6pjUP+JcO+2BAT39CGE9bZSBD0T/KyGkS7QBwENFC+sapP2Ljo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799009)(64100799003)(186009)(36756003)(38070700009)(4326008)(478600001)(44832011)(5660300002)(8936002)(8676002)(83380400001)(7366002)(6506007)(7406005)(7416002)(6512007)(2906002)(31686004)(2616005)(6486002)(66476007)(66556008)(66946007)(76116006)(54906003)(64756008)(26005)(91956017)(110136005)(316002)(66446008)(71200400001)(86362001)(31696002)(122000001)(41300700001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDAzNlo0eFdWdW1wbVIwYnh4a2ZzMWhQTlRKRE8zQzZ4cHo2a2xiVlVCblZl?=
 =?utf-8?B?d3VoVFpaN2hoNWJVT1luVlNjcGwyWjE5L3krRE02bENHdk9wVENLNW9nSzhq?=
 =?utf-8?B?SHlaZGNscXVuL1o2UzlYV3hRKy9LT0h6WDgxTVBIbmluS0w5Q3pNRXNUalM5?=
 =?utf-8?B?bk02SER6enE2eWZ1c3Jtaks2cjd3Qm1lbnhQVHg2TmlYUWZhN3YrVU9BM0lw?=
 =?utf-8?B?TWc3bkVoR0hRek90T0pjdDkvVzdUN1NhelRSbXVnVldSOFptZENhMTNDMGdE?=
 =?utf-8?B?Vk1VcVFjellQTm1RaTltNFN5dCtyU2gwaWFaOXhtaEFEYWZ5MHdMWERvNXph?=
 =?utf-8?B?dXgrM3lZZWw1bjFJeWdBSmcvS255NWVLSGtKa2N3Z3I3Y3hBZjM3UHV3TGp6?=
 =?utf-8?B?cnhhM0JkK3hOUGxBbExzY2VkQzM1Y2wyaktaZWxBc0ZiK2xHUEU0UnowckRh?=
 =?utf-8?B?WkppdFlIQ2NlVU51TUNucklyc0NySVVHcUhHRHJKRmU3WU5pNU54dmF4UU8x?=
 =?utf-8?B?czd4UVdQMWdoR1NBSnNTUVMyNXViTnZtdmcycnZxN0RKLzN3bm9POHJ1ZGY5?=
 =?utf-8?B?L1M5RGN0QUR6S2ZVdXFDejBRZDZ6NUdIYVN4Qk1lakwxRnpOcVNTY0RGY0E1?=
 =?utf-8?B?aFlMS1ZVSTdnT1E4UnlKMzRETlMxeDVFUThaamlDY3JuNUwxbWs0MU9DWHBo?=
 =?utf-8?B?d1hVN2tyYzBUaGg3ZjlyWDU5anY0UUkzZ2d3SmVOVXhzQ0ZIVzB6L3RGQU5L?=
 =?utf-8?B?TStuc0Z3TUdDdTNqN2JySlFPQ1ZqR2xYQlJYcmtNSndHNmYyek9yUzFyUmp4?=
 =?utf-8?B?MW1sc1hscTg4enNDamZ6Umc3ZFE5NGk2SHdSVXZWYkxWM3JDUnhtQWZzUEJu?=
 =?utf-8?B?RW1UVktCU2NZeVdYZlJUaVlvWHFSSTBZWFp4U212YWtXU1dXSmJ4cVVkZi9r?=
 =?utf-8?B?aFZCM1R1Tyt5V0ZQQU84VU5Kc3plTDZEcHZhYnR2T2RvTlVITElDVTJvQmhj?=
 =?utf-8?B?S0VSdkFLc2lzRjBaYzlmcmtSNXlXNVNBOVNBQnZvTm4yYjF3OERoaFRlNURM?=
 =?utf-8?B?K2lXaGliVGdTUmdtT1dSTHhDMXVrWFZ4SmxwSURRSnR2c3l6S052TjVYMmln?=
 =?utf-8?B?UDJXWEtCZTlPb3JvdEN2aTZMeHFpa2hTSHFUU01SdE9TckZCUG9WNWRTUlda?=
 =?utf-8?B?TXlkdGtFdHQ3SGd3NHdjMlkzTGtCQzRjSjc4UEJYdWgvR0tpNjNiZm1FQURX?=
 =?utf-8?B?VVRjUUxPSVZsdkIxa3l5bUsvSGs0cnc0V0QvOFNhaGlNekRzYkVDNnJOempk?=
 =?utf-8?B?TTQ5blpQaUlaaXMzbU5ERlZaMzJQMVdmbnhqQ2Z1b2VwTlJMZ3V5WGM3b3Bk?=
 =?utf-8?B?UEtkendFeVNTa1NOaE9CWEx1Q1g3YUdZQ1R0cGhKZHFIRWh3QW1HZzNFWnNZ?=
 =?utf-8?B?eWE5QTBscjUvK2NxOVU3QURlTVBjWks1RElCNUgzVENuZnJKY2hBUU44czds?=
 =?utf-8?B?QjMyNy82RlVxWWZVclRRNnRNckFQb0hKSHJXKzFuRndIbFJBRmt4Ym82czc0?=
 =?utf-8?B?Uy9Kc0ZzUUtTbSt2UnZ0dTh5akMwUlBYdjZHUHFkVXJTSmNBa2FmYS90elJG?=
 =?utf-8?B?Si9vTGswSnR6MXpkbWlZZDg2WlEvSUtwUEtnTXpZbkI0VCtmclRiWWs2ZDFy?=
 =?utf-8?B?cXE1dEtCZDNyWXR1WFFyeFEwYzRoOWFxVWExbUpWdDd5ZXg4NUJONFY5cEtS?=
 =?utf-8?B?UUJyVlh6NEpZK0wwVVRjT0JoYlBUK2FlaW1TN25obHp6VnhpRzZBV1gyUzhQ?=
 =?utf-8?B?V2FrSDliSkEwWXZzOHBQRWNQeUtQZG94OTVMejRVQW1uaTUvMG5XOWtYZWwv?=
 =?utf-8?B?bk9peFpqanhqNWExWUMybjRpZllWY2p4T1RITnZMSEE5eXpqMFBzNVNCSzFF?=
 =?utf-8?B?aXNyUXZvMlFuYVFGV3dLUkordXYyWWNlME56SjZIVktLQkE1WkFMTHFVZExr?=
 =?utf-8?B?YzM1MGwwajZTTjBiWm9qbnVYZnVnU3lJMS9oTCtRdFFMM0VITENDVmZOTW5T?=
 =?utf-8?B?ZVNNRWRpQzZiSHU3QXBYOWV5KzdDRlQ3RWJNd3paUEhzMUtmbTVoZHZickJn?=
 =?utf-8?B?RGZjRzhVbmpGVllSTE1FaU9xaDJhSFlmWnBDTWVOTzE3emZ0V2FqWVRGbEFn?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C233738C4F54F846AA4C39154FBFB7E2@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1f5e49-f364-404e-467e-08dbe088e583
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 18:31:17.3456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RgRxhNLlCVkPc0LSEKxDmYk13Epm1drAQ51K7ghR1BlnMAtU6BHXhvJz0vDxNQ55QC8jwmFb9Gk8lEsCeGEDiat92/7DJzDVfHtwYXaeMXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0KTGUgMDgvMTEvMjAyMyDDoCAxMzo1OCwgQXJuZCBCZXJnbWFubiBhIMOpY3Jp
dMKgOg0KPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiANCj4gVGhlIFZE
U08gZnVuY3Rpb25zIGFyZSBkZWZpbmVkIGFzIGdsb2JhbHMgaW4gdGhlIGtlcm5lbCBzb3VyY2Vz
IGJ1dCBpbnRlbmRlZA0KPiB0byBiZSBjYWxsZWQgZnJvbSB1c2Vyc3BhY2UsIHNvIHRoZXJlIGlz
IG5vIG5lZWQgdG8gZGVjbGFyZSB0aGVtIGluIGEga2VybmVsDQo+IHNpZGUgaGVhZGVyLg0KPiAN
Cj4gV2l0aG91dCBhIHByb3RvdHlwZSwgdGhpcyBub3cgY2F1c2VzIHdhcm5pbmdzIHN1Y2ggYXMN
Cj4gDQo+IGFyY2gvbWlwcy92ZHNvL3ZnZXR0aW1lb2ZkYXkuYzoxNDo1OiBlcnJvcjogbm8gcHJl
dmlvdXMgcHJvdG90eXBlIGZvciAnX192ZHNvX2Nsb2NrX2dldHRpbWUnIFstV2Vycm9yPW1pc3Np
bmctcHJvdG90eXBlc10NCj4gYXJjaC9taXBzL3Zkc28vdmdldHRpbWVvZmRheS5jOjI4OjU6IGVy
cm9yOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yICdfX3Zkc29fZ2V0dGltZW9mZGF5JyBbLVdl
cnJvcj1taXNzaW5nLXByb3RvdHlwZXNdDQo+IGFyY2gvbWlwcy92ZHNvL3ZnZXR0aW1lb2ZkYXku
YzozNjo1OiBlcnJvcjogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciAnX192ZHNvX2Nsb2NrX2dl
dHJlcycgWy1XZXJyb3I9bWlzc2luZy1wcm90b3R5cGVzXQ0KPiBhcmNoL21pcHMvdmRzby92Z2V0
dGltZW9mZGF5LmM6NDI6NTogZXJyb3I6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3IgJ19fdmRz
b19jbG9ja19nZXR0aW1lNjQnIFstV2Vycm9yPW1pc3NpbmctcHJvdG90eXBlc10NCj4gYXJjaC9z
cGFyYy92ZHNvL3ZjbG9ja19nZXR0aW1lLmM6MjU0OjE6IGVycm9yOiBubyBwcmV2aW91cyBwcm90
b3R5cGUgZm9yICdfX3Zkc29fY2xvY2tfZ2V0dGltZScgWy1XZXJyb3I9bWlzc2luZy1wcm90b3R5
cGVzXQ0KPiBhcmNoL3NwYXJjL3Zkc28vdmNsb2NrX2dldHRpbWUuYzoyODI6MTogZXJyb3I6IG5v
IHByZXZpb3VzIHByb3RvdHlwZSBmb3IgJ19fdmRzb19jbG9ja19nZXR0aW1lX3N0aWNrJyBbLVdl
cnJvcj1taXNzaW5nLXByb3RvdHlwZXNdDQo+IGFyY2gvc3BhcmMvdmRzby92Y2xvY2tfZ2V0dGlt
ZS5jOjMwNzoxOiBlcnJvcjogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciAnX192ZHNvX2dldHRp
bWVvZmRheScgWy1XZXJyb3I9bWlzc2luZy1wcm90b3R5cGVzXQ0KPiBhcmNoL3NwYXJjL3Zkc28v
dmNsb2NrX2dldHRpbWUuYzozNDM6MTogZXJyb3I6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig
J19fdmRzb19nZXR0aW1lb2ZkYXlfc3RpY2snIFstV2Vycm9yPW1pc3NpbmctcHJvdG90eXBlc10N
Cj4gDQo+IE1vc3QgYXJjaGl0ZWN0dXJlcyBoYXZlIGFscmVhZHkgYWRkZWQgd29ya2Fyb3VuZHMg
Zm9yIHRoZXNlIGJ5IGFkZGluZw0KPiBkZWNsYXJhdGlvbnMgc29tZXdoZXJlLCBidXQgc2luY2Ug
dGhlc2UgYXJlIGFsbCBjb21wYXRpYmxlLCB3ZSBzaG91bGQNCj4gcmVhbGx5IGp1c3QgaGF2ZSBv
bmUgY29weSwgd2l0aCBhbiAjaWZkZWYgY2hlY2sgZm9yIHRoZSAzMi1iaXQgdnMNCj4gNjQtYml0
IHZhcmlhbnQgYW5kIHVzZSB0aGF0IGV2ZXJ5d2hlcmUuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5LCB0
aGUgc3BhcmMgdmVyc2lvbiBpcyBjdXJyZW50bHkgaW5jb21wYXRpYmxlIHNpbmNlDQo+IHRoYXQg
bmV2ZXIgYWRkZWQgc3VwcG9ydCBmb3IgX192ZHNvX2Nsb2NrX2dldHRpbWU2NCgpIGluIDMyLWJp
dA0KPiB1c2VybGFuZC4gRm9yIHRoZSBtb21lbnQsIEknbSBsZWF2aW5nIHRoaXMgb25lIG91dCwg
YXMgSSBjYW4ndA0KPiBlYXNpbHkgdGVzdCBpdCBhbmQgaXQgcmVxdWlyZXMgYSBsYXJnZXIgcmV3
b3JrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4N
Cj4gLS0tDQo+ICAgYXJjaC9hcm0vaW5jbHVkZS9hc20vdmRzby5oICAgICAgICAgICAgICB8ICA1
IC0tLS0tDQo+ICAgYXJjaC9hcm0vdmRzby92Z2V0dGltZW9mZGF5LmMgICAgICAgICAgICB8ICAx
ICsNCj4gICBhcmNoL2FybTY0L2tlcm5lbC92ZHNvMzIvdmdldHRpbWVvZmRheS5jIHwgIDEgKw0K
PiAgIGFyY2gvY3NreS9rZXJuZWwvdmRzby92Z2V0dGltZW9mZGF5LmMgICAgfCAxMSArLS0tLS0t
LS0tLQ0KPiAgIGFyY2gvbG9vbmdhcmNoL3Zkc28vdmdldHRpbWVvZmRheS5jICAgICAgfCAgNyAr
LS0tLS0tDQo+ICAgYXJjaC9taXBzL3Zkc28vdmdldHRpbWVvZmRheS5jICAgICAgICAgICB8ICAx
ICsNCj4gICBhcmNoL3Jpc2N2L2tlcm5lbC92ZHNvL3ZnZXR0aW1lb2ZkYXkuYyAgIHwgIDcgKy0t
LS0tLQ0KPiAgIGFyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYyAgICAgfCAxMCAr
LS0tLS0tLS0tDQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vdmRzby9nZXR0aW1lb2ZkYXkuaCB8
ICAyIC0tDQo+ICAgYXJjaC94ODYvdW0vdmRzby91bV92ZHNvLmMgICAgICAgICAgICAgICB8ICAx
ICsNCj4gICBpbmNsdWRlL3Zkc28vZ2V0dGltZS5oICAgICAgICAgICAgICAgICAgIHwgMjMgKysr
KysrKysrKysrKysrKysrKysrKysNCj4gICAxMSBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25z
KCspLCAzOCBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS92ZHNv
L2dldHRpbWUuaA0KDQpwb3dlcnBjIGhhcyBmdW5jdGlvbnMgZG9pbmcgbW9yZSBvciBsZXNzIHRo
ZSBzYW1lLCB0aGV5IGFyZSBjYWxsZWQgDQpfX2Nfa2VybmVsX2Nsb2NrX2dldHRpbWUoKSBhbmQg
YWxpa2Ugd2l0aCB0aGVpciBwcm90b3R5cGVzIHNpdGluZyBpbiANCmFyY2gvcG93ZXJwYy9pbmNs
dWRlL2FzbS92ZHNvL2dldHRpbWVvZmRheS5oDQoNClNob3VsZCB0aG9zZSBwcm90b3R5cGVzIGJl
IG1vdmVkIHRvIGluY2x1ZGUvdmRzby9nZXR0aW1lLmggdG9vIGFuZCANCmV2ZW50dWFsbHkgcmVu
YW1lZCwgb3IgYXJlIHRoZXkgY29uc2lkZXJlZCB0b28gcG93ZXJwYyBzcGVjaWZpYyA/DQoNCkNo
cmlzdG9waGUNCg==
