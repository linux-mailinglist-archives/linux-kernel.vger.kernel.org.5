Return-Path: <linux-kernel+bounces-49814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED5846FD0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6990F1F2A7AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85513EFEF;
	Fri,  2 Feb 2024 12:09:22 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE47764F;
	Fri,  2 Feb 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875762; cv=none; b=KNEUQX7MSPpiWS8jwsJecuxrW+33K6RH9/2zPjOeFR7qknAgUQxDxOwCJbIXupw+7vrNyh6voY0gPOYcHyh9o9XsX1Eaj3IBN3thHHw36iZc7/tqd9jVMwO4lYWdo1TmD6N8QCDoNxDKgfYHjwVpGcxtHur2YE57HkgHYNYrJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875762; c=relaxed/simple;
	bh=z8+ru+TQQ7IeURiNr3TDqTzdO+XhmrT/SNMv0JDZ1mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxCF1SXqXHleLsq+8qxo9v2movlQLHN7w67HT36Yw1GyPPUrQYtRdVJXPTbkcq/X0Vm1jCmfRJTz7xhUxTDlNnRZXiUY9cSx4TRNS3vTUMej39az1Kl7ZfaKuEUd12/sjUa82cSz4U3Tk0VktH3voXbCn22ptSI8bgMewobtql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rVrjM-0002A8-EW; Fri, 02 Feb 2024 12:29:12 +0100
Message-ID: <0c8e379b-91fa-4e02-8758-aeee01024c93@leemhuis.info>
Date: Fri, 2 Feb 2024 12:29:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] ath11k broken in v6.7
Content-Language: en-US, de-DE
To: Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <874jfjiolh.fsf@kernel.org> <87frytg7b8.fsf@kernel.org>
 <878r4lg3t8.fsf@kernel.org> <87jzo13jmf.fsf@kernel.org>
 <94150b26-bdd9-49c2-82a1-26ff46c9d32a@leemhuis.info>
 <87fryp3he0.fsf@kernel.org>
 <0253854a-e5f9-4316-bec3-61aaf3ebfd1a@leemhuis.info>
 <871qa0xtk6.fsf@kernel.org>
 <ccbb3aeb-daa1-49ba-b729-964bd97748bc@leemhuis.info>
 <87r0hvta9a.fsf@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87r0hvta9a.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706875760;ac4213bc;
X-HE-SMSGID: 1rVrjM-0002A8-EW

On 02.02.24 11:45, Kalle Valo wrote:
> Thorsten Leemhuis <regressions@leemhuis.info> writes:
> 
>>> So, in the new interface, how should I handle a situation that a
>>> regression is first reported on the mailing list, added to regzbot and
>>> later there's also a bug report opened for the issue?
>>
>> You will have to options: reply to the first report with a "#regzbot
>> duplicate https://bugzilla.kernel.org/show_bug.cgi?id=325423423423542"
>> or add a comment to the bugzilla ticket pointing to a report already
>> tracked by regzbot, e.g. "#regzbot duplicate
>> https://lore.kernel.org/not_relevant/msgid-423423423423423423/"
> 
> Oh, regzbot also follows bugzilla comments? Didn't know that, very nice.

Right not it only notices them. Commands in comments are not supported
yet, but will be once the partial rewrite lands.

> One more question, I promise it's the last one :) When using the Closes
> tag in patches does it matter which URL is used, either the original or
> the duplicate? For example, do these both tags close the issue:
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=325423423423542
> Closes: https://lore.kernel.org/not_relevant/msgid-423423423423423423/

Yes, you can use either or both of them together to make regzbot close a
issue and it's duplicates. But to make Linus happy I guess he'd prefer
to have both links in there, if those are reports from different people
that contain background information that might sooner or later be handy
to have at hand.

Ciao, Thosten


