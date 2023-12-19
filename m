Return-Path: <linux-kernel+bounces-4745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF840818178
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F22828564F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C0079D0;
	Tue, 19 Dec 2023 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBRqQrQU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE97ED2E6;
	Tue, 19 Dec 2023 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso1472371f8f.0;
        Mon, 18 Dec 2023 22:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702967005; x=1703571805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJpSfJ1dvmmE5RJ34NhOa72WgMVQr4CGokT5UCK3ZUM=;
        b=bBRqQrQUePb5DeKH3WyahIg/JVknTbiII57R17rbgrVoB2+sthz9UsoXo//DL/NUZg
         V2DKxgmef5TN1hfwm5kwOttdyMTggwBNCRgll+v3D3Nv5kREnU7C7oqZdo3i1Yf153PO
         gTV0OCMl4Zy4L1v88H8zfSld2zoo7TjOnkUSA0K006px3AfoPwNincL2lr90lj0eiyEO
         GjdgQKKW/sGwr01+a7hqwe9Er+O2DQC26cX7eKLsgiY1A13w4aJo65bLgmEJdT5wzD1r
         /RQWNLhXf6oaWJcxjzoa+e0zQmMqCuPYD9sayCbdooLnz5LtBXZ3m5fZEtvnp3xLkJ2k
         h4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702967005; x=1703571805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJpSfJ1dvmmE5RJ34NhOa72WgMVQr4CGokT5UCK3ZUM=;
        b=FMOLizMPMpvExs2Hjw7x/mxUnrWpt7+LW5GlUd5syU/5GgcysZXRNjCot5wGWpIwRe
         9dOSYFcKh7gQJUUSEXpv1zuTM9MDgt8LGKvjXDtcvzkaehW+lfn7joQ/l5swUc5/5m25
         clt5eMZA2iSLFwsnSXY6JnNnA524tM5iKJd6iN5mnAT+VXy8JPqf2fbKyeoRkPaUbuk+
         eK+SkHOrYAa1aztaldWM6tgEewHwoRTCIpkJE7Ac3KdnRt3nGcNWTYZYe+67AmB7fxCy
         19PsCLLtJLxGllF+M3ClfMrtvTbdzxa562eQ0jLHcYSKvxHikY6/4q1gIv0IEp1ztXYG
         VzfA==
X-Gm-Message-State: AOJu0YwMX350I7Mz68bTwEtE59sZAQS97MUrA30VRDeZi2Jtbrgi0t6G
	OYN0P5M73tmpWZh/pbjj0cA=
X-Google-Smtp-Source: AGHT+IEkzjyCXE/pVfUxl8tgx+nFnDzsHLi35TAeUuwcvNFMaqgPyhCy8pOADrz3Dwm0lPUZXebU9g==
X-Received: by 2002:adf:fd45:0:b0:336:5499:c5f5 with SMTP id h5-20020adffd45000000b003365499c5f5mr2017669wrs.89.1702967004827;
        Mon, 18 Dec 2023 22:23:24 -0800 (PST)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d45cc000000b003365422e8b9sm10710991wrs.17.2023.12.18.22.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 22:23:24 -0800 (PST)
From: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
X-Google-Original-From: Muhammad Muzammil <muzammil@dreambigsemi.com>
To: robh+dt@kernel.org,
	frowand.list@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muzammil Ashraf <m.muzzammilashraf@gmail.com>
Subject: [PATCH] drivers: of: Fixed kernel doc warning
Date: Tue, 19 Dec 2023 11:23:17 +0500
Message-Id: <20231219062317.17650-1-muzammil@dreambigsemi.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muzammil Ashraf <m.muzzammilashraf@gmail.com>

property.c:1220 : Fixed excess struct member definition warning
property.c:444 	: Fixed missing a blank line after declarations

Signed-off-by: Muzammil Ashraf <m.muzzammilashraf@gmail.com>
---
 drivers/of/property.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index afdaefbd03f6..641a40cf5cf3 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -441,6 +441,7 @@ int of_property_read_string(const struct device_node *np, const char *propname,
 				const char **out_string)
 {
 	const struct property *prop = of_find_property(np, propname, NULL);
+
 	if (!prop)
 		return -EINVAL;
 	if (!prop->length)
@@ -1217,9 +1218,9 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
  *
  * @parse_prop: function name
  *	parse_prop() finds the node corresponding to a supplier phandle
- * @parse_prop.np: Pointer to device node holding supplier phandle property
- * @parse_prop.prop_name: Name of property holding a phandle value
- * @parse_prop.index: For properties holding a list of phandles, this is the
+ *  parse_prop.np: Pointer to device node holding supplier phandle property
+ *  parse_prop.prop_name: Name of property holding a phandle value
+ *  parse_prop.index: For properties holding a list of phandles, this is the
  *		      index into the list
  * @optional: Describes whether a supplier is mandatory or not
  * @node_not_dev: The consumer node containing the property is never converted
-- 
2.27.0


