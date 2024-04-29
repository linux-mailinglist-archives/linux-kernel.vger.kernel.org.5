Return-Path: <linux-kernel+bounces-161848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D498B5226
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535F51C20FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05DF175BF;
	Mon, 29 Apr 2024 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="SXubuxsN"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C059412E74;
	Mon, 29 Apr 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375119; cv=none; b=djL4agYBpTOh2Uceoh/of0nREGl0X05/BfzTbxKHmSLoKqG3aQEuGbQR5bW96zMcoL1cNmsyq4+pA14HRGW+itMBb5GnvOiDzBnB6ForC+OVMywpPwBq2EcdAK2Mudn37esnVBiLCE5xhst3Mngygm52rdCnci2IKZvw3QbbpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375119; c=relaxed/simple;
	bh=6AqRK4s+/gqcB8HzuTUSB8hZRa2UQEfkA8i5t+vDrd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCbXFN8Yb9RtZasfNTGRigkwWC42+pskgEXH9F0T9WfcgD6xidYsNXLmVbsws9mbGNpOTud+LobI2E8AGnPC7G2AjOXm5XI38iLhO5T/WfmXBzg/WTCTF7NsFa7OBjYhNbekQf6stTRkwTI/4ckDRwgIKuz5rz2hjraRFLxmA94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=SXubuxsN; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=iK5q2DNeaWz8v/Rr1pJ400p0iaZpSMomthypDMAXlFY=; t=1714375116;
	x=1714807116; b=SXubuxsNBTGvY/eO3GSmCqGuFMkRfqUHVVucW+zPtMCdn1uUhRLfXMU/Cwzxs
	muthR0bptu+4JrprektYBDoE9kGKec6T11WbZbRwVhz/r3xEkc6uUfXwOrB0KBb+gBl4crxnUCW8j
	dpyjFP2exmdKik28GnPljKHJ282+HxsTBTsPFrg1NcSIYIEKT4uOEH6glM8Dlt9vJLUOpVviQHKUc
	MJwfVO6dQpEEtVATtOkW+HcyW+/AkSnT1IG2QbeqOaxHbs04KIuZdxhe8HXmkWJTJkyu23FMwsccE
	rK+lmbuIZwfIRdN6huxV5Xx6UGvAk58o+4yphP1dj8sMN03ImQ==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1s1LHU-0004e1-VX; Mon, 29 Apr 2024 09:18:33 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] docs: stable-kernel-rules: explain use of stable@kernel.org (w/o @vger.)
Date: Mon, 29 Apr 2024 09:18:29 +0200
Message-ID: <6783b71da48aac5290756343f58591dc42da87bc.1714367921.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1714375116;044ac9ba;
X-HE-SMSGID: 1s1LHU-0004e1-VX

Document when to use of stable@kernel.org instead of
stable@vger.kernel.org, as the two are easily mixed up and their
difference not explained anywhere[1].

Link: https://lore.kernel.org/all/20240422231550.3cf5f723@sal.lan/ [1]
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index b4af627154f1d8..ebf4152659f2d0 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -72,6 +72,10 @@ for stable trees, add this tag in the sign-off area::
 
   Cc: stable@vger.kernel.org
 
+Use ``Cc: stable@kernel.org`` instead when fixing unpublished vulnerabilities:
+it reduces the chance of accidentally exposing the fix to the public by way of
+'git send-email', as mails sent to that address are not delivered anywhere.
+
 Once the patch is mainlined it will be applied to the stable tree without
 anything else needing to be done by the author or subsystem maintainer.
 
-- 
2.44.0


