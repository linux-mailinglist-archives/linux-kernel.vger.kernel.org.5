Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEACB7B097D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjI0QBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjI0QBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:01:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E223F139
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:01:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c62d61dc96so34909155ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695830500; x=1696435300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n15H0FheNa3mqwmWOOLwdjuLknHFCZpBdaYFxw9dy2I=;
        b=Gvj/rZAPooCRMXaXBC7k1XyqIv+TVI2aYApHIVeH3g4ip/PdkFuSS2fJ17G+xfZSqz
         PL3QeXSmn6Nr3EoZ/FXYvd/e8TGrTucVSO9a2bBJNj7nbYtJpgzFuHplewIgxNs8L8HU
         Z3S50JwcjkTVdZsrQOvFSy/0xQ3k+noV1Zfso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695830500; x=1696435300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n15H0FheNa3mqwmWOOLwdjuLknHFCZpBdaYFxw9dy2I=;
        b=RjmmEGtm+Hb/XCOU0W6+qMxIXGwfxAAhBWhSoyCNGCDtRgoVs05rtXCwn2z3vyz3LT
         zYCvNCPB5zJJYvDJesapWPbR6zjLU6d+nbpwC/uXBiHIXxxhVuJo9yC32eut/5lqtsDA
         x+2r97GSJnBn9fQpfnMwQyHZQmIAgZrytUSUE8CwWXMZEilV2PHc3qb1Ap0DaFl+6PMH
         1m2rD6QGQorNHWESnaU9dBbWST/7czO+ZdXFgitIY4IRIz1d4M4jtl4wc1ndPhG63q3M
         8k0WqnCeaiXwHEP07OJ+bqmMEGZPy+vqJQR9mxgwJWeWh5iIMQ+yTIq6s82MizmaDbqW
         86IQ==
X-Gm-Message-State: AOJu0YyVu1dc8G+XFHvhnCgMdU0G7mx6NcZRfxBCsCdAi0x0P/4CBlLV
        yrZ6YjzdDx1M172O+BiQAb7A7A==
X-Google-Smtp-Source: AGHT+IGrBR+utDzRL8afQeGJmUYEVj5u/kadJGYYsKrk0xcLszK9da5IGy/cQqmOdKo3WGrF094bUw==
X-Received: by 2002:a17:902:c14c:b0:1c5:bcdf:fe93 with SMTP id 12-20020a170902c14c00b001c5bcdffe93mr2094485plj.27.1695830500304;
        Wed, 27 Sep 2023 09:01:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001c6092d35b9sm8399659pla.85.2023.09.27.09.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 09:01:39 -0700 (PDT)
Date:   Wed, 27 Sep 2023 09:01:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH 0/3] get_maintainer: add patch-only keyword matching
Message-ID: <202309270859.B83F72E179@keescook>
References: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
 <CAKwvOdn4wwaBYzddLuXunjvCyH7HU8Brds-ZCYzsSxsAg4275Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdn4wwaBYzddLuXunjvCyH7HU8Brds-ZCYzsSxsAg4275Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 08:24:58AM -0700, Nick Desaulniers wrote:
> On Tue, Sep 26, 2023 at 8:19 PM Justin Stitt <justinstitt@google.com> wrote:
> >
> > This series aims to add "D:" which behaves exactly the same as "K:" but
> > works only on patch files.
> >
> > The goal of this is to reduce noise when folks use get_maintainer on
> > tree files as opposed to patches. This use case should be steered away
> > from [1] but "D:" should help maintainers reduce noise in their inboxes
> > regardless, especially when matching omnipresent keywords like [2]. In
> > the event of [2] Kees would be to/cc'd from folks running get_maintainer
> > on _any_ file containing "__counted_by". The number of these files is
> > rising and I fear for his inbox as his goal, as I understand it, is to
> > simply monitor the introduction of new __counted_by annotations to
> > ensure accurate semantics.
> 
> Something like this (whether this series or a different approach)
> would be helpful to me as well; we use K: to get cc'ed on patches
> mentioning clang or llvm, but our ML also then ends up getting cc'ed
> on every follow up patch to most files.
> 
> This is causing excessive posts on our ML. As a result, it's a
> struggle to get folks to cc themselves to the ML, which puts the code
> review burden on fewer people.
> 
> Whether it's a new D: or refinement to the behavior of K:, I applaud
> the effort.  Hopefully we can find an approach that works for
> everyone.

Yes, please! I would use this immediately -- there are a bunch of places
where pstore, strings, hardening, etc all want review if certain
functions or structures are changed in a patch, but we're not
maintainers of the files they appear in.

> > Justin Stitt (3):
> >       MAINTAINERS: add documentation for D:
> >       get_maintainer: add patch-only pattern matching type

Can we squash these two changes together, and then likely add some
patches for moving things out of K: ?

-- 
Kees Cook
