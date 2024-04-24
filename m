Return-Path: <linux-kernel+bounces-156967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37098B0AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20425B26392
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A848615CD7C;
	Wed, 24 Apr 2024 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="o1c7H11N"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4715EFDB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965511; cv=none; b=LfwsWCtJNxqkuuUtTyTfLTEFVqOkR5iikkJvncMVq5g2XqIzsbO5H1WxJajroowEEgYVTYGBoJeqjnvWKV+sSRv9YiupVi0eAD11eMF7N56cp9tu4Y0hF4+BQwvloFWunome7Cbwc2tJv5GF6SmEKcRrklAMxpkJk6o/norFkQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965511; c=relaxed/simple;
	bh=Ko741lJ/ldYXv4i0oGqQdI/UMYYb5nwDUjoO+M/FcWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ogk/5/mXxh5MOvCV+Y0w4eTA/ETBPCTy2YMrYEaBTzUN73QG/co7d+kBwEYol0rlIL74O/l6NIykIwzuxPxy4DzG/Xudec7xQJn1KVila0+L9CwD+R9R9lBAxMZw+ShDYVwK96kbgdO+rhTZH3rNNYT06Bpwf5B5VuxznrwFE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=o1c7H11N; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58872c07d8so183037066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713965508; x=1714570308; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c4Hl4NLqdGzUXg705Rji8mLCpex1Aip+oeFMwQ83Pz0=;
        b=o1c7H11NGeEvYwcYHuneWmjy8k77qZsHZk77W0ZRWm0neowxACgqwu94VyF+EoyIgE
         cNJxHNjQdmwfzCAuXcCh4CFh8A1CDmIy5XVyZhVYEk1SH4GeBS3rnOSjE4rqsqUpWTMb
         Vk3msQ34kkvW7LewttXcz47Ro9hvIppbLyB4T/9g8ZC7jymPTwb5IkORZtx+eMmz060f
         881zl2+kmC/12hZtKE4RVIvCzzA8oq1neu9HwAbOqghNtg4gxkVcDHNHqQGbznmy2C7q
         dmC+eX63tUvIDTeCxjupJ+/LG6YCjpkCyspX/FBBQd4J8L1caZRpZgJ2nqqzSOgABQ4W
         pzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713965508; x=1714570308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4Hl4NLqdGzUXg705Rji8mLCpex1Aip+oeFMwQ83Pz0=;
        b=tE+zRqfr5DBwY2GXGLjWnJ6epCCTpqrc1wcDOxKH2BphFdmHnWWbJqpPCTHu1lCmzJ
         sR1hFtIZyrrwhYGpQs4Mj9I4BLNo3S4357FKp+V7bjr8Y27cFigYgS4h5LgZ8HYAak8F
         awlrdlLPUUVcPG0QCFtYn7K4jGf3s4uN1+nh0+TZ3+OG4IFEFyKqb5kZMEazkZWDna1M
         xG7u3K8Kt9XFK2DtZTLTT4OHKk8f4ZgY54uNLwjX2fgUiSyOSaYjQwRZrwx/b4fdc4/r
         W7USiCA6JdTtJzBWrv5MElMhMvoCkuc0w74tFmqI3tt9ffvhn4zIyCV/Xo9OG00fgbTK
         z5jg==
X-Forwarded-Encrypted: i=1; AJvYcCXxvWyEuuEzD93Y+SLpNsMj3U0pHxlHj6ZGbj81YMihH+M8u6FSPbKU3peNt3BXLwYc+qL5yLu7Mj6puUeWzEGajcxb8bhzs4Hr8Bdf
X-Gm-Message-State: AOJu0YxSyMkZ0/NOJWJEeeJPGtxVMK21RqaigCD3XmeyTGfHwvbVn9FY
	snmaBTni3j6pcUaW+uB7l7zCmGYwy4q/iwAAU5HUNniqUQEnu99MWjJ6eEI+4KA=
X-Google-Smtp-Source: AGHT+IHJr3FYf/AKBS+rmpvAdd9+nzsoRwO0qpaGPs8V42zr8lIg6pDSo29AqeA/dSfcoTYiSYnHzQ==
X-Received: by 2002:a17:906:a2cf:b0:a55:75f7:42fb with SMTP id by15-20020a170906a2cf00b00a5575f742fbmr6308275ejb.24.1713965507864;
        Wed, 24 Apr 2024 06:31:47 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id gw5-20020a170906f14500b00a523be56940sm8351416ejb.136.2024.04.24.06.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:31:47 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:31:46 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Ian Rogers <irogers@google.com>, Anup Patel <anup@brainfault.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] perf: RISC-V: Check standard event availability
Message-ID: <20240424-7b4434122a8c1cf1c1173403@orel>
References: <20240103165438.633054-1-samuel.holland@sifive.com>
 <CAOnJCUJ4rC+Rrs6GV4t+=NWA=LtTZix5Nk1VzgP9CK-3+5-jAg@mail.gmail.com>
 <06e71142-e113-40ac-b2c2-b20893aa714f@sifive.com>
 <a4c4c9f2-9fe1-4c22-a99c-1667481ddd6b@rivosinc.com>
 <CAAhSdy1yoCMtR52X7tS6dB2x_ysgA8K4hSSXH044bbq2uFY7jQ@mail.gmail.com>
 <CAP-5=fX5JRYxZ26buLujSVP7roQTaWofqdiX1y1rAKQ70Yu+QQ@mail.gmail.com>
 <CAHBxVyGuxQLTnBUiK2w=9atqNXs0sWC9KcWjssgzhNnbp_Z-mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHBxVyGuxQLTnBUiK2w=9atqNXs0sWC9KcWjssgzhNnbp_Z-mg@mail.gmail.com>

On Tue, Apr 23, 2024 at 05:36:43PM -0700, Atish Kumar Patra wrote:
> On Mon, Apr 22, 2024 at 8:44 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Apr 15, 2024 at 9:07 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Tue, Apr 16, 2024 at 5:31 AM Atish Patra <atishp@rivosinc.com> wrote:
> > > >
> > > > On 4/10/24 18:40, Samuel Holland wrote:
> > > > > Hi Atish,
> > > > >
> > > > > On 2024-03-18 2:44 PM, Atish Patra wrote:
> > > > >> On Wed, Jan 3, 2024 at 8:54 AM Samuel Holland <samuel.holland@sifive.com> wrote:
> > > > >>>
> > > > >>> The RISC-V SBI PMU specification defines several standard hardware and
> > > > >>> cache events. Currently, all of these events appear in the `perf list`
> > > > >>> output, even if they are not actually implemented. Add logic to check
> > > > >>> which events are supported by the hardware (i.e. can be mapped to some
> > > > >>> counter), so only usable events are reported to userspace.
> > > > >>>
> > > > >>
> > > > >> Thanks for the patch.
> > > > >> This adds tons of SBI calls at every boot for a use case which is at
> > > > >> best confusing for a subset of users who actually wants to run perf.
> > > > >
> > > > > I should have been clearer in the patch description. This is not just a cosmetic
> > > > > change; because perf sees these as valid events, it tries to use them in
> > > > > commands like `perf stat`. When the error from SBI_EXT_PMU_COUNTER_CFG_MATCH
> > > > > causes the ->add() callback to fail, this prevents any other events from being
> > > > > scheduled on that same CPU (search can_add_hw in kernel/events/core.c). That is
> > > > > why the dTLB/iTLB miss counts are missing in the "before" example below.
> > > > >
> > > >
> > > > Thanks for explaining the problem. I can reproduce it in qemu as well if
> > > > enough number of invalid events given on the command line and the
> > > > workload is short enough.
> > > >
> > > > >> This probing can be done at runtime by invoking the
> > > > >> pmu_sbi_check_event from pmu_sbi_event_map.
> > > > >> We can update the event map after that so that it doesn't need to
> > > > >> invoke pmu_sbi_check_event next time.
> > > > >
> > > > > I tried to implement this suggestion, but it did not work. The SBI interface
> > > > > does not distinguish between "none of the counters can monitor the specified
> > > > > event [because the event is unsupported]" and "none of the counters can monitor
> > > > > the specified event [because the counters are busy]". It is not sufficient for
> > > > > the kernel to verify that at least one counter is available before performing
> > > > > the check, because certain events may only be usable on a subset of counters
> > > > > (per riscv,event-to-mhpmcounters), and the kernel does not know that mapping.
> > > > >
> > > >
> > > > Yeah. My suggestion was to fix the perf list issue which is different
> > > > than the issue reported now.
> > > >
> > > > > As a result, checking for event support is only reliable when none of the
> > > > > counters are in use. So the check can be asynchronous/deferred to later in the
> > > > > boot process, but I believe it still needs to be performed for all events before
> > > > > userspace starts using the counters.
> > > > >
> > > >
> > > > We should defer it a work queue for sure. We can also look at improving
> > > > SBI PMU extension to support bulk matching behavior as well.
> > > >
> > > > However, I think a better solution would be to just rely on the json
> > > > file mappings instead of making SBI calls. We are going to have the
> > > > event encoding and mappings in the json in the future.
> > >
> > > The problem with JSON based event encoding is how to deal in-case
> > > we are running inside Guest/VM because Host could be anything.
> > >
> > > IMO, the JSON based approach is not suitable for SBI PMU. For now,
> > > we either defer the work using the work queue or keep the approach
> > > of this patch as-is.
> > >
> > > The good part about SBI PMU extension is that we do have a standard
> > > set of events and we only need a way to discover supported standard
> > > events with a minimum number of SBI calls. It is better to add a new
> > > SBI PMU call to assist supported event discovery which will also
> > > help us virtualize it.
> > >
> > > Regards,
> > > Anup
> >
> > +Ian Rogers
> >
> > `perf list` will already filter some events depending on whether the
> > PMU supports them, for example, legacy cache events. I think we can
> > extend this to json events.
> >
> 
> Yes. That's what I was thinking as well. However, that may be a
> problem in virtualization
> as Anup pointed out.
> 
> As per my understanding, cloud providers provide json files for VMs
> based on the host
> architecture and allow migration only between hosts with the same
> family of cpu. In RISC-V, the mapfile.csv works based on 3 registers
> indicating marchid, mimpid, and mvendorid. Thus, the json file has to
> be tied with the host machine it is going to be run.

This is also my understanding. That is, that cloud instances typically
dedicate CPUs to VMs and don't try to present CPU models to VMs which
don't exactly match the host's CPUs. The remaining concern would be if
the hypervisor doesn't emulate/passthrough everything the json describes
for the host CPU type.

However, this is just "typical" clouds. All bets are off for general
virtualization, as Anup points out.

> 
> We will end up doing the same if we only rely on the json file to
> filter events in the future. Please let me know if the assumption is
> incorrect.
> 
> If we allow a SBI call route to discover which events are supported,
> the guest can always support legacy events on any host even though it
> doesn't have a json file.

Yes, I think we need a solution which works even without a json file,
since a VM may use a special mvendorid,marchid,mimpid triplet to
describe a more generic CPU type. Unless we also create json files
for these VCPUs, or provide other event discovery mechanisms, then
the VMs will not have anything.

Thanks,
drew

