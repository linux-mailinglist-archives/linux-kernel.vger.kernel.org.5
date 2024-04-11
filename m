Return-Path: <linux-kernel+bounces-140203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9838A0CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00442B21EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276A2145B05;
	Thu, 11 Apr 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC0Cxp8n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4C13DDDD;
	Thu, 11 Apr 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829081; cv=none; b=gJG6kNHoKCWqMeHvuSduJgNs5Cfv18GNld9e7oa2n6AKZeN1Y984LUez6fl66xGhT/kV6obY4Rd7aNqd7oC3hT3Ydi0n4bhAhhdyAAM0lAuqgUGQMq7Snu0PCzg4k9ItSLadNFamV9L3MrX1YBOcFTUOJyymN7DOATKpOU9RnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829081; c=relaxed/simple;
	bh=GwJOmyKS+qRIGAIfgbHrecjPAi5CzjfR2PXoi3m9S9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ydvfp5IIj2Tu8+Fqgfq/6NRYhNsvPJCgicxkoWxWTOEiPK/Yrv9RhT9T3R4ltUHy0LeGJKmqyKAxoRLw+WYsA1XnuP7NYA2gkmLC9g2AJN9sxBJv885k73jRn5mppEhQ622UGGFXYf4fN1yCZJWXaRtqdwDG5TMOS33DoNRv+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC0Cxp8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D34C433C7;
	Thu, 11 Apr 2024 09:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712829079;
	bh=GwJOmyKS+qRIGAIfgbHrecjPAi5CzjfR2PXoi3m9S9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eC0Cxp8ntoz7FzmYOkORXBMuFF6O/lOoNuhsrD6G4mLEtQf1M4N2RQnMVlj2nbwKS
	 7jDHIqg4+hmGRtpWRo7xTzOuj1y20LtHPMND3wDCIbpT9P28fAXmmTQXq5SPUGhQmY
	 fW29aDEFqeE5JJtLK6WVhsZld5UaBTjCQdAvHAeYB+iVKbmLoKqZfAaxE/lGtPX4tM
	 FUvo2JFeGEhsWDzKhqU9wFWHaKl9Z0UJFmGuotpV8tb68hpanvY0nUovOCPskkFdIj
	 fXUQaMX3vLtZeWoVEQxlUg3dYV9MUNNI7kMA9wWIJOMVjTDbC+nkT6Q8JKzX5XkIHv
	 +W7djfGAhVJrQ==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240408063822.421963-1-yung-chuan.liao@linux.intel.com>
References: <20240408063822.421963-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2] soundwire: reconcile dp0_prop and dpn_prop
Message-Id: <171282907778.521900.3984632651431202720.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 15:21:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 08 Apr 2024 06:38:22 +0000, Bard Liao wrote:
> The definitions for DP0 are missing a set of fields that are required
> to reuse the same configuration code as DPn.
> 
> 

Applied, thanks!

[1/1] soundwire: reconcile dp0_prop and dpn_prop
      commit: 8dfd00f7069c54db78463f2a8a8cb677844fdf1f

Best regards,
-- 
~Vinod



