Return-Path: <linux-kernel+bounces-98985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACB8781E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E941F22F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2673405DB;
	Mon, 11 Mar 2024 14:45:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D501F3FBBE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168344; cv=none; b=IqFKehIqIKm9eT5jYiQm9QmRoVwIS6c/tS8YPMFxxZcfcpr6lfzYVdRQbl9fK4jvU03Nwe754OmVk1YvPCGx8VtL7nh/0rGglG2nDY5l/JxpzcmsIFblCQgp73hpFUnbzTSJHy0KLw97nK/c+Cee8VpfepeKJ71StFlVt3Jb+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168344; c=relaxed/simple;
	bh=uBHpfN0h7l6eHJcAx47Tmb4VjlizbTZis5M8Scs5vb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKd2E+VcQS3xpdvI/VJgcPn1SeP5iBzEL1ho8N1s1CwCebVrB7TkrXgcDV9HM3naXp+vSsY5c0XpFQ4EkSAUtRE4YdsFk6J75Fyoc422V58z8PHfo6IHKYma0J3Bu1WU7j/lrXS4BAHDaq+uwwYCP+uWTSInxLRHsCPBTxR26yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D5D7FEC;
	Mon, 11 Mar 2024 07:46:17 -0700 (PDT)
Received: from bogus (unknown [10.57.94.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AB193F762;
	Mon, 11 Mar 2024 07:45:39 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:45:36 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Marc Bonnici <marc.bonnici@arm.com>,
	Olivier Deprez <Olivier.Deprez@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v2] firmware: arm_ffa: fix ffa_notification_info_get()
Message-ID: <20240311144536.za6xn2paafvegts6@bogus>
References: <20240311110700.2367142-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311110700.2367142-1-jens.wiklander@linaro.org>

On Mon, Mar 11, 2024 at 12:07:00PM +0100, Jens Wiklander wrote:
> FFA_NOTIFICATION_INFO_GET retrieves information about pending
> notifications. Notifications can be either global or per VCPU. Global
> notifications are reported with the partition ID only in the list of
> endpoints with pending notifications.  ffa_notification_info_get()
> incorrectly expect no ID at all for global notifications. Fix this by
> checking for 1 ID instead of 0.
>

LGTM, will queue it at -rc1 as fix.

--
Regards,
Sudeep

