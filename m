Return-Path: <linux-kernel+bounces-52814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B40849CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D16281295
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6A52C195;
	Mon,  5 Feb 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DkEy8pIr"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34D28E2B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143185; cv=none; b=huAnT+C+/YETbdtXoONOV4HVK7CNtE6NpCAApx4fjVmk9RNZHQD/E60SddnvwWKHacoEN/BjhIxVBX6c+Rw1Z/2aHrQ9widtav27ptjKMiiSWaedIzK3hyYxArsn/fskQvRtDvOOtPULoKDAnL3Hwaw9v+w5CwWYAumwJjUxDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143185; c=relaxed/simple;
	bh=93ifPHxJSeM2iYaU2Xs0dPEPIKxV57GehpAJ9XmcIZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBaLlHn5cUCUZlZY8wtVDPPHgovyKZbqeoy+D7sUO0fFsR1Y9YheWqWD4Ccf7Qcj7kXmf0FRwnBFL8jq3O8f+IsYOIdzeQvRoay6RP+AoXWsYY8n721JW7LI0Blt7PkuDA0BMOMxTGEuMtulSUDsLtCkifPKB5hAE7wQvFmxOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DkEy8pIr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6979B1C0003;
	Mon,  5 Feb 2024 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707143180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AC/wHsk6r4rKaMrstkPBqCLcLZEO4rQpDW0EikvYx9k=;
	b=DkEy8pIrVKpoDETj4JXr2udeYFAihq+1wyevfSnhx/SxD9NjAt/666dYSA7SmUZwlm79lt
	XXLvcPZIDDN01E3IaNzjsXfFEaMfLeiYYui9tVKiI/0dXg48yCf/fGotnSErOZPl4j2QGq
	HIZ9Mgiug1DjtjkSTrb0DKCa4Ha/gGvEUx3AOTihMimSL/Q+Tj4hi8K87C3We0f9FEvf5X
	di2NqWMOaR2xIAc8xYXazAelkTNid2FbHw2pJxk+nyhjbBXoPMzjAoJDpfobSC19aBh3fK
	pBbnj29eOlvk3m9oSJYto12B3tvsjtEFWFRZ1dB76hD8fjHFGmWUWR8WmetDwg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	miquel.raynal@bootlin.com,
	richard@nod.at
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Takahiro.Kuwano@infineon.com
Subject: Re: [PATCH] mtd: flashchip: explicitly include <linux/wait.h>
Date: Mon,  5 Feb 2024 15:26:20 +0100
Message-Id: <20240205142620.390286-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205100955.149755-1-tudor.ambarus@linaro.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'18af7e357033f1a1cee50db2663ef982b4a2226e'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-02-05 at 10:09:55 UTC, Tudor Ambarus wrote:
> While reviewing the hyperbus sfdp proposal the following problem was
> noticed:
> 
> In file included from ./include/linux/mtd/gen_probe.h:10,
>                  from drivers/mtd/hyperbus/hyperbus-sfdp.c:6:
> ./include/linux/mtd/flashchip.h:77:9: error: unknown type name ‘wait_queue_head_t’
>    77 |         wait_queue_head_t wq; /* Wait on here when we're waiting for the chip
>       |         ^~~~~~~~~~~~~~~~~
> 
> It is good practice to directly include all headers used, it avoids
> implicit dependencies and spurious breakage if someone rearranges
> headers and causes the implicit include to vanish.
> 
> Explicitly include <linux/wait.h> in include/linux/mtd/flashchip.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

