Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871F47DC185
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJ3VES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjJ3VEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:04:16 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B0FF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:04:13 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso4467351276.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698699853; x=1699304653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IRBB4v+xNKwfa339/f54Eupmf6Jk1Nhnt0RmKMHDA0=;
        b=BmsmR0SISl+xP97UkzsUvLRJ0VnfYymUBTxOCtmdUgJREceVK/++izMXyzy6L2FClB
         vLjelyrAuZ9G9bv+pqvGPQ9KzJYmpk05sHzAKHQMs7AJ/wqrn8J9LCCc3gGuG9iYWzQH
         NAa+2P+3OvfGuoUYWHFb7N+CigQxbNc2SX6rPFE29jyMdI7edt+mn3S5z0NQs6aKwG55
         jbp3dDQ2gb6O7ffvwJpkdkKVggp1oU7XhMw/ac+KoWX5Cyx6gfJbn4HoSd0N+VmRAx+i
         zjER/MARXQfXwC1OfG56ogmzD+SpfKLWYZmaSPcLd4pYcUqICjJyrTIZZ6X3RyTiHAUr
         Kiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699853; x=1699304653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IRBB4v+xNKwfa339/f54Eupmf6Jk1Nhnt0RmKMHDA0=;
        b=OnSclZKG1qXinIu5aeF426M4KBNeVu0hxmwiKSSi/2mdE2ux/Vgfjnbh28Yk0e+GKG
         fnp5+DO3HFnpaZLN+w0mZq0GhL3H9caKK4tzZ1uQfqFbFYcdUBV7fbDM+4SekFEIeKV5
         S9vze9zjL7C4ZF99IKtVpHr6K2flwirpgl7VowxCEP20Dc5OovH/N5y1XrJ0lGGpM3VI
         BxN1snjQtFwRPsli37gJonaQEJAhOIugHxechDMIN+LUHXZ9Ny5sFMNL6/0DsInbRPrC
         UHAxLPDp3Z6Zh2Gy4XydWlUURYmhu84/AkdXGsy928t4OGqxv9Hl+6nMEFvYZF7VE3Ya
         o7bg==
X-Gm-Message-State: AOJu0YxLjMN4Dp97cxOcDxkFpwO22qvmboTO71qX/LJGmb0zJ0pKE2tH
        3m9A0eTJAsNmTVVAUx+q8p5i6Zwvaa6L0B2PTQ1/
X-Google-Smtp-Source: AGHT+IHgWT98tQeMKmbprLoIOO4qYYNM0FKQ8Yylq7cSYwMVyIM6xEJkoJ8OMu86XlQJpwgHYhnP6KQuaS4mdiHRKF0=
X-Received: by 2002:a25:a2ca:0:b0:d9a:c218:817c with SMTP id
 c10-20020a25a2ca000000b00d9ac218817cmr11419967ybn.4.1698699852727; Mon, 30
 Oct 2023 14:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231027130320.69469330@canb.auug.org.au> <CAHC9VhQ+Nt7CrLxSZcOVNEtAypruOmM0ST0P0JJMrOq4XYmAkw@mail.gmail.com>
 <4b4eb40c-b65a-46e2-9e23-5412a9cdcad0@canonical.com> <CAHC9VhQbxJ4-z4Hp7CSmtcTNOWGFeQF2eEyct9=nHCMN_89YXw@mail.gmail.com>
 <20231031074649.3bdbec45@canb.auug.org.au>
In-Reply-To: <20231031074649.3bdbec45@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Oct 2023 17:04:01 -0400
Message-ID: <CAHC9VhR=x7qB3gmQg+GPYLnXtGU88S3KCiZGjRYtDKSJHp4P1g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the apparmor tree with the security tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 4:46=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi Paul,
>
> On Mon, 30 Oct 2023 12:52:50 -0400 Paul Moore <paul@paul-moore.com> wrote=
:
> >
> > On Sun, Oct 29, 2023 at 5:09=E2=80=AFPM John Johansen <john.johansen@ca=
nonical.com> wrote:
> > >
> > > is part of the Three basic syscalls series, the plan is still to have=
 that
> > > series bake in next for a full cycle?
> >
> > Yes, that's still the plan.  Once v6.7-rc1 is out I'll rebase the LSM
> > syscall patches and I expect the vast majority of these conflicts to
> > disappear, although I'm sure we'll pick up some new ones with the rest
> > of the v6.7-rcX cycle :)
>
> These patches should not be in linux-next until after v6.7-rc1.

What if we wanted additional testing beyond the typical?  Do you not
support that?

--=20
paul-moore.com
