Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C1E7992A3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245662AbjIHXFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjIHXFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:05:45 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258CB1FEA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 16:05:41 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-34e1ddc38c6so8897175ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694214340; x=1694819140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LvlWMVxCyv+zi38Xl3VaIYCEHxmB3dP1Hy1CKA8S0RE=;
        b=3bOldav7wZ/OG6ZW/IYlEMM7NgMwqPQrpY1wnIRdO5Scd7YUH5vUcLV0pfAvwzyp5f
         YFqno1xpHhGanUaN/sUGp1c1SYcJmm4PU8+mDYZKP9hQWUG2hi1FnHJi9wVns/mJp3Nv
         YtjbqKQh4vbJRz57gQUWGhS06Oi7CSZX6Piwx6lyJ0Qak46NzJ7OrEPfxZIKOjyZG46B
         UfrEuG6VlbnAdRchMf03XsnEpsT8dDZwzFexwWCu78ROkHllUz2fvUKvUp9qrietx5cG
         ijc+XGTCTMKF1eHIC6Rda5PCdU1/RTfCs4in4F3IKpvGdgCzkfyaUmRg+VcgTV/uVUdk
         bWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694214340; x=1694819140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvlWMVxCyv+zi38Xl3VaIYCEHxmB3dP1Hy1CKA8S0RE=;
        b=tn4ka2nZkjM5kQTy+uUu2IxHFL7xY3vzj2OtQqh6SLrS7xa+TJrDJvh0yjGiq1fN5w
         2mk3pLWGgvz7TL+ZnRxbLE6a3DW/xwP/To6Bfu+LzOG5NTrqT/QFemUZSQn87hm+sO2O
         R+qpgn8sNsN9lu1eGx5RgqkwQWjRdE9nhHOlBHbGikRZNfJC9+b+40X0XdXhcAep+Ja7
         4eQ1T6SxiolFheKfKhwQyRkj1GaiO446LIqm/JLCIHV9IOJhguiPrCaj6jrAnmCijeg0
         5nGd7qSPi/9sMbJ2hdAUJu3pEFSzjMnnRkmxFSG23WTF3UBtrnJx8pWxYgW2uU+cHLXH
         RIeg==
X-Gm-Message-State: AOJu0YyHygDImzZhSEd2dRLy5GIR0AWM3mOjBhETul5pRnWbeNGFwVhD
        TN7qSJAjXukRTaFx6zqKz5AuLw==
X-Google-Smtp-Source: AGHT+IGzIwsIjpI1ULRJ3Bzodv5Gi5NcWFQplZ7Zlt1hgPtuKzRS1ZDpiOKlBLZjJkaQ3kzbl7om2Q==
X-Received: by 2002:a05:6e02:2165:b0:348:dba4:6418 with SMTP id s5-20020a056e02216500b00348dba46418mr5333591ilv.6.1694214340537;
        Fri, 08 Sep 2023 16:05:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id x20-20020a656ab4000000b00574164301d1sm1392670pgu.47.2023.09.08.16.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 16:05:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qekXg-00CfA8-30;
        Sat, 09 Sep 2023 09:05:36 +1000
Date:   Sat, 9 Sep 2023 09:05:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZPuowDDMOP6Pl/Sz@dread.disaster.area>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <20230906222847.GA230622@dev-arch.thelio-3990X>
 <202309061658.59013483F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309061658.59013483F@keescook>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:03:06PM -0700, Kees Cook wrote:
> On Wed, Sep 06, 2023 at 03:28:47PM -0700, Nathan Chancellor wrote:
> > Hi Kent,
> > 
> > On Sat, Sep 02, 2023 at 11:25:55PM -0400, Kent Overstreet wrote:
> > > here's the bcachefs pull request, for 6.6. Hopefully everything
> > > outstanding from the previous PR thread has been resolved; the block
> > > layer prereqs are in now via Jens's tree and the dcache helper has a
> > > reviewed-by from Christain.
> > 
> > I pulled this into mainline locally and did an LLVM build, which found
> > an immediate issue. It appears the bcachefs codes uses zero length
> 
> It looks like this series hasn't been in -next at all? That seems like a
> pretty important step.
> 
> Also, when I look at the PR, it seems to be a branch history going
> back _years_. For this kind of a feature, I'd expect a short series of
> "here's the code" in incremental additions (e.g. look at the x86 shstk
> series), not the development history from it being out of tree -- this
> could easily lead to ugly bisection problems, etc.

I disagree entirely.

One of the most valuable things we have for XFS is a complete change
history going back to the first commit in 1993. We don't have all
that in the kernel git tree - that only goes back to 2005. We do,
however, have a separate git archive that runs from the initial
commit in 1993 to 2008, and so we can track bugs and changes back
all the way to when they were first introduced.

I'm looking at something in that historic XFS archive every second
day; understanding the XFS code and why it is like it is requires
looking back in time on a regular basis. And because XFS engineers
have been really good with commit messages for a really long time,
there is a lot of information in that historic archive that is
simply not documented anywhere else.

So if we have the full history of bcachefs developement sitting in a
git tree, we'd be *utterly stupid* to discard it when merging it
into the mainline tree. Nothing else documents the reasons for the
code being like it is right now better than the change history of
the code. For people trying to understand the code or trying to
perform root cause analysis of a bug, a complete revision history is
a rich gold mine full of valuable nuggets....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
