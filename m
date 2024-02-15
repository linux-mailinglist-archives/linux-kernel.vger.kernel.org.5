Return-Path: <linux-kernel+bounces-66393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD39855C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEC528A89A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E2912E6D;
	Thu, 15 Feb 2024 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ8UdmkO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DE12B87;
	Thu, 15 Feb 2024 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984637; cv=none; b=UxOsBvmx6TVgEQfPembeQebETMz4D3gBvxv0H3MnSOvjabEk+vC1hEia/b8oLNwIZVGC0RvIGRFCb+PtKz+NuKb7sO+10kXnhYaSo2nKs/PP/kIDvjqAeXiU6mfEAlXmAzqS3c9Ei54fRf9XHa2/qQuxDXyskm0RoJAtSpAHWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984637; c=relaxed/simple;
	bh=xFilebdpUOTKDaW3difRJkzOKNTenYbbMTwQ+jLo0Tg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pVA1bFTVUCsjQUtKQCDWJc/UQPN2X1wM15+HwrAmHMnayNpXylNio8iq5iLzphdelOPVeiMWGpb81Bd3bOYU0iufo6TmemJzjFp/cnxmbJ6X2d9Pp0HRuIRTUEuuKLoHSdCfBbLohsMkvcGtosw1fyg5KunVhqOGQFucX9W402E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ8UdmkO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b28aadb28so253101f8f.3;
        Thu, 15 Feb 2024 00:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707984634; x=1708589434; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EZhexOGrvx6hSKAHRm6JY4eNhDRld529voKN7twHhNE=;
        b=QZ8UdmkOmhs2VOEATIFTNn28Gb5MwqiyAA2khKZJzWCjnMdm+9fsrU7KKk/5+J8KR6
         hsLisqcdK8Dhq6qHOpRlFqzD6H77hGg6b8fPACxp0wnmEe1JnXcfgOJ4y2yZ+1Ldi6lK
         aN+VkY7MncBle4D/YUiI0nKgjrYfy3WPDtg+LvSTEKRKLAZG2jKmUoG1HWrOYAb8eoSZ
         G/RNxFuoD1CLdBTk4iLlSldqgBv9TO+170HmUEB/DsnvWlr1QFb6FONCgOAfVW/TKf4n
         kEbNlE+kzze12sBJcFJhLSZfFoul2l00PAx6Gi9/6Yq0kqOngXt7kIT4ORWDEqRyZtb/
         y7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707984634; x=1708589434;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZhexOGrvx6hSKAHRm6JY4eNhDRld529voKN7twHhNE=;
        b=e9VjzZChbQpsL6Ci75Gy5QOnPzpJ8yVrOkjNyHwT6hwd4mmIajdbrNpY0QsMwmoKxR
         FWhe9hZ5ksFpEZw+KxfSbSPY4MkaU3R6zTA1vpruTtw7nXtXEUiWdc6L+4kmGWEbClAv
         hYY49emOSITzKS+9BX+xWaz9lWAaymKi7V60D6jua37v7B2C5pEOiyxsMRFsCH2P+Q2e
         l630RQk3uZtYPqcm3pudgG9dBsWwm+Z1KIhc7R5Nkqt4lwHnZ2mA5fid44qw3J8Vd8kq
         7hzRfPSTjLLBXl01lMng7Rmmitogbf1VK28rlvk54Ud2ahyC7drx4rd5LJXDO15RRqoU
         A2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVUF2L7d3ZoCvgjT4mKU1QyDeuDX6UcAIKRwqEi5wEc06rysPk0bZvPlxUqaVksJY9aGgmnJQXxwxgO7aNG2JToeD6kt1EvvvuMdgjtjWNTmKmQM8ZyAWXkG5x3HzqG/XXugKWI
X-Gm-Message-State: AOJu0YxN19IVHvOMV6ad5oMalJJ0IGumldmwhuhHaKSgc3ukSlLZalUV
	hcUdCkRN83EA/LM53/G4KCa6pQBkFTeKpd0T6xZAbzXV6d6iCNwu
X-Google-Smtp-Source: AGHT+IEWdkjwJ3jIpNxoL6I2N2x8CaR/i9ycebzVY7CCKE7d+csrAx6paQFfciUbLER2vE0F2Hba7w==
X-Received: by 2002:adf:fdc8:0:b0:33c:e34f:c2c0 with SMTP id i8-20020adffdc8000000b0033ce34fc2c0mr653491wrs.34.1707984633844;
        Thu, 15 Feb 2024 00:10:33 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id bw15-20020a0560001f8f00b0033b75d0993esm976949wrb.74.2024.02.15.00.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 00:10:33 -0800 (PST)
Message-ID: <be512dfd907d3d0a30aac8d055605d519d7c7613.camel@gmail.com>
Subject: Re: [PATCH] net: ethernet: adi: requires PHYLIB support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, Lennart Franzen
 <lennart@lfdomain.com>,  Alexandru Tachici <alexandru.tachici@analog.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Date: Thu, 15 Feb 2024 09:10:33 +0100
In-Reply-To: <20240215070050.2389-1-rdunlap@infradead.org>
References: <20240215070050.2389-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-14 at 23:00 -0800, Randy Dunlap wrote:
> This driver uses functions that are supplied by the Kconfig symbol
> PHYLIB, so select it to ensure that they are built as needed.
>=20
> When CONFIG_ADIN1110=3Dy and CONFIG_PHYLIB=3Dm, there are multiple build
> (linker) errors that are resolved by this Kconfig change:
>=20
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.o: in function `adin11=
10_net_open':
> =C2=A0=C2=A0 drivers/net/ethernet/adi/adin1110.c:933: undefined reference=
 to `phy_start'
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.o: in function `adin11=
10_probe_netdevs':
> =C2=A0=C2=A0 drivers/net/ethernet/adi/adin1110.c:1603: undefined referenc=
e to
> `get_phy_device'
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.c:1609: undefined refe=
rence to
> `phy_connect'
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.o: in function `adin11=
10_disconnect_phy':
> =C2=A0=C2=A0 drivers/net/ethernet/adi/adin1110.c:1226: undefined referenc=
e to
> `phy_disconnect'
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.o: in function `devm_m=
diobus_alloc':
> =C2=A0=C2=A0 include/linux/phy.h:455: undefined reference to `devm_mdiobu=
s_alloc_size'
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.o: in function
> `adin1110_register_mdiobus':
> =C2=A0=C2=A0 drivers/net/ethernet/adi/adin1110.c:529: undefined reference=
 to
> `__devm_mdiobus_register'
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.o: in function `adin11=
10_net_stop':
> =C2=A0=C2=A0 drivers/net/ethernet/adi/adin1110.c:958: undefined reference=
 to `phy_stop'
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.o: in function `adin11=
10_disconnect_phy':
> =C2=A0=C2=A0 drivers/net/ethernet/adi/adin1110.c:1226: undefined referenc=
e to
> `phy_disconnect'
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.o: in function `adin11=
10_adjust_link':
> =C2=A0=C2=A0 drivers/net/ethernet/adi/adin1110.c:1077: undefined referenc=
e to
> `phy_print_status'
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.o: in function `adin11=
10_ioctl':
> =C2=A0=C2=A0 drivers/net/ethernet/adi/adin1110.c:790: undefined reference=
 to `phy_do_ioctl'
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf60): und=
efined reference to
> `phy_ethtool_get_link_ksettings'
> =C2=A0=C2=A0 ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf68): und=
efined reference to
> `phy_ethtool_set_link_ksettings'
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

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


> =C2=A0drivers/net/ethernet/adi/Kconfig |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff -- a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kco=
nfig
> --- a/drivers/net/ethernet/adi/Kconfig
> +++ b/drivers/net/ethernet/adi/Kconfig
> @@ -7,6 +7,7 @@ config NET_VENDOR_ADI
> =C2=A0	bool "Analog Devices devices"
> =C2=A0	default y
> =C2=A0	depends on SPI
> +	select PHYLIB
> =C2=A0	help
> =C2=A0	=C2=A0 If you have a network (Ethernet) card belonging to this cla=
ss, say Y.
> =C2=A0


