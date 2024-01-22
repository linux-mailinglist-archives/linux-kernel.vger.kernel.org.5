Return-Path: <linux-kernel+bounces-33233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B288366E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F07728BF26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516CC4C3AF;
	Mon, 22 Jan 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj/Bptzw"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E664C3A6;
	Mon, 22 Jan 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935440; cv=none; b=gJq6AnnZUlxDOtrH9EzbPBzPg2PbvtYIV/qfH4CRTZJKyT1TzybV++hx2ZqAQeXYEfZwTvJRLGSOlC5GDojwD9bt4b8RNvl7B90bv0J+cE1b5I1ZvRxqx929hjRYxzo14KPuNfjvmLbLr1nX+j7hOVv/h5DeC2De8wwJVc4O/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935440; c=relaxed/simple;
	bh=BgvNZY/QfTSwVEzDHP++RDFUZNQcr14FA9g3T5+LBvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+S1sgtvcQekDFNoFjJQz7TOMHBlZmrLcYN6afRny5r8rxjtKcSmXsKIFpKq+o8vOHjrQf0rL2u4TZpZRanslCQtU1vWQgpM59LFyMY4ChYmBldPwQrqaBHkFWiqZxKGafw0W6Kwx9RV4Ns3dNWnkf1uelrKYqV5yP/0o6q4riI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj/Bptzw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso1403942a12.2;
        Mon, 22 Jan 2024 06:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705935439; x=1706540239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUlc9dFtmFNVMMileb59mVC2b8uuORrgFOa/X7tkua0=;
        b=hj/BptzwW/KQ/71/3u3J5xnfkVnNR0vR/Tjgz5zyBm5+BksFTeAc8nz9sGpH9mGXBF
         mXLEZaQ/T0PFBx1t+JnhyGLk8DVNNprrdjPfDn6fqkhhR6Do4mpFrjMGYdNX6WFx4mFz
         LR0RxKpUPpisjYQU9u3Gam9x114b0Ozy+XCIG9fCZ6n7050huyZdODilf0l11Nu8uNio
         TsrGbIrv1jQ6jfTgJ19nDGvPLCEAzLecbMFeZzw6v45qqcbmCVDkmU2oQDmEhJYzOUao
         uTngJ/I/OoLwmM+HscLv+PRdgVMwbzRbOPYa9iJLtNIXwfJ8YG8yYPt0B1a+6Ov9p+Er
         Yy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705935439; x=1706540239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUlc9dFtmFNVMMileb59mVC2b8uuORrgFOa/X7tkua0=;
        b=DYXRnUEfvYeF1z8UGgT3pbToyPSY76H6WKf2HvQwSfPWSMxDX2XeqW2cuetNivu273
         YOsWMMXh61P/Bc5bbUaEtU2Lu/lImJDqMo9Wl2maYx2LRPjwrfkYqpS+ctDrkPj/qOiy
         Ja28OvL2y0FF7o4mDcD2QkDFDQleb2ykwaDleNt8nnSkiZjpNb8HoBz+qUaTzPTGkusn
         om8g8PGd/jkDgqeQXO47x1SFKEldE7MhdbMx34yXs1GElqEla3JPKpUPUZWtKL+LZDNJ
         CZ1KDjzG0RTF6ZopRu4O8yFF88Aymjgp2oIbt0rt5ijt1MrBGxhWHsVN9loGTFdnG2dc
         rh3A==
X-Gm-Message-State: AOJu0Yxa0EQAOcHJZieQHaxl+VxImy5tNqb8M/EalzyJB3uNWq6pZe5R
	08VAdzSBqkouoIdaKvga/JyLKhLvbFhAPsxISLoDHb4qVnOUNsY2kAPdTBfs278KTY5lpEMY2gU
	WOu3er/vv5ADTCnZa+7oacRPifcyLC6sqL18=
X-Google-Smtp-Source: AGHT+IEYlSZ6qlXw1uFfqh8Gk1pP+G/35ntlZveWkUpzEBpJ5/GxWOpj2lv8H3YRYiZwdDTFTI7rPQAd7CvBLwEyQG8=
X-Received: by 2002:a17:90b:3786:b0:290:666f:7be2 with SMTP id
 mz6-20020a17090b378600b00290666f7be2mr1006216pjb.82.1705935438597; Mon, 22
 Jan 2024 06:57:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119113319.54158-1-mario.limonciello@amd.com>
In-Reply-To: <20240119113319.54158-1-mario.limonciello@amd.com>
From: Wyes Karny <wkarny@gmail.com>
Date: Mon, 22 Jan 2024 20:27:07 +0530
Message-ID: <CAAE01kHEperoassBmLwM3pWhJmWpjRS2fcE8VPkLAgvz7yAuQA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix setting scaling max/min freq values
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 5:49=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Scaling min/max freq values were being cached and lagging a setting
> each time.  Fix the ordering of the clamp call to ensure they work.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217931
> Cc: stable@vger.kernel.org
> Cc: wkarny@gmail.com
> Fixes: febab20caeba ("cpufreq/amd-pstate: Fix scaling_min_freq and scalin=
g_max_freq update")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Wyes Karny <wkarny@gmail.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1f6186475715..1791d37fbc53 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1232,14 +1232,13 @@ static void amd_pstate_epp_update_limit(struct cp=
ufreq_policy *policy)
>         max_limit_perf =3D div_u64(policy->max * cpudata->highest_perf, c=
pudata->max_freq);
>         min_limit_perf =3D div_u64(policy->min * cpudata->highest_perf, c=
pudata->max_freq);
>
> +       WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> +       WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> +
>         max_perf =3D clamp_t(unsigned long, max_perf, cpudata->min_limit_=
perf,
>                         cpudata->max_limit_perf);
>         min_perf =3D clamp_t(unsigned long, min_perf, cpudata->min_limit_=
perf,
>                         cpudata->max_limit_perf);
> -
> -       WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> -       WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> -
>         value =3D READ_ONCE(cpudata->cppc_req_cached);
>
>         if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE)
> --
> 2.34.1
>


--=20
Thanks & Regards
Wyes

