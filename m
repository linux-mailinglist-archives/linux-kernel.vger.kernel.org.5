Return-Path: <linux-kernel+bounces-165265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D48B8A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CAF286343
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174B651C30;
	Wed,  1 May 2024 12:46:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1D1DFF0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567593; cv=none; b=sLCgSKQkQkUGI+KfSICpiXyePcveKChkac/PHu+zEMMZx2JWn5QlgrAeYDl2cRt4XO8q/lI8U1E2qhgT+nwUG6pSCBTxnsRR1OdljOatmtHS/hmUxkx/UgzJjt8ZIjmlOJ3sAxVic9+ttwciD9XTGWyJQlRO22w5xuioRRNnYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567593; c=relaxed/simple;
	bh=QmZ3QZYs5IMx0WCZRQ4YWmIReBZ+yiuRUH2JXhHjAPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWuOb/ZCsPuy3QV2fUc9gTWdBL0N8kIAXynJG5CH5Vat0EPSJ2N3jLODhOBcMAfedRBUVFJqI1ECBK3CEDJ0GFXBM21q89u+y353VA1GMuWp2RP+VJrIouPglsPAddNxNgswyS0CLEQkw9b2IGrmWVOPAuqUQBI/RCrV7EXPmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DDA42F4;
	Wed,  1 May 2024 05:46:57 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 450823F73F;
	Wed,  1 May 2024 05:46:30 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] coresight: tmc: Enable SG capability on ACPI based SoC-400 TMC ETR devices
Date: Wed,  1 May 2024 13:46:19 +0100
Message-Id: <171456742630.34457.13492058912953014539.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404072934.940760-1-anshuman.khandual@arm.com>
References: <20240404072934.940760-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 4 Apr 2024 12:59:34 +0530, Anshuman Khandual wrote:
> This detects and enables the scatter gather capability (SG) on ACPI based
> Soc-400 TMC ETR devices via a new property called 'arm-armhc97c-sg-enable'.
> The updated ACPI spec can be found below, which contains this new property.
> 
> https://developer.arm.com/documentation/den0067/latest/
> 
> This preserves current handling for the property 'arm,scatter-gather' both
> on ACPI and DT based platforms i.e the presence of the property is checked
> instead of the value.
> 
> [...]

Applied, thanks!

[1/1] coresight: tmc: Enable SG capability on ACPI based SoC-400 TMC ETR devices
      https://git.kernel.org/coresight/c/8877ef45ef9ec281849870d88039f8dc84cde774

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

