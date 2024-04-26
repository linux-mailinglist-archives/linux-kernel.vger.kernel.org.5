Return-Path: <linux-kernel+bounces-159398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5B58B2E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBD11F230E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91732EBE;
	Fri, 26 Apr 2024 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jXXwARaA"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0884380;
	Fri, 26 Apr 2024 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714092384; cv=none; b=iDSeCC1ccBBdijgNrC9d2Z149ZLAPZSwLW4TXgw6IAAINJ9IBkAGxT6ycw7qZux130ZakbtFMxcRlbJqHQW3ktXofn5DCqn3aGvmN0TQKquA5K7ZMjHg8B1OBwdghwZ/k5o9bOU8p83WWFeX83j9/3wlrwRxMfjwdznJ3GYYPQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714092384; c=relaxed/simple;
	bh=iAIwvNanaJfSwyuQdu2iPKAxIDvIcefdxepA2j6RBCc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DVS+xhMHrjemmFMTCsEMmznMbJATjgccxZIaQ58AtcPiC/+8AuxWh5uYapA4yOMRll5RhPb3dmzE8Y0AV+YY/HSGRxIt27yWLehjEZQZFoQiyX5cfV0se5BDvr8W8AbSq0XVnq3GpP93xheCnQQpb6BLUmXyWAkoAtgERMa9OPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jXXwARaA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714092379;
	bh=iAIwvNanaJfSwyuQdu2iPKAxIDvIcefdxepA2j6RBCc=;
	h=Date:From:To:Cc:Subject:From;
	b=jXXwARaAwsEQFPZftpORNj18oMtpRngcpUrXGwSLWQHH8N8hmCU4TnCzyS7beVF/F
	 X0xZZ9mSjbKqUc3u+cJzIgzzDBEEy/T5BVoB0a9QboZcgAelTDZAicyB+5y+WL4KrA
	 8ADD/CzPdLGAEMPU+IO43iJF6M5rWPTGb0vcz+gY5yVfUEnK4bPtbzgNsW3hrg3hmh
	 P3+W44L4qzabkB+7s+U8av2wIpuFJCZyXX5mj72Ih9beHyS03jbefyukFP3OXtCCJh
	 u942cZFISE75FHn8Sr++7WKZgD4Zxbd1nrqK3tcj0aj/LfgZL0if/MX4hRRYXFzT7W
	 fjnaQJ4fSgtXQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQYtz0tdcz4wcr;
	Fri, 26 Apr 2024 10:46:19 +1000 (AEST)
Date: Fri, 26 Apr 2024 10:46:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: error fetching the drm-msm-lumag tree
Message-ID: <20240426104618.43d926d3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//Nrr/SGkSmvw=ixDylAFVNw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//Nrr/SGkSmvw=ixDylAFVNw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the drm-msm-lumag tree produced this error:

fatal: couldn't find remote ref refs/heads/msm-next-lumag

--=20
Cheers,
Stephen Rothwell

--Sig_//Nrr/SGkSmvw=ixDylAFVNw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYq+VoACgkQAVBC80lX
0GyDdAf/XHV7XpbwdanzebPFw7Oqm0lZjuG24R7oJbSruGBi8k0R5YUjwWYtLvuN
EvjrCEqYdfBQ8da2vylQG4Zhv11WYIlFD1ocq38/mhQ+NaiJtnjtzBvWEFq1K4oy
BrEj9Y3mSJfWRSfH3OOGT1kDI7PKEiqgCfQXmaUF2NTouaZCbVtKATEj0epFzpat
+CFkbTvqP0Ufj2J8xqf2g00qkRbdZV0owr41AnfGxp1B0TBMMXpPlYv0kBsjbsVU
RRSVip1Tz4nocRrJbPFi3zZauiUg6UjI/ym2dHAShKkRDSnanWRpRvEC5AdH7f9w
TP8k8/1AKCeg29aFARZ1Y9/1w9lG4A==
=35hf
-----END PGP SIGNATURE-----

--Sig_//Nrr/SGkSmvw=ixDylAFVNw--

