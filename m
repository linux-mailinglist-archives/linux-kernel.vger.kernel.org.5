Return-Path: <linux-kernel+bounces-68422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3114857A04
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8FC28252B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03274200BF;
	Fri, 16 Feb 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="gbiXuLJc"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DFA1CD36
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078258; cv=none; b=ADjz3zkY+1+ac3feLl+WxfttG9s2WvLc/xlqmhj6EkHGZo/xVinkIvqSSNCBnb42G8ZdKMMNczP/6rWlaLYcBRmO4ayIbkc+k3OD1pe3MO+gR7rsH6CnRum3LZBqIyXElylvY3FL0gXQgxoCtX/3k2G+gO2isU83GC3Dfkvwd1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078258; c=relaxed/simple;
	bh=xpMb11dxg64nZ8TeWmw4wTspdBi2WW1ycVxNAeNDxxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngvKfPNkdTNeqQpYwXIwa/qtz0krlbxBz0DqxKkb7tuSToiNsTgnvQXWFAf5iHF8Xc/LcoINPlEIAIYZuIC2BrR30H2iCPvbFCWlKaCPTZFqSQYNP58lxOgjs3JZyXRpfsg9OS6rk+ZYA2fqBHYYm2rAGjMnBDs/FxvCX9p9JJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=gbiXuLJc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56394d0ee54so681735a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1708078254; x=1708683054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=revdL7g1oAcERXcWT0jDr3geYXgL8Ugw/vEWapN0s+4=;
        b=gbiXuLJc3zpa100ANalakbCCHNufMPUpc6u668nXSfDTS9opCW24GtWw3DnhjW6/r2
         L9v2ue3nDChaQxrKKCtJxWNqZwLIKyFKjlved4YYPEdaaBrRnEtM5yAnCE9v720S96/p
         7z8kZx9iyxHp1/YBsEJfW4yoAkOUL7uDTi2ml4g3cBrLxE0lnvpOQp8NCRl0X/L/Pqgd
         bNUJJfuNuEMa4Wpd8SKKgCAGN20uHD+p2hOj5cmoxKunby1vYpxB5/SKHSmNsh0ClMWy
         yLFf+I6eLxqgIT4/l5ka5kk8AnWdKcvLUpllNwtX7wOoRV4pgs/AdVeVeEuewOTy5IUo
         d6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078254; x=1708683054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=revdL7g1oAcERXcWT0jDr3geYXgL8Ugw/vEWapN0s+4=;
        b=lR8Gwtp3HrD+2F/8VYnupTZ7zod+CppLtpoNQyaDsvNCqjz5JWJ2kwxSf0Gpk2HU6i
         C2YUeqvt4P3/wflWH+pxLRLY4ZADZx7XiU2gptSMv14yTRUDsTvbwC6zGlX24umBlX81
         hTCob/OAOwzSI8bKUACr9dWzzlxTMXKNMwegnQ/MyA+SM4TI6ufYDZZJzue78kAFnjEj
         jM4msGOWLicRYWhMmQStOssP7URUs5T4eDHH3WybE/oz04cB4i+Id/q1KsrAc17FyH4M
         e0qRYgOX0Dn7jGUCsPYIevVSS5I5Ht9VJBDWhIKWY0BFX6AoacHbjtKUt5NQCjoDlCCX
         o0jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPm7FjbTFICex9OFaossr3nvOR4eDMmX7nDKbMwtBUT3Qkm7fPHkDeznEz/Mi586ZiV6tFynEuxTdnApPhRfT33gDvdAQGPRKKu35f
X-Gm-Message-State: AOJu0Yw0cUjdsF+Awl3TL84H0NA3bfNo509r3nHquKIFA97yXHSrzQMr
	lJcUUgKjXo67nvn7T3hTx62uWuf/WKGaeeqO8yLpnRFM5TdJA2Pb00uhxGlPa7A=
X-Google-Smtp-Source: AGHT+IHvVyi01m5WRubx/2LzMcgOYA+L1JCpSnOZwUbC6zufjujFQB6IyuxF+9dIEw7v0O3P2l7c/w==
X-Received: by 2002:a17:906:719b:b0:a3d:a773:b9be with SMTP id h27-20020a170906719b00b00a3da773b9bemr2526010ejk.76.1708078254638;
        Fri, 16 Feb 2024 02:10:54 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm1398019ejd.113.2024.02.16.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 02:10:53 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 16 Feb 2024 11:10:50 +0100
Subject: [PATCH v3 3/4] arm64: dts: qcom: sm6350: Remove "disabled" state
 of GMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-fp4-panel-v3-3-a556e4b79640@fairphone.com>
References: <20240216-fp4-panel-v3-0-a556e4b79640@fairphone.com>
In-Reply-To: <20240216-fp4-panel-v3-0-a556e4b79640@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

The GMU won't probe without GPU being enabled, so we can remove the
disabled status so we don't have to explicitly enable the GMU in all the
devices that enable GPU.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 43cffe8e1247..5a05f14669be 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1439,8 +1439,6 @@ gmu: gmu@3d6a000 {
 
 			operating-points-v2 = <&gmu_opp_table>;
 
-			status = "disabled";
-
 			gmu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.43.2


