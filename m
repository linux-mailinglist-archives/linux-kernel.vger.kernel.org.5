Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8B97A10FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjINW3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINW3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:29:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC1B2100
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:29:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502934c88b7so2566734e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694730574; x=1695335374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obV8+bcnRi/J9RquhfwwRZFHOsJK4qK3A3iNjPmPcnM=;
        b=YvaBYcxF/PkyZu+bUBiQzVzsajhoC8VvjaJ8USplXmykjl28gmS4QzN/wS+KJZ+Ny6
         44rWeEzb5SfMc3e8wqF8QSFAl9v0b6BEDOO1h2LpY4btJlJ3IAp1rbp0tQ//pi8QgrXW
         akgXifq0ug4WxIC5A4j9bORNkjJg5sxhW3me8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694730574; x=1695335374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obV8+bcnRi/J9RquhfwwRZFHOsJK4qK3A3iNjPmPcnM=;
        b=POqM7G41PuCIucTpDLGsrVtILUr13X7yD3fitj+H7LzUZXAQ8SY3nXJARPKasJVw9p
         kO0P+f+Q/FCEI8tna1tkTprxqaGWHcEv+osQtn5n7jjXWVkVjgUa1j136XSjXx+/jjk/
         FWsflm0RadmScaCnLMqcHKCcr8+GNnBkQsW8AgwGuK2idr0U98em9npTZ+jVLKVqvhDq
         re/zGdMGsU1l9tclnbIAxqLS/ZLGCqHvsv8f0jiuGOQBN34OB5H7Bd/xkcx/kaccdwau
         r/sNTR1L8HF4lpWVAAIdLRpHWo7m0Ymdf6KIjx+ICvLTlTkNYDVi6PSHlrO5CNNJLpZC
         hCPA==
X-Gm-Message-State: AOJu0YwCtk1yNFEDRt8Y6bCO62kG9fwLO8JW03ybgZN4Bs89ixm8/Sr7
        4QS3Y898/05G1eAJAatj6gpvHNos+4YOtV56gtscYQ==
X-Google-Smtp-Source: AGHT+IHDWoDke1rvJLejc1NExyTIW01uOkVqZtrKJ6UQUn8pOlug3jBNV/+Yx6iRyoadQRfyI6tyhA==
X-Received: by 2002:a05:6512:36c7:b0:500:a2d0:51ba with SMTP id e7-20020a05651236c700b00500a2d051bamr30725lfs.44.1694730574552;
        Thu, 14 Sep 2023 15:29:34 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id r25-20020aa7d599000000b0052a1c0c859asm1451402edq.59.2023.09.14.15.29.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 15:29:34 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso11645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:29:33 -0700 (PDT)
X-Received: by 2002:a1c:4b02:0:b0:3fe:e9ea:9653 with SMTP id
 y2-20020a1c4b02000000b003fee9ea9653mr55567wma.4.1694730573066; Thu, 14 Sep
 2023 15:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org>
 <20230901164111.RFT.3.Iea742f06d8bec41598aa40378fc625fbd7e8a3d6@changeid>
 <288af70dafc5e73d0fdfac71a33449385d4d6bd3.camel@crapouillou.net>
 <CAD=FV=VuJe7ACFw3pt1z=EAh14_Z4iTOc5VKJt24CGwZYjRpeQ@mail.gmail.com>
 <3prgpsxxnf3hzeqcpjs5r37nfojbkuwk4ezizrwfrcthm666k6@t2q2qcpnfkiu>
 <CAD=FV=VSTP2g1RttMu_9+AGQbMK87MzQO+tw1cZBEJ3g-jAmYg@mail.gmail.com> <vkdjbjda23fwofsbt23wtjgiya3uhelby7evwtvteqkpwb4dr4@ybla63hqndic>
In-Reply-To: <vkdjbjda23fwofsbt23wtjgiya3uhelby7evwtvteqkpwb4dr4@ybla63hqndic>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Sep 2023 15:29:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VWF8tP2aykNW7+4tkqQExdoja71OqtiDFGZs+c7Gjttw@mail.gmail.com>
Message-ID: <CAD=FV=VWF8tP2aykNW7+4tkqQExdoja71OqtiDFGZs+c7Gjttw@mail.gmail.com>
Subject: Re: [RFT PATCH 03/15] drm/ingenic: Call drm_atomic_helper_shutdown()
 at shutdown time
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        dri-devel@lists.freedesktop.org, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 14, 2023 at 1:14=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> > > So it doesn't have any relationship with the unbind/remove timing, an=
d
> > > for all we know it can be there indefinitely, while the application
> > > continues to interact with the driver.
> >
> > I spent some time thinking about similar issues recently and, assuming
> > my understanding is correct, I'd at least partially disagree.
> >
> > Specifically, I _think_ the only thing that's truly required to remain
> > valid until userspace closes the last open "fd" is the memory for the
> > "struct drm_device" itself, right? My understanding is that this is
> > similar to how "struct device" works. The memory backing a "struct
> > device" has to live until the last client releases a reference to it
> > even if everything else about a device has gone away. So if it was all
> > working perfectly then if the Linux driver backing the "struct
> > drm_device" goes away then we'd release resources and NULL out a bunch
> > of stuff in the "struct drm_device" but still keep the actual "struct
> > drm_device" around since userspace still has a reference. Pretty much
> > all userspace calls would fail, but at least they wouldn't crash. Is
> > that roughly the gist?
>
> Yes, but also, no.
>
> In the spirit, you're right. However, there's three things interfering
> here:
>
>   - You don't always have a match between device and KMS entity. Display
>     pipelines are usually multiple devices working together, and while
>     you probably have a 1:1 relationship with bridges and panels (and to
>     some extent encoders/connectors), the planes and framebuffers for
>     example are a mess :) So, if the device backing the planes is to be
>     removed, what are you removing exactly? All of the planes and
>     framebuffers? Do you free the buffers allocated by the userspace
>     (that it might still use?)?
>
>   - In addition to that, KMS doesn't deal with individual entities being
>     hotplugged so neither the subsystem nor the application expect to
>     have a connector being removed.
>
>   - ioctl's aren't filtered once the device is starting to get removed
>     on most drivers.
>
> So due to 1 and 2, we can't really partially remove components unless
> the application is aware of it, and it doesn't expect to. And most
> drivers still allow (probably unwillingly though) the application to
> call ioctls once the DRM device has lost at least one of its backing
> devices.

We "can't", but we "can", right? Userspace can freely unbind a driver.
Unless you want to dig into if the community would allow a driver to
block "unbind" then we have to, at the very least, not crash the
kernel when userspace does this. Ideally we'd have something more
elegant than just "don't crash the kernel", but at least we shouldn't
crash.


> > Assuming that's correct, then _most_ of the resource acquiring /
> > memory allocation can still happen in the device probe() routine and
> > can still use devm as long as we do something to ensure that any
> > resources released are no longer pointed to by anything in the "struct
> > drm_device".
> >
> > To make it concrete, I think we want this (feel free to correct). For
> > simplicity, I'm assuming a driver that _doesn't_ use the component
> > framework:
> >
> > a) Linux driver probe() happens. The "struct drm_device" is allocated
> > in probe() by devm_drm_dev_alloc(). This takes a reference to the
> > "struct drm_device". The device also acquires resources / allocates
> > memory.
>
> You need to differentiate resources and allocations there. Resources can
> be expected to go away at the same time than the device, so using devm
> is fine. Allocations are largely disconnected from the device lifetime,
> and using devm leads to UAF.

Right. I think my original point was looking at "ingenic-drm-drv.c".
Much of the "devm" stuff there is resources and those specific things
could be moved to probe() instead of bind(), right?

For allocations, I think you'd have to look at each allocation. If the
allocation needed to live as long as the "struct drm_device" then devm
is clearly the wrong choice. ...but not every allocation needs to live
that long. Also, even if in the "simple" case allocations need to live
as long as a "struct drm_device", it's possible that there are some
cases where there's only an indirect reference to the memory. In that
case, you could NULL out the indirect reference and then free it.
Obviously someone would need to take care here.


> > b) Userspace acquires a reference to the "struct drm_device". Refcount
> > is now 2 (one from userspace, one from the Linux driver).
> >
> > c) The Linux driver unbinds, presumably because userspace requested
> > it. From earlier I think we decided that we can't (by design) block
> > unbind. Once unbind happens then we shouldn't try to keep operating
> > the device
>
> That part is correct, because the resources aren't there anymore.
>
> > the driver should stop running.
>
> But for the reasons above, the driver needs to still operate (in a
> degraded mode).

So I think here is where the disconnect is from our viewpoints. IMO
when a Linux driver is unbound then it makes no sense to try to
operate the device in "a degraded mode". When a Linux driver is
unbound then it should be releasing all of the resources from the
device (iomaps, IRQs, regulators, GPIOs, etc). That's just what
unbinding a driver is supposed to do.

I understand what you're saying above about display pipelines being
multiple Linux drivers working together and that it doesn't make lots
of sense to just unbind a random Linux device driver in the middle of
things. ...and I don't really have a simple/great answer for how to do
something super elegant if userspace tries to just randomly unbind one
of the many drivers in an active display pipeline.


> > As part of the unbind, the remove() is called and also "devm"
> > resources are deallocated. If any of the things freed are pointed to
> > by the "struct drm_device" then the code needs to NULL them out at
> > this time.
>
> Right, we also need to make sure we don't access any of the resources
> that got freed. This is typically done by protecting all the accesses
> with drm_dev_enter/drm_dev_exit.
>
> > Also we should make sure that any callback functions that userspace
> > could cause to be invoked return errors.
>
> That would prevent any new ioctl from occuring after the device has been
> removed, but that doesn't fix the race condition if it's removed while
> there's a commit happening. This is further complicated by the fact that
> commits can be queued (so you would have multiple submitted already) or
> made asynchronous.

I guess I would have expected that the remove() callback in the device
would prevent new commits from starting and then block waiting until
any in-progress commits were finished? ...kinda like how drivers call
del_timer_sync() in their remove functions...


> > Our code could go away at any point here since userspace could "rmmod"
> > our module.
>
> Yeah, we probably have a bug there. Boris also reported something like
> that recently where if you add an action with drmm_add_action, and then
> remove the module, the function would have been free'd by the time it
> executes.

I'm fairly certain that you can prevent a module from being unloaded
by just grabbing a refcount to it. However, I'm not sure that's the
right solution. If we're trying to run driver code after a driver has
been unbound then, IMO, that's the bug.


> > However, it's not a panacea for everything. Specifically once
> > the Linux driver unbind finishes then the device isn't functional
> > anymore.
>
> What's wrong with it then?

I'm mostly just saying don't just search-and-replace "devm" with
"drmm" in your driver and call it done. You need to think carefully
about which things are which lifetime.

---

Ironically, while digging into this I'm tempted to take back my
original request. Despite the kernel docs I pointed at [1], it
actually looks like it might be fine to use "devm" within a
component's bind() function. In try_to_bring_up_aggregate_device() it
seems like the code is opening up a nested "devres" group specifically
to allow this to work. A little bit of testing that I did with this
shows that, indeed, the nesting seems to be working. Am I missing
something here?

[1] https://docs.kernel.org/driver-api/component.html
