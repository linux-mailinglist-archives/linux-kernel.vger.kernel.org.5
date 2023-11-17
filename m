Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084A47EF69F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346133AbjKQQww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjKQQwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:52:49 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22963D56
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:52:43 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3523B5C00A6;
        Fri, 17 Nov 2023 11:52:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 Nov 2023 11:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1700239959; x=1700326359; bh=qj
        ad5w1xVe45VNf69YXVdf321u58ZmSanTzhkR3x92o=; b=ocTtZWdou6T9ZnJINU
        1lrlCAvSOFFPh2DgMFH8C3XpO3v75aMMzwhKuHsGsddJyQT5exPSFlKlWYowagop
        ccMEbKouRjnXqtINvy7nK6uOb/JZZDDXyEEx8r0yBllZT5o24grLTGKe9td7B3VK
        KRP85nU1EOBVEse45iTflbGPMTTKZNWdlWylr4AZmH2u+hpO0Uhpd//xde3iGEKz
        7GtkKgbjBsJYMjfeoVkZxB3bcNfMhEZX43FeF+6pAcj3WurqGV+27WgikQM7A69F
        3t9jxbrdO8VOjgT7F+THFhYBb+5T+29dKnrRI7+rnyhBCW7xkmBZfHnmVbMmWx73
        t2Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700239959; x=1700326359; bh=qjad5w1xVe45V
        Nf69YXVdf321u58ZmSanTzhkR3x92o=; b=ivNcVvll353DESAycqQeTIeA41Uwe
        Ia0x8tqlYC4Cn2PVrxNUNvAGfCpcAP+G/E6Np8EomRY7QH9vslLC9mRPvm77buLP
        l4loH2+ZAQNuN0NMgancgIn0YOD4c1sY6JcSvwqGjsylBCyOHjdeU/OFvgVBvtV5
        UwnOntL4uWVELTc/Ccz4SezC13+pgXe60WVS8dQ/BUpe+jQcMtX/Drq16g5flsnh
        0RtgB0B3Obi/db4wI8Zss4m0TmXpt8DcxLBx/WohSksFb9uQ37bnPRiC5MiwplqD
        DM4edNjWfe5u0QyJIEqiXGjYE/JeFP+jjtpY1PfD3BvhK40fe6NvMg4lQ==
X-ME-Sender: <xms:VppXZeKSGAMqceQGsD7hGLCskTchkwXLhl_E7V1_IcnYhxWdmZXP5A>
    <xme:VppXZWKyuxGj-AJ0-87etinrSoa50D3hFq9Cww8nXrqEpN25cFE8-eDl0pToU0Bq5
    8EoPF_4pEy18ArfT50>
X-ME-Received: <xmr:VppXZetX55SP12CtsgwZKEn7V9KD7aZAlH2wxYaC7Ege3tlaA5EPcQ-->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegtddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepufhtvghf
    rghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecuggftrfgrth
    htvghrnhepvdduhfdvffduvedvkedvffejvdejuedvfeejtdejtefffeejgfelhfetkedt
    geeknecuffhomhgrihhnpehkshhmtddupgdurdhfrghilhdpkhgvrhhnvghlrdhorhhgpd
    hkshhmtddurdhfrghilhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:VppXZTb9BFshMKaZ0qYqiCKJNrzGrqHZVeTXYiJwUR0nyLx4ZxfMfg>
    <xmx:VppXZVYYqroLtNRKhx0BBEwq1v13ba3YgalXZffaKYDa6Mnug5VVPg>
    <xmx:VppXZfA8eNBni4zLaCLLW7LMPABY19fU5sPB6FUE6iZogBDtb3LWZQ>
    <xmx:V5pXZTMRmMsVJUZmRwh5iIjMvOquoWNl493FMJMIGnOksj4jUZQgRw>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Nov 2023 11:52:35 -0500 (EST)
References: <202311161132.13d8ce5a-oliver.sang@intel.com>
 <3540fd3e-88dd-462b-88ce-df28b7b5b148@redhat.com>
User-agent: mu4e 1.10.3; emacs 29.1
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        ltp@lists.linux.it
Subject: Re: [linus:master] [mm/ksm] 5e924ff54d: ltp.ksm01.fail
Date:   Fri, 17 Nov 2023 08:45:07 -0800
In-reply-to: <3540fd3e-88dd-462b-88ce-df28b7b5b148@redhat.com>
Message-ID: <87edgo8gq7.fsf@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 16.11.23 05:39, kernel test robot wrote:
>> hi, Stefan Roesch,
>> we reported
>> "[linux-next:master] [mm/ksm]  5e924ff54d: ltp.ksm01_1.fail"
>> in
>> https://lore.kernel.org/all/202311031548.66780ff5-oliver.sang@intel.com/
>> when this commit is in linux-next/master.
>> now we noticed this commit is merged in mainline, and we still observed
>> same issue. just FYI.
>> Hello,
>> kernel test robot noticed "ltp.ksm01.fail" on:
>> commit: 5e924ff54d088828794d9f1a4d5bf17808f7270e ("mm/ksm: add "smart" page
>> scanning mode")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> [test failed on linus/master 3ca112b71f35dd5d99fc4571a56b5fc6f0c15814]
>> [test failed on linux-next/master 8728c14129df7a6e29188a2e737b4774fb200953]
>> in testcase: ltp
>> version: ltp-x86_64-14c1f76-1_20230715
>> with following parameters:
>> 	disk: 1HDD
>> 	test: mm-00/ksm01
>> compiler: gcc-12
>> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>> If you fix the issue in a separate patch/commit (i.e. not just a new version
>> of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202311161132.13d8ce5a-oliver.sang@intel.com
>> Running tests.......
>> <<<test_start>>>
>> tag=ksm01 stime=1699563923
>> cmdline="ksm01"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
>> tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
>> mem.c:422: TINFO: wait for all children to stop.
>> mem.c:388: TINFO: child 0 stops.
>> mem.c:388: TINFO: child 1 stops.
>> mem.c:388: TINFO: child 2 stops.
>> mem.c:495: TINFO: KSM merging...
>> mem.c:434: TINFO: resume all children.
>> mem.c:422: TINFO: wait for all children to stop.
>> mem.c:344: TINFO: child 1 continues...
>> mem.c:347: TINFO: child 1 allocates 128 MB filled with 'a'
>> mem.c:344: TINFO: child 2 continues...
>> mem.c:347: TINFO: child 2 allocates 128 MB filled with 'a'
>> mem.c:344: TINFO: child 0 continues...
>> mem.c:347: TINFO: child 0 allocates 128 MB filled with 'c'
>> mem.c:400: TINFO: child 1 stops.
>> mem.c:400: TINFO: child 0 stops.
>> mem.c:400: TINFO: child 2 stops.
>> ksm_helper.c:36: TINFO: ksm daemon takes 2s to run two full scans
>> mem.c:264: TINFO: check!
>> mem.c:255: TPASS: run is 1.
>> mem.c:255: TPASS: pages_shared is 2.
>> ....
>> mem.c:255: TPASS: pages_shared is 1.
>> mem.c:255: TPASS: pages_sharing is 98302.
>> mem.c:252: TFAIL: pages_volatile is not 0 but 1.     <-----
>> mem.c:252: TFAIL: pages_unshared is not 1 but 0.     <-----
>
> @Stefan, is this simply related to the new scanning optimization (skip and
> eventually not merge a pages within the "2 scans" windows, whereby previously,
> they would have gotten merged)?
>
> If so, we might just want to disable that optimization for that test case?
>
> Alternatively, maybe we have to wait for "more" scan cycles instead of only 2?

I'd expect this is caused by "smart scan", where we can skip pages.
The best is probably to disable the smart scan feature for this test.
The smart scan feature can be disabled by:

    echo 0 > /sys/kernel/mm/ksm/smart_scan

I'll have a look at it today.
