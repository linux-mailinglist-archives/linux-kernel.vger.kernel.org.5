Return-Path: <linux-kernel+bounces-139782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873438A07A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4215228B841
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF54213C8EF;
	Thu, 11 Apr 2024 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="P47NtRUq"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14913C807;
	Thu, 11 Apr 2024 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813114; cv=none; b=jNcWNoIbYR6xTA8zO4zOsSz9TRSYxbMKiKp6xqt41XofJapmk9TvwPAovyyz8xPEMx24MG8oERMJMlk55GClfvsW3DBtAna3MzQbhcEqZVJkFCmc4XjQG6q0BS/mmhocAghOxuo+oY//bq8m9ZeNFZ323JxWocEvpwguRCeWJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813114; c=relaxed/simple;
	bh=lBPikJEMl0rOFLCy2Mqs76RURlUaUj/5zw0nHOMGgjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IDPdBh7Rt0lN0ufFIq90S+/L0Kw0V9hwHWrulnYwXE27GdDUwKzIHljj+zedHVepkAoglSmq/il1A+xLxGWXr5V0u0Nz9qDSFcRJJJbKZAl/nPO+MxfppfXcmQGJdPbzbatsFn0m1qOGHeg63FU5m8zoC4IT2R69LTdHN4rJ2o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=P47NtRUq; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=to3hBhFvWbGmGr5fYwaE8VtNPBpJwUxIoxQcqm7kk6o=; t=1712813112; x=1713245112;
	 b=P47NtRUqjHAL3ZLzHAjhrY+6330gpLr5NBvvegPOSRB7zQVQsc+D9LYuNVDRtL/hvMgoR06SEB
	7G6eXc8TuagjnCIIMjIodYEZxHAcKobkGE8ycV/pdwHDNmK3ODc6s4AgjmwggAVqKW7LeG0IP+4JI
	gP39cCOgvPNnuXnvJjiIpJO+MVrPiufyV4TSa+3nhr/eXAh2Qy692ESTmzsVOLgVSxfSxLOwQEB/N
	inkLZMBJW6HDNJtnV99KSvyqc9VF/Dc+A13GffMshmbw7DzTAg6g+GvCBCZCmcvKgAJytuQ9JNZU0
	I5zRiG3vwGpif50JO+j5UUn8nM754wppj86Xg==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rumvq-0000rh-OW; Thu, 11 Apr 2024 07:25:06 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] docs: stable-kernel-rules: fine-tuning and 'no semi-automatic backport'
Date: Thu, 11 Apr 2024 07:25:02 +0200
Message-ID: <cover.1712812895.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712813112;8245af4a;
X-HE-SMSGID: 1rumvq-0000rh-OW

After a recent discussion regarding "do we need a 'nobackport' tag" I
set out to create one change for stable-kernel-rules.rst.  This is now
the second patch in the series, which links to that discussion; the
other stuff is fine-tuning that happened along the way.

Ciao, Thorsten

Thorsten Leemhuis (4):
  docs: stable-kernel-rules: reduce redundancy
  docs: stable-kernel-rules: mention "no semi-automatic backport"
  docs: stable-kernel-rules: call mainline by its name and change
    example
  docs: stable-kernel-rules: remove code-labels tags

 Documentation/process/stable-kernel-rules.rst | 50 +++++++------------
 1 file changed, 18 insertions(+), 32 deletions(-)


base-commit: 3f86ed6ec0b390c033eae7f9c487a3fea268e027
-- 
2.44.0


