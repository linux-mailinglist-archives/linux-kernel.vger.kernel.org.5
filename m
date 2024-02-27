Return-Path: <linux-kernel+bounces-82943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B641C868C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E031C223B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405B4136648;
	Tue, 27 Feb 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HymjBdRT"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440015D0;
	Tue, 27 Feb 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025553; cv=none; b=o44W7lp/LmM7FvJXCS94jUGyKCohMHeHMNvSIE+jRbpJqYvfkBN08rv6j7AmKfVmuCxpXJ3axKTcN6hYzekkYgLS/d1d3lvmB8/Lhnj1k+0dZOrvm/ILjPK2rudBKSHe/Uqe7W+dbgItj7aOni5mz9lxf0UsWIKFrZ+gvTZCZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025553; c=relaxed/simple;
	bh=2rvKWBsOe5u09Fm07C6Vhkn/eWWGe34DDiMGSkmn9Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkqXJEMXDXxpAAkz1uCzwFYyP1Y3jLPjvP0v4rJRnjo6xBda17SSq5Q0mu7mH+UuK+kPCAPrvswebUT2WIkm38ew2TAx2Ad4p/LnYSh1xQQMGRj7D1BZDoEtqCfPDtEdNqzhWmgQt+cQX7IujWJgGONodLn//dnywKWK2plgZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HymjBdRT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412ae376419so2028265e9.3;
        Tue, 27 Feb 2024 01:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709025550; x=1709630350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4OJtlxBTGwU2hkLw+f6HomonbgUEkZ6XExKyA+CTZ+E=;
        b=HymjBdRT4p/Q+XTvR4eH6i/WJ1eFgCzXTuPUoYH0jibxhRNjblhSP8MTTf3eJq/m7W
         Mt2LK1ZdkwElaVsMlbwvTHUd0ZC0o8jIVgtybMn2hhnRCQjfyYqBtMlZr7Xwq9vuSNti
         YfhlNmWWxnhX7uXGAqyG84ga7euBgjw+DGckFFkXBE3zZ9P2G0oz0JHPT8/NsYH2PcMn
         UpcWXn55PR3fAv/Hfz+nCUPipjuZZ3ZPaJoVFEYwbqut/tqs3uG475iN05Ji3kidhcSS
         jV6B3WVaQ/xc4XmzbVetQ4ejgQsZV88FHOlu6syz11H222jpGKRUty4YnuaP6Pfez4Wp
         xthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025550; x=1709630350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OJtlxBTGwU2hkLw+f6HomonbgUEkZ6XExKyA+CTZ+E=;
        b=BHj7JFB8LG+UaDqwnfPlYGZbDF3R8B1jzmr3kDFWw2jS7ADqsCx+M0Hn/e5XaLU8Nl
         xggs3FLwhAegTZJ0qSwxwuwH+A53rljUXsQ38nZe+kKbXJDe7xubDzXQwBg/IT1k/COz
         T1wbRnVTGoNJUqd19SjqZ+eXki6+2MZDZyhM2VqjMgaNAgpNGOlsmfjmmgivAbWXj2Xe
         +GAwwV+5I7rU5QQb/J97dWTmckxh8rckXpngP80Nul/SU0Z2LQ3bjmRwQOmQn+IKKv0T
         m3fJ3Dzdeyg8AelcXiG4gVUpHR7jdrdLfK9gi8C4KsGnK25qBiJtP/HELSsCCXMeiaAg
         GXjg==
X-Forwarded-Encrypted: i=1; AJvYcCWeJVvyl7JrM1QXQM7SBenM/ge0gUDPh/GNaIRdUdObZoOl0ggVLgnOHJO94bJoEw0FfKJLcMJC6zAMkobo5Zm3izQqPvVBuGyKfStBkUfFdP0=
X-Gm-Message-State: AOJu0YwXbvDrRdOJQFHQG2H94+SSmt57r26mcNsyHBehe7watc/9Boux
	iTZmeVLDVIbYpNitXzOnWC6GrDGfA2QnPuhUaHAip29Pd0ph6EP3
X-Google-Smtp-Source: AGHT+IHo04C8KEdcciAWhLv4DtImgXgPjfgRBYtchRH2qs/BWZhaTvu8jXxY7kHGbTjic1XqsbVm+g==
X-Received: by 2002:a05:600c:3acf:b0:411:c329:6515 with SMTP id d15-20020a05600c3acf00b00411c3296515mr6086729wms.24.1709025549984;
        Tue, 27 Feb 2024 01:19:09 -0800 (PST)
Received: from gmail.com (1F2EF054.nat.pool.telekom.hu. [31.46.240.84])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c225400b00410df4bf22esm14502533wmm.38.2024.02.27.01.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 01:19:09 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 27 Feb 2024 10:19:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [tip: x86/apic] smp: Provide 'setup_max_cpus' definition on UP
 too
Message-ID: <Zd2pCxSm0FKJ8DZn@gmail.com>
References: <170894808668.398.2149303099223176501.tip-bot2@tip-bot2>
 <20240226150234.GCZdyoCtNj8lFwViAW@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226150234.GCZdyoCtNj8lFwViAW@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Feb 26, 2024 at 11:48:06AM -0000, tip-bot2 for Ingo Molnar wrote:
> > The following commit has been merged into the x86/apic branch of tip:
> > 
> > Commit-ID:     429bb0269058e2e1f4ab69a0d33d374933aa15b9
> > Gitweb:        https://git.kernel.org/tip/429bb0269058e2e1f4ab69a0d33d374933aa15b9
> > Author:        Ingo Molnar <mingo@kernel.org>
> > AuthorDate:    Mon, 26 Feb 2024 12:07:31 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Mon, 26 Feb 2024 12:13:40 +01:00
> > 
> > smp: Provide 'setup_max_cpus' definition on UP too
> > 
> > This was already defined locally by init/main.c, but let's make
> > it generic, as arch/x86/kernel/cpu/topology.c is going to make
> > use of it to have more uniform code.
> > 
> > [ Keep it a C variable, not a define, because there's
> >   some namespace overlap for the 'setup_max_cpus' token
> >   in existing function argument names. ]
> > 
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > --
> > ---
> >  include/linux/smp.h | 2 ++
> >  init/main.c         | 1 -
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> That one needs some work:
> 
> $ grep setup_max_cpus 13-37-17-randconfig-x86_64-2517.log
> ...
> ./include/linux/smp.h:221:27: warning: ‘setup_max_cpus’ defined but not used [-Wunused-const-variable=]
> $ grep setup_max_cpus 13-37-17-randconfig-x86_64-2517.log  | wc -l
> 122
> 
> very noisy.

Yeah, a bit sad.

So I resolved this all with using #define and (first) fixing a namespace 
collision that broke with the #define:

  4c8a49854130 smp: Avoid 'setup_max_cpus' namespace collision/shadowing
  3c2f8859ae1c smp: Provide 'setup_max_cpus' definition on UP too
  6be4ec29685c x86/apic: Build the x86 topology enumeration functions on UP APIC builds too

Thanks,

	Ingo

