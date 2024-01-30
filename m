Return-Path: <linux-kernel+bounces-44709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A4D842652
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40205285F18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6246D1B7;
	Tue, 30 Jan 2024 13:42:25 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959159165;
	Tue, 30 Jan 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622145; cv=none; b=Ti+EWyIxCqetDLeJbd8lQgTVyj38TvRUN7O4RlPqEp/DJsBc4x9P7j08LpoaaWNxkbsNjU6yVPil/DrkSC+6+1v790+pGz19cqL13I+/mRYKZ3QwNMHaHWZ47PRMbgj97yPgemqX8t21knXtuMujVA4f2OTajP4DUBGty86Jbzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622145; c=relaxed/simple;
	bh=yZIuSbQwmhsNBImBxP16rMMqoK8f4QFDk5EkKtA5CJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DP9vFLy0Tj04VBQijdJB7D059fMOYFgfRf+M5feNXW093eRpFFOufUP7iiXKxCY1I5KdW6aVw4HcC+9NgDWarCVbfnj+lIA83JX8DphWUQiB10Uqskkq92pDBFxAzvhzYL9BKlNcSj/WB0cAjtTrc0MujirzCdLCD1WABJRsdiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59a1f85923aso236658eaf.1;
        Tue, 30 Jan 2024 05:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706622143; x=1707226943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGl++iIA4A9u+4qEV+u6ph09ARs/qmkRzVLAgGs2Okc=;
        b=BHX7OPApczGexSMZ/ylPW+g01dVce1hK3GYPovVFtF1J3BSrzkfu8msKu8+GEd0Je3
         WO1rjqV4v3XZ9VA5gjUMQhDwQJw1nf7jetP4oAaSkI95ONisugQCwHAzfIR0nnB824cj
         oGCTtgycrltt4KlMq09O5HJD096BWS+6KprjnUIzMT0ONhsnZObgMEMZAKeFyTg347aQ
         tHsPHwy978HMfxjCGIoEu7gJQExaCtH+nDveYEOllrcFYCjz2P6vKcgzMVwulGRwh8b3
         xZUwbQCnWM2XtaSPHx4jOZumCxVLn74em2Swg6Cy417AoaLNfKh3SMcVrZg4XLF3Ov9k
         PlrQ==
X-Forwarded-Encrypted: i=0; AJvYcCWohR6uluzBy/vW9auzuR+vySYZ8bbPg/xSuP7yQUdNJJmKmv61s+1ccuud0O1YoeFdC8fgVpXbOPb/UAcaNQFICEo0a0s1DmgCPRNCfixfMz9Za1h2EEHV7aLJUAzTrvVWa97yUqY=
X-Gm-Message-State: AOJu0YyKSTAl1tQ0xAVBZ7c99NaDipwjTmNunr3mcmVkMBYLJ+kzfv4i
	KBfM9pNgqSLFdOyh0x6pyrTWM0E9jofG1rAeR+LVr0qat9WUduTty0oKOJFfxyG2CtoMWk7tDBW
	XZm4AhII1BfTGk3fB/QJzPjZRnFUHuu3OoN0=
X-Google-Smtp-Source: AGHT+IGW/gIo/IHhmpwB9vVWiQRFfsVvA0RJeOnRNPHdBsXzjS/Kmjhnfbd60m1A88WTc89VixssY6oxlvg6pwj+4uU=
X-Received: by 2002:a4a:dc92:0:b0:599:e8ff:66d9 with SMTP id
 g18-20020a4adc92000000b00599e8ff66d9mr9403802oou.1.1706622142795; Tue, 30 Jan
 2024 05:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5770175.DvuYhMxLoT@kreacher> <2192653.irdbgypaU6@kreacher> <Zbie+bepNv1xob3J@linux.intel.com>
In-Reply-To: <Zbie+bepNv1xob3J@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Jan 2024 14:42:10 +0100
Message-ID: <CAJZ5v0hwXbtYBLx8EJo3N_SY9RU-63syf=6Q-dCaOh7eXkg-0w@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] PM: sleep: stats: Use an array of step failure counters
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 8:02=E2=80=AFAM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Mon, Jan 29, 2024 at 05:11:57PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of using a set of individual struct suspend_stats fields
> > representing suspend step failure counters, use an array of counters
> > indexed by enum suspend_stat_step for this purpose, which allows
> > dpm_save_failed_step() to increment the appropriate counter
> > automatically, so that its callers don't need to do that directly.
> >
> > It also allows suspend_stats_show() to carry out a loop over the
> > counters array to print their values.
> >
> > Because the counters cannot become negative, use unsigned int for
> > representing them.
> >
> > The only user-observable impact of this change is a different
> > ordering of entries in the suspend_stats debugfs file which is not
> > expected to matter.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >    * Use one cell less in suspend_stats.step_failures[] to avoid
> >      introducing an unused array cell (Stanislaw).
> >
> > @Stanislaw: This is different from setting SUSPEND_FREEZE to 0, because
> > that would complicate printing in the sysfs attributes and the debugfs
> > code, so I've not added the R-by.
>
> LGTM.
>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
>
> > +     for (step =3D SUSPEND_FREEZE; step <=3D SUSPEND_NR_STEPS; step++)
> > +             seq_printf(s, "failed_%s: %u\n", suspend_step_names[step]=
,
> > +                        suspend_stats.step_failures[step-1]);
>
> Consider (in separate patch) removing SUSPEND_NONE from suspend_step_name=
s[]
> and use step-1 for it as well.

SUSPEND_NONE is handy for printing an empty string when there are no
suspend-resume errors.

