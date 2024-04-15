Return-Path: <linux-kernel+bounces-144691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD448A4943
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A632817D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546EF28DD2;
	Mon, 15 Apr 2024 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eryD4r6k"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1968B38389;
	Mon, 15 Apr 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167018; cv=none; b=W0yWPbzMjDMxGzA7IvH0Vo7pqqOwIAQ04j4/cRx97Fk79pqi5h6dksY5qipTunelc+KGivMjlH+udXh2gbz88A+U5pu0AMhm3xMlWuAnXoVe+cvROlLLnukR1RuGhCpUoGaih+TJQ9gNj9wfo8Gm0O6U0/nJHKHNc6pkIPgc8lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167018; c=relaxed/simple;
	bh=SfL54Q7DzvB74BgN0DZ2PxYEquQ2XlEdK13OFlmH4jI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TsXKXl7F24kUuxAT7mGuW8PcmqinCz7n++MSbn6wZvAivPWh14FEJqTWSDNc/TMi/4+792aNkYXC8HGQ4/ubVpFuzbpWuqfWl78FB9kipOfwwHeB2jxnbckA73fHWkOoxxBYcQ/2khD1/7lxCTI2jPWyw//M1GI+ZS85IaJ7iQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eryD4r6k; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713166994; x=1713771794; i=markus.elfring@web.de;
	bh=Ehw3JP9/jH11oJR68DQOEghJBea6xoCh7eHWITgqHRM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eryD4r6kmxWCnkLLaPtDkiFoBn4OIfitiMN4abV05fl8tNgD2k9xI8qIF6wmU2fM
	 5Qk+Kwvs29iv33OOKUKVBnc1q96JO1eK+ybtB/FQCkrbw8r/7gKSrCPHQfHOVjBHj
	 dwfO2VrUin92HOM2N4uDB0EuWZY5GrnZoV6tt77/WwvizHP6+OaU3/kMwQ16YIEyi
	 cTGkwk2sxBaP0juO3kLKcPM6l8UwXLjsqxD36BwrBLwR2LVMPuc2VAG2ojIYF1+3C
	 gasuNuKMVhOVmjaN1VDgJmf036H8mBNDPZHV+K3g9chcH51Id+xw7RnWmMw4vkCxG
	 t0UXS7ElfAHoUM8Wuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzin-1sE4zj2557-00Hz6h; Mon, 15
 Apr 2024 09:43:14 +0200
Message-ID: <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de>
Date: Mon, 15 Apr 2024 09:42:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
From: Markus Elfring <Markus.Elfring@web.de>
To: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
Content-Language: en-GB
In-Reply-To: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:clWA/QkEMk1zwMQrfsyv96T78gaWC3LvgzWJUo1bf0wfhW8Ib83
 dTf4utj1Tw3KMQwJMwkvi+LGtQt2GBBMU6UbPuBwVyePLDUe3W71tPDnKSa9VsvT3sqgU2D
 caERPxmHaL4CoVKIpUQiXoj+F2s2abtVqYEeEsw4j8HcEgYEFMKkhherMm4g5b+S9nrXboa
 OH2uBab55WhqqaOsclLAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QIo4Ksqsr9g=;4Gg95QXmFO+zKJrVU0tNrlb2pZ5
 pO2yecCe36GJ78zuRFCpoCTROCAj9WCi7BuNDbDJ8y3kj82gVfEVqGPTCAS9GhAIR73fpgduD
 4/mrWvqX9oWV5fXBI5/7mtZPuCuFJNcQgvX05PjCnK5Ti7OVvamI/rnfoLPUtd5rcl86mrXPZ
 jCHidQabVd49+ww84TFn+RgP3m8gp+FtgtkXjAi7WKLpBhwNrqa83EBoMxIlpmCeqToWEKJvp
 cxxY+u1c5Pw+C3/WDfXEhLb7BqufYxSpeAxhjnro2kKQmuHqkMVxyR7Hvyahbflt0A4phQDzI
 Gju1dKIO9H2W3Jr13NHRhzlwBg+0kPGUwtpgbxMQIamMXl35j3ubfoJHMGNkjVuis695Eju8M
 zv/DqNwtjWDYq1D9bTY5wITMIBNRTQ3a0BeAvpbjjiTq6rkKpz+4p9aKxOWE9t2EJEH3yyDkI
 OcD5mbSvFK08kIYHkFglwGAUwBP6I060u9mzW6dRtvEzqYCN7mOxEplcB1PMJMLVelyOdraK+
 Q5DnPfai0rumhfVNlngBon1Xp1APjwQwjdey8Q7s8Atb+UD/xTVcTps4BPT62puVFic8rRwml
 myVjvlVIsxz0IZ/GsfkfgLLILxTxeqRFYtYMVKchA4CwgUFF+QpiMhxyXLru/wjsbWc06mm1w
 DVk+a+F+hJ2dujOr+bsfc3sU958bOK+zpA/o8ZUIk51OmpVDqz8Kk4l5j+lbKu+PCOpcbuaCb
 ZAnA8S0crAjSHJ4c923RO7mEJUjzCyXPOkUK9E+5PbOqY4bp6KsKr+Y4j0QQjHOeSscgHgoyp
 xpECGR9p6xaDhBT7yMYifcVH2JwfnoPiZs7tpLrvq0e6A=

> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (2):

I would appreciate a bit more information about the reasons
why this patch series was rejected.


>   One function call less in vas_window_alloc() after error detection

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1f1c21cf-c34c-418c=
-b00c-8e6474f12612@web.de/


>   Return directly after a failed kasprintf() in map_paste_region()

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/f46f04bc-613c-4e98=
-b602-4c5120556b09@web.de/


>  arch/powerpc/platforms/powernv/vas-window.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)


Regards,
Markus

