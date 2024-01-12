Return-Path: <linux-kernel+bounces-24348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E22082BB67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207821C24FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886A25C8FE;
	Fri, 12 Jan 2024 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IrjQh1wM"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18042A87
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso5376880f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 22:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705042588; x=1705647388; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9prXoTbAmkoR0CZO9d0SNqMhaDHqa31k4/WzflBN+f4=;
        b=IrjQh1wMctaMiqlMKDXXjr2CzSqAu3HFdYdyugt2MgNsDOmB0LNVorGBlYIFtLHqP5
         UD+lib05Tcym45i+C6gOKXF7WYMiZGQJVOAp0zzh+hnEb1O5Oo5O/KZW6CF8y4LYDmH5
         5M8xjEPAtIysW4FxEk/jQ2QKRXCcj26NxNX44hsuxzt6lgnc5SIbsnBvi1aUGWCDaTAx
         IEvGwEHyYCoF4uGpln/xlvy4BmkF6UbOrr+mky2xjaa0KDY9fOL6wTN6uWsNybXXPlI/
         A6aT8o9hihZzds2B3MfbMiIvn8P0/iQisYnaU+7Gsnmjcgr84GRiWR6lap0P4GDn+i+3
         4Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705042588; x=1705647388;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9prXoTbAmkoR0CZO9d0SNqMhaDHqa31k4/WzflBN+f4=;
        b=wcdhpdwxAfrgbbC5GzRALup7p47QttWQnKQ4mQ6OF8UscZy8oezPsfigM7fp96Jkoe
         uu7qZNOZy9eR20YTu8PE+ggTddEUjMRAc/2aNklVDv5Y2UMWongfIeVh3Cur9WrmBPi+
         yw7fMjU5GeLRaYsUzT2S1V9nrZNPfp52w5H+m1CajDfFRd54DKJ3DA6kAuEjaGHrk0yH
         ezUeXlwdOI51CqD3qNFR4EXjBB1dUqBQ1ScQYJ2Qe2e4dD+1No/Mx1qPJGL1UTJyI7hL
         oowAh2kL3n3745Gj3df7J0ueA9eNxe1SzhdpCamc3rwaXBHULZQKDGeMHX+0ZI/RmxGJ
         K+xg==
X-Gm-Message-State: AOJu0YyZqjsA9adfYRMhIgc6TYZx7oQInTkWr8ygP7FNz0PKhv3rQ6P/
	LDfQf+aSKCdomsVrx4u1T1iZGm6q58b32Q==
X-Google-Smtp-Source: AGHT+IH6gsHGVIynSC4gedvLtDCTO7G8G5VIZut2PGL0yCvFoPazVS5ii5HisQkORg+7Nmq9Qnuw5Q==
X-Received: by 2002:a05:6000:141:b0:337:404b:1d67 with SMTP id r1-20020a056000014100b00337404b1d67mr447985wrx.69.1705042588682;
        Thu, 11 Jan 2024 22:56:28 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id a7-20020adff7c7000000b0033660f75d08sm2983461wrq.116.2024.01.11.22.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 22:56:28 -0800 (PST)
Date: Fri, 12 Jan 2024 09:56:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hans de Goede <hdegoede@redhat.com>, Henry Shi <henryshi2018@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] platform/x86: silicom-platform: clean up a check
Message-ID: <a58bffb7-0a8b-4195-b273-f65a188ace7b@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The error message in this code can't be reached because value is either
zero or non-zero.  There isn't a third option.  Really, it's nicer to
write this as a one liner.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/platform/x86/silicom-platform.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/platform/x86/silicom-platform.c b/drivers/platform/x86/silicom-platform.c
index 6ce43ccb3112..c0910af16a3a 100644
--- a/drivers/platform/x86/silicom-platform.c
+++ b/drivers/platform/x86/silicom-platform.c
@@ -256,12 +256,7 @@ static void silicom_gpio_set(struct gpio_chip *gc,
 	if (direction == GPIO_LINE_DIRECTION_IN)
 		return;
 
-	if (value)
-		silicom_mec_port_set(channel, 0);
-	else if (value == 0)
-		silicom_mec_port_set(channel, 1);
-	else
-		pr_err("Wrong argument value: %d\n", value);
+	silicom_mec_port_set(channel, !value);
 }
 
 static int silicom_gpio_direction_output(struct gpio_chip *gc,
-- 
2.43.0


