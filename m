Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C707F557E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjKWAnu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 19:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjKWAnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:43:49 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F99D41;
        Wed, 22 Nov 2023 16:43:43 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AN0fd9A32593574, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AN0fd9A32593574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 08:41:39 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 23 Nov 2023 08:41:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 08:41:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 23 Nov 2023 08:41:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Su Hui <suhui@nfschina.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "lizetao1@huawei.com" <lizetao1@huawei.com>,
        "linville@tuxdriver.com" <linville@tuxdriver.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH wireless-next 2/2] rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
Thread-Topic: [PATCH wireless-next 2/2] rtlwifi: rtl8821ae: phy: fix an
 undefined bitwise shift behavior
Thread-Index: AQHaHSNCghVLlD1f6kiAq806Rpki+bCFx80AgAFHvAA=
Date:   Thu, 23 Nov 2023 00:41:39 +0000
Message-ID: <99ec66d717b249e781f9316cbd689521@realtek.com>
References: <20231122090210.951185-1-suhui@nfschina.com>
 <20231122090210.951185-2-suhui@nfschina.com>
 <2ec14802-78b0-4a3f-a730-19e95ec8d359@suswa.mountain>
In-Reply-To: <2ec14802-78b0-4a3f-a730-19e95ec8d359@suswa.mountain>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Wednesday, November 22, 2023 9:02 PM
> To: Su Hui <suhui@nfschina.com>
> Cc: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org; nathan@kernel.org; ndesaulniers@google.com;
> trix@redhat.com; lizetao1@huawei.com; linville@tuxdriver.com; Larry.Finger@lwfinger.net;
> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; llvm@lists.linux.dev;
> kernel-janitors@vger.kernel.org
> Subject: Re: [PATCH wireless-next 2/2] rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
> 
> Perhaps, a better way to silence the warning is to just change
> _rtl8821ae_phy_calculate_bit_shift() to not return 32 bits?  Do we
> really ever pass bitmask 0?  No idea...
> 

I think the bitmask should not 0, so just replace _rtl8821ae_phy_calculate_bit_shift()
by __ffs(bitmask). To be safer, callers can check bitmask is not 0 before calling. 

Ping-Ke

