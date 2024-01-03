Return-Path: <linux-kernel+bounces-15242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E46928228FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E591F23C51
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB8F1803D;
	Wed,  3 Jan 2024 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="QC6jEHwv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE51802F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=bCfLSVPQoIMpScqiGU+FQxppHcHn7wqKQ1i1JBi2Q88=; b=QC6jEHwv22+wuyyUZYFHOvzBcC
	7l8/ue8JARl6urs5G+Clqr/przo5m/eC/zGeuCWLZS/l06oVjYiu/8e7ikLTQ61XMbIHj1TRLpL/J
	LdIFPvueWo3mLupiDLpMdaH44fH/4TzK/iIO68w8aZhw4+3oWPK9BpT0dWrYyLQ+IDVGv5iRDD3Iq
	Aub4yYWsWGjs82PnpOYIHy09xl5w+j501rjwiHOk+Jp+ZDoZE+pPojUuTOgi45xePI7JXzfiV3icA
	7QTZenBbufOLZKWMfLQq4jE3tGHKaA45RBvbBMqZo3ZCx2XpPVAkNMa0xcKdeHvkXjv+cRGWSSoOa
	oOdmcD/Q==;
Received: from cw141ip135.vpn.codeweavers.com ([10.69.141.135] helo=grey.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <stefan@codeweavers.com>)
	id 1rKvhz-009vLS-08;
	Wed, 03 Jan 2024 01:30:35 -0600
From: Stefan =?ISO-8859-1?Q?D=F6singer?= <stefan@codeweavers.com>
To: x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, wine-devel@winehq.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: Elizabeth Figura <zfigura@codeweavers.com>
Subject: Re: x86 SGDT emulation for Wine
Date: Wed, 03 Jan 2024 10:30:24 +0300
Message-ID: <13430819.uLZWGnKmhe@grey>
Organization: CodeWeavers
In-Reply-To: <3207569.5fSG56mABF@uriel>
References:
 <2285758.taCxCBeP46@uriel> <868D3980-3323-4E4A-8A7A-B9C26F123A1E@zytor.com>
 <3207569.5fSG56mABF@uriel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2924670.e9J7NaK4W3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2924670.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Stefan =?ISO-8859-1?Q?D=F6singer?= <stefan@codeweavers.com>
Cc: Elizabeth Figura <zfigura@codeweavers.com>
Subject: Re: x86 SGDT emulation for Wine
Date: Wed, 03 Jan 2024 10:30:24 +0300
Message-ID: <13430819.uLZWGnKmhe@grey>
Organization: CodeWeavers
In-Reply-To: <3207569.5fSG56mABF@uriel>
MIME-Version: 1.0

Am Dienstag, 2. Januar 2024, 22:53:26 EAT schrieb Elizabeth Figura:
>   I'm concerned that this will be very expensive. Most VM users don't need
> to exit on every syscall. While I haven't tested KVM, I think some other
> Wine developers actually did a similar experiment using a hypervisor to
> solve some other problem (related to 32-bit support on Mac OS), and exiting
> the hypervisor was prohibitively slow.

Just to add to this point, Ken Thomases and I experimented with this on Mac 
OS, and as Zeb said, we found it to be unworkably slow. In the d3d games we 
tested the performance of hypervisor + lots of exits was approximately the 
same as running all 32 bit guest code inside qemu's software CPU emulation, or 
about 5% of the performance of using native 32 bit mac processes (when they 
still existed). From what we could tell the cost was imposed by the CPU and 
not MacOS' very lightweight hypervisor API.

There are obviously differences between Mac and Linux, and with Wine's new 
syscalls we probably don't need to exit as often as my hangover wrapper DLLs 
did, but combined with the other reasons Zeb listed I don't think running Wine 
inside KVM is ever going to be realistic.

--nextPart2924670.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQxb0tqoFWyeVMl1sPRO8yFRPGiIFAmWVDRAACgkQPRO8yFRP
GiJ13RAAqjuafx3f25HgeI+PhElCBW4yzBMAemdbPY4PPMP/f7T3c2qvUZsdzjqv
U6yqikXrKpgpBy+pV2ofZK3W8hALIrSWaCng+auEwToa9lvjWP1TgPNcF3504xU7
vDpFtXmvBb2K/JmAbptyEdorf5AKSnGRjHgvbNXxjuzI/+OYL1BihK1w1md13MPv
1wdHXZUy6HuZ9wltoErAK3HdP5ZOSTILRpHHY58E3OTmcWREcds0sYj9IgvAOIV+
f6mUGkCdrgyHdtVMdpcwNcyksKyf+42pbdlww4GHDxD2zVlJkTbVn6bIS4DIBGJ9
jCOmr0clYjCXLCUAslCoNVSa/CpHab/64Hdg07lguqV3+u4FjVnrGs05jHTASVAW
3x1sfICCRV+iwjJpnQX0r9JQIv1ZKBd4jn+6ZpM1Ahbn/PKf5Plzw+XL18miyJL/
2+4CpMQ8K2kc2Ww/gO5a9yvINJY9uES2hEIvYgvZwB3NovO7sO2xPriEd0f3uKV2
aQg6D1KR46riMdFgVfKfg7vRBoLakd3CqbU6NAxO53EAhMd3L+MvTOSW8dVWYH6v
OU+Av5m7vKUPd22wzL4YKxlIBKdNpzBGHNj40/aCzhn5fJsgfHr0VDOl28DCrD4r
CXtmCIE8wNeW8lXmFU29lQcmIve4WLrt327qXp48tPLALqlaICg=
=0sIG
-----END PGP SIGNATURE-----

--nextPart2924670.e9J7NaK4W3--




