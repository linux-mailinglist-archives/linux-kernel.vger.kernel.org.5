Return-Path: <linux-kernel+bounces-976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 972EB8148CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318DB1F2496A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E4C2DB6F;
	Fri, 15 Dec 2023 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHCHb5AH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453FF2D056
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76811C433C8;
	Fri, 15 Dec 2023 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702645987;
	bh=tuoQDVEvOc4yYofLOsac9XvmYp1ao3T0xlTQ8AbQp/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kHCHb5AH3+NMcS7GzCcQ6i5eMb8R4+mbVTuNYb6//iPDSHzMTaKTDfdlE6RWgnkXu
	 fnwG/yuVs6dnGqG56LR81EJ9Kg3ZSeV700QJ7qkM/4rNvBA1YMrpZY+kMDqKTqI+Kt
	 +4ezyU9PBP4ZSU5DFR/UnPelyeEYliBlGN4SNrVEyarjrK02gmGM4e4MCgDmFiHpsL
	 MjB63cTsKJn2lAqLTc95QMx1F7Fph7ByU3sTprr42dduZvugZsEsmvI7yw7zKDL1WS
	 hJHf2EK6mj4yL2Jm3+KiAYmugp7MwZqa6Vc9doz3Cg9Lu+JP0W79WLrXb1ekHpujit
	 yvqP2FLT2uKFQ==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Donald Robson <donald.robson@imgtec.com>
Cc: frank.binns@imgtec.com, matt.coster@imgtec.com, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
 daniel@ffwll.ch
In-Reply-To: <20231208163019.95913-1-donald.robson@imgtec.com>
References: <20231208163019.95913-1-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH] drm/imagination: Fixed oops when misusing
 ioctl CREATE_HWRT_DATASET
Message-Id: <170264598499.449619.5534546786451480094.b4-ty@kernel.org>
Date: Fri, 15 Dec 2023 14:13:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Fri, 08 Dec 2023 16:30:19 +0000, Donald Robson wrote:
> While writing the matching IGT suite I discovered that it's possible to
> cause a kernel oops when using DRM_IOCTL_PVR_CREATE_HWRT_DATASET when
> the call to hwrt_init_common_fw_structure() fails.
> 
> Use an unwind-type error path to avoid cleaning up the object using the
> the release function before it is fully resolved.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next-fixes).

Thanks!
Maxime


