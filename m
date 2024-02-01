Return-Path: <linux-kernel+bounces-47842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A55845395
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE55B266BB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3A415B0E8;
	Thu,  1 Feb 2024 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vv9JpJmz"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1115AAC2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778986; cv=none; b=IpKvSVx88iEOKK19fJLKU34IwIkEvIeBtsVqFzrN1rLLpgaN0BVa9X39XvAxFi7OIRG2DZkYwj+mwZetvyqUfGEKIaVdtHlvCS7cmpqxR0DIFU4roGU2iwigA7RYFwbhHBFQYy6b4lNkYRjEytwPu524Qi7WutCFzudVpbvBNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778986; c=relaxed/simple;
	bh=5OTikD6CuPK8gKbmtuehnyPLyBNME4taPsrO/Ys9BZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l3j4cWMur6yH3cArSZkESS0ZhrCA7/y54DYORoSgRFdQduXcyv+BtEOSrM0X5q1pcYlEJdKkSMXgIfT+1clyw6JsBC3lI9YwZaCrIByy5QYPBbyfd3UFHVZUjxWdy49UIalkM3Nz8BmSpEF/4jAv3Gd/lm8jYvN4ZCPuJ+geNo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vv9JpJmz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so5899195e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706778983; x=1707383783; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KbM4ttdeCgtUREmJp18n91Tmg8C/A3C0WQ15eddMLUo=;
        b=Vv9JpJmzJP1omTVYowGKo1ODBhAScLvPJS0qKC/n3KwtJbVbHhJ+KU0fDWWpTG/LjM
         vWOMnLf7skdNm/D2ewMU6J6gVaqz0IiXOA8tLgA0WsMLbLDjLRLhcee3mo4wd1AIHEZ4
         Dw0eGXK013V0v/f/XOSVpDQkCrUT75aK2IYBrBew5dmgNqvoxJdIXkt+BgrDr5yUp+gQ
         bBkwUnPnWLqDP5yUBYiVHhHN8hxaRq+DOr2TWeMFGrCEjVBjkj07sUj+EizrskiTkEJ5
         DJi8VZbgYRxu1nHF1tO9oo3QbsFAdk+3uA6eDTN6v3x9w7ppuUcldK8cljFqFKQkGjj9
         00KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778983; x=1707383783;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbM4ttdeCgtUREmJp18n91Tmg8C/A3C0WQ15eddMLUo=;
        b=kiUWe2qOA+gqVi2vgLXau2kn8oFCuKMVPHFZ4sH6oVZLny9MDaF83tOZnpGNaoQyg6
         nqWj9M+3hmQfBPeYZx1LgNq+RQQ3DpGEFpSeF/QdZYlF1mgiJtBQiHWeN06IbUued2vx
         xBo0ahq1lX9sUqDvPqseTk3IOFsSP1FFRlq5K/2i65uWPQ4pwVHZe1bbz0x+F7zOgO4s
         j3AnN7P/Um9yazgOgYNdcwJA4XIMRZ1yE05Mni0vqy+IP6LolCYyLcmscJaIdDrrJIQJ
         AG7QtlvszVjmNRsOdBDEGitov2csyOeQvUEHzVTGQLXKMFb2XjKpcphsGE8IIvat2v3M
         VAyg==
X-Gm-Message-State: AOJu0YwZSHlu8LEEooi1jOb0I/MLSxRyW1FtnEL3tjt5zjYA3KcwGuaf
	pAmwWn4I75kkwnNlh77KNMB32KIcLF+8OUz07waff5lEIxnta2uIRXMEH7USAfI=
X-Google-Smtp-Source: AGHT+IEEpYejzM4XUH+oYeUuGYpKcB2ZFEYwFkYNkUdFuHQItoqzDMOptLCRHJrPVhpiBEVsDktmPA==
X-Received: by 2002:a05:600c:4589:b0:40e:8fe8:a173 with SMTP id r9-20020a05600c458900b0040e8fe8a173mr1325416wmo.4.1706778983084;
        Thu, 01 Feb 2024 01:16:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUmfmXqD2prUNRuX6FAeUYPHkAeC6zyJoArufPykTwgy3U/UhlaCKbnerO0KDJnPiwoBU1tZlexnGgTm2DrczyYvLOB22hQSlBRUVSzxBJhdiL60S1/q7/H1Anqpz1rGx1mTROPcEX0CVZsH1kpj5RzIV5gvW25hsWvuk0/+Aag06gdN7BEEYHGmitcpVLG8T4y64nS71g0lkO7Q+T7B8shrpIn/BMyiC+QJZgBO32VFJ60bowcEDh7RDvJ01xOVGICJ6poi5uWi2gpIhVnSo+oGy12vxOVjd9e0O/Va6FRB6WH
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id jn22-20020a05600c6b1600b0040ef63a162dsm3804881wmb.26.2024.02.01.01.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:16:22 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 01 Feb 2024 10:16:21 +0100
Subject: [PATCH] arm64: dts: qcom: sm8550-hdk: correct WCD9385 route and
 port mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-topic-sm8550-hdk8550-audio-fix-v1-1-aa526c9c91d5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGRhu2UC/x2NSwqAMAwFryJZG0iLxc9VxIXaVINopVURxLtbX
 A0zi/ceiByEIzTZA4EvieK3JCrPYJz7bWIUmxw06YI0KTz8LiPGtTKGcLbLz/604tHJjaasXVU
 6RfVgII3sgVP+D9rufT8c3LoocAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2412;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=5OTikD6CuPK8gKbmtuehnyPLyBNME4taPsrO/Ys9BZw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlu2FlCJhAxbNR2uAtR8CkZIlAdrUez9GIT5QqknIe
 /uuaoH+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZbthZQAKCRB33NvayMhJ0QpnD/
 97YNRMRsDuqWFFHIz8Lw+AOQfhCgq+nfmWUK3MHVgglsO5sfPPrJR2tJBZO9tX8bP8XQAO6mkq+xam
 416fGhEWupmRj+RQ5rfjq1evhr6FxsknBgBJ5V1vhd/sEp035VZLHOLEw6fk9KUQhOZlT79w8jeeHC
 3yCN042jDKri2l5k8ygP4PiFNGBV8o4lgsIOh9TSkId/yWdJeuFox9Ac0+T1w5bVDQZG326Tu8fEgA
 fVCpE0NTyKei2Tf++dH8oEquNYrX25oWCAWFNJBT358d4DRwFTl36wUB3JIIsF9fFqgqAxdYmR0ho2
 JIw0db134DfBIMTVOqUQ108WMY2GWyn1UCKGaZ4Oj0KDQWgHhTCxxQvdM+dj1tpMHZlmKH8iOUQaxk
 T2suGKdgFaZVU5iOmrHsESuAeIwE3qhCKlLWuLyH33B+wZMjtE7pj+KCrJgZ24eihewWNlKNo6wSfe
 tg1jHVuPttr5cGd6czIqIkPhOi225VWOsDXaLutIsu3pNxXjldIT3cQPsxqe/aveNzhYTb3SFfQ+pn
 7MnIYuxnt4fiUcqS3yV2Ow3l8OrzT0cC/jbpS9J9C50mKhtCVXJWP2WFZG03kw0XKASvDpIB1QSFSM
 +Hx0XmlxOp7kD2jz1th8xWs67P5ZsnJZf2zRyetzmYEb0FwaaEGteOOtFxjA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Starting from SM8550, the TX ADC input soundwire port is offset by 1,
and uses the new SWR_INPUTx input ports, so replace the legacy
SWR_ADCx routes for SWR_INPUT0 & SWR_INPUT1 following the correct
TX Soundwire port mapping.

Add some comments on the routing for clarity.

Fixes: b5e25ded2721 ("arm64: dts: qcom: sm8550: add support for the SM8550-HDK board")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 87276c39c589..12d60a0ee095 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -211,9 +211,9 @@ sound {
 				"AMIC1", "MIC BIAS1",
 				"AMIC2", "MIC BIAS2",
 				"AMIC5", "MIC BIAS4",
-				"TX SWR_ADC0", "ADC1_OUTPUT",
-				"TX SWR_ADC1", "ADC2_OUTPUT",
-				"TX SWR_ADC3", "ADC4_OUTPUT";
+				"TX SWR_INPUT0", "ADC1_OUTPUT",
+				"TX SWR_INPUT1", "ADC2_OUTPUT",
+				"TX SWR_INPUT1", "ADC4_OUTPUT";
 
 		wcd-playback-dai-link {
 			link-name = "WCD Playback";
@@ -1139,6 +1139,13 @@ wcd_rx: codec@0,4 {
 		compatible = "sdw20217010d00";
 		reg = <0 4>;
 
+		/*
+		 * WCD9385 RX Port 1 (HPH_L/R)      <=> SWR1 Port 1 (HPH_L/R)
+		 * WCD9385 RX Port 2 (CLSH)         <=> SWR1 Port 2 (CLSH)
+		 * WCD9385 RX Port 3 (COMP_L/R)     <=> SWR1 Port 3 (COMP_L/R)
+		 * WCD9385 RX Port 4 (LO)           <=> SWR1 Port 4 (LO)
+		 * WCD9385 RX Port 5 (DSD_L/R)      <=> SWR1 Port 5 (DSD_L/R)
+		 */
 		qcom,rx-port-mapping = <1 2 3 4 5>;
 	};
 };
@@ -1151,7 +1158,13 @@ wcd_tx: codec@0,3 {
 		compatible = "sdw20217010d00";
 		reg = <0 3>;
 
-		qcom,tx-port-mapping = <1 1 2 3>;
+		/*
+		 * WCD9385 TX Port 1 (ADC1,2)             <=> SWR2 Port 2 (TX SWR_INPUT 0,1,2,3)
+		 * WCD9385 TX Port 2 (ADC3,4)             <=> SWR2 Port 2 (TX SWR_INPUT 0,1,2,3)
+		 * WCD9385 TX Port 3 (DMIC0,1,2,3 & MBHC) <=> SWR2 Port 3 (TX SWR_INPUT 4,5,6,7)
+		 * WCD9385 TX Port 4 (DMIC4,5,6,7)        <=> SWR2 Port 4 (TX SWR_INPUT 8,9,10,11)
+		 */
+		qcom,tx-port-mapping = <2 2 3 4>;
 	};
 };
 

---
base-commit: 51b70ff55ed88edd19b080a524063446bcc34b62
change-id: 20240201-topic-sm8550-hdk8550-audio-fix-579f87f109b5

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


