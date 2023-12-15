Return-Path: <linux-kernel+bounces-977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C28148CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE8F1F24967
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4AD2DB99;
	Fri, 15 Dec 2023 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5WXOQ5M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092892DB89
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3198DC433C9;
	Fri, 15 Dec 2023 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702645990;
	bh=Dehen5HnXFNaa3WfZmpIvUhDsZ5iy/FsmZyQTwq/+OU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B5WXOQ5McoHNvKHmRHggUXcrXBTdPajeiSwaFPgQaCVt9SJZ2x2uKwKiOFfmXH8ei
	 eT4tCs235k6op6X/zu3SRozD/NvvX+quBl0OUnUN8XRm7FkV5Mz1hAyZPF+Y9uHm/x
	 ejt7hC9TH93iNDegGptMMpTSSMNiSUmTeSLlk/2UGqHzzLUGsTGK1UaHiqHyRxFoTc
	 F10vtR2TWP9aWO8SWeDVykSIS/qmzVSynE/b2/DX0CZzqKp4Bv4PaBtruJoSQ5c1et
	 ScusWitNTeaijd159wDMHBBKbU5DvDDgLo4IvQWj8zhi2wCgrovq4C5NFSBq7xaXbP
	 COyc+GFQyD5Tg==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Donald Robson <donald.robson@imgtec.com>
Cc: frank.binns@imgtec.com, matt.coster@imgtec.com, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
 daniel@ffwll.ch, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20231213144431.94956-1-donald.robson@imgtec.com>
References: <20231213144431.94956-1-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH 1/2] drm/imagination: Fix ERR_PTR test on
 pointer to pointer.
Message-Id: <170264598817.449619.12909620922259107900.b4-ty@kernel.org>
Date: Fri, 15 Dec 2023 14:13:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Wed, 13 Dec 2023 14:44:30 +0000, Donald Robson wrote:
> drivers/gpu/drm/imagination/pvr_vm.c:631 pvr_vm_create_context()
>   error: 'vm_ctx->mmu_ctx' dereferencing possible ERR_PTR()
> 
> 612         vm_ctx->mmu_ctx = pvr_mmu_context_create(pvr_dev);
> 613         err = PTR_ERR_OR_ZERO(&vm_ctx->mmu_ctx);
>                                       ^
> The address is never an error pointer so this will always return 0.
> Remove the ampersand.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next-fixes).

Thanks!
Maxime


