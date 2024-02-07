Return-Path: <linux-kernel+bounces-56520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97D84CB2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6611C267FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A3577F13;
	Wed,  7 Feb 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ikhlTEK/"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1377F0A;
	Wed,  7 Feb 2024 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311359; cv=none; b=sT+myDD5JFeIBkAQn1fzO7+aduYokuVasOtedNhwK/Ai1p75NsvnPsIN733SNuGYWz4sqwR5j1H1WuZ+s8rjmaOxYCz0CK/qSzqv5DDJbrQ+Fi51Nvno9qlt0jtQDAXQh7GzPM2lPkjWL24Xtu/Da0npt43wydYkY2TC0dd7jcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311359; c=relaxed/simple;
	bh=GWAgaDJ3zdRn3qm1MtZe+axa+R6PJ8fMMxWJrbGg7AQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gitN/5VlSPgv1+2mgTH3p6U6SXDKHcz4XZRYMCXbJng2IgJjJ1xkEpmI7wQIPFMFD9xxkAdJDDlsZ5WsWo2PbHWvE+CIo1MV7YKpNrMs5zMxQqq4Z4CBbpDSQSXi+Sc74K8r+eni8ZnoLah9KrvLvBMSTyvt6ClrytmzIbFAoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ikhlTEK/; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TVL6W6k3kz9sw2;
	Wed,  7 Feb 2024 14:09:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1707311347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xxONrTvJa5WGKkunFtaEoZBXl9eRExoEHx1SGG+4XXs=;
	b=ikhlTEK/L4z8v8ELl0gxcfrTW0e38Po69NiBubwHSN+SOYzu5zRmVd9D4U/hu1G0XYYJSW
	hjBMa7Coevc9BrQTTOhJ3xTSVDZVPp3XlyUvpgRzz5U6MpNkF0dHAQoRfBUHWMKK2ft+Cd
	4LB5Pw12gbTkPUdPy0X7QL+K9mXqFVZ9Kt8WFw611WHat/vIpxW2WY1n4RTMg4WjBQPsDr
	azO9ekKjmiqVP80MT92e+I/5DwhDsI8TQmlPsfP//RHz7aAuSF5pN761kasdRNT1GtTFvt
	ySgUISiYpN+GupU7IYMw4Hmm4H1RDP4xlRvdejGzxN9qBb18Fv52dB0ENVhqfA==
Message-ID: <41f82085-8ea9-4ffa-a93a-8e39ce0f4c27@mailbox.org>
Date: Wed, 7 Feb 2024 14:09:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>, Perry Yuan <Perry.Yuan@amd.com>,
 rafael@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org, Oleksandr Natalenko <oleksandr@natalenko.name>
From: Tor Vic <torvic9@mailbox.org>
Subject: [PATCH][next] cpufreq: amd-pstate: Fix min_perf assignment in
 amd_pstate_adjust_perf()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4wcfr81h7xkjb3at6zuheac1jr4e8dqn
X-MBO-RS-ID: 76e10efaad271e17016

In the function amd_pstate_adjust_perf(), the 'min_perf' variable is set
to 'highest_perf' instead of 'lowest_perf'.

Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for 
AMD P-State")
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Tor Vic <torvic9@mailbox.org>
---
IIRC, this was first reported by Oleksandr, hence the 'Reported-by' tag.
---
  drivers/cpufreq/amd-pstate.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 08e112444c27..aa5e57e27d2b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -577,7 +577,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
  	if (target_perf < capacity)
  		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);

-	min_perf = READ_ONCE(cpudata->highest_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
  	if (_min_perf < capacity)
  		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);

-- 
2.43.0

