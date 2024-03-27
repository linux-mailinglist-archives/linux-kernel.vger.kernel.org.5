Return-Path: <linux-kernel+bounces-122036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F91D88F10B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EBC7B22AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1435153594;
	Wed, 27 Mar 2024 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jvegs6pu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34FD153506;
	Wed, 27 Mar 2024 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575276; cv=none; b=o4xnKmmlCW9d86svYmDlPXMjxPL7/jypjz1IGjI0gNqBK9exixfpaL3WBx5MqnOZih1D+YBNunz9377mUJV000Hy30M4dQVmTS+dla8fU3+1YsCJVTigXEnUIxAdIUXc3gqDyA3JSfJEZFdOk3B8yQEmuWVuSZ6W+b8BGghwXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575276; c=relaxed/simple;
	bh=1PQshf9oLNWymLSf6XO3y7JgS+i8nEM66r2+FQV9ULo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fA93II9XYB4Q6gcjhLdRw098ECwZ956TnPyb1Fsor3nemKBxXqyFxi+wGjZEPbJUQA1RvpgV9055hkSc54yrP+lSDbye/vSpkrO7VfCInSPMOkq0RSrLiXlqRnq7SUyGr1v+ypdA9rrGcXfM6WaATzgj6G26el1jnyldEOGalEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jvegs6pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E9CC433F1;
	Wed, 27 Mar 2024 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711575275;
	bh=1PQshf9oLNWymLSf6XO3y7JgS+i8nEM66r2+FQV9ULo=;
	h=Date:From:To:Cc:Subject:From;
	b=Jvegs6puaU3ogoSLYQKoKNWCNQ6kIUZDdOMAaBshLPxcwoXmWcJrPAuYR1j6jLMMu
	 HJplGER0DDwE3JKIdBeZ0Y8E0r50M9Zy1moMJ7iQWcs7HovPY4OkM9OZdtKb1jgj41
	 i8AY1s7e1WzJgvVL/2lq26bPEU62nRYiIUAx1tv1F6roxUmXbBqjzz7ZPLIqv1zC68
	 dgaf4wJlKOvSTTqeEet4hxrrXgF758Nn7Ijp+W092obLIsm3pTnSY2yeYg/XtgPUsg
	 4ujBtNP9gOOkBhhgfcw9/OBEJOt0EGgh9cEJDIW6ErnT0v/tzccje4KtFx7Zi5afZB
	 6YYgIaMuGGnxQ==
Date: Wed, 27 Mar 2024 21:34:14 +0000
From: Eric Van Hensbergen <ericvh@kernel.org>
To: torvalds@linux-foundation.org
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs/9p: fixes for 6.9-rc1
Message-ID: <ZgSQ1nvIyOGm4oCD@3f3e8491d9e9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fsdheo31eKupSjQ5"
Content-Disposition: inline


--fsdheo31eKupSjQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-fixes-for-6.9-rc1

for you to fetch changes up to 6630036b7c228f57c7893ee0403e92c2db2cd21d:

  fs/9p: fix uninitialized values during inode evict (2024-03-25 14:16:06 +0000)

----------------------------------------------------------------
fs/9p: fix errors found in 6.9-rc1

Two of these fix syzbot reported issues, and
the other fixes a unused variable in some configurations.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

----------------------------------------------------------------
Colin Ian King (1):
      fs/9p: remove redundant pointer v9ses

Eric Van Hensbergen (1):
      fs/9p: fix uninitialized values during inode evict

Lizhi Xu (1):
      fs/9p: fix uaf in in v9fs_stat2inode_dotl

 fs/9p/vfs_inode.c      | 16 ++++++++++------
 fs/9p/vfs_inode_dotl.c |  6 +-----
 2 files changed, 11 insertions(+), 11 deletions(-)

--fsdheo31eKupSjQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElpbw0ZalkJikytFRiP/V+0pf/5gFAmYEkNYACgkQiP/V+0pf
/5iD8w/9Fvsajqg3iejO/THhQrSpkhkVZ0avnkJaiBwXSyFTxausYRx6VBV51JyV
kWN52e16kXsJk8wiCfPIwZgPScgXBTzF/OOQYCvY50d9EsMJPI40hvTg5Xnb2fbA
GIxcmacPY2szUIRYYW4pH8URYPk5yvEkUbgx/9DK+pmRLoH++7Feb82xcVO/zLob
lA/wCA6qNSHpfLfC/ISt5kI2w5xbcLn87XCq3+14CViFTXhemp+zRLmzQ4PRGzxy
0Jl3d+txsOkt0QQorEtXacuWQiaBK54x6LtwLXLiZ/nZ34t5Iwk+vfsAbzp0L8Zu
w5JgZ4zGKJffTXTRBH9f61zMh6iJbsFmBGPVOFwH6Aoz9lWWVOH5Qm1OcHdePNqE
2NwiLpTpVh3h+6NCkTy6OaMrTjpt2IMotVJE+9+lr0SOe6G5ewYF0xlVeVEwXxAc
8ukjGE2e7DxpPVA+CApHp+ZpKBbrYfkO6oTH1xrpgrOfZc9K8l0WnS76tIln3pli
KaZ7KvqQ2OjI4W2ZGhfDg+8yEATflov671jnVf8fmqQJcxOQojunxlkMmLIrijuI
FWEoodFNSc1noJnRAhsoYAXuRqDqX+HkizmUVrVQMWLgSUlR4t14gP+AJYnvkQW/
Ym1qmuTQfrgSQqDbhHXUR0bCVQS5sW5fVFH51yW9mB9P8Fn4PZc=
=6gdx
-----END PGP SIGNATURE-----

--fsdheo31eKupSjQ5--

