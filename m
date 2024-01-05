Return-Path: <linux-kernel+bounces-17967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7974182561D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936741C22C38
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DB62E656;
	Fri,  5 Jan 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="f4Ln9Qhm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BD82E647
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28bc7155755so950750a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 06:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1704466211; x=1705071011; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GZErK6MV9K+J1f32MeF31Zrg/PpbhFZ67cEtY9jkovA=;
        b=f4Ln9QhmPj3rQx7WsS4/AegQ6WcHQw2DQxFzY6euSYZecr6ZBlVd/68FVyfnNpTI73
         pHex+z7vn8LBfF/1mAZAfqYLJg8woC2essRnLI9zudF8GREpY1MBpANOzLGF/WGvo95s
         JORfT/BsmZvwcxVpFkPQ4dnOL1L4tKO3Dd3kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704466211; x=1705071011;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZErK6MV9K+J1f32MeF31Zrg/PpbhFZ67cEtY9jkovA=;
        b=s4ECe5qzaajXhcAFoxae5sio2QYolZo0DgpJNaVsZqqp0aNpY8tPlXFR/d3KqKxHrz
         4KSBLWT/4gJ1gKvbb7JBTbdC0BIViO49ze34p5SrtL23ojBBxTvnUUmxjpcAZ2pnFQ38
         GEezZn2r6YmU51JXDM3Eypi+F27XO7zEd9+OaNFgbtajmM0v4M++wkqszORuJkfCgkGT
         k7ih8wYlZ5KU8Uv90PGmhCoE3pzdQ1Utfpo37d/0tF7hkCZ4y3SVCNdsIzw0GQKc7Hnu
         1sTPrMDq19b8IVbTBGIY+hDPoM+HCAbiFFQ75OfNQ3vWoCO82GQz6y3/zb38tXRj0jZ6
         HsFA==
X-Gm-Message-State: AOJu0YxyCco+mdikBUZoqYLRQgL2JzGnj3hrju6W45ERCwmC8ex9noqe
	qPkNCKqDzeGyS2w2Wo7KBCym+A4XwkQmKXxIma7iU+YFriPimzd4Rz5lXPPpjaw=
X-Google-Smtp-Source: AGHT+IH9PkpLVuD6KIuQh8C102TbBYuAyg9PTODZIORcrF2+0m43K2hAVXxfEm8t4FIQxp0ChjC0vWQ6OOiuAkwsPpM=
X-Received: by 2002:a17:90a:db07:b0:28c:a9f6:a1e7 with SMTP id
 g7-20020a17090adb0700b0028ca9f6a1e7mr1977878pjv.46.1704466211332; Fri, 05 Jan
 2024 06:50:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Fri, 5 Jan 2024 09:49:58 -0500
Message-ID: <CAO9zADza=73GsuzAcuyH-YfhS34qjkDtuJjGBReVGpfE6KN_ow@mail.gmail.com>
Subject: 6.1.0-17: nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0xffff
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Distribution: Debian Stable x86-64
Kernel: 6.1.0-17

Reporting this as requested from the kernel message, I have now
appended the recommended kernel boot parameters
nvme_core.default_ps_max_latency_us=0 pcie_aspm=off and will see if
this recurs.

Jan  5 06:18:52 atom kernel: [295306.524933] pcieport 0000:00:06.0:
AER: Corrected error received: 0000:00:06.0
Jan  5 06:18:52 atom kernel: [295306.524979] pcieport 0000:00:06.0:
PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
Jan  5 06:18:52 atom kernel: [295306.525004] pcieport 0000:00:06.0:
device [8086:a74d] error status/mask=00000001/00002000
Jan  5 06:18:52 atom kernel: [295306.525027] pcieport 0000:00:06.0:
[ 0] RxErr                  (First)
Jan  5 06:19:22 atom kernel: [295336.554420] nvme nvme0: controller is
down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
Jan  5 06:19:22 atom kernel: [295336.554469] nvme nvme0: Does your
device have a faulty power saving mode enabled?
Jan  5 06:19:22 atom kernel: [295336.554489] nvme nvme0: Try
"nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
Jan  5 06:19:22 atom kernel: [295336.614521] nvme 0000:03:00.0: Unable
to change power state from D3cold to D0, device inaccessible
Jan  5 06:19:22 atom kernel: [295336.614898] nvme nvme0: Removing
after probe failure status: -19
Jan  5 06:19:22 atom kernel: [295336.630497] nvme0n1: detected
capacity change from 7814037168 to 0
Jan  5 06:19:22 atom kernel: [295336.630502] BTRFS error (device
nvme0n1p2): bdev /dev/nvme0n1p2 errs: wr 1, rd 0, flush 0, corrupt 0,
gen 0
Jan  5 06:19:22 atom kernel: [295336.630513] BTRFS error (device
nvme0n1p2): bdev /dev/nvme0n1p2 errs: wr 2, rd 0, flush 0, corrupt 0,
gen 0
Jan  5 06:19:22 atom kernel: [295336.630542] BTRFS error (device
nvme0n1p2): bdev /dev/nvme0n1p2 errs: wr 3, rd 0, flush 0, corrupt 0,
gen 0

Regards,
Justin

