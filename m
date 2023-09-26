Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103B47AE4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjIZFKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjIZFKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:10:13 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACFAAF;
        Mon, 25 Sep 2023 22:10:03 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-452962769bdso3587569137.3;
        Mon, 25 Sep 2023 22:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695705002; x=1696309802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bipsNM2vsnkfa6VF7W6nu2gEgIj2EbOeaFC3oBg/8Kk=;
        b=ARaEW4OKPmev0+vQohzoM7CvkMOvBmdLdpA+6MMU0UaD5lABTOpwSjT7IuxG6NMZqe
         Wd2ktz+Af5F+rIEb27slCIiv2SXdSeG87ARpG1+RVmzqVbZWqLTf3TR0oZqfBRNeDDHy
         EHnMrIF2MxLKkBVY21opK7HlxaOvllHbg5ogrQbdNE5a2lmCR9d7Zt0UIEfMhUDVaNs2
         vK/lvZUCbwYEn6lDL29f5m/Zu3oRo30u/heeHnoCsl7UDdX07IWWhEtlYagGHYYCvMXF
         ljD/S5bE1eGLxj6JgeOjQRQD35UHGabyqR04ru0d2C/vq3IRelT3E1BX/JxZ7Xpfh8QZ
         Qetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695705002; x=1696309802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bipsNM2vsnkfa6VF7W6nu2gEgIj2EbOeaFC3oBg/8Kk=;
        b=aY2ZD9/MwPksHZz276FvJMZMcN3woFu7R8uE5hwBUha/M+7ELw39CyKWqgdkE0WIgm
         kk7GC294dRCwNVqnJQQEgFK9VjY0Xqb+jKw/dprgrVw9HO0TvtlAmaL3cGjrmrBVY5ul
         1ez+RH2edqVpgTsvWYV0UYH0YfTKl96lPrsEky+fxiwlD167bHn8yEZqrNWbjUxnsvgv
         V7pn73QxAMQfvO4v777wxINS//ADvNooJprQZCuWhx4a2KEJv0eBNDZ8EANdvR8s+A6J
         UfEhKGOKnjumGxfRMeeT4ijostrOGbMQ/dWZMH7kxqUHy3SN3xxcx5BH7aKOXo62mBQg
         6h+g==
X-Gm-Message-State: AOJu0YxSNzepkgD0aKHiqKkbdp7euZDawUi5D6crsOVhFcPVG/xd6al1
        fp4EOLPFhJB+AE97LCWofyjoDVb/aHUSvvWcWOoxXBW1uKE=
X-Google-Smtp-Source: AGHT+IEpTjiUmtA87UahMB+Q9aykMOZpOlOnFgIIS7U7rFqBcFXg6vr5rrB+RfDyZGUTFPItba+mccJUjwAm3mTeBSM=
X-Received: by 2002:a05:6102:3bd5:b0:452:6aca:b9 with SMTP id
 a21-20020a0561023bd500b004526aca00b9mr5782100vsv.10.1695705002413; Mon, 25
 Sep 2023 22:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230926102444.096ce797@canb.auug.org.au>
In-Reply-To: <20230926102444.096ce797@canb.auug.org.au>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Sep 2023 08:09:51 +0300
Message-ID: <CAOQ4uxgs7dCUQ50J6fwW5Dtgb-sBU4WyKogbU2PEG2uooWxSCw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 overlayfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alessio Balsini <balsini@android.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
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

On Tue, Sep 26, 2023 at 3:24=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>
>   fs/overlayfs/file.c
>
> between commit:
>
>   f8f29a49ec21 ("ovl: move ovl_file_accessed() to aio completion")
>   e57757c5d874 ("ovl: use simpler function to convert iocb to rw flags")
>
> from the overlayfs tree and commit:
>
>   2d1b3bbc3dd5 ("ovl: disable IOCB_DIO_CALLER_COMP")
>
> from the vfs-brauner tree.
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
> diff --cc fs/overlayfs/file.c
> index 05ec614f7054,693971d20280..000000000000
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@@ -398,16 -389,22 +398,22 @@@ static ssize_t ovl_write_iter(struct ki
>                 goto out_fdput;
>
>         if (!ovl_should_sync(OVL_FS(inode->i_sb)))
>  -              ifl &=3D ~(IOCB_DSYNC | IOCB_SYNC);
>  +              flags &=3D ~(IOCB_DSYNC | IOCB_SYNC);
>
> +       /*
> +        * Overlayfs doesn't support deferred completions, don't copy
> +        * this property in case it is set by the issuer.
> +        */
>  -      ifl &=3D ~IOCB_DIO_CALLER_COMP;
> ++      flags &=3D ~IOCB_DIO_CALLER_COMP;
> +
>  -      old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
>  +      old_cred =3D ovl_override_creds(inode->i_sb);
>         if (is_sync_kiocb(iocb)) {
>  +              rwf_t rwf =3D iocb_to_rw_flags(flags);
>  +
>                 file_start_write(real.file);
>  -              ret =3D vfs_iter_write(real.file, iter, &iocb->ki_pos,
>  -                                   ovl_iocb_to_rwf(ifl));
>  +              ret =3D vfs_iter_write(real.file, iter, &iocb->ki_pos, rw=
f);
>                 file_end_write(real.file);
>  -              /* Update size */
>  -              ovl_copyattr(inode);
>  +              ovl_rw_complete(iocb);
>         } else {
>                 struct ovl_aio_req *aio_req;
>


Thanks Stephen, your fix is correct.
Serves me right for doing an unnecessary var name change...
Anyway, the conflict is with vfs.fixes branch destined for 6.6,
so I will rebase overlayfs-next (for 6.7) as soon as vfs.fixes is merged.

At this opportunity, I would like to ask you to add branch ovl-fixes
from ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
to linux-next, because I will need to send some ovl fixes for 6.6 in
the near future.

Thanks,
Amir.
