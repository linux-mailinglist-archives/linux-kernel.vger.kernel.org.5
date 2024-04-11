Return-Path: <linux-kernel+bounces-141524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B578A1F66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211411C22C53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74E214F65;
	Thu, 11 Apr 2024 19:23:17 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8571798E;
	Thu, 11 Apr 2024 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863397; cv=none; b=N31QlApxwAjqdLKZWej1aGf2QWhFIBP2BL0rxio/IFzW90kZPUr8dZTsWtESnXk/9aJXUQGXcXvYNSgBdV2gMOE0XCQFhUUnyHxR7QsEJK2hoG6QS2Rfp0/RZ8H9AUl0Gwf/79+F7j3RCmmwWm14+n8yjaj0C++fTcXtBjtHaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863397; c=relaxed/simple;
	bh=TI1GSDhfKjhAQ+1D3J9jkicNBNjV6XsaqUxxT18ZyJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFM2gMk4zTye4k7qhSdXBN+lv4V/HsUnxtYo2RyAmk1NHJ15A7+6rwY0vT3NjmAdg566ajFUTJvTOdHO2X2ebE6EwLNBS2vQKHbb4uGAyTc8PJgE4vrJBCZAG+7e2+EE4kAd36s00ib1BkS+FEnJkRJ29ghi93gPgpZAyqnA31s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d82713f473so1924211fa.3;
        Thu, 11 Apr 2024 12:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863394; x=1713468194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIBXaQpWGDZLuod73VoHOj9O9W3K2JcAK0KSYOPcVaQ=;
        b=Iwmq8EtglV3xjWL8QawG2znIS5Putzew9DI1upEvDpeF1bjrp+v9MXieIbbi9G5v7h
         asrrM+GGMb3rqdV1E4U7rmjwnOddIfmMrgyE93ekiBCsVjH8iJsxBxuTBwSkMmWJem/j
         lIAhYkr+HGeNv4WfRbc2UQVxhe0f/XBxbHYy68EWyuSHMWIenTRCGlynfjI3JtaRcm1t
         qloJgswBqRLn9wOCqTvRwh4bHDJt/vVPkoGZ+0uh2IfpaZCW6hupCmLK/wYYExjPz5M0
         YykH8uZtWRVmPA4N9DuKSk8aG7kD4lHYfSI4SQdbpgKoAKfZ10mKslq3EiH5ueeidJ67
         8GbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUAGssXj8CuTkBv/mslP2jfWwOCCe9IVb678Nawh3Negok+E9AcY2oJ/0sa1Q3XDbnZe3QFiNtTOpgcmJr/UBsjNPs78nc
X-Gm-Message-State: AOJu0YxbEtEmNhExHUJnIgWHQfFa281ISOzdM7l+FtFCMwz5c3kEG7Q2
	R3WhL18RMY6cnIvwrxMdBOvwHPgStSh2D6uhi9CuLyHZYI/0M5yp
X-Google-Smtp-Source: AGHT+IEt7RbiKpbYhIe9xJ71P9L1Z5U6C0nSsv1vHmYIfX0j8xDQZwFKW9WvmOYy3SPWHCY4MCN07Q==
X-Received: by 2002:a2e:b00e:0:b0:2d8:36f9:67af with SMTP id y14-20020a2eb00e000000b002d836f967afmr353683ljk.44.1712863393363;
        Thu, 11 Apr 2024 12:23:13 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id q5-20020a170906360500b00a51da296f66sm1016692ejb.41.2024.04.11.12.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 12:23:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 0/4] net: dqs: optimize if stall threshold is not set
Date: Thu, 11 Apr 2024 12:22:28 -0700
Message-ID: <20240411192241.2498631-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are four patches aimed at enhancing the Dynamic Queue Limit (DQL)
subsystem within the networking stack.

The first two commits involve code refactoring, while the third patch
introduces the actual change. The fourth patch just improves the cache
locality.

Typically, when DQL is enabled, stall information is always populated
through dql_queue_stall(). However, this information is only necessary
if a stall threshold is set, which is stored in struct dql->stall_thrs.

Although dql_queue_stall() is relatively inexpensive, it is not entirely
free due to memory barriers and similar overheads.

To optimize performance, refrain from calling dql_queue_stall() when no
stall threshold is set, thus avoiding the processing of unnecessary
information.

Changelog:

v3:
	* Read stall_thrs earlier, at dql_completed(), to avoid any
	  performance penalty, as suggested by Jakub.
v2:
	* Moved the stall_thrs to the very first cache line, as a new
	  patch. Suggested by Eric Dumazet.
v1:
	* https://lore.kernel.org/all/20240404145939.3601097-1-leitao@debian.org/


Breno Leitao (4):
  net: dql: Avoid calling BUG() when WARN() is enough
  net: dql: Separate queue function responsibilities
  net: dql: Optimize stall information population
  net: dqs: make struct dql more cache efficient

 include/linux/dynamic_queue_limits.h | 50 +++++++++++++++++-----------
 lib/dynamic_queue_limits.c           | 13 +++++---
 2 files changed, 39 insertions(+), 24 deletions(-)

-- 
2.43.0


