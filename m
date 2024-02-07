Return-Path: <linux-kernel+bounces-56307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C083F84C884
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D8228468A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB93F9DE;
	Wed,  7 Feb 2024 10:20:03 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739242232C;
	Wed,  7 Feb 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301203; cv=none; b=FHcWZYjVtpbJnMqRmob1caxyC78ZQTdmRY8g9YMc5Le3lwDaCWw44eqCxrzwJWvuXYNfo9MgCY0VHy+JY7W4i83/5YPmqR5gEUrBlImxUWyyDcfXF3xYHvLDJlD0RcPHqXZonfgRqtBg+thldaqebDjEJZ0oAeGiUZ/UvaAqXeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301203; c=relaxed/simple;
	bh=ZIYJJskWurszPGjPRZpJUtbt1AXZlUpfp0K0t1yduDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CVD8mNLkQ1YKb3sb+AJWp8tr22PatMKQ6JBUSTz2wvN7+ATqPjRHTs8y73EN7oungt5jV1bbyb4svHc7Ujh5y9o6JfdqwyV+k4CqmddVwNLpNLDfyd5aKB2dpw1bPctJ9R9xPtqMoyP/6fXoxwBG3HIyUHToUk5Knx6RP7OI6mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5116588189aso742490e87.1;
        Wed, 07 Feb 2024 02:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301199; x=1707905999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PeYGuM2VzWmaP8pGOHtb0MhEd16/0MAF4k7QK8QyX8=;
        b=NIS0uXBc/A3O9NEdY8sTiwUxPXmyazMeNAhWN4Hn0AIRH3AVvpHKZjtfJ9/IZqDLpK
         2brP747V/zZog37FOY63a8XlbnIOo4BUa9vMDWGcINAsnJlTM6ob80SsHnqQhb7o8Z5q
         H2XgzS6F/u9uWcZ41YtJJPSb1xgCX2aPjc9yOxR6zgTOdblKRX9xpKQIwnA8s3dwr3xG
         4WPrHbir8qG/fm2OIyhLl2M+XqwOn15Oy7tdwvvqnJCFcYoR91vBEwoDooma4+e5NEIw
         k+cRIRoy5ngXcRT+LebWJ9Sg1YUxeDcvh5cWr6XBhSrWYpGb9FNNWJfIjLeCnfotnkyQ
         Vfbw==
X-Forwarded-Encrypted: i=1; AJvYcCXqaE5tA9p5lozJ3wjqTijTKAoAsP2g3eE12a8Yb/cWShuj6glV0hoOuGtwCCcWBAVbnVe5MRSN0BlIhnm+BDISFg1GTPomFHPJLowr
X-Gm-Message-State: AOJu0YzaO4TkIa/jM9tnyhB16/Yv/tqG/7eYmexaYRwK+VggyHxKS/R1
	Pr/IpBChqJ0MypfVwBYNNhiqsjWyGYbc74G9ohTzXU2K422YMznE
X-Google-Smtp-Source: AGHT+IFJfUPvqhYCHaBjDbiqHzik7FlqWyPHWDSh9+YHk/9V8T3UTX1M49MB9lEX2Vr1IGry9YsKDg==
X-Received: by 2002:a05:651c:20e:b0:2d0:a3ff:33c4 with SMTP id y14-20020a05651c020e00b002d0a3ff33c4mr3709585ljn.16.1707301199331;
        Wed, 07 Feb 2024 02:19:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDn2j3lviigQChRqa1aH1Rwws/2aEuJJUKb0/JECozRGJtISUxS9QOn8ABjvYc8ZPBsNIjg+WKHzq+5FRg3HjNKSNRTO3sz9lDp0vf5PNwtpa+sJCJI4DRebpBToV/BIfagXyHY00CDZE43RcyClLPE5t7qTiqH/B/GtTdXTN5E+Llt5oC2dr+vWzd0kPPu3/X8FlVB1KVhfjdYAH4ayFfOaVb+9/x6+t/Gi5C8/Vlubm71WAiQUlVPMAt5D/2o/yp6J33CEWZ5qsohB0PsoCB0vbKLA==
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id br10-20020a170906d14a00b00a3522154450sm603159ejb.12.2024.02.07.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:19:59 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net v2 9/9] net: fill in MODULE_DESCRIPTION()s for dsa_loop_bdinfo
Date: Wed,  7 Feb 2024 02:19:28 -0800
Message-Id: <20240207101929.484681-10-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207101929.484681-1-leitao@debian.org>
References: <20240207101929.484681-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the DSA loopback fixed PHY module.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/dsa/dsa_loop_bdinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/dsa_loop_bdinfo.c b/drivers/net/dsa/dsa_loop_bdinfo.c
index 237066d30704..fd412ae4e84b 100644
--- a/drivers/net/dsa/dsa_loop_bdinfo.c
+++ b/drivers/net/dsa/dsa_loop_bdinfo.c
@@ -32,4 +32,5 @@ static int __init dsa_loop_bdinfo_init(void)
 }
 arch_initcall(dsa_loop_bdinfo_init)
 
+MODULE_DESCRIPTION("DSA loopback fixed PHY library");
 MODULE_LICENSE("GPL");
-- 
2.39.3


