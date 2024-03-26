Return-Path: <linux-kernel+bounces-118500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AA188BBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3040A1F3AEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E42132C15;
	Tue, 26 Mar 2024 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJjGLE1N"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6518C38
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440043; cv=none; b=FOQl0Ph/+d0ZJAqAOj3c/PieIsnromwDFntN4PjnM7OkcTX1upvrI0EMDjZ10d5HPBieK2AytpnKeTqXkBhOYfqDN75j/bYABDspcdclgZnV7Z4RoGRdggNvTDIPVzvVLhggzrmTyeL4Qz8GSViZ35SdfqOQ/gTUcS0FY3udpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440043; c=relaxed/simple;
	bh=6MaqMWqkhOmxMrgHOZoSKLlk45zsUaUQaGJ4Twhftac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFd8Tis6SzF9T4utq6F6Ac+/RKl+z8U5Xl8sdpTOBSq+hViuOiGVR1TF2lVyYPEvsuJx2UNzccxk3tji4aY4m6h0p+bVAS5C9iIolFqAbecTfnU5DOa1Q1PAWBNpZcowZ/3fzsFBGO4lBX2gN1+35ZBElIFfpdIOnqbYkgclTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJjGLE1N; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a468226e135so613023466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711440040; x=1712044840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVV9SsT8yjPiZohWj6zll+WF7QMruuGTauASL9U5jK4=;
        b=QJjGLE1NJsyCpceE7UeZrI4WhsHD+ijVXVMlYp9wbFGiDR8uczEpcYG5ftSRvWzTu9
         KC/rgJv8WOpr0AZW32L2kpBID1MFnwNFd+RmxBRIRma253ioMWCfpohYCQwgOy1hGLrM
         HZDJXXZmQU81W6QDkHx2yfEgrLlZtlruv5MK2n9RUWoInHR9qNrREFzYcoWROZTBkjF8
         gKsc+UnPMymJ9kOgI8MEHWQCvBx8Lpe8BB1a5LlLwzvwpFy7r0RFEp6GxOt068DCiJIl
         t7VB7u1fDu8a6p8LdoT3HLPo5BHdQZHqtRtdWhu3cjpdm3uwRceASYt94bZZx5KmOcLv
         Y3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711440040; x=1712044840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVV9SsT8yjPiZohWj6zll+WF7QMruuGTauASL9U5jK4=;
        b=SB5FxhmBWOhS4pGmOMlEmUoYxO3/+uzvKcBStCA2MVIEljtP+wx6+dbe86YJ6/WtJY
         RWF5a+/q4gabPu5vrCBECJey5N3n3cjZTiJBaqotHRZEaQEVkjmiPYpXDfSWYMWea/3Z
         tEyraau4wlN0RDk0ou52TMzbwzKFQCPzs+7ftFuRVZBbMwukJONYaq0mSg3UrGGdN+AN
         vRsYAUlIDntfXVXqy7RCKYldqCydZmyFVwa7O+E1SepXOrloXU31I/Mj4ZcpZY13LBx9
         9gNruR1MoVITGP1L2mzYh7hcMGfkuM2WeJZ37x36X6UVs+ZRutd3dtyHzfyaHj+YRzqF
         mM2g==
X-Forwarded-Encrypted: i=1; AJvYcCUpMX2dExaz6ZIb7reTDVGGcKCRr5G9AlWEhxUmxiPV9kf9EcR83wVBgIg0bqFwZoGTVaJdfvX/VOF9YrbIEHf5QKZJ3M1QY3Ty3Pk9
X-Gm-Message-State: AOJu0YzpF8WuYB73Y6tHTjj+w+rlyRchiuNA4zuNBc29oq0vu35lX3Ui
	pj0wbzHC64+Es3rBgfRHpev8rYT9IKPxYC0wBXZsWrgo2tBw1ez0
X-Google-Smtp-Source: AGHT+IE11YMizLgUiodQ+uo2VD0DjbIQ+pKbOcdHSZLZ6sFjZ7ktIf3mF9PzTQC1Yk51FVafBoGNvw==
X-Received: by 2002:a17:907:7f22:b0:a48:56b2:d988 with SMTP id qf34-20020a1709077f2200b00a4856b2d988mr1704578ejc.59.1711440040130;
        Tue, 26 Mar 2024 01:00:40 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id a27-20020a170906191b00b00a46bd891b5bsm3942106eje.225.2024.03.26.01.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:00:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 09:00:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, qyousef@layalina.io,
	linux-kernel@vger.kernel.org, vschneid@redhat.com
Subject: Re: [PATCH v3 0/2] sched: Minor changes for rd->overload access
Message-ID: <ZgKApcWeuwxc2+WO@gmail.com>
References: <20240325054505.201995-1-sshegde@linux.ibm.com>
 <ZgFTtAOw39tIyfzR@gmail.com>
 <3c92c18b-6a19-4477-9972-1219c29b3d71@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c92c18b-6a19-4477-9972-1219c29b3d71@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> 
> 
> On 3/25/24 4:06 PM, Ingo Molnar wrote:
> > 
> > * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> > 
> >> v2 -> v3:
> >> - Wrapped check for value change inside ser_rd_overload_status
> >>   as suggested by Qais.
> >> - Added reviewed-by tags.
> >>
> >> v1 -> v2:
> >> - dropped Fixes tag.
> >> - Added one of the perf probes in the changelog for reference.
> >> - Added reviewed-by tags.
> >>
> >> tl;dr
> >> When running workloads in large systems, it was observed that access to
> >> rd->overload was taking time. It would be better to check the value
> >> before updating since value changes less often. Patch 1/2 does that.
> >> With patch updates happen only if necessary. CPU Bus traffic reduced a
> >> bit. No significant gains in workload performance.
> > 
> > Could you please post this against the latest scheduler tree, ie. tip:sched/core?
> > 
> > Thanks,
> > 
> > 	Ingo
> 
> Hi Ingo. I had mentioned the same in cover letter. Sorry if I didn't 
> mention it in the correct place. 
> 
> *These patches depend on below to be applied first*
> https://lore.kernel.org/all/20240307085725.444486-1-sshegde@linux.ibm.com/
> 
> After that the above patch would apply.

OK, I missed that, but I don't really like patch #3 of that other series, 
so we'll need to address that first.

Thanks,

	Ingo

