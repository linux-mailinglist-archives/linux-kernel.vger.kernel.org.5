Return-Path: <linux-kernel+bounces-56302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D124B84C87B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100211C235B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348B42E63C;
	Wed,  7 Feb 2024 10:19:50 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC528DDE;
	Wed,  7 Feb 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301189; cv=none; b=H6kZbIjZuKLMLVLSQFTwS/86A1jUpmrrfElQ72tHSa5UX33o0Zsx8e2b0L5+KWKH4M9FF4vQ0hXleEKtmkAUWmnuW4eI1tRsiLNV8GssdZ6ajzPpRmsmBKGbUIiDZX+3w1jq2XbxYtnGcD72Wa6uElzgmjIPyPdxS1/KMIWHo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301189; c=relaxed/simple;
	bh=h09XmzjAYrmpBl0iTXX+I7W1xNVXxPK2RnBfV9Jz0b8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPyu5Rj5SI3eMCrKPOlPf+QQT+G1SD9H3rKeuG9lmwVZw3PudVohH/464Oew7wGuzuDdYz5Buf52JB4lJs35V5tZx/Krn0KxlZBPfctf79uwmAWrd7fLTn0/hE5DTXAXDJb7fez6vopRniWczG9mgv2n6txzLgqcHnkppX5qblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5605c7b1f32so487688a12.0;
        Wed, 07 Feb 2024 02:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301186; x=1707905986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSPKPWb2+X/fBYPYBCyjcjI4u65FLsU0K06sqValewc=;
        b=iT+UoFlBkiln9mtSJLPXBtVQFdpKayi12JcNDPYBau/rG/+vT8gBciQ+GIQq717v/i
         i0i7rop5/lFebUx1WswZe5Fq5rHXzWH4h0apOp3EbJ7smKKqMoDmXoDV7TNw6KFpCGCK
         v+mmu4m8eqICpcPNOydOZxWlgdtjOj73KFlvKzasJXACHCACtfw1Q0rh5tNOhyG9/wbZ
         caS/ycgIEJcGH9xvNaF5O0hg0HQnGlLL3xgBCFYk5Fl0yimtDnI9BIaHcm/fWMAKwE/s
         B65YHiXq9378bZYW0049t9CQ4ELlJtHOCy5dOom+iGKuIAMqnm9OUtZIPZlOgI+kgIY4
         6pcA==
X-Forwarded-Encrypted: i=1; AJvYcCWHUBw7Hmjff9kPreHQi8ZbHQWM31RcUgjoxM03u7rrDJBSf+RaNFjK/ZFhDWSx6hGwxtVR+HV4KYrZtwVsquB5n86+a7k8dNpIvOpRr3MlUKxGZyzeRVIQL+PqRiq/PUpKWJ7dlxM/JJDmoPVJ2PpDSxp3XdM3B9PA/eYVN8uN1+qGpXEzkt6Lag==
X-Gm-Message-State: AOJu0YwCqo1MPPFxLulSpyKauTrhzlfoPnYFISRpHlfdUgSGN7WVBHXS
	yEl93/9YuBPvf/FZYgL6yjTWlIQZUGxKPg9sZ5PbRFdsHZ6A398PBFXRZfX1b8UMOA==
X-Google-Smtp-Source: AGHT+IGAXx3NnaGXn4zp3l9aun0K3Mm5DPsfnSDWvNUdeDkn55H4OZpnvjdVcaBuVDm54IGHq3CB1w==
X-Received: by 2002:a05:6402:2036:b0:560:e82e:315c with SMTP id ay22-20020a056402203600b00560e82e315cmr281324edb.42.1707301186210;
        Wed, 07 Feb 2024 02:19:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzmxMsCIi5cbnPIT290P4P99sAExkNGk9gQMwPyQtZSVUfjGw4nD/1JQUnFDzgYPCgv6/f7VzmcR7JG2X+Wg1LI/U2QALjMuh9NHp1QNfXrEHg+tgnmn83/6JBEAZIc1N+oGYVYRfhuDC5inq2/CuHAfv60ZMk2W9bRJLpZ4LlxaElSs+o5sR64XGqdRYObS91mz7GEKoYq1zFH7vzn1BQSi/1IDOgM3xztSP3siz4ylVqUdXrVTNfvPrU5nsM4mMT895IU1MODI83ddGXUSGNwcHV4N9Jfgr1fsCJCJTKIoTgcJ7PmtZxCyvnYkmPwY5p+AJeptpU1rlKH5mOQQ==
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402034d00b0056003b75400sm511610edw.44.2024.02.07.02.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:19:45 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Alexander Aring <alex.aring@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	linux-bluetooth@vger.kernel.org (open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)),
	linux-wpan@vger.kernel.org (open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4))
Subject: [PATCH net v2 4/9] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
Date: Wed,  7 Feb 2024 02:19:23 -0800
Message-Id: <20240207101929.484681-5-leitao@debian.org>
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
Add descriptions to IPv6 over Low power Wireless Personal Area Network.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/6lowpan/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 7b3341cef926..850d4a185f55 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -179,4 +179,5 @@ static void __exit lowpan_module_exit(void)
 module_init(lowpan_module_init);
 module_exit(lowpan_module_exit);
 
+MODULE_DESCRIPTION("IPv6 over Low-Power Wireless Personal Area Network core module");
 MODULE_LICENSE("GPL");
-- 
2.39.3


