Return-Path: <linux-kernel+bounces-136312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292F289D289
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8269284544
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ADD31A66;
	Tue,  9 Apr 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bu1UoXP8"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D46E5EF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712644863; cv=none; b=jbzyLMjR8TK7oFk2AXOR4TSoLVq86vujgGA6iPZ2cd8kvT68mHUbZoig5xMLzEbGPRJnzjiPp5WgatFacQj24hXYltQDxoXh7dIGCD1XtZ3t+9tSy6H8qU33aoz/KG09H7yOnGC86yLvsIQtPT2uvCzLrtdfLKRS09mIyAnmjUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712644863; c=relaxed/simple;
	bh=aMP9ixz0M0oa1i3Cpxg0z3tlmqIAc7u1l9xEh+VLkj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UPrEtc063SDrTznDaz5qCgVDPDCz9TPitaSg2E4XlLvwylWW+YlpK+buUoaFCoCQlpUNpnaNhzG+ig2Zu7EwVOoN4lFexsNzj1OqyBWjtlam54IeXcY4eHeqKZKV4V2gzYzS1xLdakOlBXhwlnEZsq1Iu5yEX/m0mJ4yQdiT8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bu1UoXP8; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50E502000E;
	Tue,  9 Apr 2024 06:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712644859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=el4POVwG1BFOHwCXCj9zzWb/ZOsSj/5veLdQd6Ccm00=;
	b=Bu1UoXP8fESp32KVmdyGj/iLb8L294CKCbaoAKc8LpF0ujbj118zHfT//X5Xf+hazUgoMT
	Cq+Krhpipm7P3vepAyf8RJUALLvSMojCxZeE8Qbq7A+4YaKnYS3/vVapkJDDYSX6QT+UhH
	oBu74Y1Cn133jdsKYdEovpV1S6Fiofss9wsf8hyxtX7xmNIh08F9lNLZh1S0jm8v3O28NX
	seQVCqYfawXudtThkYHc3EWWBK7UxGMKE8elpmDy0QXqNj96N8qw42sOxnadgV9fjoZOHa
	45oCisZNQF4ykMl7d9EpHn605dmPJERCM4BZzSdB8LgRnlrTqJRYBLkrK/4DAA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: core: Align comment with an action in mtd_otp_nvmem_add()
Date: Tue,  9 Apr 2024 08:40:57 +0200
Message-Id: <20240409064057.91803-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325151150.3368658-1-andriy.shevchenko@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5043e5553601504995300c98141230f5edd11933'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-03-25 at 15:11:50 UTC, Andy Shevchenko wrote:
> The comment is related to the non-error case, make it more clear
> by inverting the condition. It also makes code neater at the end.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

