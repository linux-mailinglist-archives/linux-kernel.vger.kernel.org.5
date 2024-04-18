Return-Path: <linux-kernel+bounces-149746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E4A8A9553
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E65CB20EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A96315AD83;
	Thu, 18 Apr 2024 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="LIimsa/f"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055715AAC9;
	Thu, 18 Apr 2024 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430133; cv=none; b=hESICLKiG3sOwBJVrgfLEsLLMhKnC5++Jpj+gfcKDHLGDHJdTSDv5HMWTSEc4zpyrjgNFbGgnNyzAa39BZgMlCJZi0JZaDbujYNbVWyFug7b94WG2poRZIhirBPbubotSJd3GQLAZqNLYrBQywy2xl2dZ2uu0XRDs6C5jski6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430133; c=relaxed/simple;
	bh=cCZcSL0YIDAF5qz+4wzip6oQvBGsMJ9ti10QUAp/PH4=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=lxTPN1I34wHUwfhlxvUd6ai6Hf6B9ohVm+e8iQU/+4k1lQW1VxT349mAxRxNoNTrp3St5OKYxaeSxL0/33FO/7GtIlHFmEYaMM8FsGSuVTM+DSM8+4yDz5nXAEhJxAM9OTFn2IUDi1DwYFZLzd1MedYfG9crslaPqH8a0rUWl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=LIimsa/f; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:Subject:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To
	:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ceJILIOVA2WDBG4d054KS51MjWUMSrgtQobFchiud7w=; t=1713430131;
	x=1713862131; b=LIimsa/fAMNjDmSmZRH9wMKuyxY3DkeZSljscBj73THRs7plnK0OGTVxDGE0q
	JT7B9WYprfRkMq0eQoxxTT+A2+eM23K2I0kcAKY6jC4f090lXVweIl3ScSTR7fg+3yZCGrt/WafEi
	OfXlcoXU/+A3hXEZUF/9eeEcUMeM+dW+Aw8k0ZKn9OaRQJ/LhuoeaZBFHavy+Pgv2F7/2cBp4KCdY
	reSWHyg8ABuy2COuAlZAv31NJXWE0Je6sOdqMLoSl/brOylI2uFKJ6TxRT2CYLrH2UQHVJXPdzN7I
	3CW5KQ4ZiOOFvGanEzLJ9eWJpobnIDTvmeHmCR7SP3/SLqqaQA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rxNRi-0004qb-BO; Thu, 18 Apr 2024 10:48:42 +0200
Message-ID: <e17e5bf2-657a-4a22-a925-94db95fe8ca1@leemhuis.info>
Date: Thu, 18 Apr 2024 10:48:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: [regression] Tri-band AMD RZ608 (MediaTek MT7921K) has 6GHz band
 disabled in kernel 6.8 despite working in <=6.6
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713430131;169e7109;
X-HE-SMSGID: 1rxNRi-0004qb-BO

Hi, Thorsten here, the Linux kernel's regression tracker.

mt7921 maintainers, I noticed a report about a regression in
bugzilla.kernel.org related to your driver. As many (most?) kernel
developers don't keep an eye on bugzilla, I decided to write this mail.
To quote from https://bugzilla.kernel.org/show_bug.cgi?id=218731 :

> On kernel 6.6.27-1-lts, running `iw list` shows that 6GHz channels are supported:>
> [...]
> Similarly, discovering and connecting to 6GHz APs works fine.
> 
> However, in recent kernel 6.8.5, running `iw list` shows that 6GHz channels are disabled:
>
> [...]
>
> And scanning or connecting to 6GHz APs does not work. 
> 
> There's nothing in `dmesg` that differs between boots of the two kernels. On 6.8.5, 6GHz band doesn't work like it did on previous kernels. 
> 
> I can provide more logs or help debug the issue if needed.

See the ticket for more details. Note, you have to use bugzilla to reach
the reporter, as I sadly[1] can not CCed them in mails like this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.6..v6.8.5
#regzbot title: wifi drivers: mt7921: 6GHz band stopped working
#regzbot from: AlexDeLorenzo.dev
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218731
#regzbot ignore-activity

