Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2284B75E4FA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 23:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGWVEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 17:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 17:04:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3C122;
        Sun, 23 Jul 2023 14:04:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-314313f127fso2682591f8f.1;
        Sun, 23 Jul 2023 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690146289; x=1690751089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ7/4DXG7QClXNpcfbVGF9Xk1htkcz3DMZ3n7khqPCM=;
        b=Rpu8vTC5wyZqz8eFNzFy5r2Fj/z33FaVXv8YIftoq1Zf1eJzBvIBgl0xmvbPjrG9zQ
         nmE99EJK/pLxdRiVfWXM3husN6I/FPkB1ZlKEcHvmJ8C6UVeQHXCQs2Hz/LBTKML5wAd
         HGMVRKUYwxxDJuqc0c5y1ggD7Lr5TBKl0f4DWs+dCJzzrpY4LzQB6K85AvcSuYC82oJT
         Y3U/5cMsMrdPKJVZuArFgrOneSFRBp2uMz/0VwdYofOWYFOXFAVS3OjP2gYPG9aB0X5M
         0hiwQPCMRs2wy2wAHtHbA/38bY9O2Ocf8FQ3uqK5jAqoXLL2QYrOd//4NroXFSDQM742
         zY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690146289; x=1690751089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ7/4DXG7QClXNpcfbVGF9Xk1htkcz3DMZ3n7khqPCM=;
        b=UiRxN/18Ycb1JardUTHcaTzWj5lLkSAvPxtR5t5VZc+H/xou4O/ejXSJfdGfqPnWnq
         Q38krrlhWO/gCzTjJ8zfFxnjCDcOHh7pY69vLuaxfJ0kzpYeixpzt1/rVns3tirR9teq
         4r2UGVPoQmzZlx5NyhBFLmqjPHAkMzu/Nzc89ST87dm1rUvA72WP+FIWXvrx5zxXrmur
         29TO7Yv1/vL0pFTWj3OW6Tmz14kLb9T6nBejqYEenR3OTKhCTnsw8S4vJ4nPDO6yUksN
         U1cih7fmmsT47ybWa5+8NdeUw1G7ySX7UK8rZHzFDcaPDCXE0JfGS76I+kb/+C75pl7+
         kF7w==
X-Gm-Message-State: ABy/qLbJ3p2g2S2I4rQcrtahNkk4nUgovZcjRK3wdVmSFhbg6EkMX3Jb
        X+PymDLOERx0yhr7MK/j/mX5IoWcphSKLQ==
X-Google-Smtp-Source: APBJJlEMh5zqNvgl5FMCHp6O5xJGXJCMhbW6fHdy/aTOSH8HhF9kax7W7lNYIgSrigW6BJVTCnKfsg==
X-Received: by 2002:a7b:cd91:0:b0:3f7:f584:579b with SMTP id y17-20020a7bcd91000000b003f7f584579bmr5246805wmj.9.1690146288972;
        Sun, 23 Jul 2023 14:04:48 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bcbcb000000b003fba92fad35sm11120257wmi.26.2023.07.23.14.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 14:04:48 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:04:47 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Rich Felker <dalias@libc.org>
Cc:     Szabolcs Nagy <nsz@port70.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/4] openrisc: Support floating point user api
Message-ID: <ZL2V77V8xCWTKVR+@antec>
References: <20230418165813.1900991-1-shorne@gmail.com>
 <20230418165813.1900991-4-shorne@gmail.com>
 <20230626213840.GA1236108@port70.net>
 <ZJsRHzDbuTlXKNCG@antec>
 <20230627175638.GD3630668@port70.net>
 <20230627192719.GR20050@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627192719.GR20050@brightrain.aerifal.cx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 03:27:19PM -0400, Rich Felker wrote:
> On Tue, Jun 27, 2023 at 07:56:38PM +0200, Szabolcs Nagy wrote:
> > * Stafford Horne <shorne@gmail.com> [2023-06-27 17:41:03 +0100]:
> > > On Mon, Jun 26, 2023 at 11:38:40PM +0200, Szabolcs Nagy wrote:
> > > > * Stafford Horne <shorne@gmail.com> [2023-04-18 17:58:12 +0100]:
> > > > > Add support for handling floating point exceptions and forwarding the
> > > > > SIGFPE signal to processes.  Also, add fpu state to sigcontext.
> > > > > 
> > > > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > > > ---
> > > > ...
> > > > > --- a/arch/openrisc/include/uapi/asm/sigcontext.h
> > > > > +++ b/arch/openrisc/include/uapi/asm/sigcontext.h
> > > > > @@ -28,6 +28,7 @@
> > > > >  
> > > > >  struct sigcontext {
> > > > >  	struct user_regs_struct regs;  /* needs to be first */
> > > > > +	struct __or1k_fpu_state fpu;
> > > > >  	unsigned long oldmask;
> > > > >  };
> > > > 
> > > > this seems to break userspace abi.
> > > > glibc and musl have or1k abi without this field.
> > > > 
> > > > either this is a new abi where binaries opt-in with some marking
> > > > and then the base sigcontext should be unmodified,
> > > > 
> > > > or the fp state needs to be added to the signal frame in a way that
> > > > does not break existing abi (e.g. end of the struct ?) and also
> > > > advertise the new thing via a hwcap, otherwise userspace cannot
> > > > make use of it.
> > > > 
> > > > unless i'm missing something.
> > > 
> > > I think you are right, I meant to look into this but it must have slipped
> > > though.  Is this something causing you issues or did you just notice it?
> > 
> > i noticed it while trying to update musl headers to linux 6.4 uapi.
> > 
> > > I didn't run into issues when running the glibc test suite, but I may have
> > > missed it.
> > 
> > i would only expect issues when accessing ucontext entries
> > after uc_mcontext.regs in a signal handler registered with
> > SA_SIGINFO.
> > 
> > in particular uc_sigmask is after uc_mcontext on or1k and e.g.
> > musl thread cancellation uses this entry to affect the mask on
> > signal return which will not work on a 6.4 kernel (not tested).
> > 
> > i don't think glibc has tests for the ucontext signal abi.
> > 
> > > Just moving this to the end of the sigcontext may be all that is needed.
> > 
> > that won't help since uc_sigmask comes after sigcontext in ucontext.
> > it has to go to the end of ucontext or outside of ucontext then.
> > 
> > one way to have fpu in sigcontext is
> > 
> > struct sigcontext {
> > 	struct user_regs_struct regs;
> > 	unsigned long oldmask;
> > 	char padding[sizeof(__userspace_sigset_t)];
> > 	struct __or1k_fpu_state fpu;
> > };
> > 
> > but the kernel still has to interpret the padding in a bwcompat
> > way. (and if libc wants to expose fpu in its ucontext then it
> > needs a flag day abi break as the ucontext size is abi.)
> > 
> > (part of the userspace uc_sigmask is unused because sigset_t is
> > larger than necessary so may be that can be reused but this is
> > a hack as that's libc owned.)
> > 
> > not sure how important this fpu field is, arm does not seem to
> > have fpu state in ucontext and armhf works.
> > 
> > there may be other ways, i'm adding Rich (musl maintainer) on cc
> > in case he has an opinion.
> 
> Indeed, mcontext_t cannot be modified because uc_sigmask follows it in
> ucontext_t. The only clean solution here is probably to store the
> additional data at offsets past
> 
> 	sizeof(struct sigcontext) + sizeof(sigset_t)
> 
> and not expose this at all in the uapi types. Some hwcap flag can
> inform userspace that this additional space is present and accessible
> if that's needed.
> 
> Optionally you could consider exposing this in the uapi headers'
> ucontext_t structure; whether it's an API breakage depends on whether
> userspace is relying on being able to allocate its own ucontext_t etc.
> This would leave the actual userspace headers (provided by libc) free
> to decide whether to modify their type or not according to an
> assessment of whether it's a breaking change to application linkage.
> 
> What's not workable though is the ABI break that shipped in 6.4. It's
> a serious violation of "don't break userspace" and makes existing
> application binaries just *not work* (cancellation breaks and possibly
> corrupts program state). This needs to be reverted.

Hi Szabolcs, Rich,

My fix for this has now made it into 6.4.5 stable release.  You should be able
to use this release to update musl.

The fix was to use some unused space in sigcontext, for the fpu state.

-Stafford
