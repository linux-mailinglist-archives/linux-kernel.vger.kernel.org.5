Return-Path: <linux-kernel+bounces-77026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C203A86003D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CAD1C23FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932315957C;
	Thu, 22 Feb 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGZrPy3/"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DB158D7E;
	Thu, 22 Feb 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624747; cv=none; b=S1DEoS8ciHh3g1gkcHWdwdDsnEjp87bo/L/X/vYTcnFhvtn5N4UIA5E6zKPbIiZZmwLN/cFvilOLShrk/yEkloFgTP299xrSmVMRj/vHbwRABkBOcjyCMfz2KqCcGHJYjFoc3qOmJGIeIG/iXoElFou4YJzqH9w2KN1HUojh1t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624747; c=relaxed/simple;
	bh=Z/EIGnuYjLNrAYUnfmJi4T97HGPjIPXlLK6RZjCVmqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uetQ0cZI/J7kVI48mOOosgordsc9HxGDJukzBvvxLqh4T/5q+lGq0Dyi5Tm/L67x0bSl7yOwe0pCCIHwl/7nKNg7ycwQKzNnfnZpTtU1qGd3Ii9c095OTDsznoumiAZEMzVKT7YIb+SUQiubejT30clQR48YWUECSPP0U7fy2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGZrPy3/; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2628e81b8so7543761fa.0;
        Thu, 22 Feb 2024 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708624743; x=1709229543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bTqyc5eLl00Lab2XpbFjSYvN/btOw7kIcPOi9K55pg=;
        b=bGZrPy3/FKYsUr4VSUe6MTQx723LvRkz6A8tqWv6bO/6KQFC5YRPXXORWjKaTyj3Fq
         P0/ciaQSbqbyF1oQNhboasL/+mzWwbY92eiO6zH5oc7DSesc9VBlLADam3IAySiAnu1j
         DzsbRu+TwPPAqaxzGtTVT2zBbgEI0I92fuDUxuehNHKmuu1EavWfyVJUwwH6BUrckGDO
         M1KxwvDat/oaB3Bv4US77WE8BbGiVAyWRa50lgt/cSgwPq9JJJVAg8omU1swP+7pChnT
         KgCon99xDMNJ7snstt9MEuWGehIc7Gv+dGwaifDjW62x6t7+wqoOzCAob8qpOme+Y5rs
         RrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624743; x=1709229543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bTqyc5eLl00Lab2XpbFjSYvN/btOw7kIcPOi9K55pg=;
        b=NDVHyvpxDy5vE+qOG/xqoM3WM9oFTpncJCH6oig6q1LvAIVUDxzEkGGJ+dF4D1eYFc
         Lo0bkgMq9wFi2eWN7M2vVHBs7Z2HQj+9pmEyVXZ0exg2yukyo8HEswQBhvt4HNo75LZH
         DW0ChIcob3nt/ko0cuVx510Wu5tOlL3PqsVECH51HgEKLVZW0YsNusTEm/CuLjbBY+hD
         cLkHnwyjOv87ZNJNZrbrPtjL1YkRPXsHphP9N+eowfvJj3ZzHXvR6hbafeTkFAj2IRgk
         Ewjjriy1P5lKFP9ktMrqZDpq292MJ8VyzrbXuvPrJ0FKA9Jpbq/Airkf7xiUbrZqqSbB
         MmYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK/T7acKIqjgTEqn3+ooVF8YE5/mzWjULhOmuEWw/VWb9/plVodoBUE+RF5vRkVLXl+DlTIejXIJOk5VbZDwBQ9ET9+za8yyN/qFwaaedboX4EA31PMVYjqYpgRTvkbYH2pznY
X-Gm-Message-State: AOJu0YyixE2gFm+ghtj75M1edyXEzURf3q2imIRKDUlIXAs+uCOWk6hh
	vMosvVHCiAiqPImzfROtItRJQdLFoOd0T4+dj1I1/J4exPCUM7wj
X-Google-Smtp-Source: AGHT+IHuasSgIqN4mYlSs8rVhcBwid+S/k+ba5GORgBQig/kQBDhwbuCR6H37k2jc6Uam3ZK+g908A==
X-Received: by 2002:a2e:904d:0:b0:2d2:31a8:cb1a with SMTP id n13-20020a2e904d000000b002d231a8cb1amr1275872ljg.13.1708624743579;
        Thu, 22 Feb 2024 09:59:03 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id l25-20020a2e8699000000b002d221041b59sm2296052lji.51.2024.02.22.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:59:03 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/4] net: pcs: xpcs: Explicitly return error on caps validation
Date: Thu, 22 Feb 2024 20:58:23 +0300
Message-ID: <20240222175843.26919-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222175843.26919-1-fancer.lancer@gmail.com>
References: <20240222175843.26919-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an unsupported interface is passed to the PCS validation callback there
is no need in further link-modes calculations since the resultant array
will be initialized with zeros which will be perceived by the phylink
subsystem as error anyway (see phylink_validate_mac_and_pcs()). Instead
let's explicitly return the -EINVAL error to inform the caller about the
unsupported interface as it's done in the rest of the pcs_validate
callbacks.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 92c47da61db4..46afeb5510c0 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -613,14 +613,15 @@ static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 
 	xpcs = phylink_pcs_to_xpcs(pcs);
 	compat = xpcs_find_compat(xpcs->id, state->interface);
+	if (!compat)
+		return -EINVAL;
 
 	/* Populate the supported link modes for this PHY interface type.
 	 * FIXME: what about the port modes and autoneg bit? This masks
 	 * all those away.
 	 */
-	if (compat)
-		for (i = 0; compat->supported[i] != __ETHTOOL_LINK_MODE_MASK_NBITS; i++)
-			set_bit(compat->supported[i], xpcs_supported);
+	for (i = 0; compat->supported[i] != __ETHTOOL_LINK_MODE_MASK_NBITS; i++)
+		set_bit(compat->supported[i], xpcs_supported);
 
 	linkmode_and(supported, supported, xpcs_supported);
 
-- 
2.43.0


