Return-Path: <linux-kernel+bounces-978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168308148CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ACA285C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D52E40B;
	Fri, 15 Dec 2023 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9hDPZOD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4EF2DF98
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA9AC433C8;
	Fri, 15 Dec 2023 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702645993;
	bh=95CxUUbPl1kIpQU5C4sC9NMgOhe+jHAIEUlCPWtuLMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q9hDPZOD0ZG7crnWA7ninOmRAjnXcZET6FUJyxW2/SK6lwe/+Oz+CbM3q9KXr6auW
	 TwSRowOnABbwoDeYttl6dbRlIYY+hAsZowOE+c/c4wpKH6GH4nmXg2jqSkt+LuAAMW
	 GX7kKthJszfrj6vA/W5XXy5mNW/a8vOmHs0p7Mr9FLVUkaSp8rGrPWmZfgn2Y2qnvD
	 NGd+NQ7C0vCBFPQCuRKSJrUUW0Ufxm0TJ0Zcbh5HfucwqppRBmvvAffl54Nz7WXnyY
	 v+DgaxLVrmGvqlJA4ikDG3VhkF0YILu9iZcComapnwsQ/uHyPgMIyGjfZC9S4lpfR9
	 fpzdOooXjG5YQ==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Donald Robson <donald.robson@imgtec.com>
Cc: frank.binns@imgtec.com, matt.coster@imgtec.com, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
 daniel@ffwll.ch, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20231213144431.94956-2-donald.robson@imgtec.com>
References: <20231213144431.94956-1-donald.robson@imgtec.com>
 <20231213144431.94956-2-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH 2/2] drm/imagination: Fix error path in
 pvr_vm_create_context
Message-Id: <170264599089.449619.14263811622575523526.b4-ty@kernel.org>
Date: Fri, 15 Dec 2023 14:13:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Wed, 13 Dec 2023 14:44:31 +0000, Donald Robson wrote:
> It is possible to double free the vm_ctx->mmu_ctx object in this
> function.
> 
>     630 err_page_table_destroy:
> --> 631         pvr_mmu_context_destroy(vm_ctx->mmu_ctx);
> 
> The pvr_vm_context_put() function does:
> 
> [...]

Applied to drm/drm-misc (drm-misc-next-fixes).

Thanks!
Maxime


