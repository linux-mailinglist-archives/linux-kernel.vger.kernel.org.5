Return-Path: <linux-kernel+bounces-42791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994BA8406D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A621C24DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89B764AB3;
	Mon, 29 Jan 2024 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByjR9RCx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1A64AA2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534767; cv=none; b=h6G2pw7DT1K8VTHneXiHYZDXyx0euJP/2pVGycQ8cY0XuVG4bcVGriQnC37TSlJNdrwCGWOdnDRNpMbOVg0ZwAvoGQy/PWSm1eXXkaFIfqE6AJLYFICzXhETGHJq++2UsWM2KxHbOosMq5tjQkpefXOvnRpWRkBVT4fXyrtjiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534767; c=relaxed/simple;
	bh=B9azg97gvfK4Td1aCifOHkTCJtHZ+EM7jryOwYC5Ivg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QrcGOKlyvXFSKk1bu0KdbViFKnA3b1aYimlBGNilYghBATQ7U5xKMZ11CJje75Zw26CmClPPXeG418lhrBnQsu7UE9I9zNPbvIiwsaVGJq+Z5tH5GihkisRIjh8Wpen84YQDCbGasLl4pnB2Dre0XZKUgdq1A5au0xwKWosPUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByjR9RCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174E0C43399;
	Mon, 29 Jan 2024 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706534766;
	bh=B9azg97gvfK4Td1aCifOHkTCJtHZ+EM7jryOwYC5Ivg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ByjR9RCxWhEtabgn2vOUB7EC3aJJ8x3MBQ90aw3vtEhiMXUF55XbpKOCMg0ZSZ1xY
	 WW0232pOokov6MLkD0AGziMEm5pDXng4CzSewP+QfNHXEB36vwAQS64NWFmmy0jncB
	 mJLzK3uclzRi/QMLSvipNaJ8ULKwmfKBv2YDQDtXciVxFseAzSRdP/gOD4bVWFjEfi
	 zlToiDyEy4byiQZjUmQS4qRzRi6IznUNpRs8g2EiwdxODd8buosk/w6NwlQEOebrXc
	 v6vSNkN1eMo27LdVpb4Y6atEz3CwhSZM8KchbDdQiOhisubQwCuS8zQ6CBD4NOoEDr
	 6wCkIcSM87IGA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org,  michael@walle.cc,  miquel.raynal@bootlin.com,
  richard@nod.at,  jaimeliao@mxic.com.tw,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: spi-nor: drop superfluous debug prints
In-Reply-To: <120bf090-0c07-4971-a18a-a1b326f1b139@linaro.org> (Tudor
	Ambarus's message of "Fri, 15 Dec 2023 10:24:42 +0200")
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
	<20231215082138.16063-5-tudor.ambarus@linaro.org>
	<120bf090-0c07-4971-a18a-a1b326f1b139@linaro.org>
Date: Mon, 29 Jan 2024 14:26:03 +0100
Message-ID: <mafs0v87cs238.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 15 2023, Tudor Ambarus wrote:

> I missed to drop some unused variables. Will drop them if everything
> else is fine.
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index a708c3448809..92c992eb73d5 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3492,9 +3492,7 @@ int spi_nor_scan(struct spi_nor *nor, const char
> *name,
>  {
>         const struct flash_info *info;
>         struct device *dev = nor->dev;
> -       struct mtd_info *mtd = &nor->mtd;
>         int ret;
> -       int i;
>
>         ret = spi_nor_check(nor);
>         if (ret)


With these, 

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

