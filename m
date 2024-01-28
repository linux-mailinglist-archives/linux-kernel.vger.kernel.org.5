Return-Path: <linux-kernel+bounces-41569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765C483F4B2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0D71F21D79
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34A4DDDC;
	Sun, 28 Jan 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLSFleWS"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89DDDDA5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706432682; cv=none; b=YVIVpI7RgNoU2fvnCpE/Ov31gtqZQ9lqb1dIYMjVFKBCVsSR2qezTFdN0djFdZAtBpBaU0CXFRa8V2tR6G6kDLLWRzTXW9qYJKLi8odvEeNz582tVqETbDphRuwdSrpvS0ShWgivCSr3ZUZpEyOKZAKDVGoDGubiWCxYH5kGaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706432682; c=relaxed/simple;
	bh=UL/GspxwOSujHJz1YNLgkqHEEABkTVuJDlLqZ6QUzz4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PzAqEYVIrIp1XneILz/GkSKlBx7kmlBcZ9Rm8Tta+BpScRpQVqZQVsET60CszVbyMj1K0QcMEEoZNz/gNA4Ky2MzIpdgz18UD9TpOcnibpiIGU8McW3fY31tu3PyO6S+q37nDsbTyRF4/kFPA2gILRhrfxOLGNePtcQcYakujxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLSFleWS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a0ba5098bso13798901cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 01:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706432679; x=1707037479; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tl12HUX4uU642Pm0XD/FsExYrprZs5KqQHYM6NQv7yw=;
        b=VLSFleWSIif8gsG+niK+YmBlTiYLIm0kgxeoFI55d1GBX4UXf3XsOJpTGi74pNGaiQ
         8723eCv3fKOHJSnWe9jz5EpefULsYiYjDRGokCPmmv57bbafF/bH/wqkrKn7gqgrD4vr
         Vk9q/ondJVpSdagZUDUniD/l/zcsPlNgQ0emz8gzgSMwv/cNdl6qoSly622mV1rhQvLj
         g82kqXd6AgS/T2u6YLSUrQods+ezGxgyFwufU9IA42TlIxPQdiWtGMsC6ftH9jjPWfjN
         Kcq9J9YY8CsK/wnizNCtIPbmoNQ64VaetHu8SSAOpojQPp7llqqqsCsTv9CgoF7XsQZz
         DB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706432679; x=1707037479;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tl12HUX4uU642Pm0XD/FsExYrprZs5KqQHYM6NQv7yw=;
        b=pINqhZUpm3e1B29Zeu0Nkkzxk3j9hOWepndYmpUn7/AiXavgPAtceP0K6/WUzhllqV
         LaTLQhxRSOVwI/DsDdXjF0zLLY3RG5WhIfallE0+S+fJ/bifcP3eQuBUKyWVkqH1b6uO
         SS7i1zoBNWjbke2XLT5Lmsdb4jSAxxq7kmSbi4FLIZXKfSDo1lo+7nb0NPx38z6YJHpI
         10zYv0Z2kZhegC42NisAwAfcFQ1IWt6fjhSWTWdeecjjwuJfkJs6Xh6jXXE3PmiC4OzD
         6bATKRkXVz250GYBBQZaQq2mrPL+MU2RgFnZuLoW6I232+yeN+hAoRVP6sfIXv32Tiq6
         I0jA==
X-Gm-Message-State: AOJu0YyvfToZ9mCrsyRuLCf7gtxRIO0xZ8TqZ2RFmwug894xOYqc0zvN
	1gRmVURqzav1gwkQFYxY50f+3MYdyN5+gh0KVRgQxy1MKKP/NCk=
X-Google-Smtp-Source: AGHT+IFyTE09o/xWHMwQXLRQeWK4UyZ7mKRESG5vo897/5dTOfLsZ+QnKmU9/J0QcLWgtItYdBAXtw==
X-Received: by 2002:a05:622a:1050:b0:42a:6860:4b5d with SMTP id f16-20020a05622a105000b0042a68604b5dmr4062236qte.91.1706432679336;
        Sun, 28 Jan 2024 01:04:39 -0800 (PST)
Received: from localhost ([207.181.197.26])
        by smtp.gmail.com with ESMTPSA id kf13-20020a05622a2a8d00b0042a9a2e43ffsm709108qtb.92.2024.01.28.01.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 01:04:38 -0800 (PST)
Date: Sun, 28 Jan 2024 03:04:38 -0600
From: Lenko Donchev <lenko.donchev@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Use kcalloc() instead of kzalloc()
Message-ID: <ZbYYpky2sb8p8hjx@nixos>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows. Here the multiplication is
obviously safe, but using kcalloc() is more appropriate and improves
readability. This patch has no effect on runtime behavior.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
Link: https://github.com/KSPP/linux/issues/162

Signed-off-by: Lenko Donchev <lenko.donchev@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
index 5c9a30211c10..b67cd78e7c58 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
@@ -164,7 +164,7 @@ static void dpcd_extend_address_range(
 	if (new_addr_range.start != in_address || new_addr_range.end != end_address) {
 		*out_address = new_addr_range.start;
 		*out_size = ADDRESS_RANGE_SIZE(new_addr_range.start, new_addr_range.end);
-		*out_data = kzalloc(*out_size * sizeof(**out_data), GFP_KERNEL);
+		*out_data = kcalloc(*out_size, sizeof(**out_data), GFP_KERNEL);
 	}
 }
 
-- 
2.43.0


