Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEF07C5897
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbjJKPxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjJKPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:53:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB891
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:53:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c1886777d9so83891091fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697039589; x=1697644389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHhDRJtv88GUtolhSfk/M6EnhLggiBTlRi1I9TUAYxE=;
        b=co58F206CZ9+NcaDf4wM4feBhvMARKMv8mlCrVgeTav2i25nnvWVrKRowIBWkNEqRE
         ifhVdsNvZSLRVqpbu3RK4mxV968et59q3cCrjLG5mrGRfgw7SOO5DbUb36otU6yiIB7M
         p4kOmn5//QjnD0KXcaSa/Z52FOw2rbFoABLwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039589; x=1697644389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHhDRJtv88GUtolhSfk/M6EnhLggiBTlRi1I9TUAYxE=;
        b=fh+u2ik/dg1vVBKf+IP9QtgeH3mAJc88fmDcOw5TXykMns64Y1OpSSJUww8W4b8Nji
         Jgn8WM8eIxeh6AhA+rCfbUFsosSp11Z/GTvew+h8H3cYrQBVl2eG+AlnXshl+ZVEhjqQ
         6rsKKdcFz17XJiuNAX8JB7QY6wTCl9cj0el8obhpX7Jt6vt7uRnlKuX6bMKRw51GIcfL
         RQM1HH1RUUFq4TEG0vNrsMR882Bo+/oQ/pg6AKiEgvS8s6pmYVxZM3NDCg42tFjYrXN+
         IaWkgDMqkFQMXeCKlM5gCvoJYl8t03EIm4RUYlkQnOtmpNRBEEnhoyjhnGY3gPC6vVzF
         7Mdw==
X-Gm-Message-State: AOJu0Yzc+Lb2MIn0kSStxVp+W8SURiUQQLvbz5+/FZACjDUFqIKtUZgs
        HDl1r1heH3XAzhmkKnaltsWIn4A/ntEEY3UrAeQDcA==
X-Google-Smtp-Source: AGHT+IFAHZaip1J9zeajKEpAb5YV3c9gzGgz3OmrihXxQNsyJWbI2IkKeT2npiPX4t/KAAzUr0Cb58QohVGr/xX8Hbc=
X-Received: by 2002:a2e:b781:0:b0:2c2:c38b:2141 with SMTP id
 n1-20020a2eb781000000b002c2c38b2141mr17098551ljo.49.1697039588905; Wed, 11
 Oct 2023 08:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230929021213.2364883-1-joel@joelfernandes.org>
 <87bkdl55qm.fsf@email.froward.int.ebiederm.org> <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
 <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
 <87il7fzusf.fsf@email.froward.int.ebiederm.org> <CAEXW_YRv4Uqfn-9cQvDTRGNbCbC9s3jg+PP1-nqYP-DNO54R-w@mail.gmail.com>
 <87fs2ii3tf.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87fs2ii3tf.fsf@email.froward.int.ebiederm.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 11 Oct 2023 11:52:58 -0400
Message-ID: <CAEXW_YT4JrLaVg9iXdbny9o4DrhUN21WNGDfVNbwJCa-ZvUPOQ@mail.gmail.com>
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Rob Clark <robdclark@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 5:08=E2=80=AFPM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> Joel Fernandes <joel@joelfernandes.org> writes:
[...]
> >> That way you can get the orderly shutdown
> >> of userspace daemons/services along with an orderly shutdown of
> >> everything the kernel is responsible for.
> >
> > Fixing in userspace is an option but people are not happy that the
> > kernel can crash like that.
>
> In a kexec on panic scenario the kernel needs to perform that absolute
> bare essential shutdown before calling kexec (basically nothing).
> During kexec-on-panic nothing can be relied upon because we don't know
> what is broken.  If that is what you care about (as suggested by the
> unit test) you need to fix the device initialization.
>
> In a normal kexec scenario the whole normal reboot process is expected.
> I have no problems with fixing the kernel to handle that scenario,
> but in the real world the entire orderly shutdown both, kernel
> and userspace should be performed.

Sounds good. Since you mentioned you have no problem with fixing
regular reboot in the kernel, we will work on reproducing the issue
with regular reboot as well and fix that.

I think a syscall causing the kernel to crash instead of operate
normally is a cause of concern, so let us fix the kernel as well
(other than improving the test case as you mentioned).

> >> At the kernel level a kexec reboot and a normal reboot have been
> >> deliberately kept as close as possible.  Which is why I say we should
> >> fix it in reboot.
> >
> > You mean fix it in userspace?
>
> No.  I mean in the kernel the orderly shutdown for a kexec reboot and an
> ordinary reboot are kept as close to the same as possible.
>
> It should be the case that the only differences between the two is that
> in once case system firmware takes over after the orderly shutdown,
> and in the other case a new kernel takes over after the orderly shutdown.

Agreed.

thanks,

 - Joel
