Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD47787D46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbjHYBhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbjHYBgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:36:51 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843021707;
        Thu, 24 Aug 2023 18:36:48 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1ccc0d2e697so303457fac.0;
        Thu, 24 Aug 2023 18:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692927408; x=1693532208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAj+Xn3dc9xjoz8edHYO8SCdBYUNyj8RASPwvjsgC10=;
        b=OmpmEjU9trbSflUJPRuGHMuSuh1tPD3tbIRq5MMChBFDvE373Xxamjrn4vQUKW4eTH
         yoWIHirNW2WNimNbNTVJHAE6rkx3ARvFPvax6DbydFIpWxPPJxTyforO6nRaLkbz7Y2Z
         AImW6keo0vFb3KMiyxjNqqUB7sPSv7iWsla8+XiN31zGpO0Nk66+TOgA2CcgFrc39H20
         oHZQrOoWnjvgKdcbnfC0EJJ+A7+9oZajw78BmlqL6mz29Fvbvf4nWwcfx+LCoidZHpxi
         hKb2jI76c2SC1gG1SXtZ/0pjCYrNcBYA8SEDGOOkGgsrF3CmucRjz72mEChRRlWNdySS
         kSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692927408; x=1693532208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAj+Xn3dc9xjoz8edHYO8SCdBYUNyj8RASPwvjsgC10=;
        b=H7Qu8JPS8JzbA8EW5xqxwlz9UdA6w1B5ZNd5O7n0feQpyPyQp5zD7+ieOzQk8Rr9Ea
         gssmhqIUiN3hrfslgpMXSLununsRoZfF/uEE+wOtcZlArGANwzhNEFC4hsaF2UEgsRu7
         oxttcfXN+BfxYNtKT/Xduk4qCn5oVnE0YjQ1zpoNemAQFfwHW1RFS/FT/UBUKw3/CXL3
         eWnCBxWr02v/fhT7tWKgn8/BmTzKTCmM5TYKU1gjLNFcgu73qO0YESYQBj07r+/AhtS7
         s/B01lxnj7a/Au7weKbr615bjwXbdvPEuXVm3cc/9UYniFL2AhmNVW9WDsdazqQNNCUs
         xGhQ==
X-Gm-Message-State: AOJu0YwZDeFmM/wPHkZsUv7TDp3HVeJvJJmPAKpxoGO+gS8n2FBMfjcz
        AD9ut3CyvDhnN2U+8yr71yH750rQDuZwPtUWrhk=
X-Google-Smtp-Source: AGHT+IG2N4Mp0HQwEXLsDsLQP3n3x9jc0/pqCXzobqKl6JN27VdJ5hlN3aSWvLLGMVSoEkn4ka2b5IDoytSVDD3+JXA=
X-Received: by 2002:a05:6870:3322:b0:1a9:caa1:9571 with SMTP id
 x34-20020a056870332200b001a9caa19571mr1444334oae.34.1692927407719; Thu, 24
 Aug 2023 18:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230818031045.wovf5tj2un7nwf72@synopsys.com> <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com> <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com> <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <CA+fCnZcmb78DMaffb3cq2JeCNxcGBeyt8hxeJq3SaTTkbZ3ewA@mail.gmail.com>
 <3f52eb94-1d8c-4233-86ac-bbc78d4efce7@rowland.harvard.edu>
 <CA+fCnZcJ0JHHY04By+PjYvofpefKtp1br63gJNsEL=J7n1_vCA@mail.gmail.com>
 <bdf69b9d-fe82-48e2-9638-d84d00d4ef1d@rowland.harvard.edu> <20230823171757.vegbktpkk23eg34z@synopsys.com>
In-Reply-To: <20230823171757.vegbktpkk23eg34z@synopsys.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 25 Aug 2023 03:36:36 +0200
Message-ID: <CA+fCnZdewxqN6jaOmah4Ptz5CaJoc6iKisFBMLujBGOD_6HoiA@mail.gmail.com>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Felipe Balbi <balbi@kernel.org>,
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

On Wed, Aug 23, 2023 at 7:18=E2=80=AFPM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> > > First, I noticed that some of the UDC drivers only expect to handle a
> > > delayed Status stage for SET_CONFIGURATION requests. (Which is
>
> Just want to clarify that dwc3 would expect a delayed status for any
> request returned with USB_GADGET_DELAYED_STATUS. The issue is that dwc3
> assumes the _first_ delayed request would be SET_CONFIGURATION. Any
> subsequence control request with delayed request, it assumes the device
> is already in configured state.
>
> > That expectation is wrong; gadget drivers can also want to delay the
> > Status stage for a SET_INTERFACE request.  And in theory they might wan=
t
> > to delay any control-OUT transfer.
>
> Agree. Thanks Andrey and Alan for looking into dwc3.
>
> Regarding SET_INTERFACE, it should be fine because it should be done
> while it's already in configured state, which is after
> SET_CONFIGURATION. But it's true that dwc3 needs to fix this assumption
> here.

Ack.

Thank you Thinh and Alan for taking the time to look into this!

So to summarize the issue wrt the 0-length requests:

1. UDC drivers must always delay the status stage for 0-length
requests until the gadget driver queues an empty request.

2. Many UDC drivers do not do this, and only delay the status stage
when USB_GADGET_DELAYED_STATUS is returned from ->setup(). Some
drivers also assume that only a SET_CONFIGURATION request can be
delayed.

3. All such UDC drivers should be fixed and USB_GADGET_DELAYED_STATUS
should be contained within the composite framework.

4. Fixing all such UDC drivers is a non-trivial amount of work, but
this is the goal to strive towards.

Alan, would it be acceptable if I add custom handling of
USB_GADGET_DELAYED_STATUS to Raw Gadget in the meantime? It would be
great to keep it at least somewhat working with dwc3. I can also do it
for GadgetFS, if you think it's a good idea.

I can also add some clarifying comments for USB_GADGET_DELAYED_STATUS
and ->setup() to hopefully avoid having new UDC drivers being added
with the same issue (e.g. cdns2 and renesas_usbf with the same issue
were added just recently).

Maybe it's also a good idea to add a checkpatch.pl check for using
USB_GADGET_DELAYED_STATUS in UDC drivers. Or maybe ask Greg to keep an
eye out for this?
