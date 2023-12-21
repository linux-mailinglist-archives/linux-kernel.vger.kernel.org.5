Return-Path: <linux-kernel+bounces-8179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8090F81B336
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08504B235D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194644F202;
	Thu, 21 Dec 2023 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkLwMoSf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D851C20;
	Thu, 21 Dec 2023 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e4a637958so816990e87.2;
        Thu, 21 Dec 2023 02:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703153433; x=1703758233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0fIP+gY5tjmlfd94qvCRw5zI94zpMLdzYlGd9t55ptY=;
        b=XkLwMoSfHkvLqxfIQH+N2dSVg4fWT/urJyeD5R3AGVdmvzQSydOr16oGx5Pb2je7Uc
         +BFtkLnIeqQqnxjC4Uf+ORYJ/8F0pqb4tN1LTqpL/libaSHzIfZYUyvNao85Xt+JXIU0
         B11QMUeIx2wPEezBgI2jOKZRonzbVjskaE5j8DsTHSQssr7V/MSx7eAO9YIDR4H35CCU
         DZ8crzxmpudPpLBqAG/QUNTTc0biVRGahZPhDi9NY8L4gRMDokRH/Kf2USmHy6s1BSfw
         UgD7pZEuEDztz9A0GQfLy57SW6+jFo1Z8LG19qKWpANJyA1LmpFIID28QGr2xpdjlR8Y
         luvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703153433; x=1703758233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fIP+gY5tjmlfd94qvCRw5zI94zpMLdzYlGd9t55ptY=;
        b=dqilKyxLRTpSndEvJXPpHFW+fkUJfhr80hstYutwncRezio6p7XsW8tMtBh21ofBJx
         cVe+le9QFMCgrxtckq+A8HK7xXrSqTGfo/hMvAjdqPUM7fEROIqnyh7FMTfGzGu2RF7R
         r68u+9cELl1+l4xeypLDNZYfyB6lCJTOqxfgSxF4nd4gmY03qX4AYKVdZ8k7akpv/2Xb
         ItAVx4FdgiZEjtPgVLRhAd5fbgCN11wiorv+Eud+UENpuKrO+Rxjl0PMaxddyCXlP+gq
         i9RPbiTflazO5n/mee7J+0VuRPU1E7WMWDEHQ1Yda9YGf4cRxTJ1dsWGpo14n8nuFNxB
         5KOA==
X-Gm-Message-State: AOJu0Yy2FUqagOnPB68XyeBRwKpIGakJ3oesqdcIb16lAU6pc0xT7viu
	fCrP0yZD9XlIAYlS3U7KFIM=
X-Google-Smtp-Source: AGHT+IFtYAcqviJSNW2hlf7hb2pY1nEpa7NDu2xXdMOCQkRzDnF1hONtWet1/ZO/uZRytB3dHQ2T/w==
X-Received: by 2002:a05:6512:402:b0:50e:51e0:732 with SMTP id u2-20020a056512040200b0050e51e00732mr622482lfk.277.1703153432484;
        Thu, 21 Dec 2023 02:10:32 -0800 (PST)
Received: from localhost.localdomain ([154.72.163.204])
        by smtp.gmail.com with ESMTPSA id x7-20020a170906b08700b00a25f5dba09dsm784928ejy.145.2023.12.21.02.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:10:31 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [RFC PATCH v2 0/3] Add support for reading D1 efuse speed bin
Date: Thu, 21 Dec 2023 11:10:10 +0100
Message-Id: <20231221101013.67204-1-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series is an attempt to get feedback on decoding D1 efuse speed bins
in the Sun50i H6 cpufreq driver, and turning the result into a meaningful
value that selects voltage ranges in an OPP table.

I want to make sure I get this right before sending in a v3 of the D1
cpufreq support series here

https://lore.kernel.org/linux-sunxi/20231218110543.64044-1-fusibrandon13@gmail.com/T/#t

which is currently stuck at

https://lore.kernel.org/linux-sunxi/aad8302d-a015-44ee-ad11-1a4c6e00074c@sholland.org/

Changes in v2:
- Make speed bin decoding generic in one patch and add D1 support in a
  separate patch
- Fix OPP voltage ranges to avoid stability issues

Brandon Cheo Fusi (3):
  cpufreq: sun50i: Refactor speed bin decoding
  cpufreq: sun50i: Add support for D1's speed bin decoding
  riscv: dts: allwinner: Fill in OPPs

 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 19 +++-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 89 +++++++++++++++----
 2 files changed, 89 insertions(+), 19 deletions(-)

-- 
2.30.2


