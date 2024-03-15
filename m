Return-Path: <linux-kernel+bounces-104808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE8487D3FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A43F1F236A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014D4F88C;
	Fri, 15 Mar 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUPDvJvC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3865336A;
	Fri, 15 Mar 2024 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528602; cv=none; b=pUrxZKvmeVWNZNRoGjoKYiDj+RgGl/n3JLJQ9NhHaeaydLnUPRubOySot6T0bTz+zmRnQ4UIYLFFaF4zXy2Az+tB5GCBMB/HZpZSsy2BM4xTo4zDZy/YY7msutdC4dR7jeOCJPtvSNqfHjo/izo7Yg6GCby++oUt+rBvuemdBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528602; c=relaxed/simple;
	bh=VHhc6tYZfkq50xDZ+Xatgk3rCEAkNdNQaSimpkFNQ/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ba1z8NR/f1+3VD6dcJopgtXnAQpwvGXVcrSw0rXSmg/edq8iAIatoe+9fPgegMtvsGWLSSRPxjjatSQEPnF1PLX7u/Y3BrWvLyWoINmZPW6qAUTgCelLNlNcozTKOWRRZ0eRkg9XP4LX60DEp3oWLvTJ+K5NqYQoYZBLGVY8Yn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUPDvJvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536ABC43399;
	Fri, 15 Mar 2024 18:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710528602;
	bh=VHhc6tYZfkq50xDZ+Xatgk3rCEAkNdNQaSimpkFNQ/I=;
	h=From:To:Cc:Subject:Date:From;
	b=VUPDvJvCepu6K7yq6uglbGG7/aln9jP4DdTLuzTFz8Pj0ZjLktCKUf4EAlnywSxw5
	 j9iWbOBCgjlFPCTXIDFCZTb4HdBTwsmLV8qz06zD/awQ0m9zsplL1c0xwUlhL6snpw
	 Zmawj7U4lFoREsxnyaVeSxEh0kvTsqeoFer52o0f7qeQWHV5obvcVzrwzuoMxWULOe
	 5WAGJYPTIFflRn4MCNSpZEbHnyoIgK3ZTb8y8eTdzXmK/JY3VboZyfK7NYg6asMGHy
	 ewdM1+eBmNhh9KUy++MuaewDDhTJgN7Nhd/iQ1M50lTA4mWaOBgGtnM/SwDeWf2cqF
	 9JDzujYVpzRmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.8.1
Date: Fri, 15 Mar 2024 14:49:58 -0400
Message-ID: <20240315184959.1841391-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'm announcing the release of the 6.8.1 kernel.

All users of the 6.8 kernel series must upgrade.

The updated 6.8.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.8.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------



-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmX0mB0ACgkQ3qZv95d3
LNw+tBAAraZu6ZEFSO9/acuTsFQNQqPCVT6KPRWiX3FNWKnROFW10ExxgmjVTRUc
xpZ8KFSuxXb9ipPEHI5r1Apqp+iu6LE8NmbMRPLVyWEWonnxdKKWztturhebOYZs
Kj8HAwIyf0H3ubrIXT/pxtOzodiA3nsyc49+NNAK6fciEHe/g0KuSsC1a6nBAndG
8zqNTQg1jI02ymoiOPSf5z1MuIYmSA5Ae2+4pHthWcDPiaGw2MWqc632x2W+Yh1a
gZIXYar6VLA2Bk2hcSL5tOVIDTXHEZV5iRndJ5wbxbg+LbE0z1tTvuZPLEPefRnk
lMP+rObTHZLf9yTNMRbWJ0HwhrdFuVxLYUMeZfDyI5I5XF2pYv9qTQmjc+tYJICI
qbDiO5u1j7Ffsxfl0HIWNLlSUMt3MBt1cn8riMxb9YSFWVFiflw66Axi4Rybhp7E
Brrp/SNl1fHRoSgTxJC1RRz+/uIuwaQGOARKfcakXPLfQ54zUdNwSzEBdpXuLV3j
6QIS7d6hiw0IvtU5BF2JUMVt2hWW9SEAnhPRKrh+AJRX3aBjYmhe8UMo4OWfNINQ
Hzl4b/AZwQ22r3z20yIlbwLSmd/P27H+HbWnSOiPdpMDttes+jcN/nso0coHHX5i
chCuy4eGCj9K0WOSYSTn6XyobMMuQbyHVjXMM0wyXGLQbhqHycw=
=Aljr
-----END PGP SIGNATURE-----

