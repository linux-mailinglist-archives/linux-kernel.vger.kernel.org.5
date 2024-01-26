Return-Path: <linux-kernel+bounces-39640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EFF83D41B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688971C230EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754DED26D;
	Fri, 26 Jan 2024 06:02:49 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478FC128;
	Fri, 26 Jan 2024 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706248969; cv=none; b=g3CmNa8KBLqFQFZ/NBxxyUaKgmQd+aFwo2VN5ycOcFQJADM5MPFU6L/jnz3abxStR9OF3OHN405B6Wh8OfGMSIwIfwPu/QL0EttSveUeHfS4SiPvWvtOI5FcOp+MO0IpCCS2LZXgyfHfsf4k9IfqPtRhk8S/A+gokK4THCNVS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706248969; c=relaxed/simple;
	bh=IL9oMDaClY0uotAhvsBw9ZIFBnxI1w+GXSWMxgTnCS4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=BUUAkkzkcC4I8ISzLMc8Ixia3JSXfCWD+9IgEhlYAT9wlLzqkflDvqEpZ9azHWCOhDfvwRl/GSnxN2pVijKe+ictepyUhzVWqsedI/IEL4HdSX4gXSi/aavRfYZX83buCyMz962uDnbAvuJwmgDndQGm3zqbfed44qY3AmxZYkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rTFIZ-0007tI-Uv; Fri, 26 Jan 2024 07:02:44 +0100
Message-ID: <3bfb5c07-664e-49cd-a470-635a36bcf806@leemhuis.info>
Date: Fri, 26 Jan 2024 07:02:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Consider picking up "tpm: Enable hwrng only for Pluton on AMD CPUs"
 rather sooner than later
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 Kalle Valo <kvalo@kernel.org>, Benjamin Berg <benjamin.berg@intel.com>
Content-Language: en-US, de-DE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706248966;a7456984;
X-HE-SMSGID: 1rTFIZ-0007tI-Uv

Hi stable team, JFYI, yesterdays mainline commit 556857aa1d0855 ("wifi:
ath11k: rely on mac80211 debugfs handling for vif") from Benjamin
contains no stable tag, but a Fixes: tag for a 6.7 commit. So it guess
you will pick it up anyway. Might be worth picking up rather sooner than
later, as it fixes a regression that according to Kalle causes ath11k to
crash during suspend:
https://lore.kernel.org/all/874jfjiolh.fsf@kernel.org/
https://bugzilla.kernel.org/show_bug.cgi?id=218364

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

