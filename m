Return-Path: <linux-kernel+bounces-78109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824C8860F06
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359001F23119
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE355D48A;
	Fri, 23 Feb 2024 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV8ih/fu"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC65CDDD;
	Fri, 23 Feb 2024 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683440; cv=none; b=RulqPGDoXfNZvb/2XjHkke6ndz//oCYLvGfDHf9b5GlXUumH4qKqqyeRkcibGKVAULUhQeGx8vhS5D7wALa5kWrefLagh4TS31ZEqQpQq/jd0fIbJhRNH+78ziG602NKRxjfmXVBI0M+Tge4DbHJmyoNrOE3HQk4UyggFcyoszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683440; c=relaxed/simple;
	bh=luWX7VBXFKcwN3ALF0NSfVrZNBf8N0YoZh779pzK8Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c836yGAsYPURAHHeF566gv7mlUCha5G5rJCc0LahFjx7sohNugALBLfBRZZQ3uayX4T0hsNW02MZu5ZgrNy5wbzEunl9lmFct5HsYR/jwhnfgODLsdy+FYFUO6JQbPsiRmGT53bmgyusrP1C8YiROVFX769AO31G6DlhZ5Gcvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV8ih/fu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so30267866b.0;
        Fri, 23 Feb 2024 02:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708683437; x=1709288237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85mVdfmieSyePN9kKLLWp/rml6afpBa0DNNt1hnWsOg=;
        b=XV8ih/fuPQD87GRSqIiS96LwTrTC+GMyRw5Q8rlxkEh6/tlr1HkuxA4ns0k6lkZY0H
         X2qjhwyjYlrf2nqM2+JjEETnC5QTqc/Zn1IllbYNL4xUygZ1JgEwuAlScw7w+TcRcLPE
         zv/nkt5JJaY6wYhSIecwrwlDZ3eTY5tVDgN50JsnLkNPdW+ms9YG2gh29pui/z4ShYZ9
         eL7o6mQ25IL1LBFr/bPR/itK0rSEz5txkjq0hPHmM0F9TaELUP/z+nl6CfEwPNoKtUUK
         vZ3wjPDV4285jqRPBQFiOctf/tGpH5KySgMHrbbUDJr7EHgfOBxHHj4WtnWIyaGutZwZ
         uAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708683437; x=1709288237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85mVdfmieSyePN9kKLLWp/rml6afpBa0DNNt1hnWsOg=;
        b=I45rJLdHeOWySRleaY+C5J6vjgR4MfiFYyvI0jKX7sUW70GLrm63VQw9a10UhJRcNM
         fANju3i8mCWxFT5eXhfNEzAmYiUMfBweSCuJ3xTDEWjAhkS0F6R2p/lkwg8Hzo85bjwy
         cKwQ7pMYO/18m3G0PbhIZQ+BoQMYo5OqDB32O+tY8juvSeuK2lCRvX4GLxMR1bKlxP8O
         tRIWRmsBWoSuciyMLX7FO8SY7f+/7SvJULM4phkaxj59AsXXAfm/0G/BjAalS/CyUFt+
         wZq5udf9NzhBkFORW5zfSFExGjuXRDnh5q2pT5fe4yAas8Q9c+xD1N6ucrESdIQZ1Vso
         YOUw==
X-Forwarded-Encrypted: i=1; AJvYcCUjHKkzjn6rgP/V3qCdBwDOasl9sjab6mB0PY86//npyxXVhSXn4epYmKhptdSSawqIffFBh5jXx6fxgoP43wRJPj55VeEO25F0ydFT41efP5Iw0TZcOxG5aDGAMQAjomsUwo8zhp4GRg==
X-Gm-Message-State: AOJu0YxI0CfQ/P15kJH+H3EJvJvPV3CEP4NnlE+9Ewnbxh5wz11V4piv
	27N52HxilQ5zD0dABbNAG0NZMRO12KbTyohyoxvfTRkOm58Wa6tI
X-Google-Smtp-Source: AGHT+IGPRSEDB/NYZrCr0iipCPdM8Mj0L6+q/X1kjeEbb5aISJQ4+uGlmTeluLm0fPU3TnORdwZqGg==
X-Received: by 2002:a17:906:3b12:b0:a3e:53d9:c7d5 with SMTP id g18-20020a1709063b1200b00a3e53d9c7d5mr1075726ejf.36.1708683436768;
        Fri, 23 Feb 2024 02:17:16 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ti7-20020a170907c20700b00a3d99dc3f3asm6667250ejc.67.2024.02.23.02.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:17:16 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 1/4] dt-bindings: vendor-prefixes: add Cudy
Date: Fri, 23 Feb 2024 11:17:06 +0100
Message-Id: <20240223101709.30072-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240223101709.30072-1-zajec5@gmail.com>
References: <20240223101709.30072-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Cudy is a Chinese company providing networking products.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 20ed04148092..57f91c83152e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -334,6 +334,8 @@ patternProperties:
     description: Czech Technical University in Prague
   "^cubietech,.*":
     description: Cubietech, Ltd.
+  "^cudy,.*":
+    description: Shenzhen Cudy Technology Co., Ltd.
   "^cui,.*":
     description: CUI Devices
   "^cypress,.*":
-- 
2.35.3


