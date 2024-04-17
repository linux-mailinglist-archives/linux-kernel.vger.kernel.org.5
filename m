Return-Path: <linux-kernel+bounces-148457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4704B8A82D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00846281401
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4968613CFAF;
	Wed, 17 Apr 2024 12:09:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D84B13D2B5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355792; cv=none; b=C4svkOnKO3bPAhBK560D/bU9JimagfxbylxPi+L+3jD0jipzXMuThgfAeoiibbY6H0vPpM1lzGetpuEhl7wbXCmWwqF45z0BPrOPVwEqhJJhUb8mFzNFt8dyWPuSFQxH1UgjAKLIbrVZ1/WZ0azER20RPdcEWh1uvtLcf1cLmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355792; c=relaxed/simple;
	bh=VcRQmxkgKJUFowmMrDseywFsMBcTlOSkQBSqdLWOC6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7kGVc240h+k2VACaDZP2B7ZCiXnVsGqaggy5jP5CRdNDXWrXCl/if7dvHFz6gjJk3QhxKsl000sRdFYt+pgIeVxEzFNjdc+LNKsTV9nPI/ArMeO4+qi4NzhZDnceeX9ilsmjL4xQ8GvUwlDt1tM67e/YzcbJGHkjyDbmgtfIXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58C0D339;
	Wed, 17 Apr 2024 05:10:17 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD56F3F738;
	Wed, 17 Apr 2024 05:09:47 -0700 (PDT)
Date: Wed, 17 Apr 2024 13:09:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	konrad.dybcio@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: Add dedicated vendor
 protocols submenu
Message-ID: <20240417120945.jjcpfwknj5urb6bk@bogus>
References: <20240408093052.3801576-1-cristian.marussi@arm.com>
 <20240408093052.3801576-3-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408093052.3801576-3-cristian.marussi@arm.com>

On Mon, Apr 08, 2024 at 10:30:52AM +0100, Cristian Marussi wrote:
> Add a dedicated Kconfig submenu and directory where to collect SCMI vendor
> protocols implementations.
>

This looks fine. But I would wait until the first vendor protocol is
ready to be merged to merge this as baseline. Hope that's OK.

--
Regards,
Sudeep

