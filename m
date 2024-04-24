Return-Path: <linux-kernel+bounces-156812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7F28B0880
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8AD1F24162
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A505E15AAA2;
	Wed, 24 Apr 2024 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9ciplj1"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6D15A492
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959016; cv=none; b=XOqft5+JKIJgRr+Mi5za5oGHX33Q6o4VECliytwdgjfjBt3Tfe62CPjh90ppW/tkwIOCud40O1P/1BbylS3EZuytyhMBjjBC21ir/0KPJWU7my/4sCTTE9w7EaaFN+1Wew/3qQvnGtufFdLWtvRE9+mqzwgYJzZTxW1MNoFwCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959016; c=relaxed/simple;
	bh=3lahgNJKWCq8KC5g+5ZgzQuCAxnQjDYOSrfMMIwSLEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RF7m3jNytTf23iKpRP3EM/wXNDFxihrxW21CQALHdcz9b2W8EayT1x9liB2zN7XaDJmLqn3QhnT5Y3RuucM51ZwvZJn5phCtlL5UzhPHlYJUt3fX1dJVhzNXP2ny+OXA+YJAtwJ6af3CkC9wBRaAtUrsalM1e0AJuYBLYJThZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9ciplj1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-346359c8785so5605208f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713959013; x=1714563813; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enk6u0NWo+HjAlsfAsaG/0BOtgb+vI9MCBxWfkbUG6A=;
        b=S9ciplj1WmOukhP37Hp8Wrm578H09XEQ6GyoP0T+kl/4SRcQpWO088i6qjB1hmz/oT
         4AEF7pmKVJBvWIyhmU8JAv37zT9qb9EpIp7s61fjkBK2yUzDb6KFstt8/T25WCm5u259
         XZxNUZwiJoB1Nq7z8PhqP8IxswDY5wW/2wUoOrGuW4DzhgPna4i5SYPdAHgBDbsTSqQE
         4ojj7oNpcPy6fR/r5ZVHL652uyuwFpo5hwoMOblezGfLdd/fYR+HHxb9K4NAlD+wU5dh
         qU5bttUk2Is5HTDlLz07+vYDfp+y6ChV3VGLKB/zUnQPirlFd3De1BfzGbAlpDKnaduH
         jUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959013; x=1714563813;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enk6u0NWo+HjAlsfAsaG/0BOtgb+vI9MCBxWfkbUG6A=;
        b=Dv3nkXVMSJxklrTpzcPtVCU869Lvh4fVeXVCexRQk9FLRtn9lJRMOl28rvKvfrgSE4
         mROFBpPWQJKIS5kL1m13DCOeU+lYrRHor+LqGx2mxCy0dhTmyBhVCaX+u08UA/8W7zZZ
         cMxwo9uFxKTq/T3OmlcQ55ml7mAwnFiXcNicnRdmjAOxUXm5wa3qCDg4t0vuegDFHdHV
         EkVAXJXp4sw50+mQ7LEfLvNrqIcVWIU01JQQZmCkSfKI1UsR+econnZAJ4d/qNX/PsGX
         LLDtFj+14r0If4pQ7GnEcWGGhTGNevBMiF05FXGTN0WcJcuKg5DxhdE0T/9am7tdsH+S
         q3PA==
X-Forwarded-Encrypted: i=1; AJvYcCWywoL12Zpn+9nO0vVddv+KJQjHeqh3lLMT95FS4BJM9sdQBmOqHw8hG9xHX13sjrbGQ8TfrAGqtlmK162ePopYAs/MTlC3fagHA7K8
X-Gm-Message-State: AOJu0YwET64iMz7NkSmHoAoqXWUecwqM6OMw1JZxJBrAzWKcuvtK+eyj
	xr0Qs658FGKsjQwtRkZpMs+uekOBG+p2qBQl3hnUfLKoNoxrXJ929usCEaDJqwk=
X-Google-Smtp-Source: AGHT+IF5vUsuDt3b5kATjhz13YwMUbFsgUZ7ijQ1OWYZHfaNiPIFT/g4J+dEvQgjMaMZVRjTozCIKQ==
X-Received: by 2002:adf:ef43:0:b0:343:4b39:9dbc with SMTP id c3-20020adfef43000000b003434b399dbcmr1447812wrp.42.1713959012474;
        Wed, 24 Apr 2024 04:43:32 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b0041b0d4e1c27sm1442161wms.42.2024.04.24.04.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:43:32 -0700 (PDT)
Date: Wed, 24 Apr 2024 14:43:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: vc04_services: Delete unnecessary NULL check
Message-ID: <526ec2ff-6277-4d5d-b2d9-63b087a97c7c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "state" pointer points to an offset in the middle of the "mgmt"
struct so it can't possibly be NULL.  And also we dereferenced it on the
line before.  So this NULL check is pointless.  Delete it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c    | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 9fe35864936c..3c63347d2d08 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -1170,11 +1170,6 @@ static int vchiq_open(struct inode *inode, struct file *file)
 
 	dev_dbg(state->dev, "arm: vchiq open\n");
 
-	if (!state) {
-		dev_err(state->dev, "arm: vchiq has no connection to VideoCore\n");
-		return -ENOTCONN;
-	}
-
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
 	if (!instance)
 		return -ENOMEM;
-- 
2.43.0


