Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DF4756946
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjGQQgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGQQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:36:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B901B6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:36:01 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a412653352so2931778b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689611761; x=1692203761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA/iWGM5jVgrQTgVAP1T1MYlEj/+DU3uJ2eHPJePb2Y=;
        b=NzeOCLYrZJ1CPIeDNJPnTwQul1uiwgBoWc5uHedLi3ZzTY+tKjXEdHRxmPfdYGw4Yt
         rpu00HY7+EsiFSloYywPdV1Py/E2Yrsz0+6tP+gOmvRBmtXba/UEcInUfJDHUUt2OAV4
         Zmxd+cx0bLNrEXyhV2D5z9nP5B0ny0sKKTSVuB5yE0QBcarnNSYBeqUY1BY1v3wNNj2z
         tQ9XSklQHVI+OyBBrR+D3vYhfiU0sGJwlyHI3ynnqyIwyGuPxG7EtpYc6YTKB4eMOEmt
         kY6A9nJisyR8QWOJdvwq1r8taOhb3TG90AGVxUPYQ0ZEhtrr1kspvML2xxvKPQAyHIrp
         W8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611761; x=1692203761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA/iWGM5jVgrQTgVAP1T1MYlEj/+DU3uJ2eHPJePb2Y=;
        b=hVcAfzUKs8wWxg1/GzvziuOzJ2XLGrhQDTwCs5zfnSKkzHDa3Fj+Vf8EV8L6CduSgl
         1c/2EEIGnIMznQ/ML+Ekllgf+mzGShu5nV4gvjvLVMifK3kNliUUH+IFCWa3EAwmi5qL
         7ApYDpAM56xdFQ13H1xnsg9oYjLxBUedlLy6oXkisARV5UIfJoSPu/ghv3wE5YzZ2LRo
         RnNEtdFjPSwKkUEm4IOs8wPZl2/51yim4bLQvS4UeiV8sRbAnpuoLjkOS1N61duT8ifS
         WWvYxQNdpF7ModzYKm2yLzMaHsfKVNoNpVwPyj1vMNX4KuGe+4FbFrG5yGYAuTkR8pkO
         sOsw==
X-Gm-Message-State: ABy/qLY01X8FmPv9Gr3GNdhTCyQmJHrXnhEQb93rai5XIxn2kffXGoDO
        DuvL5rkBmImgveNxYO29PhOMI2A7rq4hBea5nEe5Xg==
X-Google-Smtp-Source: APBJJlFXgoM5JYiyURfjrpy48hpLApao0t2u3cPzHUDUmrorV/Pnf5w8IT0o72AR8WmiICLf0mld20wdlPtVBx8J+T8=
X-Received: by 2002:a05:6808:1513:b0:3a1:b6de:ed54 with SMTP id
 u19-20020a056808151300b003a1b6deed54mr14212741oiw.32.1689611760823; Mon, 17
 Jul 2023 09:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <202307171254.yFcH97ej-lkp@intel.com> <ZLUSG8bNnSqT0LO+@smile.fi.intel.com>
In-Reply-To: <ZLUSG8bNnSqT0LO+@smile.fi.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Jul 2023 09:35:49 -0700
Message-ID: <CAKwvOdnUjAXg4VRbCBKUOZDCKs-=5aA2-ef1tFRj-P=-1bBjaQ@mail.gmail.com>
Subject: Re: lib/test_bitmap.c:920:2: error: call to __compiletime_assert_348
 declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 3:04=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jul 17, 2023 at 12:42:57PM +0800, kernel test robot wrote:
> > Hi Alexander,
> >
> > FYI, the error/warning still remains.
>
> Alexander, either you can escalate this or just propose something to disc=
uss.

https://github.com/ClangBuiltLinux/linux/issues/1874
Sorry, a few more fires have popped up in the meantime.  Regardless of
changes to the compiler, we still support many versions of clang for
the kernel, so we'd need some workaround in the tests regardless.  I
saw there was already one for s390 + clang, but from this report we
will need another. Feel free to use that link above in comments in the
tests; we will clean those up once I have a better grasp on what's
going on with the compiler here.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>


--=20
Thanks,
~Nick Desaulniers
