Return-Path: <linux-kernel+bounces-29903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C19EA8314EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FD71C21131
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4755125B1;
	Thu, 18 Jan 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="k0go9khd"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772F11716;
	Thu, 18 Jan 2024 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567187; cv=none; b=ZjTo72XFW8AL9h2jBmKMkWpXW/F+Ge+KLPWxYCopIz2qwxv41i3V7PGSihnhhWUxmc2h5QAU7/btUQ7Z7OryzQ/7wCaA7wMpPrg2fzlsK9Bq14Xt8jLvxfeITNQ0C2jDw2p4cMRezw4Q830hBzF1AcNDrD4Vmf75/duWbNN6q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567187; c=relaxed/simple;
	bh=c5NIjA7ZVExAL8yvcmRrYUcTws8SPyenufmj2QU5Fkw=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=Saec4zebCRl8/0lq+Sr8SPE3oV5H8T4gjQK70Op9XPdzrqc6c/qkfa36aCiYve3MQp4aq1+ii6YuVfwD9F5NKcDb5UwqwWDO95bPpUn9ZjQD5HqSHkZTVLTBmqA3QOhuNhhrY6gWubfulU0VXOT7FVkDYQa8ybWuHyBMMmASC60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=k0go9khd; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705567136; x=1706171936; i=markus.elfring@web.de;
	bh=c5NIjA7ZVExAL8yvcmRrYUcTws8SPyenufmj2QU5Fkw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=k0go9khdcMe+WBdNDa4U+Qhm6YfsiAia1sv4LWKlM55XdS/un90eRmaVWQZlnAVy
	 vrFLLk7gsLYHHrqfifWG3w66rxpqx8ZOZ8QXH+N+LLh6PLKyVpN8F4mjhjtcHO2/j
	 15/gDR1fDG2G3/+iQphlkQ0cgc3lBuw9mRj0inxQ0YfbYJcQwpAMCuky0OtmHQl51
	 xFCGzl+jcmpkmBXQ/oZdJxRt8mC6WsWBYDn2juQl0QjCLeNQqGFXltnMk38JJhEkz
	 xMA3jSAFpbSVhzPOteKEQBJ4lvx5znKbYl0O0ZRkhbfw2O/5o2LEdC4y8HrzvuR9g
	 rQ5wykQgaPTs0WSthA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McIki-1qpxiG2irM-00cfcL; Thu, 18
 Jan 2024 09:38:56 +0100
Message-ID: <ea4117d5-bc70-4f6d-9fe4-e70e0cc47a6c@web.de>
Date: Thu, 18 Jan 2024 09:38:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pstore/ram: Return directly after a failed kasprintf()
 call in ramoops_init_prz()
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>,
 linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Joel Fernandes <joel@joelfernandes.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?=
 <groeck@chromium.org>, Sai Prakash Ranjan
 <saiprakash.ranjan@codeaurora.org>, Kunwu Chan <chentao@kylinos.cn>
References: <644f44ad-7e2b-4a1a-bbd7-ccc79d479242@web.de>
 <26759e3b-ff74-4b04-b06f-4d68fbc5f606@moroto.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <26759e3b-ff74-4b04-b06f-4d68fbc5f606@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nV3so7VARuPz+H3zgBtP5qFxp0QSibkDxt/9dkRReI3IdOgNMLU
 BcINV1xvzIwy4ceXKDMUQttLb3561ySWFGmUxrzME9oKpCpbjwGGdcHMq2/ti/VqoHZQZi2
 JcFEMEncuE98uc8xJvTSAwICMZlgYIoXx0znWcoaYOO4YHfiZGbHV7O3RH0pPcuP3mMahtk
 zChUGwIwdkCgNVnJeFDEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mJ0dEA0NvLA=;dTB2kylOv6oJYX9V0c3EanhWlh8
 gHXqOviPoFcDqkCtG2CguXyQsV4A0BIYg/JSHreVhLsX/e2L2NQUrVr+0my9XK2ENWXbpGGOb
 6x44lIAGMlJbwYCKlejIvhptLS+dHiwKt63u2uI9MmGE94u/joRE+A2NGD6WL1uUVAunozIm8
 jTKFnD704vMciTL/j7schkkLf198LVe4oHFtqDUJdF4UzNE3Cs2X/S043T7ha8HNbAGkCM8/x
 tINTZF8WoxBlgCMYp85TDtH9Osjc4gJPGmIgFFOCXU7kTMXKMa6R3gmqi5YujL/92aYz2qVue
 jZYfk8me85L+iuZxGRnZr/MwZFXzj7f2ehpGae6aCZOWkEpcv6TBuyuQKoIALWz9olVGQvnu/
 izQAqe7HvJN1pi2OsbCb5SmxjK4oq/qN+vzTr6S/wYbJnlNssX58zeKcyqaO9Rpz4xDy2XaLD
 EI7xldmGrqUXAa8KAl2r44nN/IHQ/bb9T3Li8S9jUlTVqb7w/Cn9fJDUvuddHlEATY8ypKLIQ
 Le+GSvaJEZssfPjUbD6bhgrZ6k4xNmcXq5YtGNUpi7tTRSjnvWnjqZV4nt6rKKPXfo1mqlafR
 6oHAdvDAGLEp4MAG5OeJNis/AO1NZ5bog5fWTt0qJEuG3MwbHp3UB/5KTMyKxrWbY3YfFbZPA
 HOvvghQwygfha7Vkjcb7TVJyOkjec4xthjBB4sKGgLFwzxTsE4PqJ8ldD4Dd/lDC08aSxBbnY
 LrDFqS7rG1tKgbBI6qXfZb6tZib/eLNyYsgpCPVbUftd9C2sEEI+xkwHLeVhFcb8qF5YzZQ5r
 A4Y+CeAOP+B04/Pc80orfJ/ioqQMlTmo07gbmIkoIhwCAB+J3eJQRwGK0b3pXMwsC2+C7fjnO
 p1fUvpEWfIm1gHjNna+atKro1uWFhVXXCUOZm2jzU2250YlvdJdMxMzU3gIZUfoNELVnkJJDj
 enbmkw==

>> The result from a call of the function =E2=80=9Ckasprintf=E2=80=9D was =
passed to
>> a subsequent function call without checking for a null pointer before
>> (according to a memory allocation failure).
>> This issue was detected by using the Coccinelle software.
=E2=80=A6
>> +++ b/fs/pstore/ram.c
>> @@ -595,6 +595,9 @@ static int ramoops_init_prz(const char *name,
>>  	}
>>
>>  	label =3D kasprintf(GFP_KERNEL, "ramoops:%s", name);
>> +	if (!label)
>> +		return -ENOMEM;
>> +
>>  	*prz =3D persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
>>  				  cxt->memtype, PRZ_FLAG_ZAP_OLD, label);
>>  	kfree(label);
>
> This patch is fine as a clean up, but I think it's useful to say that
> if you pass a NULL label to persistent_ram_new() then it will return
> an error.
=E2=80=A6

Will it become helpful to annotate the corresponding function input parame=
ter
for null pointer tolerance anyhow?

Regards,
Markus

