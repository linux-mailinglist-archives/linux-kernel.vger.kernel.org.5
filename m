Return-Path: <linux-kernel+bounces-131296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8038985D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E731C26272
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AF83A0D;
	Thu,  4 Apr 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJPhAixk"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C80823D1;
	Thu,  4 Apr 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229232; cv=none; b=OTK8naV9esfgZdvOG1NWLXu8Py9cbLbWnwuZic6ej2bHy1s6sWg5pFmH4Hu1oBkxKflunLMObL62nlIu9DuySFM4Sz/m5TsZFenAgpO6jSrq9AdjS3CIXI21oWgmHQAD87e1mpMVlAmzEQxCQAyJWwLBKHBrJQzu8jN2IgkARFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229232; c=relaxed/simple;
	bh=45vK49EfLJqORf4YubKvGjOflbMGxKU6di5MER/rwBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gkBosojFpmFgAswnJoEkPZXzizgjFWlRJuF8eRm2M+jYOqT1s1IIyPY+RtZgVmaGMPp0YSUAcdb17JVJN3YQikmfhklSf2ku5ipFa4I0lVWpCSyIOrM+AdXw/MuHbJJ4o5YzHdimRQRtOTTkt6bzPllJxPct8NIoqvuJ3bxXPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJPhAixk; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c197d042fso880938a12.0;
        Thu, 04 Apr 2024 04:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712229229; x=1712834029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TlPLK7jglvaB3j36qi7ymAffxtiGExNw/hBufrLkdw=;
        b=MJPhAixk5NJYqNK5XIyudgRoZEmzF5TbWBsgUQFicdpnav1P3448qJoku3FLmzIN63
         nrFMTssObMctMCFii3DsP0xQtOUThGJb6SP5/SxMiske6VK7M69mVv6KzzrStHllbepR
         FCABzvbNQLaRSJc+Xr61yu3ETXMnHpIwJlssrBHezDh8iOmvE7uDxOd3JYpIxc7oKUOS
         gvMR6OAnAwHaWWgBSLyJegJXPDF11QptER8A3Ix1/uW8ZXcXzuoDl4m48xQacNMgNmRo
         IoMn2Hktee+FChQ3D14wge/BT65rY+6wYqTRBVtgNHDPLv3/x4DvQkfq0egQy1T3c48Q
         TQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712229229; x=1712834029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TlPLK7jglvaB3j36qi7ymAffxtiGExNw/hBufrLkdw=;
        b=drSI3sIz+XfulG9Ac0Ch/Tgd/WgfYlcLO123g01xNvXzkgIibmM/XsudGrSK20zCi2
         GDcQjH/W5J7y2qn5UhAFZk3fZdL09C+AIiqR26nL6waozF0x79N+SqOcIwkn+3iRzbJk
         INbtnYBK/+8RcdU8fzgQywc/14ZS3HAO8JykluZZioEnKWR26raSFZLKGXej9jrsyIcO
         rxRsUrAegiSFLUxp6nlK+p55VcAt6mw9Ka/Egy34LWjLPpsfm9JjnIj8umOV6hk/uEIa
         WI0rHfvaCVUF2G5tu+YCzU3+NrvtHsui5G66uSndnHqFntydMZMod+3Tg3RYrrGwI2B4
         K3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVpSFcuPow0WhDzp0QhVhAXFA/0kjRiVTbs3Od84waCCoK1Zvs628PY6LDaymGX4b4v3txv0lJqw4TxcruE7iOp2gCJtBZPDqY9W1cK
X-Gm-Message-State: AOJu0YxoXCoH+UHmcsh44DpIUSUS5GFGguinEWbR8u0OjO1bSk3KNC8l
	I4vjgaX47Ys9+zezi6bEZ19IGp1ko+foyAi9uPl34IG2XXcIYgz3
X-Google-Smtp-Source: AGHT+IFtGTdz2xL9Qq4lX8iYug3K+v6pOIFUYq5Wdol+sO4ZpPj2n+IKwsdab9Bea2ogWg+W7qioMQ==
X-Received: by 2002:a17:906:8c1:b0:a51:970b:6d55 with SMTP id o1-20020a17090608c100b00a51970b6d55mr41834eje.45.1712229228885;
        Thu, 04 Apr 2024 04:13:48 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id qf4-20020a1709077f0400b00a5195edf8e8sm104659ejc.62.2024.04.04.04.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:13:48 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 04 Apr 2024 13:13:28 +0200
Subject: [PATCH 2/2] hwmon: (gsc-hwmon) use
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-hwmon_device_for_each_child_node_scoped-v1-2-53997abde43c@gmail.com>
References: <20240404-hwmon_device_for_each_child_node_scoped-v1-0-53997abde43c@gmail.com>
In-Reply-To: <20240404-hwmon_device_for_each_child_node_scoped-v1-0-53997abde43c@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Tim Harvey <tharvey@gateworks.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712229225; l=1772;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=45vK49EfLJqORf4YubKvGjOflbMGxKU6di5MER/rwBg=;
 b=QfG0G1QzcjW5cfpfVaUj8toqOQuh+zJKvcu3CLHxbeaXwNT9D8jSNqdmgeEn3GDufpNPMIgoK
 CfT5014SEnNDtrX2uBgKp/g05ijU1ipzqbyRHilr8XhNoYHDvKB2+GY
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to the _scoped() version introduced in commit 365130fd47af
("device property: Introduce device_for_each_child_node_scoped()")
to remove the need for manual calling of fwnode_handle_put() in the
paths where the code exits the loop early.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/gsc-hwmon.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index 1501ceb551e7..0f2147699c91 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -249,7 +249,6 @@ gsc_hwmon_get_devtree_pdata(struct device *dev)
 {
 	struct gsc_hwmon_platform_data *pdata;
 	struct gsc_hwmon_channel *ch;
-	struct fwnode_handle *child;
 	struct device_node *fan;
 	int nchannels;
 
@@ -276,25 +275,21 @@ gsc_hwmon_get_devtree_pdata(struct device *dev)
 
 	ch = pdata->channels;
 	/* allocate structures for channels and count instances of each type */
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		if (fwnode_property_read_string(child, "label", &ch->name)) {
 			dev_err(dev, "channel without label\n");
-			fwnode_handle_put(child);
 			return ERR_PTR(-EINVAL);
 		}
 		if (fwnode_property_read_u32(child, "reg", &ch->reg)) {
 			dev_err(dev, "channel without reg\n");
-			fwnode_handle_put(child);
 			return ERR_PTR(-EINVAL);
 		}
 		if (fwnode_property_read_u32(child, "gw,mode", &ch->mode)) {
 			dev_err(dev, "channel without mode\n");
-			fwnode_handle_put(child);
 			return ERR_PTR(-EINVAL);
 		}
 		if (ch->mode > mode_max) {
 			dev_err(dev, "invalid channel mode\n");
-			fwnode_handle_put(child);
 			return ERR_PTR(-EINVAL);
 		}
 

-- 
2.40.1


