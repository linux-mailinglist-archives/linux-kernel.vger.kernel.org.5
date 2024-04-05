Return-Path: <linux-kernel+bounces-132791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA9A899A32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2AD1C20E1D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FF1161339;
	Fri,  5 Apr 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IxP8PvBs"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA327447;
	Fri,  5 Apr 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311591; cv=none; b=VrOV1DfPDUWCa7OJsj3xaoDLgxlpRioErPlpbbB2LipqExT1P0PXnCGbQaakXShkNR/sxKmXq+WF591O9V0UjljSggNXzeZhx+nYRhQpPKJ0wh8IHXgJHqOWao4/ed1Z0xVJDkQ5qoTWE/TAxR8VViNCxoWKK5YVDtRaC3vq9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311591; c=relaxed/simple;
	bh=46/M8frtVI1xwHwJDfzOWBILidy1qF/nbknjFjniG0Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=I65StV5mdgcdNDrhriClKl9q4OrC2wlJNDsTnwiqTed+GXtEC+5YNHXCeTSYm3rt9yj375ai/0dYwy9zEwOIPqQdTOFBn+fgeIuenQb04lYAQiBFWOs3YucYd1vQLoC8yGifj7Cyp2z2FJJrzBhBkrYY0W+GvV5TIR7R5ZZvl3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IxP8PvBs; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712311570; x=1712916370; i=markus.elfring@web.de;
	bh=h1rD7cl36D2n8I8nOEC0tJ1ZmmxTzOTFUREe8MP1MAI=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=IxP8PvBsbBgI06W49RzUSQBvZz6BCq3PFnpRVr/ZpiFKbUMPG2UB3AtDHpkN84U+
	 lT2K2HCZIswoF7yj0G0WE/4+yM03xYmvhfvywElv5UJEsgo2Ma08KexaUyPV5Vopq
	 596Br/ZBhBLA8drDiizBzHtnFT6JxVd3NzW1Igh8OwUFw5TGkG6+ZN28EdXTLFilk
	 rpuGxpOjfkT+IpMbnLy3Pkk5OuuLB9eBZdgfeEJ5RB+ZC/D11D/Ou9A5BUnTLgtH0
	 s8ssHbY3ADf6l6wcr6Ad5Jc80L8ue+aqO4pJ4TAekuXq1JPhFbWAJBikPEvE1nZG9
	 3CcfR/cYv4/prJWrhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdHE-1s6txd3UOS-00Ubi9; Fri, 05
 Apr 2024 12:06:09 +0200
Message-ID: <12a5180c-fbac-41dc-b1bf-9eded9d8c5ed@web.de>
Date: Fri, 5 Apr 2024 12:05:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shahar Avidar <ikobh7@gmail.com>, linux-staging@lists.linux.dev,
 kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Felix N. Kimbu" <felixkimbu1@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240405074000.3481217-6-ikobh7@gmail.com>
Subject: Re: [PATCH v3 5/7] staging: pi433: Remove duplicated code using the
 "goto" error recovery scheme.
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240405074000.3481217-6-ikobh7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mhQpAhLFo7ec/e+NSRI//PqcCKVx4mChnrxS6HgTJKN0F9eJODN
 G18UTr3jFVbFS535x0kRrC5Awju3Fb7FQ92s/mBaG0mf5PQqG4RqxsUiadSxY9v/37CJQlW
 X/hJhWIZc44ruv9F+DgP29MYONiq7YK11IdqjEn2PMe5nqZ1gE2QtkCdgAIwPrT9mZ7PkYG
 usLzoDhNnMUOr835xL+bA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4QjQawHPQ3k=;1+SIoM3nxoQyGRfDtsKMlr3BPbY
 sdbnZGu6YO8wbYi7c8JOY+023ecEHxj6USL226LwddImTF4Y3ZRIDL21VzzUNJzTkXoj9Jola
 KJuvXL9NU3RAt9khWJBLEz4zbFlBZRFEctFR48ihhFvb1A/SeHNJDXMHqTZZ0zOla2AB58IeF
 cnNoUkmRk/tuRv+r9u89DNXhL/wX8HSmLvj3x8IFDlT2aZOUWJn51FnK3tja/Lb9KId0QIU4U
 ug13HJdwEMqv3IfHLf/QNFjdsTDxti0foXDAwFdOO3PYKMyuO52Vbc2ded8ZKGXRs6fyVAUud
 Dk6c+eFzTX0wYE28V+spJDjy+XPWnsCuROE1NZj5oxvQ6OG25zxDDXL+VuHxdRaGRMnX4G+VI
 RmFasWpvZ1zISIdmbmwTsNCILH4fVPvJf7a9ysDk2PljsWPMVdh1r82QsIz7GAoBRQM6ksoFm
 BR3cd+CkDUnXN5pslGn9BXiWQkIt8mwHU2vKtgshzIjJVkhsEsGSGb83e6tbPuRTfAjW+gxdk
 6DLA8D6SFvnTIa/UpaWRMalvbvvPoo0iXqScdvHx+9tVZXMK6B6CeLx0CkYs8/mxT/tL6s3B3
 e03KDak7pRwe1BsOmh0RnewcUWdfiVwcqmK3bSdJkAzBJoPyL5tMauBMezomezVIbnr/66oJe
 tk/E12ppxp94FdEBLmvGeBUyhDq+x98VD+jWjgwW+FniFMuu1sIIPBVaf0ptavuFMafGTDe1q
 OROECt+eoy3ivkVtxind6TOYLH3yx+kf8dlzo50XkTOAXkeZByOei8Y9N+W6qSDrOVwjSzA1q
 xs8WAb+Axc/tetLGUkn7TqGY4wJpKFf3Js0F1JxBsaZvs=

I suggest to use the summary phrase =E2=80=9CUse common error handling cod=
e
in pi433_init()=E2=80=9D instead.


> pi433_init had "unregister_chrdev" called twice.
> Remove it using goto statements.

How do you think about to use the following change description?

   unregister_chrdev() was called in two if branches.
   Thus add jump targets so that a bit of exception handling can be better
   reused at the end of this function implementation.


=E2=80=A6
v2->v3:
=E2=80=A6
          a seperate patch.
=E2=80=A6

Would you like to avoid a typo here?

Regards,
Markus

