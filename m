Return-Path: <linux-kernel+bounces-12171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9EE81F0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29D21C20B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE444652B;
	Wed, 27 Dec 2023 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="u18bTJEc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DEC46453;
	Wed, 27 Dec 2023 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703698110; x=1704302910; i=markus.elfring@web.de;
	bh=hrGMV7DS1Hq9z/Sx/zgTn8G7c+CCmRc26CbqvNt/lTY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=u18bTJEcOAvYsxLq2lWLLpNPETzZtg5KKMv+5oPocaSc6yRIXH4aN75ZdeEoC2kz
	 /A77l9JH7Dzu9Bij1azXZBQ3QhcVoIXbVr5ZzD6EZVaKgIKePcNboM9JBRAbNW8wo
	 OrIm+TfWhtxy4YDmyx1sjJSQyhZ2LjJx9h9T87VyKDssasmDRWAg32/5ezt4pLxiF
	 q+HX2KCT4GXxnSi7MZg4c1B8zTRkMgcG//XsrbGfm8jQJkh4I0Cyez1GpoTWyrKPr
	 l5z6tsae39HqVj9n4VUIoOaQvyU5c7BhlLZoZdGOqJ0iwyZXIjxOTh2m2IAM29wvy
	 5J/j3eUDOMRTqcEvnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWoe-1rXrfC2Un2-00KL1N; Wed, 27
 Dec 2023 18:28:30 +0100
Message-ID: <017f212f-fb55-42ca-bc1c-7f2522194a9f@web.de>
Date: Wed, 27 Dec 2023 18:28:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mmc: mmc_spi: Adjust error handling in mmc_spi_probe()
Content-Language: en-GB
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Yang Yingliang <yangyingliang@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <2aa6bd31-f3d8-41ac-abf1-9ec7cf7e064b@web.de>
 <ZYxXTVpLfI-mgxF4@smile.fi.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZYxXTVpLfI-mgxF4@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V9bNz1Vq4gc/izWZjmMc6xV8NhQ1cp41dBgf3I03DmYlY+8jTNt
 X192lV3pIcnPwQbGPj2wre8044olcROF4pPcdNDRfwlDjgHf3K1j79LPHSmcGez3eS3dMGR
 uFq/pFapverKkfXx0gTbHMdfVynoxGUlsl7xsLXH7/iQSKuPJIIQbEw5b+QqahJN8YLpC5F
 gnHx15GAazW62NiqY25IA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ReUDYDxLwuE=;pQgvrz6qztCFdyc/FQRg/Nk1gqt
 Vcj1nqZWWIYul35Q8rzZYlLrCemvCGgZER4teElf803vFXfeyFp410ZuyNUZnKMoD6a0IaNMl
 VxjwpoJB8LWYeHuGZ1TXf1Ik1BsET0C54sT+23Xbx6gSO/iWcpPAv9EsdtLnCCfgQ3M8ZhRjZ
 6qdCN34hBlbTjPINFupc9J7zdM9EhH7b8CI+J5S8vGFUEcf/68hWmZQNoXpPX2CIlkgx0wcMl
 7ib4QIvoj00nMkT6ag164VQK/idITxIybYGYYUrRpODiS0sxVGMKZJbsvvc8ZTPJYvLtSjHdd
 fziTLfGdoC7BbZLx+RlHjDTSldF/ZNhPSkxB0obRyCAvZJg6r43PXDDt5q/mH7JRXZrHzLqw7
 jrmM0WqBsxxB8vCDjgZ/NVr8C0kQtiyWTimVycjot+3Ldcn8KlSNUJFopnNGn1jWrmIt66sNx
 coIfA0/E3HgzLR2Xr/vZdZ53gyMmm62bHUQedstSGGgiNBRrB9Pt3D969jkjLTFRjR8WVB16Z
 nLsMemmFK8NckbjtSr10ovnaVYvCvR/7q8nG31cRJYyayGTcx6qLAFiuCK4ronXs7RtNm6vLm
 uk7rJxeOcuwtTSJn06fko8+Hviha7rIWkDVdXLlIIPYlushrsH+Bhl8wOSqCYnRsGTHhrJo01
 CktMUBmjYLNq4NPTahjFFTFqTw5MCiQKIVNugIe2EacZEhbNBvtfKXU3+HVBEqNwKmHjRQkE8
 HVTp5HjOqwxCKY6vLSwDVMtWJ3IxAIgFcTh9XEfh7jfSEmvtleNWpqAYe0efPs88Vy6kZ9mw6
 Ree21vZugeZOS62MtL6K8H2OAuwbaKZSpV751jlP1L+rWmpbM6j3uUBVIvf8SrDMTgFquLrIH
 5a0pzAoR+9dXmeUSoHKhzL+dbDgvS/aSjwYmPpQyd4kkml3cOo94M2kHMVh9mXAQBFj0mC5mt
 zorgMw==

>> The kfree() function was called in one case by
>> the mmc_spi_probe() function during error handling
>> even if the passed variable contained a null pointer.
>> This issue was detected by using the Coccinelle software.
>
>> * Thus return directly after a call of the function =E2=80=9Ckmalloc=E2=
=80=9D failed
>>   at the beginning.
>>
>> * Move an error code assignment into an if branch.
>
> How is this one better?

I suggest to avoid a bit of redundant data processing also at this source =
code place.

Regards,
Markus

