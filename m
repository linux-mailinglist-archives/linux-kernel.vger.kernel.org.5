Return-Path: <linux-kernel+bounces-51700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C24A848E5D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117502842C1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328C424B28;
	Sun,  4 Feb 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="WK3V1FG3"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F36249F9
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056510; cv=none; b=GzwPzIx1itCaTWq3R9r2uSZOkdKllu78Pa+OXZ1MT/C1AT/h05S4wkPjUEPv3rcQR7hel95n2Grg+OlvSNhTDxEG/6nt1zU2ZG2Bjj3rwsNt1IzP2A9z3zGTC7m6bOc4TDDvAajzXGnWgI9Cm2Fns99ky5j38YT9FhLLlHH42FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056510; c=relaxed/simple;
	bh=5r8tPAE4JJiQ/TMfO7ryglYRMYVtmuiRDdzPD20d+eI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ClQjulrCpirtTyDJafm/OCK1YrNGvVhcA20p4wpyYLNtka2Y/387I6lKd8xglWf5njdmQ+twdAAyRhAhUl6m9AGKttKbZsIwZpr9fAICwO8nAUwVE+KbUJJCuXae128Q6HKMFc653mhrPXYVo4iMIZrl5gmye3p4nJzNhBlObQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=WK3V1FG3 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7354ba334so31872425ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 06:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056508; x=1707661308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DM1wclqTtJ+/yCoNOLkdaIuN4wdZRWjTbqonpGJw8JI=;
        b=OtSeJob+0mKUN4N4CFkm1HdEkKAX4ZULTrmdLFvusT9kpnII7OAMUMktGY/Q9lCg/k
         +d+xrPhm3AQrS4CTVPCiz3u8GWhJXzSWrYUfJ10+e9/uxfxUYO4mR5bxmnBbjoOVHAu0
         m0iYToMu6UXLynp+/LINU1XnJOj1HG1w13TSYGmwsF4MWW7503BllD3V96avo+VARHBt
         LhhZm9qCauGibaEP3Ockd4ZM+E/GbSnsBvnVNnaYnfpjS2CZeNQfqeel/Bn4V0fI0HiK
         LL26g5aT67rpzXcKLAigSAh7V6uiqch78Mx8G17H0StUiX3j181tXZZplLn4Wgt3/7Qt
         dV3g==
X-Gm-Message-State: AOJu0YxwG/9GlyUwB358JQ4YmI9Jje29uYUxYrQZptiPTiKjyw25UKFy
	xmhATfQO6VkW4nI9SbgVQhnxPEFIAHy8e6z0ZxBPGy8SxNGPxi7F
X-Google-Smtp-Source: AGHT+IGbMbmdxU5sGxcRK8e4sB+bnO9dyqYgoYH8V8UbKpXj1YBl8/N0RtzoifBZkOzBV1fQMWlwsg==
X-Received: by 2002:a17:902:d4c6:b0:1d9:8fc6:35 with SMTP id o6-20020a170902d4c600b001d98fc60035mr5472471plg.15.1707056508444;
        Sun, 04 Feb 2024 06:21:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFJSX5qjqrqhBMTuQdKaXScTPowLE0tBasLmOzydkWG6XABrdrT8wqS3Wcj1n6Zzixrg6hrwXofBXEI2/cnsU22fPr//4+tQMt4852e/pi/5nNv4FjWcaiT3vBn93sdsXPjaqqlCxFFYuzr8VJySscPpAixRlt4z7HQU2iNN3UFfQwWq7iLACRhOypSqlY4lLEugbhicoEHkCPgAqPIPBK0BhI0GmAp3Gdpr9sYDoueU1H0DCm1YZhwSQsmYHkZpur
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id r2-20020a63d902000000b005dab535fac2sm5097095pgg.90.2024.02.04.06.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:21:48 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707056506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DM1wclqTtJ+/yCoNOLkdaIuN4wdZRWjTbqonpGJw8JI=;
	b=WK3V1FG30pTDXErhU6A8V1nmaEE3ZW0hDpcaQEa9JBtKoOMLXG6AhgggNZ3k/0PX5BvTCJ
	8TzgwlHZ7kVj0Axx+zXzZ5lO4AGLDedzNA1UCJlwW4L8Z8DzKC3ZZTCAUNAA+mkaQLZ9KJ
	GKfNmpha/cMVPNrCVFRpbZcXNZkFbW1yKYEwuWWXYjyPMJKwp7Xy0xK98ZDYjYFkYsm8Hf
	0gF3W0AQx9cTglwv6s5oApK/tB/wcyF10+5F607wE7rPrT72Okj3SPdoHeVGwnNoqQermq
	BMx73JUci00NrjJDQ9TMWBkoZ4H0f8wUdBQYmtfE25ZJ1MImca1fKwEi6uzRVg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 11:21:58 -0300
Subject: [PATCH 4/4] powerpc: pseries: make suspend_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-powerpc-v1-4-c763f0e142e9@marliere.net>
References: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
In-Reply-To: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
To: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=5r8tPAE4JJiQ/TMfO7ryglYRMYVtmuiRDdzPD20d+eI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv52J/wzsesxRSSPnJ5rCztFrehjjQWiFrmPB0
 SjinE4QIhyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+diQAKCRDJC4p8Y4ZY
 pghvD/9p/r1OMruDDruavs7mlXgYdpGZBqX0Sx9e4jpOPBU8fYGah6R0HrUIAQk32wEul9pna27
 X5/g7MvXsA0Q/0/+aj/XGmMeoqZbWWe8ZvCK7b4y2BEpP5Ek8wugNYU4yIvpKmsnwwATsbUuYd6
 ZhBxPF6wSK9AzLLgRXD+9CyVzZkFYNeWt9JGEsdHpN2NEuza/TbC7V1NKTkArEpbOv5xPhkqpzZ
 t5f/SEEAR/ruJYHGzQhpR3TRmx2kLwnDd0ZN9/JtzCC+6xL1fMf64puEjT+xUHY1YqITyqEJnag
 SRKWVrYF94vvsfAYpvgEAlrUCImZumTmuCiFa4tYDOtl7IaQIiny/NI7fLZFh05RO1TKUrxyubL
 uUpsL32dnPWjaNVG8ClnkMBwR7wb2cHUSO/Q19cgWDCF2nl3ICSSdBMGIPQWF+mSgOpgv/KqDTY
 +3eBuejg8f/oLSEVjZGwla1Py8AR+RixFiYlOaiHKo5XRTEnW4szpnMSFtI6q6/ZyR3INHabBJ5
 Q0IlvqDaZOrFRJMsGNYvr0NW6SmqxC+YRkJlmDU5kp4CAjj/n86YlBn6qETZ/PvXxddPQ0XmM1f
 FJ1Um9H1F0KvtUhUaWV1a6Jkc7bJfZKlDS6ftSP1ZDEkSWuEiUy8VKHEaIEBhvfRW5k/cV1WkO9
 JzjGbrUONmmZLgQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the suspend_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/powerpc/platforms/pseries/suspend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
index 382003dfdb9a..c51db63d3e88 100644
--- a/arch/powerpc/platforms/pseries/suspend.c
+++ b/arch/powerpc/platforms/pseries/suspend.c
@@ -126,7 +126,7 @@ static ssize_t show_hibernate(struct device *dev,
 
 static DEVICE_ATTR(hibernate, 0644, show_hibernate, store_hibernate);
 
-static struct bus_type suspend_subsys = {
+static const struct bus_type suspend_subsys = {
 	.name = "power",
 	.dev_name = "power",
 };

-- 
2.43.0


