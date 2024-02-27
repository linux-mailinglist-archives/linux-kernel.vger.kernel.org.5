Return-Path: <linux-kernel+bounces-82553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8673868648
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC281F2539A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD4B1170F;
	Tue, 27 Feb 2024 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKxfDeVu"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AAAE56E;
	Tue, 27 Feb 2024 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998449; cv=none; b=DFogdsI888L4PkbrmpS+XdeQFfgWR6m3YTSb7mveN+G+/W7zBil5E7pD5NB1upOSmxCeYKphHJkIm6Vt/GQthMxAS47Q9EITS9Ni32MGu3DhmAqvRs+ljUKwra5CSdKhDkAQT/InwYbi5s/ZMqfFK+Yjxvd2jcqNMwofnIM5MKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998449; c=relaxed/simple;
	bh=ZIveYUjSn4LfTdnzH8oI+yagiadQMB2/oznVRBOXiwU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uIVeO85NCR8EQzkvs+at2zIU61sUxYgUnRowMT2/uNW83iqY0Vp+VC7eJfzPAarWh2JoYTOeS/ipHd73YtzThQEN5VZxuyTLTwO5jZtIc4twlqzs/g7X0dM+OQcnclW4iA5uiHsCHY8UhcKDvPzyxmDb73TxJekYpBLzzMUloHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKxfDeVu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so17558505ad.1;
        Mon, 26 Feb 2024 17:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998447; x=1709603247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtUXz+HyXntUYvPu0c3yAr8OxqLOOI9DlELoYq4T+Ug=;
        b=TKxfDeVurhd7rYgBkQZC6gVTaiPwfqNjry8ZA+xym6c/UC9TD36RGHgxHWjFhVdouJ
         JzE49DnctNkA7+w2vMEaH8NpExmDtS8b8ie/x2SuVOtvXa0qZzro3FMll3HRpPgSYIee
         9LwrLSbcBUdN3boMYELKC6DBkJFN8GkJtC9mvP7o2WnA9RkLZ3lpXChYcaZOYKjEuLBK
         BplYuLRZE1ip0uJUzW2cSMcaUnAtldcwrx2Gu47xz2s71M/BPU+eL0+0opN1ZdeQMMtT
         HmwtuHQLmxA4qLL026txsKNW+PIr0BSOnYS/ypCOqWMm09H4UYJPEvZTprT9DNoS3BIq
         qqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998447; x=1709603247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtUXz+HyXntUYvPu0c3yAr8OxqLOOI9DlELoYq4T+Ug=;
        b=iY/BSs0yXAftIyQL4kVk0ilAzlEGncaxSVYmvX0ijr/Ux74MFks25cDbm7cNLghKA4
         hzKztv3+uE/bxqrcTvmUlg+pHVHsnYabWXnZ3so55qxy/l4aeulqyuNeu72TAe3byBAO
         vgNefAnxBmwSJo6TUW3q7F+MdBzXefVTGECHDA+GHg1n3fu0s7sJgv5pOJOt5nDlFZbx
         xPAsevyePqu5u40xmv+EPtXh1WQg/JfwIPuKIg12Oxc1zEuqXvB4b/evXrQMX/gvBR8Q
         GzKlMY85H1ccJenHDe8DC3G5xwiEYKOdMgiz4wtd6LNc0+sBKGE/fPINzeWkmX3K2Q4i
         MJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrE/r3BLTEzH64J2cbrRWjhjcxy8WDZ8NSxma7afg90TERIE0zKcWqTW+nwevmA5A4i7CKe3ErIQvfPzE+Vx5wICfL3N00qfoJ+iJnQCSuRFIuIdPm037zwMDvDczXYhW82msWOddlyA==
X-Gm-Message-State: AOJu0YxWAm6BjAK7CxN1IpsgsgiFcqo2mIgM5ZqxADN6VYwZRIIUP8qr
	9mt7ZEl7yvqc7KwNOhXSLBaos/J9gQSMkWysapr6VVCUoxfCm9AXnfBCC5ii
X-Google-Smtp-Source: AGHT+IE5uR+ORUDeC7BTu28ujyXZdBNceJji3J1hfR7Wribes27YPwH77+0KYoHvLZBLYGlqGfa2mw==
X-Received: by 2002:a17:902:82c5:b0:1d5:f36c:8737 with SMTP id u5-20020a17090282c500b001d5f36c8737mr7880836plz.68.1708998447036;
        Mon, 26 Feb 2024 17:47:27 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e381-af24-f369-7cbc-56bf-1d54.emome-ip6.hinet.net. [2001:b400:e381:af24:f369:7cbc:56bf:1d54])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm318893plb.280.2024.02.26.17.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:47:26 -0800 (PST)
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
Subject: [PATCH v4 01/10] ARM: dts: aspeed: Harma: Revise SGPIO line name.
Date: Tue, 27 Feb 2024 09:47:10 +0800
Message-Id: <20240227014719.3037588-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
References: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The same name as reset-control-smb-e1s
change to reset-control-smb-e1s-0 and reset-control-smb-e1s-0.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---

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

---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 7db3f9eb0016..8a173863ef24 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -505,9 +505,9 @@ &sgpiom0 {
 	"","reset-control-cpu0-p1-mux",
 	"","reset-control-e1s-mux",
 	"power-host-good","reset-control-mb-mux",
-	"","reset-control-smb-e1s",
+	"","reset-control-smb-e1s-0",
 	/*E0-E3 line 64-71*/
-	"","reset-control-smb-e1s",
+	"","reset-control-smb-e1s-1",
 	"host-ready-n","reset-control-srst",
 	"presence-e1s-0","reset-control-usb-hub",
 	"","reset-control",
-- 
2.25.1


