Return-Path: <linux-kernel+bounces-160087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9508B8B38F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA628B238E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37EA148303;
	Fri, 26 Apr 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dbft3gR5"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4C7147C81;
	Fri, 26 Apr 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139506; cv=none; b=EUmgD6L35YcIZlEkDvxRUQULZniIBrYJCD2oZ9YSZa1/4aDcT+VOD7sH/ywGgqyuM6vQW8e9GnSl+B720hnevDLNtBMRj/wCTPRjrTBZrnUnR5+Lhdflckgvo2aNQ7VWupbPKwT1jhAofMiyUpjnxNYUsH7YA21cER4tHPL0X1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139506; c=relaxed/simple;
	bh=sfPc8vA1asOT4uhPnXFYAb1MYP7/75SGuCAI7eNLkxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHuKeyiLatg0gdk1o7ZS/AxJSJ/XUw8yMH0WHmDBndfYSi7bFowEv7YK9nZuq8EM1qghU3uSWJwb2GxuwxfNQ55ZCJeD+L3BJ/2nXq74YZxpNC6aLBc1u73qDKnPTLWvLV4xbGosiC54xkUz0Q99wzWN4Q1Xz8cxWWVQOU3vzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dbft3gR5; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714139474; x=1714744274; i=markus.elfring@web.de;
	bh=sfPc8vA1asOT4uhPnXFYAb1MYP7/75SGuCAI7eNLkxs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dbft3gR5I9p9ervltEZx+omyOiwLyxFKXShxNiup9mHSMcJ/zHQsGTU0dBH6RNkE
	 Rw3qZpUt+zG+YEHw7BqN4numkvzMBtU9k/6/Q3cV9Yc+vGsXxrMq0J9UZjXcR8ytQ
	 y2hU2C2q+xtTVVTlKig80ST1hsWMmAOCGVjyBinfWu6M76QkA77GnVABTAJH8laHC
	 k3EkqSNPiE4hUsq3Kl3pXLASl7bPrUC3rNPy0OeKX5/uia+bx96MwL+2hVfGlmaQ5
	 UXDeSJwX8XmMFvxQXUqGtJIMHP8TWGgBo0GkhbKCCCBPHYwDKdGccp9ZLltmofWSd
	 FGRx5BZrByfzEjDd0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFayw-1ruGeC2EL0-00H4ZR; Fri, 26
 Apr 2024 15:51:14 +0200
Message-ID: <801e8f98-7e26-429b-9601-9e42d0e304e7@web.de>
Date: Fri, 26 Apr 2024 15:51:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: serial: 8250_lpss: Fix memory leak in lpss8250_probe()
To: lumingyindetect@126.com
Cc: linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20240426114716.1275085-1-lumingyindetect@126.com>
 <42c5d1f0-d16a-483b-8bb1-4c5768aa3a8c@web.de>
 <4e6966e0.a07e.18f1a7f7863.Coremail.lumingyindetect@126.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4e6966e0.a07e.18f1a7f7863.Coremail.lumingyindetect@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:44/Zkz0wQLU2wdmqoRfUmes0z8Qej6S5BBJmxijUrzSXSpyNFAQ
 +E5Eem4AzytWFighTHTFnb4PMQu8lzwJwYw80dFkexUl9AGGTfHAKZBMewyY1Fu4VfarQVY
 8MKJR+641KXxt+iz99ddMO3fEwye3/y2T6QJHBccizzd6lbAm4ZHsPUjyF7MxPtpMZ+H0bR
 9Ai3cJ198zZ75ZUKyOpZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hrkOPrdjhYQ=;JoqKRc4NrL4MMWqyzGtOVb24Aa3
 YG/73oK/MqpKXnEUjtpn+3lyeU7akHH2X2080bFuXrIWfhRgIV6qE/ok/R5XOWt+3EsPqaWOv
 g2nFBs+aHFd1DwKl1OKsNnLJQjS/6BaCIjiLTNNXnuMOD8rSoYiuJRCnj97kr2juvqrvQnRzg
 nVTRXx0+ynxLiQNmloU2Yb7XFLK8gXQ/fEzZfvx0/bzvAsSAWHwbLUVxDW0jb5eRw4QS1sUyU
 D5nkNYUHaQwjKk3ip2UCcf/kYgjbR/0U4lMGfH5vhtRmjF/d2YjlZgT0xPjEr//xp3Z9ox+kb
 ngzbpViIJtpqHcv2sWBS6Ts9Aw750AULXuCcDCiS4vAztl0/FTqtajjlo8MOkASd7BQdCjTTL
 mosK27aACUBn4FsXAxCjTL9ZZ2olX6MIZeY4wl+JaFhhkDtel7GOsEfMelzmJVfYNlF4hdC5C
 PeUu/aUAbyWpHofEkrTeQcem77DT7Yg/+vTPD1El9dAqRCtwzGuq4K2lg6tQoOKj2fG7q36L8
 CN58dy86BtEZ5/daUhTEd3+3n6QwBpP0wwayhkkrMRdD4FcsA1aNAYxT3Ype+G+jjgW6/za8T
 HAqegjPT0sjnI/XzPjvwxENUtkOLmRCvv62hGJ1hSc3dkyGZD8Q4yCytIeMD6a8fCJgftYAd+
 9XDYDYJFQZSv/2zImY1EEtjTYmYNbuf54s9Ft7b/vX7tTVrFOPLCmIJaLMQvcEBYK/vUmz7CB
 4Df+35/FErG/Haz3PUH1tPNhpLJeZhWKr/xn/82paZN8CVtlkpb8GPf6c0zr8PWy0KV6RPhUU
 ALfoATZPUtpYyBk5pu7pVcCoI/cHIguujWGzW3mqxr6Rg=

> This is my first time submitting a patch, and I haven't fully understood=
 the meaning of "add a commit subject for this tag" yet.

Would you like to take available information from published information so=
urces
better into account?

Please take another look also at advices from the section =E2=80=9CDescrib=
e your changes=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n145


By the way:
Did you try the development tool =E2=80=9Cscripts/checkpatch.pl=E2=80=9D o=
ut for your change approach?

Regards,
Markus

