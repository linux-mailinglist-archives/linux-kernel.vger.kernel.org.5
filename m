Return-Path: <linux-kernel+bounces-42478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C168401E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7649F1F22983
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8289D55E68;
	Mon, 29 Jan 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/A8iDK+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBAD55765;
	Mon, 29 Jan 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521102; cv=none; b=KukQa8jmbjNYvADqoYvW8mZzbljspgKTm/c5ZDNRetNV30PJHvcH5clF/lMyqf4xsB6zPKF9S/VudPjENZNB2iceTZVwp7E0q1fr2dZxkhlmnRc39NRSVh8KIUGhLjBZpzrcSPMgbrc5ezKGpovkAfavOUXzUQrDRghZIDGNN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521102; c=relaxed/simple;
	bh=rhLbs8RDtFB5pDbCrc/ZKmEFvyOrcNyrTDC+mGeGs/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHugUOY+B6OGJ8ZeZFrkE7jKxUoJfbiRFhAo3NTCHtzcqD1ykfvXPNleZlftGVMgYBSKMQ28EhzaEG4tCtdv8ijmCtDeTUUvd3RrKy/rEiIyplvbR1mTiEhLi95/QY+mkPU8U/7tToG2uxteGW905/XXfa61pXRqSvamQuvKKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/A8iDK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDE6C433F1;
	Mon, 29 Jan 2024 09:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706521102;
	bh=rhLbs8RDtFB5pDbCrc/ZKmEFvyOrcNyrTDC+mGeGs/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/A8iDK+qvEwZQs2jOfXYFIcUpQQ/XZuYln2omvDlDaFiFFOy/yzYlz2KordHXCDh
	 Zj1TdiiWtfD235gQGah2tV+0Sxg/xDBNEy/iwcL2QXprybV7H0nNFQnEsoTiuzlROF
	 KcPcjXd8fQYU8yUZU2zJwQNH/vttSQB9FAJKiDOL9J3tu3q50LAr2OMO68asc/1bPa
	 lfWeBWaxFR3jwv0xWtlLmsf748j/eDZzdBLIHj2NRs6Jy7gl9g4PV6O6t5vCOQEXCl
	 Mqt3sGrOkb6afAVlF8IP6KJmIbIuGhwORf1387FSgHyNklONGfkfykiSoft9uwXN80
	 kWmM9t1DqFqNg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rUO5m-000000006fw-2Kvx;
	Mon, 29 Jan 2024 10:38:15 +0100
Date: Mon, 29 Jan 2024 10:38:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: Introduce additional
 tsens instances
Message-ID: <ZbdyBgbX2Su80eln@hovoldconsulting.com>
References: <20240126-sc8280xp-tsens2_3-v2-1-8504d18828de@quicinc.com>
 <ZbPfeq6ElA3vMf_O@hovoldconsulting.com>
 <20240126165113.GS2936378@hu-bjorande-lv.qualcomm.com>
 <ZbPlRsx3czAHRBew@hovoldconsulting.com>
 <f28604d2-20a8-4662-9412-f09c6bf4a67b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f28604d2-20a8-4662-9412-f09c6bf4a67b@linaro.org>

On Fri, Jan 26, 2024 at 10:23:41PM +0100, Konrad Dybcio wrote:
> On 26.01.2024 18:00, Johan Hovold wrote:
> > On Fri, Jan 26, 2024 at 08:51:13AM -0800, Bjorn Andersson wrote:
> >> On Fri, Jan 26, 2024 at 05:36:10PM +0100, Johan Hovold wrote:
> > 
> >>> Shall you submit a follow-on patch to set the polling delays to zero
> >>> for the other thermal zones (cpu, cluster, mem) so that we don't poll
> >>> for those?
> >>
> >> I optimistically interpreted Konrad's response as a promise by him to do
> >> so ;)
> >>
> >> I do like his patch which remove the poll-properties for non-polling
> >> mode. Would be nice to not first change the values to 0 and then remove
> >> the properties...
> 
> That was my intention as well..
> 
> > 
> > No, that should not be an issue as it allows us to get rid of the
> > polling without waiting for a binding update which may or may not
> > materialise in 6.9-rc1.
> 
> If you really insist, I may do that, but if the thermal guys act on it
> quickly and we negotiate an immutable branch, we can simply but atop it,
> saving the submitter timeof(patchset), the reviewers timeof(verify), the
> build bots timeof(builds) and the applier timeof(pick-build-push)..

Why would introduce such a dependency for really no good reason?

Submit a patch based on the current binding, then when/if your proposed
binding update hits mainline, you can send a *single* patch dropping the
parameters from all qualcomm dtsi.

Updating the binding is a separate and lower priority task. In fact, it
may not even be desirable at all as an omission of adding these
parameters could then lead to broken thermal management on platforms
where the interrupts do not work. Having an explicit poll-delay of zero
at least gives people a reason to think about it when merging a new
platform.

But again, that's a separate discussion. Don't make this patch depend on
that.

> > But whoever updates those properties need to do some proper testing to
> > make sure that those interrupts really work.
> 
> They seem to, check /proc/interrupts before and after adding an e.g. 45degC
> trip point on one of the CPU thermal zones, they fire aplenty.

That's not proper testing. Add/enable debugging in the thermal driver
and make sure that you trigger precisely once when passing the threshold
in both directions.

Johan

