Return-Path: <linux-kernel+bounces-79830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BBD862747
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9521B212D6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B824D11F;
	Sat, 24 Feb 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QNt6B8Yk"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB53469E;
	Sat, 24 Feb 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708805786; cv=none; b=OI6Wnqt/klBmu2HjOK7T6RWMSR7MgqqMqmfbzRvkhhHs/jb75WMTdT233v/vkuymlfG9ZhJoz2Wa1WjCOjJ9rElL6lLhw4pTU16DxMi0lW7o2iwjRHgcwObFC22CWl0pASqT+WO7budwTtdT1kswlVYXfEHVYstcTuLuFBBNrKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708805786; c=relaxed/simple;
	bh=yLz7Vg77PB7IlV1AITmSO9pNNY8zgh7ejy/6z5+C0lo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mjNVsQrHZPjy3coMRtUtORF4NzMqfzHKLCyR0HEfNE2KlfMLz+0JKRbDW5U2vzUmxtSvgchLQqzAsiWiFYzpQPxKHH+oKvk3gZBWLSsMNqn21+jV570ls1kow7QxnU2m0bebuae/D6vftqNySZGyT0jNaK/aP6i0LH5hJSH9+U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QNt6B8Yk; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708805777; x=1709410577; i=markus.elfring@web.de;
	bh=yLz7Vg77PB7IlV1AITmSO9pNNY8zgh7ejy/6z5+C0lo=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=QNt6B8YkGNqRWjK92Je/bLysp4ai5k/0EujaGr1eWzp86Q4DPbv5901HqtkJ/ImL
	 mPM/BeAep5L4IapLHjYB8Zsmgoxidk2oOyRoG5YK4VhnvSYtpNd5AeRHb76+xX5N9
	 2MSW71oB/LjBnkMP+NRqJOoBrhNFyShAtbUUMTBx17ogYfPEd9rdi5O0POlfUc1f0
	 zvnneTmviXfWCkS087OI2RdBC/WvkBBqHA/7tHF9VWUDDyPq/i2RkVBa+Sj+xGvSd
	 8NnxynGyrHF9CrTqhQEu/AnmOA7Iuft59hFT/1uRD70t/ldVHRQ/QDJJMuMfmmbse
	 6tt1eK+1XwicLSWALg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkElP-1rBoP0152X-00ka9U; Sat, 24
 Feb 2024 21:09:43 +0100
Message-ID: <0f25b520-563c-4b3b-96cd-d1dcc7ea6f40@web.de>
Date: Sat, 24 Feb 2024 21:09:40 +0100
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
X-Provags-ID: V03:K1:KmuGeYS0ux4JU6O/o1Nu+42F6g71tHr+fv4Cdf5CuQtvKg1uvSg
 vjYqz61D7ymrpo994E5hjD1PvjDRPtvAwNo4ABW+RoF6DWx1XWXdjexrxQauqSgPlIiKbo3
 nRHW4A+GgRRwZp6WbEM7VuOXok/HOHsz2z1MMcumnqxMuE6AJtwolCKp6PbYWs5E8s6iVYP
 9jaJaK9mvtvBHtKRt3VBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5CHPEWZZ7GQ=;zQWgfxumXQtHf8dKzPPr9zY4xH4
 Dk0CNOIPMl2d4EbhSQZfjYsO6jKS46xWTXOrFyf90nXeXsKqLRCMBeekbPglwWSBN7QdKxBdD
 0L1mq+g7KKqemQG7JMzCdDg3H74RKDQtS6ZFomNdyJW0yCU3ZbIaIpn7wsbX82lmNrNs9wrqn
 od0XLdwPP2vMiFEj9DRBhcOldX/dDSfeKDFsgKi10kNOVnbvy3+Wzxk2f1ac1JcdgPIT+iS+Y
 iaSh0m/qz6fYCkO25PYu3caWHornpzEmSntiZ9KL3ZZQ7PL42FcorzLb9eV0hfDgkJ2cijU0p
 6h9FidploBmVeX/EFIkLEYFxyJ7PM17K+k/6pZz3blXRrJDK7rw2l2m+veK5isv9gXNyHdqgT
 pzYpkZzHTsisTCwqTHNda6TQKlKL3HfZO4ZnUqC5OVmvlkOGVzIqCFE06qQaUvzGX89SQpCCU
 u1F8mmWra9nBwTgV/pGno8X0gwjijH6Shwm3kX1BmEPJHOc7XRtr8aCv5MW/VEvKRDq68ImPe
 OlwXuyJ6LkBaiF1L5GwCPqsFagqLpXB0E7M1wWokHr+kY1xqc0ux7DNjQezoNBNkf8OstiJ6j
 09PNrZ/QH4o3zOKOAo0REqVpyquyGl8GrkRxr1QlfI+EO2TRqrMy3yMlQEUbYVcN/Szha2doj
 r0cjpc0684SB5ZuW+AmwaLaTOly6OyEzX1e689iJ0VSkV2qkxChF0W99x8LPAXjWgRr70knM2
 RKTmCtdYQcgtl2jk6A4rLpo3+oXMfXBzLyr6g6pQESzk+AWbZqzClsTxNDMfJQroAwol4RFN+
 G8iztBInP4/xAEuvmrCK1VA6w3XiSkJM5jxsxh/BCrC+8=

=E2=80=A6
> +++ b/drivers/spi/spi.c
=E2=80=A6
> +static int __spi_optimize_message(struct spi_device *spi,
> +				  struct spi_message *msg)
=E2=80=A6

I propose to reconsider the usage of leading underscores in such identifie=
rs.

See also:
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier

Regards,
Markus

