Return-Path: <linux-kernel+bounces-159827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256148B34CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC17528491A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16EB142652;
	Fri, 26 Apr 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Co7f2fmq"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FF13C9A7;
	Fri, 26 Apr 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125704; cv=none; b=Fj7ceY4yDS6t9M3SyXPwiGN7K6AZqlrFlnPFYW7qVWP69qHCxkyjcrt51+nz2c0aXhPqRNy3pBakysG+sGUW9IwMGTm9k6M50tMIyQzVoJbINt0zmIGMu6hqMbJO1IbPeg6iJPD89fOloEj3GEDocC0DIAF9x/gBpOfwgtp9J1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125704; c=relaxed/simple;
	bh=YpTE09Jdj7TFL3FQrJpjOfExP0eacSSODBHGOgrYr9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhSaiACaytnwt0U2mmxDRRIb1bQejrrM+HdNGz8HsWhkBKwQx7QF3O9KH/irN5ENg4xx7Zb1OVQic6XYXGVw3Tx8usaQR7lYrRRyznqnIMnDnRcv7Gmo2XoowDeJabvibKnvCUas2x+5ODOJQNXkUG/n9QXnsLQBB94x5LwCgBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Co7f2fmq; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714125683; x=1714730483; i=markus.elfring@web.de;
	bh=IkxQuklyV6oYuexLU2ovnPEuT39tlloBO1TIHfNZ42Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Co7f2fmqpY5WVoPJCLyEXwpjQqAK+/Y1RHnxD+nuWsvAUpOioKoAhw6PTBGaq384
	 tPi2ZuUeAWTxej4h21QvC521Q31N2ql6ONZK8lndwLw9WlaFS1uJYUXJ8kxfhP3vB
	 BybDzi1joEE3kisLh0txIGDAm4J8KZZQkpL4rKOAnthCY5WY+B8Ll4jCqLNGr0+25
	 C7kMNathdZo9CKlwHiJHxKGDgLD6q1//SrW2HCVMxOSl0aYnkUYU0c/rYyA4lfZqA
	 kNX+nViTBhhO5z4pdeHxaH8IoQcUtYVuFlhtinmvYTTtfApHc9hdegfNm/NMraXs2
	 AY04gtzyRPKdesmUMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCI8-1sXQHy42q8-00bZXW; Fri, 26
 Apr 2024 12:01:23 +0200
Message-ID: <9d186852-9ac0-4cbf-b9df-54d433b3483c@web.de>
Date: Fri, 26 Apr 2024 12:01:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_send_cmd
To: Dan Carpenter <dan.carpenter@linaro.org>, Sungwoo Kim <iam@sung-woo.kim>,
 linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "Dave (Jing) Tian"
 <daveti@purdue.edu>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
References: <20240426072006.358802-1-iam@sung-woo.kim>
 <964b0005-3a9d-499b-91d3-171a3c917b4a@web.de>
 <CAJNyHp+WFONaNbZVK3tPcT=9obEiuE3MvQzJK++HP-ffNdfX0w@mail.gmail.com>
 <dd466a68-f3ae-4dc1-8389-6adc463735db@moroto.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <dd466a68-f3ae-4dc1-8389-6adc463735db@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zbR8CpACKr2MhVcZfbZ4Vyyw5ox2/rZDQ0i6PsfsA9gbTcmkhOF
 z8/OeK4ftOJUk+MH4bsnXb5JzuWRchlCKr4YlHhWg/VmRwksLBSMX+74We4Z+vi0kYv3YCb
 psd1D+lbfUg2WsUEoJgsWTGReobu5e69qfcNBRPymiM3Cot52JH44gsyGs1M0BReCX6YiSH
 1iEsHhowgVyJDEzgRCOGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bLtSnyTF/EU=;NiuCW/MPI7cO+pZqqCaXj7a4Xg0
 KwzItyN/vlPSBWN7h3UFsmlLgPI7HdCb7APHi2krTY/bo23RJfVviHRdmruD2qAjxV150dKMf
 7ROLDmBwblmhP6Ii8HAQ+JWlxUpc636RqUh5pq/ZR1qU64vts/9tadGVA31APyzk3nB+ykMmF
 W9zYuvq/bKxHSZPYbLHIp2PjhYxaKJUaoPupkGpxl4OfrpAuT8OMkwfxGCLyFk/M3ediwR8zg
 HuJ35+vMrOuIotZe4jX70Jdojis3RYFX97s3g6Kv83jb+F9zeIe2eMSXsNBVKIwrxhwEEenT7
 Wx/3jZwJH9ksI60PSa+xge8a2V+SrL8FjEGjlrWvkv7RhdUcV+JrmFd+kG8xM8BwArY/vcHvg
 A7g4b/p8YZdnI9GPlnroxQwQ8jw7BNemiV2L+Xjxjb9HtnXkTGO5+RSVOBD0Su5lHWG6F6jhZ
 JFClQofKeEYvl8kQO5YowVeTcxkK/kAUDtBVNolcVSaluIuyyaAMSUehIeReyK5A2nvuUG+a5
 +/DLgnZVSRApXk7maf4sIus/d6lRWz+a6/F8BPrslU/xsHdvJSg3GAOf6Y+jkSw+PFdnXeXjU
 a/JwYRRvuZaA/ORvyFcZSb/7Ok7wmaSS3sRfy6Djww7rjxvIjLalVH7WIw/xpvzHzh7RIfgol
 vdjxJXh9WlUzeLg0Db4q7va1quNkXBr2Nw8syKF6EV3axcwVtQUrBd1Pp2ZRBlA8G7eJwCf22
 ftU+K/LjXTCCw5oTvrhAlZTYLbiLtPNmdw0VDogEKV0FWeqP6EHQ0a1a+SyLHCBGSu2zFvWIj
 XrOKxXAOL5rS5IgGoerhCxM8xxDgTAJLRzqwNVActaGhQ=

> 1) It doesn't matter at all if there is anyone in the To: header.

I suggest to reconsider this view according to proper selection of message=
 recipients.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n231


> 2) You are allowed to ask questions.

Yes, of course.

But we are looking more for =E2=80=9Canswers=E2=80=9D in consistent and im=
proved change descriptions,
aren't we?

The placement of related wordings can be adjusted another bit.


> 3) Yes, the commit message will need to be changed but first fix the bug
>    and then we can worry about the commit message.

Will such a suggestion trigger further clarifications for the desired patc=
hing process?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n77


I hope that recurring communication difficulties will result in helpful id=
eas.

Regards,
Markus

