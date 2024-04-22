Return-Path: <linux-kernel+bounces-153547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA918ACF78
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7750A1F2129C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803A8152197;
	Mon, 22 Apr 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAdGzVxk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A65152172;
	Mon, 22 Apr 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796338; cv=none; b=mnEp3W3qzPpDrNeB/p9rdueMRKTHidI0fejQlf1A5uKm5jkUfZmnBqfqWNSZ45R0FzpVFMPNwSnj1y2dirtQyGrbrjTyh8+iUiCcrqxfIj0H+WZYt25lYYCw0ryHZ2LFPb9oQ204qbiQ86P4C1tN0SJQFng8rTwoTLR31nbCTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796338; c=relaxed/simple;
	bh=UZIxVFEW74eS+zx3QNO5SuI2uGg45s9QOS50Qqh4CEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVgBy2CzuqcPKtVq4cOzxBRO8VldY6u3vk75vD78BG3nunW6DoeGe8nYws2kOLCIq2/0EKd94XeMEtRKf7xxSKTVU9VjRtMLdP2xNTJJT0goxRtL/TnusJa8gPHUnX4QH6TbitaC7M6V5eG2UkOZWbR1ORq3drqnt+vWcVa+has=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAdGzVxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D4AC32781;
	Mon, 22 Apr 2024 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713796338;
	bh=UZIxVFEW74eS+zx3QNO5SuI2uGg45s9QOS50Qqh4CEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAdGzVxkEz0GXl6OGmaEd/zSorzSR3q6hPLVkaU8f0vm5JffzM4Xnd0vifqLHhn3E
	 Zv4PP8L2+NxZ3xdtxxuezgsBKEmZ4GibOSHoCzu2A0gkKuVi9ppN58A7NQ5qbaVkWM
	 9qHzPchBo1ktsPqSDO7UYWvzywlUjPP7MPDKxdzh0dpeRsW/z41MggAGRDizSYeKAU
	 0u6KgXciKXiAUNDkThKE7Nek5zgqvgbVJ2GY4qpQz5WNfhiYDuCIOY9JZLUhtaiu8R
	 Gfmzkou7PyBq8+WPlIkLChxDxFzXZP1kbNYjVA3E2vBMDI2XvGdobNQgrhROQ3pePt
	 iAq0llisZPs0Q==
Date: Mon, 22 Apr 2024 09:32:15 -0500
From: Rob Herring <robh@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: amadeus@jmu.edu.cn, conor+dt@kernel.org, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, heiko@sntech.de,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions
 for Radxa boards
Message-ID: <171379340485.1139142.4385224897520028554.robh@kernel.org>
References: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>


On Thu, 18 Apr 2024 18:26:19 +0200, Dragan Simic wrote:
> Correct the descriptions of a few Radxa boards, according to the up-to-date
> documentation from Radxa and the detailed explanation from Naoki. [1]  To sum
> it up, the short naming, as specified by Radxa, is preferred.
> 
> [1] https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com/
> 
> Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


