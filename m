Return-Path: <linux-kernel+bounces-76184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B41485F3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A7F1F251F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E410F36B1B;
	Thu, 22 Feb 2024 09:07:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6C02C697
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592855; cv=none; b=MVFQBZEyGw9H+2tsucCk33ZQVso/TTle0gw9/YLnCgrnilOyEseMcVBLSxzXzGVsbukszitoQJI5rZpEYzbGCk04a3tMWA+QL1UH8cCM59YKVo2yKsd4kv9BPYfG5quYL4i8V8U0VqRmB1a5CBH2ytD6ZLmrrY4KvlIpFsaBQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592855; c=relaxed/simple;
	bh=5gufoEXyuTQ0t2SdFGZ+EeRLxUs671wvuIYjn7qp568=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFSEIP73gFI3I6VOhhB1b7NfJptVawD5H4ku85PI2YiIko5XMW5mU+HlI9cmXuNUs/BuQJTEbC8lujf2i+gXJ+Gubw2FmKkPdgyFB9yPyQamTRF6qDDrGITGwHwiGG5AV0i0X3AYZHSjRU9AzmleHMmMPoRyzG7l4fSWUOzWYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6231F1007;
	Thu, 22 Feb 2024 01:08:10 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 218553F766;
	Thu, 22 Feb 2024 01:07:31 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] firmware: struct bus_type cleanup
Date: Thu, 22 Feb 2024 09:07:24 +0000
Message-ID: <170859038392.107308.7406544122897669269.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
References: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 11 Feb 2024 12:51:28 -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]).
> 

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[2/2] firmware: arm_scmi: make scmi_bus_type const
      https://git.kernel.org/sudeep.holla/c/961745b2c42e
--
Regards,
Sudeep


