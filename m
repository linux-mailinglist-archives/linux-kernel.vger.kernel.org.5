Return-Path: <linux-kernel+bounces-149971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC2F8A9899
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8E3284A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA92315E7EC;
	Thu, 18 Apr 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWJF9+G6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373856464;
	Thu, 18 Apr 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439980; cv=none; b=fxYMvdzlMe+R1t1EAqMQaASQz8zgUTv0xqlrqliIctNvBFEREegKgB6dE4AkQvmDyYdxr2Oe3kIy5xueCGo6+mmhCMpy3RIfSt9gN553HfEGHhocCjVBDBwTTV1OXGftI08DiL3B8/v71+mcAS0Jynfjs7GDYEPc/8MiSwR3gKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439980; c=relaxed/simple;
	bh=o+JV8MIGjKEeR3qwjniL+kE5kdz0uJ4owIBth1VetVs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kTyingfmOdXheRPs8wgLedcMMbDTLmDGQHf+KcKuLKqXbejKIM+Fx/9zMHbgzKXv/pPA7uiivmC1tObG0ZxEE7dvCbzcuZc7ZMTfA4yR4qWfSoBVVDf3x/Payl1sg+X5x+bZZFTYyX6IcFa1H+O54L8KBLdkc7Nmxcq0xAV7PFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWJF9+G6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713439978; x=1744975978;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o+JV8MIGjKEeR3qwjniL+kE5kdz0uJ4owIBth1VetVs=;
  b=jWJF9+G6rigZePUHBbGhwv4zBYmTTYJZmrTedn9MfJOegAO75LJgS8Eg
   mVSKvtUYG8odtT4k+rA0oe3XidVAFy7W/HMVPEyWK4/cpVXW6JMfLKmx5
   RZ33dC/cxJ05P3f76kGs2Ll6Fn73c7iEWm/nV0Lutj1ahB8adMIGzVQaK
   JtIw4HOOYdN5OHGPdKBZel0Kx/twP/Q3SL3vt2VXyte1i1S//BFfradZO
   i4V8Ij4hcn0nj/Qjvke6vz7KPKJ+x2AkSSnSriItPyB2W99T+SC9vDdgM
   Zg1O/YbfTSWZU6MlTSTnlvTzXMNyBM1dr1VgFPSGiEl6O8thduSDZpG6/
   g==;
X-CSE-ConnectionGUID: +p17lV3/T3WesgTpFTaxRA==
X-CSE-MsgGUID: T6MaTthQRoSR6DPRoXQ4yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8840329"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8840329"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:32:57 -0700
X-CSE-ConnectionGUID: RoLqWj3RTOq8tkJZEN3BIA==
X-CSE-MsgGUID: 3IQBj/aNRcmuq+D8X8DaUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23034623"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.36])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:32:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Apr 2024 14:32:51 +0300 (EEST)
To: Parker Newman <parker@finest.io>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 3/7] serial: exar: add optional board_init function
In-Reply-To: <0e72a3154114c733283ff273bc1e31456ee101f4.1713382717.git.pnewman@connecttech.com>
Message-ID: <60feac79-2e71-4a66-729e-80d12cb660f2@linux.intel.com>
References: <cover.1713382717.git.pnewman@connecttech.com> <0e72a3154114c733283ff273bc1e31456ee101f4.1713382717.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1710506478-1713439971=:986"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1710506478-1713439971=:986
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 17 Apr 2024, Parker Newman wrote:

> From: Parker Newman <pnewman@connecttech.com>
>=20
> Add an optional "board_init()" function pointer to struct exar8250_board
> which is called once during probe prior to setting up the ports. It will
> be used in subsequent patches of this series.
>=20
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
> Changes in v3:
>  - Renamed board_setup to board_init.
>  - Changed pci_err to dev_err_probe
>  - Added note above about checkpatch fixes
>=20
> Changes in v4:
>  - Removed checkpatch fixes, they will be in their own patch at the end
>  - Added pcidev to board_init() args to avoid needing to add to priv
>=20
>  drivers/tty/serial/8250/8250_exar.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/825=
0/8250_exar.c
> index 72385c7d2eda..f14f73d250bb 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -177,12 +177,14 @@ struct exar8250_platform {
>   * struct exar8250_board - board information
>   * @num_ports: number of serial ports
>   * @reg_shift: describes UART register mapping in PCI memory
> - * @setup: quirk run at ->probe() stage
> + * @board_init: quirk run once at ->probe() stage before setting up port=
s
> + * @setup: quirk run at ->probe() stage for each port
>   * @exit: quirk run at ->remove() stage
>   */
>  struct exar8250_board {
>  =09unsigned int num_ports;
>  =09unsigned int reg_shift;
> +=09int     (*board_init)(struct exar8250 *priv, struct pci_dev *pcidev);
>  =09int=09(*setup)(struct exar8250 *, struct pci_dev *,
>  =09=09=09 struct uart_8250_port *, int);
>  =09void=09(*exit)(struct pci_dev *pcidev);
> @@ -773,6 +775,15 @@ exar_pci_probe(struct pci_dev *pcidev, const struct =
pci_device_id *ent)
>  =09if (rc)
>  =09=09return rc;
>=20
> +=09if (board->board_init) {
> +=09=09rc =3D board->board_init(priv, pcidev);
> +=09=09if (rc) {
> +=09=09=09dev_err_probe(&pcidev->dev, rc,
> +=09=09=09=09=09"failed to init serial board\n");
> +=09=09=09return rc;
> +=09=09}
> +=09}
> +

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1710506478-1713439971=:986--

