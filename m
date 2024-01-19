Return-Path: <linux-kernel+bounces-31306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA5832C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB768287D44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D0854BC7;
	Fri, 19 Jan 2024 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="V3tKoVeC"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC754656;
	Fri, 19 Jan 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677726; cv=none; b=DX6RhIPYtpbHUdxYnkTsKlUPq6jJf6QEM+5R4XFX+SPDcyXQ69LSIwSTWB3vn+JUCO7SlMBuwIkG4dYiUDa5Z2upd/uZ8CHvbyECqViAlRqx1U2IO7ITcMGG4ppxXtGY02yU5Ztog4vn7THgJNCTUtaERMt21EQ6OZK3Y0QGarE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677726; c=relaxed/simple;
	bh=sduG7CFjqy3qYfN3S6tvF21Xyjo4P0HqDDxfA1GLwto=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdcNPsXEg6mZV7BKq5o2jhHzQOnvL0pZYxNxLuVeaxljLmeaRqtPy4ibVQ+vxrGIsLtSnS5snObJvpTNy3VsnqI43WowU1AW+5JUbn8TlIxRIAlpIkjAHu/eRV+Hc+7VE7hSUk8F9RMUnOEbPZv0khEkHuNoHnL0cEhswCc0ccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=V3tKoVeC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sduG7CFjqy3qYfN3S6tvF21Xyjo4P0HqDDxfA1GLwto=;
	t=1705677724; x=1706887324; b=V3tKoVeCuEDlUbNcmg/LJUi0WA66Erv7HQNRIHdyLK8UDL1
	ofsXZRuVeRHbPWpqJKKweKyM5KO4oLDtxh2cQ1zBTchkKyJs5zmzoYGIXHAhaTYcFGNMppulSfyDs
	6gZ8Qkx4ohDcZYMFHsTRWq6pUWQ5xL3AVXMerUYZSHc0dioYF00XBq+b1D1YpphrFbkZRpwuYeqHm
	v8MZjMZ8J+yeL6AjTtYxGaSByb93CU+TE5bEhgOqjn1UXcgf2kLaUoT42sxhMXTvvvVHV74FIjpzn
	fAN4ipsGLuLUQ9c8DmkDSNjw2rx7r0QUT1ehqsy80UsYT5K/MeIoVS72kN8JpECg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rQqgq-00000009b8H-0fHe;
	Fri, 19 Jan 2024 16:21:52 +0100
Message-ID: <f5bbc81ac152bf8484faf0047ad8d4130b997ef0.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v2] nl80211/cfg80211: add nla_policy for S1G
 band
From: Johannes Berg <johannes@sipsolutions.net>
To: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvalo@kernel.org
Date: Fri, 19 Jan 2024 16:21:51 +0100
In-Reply-To: <20240119151201.8670-1-linma@zju.edu.cn>
References: <20240119151201.8670-1-linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-01-19 at 23:12 +0800, Lin Ma wrote:
>=20
> V1 -> V2: change net-next to wireless as suggested

For the record, I don't think anyone is using scheduled scan with S1G or
even _could_ be doing that (is there even a driver other than hwsim?),
so I don't think I'll apply this for wireless. No need to resend (again)
though :)

johannes

