Return-Path: <linux-kernel+bounces-97294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D855C87685F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154751C20FBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515345916F;
	Fri,  8 Mar 2024 16:26:18 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21957250F3;
	Fri,  8 Mar 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915177; cv=none; b=WcaYzIOJgw7q3VO6UEnWQ+PNTCTfnTuIfGgzDJ8Z8ypu26I0ScnP40ZG6fAGcSd3lpf2n48GT644TGPEbax7hl/EDL2SU9HvXlI/dyEAUtaIqv94PuvMGJ7dmMkBBGo7b+9pwX1jviAWPlchxzuV/ERCSFiPDeXdrJkXm7fswOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915177; c=relaxed/simple;
	bh=Q3Pupgvnu/q144qS+adWPKgFTyXP4WAJah2ban/vTUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTF2B1TTWHP+Y1/bcyXVC+PP65rURd2tF1EdRL5WXJR1hJ2rrdWdOn+8AZvsPasSO5/saRcLGQnULIkNCChzwe0cEFv5/leuIKx/k2nqTF5vVPyY62Uj2pevZBvII5v3qGhkMmFYDZHJ+a3cn4m1luf6xe6jKMD4OHLfBf/rmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-568107a9ff2so2612508a12.3;
        Fri, 08 Mar 2024 08:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915173; x=1710519973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJxifVLROjGKsQmtNeatFoAmB7soq/2hZXteys/ymb0=;
        b=LG/k0gxPQXldCwiYsoftSOO72FHmW8W+uNVqNDIY/Fhy1Pn/AxskAf0lRvFDlT6A/Y
         Aou0JyorAZU/+T9zeyWe+Buk2ImBlGd6TrlIKAps2+Sp2CbCgc7BbB9AZFm9XjvdaLzS
         bNtS1ENJPANzdnEW5TFL8UtLLp5sNl36Yo5Ckn+bJA1Yo10F+P/wfxyiqp+0jSiZKZe2
         xnSds3oedU88sLB7k1PISP9MZRKPmIBtqTocB382sq4M3Pn8LQTgMwudp6gYXlKDoqT0
         UxtkJ6TOvYe3gBTL01wU7axdm1VVNkyy9C0zxkUruO8ql+BhUPC9pna7GW81ZNoiEiEU
         DoFg==
X-Forwarded-Encrypted: i=1; AJvYcCUOEBiykJ8th/jRjosfhEjy5AaSEktVOzn3DDePEqRH5Cdc7vJvu7fBH1edTMEtbQtzlChrBt0R0mNLE6Qvd0YzGXLb2FIqE/7Lxne/
X-Gm-Message-State: AOJu0YzzZ63yyJ8CiqMlY8vwkI2EUjfWZLf8ZX/s8rq0Cpjxcn3ICFI2
	oaRsJMindU8OZCSWLK8EnS+YnBBHThd08rrGHoM5Tz05seK7CqPynpTTKZ0z
X-Google-Smtp-Source: AGHT+IHwwnuTPO7ooGyqdKCkHTuL+Ie2QGrwyj6O3FD9unLg4mC2+oTXN+5pvMFLRkkobPJyO84g9A==
X-Received: by 2002:a17:906:eb17:b0:a45:9b1:f4b0 with SMTP id mb23-20020a170906eb1700b00a4509b1f4b0mr11448400ejb.40.1709915173148;
        Fri, 08 Mar 2024 08:26:13 -0800 (PST)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id gg17-20020a170906e29100b00a45deac10fdsm1516767ejb.207.2024.03.08.08.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 08:26:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: Taehee Yoo <ap420073@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next 2/2] net: amt: Remove generic .ndo_get_stats64
Date: Fri,  8 Mar 2024 08:26:05 -0800
Message-ID: <20240308162606.1597287-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308162606.1597287-1-leitao@debian.org>
References: <20240308162606.1597287-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/amt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index cb31d1990660..6d15ab3bfbbc 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3084,7 +3084,6 @@ static const struct net_device_ops amt_netdev_ops = {
 	.ndo_open		= amt_dev_open,
 	.ndo_stop		= amt_dev_stop,
 	.ndo_start_xmit         = amt_dev_xmit,
-	.ndo_get_stats64        = dev_get_tstats64,
 };
 
 static void amt_link_setup(struct net_device *dev)
-- 
2.43.0


