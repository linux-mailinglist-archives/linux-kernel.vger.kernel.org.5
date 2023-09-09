Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4D799A36
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbjIIRP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjIIRPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 13:15:55 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F49C;
        Sat,  9 Sep 2023 10:15:50 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d7eed15ad69so2913959276.1;
        Sat, 09 Sep 2023 10:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694279750; x=1694884550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUYhXiAroV4hg8ozsfWDxDiqQmJJcr1xhZd/suVLTSc=;
        b=bZLcy4FhVSyZxkeY3Jv9oCxuwJFcp3zTJf8EYW5iwBQ8nq95FhhaKTIma3WUntlLDM
         2/OhCrOpZO2MHJY7/oxYiDeKGlBx69zhz78Qm+oeVdsK7HM3gYhuWFJRY3VJepeRSZu8
         s/augKAE6+J6QLILkSfGHTpE1433DMBmBUriQH23tDsX4HQPneGfXS8UzPJ2zqNMFN2L
         7p+cLAz6fz0NKkdQ/1k7RJIeRjxt40kNXWgOtJJ1I19G9CfrFHR8P65vFl0Jzp06Oedz
         NMKZzM2E7B0CHSvG/oBjPKi/42+RiY8o8bywPB2KXnm6+HSqZLwDfb0AqN81VFiAgi1O
         tJMA==
X-Gm-Message-State: AOJu0Yw/I3min1SfaYviIq+zr078oPepPvSons79giOEiu2q4spSYoQa
        NpmMdrPyGBwq9PU205mYfnebeMkg5bNlgg==
X-Google-Smtp-Source: AGHT+IGHnOYFmpPB1GY+y3R3jPVjrcxXv0ELMunv7ZefBzCz3E3uQgJKgXqVZgzzA1G3H3PRDVK9jQ==
X-Received: by 2002:a05:6902:704:b0:d7e:7916:b41d with SMTP id k4-20020a056902070400b00d7e7916b41dmr7157976ybt.13.1694279749974;
        Sat, 09 Sep 2023 10:15:49 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id s104-20020a25aa71000000b00d7fcdc8e17dsm887072ybi.37.2023.09.09.10.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 10:15:49 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59b50b4556eso20444477b3.1;
        Sat, 09 Sep 2023 10:15:49 -0700 (PDT)
X-Received: by 2002:a0d:ebc4:0:b0:589:fbfe:fff1 with SMTP id
 u187-20020a0debc4000000b00589fbfefff1mr5703734ywe.10.1694279748861; Sat, 09
 Sep 2023 10:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
In-Reply-To: <20230909161851.223627-1-kernel@jfarr.cc>
From:   Luca Boccassi <bluca@debian.org>
Date:   Sat, 9 Sep 2023 18:15:37 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnT-Ck-Y4i-MZAf99U5nzgDaj-q8UPRH_c00JgGMtUy_QA@mail.gmail.com>
Message-ID: <CAMw=ZnT-Ck-Y4i-MZAf99U5nzgDaj-q8UPRH_c00JgGMtUy_QA@mail.gmail.com>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
        lennart@poettering.net, systemd-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Sept 2023 at 17:19, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> Hello,
>
> this patch implements UKI support for kexec_file_load. It will require support
> in the kexec-tools userspace utility. For testing purposes the following can be used:
> https://github.com/Cydox/kexec-test/
>
> There has been discussion on this topic in an issue on GitHub that is linked below
> for reference.
>
>
> Some links:
> - Related discussion: https://github.com/systemd/systemd/issues/28538
> - Documentation of UKIs: https://uapi-group.org/specifications/specs/unified_kernel_image/
>
> Jan Hendrik Farr (1):
>   x86/kexec: UKI support

Hi,

Thanks for working on this, it looks super useful and at Microsoft we
are definitely interested in it, as we rely heavily on kexec and we
are looking to switch to UKIs.

I had a quick look, two comments:

- the cmdline section is actually optional, just like it's optional to
pass it on a traditional kexec load, so it should be used if present,
but skipped if not
- the dtb section also is optional but supported, and given kexec
supports loading a new dtb I think this change should support it too
immediately. Moreover, we are adding support for multiple DTBs in a
single UKI (by simply having multiple .dtb sections, and picking the
one that matches the firmware), as a stretch goal would be nice to
support that too, but it can also come later
- also what would it take to support arm64, which is the other major UEFI arch?
