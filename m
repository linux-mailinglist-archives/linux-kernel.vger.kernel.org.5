Return-Path: <linux-kernel+bounces-67780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B878570AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0631C218EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BA41419AD;
	Thu, 15 Feb 2024 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcs3MblQ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F4F55E7F;
	Thu, 15 Feb 2024 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036986; cv=none; b=Q23UBbrQP9i17Cwb+4/lSltUfdM4spPvStdoF+RXpJOoHURASUJUuYxo9E7O9Z17YqU3S7Q0EnHLds0G9RPs2zn17XJCGMHWD2NMLCl0LpUOm4erqaMFpM0gUDAzs2Bf+HYH/a0OmkGynIvkQgJCcvvgohDsdUAlVRU+iTG72+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036986; c=relaxed/simple;
	bh=CKJU0qV348zK5ydfwu0hXi5DFvYpoWmGby9n3Xbav48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uUIiPuXCd8coITfIgIHArte2jBgWUlWBBQVdm4wLGngzU9SP+TujXtcpHudvBRegEEZ3L7r8akJUFCFi0oJiVeQYr2XHP3uY6WzI6j8dfDYiWJt5RoFuiiFAp8251EX9lMTJT+N2fCsGZJtlyfSscb/vcLGAw210U/OqCxzrN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcs3MblQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-411d231ea71so11008385e9.1;
        Thu, 15 Feb 2024 14:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708036983; x=1708641783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PgvYXFeAtJ4eMTl/jZdy/AomuxUWsZvphnf9tLSxGTs=;
        b=mcs3MblQW+P9CJJERAHyy+8xvJqP64RfocITHELhqgXUy3CX+GtzgIb7X98apWA3UX
         z8BVchZCYKa5TlNeadXmgAilv9iFXOIiT4NOPB7KHd3gcFsWaXTfSU+YWloaB3R+8b9p
         kWu7TR/Foe3f6BrChNa/8cxbEs8uiYMAc2tMte//Um7S7bxwwL366mxCWqxs3EOW37OX
         nUhbe7jUUElnjGsS/DeoEkknTgGGDACWQU2TcIaayAVGh3BMqwA1T91RTVPGfc+G0WSs
         X5ePihw/Tu797ZOOeucJIULlYJd2+cpK1FIHM10lDzLc+KwSpdUE6/wh/Ze9LmpfUR8p
         gW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708036983; x=1708641783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgvYXFeAtJ4eMTl/jZdy/AomuxUWsZvphnf9tLSxGTs=;
        b=v7mDnxpJ3PesUZJCs6zeirsEJ6ETsk9VPJCo622Wmw9D9lb6OepFVgDLliRrWI5KL3
         Gu/676K7CGCNxr7q6Zd9c+d1wgnv+Nm2y/z9sb14Ns7MqwP7Tkdwwl3doEt0bmVBEfzo
         EWUJbO1cIp3V8YVz4lw4cA+eh+Kg/fPMx5gtBlowP6Ko0jr9UcdkatFVXIsyhhgJSAPg
         Hu595Kwd4E7zq78WYg08n8tR4cmGRiPtoPjc4OWl16Ki5rhcEITTrH5EAFO5sNYOIb+E
         ho6UHP+FvUoOkaugC+n3bm/1eY4lE3mS2R9n9xvAXVkHjieEl8QbUvVw5UJDTPcpEC72
         MpLA==
X-Forwarded-Encrypted: i=1; AJvYcCW5x4CvBC5+fVLQnOy7bZu9mYjc77VNeKlU8YE2vcG8mnNIxf1JyTdqBAkv/8Li9JiEot3FHukadBcVS/Mt+OGynknffM/o3IbqdZuLFI/vNI6bPEYHQQOktX3bhiYgtEYXMYzeWxXDnTY=
X-Gm-Message-State: AOJu0Yw114KfVhhGjCyoxNGiJ5YeNU/y/wMBwLacI4fRw5c4B1i6nYK6
	trnlImbTWhHtPzRF061GLi1YG2xYi3m80pEyufimQIC8+yjD5qQJ
X-Google-Smtp-Source: AGHT+IGcWuz3xcbAdY5/RWa5oBq7q97NdHSFkTnbKOefJLXg/93rMMe3WyK7u1MhDRLzQJEak9sv9Q==
X-Received: by 2002:a05:600c:3549:b0:411:ff38:aa13 with SMTP id i9-20020a05600c354900b00411ff38aa13mr2348576wmq.27.1708036982510;
        Thu, 15 Feb 2024 14:43:02 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b004107686650esm445978wmq.36.2024.02.15.14.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:43:02 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] gpu: host1x: remove redundant assignment to variable space
Date: Thu, 15 Feb 2024 22:43:01 +0000
Message-Id: <20240215224301.2073845-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable space is being initialized with a value that is never read,
it is being re-assigned later on. The initialization is redundant and
can be removed. Also merge two declaration lines together.

Cleans up clang scan build warning:
drivers/gpu/host1x/cdma.c:628:15: warning: Value stored to 'space'
during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/host1x/cdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index d1336e438f4f..407ed9b9cf64 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -625,8 +625,7 @@ void host1x_cdma_push_wide(struct host1x_cdma *cdma, u32 op1, u32 op2,
 	struct host1x_channel *channel = cdma_to_channel(cdma);
 	struct host1x *host1x = cdma_to_host1x(cdma);
 	struct push_buffer *pb = &cdma->push_buffer;
-	unsigned int space = cdma->slots_free;
-	unsigned int needed = 2, extra = 0;
+	unsigned int space, needed = 2, extra = 0;
 
 	if (host1x_debug_trace_cmdbuf)
 		trace_host1x_cdma_push_wide(dev_name(channel->dev), op1, op2,
-- 
2.39.2


