Return-Path: <linux-kernel+bounces-3538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC047816D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C041C23624
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA544F8A9;
	Mon, 18 Dec 2023 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="C0/i3W1H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4724F88F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id E2CDA5D4;
	Mon, 18 Dec 2023 13:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1702901300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwcO1HBrnFwN8fglAkiHLgkaZQhaGL5lpJAofpl8yGQ=;
	b=C0/i3W1HJqGA/xGB87btawUYMulwSBCFEBftHUhENNGHigDOh7XljFj5RowpxEhBKOGQgs
	gQhgl6J57D8f+YkRUiEoyWzysk0c+edKLmnwvm9cp057ThGZsZmoWn/Pw2LPa07EUehyau
	hhriBJmCZFig1xq0mwTHFoWaMyxHIBu1InZRLT504j6ExvgKc1C89yEpc3yqeHElUgi5br
	Fqh4lCGCF7A7HN6evQun9BuRWvg+UTJJFhyBowh8SxNy1o/2KMalMM61/0IwBJCnWDtVfx
	K2Ck0Gjm2OUFrNgjqz+O0QsnFggN+OAkP2xbkJnNWZb+5KootR1/ACHMnknKxA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Dec 2023 13:08:20 +0100
From: Michael Walle <michael@walle.cc>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 jaimeliao@mxic.com.tw, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mtd: spi-nor: mark the flash name as obsolete
In-Reply-To: <20231215082138.16063-3-tudor.ambarus@linaro.org>
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
 <20231215082138.16063-3-tudor.ambarus@linaro.org>
Message-ID: <5603ba319b2a89e7373b850792c6090a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Am 2023-12-15 09:21, schrieb Tudor Ambarus:
> The flash name is unreliable as we saw flash ID collisions. Mark the
> name as obsolete.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Michael Walle <michael@walle.cc>

