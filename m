Return-Path: <linux-kernel+bounces-122782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA6888FD2B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3DD1C2F348
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833E67BB1F;
	Thu, 28 Mar 2024 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apjkq7fl"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D154777
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622066; cv=none; b=JxQ+LnO6R3kzVKi38cZ1BhJDuW41ZTlF6stfIweX2RwSHyFq8XGlneOPpFusRdE6U317MjW15c5CIwZJZuNaOxNN5cTO2hV7vtkVzBKhrJyU5OP8vB58aTSV6443Q3Fr5pRBobkyvcczJoNBnpjkMm78Cec59jGlROsqgn4xNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622066; c=relaxed/simple;
	bh=f8v7EOGFo2hJ2Y2qlv/bBltA+1RGsGETJcyIpWfuJ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsiYXQvgv7C/dghATOG2tH8fU4frwprneFZaNED/Y1pY3fKyBJWVYNGYl2ejPzqxnqYymNtA9jIKOMj2iz2mht5bXjDf14IjRvx14bBXDKL7eNL1m+s+F7OqbpRUlWkzIOZfk09iEZvjHESyXKEZsKO8wsDWcqCtKMqaAtnRmgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Apjkq7fl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso879892a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711622063; x=1712226863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzR01yK0YozP3svh94TbV0oZTAet2ediyANhbIq549c=;
        b=Apjkq7flOm0MPPfiujfSubLgow2+jjXrjDl/dS07y1gJyMR6go2LpL1y+NAnCicQOC
         +Zlkqn3vFkQuJb7p0c2T/n7HQCXNux9l2/VGrTV1BWilFnWwOhgkUJNOdSMqFBUhdC/p
         aFhdMgXAU6bxWjE7IkbvHCr3Z5M+heCxLj7btMKMah7ucODOaojhr9l463dXbXTf43Ib
         daGyMlb/KvMT97dXlWf+a/R1qQJsNlXdL/BHqimCH9lPk6uRRbfwaDoafHjY59+wFVSr
         nEu/Yxyx4z/HRBv/BFkcMpsgm8+/L6/Lu/cDgRx+Ignv/ZLeRE7SpzPEFG55jTmUzrQx
         ik6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711622063; x=1712226863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzR01yK0YozP3svh94TbV0oZTAet2ediyANhbIq549c=;
        b=V1oAAgZvEd3zd0QFPu3TmKMnZaB6rVGmiELLDSY6sqza/F8Um5rUz48xZNfZRcZBf0
         0kRlxVxESp6TuH4t4KMOZiJOtkDA+4orBcdG5eGNmkfQBAUFtpB1XyIC9BI6eVuGlEGz
         +Qtoz6qRlfAKk2HzS71qvkWO2kKKdJ/NX03eSwWiqVcnV3+3tLEkFz1VVPqgmbajqt5i
         Zp3NUaKNj57bpDdfSajB0ermBIzj7i/t+d0cjaCIXFxz4IZZziqIGHWB0aWbijrcFNr0
         07Y6SO0+M1ppOc0tmDLDKWvt463vi73bIh+d4EV/gCbRt6dFlEgUcB+83DrFGLSSFWFp
         6roA==
X-Forwarded-Encrypted: i=1; AJvYcCVeRH/ZJ+Hnlrx/M92vlq+RRA/nHZRrFE0mjhEpumkFw+wFh/JFP+dpSr0bhIQrvmAKtIQ2yl4gsfQlyHliHE9hf+r1eUMfSnOCTUk9
X-Gm-Message-State: AOJu0Yw/AAwyXDkPx4qyXPspQFx8CpeTxA7F7As/Wh2jMTIMw3Ci2opa
	FaWp9+WlvpaWEVCrSzy/b3I3T8cRmS+q59FYyFovcNpYSuSNi9cY
X-Google-Smtp-Source: AGHT+IHM1Xk+KJApBgolLmlnZTZNtHbMU/dYAeIjh3/T/2z1EsetN5w3ibLMmeLprAD+czTBOuelWw==
X-Received: by 2002:a17:907:7e94:b0:a4e:f44:f73e with SMTP id qb20-20020a1709077e9400b00a4e0f44f73emr2070457ejc.13.1711622063012;
        Thu, 28 Mar 2024 03:34:23 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id t5-20020a170906a10500b00a46af5f023bsm587463ejy.202.2024.03.28.03.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 03:34:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 28 Mar 2024 11:34:19 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, qyousef@layalina.io,
	linux-kernel@vger.kernel.org, vschneid@redhat.com
Subject: Re: [PATCH v3 0/2] sched: Minor changes for rd->overload access
Message-ID: <ZgVHq65XKsOZpfgK@gmail.com>
References: <20240325054505.201995-1-sshegde@linux.ibm.com>
 <ZgFTtAOw39tIyfzR@gmail.com>
 <3c92c18b-6a19-4477-9972-1219c29b3d71@linux.ibm.com>
 <ZgKApcWeuwxc2+WO@gmail.com>
 <38c39ea6-21df-44e9-96e7-6f6fd35822a7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c39ea6-21df-44e9-96e7-6f6fd35822a7@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> 
> 
> On 3/26/24 1:30 PM, Ingo Molnar wrote:
> > 
> > * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> > 
> >>
> >>
> >> On 3/25/24 4:06 PM, Ingo Molnar wrote:
> >>>
> >>> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> >>>
> >>>> v2 -> v3:
> >>>> - Wrapped check for value change inside ser_rd_overload_status
> >>>>   as suggested by Qais.
> >>>> - Added reviewed-by tags.
> >>>>
> >>>> v1 -> v2:
> >>>> - dropped Fixes tag.
> >>>> - Added one of the perf probes in the changelog for reference.
> >>>> - Added reviewed-by tags.
> >>>>
> >>>> tl;dr
> >>>> When running workloads in large systems, it was observed that access to
> >>>> rd->overload was taking time. It would be better to check the value
> >>>> before updating since value changes less often. Patch 1/2 does that.
> >>>> With patch updates happen only if necessary. CPU Bus traffic reduced a
> >>>> bit. No significant gains in workload performance.
> >>>
> >>> Could you please post this against the latest scheduler tree, ie. tip:sched/core?
> >>>
> >>> Thanks,
> >>>
> >>> 	Ingo
> >>
> >> Hi Ingo. I had mentioned the same in cover letter. Sorry if I didn't 
> >> mention it in the correct place. 
> >>
> >> *These patches depend on below to be applied first*
> >> https://lore.kernel.org/all/20240307085725.444486-1-sshegde@linux.ibm.com/
> >>
> >> After that the above patch would apply.
> 
> Hi Ingo. 
> 
> These two patches apply cleanly now to sched/core. 
> 
> 7a9dd7ef946c (HEAD -> sched/core) sched/fair: Use helper functions to access rd->overload
> 4f24aa918558 sched/fair: Check rd->overload value before update
> c829d6818b60 (origin/sched/core) sched/fair: Simplify the continue_balancing logic in sched_balance_newidle()
> d0f5d3cefc25 sched/fair: Introduce is_rd_overutilized() helper function to access root_domain::overutilized

I've applied them, but note that there were quite a few avoidable typos 
and grammar mistakes in the changelogs. Please always review what 
you've submitted versus what I have applied and try to learn from that: 
I almost invariable have to edit some detail to make the changelog more 
presentable... Could you please take more care with future patches?

I also renamed the accessor functions in the second patch to:

      get_rd_overload()
      set_rd_overload()

Plus I've applied a patch to rename ::overload to ::overloaded. It is 
silly to use an ambiguous noun instead of a clear adjective when naming 
such a flag ...

Thanks,

	Ingo

