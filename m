Return-Path: <linux-kernel+bounces-158211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFD58B1D07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0091F22959
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025B17FBA8;
	Thu, 25 Apr 2024 08:46:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D666EB56
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034814; cv=none; b=Hre30UqOV+6IQ2kRDO1Pq9yTKpigr9LxDp/gy/0rIETcbcFvPSla0W3IT+ztixCK3CmgbKkBczcL2Zw8eEylPWeokjPkMk+2dSmE4ZCC6sOQEInGb6xkFs5FH8gODh6U5lpuYZoAcmubKV7o+CSKDDEN6J05GmUMxlcO+nWQ6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034814; c=relaxed/simple;
	bh=hhrOka8cOheUP3a0Q+QLQNbvwyMXbpo1sO5jFHXBnhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxmoF5p9rNrx63Q5hncekuI+B+k8OLGqvMryaPw7aryO7UM370RJkrliHldHes6Be4qBuZz7q7jjnQBEyZDHllk7IUHRQAPeElrta6udCovmyZKSKfe3uQax/QpM8ZG1BOy+GbEcttK+0qhdkpaYtrjHlK/1ZSz7/4P7qTuByBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB011007;
	Thu, 25 Apr 2024 01:47:20 -0700 (PDT)
Received: from bogus (unknown [10.57.84.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AA733F64C;
	Thu, 25 Apr 2024 01:46:50 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:46:47 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: lkp@intel.com, rafael@kernel.org, mingo@redhat.com,
	Sudeep Holla <sudeep.holla@arm.com>, peterz@infradead.org,
	lukasz.luba@arm.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, qyousef@layalina.io
Subject: Re: [PATCH] arch/topology: Fix variable naming
Message-ID: <20240425084647.ulyz4kzcdkfndhjs@bogus>
References: <20240425073709.379016-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425073709.379016-1-vincent.guittot@linaro.org>

On Thu, Apr 25, 2024 at 09:37:09AM +0200, Vincent Guittot wrote:
> Using hw_pressure for local variable is confusing in regard to the
> per_cpu hw_pressure variable. Rename it to avoid confusion.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

