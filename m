Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BE278C8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbjH2Plw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbjH2Pl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:41:28 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C14CD2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:41:21 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6515d44b562so14706116d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693323680; x=1693928480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6w1Ls1sn3g8EuR9FLr87CmzSLawvlZA36YBFNsEyrqo=;
        b=RePQtCbtJb8yTnPCG6XhU52r+nhBacgJ3m1Hf6++uzNpY5WVwBEgEeUOJJj5tRKsdG
         Mw6sLocWVTveeyxm84ASXXZicf/JLpdRkJSwmatVMFNPEe5goKu6QN7BEo66ZLqhi1T+
         oLie1Sx5nFp2iIxc7d6WlHxlqh6rUAF0Dymb9N1RfMjYr/aRUEeFv+K8CnDi5xIM85Xi
         17dO0P9uDb3w45zqDsQWdD6UB9Q87aEBW1ZGKFFgfONnSR6z9Q7U/sy4bYcgvat1rACc
         DXb1bskKsPhCDT9n049AqzRNxxbZE5euxOXUwImZiMxURyBMN/kwGdUZq9+Oruj5kfuq
         ZjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693323680; x=1693928480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6w1Ls1sn3g8EuR9FLr87CmzSLawvlZA36YBFNsEyrqo=;
        b=QqPoPFr+22GrWZq212Vtwd8u4zPeSh7GVPoX5DmIWK050qr0jA+Rr+LlUUQDb69GeO
         /n/OWMbOq41ogU0kjdpPnHqK6TNZlL9wvTTGp3V2b7hH6Uy8ygxgHXd6FOdUU3GSfk5F
         y6oBMjQnyvC/dRKhBdAbSvRh3+8IB7lCgYRnt1lXPPQWZ9yHFmKjoomGrG9AKwEri0b+
         xG4DoTfy9GAtqyIb6vsuV6OP/JZB/o4AdCl4Qeeofr7HUK6PnYvayz22j9CpGFu7pAhh
         wGPfSQugd/oXC52fAIBVdXxfJAkl5zgvJC/tTAmZezGRdvoF4HRe7nNKZrVIrVAmBE/E
         ld9A==
X-Gm-Message-State: AOJu0YzKjRPD2p8qF/u4pJIN2P8BSCksHcDS+jhFzdsSRtfQwlC6/vOC
        j1Ob0xNHI9lj+cuIbmleKekD6cHXe1bpE8lpHaGLRA==
X-Google-Smtp-Source: AGHT+IGHcq6O4w4Xaif/Wkg7G2cp5jDPTlWZCjK9MvTG1O3GXizQyZyXKPiWJ235Db2+y9z6DE/nb27moDetWPL+YZ8=
X-Received: by 2002:a0c:ab5d:0:b0:64f:42eb:92ea with SMTP id
 i29-20020a0cab5d000000b0064f42eb92eamr24008326qvb.4.1693323680063; Tue, 29
 Aug 2023 08:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230828153142.2843753-1-hca@linux.ibm.com> <20230828153142.2843753-2-hca@linux.ibm.com>
 <ZO0j3M8KFWeEznXy@google.com> <20230829080202.7031-B-hca@linux.ibm.com>
In-Reply-To: <20230829080202.7031-B-hca@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Aug 2023 08:41:09 -0700
Message-ID: <CAKwvOd=Q1woTad6wFMm=Phs36FTyQ5Gg1wFwZZUhe6j5x3zEqw@mail.gmail.com>
Subject: Re: [PATCH 1/1] s390/dasd: fix string length handling
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        =?UTF-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, nathan@kernel.org,
        llvm@lists.linux.dev, David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 1:02=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Mon, Aug 28, 2023 at 03:46:52PM -0700, Nick Desaulniers wrote:
> > On Mon, Aug 28, 2023 at 05:31:42PM +0200, Heiko Carstens wrote:
> > > Building dasd_eckd.o with latest clang reveals this bug:
> > >
> > >     CC      drivers/s390/block/dasd_eckd.o
> > >       drivers/s390/block/dasd_eckd.c:1082:3: warning: 'snprintf' will=
 always be truncated;
> > >       specified size is 1, but format string expands to at least 11 [=
-Wfortify-source]
> > >        1082 |                 snprintf(print_uid, sizeof(*print_uid),
> > >             |                 ^
> > >       drivers/s390/block/dasd_eckd.c:1087:3: warning: 'snprintf' will=
 always be truncated;
> > >       specified size is 1, but format string expands to at least 10 [=
-Wfortify-source]
> > >        1087 |                 snprintf(print_uid, sizeof(*print_uid),
> > >             |                 ^
> > >
> > > Fix this by moving and using the existing UID_STRLEN for the arrays
> > > that are being written to. Also rename UID_STRLEN to DASD_UID_STRLEN
> > > to clarify its scope.
> > >
> > > Fixes: 23596961b437 ("s390/dasd: split up dasd_eckd_read_conf")
> > > Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> >
> > Thanks for the patch! Nathan just reported a bunch of these. I took a
> > look at these two and thought "yeah that's clearly a bug in the kernel
> > sources." Fix LGTM.
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1923
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > I also like David's idea of passing `char ident [DASD_UID_STRLEN]`, too=
,
> > but I don't feel strongly either way.
>
> Well, this is supposed to be the "minimal" fix. I consider everything els=
e
> additional cleanup work, which can and should be done by Stefan and Jan w=
ho
> maintain this device driver.

Sure, like I said, I don't care either way.

>
> For example there is more or less identical code within dasd_devmap.c
> (dasd_uid_show()), where it would make sense to de-deduplicate the
> code. And then of course there is the already mentioned rather pointless
> strlen() invocation; plus there are many other string operations / format
> strings, which also should be addressed.
> E.g. there are quite a couple of "%p" printk format specifiers which are
> pointless, since pointer values get hashed since years - so a more or les=
s
> random value will be printed, etc.

kptr_restrict can be disabled at runtime though, so it's not useless
to print pointer values (IMO).

>
> However all of this is up to Stefan and Jan.
>
> So I consider this current fix as good enough and final.

Thanks for the patch.

--=20
Thanks,
~Nick Desaulniers
