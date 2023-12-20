Return-Path: <linux-kernel+bounces-6738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C2819CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE88B24A91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0270C20317;
	Wed, 20 Dec 2023 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCper4AP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8AD200D3;
	Wed, 20 Dec 2023 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5d3758fdd2eso44959817b3.0;
        Wed, 20 Dec 2023 02:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703067968; x=1703672768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sXgD/C7+n9GFUr4X32uVLAXUHnqozSqAdlFPze07R10=;
        b=hCper4APwEPAZnjqrit5sQNAaLuDYnaRLJU7Lw64qRJk7SB7ch3yPSb/lLOdB3gjFV
         yDKki6FA5BYgR5ngJN44HFqZ9hQKV+k0e9Fiq1nOkbAmACE/2kr+QNcWqgYEvJ8BawVS
         ZW8OiUekDXOn7yIzPAhBE3HeLV5f//xTiigCbmECJU3dvFzR4y5c9LqQdHNwXq5k+eZw
         ZDfVAjjpYzQ1YMXz9uQ0jF9vrhbM/lyf1WTQSHCYqLj7TegRuQBTPlvP08yC0gtyz1q/
         Qh4Ul2JmSB2/97URxL1m7BEiiBN51cJuu8OZyFxjrrET+bBTRTaMp2A3rG9eiLDayPkf
         Wkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703067968; x=1703672768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXgD/C7+n9GFUr4X32uVLAXUHnqozSqAdlFPze07R10=;
        b=O2hV679FCaJPe80p24CVLRISJqXO9m/ixvhnHf0D/vapcYWjebt/1FaAemIo2sO1ld
         vcTnscHvFGmBYfo1X9R/mnTQGHqtJvFxhsejvOZaJ+6JkWvo9H3jI6XoTUKJsw7yeStr
         QdilTWbrwbAWu4oGYDCb+bQWCgwpZZ13wignRCquN2H9eC5lSFZ+DSii25eKnCW1o0Q9
         rlc0AUNbqMJktOUgosPY7yKPYv/EwMq8DaXIcv/f3lxhm5hTud0yjLKQXps8uk0durwi
         p1FJ1RPI5gpYoAu3vRbPbdcV8BTXpOxYJxRHA5m1WlqLOyyWSFu25o8iLEYUjkNhCeVc
         AsHg==
X-Gm-Message-State: AOJu0Yyyu6fAQx5MXovXE16c4MdpbChP8dMp9dRIdTbaWUMN1JJ636G+
	YaGSz1QJPgxmkES9Xk3YqjU=
X-Google-Smtp-Source: AGHT+IGeddT4dJjTvsEa3kYxaAZB6sIeew+/3rqO/ux5zuyCj58aTqE7ACwDIao18P8BCdFRLjmczw==
X-Received: by 2002:a81:df0b:0:b0:5d9:1524:e315 with SMTP id c11-20020a81df0b000000b005d91524e315mr15319641ywn.17.1703067967969;
        Wed, 20 Dec 2023 02:26:07 -0800 (PST)
Received: from localhost ([185.215.181.26])
        by smtp.gmail.com with ESMTPSA id ez6-20020a05690c308600b005d997db3b2fsm446136ywb.23.2023.12.20.02.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:26:07 -0800 (PST)
From: Kevin Martin <kevinmbecause@gmail.com>
To: joeyzerocrash@protonmail.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kevin Martin <kevinmbecause@gmail.com>
Subject: [PATCH 0/2] Enable compressed files in EXTRA_FIRMWARE
Date: Wed, 20 Dec 2023 05:22:49 -0500
Message-ID: <cover.1703042081.git.kevinmbecause@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux-firmware packages on Gentoo, Fedora, Arch, and others compress
the firmware files. This works well with CONFIG_FW_LOADER_COMPRESS, but
does not work with CONFIG_EXTRA_FIRMWARE. This patch allows the build
system to decompress firmware files specified by CONFIG_EXTRA_FIRMWARE.

PATCH 1/2 adds decompression routines next to the compression routines
in scripts/Makefile.lib. That patch is then used by PATCH 2/2 to
decompress files before compiling them into the kernel.

The patch works by copying or decompressing the specified firmware files
into the build directory, then compiling them in from there. I would
prefer to not copy any uncompressed files, but I have not found a clean
way to do that.

Kevin Martin (2):
  kbuild: Enable decompression for use by EXTRA_FIRMWARE The build
    system can currently only compress files. This patch adds the
    functionality to decompress files. Decompression is needed for
    building firmware files into the kernel if those files are
    compressed on the filesystem. Compressed firmware files are in use
    by Gentoo, Fedora, Arch, and others.
  firmware_loader: Enable compressed files with EXTRA_FIRMWARE The
    linux-firmware packages on Gentoo, Fedora, Arch, and others compress
    the firmware files. This works well with CONFIG_FW_LOADER_COMPRESS
    but does not work with CONFIG_EXTRA_FIRMWARE. This patch allows the
    build system to decompress firmware files specified by
    CONFIG_EXTRA_FIRMWARE. Uncompressed files are used first, then the
    compressed files are used.

 drivers/base/firmware_loader/Kconfig          |  5 ++++-
 drivers/base/firmware_loader/builtin/Makefile | 16 ++++++++++++----
 scripts/Makefile.lib                          |  6 ++++++
 3 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.41.0


