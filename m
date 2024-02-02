Return-Path: <linux-kernel+bounces-49572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4F4846C4C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86AE8B30211
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F27A71E;
	Fri,  2 Feb 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4KTOP1V"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD277620;
	Fri,  2 Feb 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865888; cv=none; b=ZYbp2QgnQZUz+7brjUDBiKivMBzpNa/8BjfqRCdgzN5oyLnxqzBtSuirSfv9jB/6ZjsLcsNrph9W+l/NSCPn7kNp9juRaBUB19vEdyML4hkvXNCAdncyrMUXYJB/sNu77jvWs22yh5EEo8HkycCGyPhVho2U3gKlBaLjaDoarpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865888; c=relaxed/simple;
	bh=+zPRx5GnVsdneG6x2OLDEMhNye8NXSB/IlDh18S93kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVX1GsWanupJzbMmvpeELqEtDwY8p+WHnRL39URngDT3TOU70pj9+60ORFpq0FcY6Wj3XH958gY84FJpynlmMZBDCZOO7nVdwjBMBZQtLnJxGmy2tgDrCi/nxUS9+26bhPTbF4Pgj0s7kcibD7HMEDrFOAp4Qg+R215o/0VH0KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4KTOP1V; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6869e87c8d8so8326156d6.2;
        Fri, 02 Feb 2024 01:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706865885; x=1707470685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jZ7LJ0w9u7x0tImGNxxD5E2uy3UdmNQbHbFvKlgQBE=;
        b=b4KTOP1Vu2qoEzBGRlX+5mGIjCThwrOeOVZxisya+ixpWkDMmfj0AAW7iW/xV4LlhS
         bGjhz+Vc3Tf3QGENi5nvNLd2wJUQNoXr8u4A5UrOEPK4GAD1j98aLOOIKIz/92/5i9sR
         XAPSGyK75S9J6sU2bWtH1yt2SHViz27DshdGdOqhPoH7DX3JgaQCyFSLuxWMAhSrNpZG
         aUKIT/hSaJFZvIYg9jJN7H0ER7qaxBQcNKM/txOFrsYUFxqYzx0nleucieu3kNMsCCPk
         sZFme8Ek8vmrR0qU8q9dQr79+zeVrvnMJU9NDGWHgfFsJJ3k5SlmmRuy4nzrZS0GsYS5
         90Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706865885; x=1707470685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jZ7LJ0w9u7x0tImGNxxD5E2uy3UdmNQbHbFvKlgQBE=;
        b=wgiC+/F95hLL6vzgBeAarOVZTk5cnE0tZNwnmTG1BlYKhsEZP0BvbHMmQDY8zpad4W
         Wz+Z0TfwXxOdB6vYB5oBYT5ipCQwNZNhGbT6N/am8yCjI0IYXGUKQNEsOnqqmTgdQ6uV
         yu3B5e4Sesm4Sja3xpb6DMrUBsmTQsJS7KazPtpDyoFGifrqbePnFfUTIyEUPHGk5xFh
         WS0Ec8VKPwdsimu4HlFIVbR3ZVs8qNtoSnj5XV+fQQKP7p4JMbt+OUjQYzav8/aRJmB1
         Zbz6j60sV7y2Yqzc1hk27jIzbynmrV5oWSbMTtz9vHKkFZGQE0nN0XAnPy28AUvfTYTy
         RrLA==
X-Gm-Message-State: AOJu0Yyd3t7LQzAREZe8D90sngdSlOuhWwg8C93j4qP/+euTInG+0owh
	Xtp1CAlH8rCD1J1fE0bEBTpgPIAc+g1nzptzEZDncZFwzXMCS4k0xA9A0VnLiqbzY5LLvJlA2Sr
	PkLnVF3DA//haYLX7k7hdikMLrBXIDZVsP40=
X-Google-Smtp-Source: AGHT+IEwA4CgDbG8YXcc8Jam/z+5xFg9sXc6x9vrGJG3s7TemCWJ73riLlZiqpBVJFzETzpu4gPfm/XM+qqIBfi8ClU=
X-Received: by 2002:a05:6214:1252:b0:681:7948:220d with SMTP id
 r18-20020a056214125200b006817948220dmr8109610qvv.61.1706865885495; Fri, 02
 Feb 2024 01:24:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-5-stefanb@linux.ibm.com> <38230b4c-54ae-45ed-a6fb-34e63501e5b1@linux.ibm.com>
 <CAOQ4uxiYARZBSgzb4_W-RKvB1XLSF3GUBqeLw2kH+eVeZ_8ARQ@mail.gmail.com>
 <c018b014-9ba8-4395-86dc-b61346ab20a8@linux.ibm.com> <CAOQ4uxi6Te8izWpXROthknRaXrVA9jho5nbc+mkuQDrcTLY44Q@mail.gmail.com>
 <CAOQ4uxigdNeE+2nfr4VxS9piQf5hez=ryT0a-jzW+tW0BT-zuw@mail.gmail.com>
 <492ea12a-d79d-47da-9bbe-a7f33051bd3f@linux.ibm.com> <CAOQ4uxgiO1RbsmqOu4F4Foy-MBPecnEXO7BvgDGz-Lzb1Eysog@mail.gmail.com>
 <4c584bfb-d282-4584-bb20-18c26b1033c0@linux.ibm.com> <CAOQ4uxjftr7GGx6tuW_yB_MTaVB57m6p_d=UHhN3Z23YVXY0QQ@mail.gmail.com>
 <11abffea-15c5-4d13-9d0f-edbc54b09bf3@linux.ibm.com>
In-Reply-To: <11abffea-15c5-4d13-9d0f-edbc54b09bf3@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 2 Feb 2024 11:24:33 +0200
Message-ID: <CAOQ4uxjZ6p9+H54G0LNTUnU56WRaoLtWOUj2nOaKJ4JvBGqLVg@mail.gmail.com>
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:35=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 2/1/24 09:11, Amir Goldstein wrote:
> > On Thu, Feb 1, 2024 at 3:37=E2=80=AFPM Stefan Berger <stefanb@linux.ibm=
com> wrote:
> >>
> >>
> >>
> >> On 2/1/24 07:10, Amir Goldstein wrote:
> >>> On Wed, Jan 31, 2024 at 7:46=E2=80=AFPM Stefan Berger <stefanb@linux.=
ibm.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 1/31/24 12:23, Amir Goldstein wrote:
> >>>>> On Wed, Jan 31, 2024 at 5:54=E2=80=AFPM Amir Goldstein <amir73il@gm=
ail.com> wrote:
> >>>>>>
> >>>>>> On Wed, Jan 31, 2024 at 4:40=E2=80=AFPM Stefan Berger <stefanb@lin=
ux.ibm.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 1/31/24 08:16, Amir Goldstein wrote:
> >>>>>>>> On Wed, Jan 31, 2024 at 4:11=E2=80=AFAM Stefan Berger <stefanb@l=
inux.ibm.com> wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 1/30/24 16:46, Stefan Berger wrote:
> >>>>>>>>>> Changes to the file attribute (mode bits, uid, gid) on the low=
er layer
> >>>>>>>>>> are not take into account when d_backing_inode() is used when =
a file is
> >>>>>>>>>> accessed on the overlay layer and this file has not yet been c=
opied up.
> >>>>>>>>>> This is because d_backing_inode() does not return the real ino=
de of the
> >>>>>>>>>> lower layer but instead returns the backing inode which holds =
old file
> >>>>>>>>>> attributes. When the old file attributes are used for calculat=
ing the
> >>>>>>>>>> metadata hash then the expected hash is calculated and the fil=
e then
> >>>>>>>>>> mistakenly passes signature verification. Therefore, use d_rea=
l_inode()
> >>>>>>>>>> which returns the inode of the lower layer for as long as the =
file has
> >>>>>>>>>> not been copied up and returns the upper layer's inode otherwi=
se.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>>>>>>>>> ---
> >>>>>>>>>>       security/integrity/evm/evm_crypto.c | 2 +-
> >>>>>>>>>>       1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/security/integrity/evm/evm_crypto.c b/security/in=
tegrity/evm/evm_crypto.c
> >>>>>>>>>> index b1ffd4cc0b44..2e48fe54e899 100644
> >>>>>>>>>> --- a/security/integrity/evm/evm_crypto.c
> >>>>>>>>>> +++ b/security/integrity/evm/evm_crypto.c
> >>>>>>>>>> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct de=
ntry *dentry,
> >>>>>>>>>>                                    size_t req_xattr_value_len,
> >>>>>>>>>>                                    uint8_t type, struct evm_di=
gest *data)
> >>>>>>>>>>       {
> >>>>>>>>>> -     struct inode *inode =3D d_backing_inode(dentry);
> >>>>>>>>>> +     struct inode *inode =3D d_real_inode(dentry);
> >>>>>>>>>>           struct xattr_list *xattr;
> >>>>>>>>>>           struct shash_desc *desc;
> >>>>>>>>>>           size_t xattr_size =3D 0;
> >>>>>>>>>
> >>>>>>>>> We need this patch when NOT activating CONFIG_OVERLAY_FS_METACO=
PY but
> >>>>>>>>> when setting CONFIG_OVERLAY_FS_METACOPY=3Dy it has to be revert=
ed...  I am
> >>>>>>>>> not sure what the solution is.
> >>>>>>>>
> >>>>>>>> I think d_real_inode() does not work correctly for all its curre=
nt users for
> >>>>>>>> a metacopy file.
> >>>>>>>>
> >>>>>>>> I think the solution is to change d_real_inode() to return the d=
ata inode
> >>>>>>>> and add another helper to get the metadata inode if needed.
> >>>>>>>> I will post some patches for it.
> >>>>>>>
> >>>>>>> I thought that we may have to go through vfs_getattr() but even b=
etter
> >>>>>>> if we don't because we don't have the file *file anywhere 'near'.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> However, I must say that I do not know if evm_calc_hmac_or_hash(=
)
> >>>>>>>> needs the lower data inode, the upper metadata inode or both.
> >>>>>>>
> >>>>>>> What it needs are data structures with mode bits, uid, and gid th=
at stat
> >>>>>>> in userspace would show.
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> With or without metacopy enabled, an overlay inode st_uid st_gid s=
t_mode
> >>>>>> are always taken from the upper most inode which is what d_real_in=
ode()
> >>>>>> currently returns, so I do not understand what the problem is.
> >>>>>>
> >>>>>
> >>>>> No, I was wrong. It is the other way around.
> >>>>> d_real_inode() always returns the real data inode and you need the
> >>>>> upper most real inode.
> >>>>>
> >>>>> You can try this:
> >>>>>
> >>>>>     -     struct inode *inode =3D d_backing_inode(dentry);
> >>>>> +     struct inode *inode =3D d_inode(d_real(dentry, false));
> >>>>>
> >>>>> With the changes in:
> >>>>>
> >>>>> https://github.com/amir73il/linux/commits/overlayfs-devel/
> >>>>>
> >>>>> Not thoroughly tested...
> >>>>
> >>>> The change + 3 topmost patches cherry-picked is unfortunately are
> >>>> crashing for me.
> >>>>
> >>>
> >>> I will look into it.
> >>> But anyway, the patch I suggested above is not enough exactly because
> >>> of the reason I told you earlier.
> >>>
> >>> Mimi's fix ("ima: detect changes to the backing overlay file") detect=
s
> >>> a change in d_real_inode(file_dentry(file)) in order to invalidate th=
e
> >>> IMA cache.
> >>>
> >>> Your change also invalidates EVM cache on a change in
> >>> d_real_inode(file_dentry(file)) and that makes sense.
> >>>
> >>> But on "meta copy up" for example on chmod(), an upper inode with no =
data
> >>> is created (a metacopy) and all the attributes and xattr are copied
> >>> from lower inode.
> >>> The data remains in the lower inode.
> >>>
> >>> At this point , the IMA cache and the EVM cache refer to two differen=
t inodes
> >>
> >> You mean they refer to different inodes because IMA cares about file
> >> content ("data remains in the lower inode:) and EVM cares about the
> >> metadata ("an upper inode with no data is created")? If so, I agree
> >
> > Correct.
> >
> >> since the following line after copy-up with meatacopy enabled shows th=
e
> >> proper GID is in the backing inode not the one return from
> >> d_real_inode(). If we knew that a meta copy has been done we could cal=
l
> >> d_backing_inode() in this case for access to mode bits, uid, and gid.
> >>
> >
> > You should be able to use
> > d_real_meta_inode(dentry) !=3D d_real_inode(dentry) to figure that out.
> >
> >> +       printk(KERN_INFO "real: GID: %d  backing: GID: %d\n",
> >> +              from_kgid(&init_user_ns, d_real_inode(dentry)->i_gid),
> >> +              from_kgid(&init_user_ns, d_backing_inode(dentry)->i_gid=
));
> >> +
> >>
> >>   > so you cannot share the same logic with IMA cache invalidation.
> >>
> >> I thought we we would have to share the same logic since IMA and EVM
> >> would have to refer to the same inode also since IMA and EVM are
> >> strongly connected. So the file_inode(file), which is typically used f=
or
> >> finding the iint, should be the same 'high level' inode for both EVM a=
nd
> >> IMA I thought. A different inode could then be used for file data and
> >> metadata.
> >>
> >>>
> >>> My patches are meant to provide you with a helper e.g. d_real_meta_in=
ode()
> >>
> >> The patch providing this isn't there yet in overlayfs-devel, right?
> >
> > It's there just not spelled out with these helper names:
> >
> > d_real_meta_inode(d) :=3D d_inode(d_real(dentry, false))
> > d_real_data_inode(d) :=3D d_inode(d_real(dentry, true))
> > d_real_inode(d) :=3D d_real_data_inode(d)
> >
> > I think this use case is pretty specific to EVM, so I don't think
> > I will actually define these d_real_*_inode() helpers.
> >
> >>
> >>> that you could use to get the upper inode in the case of a metacopy, =
but
> >>> IMA would still need to use the d_real_data_inode().
> >>
> >> That would be fine since we are only changing EVM code in this case.
> >
> > Yes, using those overlayfs APIs requires understanding of what they mea=
n
> > and knowing how to test the affected use cases.
> > This is not something very common for other subsystem developers.
> >
> >>>
> >>> Is that explanation clear? Is it clear why I said that the problem is=
 more
> >>> complicated?
> >>
> >> I think I understand it.
> >>
> >
> > I think I am also starting to understand the expectation from IMA/EVM
> > over overlayfs ;)
> >
> > Anyway, let me see if I can fix the problem in my WIP branch.
>
> The good news is that with your two patches applied :
>
> 3b0ed3977dd2 (HEAD) fs: make file_dentry() a simple accessor
> b5ccc40f3d50 fs: remove the inode argument to ->d_real() method

Doh! good catch!
This first fix commit was buggy.

Pushed a new fixed version:

* 4d76c382bf12 - (github/overlayfs-devel) fs: remove the inode
argument to ->d_real() method
* 2cadd1b25485 - fs: make file_dentry() a simple accessor
* 1c5e7db8e1b2 - (github/ovl-fixes) remap_range: merge
do_clone_file_range() into vfs_clone_file_range()

>
> and your suggested change to this patch :
>
> -       struct inode *inode =3D d_real_inode(dentry);
> +       struct inode *inode =3D d_inode(d_real(dentry, false));;
>

In the new version I change the API to use an enum instead of bool, e.g.:

       struct inode *inode =3D d_inode(d_real(dentry, D_REAL_METADATA));

This catches in build time and in run time, callers that were not converted
to the new API.

> The test cases are now passing with and without metacopy enabled. Yay!

Too soon to be happy.
I guess you are missing a test for the following case:
1. file was meta copied up (change is detected)
2. the lower file that contains the data is being changed (change is
not detected)

At #2 the change is not detected, because the inode version of the
lower inode is not checked.

I think the only way for you to cover this case is to store versions of bot=
h
real data and real metadata inodes...

Let me know if this version work for you and I will added you Tested-by
when I post it.

Thanks,
Amir.

