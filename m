Return-Path: <linux-kernel+bounces-71342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2485A3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A744281410
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9332E821;
	Mon, 19 Feb 2024 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="catl75rC"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A92E652;
	Mon, 19 Feb 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346805; cv=none; b=MMkQ8vlZKJ+uK4X/7sTOtXqXabIriuBmil1Ui7WZ1zonDYm12Xz8HTL33L98t0R6BLJVkm/rALljFGzLH46ZT/QtkFFmMl00kUoEFa81n28ljFNiQXZhSyMXbKp2HJHDHUxEIEMA12RYbO3vcp5LaCxZvCkw7V/a362Xyc0HsaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346805; c=relaxed/simple;
	bh=v2tFgPh2DhrAkjf4HRKnQQBDaVpePm8Gb5zL34pd/k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C8z0kQueI743SWtoyg1kCP3rYCZo6z2xzC4HLrDRTYvxBy4cwWsyMfkM1v2DaxBqmN7GH/G4AHWvQGAWVnSDoHuh65WsYEqN7DnFlWUAMa48vPjNzewnFI3O3gKz7b4CiDe70YwfB2Ao2atY9df2ExqKEautZqnfdgVx+RfnrNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=catl75rC; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-365138d9635so9194375ab.3;
        Mon, 19 Feb 2024 04:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346803; x=1708951603;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFMPdkgeHy68/bLzT3L6tHn2KP/MczRpQvVLvaFtrj4=;
        b=nIlKtNsLOPxKgq+9LAo6tVmR0i+LZezQ54SjiDGcDZMrZljAVnfa0sL40/Qu1hNPnc
         rPJ30BqWkfQzgTHEVm7ZPMhWOX8hcOhlU5QX5p8SgIo87dscSscPpMdN2ULB2uUu5WIs
         U32pAcEJHd9R9UachnTlrxru3jQBaJCDnQUIo1qVd2SxRXPpf+m65DjpfA5DXtOagC2k
         3BXpXI50gvX1ujCdNrJmNct0Cj37mcHsyv7QrQQj+UKIsDmfOdP6yTettdU6p7iz24o8
         AjeIy8NJ8uP4QGv+7KkIkvWnNyxuDQmVLCb+co1J1b0mFJpr4GnqhexoSUdVLknYQGPJ
         rx8g==
X-Forwarded-Encrypted: i=1; AJvYcCVxi6ConpvtwYaVFfoTbuVZIKZNy0cHbwERVDiorpMvjwAn4GW/NunVUWQ4zdcBq5fqqAZWK7T4N4VtZdDc3hNQhbmwkU8pu9EflhM6BUur/D41fRB/67hu6TiMg3jUukMHRB0DxKgr
X-Gm-Message-State: AOJu0YxjfB9Vf/0J4v7KVeYKYh1CI8IBL71DiCaitDZDJiTlXnT0d8Ng
	XiJvHbkkHB5X0CjkTir3Uphffty2XTHgBY+1EHPvau2U792qIMoD
X-Google-Smtp-Source: AGHT+IGCLb6KiMGde4xcC/pcOu5ZQ5eZTdo8F9PXSJUMlMi1DIS656NNPvo+M7N9oD6G3/0AN4wV/g==
X-Received: by 2002:a92:d9d0:0:b0:365:1a08:2425 with SMTP id n16-20020a92d9d0000000b003651a082425mr6005967ilq.30.1708346803092;
        Mon, 19 Feb 2024 04:46:43 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p11-20020a63fe0b000000b005c6617b52e6sm4651467pgh.5.2024.02.19.04.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:46:42 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708346801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uFMPdkgeHy68/bLzT3L6tHn2KP/MczRpQvVLvaFtrj4=;
	b=catl75rCpA3toE3p0fHkprvVKneWaZCOU7brSeB3gor/XcnDh8ijmqR8qvfFqVEqhdnDad
	/FG1GcrHSaUWt++fd2w78wmSgHqATrWE4oCpmd/ejSUIfBGXpqCCQeAF6IsWZVHDNqfRJP
	m8Bm1z7AaEWddZ+HMBEoNXb+qXHgsunNYDIpTLcaaRi4qLLotE9n+jjHKxVX6IzgUEuNET
	l/aDI2T0iVeRdzEAqnzV0awaFK0Qk2BvHji9IykrAF6vnPayHttZjj1xItzLDWDxCJIFv0
	njvxqEeQ8Bd/3b0QwkcsseYd31a0xloL9ugMUt7SrWhkippENRj+JvDpDiWPaw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:47:28 -0300
Subject: [PATCH] dax: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-dax-v1-1-6b319ee89dc2@marliere.net>
X-B4-Tracking: v=1; b=H4sIAN9N02UC/x2MWwqAIBAArxL7naASva4SEeKutRAWSiGId0/6H
 JiZDJECU4S5yRDo5ciXr6DaBuxh/E6CsTJoqTup1SSwSpY2e5Lxzy3QJIGjdihtPziHUMM7kOP
 0T5e1lA8JX5ViZAAAAA==
To: Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=v2tFgPh2DhrAkjf4HRKnQQBDaVpePm8Gb5zL34pd/k4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl003g5CgCqz1cWBx3Zxb+sX1z9Z+uaNXXOTgy5
 1W4BWp+ppOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNN4AAKCRDJC4p8Y4ZY
 pnSLEACmZxs7VJKZM72/T20LHsunB6H4bUV+m0RZ/lbzFoFhbDObaggtHyGNu1iza6xLAChmrC+
 /QREKrtEBMJi7SJoMDD5dZhVKDgE9BGr5ZhO1DOsq8JoUR/wn20ye9Nm1T8swWDSPCINWyXPJGT
 Pe4J68RIUOjHiFFoeguH7Bo5JSa8sOnIXw1pw4wJae4JkK3ncYETMdGf2cV6k6hT4Ua//NCcIpR
 xOJwYinwmBZBkqFE1pvTmMqTA2AlCbpq+ytSJDHA/ZOGFoEMGf66SOnyCqmLPZLIv6o7nxilvm5
 ZHFj7V+fi0HPQRO2GFCQs8EazGWkAF6HHNqAi8nf31Gt2Av21JTF/0rOcT//drrEySLH4by/bd6
 KwoCC2eolwzbmTElVjucQNoDYKIp2mSt71YhbCf1e5v3rbo61AOCFstHxkVkf96S+AYQP4sHKpD
 ZYpN9WHQYO81CNDAkYxl5OIvnnnKJpGk0htxkXm95dMrhRkqdPbnsBNIDTKmPEL0EGHcZlHKPjU
 8lAmibOXThQCo4qmm6nN7l91pGhcrQ2MU1PbJOW+KyVx0cu0mfaIQYM3ZI/DhYpPjYFxaybSY8Z
 PtW3whftEHjCgtNyIjiO0hZh0/690D00zdBUShL6BHjN2+4Yopn0cCVJaohZFne36LRvjXX0Ncc
 OQIS0zz2f2t1p+g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
dax_mapping_type variable to be a constant structure as well, placing it
into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1ff1ab5fa105..e265ba019785 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -763,7 +763,7 @@ static const struct attribute_group *dax_mapping_attribute_groups[] = {
 	NULL,
 };
 
-static struct device_type dax_mapping_type = {
+static const struct device_type dax_mapping_type = {
 	.release = dax_mapping_release,
 	.groups = dax_mapping_attribute_groups,
 };

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240219-device_cleanup-dax-d82fd0c67ffd

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


