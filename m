Return-Path: <linux-kernel+bounces-19284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 190FF826ADB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8194282867
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59F13AE2;
	Mon,  8 Jan 2024 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4QCDGLN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB512B6B;
	Mon,  8 Jan 2024 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28d25253d2so157379366b.0;
        Mon, 08 Jan 2024 01:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704706723; x=1705311523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwtEGBKue4JW01UC/X1KgpKlH7eEcJJtQh1fhUNInlo=;
        b=b4QCDGLN5I6uxwZePQiraZRHDooLWy1KU/4e2w9gHyPl4F1TlBUCaUOWnhhbsLtv82
         de5Bcs/9qJni2oCkFCKRP6JTB0J/cHiKN13ZQk7QHnvKrW6dwBCE1dKe6/aC1zzVJfkB
         lMATm1T0XSiDRwpU0wkBzbnm6KS28iYHAuINnAXQk2LJG11JZH6BzSrEUSGiQ1SnowZV
         yN2Holb1rqEkqO+fy+kSXpgiqCYkrStxLL/JT4oh7JXuISmnWSeicrXvOQOQmCZWq12C
         t3lak7fR50oAf5zeYwXiqCB3gaSHkBWUNGGPKjomCzcxSdmLVVavVLfqYN9aZPdhtiLG
         Xk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706723; x=1705311523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwtEGBKue4JW01UC/X1KgpKlH7eEcJJtQh1fhUNInlo=;
        b=UjeQUww3M8RpWNlHW4+5k7fyA01BvkGnBvQlBiX7lF/dzkcRqZ4rIbfeACt6hJP1Ut
         c477Gg91K3RKQRlYyVKFJKfMr5tl4Rg851+lQ/IxUrLkK7bRbBsCcfb2hSMYUTY5Izmh
         lTZ1ksRQDozfF46Ozj9DJ+ntFfin/9on7nXALChqE9+ZxGZCDVC/ndZmjrGyAQL6OCMR
         i7GOHdn97bz33Ph+7GRACtoYWAlvIuixyp3PKsTMTWNj6A4oHcxumA73xzKnKgjFvJun
         PjwTkfFxKzWqpYFc6dHjpCj0Xb9Njjrp4htLRPk47lYWPKBfUhYgTC4GJYh7ip6xn6pp
         0sVQ==
X-Gm-Message-State: AOJu0YwZI6KSnGiRc2yBh/Ki18mL1y8PHW7DePX8LpZnlz99vGJ4IJqL
	eK3SR5ra12PfFbBSIJeWbBM=
X-Google-Smtp-Source: AGHT+IEHsKXSWX0z331I/UVixFf2/4cPl7Jjq2WA3i3Okah8CEiq3sPUrugq948yR+m7c2m45o6Ahg==
X-Received: by 2002:a17:907:9257:b0:a26:8f35:7130 with SMTP id kb23-20020a170907925700b00a268f357130mr1164052ejb.48.1704706723469;
        Mon, 08 Jan 2024 01:38:43 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b00a2ae71cee2asm326851eja.177.2024.01.08.01.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:38:43 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net-next 1/5] net: phy: Add BaseT1 auto-negotiation constants
Date: Mon,  8 Jan 2024 10:36:56 +0100
Message-Id: <20240108093702.13476-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108093702.13476-1-dima.fedrau@gmail.com>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added constants for advertising 100BT1 and 1000BT1 in register BASE-T1
auto-negotiation advertisement register [31:16] (Register 7.515)

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 include/uapi/linux/mdio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index d03863da180e..020ccc810d23 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -348,6 +348,8 @@
 
 /* BASE-T1 auto-negotiation advertisement register [31:16] */
 #define MDIO_AN_T1_ADV_M_B10L		0x4000	/* device is compatible with 10BASE-T1L */
+#define MDIO_AN_T1_ADV_M_1000BT1	0x0080	/* advertise 1000BASE-T1 */
+#define MDIO_AN_T1_ADV_M_100BT1		0x0020	/* advertise 100BASE-T1 */
 #define MDIO_AN_T1_ADV_M_MST		0x0010	/* advertise master preference */
 
 /* BASE-T1 auto-negotiation advertisement register [47:32] */
-- 
2.39.2


