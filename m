Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6A5788E83
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjHYSVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjHYSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:20:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1629A10D7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:20:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26f4bc74131so879847a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692987633; x=1693592433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYd1wVFPRI7NiM/Sx4/tad/ZtbY6g9sye8P5AXqu+fc=;
        b=E4mC5YAXMMgmUHgfRiWFcSZjAFYw1waD0EqZCNwtYhRSRtgJoFZVlCS3JG3wV7FXjd
         sXVU7RTKIYiV68OaJT+pNyPhtCG1CpcRdXA82AG5ofhhqR/vSGm3tvd1mpbR6M1weagG
         NwWQJu1Josu1pkUS1L/DPphW0b+C0Nzy+d45c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987633; x=1693592433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYd1wVFPRI7NiM/Sx4/tad/ZtbY6g9sye8P5AXqu+fc=;
        b=GFWgIah6RmjgHxb46wlyhCbtFABg1yTtWbRo60nl7DlXH6sAO77CgwgaQC+ygcKp+v
         5ZywVBdu30b0oHGjxYAOkGFDy+5A3C0d8+Zlxq7mXwyOw0nheMuh7oq98JUx47B1c3Ns
         PbxUyakPJiJKI4llBs69dIO55WcSKvptiCtpFXeBRMHtrEUjJoAcBU5fRx/PbMNAgimq
         XAUCHcVZadWfxb9AEsPFUuWs9H/Sja0Wm6Thh2nH60Jgf4izUZf1myYsizxcbme2XJhr
         W6mAuRH9UmN7PWL7eeB4E+QkIG0GGKpkbADbr+2CRyj5kmer+KhGD3holi0uZNRFksox
         b1xA==
X-Gm-Message-State: AOJu0YwkoZUOYIH6SMe8Ka8M6X8I7bWSx+GgYA0OWzuaWXKvT67clsEn
        Mqt89KaZ3DJpnM4sEH8lBKWpZA==
X-Google-Smtp-Source: AGHT+IF6DSGG+sLTemEr6zFswCsdJsrOmZC3VrMrE6v1fI8J4N4rJsVzak2qfPMHQ2MCnkGlwtuaPA==
X-Received: by 2002:a17:90a:c08d:b0:267:f8f4:73ab with SMTP id o13-20020a17090ac08d00b00267f8f473abmr28444155pjs.16.1692987633516;
        Fri, 25 Aug 2023 11:20:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090a628c00b0026b3f76a063sm1910536pjj.44.2023.08.25.11.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:20:32 -0700 (PDT)
Date:   Fri, 25 Aug 2023 11:20:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kbuild: Show Kconfig fragments in "help"
Message-ID: <202308251119.B93C95A3A7@keescook>
References: <20230824223606.never.762-kees@kernel.org>
 <21193a52-0425-f5ae-90f0-10e4c578ae90@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21193a52-0425-f5ae-90f0-10e4c578ae90@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 05:04:02PM -0700, Randy Dunlap wrote:
> Hi Kees,
> 
> On 8/24/23 15:36, Kees Cook wrote:
> > Doing a "make help" would show only hard-coded Kconfig targets and
> > depended on the archhelp target to include ".config" targets. There was
> > nothing showing global kernel/configs/ targets. Solve this by walking
> > the wildcard list and include them in the output, using the first comment
> > line as the help text.
> > 
> > Update all Kconfig fragments to include help text and adjust archhelp
> > targets to avoid redundancy.
> > 
> > Adds the following section to "help" target output:
> > 
> > Configuration fragment targets (for enabling various Kconfig items):
> >   debug.config         - Debugging for CI systems and finding regressions
> >   kvm_guest.config     - Bootable as a KVM guest
> >   nopm.config          - Disable Power Management
> >   rust.config          - Enable Rust
> >   tiny-base.config     - Minimal options for tiny systems
> >   tiny.config          - Smallest possible kernel image
> >   x86_debug.config     - Debugging options for tip tree testing
> >   xen.config           - Bootable as a Xen guest
> >   tiny.config          - x86-specific options for a small kernel image
> >   xen.config           - x86-specific options for a Xen virtualization guest
> 
> ISTM that you are missing the "why" part of this change in the commit
> description.

I want to see what fragments are available without needing to know the
source tree layout for their locations. :)

> "make tinyconfig" is the real target here.  The other (tiny.) files are just
> implementation details.
> We can't put all implementation details into help messages and it's not
> difficult to find that the (tiny.) config files are merged to make the
> final .config file.

Yeah, this seems true for much of the ppc stuff to, as pointed out by
mpe. I'll go answer there...

-- 
Kees Cook
