Return-Path: <linux-kernel+bounces-149993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323F48A98DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A96C1B22C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C319215E80D;
	Thu, 18 Apr 2024 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkpmaVqG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821FC56464;
	Thu, 18 Apr 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440623; cv=none; b=bUhs+hZ8+kjnt+WbUQsTkkjxvSjDtkq1NTOTBNERqOo8qqPRSwpBoENY2Qt0nuLdb+t6ebb8C817bxNlJbY2VEhdjYUSKIjYvzy65zGlGlMruAoi+hxZ/gnJfbkTI001QooCNQFB6m7gO/1RirCt1WOafiShSQ6NY0wCcfpx5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440623; c=relaxed/simple;
	bh=T4fBkydOARcqpAZpedsRkcZRcxSxeRnonLEt65AZCDk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nJ8bcIkyHTbEsnl/a5o3VC6uxt4taHQvdIzX6+HzSGuynJdTj9tVJm3+WyXbPbTokLGMPvl/CCzWfleAzvNbiXT2S0B89141Tr5/XVvr4vozopvYuK3zPNjAyZ9TDTxa3f2cCG6sacJ8ArCYgg2tAJ3QXgXLg8N1dxRyQcv2tWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkpmaVqG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440622; x=1744976622;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T4fBkydOARcqpAZpedsRkcZRcxSxeRnonLEt65AZCDk=;
  b=kkpmaVqGiSLIQaD/zqs1kz0g9Fj5jvmG0ckn200x2Ke35ifEmZ8wxPp/
   aAi0IQLNjue2FXNHbP1JecZsiSeocif0SiH9MZCM83X2PzICEad7p7CTI
   C98x0stmxHmlwXHZIhVYM6767haMKF12UIcGCS8DKkc3JX3KIt0rUYalP
   s0P5LeSTJDEutkw3/PSBhlVv4xRAW61DPB9NSctwW5Q/SmHDocByEJDso
   b+4mvm8Fw0vgnJxDfU9ozV1fG206b6kQk63zlz/Kzw+ZNxrdITew773gl
   4Ia39JCubV/wHgmq30e0+ciaxvDBjvfUgFvO1gOjeZBrDLQQppL0UlH9I
   w==;
X-CSE-ConnectionGUID: 0hyStRiVSmy0fjFg6cNG+g==
X-CSE-MsgGUID: jmMSuNfDQJyBHE20Ht2Ylw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9149569"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="9149569"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:43:41 -0700
X-CSE-ConnectionGUID: q8RaWKgCS2qalrCMofydew==
X-CSE-MsgGUID: M79X7JZnSQC5AROw9vYsDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27387263"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.36])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:43:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Apr 2024 14:43:32 +0300 (EEST)
To: Parker Newman <parker@finest.io>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 5/7] serial: exar: add CTI cards to
 exar_get_nr_ports
In-Reply-To: <0c64bdf852f39aec966b38696695d951e485d7e6.1713382717.git.pnewman@connecttech.com>
Message-ID: <60790bd3-d35a-026d-ef38-ae3b12160fbe@linux.intel.com>
References: <cover.1713382717.git.pnewman@connecttech.com> <0c64bdf852f39aec966b38696695d951e485d7e6.1713382717.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 17 Apr 2024, Parker Newman wrote:

> From: Parker Newman <pnewman@connecttech.com>
> 
> Add code for getting number of ports of CTI cards to
> exar_get_nr_ports().
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
> Changes in v3:
> - moved to separate patch
> - added spaces to single line comments
> 
>  drivers/tty/serial/8250/8250_exar.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index e68029a59122..197f45e306ff 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -711,12 +711,28 @@ static unsigned int exar_get_nr_ports(struct exar8250_board *board,
>  {
>  	unsigned int nr_ports = 0;
> 
> -	if (pcidev->vendor == PCI_VENDOR_ID_ACCESSIO)
> +	if (pcidev->vendor == PCI_VENDOR_ID_ACCESSIO) {

You can add the braces while you moved the code around so you don't need 
to play with them again here and this patch can be more to the point.

>  		nr_ports = BIT(((pcidev->device & 0x38) >> 3) - 1);
> -	else if (board->num_ports)
> +	} else if (board->num_ports > 0) {
> +		// Check if board struct overrides number of ports
>  		nr_ports = board->num_ports;

The comment just tells what the code does, IMO that comment doesn't add 
any value.

> -	else
> +	} else if (pcidev->vendor == PCI_VENDOR_ID_EXAR) {
> +		// Exar encodes # ports in last nibble of PCI Device ID ex. 0358

This comment you can also add while you moved the code around (or make 
another patch out of it after moving).

-- 
 i.

>  		nr_ports = pcidev->device & 0x0f;
> +	} else  if (pcidev->vendor == PCI_VENDOR_ID_CONNECT_TECH) {
> +		// Handle CTI FPGA cards
> +		switch (pcidev->device) {
> +		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
> +		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
> +			nr_ports = 12;
> +			break;
> +		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
> +			nr_ports = 16;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> 
>  	return nr_ports;
>  }
> --
> 2.43.2
> 
> 

