Return-Path: <linux-kernel+bounces-3550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E7B816DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632951C23C69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F44F881;
	Mon, 18 Dec 2023 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="XQm5+G/e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849F4F5F3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 0CF9B5D4;
	Mon, 18 Dec 2023 13:11:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1702901473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1YrvLcZmhYxcBs0+MrjLM+H/Py5ZDv19n+yvqj0ggI=;
	b=XQm5+G/eJ2d//DoBR3tlIWuqoG3vQWsCxZNdBqvU/a3M6UFfJaTh4QYK/+5MwGv0Fh0JE4
	2UcHyY0Yiptn03utfxrYVFKMujLVfnLzkJ/9tbD88PpXBwAu+9JRLnb28lB+PJx9Ue2dng
	nISdDuFv9FaD5yKH58t5fXdp30jEHJkMRpei/pmoIPZmEPWXlNIi2I5AvKYBepMHmpNtZ4
	fxOZceabLstVvVCL2JWkThoFS/ZFD8pqSj+x9YaTeo0M3HosSV4imgbfxYfojYpa21I3r/
	K7tSI1P/LZQxtF0TFGDCHxAH8DKK7VMsKvfd2n/jvJVFrssFbRZfIej29tGrEQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Dec 2023 13:11:12 +0100
From: Michael Walle <michael@walle.cc>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 jaimeliao@mxic.com.tw, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mtd: spi-nor: sysfs: hide the flash name if not set
In-Reply-To: <20231215082138.16063-4-tudor.ambarus@linaro.org>
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
 <20231215082138.16063-4-tudor.ambarus@linaro.org>
Message-ID: <15561027b3896faadfc34274df76f533@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Am 2023-12-15 09:21, schrieb Tudor Ambarus:
> From: JaimeLiao <jaimeliao@mxic.com.tw>
> 
> The flash name is not reliable as we saw flash ID collisions.
> Hide the flash name if not set.
> 
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> [ta: update commit subject and description]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Great!

Reviewed-by: Michael Walle <michael@walle.cc>

-michael

