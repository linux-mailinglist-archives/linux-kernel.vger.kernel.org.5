Return-Path: <linux-kernel+bounces-95331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E7A874C63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1DF2B20E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB4B85284;
	Thu,  7 Mar 2024 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VGXnNUZc"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B8E82880;
	Thu,  7 Mar 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807392; cv=none; b=Rzq/5WWsP/9NSIv5Sa7POwrVcGPyd3yetxlhBrBgonrJJEwrC5bWcB2LEmRxNU5dNm2GXlhhEEQ8UsKPFHfFgpZIJZ6Bo2sSE0eHp6UWaQXtl7HWYhMtm0D7v0wxHaMGm6g4/90G8yAMvHGDvLyUH4hFlsYln/n+hfaI/yTyX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807392; c=relaxed/simple;
	bh=vkFekbspeK5lcVDIHIUxDZO/hMV0UJA60B9DU9IECYA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nm1jHS/ySY42r6AxZ8fuWqcMiF23PFTlkwA2u7dcf6GISYx0J6hNdweJIBnMWznvvzyTD8PGERcZDwUW1nIUc6AR6MFEm5N3HUMT+UEjnZVLDmOtAV27NO0qHMWbT47sCucAZJw09IgJNGCLHg3sa+IBD3/r5VNjvP3Z7Nr8uk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VGXnNUZc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vkFekbspeK5lcVDIHIUxDZO/hMV0UJA60B9DU9IECYA=;
	t=1709807389; x=1711016989; b=VGXnNUZc/P+de7Tg501CT7kEHoKPGlCOF2QDGMat4UUqhS7
	2v3zjshr7AuDqSvfjMnljY7gcYAkCHcxVWWieaYkm9LKqAheQhVL8+cpjBhVPyckZD3sAxgbfL3fb
	um/KRyGcNu5pi6k2gEFmvQ+jzoYtcJ49Ii1wmrztcyIohfGsSoh/nQ0jy+pXHFjZCilZjZvqDLwSR
	/sUyFduSFqHPbn9BuGysn8iJrXbkbKGbrBttAZq02zMolddMMEYeZG9ejG42DOQiOuA4qY3zzR5iO
	Gz6WR3HRJD0ll/OhwPvfjYnFJbG6ICtS1lZYs6Tc0cl653jbSEQGO05RPLLHuttg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1riB0U-00000005bPH-16fc;
	Thu, 07 Mar 2024 11:29:46 +0100
Message-ID: <a485fbdea26e19afe00f603bd65c83e2be20abe6.camel@sipsolutions.net>
Subject: Re: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Waqar Hameed
	 <waqar.hameed@axis.com>, Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel@axis.com, Richard Weinberger <richard@nod.at>, 
	linux-um@lists.infradead.org
Date: Thu, 07 Mar 2024 11:29:45 +0100
In-Reply-To: <2cc222b7-618c-46a9-b78b-eb099d0f4be7@cambridgegreys.com>
References: <202403052336.y6DkUd8a-lkp@intel.com> <pndzfvbibgm.fsf@axis.com>
	 <87cfca1e-3f53-4935-a274-0920bce86373@cambridgegreys.com>
	 <463be980baf66b967031e3294c3b9745b07aa058.camel@sipsolutions.net>
	 <2cc222b7-618c-46a9-b78b-eb099d0f4be7@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-07 at 10:27 +0000, Anton Ivanov wrote:
> >=20
> > How's that required to be formatted and loaded? tcpdump itself can also
> > dump the filter in BPF format, with -d/-ddd (-dd is a C representation,
> > so probably not useful). Perhaps we could even automatically call
> > 'tcpdump' at runtime?
>=20
> That is one option.
>=20
> As far as common use cases are concerned, at present you can:
>=20
> tcpdump -ddd, convert it to raw binary (3 liner in a language of choice) =
and pass that to vecX as a bpffile=3D
>=20
> It may be worth it to make vecX also take the -ddd format directly by add=
ing "format" options to bpffile.
>=20
> I'd rather do that instead of invoking tcpdump out of a device open. The =
-ddd notation (+/- a comma here and there) is
> standard - it is also used by iptables, etc. It can used by other code ge=
nerators as well.

Yeah, that makes sense, this is all kind of special configuration
anyway, and given that it's been broken forever ...

I actually doubt anyone would scream if we just removed it, so maybe
just remove it and if they do scream, point to the above, including said
3-liner in the response?

johannes

