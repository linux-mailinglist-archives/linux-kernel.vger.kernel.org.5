Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995E87DB78E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjJ3KOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjJ3KOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:14:23 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216B73247
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:02:04 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59b5484fbe6so37590727b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698660122; x=1699264922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7lO5+taRGYUV3utFVgJLnLNjNxmtaBHkPbnYDUDIen4=;
        b=yVdYBjrLvwjTXp7omK711ie9w37RWbSKUmoDEJhGgXABJwRz+0Eb2x1hfUwRJPhC7f
         8WyHsWJYEd1quoXRsEe+E2u3mntyDGK+ORAwSEXOQlgowFTs45kciBFGHDzVXRRXNUbG
         DUiTBWrzpOs+A49jVwMJ9yuTPt0GUoANhFUvJGC9EWLzZEg2LmyY3f6jf9RqbkE+SXRy
         YaGKt4qMdy28tcDkepwQULLjiL4jz8kXqB6IJK5LIxBr+ce168hX0ZoJmnSGZu/LATpo
         zZPjPXB//UxO+VnWqeevICuBpZcDYiAMdYG4+dXq0qlRUd7qWr3bW0hliqUqjiKOTSKU
         Tx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698660122; x=1699264922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lO5+taRGYUV3utFVgJLnLNjNxmtaBHkPbnYDUDIen4=;
        b=XScrF++SLol4bmVZujKr+oG1bFKYCS5whHZlRo0ziaHDkMBs9sfx8YyZD3XuXOFnV9
         BQ3BdL1pjLzDTdy+QNji5XkVmb1UkFRPfTr8b1DsFJHgxA89c8Y47x9VwU1X/ViqbXYu
         3FfwUhcV2c+r8RhLTi0kj81tVuziBg0Zz43ibFs24DqkhWzeFKojEvx/p1dm+jbLR4sG
         ftigdWucHRojd/1LITC1KOnC5ONGkhxbdWyCNi+0mIFoLKk0qswo+/qNkROh28oIp5or
         MCq3VpU9+1kzNsP+f2PXuK6v63Iz0CHpnubOi26VB4PJn25g6e6zu6OrOZ1k8BqNfqtc
         Y4yA==
X-Gm-Message-State: AOJu0YxP+9Eq/52qDkrppve1WpC37mzzO59Q7SABsL25MEprHs7WXAYN
        nIjXcPf3qvDoQnzLV/3KIMDxfrc697G8LBjzML/Z5u6z+1MfgwModEaOg+6k
X-Google-Smtp-Source: AGHT+IHMOnW5IIvkllnN98d7WTlfIttakT+UyeassCtYZ55EdxcFVw1ThJqTcmAYaOcLODaGTVh67pjcINcwpLY061A=
X-Received: by 2002:a81:4413:0:b0:59b:eab8:7ac6 with SMTP id
 r19-20020a814413000000b0059beab87ac6mr9995171ywa.42.1698660122684; Mon, 30
 Oct 2023 03:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231029194607.379459-1-suijingfeng@loongson.cn>
 <20231029194607.379459-3-suijingfeng@loongson.cn> <CAA8EJprjQXcTgxnC1POaBjVBzyVBvKpmKyJcCR5ExRUhVxtYoQ@mail.gmail.com>
 <3ccb9600-6990-4ec7-81de-0d7b4e1294eb@loongson.cn>
In-Reply-To: <3ccb9600-6990-4ec7-81de-0d7b4e1294eb@loongson.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 30 Oct 2023 12:01:51 +0200
Message-ID: <CAA8EJpqCe2j3GyeutnwTB0bkGXGk0az9-w3sPHLFwMVgAS=e7g@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/loongson: Introduce a drm bridge driver for
 it66121 HDMI transmitter
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 11:42, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>
> Hi,
>
>
> On 2023/10/30 06:53, Dmitry Baryshkov wrote:
> > On Sun, 29 Oct 2023 at 21:46, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
> >> The IT66121 is a DVO to HDMI converter, LS3A5000+LS7A1000 ML5A_MB use this
> >> chip to support HDMI output. Thus add a drm bridge based driver for it.
> >> This patch is developed with drivers/gpu/drm/bridge/ite-it66121.c as base.
> > Please use the original bridge driver instead of adding a new one.
>
> I'm agree with the spirit of code sharing, but this is nearly impossible for non-DT system.
>
> Because the original bridge driver(say it66121.ko) is fully dependent on the DT.

I can not agree here. It doesn't depend on DT. It has fully populated
i2c_device_id structures, so it will work with bare I2C buses.
Most likely you will have to change of calls into fwnode calls, that's it.

> UEFI+ACPI based system can not use with it.
>
> Our I2C adapter is created by the drm/loongson.ko on the runtime.
> The potential problem is that *cyclic dependency* !
>
> I2C adapter driver is depend on drm/loongson
> drm/loongson depend on drm bridge driver (say it66121.ko)
> drm bridge driver (say it66121.ko) depend on I2C adapter to setup.
>
> This plus the defer probe mechanism is totally a trap,
> incurring troubles and don't work.

Welcome. We had this kind of issue for DP AUX buses.

I can suggest the following approach:
- In the root probe function you can create an i2c bus and populate it
with the i2c devices.
- I have not checked whether you use components or not. If not, please
use an auxiliary or a platform device for the main DRM functionality.
- In the subdevice probe / bind function you check for the next
bridge. Then you get one of the following:drm_bridge pointer,
-EPROBE_DEFER, or any other error case. Your driver can react
accordingly.

Basically duplicating the existing driver code is not really a way to
go. Consider somebody adding a new feature or fixing a bug in your
driver copy. Then they have to check if the fix applies to the driver
at drivers/gpu/drm/bridge/ite-it66121.c. And vice versa. After fixing
an issue in the standard driver one has to keep in mind to check your
private copy.

So, please, use the OF code as an inspiration and register all your
devices in the device tree. Yes, this requires some effort from your
side. Yes, this pays off in the longer distance.

> >   If
> > it needs to be changed in any way, please help everyone else by
> > improving it instead of introducing new driver.
> >
> >> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> >> ---
> >>   drivers/gpu/drm/loongson/Kconfig            |   1 +
> >>   drivers/gpu/drm/loongson/Makefile           |   2 +
> >>   drivers/gpu/drm/loongson/ite_it66121.c      | 749 ++++++++++++++++++++
> >>   drivers/gpu/drm/loongson/ite_it66121.h      |  19 +
> >>   drivers/gpu/drm/loongson/ite_it66121_regs.h | 268 +++++++
> >>   5 files changed, 1039 insertions(+)
> >>   create mode 100644 drivers/gpu/drm/loongson/ite_it66121.c
> >>   create mode 100644 drivers/gpu/drm/loongson/ite_it66121.h
> >>   create mode 100644 drivers/gpu/drm/loongson/ite_it66121_regs.h


-- 
With best wishes
Dmitry
