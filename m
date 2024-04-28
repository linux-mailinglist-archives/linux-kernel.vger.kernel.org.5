Return-Path: <linux-kernel+bounces-161429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE748B4BE1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018C71C20C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2496BB4E;
	Sun, 28 Apr 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sE9CJOcT"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A06A35A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714309028; cv=none; b=RYOnnE5Zo7F9Ye/S8oy4pcQpgXAUYGiuPfOCtXLtO4gKiEkOjoOU9HvlqK8/2erJ2D9/I8KGg35b6WvikbgoaThvY81YJfeHV7tMgw+QgwFUxhdVUX/84ub9/2POpZxl3f0GT0F8ywR1NfzD30cesBEBpEobF8V8N8KB8sCsBnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714309028; c=relaxed/simple;
	bh=5Sg1IcsOjbxjfL3zgZHh2k8pdabOaB6L3F2mPfSkFPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G74534h94NouVhAl3klB3f9eGoHUUbnCvk/ssulhVukGJhitMy9oepY6/2kdICnzy0nydAyjSvTs68TzNM8QlDvEjoTvDCC2Du56EQS1RVq0OlYw2HikJO6CHoDnPPmsiW/dRjAKx6FMhAJ3GeT4AnfZKvy9S5huiuVUail21C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sE9CJOcT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58d0aea14cso261536766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714309024; x=1714913824; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ng058NZ9Nj+W4KweKWLHemyFc1EwGYUwsROdFC21IRA=;
        b=sE9CJOcT4tFXVkZUd6c8SdGiywZQLrjiI9duzOei9SJXz4GOZJ0JgNyfzi40tgF4Qf
         39/sy9EjEYQhrXzUXnbhR4U2i5Ji93JKfRAd47JnBjK1saojxsew0rTNoNam26a2q7de
         /sSy2Nocj3pA7O/FNHBNvKTXqoo7wrSwTQ3h7zigP/X6VJQzSBbaXsb6/fjG7GLpgn7T
         PVBjn2YE/tCWI5In00rEKLp/pMVntJfAjYbI7bkrt8dxSSq8BHHm6e5ZD4mL9p1HYNZR
         4yxkRGN69iJkxcGRHctKXAlGwkXPWC7tZBPidOc+b8Kq03uCLOKJuvzhdxP5KFo7r/bQ
         UZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714309024; x=1714913824;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng058NZ9Nj+W4KweKWLHemyFc1EwGYUwsROdFC21IRA=;
        b=qJ1uaCu/8Npuv+b9cq2injSVW6vpqIytg9sk2PA4MAoq16oDT3KosSZPK4O0EimbAz
         PUe1XK8RBA4esOEAPcZMHhY9ytWftD6+iqdg17oXHiq17LVf4/lltB8OaE5bvQoXboQo
         EZjCabfnW51xTIEzs6x0mAnrj7ygB4QO8eDni9GI0IcVsmf5u5OpDJ+fGhIP/05ZR4He
         uiJ39CTiT4WQ84Ggw+bILY3FvGdVd3Bwy0h4y5qqqWehrSTP2hgeU7QqLwYNSwRivbGT
         PLCR5Hu+LxUQFoVm3mSK63NDZif2LbO2Zm8DIKVe/oTVZW30IhZBrlU2tCytL5dXex8d
         oqOw==
X-Forwarded-Encrypted: i=1; AJvYcCWCQM+7fdasNKDEI6KDbo6ZM88flYFO9k7RV3iE2kFeorm9LVAbuRRmjCeTkU4irXOuZlZ1nKOF1SnKWRMsvXwaUYxp2ehA34K9YqMP
X-Gm-Message-State: AOJu0YwntU0f/Bar/Visad4F29D+puQ5eqMc6aV95ulz9UOcDBlkvaCf
	11NDXe6I2NKy174Aeyapz9kU37tlr7L3AzM4uV590lMZKUAzsT8eKqHiXVLAmZ8=
X-Google-Smtp-Source: AGHT+IF2bconLYEiVsCFSWzXhwOMR/6nTlbaxbFyyM1sjiNBblck1WsWiEU8lcUPzjFP3RiywB5d8Q==
X-Received: by 2002:a17:906:13c9:b0:a58:8fa6:df18 with SMTP id g9-20020a17090613c900b00a588fa6df18mr4813693ejc.41.1714309024203;
        Sun, 28 Apr 2024 05:57:04 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906315400b00a5591a644c8sm10726019eje.17.2024.04.28.05.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 05:57:03 -0700 (PDT)
Date: Sun, 28 Apr 2024 15:57:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bob Zhou <bob.zhou@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Guchun Chen <guchun.chen@amd.com>, Le Ma <le.ma@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix signedness bug in
 sdma_v4_0_process_trap_irq()
Message-ID: <afb229a9-3f18-44cb-b305-5fbb2e1b4ee3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "instance" variable needs to be signed for the error handling to work.

Fixes: b34ddc71267a ("drm/amdgpu: add error handle to avoid out-of-bounds")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 101038395c3b..772604feb6ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2017,7 +2017,7 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
-	uint32_t instance;
+	int instance;
 
 	DRM_DEBUG("IH: SDMA trap\n");
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
-- 
2.43.0


