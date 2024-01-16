Return-Path: <linux-kernel+bounces-27713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE14182F492
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FB01F23EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0441CF96;
	Tue, 16 Jan 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wVyt2T5F"
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC55310A09
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431002; cv=none; b=GKzfb+a52WFj1uniaLWqBHcXahKRQ3351199nUsUzDo44VaS5UW9nvatZHveIcBspFtOTe+iBUWSZ2DFoFope6NLtLh713dQaqNs/zz637pt6priHIeuFK4Ku53eWhSZNo0gS4NPLiHmn/irLQf2dS/DhXxJ2hDm5MxGIPPbx9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431002; c=relaxed/simple;
	bh=23E+zOOhJWI4SMMPXMWfWUwPDVxCt2bFVpl2+0vzHuA=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=U75syk3sSa7KBBysy+RsS9zM6BBiO6mZ4KN68wSBFtZ54Q620OoB6aNlHCMJYTcKwEMX3+4DJeHkxcxTag8NMIYA5Sqdfax/ohryxP5PCoAdHYszUhL70haE6yY+yoFfS7kCBv5+YwBnpubndT7XPBHbNlAPlWXDXqjlYpO2Qe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wVyt2T5F; arc=none smtp.client-ip=203.205.251.59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705430987; bh=stlN6YfiC8L9Ag4benpqdHlyqEnTMcGYBbMTAHM9e4w=;
	h=From:To:Cc:Subject:Date;
	b=wVyt2T5FWdzO5svbe2jDC7ZiJErGOKZbTVkTttLWgkFDYtgsVOunxb5uVhzffZyiL
	 R0aZFID59z7rfFqWRVK9ynkAonOTPWINFIcN19bVbHXFh/QBmfaOKcfzik+B1Q1RjP
	 DxNx4fmOsBCqoV4DEtOLsw/5EJkXR4v37LM7U808=
Received: from cyy-pc.lan ([218.70.255.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id C63A96F5; Wed, 17 Jan 2024 02:49:35 +0800
X-QQ-mid: xmsmtpt1705430975tm33z1db6
Message-ID: <tencent_53C5DA6E8E55B80731AE21328D037C908208@qq.com>
X-QQ-XMAILINFO: MQAOa38Yz/8/aS8UZHZVnW/xmkhE5R0LK4hhHkoDPoiRxwOrj+1gIOA5CqizxC
	 ZqNTmCR2iU5Ib6ZrEOnaJtb6EcUNiEs981+XlYb8ZdHcZdYJs8aaq0f+J2VKDFkPyLUtXixb3Dfn
	 WH+qrQXwcXO2uD9mfqXLnhS8jZugElrW2tt/9BsyC5k7XD5y/Jd7R5WzGNlq7IMFJ5WWngsNXdt/
	 N5hhvVgVLEK/cqiFlCwWlI0GG3ovEgKLcVDAJyFa87Ovjq2lWG52wFcC8qQPGiMuIam2rDnn7TEs
	 BciELdvmtsLLMS5wnrIhihin3ZWELmm0eIPQ4E1/YwlJdTz7P/H3DGBDqz5Okl5iRmHKOVYuQAd0
	 zDS5SDJvoGeBp09iMCTytEJTuviEO5coDpGeX/SChR4HuYCnHXbR+bVepKRvCN7bYXh5VwT8KVma
	 o8W4R+idJb1zf2+4nWYJseXolNGB6Po7nusjYafXU8WErPsNAlV6BAelUiBDHMAkE3pchusJK/y5
	 HgabD2TrZ5+r4kxNH/rWG5p2P/ESBMXX2yleEUjl/Ln6a0wJCEFIK4X6dDtfOECIiVeUwxXpDNRC
	 N0u4Dp3lsWyopwjCxJH5UsXekAvzoI1ZsBnDwTw7X83CSkbhc7AJv7a/lGyzA0mMfspeJ/iDvAdw
	 hItkZhlcmtsxMyeiYCN1Od4JsBv6f2UbTPUMh3zXS6Wzu6n4/L5l8v23zMraLANwXODUu7fclyXA
	 ePC2iQNZaul+3PMIbtXvYdXaG7PsrWpDRkAjTiQECGWdVlpysttW+W6JSKczdZFLnASzOYJv07Ad
	 82/TqdG4b1aL9+vrLvQ5ysn7mJUSAHWeWXwtTSP4voZvbLr/KvoiBbz5zAeTbFqTrfjlQvhh16aH
	 VVSi7hWUqUuWzO4HF5wNdbtvRYD0imp12aMg/ExPKoMTBocqatKzg3gArlrJoZazdk3S+OLkDebB
	 e1S0y86jPJeALxWWGR2sDv5Blbe1I0L+8GXcoSkMznRr/y1w6DokRrMQWE/nbNM7gUatCxmPk=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yangyu Chen <cyy@cyyself.name>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jiuyang Liu <liu@jiuyang.me>,
	Yichuan Gao <i@gycis.me>,
	Icenowy Zheng <uwu@icenowy.me>,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 0/1] drm/ttm: allocate dummy_read_page without DMA32 on fail
Date: Wed, 17 Jan 2024 02:49:23 +0800
X-OQ-MSGID: <20240116184923.175029-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms may not have any memory below 4GB address space, but the
kernel defines ZONE_DMA32 on their ISA. Thus, these platforms will have
an empty DMA32 zone, resulting ttm failing when alloc_page with GFP_DMA32
flag. However, we can't directly allocate dummy_read_page without
GFP_DMA32 as some reasons mentioned in the previous patch review [1].

Thus, a solution is to allocate dummy_read_page with GFP_DMA32 first,
if it fails, then allocate it without GFP_DMA32. After this patch, the
amdgpu works on such platforms.

Here is dmesg output on such RISC-V platforms with Radeon RX550 after this
patch:

[    0.000000] Linux version 6.7.0-00001-gd90146c47100-dirty (cyy@cyy-pc) (riscv64-linux-gnu-gcc (Debian 13.2.0-7) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.50.20231227) #13 SMP Wed Jan 17 02:35:17 CST 2024
[    0.000000] Machine model: 
[    0.000000] SBI specification v2.0 detected
[    0.000000] SBI implementation ID=0x1 Version=0x10004
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x0000002000000000..0x000000200003ffff (256 KiB) nomap non-reusable mmode_resv1@20,0
[    0.000000] OF: reserved mem: 0x0000002000040000..0x000000200005ffff (128 KiB) nomap non-reusable mmode_resv0@20,40000
[    0.000000] Zone ranges:
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000002000000000-0x00000021ffffffff]
..
[   36.425400] [drm] amdgpu kernel modesetting enabled.
[   36.430695] [drm] initializing kernel modesetting (POLARIS12 0x1002:0x699F 0x1043:0x0513 0xC7).
[   36.439436] [drm] register mmio base: 0xA8100000
[   36.444055] [drm] register mmio size: 262144
[   36.448462] [drm] add ip block number 0 <vi_common>
[   36.453348] [drm] add ip block number 1 <gmc_v8_0>
[   36.458150] [drm] add ip block number 2 <tonga_ih>
[   36.458153] [drm] add ip block number 3 <gfx_v8_0>
[   36.458155] [drm] add ip block number 4 <sdma_v3_0>
[   36.458157] [drm] add ip block number 5 <powerplay>
[   36.477491] [drm] add ip block number 6 <dm>
[   36.481764] [drm] add ip block number 7 <uvd_v6_0>
[   36.491409] [drm] add ip block number 8 <vce_v3_0>
[   36.703765] amdgpu 0000:05:00.0: amdgpu: Fetched VBIOS from ROM BAR
[   36.710051] amdgpu: ATOM BIOS: 115-C994PI2-100
[   36.716023] [drm] UVD is enabled in VM mode
[   36.720242] [drm] UVD ENC is enabled in VM mode
[   36.724789] [drm] VCE enabled in VM mode
[   36.728724] amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[   36.728735] amdgpu 0000:05:00.0: amdgpu: PCIE atomic ops is not supported
[   36.743620] [drm] GPU posting now...
[   36.858108] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[   36.867392] amdgpu 0000:05:00.0: amdgpu: VRAM: 4096M 0x000000F400000000 - 0x000000F4FFFFFFFF (4096M used)
[   36.876980] amdgpu 0000:05:00.0: amdgpu: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
[   36.885347] [drm] Detected VRAM RAM=4096M, BAR=256M
[   36.890228] [drm] RAM width 128bits GDDR5
[   36.894289] [TTM DEVICE] Using GFP_DMA32 fallback for dummy_read_page
[   36.900907] [drm] amdgpu: 4096M of VRAM memory ready
[   36.905896] [drm] amdgpu: 4007M of GTT memory ready.
[   36.910928] [drm] GART: num cpu pages 65536, num gpu pages 65536
[   36.918185] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[   36.926847] [drm] Chained IB support enabled!
[   36.935727] amdgpu: hwmgr_sw_init smu backed is polaris10_smu
[   36.947466] [drm] Found UVD firmware Version: 1.130 Family ID: 16
[   36.976989] [drm] Found VCE firmware Version: 53.26 Binary ID: 3
[   37.329484] [drm] Display Core v3.2.259 initialized on DCE 11.2
[   37.390981] [drm] UVD and UVD ENC initialized successfully.
[   37.497639] [drm] VCE initialized successfully.
[   37.502935] amdgpu 0000:05:00.0: amdgpu: SE 2, SH per SE 1, CU per SH 5, active_cu_number 8
[   37.516199] amdgpu 0000:05:00.0: amdgpu: Using BACO for runtime pm
[   37.523381] [drm] Initialized amdgpu 3.56.0 20150101 for 0000:05:00.0 on minor 0
[   37.592040] Console: switching to colour frame buffer device 160x45
[   37.614276] amdgpu 0000:05:00.0: [drm] fb0: amdgpudrmfb frame buffer device

[1]. https://lore.kernel.org/lkml/2b715134-9d63-4de1-94e5-37e180aeefd2@amd.com/

v1: https://lore.kernel.org/lkml/tencent_40DF99E09A3681E339EE570C430878232106@qq.com/

changes since v1:
- Add __GFP_NOWARN on first alloc_page to avoid warning on such platforms
- Place comment on the top of the if
- Shorter warning message

Yangyu Chen (1):
  drm/ttm: allocate dummy_read_page without DMA32 on fail

 drivers/gpu/drm/ttm/ttm_device.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.43.0


