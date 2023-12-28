Return-Path: <linux-kernel+bounces-12671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E081F8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA54B236B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CE98475;
	Thu, 28 Dec 2023 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LICwZNZ+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985E079CF;
	Thu, 28 Dec 2023 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3cfb1568eso49343665ad.1;
        Thu, 28 Dec 2023 05:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703769409; x=1704374209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdxMA0IFnQNSF87xNJWS4MQoHn8cWo2ZJ5T/rZOTLd4=;
        b=LICwZNZ+nOf3lXg54F3hV5fE2iRbdB5vVNY5xDIRg+CwB1NwSlxIozDXrT8BMAcTMo
         0EnT9Zxd6chwRviwffDdA0kXFKqdQJTRCM4SdmqSEDhm3hqIp4zTXx+4hqJe+XvlFySg
         rTd4+/EotHmceEhbg/T4FFFKKfHm6vQovStBoHHB1ZsJW8+iRP0ttQOTy8u3EsMDE8pz
         D7dgJ5kYXvK4y3vOQOHozQkYFDS4WfOaGxkzeNxIywEu4oZ3l+huxFWEgYpP0NmUVMQn
         +gusuD/21XQyolkOU7/9h5ySxiFrc+oUWEzyvce88U2hqcyDxdALq9oSp5kstFQuogyJ
         tj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703769409; x=1704374209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdxMA0IFnQNSF87xNJWS4MQoHn8cWo2ZJ5T/rZOTLd4=;
        b=f3K5K7RjOCn+NZOUxbqGmEQSzBUdZEt1foEOQ0N9Oem05p79cvdzij22Aj8sDJRWM3
         pidvyzRDrIp/FNmBJcD6tnz5q81KX8hQHVe/jYrpf9ywmYDgUelUrlmrrMVl6MjZRR/B
         1qlQIz4jlOMndxu4223P80+5ZqaWEYYwPShy4PdwpNITgclwu/fQyQFbW9aoejMVz2bG
         8vNm1Esa68mYcjF4AG6WaYUPRBj5bPz0MiF+MgiaAdzhPqBRmfuXT8SzhR6AP+bO7+zb
         Atkf/TqCcbMqzOEyqRwI++odQk+hAnhwhaakCBCardPCcJP8TaNYJ0V3nW/pBSDoPmGW
         qpcw==
X-Gm-Message-State: AOJu0YwS5kfP8IoLtHhqKhPVW7TkT/NIfKl3YkkvsYRRgg2o/0WV8iCN
	z6BaXhQtNn8GBGpoCEgBLdc=
X-Google-Smtp-Source: AGHT+IH8H9gke14Hfds3PK61sbjEENzKw+rV/8YgR/y3014PaI2W0cSmtiFb5LSDfFmIPkfRF8gw9w==
X-Received: by 2002:a17:903:44d:b0:1d0:8554:5dd5 with SMTP id iw13-20020a170903044d00b001d085545dd5mr10136244plb.37.1703769408774;
        Thu, 28 Dec 2023 05:16:48 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:3708:559:ea20:9883])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001d0b4693539sm13864221plx.189.2023.12.28.05.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 05:16:48 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sfr@canb.auug.org.au
Cc: liujianfeng1994@gmail.com,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] Add hantro g1 video decoder support for RK3588
Date: Thu, 28 Dec 2023 21:16:14 +0800
Message-Id: <20231228131617.3411561-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the v2 version of this series adding hantro g1 video decoder
support for rk3588.

Changes in v2:
- Fix alphabetical order in patch1 and patch3
- Sort device tree node by bus-address
- Drop rk3588_vpu_variant fron v1 because that is exactly the same as rk3568_vpu_variant
- Link to v1: https://lore.kernel.org/all/20231227173911.3295410-1-liujianfeng1994@gmail.com

Jianfeng Liu (3):
  media: verisilicon: Add support for Hantro G1 on RK3588
  arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
  dt-bindings: media: rockchip-vpu: Add RK3588 compatible

 .../bindings/media/rockchip-vpu.yaml          |  1 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 20 +++++++++++++++++++
 .../media/platform/verisilicon/hantro_drv.c   |  1 +
 3 files changed, 22 insertions(+)

-- 
2.34.1


