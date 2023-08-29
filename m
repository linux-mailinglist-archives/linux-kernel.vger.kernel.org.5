Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D843E78C8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjH2Pn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbjH2Pnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:43:35 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52338E69
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:43:09 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76df3d8fb4eso299443785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693323788; x=1693928588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBTH3KqXgFJRqcMAbzLE/ja4EQ9oM7ASpBmuXdwwsEI=;
        b=HVI6FJsyGs541XjaMgVduX7Uc1sfhiaAfYG1AooHHyQPpd7jEsnrKktawbP7iuEXzU
         ujwrfFOLNG61awVH7O8MajC8Kn1E7Xrc2PPeNuAnMVUU+QrRxcqQY14cINXgTirBcRoo
         9Kt1S7N1bkJR92e8IosfYJ0EhZJw5Ai8ZnNLNtGxk01jR1/Idy5BfjQd4NjWYszST29F
         5sDRHiy/fBOYAVK4kzMJ8JimZATeE55gclkMQ6T4VXRP+nVed0rYVZqaiaJem2VXcsM1
         8W0Bjmb+wH93fcCd/n6lPfcJG1SFYUHs1pDyNFaeDZjJDqb1zKoqRjTle/fFPK6zFBSP
         PfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693323788; x=1693928588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBTH3KqXgFJRqcMAbzLE/ja4EQ9oM7ASpBmuXdwwsEI=;
        b=hyu4jfFAtz3PjvOYaCvLWBR0S3RF3qg3lFW2msGeksZNTcp4WZQiIAGFZbm44tfrqa
         c3381/2ojvaOjPdo2m7uFZUZqBrR55o8RSpoib8+Inla7Wkg7lFTHyMnrXUaLSFKoWku
         y8APdQ1hs1zd12YsaYMsHrcCGpmK402giEFh1XD4/OmwSCybvMmnE5jozKdK/Wv+TfQO
         3bIG0wFMRq7oAdk5s2LtVlZ6kjqT1R3vzsI4MpSgFKQxAxAv7fVMldGXuOOIAFohntzJ
         zHnHrLl7oo6oGT5NIx67yGL9hL7EGSv7qmfBlhgXWSSGEIyxICXay2BWxkmEO1EcIfsZ
         PYlw==
X-Gm-Message-State: AOJu0YzzebiwGwgFbDsBwav6KWLofc8auLgimqkKT6HsHuNWNM0P448C
        i4ltP/GOUZOMd4izSpgrZPcwNNUON+U0m7xKwa6qIA==
X-Google-Smtp-Source: AGHT+IFI195D/AC2c/3Bu7IIaQoiyLB0K4oEif6OroPsGolMUfKUAgcMd4pgiugVDhV5XGVzvFQe2vWKh9zFprkhljc=
X-Received: by 2002:a0c:f484:0:b0:64f:4e7a:bc3a with SMTP id
 i4-20020a0cf484000000b0064f4e7abc3amr24893513qvm.26.1693323788232; Tue, 29
 Aug 2023 08:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230828153142.2843753-1-hca@linux.ibm.com> <20230828153142.2843753-2-hca@linux.ibm.com>
 <f0419f6428ad404386ebca813dc1ec03@AcuMS.aculab.com> <ZO0k1Par4i4FBCWF@google.com>
 <20230829074854.7031-A-hca@linux.ibm.com>
In-Reply-To: <20230829074854.7031-A-hca@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Aug 2023 08:42:57 -0700
Message-ID: <CAKwvOd=23+rjzB96jpYgb4-J2jniTWXbT+638gQJ2mmShVfN=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] s390/dasd: fix string length handling
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        =?UTF-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 12:49=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com>=
 wrote:
>
> On Mon, Aug 28, 2023 at 03:51:00PM -0700, Nick Desaulniers wrote:
> > On Mon, Aug 28, 2023 at 05:18:37PM +0000, David Laight wrote:
> > > From: Heiko Carstens
> > > > Sent: 28 August 2023 16:32
> > > >   if (strlen(uid.vduit) > 0)
> > >
> > > Does the compiler know enough to optimise that brain-dead test?
> > >
> >
> > For the purposes of skipping diagnostics, no; clang performs semantic
> > analysis BEFORE optimization (which is handled by LLVM). As such, clang
> > will produce diagnostics on dead code.
> >
> > Partly because LLVM isn't very ergonomic at emitting diagnostics from
> > the backend, partly because Clang code owner and developers don't want
> > clang to emit diagnostics dependent on optimization level.
> >
> > I disagree with my compatriots, and you can read more thoughts here:
> > https://discourse.llvm.org/t/rfc-improving-clangs-middle-and-back-end-d=
iagnostics/69261?u=3Dnickdesaulniers
>
> Maybe I misunderstand what you write above, however clang (latest+greates=
t)
> does indeed optimize the strlen() away and generates code which only test=
s
> if uid.vduit[0] is zero or not.

Oh, yeah, sorry I was talking about something else. Nevermind my point.

>
> Unlike gcc, which does not optimize this away and which uses the strlen()
> inline assembly provided via string.h...

heh, I feel like I was just having a conversation yesterday with
someone about pessimizing compile-time calculations...

--=20
Thanks,
~Nick Desaulniers
