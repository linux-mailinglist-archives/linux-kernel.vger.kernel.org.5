Return-Path: <linux-kernel+bounces-166939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D68BA24E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097D51F24038
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19131C688A;
	Thu,  2 May 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="kkmavty5"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51471C6602
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685224; cv=none; b=M/eSraT33/cP+3MvXT5bVA+fNKtYoqqEcjIGRvwHu6JWh8cKBkl8F31ykvRBBW56M0Yy0hIZ40EwnnpFk8JQzyvuMkbH8Cryu2WWZL4wE9Z0f36EScbtJTQy7KR0FNySvGJKHP/aJk6bUKN3o5jUKqWY/jdhRPvGq0N/j8cbWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685224; c=relaxed/simple;
	bh=FTwV9FJr3GNOMfmr7/ZF3Ka+WKG890demF0+p3F69iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atlzw004gzKJElr4npCPdwH1fuY7aFoIwBZSqpNRHlTI/B9T0V1dAVbtsiXPVJRGqH+O0cG8DSniyJPukSMt1r0zkALfgMmz0OyTDWI9X8WF2IEXykIXvTLkgBsO/mKlJutA9tcCclcTCEA+NiMwPM78VpA0z/TmmPaEekdGEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=kkmavty5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51a7d4466bso975012766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685221; x=1715290021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfhcsvhSsmt38RwfQsVzDR+KRnJI3LFvmZGFu2ShhZs=;
        b=kkmavty5nGOunby5dTAUBjBmExMvpvQO4XVCP4/OV1BfUzjsUn/QGM+At3mvrtDXKh
         x/xWdsYVCCg1AcXzjmHufFna9l/aknjTkKlY9Fh2FaxZPalhei7HzRZGw1TBpdNu9Xct
         wI4CUwXFjSY2Kug57qb1ioNvOTz0kUextcIcaorUWTKrlpbrl8rkRHfaXLcbXXSI4xPP
         QEwP5DN1hcx5/l05UX86zg4YeNNUV6QLz/TTjUDAOvEKGZwYbEpbwog+ANQhNp4JiNyz
         yWbM4WLSq5G9YXtWCx33DG/H0W8TvtBdrho19YMb2nLyY0GymD8RjaWo0Ks3g21gznQO
         msEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685221; x=1715290021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfhcsvhSsmt38RwfQsVzDR+KRnJI3LFvmZGFu2ShhZs=;
        b=a/Izy/PjcWBf8Jz5PXjkaNYeHTBVf6c5q82DF5yNxWnW2AYi83T4J1vpiJNmQW+nay
         QCqE5OS1SaSjkn89Nn/QZADMNpXwPMzns9gFk8Sqk9gdofiW9fh9dbt84o8L12U1IDgI
         AOT1v6ex4vgZg/PbVmiDGmSzqissC0QQKa5vskhrcPY8xeeHJe8oz+qp7UVi0bzlsF8j
         SAhOz+z9sgvdhQ+0Oj9ax/h0cT2XGrAZPa0bM1IMGK+oLjVo8dZRyLlmMHNSrpLZAyHk
         5rWtHTO1AdXAJe+GZLLsk10nkzYzXS0Zn+p2HYzcNb1u9bNGTfoFwPNn7QKs4FsYfz8m
         9+cg==
X-Forwarded-Encrypted: i=1; AJvYcCVtON5wZpcOFvbw6sNmwlpQMrvwgv0IAmNhoa7alXoFz+YBvYoABMyF0bkegQIH8hSUEWc2HL/dSn8nfznFiHT4IP0NInvyewLU3EzW
X-Gm-Message-State: AOJu0Yya8A7epmMEM7XbGaY4/9ZY8eN0D0bMwRtAxzL7JVTkqgpkgyXc
	TPRGSX1WQppP0hPKOmS0jQrrv+TSl7faYxg3TL2z68OHoO8rEEAnR0O6Oea5wok=
X-Google-Smtp-Source: AGHT+IHsnl7RJpj3ymJ81i/nNwARVNtUdevH3erTDDDAwNmlYmS3UuIDG1Pd4ArMQB2iLnX4wSe1VA==
X-Received: by 2002:a17:906:fcb3:b0:a55:5ba7:288a with SMTP id qw19-20020a170906fcb300b00a555ba7288amr430875ejb.33.1714685221271;
        Thu, 02 May 2024 14:27:01 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:27:00 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 3/4] overlayfs: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:30 +0200
Message-ID: <20240502212631.110175-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502212631.110175-1-thorsten.blum@toblux.com>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/posix_acl.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/overlayfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index c63b31a460be..35fd3e3e1778 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/xattr.h>
-#include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
 #include <linux/fileattr.h>
-- 
2.44.0


