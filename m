Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC4978BDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjH2FZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbjH2FZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:25:03 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 22:24:59 PDT
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A118D19A;
        Mon, 28 Aug 2023 22:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1693286700; x=1724822700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=34c5f9C7Ye9WFJna4e5T4sicV7LNBJieBWsJR3wooMs=;
  b=jbjcNBwJaRlnh3FcVJLCtsDvgjTokdJDZ9UqeynLy2PlxGdas5zVcD1f
   LomAwfb7msZ/z539bwBekK9cjEGP/sao9Qkt8GJLlKkUPxp4fR9cx9DHA
   0uuTCMMZofoHT81lxh45aQxqvqR2y+cYtbvElpabf6Hc4Tn8au/sD39sm
   kY7r8j8cgHwXS21BJ+vlFZ3PxEnA776eTS84IegRjVhgwOdonlFRjFxBg
   XHbBwlxruarMK+qn00ZWYPHo7/q4J7MSukSeBx41rqVQDhttVV/vGyRn6
   by7MOL1ejYa3keGmt+1xIA7pZlaaTUvyASc3shZMTqlWFIx1TtDknVp7P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="93421315"
X-IronPort-AV: E=Sophos;i="6.02,208,1688396400"; 
   d="scan'208";a="93421315"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 14:23:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kio911tIHJH1vRmoYXwiYhAKesefg4OIP8coEoUmFrAglNWIIEBxwM1HiU1S1EDFqw3eTEFPIv+Qr0+KvICbMDOuiIQeUghfnxD41hqETU9JaAzETZtOPk5u+cAdkLHkvANfSycj8jgjLxezEvAyiLZ2H0aFVfcNNJRQtTg8wxe56MuusPhQsD8vA0ZfHyWd6MqPoDtEB0WGMh3HqQBERiBncuaa7qLoGvZmyxyXeIYUt7cMUt2GDgSvGqRiIrQzsO9bQv6+F1WH0UDOJ2PXraAIvk+H4tT1aaiQF3/RpBcZ3f29AdIpyyYJVm4Fc5vvz7Xskd70e15BSIpbL3LwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz6rOmSApU8HpVC8TYU7OfclBAPEjZqrVWEK2GMVNXM=;
 b=kBb14XcnI+A+bHXPGMCxfmq+zWvCjfhY4bUb9peIzu2ZqZfG9cnEea8dNiaFkZQMp0cOn+Ay83WzMPoPEErtjG2Aagl05XJonh22Wf+BvJlfKnPK540w+AdatOCk9iCYdRXdMVeZ3duThF1P0Ppm9k556rpPGZSHVNQyPmaRU5mITI0Jnp1EJpmP0aF5A4JvkmHCt/80zlaisv6/cQlpmfDVNQBmYq45YuHMUMg3sqrIuPSMI/YQwNhkZ5buNJH28HSoi4jMMjuAeUxbmsdXQ6pXOaLZZygTXXqNBndHy54MnYquLHDXksBLyj35oAD5Vp9xGNFqWEk3T9koRFb+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB11025.jpnprd01.prod.outlook.com (2603:1096:400:3a8::5)
 by OSZPR01MB8579.jpnprd01.prod.outlook.com (2603:1096:604:18d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 05:23:45 +0000
Received: from TYCPR01MB11025.jpnprd01.prod.outlook.com
 ([fe80::c8f6:466b:7013:44a8]) by TYCPR01MB11025.jpnprd01.prod.outlook.com
 ([fe80::c8f6:466b:7013:44a8%5]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 05:23:45 +0000
From:   "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
To:     'Douglas Anderson' <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Yuichi Ito (Fujitsu)" <ito-yuichi@fujitsu.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace using
 pseudo-NMI
Thread-Topic: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace using
 pseudo-NMI
Thread-Index: AQHZ1qB770+2fYuE1kq5V5ql2zgGdLAAuw0A
Date:   Tue, 29 Aug 2023 05:23:34 +0000
Deferred-Delivery: Tue, 29 Aug 2023 05:23:34 +0000
Message-ID: <TYCPR01MB11025E1AB8ED779D1D67F05CBE5E7A@TYCPR01MB11025.jpnprd01.prod.outlook.com>
References: <20230824153233.1006420-1-dianders@chromium.org>
 <20230824083012.v11.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
In-Reply-To: <20230824083012.v11.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9YmE2ZTgzNzktNGZkMi00ZTRhLWI1MTctOGQ4?=
 =?iso-2022-jp?B?N2ZmOWE0YWMwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjMtMDgtMjlUMDQ6NDk6MTFaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 4b2339d40226454c81867ab051945c20
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11025:EE_|OSZPR01MB8579:EE_
x-ms-office365-filtering-correlation-id: 5e3bd688-b152-42d6-5cad-08dba8501df6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eXoHPT5tl0GAgVhROQnWLn4ICFVlMmRdPORcGS0O1PtnDurYQ7af6PAXefEiGLTZki8l4K9Sid89mlXU29OdU0/nu8FrDYRfFHlbVfa3zhdjU236ZiF82bVstIITgIHBlK5KkGCXudy6pMiIgD8f0ejJGL+Is9n62tdljRcH/e2PcwaZl3Afho817HmuUNiJuUbY/sFqFr+As5X0sJYfnWJfONulOT9Udk38gj3Xcut/e0AHyTBBWEg0kDwGmfwp8Ow7nDnctzPyfeEuw/4GwndBFlE/QPCmTcVc0GocLhGy1P/OZwYioT9Qq5FbI6yD368wmENyMT/0zvDJYZu10zxzv+gFE/rCtYVwEfoL81tTRNfBmV992ZdujLqGrvq028XJRuqbMfgSqr0EplwGIoQGJVNxOWoGZjiJU89ogH+7Iu+ygUFfDyV2rgYv7xV76FuV7PhT3WGKZDvI2gu84XNHgdKtHmys5gf7s4GAm9Rf7wljHeHZMVjXMRLPeBeUc+cigcFveDYTVKEhsBR1RsQ7f3u6THeRFMjcrSz0rgYOG0nFWNTnd6bWsjR1xLtprkiRRCzy1yhl11otJDpSGwOx0VCJQtVIPvSKdyz02DXDyo30Oks/JFdjOp+1Rr/f2FgRmAApB1eb/29OpFtgFkfm5/PqHr7dd8ZYin/7AF0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11025.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(1590799021)(1800799009)(451199024)(186009)(9686003)(1580799018)(38100700002)(38070700005)(316002)(41300700001)(82960400001)(4326008)(7416002)(33656002)(2906002)(83380400001)(86362001)(52536014)(85182001)(26005)(5660300002)(8676002)(55016003)(8936002)(6666004)(71200400001)(7696005)(6506007)(966005)(64756008)(66556008)(66476007)(66446008)(54906003)(110136005)(76116006)(122000001)(66946007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eFNLQW0rOW00ZTR5aXJjNXl5YlpyWFhGNTZkd3pGejZFUkxNSDg5c1hI?=
 =?iso-2022-jp?B?M0tLQXQ5Nk8xbEd5NktUR0VsQVlHV2FRQ0Q5NXRQVVdRdjU0dVNQUUFQ?=
 =?iso-2022-jp?B?NFphUGZHdENHTnlydFlQSjZrUkdpVnVGbnFWNGdQWndGUG91N25YdVBX?=
 =?iso-2022-jp?B?dWZYQzB1bHhneGtRZHI5UVgveHF3a3ZVWmVVUDhGU2o4WnU5MDJFKzQ1?=
 =?iso-2022-jp?B?UlJ3TDdGTWdCNytodytXb2tJVXgxWE5WNVBIZmF2bU4wMHIxWjhzbGRR?=
 =?iso-2022-jp?B?RVRkS3R5MGZiOHFXNnUvSkNMamQ1OWdWVVN0dkRUOHpKTzM4UHJHQ2tk?=
 =?iso-2022-jp?B?NWVLRUpJN204QXNSMjl1ZG1PWmM4a0pLZjZidEFGcWlOQStaM2Q2OFRW?=
 =?iso-2022-jp?B?QkZ2VmJmQ1FydFVTb0V4U0FhZm1jczVIVG5VdHpRdWFHZ0p6blRwcG9X?=
 =?iso-2022-jp?B?NzZNejVpUS94L0VUdHZiUU4wTENQZGxUK0RqQ0kzMDJoOXNPaFhURmFJ?=
 =?iso-2022-jp?B?N080c1dQcE1VTUp2a0xYbDlBOUxmZ0VkRmRXVlROVFkzUWQ2aTR2elZS?=
 =?iso-2022-jp?B?NWQyUTM1ZlZlQm44NythOWFKeS9OdEJzL0gxdlBObzFCbkU4Z0RwVVE4?=
 =?iso-2022-jp?B?cnorUGY0TzNhN0RrRHIrb0lReStxdEdUS3FKNzlhLzdVZEd6SGlOTTI3?=
 =?iso-2022-jp?B?Vk01WDJzSTBCVk1YY3kycFlJWHRIZGE4d2hvRU1BTTNPelZoRThKdkxs?=
 =?iso-2022-jp?B?UHlQb2YzcXRzeHV1Z2xGK1ZKZXJQMFNhVVlkdTBYaFkrb2VFRGMraExi?=
 =?iso-2022-jp?B?WDJYRnYwVU42YUlyckNTWGQrZzZVc25vNnFJRFdmZWJaSldEWjN2VXpS?=
 =?iso-2022-jp?B?cEpQeHJsMDFaVXdOdnB4aWgwYjZMTC9kZkVsaHZwK0tlL3J0ZFFiME5Q?=
 =?iso-2022-jp?B?emJXVFdsaFU4NjRIUFNERlJVRjhJNTlzelpGTjlLZDV0L2tmanpjQVN0?=
 =?iso-2022-jp?B?V0U5N3A1OEZ2anV1NUY0eVRVSng3TmMzZnNWNDRVY2hQNzBUcUVQUUYr?=
 =?iso-2022-jp?B?Yy85U256THVHdk1NZE1KeEdDSE9XbmR1ZnJTUU1udlpnL0lpQjhweno1?=
 =?iso-2022-jp?B?bWZmUG5QeFhaZktQc1I0Q0JmOS9ka29qbmZ4YVpYSkZQYkJEdE95bFUx?=
 =?iso-2022-jp?B?b29zdGcyeUN4TjAvNXh0d0FqS2c3TVJCZE1WRTBDYjc4dG1DS2F3U3U1?=
 =?iso-2022-jp?B?MWo4RUdzMkNIbTM0Zm9RYzdlRGR3Y1doSy9MSGJOSGU0L0QxNVlaMXcr?=
 =?iso-2022-jp?B?UTRNR2xWZndkemN6ejZPdGZTRUxIMVFkbGM2T0VQczI2S0l1OWUzMjds?=
 =?iso-2022-jp?B?UHpFRXNJTzY2bElodENYbFVySzFFQ0x1K25hZmp0Z1Q2d29iREFrRFNP?=
 =?iso-2022-jp?B?Q1NhZFJEajB2UXFVanVKRFp4aWs5Y251c3pkcE9GOExnQXdaUnFkNkdw?=
 =?iso-2022-jp?B?WmdST1dyc2NmSzJSREozT3BwL1hrZXNLZWt1Ym1YQ3RiaDBvbjJWSkpB?=
 =?iso-2022-jp?B?QzI1R09ZOWRNLzVCY0RrUHZWN0x0SjFOSFlZYmFRUFFyeXFXaUhNVzY0?=
 =?iso-2022-jp?B?c2E4MXcwbFZxYVhqdy8yUkNaMjdhQXdXRGY4NTNzYmNrZ0t2NitpU3Fw?=
 =?iso-2022-jp?B?dFJtMG50eHJvYUpla21hcnd0aHBGQWp2RHg3WlpYT2czMFRRK2xkQlNL?=
 =?iso-2022-jp?B?ZC9tMjFGYTUycWlUaHEwLzZyZWt6cnFGUmpvUmlQemNFK1ZsaWVOZ05V?=
 =?iso-2022-jp?B?MzZhcWx3Q3NyeGNsZ2Y3VEtXelgzQlVYUDg2dUdPMFBoZnFMbkNmYWx0?=
 =?iso-2022-jp?B?c0pvZEFLVllnWmRONVFCMHFDaW1iMnptSmpVM0IzbTFpK3F0eVlsTGd6?=
 =?iso-2022-jp?B?TzUvN3EyTVptRWlFVkE4bkt6UDdKbmQ1M1BWWTVMS2ZrOHVoSnBFT3pY?=
 =?iso-2022-jp?B?ZEpsOVRVTGVjVGp1RXpkNzRDSjBORlhWMlFBZ1M1RjBDMURDeHA4SFVv?=
 =?iso-2022-jp?B?REVLcXkvOTJrWTJ2dGRuak54b1RwWWpSY05vbWU5ZWJsNCtwTlhscm1p?=
 =?iso-2022-jp?B?L3dWNVVvam5aYkc0UlcxL21IVkl3akFsSWRRaU1EcTY2Rysra21VcHdi?=
 =?iso-2022-jp?B?N0t3a0N1K2NselRZM3BXS3BZVk9JSHhBVUdCZjQ1c3hxdFZLQncrMzVC?=
 =?iso-2022-jp?B?Rk51RENKNWNjdXBmL1J1ZXNxSHAwQnd6K0Z0ZW1Da0czVkRQa09TMEwx?=
 =?iso-2022-jp?B?aStCQlNQQ3JEcTczQzJCMTBURjBPVk5OaFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?YXc4TVRrK25raCtkYjIxU05UR0JWYmcxT2I3Q1Y2QkVSS0o5UUpXNHc5?=
 =?iso-2022-jp?B?UzcwOGx2bVlxSmlrNXJ1UDIreGZpQ2lodTNrZGw5UUhXalpmMUYwcVpq?=
 =?iso-2022-jp?B?M3YvVHlBbTM0OTQ0Q1R6VWFteDdoMkpueHF1N1FucjQ2UmVrYnNYTE1S?=
 =?iso-2022-jp?B?anZQUXU2dVhWQTFtbzcyRHpNSS9sVmx3QWJ2SzJ0Tlk2ci82VGxxZTRk?=
 =?iso-2022-jp?B?QXBDUkVhQ2FzUitZOTRZejVRbHpkS3p2dk05V3VLbEMyOHpTSDM0OW80?=
 =?iso-2022-jp?B?dmI4VWkyNVl3eTJMSFhITjJRUEtrMk1KOCtKUE1zaFNMa0FsUVh4VVA2?=
 =?iso-2022-jp?B?UFZsc044eWtGV0NndWxmWEs3K2g2dDlzWDl0SEVPKzlsM1dFcHVadHpm?=
 =?iso-2022-jp?B?WWpDVCtJMmw2UzRLaDBQVTZVVmFpVG1jOVJTNXFhS2F1eVQrNG1seStO?=
 =?iso-2022-jp?B?TUdybGEwUTBFUnVOYUlWT3l6c3FpRzhRYkZxdTNpcVFhRVBkR3RRdnZw?=
 =?iso-2022-jp?B?NllIL0EvQWpib1l4bUJrV0tFcmhJZVBOcVpyM05GRy9PbVVaRnFsTVdl?=
 =?iso-2022-jp?B?RW9FOE4zR0xaVXFKRnFtS0xFMUZzZHh6aml5Z1ZCcWcrNkY1OTQyd2hS?=
 =?iso-2022-jp?B?TVRBeVVQbXRpOXBqVVZ5Q0F4ZGZJWjlHUll1am84UUNHTldHOGlSTENz?=
 =?iso-2022-jp?B?ME41eVliVFA0VWZMU1AwK0FHSFgyMlNTNzBvMUZ5UE93R2ZudzZndFg4?=
 =?iso-2022-jp?B?V09UYWM4TXluVEVYMWFiTVpZYyt2Q3ZVem1PU2NsMWhQT1BGNWRYa3B3?=
 =?iso-2022-jp?B?TzJXa0taOUFRTG8wMCtaNXVzSEhBejhyeUtHaGorR05xR0xXQkUxelFq?=
 =?iso-2022-jp?B?eHJ3enZEQnJnVTZ1emJyMVBtSjEyMnhxNUZLdTdZeU5GMHZyU21NVTdJ?=
 =?iso-2022-jp?B?Z3ZFOGdaUjJ6bXlwLzE0YlpubmlRV0JwV3VCaHZ5Z1VERXgyTzdTUEth?=
 =?iso-2022-jp?B?MTV4ak5TMjZXdzNmY1dxcmt2cjBWQWx2a1g4N0RUZlQvV25WeGZiTjhF?=
 =?iso-2022-jp?B?YTV4anZvaU1SMnJ1b2JBcmdmUFpoUFJoUEhLMm1JMy90RkpvWXo2UWYx?=
 =?iso-2022-jp?B?T3VncWZjZTMxRDFBTTZQSGRVZlo1SURxUFd2UzJlekQzYURQais0Mml5?=
 =?iso-2022-jp?B?Uy9JOUFpaFh1Mlp6R2VkMDE5ZDZaNk95ei81eVNHVHJZRkFZRzQxSU5O?=
 =?iso-2022-jp?B?WkRpeGQzREI1ejNqMnJxVVlpWUZwY1p2aW1iRDVlaUEwcXd4YUEvMFBY?=
 =?iso-2022-jp?B?LzBpNWswOXA2dFJ2ejYwclBVRVhWWUhKWFF6UGtrZjRmeCtvNDBpcW9W?=
 =?iso-2022-jp?B?bXVrV3M0dVQ5UlBPdStEWWF6Q0hFR1lXZU5VakdmMjRhSjBZWFNXUU42?=
 =?iso-2022-jp?B?aUVveHRnRDlEU1ZJVE5KeXdNR1pVU3lPZHBMN3huME1uQUtRdUUzUXlC?=
 =?iso-2022-jp?B?eVBRdTRuS0NqUXlEOFhFckxDUzNXK2p2V25GZ1diOGd6TXlYTjRNbUpu?=
 =?iso-2022-jp?B?dk9ZbG16QytiWFFZamJQL3J4UlJscXN6a2ZuVm11VDhRZlJhWDNqSWVl?=
 =?iso-2022-jp?B?SEpFYnNoalQzcFh1RE55MTAxSmdMMENUSjUrUlpMVmxhdmRkNmNMMWVr?=
 =?iso-2022-jp?B?Q3kvL25ETlh4b2tmVS9GS2JUSnZvWFZJM3lKd1Q0OXFnV1grbjRVd3Rq?=
 =?iso-2022-jp?B?c1N1M0RjUmx2NXFCc1ozQ29tTW5DZis3V3dWdTdxWVlBQ2VFMjB6QS9Y?=
 =?iso-2022-jp?B?V3hJc0ZDZVNNQU45YUJpRTJhOVprM2wxcUt0YWs1K0ZlNWxaZUdYQy9R?=
 =?iso-2022-jp?B?PT0=?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11025.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3bd688-b152-42d6-5cad-08dba8501df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 05:23:45.6479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vaow/jW29uy6FPhO36iD1VQtzWnJwxIch1nKjaoRhlfZB9c4lzbMZXcR9s0s3tyxVFd6lyfLp9QJopCY92iqwZ+pwtjkSBffljdbr0HAa4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8579
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> Subject: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace using
> pseudo-NMI
>=20
> Enable arch_trigger_cpumask_backtrace() support on arm64. This enables
> things much like they are enabled on arm32 (including some of the
> funky logic around NR_IPI, nr_ipi, and MAX_IPI) but with the
> difference that, unlike arm32, we'll try to enable the backtrace to
> use pseudo-NMI.
>=20
> NOTE: this patch is a squash of the little bit of code adding the
> ability to mark an IPI to try to use pseudo-NMI plus the little bit of
> code to hook things up for kgdb. This approach was decided upon in the
> discussion of v9 [1].
>=20
> This patch depends on commit 36759e343ff9 ("nmi_backtrace: allow

Hi,
Is this commit ID valid? I believe this commit is not included in the
mainline yet. Other than this,
 Reviewed-by: Misono Tomohiro <misono.tomohiro@fujitsu.com>

Regards,
Tomohiro

> excluding an arbitrary CPU") since that commit changed the prototype
> of arch_trigger_cpumask_backtrace(), which this patch implements.
>=20
> [1] https://lore.kernel.org/r/ZORY51mF4alI41G1@FVFF77S0Q05N
>=20
> Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Co-developed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>=20
> Changes in v11:
> - Adjust comment about NR_IPI/MAX_IPI.
> - Don't use confusing "backed by" idiom in comment.
> - Made arm64_backtrace_ipi() static.
>=20
> Changes in v10:
> - Backtrace now directly supported in smp.c
> - Squash backtrace into patch adding support for pseudo-NMI IPIs.
>=20
> Changes in v9:
> - Added comments that we might not be using NMI always.
> - Fold in v8 patch #10 ("Fallback to a regular IPI if NMI isn't enabled")
> - Moved header file out of "include" since it didn't need to be there.
> - Remove arm64_supports_nmi()
> - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> - arch_trigger_cpumask_backtrace() no longer returns bool
>=20
> Changes in v8:
> - Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
> - debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param
>=20
>  arch/arm64/include/asm/irq.h |  3 ++
>  arch/arm64/kernel/smp.c      | 86
> +++++++++++++++++++++++++++++++-----
>  2 files changed, 78 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index fac08e18bcd5..50ce8b697ff3 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -6,6 +6,9 @@
>=20
>  #include <asm-generic/irq.h>
>=20
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int
> exclude_cpu);
> +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> +
>  struct pt_regs;
>=20
>  int set_handle_irq(void (*handle_irq)(struct pt_regs *));
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index a5848f1ef817..c8896cbc5327 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -33,6 +33,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/kexec.h>
>  #include <linux/kvm_host.h>
> +#include <linux/nmi.h>
>=20
>  #include <asm/alternative.h>
>  #include <asm/atomic.h>
> @@ -72,12 +73,18 @@ enum ipi_msg_type {
>  	IPI_CPU_CRASH_STOP,
>  	IPI_TIMER,
>  	IPI_IRQ_WORK,
> -	NR_IPI
> +	NR_IPI,
> +	/*
> +	 * Any enum >=3D NR_IPI and < MAX_IPI is special and not tracable
> +	 * with trace_ipi_*
> +	 */
> +	IPI_CPU_BACKTRACE =3D NR_IPI,
> +	MAX_IPI
>  };
>=20
>  static int ipi_irq_base __read_mostly;
>  static int nr_ipi __read_mostly =3D NR_IPI;
> -static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
> +static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;
>=20
>  static void ipi_setup(int cpu);
>=20
> @@ -845,6 +852,22 @@ static void __noreturn ipi_cpu_crash_stop(unsigned i=
nt
> cpu, struct pt_regs *regs
>  #endif
>  }
>=20
> +static void arm64_backtrace_ipi(cpumask_t *mask)
> +{
> +	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
> +}
> +
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int
> exclude_cpu)
> +{
> +	/*
> +	 * NOTE: though nmi_trigger_cpumask_backtrace has "nmi_" in the
> name,
> +	 * nothing about it truly needs to be implemented using an NMI, it's
> +	 * just that it's _allowed_ to work with NMIs. If ipi_should_be_nmi()
> +	 * returned false our backtrace attempt will just use a regular IPI.
> +	 */
> +	nmi_trigger_cpumask_backtrace(mask, exclude_cpu,
> arm64_backtrace_ipi);
> +}
> +
>  /*
>   * Main handler for inter-processor interrupts
>   */
> @@ -888,6 +911,14 @@ static void do_handle_IPI(int ipinr)
>  		break;
>  #endif
>=20
> +	case IPI_CPU_BACKTRACE:
> +		/*
> +		 * NOTE: in some cases this _won't_ be NMI context. See the
> +		 * comment in arch_trigger_cpumask_backtrace().
> +		 */
> +		nmi_cpu_backtrace(get_irq_regs());
> +		break;
> +
>  	default:
>  		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
>  		break;
> @@ -909,6 +940,19 @@ static void smp_cross_call(const struct cpumask *tar=
get,
> unsigned int ipinr)
>  	__ipi_send_mask(ipi_desc[ipinr], target);
>  }
>=20
> +static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
> +{
> +	if (!system_uses_irq_prio_masking())
> +		return false;
> +
> +	switch (ipi) {
> +	case IPI_CPU_BACKTRACE:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static void ipi_setup(int cpu)
>  {
>  	int i;
> @@ -916,8 +960,14 @@ static void ipi_setup(int cpu)
>  	if (WARN_ON_ONCE(!ipi_irq_base))
>  		return;
>=20
> -	for (i =3D 0; i < nr_ipi; i++)
> -		enable_percpu_irq(ipi_irq_base + i, 0);
> +	for (i =3D 0; i < nr_ipi; i++) {
> +		if (ipi_should_be_nmi(i)) {
> +			prepare_percpu_nmi(ipi_irq_base + i);
> +			enable_percpu_nmi(ipi_irq_base + i, 0);
> +		} else {
> +			enable_percpu_irq(ipi_irq_base + i, 0);
> +		}
> +	}
>  }
>=20
>  #ifdef CONFIG_HOTPLUG_CPU
> @@ -928,8 +978,14 @@ static void ipi_teardown(int cpu)
>  	if (WARN_ON_ONCE(!ipi_irq_base))
>  		return;
>=20
> -	for (i =3D 0; i < nr_ipi; i++)
> -		disable_percpu_irq(ipi_irq_base + i);
> +	for (i =3D 0; i < nr_ipi; i++) {
> +		if (ipi_should_be_nmi(i)) {
> +			disable_percpu_nmi(ipi_irq_base + i);
> +			teardown_percpu_nmi(ipi_irq_base + i);
> +		} else {
> +			disable_percpu_irq(ipi_irq_base + i);
> +		}
> +	}
>  }
>  #endif
>=20
> @@ -937,15 +993,23 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>  {
>  	int i;
>=20
> -	WARN_ON(n < NR_IPI);
> -	nr_ipi =3D min(n, NR_IPI);
> +	WARN_ON(n < MAX_IPI);
> +	nr_ipi =3D min(n, MAX_IPI);
>=20
>  	for (i =3D 0; i < nr_ipi; i++) {
>  		int err;
>=20
> -		err =3D request_percpu_irq(ipi_base + i, ipi_handler,
> -					 "IPI", &cpu_number);
> -		WARN_ON(err);
> +		if (ipi_should_be_nmi(i)) {
> +			err =3D request_percpu_nmi(ipi_base + i, ipi_handler,
> +						 "IPI", &cpu_number);
> +			WARN(err, "Could not request IPI %d as NMI,
> err=3D%d\n",
> +			     i, err);
> +		} else {
> +			err =3D request_percpu_irq(ipi_base + i, ipi_handler,
> +						 "IPI", &cpu_number);
> +			WARN(err, "Could not request IPI %d as IRQ,
> err=3D%d\n",
> +			     i, err);
> +		}
>=20
>  		ipi_desc[i] =3D irq_to_desc(ipi_base + i);
>  		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
> --
> 2.42.0.rc1.204.g551eb34607-goog
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
