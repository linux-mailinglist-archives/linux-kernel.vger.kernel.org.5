Return-Path: <linux-kernel+bounces-93163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5593872BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7BA1F26732
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55575D50F;
	Wed,  6 Mar 2024 00:24:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99134C8F;
	Wed,  6 Mar 2024 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684669; cv=none; b=madoYIjwM5Ns513n9u9exq4B5qF2SupC0Rv6p1oD/5EbRNCzOR0vSn478OwvN8GOiZeMnrdpXgZBb5JhTP7b/rGgwmLOpZKylWX5/yubzV5RldDZVxtMKg3SrmTJCxmuf2PQKT5hU4CojOGFTEXzE58HkRRG4JQwTyouDrkhkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684669; c=relaxed/simple;
	bh=oYvNC2/mFtZnu/1sU9+I8+QsRe1+61Q3hKfBaUiqz8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dLQwHCAixodNvy5E0k4tJP0pDH6VZcjXo7D5cdtFixvdQWNh23miyGrpsQEZYjqouvTIRMlJPAhwb7C23jrqo7N5tosyLKIs+bToLhBo48fIm/HYuKWZgsIH6n4rDL0hwuqk9zkiUzmQdtmmSrqWnPuC0NEL573RqEUnBV3GnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B29EC433F1;
	Wed,  6 Mar 2024 00:24:29 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 3DF9F1060B14; Wed,  6 Mar 2024 01:24:26 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20240303-class_cleanup-power-v2-1-e248b7128519@marliere.net>
References: <20240303-class_cleanup-power-v2-1-e248b7128519@marliere.net>
Subject: Re: [PATCH v2] power: supply: move power_supply_attr_groups
 definition back to sysfs
Message-Id: <170968466622.645753.4432514364980212313.b4-ty@collabora.com>
Date: Wed, 06 Mar 2024 01:24:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 03 Mar 2024 13:30:50 -0300, Ricardo B. Marliere wrote:
> As reported by the kernel test robot, 'power_supply_attr_group' is defined
> but not used when CONFIG_SYSFS is not set. Sebastian suggested that the
> correct fix implemented by this patch, instead of my attempt in commit
> ea4367c40c79 ("power: supply: core: move power_supply_attr_group into #ifdef
> block"), is to define power_supply_attr_groups in power_supply_sysfs.c and
> expose it in the power_supply.h header. For the case where CONFIG_SYSFS=n,
> define it as NULL.
> 
> [...]

Applied, thanks!

[1/1] power: supply: move power_supply_attr_groups definition back to sysfs
      commit: f107e6b82392a4d64507e219c57235d3fe09e9d7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


