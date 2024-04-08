Return-Path: <linux-kernel+bounces-134719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE17C89B5FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECFC1C210DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B7F566A;
	Mon,  8 Apr 2024 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNKaF6Zr"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681B524A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543649; cv=none; b=F8t3mqIY+4XYR9LwiZ9VvGAgJLDz+enEgg/gOo+C2ZaK1EsMEOID5pt4Q0a1OJsXz667Zad7UORIApjQTAdybzFcF4IR40v9KgHVtrPi11KU4/hSwZJPi263WRa1nB53d2A5mX1JeGHlFY3eHYVVRWii4kCyOogY2xdSeDGGx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543649; c=relaxed/simple;
	bh=MrRma8bXJiIflCVU3n2w+pWL093vD3VGBihielJk17A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PvbpjW0TOmwxvz53/u+7eeD9XqL38SrSXXpa7NfF0Dgx+y3bqdOrgxrbcLwGsf0RN03jn1mGOk11VVXN2RUmdypcZDOKoAVfae+KtQPZ3FVU5wNcZyxpLYC31pj22yd+w2JeI+zcakgcgDlnY1TDaaTgKuRBXwk4WNr/h+NZArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mNKaF6Zr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so3800920e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 19:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712543646; x=1713148446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOQRjwUPOwicZ0FyUJunEbCwB+UEOoMXhllX9eZKJIk=;
        b=mNKaF6ZrERO6/CVbcH/R3uiFJSMtt/7wKgnMyYCYLVTED1DAlxuWGh7BsRMRh+WQMH
         mwQVd/2P7ViqZyreJ9wLtA4z+zpIe50hs/Zd15WDCb9vAY5xI9Z3e9ORLrEBNFCJPx5L
         ZKW0aEmgi/vuixlVXUDkfBJK9AYEQOJJ5H9Tchczp+fdOjtPO8My7YcvfAX8+LSlti6a
         S3ZnvkkQNWZw8UzttCn9syMO9FWDdMQG/ZIloxqCQhCZjbqyRcHw+bUJMTcTrdwLlUI7
         FiUSQaTo0n5p9PnivZcbiL9u7+RA26bt3SGJypbllOuHTgL7xJNIHViAvoZeVJBhyGlN
         BWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712543646; x=1713148446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOQRjwUPOwicZ0FyUJunEbCwB+UEOoMXhllX9eZKJIk=;
        b=M/C67Ah9ireInJ4X1vPshQ41iZ4dEGwkBuhGNeKY6vSg91nP28yi5Rl5U7bpGbakHU
         vcMnJ6BjhW9DyadFDnTGAEgri+EaO4kaS5Fgf9/pxHHeNAWwa+NFu5WeLPlo22EvhOus
         RBalzABapFjTA1S77Pa9qB+gC7v4GGj6/UFm/dHctqhuPbQ0xTk2+Z3VnhNLp09RvYSJ
         I0qgPOhTV0v0AnhMPmgn7ygP47db3mjk9BN9JKdBh/dFaWRzDXl4wsd1Gvu4rKXA7JMP
         vdYgFviu2E9hnAIlM1VAmclky24kQ50aldbMQlsNf8V/K7+2Sg+5tpIlSrLJfOr/AEbb
         IOcg==
X-Forwarded-Encrypted: i=1; AJvYcCWaTHx+gsxWm5KVnI9kWhuPttlzS5hvgtat1EuD/fIYIy09tMSfS0XbViEIb8A/7VomWtPwjCDGlRD1mFgj/8hvi2lhg7FLvHwlOMkV
X-Gm-Message-State: AOJu0YxNFytDEy1sK6ZKtDud90ejKE93GVcMB8fooN9SsXNjfwIfHoFR
	mkdFaGDGnW5TAe5tyDjLaX1hQzMoWmRAVkgezpT9mQFIrTZWhIhN7HLqW424JCU=
X-Google-Smtp-Source: AGHT+IFexGeujw2xySafJEALUtJFhuHD9mbM/LVhsMZyeJxf6SXifslWTitrl17b7gKaEOm7fSYyEA==
X-Received: by 2002:a19:ca48:0:b0:516:ce3b:4aa8 with SMTP id h8-20020a19ca48000000b00516ce3b4aa8mr4789695lfj.41.1712543645857;
        Sun, 07 Apr 2024 19:34:05 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h5-20020a0565123c8500b00516d58590e1sm943673lfv.250.2024.04.07.19.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 19:34:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 08 Apr 2024 05:34:00 +0300
Subject: [PATCH 2/4] arm64: dts: qcom: sm8450-hdk: add USB-C orientation
 GPIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-hdk-orientation-gpios-v1-2-8064ba43e52a@linaro.org>
References: <20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org>
In-Reply-To: <20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=788;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=MrRma8bXJiIflCVU3n2w+pWL093vD3VGBihielJk17A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmE1ebVUPTM/qrJcEnKVcK7dmMg3XBbCwgGYxNQ
 K+YZSB3/liJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhNXmwAKCRCLPIo+Aiko
 1fb0CACY6XXZpIh4YOUl2dHANUksH9R1aq+VPEhof9Pks6S6tataARPDjm5Bhbq968WiDTzqus5
 Rr+h8nxWPFXjyxT+1Bm4xC1udpWw/rBQ3sPyTs6XZkIPkVpCamxPII6bbJqZZkAZgQfvGfDTb30
 2GOM9i+F+D6EIbtTVb2mqP5k8pRan6rTJkeuEBqxc88Gqx7Ec41v5vycu3z91nytJTfsvhxBiWn
 ne5PmefBuOMbAn6DM5HdcvvRVwPS39zFJw0Q+TyCOlJjXvG9DERXJxIXeZll1Mr7AhJKvgTu/Qg
 zvkDhSGV/FzJBtBCCBz6TJPsFuOsitrRWsekidUQHlVH+Trx
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Define the USB-C orientation GPIO so that the USB-C port orientation is
known without having to resort to the altmode notifications.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 0786cff07b89..3be46b56c723 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -95,6 +95,7 @@ pmic-glink {
 		compatible = "qcom,sm8450-pmic-glink", "qcom,pmic-glink";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		orientation-gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
 
 		connector@0 {
 			compatible = "usb-c-connector";

-- 
2.39.2


