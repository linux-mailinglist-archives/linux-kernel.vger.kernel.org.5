Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DF87A1920
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjIOIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjIOIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:46:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CB410DF;
        Fri, 15 Sep 2023 01:46:30 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5029e4bfa22so3136733e87.3;
        Fri, 15 Sep 2023 01:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694767589; x=1695372389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW5DG8Hwtbc4n4guL0DfQmbZTZ9fyH3V4yIB2Lvai/E=;
        b=AsfNcoks0GbDs7zrmCtTYeoK2FR6eEh6VMTsIkFPU+mK1O4tZxFj4SPySxDgFkpFHJ
         vYra4EP9pusM2ijGoh1VtpRuMlWXmd+wT6rtVqGQD9kOX7UEGVR6Ht+WwbQgBQC6NzXS
         V0WVNPaS97WMUbEutnbyOM+Ge1X14MDx0iMeVX+Y0RvhUEsJfjAnc1KUhz29UTL+G6z9
         a+cDOJHS2IJ92fbUC7Ep49oxtuuoiQs97LdmeaMamDVqxY8fXbl+TCwh8GNIu+lRHtkp
         SUxZDzSsO6XsurrJGiyy0HM6LKISzSmEoQqc96XYNPWKnZXew/oI7xx7Bv7fdg5bl37q
         +FRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694767589; x=1695372389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW5DG8Hwtbc4n4guL0DfQmbZTZ9fyH3V4yIB2Lvai/E=;
        b=lT9xWvBx292lgPQVpt/43uuIrGfzZUOV93AiLPaK2QAQ0xa/67MIDYgmyXl1JuOQF0
         srl06JKL7XymaSV7j3mhcx5VdeJyKiXGGTb2BSmeyhSNtMrnySaaosioPsipPfl/bBJv
         Kunoq4dAf480WjN4D6NHsMXC7IRDkWQm32ErHUalQttKD9w6vM0xXbefje2O/rCFeViL
         YmoHHPBG8YTUdbNBYCcaA2EXpv7PvyH1wAS5GV2X0NDSZ2PO+uwfQW021BG02z1qVXy2
         tptpthmgF3luY2fSeLzccl33bd+Ww8g5mk07UNhGl3u2jvrKjFryLRkzq6FxSQAAiZoo
         NURw==
X-Gm-Message-State: AOJu0YyVtrNPXUk0E12l04TianSCfulutb7N2DXQbaIIwTUppFiMKzmh
        j+g81aK/Nzy9mezqplLVuO6LJsop58WQjyfYHB4=
X-Google-Smtp-Source: AGHT+IFY4O3kkgDLoGu1aGxdoGoRt5bBMenHIFncJmvMkzqnJgAqWwuZfr+Kad9hscB8ExmsAWf0S/7sQhckVaLUCTg=
X-Received: by 2002:a05:6512:281b:b0:501:bf37:1fc5 with SMTP id
 cf27-20020a056512281b00b00501bf371fc5mr1061940lfb.22.1694767588569; Fri, 15
 Sep 2023 01:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
 <8734zfx2bo.fsf@jogness.linutronix.de>
In-Reply-To: <8734zfx2bo.fsf@jogness.linutronix.de>
From:   Enlin Mu <enlinmu@gmail.com>
Date:   Fri, 15 Sep 2023 16:46:02 +0800
Message-ID: <CAAfh-jPc+UWMcLPFbYy6rYUh4OU36frkVYVbkhNPNX4L6RG5sA@mail.gmail.com>
Subject: Re: [PATCH] printk: add cpu id information to printk() output
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Enlin Mu <enlin.mu@outlook.com>, pmladek@suse.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        enlin.mu@unisoc.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

John Ogness <john.ogness@linutronix.de> =E4=BA=8E2023=E5=B9=B49=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=BA=94 16:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2023-09-15, Enlin Mu <enlin.mu@outlook.com> wrote:
> > Sometimes we want to print cpu id of printk() messages to consoles
> >
> > diff --git a/include/linux/threads.h b/include/linux/threads.h
> > index c34173e6c5f1..6700bd9a174f 100644
> > --- a/include/linux/threads.h
> > +++ b/include/linux/threads.h
> > @@ -34,6 +34,9 @@
> >  #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
> >       (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
> >
> > +#define CPU_ID_SHIFT 23
> > +#define CPU_ID_MASK  0xff800000
>
> This only supports 256 CPUs. I think it doesn't make sense to try to
> squish CPU and Task IDs into 32 bits.
Yes, it is not good way,
>
> What about introducing a caller_id option to always only print the CPU
> ID? Or do you really need Task _and_ CPU?
   Yes, I need it.Because I need to know which CPU is printing the
log, so that I can identify the current system operation, such as load
situation and CPU busy/idle status
>
> John Ogness

Thanks

Enlin
