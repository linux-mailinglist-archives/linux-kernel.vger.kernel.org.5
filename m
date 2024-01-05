Return-Path: <linux-kernel+bounces-17502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7E0824E85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBDD2848E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AD25CBE;
	Fri,  5 Jan 2024 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf8hki1g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA0220B16;
	Fri,  5 Jan 2024 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5f00bef973aso12830557b3.0;
        Thu, 04 Jan 2024 22:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704435062; x=1705039862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEfee24QFYlAljoy5Qvt9FbyO3OaSLMfwOgRzUUY4nI=;
        b=bf8hki1g6L3kf6768ioRTB2UxB32Uu7TRHmVw7+HVfv239TQlfcqgONbk+oWwY8LUZ
         JW+iw4vlFYSGhGUOsQBIeoRdCOMpcWvbDakuQ/GvTW6q6S0VMtS3nEtfuJ7IF3rz8rKf
         w7CkjFipb6r9huYV28OTlTtYirMTpTwX0FKr+nTaRdWHMAe8LZyaiit8qlXj1ZrJXAHq
         TZ/08+Bu1vN5wB0V7am7GDz/yZ0sM5ezuTMoE1kcthrNR9AZINavtSQTn7Hg0/LmwMLF
         AZX9Z6K4M9E0Gu2KQ+pKgJ/tEBzxy0CnEDMDD3L2Dj+5PRkpbPOiC8356Uc4FEE70dv1
         kiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704435062; x=1705039862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEfee24QFYlAljoy5Qvt9FbyO3OaSLMfwOgRzUUY4nI=;
        b=nCKF09KY5wCgFlASF2akeWZwGqvScleOvnZcD1RmWIS0Zvww/kAESkGGrUkgciLRP9
         xvXRQxmvURklSqjvcmmZCERjC7KtWC235OASNjyHjlpE5zYZ2X6K0egYE4vZipDtolJN
         UUt+XQVmBe+w0QNACfjdGq3y9L2RVck4MA/Yj/snFl565rNi44IUi54tMj3z15kG4flB
         oQcIAony57G0gvjEae61lu8D8BAsCVeem4+Jqt45V/aJi47CsrlpPNQlXqsf8xpbrHn7
         lPm/M6KeQ8/t1ozcXW699BgugatF8/712AS+doXsjhN/BAqZ7TWQvDRPNUVLv4cLMVIs
         zb1Q==
X-Gm-Message-State: AOJu0YzR+kQErExDz36/F+vvRmFSFAyc10Gsfxg7Se+uAdtbK2ewzYgp
	6qgLUhxrwJwWqrNEUhyHiLW2TpNbQGMkrA==
X-Google-Smtp-Source: AGHT+IEw4ja6fYfqVYXS4vwYeld8OIj5UGa1vVo5uynVPfi4EZjrHX4qZ9mn4pq7SLvFFMy1OvkerQ==
X-Received: by 2002:a81:5dc3:0:b0:5d7:1940:b398 with SMTP id r186-20020a815dc3000000b005d71940b398mr1566662ywb.100.1704435061656;
        Thu, 04 Jan 2024 22:11:01 -0800 (PST)
Received: from localhost ([185.215.181.31])
        by smtp.gmail.com with ESMTPSA id o1-20020a81de41000000b005d3a41adfafsm399269ywl.133.2024.01.04.22.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 22:11:01 -0800 (PST)
From: Kevin Martin <kevinmbecause@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kevin Martin <kevinmbecause@gmail.com>
Subject: [PATCH v2 0/2] Enable compressed files in EXTRA_FIRMWARE
Date: Fri,  5 Jan 2024 01:10:00 -0500
Message-ID: <cover.1704353568.git.kevinmbecause@gmail.com>
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

 drivers/base/firmware_loader/Kconfig            |  5 ++++-
 drivers/base/firmware_loader/builtin/.gitignore |  5 ++++-
 drivers/base/firmware_loader/builtin/Makefile   | 16 ++++++++++++----
 scripts/Makefile.lib                            |  6 ++++++
 4 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.41.0


