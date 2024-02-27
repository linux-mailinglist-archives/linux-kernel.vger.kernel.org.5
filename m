Return-Path: <linux-kernel+bounces-82659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A4E8687E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC661F23024
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3853495CC;
	Tue, 27 Feb 2024 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8TZ5Fnl"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79E2B9AE;
	Tue, 27 Feb 2024 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005559; cv=none; b=NfvJo3uH3MgIxp6daEO0KQfM0m0XgHtVVo4rmtTIs682bUYy9LWe4tkDE5LJtdlmCl/+a0himtCPfrkITfBfj4VbjVMWqsHnkOS93NjvYwq+0rqZCLSvcAy2ioJ+8qMMeIMjzqKkmHOo1LHH1ra4IjEbuhRVyI1YKgIwOFo6FIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005559; c=relaxed/simple;
	bh=vcai9d1SaHknWypx9g0oBQddWEqztQWNUPqi7bp1fLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgPshzcLVC32y4kemjqLMJnPmeXTroXSwWYe6l9trrKmMsLgKz3zknAj8eS+SrwZfRPqnAavZPlxYOGok21upEVQm/p182hOXpRKJQpbO5p3X/zd/MX66/9YOFEDRXS4UpeUFqKvkZZhoJJTwwkjLmmzrLkyEafLVrF6bGDnIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8TZ5Fnl; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36517219a19so12634125ab.1;
        Mon, 26 Feb 2024 19:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709005557; x=1709610357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wl0bBkvRiqQeuBTLPhRoK2WWUUi11l8F15u5KFX7dWY=;
        b=Z8TZ5Fnlg2OmPpbZ8Z7DE59CLKXi6uBIJT5IMxa/9Xr+zCQUioxm/cBQ4Q2k4pHrOl
         nK3xfNDvZpMGYaTGFwXU66PuiyLJp7+jxCcE7BSCT4FpYPuzmI2no9ruEluN4cztq153
         NgMeayEBtiQuIAz3P+4ZmDq6ZjOneudMZHcyf1cNDfvARqXb0tVK61G/6BEUCj2StYwW
         5sOOZzG4UGGiED8O9mYtMvPGH2VAoHOHEhd38axYESyrP/SYrr+gY8mmijzBwOup1eXP
         7ap0y4B3MD4fU1jAaiD1UigVWc2TBiavjhtpNq6Bpa0kSZIFVGE9mWW/qgMxQX1ulku7
         eyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005557; x=1709610357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wl0bBkvRiqQeuBTLPhRoK2WWUUi11l8F15u5KFX7dWY=;
        b=B4ykBnn5YkWBVlN+ihN8JZ4dd+0RV5powiLpZRb/bdDq4wM9lREQUSxMICFahdtks4
         40f31SxgIsMfBLl6Fg0oLldAA0Dl2Jjl8uQ8PcA1MnvhEN629mjwx51GlagYym4CbdWq
         D9Pub0VkXkwsPWNkHIdAh/x2cE5fDhCDgQa5lnWxWYQ4Rpihyo6wEyJgxHwXpLNN8LM7
         0dAJYz47VTERz9N6aMV/dSxNFvQMWRDVa2etVtZ3cMhz3rOO26WCtqaSEMcJ9Kg6vbnt
         14DTPs5LsNU0HrHK+Prn++aIfIuu+K6XwT1XC/nKUKXBnZo0lSUKa67GldjcHww8ux7r
         EbhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwuuhI8/ex7FR6RKp7hczmvKhC4dVkNRoY+ZiyhmqZzpwIihPdYx7XPCZTffL1yYlOyWDRbbBM1bO3uUUXF7HAUr81KyHCL58q5p39FutW5wMNMayA9l+N7rCOi3qUaAo1nI0nzL7cb0j1uKNFbpvKcuFlY93oVN7vbxNcmunuPBUuNhRmA7dAZs/P
X-Gm-Message-State: AOJu0YxU8HDbTLfClZCtugpPegkhgGqxcKfwf0fusrG6n7G8IIJ9HcSU
	aRQ8oQZkiM4E7D3t0zi1uF4nFwUU7REmGoB3zXocbdJ8EfREJo0pGfSNj9nh8Vu4N7+K
X-Google-Smtp-Source: AGHT+IF5iCsGO7Lh19DB7/toWuvvr5zyzgW6mtDlHlNqxuxd8xI4191wlLaB8IhucWBfHVJ3P+Nsjw==
X-Received: by 2002:a92:ab03:0:b0:365:858:d6d1 with SMTP id v3-20020a92ab03000000b003650858d6d1mr8892141ilh.1.1709005556933;
        Mon, 26 Feb 2024 19:45:56 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:1712:c48b:aaa0:cd8b])
        by smtp.gmail.com with ESMTPSA id w4-20020a92ad04000000b00362b4d251a5sm1891566ilh.25.2024.02.26.19.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:45:56 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] gpu: powervr-rogue: Add PowerVR support for some Renesas devices
Date: Mon, 26 Feb 2024 21:45:30 -0600
Message-ID: <20240227034539.193573-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas has used a few variants of the Power VR GPU in their R-Car
and RZ/G2 families.  While there is still some work to do at the Mesa
level,  adding these device tree nodes allows the Power VR driver
to enumerate and load the respective firmware located:

https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/powervr/powervr?ref_type=heads

Adam Ford (6):
  dt-bindings: gpu: powervr-rogue: Add PowerVR support for some Renesas
    GPUs
  arm64: dts: renesas: r8a774a1: Enable GPU
  arm64: dts: renesas: r8a774e1: Enable GPU
  arm64: dts: renesas: r8a77951: Enable GPU
  arm64: dts: renesas: r8a77960: Enable GPU
  arm64: dts: renesas: r8a77961: Enable GPU

 .../devicetree/bindings/gpu/img,powervr-rogue.yaml  | 13 ++++++++++++-
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi           | 10 ++++++++++
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi           | 10 ++++++++++
 arch/arm64/boot/dts/renesas/r8a77951.dtsi           | 10 ++++++++++
 arch/arm64/boot/dts/renesas/r8a77960.dtsi           | 10 ++++++++++
 arch/arm64/boot/dts/renesas/r8a77961.dtsi           | 10 ++++++++++
 6 files changed, 62 insertions(+), 1 deletion(-)

-- 
2.43.0


