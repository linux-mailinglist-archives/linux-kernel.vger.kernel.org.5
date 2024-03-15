Return-Path: <linux-kernel+bounces-104818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E880187D426
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881DFB23E45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26352F63;
	Fri, 15 Mar 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJDmhFXx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFFD3B79E;
	Fri, 15 Mar 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528790; cv=none; b=f8ofmQ9QIjgSjuaKOyucBf8p375cRneL4JePuwQRWLisju6AWCqMvfBtlzD3vKioG+dT2Ex+AS1lKBBx3Pq7iAqPgLEHScXsMJqtwLsTvallWjHf0d5+U4CflwpkH46+MsSXP8L47Pn9YCuW9WyVNRae+q23cHak1wYvKmQDNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528790; c=relaxed/simple;
	bh=xlmyVSRDkABR2tqMWqpv5JuaieNFVjgbz9NYWFAttDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtO+QJIF21gHSM8i8eUYCbB1f+8zlzi2Wm5YrrjHLOkDLmMPmItS0MItRGRgNo3Y7fDPUkR0lDLVzPfoemAbuz4wHeQqTnnNFYpt7Q59iEX3r2izRX9h7G1eLpFzoK5PDfJBVkEwtyupZXFsqvqMwqKRGItsQIuxVfwN+fsyhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJDmhFXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B01C433F1;
	Fri, 15 Mar 2024 18:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710528790;
	bh=xlmyVSRDkABR2tqMWqpv5JuaieNFVjgbz9NYWFAttDA=;
	h=From:To:Cc:Subject:Date:From;
	b=bJDmhFXxr1Mm9rzqwu8wJRVUQS56ZNNMhJMikkW0dFxBrv4hvmr2Vz6mCFbU/cBqv
	 ol3v5O0t7vvawwfsr4xOJZe5rX5r0NsZASt6BWsHPVLGDuZ16pIzaUpRAGjQcykrMY
	 EEtChFU9E8fpDNVn1dQp3uhCKIW+SUAl+aES0BO1RA9YoUvmOfcHu9Gs9uAC56vhGN
	 mXVBe/q6QEIa7X8pUEikqcxgEKpdBqUtvW9SPguj+pVZ9eTsgQwofJyJd6U8o98PUR
	 k6ysT2h/SA7zz2KBoylhJXNy/bAx9MG7IIX8RMLDKgZYWGH8GgaBhN0Lnp83zW1rxk
	 RiHThaHxIgUWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.7.10
Date: Fri, 15 Mar 2024 14:53:06 -0400
Message-ID: <20240315185307.1841671-1-sashal@kernel.org>
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

I'm announcing the release of the 6.7.10 kernel.

All users of the 6.7 kernel series must upgrade.

The updated 6.7.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.7.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------



-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmX0mQoACgkQ3qZv95d3
LNzimw/8CNyHdoZLtpqSUecdo2L57pR6Fd3oHmP87dqOnRylZpQpSujVqn/euZ3e
XCEfwhyA52LaQDAcEqrgsoYa9aQQUBFHBY/P3QhPvvzud+wFkwyz73+UTYSH0ag7
GPpNwjdM6d/KdKZyNmv5FIX1zbaBx0ETYPVUBhL/UiCMwFTq4U/1ic4tiBueUSQa
o87IlfZQKB9Gz6k7Dsi4bW0tZbeVCcg7rmVlL69b0xATuftOJe7P76OmjSJ6GO8c
e2hTCTuc/RvuyAvfWjUSxmq38IMGb2yLsJP9/DWCjinlIna9mLKCsmQZ0oxg9q/T
NHwur3VWuFoxX86/0CGFQ9XqNuZlvH0aqPpdUn4BvLOhFBBn1TM9KbVx3fLTjOfo
BaF0tl8ZFsH5rZasUpoimrsmHoGSIVs7Vv/XY8hLZVq7BaWogwlz1yYN6tcDUcRn
bp+RuC6FrPO8/G6QMX2TwmSmEM15L/RvWKEjAigqEeqOrAW1EurKMLa9oim4gJtH
g3IRXdjzR6iYGW56XZ66MKmfXt3D2hPVOHYR2OvlMZMecSnuN0ncEAPzXa5hPNKN
Ff2seiKL7DWKnUhDsqLQfJIXEtAqxavNK9SbCB54g7Vq6THPfcN49+dXxkqHUxpH
IzGfYbfURrUEQw5KMsE1X7RueiX9eYTIWbthPw3A/OvWYC4HJ34=
=HltL
-----END PGP SIGNATURE-----

