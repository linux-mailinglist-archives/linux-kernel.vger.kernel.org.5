Return-Path: <linux-kernel+bounces-87351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF91E86D328
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C21F24AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD2144032;
	Thu, 29 Feb 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxOoM3rj"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D4134439;
	Thu, 29 Feb 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234839; cv=none; b=nbdnCaesx2oz8TJ8I36qYAQiv/Tj5x1RCTThatYAffLnKmJ9ujrLHQICBAPfdOl9v+YMeMvdQ46v4kEt/vqWqyDym9JeggwtksVG6MZ9aoCmpZapTQFjH4vmJzh6ymY2W2KQYzUu223hvCohUebxrhsORdV5EFMFglT0F/GPpH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234839; c=relaxed/simple;
	bh=j/++tKpf6nxbbeFDehv27/TaZ3F22dBnSGotJt3JR3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4Nbu9a6/sE8yJtpXz4g9e7mA+p1GeIpgglh/d7ZP8CHwNxSsBMXiJPM8quyh0dpxKpqNMoVGstNndoZL+KqqavQOBvHi5yEPgr9xiPH/NQ1bd4MY8XC9umZRmBA3Wp52Eq58Y9xKpQP1OEihq1bDTR9xqwMBsPjhA2dJopHx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxOoM3rj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5131f3fc695so1422080e87.1;
        Thu, 29 Feb 2024 11:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709234835; x=1709839635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8pIF69B3+vCEfVyDdwwj/eV/I9z+Zc+q5b1+o/fwOY=;
        b=kxOoM3rj/xS/fbDya+rqT0znIP7DFgHONclcmXDRnESRzRjUS5tJxWYFKJHyctGj2z
         56Xkjz2rw6JD45h/Ztutw3amTpLnp6iMH2pycKbkvCTY+weEwb4aniGixOD4gN7JIw1F
         sag1AlhHMBQ088klrI+1V9l8mE/URseKYxeHTbuZ6kLQUm9psCntIvOIw2V58/to/TmI
         mCMCxzNm8ocH4awtkuD5hsgjAqOLVJaYHxWgwnuaZc1E4iL8nviMsP7rzKEpVhnJj992
         Ik/VJeoAIcF05ERoWo5FTuF7je/YzrJ++Sk/N/4V/IhSrymWfuAsvuuh1zRawcXnBJWI
         l+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234835; x=1709839635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8pIF69B3+vCEfVyDdwwj/eV/I9z+Zc+q5b1+o/fwOY=;
        b=baFJYat2c3GhDz6IZQq2gCuuNZ7ulrrUUS5yNOfm+NkU/ltrKMrUk4OQpfntEyuBAK
         vuSJQ59AMMR+Gupo0SUqYWhb+RJzfevka/R7JK9U9gjIOSbxc85qjhCw9LQDfvvvwSu6
         +ZWgIKOwpO4oLrxENplhsHjAlXs1H3DoQYeHc6QouVmQNkmo9G+DWK5tXSlPhR8K0q44
         4pioS+z25QqbSTGrWzdItgLwiwJLGVs2wS+HR7wlsA45lOzJJoINU+6t790IdCGXHitS
         e3dBo2pVp4LX8kZKwG8ZQkGDIxYUcpQSLAZACXmyz6fJynMOLbAohQLfZVNJrdwKwo0L
         F5HA==
X-Forwarded-Encrypted: i=1; AJvYcCULX71Xni1JKUOFd8vFeu8oJeZ8px5RYaQQL2DtlbWMw9fMqK0Jt8Ov7bZy//FuE0s8miIygZIwzsK/5XLBJ6nYCjrZY4ilTD3mTu7AWm9D4ZPb4C9IOl4ZghNiXDQfsMHSrvKLFcD0RQ==
X-Gm-Message-State: AOJu0YzXwCAkH3pjk0fEmRMpjSKV16X6k3qUCj5U1Hq14ncy/pnVZbd1
	M9TgN7IGolHrCYDYAg1pDDEFFT6VX2O73Yhj68k37AgM01hB4I26w9SSBHidKJIPOQ==
X-Google-Smtp-Source: AGHT+IFdEd2RYXTkQHnppetkRnPxVnjNwWo7EOTHuMMvCLx724tUqzZ30NaYb3Avu9qRLku1FgXVlg==
X-Received: by 2002:a19:f80c:0:b0:513:fad:3a79 with SMTP id a12-20020a19f80c000000b005130fad3a79mr2169278lff.41.1709234835537;
        Thu, 29 Feb 2024 11:27:15 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:6ebc::d35])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b00412bca49a5bsm2853944wms.42.2024.02.29.11.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:27:15 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 29 Feb 2024 23:26:36 +0400
Subject: [PATCH v3 5/5] arm64: dts: rockchip: Add further granularity in
 RK3588 CPU OPPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-rk-dts-additions-v3-5-6afe8473a631@gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
In-Reply-To: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709234816; l=5519;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=j/++tKpf6nxbbeFDehv27/TaZ3F22dBnSGotJt3JR3A=;
 b=tzN5fmgoHAnEdXpez23vQkmx1XeBtubWfNRVPi+kjuzKwBQ26lA/DVX4u4pp+xiQzv6TShJfT
 nXrscsS74dmC2+s4BeMzPAbU4r8/Gbj+Zb4sS4yUglJHYPXwx79momW
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This introduces additional OPPs that share the same voltage as
another OPP already present in the .dtsi but with lower frequency.

The idea is to try and limit system throughput more gradually upon
reaching the throttling condition for workloads that are close to
sustainable power already, thus avoiding needless performance loss.

My limited synthetic benchmarking [1] showed around 3.8% performance
benefit when these are in place, other things equal (not meant to
be comprehensive). Though dmesg complains about these OPPs being
'inefficient':

[    9.009561] cpu cpu0: EM: OPP:816000 is inefficient
[    9.009580] cpu cpu0: EM: OPP:600000 is inefficient
[    9.009591] cpu cpu0: EM: OPP:408000 is inefficient
[    9.011370] cpu cpu4: EM: OPP:2352000 is inefficient
[    9.011379] cpu cpu4: EM: OPP:2304000 is inefficient
[    9.011384] cpu cpu4: EM: OPP:2256000 is inefficient
[    9.011389] cpu cpu4: EM: OPP:600000 is inefficient
[    9.011393] cpu cpu4: EM: OPP:408000 is inefficient
[    9.012978] cpu cpu6: EM: OPP:2352000 is inefficient
[    9.012987] cpu cpu6: EM: OPP:2304000 is inefficient
[    9.012992] cpu cpu6: EM: OPP:2256000 is inefficient
[    9.012996] cpu cpu6: EM: OPP:600000 is inefficient
[    9.013000] cpu cpu6: EM: OPP:408000 is inefficient

[1] https://lore.kernel.org/linux-rockchip/CABjd4YxqarUCbZ-a2XLe3TWJ-qjphGkyq=wDnctnEhdoSdPPpw@mail.gmail.com/T/#me92aa0ee25e6eeb1d1501ce85f5af4e58b3b13c5

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 87 +++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index bd39c5c47bfb..6b4ecc7ab37d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -360,6 +360,21 @@ cluster0_opp_table: opp-table-cluster0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <675000 675000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <675000 675000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <675000 675000 950000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <675000 675000 950000>;
@@ -392,6 +407,27 @@ cluster1_opp_table: opp-table-cluster1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <675000 675000 1000000>;
@@ -422,6 +458,21 @@ opp-2208000000 {
 			opp-microvolt = <987500 987500 1000000>;
 			clock-latency-ns = <40000>;
 		};
+		opp-2256000000 {
+			opp-hz = /bits/ 64 <2256000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2304000000 {
+			opp-hz = /bits/ 64 <2304000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2352000000 {
+			opp-hz = /bits/ 64 <2352000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-2400000000 {
 			opp-hz = /bits/ 64 <2400000000>;
 			opp-microvolt = <1000000 1000000 1000000>;
@@ -433,6 +484,27 @@ cluster2_opp_table: opp-table-cluster2 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <675000 675000 1000000>;
@@ -463,6 +535,21 @@ opp-2208000000 {
 			opp-microvolt = <987500 987500 1000000>;
 			clock-latency-ns = <40000>;
 		};
+		opp-2256000000 {
+			opp-hz = /bits/ 64 <2256000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2304000000 {
+			opp-hz = /bits/ 64 <2304000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2352000000 {
+			opp-hz = /bits/ 64 <2352000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-2400000000 {
 			opp-hz = /bits/ 64 <2400000000>;
 			opp-microvolt = <1000000 1000000 1000000>;

-- 
2.44.0


