Return-Path: <linux-kernel+bounces-76035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A654E85F234
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B911F22545
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6D717BB6;
	Thu, 22 Feb 2024 07:55:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10962175A4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588540; cv=none; b=s45iSzY+xay+K0UQjGCpqOXR6bwvA6/5IBzWtz939E6vQFb+tOJjZa69uHEdz5xSzBlpx43qUWX2ueNP3rJ9RSHm8z+TJKb950FhCKGLkhqsyGI3Hn6vtxe0f3ClMRpd9oCNuCPeFcVy6jD2rs08o68hop1sevG6/ITFcjBfU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588540; c=relaxed/simple;
	bh=lMbdJxeE4htmicD64gX9lZf2QwzY1B/WdLlZ0T8Fqxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HD/WUeKz7ICbCmV+MaWM50HQO5r/Rp4kKQ1otrKTpGA62rZQ7bUoE1e9j3oITEO0LT832Txl3aJTxlmLmCxB4jDLB8ar6meqn3+dK0Ot5h2/NbEMYUsImJAJDcxfv84m3psoZix7L/TOMI3YRBY4DPgUdXh7UdBHIuQ/Q4qBqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00FCC1007;
	Wed, 21 Feb 2024 23:56:16 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 003C33F762;
	Wed, 21 Feb 2024 23:55:36 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Add multiple protocols registration support
Date: Thu, 22 Feb 2024 07:55:33 +0000
Message-ID: <170858849685.106442.17247883098371557562.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20231221151129.325749-1-cristian.marussi@arm.com>
References: <20231221151129.325749-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Dec 2023 15:11:29 +0000, Cristian Marussi wrote:
> Add the capability for one SCMI driver to register with the core SCMI stack
> to use multiple SCMI protocols: in such a case the SCMI driver probe
> function will end up being called once for each registered protocol which
> have been also found as implemented on the platform.
>
> This is especially useful in testing scenarios.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: Add multiple protocols registration support
      https://git.kernel.org/sudeep.holla/c/2858f6e5f064
--
Regards,
Sudeep


