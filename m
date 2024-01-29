Return-Path: <linux-kernel+bounces-43616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2CA8416B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE2B234AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754FF524C4;
	Mon, 29 Jan 2024 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnhfaDbH"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED85103F;
	Mon, 29 Jan 2024 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570713; cv=none; b=mxC5PXRvK/bwbicOx5uqJpuJI9BfWiMS8BnlMNEPvbw7TbIsvmz0JofJmE0DMiH+eG+ErYdveHLfiOC2I9RZYb/sVa0y/ARMOuD6Jq3bS001SAnEMLEaKybGlq0Y/ijRgSa1cZytQK0oUaK35TXFpC3ZbP5k5CiyNNC5pMlLUNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570713; c=relaxed/simple;
	bh=13GmUzSo0OvnKed5uuQ3ajwvL+12lFg7NcgNcyPTeD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDTcVKT8d7lXXd7AF+Cn/CH1wvQQM/f9Q6/n1qlLj6rSb1xxjZb2r0mStm02WEqczYN6wgHdeSXp6eWSgZ5uBx6QKDDWU/1HGrR5ZrWhvl2ECcWn3U7oHT95d6mFophWCDYVMwr19R17lL90LZN9YBV7uXv4/FWBDv/zBmtX8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnhfaDbH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783f49811b2so133951685a.1;
        Mon, 29 Jan 2024 15:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706570711; x=1707175511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0NexKjD7KMwrg1NWT5wkOObrAZDYheyKqGp/AuuOK68=;
        b=EnhfaDbHup6K13FbGzJxRlOX7lS4g9xfNvwQ9SLtPcUcwhaYJcFdRWGIfgIpB8B7Aq
         EbPQWBBpY+32purDoE+kVrmq87pkAvNKnXWqTzEpjV1ZCmBTwCA2g1URfkhvBd7YYb3v
         2Ehed4teRE0AO8WulPGvSR6cTBTy1fagPZuh0W0fL8BRkjEnhukeDsYfnw1luIWvbKWl
         XsU6bkBe4vPkHl1Z04Ey9NR9TH3KsR1uYO9sjsQkWdWtdbWS/ja9YfFrnkcAYbNFzDU5
         YRhg/mbMdpW3eIBb4RSKULDU/pNedl91AlrPN9Xw3MPUGLlSd9g6TS6HWTB8QcOETRw4
         lCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570711; x=1707175511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NexKjD7KMwrg1NWT5wkOObrAZDYheyKqGp/AuuOK68=;
        b=ORd2LGA/GxQlzObDlXAX4nGUIOfOH3S+GRy+byh6tRTUKOXDjNYVmYQyLr+zPmzaJN
         PavAW3gg/7aIy3ffzqoD99/Sa9Plj030XTLrotWWPmb9+YxOKHpMd2UAujivpt/cVC1q
         XbQ70YFY83Q9dPFStmlBcZnFT9O3wn2F26K6HxswD3hzMQ8nIsr3EDOAo2Z0ZPeVBrLR
         BIJ0OdBSnc0eeeTfGSSJgWttXfANFcQfg+++2M03bP82Oz5TXm84XQd9CurpOrZzz0jk
         9yUAiFXgwHxYuGHreP7HemWsu547oyrB3X72vEoZgeUCzIV1r3a4bnKKJ3NJrQVsfeft
         EKcA==
X-Gm-Message-State: AOJu0Ywa+OufbrJZ40pBHkkSLOnnwQBm6XGrEI7ThI8+WwULzNw1/Acn
	PHfRZ356isJvDxquRQz2XGMLaDnzJYsC3kySao1t76gzA8+5feDj39cwDrhX
X-Google-Smtp-Source: AGHT+IGeWnvE867IQgfNfqZeXDse/FvvtSwE2/2pa2VKQxKAjo1uryEyh3BbfwUt0WQGT3uNASc8Qg==
X-Received: by 2002:a05:6214:da1:b0:686:ae8f:3ed3 with SMTP id h1-20020a0562140da100b00686ae8f3ed3mr7934074qvh.66.1706570711077;
        Mon, 29 Jan 2024 15:25:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXdCo0i6JM9l2b3q+7Tc6EtVCshzIDOgS3bmB27kdlMN0mFsse/IuB9j+xNOMCO5Gl5cd5N9G29hoPCh58ZXKXDQY9Y
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id lr7-20020a0562145bc700b00680c25f5f06sm3898272qvb.86.2024.01.29.15.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:25:10 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 52C0A1200066;
	Mon, 29 Jan 2024 18:25:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Jan 2024 18:25:10 -0500
X-ME-Sender: <xms:1jO4ZcM1wUn8_VnRFbcznaxorKy5NEFjokqALZB5DDqAFk6KArxLXg>
    <xme:1jO4ZS8yS-_raTCuFDxY3B1_2a-ttnONvptNgToCBjwEkwGt796atlbr1QndlyBN9
    cIm9k0kCK3IKDXpig>
X-ME-Received: <xmr:1jO4ZTTwzm6V0uLGrD1xSwYAXKXPKuNccGIE5NHtwziKjldfsdVJqtYK1M6Cgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhm
    rghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfftddtkeelvdefleeghfelleevge
    ffteehheeljeejudehueejhefggeevfeetnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:1jO4ZUtqvuZRRcs2MiHRKq1OR_j3TPBE82TAYM6WM6bUZjyTa9cZJw>
    <xmx:1jO4ZUdo-pW8meEw74NNVD6-KrDqmSlFLkgdJpl4m9tDfvsfAYJGVA>
    <xmx:1jO4ZY3MqAkG8sqdDm6m3yb-VZWysh6ecAPyD4Zj3DI3GWygT4micQ>
    <xmx:1jO4ZVqXGcR1hjAUjiDrQoSbiji1P6aXLJgHx-jQMfX1wefkJs_6WT7-kCo>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:25:09 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 0/8] RCU exp updates for v6.9
Date: Mon, 29 Jan 2024 15:23:38 -0800
Message-ID: <20240129232349.3170819-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series contains the updates and fixes of RCU expedited for v6.9.
You can also find the series at:

	https://github.com/fbq/linux.git rcu-exp.2024.01.29a

The detailed list of the changes:

Frederic Weisbecker (8):
  rcu/exp: Remove full barrier upon main thread wakeup
  rcu/exp: Fix RCU expedited parallel grace period kworker allocation
    failure recovery
  rcu/exp: Handle RCU expedited grace period kworker allocation failure
  rcu: s/boost_kthread_mutex/kthread_mutex
  rcu/exp: Move expedited kthread worker creation functions above
    rcutree_prepare_cpu()
  rcu/exp: Make parallel exp gp kworker per rcu node
  rcu/exp: Handle parallel exp gp kworkers affinity
  rcu/exp: Remove rcu_par_gp_wq

 kernel/rcu/rcu.h         |   5 --
 kernel/rcu/tree.c        | 175 +++++++++++++++++++++++++++------------
 kernel/rcu/tree.h        |  11 ++-
 kernel/rcu/tree_exp.h    |  83 +++----------------
 kernel/rcu/tree_plugin.h |  52 ++----------
 5 files changed, 144 insertions(+), 182 deletions(-)

-- 
2.43.0


