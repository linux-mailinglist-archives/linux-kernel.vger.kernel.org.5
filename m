Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB337B9E29
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjJEN75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjJEN5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:57:53 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346F71BF5;
        Wed,  4 Oct 2023 20:55:47 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7b07548b085so215384241.2;
        Wed, 04 Oct 2023 20:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696478146; x=1697082946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA6+xMHo1V0jyHxa3B2EhwgcTn/GiHjuNP/IimGuAGY=;
        b=lSSKUsH6kUaZ71cGYKmxXa1PTFl6zXqTT8y7mWegBA4WslgxEpZCvx9AhmYr79iMjH
         47ma2Z0+uCd3jG7j9nCzhwNUcSOEgInEc2uh0dXXA84bR8WpL9Yk3KGk/kbgy/6MvzKB
         g28BUGTYjdegL/YhP7i6MFTBKx2K9YEseE5/rYh/0OQQTgZw9STFwMVoKM2snFzN0Ve9
         +GnB+miKYgP/uo+I+8s0tLyLDUQPCts9eAvw6nH2a4oiIh4nUSW4fywp37pD1mzOzIKs
         MNr5rUYddExHHoBJw3Zo4awJfjdyUQUHLuEQrdqxgzoLGCQJqrGSveXne6cxQtcRY1/s
         cEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696478146; x=1697082946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA6+xMHo1V0jyHxa3B2EhwgcTn/GiHjuNP/IimGuAGY=;
        b=Bz5Vn/xZGaD140JWgTQ9ChRgYY6czdnU6UpzIHp4cY4XVKLXKWjM4Uc4z5lq+Wgftv
         xNnTEmHep3ttld/75bTfeQ7dkGzYrV+Wu1Hwd4levGjxD+SYGKoxC90MKv4bDmraOQf6
         2a2muzPB5ioGt5uU66eKfU83g1KnqP3uEo6ez/zAvtvojvVw1K1qgYAW9OlGcQDjYDCc
         GZE8QH6vEKqWPIe+uS9A3XH0cutC7SWjxsOpTr+R1dUXacygegu5EVg75Xwy8LtXk8k0
         Lsdlcqw0cjcK6nwQEEGwxSx0lLc/4hRvhR+X7GHQXMSoEbloP8tRf/FrY5Sw8HREN4w7
         CWjA==
X-Gm-Message-State: AOJu0YxeYDTytnjwxHB7MBgMq2PIuljvNHPFUDhDqBgWYVOJwuFWNRHb
        dzHyQxihaxRPE/fLLahBVMii2/Hfmz2jfT/1J3E=
X-Google-Smtp-Source: AGHT+IGhutk41Atirdz72BPO6mypjapbxNvc/HY4PfmO7Owm2/7cVPrCtcBwal6aAUk8eOP9WsgTpAJvtiDPFJqJ2v4=
X-Received: by 2002:a67:f7cf:0:b0:452:c3a4:1f99 with SMTP id
 a15-20020a67f7cf000000b00452c3a41f99mr3820165vsp.4.1696478146227; Wed, 04 Oct
 2023 20:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <CACsaVZ+LkHwTKO4XE_FFM62SbF3gGD4DZyse-9Y1UbJUgrhvfA@mail.gmail.com>
 <ZQPxuZ2tifa9bQKJ@gcabiddu-mobl1.ger.corp.intel.com>
In-Reply-To: <ZQPxuZ2tifa9bQKJ@gcabiddu-mobl1.ger.corp.intel.com>
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Wed, 4 Oct 2023 20:55:34 -0700
Message-ID: <CACsaVZJYcGv26gM=Kcm2R3-A7Yqc9Jc1cd8TchA0POpxx1NHow@mail.gmail.com>
Subject: Re: Linux 6.1.52 regression: Intel QAT kernel panic (memory corruption)
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Linux-Kernal <linux-kernel@vger.kernel.org>, qat-linux@intel.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:55=E2=80=AFPM Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
>
> On Thu, Sep 14, 2023 at 10:27:22PM -0700, Kyle Sanderson wrote:
> > Hello Intel QAT Maintainers,
> >
> > It looks like QAT has regressed again. The present symptom is just
> > straight up memory corruption. I was running Canonical 6.1.0-1017-oem
> > and it doesn't happen, with 6.1.0-1020-oem and 6.1.0-1021-oem it does.
> > I don't know what these map to upstream, however with NixOS installed
> > the same corruption failure occurs on 6.1.52.
> This is probably be related to [1].
> Versions from 6.1.39 to 6.1.52 are affected. Fixed in v6.1.53.
>
> [1] https://www.spinics.net/lists/stable/msg678947.html
>
> Regards,
>
> --
> Giovanni

Thank you Giovanni - that appears to have been it. Ubuntu
6.1.0-1023-oem (v6.1.53) no longer reproduces the issue.

K.

On Thu, Sep 14, 2023 at 10:55=E2=80=AFPM Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
>
> On Thu, Sep 14, 2023 at 10:27:22PM -0700, Kyle Sanderson wrote:
> > Hello Intel QAT Maintainers,
> >
> > It looks like QAT has regressed again. The present symptom is just
> > straight up memory corruption. I was running Canonical 6.1.0-1017-oem
> > and it doesn't happen, with 6.1.0-1020-oem and 6.1.0-1021-oem it does.
> > I don't know what these map to upstream, however with NixOS installed
> > the same corruption failure occurs on 6.1.52. The stack traces give
> > illegal instructions and all kinds of badness across all modules when
> > the device is simply present on the system, resulting in a hung
> > system, or a multitude of processes crashing and the system failing to
> > start. Disabling the device in the system BIOS results in a working
> > system, and no extreme corruption. kmem_cache_alloc_node is the common
> > fixture in the traces (I don't have a serial line), but I suspect
> > that's not where the problem is. The corruption this time happens
> > without block crypto being involved, and simply booting the installer
> > from a USB stick.
> This is probably be related to [1].
> Versions from 6.1.39 to 6.1.52 are affected. Fixed in v6.1.53.
>
> [1] https://www.spinics.net/lists/stable/msg678947.html
>
> Regards,
>
> --
> Giovanni
