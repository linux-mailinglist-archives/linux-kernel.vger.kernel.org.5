Return-Path: <linux-kernel+bounces-159135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29888B29CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C741F2164D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F242155740;
	Thu, 25 Apr 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW7gNDP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A61153BD0;
	Thu, 25 Apr 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076772; cv=none; b=WpQkG8qSySL0LEDrJt2+WAbmcU1GXsC+H/JPu26mkrsWNkAyY/jyh1YHMh+5bsWUJrsjevfWGcdz9NshfB2qLY4He8S+cGUo97QZ3Hn0gZmO4wxcdf0CtM4Bb87ZYBYNXxPOT51w6ivfCAKKf+K7F6VvfbAdItFciUOgJIU5yD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076772; c=relaxed/simple;
	bh=PLMeaxqZnXGaE83WfAZG3zNxwApXjTs0zbWw4UZmoUE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PQmEUdIRkfPLGAC8zh93BDx7GK8aa2OOy5V2G+EQP4/A4ah/W8DXxV9yKrHwQ0euAX6SDbrTTNHhEwO63ha9NPkP+pIRrWAguFrhbig3vmhG08l+Wl+Cqr0DRdoGrxFpj9FW1gYQYyRJsDE+mal9EssDBkMvU3NQA1WUFf1+sjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW7gNDP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA76C113CC;
	Thu, 25 Apr 2024 20:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714076772;
	bh=PLMeaxqZnXGaE83WfAZG3zNxwApXjTs0zbWw4UZmoUE=;
	h=Date:From:To:Cc:Subject:From;
	b=VW7gNDP9vOqWq9cksmCzMVacHjCCT0quq6Zas0rk7VESAmupkTvrAi9inIM1C08Tr
	 nFzF7JWaCdIEDiIiDAc/rsQjhmYDdo12DdhyT8aVEIUn1aVJRNLnxns5YdYvOu1wLl
	 adI89GnSFCM005U08gK6z08G8PAYF2J1DVXk2FMLbKp05DZ2IN1kSTtnXbdF1vbbly
	 7HpqlDsweMzL3K1ZIyGbEe2OheFcyOK/s1hYDmfdm8qZb2aRX0mniqI5XOhqY3hk4Q
	 C9fHoTXAo7PYJemzEv+/LKYLFEY6NqepK5flUBBLRMBUprtN01a11aGMB5JrlbeyhH
	 YDtvt93cbp8Zg==
Date: Thu, 25 Apr 2024 20:26:10 +0000
From: Eric Van Hensbergen <ericvh@kernel.org>
To: torvalds@linux-foundation.org
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs/9p: fixes for 6.9-rc6
Message-ID: <Ziq8YlBcw4qj4K1O@3f3e8491d9e9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="upXBWr4EQuAUIzK/"
Content-Disposition: inline


--upXBWr4EQuAUIzK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-for-6.9-rc6

for you to fetch changes up to d05dcfdf5e1659b2949d13060284eff3888b644e:

   fs/9p: mitigate inode collisions (2024-04-22 15:34:27 +0000)

----------------------------------------------------------------
fs/9p: fixes for 6.9-rc6

Contains a single mitigation to help deal with an apparent
race condition between client and server having to deal with
inode number collisions.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

----------------------------------------------------------------
Eric Van Hensbergen (1):
      fs/9p: mitigate inode collisions

 fs/9p/v9fs.h           | 11 ++++++-----
 fs/9p/vfs_inode.c      | 37 +++++++++++++++++++++++++++++--------
 fs/9p/vfs_inode_dotl.c | 28 ++++++++++++++++++++--------
 fs/9p/vfs_super.c      |  2 +-
 4 files changed, 56 insertions(+), 22 deletions(-)

--upXBWr4EQuAUIzK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElpbw0ZalkJikytFRiP/V+0pf/5gFAmYqvGEACgkQiP/V+0pf
/5i7JBAArl4Mx9CEYQji918PaDOQCnY+U7LVfBNGz9uOwJtLmlpyLbfZF73OCsse
BbaHlwkoPlJJ6n9G+Ik1o2soYgLc8tO3Ap40gheJuhld+RE6lxROIltepL/mBehF
cAgj+XbN5YykglxhiqCuDVni+vuMy0rMlCBoA1JWy2m3GmXMXUSRKA+RQiPV83IB
orUvdRi9rtZzDKqsysoAilRfHDvEYqquRLL00rejUnxGYjoqK0qvowHby+uIcmjo
iROCS899UMSg4bIe0Y11g7F2aJNw2LtPFqujDwfTJeflIgN9E4oyUL1Pt4pdpvPh
vE150w5nIHgazRDxlP/hgLVenMhmnZPIhpfcUf/8JHEVvZ/GLjpjft0lj5NO0hnH
g89eiTMaTwppRN+b7CYNBq81zf261U37OzDMpw5mDez6ROQoP/0lgLUI+SV1kuAR
GQUx6KV7oovosPr5oMES+vyvn/v26sWZYnPwT0FfckzkKlKGRdor9tMMWzlSpUC7
fYK9JTPQGFsls/DZLE8jYRFN+aUZhBBHs8nfH35thtlnV4V2KvJdypNWkM4W9yQm
b107FVqEbyaoAThuiq9WHJFtyLCUNsJvSUjnhd1OXYGkOedTprKQRxSn/orFnOKb
kUiQnuEc0sRJLM/L1PLQKHUDO9DGLnDaRlnoR6WU6sBz4n092js=
=Nzc0
-----END PGP SIGNATURE-----

--upXBWr4EQuAUIzK/--

