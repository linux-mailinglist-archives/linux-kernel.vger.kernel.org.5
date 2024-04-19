Return-Path: <linux-kernel+bounces-151615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4488AB12D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197C11F24442
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180D612F582;
	Fri, 19 Apr 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="pgyACKPu"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653FF7E11E;
	Fri, 19 Apr 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538770; cv=none; b=qF2KL1PRl6Z3HieZSWsbXV93ZVpWaxwLMFmjdjpkIvrYG999VK7TYC0FyawsIqG2W2jt5oKgzoLamkZr5oDYjOj9DGVedK0aziPI6Ow518MtM1OefZv8dINwBDJWs3iEMigxTUa7QYHPmMwIu8R67KBh7OiU0jW7UZ5WuL457HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538770; c=relaxed/simple;
	bh=xLGjrkO2SUO1JRzITsRXgRMWDPb6x/5WT0uqbMPvzZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLsUdFZlAm279Ot/yB4wUYCyhJrHPUFc/1LlGoCsAjOjiM2g3TVvedEZRJCqP0imFuzyTi1fQZj2ypUk/CVJHdbP33++Y+0NJqYRmYXcPah8acNRjfzLNfMLcUsTNZW52++H2I45K2QoQggQfosHnYyhytbwV2JFsx2MPGB43vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=pgyACKPu; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xLGjrkO2SUO1JRzITsRXgRMWDPb6x/5WT0uqbMPvzZE=; b=pgyACKPu/RWlwCbCYmOLHGKkpN
	qXc3g/C9YHNV18TxlsMgR0ws3yFawJIJRnme7vht+hsmLY3EvUlHglgfHka7H7LcF9/9UBKAls18o
	JZwphik575UyT+NMYXTBIeT29twgZ2T5yr8ukRZTVdFt/X5tLWN2K8sL1YqYbjdbx0EZYLnk5NYvC
	+6jM9LFZUmkc3DlMKNXgy9f2JaSfIsEnCeKZ3HnJQI++w3gAfl74GkMtSw+alc8EjA9+HyPS2OQ3Y
	taidi6a9gyVurzxINRyyl12H7+6wO+/d84lYa58wXVdA7RVSkUTt0MJxi6urqLzTiaCH3YuyOI+fw
	Kl24Hk7g==;
Received: from [2001:9e8:9f5:cc01:6f0:21ff:fe91:394] (port=41248 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rxphv-0047Wi-RX;
	Fri, 19 Apr 2024 16:59:19 +0200
Date: Fri, 19 Apr 2024 16:59:16 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 1/4] arch: use $(obj)/ instead of $(src)/ for
 preprocessed linker scripts
Message-ID: <ZiKGxKlG6zTrDgkv@bergen.fjasle.eu>
References: <20240416121838.95427-1-masahiroy@kernel.org>
 <20240416121838.95427-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pNeCiBriP5NkfKjj"
Content-Disposition: inline
In-Reply-To: <20240416121838.95427-2-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no


--pNeCiBriP5NkfKjj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 16 Apr 2024 21:18:35 GMT, Masahiro Yamada wrote:
> These are generated files. Prefix them with $(obj)/ instead of $(src)/.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Helge Deller <deller@gmx.de>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--pNeCiBriP5NkfKjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmYihr0ACgkQB1IKcBYm
EmntWBAA6krPg9ICWmLwKtUUBF+2KhBJnuyRxv+8Tg9S/rWm9Z4iKd2rXiVZPQHE
DxASgFwIiwRhF/C7uspK2v8ujd8oJ5053wjEvQSzlCGXDXac0/9cFayB9HJT6gg4
E9Kbj3DwTmTHOXr2U54OUtiMYTq8c/AS0cDdgpu032MlrUQLTa/efuT27YpQY/da
Nl8Wd279/jAHaHGZWqkIUca98i0aN+BwFrnF0w5/p3sDfZyPrQOhKiCVr+zlDxs6
i63XmQloX/X5O8vpbnHr9YfViKs/SBZScKUvlfExkHgmFDdpqNDtZw8IerwjOD0T
RD/44KfHUKeCOSBMI7IAmkFUxStx8fQRTRKQX8pixWCvXgRpj47XTVA0sl02VYk3
A3mz6CXoEAz0eJrG2ud3pBIjDsyISH54o6I1O0uZhmSBuh4tIA9CsknnwVcEHV/A
rcp3FsyKkErfo4e8jP2g9XsfVwBncT1uzt5IULOZ8DDyK2TXyFggT4veEUsl1zeq
gvvNPuYb01TCY5JVKFFsICe1nhIYsNAyTG5XVfqMxyRH/XOZ9IVrp0/VAXw9uZ1e
NvzAU8zsQjVXbNU+62to7D6OPvbz9HmUGEFP4IoWRUdOcQmsI6Y3CkSI1JFu4MxJ
1TYCBszGHDirOzJgddQACqyeva4+4+UPiXQxkqtqceKbGTwVuo0=
=HbVg
-----END PGP SIGNATURE-----

--pNeCiBriP5NkfKjj--

