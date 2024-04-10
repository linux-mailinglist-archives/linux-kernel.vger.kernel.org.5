Return-Path: <linux-kernel+bounces-138422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA3B89F103
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8891287AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10379159917;
	Wed, 10 Apr 2024 11:38:53 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1574BE8;
	Wed, 10 Apr 2024 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749132; cv=none; b=lMa5FFhErxmqOnXdXcaTdrfFalCGxprXDppcPdfJ+hbrW17hBn+oYUJOaz0KyQauZdlwZFQlc7z88laDCgtKm3XhbLz0wYJItpXTCKrOWyivXDcBNCVbGcPSJ6RGaG/TIHtUSN6VDOfKIwsUxaADVdxNRXF3ZFmn0dqkK5T0g2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749132; c=relaxed/simple;
	bh=EDVcGieKBVTz2AJLhpvH1T+PC6Eq/mmJrNHMavEH6pQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l99e0GCZtjIHRVGYHgPLd0hGjh6AbKHVAkcd0RGVlU/7YJPKI3b35zlfo0PAnHgx03mEZoHF30nxl7O92lRwZLsqOsv/hf87pNVUxq+khY7i+oYhwQY0pds8SnhPLZmYM3M+VDGNRuueJFbA4/uHzqXEm0Lj5vynI9zXtnWXg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com; spf=pass smtp.mailfrom=ozlabs.org; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by gandalf.ozlabs.org (Postfix) with ESMTP id 4VF17B15kWz4wx6;
	Wed, 10 Apr 2024 21:38:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VF17B0HGSz4wx5;
	Wed, 10 Apr 2024 21:38:44 +1000 (AEST)
From: Michael Ellerman <michaele@au1.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Donnellan
 <ajd@linux.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>
Cc: "fbarrat@linux.ibm.com" <fbarrat@linux.ibm.com>, "ukrishn@linux.ibm.com"
 <ukrishn@linux.ibm.com>, "manoj@linux.ibm.com" <manoj@linux.ibm.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Make cxl obsolete
In-Reply-To: <0dd09e90-440d-46f0-827e-cbef93ce72c6@csgroup.eu>
References: <20240409031027.41587-1-ajd@linux.ibm.com>
 <20240409031027.41587-2-ajd@linux.ibm.com> <87bk6jb17s.fsf@mail.lhotse>
 <0dd09e90-440d-46f0-827e-cbef93ce72c6@csgroup.eu>
Date: Wed, 10 Apr 2024 21:38:44 +1000
Message-ID: <87o7aha1mj.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 09/04/2024 =C3=A0 06:37, Michael Ellerman a =C3=A9crit=C2=A0:
>> Andrew Donnellan <ajd@linux.ibm.com> writes:
>>> The cxl driver is no longer actively maintained and we intend to remove=
 it
>>> in a future kernel release. Change its status to obsolete, and update t=
he
>>> sysfs ABI documentation accordingly.
>>>
>>> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
>>> ---
>>>   Documentation/ABI/{testing =3D> obsolete}/sysfs-class-cxl | 3 +++
>>>   MAINTAINERS                                             | 4 ++--
>>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>>   rename Documentation/ABI/{testing =3D> obsolete}/sysfs-class-cxl (99%)
>>=20
>> This is a good start, but I suspect if there are any actual users they
>> are not going to be monitoring the status of cxl in the MAINTAINERS file=
 :)
>>=20
>> I think we should probably modify Kconfig so that anyone who's using cxl
>> on purpose has some chance to notice before we remove it.
>>=20
>> Something like the patch below. Anyone who has an existing config and
>> runs oldconfig will get a prompt, eg:
>>=20
>>    Deprecated support for IBM Coherent Accelerators (CXL) (DEPRECATED_CX=
L) [N/m/y/?] (NEW)
>>=20
>> Folks who just use defconfig etc. won't notice any change which is a
>> pity. We could also change the default to n, but that risks breaking
>> someone's machine. Maybe we do that in a another releases time.
>
> When I boot one of my boards I see:
>
> [    0.641090] mcr3000-hwmon 10000800.hwmon: hwmon_device_register() is=20
> deprecated. Please convert the driver to use=20
> hwmon_device_register_with_info().
>
> Could we do something similar, write a message at boottime when the CXL=20
> driver gets probed ?

Yeah, I think so.

There's still the problem that people tend not to look at dmesg until
something breaks, but at least we can try and get their attention.

cheers

