Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CDD7A23E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjIOQs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjIOQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:48:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2103.outbound.protection.outlook.com [40.92.22.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE28269D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzHJucy/ph+k3Y3zqPE5HdyylF4qLEgf2HxFOG0cNDfwCJ2YoPBEW/hkiOFsXMwYWtC3obd4I46MheoHW8xu+srF2+F9YOyJhFuBHaKrbZvdEWmC48g6+lTQuzEnhgJaHJqC7gcbdbA4ELAe90Fo/sRO6PKrRQ4y1K1QeazQcYKLUJcWrPRgEkpOzq2S/fo8A6vSngn2FXuo48pkizgIWDK/0T6M4NC9IZ0ZrUOgXjlmuweNKD1qmzVOWhqwONDrraCQp1xrKsmOVuVLZlF/rqCEcqtWAi354yHuFc+AO34nPtmEQ4UXGMKOQgz0G3RqTr8D2jrunX9S2AZTFVsggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoLp3J16ZXxD3xHs+u2pileZQ3QKrHqSTI27ku9TpcY=;
 b=WcknE7h4mYG+aaAeoJcYSlbzE9Nc1YMfCJFO3oTz1DcITKqZ7Nki6yCcDsZg4xrCNr5774r2lD9/xOw/3KAhpBkJSltYVy4jvbASuJssRcuLwnolnGRB9g3/xGAIF0uWKOTf3nOovspm2foasAXpApkmmLM8DIca0KNgClrerN+S3kgpUylZLWP3Rplu/EO6j3ExJBumQenRb8b7Y6LA069/77LG5kDs5PANawGDw7u0MVpXo+kIx74ojGH70IJMbJ1pOndmqmXhtyc9mbn4MMsDtfi72JpTImaGx9gJ437Tqx0M9T7q9aezuTz1BJPtSHGH5x8XcPQNev0fWb8Jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoLp3J16ZXxD3xHs+u2pileZQ3QKrHqSTI27ku9TpcY=;
 b=lLnhb7bafgCpOSs7P6c1vU4B5dq2WVYV4XSAWkFHbmLocnn50gf7Uurs6T06G5Qr/ppj41Gx6vt8P4MUeOgVNTGCWef1mF//XDugrSIeL6yNYmTl4oTad3EnLdkLtcKBiFaWemAghK1hHMB9vwO1tCA781bFcs8KeFePfAzjsAL9eQzrPh0RWoIiuGfmKpNHrI36wQkWLZ1YVG/NpKomIqgwfDDYuI5q8/B/5jvW6/SlZ/vd5jvhLBfVfXmDuelbM/mTO8K3KnIqIKRGJQFXSGklsONleoNGy1tKk+d3LbGODChKrLMF2zUJKfTfbjAvKNMMOI0F3yDevzHIhDZ8Yg==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by MW5PR06MB9029.namprd06.prod.outlook.com (2603:10b6:303:1ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.40; Fri, 15 Sep
 2023 16:47:51 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c40c:bbc8:b103:459c]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c40c:bbc8:b103:459c%2]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 16:47:50 +0000
Date:   Fri, 15 Sep 2023 11:47:46 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: include/asm-generic/unaligned.h:119:16: sparse: sparse: cast
 truncates bits from constant value (aa01a0 becomes a0)
Message-ID: <SN6PR06MB5342BF4352A5FF56C119D8FFA5F6A@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <202309120820.bRjnU9fZ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309120820.bRjnU9fZ-lkp@intel.com>
X-TMN:  [BALaEFiZhshs7qahAQbFN8KN0ukGIrJD]
X-ClientProxiedBy: DS7PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::30) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <ZQSKsjLNzT2s3gav@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|MW5PR06MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c13a667-fa5d-467d-ccbf-08dbb60b7f25
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0HsxDd9aXrSTrIDFV3w/ieIWoBgN36kQ7VpzWZkuY88Em+aCX7BffAZ1aO9Ji+xT5wOd6cJgw5vsVm+oZ9NDd0AU+GMKUM20aipwpgeYMczdZW9OLjU8o4V3i+ThzZ4g+8Vo8zzF/rYChKbT6s4iLkKg+Tw1uP6N0AfVmZ0YeEY97snmO0HbqsOU1fQItsFdsDv6tYVjmUndjTvGQ3zujmQ8FymkT51QxKy7st7U6SuvyuqUSrIdEQe9gqUbWdoCkz6WOu7sKKWuOuyrhg6VRoSEMn2U0fqq7WsU8FEOjHa6MJpC1d8I0DtXasFjcNLNsMBO1S4+3AikoV2vK38+xFtmYLRHS65fTMXkyLC0wtnCS20+3O0JwgGcZ1HLOT4RDdC94LfxC4XM9mgqnobczgDfdG8OiQDibvNhHUMMg1FP7hxczS3elaKDby3MvFFyspHSo327i6V2f7xWUqBxZdaks/eBHTApH5ssHS2taMp2Kfts16GzJ6EcRJZRG9XKWbkfTKXA4rMfbkho0Pd8B7FAISKab82GykiWrrufnKPUaZfMMLRR52j+FHSc6kbLpjs4WVhRxAG+44/3Z79N8Me+GR/AF893zp1Y7fvvMs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pj10pnmZSGuIfzzyPRAu3sR9FWeFz8BJTeh/QSRg6Mj8fCOYoANy4ypxBEBO?=
 =?us-ascii?Q?eb2wWF1orvDJIey+M/vs5Ger1h+420RUYLGhPaYvwWU5A0QXuKuiVb5P7Wap?=
 =?us-ascii?Q?0GQiD+ZOPR7nd0RFvLRKV2Tjp/4UGbXRKKeLM16sFqwv+apZxoRimMfBosBj?=
 =?us-ascii?Q?8pZYGi4il+79MzVbzCBqP9op77NiLfLdhUkOGk+1DH9/x0km4T5V0StpmgB2?=
 =?us-ascii?Q?UEflq8GnkTipaLJ69CI/MItoEovyo961lcQEx5bqRvUo/3BE9fhvMH53JofN?=
 =?us-ascii?Q?GjAXeCib6Og74xshhQYDP5kSm6PbBkeriZ+IZXgFPNmazKwJpb3idyRp7Ki9?=
 =?us-ascii?Q?P4uarfzEqj9r8PUpbaqBWNVYwJmdnYxzcPH7Mf1Ujv6E4X3oZVjf+UTMsPM7?=
 =?us-ascii?Q?W6nmYEQvTy8Y8xLCPt1gAfu3gSg5b9pAkYweioZKG2oe8VlOmCKYca8hceRf?=
 =?us-ascii?Q?OgH0v32Nb1WBH/w5o4+4nmUAZndHMlovMJvrIqj1ExVN42yEwBcHPJg50DP+?=
 =?us-ascii?Q?r+jrHegChHsJ6s1ZBs5UjFoRgQjU5snCGaZQYD/YNqveR9aG1LONV+K2TjMa?=
 =?us-ascii?Q?V4npPGNPsxwRP6lfrDCyP6uodeSO9QR1n3HRZt2zZ5F/XsOpqSJEW5Zxg/2y?=
 =?us-ascii?Q?MdUo/DICrWH8zhze8X3Fyr+yyWZKjWZOS9JO2frOaXjxjkQnfKWZRaGW2L4z?=
 =?us-ascii?Q?XVPnr4TaqnhhMdTBiJrwYV8q2ZsOwrYXi99o43QldqFXKnyK42jkAUDfjrO3?=
 =?us-ascii?Q?F+e4mhq64XPezlX1RxQ0dxVsmlxh1Y+1aipRKd06nRFbrCj3M47TidRTi9S6?=
 =?us-ascii?Q?VKHrntg539gH5t6QWAxadbWJX/OEJIVYtPke/Ra/YPmUiNoT2ObuBk35DZqN?=
 =?us-ascii?Q?E5CMW3ScK6HVdk6g0/avCpTAtrVWaI23YyFhz9ddwBGQQ2cwjykNKBAd4XIr?=
 =?us-ascii?Q?YijkQWnzuIAkud9guJfmTzquXlYZiFw4niIvpPn6FxKx6Vq4QNh1rNGXlbNO?=
 =?us-ascii?Q?uSLFxHq9i/AFVwLcD6/NxmxuGX9TB2FrGD21ogeAff3fI+2aVGZjsjpBLYVu?=
 =?us-ascii?Q?NIAql3tDX2pEOwVq3qQHqb93vjU/uvgQWykNnDJopzH4ameJY2MDYpwmTdiq?=
 =?us-ascii?Q?aJNAQOrJ8Srfmhn9Mjqd/Wa0y0YyfbP5kSVT56QpFx3Crk4kVa7hysuZEiyA?=
 =?us-ascii?Q?rvWODyK6CuvGWC6KofhizqFy1lFyMNygZkB4Q9lHLTWb06QWhcMnZORVcdM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c13a667-fa5d-467d-ccbf-08dbb60b7f25
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:47:50.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR06MB9029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:46:48AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> commit: 66603243f5283f7f28c795f09e7c2167233df0bd Input: add driver for Hynitron cstxxx touchscreens
> date:   11 months ago
> config: i386-randconfig-061-20230909 (https://download.01.org/0day-ci/archive/20230912/202309120820.bRjnU9fZ-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120820.bRjnU9fZ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309120820.bRjnU9fZ-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    drivers/input/touchscreen/hynitron_cstxxx.c: note: in included file (through arch/x86/include/generated/asm/unaligned.h):
> >> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (aa01a0 becomes a0)
> >> include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (aa01 becomes 1)
> >> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (ab00d0 becomes d0)
> >> include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (ab00 becomes 0)
> 
> vim +119 include/asm-generic/unaligned.h
> 
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  116  
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  117  static inline void __put_unaligned_le24(const u32 val, u8 *p)
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  118  {
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08 @119  	*p++ = val;
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08 @120  	*p++ = val >> 8;
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  121  	*p++ = val >> 16;
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  122  }
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  123  
> 
> :::::: The code at line 119 was first introduced by commit
> :::::: 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63 asm-generic: simplify asm/unaligned.h
> 
> :::::: TO: Arnd Bergmann <arnd@arndb.de>
> :::::: CC: Arnd Bergmann <arnd@arndb.de>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

I'm afraid I don't understand the error in question. When I call the
function put_unaligned_le24() I do see that this function then calls
__put_unaligned_le24() which takes part of the value and does cast
it as a u8. Is that what this error is about? Just trying to figure
out the best way to resolve it, sadly I'm not clearly seeing the issue
so I thought I'd ask.

Thank you.
Chris Morgan
