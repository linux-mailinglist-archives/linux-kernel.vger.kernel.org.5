Return-Path: <linux-kernel+bounces-104559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3A587CFD9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631CB1F2396B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAF43D0AA;
	Fri, 15 Mar 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpE75CBY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDD3D54D;
	Fri, 15 Mar 2024 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515406; cv=none; b=HYeGge11s0V1OQQQs/kHLZqUu2YZMHC1IxsXY7reRA6AC0nT9xgFK4JsuJqhHYVIppo0zZn13x0QoOAvoNoiFmLbL0Coi6G90EOKPpqkT4wnsV6cvghUTckgKes9D6V5ymYTYXCfK9e9ZnzdmRWatAT5YdvGC7g+W5o5XREsFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515406; c=relaxed/simple;
	bh=uYDbJVk8kmGVv37g2Kut/IcJsn7rfQBGO9Ym1rJ+eNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=edKz3NbhROfwxQX6nJgMddqfYWAkuKqICDFsenFUUT3duOXrZjIXV2VlPY40o5QfErAzej3MFCDecDcid2/WQ4X+MdN/OUwxO4mmQQtZdLJ33nhcQI27BmXftNQnL8iBfHmcTufaJ88DwVwCWxxWfOlyrA3Zw/zcEn4VHxX35qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpE75CBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B49DC433F1;
	Fri, 15 Mar 2024 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515405;
	bh=uYDbJVk8kmGVv37g2Kut/IcJsn7rfQBGO9Ym1rJ+eNg=;
	h=Date:From:To:Cc:Subject:From;
	b=fpE75CBY9n8U9bly8C834tBpcVvKkvnw9TJRxNB4/Wl8jeDZq+xy/kWtbT8lkAGKA
	 zFLoQ/vJBnAB9nmolgVa00FGTJoPmwPPKVzr1JC+llLjBhH1NOR1WXnL+XgGm1w+dh
	 Y1TlkzybYTJOnptIVeTedKeQbZ+sTeSBbTLrEXNcULx9lsVfztJH5QYS8tvNKic3KO
	 9jFGNSuVEW4O6UdAR/Cty3MLwpisg6918C2+F2u1VKLdS+aWogdWwzPbYft8BlKIgV
	 SvmVELXlXX+5WcLYwr1gUZiG2ptPd2PlC54yCiAd+GumBezbZtxAeUyRKC2tx3nYfw
	 Zx7KbuXlE5iSw==
Date: Fri, 15 Mar 2024 15:10:03 +0000
From: Eric Van Hensbergen <ericvh@kernel.org>
To: torvalds@linux-foundation.org
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs/9p patches for 6.9 merge window
Message-ID: <ZfRkyxUf8TIgsYjA@1149290c588b>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V15auZRh43av0R2/"
Content-Disposition: inline


--V15auZRh43av0R2/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-for-6.9

for you to fetch changes up to be57855f505003c5cafff40338d5d0f23b00ba4d:

  fs/9p: fix dups even in uncached mode (2024-01-26 16:46:56 +0000)

----------------------------------------------------------------
fs/9p changes for the 6.9 merge window

This pull request includes a number of patches
addressing improvements in the cache portions of the 9p
client.

The biggest improvements have to do with fixing handling
of inodes and eliminating duplicate structures and unnecessary
allocation/release of inode structures and many associated
unnecessary protocol traffic.  This also dramatically
reduced code complexity across the code and sets us up to add
proper temporal cache capabilities.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

----------------------------------------------------------------
Eric Van Hensbergen (8):
      fs/9p: switch vfsmount to use v9fs_get_new_inode
      fs/9p: convert mkdir to use get_new_inode
      fs/9p: remove walk and inode allocation from symlink
      fs/9p: Eliminate redundant non-cache path in mknod
      fs/9p: Eliminate now unused v9fs_get_inode
      fs/9p: rework qid2ino logic
      fs/9p: simplify iget to remove unnecessary paths
      fs/9p: fix dups even in uncached mode

 fs/9p/v9fs.h           |  31 +++++-----------------------
 fs/9p/v9fs_vfs.h       |  11 ++++++----
 fs/9p/vfs_dir.c        |   4 ++--
 fs/9p/vfs_inode.c      | 150 +++++++++++++++++++--------------------------------------------------------------------------------------------------------------------
 fs/9p/vfs_inode_dotl.c | 194 ++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------------------------------------------------------------------
 fs/9p/vfs_super.c      |  45 +----------------------------------------
 6 files changed, 71 insertions(+), 364 deletions(-)

--V15auZRh43av0R2/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElpbw0ZalkJikytFRiP/V+0pf/5gFAmX0ZMsACgkQiP/V+0pf
/5g3HA/9Gqx9Zbwn/sKciCWle80JHJECnJPwE2Iz+yrKuPNqStNIb1AC7EfwWWIM
K7KIH7ObDM6YDY3GHBOmyGPDXUA9WUqY5kl6cZLfwO2/d0IEthBU61rEc6Av6DI3
T4kLWvgxenm3qfZSDn1qYgNKZOPrdUnKr4smn2ny/MjRCaOf9PXSpocpJBzrsjUr
s0sTBmNfHyghX5e/3Ev9BqBA/uRWrvdMMNahD1Cdo1P0nNhsKrzGuyKgLdEQpQBO
3NEzoKkpTag49ruu0xlRUxkfyU6JrjbCByN8VtF3yG+4lIKNSgqYNoraObsq/7U1
q/7jR7oMRs6a+Du0Lk3n2P514p9XSh/KRnRc49p031tYpodKvo2ZX5+DA1i2g8lx
qcA1ngWKo6eGjiqIqJ2JQCgrVAkZsIKKyieVimN6w0FfGE6Xv+DZhNcsdULmBiDF
VC5eNV3370dDpjroqcBqdi/DGkXGdpx8/zyptu/paacki0U5kXfzLiWa8k+z+Iyb
Dlwm2ipVKRQoOGKzyqtvKCW8zjHfi+yEcSwrWFcE7+/l80yr3q7XLBNTcF1QobNg
mehEf07xaD0dkYbSyJYCEKSe2RKebmvWdP9xymZjVccKCQ4JxoBIoid8pjE+xuou
ro46bKYta6Qqp5WPCgGY9p+5zcAajKrwSvy1nfaoC7kmIUjbPRI=
=DsVH
-----END PGP SIGNATURE-----

--V15auZRh43av0R2/--

