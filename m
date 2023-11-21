Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851147F290E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjKUJfb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 04:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjKUJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:35:29 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22970FA;
        Tue, 21 Nov 2023 01:35:25 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AL9Z2NX01510597, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AL9Z2NX01510597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 17:35:02 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Nov 2023 17:35:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 21 Nov 2023 17:35:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 21 Nov 2023 17:35:02 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Simon Horman <horms@kernel.org>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v11 00/13] Add Realtek automotive PCIe driver
Thread-Topic: [PATCH net-next v11 00/13] Add Realtek automotive PCIe driver
Thread-Index: AQHaF8hx62WvfSwr8k6No036AHxBZLB8twcAgAfUibA=
Date:   Tue, 21 Nov 2023 09:35:02 +0000
Message-ID: <6f765fed07f0455bbc46f86698c1b62d@realtek.com>
References: <20231115133414.1221480-1-justinlai0215@realtek.com>
 <20231116175724.GF109951@vergenet.net>
In-Reply-To: <20231116175724.GF109951@vergenet.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Nov 15, 2023 at 09:34:01PM +0800, Justin Lai wrote:
> > This series includes adding realtek automotive ethernet driver and
> > adding rtase ethernet driver entry in MAINTAINERS file.
> >
> > This ethernet device driver for the PCIe interface of Realtek
> > Automotive Ethernet Switch,applicable to RTL9054, RTL9068, RTL9072,
> > RTL9075, RTL9068, RTL9071.
> 
> ...
> 
> >  MAINTAINERS                                   |    7 +
> >  drivers/net/ethernet/realtek/Kconfig          |   17 +
> >  drivers/net/ethernet/realtek/Makefile         |    1 +
> >  drivers/net/ethernet/realtek/rtase/Makefile   |   10 +
> >  drivers/net/ethernet/realtek/rtase/rtase.h    |  353 +++
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 2542 +++++++++++++++++
> >  drivers/net/ethernet/realtek/rtase/tt.c       | 2542 +++++++++++++++++
> >  drivers/net/ethernet/realtek/rtase/tt.h       |  353 +++
> 
> Hi Justin,
> 
> Unless I am mistaken, by the end of this patch set tt.c is identical to
> rtase_main.c, and tt.h is identical to rtase.h.
> 
> If so, why?

Sorry, tt.c and tt.h are redundant codes. This part will be corrected in the next version of the patch.
> 
> $ cd drivers/net/ethernet/realtek/rtase
> $ sha1sum *.[ch] | sort
> 9762c7f0fc1acb214d1705905495fad6b902a3c8  rtase.h
> 9762c7f0fc1acb214d1705905495fad6b902a3c8  tt.h
> ccfe889f5ae3b6ecfa0dfba91d30fd7beffd4291  rtase_main.c
> ccfe889f5ae3b6ecfa0dfba91d30fd7beffd4291  tt.c

