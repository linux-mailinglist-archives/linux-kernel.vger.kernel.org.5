Return-Path: <linux-kernel+bounces-89419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC37486F014
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615E41F217B7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6285C171A5;
	Sat,  2 Mar 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="w4QQ4ma1"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5F79F0;
	Sat,  2 Mar 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709376052; cv=none; b=LX/W4fEKNzs7pMJLKBpQaI5QzlzrWuu0NwMfHdtw/N7qVWJknVefHNRVtTKZcuVZJ6SjrM2gFnecGnBtYkyP9g+UCT3H6phqkeU6RDV+sc/LaJ7QtIVMPDLPsjA7g/GTBAnbJYKo4+ay4RdJuhnOcF1cRZ94ucv0JAAc5UFEENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709376052; c=relaxed/simple;
	bh=5KEwfwfpBtHKd/mMoh+MO4I0djnrDy1f2e5WKqE/N+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXxFDl0+gNpS+uMw6iyKkfizHwKzXMdPRhF26+kaCJ4bdPe/izlCWEnrtap8Pxpckn0Djb8D6gXPOlEimhLAAyCgi40RJ5vX/T5toyN6aRUITyaOHDml5k181MmZR+AhdLW5XwmPMhIO+gXb/ogPbD4I6pqME9DGlGQEE6pmr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=w4QQ4ma1; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709376027; x=1709980827; i=markus.elfring@web.de;
	bh=5KEwfwfpBtHKd/mMoh+MO4I0djnrDy1f2e5WKqE/N+Y=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=w4QQ4ma1DcUJNf1607MwmUiWq1VEwhfUtnHjOxpuJ57dgm104lqxEk3tuLs+ASHV
	 9yU5+PCLDPII4m3KlfLFhUy/NmlbbNat23dHJDPRsFBXm1KiXD64gugniF1qTqnXW
	 p9bl0BVIVm1/xW7RvepilXKQ8GpEItCCbkUVhyvhEfUCbEKkjcHxrbNX7ugq6xtkK
	 wEc+udSFuzhCUDa17vl1PU9EwT647Z9Aj2nMzL7sxo7vINMC7ExYm6lllP4UW3jUO
	 i2GXQmCxBcNhcna/RIeF1GEl9G4H9wK5LJFrPVOqzKIKei0VrtS2PKD9ZVig8aCef
	 oeJzFtzmJxhdT6OwGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgibY-1rF2Ji44NQ-00h3sN; Sat, 02
 Mar 2024 11:40:27 +0100
Message-ID: <f451ffba-db26-4a3b-a4b3-186c31f2ad64@web.de>
Date: Sat, 2 Mar 2024 11:40:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: staging: media: tegra-video: Use common error handling code in
 tegra_vi_graph_parse_one()
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-staging@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <dbebaea7-289c-47d9-ba06-cd58a10ea662@web.de>
 <20240301183936.505fcc72@booty>
 <9f1b617f-06cb-4b22-a050-325424720c57@moroto.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9f1b617f-06cb-4b22-a050-325424720c57@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8EIFhDOXNVZRFR7rb6IKMJFkCMFDb06oUAxZG70fjR9PxT9vVDb
 ygwmriYITR6G3+mDegwySoLWOaFOrKIdvdfLLtx7Npk3lEV/2yhpzaPrHsOg54hr9fLjXQk
 AzjYhdKxoeGucPy0nUXqkKVuDA3LPFMYyENkuKlBs2M1tOv2hAqXwKOkUXsa7C1+5NUialp
 +CSqHePTqHSMCthsLr/LA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KfSN83dN8vM=;ZZe12Cqx8Lnelg3dRbEv//XtPa+
 Ov5CSeXzzv6A+QTt5mCYp1fCKAAagNqF5ynAnwrPI4m1jOoE2ypRSpp4/NG2d2XDKQQBiuBv2
 eEc09zFfUiqqUAVJQkQD7Ft+7us/UUJXYYGbArKJFJ3z7nry/qPmgmLmLWbhAYHQbYwAoLE9L
 EKxS5/RONLgDwqzQNt1MFXDptC+PGHk8VMVGkSShxKAmKfuWupdMgKXR/Nk2EoJJ9Gwotc5EL
 aPP+Pe/YU0Sn79UFH2OjecwDHmILfSwP+DUQj+StufPEwPOwI7CcV5HZ1J941hs8uW6MoLDYR
 rZtwx/vPeWJLoQlLTv46aHJNZziFOCtx1EBP3zUNX59nHJ0MYh40KZFiiPqlHShjGoSM+JU7W
 qyltlenXBPC17tldyORFY+2FdWH0M4uobbLeL1JlrScsD8A3b+ph63jnju8CMdu9qedNzQkbk
 QmiKxOb7FJqTGwycqUC3EMnoMUBbiZXFlXLkfqDiUlKzSK2V9JFmsf+BFzXah6ADjVPdfJ7Ui
 MFy/Y80NR/NZMnop2mleoGV06F67SDirHovQC+LUMNSnt19WomGwHZJjm2mb24gcNp8edIXEA
 imvcusWfDabNucAvhU6MCv5cEo1SLoHzR0S9pGPt8rpsB6Bf4iEsAj5CBsGL/LQ8N0pZ4Hfj2
 u/3kEbrMY6tZMQrL7ggvg8W0OO7QegEIt2fWcP77IcwIBXplzVBPrjxO8CFYzYygw0jWnWcKR
 7qCkT181QQ2ZCz/4Mz/bdK44hJYyJVcJsW+L3MrHJ4+pKpfAZWo6tNyq3KSHQ4pd+N6Nk5HR/
 piduLI8jjzlFyEsJW6Tdnzf608wMZhps3Qnp2fMTqo9QM=

>>> Add a jump target so that a bit of exception handling can be better re=
used
>>> at the end of this function implementation.
=E2=80=A6
>> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> These patches make the code worse.  If we're in the middle of a loop,
> then we should clean up the partial loop before doing the goto.
> Otherwise it creates a mess when we add a new allocation function after
> the end of the loop.

How does such a feedback fit to another known information source?

Section =E2=80=9C7) Centralized exiting of functions=E2=80=9D
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.8-rc6#n526


> Someone is going to add a _scoped() loop which uses cleanup.h magic to
> call _put automatically.  This is a good option.

I became also curious how scope-based resource management will influence
Linux coding styles further.
Will various collateral evolution become more interesting?

Regards,
Markus

