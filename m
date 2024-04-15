Return-Path: <linux-kernel+bounces-144883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E59B78A4C25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7424BB22CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A361481D8;
	Mon, 15 Apr 2024 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iR6dQYvF"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF3383A6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175618; cv=none; b=i4wCuuiLaP7BrxGkFjmrvRW0sV3BYUBKmXjHykZ9QV9gKdxYMRq/j1RDcl2iOSsOPlnlIHs7+mlE8ohqFRXyTEQ4AQFpYRTbjw5KIR6DxL0kUqhIAk27O8Hsay4htSO2We6DgtYues6gV6EebQqroVja1HtYMAE4b8wg8r7y9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175618; c=relaxed/simple;
	bh=YjMchapYX9/sDls5svLeujHI7lcyG9YXWgXrM9cbnQY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W51dfLbcOMzgielbxL0e8RfbLyGBvK+V7X3vBBVWthSusF3ewHNKnA7YqGFLOhAaEs9tWn0fiXz+5/2KEMUpX1Bwma8/6fwGgrxoKNGbYxnv/Gmd7sBnIphQTnyCtfo8CYS+1BkQ9axJJY2j2daBi4KPRj/ANwnxzY3SoJw5UN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iR6dQYvF; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1AF5AC0002;
	Mon, 15 Apr 2024 10:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713175614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2SwlIPSgTwFnJsuIKzMY9+vt/yHtdwscdSZB6mQOW8=;
	b=iR6dQYvFkl5Svd/hCMCscoiZlfYcraDq8OBiHnTauIJ0XRAI2cupwPlWH5NMboUSWdK0/z
	saMdNmofXIcn28F3ee9IPQM4aXW6iQwE3HzGwNuYHkTfxtk/Q5cbElz6rZvsulclcQkQpo
	j9TlfTTM15Nz3dbfuHgxAjL2VQg3P1yC7Ww62QxHxoM4GEBfUFdtiqr12IBIhz9DrsHUFg
	z6vkWPQb1WYWQ2hAHGenPQDm2+95cmIYW94c50hqbLfgE/EgkK1nhwXseCRYF2gXuzdF8v
	RkEgyq2UzSppVxe+suPPqBP3zydrhPTL5PpWKBGMkQsbw/64QMVTYQx0F9z8Zg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: mchp23k256: drop unneeded MODULE_ALIAS
Date: Mon, 15 Apr 2024 12:06:53 +0200
Message-Id: <20240415100653.32058-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240414154943.127079-1-krzk@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6277967d872e229de53b0585ebc34c8172965492'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Sun, 2024-04-14 at 15:49:43 UTC, Krzysztof Kozlowski wrote:
> The ID table already has respective entry and MODULE_DEVICE_TABLE and
> creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
> the alias to be duplicated.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

