Return-Path: <linux-kernel+bounces-80000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76DE862981
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A52828223F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53826DDC7;
	Sun, 25 Feb 2024 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGA2qEKP"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFF101D5;
	Sun, 25 Feb 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844012; cv=none; b=tREV5x/IfEGndATbnpaZLooWxMiJ80TKvw3g4GOBjBlsUcXQ7ROI2MUqEl9ATAA8et3IVjwS934XHLHtQU6zqmN682T70bdagir20jX21phXTu3Kzzdqp3vBri87TQsVycUBQRGjGsXxigEU2f5zv2I0Bv5h9hSuH8lknNDZdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844012; c=relaxed/simple;
	bh=m8UmET64JFRSVNpBc2wrAPbmY40xINLq85Nvqqp+9Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tl9HyrcPBTAUoO0/nc19VmqUnSLCCiX96hSjYYDZOYP4JTxc0KHZlb+EvKex+8yiNrMk98pQ5LO+xTKdS6MqjvptVfEzeq/szAbOcUFLD/akeCsRLDSkuFQ9QO+l6FJkLPNNxs0Nc1TbpOC13QZb0+em2tbTgqpqMy+Q+LIvNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGA2qEKP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d8b276979aso1669740a12.2;
        Sat, 24 Feb 2024 22:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708844010; x=1709448810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7qId9+jfJUCqQ/SkIwlhCGmFKyY/JbOZZwyRJiXokA=;
        b=AGA2qEKPXCMf8YPinvafslkMF+1g26gQYmAeAdrKtfSiZlz1WiKyzKytvmwJBIv4O8
         5I7Lqyoc6xGAA0vByoLLONPH9+tQ0EUu9w7pnUBw7epYqMLTDc5hImYehFPtSXYtMdwA
         Gp7QHYTBl04rb7JaPtaSUxNC7YOY+b5YXM52y2O4tv3bvQA9FfpNu0tvyvq/JtS3udyf
         IgWur/pJJEu/lRfCQntcDhEzft9DOGw4wg/igsF/PzsYRbgL0HibwftE7jIrgdzwvHHI
         fU3mhnMoBEt4qoQ93McBWa7k1S8OkQJQIVBvX/zTlowcmScCN7/IWF3r/JJ6a+lrVAEv
         Mkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708844010; x=1709448810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7qId9+jfJUCqQ/SkIwlhCGmFKyY/JbOZZwyRJiXokA=;
        b=OZy0dZGzZn9sdXavUgsxPd/5ebiMPBI7E2aUwAYW//VI6kKLaEuCwdXo4nwV5vnR7r
         IVo6suyNTl/UREGaaXLu7+5rKo5etPgYJFeeAvzOCK0bLstmNtwfaxYDMG3QYNKkZyt8
         rUVkRv6CPBxzuTEk/6hgK062S8r2LvGCJha7tqFXdOpV1pBwVTnxe5vYwUAaAgerkJGe
         oVtlzBI8z+Oke2oDZg/QFfQJbGvDC0hZ9LFj4v3fgwSH7FdaU2ht12QpccNw8TnQ2i4+
         ayXWiAkYD8usBVeMdQOqvDMfqtgO4n6c6/0+dy+b7PNudoztWdbX9MBzt0olriyZI61O
         BKrg==
X-Forwarded-Encrypted: i=1; AJvYcCWfjm8e+fPRAOVnYT2tKkRHkhWdINhFdC4ObtB663w+yNgtyxoCqVhKho11+q2KvrmiqpnQklmJTa+rps/Ol4aHScV/UG1dcMEIFtxS
X-Gm-Message-State: AOJu0YzfsVtzZ5pZqbKzmjC5EuxZFqRoRzAUXbpEpjvyIqyQZ8GwZI/u
	v3UA7Rklkq7cvGJ4fnm7EDm/X5oXYlLhmPdJwjD0CyAMnVThmzqqdkyfhabrre1JPw==
X-Google-Smtp-Source: AGHT+IF9chCDge13Y4Lr76jCHJyZtsaC56UwXBqQHpgUdUxnkQ9sU1Q7D6+Pxbo/AX79QRPrGdiNWQ==
X-Received: by 2002:a05:6a00:1816:b0:6e4:65e1:5732 with SMTP id y22-20020a056a00181600b006e465e15732mr5347721pfa.18.1708844010189;
        Sat, 24 Feb 2024 22:53:30 -0800 (PST)
Received: from localhost.localdomain ([171.218.176.26])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a0026d200b006e45b910a98sm1930313pfw.6.2024.02.24.22.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 22:53:29 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Yang Xiwen <forbidden405@outlook.com>,
	David Yang <mmyangfl@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/13] clk: hisilicon: Remove hisi_crg_funcs
Date: Sun, 25 Feb 2024 14:52:19 +0800
Message-ID: <20240225065234.413687-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225065234.413687-1-mmyangfl@gmail.com>
References: <20240225065234.413687-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After refactor, no one use hisi_crg_funcs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
index bd8e76b1f6d7..db2324309d41 100644
--- a/drivers/clk/hisilicon/crg.h
+++ b/drivers/clk/hisilicon/crg.h
@@ -11,15 +11,9 @@
 struct hisi_clock_data;
 struct hisi_reset_controller;
 
-struct hisi_crg_funcs {
-	struct hisi_clock_data*	(*register_clks)(struct platform_device *pdev);
-	void (*unregister_clks)(struct platform_device *pdev);
-};
-
 struct hisi_crg_dev {
 	struct hisi_clock_data *clk_data;
 	struct hisi_reset_controller *rstc;
-	const struct hisi_crg_funcs *funcs;
 };
 
 /* helper functions for platform driver */
-- 
2.43.0


