Return-Path: <linux-kernel+bounces-36278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DA5839E53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA561F2A9D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDE7187F;
	Wed, 24 Jan 2024 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="cOAqZti5"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300515BB;
	Wed, 24 Jan 2024 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706060228; cv=none; b=D4T/9QkSIpsgRQ1LjqwfoDUGAsP8Y9wDBCUGrz3nBTK5qCI9Zfl5eCM5ajwtvpXtRXyAijjQ3h+YHnjEBjyR62Npwsjc1Z6T1XrUL+bDjLuNGcf64+I/TCXsMtW4hX4n0xBJ3zDvpmEx86BPJMkedoGbsJSgWnpp0tfgDiqmTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706060228; c=relaxed/simple;
	bh=AkxNZCuiScy7QujUJurjgNtf9SHosScGSpMo9SYfWFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEd8YsT6Dv0ViaMXGlq72yODLWlGa/TZV1DXs88+jgGGId0cT4WRL0aK3hwczxLaMP02ttEWl/6Qsjv1lwdnGyWlgHXNIvTi35j+bosKppK0MWkhp5JTycJ2xmT+bUUBsCCII+WscVrlgVASUncRwEALvk0Pw3f/Lcgx9ych9F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=cOAqZti5; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Tpw61aX8UyRO/CdHBlVWWO1h612nMeq0gaCsDS1pyYU=; b=cOAqZti5ch6HuWehrVFvNJvOKu
	RT6uwbNyBFMsFgwuFTtmjMe7NETaZXAWL+0lSZ3y0r7dS8XzNTrSDFis3EdMo73RZyJEAYHo6Hp5l
	GYurEPrUxAbz8l5XokuL8zAn4ToP54l3UZVe17vKYuVvmPWKq62Za1OaWDyqf5kk6ppO6zurhBJFv
	3I4PjKcRA3gL0xAWfymYJA9vu3NK0xfIMOB6DiLNCr/V3wCkD4YpMGrDuCNr+yP8dYTq++xOvJ1bm
	i6EVx5yM/XmR3TMEfAXHVJjwVoBEz765K3I8dWZHrZCmhzyh+ybXNZnsMm2nxvtdvQ9wRsOPhcFOe
	R6ezlrcQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSSCL-00DYCl-0j;
	Tue, 23 Jan 2024 19:37:02 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/9] NT synchronization primitive driver
Date: Tue, 23 Jan 2024 19:37:01 -0600
Message-ID: <12365105.O9o76ZdvQC@camazotz>
In-Reply-To: <2024012319-aptly-calculate-0f88@gregkh>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <2024012319-aptly-calculate-0f88@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, 23 January 2024 18:59:35 CST Greg Kroah-Hartman wrote:
> On Tue, Jan 23, 2024 at 06:40:19PM -0600, Elizabeth Figura wrote:
> > =3D=3D Patches =3D=3D
> >=20
> > This is the first part of a 32-patch series. The series comprises 17 pa=
tches
> > which contain the actual implementation, 13 which provide self-tests, 1=
 to
> > update the MAINTAINERS file, and 1 to add API documentation.
>=20
> 32 patches?  I only see 9 here, why not submit them all?

Because Documentation/process/submitting-patches.rst makes a point of askin=
g people not to submit large patch series (and it matches the expectation o=
f other projects I've worked with=E2=80=94that patches would be submitted a=
nd reviewed a few at a time). I suppose I've misunderstood that advice, tho=
ugh.

I'll resend with the entire series. Sorry for the noise.



