Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C875C7AF49F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjIZUDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjIZUDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:03:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6735A11D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:03:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c451541f23so74561725ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695758591; x=1696363391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fA05+bYS7KOIKR/I8Uj+c2mjDDZM40BJJRZc83kHMhs=;
        b=pNGxaZJY6XSKDWtaxJ6XWeX4twkjghpOUJXzslSuxvE4vqljxtL/R671TaNpJePTaZ
         y6A+4UHFA3IHcGokPJgih9tf7BtB9sQUHpzTE5SQ/j1JEAen/3fbt7LQ9x4PpHlYIvO2
         KDgwnDKN5bTR6VmxViftxxwCtUesGX9bnL/iA2ZTCK3UH47C6qgDJ9tmzCHrj41IwiQ0
         UjPYKqS/c3quP/1xEshQ/aM8h0fYfMxVf0q0QnlNLkyr3qAf4dByeLbJ/sBykIxcssuH
         Nou66/kqJi/v3oNXA+ODpltDrfsXlKpUYnsJOyAOzzutRDyJETUn1WrZF2qsdcalN+vT
         2SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695758591; x=1696363391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fA05+bYS7KOIKR/I8Uj+c2mjDDZM40BJJRZc83kHMhs=;
        b=mBei82JPEehTLcAqtohoxcIR1i/NbdcvypGnOOGzw6BuAXq3vO7C1QidfVHdjp9rIW
         5am75TjfoaAW3uavWY/yovclMpkPoSaKE+TXet4HznlnNiOrSe9kF9rNzTmLgS/y4q6X
         MtGjI8WWGYEP1zgMvI/4U4Pujo3sraX+M6bgjsQs/JGQrEEkrsX3g/6JnFhv7KC//9Zu
         DoUN2r1fF0h65f5Gz5LsZvF6/uPSdFtX5+8LMX7Rrni2129eqVmdx4YhqsCbG8R0wQI+
         LcX7yVTmVFzlzPgQFA1jPHdJxe7ykg+kE+NWVzGmu4b0ULd1oBowpRwFFtSIH1swkBw0
         4jGg==
X-Gm-Message-State: AOJu0Yz9fUoRea8tp+tgmUZRAlbCLfhCEdvRDY4CUVWHfbFTVaa5+qc4
        BN9jFNtKaT3zGe39bXaO923kO5rhbiUnhoM9YOxFmQ==
X-Google-Smtp-Source: AGHT+IEQWocucOt77iz92cLf81oVW1Qi0Z2ZvMtVVl9yhDa/wA+LToQsFIZ/7D0ie7+TsWMUTo3dCgff4aufnilluGc=
X-Received: by 2002:a17:90a:6341:b0:263:4305:4e82 with SMTP id
 v1-20020a17090a634100b0026343054e82mr7899778pjs.6.1695758590638; Tue, 26 Sep
 2023 13:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230922155336.507220-1-bgeffon@google.com> <20230922160704.511283-1-bgeffon@google.com>
 <CAJZ5v0gRmoSaP3T0s9Li3grBB6DkaXf6D_0oHdw3=-UJWjJEKA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gRmoSaP3T0s9Li3grBB6DkaXf6D_0oHdw3=-UJWjJEKA@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 26 Sep 2023 16:02:34 -0400
Message-ID: <CADyq12wMR0viVN+m6T3rAL0kn1792iB0V5s=_tSxkLuPZk6KxA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: clean up sync_read handling in snapshot_write_next
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 2:24=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Sep 22, 2023 at 6:07=E2=80=AFPM Brian Geffon <bgeffon@google.com>=
 wrote:
> >
> > In snapshot_write_next sync_read is set and unset in three different
> > spots unnecessiarly. As a result there is a subtle bug where the first
> > page after the meta data has been loaded unconditionally sets sync_read
> > to 0. If this first pfn was actually a highmem page then the returned
> > buffer will be the global "buffer," and the page needs to be loaded
> > synchronously.
> >
> > That is, I'm not sure we can always assume the following to be safe:
> >                 handle->buffer =3D get_buffer(&orig_bm, &ca);
> >                 handle->sync_read =3D 0;
> >
> > Because get_buffer can call get_highmem_page_buffer which can
> > return 'buffer'
> >
> > The easiest way to address this is just set sync_read before
> > snapshot_write_next returns if handle->buffer =3D=3D buffer.
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > Fixes: 8357376d3df2 ("[PATCH] swsusp: Improve handling of highmem")
> > Cc: stable@vger.kernel.org
>
> If you send an update of a patch, it is always better to give it a
> higher version number to avoid any possible confusion.

Yes, I apologize. I wanted to add a Fixes line and I wasn't sure what
the best practice was. I'll do my best to not create any additional
work for you going forward!

>
> > ---
> >  kernel/power/snapshot.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 190ed707ddcc..362e6bae5891 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -2780,8 +2780,6 @@ int snapshot_write_next(struct snapshot_handle *h=
andle)
> >         if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pa=
ges + nr_zero_pages)
> >                 return 0;
> >
> > -       handle->sync_read =3D 1;
> > -
> >         if (!handle->cur) {
> >                 if (!buffer)
> >                         /* This makes the buffer be freed by swsusp_fre=
e() */
> > @@ -2824,7 +2822,6 @@ int snapshot_write_next(struct snapshot_handle *h=
andle)
> >                         memory_bm_position_reset(&zero_bm);
> >                         restore_pblist =3D NULL;
> >                         handle->buffer =3D get_buffer(&orig_bm, &ca);
> > -                       handle->sync_read =3D 0;
> >                         if (IS_ERR(handle->buffer))
> >                                 return PTR_ERR(handle->buffer);
> >                 }
> > @@ -2834,9 +2831,8 @@ int snapshot_write_next(struct snapshot_handle *h=
andle)
> >                 handle->buffer =3D get_buffer(&orig_bm, &ca);
> >                 if (IS_ERR(handle->buffer))
> >                         return PTR_ERR(handle->buffer);
> > -               if (handle->buffer !=3D buffer)
> > -                       handle->sync_read =3D 0;
> >         }
> > +       handle->sync_read =3D (handle->buffer =3D=3D buffer);
> >         handle->cur++;
> >
> >         /* Zero pages were not included in the image, memset it and mov=
e on. */
> > --
>
> Anyway, applied as 6.7 material with some minor edits in the subject
> and changelog.

Thank you for taking the time to review!
Cheers

>
> Thanks!
