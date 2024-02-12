Return-Path: <linux-kernel+bounces-61433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FA685124A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB641C20B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A417D39AE1;
	Mon, 12 Feb 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRNl1P51"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083739852;
	Mon, 12 Feb 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737512; cv=none; b=a58vUPIov5g7oD1lOSl5KFk1JENzmHZF3lMjZg1Lph4EQtmqM1kv1ff5RFW/qWyenEH8sM6sokUCZ+h0gw2EKPUZu0nc5pHSnkhTjIH/C12pgtXSdqewVlXwLoqZcvSTUxHyrhgS9Vy2R5MPkGEIucE9HDnMDF3WYw+Imugrg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737512; c=relaxed/simple;
	bh=Na/rHa5dAP3l50X//9FCmhKqVB813/sR9Yz3qZ8PB4Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=rW2Vj/PLVFE8L51JRiGhQR+bN87hmKifhNJ/lJ2KNoBh2M7jFpa7z4CukzuPrSdxYYG3klOTuUDbMrZ4xs/3goZYWULrwVd8W9TJIAlVQjoAhJh039WvhlfVq3hua8yWLE0Svb/30DJmr4RC9nvVz9cdldgh7SSU7zM2VC1rOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRNl1P51; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-410c1ebf5e4so7973435e9.2;
        Mon, 12 Feb 2024 03:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707737508; x=1708342308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUC5+LMrNmxS7ctyeH5pl2x/dqcP46pJUlAebEkKzMY=;
        b=RRNl1P51mIuVsN83b/YxTNo/fsRO5Erx1wZQ/fvGCy/V+XWsTYQ8gTuVqIJ3/xTE+c
         9s/vVQ44yM0kXQDti5EWnSur5LFxpPcG/H9HDtiXU9xJuvRLlgCcMLCesS1jk2mcyDMo
         gcLuGRGeds2X+P01XDd70ssMDAy6xURynnEkXhoHotSmq8n3Z9GD2VZW7FigKl5dLBpF
         mR2WW3eErrVa65wLekvvv1QIBmlTOOEI6CaTHntiuPSr2BCUQYVUX/iG/bv2MEyUO5mq
         xT3o04yCQq4uLevuKHhr6rGV+EppgosAeRwHX0rasqtYg5XKU8kSJ4RJjnS9R4FiVbLt
         wmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707737508; x=1708342308;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUC5+LMrNmxS7ctyeH5pl2x/dqcP46pJUlAebEkKzMY=;
        b=vj4UF0FRH46dREWHCSWWMKwV9hK2PI29Gkg+ABUPhN0yVFRWLMy/HKpCkpBJXtMeUj
         krOTXmRGNVXjmctv90lfpUyilFHFTMQcF6DYg5SN+Wgawsmzed4sVNlZQ2m2F4b/KoeM
         KXx5xUyY9c8EnwzWdgvISoYNUzPSH1CT24lUd5fy6her7GtTHa3fK7ntLpjGCMRNNsQg
         EsJGHMgIBEhiipGni0BcThGJNyza5XhB/5MC6zbaN1+jpvV/FZ5AtiD0WPKxF4ICrcuW
         XANhxA0+DEz+HcGb67FPOt5XJAwc75e0TG8crDYINCYDeWSTEr5HSrYyqu+D6KYC3eRb
         WKvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyKr+AhTi1SEFcwSP0D0p25T9bDMi5BdpFo7sdlHqXzCbu4Pt2s3Gav4d8eC237AB0OI+/CdPvML3v7942h8ioPCJKDqDfgrrXTurxb/1mvKFtNSNMzbpizQI2PQW3gjdywEfh
X-Gm-Message-State: AOJu0YyxaGbjh0srqJNNxdAS8gQZWV6gMkVWXrF3N0fzlXRIUjpQez4R
	zOOIYiFspmuEE2iYO6nKur+JGh/5PmIi+ODIzeVYfllr7H3Odzi6
X-Google-Smtp-Source: AGHT+IE+5zuwW7yrsOv31+vWiPAyUrhpzypF4FkaT/NCs+F+uYeC4DCmPmFSiu9j2c5OOLOnoljCDw==
X-Received: by 2002:a05:600c:1994:b0:40f:c404:e2d1 with SMTP id t20-20020a05600c199400b0040fc404e2d1mr6185259wmq.19.1707737508435;
        Mon, 12 Feb 2024 03:31:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWR2iTtX1e3lWMsiZIItzqZolsT1+SrO+IYPvd4Mnk9qfVk5oqtuTGayfq8h/PdBph1icPKjf5BisiimUASF9I+sJMbX/rkjdA7ww2+/IR14cubejkg/D0c4Ce+O2pqTcY6RSq4xXejeAtRVH8xabBlYSA1374UMSY33rbWPqM8Z/s5rO6XolyLKqdqxDTHi5OCZhx7LD+cb6Xh0IiSJRpNJSAq2wqtmbl68pZEGoadsGk=
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b004106c2278eesm8459064wmq.0.2024.02.12.03.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:31:48 -0800 (PST)
Message-ID: <152dec8c-176c-4012-bef8-25ccc5785241@gmail.com>
Date: Mon, 12 Feb 2024 12:30:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [RFC PATCH net-next v2 1/3] net: route: expire rt if the dst it holds
 is expired
Content-Language: en-US
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <3a17c86d-08a5-46d2-8622-abc13d4a411e@gmail.com>
In-Reply-To: <3a17c86d-08a5-46d2-8622-abc13d4a411e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The function rt_is_expired is used to verify that a cached dst is valid.
Currently, this function ignores the rt.dst->expires value.

Add a check to rt_is_expired that validates that the dst is not expired.

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 net/ipv4/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 16615d107cf0..7c5e68117ee2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -392,7 +392,8 @@ static inline int ip_rt_proc_init(void)
 
 static inline bool rt_is_expired(const struct rtable *rth)
 {
-	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev));
+	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev)) ||
+	       (rth->dst.expires && time_after(jiffies, rth->dst.expires));
 }
 
 void rt_cache_flush(struct net *net)
-- 
2.34.1


