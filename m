Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E47781687
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 03:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbjHSBz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 21:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243362AbjHSBzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 21:55:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378A3C3E;
        Fri, 18 Aug 2023 18:54:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26d5c71199fso532232a91.0;
        Fri, 18 Aug 2023 18:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692410099; x=1693014899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqslO+gser46xdHp/ifs54tatb1N4ZLb8FXaTo2s/kk=;
        b=JgGd1q65RYGodI6T8e4Gf8MOegn83scktIMaU8SOKL2RONacoF/A5RaOX1T7Uxd0fQ
         hkiunMrB1uEGFB09oZx8r3YrWuMLI2K0cT4ZthpjFx9WVaYpiS0o+iCCDScksqHey8RW
         MntL/7ol+lL2gtdJjn+j23cWw78SydFLy9xYL9CLyVeKwe99DMEvKqgLOwjZYx3XfkbY
         ClZ8AUaa2A2EAnK4LQ74QiVHFZJgHdNxYCUt9RvjdQ8wxzQz3CX2JrVEnFlRbcOWWozP
         UNO4oWjxjx8gHyYvMoMFDsHnpzcZg3WzRoHd9j7uaU7UOFScm/Q7FQ5K4NImptg8C0iQ
         xcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692410099; x=1693014899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqslO+gser46xdHp/ifs54tatb1N4ZLb8FXaTo2s/kk=;
        b=W8heJF9V6MsuYdiy+lfSMJav73mGdJLYJUENtRk7/HTJFqeIa5xCZRUlOSH532D02D
         9L5ntPkXutxydpXqygVhhKmEoFYYgFe3CN47wVSfOrOUpjpyKpPtyAh2qtFSY5AF4hTD
         2RSd4cl01h9dnXiIbsodGXLOom8692PBeB8/w2Mk3cvtjByvErdzY2Zy2W4lPnmyVie/
         EREXJ2rBxtw2lEuIAIhGaAHYdjO/hDCy0hD2vMhE7FN3CtTbpEjH2t3Y+KwHO9LxQDjW
         ueAFS4h/RWmBsimCbJ7xEYD7LP56CG3m1Zskt0PuTWyNdcxkLf/8mpxENQKM+0ohYDoN
         nNtA==
X-Gm-Message-State: AOJu0Yyv1HMV1py0l42cC6SUJ7mp5X2lW2VoyGQIv7Tft/37RL6rFEUw
        HOjbwx/ElnZclYqcS+EnPbLfacI/DQatjgVkCgQ=
X-Google-Smtp-Source: AGHT+IFstb6/5EtwO2rzfa9ADWWSfCtJkPWYna9nIQ+OPu4ttFplDwRjnHNBjypj+AzwTGt3jMDD3R9gY22OkZZ5MSI=
X-Received: by 2002:a17:90b:3707:b0:263:c0f9:451c with SMTP id
 mg7-20020a17090b370700b00263c0f9451cmr648175pjb.3.1692410099093; Fri, 18 Aug
 2023 18:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com> <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com> <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com> <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
In-Reply-To: <20230819000643.7mddkitzr4aqjsms@synopsys.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 19 Aug 2023 03:54:48 +0200
Message-ID: <CA+fCnZfekbQ2upu085g6RPO+_bRKHcnxqfh8Cvsbt8XXz-DEwA@mail.gmail.com>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I will skip the discussion about the racy or aborted SETUP requests
and the potential design flaws in the UDC subsystem: this is not
what's happening in my case. ]

On Sat, Aug 19, 2023 at 2:07=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
> > > > One question is why Andrey is observing a new ->setup() callback
> > > > happening so soon?  The host is supposed to allow a fairly long tim=
e for
> > > > standard control requests to complete.  If the userspace component =
of
> > > > the Raw Gadget takes too long to act, the transfer could time out a=
nd be
> > > > cancelled on the host.  But "too long" means several seconds -- is =
that
> > > > really what's going on here?

No, this is not what's happening. All the requests get processed
relatively quickly, there are no big delays.

> > > As I noted initially, it should not happen so I'm not sure what's rea=
lly
> > > the problem here. Granted that the setup_pending check for data phase=
 is
> > > missing in dwc3 driver, there should not be a problem unless the host
> > > actually aborted a control transfer. Also, there should be no data ph=
ase
> > > for wlength=3D0 even for IN direction if we go through the composite
> > > layer. So, I doubt that's what happening here.
> > >
> > > Perhaps Andrey can clarify.
> >
> > My impression from his initial email was that something different was
> > happening.  It sounded like his ->setup() callback was invoked with
> > wLength =3D 0, but before the Raw Gadget driver was ready to queue a
> > response request, the UDC driver sent an automatic status, at which
> > point the host sent another SETUP packet.  So the gadget driver got two
> > ->setup() callbacks in a row with no chance to do anything in between.

Precisely!

> What else should the gadget driver do? There's no data stage for
> wLength=3D0.

Quoting one of the Alan's responses:

> But if the SETUP packet's wLength value is 0 then when the gadget driver
> is ready, it queues a 0-length IN request which will act as the Status
> stage.  In this situation the UDC does not automatically create a
> Status-stage request.
>
> Note that the gadget driver is allowed to queue its various requests
> either while the ->setup() callback is running or after it has returned.

So there's no Data stage indeed, but the problem is that dwc3 proceeds
with the Status stage by itself without waiting for an (empty) request
to be queued by the gadget driver.

> > > For dwc3, it's been like this since the beginning that it automatical=
ly
> > > queues the status upon host request. USB_GADGET_DELAYED_STATUS was
> > > introduced to support scenarios where the device may need a longer ti=
me
> > > to process the specific request (such as SET_CONFIGURATION).
> >
> > It's hard to be sure, but that may be the cause of Andrey's problem.

Yes, I believe this is exactly the problem.

> > He
> > mentioned something about the Raw Gadget's ->setup() routine returning
> > USB_GADGET_DELAYED_STATUS when the problem occurred, but I think he
> > meant that it did this for the second callback, not the first one.

Right!

I just tried changing Raw Gadget to return USB_GADGET_DELAYED_STATUS
from ->setup() whenever wLength =3D=3D 0, and the enumeration now works
properly. However, I don't think this hack is the proper solution. I
think dwc3 should just do what other UDC drivers do and do not
autocomplete the Status stage for wLength =3D=3D 0 requests.

> > Still, I recommand that dwc3 not automatically queue a Status request
> > when wLength is 0.

Yes, I believe this should fix the problem that I'm having.

> > Gadget drivers don't expect UDC drivers to handle
> > this for them.  For example, look at the composite_setup() function in
> > composite.c.  It does this:
> >
> >       /* respond with data transfer before status phase? */
> >       if (value >=3D 0 && value !=3D USB_GADGET_DELAYED_STATUS) {
> >               req->length =3D value;
> >               req->context =3D cdev;
> >               req->zero =3D value < w_length;
> >               value =3D composite_ep0_queue(cdev, req, GFP_ATOMIC);
> >
> > Clearly it doesn't want the UDC driver to queue a request for it, no
> > matter what wLength or value is set to.
> >
>
> dwc3 parse the SETUP data and determine whether it's a 3-state or
> 2-stage control transfer. If wLength > 0, then it must be a 3-stage
> control transfer. The dwc3 driver would not queue the status immediately
> until the data stage is completed.
>
> To enforce the gadget driver to manually queue the status would take
> some effort to ensure all the UDC driver comply to it.

I think most (or all except dwc3?) UDC drivers already comply with
this behavior. At the very least, Dummy UDC, dwc2, musb, chipidea, and
net2280 drivers work with Raw Gadget, so they must be complying. dwc3
is the first UDC I tested that caused a problem.

> We would also need to update the composite framework.

I would expect that the composite framework already takes this
behavior into account. I suspect that it's the dwc3 that just happens
to work with the composite framework, as the composite framework
quickly queues an empty response to a wLength =3D=3D 0 request (which gets
apparently ignored by dwc3) before the next ->setup() calls happens.

Thank you!
