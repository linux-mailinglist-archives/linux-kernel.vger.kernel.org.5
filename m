Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F696766FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbjG1Oua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbjG1Ou2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:50:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E42D5E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:50:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe0bb9500aso3785382e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1690555824; x=1691160624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0/Zz0K7yOTQgY23M7Y3UkTj7T3LRo0eppYGxgXzcnk=;
        b=M05v02b4dnmqB+FuH88rSkQy5xn7f+D99fe8i9xh3POgzAV5xBS63MZkWMbR86aQQY
         O4mA7paJFzXNm5KEhzb43Sza0hOmpE3+cYiYAT6/Hu8GhG/aMHFqaKlX/kYUQLV2vMiV
         +RbJs3guf7WHponUAHCRCu+gG4XSw4EPLdW/AahoZ1ZLLe/p4wY2HOKT+o+Fa7qGeqA1
         TQ/Vr+lxFcedspQYp4mo3o7Y1ggtay++TE9u5cExd/fb+JLORznKv1zEDX1XpLRuOGnh
         ULtRkgtot0MTis509tbh70ZFE+kO1BynbZ0Ax7kF+nucwDT/B2AzJpu9joh/cu1snkbq
         GJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690555824; x=1691160624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0/Zz0K7yOTQgY23M7Y3UkTj7T3LRo0eppYGxgXzcnk=;
        b=ka/+8aHeDNFKmnw+JCbWk1T8tB5cpwujnKNp3Qv//HhoIUl+56ivmN7HCJaywhFHeg
         45jfBtiiirjpufV7UltVCdf80YywLZwUQzbhHyrjwm39d3385NpGpeVRVIpTEGnAk9bE
         1Vgnqcca+43ZfIh61n1mi+0KQ0lD1oS/iaz3esamAeBtohTmrhohxjzzGsCTmAd3AWJR
         jHo4NKMY145FYzULCiBxo567uocxz0aeIjxADhsNoGCUJwn4ckDUwV7rYw2+Kkrt22EH
         IOEyQXPQEUIWEeV4mQZeKZQb3Pp6XjIOR2mJVkoNr+YYLYO74jJowuAaI+dUDYs7We0h
         aX2g==
X-Gm-Message-State: ABy/qLYo+EfvvTqz2ZgaJLaU+vunt2Km873t6M1KHfi+rWi+eirSJadK
        FEXrqvfp4j0P9gJc9yllznm5f+2Xxyx3o+6STqU7Y/ML81xPsrVZiA==
X-Google-Smtp-Source: APBJJlHL9s9IQm/WCVsA5DFEWr3ThKD1y31sFxG54tKaprJl1vahhrlHsKpgG8AEeiGFhCS1Y0f8O0XXzAEkwBtwIZ4=
X-Received: by 2002:a05:6512:ac2:b0:4fb:9631:4bb with SMTP id
 n2-20020a0565120ac200b004fb963104bbmr2285073lfu.11.1690555824109; Fri, 28 Jul
 2023 07:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230727131326.2282301-1-lb@semihalf.com> <2023072705-palpitate-cut-874b@gregkh>
In-Reply-To: <2023072705-palpitate-cut-874b@gregkh>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Fri, 28 Jul 2023 16:50:12 +0200
Message-ID: <CAK8ByeJYtFcMbEabSDJwXhE3jYY2xQG+JHR0gpwh6_=yg+AXjw@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 27 lip 2023 o 16:47 Greg KH <gregkh@linuxfoundation.org> napisa=C5=82=
(a):
>
> On Thu, Jul 27, 2023 at 03:13:25PM +0200, =C5=81ukasz Bartosik wrote:
> > Thunderbolt tracing is a lightweight alternative to traditional
> > thunderbolt debug logging. While thunderbolt debug logging is quite
> > convenient when reproducing a specific issue, it doesn't help when
> > something goes wrong unexpectedly. There are a couple of reasons why
> > one does not want to enable thunderbolt debug logging at all times:
> >
> > 1. We don't want to overwhelm kernel log with thunderbolt spam, others
> >    want to use it too
>
> But doesn't the dynamic debug infrastructure allow this today?
>

Dynamic debug allows only partially what we would like to achieve.

Our goal is to be able to gather thunderbolt debug logs from ChromeOS
end users when an issue happens. Especially that would be very useful
for us in case of issues which reproduction is difficult. We would
write thunderbolt debug logs to a separate wrap around buffer provided
by trace subsystem. When an issue happens and a user sends a feedback
then thunderbolt logs would be attached to the feedback providing
more insight into what happened.

Dynamic debug sends all debug messages to dmesg and with significant
number of dynamic dev_dbg prints enabled dmesg may be quickly overwritten
and other important logs lost. Also enabling dynamic debug for the
entire kernel might
not be appropriate for production kernels due to impact on kernel size and =
perf.

> > 2. Console logging is slow
>
> Slow how?
>

I meant slow compared to writing messages to trace array instance in memory=
.

> > Thunderbolt tracing aims to solve both these problems. Use of
> > the thunderbolt tracefs instance allows to enable thunderbolt
> > logging in production without impacting performance or spamming
> > the system logs.
> >
> > To use thunderbolt tracing, set the thunderbolt.trace module parameter
> > (via cmdline or sysfs) to true:
> > ::
> >   eg: echo true > /sys/module/thunderbolt/parameters/trace
>
> Why yet-another module parameter?  Why is this required?
>

This is to enable/disable write of thunderbolt debug logs to thunderbolt
trace array instance.


> > Once active, all log messages will be written to the thunderbolt trace.
> > Once at capacity, the trace will overwrite old messages with new ones.
> > At any point, one can read the trace file to extract the previous
> > thunderbolt messages:
> > ::
> >   eg: cat /sys/kernel/tracing/instances/thunderbolt/trace
> >
> > The thunderbolt trace instance is subsystem wide, so if you have multip=
le
> > devices active, they will be adding logs to the same trace.
>
> This just uses the existing logging functionality and ties it into the
> trace functionality, right?
>

Yes, it writes log messages (including debug level) to memory buffer provid=
ed
by trace framework.

> If so, why not do this for all printk messages, why should this be
> unique to thunderbolt?
>

I agree it would be better to come up with a general solution that can be
used by any part/subsystem of a kernel. I think it makes sense for me to lo=
ok
more into dynamic debug and see how it could be extended to cover our use c=
ase.

> Normally with tracing, you enable specific tracepoints that you add, not
> just "all dev_*() messages", are you sure this will actually help?
>

Yes, it would be helpful, here is an example snippet from logs
captured into thunderbolt trace array instance:
 <...>-177     [000] .....   217.635100: tb_trace_printf: thunderbolt
0000:00:0d.3: 0: resuming switch
 <...>-177     [000] .....   217.635101: tb_trace_printf: thunderbolt
0000:00:0d.3: restoring Switch at 0x0 (depth: 0, up port: 7)
 <...>-177     [000] .....   217.635400: tb_trace_printf: thunderbolt
0000:00:0d.3: 0:1: USB4 wake: no, connection wake: no, disconnection
wake: yes

Thanks,
Lukasz

> thanks,
>
> greg k-h
