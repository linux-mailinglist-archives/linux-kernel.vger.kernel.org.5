Return-Path: <linux-kernel+bounces-57776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF28D84DD53
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF2F1C24B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD006BFD7;
	Thu,  8 Feb 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="jlhN4aa/"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778A6BFD2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386009; cv=none; b=qh8ZwScEDb0tWUwQmhq+ohVlzMUB2zREPqKbJsRjOEYJ6nBZ8q5nARitdXnx7cNRuKLmtx2IrYE2skZxQ7Qh/ds0sx6QjOZY7IJvQKZOwlMY7QFE8UWtQrzNoeap1P1sah56Wt8UrdeCFHgCHLEh2fJ5p96t1SjhvlZ0ocpwBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386009; c=relaxed/simple;
	bh=NyVjwsWMQX82WHMlcOO3VcS08l7E0Fsmvz23GCnSIEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2SmMK7x6IPP6EK90lKM0pPId6+d3+k+/tVBzSDz5YvhBoOuCexWco+bYHOx8qY3lz1TK6Han6xAbeXkBzXA57xlpceSLDeKRMfntYhvOlGa3FMVNI/zt/flsHgzEsZSBzWEYsSTTHwhVOsEYw5fRGpO8FznhHtYshiE2zbOr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=jlhN4aa/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116643c64eso2936067e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1707386006; x=1707990806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWOfUyOzPB5/mozZ+qlaSvYlPa0Qvs9EHroeZTTEO0I=;
        b=jlhN4aa/8E6AnYcWRGZoarGgVet150D66nrligeZB/ljN6KSYgPIf9UIbQV/yes4f+
         z5o0dhzLogge9qpxDaVD2OL0IbFY0vkjUSyXyKnRhEPMCR1C6YldR+cJr3peNbO3TXx8
         zM9BgZoPWMUju0uHt3Eh9kB7xDqs9qcsIFMyf3v+L21s+8D9d0CrHSQtovHmL7mXWu51
         RWwwRqRL63ZD/Kc6kuItB29TeGB5YsLWquN5eRMP/dmgbCqtHt5Xmt8rsGMXYfHgiGS+
         ZpNWkVO1Re1N/4Sj+ZNPYSD2OzXUqKzZUX5X/mBjf/yVfHw+sOuiEb2P8bVFxBu+7YZN
         4P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386006; x=1707990806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWOfUyOzPB5/mozZ+qlaSvYlPa0Qvs9EHroeZTTEO0I=;
        b=PNfw4TifiqW5K5zwCXLUSsNIF+XvF/MSbn5jH6v6Qx6U8/zt5LmDrUhNjbIvDIvNnG
         WUaHVkBrDvuFDQyaYzd8TFcFGQ/H3NokZpYjgTMc/PS+xruyrXHnKOLfsN3VegP3OaUx
         JoBtGPRJgqZqK3Nd/d68qYNFzN+xJf9aA06CPJXVNgyJw4+4OyymZ/NdgEj3/aoMVc7s
         jvtcG47QdGkhUKUm/j61c3pGW+3Ox88KMsVFa5KhBOs4S18b9hcyRQIDxTGkb6LmZNPK
         0FUxmE+37bwfcOR7ZEGUeHWPcQqoBTzeb2oPcCbKV6htzPmjPgCH9LwubtL7W3Wx+olq
         lWTg==
X-Gm-Message-State: AOJu0YxFttPria3ampkc6wDU1vFpp+4ljz6BaqsRwPqPwPbJuLo8pDCl
	jZjH0t83mmmEBWvbrtiUKLCC2RRhEOJpzf/MUhFH5LDy3Dud0kBRexU0suOwhTo=
X-Google-Smtp-Source: AGHT+IHAWb0Lxtlk5mrU5b180xlwuOt6wgXF5iY8JCV2sTCu5kz4CD8m82mu74gG2g+o6r8gHXcK/A==
X-Received: by 2002:a2e:a174:0:b0:2d0:af40:8be7 with SMTP id u20-20020a2ea174000000b002d0af408be7mr6141083ljl.43.1707386006074;
        Thu, 08 Feb 2024 01:53:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyardZa4isE7GrA2BO/htRppIJF9wLNZ8+t/Z6WvZBH835woh7FQW5ZKlDCIaQcawIyeQzBpRFQ9MDiXzTXJXBLPlMeDMo1gB6J1OXGbqy+HeLpO5dp6Zeqj8o0be31/gQ5PE/sYIBtu4t+xPN7qrTUJCegXC6bVaqIhDCTmd4ta+WF5BJFkwwblHbBQnVyUyp1bLqKoPYOvlkvDaUfVek6NBYaaKLNc/TUvRxMlKhnmq8ngcMt4WiILH+gwI9rhWAjLVp4B/Ar22ujurEDpE8r3oJb+RDon9TjV4vzK24AjuXdjIt4NAehaa0kJk1WxSmpAMuY17YHtNxCXx754Zl80tAej5bv3LIoGy/ElXDcLkZCI9ctsOOduxSqsCi7XMpfca0DeZyvXUKj9ty+BecGgtVrHpdvyi4d4WU1la2WGiL+9yJO0Sm8NZpQyzEwyA0kWCSyxuo17o4N9IwFagZgwcas6VDuPoBMWXRQ/hH0lwwZYfeTCLO8wVLRDQoAKu85SJgD+2bk6xCLXUFmNmwSiZvlGET4Tw/MR/cMG7aiCn9B1IFKiS2Ik4Y2pCSFpoKcit7Hv2GxhtvAiO+Ixa5dVrr2w0OcnJjrIFu3DwmMupd
Received: from otso.luca.vpn.lucaweiss.eu (ip-185-104-137-32.ptr.icomera.net. [185.104.137.32])
        by smtp.gmail.com with ESMTPSA id d20-20020a170903209400b001d8f111804asm2956685plc.113.2024.02.08.01.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:53:25 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 08 Feb 2024 10:52:32 +0100
Subject: [PATCH v2 1/2] dt-bindings: soc: qcom: qcom,pmic-glink: document
 QCM6490 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-fp5-pmic-glink-v2-1-4837d4abd5a4@fairphone.com>
References: <20240208-fp5-pmic-glink-v2-0-4837d4abd5a4@fairphone.com>
In-Reply-To: <20240208-fp5-pmic-glink-v2-0-4837d4abd5a4@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 cros-qcom-dts-watchers@chromium.org, Rob Herring <robh@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

Document the QCM6490 compatible used to describe the pmic glink on this
platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 61df97ffe1e4..101c09554b80 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -23,6 +23,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - qcom,qcm6490-pmic-glink
               - qcom,sc8180x-pmic-glink
               - qcom,sc8280xp-pmic-glink
               - qcom,sm8350-pmic-glink

-- 
2.43.0


