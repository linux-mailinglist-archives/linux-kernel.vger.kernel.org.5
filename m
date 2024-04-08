Return-Path: <linux-kernel+bounces-135745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6538E89CABA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A25B21918
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D5143C59;
	Mon,  8 Apr 2024 17:26:16 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD247460;
	Mon,  8 Apr 2024 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597175; cv=none; b=p04EzlOcwJ4/v/HyUA/iFt8GxRo5nXF6/tG6nXefAfuobvmYRANcOZFE//cbq2DqHfrGfLQL8Od3qZG+okZPAn0U7sPumNtHrPDujxYziSa1rGyd/0IMZFpSyEaPAduxqAvwxommohqY2NOncX7WsOoo6XH+/VN5GK7anauoTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597175; c=relaxed/simple;
	bh=7kdOk4ITZylKnr8pBP2i71I3BILRIe0aVqKcpr7nQas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5iTq5buceSZ/E+bLA/5ncHDF+H23bJiO8h2Hj5lu1jfx2EiTj/WhpybDXc7J+LsjMjFcYgklfstwW1FyOBxeTMordpo+xvhPIsMmgnhKcS6T7yoWmVOyS+f1uEZ9nHsjcVdFIP7QMI5SuxHQf0/5fS63/9195JiBcTqV8SWVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so1249582a12.3;
        Mon, 08 Apr 2024 10:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597172; x=1713201972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXqKi997L3PagciIuldmRmvr0R9pdf27i5jWxsqbl7k=;
        b=w9xEG/coOOMLYe+jeECThqKMU4bgc8/BdU/UfeUk0KOoJI4Z6kt//ZSpjN7/MgJvlP
         KPO217y9eJUyxRjwT7bsxPxXtgP3jDV3SxePXRqzUztaPudU040mH5pCcU3rtmHBrf9L
         Sy9vPodStIllrl+AfKOfj4/opitMfGlrSt9Xb4zHu4w92OhieHFHyiIBq2UF+eSqOG+2
         dJeROkT4I63LZXPMOy4eKp0EkqBq+NvrJHR3XuzSLVcYdUt7CW/uQGakYO95wNp4RwnU
         b9+4Henlo7isza0YUkpfI+xzg4a90M8DAPKGOmrDKzmLozdEZQyk1TZnYMDLUlYxJwrC
         KnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ9fOgyk8+MEXICzBGXDqP5+qVZ7uIg4f+GbUbCENDxRfqQKSjKag4oGPBUpVu5NqZPrsElyg18Jjg8CBpSiVqSUeW/pLD
X-Gm-Message-State: AOJu0YwSJ8K1XuUMf79VQtJiLuCKbVIGugcr88kv2+cmO8XY0yOnM6aG
	90dO2tCZ4tjiK3F0dsYHwKrse+omLMfP/DXBGxUUktmPJ9xMhaKs
X-Google-Smtp-Source: AGHT+IEsOOE3bcXYiFnIV+Lmdls4F+bKEio38wciboMmKVKKIZoF0r8mLFYbPnS9wMO6DoxP9WjbaQ==
X-Received: by 2002:a17:906:cd03:b0:a47:4a32:604 with SMTP id oz3-20020a170906cd0300b00a474a320604mr6100227ejb.26.1712597172180;
        Mon, 08 Apr 2024 10:26:12 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id dr2-20020a170907720200b00a4ea1fbb323sm4645341ejc.98.2024.04.08.10.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:26:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/4] net : dqs: optimize if stall threshold is not set
Date: Mon,  8 Apr 2024 10:25:52 -0700
Message-ID: <20240408172605.635508-1-leitao@debian.org>
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

v1:
	* https://lore.kernel.org/all/20240404145939.3601097-1-leitao@debian.org/
v2:
	* Moved the stall_thrs to the very first cache line, as a new
	  patch. Suggested by Eric Dumazet.


Breno Leitao (4):
  net: dql: Avoid calling BUG() when WARN() is enough
  net: dql: Separate queue function responsibilities
  net: dql: Optimize stall information population
  net: dqs: make struct dql more cache efficient

 include/linux/dynamic_queue_limits.h | 50 +++++++++++++++++-----------
 1 file changed, 30 insertions(+), 20 deletions(-)

-- 
2.43.0


