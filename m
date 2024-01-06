Return-Path: <linux-kernel+bounces-18491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B5C825E5B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6B81F2337D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D094426;
	Sat,  6 Jan 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="gPj8eXye"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9772B1FDC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9344f30caso178543b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520568; x=1705125368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSvqtSGtk9WdQSNqyQ2NSRhqTzoQ4bXXOJlfyBaKWwM=;
        b=gPj8eXyeAyvDASYx3+h//jzbb2V8Xosxcx1ONUfX6oEobjUH9U84BaFztb5q15Y0KA
         L9UlEW8Qw34iEmzI+5WuUvFZloKx+l3SGLlN2Shs0WXUp5ecoewKF3N43h4BZACA5J+M
         c4BP7JzjwhfediyOPQ9fiJEKDe7ZprU9P8vPhF+C92Zqupn93Pmyls6MyrRFqDVRxptH
         b0q0qd8+xZC7E9zBFH/EKpSdHuAEj88as9KFLwyRCkyjtOTD3BigplYR0mVqha10NlIh
         qCmA3MRGp5sPiwnffmiOBwHBzhWnBamWGpYkGcIzsShDqAM5EAR6YTTJ20tGCLuTLwKU
         jldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520568; x=1705125368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSvqtSGtk9WdQSNqyQ2NSRhqTzoQ4bXXOJlfyBaKWwM=;
        b=qj407yIrakmFlcVfYDboRsCe40CLP7+NBeS9r3feiYoZcY0NnlxYRp14o1VABahpxc
         z0279mrLdimQcO9u6xa4kFs88BPWc1fe6bSIHNHwxj+6GVuGlNdnNncFbyWXb3M7vN59
         MYSVpZvVNqJcSCIjWAQWyB990YzRMlu3h2is46hLAv6sQ6RlaXB1Dgs9Ka6Un5H4z01y
         G5fmxv9cphjmL/q3U77ch/MTV4IUy0fS82zYnTY/nqnEK0OMAaZdIh6HilJf+O1Sduu3
         zx//qjLQh11gm45ArORNqVr9CoHL55m8kWFqhG6N0mlXzA7JKT8bPIH6kyEGt0rHqmNj
         J4fw==
X-Gm-Message-State: AOJu0Yx4ftlV3gyQKhCZtGJSj3LpYwr849kJEFBOqRi2bso9sNKIihin
	E9VQ7k8LEVQ9d0UwgLz9YIw1u6Malz4afg==
X-Google-Smtp-Source: AGHT+IE7L2RksTdo4PykhNrWnyoUvj6w2h007DkFTFN715N7b6Hrc4tJLYxYdIFTQ+swGaa0FLqQ4w==
X-Received: by 2002:a05:6a00:23ce:b0:6d9:b296:510e with SMTP id g14-20020a056a0023ce00b006d9b296510emr3879064pfc.24.1704520567923;
        Fri, 05 Jan 2024 21:56:07 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:07 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/21] Staging: rtl8192e: Remove unnecessary parenthesis in rtllib_softmac_new_net()
Date: Fri,  5 Jan 2024 21:55:36 -0800
Message-Id: <20240106055556.430948-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240106055556.430948-1-tdavies@darkphysics.net>
References: <20240106055556.430948-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove parentheses to fix checkpatch Warning:
Unnecessary parentheses around ieee->current_network

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index b9278b26accd..520b90abcde7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1220,7 +1220,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				if ((ieee->current_network.qos_data.supported == 1) &&
 				    ieee->current_network.bssht.bd_support_ht)
 					ht_reset_self_and_save_peer_setting(ieee,
-						 &(ieee->current_network));
+						 &ieee->current_network);
 				else
 					ieee->ht_info->current_ht_support = false;
 
-- 
2.39.2


