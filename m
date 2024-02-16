Return-Path: <linux-kernel+bounces-68554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69D857C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AFDB2140D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DB578671;
	Fri, 16 Feb 2024 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsZBIPWg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C277F12
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084954; cv=none; b=QpH08qo/Nz3yO4UpQoX4qmB+WKupvnvyJjRc4iAWKV1AihQFXvI4SQj/pB+J+uAd0BU9DFjpetyshJhBYMd0swQnIz6K8gyONkFTvifYe1SWZ/KFCUtuIdEk69sKQ7VkwawQoZaGvD91kSgT3k+kBvDF31ShsewnenPbTfqtUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084954; c=relaxed/simple;
	bh=5Q+kd71G8dshq5qDySGQ0Qz6DT8zy+MvtrCDJcuOJ8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=siUP07jBafpSg9l21U0uiYuIdjMdf7Hjtocr30PwV8NXqvO9JxZFVLEUTFJAxwByeMSJ3X9TBd7fHOewpBtG2ixJIq6/TdCN2GMcRNO4CIXUoebF5prZQlJactIV5w50N5pXXLcHjVYs0ac30RESNRsMSSJHsCBcAJitZkBd+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsZBIPWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29113C433C7;
	Fri, 16 Feb 2024 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708084953;
	bh=5Q+kd71G8dshq5qDySGQ0Qz6DT8zy+MvtrCDJcuOJ8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DsZBIPWgxa3vItensb1wYxtotyg7XoIFnRPrb+p1LEepBCK1rJvY/HkdbQiNOAQ1k
	 fzWZCS+OFtBvLJztcG8Ff8mqyaluQs0J0un8JNfijpoLbyPNCmTwZw61TlZvF8dsUW
	 25Ft1Yxo9A/5dx+uUaJIkea+4dYJWBkmWZ6cU390DUvfqrhybyxd7SA7xypeta+8pH
	 0UfuzlbMNepNIj4+lxIKZEZk5/0BaY5EBQ27lsbEcW9LswIVVZWRwoYwM/sD4KiKvp
	 sl2PoZ46i7gtCJd6z0gCYqoFXeUgsIQQcsE5kpVFQJsis2Gknuwu47uW9GaQCGsRFN
	 mRQjt950K7c+A==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240213-bus_cleanup-soundwire-v1-1-3878b00f6f57@marliere.net>
References: <20240213-bus_cleanup-soundwire-v1-1-3878b00f6f57@marliere.net>
Subject: Re: [PATCH] soundwire: bus_type: make sdw_bus_type const
Message-Id: <170808495076.353215.12668005796440668308.b4-ty@kernel.org>
Date: Fri, 16 Feb 2024 17:32:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 13 Feb 2024 11:36:56 -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the sdw_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> 
> [...]

Applied, thanks!

[1/1] soundwire: bus_type: make sdw_bus_type const
      commit: 81a7d0c4d059cb5c122110acbeec7bedfb91a741

Best regards,
-- 
~Vinod



