Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1347670FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjG1PuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjG1PuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:50:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD1935AF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:50:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5222bc91838so3048545a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1690559401; x=1691164201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJBRs+Bnwl2OMoy/OyNAhtrD/F8OCxBPBCF/VhngpSg=;
        b=CnZu+SXs9oSz7zlr59C7aTZSXCNsMMjPndBSf214vpYOdp7ePykWCJYBddaJzvIL1l
         al4spNG8jC2xywNsivi6wP3lZClH1zbKQL1JN6NoYKntN7vn/AnYiFjcxPYVomCiarHp
         yO1aDIqMPJrvUT1amatglNAA5uOpxHeO27JdLMp5dE5Y1DltCMPGaiRuiAEW7j/jsD//
         aFsHgyu8aGAhf0+IJG8epIWcB4bRmKkLLnGJdtzKA6CRU7R/cUIqHVDnAob8XkC9Vp1g
         waIHx4L4fCwGg2O62zOTqLZvv8Prr4zRTzVPjKT5KWZ8kmLo0UeVcpQLxP5epvnLbXhs
         WvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559401; x=1691164201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJBRs+Bnwl2OMoy/OyNAhtrD/F8OCxBPBCF/VhngpSg=;
        b=Ic7lJaDBwr8WaPEuE2p0RYfdv5O3LAOhiDFjcllxcFC4lzTEhnmOg+C+Y7HVmoX0e8
         9h/7USIDGUHzZ9+/cU8xltHNES6XYvqUr0ytBYLb59O34BnOjJo/LVKgG+wAq3qsgim9
         MXUIUmrWVHR9FgvgJke9q3imSMow7Zb8bZJldx+aIx0KsSlU3p8uSqrcTwlxhaWzhtAZ
         25TRzJoYeOJPpky9TAVyPP/cVybC80QfKuUDH7NcfIsBnxhGSbmcymUh+lEku3mzzf8z
         S+KLhEiTEHiItuzbRkdQK19EnbvZjos4IYh1ZbbIIGn9Qq14McI4Cvt3YDggv5ee1k8C
         SC1g==
X-Gm-Message-State: ABy/qLZiXONp0MvA5nESuUwEdekccD7XUnoAWU5PQ3PY8YkudvqzMw19
        t1kdCL0sq0cTx9NoBzgbmYKl24vq2i4rq8AezJ18
X-Google-Smtp-Source: APBJJlEo1nZ4GFR3RxnGEsWJX1CRKPDiKaYoZ5TV+ZYucpP4c+Bcc1TmLeSdUeg9DCKYStWeMFzQGL7oar0y1aGzP5s=
X-Received: by 2002:aa7:d85a:0:b0:515:1e50:5498 with SMTP id
 f26-20020aa7d85a000000b005151e505498mr1975917eds.15.1690559401271; Fri, 28
 Jul 2023 08:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230727131326.2282301-1-lb@semihalf.com> <2023072705-palpitate-cut-874b@gregkh>
 <CAK8ByeJYtFcMbEabSDJwXhE3jYY2xQG+JHR0gpwh6_=yg+AXjw@mail.gmail.com> <2023072825-alfalfa-skincare-23b2@gregkh>
In-Reply-To: <2023072825-alfalfa-skincare-23b2@gregkh>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Fri, 28 Jul 2023 17:49:49 +0200
Message-ID: <CAK8ByeK-pue7o2r5kKgxR=si9BT3E_SSEXkmka84JVW0_L3aFg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] thunderbolt: add tracefs support to tb_* logging helpers
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 28 lip 2023 o 17:32 Greg KH <gregkh@linuxfoundation.org> napisa=C5=82(=
a):
>
> On Fri, Jul 28, 2023 at 04:50:12PM +0200, =C5=81ukasz Bartosik wrote:
> > czw., 27 lip 2023 o 16:47 Greg KH <gregkh@linuxfoundation.org> napisa=
=C5=82(a):
> > >
> > > On Thu, Jul 27, 2023 at 03:13:25PM +0200, =C5=81ukasz Bartosik wrote:
> > > > Thunderbolt tracing is a lightweight alternative to traditional
> > > > thunderbolt debug logging. While thunderbolt debug logging is quite
> > > > convenient when reproducing a specific issue, it doesn't help when
> > > > something goes wrong unexpectedly. There are a couple of reasons wh=
y
> > > > one does not want to enable thunderbolt debug logging at all times:
> > > >
> > > > 1. We don't want to overwhelm kernel log with thunderbolt spam, oth=
ers
> > > >    want to use it too
> > >
> > > But doesn't the dynamic debug infrastructure allow this today?
> > >
> >
> > Dynamic debug allows only partially what we would like to achieve.
> >
> > Our goal is to be able to gather thunderbolt debug logs from ChromeOS
> > end users when an issue happens. Especially that would be very useful
> > for us in case of issues which reproduction is difficult. We would
> > write thunderbolt debug logs to a separate wrap around buffer provided
> > by trace subsystem. When an issue happens and a user sends a feedback
> > then thunderbolt logs would be attached to the feedback providing
> > more insight into what happened.
>
> The problem is, you don't want 100 different debug log formats and tools
> for the 100 different driver subsystems.
>
> That is why we unified everything on the dev_* format, and the tracing
> tools.  Use them, don't create something new.
>
> > Dynamic debug sends all debug messages to dmesg and with significant
> > number of dynamic dev_dbg prints enabled dmesg may be quickly overwritt=
en
> > and other important logs lost. Also enabling dynamic debug for the
> > entire kernel might
> > not be appropriate for production kernels due to impact on kernel size =
and perf.
>
> If you look at the typec code, they have their own type of ring-buffer
> for logging things.  Perhaps look at making that more generic like what
> you need here as well, and adding that to the tracing core for everyone
> to use and unify with?
>

Thanks for the comments and pointing me to the typec code for the reference=
.

Lukasz

> I don't want one-off solutions like this, sorry, that way lies madness,
> madness that we used to have before we unified everything.  Let's learn
> from our past mistakes and not make them again please.
>
> thanks,
>
> greg k-h
