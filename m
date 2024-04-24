Return-Path: <linux-kernel+bounces-157214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6208B0E81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A691C2359C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48B716C686;
	Wed, 24 Apr 2024 15:35:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F86115EFAD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972924; cv=none; b=YGeFBPenmf5zdKjAmEyFWrJOZN/Jes5qbM7iMMSf5Qvlm37oDg8WeSBNz85pXED+ymZbwoEDP6TDRe0ruXKuP1Qm69fkmQ5hRvTgH35kXJTYYiV+JLNZeNGFXVTpd1CacQes9MmeRAVkXFzAsKPEq9MIDtaKAJjs/D1QlgraR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972924; c=relaxed/simple;
	bh=ngvD/T3UbdQQqVaBWDKpDe6NZZKdVnyMO42Bpay+Xbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fv1rIhhB8ddZ/8baejcpjKp24tm36MFu9Nrzf96Qx87YA2l+FfJIm9aoQJJQBaBD9b5owcA0llKUfK0Nk0ceysL6OxukkAAfTqEt90t85lVrS/uPFOPSfa1p97k2pQdcg2TvAZ0NAhSdisD32p1CVH4STqeD3atcxfekJSIsWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18E171516;
	Wed, 24 Apr 2024 08:35:50 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C6C723F73F;
	Wed, 24 Apr 2024 08:35:20 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	mcoquelin.stm32@gmail.com,
	alexander.shishkin@linux.intel.com,
	mike.leach@linaro.org,
	alexandre.torgue@foss.st.com,
	coresight@lists.linaro.org,
	james.clark@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Abaci Robot <abaci@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: stm: Remove duplicate linux/acpi.h header
Date: Wed, 24 Apr 2024 16:35:11 +0100
Message-Id: <171397287372.3469702.475326767939740618.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424023605.90489-1-jiapeng.chong@linux.alibaba.com>
References: <20240424023605.90489-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Apr 2024 10:36:05 +0800, Jiapeng Chong wrote:
> ./drivers/hwtracing/coresight/coresight-stm.c: linux/acpi.h is included more than once.
> 
> 

Applied, thanks!

[1/1] coresight: stm: Remove duplicate linux/acpi.h header
      https://git.kernel.org/coresight/c/002026272ba523d2ae62a13b0a9febb0cdaf576e

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

