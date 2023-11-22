Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49277F533A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbjKVWS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344652AbjKVWSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:18:24 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B64D47
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:18:20 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca26c07848so3381257b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700691499; x=1701296299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4w9WGlpV+oKNURgCWJmbzMqmytRuxi/IH9HmVAy3vpk=;
        b=VFOx2zbYyRI5iOtqLe04Owvw/t5/ER1zO7V34uuIPqdfT6WhdKlHs+LrVmQJv9gtkq
         +LRqcrtVvP6duFU/kod7koZwX8Nbv2ZKh8Tq5gKhXJqvCjeAGJvq5YwB0epsyiIlLCCd
         CWxTvd+bFgQ4rRLF3Vmeg6w+7acGjeZnErIqToJFnwHQkMcfI7VpZeQffTQKC6ORTW+O
         w5GprmcLL3w4VBMV2Bqv/OK2wX1nuR2DPMJ4w6NyHJBR71RBMqj8sAGUTIrngINtPLop
         5cHOr2CQ+sOIH9qdrwWXr47MFI65Bv24jr233oG++EeEMVeR7YvUEpon9kFCgkesVM2t
         +Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691499; x=1701296299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4w9WGlpV+oKNURgCWJmbzMqmytRuxi/IH9HmVAy3vpk=;
        b=EV8inh10n1MN8K6MFmkAAKehjNFKQPw95QqiHs4c6belvfKiqbFKgWySqEhmqhKega
         o+sfex6+//UpiQpjvhzMZeAMf7lnX5/n40N+2SkJITNIPFsxzKwc3EGEaQcCVN+KlUOx
         MY57eNOeh4P4JBdEQNnHHYOdsBWgMRHsg+89g2+3apWA9+IlNwEnfalzqq6ubrX1rCHm
         f7gNCwLlwVsWWTXPOoJ/EvtIWKSwDkL0pw9EGU9mvi8MCsI99Pxe2gIahDwDGVW0ex4o
         OjGqCV5RJ0YnNHZVVN69QplpuSBBmTDge/UmTwINXxMCW8TyA70W6rgqqeGcypsm7Mqo
         xJzA==
X-Gm-Message-State: AOJu0YzKMqXaEvTo8qU9KaW35+D5wq8FZuYGz6csCtA7AmlRrqePikdh
        OCXMUUYkJLMOQYljL17vONxCPzQkhE/cvY4=
X-Google-Smtp-Source: AGHT+IG54JttGHSjosEsnKPFeVl+fooXKq2oDvdN1dMIWOZPhtgFkwHAj5sBQjrhm2bagm5ylk2hcpT6Ihrmh0Y=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:26dc])
 (user=jsperbeck job=sendgmr) by 2002:a0d:ca0e:0:b0:5cb:9a67:8b7b with SMTP id
 m14-20020a0dca0e000000b005cb9a678b7bmr123886ywd.3.1700691499640; Wed, 22 Nov
 2023 14:18:19 -0800 (PST)
Date:   Wed, 22 Nov 2023 22:18:18 +0000
In-Reply-To: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
Mime-Version: 1.0
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231122221818.781387-1-jsperbeck@google.com>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
From:   John Sperbeck <jsperbeck@google.com>
To:     tip-bot2@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        peterz@infradead.org, rui.zhang@intel.com, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a platform with both LOCAL_APIC and LOCAL_X2APIC entries for
each CPU.  However, the ids for the LOCAL_APIC entries are all
invalid ids of 255, so they have always been skipped in acpi_parse_lapic()
by this code from f3bf1dbe64b6 ("x86/acpi: Prevent LAPIC id 0xff from being
accounted"):

    /* Ignore invalid ID */
    if (processor->id == 0xff)
            return 0;

With the change in this thread, the return value of 0 means that the
'count' variable in acpi_parse_entries_array() is incremented.  The
positive return value means that 'has_lapic_cpus' is set, even though
no entries were actually matched.  Then, when the MADT is iterated
with acpi_parse_x2apic(), the x2apic entries with ids less than 255
are skipped and most of my CPUs aren't recognized.

I think the original version of this change was okay for this case in
https://lore.kernel.org/lkml/87pm4bp54z.ffs@tglx/T/

P.S. I could be convinced that the MADT for my platform is somewhat
ill-formed and that I'm relying on pre-existing behavior.  I'm not
well-versed enough in the topic to know for sure.
