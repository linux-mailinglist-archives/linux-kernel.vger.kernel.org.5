Return-Path: <linux-kernel+bounces-98671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804F5877DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364F91F224A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE002261F;
	Mon, 11 Mar 2024 10:10:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B206717999
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151817; cv=none; b=dEcmI5UErZA6tX8kKB8Rdo8YG175cQs0pZDI21HJIqvyCvMlWl8KxTHKituxq/rj8NpX6ye7MN11cjYs4a5/GFMzi5bLOtH9qrjUMc85zcmkVh/9+jVmfhbd39hkRseCPo9BJ5eHFeCnGqQLCdq95XZmChR36nD58h8f35ARWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151817; c=relaxed/simple;
	bh=j/Q3D+bb49oeEChrSCYm8mrClv6LerFcux+DJPNhBE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWkVqy8B85H9rNYLU2RTKvLsBVjRcSAE32WEMkjk1kRMbbvHkCYo0trjBzKqb1iXl+2/JhEDs0aQ2hiieEyvHXwbDaYi8FMInG4AstLs25GWGxQdRnUgbPfJNehxFJgNqB996GTj/5u+XY5aBle3HvG9+NwHIpubFew95360zIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C18E6FEC;
	Mon, 11 Mar 2024 03:10:51 -0700 (PDT)
Received: from bogus (unknown [10.57.94.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 277473F762;
	Mon, 11 Mar 2024 03:10:12 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:10:11 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] firmware: arm_scmi: Fix wrong fastchannel
 initialization
Message-ID: <20240311101011.7sawsw2oiz7reaer@bogus>
References: <20240311090413.1710725-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311090413.1710725-1-pierre.gondois@arm.com>

On Mon, Mar 11, 2024 at 10:04:12AM +0100, Pierre Gondois wrote:
> Fastchannels are initialized with a bad index in:
> commit 2441caa84aac ("firmware: arm_scmi: Populate fast channel rate_limit")
> Fix this and provide a correct index.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>

Nice catch!

> Closes: https://lore.kernel.org/r/202403100744.7Op3PI8L-lkp@intel.com/
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

