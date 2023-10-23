Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947647D291E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjJWDcr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 22 Oct 2023 23:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjJWDcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:32:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F6D51;
        Sun, 22 Oct 2023 20:32:40 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39N3VOPf82742393, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39N3VOPf82742393
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 11:31:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 23 Oct 2023 11:31:25 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 23 Oct 2023 11:31:24 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Mon, 23 Oct 2023 11:31:24 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] misc: rtsx: add to support new card reader rts5264
Thread-Topic: [PATCH v3 1/2] misc: rtsx: add to support new card reader
 rts5264
Thread-Index: AQHaAynsmhTs26pH702PHG8h5layhrBUNdwAgAJ4IRA=
Date:   Mon, 23 Oct 2023 03:31:24 +0000
Message-ID: <b31f74462ce240a18652643224e285dd@realtek.com>
References: <121ced554a9e4f4791018e8f6a72d586@realtek.com>
 <2023102153-paramedic-washboard-29e3@gregkh>
In-Reply-To: <2023102153-paramedic-washboard-29e3@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.100]
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

> > In order to support new chip rts5264, the definitions of some internal
> > registers and workflow have to be modified.
> 
> That is fine, but that should be a single patch, right?
> 

Sorry maybe about misunderstand, The modifications mentioned here, it talk about
some judgment expressions add "PID 5264" to make judgement in rtsx_pcr.c, 
so only about 30 line modified in rtsx_pcr.c

> > Added rts5264.c rts5264.h for independent functions of the new chip rts5264
> 
> And then add new support in a new patch, this is still too big as one
> patch to attempt to review it properly.  Would you like to review this
> as-is?
> 

Yes, thank you
Because rts5264.c rts5264.h only for rts5264 (new chip).
The past architecture of this driver was like this, and it will good for us to maintain the driver
different chip maybe has different functions and register definitions we used to separate different .c .h


> thanks,
> 
> greg k-h
