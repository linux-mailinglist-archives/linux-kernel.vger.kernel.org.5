Return-Path: <linux-kernel+bounces-139766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E978A0777
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F7B1F252B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081CD13C806;
	Thu, 11 Apr 2024 05:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="xWdhQNFY"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B513C3F4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812304; cv=none; b=cDd5FpW701GWSWZG3UYymJ6QYZBOy3skWK4PEB56fa3/N2SxNWL70ITIpwWPo+3Q9onn1b71RT3fskl2mBK9lOzDHE/HpXdSPx3Jx1B4KzR45AUjQ7+JjfBJYwmaYORfz632MxUNKRtiMx5frhViFz0fNlu2DPOArXcVnBqsanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812304; c=relaxed/simple;
	bh=eqKzfNEMu+huefit3g4pn5FoMsoCmnjs0w4DjLQ9syo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQR9vESaS163RY3VTVruXD6e50V2vRt+g4BoS37MPdeImJipI9AqZ8iDXK4vkytePQGI0Pdvel3gwyLUT2FBonRiKNP9NN5CMWSfaKOlk42NF/QVYmWGBimkUj9AqcCWVsk9h5uxkdX6hfNUIEBi346gbQmUntrvaF71uQAVpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=xWdhQNFY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41551500a7eso57474405e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712812301; x=1713417101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1XDD90AWzc/KDkSNe2VgDtV2pTCGWasSc0lX5ppAyo=;
        b=xWdhQNFY8XWkockbveuV4gAXGxvGhJWtPWASj3iKU5oosO8utPesy2ukjEEEPfOuif
         Lj7Hw1lkEuqpe6t26DTPUDZqvX7mThM+VCwoQPN4DdB0Zh1cNimBJM3RF8TnZ0ciwiAW
         zaF6Y5/xdzCb2iqF3qPjIysDTVcY707SnQ2SczXsmPc3maM2MdbN+bROvlXE7tGSBGA4
         mcoEJCtBQYha5+1il5eB6bXW6eE6AW7eV05ti2TWpoFl8rI16FBmwdiWxvtmVCxuhzW1
         gkkW3zwM4U6Sy1UEiuD4twcps33fU11L3rbncUN/9xQjCYRLvrY0ll0bjyFi6MQmljfO
         xVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712812301; x=1713417101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1XDD90AWzc/KDkSNe2VgDtV2pTCGWasSc0lX5ppAyo=;
        b=FDBhdPmt/V6eIbYQbXBdG8Cfo3rO/78uZFRdiusV5ncvTeV5hrEh5CulgE1K/xYfjg
         8GimcaezD9GIX9gIkymUZZ7b/RQ1Iz8fBCMRCBnCmfb5r3qNDaD4iS4Nx35ltPn1qYOA
         wB2Ta1KozdzooeSekhbt3mBYRyIkw/2hE2YqrfC3GQbhBDXJbLnbIwIHccT49gB8vhD+
         pEWcn7oeBy4L2VIJIlW5B6kOFr7JhlRPwLFr4ZLrgDF2OaDrY6rtVlbFPlf9y4EHCy5G
         g8Z742kyi1xGs/+UUfI8GfUqSRuo7Z6Sjy0IglVcGzcjOLLGEwYO+dCeL2dIAl1Z9Urj
         G/8Q==
X-Gm-Message-State: AOJu0YxYKSjNkj0yyDR6LjJs4EWtxFT+iwisyE0Oq6XEgd2v/OFGYJ8U
	U2rAT0fgw2cx9T2K0dbakAAbtwzs+Ra8kGGPkz9zYVivf+dfgNmKdSQJiTA6Efw=
X-Google-Smtp-Source: AGHT+IFrsYS9Liwv2FaXJoTlVoOGxdTxr8zhnBZ1Zxxsie09N3MqZMCUxKWrFSuqivi0LdxMInoJoA==
X-Received: by 2002:a05:600c:1d21:b0:415:5fd6:44c7 with SMTP id l33-20020a05600c1d2100b004155fd644c7mr3232445wms.27.1712812300902;
        Wed, 10 Apr 2024 22:11:40 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:46c7:8900:15f8:24e1:258e:dbd5])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b0041622c88852sm4370190wmq.16.2024.04.10.22.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 22:11:40 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yan@daynix.com,
	andrew@daynix.com
Subject: [PATCH net v2 0/1] net: change maximum number of UDP segments to 128
Date: Thu, 11 Apr 2024 08:11:23 +0300
Message-Id: <20240411051124.386817-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1->v2:
Fixed placement of 'Fixed:' line
Extended commit message

Yuri Benditovich (1):
  net: change maximum number of UDP segments to 128

 include/linux/udp.h                  | 2 +-
 tools/testing/selftests/net/udpgso.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.40.1


