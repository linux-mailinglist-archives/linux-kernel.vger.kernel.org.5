Return-Path: <linux-kernel+bounces-102913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DA887B84F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FCC1C20CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E559EED5;
	Thu, 14 Mar 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="SPGjn6pM";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ZSt6A1RC"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137B7483;
	Thu, 14 Mar 2024 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400213; cv=none; b=Gdo0xQDWrN3pZHFBpDXUs30Z9mUftuo5wMoq4TBiglx7jWHi7T4fpQ/bdP/fkvOy0O1kZfouHw7aDyUsAdBE2cNOTLDkIOxwEA0x6AGDtuGA818EORNlH2enGpNffrcOAs7hyHT2KO5d+3Vr640U2VJQRebSgUcb0B3GCZrtqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400213; c=relaxed/simple;
	bh=jY6yOpE8g9BQVfVV2ZkfIkx2zon2uXer6mzsjaixt0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObOhG8Dva6ug31qHDjzMSDO/W09F1tC+msK/3SO9kSLF3CmV6U/AX/jlQ6i8GIuSpaxJkxav56jIWqsBswozu9sRh14R6iXJZjD0I928iaOPdl6S9G7ZBG3Sl3HbAZv+VUS4HTdBD/WZH0SA2meaR+YDmWo32FeVr7s4Mz8z0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=SPGjn6pM; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ZSt6A1RC; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 208BFC01E; Thu, 14 Mar 2024 08:03:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1710399829; bh=3Vv06S8OE0qnROsAgEOpxSNvRHaMC9janhFTWckPh+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPGjn6pMlC0hxjnvWiFi4yuaD+Me9YRaiEjz9yKlZpGf5xIY3UFHv9HuIxHvn2lRV
	 O2EA/W3iOn0PCeRJM1QDD84hyagGsbkMQnwKZdzr2KCYPIj7ckxn+02hxXk9cjSJuU
	 edujCM9iKpybgSYt0vtWd/LN3j+98Wyalxr7FINaGM/eIwZchvTbiBnzFoCEkKB+MA
	 gpbHyodFgjgK/jXcX+lPVj6xwmeJqO87MXrNLXlYrX41dRAiRWbQgwZ+yuUjnVYlq0
	 pRjwTZ8fcgMuF+7UzkV7RJI93miUCA/my7PTjYJ9M50L8Il3060HFybfJGQMFTmqSm
	 6mOHSuZ1obGeQ==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 60BE3C009;
	Thu, 14 Mar 2024 08:03:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1710399828; bh=3Vv06S8OE0qnROsAgEOpxSNvRHaMC9janhFTWckPh+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSt6A1RCFK9P6wi6S9jOhVJeqevRv7Q17lI9WJe8YB+JRF5p8Xgt13VR0Xc9lyIjo
	 gTmHSwNLtYDoBNDzXg6Npv2A08heBSgw8XaZsnqOjBJ/CikiBHdKFRBuN+IuY28RLD
	 gLb7co1SKnonFEL0mI9DUNQ/7CwcMC+BKJksVhRPvaiFLAljHF6VaaihN2qd/ZDwIZ
	 ot9ffnxkrtzPl6IaxPAP+EJ1o8sDX3DzADndMapZQrZ4BMN4tocYJnr5oPdtZWiEcS
	 EwvE6WWWCWe8Wz8rmA6uUIUKOUPSzAmkRZx/qaCfeni/m/aVx8gNNH86abLvgjTgtg
	 F7YY4NYonuXYg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a2e2f42c;
	Thu, 14 Mar 2024 07:03:40 +0000 (UTC)
Date: Thu, 14 Mar 2024 16:03:25 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
Message-ID: <ZfKhPaFngJTrTJyt@codewreck.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>

Sasha Levin wrote on Wed, Mar 13, 2024 at 12:45:27PM -0400:
> This is the start of the stable review cycle for the 5.10.213 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Thanks Sasha for submitting a stable rc review!

If it's not too much trouble, would it be possible to have a different
header in the 00 patch from the other patches for my mailbox?
The mails Greg sends have the X-KernelTest-* headers (patch, tree,
branch etc) only in the cover letter, while all the patches themselves
only have 'X-stable: review' and 'X-Patchwork-Hint: ignore'

I don't really care much what actual tags are on which as long as
there's a way to differentiate that cover letter from the rest so I can
redirect it to a mailbox I actually read to notice there's a new rc to
test, without having all the patches unless I explicitly look for them.

If it's difficult I'll add a regex on the subject for ' 00/' or
something, I'd prefer matching only headers for robustness but just let
me know.


Didn't run into any problem with the patches themselves:

> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.212
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 0a70dd1e1aa9 ("Linux 5.10.213-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

-- 
Dominique Martinet | Asmadeus

