Return-Path: <linux-kernel+bounces-77022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5F9860034
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D97A1F2551B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04EC157E66;
	Thu, 22 Feb 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNz41QyK"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD2155A39;
	Thu, 22 Feb 2024 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624740; cv=none; b=KwJ77qylUX/Fa7VnySA7RxIOXJp1irHUg+iRarXgr8uU49Guo0aqkPMiaYtKXKi+LFKad326GxReEKtxV5OX+mkTMnckgN3mZYzUkJn5J8AN/FBEE1eRch16OLX7WOrejmaGrb8mUv4W7qkhvdghrhJXW7UfDqzZY6Ugt12+eMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624740; c=relaxed/simple;
	bh=dtBzsaFY2WAwF8areVe2KKs9tKw0qlKHLRdFyfRgo88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtXUBBOaIeGV1j04AtmWNUFO72UpmGW2AoVH+/hC0M72EPqIt/+HjFMcmLLQXkptXlF7d+HzHj4pCWUrmMdM172B0ugnXtbAmcAx6s9gbmn/tnPr/sgA/5GOrFEh8oMVFGB8se20Nr03JlznJsg4yIiBm+Dp0VqINQJQKsNi3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNz41QyK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so79761e87.0;
        Thu, 22 Feb 2024 09:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708624736; x=1709229536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cz55Zzpfo/zk1u1UrDBK1WZgp/imaYiWSbF3hiJkto8=;
        b=lNz41QyKM865/qW65ukfrWp19vTkOKB1S9XbqlRc03WFI6hfOE/5WfIus6LKBBpAsL
         NffQr1psmxgIT02yYJw3nZ9W3zf6o6iI6pPlBKV/PVLrtMrCO39dtXT0nS1fY7LnymR9
         /ZcneRIGn9A3qA6wm9Rx7oDBM24vUUUiPJ6g3YD4tmAiu5BSDzvW5PVEoWlVdF+/0OxO
         SIidvCEEBI7XKFT+0qqhy3LSyT0TndC0QbI4OM9MkBxD+XvVzhKwt5yUTbQLefRWZrwu
         ngvZDaDi19zkLlRMuSDP4ggA6sURHjr5SgoPNs0jmLjai9xpzJ79kFShGHzJdGOqhyAw
         LhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624736; x=1709229536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cz55Zzpfo/zk1u1UrDBK1WZgp/imaYiWSbF3hiJkto8=;
        b=wKOYsSmmWOqcKz96TSf69N3utAFwaHKBxbhwq6u+GPhgvYDElEH77pyPD1QD8tBoeh
         HSu2+VLQ/aS6tYPKXcgFHLwg1ualpK+qeiY+U+7VgGDRZVJjU6KjJxM6DWloxbQQu72K
         4GkHflfboyf3Pko3hvMFhZU2BFf+kVLR6MGe9MC1y3roDvnIN3zZicxnkpvjsO141Kz9
         DlsLod2bwUeh+e7rRCAD3fEGL2XEk9Yh5olshiuen78urZOHv4+p0CZRfw/BX1Fapji9
         SFlHSmoVerBafTlJTDRrv7cDtfBdaXf5BduKiENZaaRIgzNOBcxgcKSVU4cX9aAsab/C
         lRkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsCYwT80ebkSvTkq7kgNk1ETO6ujSFVItkpB9I0IkJmXh/HzN/29hUbmqEzm4sAiThXX2FE+vLI69+sRKlHPpLUaH83ZOsKRHmAvQdNh2eGXkc7CpP/REOzV9jVsEfPPZGd2hP
X-Gm-Message-State: AOJu0YziKGKP1orAYb/q8pJhm1kwiQkX6IBVgnVkrhqjh9I+/BRzqxhh
	hhMSQJYZlfw79kmxLor+UGGW7HSFb3DuDD//iabyx6KPWqWMVJMgRCkvdGV7rA4=
X-Google-Smtp-Source: AGHT+IE/1Dk0fjNMEbmuMP18Tm/K1SfZnMv41lhns0HjNNdVpdbheULkXP3yVIXQIWLc1QyRxeNXzg==
X-Received: by 2002:a05:6512:2349:b0:511:6c63:f76a with SMTP id p9-20020a056512234900b005116c63f76amr17664673lfu.41.1708624736307;
        Thu, 22 Feb 2024 09:58:56 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q25-20020a05651232b900b00512a949a4d6sm1957987lfe.7.2024.02.22.09.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:58:55 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/4] net: pcs: xpcs: Cleanups before adding MMIO dev support
Date: Thu, 22 Feb 2024 20:58:19 +0300
Message-ID: <20240222175843.26919-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As stated in the subject this series is a short prequel before submitting
the main patches adding the memory-mapped DW XPCS support to the DW XPCS
and DW *MAC (STMMAC) drivers. Originally it was a part of the bigger
patchset (see the changelog v2 link below) but was detached to a
preparation set to shrink down the main series thus simplifying it'
review.

The patchset' content is straightforward: drop the redundant sentinel
entry and the header files; return EINVAL errno from the soft-reset method
and make sure that the interface validation method return EINVAL straight
away if the requested interface isn't supported by the XPCS device
instance. All of these changes are required to simplify the changes being
introduced a bit later in the framework of the memory-mapped DW XPCS
support patches.

Link: https://lore.kernel.org/netdev/20231205103559.9605-1-fancer.lancer@gmail.com
Changelog v2:
- Move the preparation patches to a separate series.
- Simplify the commit messages (@Russell, @Vladimir).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: openbmc@lists.ozlabs.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (4):
  net: pcs: xpcs: Drop sentinel entry from 2500basex ifaces list
  net: pcs: xpcs: Drop redundant workqueue.h include directive
  net: pcs: xpcs: Return EINVAL in the internal methods
  net: pcs: xpcs: Explicitly return error on caps validation

 drivers/net/pcs/pcs-xpcs.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.43.0


