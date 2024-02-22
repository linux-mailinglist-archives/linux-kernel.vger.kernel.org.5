Return-Path: <linux-kernel+bounces-77255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC848602A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1D11C23304
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8959548F2;
	Thu, 22 Feb 2024 19:26:30 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6B14B815;
	Thu, 22 Feb 2024 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629990; cv=none; b=mwx1QU8HZYhibRi3AxfSCAHfbL9cLIar2M0lrf6OKf/XaWzZrvbW24bffL58USXY+VcUBEI+fdQ75Yv/wTBOrPZnaxXcE5NE47Cr1DkUB0pmCiEBxGhz52SFOwegSNEigywS22C9ilx1tuUAkkiSPykP8Ion5XqO1Bg32l0O0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629990; c=relaxed/simple;
	bh=5nGriczmZj2kIVVHsvlAX+Bf/FvI3il2JhqgUUCJoOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdSfx8Mb1ZAoxSfKGy4UwCfb3UmYhoquemOr2vCqvPgpvr2rMVOUqYNj9VgHsGnmUJA30REj67uF9fW5U/QgDLX5uZuU2VzaInHHQnqcXfBxbVCDHIvSchtSDtsUFT8IUaTuVIVc/AuWs425mFDbM+eDn5y5M8fcqdoZZCeT2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a03c5f8b2eso25783eaf.0;
        Thu, 22 Feb 2024 11:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629988; x=1709234788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtuBWALuMCKrRG+zlFuBRAVfOELJtSXnc6CkMeHVjWw=;
        b=ZHEIOw/MJzlPLcVr+YrMLURZHITMk+KhE1O+xbnnmKrElrZLS49RbPaQY2pMGELhss
         AK+OWMuMAh0y34YVaIfW0hk0X68v4jRtsgugyRKe1C4OBchPN8Z8RKQx55GeuPGOV2j+
         jjrUWP/RH3eXNc/P82zLh6xLSYov5nsWYIgWUTGaVDhrBLpxM56NbtCy2Jp/DytM74UA
         ovKly2hAwz19ySlBI/55Eeu/oaDki5h12vpsR5niCV/CWBhHm2Jt0XEmAVG9OGDuElMD
         XNQh4gsr2xcLxuaHjAGdYA1zB6TGYWGKZycZpeSXSsFjHfvELXVki1Fg+gGDdWCDRegH
         EbFg==
X-Forwarded-Encrypted: i=1; AJvYcCV8yhLWqNkI2nmvg2C9CRxNiaGPAGk8pDBnPR8YBRbH+Rdvo31KfLk3mj0WPqFhrFV3PkFtm6/cXOIJ+CnEdHob3XmxoxwMrF8=
X-Gm-Message-State: AOJu0Ywc1P8/RvutViz2uF5r+NVFgjvcpU5Srp1e0K7mFf6zhMAU9sKn
	Rw8v/BvgrzkzGtkTau1hxTKvWww93asjAckkCGIP+nX6m9JqMBJLcNxiWfKwq3IhCruhEoS7yNN
	MsiNSfcVv5M658FUSzMu+38ceSLQ=
X-Google-Smtp-Source: AGHT+IHr1zKwo/yRBl3RGgoeFsYfe7XwkhKFNKAp6YQOMfDOHC5BhV1AMr69hafezDF8k+jEOKb6+AgyLj/SPmkh/Xs=
X-Received: by 2002:a4a:e89a:0:b0:5a0:168b:d91 with SMTP id
 g26-20020a4ae89a000000b005a0168b0d91mr5103254ooe.1.1708629988119; Thu, 22 Feb
 2024 11:26:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221142550.1814055-1-lukasz.luba@arm.com>
In-Reply-To: <20240221142550.1814055-1-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 20:26:17 +0100
Message-ID: <CAJZ5v0h-HmTTGY2N2BK6paga8yaqv8u6rLosH5oqrRHPMt3Xkg@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: Fix nr_states warnings in static checks
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:25=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> During the static checks nr_states has been mentioned by the kernel test
> robot. Fix the warning in those 2 places.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 7101fa3fa0c0..b686ac0345bd 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -280,6 +280,7 @@ static int em_compute_costs(struct device *dev, struc=
t em_perf_state *table,
>   * em_dev_compute_costs() - Calculate cost values for new runtime EM tab=
le
>   * @dev                : Device for which the EM table is to be updated
>   * @table      : The new EM table that is going to get the costs calcula=
ted
> + * @nr_states  : Number of performance states
>   *
>   * Calculate the em_perf_state::cost values for new runtime EM table. Th=
e
>   * values are used for EAS during task placement. It also calculates and=
 sets
> @@ -728,7 +729,6 @@ static void em_check_capacity_update(void)
>                 struct cpufreq_policy *policy;
>                 unsigned long em_max_perf;
>                 struct device *dev;
> -               int nr_states;
>
>                 if (cpumask_test_cpu(cpu, cpu_done_mask))
>                         continue;
> @@ -749,7 +749,6 @@ static void em_check_capacity_update(void)
>                 cpumask_or(cpu_done_mask, cpu_done_mask,
>                            em_span_cpus(pd));
>
> -               nr_states =3D pd->nr_perf_states;
>                 cpu_capacity =3D arch_scale_cpu_capacity(cpu);
>
>                 rcu_read_lock();
> --

Applied, thanks!

