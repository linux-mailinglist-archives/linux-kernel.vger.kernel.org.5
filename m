Return-Path: <linux-kernel+bounces-132926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A12899C16
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085911F228E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EB616C6A7;
	Fri,  5 Apr 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyLZV4mj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6016190F;
	Fri,  5 Apr 2024 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317958; cv=none; b=kS1kQZ+BBnGsI8c0eZ8ckpkAFvC/rKQVNMs6qqVRDSKjrRVfqVax8YIfzsyraI7cEwJByM7TtgwQwwzCV+xeliaCl/SXXphIv5x1AdBmkgAAlr1ctlKqb6U2R5V/CPKsaL/wgHndlO8F7UXRyOWL6tuo121qW5ngQKZO64DyESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317958; c=relaxed/simple;
	bh=VTdpfj47qPvlRfaYIJ6AnZ627PVI0Cpj1YSwVeG0tVo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rl6gF0aSFJ5MXayObkGbyq8OZIpRzcBSgZihDxH6mfZjb4pSZwF2N7YKe6Vbgj/8wvvpEkbe78qIlBz+KMgR7s3POJJJ6sW65rKnjNztqaJZl0+aVa/ZVVV+v2/8h0ZIyjVnjKjYE9/HtfsvMTwPqgcQC9//ulifsTZ7MIiu8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyLZV4mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C44DC433C7;
	Fri,  5 Apr 2024 11:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712317957;
	bh=VTdpfj47qPvlRfaYIJ6AnZ627PVI0Cpj1YSwVeG0tVo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qyLZV4mjkjjTFNb5k9zPc+yBZnf1e9wMew3X0IXuVEwEuTCYhdjlURBiLXled9h3Q
	 3UGGYQrc7kkQsayQYtNBtRDY6V2I/NHJcntmA3uZ4iz8GNXEAufhUM8Viczxrt1jW2
	 GHjZpz9uQJKqhNbBmzk44BGMaM+/mt720jnVtCcNmp7gMhMfbro3JiNiGM93tJlmM2
	 MTwB5HRGSS6xIL5N1W8hVVu2tX0GIW+ZCm8rcYaCwL7YpQtTCL8r2YjUoEZV08SLlA
	 xEDRreco8TRHZUQwznQNKxWseh9kQOZMTU+DT/X69od9LDEecSTjvU868epmDya63y
	 9bXz19tHky1Bg==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
Subject: Re: (subset) [PATCH 0/7] soundwire: add BTP/BRA prerequisites
Message-Id: <171231795487.278895.10983950624595565432.b4-ty@kernel.org>
Date: Fri, 05 Apr 2024 17:22:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 26 Mar 2024 09:01:15 +0000, Bard Liao wrote:
> Some prerequisites for BTP/BRA.
> 
> Pierre-Louis Bossart (7):
>   soundwire: cadence: fix invalid PDI offset
>   soundwire: cadence: remove PDI offset completely
>   soundwire: remove unused sdw_bus_conf structure
>   soundwire: reconcile dp0_prop and dpn_prop
>   soundwire: clarify maximum allowed address
>   soundwire: debugfs: add interface to read/write commands
>   soundwire: bus: add stream refcount
> 
> [...]

Applied, thanks!

[1/7] soundwire: cadence: fix invalid PDI offset
      commit: 8ee1b439b1540ae543149b15a2a61b9dff937d91
[2/7] soundwire: cadence: remove PDI offset completely
      commit: 1845165fbd6e746c60e8f2e4fc88febd6a195143
[3/7] soundwire: remove unused sdw_bus_conf structure
      commit: 59401c3c08e1a306e29a8d6c826685e2c5c6c794
[5/7] soundwire: clarify maximum allowed address
      commit: bc13cf3f6e63dd708ccd160a28e6bb696af7e9f6

Best regards,
-- 
~Vinod



