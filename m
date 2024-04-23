Return-Path: <linux-kernel+bounces-154989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A3C8AE3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C9D1C224AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163BD7E58E;
	Tue, 23 Apr 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Q9sCUdPE"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166507E578
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871866; cv=none; b=hF4CZTT866pTM5P//PSSngrjTzAkkNLmH8SBQ44gKo8zcusnNuk/LM5bRmg5m0nVUnuyaLoU2sKS1SCEkJpmID0wVV0KiKFIiMU9VIHRcUUWtxJLktY90nU/97EIXtRXS6IsLJVrLUSxtX3Z6paCUgVDLBPw6yfWGuvoaUv7MFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871866; c=relaxed/simple;
	bh=GXeqw+nCDkO9GKHRJugY3kPZKbwO9gNdMwJ7gPjSi1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bFPThY4fJENHkmwcTIcnRUt7aezNiTjX8PtDKhVtIpE3qkfsgDDHLGovucZAQDeidg+/t3Cr4+oHpiLnfHeQNBNukDhr9B/uyN/HCe3sHyx8K1F68qZqP0xysVtbneHWoLJDeC5/84roZLiW6axtDm9nBI0rpTKzNdEhICf1brE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Q9sCUdPE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CGVLx9qgz3TjtRvUwHvGwoshAcQcOViHaUvMOEjBRm0=;
	t=1713871862; x=1715081462; b=Q9sCUdPEvPdYU2lu75gKHHHQxI2qyTdV3qLOf0yvWEbLfjs
	P1KZd5Fhb/yYfQfuxUEEjym2EQMzzOewqo9pFfaReiQC2qTDrYZpf4QxlmACdJXUaieSF6AeUEUeT
	XAwexymDeL4caietoIyNyhl82Mvgfjxup/varCC6w7Zy29b0dhOhWJYqZ/HflWBog3sr58xcI+14K
	3R0d2pvb+BHK2Us2+cSZLVnxSD3D1prXbCUxGpSBwKjMC0aOaR8OAiYrJodfblwEsiPTyd94MA5E5
	MV9rAN9nSEHbduJJ2Vdw4sSZvgzBiB1fBGKKzgXI8T+J08hEYuH4UeK1DdH/dmTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzEMU-0000000261M-2zNz;
	Tue, 23 Apr 2024 13:30:58 +0200
Message-ID: <e850e5016348805e7e2f427ed98cb1eb539fc434.camel@sipsolutions.net>
Subject: Re: [PATCH 5/7] um: Add an internal header shared among the user
 code
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2024 13:30:57 +0200
In-Reply-To: <20240423112457.2409319-6-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
	 <20240423112457.2409319-6-tiwei.btw@antgroup.com>
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

On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
>=20
>  $(USER_OBJS:.o=3D.%): \
> -	c_flags =3D -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/inclu=
de/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
> +	c_flags =3D -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/inclu=
de/linux/kern_levels.h \
> +		-include user.h -include $(srctree)/arch/um/os-Linux/internal.h $(CFLA=
GS_$(basetarget).o)
>=20

Why not just include it explicitly? We do have the warnings?

johannes

