Return-Path: <linux-kernel+bounces-142370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4588A2AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8B41C209DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0712C50299;
	Fri, 12 Apr 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb6A/56K"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35683A1DE;
	Fri, 12 Apr 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913487; cv=none; b=G1LOSGs7szA+DRqUj2w8P0ezd9aGKkcIs80CDlFFTWv5ag7DQjDDfTfkNoNG7GcS6dX6Q0ETITL80BvEF5yOe4pUIlcBPNwdbe+mOr1cDF1rhlXgEEzlr1GzGSfpxAAJxlRDSMi+A8YTTw+2SpylGujyZg8XIuLzR8KsNMeLxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913487; c=relaxed/simple;
	bh=YC4Bgpu88WlNqCOJ3XFyA+QsjOPCcKLwt4UBvMe1g3s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=c+qoxtrqDtHrmz0f0Dp2/N1eQQfKcNmzI8kOkexzf9mnUl14k0YRq5uqUSBhlVtg8WFTPzWb31IgozRM0tJxqotOb+ZVwQgXz8nt5BarPpfVw031uFG7qESD2Uec1vr1TYfrTAHpKGRWlTE1xT3VGiVixPzyMXLDSmIWQHCQLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb6A/56K; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a4f7a648dbso392708eaf.3;
        Fri, 12 Apr 2024 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913485; x=1713518285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wC6YvpE7b4hJoyARtBi91JyrMS4DalKwG74Rgk0uWK4=;
        b=Xb6A/56KPqeYTIUJG4ltvUA+QJwFPi0RvwUvgx6AfJgqBSrxrUuqDxurnZhPecskUA
         2JNmiywRAUzc/dP6x8IyWYylTSMep9ZU8USt7egPRsk0QGAjHivvQezln0gXfOJUpsok
         OOsg9gPFZ3dv1Vrn+q095ibuuOvddBsaHTA/i1epXMB9ik7tcDVjTkBaPT5Uh+fr7zAa
         TcRo+TdINJzNWwRu5yqX6QCLnwpg3AOKdIRHx8L4cK9sriVvqraX7cAv8XAvih8FHesQ
         GJIxlBJOeCzVl85y70hK4dRfhsg1hGiFu88Vf+YJciUMOvHjOYdMLlZGFH97dDPNWzjK
         gznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913485; x=1713518285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wC6YvpE7b4hJoyARtBi91JyrMS4DalKwG74Rgk0uWK4=;
        b=O0CGwq3/HnsrNFC1ILVP9klkUXYzLweOvd0h5oAKAKckP73NhDaAzfQIszeM8+N+Hx
         yA+1iXEsY9SyTLkrGkLWCN2yOMI9B9R8W7cQuXNksmFhfD5Kgwl6npqEKwojpXS0R9Fu
         5ZXcQT4O8Rh5KmOAfCgngP+C9dc+/EUPBWwKBsnBjtyEISDa20aj81UETNS5hENvXYN+
         s7FsXXxWPwA30aRrxp2r98BV9/oHavV6V2fE+mXoXXpl1dtiGJJq9PbW6o58xaKglp40
         kR/nBzc5GhGI2tiH4DqjDsmThQGnQhPDoHNkR/8hw0HUrX7RwFm+jNprk7Rd6KIRwm4Z
         54uA==
X-Forwarded-Encrypted: i=1; AJvYcCXHNqU5nroJbIpipENvpN3bt/3jgsaOu/1AcdxDku0cPMNLCvnBOV6aLEi+pW2yyMKbGnBJAGp4D+rHTLlXeUPuMTnEIB47jD7zOjrkP/tuAhDSy3ImS5D2h/UgCyLfKxuiGiCfrwWyrw==
X-Gm-Message-State: AOJu0YxICvfZRT9und12T8Q5Tvg2KFBth0mfN9yMDz4EQO6hG7B5CAOE
	U34xL0Dum9vGV+H9YwnPzHjonlPhah2lPVobAkuhCwhOajB/wvO+AGoqbg==
X-Google-Smtp-Source: AGHT+IEXH91UuW/BOgWLuecnv/22wdajH927v/Oc9c/RokBJowFcYqTiNEL3bZQLhYB1XNnkLg7S/g==
X-Received: by 2002:a05:6358:420b:b0:186:1128:bca7 with SMTP id t11-20020a056358420b00b001861128bca7mr2526716rwc.6.1712913484932;
        Fri, 12 Apr 2024 02:18:04 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:04 -0700 (PDT)
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
Subject: [PATCH v5 00/12] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Fri, 12 Apr 2024 17:15:48 +0800
Message-Id: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
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

v4 -> v5
  - Patch 0011 - Add retimer device
  - Patch 0012 - Modify gpio line name

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

Peter Yin (12):
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
  ARM: dts: aspeed: Harma: Add retimer device
  ARM: dts: aspeed: Harma: Modify GPIO line name

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 107 ++++++++++++++----
 1 file changed, 85 insertions(+), 22 deletions(-)

-- 
2.25.1


