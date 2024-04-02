Return-Path: <linux-kernel+bounces-127832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76FF89518B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327871F24579
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEFA60EF9;
	Tue,  2 Apr 2024 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYkv/3CU"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554F62144
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056465; cv=none; b=AoFNBP/dsBTj09qe4NyxMk0/DOI/cOKz+iJPnM8lLtOHik1NHILdMO6uGMGnUykCMcpKYxIfaYEFjdnDgHPnG2sl0oHeIlS5mrNajF3v/vf+QmLbXyZYjHvw8B6nEAIbH2kf42sT+L+UjGzTVORWvwX3mPf/6PEGI3QgtT8b82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056465; c=relaxed/simple;
	bh=bg3FZCaHqZX06oJSKp6iBE/SGrAiqjVv/OdhY8teOo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H2VBOX6COwv4F4ChToYXFkrgp8JfR3yA+Tcc/MAy/obM+T4o7vc9G+VNJAj7B+5rTrky3zZdmb/1Mqsp65b9d+CjfgpOa1cOHmN7qqyCKP0ciBZ6l6ZKk05zXabtbkDsoOFwfVoOqO/3RDWas86omSJjpaO8ZpM0LE/1rvItWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYkv/3CU; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4766e56ccccso1937383137.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712056463; x=1712661263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Rpe0ztnC/I8hQfOpeDNBquHJBgfBNtikMoRmWSLkcc=;
        b=LYkv/3CU7BgSrTcf0StUiepF4NL/xBuYNFrG3l03AyowtkkqyV2j6oa+VcyIxrDe0W
         dXLXfI50ioPJ3zdRXqUxiw3Kh14jbAxlOizHj9CM8p2RP4lDpyZhrB+HAWvxegX/7aEs
         FUnE8GxuC70tcDa6ZoOYsBFPue1Q93cmzJJm7l5+1gwwInTN1/I7ICWlfDN4O13/i5G8
         JYpTvhGPaDqCnqjX6e5qNIpvR62IhUPfBX0t0yA6ItzjviUNVEr4nD0HhCAo0LTtUh2q
         q23Uc2waU8w8QTIaFstpXe/Rja3/JW2mCqJaMxLpq+SZk9IUQxA4hKGrMl3ByApYR9nt
         /cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056463; x=1712661263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Rpe0ztnC/I8hQfOpeDNBquHJBgfBNtikMoRmWSLkcc=;
        b=l8mwGKR/9k8+279oEGDBeJoJuHWSHNn9oyi2h5k6BNmB0COk3E/q5F19JEl5nkEoFo
         x3yZ9vjL+GDqqO5K1oDFuaN7CyCxAzFr3a5V0B3QukEIT42iLJ0gC/xAnHjhtbEDNOgG
         oztnBfanMfdsPezJMlG7jZjzEYcLbCe76UK3kUd46dH37R3wGdWDCRiT402nq/6BMbsX
         PdY8BgCZMk5MQug+ACCmrzlv7MkyXBxqUMqUy/LBxDo/1EZWpvXDjQbWYcZFKllEKGNU
         n6y5qSU3+SJVV9w2yppqQn91qGAE6OBGP51ApTp8DxNk02ycmTx+MSpfBE2S+xUStUNH
         YS7w==
X-Forwarded-Encrypted: i=1; AJvYcCXg9DAit4Fhtg6XhxRaw01+oEkVVQbjBRH46MuRzdvPVU/Sqa0Mc0SWz9zzZOxMuXe/4ui60xVDuY3XihaTd/GEFQ+9BpswYav6o109
X-Gm-Message-State: AOJu0YxEJYf1yUkrJJ/IEt44bXkGDk+YJKUpbI3S+US6ErZg4RBFkGR5
	abtmo1S+XGUCzYniUXe5QfM1RDaiVS4sEMta6vMuP/h78qJA29q8
X-Google-Smtp-Source: AGHT+IHkZS1ozDBjeiZJKzzA9oQe9Tel5yd1op4D7xSCaoipnH4dQFBrlw96ELBRkTONCE1B/hOHEg==
X-Received: by 2002:a67:eec9:0:b0:478:5ca4:db7f with SMTP id o9-20020a67eec9000000b004785ca4db7fmr7964522vsp.26.1712056462663;
        Tue, 02 Apr 2024 04:14:22 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:737b:ef00:2c6f:6cdc:f641:6ecf])
        by smtp.gmail.com with ESMTPSA id 11-20020a05621420cb00b006968a6fb010sm5428855qve.91.2024.04.02.04.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:14:22 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] staging: pi433: Remove duplicated code using the "goto" error recovery scheme.
Date: Tue,  2 Apr 2024 14:14:08 +0300
Message-Id: <20240402111414.871089-1-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset improves readability & maintainability:
        - Rename device related vars.
        - Update pi433_receive param type.
        - Remove duplicated code in pi433_init.

v2->v1:
Followed by Dan Carpenter's <dan.carpenter@linaro.org> comments:
        - Remove empty "fail" goto tag.
        - Reorder pi433 init & exit calls so they have reverse order.
        - Add "unreg_spi_drv" goto tag.
        - Check "debugfs_create_dir" return value.
        - Update "if" statments for consistency.
        - Rename pi433_init return var to the more common used "ret".

Shahar Avidar (6):
  staging: pi433: Rename struct pi433_device buffer field to tx_buffer.
  staging: pi433: Rename struct pi433_device instances to pi433.
  staging: pi433: Replace pi433_receive param void type to struct
    pi433_device.
  staging: pi433: Rename "pi433_dev" of type "dev_t" to "pi433_devt"
  staging: pi433: Remove duplicated code using the "goto" error recovery
    scheme.
  staging: pi433: Rename return value from "status" to "ret".

 drivers/staging/pi433/pi433_if.c | 710 ++++++++++++++++---------------
 1 file changed, 358 insertions(+), 352 deletions(-)


base-commit: 20952655235dd9b1447829591774f1d8561f7c6a
prerequisite-patch-id: 91943193af2fea74182be67fb583235a3fbeb77b
prerequisite-patch-id: 2cad031ba6a0782a67ab1645ff034a8be65c2e76
prerequisite-patch-id: 1a852ed8f9d133aec7c651fd9007e59e39c55fb7
-- 
2.34.1


