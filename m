Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA58758366
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjGRRZW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjGRRZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:25:21 -0400
X-Greylist: delayed 1117 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Jul 2023 10:25:18 PDT
Received: from 3.mo550.mail-out.ovh.net (3.mo550.mail-out.ovh.net [46.105.60.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C1711C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:25:18 -0700 (PDT)
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.1.13])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 2B775252BC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:06:40 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-kgjmm (unknown [10.110.115.151])
        by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B05EE1FE4F;
        Tue, 18 Jul 2023 17:06:37 +0000 (UTC)
Received: from courmont.net ([37.59.142.109])
        by ghost-submission-6684bf9d7b-kgjmm with ESMTPSA
        id co++IZ3GtmTPUgEAdIjfRg
        (envelope-from <remi@remlab.net>); Tue, 18 Jul 2023 17:06:37 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-109S003826dc6eb-88b5-4684-a2f6-36c303c88a24,
                    3111FEB0E50A85C15A7B3C8E702AC4BF574C28F6) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 87.92.194.88
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     Atish Patra <atishp@atishpatra.org>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Aurelien Jarno <aurelien@aurel32.net>,
        Mathieu Malaterre <malat@debian.org>,
        Jan Newger <jannewger@google.com>
Subject: Re: [PATCH v4 00/10] riscv: Allow userspace to directly access perf counters
Date:   Tue, 18 Jul 2023 20:06:36 +0300
Message-ID: <4761144.fSbbhVQpq0@basile.remlab.net>
Organization: Remlab
In-Reply-To: <CAOnJCU+ee=FXWp7mz_Tn07TbRBb3eXLFBqyRBAJbhQTO-Jxvrw@mail.gmail.com>
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
 <DDB4EEB8-12A0-4E66-8E96-808E84A82078@remlab.net>
 <CAOnJCU+ee=FXWp7mz_Tn07TbRBb3eXLFBqyRBAJbhQTO-Jxvrw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 14312439619513293242
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkohgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpeftrohmihcuffgvnhhishdqvehouhhrmhhonhhtuceorhgvmhhisehrvghmlhgrsgdrnhgvtheqnecuggftrfgrthhtvghrnhephedujedulefftedvvefgueehjeekhfeukeegtdeijefgheevgeehkeekhedtleeknecuffhomhgrihhnpehffhhmphgvghdrohhrghdprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrvghmihesrhgvmhhlrggsrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Le tiistaina 18. heinäkuuta 2023, 2.22.54 EEST Atish Patra a écrit :
> > AFAIK, if the default settings breaks user space, the patchset is
> > considered to break user space. That being the case, either this case is
> > deemed special enough that breaking user space is OK, or it is not.

> This case is a special case as the usage was incorrect in the first
> place.

I agree that it's not only insecure but also incorrect. However it mostly 
works. In fact I don't disagree with the change as such, but I think that the 
commit messages are misleading and confusing. For a start, in one place it 
says that it is not breaking user space and in another it says basically the 
opposite.

(Unfortunately, not everybody agrees with the change. I can't seem to get 
FFmpeg's checkasm tool fixed:
http://ffmpeg.org/pipermail/ffmpeg-devel/2023-July/312245.html )

Also this is not the first time somebody argues that an API should be removed 
because it's broken. That's not special.

> Any application that genuinely requires rdcycle can always get
> it now via the perf interface.

Sure. But the question is whether it breaks user space and if so, whether 
that's acceptable. Existing apps that call RDCYCLE will now fail, presumbly 
receive SIGILL(?).

> If the insecure and incorrect behavior is allowed, we suspect the user
> space behavior will never be fixed as it is hard to put a future flag
> date in these cases.

For better or worse, I can only agree there. But then adding an option to 
preserve the broken behaviour is begging for people to (ab)use it, and indeed 
never fix the problem, and never be able to remove the option.

> > If it is not OK, then the only way out that I can think of, consists of
> > trapping and emulating the counters, returning the same sanitised values
> > that Linux perf would return. Then you can add a kernel config option to
> > disable that trap-and-emulation code in the future.
> What do you mean by "sanitised" value ?

I mean whatever avoids creating a security issue. Presumably report the number 
of cycles spent in the calling thread and in user mode since the first time 
that the process called RDCYCLE?

Maybe it's not reasonable for complexity or performance reasons, but then IMO, 
it deserves a little bit better explaining in the commit message.

-- 
雷米‧德尼-库尔蒙
http://www.remlab.net/



