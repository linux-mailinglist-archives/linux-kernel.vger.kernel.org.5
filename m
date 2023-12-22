Return-Path: <linux-kernel+bounces-9353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F7281C477
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B692847A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDAA539F;
	Fri, 22 Dec 2023 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJtwuhWS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419AB64C;
	Fri, 22 Dec 2023 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1908737a12.0;
        Thu, 21 Dec 2023 20:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703221002; x=1703825802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWqsP0YUMP6a7cu2oaHJUgxIQ36xA/a/DzZjUjmtwic=;
        b=jJtwuhWS2xg0MEYz3cR/aqAo3s3e0dWU1gHyI30l2FbspXwQYH1cMftsZUewH4RsLn
         c7qd5Uk6SU9zynEcb2I5Eb4dclM9AP1IikOP27+oE+/CAY82x0U+M2Cxz8tGxCsKX41c
         Rflrs7YZvRT98aWupOvUx1COMrujMhSHrENbBm+IFbZvfIJDaD1BYntHEmwURTh/g8oV
         l3xkbB69A9J4JHOj15rjHdiXt0o50rGaMXqTk7S5/OAG/Kw6WqZCT8ufqdmmsPMgBwkP
         8Px5dRSheUEOWXjz3YoqdmjUHTXWtrbCH96ochvX+wujo+rd7hXr/dQmrop2v3hwFxKv
         rAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703221002; x=1703825802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWqsP0YUMP6a7cu2oaHJUgxIQ36xA/a/DzZjUjmtwic=;
        b=cCUL1aSBlIAU2X0OIVFxHUJ6Jm+h9hV9casF5m6waMPQOuX4oGyuBUdsIBeOhKKc2H
         QlO4gVXP+ns3srQbHdgIwRSjfvAu/lBi4DFgi51Il3d+4ERNmYOahmzX3F6Q/JFMgC8+
         31QLxnZHSaJ5MfZjEFyNBdu2iq5uJ5QjW0NfuppfQa9Mkpj7zgUDx/HdC+USsY33fsT4
         69KnOEWZxDLN0JltjW+2BSh8C5vcVtORWS+8eTzoXH3g1HyrVhzGeKUhNGumyxbpS6Qt
         lNT3JrZvOxUMU0abkHIXCSamytZd4wkh8U8CXVxdxrhKQT6nneIUxgLxTPnBQwLibvFY
         XZVg==
X-Gm-Message-State: AOJu0YwGgZEDDBcryjr3H18Dx5SYLgMbkVvfxGE3gSM0YIvR6Qr1h2US
	1fOCQhV4KWCkdkpUfTJEfTwPTjCp6NHuuk9NGcA=
X-Google-Smtp-Source: AGHT+IGVJQsE6p52eLFhSLFIKzi97L31nRMNk+0XS/0jAbSL9nFWpk19E7VqjdYceCuuABPSwaacuEqItbhpCkg3+dk=
X-Received: by 2002:a17:90a:d158:b0:28b:8fe8:3e95 with SMTP id
 t24-20020a17090ad15800b0028b8fe83e95mr2051176pjw.29.1703221001685; Thu, 21
 Dec 2023 20:56:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221104343.5557-1-2045gemini@gmail.com> <abc324aa-1ccc-c8fd-1437-a77465f6e4be@huaweicloud.com>
 <CAOPYjvbfGZObUa+P5Bo_syLMpyMNEPU6SNm6xJPSqSZYREmNfw@mail.gmail.com>
 <CAOPYjvYhEzeF3vdd9GXCX+k_-OmsE1yP7VNozcMt4vOyFLDAfw@mail.gmail.com> <ae9fc764-4765-8c13-8d59-56bc8582c094@huaweicloud.com>
In-Reply-To: <ae9fc764-4765-8c13-8d59-56bc8582c094@huaweicloud.com>
From: 20 39 <2045gemini@gmail.com>
Date: Fri, 22 Dec 2023 12:56:06 +0800
Message-ID: <CAOPYjvaDCFhFCSc+LhpDRq2ZB0jOP8xx0t3OVL95C3WfG-NimA@mail.gmail.com>
Subject: Re: [PATCH] md/raid5: fix atomicity violation in raid5_cache_count
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@outlook.com, BassCheck <bass@buaa.edu.cn>, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
We've updated to use READ_ONCE() in PATCH v2, Thank you for helpful advice.
Best regards,
Han

Yu Kuai <yukuai1@huaweicloud.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=BA=94 10:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> =E5=9C=A8 2023/12/22 10:34, 20 39 =E5=86=99=E9=81=93:
> > Hi Kuai,
> >
> > Thank you for your patience. This email is essentially the same as my
> > previous one, only now adjusted to plain text format. I apologize for
> > any inconvenience caused earlier.
> >
> > Thanks for your email and the insightful points you've raised. Let me
> > clarify a few aspects regarding the raid5_cache_count() and
> > raid5_set_cache_size() functions.
> >
> > 1. Callback Function in setup_conf(): You mentioned that
> > raid5_cache_count() is called from setup_conf() where reconfig_mutex
> > is held. While this is true, it's important to note that
> > raid5_cache_count() is actually initialized as a callback function in
> > setup_conf(), as described in /include/linux/shrinker.h. This means it
> > could be invoked later in a context where the reconfig_mutex isn't
> > necessarily held. The documentation in shrinker.h indicates potential
> > invocation scenarios beyond the initial setup context.
>
> Yes, you're right. I misread the code. Then this patch looks good to me,
> just one nit below.
>
> >>>> @@ -7390,11 +7390,12 @@ static unsigned long raid5_cache_count(struc=
t shrinker *shrink,
> >>>>                                       struct shrink_control *sc)
> >>>>    {
> >>>>        struct r5conf *conf =3D shrink->private_data;
> >>>> -
> >>>> -     if (conf->max_nr_stripes < conf->min_nr_stripes)
> >>>> +     int max_stripes =3D conf->max_nr_stripes;
> >>>> +     int min_stripes =3D conf->min_nr_stripes;
>
> Since read and write can concurrent, I'll suggest to use READ_ONCE() and
> WRITE_ONCE() for max/min_nr_stripes.
>
> Thanks,
> Kuai
> >>>> +     if (max_stripes < min_stripes)
> >>>>                /* unlikely, but not impossible */
> >>>>                return 0;
> >>>> -     return conf->max_nr_stripes - conf->min_nr_stripes;
> >>>> +     return max_stripes - min_stripes;
> >>>>    }
> >>>>
> >>>>    static struct r5conf *setup_conf(struct mddev *mddev)
> >>>>
> >>>
> > .
> >
>

