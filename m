Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73B27BBAD9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjJFOv0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 10:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjJFOvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:51:23 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13FA6;
        Fri,  6 Oct 2023 07:51:21 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a1d0fee86aso26471947b3.2;
        Fri, 06 Oct 2023 07:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696603880; x=1697208680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH1WSSdRdMGN/blmpsRHcGzazR8XoV0oXL3Y8AOIRuQ=;
        b=EmSCQWVWx5opcu9lhccyjt2i+UuXRKZ8XikPBmn7a1drujqFNLrjeKQ4AhtBmijWno
         aE0XmqdeSkOiqgRlPVB1iHxj375ZFnNHHRwlW/uw79B0sL56qQ0qwjjgEvz0NZdSZqDa
         N4fF4njzdCvgpvlIfmmVhbfI3yz2IMeZ8SXYtlc/fyBUO5L+fBYNjb0GqEEnxc/5Jrsg
         e0v6ZIr0EZRoaqi0rgSG4+gwErJRcOFHpR4gLityQOXoD7ufGo1RhnPaWqdSkY8ZQqC2
         miuZJ43Gw7nDAJu6lGGBsxbrn9YSBNkHF/+Cg3q7XsLRnWr0/q3IDl5viZyH8VghmHse
         7LkA==
X-Gm-Message-State: AOJu0Yxhg0fg9iuCZAJ4Zis2IW8s0zLNp5W3Nlkea4maXgL5o4sT5NqY
        2jGnXMyPi+YdUbf1BFzLnVcePibTgI/T7Q==
X-Google-Smtp-Source: AGHT+IFEdid6NvPaXtU1E9irJUJ6xGIbx+Lbxk6EPoOAssw561MiTIYyMo+82/38MFl99lKng8CvRw==
X-Received: by 2002:a81:4e12:0:b0:5a1:d8df:c457 with SMTP id c18-20020a814e12000000b005a1d8dfc457mr8602044ywb.12.1696603880526;
        Fri, 06 Oct 2023 07:51:20 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id k132-20020a816f8a000000b00598d67585d7sm1331399ywc.117.2023.10.06.07.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 07:51:19 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59f7f2b1036so26433907b3.3;
        Fri, 06 Oct 2023 07:51:19 -0700 (PDT)
X-Received: by 2002:a0d:e841:0:b0:589:f491:de9c with SMTP id
 r62-20020a0de841000000b00589f491de9cmr8896800ywe.28.1696603879221; Fri, 06
 Oct 2023 07:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
In-Reply-To: <ZQmbhoQIINs8rLHp@casper.infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Oct 2023 16:51:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV4qx3iQzqksfnvckk_PK9Zas0U=p-xv3pVwJ6hWLpejA@mail.gmail.com>
Message-ID: <CAMuHMdV4qx3iQzqksfnvckk_PK9Zas0U=p-xv3pVwJ6hWLpejA@mail.gmail.com>
Subject: Re: Arches that don't support PREEMPT
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
        linux-m68k@lists.linux-m68k.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Tue, Sep 19, 2023 at 3:01 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Sep 19, 2023 at 02:30:59PM +0200, Thomas Gleixner wrote:
> > Though it just occured to me that there are dragons lurking:
> >
> > arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
> > arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
> > arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
> > arch/um/Kconfig:        select ARCH_NO_PREEMPT
>
> Sounds like three-and-a-half architectures which could be queued up for
> removal right behind ia64 ...
>
> I suspect none of these architecture maintainers have any idea there's a
> problem.  Look at commit 87a4c375995e and the discussion in
> https://lore.kernel.org/lkml/20180724175646.3621-1-hch@lst.de/
>
> Let's cc those maintainers so they can remove this and fix whatever
> breaks.

Looks like your scare tactics are working ;-)
[PATCH/RFC] m68k: Add full preempt support
https://lore.kernel.org/all/7858a184cda66e0991fd295c711dfed7e4d1248c.1696603287.git.geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
