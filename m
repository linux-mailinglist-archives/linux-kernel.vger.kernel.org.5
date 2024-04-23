Return-Path: <linux-kernel+bounces-154437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E18ADC13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0121F229EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C6418659;
	Tue, 23 Apr 2024 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Unvu1wUu"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C01228E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841533; cv=none; b=iYneLFW9CyOh7sDW4wG0ec/LPT3anFRpW0v6m6ZMvzxkAjPBpiPiYewyuU+Ks8ZEPZgruvtgNYqYPQTgEKco1Xm3X2ehYL+JtE8mIlVpY8HWsmk9T/fb1kF44CNWfIllC3aOWmp+nmp5Iar3+EtMMg3kf3LLtBXRW+qvUlJ/wqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841533; c=relaxed/simple;
	bh=xGPyMt0hx98/yC3b1wsp7YdQjtC44UZUo0wvYYRoJ6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndKjmzfTlluRuSqhAOLyqJq3ixK6x02WbBJ8/iqFT65slhUzBz2B84rtxrNKHAajZodg68NsB9C5CwsQw5JrRTOXe6fmDriKNqAbIuglM1dV1usPWkawnU8YAt7ixYHb4TacNOJhfUJbykSKtfmr0PqUG9nrSUiuJv2wAxw7yio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Unvu1wUu; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-222a9eae9a7so2660403fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713841531; x=1714446331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAAQr9e+UN87SLUI6YM0IRXC202l4ssUfCJlkLBuHwo=;
        b=Unvu1wUuiWfuMA4z76CaZ6+CfrEUgGxz3cAY1u/9+2Y0GjMMSbUJ1ysOw/m75bOwEs
         LA2itCARiUUpvKgwZer8lnUG0NXTFEkjYO4xhW4IxeVAy5+E2v5oVTsfT8U4eIHs9LTk
         i9/BVbRGWzcOQVPboCLj+yJWKwbDkyWC6TWd5nTVY8MPbgGCE3ny62/aDdXQcmxzoFKZ
         unYjVhw6cvrDQSv8zDhPk9RyVb2zI+kHyd6Ly0Q9vcE4Pni7h44lRSxAGAK14r+uyT/J
         uyG8aHgF3kFXEDq+3bYeCQJl3D0hKgyVCGArvRxelYnnQycOxpa63erX9nyhz9ZzhH7l
         d1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713841531; x=1714446331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAAQr9e+UN87SLUI6YM0IRXC202l4ssUfCJlkLBuHwo=;
        b=vcWLFdfJ5/W5k8jgxHjPGvfe4aPYw21A9jIlcpGSv+GmAuGG73wgSRghK7Mmvg6GYE
         BaANbOyFT4XJ/y1QJuCuTqD1WQGoBX9A/mZ7uUTrBHiUxS3EShyfuP2AOVhQto4rN8Bo
         gC/MQKVomrvOD4EXoEw2JETqza40x4cLuoAyAqH7fQA2FST3XyGbZRF/shBP/Izxzaj4
         MBHUtArylhkh6DlGAe3nhrFf76CtVNIsPJjMDYB2p4aVIca+IU+pUA0fpf9S+MHCk/M7
         1ZLhLbtDtXW8U5boAelc+60bc0iwYGRUPx0vdI1IoEJKyz1tgSMAL6KOh4alwqOAKVVm
         RbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXflPHkVt7GvEdMqg8yU8qQbLO8d6nMHB+xpcnjsudSCQsmUX1L2S/mfBih3I0Kns0h5QSMFNHe9Ug2g5zEJIL45E8Zl9u6Lw6Fv2YU
X-Gm-Message-State: AOJu0YzQIc2BZ2XbDrbNpG+Zwj/6NwN5Wfis03wVRCiUJX+fP6LhyEuH
	6zPbJA+V94cFlcixc2k38lWn0dvHeifR5yhzVWiXu249k6vArt5rwGzCchzCq1S+m084QSdMUGs
	fHCx/aqNMVa2/1eYA9z34Mllg7OY=
X-Google-Smtp-Source: AGHT+IGhLiSLWG701oq3ocGWefxJYB06lmqCkexsFgM0GvDqIty2u7hHC6FcFJzpa0REgOvtDZ6S1aDvZAAAAAALe0c=
X-Received: by 2002:a05:6871:7987:b0:234:d838:ef3e with SMTP id
 pb7-20020a056871798700b00234d838ef3emr15575983oac.12.1713841531264; Mon, 22
 Apr 2024 20:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422082238.5784-1-xuewen.yan@unisoc.com> <CAB8ipk-LhSuMsp0DdzjEJN-4XEBT1_ri6BPH_nvxSgFZONMT2Q@mail.gmail.com>
 <20240422094157.GA34453@noisy.programming.kicks-ass.net> <CAB8ipk9M1wLXV7MWMBYGMhKbY71QqwkvchiENeWTg7JERe6kZw@mail.gmail.com>
 <20240422111744.GO30852@noisy.programming.kicks-ass.net> <CAB8ipk8ZBSnJfw9Ow9My-VXG1TU6DVY7mOL_i0Ejdd7GUZCLWA@mail.gmail.com>
 <20240422155937.GP30852@noisy.programming.kicks-ass.net>
In-Reply-To: <20240422155937.GP30852@noisy.programming.kicks-ass.net>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 23 Apr 2024 11:05:20 +0800
Message-ID: <CAB8ipk-WYVLsRi1_wnm2vF3M4RDnV1cSomb4MkJ83ef2GY0gzg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/eevdf: Prevent vlag from going out of bounds
 when reweight_eevdf
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	yu.c.chen@intel.com, ke.wang@unisoc.com, di.shen@unisoc.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:59=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Mon, Apr 22, 2024 at 09:12:12PM +0800, Xuewen Yan wrote:
>
> > By adding a log to observe weight changes in reweight_entity, I found
> > that calc_group_shares() often causes new_weight to become very small:
>
> Yes, cgroups do that. But over-all that should not matter no?
>
> Specifically, the whole re-weight thing turns into a series like:
>
>             w_0   w_1         w_n-1   w_0
>         S =3D --- * --- * ... * ----- =3D ---
>             w_1   w_2          w_n    w_n
>
> Where S is our ultimate scale factor.
>
> So even if w_m (0 < m < n) is 2, it completely disappears. But yes, it
> will create a big term, which is why the initial vlag should be limited.

Okay, I understand what you mean. Even if the weight during dequeue is
very small, the weight will be eliminated during enqueue.
In this case, the necessity of the !on_rq case does not seem to be
very important.

On the other hand, the following case:
place_entity()
{
..
 5244                 load =3D cfs_rq->avg_load;
 5245                 if (curr && curr->on_rq)
 5246                         load +=3D scale_load_down(curr->load.weight);
 5247
 5248                 lag *=3D load + scale_load_down(se->load.weight);
 5249                 if (WARN_ON_ONCE(!load))
 5250                         load =3D 1;
 5251                 lag =3D div_s64(lag, load);<<<<
..
}
reweight_eevdf()
{
..
                 if (avruntime !=3D se->vruntime) {
 3770                 vlag =3D entity_lag(avruntime, se);
 3771                 vlag =3D div_s64(vlag * old_weight, weight); <<<<
 3772                 se->vruntime =3D avruntime - vlag;
 3773         }
....
}

There is no need to clamp the above two positions because these two
calculations will not theoretically cause s64 overflow?

Thanks!

>
> Notably, nice should not exceed 88761*1024 / 2, but I'm not sure I
> remember the limits (if there are any on the cgrou pmuck).
>
> But if roughly 27 bits go to weight, then vlag should not exceed 36,
> which should be well within the slice limit iirc.
>
> Also, as said before, due to integer division being truncating, the
> actual S should be smaller than the expected S due to error
> accumulation.
>
> Anyway, the things to verify are:
>
>  - the S series is complete -- missing terms will mess things up right
>    quick;
>
>  - the limits on both the weight and vlag part, their sum exceeding
>    63bit (plut 1 for sign) will also mess things up.

