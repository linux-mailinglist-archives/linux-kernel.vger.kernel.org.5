Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FDE811F23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjLMTn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLMTn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:43:57 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E26DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:44:02 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-dbcc63b7c68so1675205276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702496641; x=1703101441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KwJmg/AmRci9oth6e0vim63G1m84y3oNQcN/OKV3e0=;
        b=YEamIdU7C239wWPhqUHdM5mUnEJHCDsS6mV07MZk3u2h4XsRiQFtYsKTRzDqF0SWvz
         8xo+oS9bCU9hLMZjmxNcqhlYARs7r1jd0M/EmCgne2ivcV9Jwg41OYIK08nVin/QqOKP
         WRHp6VQRqdsdWCZMf5ig8td+pC8U6YnOfKYU4+BaqmyWYC3uGP+34m4+wxeI2Ccw32AQ
         8miGZdidSEs2mBdcowgm7+DNQSD2Y8clzNrR9t+tmgLM0J8MLFDJhbjT/Q4ZhzS6GQoQ
         dTbInR8BqVr0ts7LZpq7jntHS13SHrK82556ERAkjzACnvr3uLp8mJvvHkrucMbHcMAi
         Viig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496641; x=1703101441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KwJmg/AmRci9oth6e0vim63G1m84y3oNQcN/OKV3e0=;
        b=opagfUPbGB6FAY02pcdKeEtfyX6xVegy+s/WNy+hB+bY6HLJHg4i8XtF0bCkSBuBqq
         fIj1WRTPIt8++JZLbRMB/Fo4adtlyCvPpi0kblqjtJZtwoeAmHf+dNLPKPoSb2xUPSJg
         pDZ2zkPZZOH2Ekknx77q682YRlQaCLl+MyBFxdhN/j4yJ9XyGA8uzacec3hpL8iG4EyS
         2uzZ2QhGOH/HPEz2LtM7m0EpUaeNl7eBuTdjhZJIx2ruCwSljoy3HoRg6/d+C6kQ1ack
         yqXNW1Z6qr+1P3a4b3QUsGzIFRbFnFeeFSI/iCKHoQxH+WQ8IBeEOqrtKqQ1hdDp2Ycw
         pOXg==
X-Gm-Message-State: AOJu0YyUOVbBhBwIkkoBDkwHe/rElZY5zHeIizeSLoaTaOUEwraKFPTF
        xNqALBaFuZCjRGc96iP2rTwlLOioTjC3S5sdeD0ciw==
X-Google-Smtp-Source: AGHT+IFSmPxfZTBIe3gumpwK2nVwVDcDb9+yDl2yaVi4US6Ez2/rKUahNn9IJ0xE08iqlW2A2FfQ7xQQ2M/z/jnykQ4=
X-Received: by 2002:a25:8c91:0:b0:db7:dacf:59de with SMTP id
 m17-20020a258c91000000b00db7dacf59demr4990232ybl.82.1702496641231; Wed, 13
 Dec 2023 11:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-2-201c483bd775@kernel.org> <CAKC1njSC5cC_fXnyNAPt=WU6cD-OjLKFxo90oVPmsLJbuWf4nw@mail.gmail.com>
 <d708b493-267a-4418-be91-9bde6b2cf50c@sirena.org.uk> <CAKC1njSQPO8ja7AkTzQ724hhSsGjchH9dLbbH9LXP0ZiKj-zPQ@mail.gmail.com>
 <0d0d8802-09e3-4ea5-a0b4-b3a08c8a282e@sirena.org.uk>
In-Reply-To: <0d0d8802-09e3-4ea5-a0b4-b3a08c8a282e@sirena.org.uk>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Wed, 13 Dec 2023 11:43:49 -0800
Message-ID: <CAKC1njRHs0R=VKfn4jBap9__oR0rBHmNy7_tqHR8=xEHdUE4+A@mail.gmail.com>
Subject: Re: [PATCH v7 02/39] prctl: arch-agnostic prctl for shadow stack
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 5:37=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Dec 12, 2023 at 04:50:38PM -0800, Deepak Gupta wrote:
>
> > A theoretical scenario (no current workloads should've this case
> > because no shadow stack)
>
> > - User mode did _ENABLE on the main thread. Shadow stack was allocated
> > for the current
> >   thread.
> > - User mode created a bunch worker threads to run untrusted contained
> > code. They shadow
> >   stack too.
> > - main thread had to do dlopen and now need to disable shadow stack on
> > itself due to
> >   incompatibility of incoming object in address space.
> > - main thread controls worker threads and knows they're contained and
> > should still be running
> >   with a shadow stack. Although once in a while the main thread needs
> > to perform writes to a shadow
> >   stack of worker threads for some fixup (in the same addr space).
> > main thread doesn't want to delegate
> >   this responsibility of ss writes to worker threads because they're un=
trusted.
>
> > How will it do that (currently _ENABLE is married to _WRITE and _PUSH) =
?
>
> That's feeling moderately firmly into "don't do that" territory to be
> honest, the problems of trying to modify the stack of another running
> thread while it's active just don't seem worth it - if you're
> coordinating enough to do the modifications it's probably possible to
> just ask the thread who's stack is being modified to do the modification
> itself and having an unprotected thread writing into shadow stack memory
> doesn't feel great.
>

Yeah no leanings on my side. Just wanted to articulate this scenario.
Since this is new ground,
we can define what's appropriate. Let's keep it this way where a
thread can write to shadow
stack mappings only when it itself has shadow stack enabled.
