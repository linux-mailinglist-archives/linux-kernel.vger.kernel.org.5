Return-Path: <linux-kernel+bounces-118963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3259988C1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648FA1C3666A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF67976042;
	Tue, 26 Mar 2024 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="uYSHkLWv"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A30C74433;
	Tue, 26 Mar 2024 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455714; cv=none; b=D8dsy0B6YeJ68RbPsv1LtpjhybJuzak9MrqhMdKkKotzdyLHwugHvXDnvsHsq+Phsv9BuJgcnJdZzHAZqU6Z12rxjUYzTfioLbgXf2S3SUhIUPJuPeu6GZeXLdaXvXtqWKCVplho+wzsg1huJQrnjDTES1SVnUkt1uioY+iihWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455714; c=relaxed/simple;
	bh=qyTuZJJBB6SRCYQaUw+XLTTc5thHeDk4mK9OvDwIPpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fjs30J1zhZixm/kUYNCRSZHv1l6n57rPh3BnCa5HMfW1WNJ2+Bm6NrDEyLfZg3Wg193BoVD8Trr9JAIKrULt2FV5AaIfBJsAoBk9mByL9F7Tt3B01mFO0L9x+5q2T7h5cz5IAHn84lnjADjVlsRyLTHRFotJgx1ai+84YdZJySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=uYSHkLWv; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=T7Rg75OUQXr/P0BzSaCpqEAwDPUMWNB+wRhXebgxorI=; t=1711455711; x=1711887711;
	 b=uYSHkLWv64FkbGkKSuwa305CY9DsjE43kyGFs3OJy03ac9AWv/a51WtI5MZUqovUVbuboGKXZe
	0ecJ1d7m/dTM8FFfWeiM3MZs8mB3h7VGTFrBHJBr4yLfApnR39Kzv4ESnwAmtK2Sp5uZcxoNq0mXZ
	u5El0Jh91NPAGzhN03nQCqywXNfD9fyoDFfeXFMUT8THUTMlnyiozF9suwX8VVngg6BaFM3NFK9ov
	Y5wWsozCAxREv3heTwTi0ezQmJM75P+w3HB7GmGv7Jh4qdpIL1tWTg/aI9l5Gk/W5PrxiN81gdVHE
	wugyVvLQLhUE3Mnxw8nTDVu8uSzotuAiilQpA==;
Received: from [77.20.141.166] (helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rp5oH-0000kc-8I; Tue, 26 Mar 2024 13:21:45 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [RFC PATCH v1 0/2] docs: reporting-issues: rework while involving the 'verify bugs' text
Date: Tue, 26 Mar 2024 13:21:27 +0100
Message-ID: <cover.1711455295.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1711455711;c092b3a9;
X-HE-SMSGID: 1rp5oH-0000kc-8I

This is a RFC with two WIP patches that basically rewrite the detailed
step-by-step guide and the TLDR of
Documentation/admin-guide/reporting-issues.rst. Those two patches cover
all main changes I currently plan to do in those areas of the text, but
the explanations in the reference section are not yet updated to match
the changed step-by-step guide.

I'm nevertheless posting this now as RFC so people get a chance to
express things like "Thorsten, you are crazy, go away and find a hobby"
or "you are on the wrong path, this makes things worse, and would also
create a lot of trouble for translators for a questionable gain".
Getting such feedback now would be good: I'd prefer to not waste time on
updating the reference section if something like the two patches posted
here have no chance to be merged.

That being said: I (obviously) think these changes are worth it, as they
make both the TLDR and the guide easier to follow and fix a few things
that didn't work too well. It also offers users a new fast track to
inquire if a regression is known already. The step-by-step guide
furthermore is now a bit more verbose, so users have to consult the
reference section less -- this felt appropriate, now that the TLDR uses
a step-by-step approach as well that is quite similar.

In the end it looks like a rewrite, even if many things remained
similar. And all in all those changes sadly makes both sections larger:

TLDR:
- before: 374 words, 2332 characters;
- after: 491 words, 3085 characters

Step-by-step guide:
- before: 1058 words, 6279 characters (excluding a section that becomes
  obsolete)
- before: 1332 words, 8048 characters (including a section that becomes
  obsolete)
- after: 1491 words, 9015 characters;

Note, the changes to the reference section should not turn out to be as
extensive as these two patches, as many of the steps in the new detailed
step-by-step guide had equivalents in the older one; many sections in
the reference section will thus only need small changes or maybe none at
all; a few things are also unnecessary now, so the reference section
should get shorter.

To alleviate reviewing and translations, I plan to submit the changes to
the reference section in two steps. The first patch will perform all
changes, but will add newlines before significant changes, which will
wrap at 120 characters or so: both things should make it easier to see
the actual changes with ordinary diff. A second patch then will just
rewrap the text to the usual 80 characters boundary.

Side note: the two patches submitted now could and maybe should be
merged into one, but I decided to keep them separate for now to have
section-specific diffstats.

Thorsten Leemhuis (2):
  docs: reporting-issue: rework the detailed guide
  docs: reporting-issue: rework the TLDR

 .../admin-guide/reporting-issues.rst          | 497 ++++++++++--------
 1 file changed, 273 insertions(+), 224 deletions(-)


base-commit: b8cfda5c9065cd619a97c17da081cbfab3b1e756
-- 
2.44.0


