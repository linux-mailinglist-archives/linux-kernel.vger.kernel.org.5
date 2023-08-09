Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECEA775330
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjHIGt5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Aug 2023 02:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjHIGtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:49:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBF631BFB;
        Tue,  8 Aug 2023 23:49:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3796nDkiD014301, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3796nDkiD014301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 14:49:13 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 9 Aug 2023 14:49:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 9 Aug 2023 14:49:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 9 Aug 2023 14:49:30 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver
Thread-Topic: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver
Thread-Index: AQHZxeQMA/4O5CExTkOPXZ48NozVXK/XvyuAgABzMICACVzJQA==
Date:   Wed, 9 Aug 2023 06:49:29 +0000
Message-ID: <dd9ff9e7d0524335ababccc93651cc76@realtek.com>
References: <20230803082513.6523-1-justinlai0215@realtek.com>
 <ZMtr+WbURFaynK15@nanopsycho> <87194ec9-476a-471b-a5b5-d70e8a2cbcd5@lunn.ch>
In-Reply-To: <87194ec9-476a-471b-a5b5-d70e8a2cbcd5@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 03, 2023 at 10:57:29AM +0200, Jiri Pirko wrote:
> > Thu, Aug 03, 2023 at 10:25:13AM CEST, justinlai0215@realtek.com wrote:
> > >This patch is to add the ethernet device driver for the PCIe
> > >interface of Realtek Automotive Ethernet Switch, applicable to RTL9054,
> RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
> > >
> > >Signed-off-by: justinlai0215 <justinlai0215@realtek.com>
> >
> > [...]
> >
> >
> > >+
> > >+static long rtase_swc_ioctl(struct file *p_file, unsigned int cmd,
> > >+unsigned long arg)
> >
> > There are *MANY* thing wrong in this patch spotted just during 5
> > minutes skimming over the code, but this definitelly tops all of them.
> > I didn't see so obvious kernel bypass attempt for a long time. Ugh,
> > you can't be serious :/
> >
> > I suggest to you take couple of rounds of consulting the patch with
> > some skilled upstream developer internaly before you make another
> > submission in order not not to waste time of reviewers.
> 
> I have to agree with Jiri here. This 'vendor crap' driver has no chance of being
> merged as is. You need to reach out to some experienced mainline driver
> developers to help you rewrite it to mainline quality.
> 
>     Andrew

Thank you for your reply, I will refer to your suggestions to modify my code.
