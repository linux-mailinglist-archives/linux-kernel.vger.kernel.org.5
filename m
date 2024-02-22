Return-Path: <linux-kernel+bounces-76066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85685F284
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654EC282819
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6396718041;
	Thu, 22 Feb 2024 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3Tf2C5d"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443AC17C9B;
	Thu, 22 Feb 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589516; cv=none; b=CLtP30dUDLyTD3jXOWA+Hd0dfc9pmwtkD4uEQLDj4H1ndfIfhok4pRXgaG+wUjZ3aeGlGTGff/x7eYPE7GYEqoajSoetvvk/zS2+EzG02QORc5Z+xlQDZcR6N1Mn4ARfeYxoR0/QhZoQgrZMeaeLjZ0kpjugP/bVm5omm1VnIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589516; c=relaxed/simple;
	bh=elakuqGNOaOhtGFsNLCyqgDmOnmPX9ZLJ1JqFpNQ/yg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F1mpjNBTgkK0QomFSvtejCFhN1yHBhGxZP7s0WvZbNt7YN4iuqdJ5Zb3GBy3LeUqyPp4J7Vdv+jyH6z/SDsv+tRTFF5DpQaLfPGrPBZgbqpqIpWfY62OEMkPL/n7BM4CyI2ZsnN5+HsWIi1AHtkENUG0aTeEEX8oxeHG/23xAqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3Tf2C5d; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd72353d9fso5524977b6e.3;
        Thu, 22 Feb 2024 00:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708589514; x=1709194314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb6F6A+ApMdDat1na/OH49cM4hajulmNpBuYW9OklqM=;
        b=K3Tf2C5dWQMidsOQTZ9UgoC/orbacX7HbPn/nOuRpyqNrg3Fr8eJFvoM7JUyQ/qCb3
         91EzQtwV0GiXhUQrrOFg8NJLnwNpwQmqJ8qCADWj0YDoKje4jlzaZkkU0NMreUB9rOpP
         r8j2Zk8LNVxhFBFxMJHk+Eddj4BDrbBB7Xgfe4h55QqDHexG3BWF5mgFllRiFldsxtn+
         eXWh0ER9WF/vNFLCwTf6ptokQQHKPrmyQu6N3nXeb5OpyPOdihMJ5oq/22JgPF4pXM5W
         bK2q2+cROmb+Ci0HtEauuYzi4dJahdAEDrK1zJGf2dX4EjYt/75EnzMCdnWJZm8Z/vBl
         Q9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589514; x=1709194314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rb6F6A+ApMdDat1na/OH49cM4hajulmNpBuYW9OklqM=;
        b=fprnrYD2JRV5AUfos//HB7vUFB3K3dJBQF1dW7QpynP0kYl35ATTjvQLOwV2xYVA3m
         /ekqFVZot5JcMuOt2sZLtK8dx8CRzHiZIxbPyznoD+mFIXyH31jLIqHUalZDdTkTtfLf
         SQcPutkAC37ZO7YTBSi+D/7TmLUUkmU4+Yk37oBZPAUH0emu7Tlqevfwbau8qON4b7WP
         IJE4bKo9ouEv+rHLCe3tyYoV7ibts487csmHsx0jUcTKLfC6o72T90V5dRJwGPoHw6qm
         9s1tfKeLDA+kCFVzjOJ6cI7CrbkThzZOa1qTZPzgXr30JmW+uIUTtGQnsmhT9mySWryH
         esPw==
X-Forwarded-Encrypted: i=1; AJvYcCX/gTiUzTl6RTpOp/ywqCC4WnjD22kb71nB52bU/qNUwwk07x5fw8GLI+mBFYWK/OCA8u+Y2Y0V02uIPZlLNPDMK4fu1Gh4Droo9S8v5cUG15BGQCzNa1l5ERaLtR7gE5uLxNp7dTUQ56Kv
X-Gm-Message-State: AOJu0Yz/Yk6oQWpap7o21OdhxpoGGXVjcoI47ysdyDqulOtifttVm8Mk
	Zm6OnnMmzzQEplCTD+Hi1Sm0aV18c4Kh65UbhQk+yLER+2HhH4ZQ
X-Google-Smtp-Source: AGHT+IH+iE8nn355j+obaDXw5uQfSNM7RCvZ5iPrzXuNiE225kZ5vF6pG+3rjE/Ss9UcKRo7UkW/7w==
X-Received: by 2002:a05:6808:13d6:b0:3c1:4cc6:4f9b with SMTP id d22-20020a05680813d600b003c14cc64f9bmr17748546oiw.25.1708589514162;
        Thu, 22 Feb 2024 00:11:54 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:3b18:a2e2:f00b:c965])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006e46672df97sm6989554pfb.75.2024.02.22.00.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:11:53 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	davem@davemloft.net,
	hannes@cmpxchg.org,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com
Cc: chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	linux-kernel@vger.kernel.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v6 0/2] zswap: remove the memcpy if acomp is not sleepable
Date: Thu, 22 Feb 2024 21:11:33 +1300
Message-Id: <20240222081135.173040-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

In zswap, if we use zsmalloc, we cannot sleep while we map the
compressed memory, so we copy it to a temporary buffer. By
knowing the alg won't sleep can help zswap to avoid the
memcpy.
Thus we introduce an API in crypto to expose if acomp is async,
and zswap can use it to decide if it can remove copying to the
tmp buffer.

-v6:
 * add acked-by of Herbert, Thanks!
 * remove patch 3/3 from the series, as that one will go
   through crypto

Barry Song (2):
  crypto: introduce: acomp_is_async to expose if comp drivers might
    sleep
  mm/zswap: remove the memcpy if acomp is not sleepable

 include/crypto/acompress.h | 6 ++++++
 mm/zswap.c                 | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.34.1


