Return-Path: <linux-kernel+bounces-151072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFCA8AA8A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB331F214D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126DE3A29B;
	Fri, 19 Apr 2024 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Hz7scD+I"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5B79F9;
	Fri, 19 Apr 2024 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509491; cv=none; b=BJ/XoXFBRgBCKd68FiLogqXopoGYenl2I99iTCfrB0gUQfxnmTfWfOaVYYAJBiW08Gx4N2nMqnQ4Brr09vmxJEDAh2AGEyahmrClozVVmzmDX3NW/17Bv6pqWQgX4+81AS5vNvHxNYaqxzmoFhPadhfSGK22cfKSdYwE1/EY5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509491; c=relaxed/simple;
	bh=kNV+Cr8IeaPgt0ekBbelYW4XAy06Z4dnET3H5hMF8OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Mu/j0TX1HAqCOPOmXvvTs/pwB7ltQA4nRSDTQVJxYCnGTEtEUoC5nUlJBpFycRb1OMIUsE/iRK36X/nF3GrTk9E5I4Zimy2PqCg8UqQofpEOBPmEP6DZ+JySD8Bp3kP9fh1rQqWOqJUrqQf5eMUHlnr1mJpa4njdruduBkMSNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Hz7scD+I; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713509480; x=1714114280; i=markus.elfring@web.de;
	bh=Tp4fDh1EM73eA9LppB8jCZQssdvVqY1VS8ada0xBL2I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hz7scD+I+gTR5ejWD3rX7rgAzJ2u/DHZkEq+PpdaB8wp2N7HJ8+CxD/vpxCY2svA
	 bXbsciwuAxovyCMSnTBnsqPIaKDlc4qjBc8OuA2RjNuUNFcuv/p/U5uAK1otyyQ0T
	 6vp3arBHXC4f2+Gbdh+LLtzaExr4Zkr0Vtrg6O1i6xrYOjRGisCZrHluok1heULtq
	 kFNKoJk3kAi4udxJCejt3rpeKz6lohWvjnI2pivqhoSs+oBP/qjn298cSmUT2CEN5
	 05uIRyQEhNIpYZRHJSoPOcG6rEivtvwKKcEBfESntD/DCuDN5PB/m0i17OvLA9Zks
	 nZ4f/gKLUYKIQJnN/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1sbQd61dvk-00gZyN; Fri, 19
 Apr 2024 08:51:20 +0200
Message-ID: <f1f47166-00d7-49f3-9b80-34aa7b7b5510@web.de>
Date: Fri, 19 Apr 2024 08:51:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH] coccinelle: misc: minmax: Suppress reports for
 err returns
To: Julia Lawall <julia.lawall@inria.fr>,
 Ricardo Ribalda <ribalda@chromium.org>, Denis Efremov <efremov@linux.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
 <alpine.DEB.2.22.394.2404182255010.3213@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.22.394.2404182255010.3213@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZqBxasO1k8IZLHBuzwDX0hZEP94LaRo3JlVkMX5m417nUWPFam5
 JaWUOpVcL2/fEHCh67X0zRkV687+xjduWG5zNnNaorIpsL+Py5LGtjiJea+eFcdiOk8nwvx
 ivZbmu4QpPs0M2TY+ArXMJrniBX+QNmYzdY/Zf5WzAbjnqZlvOMDp0Pnu6EtvNNbLPSoMVc
 oc//e1kok5W4vhTL71wMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XpNQKZxqhRE=;nnLa+g7p9oEH0zrRsObeIx72MQP
 7vGqAqqLin1TpJLALxWnCj7UqWgZdegrKpV2m2h0nj7/u47fVVyz3boDtdSKm6nBfDxWzQXJa
 eb/PMN9q0E6asMwSX7mqoCl9/hlTA3PYh4XgK8SJUrRqdZAyYBA5xM8zEOWxAgGlzyPY+ZfoV
 p3rB7ctc2t3QqP5KnAa45QAJzyS+jrlTBEbAsx5gwqydgPCzGn/sF2N9x9wLPOakqFJ5UhwBx
 kUrfl1/u0h/k0MQT6KCDYld0Dy8qJIYQbm7ZtuS4MyYYwA806K5DcyUEO7Kk+uz8hH/A2+uR7
 kVsLP/bMpHoEMw5CaWx+pa+mAZ92pGG8xP4DE92iUIGqt4RyO8XauzyhMw8sQdyieFbQg80+X
 1SDIlZUeyoC2aC4Kzn3n1B8I0/9+CAjm27K+xcf9pMUTJMglKH2FSddfQMGO83+zo7/YAhHRe
 JuHYzFXkXBjB0Zu4XTzJTAMfQbJhSiN5WoXeZYHV/jLdXF9U62h6iv1gNwEdFlU3tdxGrXzQS
 G66Qg9LAAHxFw4A2gNl16HSo9jFTz2LCBNUUsErAcMQ2wU/eHZnivan72gRdx3Ymfq7nFBJg0
 WUXLwOoCBmRS1jmK55wj0t5FJKm/alZRWLi3XZMi0VjhUYS94TCgl6NAM1cGzu6c6x5Mg+PxS
 cShZkSOw4EuO+/9kI0Yy8aQWbcbTdmEYdV3hy35Z+pbGE9xwgl7nUsPme4qdJA9b2tR6QIJZy
 cI+b2WpcGGmI1Eb1rC4+t6FDm8iwnOnRWalGIRwv6sZHUUMhxIHb7BYLKgMp8Pcr4xg3HDDlZ
 YLXFqrrPPCIb3ZenwQewy76CYfwgMrB6oYu+lVKSah7Gw=

>> Most of the people prefer:
>>
>> return ret < 0 ? ret: 0;
>>
>> than:
>>
>> return min(ret, 0);
>>
>> Let's tweak the cocci file to ignore those lines completely.
=E2=80=A6
> Applied, thanks. (Coccinelle for-6.10 branch).

Was a planned code adjustment published?


=E2=80=A6
>> +++ b/scripts/coccinelle/misc/minmax.cocci
>> @@ -50,11 +50,26 @@ func(...)
>>  	...>
>>  }
>>
>> +// Ignore errcode returns.
>> +@errcode@
=E2=80=A6
>> -// Don't generate patches for errcode returns.
>> -@errcode depends on patch@
=E2=80=A6

How does such a change fit to the usability of the coccicheck operation mo=
des
=E2=80=9Ccontext=E2=80=9D and =E2=80=9Corg=E2=80=9D?

Should dependencies be reconsidered any more for the desired consistency
of involved rules for scripts of the semantic patch language?

Regards,
Markus

