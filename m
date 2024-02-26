Return-Path: <linux-kernel+bounces-81180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B841586723D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD4BB3349F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D515E1BC30;
	Mon, 26 Feb 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YvGqP2LL"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A411CAB1;
	Mon, 26 Feb 2024 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944207; cv=none; b=tZISm+fy8/aoTMzhZ/WBJi9iRqmrCvfBE4W4F60Umo9lxqMDkDYUH59uguQpNFFTIuJFuWqI+GcjV4wYTDSdCF5iUn6YC0NbwU3vAnTwF+jXgpl0k3ExHNSUynXYjJBZGiGEkH1UtSruE9wRSqdIpHOv2iaULt7s6LKzN1GY9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944207; c=relaxed/simple;
	bh=bCOEdmzm2b5pTbM42AruTEdEivbhVbBQbwIOPdHVrdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6sYcDv/KToCyo7Ht0uCgQ0wACLEacrHw0vAfc4R4/7Z/0RJImdBBkyOkQrGlWnp+F8NN349aV8erm52FqX1bCDHvkU+IqvlJK1WnpMJJviB3O/uP6ToKsExvcQ6aOCATeikjrOqnvGlMt0mTLAKVkcH4wsoIajmhoEIlcLw5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YvGqP2LL; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E2AFE0003;
	Mon, 26 Feb 2024 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cUOu/Bvds6IWzkUYXUufNxfYQc8ER3syNtdbbPnHc8=;
	b=YvGqP2LLM+FcTfrtjxQwzs7w3A2fUilwQeUI58huYIm2Kg1IQMFfGt+Zet2mcELXqH2fob
	mn4B2THIdiZmkOsYQUmnmSIq4P258lPEmg80dYPqD/7sY7u7ZuXtoaC3XfASxHuN01/MFn
	ysabwloahnVouXM+KREKryMSYQojH8p/FzMg2NlnQZn5HSHyoT3D1K0H8Wx/BrtIVlKNTm
	YKgKPmiXzz+jm91LfbKhCi8QmV4Qbldt0B7Dhu8K9Dwx5BCADLIQKTfxbCH4yIhlMgmDkQ
	Y/F6coD0LmKVep9scoc2ocmi7rGw4SfPk/796x6la7xFzZjySPlpMgNuZCwfTw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Colin Ian King <colin.i.king@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: chips: remove redundant assignment to variable timeo
Date: Mon, 26 Feb 2024 11:43:22 +0100
Message-Id: <20240226104322.489020-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215140106.2062858-1-colin.i.king@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2416a2e7be9b27157f173268f5c7f769bd72a8dc'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-02-15 at 14:01:06 UTC, Colin Ian King wrote:
> In two functions the variable timeo is being initialized with a value
> that is never read, it is being re-assigned later on. The initializations
> are redundant and can be removed.
> 
> Cleans up clang scan build warning:
> warning: Value stored to 'timeo' during its initialization is never
> read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

