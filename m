Return-Path: <linux-kernel+bounces-60907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCEB850AD4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9234FB21B67
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCF45D752;
	Sun, 11 Feb 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kqYKgoh0"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A385D497;
	Sun, 11 Feb 2024 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707676205; cv=none; b=IaKWrfo5BjMfExw3XlLTsHboDr1wSky+zIUJlSjG3TzY3Te4CMGMVR88A5lHXhF8YoOUZ3fNEnYL0IQfX8dVvDe52whGrDJ3C+CtO2JE/KMZJjw354gKlNHv3JbPos/jUGyVtDjqkEoo9UAGpW3JttNYDv0GDK1xxG5N4DryPug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707676205; c=relaxed/simple;
	bh=74YHyaDhJLXssD4iP9ahFOyAatWAfcQ49coXo35cm18=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=upfB20QbcfxiVC9MGO3l/1j/lZhx7E5yIblXrJYmYusrtk8x12NjLHZ9fuYgTnhTGtQ5U4/3f4iM/gxa+4lr/LA+AJcKhaGCa9jcpRg09DRp7S2eC99TNqxMmYGHxfeVjtQQl56Ndn+y1F10HuVhL0Le3Baccl+LrosWg/DAdag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kqYKgoh0; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707676174; x=1708280974; i=markus.elfring@web.de;
	bh=74YHyaDhJLXssD4iP9ahFOyAatWAfcQ49coXo35cm18=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=kqYKgoh0Hs7D5bhjC02lOcuXQVIYV/9CxN3yWqJWhRSY/KhVvF4qLkDe2QSStatR
	 sR/jRBgcsqErHEjCUt6f1ZYyS1C4TJrbRG8NZYR4aJ2SBCWYaLWLAn4Xvs83QicIv
	 HOzXSRNMwQ34XwqRK0FrdnKGCbKg09/obu72qUDeegySthjghdu2HOUgbtCT5SqOc
	 Pgxx3nDXrQ7FxcdBvf1cV06Cv483SSkeeqkN3ohLX6123iUI4Eojxe+W6OmAWZ2P3
	 syujlUf0LAWuDY9V2UelxSXgjc6SwQaheFuALrp4zxJNTCGPSIbr2RCu8ZJcvLiGr
	 8ZqD2OoAgweLFzG5oA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mv3Ya-1qie1m1ySG-00r3IB; Sun, 11
 Feb 2024 19:29:34 +0100
Message-ID: <bc60c33e-c268-4e7e-94f9-e573545ffe98@web.de>
Date: Sun, 11 Feb 2024 19:29:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Matthew Sakai <msakai@redhat.com>, "J. corwin Coburn"
 <corwin@hurlbutnet.net>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <16ffd614-48a9-42b8-961d-2dc8a69c48d6@moroto.mountain>
Subject: Re: dm vdo slab-depot: delete unnecessary check
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <16ffd614-48a9-42b8-961d-2dc8a69c48d6@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o5C86Z9n5z4X2YsnFMlMnGSSfF15aQxmj9OgobzQ3XBKbZz+Dru
 HJOlK4fIAoOl5ReAteu7vc6S4gzCSVPcf00uYHZ8YmUNVWdOMAq7trdjq7xUsSBgTzWb484
 MH3YyzbNzqWjhgqpCbOlpOzIK799asb7cdj+YkEV8mP0hpqtsyCsLSnIQHEtkfT8IxBHPCQ
 NdmoIGr5zJkfyFpPehLsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7nZPYxQdON4=;fHrT4ZFPZ6VGtdo5GteLvoqy77w
 fZO5DenF+Zif5rIahUiQEyTbq43jvCnLgGxcaJ/Ii6iRIc4So43poG7UQpOVAka6RTZDbgTzp
 ZbYCIrmibi5VW+ByCvWZULwCA0bfWG+hXLqnM5XuZUDqfv0337mRJmTNoNN/dQvidK8WFVL0Q
 uaD/YNKJvcmx76ZARUT90eFHDwTLAihBsMXPJdpe16FcIbChChU9yiYKWEqNtO9408ZP/ZrJ8
 OR28pLGNGTlTHeIJYCMhdm0hq2WQ8rasHuOPllVuyrGcAvLuUvxsaMjHRF3RkESNgFSmy2Jzy
 n4mcUk2b3HLoT+tLjGYT0v8EjjOi14fm5QuOwLjP7FqE4I8Y3dTQDT/IVVPGuTMgJ25iUgdty
 UB/12EDfbZcpmsiSnrSaXlMkdoR34r3BeiGvQ4zZB7EWT+DiPkFqnd8ngxhNJv8/8dcPKCZxk
 gwo3TP76IiCn7c51Ubu8UenDQBjmyULtmGCNs942zR3ESu57OO/9rF0x6peMShiji4XHqoDXG
 IYJrVx5UrYT5wn1enml8YH9KB7ikskhRfwp65sJhO4z4LQKFIQykW7F5UxqJOyA+CmGCh9Jud
 yDNESGh237ymZT4+Wdc2LKYLEw9/Sjqar6LLpDIRkXLSUquXvEsTjG57v0CgcgYalb1Gw+68e
 Ly4JuU0SdP+TlRK7tFX8lQnJT/FcOb3d2ZvLEvTsM3665HoH7J+gSP91a7J6DaYpdGLSObrjx
 3YPuf5j0Ytp4tGTVi3zNvE9mMAGBw7v9JHfRPCZzm1/4oIOHSJ54JYCOKJ+kceZYYzI+IbYHN
 6WuxoJBpf1MkzS+zqXaaGeE0mL3bT1H2gHGZX0QkYUCFw=

> This is a duplicate check

Was this implementation detail detected with any known source code analysi=
s tool?


> so it can't be true. =E2=80=A6

I suggest to reconsider this information a bit more.
Would you usually expect the outcome =E2=80=9Cresult =3D=3D VDO_SUCCESS=E2=
=80=9D from a call
of the function =E2=80=9Cuds_allocate=E2=80=9D?

Regards,
Markus

