Return-Path: <linux-kernel+bounces-32514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ED0835C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0591C2090E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0EA20DF1;
	Mon, 22 Jan 2024 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5QNG5R3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB24C87;
	Mon, 22 Jan 2024 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912049; cv=none; b=eNRW26hS7GISWjshB1xigynfbpvZmCP42eLwWAO++wlyGlQd1YA6Uqr45c6qmTT5UOtsp+0UhDPAqFisjuXaUycrzzsoL+Q5Zw88Z4aPRYWRBxY0thZMDk/+trp0KWrKfefML4fEC4a0ddo7M4WxiOz7r6Mz996T2htGLnePusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912049; c=relaxed/simple;
	bh=lBFgz2wmn8cEi5y1vg4jI0P+TneucWVXyyuYbQ64/20=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D7la6jvN10hEjAzs44jJIu3ehs6J7hO6DCjQEkLje/F2Su/iFvfkNE+vlDGwclMhSU7qX+icPmYSmtybW4QrFGbkerkew1N0+IofeoFmFG6VlsZBJAbDOp/nE39L09M8Gfl3Jj4d7UJX9JQfKXw4PF6xPJphEP1RMNpxm45cvA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5QNG5R3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3D0C43390;
	Mon, 22 Jan 2024 08:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705912048;
	bh=lBFgz2wmn8cEi5y1vg4jI0P+TneucWVXyyuYbQ64/20=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=b5QNG5R3IbaJpXLZoJV8kUkdPiznstDxQhuBa9X5bSxsPZ3jw3aQbJXQVtKbg/kUa
	 tlvOKQpBeM5vHcmEguCY0hv6mdrwa76rVna3PifOlu7SiqsPp4TfZOd590djQpupyE
	 zXWz1MfXpCeSH34EHFjqSHRYNPjH85qcJyGyPaqAEAZM8GDwyCLfqSrpKEjxSdbmyp
	 8geRVmqIB8oZBVAXC9tjzXPUusgAtYUTB4FG2RVci1epuCCa2BR68KHhXkMmgpGAvQ
	 rVYGYXGiG0j+kbttKgyREhoGTNPqbfOIuFmy0S8gYAf7LsyS6ZqGkRoMln5+b19EH1
	 IVKmckkQkA1oQ==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240117160639.1327266-1-krzysztof.kozlowski@linaro.org>
References: <20240117160639.1327266-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] soundwire: stream: add missing const to Documentation
Message-Id: <170591204572.231468.12374563970048661834.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 13:57:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 17 Jan 2024 17:06:39 +0100, Krzysztof Kozlowski wrote:
> Commit 21f4c443731f ("soundwire: stream: constify sdw_port_config when
> adding devices") added const to sdw_port_config argument, but forgot
> documentation.
> 
> 

Applied, thanks!

[1/1] soundwire: stream: add missing const to Documentation
      commit: 0707496ff4e416ea08c90053fd5fde5811b11b22

Best regards,
-- 
~Vinod



