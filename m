Return-Path: <linux-kernel+bounces-20529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F348828030
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2B02842DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94ED2420E;
	Tue,  9 Jan 2024 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ9T1/Z0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4911CAF;
	Tue,  9 Jan 2024 08:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6175CC43394;
	Tue,  9 Jan 2024 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704787963;
	bh=224IB4+F5ytDnqRtVIkge9vsOi4Yg6Fso5YIj7PvVR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZJ9T1/Z00y2Cq0xhLXoOezF1jzEhxlO3O+baBYOeDQCnjWPgLRuVkejB2IhnLuXQM
	 nqsWh4gIwwYVnvbHhbfEtaiyJ3Au7ECT05UQ2B1lYDQVOSHgYVSEcBipgOx0/zE8vo
	 g+lNIR0bFHdL1eLw3TDWVN8FgWRAdehn4apQzUJifSQ25BvbFP5Z/z/6Es99wDMKUU
	 lyv6il906YrGSR9kvVDuGemVK2PO/+8Q/nGjUo01YQa1Dx/6o/EmtkUF7gx5KSrrb/
	 oDJOAw2tIuETBJKfEqoI24O5eGiNclu6l6nHhuyVZWfBFBRsS5aNlxCRF66EUTC7iK
	 qcwYbbfBwNB2w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e7b51b0ceso2491578e87.1;
        Tue, 09 Jan 2024 00:12:43 -0800 (PST)
X-Gm-Message-State: AOJu0Yx1kbUZtRQZizMMGuA5uMhSzZ4EUH2lZTn6dTozu88o/7OCinnQ
	THQFKehAoDdxUfj/AIOsYQOHx6LtwAR8yqfjfSs=
X-Google-Smtp-Source: AGHT+IGvqU89UK/GxkSqH6kLLyXkKpUcrqPB7ARXGMqar5YOeTGmzsxlv9PY6/6sVJeYz0SuI+hipXszuba3IO8zq5A=
X-Received: by 2002:a05:6512:2388:b0:50e:3879:8222 with SMTP id
 c8-20020a056512238800b0050e38798222mr267241lfv.21.1704787961552; Tue, 09 Jan
 2024 00:12:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927061241.1552837-1-yukuai1@huaweicloud.com>
 <20230927061241.1552837-3-yukuai1@huaweicloud.com> <CAPhsuW6sdnJYtE+iy+x=C2qVKzeN18zibx+qQBF4Y=KRsAmTTg@mail.gmail.com>
 <b6a79bb8-e0fc-09b4-90e7-8112100a3fd0@huaweicloud.com> <753615cc-16d6-3c58-99ee-b5e1f0aa0cde@huaweicloud.com>
In-Reply-To: <753615cc-16d6-3c58-99ee-b5e1f0aa0cde@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Tue, 9 Jan 2024 00:12:30 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6Ekxu9kaxvi673MCr=nBCS78D613zuH6Kcg5Y4Hs=jDw@mail.gmail.com>
Message-ID: <CAPhsuW6Ekxu9kaxvi673MCr=nBCS78D613zuH6Kcg5Y4Hs=jDw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] md: simplify md_seq_ops
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mariusz.tkaczyk@linux.intel.com, xni@redhat.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 11:48=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/01/09 9:21, Yu Kuai =E5=86=99=E9=81=93:
> > Hi,
> >
> > =E5=9C=A8 2024/01/09 7:38, Song Liu =E5=86=99=E9=81=93:
> >> On Tue, Sep 26, 2023 at 11:19=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.=
com> wrote:
[...]
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index e351e6c51cc7..289d3d89e73d 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8135,6 +8135,19 @@ static void status_unused(struct seq_file *seq)
>          seq_printf(seq, "\n");
>   }
>
> +static void status_personalities(struct seq_file *seq)
> +{
> +       struct md_personality *pers;
> +
> +       seq_puts(seq, "Personalities : ");
> +       spin_lock(&pers_lock);
> +       list_for_each_entry(pers, &pers_list, list)
> +               seq_printf(seq, "[%s] ", pers->name);
> +
> +       spin_unlock(&pers_lock);
> +       seq_puts(seq, "\n");
> +}
> +
>   static int status_resync(struct seq_file *seq, struct mddev *mddev)
>   {
>          sector_t max_sectors, resync, res;
> @@ -8273,43 +8286,53 @@ static int status_resync(struct seq_file *seq,
> struct mddev *mddev)
>          return 1;
>   }
>
> +#define MDDEV_NONE (void *)1
> +
>   static void *md_seq_start(struct seq_file *seq, loff_t *pos)
>          __acquires(&all_mddevs_lock)
>   {
> -       struct md_personality *pers;
> -
> -       seq_puts(seq, "Personalities : ");
> -       spin_lock(&pers_lock);
> -       list_for_each_entry(pers, &pers_list, list)
> -               seq_printf(seq, "[%s] ", pers->name);
> -
> -       spin_unlock(&pers_lock);
> -       seq_puts(seq, "\n");
>          seq->poll_event =3D atomic_read(&md_event_count);
> -
>          spin_lock(&all_mddevs_lock);
>
> -       return seq_list_start(&all_mddevs, *pos);
> +       if (!list_empty(&all_mddevs))
> +               return seq_list_start(&all_mddevs, *pos);
> +       else if (*pos =3D=3D 0)
> +               return MDDEV_NONE;
> +       else
> +               return NULL;
>   }
>
>   static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>   {
> +       if (v =3D=3D MDDEV_NONE) {
> +               ++*pos;
> +               return NULL;
> +       }
> +
>          return seq_list_next(v, &all_mddevs, pos);
>   }
>
>   static void md_seq_stop(struct seq_file *seq, void *v)
>          __releases(&all_mddevs_lock)
>   {
> -       status_unused(seq);
>          spin_unlock(&all_mddevs_lock);
>   }
>   static int md_seq_show(struct seq_file *seq, void *v)
>   {
> -       struct mddev *mddev =3D list_entry(v, struct mddev, all_mddevs);
> +       struct mddev *mddev;
>          sector_t sectors;
>          struct md_rdev *rdev;
>
> +       if (v =3D=3D MDDEV_NONE) {
> +               status_personalities(seq);
> +               status_unused(seq);
> +               return 0;
> +       }
> +
> +       mddev =3D list_entry(v, struct mddev, all_mddevs);
> +       if (mddev =3D=3D list_first_entry(&all_mddevs, struct mddev,
> all_mddevs))
> +               status_personalities(seq);
>          if (!mddev_get(mddev))
>                  return 0;
>
> @@ -8385,6 +8408,10 @@ static int md_seq_show(struct seq_file *seq, void =
*v)
>          }
>          spin_unlock(&mddev->lock);
>          spin_lock(&all_mddevs_lock);
> +
> +       if (mddev =3D=3D list_last_entry(&all_mddevs, struct mddev, all_m=
ddevs))
> +               status_unused(seq);
> +
>          if (atomic_dec_and_test(&mddev->active))
>                  __mddev_put(mddev);
>

I think something like the following is the right way to do this.

Thanks,
Song

diff --git i/drivers/md/md.c w/drivers/md/md.c
index 38a6767c65b1..14044febe009 100644
--- i/drivers/md/md.c
+++ w/drivers/md/md.c
@@ -8215,20 +8215,8 @@ static int status_resync(struct seq_file *seq,
struct mddev *mddev)
 static void *md_seq_start(struct seq_file *seq, loff_t *pos)
        __acquires(&all_mddevs_lock)
 {
-       struct md_personality *pers;
-
-       seq_puts(seq, "Personalities : ");
-       spin_lock(&pers_lock);
-       list_for_each_entry(pers, &pers_list, list)
-               seq_printf(seq, "[%s] ", pers->name);
-
-       spin_unlock(&pers_lock);
-       seq_puts(seq, "\n");
-       seq->poll_event =3D atomic_read(&md_event_count);
-
        spin_lock(&all_mddevs_lock);
-
-       return seq_list_start(&all_mddevs, *pos);
+       return seq_list_start_head(&all_mddevs, *pos);
 }

 static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -8243,12 +8231,31 @@ static void md_seq_stop(struct seq_file *seq, void =
*v)
        spin_unlock(&all_mddevs_lock);
 }

+static void md_seq_print_header(struct seq_file *seq)
+{
+       struct md_personality *pers;
+
+       seq_puts(seq, "Personalities : ");
+       spin_lock(&pers_lock);
+       list_for_each_entry(pers, &pers_list, list)
+               seq_printf(seq, "[%s] ", pers->name);
+
+       spin_unlock(&pers_lock);
+       seq_puts(seq, "\n");
+       seq->poll_event =3D atomic_read(&md_event_count);
+}
+
 static int md_seq_show(struct seq_file *seq, void *v)
 {
        struct mddev *mddev =3D list_entry(v, struct mddev, all_mddevs);
        sector_t sectors;
        struct md_rdev *rdev;

+       if (v =3D=3D &all_mddevs) {
+               md_seq_print_header(seq);
+               return 0;
+       }
+
        if (!mddev_get(mddev))
                return 0;

