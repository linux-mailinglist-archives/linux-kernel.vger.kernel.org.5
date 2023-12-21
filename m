Return-Path: <linux-kernel+bounces-8877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D097A81BD93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E124285918
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFAA62813;
	Thu, 21 Dec 2023 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="Ih4TXrhJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA2634EE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1703180789; bh=+ZCY1Qb2wMJBWyRbH4gw2JjGYZOSVk0BBR18YWiBWHE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Ih4TXrhJGO63OjfUer/xhFtgnwW+rp5QcUo4dOkslFQzIKa4yMDdFCGsrrAErmcvX
	 EykpJ+U+muxvWeW9c7Zo3RVkRtmvROms7anDynYIAMs4N1L+5NPONSUEArD4mEu6Pp
	 0tMXr7G/sQnzCQF3Yb1HZTUmPo1zh4t8VtokTZhA=
Date: Thu, 21 Dec 2023 18:46:26 +0100 (GMT+01:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <28a235ff-bb1c-4d4f-a2a8-db29fb16af45@t-8ch.de>
In-Reply-To: <20231221140921.2760432-1-andriy.shevchenko@linux.intel.com>
References: <20231221140921.2760432-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] pvpanic: Kill duplicate PCI_VENDOR_ID_REDHAT
 definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <28a235ff-bb1c-4d4f-a2a8-db29fb16af45@t-8ch.de>

Dec 21, 2023 15:15:32 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> PCI_VENDOR_ID_REDHAT is already defined in pci_ids.h. Kill the dup.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

> ---
> drivers/misc/pvpanic/pvpanic-pci.c | 1 -
> 1 file changed, 1 deletion(-)
>
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pv=
panic-pci.c
> index 689af4c28c2a..c5fb6298cb8d 100644
> --- a/drivers/misc/pvpanic/pvpanic-pci.c
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -15,7 +15,6 @@
>
> #include "pvpanic.h"
>
> -#define PCI_VENDOR_ID_REDHAT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1b36
> #define PCI_DEVICE_ID_REDHAT_PVPANIC=C2=A0=C2=A0=C2=A0=C2=A0 0x0011
>
> MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
> --
> 2.43.0.rc1.1.gbec44491f096


