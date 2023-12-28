Return-Path: <linux-kernel+bounces-12669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C57B81F8B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBA9282628
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C88468;
	Thu, 28 Dec 2023 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EySvRj/V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6D79EE;
	Thu, 28 Dec 2023 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so25943905ad.2;
        Thu, 28 Dec 2023 05:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703769179; x=1704373979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdxMA0IFnQNSF87xNJWS4MQoHn8cWo2ZJ5T/rZOTLd4=;
        b=EySvRj/VXYxKmQMjRiC2M+mt7VBXjidQwwrmLXBO93zJYvin1X1te0px4/j7zEIHC6
         LDUHf55DCBUlRJwvCmiL6G/shpwsy5TU/GuuQQdzIEpo1jK1TzwbdSd4+bP2WmLBQsHk
         6gVCuaAocQwBEyj7Iv0nROtymplYZVIbMMF068vVOo+ftL/ZJyupKULhiJhYSo1uwmw3
         qcjHS02uQ6oLl7fl7D4AwfpEOCOPT/klboFPhL8n0EDii5227xgVIqHjKKiY9uYBShhB
         HI872csUjimGFCEkoVu5a+YPEHtEvmbgdCFQAPFArBHAwcIJaPai7MPhr44wSeT+br9u
         wC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703769179; x=1704373979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdxMA0IFnQNSF87xNJWS4MQoHn8cWo2ZJ5T/rZOTLd4=;
        b=B3jJJ33w3SJfXfZKxSHUhmWTxQSIKWHgt8o9ABjxMBniNIKwyzEk4awJnOWZWAZiUd
         bhg4JkQY3TzzYrmy+t+5XtjeK/i3+sTw4xLRHsFlCXIIVwHXxVk9EjBnmMSNcge+ylz8
         F3g7xr90UA2IDSuhJqKLYlycEFX76ivyxBlOPICKQmWh8Wq7wY3falxMnJB6FTIdp62i
         Dmu/m8NYgVpE+thx+pjBtQdSHdw/ksHHwX+/Gp08CChBNvqIiq7sTIxJDrdVR7kOknDN
         LLGKvFZXG8fgcxr9xCAlvLc6KStRJ1snZ9oQK94an145+7H20ewSDhSs6wk51g4FlT7B
         OVJg==
X-Gm-Message-State: AOJu0YyKoG60D11Yd3qaz+7nqWAiEjJd8T+8QaecN0Ny2obIvGqrVVkZ
	+RUHN0EgjQ9SZKLi1FSkfQ1xcnnJWAiIuWPY
X-Google-Smtp-Source: AGHT+IHPd8c8SYk5UR/CgxiKBryChaDijaKA4sczlTbTwdwoxSlTcheRkC4yqkDpKfz6fnF3obdy4g==
X-Received: by 2002:a17:903:11c3:b0:1d4:75c6:9560 with SMTP id q3-20020a17090311c300b001d475c69560mr2578044plh.59.1703769178818;
        Thu, 28 Dec 2023 05:12:58 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:3708:559:ea20:9883])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b001d3e5271459sm14300404pla.55.2023.12.28.05.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 05:12:58 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sfr@canb.auug.org.au
Cc: liujianfeng1994@gmail.com, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	"devicetree@vger.kernel.orglinux-arm-kernel"@lists.infradead.org
Subject: [PATCH v2 0/3] Add hantro g1 video decoder support for RK3588
Date: Thu, 28 Dec 2023 21:12:41 +0800
Message-Id: <20231228131244.3411442-1-liujianfeng1994@gmail.com>
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


