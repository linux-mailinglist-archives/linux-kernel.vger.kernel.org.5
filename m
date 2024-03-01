Return-Path: <linux-kernel+bounces-89098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5793486EA6A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BBF1C253D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2255D3C6A3;
	Fri,  1 Mar 2024 20:37:44 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4343C067;
	Fri,  1 Mar 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325463; cv=none; b=PxsnyEntvO/SS5x41vtY93CNH++PdlWEQYJkQtQoVCc5p5TJpEkvr0VKTfaZZFtbJMSSxLs8oEICxD/K5BS6qw6mGqIZ6hE05B6E+0HQBkAbFdVya4Nvx6VfAqH3Xh75V2oeb3dReJAUVwHJ/Oe44LKkIGzwq+oz9hWefXn1Tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325463; c=relaxed/simple;
	bh=jDk+Rr+D+yrxNBXemNzJit3fk+TeM+fn/xgB37dy9Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=md6owclgUSJDxqHd2HFFJqzAvaezks+lj9IfV/qzJq1eGgal5PVhmcH4V/bXJjgp2ohognkDUO7ICsYAL9berkbqmpsZn7ZVvxNh5YN+8D1GflpwpZp1HSVU4i+Seka+S1EUwNx+p7j2m6jjcMkO1efvnZVwy9Q+4Ggtqe8ZMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a10f19d4a0so35679eaf.0;
        Fri, 01 Mar 2024 12:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325461; x=1709930261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aA81n8gjpnioNNFqryBLhwwan57m+hU0QtyE/pL0sz4=;
        b=gk8a1OE0suE5Yldljp6UM3PlNcgz/17ejrjzNM1Af8EfUGkIaN3trtby/7qWqqrFl7
         sq857NssLt9sPgax3EQuFVduZs1vsge1Wnb0sffj7hOu9vZxHaDnQw+Z1W6jjulUvfjP
         p0bDHNnZTwjl7flJOOVFW4+TqkczIaVpSwIjplDkPamMehLkBjrxjPK/F5dJ/vF+Cil3
         cMCJk7Pu6Jg2p1cUkfSS0A3fsmjf7tEE38bMXTN8dA/eil749B3IWIfXB6fSzRLZj5j9
         7UnalioZIBQFWvdzrAgi+nJ7TsSO/knS0yppMJgMqLSu+o427oQ8IW+QQyfHoXO2TstM
         CYjA==
X-Forwarded-Encrypted: i=1; AJvYcCV2FYsro2a9/ehU2DQgIGe3PkNDsws84ehMkTEsmdarEGKoNIQOp29idtJmmyuVWqHb2DVRJdu3usE9roThaT4AzT3q7ZyAqsnTpjd0
X-Gm-Message-State: AOJu0YzyPgPOot07KHKhBoSxe+CC8OligpKto6+Dw1boLDIor7h0l/JM
	bS5kM8alBmKSPD6MAmen+8kim44zVUFctIccpoD4+t7p617Yw6kiLo5elqmg0RinyMfSSyggbOY
	oRxcVhhqcYwEPhzevGUBFqMpSjFI=
X-Google-Smtp-Source: AGHT+IFlqnj2ZRoupaw1r/5HvSXa4w4tESFY9IgyT5VAxYYLwMgAPyX72tAGxz6v1xyl82sXmux6gvTDEE5oSheHqMU=
X-Received: by 2002:a05:6870:332c:b0:21f:cd7d:9904 with SMTP id
 x44-20020a056870332c00b0021fcd7d9904mr2777170oae.4.1709325461366; Fri, 01 Mar
 2024 12:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1333a397b93e0e15cb7cb358e21a289bc7d71a63.1709193295.git.viresh.kumar@linaro.org>
 <20240301055042.p4jaa4v3tshlbwnb@dhruva>
In-Reply-To: <20240301055042.p4jaa4v3tshlbwnb@dhruva>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 1 Mar 2024 21:37:29 +0100
Message-ID: <CAJZ5v0hHTuEXmQA=0D90eR_KUsOsfcxYbTS=zQYDTXuY6o_K_Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Don't unregister cpufreq cooling on CPU hotplug
To: Dhruva Gole <d-gole@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>, Roman Stratiienko <r.stratiienko@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:50=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi,
>
> On Feb 29, 2024 at 13:42:07 +0530, Viresh Kumar wrote:
> > Offlining a CPU and bringing it back online is a common operation and i=
t
> > happens frequently during system suspend/resume, where the non-boot CPU=
s
> > are hotplugged out during suspend and brought back at resume.
> >
> > The cpufreq core already tries to make this path as fast as possible as
> > the changes are only temporary in nature and full cleanup of resources
> > isn't required in this case. For example the drivers can implement
> > online()/offline() callbacks to avoid a lot of tear down of resources.
> >
> > On similar lines, there is no need to unregister the cpufreq cooling
> > device during suspend / resume, but only while the policy is getting
> > removed.
> >
> > Moreover, unregistering the cpufreq cooling device is resulting in an
> > unwanted outcome, where the system suspend is eventually aborted in the
> > process.  Currently, during system suspend the cpufreq core unregisters
> > the cooling device, which in turn removes a kobject using device_del()
> > and that generates a notification to the userspace via uevent broadcast=
.
> > This causes system suspend to abort in some setups.
> >
> > This was also earlier reported (indirectly) by Roman [1]. Maybe there i=
s
> > another way around to fixing that problem properly, but this change
> > makes sense anyways.
> >
> > Move the registering and unregistering of the cooling device to policy
> > creation and removal times onlyy.
> >
> > Reported-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> > Reported-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > Link: https://patchwork.kernel.org/project/linux-pm/patch/2022071016402=
6.541466-1-r.stratiienko@gmail.com/ [1]
> > Tested-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
>
> Makes sense to me,
>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Applied (for 6.9), added a Closes: tag as suggested by Daniel.

Thanks!

