Return-Path: <linux-kernel+bounces-106499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1E087EF81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70351F22F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840855E7A;
	Mon, 18 Mar 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DtiAJ4mL"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0DC55C14;
	Mon, 18 Mar 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785568; cv=none; b=A+iqydobbMD5cA3i3Cn1I3zYXgomo1EkDM9ZpLo3CBSIWYWCdEA8llhm9wMiQwAiFk/w3AgFTgzKHGU6mdG7+JloF3Pxp3utvMTMPmUN4V50qUKXzuxHWgU4yY6S10ctIpV5klJNhgg2uolVIwWhUeeawXYU9EcwBmNinuIVV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785568; c=relaxed/simple;
	bh=Lac3YRJkU4gFApnJTCBqCe0z/9YKT7CxPuYov4fasoY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cPKskl7HAkYWRR0OJdJcfNH+UsXHj958GpqsQx9l6zGILeZwi9/pYoO9rNcQpk7uiar7NoUnDwaxyh7DpuC3DkN1tz6WerLRM9ryMtuiFhXID0z//Nwm/tvorPuvyVPJxR53Rl1CGWmYVN04dpYOFnHqOUzBffssAwMFxcroygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DtiAJ4mL; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710785542; x=1711390342; i=markus.elfring@web.de;
	bh=Lac3YRJkU4gFApnJTCBqCe0z/9YKT7CxPuYov4fasoY=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=DtiAJ4mL+fiMEmlLYNE+iHg/3zZ03m+na+DnFX9rNp0X8vC3m1YzzzfbqIbNUz4M
	 Dt/DoYRZ0bTHZMXQhjGQI5H+aW5q/a5zWyI2OiPdDqCrEIY13lTnnTv64UmgOhJlP
	 AdP1de9DaQxLPmVPhHjOMruAxmUu8IjvBxqgt1t6o6/JqA2aLA8ttQPPqZgEPNpVd
	 nnPPPOBzYznZLns/h1E7VD70fWADr5hWWCz4+RfWiMZaxts+7fOHzhLOJi0dCa8xQ
	 1WhA2QoKteLDviVFmPYk2hYl3ekUd1OQ3YXoY7bsM5TWPGLkVHKXgzMZZteTc6bIV
	 SZWCtywFzYFN47nToA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqIFF-1r0cvV1ZHH-00nKIM; Mon, 18
 Mar 2024 19:12:22 +0100
Message-ID: <d5efc400-8dbc-4aee-9fb5-2993e6830e2c@web.de>
Date: Mon, 18 Mar 2024 19:12:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ayush Singh <ayushdevel1325@gmail.com>,
 Vaishnav M A <vaishnav@beagleboard.org>, devicetree@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, lorforlinux@beagleboard.org,
 greybus-dev@lists.linaro.org
Cc: LKML <linux-kernel@vger.kernel.org>, Alex Elder <elder@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Conor Dooley <conor+dt@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Kridner <jkridner@beagleboard.org>, Johan Hovold <johan@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
 Rob Herring <robh@kernel.org>, Robert Nelson
 <robertcnelson@beagleboard.org>, Tero Kristo <kristo@kernel.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240317193714.403132-5-ayushdevel1325@gmail.com>
Subject: Re: [PATCH v4 4/5] mikrobus: Add mikroBUS driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240317193714.403132-5-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d3rsWjua/euVmCusMEdf9EWPGyz5EyJVackRp6jiopEEya/axKM
 7KtTisuDqOjT7g+BpfBqQUwvkJdzBesfLFecqA+eroXI5usXRM1yMhefzveu38JXth+ok/K
 9memp43OQwwmFTM+1S32xqzmjH/zYdRag8frGqdD+AMSRfF6t28WhqRCmDHj5Qt7AtzUka7
 533VbMOvhlXUEbK3I4QyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FOAv7gLOqbk=;LIFw7TE+o2L/aes12HD1LR9Y1I0
 VDIjhJs70jys6vXqjVzsgrWtqrEk9pchL9A+mGrUuU99U2rzuYEvJe3Tp0/WZpfS7FCgkZt6n
 wf4MuB3QnaDd3jyAg6wfQFcWpPpzY2mJUXIsFtteJWmXX8LxUf84i6opANHArV6uPrTgW1Bt8
 ye49vSH5h8mLrS5Egj+E7vN+eTIpzd3pr0XqiOjpEvUeXtGjj/AD53pnNayTJy8s8PsfW9/+Q
 8amXd2uh1sYJX6GK1MqiJHlaRy33xCM69nyFSCNOqHzFCbrR1BqGddY7yKRALti7PUmdUTe7p
 5Q5I2FcCXUoI6HQburx4jGu1ftlbnqcpp/0FdKovJI95vXuxYf7RIuDad8S5vz0Yyt84Rb8Wr
 G/tGX7Qvs6dgatLzJlUQLjfJ3jd/wzjfB1j3QFpAiIuef8TUmvokOgPESnwR96E7H2c/Ul6j+
 q7BB1qJD1+B+GF4520sj1KEIsePWDJrlvGb/DRgyYkHBxAFHmIfEPfxR8YVHQMw+U3FvWMLcv
 mnxV4xtKtb/7cklHsq3MY09j55UNMdKEhngLtNn8Ua1Ion3GAWEqv4tA1+bL07hm6nCfinpeU
 tIA/Z3AFQMJ/LM+kKDJZQd8PmaZCY52VMv5YnxybipwTuwOK3E3DuJHYQH9btP8v7746qxjuH
 2C/xWUSp6SGrPueZ+BvTReM5nrolHLfNQUl9cMU9gCl9buwICLJYiuQtu+jDn6QKiBDkyrife
 Lj0OzKfxvNPeK8h2fp+zxep8H/B417sLSJpY4Fy1zJIr+jNxaiAsSgLeoOjgpFRQZHylw4n6o
 e1HDP836GHMfIfjaEKUq9QklADBV+IztnZKY+buyRd+Bs=

=E2=80=A6
> +++ b/drivers/misc/mikrobus/mikrobus_core.h
=E2=80=A6
> +#ifndef __MIKROBUS_H
> +#define __MIKROBUS_H
=E2=80=A6

I suggest to avoid the specification of leading underscores for include gu=
ards.

See also:
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier#DCL37C.Donotdeclareordefineareservedidentifier=
-NoncompliantCodeExample%28IncludeGuard%29


Regards,
Markus

