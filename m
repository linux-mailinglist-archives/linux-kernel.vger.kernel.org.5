Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD29A782DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjHUQNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjHUQNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:13:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C476FF;
        Mon, 21 Aug 2023 09:13:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5656a5c6721so1922223a12.1;
        Mon, 21 Aug 2023 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692634396; x=1693239196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9mifx+UGkE0S0xzchpKkc4eAFsqEElU8pnoSlp1HjE=;
        b=Kr++x1Q5c+VVlqGOpGdREoAyY7Rz9EybuoNnZx0rRQAdamseTB7czC/SOr6X6+M8e0
         JsDvdGJhdyjR/pyqxgBOnJjTYR3t85l2Ju5ZNRXnDL0lIbc4ileDzbzlCv0Ya/fBVRy+
         RMkCVaGoN3yUca48BHRQBERHuKtzQv/Wfmnr23V9mqD6eAWI07vsZ6K78AVR1/gHrN2c
         NTCUQuds13x16QfgopvUBQTphbK6Rijwf28gATgawwazFNmgfs98rD+uH79i7IwbdfM2
         n/VcwIYHwJF+rR/YaMnPtzdBmDbyg93kO9X8pxT93b6U9GWj8BI6txmUiU8HvhnrVfxp
         8m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692634396; x=1693239196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9mifx+UGkE0S0xzchpKkc4eAFsqEElU8pnoSlp1HjE=;
        b=L63OtBmRrWHGB+6Y2H+Iladprr1yQcISFug27dGEXuF6HxhdNGtG3psslVBErF79N0
         azR4CyFmi5+hkK1dt6lNoZWS8VuhbxoXOZvqy1i6wHoetZokJcvrUJAO8u7rdggQNEak
         /hhgKh7UZ82Suk3BCEZR6R+LBv9kVi44tbhudDpBX8bVc/QHRlF6v1E5RoAVbzka4k9F
         F89R8CsPe3dxAn67/sLOOwGNrkRNCI5k9yIQbx8YMHomgkCBLkcdjtqnrr6I3Mwh7aRM
         4OggnpNHKb6x/OWQ7NubMoDFKGXtgdjcm/qhm+ckzW98ZhAc6V8eB2vFE+7Hf7iDkeLE
         BARg==
X-Gm-Message-State: AOJu0Yx9DqEgL/To86llTcf7Lmg7NDQNo+OlzxKzxuesrXR867slTSUQ
        RgOCAgiQK0hCwiO1QEzDfBeyexB323+ak00sHZs=
X-Google-Smtp-Source: AGHT+IF15BDPIoOFdDsEOMQDbVtZnwck13z+KDafRvH5+e66BhdxZ9xKieeRJmgfCqlRj38YAo4LvbHq48d9PGqmxeM=
X-Received: by 2002:a17:90b:e07:b0:269:2682:11fb with SMTP id
 ge7-20020a17090b0e0700b00269268211fbmr4259608pjb.8.1692634396071; Mon, 21 Aug
 2023 09:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com> <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com> <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com> <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com> <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
In-Reply-To: <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 21 Aug 2023 18:13:05 +0200
Message-ID: <CA+fCnZcmb78DMaffb3cq2JeCNxcGBeyt8hxeJq3SaTTkbZ3ewA@mail.gmail.com>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
To:     Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

On Sun, Aug 20, 2023 at 4:20=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> > > > > This may be a holdover from the early days of the Gadget subsyste=
m.  My
> > > > > memory from back then isn't very good; I vaguely recall that the =
first
> > > > > UDC drivers would queue their automatic Status-stage requests if =
wLength
> > > > > was 0 and ->setup() returned 0 (which would explain why
> > > > > USB_GADGET_DELAYED_STATUS had to be invented).  Unless I'm comple=
tely
> > > > > confused, that's not how UDC drivers are supposed to act now.
> > >
> > > I did a little checking.  The USB_GADGET_DELAYED_STATUS mechanism was
> > > introduced for use by the composite framework -- not in order to make=
 a
> > > UDC driver work properly.
> >
> > Hm... perhaps we can update so that it's applicable outside of the
> > composite framework. Currently dwc3 treats it as such, which may not
> > work if the gadget driver does not know about USB_GADGET_DELAYED_STATUS=
.
>
> I think USB_GADGET_DELAYED_STATUS belongs entirely inside the composite
> framework and it should not be used by UDC drivers at all.
>
> That return code makes some sense in composite.c, because the composite
> framework juggles several function drivers in a single gadget.  It has
> to know when all of them are ready to complete a configuration change;
> it can't assume each function is ready when the callback returns.

Out of curiosity, I also did some digging around USB_GADGET_DELAYED_STATUS.

1. USB_GADGET_DELAYED_STATUS was introduced in 1b9ba000177 ("usb:
gadget: composite: Allow function drivers to pause control
transfers"). It looks like it was indeed initially intended for the
composite framework, as nor that commit nor the directly following
commits use USB_GADGET_DELAYED_STATUS in any UDC drivers. However,
this commit had an unintended (?) side-effect of returning
USB_GADGET_DELAYED_STATUS from the ->setup() call of the composite
framework gadget driver.

2. In 5bdb1dcc6330 ("usb: dwc3: ep0: handle delayed_status again"),
the dwc3 driver was the first one to start relying on
USB_GADGET_DELAYED_STATUS to decide when to avoid auto-completing the
Status stage (+Sebastian). The commit description mentions some
previous rework of the driver that made it lose the ability of handle
delayed Status stage handling, but I couldn't figure out the exact
commit it refers to.

3. Following that, a few other UDC drivers also started using
USB_GADGET_DELAYED_STATUS, potentially using the dwc3 behavior as a
reference.

Interestingly, in 946ef68ad4e4 ("usb: gadget: ffs: Let setup() return
USB_GADGET_DELAYED_STATUS"), the FunctionFS composite driver had to
add USB_GADGET_DELAYED_STATUS to specifically avoid failures when dwc3
is used. This is the same "fix" that worked for me with Raw Gadget.

Right now dwc2, dwc3, mtu3, cdns3, bdc, and renesas have special
handling for USB_GADGET_DELAYED_STATUS. Surprisingly, dwc2 works with
Raw Gadget as is nevertheless. dwc3 fails as I described. For the
others, I don't have the hardware to test them.

I guess the proper solution would be to contain
USB_GADGET_DELAYED_STATUS within the composite framework and make all
UDCs not to handle the Status stage on their own. However, this would
require a collaborative effort from the maintainers of the UDC drivers
I mentioned.

An alternative would to declare USB_GADGET_DELAYED_STATUS to be usable
outside of the composite framework and leave everything as is
otherwise (but change Raw Gadget to return USB_GADGET_DELAYED_STATUS).
The downside is the discrepancy in the interface of different UDCs
(some require USB_GADGET_DELAYED_STATUS, others imply), but perhaps
it's not that bad provided that this discrepancy is documented.

Thank you!
