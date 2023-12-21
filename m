Return-Path: <linux-kernel+bounces-7790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8935781AD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9771F24C38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23718AD5C;
	Thu, 21 Dec 2023 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0656Vdf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18E4427;
	Thu, 21 Dec 2023 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so2359695ad.2;
        Wed, 20 Dec 2023 19:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703128188; x=1703732988; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEgF2ZhQjQOKtPApvRdmEAY0ycPOACRB4YXgq2azI0w=;
        b=M0656Vdf2IXrBqGxE/FSAqQr+t8qlb9ws4wDm3l4iKK3zJ3z952AMQPwxgO+l+wJ7G
         6/YwvWc8zJQUA92o08ATAdGRObbFJPmbDuGDGB40nlPdM0E40LOB6mlxRSC6K9CCGR5K
         STIVYj48ZqUxak4EKRH7cuLVb0CJdbCB9KxYjoB5EobuLmEuSSrAYk0jQLp8cT2Lbvu2
         rjv4lFhWnNIaDhf8FIX+/2Id8+p9rXofIzDuxsR4hND0WbuvKiBQM0w4QxOxZE3rFk8o
         XnueDt0s7593GS/FLybueDx+5VHXiNll7F7a+nU6PZkKnIvR6OrvE6bH1cBVEv0ieVfF
         9BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128188; x=1703732988;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEgF2ZhQjQOKtPApvRdmEAY0ycPOACRB4YXgq2azI0w=;
        b=V7m9m6wy829sq6ogqILEq5n1Qo32rCfYPJOho2JGg0LNp7/8xFOqk1xFhCzF9b3X7O
         4j1KFVVqWyk6P+jKcUCcmHs+nNdi6mMua9va6VRshvEvwYoeOKV72oIz2f3pAOxIDUK5
         3M+r4UU89Yc0WmRXQgGS8UQEHq8QZutVgWWk+7ye6D0bwg2qt8uVtjzWKKn87M3DsqFJ
         5t9Kfk76XWUv49W6tnFdDP7DDgOfB4vlqgpYkZfhv7bT5uEkTohhqI3uyshDP9XJ78T0
         bTQczqP1O/WU/9N0N2RC6FJWIzgujKeYYdqyCpIwzSJvJE+TJzxEUkvU53PTXCq8rFzM
         L1rA==
X-Gm-Message-State: AOJu0YzElWWEzJ0xv9p0RMFkM82FlFmFE55RCKPXaqHpXccjG8dE4oXD
	rb3wm68ehZ3xH48cTmVfHwI=
X-Google-Smtp-Source: AGHT+IHRGnHJwpjCjQ1miRy1I3XQd0E899CUD1DA9ShKDOU01VPjvm1IYa3AeF6D1GAqlv8eOeyXQA==
X-Received: by 2002:a17:902:b60f:b0:1d0:711b:c926 with SMTP id b15-20020a170902b60f00b001d0711bc926mr11313301pls.110.1703128188252;
        Wed, 20 Dec 2023 19:09:48 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9d7:3461:3155:35d4])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b001bb750189desm434145pls.255.2023.12.20.19.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:09:48 -0800 (PST)
Date: Wed, 20 Dec 2023 19:09:45 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: da9063_onkey - avoid explicitly setting input's parent
Message-ID: <ZYOseYfVgg0Ve6Zl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

devm_input_allocate_device() already sets parent of the new input
device, there's no need to set it up explicitly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/da9063_onkey.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index ce499c28a7b2..c338765e0ecd 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -211,7 +211,6 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 	snprintf(onkey->phys, sizeof(onkey->phys), "%s/input0",
 		 onkey->config->name);
 	onkey->input->phys = onkey->phys;
-	onkey->input->dev.parent = &pdev->dev;
 
 	input_set_capability(onkey->input, EV_KEY, KEY_POWER);
 
-- 
2.43.0.195.gebba966016-goog


-- 
Dmitry

