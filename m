Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A339C782DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjHUQJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbjHUQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:09:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB05109
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:08:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68a3cae6d94so1461065b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692634139; x=1693238939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaHdRkYkPRI69aZ/lmvZ478sSBPpifQtYAZYN/ChpUk=;
        b=BfhKszstxVugd4QaXKP6AKbVdheAmpXmwLBTkJkrEwF1b9tdmdhyJQ1wCjiHwI2uJh
         2cx+mg75Wn7zmMvD+fACBuuJktjZRPWKtGdCxWDjXEQ0BHRCcLR3p7uPKpxsf7tTPi4Z
         4o9xjU5MXBWcKouKHQqe+4hhOhZ3Kl9uQT44k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692634139; x=1693238939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaHdRkYkPRI69aZ/lmvZ478sSBPpifQtYAZYN/ChpUk=;
        b=YqaXj7cKR1YFBWSoLsojMnkylqxfLIxjhPXywSldLfjU60rWxz2RlijXfF+F0N4nCy
         arv3Ele89Pj2D6oWyfhfChvX3hLF3SAYK81fIIW34/+aZQ32PLe0oRkGBMMD9y/y4EGb
         mm/nGy+iotG50XeBNnEqRII7oN8pzqxk6TkbKxK/EA63cC9APZ2i+S/8QA7EHPWdTpeZ
         UdR1hbPnl7oUWMjYVJoxMgJUFoO+8726leC/S0HSLDZDsFg9/B3RUIQaGsBZxnaXObSx
         fBkbZeOcZkppFqqNp0Gi6wd6BdC8d3aGBWYvCrRLmJv8fPflRMcAzgXhFOWy7/cK0nI2
         g2sw==
X-Gm-Message-State: AOJu0Yw+o4EwvjVwPmBGsmwS+GnPza+5dWAvIZKOYVSSGYTKmuM8MS7q
        GKKeb8ZGs2IoVjbMfk/W2cI5LA==
X-Google-Smtp-Source: AGHT+IEOgTyR4jaB6XtqhahHvy0ziUqApkFMs3XvCv9+1wdEIAaSHh7YR1f9BPyQSwl9uXmMQ9DBEw==
X-Received: by 2002:a05:6a00:234a:b0:688:11cc:ed88 with SMTP id j10-20020a056a00234a00b0068811cced88mr9337228pfj.33.1692634138793;
        Mon, 21 Aug 2023 09:08:58 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id v24-20020aa78098000000b006877a17b578sm6359010pff.40.2023.08.21.09.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 09:08:58 -0700 (PDT)
Date:   Tue, 22 Aug 2023 01:08:53 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
Message-ID: <20230821160853.GA3913@google.com>
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com>
 <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
 <20230820072119.GM907732@google.com>
 <20230820073332.GN907732@google.com>
 <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/21 21:27), Masahiro Yamada wrote:
> > +       const char *list_missing;
> >
> > +       list_missing = getenv("KCONFIG_LIST_MISSING");
> 
> 
> My (original) hope was to add a single switch, KCONFIG_VERBOSE, to address both:
> 
>   - A CONFIG option is hidden by unmet dependency (Ying Sun's case)
>   - A CONFIG option no longer exists  (your case)
>   - Anything else we need to be careful

So I see a "no longer existing option" as a terminal condition. In
general there is no point in continuing the build because the build
will not include some driver/functionality that is still expected to
be there. (This has actually happened to us).

[..]
> > @@ -482,6 +490,12 @@ int conf_read_simple(const char *name, int def)
> >
> >                         sym = sym_find(line + strlen(CONFIG_));
> >                         if (!sym) {
> > +                               if (list_missing) {
> > +                                       conf_warning("unknown symbol: %s",
> > +                                                    line + strlen(CONFIG_));
> > +                                       continue;
> > +                               }
> > +
> 
> 
> This should be warned only if (def != S_DEF_AUTO),
> otherwise the same warning will be displayed twice.

Good point.

> > @@ -530,6 +544,13 @@ int conf_read_simple(const char *name, int def)
> >         }
> >         free(line);
> >         fclose(in);
> > +
> > +       if (list_missing) {
> > +               if (conf_warnings)
> > +                       exit(1);
> > +               exit(0);
> > +       }
> > +
> 
> This is something different because you are making these
> errors instead of warnings.

Right. So "verbose" and "list missing" probably have slightly different
requirements.

When "verbose" complaints about a downgraded option, for instance, then
you can regenerate the config and continue, because the symbol is still
there.

When "list missing" complaints about an option then we should stop and
investigate. That option, for example, can be added by build infra based
on some USE flags switch, etc. So there can be multiple parties that
needs to be fixed. Apart from that we need to figure out what option
(if any) replaces the gone symbol. "list missing" is basically "missed
expectations", we need to do some work before we can build the kernel.

I can "list missing" under KCONFIG_VERBOSE. It probably still better
error exit if missing symbols are found. Thoughts?
