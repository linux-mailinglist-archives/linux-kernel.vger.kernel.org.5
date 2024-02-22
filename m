Return-Path: <linux-kernel+bounces-76096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D8385F2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF1DB25607
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16451B819;
	Thu, 22 Feb 2024 08:26:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93373199C7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590376; cv=none; b=gJSaOvCnZd54EcGbWrarhZ1PON+NBssRVduBoNFnqvK8Gvl8cKWl4/e/fLCTRNjvhTZHwOvfjKvn52lb6ZcAjKmPIh2ZuNOmIrodu20BZoVfjBFMQWt9b8SJO+DW31Y3lXachMMSmykmksL1/kemro89lgWTi/Q0hb/CuP0yE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590376; c=relaxed/simple;
	bh=/trNUrPLViOZ1GwrgCizgHUzDyfkqJ844sNvvNo2Xhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lbdw7kMJp6qSK7HPIXC/jshF4O8/ySTeyn0Cfzn357c1SYDSLmPVnX9mkfbI5LmFUE3H0icUjMugYuDQzCtr5Zf34fYv81+5Kos9W0diPr5GvLBvGkx9CaDhk+gUDut7bu36TiFE+uuKEQKSNOOZA9RFuBCBFRTUDF5Es/M1TkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18CA71007;
	Thu, 22 Feb 2024 00:26:41 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECB963F762;
	Thu, 22 Feb 2024 00:26:01 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: optee: fix struct kernel-doc warnings
Date: Thu, 22 Feb 2024 08:25:58 +0000
Message-ID: <170859029406.107193.1029353194533836071.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221062157.8694-1-rdunlap@infradead.org>
References: <20240221062157.8694-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 22:21:57 -0800, Randy Dunlap wrote:
> Fix the kernel-doc notation for the nested union in struct
> scmi_optee_channel to eliminate kerenl-doc warnings:
>
> optee.c:130: warning: Excess struct member 'shmem' description in 'scmi_optee_channel'
> optee.c:131: warning: Function parameter or struct member 'req' not described in 'scmi_optee_channel'
>
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: optee: fix struct kernel-doc warnings
      https://git.kernel.org/sudeep.holla/c/a9c049f47e06
--
Regards,
Sudeep


