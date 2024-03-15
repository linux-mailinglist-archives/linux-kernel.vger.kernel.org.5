Return-Path: <linux-kernel+bounces-104822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F387D42F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04386B2432F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59E94A9BF;
	Fri, 15 Mar 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLxUbvok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365EB376FB;
	Fri, 15 Mar 2024 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528937; cv=none; b=M2jJlutg3UHb54OIv/upHx1AGi7qK/M1Bllls5i1J9x5wAm9z+lHg+EswVjK9ULjBgVbZB4/h7BRd0coFBHIqNwI1TG0iCYkWHos8yipgpShLss7sqQMBJN/WD5YBApWI7SMAD1u+7d9lg8rl1GC4yKfPpfLPk9eMS8mm2C4c98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528937; c=relaxed/simple;
	bh=mkWwDHx49jdDkfkkTgs0NqewXdFo4R2FkQN+d1rrsxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z65S66VX5rmAzuDHt5ipn0Pw2OS71erhjert/w/OjoSLtn+6GP33DuXpwKhxsHj8bXM/M3nfu6pHLxm1sNLCRF67w1iz6rDgvkuY2sEnnYkSQqGRAC4QbwmalU+pZ8mT/IjCDs5A/zdl86auBJzH3ox+27XqY25PdLM0BX/R/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLxUbvok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BF9C433C7;
	Fri, 15 Mar 2024 18:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710528936;
	bh=mkWwDHx49jdDkfkkTgs0NqewXdFo4R2FkQN+d1rrsxg=;
	h=From:To:Cc:Subject:Date:From;
	b=dLxUbvoknc/NqagmL2Z4U1xjRsl2H5uk/WB6jdnIAvnkSS684Erw0Wpp+WIgSrybk
	 EQaokH8SwEAfy95EBZK4/JctVZBR3Phz3vU5xMRm/WpXpUVCzG0WAy6rtzYAuO+nZT
	 z6GupUdOeMKOlZdHsF5tXVqT4hxAUEWct1XuDB88vTeekJAld1AJOkcLDrao5ilFJm
	 74UpBkNVXE72vJVtpEOYrlD/DiNM3SHfAVUzbS1ViSeOOyA+MtnWv+VJGeLSDm9PSV
	 D0GHZXi/pj+/JlXAZtJnHih2biyxDo7HAjbWFb+wGCkaajcmU/QLJgEgCWEWqPfTeu
	 tM1S9E4oTQWhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.6.22
Date: Fri, 15 Mar 2024 14:55:33 -0400
Message-ID: <20240315185534.1842040-1-sashal@kernel.org>
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

I'm announcing the release of the 6.6.22 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------



-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmX0maQACgkQ3qZv95d3
LNzbJxAAnP99q7lPOB0g0UMoAGOBqKYWI81DtW2Xey8i/Bf0yerJiIYIBqRRRHKU
I4Sqq8C8iR7yrTkYcD7993J2Zey8rjMBIBws78vDeEKWdVxtGLuE1DivT2sBTk6N
y6uQ7Nar7mDmQ0U2IB5KlA1MCy8/tFb2J2Ocvep0GfUMbxiloOcnRoa9SqZlUOzN
BNeZoAqlAWIjgJ4rVo7En9cWdYjMtk4fPFDb53vfmSR2xu1Rak73w4LHA8MdtNzr
AnKqQOqXLEutjb8tGnJ4mWe7ep/OMsrDGNXSkz04Sg/V7kSbjYzyTGiLeCxYmxip
lavPNqBdgdiukexVkgWON8OA2AkvFBgKGHFrEaG4k+NAfLHzKAIC1AR8MQXjCbi8
5vinLTp+u8qmoAZNMsbTYgA347fgMexM3/rk65Z33w/GWP2hOWX7fJ9TRHycbomt
tiveGtaSMgMAdhN+RKlDTtsxF4JVRDVADe5w6LBzaWgv1drdcJzwNn2fTItWZm9p
Vq9gjzWdPChNqS9QXK58C14GUmnzgVEbZz3my0BU7ROroEKONje/jfwdHb9fj61V
8w/CYhAU9I/hlK/1ETxQkR3GdURZ/bzHNzmLsDXx2JBgxaelAXivQDuW2iR1PqtV
YH4NtC6VlUN4tDPNrLse+wCUb5QUuSX4jb6qXDxUneaRegXfa9Q=
=uPB5
-----END PGP SIGNATURE-----

