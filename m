Return-Path: <linux-kernel+bounces-156892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D608B0A00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CD3281B47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B313115A4B0;
	Wed, 24 Apr 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVfQh2Kf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F302B156C68;
	Wed, 24 Apr 2024 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962956; cv=none; b=LhYZQwHq0WvvMY25Vfy26+GS5HDfG6WEYGV/01akssRzY2lSrM7h/rIIA/thPkMD9LvEAM6a5nshzEAN0PKHH+IrZWJYi/8T5xeDHOfWolJfQTWJmTseYwYf/+pgX5fCO2mvgjEmitxWcztWDgI+fHw3ufiACVw7cmTEz/66bGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962956; c=relaxed/simple;
	bh=Pe/8rKv+51DI3a+CqP2y5vGWwqMpYTxCESRC+dNeud0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IS/gYiQTehZvFiffLX1Ss/jPlXxqjC+8CyYDNkh5Dnehg0yS1PY/3kl345EdHFz/e/TGlHzrzEgY3NY+hu3EQINayCFZ4lqQmovlMG6YOdH5lIeRZP0VyYcsav9rZlIMod2QFtdLgyYcTkMw/B/wF3bA3r9Sc5T8QVQTv53L9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVfQh2Kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02837C113CE;
	Wed, 24 Apr 2024 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713962955;
	bh=Pe/8rKv+51DI3a+CqP2y5vGWwqMpYTxCESRC+dNeud0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVfQh2KfvE8HUdB+INEHukSpOt9vFPJxwWKhk4KU2wYbdRi8whAsTxEWBvgr7hVuk
	 q9uuP0FXGjlQgM/7S8UbYNy1aBO7YiDjzN5amjAT1+nFDCcjrmZ+/4FftCZbiTgDLR
	 PPQj+sWirUje66HIN6F+YizQLjVjL+HK/roCyB2bPJW+N/gxw43rvUo3S2yupQUJVI
	 u/qEXznTu22G1EOUcS5dbyxeZH/5CbEgrLJZd92/GcfO+wI5/Rl002kNeTNhai3Kb5
	 jngpWh4Y+Ui0RgtJ4tSpEO2A4I3MyHPzvZqT/hJ901fHPH/9fGu8LvetHpPUhNoQLG
	 6+dOxDrRD+3yA==
From: Christian Brauner <brauner@kernel.org>
To: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: xfs fixups for the fop_flags conversion
Date: Wed, 24 Apr 2024 14:49:06 +0200
Message-ID: <20240424-parameter-bekam-55dfd6f34ce6@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423124608.537794-1-hch@lst.de>
References: <20240423124608.537794-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=brauner@kernel.org; h=from:subject:message-id; bh=Pe/8rKv+51DI3a+CqP2y5vGWwqMpYTxCESRC+dNeud0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRp/D/MuSw0Is9A6fJ+NhGOV4tOGEtvt/32zdwgyeAAT 2U079zOjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlU/GX4p/GpYLXaF14WueAJ gelNcrHFT99O/7401Lv2xNZZGZs3/GBkaD06JVHF4o9iR/PrM9xrz+0UDdXPKclsEO2WNLn95J4 4FwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 23 Apr 2024 14:46:05 +0200, Christoph Hellwig wrote:
> this series against Christian's vfs.misc branch fixes up pointless
> harmless but pointless over-declaration of capabilities for XFS
> directories.
> 
> Christian: the first patch would make sense to just fold into the
> original fop_flags conversion if you're still rebasing the branch.
> 
> [...]

Thanks for the fixes! I didn't fold because it would rebase a lot of
other stuff which I'd like to avoid. :/

---

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

[1/3] xfs: fix overly long line in the file_operations
      https://git.kernel.org/vfs/vfs/c/19e048641bc6
[2/3] xfs: drop fop_flags for directories
      https://git.kernel.org/vfs/vfs/c/f50805713a6e
[3/3] xfs: don't call xfs_file_open from xfs_dir_open
      https://git.kernel.org/vfs/vfs/c/652efdeca5b1

