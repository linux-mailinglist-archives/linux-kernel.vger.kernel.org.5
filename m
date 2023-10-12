Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229097C6417
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 06:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376867AbjJLEcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 00:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjJLEcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 00:32:02 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14070A9;
        Wed, 11 Oct 2023 21:31:59 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b625ed7208so294715241.1;
        Wed, 11 Oct 2023 21:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697085118; x=1697689918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hiFJOL2t+hUkAr324+Y4I245GbbdgB/DrIjwr1XVLY=;
        b=BbNoZwp2FORO6exw3VkpEt7drniMK/A+5YW21tnlPhT9oVbhvnqd/zHf8/Kn555CVh
         GcgeO6ir6EUEQYVYwdA1Cw4YkBoDRXd56uxJz7d4GspXZebGE8znVGU7+CU6PZUOUQKe
         xw4D5PsFAhWkQ/2jB92lu4lLkySVZ6M44m4gknWh88eeFpIySmZmcnZ0//LBs97aHOCt
         fv1M4YWcX0vzOaa97lG2YNHMULZeVHwhIBZWnEQ6X5YSUu0FEKgnVzDAwdh3qQy/xQkt
         YAcI5nWJor1uciHBh69ydwi9jaFzujJyZ3Gag4nFOaCDJDAHkcoZoEQZk+uiw3AqAlcM
         IKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697085118; x=1697689918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hiFJOL2t+hUkAr324+Y4I245GbbdgB/DrIjwr1XVLY=;
        b=Q3nNqpS1/RrBM51fPMZkoLWv4gJiisOzonbUTsrSrIQ/8jSGd4iQmkxNWG0Wyl1HAj
         jcg1tE0UVi45s9rstaVjr1RDQmbuzen67es5OC08GxvsQtA4prKJnl3QuBzAHhN8cyQN
         lo4Zy0MQM6EIARCVCPXTA52Xv7kLG4JKUv59YJ9rN22+B4a1CZYqGXf2wsnYdtwWcclv
         NgI13iopWMFCGnCzCBlS686PO7FGqZ9Qb+xb5JpDKBB8jxsYtm/q/z2bl6U08A0A2zT2
         ZCDkjsXQwylCzeZ5s7x8da2W6pK2F8hrkUor/Ltzu4Efw6Em+9aq8F6ZPp7OQxfgJZw5
         p0XA==
X-Gm-Message-State: AOJu0Yy/UkAuf/zD4MsBy6T4mMBNJ0cS/Ol5ryhvvGZzK8ZgLMakm5uO
        bW/VG8wmQ3+tbOe+uAi8JX5MbCJU8ouQk90Plps=
X-Google-Smtp-Source: AGHT+IFC1zDyCV1N3GRhhC60qYCcSy+15VG4IDhENiCwj70q9l9TB/ZScUjNTtlBtrUYuNlJk5jRL7nwiJDXCXljMDs=
X-Received: by 2002:a67:f043:0:b0:452:de00:7ab4 with SMTP id
 q3-20020a67f043000000b00452de007ab4mr23422802vsm.5.1697085118110; Wed, 11 Oct
 2023 21:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230817235810.596458-2-alistair.francis@wdc.com>
 <2023081959-spinach-cherisher-b025@gregkh> <CAKmqyKM+DNTF1f0FvDEda_db792Ta4w_uAKNTZ6E3NkYoVcPFQ@mail.gmail.com>
 <2023082325-cognitive-dispose-1180@gregkh> <CAKmqyKMMKJN7HU_achBc8S6-Jx16owrthwDDRWysMZe=jymnMA@mail.gmail.com>
 <2023083111-impulsive-majestic-24ee@gregkh> <2023083139-underling-amuser-772e@gregkh>
 <2023090142-circling-probably-7828@gregkh> <2023100539-playgroup-stoppable-d5d4@gregkh>
 <CAKmqyKOgej1jiiHsoLuDKXwdLDGa4njrndu6c1=bxnqk2NM58Q@mail.gmail.com> <2023101113-swimwear-squealer-464c@gregkh>
In-Reply-To: <2023101113-swimwear-squealer-464c@gregkh>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 12 Oct 2023 14:31:31 +1000
Message-ID: <CAKmqyKMX3HDphrWHYcdnLEjMwe1pCROcPNZchPonhsLOq=FoHw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to attribute_group
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 4:44=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Oct 11, 2023 at 03:10:39PM +1000, Alistair Francis wrote:
> > On Thu, Oct 5, 2023 at 11:05=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Sep 01, 2023 at 11:00:59PM +0200, Greg KH wrote:
> > > > On Thu, Aug 31, 2023 at 04:36:13PM +0200, Greg KH wrote:
> > > > > On Thu, Aug 31, 2023 at 10:31:07AM +0200, Greg KH wrote:
> > > > > > On Mon, Aug 28, 2023 at 03:05:41PM +1000, Alistair Francis wrot=
e:
> > > > > > > On Wed, Aug 23, 2023 at 5:02=E2=80=AFPM Greg KH <gregkh@linux=
foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, Aug 22, 2023 at 04:20:06PM -0400, Alistair Francis =
wrote:
> > > > > > > > > On Sat, Aug 19, 2023 at 6:57=E2=80=AFAM Greg KH <gregkh@l=
inuxfoundation.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Aug 17, 2023 at 07:58:09PM -0400, Alistair Fran=
cis wrote:
> > > > > > > > > > > The documentation for sysfs_merge_group() specificall=
y says
> > > > > > > > > > >
> > > > > > > > > > >     This function returns an error if the group doesn=
't exist or any of the
> > > > > > > > > > >     files already exist in that group, in which case =
none of the new files
> > > > > > > > > > >     are created.
> > > > > > > > > > >
> > > > > > > > > > > So just not adding the group if it's empty doesn't wo=
rk, at least not
> > > > > > > > > > > with the code we currently have. The code can be chan=
ged to support
> > > > > > > > > > > this, but it is difficult to determine how this will =
affect existing use
> > > > > > > > > > > cases.
> > > > > > > > > >
> > > > > > > > > > Did you try?  I'd really really really prefer we do it =
this way as it's
> > > > > > > > > > much simpler overall to have the sysfs core "do the rig=
ht thing
> > > > > > > > > > automatically" than to force each and every bus/subsyst=
em to have to
> > > > > > > > > > manually add this type of attribute.
> > > > > > > > > >
> > > > > > > > > > Also, on a personal level, I want this function to work=
 as it will allow
> > > > > > > > > > us to remove some code in some busses that don't really=
 need to be there
> > > > > > > > > > (dynamic creation of some device attributes), which wil=
l then also allow
> > > > > > > > > > me to remove some apis in the driver core that should n=
ot be used at all
> > > > > > > > > > anymore (but keep creeping back in as there is still a =
few users.)
> > > > > > > > > >
> > > > > > > > > > So I'll be selfish here and say "please try to get my p=
roposed change to
> > > > > > > > > > work, it's really the correct thing to do here."
> > > > > > > > >
> > > > > > > > > I did try!
> > > > > > > > >
> > > > > > > > > This is an attempt:
> > > > > > > > > https://github.com/alistair23/linux/commit/56b55756a2d7a6=
6f7b6eb8a5692b1b5e2f81a9a9
> > > > > > > > >
> > > > > > > > > It is based on your original patch with a bunch of:
> > > > > > > > >
> > > > > > > > > if (!parent) {
> > > > > > > > >     parent =3D kernfs_create_dir_ns(kobj->sd, grp->name,
> > > > > > > > >                   S_IRWXU | S_IRUGO | S_IXUGO,
> > > > > > > > >                   uid, gid, kobj, NULL);
> > > > > > > > >     ...
> > > > > > > > >     }
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > added throughout the code base.
> > > > > > > > >
> > > > > > > > > Very basic testing shows that it does what I need it to d=
o and I don't
> > > > > > > > > see any kernel oops on boot.
> > > > > > > >
> > > > > > > > Nice!
> > > > > > > >
> > > > > > > > Mind if I take it and clean it up a bit and test with it he=
re?  Again, I
> > > > > > > > need this functionality for other stuff as well, so getting=
 it merged
> > > > > > > > for your feature is fine with me.
> > > > > > >
> > > > > > > Sure! Go ahead. Sorry I was travelling last week.
> > > > > > >
> > > > > > > >
> > > > > > > > > I prefer the approach I have in this mailing list patch. =
But if you
> > > > > > > > > like the commit mentioned above I can tidy and clean it u=
p and then
> > > > > > > > > use that instead
> > > > > > > >
> > > > > > > > I would rather do it this way.  I can work on this on Frida=
y if you want
> > > > > > > > me to.
> > > > > > >
> > > > > > > Yeah, that's fine with me. If you aren't able to let me know =
and I can
> > > > > > > finish up the patch and send it with this series
> > > > > >
> > > > > > Great, and for the email record, as github links are not stable=
, here's
> > > > > > the patch that you have above attached below.  I'll test this o=
ut and
> > > > > > clean it up a bit more and see how it goes...
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > > > >
> > > > > >
> > > > > > From 2929d17b58d02dcf52d0345fa966c616e09a5afa Mon Sep 17 00:00:=
00 2001
> > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Date: Wed, 24 Aug 2022 15:45:36 +0200
> > > > > > Subject: [PATCH] sysfs: do not create empty directories if no a=
ttributes are
> > > > > >  present
> > > > > >
> > > > > > When creating an attribute group, if it is named a subdirectory=
 is
> > > > > > created and the sysfs files are placed into that subdirectory. =
 If no
> > > > > > files are created, normally the directory would still be presen=
t, but it
> > > > > > would be empty.  Clean this up by removing the directory if no =
files
> > > > > > were successfully created in the group at all.
> > > > > >
> > > > > > Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org=
>
> > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Co-developed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > ---
> > > > > >  fs/sysfs/file.c  | 14 ++++++++++--
> > > > > >  fs/sysfs/group.c | 56 ++++++++++++++++++++++++++++++++++++----=
--------
> > > > > >  2 files changed, 54 insertions(+), 16 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > > > > > index a12ac0356c69..7aab6c09662c 100644
> > > > > > --- a/fs/sysfs/file.c
> > > > > > +++ b/fs/sysfs/file.c
> > > > > > @@ -391,8 +391,18 @@ int sysfs_add_file_to_group(struct kobject=
 *kobj,
> > > > > >           kernfs_get(parent);
> > > > > >   }
> > > > > >
> > > > > > - if (!parent)
> > > > > > -         return -ENOENT;
> > > > > > + if (!parent) {
> > > > > > +         parent =3D kernfs_create_dir_ns(kobj->sd, group,
> > > > > > +                                   S_IRWXU | S_IRUGO | S_IXUGO=
,
> > > > > > +                                   uid, gid, kobj, NULL);
> > > > > > +         if (IS_ERR(parent)) {
> > > > > > +                 if (PTR_ERR(parent) =3D=3D -EEXIST)
> > > > > > +                         sysfs_warn_dup(kobj->sd, group);
> > > > > > +                 return PTR_ERR(parent);
> > > > > > +         }
> > > > > > +
> > > > > > +         kernfs_get(parent);
> > > > > > + }
> > > > > >
> > > > > >   kobject_get_ownership(kobj, &uid, &gid);
> > > > > >   error =3D sysfs_add_file_mode_ns(parent, attr, attr->mode, ui=
d, gid,
> > > > > > diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> > > > > > index 138676463336..013fa333cd3c 100644
> > > > > > --- a/fs/sysfs/group.c
> > > > > > +++ b/fs/sysfs/group.c
> > > > > > @@ -31,12 +31,14 @@ static void remove_files(struct kernfs_node=
 *parent,
> > > > > >                   kernfs_remove_by_name(parent, (*bin_attr)->at=
tr.name);
> > > > > >  }
> > > > > >
> > > > > > +/* returns -ERROR if error, or >=3D 0 for number of files actu=
ally created */
> > > > > >  static int create_files(struct kernfs_node *parent, struct kob=
ject *kobj,
> > > > > >                   kuid_t uid, kgid_t gid,
> > > > > >                   const struct attribute_group *grp, int update=
)
> > > > > >  {
> > > > > >   struct attribute *const *attr;
> > > > > >   struct bin_attribute *const *bin_attr;
> > > > > > + int files_created =3D 0;
> > > > > >   int error =3D 0, i;
> > > > > >
> > > > > >   if (grp->attrs) {
> > > > > > @@ -65,6 +67,8 @@ static int create_files(struct kernfs_node *p=
arent, struct kobject *kobj,
> > > > > >                                                  gid, NULL);
> > > > > >                   if (unlikely(error))
> > > > > >                           break;
> > > > > > +
> > > > > > +                 files_created++;
> > > > > >           }
> > > > > >           if (error) {
> > > > > >                   remove_files(parent, grp);
> > > > > > @@ -95,12 +99,15 @@ static int create_files(struct kernfs_node =
*parent, struct kobject *kobj,
> > > > > >                                                      NULL);
> > > > > >                   if (error)
> > > > > >                           break;
> > > > > > +                 files_created++;
> > > > > >           }
> > > > > >           if (error)
> > > > > >                   remove_files(parent, grp);
> > > > > >   }
> > > > > >  exit:
> > > > > > - return error;
> > > > > > + if (error)
> > > > > > +         return error;
> > > > > > + return files_created;
> > > > > >  }
> > > > > >
> > > > > >
> > > > > > @@ -130,9 +137,14 @@ static int internal_create_group(struct ko=
bject *kobj, int update,
> > > > > >           if (update) {
> > > > > >                   kn =3D kernfs_find_and_get(kobj->sd, grp->nam=
e);
> > > > > >                   if (!kn) {
> > > > > > -                         pr_warn("Can't update unknown attr gr=
p name: %s/%s\n",
> > > > > > -                                 kobj->name, grp->name);
> > > > > > -                         return -EINVAL;
> > > > > > +                         kn =3D kernfs_create_dir_ns(kobj->sd,=
 grp->name,
> > > > > > +                                                   S_IRWXU | S=
_IRUGO | S_IXUGO,
> > > > > > +                                                   uid, gid, k=
obj, NULL);
> > > > > > +                         if (IS_ERR(kn)) {
> > > > > > +                                 if (PTR_ERR(kn) =3D=3D -EEXIS=
T)
> > > > > > +                                         sysfs_warn_dup(kobj->=
sd, grp->name);
> > > > > > +                                 return PTR_ERR(kn);
> > > > > > +                         }
> > > > > >                   }
> > > > > >           } else {
> > > > > >                   kn =3D kernfs_create_dir_ns(kobj->sd, grp->na=
me,
> > > > > > @@ -150,11 +162,18 @@ static int internal_create_group(struct k=
object *kobj, int update,
> > > > > >
> > > > > >   kernfs_get(kn);
> > > > > >   error =3D create_files(kn, kobj, uid, gid, grp, update);
> > > > > > - if (error) {
> > > > > > + if (error <=3D 0) {
> > > > > > +         /*
> > > > > > +          * If an error happened _OR_ if no files were created=
 in the
> > > > > > +          * attribute group, and we have a name for this group=
, delete
> > > > > > +          * the name so there's not an empty directory.
> > > > > > +          */
> > > > > >           if (grp->name)
> > > > > >                   kernfs_remove(kn);
> > > > > > + } else {
> > > > > > +         error =3D 0;
> > > > > > +         kernfs_put(kn);
> > > > > >   }
> > > > > > - kernfs_put(kn);
> > > > > >
> > > > > >   if (grp->name && update)
> > > > > >           kernfs_put(kn);
> > > > > > @@ -318,13 +337,12 @@ void sysfs_remove_groups(struct kobject *=
kobj,
> > > > > >  EXPORT_SYMBOL_GPL(sysfs_remove_groups);
> > > > > >
> > > > > >  /**
> > > > > > - * sysfs_merge_group - merge files into a pre-existing attribu=
te group.
> > > > > > + * sysfs_merge_group - merge files into a attribute group.
> > > > > >   * @kobj:        The kobject containing the group.
> > > > > >   * @grp: The files to create and the attribute group they belo=
ng to.
> > > > > >   *
> > > > > > - * This function returns an error if the group doesn't exist o=
r any of the
> > > > > > - * files already exist in that group, in which case none of th=
e new files
> > > > > > - * are created.
> > > > > > + * This function returns an error if any of the files already =
exist in
> > > > > > + * that group, in which case none of the new files are created=
.
> > > > > >   */
> > > > > >  int sysfs_merge_group(struct kobject *kobj,
> > > > > >                  const struct attribute_group *grp)
> > > > > > @@ -336,12 +354,22 @@ int sysfs_merge_group(struct kobject *kob=
j,
> > > > > >   struct attribute *const *attr;
> > > > > >   int i;
> > > > > >
> > > > > > - parent =3D kernfs_find_and_get(kobj->sd, grp->name);
> > > > > > - if (!parent)
> > > > > > -         return -ENOENT;
> > > > > > -
> > > > > >   kobject_get_ownership(kobj, &uid, &gid);
> > > > > >
> > > > > > + parent =3D kernfs_find_and_get(kobj->sd, grp->name);
> > > > > > + if (!parent) {
> > > > > > +         parent =3D kernfs_create_dir_ns(kobj->sd, grp->name,
> > > > > > +                                   S_IRWXU | S_IRUGO | S_IXUGO=
,
> > > > > > +                                   uid, gid, kobj, NULL);
> > > > > > +         if (IS_ERR(parent)) {
> > > > > > +                 if (PTR_ERR(parent) =3D=3D -EEXIST)
> > > > > > +                         sysfs_warn_dup(kobj->sd, grp->name);
> > > > > > +                 return PTR_ERR(parent);
> > > > > > +         }
> > > > > > +
> > > > > > +         kernfs_get(parent);
> > > > > > + }
> > > > > > +
> > > > > >   for ((i =3D 0, attr =3D grp->attrs); *attr && !error; (++i, +=
+attr))
> > > > > >           error =3D sysfs_add_file_mode_ns(parent, *attr, (*att=
r)->mode,
> > > > > >                                          uid, gid, NULL);
> > > > > > --
> > > > > > 2.42.0
> > > > > >
> > > > >
> > > > > And as the 0-day bot just showed, this patch isn't going to work
> > > > > properly, the uid/gid stuff isn't all hooked up properly, I'll wo=
rk on
> > > > > fixing that up when I get some cycles...
> > > >
> > > > Oops, nope, that was my fault in applying this to my tree, sorry fo=
r the
> > > > noise...
> > >
> > > And I just got around to testing this, and it does not boot at all.
> > > Below is the patch I am using, are you sure you got this to boot for
> > > you?
> >
> > I just checked again and it boots for me. What failure are you seeing?
>
> Block devices were not created properly in sysfs.

Strange. I have tested this on a QEMU virtual machine and a x86 PC and
I don't see any issues on either.

>
> Did you test your patch, or my modified one that I attached on this
> email?  That might be the difference.

I'm using your modified one.

Are you able to provide logs? There must be some driver that is
causing the issue. I can try to reproduce it if I know where it's
failing.

Alistair

>
> thanks,
>
> greg k-h
