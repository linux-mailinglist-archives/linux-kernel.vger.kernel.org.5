Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411187F50D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344443AbjKVTjh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 14:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343687AbjKVTjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:39:36 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8091A8;
        Wed, 22 Nov 2023 11:39:32 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5841a3ffd50so17382eaf.1;
        Wed, 22 Nov 2023 11:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700681971; x=1701286771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrGYRaQuwaRR+IXDug9hdvAmme5SWIRdj6QFrDzBe8c=;
        b=GXhRiJYmTV74Y0flUuOH89405jOaMEckYpmOKMaiH5HfqXoB+H0AKa/AqIMqIIAmpC
         ipKYMNmFF/7zzxPxpg6QVcVeoDJqYarmmQ+9aEWaGOyRgCns7TFnZIvhxFqyA9pnQPJb
         eKYCV0tPG4l61TuN9h+BGMS0WBuHDWuzsfKILMs5dAtnQEeGRaGgCrPrZWUoCoGUoO5p
         ftjlqPp3rGf7Hkx342Z/QLYHPoeZm8XjVtEEyzIxu2GZVN9jp2zdrD1w25iBq/t6tlkF
         81IrYkx+Oip5C5A46KWTK3JOkXvBJ3f9G1El/NIKqnIjsNOPIgKXVrB7wK0Y7AZxPjgt
         TcEg==
X-Gm-Message-State: AOJu0YyorhX57RoLsm+s/XfhL7/B0HghGpJt5D4xbw9NhPPBbBg5uZaM
        bhb972rxCQFMMIm5NZrAql/MlIKZdF+K59ga3RJmTHCn
X-Google-Smtp-Source: AGHT+IFjlxpZYJh/rg9Lttt/sOzsAjzIgeTKw0qmGeh2mnz//xW9WqG6Gik1J5Y7uJlf0nG5JhjkP0i4pFjZHckZ/K4=
X-Received: by 2002:a05:6820:706:b0:58c:ec4c:fcac with SMTP id
 q6-20020a056820070600b0058cec4cfcacmr3707814oow.0.1700681971570; Wed, 22 Nov
 2023 11:39:31 -0800 (PST)
MIME-Version: 1.0
References: <12299447.O9o76ZdvQC@kreacher> <CAMj1kXHpVroVqXxH72XNJP5=dYDcfBiZex2wE2jOsSFNEAYqxg@mail.gmail.com>
 <5724231.DvuYhMxLoT@kreacher>
In-Reply-To: <5724231.DvuYhMxLoT@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Nov 2023 20:39:20 +0100
Message-ID: <CAJZ5v0gMw3xsKuvS0Q26D=DPdQFtDxAMfscufMZMPVFmYC2ZhA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: processor: Provide empty stub of acpi_proc_quirk_mwait_check()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Frank Scheiner <frank.scheiner@web.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 4:00 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, September 21, 2023 3:09:04 PM CEST Ard Biesheuvel wrote:
> > On Thu, 21 Sept 2023 at 13:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Commit 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of
> > > acpi_processor.c") added acpi_proc_quirk_mwait_check() that is
> > > only defined for x86 and is unlikely to be defined for any other
> > > architectures, so put it under #ifdef CONFIG_X86 and provide
> > > an empty stub implementation of it for the other cases.
> > >
> > > Link: https://lore.kernel.org/lkml/c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=remove-ia64&id=a0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
> > > Fixes: 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of acpi_processor.c")
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Reported-by: Frank Scheiner <frank.scheiner@web.de>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > This is kind of orthogonal to
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=remove-ia64&id=a0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
> > >
> > > because if any architectures other than x86 and ia64 decide to use the
> > > processor _OSC, they will see the reported build error.
> > >
> >
> > You mean when other arches #define CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC too, right?
> >
> > In any case, this is going to conflict with my change, which is
> > already in linux-next (you were cc'ed on the PR to asm-generic). What
> > do you propose here?
>
> IIUC, the conflict is that the empty stub will be defined twice if this is
> applied before removing ia64.
>
> But if it is applied on top of the ia64 removal, all should be fine, so that's
> what I would do (and tell the -stable people to ignore it).

And ia64 is gone now, so applied.
