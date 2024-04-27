Return-Path: <linux-kernel+bounces-160951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD238B44FF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C5B1F229FD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899B94438F;
	Sat, 27 Apr 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="OqG39z5o"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C441C6A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714204192; cv=none; b=D+cAipXRObqlD4VA8tka6kCW6kA0xC4A55kQikUbS3S/X43VEWOrYWL6oASYs7f1PEctnELmfGNwByqM7K6vMuePwOl+Y+OTD98cCTggVeSeTzuMPDpkbT5wVVdZkASFONICEMGlh/obOW+Mdv9n4TMtfgEWEI2ipj879zM915U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714204192; c=relaxed/simple;
	bh=mUxT13d3le/sYzbS13OJP0O8pwkE/1ITfW2MS6a/btg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M+wR7p9RmmmgszLkkBsPcOh8iB5YVwj4EXbJlxLb8k3OSng8mTlrrIzFk61bLeKNq1DKuQtE9dsPVJv3EprB3FSyctCHsdJCnJ1fBN3XErwyykN1OsMVzw6Bz6ZODNeYBeDrh2NNKS/8kBSej9x+tTwXnokEDp9vYyoRuDwJj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=OqG39z5o; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1714204184;
	bh=mUxT13d3le/sYzbS13OJP0O8pwkE/1ITfW2MS6a/btg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OqG39z5oVRCPoCX2moeXHv/WSG375Ex9ypc8B6/2HxtangSFMZ8UPwTWD/qeDd16A
	 Ll+yupcL29vzs5vk1Wg5Ja/oXCRUfbTwQqqTru4hyWCs8usetRUOADVKza6cSjub6C
	 3BcC373LTeSYTz4W6Zb6XWpfMygGW+Mmsx5xmprw=
Received: from [192.168.124.11] (unknown [113.200.174.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 303E166EA9;
	Sat, 27 Apr 2024 03:49:42 -0400 (EDT)
Message-ID: <a3df8ae7ad7c4af447c6143858ae44c3da453704.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Provide __lshrti3, __ashrti3, and __ashrti3
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Sat, 27 Apr 2024 15:49:40 +0800
In-Reply-To: <CAAhV-H5vrCrBFhDKjTXchCGABWHT6Wxz1JK6hNsarOwp+vfHpg@mail.gmail.com>
References: <20240426121442.882029-1-xry111@xry111.site>
	 <CAAhV-H74cQ4XdDez5PipCxUZTpfS=CA6azL5qob=jGGebobD6g@mail.gmail.com>
	 <dfdc9823a0b89c8582587fa75448bba5c3a7e15e.camel@xry111.site>
	 <56414029e179d219442bde9b8eae81fa3e3ceec4.camel@xry111.site>
	 <CAAhV-H5vrCrBFhDKjTXchCGABWHT6Wxz1JK6hNsarOwp+vfHpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-27 at 15:20 +0800, Huacai Chen wrote:
> > /* The prototypes are incorrect but this file is only used by
> > =C2=A0=C2=A0=C2=A0 modpost which does not care.=C2=A0 */
> > long long __ashlti3(long long a, int b);
> > long long __ashrti3(long long a, int b);
> > long long __lshrti3(long long a, int b);
> >=20
> > How do you think?
> OK, then just keep the original status.

Then I'll just send a patch squashing the origin version of this patch
and the patch selecting ARCH_SUPPORTS_INT128 in a day if there are no
other review comments.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

