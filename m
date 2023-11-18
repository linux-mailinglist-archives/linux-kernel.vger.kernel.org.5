Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBEC7EFE92
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjKRIi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRIiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:38:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB5CB9;
        Sat, 18 Nov 2023 00:38:51 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32deb2809daso1796953f8f.3;
        Sat, 18 Nov 2023 00:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700296729; x=1700901529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+i0KfW6No8nTtUxfF3SBkoQohwSEclHyK7ryzwdT8c=;
        b=iuCus+3m61jKZMUzCL52yflh7Y6ehOdmYLZ/ewww3tMYMl562yg2/10OGM94GxUM2U
         pGDXf9jcgSguj7YL5aBIuSdPu001H/YosQwYbE5v+yfBWTJDNsXXjoT0cNBlzEQnPrJy
         RqoQexjvQWwFYT2PrE2exTbEHZF2eq/uhluKzSzOeSZKtumhDB0IRqwm5uZz8JoBTfH1
         VyyPp56SaIB8Z2Pv6EiY7lKRT8prUvTdLqxw3wXQRffv0py8pU10dp5aqPNOIjJj642l
         s3uot6TBXLJGPHlBIe2gLsN6XcMz9dKruoQyvzqEoeRuD2Fj2jk+uoiUujDwKrDIQ5W7
         Z5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700296729; x=1700901529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+i0KfW6No8nTtUxfF3SBkoQohwSEclHyK7ryzwdT8c=;
        b=aS1jadXTqvAWfC4aDjv+zgJi7mlTSXTZDt/gWhR3Rc9Lpqcxt2UfA+kcRUg9JiwDBk
         9DJ5CZ5u7aymc50mAKf93qll6W0+2a7MGy02eZdNjjbs95XjPo/6uFcDoKnnd2EHdPpS
         J3y1bUX+UBATL+CSrS1mEfhsd/uPKCX8JwPlaju9rBO4xtBDm2wLw1ImWHcHd9Eo3poP
         +1oWIrHHAXOyEIItXdJX4wUZyrLKqyhdLWN1tf1T6tsvamMA3UpssvBxiGa1PAfrPdKT
         1thwP+XrR26luoGSuemtkMAtF0nwwT9oP3bVgieC7HKVik2wWIdzXlDaF14F8B8lhNnK
         EvMQ==
X-Gm-Message-State: AOJu0Yx8KCoBMHVd01e53aSsdl2L2iCbj+OnXmlsedqoFbuChj9QIoX8
        TIb6Fbmd7nilV4wHtfovzTZRA4PuMlTg+gwa1zc=
X-Google-Smtp-Source: AGHT+IEoQrJ6KymHk1iFGh/E1XP19GUQo18VJ8jQaGfTADdIiZuy6Hyj6FugkfPQyBAurDODmiBfbZe3/TxtV+6mOGo=
X-Received: by 2002:adf:ea08:0:b0:32f:7c15:2ad7 with SMTP id
 q8-20020adfea08000000b0032f7c152ad7mr893788wrm.38.1700296728821; Sat, 18 Nov
 2023 00:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
 <202311160612.C38BF44@keescook> <202311160631.5ACFB84B7C@keescook>
 <2910678.e9J7NaK4W3@oscar> <202311161022.6B34F00641@keescook>
In-Reply-To: <202311161022.6B34F00641@keescook>
From:   Ronald Monthero <debug.penguin32@gmail.com>
Date:   Sat, 18 Nov 2023 18:38:37 +1000
Message-ID: <CALk6UxqugQ_8piS6oNr4XdwRTo9dROJ6U-iU_OHUmQC_J_-VWw@mail.gmail.com>
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
To:     Kees Cook <keescook@chromium.org>
Cc:     Anders Larsen <al@alarsen.net>, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Kees and Anders, Cheers

BR,
Ronald

On Fri, Nov 17, 2023 at 4:26=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Nov 16, 2023 at 05:48:20PM +0100, Anders Larsen wrote:
> > On 2023-11-16 15:58 Kees Cook wrote:
> > >         if ((de->di_status & QNX4_FILE_LINK) =3D=3D QNX4_FILE_LINK) {
> > >                 lnk =3D (struct qnx4_link_info *) de;
> > >
> > > It seems that entries may be either struct qnx4_inode_entry or struct
> > > qnx4_link_info but it's not captured in a union.
> > >
> > > This needs to be fixed by not lying to the compiler about what is the=
re.
> > >
> > > How about this?
> >
> > > diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> > > index 8d72221735d7..3cd20065bcfa 100644
> > > --- a/fs/qnx4/namei.c
> > > +++ b/fs/qnx4/namei.c
> > > @@ -26,31 +26,39 @@
> > >  static int qnx4_match(int len, const char *name,
> > >                   struct buffer_head *bh, unsigned long *offset)
> > >  {
> > > -   struct qnx4_inode_entry *de;
> > > -   int namelen, thislen;
> > > +   union qnx4_dir_entry *de;
> > > +   char *entry_fname;
> > > +   int entry_len, entry_max_len;
> > >
> > >     if (bh =3D=3D NULL) {
> > >             printk(KERN_WARNING "qnx4: matching unassigned buffer !
> > \n");
> > >             return 0;
> > >     }
> > > -   de =3D (struct qnx4_inode_entry *) (bh->b_data + *offset);
> > > +   de =3D (union qnx4_dir_entry *) (bh->b_data + *offset);
> > >     *offset +=3D QNX4_DIR_ENTRY_SIZE;
> > > -   if ((de->di_status & QNX4_FILE_LINK) !=3D 0) {
> > > -           namelen =3D QNX4_NAME_MAX;
> > > -   } else {
> > > -           namelen =3D QNX4_SHORT_NAME_MAX;
> > > -   }
> > > -   thislen =3D strlen( de->di_fname );
> > > -   if ( thislen > namelen )
> > > -           thislen =3D namelen;
> > > -   if (len !=3D thislen) {
> > > +
> > > +   switch (de->inode.di_status) {
> > > +   case QNX4_FILE_LINK:
> > > +           entry_fname =3D de->link.dl_fname;
> > > +           entry_max_len =3D sizeof(de->link.dl_fname);
> > > +           break;
> > > +   case QNX4_FILE_USED:
> > > +           entry_fname =3D de->inode.di_fname;
> > > +           entry_max_len =3D sizeof(de->inode.di_fname);
> > > +           break;
> > > +   default:
> > >             return 0;
> > >     }
> >
> > The switch won't work since the _status field is a bit-field, so we sho=
uld
> > rather reuse the similar union-logic already present in fs/qnx4/dir.c
>
> Ah, okay, LINK and USED might both be there. And perfect, yes, it looks
> like the union qnx4_directory_entry in fs/qnx4/dir.c would be perfect.
>
> -Kees
>
> > > -   if (strncmp(name, de->di_fname, len) =3D=3D 0) {
> > > -           if ((de->di_status & (QNX4_FILE_USED|QNX4_FILE_LINK)) !
> > =3D 0) {
> > > -                   return 1;
> > > -           }
> > > -   }
> > > +
> > > +   /* Directory entry may not be %NUL-terminated. */
> > > +   entry_len =3D strnlen(entry_fname, entry_max_len);
> > > +
> > > +   if (len !=3D entry_len)
> > > +           return 0;
> > > +
> > > +   if (strncmp(name, entry_fname, len) =3D=3D 0)
> > > +           return 1;
> > > +
> > >     return 0;
> > >  }
> > >
> > > diff --git a/include/uapi/linux/qnx4_fs.h b/include/uapi/linux/qnx4_f=
s.h
> > > index 31487325d265..e033dbe1e009 100644
> > > --- a/include/uapi/linux/qnx4_fs.h
> > > +++ b/include/uapi/linux/qnx4_fs.h
> > > @@ -68,6 +68,13 @@ struct qnx4_link_info {
> > >     __u8            dl_status;
> > >  };
> > >
> > > +union qnx4_dir_entry {
> > > +   struct qnx4_inode_entry inode;
> > > +   struct qnx4_link_info link;
> > > +};
> > > +_Static_assert(offsetof(struct qnx4_inode_entry, di_status) =3D=3D
> > > +          offsetof(struct qnx4_link_info, dl_status));
> > > +
> > >  struct qnx4_xblk {
> > >     __le32          xblk_next_xblk;
> > >     __le32          xblk_prev_xblk;
> >
> >
> >
> >
>
> --
> Kees Cook
