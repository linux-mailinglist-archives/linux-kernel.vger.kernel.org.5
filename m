Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2665E799A5B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjIISKT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Sep 2023 14:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjIISKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:10:18 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53121B0;
        Sat,  9 Sep 2023 11:10:13 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3a8614fe8c4so2248805b6e.1;
        Sat, 09 Sep 2023 11:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283013; x=1694887813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7stfKXPrGgmPuohhEH9AzgMJornHPnvxS8cyO4wLhws=;
        b=eZhA5n5fmWLK+jtK6R5ziKo4fwYU06D1AnrzHe4jWOKDx6UmNb+aZn2gejnGWSw+uC
         3tTV/4pgYRl8Vp0KVJdyGidOWiCcym9v8jQeHTT+bmqCz/Uc/FuRpGuDMJZBkV1p8IR2
         /baVNhO7OE/BRWMxu3f/hXPTnFqs633fjOhm+l+APfuMV0oFwIFJLi0BfedRvXQawdM5
         X+/ZxXtiyg/NugG0j/Gyxkwb49qHbVW7fDmxvk6FiHtIIGx+jWXIMpigtjdwbjRVGUyl
         o8H5QZixKUG3n7tlXcr/iGsVXF4prjoC7xb4a4jgQjBD0O2vFWJx3FFVjfoIvaQu6nGS
         DtSA==
X-Gm-Message-State: AOJu0YwyR1rEzAI6pQ/qzvqLVR80urmCC0oW9JKU/J61feB82QZnKVHH
        ZkHaZEh8luhv3DfqobSO7jGIZiiqpmKA/A==
X-Google-Smtp-Source: AGHT+IEuU7mBVu0vnJIWRYkJQXj6MMxIHxi95tf2YHOMFTozYWwl5gSz0ku+u0OeDL0J8eJfakW7gQ==
X-Received: by 2002:a05:6808:14d0:b0:3a8:5207:1d88 with SMTP id f16-20020a05680814d000b003a852071d88mr7712706oiw.49.1694283013039;
        Sat, 09 Sep 2023 11:10:13 -0700 (PDT)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id q4-20020a0568080a8400b003a37372e6b2sm1789899oij.21.2023.09.09.11.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 11:10:12 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5734b893a11so1991031eaf.1;
        Sat, 09 Sep 2023 11:10:12 -0700 (PDT)
X-Received: by 2002:a05:6358:7249:b0:134:cb65:fbbe with SMTP id
 i9-20020a056358724900b00134cb65fbbemr8198881rwa.13.1694283012561; Sat, 09 Sep
 2023 11:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230909161851.223627-1-kernel@jfarr.cc> <CAMw=ZnT-Ck-Y4i-MZAf99U5nzgDaj-q8UPRH_c00JgGMtUy_QA@mail.gmail.com>
 <5c94f7f4-697f-4388-9243-009c0c2d745f@app.fastmail.com>
In-Reply-To: <5c94f7f4-697f-4388-9243-009c0c2d745f@app.fastmail.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Sat, 9 Sep 2023 19:10:01 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnShMzqH_yiXCS0-O+yR0RZs7+sSm0rqSYwpoygcYdg6hA@mail.gmail.com>
Message-ID: <CAMw=ZnShMzqH_yiXCS0-O+yR0RZs7+sSm0rqSYwpoygcYdg6hA@mail.gmail.com>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
        lennart@poettering.net, systemd-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Sept 2023 at 18:58, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> > - the cmdline section is actually optional, just like it's optional to
> > pass it on a traditional kexec load, so it should be used if present,
> > but skipped if not
>
> Should be an easy fix.
>
> This should be updated in the UKI documentation as for other optional sections it's explicitly marked. I assumed that in the case of an empty cmdline the section would still be included but empty. Or is that semantically different: empty .cmdline section -> no cmdline allowed, no .cmdline section -> user can specify cmdline in bootloader?

Yeah the doc is wrong, tools handle it as optional, fixing the docs:
https://github.com/uapi-group/specifications/pull/72

> > - the dtb section also is optional but supported, and given kexec
> > supports loading a new dtb I think this change should support it too
> > immediately.  Moreover, we are adding support for multiple DTBs in a
> > single UKI (by simply having multiple .dtb sections, and picking the
> > one that matches the firmware), as a stretch goal would be nice to
> > support that too, but it can also come later
>
> As far as I know dtb is not supported by kexec_file_load at all at the moment. Maybe someone here knows more about this. I'll look into it.

Not sure about the specific syscalls, but I definitely use kexec
--load --dtb on arm64 with existing released versions of
kernel/tooling

> > - also what would it take to support arm64, which is the other major UEFI arch?
>
> I'm not familiar with UEFI on arm64, but I can certainly look into it. I assume it's not gonna be that difficult.
