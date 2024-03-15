Return-Path: <linux-kernel+bounces-104573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF687D02C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BDF1F238CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA5E405FD;
	Fri, 15 Mar 2024 15:24:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056B405FF;
	Fri, 15 Mar 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516281; cv=none; b=NK3n9LiAd8lXor5LKRxwRMEx8xrPulZ4keUswZCuH8o+p7XfRccHbYVrb9UIdMR/gpFunMcedd0WftRS0tcfFe6kMD4kNaoNdwNhSbgSOucy75uf5QS6aVdy64mDHKp1kDzgzruLCqKYBOKtsnhCuIQTY/35tR8JgHTkMlizmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516281; c=relaxed/simple;
	bh=tvtPqHTyHAvq5sNabGjdAHpevyZoKTYNDRZhl/bZKTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0hDFsYnFV++GN7OjEAHtZH160x8GoDLbdcl0EPfOO4PAheh1T1JkGzBDsm/8LL+L1Pc4zQgWcDxnC4UJqAl9Nlo4t3Ye5rdFG1Hl5lUN4J5FedkqUXHHdoBbA8hAKCXFl0zHjCYArYsbbLG4mY9Z/4nOkk24Ph+HhdUgfJr5t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B10B3C15;
	Fri, 15 Mar 2024 08:25:12 -0700 (PDT)
Received: from bogus (unknown [10.57.81.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EDD23F73F;
	Fri, 15 Mar 2024 08:24:34 -0700 (PDT)
Date: Fri, 15 Mar 2024 15:24:31 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Maulik Shah <quic_mkshah@quicinc.com>, andersson@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, ulf.hansson@linaro.org,
	swboyd@chromium.org, wingers@google.com, daniel.lezcano@linaro.org,
	rafael@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	jwerner@chromium.org, quic_lsrao@quicinc.com,
	quic_rjendra@quicinc.com, devicetree@vger.kernel.org,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Rob Clark <robdclark@chromium.org>
Subject: Re: [RESEND v4 3/3] arm64: dts: qcom: sc7280: Add power-domains for
 cpuidle states
Message-ID: <20240315152431.sckqhc6ri63blf2g@bogus>
References: <20230703085555.30285-1-quic_mkshah@quicinc.com>
 <20230703085555.30285-4-quic_mkshah@quicinc.com>
 <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>

On Thu, Mar 14, 2024 at 04:20:59PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 3, 2023 at 1:56 AM Maulik Shah <quic_mkshah@quicinc.com> wrote:
> >
> > Add power-domains for cpuidle states to use psci os-initiated idle states.
> >
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 98 +++++++++++++++++++++-------
> >  1 file changed, 73 insertions(+), 25 deletions(-)
> 
> FWIW, I dug up an old sc7280-herobrine board to test some other change
> and found it no longer booted. :( I bisected it and this is the change
> that breaks it. Specifically, I can make mainline boot with:
> 
> git revert --no-edit db5d137e81bc # arm64: dts: qcom: sc7280: Update
> domain-idle-states for cluster sleep
> git revert --no-edit 7925ca85e956 # arm64: dts: qcom: sc7280: Add
> power-domains for cpuidle states
>

IIRC, this could be issue with psci firmware. There were some known
issues which were discussed few years back but I am not aware of the
details and if/how it is applicable here.

Not sure if you are getting any logs during the boot, if you do have
worth look at logs related to PSCI/OSI/Idle/...

-- 
Regards,
Sudeep

