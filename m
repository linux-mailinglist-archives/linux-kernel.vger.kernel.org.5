Return-Path: <linux-kernel+bounces-60628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F285079A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 02:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAE02852B4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 01:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03CE185B;
	Sun, 11 Feb 2024 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCy/MYyQ"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350915BE;
	Sun, 11 Feb 2024 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707616398; cv=none; b=QeB+7K8BSwogl2lW3JVQY/5nb9rxNdGMv6hUX5DTLkwvfWwTx8kg463/HDPee2/dZaiImczabTneXS61YMRYYSpMK7ZEAF4YDaitDkPzCOGMu4BOW3iUW6JB4noNFJO16zYUXJQcsNZluWZmqaDt7xbMl+zh/XeXjPesNhmEBYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707616398; c=relaxed/simple;
	bh=nuSzSl9gWOU7ThKVhsz/gLgGzU40+yE07LZq1v68Oyc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sIb5I4ZYv2IEq9/NK9jdu5D3ffJIWMFRuF2mW7dJZyLNBz3d2mxG0VGY7ZxaFvDQWPjBnWcKJoTje87ossUkKjhP333eFJn9ghEovv9xNcVVOTcDfaYgRNijlh7K9Mz9P6cUfe9r7Po7/i3PIuJUrKfMCsJZEwvtBP+cLyuY23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCy/MYyQ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-686b389b5d6so9487246d6.0;
        Sat, 10 Feb 2024 17:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707616395; x=1708221195; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1jV67d8m24PXZq1850zcH4U3UHNFlaMaq/fIupQAUA=;
        b=VCy/MYyQU+vcRyP6KfaJDM4e4frRffsi4M89h5jxeKJyE/idS/8UH2toVweA3Ew3dv
         tvcEToMmJfE2Kf61Bds1w2/v+KqwslUprDQFn5kobKKu/2H5+kkCa+nAILdI3nhMLcWk
         pVqPolRFuTi+zHLBJyUHSw7VamUcXC4IKMRBVYz/21ZGBgDc7+hIi4fkFcMk1KmMVvAW
         eFrl5fr8CjuoTA5Osp6RX823oDoB6DdcQ8T+EPQ8ePJV0J10MLiAstqIwsWp7Nkw/V3O
         Gvcl8uvvemjoZNseXCi3EiaQIOvVk/fxRdf5gMJ8HxB2LWQCBqeqYNRN7AzDDXqCJeM4
         EwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707616395; x=1708221195;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1jV67d8m24PXZq1850zcH4U3UHNFlaMaq/fIupQAUA=;
        b=uZ2eeKLkJ8Z9SMLxftBGw41cQc/3SZtyNvowPyU6jvBSm8AC9JZ6ZM6VbVI6rb6e4G
         +nQCnZS6voIfbVJv7QbLDDwcyYmsa5tRHr2QjeiMgMHKvB3w5wiitrUsLF1nCkQU2hn6
         tI2W9FM/uIiHHlnVRShGcoUfqaTWPWusFuJX+Bvmq+cyRmVWFDZ7zRnnHWeLJ4Cavj++
         Q31SCU+uXkVYnvOIktI+STai++mt5ibo7DwRjMaANSPil3v98AAERYhd+pOUBu8vYD2s
         57X4bJY9HZh12WzUV++K0mpi7yntEwE13Kvy2h5BXZKqSfzygWIMtvGUQfcnN4Dky/Gd
         nQ2w==
X-Gm-Message-State: AOJu0YwTIovF2PLFrqFEi06CrrRqJADCivtd8HcFEE3EcEw1ReWJn4g2
	6+ORYP9p+T4BDxgzK7qELNeIcHxAI1jz761OweRF/D3mlwFzxxrI5ur9+P/UeA==
X-Google-Smtp-Source: AGHT+IF3qzQja2kR2RYxGLqTqgS4IjK8n9nvUEg00vvn7W9qbbH4rgzdjr+GRq5k2l0JAplN2mPzRQ==
X-Received: by 2002:a0c:dd14:0:b0:68c:627f:ed53 with SMTP id u20-20020a0cdd14000000b0068c627fed53mr3608896qvk.59.1707616395646;
        Sat, 10 Feb 2024 17:53:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6O9Ebb21G/lrlgwem4+12w8w/ssoqnMBcmAlTA9/i7CKwYyO3yj/QoX0Faoum6H5Nkw2vH94Wf3fg5FDvLQEJZEqqle0mPfhEFd1PPREyOP8JHzxHt3gz62i7mRAJ+cE8u9Fzx/sHjNWoBqj9C3AmG7KUsfkMLKRnyqLoXBOXrCZYUMM=
Received: from localhost ([207.181.197.26])
        by smtp.gmail.com with ESMTPSA id mu19-20020a056214329300b0068ca3ed8cb1sm2285785qvb.73.2024.02.10.17.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 17:53:15 -0800 (PST)
Date: Sat, 10 Feb 2024 19:53:14 -0600
From: Lenko Donchev <lenko.donchev@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] fs/ntfs3: use kcalloc() instead of kzalloc()
Message-ID: <Zcgoighe07IahAV8@nixos>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows[1]. Here the multiplication is
obviously safe, but using kcalloc() is more appropriate and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]

Signed-off-by: Lenko Donchev <lenko.donchev@gmail.com>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3b42938a9d3b..d435446537ca 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2636,7 +2636,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		goto out1;
 	}
 
-	pages_disk = kzalloc(npages_disk * sizeof(struct page *), GFP_NOFS);
+	pages_disk = kcalloc(npages_disk, sizeof(struct page *), GFP_NOFS);
 	if (!pages_disk) {
 		err = -ENOMEM;
 		goto out2;
-- 
2.43.0


