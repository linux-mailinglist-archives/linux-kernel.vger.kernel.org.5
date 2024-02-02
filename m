Return-Path: <linux-kernel+bounces-49761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB05A846F0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876AE28D7E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B563813E22E;
	Fri,  2 Feb 2024 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNXEhKz9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE68004D;
	Fri,  2 Feb 2024 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873681; cv=none; b=IoBgn7/0xXEyOpQVrIkwQbSeZxZ5SnesN4QruwSNnT5mXEIKUCpmdpJ2Z1aXFTVyOfE0PgjapTBf6X7swR07xAL07qpKVcxHd64QQpvOyjaR2Sjj2HqXsM+VyfX/MfwYX9SvxSLVwBl49vVz2TFwcR2+uRnTsRMreV2hr/sedPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873681; c=relaxed/simple;
	bh=Z36sUISol3n1H+J78EhfUyh0WQQhwLEyy3cNNNXjhiQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=V8dmq3gOvGKvzKAtY0QKbwZAiiM75mrXUL67sqCk/RvXewx/WKsKfSj5ove4NrUzdZDUWViRKeNO2t91HIJ3oiDpJtZuPfPu6XY9Vdorouhc+v4RFZ6v3OYl2/+Dwk2pEKx59iH03qzTOA4KR1idm9TIEBZIhk0pNtepLOMAqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNXEhKz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A26CC433C7;
	Fri,  2 Feb 2024 11:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706873680;
	bh=Z36sUISol3n1H+J78EhfUyh0WQQhwLEyy3cNNNXjhiQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kNXEhKz9vpzYEYHotUm9jbF5xmG9z6zj5c6clJDRXC6WseHwGOl1onWD74n3wsU7o
	 yfOJF1YaMVa/RZbTgWSN+xW7VEC6/+YI+YqoUf46ncZ2qTP2DOmqRemE2HxPmXLnSK
	 xhNaQ7QVkXqE00lq+RnsFeu9QMYziVNhyPtNE2qX8dPPrtgWK9+PdloU0t8vwAKQHE
	 9W0TRDBK7T0MgpZrmf3LE8znLgI6UYT/ZrtVt8I+T7L/srBU1xI8yuwacbwc1Lydg7
	 1kA1MG9ymiI+aYy0HUeIXR6c8ilY22qGuKfUoCpkqqN1gKSHPyWWRcNeEMasEQ2vpn
	 n1CSoM6oXBtmQ==
From: Kalle Valo <kvalo@kernel.org>
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
  ath11k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [regression] ath11k broken in v6.7
References: <874jfjiolh.fsf@kernel.org> <87frytg7b8.fsf@kernel.org>
	<878r4lg3t8.fsf@kernel.org> <87jzo13jmf.fsf@kernel.org>
	<94150b26-bdd9-49c2-82a1-26ff46c9d32a@leemhuis.info>
	<87fryp3he0.fsf@kernel.org>
	<0253854a-e5f9-4316-bec3-61aaf3ebfd1a@leemhuis.info>
	<871qa0xtk6.fsf@kernel.org>
	<ccbb3aeb-daa1-49ba-b729-964bd97748bc@leemhuis.info>
	<87r0hvta9a.fsf@kernel.org>
	<0c8e379b-91fa-4e02-8758-aeee01024c93@leemhuis.info>
Date: Fri, 02 Feb 2024 13:34:37 +0200
In-Reply-To: <0c8e379b-91fa-4e02-8758-aeee01024c93@leemhuis.info> (Linux
	regression tracking's message of "Fri, 2 Feb 2024 12:29:11 +0100")
Message-ID: <87mssjt7zm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:
>> One more question, I promise it's the last one :) When using the Closes
>> tag in patches does it matter which URL is used, either the original or
>> the duplicate? For example, do these both tags close the issue:
>> 
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=325423423423542
>> Closes: https://lore.kernel.org/not_relevant/msgid-423423423423423423/
>
> Yes, you can use either or both of them together to make regzbot close a
> issue and it's duplicates. But to make Linus happy I guess he'd prefer
> to have both links in there, if those are reports from different people
> that contain background information that might sooner or later be handy
> to have at hand.

Good point, I didn't consider that. I think I have now a good grasp of
regzbot and I'll try to use it actively from now on. Good luck for the
rewrite, I hope you get it finished soon.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

