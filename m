Return-Path: <linux-kernel+bounces-82552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449B3868644
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97A21F25215
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F98746E;
	Tue, 27 Feb 2024 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0IJrBOn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47B6AB8;
	Tue, 27 Feb 2024 01:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998446; cv=none; b=i8e8GfS1eiE2Sq0+FQUb3bKTPP3isvlckVjuoXnOJDM7YTyuSsDYDKwW/FEOAZzM/XqdiPVOKjNsbiqfG2CwqpW4KUZd2vckELH9LLv7yM/D67OYNaRusacUfA86CfarshpMa4vfHtvpzzK7tCFVaiwY7tIj0kRVfLuMFWkG7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998446; c=relaxed/simple;
	bh=oO+eEhdJwg550qCt35hOiohnEv3NP2Ypo1gOOnvfYKs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=VUHOXjcuDG2EhvOuLUhXukbIMp/8n2UzeBLngd2+lk2HWoLa2qVE0cUcTQnD5YxSQr+8NDUmGs7yIq9tLdhHF6Ne5SLF4ROoq0rxSZUYwVNFRGqhQWTW5e7P7gOvQ/dtZ6fIz8jFwPajs89nvkd6tHJf3kJYGzGz7x5Hq2FdhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0IJrBOn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc418fa351so20030195ad.1;
        Mon, 26 Feb 2024 17:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998444; x=1709603244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5Bi8JUt9nb05E2+iuy4wVbc0ulD53LZE12DFVp8HmA=;
        b=P0IJrBOnqZkF+181V3AKQtFjK3SEueBkgXzs/d/MC0YVCSPjb+TCAQt2GJWT3bhm/f
         4l0dHRiQbQ974vuukEz2wqIzYAThlCnTYmfMQJHBdYiDW/+hX0RX2vjs6iebcUjOPmIY
         P1dzBXE3b0mytznClkXVkG5RCzTg6tL6PI+AaKrX0t5j9JZ4ifipGUl5JaklIBhqFD0t
         QbFIsjGTP1GIr5IcwRZBYQzPZOqnvHaxMpocVj5DeODURGD9Ep0TxqYBeSVAifEZY3bO
         ChmbMq7pz+MOumii0h9l2dVM2lIP4gomRhuzXWWrawI0fno7Y1NVVSE/h5jVsvDM8Lv0
         lz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998444; x=1709603244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5Bi8JUt9nb05E2+iuy4wVbc0ulD53LZE12DFVp8HmA=;
        b=qNWv4UFe1iuIEfXgFzg41s1n8A9D7BZxkmzLdz7VU+mFL3Dn8y3rhMUYGEsdVz5vgr
         yKLH1awbXpjyy9RBmum8TyDpaQ14W2IewoGoKxYpzFtpUNG2QJ9A81PvYlEoAQSuWj0N
         XoLfGWCQipOKK1MzvuDW09UOUky6gFJBSvYYw1eXRW679/BpquoLh5+qvz7ctEOcziS+
         3C8f/e647S97455wRyZ2VBbnK21CwGDqQ1w26v7EVehYj78m53Ui0RWlwc50XN8OO1pb
         w3BBcV9QBtdVIBe/dvBfr+tjVcQZ63o3CzpOlBc7zIM0rpzsF/deVGt2gYa3dERXG+B4
         6Uxw==
X-Forwarded-Encrypted: i=1; AJvYcCVzj3beCepyOt1//1HbC/0HAIKPj+xtZYx6GDB51wfSrg8a1J/I//9GAbooZeLVpul/u74djvdgC0kzKHeKanbs4kq3DgigToGB82qi/gC/xL7PfH4/juRP1Ho8qT7RuhQp6UbK5FOYEA==
X-Gm-Message-State: AOJu0Yxj+4j3R+wOqTu3inLSjZE8pB3MYipZVlUV2So/iioYEHrEyf6Y
	tOF3dqu4K1jRpapWc+aA45HGbTA/amPW7OaComReA02UzJ90TJSx
X-Google-Smtp-Source: AGHT+IEnSIvF4O3ektlcPRgviqqNsyJ1pvW7GtmYokpf1hZ02p2IuY+epU/RcrY/7nLYnBtMc1UFlQ==
X-Received: by 2002:a17:903:2347:b0:1db:8d0a:cfa9 with SMTP id c7-20020a170903234700b001db8d0acfa9mr11514913plh.6.1708998443948;
        Mon, 26 Feb 2024 17:47:23 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e381-af24-f369-7cbc-56bf-1d54.emome-ip6.hinet.net. [2001:b400:e381:af24:f369:7cbc:56bf:1d54])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm318893plb.280.2024.02.26.17.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:47:23 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/10] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Tue, 27 Feb 2024 09:47:09 +0800
Message-Id: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP8Qbepm1AVjuCbaKw@mail.gmail.com/

Change log:

v3 -> v4
  - Patch 0010 - Revise node name
  - fixed PDB temperature node name in Patch 0006

v2 -> v3
  - Patch 0007 - Revise max31790 address
  - Patch 0008 - Harma: Add NIC Fru device
  - Patch 0009 - Add ltc4286 device

v1 -> v2
  - Add infineon,slb9670 information for tpm.
  - Patch 0006 - Add PDB temperature.

v1
  - Patch 0001 - Revise SGPIO line name.
  - Patch 0002 - Mapping ttyS2 to UART4.
  - Patch 0003 - Remove Vuart.
  - Patch 0004 - Add cpu power good line name.
  - Patch 0005 - Add spi-gpio.

Peter Yin (10):
  ARM: dts: aspeed: Harma: Revise SGPIO line name.
  ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
  ARM: dts: aspeed: Harma: Remove Vuart
  ARM: dts: aspeed: Harma: Add cpu power good line name
  ARM: dts: aspeed: Harma: Add spi-gpio
  ARM: dts: aspeed: Harma: Add PDB temperature
  ARM: dts: aspeed: Harma: Revise max31790 address
  ARM: dts: aspeed: Harma: Add NIC Fru device
  ARM: dts: aspeed: Harma: Add ltc4286 device
  ARM: dts: aspeed: Harma: Revise node name

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 63 ++++++++++++++-----
 1 file changed, 49 insertions(+), 14 deletions(-)

-- 
2.25.1


