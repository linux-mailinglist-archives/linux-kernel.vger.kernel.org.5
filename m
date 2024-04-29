Return-Path: <linux-kernel+bounces-161844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6308B521B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E37F1C20F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F44814AB7;
	Mon, 29 Apr 2024 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="fRmFoCzU"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7FC134BE;
	Mon, 29 Apr 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375118; cv=none; b=h7Da1d+btlZhW864J6C445X7tdZBKmpg6JtuRGpsVsvHR2jvR9TZX1yf7iCUAZZ76kKTPRlNNewiGdCcjdy3de+ECLmoWoc0p19yGvevkLmmtcOE/GWU8eAbWxVNGQamkItiN+6IqNDe+NTOWJOFDV5cOYwOaT4spWHibU/oU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375118; c=relaxed/simple;
	bh=mRJK2AQiE5O8jdME3BVX81Wip+tE76LubZ8HkAoHRzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7ON2BfFJePoPb0k8ciCzdCnFa/OXYLsiTZYrBgWtgkukCeDcOhWvJl5kwvMX/AyW/a77oDols67fsVb3PYqlODzNM+OQhVJJl3YbNxyQojTBYf3QPWfwo3XFTZQ8AOun60rSr6gnB50fwPoy7say8NPqxKRlPZcKntpQZSOtjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=fRmFoCzU; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=6Urg+TQ/FnsFc4yBOyVl/MrcHcj+2yeVM0FYIrCt150=; t=1714375117;
	x=1714807117; b=fRmFoCzU6nJ8Xl+zpoKl9DM2oMLYmmhVo3Y/8iJ07P5lQjjOjbHKGw2N6wwRh
	+G/MWEpEbvhnlDKD1FcXMV3vWre8MkvLydjEoKfATqV5ibuoVIrbCFcA+pXZNfZR0L8VouXymYDnm
	cnx0vgzWUJ+R0dBeP+Q/WA92+RjtGa9/QqbV250EDjVLInqZK8/+INOFIcP9KG6U+By2SneTTm1IZ
	N7ezbXIFbD2OT3vJtzKptMA4Ku9gTbC1TR0+yQ5lD9p58T/7z6peCZZQRrsx73k/ryl6UnXHfXCkb
	vZlYxk+h9KYuWSrEzKY1hGU0NOVtun+E0jLffIF5xTSZ7B1QZg==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1s1LHU-0004e1-7h; Mon, 29 Apr 2024 09:18:32 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] docs: stable-kernel-rules: call mainline by its name and change example
Date: Mon, 29 Apr 2024 09:18:27 +0200
Message-ID: <0a120573ea827aee12d45e7bd802ba85c09884da.1714367921.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714367921.git.linux@leemhuis.info>
References: <cover.1714367921.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1714375117;b475376d;
X-HE-SMSGID: 1s1LHU-0004e1-7h

Fine-tuning:

* s/Linus' tree/Linux mainline/, as mainline is the term used elsewhere
  in the document.

* Provide a better example for the 'delayed backporting' case that uses
  a fixed rather than a relative reference point, which makes it easier
  to handle for the stable team.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 0da9c57287c134..d28072b570f872 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -6,7 +6,7 @@ Everything you ever wanted to know about Linux -stable releases
 Rules on what kind of patches are accepted, and which ones are not, into the
 "-stable" tree:
 
- - It or an equivalent fix must already exist in Linus' tree (upstream).
+ - It or an equivalent fix must already exist in Linux mainline (upstream).
  - It must be obviously correct and tested.
  - It cannot be bigger than 100 lines, with context.
  - It must follow the
@@ -134,7 +134,7 @@ comment to pass arbitrary or predefined notes:
 
    .. code-block:: none
 
-     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
+     Cc: <stable@vger.kernel.org> # after -rc3
 
  * Point out known problems:
 
-- 
2.44.0


