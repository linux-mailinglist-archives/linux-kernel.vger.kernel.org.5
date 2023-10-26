Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4616C7D7C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjJZFQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZFQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:16:29 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2894BB9;
        Wed, 25 Oct 2023 22:16:27 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d264e67d8so3711156d6.1;
        Wed, 25 Oct 2023 22:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698297386; x=1698902186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcRpgRwe25+UkQEfJDZGZHuA0KvrCaL/46MeTSbRYhg=;
        b=iNlzEdEHzVV58O1KuXP17K7ludN6tkRrZM8aIHmIv/N8/AV8cefmDYaOxmAQ3oYBG3
         pu5WCtwOHiBAXp2r7ByggNgY5VxaX3/CsiN2BYC4YMJyc4JU+qzLycrMHluuIxwzSTbG
         rjM1BWxVpAK8z1wsAvKjohDGEWwL6pU2Vp+uB/yU2+pVSKYbN6HStDddiFFKptTPSZey
         w7TXzI599gIU0hTnrLWxu/DJK7eX354SSEiw1UXK9bD9KXV9B8eX/oKq/prsJHVLBzOu
         ctEATEZovdzsLhSJNYrZS399wxzcMw/mlyhQcsZL/f6Z8xYAGc+S/m6vgLouqhmKI1Ri
         bFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698297386; x=1698902186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcRpgRwe25+UkQEfJDZGZHuA0KvrCaL/46MeTSbRYhg=;
        b=oyVqpLkoAOkBOjLjPVcL904q1awXPNOk/mYqCfBjvfmAYHqwEskQ1n/pI8ZEzOCGjE
         It6ul57AB7Re90UkK8cELk0S/iU7rFuvRg8OBVjgElJfDBGfG2vmmNTWa1wgd5YuVIYm
         GHR+3ZOVkUMsRV2OcF9+U/51utPfna+X1DPv6Vmwo7e4irxk/it2UfjhPbfxPw5ojY5/
         9AUZcBTFE4nYXaXAbvhrGSj0u0sCTyrnYcmrzt0D5+1AAeID9e2wSMK5Vtj3y+RDvxit
         mtFGCazvutP8Y4BOgV4ku3sN91KG+NvK2zL+9iQYkyfzRpQ6kyOo6giStgdei8PJvUbW
         XkXw==
X-Gm-Message-State: AOJu0YyHOUmaqWvLGltb5CrGfqvCgn/By7iWsEvfOdVu/oyuVhW/UG4w
        wTIA5dOHzsp5M/EwubafH5FH8j9rg8DGdP5d16pWRw5qJmY=
X-Google-Smtp-Source: AGHT+IGm5bZjOgdS9pjD1LIYa7YuuuCqRiJOGCr3vjsX7/7RF6uJ7LiB5Vye26ZWHi1SfuEmS2VI7QPhio+2h5rNG1I=
X-Received: by 2002:a05:6214:c85:b0:65b:1594:264e with SMTP id
 r5-20020a0562140c8500b0065b1594264emr17698166qvr.51.1698297385896; Wed, 25
 Oct 2023 22:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231026100157.735d7dee@canb.auug.org.au>
In-Reply-To: <20231026100157.735d7dee@canb.auug.org.au>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 Oct 2023 08:16:14 +0300
Message-ID: <CAOQ4uxjmRena4AB3yMQhBJ58c6DRtkDJJrnTgFe=gWsadSdbQw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 bcachefs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
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

On Thu, Oct 26, 2023 at 2:02=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>
>   include/linux/exportfs.h
>
> between commit:
>
>   85e95ca7cc48 ("bcachefs: Update export_operations for snapshots")
>
> from the bcachefs tree and commit:
>
>   2560fa66d2ac ("exportfs: define FILEID_INO64_GEN* file handle types")
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

[adding exportfs maintainers]

>
> diff --cc include/linux/exportfs.h
> index be9900cc8786,21bae8bfeef1..000000000000
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@@ -98,12 -98,17 +98,23 @@@ enum fid_type
>          */
>         FILEID_FAT_WITH_PARENT =3D 0x72,
>
>  +      /*
>  +       * 64 bit inode number, 32 bit subvolume, 32 bit generation numbe=
r:
>  +       */
>  +      FILEID_BCACHEFS_WITHOUT_PARENT =3D 0x80,
>  +      FILEID_BCACHEFS_WITH_PARENT =3D 0x81,
>  +
> +       /*
> +        * 64 bit inode number, 32 bit generation number.
> +        */
>  -      FILEID_INO64_GEN =3D 0x81,
> ++      FILEID_INO64_GEN =3D 0x82,
> +
> +       /*
> +        * 64 bit inode number, 32 bit generation number,
> +        * 64 bit parent inode number, 32 bit parent generation.
> +        */
>  -      FILEID_INO64_GEN_PARENT =3D 0x82,
> ++      FILEID_INO64_GEN_PARENT =3D 0x83,
> +

This is wrong.
Those are filesystem defined constants.
Please don't change them.

0x81/0x82 have been used by xfs and fuse for years,
even though neither defined a constant in this enum so far.

Conflicting with FILEID_BCACHEFS_WITH_PARENT is not
a serious issue, but I encourage Kent to pick different constants
for bcachefs or keep the bcachefs constants out of this enum.

It is a slight inconvenience for users that have bcachefs exported
to NFS clients and upgrade their server, but maybe that is acceptable.
In overlayfs, we encoded type OVL_FILEID_V0 and switched to encoding
type OVL_FILEID_V1, but we still accept decoding of both types, neither
of which are listed in this enum BTW.

Adding fid types to this enum is not required.
This enum is a place to standardize and for different fs to share the same
fid type/encoding as is the case with  FILEID_INO{32,64}_GEN*.
IMO, the bcachefs constant do not follow the convention in this
enum and their format is unlikely to be used by other fs, so
they should not be added to this enum at all.

Thanks,
Amir.
