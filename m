Return-Path: <linux-kernel+bounces-97145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA29387660B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950D82852E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E6C54BF1;
	Fri,  8 Mar 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MZc6NNaY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4D48CE0;
	Fri,  8 Mar 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907019; cv=none; b=ZozyZgNt4P+8LYh03judVkRHtoVEoHwQS4hBWkxh60EWT/Ru9fcZ98D5g5szr5BxzpPvOAAOUD8LFP2pWiidikqgKWJtzE/cEbTHPLGD/pzpT1WKPPRSHpy1VD+54cxaFLQQYQHihZOBocIwk/YDFbr/mS5auvO67/6veAjUbkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907019; c=relaxed/simple;
	bh=Db27v9MUEFpeHNz5Y4ZJHqQ71hj6+AjIuAsZ6om6S4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltj0aKW0WvpjsQro7EX1vH2BGEIOMVTr+RXqMRBJ2b0zb263IqGc51gx7hq4utenRZ3BibVL0FWqfQq3J/73EtzXVdVKDLO25EqAmcK/xzEi6EMZnD6yoJ6Vbv+Urn2aDpg8AfNWc1rP0L9HzpDls2EeV8g5diKOMKPbSbKAOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MZc6NNaY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709907016;
	bh=Db27v9MUEFpeHNz5Y4ZJHqQ71hj6+AjIuAsZ6om6S4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MZc6NNaY8YuC/v4VglVkm2FwnfgVOAwewkCoVOW1oflUznd0D4d/8pSPqEnXTGRYo
	 KxZ4c9vbi+fmhAet1Uhontpfnp5z9zVIRLeErUIg3ffNHso90q/Iinl2LZMCPNHdIr
	 230xLe99/Oq4fC+CcAmB2u9NhcfGELUfBn2tF0X4mDam+5Fy4jml6SgDAYil5wd1ZE
	 3A7/Zh58Xl7l+sTqm7JznLcz3z62YwzEb5h0FZeJCEnZdhbwJJJkAlJIWS9SC/Gv1z
	 3q4pJbaLeMnVdfJt2auL1d2h83YSAAB/dziQBN/7rfPVA58EZFRLzNaRadTYSku/sm
	 5Cjl1Ww6X32kw==
Received: from [192.168.1.13] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BF64937820F4;
	Fri,  8 Mar 2024 14:10:14 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 08 Mar 2024 09:10:00 -0500
Subject: [PATCH 2/2] docs: handling-regressions.rst: Update regzbot command
 fixed-by to fix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-regzbot-fixes-v1-2-577a4fe16e12@collabora.com>
References: <20240308-regzbot-fixes-v1-0-577a4fe16e12@collabora.com>
In-Reply-To: <20240308-regzbot-fixes-v1-0-577a4fe16e12@collabora.com>
To: Thorsten Leemhuis <linux@leemhuis.info>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, regressions@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

On the reference documentation for regzbot, the fixed-by command has
been renamed to fix. Update the kernel documentation accordingly.

Link: https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
Link: https://gitlab.com/knurd42/regzbot/-/commit/6d8d30f6bda84e1b711121bb98a07a464d3f089a
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 Documentation/process/handling-regressions.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
index 42b13f77b019..ce6753a674f3 100644
--- a/Documentation/process/handling-regressions.rst
+++ b/Documentation/process/handling-regressions.rst
@@ -432,7 +432,7 @@ or itself is a reply to that mail:
  * Mark a regression as fixed by a commit that is heading upstream or already
    landed::
 
-       #regzbot fixed-by: 1f2e3d4c5d
+       #regzbot fix: 1f2e3d4c5d
 
  * Mark a regression as a duplicate of another one already tracked by regzbot::
 

-- 
2.44.0


