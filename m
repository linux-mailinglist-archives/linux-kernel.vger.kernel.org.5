Return-Path: <linux-kernel+bounces-143602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A74658A3B4F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC551F22374
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75081CD26;
	Sat, 13 Apr 2024 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6oX2VPh"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C81C286;
	Sat, 13 Apr 2024 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712990800; cv=none; b=p0jbSJYLYMutBM3rWAZzRsgNkU5Itw8nBZNm7f82lPuVgBHft1ikOYORsIzeUtFPQH9Jd1w42VEWk8ern7pFtqKdH05Qq6b1Y5nxLFcUwAqTbeA7JZAuUUjPWnuv1Zw7Ss5Z4nCUCxTx3/yv1pcGMgC0579G7Iym26U4uRCaijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712990800; c=relaxed/simple;
	bh=b7xic11TrlqPqW6MKWhNjFfRsty3I0aUokUTdGxC8ag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PYBpGsCJhMm2cBi2uzp5iCOdVSVoLc060eN8CL5aPCojEKUTadSLQfHJrY2g42YqeMZYzxFCr0Gp1odQzsXzzv3xZeBTq98yCx4R2WaGinFrBI/Rh0EB9t9ezWTLUHoyDl7w7DielNMW0tpylCwTcznHQttwqT/rj8OxS03x9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6oX2VPh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ef9bd94d81so452081b3a.3;
        Fri, 12 Apr 2024 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712990797; x=1713595597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=twRetE152Y2Fvd4PMDtj8L/32OUiKxwrCOgAjYJA/T4=;
        b=g6oX2VPhckcw1ceWHz1aS9D0EfChScFdJ4r9L2dKEHT2uXuikVf3pp5DMUXKdSfJeY
         1NRv1Uf+S50CILqNBKgB3U8I4w/iidcBG6Q9dQFvnMiXtdKzRgnYlxrpEYsgt3e7yjK8
         PSnnaVv0IgHVvKPVzMuiceGuhBVee2HJETGvEMUvWNpqHqB0TMsBVEtrbaa5lJ0FE+Vn
         bJTokGW0RUigpO8Sj9RHHkJkJIqvk7Q+mqCgOVSIHQ8WUSMDniDBxtJdW4xxu12KznTE
         kbvud1yPuaA94/BKS/SGr9i0jPXSXH+QjIIQsFtIWGxTK8qkGALVwN7YQpgviLa74BNn
         iCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712990797; x=1713595597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twRetE152Y2Fvd4PMDtj8L/32OUiKxwrCOgAjYJA/T4=;
        b=kskf8D/0GXaojIdFzU1ZjziK17tSw4e3WIPC3YDcEHjjCuXi9z9wOdh8x7qXBghXH2
         z+VdypmYFwRuFCxI1B83njYbBT4CsFpXLkZanCOW8wVNllzotBkV55qgDwQo5kNb7kNL
         WQqsHVEgeaNWysJCXMVXy72GksE8LsOoTlEa1TsAqXFqFa0k70Dmg9eXkgpSWHo2U/hM
         A8v2v7ul50qSt1w5C6JSsL10XVxia9F1BYqZgJLPbiPycJLTnWPfE2tqR3Hh2srAp658
         IUCmvlQPEv8nEoc7+t5ZFwM8PynAgirs2qsqjVkoHzvQxu9G8TTZ5aMzNwa5BD4RncwU
         EZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5x0ohiJd5FyjmBhymgaFidUzXupMiAXUj/S1l/t5dMUTES7xRN72oVJ/8TZp4e3V8fGpCtyira9/cnm7E1f1TChz20rHMg5nKn9W5cmflsBO1Qz2wniZXlIAbtIVp1TbmtD5OlG8c3Yc=
X-Gm-Message-State: AOJu0YxL6SzHefUEuKVilCxyZ0k73QPTzIfM/4sfqNgs2LWlbJGJDfjY
	U0LUImlDxVBw7U7jf4tpJc0oNTjTy5DrPjRO18RmyywB+JkmwdJtf4q7PTu6opc=
X-Google-Smtp-Source: AGHT+IFW7qpsvXblAiMX/RvthcFLBilYOKUGwz2LBo1EmPVEmqagdDyQemcgq5bYd++1E+at1QyQRg==
X-Received: by 2002:a17:903:48c:b0:1e4:425f:5795 with SMTP id jj12-20020a170903048c00b001e4425f5795mr3679487plb.58.1712990797341;
        Fri, 12 Apr 2024 23:46:37 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b001e2a7e90321sm4096693pll.224.2024.04.12.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 23:46:36 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	sfr@canb.auug.org.au,
	liujianfeng1994@gmail.com
Subject: [PATCH v5 0/2] Add hantro g1 video decoder support for RK3588
Date: Sat, 13 Apr 2024 14:46:06 +0800
Message-Id: <20240413064608.788561-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the v5 version of this series adding hantro g1 video decoder
support for RK3588.

RK3588 has Hantro G1 video decoder known as VDPU121 in TRM of RK3588 which
is capable to decode MPEG2/H.264/VP8 up to 1920x1088. This vpu ip is also
found in RK3568.

Test results from fluster can be found from thread of v3[1].

Changes in v5:
 - Add missing interrupt-names to devicetree node
 - Rebase devicetree patch based on next-20240412
 - Link to v4: https://lore.kernel.org/all/20240316071100.2419369-1-liujianfeng1994@gmail.com/

[1]https://lore.kernel.org/all/20240118080602.9028-1-liujianfeng1994@gmail.com/

Jianfeng Liu (2):
  arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
  dt-bindings: media: rockchip-vpu: Add rk3588 vdpu121 compatible string

 .../bindings/media/rockchip-vpu.yaml          |  3 +++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 21 +++++++++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.34.1


