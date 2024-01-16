Return-Path: <linux-kernel+bounces-27376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E12D82EEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CAC1F2439C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9201BDCC;
	Tue, 16 Jan 2024 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="z835TK+Q"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA45E1BDC4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so11511088e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1705407802; x=1706012602; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP28pKwlC43EyMKbv8HcsE5BWUxwmYS/RkADmts8Xrs=;
        b=z835TK+QLUAkiEJgC2s2jBduGOE+BILWlQRa/6X5pGukv4AQHuQl7sjfVgoOyezfa/
         gmgaNeo5koKd6LVubAI0SaRu7ue0jd8iN841+U6A36QNpbLCPWn1MNduU6drWINnhQQs
         yD2P5jyL27oqsfy4vkS4/0rvreS5zqu2lE2Iet5bzN4Ci5WHfe0I1axSspDZ2dexYLAd
         pDlq44TP6qcK9lEYanckT8bny1fU/XFcAuNJIm+NcHW4Wn/mRnEjd1PCXS1+9/3MBatI
         kccUZsQWi5I62zG2TPUjvBXFUwHtcYyq8QezKQZs+cW3nKBry3ARxbogPMkBjCEeNOVi
         YmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705407802; x=1706012602;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GP28pKwlC43EyMKbv8HcsE5BWUxwmYS/RkADmts8Xrs=;
        b=gs95xcUbKq+5lj7RytC88fFl/KbLDst7RjR3wSiXlSxFKGoBbpoqq2sPdp+qEfRPs8
         PTLkGBEqUlN11hDUHMdrwKWTmdGqfHkbnWrlYo/2Wpta7exhTpZoZeI+7Cw9/V8AkHQq
         iScy9ttnxW4BAXr2ghBmzwOGDzAt/p1IhxYTdHD/gdsytwaV6bXK4NjJSw/qgCTF5Z0q
         RADMI826qO0Cv0/nCEW6QrlAcVHNkoO8IPLOzLHpdPyl0VmypX7nrK7laB9ui7DPuaHI
         RtT9zHc3J5EtSbe1gQQ1DGZm7KNjzbxpHDtISawLqP9bEUjXF8Vh9ZJGJ7N3KPa2+kCz
         t9Gw==
X-Gm-Message-State: AOJu0YxIkFzcPBN8hIN/LEY9nYp5xgg/Mr2Wj/KEKMnynI7CFNG703Fm
	d4VoxJY6e+aW3wlOLkavYbuRa1caOJ9Xc2cAMk3PQmhhBXYP
X-Google-Smtp-Source: AGHT+IG4c4QnbBzRLcElDSXI39Uj0viamIdzz4hDyod0oVfHHrKTnr3OXKIjKxhE5Hh0OCViYaNRfQ==
X-Received: by 2002:a05:6512:e9a:b0:50e:3f2e:c726 with SMTP id bi26-20020a0565120e9a00b0050e3f2ec726mr4200149lfb.87.1705407802041;
        Tue, 16 Jan 2024 04:23:22 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709060f0900b00a28f6294233sm6410335eji.76.2024.01.16.04.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 04:23:21 -0800 (PST)
Message-ID: <adcaeddc-1bee-4e5d-bf1e-d1cc93d08a01@monstr.eu>
Date: Tue, 16 Jan 2024 13:23:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 6.8-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

please pull these 3 patches to your tree. All of them target defconfig to align 
with the latest Kconfig layout and enable Marvell ethernet phys with NFS.

Thanks,
Michal

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.8

for you to fetch changes up to ffb0399437ef582b035089d1617bbb0ea174cd0c:

   microblaze: defconfig: Enable the Marvell phy driver (2023-11-15 13:49:14 +0100)

----------------------------------------------------------------
Microblaze patches for 6.8-rc1

- Enable NFS, Marvell phy
- Sync defconfig with the latest Kconfig layout

----------------------------------------------------------------
Michal Simek (1):
       microblaze: Align defconfig with latest Kconfig layout

Radhey Shyam Pandey (1):
       microblaze: defconfig: Enable the Marvell phy driver

Raju Kumar Pothuraju (1):
       microblaze: Enable options to mount a rootfs via NFS

  arch/microblaze/configs/mmu_defconfig | 13 +++++++------
  1 file changed, 7 insertions(+), 6 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

