Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF33781219
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379125AbjHRRhj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Aug 2023 13:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379131AbjHRRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:37:13 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103EF4223;
        Fri, 18 Aug 2023 10:37:03 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5862a6ae535so12178047b3.0;
        Fri, 18 Aug 2023 10:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380222; x=1692985022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5oH2jYhBX6xr0+lSvBfeZSga3rbN0f7TFFwU/2+2ic=;
        b=XJSzZeDynVL0GDF2BUZsPchE6vccFJBWp9X22MnZ2E1no8CDg2vjTAUdqsnNSN6GuV
         FS4S18joj7fk4EhTIdu1pwF8VXBfR6cQnGmRrmx4+X8+wmIo1ZBy4oWxkLAeB+h0qoU0
         vh0FZOSz+fD0d9hEytygNYtUmB4WEh83eVvEXjINzKmT8TCA5izH2rVuuDugrGhJGoRs
         fNw2WMtp1KJz7KpT+TEF1W+y7OkJzJakKJjfMl8/6xzMP6FcReuHSgQT1tU4W5BFigdd
         g0k/c3y4mOlAAbm8ayP6eStzJQMqQmMryHwrnZv8fdswLfH9MafirHCJSrZ6YlsmJZak
         0DfA==
X-Gm-Message-State: AOJu0YyWqeMHDFuN2v/9P2ex8sv+wsTpGT/6Bx45vO/wI/4XqeyjGzPI
        sHWLAh1uZ74JswFxk226oblCV0xCubxzHw==
X-Google-Smtp-Source: AGHT+IGU0udC3UBus1+nBfmgs36YgAxNRnE24/AUlnzKokvGPRWHywav12Y4dplxvjaCsnffEW8ydw==
X-Received: by 2002:a81:69d5:0:b0:586:9c8b:4bb4 with SMTP id e204-20020a8169d5000000b005869c8b4bb4mr2814178ywc.29.1692380221973;
        Fri, 18 Aug 2023 10:37:01 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id d15-20020a814f0f000000b00584554be59dsm619011ywb.85.2023.08.18.10.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 10:37:01 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d72cf9156easo1103599276.0;
        Fri, 18 Aug 2023 10:37:01 -0700 (PDT)
X-Received: by 2002:a25:489:0:b0:d07:d88b:4843 with SMTP id
 131-20020a250489000000b00d07d88b4843mr3622130ybe.20.1692380221415; Fri, 18
 Aug 2023 10:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
 <20230801-dt-changeset-fixes-v2-2-c2b701579dee@kernel.org>
 <CAMuHMdX4gqPLv5ZWiWe-B+bQtHSfF9AxZTKWisFZEKa29Ge2KQ@mail.gmail.com> <CAL_Jsq+2nz9MCLffKEHxygUbMNisNAFh_i-8BaZjXy_eDHEi0g@mail.gmail.com>
In-Reply-To: <CAL_Jsq+2nz9MCLffKEHxygUbMNisNAFh_i-8BaZjXy_eDHEi0g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 19:36:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVN+A6XDHAThz-7gNWvdeFgSfPFW0EYSEJQ12CmRKVaHg@mail.gmail.com>
Message-ID: <CAMuHMdVN+A6XDHAThz-7gNWvdeFgSfPFW0EYSEJQ12CmRKVaHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] of: dynamic: Refactor action prints to not use
 "%pOF" inside devtree_lock
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Aug 18, 2023 at 6:17 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Aug 18, 2023 at 10:36 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Sat, Aug 5, 2023 at 12:42 AM Rob Herring <robh@kernel.org> wrote:
> > > While originally it was fine to format strings using "%pOF" while
> > > holding devtree_lock, this now causes a deadlock.  Lockdep reports:
> > >
> > >     of_get_parent from of_fwnode_get_parent+0x18/0x24
> > >     ^^^^^^^^^^^^^
> > >     of_fwnode_get_parent from fwnode_count_parents+0xc/0x28
> > >     fwnode_count_parents from fwnode_full_name_string+0x18/0xac
> > >     fwnode_full_name_string from device_node_string+0x1a0/0x404
> > >     device_node_string from pointer+0x3c0/0x534
> > >     pointer from vsnprintf+0x248/0x36c
> > >     vsnprintf from vprintk_store+0x130/0x3b4
> > >
> > > Fix this by moving the printing in __of_changeset_entry_apply() outside
> > > the lock. As the only difference in the the multiple prints is the
> > > action name, use the existing "action_names" to refactor the prints into
> > > a single print.
> > >
> > > Fixes: a92eb7621b9fb2c2 ("lib/vsprintf: Make use of fwnode API to obtain node names and separators")
> > > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v5 (v2 in this series):
> > >  - Move majority of refactoring to separate patch and minimize the fix
> > >    to just moving the print out of the locked section.
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/of/dynamic.c
> > > +++ b/drivers/of/dynamic.c
> >
> > > @@ -648,20 +634,17 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
> > >                 }
> > >
> > >                 ret = __of_update_property(ce->np, ce->prop, &old_prop);
> > > -               if (ret) {
> > > -                       pr_err("changeset: update_property failed @%pOF/%s\n",
> > > -                               ce->np,
> > > -                               ce->prop->name);
> > > -                       break;
> > > -               }
> > >                 break;
> > >         default:
> > >                 ret = -EINVAL;
> > >         }
> > >         raw_spin_unlock_irqrestore(&devtree_lock, flags);
> > >
> > > -       if (ret)
> > > +       if (ret) {
> > > +               pr_err("changeset: apply failed: cset<%p> %-15s %pOF:%s\n",
> >
> > Printing the cset pointer will (needlessly?) complicate the EXPECT_*()
> > handling in the unit test.
>
> That's added largely because the other prints which I rework later in
> this series had them. Either printing the changeset ptr is useful or
> it isn't. I think people running the unittest and the post-processor
> can easily enough filter this out when looking at the results.
> Honestly, even I probably run it less than once a cycle.

Do you have a use for printing the pointer value?
And by default, it will be an obfuscated cookie anyway.

> > > +                      ce, action_names[ce->action], ce->np, ce->prop->name);
> >
> > This should check ce->action to avoid an out-of-bounds access beyond
> > the end of action_names[].
>
> Indeed.
>
> I think I'll add "invalid" to action_names names and then do something
> like: "(ce->action < FOO) ? ce->action : 0".

OK, zero is invalid.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
