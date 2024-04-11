Return-Path: <linux-kernel+bounces-139880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F5D8A08D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A4228477C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082EC13D89C;
	Thu, 11 Apr 2024 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="BH8mVLxJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="uHO55evr"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52C13CA96;
	Thu, 11 Apr 2024 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818271; cv=none; b=DKQPkfa1gEpjFxK1kpkMvGqb37iHPSICjNyvhAHQHhPExG063gAk4T+x6oD63EB+ebZIa7rrP3eQeqEOMlf4qGkd0XLloO6qif5V/w8doKgEegYJn1grNU1XnF1X3tREcbxN4vcJYlcf2WH1V7wT2foENAEXTbZMTRV+Up+NMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818271; c=relaxed/simple;
	bh=asJDC2tCsCIKUlk1uvdNpI9ztJYtDMb1G5pVM5ATV0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEJFRP/mSqMR2LYTxX8v5Ox8yC/EKx8F+7JHUGnfhaYm0Bh2vhnsPu7e92D21QZcYD5qyryos2DjGxp2Jle5GJt/Q/ocq2PYw8XNtskJfnUcrWAroFD49L7zLloIt2zoiopnqJrPbOldxLh5eicS4VMQ67Fg4XLWQ12d1e0OU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=BH8mVLxJ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=uHO55evr reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1712818266; x=1744354266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Low/TPMD1pUUoPwWdlQu8aIxFappqVJowC749G0kgkI=;
  b=BH8mVLxJvUETgnJ7BdguPxNCfkWVHUO1TeBqVEENcVAo+yUDH+W7keDV
   FGDB66HKnkde7i4D4/WA93LIP3K45Zn6kPDGChDXodJAW0kOl9WcxN2i1
   qehrsI0hMOHbrUwRpFUvCusI50UB33mK5ImT3Y8xcYnLO/X7IKwJe6AQz
   q2rwT1GQeU/S1bD0AEl+YDadER5D8Xcec/XdxxrYEbs7Y8krf+blBnNwX
   PORupnKcx/KvQuhHx0l25Q1wkHUNQWEaD+C+28XkroYxgDzdbBCHwZEoD
   mWDJiVsU7hel5HBDT4cIljqlHpyYCnFk3VCkPv9yWPG9Mh/W82o31GCQ9
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,192,1708383600"; 
   d="scan'208";a="36358588"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Apr 2024 08:49:52 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FECC161507;
	Thu, 11 Apr 2024 08:49:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1712818188;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Low/TPMD1pUUoPwWdlQu8aIxFappqVJowC749G0kgkI=;
	b=uHO55evrzbTutyrpVePZSFM48wYSp1zAa5AgL4Jam0q2mpwECoLv31npjAvfE5q5w90wXW
	Uu4NBJB0OxIr+Iqx6OfJIAbbx8TpaZuYiOEddK8ODQT7PkSUAGhHrje8ibA2dGxyoDB11N
	c3eW+GkVXXQL192tzqlp+SaoEN9s2x21itSGXy+1CLl05ZToEjk7xyqi6w2dvlJNRWcfFl
	BMbY9qFB4rK2pDL/MA9J+5y/BXzohlLTYMSQ4eoD/80210zU2I3Hu1HdvhChBKPmVyEbtm
	1LTI5pYXbAYRReatNAR6DvHImxw4NVComkW16X99qVI0d/FSlrRotlRj6eOWhQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 1/1] mmc: slot-gpio: Use irq_handler_t type
Date: Thu, 11 Apr 2024 08:49:47 +0200
Message-ID: <12416790.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240410195618.1632778-1-andriy.shevchenko@linux.intel.com>
References: <20240410195618.1632778-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Mittwoch, 10. April 2024, 21:56:18 CEST schrieb Andy Shevchenko:
> The irq_handler_t is already defined globally, let's use it
> in slot-gpio code.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me:
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  drivers/mmc/core/slot-gpio.c  | 5 ++---
>  include/linux/mmc/slot-gpio.h | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 39f45c2b6de8..8e4750558101 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -19,7 +19,7 @@
>  struct mmc_gpio {
>  	struct gpio_desc *ro_gpio;
>  	struct gpio_desc *cd_gpio;
> -	irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
> +	irq_handler_t cd_gpio_isr;
>  	char *ro_label;
>  	char *cd_label;
>  	u32 cd_debounce_delay_ms;
> @@ -162,8 +162,7 @@ EXPORT_SYMBOL(mmc_gpio_set_cd_wake);
>  /* Register an alternate interrupt service routine for
>   * the card-detect GPIO.
>   */
> -void mmc_gpio_set_cd_isr(struct mmc_host *host,
> -			 irqreturn_t (*isr)(int irq, void *dev_id))
> +void mmc_gpio_set_cd_isr(struct mmc_host *host, irq_handler_t isr)
>  {
>  	struct mmc_gpio *ctx =3D host->slot.handler_priv;
> =20
> diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
> index 5d3d15e97868..3e4d4836a2bb 100644
> --- a/include/linux/mmc/slot-gpio.h
> +++ b/include/linux/mmc/slot-gpio.h
> @@ -8,8 +8,8 @@
>  #ifndef MMC_SLOT_GPIO_H
>  #define MMC_SLOT_GPIO_H
> =20
> +#include <linux/interrupt.h>
>  #include <linux/types.h>
> -#include <linux/irqreturn.h>
> =20
>  struct mmc_host;
> =20
> @@ -21,8 +21,7 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const c=
har *con_id,
>  			 unsigned int debounce);
>  int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>  			 unsigned int idx, unsigned int debounce);
> -void mmc_gpio_set_cd_isr(struct mmc_host *host,
> -			 irqreturn_t (*isr)(int irq, void *dev_id));
> +void mmc_gpio_set_cd_isr(struct mmc_host *host, irq_handler_t isr);
>  int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on);
>  void mmc_gpiod_request_cd_irq(struct mmc_host *host);
>  bool mmc_can_gpio_cd(struct mmc_host *host);
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



