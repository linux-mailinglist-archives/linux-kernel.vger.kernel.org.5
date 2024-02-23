Return-Path: <linux-kernel+bounces-78620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1B98615FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF551C20FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC8A823BD;
	Fri, 23 Feb 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqOIG3/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD226E618
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702629; cv=none; b=YAs7WGnCnTzOhznbTjpIXylMhTUQwfkneOIkuYI15uJUgbB8lEmxjNysKYLHqb5D8xJBqV0LhN5LXxdfK24gruYN0u7OGqKmFMCsqgPY6wnbPgBqcy6OMmnTHdxMlAZtAWJoh9MnpG39bF3A5Vs61+L9QHGAv9SnzMkEIO7deIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702629; c=relaxed/simple;
	bh=1Mc2mfHsTojIwn0Wldi0LZb5nmTE/KW/KUJ8gCPv8s8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lEcLWEflUVUgNL73T2oJ6gUjGUxSJ23kt2zNZzZ8Tqpc9+SLl5imMAo2GQ1K2H6had7usRwzzFGKXcU+vTdhHlI0Vjew1CXN9eO+CAEn4TnnLVem/4SqLduZAciEnAihD2ZTuHipNzyuok5kw+2uK/IjULsPW4IO31RNRy301RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqOIG3/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE08FC433F1;
	Fri, 23 Feb 2024 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708702628;
	bh=1Mc2mfHsTojIwn0Wldi0LZb5nmTE/KW/KUJ8gCPv8s8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HqOIG3/7aojtaoUhqHJUT6jh+l1179+DqPGcdOBFuWEKIaz8kbc8QMzHR5lIQ4t7n
	 RxAVzszo3Ds6AcFu3Vlv6RRnAIVuaXxwEjxFbLxedPkDu4B7/KOSxQ/95EV0M9v/IT
	 rlN9H+JZuBT3SGPvZzaGPaCYO6R3oHcq3lNCAtxoU4/mqF1U8CWi9KmG28Rj29P9WZ
	 2/mR7P1C33Aeb2Bv+GAbXWDt8dOGgYGg8qzRk0aFNxMAd8GJ96UMVAitD4yzKbjYVl
	 RG+nmqsd7n2mi9M9LmWBTSjDAhrfeK+y+Plp/xL254lMu82V52qz2tNmlnINhJLzlo
	 sZ0NwCv6h0ZOQ==
From: Lee Jones <lee@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Lee Jones <lee@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ef7d5fc3d867338520392417cdf2b67ba19aecde.1708002264.git.geert+renesas@glider.be>
References: <ef7d5fc3d867338520392417cdf2b67ba19aecde.1708002264.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH resend] mfd: mc13xxx: Use bitfield helpers
Message-Id: <170870262748.1709751.12807653760472822358.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 15:37:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 15 Feb 2024 14:07:13 +0100, Geert Uytterhoeven wrote:
> Use the FIELD_GET() helper, instead of defining a custom macro
> implementing the same operation.
> 
> 

Applied, thanks!

[1/1] mfd: mc13xxx: Use bitfield helpers
      commit: 18cf74b67f1db31ef8e2cd256e605fe40a034cdc

--
Lee Jones [李琼斯]


