Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9031B784EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjHWCaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjHWCah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:30:37 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7988FB;
        Tue, 22 Aug 2023 19:30:35 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ccb6a69b13so594587fac.2;
        Tue, 22 Aug 2023 19:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692757835; x=1693362635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WChwMxafgo9YmuP6ZoQj+qOv65Zjvm+fDVoi6MSyrY=;
        b=IN/JYu4m11ShjeahoGWaXSisuCarzDYTKyG6ytws8xONfHG0nTchv6SX7DHqvqJzTb
         Jg1rBzWojPB5uKUsXzlUEhSCpunN2f9DHQ3zIUY8s8UDwnyz7X5zVlwTny6gGNw5Rhd+
         jOUNH+qiR37S7DLNyiyNp9MxcOwXIca3KAz7BWs82RWnF1Ab+OblwRydSAPjDNo22Gb6
         2KOrCI+lyjcIOHjnnMWBreovmly4J1OD8H5A9dCIJG1PaIyBKLiGm7eFU1ZovZ+/uUdJ
         EkuL0fbHB1BWm8odVKhJMIOPBzlviqw+Jf8b74d7lp5qKvzHF0my1PD9iXRi9PG4gAzC
         59Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692757835; x=1693362635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WChwMxafgo9YmuP6ZoQj+qOv65Zjvm+fDVoi6MSyrY=;
        b=B+aGRTI2ZIxuiuBlxQ5xfiv7XupAS2ZCqOaCRkgkDWJ6hy/7nDSXZHXilCwrSxFCkJ
         OAv90839iZh+Lnj8OtAkxEV6sryW5GGZhqBpqxNejT+tZ3YcFISDp+HkqIJvEOanVwN5
         dXmD4/VFzwMKdh9F4gQF7BSBAvEMLuq8/sRG7dTLjRXV837d2eRinJ+dTPqERfEoFeuf
         5wEA6E12ZUdJAUHYCF2BMa9W3TqHmgU7Qecs9+s7qyD0Pkizpzqu9/TxFJ+yrZiPgQmT
         QZ12vxN8X+KBx80WtpgPfy9CvUTfWlUuhKokia9se7ctSLMekNLQJDXxOtuKkYkAmDAf
         m5Aw==
X-Gm-Message-State: AOJu0YwCGY04ZokWY7Eo69N3IMDIsDodJ+/HV20UPolEGbQjcqwoDcyw
        dqR0EVdnHPNfEgP7xla5kylXqzzCVzvlK4adJ0jCoefV
X-Google-Smtp-Source: AGHT+IF1jeZJwSqvuBO3HeNt/ev3hKVVWg/CpvsYUiJ+p2pJDJ4CR0DVrE7v7ueh8oUBA1p35RZN4lLoY2hje5UO9j0=
X-Received: by 2002:a05:6870:56a8:b0:1be:c586:31ae with SMTP id
 p40-20020a05687056a800b001bec58631aemr13276048oao.40.1692757835033; Tue, 22
 Aug 2023 19:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com> <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com> <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com> <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com> <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <CA+fCnZcmb78DMaffb3cq2JeCNxcGBeyt8hxeJq3SaTTkbZ3ewA@mail.gmail.com> <3f52eb94-1d8c-4233-86ac-bbc78d4efce7@rowland.harvard.edu>
In-Reply-To: <3f52eb94-1d8c-4233-86ac-bbc78d4efce7@rowland.harvard.edu>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 23 Aug 2023 04:30:23 +0200
Message-ID: <CA+fCnZcJ0JHHY04By+PjYvofpefKtp1br63gJNsEL=J7n1_vCA@mail.gmail.com>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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

On Mon, Aug 21, 2023 at 7:25=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> > I guess the proper solution would be to contain
> > USB_GADGET_DELAYED_STATUS within the composite framework and make all
> > UDCs not to handle the Status stage on their own. However, this would
> > require a collaborative effort from the maintainers of the UDC drivers
> > I mentioned.
>
> Most if not all of the UDC drivers you listed are actively maintained.
> It shouldn't be too hard to get people to remove the special treatment
> of USB_GADGET_DELAYED_STATUS in them.
>
> The necessary changes should be pretty small: Whenever wLength is 0,
> treat any non-negative return value from ->setup() as if it were
> USB_GADGET_DELAYED_STATUS.  This would probably end up shrinking the
> UDC driver code a little.  :-)

I started looking into reworking the UDC drivers to drop the special
case for USB_GADGET_DELAYED_STATUS, but this seems more complicated.

First, I noticed that some of the UDC drivers only expect to handle a
delayed Status stage for SET_CONFIGURATION requests. (Which is
reasonable, as they were developed assuming that only the composite
framework might request to delay the Status stage.) In particular,
dwc3, cdns2, and cdns3 set the gadget state to USB_STATE_CONFIGURED
when handling a delayed Status stage:

dwc3/ep0.c:136: usb_gadget_set_state(dwc->gadget, USB_STATE_CONFIGURED);
cdns3/cdns3-ep0.c:739: usb_gadget_set_state(&priv_dev->gadget,
USB_STATE_CONFIGURED);
gadget/udc/cdns2/cdns2-ep0.c:572: usb_gadget_set_state(&pdev->gadget,
USB_STATE_CONFIGURED);

So I believe an additional check for whether the request was indeed
SET_CONFIGURATION is required. (cdns2 and cdns3 also do other things
besides setting the state to USB_STATE_CONFIGURED, but it should be
possible to hide that under the same check.)

I also looked into how other UDC drivers change the gadget state to
USB_STATE_CONFIGURED:

1. isp1760, mtu3, and bdc immediately set USB_STATE_CONFIGURED once
they receive a SET_CONFIGURATION request, before calling ->setup() for
the gadget driver;
2. gr and mv_u3d do that after the ->setup() call;
3. tegra does it after the first non-control endpoint is enabled;
4. dwc3, cdns2, and cdns3 appear to not set USB_STATE_CONFIGURED if
the Status stage is not delayed;
5. dwc2, cdnsp, and all other UDCs don't set USB_STATE_CONFIGURED at all.

I'm guessing the UDCs in #4 and #5 expect the gadget driver to set
USB_STATE_CONFIGURED.

I see that the composite framework sets the gadget state to
USB_STATE_CONFIGURED even if some of the functions request a delayed
Status stage via USB_GADGET_DELAYED_STATUS. And GadgetFS also sets the
state to USB_STATE_CONFIGURED before delegating the SET_CONFIGURATION
request to userspace. However, Raw Gadget expects the userspace to
issue an ioctl that sets USB_STATE_CONFIGURED before completing the
delayed SET_CONFIGURATION request.

So I am wondering: when is proper time to set USB_STATE_CONFIGURED?
And should this be handled by the UDC driver or the gadget driver?

> > An alternative would to declare USB_GADGET_DELAYED_STATUS to be usable
> > outside of the composite framework and leave everything as is
> > otherwise (but change Raw Gadget to return USB_GADGET_DELAYED_STATUS).
> > The downside is the discrepancy in the interface of different UDCs
> > (some require USB_GADGET_DELAYED_STATUS, others imply), but perhaps
> > it's not that bad provided that this discrepancy is documented.
>
> This alternative is less desirable, because the legacy gadgets (some of
> which don't use the composite framework) may not be compatible with it.

I think GadgetFS and Raw Gadget are the only two such drivers?

> And as a matter of general principle, allowing UDC drivers to start
> automatically send Status replies to 0-length control transfers is a
> step in the wrong direction.  What we really should focus our energy on
> is getting them to _stop_ sending automatic Status replies to
> non-zero-length control transfers!

Ack!

But I don't think it's within my capability to fix all UDCs,
considering the issues I mentioned above.
