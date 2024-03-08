Return-Path: <linux-kernel+bounces-97130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE708765E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C907B25B83
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0555A7BB;
	Fri,  8 Mar 2024 13:59:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E945A79C;
	Fri,  8 Mar 2024 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906374; cv=none; b=ErEsY76lVUPvrbRuov9qDDBkoDVHNF9rcx69Zl5Yimf1HglX0nb/EaPYjd1AyB/tvYtpIHoWDoqiU9XjiVBqYgcFkfiyltLLe/VYMxEGPh7sMYTBEFdYuMIIBvdetj9+ejqI8edngQV6Pqs0rSoQExF+15Hwx/3m1no/BGJ59dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906374; c=relaxed/simple;
	bh=SRfdLg5n8IYvB/LXF9I6PRuHNqVFh+8x4mkOX53oHrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnlgHk0/mcuYVhPdn6z7TLJNU19pVU46koerfCaXgMwUQ5TL9N4kNKTJDdLwRhmfnqC+FrU1LlWCR3Lq3J9D46qDHrO7Rbd9jp06xexSKL7j8scM8VjUksPYTL/9ZLfO6L+m128ddJMYu2MYixhi3Qw6uaWbo7zJywQVSmWzbys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD2D8C15;
	Fri,  8 Mar 2024 06:00:08 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12A203F762;
	Fri,  8 Mar 2024 05:59:29 -0800 (PST)
Date: Fri, 8 Mar 2024 13:59:27 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: <cristian.marussi@arm.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
	<dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
	<sboyd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<quic_mdtipton@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
	<nm@ti.com>
Subject: Re: [PATCH V3 1/2] firmware: arm_scmi: Add support for marking
 certain frequencies as boost
Message-ID: <ZesZv9uFJBKIrQSC@bogus>
References: <20240308104410.385631-1-quic_sibis@quicinc.com>
 <20240308104410.385631-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308104410.385631-2-quic_sibis@quicinc.com>

On Fri, Mar 08, 2024 at 04:14:09PM +0530, Sibi Sankar wrote:
> All opps above the sustained level/frequency are treated as boost, so mark
> them accordingly.
> 
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

