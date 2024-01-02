Return-Path: <linux-kernel+bounces-14319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B812821B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50F8B21DAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC7CEAF1;
	Tue,  2 Jan 2024 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyhD/PyK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7BEAE4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25894C433C8;
	Tue,  2 Jan 2024 12:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704196914;
	bh=TC2BybdGdhXnRbuf72sR13qpV75OfNbk5lqpu3563QY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HyhD/PyKiDQMdfAp17SkoG33L29JAnarUg7RqDDXfDFWYXcZdJ23QqMx3uv/eO757
	 I4QGGZIgbgdxjytqQQ46pKVWpcuhyQWSE3SHM/X7QsQDv3RNZVaLwMWzNXLNaMvuy+
	 3P9PVhGs2fq7i/YaThNwHtMrOJAPpnkGqmoOKK18OZluVBKVNH8VT5xWlOB2cViaPa
	 bbQqtQGHwsARkhgur40N4gce6W8yxUx5EsG0WBlVKdfad2/gT3VpHgfI9NRY+4AuXu
	 Sm9ddOD7fJWXJH/ZWpxH8kRbyEUGMmZ15TQM8y7uO5BA4ipOjAOL+QryPoWnsifN3H
	 WnjHfmrYOBwiA==
From: Maxime Ripard <mripard@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 Jonathan Corbet <corbet@lwn.net>, Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <20231231054856.31786-1-rdunlap@infradead.org>
References: <20231231054856.31786-1-rdunlap@infradead.org>
Subject: Re: (subset) [PATCH] drm/gpuvm: fix all kernel-doc warnings in
 include/drm/drm_gpuvm.h
Message-Id: <170419691176.40444.10974951335864168789.b4-ty@kernel.org>
Date: Tue, 02 Jan 2024 13:01:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Sat, 30 Dec 2023 21:48:56 -0800, Randy Dunlap wrote:
> Update kernel-doc comments in <drm/drm_gpuvm.h> to correct all
> kernel-doc warnings:
> 
> drm_gpuvm.h:148: warning: Excess struct member 'addr' description in 'drm_gpuva'
> drm_gpuvm.h:148: warning: Excess struct member 'offset' description in 'drm_gpuva'
> drm_gpuvm.h:148: warning: Excess struct member 'obj' description in 'drm_gpuva'
> drm_gpuvm.h:148: warning: Excess struct member 'entry' description in 'drm_gpuva'
> drm_gpuvm.h:148: warning: Excess struct member '__subtree_last' description in 'drm_gpuva'
> drm_gpuvm.h:192: warning: No description found for return value of 'drm_gpuva_invalidated'
> drm_gpuvm.h:331: warning: Excess struct member 'tree' description in 'drm_gpuvm'
> drm_gpuvm.h:331: warning: Excess struct member 'list' description in 'drm_gpuvm'
> drm_gpuvm.h:331: warning: Excess struct member 'list' description in 'drm_gpuvm'
> drm_gpuvm.h:331: warning: Excess struct member 'local_list' description in 'drm_gpuvm'
> drm_gpuvm.h:331: warning: Excess struct member 'lock' description in 'drm_gpuvm'
> drm_gpuvm.h:331: warning: Excess struct member 'list' description in 'drm_gpuvm'
> drm_gpuvm.h:331: warning: Excess struct member 'local_list' description in 'drm_gpuvm'
> drm_gpuvm.h:331: warning: Excess struct member 'lock' description in 'drm_gpuvm'
> drm_gpuvm.h:352: warning: No description found for return value of 'drm_gpuvm_get'
> drm_gpuvm.h:545: warning: Excess struct member 'fn' description in 'drm_gpuvm_exec'
> drm_gpuvm.h:545: warning: Excess struct member 'priv' description in 'drm_gpuvm_exec'
> drm_gpuvm.h:597: warning: missing initial short description on line:
>  * drm_gpuvm_exec_resv_add_fence()
> drm_gpuvm.h:616: warning: missing initial short description on line:
>  * drm_gpuvm_exec_validate()
> drm_gpuvm.h:623: warning: No description found for return value of 'drm_gpuvm_exec_validate'
> drm_gpuvm.h:698: warning: Excess struct member 'gpuva' description in 'drm_gpuvm_bo'
> drm_gpuvm.h:698: warning: Excess struct member 'entry' description in 'drm_gpuvm_bo'
> drm_gpuvm.h:698: warning: Excess struct member 'gem' description in 'drm_gpuvm_bo'
> drm_gpuvm.h:698: warning: Excess struct member 'evict' description in 'drm_gpuvm_bo'
> drm_gpuvm.h:726: warning: No description found for return value of 'drm_gpuvm_bo_get'
> drm_gpuvm.h:738: warning: missing initial short description on line:
>  * drm_gpuvm_bo_gem_evict()
> drm_gpuvm.h:740: warning: missing initial short description on line:
>  * drm_gpuvm_bo_gem_evict()
> drm_gpuvm.h:698: warning: Excess struct member 'evict' description in 'drm_gpuvm_bo'
> drm_gpuvm.h:844: warning: Excess struct member 'addr' description in 'drm_gpuva_op_map'
> drm_gpuvm.h:844: warning: Excess struct member 'range' description in 'drm_gpuva_op_map'
> drm_gpuvm.h:844: warning: Excess struct member 'offset' description in 'drm_gpuva_op_map'
> drm_gpuvm.h:844: warning: Excess struct member 'obj' description in 'drm_gpuva_op_map'
> 
> [...]

Applied to drm/drm-misc (drm-misc-next-fixes).

Thanks!
Maxime


