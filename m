Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B558778986
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjHKJOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHKJOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:14:53 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3419E1BD;
        Fri, 11 Aug 2023 02:14:53 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a76d882052so1501253b6e.0;
        Fri, 11 Aug 2023 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691745291; x=1692350091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diGjMzcK+6SwwH5w7FGvR2kPAAmdD+cz2vEifZfgJK8=;
        b=SbKT5GtBaVAtViOg16H84jFbWDFn0jS71cTFCxl3yu2Z5XZBKYkSsCA2sYG0VzYiGp
         PH1py9bPCQRdBGBwKtfJ0vzlyWPVXM67CeMCq2v5SqiglhgKpe7Mm8TuioT0sdVOZ6am
         KLYGlM63xRP2M6NEAGTXIJz6VIobvuw6igJfjFj4uLoaoD1WqLcsQbimAgnnndcOfAzP
         yM6k3J21X6dF1v4MAlQ4q03zvR0js/HKmKTM3pKaAID1iGMgg66v5kkqskK43X/3zYxH
         NSNFf/H/L6lFJDwxuTMIRAh/Q6IhwwSLJ9TkxLD0T6IwICgwWNFVU1l3dSypg75O8o3s
         jioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691745291; x=1692350091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diGjMzcK+6SwwH5w7FGvR2kPAAmdD+cz2vEifZfgJK8=;
        b=hOTMumLFuTVpktox7e2uxy8q5/bz77eCjx3+kDojx6BlKAN7m13rfrTwFUKFLKmwPF
         SD2K7xG9eXpAYFl0NYL0Y/Usrx2JZk+AescXxtjmUVzNSrzyjrbDQ6G5Gb/hAhJTGbLV
         o9Cba8Z/51WakB2q9qxO7HICX0cwWH7KcCrVMJU4ziXO1bli1nGDTVL2rcUZNgOAsyNy
         WWgcC0Yg/XmEm6MO/LbgBET6yLTomhF60Ugp8DUE/RqetkzFgBBlBUOwKCRanukCSncz
         JLPcs7X4MnnWBurh2Pnt/MUO33Irn2omp2cGQOijkZOYzZpU8/a2x6Lw7JoaHp1B2Uzv
         Pr7g==
X-Gm-Message-State: AOJu0Yynn/dTf3CUCoqdmVvkFG8tPJOdte/XZ9+Z2l30BVVJcVwDzWJK
        ZgSzIFOzCZBr45t1AKjRSWYAsC+WrARi2sJMzh8Ydqei+bw=
X-Google-Smtp-Source: AGHT+IF8ydQX+PE1GNDYJsiJelaw0s8oI1yTQGzWRJFgxbaZmi/idQI7p42d4mBdnXlb4udJcfxd5sqYWMXrXIGJfv0=
X-Received: by 2002:a05:6358:998d:b0:139:b123:ae9 with SMTP id
 j13-20020a056358998d00b00139b1230ae9mr1558616rwb.16.1691745291399; Fri, 11
 Aug 2023 02:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230521082813.17025-1-andrea.righi@canonical.com>
 <20230521082813.17025-4-andrea.righi@canonical.com> <CAJfpegtK=dh0yNdvxSC8YF6vOYqGPM5EOWny07jYDdFc0qfhTQ@mail.gmail.com>
In-Reply-To: <CAJfpegtK=dh0yNdvxSC8YF6vOYqGPM5EOWny07jYDdFc0qfhTQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 11 Aug 2023 12:14:40 +0300
Message-ID: <CAOQ4uxjxSVNqicAUhevCXEuRZGZdAPhz4BksM8yE5HbE0piZ6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ovl: validate superblock in OVL_FS()
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Andrea Righi <andrea.righi@canonical.com>
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jul 24, 2023 at 5:43=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sun, 21 May 2023 at 10:28, Andrea Righi <andrea.righi@canonical.com> w=
rote:
> >
> > When CONFIG_OVERLAY_FS_DEBUG is enabled add an explicit check to make
> > sure that OVL_FS() is always used with a valid overlayfs superblock.
> > Otherwise trigger a WARN_ON_ONCE().
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> >  fs/overlayfs/ovl_entry.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > index b32c38fdf3c7..e156649d9c71 100644
> > --- a/fs/overlayfs/ovl_entry.h
> > +++ b/fs/overlayfs/ovl_entry.h
> > @@ -97,8 +97,20 @@ static inline struct mnt_idmap *ovl_upper_mnt_idmap(=
struct ovl_fs *ofs)
> >
> >  extern struct file_system_type ovl_fs_type;
> >
> > +static inline bool is_ovl_fs_sb(struct super_block *sb)
> > +{
> > +       return sb->s_type =3D=3D &ovl_fs_type;
> > +}
> > +
> > +#ifdef CONFIG_OVERLAY_FS_DEBUG
> > +#define OVL_VALIDATE_SB(__sb)  WARN_ON_ONCE(!is_ovl_fs_sb(__sb))
> > +#else
> > +#define OVL_VALIDATE_SB(__sb)
> > +#endif
> > +
> >  static inline struct ovl_fs *OVL_FS(struct super_block *sb)
> >  {
> > +       OVL_VALIDATE_SB(sb);
>
> This could be written simply and naturally:
>
>     if (IS_ENABLED(CONFIG_OVERLAY_FS_DEBUG))
>          WARN_ON_ONCE(sb->s_type !=3D &ovl_fs_type)
>

Andrea,

There is an inherent challenge with a cleanup series like this one
that touches many functions to avoid merge conflicts with other
devel branches. I did not try, but I expect there are conflicts
with the current overlayfs-next branch.

I also see at least one new direct reference of sb->s_fs_info
in ovl_maybe_validate_verity().

Please make sure to base your next submission on overlayfs-next
branch from git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git=
.

Once you do that, we could apply your patches to overlayfs-next
so they won't get stale again.

Thanks,
Amir.
