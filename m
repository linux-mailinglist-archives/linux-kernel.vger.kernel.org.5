Return-Path: <linux-kernel+bounces-112681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5288F887CE8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847171C20AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A54E17C70;
	Sun, 24 Mar 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLWBkroE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A701A38DA;
	Sun, 24 Mar 2024 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711287596; cv=none; b=kq9FyO9Tb1xo/ZiOZng2kEqwJMX/IOuP+RvzXajope9m3CKRd3OsgNy3ZtlAzHXDBfrOIJ4V6WGI5ZEYHTLsoBjXS4nXFRZ1XOgmgtyUJqXCrgi21yW+IZ82FPjEgEEusLB7vF0pkNs5HNfOD+cEQdWuD9QSXbRUOzg634bFef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711287596; c=relaxed/simple;
	bh=YKFMBj2kiq7RfXQL4DsoVd4QBUTciDzc2eqHAYf/zTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwOsMzdzI3KV3sYiYckm/RQS+H/OXi+5/7gdlAaiLTKzKBu3hCMayZbiOZTrQM2WBDs7zBZPfSwcpaEtmiAwNv1RoQkVIrULhFB1HlpDnan9Ok9vh+6xuqUB8kBI2uTLSpC2BbyR5ROvQZDz+UGPgF70KDb42ThSlB0/D1SCGrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLWBkroE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59737C433C7;
	Sun, 24 Mar 2024 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711287595;
	bh=YKFMBj2kiq7RfXQL4DsoVd4QBUTciDzc2eqHAYf/zTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FLWBkroEr5q7ie8g4JwhZgqGyM2SuqtY5pdEgO3ZRrwL+UjO22QAsXtL+1DYBU6rd
	 XAV8Wo2Ut7j4Tf3DaZYaGMkmdjtfXQAltOoN8fQFSqp6jR0BKAnCKqbxbQUxNgYlP1
	 /nu/1rMNq93308Gi9BHZQxzOkmxjrjGtDP+skx8U31as5c1AEsHMGrOW4SJMlRearL
	 r3e7iicuodnKc7L2XwtcgdF1EEzwDBwW0p49615zolZ+KTxuNLOwgCTJ2K+YKZcp4j
	 akRx3DXfoluWFJ60Brj56ilGUyWTzwfvdzchWOFD+T3KAKdeMbE0e9fTnwzi8FqgSg
	 jZcgViXP7JhLQ==
Date: Sun, 24 Mar 2024 13:39:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v3 0/6] iio: accel: adxl345: Add spi-3wire feature
Message-ID: <20240324133941.26814432@jic23-huawei>
In-Reply-To: <20240323122030.21800-1-l.rubusch@gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Mar 2024 12:20:24 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Pass a function setup() as pointer from SPI/I2C specific modules
> to the core module. Implement setup() to pass the spi-3wire bus
> option, if declared in the device-tree.
> 
> In the core module, then update data_format register
> configuration bits instead of overwriting it. The changes allow
> to remove a data_range field, remove I2C and SPI redundant info
> instances and replace them by a common info array instance.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
That patch break up seems reasonable (one minor request for a split
in the relevant patch), but normal convention would be do do
refactoring first, then functionality at the end. Also removal stuff
and group, before adding things. 

So roughly speaking reorder as

>   iio: accel: adxl345: Make data_format obsolete
>   iio: accel: adxl345: Remove single info instances
>   iio: accel: adxl345: Group bus configuration
>   dt-bindings: iio: accel: adxl345: Add spi-3wire
>   iio: accel: adxl345: Pass function pointer to core
>   iio: accel: adxl345: Add the spi-3wire

Thanks,

Jonathan



> ---
> V1 -> V2: split into spi-3wire and refactoring
> V2 -> V3: split further, focus on needed changesets
> 
> Lothar Rubusch (6):
>   iio: accel: adxl345: Pass function pointer to core
>   iio: accel: adxl345: Make data_format obsolete
>   iio: accel: adxl345: Add the spi-3wire
>   iio: accel: adxl345: Remove single info instances
>   iio: accel: adxl345: Group bus configuration
>   dt-bindings: iio: accel: adxl345: Add spi-3wire
> 
>  .../bindings/iio/accel/adi,adxl345.yaml       |  2 +
>  drivers/iio/accel/adxl345.h                   | 13 ++++-
>  drivers/iio/accel/adxl345_core.c              | 48 +++++++++++++++----
>  drivers/iio/accel/adxl345_i2c.c               | 22 +++------
>  drivers/iio/accel/adxl345_spi.c               | 32 ++++++-------
>  5 files changed, 75 insertions(+), 42 deletions(-)
> 


