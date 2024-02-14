Return-Path: <linux-kernel+bounces-64910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E8B85448F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA451F2A91A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F070F101C1;
	Wed, 14 Feb 2024 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="EtEA/X/K"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457B8473;
	Wed, 14 Feb 2024 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901454; cv=none; b=Vx6m8AMU92KSp/GwH3Ch1Bw8GGs7YO937vqYah/sHTKITxLnn+T/WjG6/YgzaVsvCsU9fQ8pE/0vnsQDlFAsOLg2e4NNIhVc9/OH4IE7nqQIeIb++ZAfCvKKfUM3hdpwaLPwip12STEPAPIC7zIud3m/hCs/Eukuq/ck6nY02RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901454; c=relaxed/simple;
	bh=vuhdcyX9bdUXLdOFBo7MVnrhvcQRIzTGTAMuBGPXqzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2EgUMaH6y5x7YGitj+6p+0R1yNKu2DksbWZQGATCjNBvQm1+WnCB9IkaB+gWxChmdPTNtfoS2C4HLZYnmfE7Go0lYf04LLd5CR6kbQXwMcFQ0XHLy/Rr1xAv1FrEiWvEIOqU99Qu8JQqlkWI5qHFhfpg1Yl0CJ5tcPd5Y0QEuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=EtEA/X/K; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 93C0960434;
	Wed, 14 Feb 2024 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707901451;
	bh=vuhdcyX9bdUXLdOFBo7MVnrhvcQRIzTGTAMuBGPXqzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtEA/X/KaGOLt0Dcxqqk6BkYl7IAPJDT+yjncICRRWCMauQ5Vy6n3uxvw1TRyyNqp
	 FVChJ5DY6p/gbhfImT/ARj2n81ay/15F/VOyKugtqlOLYjVM505iPpngN7Mawvi2Ij
	 xw0SCEebj7xj3oXYKJcZCHLZvtT+4uJfJGxTIH7VQ2UIA796eb7y1Nic/18LbNQnQV
	 oKoze+/XZWn1LIEuL5RJIcoJpnzaftwif21JobW8M0KxvODhq2zkUD/Y/K5glNlVRt
	 cV+rPkSfazfB8djLJ4GUKp0uscWJ4Y8BzZ1Z4b1+OuKaUxLdmM7WHUYx6FJB+mYi3d
	 kA6cbtkDKBaiQ==
Date: Wed, 14 Feb 2024 11:03:30 +0200
From: Tony Lindgren <tony@atomide.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 4/6] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <20240214090330.GR52537@atomide.com>
References: <20240213084545.40617-5-tony@atomide.com>
 <aa4b1b2e-50b8-419c-bf0d-526711f1aaea@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa4b1b2e-50b8-419c-bf0d-526711f1aaea@moroto.mountain>

* Dan Carpenter <dan.carpenter@linaro.org> [240214 09:00]:
> a2020a9ccacd63 Tony Lindgren 2024-02-13  252  int serial_base_add_preferred_console(struct uart_driver *drv,
> a2020a9ccacd63 Tony Lindgren 2024-02-13  253  				      struct uart_port *port)
> a2020a9ccacd63 Tony Lindgren 2024-02-13  254  {
> a2020a9ccacd63 Tony Lindgren 2024-02-13 @255  	const char *port_match __free(kfree);

Thanks also noted by Andy.

> Someone should add this to checkpatch.  These always need to be
> initialized to NULL.

Yes good idea. These are easy to miss especially if the code path changes
for whatever reason.

Regards,

Tony

