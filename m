Return-Path: <linux-kernel+bounces-80601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4992866A32
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EB31F22DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49BE1B27D;
	Mon, 26 Feb 2024 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W2C6wma+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KJMoawp/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W2C6wma+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KJMoawp/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C71BDCB;
	Mon, 26 Feb 2024 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929885; cv=none; b=LEoMYMvBMbWf7CLFx0Z26nOGreAqZTSUAYy7b7LL13FvFkWI/kgEXqh7Lra7Yq6MnXACVjfHxy9aroLceqEOh0XbjhBvxBuFXh41dozXurXCCgzslkABl0Webm4PaILJkwka7VQY7zAkgwgKuO4J7khdKMvwlEwcssJlRMQVYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929885; c=relaxed/simple;
	bh=0jR4/i7gzhFMuOdekx0+xLT5ggNU6KA0YqzULT8MLiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF4O5YgFNcnf/+AaDivG79gwxsnZHFRlMbpjTadfEZgf2KsONKgytFgkzLdcI2miH9CgPGbJeM+86W/D/ckKCtyD2usJlRB8LTNtNJbeN0Z3vhGGwA7awRNox5/ckXFJvwDMxvXeu11OP+XDDcuFmRzizgvrnFXVnDNX96ke/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W2C6wma+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KJMoawp/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W2C6wma+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KJMoawp/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA1922233F;
	Mon, 26 Feb 2024 06:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708929880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+h6mH/zm8We5PynLw0CU0r1+Xfy20Hg53wFN8364kU=;
	b=W2C6wma+ZOEZsgkmamUWxY50Nicn++NFciUw9MzkP/imZEZk7NqwckYvv9/4Jc2vAP7nzR
	Y3TmopAjVzgtSscKLguqCfFjq4UtD8FbmPk1r0FvuAYG6X+dtjNm4unBBugG8b+444bKNT
	fvL9Sqr03RFX9akcvGBusZmO34KpCtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708929880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+h6mH/zm8We5PynLw0CU0r1+Xfy20Hg53wFN8364kU=;
	b=KJMoawp/vPoAmOMiYZJMyiNhIgIjkwr/HEpzLUmkw7GQoOiOydzNc0Bds9QSg5Lb3bAoQP
	CQv31JvV44DAfjDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708929880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+h6mH/zm8We5PynLw0CU0r1+Xfy20Hg53wFN8364kU=;
	b=W2C6wma+ZOEZsgkmamUWxY50Nicn++NFciUw9MzkP/imZEZk7NqwckYvv9/4Jc2vAP7nzR
	Y3TmopAjVzgtSscKLguqCfFjq4UtD8FbmPk1r0FvuAYG6X+dtjNm4unBBugG8b+444bKNT
	fvL9Sqr03RFX9akcvGBusZmO34KpCtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708929880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+h6mH/zm8We5PynLw0CU0r1+Xfy20Hg53wFN8364kU=;
	b=KJMoawp/vPoAmOMiYZJMyiNhIgIjkwr/HEpzLUmkw7GQoOiOydzNc0Bds9QSg5Lb3bAoQP
	CQv31JvV44DAfjDg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 95ECD20147; Mon, 26 Feb 2024 07:44:40 +0100 (CET)
Date: Mon, 26 Feb 2024 07:44:40 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Lennart Franzen <lennart@lfdomain.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: adi: requires PHYLIB support
Message-ID: <20240226064440.ismpxvp5qmnskyna@lion.mk-sys.cz>
References: <20240215070050.2389-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dokggcunvhr5bb4x"
Content-Disposition: inline
In-Reply-To: <20240215070050.2389-1-rdunlap@infradead.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-5.20 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,infradead.org:email];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -5.20


--dokggcunvhr5bb4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 11:00:50PM -0800, Randy Dunlap wrote:
> This driver uses functions that are supplied by the Kconfig symbol
> PHYLIB, so select it to ensure that they are built as needed.
>=20
> When CONFIG_ADIN1110=3Dy and CONFIG_PHYLIB=3Dm, there are multiple build
> (linker) errors that are resolved by this Kconfig change:
>=20
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_net_ope=
n':
>    drivers/net/ethernet/adi/adin1110.c:933: undefined reference to `phy_s=
tart'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_probe_n=
etdevs':
>    drivers/net/ethernet/adi/adin1110.c:1603: undefined reference to `get_=
phy_device'
>    ld: drivers/net/ethernet/adi/adin1110.c:1609: undefined reference to `=
phy_connect'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_disconn=
ect_phy':
>    drivers/net/ethernet/adi/adin1110.c:1226: undefined reference to `phy_=
disconnect'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `devm_mdiobus_all=
oc':
>    include/linux/phy.h:455: undefined reference to `devm_mdiobus_alloc_si=
ze'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_registe=
r_mdiobus':
>    drivers/net/ethernet/adi/adin1110.c:529: undefined reference to `__dev=
m_mdiobus_register'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_net_sto=
p':
>    drivers/net/ethernet/adi/adin1110.c:958: undefined reference to `phy_s=
top'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_disconn=
ect_phy':
>    drivers/net/ethernet/adi/adin1110.c:1226: undefined reference to `phy_=
disconnect'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_adjust_=
link':
>    drivers/net/ethernet/adi/adin1110.c:1077: undefined reference to `phy_=
print_status'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_ioctl':
>    drivers/net/ethernet/adi/adin1110.c:790: undefined reference to `phy_d=
o_ioctl'
>    ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf60): undefined ref=
erence to `phy_ethtool_get_link_ksettings'
>    ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf68): undefined ref=
erence to `phy_ethtool_set_link_ksettings'
>=20
> Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402070626.eZsfVHG5-lkp@i=
ntel.com/
> Cc: Lennart Franzen <lennart@lfdomain.com>
> Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/ethernet/adi/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff -- a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kco=
nfig
> --- a/drivers/net/ethernet/adi/Kconfig
> +++ b/drivers/net/ethernet/adi/Kconfig
> @@ -7,6 +7,7 @@ config NET_VENDOR_ADI
>  	bool "Analog Devices devices"
>  	default y
>  	depends on SPI
> +	select PHYLIB
>  	help
>  	  If you have a network (Ethernet) card belonging to this class, say Y.

Shouldn't the "select PHYLIB" be added to ADIN1110 rather than
NET_VENDOR_ADI? Now with v6.8-rc6, PHYLIB and few other options are
forced to "Y" whenever NET_VENDOR_ADI is enabled (even with ADIN1110
disabled).

Michal

--dokggcunvhr5bb4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmXcM1MACgkQ538sG/LR
dpWWyQf+IwV1bbDi03xWEPWF9NbDjKpBv4a2Lg5jNjnCa+k3kW3DNzThJTedzX5F
ROmPLIj1cH4cKnaK++npbAlv8K4rZXlvibJDDrXHzNi67IuoExFy1foTyfx8Kr/1
fImb56B2WQXW4SrlHPXi8dB8CDIqlu+z3ec1eG0DEKYBM1WbVP9LKNA/FjNVi0pX
ktr2s2tv2CgZ/4m3+/cPvxQIhiQYFjdfeiXmWaEcfjxgqZRoyGOqqqrCylHk2mIG
0auC4nBbvEkFZqE9p4iPgFQ4IoMf8bnFtNMOawmx/DoDuj3QbgGEKBdDvDbdlRVn
/z0uBAhXH5yRjGpd9XHPDcV2JZthLQ==
=wmo4
-----END PGP SIGNATURE-----

--dokggcunvhr5bb4x--

