Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCF0806123
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346270AbjLEV5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjLEV5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:57:45 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F46C1B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:57:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3332fc9b9b2so127372f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701813469; x=1702418269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWmm3+4G7HJVcv2X2DUaAz47s+8+x8VIlkxgLxuapbQ=;
        b=QWkKs/UzIBRNkw4Ky1WwfXO6UppOzSgt5dWDbFssSLEb+cD18Hr1joGQDvomUy3CLd
         xuj40M6g0rxXufQ01ptoLcUdgHr4FPj+88b6HxhfZN0qNwLyKOk/7LQygMGTAJi/TFw3
         q8Gp2uEv+H2cVaQ52jPXAi6mE0ouOAafE0tIHD8zlsBfvKM0R6Dp1yxCyXy90J19ylde
         3Rw1olXX6F4ebOvfwSoDizeYBqyINu77y3VOqidWoJF4DfYskpSKdLvwehg+bxmFLRK5
         7YGN0VtbfFraYGyvDXjdQ8ikpborRF5nK6M4t1+gYDKDG4tjxHEOL1PvpYsoH2Y8faiE
         PIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813469; x=1702418269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWmm3+4G7HJVcv2X2DUaAz47s+8+x8VIlkxgLxuapbQ=;
        b=Dmb2HDf4gYLATIeBNryhduBxA/wB1U+gZh9kOrh+1k5u9ZK9GxeIdPnse/UFQK8bLw
         t4+Kc04vla+LdcLPIbJY9l9zzSSxLCVut+AhMeicwIiPM59QkOYKGVKTncNOMdIaSuL8
         1NWCvU7jwePOPW6xkQc8bW/c357hAFKlEBcAdH81zZpOcRpd4xsccLBW3JjmHgqOzZT9
         UIM0HUYerEQSo/pAn09GOXP9M6kOgZrKwgxNuGVCmfew/c7ckHR+Xk4sdShvVebNynai
         cmf+NbHT4gh2N/b4znGt6ESaE9GWdk0cl7z5PC3er84C4g8kKx08np6y2Cmzny1ag4/B
         QlGQ==
X-Gm-Message-State: AOJu0YwxqwsFUNlRAwkFzJU9vgGCf07/+YOvg1O8wx6nh9FxAx7IlMH3
        v5aEp/YpcqI2pmgygRQMI4qEqanmE2mi++JlPZNACg==
X-Google-Smtp-Source: AGHT+IEpGt6sfF3ndmcMCRvGxlKhVICniUpy6Xq7r6eo+/mxjFz3D+cUv+CWgFch13RwDQLHwQYzlcBK9dkUW5r0FZQ=
X-Received: by 2002:a5d:5949:0:b0:333:3cb9:8a54 with SMTP id
 e9-20020a5d5949000000b003333cb98a54mr1638687wri.189.1701813469476; Tue, 05
 Dec 2023 13:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
 <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com>
 <20231205132452.418722bea8f6878dca88142a@linux-foundation.org>
 <CAKwvOdn=og6h5gVdDCjFDANs3MN-_CD4OZ9oRM=o9YAvoTzkzw@mail.gmail.com> <20231205214359.GF1674809@ZenIV>
In-Reply-To: <20231205214359.GF1674809@ZenIV>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Dec 2023 13:57:38 -0800
Message-ID: <CAKwvOdki0aUFLOgEhDxtHdHk_6x7WZdt3k2rSCxTB5hkPfKYWw@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 1:44=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Tue, Dec 05, 2023 at 01:39:47PM -0800, Nick Desaulniers wrote:
>
> > The tooling Tanzir is working on does wrap IWYU, and does support such
> > mapping (of 'low level' to 'high level' headers; more so, if it
> > recommends X you can override to suggest Y instead).
> >
> > arch/nios/ also doesn't provide a bug.h, which this patch is
> > suggesting we include directly.  I guess the same goes for
> > asm/rwonce.h.
>
> See include/asm-generic/Kbuild:
> mandatory-y +=3D bug.h
> ...
> mandatory-y +=3D rwonce.h
>
> IOW, sh will have asm/bug.h and as/rwonce.h copied from asm-generic.

Ah, right, Ard had mentioned this file to me once.  And mandatory-y is
documented in Documentation/kbuild/makefiles.rst.

Ok, so we can use include/asm-generic/Kbuild to know that if the .h
files listed there are recommended to include as asm/*.h, then we
should replace that recommendation with linux/*.h.  Our tooling has
something where we can automate that.

>
> Still, includes of asm/*.h had been a massive headache historically
> and breeding more of those shouldn't be overdone.
>
> More painful problem is arch- and config-dependent stuff, though...
--=20
Thanks,
~Nick Desaulniers
