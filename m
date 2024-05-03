Return-Path: <linux-kernel+bounces-167325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3297C8BA7E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6402A1C21756
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D291A1474C4;
	Fri,  3 May 2024 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZV92GoCD"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5D139D12;
	Fri,  3 May 2024 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721795; cv=none; b=VxFK8KAkx8Guki0LofM695QO7+BRTIuvUGURf5001hc2yDiexvCrxzjzYV3TD5R5EwLpe4UM1UoLTBj0OFGaeBL3i7D3yWlyYtW7iu22LtXK9wVwuhMIv+F3L4wscSW5CXcmF8zWsDXIYt8WncLEABE4e8RdmMPAKeft6d1crDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721795; c=relaxed/simple;
	bh=7KoCLlZBSOFASgSu6MYjnBmP3h1VL0xbXZBQuWHgi5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4p9yA2hSnt+XixkVLMGnX/Otdu6eLNFRGOEpr5ZkXhHDLmKqbmb8fzVfgtZjZDYykSdFl0Pb8LBuuSAoUR+fsvO4tedyUeZWK9sXr8w5G968qj5L69rHKV5ygE/sa/aAzQ8OhS05AcrBAHlD+mRGBdamElP6DzLEBlDR0SfYxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZV92GoCD; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714721789; x=1715326589; i=markus.elfring@web.de;
	bh=tTc56wSSVJv4iZDOZUEc20yuwRleSTjh1lHhSpz3Qng=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZV92GoCDhbobZP4TPyEUBx8zDd41Ia5ocGweYzqZ6eV6ITNBiodnpQuAftw+umMn
	 Megw/dceTCuiMpWGfbBW+M4UzNCwsHrQ3Q7DqVCZQEav2z6JoJCO2VF3EYoiK9xas
	 niyH1SKv4nX69HKarMxLThK7k9JhaKRm/kYiEYhlNiEioG8B5MQqhPO/vfxmhJRAf
	 pJDyJ0rp61GvRFcNscB1DP/TwG1SvBPy6JjdS+gPwmX/pWzzf0W4bSbB0mDEfpV9J
	 PCKzZY1V2CD/jaV7y3pIiQy/ImIuJ72ZtlqJ9+SMgPUdlCFwUKDWBPYwRAunc8DTS
	 1DTfFM+XTdxItegOeQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnpGi-1sRQga3uzi-00prNa; Fri, 03
 May 2024 09:30:35 +0200
Message-ID: <6eac7fc4-9ade-41bb-a861-d7f339b388f6@web.de>
Date: Fri, 3 May 2024 09:30:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] ax25: fix potential reference counting leak in
 ax25_addr_ax25dev
To: Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?J=C3=B6rg_Reuter?=
 <jreuter@yaina.de>, Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Lars Kellogg-Stedman <lars@oddbit.com>, Simon Horman <horms@kernel.org>
References: <cover.1714690906.git.duoming@zju.edu.cn>
 <74e840d98f2bfc79c6059993b2fc1ed3888faba4.1714690906.git.duoming@zju.edu.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <74e840d98f2bfc79c6059993b2fc1ed3888faba4.1714690906.git.duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fyEaMnRrnNvXcfnnCsy95pUZQYP6d4iTVya14Y35u0lKhfCNXWH
 sjb6AoMx6a27q2adKg/1eQDvJH4aHEKwGTLhXARxvdWUG1+Ud1cPRv7HqZNzk315/VCUaBH
 B91xSUcToLX2iOdINlQXl363NaB6E3QUXOI/4HnkqX0auYxz3xCuwBUdF71kTsNpqYfz5Hp
 e6E4An+24Z58olqplCVMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y5nGvnd2AQM=;6gXhRfyb2lyixwSuZj9IZk9twB1
 yaS9x+tAjWeLsKgigaBdAMOnu7CQw9oTJ2zLqZzkiyOP93jpx8cEar+yIs+dxrqcsgfB9aosE
 TXs57fmqKJU7fzaMVBHMn48VfyoDNoGm4JXXNUObpIjxwUP2vaADn52hsKhpzfwTZf18Sg33d
 sTJrmZinGVUs86bSXIZdnnXfAz4pBzYRYNLF8ogyhm8otvbZnOJXp4raC/Mqe5Xau2s3TmLdX
 5NhB38usJFQvpfw1eXfsZ0JQFpTLF+tAufKwC9YFosWeUcaFRkipcQ43AqcHlt6WP/JEL61tB
 /qTDumEVGpBo8JoFZD2pg6lthpteWyUMSJClT0PpGcHtNCTxMlpKqLw8q7Eva9Bxx5XFSAjrv
 y6OHMlhfBfyE4hjg8hzQLzEsoYHErPm2TC3cQ5MbGREywOdM1aXA29ForvQWt4gdpHJz7pcvb
 ecVIhgUHcgiMq9lSVL/D304oh7c/oAolEZNrEnvqyv0Xd5kuXEJgPwkiKB7YMhYXupOQqc5js
 qqGXnyx7jrPGmTjpinQ3p0XR+/qK3RbQ7esOGW/xrtJQHONuvlywwU8yKfZsghYWfQvN8+JjL
 kd00PZFFPQcA0aoVCELJr1Mw5fm3FFZkAepmqRpl8N8698N6pFmr1V5f0yj3thkkiGBoInDQF
 Spo/BwBp15xl2dw3tlwNwJYENun6rFshOOGJ9O+t9f1RpiFFzWKQF7njcdk5tw076WtggnUP9
 IRRvHGzQnPdgnICzHlhw08snhc7/fqRihSFDEkNy6vCk6RyfU3XQ1FizJePmev87v7NAENo8m
 YEJ3671Am7umulyDXa5HwHHvLhZm5sGy9VVemku8REUBnD630OOdxqeyYLk94bFJ4r

How do you think about to append parentheses to the function name
in the summary phrase?


> The reference counting of ax25_dev potentially increase more
> than once in ax25_addr_ax25dev(), which will cause memory leak.
>
> In order to fix the above issue, only increase the reference
> counting of ax25_dev once, when the res is not null.

Would you find the following change description a bit nicer?

   The reference counter of the object =E2=80=9Cax25_dev=E2=80=9D can be i=
ncreased multiple times
   in ax25_addr_ax25dev(). This will cause a memory leak so far.

   Thus move a needed function call behind a for loop
   and increase the reference counter only when the local variable =E2=80=
=9Cres=E2=80=9D
   is not a null pointer.


=E2=80=A6
> +++ b/net/ax25/ax25_dev.c
> @@ -37,8 +37,9 @@ ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
=E2=80=A6

Would you like to omit curly brackets in the affected function implementat=
ion?

Regards,
Markus

