Return-Path: <linux-kernel+bounces-140204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979228A0CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370441F22DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD01145FE6;
	Thu, 11 Apr 2024 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwii1Wfw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F709145B0D;
	Thu, 11 Apr 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829082; cv=none; b=ViZZXOw0L38yZVPt8kPLWeUBOpTeHCHLP8k2Kuycf5jYvla+K6W9HbUP0GE1BieWssdLpTt1VkJZVEeMBgoL/tvUea4rqWongBrJzzy1UtB49he+qNfXkiJoIc5UpZPWIfbr02yAb9WhcDm4sDJ+g0xESonvEGxIfqUCQV2DSws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829082; c=relaxed/simple;
	bh=dDDFGxbzvsZ8WL2gkkU/z0FoC5P7riL8bCTBYIbhje8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ASZnhTZI8ZE1FzFsRoarZ81BQ+Ayeyv6WsPKDhGvMNiu2uMoPLKKHnE2ouFraYFRTxBqYwSvqDpiVXD/aLtvqjG5RrvhIdUugwY5lmC4lSuzYGW8mI8J9F6P67GhUDOlP6qzgrlJO6isfxJV3ml0fCzXsuVkmxntRI8FDLH7rLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwii1Wfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B81DC433F1;
	Thu, 11 Apr 2024 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712829082;
	bh=dDDFGxbzvsZ8WL2gkkU/z0FoC5P7riL8bCTBYIbhje8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Iwii1WfwXAPhAr1zpMSkaTs9d6mvUukauGpIjCu2D2Z3sYtQvxREbfvxWY1n6HAis
	 qW6hgxStloTXb3tv4fbZJjknFyR0/vVcvS3xCYLCOoT47cz2ZVjMw+WltcBeKSpy3u
	 rlNVND71iPbdom3abq33lDRNIILDyBkkvnh0XnqKPtaYq5UikaMEHTWbO+qGE2ldM2
	 VgFSKBz6FuD2f5lg7J4YTNWCzf0RyllNDR4pMDc98mq1Q7KvPyiPRV6CHARtOQeR40
	 ALv3fQF/XtueCOb2/WEbGUEHMYUtuc+CCTJ+9IfOr14Nuw10EyUUPCxboZJPDN5iXx
	 nM5lWrt2m0l6w==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240408062206.421326-1-yung-chuan.liao@linux.intel.com>
References: <20240408062206.421326-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel_ace2x: use legacy formula for
 intel_alh_id
Message-Id: <171282908007.521900.190599081183352528.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 15:21:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 08 Apr 2024 06:22:06 +0000, Bard Liao wrote:
> Starting with Lunar Lake, the notion of ALH is mostly irrelevant,
> since the HDaudio DMAs are used. However the firmware still relies on
> an 'ALH gateway' with a 'node_id' based on the same formula.
> 
> This patch in isolation has no functional impact, it's only when the
> ASoC parts use it that we will see a changed behavior.
> 
> [...]

Applied, thanks!

[1/1] soundwire: intel_ace2x: use legacy formula for intel_alh_id
      commit: b18c25afabf80972b32a3918f6d7f16fbd54b18f

Best regards,
-- 
~Vinod



