Return-Path: <linux-kernel+bounces-39646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932983D436
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA46DB21459
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA814266;
	Fri, 26 Jan 2024 06:09:26 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71844BA2D;
	Fri, 26 Jan 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249366; cv=none; b=GsUAiFsIZA8Zsc+huI+ub7iMecrACTUxS5OVgO/rtzBrzd3TdiYv/fRbzioNrIPuysurlSy1Ek9/wAIlFXidaG6spUxjx2klSqiPHvFw5iwDeZy26YoRGqUVsRDeHe8QowXBGkcjl5JvhD9eqMHQu71IqXaPg+lhXuiAB/sckss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249366; c=relaxed/simple;
	bh=/d1wqQ1bV1Dlsc9JT0cEN9QSVyzjArI7JRAqWb6sDUA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XyqtrwUD6KwhLQsWtFRcm9P9YRuDddqhnt28sCBIb9wcw5G+AeanIrrx6XpvRQBm2SjNTc7u81YYiYqUKNP+x0cK+hmFShrAL3JY+88Et00AK7PfCbFswnmNGrTrDNHwPEVWStk33Ea9UFLkthOtz6yxeMhElBwUTvbQP/T9A5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rTFOz-0000QD-B0; Fri, 26 Jan 2024 07:09:21 +0100
Message-ID: <f15eb882-99c4-4248-acd1-39bfa6dfcfe9@leemhuis.info>
Date: Fri, 26 Jan 2024 07:09:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Consider picking up "wifi: ath11k: rely on mac80211 debugfs
 handling for vif" rather sooner than later
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 Kalle Valo <kvalo@kernel.org>, Benjamin Berg <benjamin.berg@intel.com>
References: <3bfb5c07-664e-49cd-a470-635a36bcf806@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3bfb5c07-664e-49cd-a470-635a36bcf806@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706249364;d49e159d;
X-HE-SMSGID: 1rTFOz-0000QD-B0

Reply-to-self with fixed subject. Was likely a stupid idea to take a
earlier message and adjusting it early in the morning, as then these
things happen. Sorry for the confusion. Ciao, Thorsten

On 26.01.24 07:02, Thorsten Leemhuis wrote:
> Hi stable team, JFYI, yesterdays mainline commit 556857aa1d0855 ("wifi:
> ath11k: rely on mac80211 debugfs handling for vif") from Benjamin
> contains no stable tag, but a Fixes: tag for a 6.7 commit. So it guess
> you will pick it up anyway. Might be worth picking up rather sooner than
> later, as it fixes a regression that according to Kalle causes ath11k to
> crash during suspend:
> https://lore.kernel.org/all/874jfjiolh.fsf@kernel.org/
> https://bugzilla.kernel.org/show_bug.cgi?id=218364
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.
> 
> 

