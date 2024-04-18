Return-Path: <linux-kernel+bounces-149588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089868A932D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3341C20A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2980838F96;
	Thu, 18 Apr 2024 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="wRzKGQMy"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3825622
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422241; cv=none; b=CA0wSJNucehVO8Ur0PNtHhxZyJ+rzqSXRxPDHTK8e9lWcsRIL9iggFGG9lyfOqQvnKMYv35Pp6mLsEQ9PpHSSk0xXLfNQPZqXiJdrsj70xpEJuIyoZ0QSSdj2gPkSBa9c0OAyvXKAbD3WY9a/Q5W0C+ozjLF/xRFeP1MVPloiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422241; c=relaxed/simple;
	bh=IgFSS0qtSnyg++H1olUTQAlmpttnmEZ7gZvh7AhbrdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqT2TPalbG0CdRCRJ6UQwLAWT0pPHbYXlwmSaEdFrdAfSoFT38FdDhFg1WDL+mFr9k94hWTf5p487Y0lxLGWw3gS/CJMOfW78+B6DS3sqHn+c0Zkx8KOu1Y4fJBWJLpsKeLOqROyZI3zUZQnfu9fq0NqRMVKqdOerubTKy7otxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=wRzKGQMy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so677721a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1713422238; x=1714027038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39prjfdUZn68Ea0wBSxJWy7y6KU96R9Wr42vUXg8nHA=;
        b=wRzKGQMyy7LZx/hWyIHPeJCSYHVjd85B/xXbyMhyL5ETecUcEI7Sax/1ErjNMouwPZ
         kV2xitYzMf9GEdBwhRHY3ii5qSLtfYaLulHMKZHQ0qECdQs2V6p9g3xOFW5g2OIWKPQs
         zJgl7dSGegGW8LqwpRM4plOcUqOWmz8J6aUUAwUiwzuUbqHUD6MbA0xKdCAuAovFlBM6
         V84UhqThjyJULf6Dhbn/rvqfybrcIKIPqSF0Fl6At5zIQWSZhtKayTsq6hlqd5F9hDXx
         MtS9UBbSSDcDqN+nV5i/FTbK9EwLTZcSse/Z6V7v65nFvD2jxLHV2OITD3dScm4VD30d
         Bu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713422238; x=1714027038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39prjfdUZn68Ea0wBSxJWy7y6KU96R9Wr42vUXg8nHA=;
        b=Q95L9SB3Mt/KP0vdlf2lchsZKsIh+NUX9b6T0NRfiYwYpcYbRfIvDUdFfTbJjcbWvH
         jU9DS/iYR8L0VW8KM+tK/zi64JN2qAJvNlcP8NPwoKd0IY4F6XbUP8sz9ljyocagFhPk
         RWtxR0u3qYnM8LontFB3QQL57P+GRibH+EheZN44y33W99NQkylcecPFXarm3TBpYT+X
         wHwve2l/VebcnQXwgbKHex7M4FGxr28MBFtS39pwS/Q1j2runWp9IT2xshq0wWwbTTyB
         z68lMc4A/X+xfp385FruTQBDegOByyXgk06EoWpm5te1HFc31Rz9KSzKGXSr76vRHC1o
         dC6g==
X-Forwarded-Encrypted: i=1; AJvYcCUGF/679A11juzsC5fUV4Z7tOSxaazMwPOhHUC3SpQ/CiNKbr+lTisByAI6LIh4qlsUwi+XRx9Xo3Y909/7Tkv+JL+iV7to7HPNAvba
X-Gm-Message-State: AOJu0YxJJX8AK7BmU9FXfKD72ReUQTU/C5+lZ4CEO3x6xS/pLCpWCaKG
	YPt+7vVb50Pqm+lMUy9ageUJzczECwlD9ovoXzAX/e/WPNHR1aY4XmIyDY2hpis=
X-Google-Smtp-Source: AGHT+IFMMUtN5QDG0RL08DrlOyhBUpv/2mzTf2vAZ1XgVxE3n0VWHXu9Xd2BxaI1nvTV5u4aIeKVpw==
X-Received: by 2002:a50:c057:0:b0:56c:1696:58a8 with SMTP id u23-20020a50c057000000b0056c169658a8mr1537498edd.0.1713422238001;
        Wed, 17 Apr 2024 23:37:18 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b0056c24df7a78sm472277edb.5.2024.04.17.23.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:37:16 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 18 Apr 2024 08:36:54 +0200
Subject: [PATCH 1/2] arm64: dts: qcom: pmi632: Add vibrator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-fp3-vibra-v1-1-b636b8b3ff32@fairphone.com>
References: <20240418-fp3-vibra-v1-0-b636b8b3ff32@fairphone.com>
In-Reply-To: <20240418-fp3-vibra-v1-0-b636b8b3ff32@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

Add a node for the vibrator module found inside the PMI632.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pmi632.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qcom/pmi632.dtsi
index 94d53b1cf6c8..b4313728f3e7 100644
--- a/arch/arm64/boot/dts/qcom/pmi632.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
@@ -200,5 +200,11 @@ pmi632_lpg: pwm {
 
 			status = "disabled";
 		};
+
+		pmi632_vib: vibrator@5700 {
+			compatible = "qcom,pmi632-vib";
+			reg = <0x5700>;
+			status = "disabled";
+		};
 	};
 };

-- 
2.44.0


