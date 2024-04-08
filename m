Return-Path: <linux-kernel+bounces-135789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E41C89CB69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3ABB2BB71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109EA1442F1;
	Mon,  8 Apr 2024 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKWWwiT9"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E8143C7A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598975; cv=none; b=EOtsdWR9uBb22zptQ4KKbD3JbO1guEXIWSx0Ez/tRtByltbl+iTFnOu1mbZM/qwVTr6mA2g+Lsu0KS1rvKAthtYWR44FxYLUglWEf/8QxO24KSpzYQM25B+vwASxdGvVtO5dkioVA+RZ6u1Lw8MR9qjxod+X/GLbZo1mr9vm9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598975; c=relaxed/simple;
	bh=5dL/MEnI1xq0UisSXnTI6Hl/x7mbnGmtACpkR6LRW5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkKSiAC4NP9j+GwtMLfbNN6FVRehLXrEz/EAVjplRoSezGryUMVH28s7KgwFgqQq8sW/Xy8ywW9ozC//IUGLMdBz6s3S3B6r47OWU+KQBdXBf6hbZfdeJnYLBiW8Wy/yXwrs6u6/t/MPQlL5/khE8knr4jer1t8Jen0PcxyyyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKWWwiT9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso3022597f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712598972; x=1713203772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PVqd5K0SRGaVpj/BbPQME6uHdpenAhrgdHionnlOxzU=;
        b=TKWWwiT9l3WMhiZFn+co+pteHJTcElLiYJKnwVceX3zGD8IV2UmvEnqSnS3/owgrmH
         ZT/o7SFoTOnOYz3KS+FSXwzzE0tkse2AKdPRMZbR0dTPiW/a+PcWpoJ+aBJpNpOhRxic
         BGOYzexmv9V1dFE25kgBGshfow/sDCMykQoIZ8pnOLtUwa+cg8ZxVNJ3ZB602kjHCW11
         NNgqWaTWsLRGXA9jJSmm9+M60/Tv1vTeMBAYHxOXj6dcas96EIG+1ZcsQ8eOrHzhlVKM
         rdXXOU/ulclIVCP0SwP5XnvFOyA484WckrOGJvQcEHQft2SRSNa/0tQzkPQtWal+BSip
         1cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598972; x=1713203772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVqd5K0SRGaVpj/BbPQME6uHdpenAhrgdHionnlOxzU=;
        b=Yyh4VCFQU323x+KngGlX7Oc/DaPeaR0gyfZr8zqVdEEkFUU6rUaL79WX9qmlHyMluc
         BQ4DS1XfTIgXr3u2fOoSBZbj8eeJ41j5HldG0caWt+pGJ9arrJ7PLZGvXv1jQkdpdWsM
         2CdV/Uk8WibJH0PNE73a4phZNEN229zZYPUXwCKqna20GUbcBYh8Xb7ppzaf8vjEumk8
         8Ze1hJshs4ma4l8ygaBSUnCIr+hOPs/89Zw3VI8BGfhwdGFbDTeNhqZ/fSm02iOfljJu
         MfvnuE7GOfgtf54Ts2HGHCdak0zHbuNRLmsdHng+E0MD2Alqs7h9J1iKXeLi/fjEgh+x
         Ozxg==
X-Forwarded-Encrypted: i=1; AJvYcCWKM4otRaxYp8drJcMiqxr91Shnskj55w+2tpM0LvQEWQP5Aq1EKXYBsAqE6N+p0Ps4dfZjUqKzv6wLMxzo+3iCKNoSTL1eMjhY9ENg
X-Gm-Message-State: AOJu0YxK0d3Pl/4hMMug80TsGsRFFTxUh7kYLdm4lYoSRvrvLTEG3oWH
	AWlUuh6XSGM/Tq5nJOfjtqQCyDS/xItbPTWHnHSMv1Vn6D9fvLy8gEJ5rBJff9g3TM9WxamByx9
	Ql4/0hqXh5VpoC789Raah1iTW3KI=
X-Google-Smtp-Source: AGHT+IEBfcTwKbjIXNSE9gdl9yU2JjwleWoBgOieN5OFGOgrCuTtSC7v5ZDWG17SMfnwAHM10PxwQ6il59ulsNFxQls=
X-Received: by 2002:adf:a112:0:b0:346:1463:2986 with SMTP id
 o18-20020adfa112000000b0034614632986mr57905wro.57.1712598971194; Mon, 08 Apr
 2024 10:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAODyvywHfmeFJP_obZB=dWcaibH_1RRGX=+CSVwcdfjSLMbJ4A@mail.gmail.com>
In-Reply-To: <CAODyvywHfmeFJP_obZB=dWcaibH_1RRGX=+CSVwcdfjSLMbJ4A@mail.gmail.com>
From: broler Liew <brolerliew@gmail.com>
Date: Tue, 9 Apr 2024 01:56:00 +0800
Message-ID: <CAODyvywzsX3j55_pa1OWU_AFrVty4+HbtvTH4gLeLjj7mDuZAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove "num_pages" local variable in amdgpu_gtt_mgr_new
To: alexander.deucher@amd.com
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="UTF-8"

sorry, this patch has format problem. abandon. I send another email
use qq mail instead.

>
> amdgpu_gtt_mgr_new and ttm_range_man_alloc share similar logic, but
> "num_pages" in amdgpu_gtt_mgr_new is defined as local variable which
> is calculate directly in ttm_range_man_alloc.
>
> Signed-off-by: brolerliew <brolerliew@gmail.com>
> ---
> drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 44367f03316f..0c56e4057d85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -116,7 +116,6 @@ static int amdgpu_gtt_mgr_new(struct
> ttm_resource_manager *man,
>                              struct ttm_resource **res)
> {
>        struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> -       uint32_t num_pages = PFN_UP(tbo->base.size);
>        struct ttm_range_mgr_node *node;
>        int r;
>
> @@ -134,7 +133,7 @@ static int amdgpu_gtt_mgr_new(struct
> ttm_resource_manager *man,
>        if (place->lpfn) {
>                spin_lock(&mgr->lock);
>                r = drm_mm_insert_node_in_range(&mgr->mm, &node->mm_nodes[0],
> -                                               num_pages, tbo->page_alignment,
> +
> PFN_UP(node->base.size), tbo->page_alignment,
>                                                0, place->fpfn, place->lpfn,
>                                                DRM_MM_INSERT_BEST);
>                spin_unlock(&mgr->lock);
> --
> 2.40.1

