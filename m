Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4C7DE993
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjKBAlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbjKBAlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:41:35 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CB612C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:41:24 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5afbdbf3a19so5237607b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 17:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698885683; x=1699490483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAm9YT2CGT8GblHULmmywbX41m2R7RbqEQjQ8qzUJ/M=;
        b=K0JtkKnX6EbqfiBHos83i5VZIYxFdOgqSjmJHTPSh6QzqBS3iZZiHIeGNu9p63tOY3
         p1TXNzSazLo8spWgciOgKmJpg3gQPOD6UyRBtV7dAbKUn+SWWv7yoZ/0SGlsVcnwgGy8
         /UwOPLIzTNsDyqbyXOJH6UQ4krABzCtLLVPzg0w8QtBiKKEnJXAgAMA8IaQZlpbCpVCA
         RYum+uBxgMeDn4EuzZUavblDvswu5HFrte+CR+0auq7Zm4Vsk10razTKtAT9QcZdMDRg
         04xkxaBct++JULnmuBCKCSzJj9jAZY9rg2+n1vcdlGx7w8Yseh46sdOUyYRLoFPiAfkP
         CC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698885683; x=1699490483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAm9YT2CGT8GblHULmmywbX41m2R7RbqEQjQ8qzUJ/M=;
        b=SiwnE/FQhMcfdOYp1g/sLoZCfMh6L19VmJ92+5pKxHnQ8qXOSZPInB/dlnYqdMkwcN
         rbR+4qs8J1aFcduJff0J2MsFO7251zy7Ao6thZMzdr0udPJhwpIv7ao5sXirLN2BmEDv
         p7xXV1SUnEeCfeiMIcH9bEXIo/uhFLyjMY3SSsxUcb+5BtZWmbKKTIxmegtUS3TLvkUw
         PK9old6jEQ+oHsO7/ko1eUDBdU0WPbXvseeGKlgVi6Sc8VsNyCD4Enn6UUoiI/mDGFeZ
         us9NzDMOB/gNYGh2HjC8oWX4aksGthSpdSJJ0Gyb0SCQrKowoqs4VlI7R6pukWEt8SjR
         cE1w==
X-Gm-Message-State: AOJu0Yxl2Iy+T6RN2U6cnyQDwHPtIwf6xOc8b/P1lH//PkOYBpjyL4TH
        kZY0bFRxnswnx/yoCEUqM87dG1HwFqj8eoDroBl3
X-Google-Smtp-Source: AGHT+IE9R2PNJzbWCbhLDpDBJE3kRi/K1J1lLamCQI6hfAPMxVasf0j2MjEDKeFunE720qUTJiYc5/y2Q0udhgf5d6k=
X-Received: by 2002:a5b:1ca:0:b0:c4b:ada8:8b86 with SMTP id
 f10-20020a5b01ca000000b00c4bada88b86mr16324385ybp.64.1698885683563; Wed, 01
 Nov 2023 17:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <1696457386-3010-13-git-send-email-wufan@linux.microsoft.com> <2121d9724f32ea5926574f9aba806b69.paul@paul-moore.com>
In-Reply-To: <2121d9724f32ea5926574f9aba806b69.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Nov 2023 20:41:12 -0400
Message-ID: <CAHC9VhTC0+p9sgeEjCYBZKFu9FcPj3U5zQ7eqBOfwvg9Kd=vwA@mail.gmail.com>
Subject: Re: [PATCH RFC v11 12/19] dm: add finalize hook to target_type
To:     Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, audit@vger.kernel.org,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Oct  4, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> >
> > This patch adds a target finalize hook.
> >
> > The hook is triggered just before activating an inactive table of a
> > mapped device. If it returns an error the __bind get cancelled.
> >
> > The dm-verity target will use this hook to attach the dm-verity's
> > roothash metadata to the block_device struct of the mapped device.
> >
> > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> > ---
> > v1-v10:
> >   + Not present
> > ---
> >  drivers/md/dm.c               | 12 ++++++++++++
> >  include/linux/device-mapper.h |  7 +++++++
> >  2 files changed, 19 insertions(+)
>
> We need an ACK and confirmation from Alasdair and/or Mike that this
> is the right approach.

A gentle ping with a reminder ...

For reference, the full patchset can be found on lore at the link below:

https://lore.kernel.org/linux-security-module/1696457386-3010-1-git-send-em=
ail-wufan@linux.microsoft.com/

> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index 64a1f306c96c..3be9cc35306d 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -2239,6 +2239,18 @@ static struct dm_table *__bind(struct mapped_dev=
ice *md, struct dm_table *t,
> >               goto out;
> >       }
> >
> > +     for (unsigned int i =3D 0; i < t->num_targets; i++) {
> > +             struct dm_target *ti =3D dm_table_get_target(t, i);
> > +
> > +             if (ti->type->finalize) {
> > +                     ret =3D ti->type->finalize(ti);
> > +                     if (ret) {
> > +                             old_map =3D ERR_PTR(ret);
> > +                             goto out;
> > +                     }
> > +             }
> > +     }
> > +
> >       old_map =3D rcu_dereference_protected(md->map, lockdep_is_held(&m=
d->suspend_lock));
> >       rcu_assign_pointer(md->map, (void *)t);
> >       md->immutable_target_type =3D dm_table_get_immutable_target_type(=
t);
> > diff --git a/include/linux/device-mapper.h b/include/linux/device-mappe=
r.h
> > index 69d0435c7ebb..4040e84a8ec7 100644
> > --- a/include/linux/device-mapper.h
> > +++ b/include/linux/device-mapper.h
> > @@ -160,6 +160,12 @@ typedef int (*dm_dax_zero_page_range_fn)(struct dm=
_target *ti, pgoff_t pgoff,
> >   */
> >  typedef size_t (*dm_dax_recovery_write_fn)(struct dm_target *ti, pgoff=
_t pgoff,
> >               void *addr, size_t bytes, struct iov_iter *i);
> > +/*
> > + * Returns:
> > + *  < 0 : error
> > + *  =3D 0 : success
> > + */
> > +typedef int (*dm_finalize_fn) (struct dm_target *target);
> >
> >  void dm_error(const char *message);
> >
> > @@ -209,6 +215,7 @@ struct target_type {
> >       dm_dax_direct_access_fn direct_access;
> >       dm_dax_zero_page_range_fn dax_zero_page_range;
> >       dm_dax_recovery_write_fn dax_recovery_write;
> > +     dm_finalize_fn finalize;
> >
> >       /* For internal device-mapper use. */
> >       struct list_head list;
> > --
> > 2.25.1

--=20
paul-moore.com
