Return-Path: <linux-kernel+bounces-22874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D8A82A4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8FB1C2351A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822974F8A0;
	Wed, 10 Jan 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLI36cK6"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3824F895;
	Wed, 10 Jan 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9b5c4f332so2736153b3a.3;
        Wed, 10 Jan 2024 15:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704928308; x=1705533108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17ggLjMqhe+Zr+Ze+Tl7nFqyP1F7QF5Gb7QnXBuIMrY=;
        b=ZLI36cK6NSvehDVTszGnustYvsEIltNfcRnjxi9ZaNhEGZ16FDP6yWjsZaZh+om9oF
         418Td6bpgRM8HV/2qW7YioJjIUU4H9IkiYN5Nb/OmXZZ3Gju2Q3Rz+wB78mt1phtb06/
         rlH6Pe93xWBLUzKoDoiveUe1MxiH0Ii2AWK4g8N+uEoVOUcRS9tIV0Ek71NVtc7uArki
         p0WgvedMoPs9/gCgGMQJjDT2XvNNTYWj8L+O/cf+O/YReF96b0xgVz29dgwj8GZJt3m8
         0UvcgvVgCWGBnueQqAn34y5usFQ5mgoAnS+CtX4xZ2/Qyxm5bnMtoSLQvG6DYLXsGpN2
         zUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704928308; x=1705533108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17ggLjMqhe+Zr+Ze+Tl7nFqyP1F7QF5Gb7QnXBuIMrY=;
        b=Z8UwJzWnbqQkgIPKQ2Q9MrofaP+XZUhZV/7Qiifz/m7Ib3ycLUx5mYWnj5+8BqeJuS
         EjuXUVmMfTPHIWJ1mdeXYcXalttZlXJnMf4sQo4sb0CGjJDDnk5lBjJ1xSqt7jMLUkUQ
         25hX7rJ+eussNjPjkjo7yN8amFy/vhiY0Hhlkx8A8ZHoE56rioi/nCnZ6bqwTLwdZ43o
         LeqUCUbO/3XwnKVKeNNgdMlCxGCWmejRN6dnPYyCzD4KRXLHlIg7o6CZJyzoIxFeOTT8
         CxspcOKghnNdeDqdDWZLQUprrmBhNf3E1tQ2naXHjG4YNwdUvEudWkqGBhAIYCBrGF1i
         a3Qw==
X-Gm-Message-State: AOJu0YyIXVlfIcSznfWbMEt8L6vmYAQzUdSz9I3alpu1d1B50C6AGv6h
	4616DejdstkNqAM2uas01JnGqlsaR0w=
X-Google-Smtp-Source: AGHT+IHZARl7rSl8NdTsrREwKc5YhqEvGu3RiYk0rFv5GSBzL+R9LyPYMbQE7m3aDkaiNMcNO7CERg==
X-Received: by 2002:a05:6a00:11c6:b0:6d9:b75e:ddc3 with SMTP id a6-20020a056a0011c600b006d9b75eddc3mr272535pfu.33.1704928308194;
        Wed, 10 Jan 2024 15:11:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id du25-20020a056a002b5900b006da022d1bc8sm4004057pfb.25.2024.01.10.15.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 15:11:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Jan 2024 15:11:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/export.h: remove unneeded .balign directive
Message-ID: <50cf203b-eb25-4cf2-a5ea-673656310822@roeck-us.net>
References: <20240103135454.376021-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103135454.376021-1-masahiroy@kernel.org>

On Wed, Jan 03, 2024 at 10:54:54PM +0900, Masahiro Yamada wrote:
> The .export_symbol section is discarded by the linker script, hence
> no alignment is needed. Simplify the code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

With this patch in linux-next, all sh4 builds fail.

Building sh:defconfig ... failed
--------------
Error log:
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
{standard input}: Assembler messages:
{standard input}:6: Error: misaligned data
{standard input}:7: Error: misaligned data
{standard input}:8: Error: misaligned data
make[6]: *** [scripts/Makefile.build:243: arch/sh/boards/mach-x3proto/ilsel.o] Error 1

Reverting this patch fixes the problem.

Guenter

---
# bad: [8cb47d7cd090a690c1785385b2f3d407d4a53ad0] Add linux-next specific files for 20240110
# good: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
git bisect start 'HEAD' 'v6.7'
# bad: [b14da9dd6f977c6e18a4c81e4b92692fd9b6997f] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad b14da9dd6f977c6e18a4c81e4b92692fd9b6997f
# bad: [e85ebbed67d0d74e8602d11a496183d8f65e0b2f] Merge branch 'for-next' of https://evilpiepirate.org/git/bcachefs.git
git bisect bad e85ebbed67d0d74e8602d11a496183d8f65e0b2f
# bad: [65d7e41dbca9e31017cfd36c2ce4cb8408b1f2c6] Merge branch 'perf-tools-next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
git bisect bad 65d7e41dbca9e31017cfd36c2ce4cb8408b1f2c6
# good: [fb46e22a9e3863e08aef8815df9f17d0f4b9aede] Merge tag 'mm-stable-2024-01-08-15-31' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good fb46e22a9e3863e08aef8815df9f17d0f4b9aede
# good: [fd38dd6abda589a8771e7872e4dea28c99c6a6ef] kselftest/alsa - conf: Stringify the printed errno in sysfs_get()
git bisect good fd38dd6abda589a8771e7872e4dea28c99c6a6ef
# good: [8a0bd6d47301eefd80fdfeb3a00ec09011546155] Merge branch 'mtd/fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
git bisect good 8a0bd6d47301eefd80fdfeb3a00ec09011546155
# good: [16f533ade706d33e60324ff32e526bda20bccbd9] perf unwind: Use function to add missing maps lock
git bisect good 16f533ade706d33e60324ff32e526bda20bccbd9
# bad: [c6113f13957f918762d54080b2e2adbe0d7889e5] linux/export.h: remove unneeded .balign directive
git bisect bad c6113f13957f918762d54080b2e2adbe0d7889e5
# good: [d821f8a26efb6789666d70ce7a8f27df6c33c12e] sparc: vdso: use $(addprefix ) instead of $(foreach )
git bisect good d821f8a26efb6789666d70ce7a8f27df6c33c12e
# good: [9c65810cfb215f40f14d2c00694911fbc5408761] kbuild: deb-pkg: split debian/copyright from the mkdebian script
git bisect good 9c65810cfb215f40f14d2c00694911fbc5408761
# good: [5e73758b43c3defba2578df6d3a53e942fa6b41e] kbuild: deb-pkg: use more debhelper commands in builddeb
git bisect good 5e73758b43c3defba2578df6d3a53e942fa6b41e
# good: [343f74e7779c482c2fd4492cc6b45c64e18fe321] kbuild: deb-pkg: make debian/rules quiet by default
git bisect good 343f74e7779c482c2fd4492cc6b45c64e18fe321
# good: [0832e9bcfb0dc48833bbc8054cdc9b697afa8cd9] kbuild: deb-pkg: build binary-arch in parallel
git bisect good 0832e9bcfb0dc48833bbc8054cdc9b697afa8cd9
# good: [53bc4fa98f8dd5ccca9a8e038660bf0d30d9e22d] kbuild: deb-pkg: call more misc debhelper commands
git bisect good 53bc4fa98f8dd5ccca9a8e038660bf0d30d9e22d
# first bad commit: [c6113f13957f918762d54080b2e2adbe0d7889e5] linux/export.h: remove unneeded .balign directive

