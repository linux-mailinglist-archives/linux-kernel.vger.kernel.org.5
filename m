Return-Path: <linux-kernel+bounces-6679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ACF819BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E431F266AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A620DCB;
	Wed, 20 Dec 2023 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="uBMaLhFT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3385C208CB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a233a60f8feso443579266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1703066580; x=1703671380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZG9t7JfVXwtnb6DRy4cZuLmEqAW2xHjdtAPD5UdCGY8=;
        b=uBMaLhFTEIcBTJORZ7u2tqXqHmRv14X+AgM6fM6g9eOfbePkgRzlKYosus+VAoPBSD
         w124FDhkJqBcaoDJcCVflCCKr6ETy/OryhDqTb4xKSfhRdV01sc8/I1cdxb1D6wGAv3h
         wWlmQ0NG/AxPeXskBIsdsJR5SbyBhZaj6PEjZ7KP4kLF2HV/MWY7uu6jEQ329pxyMHW2
         FUSWPzusjwU4JD5XgIHXcp9neWkiCzaSyI0g+CydjsCP4SMi/NRRcStU6gf4SObNXGyh
         H3LJmjW8uPtwaONHXOqFFEEifwGZsdpD12rm2J7h3dFYILgvRygHVnFzejv4RjqlF3Wp
         tgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066580; x=1703671380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZG9t7JfVXwtnb6DRy4cZuLmEqAW2xHjdtAPD5UdCGY8=;
        b=AdeFGpNVDcBJurinS7ZRb1+wrPuP25ISjuh0l0WbVc3LHM0HT2XvcIHhzloW64ujab
         jYmYYYOotlYJvyGH3i79ZpSht16ssZT1xONJkGqY673jpG0Y1VAr4JIXDuVxPwE+CiTR
         u2X54CrZY6oIxRB96hYNi5zN48KQoxupXX80g+Xj26gXBjYyogi68m9by0wX7kRoxxUp
         hWep+nxarjjWBLiOXJmAnpEOMMWczGUPuKIj1JeYZ1OcTvcLA82mueOeRKuJtXP0zTzp
         F5z3V94buiI+woGzsIgyMNCRdgmmcTCwSEcH4Ja0qd6v1clXt4lErGx0VKD3SVFGIon/
         3iVQ==
X-Gm-Message-State: AOJu0Yxo2Yh1ad5FK780deL47SUQvKrBHy2Ip8BKWChjjx2kKy3Ux5C4
	jA3E2xn1KfxnGC+153a+d3Kiww==
X-Google-Smtp-Source: AGHT+IFeUc7MhgtuoLd1PoqD17miYislsdV/yOLe/vhsYNTOz+seUTv1KFWTeqG8CfQaVUHNq+k0ow==
X-Received: by 2002:a17:906:24cf:b0:a23:5914:4a9c with SMTP id f15-20020a17090624cf00b00a2359144a9cmr2225503ejb.150.1703066580465;
        Wed, 20 Dec 2023 02:03:00 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906561200b00a2356a7eafasm3718681ejq.199.2023.12.20.02.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:02:59 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 20 Dec 2023 11:02:56 +0100
Subject: [PATCH 1/3] dt-bindings: soc: qcom: qcom,pmic-glink: document
 QCM6490 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-fp5-pmic-glink-v1-1-2a1f8e3c661c@fairphone.com>
References: <20231220-fp5-pmic-glink-v1-0-2a1f8e3c661c@fairphone.com>
In-Reply-To: <20231220-fp5-pmic-glink-v1-0-2a1f8e3c661c@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

Document the QCM6490 compatible used to describe the pmic glink on this
platform.

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


