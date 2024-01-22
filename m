Return-Path: <linux-kernel+bounces-33178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAA58365A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF76C1C21F42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962283D55D;
	Mon, 22 Jan 2024 14:41:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5153B29D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934507; cv=none; b=RFS5isOM+udqy/3oj1wZDwgjVcEA92hQiV0neuBBxwerCSLeTrkpTIYh2JPcNGfB6Qu/SUE3NATL4jq3tLiB1K5MNkmg4/dl0/fJJKJeqeb6+OHSB7J4rRuwbnl5fqbCc3JmOW3soVd9c2U6K+CRG4HWdZhQXIbi/OeOQrRyn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934507; c=relaxed/simple;
	bh=a+Jr8sct729IwtOf1oYnSa9+nJJaMVHabN7466qKUE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0h9Pdd2enU5WTj5M+HBAoWQX0xAlgGHGpzTxT+63W2mMbIkG3HRVDF8nSieFo/EAtlV4AGh1344aJ/Ub21HlHusk/vxjSpjIfrVCGdayO0a+kU/uX6PTD03kX5NPIK4glDltqEj/F/uwv2Hp5qTBfBb+yrYUPx9wH86fys2KQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 154451FB;
	Mon, 22 Jan 2024 06:42:30 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E6AF3F73F;
	Mon, 22 Jan 2024 06:41:43 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Misc FFA fixes around init.
Date: Mon, 22 Jan 2024 14:41:36 +0000
Message-ID: <170592209547.3494416.2430482386764406977.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
References: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 08 Jan 2024 12:34:10 +0000, Cristian Marussi wrote:
> A smalls set of fixes arounds FFA initialization routines.
>

Applied to sudeep.holla/linux (for-next/ffa/fixes), thanks!

[1/6] firmware: arm_ffa: Add missing rwlock_init()
      https://git.kernel.org/sudeep.holla/c/59b2e242b131
[2/6] firmware: arm_ffa: Add missing host rwlock_init()
      https://git.kernel.org/sudeep.holla/c/5ff30ade16cd
[3/6] firmware: arm_ffa: Check xa_load() return value
      https://git.kernel.org/sudeep.holla/c/c00d9738fd5f
[4/6] firmware: arm_ffa: Simplify ffa_partitions_cleanup()
      https://git.kernel.org/sudeep.holla/c/ad9d9a107a43
[5/6] firmware: arm_ffa: Use xa_insert() and check for result
      https://git.kernel.org/sudeep.holla/c/ace760d9c049
[6/6] firmware: arm_ffa: Handle partitions setup failures
      https://git.kernel.org/sudeep.holla/c/0c565d16b800

--
Regards,
Sudeep


