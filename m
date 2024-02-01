Return-Path: <linux-kernel+bounces-47694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3136384516B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC3D1F2BD22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ED9157E8C;
	Thu,  1 Feb 2024 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=logitech.com header.i=@logitech.com header.b="jeUfjxiW"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB5157E7B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769282; cv=none; b=sh8cSNXYxXVTBiYg6HlK6W3/fYvC0rQnQf18v2druIGNmOGdxJlvX6DCdPUSqSsb9b3zHFZfgbuGgLTOhPgluNTNLx7KT8nLcH1WTUNCIw5J6+w+HTJD5iuofMPE9h23Z5TQIOr1JKACcWJlRQwUIbMWGXg8IoaWoF5xMswf8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769282; c=relaxed/simple;
	bh=OOi6m/ttx03p4JB3XlrP+TgknydbKLEPBpB8WTlFoAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4i5J5wY7dRFgwLkAVjun0L2Qsf6zipWcwfMwnem/3VtZdP/xjCn/H+W7jO72GEEp0cuolKyQslWPMCjU3BYJHpv0n1n1dhi8nBtlP3DEun2zpvlB1yoCCGUqpUvF5Apx/FuEv4pvcRryGVKQjggEmzAr6ZtsjoRW61WWFi0Rdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=logitech.com; spf=pass smtp.mailfrom=logitech.com; dkim=pass (2048-bit key) header.d=logitech.com header.i=@logitech.com header.b=jeUfjxiW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=logitech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logitech.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d8d747a3bcso4487225ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=logitech.com; s=google; t=1706769280; x=1707374080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOi6m/ttx03p4JB3XlrP+TgknydbKLEPBpB8WTlFoAI=;
        b=jeUfjxiWVvwC0akOjDFRZ2aOfv2F6P0kqzLugTXYorz/N2+EDv+Kp9JJCLUdjDbrHi
         p66VC6sPXePAp563CU6igSyT+DY/hSoTPJDir4A3VxB/uumN/U3+HxbxbhzMVphwXw/J
         3wxtq9CifoEet486x/hl/3G6WwHLMlR4sz7NAWFSvLm4AkJcT9zrR5xmIKcWJkUsevLK
         hu5pjI2v6pXm5btmnnRFfWA9i8loZ8ijn1R5+AD69n2zzwafAfAWRY/IiNEsdYQGMDS/
         Wcf7DgKgSjbImUciSXcAyTgQUcnZDFDnRIgu1bqn1PoBcW64ExHti+bkRY0fKZ1/9MQQ
         Vcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706769280; x=1707374080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOi6m/ttx03p4JB3XlrP+TgknydbKLEPBpB8WTlFoAI=;
        b=qv5kj7vtK3Lij1HV6++vnuFLMXqCkvkPtsfb/S5qNmsSNtuOPkih79HYT0GZkCqfEv
         uc9AM9mv5LHzXp1RQN25/jNshxCP7tcDEO7z2HhTRo4Twy/l9GWNDKxv67mvyUfUc+vD
         wcsjrwJ5IRcvWVZIjhAIuiNLWZFi1584ifV2qhiI8ryjPwoUHujjX3fSDQ5WnKlD4vOd
         3TGFb7mFudmOXRcJwNu9dpkJWE4r3pQWEVuirgGq4TK4iQ8PViq0vBnhnwNZlcQ33otw
         cdggGnIC6VKCQzk+AqsuNI0Sycotak6havdD1WwCHEEdMGvcwpIWQiqIgXrLrCE/WFFT
         a61g==
X-Gm-Message-State: AOJu0Yyd2JLlo2NoAofw5QLVnucYV1sjaWngNSUS+w1+aoRHKVJ2Nd5E
	Dsh4HphFGrlXUt4cbR+y4yhYrYhOe0t3LQtKKn0rlknuhUSaX35nT6H9M4xLaA==
X-Google-Smtp-Source: AGHT+IF+BIapmET8K1YuIr3YNHU9VKDFO3qFzb93Bi9ssE+FVQu2m3Uau0P0mXDAR3GlVL3YM4L4PA==
X-Received: by 2002:a17:902:6946:b0:1d7:407e:418d with SMTP id k6-20020a170902694600b001d7407e418dmr7481989plt.26.1706769279726;
        Wed, 31 Jan 2024 22:34:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWTXW8bn7Ly8+VvVNH1D/rMmKcZji33FXGnhsXD1I/e6k4Jkd4rusj4aQ3J/TXxDfYCMmeqiOhgKmSBArO5izXy4QqOxP+HX/AD7+eEVPR9yAHSHBaKs0kJAZ7WW5ACCXtgkuXuPqm059JdS+9h0Ee5BOH8BM01CTtx/7qjx1yM4GCmAPUFPDrcVIinoVuuaNFMF4Dc7IB96cQEfk36ARwsgoo5FYeO/neskIRccI5tENpDw1ZbJds2YNWgfG8hDCe+lvJB0rTcLrJotaUuawGwDWudrnc7ZCcq/J13D+atMB3t3XdxoGIrDONsvPntUSZU7Fyf9V3hQTP1hfdYPn3gRZENBn/8U2qywzm6ggFJNvBWXGtmYEqhKXo=
Received: from localhost.localdomain (c-71-193-234-98.hsd1.wa.comcast.net. [71.193.234.98])
        by smtp.gmail.com with ESMTPSA id kj4-20020a17090306c400b001d88f0359c1sm6740612plb.278.2024.01.31.22.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:34:39 -0800 (PST)
From: Devinder Khroad <dkhroad@logitech.com>
To: senozhatsky@chromium.org
Cc: gregkh@linuxfoundation.org,
	laurent.pinchart@ideasonboard.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	ribalda@chromium.org,
	stable@vger.kernel.org,
	stern@rowland.harvard.edu,
	Devinder Khroad <dkhroad@logitech.com>
Subject: Re: [PATCH v4] media: ucvideo: Add quirk for Logitech Rally Bar
Date: Wed, 31 Jan 2024 22:34:20 -0800
Message-Id: <20240201063420.46495-1-dkhroad@logitech.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109124838.GB1012017@google.com>
References: <20240109124838.GB1012017@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Devinder Khroad <dkhroad@logitech.com>

