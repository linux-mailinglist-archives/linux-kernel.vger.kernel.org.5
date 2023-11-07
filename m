Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC97E48BF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbjKGSvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjKGSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:51:39 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FFA99;
        Tue,  7 Nov 2023 10:51:36 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507bd64814fso8169601e87.1;
        Tue, 07 Nov 2023 10:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383095; x=1699987895; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYX/+1zca99/JdFmRK1ANRzRq/tpw+CXD4MrR9eZEg8=;
        b=F9dsvkjzXbFuIgGQFKhMbvBDecPkG3EwXDJRjW6s/ADb+QLIjqQJMV9rb0rf1ywzEA
         aRpFolMHtofd+n0fYlOi6VgaBTqWVNQjUjKFhvDOfyzNN1pxboIHK554+YZAip7b3MXB
         HfVWgdbkvQ1Sgf64HqFS4KDfXTCNEf7XGvYg4FoTEtAPKw6qbbs+6OYNI8ajrtP3pYc0
         FaaAUBl6ZBhb7uViCSFhmx1n0Swf8CqZ8ZLj6brqRxAcg2f2kk/tJApcT4EbDw4a6mF5
         iNUEMtKFv2iMTHYwW+7dGDIapdwTCH3LEwDuEoLWjF7A+hsNJkJuFDi7WDsDPy/YjUCE
         3Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383095; x=1699987895;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYX/+1zca99/JdFmRK1ANRzRq/tpw+CXD4MrR9eZEg8=;
        b=pro86NmX65THN1E5SfxEk+QTLBA5jlCmM6dfBSXxh3BN6j3c8OlXRZ5xWQzqqDqVmR
         yr4jQfItOnvMN9XiYztF08o3Bo9qdX7yElr0OIeWkBCgUlezwHQYsPHkZkpcIAhByAEk
         Nz1iBbKePyDodml/M+mlBbhPBY7D9q4iQaZHoTGqZwidc9tTH7AGT7tnfcYQIa/f1L9G
         l8QFaBXzEUy9QhXupRQ5f2C+q8Ho5yi/ddoXRZkfRH2zxBBOs4t5cc4Svv6Boz/INHYp
         /YltwNtiDGrS4t0trwqrIUw8sc1yP+bAQwdg8W/Zb1i0i0Xb/E2KioFgBFmI+cNTEkUF
         iNdQ==
X-Gm-Message-State: AOJu0YzgAtQnoUL6QAzbtP5/DXevA6iAe0tPqahtkQmyhaqONSAN3tK5
        gSh/Qd0JG+caWGjGjexRBaQ56gNRrLqcbc8FBHI=
X-Google-Smtp-Source: AGHT+IEo6otfTYR/QVUm0na7W/fLYg5QJNrglqZnAZgH/uFPIuCEetS4+FtIigFxPa4ZCTOv1XuXgbr5eeo5WTB47ng=
X-Received: by 2002:a05:6512:3da3:b0:507:a671:3231 with SMTP id
 k35-20020a0565123da300b00507a6713231mr30421076lfv.52.1699383094519; Tue, 07
 Nov 2023 10:51:34 -0800 (PST)
MIME-Version: 1.0
References: <ZUiXkPPP1TuOgmmf@fedora.fritz.box> <20231022183917.1013135-1-sanpeqf@gmail.com>
 <ZUfQo47uo0p2ZsYg@fedora.fritz.box> <CAH2r5msde65PMtn-96VZDAQkT_rq+e-2G4O+zbPUR8zSWGxMsg@mail.gmail.com>
 <20231105193601.GB91123@sol.localdomain> <ZUfvk-6y2pER6Rmc@fedora.fritz.box>
 <20231105201516.GC91123@sol.localdomain> <2610852.1699281611@warthog.procyon.org.uk>
 <ZUnIsXpjd7ckkTVw@fedora.fritz.box>
In-Reply-To: <ZUnIsXpjd7ckkTVw@fedora.fritz.box>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 7 Nov 2023 12:51:23 -0600
Message-ID: <CAH2r5mvsn92VicJPLo+BiFmCvk6HAn30t5WGyEqAb=sp0mA0bg@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix encryption of cleared, but unset rq_iter data buffers
To:     Damian Tometzki <damian@riscv-rocks.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Steve French <smfrench@gmail.com>,
        John Sanpe <sanpeqf@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cleaned up some minor whitespace warnings in the patch, added
Tested-by and Cc: stable and pushed to cifs-2.6.git for-next

On Mon, Nov 6, 2023 at 11:18=E2=80=AFPM Damian Tometzki <damian@riscv-rocks=
.de> wrote:
>
> On Mon, 06. Nov 14:40, David Howells wrote:
> > Hi Damian,
> >
> > Does the attached fix it for you?
> Hello David,
>
> this fix my issue with the cifs mount.
>
> Great many Thanks
>
> Damian
>
> >
> > David
> > ---
> > cifs: Fix encryption of cleared, but unset rq_iter data buffers
> >
> > Each smb_rqst struct contains two things: an array of kvecs (rq_iov) th=
at
> > contains the protocol data for an RPC op and an iterator (rq_iter) that
> > contains the data payload of an RPC op.  When an smb_rqst is allocated
> > rq_iter is it always cleared, but we don't set it up unless we're going=
 to
> > use it.
> >
> > The functions that determines the size of the ciphertext buffer that wi=
ll
> > be needed to encrypt a request, cifs_get_num_sgs(), assumes that rq_ite=
r is
> > always initialised - and employs user_backed_iter() to check that the
> > iterator isn't user-backed.  This used to incidentally work, because
> > ->user_backed was set to false because the iterator has never been
> > initialised, but with commit f1b4cb650b9a0eeba206d8f069fcdc532bfbcd74[1=
]
> > which changes user_backed_iter() to determine this based on the iterato=
r
> > type insted, a warning is now emitted:
> >
> >         WARNING: CPU: 7 PID: 4584 at fs/smb/client/cifsglob.h:2165 smb2=
_get_aead_req+0x3fc/0x420 [cifs]
> >         ...
> >         RIP: 0010:smb2_get_aead_req+0x3fc/0x420 [cifs]
> >         ...
> >          crypt_message+0x33e/0x550 [cifs]
> >          smb3_init_transform_rq+0x27d/0x3f0 [cifs]
> >          smb_send_rqst+0xc7/0x160 [cifs]
> >          compound_send_recv+0x3ca/0x9f0 [cifs]
> >          cifs_send_recv+0x25/0x30 [cifs]
> >          SMB2_tcon+0x38a/0x820 [cifs]
> >          cifs_get_smb_ses+0x69c/0xee0 [cifs]
> >          cifs_mount_get_session+0x76/0x1d0 [cifs]
> >          dfs_mount_share+0x74/0x9d0 [cifs]
> >          cifs_mount+0x6e/0x2e0 [cifs]
> >          cifs_smb3_do_mount+0x143/0x300 [cifs]
> >          smb3_get_tree+0x15e/0x290 [cifs]
> >          vfs_get_tree+0x2d/0xe0
> >          do_new_mount+0x124/0x340
> >          __se_sys_mount+0x143/0x1a0
> >
> > The problem is that rq_iter was never set, so the type is 0 (ie. ITER_U=
BUF)
> > which causes user_backed_iter() to return true.  The code doesn't
> > malfunction because it checks the size of the iterator - which is 0.
> >
> > Fix cifs_get_num_sgs() to ignore rq_iter if its count is 0, thereby
> > bypassing the warnings.
> >
> > It might be better to explicitly initialise rq_iter to a zero-length
> > ITER_BVEC, say, as it can always be reinitialised later.
> >
> > Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rat=
her than a page list")
> > Reported-by: Damian Tometzki <damian@riscv-rocks.de>
> > Link: https://lore.kernel.org/r/ZUfQo47uo0p2ZsYg@fedora.fritz.box/
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <smfrench@gmail.com>
> > cc: Shyam Prasad N <sprasad@microsoft.com>
> > cc: Rohith Surabattula <rohiths.msft@gmail.com>
> > cc: Paulo Alcantara <pc@manguebit.com>
> > cc: Namjae Jeon <linkinjeon@kernel.org>
> > cc: Tom Talpey <tom@talpey.com>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: Eric Biggers <ebiggers@kernel.org>
> > cc: linux-cifs@vger.kernel.org
> > cc: linux-fsdevel@vger.kernel.org
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3Df1b4cb650b9a0eeba206d8f069fcdc532bfbcd74 [1]
> > ---
> >  fs/smb/client/cifsglob.h |   12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> > index 02082621d8e0..c70760871606 100644
> > --- a/fs/smb/client/cifsglob.h
> > +++ b/fs/smb/client/cifsglob.h
> > @@ -2143,6 +2143,7 @@ static inline int cifs_get_num_sgs(const struct s=
mb_rqst *rqst,
> >       unsigned int len, skip;
> >       unsigned int nents =3D 0;
> >       unsigned long addr;
> > +     size_t data_size;
> >       int i, j;
> >
> >       /*
> > @@ -2158,17 +2159,21 @@ static inline int cifs_get_num_sgs(const struct=
 smb_rqst *rqst,
> >        * rqst[1+].rq_iov[0+] data to be encrypted/decrypted
> >        */
> >       for (i =3D 0; i < num_rqst; i++) {
> > +             data_size =3D iov_iter_count(&rqst[i].rq_iter);
> > +
> >               /* We really don't want a mixture of pinned and unpinned =
pages
> >                * in the sglist.  It's hard to keep track of which is wh=
at.
> >                * Instead, we convert to a BVEC-type iterator higher up.
> >                */
> > -             if (WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter)))
> > +             if (data_size &&
> > +                 WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter)))
> >                       return -EIO;
> >
> >               /* We also don't want to have any extra refs or pins to c=
lean
> >                * up in the sglist.
> >                */
> > -             if (WARN_ON_ONCE(iov_iter_extract_will_pin(&rqst[i].rq_it=
er)))
> > +             if (data_size &&
> > +                 WARN_ON_ONCE(iov_iter_extract_will_pin(&rqst[i].rq_it=
er)))
> >                       return -EIO;
> >
> >               for (j =3D 0; j < rqst[i].rq_nvec; j++) {
> > @@ -2184,7 +2189,8 @@ static inline int cifs_get_num_sgs(const struct s=
mb_rqst *rqst,
> >                       }
> >                       skip =3D 0;
> >               }
> > -             nents +=3D iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
> > +             if (data_size)
> > +                     nents +=3D iov_iter_npages(&rqst[i].rq_iter, INT_=
MAX);
> >       }
> >       nents +=3D DIV_ROUND_UP(offset_in_page(sig) + SMB2_SIGNATURE_SIZE=
, PAGE_SIZE);
> >       return nents;
> >



--=20
Thanks,

Steve
