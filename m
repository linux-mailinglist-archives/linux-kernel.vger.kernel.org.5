Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ACD7DBE47
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjJ3QxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjJ3QxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:53:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2F6DA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:53:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d865854ef96so4048493276.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698684781; x=1699289581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwMkDKq50ThyVlHovkeE8yCjhEm0AE7bUk6nbrhZfxM=;
        b=YKBb1Aj2+IRRySeQUZXYNMwt2mr//XsiT3uMYDwhMr7+p+eL/kSW1rpi0nkVXlUcCK
         Zor9RJ4soIH/K34NCaqhntx46T+PTQBa717CyfMhoo47okIq3Q1ZVRRnbdFYzsAxkHo6
         rs+1VJFqq+kqAMrsvuB72ziZwp/lFGrqqFJfOMGu8TNVAitv6TpmAUVw2wJnnTkXtFve
         TtmLm9ESkw1Bw0OoEmpWth4frkXuZJc98tkh2RBr7aACQBxa1a40GG0tufrC/o1/wRK8
         cK3n/B32tP/LolYa5jZ2pI+OpfnSmdFVrvScyECR8mzykR9i5sezgOJnxhdCdRX4zd4H
         mm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698684781; x=1699289581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwMkDKq50ThyVlHovkeE8yCjhEm0AE7bUk6nbrhZfxM=;
        b=VCFnNcSFQgSO1Q+Bhq+G2sduWijS2qNVH7QU9LU5L1TVq2yC2GdA59ChCG3HhLXGeb
         XSiOWvmF1/XwcxBNpX0EnFqHV1BCrQ7enynNKLBL6hGR6wJFE7wv7eWsQ3DbImujTVt1
         F+gDhRoqm/gj2nbN7rsaqxW0Q8vPgla5QVTRB1JOHkjaj4qzsv7DHOYF1c1uetj4QIsQ
         JSNXjDOdkv8FAsYD40YRZoHBKfYD5cXgypV4Yq8V20k5KqA0IH6kZqDhHZZBEyYe9Dpc
         vhQcCLi9TcA9Iej3qC46y2De6Wby+dh1KSbp3/4Avff57OuXZSeXfjaQC5qcNkb4W6LT
         WR2g==
X-Gm-Message-State: AOJu0YzktYCm540cp1Lslw4NwkeMzUEWfEfZdLfTb4izSYMlKf9NMTso
        NdkyfxpHa08MyY4feqxWBqXe4avIo/m9EFpbKXbS
X-Google-Smtp-Source: AGHT+IFkLfWhGCayc4iafAS6NLVIK86aPcbOyiKSW3nz6bt+VLjKZOg2dnWJbC/trJ4dWgWvUnEG6LhFmfDGu+txJRg=
X-Received: by 2002:a05:6902:1366:b0:d9a:6b48:db71 with SMTP id
 bt6-20020a056902136600b00d9a6b48db71mr9561887ybb.62.1698684781293; Mon, 30
 Oct 2023 09:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231027130320.69469330@canb.auug.org.au> <CAHC9VhQ+Nt7CrLxSZcOVNEtAypruOmM0ST0P0JJMrOq4XYmAkw@mail.gmail.com>
 <4b4eb40c-b65a-46e2-9e23-5412a9cdcad0@canonical.com>
In-Reply-To: <4b4eb40c-b65a-46e2-9e23-5412a9cdcad0@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Oct 2023 12:52:50 -0400
Message-ID: <CAHC9VhQbxJ4-z4Hp7CSmtcTNOWGFeQF2eEyct9=nHCMN_89YXw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the apparmor tree with the security tree
To:     John Johansen <john.johansen@canonical.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
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

On Sun, Oct 29, 2023 at 5:09=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 10/28/23 08:32, Paul Moore wrote:
> > On Thu, Oct 26, 2023 at 10:03=E2=80=AFPM Stephen Rothwell <sfr@canb.auu=
g.org.au> wrote:
> >>
> >> Hi all,
> >>
> >> Today's linux-next merge of the apparmor tree got a conflict in:
> >>
> >>    security/apparmor/lsm.c
> >>
> >> between commit:
> >>
> >>    3c3bda37ca1d ("AppArmor: Add selfattr hooks")
> >>
> >> from the security tree and commits:
> >>
> >>    bd7bd201ca46 ("apparmor: combine common_audit_data and apparmor_aud=
it_data")
> >>    d20f5a1a6e79 ("apparmor: rename audit_data->label to audit_data->su=
bj_label")
> >>
> >> from the apparmor tree.
> >>
> >> I fixed it up (see below) and can carry the fix as necessary. This
> >> is now fixed as far as linux-next is concerned, but any non trivial
> >> conflicts should be mentioned to your upstream maintainer when your tr=
ee
> >> is submitted for merging.  You may also want to consider cooperating
> >> with the maintainer of the conflicting tree to minimise any particular=
ly
> >> complex conflicts.
> >
> > Thanks Stephen.
> >
> > John, can you take a look and make sure this is correct (it looks okay =
to me)?
> >
> yes its good, thanks Stephan.
>
> Acked-by: John Johansen <john.johansen@canonical.com>
>
> Paul just to double check, to make sure we get ordering on this right
>     3c3bda37ca1d ("AppArmor: Add selfattr hooks")
>
> is part of the Three basic syscalls series, the plan is still to have tha=
t
> series bake in next for a full cycle?

Yes, that's still the plan.  Once v6.7-rc1 is out I'll rebase the LSM
syscall patches and I expect the vast majority of these conflicts to
disappear, although I'm sure we'll pick up some new ones with the rest
of the v6.7-rcX cycle :)

--=20
paul-moore.com
