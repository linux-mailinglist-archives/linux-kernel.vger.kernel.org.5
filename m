Return-Path: <linux-kernel+bounces-133970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF5389AB9C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D01F1F21BA2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FCD39FE5;
	Sat,  6 Apr 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEQ5BuWm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE19381A4;
	Sat,  6 Apr 2024 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712416789; cv=none; b=EW9HXyT2FFKhhJQA2yY6vh/pyvMTvOPt0RmYBCPn0lRWXB7E3hwxilY+s3j/dZVRqGHJeUaXinlYLmdMA78PuE63I3I/cmVEiexOU+MHrUH29SHPwqbwFLs/MAj7E/6GA8/ckSriof5OXBHjrvRI9GSTBvRl0ZRTOMw09lMcaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712416789; c=relaxed/simple;
	bh=F0yD2te0Q85dmAD07i6O7OobeJIw3035Mh6eXZKnERY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPZOdXkiS9mpeVl8geYkDrNUJG+9KzJtUUOOVZ0CQ2/vAlpYjuK6UkkvSf+1FfEgCcSnZluGdu1YGC3TrmK8GW/vFiymXd7KMWRaYFo9QbVBe6b/xYErKD1oPxjA+2zFIUUEe+JDJnayZI6Uh5C9bdFSh6gIwTA//R6mhx/ujAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEQ5BuWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E45C433C7;
	Sat,  6 Apr 2024 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712416788;
	bh=F0yD2te0Q85dmAD07i6O7OobeJIw3035Mh6eXZKnERY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mEQ5BuWmG8QsLe9rfJTRZ8DTfgoFzmPBoWN905oUQ+1V6iOLJbX9u+jG0Nw9PAK4x
	 De7bd6r8v/z8XFHt6e+5+mYLOq4RKQNNEH9aZ56rvoKTViutm5rXUmVjCB7N4gwHKb
	 JyGoPYl5Rg4BMNOhux4bliCmxeJLBbPNMvdLfVvri4ujp9uQepgSoD/CJKsQRTGV/e
	 YBCn9XqIXgBF9/qwfdb0Y3x9nIwacbMpFlNos3YBYtDEj9hMD+0/SeUsVFRQncv/Cy
	 CrJktO5MDDaBf3zzD5DjmuCqL0W9OiK/8Rfx9S26SX2/b1rksFLh9ufdSK0cPOfjUZ
	 RXdPVCz1Aaxlg==
Date: Sat, 6 Apr 2024 16:19:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v7 0/8]  iio: accel: adxl345: Add spi-3wire feature
Message-ID: <20240406161933.56da10a0@jic23-huawei>
In-Reply-To: <20240401194906.56810-1-l.rubusch@gmail.com>
References: <20240401194906.56810-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Apr 2024 19:48:58 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Pass a function setup() as pointer from SPI/I2C specific modules to the
> core module. Implement setup() to pass the spi-3wire bus option, if
> declared in the device-tree.
> 
> In the core module then update data_format register configuration bits
> instead of overwriting it. The changes allow to remove a data_range field.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Series applied to the togreg branch of iio.git and pushed out initially
as testing to let 0-day work it's magic (find build issues for us!)

I'll push it out for linux-next to pick up sometime in next week (ish)

Jonathan

> ---
> V1 -> V2: Split into spi-3wire and refactoring
> V2 -> V3: Split further, focus on needed changesets
> V3 -> V4: Drop "Remove single info instances";
>           split "Group bus configuration" into separat
>           comment patch; reorder patch set
> V4 -> V5: Refrase comments; Align comments to 75; rebuild FORMAT_MASK by
>           available flags; fix indention
> V5 -> V6: Remove FORMAT_MASK by a local variable on call site;
>           Refrase comments;
>           Remove unneeded include
> V6 -> V7: Restructure optional passing the setup() to core's probe()
>           Guarantee that initially a regmap_write() was called to init
>           all bits to a defined state
>           - When a setup() e.g. for 3wire is passed, then call
>             regmap_write() inside the setup(). In the following
>             core's probe() has to call regmap_update()
>           - When NULL is passed, then call regmap_write() in core's
>             probe()
>           - Refactoring: remove obvious comments and simplify code
> 
> Lothar Rubusch (8):
>   iio: accel: adxl345: Make data_range obsolete
>   iio: accel: adxl345: Group bus configuration
>   iio: accel: adxl345: Move defines to header
>   dt-bindings: iio: accel: adxl345: Add spi-3wire
>   iio: accel: adxl345: Pass function pointer to core
>   iio: accel: adxl345: Reorder probe initialization
>   iio: accel: adxl345: Add comment to probe
>   iio: accel: adxl345: Add spi-3wire option
> 
>  .../bindings/iio/accel/adi,adxl345.yaml       |  2 +
>  drivers/iio/accel/adxl345.h                   | 36 +++++++-
>  drivers/iio/accel/adxl345_core.c              | 92 ++++++++++---------
>  drivers/iio/accel/adxl345_i2c.c               |  2 +-
>  drivers/iio/accel/adxl345_spi.c               | 10 +-
>  5 files changed, 94 insertions(+), 48 deletions(-)
> 


