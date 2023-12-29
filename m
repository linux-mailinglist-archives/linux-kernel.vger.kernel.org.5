Return-Path: <linux-kernel+bounces-13010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C768181FE63
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D36A1C2229F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11E10A07;
	Fri, 29 Dec 2023 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="l07ZjodO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE35FC04;
	Fri, 29 Dec 2023 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703840428; x=1704445228; i=markus.elfring@web.de;
	bh=BTlTiw3od+zRvZkdkmC/usfjKGkFNJTzefXH2qefj40=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=l07ZjodOoyATj0Jz/jD/neCa3r83waQzBb3O6X6Ar6X/kjFiMlYTtThb+0hZs3pV
	 KyWXSs4Gd10EoGVlObSfKi6cS7pvrjcwKpuE+UKy70ZK7i3cTxJRiCkBqP6wpyeba
	 Ry2mM5gMrMQNlxR8GUMx6hVNuYODTJab68JQuRjZ8geowjeBzlTAcBO/stTtjOj2u
	 gvSMa9eKT7G/Jf5bYElrjDS2QiJN+zypZDB7EZQXe3XPTenNys3EmSkkar6onobRX
	 32Bd5MTA1QwMEMr2BX6QQFhzLOaAZzDCG2fk+2ekQhcwmGgxGxzrazmUGPGYzZgLg
	 xD7aUEt1r64jlBhHvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDQZ-1qiQrj2X4R-00avGO; Fri, 29
 Dec 2023 10:00:28 +0100
Message-ID: <df72e6dc-5d4a-4101-9366-24a9166ec9ba@web.de>
Date: Fri, 29 Dec 2023 10:00:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Input: MT - Return directly after a failed kzalloc() in
 input_mt_init_slots()
Content-Language: en-GB
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
 LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <5088a905-4f29-41d3-a96e-5b66aad551f1@web.de>
 <ZY54hX3VLswwKgMH@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZY54hX3VLswwKgMH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ygcekGhx0S1ZMtT/mPQnzee7NC/ULw8FHFpKluylUlAMwneyvoQ
 5o8HMnGrlADOZSswpOTbLmvctCdDNHiRBDhdDS3I2iHQ0v1BTPCJZyIoDamFp6ebcKAR7Wy
 nOiGeAVSznZ7hjYAbm3Q03BRREJtYMDBnl+lEQWAIfqQIR/iymG8ooWQvjsSY6KwJIHPKr5
 VklaoYKooZsxs4PLYqQeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:arcw1lIPLVs=;H0swndXBK/ormHQV4YcjXhL/wzf
 eW7hTc/MWZK7jSd8+Ns9BN8ysD2VbXhpWKai2/JclPXR8UGH6fTgOa42TS5Y0fjCr9lm+fPX3
 wjJWPMFrT1h1BSreFjRFYBQbafgT0GLHXeHGcX7zHz3xLMx3swPu4Fl9/tDDc+9X66ItGnVkd
 CIUJ4E/OrBPcHyAxkv5YoBDEWLhEKyIqwQ/gbiIyxOt/2YpolnZ/oUJ4dNi7Wc9QVRdwlVwG6
 yj1SSlTQPsLU9h4vtcs/wKdm2A7j6O0HJMkIy5SHdxfYNn3ONwcsyELlKD8YfJX1rdgIkBndx
 eilSOK9nmzGN7s125FzmiU6CiwUY0U4Wz3uJTrGyfD4j9ghB0rHOC+F7rpv/0Ib+UFDhzk3nO
 pbNWbowDg9994ZULfqZOMHiMl4N6WKc92oYXvWtoc86deNrQu68EKrqX2Fx2thDfNNw6BIddp
 Fh1e16E7w4of37XGOdNeSVwBlJdo1SVaTyWaGrLNx/DXSCFTdWbHD6W/l+w8MEKPUNQuzK116
 1JUeeAredBclUWOVW3MuhVt8C+bhYUVjAvFBwxTMT2xyXWS5PpZ0+JYFXPR6RazTnt4NU9u+B
 sYlovPS9FBz3WhIATK3o0e7OdoQ/ol0NZIxogIXyguai5Msl8eEQB0CZmnv8jDCCbYS0Cm5DD
 7+/KOYRdM5VVnz6c5CN3bgDKB0PVl5MkPgqyBc0hhLBLVaUF5RCuyN5yC5zKa1C/LHn7CWlb0
 m6sSlqd8Ba1rTOsBs1iPxrhNZ/ceZEMhN1geabTeWrLpc4nuspvz8boihZ1dbnDedgI+uASw+
 5tr8Doyth3HpEnC/WEahnYzOPK9zPsIrw3E1YU2VTwLGxUmSzq/4mcdgci8e7P+76Q251AAHd
 jdSPzTx0tfKxxdj6DEXdgNpFSdmykqT74MMuFH7JkPa9zekYr6FlGI9fV/TyMlzOagZQ94C4m
 m5ZGSN5qCaPSByYsgUXtjkGli9A=

>> Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=
=80=9D failed
>> at the beginning.
>
> This is not needed. The same arguments as on the patch to
> usbtouchscreen.c.

I suggest to avoid redundant data processing a bit more.

Regards,
Markus

