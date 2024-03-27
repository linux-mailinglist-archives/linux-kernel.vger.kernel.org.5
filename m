Return-Path: <linux-kernel+bounces-121491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A8988E8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3025306B80
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2360131193;
	Wed, 27 Mar 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5nwcoT1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CFD12A157;
	Wed, 27 Mar 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552873; cv=none; b=fMsFstV/0kTL5esus9/QHIwajpW+SsrL9H9xnwaF04yPlF3buyl3IrsILUNE/0Sgcj6ysRtavhfGX7jo/9ZMKyZjnREBkN8fXd5FWS6wNK8CelcFxHTAdy6pDHFxbi2Q5R6w5gZ9X04Eq7WL72eKF9cQ0SipiYT8mUCY5c2iYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552873; c=relaxed/simple;
	bh=+BBgCBKAcE2KgM8BGSw6ott7/P3FQP78mzVrz2NJbf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCFQ1g9y6K46yJ1KO5b3/saedj68QYtKHYg0WyXEP7ONgK9m5TmjQT7IKCP56oPcldS0b3oQXP+cEHuFIeS7pbe1C+cOXGzFBf76aZsuV7TV3c9b6+j5M3ytdWJ4SJugFs7w8SVefJb1uU8RWz2uV+0sZsKWJsPlIo5ciUo5T7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5nwcoT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D75C433F1;
	Wed, 27 Mar 2024 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711552872;
	bh=+BBgCBKAcE2KgM8BGSw6ott7/P3FQP78mzVrz2NJbf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J5nwcoT1YanR4O5GM2S8VVguk+BEhGu4BBK8HEyRpuXi82S1d9IdQtgHngs+ZHy7V
	 Hd2tbJFXYLVXK4/axEuCwqwrjO1+syZw2H0iPkuztR9IMMWr4e/xwbVXvakhlqlW1I
	 Ox2qCa0qcfPlKv6dWYSnzC17K6CvNZguCXhsmM14TqxLM00U7ww23t2nQmoQ9dvE12
	 +od0lxKDuf7tVjEZRKdpk73X3JJMF+pD2g3ZKfcnatSCVk2gGgPwnX286uV6kDcBxS
	 wEbTGTNuNRwPpcVJP9aeQ+BKZxCW61YLk5uaPdTDSc4SaECSdEWrEkbqUHF2yF/Wjv
	 9ugccWFAqmUtw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a47a3786dbso2047211eaf.0;
        Wed, 27 Mar 2024 08:21:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxQrQaQCUIMcbN2HChetuVetYGButGY9RwUgzOeIMZ6V59hgRogbwdnEdnsEikx/4LCUbcJ+GUsvQO1+noY/lGfHRnta0sAIicM2+rWwVpYZ/Zv0eo4nCs5nEv/vVnKEVIVBw0d6c=
X-Gm-Message-State: AOJu0Yw4SOtGJFk/yE6jlCNK4BzdH9a4LyRoYeisEN3pS9LjgzjCr6Bq
	ksY6QuGO7Sszx1RSx9994l5KRtJL3ZaD0OtI01YaTQ+p5ywvVq6y3hwusNgUEtGWcA6vPNq934X
	nYPuVEJ/cXF5a0cfJIAz468E00NQ=
X-Google-Smtp-Source: AGHT+IHAV8gu9ogawpJfevwkO10TLVfwFoptoS2oOFVfjVBj5oRzlz9TZVUDtn8iD/tLLmsphZrnyMh3hv6Vs1KK6As=
X-Received: by 2002:a05:6870:a453:b0:22a:5205:6993 with SMTP id
 n19-20020a056870a45300b0022a52056993mr7893457oal.5.1711552871766; Wed, 27 Mar
 2024 08:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319080153.3263-1-xuewen.yan@unisoc.com> <20240320032056.2noz6lu3k2utcpid@vireshk-i7>
In-Reply-To: <20240320032056.2noz6lu3k2utcpid@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Mar 2024 16:21:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hy=Ak1JynF2fuQ74GNRAQt-mWqnrM+tsJvoU2jgY3FoQ@mail.gmail.com>
Message-ID: <CAJZ5v0hy=Ak1JynF2fuQ74GNRAQt-mWqnrM+tsJvoU2jgY3FoQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Use a smaller freq for the policy->max when verify
To: Viresh Kumar <viresh.kumar@linaro.org>, Xuewen Yan <xuewen.yan@unisoc.com>
Cc: ke.wang@unisoc.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuewen.yan94@gmail.com, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 4:21=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 19-03-24, 16:01, Xuewen Yan wrote:
> > When driver use the cpufreq_frequency_table_verify() as the
> > cpufreq_driver->verify's callback. It may cause the policy->max
> > bigger than the freq_qos's max freq.
> >
> > Just as follow:
> >
> > unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_available_=
frequencies
> > 614400 768000 988000 1228800 1469000 1586000 1690000 1833000 2002000 20=
93000
> >
> > unisoc:/sys/devices/system/cpu/cpufreq/policy0 # echo 1900000 > scaling=
_max_freq
> > unisoc:/sys/devices/system/cpu/cpufreq/policy0 # echo 1900000 > scaling=
_min_freq
> > unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_max_freq
> > 2002000
> > unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_min_freq
> > 2002000
> >
> > When user set the qos_min and qos_max as the same value, and the value
> > is not in the freq-table, the above scenario will occur.
> >
> > This is because in cpufreq_frequency_table_verify() func, when it can n=
ot
> > find the freq in table, it will change the policy->max to be a bigger f=
req,
> > as above, because there is no 1.9G in the freq-table, the policy->max w=
ould
> > be set to 2.002G. As a result, the cpufreq_policy->max is bigger than t=
he
> > user's qos_max. This is unreasonable.
> >
> > So use a smaller freq when can not find the freq in fre-table, to preve=
nt
>
>                                                       freq-table
>
> > the policy->max exceed the qos's max freq.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  drivers/cpufreq/freq_table.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.10 material, thanks!

