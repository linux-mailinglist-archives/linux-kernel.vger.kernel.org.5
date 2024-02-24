Return-Path: <linux-kernel+bounces-79786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AFA8626A9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7925282792
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B46F4C600;
	Sat, 24 Feb 2024 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="obqcXRK3"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2046450;
	Sat, 24 Feb 2024 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708798589; cv=none; b=We4/ebhlVEc+SIgve87pcP8p+f1QDKb3yTfxvFd9CXsWGnC0SIZBKZkz7KN0p3jIcYG+0L/5ipu+fxIP+jXQs4VWm6wmky1bfbq5uRkjSYIssBx1IweDh/jRUbZqEg9/jGZV2BuZaCy84Iq0cxSA+pBJbdpjfPVSnCRkNCYU0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708798589; c=relaxed/simple;
	bh=VUx1i8XWpfeim7DHTmTo7nDlWrnG/F3najnDhzFbEu0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=EGSSf3z97GNnZ2bg4lsavOCwslVdGEzSvX9l9CMLROzQJ3A0iwweqN9p9/9v+R87bdPKHDuOg/y9JNVNDffVTLGOI+c6C9gMZ5lamVN1mdJvH8C95DvyvbkR9qXhfHBWa5LbHeM729OLbgK1sQjoBItWXWle1iOm4vCILkO3h68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=obqcXRK3; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708798541; x=1709403341; i=markus.elfring@web.de;
	bh=VUx1i8XWpfeim7DHTmTo7nDlWrnG/F3najnDhzFbEu0=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=obqcXRK3l8/f6gVhd0guF3S8rwmabTEE1NwgSuP3x5HBGyMvteRhIfn79357pqC6
	 beBKWNt9zzMUNAipF1WNf/uYEPDiFI0b3HVNH4Y3VdhvEf23VnX8JfVz4z95TqINf
	 mqV7VZgp0wacpZE3x4dJTp0IzFO197JRk6mIMrRUiF7RMGSpD5aq2sJwHQ+8My92X
	 IF8sTfEjrjbgub1/48bqoxm8TUIRznKJT5WtUQZvCXWctGEEL0NxoRhutUl2r+IwD
	 0b/73Y4wlYDuQSbc3mtNFBaKl2l8Z31n/Tb+4jVVAi96ksXGWOpRWpdzl63Tvc3w5
	 fhGzhYMwM5xZ5YI3Hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7epr-1rYiQq2PiX-008CCk; Sat, 24
 Feb 2024 19:15:41 +0100
Message-ID: <80b1afef-3502-4719-ba9d-682b5566688b@web.de>
Date: Sat, 24 Feb 2024 19:15:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: David Lechner <dlechner@baylibre.com>, linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Mark Brown <broonie@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 David Jander <david@protonic.nl>, Jonathan Cameron <jic23@kernel.org>,
 Martin Sperl <kernel@martin.sperl.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <20240219-mainline-spi-precook-message-v2-1-4a762c6701b9@baylibre.com>
Subject: Re: [PATCH v2 1/5] spi: add spi_optimize_message() APIs
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240219-mainline-spi-precook-message-v2-1-4a762c6701b9@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PDatmO5YnLqX8lT6ygw7MPKZXfWiMCjg+ZexIiXGIK3wvR8lKMV
 /D3tyZEGXNWGy+CM+nkgcUpjdTYfgURdM/7+bewmaixJqJJgLgWI5zi8O8NXfQ9AdFgo9ta
 JdqGnsqs4kbLdMlyl8QifRHdNHSO1yLeFJV+TpuyrVUjGrYyTcIQHXXPgJ6TaS5p1tsdTVR
 927Io9MXhIa5fOxDVxJlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3cS0VhBImIU=;bnuscn4tw449kz9nyq0ezwz1zYn
 znvFq8A809Mc1Ko/3CjdxpWOQYyGmzXkIu1yx+oyng4uHcin/fqlbDZsJmxY17tQQ+tV4uplU
 DGI4py1z3E1S/kJeloswIzeDmoj3o7rfhStWl8DhZzCh9hdAkcujgskHxJRbNBYkgfrefCtaM
 qKX6jKU6hRB4v5b6dG8pNzN+UuptzpKLvFg8GhNnKkfwB+Hr5RxX29Aqulfp59tRvHiv6/CQx
 HNshIcIpVwLvuIhIU5ssSkNnp64QS4+iO0p812r/689a12jgh87qQ1ww5n4PJxvmSKKdAwFbo
 Kh7dUpjrWpaOUC/mQBzgTkLw9hO9eJwQW2mBzqucVitxho5fc96zZkosMElSBLIUnz5bEAeEN
 9qRh2AEaYlz/lXEum+vZMBFa6MQtfYp1DFmRhHxjo3o0JDNZHAw1HvljZyTKATGh+MpnmWpiP
 I/xg5jwrggf0oXtRnZBKusYWCtS7AdyjIqetIAl5s1p/kUOR/7AfyYvtabhQOWyKG/zPvJC7S
 PsUdKuxh9fCvnsq0lZziEo3Nz8uQOGdiK2kyD9r09dwxQ7X10mqofUnqD9nAvYuM7/qiHVt9s
 IuHe8xojX7X+os3dauybB5/fzj6sjYSA4zkMPDHlzWgbFvC1cbTTn9SVNek7ke/IHc0cSuEfh
 luwKT1yO8U6+3stJ6ftbp756hIcP0wx3lcqwJ+2qsEy9lHRz/l6wGBIJ4gsPsfUX9DWBofvPT
 afY6uvZdrqUCVeXnzTTf7/k1YUW1SXDWkh+ZpSIChGdXfjDAIkVuiEmrHNAM+OwPZjPh61KtZ
 nVd0zyKylIJotK6myJI818B2cn880ihp/1IP37EwCMjY0=

>                                           =E2=80=A6 call it. This is don=
e to so
> that controller drivers =E2=80=A6

I hope that such a wording will be improved for the final change descripti=
on.

Regards,
Markus

