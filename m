Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF8A7AA484
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjIUWLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjIUWLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:11:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D5085D39
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75009C4E683;
        Thu, 21 Sep 2023 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695301757;
        bh=yAwCJjSMFMlMIBKVIk7qYPpTeU00hSIhJXw0KgaQv2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dDCs0y4leKCNNse29XK/7s764dl4ZcWvG6Hb8WhFv6KK7PYG+DZuqnEguLf+latrX
         KAW2BXC56oalCI/mEqVzwtPZzvZXWIhUc0+57ynKi0y3ynxddV4MBI6GOkJG2KNLj4
         Cirhtpzbm8OKfKqUKtE0CHvJSyJCsYn8uE7cO8LXPcHcGrQ3RhxC8OHOmYS52C/L9e
         dess+NkUw3Fsn6mnBkRX8UPAuoouxnAD3syS2qgtRwDMxGZYw14PFj8WvyWgDz3BLO
         I9SyfuoeL5eGVrRI3/v799+c4Z2UkqfRpe14Vcv8jMVhYuiOCddweVn7V+wcfBxe04
         3ef/huaSztenQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-503012f4e71so2472744e87.0;
        Thu, 21 Sep 2023 06:09:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YxMTwmOpkebywUITTo0vhyqJ4tTzamplGpSHOgSJxnAHfJ0/XU5
        hpoUBpWt85Ey2ioXu+U0a+Rl8TpvoJ8iJnErplU=
X-Google-Smtp-Source: AGHT+IE+A0IgOmBYCfeOwtLKlr2k/PnxkhL5xbSIL6oTs0ZhBPO/aaWneyxH5hDNwCWUTuzRJ5B88jpK/YlPDdeG6yI=
X-Received: by 2002:a05:6512:239c:b0:4fe:13c9:2071 with SMTP id
 c28-20020a056512239c00b004fe13c92071mr3278684lfv.2.1695301755687; Thu, 21 Sep
 2023 06:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <12299447.O9o76ZdvQC@kreacher>
In-Reply-To: <12299447.O9o76ZdvQC@kreacher>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 21 Sep 2023 13:09:04 +0000
X-Gmail-Original-Message-ID: <CAMj1kXHpVroVqXxH72XNJP5=dYDcfBiZex2wE2jOsSFNEAYqxg@mail.gmail.com>
Message-ID: <CAMj1kXHpVroVqXxH72XNJP5=dYDcfBiZex2wE2jOsSFNEAYqxg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: processor: Provide empty stub of acpi_proc_quirk_mwait_check()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Frank Scheiner <frank.scheiner@web.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 13:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of
> acpi_processor.c") added acpi_proc_quirk_mwait_check() that is
> only defined for x86 and is unlikely to be defined for any other
> architectures, so put it under #ifdef CONFIG_X86 and provide
> an empty stub implementation of it for the other cases.
>
> Link: https://lore.kernel.org/lkml/c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=remove-ia64&id=a0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
> Fixes: 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of acpi_processor.c")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Frank Scheiner <frank.scheiner@web.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This is kind of orthogonal to
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=remove-ia64&id=a0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
>
> because if any architectures other than x86 and ia64 decide to use the
> processor _OSC, they will see the reported build error.
>

You mean when other arches #define CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC too, right?

In any case, this is going to conflict with my change, which is
already in linux-next (you were cc'ed on the PR to asm-generic). What
do you propose here?






> ---
>  drivers/acpi/internal.h |   14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -148,8 +148,11 @@ int acpi_wakeup_device_init(void);
>  #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
>  void acpi_early_processor_control_setup(void);
>  void acpi_early_processor_set_pdc(void);
> -
> +#ifdef CONFIG_X86
>  void acpi_proc_quirk_mwait_check(void);
> +#else
> +static inline void acpi_proc_quirk_mwait_check(void) {}
> +#endif
>  bool processor_physically_present(acpi_handle handle);
>  #else
>  static inline void acpi_early_processor_control_setup(void) {}
>
>
>
