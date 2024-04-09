Return-Path: <linux-kernel+bounces-137392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81389E164
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3761F2193E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB51C155745;
	Tue,  9 Apr 2024 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="CpybkHqn"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415C15381A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683042; cv=none; b=FkFDkF+3oWwEEtA8Wm/p6IWalSiCHlR5uRkb6TLYVXJGpW8nCWjhdKn5NjSF16nzwLX3bYQfvrGlC23SkyF1wPIEPTo10PcBqP2h7po00PsKB1astjA3A93RMIW2/xeUaHhBNFOnMm+LPKnh3AumUMqAI5qjvV4UQ2QMTeh2VSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683042; c=relaxed/simple;
	bh=QUmjtRQ2Et38MbBGo7SgDrlnT4lS7whKAE/1mSeqn7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U+n+vIjlrdWte4S1p4Qprt1gF/z6fumYGI+/0FlwgSk6faGKgVlMnFYEbY9P7Ek46u7vQ04+kM7fLXYHrA30eWUvA4KP1pUjSJlW+wnDrZ7XWFi9USGDL+BtQdAB2LQNWuk6hdA4aVMOtfIe/hMKH58l4zJ2/nBuwmEM5ZmUoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=CpybkHqn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e21db621caso11808035ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1712683040; x=1713287840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MvWmgyGI74zEDpvJ6ZWhvtxho6GjxC+GaSfStZau1r0=;
        b=CpybkHqnh+cMqcx4v6ztcUXzzFFU/oH57MHSPturYFcr9ZgiO2ztTM1S8RAe97c+yA
         bLLttT3sdMBb7h+qttaqhCOoLM0YZvm9sIU0ELI7kBjbtjZFSXEJmccgXX+Z+0hvNYYS
         VRzDfIOiRNNaBCVcYIEaGb8odVQ5yI17LFQaA77KPIwi1JYxQ5DKjgO67n8k95Xo7Ri0
         NzusjRMIeiyIZGLqDmhfANL95dwSbkLp2RnRden79EqcpGe9avZQAH90CXG2Oi9tFB6S
         oY19pdNYnfPXA8SfYTW1QiVhO/qeXQjIXx5QMaerw3M3R2l0Ff4io/OvLtcaBgYxMWhp
         nqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683040; x=1713287840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvWmgyGI74zEDpvJ6ZWhvtxho6GjxC+GaSfStZau1r0=;
        b=A6KhBMvItDssneIfMIuA12fiPbUpKfkTOTh2spgM/TFN4CeVY6qrMjyCIL+qfUdnJ0
         sVDp/aOQoQF6seUMP1Zv6L/kd9sAm4yOLGC6tokcvVAuz46CGed9h8IJVs6axzDR+hT/
         cD6t6HEUKoaKLlrPkN0MXs1F2ialDS7sE+PwBbIqDxLZVypmwfm0Vy8wLO/Qv1YPXwpD
         DLJto+/ceyLuecRHdLBPkAE06lsUHlc/wqL5xnB9iEE8VgyZadKajyUOIkhd/7y761OU
         LVMWFzZnGlCzUEYj8W9T9RqRuWgyfZ10BM9dhdOZBLrrljsxMlvY8LAAISVbeuecpXE6
         dBPA==
X-Gm-Message-State: AOJu0YxbpDMnx8am7vl8iNOuLvuTmH+HhbmMU8XmS8tZ3dF6MRK13S9S
	4wFtx4DNB6QffLM2fprptHtVZi1Uhi8Jh9ENhxF1OyRcwFHjENp0hBGOi8aqlsRrLgBUPX0eelV
	G
X-Google-Smtp-Source: AGHT+IE+uWo/1PSkL4b+IFqjLiW//0Gj4eATqmnyNsUpcV6hTkTwemkJbc/CTdypoZCRvxXrA0yNRw==
X-Received: by 2002:a17:903:41cf:b0:1dd:667f:bf1b with SMTP id u15-20020a17090341cf00b001dd667fbf1bmr467291ple.0.1712683039836;
        Tue, 09 Apr 2024 10:17:19 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.165.229])
        by smtp.gmail.com with ESMTPSA id ja21-20020a170902efd500b001e0da190a07sm9134048plb.167.2024.04.09.10.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 10:17:19 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: buildtar: Add arm support
Date: Tue,  9 Apr 2024 10:17:07 -0700
Message-Id: <e7c14a0d329e28bdcda21376b54a43c85a4aaf3f.1712682861.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make 'make tar-pkg' and friends work on 32-bit arm.

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 scripts/package/buildtar | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index 72c91a1b832f..0939f9eabbf2 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -101,6 +101,9 @@ case "${ARCH}" in
 			fi
 		done
 		;;
+	arm)
+		[ -f "${objtree}/arch/arm/boot/zImage" ] && cp -v -- "${objtree}/arch/arm/boot/zImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
+		;;
 	*)
 		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
 		echo "" >&2
-- 
2.39.2


