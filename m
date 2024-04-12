Return-Path: <linux-kernel+bounces-142470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E530D8A2BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA5BB2247A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4420F535BF;
	Fri, 12 Apr 2024 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddSOzzfS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88084E1D5;
	Fri, 12 Apr 2024 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916548; cv=none; b=QfDuYaFnjXWhbR2KKyM/6YnXDawcmoTFA/msATmXBt7MVvxijPOdUAbpNKzofaHENo1IfK9k9j0I9GqsygICAA27aOKFvxH02vm3XZIG7RGDPTrxrigCq4XDK5BJ9qk5x/j2zkQWakSbwCOGt65Pl8u4GUFttNS4FHLEBCNY7f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916548; c=relaxed/simple;
	bh=YezIN9339n4/OSCt3qVNZcNDEPF8p7UvYMLxXyXBEhk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NVWX6PF5cvlo0g/P7DkY8iIduJT4sFOjootrbk9YOD9SxgxCQ90MOYR9xPfCA3mbrN5xiDdZFF8F/wvA43ckV5pVZD9eezadIOJx/hEuvcTNVu5fepJeBIG+eYT+SlajJwEUFphnF3fcK5p8UBQhHaATncp3ova2qOlPQOb01yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddSOzzfS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712916546; x=1744452546;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YezIN9339n4/OSCt3qVNZcNDEPF8p7UvYMLxXyXBEhk=;
  b=ddSOzzfSdUuL1/HBBePoJSslX2SkKg1QDQpcn82P6QqpXUbymrwolqN1
   6J3cnrCes+z7BTMGWM/KIuCS4CEvoz41BnDnLzCCgDBcpURTQjpT04f+k
   MuAUB+XhUvTbCP6KZ2mt1EG++xYtdhf5+iNj4h/ycVuzErvBSYortH778
   xNOB79ZX4IwkRCO6Du7/j5iS48yCS/6L5u4Y2YJnUAWaSDFEJfvuemwco
   RZ3YcNlzX6PKW9Dn2PZyO2D7egqpLus7tUlMojQddKOFkDsqi/APMWGJ6
   WC31uxc5+2GjqFS6yqgVD4DcP8sJ1Ne68zsJScHBUJQqSEhyrcaLMDqNj
   Q==;
X-CSE-ConnectionGUID: t21Vm7RhQdGnzNQ82tc6QA==
X-CSE-MsgGUID: t1sp6nO8TKmxoR9n3XImIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8226160"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8226160"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:09:05 -0700
X-CSE-ConnectionGUID: Ihz90/6NR2+BfAxq/saU3w==
X-CSE-MsgGUID: MX/ZbFa9Q5KUAHZw3wHilg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="58619198"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:09:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Apr 2024 13:08:58 +0300 (EEST)
To: parker@finest.io
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 4/7] serial: exar: add optional board_setup function
In-Reply-To: <69677365f4c753cbe6b5c028f530db49e6712ab3.1712863999.git.pnewman@connecttech.com>
Message-ID: <385ccf17-199e-13cb-e003-8b583252cab8@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com> <69677365f4c753cbe6b5c028f530db49e6712ab3.1712863999.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Apr 2024, parker@finest.io wrote:

> From: Parker Newman <pnewman@connecttech.com>
> 
> Adds an optional "board_setup" function pointer to struct
> exar8250_board. This gets called once during probe prior to setting up
> the ports.
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 9915a99cb7c6..b30f3855652a 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -143,7 +143,7 @@
>   *
>   * MPIO		Port	Function
>   * ----		----	--------
> - * 0		2 	Mode bit 0
> + * 0		2	Mode bit 0

Unrelated change.

>   * 1		2	Mode bit 1
>   * 2		2	Terminate bus
>   * 3		-	<reserved>
> @@ -179,22 +179,24 @@ struct exar8250_platform {
>  	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
>  			    struct serial_rs485 *rs485);
>  	const struct serial_rs485 *rs485_supported;
> -	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
> -	void (*unregister_gpio)(struct uart_8250_port *);
> +	int (*register_gpio)(struct pci_dev *pcidev, struct uart_8250_port *port);
> +	void (*unregister_gpio)(struct uart_8250_port *port);
>  };
> 
>  /**
>   * struct exar8250_board - board information
>   * @num_ports: number of serial ports
>   * @reg_shift: describes UART register mapping in PCI memory
> - * @setup: quirk run at ->probe() stage
> + * @board_setup: quirk run once at ->probe() stage before setting up ports
> + * @setup: quirk run at ->probe() stage for each port
>   * @exit: quirk run at ->remove() stage
>   */
>  struct exar8250_board {
>  	unsigned int num_ports;
>  	unsigned int reg_shift;
> -	int	(*setup)(struct exar8250 *, struct pci_dev *,
> -			 struct uart_8250_port *, int);
> +	int     (*board_setup)(struct exar8250 *priv);
> +	int	(*setup)(struct exar8250 *priv, struct pci_dev *pcidev,
> +			 struct uart_8250_port *port, int idx);
>  	void	(*exit)(struct pci_dev *pcidev);
>  };
> 
> @@ -966,6 +968,15 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
>  	if (rc)
>  		return rc;
> 
> +	if (board->board_setup) {
> +		rc = board->board_setup(priv);

Could this be called board_init() as having both ->board_setup() and 
->setup() is bit confusing.

> +		if (rc) {
> +			pci_err(pcidev,
> +				"failed to setup serial board: %d\n", rc);

pci_err() belongs to pci subsystem. Please use dev_err() or return 
dev_err_probe().

> +			return rc;
> +		}
> +	}
> +
>  	for (i = 0; i < nr_ports && i < maxnr; i++) {
>  		rc = board->setup(priv, pcidev, &uart, i);
>  		if (rc) {


-- 
 i.


