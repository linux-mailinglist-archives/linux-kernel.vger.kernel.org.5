Return-Path: <linux-kernel+bounces-142575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27AA8A2D52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40F91C22132
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865585491F;
	Fri, 12 Apr 2024 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qraH0DXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0553818;
	Fri, 12 Apr 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921179; cv=none; b=VLca2hBwQ5WCmVrMyNzRuonurYr7cbaJC2/OWm1OdS84uD8eT1ufmiRAhChE2YAEIlb0VzvT2DgzLvrCWYut0JEMXbTcx0RQRkdkFLklsSPmR8EAfTqESl9jgYKgxjU65iMBlMyuHu55bzEago5Ddj38Xdsvai/FoT15Rd3m9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921179; c=relaxed/simple;
	bh=HwD2cmce3NrbLnH+gh+y4+5Qxd5czNVQgs4oY/n2RFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpC/Xir0xnU+DXxp7GuxDC7FcR2q8Di2PlWE99KruwTE9jIzLyxufP5bJOsleqSy3KprDgcGW0c95U70TzGpBPAtQWmWOXnxWH1fJkc0qsucxcG/Y4WlpTvwVY2wM30NTfgAu4Fg6o36UD1+uEAi09XTj4mywCTMhohboXNFN3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qraH0DXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEDFC113CC;
	Fri, 12 Apr 2024 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921179;
	bh=HwD2cmce3NrbLnH+gh+y4+5Qxd5czNVQgs4oY/n2RFo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qraH0DXp447IJJjOEs9hwwAb/UqjD0BNZmFj53CfqwXmO63OYF3xZg/e8i1R2ih7Q
	 Ii5kRRgUEOqCZfnniRaLVsLilFZhgfZvKQn8lnPO9EjUI3YCQf+aYPvHE7oJ2J+QvV
	 QPnR7Kz4jcG3PimTAdMUhE68zekUE3IqouIoRpv6/RZ5BVACzYeXG1/yjIuuJCpOnc
	 FUqdwAl5oFSUXk3NO4QI1YgNNXIK1ttbjpt1It9VJ8hcFczzo06Prq2IgFWN2t1Hy5
	 c3GWG5zAU1YMydLtLxgsyyrQEA4z2JdG/I3YPFhimk1eqOlT9CfZ7mMdow5rUijjdK
	 C5WU0g/DELF+g==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c60bb16e44so241391b6e.0;
        Fri, 12 Apr 2024 04:26:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdnbmxoSy/KvNhVbgSrkxwZ1P2bdYauDVaBxrsHq0W0XsAqsIFIrFCkjcKuSJOBDHuh56vUiXb1wrHtLiEzGiZ+39Ss8VYRwwrSwaGMLznO6ynIG3/8blwUCfDlGmpUIL/MebOjr8=
X-Gm-Message-State: AOJu0YwHu/TjuEf4D93B1dgjTh1q1l8cGMyhyok/zWlzTI4cJRo4pxPL
	hLAvv7IrVF+STy7ru4BuNwPDsgDPDbydaqrV/x2rQPHUQ/U3Yjztj/+87uXFaWa5MwLP5ddls9H
	HBVLDQySRIxKjwQdsITJe4y72CCw=
X-Google-Smtp-Source: AGHT+IGTaIEw+dMcbzhTwLiN44Gbf3UepfXNPytu8Sf/6OPGYJMKVS2NRTPodB0I2O78xDS/3OAl8l0kOQM+D6QLbFM=
X-Received: by 2002:a05:6870:5b9b:b0:22e:161b:7682 with SMTP id
 em27-20020a0568705b9b00b0022e161b7682mr2540091oab.4.1712921178607; Fri, 12
 Apr 2024 04:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411231818.2471-1-sensor1010@163.com>
In-Reply-To: <20240411231818.2471-1-sensor1010@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Apr 2024 13:26:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jZjJJED=Rc+9vAeVd3DdFaXJVQ1rCvN1FtSegCB-Y7jA@mail.gmail.com>
Message-ID: <CAJZ5v0jZjJJED=Rc+9vAeVd3DdFaXJVQ1rCvN1FtSegCB-Y7jA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fixed kernel crash caused by cpufreq issues
To: Lizhe <sensor1010@163.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 1:19=E2=80=AFAM Lizhe <sensor1010@163.com> wrote:
>
> When the cpufreq_driver does not provide an exit() function.
> cpufreq offline operations can result in a kernel crash.
>
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 04d349372de3..e8660bc7d232 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1739,7 +1739,7 @@ static void cpufreq_remove_dev(struct device *dev, =
struct subsys_interface *sif)
>         }
>
>         /* We did light-weight exit earlier, do full tear down now */
> -       if (cpufreq_driver->offline)
> +       if (cpufreq_driver->offline && cpufreq_driver->exit)
>                 cpufreq_driver->exit(policy);
>
>         up_write(&policy->rwsem);
> --

I've applied the patch from Viresh that addresses both issues with
missing ->exit() driver callback checks and therefore is more
complete.

Also I'm not going to apply any other patches you have sent because
there were obvious mistakes in some of them and you sent updates
without version numbering and without any information regarding what
changed with respect to the previous version(s).  Also some patches
were sent in multiple copies (I think) without telling me which one to
look at.  All of that is too confusing to be treated seriously and
quite disrespectful to the prospective reviewers (who might allocate
their time to more productive things).

If you want to send the changes once again, it is fine because they
generally do some nice cleanups, but please follow the patch
submission and kernel development process documentation as Greg has
already advised you.

Thanks!

