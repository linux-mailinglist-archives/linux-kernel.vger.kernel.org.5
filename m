Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039A67A03AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbjINMWc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjINMWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:22:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70FCD1FC0;
        Thu, 14 Sep 2023 05:22:26 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38ECLd5A21169338, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38ECLd5A21169338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 20:21:41 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 14 Sep 2023 20:21:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 14 Sep 2023 20:21:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Thu, 14 Sep 2023 20:21:39 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v7 02/13] net:ethernet:realtek:rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v7 02/13] net:ethernet:realtek:rtase: Implement
 the .ndo_open function
Thread-Index: AQHZ5Voer1zs1eayP0a8NW2oYFXOS7AYxCOAgAF8KOA=
Date:   Thu, 14 Sep 2023 12:21:39 +0000
Message-ID: <226589a878f64b5eae3b7ca55936e926@realtek.com>
References: <20230912091830.338164-1-justinlai0215@realtek.com>
 <20230912091830.338164-3-justinlai0215@realtek.com>
 <a7a4d7b6-84cd-49fc-9fde-1a6a232bf7af@lunn.ch>
In-Reply-To: <a7a4d7b6-84cd-49fc-9fde-1a6a232bf7af@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Sep 12, 2023 at 05:18:19PM +0800, Justin Lai wrote:
> > Implement the .ndo_open function to set default hardware settings and
> > initialize the descriptor ring and interrupts. Among them, when
> > requesting irq, because the first group of interrupts needs to process
> > more events, the overall structure will be different from other groups
> > of interrupts, so it needs to be processed separately.
> 
> Please take a look at the page pool code.
> 
>        Andrew

Hi, Andrew
Do you want us to use Page Pool API in this driver?
