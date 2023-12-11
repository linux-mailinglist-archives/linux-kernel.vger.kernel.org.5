Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDAC80C464
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjLKJWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjLKJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:22:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02535CE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:22:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E608C433C7;
        Mon, 11 Dec 2023 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702286545;
        bh=loi0HaJE81baXDC9k3d7qgLhOZK98B8aq2E8/2avPlU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nq/0y8AlWIGYezWXJ76icz3Jvp/ul+Q05DOKUcmIkby/D5l8fhQ+qRELJpmOVJR+o
         WOXX6P3TDZAyEjyw1cb8P7O3Au9ANm1/ZnpUy+oFtLBmtpA7V2pxs7TIQmIpN1YWIE
         R7cVYqpTpQMStfixab4zoBaZing6LHbAgAiE2yk86Ykiww16bOclT1+lfNSdlqYJYA
         iSsoj+eS9zCcfAONBqhXU62hhuQds2xuIVV2AQUYXqhTzePdbifVBNOdBAHPM+l34D
         SXZuVcOSPjeWeqta+PXUA5l5dBmYOsoggy5Vr9tntivBzYeQnoZ4FtEoJKzYdN5cun
         8t56/rQ7oZB4w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50bfd3a5b54so4711475e87.3;
        Mon, 11 Dec 2023 01:22:25 -0800 (PST)
X-Gm-Message-State: AOJu0Yy74CCcveT+iVJFtlg4TH13YER0LaXF6J/7e9V8IsPwYzFNjX9w
        RWkIZy4iMqEl8KF5s93Ndg2IK+i5HK5fDbXW2w0=
X-Google-Smtp-Source: AGHT+IHkUug4AGg9NguvDT6U8EQW0DoFEM6O+sS6ukhcM/xO967l6nnD3SzKtlcEynqtqCAzg48Nvq1JutvPDEFQZ0k=
X-Received: by 2002:ac2:4989:0:b0:50c:5c0:b5e0 with SMTP id
 f9-20020ac24989000000b0050c05c0b5e0mr1699083lfl.105.1702286543727; Mon, 11
 Dec 2023 01:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20231211151303.1286eda5@canb.auug.org.au> <20231211153905.6cbf7dcb@canb.auug.org.au>
In-Reply-To: <20231211153905.6cbf7dcb@canb.auug.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 11 Dec 2023 10:22:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGG=pPAFEJ=YuWkk6oc7ZZfRE=Y3jGmp-4fWb7FK3AC0g@mail.gmail.com>
Message-ID: <CAMj1kXGG=pPAFEJ=YuWkk6oc7ZZfRE=Y3jGmp-4fWb7FK3AC0g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the efi tree with the efi-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 at 05:39, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Mon, 11 Dec 2023 15:13:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the efi tree got a conflict in:
> >
> >   fs/efivarfs/super.c
> >
> > between commits:
> >
> >   0b6d38bdd6f8 ("efivarfs: Free s_fs_info on unmount")
> >   ab5c4251a009 ("efivarfs: Move efivarfs list into superblock s_fs_info")
> >
> > from the efi-fixes tree and commit:
> >
> >   b501d5b36f58 ("efivarfs: automatically update super block flag")
> >
> > from the efi tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
>
> Actually the below is needed. ("info" is not a great name for, even a
> static, global variable.  And maybe what I have called "einfo" could be
> "sfi" like in efivarfs_kill_sb() ...)

Apologies, I should have spotted this myself.

I'll fix this up and sync up the branches so any conflicts are
resolved before they reach you.
