Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4521D7C7DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjJMGc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:32:55 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B066BC;
        Thu, 12 Oct 2023 23:32:53 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7bbcc099fso22348017b3.3;
        Thu, 12 Oct 2023 23:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697178773; x=1697783573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RJx+LWOJYRgtiiPj5S3Xyml9/R6gBT1DY9mfhgdDwo=;
        b=RSoumDkk8tTc4EuOk3PPUSYKx0urof8l8z/KBNOemWLK4MezgGnJvF4kjtjd2nlnSG
         JIkkybsL1UV9ekETCzVrsG4y/mstY6/yyWZRslq7WbZw/t2FOr209pEidBFPREUD3wRc
         DFs2GylpEO+4KE5lw2IX1Zl5HqfjXGXMxpj96jsu47RpMLNyc7pKBsAkanWabgFaYXKy
         xdN0A+L2MhxYcDbkU9GZnfj/keoF1jhSUtuDjsF5h/glaJ9QaK0UZcrQvWKyy4HX29VV
         Rup6DUhH7vljPANaX9wuZkwHhiCdg9zB16The+qUDsqD+WnHtcLMcf0auJgXU00mWL1/
         i1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697178773; x=1697783573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RJx+LWOJYRgtiiPj5S3Xyml9/R6gBT1DY9mfhgdDwo=;
        b=LMIOTMQcnQQGNVO0kE8xnqwyn558csyAHYjmhXeAP9J7JzD5FAGiFUkj54ro/T4QAo
         lOQn4FZu0qKEcnaE5Cl05PYrf4eL1jlYjz8zUz3+18GlQ8EKEXVuibwkFunaHOu3WvOk
         6jXIi02FEgK52td3Z9zoOlVe2AUgOyo41T/hNImFmQS7v6yr4qIULQ4cFRdVOTGhz5AI
         zUCKULM5hERTFUJANOzt/R7BRzwkm6jYxAVQWxMnkRlYFtEagI15TJywadR/rVguwZ2R
         Q6aaOMHw0AT9l56jt1D9oMX+NfVNRJ9XSYXeBtHkX95csuKB4y+YuA9RnKhT8mXj2v+4
         2OhQ==
X-Gm-Message-State: AOJu0Yz3tFQe5Rz2WW7xZl50Zir16f/gIhNm2qfd99r61R8LVhwyBF5A
        uGJ5YNfQ03zq7X4c8eTsLeBDigWeUYbxaxNwcBI=
X-Google-Smtp-Source: AGHT+IGF92G3YigKuGj2W+653tQ+Bu93m6kiyQTDevgMl7ESWHN9rYENlMDMFgCHm0CX+jx9IH0ob3ovbi+GS59qhnE=
X-Received: by 2002:a05:690c:f8d:b0:5a7:ec51:9218 with SMTP id
 df13-20020a05690c0f8d00b005a7ec519218mr6854844ywb.25.1697178772730; Thu, 12
 Oct 2023 23:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231013104816.103ea713@canb.auug.org.au>
In-Reply-To: <20231013104816.103ea713@canb.auug.org.au>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Oct 2023 09:32:41 +0300
Message-ID: <CAOQ4uxjazEO_f7HPzUpK3FpZXC4j=GXFfBpgNU9zsanVzp=Kzg@mail.gmail.com>
Subject: Re: linux-next: duplicate patches in the vfs-brauner tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 2:48=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> The following commits are also in the overlayfs tree as different commits
> (but the same patches):
>
>   149f455798a6 ("smb: move cifs_xattr_handlers to .rodata")
>   295d3c441226 ("net: move sockfs_xattr_handlers to .rodata")
>   2f5028604f08 ("shmem: move shmem_xattr_handlers to .rodata")
>   375aa21d36ee ("xfs: move xfs_xattr_handlers to .rodata")
>   3d649a4a832e ("overlayfs: move xattr tables to .rodata")
>   c08a831c74f0 ("squashfs: move squashfs_xattr_handlers to .rodata")
>   c25308c326db ("ubifs: move ubifs_xattr_handlers to .rodata")
>
> Looks like the overlatfs tree has merged a previous verion of a topic
> branch from the vfs-brauner tree.

Yeh, sorry my bad.
Christian told me that vfs.xattr branch was stable, but I did not notice
that I had merged a day old version.
Fixed now.

BTW, Christian, feel free to fast forward the stable vfs.xattr branch to
a640d888953c const_structs.checkpatch: add xattr_handler
it won't be a problem for me.

Thanks,
Amir.
