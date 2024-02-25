Return-Path: <linux-kernel+bounces-80202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00523862BC2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E601F2166F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A51B815;
	Sun, 25 Feb 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgjW9rFc"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3013AEE;
	Sun, 25 Feb 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878615; cv=none; b=MZUzntLffKQkvjAZ0AicpCSmWX/+l0k5OvPN9fNil/eOz1SkI+tfcXMa28a7qzTIY0wvuYi1M/JWpWMsrIZzQbzhemVg6vuGnH6Kmftw94B1ITvTWmESeTKca/UA/xNihv6hB/nCy/KxEXG3FiRDa30TbEBBnMDJ0FIn5a0PyqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878615; c=relaxed/simple;
	bh=jaE58dVT+Z5BQAhxxugZAsJOr197wav/S9cgS2l1Mj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFd6SFgCH2TL6S8EYMjMN71NC/91kH8p9LfbfpRFEJ13K+AMDiaLjNq/UHmnsM3cf8U+sDEHJYVkHw6z5exoY39U2ejraI8U4cGh+pTczj4wn7WX/c4U4pC3Vef8U/mFpQud6ApO6PZgcSOPHIvm/iTCn5C9EBeS7GbynIZ1FII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgjW9rFc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29a8911d11cso1025403a91.1;
        Sun, 25 Feb 2024 08:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708878613; x=1709483413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ik8qJ3aCWPUVoqq8sIut4tSoLjkKaRHYoxxij3VGIi8=;
        b=WgjW9rFcPfw6ZlI2n0WkyBN6PidCBCpkuBDxfvDH5tpjbZKh99Pxl6O5taAEpVIhIR
         KGkaV8dRsTy6KbWFIlwWaqg3L0HS6/enF5AH8wny4B5M2nCb+zxQrwApFStT4jgyBXi8
         rtWUKyS3RJgLVAmL5IVbiHP0Rjpvsv4curNuWv9ZJowPl9R3iwzttNXdH5gOHUMYq7jO
         XM7Co0ik1JJNERjlAouYTQPPBGcizcyaITLR0CaBEHE+z68+elMEasV4ZFzEMbhvWCa8
         WmVp7/QSRFWQx6Kb520sGmWQvt0sVc3oe0kMzhfheNCDUv/yDO3tx3wv806/od03SRuw
         fgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708878613; x=1709483413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik8qJ3aCWPUVoqq8sIut4tSoLjkKaRHYoxxij3VGIi8=;
        b=JhEt+l/83VNbXw2y2w8qQu7GSWQS4iKZQf6T7vOpimAiZwDODD5LU5IvhIhktZCWFd
         oKZDWtZ05+ksJGSp6v0M7N3UHqqagm2QDv7kYIC576jbG+XiR5pHniChP6DR0jUqCTxP
         hunE/dRZOhNeiUF6zgpHJIKfmW8cJ8hvXWnl+1ejR5f9hONrD2IQMbw/3PXCtJ1lyX9h
         sB5qSNJPNSJDdSd5PFa8YQDu/pCfqpAG13/A/vnvlWbahx7bZqN8mb0sZbsUkQBcYsdQ
         daXdb/6SyQY70IhPvkBKTlAbossoCZ+rfyEe6f4IfHoX2JV3XxWLd0CO+4OTeKuuUdHR
         pa7w==
X-Forwarded-Encrypted: i=1; AJvYcCUJxOlA6yNZJeFtFiICbkWFTtkbIff75Y3gs/rZU/jq/88Shv0566xTZ/nTvBbbd6KskNOdbQ4Y5Ti2EZ5cTT42UDOg4Y5g+KWZOfsk3Oo9qgEl9JjWW2rdUoVnN+wdqdO4+V8wyxNdZA==
X-Gm-Message-State: AOJu0YyOzPlsC0o00U1f84PVP54TTaSXGRwLRSqgQ4GPGPGo02Wb40nW
	ydhVm340wrIzKUCm4IYtSFFDSXTrv/6zPGIwi/M6cD+pzfHiRTsg
X-Google-Smtp-Source: AGHT+IHf/lXHhNv15L3Do33iLmHjyiKle0EvwF+z8mZN9vHVEv1VX6Yq+iak1DO7b3vnc5lu72bs5Q==
X-Received: by 2002:a17:90a:d489:b0:299:4fba:7434 with SMTP id s9-20020a17090ad48900b002994fba7434mr3351823pju.0.1708878612962;
        Sun, 25 Feb 2024 08:30:12 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090acb8c00b0029a4089fbf0sm2838367pju.16.2024.02.25.08.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:30:12 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 25 Feb 2024 13:29:54 -0300
Subject: [PATCH net-next v5 2/3] dt-bindings: net: dsa: realtek: add reset
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240225-realtek-reset-v5-2-5a4dc0879dfb@gmail.com>
References: <20240225-realtek-reset-v5-0-5a4dc0879dfb@gmail.com>
In-Reply-To: <20240225-realtek-reset-v5-0-5a4dc0879dfb@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=jaE58dVT+Z5BQAhxxugZAsJOr197wav/S9cgS2l1Mj4=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBl22sEYGX+z/PhrhYfnjofFhucvtWG8ORnJsHba
 AAHa2AQeh+JATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZdtrBAAKCRC7Edu60Qc7
 VogSB/wIJaGuL2BghBFVgVt3mIPLnElBrMmnmuq1jmu4V7sNRwONwVFmgx9vWh1YrZ91ywKHEvh
 oizRJpvPFX5y3P4VesmFqwwMBwMC3UcLMlLMFlnMGncqvd86V3Zi1C5zJDcWPP4TlhLDfg2jePr
 C1zwXt7fFj9I7PYxsJ/zS734O+zNx8RASm5OG00DoG6Hdt1Gi3IAIzSior16KcgG/Qttl3UdbwM
 MAfBUnoG16rW8S+N09dmEK61krRwcvUqPtwu2hbY7FNK+kgjl5oA4cZTOw6rJefZHBoyVtZDy0g
 FlgqxXQt3TjWStc9haqZXOLR4ij76BzB6KARyWn7stMp8B4u
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Realtek switches can use a reset controller instead of reset-gpios.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: devicetree@vger.kernel.org
Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/realtek.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index 46e113df77c8..70b6bda3cf98 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -59,6 +59,9 @@ properties:
     description: GPIO to be used to reset the whole device
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
   realtek,disable-leds:
     type: boolean
     description: |

-- 
2.43.0


