Return-Path: <linux-kernel+bounces-38569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0070383C240
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2F41F24203
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5347F5D;
	Thu, 25 Jan 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvkP7mgH"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C099374F5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184693; cv=none; b=NkHYJUlRBj/fdMqDXLwZULIdUSXN2MzUNd3+DMqhPH+9jkGl5dlX28oyn8Q7fgXTZLhMQR1vwt/tP2wgLvKjNgU57x3rw4fq2afvi8wSjPZ9hVQVVVRLwoRXmpBqyeUl3PvQDzhYCx64UGb4c2SnxmHU5ZoIH7kHHajVcDY2jq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184693; c=relaxed/simple;
	bh=ZPr6E4c1CKD0WVJLVQoqbaMXnDZAUQSUX250E823OTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6PzvJWFu7a/FWuPkDJtJeJhgTaOBpu4wReqEcbzzlYrcDifYnZvmQ9AfufxQ/z8cS6xVhMeQuH5uJgiqoSa2F1qg1g8+HR5vPNCJvwnwrQ02+8oRty0O14h9U83tK8yga/rfDOcQ9J8fQEmXaUgK45E2IwRffIv8rykw8jWEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UvkP7mgH; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-510218ab26fso157760e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706184688; x=1706789488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yB2oUZTJxFBXmfGYTP34odt/VQAw3YcB9sjxxvoA4rY=;
        b=UvkP7mgHpzs612whY5LImcD0LMgRQ756HnNzbWZKQ5QR8elIritTmOGJXmkMJHgSkn
         5gaOkINnZyuZFuk2LyhdaQvGgDjUf9qs2jC3ZvI63txBVPbJWPkaQ/AqVBo7i/CMrthW
         RU5OdxpASB/pLMqZ5THWg8u0t2ajjO+n5HBfMsv1FaF/GFMt13bPMySUoEJOySqWqKXi
         IiM9hazFRIajMdRJcv5Fwalr0dq7tlFGsvfi1vaen9EdZIHLZbi2pRBmtq+0DExrg/mq
         GabOITeVrTHW8tOYOXySvYkjUMuzXEtogEB20v1JV1/1gz+tJqKEvRPNSKfDxup0CRsW
         ykrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706184688; x=1706789488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yB2oUZTJxFBXmfGYTP34odt/VQAw3YcB9sjxxvoA4rY=;
        b=Pifv0gnC0ZSKI1GXnFHkuPHI8AGI0yUToLTvlNa+EmU/oCFxlMfLnAa3rzG3lhFQAJ
         +w7gJpsrqLmiFtAFoRHlwOyOrXk89i19iSipGcYI3z9ln8S9+HeaWPrL0fKvDIjbAtwf
         qFAn+p2FH/bX1/oRr1+r2euq5X+Z705E+ScAWxm9outpQBLkuPhMDIqALwiD6EKJ7ZmA
         PDBAS0Yskezrc2B9IJF5gZjbbV/lCjDNmGN3zhcdc8F/aCVi8+Fx9BIcl7yWqlol/x8K
         8ZF+xa+f5593IW/mvnQD2hX1LZHdp0dLCyv8SdQJ6ylGGQlkNZsfBNtrUxmDiqXinf+v
         bMLA==
X-Gm-Message-State: AOJu0YzE3lFtzqNnYJLuPR2ehTpXxFUGPdPDdsuuM+inyf5NRdV4alQ0
	IOzV3cpkLbT+RvD9FmfGDDFLR1qu28+x9b9LA0/rFqWXIfEHuW2ElH5jb2ypRLU=
X-Google-Smtp-Source: AGHT+IGJ9Ulfs3cW+fmPeCGH3QcncDosCorfFRPWC8zOqkEkU5iEvWfN4BRmkCwx0JY3N+ie1eIw6Q==
X-Received: by 2002:a05:6512:ea0:b0:50e:a6f8:aacf with SMTP id bi32-20020a0565120ea000b0050ea6f8aacfmr820110lfb.14.1706184688088;
        Thu, 25 Jan 2024 04:11:28 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y20-20020a196414000000b005102188d154sm21221lfb.108.2024.01.25.04.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 04:11:27 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 25 Jan 2024 13:11:15 +0100
Subject: [PATCH 1/2] dt-bindings: thermal-zones: Don't require
 polling-delay(-passive)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-topic-thermal-v1-1-3c9d4dced138@linaro.org>
References: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
In-Reply-To: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

Currently, thermal zones associated with providers that have interrupts
for signaling hot/critical trips are required to set a polling-delay
of 0 to indicate no polling. This feels a bit backwards.

Assume 0 (no polling) when these properties are not defined.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index dbd52620d293..68398e7e8655 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -228,8 +228,6 @@ patternProperties:
             additionalProperties: false
 
     required:
-      - polling-delay
-      - polling-delay-passive
       - thermal-sensors
       - trips
 

-- 
2.40.1


