Return-Path: <linux-kernel+bounces-62927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5858527F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669E3285ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C0FA947;
	Tue, 13 Feb 2024 04:12:26 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD20A923
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797546; cv=none; b=T6iN2VkRVdRp+yhu3JwuLBBjIJQvVURnuSjByyNhh0VRD11JEjvvQKa8Wn6Iooe9rof0HbCiW7gmpozz0OBTCbJW6MN8jLfcw+re34yyeLujn8PO9yqIztaLwrM1+g6FRbz8j6d9hQD9MNEL2Zzagsj+H7X0UNSbmaTgRbOUw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797546; c=relaxed/simple;
	bh=/z0ICIgQbDrxgBw0ZD60HlbOlYvkerlYlz7Z2JBTs6Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e6dSsJs0YJvnx0rxWHJ6qyZ5l1GdTpXXP++bYcsQ6DHPR+8NH43NAeoYNaEEhkB6JLQ+cHOCIuRXaYfUbeWUKIZ3wiLzGxgHfPBhy1oi9RCBRin4c68n5GwNvgbzqiUJb3bEMVeODNpkzzC2/+04x4vspiVGX55MMztUNHBb1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5278BA0166;
	Tue, 13 Feb 2024 04:12:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 673E02000F;
	Tue, 13 Feb 2024 04:12:18 +0000 (UTC)
Message-ID: <5897107ef2ef0e862c92a9c3400d52e9a2d48d93.camel@perches.com>
Subject: Re: [PATCH] Fix MODULE_AUTHORs' missing closing >s
From: Joe Perches <joe@perches.com>
To: Ahelenia =?UTF-8?Q?Ziemia=C5=84ska?=
 <nabijaczleweli@nabijaczleweli.xyz>,  Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Date: Mon, 12 Feb 2024 20:12:16 -0800
In-Reply-To: <bsr2n4luxzymq2oihn5n4o5m2fvt5rqu7xf6i4iw2iymeenfla@tarta.nabijaczleweli.xyz>
References: 
	<bsr2n4luxzymq2oihn5n4o5m2fvt5rqu7xf6i4iw2iymeenfla@tarta.nabijaczleweli.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 673E02000F
X-Stat-Signature: ef7gkhmpftfc9kuyhehy5pftk9wz3rai
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+24wrkq0JKkoEzblPI3xRkH59OaJfwsCE=
X-HE-Tag: 1707797538-291574
X-HE-Meta: U2FsdGVkX1+qfSCi4Vv0LJJfx1dM1soNpF3nEOOSpy4kx1NttClqGs5RaRmKnTB9Rs0JnVpgZF6kvXbDcnzB6tJ3IuuEcyYUxvlBRoKLhNJKbkz8bEtod1425v7tkeo2lSmx9bI81lJyUa6VHQQtR0NWZAplUhc+552iHgPFuXRHdfywE7Bb+TYrQn6fukdPc+jxfofQv0UUApl0TWMJpgDCLkyx06LKO0j0eh/85errszDWolnkvse0gXdwc9b3+UtfWOsuC4dTXSZHpNgR5HsAkST3dU4SJeR93GGtVe08jm0IkM4nKo6DL19lNZuTDym9d4jjtzSUKqSE6rliZ7ftMZ2zgqcmMs08APUVwj2N26irwaXBh/EWIP+rOOTWp5hFaT+FPIKL+bUjkvhPH8kxSVr+P/L6y+8bhsprGXaickz4jTIzzTDkWEcYQAzZ9U/6en/BX79JktwC9rRQlgtaBRZDLqNBbk4hI2Z0IWoMuA8ViY2z2cBqFlYvxk8AuQsA3o8JJwsk9UJTmuKN3QeJMb6eDHFqD253iSQ3wWej81QbQpTlCqH9pguCkTEcCHsoMPR8HHqfEUUk+f1UVrEMSywSrOnOPYzt5nwZaqD9vmrcXvrFSJcv3Ki3a8XavbnoxeI/ESGhu1NzmtZA8FOhwyKQ1onWuGZJCGeuMKgMVq0wljD/DrMwZks7IOgHolUZQmsejrDhCSmYqnwbS6d6GdKVEBB6Jg80bFhqW/lkXrP7Wq9iO/NgfW7m/2qK5lrDlL8i3VAijjllGDq2lLt7Frelb1kdHWsN7tcFD756HpK/P1TwZYmpuLVY98F3WmsYrPKHUmwsWpS+aWqoJN+REmjuAn+8g5T5z0pGQKJqRQrmfCAkDbcCzL3xqqJm+hj9ptcDC44J3Y7n/ljNFcdHIXOH2xl7VBWRFu9ceFmgtY2OBhrAkzy3/CAZtFJNZEVpAK/wtdUplnUqKdaY7fOjXJu
 2kH3bVPcCfrEuLI/s7AOGFoS401mXFi9YYgpbHu2V/EavRPWMEhkg9Il+WQ==

On Tue, 2024-02-13 at 03:52 +0100, Ahelenia Ziemia=C5=84ska wrote:
> When perusing arch/mips/crypto/crc32-mips.c I noticed that Marcin's
> MODULE_AUTHOR string was damaged; there's quite a few of these.
>=20
> Automatically found with
>   git grep 'MODULE_AUTHOR.*<[^>]*[^>],'
>   git grep 'MODULE_AUTHOR.*<[^>]*[^>]")'
> and fixed with
>   vi drivers/media/dvb-frontends/dib8000.c
>   sed -i '/MODULE_AUTHOR.*<[^>]*[^>]")/s/")/>")/' \
>     $(git grep -l 'MODULE_AUTHOR.*<[^>]*[^>]")')

Maybe change these to use angle brackets instead
of parentheses for the email address as well?

$ git grep -P 'MODULE_AUTHOR\s*\(\s*"[^"\(]+\([^"\)]+@[^"\)]+\)'
arch/sparc/kernel/chmc.c:MODULE_AUTHOR("David S. Miller (davem@davemloft.ne=
t)");
arch/sparc/kernel/ds.c:MODULE_AUTHOR("David S. Miller (davem@davemloft.net)=
");
drivers/block/sunvdc.c:MODULE_AUTHOR("David S. Miller (davem@davemloft.net)=
");
drivers/char/hw_random/n2-drv.c:MODULE_AUTHOR("David S. Miller (davem@davem=
loft.net)");
drivers/char/tpm/st33zp24/i2c.c:MODULE_AUTHOR("TPM support (TPMsupport@list=
st.com)");
drivers/char/tpm/st33zp24/spi.c:MODULE_AUTHOR("TPM support (TPMsupport@list=
st.com)");
drivers/char/tpm/st33zp24/st33zp24.c:MODULE_AUTHOR("TPM support (TPMsupport=
@list.st.com)");
drivers/char/tpm/tpm-interface.c:MODULE_AUTHOR("Leendert van Doorn (leender=
t@watson.ibm.com)");
drivers/char/tpm/tpm_atmel.c:MODULE_AUTHOR("Leendert van Doorn (leendert@wa=
tson.ibm.com)");
drivers/char/tpm/tpm_i2c_nuvoton.c:MODULE_AUTHOR("Dan Morav (dan.morav@nuvo=
ton.com)");
drivers/char/tpm/tpm_nsc.c:MODULE_AUTHOR("Leendert van Doorn (leendert@wats=
on.ibm.com)");
drivers/char/tpm/tpm_tis.c:MODULE_AUTHOR("Leendert van Doorn (leendert@wats=
on.ibm.com)");
drivers/char/tpm/tpm_tis_core.c:MODULE_AUTHOR("Leendert van Doorn (leendert=
@watson.ibm.com)");
drivers/char/tpm/tpm_vtpm_proxy.c:MODULE_AUTHOR("Stefan Berger (stefanb@us.=
ibm.com)");
drivers/crypto/n2_core.c:MODULE_AUTHOR("David S. Miller (davem@davemloft.ne=
t)");
drivers/hwmon/dell-smm-hwmon.c:MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.=
org)");
drivers/hwmon/ultra45_env.c:MODULE_AUTHOR("David S. Miller (davem@davemloft=
net)");
drivers/i2c/muxes/i2c-mux-mlxcpld.c:MODULE_AUTHOR("Michael Shych (michaels@=
mellanox.com)");
drivers/leds/leds-sunfire.c:MODULE_AUTHOR("David S. Miller (davem@davemloft=
net)");
drivers/media/common/siano/smscoreapi.c:MODULE_AUTHOR("Siano Mobile Silicon=
, Inc. (uris@siano-ms.com)");
drivers/media/common/siano/smsdvb-main.c:MODULE_AUTHOR("Siano Mobile Silico=
n, Inc. (uris@siano-ms.com)");
drivers/media/dvb-frontends/cx24117.c:MODULE_AUTHOR("Luis Alves (ljalvs@gma=
il.com)");
drivers/media/usb/siano/smsusb.c:MODULE_AUTHOR("Siano Mobile Silicon, INC. =
(uris@siano-ms.com)");
drivers/net/ethernet/broadcom/tg3.c:MODULE_AUTHOR("David S. Miller (davem@r=
edhat.com) and Jeff Garzik (jgarzik@pobox.com)");
drivers/net/ethernet/sun/cassini.c:MODULE_AUTHOR("Adrian Sun (asun@darksunr=
ising.com)");
drivers/net/ethernet/sun/niu.c:MODULE_AUTHOR("David S. Miller (davem@daveml=
oft.net)");
drivers/net/ethernet/sun/sunhme.c:MODULE_AUTHOR("David S. Miller (davem@dav=
emloft.net)");
drivers/net/ethernet/sun/sunvnet.c:MODULE_AUTHOR("David S. Miller (davem@da=
vemloft.net)");
drivers/net/ethernet/sun/sunvnet_common.c:MODULE_AUTHOR("David S. Miller (d=
avem@davemloft.net)");
drivers/net/ppp/pptp.c:MODULE_AUTHOR("D. Kozlov (xeb@mail.ru)");
drivers/platform/x86/compal-laptop.c:MODULE_AUTHOR("Roald Frederickx (roald=
frederickx@gmail.com)");
drivers/platform/x86/intel/oaktrail.c:MODULE_AUTHOR("Yin Kangkai (kangkai.y=
in@intel.com)");
drivers/platform/x86/mlx-platform.c:MODULE_AUTHOR("Vadim Pasternak (vadimp@=
mellanox.com)");
drivers/sbus/char/openprom.c:MODULE_AUTHOR("Thomas K. Dyas (tdyas@noc.rutge=
rs.edu) and Eddie C. Dost  (ecd@skynet.be)");
drivers/scsi/esp_scsi.c:MODULE_AUTHOR("David S. Miller (davem@davemloft.net=
)");
drivers/scsi/jazz_esp.c:MODULE_AUTHOR("Thomas Bogendoerfer (tsbogend@alpha.=
franken.de)");
drivers/scsi/mesh.c:MODULE_AUTHOR("Paul Mackerras (paulus@samba.org)");
drivers/scsi/qlogicpti.c:MODULE_AUTHOR("David S. Miller (davem@davemloft.ne=
t)");
drivers/scsi/sun3x_esp.c:MODULE_AUTHOR("Thomas Bogendoerfer (tsbogend@alpha=
franken.de)");
drivers/scsi/sun_esp.c:MODULE_AUTHOR("David S. Miller (davem@davemloft.net)=
");
drivers/video/fbdev/hgafb.c:MODULE_AUTHOR("Ferenc Bakonyi (fero@drama.obuda=
kando.hu)");
net/ipv4/gre_demux.c:MODULE_AUTHOR("D. Kozlov (xeb@mail.ru)");
net/ipv6/ip6_gre.c:MODULE_AUTHOR("D. Kozlov (xeb@mail.ru)");
net/mpls/mpls_gso.c:MODULE_AUTHOR("Simon Horman (horms@verge.net.au)");



