Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBE17F91AD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 07:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjKZGpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 01:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZGo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 01:44:58 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D93C7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 22:45:04 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4acf9dd3d35so1022572e0c.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 22:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700981103; x=1701585903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgZXutmXX9uYtq4WDYC/LHkmx24eIdlcQOf4F4S1Usc=;
        b=Wf6OAh766lS+xXjRJd47nwS3Bd/nRQJt+6f1Xr8ixZeJs0svGLvHKXQMnyqn7LL9Gm
         /RNFCCDfMiOHUjs0d+yYQ9Nwl7HCuFXZi6XlpJ5LD6UvmcBjBhqXNaxnNxf5oURM3gkR
         s/Akm/ZjC8QARi11ArgqetP7xayFcj2Q5ivgZ04Zhk9aKiNbKSQz4Ca7oVpRvT3GMFhe
         5wVv2hKl3IcIoL1qf4Fygy6xX8XPx4HoZZuyrGfiUp0J01GsZ5DiYggtezYWIOYVuPlI
         2f9ofl4jFz0hkLHnPZ1uNSyd98GINwfMc9n5XnVA7EMgPN559+AlMNXrkjVrgGh4rj/+
         RVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700981103; x=1701585903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgZXutmXX9uYtq4WDYC/LHkmx24eIdlcQOf4F4S1Usc=;
        b=Zjco6QsHpDYQjvs3L4yi4Nk7cvoM6ffx5utiHu1IZ2VcDgYrSOoyKqweBGl+6h932x
         IrIxJ7WzbhCAnV0MbSlsYHGhHTYqK+YAn4NJTfm1BjJ3VSYtB6zyICMEghTRiv/eCfIR
         zobJ7GxaW7J4Kw4TQrcpIWwHwNIWvzXl6aawfmk0l8tS3dV0dDa5Pc3hC/t/P6uIEhEN
         r6I1onia4ctJad/WZ6UQyl0AX29He05DPcIl7ZXrYlLiSwCwA5fngO01Onou9Tq/GTX+
         viqs4VEVJ5JTrE7Axo9EZJBlAWtV5YyshGs0nr5gYTaU6EvPO/8fl4PdXXjnVDr0dVTL
         Rskw==
X-Gm-Message-State: AOJu0Yx2rhCBIed9gnmBrpAoWnP38qb2Mg9E6LCAozD2z4r7izy9V2Qc
        ti2wGA6sJWS+b4qPrdnvaHht+PefNMs5VqfdkcLuAgpn
X-Google-Smtp-Source: AGHT+IFrIwgyly0619dlGbmXTblvtHQwc9fmV9F+k1/5ZpauWJhwG/r7/i9no+/gs8u5gWzSIK/lT92tDm/hU0arR0A=
X-Received: by 2002:a67:ec17:0:b0:462:8944:f6ea with SMTP id
 d23-20020a67ec17000000b004628944f6eamr7758982vso.16.1700981103076; Sat, 25
 Nov 2023 22:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20231116224318.124209-1-jim.cromie@gmail.com> <20231116224318.124209-3-jim.cromie@gmail.com>
 <ZVj2CRI7452gm6lH@arm.com>
In-Reply-To: <ZVj2CRI7452gm6lH@arm.com>
From:   jim.cromie@gmail.com
Date:   Sat, 25 Nov 2023 23:44:36 -0700
Message-ID: <CAJfuBxw_RKv0PJR+vQs-fbg-+hNQOx6wVm2aUm=EPPa+z9nT2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] kmemleak: add checksum to backtrace report
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 10:36=E2=80=AFAM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 16, 2023 at 03:43:18PM -0700, Jim Cromie wrote:
> > Change /sys/kernel/debug/kmemleak report format slightly, adding
> > "(extra info)" to the backtrace header:
> >
> > from: "  backtrace:"
> > to:   "  backtrace (crc <cksum>):"
> >
> > The <cksum> allows a user to see recurring backtraces without
> > detailed/careful reading of multiline stacks.  So after cycling
> > kmemleak-test a few times, I know some leaks are repeating.
> >
> >   bash-5.2# grep backtrace /sys/kernel/debug/kmemleak | wc
> >      62     186    1792
> >   bash-5.2# grep backtrace /sys/kernel/debug/kmemleak | sort -u | wc
> >      37     111    1067

So, speculating from here,
what else could be done with <crc: deadbeef> ?

1 - (optionally) collapsing backtraces, replacing the stack with
   "seen previously, at <mumble>"
    of some clear / succinct flavor (maybe several ?)

2 - stack specific instructions from user

echo drop/ignore/histogram/<mumble>  deadbeef \
     > /sys/kernel/debug/kmemleak

this crc-specific instruction could control the optionality of 1.
on a trace-by-trace basis even.

The "seen previously" would be an obvious place to look
for a root cause of a detected leak.
tools beyond drop/ignore/histogram/<mumble>
are worth some consideration ?

> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
