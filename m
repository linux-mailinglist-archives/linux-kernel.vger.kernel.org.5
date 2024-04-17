Return-Path: <linux-kernel+bounces-148496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B6E8A8384
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5E3285A03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4313CFA6;
	Wed, 17 Apr 2024 12:54:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310223D72
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358447; cv=none; b=smwT+dvyHXVLj71TkTbyAT38HisridM3iyR/nqNYj7Ne+2yZFQjyxUnSNh5PxDkW2ei2WT6Oat1mhqI3p6O8l9zU1kbf1tjpcQnBfpcAONzHn/J7l//W0IcVjoZo6NsFiRt58jsnQ2kTCzGB1GvmY0acRgIsLbyNOeL+kblLjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358447; c=relaxed/simple;
	bh=PSbnTBzkSI/lvkvZJNydmcYbPtxI8Y9zOOsrqxQR7SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ0s4cqfuE2cwFO+leSmv1S1EV/kE03xqphmnjxh2iQbLeJ7Q6RudYu26uUpYzPZbAoEeu4nmC5hK7lnVZZLwsIGe9MUTGxL3GLOHCtAHQmaiOsBLrOUptBkeUPjCGBzZtTPgiPZWr0Da29Cf/8ifsZjvJdArPEihPPtJIUcqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F651339;
	Wed, 17 Apr 2024 05:54:32 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A473F738;
	Wed, 17 Apr 2024 05:54:02 -0700 (PDT)
Date: Wed, 17 Apr 2024 13:54:00 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, peng.fan@oss.nxp.com,
	michal.simek@amd.com, quic_sibis@quicinc.com,
	konrad.dybcio@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: Add dedicated vendor
 protocols submenu
Message-ID: <Zh_GaLMJdf7wv2sp@pluto>
References: <20240408093052.3801576-1-cristian.marussi@arm.com>
 <20240408093052.3801576-3-cristian.marussi@arm.com>
 <20240417120945.jjcpfwknj5urb6bk@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417120945.jjcpfwknj5urb6bk@bogus>

On Wed, Apr 17, 2024 at 01:09:45PM +0100, Sudeep Holla wrote:
> On Mon, Apr 08, 2024 at 10:30:52AM +0100, Cristian Marussi wrote:
> > Add a dedicated Kconfig submenu and directory where to collect SCMI vendor
> > protocols implementations.
> >
> 
> This looks fine. But I would wait until the first vendor protocol is
> ready to be merged to merge this as baseline. Hope that's OK.
> 

Absolutely, I think some vendor protocols currently on the list (beside
their ready-to-merge status) will rebase on this once this is in -next.

What remain to discuss really, it is, as I mentioned offline, if we want
to also group the vendor protocols headers (the one containing the
public protocol ops) somewhere...I think now they are just placed on top
level include/ named like

 /vendor1_scmi_something.h
 /scmi_vendor2_something_else.h

.or (as I now remembered you mentioned offline) just leave as it is for
now and then post a patch on top to shuffle around the headers into some
common include/scmi/ top dir...not sure anyway if it worth...maybe some
header name convention is fine (but I ignore if there are rules about
polluting more or less the top level /include/ dir :D)

I assume also that this mechanism is fine for vendors at this point, since
all the feedback we've got from  them till now was on specific (and very
much welcome) code-reviewed stuff...

Thanks,
Cristian

