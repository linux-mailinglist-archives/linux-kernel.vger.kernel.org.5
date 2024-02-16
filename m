Return-Path: <linux-kernel+bounces-68551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12B8857C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF5B282CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF2B7869C;
	Fri, 16 Feb 2024 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5gf51Nc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C97868C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084691; cv=none; b=CpLLoih5bQE+Yls25bVo5gp6MpXBy1PIuy6mtTJLE5oNVzm+Oim0xVtLMzrrzXU5DFNdALvprBIO8U1AdN1tl3Ze8Oe4cpvjC7vkZD48+T0ybGYKtHh9at5InjcSyAmbYm0WHcA5vxjfiG0+cwDjoeFCwUoMTTj2ogCRTsHM6ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084691; c=relaxed/simple;
	bh=fDXFPqOM8tS1XBAaGHhJZBANxuhJPAJuNO0LrQAsUz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dPp6wH6Zx85K5WX58edu3cYuhK8eD9O/cFotl7F15yX/kRVy28d2qaSzK4ikyWzcR/Ywo4GE6ZLQgUdsacblTAUQl7H5UUOieeq0X+LZZS8Sy+01/LjtZuKD/1dpj9s2drbXvMEDoQlE0SbutUnmtONT9c8giTIpcRIVv9FXJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5gf51Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCE9C433A6;
	Fri, 16 Feb 2024 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708084690;
	bh=fDXFPqOM8tS1XBAaGHhJZBANxuhJPAJuNO0LrQAsUz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A5gf51Nchu6ZzsB9EI/rNiYoAPJC8mTOX+Yj+aT8TRjifTvjHM4d2TL8Xlexbv/YL
	 iL3qrkOkCtYkIuF4MKAxl3SP/zqx/vZlXDe4PwKbdaTDr5GcAR0JyOPEEuyNqQQB6M
	 8Xvj6YwvXCGqkiIhxjXN9aaT6zK0zEEZsNGUl64YMlTdmHqSb6mqB5bZADootnbI9E
	 r2SMOhFOnj0nLJMhY1mid+pimMrecSNjV0kOQOoGPm6GxmTIUQfj5GLkawA3VdW+uw
	 zkbhuf3r5YMlikVo8XjRZ7sXzGI4wnHt7BCZA43O50zp1e8HKE2lu9Ig8n/jr7eBae
	 B0sMDSDK+WoAA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
In-Reply-To: <20240209160334.2304230-1-andriy.shevchenko@linux.intel.com>
References: <20240209160334.2304230-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] phy: ti: tusb1210: a couple of cleanups
Message-Id: <170808468906.352706.3704956051915037531.b4-ty@kernel.org>
Date: Fri, 16 Feb 2024 17:28:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 09 Feb 2024 18:02:13 +0200, Andy Shevchenko wrote:
> A couple of ad-hoc cleanups. Nothing special. Has been tested on
> Intel Merrifield platform (with DWC3 using this PHY).
> 
> Andy Shevchenko (2):
>   phy: ti: tusb1210: Use temporary variable for struct device
>   phy: ti: tusb1210: Define device IDs
> 
> [...]

Applied, thanks!

[1/2] phy: ti: tusb1210: Use temporary variable for struct device
      commit: 03db1786fe9eae146ba9b3e4fd220f1e502d588b
[2/2] phy: ti: tusb1210: Define device IDs
      commit: 505dfc6ba84c85651f8f8a7bf721aadc49049a44

Best regards,
-- 
~Vinod



