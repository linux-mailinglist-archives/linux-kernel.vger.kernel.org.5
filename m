Return-Path: <linux-kernel+bounces-136355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A07889D31F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4532831C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31927E116;
	Tue,  9 Apr 2024 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="TzVeC8dr"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FA7C0A9;
	Tue,  9 Apr 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647858; cv=none; b=T74abUZ8z5rTBH1co7NdClmqZPqf+fNgS7p6Z5NG4a4ANa5OD6NQ9AamtNgKoGav7xK+BoiYOhlXGN19mu2aTjphfVKmgrKizjBYEWHd/MujtERnwX1SLx7+q/YaiBiWjj+nSktIYwAe6kt8lkZ9bO1KrhbzkveuvODrQAnLXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647858; c=relaxed/simple;
	bh=r9rSLlfIhJer4fzjFi/L0h0xK2cjOr96/AVBAEJVmUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNc8sGt1lTWfqr4TRRWZD4cJ0KQEUKK5wwqKkKRsfsUWys3S5udoag5qpgn8ELPwIy5wWJIejW9Lm0DcURvsL4bCY6gvhdKnXKP1NBdyTebH50AoFoESdLsw0MxPWoQTrMhC3KEOQ2x+i4oymd/jMiaOec+4x+zV89RJ3V5vwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=TzVeC8dr; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UxJyCdmSRIdnQgIpQFL657Xfx2+jcU5H7X+gTyZfOcQ=; t=1712647855; x=1713079855;
	 b=TzVeC8drAIkiPokFCNpo/AcWe8XnHT3voYph/Rxaj3C3/lb+cJU5hkQ0eYAAGIzF1+mvVavay2
	fWvvXYAptBhABua58oFTUlV6JoVwrZ9tGGRf/KwLE9QhfGE+dW7ltIX9tbGoNhHYxde91tEA6Z0p5
	LEDB7GEMr5k5gFeSnoYF7KY5uozdxH4ODkcfKjpLAzStlEIx2lZ5XtWvUwuy2VSAnVz/uy9eAMtyy
	f4fP3qDWgAkR3nW64psw5uR0F/JQcNn8BZd79a6rQJv95TF01GJnJR56a+751V5a4dci7WwSuSXI/
	IQFbHWSfli8FDYrC+abV7s61dR03lVLdx/hyw==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1ru5wP-0006Ld-Ve; Tue, 09 Apr 2024 09:30:50 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v2 0/6] docs: verify/bisect: fine tuning, testing fixes, build host, order
Date: Tue,  9 Apr 2024 09:30:43 +0200
Message-ID: <cover.1712647788.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712647855;18e5c630;
X-HE-SMSGID: 1ru5wP-0006Ld-Ve

A quick series with various improvements for
Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst after
receiving feedback on the text or seeing people struggle with certain
tasks.

* The first two patches contains various fixes and some fine tuning.

* The third is mainly a layout improvement that results in a somewhat
  large patch.

* The fourth adds instructions for later testing of reverts, fixes, or
  newer versions. This was already hinted at; but during some early
  work on Documentation/admin-guide/reporting-issues.rst to better
  reconcile the two it seemed wise to cover this properly here.

* The fifth patch briefly outlines how to build kernels on a different
  host; it came into being after a second user within one week asked for
  this. That also allowed the text to briefly cover cross-compilation.

* The sixth makes users that face a regression within a stable series
  test that series first before they are told to test mainline.
---

Hi! While at it let me mention one more thing unrelated to the changes
that came up where I'm unsure if the current approach by the text was
a wise choice:

* Should the document tell users to avoid mainline during merge windows?

Some input from the community on this would be splendid.

Ciao, Thorsten

P.S.: Not totally sure, but I think this should go into 6.9 as this is
a new document; if not I guess it would be wise to pick the first two,
as they fix bugs.

Thorsten Leemhuis (6):
  docs: verify/bisect: use git switch, tag kernel, and various fixes
  docs: verify/bisect: add and fetch stable branches ahead of time
  docs: verify/bisect: proper headlines and more spacing
  docs: verify/bisect: explain testing reverts, patches and newer code
  docs: verify/bisect: describe how to use a build host
  docs: verify/bisect: stable regressions: first stable, then mainline

 .../verify-bugs-and-bisect-regressions.rst    | 597 ++++++++++++------
 1 file changed, 417 insertions(+), 180 deletions(-)


base-commit: b8cfda5c9065cd619a97c17da081cbfab3b1e756
-- 
2.44.0


