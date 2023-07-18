Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890AB758606
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGRUUo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 16:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGRUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:20:42 -0400
X-Greylist: delayed 4552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Jul 2023 13:20:41 PDT
Received: from 14.mo581.mail-out.ovh.net (14.mo581.mail-out.ovh.net [178.33.251.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35749B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:20:41 -0700 (PDT)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.109.156.164])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 2E98D26CC6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:04:47 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-g6sfr (unknown [10.110.103.4])
        by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5EA4F1FDBD;
        Tue, 18 Jul 2023 19:04:46 +0000 (UTC)
Received: from courmont.net ([37.59.142.109])
        by ghost-submission-6684bf9d7b-g6sfr with ESMTPSA
        id hDu6EU7itmQ5AgAA6V/YAg
        (envelope-from <remi@remlab.net>); Tue, 18 Jul 2023 19:04:46 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-109S003d480a6fd-102e-4f80-8590-9c2f09ff353c,
                    3111FEB0E50A85C15A7B3C8E702AC4BF574C28F6) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 87.92.194.88
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aurelien Jarno <aurelien@aurel32.net>,
        Mathieu Malaterre <malat@debian.org>,
        Jan Newger <jannewger@google.com>
Subject: Re: [PATCH v4 00/10] riscv: Allow userspace to directly access perf counters
Date:   Tue, 18 Jul 2023 22:04:45 +0300
Message-ID: <8756384.Zvl9fuB8X0@basile.remlab.net>
Organization: Remlab
In-Reply-To: <CAOnJCUJreDYWZcSRr-pb1vwRg_LyU7TBG+b_9Ys8rVmM8_fvgA@mail.gmail.com>
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
 <4761144.fSbbhVQpq0@basile.remlab.net>
 <CAOnJCUJreDYWZcSRr-pb1vwRg_LyU7TBG+b_9Ys8rVmM8_fvgA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 16307252779307833786
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggdduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkohgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpeftrohmihcuffgvnhhishdqvehouhhrmhhonhhtuceorhgvmhhisehrvghmlhgrsgdrnhgvtheqnecuggftrfgrthhtvghrnhephedujedulefftedvvefgueehjeekhfeukeegtdeijefgheevgeehkeekhedtleeknecuffhomhgrihhnpehffhhmphgvghdrohhrghdprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrvghmihesrhgvmhhlrggsrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le tiistaina 18. heinäkuuta 2023, 21.45.15 EEST Atish Patra a écrit :
> > I agree that it's not only insecure but also incorrect. However it mostly
> > works. In fact I don't disagree with the change as such, but I think that
> > the commit messages are misleading and confusing. For a start, in one
> > place it says that it is not breaking user space and in another it says
> > basically the opposite.
> 
> Agreed. We will improve the commit message to clarify that. That's also the
> reason I started this whole thread :)
> 
> > (Unfortunately, not everybody agrees with the change. I can't seem to get
> > FFmpeg's checkasm tool fixed:
> > http://ffmpeg.org/pipermail/ffmpeg-devel/2023-July/312245.html )
> 
> Why can't rdtime(equivalent of rdtsc) be used instead of rdcycle ?

Isn't RDTIM susceptible to interference from power management and CPU 
frequency scaling? I suppose that RDCYCLE may behave differently depending on 
PM in *some* designs, but that would still be way better than RDTIME for the 
purpose.

As far as benchmarking is concerned (_excluding_ system security), RDTIME 
seems to have all the problems of RDCYCLE, and then some more, no?

> The perf syscall overhead is just one time setup thing during the
> start of the application.
> For counting the cycles before/after a loop, it still provides a
> direct CSR access in user mode.

I suppose that you allude to mmap() here? The (dumb) FFmpeg code is using the 
ioctl() interface though, but that's just laziness.

-- 
レミ・デニ-クールモン
http://www.remlab.net/



