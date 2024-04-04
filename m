Return-Path: <linux-kernel+bounces-131661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A316898A8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90FC0B27814
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88581D551;
	Thu,  4 Apr 2024 15:00:18 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED7B1CF8B;
	Thu,  4 Apr 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242818; cv=none; b=CRNfybPIRhvpTZA0hJFBp12i1YiG6kJd7xG5RsVWqlhoO+XSeY0uf9ifc9vGnEgaOTRn2cNMfwpIwi6vzVe1a4ZilY14GntSAblGBKJdCbkLhLkc3EnAZr9Bl5m0EY16baucx+qk7lHLDjUg09ba5/GMIyukH4sGjUVJgrLtQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242818; c=relaxed/simple;
	bh=eMuaYgx01EBMtw3uBUV9HF4Gnz06WvJHbf59WwPGPO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvt5lviw6L7D2HMmnoVZ6GqwDI65oQLtDwSZlcN+UqDSGYC0DMyZBRu7sg8+Ai2Ro0lgkE8+s5xEh4RoVNBCXWeZPD2lQWL9z0UzRlxiXg0v56I5dhnRSsu1ShprsnqTKeC0luT1PpWfUYJ+dXhX1CCeyxTR27whRKu5tbKhpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d04fc04bso953675e87.2;
        Thu, 04 Apr 2024 08:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712242815; x=1712847615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5ToI3bzdZhzvl18q+80iRB/qtFJZwodL1fIQlb9Cc0=;
        b=hve+gMiY0/wvZgonux7F8XM8IMZFI/EydnVPsdV7z9gXNrdT3GD/6oxFkxj2/sW006
         VSBWBkCtHnuxdHCVExhQjElWmN/7GyNtBxxW9gQqPJVcDfN60BnsM1fgubtNn4lZ/t99
         kErb9i3zWS6SUpcZQgiF1zSWDBvPcZSidq4bpXLgaYCOK8BrdsDf5Gk6gOhv/WgjspaC
         1o766RaB199zPCIdTb7jt90vlhPaunUjokbFtX73BDZC8JcswVBvb9GQ93uCRBOab1G+
         yyHxWVTvOE6knmKMKaqswr0b5Rs7xO/80Ix1OaX30dH56iiReNVJ3ya9BJm4ui0YajpI
         lgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqwxuIyh9NnxZDsWY4MfJDDru0PPE6cMhbzkT5SRkSAAUy0UyOOL2hp68MCx1b9sro9EBGitd/SRZDHKAquX2TUObE+zNV
X-Gm-Message-State: AOJu0YwOnFDHOPwsz6NIKRiay+ASBJNhVQa1zWQ+HQx0DzXHWH2XLOh4
	R/Txs7g5bMfHNGbLtwBKxI7PNqM7ENqEb517lO6l2AWH172xIssj
X-Google-Smtp-Source: AGHT+IEAeiQoYh1EXhCv9LPSM8dKxIblZUfzpr0UJ3k4fzxeqtdoxZg6Uu+jFimyiCCRe0s87UWktw==
X-Received: by 2002:ac2:4563:0:b0:513:7e83:b3f2 with SMTP id k3-20020ac24563000000b005137e83b3f2mr2262791lfm.45.1712242814063;
        Thu, 04 Apr 2024 08:00:14 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id kg26-20020a17090776fa00b00a449026672esm9154370ejc.81.2024.04.04.08.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 08:00:13 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] net: dqs: optimize if stall threshold is not set
Date: Thu,  4 Apr 2024 07:59:29 -0700
Message-ID: <20240404145939.3601097-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are three patches aimed at enhancing the Dynamic Queue Limit (DQL)
subsystem within the networking stack.

The first two commits involve code refactoring, while the final patch
introduces the actual change.

Typically, when DQL is enabled, stall information is always populated
through dql_queue_stall(). However, this information is only necessary
if a stall threshold is set, which is stored in struct dql->stall_thrs.

Although dql_queue_stall() is relatively inexpensive, it is not entirely
free due to memory barriers and similar overheads.

To optimize performance, refrain from calling dql_queue_stall() when no
stall threshold is set, thus avoiding the processing of unnecessary
information.

Breno Leitao (3):
  net: dql: Avoid calling BUG() when WARN() is enough
  net: dql: Separate queue function responsibilities
  net: dql: Optimize stall information population

 include/linux/dynamic_queue_limits.h | 45 +++++++++++++++++-----------
 1 file changed, 27 insertions(+), 18 deletions(-)

-- 
2.43.0


