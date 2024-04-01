Return-Path: <linux-kernel+bounces-126551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B1893964
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255C028202D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADD10A2E;
	Mon,  1 Apr 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DgyR/oiv"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423BB1078F;
	Mon,  1 Apr 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963791; cv=none; b=O3Wy3Jw17AosbOzpy+3OPsUmk1X4MxhdwHHuth1aPf4SgY1twWv4WOHOsjllbgKKkIiKpa2irjj7qOAm38mJPUrks/vpwJDKwxt8YAiQobuU38puh15AlZtDssnlxKeRglKNcxQv5wNR0LBzPaU6Pa70D8MIEC8i+vOU6s5nnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963791; c=relaxed/simple;
	bh=09g0KmPnWZwZMKemwLr3J6sPGr0aiE4KawaGx/CSgP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmqCgiuqGzaZwH9W9+ne13khjPBlR6a8BIPxVtVV+PhXWa4JHHQkeqjtcc9YjX1whPXLTiX779AKVS+ceYFKb/GyQg2CU/cXHPYkaWhq2ahRHGyoHO/wjAQyOYSrP2digMCI81l71fyUfwCrEZAe+GLDNBHGIK4DMscERscH9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DgyR/oiv; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FlOrEzhCm16iYgRyEXQCmmA+7J5gJqSSHdF+G2C/KxQ=; t=1711963789; x=1712395789;
	 b=DgyR/oivVBwSo9if94e4sQugcbSrBnmLO2fA5m9PLc2fli7QXhNt1vGtPRJj6+1zShjdDFyoT+
	vEnHpQGJaCdwzYBRysUW7q0plxB52bUS2BrofNlMS4DXcyV5iSUc87IyoqopoYAeC/pEUTr780Wsj
	QWNwRQ9O6HZavsHq/Hi/6wUj6YjqA/zcgsBnO+dsN7P62UuZAgICEUQpPSNgNzeuyasBfbJyYgtqG
	+jXE82sXKr/JuX5GOGCH2wkDS6hjBZaTSe2k8Vzcw++eAleSbuihXuXqlJoIBOdaXePNQ3gjn3E8I
	aA6nTafhBpEsXzT0W+oCi0zXN9ejLwhcKDaAg==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rrDz6-0001Lq-M4; Mon, 01 Apr 2024 11:29:44 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v1 0/3] docs: verify/bisect: fine tuning, testing fixes, and using a build host
Date: Mon,  1 Apr 2024 11:29:40 +0200
Message-ID: <cover.1711963460.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1711963789;9169144f;
X-HE-SMSGID: 1rrDz6-0001Lq-M4

A quick series with various improvements for
Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst.

* The first patch contains various fixes and some fine tuning.

* The second adds a few instructions for later testing of reverts,
  fixes, or newer versions. This was already hinted at; but during some
  early work on Documentation/admin-guide/reporting-issues.rst to better
  reconcile the two it seemed wise to cover this properly here.

* The third patch briefly outlines how to build kernels on a different
  host; it came into being after a second user within one week asked for
  this. That also allowed the text to briefly cover cross-compilation.
---

Hi! While at it let me mention one more thing unrelated to the changes
where I'm unsure if the current approach by the text was a wise choice:

* Should the document tell users to avoid mainline during merge windows?

Some input from the community on this would be splendid.

Ciao, Thorsten

P.S.: Not totally sure, but I think this should go into 6.9 as this is
a new document; but I can split this up if the two latter patches better
should go into -next.

Thorsten Leemhuis (3):
  docs: verify/bisect: git switch; proper headlines; various fixes;
  docs: verify/bisect: explain testing reverts, patches and newer code
  docs: verify/bisect: describe how to use a build host

 .../verify-bugs-and-bisect-regressions.rst    | 469 +++++++++++++-----
 1 file changed, 344 insertions(+), 125 deletions(-)


base-commit: b8cfda5c9065cd619a97c17da081cbfab3b1e756
-- 
2.44.0


