Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C169C7D88FC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjJZTee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjJZTec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:34:32 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7647D187;
        Thu, 26 Oct 2023 12:34:30 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-779f2718accso101852085a.1;
        Thu, 26 Oct 2023 12:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698348869; x=1698953669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlx257uGBGuSd2Gloxav30tAY6VWTs4Trptnw4lRsxk=;
        b=KLcJFSQMh1MZw7JIYwUCsfwOChOlPh3xMI9lfevAexH+lcEMavRMag9dVwOiQix8Wy
         R80gV+UusDmeDGARJVOb8bzXGzF43DhO8EX8oKpImxEwW3ruYM2R6Y16rUMhmJ6aLHGa
         GMBr9X+JHnj18O5MdVmkAasxukG38kLm61Dw6lMlL0zoG6AlHrzN0xkFNYBoZJkrAjIa
         VTu7Oc4zfbHis7RP1DVYgEEnmGOEuxQKA/ug8ljnhNvPgB7762gUgGCluT16D1ZN8DWw
         kYOULKm/zCxi1DZQCoyjWPEGDXXME6OYsxMIFt7u5TuHn7rKd3fCBe1XgFGV1Zf+O+4O
         vLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698348869; x=1698953669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlx257uGBGuSd2Gloxav30tAY6VWTs4Trptnw4lRsxk=;
        b=Y71+Fr63Blnc+WJE/s+Mc59I24Lpi9OlaoJ6fCP0OwxjDS2BFdOzlnStkNz2ZzoDgo
         QdpvTajpLGjMGZaA+UoWDY5AASVo+0sKV1ItOwwjtIoLxoO3lNtSLNsdw+5KwO7v9f1n
         iEhRKsfW8AEvwNz2ckN3xME8I6qIVRf7hLGh3yDd1+pqMadZJO4J/mmnwkXNNqpm7E0t
         4PVpO0/Sdedw+y7u9sh7CbuMsjUc5GqCHxGgD+8w0vi6psauTQWrZyj2V5ASd9oDvMGb
         HS0JrQG6tmdak4pcuGDZApERMP5cyGJZ+8HTiG/+czXUs5mBrWdhZQ0ljLovArzNmJUW
         iSnA==
X-Gm-Message-State: AOJu0Yx05/I9o2GAFJ2dqnNVsx/BDgQCc25RC3roYC0NYkPS2c4Z/TNx
        NsElrM6w+okPziZHt+TRvnnv7m2259A/iL6f6sskLTafJIY=
X-Google-Smtp-Source: AGHT+IFa+a9Wkq0WM46wIhO/htxqSNYR6+vE26pYPjlFIxvtDnoXWFQQ67gzGR3SJ1/2Zn5PLRZUXSIs2u39F9GgLWY=
X-Received: by 2002:a0c:e34c:0:b0:66d:55d9:9522 with SMTP id
 a12-20020a0ce34c000000b0066d55d99522mr700958qvm.23.1698348869544; Thu, 26 Oct
 2023 12:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231026100157.735d7dee@canb.auug.org.au> <CAOQ4uxjmRena4AB3yMQhBJ58c6DRtkDJJrnTgFe=gWsadSdbQw@mail.gmail.com>
 <20231026183539.cffe6uljmnjgacxq@moria.home.lan>
In-Reply-To: <20231026183539.cffe6uljmnjgacxq@moria.home.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 Oct 2023 22:34:18 +0300
Message-ID: <CAOQ4uxhNDADk9CgSMxKc93qunDUD17AFaA+tuSni9AOsjkfPYw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 bcachefs tree
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <brauner@kernel.org>,
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

On Thu, Oct 26, 2023 at 9:35=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Oct 26, 2023 at 08:16:14AM +0300, Amir Goldstein wrote:
> > On Thu, Oct 26, 2023 at 2:02=E2=80=AFAM Stephen Rothwell <sfr@canb.auug=
.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > Today's linux-next merge of the vfs-brauner tree got a conflict in:
> > >
> > >   include/linux/exportfs.h
> > >
> > > between commit:
> > >
> > >   85e95ca7cc48 ("bcachefs: Update export_operations for snapshots")
> > >
> > > from the bcachefs tree and commit:
> > >
> > >   2560fa66d2ac ("exportfs: define FILEID_INO64_GEN* file handle types=
")
> > >
> > > from the vfs-brauner tree.
> > >
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your t=
ree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particula=
rly
> > > complex conflicts.
> > >
> > > --
> > > Cheers,
> > > Stephen Rothwell
> >
> > [adding exportfs maintainers]
> >
> > >
> > > diff --cc include/linux/exportfs.h
> > > index be9900cc8786,21bae8bfeef1..000000000000
> > > --- a/include/linux/exportfs.h
> > > +++ b/include/linux/exportfs.h
> > > @@@ -98,12 -98,17 +98,23 @@@ enum fid_type
> > >          */
> > >         FILEID_FAT_WITH_PARENT =3D 0x72,
> > >
> > >  +      /*
> > >  +       * 64 bit inode number, 32 bit subvolume, 32 bit generation n=
umber:
> > >  +       */
> > >  +      FILEID_BCACHEFS_WITHOUT_PARENT =3D 0x80,
> > >  +      FILEID_BCACHEFS_WITH_PARENT =3D 0x81,
> > >  +
> > > +       /*
> > > +        * 64 bit inode number, 32 bit generation number.
> > > +        */
> > >  -      FILEID_INO64_GEN =3D 0x81,
> > > ++      FILEID_INO64_GEN =3D 0x82,
> > > +
> > > +       /*
> > > +        * 64 bit inode number, 32 bit generation number,
> > > +        * 64 bit parent inode number, 32 bit parent generation.
> > > +        */
> > >  -      FILEID_INO64_GEN_PARENT =3D 0x82,
> > > ++      FILEID_INO64_GEN_PARENT =3D 0x83,
> > > +
> >
> > This is wrong.
> > Those are filesystem defined constants.
> > Please don't change them.
> >
> > 0x81/0x82 have been used by xfs and fuse for years,
> > even though neither defined a constant in this enum so far.
>
> Perhaps we could get that fixed...?

commit 2560fa66d2ac ("exportfs: define FILEID_INO64_GEN*
file handle types") fixes that for fuse.
I may fix up xfs to use these constants later.

>
> > Conflicting with FILEID_BCACHEFS_WITH_PARENT is not
> > a serious issue, but I encourage Kent to pick different constants
> > for bcachefs or keep the bcachefs constants out of this enum.
>
> Happy to do so. Since it seems this enum doesn't have all the constants
> I'd need to avoid conflicting with, I might need some help here :)
>

Technically, you don't *need* to avoid conflicting with fileid types
of other filesystems and you do not *need* to define your constant
in this enum. It serves no real purpose unless your constant
declares a fileid format that other filesystems also use.

See the comment at the top of the enum.

> > It is a slight inconvenience for users that have bcachefs exported
> > to NFS clients and upgrade their server, but maybe that is acceptable.
> > In overlayfs, we encoded type OVL_FILEID_V0 and switched to encoding
> > type OVL_FILEID_V1, but we still accept decoding of both types, neither
> > of which are listed in this enum BTW.
> >
> > Adding fid types to this enum is not required.
> > This enum is a place to standardize and for different fs to share the s=
ame
> > fid type/encoding as is the case with  FILEID_INO{32,64}_GEN*.
> > IMO, the bcachefs constant do not follow the convention in this
> > enum and their format is unlikely to be used by other fs, so
> > they should not be added to this enum at all.
>
> Eh?
>
> Most of the constants here appear to be completely filesystem specific -
> I see UDF, nilfs, btrfs, fat...
>

There is no good reason for those to be in the enum either
other than documentation.

> And since you also don't want conflicts with fid_types that aren't
> defined here, it seems like they really should all be here.

If you define your constants internally in bcachefs, I don't care
about conflicts, but if I were you, I would avoid conflicts with
the known types.

If you want to define your constants in this enum please choose
any vacant 0x?{1,2} values. 0xb{1,2}?

Thanks,
Amir.
