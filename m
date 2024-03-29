Return-Path: <linux-kernel+bounces-125191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759478921F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC4B1F25EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1E38DF1;
	Fri, 29 Mar 2024 16:49:58 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140E1C0DD5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730997; cv=none; b=fr+2EBEczrGxily58cMGr7vahhmfOQs2/PwI7qnIHgY6QsZuFdK9PjZZLwtlLv5cYrPgRhrPogaCJlgaZfEdKPLv9004jKU35E3MixDxnAJBtNk6+DTOA+ZAXOLMupkwak8GCt5YStxYxC+tN1ACf1mFswaYiiVMahOZU6nDNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730997; c=relaxed/simple;
	bh=5C20/ZKHXuSQJ16k3wCbs2KBoQaCmtX6xMsYneOWEdE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTquifqTzSWjHdWBcU9fC82SsWQ1QM66cfmwGXOUfU6DlvSguc8aQ9nsy1zBwHKCch7ZnQBaanc0X3BZDmmdTuhMhxRjRo83emdsLwiyurxNxCrcqPZyNuvVYspEIvzUBfVdMbQIF2tX+GJhr3zPeijUA+C5xi+rKnpsKBWPVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 5da4657b-edec-11ee-b972-005056bdfda7;
	Fri, 29 Mar 2024 18:49:53 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Mar 2024 18:49:53 +0200
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] spi: more tx_buf/rx_buf removal
Message-ID: <ZgbxMUF3wWdRBKqB@surfacebook.localdomain>
References: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>

Thu, Mar 28, 2024 at 03:51:44PM -0500, David Lechner kirjoitti:
> I found a couple more controller drivers that were checking if the
> tx_buf and rx_buf fields in the spi_transfer structure were set by a
> peripheral driver that I missed in [1]. These checks can be removed
> as well.

He-he,
84a6be7db9050 ("mmc: mmc_spi: remove custom DMA mapped buffers").

> [1]: https://lore.kernel.org/linux-spi/20240325-spi-remove-is_dma_mapped-v2-1-d08d62b61f1c@baylibre.com/

-- 
With Best Regards,
Andy Shevchenko



