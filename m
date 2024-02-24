Return-Path: <linux-kernel+bounces-79437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D34862240
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71913B241BC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247410A2C;
	Sat, 24 Feb 2024 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epJrPS6A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5CDF5A;
	Sat, 24 Feb 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708740810; cv=none; b=eSV7tUmEDNuuzSm53mxa6y4jDasPt0tErsYtO5NBQpp8i5VLbPYrdMlPthXqXS8kW8fQdt0Xb9v5XhyHKjc6O/L5taSdW41+C0dtDwCOD9RtPfZfoG8wWwD+pYb5oTYao6+jYKxRWcKCfJ57QvLNcQWx59xZAZBPyjSm6CRiaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708740810; c=relaxed/simple;
	bh=X67Qts2eYsMFcbAMnSp7VaC/EkqgWhHXXWuQo770d2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hc5svJW3tDtAP8urmLa8+m/MT7fEI3fIf433Z1tqseaZ5rXKClyhIVI4i2J/Bwf6J8fLowE6weQekGm2gFG30BNyAYLqoH3fv3ZpkametgeMPQEPCUYBat6ewvXFFJCdfp/DjIEdz/UaVeSg7briFXRpy0/foUBKxCuGn3hwAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epJrPS6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F410C43390;
	Sat, 24 Feb 2024 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708740809;
	bh=X67Qts2eYsMFcbAMnSp7VaC/EkqgWhHXXWuQo770d2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=epJrPS6A1G6bhoIZjuzU/0ubkgBn07/pCB5RR8HXzDWXrG/xEvxUHYmcLXGfU/imQ
	 yb07Bd8uXulcrwxp7aNSgzcQBG2+We+oKXCANEBeFVFkVqYjdpLyM0y/nq+pFM67JD
	 3OpCquGADVgzVl8p3bXdxUsaosy4lW9/nrjXL7O8eSTqAiicRNdQxXUNlerxC0Jf7E
	 nDkXxiI8s3ubv+oXywnwEH98e3D7axWyqtVtfK68a1PZxFqQIPN0NNOIV1rpoi2Ajj
	 ELilxBNyOKFe3CJmdbuUIMKtjwQlj0xJ88g3CkehpyNkX8OTjdFIoKF8yargSJNXSW
	 2MsK+9AK959lQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d23114b19dso19496791fa.3;
        Fri, 23 Feb 2024 18:13:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgAstgcztgI5+scEVFLyCwOQTudLIgKPDglQub1CEs6Z+D7jjpml/VA4NlXYEQ4uUlWNYh+UWuXF3eqCG7au+83Op16aLG+r141mUEAhX0Stc0DMJZ8htpVCVh6WnPDVE1E6XuVj8KdW/UrOgoR+UaGLu3efXsInIvZqxc9eXGMA==
X-Gm-Message-State: AOJu0Yx3Q+O1pADBglGqEwGk/IgHBjnt2NirdI2NlqrNqGarMlfh16PQ
	IjOEdXI0BHGj2BiOsO8zQmtcInZnwE6j61vYFAcSinLJ4yyXFEnMHeHwzyxrfDAyEwOTh069wPj
	cdX7KjMCqB4VbO7NaDHEmf99VGK8=
X-Google-Smtp-Source: AGHT+IHbx3gA6OyO539gNo1sNSfaF1AyeEak6jD3EkmuCjjvLRhSzK5c5KY4qJTW9EiP3SWDHxOeEPsGqtLi/aA7Mzk=
X-Received: by 2002:a2e:a227:0:b0:2d2:63bc:952 with SMTP id
 i7-20020a2ea227000000b002d263bc0952mr450013ljm.35.1708740807610; Fri, 23 Feb
 2024 18:13:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123005700.9302-1-dan@danm.net> <20240220230658.11069-1-dan@danm.net>
 <7efac6e0-32df-457e-9d21-4945c69328f8@leemhuis.info>
In-Reply-To: <7efac6e0-32df-457e-9d21-4945c69328f8@leemhuis.info>
From: Song Liu <song@kernel.org>
Date: Fri, 23 Feb 2024 18:13:16 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5QYTjBvjAjf8SdcKmPGO20e5-p57n6af5FaXudSiOCmg@mail.gmail.com>
Message-ID: <CAPhsuW5QYTjBvjAjf8SdcKmPGO20e5-p57n6af5FaXudSiOCmg@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: gregkh@linuxfoundation.org, junxiao.bi@oracle.com, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	stable@vger.kernel.org, Dan Moulding <dan@danm.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 23, 2024 at 12:07=E2=80=AFAM Linux regression tracking (Thorste=
n
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 21.02.24 00:06, Dan Moulding wrote:
> > Just a friendly reminder that this regression still exists on the
> > mainline. It has been reverted in 6.7 stable. But I upgraded a
> > development system to 6.8-rc5 today and immediately hit this issue
> > again. Then I saw that it hasn't yet been reverted in Linus' tree.
>
> Song Liu, what's the status here? I aware that you fixed with quite a
> few regressions recently, but it seems like resolving this one is
> stalled. Or were you able to reproduce the issue or make some progress
> and I just missed it?

Sorry for the delay with this issue. I have been occupied with some
other stuff this week.

I haven't got luck to reproduce this issue. I will spend more time looking
into it next week.

>
> And if not, what's the way forward here wrt to the release of 6.8?
> Revert the culprit and try again later? Or is that not an option for one
> reason or another?

If we don't make progress with it in the next week, we will do the revert,
same as we did with stable kernels.

>
> Or do we assume that this is not a real issue? That it's caused by some
> oddity (bit-flip in the metadata or something like that?) only to be
> found in Dan's setup?

I don't think this is because of oddities. Hopefully we can get more
information about this soon.

Thanks,
Song

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>

