Return-Path: <linux-kernel+bounces-61650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D81888514F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F98BB21F04
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF25E4DA02;
	Mon, 12 Feb 2024 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRqmHLtg"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B04D5B5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743682; cv=none; b=Ybj5KpJab+92QXCywpZmQwc2Io63Z4AOfEsm68wwzclPtgIg5sW0HTNbueeYw9GcZ8wYZ0WH9O3//bn7bn/1cO/KsJSde9BMp6xhM6hB7ruN0XX8zFoahaatin2Icu1VSu79RD/JrjivDYOEi1F34G/JEt0NmY0imDHoX+x8GGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743682; c=relaxed/simple;
	bh=gcqzXqPvCid0bdGkdQCOqBvfMk4/JJEe5ZxnNjAwSB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hpbZjnYWMBojf4j3wptazLNT7eQ55iA/h32A5R+u2Zb4G361rHmgwxHdENxCK80tV3uejiIOZVtWlQMNQ8Cwor4WmGg1kmGJjq6aeCXzUzZb0zpKzdnYOXftuNxaT7TyR1YFVh9JuI5vzWRz+UuOxSDzTXFsJyAS0jTW4B61WT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jRqmHLtg; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-337bf78ef28so1119834f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707743678; x=1708348478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oX2+cr2GJmybLTxSkR2z2RsI+0zR7H0TC6zqB4mg2qY=;
        b=jRqmHLtg7k4CXJvCxsRaBZ0K5UWhwRRGzTE7xsjyWHSWN3Xr/T2M9uxJ3/SGl2zrS5
         QkVlOeaKv7TrrkDA+O1PJ17mEOX85b2ZZAcLnKkJqLVhfBXeFYmD0DvXUr77rs76oK8l
         WQNDu/67fg3/36L2ZlFGOxvoAaa+4npg2sZm1Zynkaisr/H/WouGMdMiSllVBfuyB8Hf
         qeF4bAMzi53gOEvEDYngOrgQ7Te55ZyrNgWfhbwSoqRTs965FLqMkBFFuPtH5xrKIPi7
         avkBKr0a+Yu9J7pRcrJl7j0L097/rw2hnhmON1PdHdBkz4BJrOFlSsmJkAGannDM2dWi
         QLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743678; x=1708348478;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oX2+cr2GJmybLTxSkR2z2RsI+0zR7H0TC6zqB4mg2qY=;
        b=Ts0RtbEbzSFF1gf0s2LjTPqUDe3+W8NZ/Di4mXnB1FdvvT9LOw/OWpEgugrGUaEpom
         hpHv/8zClNiv77uavRnb8yBUJlmal7aTckpugQe5ZqMAlAQPvGqkCKpGY83q8LMj5e7H
         tVDs2u3h9HByu3cOPjV99j5pYZKm4jDGmUzqkNxs7HSQzl5onC1J8QfajhB7TEdwOLYW
         q/vP5p1++3Oeqp67vpi0I3nw4mSRwONUHK2oBqZNPl7GcBfWSH/u6rjTHj8NPR0B0PIo
         pxH84OKZz45BizVAh9gv1rpHGGTF4WNuQYsgBFAsP/MdjtwiPiCkW/5fNE2gtJHi9qv1
         mtTg==
X-Forwarded-Encrypted: i=1; AJvYcCWSP8Acag2tQZtPJwkPwzLziJCvKNHp/d9lSpJ/SeBNGqcGP5yzXDz6NLk/V6T4FddQNJE9Elhcx2ELvUhzsIo819kj+32yCupSrmJG
X-Gm-Message-State: AOJu0YwANUBkFAaI9DxRSMTmyirkJC6/YXC3LKoWLvj5KITQgkSSzUOY
	569x/A8f8HOEkgd+S2gZ/NUtmzggq+vyr0PgUh5BweavhgFPhwD2neAkCtBrA3xtt/pP4KelEcB
	hjybTnAePFg==
X-Google-Smtp-Source: AGHT+IFkFcklODkA+IZce15OW7imyMehYzYa0bp9Q+4UUqUKMp1QHbHOQZVoAphFa93JEGMlAaRIokbaJqszdw==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:6000:1751:b0:33b:8f6:2a77 with SMTP
 id m17-20020a056000175100b0033b08f62a77mr15650wrf.2.1707743677947; Mon, 12
 Feb 2024 05:14:37 -0800 (PST)
Date: Mon, 12 Feb 2024 13:13:23 +0000
In-Reply-To: <20240212131323.2162161-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212131323.2162161-1-panikiel@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212131323.2162161-10-panikiel@google.com>
Subject: [PATCH 9/9] ARM: dts: chameleonv3: Add video device nodes
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add device nodes for the video system present on the Chameleon v3.
It consists of six framebuffers and two Intel Displayport receivers.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 .../socfpga/socfpga_arria10_chameleonv3.dts   | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dt=
s b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
index 422d00cd4c74..9bc0c1672b18 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
@@ -10,6 +10,136 @@ / {
 	compatible =3D "google,chameleon-v3", "enclustra,mercury-aa1",
 		     "altr,socfpga-arria10", "altr,socfpga";
=20
+	soc {
+		fb0: video@c0060500 {
+			compatible =3D "google,chv3-fb";
+			reg =3D <0xc0060500 0x100>,
+			      <0xc0060f20 0x10>;
+			interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			google,legacy-format;
+			google,no-endpoint;
+		};
+
+		fb_mst0: video@c0060600 {
+			compatible =3D "google,chv3-fb";
+			reg =3D <0xc0060600 0x100>,
+			      <0xc0060f30 0x10>;
+			interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+
+			port {
+				fb_mst0_0: endpoint {
+					remote-endpoint =3D <&dprx_mst_0>;
+				};
+			};
+		};
+
+		fb_mst1: video@c0060700 {
+			compatible =3D "google,chv3-fb";
+			reg =3D <0xc0060700 0x100>,
+			      <0xc0060f40 0x10>;
+			interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+
+			port {
+				fb_mst1_0: endpoint {
+					remote-endpoint =3D <&dprx_mst_1>;
+				};
+			};
+		};
+
+		fb_mst2: video@c0060800 {
+			compatible =3D "google,chv3-fb";
+			reg =3D <0xc0060800 0x100>,
+			      <0xc0060f50 0x10>;
+			interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+
+			port {
+				fb_mst2_0: endpoint {
+					remote-endpoint =3D <&dprx_mst_2>;
+				};
+			};
+		};
+
+		fb_mst3: video@c0060900 {
+			compatible =3D "google,chv3-fb";
+			reg =3D <0xc0060900 0x100>,
+			      <0xc0060f60 0x10>;
+			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+
+			port {
+				fb_mst3_0: endpoint {
+					remote-endpoint =3D <&dprx_mst_3>;
+				};
+			};
+		};
+
+		fb_sst: video@c0060a00 {
+			compatible =3D "google,chv3-fb";
+			reg =3D <0xc0060a00 0x100>,
+			      <0xc0060f70 0x10>;
+			interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+
+			port {
+				fb_sst_0: endpoint {
+					remote-endpoint =3D <&dprx_sst_0>;
+				};
+			};
+		};
+
+		dprx_mst: dprx@c0062000 {
+			compatible =3D "intel,dprx";
+			reg =3D <0xc0062000 0x800>,
+			      <0xc0060f80 0x10>;
+			interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			intel,has-mst;
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@0 {
+					reg =3D <0>;
+					dprx_mst_0: endpoint {
+						remote-endpoint =3D <&fb_mst0_0>;
+					};
+				};
+
+				port@1 {
+					reg =3D <1>;
+					dprx_mst_1: endpoint {
+						remote-endpoint =3D <&fb_mst1_0>;
+					};
+				};
+
+				port@2 {
+					reg =3D <2>;
+					dprx_mst_2: endpoint {
+						remote-endpoint =3D <&fb_mst2_0>;
+					};
+				};
+
+				port@3 {
+					reg =3D <3>;
+					dprx_mst_3: endpoint {
+						remote-endpoint =3D <&fb_mst3_0>;
+					};
+				};
+			};
+		};
+
+		dprx_sst: dprx@c0064000 {
+			compatible =3D "intel,dprx";
+			reg =3D <0xc0064000 0x800>,
+			      <0xc0060fe0 0x10>;
+			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+
+			port {
+				dprx_sst_0: endpoint {
+					remote-endpoint =3D <&fb_sst_0>;
+				};
+			};
+		};
+	};
+
 	aliases {
 		serial0 =3D &uart0;
 		i2c0 =3D &i2c0;
--=20
2.43.0.687.g38aa6559b0-goog


