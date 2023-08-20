Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D30781DED
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 15:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjHTNNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 09:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjHTNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 09:13:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFADD1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:09:02 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so42566241fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692536940; x=1693141740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LZ+oES1zsfNlKxhCEQJA4MvdY1kIWFy2dYtj4VC1s8=;
        b=Rpu5V/q5Rj3FAFJgbIFk6XfWl+O4qv73wk/unM9kUZT2aU8w/Uv4eukCWPYM3rl8UP
         TcgegFpXDpMG09ODb/lJ2z23RT6kLRv14N3yX9OO5GRM4ECOPDEn5uvWmAr5Cu2klai6
         041vg2eb7N9c3VjvmUWBFyRFpWnmzTBTOjaFjNuYExeD27jqs/bHTQ1P+09tJ2JC8pdD
         knPEor3GKvn7E8UT59RJV/9ucrEz5VbK9dt1v8OZXmzoTN7fTNNNTG5D7AWEN/89zr5m
         QEJFDxa96GcDjp8OixEZliiKAdA9vlDjmWXl6TMddYe1uvoVFtVr1lWJmKGVW5cnqyxm
         l2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692536940; x=1693141740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LZ+oES1zsfNlKxhCEQJA4MvdY1kIWFy2dYtj4VC1s8=;
        b=VSf6Qd+D++MRO7u85Eh9x+I67VIvAYk3i6e9i/yFVwNLW+prB+0hKbfSPi0DF32qbR
         28sp/gtLg+In0QI1Ewfqhg+De5+uz3PBFNNSSwUbd9DNuVvj34w1JzVhw73vaD7gqWsM
         Ijabt/9wV9vA9Rmhgaf5FVPiyXGucsX3UgSTKmVr48ROs54Jxe/8IPB+PhEyJamok+T/
         FuZk134iubf+wI0Mtw7AuJWaAmtmftq7XzPLaxe+8nU9dqapJheMvIPxp8dWudvcNWpL
         mI3/dUweTnkkmCl2kugBlCfAjKdqT6hoR6+OzhPDtcjA1lPS5f2Vtt/ssji/gAcgl8sr
         uBpw==
X-Gm-Message-State: AOJu0YwXVFjnyg3+YOssInmYs56W9+OPmyUTyBjeVavaeKUngeEGQHZj
        SvbPUBHYivrR4S1JLG04kRE=
X-Google-Smtp-Source: AGHT+IFTG+Uf/j3nxx0sFZqGDD5S8oGs3q8smizkUS/mb+as4m/zVf3PT2lLTMD/Y3+NVynnaGlSQw==
X-Received: by 2002:a19:5e49:0:b0:4fd:c844:6a43 with SMTP id z9-20020a195e49000000b004fdc8446a43mr2037685lfi.43.1692536940067;
        Sun, 20 Aug 2023 06:09:00 -0700 (PDT)
Received: from f (cst-prg-27-89.cust.vodafone.cz. [46.135.27.89])
        by smtp.gmail.com with ESMTPSA id v5-20020aa7dbc5000000b0052241b8fd0bsm4302636edt.29.2023.08.20.06.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 06:08:59 -0700 (PDT)
Date:   Sun, 20 Aug 2023 15:08:56 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove unintentional voluntary preemption in
 get_mmap_lock_carefully
Message-ID: <20230820130856.j2wbfe4z6iem4fis@f>
References: <20230820104303.2083444-1-mjguzik@gmail.com>
 <ZOH62Zi/yao/oC8y@casper.infradead.org>
 <CAGudoHG3OxoYKSwDmJYEDOj6LmDMsQDs3SD5nBdrzA5Vc1_H0A@mail.gmail.com>
 <CAHk-=wh=cECn7SLr31VXwtJq-wYnt5+VcERnvAmEVktdEKqR=w@mail.gmail.com>
 <CAHk-=wjW7W-eLpxz-Rnztx1J0Ay=kaXNFsPe=MZG9hQBXBPL3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjW7W-eLpxz-Rnztx1J0Ay=kaXNFsPe=MZG9hQBXBPL3Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 02:59:07PM +0200, Linus Torvalds wrote:
> On Sun, 20 Aug 2023 at 14:47, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But without that odd ifdef, I think it's fine.
> 
> Another option might be to just move the might_sleep() to the top, and
> do it unconditionally. If the trylock fails, the overhead of possibly
> doing a cond_resched() is kind of moot.
> 

I wanted to do it, but then I found this comment:

 * For example, if we have a kernel bug that causes a page
 * fault, we don't want to just use mmap_read_lock() to get
 * the mm lock, because that would deadlock if the bug were
 * to happen while we're holding the mm lock for writing.

I figured scheduling away while on the way to OOPS/similar is not the
best thing to happen.

> IOW, the main problem here is not that it causes a scheduling point
> (if the kernel isn't preemptable), it seems to be just that we
> unnecessarily schedule in a place with the mm lock is held, so it
> unnecessarily causes possible lock contention for writers.
> 
> With the per-vma locking catching most cases, does any of this even matter?
> 
> Mateusz - on that note: I'm wondering what made you see this as a
> problem. The case you quote doesn't actually seem to be threaded, so
> the vm lock contention shouldn't actually matter there.
> 
> Does it schedule away? Sure. But only if "needs_resched" is set, so it
> doesn't seem to be a *bad* thing per se.
> 
> It might just be that this particular scheduling point ends up being a
> common one on that load, and with those kernel config options (ie
> PREEMPT_VOLUNTARY)?
> 

I did not cause a slowdown for me and I did not say it did.

I am saying down_read + going off CPU, should it happen in a
multithreaded program, is going to delay any down_write issued by other
threads. And that going off CPU here was clearly not intended.

As I noted in another e-mail this is just a side thing I spotted while
looking at other stuff. I don't find it important enough to discuss it
any further, so as far as I am concerned you are most welcome to take
any of the 2 patches, write your own or or leave the code be.

[I am going to post other stuff later which *I am* going to argue to
push for ;>]
