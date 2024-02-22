Return-Path: <linux-kernel+bounces-76149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8568F85F381
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D101C22DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D82C6B3;
	Thu, 22 Feb 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDm6difF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4092BD01
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592013; cv=none; b=peyP5Urxye8qcFJgJfmf6bm3oeOEa9EkiXJYnXhrSixqhBloEO3+5aBG9SRFIT5CrQNuDzNbBDeGLUD6sYuwjMolE/OvHK1Y00eJ4DO9/c59iEMBVZ9Kd7Lif+2h/8xoEWpMjqaKkgoafeei8mOnsLM11x/oRF3EwLoejpgwIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592013; c=relaxed/simple;
	bh=ZaCt5bs1UxqZ+qs7mRxsARXzEk6hn2SLa2V4crMdhUM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AV5OMDojnRZvs57URwZeuoNghCMGyncOJ7ueBsKYyi2uQy+M2/z9U5GX0UMOpjBPAir5dQ309A0GwH8uMiTMUUCa55hvC3a6Iax0yCuPm68kj64gntXqj0a4BMuc4BlEKSdztUl78ygmCwms5TAA+eD68XW7S0eMWhYt2VqcVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xDm6difF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4128cfb6c1aso517135e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708592008; x=1709196808; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8UwvKUddBcDJ30OeDmpxIggbUMABYM5HCkJJ/iLXS0=;
        b=xDm6difFBcWSEyuvXXoDsoqiFLZdL3NzdU/UuBsGndv2Mmg/uPH4rLS8x0aqFC9+k+
         5eUXBb3QE5PChvwEGTgZFkJH1Yj+bOEGfIJ95uXpF4wlNDai6v9yyiofhVr6/HzJ4+Rn
         peBXmmxvH2+vUD73jqEfMun9DxWnjQxKxXDMZgXo18kDL6QseVutB+YziB322xXrzP3o
         5sGpXOxoDsb4EHfVSoTkoQASwDdXAODUqRoJ7hn3BKYxHvyyqU8KTnaETkYTNpwyl6nw
         mlfFQs+HQqD37jpQo6H37DiGxHm5UGXw+G2UonN87FCtzuJI98z+OUGVjoHvr3Nnhe+z
         9IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592008; x=1709196808;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8UwvKUddBcDJ30OeDmpxIggbUMABYM5HCkJJ/iLXS0=;
        b=jBH78kD+t7TlE637k78gQt/BVDbh8QWPWJnUWTCASs+BVR87GTwwFUYOLdIzu7CWZu
         2FnVD5hKo28BVW1l3/Z5bRbfsfkW8yyGsrRgcf9JSxLMWuRCu6VJ++nSfKi3yp6TO6kr
         q/TAJgDZhMB9dIVD/Jt2O6m8MtBz0ITa/hneaEdlrC4jv7i5kx8stR3vG3xt8DtJPfOL
         grUkL3B6ZlxRZeyuepMCNrLN9mQC09LDtnJGA/Y6LpQXTi/XY8MrcQ3uFjY5RZIROHuL
         PxZ3FLC52Nhn0LCtqsfeC4SKzEdLCrZGFt9kLUl0IJE5LL6xuVdPvI88xww7z09ACwhT
         L76w==
X-Forwarded-Encrypted: i=1; AJvYcCU5KgETQim6Y0Zjgfjl6bXvIGDEmx4dCYiJvv9PBHXwl2qmMZ2YblHmtTWK6K6SYJCTy+fEp8aa5ryAAGKhh+c986vFdneQ7TxieVfX
X-Gm-Message-State: AOJu0YxM5hpqYRQ7bbflBxmEot2u2rJ5md+YHey1/ulwtOSjDk9CQg9L
	yXHk57kXG3mREy6RilA8cRik1FGPPNGM/a+JOnvVLpZEXyrAsGN2hD8r/KOQ9T8=
X-Google-Smtp-Source: AGHT+IHnOo2I7r2WPEzhWOsfF+Ao1GprZINhZylx6l+TcqIjYU4pOyVZTVFPvaORJc+oMQDaGku7AQ==
X-Received: by 2002:a05:600c:4fd0:b0:411:d929:6e12 with SMTP id o16-20020a05600c4fd000b00411d9296e12mr1464873wmq.17.1708592008662;
        Thu, 22 Feb 2024 00:53:28 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b00412590eee7csm18262233wmq.10.2024.02.22.00.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:53:28 -0800 (PST)
Date: Thu, 22 Feb 2024 11:53:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Torsten Hilbrich <torsten.hilbrich@secunet.com>,
	Nick Dyer <nick@shmanahar.org>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brad Spengler <spender@grsecurity.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] Input: synaptics-rmi4 - fix use after free (more completely)
Message-ID: <e77756aa-c0f1-44a8-bcd6-a46fe954b195@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

From: Brad Spengler <spender@grsecurity.net>

Grsecurity uses memory poisoning and detected a use after free in
rmi_unregister_function().   A fix for this was merged into the
grsecurity patchset.  I detected the user after free later using static
analysis and sent a partial fix as commit eb988e46da2e ("Input:
synaptics-rmi4 - fix use after free in rmi_unregister_function()").
However, my patch meant that the grsecurity patchset didn't apply cleanly
and forced everyone to re-visit this issue.

The bug is that we must not call device_del() until after calling
irq_dispose_mapping().

Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Closes: https://lore.kernel.org/all/1932038e-2776-04ac-5fcd-b15bb3cd088d@secunet.com/
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215604
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/input/rmi4/rmi_bus.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 1b45b1d3077d..02acc81b9d3e 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -275,12 +275,11 @@ void rmi_unregister_function(struct rmi_function *fn)
 	rmi_dbg(RMI_DEBUG_CORE, &fn->dev, "Unregistering F%02X.\n",
 			fn->fd.function_number);
 
-	device_del(&fn->dev);
-	of_node_put(fn->dev.of_node);
-
 	for (i = 0; i < fn->num_of_irqs; i++)
 		irq_dispose_mapping(fn->irq[i]);
 
+	device_del(&fn->dev);
+	of_node_put(fn->dev.of_node);
 	put_device(&fn->dev);
 }
 
-- 
2.43.0


