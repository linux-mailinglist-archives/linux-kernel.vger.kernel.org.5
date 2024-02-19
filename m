Return-Path: <linux-kernel+bounces-71875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D8685AC1C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184B4282120
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A695102F;
	Mon, 19 Feb 2024 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0zK2vNX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E270650A6D;
	Mon, 19 Feb 2024 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371330; cv=none; b=RJ2Z9qzTvmCjPcaUyKMbdxx477WZGHorG6m+j8laq8Id82YyhkFUzWA3NrsXx4r3LphTNNdHEwF1QGjFKACdHCaPQu96wTa58InDvhIRi/fJVG+/uQRCTy2atFzRq9+OCLpBXGXr5eiun1EvjQdhA0WG4AJ1QY6guIETUtCdI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371330; c=relaxed/simple;
	bh=MtHBN20Imk6FyQFVnXsyakVvR6vcvLdw4T3spvloVPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1cfGAB/gkYg70tFuEcwPosoilmT0DAV0G/V4ZwDkxV14SetqwPKwlW3OJJLFnPmjUgP/HoWAJ8o6e9JYFYW1096U9b0NgNbNOzv7i9tRa0tUy6pldr9KsvwphUHaAyN3ztp0m43kIk8YAwdKVRJ2h/jiomnBIbkb1KIu5oALYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0zK2vNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EF1C43390;
	Mon, 19 Feb 2024 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371329;
	bh=MtHBN20Imk6FyQFVnXsyakVvR6vcvLdw4T3spvloVPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y0zK2vNXyC6JWeO5a3LlTiYGO0k+Su4tGV/xFCDF9CAPAO3PgahUr0OgjJdKYrLZf
	 gnoPuI90yww8I6Fl+xKmJHyLBrZnFnaNgpSoyL6sLQiaCxbAlgQT2K6RUiEF3u7peR
	 /5/44MSQJPL57KsDHksBRQ7JziVRPesJQm99HsJxRGKcmNfjrlVm07tXCIC4lxbv70
	 N0SDdaByDCk8ZO+duEiMx/TCSFbzkzUvo5HLNZCfBx+Lk3+NhCI4QE7rOm2h+7Tf4Y
	 sCrkRd3qCCs226hDlVxFOhOqaFBj8t67zC1eWNL8VvYPYZQ4XJPYtJ7WNEv8qZS+99
	 vv16OXYPnfCdQ==
Date: Mon, 19 Feb 2024 19:35:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones
 <lee@kernel.org>, Liam Beguin <liambeguin@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>, Marcus
 Folkesson <marcus.folkesson@gmail.com>, Marius Cristea
 <marius.cristea@microchip.com>, Mark Brown <broonie@kernel.org>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Okan Sahin <okan.sahin@analog.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <20240219193512.2ff8455c@jic23-huawei>
In-Reply-To: <ZdNJTTy3j90mL8CJ@smile.fi.intel.com>
References: <20240219065026.578517-1-mike.looijmans@topic.nl>
	<1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.ec4cd694-3b45-4b64-9a96-fc1ccc42fc68@emailsignatures365.codetwo.com>
	<20240219065026.578517-2-mike.looijmans@topic.nl>
	<ZdNJTTy3j90mL8CJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 14:27:57 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Feb 19, 2024 at 07:50:26AM +0100, Mike Looijmans wrote:
> > Skeleton driver for the TI ADS1298 medical ADC. This device is
> > typically used for ECG and similar measurements. Supports data
> > acquisition at configurable scale and sampling frequency.  
> 
> This version seems good enough,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

I fixed up the PTR_ERR() thing directly on the tree and added Andy's
RB whilst there.

