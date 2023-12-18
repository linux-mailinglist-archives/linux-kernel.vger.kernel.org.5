Return-Path: <linux-kernel+bounces-4445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D99A7817D31
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683F6B21BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727A76098;
	Mon, 18 Dec 2023 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKlR7InW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2868D71470;
	Mon, 18 Dec 2023 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so38107955e9.0;
        Mon, 18 Dec 2023 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702937916; x=1703542716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKxmXgd84F0l1C3rdxwz9qBQGX032HUOjc/IMT1HuYc=;
        b=dKlR7InW5uhDWc5mu4uccAZ0T6mRDNZk3FSz3nynJwf+ex9bA23u2KJRFjEbyjSwmq
         ljZGbiUhnhBnByQ3pUMyokpOAExUxXWjhGw7BQ7Hbm4PE0LjuKZFE6BngHTx303GkqXf
         nrWmJdBsxbalxpZ/MEqTA2fBNj1XeeV97n3hc+o0B0FiXj91qpTT1sMjrx14GGdfOpk9
         +4xK1d40Kc8fPPGJit8jQC9Zw+nWCQijSrh2SmOuRsmLNISarCbSvVB9O3kLO/M2nEqA
         8IKXEpb57U+KlXxMcys/eBGMoVkKAllSR26aVjHijITanZx3rMmUo36Kot4E5xqODtMg
         4aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702937916; x=1703542716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKxmXgd84F0l1C3rdxwz9qBQGX032HUOjc/IMT1HuYc=;
        b=wSzGfafRF/0yqlv6X7b7PoqA8dUxIuHkrld6+CDwA6+MTRhWjsvtK+H+kDJ4k18wNn
         Hf/KpIuH3tgxz78Lzw7Fp295ObeiTPPtZQxv5IQfnPSiz7LPB/7mbUgE1yO0bLthRZ2b
         3CDoLp45CDBUf9rC4rBLQEv4kZ+/vvdPAOziDpYMu2RLi8I3n0XXEefR1UHd2uKzqLNU
         mOuegFSDRw91i8fNDdFD6Z/nomg1QnO4Dnu0JQQOU8VzCbWs+Fdy4rAqumUj6fRFhec6
         XOASYHhEd7Zc6f/f0nJR6uTObFkdB7ofvXcLmBhYnqyDp2+PszadmBqI7i2c/wrMUZqW
         kUcg==
X-Gm-Message-State: AOJu0Ywkfrhg6eT/ci3LwSpg+DbWlD7FTAGDMuBBTkT9g8l4cWiAJK+k
	0Qf+djxiurezi2M2R4BX/Rw=
X-Google-Smtp-Source: AGHT+IF+FFQWtym9rQ6akSd1UL7fu/Rk5wBZt6VirWA5sxLt+y2oSTB8TSc1AFT2bEKk8wTHNcojZw==
X-Received: by 2002:a05:600c:3790:b0:40b:5e21:ec3c with SMTP id o16-20020a05600c379000b0040b5e21ec3cmr8387726wmr.110.1702937916252;
        Mon, 18 Dec 2023 14:18:36 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c34c900b0040c2c5f5844sm86928wmq.21.2023.12.18.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 14:18:35 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: phy: Support 100BT1 and 1000BT1 linkmode advertisements
Date: Mon, 18 Dec 2023 23:18:14 +0100
Message-Id: <20231218221814.69304-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218221814.69304-1-dima.fedrau@gmail.com>
References: <20231218221814.69304-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend helper function linkmode_adv_to_mii_t1_adv_m_t to support
100BT1 and 1000BT1 linkmode advertisements.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 include/linux/mdio.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 007fd9c3e4b6..322c7a5092e4 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -408,6 +408,10 @@ static inline u32 linkmode_adv_to_mii_t1_adv_m_t(unsigned long *advertising)
 
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT, advertising))
 		result |= MDIO_AN_T1_ADV_M_B10L;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT, advertising))
+		result |= MDIO_AN_T1_ADV_M_100BT1;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT, advertising))
+		result |= MDIO_AN_T1_ADV_M_1000BT1;
 
 	return result;
 }
-- 
2.39.2


