Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6A378387B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjHVD2C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 23:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjHVD2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:28:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99BB1CCA;
        Mon, 21 Aug 2023 20:27:47 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37M3R5TO0001870, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37M3R5TO0001870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 11:27:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 22 Aug 2023 11:26:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 22 Aug 2023 11:26:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 22 Aug 2023 11:26:28 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek automotive PCIe driver code
Thread-Topic: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Thread-Index: AQHZz4Ya38d07ViN20S7bf3O9T4Qta/q9pcAgAMgk2D//87KAIABzfpQ///CfgCABJnu0IAALOEAgACljtD//5/vgAAlziXA
Date:   Tue, 22 Aug 2023 03:26:28 +0000
Message-ID: <e4f258b5e3d14a04a841d9d2b2ac82ef@realtek.com>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
 <20230815143756.106623-2-justinlai0215@realtek.com>
 <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
 <4955506dbf6b4ebdb67cbb738750fbc8@realtek.com>
 <eb245c85-0909-4a75-830d-afb96ccd5d38@lunn.ch>
 <4951391892534eaeb2da96f052364e4c@realtek.com>
 <4b630aeb-3098-4108-b8dc-7da6e55a7cf1@lunn.ch>
 <6d35d56f78b7452b9330c3257748fa3c@realtek.com>
 <97f3744d-afbf-4562-9168-5b9e211fac1f@lunn.ch>
 <4db3248874d64418b63fdf5c5e8a0f79@realtek.com>
 <3e5b2f0a-3661-4147-bc4e-784eecf41364@lunn.ch>
In-Reply-To: <3e5b2f0a-3661-4147-bc4e-784eecf41364@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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

> > But I2C, SPI, MDIO are connected to the SoC through this chip's
> > external pins, not on the PCIe bus.
> 
> Thanks, that was the information i was trying to get at.
> 
> > Actually, there is the other function in the PCIe GMAC(Multiple
> > function) to manage the registers of Switch Core.  Should they be
> > integrated into the MFD driver?
> 
> Can you cleanly attach another PCI driver to those functions?

Yes, they could be attached individually

> You need to use an MFD when there is a single top level addressable block of
> hardware which has multiple functions. Thank of an I2C device, which has a
> single address on the bus, but multiple functions.
> Access to that one address needs to be shared via multiple drivers. The MFD
> framework provides the glue to share access to the hardware.
> 
> However, PCI identification and addressing is more flexible. So long as they are
> separate PCI functions, you should be able to load two drivers and not have
> problems. Then you don't need an MFD.

Thank you very much for your comments and time for review. 
