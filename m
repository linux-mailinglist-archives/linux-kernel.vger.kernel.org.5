Return-Path: <linux-kernel+bounces-51252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C0848851
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577C31C214C4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3213AD4;
	Sat,  3 Feb 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="aqvKt7Ro"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A397E604C1;
	Sat,  3 Feb 2024 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706986911; cv=none; b=DQmwJGbyxZgfFijt5YE0c6RRyYBALikyD4bTElJc99SqVNW8PkzvAfOqnrbhE4GaZ4eQBnazyJP4HLpzlRxgV8eSsEgip9wneDCh71ii35XEyr3f/XJ63w24fzyaED/QEESZPpZlTPpvBhLP5/gquAtlUmd3rHsZ6pYU+vtqOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706986911; c=relaxed/simple;
	bh=pc1HhvzRk6bVkjI2bt/w+4XjgJvrHjEzJv9iDLQZGSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DH2H1lwNGZkyuWxuhF9Z3tFmXfWq5AN4ss9OacYPiezoi4uSz/BKRX34wYjWAMPofFBfoQDpKiI+35Mobpiml31b1o06SLEtUaFtxqBU5/XOxVFp/Ty8ZdZgXNbxAWOPEX49JCFgLStnfeBxCx/Oofbdxf6bU3EiJ0Qheqab1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=aqvKt7Ro reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so2558228a12.0;
        Sat, 03 Feb 2024 11:01:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706986909; x=1707591709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvUYUdcKAB7i1BmNOiCXEGj+jeIkzeweygwcC2BIi2w=;
        b=g4WFmspezzk6mdW2PQwqJoIn4uU7Lde+2LSq0XTPvQLezZxfMHHcmmcSmkmgiE/Tiv
         6brdA5ldxnHQd12RykARR5XqYWkuc1KoWtUE77rUQxoepuOKvtpTXN4cqqVPz9Q+drfZ
         BfmWS49Mdo5xpy9/F0iyx1h9y4Nq6R193dwY2XqOO2guWFOgvBSsk4z7OoiuFhyv44Rb
         Nl3s9S/84RQDfRUYxNwf3ITpyo7sRAjr8QUZUi2JC7kykex1wCQuF60idVSnKcxBU8J+
         9N10cCCQqT36YVmYnuMMSaQR8h4yHkFGPqRHVXy3oUtHNXjO4rLQcffHGhEuS9jMKDfo
         l4Fg==
X-Gm-Message-State: AOJu0Yw24TX2fOBed7pKaO31J8EJsR7+wafr/cRKSRmAKgUtNuE3+iHB
	YNyg3csqlsSf4j8cKHHOoiB4cvN1ZMINqQXEQmEQMGVJUaGqLba/
X-Google-Smtp-Source: AGHT+IHQcx0ElYKTpISXQiRUQKW2on0cYCGmnCIJj+F1wk3fXMuVCx+L22V/+kUno09HnaH2IsZwhQ==
X-Received: by 2002:a05:6a20:2002:b0:19e:2d04:d775 with SMTP id w2-20020a056a20200200b0019e2d04d775mr9936452pzw.50.1706986908925;
        Sat, 03 Feb 2024 11:01:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW4OTlsi1HyxI3PLI7hQ+X9ZXZx6uyR0sm1KT0qfR9TMHnwID9ksYus/q05JbFlc61xtZsMaVgPs7NIUSAEMrx1u/7gRk5vSQJISVTp1xGyLQf9/Ioe1nM9WyMoeqFS0IeOTaUd4o0Pfw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id g8-20020a056a0023c800b006ddb0b0ff0dsm3709285pfc.34.2024.02.03.11.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 11:01:48 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706986907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvUYUdcKAB7i1BmNOiCXEGj+jeIkzeweygwcC2BIi2w=;
	b=aqvKt7RoHdlFIDUfTUnOallSYG/3P2+qO50BqcqkfiD1c2ARIKo/2dMvSSJPpHauKPfM47
	l00Nbxn7a2T/5oOJxQGlfCh725eXbA8Lt5FGU9Der1TadqTe4yC1E+HYfhwjc3WQxkSAH0
	ukZwsNGyP5O7Iifq4lUFD7F69rstUzruPP//e5LQkca2jQvbRqx+/SeT1SLDCjJfMvR3li
	/BiHiMvPQSE7UzhYwf3IHVkUdGG/RzWftOwvIp9zkMITL9eFQXSvH6CQY5jbhbWcDlGuYN
	fyLwX+KsyVTgEBv1+hP+Jhb3xBZ0wQSArtCE6MJ9QOTPbAfl5vGgF/aHHUmihw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 16:02:02 -0300
Subject: [PATCH 3/3] mmc: core: make sdio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-mmc-v1-3-ad054dce8dc3@marliere.net>
References: <20240203-bus_cleanup-mmc-v1-0-ad054dce8dc3@marliere.net>
In-Reply-To: <20240203-bus_cleanup-mmc-v1-0-ad054dce8dc3@marliere.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=pc1HhvzRk6bVkjI2bt/w+4XjgJvrHjEzJv9iDLQZGSw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvo2tB3tOqyMU8SsV7StMoRxOveA3ODo7JEhBY
 VGjCWVRelKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6NrQAKCRDJC4p8Y4ZY
 poNsD/sE40XxGtnSVrN1fTksGb11kBzPb0q5thJjgKRkoJR1+2B0nSvBQZdIzlDLXFOAZZIuGzB
 JefNzg82LHgZBKdx6XGmPbLwLijrxwynzHlr9630XXj2xKKbzKEZzvwpHQrT9Feu5hdAX9Uu50V
 ZO7/FzgwST0nlhK4InUJVLEDDpJgHVEUQXaHzh785QG7DPGgX8ZFetFaPyPkbdMOUVd26gGnEri
 qR5/qsOYEj01Sh79b1RTEtil8wW18o4o7yRUIpqkiAGZBnwixJiAdT+VdWtWRB313JF9aGbJDnM
 vS9vJVwzPQxGJgcvaMi82QbLUZeY/dNxgs2h/Zns2HuyEaNpnqSAm/OGa2NVjBbJKekILCHo3y+
 atRPMpi3mq5zTaTg2itt98V9CewMk8NDXK97mwuwROcgOrPt1BUUDErtdelCC38fejueFdBgCYt
 tAHVq0kb1p2oVvgZfq8HTToQh2shgSOkAabDvo7/+o9FD06yz8U9nEUFL9tIY2pSf7QcbfemgVv
 vhVJmggSEqctgtHRx+fd8okTggZIdYqFdNsh1KrSKmfM4Gtic2LRuvsyGDuwqZheuSBPttu8MzU
 np1xerv4HdXOMzdyMAcJDZrGVKmG5ftZr/FNA8xFxbMa5STZr/rxlSR4v8UxJ1HKQ9X1Qj9/Io/
 IioD916PDiEBX6w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the sdio_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/mmc/core/sdio_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 47a48e902a24..71d885fbc228 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -244,7 +244,7 @@ static const struct dev_pm_ops sdio_bus_pm_ops = {
 	)
 };
 
-static struct bus_type sdio_bus_type = {
+static const struct bus_type sdio_bus_type = {
 	.name		= "sdio",
 	.dev_groups	= sdio_dev_groups,
 	.match		= sdio_bus_match,

-- 
2.43.0


