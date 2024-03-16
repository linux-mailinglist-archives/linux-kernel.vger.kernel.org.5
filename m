Return-Path: <linux-kernel+bounces-105099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680987D918
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB721C20FA0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E050ADDD3;
	Sat, 16 Mar 2024 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aquw2tYM"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34FD512;
	Sat, 16 Mar 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710573159; cv=none; b=u3Kwft1+3dPoEnORq9HSn/s8wgWAUlucb/qIzp+dnCsNuWhdv79PQFPX19mJXFflTuhv/nJPLSMMdj7H8EQS7kwg3Qend1WWImkFvF9qOFXdKGwLsiBvHDNdEoCq9meUwW0BXTyPF2RzHzRpdIKxg0iUSzW34Fmwvu4r8YkdjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710573159; c=relaxed/simple;
	bh=ppE93cv1QyN7O3apvV9Q/H8M+w1Ua5G3g9KKi3vKu8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kMer4nAzw37CuYbo7kNOGYahOUTPHlvKnNCSnj+KbJSv1l0v5qX9BlHM1tgvfocLD6wKmWv9EtiK4wq1gk4g9aKIyWQuj8IIalT3xFPVQDsQdSVTWfW6f+duLl6ZTqGTB3w0YjsDMxs/O2hAf5Vdm6bOqbx8v8gR/z8/h8OxJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aquw2tYM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b5432439so2826384b3a.1;
        Sat, 16 Mar 2024 00:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710573156; x=1711177956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8oDZKpxy0SLAMcyRnZgXM1CHZS3gVNfsxrD16EfDgvc=;
        b=aquw2tYMFsLrwMDYY2gbcsRAAYNvqxKS++K0YcaFg3VTOTKOPMFi3uF0+PyClV/0os
         hN/hFOO0jaMA7PRuiDz3+X4Jskfybl7QtFXxJM8n5oZDi3GJlK1UaEhdWjaikW7YezO4
         5Ypz94mHdCi5uYFBrf40pClc3VlG0yHW+WTTFypVL9cSdEcR06yAENs64RjjhM4vBuPU
         ZlczUiHDu8Hp7e9ZabPw7QROgcHs5E3qIXfE++wdSpVwk0jCRG52MpgxPXiIxZ9tVCKB
         rdzvudErpr8UTTQk9aG/kHw9TqW9tpnN4lqJLqR9i0tbbC/IHMSBqlf/2RPnZQelAvE+
         Qo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710573156; x=1711177956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oDZKpxy0SLAMcyRnZgXM1CHZS3gVNfsxrD16EfDgvc=;
        b=A4HEAdigPbV/CpCpef/wlhVMaNOdH2gfDpwvibdt/Rp1nFagjocaTy9nwJHLgjUHcW
         ++Aen43KmOR8gmgu18JuRWyMWS1u7uv+Rxj/cUSe2b/L7elXx366HKrTpF/cEpUwjll2
         t0VWjiWRQRW5BHQBO479UbYAhMYVSm38EHkTKxl/husCPmamiieLB1rOvhgOtB2aLA9M
         Mr2OBgf8ekbuScWEewigUJQgWdvNL8pqLXUQnICmLkVJU3naLw1o7QEIO86Iovun1NgV
         9QUCV1+BcYt6s67eX8iSy1lA3k0yNOZi+MTdrGmJzRWEKoLSPBVvhJi6cNiZdF2tBSgV
         Mb0g==
X-Forwarded-Encrypted: i=1; AJvYcCW8rrmDMZxjMM6n/kXs9Mv3wWowWYGCgVoJlKbNA4uuA2O8ZCIJqqOs4CvXNXJOB/GzQ7twYCI3MO8PDXsugnwmaottVfqWNRZFmMzV8c9KXK1K2CU7XuffeJwMcoa0sS/HuqGAxRU+gAA=
X-Gm-Message-State: AOJu0YwldnR0ZjhXhOP1RMOJPTuI48JboVt4H5MiziB14Cw8t+UFJt2G
	imGMD9wg648h3P77+tH8Okm/5sPCC+R+buZQAJWj6i5mmSrMfuNlVBrCIt4jIEKhmg==
X-Google-Smtp-Source: AGHT+IHKo/55+X0r4fSws+qbSoxX5taM8lhT273EIdjdmOO0UAJS1z9g1aQ+ugU43TQdBDX2VXKFYg==
X-Received: by 2002:a05:6a00:1747:b0:6e5:fb97:ed35 with SMTP id j7-20020a056a00174700b006e5fb97ed35mr7530625pfc.18.1710573156045;
        Sat, 16 Mar 2024 00:12:36 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id x18-20020aa784d2000000b006e5a915a9e7sm4574651pfn.10.2024.03.16.00.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 00:12:35 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au
Subject: [PATCH v4 0/2] Add hantro g1 video decoder support for RK3588
Date: Sat, 16 Mar 2024 15:10:58 +0800
Message-Id: <20240316071100.2419369-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the v4 version of this series adding hantro g1 video decoder
support for rk3588.

RK3588 has Hantro G1 video decoder known as VDPU121 in TRM of RK3588 which
is capable to decode MPEG2/H.264/VP8 up to 1920x1088. This vpu ip is also
found in RK3568.

Test results from fluster can be found from thread of v3[1]
https://lore.kernel.org/all/20240118080602.9028-1-liujianfeng1994@gmail.com/

Changes in v4:
 - Change compatible string to rockchip,rk3588-vdpu121
 - Link to v3: https://lore.kernel.org/all/20231231151112.3994194-1-liujianfeng1994@gmail.com/

Jianfeng Liu (2):
  arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
  dt-bindings: media: rockchip-vpu: Add rk3588 vdpu121 compatible string

 .../bindings/media/rockchip-vpu.yaml          |  3 +++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 20 +++++++++++++++++++
 2 files changed, 23 insertions(+)

--
2.34.1


