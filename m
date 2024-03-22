Return-Path: <linux-kernel+bounces-111604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59239886E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB2F282879
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7847F45;
	Fri, 22 Mar 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIPR+x/7"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC5B44391
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117485; cv=none; b=SumBzTDkhRa5HLlh0RYqamaxd+ecbje4wl35wlMJMU96WuilDP4No+//70JPcA7C0JY7tVSUn+AO9vFHAZ5x8VqG8KQ+S5z+ALvHp/YitsCkiXh79uN2T0m4JjTt2UKLYF0PXE17msLqg+pB9mdB4HYJIc4F7NdWQ8tbPepIDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117485; c=relaxed/simple;
	bh=syPJCbEbMSsgWwjmffvYkDK0wMrVwE03bWzuwKneTX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGyg/JyYu6L5lU5rmd/zQc0qtwmaWf6eFb1+ZGvaQT59qB7nDK1AGU/bMApP+e6r2mdfNmg0n1HoIy/DLHWtu/HXEJg3oEOY/IVJ3xNYK2XcmiMzQldpWK1fK0cu2fXMqo0FuvVmcmfucQfw6zuzCH6IaZCNgIoyJ/Mo+m28jwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MIPR+x/7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46cc947929so308105066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711117482; x=1711722282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpJ4vef/DM0XTXXII9U2wn8MVlRJg1M1abd5hGl+Ct4=;
        b=MIPR+x/7pQgHRphGF1aJrc84H9sFuDvVQ05fVAE1EXBBe7iyAIWKTMNKASH0FKxJAv
         l4Q+uYg1LxlRw6ZpHd7Zg36SPgRw4rOtEYsQp+yRXDRRENGwV+EjKFj2FLsWZ8jjI2Zi
         +kd9ddms/QO8J9y5uWYga2OuuD3rExUQt2/rs9JwtjRZX8UlHEGg7z33nnNIiCuOIAdL
         5LokSIo/SjbR5qeTH8/Qk1g3oGvUtQhB0u3mV+bdRBnO0YeUz1NfMc/OtKIhv6W1XjXm
         scTzmbuAl7hktklsGoRnPZVxSNyvYbKEXSb2OZIxpdz07o3PcLNrV1lhgt4r6BJCT/wR
         PHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711117482; x=1711722282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpJ4vef/DM0XTXXII9U2wn8MVlRJg1M1abd5hGl+Ct4=;
        b=hI8yKCXOBwORb3OfnDvYiukHSISU1uCfw4Xw52PqbMYvHe6CqOBxgiSYzWM2mUDhQm
         Z9BuKAkNvuoK6od33cu4XdJZ3ybAmGy5eMjFxwVtHtU/XDPC6RxSOWE5lTV4Lz5DI3oZ
         ZgUc/TUbm1JCUY6Cd95GrjqoWzrNsHf4Yac1nMmQvBi7YP8pe926WcR5ofW6xMRk//70
         NNlVsp8O3/WbHPk6y5KgTMJqgoKQNj4ql84DMlaQiz1PuCO4ZCCKq0KiBIUe1KjJT7qZ
         NsZHSJWMsSxaJvTH0bL2PT0tyBCoDapROIVHaTMluvb31a0BgOvzOu6xM8OypphJ76B8
         /u4w==
X-Forwarded-Encrypted: i=1; AJvYcCXUGXVXjBb1pdiWUF6QY2XLf0zAbDNfNwPmmyicmbnlEhyV2yLlyBTSjeM48Ang6cSZZY1HYkXyaqrYphV2IivurM0O/9Hsh+ytw3i1
X-Gm-Message-State: AOJu0YySdZ7OYlvEqMezgHEJmpUv90q7xR7qcfCUdJfiKBFBC0RbO3QK
	qJtLfmSJhv/jb5HXVis0Ubz0p3xiNLLkvs/sDN6ES5ysipCRzhsJF6vC12zwIw==
X-Google-Smtp-Source: AGHT+IHV7ZedVCo+7sdEER+uodJailEQLJUTasnzC10mtbi8r3xphXx/fdmPks0AX5p8D0JfI3tpTw==
X-Received: by 2002:a17:907:b9ce:b0:a46:af7d:28d3 with SMTP id xa14-20020a170907b9ce00b00a46af7d28d3mr1785337ejc.11.1711117481409;
        Fri, 22 Mar 2024 07:24:41 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906351000b00a46cddf1efbsm1065100eja.29.2024.03.22.07.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:24:40 -0700 (PDT)
Date: Fri, 22 Mar 2024 14:24:35 +0000
From: Quentin Perret <qperret@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: Add KVM_CAP to control WFx trapping
Message-ID: <Zf2Uo1l0JgBEKRAL@google.com>
References: <20240319164341.1674863-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319164341.1674863-1-coltonlewis@google.com>

On Tuesday 19 Mar 2024 at 16:43:41 (+0000), Colton Lewis wrote:
> Add a KVM_CAP to control WFx (WFI or WFE) trapping based on scheduler
> runqueue depth. This is so they can be passed through if the runqueue
> is shallow or the CPU has support for direct interrupt injection. They
> may be always trapped by setting this value to 0. Technically this
> means traps will be cleared when the runqueue depth is 0, but that
> implies nothing is running anyway so there is no reason to care. The
> default value is 1 to preserve previous behavior before adding this
> option.

I recently discovered that this was enabled by default, but it's not
obvious to me everyone will want this enabled, so I'm in favour of
figuring out a way to turn it off (in fact we might want to make this
feature opt in as the status quo used to be to always trap).

There are a few potential issues I see with having this enabled:

 - a lone vcpu thread on a CPU will completely screw up the host
   scheduler's load tracking metrics if the vCPU actually spends a
   significant amount of time in WFI (the PELT signal will no longer
   be a good proxy for "how much CPU time does this task need");

 - the scheduler's decision will impact massively the behaviour of the
   vcpu task itself. Co-scheduling a task with a vcpu task (or not) will
   impact massively the perceived behaviour of the vcpu task in a way
   that is entirely unpredictable to the scheduler;

 - while the above problems might be OK for some users, I don't think
   this will always be true, e.g. when running on big.LITTLE systems the
   above sounds nightmare-ish;

 - the guest spending long periods of time in WFI prevents the host from
   being able to enter deeper idle states, which will impact power very
   negatively;

And probably a whole bunch of other things.

> Think about his option as a threshold. The instruction will be trapped
> if the runqueue depth is higher than the threshold.

So talking about the exact interface, I'm not sure exposing this to
userspace is really appropriate. The current rq depth is next to
impossible for userspace to control well.

My gut feeling tells me we might want to gate all of this on
PREEMPT_FULL instead, since PREEMPT_FULL is pretty much a way to say
"I'm willing to give up scheduler tracking accuracy to gain throughput
when I've got a task running alone on a CPU". Thoughts?

Thanks,
Quentin

