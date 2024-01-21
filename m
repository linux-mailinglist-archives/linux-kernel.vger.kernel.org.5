Return-Path: <linux-kernel+bounces-32039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC5F835599
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6530B214D1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D7E36AFB;
	Sun, 21 Jan 2024 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GbsndVe+"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E8736AF2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705838589; cv=none; b=mUxXvD3T5hx0jrGsv0RGEKfuesN5XlYvdCI1dr2YJv4DG6+M7CdRRNcjcDwSJkYHgFBFleURye0r9s/Axl4TSTO+CfVSeAaeyiZpZYZwor6l/SUJS9dVBQu1WP4ZUWURuyDww/j7RYJ3K5A29XT8SXxxmDgpfx/BG+02DL7rOg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705838589; c=relaxed/simple;
	bh=kwUryKIJGMlklPd/irqSDeoBQ9mM5+pJPKWXSEABKUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7QBaTd6t+RILTKTqR0e8Suo10vJN3Ja7alYO9QdIosw9uYiWXIefgOcyKaYQ+XAxm18r5uH4xf5GN2vP8T7n9xWXUyDc4bOevKIg369FCngP7DfoB5kCCJnip4m9UIBCMb9GQaqp2wRNUDxiRpbd6jGkMAYgdZUDkd/3JjZpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GbsndVe+; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705838582; x=1706443382; i=markus.elfring@web.de;
	bh=kwUryKIJGMlklPd/irqSDeoBQ9mM5+pJPKWXSEABKUc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=GbsndVe+QPud8qouKqCOmpc5o9jcvlbM27Pt/pEnPg0cSl4e9W27UDL4MkBjZjiD
	 52H3aTCx+nQ+ggdJRHvQ+GSIH8tbeMtPfaRa4xMHzFBcySb0dUf2W9bfOxvtzFPZh
	 Z6DiOoULHWRcJwvf849HXqHGr0PTIIjEO6ydhlxpeYulfDSO3zU86ai5mm2X1ZewC
	 c5HcyvLkBFsoCGOP0R74XKyIMGiYSnmPwhLzcvtnkoCbVRqJGpbTipYVyNXS6Dov7
	 TdELnPy5eZJhiKATsrJqs/GK3kTBXXm7CqWpiVjdxNl6H7+q8TvDq83eOAPkNbewA
	 +hQeCToIilzGgpBXTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6xz-1qsjcU3ToB-00ZtGR; Sun, 21
 Jan 2024 13:03:01 +0100
Message-ID: <ab09b77f-12aa-4bfb-9697-f5585303ba2b@web.de>
Date: Sun, 21 Jan 2024 13:03:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Li Zhijian <lizhijian@fujitsu.com>,
 cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
 <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
 <alpine.DEB.2.22.394.2401211159350.3743@hadrien>
 <161c3be1-011c-4ffd-8646-1b95f1a461eb@web.de>
 <alpine.DEB.2.22.394.2401211220480.3743@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2401211220480.3743@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pZi3PE5cu/zeyrIQl9l5Efx77lgAOcKtVKV5hnzGGloVAQxWxfG
 Uyz8ioUvqz3JgFE3Iecb6jIhNpz079S7AyyiKkaIgK1mDAWQjP6SnxrsJ9SPVf/ftEIJ8qe
 1hBNSbVibf4qNX4IItRavh+dBwt1/sxfedOGkxPYh6U2Zh59awmKDyrg22Pf6mhP9M3654l
 0YtnAwywX68cpCPG8c4tA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DQFPm5rJQ+E=;k6hS/MLcglwIftaJziDYl0EVn2m
 trWyfszRciKtCIY3IVUP14NcNTubg3IEUWFG0KEe5LiL20AfSA7Oi0tHAZg/HfyiBr2ygMP17
 UXqN8JDEk7CK1PzBQoyUNh0zACO5+iTC0TDavOHNnX5wKGO1Adwl1edj/ZEsLp7xIePsan61H
 N0RBBx8jqAAuhCV1dUWg4ueavE1TmarmqazIDcXnbHcSFjVSmQZI0QFD+csFJgMj2tqoIMnKp
 RdFfCg4wATyJYu8kOBd2mmodeKDjgolKLSK4s9p66L/iKj1cOhzB2KglN4icclFyskmW48ysu
 FjjDjVse6Qw/FsBmNDFR2lfUd5f7MG7GyDGCkRsdPTEym/H2OlLigUeFo2IdAr31NaB07zE/d
 z5Ewv82hQ21GPs9+6ZiPuviHgcEArhywSCCOYJpedJaqHg8zjjO0n7Nqt1mRnlUyFb7upBrRt
 iCaBvvWBpMjBu0JGUkSwScKzrFogYMozXHhul0BJjPyQmljgqwzdaSTjQOx9fYRsv4nWQ2zca
 NvUoLCk97cCnDZDD+wjsNyycZeSxwuo6fF+vHb1L5hKt0PeksGOlQH8oa5Vy8OI919mNAmar9
 gnC1GfgKueHJyHzlH2ZymzhY/0Ep6HjF7WFuDrAs+nFmVgFMl8Csxr7S6vJtYYDP6uYJ/50eU
 7jme642UTFG+C+QnQsZa/XN8dqjC5ESOWigdYoh/9h2qDp1Iw6SlNsibeY2jaxJNG6ufPhDC1
 PctNoo0LAb/7LRLPbO8Q9VnkCj0sIqvUXj0qWudHeWyJVRMD6Fd6pDBmHzBMe0kTTMy6/7vor
 JBVzyO0PzR7HVz8NorpRRbUWpZvc9gUVfkkKQpDNVq/6fOnPpf8gBcUIRmDv4iDoDur4FPd3s
 mxYWVSMcgqHPA72ZL9wZAqyZBYoR758m4/vZ8+A+uiNzwgmaKu6LkdyK7IZzu7ZRAJ9Sus8Fm
 nDko6Q==

>>>> -snprintf
>>>> +sysfs_emit
>>>>          (BUF,
>>>> -         SZ,
>>>>           FORMAT,
>>>>           ...
>>>>          );
>>>
>>> It's ok too.
>>
>> Are you going to integrate such a transformation approach?
>
> No.

This is a pity.


> I already pushed the commit for Linux v6.8,

I hope then that the change acceptance for the =E2=80=9Cbeautification=E2=
=80=9D
and refinement of SmPL code can grow for subsequent versions.



> and I don't think the change has any practical impact.

I got an other development view for further fine-tuning possibilities.

Regards,
Markus

