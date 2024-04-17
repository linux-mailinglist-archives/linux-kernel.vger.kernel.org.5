Return-Path: <linux-kernel+bounces-148550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 451548A8448
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD2BB266F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB3213F444;
	Wed, 17 Apr 2024 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="V0kcuIDc"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0013D626;
	Wed, 17 Apr 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360091; cv=none; b=CAooz5z+7hMOyvuu6vh5hbFFK3oIxwq9fZ7Q/ZpRNnWukJPLgSs7rWRtBOmnAqlSG4I2fjyQRN130VPurBphct+W7wDBNcXuyocpexTdu2CTfMJL5g/1wgGzAUJLWgEMC0fsVfiRKJqnvG6TNBgUHBj9/lul8iEU0aPM55lNcyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360091; c=relaxed/simple;
	bh=/NZ0RQIi3nqKByWv1Wl+CqCZ7YVkUOO4rBSu1lPL8qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqHSRhwMDfEL6lumF70eM3fi1vW2zV9g3UBqI9/nKmTcYPQjs9RsB+PE/OtZAl7hjNkDSNlyTsMfmnoHKlRznWMYYYnuIJHHxHssU0evAmoAalKwRWFBJahn1CEGZO1ekawBCzq20PL7ehWAuWa1IaZSdWcrUTqMAp59vV1hLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=V0kcuIDc; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Kgrqtwphnc8wVTX12ewbpNQ26rIIXy3b1ktkxRpdaIQ=; t=1713360089;
	x=1713792089; b=V0kcuIDce9QR84iQXrr3W8XSDWX9+iyav/jMN9EraYOsskyE1f5BTKn4MxGNT
	u5rWfI378SwU1n7bb/XJQ3wEgpOpUe5PfAIE47nNa5gf+7H8K4yEREYkVnreoRyj/WM2x9Vsz70H6
	fbKo5B8TpWN/dWb5AQTQIPcYhuGKWyQdCC3sp5vVwcvKqHX06a/c8I02XUI702xWApv8DoDaW7f/K
	qlj6Ot1Jjb6npM3R/r1CfV8nsFe+zGx54qaF6/M5skrWxOmGpjlR4hxIZDdPxeRP7RoEUKoPXJVA1
	9A8mgSq+mZ4HuxCpwsFN3/oll7MfqSJVHPxddF6f8P45x67Yhw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rx5E7-0000m3-Or; Wed, 17 Apr 2024 15:21:27 +0200
Message-ID: <e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>
Date: Wed, 17 Apr 2024 15:21:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: helpdesk@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417-lively-zebu-of-tact-efc8f3@lemur>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20240417-lively-zebu-of-tact-efc8f3@lemur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1713360089;acf7db00;
X-HE-SMSGID: 1rx5E7-0000m3-Or

On 17.04.24 14:52, Konstantin Ryabitsev wrote:
> On Wed, Apr 17, 2024 at 09:48:18AM +0200, Thorsten Leemhuis wrote:
>>
>> Could you please create the email alias
>> do-not-apply-to-stable@kernel.org which redirects all mail to /dev/null,
>> just like stable@kernel.org does?
>>
>> That's an idea GregKH brought up a few days ago here:
>> https://lore.kernel.org/all/2024041123-earthling-primarily-4656@gregkh/
>>
>> To quote:
>>
>>> How about:
>>> 	cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
>>>
>>> and we can make that address be routed to /dev/null just like
>>> <stable@kernel.org> is?

First, many thx for your feedback.

> That would make it into actual commits and probably irk maintainers and 
> Linus, no?

Yup.

> I also don't really love the idea of overloading email 
> addresses with additional semantics. Using Cc: stable kinda makes sense, 
> even if it's not a real email address (but it could become at some 
> point), but this feels different.

Okay.

> In general, I feel this information belongs in the patch basement (the 
> place where change-id, base-commit, etc goes). E.g.:
> 
>     stable-autosel: ignore
>     [This fix requires a feature that is only present in mainline]
> 
> This allows passing along structured information that can be parsed by 
> automated tooling without putting it into the commit.

That afaics makes them useless for the stable team (Greg may correct me
if I'm wrong here), as they deal with the commits and have no easy,
fast, and reliable way to look up the patch posting to query this. Or is
the "patch basement" available somehow in git for each commit and I just
missed that?

Guess in a better world we might use "git notes" for this, but we
currently do not use them because they iirc are somewhat tricky (they
are easily lost on rebases iirc is one of the reasons ) -- and starting
to use them just for this is not worth it.

>> There was some discussion about using something shorter, but in the end
>> there was no strong opposition and the thread ended a a few days ago.
> I feel this is a significant change to the workflow, so I would like the 
> workflows list to have another go at this topic. :)

FWIW, we could go back to what I initially proposed: use the existing
stable tag with a pre-defined comment to mark patches that AUTOSEL et.
al. should not pick up:
https://lore.kernel.org/all/c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info/

Ciao, Thorsten

