Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1027D2875
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjJWCWm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 22 Oct 2023 22:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJWCWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:22:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ECDE8;
        Sun, 22 Oct 2023 19:22:39 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39N2MJpO42643294, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39N2MJpO42643294
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 10:22:21 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 23 Oct 2023 10:22:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 23 Oct 2023 10:22:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 23 Oct 2023 10:22:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Chukun Pan <amadeus@jmu.edu.cn>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF mode table fail
Thread-Topic: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF
 mode table fail
Thread-Index: AQHZ/RSdr1GpsNeu4EyztedoWtdjVLBG6SOQ//+TYACAAKK4uYAN70qAgAGknIA=
Date:   Mon, 23 Oct 2023 02:22:18 +0000
Message-ID: <8dffe5f57c6948e1bca5f7cb3e40a781@realtek.com>
References: <8734yff8vr.fsf@kernel.org>
 <20231022090901.430143-1-amadeus@jmu.edu.cn>
In-Reply-To: <20231022090901.430143-1-amadeus@jmu.edu.cn>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.71.113]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Chukun Pan <amadeus@jmu.edu.cn>
> Sent: Sunday, October 22, 2023 5:09 PM
> To: kvalo@kernel.org
> Cc: Ping-Ke Shih <pkshih@realtek.com>; linux-kernel@vger.kernel.org; linux-wireless@vger.kernel.org;
> Chukun Pan <amadeus@jmu.edu.cn>
> Subject: RE: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF mode table fail
> 
> > _Why_ is that warning printed? Are your devices uncalibrated or are they
> > somehow else special?
> 
> I don't know, but not only my rtl8822be wifi module will have this call trace
> every time when the driver probes. This can be considered a common problem.
> So I prefer to disable this call trace and use the driver warning instead.
> 

Except to call trace, rtl8822be works well in your side? If so, you just
worry the verbose trace, right?  

By the way, I tested two hardware version of rtl8822be, and they both are fine.

Ping-Ke 

