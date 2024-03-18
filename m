Return-Path: <linux-kernel+bounces-105822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B3B87E50E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355601F21126
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0F728DBC;
	Mon, 18 Mar 2024 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="xDqpIbDD"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581525624;
	Mon, 18 Mar 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751134; cv=none; b=NdD3MGMTIw2ULXep0gYm+KRZSqf5Oa+mUlmv2ExaDuL9cC/ljsAUKHwNIVpDl7HsTlCi2TetSFGE8q+xhMVFNJBwA5mhBRJoCe84Een4uPK4Yfi8jcQLJbqatfl/64LTjAwl/UI79b5eXBS4i1VLAzyHTt6b5y4FkqGL6CSlF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751134; c=relaxed/simple;
	bh=Q1xjT+rtpxSXBeIBdH+RqFFAq8QdGlmiKD2Xuo4StNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SorGz4ROGDK/OHOO4GLO07IOnte/7uGCtE3N5l2/6PZSrfCFRIU/cgXkcAJ0FKxYdLWjGWHVakCqqlta2Af19wGXJ/7bo3Hn91CgdL6L0jWX2kgm3qxFRpKjExH5E1RAgPiJbJ9WutD4rjSuTebzlF03bIsuDxDV2wZyHdVajiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=xDqpIbDD; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=oRQDdmgf9lAqQVGEv78ZqQtrkzdwgqSXfSY5t2nDCv8=; t=1710751131; x=1711183131;
	 b=xDqpIbDDQLAfM14or5tvD1I8Z5aSOzqLI2mD58Sn8lc6kk5NXg5EcWgq+ef1sM/JKwcb9b7JhS
	+oPxSKKs/IeEeYF5VwB2ZtQNARKKBjuJ0xACbIMyodCtO3NOmv7M99FKKqTPx0U/C1cYpY9r+RnJi
	Dy8ISTyfJZlFi4cKHWZly2jAn5OP2JCMjRPMsGZ4MGpDyn7+9GRnvQ7geAV0wOZGZObTMh36/2nIh
	xCjp/wRDgwJuZVeHIg9x94iSpuzC3+89sxyyfUmw5BCJUeCWkNSGdSWbF4bWfnwP4rHi5jUhmoqWL
	461TOSMFW+ILTIQjopDgxrORrNVGVU236gi2w==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rm8W0-00037E-63; Mon, 18 Mar 2024 09:38:40 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v1 0/4] docs: verify/bisect: install, tainting, and finetuning
Date: Mon, 18 Mar 2024 09:38:35 +0100
Message-ID: <cover.1710750972.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1710751131;f9e8a67c;
X-HE-SMSGID: 1rm8W0-00037E-63

Here are a few small improvements for Documentation/admin-guide/
verify-bugs-and-bisect-regressions.rst.

* The "improve install instructions" aspects (link to distro docs, Arch
  support) were brought up on the list and in a chat.

* The "check tainted status" thing was something I had forgotten; I
  noticed this aspect should likely be covered while doing some early
  work to better align Documentation/admin-guide/reporting-issues.rst
  with this text.

* The rest are minor fixes for things. Many are things I noticed while
  working on the above changes. Quite a few are also things Petr Tesařík
  brought to my attention (many thx!).

Ciao, Thorsten

Thorsten Leemhuis (4):
  docs: verify/bisect: improve install instructions
  docs: verify/bisect: check taint flag
  docs: verify/bisect: drop 'v' prefix, EOL aspect, and assorted fixes
  docs: verify/bisect: remove a level of indenting

 .../verify-bugs-and-bisect-regressions.rst    | 389 ++++++++++--------
 1 file changed, 211 insertions(+), 178 deletions(-)


base-commit: 0c8e9b538ed7ecf4159b080ab0dafca3941c69db
-- 
2.44.0


