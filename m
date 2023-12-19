Return-Path: <linux-kernel+bounces-5233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3738818846
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904DC287230
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820411A5A5;
	Tue, 19 Dec 2023 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLLRjAtY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94151A286
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EED0C433CA;
	Tue, 19 Dec 2023 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702991235;
	bh=dDa8HGYYMKaUJHXbo4gPTqDJdCPvsm8/sJAF+uyYnz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLLRjAtYFN+GJhGaM438RoklTOgEtiU89OchSbVBwGcO1a62xiz3qepwjoDNCTMRS
	 kFpBy8AIIw3jpseWA6GtvwKV5FVlUkqEHsWCwUVVvoaRl9VhfmX03GeCyOKKKtAqqG
	 UPUcC+JVMwnlsPX/4LR2VV6wcofNSEceeNfSYBlNL4G3JW7YNiF74zAMRSBW+EvvVK
	 V02pAvpI4zbxG76rmCtCPFlRThqYUeIyQ5UeQa2niPmBvRD+yoK/vXfg1p2mjlQRZQ
	 zqdxbO997rkHyO7HIOx4ghXDrdYgoE0YQg/NffzL9BEwaEzPYksBG3bx04p4PMgNLN
	 rBe1wGw5kyb5w==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-ntfs-dev@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ntfs: dir.c: fix kernel-doc function parameter warnings
Date: Tue, 19 Dec 2023 14:07:08 +0100
Message-ID: <20231219-lockruf-passt-c4ac862c57cb@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231219045414.24670-1-rdunlap@infradead.org>
References: <20231219045414.24670-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=brauner@kernel.org; h=from:subject:message-id; bh=dDa8HGYYMKaUJHXbo4gPTqDJdCPvsm8/sJAF+uyYnz8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ2Tq0W7N7/XWSmyN878/dJCv9bEMI2ZWPjx7ULt9eve xW/4BfPwY5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJmD9j+F8R0rW3R2B/jNpE h392E1yTZKWus2/6KHo3Y/Etb73rTQYM/8vWG89y9D56cM0az6aVj0pZJ6/dZWNTdaREr7FpnUP 8TwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 18 Dec 2023 20:54:14 -0800, Randy Dunlap wrote:
> Correct the kernel-doc function parameter warnings for function
> ntfs_dir_fsync() to prevent the following kernel-doc warnings:
> 
> dir.c:1489: warning: Function parameter or member 'start' not described in 'ntfs_dir_fsync'
> dir.c:1489: warning: Function parameter or member 'end' not described in 'ntfs_dir_fsync'
> dir.c:1489: warning: Excess function parameter 'dentry' description in 'ntfs_dir_fsync'
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] ntfs: dir.c: fix kernel-doc function parameter warnings
      https://git.kernel.org/vfs/vfs/c/be4887a964e2

