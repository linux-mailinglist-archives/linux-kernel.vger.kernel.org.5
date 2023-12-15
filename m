Return-Path: <linux-kernel+bounces-592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D01F814355
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9CB1F23307
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975CF134AA;
	Fri, 15 Dec 2023 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvoo24Gv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6590111AF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so259724b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702627797; x=1703232597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0/MBCfdXawjZKv2ZV3awmKhfLQGaRPuP5dSW02Zx1g=;
        b=gvoo24GvDl8ETyUAUFrlXXuZPAf1aFYlVIvZKLt2W5aIXoSr5EY2i1FdKlqs6vJRtC
         qYo8e6L3MtrZsiR0gsVxzwmN5/tDqBOKqI05wZEeUeXPQG67wRW5E+HJ5y2FfJXiF5p5
         WrjSvT5koJfoSRxOpgI3A9N0MjBMxKefs5ipNNpteH7YunD3WAN71O2oxsA29qiUGrg7
         cEa0UPr2O+4ak2d3t4r2kaMxQJZ9PXh97xEvWV7frtakylVEuSBklzLriSwwEhLh1Vju
         Wv6zr04Gh5H8o5d0I/JCldmvAP4AvbR842uSo+chYDg412uqtvJivNDbB0T4lJBiUn5z
         1JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702627798; x=1703232598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0/MBCfdXawjZKv2ZV3awmKhfLQGaRPuP5dSW02Zx1g=;
        b=ChfGnNby6IcnFkedKZzoQqSMZ175C0bUSS0gk0FBULgmVc/qLyyUzo0wYPPxFSiI5j
         wL74s/bRhX5cJnxx67BqLcExEfW0KesTy8HNfZbmN1PKghaUtW2L+hYxa/EnwkA+LfkX
         vmjpz8DH1ns0ixHbO8BlCL3FqnEz/F9UW6EnEJx2WnJh4zHdSreUBSx7FjhadPHW8VSG
         w39Jyj8oaa5JPGANVaMAwgNnC7dbOuIZmbZReAO6Sh9ERa6ympep/UfS33zpg9ya8/xr
         IJTr+bCAFqzSe3RaDRD8UOG2I6Gg/2pHBlLGDPSllK+GsLhWl9rWzXcDwIThuCW218tE
         qf8g==
X-Gm-Message-State: AOJu0Yx9/UDyhSAF+iaiiRBsuQ+Qh77bKIP/SvuV7WC975YSVFlqp4Nx
	9D9KXqViDdd0EPbXiSmQBrKd4iiSXbQ=
X-Google-Smtp-Source: AGHT+IFJGQnjFgAMnUCZUi9/NN5yXdMK/QUUi/s5YLp19cYbU54DBnzCc7uUZLehiHETGePvX24pXg==
X-Received: by 2002:a05:6a00:6c9e:b0:6d2:6918:d039 with SMTP id jc30-20020a056a006c9e00b006d26918d039mr2591566pfb.22.1702627797500;
        Fri, 15 Dec 2023 00:09:57 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b006cee656cb35sm11783792pfl.156.2023.12.15.00.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:09:57 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 1/3] kexec_file: fix incorrect end value passed to kimage_is_destination_range()
Date: Fri, 15 Dec 2023 16:09:08 +0800
Message-ID: <20231215080910.173338-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215080910.173338-1-ytcoode@gmail.com>
References: <20231215080910.173338-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The end parameter received by kimage_is_destination_range() should be the
last valid byte address of the target memory segment plus 1. However, in
the locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions,
the corresponding value passed to kimage_is_destination_range() is the last
valid byte address of the target memory segment, which is 1 less. Fix it.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/kexec_file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..26be070d3bdd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -435,13 +435,12 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 		if (temp_start < start || temp_start < kbuf->buf_min)
 			return 0;
 
-		temp_end = temp_start + kbuf->memsz - 1;
-
 		/*
 		 * Make sure this does not conflict with any of existing
 		 * segments
 		 */
-		if (kimage_is_destination_range(image, temp_start, temp_end)) {
+		if (kimage_is_destination_range(image, temp_start,
+						temp_start + kbuf->memsz)) {
 			temp_start = temp_start - PAGE_SIZE;
 			continue;
 		}
@@ -475,7 +474,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 		 * Make sure this does not conflict with any of existing
 		 * segments
 		 */
-		if (kimage_is_destination_range(image, temp_start, temp_end)) {
+		if (kimage_is_destination_range(image, temp_start, temp_end + 1)) {
 			temp_start = temp_start + PAGE_SIZE;
 			continue;
 		}
-- 
2.43.0


