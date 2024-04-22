Return-Path: <linux-kernel+bounces-152987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DCC8AC71A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7601F21D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C13502AF;
	Mon, 22 Apr 2024 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIk0DqMJ"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA411CAA1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774830; cv=none; b=C86F3p/UxOyWOB4onqVHfm2colUmDBICgZ1RC8B5Ux93hxKpT8TxVSNHKOwqmP6vnTOvoqetODBYDkaCU0T41FRMl0ktVmW2baqSNlUsXGs4uC1kMnEKihNMub6D0HomZxb0dS84WoabM6Hqkpgo/l38IgmSqvQfdRtaAfgx+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774830; c=relaxed/simple;
	bh=foq5ht+lMPQXu4in46rwNYOqTfbeaW4P5OvmFAJopWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/27PwSiu6sxyH3rpp4s8sCb1nLYwO1LZO/Oo5sw3KsgphXjW/BqevQcMfiSEiZJD12D/B3ux94/JhMNUpZ1OAATkbWuyRvVBtQWE9+uSjXMuH9BVvk72fhgKvFGghBYw/GbAOgKdCc1KeFoU9ql07TMuzjbtYnYbw5SRrIU1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIk0DqMJ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ea1a55b0c0so2198873a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713774828; x=1714379628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywcd19fDJAvHh2oKY2HtCRoc8tp9ImKib5PzcAaTuGE=;
        b=CIk0DqMJ6jHLh16KBVwmcI1HCuz1bxE9PSxkaXM1eqkE+0/EZPTEILBmGcB1HKrNku
         YQL8L5QghknVjpjxd27wsKg/4l02UarfZhv3zbp1Ugg6y6zsI/ekMVbGjmYk8/vzlcGQ
         jmdqgVuhlV6oPJudrMYHZDnGJuVbdyUoAdiJ9kxVakXbOPNj1jO4UAKKsYutgBnWEOhp
         1WivaJKSPauohcuraHOoRgmdlA60DZEGjYfAiQV46bhR3FpWyj5C2ELj+9BGOCETxOyX
         96PcWJXYmzJCcp/dFtRuEFTxOMZett35JvIfdMhlNtXzhEO73o/jExie/H6Yabwo/7+E
         0vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774828; x=1714379628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywcd19fDJAvHh2oKY2HtCRoc8tp9ImKib5PzcAaTuGE=;
        b=n8em2LoJSjZHqTymvreQMy/Ix/2JlQmj79p927IFSORRhiAooQXqNDj0HeXlHtZtA3
         FTevaNda1dHWtd/TctYzRiuCTtjGLPXDAcU5G4V4nxQfKAuQoP1tAt0Vv7swTO8kWFpI
         /XZEpgxwKdOGvH3V5SBOjMMFqkBy/TWhqwer/y30P1ypK4mG5sSpYDk/sSaClqgBWUIZ
         BEJzrTugquQv5wBkYRU2xndcRLgilhHpQuahqn2BEWCdW2DLkCn/nBEHnmdKeZrlo0k8
         5/HQCgP9kXbonutc9XUw9dJSJo3wC2tIyo5reqT6PgeF60c7Q6dLX2FitV2KN5GAhCjm
         BLvA==
X-Forwarded-Encrypted: i=1; AJvYcCXPZEt0LYGfpnxCcQ9lJG5Hy8rvKZyyQcGlVJgU485lejrgDaF1jYy+QRDkgrjgvmAd0m/nlFzTv9ZlqnXG/Css1O7KHQ4BcH13Uvn1
X-Gm-Message-State: AOJu0Yy+P/9bWaHFX2HvQeIThTHtbxUbG9/UfxHpUploafztUU5GJw8J
	z2ANsPmfigBhIsuuugnrBTQKXqbpivTdMfRFCuBSDstT9cJEs+4L2wTNYdeATTTllbrgZdoThwq
	qNgVGgSHL0Cd9oNT8gx5J2qhA4Aw=
X-Google-Smtp-Source: AGHT+IEPJHMY8u7itxLBLQLayGMuxMOVFCMdrOZJ4tTSnqwhtm7xDeLbEZKYZ/SgcKO4gmrr6s7ixsqp9UeoKVIxDXM=
X-Received: by 2002:a05:6870:71cf:b0:221:416:1df9 with SMTP id
 p15-20020a05687071cf00b0022104161df9mr13159216oag.23.1713774828235; Mon, 22
 Apr 2024 01:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422082238.5784-1-xuewen.yan@unisoc.com>
In-Reply-To: <20240422082238.5784-1-xuewen.yan@unisoc.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 22 Apr 2024 16:33:37 +0800
Message-ID: <CAB8ipk-LhSuMsp0DdzjEJN-4XEBT1_ri6BPH_nvxSgFZONMT2Q@mail.gmail.com>
Subject: Re: [PATCH v2] sched/eevdf: Prevent vlag from going out of bounds
 when reweight_eevdf
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	yu.c.chen@intel.com, ke.wang@unisoc.com, di.shen@unisoc.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Because the issue may be urgent for many people, I sent the patch first.
However, when I test on the Android system, I find there still are
vlags which exceed the limit.
On the Android system, the nice value of a task will change very
frequently. The limit can also be exceeded.
Maybe the !on_rq case is still necessary.
So I'm planning to propose another patch for !on_rq case later after
careful testing locally.

BR

On Mon, Apr 22, 2024 at 4:23=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.com> =
wrote:
>
> kernel encounters the following error when running workload:
>
> BUG: kernel NULL pointer dereference, address: 0000002c
> EIP: set_next_entity (fair.c:?)
>
> which was caused by NULL pointer returned by pick_eevdf().
>
> Further investigation has shown that, the entity_eligible() has an
> false-negative issue when the entity's vruntime is far behind the
> cfs_rq.min_vruntime that, the (vruntime - cfs_rq->min_vruntime) * load
> caused a s64 overflow, thus every entity on the rb-tree is not
> eligible, which results in a NULL candidate.
>
> The reason why entity's vruntime is far behind the cfs_rq.min_vruntime
> is because during a on_rq task group's update_cfs_group()->reweight_eevdf=
(),
> there is no limit on the new entity's vlag. If the new weight is much
> smaller than the old one,
>
> vlag =3D div_s64(vlag * old_weight, weight)
>
> generates a huge vlag, and results in very small(negative) vruntime.
>
> Thus limit the range of vlag accordingly.
>
> Reported-by: Sergei Trofimovich <slyich@gmail.com>
> Closes: https://lore.kernel.org/all/ZhuYyrh3mweP_Kd8@nz.home/
> Reported-by: Igor Raits <igor@gooddata.com>
> Closes: https://lore.kernel.org/all/CA+9S74ih+45M_2TPUY_mPPVDhNvyYfy1J1ft=
Six+KjiTVxg8nw@mail.gmail.com/
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@in=
tel.com/
> Reported-by: Yujie Liu <yujie.liu@intel.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> changes of v2:
> -add reported-by (suggested by <yu.c.chen@intel.com>)
> -remork the changelog (<yu.c.chen@intel.com>)
> -remove the judgement of fork (Peter)
> -remove the !on_rq case. (Peter)
> ---
> Previous discussion link:
> https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/
> https://lore.kernel.org/all/20240130080643.1828-1-xuewen.yan@unisoc.com/
> ---
> ---
>  kernel/sched/fair.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03be0d1330a6..64826f406d6d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -696,15 +696,21 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
>   *
>   * XXX could add max_slice to the augmented data to track this.
>   */
> -static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity=
 *se)
> +static s64 entity_lag(u64 avruntime, struct sched_entity *se)
>  {
> -       s64 lag, limit;
> +       s64 vlag, limit;
> +
> +       vlag =3D avruntime - se->vruntime;
> +       limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se)=
;
> +
> +       return clamp(vlag, -limit, limit);
> +}
>
> +static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity=
 *se)
> +{
>         SCHED_WARN_ON(!se->on_rq);
> -       lag =3D avg_vruntime(cfs_rq) - se->vruntime;
>
> -       limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se)=
;
> -       se->vlag =3D clamp(lag, -limit, limit);
> +       se->vlag =3D entity_lag(avg_vruntime(cfs_rq), se);
>  }
>
>  /*
> @@ -3761,7 +3767,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, s=
truct sched_entity *se,
>          *         =3D V  - vl'
>          */
>         if (avruntime !=3D se->vruntime) {
> -               vlag =3D (s64)(avruntime - se->vruntime);
> +               vlag =3D entity_lag(avruntime, se);
>                 vlag =3D div_s64(vlag * old_weight, weight);
>                 se->vruntime =3D avruntime - vlag;
>         }
> --
> 2.25.1
>
>

