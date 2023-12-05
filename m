Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519678061A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346277AbjLEW0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346638AbjLEWZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:25:49 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CCD181
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:25:55 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33350fcb2c7so109649f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 14:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701815154; x=1702419954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlRvcm7L+cBAIszdYTxuMdD16SmRomd1bg4ss68VhyI=;
        b=hWbA1Hj0zQde/j+2EwawUBS0XHnLSu/c82WtM7myLO+MXlqhjJHhTSNFyKTEqgvgDR
         aZPAa4Dgd9Gys0QrX/SYaXHHndDSEYUfHp9gl3hBYWKr1SOtcu9hL5pdAAf3N8x8f4oV
         Gr5x+pMoW6F/nNJ6EhSgHliJY1OoISW3LHsK8Z1/7wxPFe9dscWJfB4LTYz2/RF6elTp
         Qk8DpnxlYtsOsTSEt07QZCHkR3VOrLeLPPpTGvxayqCrh3EitqO//zuambyQTrl3Lk4T
         6RIa6AGNzWHws4pIdszu6NvX8fLiXTtDmDG2KcQ88GRvXk2kPB90PwxQFsN80cr8YZIO
         NlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701815154; x=1702419954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlRvcm7L+cBAIszdYTxuMdD16SmRomd1bg4ss68VhyI=;
        b=XdsSYiNUj8HSlOau50KD1jjn9XX/RXF90x6sqbRIk8NmL2d2nzEg5pzaIRoPWL0nKc
         X4GTOaznujwpHENEkcgKYXt9ETlbGartyalrOA51tgDG407q0r9gsf2grKkOlWJNWRfB
         /j0IVqspFirZkwqVAM857SgWF9StcZsfC5y6Lw4bvAFOaSgTsdsQaMFPuKTONYnMDs5W
         6LQTF2ZsbQ8JixJGw/8n3llh6YZEw1UFBesGtdeFSAfOCGbxJfCGKbLqrJxtGkHrpx4x
         l8vRZLQPYj6vu6ZyA8o2S11eeGjrVFsMJzUJHS8YtNU1WcD9VRDcZjWcO7W1yC4afOIy
         Kkfg==
X-Gm-Message-State: AOJu0Yx0btV54qoTTAD6d3d+kwT8u8R6VTM7Xb37io3Lwl+Vb97YPUfV
        kCYQm/DgmyvQZnExFyF1yUOUbhkfS4qCHYAV+JPuP6ZtpwVgpnXEcFnWZA==
X-Google-Smtp-Source: AGHT+IHF7C4eMuQFihFrv8+8ynBjYGzdmiqKV5qMKe3JCWHAeoQ6T/vXYIaLbgU2DeTIXJ8mWuYYqhOravlOhhfavug=
X-Received: by 2002:adf:ed12:0:b0:333:2fd2:813d with SMTP id
 a18-20020adfed12000000b003332fd2813dmr4815585wro.90.1701815154097; Tue, 05
 Dec 2023 14:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV> <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <ZW-d1NZRIvmJlfcW@smile.fi.intel.com> <34e27c57-fc18-4918-bf44-4f8a53825361@infradead.org>
In-Reply-To: <34e27c57-fc18-4918-bf44-4f8a53825361@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Dec 2023 14:25:43 -0800
Message-ID: <CAKwvOd=bZvLz4yRqet6Hv2O9iZYfGr=xiwfk+-MAasPjK7XnWA@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 2:10=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> I have an unpublished Linux Best Known Practices txt file with
> this "rule" and some other info that I have collected over a few
> years. I wouldn't say that it's up to date. Anyway, it's copied below
> FWIW.
> Generic drivers should not (do not) #include header files from
> <asm-generic>. Only arch code and arch-specific drivers do that.

Ok, that confirms my understanding.  We had picked up on that
convention, but had missed the one below.

>
> Don't use <asm/header.h> in generic driver code. Instead use
> some <linux/header.h> that then #includes <asm/header.h>.
> asm/ headers are implementation; linux/ headers are API.

Ah, yeah, that's what we missed.

---
You should publish you doc somewhere, it can be helpful to refer back
to them when you're on a different machine or to point someone else
to.

I keep notes like this myself for debugging LLVM:
https://github.com/ClangBuiltLinux/llvm-dev-conf-2020/issues/3 (and
recently gcc: https://github.com/ClangBuiltLinux/llvm-dev-conf-2020/issues/=
4)
--=20
Thanks,
~Nick Desaulniers
