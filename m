Return-Path: <linux-kernel+bounces-58362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168CE84E534
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C928C711
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97E881AC7;
	Thu,  8 Feb 2024 16:43:00 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B4C81AC6;
	Thu,  8 Feb 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410580; cv=none; b=aIZsMbt9shikMSEqW4R0Cb23OYhWs9nuNuOcS8svSQQypeG3aXmLzgtDqlOl8FbyL4LRRnehM9Svj9L/To/KKquFYS70K59kpOtpggx+U0owwXcHRVoq/VOvWe1a7gNUNN2W1jOR9MiI9TuzqxWPmpndvmcpd5pw02CEQ/3Iv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410580; c=relaxed/simple;
	bh=AF9MRNHP4Zfbum3O37Vqta3MLkTQ94Fd3K1qg6GP2pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7XnbYULyE48YG5/LaBNL/UyF7ghUua1uL4Y7IM/4GxiJqVfxtjwxTPuAgWhQXSine/61Ody7Im55gsElRDYG2rWmCsIg4OXBAFFTY65TUgY1jNGf45Jw8iPEz0ZMbTYvBnvqcMe4U/7I7YtDSuVwu5DpC6Je5A/WUpmhnvXPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a30e445602cso220270766b.0;
        Thu, 08 Feb 2024 08:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410577; x=1708015377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9t/Fs6sg6uNWFkbyktvvrK9s3ApKdOAXQbX21ZqRtc=;
        b=v35h5U+blWIeqVyhKcvTEQrgqSU7+til6gnOB7LQXVDwiSuJolGkDIEByvpperEPnH
         VJ/E0+0gM93OY4BeX9gl/uO5ZShvfqBuCqvj8AAVe0hATLTESo+zgC5YUQBCa+t7n/TC
         h2dOtxA+Nv3QsS9pNtGYbEpuFdWpVK7NUojqpPLdeGeGxdun1miawwdKTE8tXBhEXwLh
         M6QUTuetzDMKSbeE4E+6TxBdqEsi5N58tB60OfVeD4HuBki4+wlOIGKUV+sEJBVnqg9p
         P9mJWq+bL1PlrOOP5Xo1FdpJb8HFeQLOh0pYGKlQQ9uS6HwkL/VTxIZXVQ4riPbomBVL
         HT5Q==
X-Gm-Message-State: AOJu0Yxzjp0sxP+gpG7jGggP15SYPaBIREFxXCGRLxCWjewyn5YwsSty
	aAdmj3pfyrU2qr5wrO7JpuSA7vJndohUfJiM/VXV7f8KlybIihLA41Zk5BEO
X-Google-Smtp-Source: AGHT+IERRL63Q47T75PpVu9CMoD3HAIwZ74VoE9kqsmhPZF9NaORsNSg0UHHgMMAPr7SdYZ3e8DJrA==
X-Received: by 2002:a17:906:2b16:b0:a3b:adff:85d9 with SMTP id a22-20020a1709062b1600b00a3badff85d9mr1574474ejg.15.1707410577018;
        Thu, 08 Feb 2024 08:42:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqIU44hjF4Z77alKakWDUy4GiNfrqYDYHQVuhKYrcyDyCNiKzwbVdN/vMqMb5l+dnM3WJ2CnPmck5cVV5Z4sPh54WQFsQwpSr5CCg0ob2j+CCg0fLUQ1ENwbR9DQySAtDjM3Oy/jkJqnsHmc7y1avSVjFTtrdEHlv1lQesbbuRCl7YWFhj/ykRO6NRElNy6an6kBrbedJ0/M2LQ6OzYLcZE1bsASIByw2eeDlFqNCtftNfi4piyoN1mxZustBIfaHvUmibN/YGzhnz+qeSr0oSE+WU
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id jp9-20020a170906f74900b00a396186396dsm226166ejb.54.2024.02.08.08.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:42:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	jhs@mojatatu.com
Subject: [PATCH net v3 2/9] net: fill in MODULE_DESCRIPTION()s for mpoa
Date: Thu,  8 Feb 2024 08:42:37 -0800
Message-Id: <20240208164244.3818498-3-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208164244.3818498-1-leitao@debian.org>
References: <20240208164244.3818498-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Multi-Protocol Over ATM (MPOA) driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/atm/mpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index 033871e718a3..324e3ab96bb3 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -1532,4 +1532,5 @@ static void __exit atm_mpoa_cleanup(void)
 module_init(atm_mpoa_init);
 module_exit(atm_mpoa_cleanup);
 
+MODULE_DESCRIPTION("Multi-Protocol Over ATM (MPOA) driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


