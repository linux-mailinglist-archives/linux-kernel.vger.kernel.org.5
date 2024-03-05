Return-Path: <linux-kernel+bounces-91815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A6B8716FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B678F283FEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6005E7F7E9;
	Tue,  5 Mar 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pn1igtKd"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A207F485;
	Tue,  5 Mar 2024 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623994; cv=none; b=g074QW7QMa82Vms1tTCn9QQfCow84PmP1oNZk4lD64enZYso18GZ5qWNiH6UQ+vdUo+82k36th3vhkSNBZiYB9FyypxjxxCU+XASX3gcxWsgMd5aWOFbD+LXYLadiiVxze3vJytJe+o7r/W2ZzIL+aEwcJUNixPAkRV14byyPQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623994; c=relaxed/simple;
	bh=gkTKJFb/QzUGUie519FgaxdmUcm/+GnzkYdSIfXAYRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiBODrTifDBFcnGUjDCmxnMpGWufoDsWQyhRXYJTe7Bcp8Y9T+h34qglMC+kCMPWeRmWSdUYvblXfEpsYbv9uwQvVefvJNyzRAoJQgrztYK9NATtzU0ot28fYl6h6I0JHNPXb+YnJtJgKoWr0ZQJExKO8dKtvQGy8N5Ntv2YRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pn1igtKd; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97256C0005;
	Tue,  5 Mar 2024 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709623989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6kBoq5tRd5YscgKf6UUgk0mO/9Dtx1WM7zMQWwpCmM=;
	b=Pn1igtKd/gElSF/6giLGZoAQD+L0Yhooq7iwPam9UaxsSqkpOjPun8wy7TldRyYe+Vycpi
	6FAa4bzuVCL6R85J4YRl8zyGmrq2YzP65AZw2iRbmn3wAcQNB4Zc8AHuhwYL4kfikIIF9v
	34A/itcSgnG9mivO5048TIMGmIbLVHA/qYNpfZzjiYmDfgQeIFelqlmrNAeghylB24Ooqg
	QWz/TQcPafQ01CkpqVFgyEwi+zKYzC8VwBUy1rXamcxaQ+vvPScKeGUCD707HR/xhnNr3N
	QLQsiDGSgOjMePPwJyh4iMPt4UXzG+IRNgk3hU+VIoXRdv+gz+omjYw8O5+wzQ==
Date: Tue, 5 Mar 2024 08:33:06 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>,
 Alexander Aring <alex.aring@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] ieee802154: mcr20a: Remove unused
 of_gpio.h
Message-ID: <20240305083306.3eb8138d@xps-13>
In-Reply-To: <20240304175320.1199496-1-andriy.shevchenko@linux.intel.com>
References: <20240304175320.1199496-1-andriy.shevchenko@linux.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Mon,  4 Mar 2024 19:53:20
+0200:

> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

