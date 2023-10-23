Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6DA7D2787
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjJWAeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJWAeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:34:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CACDC
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 17:34:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so3920491a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 17:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698021256; x=1698626056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf4op5br1ztmtzsuW4A7c+sb/jIvoiKssiNsddkNzIo=;
        b=nC3GlrtwpeqpsDoyXEYeAtgUPkAaM7UpwJTI9maG6kDEnH6pARxW7aWoUBeWb9zC9o
         5cL81BgkpYiOOhYfwE/wnv3EIigmapLZ+8hdJXjvi5tAgUPqHMP+4n984dMtHYhWiNfZ
         SnylhEQXLKmoChPcKWogF6cZ5/8/9T1JMHN/tE1DQjoQqUWGcBgl+b4SaXHunNgbdgrN
         wCYE1cISN0TwBqXg+5IanJcHfpvN9Dtl5qM6PeTMga8wU2W3ny/Rqr8rXSHHn+T9kAE3
         bO/CG4ILN8zVPFaa5fYS2wjXd4iMCL2E8vp7jPKYajLWWXrh8MKZWO/TPr5QGyecV/dR
         SvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698021256; x=1698626056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf4op5br1ztmtzsuW4A7c+sb/jIvoiKssiNsddkNzIo=;
        b=IPEhmJw8tmacp+zSzep/t+ZxUEyWRws03bSOzHU1Z6f3jXPgNR5RHcR9893lOfcado
         PH0TGZTL1XErDOYHYQ2c9cAisre3gLy7rAGrQhhOLbRWAYf7FXYNQ4myVySAGC+jFgzL
         FJGAcGiO3ULY0Lvd9ro6cXtgx+BzE3SLGxs2CWxtNQ6uvxbT0BTcP9m7v3WD1xUmyzhT
         fLFQG6Lk/5fvvsOZ6OGMF6jQAmNHON6SJw88poUTexeo5tt1fwIwnyBtJM7/kkjcz/ii
         e7ikPHWEYKLv0piubfXvi/V+cjguIfywVHWJefSqssdWYNdmhAICIVmSExG0cwVeJSrp
         sbjA==
X-Gm-Message-State: AOJu0YyUOPsDqyUTFrCzIKAquiC1Zjkwx6s42ehv4YGXz937EUDGuUy7
        A6zUdnghLGll1xJqpIpxd9xqr75IQ6ySfbX0N7LIG6BQ
X-Google-Smtp-Source: AGHT+IEz9IPbSfxHt/XOQd0CQjMdfeNrgd2QmtWb/Av/GeZg34zjp153Pwm56E7jpmtqDlP7MfL9gVj/cbzTEEoGIrU=
X-Received: by 2002:a50:8a95:0:b0:540:f3e:9666 with SMTP id
 j21-20020a508a95000000b005400f3e9666mr3142493edj.37.1698021256154; Sun, 22
 Oct 2023 17:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOx-CDUwV0d0+2UdZW+vdUcjwAg2+Hanf1-iNSYFRWOW2yQugg@mail.gmail.com>
 <6675c47a-d258-41ae-b506-88d7ae74b551@infradead.org>
In-Reply-To: <6675c47a-d258-41ae-b506-88d7ae74b551@infradead.org>
From:   gmssixty gmssixty <gmssixty@gmail.com>
Date:   Mon, 23 Oct 2023 06:34:06 +0600
Message-ID: <CAOx-CDVn7Ub31yiRpoZh4RhJBCvgZhb8Ca=cH9b0xWPjk5FNQA@mail.gmail.com>
Subject: Re: How can I add "busybox sh" as init during boot of the custom kernel?
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
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

I tried this: init=3D/bin/busybox sh, but it got Kernel panic and
failed. On the other hand, what should I write in /sbin/init?

On Mon, Oct 23, 2023 at 6:15=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 10/22/23 16:56, gmssixty gmssixty wrote:
> > How can I add "busybox sh" as init during boot of the custom kernel? I
> > have compiled the kernel and put the bzImage in /dev/sda3 (/mnt/sda3).
> > Booted that kernel. After booting, I got a message to set the init
> > process. I have put the busybox in /bin. Now I want to add this
> > "busybox sh" as an init process. How can I do this?
> >
> > Note that, I did not install any other software in that /dev/sda3
> > (/mnt/sda3). I have only bzImage and busybox.
>
> from Documentation/admin-guide/kernel-parameters.txt:
> (or https://docs.kernel.org/admin-guide/kernel-parameters.html)
>
>         init=3D           [KNL]
>                         Format: <full_path>
>                         Run specified binary instead of /sbin/init as ini=
t
>                         process.
>
> --
> ~Randy
