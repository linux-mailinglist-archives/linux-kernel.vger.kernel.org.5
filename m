Return-Path: <linux-kernel+bounces-19019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0954A8266D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933C0281826
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36C13FF8;
	Mon,  8 Jan 2024 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E3c5M++3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CF13FEB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 80143C2C19
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 00:04:11 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1E47C0002;
	Mon,  8 Jan 2024 00:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704672244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eg4ZK/4xRof4C62MEDOAspYaJdjduto++dnlzUfFY3U=;
	b=E3c5M++3pyZznVbBRuHbNyAa4O2MEbwB7JLXIrrfxSvY62D6kipm54Sn0tFbRmvZ/fDx7E
	3YANJyw9K39oRIS9Q0BZHDoaa/SNndLm26j3YW6zW2yxDnefVqcRYv+7vP/bf8NS/ASiRJ
	lHo9M5ixmRsZ/w3JdxroUPgWXLO4NpbIav+zhmEfeAgM+uxi9+DKqVCCaHnUtEXgn6dWJE
	GkpRrQRrYCXxpvPAxbYSBlAM+FYPTs2oJa9vdjPVyj6/meYi4O3Iocw1CkgoP0gZbCdmrJ
	SQErILPUUNV2ADJnZs8dGNkiwGH+MM5BqLu6QC/oePlda7gEqjaCliwIizpiWA==
Date: Mon, 8 Jan 2024 01:04:02 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: pgaj@cadence.com, Harshit Shah <harshitshah.opendev@gmail.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: cdns: Update maximum prescaler value for
 i2c clock
Message-ID: <170467220284.558820.9894090612605026533.b4-ty@bootlin.com>
References: <1703927483-28682-1-git-send-email-harshitshah.opendev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1703927483-28682-1-git-send-email-harshitshah.opendev@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Sat, 30 Dec 2023 14:41:23 +0530, Harshit Shah wrote:
> As per the Cadence IP document fixed the I2C clock divider value limit from
> 16 bits instead of 10 bits. Without this change setting up the I2C clock to
> low frequencies will not work as the prescaler value might be greater than
> 10 bit number.
> 
> I3C clock divider value is 10 bits only. Updating the macro names for both.
> 
> [...]

Applied, thanks!

[1/1] i3c: master: cdns: Update maximum prescaler value for i2c clock
      commit: 374c13f9080a1b9835a5ed3e7bea93cf8e2dc262

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

