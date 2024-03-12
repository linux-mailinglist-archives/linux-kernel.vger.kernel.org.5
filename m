Return-Path: <linux-kernel+bounces-100546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D01879968
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E2D1C213F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E54137C2D;
	Tue, 12 Mar 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9thJUeP"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E273137922;
	Tue, 12 Mar 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262420; cv=none; b=pYm+qK9jeD5sv3Ezf3cx0tIQLyeEyZr1pWs5gFQ3hyQrXXIapFWtoxMB++sESTWOrZcKUYLjrXEmVQes2uYugF0OH38FVrQ/CVFyEBsY3oGxClPEt9aPsSujMvX5NtSCWs3vDlYkdTrj+OwcMcnSHHjZACLBjfnHn7KNOqi7jfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262420; c=relaxed/simple;
	bh=62ZNJkCWnpg6uw2sY4QlOwD0WO15Qg1v7rcp10Vqvvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEdNeXBDSEaCwc5XR7uDVoJhWoxOK9XWycEQZOoehLLEKUSZ9xDHAj7t/mSRvLKg1Mbfm/UeNf5aupT+IJMKXw0mAJGw/K5yAu9dWVRidYanPUuZhmCIR64FfwYvdGqMBOl6M1f9MwBzaNCz2ar9PHZ+0BWCRFOnxxPv7Pd+A5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9thJUeP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dd9568fc51so22682805ad.2;
        Tue, 12 Mar 2024 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710262418; x=1710867218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k29YCBv1oSFNYkMP2kxo5OqxARtTRzAAo6P/8vA6HEM=;
        b=E9thJUePzIG5iBEz83w8GULAXvsgLqWzDIKPB5yC/EY1PgzerVABVxtigT3OeoHuL/
         OSv9JNvEk9qv6k7vuujqXve4M3DZRLR3eklNEgCsEUBw5aQIrscNSt1N6SZEJ9KS0/CU
         9n7P+df04n51luVbl28olZBe3uhTklsyne0tX+9DLBNO+tP072jmzEZfAKoKt+zQ2yja
         FJb/kcxVBKXojPF0gEX2ABVPbLNDSfosLt83bThkpKuPkz6IgQBzNTZT/spi1rPldsRw
         zE3JMbdHubPw5Rnx1C7rZwHdx6aT0yipApPBN4A2ebrGTG6ja/uI/fdVh+92LBWVH5YU
         njTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710262418; x=1710867218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k29YCBv1oSFNYkMP2kxo5OqxARtTRzAAo6P/8vA6HEM=;
        b=GTOjvVLZ7+bq3QHuMyLV29TutlsKYBHziVmicqlsYfqeWUnXat+s4Mck6vai0qrudt
         VJmb1YkVpdX5Q3QZfxIbSL5jTfL5Ayczceg33s1M2eCb11L5Yf35nYC4Geu0OgDgLW+s
         qAAM7C0inLTEyjvFIAnqJ+cvzjq7g0Y3mqV6tYLtmYXwxhYlqbhE8PENd/Nn48VtZte9
         7Yda7HNVIjIoEMnvARf0Fa224qje1Ca0Lu6cKqV32RDNofzTIf0ARDhcZ1vffDC799YM
         Qzt9/ws8TJvn/1VhkmYMeyzM0XlE0/wu4KA6ZsGuOrDiTrpwB2YupwET9fRc+bcaiFK7
         5HZA==
X-Forwarded-Encrypted: i=1; AJvYcCWzW3GQCAMq9LXQH0CG/l5/Pdaqhh/flHY2XAyYkoAJdHIbELPvwRmcy4wvzIz0x47rMKPYDNUAUFWD6z+eHrQ9ws0mcQh1ZMsBWDtjKIeq2ewO1xsSssaFZZ5OILnf0+R9PvwpwtAa
X-Gm-Message-State: AOJu0YwhK76C0oM3q0p3b3rHob9ieAm6VOY9AN1wkIr5MHmmEwXr6BjU
	Y5MRaMSb4SGtLqDud7xJEHpf5zUG3ZchIqIPoz7/VebEmSXEOY0EnNNI0+hc++wAxBF0OFA/Emm
	feMD26VSt9opItwMpaLuPIIBE79wWriIluA==
X-Google-Smtp-Source: AGHT+IEKM8bVJ4Ssnabzg/XfL0JCdFzi0jKEQLB6R8vWe+I6RxykGYNrraBtSFW6TCjYZKgMXm0MMowzUKBMJKcNd6o=
X-Received: by 2002:a17:902:d2c4:b0:1dd:c90a:f6bb with SMTP id
 n4-20020a170902d2c400b001ddc90af6bbmr552684plc.51.1710262418245; Tue, 12 Mar
 2024 09:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALGdzur-rsLbd4BcgtR9QV2=ZH8xHAVySjm2z2TT=Aog74mdPw@mail.gmail.com>
 <6dd0d822-046c-4dd2-9532-79d7ab96ec05@gmail.com>
In-Reply-To: <6dd0d822-046c-4dd2-9532-79d7ab96ec05@gmail.com>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Tue, 12 Mar 2024 11:53:27 -0500
Message-ID: <CALGdzuoA4ANBurXyP+00hFPmPznixcMTgrYNp1P4VwvpFb_GtA@mail.gmail.com>
Subject: Re: [drivers/iio] Question about `iio_gts_build_avail_time_table`
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijie Zhao <zzjas98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

I have a question about the "The idea of the check which has been
removed was to assign the value in
the array in first free spot if it is bigger than the last value".

-               if (times[idx] < new) {
-                       times[idx++] =3D new;
-                       continue;
-               }
+               times[idx] =3D new;

It appears that the comparison should perhaps be made with `idx-1`
rather than `idx`, given that `idx` represents the current number of
copied values in times, whereas `idx-1` points to the last value.
Could I have your thoughts on this?

Best,
Chenyuan

On Tue, Mar 12, 2024 at 6:16=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> Hi Chenyuan!
>
> Thank you for pointing out the problems :)
>
> On 3/11/24 21:48, Chenyuan Yang wrote:
> > Dear Linux Developers for IIO Driver,
> >
> > We are curious about the functionality of
> > `iio_gts_build_avail_time_table`
> > (https://elixir.bootlin.com/linux/latest/source/drivers/iio/industriali=
o-gts-helper.c#L363)
> >
> > ```
> > static int iio_gts_build_avail_time_table(struct iio_gts *gts)
> > {
> >    int *times, i, j, idx =3D 0, *int_micro_times;
> >
> >    if (!gts->num_itime)
> >      return 0;
> >
> >    times =3D kcalloc(gts->num_itime, sizeof(int), GFP_KERNEL);
> >    if (!times)
> >      return -ENOMEM;
> >
> >    /* Sort times from all tables to one and remove duplicates */
> >    for (i =3D gts->num_itime - 1; i >=3D 0; i--) {
> >      int new =3D gts->itime_table[i].time_us;
> >
> >      if (times[idx] < new) {
> >        times[idx++] =3D new;
> >        continue;
> >      }
> >
> >      for (j =3D 0; j <=3D idx; j++) {
> >        if (times[j] > new) {
> >          memmove(&times[j + 1], &times[j],
> >                                  (idx - j) * sizeof(int));
> >          times[j] =3D new;
> >          idx++;
> >        }
> >      }
> >    ...
> > }
> > ```
> >
> > For this function, we are trying to understand how it works but not
> > sure how this sorting is done.
> >
> > 1. When the gts->itime_table[i].time_us is zero, e.g., the time
> > sequence is `3, 0, 1`, the inner for-loop will not terminate and do
> > out-of-bound writes. This is because once `times[j] > new`, the value
> > `new` will be added in the current position and the `times[j]` will be
> > moved to `j+1` position, which makes the if-condition always hold.
> > Meanwhile, idx will be added one, making the loop keep running without
> > termination and out-of-bound write.
> > 2. If none of the gts->itime_table[i].time_us is zero, the elements
> > will just be copied without being sorted as described in the comment
> > "Sort times from all tables to one and remove duplicates".
> >
> > Please correct us if we miss some key prerequisites for this function
> > or the data structure.
> > Thanks in advance!
>
> You are correct. The sorting is not working as intended! It has only
> worked and passed the tests because the arrays in the test and driver
> code have been ordered in "descending time" - order. The code above has
> done a copying of items in reverse order, resulting a working set of
> available times.
>
> > A possible patch based on our understanding is attached.
>
> I copied your suggested fix here for my initial thoughts:
>
> diff --git a/drivers/iio/industrialio-gts-helper.c
> b/drivers/iio/industrialio-gts-helper.c
> index 7653261d2dc2..0667da988295 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -375,19 +375,17 @@ static int iio_gts_build_avail_time_table(struct
> iio_gts *gts)
>         for (i =3D gts->num_itime - 1; i >=3D 0; i--) {
>                 int new =3D gts->itime_table[i].time_us;
>
> -               if (times[idx] < new) {
> -                       times[idx++] =3D new;
> -                       continue;
> -               }
> +               times[idx] =3D new;
>
> The idea of the check which has been removed was to assign the value in
> the array in first free spot if it is bigger than the last value. As you
> pointed out, the implementation is wrong, but I think the idea is Ok.
> Here you do unconditional assignment which is slightly sub-optimal.
>
>                 for (j =3D 0; j <=3D idx; j++) {
>                         if (times[j] > new) {
>                                 memmove(&times[j + 1], &times[j],
>                                         (idx - j) * sizeof(int));
>                                 times[j] =3D new;
> -                               idx++;
> +                               break;
>                         }
>                 }
> +               idx++;
>         }
>         /* create a list of times formatted as list of IIO_VAL_INT_PLUS_M=
ICRO */
>
>
> I will fire-up a setup with the IIO-GTS Kunit tests, and alter the order
> of times in array for the available times test.
>
> I would appreciate if you could post formal fixup-patch in inline
> message as per usual Linux review and merge process. That would simplify
> the process for Jonathan and other reviewers. Please, let me know if you
> don't want to send a formal fix. In that case I will write a fix by mysel=
f.
>
> Finally, your finding and report is _very much_ appreciated! Thanks!
>
> Yours,
>         -- Matti
>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>

