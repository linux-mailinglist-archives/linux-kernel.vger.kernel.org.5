Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A9277A103
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 18:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjHLQ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHLQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 12:26:11 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF991BEC;
        Sat, 12 Aug 2023 09:26:14 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44768e056e1so1235785137.1;
        Sat, 12 Aug 2023 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691857573; x=1692462373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpQF2jb9S26eRaRt+HxIZRVdjuYf869tDcD3W/2sESQ=;
        b=cBvxQ9L83Yt5nefPpuvc0YUpLvWPtYQbXXa+ZaxS2i67igSA6xiM+Wk1iyK5oYvHDC
         RkvpXNf24mb77xD29WDqaDw9dtqVZbXtdWh6OsMDW6igCElVVu5r0LqU8myR1wimnnU5
         KAorAKstgaQvAisdQ9EutXqr9ujnamX/Rwi526rmDqRvjWPue2V2Q4t7DpVc0OfD+cbv
         ofOYIsWz2S77qo74unKyDDwXDPqjv8akSK4601Oji+LfZrVJcufI42Gh35t9vOBDYpsg
         NMZH/dLdLQO+kVYWNl7Wrv07hGFHtkMreZy+Y/AxKqkCl40DMqaE+2St2vXcPtoPYpQ3
         6G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691857573; x=1692462373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpQF2jb9S26eRaRt+HxIZRVdjuYf869tDcD3W/2sESQ=;
        b=P7HsuHDimNnqgmUeFZnuDrUUlHUM8Qmui79mLbP3VWo1VA51x5kP2ps+BWI3NvVj1Q
         9Ki4xvUgKGUtdRB73a9vjADPi0RimPwBePljIE/NHJ7PCFrCGbYtgDlkw3DKG8SZjnqF
         gt34hS8qKqqJQltVxLyXSpc29xryc3+pQZXtsESkbAnkJV8ePumKqBA5QS+mRKbId4gx
         Ff1wKHCO9+dKhuH7bgoSSi8TNTJ8/pirUkzJeaV9reAyqqDb38gUTmt7PpXX2hxAHCsl
         uURYb0rcA4pjKEQJa6Iqm20IuEXHGDEcoa748ZM8/weTFU8sP06zBenxa4Dj+sXkE6wa
         yv+w==
X-Gm-Message-State: AOJu0YycneOlchGtY5P4uCQXmsedhfl5ghhgeuW2xusIU5Y2SAEZgkUq
        Y3h5E6JyXXyYA4uf+sgQcVOikp28TbUCy6QSpqGqsGEm7uk=
X-Google-Smtp-Source: AGHT+IHgx8NCZclLuhUoLggEHg4viiFjhX4VIzJENOwxmr3Cef8qND6lwpro6gGBYdP55BZ0wWqFs0ImGpU/K842oOI=
X-Received: by 2002:a67:db81:0:b0:443:7170:b048 with SMTP id
 f1-20020a67db81000000b004437170b048mr4486829vsk.27.1691857572983; Sat, 12 Aug
 2023 09:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230521082813.17025-1-andrea.righi@canonical.com>
 <20230521082813.17025-4-andrea.righi@canonical.com> <CAJfpegtK=dh0yNdvxSC8YF6vOYqGPM5EOWny07jYDdFc0qfhTQ@mail.gmail.com>
 <CAOQ4uxjxSVNqicAUhevCXEuRZGZdAPhz4BksM8yE5HbE0piZ6A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjxSVNqicAUhevCXEuRZGZdAPhz4BksM8yE5HbE0piZ6A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Aug 2023 19:26:01 +0300
Message-ID: <CAOQ4uxgzVVh1F6QiMKcXdBsYaVC7zsF4mCLciYnFU8hBvxzgkA@mail.gmail.com>
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

On Fri, Aug 11, 2023 at 12:14=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Mon, Jul 24, 2023 at 5:43=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Sun, 21 May 2023 at 10:28, Andrea Righi <andrea.righi@canonical.com>=
 wrote:
> > >
> > > When CONFIG_OVERLAY_FS_DEBUG is enabled add an explicit check to make
> > > sure that OVL_FS() is always used with a valid overlayfs superblock.
> > > Otherwise trigger a WARN_ON_ONCE().
> > >
> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > > ---
> > >  fs/overlayfs/ovl_entry.h | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > > index b32c38fdf3c7..e156649d9c71 100644
> > > --- a/fs/overlayfs/ovl_entry.h
> > > +++ b/fs/overlayfs/ovl_entry.h
> > > @@ -97,8 +97,20 @@ static inline struct mnt_idmap *ovl_upper_mnt_idma=
p(struct ovl_fs *ofs)
> > >
> > >  extern struct file_system_type ovl_fs_type;
> > >
> > > +static inline bool is_ovl_fs_sb(struct super_block *sb)
> > > +{
> > > +       return sb->s_type =3D=3D &ovl_fs_type;
> > > +}
> > > +
> > > +#ifdef CONFIG_OVERLAY_FS_DEBUG
> > > +#define OVL_VALIDATE_SB(__sb)  WARN_ON_ONCE(!is_ovl_fs_sb(__sb))
> > > +#else
> > > +#define OVL_VALIDATE_SB(__sb)
> > > +#endif
> > > +
> > >  static inline struct ovl_fs *OVL_FS(struct super_block *sb)
> > >  {
> > > +       OVL_VALIDATE_SB(sb);
> >
> > This could be written simply and naturally:
> >
> >     if (IS_ENABLED(CONFIG_OVERLAY_FS_DEBUG))
> >          WARN_ON_ONCE(sb->s_type !=3D &ovl_fs_type)
> >
>
> Andrea,
>
> There is an inherent challenge with a cleanup series like this one
> that touches many functions to avoid merge conflicts with other
> devel branches. I did not try, but I expect there are conflicts
> with the current overlayfs-next branch.
>
> I also see at least one new direct reference of sb->s_fs_info
> in ovl_maybe_validate_verity().
>
> Please make sure to base your next submission on overlayfs-next
> branch from git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.g=
it.
>
> Once you do that, we could apply your patches to overlayfs-next
> so they won't get stale again.

Nevermind, I had rebased overlayfs-next, so already applied your
patches with the needed conflict resolutions and addressed Miklos' comment.

Thanks,
Amir.
