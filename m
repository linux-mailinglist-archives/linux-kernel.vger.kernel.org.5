Return-Path: <linux-kernel+bounces-123406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8913E890818
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438B3299B76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4714C1311BE;
	Thu, 28 Mar 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsADXKHZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D57D414;
	Thu, 28 Mar 2024 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649760; cv=none; b=RHE/IAgbKnQqivhBQrB5TE7bFEQo88vrDKHX38vZPsNRPHdBwAx/TLZXET2HopZFyY4GVcQcZhBeuyHfR5etPuTuaSwe7Rog63pJf4QM1bN890wiVjqYasS9LrIvcIbFSZPJsPDKldsl+Zhb0qUABjiZlLPXNcbn4R0Sw8ozBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649760; c=relaxed/simple;
	bh=3GUY1V4XEO+k/JrR27SCuCgcjUJslhIYukseqgtaosw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QpyIFwh2GlblYhxMvpv6EhMZdwSyJDoMxFeAJ/r2ssPxjWTnOTIPTMgnfWdaRZc8cHwTnK/3kBhV7FhwdurOOwrrH2YV+C2D2fISgeJgRAX5LFa4CjmquXvaBqAR4XtjJN/Jj0K65vvoswnkDJD0ssVAac44s2WcHsNUh0pAtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsADXKHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C6FC43390;
	Thu, 28 Mar 2024 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711649760;
	bh=3GUY1V4XEO+k/JrR27SCuCgcjUJslhIYukseqgtaosw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jsADXKHZ0e5V+45/UMpwfN23PQHBncOmhngnQozFFdlaLzeXrfllnEoMo1P47dQxQ
	 yXmVNgIGGE5g0ZRv/SA27l1ZgMe2ORrA+QtxBL+lyLZIpBDCAosLWqer9Ni6wAXT5K
	 P+k0rpGeyAOvUjoZYgVopgKBHscV8rTf9CZ6JoLoQPc1Inxd+dCHYmAMS/LR8s/b/5
	 CjK9GzwU5VPgNXdUlT4xQZCMJuPPcVCin4dZaknUn/4ADhXhtUyCK0Tft80YAntZqP
	 vH9DB2Mh2vwOuEW1EWh4sHCKaSJxvNSjzSxnugq6L6wCXrZ9Cci6vC8J1n1S7iNT/1
	 jC+s6bEuYNVog==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240327055215.1097559-1-yung-chuan.liao@linux.intel.com>
References: <20240327055215.1097559-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel: add intel_free_stream() back
Message-Id: <171164975703.128475.13939078109231155224.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 23:45:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 27 Mar 2024 05:52:15 +0000, Bard Liao wrote:
> Add the intel_free_stream() callback to deal with the change in IPC that
> requires additional steps to be done to clear the gateway node_id.
> 
> 

Applied, thanks!

[1/1] soundwire: intel: add intel_free_stream() back
      commit: 2a9c6ff5ca5ac074a9f10216e009c042dbba0526

Best regards,
-- 
~Vinod



