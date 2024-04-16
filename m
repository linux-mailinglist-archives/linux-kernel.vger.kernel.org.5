Return-Path: <linux-kernel+bounces-146582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEF18A6798
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992C31F2191B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CE586629;
	Tue, 16 Apr 2024 10:02:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E09E82D82
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261728; cv=none; b=AAAfr/5hCnMfRuetOTZCV3Ni/ztrPQX6Yt43Gq4Cw49UuGj6rMYGR2ZkBaZ7Y9H5kMLldQPtnfYy5RpRpVDn4orOdJbwDaXsnARduVUCYQCdj0676+vq/11TCDfvU802mvN7yDSf9wC6zlVOTjks6XuDXCr/w2F1VPndpLQ4APw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261728; c=relaxed/simple;
	bh=Jq19k12ilL8BDybMeNw1DHJhQaeEvIBxmiWCnWQG7Uc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kbJhbUJlfysFl2UBU+Iklrfqj68KpTyT3RSz1dFo42zzizPWkW0PNow2NlHYQ47b6sTzlsnFV6zEldPg0Fk7vpZUBMf3xbiOPKYmnPEneQUnadgvKR0+2UhunRy1VkMA2KtAGO4ttO8Xk8ra0oma63M1Wua/XRNthLnGXfiaRhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6256C113CE;
	Tue, 16 Apr 2024 10:02:07 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A6AEB106071E; Tue, 16 Apr 2024 12:02:05 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Osama Muhammad <osmtendev@gmail.com>
In-Reply-To: <cover.1712756364.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712756364.git.u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/2] HSI: Convert to platform remove callback returning
 void
Message-Id: <171326172562.1374966.13797098333010871783.b4-ty@collabora.com>
Date: Tue, 16 Apr 2024 12:02:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Wed, 10 Apr 2024 15:41:09 +0200, Uwe Kleine-König wrote:
> this series converts all platform drivers below drivers/hsi/ to not use
> struct platform_device::remove() any more. See commit 5c5a7680e67b
> ("platform: Provide a remove callback that returns no value") for an
> extended explanation and the eventual goal.
> 
> All conversations are trivial, because the driver's .remove() callbacks
> returned zero unconditionally.
> 
> [...]

Applied, thanks!

[1/2] HSI: omap_ssi_core: Convert to platform remove callback returning void
      commit: 94eabddc24b3ec2d9e0ff77e17722a2afb092155
[2/2] HSI: omap_ssi_port: Convert to platform remove callback returning void
      commit: c076486b6a28aa584b3e86312442bac09279a015

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


