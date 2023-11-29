Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2C07FD07B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjK2IRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjK2IRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:17:07 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785191735;
        Wed, 29 Nov 2023 00:17:08 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 35C2E100017;
        Wed, 29 Nov 2023 11:17:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 35C2E100017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701245825;
        bh=O5NkTrwZ+QdAByF4tbA1RQkxuNPKJka+PuD56Wd0pzI=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=BZUTJQfzjFd5iYndxEgO+vC1N8ygMCQdVHYvFncw/h4znpKenBhDCtwaTwBrsOjVK
         YmTDsgiw77qr1pxLioqRKJqOgC0wFSYsRD/nUVHIbvlgIkJPp1f2J8CCOEordO87hG
         5ZZpdkpY5mYa27WKNy7GK2f+ZUoCXpq0W2+tDpWsDJG1iiimDAqcljyg1s80R2xFOz
         vCQPbqvznJobhlP2rosWH6WB840l5WHpXOl7hl7WSWnKNpnLUVGeR7M7/mJ0/HpQcl
         8Ct8RLxwcDU01UyxoNKimrfxd16fB1ZfdSG2tjAnhW1Y1Ou3WYB6/fJpRa6l0NEATO
         e/V+cdT+xrqCQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 29 Nov 2023 11:17:05 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 11:17:04 +0300
Date:   Wed, 29 Nov 2023 11:17:04 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20231129081704.f26fu3g2svnam7n5@CAB-WSD-L081021>
References: <20231129084547.79c27d63@canb.auug.org.au>
 <20231128144514.aa04099199dc13f52374e2b2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231128144514.aa04099199dc13f52374e2b2@linux-foundation.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181676 [Nov 29 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/29 05:52:00 #22570775
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen and Andrew,

On Tue, Nov 28, 2023 at 02:45:14PM -0800, Andrew Morton wrote:
> On Wed, 29 Nov 2023 08:45:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > After merging the mm tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> > 
> > make[5]: *** No rule to make target 'samples/cgroup/cgroup_event_listener.c', needed by 'samples/cgroup/cgroup_event_listener'.  Stop.
> > 
> > Caused by commit
> > 
> >   fc2cf253aaec ("samples: introduce new samples subdir for cgroup")
> > 
> > I have reverted that commit (and the following one) for today.
> 
> Thanks, my rename detector broke.  Fixed.

Sorry, I don't fully understand the situation. Is there any issue on my
side? I have added new samples to the Makefile, and it's very strange
that there are build failures.

Makefile contains:

====
# SPDX-License-Identifier: GPL-2.0
userprogs-always-y += cgroup_event_listener
userccflags += -I usr/include
====

-- 
Thank you,
Dmitry
