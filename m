Return-Path: <linux-kernel+bounces-101484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A687A7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752491F215A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8F61EB3F;
	Wed, 13 Mar 2024 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="a+QYS8/j";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="PJ/6X6Ns"
Received: from e2i652.smtp2go.com (e2i652.smtp2go.com [103.2.142.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC9C15D1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333704; cv=none; b=k9ZRHNN3dZR0Mt2rFf9NxNuUvnzHPQbG0Py/J+BGpNQm3qKSENDYH1+TbaT+s71ln5i1+IHDAe/TSYVxFFxl4hR3IjK2TGoLsX+zJaS4dUNl8i+8wuR3LY4o0X2KuCSeghsbAb+Db7xtE95CgQjmg9+Mj9WGAJDKy7daTE+USLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333704; c=relaxed/simple;
	bh=C6Ei12qFq1dwjt7LRGxmcGnHjiV+5QZTSZmgID4wPsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V4PnViYTxBzOyPSGC6TWSSfdc1E78uxoXx0keq88WrPGc9e6AmJw1Aa8qRORLkUzQuIqn63+lfhvF855fWPVtcv9HuOPz9K7SZ7F0uz+sUmooEdDKqJwWsOSio2lDwFl9vXVbBCKDfv7mkiDX05liHRj63XVJib2dPHpc9Emgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=a+QYS8/j; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=PJ/6X6Ns; arc=none smtp.client-ip=103.2.142.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=JVz+0/1IvynSUvZNYS9ttPNeUmoE4X67mo1kcxJZITE=; b=a+QYS8/j86ZWgp+GzX0GC6LqJv
	XZ3CoOhxZ96enAXrYGkTUZJBJOKHi5x6gx9lTwrHsHOCKIZVo4QWnt1c/eEObGXLAUmyoHQ3+LaLF
	an4Y8uLBy3FcD+bAUBAVj4QAbfV6fUXIXWSLeTzTcVuRVidJubiLxRff0oQlLlCifuE7zyirlYiXF
	Hj0QZ9Na6f7EXXSKfmAKLvqymZBRy75nT6lCHyJdOwrsB3C+7v49y4CJoPr0kSsnu+81tTZ1i6uRZ
	7nBy+EH6mEf4uW3ZwwZNw3tifF3lbxrcTsqMdPeI+NovDI+WkLTt/CD19FZqP6F6Cxs273XMqDkAi
	wSX1W0TQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1710333702; h=from : subject : to
 : message-id : date; bh=JVz+0/1IvynSUvZNYS9ttPNeUmoE4X67mo1kcxJZITE=;
 b=PJ/6X6Ns2bzjnSBZysHdfZvg8DyrXjoH3ESae2BRsIBtjxbbJjw+HXxnuva6yxoM/q4xl
 U7xya7ieP3SSgY4jUrqlH5tdautWD6t4Rc7Wg2NjfZg9clYH+SUt87auGWdGY0x5bN1MmiM
 bOvC73DRa6fb8zztHfpB1iTvEG2WyLBwhlpEGQ890CXWaxH+/JqzETnlOX5rWbak88eAZ1H
 Dgycdluu0qDXZXDmSRIen46i9HquTm3N/iz1+TxJqkmr2AkNoYqK4qF8qHP6/oDrvCFKYt0
 hUVgF+333wHxTlZbTPDTgup1dpTLT+c1M3Do7CeoBSC9j7YGfzJ3m6mKXGEg==
Received: from [10.45.79.71] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rkNvK-qt4DT6-JC; Wed, 13 Mar 2024 12:41:34 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rkNvJ-DuzQp3-0d;
 Wed, 13 Mar 2024 12:41:33 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with
 Microsoft SMTPSVC(10.0.14393.4169); Wed, 13 Mar 2024 13:41:31 +0100
From: Flavio Suligoi <f.suligoi@asem.it>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] thermal: qoriq: remove redundant TMTMIR_DEFAULT
Date: Wed, 13 Mar 2024 13:41:17 +0100
Message-Id: <20240313124117.3224601-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Mar 2024 12:41:31.0735 (UTC)
 FILETIME=[C6AD3670:01DA7543]
X-Smtpcorp-Track: 1rkNvJDIzQp30d.8l7B4HLTV3iOt
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sdazqNa4wD
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

The definition of TMTMIR_DEFAULT is repeated two times in the code.
The first time is useless.
It makes more sense to leave this definition after the correspondent
REGS_TMTMIR register definition:

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/thermal/qoriq_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index ccc2eea7f9f5..c29ed179c12d 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -20,7 +20,6 @@
 #define TMR_ME			0x80000000
 #define TMR_ALPF		0x0c000000
 #define TMR_ALPF_V2		0x03000000
-#define TMTMIR_DEFAULT	0x0000000f
 #define TIER_DISABLE	0x0
 #define TEUMR0_V2		0x51009c00
 #define TMSARA_V2		0xe
-- 
2.34.1


