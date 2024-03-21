Return-Path: <linux-kernel+bounces-110550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6204886073
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58C11C220DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9F4133420;
	Thu, 21 Mar 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="imqIXKmB"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DF79C8;
	Thu, 21 Mar 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711045206; cv=none; b=E/HIZsC9Z0TcysghIKeQLNSYFKGFLzGB9CPJHvcbisdRIvKk1ei9ZN8ewQzGWXpaNuOUNqcU3iFOClzG2OHTt46dd+izVbU0sVQLGU+uMUVWSpHjU+6We9pk5DyuiTIhhY8k6bC5i2+m8PhQGAlnbrSuSdDU8JBqCOjqIjEpEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711045206; c=relaxed/simple;
	bh=8fW3dhh9hYG5Y1ZObjvWtGoPkBZ9p9ImMfwLnxDrke0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHz3w6RixgA1Zm1WKlAEuO89YpPI1mEqTVcDUhMxlKfJdIJmtVno+LGEFSmo6txAUFta/xK9R6+Xks1nipUipPbP45z4bZIR6skbc6VKLYlMLLfXd/CW6fUpUqz5W+4CWMOeaaFik1QQpdKeXohBxnYyc5XgbyZrJaBTv6kZ6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=imqIXKmB; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711045201; x=1711650001; i=markus.elfring@web.de;
	bh=HgrbIRE7VEvNM/7O+kRv8lnP7tFYK9W1rOWWA2jQum4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=imqIXKmB46uAN+rH9XXuN6v+H6/1USJchXf21JZZfoDez/vI50B/Krg5G8vJlTRB
	 rqLlISWCkSHkVJ+PtHNFiZqXOLZ+edi2sYwDSr0aH580tKVhR/z/3d0G6EtpztHPI
	 yzmQktctnT6Z2/wceX+H0y7/ILWYKs5t6cHsKQPkb5EA7fwKwbUkYdhWu7SmjslT+
	 fYFNe1tSNIBH9vLBgiBVV7UAvTG+gVhBhCG7SpPHsUXrNxiIPw/TWz9Z1hfXk7XV2
	 tujXbiQ3hIGJpoZlDQsyIM3CyOYHKwL78y5jBZEEhXnxL1nx49uH49vfphKQdqo09
	 IX8NweSGATuKTL8m0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5lnT-1qi0cQ3Muh-00sdt1; Thu, 21
 Mar 2024 19:14:13 +0100
Message-ID: <e5172afb-427b-423e-877a-10352cf4a007@web.de>
Date: Thu, 21 Mar 2024 19:14:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Content-Language: en-GB
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 David Laight <David.Laight@aculab.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
 <d2b1f3bd-42f1-483b-916e-3735b39a30e1@web.de>
 <Zfx2VL7xnj4rQoV8@smile.fi.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Zfx2VL7xnj4rQoV8@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sgi560zt2vi0QRILaOf8Dno1paTZMF0JEueGv8qFTmpY2UfKHsL
 7YAth+4h13SGVefnGT3MdnvQlXK2uzciuQAvypP075NmJwH+S1f5f2BOQ79WNEYzGNYW9gQ
 yz0royLM51YEA7NL75PeQ8OuPHo/abXi7N/DUbBLsSMqyhUaUrXgvBCO1neaNLoBXEkxfq2
 wtnF/rBwxxzKrMKDBHRhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vB8mFuwR+dI=;qdq3to6uVb96t9XCtTO/xTNQNBA
 3vFin/ZvWWkItGHHjrW/mWM2bguPoLo5sndULVGKvZiQEensFDzpaHrh/upGXHGqoXRC1g3aR
 N4rqgZWS5CCS8eh1/O4esq+ktaet89gS7lvDZ9mwy5416tk/sredsdR59l0TmmRjoPOEurYAv
 CdFX2mNx4VZNFTXlS32DFH4sl2xib4YB7IF52pavgztyhC3dvKrB+PE156FP5LwIZth7Ufv4m
 X0/6RAQiKdW8GYN1XrhBtQ8Zi0Gv0IJAQvyiHkOQHo8Z7h4txtQfLQ78ZUbErNEXPK7t9IVb2
 125/sOLjtTnnqWxhFkRuusB/yaWba8cehhn/qJgM3gGoks1JpOWoR4oRZsufZNk/V0hKvKiJ6
 T8gKk9BYpmZ2rdD6RL0F2roH/TWpC/d06Hp/juOqx5GQ1RvxIdXdokbRcOmbE1J0lUsPS8e+o
 9nexNQ9gvw1kMZfZI2Dl68cus4HkwwnKagrCljYSP1c2wOgbaa2WEf9X6OU6J7ofvwwb9yKgn
 Xgcdk4twUBx8m5t72T/0CX1Ud0RRYPUwlrT7zg2mjwycLBVx8O5F1bq15hVX0O2HvwovrhDzM
 jcozV9lFf6WRf2VPsgwXMCgIrNQwAVAgQs4UzeH9MIQrZ6pW2L+f31pWYFnZdHn5ebltufL1C
 yqF6N3uDqQx0PcBayqL5F4aaGZe6O7m5yDuvBLFeSWz83ObmaYwJ7gxZn+bSc+PqwHXQoKwEH
 q3NwV6Lgxw8EpowwLl0qPGOZZ4KJFQypcMWNs8F7IyTq0DWlZsXI5RfNFpv9nyoi3sIsEpygf
 brnjCROtc9T7cwDCoGZcrfM9SRIswXVGWeVjOrFTRGZNM=

>> How do you think about to reduce the scope for the affected local varia=
ble instead
>> with the help of a small script (like the following) for the semantic p=
atch language?
>>
>> @movement@
>> attribute name __free;
>> @@
>> -u8 *tx_frame __free(kfree);
>>  int i;
>>  ... when any
>>  if (ice_fltr_add_mac(test_vsi, ...))
>>  { ... }
>> +
>> +{
>> +u8 *tx_frame __free(kfree) =3D NULL;
>>  if (ice_lbtest_create_frame(pf, &tx_frame, ...))
>>  { ... }
>>  ... when any
>> +}
>> +
>>  valid_frames =3D ice_lbtest_receive_frames(...);
>
> I believe you don't understand what the scope of the above can be.

Will the understanding improve for the proposed source code transformation=
?

Regards,
Markus

