Return-Path: <linux-kernel+bounces-16728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B536F824307
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394A11F25215
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78BD22F0B;
	Thu,  4 Jan 2024 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmzwAkmm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3023760;
	Thu,  4 Jan 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d427518d52so3410695ad.0;
        Thu, 04 Jan 2024 05:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704376067; x=1704980867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mmt0UdSDV+w1BWZtmNFxfAxPy3KjCbVYZPCzBNdDlQ=;
        b=mmzwAkmmv6Jp2oZzEgM/ossWtbTEosSwGTs/AIGMA+2+QVsc3h2JaMPy/pzmXYKk7Y
         M3q8etyHRkISjKiZDa7biJs7X201uL6stHQc/zHaaVeE+LBmAvrTyacQD9cJ/pcrZjuy
         zMS8vntiNnvSm+PrMYGga629uSD2o19Pi6cbfKbLkUcB6pZDh9/GS26OhQcu84nh75zE
         IotzOoa7209X7iG7Q/pPvC9GSm2K29sznC0gKgXhaG/x+IoRvlCV/O4yI9EZbgPak8Ms
         gGeXnhLISHSn24mtHh3p5VtahAk4OKpWTlSnM/NBZqPS4A7q1DBFEo/vX8wpjXiJNobI
         eonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376067; x=1704980867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mmt0UdSDV+w1BWZtmNFxfAxPy3KjCbVYZPCzBNdDlQ=;
        b=Q6GBZC5SZnNL1nP//BnMI4ZVsOOfYh7ffN+RLIP5MzOsHeRaSlTAal2jxWkjObp7jL
         AyE3CyY+rjuTXPaN7DsxdshySukesfqE8fiLJzWbNusds7TZ38XoqPA1YqAf2VZ74WnC
         Hoa0thh8zoUUtV1E0rwHHKRzQ3rfH28ASvRkGjUCv3QKEbwRhWHIiX9+rUFVpeUHfg3e
         p5qwzjBL+SeNZ5nrGdA6KYfPmiUxwGEfwZzhuFckn2CdlbMvsYvsz3ShyrRV+KwHxn9P
         kPsvJ6cS1sCwOiJmHN/nvV0WYTC+QRD/SMk62O+yvq/pFt/KbAlwf/pr/MFJby8frShL
         WmEQ==
X-Gm-Message-State: AOJu0Yz/Oz+zSR4e/qsRVmPa3DsdReKLqWAjJuKu6HjUXffalDzE/daJ
	mqwpnLGVhPQqscoEpTCqRHk=
X-Google-Smtp-Source: AGHT+IF7X1lreIaoGxYOY0Mw924RintZD1lo9Uf8+TBROV+grUK3C7/HxBu+kT8owOJIrT3JfzUsBg==
X-Received: by 2002:a17:902:dac5:b0:1d3:f344:6b01 with SMTP id q5-20020a170902dac500b001d3f3446b01mr745037plx.3.1704376067201;
        Thu, 04 Jan 2024 05:47:47 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709027d9600b001d425d495c9sm22990550plm.190.2024.01.04.05.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:47:46 -0800 (PST)
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
Subject: [PATCH v2 4/6] ARM: dts: aspeed: Harma: Add cpu power good line name
Date: Thu,  4 Jan 2024 21:45:30 +0800
Message-Id: <20240104134532.536793-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
References: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a line name for cpu power good.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 5d692e9f541e..36aad01dda20 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -501,7 +501,7 @@ &sgpiom0 {
 	"","reset-control-cpu0-p1-mux",
 	"","reset-control-e1s-mux",
 	"power-host-good","reset-control-mb-mux",
-	"","reset-control-smb-e1s-0",
+	"power-cpu-good","reset-control-smb-e1s-0",
 	/*E0-E3 line 64-71*/
 	"","reset-control-smb-e1s-1",
 	"host-ready-n","reset-control-srst",
-- 
2.25.1


