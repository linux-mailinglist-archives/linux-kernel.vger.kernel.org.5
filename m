Return-Path: <linux-kernel+bounces-39642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2947E83D423
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1DB1C20E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A65D310;
	Fri, 26 Jan 2024 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwdAebmF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5199510A1E;
	Fri, 26 Jan 2024 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249223; cv=none; b=DrxwIUgAlXuFzmUFW/w3Dvp9mNm0LSymNIK1VBtUFB0y77zBU8JcckyKNVz+tQVwb9A0CQYSkCWz+WFih7hVgeuX//z740pYS9h0L++IHYsEDkefLEPTMDW1vNTvLk6yMj/a/7acprzCIUubmCkcLy/zJVHCFahUlrdf/8nrhyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249223; c=relaxed/simple;
	bh=Rwtxc+Dc2BLkxO+V8Dz2wt33cbpIubHKLZXOqbvU/G4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KsEjc3uETELVxJt2+8894DtFh+YcPVIbrewy9FGf2w0t9OnuQ6xoZsYT2vH4RRjA61m9XTn9DS+cMb/Iq4L8+UWbqFWPXdM8week9MqwK5WCQXdxNswAtZK4zMZsACqIkIVlgu3tdhkpNkXk61FrHzbVWQf6K3MHCUkg0EL1Ky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwdAebmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A746C433C7;
	Fri, 26 Jan 2024 06:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706249222;
	bh=Rwtxc+Dc2BLkxO+V8Dz2wt33cbpIubHKLZXOqbvU/G4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FwdAebmFCuoCOLvnN7eL2WlUDnG2IU6NfUz7aMmzc+VL344iBSdgO9OgeTsY/ah8g
	 JKWGAhbT68sEAvyl+0h6gTDsi7w4JElnP1xsiWgbMSG2paHLLl4WqOZW56bWFFwFtI
	 z1656XLAhkje7rzyktPoIPbyvuwA4rOEQVDjjniOjcLMJwsZtt7FGxzbYCxOSfN9zP
	 dI4vwU7hkW5BT43UR9a3WTp3v2ZNj0BvtqnfAq9hzj4SWsfq3HtHWtvPH3cH+FTg41
	 8kchidonLm/1bsP/aCpiaVlZaqar3MNIIGSQpasLUuOPJK9ykQX8w1+lnAVU5g7JOr
	 iO9Y8EPH3ZBEg==
From: Kalle Valo <kvalo@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,  Greg KH
 <gregkh@linuxfoundation.org>,  Sasha Levin <sashal@kernel.org>,  Linux
 kernel regressions list <regressions@lists.linux.dev>,  LKML
 <linux-kernel@vger.kernel.org>,  netdev <netdev@vger.kernel.org>,
  Benjamin Berg <benjamin.berg@intel.com>,
    linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: Consider picking up "tpm: Enable hwrng only for Pluton on AMD
 CPUs" rather sooner than later
References: <3bfb5c07-664e-49cd-a470-635a36bcf806@leemhuis.info>
Date: Fri, 26 Jan 2024 08:06:58 +0200
In-Reply-To: <3bfb5c07-664e-49cd-a470-635a36bcf806@leemhuis.info> (Thorsten
	Leemhuis's message of "Fri, 26 Jan 2024 07:02:43 +0100")
Message-ID: <87mssszkzh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

+ linux-wireless, ath11k

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> Hi stable team, JFYI, yesterdays mainline commit 556857aa1d0855 ("wifi:
> ath11k: rely on mac80211 debugfs handling for vif") from Benjamin
> contains no stable tag, but a Fixes: tag for a 6.7 commit. So it guess
> you will pick it up anyway. Might be worth picking up rather sooner than
> later, as it fixes a regression that according to Kalle causes ath11k to
> crash during suspend:
> https://lore.kernel.org/all/874jfjiolh.fsf@kernel.org/
> https://bugzilla.kernel.org/show_bug.cgi?id=218364

Thanks. The subject doesn't match the body but I guess that's just a
copypaste error :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

