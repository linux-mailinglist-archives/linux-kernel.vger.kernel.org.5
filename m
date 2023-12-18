Return-Path: <linux-kernel+bounces-3555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1B6816DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7353E1F211B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E774F5E9;
	Mon, 18 Dec 2023 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="L9xiH1Ej"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195F14F5F9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id CDB6D5D4;
	Mon, 18 Dec 2023 13:14:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1702901692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3syL4boPsKSxtc4draQO3ijO1mk9nC2sQSx08Ey95Y=;
	b=L9xiH1EjkgX7nLQ3y36aVW9YKxib4KCy0Kp2DuUD6jSD8FjuMCJ9s9MPFn0zCGV1+jKguM
	QlF4Vldvuqq7eS/GtxDHvOQ8SKxdv0uRZP971dTtu/IQDyLeSDKbdw/5Vu/de9WylfROgk
	8SWMekbP4/tXESsgGcPvgHBIBv8rDGa9alXpEa4YX5vQWD9+ys9YriHstD7ruxEvX0Risn
	kM8U4EtrpP/k3EfepFWUjspvNLMsu4P3Uxwq4eyA5YCR0rsE0WAJKH5Pm/DV+fR458OPb0
	8GBYogYNq7sOXFYlnIYNbowe5X80FDsZniAg2vvHKHwC2WrKR5WW6gAw7oUONA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Dec 2023 13:14:52 +0100
From: Michael Walle <michael@walle.cc>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 jaimeliao@mxic.com.tw, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: spi-nor: drop superfluous debug prints
In-Reply-To: <20231215082138.16063-5-tudor.ambarus@linaro.org>
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
 <20231215082138.16063-5-tudor.ambarus@linaro.org>
Message-ID: <7d80cc0afe33ee9a9f660b6876b69e81@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Am 2023-12-15 09:21, schrieb Tudor Ambarus:
> The mtd data hall be obtained with the mtd ioctls or with new debugs

shall, debugfs

> entries if one cares. Drop the debug prints.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

With the above and the unused variables fixed:

Reviewed-by: Michael Walle <michael@walle.cc>

Miquel raised a valid point that if the rootfs is on this very
flash and if there is an error, you cannot use debugfs or the
ioctls. But I doubt that the info about the erase regions will
help much in that case.

-michael

