Return-Path: <linux-kernel+bounces-104720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B300F87D2BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3CA1F2611D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012834CB58;
	Fri, 15 Mar 2024 17:26:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307964CB2B;
	Fri, 15 Mar 2024 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523603; cv=none; b=YflbCD5D3GMSEBC7M2mQPJBfg9P73rIZaJFiKGMYlBXNjckfd3c0mhSY7l6o6vVdUVVZTyioX4dym2RTscTNM4m/MgzULmlM5xyCVV0KuqZ1y1UF1bCeSePeLQmKjvBnxb4+B524ADZXbhJAQGdNmQ4cy534/gkqkPAa+ikftho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523603; c=relaxed/simple;
	bh=kppvzE8hmVDe4CqcOZjfH/zMBxgvlpknYDUEUNtJmLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVF+RGib7EdTjItXo3RNZ9QfL3Le6HpddXeAVlmWq7PaapksTx7PeK0EdPSs+/tR5sw4tKwg+NZp9K4edzBXalhy/NYb3rAr+C8W0Sx/Qm8MIr2RVDVd2Id51Qo9huLdt66CLgoV8gTiHK1k7eLNzYTcoah9op5jJoUp3t6Prow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0B4AC15;
	Fri, 15 Mar 2024 10:27:15 -0700 (PDT)
Received: from bogus (unknown [10.57.81.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2A323F762;
	Fri, 15 Mar 2024 10:26:35 -0700 (PDT)
Date: Fri, 15 Mar 2024 17:26:32 +0000
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
Message-ID: <20240315172632.6zxwj4enq4tddbb3@bogus>
References: <20230703085555.30285-1-quic_mkshah@quicinc.com>
 <20230703085555.30285-4-quic_mkshah@quicinc.com>
 <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
 <20240315152431.sckqhc6ri63blf2g@bogus>
 <CAD=FV=UD1nuxryvWH=Mi7E+QzMoa7xCHebY0DtZCAVmEW3ZeAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UD1nuxryvWH=Mi7E+QzMoa7xCHebY0DtZCAVmEW3ZeAg@mail.gmail.com>

On Fri, Mar 15, 2024 at 10:12:12AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Mar 15, 2024 at 8:24 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Mar 14, 2024 at 04:20:59PM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Mon, Jul 3, 2023 at 1:56 AM Maulik Shah <quic_mkshah@quicinc.com> wrote:
> > > >
> > > > Add power-domains for cpuidle states to use psci os-initiated idle states.
> > > >
> > > > Cc: devicetree@vger.kernel.org
> > > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 98 +++++++++++++++++++++-------
> > > >  1 file changed, 73 insertions(+), 25 deletions(-)
> > >
> > > FWIW, I dug up an old sc7280-herobrine board to test some other change
> > > and found it no longer booted. :( I bisected it and this is the change
> > > that breaks it. Specifically, I can make mainline boot with:
> > >
> > > git revert --no-edit db5d137e81bc # arm64: dts: qcom: sc7280: Update
> > > domain-idle-states for cluster sleep
> > > git revert --no-edit 7925ca85e956 # arm64: dts: qcom: sc7280: Add
> > > power-domains for cpuidle states
> > >
> >
> > IIRC, this could be issue with psci firmware. There were some known
> > issues which were discussed few years back but I am not aware of the
> > details and if/how it is applicable here.
> >
> > Not sure if you are getting any logs during the boot, if you do have
> > worth look at logs related to PSCI/OSI/Idle/...
> 
> Given that the new firmware fixes it I'm going to say it's not worth
> looking into any longer.
> 

But it would be good to know if that is the exact reason, see if it can
be upgraded, or else we can disable them by default. The bootloader or
something else can detect the f/w version and enable them so that the
board with old f/w(if can't be upgraded) can still be used.

Otherwise it is a regression IMO.

-- 
Regards,
Sudeep

