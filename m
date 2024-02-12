Return-Path: <linux-kernel+bounces-61373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A12851180
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6B2B25517
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6EE20DE8;
	Mon, 12 Feb 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caw9aptx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585538F86;
	Mon, 12 Feb 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734891; cv=none; b=DW4x9e9Nf3G7w0GC69RpW+P+NwmfrTCH++a64r4LOl+9l3frbt8UWiNeaxoNC838XWEJEdy/VAq1FwqRERWQe9gVe8E3jPkv2+oM+iwWFTDnNANNklQCefqiAzgGKh30mzWkRtRQwyPQungJl9I4bTQ5OYboCBB+t1zLE67bhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734891; c=relaxed/simple;
	bh=33VlHW6tG6RBpKyaXFo4ViMfDvaBlB4JaKCY3aSVkss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VQlz0kHPTwH+eqb3krPPGxipi39ut9gJ5stW8eTOnnYA0jHn/FGM63Mi3ccOYWtW3nYpCDR2QtRUbQX5/KT+rssVmS5+apqPrkGbcddiYCKAEuO7ABDoUEtNqMPoUeieVlsRar6sHxND1C8ZHHebRQz2ioRjKCQcpz1lw48XeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caw9aptx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D62C433F1;
	Mon, 12 Feb 2024 10:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707734890;
	bh=33VlHW6tG6RBpKyaXFo4ViMfDvaBlB4JaKCY3aSVkss=;
	h=From:Date:Subject:To:Cc:From;
	b=caw9aptxYciK7woZ+Znptsxd+4JBaSsjf2+XrG+nV4ndr1u+Dk2b59hPjR56TLQE+
	 XGsDayWpjFXjoXtCDMhNMpf9AO6j80zBcBKt5dYbkIYTpzH5blqPhpfTJoWJLNiYjM
	 smMiz5yiWAbpevF0Yej20x5KC7qsWF61hIFBbkWgkGpZwJOBTXG5KUTgjIZp2gmBbO
	 ia9KOhB9r+eS1E7qGeWyH9TOhhiRmyWvDiMn9qXvPH+IeqsiHHR8nZrrS7h5AhILj7
	 Dg/GRSc9/osqPXnZbZbpcRiO9vh5Q0aSK19z5NUOZ9YebPzq6++wyL2yCW2roYwkl3
	 fnp7iTw/RFb7Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 12 Feb 2024 11:47:14 +0100
Subject: [PATCH] configs/debug: add NET debug config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
X-B4-Tracking: v=1; b=H4sIADH3yWUC/x3MQQqDMBBG4avIrB1IhtpFryJdaPIbh5ZRkioF8
 e4Gl9/ivYMKsqLQqzkoY9eii1X4tqEwD5bAGqtJnDyceOFPWGzSxBHjlhg2jF+w4cdBYnh650Q
 6oZqvGZP+73X/Ps8LnkNLImoAAAA=
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Qian Cai <quic_qiancai@quicinc.com>, 
 Kees Cook <keescook@chromium.org>, mptcp@lists.linux.dev, 
 netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=33VlHW6tG6RBpKyaXFo4ViMfDvaBlB4JaKCY3aSVkss=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlyfdo2EU3gz8te8tWN2NgzXSfDNfXwe0Vg1Nu+
 cfZL5tRm2iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcn3aAAKCRD2t4JPQmmg
 c2HYD/0SmdRvuXq/A7Au2J0oT3t9EzkMu7KVbSKecDAxR/eUcjb4zqviltUibKCFnLmSjI2ytEa
 AdItLkDYHRZVWCuOOkgiHNLxb01uqpSzvkQMLvvzgh85rW1ajWrjoQ3OpwZqMJNX+xvYXh5wcMr
 4sbyDH88vMyDqXEkP40JgzPDWJ7Iu/9BUNWy0+fXOO3kvkg5xbRnkZlrARWHDTXGlTpCRoBDaqp
 h/Lx27W9to+iLxxGScjErd4nG7BTFnSGN1srkA8CCu5nYzAe1tSoMHI4jcRyIAOYMgqPM/R028h
 BRdVVuVH3U1c2PLjey4iVlXxuS5Wi6AC7+9pguUb/CMCPT4CyXow1zXWW2iLmVWUVX35Z2XkJ+n
 0U2FnNcmx6BbqgA8kVCPDWgRMNZWhq7lZSX//9+1pH1/LTHPtSn1YH2igNlDuKkrvR9Yx2fKzgu
 hYtc9/qiloDNkWUnc3E8Gz8lZgmB8YVmOStl2k61MM9W34wylfftOZAMRi11P/8VVh168F+xJXS
 g+mN31xdrtqXbVW3cWbQwAxj4gl8NUx1SXgpiVkk4FWD5E0HOTGlLykdzrrcscGF7j9YrEPDaz+
 nWoqdsKBORqV5j+3UH1lefvjxhJMKm7VaJG2Lps/APVnzkWJHxMJBWy7PJbElZ8vOVUGrOvatBa
 UgS7P+J0YKmXiHw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The debug.config file is really great to easily enable a bunch of
general debugging features on a CI-like setup. But it would be great to
also include core networking debugging config.

A few CI's validating features from the Net tree also enable a few other
debugging options on top of debug.config. A small selection is quite
generic for the whole net tree. They validate some assumptions in
different parts of the core net tree. As suggested by Jakub Kicinski in
[1], having them added to this debug.config file would help other CIs
using network features to find bugs in this area.

Note that the two REFCNT configs also select REF_TRACKER, which doesn't
seem to be an issue.

Link: https://lore.kernel.org/netdev/20240202093148.33bd2b14@kernel.org/T/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - It looks like this debug.config doesn't have a specific maintainer.
    If this patch is not rejected, I don't know if this modification can
    go through the net tree, or if it should be handled by Andrew.
    Probably the latter? I didn't add [net-next] in the subject for this
    reason.
---
 kernel/configs/debug.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index 4722b998a324..509ee703de15 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -40,6 +40,12 @@ CONFIG_UBSAN_ENUM=y
 CONFIG_UBSAN_SHIFT=y
 CONFIG_UBSAN_UNREACHABLE=y
 #
+# Networking Debugging
+#
+CONFIG_NET_DEV_REFCNT_TRACKER=y
+CONFIG_NET_NS_REFCNT_TRACKER=y
+CONFIG_DEBUG_NET=y
+#
 # Memory Debugging
 #
 # CONFIG_DEBUG_PAGEALLOC is not set

---
base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
change-id: 20240212-kconfig-debug-enable-net-c2dc61002252

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


