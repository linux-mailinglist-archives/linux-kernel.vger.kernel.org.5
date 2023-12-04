Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD7E803A82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbjLDQhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjLDQhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:37:50 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F66CA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:37:55 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db510605572so2881949276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701707875; x=1702312675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ytHym4TWHPiac4ZL1jwTfy0WQXCu4D326ivcWRp1+8=;
        b=TlT3hWK1I0DJ9ddzjWuBGIDlZkUzyVkVZW8j0gesiMh9Dez5aGAnIEp82hORnczBHo
         Oc1bOY9leTUFVfmEnAVYEAjQ+BeP3Vs7I69vrCRd3pG8qYxX2MCbgDZrT7+zHS7SrADd
         VjuGUvzYJ7bouC+1YU9wkESP7oW1rBp4u7j2jmGmlDih/V4hqiPRuLXoA/o1la2bxFdY
         RsCphPN36LLvxrtcdHhXIFbCgJCqQYR4cn0qj5PtI1t2O5KXh2qcvi49F1HYP+hzMdJk
         YoDwWwFBOUulJl0WzZpVavUZa9jGXExDv1sUStj0a0xhegEK7i1mdly82CKV5F2zUCAu
         BDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707875; x=1702312675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ytHym4TWHPiac4ZL1jwTfy0WQXCu4D326ivcWRp1+8=;
        b=xHMyeGGK5PM8nCPh4rkomiWCNOvSEa+wyCePDvgmR7Bac00c4mjY5//8PWwrVAjMGe
         6a6/In/bIkVFdgEw+nCAA9909I70sZEs8V9gP1wGt/k19au9S3ENwRXn+Dso/oBbjC1a
         3/8HDErUS82Cz/okIVbVKleX9a3Vb0epNpKKAQPT7Q3VAiLGGGVy6CEmUFvkJF2eNQlG
         S98WX0Gu+DeBpLvLHoHnSxOoSC7MHCWJIQgAqXa9ndYMYt6GjL60msEukswlpzJ++RBe
         oHbxusHcOClLD+xSOAZPR0R/ZK+NHpYGqANj1dyScxZ9sr9C/jHSWjmuP2H18mJpoiTg
         kapg==
X-Gm-Message-State: AOJu0YyP/NX7Cv15/ALzxsEvjz0NOP0BBzsLCTBh9MtXxSoziFW2Zk3t
        gu9RazRJIfXVxCjjk76uwBeJqBzPfCnvZAam7D0XcTodiwgatMc=
X-Google-Smtp-Source: AGHT+IGHLVwglvYRPWt67Br5ifnmRNJxcf5z8ii0VblD/ojAEUODm/AY0mFoUTNPTX7Ihy0rdUkxqhhY5aNEp47h25A=
X-Received: by 2002:a25:ab89:0:b0:db7:d0fb:c857 with SMTP id
 v9-20020a25ab89000000b00db7d0fbc857mr2651632ybi.51.1701707874962; Mon, 04 Dec
 2023 08:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20231204120314.5718b5f6@canb.auug.org.au>
In-Reply-To: <20231204120314.5718b5f6@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Dec 2023 11:37:44 -0500
Message-ID: <CAHC9VhSyv8XULS8UJe3oZsTjLxqdhi84TUMS_8vhJ5TC9uU4bw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the security tree with the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 3, 2023 at 8:03=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the security tree got conflicts in:
>
>   security/selinux/hooks.c
>   security/smack/smack_lsm.c
>
> between commit:
>
>   bf18dde00aa9 ("io_uring: split out cmd api into a separate header")
>
> from the block tree and commit:
>
>   f3b8788cde61 ("LSM: Identify modules by more than name")
>
> from the security tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc security/selinux/hooks.c
> index 17ec5e109aec,b340425ccfae..000000000000
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@@ -91,7 -91,8 +91,8 @@@
>   #include <uapi/linux/mount.h>
>   #include <linux/fsnotify.h>
>   #include <linux/fanotify.h>
>  -#include <linux/io_uring.h>
>  +#include <linux/io_uring/cmd.h>
> + #include <uapi/linux/lsm.h>
>
>   #include "avc.h"
>   #include "objsec.h"
> diff --cc security/smack/smack_lsm.c
> index 2cdaa46088a0,53336d7daa93..000000000000
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@@ -42,7 -42,8 +42,8 @@@
>   #include <linux/fs_context.h>
>   #include <linux/fs_parser.h>
>   #include <linux/watch_queue.h>
>  -#include <linux/io_uring.h>
>  +#include <linux/io_uring/cmd.h>
> + #include <uapi/linux/lsm.h>
>   #include "smack.h"
>
>   #define TRANS_TRUE    "TRUE"

Thanks Stephen, the above patch looks fine to me.

--=20
paul-moore.com
