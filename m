Return-Path: <linux-kernel+bounces-106236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD76987EB36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8309A1F21C60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E184E1CF;
	Mon, 18 Mar 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD3U3oYj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E565F4D9E0;
	Mon, 18 Mar 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772939; cv=none; b=qmyt28Jep68y/P1Q/5SHDUfTKZw0GroBc0VtZplmNbMy/ucoe7g76GoQQ4M1kgnsOsbR8J3SzbfkCuLk/jKhJGCu5yaboL1J/LgNVYTLJiMu+L68Q664hKvc/SmE8HmbfxEQvyVPMNYSNetXWEcm151mbP+L6p2f4xQ4F0skJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772939; c=relaxed/simple;
	bh=l1HHg0QoUhKgRqyw04ZpzpJIxIF15krE30lI0986Cak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppThLWykhAO0R7Oo0nz5ahmm41yj/gpo3SY7JY6DaBbkUZ8u54KsrLa/Zxwybk2SsAxzJ/NoHcnZm09EbnQ+o1M1MfjqpENPqM9M1cHwiyqKJ23PTVDyCIjgn6E+Vk/pTyjj38bJ1wGsIiGtFQqinv8xBn4HWrEi4oPGq04czlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD3U3oYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F75C43390;
	Mon, 18 Mar 2024 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710772938;
	bh=l1HHg0QoUhKgRqyw04ZpzpJIxIF15krE30lI0986Cak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HD3U3oYjB7yanIn4H7iX5zsWod1r7zueK2oZXAeXtmmtyiRcnG82/aqDe9RBRsIWA
	 4oQXfjBDZl97ve6edWsV1kBaSUN433i125SMuQ9icnyrhIIniYrdKMgI3djP5L3GTe
	 lyIN5a9fB9XIHq3fi7/xZsldmW+CSoHa0GIocYGRbvhuEDWNbBEWLYXvwJSTdTFNjX
	 NO01Ikomc7fykfhe8pLFlS8k9Y7wYY4uX6ZIgM/kHXwuFP/CxstXHKrOOyeyijZuSu
	 MnBXX3KWoXbBT1NKv9+SNWGC9dqVcqdXtHrw16iHPKCh+Dvca+g9O6+p5AYK7mysmE
	 M+ea+mShkK7pQ==
From: wbg@kernel.org
To: William Breathitt Gray <william.gray@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	David Lechner <david@lechnology.com>
Subject: Re: [PATCH 0/2] counter: Convert to platform remove callback returning void
Date: Mon, 18 Mar 2024 10:42:12 -0400
Message-ID: <171077223004.1256602.14037397578842213363.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710057753.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710057753.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: William Breathitt Gray <wbg@kernel.org>


On Sun, 10 Mar 2024 09:06:05 +0100, Uwe Kleine-König wrote:
> this series converts all platform drivers below drivers/counter to stop
> using struct platform_driver::remove(). See commit 5c5a7680e67b
> ("platform: Provide a remove callback that returns no value") for an
> extended explanation and the eventual goal.
> 
> Both conversations are trivial, because the driver's .remove() callbacks
> returned zero unconditionally.
> 
> [...]

Applied, thanks!

[1/2] counter: ti-ecap-capture: Convert to platform remove callback returning void
      commit: bcc8ced4e1713bc7fa19a422321756788a58512f
[2/2] counter: ti-eqep: Convert to platform remove callback returning void
      commit: eca588187f9129300c6e44d64b819545cede463d

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

