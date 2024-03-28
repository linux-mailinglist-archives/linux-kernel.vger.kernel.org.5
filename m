Return-Path: <linux-kernel+bounces-123495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A1890984
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E1C29192C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8471A1386A5;
	Thu, 28 Mar 2024 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="ZnKiZLpA"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C21134CC0;
	Thu, 28 Mar 2024 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655070; cv=none; b=bBQ2ZUHc2NCC4NeEw9jsIu45K7CydAHUzODXn4hvgQPPowY5w0rOb9d7h6gE4N8KMHdzj5zzOS/uEjbChyQIzcwxwSvEyeOiZg1f87fbAZ7/n1jBolRaZl/c6UVySdKzjOzedVUx5CT8yy9VBDQQwS80M/RRBF9xy0gl/EgkAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655070; c=relaxed/simple;
	bh=BA0p6EgNxcmz4H9GYa0tDJrQXGb/k9OOb1DW6MRHGHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D93ciJp/eBKtKAAqPLr10rVyT7ALvoCjqTWEXoGuCTTyVGhTuYvZPk8W66r1GRjHFEjoV3MK/ESn4YOLEZqxAdxWasxp/kqXLDjJzCzoDuiaTsgS01RIBrTKJO/zPcj2kbO2fpI5lErQfRN07VdKudDZx/fCkzJ3LSt/37BlIcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=ZnKiZLpA; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1711655043; x=1712955043;
	bh=fKOBcit0OLSIvvpbV7fpFKk/+/JlS7VOufh0Oihpa10=;
	h=From:MIME-Version;
	b=ZnKiZLpAu25fer/vfl6cNMeySwxQoMcMbf6GmMyq3xu4asRubhzUFqXPz5c09UhSd
	 b16Vn1Hreeo8E05pUPiJR8DonSmwBwk89f2wG6+XK5m8JylMaK/4WBhgTzMO7wn2QL
	 cKuSGx+D/9g/sHuGzkJgM/9wst1QDTlWpn3yBoQDojh54o+VcR/rpEikhU2/kh4Etq
	 Bw7R3xF2GXjALShGFtEK3hp88TXXW0yGTpuYtIMExdvO+DGn4MgEwg4x9Y8mXqUzZp
	 /E4/WW9naIKWQRyLeo2CTG5u5VFlhMlZyVcdw8VevDkg+fV8lakzONsPZZ4ybB/B2/
	 N8XSN5fr1Povw==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42SJi0QS074668
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 20:44:01 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet <corbet@lwn.net>,
        regressions@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Cc: balejk@matfyz.cz
Subject: [PATCH 0/2] regressions documentation improvements
Date: Thu, 28 Mar 2024 20:29:14 +0100
Message-ID: <20240328194342.11760-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

this small series suggests two (hopefully) improvements for the
regressions-related documentation texts.

The first one is perhaps unnecessarily nitpicky but if nothing else, it
at least adds a missing word.

The other one tries to clarify for future readers a question which was
on my mind through the whole process during my first attempt at
reporting a regression.

Please take a look, I am eager to hear what you think.

Thank you, kind regards,
K. B.

Karel Balej (2):
  docs: *-regressions.rst: unify quoting, add missing word
  docs: handling-regressions.rst: clarify that "Closes:" tags work too

 .../admin-guide/reporting-regressions.rst     | 10 +++---
 .../process/handling-regressions.rst          | 32 ++++++++++---------
 2 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.44.0


