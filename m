Return-Path: <linux-kernel+bounces-35058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD05838B41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40CAB21C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DDE5A0FF;
	Tue, 23 Jan 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+0Daynv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8D5A0E6;
	Tue, 23 Jan 2024 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003993; cv=none; b=tgNf//JaGje23SXNMNOyvUJ7Cym28JWdJ9RgoslQ2mR+8MrObXoI/CwEHj6ggagTE9Jrlh1vaSbxITDnOm4vK9vv9mB2n0HwL2hq2oY58+MuM30Hh3qgsijLBs8XiMt3ZIxMA4qX4EVPt+eEwCAv55b9BQ7QcC5lWvG88qhLfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003993; c=relaxed/simple;
	bh=jqpnf5fGsPvFFRmwRKHROctIc2OQE3n0al69wZtjoec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ms8Cyjdn95gZ659zbw0keRHejNeAgq5BPT9l2GDW8lOMuOI3BMbEqFEpGyjIHK6FL3t0+HDHiVVvkiGUHND9m8B3Kjm/ffocJrMln8pPxHm0HfA0dg/d1Qncsk440Ep0mxwYlX501/h6d5KaRsbu5dL5q7INzMFNHR8FkmQT7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+0Daynv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AE4C433C7;
	Tue, 23 Jan 2024 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706003992;
	bh=jqpnf5fGsPvFFRmwRKHROctIc2OQE3n0al69wZtjoec=;
	h=From:Date:Subject:To:Cc:From;
	b=D+0DaynvflO1cRwaOP8wZpIpIgv2SXDOhGLfkyQ13lYqX1+vKpP9qfnd9QltllMdx
	 YE/i66Y2voqW6yF4bitynI6M2wyItMiBslWidaXMaTKf/TN6mSiZWDVrImPp71M/gt
	 ZzC+dlfUg+qH6CTmYaluODEsK0F1UIgDmXvZXfc/YdVqloJdVKB9nTx+11SvqQe+NR
	 jopLdTIyWYrLQr6qVf3MISzHI1YXEXf8HhlTtmuD7cc0Jpwo99RuGEf8AiuYsFIOmn
	 GJPNXel6W/8i8Kv4ubSypjglSMCETnLz+WAWiZdAM/p9TULdy06G4zSNl2velVWP8i
	 KVPNt2yD1Q6lA==
From: Simon Horman <horms@kernel.org>
Date: Tue, 23 Jan 2024 09:59:48 +0000
Subject: [PATCH] mfd: rave-sp: Avoid unnecessary use of comma operator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-rave-sp-comma-v1-1-84e9b15ba205@kernel.org>
X-B4-Tracking: v=1; b=H4sIABOOr2UC/x3MQQqAIBBA0avErBtIDcquEi1Ep5pFKgoSiHdPW
 r7F/xUyJaYM21AhUeHMwXeIcQB7G38RsusGOcl5ElJhMoUwR7TheQw6WqxWs15PpaA3MdHJ7//
 bj9Y+DMNSMl8AAAA=
To: Lee Jones <lee@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.12.3

Although it does not seem to have any untoward side-effects,
the use of ';' to separate to assignments seems more appropriate than ','.

Flagged by clang-17 -Wcomma

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/mfd/rave-sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index da50eba10014..aca552890553 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -358,7 +358,7 @@ int rave_sp_exec(struct rave_sp *sp,
 
 	ackid       = atomic_inc_return(&sp->ackid);
 	reply.ackid = ackid;
-	reply.code  = rave_sp_reply_code((u8)command),
+	reply.code  = rave_sp_reply_code((u8)command);
 
 	mutex_lock(&sp->bus_lock);
 


