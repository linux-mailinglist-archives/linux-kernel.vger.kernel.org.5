Return-Path: <linux-kernel+bounces-13726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 374C6820BB6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842D5B20C9A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9073279C4;
	Sun, 31 Dec 2023 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjuUB8JT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B16610A;
	Sun, 31 Dec 2023 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d408d0bb87so58471715ad.0;
        Sun, 31 Dec 2023 07:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704035542; x=1704640342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jeYeBXSxdMTougCaSNrlMRCUw3h8MjaQqsA3L1UWeJM=;
        b=QjuUB8JTqqseCZf1N/u7lIAnm8XbnAD8fmkv5Up9/lN7D2C5PRmxEvRM3eHrISEbpt
         UYWEg0zCA7zgZWzam5IHFnkvU9Lx3UU13KHE60HFmf9aSfSHG1sI43Ajq8TLYx9YkP94
         Rl0OvYZ4Tgc2vYIem144oitV6j5Q7PA/Ml7BPts0AzypmCI4Q1MPAiPPH0+RLJqs1isu
         gDlRlf2HH537P8SOVhAOv3rxL2vADZV6fNSntOX0VtTUOKuMecxFD0QYcBVaMLDn3eKx
         F0vZfZWaN2rcixs5vpYFl+Q7sgo5ll2uZFtvms3V46uCcjZbk6fxlVsZWcL2NA0EusYT
         mauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704035542; x=1704640342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeYeBXSxdMTougCaSNrlMRCUw3h8MjaQqsA3L1UWeJM=;
        b=vU+GC4aSA0Al5t5EibRTSOLfEI3sYh7VcXuXRLx1bFgghBZ1WOCh19siAa6NiR5pJ4
         50gTEcO/tpNW67yGtwNIdmJEwEDa5MsH3rPuF10Az2tOiunDqiQvYY1RTfthD4mLlxWo
         S4hSd1g29W9ahD99rv4d4ojh3kLI7FnlFFLymCPRmB1ucuB4I5YmG1uqC2WcP+KQBarX
         hXzT9j3YlzrDvWy2e4RmFtZBtgmUqgnnAIC62U9yGHpV9zv4b6UFnHx3Rm7aA5rPPb2N
         6hjD85RDiT4rwlTDozkaNJQ+0yIa/HqZbrNXSV4YBLIvMH0CU4NI2Tk75gvVcTw/8r+a
         QO/w==
X-Gm-Message-State: AOJu0YyyJNju0JOLu6OzT9RJmsgBRGSSyB5vSA+UmopQTIEZXPqaLqJT
	5Nx0bEM0r/1tDUhZnN+1Ix+SPI9JImwd6CzL
X-Google-Smtp-Source: AGHT+IFYiCNMbl3dZt18tBdXWUUj2YyulwcA8ZtzasbEmO897ubaYYezbzhFB6TThhQZw069VWyoEQ==
X-Received: by 2002:a17:902:e5c7:b0:1d4:35d6:f999 with SMTP id u7-20020a170902e5c700b001d435d6f999mr16284099plf.139.1704035541802;
        Sun, 31 Dec 2023 07:12:21 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:2643:6273:f90:f77e])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001d058ad8770sm18775011plh.306.2023.12.31.07.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 07:12:21 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: sfr@canb.auug.org.au,
	liujianfeng1994@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	sigmaris@gmail.com,
	knaerzche@gmail.com
Subject: [PATCH v3 0/2] [v3]Add hantro g1 video decoder support for RK3588
Date: Sun, 31 Dec 2023 23:11:10 +0800
Message-Id: <20231231151112.3994194-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the v3 version of this series adding hantro g1 video decoder
support for rk3588.

RK3588 has Hantro G1 video decoder known as VDPU121 in TRM of RK3588 which
is capable to decode MPEG2/H.264/VP8 up to 1920x1088. This vpu ip is also
found in RK3568.

Test results from fluster can be found from thread of v2[1][2].

[1] https://lore.kernel.org/all/CAAXNxMT3f68-ptM7Crhrfmn7iwTyJc9pwz4Beob+5beVODaSHQ@mail.gmail.com
[2] https://lore.kernel.org/all/20231230153159.3748580-1-liujianfeng1994@gmail.com


Changes in v3:
 - Drop code in hantro_drv.c because hantro g1 vpu in rk3588 is compatible
with the one in rk3568, only adding devicetree node should work.
 - Change devicetree node name to video-codec@fdb50000 to match the reg
address.
 - Add dt-bindings rockchip,rk3588-vpu compatible with rockchip,rk3568-vpu
 - Link to v2: https://lore.kernel.org/all/20231228131617.3411561-1-liujianfeng1994@gmail.com

Jianfeng Liu (2):
  arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
  dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible string

 .../bindings/media/rockchip-vpu.yaml          |  3 +++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 20 +++++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
2.34.1


