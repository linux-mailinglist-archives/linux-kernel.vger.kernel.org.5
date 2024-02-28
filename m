Return-Path: <linux-kernel+bounces-84922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3950B86ADBE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AECB1C21C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FAA14EFEB;
	Wed, 28 Feb 2024 11:32:05 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88314DFD3;
	Wed, 28 Feb 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119924; cv=none; b=Xdnt02LNfOQ3J2eWC+Rvg4i8tblCaElqUME3KvG8OAYuUQseOOdn8nz89LBND728PKimUYaf7FYZZCxFgSJ0kT+KDRkJAZ5TcYqlE411OoXYziJpqCz7Wn3corJdnAXtpg31e19tzhonsJ6t4aVcFj6bQ+5kNbrE0kVhRj0xJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119924; c=relaxed/simple;
	bh=M42cRr9evUR9Mr0JSq1IeJJSWj3kvBrf77cxCU4NVhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJKrspOEGAk+lIsmBM51kPygIN5BWnX1hJSNjPr2ShF0W2ZQsUPBjUy8IJTPRp0nAqJ53dlEFb+YcLGBiAGEmLxRRYeT35KGyVLHRqsXOkytytqNBeD1xCXArl5XcQ22kcjBH1Mj+CYPaKlD4Rs3vW0OY51bIObtkqP1PXFFPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a43f922b2c5so69130666b.3;
        Wed, 28 Feb 2024 03:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709119921; x=1709724721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeRdk5nsJWzv2xbJPbFyJWHca2KgoSDk84tifNfmBI8=;
        b=ckMFm2E1+8R0znaL8z3/V7tLd2oB0das6N0eDzfPX2deMnYNwNwjYTYHl8D6razvF7
         BgdRxfQM3C7kyZmuRVHpYz2oR6wNLfG73oK2eSVbl04sgbSwPmZNiwqQDk2ehpnNZcqX
         PapVdPqG8t+qzfBmFMv+ynOK+xOUtGNTz8SK50WuqhLjleZvxwPDb6t6wgrrMJ8iIIjO
         wlv6wP0i0t7p2D1pNsofKdKDwhli7esUh/l5MG/XUmAyq+9+6C/rf0TSHUdePnnGBcmN
         zr9uciI06jqBIB+aLTA4iv87S+pJkunZ9SGy5aFdSnxWJn86RLYokqNkpgVusa0IahtK
         fNYA==
X-Forwarded-Encrypted: i=1; AJvYcCXJuhJ+NzUsSti3Dx94VWNJbknkdPcRhXhPbwR881FnkK0UoKK7icQo2XpBSGMQi1faiGEmSWW4vANoYUnaFkUmMA1ZrL/ORocXjbpe
X-Gm-Message-State: AOJu0Yw65fvr+43mSn1F5TccMYP3q1+FVmU0gNANjJLf4BovGoalWsyA
	rSrOvN+SHHI8wOO3DQxjCs3iW+Kp8PUypdCOZeudB+Iy+qrbIKFU
X-Google-Smtp-Source: AGHT+IF3z7GP3/H1N4q1K4u1BmTqW5idwzXmlZlHj90TqM8VUsFO4aGGRLci4uTMbH0nKNo6EoqWhA==
X-Received: by 2002:a17:906:4ecd:b0:a43:b472:9a57 with SMTP id i13-20020a1709064ecd00b00a43b4729a57mr3038624ejv.62.1709119921217;
        Wed, 28 Feb 2024 03:32:01 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id ef3-20020a17090697c300b00a4396ea6628sm1736864ejb.210.2024.02.28.03.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:32:00 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next 0/2] net: collect tstats automatically
Date: Wed, 28 Feb 2024 03:31:20 -0800
Message-ID: <20240228113125.3473685-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf") added a field in struct_netdevice, which tells what
type of statistics the driver supports.

That field is used primarily to allocate stats structures automatically,
but, it also could leveraged to simplify the drivers even further, such
as, if the driver relies in the default stats collection, then it
doesn't need to assign to .ndo_get_stats64. That means that drivers only
assign functions to .ndo_get_stats64 if they are using something
special.

I started to move some of these drivers[1][2][3] to use the core
allocation, and with this change in, I just need to touch the driver
once, and be able to simplify the whole stats allocation and collection
for generic case.

There are 44 devices today that could benefit from this simplification.

	# grep -r .ndo_get_stats64 | grep dev_get_tstats64 | wc -l
	44

As of today, netnext only has the `sit` driver fully ported to core
stats allocation, hence the second patch.

Links:
[1] https://lore.kernel.org/all/20240227182338.2739884-1-leitao@debian.org/
[2] https://lore.kernel.org/all/20240222144117.1370101-1-leitao@debian.org/
[3] https://lore.kernel.org/all/20240223115839.3572852-1-leitao@debian.org/

Breno Leitao (2):
  net: get stats64 if device if driver is configured
  net: sit: Do not set .ndo_get_stats64

 net/core/dev.c | 2 ++
 net/ipv6/sit.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0


