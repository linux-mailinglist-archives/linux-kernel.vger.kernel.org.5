Return-Path: <linux-kernel+bounces-116967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1F788A59D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01AA1F3EE94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2010C153819;
	Mon, 25 Mar 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="dDM8bDZV"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2913C9CA;
	Mon, 25 Mar 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368274; cv=none; b=iaFB5k8blXDTzVb+WVqSlyE71Hnh3+/RLRnQQmQ454KyBYRSlv7eze2hnCjpF9de7AAXhkGaG26X1bvK5l/QyCEjt2+fqP0OOoJ2gEHKcY/VZCqu1KZjazO9SM5qdh/uJmJRoFrFepdroqndCWCEL4x+pf5f4dqUVA6KofRQ5zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368274; c=relaxed/simple;
	bh=0wWxnhlUgMSZvuwxbr8ru7jSnb5aI6EIzUA0B0gFuCc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LU21OknWzRoNGgp7GMB4Vc9iN/NLaREHFixaN6zyWcycMNWw1ey8bD+po0YIZD9PvWTx5kHZEvPs3BbrpNPLw3Fk6yFJhtJRzp1AhSUzdn5iETkm/0pJeH5wkzb9R8y6+/VIZvcAyX5vR4U39japCrQQxYAIYLVBx6hsGvS6Joc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=dDM8bDZV; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1711368263; x=1711627463;
	bh=0wWxnhlUgMSZvuwxbr8ru7jSnb5aI6EIzUA0B0gFuCc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dDM8bDZVN7ZutsxtsURwCCD4JOFAowowErwOUgEQBTUH1IAzGg019hSmOXdcIkQR1
	 FI1jQLnP+CyzviPBqxLIanDf3Or2WCx4nRwCYfzRM9639Bs6TzelNSyRDoHKi8dMBM
	 /OMgRXWKlNOdraNVDhXPQ+IHRoLP8FuFSkISgHbfyt58xEtuGgZwcZRmNe/PR74ixy
	 nLiN9eOEGk3osD7VeehzK4svY/1MnhYXvVgk7mFiaSp7+DizTFG9qJ3Ohx85SXFzy9
	 SfvtXTK6A9gqHjw+cYZDeIE+bADez5uClVjklmzxmZpHNs3/ziXMhyzLLxoC8S54T7
	 Z4mdHB9dPfa5Q==
Date: Mon, 25 Mar 2024 12:04:10 +0000
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: disable analog audio for rock-5b
Message-ID: <CCTOoihgxcoHsOeXW4owCGYEAdaJ7kU3vQg9o0AFJaIvzbIj0EzBYn3To3dakOKjMwmozVEl5hwPD-K_GXYzU-XNK6GvIvRcSCMkOxDDvV4=@thefossguy.com>
In-Reply-To: <37afb6dc-28a0-46e5-ac39-3443999f3bd0@linaro.org>
References: <20240324062816.145858-1-prathampatel@thefossguy.com> <0005257d-8022-4a66-a802-0c920d259ccd@linaro.org> <TbQeSy-AWAKVHo2Alb8hXUvplVNvohDJ2ztRM1x3Fo5PMmGLMsJxtHR-OIms9FlUshfUD9x45EghBCB9gVtcUPlxeMRUJQ_C95DVhu3AJrk=@thefossguy.com> <37afb6dc-28a0-46e5-ac39-3443999f3bd0@linaro.org>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, March 25th, 2024 at 13:18, Krzysztof Kozlowski <krzysztof.kozlow=
ski@linaro.org> wrote:

>=20
>=20
> On 24/03/2024 12:21, Pratham Patel wrote:
>=20
> > On Sunday, March 24th, 2024 at 16:15, Krzysztof Kozlowski krzysztof.koz=
lowski@linaro.org wrote:
> >=20
> > > On 24/03/2024 07:28, Pratham Patel wrote:
> > >=20
> > > > The addition of `of: property: fw_devlink: Fix stupid bug in remote=
-endpoint parsing`
> > >=20
> > > Please refer to commits using commit sha () syntax, as mentioned in
> > > submitting patches.
> >=20
> > Noticed that in the wiki but didn't do that since the commit hash for t=
he commit
> > was different in each branch (of the stable tree). Maybe I should have =
copied the SHA
> > from Linus' tree. I will do that.
>=20
>=20
> There is only one tree: master/mainline tree. Commits in stable do not
> matter outside of stable.

Ack, thank you.

 -- Pratham Patel

