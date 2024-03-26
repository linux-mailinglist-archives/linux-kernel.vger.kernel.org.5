Return-Path: <linux-kernel+bounces-118812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE0C88BFA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139A51C3E5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D106DF60;
	Tue, 26 Mar 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE+BOn4b"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A66AA1;
	Tue, 26 Mar 2024 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449365; cv=none; b=Y1Zqtv0bNGX9+MMOWr1Y0ALsnTBkOmeH5BPvFW5N9sKJ8BJZBnK8tfUUiA77iCw+JIk9HF2Vr378D9RoyGAYdNKFk+F9iSQKrXE7+D5my+sZVY+ERNvOHoy/FKsXZb6jLrT2S03orcQfJ4Q6nmSl98edZVw20XSD89wYMHG8G3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449365; c=relaxed/simple;
	bh=nA3HGlEzg4wipPMaSJZpoxch5/KlpndwCHv73DJVBq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GhAYZBqbu3+zUAPK1Gb8k/58vlLbG9Y3fZWa5cupVqGmRYXJA2D8ufwHO+hhizQATnaU5XEAHgEMqhlvA/kV6F0MGepuFXaMu48qjcwOaeOWv+hTR9g4AleTXdtVV9JXJCWMixFr3+iTeUCLTR5obYgR+OT1raAnJSjri8SGAzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE+BOn4b; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6afb754fcso4697267b3a.3;
        Tue, 26 Mar 2024 03:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711449363; x=1712054163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzA+4JI3wFiXDrwUJkR8zhNrvSRJ9geuAiqpr+wQJso=;
        b=bE+BOn4b3WkWIe2QZ19VxtVPjuXYHjmveFPJ3xzW2vijM+hH2TH2EzYOG+hgTFK+bQ
         c+VrVQLC6YybQs4cgeWIsXBA02HVU2YBb/7Gr6jL83Qw7pF0Vmd1xTBdQqOX+oHxNYgn
         eqxLFeymNPqwjVivslVG/DYbAZpCtt/WgkmYr56VNKKzgAnvkiE62RPKC8r+rX5jRaXm
         B3Rwy8NkCiKLrPzlQJDDOI9mfNJKgOW92sAHx0rXPawPrBZrT/7KY6Vy6HQKYG4pPWiG
         oxx0gUu/0vgKzUmSaoMKMA+6rnMvs7AUNZxTvINxmaMwsepxAaCMGiX8bZVa7FBsTyv2
         kPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711449363; x=1712054163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzA+4JI3wFiXDrwUJkR8zhNrvSRJ9geuAiqpr+wQJso=;
        b=H8yYeFy1taWG7XvhZX3UmBISnW6FFRKrFQrfcfF9N2vSpgldGtePkY+G70y2J5Bt32
         x8XH2lcpkHZ19HMFAnyhzTPet1xtUsoDFTPQhSE5zGyTCmXpm8rd2Lq4q0jJau95nxGN
         C521w6HcCaLGcXBS9a451NplZReaCNXWodURQLMpD+iWSMpD5VdCrSPXl66B1UTMHB6R
         qvoDDp4boIjxwa4+RN+9miis7YO5yWqbcR2PQSnd6YTWzqj5sK3/iTkxufXGbYXaeBp3
         MzC2lyH7xoM4Ny05//FNo4Muynd91JUdZb79jccqxowvOasVX/MmiQhkuZuvz9vJn0z2
         bWow==
X-Forwarded-Encrypted: i=1; AJvYcCU82xerbvrM0qgS7JyAfGpa2EUMpypKmBU+LpoPRFg0DXpE652TYbnTfSvyNVGrEVubXLFiGsypKxB3g+9tbRgP1Q2DbCTmH98HnI3DvUKJrp0keoFTcm6jdatW5slcqXXx2E3aq/M1UA==
X-Gm-Message-State: AOJu0YwqE96tGGE0n9JN42NYsu2+V7JmeKbr9Go8hCs8LVZtY8bf/p6X
	21xdBPsiz4nJtnEuqCl8APZJi3aKY+2q8/M3bUHvdFPogedjI+Mg
X-Google-Smtp-Source: AGHT+IHHOYzTj+IB7VjPayZebgf3uaGpX6yP65/tC4hSUtY5RbYDAX6ZhBtjhEVyZzYDQrPbpPPv+g==
X-Received: by 2002:a05:6a00:b42:b0:6ea:bdbc:963 with SMTP id p2-20020a056a000b4200b006eabdbc0963mr802295pfo.0.1711449363221;
        Tue, 26 Mar 2024 03:36:03 -0700 (PDT)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id g14-20020a62f94e000000b006ea90941b22sm5554215pfm.40.2024.03.26.03.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:36:02 -0700 (PDT)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kelly_hung@asus.com,
	Allenyy_Hsu@asus.com,
	Kelly Hung <Kelly_Hung@asus.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Zev Weiss <zweiss@equinix.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Date: Tue, 26 Mar 2024 18:35:48 +0800
Message-Id: <20240326103549.2413515-2-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326103549.2413515-1-Kelly_Hung@asus.com>
References: <20240326103549.2413515-1-Kelly_Hung@asus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on ASUS X4TF.

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Zev Weiss <zweiss@equinix.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v5 -> v6:
- Add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
- Add Reviewed-by: Rob Herring <robh@kernel.org>
- Add Reviewed-by: Zev Weiss <zweiss@equinix.com>
- Add Acked-by: Conor Dooley <conor.dooley@microchip.com>
V4 -> V5: Update all changelog from v1 to v5.
V3 -> V4: The new compatible is a BMC for a ASUS X4TF server which use 
a ast2600-a3 chip, so correct string to asus,x4tf-bmc.
V2 -> V3: Add a label to indicate it is new compatible for bmc.
V1 -> V2: Remove blank in front of the string x4tf.
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3..0047eb4ab 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
-- 
2.25.1


