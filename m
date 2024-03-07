Return-Path: <linux-kernel+bounces-95939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728CA875524
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0231F211C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1CE130E5A;
	Thu,  7 Mar 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N5PPEM0F"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7E130E21
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832521; cv=none; b=pzSAUGHA9T/KrSy9oguU7fm1GIJNsMuiKt9Jg9QWODY+eQl/4mZmyHeIUo0J36cV30i5rH1bGAHJ1W7shwtrclmW1WkoylocBk61sp3nd1BSv89uP1ZbBqSC/TbN8iEUnMNvIOgFRJqGCYUj/SKJkG7Fk4ZRctmsjBxEH3qlD3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832521; c=relaxed/simple;
	bh=4lDoHYX0TvX4bymJ8Wv6sCuZkW8lKik0jKb18/2HFQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1GcJ2SBQHBgAD1ilCCWTMV1s7kxZu+CJacFvdUxXJ7XELJtWjALJwb/azWo8BElVthkANd5JTUu17axte2+yK1kytRd0su8hNwwU2nwplXFajSHe3BQ0r3iSmNTBNxyPdDykYvkNQ9UcuPucPy4ZI7Nz4VjqyzrFmcGf2ZWoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N5PPEM0F; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C397D20005;
	Thu,  7 Mar 2024 17:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709832517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q21DLTQj0SvAQbvsDh1KicDozRTQwOzP95SJqpPGBGw=;
	b=N5PPEM0FilHp2agp8St2TXpGgvFLXB17kbldpeIjASzZ3VL3D3s2E5pUGt+te7ZspetCP7
	GGTFQHm33ttAnWGPoz1iehSR7xIGSS/cqoqqMLpPNnbekk+huDtyYOV9Cl4XBg7UmTpp73
	FAhluhXKkf9P2o15/W+XiNocTAKFeZPuNUESpjgX0+JdRl+qza5saoGWqJMZmMTkx8aNfC
	2nci/0eWvA/7An4GYRw2CnGARVCvRxZgOGgI8NXwFoLF4Hs93pU1wcetdexpMEw5WOiQQP
	pja4vxDDgl+SmLTpIdJuVsnqDMfK7px6Yq8x2NkE0ezRPo6TEc/IyskJJOZhJA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Dahl <ada@thorsis.com>,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: raw: atmel: Fix comment in timings preparation
Date: Thu,  7 Mar 2024 18:28:35 +0100
Message-Id: <20240307172835.3453880-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240226122537.75097-1-ada@thorsis.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c52f6062fa3d93eb033cfc38cc56c34976df1258'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-02-26 at 12:25:37 UTC, Alexander Dahl wrote:
> Looks like a copy'n'paste mistake introduced when initially adding the
> dynamic timings feature with commit f9ce2eddf176 ("mtd: nand: atmel: Add
> ->setup_data_interface() hooks").  The context around this and
> especially the code itself suggests 'read' is meant instead of write.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

