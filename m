Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA7E7C7B12
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjJMBL4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 21:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMBLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:11:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3448283;
        Thu, 12 Oct 2023 18:11:49 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39D1BWtI42007851, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39D1BWtI42007851
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 09:11:32 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 13 Oct 2023 09:11:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 13 Oct 2023 09:11:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 13 Oct 2023 09:11:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Chukun Pan <amadeus@jmu.edu.cn>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF mode table fail
Thread-Topic: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF
 mode table fail
Thread-Index: AQHZ/RSdr1GpsNeu4EyztedoWtdjVLBG6SOQ
Date:   Fri, 13 Oct 2023 01:11:32 +0000
Message-ID: <6991a517301a46159085a0b06d43f319@realtek.com>
References: <20231012140120.891411-1-amadeus@jmu.edu.cn>
In-Reply-To: <20231012140120.891411-1-amadeus@jmu.edu.cn>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
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
> Sent: Thursday, October 12, 2023 10:01 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Chukun
> Pan <amadeus@jmu.edu.cn>
> Subject: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF mode table fail
> 
> The rtw88 driver throws a useless Call Trace when the rtl8812bu
> or rtl8822be wifi modules fail to write the RF mode table.

Why do you think this trace is useless? As I see, there is more than one callers.
Did you meet a real case it throws this trace? If yes, how about the frequency?

Ping-Ke

