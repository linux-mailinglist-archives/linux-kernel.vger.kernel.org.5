Return-Path: <linux-kernel+bounces-66784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5973A85617F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DF628F62F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DD412AACB;
	Thu, 15 Feb 2024 11:26:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8831F53369;
	Thu, 15 Feb 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996398; cv=none; b=jhKPI6PZxsCUSC95ygDUnsNzNmRlE5YOHBO3KsWUHz8Snjxlto9UbDKCP2GBXr49o0C4WhLRyw6pE35OV0dXj5q3HvURu3y+0Sm9Kgf6LAtdtQMEiP1JgvprV7KKzduDjIIZHkVJaTa/f+JaixULYx0Bu3IwPrf9T9vINeJ16ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996398; c=relaxed/simple;
	bh=pBEYU4AJhnNOJ1+oImLXGXidM99AZZHk0MSAwGM42SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZRsaR9VE5JZ0mEbB/mFxYpq+q+f0NPA1ybyQrNbh3bgYDI/tjx6qcvYDiRY/UfmpXPSkbfROO3i+Ynh5DL4MmteOpnUSx3SSe4FQ6py2NfmCIQpOricOUDvGtpXW8spku7GI/9ir4sLV5lRYUNpNdievsfgFu0xEjqtTTxX5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 128ABDA7;
	Thu, 15 Feb 2024 03:27:17 -0800 (PST)
Received: from bogus (unknown [10.163.74.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7821A3F7B4;
	Thu, 15 Feb 2024 03:26:27 -0800 (PST)
Date: Thu, 15 Feb 2024 11:26:26 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Saravana Kannan <saravanak@google.com>, David Dai <davidai@google.com>
Cc: Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: add virtual cpufreq device
Message-ID: <20240215112626.zfkiq2i2imbqcdof@bogus>
References: <20240127004321.1902477-1-davidai@google.com>
 <20240127004321.1902477-2-davidai@google.com>
 <20240131170608.GA1441369-robh@kernel.org>
 <CAGETcx8S0oS67oMZsPKk6_MGAtygoHEf_LN1gbcNDEBqRJ4PPg@mail.gmail.com>
 <20240202155352.GA37864-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202155352.GA37864-robh@kernel.org>

On Fri, Feb 02, 2024 at 09:53:52AM -0600, Rob Herring wrote:
> On Wed, Jan 31, 2024 at 10:23:03AM -0800, Saravana Kannan wrote:
> >
> > We also need the OPP tables to indicate which CPUs are part of the
> > same cluster, etc. Don't want to invent a new "protocol" and just use
> > existing DT bindings.
> 
> Topology binding is for that.
> 
> What about when x86 and other ACPI systems need to do this too? You 
> define a discoverable interface, then it works regardless of firmware. 
> KVM, Virtio, VFIO, etc. are all their own protocols.
>

+1 for the above. I have mentioned the same couple of times but I am told
it can be taken up later which I fail to understand. Once we define DT
bindings, it must be supported for long time which doesn't provide any
motivation to such a discoverable interface which works on any virtual
platforms irrespective of the firmware.

--
Regards,
Sudeep

