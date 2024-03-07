Return-Path: <linux-kernel+bounces-94768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12FD874502
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B641F23725
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA9800;
	Thu,  7 Mar 2024 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="T9mxWMTe"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0F161;
	Thu,  7 Mar 2024 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709770044; cv=none; b=qifvx7eaSWUzbW/sHlQhaOd57tPQ1IyPcWr39GVHghCg7Ws6xDz5ZwicafEMFUzyFrxqkVBYECC6nWQfz8y6Ep/ob2+HdtbTnDnBbnsBgG5vUV/eVg9BokPxBpP4Osc3CYBdv2m/PpzQ0UypEhIBUaFt6eAgu1Zpz9MK6u76598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709770044; c=relaxed/simple;
	bh=QTUOXYdMlWgpt+KAVLtO+n1L0FFFbX4fZZbEK/5E49A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Lf+7SFLhbZ4rgYx/vFN75qW9Gnoe3JzKCvyeFRxHS5Adp4LPUYk33Ko066DIUDwAMPfXyfMqNqI2rZJfbIddjwDEx8kkGeId9FHou1T8DxVfNC8tauTp6fsq1JvHizyQYcTG6wBTNsMZLp0pMH4MqzJHkch16+GNTHbQbrb7sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=T9mxWMTe; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709770039;
	bh=3PmXNVGn7XjFoSa3vjVFtQO58cni7AWVMPU81KTSwhY=;
	h=Date:From:To:Cc:Subject:From;
	b=T9mxWMTejuEvsuUQ/AoOL5WAyEOgE7M0T0Qe9cmI3sISHMNEcQCJgsfjdqGZwDk0W
	 mHdZkWkjak5cbMgclMb2ewCd1ZMZur+peczJAsZ7J4PH2wz/t5i6xeYL03Odctj3YD
	 RPuN1oW79WTNvSdKdmnZ2yBBqAdt523Y8LFduSJl8EhPP3Ci1TxiaHdp5ogrmRegFA
	 mqRFXbKzr2SGM91mJdDiRAcq3RxMFl8nIItuPz6d4mPno2oEzHLlipt4B1DHmbWXwu
	 6jQy2ZabSyrk2CmgiubrH3XNDRR1SSwGGrXCZ/hBCIJ6ojvJRkvbk/KzB5eexzkM5O
	 wxGpCpp9GX+dg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqqP25c27z4wcC;
	Thu,  7 Mar 2024 11:07:18 +1100 (AEDT)
Date: Thu, 7 Mar 2024 11:07:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jan Kara <jack@suse.cz>
Cc: Winston Wen <wentao@uniontech.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the ext3 tree
Message-ID: <20240307110717.50b64fe9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YV2kPiMrovNC6.nKsM.9alL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/YV2kPiMrovNC6.nKsM.9alL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ext3 tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/sysctl.h:27,
                 from include/linux/fanotify.h:5,
                 from fs/notify/fanotify/fanotify.c:2:
fs/notify/fanotify/fanotify.c: In function 'fanotify_get_response':
fs/notify/fanotify/fanotify.c:233:48: error: suggest parentheses around ari=
thmetic in operand of '|' [-Werror=3Dparentheses]
  233 |                                   TASK_KILLABLE|TASK_FREEZABLE);
      |                                                ^
include/linux/wait.h:283:11: note: in definition of macro '___wait_is_inter=
ruptible'
  283 |          (state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
      |           ^~~~~
include/linux/wait.h:935:9: note: in expansion of macro '___wait_event'
  935 |         ___wait_event(wq, condition, state, 0, 0, schedule())
      |         ^~~~~~~~~~~~~
include/linux/wait.h:958:25: note: in expansion of macro '__wait_event_stat=
e'
  958 |                 __ret =3D __wait_event_state(wq_head, condition, st=
ate);          \
      |                         ^~~~~~~~~~~~~~~~~~
fs/notify/fanotify/fanotify.c:231:15: note: in expansion of macro 'wait_eve=
nt_state'
  231 |         ret =3D wait_event_state(group->fanotify_data.access_waitq,
      |               ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  3440e7e55ced ("fanotify: allow freeze when waiting response for permissio=
n events")

Though, I guess, you could argue that the ___wait_is_interruptible macro
should parenthesise the use of its "state" argument.

I have used the ext3 tree from next-20240306 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/YV2kPiMrovNC6.nKsM.9alL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXpBTUACgkQAVBC80lX
0GyIJgf9EiEsM3leOBeFVLdvpuIv3h7+e66I/TcA2ap4Olkbu4nJq/xLWNjzKBxJ
AB9+3MLZP51VbsYwaugAPaNwusYakvrLGf3Fywp8tUoMC+xgsc45CTxuHEeB4Aio
Zj6Qdg4nSOQImUOz6ZJ22sTEs7K9gOHG4PP9L/nG+ztFiH3PsUzl++ZzctOmFHmF
g9xuVGMzwu4CQ+mhnPwbejMqCjIt3lCjHFEMMiYAafqPXzUD6dScyKMdWA9fp/Qe
1Q14JefgecpzfmUFZv7jezwTRMzZP8GS22Ri5V7p4CEuq9/2hdfTeTaD8KFjfCkP
zEQugtbf66R5KxWngQd+vj9Wb1Smww==
=F2PT
-----END PGP SIGNATURE-----

--Sig_/YV2kPiMrovNC6.nKsM.9alL--

