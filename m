Return-Path: <linux-kernel+bounces-3533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A1816D78
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF41F23CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A94E1C9;
	Mon, 18 Dec 2023 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="IK/Ee2Qh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F9B4D594
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id C1C9A4FB;
	Mon, 18 Dec 2023 13:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1702901271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hONpi+9Up26PTg3zkKlX6fImQXNBFZKhWsqSr/nQzw=;
	b=IK/Ee2Qhbf0M3wvpr0/p60S5k2gxujpToMUKjYb4o3qgVwdWsB4t+LAgCYjjU3fYrmlCvU
	wVowx2ZY2WTyJRfhYElq00BgGKs9TMiI9aVWQP6w/elU1M/L0BGMdfKJOKfD3GUbv5gtLQ
	WYCsW124m2Hjebc6c8kd2AhB80KUsyLz6JqMMlgo9cQFi4xGDo68jm2ktSc83RgMVkaE8b
	in5b40MVKWATbLkduMLarTFTgI/xe5FPCQ7sBTsuTFknskRiLwat+thJIiLr0kz90pkv9k
	XsNTRG9KQn9Q0VYic9qEci3tavaBbq7nHimF83fQi7tc9kl0cbwJXR1eXYeWyw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Dec 2023 13:07:51 +0100
From: Michael Walle <michael@walle.cc>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 jaimeliao@mxic.com.tw, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mtd: spi-nor: print flash ID instead of name
In-Reply-To: <20231215082138.16063-2-tudor.ambarus@linaro.org>
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
 <20231215082138.16063-2-tudor.ambarus@linaro.org>
Message-ID: <46c4de18c6650a695c6ce2b4af7bd9a4@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Am 2023-12-15 09:21, schrieb Tudor Ambarus:
> We saw flash ID collisions which make the flash name unreliable. Print
> the manufacgturer and device ID instead of the flash name.
> 
> Lower the print to dev_dbg to stop polluting the kernel log.
> 
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Michael Walle <michael@walle.cc>

