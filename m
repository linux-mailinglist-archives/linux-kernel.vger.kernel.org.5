Return-Path: <linux-kernel+bounces-56345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A832984C8FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29ABB2847F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FC517BB5;
	Wed,  7 Feb 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUgE4MMp"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC31758E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303079; cv=none; b=r4D8nhBfVhoufGm2bjJbzpgT4HpGlzL7lu1m5p5rq7WPPUbvfhTXEjql4zuMxaOQWyWUXZA4uBA2yuIShKk11l8zdIWlpT7LzYrCWTJwPOs9gfy8GhDYDtqNo7IAkY3p5VxB6jMu4+zJvNXI9PqGyb0+QHCySCCZO05ZDkSNTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303079; c=relaxed/simple;
	bh=B1XlVHojLLasAfoIWAsxe6ObOEeItQD1Hm73mZXbzls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7884kKiXUuqFLUKypT7jzSxN5VJcUdDFuc7p+zH0EEzINT7MuZWiZQdETRkw0C1Yzlo/O2uqjaev88A9GnZTCI62u8qmEVjIJxwRx1lRZxMRpJpWoA/6SGttf01NJmg55aRZ4qncmfEQgmHp2Vk3w9g5sIOSkZuKinIFvbeNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OUgE4MMp; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ffdf06e009so4855087b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707303077; x=1707907877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsgl1js8sdc7s9A+KRDmi3P2Sf5UWIXz1ucHF4fn3yo=;
        b=OUgE4MMpdifYgsFHfDR9t4lqRRvMBKMKqgii9KQnv39yj11jn6K7EWoof67C1Kqul7
         GiDjd01OyRUwJOeF2GYQE14OvFRNgJe/mmnIMIlcMFvHT3i3oQU/8zQDCnYhIRbMefpU
         R2qWYU/ii1U+npKL37OjhA4txWm29QYcrYM5kbPoBmd4kyXPByPVK1Y4KWFPL57AjoGc
         gy11JusqJeImju2O3DLRWYUKcNlgCMF04i+BlKprKCytRAHB3cdhXXOhvjzDL2YrkQO7
         mmmyDKvaZ9jOEzrSf+DAOqvWWggfq3CyRi87RBiNkWMIEVWUQ8qlF1RhfoGirfEJw3ju
         pd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707303077; x=1707907877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsgl1js8sdc7s9A+KRDmi3P2Sf5UWIXz1ucHF4fn3yo=;
        b=pPSGa/raqSX7VdlYocbvsxzj+z6c7sHeIqvl6hihVh9H+EqYF8bDrX4lCK7HHyc+zA
         Tl8lVBJOWR7LYZDRLDoz03hbgCf0cm2QML3hT3NSeMQXln6WJPR0wHfFkAZNTN8Cwoc4
         sNWV/ZzsbitZ0ukBA53Nv6Jm6jIvJzwDN8EnzAdXOh8C+k9Ck/B5P62rWakiRXKEl0AJ
         Q4WX4/GmI2Am1DBwA5Yjd23oP/GQUbMUNk8fAFMimzosFibGUb/tpuHaM6qSubufkakd
         njFGJFyP7NuYW9+7klj1OV3r+0aGv3BkZORwx3teUBeqvTqbHGxNpyLTik721X00cwca
         IEOA==
X-Gm-Message-State: AOJu0YyZXZ8aeoslkJFKA6qAXi1OPTp1ZOe4ZxY/2x693QI1aGh74DQP
	GHabqkKZDPdvCtCL2mvRBayUkXIDGc7BlEwGz4kTF2b/EJzIh/h66VSFtFfLMB1fy3ekyDTFTRd
	tyXGMLa1eFkJ6f/AuDocxIi2sjmqSJzSyCNMByqhxtoB5QrmSYpE=
X-Google-Smtp-Source: AGHT+IHf4kWxGCgC7QO0GQY35mQOn1MkRO0ngJpqcZ5PyTIrE9gtDbtBPUNd1xmk5zPB94GYf6h2CoHwXv8UHIe13NU=
X-Received: by 2002:a81:99c8:0:b0:602:b697:dc60 with SMTP id
 q191-20020a8199c8000000b00602b697dc60mr3517588ywg.50.1707303076901; Wed, 07
 Feb 2024 02:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202105854.26446-1-quic_aiquny@quicinc.com>
In-Reply-To: <20240202105854.26446-1-quic_aiquny@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2024 11:51:30 +0100
Message-ID: <CACRpkdZM96tji2OCXHPd9iXE1kU5u1TGsuPhB0YLbHG=LXAiqg@mail.gmail.com>
Subject: Re: [PATCH v4] pinctrl: Add lock to ensure the state atomization
To: Maria Yu <quic_aiquny@quicinc.com>
Cc: andersson@kernel.org, kernel@quicinc.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:59=E2=80=AFAM Maria Yu <quic_aiquny@quicinc.com> =
wrote:

> Currently pinctrl_select_state is an export symbol and don't have
> effective re-entrance protect design. During async probing of devices
> it's possible to end up in pinctrl_select_state() from multiple
> contexts simultaneously, so make it thread safe.
> More over, when the real racy happened, the system frequently have
> printk message like:
>   "not freeing pin xx (xxx) as part of deactivating group xxx - it is
> already used for some other setting".
> Finally the system crashed after the flood log.
> Add per pinctrl lock to ensure the old state and new state transition
> atomization.
> Also move dev error print message outside the region with interrupts
> disabled.
> Use scoped guard to simplify the lock protection needed code.
>
> Fixes: 4198a9b57106 ("pinctrl: avoid reload of p state in list iteration"=
)
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>

Thank you for rebasing!

Patch applied now, so we get some shakeout in linux-next and can
make sure it works for everyone.

Yours,
Linus Walleij

