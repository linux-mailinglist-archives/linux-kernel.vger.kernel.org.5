Return-Path: <linux-kernel+bounces-110266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A11885C49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F59281918
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9308625F;
	Thu, 21 Mar 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu35j85F"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3F86AE4;
	Thu, 21 Mar 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035685; cv=none; b=BsrgDtAkOMVT5/3S/rWxMvTdVnPaUOcb266tBG+FXnZZtonJBvq+zY4RwFTyJq9n3WyvsyHDnpD5QcWQkENh5H/euFO79r8AeRyIqLCvEe7HurrTl9nb8oQr6Cgj5nyxGyLmcDN+7Ro5eWRUv0Upxd/dP6zSe46LrI4lpuXKoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035685; c=relaxed/simple;
	bh=am2ZtxUQBQ7KZhI6Q5jiJiLGuPKU3XGm8lwYNqPhRBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2WlggFEiP1+yagbYddbkR02tquqHmEwzJWm3ulL3DcSb7d+CFC01ax1hE7mNxrOAl8TWm3nuhBYtVUk+VNfvDKP91w8glztyhVg5wwvbgZpZwUGw7sMSXbMkqu29w8yDamNe6WqxDtmT9V/pBdwcpBKX2n166Ysc5Ywb7Rkyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lu35j85F; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so1260530a12.0;
        Thu, 21 Mar 2024 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711035682; x=1711640482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6sNRhdlY9qNGPpCX62hoeCj6l+CfsEgQKmLhNgGUuI=;
        b=Lu35j85FkbVZ9EjtIcGwtc7GbBAIUUfJN3CQsMqIlGL1yd0tdLlWABBbc4KWTFHRnu
         yu2l2rWd19h10c5bIN8UGZlZ4iunVmHwQlBS/KQyUupdaJqsG4onal5XKeFMZuuRAT/s
         nUBMwfOOY82v7Ov4EkToaKTssYFDZEr86i7QvLfnP+z1UuFt11NedHq0nkM5McAEHvpW
         PloAN32NgC9mE2aEwkL5urvsfS3moAWDRkbINjgO8NtrF3XdjFQa8HUFV6wISK+SMv8j
         eX4YvCxWzgClIKWitU1tugooQfzVFhjSvFhQuAkvV79stZRE+HU/NwtjUd7y3nBmtlkS
         Rsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035682; x=1711640482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6sNRhdlY9qNGPpCX62hoeCj6l+CfsEgQKmLhNgGUuI=;
        b=mboDm1g3iDP9xW7woiN+vtUBC6XXwmNeJfI2XSIK2iJi+tgT2FAd8aBMdbJUhmpqE6
         2FflIPSemfvme1C3gzM5JurnYu1pAiuvrV8uivMfCFKXwBNPdHf35Puyk/+OA8ShlPft
         DunvGhKo5wjBwwArvhbf+ihSuKdkX/u3x0syDUgv80dKSuveSUGlJSf+frRaj1V+87KP
         N63vcqL/Rmj9zCjzJBB657dP5+IbhBvdXuo1fQ06lZkdW1j7VbfR2ayMx0C5mgAdqEt6
         xsPfNlmf/OOk6Jc4noFDt13376OeWQ0cgpQ9DJpElH2uUg0Y7hcnTfySlSwegUmAjJdO
         RJTw==
X-Forwarded-Encrypted: i=1; AJvYcCVt/NsRpI9LjWe3+w/FNqESk+xdIvki72qoI6HOEs8h/38w0ZUrwwPiCY38HTXxKiZtkpcPHtx++Jc5AMpkZkRe4r4UCLdZ4S+P23gtWBzKM5AVYveqVtcXRo5TTPjlbiqL23dW9nMGVfb8rdDMtZ1zmFEKlIB8c1Z7VHi+K30hoCZej5ZLdnpdHxodOgv9RHxR9aLy+MqUafq2002xb7RKqQ==
X-Gm-Message-State: AOJu0YzaCJZPIdKaYpNzzKYn7LiCfESA2A250Bt1dsqLjZhCgjfd0cJY
	4q/coChsTn2uNwCmfogXZyOXmHaGjtZEjQmRWX7XPkjGRv6SLy9a
X-Google-Smtp-Source: AGHT+IEtslIs7e9LdH5fCF9lUmECNnBFRT+wc2e1Vz/+KZFKeUJe6FPFLuJ9iA3USQ6/+4lW1JKblg==
X-Received: by 2002:a17:906:4750:b0:a46:c0dd:88f7 with SMTP id j16-20020a170906475000b00a46c0dd88f7mr7452691ejs.17.1711035682080;
        Thu, 21 Mar 2024 08:41:22 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::11c2])
        by smtp.googlemail.com with ESMTPSA id wy3-20020a170906fe0300b00a46b10861acsm36851ejb.208.2024.03.21.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 08:41:21 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Josua Mayer <josua@solid-run.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: serial: fsl-linflexuart: add compatible for S32G3
Date: Thu, 21 Mar 2024 16:41:04 +0100
Message-Id: <20240321154108.146223-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240321154108.146223-1-wafgo01@gmail.com>
References: <20240321154108.146223-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the uart binding of NXP S32G3 platforms. Here
we use "s32v234-linflexuart" as fallback since the current linflexuart
driver can still work on S32G3.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 .../devicetree/bindings/serial/fsl,s32-linflexuart.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index 7a105551fa6a..f8eb92c9a8d9 100644
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -25,6 +25,9 @@ properties:
       - items:
           - const: nxp,s32g2-linflexuart
           - const: fsl,s32v234-linflexuart
+      - items:
+          - const: nxp,s32g3-linflexuart
+          - const: fsl,s32v234-linflexuart
 
   reg:
     maxItems: 1
-- 
2.25.1


