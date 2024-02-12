Return-Path: <linux-kernel+bounces-61610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B585143E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9A51C214E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5EE3BB3E;
	Mon, 12 Feb 2024 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3UUm0NV"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D53BB36
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743432; cv=none; b=aVThadAQ+J6+JC3nwCouEk4DCffBYscqQ6IhKIsbcWz2HbJQPCogCVbGAVbeRjyvuuzz3neQXvcp+bvB+FdROFhhC9DBYJktFSQekJQFVaI6GzQDyfHm7tCdeLeTaZZDDfqgwa+KLMzdikQO5XbFFH0+yP7gs/t3/aDWKYYFD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743432; c=relaxed/simple;
	bh=BYxMMgnfl6Vo3FvICtt90++r+JIBRmHZBJczJMyhSwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jI0syOGeJZY4V/kgRGDUqBv1bWnmEPUnufJc38n3CpwScl1etdg0OzCeq59RElqAZYlpzHxhmlq4qfLozykr8iiRNkaVjm5h2BWNBl3GyvO6Q6UV7SCNfXpykHOhpJJn8yMI4raBc2DgFBhH6WjaoO+5U9INabbIjMNwBb7efsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y3UUm0NV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-511898b6c9eso1170670e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707743429; x=1708348229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqViFHK+D1LRqA6EZxzjCFX8jqipAbwRXLuah7Y53vo=;
        b=Y3UUm0NV/E/BOnK+SRca4LJF0GYF0PMaqlMLUStHYirbdEbOUau88XjdRHlyAXtvMA
         cPWqhfbUR5SvivuVYqjnPNQggdLkgwfvPamSszoEQWN9IB2bY/8N1PPetJXXxFGMAE29
         JTWsMs1X3ip1aukRG4Ul5tE38snL8IEQxgzWsgOXyr6qrMiSZDc0ngFgA8WpN/NsGIZv
         1e4MbUd9pHB+LesVguk6Uf1ruzMuidBbyVzM/avTemQVO/sU40lYqINLjnfKEYG/7npk
         OYZmEbnBKeDGsNCvlPzwuY+9JdbdB8OnC831xHyu7BgPC4aAnXCSQ82ADbsd2kTHV2De
         Ek0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743429; x=1708348229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqViFHK+D1LRqA6EZxzjCFX8jqipAbwRXLuah7Y53vo=;
        b=Q5V6voE7Rqg1jlHp8u5oz47TEGrCBVkpslsKdtSfs5VgiFcU3fIqBZ36tgziJfrKhW
         u+woRwid9FT7MqXeJvu7ubP4I/Zq6d1wx9zM1oZVm6x2cDH9Ol8E5OA2E33AVhc0kTf3
         xMlX7dw8qkAs+OY2JcvIlDFNBkr0mJ4JhfNg2KzuBRSdwI2NlTeNqvleF2HzZpxWIbtG
         RPnGAkouXBSouI+PHkjbAd34Bv8DIp+wJTRuznnhqw8LDtCg7k/NF9eEamBTA/r1QT8z
         krHq7WKj+BbSJsQq2Vzsj6sbrD31K7gCH5gyNgD7JLbof9yjo571aSf7SqYaMAgMeqWP
         x72w==
X-Gm-Message-State: AOJu0Yy3SSZCcdePrgvCDzp8jUQgYOAcOrNnsgIFPsDCHd56+k917Vte
	HdXFtwnnyYy0aZrL0BGVVwCzgtdINKJZxXABEZv/0bJVeTnrv5GEmSu2KeHGvVE=
X-Google-Smtp-Source: AGHT+IEIjIjw+diayxYIeTsT9G192l7yKdFJ/iVb+VW8lcuPZDuHCAr/3pX7O0bpKKbpqT9hdsHqsA==
X-Received: by 2002:ac2:518d:0:b0:511:694b:245a with SMTP id u13-20020ac2518d000000b00511694b245amr3856676lfi.58.1707743429537;
        Mon, 12 Feb 2024 05:10:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFrtR0Ppr2O4QZdyJXB7qGZICmVbwC7Rsf94s77wQdlGqR8ZRG3VjABkpzDKHbyAGrmol358V47jw7xw1GrngmiOx37dS5qi0CzfblGgee8jP1nWKP+/u2YsUZQEf88oWgsbOyjff2sbWyiz1Xdi0a/Z7odfUDOTMHB7rKjF56EnVW+4P0H+1uG2YK8jd8d/VQBsHFiMQ0ccvFy2JDynLKZMvR15VLFqVBl7meiEg/14OKvof3W3krdpPnJJzGsg+6ynQPo8PMxeGOZDEOKiJlhtkpaw5/u0FCzXkTp6Q2mcax3d9YgoztvEecSG93je24junf8RG9B8MDWlvvyHkOHfSr4/BjKMyT5MYKWbVf1YA3c7rkHMuIMHHF4ZVQ2UAqesgLiM7zZafZvOFdk7fWIGK6UtfJzjOK0om36TNk5WAKUH5jFk5oMQoPp/xSATSQ0l09H3o0Xjfxta0bBaD/ZI1pjKShYMq8/dUx5FLTVwtBrdbTISj0gvl0j+EofmTZ+eZwfZ/TIMfv4RwpfpdQs1C/R1iuQI+Q1j4sgjh0GNRviJv9q7eEMmHH0wA54AkgCaDcVfz1osiMvlsJLDWBJgUvMU63rm8ILcOys5zQMynWE3QObjj68b9bfVmmG8LE+CdS1mN7YEhCGPPe3dZrCuAW17uzy27QWgN5uLNLEWh3Hv/Sry5+FCaujwCnThMZqHy6QfmTH+lSrGr12ebcldRBaqxfd852DH9yfT03qsR80BSYP8HOtLawYXGHo18++xqsal+56RSzakx1IKJ7UPwkhaSrnQGz8l1PI/5kNNBKDdbOx8F16oCDysBL/Qae2yboFy3o8Ag/G0ag0oCc9134
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id gz9-20020a170906f2c900b00a3515b35be4sm193052ejb.104.2024.02.12.05.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:10:29 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 12 Feb 2024 14:10:13 +0100
Subject: [PATCH 5/7] arm64: dts: qcom: sm8550: Add missing DWC3 quirks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-topic-1v-v1-5-fda0db38e29b@linaro.org>
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
In-Reply-To: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>, 
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707743413; l=1404;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BYxMMgnfl6Vo3FvICtt90++r+JIBRmHZBJczJMyhSwk=;
 b=BVfXqO9pGrNZlcLW0yoUdDXyI3lwhL79E0y5sKgoORe9P1VUu8jT9h9S437tWRb7sucOC99Un
 AjovaL1EEYHB/X+0xku+/Crr4sQF+pNyJPi2ZtBEhDgXAfmCPQHRuRd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

As expected, Qualcomm DWC3 implementation come with a sizable number
of quirks. Make sure to account for all of them.

Fixes: 7f7e5c1b037f ("arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 868d48b85555..925e56317fb0 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3193,12 +3193,20 @@ usb_1_dwc3: usb@a600000 {
 				reg = <0x0 0x0a600000 0x0 0xcd00>;
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&apps_smmu 0x40 0x0>;
-				snps,dis_u2_susphy_quirk;
-				snps,dis_enblslpm_quirk;
-				snps,usb3_lpm_capable;
 				phys = <&usb_1_hsphy>,
 				       <&usb_dp_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,usb2-gadget-lpm-disable;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				snps,dis-u1-entry-quirk;
+				snps,dis-u2-entry-quirk;
+				snps,is-utmi-l1-suspend;
+				snps,usb3_lpm_capable;
+				snps,usb2-lpm-disable;
+				snps,has-lpm-erratum;
+				tx-fifo-resize;
 
 				ports {
 					#address-cells = <1>;

-- 
2.43.1


