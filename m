Return-Path: <linux-kernel+bounces-39784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F3F83D609
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215651C26730
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C1A12BF27;
	Fri, 26 Jan 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wg3/9hFa"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0D1C29E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258514; cv=none; b=c39l4GTptmlNKCYlDFTxhaqcSf9s6XYHF3dwZV1c+6PFtl5wPbZXn9MR3Jpa6w/9u+eBJei4/pnBPKwqVew42yRZ2Fp7t9QzoaketPoo8L5p7KeCDSH/+gh3aol2UKOF7BOo4v2dBN+Z7lyQ4Em1wSbAxon7tYwkclS6K/Y9zT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258514; c=relaxed/simple;
	bh=JnrnAWx1YmbnGWJzTzQmFlWxZHRMFnM3TZP+A72q7YU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hOApbdvKe0OwLw6wOJdDf6C2yqw1hansSzfSmk1WGGT1xZX0EELDDQ+HZGHAIOrmsjZjz+Wr3xD4++FM7f5YTVZOMx4PYMpe32Nhdjdc1jgcMCbZiglJq7Emz9Ur+oVZa8JF603l4oNaHzz2PLuvgGM2OSgJQnA9sqN9drsVdN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wg3/9hFa; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33934567777so143647f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706258510; x=1706863310; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHr39JH9ZAVO5s/Q6TxKvwEModPDg6RBhwecUYh/FLY=;
        b=Wg3/9hFaDCkdLyUec5JYl42eDyJad/ZiNHFB+I7Y33tpOvgYOyHN9JxjmzhTFYPX8z
         buimo5055u2Jkv+7S/U1IGgUg69HI3TJhwQYoy/2QVqdLEblr1ptLZKQeOGexnvm815J
         ddzgveqQDdp6TLre3Ffg27G16/aNGOgNtNu+azXpqhonhvJO3eFhM5IUR/JD7a/6lXpA
         ReuOlTqY+N5zc2rHe8rzaCHQTRRMHOH4lvECbY/MGQ6CA1B7uL6epECEbUAXwRsNY50c
         xcHz7/DfuBgJU0CWkzgXqhhhzHE4Y5osT530ZVylf1QTdAowQLyly3679d+EvBhZ+AZz
         Sc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258510; x=1706863310;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHr39JH9ZAVO5s/Q6TxKvwEModPDg6RBhwecUYh/FLY=;
        b=dKIrdgP6/nMZ0wchRmyVeOOQXz9U9eR+NjjACywytXO6YahBSZLjJSn3YnSHsuJTdF
         ZPTbi0BbAHtlyirHZhXVmdVsdNOZDfLpboX6T+8vO8+VwlsWz7Tvt4OS9h8auwVaJZX9
         7qk5EM9KXIvh5fRIJPUUaSf6BDLzCUVzw/M5+gEeilJku1AncYx9cQ/soOJn5nwKlwNw
         KxvwKZEgCL72Zf7xxlAumUpz3lv6gsjAKVX5kEs906yarQucl57WMyrTbjkJefed/3Yh
         qufX73FduyPFVU9SptjqR7HvXE4XMI71QlO1LqvjiRPFI6T5DVjID/qtCfPcs/34BWmp
         s9vw==
X-Gm-Message-State: AOJu0YxC0wApNPvMc3+B88wGpPlhv/TNUnpLD3Yg2go958f5+1rBo3vE
	plCsmAq/EUeP0qnuTEA/HWL1uEQmDozZT4dHEl4gZs/cxX8m3njdBv/FgbeBqMY=
X-Google-Smtp-Source: AGHT+IGODQTp1WGBJOYeb5QpU8MHe6FvpWAhmxNfECU8K2SX9RjwK0yxx8LAKL3RZy4pjkFNfgFKVQ==
X-Received: by 2002:adf:e852:0:b0:33a:ddff:7774 with SMTP id d18-20020adfe852000000b0033addff7774mr24330wrn.36.1706258510562;
        Fri, 26 Jan 2024 00:41:50 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id bt7-20020a056000080700b00337d4ce6ab4sm766097wrb.20.2024.01.26.00.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:41:50 -0800 (PST)
Date: Fri, 26 Jan 2024 11:41:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/i915/gvt: Fix uninitialized variable in handle_mmio()
Message-ID: <11957c20-b178-4027-9b0a-e32e9591dd7c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code prints the wrong variable in the warning message.  It should
print "i" instead of "info->offset".  On the first iteration "info" is
uninitialized leading to a crash and on subsequent iterations it prints
the previous offset instead of the current one.

Fixes: e0f74ed4634d ("i915/gvt: Separate the MMIO tracking table from GVT-g")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/i915/gvt/handlers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index 90f6c1ece57d..efcb00472be2 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -2849,8 +2849,7 @@ static int handle_mmio(struct intel_gvt_mmio_table_iter *iter, u32 offset,
 	for (i = start; i < end; i += 4) {
 		p = intel_gvt_find_mmio_info(gvt, i);
 		if (p) {
-			WARN(1, "dup mmio definition offset %x\n",
-				info->offset);
+			WARN(1, "dup mmio definition offset %x\n", i);
 
 			/* We return -EEXIST here to make GVT-g load fail.
 			 * So duplicated MMIO can be found as soon as
-- 
2.43.0


