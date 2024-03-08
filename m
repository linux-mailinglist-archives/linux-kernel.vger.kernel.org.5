Return-Path: <linux-kernel+bounces-96955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDC987638C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD141C2100B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A035D728;
	Fri,  8 Mar 2024 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciJIhD9m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187515D471
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898285; cv=none; b=NkStQoMwHZDyIWh+8WtiujJEbZ7guRPL3vXp6GwGE8B0e3e3Ufag5fO06Y1SmZfQ7b9EUrNcKN8/vW8s5tztw6HPwGixuPpC0SCKQJ8f9DFHsPFScsNI5bvNZyJsrZjEytm4qENBOUxTK3/BqXrWtvU8eXLQ0xl2CpnnEW4Z9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898285; c=relaxed/simple;
	bh=RRURGp4C9zLE/LmAZUrJtURGA0DnojIeM4tTmOPbNYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgMT/PR2KTFai9uVOTHWQYf+MuyNPklZzNy+l+oPIE1lkTt3AqZKFzkG2MawhReHcOuzM01oOYiRjsGMzE68sA7Qp17H6kvf/u0MjRDkD0ou1rQg851cy5TZ6SNhhsg26R2TS+z5K9qBHeb5GTC7hfvBrWhb5IC7DljeFJY2KcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciJIhD9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A366DC43609
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709898284;
	bh=RRURGp4C9zLE/LmAZUrJtURGA0DnojIeM4tTmOPbNYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ciJIhD9mBzNWZmHVsYvntxdR+Epmfa/2epb1aoiVZcmrOvaGcxSH1PjwRC2c2YXKD
	 yhDTBn6rKzxgQxIPh3oBAkSoNZ8p7O1WkcWAp+mMzl02PPVsp9pBvw3pRbA//xgiCa
	 2NEMCV0aJLKiX7RtieSpSiXn3f1qi4XXVM2bAAj7vyHMNJ1xH6kKHfDxdqr2NHw5Ke
	 u5cj18Rvy0HYxXpoc+bOG8gF93OvYltvQbJpMPhYVX3cd5duSoCgSbSM0Cs9MnmHfE
	 YDmSg6GPm8eFmVqwTzt9Xh3Kh6m54wOIm8eJC1P+52rZBkXSYveT60tl/0j22uinpc
	 ukOPTI19staYg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512ed314881so1875645e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:44:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEaal0GUwu/cORJroZkiOiNd9J+3AaG56Dx5h2H6HFpqp+JQh4H2aE3A4Rx9TRb8hqpr7QhkDlrrXJ7bC0I+841tWrB24SpnwHKY4o
X-Gm-Message-State: AOJu0YzxXxc6l07NbRXm7cP1gOOiVZAOxxXq1TQ9iLONXQAFxE5sqLUZ
	WQjBQXB2oN7D3UYj62136FfCTzZaJnE1O/h9wGidECLEOcIwfoJLpveV5vvO/ce2II4kDsP67ak
	a29pnd5aO/Ye8g6vMPu6eRYIMcrc=
X-Google-Smtp-Source: AGHT+IF8jcNOa8rQIi9ztIpx0ah3aOF+MXNywEK9nqFwaolnpMJBZjRRgqe6sGOS2+Vq/q8w74wRUSyr6VoxnWwp4go=
X-Received: by 2002:a05:6512:39cd:b0:513:27d7:400e with SMTP id
 k13-20020a05651239cd00b0051327d7400emr4624052lfu.29.1709898282755; Fri, 08
 Mar 2024 03:44:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com> <CAMj1kXFsX1HZ3=x1cjN0-7i5EV9LXkSrAW22dc1wERUaTdAMaA@mail.gmail.com>
 <20240308110043.GEZerv21Qj10Q7-8p5@fat_crate.local>
In-Reply-To: <20240308110043.GEZerv21Qj10Q7-8p5@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 8 Mar 2024 12:44:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFe48dUtNkCDG0PcmeGhYfvr5HJ8sucuNGwCJ1XDKw03Q@mail.gmail.com>
Message-ID: <CAMj1kXFe48dUtNkCDG0PcmeGhYfvr5HJ8sucuNGwCJ1XDKw03Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
To: Borislav Petkov <bp@alien8.de>
Cc: Kevin Loughlin <kevinloughlin@google.com>, acdunlap@google.com, 
	alexander.shishkin@linux.intel.com, andrisaar@google.com, bhe@redhat.com, 
	brijesh.singh@amd.com, dave.hansen@linux.intel.com, dionnaglaze@google.com, 
	grobler@google.com, hpa@zytor.com, jacobhxu@google.com, jpoimboe@kernel.org, 
	kai.huang@intel.com, linux-kernel@vger.kernel.org, michael.roth@amd.com, 
	mingo@redhat.com, peterz@infradead.org, pgonda@google.com, 
	ross.lagerwall@citrix.com, sidtelang@google.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, x86@kernel.org, ytcoode@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 12:01, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Mar 08, 2024 at 11:30:50AM +0100, Ard Biesheuvel wrote:
> > Agree with the analysis and the conclusion. However, this will need to
> > be split into generic and x86 specific changes, given that the DMI
> > code is shared between all architectures, and explicitly checking for
> > SEV-SNP support in generic code is not appropriate.
> >
> > So what we will need is:
>
> I was actually thinking of:
>
>         x86_init.resources.probe_roms = snp_probe_roms;
>
> and snp_probe_roms() is an empty stub.
>
> Problem solved without ugly sprinkling of checks everywhere.
>

Indeed. Setting the override could be done in
init_hypervisor_platform(), which is called right before from
setup_arch().

