Return-Path: <linux-kernel+bounces-37784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF783B4F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264081C2407E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2C3136668;
	Wed, 24 Jan 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="T22HtdeT"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EFE1350FF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136381; cv=none; b=HHcOVNnRFfCeRQm5nYWKeKW+duBrDwR2jpej2W2806BGefICSqjBUIlr3cyFDAo5923ffSuK2ZEJWqu/S7WEa6sLV+NRoEFKM+M6MlQxTOkgl0ljWZp9e0NXiuISzwlgq7oMiI8M/bIu24fD+7tJPPYvGKYYNBJ4kBkbInO6o7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136381; c=relaxed/simple;
	bh=l0yzc+JgbxOIe5aKruZQ1yA8jDtSdkNoVz/2h+iru4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwdTNd/2rZCu5ziPybqymi07gGTCpLbf56gx52ULdPJ5h/1m7uBtKMMJk5RAp/fPNezu8vCP4Yr/gJtXgVpPXU+KkJUoodRGDSEDum2dAAz2/O4WnrBusw9U+ySiE/rH/7MqDxxKQYRYOVKvBim3CATZwMUavEwBPlzV0BH8BVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=T22HtdeT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-337b8da1f49so5344715f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706136378; x=1706741178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b3jCFAz5mwOINLfDRcentDJFNQnYmeC8Gbd55COdifc=;
        b=T22HtdeTV9nGlGPqdZN5HY5PxuIMj7AHLSp5nLXPbmZOhKwX9SeQRxt/8Ui3BodoAL
         N4THOtg/LPxFIi+R/hZ59GX3h/NPOgVuX8yIRQ4pkzG7XjqfTVQZj3Wj8Ir9ravwltpb
         8+eXVFC6f8mEt/LyebKUXJl0QwXqPhVT1b/Ll2l3c+m2Rt3+JLBGPoM5kBt2nHJl1A48
         XbERmp7oY1GR0E10ncnOhbyT1+bB3oL8S24/cyFRg2rOHp+HD7woY3GU8r+c7Yvoalek
         YtuEwEj2ijVUf06hrjEnFQRdAPBQ4u6sWrpxCAnq1ofjNvfnOxfagfvpizO0ZelJBSN5
         d5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136378; x=1706741178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3jCFAz5mwOINLfDRcentDJFNQnYmeC8Gbd55COdifc=;
        b=mjN/S6yD6B/1K87nz8Q3RxjconQYRQE3q5xKyMO0iGR2OVAc3M/14Vb63Ehp44BdP8
         NU2W7I81x4LfMBaY3JwPe4GZ0jSeHxHyzuG0b2Jc0DkNaSYpRLq2s8awV0sgko8+m/+I
         Fv6YL+4DPGiX67Q8dm6OicyPPiFWiGYTSUhxwtFXCKwds0BZUaABnSeIMHsnYYECxGIs
         hv6TCfICxEN2h1tDYtA1BvALxIRMOs1CVR1PvTbWqp2OB4FMhzjaBin1zZFXfrAhXQqU
         n8ReTTJ5y6Hc5eA0dZDPye1gE4XLWEoN1CqCKHt0EzJ0Iivvbs19OBjy17HJPztTZrnS
         KwvQ==
X-Gm-Message-State: AOJu0YzsstPB8fE3XP53CSdaR/pf54EnOKe2smPc2TZbqy864fKxcQN5
	xHaZxzEHXtq1LsyIOp/ONGqYiTXdxtIgcTVFnuOhsqtQ0X/EfYfvuIdBAON3qVY=
X-Google-Smtp-Source: AGHT+IHQtNPTZa9t2N/wgHQZ1ohfyT1J7yHThNKp20AMWHF+2lntBFKyGahAs9gq/TTGUVXExj85sA==
X-Received: by 2002:a5d:5381:0:b0:339:2cad:468c with SMTP id d1-20020a5d5381000000b003392cad468cmr18720wrv.1.1706136378180;
        Wed, 24 Jan 2024 14:46:18 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id c11-20020a056000104b00b003392cb66714sm10652343wrx.61.2024.01.24.14.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:46:17 -0800 (PST)
Date: Wed, 24 Jan 2024 22:46:16 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240124224616.wcrexeb2evkugbak@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <213f94df-cc36-4281-805d-9f56cbfef796@arm.com>
 <CAKfTPtCfYcD_zPr7PqgL5hRYny=n3KW8hr6GY8q7zkoyRN7gQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCfYcD_zPr7PqgL5hRYny=n3KW8hr6GY8q7zkoyRN7gQg@mail.gmail.com>

On 01/23/24 09:32, Vincent Guittot wrote:

> > > @@ -9583,9 +9630,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
> > >   */
> > >  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> > >  {
> > > -     return rq->misfit_task_load &&
> > > -             (arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
> > > -              check_cpu_capacity(rq, sd));
> > > +     return rq->misfit_task_load && check_cpu_capacity(rq, sd);
> >
> > You removed 'arch_scale_cpu_capacity(rq->cpu) <
> > rq->rd->max_cpu_capacity' here. Why? I can see that with the standard
> > setup (max CPU capacity equal 1024) which is what we probably use 100%
> > of the time now. It might get useful again when Vincent will introduce
> > his 'user space system pressure' implementation?
> 
> That's interesting because I'm doing the opposite in the user space
> system pressure that I'm preparing:
> I keep something similar to (arch_scale_cpu_capacity(rq->cpu) <
> rq->rd->max_cpu_capacity but I remove check_cpu_capacity(rq, sd) which
> seems to be useless because it's already used earlier in
> nohz_balancer_kick()

Okay. I need to look at your patches anyway. I can potentially rebase on top of
your series.


Cheers

--
Qais Yousef

