Return-Path: <linux-kernel+bounces-46746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54840844385
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1218D289C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2012A14E;
	Wed, 31 Jan 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="c4bh8QXx"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967E12A148;
	Wed, 31 Jan 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716736; cv=none; b=UAdCViHb0tSEWhGfOtAznGK63V9s0ZzWbonYRs034/2bP0B9jYZVLyNxTfye8X3vbzu8O3F7zp3dEUqcv2wI8bbFcOh+sx7NPpmo2QQR5GYYZV2mTrsE0uZtbM8mGcYmg3dHsMHqq3n7qcgFVrF2xZcwwk0m03Gm0s2fKh1j+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716736; c=relaxed/simple;
	bh=Y/Q3xsF6bD0RrFVjl35hYlQmnoNUueb0qo3uoYGenB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AzZbN5vAisppOYi9dZZLEuNkOEfwor/MDH6/Mc2Mduid+4diE4A0j4VR8oNfv85fPSCqD7pmvC1G9mvA91clrIy6oW+boGDOoqoLn85OCH8uAP/cSEQj4v7mJ19GtIWzNDmUInm6xXRIpXywdTo+92O9dtrFuMOxjhh8g/Q7lO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=c4bh8QXx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 48D7F47AA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706716731; bh=PLm8WUNIAKoIK/mO/devLpWdKufj7FVlfUUU03pGBg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c4bh8QXx9iugcyu/pTN7YIw9hBi+qKv5fFBnxl9IYk/syHRzgig29LuO2sxCRGcp+
	 nJgEL1DNJ7NL9P3isxVgP4XnJSk6l9XHtcbISiFgpOcK07on2ssCpbLAhW7Mb7Wb/J
	 UrTmxw8cKwdc74GZiF+7iC0B+21uXsk7HrYrd4w3taDp65SikB7OyO1Z2N6JrA1oZy
	 RJXWY97SOnx2ClTF2yJuEV6AK04NBHVndlZ0yde7S+X0LP7NdK8GDeGHRVddOR3nM/
	 UtJ42x0Xoc9xOJh95NUr+91SVhaSeX51S79iLifUoLPiMRwv7e8Tj++Z3KxhYBKPvH
	 b22L9ZOXfDZZw==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 48D7F47AA7;
	Wed, 31 Jan 2024 15:58:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Corona, Ernesto" <ernesto.corona@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>
Cc: "Corona, Ernesto" <ernesto.corona@intel.com>,
 "'oleksandrs@mellanox.com'" <oleksandrs@mellanox.com>, "Castro, Omar
 Eduardo" <omar.eduardo.castro@intel.com>,
 "'omar.eduardo.castro@linux.intel.com'"
 <omar.eduardo.castro@linux.intel.com>, "'arnd@arndb.de'" <arnd@arndb.de>,
 "'arnd@arndb.de'" <arnd@arndb.de>, "'mchehab+samsung@kernel.org'"
 <mchehab+samsung@kernel.org>, "'linus.walleij@linaro.org'"
 <linus.walleij@linaro.org>, "'manivannan.sadhasivam@linaro.org'"
 <manivannan.sadhasivam@linaro.org>, "'jhugo@codeaurora.org'"
 <jhugo@codeaurora.org>, "Filary, Steven A" <steven.a.filary@intel.com>,
 "'jiri@nvidia.com'" <jiri@nvidia.com>, "'vadimp@mellanox.com'"
 <vadimp@mellanox.com>, "'amithash@fb.com'" <amithash@fb.com>,
 "'patrickw3@fb.com'" <patrickw3@fb.com>, "Chen, Luke"
 <luke_chen@aspeedtech.com>, "'billy_tsai@aspeedtech.com'"
 <billy_tsai@aspeedtech.com>, "'rgrs@protonmail.com'" <rgrs@protonmail.com>
Subject: Re: [PATCH 30 4/7] Add ABI documentation
In-Reply-To: <LV8PR11MB8463E4402495BACB9E3ACE588B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
References: <LV8PR11MB8463E4402495BACB9E3ACE588B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Date: Wed, 31 Jan 2024 08:58:50 -0700
Message-ID: <87mssl7av9.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Corona, Ernesto" <ernesto.corona@intel.com> writes:

> Added document that describe the ABI for JTAG class driver

A few comments

> diff --git a/Documentation/jtag/index.rst b/Documentation/jtag/index.rst
> new file mode 100644
> index 000000000000..8a2761d1c17e
> --- /dev/null
> +++ b/Documentation/jtag/index.rst

Please, let's not create another top-level directory for this; this
looks like information that belongs in the userspace-api book.

> @@ -0,0 +1,18 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================
> +Joint Test Action Group (JTAG)
> +==============================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   jtag-summary
> +   jtagdev
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`
> diff --git a/Documentation/jtag/jtag-summary.rst b/Documentation/jtag/jtag-summary.rst
> new file mode 100644
> index 000000000000..07cfa7a761d7
> --- /dev/null
> +++ b/Documentation/jtag/jtag-summary.rst
> @@ -0,0 +1,49 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================
> +Linux kernel JTAG support
> +====================================
> +
> +Introduction to JTAG
> +====================
> +
> +JTAG is an industry standard for verifying hardware. JTAG provides access to
> +many logic signals of a complex integrated circuit, including the device pins.
> +
> +A JTAG interface is a special interface added to a chip.
> +Depending on the version of JTAG, two, four, or five pins are added.
> +
> +The connector pins are:
> + * TDI (Test Data In)
> + * TDO (Test Data Out)
> + * TCK (Test Clock)
> + * TMS (Test Mode Select)
> + * TRST (Test Reset) optional
> +
> +JTAG interface is designed to have two parts - basic core driver and
> +hardware specific driver. The basic driver introduces a general interface
> +which is not dependent of specific hardware. It provides communication
> +between user space and hardware specific driver.
> +Each JTAG device is represented as a char device from (jtag0, jtag1, ...).
> +Access to a JTAG device is performed through IOCTL calls.
> +
> +Call flow example:
> +::

You can express this more readably as just

  Call flow example::



> +
> +	User: open  -> /dev/jatgX -> JTAG core driver -> JTAG hardware specific driver
> +	User: ioctl -> /dev/jtagX -> JTAG core driver -> JTAG hardware specific driver
> +	User: close -> /dev/jatgX -> JTAG core driver -> JTAG hardware specific driver
> +
> +
> +THANKS TO
> +---------
> +Contributors to Linux-JTAG discussions include (in alphabetical order,
> +by last name):
> +
> +- Omar Castro
> +- Ernesto Corona
> +- Steven Filary
> +- Vadim Pasternak
> +- Jiri Pirko
> +- Oleksandr Shamray
> +- Billy Tsai
> \ No newline at end of file

Files should end in a newline

[...]

> +===============  =========  =======  =====================================================
> +Bit Field        Bit begin  Bit end  Description
> +===============  =========  =======  =====================================================
> +rsvd             25         31       Reserved, not used
> +pad data         24         24       Value used for pre and post padding. Either 1 or 0.
> +post pad count   12         23       Number of padding bits to be executed after transfer.
> +pre pad count    0          11       Number of padding bit to be executed before transfer.
> +===============  =========  =======  =====================================================

You should be able to wrap the final column of the table, avoiding these
long lines.

Thanks,

jon

