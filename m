Return-Path: <linux-kernel+bounces-123405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FA5890816
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C411C2D139
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6458A135A7E;
	Thu, 28 Mar 2024 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuJiS4X6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2321879;
	Thu, 28 Mar 2024 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649751; cv=none; b=BvutotCyfWDgCANKk3t7emJQraVW/cnGVQEyTad9ECn0XzXrdabC4qf0sLtI/8i37ZllRD2ahgfx0J9dYsjRIEtGicUnzYbnUeszV54QonXn+sXTddAexLyQcWE+EwXJCvGCYG4aEZ/ODODFtYeloSTwSRQtV0udvdH4KusbR38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649751; c=relaxed/simple;
	bh=UMRSyA2bFP0rXa5J3dxBKBlpn6kkbV2kY4w4LwiVwHY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RpPZHmihZ5qrULVBIIZ4XIo0MI/uI1NNxCDCFYEglau5WTmhzQMFCxEdGQORHu41JyqhKqXrLhQ6Kr/y0ufmquIRA3h6a34c9O5peBWkqQrSzhnoGiZJjzXKvpUMEkfUDTmctDtTnNq7nJDRkYyD4++5MubRPqqgNQNDOBjjtrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuJiS4X6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4FCC433C7;
	Thu, 28 Mar 2024 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711649751;
	bh=UMRSyA2bFP0rXa5J3dxBKBlpn6kkbV2kY4w4LwiVwHY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QuJiS4X6+SdOhHuV25qq6pjN7O5OWbXkQDTacNSecHOhaFO6IA0wGTntXz42drxV4
	 B24ttCqs4lZoBY0A9jpzP6I7hVETkOOcxhGYYzEal5997+QqBZvORtiLiXALeX00OG
	 JMlAMtUqPNtl9+oJy8LgLxFwSm1l68w4fEUayhmxfeIX43rXTdExy1QYi4IvoBF7Qm
	 L3YbtCpZVvvZLJvsjxOQUlVd1RHe7nUXskPLDPoMB/kdLGMCcTE7cwQZjzIf4cilE7
	 R6S3hTEwPD1C/TNSDYlPQQi1BdkgLrjTZPdHK/zcs/7IzB+5GZEE64vWmGCKHTlSFf
	 /VTBDaY7wGKLg==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240326060021.973501-1-yung-chuan.liao@linux.intel.com>
References: <20240326060021.973501-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: bus: don't clear SDCA_CASCADE bit
Message-Id: <171164974802.128475.13743967735828669575.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 23:45:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 26 Mar 2024 06:00:21 +0000, Bard Liao wrote:
> The SDCA_CASCADE bit is a SoundWire 1.2 addition. It is technically in
> the DP0_INT register, but SDCA interrupts shall not be handled as part
> of the DP0 interrupt processing.
> 
> The existing code has clear comments that we don't want to touch the
> SDCA_CASCADE bit, but it's actually cleared due to faulty logic dating
> from SoundWire 1.0
> 
> [...]

Applied, thanks!

[1/1] soundwire: bus: don't clear SDCA_CASCADE bit
      commit: b3a6809e623c03371ba51845129cdec3ebb7896e

Best regards,
-- 
~Vinod



