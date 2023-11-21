Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FE67F24F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 05:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjKUExh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 23:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUExf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 23:53:35 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9BBD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 20:53:31 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41ea9c5e83cso224881cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 20:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700542409; x=1701147209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBkXRng0WwkeqG3mC9E0rD7mpoQUAf8DyTenpNasvY8=;
        b=QGDAQCEgR5l9hFEqYkMeDmlIOlwa16rpRybBtCppGvHSktuhNGeLgBY/9hzoGejjCq
         tYw1Mq9/IhkJh0mArrVcPtwTggSDTQqosdCgrGt3dXsp1Vnm316/p9nCZSUpKpayEklZ
         wz3Jv7AcLA4V+X7VNUd4RZSLjbw5c9IpuL+Uk4Ff3JTS6T1M/FhH0dF5HPhyVMkcTRzR
         3j3UE1Qo0IM4i+T4L2Cy2dCgahBVku7TbpQlwhxMXMuXPX8G8S93Wki4cwo5tWj86t2f
         o+kTYrqO+nhO5Qiq1JkNnrUka4TJCggBAlXzXBLIh8FojjH93PDefNroBQ/7HNgvB/N0
         Ho4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700542409; x=1701147209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBkXRng0WwkeqG3mC9E0rD7mpoQUAf8DyTenpNasvY8=;
        b=OeIoGpDrmzc4zw5vCUotfMM7+aM5DI63dXZWXNnuuDOfu3uQUEsQlGbdyI0rQHI8i1
         Dp4PxwdF9X15ZEC37HemM9z7bhslYPTXrPVxhqNgaA/I/zjzrbBI6KuTEbHvlxoNzZqP
         YXXN296p+oDnU0QVmH99uAzH2dqw3QwWAz+U4pOg3JaaP/S80fqjXvdL+E4utZI13M3j
         q06sOHBsP2ZQpXKx+YlaH+7713CJOeS+DnH0t9a0Iu8/plVqBq4sSNDkhezOm8hkMpyF
         i9MbipTJ7XYi0J4csDRMSd7KxNNixmprk84usDOzrIAE22S3WTb5/6b0Rd/PgZ8CbcGH
         nyXA==
X-Gm-Message-State: AOJu0Yy+FOtMSh1oR0gIprjQkdUWMuX1oLk4wuyjvU9zGNPj9SpD6yNk
        BuP3aDw2l6pF3zixBz+CqFo4LbtBV2OlwM9iP6EIspv78KHZ8rbqHJMONg==
X-Google-Smtp-Source: AGHT+IFhbmHym8R9Le8/vdeMhxuyRGgZwUuYEYJvcFjiuXRmmPu308GpBg9EeqJyBIt0sQp81rmtyl2dO1fRkjhq1aE=
X-Received: by 2002:a05:622a:6086:b0:41c:da19:f763 with SMTP id
 hf6-20020a05622a608600b0041cda19f763mr805230qtb.14.1700542408942; Mon, 20 Nov
 2023 20:53:28 -0800 (PST)
MIME-Version: 1.0
References: <CAMRc=MfvrqyAXYS0Q_ko9sYycnb-1n4Q+KjGUYBLig0BX9vDQA@mail.gmail.com>
 <CAGETcx8MNrLhoE8c0=VMc_bW0313zt+8B9w69ziYNV5ynkK8Gg@mail.gmail.com>
In-Reply-To: <CAGETcx8MNrLhoE8c0=VMc_bW0313zt+8B9w69ziYNV5ynkK8Gg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 20 Nov 2023 20:52:52 -0800
Message-ID: <CAGETcx_fXa6Zt_gkTQKw8Wt11EmSt8ZQ6TxKi5P+5ii3EvwsdA@mail.gmail.com>
Subject: Re: Device links between providers and consumers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

Adding LKML so that others are aware of what the issue is and it'll be
easier when I get to my TODO patches and send them out. I'm hoping
that's okay with you because we didn't discuss anything confidential
here.

On Mon, Nov 20, 2023 at 2:21=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Mon, Nov 20, 2023 at 12:38=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >
> > Hi Saravana,
> >
> > As I suspected, I couldn't observe the behavior you described during
> > our discussion at the LPC event. I have a DT GPIO provider and a
> > consumer referencing it by phandle. I'm unbinding the provider and the
> > consumer keeps on living, if it tries to use the GPIO, then it will
> > enter the regular code path in GPIO for checking if the provider is
> > there or not.
> >
> > Could you point me in the right direction here?
>
> Thanks for trying it out! Based on the code it should unbind the
> consumers. I haven't ever tried it myself (no need for it).

I took a closer look to show you where the consumer unbind is supposed
to be done, but in doing so I think I know what issue you are hitting.
One of my TODO items for device links should fix your problem.

The force unbinding of consumers when the supplier is unbound is
supposed to happen here:
device_driver_detach()
-> device_release_driver_internal()
-> __device_release_driver()
-> device_links_unbind_consumers()
-> for all "active" consumer -> device_release_driver_internal()

However the problem is the "if (drv)" check in __device_release_driver().

This problem also exists for "class" device suppliers that don't have
a drv. Fixing managed device links for "class" suppliers (and now, bus
suppliers without drv) has been in my TODO list for a while.

The gpio device is one of the cases of a "bus" device probing without
a driver. A while ago, I implemented a gpio_bus_match() that'll probe
the gpio device (so consumer probing isn't blocked) and I was trying
to keep the boilerplate code minimalistic. So, for your test case, a
quick test hack would be to implement an actual stub driver instead of
using a stub bus match. That should fix your problem with the
consumers not unbinding. I'll put up a proper fix sometime soon
(hopefully over the holiday lulls).

Btw, when we were talking in person at the LPC dinner, you were asking
"what would you do if the supplier was an optional supplier but you
forcefully unbound the consumer?" I have a nice answer now:

After a force unbind, we need to add all these consumers to the
deferred probe list and trigger another deferred probe attempt. If the
supplier was optional, the consumer would probe again. This also has
the nice property that the consumer doesn't advertise something to
userspace that it can't deliver (because the supplier has gone
missing) and it makes the error handling easier for drivers. They
don't have to worry about suppliers vanishing in every part of their
code. Once they get the supplier and probe successfully, they
shouldn't have to worry about it vanishing underneath them.

Cheers,
Saravana


>
> Let's start with making sure the basic functionality is working in your c=
ase.
>
> Can you check /sys/class/devlink to see if you see a folder with the
> following name?
> <bus:supplier>--<bus:consumer>
>
> Once you find it, can you cat all the file contents and tell me what
> it says before you unbind it?
>
> The "status" should be "available". And "sync_state_only" should be false=
.
>
> Also, how are you unbinding the supplier? And does the board you are
> playing with something that's upstream? Should we take this discussion
> to LKML?
>
> -Saravana
