Return-Path: <linux-kernel+bounces-112402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1359887955
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED3A1C20BEB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08FC4DA05;
	Sat, 23 Mar 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOBwvQY1"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6145BE6;
	Sat, 23 Mar 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711210182; cv=none; b=OsI9nRbCtbUkaSD/Yib3AlFPU+TsiplxADbn4/9JKSMSYwpekS6mQH3mE3O9kS36lPOlyov+Tk/k3Cl/GkZUzwLpi7uPkw0Mt/6CqiFwNhTw7gGAl9MCVYHLkpQf7f3H4Qa+MiIU8dtzJijKXxKUBDy/gy7K7o/wyypM9rNopjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711210182; c=relaxed/simple;
	bh=uotAOhcliSJrtYGXeo+exsDcCUCxgu+573x2YVcdnp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Igzk9Z1uJoeXMcVABDmZjCnpS6X/3qjmN5tkl0QhaBP0AASYaJdH5xMoZzWz9r+wYWqhbk4eTVj8nwHHaplS4HHRy48BE8SWiEQIwcC17FqeRepXid8oWrfa/5IbxFpaEWfBPe96DKRQZ2WOsuVygJxfgsNA+n/bN3tPeJTG1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOBwvQY1; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a4f608432bso1756315eaf.2;
        Sat, 23 Mar 2024 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711210180; x=1711814980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfWnKi3XkBpJ+D0PBN2uriZjmLLr+s0y6bK0oDzXkOQ=;
        b=FOBwvQY1YaKgVqgbMCGB4qMDVDhOVqLd9lwqegcToPJkZ4630SkPc7BNaXlrNBiHRt
         79Chrh6506EXR66/n6oPbsMZLbrjLuyDbg8mEYAINjPq1nbflQzkGynfBnxWLolH/KqF
         o5diC2eWEjxH0qINSnpbEzQWZVXgDeWDzPOXHRdSaiOgpMScbQNd3Y3tClWL3keqd6OY
         rYccrtjwQVL3Bq+EzqB/fcmL7/dBWGPQBokTDrRpVG5d5FYtJyDj0cWq6BwqwfuRoola
         3ZZZU0qW5+LbQf7AJUCL53s/LaoB6JmCsvLZsNuH8RR030Qzhfgv/EwhI6ZdHE7MEf3W
         35fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711210180; x=1711814980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfWnKi3XkBpJ+D0PBN2uriZjmLLr+s0y6bK0oDzXkOQ=;
        b=T6wB/c36oW2G385l2SC2f8Zzkdngpsdvolx8Vpeolqbk51uio1VYBdvx0Nb1HI16UE
         3v0j4GCROHUM6i4Y/qELlF0JBA2gPNl3v54baxtiV1N8xm56N5zO2F9cuXrd0ktIJtxx
         18NIZjLj1n60OKtyrWZCMyencTXqSPV9llqiGdXHpj8zuWjzY1/D67maArfKMO2TYrhk
         d68BaxHEzemDJKFi+mqeDUDDIImSkM6jwstLeZVt+O4QWAIzLytIeEYFfvC1OeqTHiR9
         JaZuezuO382eB9dp2fUG12GdZxvH6TphetAz/aEXdK8F+P/gUZRp6yL3WKvDnph36ePS
         BdzA==
X-Forwarded-Encrypted: i=1; AJvYcCVuTB7HC6Ut+vJOp85ykCL9jIcfiwWNQl5kE6qP5ea3qGdCORZ16iAh33HsYt317Qdr32Gr+f8kvCK6VcbBcXH+10afJtljFtymzdN/SCLBHOHUxQ3V72MYsHDpTihBbesdDTSrHfozMAw=
X-Gm-Message-State: AOJu0YzGrCKm6kDd3hFLGqwgvYHTc7eFuR5oLObO4oJApXh9X3/IEJAy
	FAAoC4poHSTS+AYsQtTq3ZyGjy2X+W2poPAp5z470bwn7UISrzaN
X-Google-Smtp-Source: AGHT+IHnKICd6eQ08MBl3qIuOW5vkmBdfwH82arK41ExW8LxM20/g1/q+5+V7DKA43ltBe1KzY3x/Q==
X-Received: by 2002:a05:6820:3087:b0:5a1:d2ad:ee36 with SMTP id eu7-20020a056820308700b005a1d2adee36mr2603709oob.7.1711210179916;
        Sat, 23 Mar 2024 09:09:39 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id a4-20020a4aae44000000b005a4b2172e48sm738541oon.41.2024.03.23.09.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 09:09:38 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	robert.marko@sartura.hr,
	ansuelsmth@gmail.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq9574: add MDIO bus
Date: Sat, 23 Mar 2024 11:09:35 -0500
Message-Id: <20240323160935.2848095-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240323160935.2848095-1-mr.nuke.me@gmail.com>
References: <20240323160935.2848095-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPQ95xx uses an IPQ4019 compatible MDIO controller that is already
supported. Add a DT node to expose it.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7f2e5cbf3bbb..4ab9da9fffb6 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -232,6 +232,16 @@ rng: rng@e3000 {
 			clock-names = "core";
 		};
 
+		mdio: mdio@90000 {
+			compatible =  "qcom,ipq9574-mdio", "qcom,ipq4019-mdio";
+			reg = <0x90000 0x64>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&gcc GCC_MDIO_AHB_CLK>;
+			clock-names = "gcc_mdio_ahb_clk";
+			status = "disabled";
+		};
+
 		qfprom: efuse@a4000 {
 			compatible = "qcom,ipq9574-qfprom", "qcom,qfprom";
 			reg = <0x000a4000 0x5a1>;
-- 
2.40.1


