Return-Path: <linux-kernel+bounces-34062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AACF8372B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC8D1F2B3D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F0A3F8F2;
	Mon, 22 Jan 2024 19:37:27 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9791E1EF07;
	Mon, 22 Jan 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952246; cv=none; b=Q+aLq2dng5m4yxEARRlbGPkhq+mPH5UNMM+H+6Ku4yD1jEZJvCZ+8YwpRmPo57yqKmn5E1WlEtX+dZLY9ahEZ2sohjRkzDphY/Z2DunMA0phQpgmjpE/GqeXW0q85zU5eWETIhoddj9NQkXMleAvmq/954qD82U2huxCW9tQAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952246; c=relaxed/simple;
	bh=RoIkcs5ey0VmVT8DRVQBY+Ice/V2Jk6D5ruHVfHqb6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUG9ZSZykP0Fa36paAJxEOp75We4mw+qZwJz3nyNgZysJfAf8oEZz0Vuwrl9dPDeZBlvQqEzwmwzD0LfsAfqx2ia/3QY3US6w5YGPTN+89Nv5ithFs4KRousWHHnNunwgAYXlVvhx1ov8QdENLoM6NP9rRL7ZyPX9LoCAOF9MDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5958d3f2d8aso225975eaf.1;
        Mon, 22 Jan 2024 11:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952244; x=1706557044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nesK9y4qWZhrNCSiCMAkJgfEGumzzvprEvfcz7ekwg4=;
        b=pFkB8C6kfiJ+Dkx0yQHLZ6JdwXEsXOb/OJiJSOY2tknnvnaDXFZBqWi+Z4TEuWUCjQ
         jHJAfW0C+qEdbCfY/2jiNTXKld0czbD7zpJ/sfvSXdYu76FjLkrT8OwY6oKpoLf1Xa5N
         KaE75jNGvPiYozIJUSlxxBptOdAzT+hJcTOGuBwqXxokIsGNhKI9APVPyYsehwHZi6BK
         AOclO3QYnGpXhz4q17Mp8WxdvbUPeHvDUuwhePjwnhPPN8BN2gM8iXY8uLEyxycC5GuP
         toCL3CKrdeI0FPR1fManrajl3KPXG5F5T24e6dVkh5zxg0K+coe5T9IucSIvk3hHfh8G
         pkJg==
X-Gm-Message-State: AOJu0YzIo8JZU82fXKkWJyR0Iwjnu82GtZ7CN7CoWOv6M+h/1QQWiq+Q
	0PFcAynTXlh57ZlsusOwJsLU6CrydzjW97+uKhfw34Nac7MYq1GLheCloTJpE3qLh46yzwv7kYK
	QeHVK6y8bsoA/FtZkTySLUHMmf9A=
X-Google-Smtp-Source: AGHT+IH0fdGswoQ6uEC4cc+D2uB7ejqea2Nnj7UmJc5iLidGGpOGUvopdRgTpzEh6BeeFThhHzHcXlUkMCieOABJ27k=
X-Received: by 2002:a4a:d744:0:b0:598:e709:7620 with SMTP id
 h4-20020a4ad744000000b00598e7097620mr7318381oot.1.1705952244669; Mon, 22 Jan
 2024 11:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119113319.54158-1-mario.limonciello@amd.com> <CAAE01kHEperoassBmLwM3pWhJmWpjRS2fcE8VPkLAgvz7yAuQA@mail.gmail.com>
In-Reply-To: <CAAE01kHEperoassBmLwM3pWhJmWpjRS2fcE8VPkLAgvz7yAuQA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jan 2024 20:37:13 +0100
Message-ID: <CAJZ5v0jXvjaC5niHqSxQyc+QnEj=gf+vgKrjjhdFkTgQrPHb3Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix setting scaling max/min freq values
To: Wyes Karny <wkarny@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 3:57=E2=80=AFPM Wyes Karny <wkarny@gmail.com> wrote=
:
>
> On Sat, Jan 20, 2024 at 5:49=E2=80=AFAM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > Scaling min/max freq values were being cached and lagging a setting
> > each time.  Fix the ordering of the clamp call to ensure they work.
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217931
> > Cc: stable@vger.kernel.org
> > Cc: wkarny@gmail.com
> > Fixes: febab20caeba ("cpufreq/amd-pstate: Fix scaling_min_freq and scal=
ing_max_freq update")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Reviewed-by: Wyes Karny <wkarny@gmail.com>
>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index 1f6186475715..1791d37fbc53 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1232,14 +1232,13 @@ static void amd_pstate_epp_update_limit(struct =
cpufreq_policy *policy)
> >         max_limit_perf =3D div_u64(policy->max * cpudata->highest_perf,=
 cpudata->max_freq);
> >         min_limit_perf =3D div_u64(policy->min * cpudata->highest_perf,=
 cpudata->max_freq);
> >
> > +       WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> > +       WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> > +
> >         max_perf =3D clamp_t(unsigned long, max_perf, cpudata->min_limi=
t_perf,
> >                         cpudata->max_limit_perf);
> >         min_perf =3D clamp_t(unsigned long, min_perf, cpudata->min_limi=
t_perf,
> >                         cpudata->max_limit_perf);
> > -
> > -       WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> > -       WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> > -
> >         value =3D READ_ONCE(cpudata->cppc_req_cached);
> >
> >         if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE)
> > --

Applied as 6.8-rc material, thanks!

