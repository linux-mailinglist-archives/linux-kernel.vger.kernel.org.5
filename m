Return-Path: <linux-kernel+bounces-4444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950A4817D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE461C22C88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E20C74E17;
	Mon, 18 Dec 2023 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNneC3eW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3E67349B;
	Mon, 18 Dec 2023 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3366827ca79so1455660f8f.3;
        Mon, 18 Dec 2023 14:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702937907; x=1703542707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjNyfg9b/oa8PqsdonOr0+sP3WwEoMGtYWMIoH9NCVc=;
        b=BNneC3eW6UBY562oVFewtjyhpmr2IWfmOthN9vjd7AXHAahU+1G4X3IhLyMYwWz79S
         /GVIftYP941VP/vdrAmEZPX7rHENnuCj8mAoo0QywiFAlwrl8TI9edpr3dGSb0x7PMBN
         XcCeiPgUUortxEvNWlpWWNYE5/vAev12fs2MDRyf1MLfnmeS3BFBohPWx9oUTFxyAJCL
         9brVCg9PN8INIcykf1M38W860txmFAWc9biWVtgA4E/BM0WIkMC5zx1X3fnB2nuKiSEy
         e9oKq6ms7ZQ4Zs/a26EH3mxv7kbY7qXferQ96CsSjUNdOcnMlmShGo2BR/g8raXFGlbu
         vfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702937907; x=1703542707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjNyfg9b/oa8PqsdonOr0+sP3WwEoMGtYWMIoH9NCVc=;
        b=cFOiu1hoOAcBl3IXXt0LnNJBJURU1ukIXnqfdQWZQKJ8tzJZFacd03xCBDa2IsMYi6
         tyjvo6eW62cLGd61i/aHOMu6uBqAvcKpooo+uqvsTzIJwyUQKK2vEdiThQkuRPMQESp5
         DdMS2CNJm9PBFeg/k9qr44LqrlGDncmpqCv13OmROVazo1de8iUBu0Rq9Vke7LfKNfAM
         a23cKdxR+DcxTAeRDphbkroBd5AI1sqT/JuoqU6yH3V57ST/ccPK8QkgETxJBwzlJlRc
         wYu+FUCkbkiR0/8gwzv5r4B2ITGnZVKCXBybw+5OSpiP5oahhTPuTt94yJw+QE82dNgm
         HEpw==
X-Gm-Message-State: AOJu0YzUbzT5q99bGEF7TbXMJtHF0saz3/ZQ633yvt5WEZqx1mkPjY6Z
	aiyTBGicSdf4D4VLCprRiaffx7gg2k485A==
X-Google-Smtp-Source: AGHT+IFsUhbL8W2P30+8ZvSZ/j1GVHR/pb7H/a1FC3KUBjSjHyS90PQEOa4Hj5Su4f45NVM5mvf6mg==
X-Received: by 2002:a05:600c:5486:b0:40c:6e0b:69e4 with SMTP id iv6-20020a05600c548600b0040c6e0b69e4mr3326830wmb.18.1702937907181;
        Mon, 18 Dec 2023 14:18:27 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c34c900b0040c2c5f5844sm86928wmq.21.2023.12.18.14.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 14:18:26 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: phy: Add BaseT1 auto-negotiation constants
Date: Mon, 18 Dec 2023 23:18:13 +0100
Message-Id: <20231218221814.69304-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
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


