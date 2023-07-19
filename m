Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D12E75901D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGSIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:21:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA21B6;
        Wed, 19 Jul 2023 01:21:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so60998365e9.3;
        Wed, 19 Jul 2023 01:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689754867; x=1692346867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=siK4OSk/ePA2geNjaLPDhLD4PkEcMUYKPlRGf5Gu9SM=;
        b=BKVgWb2uTivagtIl+FbELcI5E/MTncxi8pqlBhFtF/9csNkVmuoMb0rnZ5OEj2Suv7
         fmeS7yn4+/aJv+tbiejfkqG82O4mHod1S1A+DXRggkS+b/vBev0xe007qJQJDf84kjI5
         yWelJpVqdYm1ci/HKnRD50nWmWg1Wopxc/1c/GMW4jK5w8mms7vz753YKjassWGcLgzy
         a4zmZUBQasd7Or/b+ZFoncsWuYdyY2mGqV36rkI4FjZygXmR+QcD0oOUebX7t4FXVJ9z
         98IoYu9UvIz/3OY21LYrOK0cxC7eoXo/lo7Uloia1cx/XhqhCjMoaAUc1Sw3OxGkO9zz
         Zdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754867; x=1692346867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siK4OSk/ePA2geNjaLPDhLD4PkEcMUYKPlRGf5Gu9SM=;
        b=ZoO8bBZh2nRBCx2AIwAyURiROeFas/keab7/gvIz+DZyS1SVwaj32bv6q8yG1JKxkO
         0wbrt9Y1SPqZZeYW+f6OpRUWsOYIiTIFtUNDC8L7Urccn32jmXr1bdsi61bNLfHW1sh5
         bRZEP98VA3dSZpTDnKzd6gWjwlZu+JoOSwWQWFbjvDOMwqwv/j4UW5ogpAM6rOilqYIC
         z5GtHM8pfWrMH8UAYV+aXQVGyVhrinpJD9lAgWf4B9+jIzx8mvITaG0dVpP5AORPqHjo
         IXOVSJAEZEUg7XExLuLNZvHlCIqPWy7ry85UEAF3fKIpjw5m7uFnK9PbLu1KbC4j21Dq
         nevw==
X-Gm-Message-State: ABy/qLYfatuFrhuRx/zVtxDyxRVQgGiTJALzKWDHw1EuP/kOrYyXX904
        auACXejCyuNjGdo0lwZoRnH3KlGzQrOFk79hI/gjxh7KrygTEA==
X-Google-Smtp-Source: APBJJlEMYzsVW7aXyNVPWHwTQFSclAxIY+S7U96tWP5PKGFiKi68A1ED1/ehLtPDMuN0aGAqqr00Tl7Ee1vgyAtcKSM=
X-Received: by 2002:a05:600c:224b:b0:3fa:d160:fc6d with SMTP id
 a11-20020a05600c224b00b003fad160fc6dmr1302292wmm.30.1689754867235; Wed, 19
 Jul 2023 01:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221219055431.22596-1-ashimida.1990@gmail.com>
 <20230325081117.93245-1-ashimida.1990@gmail.com> <202306211451.CB0A34563@keescook>
In-Reply-To: <202306211451.CB0A34563@keescook>
From:   Dan Li <ashimida.1990@gmail.com>
Date:   Wed, 19 Jul 2023 16:20:55 +0800
Message-ID: <CAE+Z0PFtqKf9EM+u8V87TPo87jbGXz20VQvx0JvDHTdT8Xp+Pw@mail.gmail.com>
Subject: Re: [RFC/RFT,V2 0/3] Add compiler support for Kernel Control Flow Integrity
To:     Kees Cook <keescook@chromium.org>
Cc:     Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

Sincerely sorry, I just saw this email.
Embarrassingly, due to another job change, my plan was postponed again :(.

I may not be able to attend this year's GCC meeting. Is there any other
way to let this get some traction in GCC? I really hope someone can help
with this topic.

BTW, I'm still looking at this and plan to finish it by the end of this
year, but it's taking too long and there's a lot of uncertainty, so
please just consider this only as a backup option.

Thanks,
Dan.

On Thu, 22 Jun 2023 at 05:54, Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Mar 25, 2023 at 01:11:14AM -0700, Dan Li wrote:
> > This series of patches is mainly used to support the control flow
> > integrity protection of the linux kernel [1], which is similar to
> > -fsanitize=kcfi in clang 16.0 [2,3].
> >
> > Any suggestion please let me know :).
>
> Hi Dan,
>
> It's been a couple months, and I didn't see any other feedback on this
> proposal. I was curious what the status of this work is. Are you able to
> attend GNU Cauldron[1] this year? I'd love to see this get some traction
> in GCC.
>
> Thanks!
>
> -Kees
>
> [1] https://gcc.gnu.org/wiki/cauldron2023
>
> --
> Kees Cook
