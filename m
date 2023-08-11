Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5659677897C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjHKJLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjHKJL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:11:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518832D61
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:11:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe8242fc4dso8758945e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691745087; x=1692349887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=msB7XSMQKNAACWPZ/GwjszE60e79zmFAGxGoY+G/BRc=;
        b=xOeEvMhu065euw6JTBbCi3NKxbF/ibI3VYKQjJsXrN9eEzAcwPJa9ZnxTQ4z2asNNl
         6JO361GRMRLAA/RszIe37D1XCr3KY5GikzAht8IKRTkCGL1HuBWAVjX8uMv/uXUmdaEF
         ohsEPaFCEMuvHl7Hj7ImY++OTJHHmo00++qYLerpnk7AeTnwUoDqBokIfCxZVUOo1KHQ
         nr7U1Ygo3yHCNooJDk8UqFM/Nd7f6Nyf5UVqd4GYsgcbkQycExptlTRFpeau/CbUcmYu
         TlTjVMC/gUileFVwC++uirf7cUiAh+Hy3KU2OVxSmhLfUOx/srqqi4uydryT+0Uoz5sX
         Cg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691745087; x=1692349887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msB7XSMQKNAACWPZ/GwjszE60e79zmFAGxGoY+G/BRc=;
        b=EhQa0yKUfH8PsgI0Z7CFDSb/EZDWJ8hg4WtvfaVh5tbnnJylhFJmgUlVk67bUu3nZZ
         re1lOAbAvE2m/b+6cdywwN9/YRWAB421d6MwwRWRmCaqIGGmx+4GiSSFrPEO+GQpMV7s
         YZK2zkwUvLy4LPJ5Rk2PXSFNnPB7n7oTixL/y3OdF7zfT3QfXatbsUdaGGJUsnnltgXD
         TVSunZLNSPtJrVkzeR0eYrTc4yOV7Yca4AJhQMB1YN0zhNCgKkrOrtGBSuxeygum9E12
         UcZVKkBwrX5zz9kZPypXDWg0mvg8i9+C7UnlQPMse2FTqCH6cIbd0EK22tcJUBQ2Giyb
         v2bQ==
X-Gm-Message-State: AOJu0Yw1BX45T5oI7PSljs9mvNIbaxJbQyI+zORiF04IVJr5er9f9Myo
        3xHXeezvUnJNxd/zY3u2R8Byxzwi0YI79zP4lB7zBw==
X-Google-Smtp-Source: AGHT+IG0mmKs/Ojd86c5RsrBdtIz3U/1JKmzd/I7IPgCTgOgVi6XjJz1KDzwaNq3PIN/DCWY1JE0vE3/JbnwdiJ7T7c=
X-Received: by 2002:a7b:cbcc:0:b0:3fe:10d8:e7fa with SMTP id
 n12-20020a7bcbcc000000b003fe10d8e7famr1164390wmi.41.1691745086680; Fri, 11
 Aug 2023 02:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230808102049.465864-1-elver@google.com> <20230808102049.465864-3-elver@google.com>
 <202308081424.1DC7AA4AE3@keescook> <CANpmjNM3rc8ih7wvFc2GLuMDLpWcdA8uWfut-5tOajqtVG952A@mail.gmail.com>
 <ZNNi/4L1mD8XPNix@elver.google.com> <20230809113021.63e5ef66@gandalf.local.home>
 <ZNO/pf/pH5jJAZI0@elver.google.com> <202308101259.D2C4C72F8@keescook>
In-Reply-To: <202308101259.D2C4C72F8@keescook>
From:   Marco Elver <elver@google.com>
Date:   Fri, 11 Aug 2023 11:10:49 +0200
Message-ID: <CANpmjNN84DGUSutk1FxcVmPGDhgVa2PrOuFTzGYu92mv+WXUeQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] list_debug: Introduce CONFIG_DEBUG_LIST_MINIMAL
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 22:12, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Aug 09, 2023 at 06:32:37PM +0200, Marco Elver wrote:
> > On Wed, Aug 09, 2023 at 11:30AM -0400, Steven Rostedt wrote:
> > [...]
> > >
> > > I would actually prefer DEBUG_LIST to select HARDEN_LIST and not the other
> > > way around. It logically doesn't make sense that HARDEN_LIST would select
> > > DEBUG_LIST. That is, I could by default want HARDEN_LIST always on, but not
> > > DEBUG_LIST (because who knows, it may add other features I don't want). But
> > > then, I may have stumbled over something and want more info, and enable
> > > DEBUG_LIST (while still having HARDEN_LIST) enabled.
> > >
> > > I think you are looking at this from an implementation perspective and not
> > > the normal developer one.
> > >
> > [...]
> > >
> > > That is, if DEBUG_LIST is enabled, we always call the
> > > __list_add_valid_or_report(), but if only HARDEN_LIST is enabled, then we
> > > do the shortcut.
> >
> > Good point - I think this is better. See below tentative v4.
> >
> > Kees: Does that also look more like what you had in mind?
>
> Yeah, this looks good. My only nit would be a naming one. All the
> other hardening features are named "HARDENED", but perhaps the "ED"
> is redundant in the others. Still, consistency seems nicer. What do you
> think of CONFIG_LIST_HARDENED ? (The modern trend for Kconfig naming tends
> to keep the subsystem name first and then apply optional elements after.)

Naming is a bit all over. :-/
I agree with the <subsystem>_<suboption> scheme, generally. I think
initially I tried to keep the name shorter, and also find a good
counter-part to DEBUG_<suboption>, therefore HARDEN_LIST.

Let's just change it to CONFIG_LIST_HARDENED, given the existing
"HARDENED" options.

I don't have a strong preference.

> One note: do the LKDTM list hardening tests still pass? i.e.
> CORRUPT_LIST_ADD
> CORRUPT_LIST_DEL

Yes, they do. Though I need to also adjust BUG_ON_DATA_CORRUPTION to
select LIST_HARDENED, and the test should check for the new option
(which is implied by DEBUG_LIST now). There will be an additional
patch to adjust that.

> > [...]
> > +             /*
> > +              * With the hardening version, elide checking if next and prev
> > +              * are NULL, LIST_POISON1 or LIST_POISON2, since the immediate
> > +              * dereference of them below would result in a fault.
> > +              */
> > +             if (likely(prev->next == entry && next->prev == entry))
> > +                     return true;
>
> I'm not super excited about skipping those checks, since they are
> values that can be reached through kernel list management confusion. If
> an attacker is using a system where the zero-page has been mapped
> and is accessible (i.e. lacking SMAP etc), then attacks could still
> be constructed. However, I do recognize this chain of exploitation
> prerequisites is getting rather long, so probably this is a reasonable
> trade off on modern systems.

Sure, it's a trade-off for systems which do have the bare minimum of
modern hardware security features.
