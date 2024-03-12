Return-Path: <linux-kernel+bounces-100920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 444D8879FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C573E1F22274
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA17647768;
	Tue, 12 Mar 2024 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAXfcqsS"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F914293
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285971; cv=none; b=GwiwUfsSl2RM0fSNRu9KSxJ8+lXubqdYXmdfv5QcpbPFhHG+OOCcybYuXpMQCP0JRmkJyonx6A2oH9egFWuYoSsCg5muqWdCy2RlAJTBHDUBftcySm9nTaJm/xMCW5H+LKXgrZG3IiRWL6sWfnKudzjpqEuJAhmc+hISNadJMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285971; c=relaxed/simple;
	bh=WIfgWGxS84Wv7+YJukG5i0Wvzatwm4oH1A+s9RndxRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zxk9LFI2PfuitOXLvX42k/BUO6QCNZf5ltCPk1DJnoP9AaaMYeciUSPrsLhOxMUbjUFP28tH1HbXnQ7nUCW5oYzPItt/nW2SKgZEN2dnN9eKYxO9AuiXAg/09cprtvAEnZVWofNVwj7TIstQ37WPiD9M3yfu95qaMgMfvCaliDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAXfcqsS; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so5206059276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710285969; x=1710890769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpyYuRrjheLrXK53urAFXychZQj84CDy3elPQHJg8tI=;
        b=WAXfcqsS8jJWtrOM+u3n9wjfzNwCo9/c/0Q0TMQ6HvAwP7onCNjIDpzakdA+LkCTDe
         PN9Xf4ZoB4isIBvD2Y5KZoGVhZry5Fyo1WnHAkT6MqIddp3bdmfwcuzWzjMK0Yombvvh
         Ab7ET2ife5UxCb0Dh+bayAklxPA+M93YG+WieNmt7eoGGid5DE1kB0vOvoJMubZ8ol3S
         QwL276Vpgk/R5//vsyZ0XBVJz7qXmuxTsxBHM384Ood3qTF/VYU8ClsCqZUoIhZ+e70s
         jd/tOZksqkfJaKyU+cJ3i3A1NBjP22Ethl7T+GWv3w8d5v21g3q0fCQ3s4vt4PkSsv6P
         NMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710285969; x=1710890769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpyYuRrjheLrXK53urAFXychZQj84CDy3elPQHJg8tI=;
        b=POAFgvsZMbtIpuvbyfM0S/IbRAsoxSw9rxsPN5KSfzMay6P1LcE9M1lkb2PZA7BNmy
         W1MKokFzMV3RikP8jydPUZqvH5vNGkILMjrQ1xrEp2/N9LkCkjDzFwp0HDfqbrYXhMO9
         0q5awXnoQ6lYeZ1jJEXj+eoJ91Bvs7u8/fJ0mmyZyRTF6JwKB7Je2Qh9hUvylfBbvf9/
         Cpqco+7yA2E/3kwjZIuO6a8ok+c3TDAVDRCVzDqUEirkp9zfi2R6Z231k0kCFwcdUALy
         45kQNFyDRTYSALLcF2vdW7HYqa5rDT9ikpl9rLH28l7gELPEOx/XXXmwIGrB6kmSGvZv
         kRmA==
X-Forwarded-Encrypted: i=1; AJvYcCXkY1GsL57x3Hxrk3kNqHE2qy7q5LGCVOeShqw3i52CL5JtieCKawIBnCe9M3crmXoj4v+rWsVhE08u6lYu5/QGUkI6FOK6/VFtmmYb
X-Gm-Message-State: AOJu0YzaQReeCWnakadcUu7aauVr2a5et6w7gFeJKbSIWgUESaDMhu6A
	DvZPzOSpcBPulHBxi71gx8cq6sDdLkkeyZ3/aAX0QLkJYmPZJ/p0znEAIjtvL60UhZjWMLJEYDn
	kmkXdRmfRM5i64fH1Q32DTjqIwvo=
X-Google-Smtp-Source: AGHT+IFLmaDdzdhg+pSCcZtXe4YXB0XArxJCa0kY88975yeZVmf1zRBHeHSS64+FIk1Z5l+BVqyXQqat/DI5W4t30+c=
X-Received: by 2002:a25:910e:0:b0:dc7:4ad4:c977 with SMTP id
 v14-20020a25910e000000b00dc74ad4c977mr864806ybl.25.1710285967766; Tue, 12 Mar
 2024 16:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306222838.15087-1-daweilics@gmail.com> <65f3016c-c060-4d74-ad0f-d1981d1c6eeb@arm.com>
In-Reply-To: <65f3016c-c060-4d74-ad0f-d1981d1c6eeb@arm.com>
From: Dawei Li <daweilics@gmail.com>
Date: Tue, 12 Mar 2024 16:25:31 -0700
Message-ID: <CAG5MgCpW3xwSGgF6VBPiSMkwOz793NO4_nLNhJeqyBhs+jN30w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: simplify __calc_delta()
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pierre,
Thank you for the review!

On Tue, Mar 12, 2024 at 6:18=E2=80=AFAM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
> Hello Dawei,
>
> On 3/6/24 23:28, Dawei Li wrote:
> > Based on how __calc_delta() is called now, the input parameter, weight
> > is always NICE_0_LOAD. I think we don't need it as an input parameter
> > now?
>
> Maybe
>    5e963f2bd4654a202a8a05aa3a86cb0300b10e6c ("sched/fair: Commit to EEVDF=
")
> should be referenced to explain that the case where (weight =3D< lw.weigh=
t)
> doesn't exist anymore and that NICE_0_LOAD could be incorporated in
> __calc_delta() directly.
>
>
> Also I think indirect forms are preferred in general:
> "I think we don't need it as an input parameter now ?" ->
> "The 'weight' parameter doesn't seem to be required anymore"
> (same note for the whole commit message)
>
> >
> > Also, when weight is always NICE_0_LOAD, the initial fact value is
> > always 2^10, and the first fact_hi will always be 0. Thus, we can get
> > rid of the first if bock.
> >
> > The previous comment "(delta_exec * (weight * lw->inv_weight)) >>
> > WMULT_SHIFT" seems to be assuming that lw->weight * lw->inv_weight is
> > always (approximately) equal to 2^WMULT_SHIFT. However, when
> > CONFIG_64BIT is set, lw->weight * lw->inv_weight is (approximately)
> > equal to 2^WMULT_SHIFT * 2^10. What remains true for both CONFIG_32BIT
> > and CONFIG_64BIT is: scale_load_down(lw->weight) * lw->inv_weight is
> > (approximately) equal to 2^WMULT_SHIFT. (Correct me if I am wrong.)
>
> I think the comment is more about explaining that:
>    X * lw.weight
> equals:
>    X * lw->inv_weight >> WMULT_SHIFT
>
I assume you mean
X / lw->weight
equals:
X * lw->inv_weight >> WMULT_SHIFT
However, this is not always true, and that's why I'd like to revise
it. It is true for
CONFIG_32BIT. However, For CONFIG_64BIT, we have lw->weight * lw->inv_weigh=
t =3D
2**WMULT_SHIFT * 2**10. Thus,
X / lw->weight
equals:
X * lw->inv_weight >> (WMULT_SHIFT + 10)


> Also, if CONFIG_64BIT is set, we should have:
>    weight / lw.weight =3D=3D scale_load_down(lw->weight) * 2**10 * lw->in=
v_weight
>

weight / lw->weight should be equal to scale_load_down(weight) /
scale_load_down(lw->weight)
=3D scale_load_down(weight) * lw->inv_weight / (2**WMULT_SHIFT)
Right?

> So IIUC, either both lines should be update, either none.
> (meaning that:
>    delta_exec * NICE_0_LOAD / lw->weight
> should be changed to
>    delta_exec * scale_load_down(NICE_0_LOAD) / lw->weight

I think this is not correct? scale_load_down(NICE_0_LOAD) is the true
weight, as mapped
directly from the task's nice/priority value, while lw->weight is the
scaled_up load.
Their units/scales don't match.

I am quite new to the source code. I could be wrong. But would like to
see more clarifications
on this.

> )
>
> I assume it's better to let the comment as is.
>
>
> >
> > Also updated the comment for calc_delta_fair() to make it more
> > accurate.
> >
> > Signed-off-by: Dawei Li <daweilics@gmail.com>
> > ---
> >   kernel/sched/fair.c | 29 ++++++++++-------------------
> >   1 file changed, 10 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6a16129f9a5c..c5cdb15f7d62 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -252,32 +252,23 @@ static void __update_inv_weight(struct load_weigh=
t *lw)
> >   }
> >
> >   /*
> > - * delta_exec * weight / lw.weight
> > + * delta_exec * NICE_0_LOAD / lw->weight
> >    *   OR
> > - * (delta_exec * (weight * lw->inv_weight)) >> WMULT_SHIFT
> > + * (delta_exec * scale_load_down(NICE_0_LOAD) * lw->inv_weight) >> WMU=
LT_SHIFT
> >    *
> > - * Either weight :=3D NICE_0_LOAD and lw \e sched_prio_to_wmult[], in =
which case
> > - * we're guaranteed shift stays positive because inv_weight is guarant=
eed to
> > - * fit 32 bits, and NICE_0_LOAD gives another 10 bits; therefore shift=
 >=3D 22.
> > - *
> > - * Or, weight =3D< lw.weight (because lw.weight is the runqueue weight=
), thus
> > - * weight/lw.weight <=3D 1, and therefore our shift will also be posit=
ive.
> > + * We're guaranteed shift stays positive because inv_weight is guarant=
eed to
> > + * fit 32 bits, and scale_load_down(NICE_0_LOAD) gives another 10 bits=
;
> > + * therefore shift >=3D 22.
> >    */
> > -static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct l=
oad_weight *lw)
> > +static u64 __calc_delta(u64 delta_exec, struct load_weight *lw)
> >   {
> > -     u64 fact =3D scale_load_down(weight);
> > -     u32 fact_hi =3D (u32)(fact >> 32);
> > +     u64 fact =3D scale_load_down(NICE_0_LOAD);
> > +     int fact_hi;
> >       int shift =3D WMULT_SHIFT;
> >       int fs;
>
> NIT: maybe re-ordering the variables to have a reverse tree
>
> Otherwise, the patch looks good to me,
> Regards,
> Pierre

