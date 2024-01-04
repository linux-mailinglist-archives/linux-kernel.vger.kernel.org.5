Return-Path: <linux-kernel+bounces-17144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E78248E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A036D1F22B07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9FC2C19E;
	Thu,  4 Jan 2024 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Jjtcpnc8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E52C198
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50ea226bda8so896366e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1704395837; x=1705000637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PbfUvd1dhZ1Uw6hbfEyeewVXir0Wf2ztu36EzM8ecRY=;
        b=Jjtcpnc8zVRq7DQsVAFfAfqdhYYVMkJPv7mtMIvQ0SvdIhtJ1u6zNpMI9LCjzexo/c
         qeKrxyMVh62h8FGj7nIr+KrXNwtRXsDZWXGGKDMpIz6QWrITbbf0KHjkKgEjoxLwa02R
         dlqSsb8W38tHw4du3RDAdyZTzjvfNeBpsAH19l1Pu91vkKd1dee1VBIsQlhrJCAD9dYa
         S6+bYTKBrlfPTWdOHEf4Nax35VJF9ehLfb9J21nfBCqmHZPLMTM/wB8/kKX4m5rCEg2w
         ypDbup5KUc9Y6zOCnoZVQ5wv95iFVHwwIMzk1ay/cteNlFTo3f2RWZ0HhgYei44jbfKm
         FQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395837; x=1705000637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbfUvd1dhZ1Uw6hbfEyeewVXir0Wf2ztu36EzM8ecRY=;
        b=mMZHgzoJfICEhK760MT+NPyyj6ggFVzdJWiFsm0oK5rqtW0bFwq0/5WWFfBf93ocGy
         IMjNjEau4U50V12z1QFMF3KzcVy+YgA7CC9TK4atsBGQ1CqbhWSUnY9RRjb3Ke8W4SoL
         OJP94N7XyRT1SW3WiLxiMmBs9BSMZ7gbRvjNHfU/AF2Crzc9E9lHDTHVrhrra/RA58mi
         HKZswzR3bJ/QRHrn01+XV4joSrPaqFNt1iMFLxOcRd/zUHMXtI39Mgz+T+izQF1uNII7
         TuUAynOg7PdCJxpfYN1/Q1Scg6vqE7gYnw2+1cdDwGs+pav8Fk36/Fq63YbU6brb8/2R
         7Dbw==
X-Gm-Message-State: AOJu0YwoDb5xsU51pKqaHd1q/LI3GygZqMHvmatMjg2MViYF5/ROIl2G
	RN2TB6BCQTlLhSap1OgnBrnado60eDlJ0A==
X-Google-Smtp-Source: AGHT+IF3AcEgiRQsPiLdOiKjXfw/R5SD54EyvAz0rJ+2zkyONblMNoC5+GwoOWtR8hzHkhYdN+nzYA==
X-Received: by 2002:ac2:4c42:0:b0:50e:74f4:d1e6 with SMTP id o2-20020ac24c42000000b0050e74f4d1e6mr826598lfk.18.1704395836868;
        Thu, 04 Jan 2024 11:17:16 -0800 (PST)
Received: from airbuntu (92.40.216.189.threembb.co.uk. [92.40.216.189])
        by smtp.gmail.com with ESMTPSA id fw22-20020a170907501600b00a26b44ac54dsm12832136ejc.68.2024.01.04.11.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:17:16 -0800 (PST)
Date: Thu, 4 Jan 2024 19:17:13 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sched/topology: Sort asym_cap_list in descending
 order
Message-ID: <20240104191713.6wcohpywqw36a2io@airbuntu>
References: <20231231175218.510721-1-qyousef@layalina.io>
 <20231231175218.510721-3-qyousef@layalina.io>
 <8e2263b7-e33b-43e1-b0df-92b560b8fa25@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e2263b7-e33b-43e1-b0df-92b560b8fa25@arm.com>

On 01/02/24 18:09, Pierre Gondois wrote:
> Hello Qais,
> I just have some comments regarding the commit message/comments,
> otherwise the code (of the 2 patches) looks good to me,

Thanks for taking a look!

> 
> On 12/31/23 18:52, Qais Yousef wrote:
> > So that searches always start from biggest CPU which would help misfit
> > detection logic to be more efficient.
> > 
> > I see the following when adding trace_printks() during add and del
> > operations
> > 
> >              init-1       [000] .....     0.058128: asym_cpu_capacity_update_data: Added new capacity 250. Capacity list order:
> >              init-1       [000] .....     0.058132: asym_cpu_capacity_update_data: -- 250
> >              init-1       [000] .....     0.058135: asym_cpu_capacity_update_data: Added new capacity 620. Capacity list order:
> >              init-1       [000] .....     0.058136: asym_cpu_capacity_update_data: -- 620
> >              init-1       [000] .....     0.058137: asym_cpu_capacity_update_data: -- 250
> >              init-1       [000] .....     0.058139: asym_cpu_capacity_update_data: Added new capacity 1024. Capacity list order:
> >              init-1       [000] .....     0.058140: asym_cpu_capacity_update_data: -- 1024
> >              init-1       [000] .....     0.058141: asym_cpu_capacity_update_data: -- 620
> >              init-1       [000] .....     0.058142: asym_cpu_capacity_update_data: -- 250
> >              init-1       [000] .....     0.058143: asym_cpu_capacity_scan: Final capacity list order:
> >              init-1       [000] .....     0.058145: asym_cpu_capacity_scan: -- 1024
> >              init-1       [000] .....     0.058145: asym_cpu_capacity_scan: -- 620
> >              init-1       [000] .....     0.058146: asym_cpu_capacity_scan: -- 250
> >             <...>-244     [007] .....     1.959174: asym_cpu_capacity_update_data: Added new capacity 160. Capacity list order:
> >             <...>-244     [007] .....     1.959175: asym_cpu_capacity_update_data: -- 1024
> >             <...>-244     [007] .....     1.959176: asym_cpu_capacity_update_data: -- 620
> >             <...>-244     [007] .....     1.959176: asym_cpu_capacity_update_data: -- 250
> >             <...>-244     [007] .....     1.959176: asym_cpu_capacity_update_data: -- 160
> >             <...>-244     [007] .....     1.959183: asym_cpu_capacity_update_data: Added new capacity 498. Capacity list order:
> >             <...>-244     [007] .....     1.959184: asym_cpu_capacity_update_data: -- 1024
> >             <...>-244     [007] .....     1.959184: asym_cpu_capacity_update_data: -- 620
> >             <...>-244     [007] .....     1.959185: asym_cpu_capacity_update_data: -- 498
> >             <...>-244     [007] .....     1.959185: asym_cpu_capacity_update_data: -- 250
> >             <...>-244     [007] .....     1.959186: asym_cpu_capacity_update_data: -- 160
> >             <...>-244     [007] .....     1.959204: asym_cpu_capacity_scan: Deleted capacity 620
> >             <...>-244     [007] .....     1.959208: asym_cpu_capacity_scan: Deleted capacity 250
> >             <...>-244     [007] .....     1.959209: asym_cpu_capacity_scan: Final capacity list order:
> >             <...>-244     [007] .....     1.959209: asym_cpu_capacity_scan: -- 1024
> >             <...>-244     [007] .....     1.959210: asym_cpu_capacity_scan: -- 498
> >             <...>-244     [007] .....     1.959210: asym_cpu_capacity_scan: -- 160
> >           rcuop/7-66      [001] b....     1.968114: free_asym_cap_entry: Freeing capacity 620
> >           rcuop/7-66      [001] b....     1.968118: free_asym_cap_entry: Freeing capacity 250
> 
> IMO the trace is not necessary.

Yeah maybe it's a bit too much. I'll drop it.

> 
> > 
> > Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >   kernel/sched/topology.c | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index ba4a0b18ae25..1505677e4247 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1384,18 +1384,30 @@ static void free_asym_cap_entry(struct rcu_head *head)
> >   static inline void asym_cpu_capacity_update_data(int cpu)
> >   {
> >   	unsigned long capacity = arch_scale_cpu_capacity(cpu);
> > -	struct asym_cap_data *entry = NULL;
> > +	struct asym_cap_data *insert_entry = NULL;
> > +	struct asym_cap_data *entry;
> > +	/*
> > +	 * Search if capacity already exits. If not, track which the entry
> > +	 * where we should insert to keep the list ordered descendingly.
> > +	 */
> 
> IMO just a small comment like the one suggested below should be enough,
> but this is just a suggestion.

It seems you think it's too verbose but I think your suggestion is too terse
too. Since it is divided into two places and I am combining two operations
I thought it'd be useful to explain what's happening to help read the code at
a glance. I'll keep it as it is for now.


Thanks

--
Qais Yousef

